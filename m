Return-Path: <linux-kernel+bounces-242363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 159FD92871D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD981F2221F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937B5148823;
	Fri,  5 Jul 2024 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTiCzEkf"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59213131736
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 10:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176753; cv=none; b=mM9ou4moRDccHFLFMKtaAWIBUwMfEfAd4e4Sb/K53B75di1cxNw/CupA4qTDRvmzLxhBfFZPOTrjgDpurotNxslBsx7Dcy8bCf72isN0/W2vuuintu5SAi7bZnh713FNt1wwXjiB9K14Aq+22DrDsbEHcRI7JrFPb72rG7ARVls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176753; c=relaxed/simple;
	bh=QGBRDjKMNtYW16xiDTuPGbfVeQ8d/jHQ8QxJN+a3RL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pek/uGvjqVRcS0JFyDfF4g56F4gKmml3PUJC31H8D+I1LxzSCwyl8ec9307qIseZ8Ex/6RGOC31exStOq2J0JVVO4qI4mHeghGhRa8JW3oHyU+1FM157qS1/6PkaQTOsY5Jw6FvgKkcWPNJBL0tHhMZziM4Y3uaAcFZbJLy9FKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTiCzEkf; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58b447c511eso2000083a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 03:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720176751; x=1720781551; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qUMoAQufaagpNr6tV8PaGVo5aWiUuvCiezV1z2Z0uUs=;
        b=CTiCzEkfvlAjaN1GRI0f0Gj6GElXlcNzk7p4388crkiPMiMRb5zDGDrGstxt5XTRKJ
         lhmlMWaJalvV4Ee7bgyBhDgGjCX6+zYBojEBUgbj+GCd/ySfT6BdbZxjr1QrQTnI9907
         wsytF1L7EUl6juX+wFf6UWvSxST1UetR+TswARJUl0UNdCLtw/StDSFscTmaW6NVwvlJ
         naE1CpxyyVPqt1fOOUDWoq+Bxz5hsfzkR6RuKimI1SsvAtqCiqF34BTiGLwvBZi84/yh
         gHA7uYKJo4G+Vs1iSxKwMxpZLnVCgqRwbfGCNIyndV0/8Pdt5GunFe7WAcYN/Q9CmFQd
         Ishg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176751; x=1720781551;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qUMoAQufaagpNr6tV8PaGVo5aWiUuvCiezV1z2Z0uUs=;
        b=Sbvsf5t4AshpIPVSpsImlX3W6nO1CS2zytNldFS88LTRoLxRswpa2NDZ6y3NixWChl
         p10UtoslRSu8xKA1jmbSprbNDOpJhx+40xstHtw7ucVclEh19Bo+0SWkpt3PQn7jxk4p
         hpv6aWipNBSrl5F1ZeOQnwPgzflqBgBafoYMuAXF4rCI/eL+QnxZytRReUX0wrciS0ga
         NAdWG+/nUpOsbRHYkmEaK/HCUyZsUrLf6dMneHK+c/XB4x4s/ePqz7YBqiI8LNV7vr1/
         ky9WKQZy7gpcEGbMy68DAezYc2E9Fl6dEiC3P5a/QDAqoj1bXNyW5v5Gk68+1XWu31iM
         TWpA==
X-Forwarded-Encrypted: i=1; AJvYcCXj3Doi0SvZPhYypEGnuY/UZrP1+VRrS6uw8fwZBWWJQ5zm0L0GIMsdQdgz9+gBx+2O6Y5Et80m1sEOhdsDT4BynTc36TL8JVWaoc7j
X-Gm-Message-State: AOJu0Yz2+Q+iGRbMwcfPBlrt7k7iMDAk6iw02GqtX3rXVpP8jtCmoRyY
	D/m1Ym0oyXpBVHDmVTjyEAL3dxIDnN4J3hgvo3ARRtdlPQeH+Mj2
X-Google-Smtp-Source: AGHT+IGz6P3IZ+lNYkgQEuRvSKBL2zU7f1M3XQaaJLj384xS+BDm6WQRyO/zk84MF+4SGrNS6bpf9g==
X-Received: by 2002:a05:6402:2792:b0:57c:ad11:e759 with SMTP id 4fb4d7f45d1cf-58e5c82651fmr3577891a12.28.1720176750597;
        Fri, 05 Jul 2024 03:52:30 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58cd108c84bsm3388452a12.47.2024.07.05.03.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:52:29 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 05 Jul 2024 12:52:27 +0200
Subject: [PATCH] soc: sunxi: sram: Constify struct regmap_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-sunxi-sram-const-regmap_config-v1-1-1b997cd65d0f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGrQh2YC/x3NwQqDMAyA4VeRnBeIujLZq4whtY01B6skKoL47
 is7fpf/v8BYhQ3e1QXKh5gsuaB+VBAmnxOjxGJoqHnSixzank9BUz9jWLJtqJxmv/YFoySM5GI
 9DOS6NkCJrMqjnP/B53vfP9onwXZwAAAA
To: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720176749; l=962;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=QGBRDjKMNtYW16xiDTuPGbfVeQ8d/jHQ8QxJN+a3RL0=;
 b=r5tzq+6aAPquOFfO7J4X47CgE39TP7rvi6Y8WaiEAh+P4TeODlAZtxWdekKB0R/nk+cF8LLsL
 oWauLmKrxmtB5ukdVXaIJnRBpUQK/jhtBxcdBdXPcLoYNzsv3vRH0SO
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`sunxi_sram_regmap_config` is not modified and can be declared as const
to move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/soc/sunxi/sunxi_sram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 71cc377b5e24..2781a091a6a6 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -344,7 +344,7 @@ static void sunxi_sram_unlock(void *_lock)
 	spin_unlock(lock);
 }
 
-static struct regmap_config sunxi_sram_regmap_config = {
+static const struct regmap_config sunxi_sram_regmap_config = {
 	.reg_bits       = 32,
 	.val_bits       = 32,
 	.reg_stride     = 4,

---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240705-sunxi-sram-const-regmap_config-d05d1bb0583c

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


