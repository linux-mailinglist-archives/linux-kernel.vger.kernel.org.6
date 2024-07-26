Return-Path: <linux-kernel+bounces-263766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8A793DA47
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E12282162
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB18149E15;
	Fri, 26 Jul 2024 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CMuSz0vD"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC5211C83
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722030965; cv=none; b=dpWxkB5AzQq0S63ejM7EEdztrFlhAVRcK89Aidfyk80LSCIgjYCdNYwn2im6S+XR+jGZI1M/V6f/M/0E/Gclzj2i61W2SLwFIUsiGZhimSoVPxcKt/7LASxfRekocy1LcKLhDfWdbRm/YSd08wCQjFsmFEg7H1y6byCvCOjxWSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722030965; c=relaxed/simple;
	bh=YoJiPshgJkcuazzZoSi0oZDPlQBuO7UcJEB+03ez1JY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TRnozuFteTzBN08MsI6XAnd6CUDx/unfavokPQY8i/w6hRNsNC823WxJuvbZNoDglGf2urGSmfO/duXpOp5l9Km91qU00vOXtxSrS3/O0e+WVRFqbTL3JFh2bE6qyXbFHfSuYeO8lzEeCWFxa33CyWPqri37X3B/lw9VYK7ejSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CMuSz0vD; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79f19f19059so70510285a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1722030962; x=1722635762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vYo20ihtC42TqqCCz+7a2VTWK+V1RqG4C3Nqajh31so=;
        b=CMuSz0vDZIcLZ/NRl1z7XIesKPKtiJaKvheIiY2tFS7dBW6Txz6DpnRcV0iCUMaNbg
         nfaf4RonvLSSImuFIwaOTKk9TJiZkKFxMrknao1wqjG+JFnpn8i5zJslJtO+2w/zeoQU
         8mmcwQ745Wob3Q6xG//lmjWJQ43bU8LMRc90YR8XpbzOoGukbOfk60P2m3EP6yahP+w0
         jvhxW1sAsbIHriLU1sVcnAGPhwrUAM9V5pdsFn7+7RwN0JMq14BUwRGMrpJZzgk2j4o/
         gbreM4qG7I9ZqnVJCxzqkB+G/CQUvLJsQgLuoqow+UBQMjeUWxnebcJqG4/IjwnnYBOe
         yQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722030962; x=1722635762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYo20ihtC42TqqCCz+7a2VTWK+V1RqG4C3Nqajh31so=;
        b=lpU7Qs1rK/B9axksUWqz/AqhN3M578PHCliNSFw5aQqA9ZWGsZBm41L1IY7LQrV/DS
         8i3NPshFVzsnozV1g8R503L7xkMYoHsDgVYGG/eHgK6GRiiMwRM7SpPVfXFI0vFhsiw1
         q47vKGeJa5Z1DBfQsTNT43DDpF8Yd6O5k8vX8bdNrm56PPWuAbyJTg0nJt4SW0M1dmeH
         9+uhac4V6v4Z2W+895dDAPjciYWyZCiXxGkVH7BjI5+MmEtl74MVXOAM5eA2dBdlYQYi
         ChUgqKxgalYLPcMXBROT8ZnVdoRGLEWBBqVonVogNO9GsQ5tKwwFM9eOdjWyb5b/SHTz
         72kg==
X-Forwarded-Encrypted: i=1; AJvYcCUwtYD1kSlmTzQHFbmPbNEmk7TbRoMGVs9vrjKcSL1QT24gD3DROo2svQ0PeQj9cgksThbYcxgUHBDUksmRYvGXCaqPYW+v/QPvYiSm
X-Gm-Message-State: AOJu0YwAyXkl8104J515E/OMdmAqZZgWxgxJ7ipp5/c4vVtjXd+qCkaN
	yBapTP2VDmzZY7tggvOInTDLRrkeSL3e8IhzdELA8fcP+NetUo2ZE/9fuUV2ms8=
X-Google-Smtp-Source: AGHT+IFUA/fLnYCWnsDHvFpZtDoWfetBhvPxCxdD6Yap2Sp22Tks1MSFqHnaHQ+QoyS/S2H4JSnUuQ==
X-Received: by 2002:a05:620a:171e:b0:79f:108e:249d with SMTP id af79cd13be357-7a1e52f046cmr145741285a.60.1722030962254;
        Fri, 26 Jul 2024 14:56:02 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7398d3asm215044985a.7.2024.07.26.14.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 14:56:01 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	ying.huang@intel.com,
	dave.jiang@intel.com,
	Jonathan.Cameron@huawei.com,
	horenchuang@bytedance.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	dan.j.williams@intel.com,
	lenb@kernel.org
Subject: [PATCH] acpi/hmat,mm/memtier: always register hmat adist calculation callback
Date: Fri, 26 Jul 2024 17:55:48 -0400
Message-ID: <20240726215548.10653-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the event that hmat data is not available for the DRAM tier,
or if it is invalid (bandwidth or latency is 0), we can still register
a callback to calculate the abstract distance for non-cpu nodes
and simply assign it a different tier manually.

In the case where DRAM HMAT values are missing or not sane we
manually assign adist=(MEMTIER_ADISTANCE_DRAM + MEMTIER_CHUNK_SIZE).

If the HMAT data for the non-cpu tier is invalid (e.g. bw = 0), we
cannot reasonable determine where to place the tier, so it will default
to MEMTIER_ADISTANCE_DRAM (which is the existing behavior).

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/acpi/numa/hmat.c |  6 ++++--
 mm/memory-tiers.c        | 10 ++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 2c8ccc91ebe6..1642d2bd83b5 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -1080,8 +1080,10 @@ static __init int hmat_init(void)
 	if (hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI))
 		goto out_put;
 
-	if (!hmat_set_default_dram_perf())
-		register_mt_adistance_algorithm(&hmat_adist_nb);
+	if (hmat_set_default_dram_perf())
+		pr_notice("Failed to set default dram perf\n");
+
+	register_mt_adistance_algorithm(&hmat_adist_nb);
 
 	return 0;
 out_put:
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 6632102bd5c9..43bd508938ae 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -765,8 +765,14 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
 	    perf->read_bandwidth + perf->write_bandwidth == 0)
 		return -EINVAL;
 
-	if (default_dram_perf_ref_nid == NUMA_NO_NODE)
-		return -ENOENT;
+	/*
+	 * If the DRAM tier did not have valid HMAT data, we can instead just
+	 * assume that the non-cpu numa nodes are 1 tier below cpu nodes
+	 */
+	if (default_dram_perf_ref_nid == NUMA_NO_NODE) {
+		*adist = MEMTIER_ADISTANCE_DRAM + MEMTIER_CHUNK_SIZE;
+		return 0;
+	}
 
 	/*
 	 * The abstract distance of a memory node is in direct proportion to
-- 
2.43.0


