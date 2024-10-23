Return-Path: <linux-kernel+bounces-377638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2699AC1A4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81F928385C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4251D15A84E;
	Wed, 23 Oct 2024 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UCffsi8r"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2C61474A4
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672262; cv=none; b=DeSyHm0JWVEoiArmYdxuJHbWKUcAsCw6oXis0gnBwhAhE1STkz3Z6MBCGQO/ZMAcfqcIeZQNQHnRYMCXniuEU8Vpm0wNTG+uuBeV7FVGuLNeeDtQjkmF1RTVjktX09EyI4iZdY/ycvoACSu7oAcpve8pLrGfLCquEi+3n4SfykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672262; c=relaxed/simple;
	bh=OdA/Lx/g/+rhQ0Eyv42s39kdQJ47dqmOO55WQ9F/BNA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DOUDf+CRWQ0N0vmIyo9SUt05Sad5PhhSIVTp7YtGM17sIY5jyhXdx0VyghmNjfePrF50YUv2OxHsM6y2eluCUroa5GBt5gTm9o/VeCQsGPBszrD5kAg1vmSHkUo5/UTQkqr45hhCqeVMs/LBKuvyJ+ZuPpoJmjvylkMaMXRvpgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UCffsi8r; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so78422825e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 01:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729672259; x=1730277059; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJjPAsY+OlQh98BPt/llnxV3HvdF91YFt70SYWdsuBw=;
        b=UCffsi8ruJeTbOB+j7Ita1rNp5XIQYORV4U4xd1kLr3gJsfTp2Eky9MjmnpvE0aNb2
         pk7lzbpud6jko6DJyrxuvm79bc/f8UPsCOjbUcW98QmumfFLiAoPYnbgSKpiA609wFoP
         vFJ9IBwRXeCD++rhCJj07wxdjiqhr8QSkdNdBqzg+bg0Exr9p11qQgogbT2nqmrILBnm
         jbQbSNbwYXY6Z8HOt/dTgqMM1Uynpee82hM9QQZUTgYZsje4MY7qBArIACjyo8pcYA3t
         IrxK5fM3h6STIsF1hEwQgC9w2483mS7uqPmHyuf8M2hkhGft89NzqHxy8rEbPwznqRls
         CoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729672259; x=1730277059;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJjPAsY+OlQh98BPt/llnxV3HvdF91YFt70SYWdsuBw=;
        b=oxXTehMzDeOPJzmOgQ6529BQiOO4zFYUtX7PlTv4jt5kHMAcYZlSe5gyVmkFe5drPx
         SAS51IwgFTOwS/fbozzxGX4MImvz94DinA2lFeqKD8JcrMedFhbOpBslncUHNoHN37Cz
         1x443VyAJD7E80xE3FEtWDLxkFWXp8EvAexwkqeKPAofc0VAxB1GaqsbIedpeZfamVZC
         UFI7jITxLXKV1jkTilJv7pv64wS7pwhm4UBciM7i5RzaLmrghlLCvbn+UuQLFMiTIJgJ
         mwnqw7c0gAxsUcxvu0V+ezkkcAyWtr5Yoe6QQbzB6/kD63f+n/XvffRYeo5Re/xQCbNP
         cuwg==
X-Forwarded-Encrypted: i=1; AJvYcCWfKmXe857zqDdB6UGN9muGnUphByLcu8MrDhRe63ClHTgv6bj3KIPEFfmvfPlErH16mDtYSNh2OBp9e0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCv/lbL9IYtt1WtM/uAHM/bmNpBvL6a8ZoTy8gOxKiZvyQ5TKi
	3QwZvM8Iy0OgtWg/NiXTEiDtQlxCOmWm3rZBFwAb4g4Zct7DEukT84tFKqB8jqo=
X-Google-Smtp-Source: AGHT+IHPU6nYNwgDM+9I4opxX+G8CARI27qe3xwEGfD9/YcLKJqmhTD/E8EfYj2M4UlFJjONaqKbmA==
X-Received: by 2002:a5d:51c4:0:b0:37d:47e0:45fb with SMTP id ffacd0b85a97d-37efcf060f6mr1389418f8f.21.1729672259340;
        Wed, 23 Oct 2024 01:30:59 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a58cc2sm8381119f8f.54.2024.10.23.01.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 01:30:58 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:30:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Naushir Patuck <naush@raspberrypi.com>, linux-media@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] media: raspberrypi: Do some cleanup in probe()
Message-ID: <fff40b7a-20cd-4933-9534-1f72435bded8@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If devm_clk_get() fails then we need to free "cfe" before returning.

Fixes: 6edb685abb2a ("media: raspberrypi: Add support for RP1-CFE")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/media/platform/raspberrypi/rp1-cfe/cfe.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/raspberrypi/rp1-cfe/cfe.c b/drivers/media/platform/raspberrypi/rp1-cfe/cfe.c
index 045910de6c57..1da58b07c1d3 100644
--- a/drivers/media/platform/raspberrypi/rp1-cfe/cfe.c
+++ b/drivers/media/platform/raspberrypi/rp1-cfe/cfe.c
@@ -2343,9 +2343,11 @@ static int cfe_probe(struct platform_device *pdev)
 
 	/* TODO: Enable clock only when running. */
 	cfe->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(cfe->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(cfe->clk),
-				     "clock not found\n");
+	if (IS_ERR(cfe->clk)) {
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(cfe->clk),
+				    "clock not found\n");
+		goto err_cfe_put;
+	}
 
 	cfe->mdev.dev = &pdev->dev;
 	cfe->mdev.ops = &cfe_media_device_ops;
-- 
2.45.2


