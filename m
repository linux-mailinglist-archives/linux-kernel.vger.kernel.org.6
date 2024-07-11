Return-Path: <linux-kernel+bounces-249883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3E292F119
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F1EAB20CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A49E16DECA;
	Thu, 11 Jul 2024 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="EJyuYV7d"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107CA19F49E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720733131; cv=none; b=VfMQvoQFGDPrqEYKTeCGhDGadHzvCIFjLTVfyJfjyoeFERgOsjDfIMgC1+U93ngrij3eEV1V1JKBdm/TZoFjdxVQSEpmk/FLyBwQb6WKnHCDkvg0FE9YNpN3ReNJx11w5tIwJZEMtb+REYLo0pHgDB8LO8JfdeRmItb8HDPcwKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720733131; c=relaxed/simple;
	bh=uATPzvaV0y91OcQoBwZ55PYsDWdFh68MbA8/+3ddi/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K11/kMc6fS42n6997BGwZQjY+HDnBvzNgx3ZuvWphoMxDDKnvl+sh47NL24RZi6rOLMT8MyIsHvjUUMwQCZ6f+RdJInPpS7PcwqZ9ECCYfs7AK4wcYjYoDCDyObDsdBzaJzn9FH6PFRFibx+ea0Ees5i3y40ocfFlQFi+szX2EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=EJyuYV7d; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266f344091so10629265e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1720733126; x=1721337926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IPdTxwZqDLePoloPF32gHSyQNBeBly7lmFUJG9EMsKo=;
        b=EJyuYV7d0l3BzqoBYRY28MwUD4vxenQLeuTWk4g67PMhWEtquGx5w2/qlD4xaB9XEH
         taosEU8lwJaMBe9+stwEBCkGdlJ6uJLdFCe/QMuI52YlSa+OeCdrK3wFoNRHKX4ZSNMS
         P1AdEQxarE4t6epxbQk5aLdpGiDvnri+uiS4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720733126; x=1721337926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPdTxwZqDLePoloPF32gHSyQNBeBly7lmFUJG9EMsKo=;
        b=v3OWmABvXE5GB43Do0dMU/nJAqFRI13H+muKk95h9ShxpbbSgi0X52URxzYLe50XOD
         IQuapCxyiTniFjiNiogcFMsOSRw5f1F/2ZgHYTBM/hl2Jglj7UrO/VYdYF/33x8gEyzR
         nd8BEgaVffWDGqREjSL5io2BgQYuRRoVbdTrGcSFLbldgWZlem7ZrS/slZ5CyJuBKziN
         9KiAQyIVV5Xcpzy6YecxAt/UqX8ewDkEVQf6sR5Nm6wSvZeFOvi9s4f391bAT7eW3Ldu
         FvdEMCr9stWfQ0P51ZYn2QhMXzu/JpJYiD+1RxHvwPQS9y9utGYsxGk2hNQgaqsrXSXf
         FOxw==
X-Forwarded-Encrypted: i=1; AJvYcCWtyDA1iPxL0QC7kgz+P8YCPdOBTA5fKAtH5ONlKWImne5kjKwQJ/wguGYMzTG1AtpB5N2L7UveVc+vlFnGvD7O5LCN03eTlP1KBN9e
X-Gm-Message-State: AOJu0YwVnbSPwBAwfYEKE67Bzy1kNpNr8YnMcPo6XXrY7ZQMMTS0udqj
	xAPWQKjnVCj4GiW/OEmjfu/lAwNDxb5Yt/p/ItowtOKF8I8qIRBzFTC+S67of8g=
X-Google-Smtp-Source: AGHT+IFasI/VTwr1wQiQO6WZKRnF0IfXpYtY7NkeyH3PT9BX332wIOf6h8HXcCtNM6Nih1EdmiW79g==
X-Received: by 2002:a05:600c:2d43:b0:426:5e91:3ff1 with SMTP id 5b1f17b1804b1-426707dbae6mr61122775e9.24.1720733126444;
        Thu, 11 Jul 2024 14:25:26 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.numericable.fr (53.1.159.89.rev.sfr.net. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f276a62sm1286865e9.24.2024.07.11.14.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 14:25:26 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
	linux-kernel@vger.kernel.org
Cc: Saravana Kannan <saravanak@google.com>,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH] regulator: core: Set the fwnode for regulator_dev
Date: Thu, 11 Jul 2024 23:25:14 +0200
Message-Id: <20240711212514.2372780-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yoann Congal <yoann.congal@smile.fr>

After commit 3fb16866b51d ("driver core: fw_devlink: Make cycle
detection more robust"), fw_devlink prints an error when consumer
devices don't have their fwnode set. This used to be ignored silently.

Set the fwnode in regulator_dev so fw_devlink can find them and properly
track their dependencies.

This fixes errors like this:
  stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Failed to create device link (0x180) with 2-0033

NB: This is similar to the commit a26cc2934331 ("drm/mipi-dsi: Set the
fwnode for mipi_dsi_device") applied to the regulator framework.

Cc: Saravana Kannan <saravanak@google.com>
Cc: stable@vger.kernel.org # 5.13.x
Fixes: 63c7c9e16c8e ("regulator: core: Get and put regulator of_node")
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 844e9587a880..f05f873021d2 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5656,7 +5656,7 @@ regulator_register(struct device *dev,
 		dangling_of_gpiod = true;
 	if (!init_data) {
 		init_data = config->init_data;
-		rdev->dev.of_node = of_node_get(config->of_node);
+		device_set_node(&rdev->dev, of_fwnode_handle(config->of_node));
 	}
 
 	ww_mutex_init(&rdev->mutex, &regulator_ww_class);

