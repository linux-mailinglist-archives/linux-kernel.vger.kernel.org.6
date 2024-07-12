Return-Path: <linux-kernel+bounces-250741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A68D92FC24
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CCE61C226BD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8B017167D;
	Fri, 12 Jul 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nso1M+2Y"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3977616FF48
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793155; cv=none; b=TV/hHJ2DQabw5AULYr+mglEYv1lUVZBE68wW1NOX0A/f1Mu+1XWSXiZUSPwVqh8QmPlIpFdW7xq6MfMBRyT0Oe87gWkwUnYuGcMN0fBmC8bxioBOnLEG1BKBRI0QnqHgnTUaA+FA+5p21jtd2ZYNkscKsFTMPk5yjarV3sY/qxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793155; c=relaxed/simple;
	bh=LngRdNiu2YEjbbuZsYN9VKeMbFVX5bvzSoOqXzErxvI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sFvzS5jbuQI+u6iClvybavkXcXx5ZEpNhoZpO5EEVVoBt81BvcrfUi/5JRbzzT+0ymHb6hq8htWUwfa5M3kdxa6ZQJJjrNVZIV+mLEzc+x8vq5tg7HEdYIOY5EdRl0ZjuqWVqksm3va161ygPpiRZSiEzhPU1/Knw4yKkbiXms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nso1M+2Y; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-70364e06dc6so1039870a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720793153; x=1721397953; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EOXtwv/Ldbm32946n4+7+2Znba7a0UrRT/2hMaZfivM=;
        b=Nso1M+2Y/p9pxsEGT8QQ64hCisfAh8Qnbsuaoccqs2FCh7ONggvXe98SspRn7fUc9M
         8iit3E8pp9R5wYscPwIMPdg6HCZby4GeWLtgO0fEr62kwK53RnjnEFS6xj8vuyE9pUw/
         pJvyNRC+xrVBMX4Yc66SAd0RDKa3DIEj++1iC6ee39qdt6UtWm4s7lsb/Ek8oxkyE5iv
         PBIeKOjbyGjOK6rGhvwKd2ACsJTpXYheytO5dGdnw0HB7oGLc1m+oqmn8481vHSe11g4
         ZnB40Ujj2oG7DIRkzD0NFhL4GuA6fT2HL0KXyEMzZ8NdOWiertKr39ccU/DIbwI+6jQ8
         uSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720793153; x=1721397953;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOXtwv/Ldbm32946n4+7+2Znba7a0UrRT/2hMaZfivM=;
        b=ixX9X6LRXAuruu4iSbXnoPWmmXoM1HfODrW0MpaskvJiPqsZcqJnM4LbPDievdpowq
         /BjBn5eHDNoHGww+DEzSKD8CanNWKfCpwjYyHw7qxHoX3cieAVD6GqQWJCp21cKA7fwu
         yJC1O+3MeDe3XMq9L452iXsOxvvOECjuPrzK8oQ/6VZoKiZv5JoTYZtngKzYqz4aeQ6a
         yYy9lE3uQB4HknuJ9CM3mFImF5D9D1Lr/WC6e2tp3C97/X0c6m+UtsAsUeX5UooXq+tQ
         48WUI4L4TxCJSqY30T0aRz49VlgC4mpskOTNt+9cecwybJHHUaIqBbhCiWxLNZLerV07
         knLg==
X-Forwarded-Encrypted: i=1; AJvYcCXo87TxlhA9cvZzMaVnEP8+mboDM/oUxaKTbXqk/f2AiXrdIfkGGpcuTd68XC7AaLZ84OhoL1btUPWDLNhpZ12E9ehUL07p6RAEHfCl
X-Gm-Message-State: AOJu0Yw+0fK5VPIkmLOgrA5WeJUHkm/NKXdVBjvj2FsaOopNoR2j7Yk/
	G7mi12zXLEinuyBGKocK57pP7zPsLLfpYE4r6cnx334d7sB/3r/SpEQ+mwXQxWQ=
X-Google-Smtp-Source: AGHT+IGb9Kef190iCPaOpWx5MShkZU/cz6tUILd4tavbxOpBAvfY5CSmNUca5k0xQNYE01N1vFJMog==
X-Received: by 2002:a9d:7ad4:0:b0:704:480c:963f with SMTP id 46e09a7af769-704480c9a3cmr9573417a34.35.1720793153396;
        Fri, 12 Jul 2024 07:05:53 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:d26:9826:56eb:a2e5])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c7b606db30sm715711eaf.8.2024.07.12.07.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:05:53 -0700 (PDT)
Date: Fri, 12 Jul 2024 09:05:50 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	RD Babiera <rdbabiera@google.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] usb: typec: tcpci: Fix error code in
 tcpci_check_std_output_cap()
Message-ID: <b0880888-6719-4614-91fc-8ee63b71d304@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The tcpci_check_std_output_cap() function is supposed to return negative
error codes but it's declared as type bool so the error handling doesn't
work.  Declare it as an int instead.

Fixes: 62ce9ef14797 ("usb: typec: tcpci: add support to set connector orientation")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/usb/typec/tcpm/tcpci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 8a18d561b063..b5e49af48f43 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -67,7 +67,7 @@ static int tcpci_write16(struct tcpci *tcpci, unsigned int reg, u16 val)
 	return regmap_raw_write(tcpci->regmap, reg, &val, sizeof(u16));
 }
 
-static bool tcpci_check_std_output_cap(struct regmap *regmap, u8 mask)
+static int tcpci_check_std_output_cap(struct regmap *regmap, u8 mask)
 {
 	unsigned int reg;
 	int ret;
-- 
2.43.0


