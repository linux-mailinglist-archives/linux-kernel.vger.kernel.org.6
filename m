Return-Path: <linux-kernel+bounces-360657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CABA999DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DD60B23543
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA4320A5FD;
	Fri, 11 Oct 2024 07:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1DSu+86"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD4520A5F1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631419; cv=none; b=AAzOysT4FDgc+zJZaTETAsK87O+B6Jk3OFJtEnbN0nnR0+CrxdhvYtW4P8n3uruQfY105Gd3H6pbbuRhxJrDWl+O4BAxZaZDKZ/DBetcETt2bdKQeS3NNHEwGs59uzkMqocTEBf9WlDFGe2WJYIyOjVwQJz3IsxCV5v3pVzivuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631419; c=relaxed/simple;
	bh=pWtMmxnwZ3gTBjNa88ijjlObv61ZuB5OCQXy/tH1fEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHKRbor8VPclq+mWmNGRtty3/a82QV5baKMg5Tj/lP1OK7Ep5l986ebQGwbR/PWhdMstR/b7ePCwduM8TdSKbFsFHvjmFEGr0v8fKUZi8+vL3UXANFg/08HXtbJzBkVJLDPP4ugDQl1FhYxC8ZkfAooRM9xArmKLAp2twosMHcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1DSu+86; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so1478587a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728631417; x=1729236217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0XcJo9JGEctgbuPEWvt7vh5Yz6kEP61gEF6kN7DKNI=;
        b=d1DSu+868BhblXtkQJKbsQar3r92OBDfG1O3H8wsA7S53Aljg9BsNcccAzLJTFTZT7
         BiFIFtWma246Gx1piYjkF/JLg/fuIui4uYXV+uORGh5onl0Ea++1BqhTAhPC8lR9MHOg
         s8E6GVvXlyqvlpGMm/wEn/h2cQJAyVA9ap33mutY5BZXDOBcOJHTF0a11B5b43L3yYaz
         ZSLdfHgZzBCIAMNjctE9pRUBOCsvIcDFW7W6J4p4wQySMls6YMFI6N1duz57Ho5XATp4
         SCbZFExz4J7UuFxXNFFjLiIzUkVpAE4KDgylAdqX0UaXdo3rHe201VMkYXnaIXlOBwtL
         eYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728631417; x=1729236217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0XcJo9JGEctgbuPEWvt7vh5Yz6kEP61gEF6kN7DKNI=;
        b=K82t/RpjelkPPTAvC7wT+uSdKH0GfO2jjWm9F0z08SuC9G54On+2bkcPjj+3GPfDVK
         Pc6IVDbUqSlf36oHt5gvw9pqnM7BUg/97rc+AaqVO8CbRbo4gVnWxvndiAr/GSPqP7co
         G3pBk9nM5AY6njvr9hDwr3BkGl7otDzBonxqRdGQ65bBzmvjwLZrme6oZJSzrBCWh3A/
         HzBFbbxY2tPK4pj9ru1KseHGKHWzu3BRFo+JssEEukLKYnRpYMZ1dMqYtDom4k3tX2qE
         pvRHxHVchvURjlaC/CPv62orG0dMALkWWTtsr6ufa79WnAG4t3zjQbq3vz9t6UpPBgJ7
         v5fg==
X-Forwarded-Encrypted: i=1; AJvYcCXfhnmaPllvqUoDtWWIcmwzr89JNiMBVvf8Se4kR1l9RlkAP9QuuqNc5Q4XZPDxypK0JkHxen+Qw0DPE8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKzA3CA00ChyxoUf9g/bWuPfMNOeWtfujHoDhLCUWm+55z0j/2
	qFS+YD+1FdV3+NDemQpGXx2jRR3VzouLLSAzX7NnjY63M/PIJFC1
X-Google-Smtp-Source: AGHT+IFVJLbjrihstm+z1iQykRd1RHjrMq1OggwLcM33etRABky007jtDtqG43IWWvWSUwC4nwqrng==
X-Received: by 2002:a05:6a21:6b0a:b0:1d6:de67:91ca with SMTP id adf61e73a8af0-1d8bcefd51bmr2327071637.4.1728631416985;
        Fri, 11 Oct 2024 00:23:36 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad335dsm18825155ad.50.2024.10.11.00.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 00:23:36 -0700 (PDT)
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
Subject: [RFC v2 2/4] fadump: Refactor and prepare fadump_cma_init for late init
Date: Fri, 11 Oct 2024 12:53:10 +0530
Message-ID: <079e98d7db3b63bc8a568f4e8c03f2976878ae23.1728585512.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1728585512.git.ritesh.list@gmail.com>
References: <cover.1728585512.git.ritesh.list@gmail.com>
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

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
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


