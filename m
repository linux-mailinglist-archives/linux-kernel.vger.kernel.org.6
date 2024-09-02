Return-Path: <linux-kernel+bounces-311171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 679799685A0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12C91B2880B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C7C17DFFC;
	Mon,  2 Sep 2024 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eFfiQkgY"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2211114A4E0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274694; cv=none; b=GQO3+biu91DAT59n0SaEdfRLVPrIOqXSBccfV71gtwPOUICqhkP6Xo0w7rQfyno88EKhkIcsAG82iBgMVsKRyqWm67j7VEtlAy0EvgUF2snKPg72O1xt7ccpBedjM4WroGiQuzamwjAOWlI/trDQHusC2fXBM3ezTuqos8zukTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274694; c=relaxed/simple;
	bh=nVURptpefAkaUi2gD1BgDnvEIMUGmkTN0KAW3iwmleo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nAOLBa1zWR/QOVFfIKZuOx8RMA88R48XzL1+JR7hBPZ3ElN4/IicrI5Ewac7KupHm9Zsb3xO6+c/KudzLtecCtR0wHflXNdcsb1/Mty6T9BO55943ySgICJrBpJNA1DJ6Ki80sHkxJL2PihfJhhrypbw9mr/2Zyw1VtbWR8nE4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eFfiQkgY; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52f01b8738dso2846449e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725274690; x=1725879490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6DvaNteBdUmwn8dGMcWnnT03kWdIbrrlcc6VtDNmM/M=;
        b=eFfiQkgYhxrvZOuB3onGXAdPGNbal9jXhqReQMVczBNw+MSp4IbbIK9iv6ZbNgskTx
         KscgzFm6lKGC00xEcr9jD8ysp7GZSLY09Lu0InOFc3y7puXedV6eR1SMpV393n7jLRQb
         WfZDAt55qsa1whScrs5xUaSe2Qeq838LiYEVZGYAT8IuDaOjX1fgwfduRZcZzs2uyTjD
         q6d7TPQbIJf7wY4W1HRTqPVgm3k1fsEiY7Tw2tT9LxH8/sAEfkfn7aP443qyy/PaaQnI
         KzTaXKdMm0zAnINSFWM2CimEIiJ2LXtTQ+7qoFWAi4MuoU7foyHJoNks9dawcJS+qvYu
         MqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274690; x=1725879490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DvaNteBdUmwn8dGMcWnnT03kWdIbrrlcc6VtDNmM/M=;
        b=K1ElivkMTdtfn8keBR2vHM1RW5ibzHseGrdmru40vmqPwxiunGYxd7BOHHDfFsnKIE
         rUyuW26XnaRIvScpLcFdDbsuX+4dIdFm1xVm2SH3+zqwzPpxRs0V6VfIGzV8jLW68/9J
         1dntgQuQrHSUQGvYqsovp1Y0kxN1RHCBypTgAJvUcN79eFc5lNwpABZbeWEcOR3KqN8i
         3YtvYuodtjOccUp3HeOb8tjchNgkVajjLhs90z1kYsDAYWpkzJdUyPzqi7IHYicE4EYp
         l0vIadmAPZ8VnPWFjECQSN2/WZwre4rsBlx56M7+PFyvk01DE5Zs1YAA6eAF+0zEctu0
         bx/A==
X-Gm-Message-State: AOJu0YxiaR/MZHPIzveGRkH8aouddvkaTS/3fdWHu9XnVWjfhSNx1GzO
	O/MexbYA03Ks2GpOvaQodmSc383sv4jpRtAOthx8QvsEMvlEw2nZNIk4h6BXmebYmEev/gtx92G
	kvYo=
X-Google-Smtp-Source: AGHT+IHK+9VjObj4U3R0f/vvjZ+U5Or1uvL+m6lHg5VuJD7FNeik04LGzM1+Hi6ENllE7tqtemUzmg==
X-Received: by 2002:a05:6512:e88:b0:530:ad8b:de0a with SMTP id 2adb3069b0e04-53546af3514mr6140872e87.9.1725274690407;
        Mon, 02 Sep 2024 03:58:10 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6d88sm545416166b.151.2024.09.02.03.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:58:09 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2] rpmb: fix error path in rpmb_dev_register()
Date: Mon,  2 Sep 2024 12:58:03 +0200
Message-Id: <20240902105803.2885544-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Until this patch was rpmb_dev_register() always freeing rdev in the
error path. However, past device_register() it must not do that since
the memory is now managed by the device even if it failed to register
properly. So fix this by doing a device_put() before returning the error
code.

Fixes the smatch warning:
        drivers/misc/rpmb-core.c:204 rpmb_dev_register()
        warn: freeing device managed memory (leak): 'rdev'

Fixes: 1e9046e3a154 ("rpmb: add Replay Protected Memory Block (RPMB) subsystem")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
Changes in v2:
- Remove the now unused err_id_remove label in rpmb_dev_register(),
  reported by the kernel test robot
---
 drivers/misc/rpmb-core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
index c8888267c222..bc68cde1a8bf 100644
--- a/drivers/misc/rpmb-core.c
+++ b/drivers/misc/rpmb-core.c
@@ -187,17 +187,15 @@ struct rpmb_dev *rpmb_dev_register(struct device *dev,
 	rdev->dev.parent = dev;
 
 	ret = device_register(&rdev->dev);
-	if (ret)
-		goto err_id_remove;
+	if (ret) {
+		put_device(&rdev->dev);
+		return ERR_PTR(ret);
+	}
 
 	dev_dbg(&rdev->dev, "registered device\n");
 
 	return rdev;
 
-err_id_remove:
-	mutex_lock(&rpmb_mutex);
-	ida_simple_remove(&rpmb_ida, rdev->id);
-	mutex_unlock(&rpmb_mutex);
 err_free_dev_id:
 	kfree(rdev->descr.dev_id);
 err_free_rdev:
-- 
2.34.1


