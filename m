Return-Path: <linux-kernel+bounces-226215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDC3913B9B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 16:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD89281BF3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 14:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDED8148849;
	Sun, 23 Jun 2024 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDuRgUo1"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A724533EC
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719151793; cv=none; b=qRT5urAWjTCbu94bwtmmwLSfrFFNHM7GzloLnKIJWLSJsxupxpzr9csQoD1ajFJdV5yGeuiL7pcbEFxbzqb6yf4UzombZetKY5EJUlQe4kK9kFYexooEI4NLqwfqoeAKGLw9TwZUZocPyyG+UojxL89b+x7w/FEwWm7vsko8ee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719151793; c=relaxed/simple;
	bh=hRYFdrXaupK+/KmNMOki3fiDptUSyDa5A3jwlmMpkHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sEQOFxNVc91vIavhBsLyiu8I+rxDwNSJ3TntY1B4WFpcrBDeIQbo/A+a2w4zi2ltprt+OyyPaGCuz9XFdub1SsToxFiyFm2pFicoQ0FjW/1p2YYAuHDWB0MhMh1poILQA/PVqNIISFSwLMiW6koQYLuEhky/uJfkG2ZbObsLGK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDuRgUo1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4248ff53f04so1567555e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 07:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719151790; x=1719756590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R4DhKqGk83JLyXn8TYXcFLRFfovAmUW6dHWsArSysGw=;
        b=eDuRgUo1j/Hl09rLiuc0p/y/izkiN6oMQtqagJR2lGxCFie6XqMh6xnW+zzaLWASbv
         FElLVMazvQS6olICPKKjFoorFkmP/jfEMfY8P20hmSKdUDOZbDZUzZ961CCFhVCX/nZJ
         pzgj7le9UD+75Giu7ECVM3lgepTuefU4Z0W46dGi6ErQYLwMFnxBqo9TMRwOtOAsq8mN
         pjTDq4mN1PCbKgO48Cua+qqbSALIbBjEbP8HTHfII6eCqC4uQvdUT0BT++iEY3g52x0q
         KJP1U/mBomV29rSXeXNTGD4/Dr5bggc54Dua2Vm8Gia06YM/FRUisAPp1lKgZB7dtajI
         lJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719151790; x=1719756590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R4DhKqGk83JLyXn8TYXcFLRFfovAmUW6dHWsArSysGw=;
        b=iYjXET6DqVWe2tX7NIaTlzFjB/5IwVy7BzqdX519JE9jUKDnrRIZCGeZophQe/0WRm
         wvNbQRxh6PL293NyhTWxXO12FVMd9L+QJHFNJN4gObeDukmLxGTeFTh2+J2gnbI5Q2iG
         3EIslNd7tV7hKOiyq/SgRkltm2v6zGkDck6iOTbI/j5/7/u48YHfej376SarccdPi76r
         +LZtAi2PCixAqJlD/zxEOkVctG4kxa7BIWIH/dXIadbpvNrnq5J/Q/JJjQlSCvw4Ythn
         euNbaPgS68H8lfjuva3y0JaYxxrR0cFI0L0pDWJE47Yd1ReR45rYqAED0osxlAkb28sm
         mUaw==
X-Forwarded-Encrypted: i=1; AJvYcCVCwglzQIOdbSJGFaCbONkqdYV2a6QvevgcWntaqEXXnX3dj/JolHwNvByV2J0WpQQNDIyVWfn0M7idPNDnZYoZnolKOdMfuUwe1t0B
X-Gm-Message-State: AOJu0YzcXhjZOopYFFj4mhzMsRITzbGOhS7EB1n2okcljA9g63NJ0mwX
	HcizaFT8FXCkdWS4EpzDuNpBO5GzYpT8jaB1EeiduwuK0yi+nFDg87zVOg==
X-Google-Smtp-Source: AGHT+IEy7Wvcf7Hxiuw7nBekBjdbuDrCPIaEU1/ZWko6ZvpdtJEOZ3R2ZX3lfqHKWKLltdoaj0Crpw==
X-Received: by 2002:a05:600c:6d8e:b0:422:6765:271c with SMTP id 5b1f17b1804b1-4248b98035dmr21178225e9.20.1719151789781;
        Sun, 23 Jun 2024 07:09:49 -0700 (PDT)
Received: from fedora.. (d-zg2-102.globalnet.hr. [213.149.37.102])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4247d208b3dsm143809755e9.34.2024.06.23.07.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 07:09:49 -0700 (PDT)
From: Robert Marko <robimarko@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Robert Marko <robimarko@gmail.com>
Subject: [PATCH] regulator: userspace-consumer: quiet device deferral
Date: Sun, 23 Jun 2024 16:09:35 +0200
Message-ID: <20240623140947.1252376-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trying to use userspace-consumer when the required supplies have not yet
been probed will throw an error message on deferral:
reg-userspace-consumer output-led-power: Failed to get supplies: -517

So, lets simply use dev_err_probe() instead of dev_err() to not print
errors in case when driver probe is being deferred.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/regulator/userspace-consumer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
index 86a626a4f610..6153d0295b6d 100644
--- a/drivers/regulator/userspace-consumer.c
+++ b/drivers/regulator/userspace-consumer.c
@@ -158,10 +158,8 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 
 	ret = devm_regulator_bulk_get_exclusive(&pdev->dev, drvdata->num_supplies,
 						drvdata->supplies);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to get supplies: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to get supplies\n");
 
 	platform_set_drvdata(pdev, drvdata);
 
-- 
2.45.2


