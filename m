Return-Path: <linux-kernel+bounces-327735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D43977A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67C21F24CEA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0471BD007;
	Fri, 13 Sep 2024 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdCFnvLo"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5189F1BDA9F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214542; cv=none; b=Ez620oqw7OSh53v1S5eekYumJYW5av+cl8EIf9fvxSw5a41PjIHd/lzqOZimwBjt83xvByEEc5PvLRYk/JbnHQDj4ieCCmvONBTDYIikv/E9A2shVsM56FzxjHnt/aZWAnXM7EhqQMp38EtVSiG9W8I/mjHz6stxe2XWggPJb0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214542; c=relaxed/simple;
	bh=Dc5AbwAEhkjz0SN93miVFpHCjf9pfK+yTHfFlCR0Yvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n+lpHC/D+Gp8o64TU+42tbfvQTjmu8J6tww8fgYAD6HT95jw5JsTq050xiCoGUop7UAY+0YoyFF1oF2C82zY3+Ju2V0qc/KUpidUBT3d8dxY4cHML0X6h9IGb5uMDix3bPBl6mn1DkLdnoKng1MjLvlMqJOZt20toDJUEbXgoQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdCFnvLo; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374b9761eecso1495468f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726214540; x=1726819340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QUHpuEMdwgWMntNVHej8EuaNXUZ23ZaEtBMSS3bF7Ns=;
        b=AdCFnvLopG8TjgE6cVTqNpD17qC+/OO4CSxdwYbjT09e963F1xqlGU+sIi7KLzfc1G
         cE6M2mKE7ItnADO+U3CZs5wHws7b5rujbZNd9BQxjQlnP7MZUe5mzKtcJw8u5PQqPJTU
         kg7PM8rQ16/HOsMJpX+XYlCVrQ83SWAV0HSyZjihcOr9CsiOdlGQa6m8Tpj+Fs5uqlxd
         aVDY9Va4WDmw4yS2PB66IN12gytf7v+lHdvmVAG7NY7wdhtl7FPT1YxXFJ3BDw1dZ1DT
         2bI2cyWmDHmndDgm19YtJ6Oi6TpjkkHAbyP7bURFLyptCBEruCUvAY+rNYsPH8rj75YF
         D2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726214540; x=1726819340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUHpuEMdwgWMntNVHej8EuaNXUZ23ZaEtBMSS3bF7Ns=;
        b=FlR3qWRpJM2mt58vyOYvExunBRFVmaYroUp2vs4ORWduloSWgo3vHBeMlNkvEdEWTd
         sIL+s1WSy1R6obH/NAScTEA413pyO/rW3nnoZLYYceiPCTGeY22fYn84FuR2/FrYbwHB
         O8yFU9clJD1fYkez049tftD266SjMuvX2x6ARZty48Q7xyc0pjYA5jlqZ6uU8mgxn+kS
         1t1TbMJ6jcGkhoT1f+VnxYGtS5i4pY7hxfPYmhjdaLLZBXt9Z84KTX8JH6pCvKFSJoDa
         ZDUuUuTqjQhjyMSEmuRX8XFlOpycSVwVyP0YpvUZbfeVFas4ZT6mrw850Z5Uhj/bUAlm
         vqVg==
X-Forwarded-Encrypted: i=1; AJvYcCWP3fT4/IfQaUlxJ3KNDSA5XL+txht+EC2lvLTzDRu1AX0WP0vh3Nldamw4XizVfdFgAfXzXP+npD0bpqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJM20+4lJefulROjzyBU8H7TBOfD562R2uSgXrFqVhoi5HtzNt
	mXA9MVmJOKpu3eB+k+Wma4Y9XeGBNKEqEW2Ns+Wc5yls+E7MJs0c
X-Google-Smtp-Source: AGHT+IENGzKP3ZQJ/nGqRArc6ZbD50zoVdF5RGr5dExedp5Xbz+wd4r+4yFaJ/IlCZBXmyrU6Km2eg==
X-Received: by 2002:a05:6000:1110:b0:374:b31e:3b3b with SMTP id ffacd0b85a97d-378c2cd41dcmr3335594f8f.1.1726214539284;
        Fri, 13 Sep 2024 01:02:19 -0700 (PDT)
Received: from localhost.localdomain ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956ddda1sm15955681f8f.95.2024.09.13.01.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 01:02:18 -0700 (PDT)
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>
To: paul.walmsley@sifive.com
Cc: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	cuiyunhui@bytedance.com,
	sudeep.holla@arm.com,
	jeremy.linton@arm.com,
	sunilvl@ventanamicro.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>
Subject: [PATCH] riscv: Prevent a bad reference count on CPU nodes
Date: Fri, 13 Sep 2024 10:00:52 +0200
Message-ID: <20240913080053.36636-1-mikisabate@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When populating cache leaves we previously fetched the CPU device node
at the very beginning. But when ACPI is enabled we go through a
specific branch which returns early and does not call 'of_node_put' for
the node that was acquired.

Since we are not using a CPU device node for the ACPI code anyways, we
can simply move the initialization of it just passed the ACPI block, and
we are guaranteed to have an 'of_node_put' call for the acquired node.
This prevents a bad reference count of the CPU device node.

Moreover, the previous function did not check for errors when acquiring
the device node, so a return -ENOENT has been added for that case.

Signed-off-by: Miquel Sabaté Solà <mikisabate@gmail.com>
---
I was wondering if this should also be sent to stable, but  I have not seen
a report on it, and this is not responsible for an oops or anything like that.
So in the end I decided not to, but maybe you consider otherwise.

 arch/riscv/kernel/cacheinfo.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index d6c108c50cba..d32dfdba083e 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -75,8 +75,7 @@ int populate_cache_leaves(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
-	struct device_node *np = of_cpu_device_node_get(cpu);
-	struct device_node *prev = NULL;
+	struct device_node *np, *prev;
 	int levels = 1, level = 1;

 	if (!acpi_disabled) {
@@ -100,6 +99,10 @@ int populate_cache_leaves(unsigned int cpu)
 		return 0;
 	}

+	np = of_cpu_device_node_get(cpu);
+	if (!np)
+		return -ENOENT;
+
 	if (of_property_read_bool(np, "cache-size"))
 		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
 	if (of_property_read_bool(np, "i-cache-size"))
--
2.46.0


