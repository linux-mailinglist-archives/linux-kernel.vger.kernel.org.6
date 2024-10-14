Return-Path: <linux-kernel+bounces-363583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D0199C441
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF3A285786
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EF3156880;
	Mon, 14 Oct 2024 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWZHK0MI"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA33D231CB2
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896216; cv=none; b=jsBpfQ+Xsf4wZY6p8E9X2scipzD7YG9WqduOhY8OoVYXyp+U04wO/g6iS1uKZt9zYaEEAsgDz3uXTC8OTQZo4PquTvZA2qaYTVYyrAGullcfVvKCLAZG8uMSgM9aqNkGRm/b2BrepjLuqMV+ByOWvP8SbDtubDFokoaJglCCamo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896216; c=relaxed/simple;
	bh=xGtdnRt3Vj5TJFE+xPUs3ODpILN2e8JGFrFZ5HwFyn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F18QRs9LyjH7ge3wSUoYIW20N3lA6nvOiZy7IQYdVUNyrI+s3SKowbfZNjqyr/Zpg81P0aUsnwEr398MieD5A+u/ritxhRsdptL8/t8weTlnZVkUe3m9e38hoIL8qoC7TuCSNizEziytykYsgfRbI2QmuSua6gQg9OyZpKzDlf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWZHK0MI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9404c0d50so3976227a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728896212; x=1729501012; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/JEhqoZl4E0cyUUh/uV9OIb6kXsx02RuLl2MX4iZIs=;
        b=ZWZHK0MIrZFXLTz3RapwJpbO2D1DpTPq4k4Fw4Co0SV3CyM0AjLJKcLuS8i7cYmMgf
         0ImJMuXfj/7PsHNJbBLVfUs8ziHl5H4cHnp4Ogb1q1OG3LAYCm4QV944RRrd/3qK6G8V
         YFqtXSG2Rs0fqDdiygCPXlORsMVs7M+MCYllOG8LIGD/7+HJWWYCksh9e0CgE5iahAvH
         Zd3S0mx0ZakhAWWLSeztbVLpQiK2fS7zBZQgjkdtWHaszHGEuZr4so8ojrf7nbzgR2ge
         ldqK/0Tc7+CXIsg2uK3Q+xaS2ily1yW706szIIOaMbXTJNTdpnodHF1iHw54CGFThyPL
         9YSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728896212; x=1729501012;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/JEhqoZl4E0cyUUh/uV9OIb6kXsx02RuLl2MX4iZIs=;
        b=ujJf6DFPHsEyxmzQ8CDpu2J10Czo48vJ/cdfBwmyvqGdhd48vf8sChgKsRS4n3kVY3
         ZdjsfHIx2O3yjjTK9gg5njWCfyi0Woous93bwvU4ZP0TuhO4nx8Wklh3J8YbBmLIvKGo
         DdLGDlb5z6wxt/Ht4JjzE88YbBHgaES50tqDJzqd1TmkH3TQ1tygUlXZGSgjnMCTZl/s
         lDUk2dnZ3CEhH6hP25UV2iDq6e9+8AFUdlusaA5rj3X+7yGHAPz6GmHJLPvKfV7h+BWN
         L3vsSAY0s17ZUGg0kyHUpehwCAeOn5zVgZ8HlVOnETzSuVtiV9X8Q6lRyaA5xTWv6syt
         QVMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+aZMjtWLBjwd4dqsI8UAkJORFEUQxB0lFt3Yvd9IJXXYPen68lQm2jktlMipCKhBLX1gh9jUiSdyw2f0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4vcuNUu6MxRZtd48y7vcS0mPDF7jerCpQQP2xtjJJnSUJRBps
	7m9F0V7TOmzBQ+cV9eYGspmqoRsC5dh+/15cZsnY+qf7CXauXX7s
X-Google-Smtp-Source: AGHT+IEFn6QtuxV2uIFTjjx/8oPht9aHKpTC7u9qcL44bqP67ILGm5a+ZBNPq+GHrpBB1J5epP0+nA==
X-Received: by 2002:a05:6402:34ca:b0:5c9:68f9:8af3 with SMTP id 4fb4d7f45d1cf-5c968f9a259mr4404776a12.17.1728896212102;
        Mon, 14 Oct 2024 01:56:52 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9370d2296sm4635091a12.15.2024.10.14.01.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:56:51 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 14 Oct 2024 10:56:36 +0200
Subject: [PATCH v2 1/2] staging: vchiq_arm: refactor goto instructions in
 vchiq_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-vchiq_arm-of_node_put-v2-1-cafe0a4c2666@gmail.com>
References: <20241014-vchiq_arm-of_node_put-v2-0-cafe0a4c2666@gmail.com>
In-Reply-To: <20241014-vchiq_arm-of_node_put-v2-0-cafe0a4c2666@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Stefan Wahren <wahrenst@gmx.net>, Umang Jain <umang.jain@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728896207; l=1704;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=xGtdnRt3Vj5TJFE+xPUs3ODpILN2e8JGFrFZ5HwFyn8=;
 b=qS4TvGWBJCdTNKcjEj/E2YkKBXpwxQCEeub3CsxnCOFRi2PGAsVjTmZNKf7cV1VqYhMDxnDHi
 aZvTdlM8d5+DTAOddmqFmYTCjnf7qZtGg7jjKKm1cJ57YkZ8DO55+/t
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The 'failed_platform_init' and 'error_exit' labels do not simplify the
code, there is a single jump to them in the code, and the actions taken
from then on can be easily carried out where the goto occurs.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c   | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 27ceaac8f6cc..81b2887d1ae0 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1361,8 +1361,10 @@ static int vchiq_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, mgmt);
 
 	ret = vchiq_platform_init(pdev, &mgmt->state);
-	if (ret)
-		goto failed_platform_init;
+	if (ret) {
+		dev_err(&pdev->dev, "arm: Could not initialize vchiq platform\n");
+		return ret;
+	}
 
 	vchiq_debugfs_init(&mgmt->state);
 
@@ -1376,18 +1378,13 @@ static int vchiq_probe(struct platform_device *pdev)
 	ret = vchiq_register_chrdev(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "arm: Failed to initialize vchiq cdev\n");
-		goto error_exit;
+		return ret;
 	}
 
 	bcm2835_audio = vchiq_device_register(&pdev->dev, "bcm2835-audio");
 	bcm2835_camera = vchiq_device_register(&pdev->dev, "bcm2835-camera");
 
 	return 0;
-
-failed_platform_init:
-	dev_err(&pdev->dev, "arm: Could not initialize vchiq platform\n");
-error_exit:
-	return ret;
 }
 
 static void vchiq_remove(struct platform_device *pdev)

-- 
2.43.0


