Return-Path: <linux-kernel+bounces-228012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1900F9159B0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB5E1C20809
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B531A256B;
	Mon, 24 Jun 2024 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="pNJGWhv/"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B1C1A0B09;
	Mon, 24 Jun 2024 22:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267219; cv=none; b=ODYOt9E5pPDfedeoa382qzOIo6Dxl1NYMeFbmNfIUnVd5Pw1W2CGJfNW9ObMEzOuB6FUu1BnI4ZjB3l27/s7SIXj4e+SA6mh1hM5PvgpxiOcQCoQh92D9VJJT3NKedFrEOm4BN+1iCn+SjtTQJUS/hvn8MQgUimvhodjFsojlj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267219; c=relaxed/simple;
	bh=qfoKHvkltiPZQUkNKVK1FlP/mWYHNxQMS3NaKECzfns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaDlAxkAFrv4Ib8uTK1DKtEkDtw2La5+UKZqjmuU6KCn0AYkxcLcmbW9FHGDXg3jyk3F0bXhpyUlOmlgJKwXeAcC158CTSHqaZFS7Iz2xrKbLnxWiNvldsxagCmCk3+6QgALhLXmXeoB8vQFtvSmrTlWf8+iBNKPeL2u6STNNvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=pNJGWhv/; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355091.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OF2NlO000358;
	Mon, 24 Jun 2024 22:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=xzTdj//kQNkI6INZErfuhFK
	fWB5d10It9q/1v3tHJuc=; b=pNJGWhv/zhv7asZpsLEtNusKf0MwwHjM0R79XbK
	uGcztd9K6rkSBNDqLkVkcFRwa5mL3+Ht3hsTAraUUOQDPhnusLLlcDArY5H1CDnF
	VUqushrv0bKJWmPBUS8MxN+CVjXCZOBFl5k++gU/0UTytABC/YU38cFYDoOJ0b+p
	NAAQrdD7u1Lb/AO9oFzMV10XPpcPcmRbFQaIPauSipbp8T0VQ05a8+2SqkvNQ0Gk
	lbsDzBX/8qDbdK5UARdn8Nk8qvpKuLdylEJvtwU3UzKRgTODrWYd6uovyEfjTpo6
	gRQKYPXul7TqcifAkan5C8uXfP6HGtr3h5OORF49gbPqF8w==
Received: from va32lpfpp02.lenovo.com ([104.232.228.22])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3yxbqftx79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:13:18 +0000 (GMT)
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp02.lenovo.com (Postfix) with ESMTPS id 4W7Mfj6Y9Qz53xyW;
	Mon, 24 Jun 2024 22:13:17 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4W7Mfj4N4Fz2VbbV;
	Mon, 24 Jun 2024 22:13:17 +0000 (UTC)
Date: Mon, 24 Jun 2024 17:13:16 -0500
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
Subject: [PATCH v5 3/6] arm64: table descriptor ptdump support
Message-ID: <3z4hwt3fcvscs7zu767vp33tp2mqjor5edfnpgmd2s5p66sg6j@elmhqmeujb5m>
References: <2bcb3htsjhepxdybpw2bwot2jnuezl3p5mnj5rhjwgitlsufe7@xzhkyntridw3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bcb3htsjhepxdybpw2bwot2jnuezl3p5mnj5rhjwgitlsufe7@xzhkyntridw3>
X-Proofpoint-GUID: T8uRFtf4Po_E6S6YwRNJ3KsUezkw0neA
X-Proofpoint-ORIG-GUID: T8uRFtf4Po_E6S6YwRNJ3KsUezkw0neA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_19,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240178

Distinguish between table and block descriptor attribute bitfields,
enable the Kconfig option to print table descriptors and intermediate
page table entries, and support printing of attributes specific to table
descriptors, such as PXNTable.

This is useful when debugging protection systems that leverage
hierarchical access control.

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
 arch/arm64/Kconfig     |   1 +
 arch/arm64/mm/ptdump.c | 142 +++++++++++++++++++++++++++++++----------
 2 files changed, 108 insertions(+), 35 deletions(-)

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
index 6986827e0d64..33ca6d182a6a 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -24,6 +24,7 @@
 #include <asm/memory.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptdump.h>
+#include <asm/pgalloc.h>
 
 
 #define pt_dump_seq_printf(m, fmt, args...)	\
@@ -64,7 +65,7 @@ struct prot_bits {
 	const char	*clear;
 };
 
