Return-Path: <linux-kernel+bounces-219642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F2A90D75D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BB74B35B68
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012CC157481;
	Tue, 18 Jun 2024 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="Nj+tV39+"
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C58156F37;
	Tue, 18 Jun 2024 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721680; cv=none; b=XTbWEyNZe1UQN4jstFKKhXAzOjnhMkKjMvDQKIRSulltSZezDm/LXMXC4dhvAsjfHaU7gvJ1JTpI1KQ9kfLamnuQKA7VOXGakFkMMHYtZqX/kmto7+tuMEBo3FoqneGtnCkWbCtSelPrZ3k2VMriX9GzwwtDGkkPEbgsVWkRrfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721680; c=relaxed/simple;
	bh=CPQMyVIALDnBNqUQ2z8TZ/GHAz+p3phcifIvMGM9M0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUR5SnAHo65fe2wv9TphvqFqb1SMvmGn6TY+8vWy+RHVNFP77dew3GMGSbPsGdN+fnwh9XVZh0fiWntPY/yfocEm+g7mq4G7d2mBZ9YKOCEktbB34KN+3aKw9uLaobn8yGqrgENigNDnS1evdK52Z/crmcmbZ7uBxxm4XfAX0Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=Nj+tV39+; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355085.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IEd3JS008967;
	Tue, 18 Jun 2024 14:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=ZiQ3f8xQzS9FA6BEFRuceTM
	lsKV6Mo9WAxwHVPxN0eM=; b=Nj+tV39+SFug10BoWEz7cWUgnPrs8dviGW7cYFp
	rc027YAqKCrb2WHJt+ThlffX5PYRm+OOfe0W3OPjbymBFOhAtI0WxunWcy4QQn+E
	AFPOTjwIjDPEsNZRV5XfBP9Ny4zIBGMcfELvz8Ay0TjZI9NJKnDtSuu2r+sbQTS9
	HVvk3qcC6+GpXP6HAc6XcrGIR8yV/plDi3IIGpskek1twpsq633RplwxmH7tjbJA
	PJNTjIcJRbB0EC7k7bGMOKdunPR8k1ui+QPJnCH0jNuanamr94vooF6oBPIFapRn
	x/ofVlZu1aEh58PZTC5jvZBcR7HrAj2A9AbpyC+vIfqPuhg==
Received: from va32lpfpp02.lenovo.com ([104.232.228.22])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3yssffxjhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 14:40:51 +0000 (GMT)
Received: from ilclmmrp02.lenovo.com (ilclmmrp02.mot.com [100.65.83.26])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp02.lenovo.com (Postfix) with ESMTPS id 4W3TvQ06ymz50TkT;
	Tue, 18 Jun 2024 14:40:50 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4W3TvP5ry1z3p6jp;
	Tue, 18 Jun 2024 14:40:49 +0000 (UTC)
Date: Tue, 18 Jun 2024 09:40:48 -0500
From: Maxwell Bland <mbland@motorola.com>
To: linux-mm@kvack.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Maxwell Bland <mbland@motorola.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] arm64: non leaf ptdump support
Message-ID: <san7zg5rohy7q2oep2kx6awf6gltpuv2f4xlfljw5ezxqydfkv@zkd4k4udcezz>
References: <aw675dhrbplkitj3szjut2vyidsxokogkjj3vi76wl2x4wybtg@5rhk5ca5zpmv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aw675dhrbplkitj3szjut2vyidsxokogkjj3vi76wl2x4wybtg@5rhk5ca5zpmv>
X-Proofpoint-ORIG-GUID: kmBwrD3JLnyF3RFV3h1ScHXshTVxVoVj
X-Proofpoint-GUID: kmBwrD3JLnyF3RFV3h1ScHXshTVxVoVj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxscore=0 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=914 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180110

Separate the pte_bits used in ptdump from pxd_bits used by pmd, p4d,
pud, and pgd descriptors, thereby adding support for printing key
intermediate directory protection bits, such as PXNTable, and enable the
associated support Kconfig option.

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
 arch/arm64/Kconfig     |   1 +
 arch/arm64/mm/ptdump.c | 140 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 125 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5d91259ee7b5..f4c3290160db 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -98,6 +98,7 @@ config ARM64
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
 	select ARCH_SUPPORTS_PER_VMA_LOCK
+	select ARCH_SUPPORTS_NON_LEAF_PTDUMP
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
 	select ARCH_WANT_DEFAULT_BPF_JIT
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 6986827e0d64..8f0b459c13ed 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -24,6 +24,7 @@
 #include <asm/memory.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptdump.h>
+#include <asm/pgalloc.h>
 
 
 #define pt_dump_seq_printf(m, fmt, args...)	\
@@ -105,11 +106,6 @@ static const struct prot_bits pte_bits[] = {
 		.val	= PTE_CONT,
 		.set	= "CON",
 		.clear	= "   ",
-	}, {
-		.mask	= PTE_TABLE_BIT,
-		.val	= PTE_TABLE_BIT,
-		.set	= "   ",
-		.clear	= "BLK",
 	}, {
 		.mask	= PTE_UXN,
 		.val	= PTE_UXN,
@@ -143,34 +139,129 @@ static const struct prot_bits pte_bits[] = {
 	}
 };
 
