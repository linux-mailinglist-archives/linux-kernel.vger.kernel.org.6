Return-Path: <linux-kernel+bounces-435804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7945A9E7CBE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 00:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A11C282809
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02986213E85;
	Fri,  6 Dec 2024 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mkia7qtb"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D49521507A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 23:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733528335; cv=none; b=CQsSYnSRQU0JqCx9YvxhVDeTU55PBxWEfCEMYj3YUzv+6AvWC1d5jBqZr2JPZInMFQeWAXyN+hmhPmr5YFG56Ks4ycV3ctARIIERGK+gdu1SJzHrdDsb4T1nARk1iRIBl/HTLreLeDOhzOv4MZxF3tEGW2vT+8ZoKAdlmKn27nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733528335; c=relaxed/simple;
	bh=Ulzg2xjkFRD+wiTK/aYzwa6zKISjF0fC6sX0+p179fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRAOiBJPn0HtcFzJTQkidu9LoFah3jV+HpwWq8q5RhOHNyuCwGUPQfQJwCvkldBjZNJKuSwTpy0XMJWRRWVowuqTIAWxE6O8YrX5P3wfxFdh1wURPPhC5np2x6Azu0pLv/+3THQmdy0Zpd4eLMHkP5LxTayRjYs5iWtS3GbmYVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Mkia7qtb; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so1912563a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 15:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733528333; x=1734133133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7ywRolWY01/rWUFSkYNRJ4dfXAYAQRxZrdC+AkeGz8=;
        b=Mkia7qtbbAYsJnWuRQW3YE7McQb5m37n4t+1A0y9k6j1GcdGk2K+cpWVtq6F9Z9m1P
         e32wjOAB9QVFD2Lt4JEkXx/FmU5b3wgXRbogGWFzVB8tx6/Cay+2K8LVWTKMpcclUQ4M
         WR+Yx1v+a3Z0luCJtO7Vk7UW6DW7t/m/iYOUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733528333; x=1734133133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7ywRolWY01/rWUFSkYNRJ4dfXAYAQRxZrdC+AkeGz8=;
        b=FTw/2iq7kkzGCEVIe7yubLZ2zYp8GIP/3ieMgJKlb2wTZigNwB8oGvoYQZ6kmayDWb
         EkXfRMpVRJoSHBw2CJoCXoDWe8rBDdj3zqFaU9eoiTq7AaGMZzfzyGR9Wsr3Lopb9E3E
         JAZL3nuwrBiTqf+MRSh76JwZqvfNQI0tLaapeWxQAs0yhbU5QPWuB/qij9AeVyTNpvpK
         OCyDCJPHOSJMCGJKyDXVqRg3sCQT4UluCYbMOyA4VI2Rp20R1KBJWTPTNcP5so95kBJu
         iWymEBY0Zq3Wi7GMVqudahqCpmk9RsKLw0CCpVsekLyXaT8J9hGksh7KQeFIxW7/g8N/
         OW7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhY3IwQloAmlmvTMlvEukMefe7HmJhtlh1ZiE8zBBPwohGLOO47Y160w0LBeTt90Q/g5YeNKxlGQ4XwUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhJlcY7OPRBNTi8OLROUCfIPFdCO7X5cU4jC8DIZ1XqzeEm8FE
	oZ/Y9puvzIDX5Zt8xGw4AEdmF1p/2eC5Ff430l/laWtEAkLUjn2tW61+bR16Bw==
X-Gm-Gg: ASbGncu31thBLW5ufIhRj25XCzMkjvRQwdjdiDEf+PEHFRhmLk2I9LjPivxxdFUeXVe
	IfRzdMeGwIuVSjCdPvTZXbqJd+GapGr8/N5TLTq8yg67+VuvIIk5PN+MoLxfBIZskTKxFfYfNJ+
	TNTs8D8YZEsLnwn4CpiVmaCwnlbap0rmzVOmPwQJhHccClQOQIUtGrz0TeBO8rdJPt/62pjxELv
	wymmDY0IeI6QLKaSqFaJ1Wv2DoQn215aHIHa9hB88VIgn4/G0Th5iQSoQU6ZxAdJyQyyKQviPFQ
	G30mSG8L1JES0cMhBnu3iMDt
X-Google-Smtp-Source: AGHT+IE2pYezOEFHi20tWshTX8jQdgxLAviowJebOf0BsxXK7byF4aVYK7F4ypRAUugG9hj/xkBzoA==
X-Received: by 2002:a17:90a:d445:b0:2eb:140d:f6df with SMTP id 98e67ed59e1d1-2ef693676demr7738327a91.1.1733528332939;
        Fri, 06 Dec 2024 15:38:52 -0800 (PST)
Received: from localhost (227.180.227.35.bc.googleusercontent.com. [35.227.180.227])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ef4600ead7sm3702702a91.53.2024.12.06.15.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 15:38:52 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: akuchynski@google.com,
	pmalani@chromium.org,
	jthies@google.com,
	dmitry.baryshkov@linaro.org,
	badhri@google.com,
	rdbabiera@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/7] platform/chrome: cros_ec_typec: Disable tbt on port
Date: Fri,  6 Dec 2024 15:38:18 -0800
Message-ID: <20241206153813.v4.7.Ic14738918e3d026fa2d85e95fb68f8e07a0828d0@changeid>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241206233830.2401638-1-abhishekpandit@chromium.org>
References: <20241206233830.2401638-1-abhishekpandit@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Altmodes with cros_ec are either automatically entered by the EC or
entered by the AP if TBT or USB4 are supported on the system. Due to the
security risk of PCIe tunneling, TBT modes should not be auto entered by
the kernel at this time and will require user intervention.

With this change, a userspace program will need to explicitly activate
the thunderbolt mode on the port and partner in order to enter the mode
and the thunderbolt driver will not automatically enter when a partner
is connected.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

(no changes since v3)

Changes in v3:
- Set port.inactive = true instead of auto-enter.

Changes in v2:
- Only disable auto-enter for Thunderbolt
- Update commit message to clearly indicate the need for userspace
  intervention to enter TBT mode

 drivers/platform/chrome/cros_ec_typec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 0b87be52e1db..743cb5a9fe51 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -311,6 +311,7 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
 		memset(&desc, 0, sizeof(desc));
 		desc.svid = USB_TYPEC_TBT_SID;
 		desc.mode = TBT_MODE;
+		desc.inactive = true;
 		amode = cros_typec_register_thunderbolt(port, &desc);
 		if (IS_ERR(amode))
 			return PTR_ERR(amode);
-- 
2.47.0.338.g60cca15819-goog