-static const struct prot_bits pte_bits[] = {
+static const struct prot_bits blk_bits[] = {
 	{
 		.mask	= PTE_VALID,
 		.val	= PTE_VALID,
@@ -78,13 +79,13 @@ static const struct prot_bits pte_bits[] = {
 	}, {
 		.mask	= PTE_RDONLY,
 		.val	= PTE_RDONLY,
-		.set	= "ro",
+		.set	= "RO",
 		.clear	= "RW",
 	}, {
 		.mask	= PTE_PXN,
 		.val	= PTE_PXN,
 		.set	= "NX",
-		.clear	= "x ",
+		.clear	= "X ",
 	}, {
 		.mask	= PTE_SHARED,
 		.val	= PTE_SHARED,
@@ -142,44 +143,101 @@ static const struct prot_bits pte_bits[] = {
 		.set	= "MEM/NORMAL-TAGGED",
 	}
 };
+static const size_t num_blk_bits = ARRAY_SIZE(blk_bits);
+
+static const struct prot_bits tbl_bits[] = {
+	{
+		.mask	= PTE_VALID,
+		.val	= PTE_VALID,
+		.set	= " ",
+		.clear	= "F",
+	}, {
+		.mask	= PMD_TABLE_BIT,
+		.val	= PMD_TABLE_BIT,
+		.set	= "TBL",
+		.clear	= "   ",
+	}, {
+		.mask	= PTE_AF,
+		.val	= PTE_AF,
+		.set	= "AF",
+		.clear	= "  ",
+	}, {
+		.mask	= PMD_TABLE_PXN,
+		.val	= PMD_TABLE_PXN,
+		.set	= "NX",
+		.clear	= "     ",
+	}, {
+		.mask	= PMD_TABLE_UXN,
+		.val	= PMD_TABLE_UXN,
+		.set	= "UXN",
+		.clear	= "      ",
+	}, {
+		.mask	= PMD_TABLE_KERN,
+		.val	= PMD_TABLE_KERN,
+		.set	= "KRN",
+		.clear	= "    "
+	}, {
+		.mask	= PMD_TABLE_PRDONLY,
+		.val	= PMD_TABLE_PRDONLY,
+		.set	= "RO",
+		.clear	= "RW"
+	}
+};
+static const size_t num_tbl_bits = ARRAY_SIZE(tbl_bits);
 
 struct pg_level {
-	const struct prot_bits *bits;
+	const struct prot_bits *blk_bits;
+	const struct prot_bits *tbl_bits;
 	char name[4];
-	int num;
 	u64 mask;
+	unsigned long size;
 };
 
 static struct pg_level pg_level[] __ro_after_init = {
 	{ /* pgd */
-		.name	= "PGD",
-		.bits	= pte_bits,
-		.num	= ARRAY_SIZE(pte_bits),
+		.name		= "PGD",
+		.blk_bits	= blk_bits,
+		.size		= PGDIR_SIZE,
+		.tbl_bits	= tbl_bits
 	}, { /* p4d */
-		.name	= "P4D",
-		.bits	= pte_bits,
-		.num	= ARRAY_SIZE(pte_bits),
+		.name		= "P4D",
+		.blk_bits	= blk_bits,
+		.size		= P4D_SIZE,
+		.tbl_bits	= tbl_bits
 	}, { /* pud */
-		.name	= "PUD",
-		.bits	= pte_bits,
-		.num	= ARRAY_SIZE(pte_bits),
+		.name		= "PUD",
+		.blk_bits	= blk_bits,
+		.size		= PUD_SIZE,
+		.tbl_bits	= tbl_bits
 	}, { /* pmd */
-		.name	= "PMD",
-		.bits	= pte_bits,
-		.num	= ARRAY_SIZE(pte_bits),
+		.name		= "PMD",
+		.blk_bits	= blk_bits,
+		.size		= PMD_SIZE,
+		.tbl_bits	= tbl_bits
 	}, { /* pte */
-		.name	= "PTE",
-		.bits	= pte_bits,
-		.num	= ARRAY_SIZE(pte_bits),
+		.name		= "PTE",
+		.blk_bits	= blk_bits,
+		.size		= PAGE_SIZE,
+		.tbl_bits	= NULL
 	},
 };
 
-static void dump_prot(struct pg_state *st, const struct prot_bits *bits,
-			size_t num)
+static void dump_prot(struct pg_state *st, struct pg_level level)
 {
 	unsigned i;
+	const struct prot_bits *bits;
+	int num_bits;
 
-	for (i = 0; i < num; i++, bits++) {
+	if ((st->current_prot & PTE_TABLE_BIT) == PTE_TABLE_BIT &&
+	    level.tbl_bits) {
+		bits = level.tbl_bits;
+		num_bits = num_tbl_bits;
+	} else {
+		bits = level.blk_bits;
+		num_bits = num_blk_bits;
+	}
+
+	for (i = 0; i < num_bits; i++, bits++) {
 		const char *s;
 
 		if ((st->current_prot & bits->mask) == bits->val)
@@ -251,21 +309,30 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 			note_prot_wx(st, addr);
 		}
 
-		pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ",
-				   st->start_address, addr);
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
 		}
 		pt_dump_seq_printf(st->seq, "%9lu%c %s", delta, *unit,
 				   pg_level[st->level].name);
-		if (st->current_prot && pg_level[st->level].bits)
-			dump_prot(st, pg_level[st->level].bits,
-				  pg_level[st->level].num);
+		if (st->current_prot && pg_level[st->level].blk_bits)
+			dump_prot(st, pg_level[st->level]);
 		pt_dump_seq_puts(st->seq, "\n");
-
 		if (addr >= st->marker[1].start_address) {
 			st->marker++;
 			pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
@@ -311,11 +378,16 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 static void __init ptdump_initialize(void)
 {
 	unsigned i, j;
-
-	for (i = 0; i < ARRAY_SIZE(pg_level); i++)
-		if (pg_level[i].bits)
-			for (j = 0; j < pg_level[i].num; j++)
-				pg_level[i].mask |= pg_level[i].bits[j].mask;
+	struct pg_level *level = pg_level;
+
+	for (i = 0; i < ARRAY_SIZE(pg_level); i++, level++) {
+		if (level->blk_bits)
+			for (j = 0; j < num_blk_bits; j++)
+				level->mask |= level->blk_bits[j].mask;
+		if (level->tbl_bits)
+			for (j = 0; j < num_tbl_bits; j++)
+				level->mask |= level->tbl_bits[j].mask;
+	}
 }
 
 static struct ptdump_info kernel_ptdump_info __ro_after_init = {
-- 
2.43.0



