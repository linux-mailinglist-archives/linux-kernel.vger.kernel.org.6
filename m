Return-Path: <linux-kernel+bounces-285938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DA295147F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD861286D32
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2241E13A41F;
	Wed, 14 Aug 2024 06:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LHeMddkM"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF9A137C37
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 06:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723616798; cv=none; b=HhTW8xqAQ4Nx9IGS2zXx8PLbJ/FFkGe5TFZOrRARq2FQL/TZ3qznILTKNHw1OAVc5eUItC8jxB6EbUL8ND5T372OCWgy2GXKZZfqpZPfvvm8OVBsBF7OpnYmvRxzS/+hIfpzkzICCTSkCxg/aneWmxTpLojwg0nNo4vx/J3TYUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723616798; c=relaxed/simple;
	bh=i0S3J64BQdkxrV4gx//0PluX+Y3MsgQD+V/K3f34oQY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ho29q1wKzb/9OJ3yOJoq60w95v8z2j+5T13RYS4J/tJUmiRurkl+FoJhEvQxRg8gJu2jP/o7T4kH74VhBC7p2r62J/JPio6F0z8tOzHZNhDXWscUyJxk14FmJ6iWagIaqNuhWspUl7TqL8rPojZLmefqq5/GkycpskpenuTqOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LHeMddkM; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-709340f1cb1so1929651a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723616795; x=1724221595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wwc1cv5BO+5rtWkwftD9LNj15+/yJ4czUcQ6aWmdEAM=;
        b=LHeMddkMsisqprRo5SFbZM1H9WmG90qze2cDfryX8irKaOx4M/+cX4CXDau38yhH3G
         zYIeXLKxp+CfG+XNXWlTbew78noiMXS8Jwrpfg9L1uMfeROkaFIBiCFhFG1yAzsXK1mJ
         u9e+SzMlAzTM3mkzMtavSLvVW/BkA63owNRMfeD4i/8NyzdatbNq4J0/fC0IkifFH/98
         umXsHaFnLV84NfDZlJr0xtVHS5nPHmtwojgkwiCNrj277xCqldFMz6TnZ2LS7oR3zyRN
         zAq43G4rv9p8mSifXGhJp2e1Hnei/cLod1oafNZjoww+F/k/21pzYGLySNl/sGoJaqUc
         gecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723616795; x=1724221595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wwc1cv5BO+5rtWkwftD9LNj15+/yJ4czUcQ6aWmdEAM=;
        b=Wa2W56PhqTmLBV9+T9WXj1DTfQ06SegcPLGBo5JniBTdJkldkOBFONzeAnjSAKGKgC
         5wi91/MT2KfvEJEJpw0XRpyhWPwmsDm90+90zYGNzBVut2//FsV03IZSlOh1neoKpqxG
         ewA7ftX7hbUCEhRS6FmwTmXp6TG9n9Siq/r1iMxzd4by/V6Zub4GgHasBVRQyqfIdGg6
         LDDIXpQe0HhZdWGTiA/YFWun+0ss22jCvM1yuzEkQCrF7++5ek1IuKHR7LLIMEgpVHug
         dtvMHI/V6yu5MSH2yjW3RqVhRW9tIrH8cRMhVj42jcOIBXNSy9J23/mrd4fT6XK1sfO/
         96KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjxfLiI15CydnjnU/t27QzqCwoVl7lt3QQrcvZR5G2Wp9QrC0HfolzUUKBEXs+oO5/XzB1UVdlkp9v05/Nr/vrbDorMa7gjc3Y2IQN
X-Gm-Message-State: AOJu0YzoNaswrY2jmaZ8IhGzUPM3PGCHJc3aUvm7GxPjdP2HwBUx5ooO
	AoFYPpx/EMqec8gIaw9Jz80lSdw96Aj0KnHD1/j9lKwoajZL2xe2DyeR449NKL4=
X-Google-Smtp-Source: AGHT+IHhAfduYALo1MbVjnUfBA1qOzcpqiHc4wEVXsHl2UAtIqJNFPxWlDnMgRPWfrE1Cw0gPMFWRA==
X-Received: by 2002:a05:6358:33a3:b0:1aa:c71e:2b4d with SMTP id e5c5f4694b2df-1b1aac478d5mr176058055d.20.1723616795453;
        Tue, 13 Aug 2024 23:26:35 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a55de3sm6667484b3a.139.2024.08.13.23.26.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Aug 2024 23:26:35 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: punit.agrawal@bytedance.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alexghiti@rivosinc.com,
	cuiyunhui@bytedance.com,
	chenjiahao16@huawei.com,
	guoren@kernel.org,
	vishal.moola@gmail.com,
	stuart.menefy@codasip.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: add a warning when physical memory address overflows
Date: Wed, 14 Aug 2024 14:26:25 +0800
Message-Id: <20240814062625.19794-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The part of physical memory that exceeds the size of the linear mapping
will be discarded. When the system starts up normally, a warning message
will be printed to prevent confusion caused by the mismatch between the
system memory and the actual physical memory.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/mm/init.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 52290c9bd04bd..c93164dc51658 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -236,8 +236,12 @@ static void __init setup_bootmem(void)
 	 */
 	if (IS_ENABLED(CONFIG_64BIT)) {
 		max_mapped_addr = __pa(PAGE_OFFSET) + KERN_VIRT_SIZE;
-		memblock_cap_memory_range(phys_ram_base,
-					  max_mapped_addr - phys_ram_base);
+		if (memblock_end_of_DRAM() > max_mapped_addr) {
+			memblock_cap_memory_range(phys_ram_base,
+						  max_mapped_addr - phys_ram_base);
+			pr_warn("Physical memory overflows the linear mapping size: region above 0x%llx removed",
+				max_mapped_addr);
+		}
 	}
 
 
-- 
2.39.2


