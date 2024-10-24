Return-Path: <linux-kernel+bounces-380297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E689AEBF1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D08281D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D333C1F80BA;
	Thu, 24 Oct 2024 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nD4Ef7jv"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8E61F8188
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787141; cv=none; b=H+PvsiWMDk6hCLKPBWBc32e5ooiJk6IpXeICQDqn2fee9uxGcwtp8b723OGMAfxgZPuwv8NfSO2YjPHIuLTvs8in2xVY/UVjoOPVSoWFfCn0op+DJwqylL608qiHE4kTFmK3j3fZiCKFLJTg4oQFsJHlq3AEtDXCEAkSdTGX/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787141; c=relaxed/simple;
	bh=NReTaU/WrjVg9zxFq1KyTmKHkdtnfCKu2lqDSGFGRO0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pg+VJFpIkeq//tphPLztTfrw/D2RmRV5Eyi4puOw0UOsvxyD2qyhCNqXyBoZSfjQOH2JcR/1DIPZ424h8UW/xGdLetahEo2RRWz1kxBJORNOtftb5Lvtzdm5oLdWCtTKQcHUq0uhYiBFNASzNPntDUx4dvABQaBYZDMhkqdye4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nD4Ef7jv; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4315d98a873so8077635e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729787137; x=1730391937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=guhxqgoLzafkK+NdizG3et2iwgEsPQIVl8nGkP9yeqs=;
        b=nD4Ef7jvot1n+xOI+gUJ7u9IsheuvCLOgqSnM+kmbK33TId7EAMzVoD+asGkprWPID
         /UKdjRx8uy30Fcj1bGdx5CUCQoWjPBSceXrjsTXZUwOzu1HPyUJHcoc66L3nv9cUktHa
         QCo9zvXScK2OeqlxlAnGJ01/hz/vWwj4YcELKKP4BJ1n7r7+ehNpWV7pa99As620lnt4
         QFnKDBkNF0X0BiQslaNRGoSB9H2e0SBNQpVDyA7ERbWTUvCY+O3fyAIMmpKvySVJMjA2
         9WwpNu/KHcojtTu84lGAAb+cTqf4iv1u2FY0FKSvkAPIrezUVV2A97z/v4zX48DnOqNs
         GuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729787137; x=1730391937;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=guhxqgoLzafkK+NdizG3et2iwgEsPQIVl8nGkP9yeqs=;
        b=vAKN7yHgH1Fy0QvdLeS+Bg3cvhZhd0gG+Nbiw4HEtmaI0K816s7dv6+n/ryQB2SkIi
         GPEyizSHTUwpskcKDwhT8DJJOYShITBcdYnT72iC96KfEN7mN6gJxVSzOrHEUxgBDHju
         YD74hutt/+K0zHUk/5DUokei8UCOg7bD0K26i+Txl2fTS1CKqIp5fh4j8Wk+BIIs9iN9
         NpzIDRXkro0tWaGqd+cuCrtK5XxQbfCAaEo0OTTz90p1F8RB6UJqbuxHhDUZj64IwaLX
         5AbmpFMB5wzdtI93S5dHoFANsMylh8UknaUv0jr3p9YL/ZZewA5F7cIY2SpLugtLeKFj
         hscA==
X-Gm-Message-State: AOJu0Yzm181DurL/dk812r8x2DDk1Y6xZIgoUUD0VZSkYBkfkGeRnaHz
	F+rW/LMf93IoyJZ8zi1BmhhpRkZPHoY/wnsqGkvCy+FWCMlME5gO2S2E19GNddsvdG/YIllwqgZ
	HwTdUtnFKPl3RUvRupzHgOxlEB8gbEQjsPY8wC5ZXMgop/dR+Dd1jzaN2qKIFk9ftW8MdmAMC2a
	x/NAnGe2gNW8w8+Vg4yaNpyU3mXDfh81UMqanrnQ3FvyjMDbl9/84=
X-Google-Smtp-Source: AGHT+IErwzIVqMN+PjdLzUqLsxxxqsZOGGGMsnJi1kecA66UnaTLfYW8QeE2ETnjOUdJ0m1UCN25TK06TL0pAg==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a7b:cb52:0:b0:430:5759:867e with SMTP id
 5b1f17b1804b1-4318c76eba5mr266065e9.7.1729787137481; Thu, 24 Oct 2024
 09:25:37 -0700 (PDT)
