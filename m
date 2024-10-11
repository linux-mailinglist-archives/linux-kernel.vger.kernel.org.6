Return-Path: <linux-kernel+bounces-361346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBDC99A710
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80B828343D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E9D18593C;
	Fri, 11 Oct 2024 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK0Twd32"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0EDEEB5
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658818; cv=none; b=bXA/Tq+TFm7Zb1mFNb3j9GDgKU29oDa3vVL0gclBInfqHA8z1PsNzh/YNc/wfORutPzhdvLEZgjleXbcpzqKcj4CkYWRSwhe3SXul0gifyYyw3WeOd3Y/FhPDFigsQrLJvpMEYK2cLYqI4dx4FykTzsbq5wW3Dyj3ctHydjmc0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658818; c=relaxed/simple;
	bh=QOHHkKK5Ke4mkSQpvvwqf+RDb/SdwS01q3tQb00rzUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KWLlhDnMJWYHzUEfn1Nb6aSnFiqzUeXU2cKDC44qKyDaxyWxFB9kwSIuiAEQDQ2P0Go9OhZBMqyYarj5Cn/5jJTk9slr0Xmpt68+NIjyrQqP+klnpUv1iLhIhJL55FHWJseQbdEPHLGAbHub+3UsBRqEuVfgxmc1cX61N+U3AzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iK0Twd32; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71dea49e808so1953000b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728658816; x=1729263616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GxJ3a4GJ9kmYrP2J+wqTevzfvJ84If+iUVZIlsVHzAQ=;
        b=iK0Twd32hi54/M6tdgcWK7Om9bWydjNmoLV31xteqiLSHQJHfSyJspl0baI7JJINOi
         nNx1KkifXviG7lv88RO7gJN5C7Fs5o+xTOH1pdEoNnc4hoJ9TreMfuBSJDP8a7X7+31A
         A9pkJxG3oaRhBBlaUILD/rISN6QFQ7qyFbtPhJEz1/85iavi0+tZTFfhtnybnGVWXueb
         WdBq0BDLANCdtGqtqFZPXoTcu7i5u71HZb46jzIQPlz4om31HNbDs+G2ZL9RmjkB0ai1
         qtZa9h0GaiEuJNvmKL4R3DQe4c53w22VeRO7gUX6ahZxrQhW42GseIgJ+WF3d+jLnwI+
         yPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658816; x=1729263616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxJ3a4GJ9kmYrP2J+wqTevzfvJ84If+iUVZIlsVHzAQ=;
        b=bay2tflvv3Ze5Wd4NSpedJcxjvens1RJMj6G/ki5Tf8gZJ9vFTAWLqO9YXF/dk9wmW
         jF3BpV3IpJqOilw/Pl6s97p+HLMaPB5Ouihn6pQL8aNKsLChzQpkj6SzrBkeZfSZmTQF
         ILiYdOvFolNupY1C+GQVbe/rfSLWYcLB4XLNnV+lUek82LkztCsN0BKkY4Mo1l6LZNqw
         G5NsgZFWRiJdxzLF1719eQWfgfhbQNbwOgYIJcHVsISLTA2Ax1yjhxINdk4SOh9Zu+4x
         oqUMJ1Nt3/g6ZqBh7fT51/lh0EoVwEbu8+fPlb72SGuE6atUmDLhFj5TXE6pkLg5Ir0N
         pfpA==
X-Forwarded-Encrypted: i=1; AJvYcCVcClUN2emzgFuMenKynoaJbKE+uQDw6s6i0hswE4biqeeAtpKq474V4xTnnwgeXzEzoDbBvO8qOuOSv0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4qNNGCeeuUF0pSYk0x3/y7ykKCVvLddFfj6TH9Fot184UWL/d
	lG7FQT7bkGQ2D0VmrRsVzkg+dNaJF2XWqo0foXYF/RaApmRZCjJr
X-Google-Smtp-Source: AGHT+IFbjpvOtZ/4fnGnu1qPpet8fqGoBC1EXvpTqBB5vCO3GdLz4J1XYWVfGZyMKj/vHw3RhywtBA==
X-Received: by 2002:a05:6a00:84c:b0:71d:eb7d:20e4 with SMTP id d2e1a72fcca58-71e37e4e13emr4618936b3a.8.1728658815997;
        Fri, 11 Oct 2024 08:00:15 -0700 (PDT)
Received: from dw-tp.. ([171.76.85.106])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e4a2c9767sm146561b3a.85.2024.10.11.08.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:00:15 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Sachin P Bappalige <sachinpb@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v3 1/3] fadump: Refactor and prepare fadump_cma_init for late init
Date: Fri, 11 Oct 2024 20:30:04 +0530
Message-ID: <030b6d46fddac126a6cf7e119bea48055338f0ed.1728658614.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We anyway don't use any return values from fadump_cma_init(). Since
fadump_reserve_mem() from where fadump_cma_init() gets called today,
already has the required checks.
This patch makes this function return type as void. Let's also handle
extra cases like return if fadump_supported is false or dump_active, so
that in later patches we can call fadump_cma_init() separately from
setup_arch().

Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
v2 -> v3: Separated the series into 2 as discussed in v2.
[v2]: https://lore.kernel.org/linuxppc-dev/cover.1728585512.git.ritesh.list@gmail.com/

 arch/powerpc/kernel/fadump.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index a612e7513a4f..162327d66982 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -78,27 +78,23 @@ static struct cma *fadump_cma;
  * But for some reason even if it fails we still have the memory reservation
  * with us and we can still continue doing fadump.
  */
-static int __init fadump_cma_init(void)
+static void __init fadump_cma_init(void)
 {
 	unsigned long long base, size;
 	int rc;

-	if (!fw_dump.fadump_enabled)
-		return 0;
-
+	if (!fw_dump.fadump_supported || !fw_dump.fadump_enabled ||
+			fw_dump.dump_active)
+		return;
 	/*
 	 * Do not use CMA if user has provided fadump=nocma kernel parameter.
-	 * Return 1 to continue with fadump old behaviour.
 	 */
-	if (fw_dump.nocma)
-		return 1;
+	if (fw_dump.nocma || !fw_dump.boot_memory_size)
+		return;

 	base = fw_dump.reserve_dump_area_start;
 	size = fw_dump.boot_memory_size;

-	if (!size)
-		return 0;
-
 	rc = cma_init_reserved_mem(base, size, 0, "fadump_cma", &fadump_cma);
 	if (rc) {
 		pr_err("Failed to init cma area for firmware-assisted dump,%d\n", rc);
@@ -108,7 +104,7 @@ static int __init fadump_cma_init(void)
 		 * blocked from production system usage.  Hence return 1,
 		 * so that we can continue with fadump.
 		 */
-		return 1;
+		return;
 	}

 	/*
@@ -125,10 +121,9 @@ static int __init fadump_cma_init(void)
 		cma_get_size(fadump_cma),
 		(unsigned long)cma_get_base(fadump_cma) >> 20,
 		fw_dump.reserve_dump_area_size);
-	return 1;
 }
 #else
-static int __init fadump_cma_init(void) { return 1; }
+static void __init fadump_cma_init(void) { }
 #endif /* CONFIG_CMA */

 /*
@@ -638,7 +633,7 @@ int __init fadump_reserve_mem(void)
 		pr_info("Reserved %lldMB of memory at %#016llx (System RAM: %lldMB)\n",
 			(size >> 20), base, (memblock_phys_mem_size() >> 20));

-		ret = fadump_cma_init();
+		fadump_cma_init();
 	}

 	return ret;
--
2.46.0


