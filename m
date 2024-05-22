Return-Path: <linux-kernel+bounces-186678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5842C8CC76A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDA4282176
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C960C13D601;
	Wed, 22 May 2024 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaOcVR0H"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD13155C3E
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406982; cv=none; b=my0NXOVD25tfAzP4hVONSuvVAurj3SFn+OqX0UYcGamO7q4Pjv8JcBSzXOQAODA25325HZRgSSwb0EmTbaf6vQ3SPlYEBXh6cjwkc1q84SQ4VvhB1D6PDpzMqZOVO1rCP1lOT1+Y78LrxNPIIxr070J+cHgRlGPCGnhn5sPLK4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406982; c=relaxed/simple;
	bh=Dw5j8VGHS5Q3mQPMZlca9i/sZ/qFXvLWtVJzt6swrcs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jqGDR3nQj85r6VWhZzEEfPbLMrrIlrduhdx/FkpD5PHt96rala+4uuM9NVvIFoao563ldi0dGfpAPlVekV5d70sojMmUExVG/TRrqpz9yMHYVJcelkcgHSR5o30rHJhEY8gyQTqi/g12nvNcRAX02MtzprNEn7k6ouipIY9Eewo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaOcVR0H; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f4dcc3eeb3so1338911b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 12:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716406980; x=1717011780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+l1jGRIHGLSOCzg1Hqtmq9RANsnqiXOnvKtLbcZF6nw=;
        b=LaOcVR0HCwBOwmZ51bB7aiUfXBl01yHw2HXvY34qst0D5WxSA+RKipTqWtP+ssTY81
         Wwx0DCwTsOeebU6t9W0mqWgO+O+hvgpvDTsol6kTWCAHWpB+b7I8BNExYC8Wy5wMPR0E
         r83SPX9f2dsGzLURwGZjfX9+nmMqRA4yrBYUHiQnw9zSatlOFImPAHm66ky8uoJGlsBB
         Kh8VPl6QrNtQ5QVuc9ME80JFIXASd9MAaI2aNyYGAYFO6QcLsoMohf4DeuG7M0Y90KOw
         vP0DHb/QNESs+plxP7ZV7MDwc7lptkVEopjPSFMp8IUzi0J1L9hMGd24HzjlTljh6V0m
         RebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716406980; x=1717011780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+l1jGRIHGLSOCzg1Hqtmq9RANsnqiXOnvKtLbcZF6nw=;
        b=YK77M4OG7aVQ8PUYebdWaIrku1yoAs/z4I5xz6+gVM9JDOeVzrJzQkfgfsbkY9HAB6
         qDmxUgnC9xaFzMyu0TwFEmTMBL4ReNqZXdEmgQMYbP+tQ/mWboygg/msCL4X7Ya2M7AD
         LUkQZKJfv9vUUWEHwnMEvJyGebCBwKQ265rmtaUN1Hrore0f4VZaeIDVricm0V1/MR9F
         Oh4zJ9pL7sJ6y7VrPXexY9FwWf4msgzpIO+j/jAmbJURKe7X56XuL1/SMw93sn0tBQoO
         QiIL6q59vWbQcgZhrCoGJ2YrWxd0OGcWN3WyDwl+jCyMs7AOAs1nB89A+gDBf0RdQOuI
         p2+A==
X-Forwarded-Encrypted: i=1; AJvYcCXwTuLS59GGNOQ2Vdn/jRuO3dFYH1m+BnF755GI35jnU42mfZxcNoiAIgkuenH8RO7KtTwzhoo/sQsK0ifcY6754/B+bsAD24b4Fqfh
X-Gm-Message-State: AOJu0Yyb8URCNX0GjjBMLQIJ4B13Eo8shmhg0zPGGN6XBU/bj3trVd2u
	6cchl4YltlNizpriOOV5+KHdaV9eUkmCmxXZqn53cUdoXJQmZ5Ds
X-Google-Smtp-Source: AGHT+IGahBLCjjQG1T2S2C1fP6BqgfIWhVb9z2cxp36QzXbpzt8+4YBsoWGn0Y1xbJP7uCm5/8JW3g==
X-Received: by 2002:a05:6a20:3217:b0:1b1:d2a5:c7b1 with SMTP id adf61e73a8af0-1b1f8b44af2mr2752771637.49.1716406980129;
        Wed, 22 May 2024 12:43:00 -0700 (PDT)
Received: from localhost.localdomain ([27.7.152.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-656f38b855esm10648576a12.8.2024.05.22.12.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 12:42:59 -0700 (PDT)
From: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
To: akpm@linux-foundation.org
Cc: mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen.n.rao@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	julia.lawall@inria.fr,
	javier.carrasco.cruz@gmail.com,
	Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Subject: [PATCH next] arch: powerpc: platforms: Remove unnecessary call to of_node_get
Date: Thu, 23 May 2024 01:12:50 +0530
Message-Id: <20240522194250.1165568-1-pvkumar5749404@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`dev->of_node` has a pointer to device node, of_node_get call seems
unnecessary.
It will automate the cleanup process allowing to remove the of_node_put
call.

Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
---
 arch/powerpc/platforms/cell/iommu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 4cd9c0de22c2..5b794ce08689 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -780,14 +780,13 @@ static int __init cell_iommu_init_disabled(void)
 static u64 cell_iommu_get_fixed_address(struct device *dev)
 {
 	u64 cpu_addr, size, best_size, dev_addr = OF_BAD_ADDR;
-	struct device_node *np;
+	struct device_node *np = dev->of_node;
 	const u32 *ranges = NULL;
 	int i, len, best, naddr, nsize, pna, range_size;
 
 	/* We can be called for platform devices that have no of_node */
-	np = of_node_get(dev->of_node);
 	if (!np)
-		goto out;
+		return dev_addr;
 
 	while (1) {
 		naddr = of_n_addr_cells(np);
@@ -805,7 +804,7 @@ static u64 cell_iommu_get_fixed_address(struct device *dev)
 
 	if (!ranges) {
 		dev_dbg(dev, "iommu: no dma-ranges found\n");
-		goto out;
+		return dev_addr;
 	}
 
 	len /= sizeof(u32);
@@ -833,8 +832,6 @@ static u64 cell_iommu_get_fixed_address(struct device *dev)
 	} else
 		dev_dbg(dev, "iommu: no suitable range found!\n");
 
-out:
-	of_node_put(np);
 
 	return dev_addr;
 }
-- 
2.34.1


