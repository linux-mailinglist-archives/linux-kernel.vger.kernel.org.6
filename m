Return-Path: <linux-kernel+bounces-212037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C152905A56
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303252846FC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED3D1822F9;
	Wed, 12 Jun 2024 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2jJIbQOd"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9882B391
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718215563; cv=none; b=TETndGb1jn4rH60Yrn8TV4t7mg+T1PMk3Sd6vEjLoQBDXGn9+LRGS08hhuqYKKveWITiep4K02Ciq9XukRq1aptUbIylu78KJETo8fMSdMPc6YgExZlbY9ezVs77LPAscPiUJlC43cNE9Tix/p10r5MUNxAXxg8kOFA0fZjrz6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718215563; c=relaxed/simple;
	bh=Gd82Zk9HO0FaelXqjYb+95hIZHZ1fOFMGTGfcVbJ/Uo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OpNyN20KUkdIrvASUqNyxxMImKUhp0qJMCENIWl9aGH6+QXVKcoALLqLwcwNNi5l7ksT8QXIWYxdJjSy2zPydyEt9Q4adxGCvaQRzlYZKt7Vn+SENy1PvzkQ3+b0l8uM4QaE+1HdWY3TnG4WOE4Lb611u540DpxLZBMlvzhO53I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2jJIbQOd; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfa73db88dcso231505276.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718215560; x=1718820360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DK2lnuC9xeLQB13VAfnEGsxTqF4Q5It1ZYUuF9NnW6w=;
        b=2jJIbQOdVZu4gvWzSQG/Ui3G5YTzOi2GgXJXSTArpPXgoKTcQGl0RXex7RxR5lBZJY
         qu7IOlPunyFEpKiwHF2XKT88qZQg/z7TW7ABb9t8T/wGvAdGtXHdu4/HcRTAQ9bfWxDl
         pJdNNrVNdN4AZ6ndwkt5iI298qNkZWWLq3O5ji4dmcwqexwSnjw9N/xl2C167R2Ywp9+
         n9VAG3BjosAJ1ZyyqYhWBfTIn90Babl6szqTLOzG7M0VPggE6z0LjZqqXlTqXHgblXJ1
         5kEMUopDx2b0cScKcKIO3pRWl9VZV67Lcw4tPVP/Em8zYpXqbD9YLosVLptOjKWU2lVS
         I6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718215560; x=1718820360;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DK2lnuC9xeLQB13VAfnEGsxTqF4Q5It1ZYUuF9NnW6w=;
        b=WvoEt/XKdlO0Vxnvb7NmFl9BsDK0eOC1wgWFiwweLxmlBm5faxFtbIGzU0sSlk4VPr
         jy5bFqG/sEJ8e3z2Mj47mK4xtCKgaYCeuaRlju3cKI6veEd6xQhTFrhzO3nGctQXM9R6
         eHbDKdGN5XZtlhXmuzfPUJkb2MniL5A9AiU2bp55A9sjGIeRl38Cq7gvvzkYtUTRBgLI
         mgwBXq+yNG+20JJsoBVE6soxBLVIevwrU5eQsygSzjFT69ZaqZCvnCq54J9fKIhm5unx
         HB1/aOzja6CievyRjnxMD5KxT0hHYR7tkjsLeHv1Ffjmyt4e3Flura3XkdHpiBUEhjKw
         4H2w==
X-Forwarded-Encrypted: i=1; AJvYcCU6L10mziw2KaUm699OHYsT5Ln92smJVDMiUN+crMHTI7DQazpDtFRs036OSt2XHESagdr2XX4JmlhvU3Ot4EsoAxB1VK3xgLz9dviO
X-Gm-Message-State: AOJu0Yy/EOSAzBuKgPC9/lH1xYDic+bpdaDFW9JitgjK8KvwyGnN7Ll9
	a7t80wA1SRd5SpjW5Cxo/bDs4Z19ESEimvUgbaIJwBOD4uDnonxfzNIxCdEna8McgG4JppTvjyb
	tYJ+tHTlvoQ==
X-Google-Smtp-Source: AGHT+IHf2XeMCGmx6fbqkkJUp1H+CkPxzQ7NkEfYAzK80CjQTOiAo90nx+YcVMfx8SJXrPOo4VzjcIJUz4RbCA==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:aba8:0:b0:de6:bf2:b026 with SMTP id
 3f1490d57ef6-dfe690fbcbfmr93737276.13.1718215560613; Wed, 12 Jun 2024
 11:06:00 -0700 (PDT)
Date: Wed, 12 Jun 2024 18:05:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240612180554.1328409-1-joychakr@google.com>
Subject: [PATCH] rtc: abx80x: Fix return value of nvmem callback on read
From: Joy Chakraborty <joychakr@google.com>
To: Sean Anderson <sean.anderson@seco.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joy Chakraborty <joychakr@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Read callbacks registered with nvmem core expect 0 to be returned on
success and a negative value to be returned on failure.

abx80x_nvmem_xfer() on read calls i2c_smbus_read_i2c_block_data() which
returns the number of bytes read on success as per its api description,
this return value is handled as an error and returned to nvmem even on
success.

Fix to handle all possible values that would be returned by
i2c_smbus_read_i2c_block_data().

Fixes: e90ff8ede777 ("rtc: abx80x: Add nvmem support")
Cc: stable@vger.kernel.org
Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/rtc/rtc-abx80x.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index fde2b8054c2e..0f5847d1ca2a 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -711,9 +711,16 @@ static int abx80x_nvmem_xfer(struct abx80x_priv *priv, unsigned int offset,
 		else
 			ret = i2c_smbus_read_i2c_block_data(priv->client, reg,
 							    len, val);
-		if (ret)
+		if (ret < 0)
 			return ret;
 
+		if (!write) {
+			if (ret)
+				len = ret;
+			else
+				return -EIO;
+		}
+
 		offset += len;
 		val += len;
 		bytes -= len;
-- 
2.45.2.505.gda0bf45e8d-goog