+static const struct prot_bits pxd_bits[] = {
+	{
+		.mask	= PMD_SECT_VALID,
+		.val	= PMD_SECT_VALID,
+		.set	= " ",
+		.clear	= "F",
+	}, {
+		.mask	= PMD_TABLE_BIT,
+		.val	= PMD_TABLE_BIT,
+		.set	= "TBL",
+		.clear	= "BLK",
+	}, {
+		.mask	= PMD_SECT_USER,
+		.val	= PMD_SECT_USER,
+		.set	= "USR",
+		.clear	= "   ",
+	}, {
+		.mask	= PMD_SECT_RDONLY,
+		.val	= PMD_SECT_RDONLY,
+		.set	= "ro",
+		.clear	= "RW",
+	}, {
+		.mask	= PMD_SECT_S,
+		.val	= PMD_SECT_S,
+		.set	= "SHD",
+		.clear	= "   ",
+	}, {
+		.mask	= PMD_SECT_AF,
+		.val	= PMD_SECT_AF,
+		.set	= "AF",
+		.clear	= "  ",
+	}, {
+		.mask	= PMD_SECT_NG,
+		.val	= PMD_SECT_NG,
+		.set	= "NG",
+		.clear	= "  ",
+	}, {
+		.mask	= PMD_SECT_CONT,
+		.val	= PMD_SECT_CONT,
+		.set	= "CON",
+		.clear	= "   ",
+	}, {
+		.mask	= PMD_SECT_PXN,
+		.val	= PMD_SECT_PXN,
+		.set	= "NX",
+		.clear	= "x ",
+	}, {
+		.mask	= PMD_SECT_UXN,
+		.val	= PMD_SECT_UXN,
+		.set	= "UXN",
+		.clear	= "   ",
+	}, {
+		.mask	= PMD_TABLE_PXN,
+		.val	= PMD_TABLE_PXN,
+		.set	= "NXTbl",
+		.clear	= "     ",
+	}, {
+		.mask	= PMD_TABLE_UXN,
+		.val	= PMD_TABLE_UXN,
+		.set	= "UXNTbl",
+		.clear	= "      ",
+	}, {
+		.mask	= PTE_GP,
+		.val	= PTE_GP,
+		.set	= "GP",
+		.clear	= "  ",
+	}, {
+		.mask	= PMD_ATTRINDX_MASK,
+		.val	= PMD_ATTRINDX(MT_DEVICE_nGnRnE),
+		.set	= "DEVICE/nGnRnE",
+	}, {
+		.mask	= PMD_ATTRINDX_MASK,
+		.val	= PMD_ATTRINDX(MT_DEVICE_nGnRE),
+		.set	= "DEVICE/nGnRE",
+	}, {
+		.mask	= PMD_ATTRINDX_MASK,
+		.val	= PMD_ATTRINDX(MT_NORMAL_NC),
+		.set	= "MEM/NORMAL-NC",
+	}, {
+		.mask	= PMD_ATTRINDX_MASK,
+		.val	= PMD_ATTRINDX(MT_NORMAL),
+		.set	= "MEM/NORMAL",
+	}, {
+		.mask	= PMD_ATTRINDX_MASK,
+		.val	= PMD_ATTRINDX(MT_NORMAL_TAGGED),
+		.set	= "MEM/NORMAL-TAGGED",
+	}
+};
+
 struct pg_level {
 	const struct prot_bits *bits;
 	char name[4];
 	int num;
 	u64 mask;
+	unsigned long size;
 };
 
 static struct pg_level pg_level[] __ro_after_init = {
 	{ /* pgd */
 		.name	= "PGD",
-		.bits	= pte_bits,
-		.num	= ARRAY_SIZE(pte_bits),
+		.bits	= pxd_bits,
+		.num	= ARRAY_SIZE(pxd_bits),
+		.size	= PGDIR_SIZE,
 	}, { /* p4d */
 		.name	= "P4D",
-		.bits	= pte_bits,
-		.num	= ARRAY_SIZE(pte_bits),
+		.bits	= pxd_bits,
+		.num	= ARRAY_SIZE(pxd_bits),
+		.size	= P4D_SIZE,
 	}, { /* pud */
 		.name	= "PUD",
-		.bits	= pte_bits,
-		.num	= ARRAY_SIZE(pte_bits),
+		.bits	= pxd_bits,
+		.num	= ARRAY_SIZE(pxd_bits),
+		.size	= PUD_SIZE,
 	}, { /* pmd */
 		.name	= "PMD",
-		.bits	= pte_bits,
-		.num	= ARRAY_SIZE(pte_bits),
+		.bits	= pxd_bits,
+		.num	= ARRAY_SIZE(pxd_bits),
+		.size	= PMD_SIZE,
 	}, { /* pte */
 		.name	= "PTE",
 		.bits	= pte_bits,
 		.num	= ARRAY_SIZE(pte_bits),
+		.size	= PAGE_SIZE
 	},
 };
 
@@ -251,10 +342,27 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 			note_prot_wx(st, addr);
 		}
 
-		pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ",
-				   st->start_address, addr);
+		/*
+		 * Non-leaf entries use a fixed size for their range
+		 * specification, whereas leaf entries are grouped by
+		 * attributes and may not have a range larger than the type
+		 * specifier.
+		 */
+		if (st->start_address == addr) {
+			if (check_add_overflow(addr, pg_level[st->level].size,
+					       &delta))
+				delta = ULONG_MAX - addr + 1;
+			else
+				delta = pg_level[st->level].size;
+			pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ",
+					   addr, addr + delta);
+		} else {
+			delta = (addr - st->start_address);
+			pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ",
+					   st->start_address, addr);
+		}
 
-		delta = (addr - st->start_address) >> 10;
+		delta >>= 10;
 		while (!(delta & 1023) && unit[1]) {
 			delta >>= 10;
 			unit++;
-- 
2.39.2



