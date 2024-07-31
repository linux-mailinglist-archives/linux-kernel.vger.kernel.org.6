Return-Path: <linux-kernel+bounces-269466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A20943317
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B2C1C2189E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B37F1BC06D;
	Wed, 31 Jul 2024 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xk2smTWr"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733FF1BC073
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722439266; cv=none; b=HHIKpxgikRDmOX0E6fsIoMc1h/cIM1hHCRwHi8DjIs68nhRN7qlsPdBm5oVIGMd5EoeQch3kbVtbDaFWIrqjDRdiR/RSnz5LfyQa9N1uX0rx3wmxorm7KPOEmzqgP5I3wBkS5Dd9fLyfodBiEy/IAorHAhw3mn/Mv8+Wd/4o9DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722439266; c=relaxed/simple;
	bh=mnsFfjsXyLCpcHqVRuLDx+XTYSAgSLLlD1CQjdlWwhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l10fN/8RpjEOFgWSo7dsL+p7YpcirpMjvgb1WIBbGRI/K49Actv203IQZ0+e2Q4Y2XtQj6s+gPeGhhSeFqFBwrA086aD2ssEOOjYWJIBt/8r6oYWnTquu5W1bP8fl74rTpz14N/4KvGzMi3r2dos2GZKcRm173HwsIcpmZT03sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xk2smTWr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so36528215e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722439263; x=1723044063; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPgFx6S9AzTv/56jUbfitvD1CUFmclbA7VamQiWR1as=;
        b=xk2smTWrgNVg9aojipP3TqIeLQj0GJwwm458mp/dGVmRiDCD/UzeXcs6k0+QWIKQ7A
         brNPI4EjxSQAyoCB3jhll5J8n2hNXqDYl47YOwimSaQTEeTMsSIH55ZbN8Dja2wmeYqC
         AfpoyUYPVXZLqMlGZOY1rX7laSwQMni5UmWfDUIm5SopDxdu1aCVQMM/vw3EnQM5CkEH
         AFmUEkD6R+L3tVGhBGMNl0juL75XCVmmPwRDJQ7jWkdhD0TFPORzf/2kUX2OT32462Vl
         y/3est4KEJYK1pE3arESLWF+bKU8014sFsDUCG0UOoAetykres9iNFXOu0V3PIuE4MFF
         V0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722439263; x=1723044063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPgFx6S9AzTv/56jUbfitvD1CUFmclbA7VamQiWR1as=;
        b=sNhDCDQg5WDt7XjE6lidIM+nUgy8qYxVj/PnYknZY9v1x9evbI63cnM3eJQaDrsAOw
         AQbfJOPbpkTRkfahJ5Ib+iUyEGGPEEVkjm9/FXOajvBiE18R2pR2Jp84lszx01fvSYWh
         //TpXSY+p9KZYLm3s2FClmSRTozjB2D3kbQeFDKQ7CV+6G6kxNoJGoEPfP/HKppTZoRG
         xbStgFDtuGL8lpLUSahMug8Wc2X8v9jY5KE1FbwcwZyQEYD8qssqcfiWApoTmA9FjxXX
         moDLB6qJ5ilY1qocyNaJZa2lqfDU3suW9iyAgs0UxHCX+lT894eujX9WP8IVeMrNcNez
         x4Tg==
X-Forwarded-Encrypted: i=1; AJvYcCX36ekwDrmPGDJuNJ1mzNr3ffcg0Ijm13dUIW1kRyI2KD25/OTiJjSVoOEVLYdR7UzCjcBeBRvv/4R5KbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBYTycw4SYrc4UXdN2MKDD1GyiX21I5+qqfvTCG+OE90Q4bMiO
	hEmOL7CB4XYPqZd7WbAQb84fqIojN5hUt/GzE2A5bSJGufpzEkFOzLPJWFptpa4=
