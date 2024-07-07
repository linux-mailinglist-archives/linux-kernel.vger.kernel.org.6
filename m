Return-Path: <linux-kernel+bounces-243444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5256929630
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 02:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781FF1F214B9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 00:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1DF17C2;
	Sun,  7 Jul 2024 00:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBM83hFJ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE07E1860
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 00:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720312543; cv=none; b=oV93ippO0pCfQ4Kr8WM6e/cU0i7lhDMG+7U8RMQa1dxPGI8YgskIwK4Et7WLfvRlhCve8zZx8KUvW6by6Ol2qc2OJe05SRuCPozkE05DyYMpr+VSk5jyfYiTEPDS0KPRhxDggJ2cuvmCEom2NKNUdkduL8BS1zRUjAgRGARyNmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720312543; c=relaxed/simple;
	bh=R6X2fCI2KinzND2oBgo+NjrYcME0BM6mgVWrZqd8a+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iR1WrvAIz3XGu62qMXcpZg545gKIdopi25bfi/CVpTHVyRDLtKJ0BP/A+ZD2kyCnrDT9uvYFd/YqROFlzlWUPRZsAnSCoXGnuZNgWT9kqR4MkuF+8PvDGthbz/R+hLMnZe+bPWvEghlS1nfMZ4IYKnaYfaNDASzi3MOid1JRXdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBM83hFJ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ea2f58448so3251847e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 17:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720312540; x=1720917340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y24B369tsqgPF1sE6m458QbjU1a5YFUso0PShTrZFVA=;
        b=XBM83hFJZ1DvtK4BKpQP2tFJhiv+vUEwD10Fu6NlJ06sos5U7g3w0a14VEqDWSKj+1
         rtsJiQGUFrlnLzNZeimnhAB68YN8GPwQZKFzQUfXiCaWmWArV2B+NcSVQtiS6SXnJMPs
         I5ZjNDZygavSvjo+QlJkUseEiuA7TQTAIb/NOidrCnicTEki6ESso1Ev5Ziw0g/emTmQ
         22Mm5FhKRbliE6Hv8T7pzq1cUaenQGbXg337NzMhj8pY0zmy67QzUOy6smLFKL7AJOyT
         VBeXxXq/qrKSOTGZO950vOTY+3d9ZTly5W2lwZ1ng2IEH3FevHDwySoFMwx+TDUa0zK1
         zUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720312540; x=1720917340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y24B369tsqgPF1sE6m458QbjU1a5YFUso0PShTrZFVA=;
        b=he8h3njxVNRtRSzoykeGY9fpNCBzE79uX0aAgIbz0ECFhb1JVT5kwDCnfDtSMGba6z
         tl+LaY8n1ZpquRCtdv7ZTwK/mKr9a8KHJg/ZPVqPvfnuP9q2OHTB/Hbynxqs4dB9WVHu
         0x1ITCxzA/2SJ8XrDcIdJvfAeOugNPcXDStcNF3pJ4Rx2d/Q6tY4n6jKy66czAay+Q/Q
         xkSrbK2WVh08GS8wZ76bvU47eQRXcvXOX5J6IhmPrEjZ5oqGLfs4+7zXNRuMxHYKWjg7
         Ww1LOC3g+C0hcEufgEFk9ShnQAJSVHw4eiliVboll9/tL4E4FR5hZOcqzrsjONz1so+p
         bxfg==
X-Forwarded-Encrypted: i=1; AJvYcCX04DoYdLFQ9OdBTGT6yK8RhdInRaYYwiAqkPDSx8WBxNj0rcSLwpnISwL9Trw9KfxFBHpwK+UKbIcXYACz4cjCHXMTcqDjwwrXgx0y
X-Gm-Message-State: AOJu0Yz7jCS0tbZnFHNLqFx4498jDf1wDStbabPOLSjeTcJflIMztKBW
	Ridu/1s99lvS4NMNnUNcxq2Pt1Szcbpym9EzkUx5xsiiiVXobZym
X-Google-Smtp-Source: AGHT+IHER6OTwEkphqEqCz/Hc+vaSOEIX7b1oYd1erOGY64etZFqoEfyqZtLtq59+I6TM9BwzSzKCA==
X-Received: by 2002:a19:ad04:0:b0:52e:9670:e40b with SMTP id 2adb3069b0e04-52ea0638c48mr4940123e87.39.1720312539614;
        Sat, 06 Jul 2024 17:35:39 -0700 (PDT)
Received: from SP-RaptorLake.dyn.int.numascale.com (fwa5c4a-112.bb.online.no. [88.92.74.112])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-52eab4445dbsm222658e87.192.2024.07.06.17.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 17:35:39 -0700 (PDT)
From: Steffen Persvold <spersvold@gmail.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: spersvold@gmail.com
Subject: [PATCH] riscv: cacheinfo: Add back init_cache_level() function
Date: Sun,  7 Jul 2024 02:35:15 +0200
Message-Id: <20240707003515.5058-1-spersvold@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 5944ce092b97 (arch_topology: Build cacheinfo from primary CPU)
removed the init_cache_level() function from arch/riscv/kernel/cacheinfo.c
and relies on the init_cpu_topology() function in drivers/base/arch_topology.c
to call fetch_cache_info() which in turn calls init_of_cache_level() to
populate the cache hierarchy information. However, init_cpu_topology() is only
called from smpboot.c:smp_prepare_cpus() and thus only available when
CONFIG_SMP is defined.

To support non-SMP enabled kernels to still detect cache hierarchy, we add back
the init_cache_level() function. The init_level_allocate_ci() function handles
this gracefully on SMP-enabled kernels anyway where fetch_cache_info() is
called from init_cpu_topology() earlier in the boot phase.

Signed-off-by: Steffen Persvold <spersvold@gmail.com>
---
 arch/riscv/kernel/cacheinfo.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 09e9b881..42c22f83 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -71,6 +71,11 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 	this_leaf->type = type;
 }
 
+int init_cache_level(unsigned int cpu)
+{
+	return init_of_cache_level(cpu);
+}
+
 int populate_cache_leaves(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-- 
2.40.1


