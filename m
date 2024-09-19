Return-Path: <linux-kernel+bounces-333067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6790B97C308
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 04:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7E5283B01
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 02:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE5F39AD5;
	Thu, 19 Sep 2024 02:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2twLYMU"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5E838DDB
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726714644; cv=none; b=GksuiSoCDicn6FSb9h8Ft8H8w8PtcmNBusEb+ddFlLKtYg7PMfwinc/Cpgwl7GYfsX0rId59fegYAa/LNAodC8AMhsx1GU4LgsDidDjZ6zDAV+mz8V2WCwV4flZjYf/NlUgV6xIpbd1V9eE/3zvZ0S0TtWAzCnKWwuwHyFwBiRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726714644; c=relaxed/simple;
	bh=rKAkwnrKqFe/pXWHE++1cg7Hf02Exo4/eTPzv1Uabug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRZFMsv8oL1MF1I+eYgBnxQnwQIzFL4vF8Oh/UMMK+FHyP/d7KQslVbEB3KlUJWJQL8mHtc0klOtB+v6xF72YWPhxRjxaEqVM2FNlaJ0RxHhw11VpkvtJroT8OxINjuU7ZJAh7LyKYFidtOeycgA1YyKNhqfyFpgvcIW4Ap2ffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2twLYMU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2053616fa36so5561715ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726714642; x=1727319442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5daj1tikBz1GmvjDxbc2gCsvgSNJoz/zYutj+6dtSk=;
        b=e2twLYMUXf1t5YMRV5DzxKQDZD9eWUGus+pN/5VjMvLJpPbY1JU3n06vOBcMEam4DB
         fShmrf5w4DgdbkFLZpl0GkqI4bCNP+TTZ+wJAMxTVpsNDBDDw83XQRqPuhCyHkMyIMgq
         RIAeuI88bAMxHkZmdVjSDPiQEbAszy9QSDc/0g4eC6pfM/jXevto+xRgdFcXxPUA4lQx
         YSu1f5npyJYv5nRQCdso2m7OH3yaK1h6w8SM3d5iCu4LMZD0cz2LCgdag+oHGQbsEyjL
         Ta7f3DyYKWRSAEDF35o1TPmT0WPjRxPVhjGuPv8uLb3MmCeuRxjxHYERGovD9Z8VO2RG
         d3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726714642; x=1727319442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5daj1tikBz1GmvjDxbc2gCsvgSNJoz/zYutj+6dtSk=;
        b=vAiC7bp6yNEz/Cd5+ftQ7wlU7ODDe+9jvw+93gW7B7F4oUKDarCCFIfmitLoKIcHhO
         +RQHABC6OfT7DzYlyCxzN3UwSFDmjVd5YN9L5GEoktbwcqMmNB2u2g316ZD+4c/nMEQg
         bJOA1/wZ7MPbZ8VXIq4WiNzBzcx9YuKaMaVyc8DrIosq12/lDraShXwYn+PAEJSxlEYY
         8zW5Cs1zmO5kKEfMuAfQm+P6HvOqjPGydx/U1ckX79eZVXcs232OZcsyFVvrurIaJQUD
         dfowaNwSHMXTf/8i1Te/XibHQ3CGdt/FGQMved1YjnZ04kX9Z383/4npFHiaZmuA+8CX
         4JOA==
X-Forwarded-Encrypted: i=1; AJvYcCUietOpeGAdG2lCoWEQTgjxfgkByZIJSVnSZxIS1f9zl04oTPKBNFkw9z7FrVpQMzkIvZpmylWWsXp3Z7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3VuWUsWfRG+4aAhdBxIccMt4lqsB/pVTRdofJSdKAWclSOnuN
	/sJ1zwCFUdp6PtpV/TGHR6P0WedZU5h0DLUl+SAjf8mY9JsnAz+Mo6amCw==
X-Google-Smtp-Source: AGHT+IE3VeS4AWbgmq58tHFaKEJ3AWgWdI2umfqoY9F5wsipy1rAhwBkftW22XvGMU7l7yJyDOWfeA==
X-Received: by 2002:a17:902:ea0b:b0:206:8c4a:7b73 with SMTP id d9443c01a7336-2076e414901mr370597715ad.50.1726714642162;
        Wed, 18 Sep 2024 19:57:22 -0700 (PDT)
Received: from dw-tp.. ([171.76.85.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d2823sm71389105ad.148.2024.09.18.19.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 19:57:21 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
	Nirjhar Roy <nirjhar@linux.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kasan-dev@googlegroups.com,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 12/13] book3s64/hash: Disable kfence if not early init
Date: Thu, 19 Sep 2024 08:26:10 +0530
Message-ID: <43e00322c775645a251c4526484d5bc61c62850d.1726571179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726571179.git.ritesh.list@gmail.com>
References: <cover.1726571179.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable kfence on book3s64 hash only when early init is enabled.
This is because, kfence could cause the kernel linear map to be mapped
at PAGE_SIZE level instead of 16M (which I guess we don't want).

Also currently there is no way to -
1. Make multiple page size entries for the SLB used for kernel linear
   map.
2. No easy way of getting the hash slot details after the page table
   mapping for kernel linear setup. So even if kfence allocate the
   pool in late init, we won't be able to get the hash slot details in
   kfence linear map.

Thus this patch disables kfence on hash if kfence early init is not
enabled.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 53e6f3a524eb..b6da25719e37 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -410,6 +410,8 @@ static phys_addr_t kfence_pool;
 
 static inline void hash_kfence_alloc_pool(void)
 {
+	if (!kfence_early_init_enabled())
+		goto err;
 
 	// allocate linear map for kfence within RMA region
 	linear_map_kf_hash_count = KFENCE_POOL_SIZE >> PAGE_SHIFT;
@@ -1074,7 +1076,7 @@ static void __init htab_init_page_sizes(void)
 	bool aligned = true;
 	init_hpte_page_sizes();
 
-	if (!debug_pagealloc_enabled_or_kfence()) {
+	if (!debug_pagealloc_enabled() && !kfence_early_init_enabled()) {
 		/*
 		 * Pick a size for the linear mapping. Currently, we only
 		 * support 16M, 1M and 4K which is the default
-- 
2.46.0