X-Google-Smtp-Source: AGHT+IHClkBhl81RbhbhQwvb71V6F2Gv1oAzwjiUmbWV0cXrXma4jczdTf7X7a33LPe5bCg9giE3HA==
X-Received: by 2002:a05:600c:46c8:b0:427:d8f2:550 with SMTP id 5b1f17b1804b1-42811d9a644mr114725735e9.14.1722439262498;
        Wed, 31 Jul 2024 08:21:02 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:9c3f:3dd8:b524:cb31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8addd6sm24752925e9.20.2024.07.31.08.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 08:21:02 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 31 Jul 2024 17:20:49 +0200
Subject: [PATCH 2/3] Bluetooth: hci_qca: fix QCA6390 support on non-DT
 platforms
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-hci_qca_fixes-v1-2-59dad830b243@linaro.org>
References: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
In-Reply-To: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Wren Turkal <wt@penguintechs.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1545;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Ga1opdpymbhkU9R1JhuG60TILNDZdSmzqdrgmgVV3PI=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmqlZcBgQ6G7JKZlOYHDPZ6H9v/UOairIpBeC8C
 LZhczsp6YCJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZqpWXAAKCRARpy6gFHHX
 chMRD/9i9QXxsGdNawfMfGnpI37fW2Bx2vn/GP0x74mQ7mLMd9rVGpghAT6q8wJABaq/BreCtJm
 woeGTIGsKJOFPdWfCrCOAO/F6v+7UQisQt9RGhmXL0elSElvZ3HL+N1dPAo7KOtDuJEiqnirv9P
 6k7G68nqPIigIOFnIVCD/yAWISkFO6c/NroAiAbkX7eg/mJAUOATw3v4VzjpzTWSJxDL502F4gE
 M8hNuUxnTEBt77oXJ9QO2gEpCW1mEsnnSSiDQ8PiXGjcPBamc6Ny1yqCXLljW3ybOzeBdhFsdzX
 afObt8+b4GtCy0G5e6ntJnUhKdApNXkVy4FWiUQwSLE5ko0g5vqiuFlhlvNC28fyPxxR+qp4WhL
 q3SMhsC7F58hngvZrVhmaudsLBjwzuun6FZKCBOUi9Oo494dEzyYv/ogkMRc3oYtXXIiUAJ4vb1
 mIoH+pUmzJBWP/EUqNUzqAXAMCwEWvYTOnRQyfCbmczcGYxJJrR2lj8xZXGFpbOnRHhrn2jJhcZ
 t0nzkdD8a05VjCFCeNIBvdt9T2s5e38xLVq3RJGGl6P6hNjAYGn3N3Fk34fJh4x96ir8koBHtge
 8+J5pRv4uC0MhxHEcYbr+wPNMN+PwY8b1zE3PzRWPIdnHn0NQiwiruA/AqELTEkkDoiey43lOiH
 WPjjqlrdt242VwA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

QCA6390 can albo be used on non-DT systems so we must not make the power
sequencing the only option. Check if the serdev device consumes an OF
node. If so: honor the new contract as per the DT bindings. If not: fall
back to the previous behavior by falling through to the existing
default label.

Fixes: 9a15ce685706 ("Bluetooth: qca: use the power sequencer for QCA6390")
Reported-by: Wren Turkal <wt@penguintechs.org>
Closes: https://lore.kernel.org/linux-bluetooth/27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index a20dd5015346..2baed7d0f479 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2412,11 +2412,14 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		break;
 
 	case QCA_QCA6390:
-		qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
-							   "bluetooth");
-		if (IS_ERR(qcadev->bt_power->pwrseq))
-			return PTR_ERR(qcadev->bt_power->pwrseq);
-		break;
+		if (dev_of_node(&serdev->dev)) {
+			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
+								   "bluetooth");
+			if (IS_ERR(qcadev->bt_power->pwrseq))
+				return PTR_ERR(qcadev->bt_power->pwrseq);
+			break;
+		}
+		fallthrough;
 
 	default:
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",

-- 
2.43.0