Date: Thu, 24 Oct 2024 16:25:15 +0000
In-Reply-To: <20241024162516.2005652-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024162516.2005652-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241024162516.2005652-2-smostafa@google.com>
Subject: [PATCH 1/2] iommu/io-pgtable-arm: Fix stage-2 map/umap for
 concatenated tables
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When calculating the max number of entries in a table, Where
RM_LPAE_LVL_IDX() understands the concatenated pgds and can return
an index spanning more than one concatenated table (for ex for 4K
page size > 512).
But then, max_entries is calculated as follows:
max_entries =3D ARM_LPAE_PTES_PER_TABLE(data) - map_idx_start;

This leads to a negative index in the page table, where for:
- map: do nothing (no OOB) as fortunately all comparisons are signed,
  but it would return a negative mapped value.

- unmap: it would leak any child tables as it skips the loop over
  =E2=80=9C__arm_lpae_free_pgtable=E2=80=9D

This bug only happens when map/unmap is requested with a page size
equals to the first level of the concatenated table (for 40 bits input
and 4K granule would be 1GB) and can be triggered from userspace with
VFIO, by choosing a VM IPA in a concatenated table > 0 and using
huge pages to mmap with the first level size.

For example, I was able to reproduce it with the following command
with mainline linux and mainline kvmtool:

./lkvm run --irqchip gicv3 -k {$KERNEL} -p "earlycon" -d {$ROOTFS}  --force=
-pci -c \
`nproc` --debug -m 4096@525312 --vfio-pci 0000:00:03.0  --hugetlbfs  /hugep=
ages

Where huge pages with 1GB would be used and using IPA in the second table
(512GB for 40 bits SMMU and 4K granule).

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.=
c
index 0e67f1721a3d..3ecbc024e440 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -199,6 +199,17 @@ static phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
 	return (paddr | (paddr << (48 - 12))) & (ARM_LPAE_PTE_ADDR_MASK << 4);
 }
=20
+/*
+ * Using an index returned from ARM_LPAE_PGD_IDX(), which can point to
+ * concatenated PGD concatenated, get the max entries of a that table.
+ */
+static inline int arm_lpae_max_entries(int i, struct arm_lpae_io_pgtable *=
data)
+{
+	int ptes_per_table =3D ARM_LPAE_PTES_PER_TABLE(data);
+
+	return ptes_per_table - (i & (ptes_per_table - 1));
+}
+
 static bool selftest_running =3D false;
=20
 static dma_addr_t __arm_lpae_dma_addr(void *pages)
@@ -390,7 +401,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *d=
ata, unsigned long iova,
=20
 	/* If we can install a leaf entry at this level, then do so */
 	if (size =3D=3D block_size) {
-		max_entries =3D ARM_LPAE_PTES_PER_TABLE(data) - map_idx_start;
+		max_entries =3D arm_lpae_max_entries(map_idx_start, data);
 		num_entries =3D min_t(int, pgcount, max_entries);
 		ret =3D arm_lpae_init_pte(data, iova, paddr, prot, lvl, num_entries, pte=
p);
 		if (!ret)
@@ -592,7 +603,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_=
io_pgtable *data,
=20
 	if (size =3D=3D split_sz) {
 		unmap_idx_start =3D ARM_LPAE_LVL_IDX(iova, lvl, data);
-		max_entries =3D ptes_per_table - unmap_idx_start;
+		max_entries =3D arm_lpae_max_entries(unmap_idx_start, data);
 		num_entries =3D min_t(int, pgcount, max_entries);
 	}
=20
@@ -650,7 +661,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtab=
le *data,
=20
 	/* If the size matches this level, we're in the right place */
 	if (size =3D=3D ARM_LPAE_BLOCK_SIZE(lvl, data)) {
-		max_entries =3D ARM_LPAE_PTES_PER_TABLE(data) - unmap_idx_start;
+		max_entries =3D arm_lpae_max_entries(unmap_idx_start, data);
 		num_entries =3D min_t(int, pgcount, max_entries);
=20
 		/* Find and handle non-leaf entries */
--=20
2.47.0.105.g07ac214952-goog


