Return-Path: <linux-kernel+bounces-228003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F47491599C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31081C220DC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2641A0B07;
	Mon, 24 Jun 2024 22:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="zT6JBiLG"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1B213C901;
	Mon, 24 Jun 2024 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267106; cv=none; b=IXkBksxcldm9oPptS0rX2aOFKdWj3ESq/k540UX4C2dBeaotXX1RHwiCet4/z7ySx36qMVTW+oDgljkG4isAxu72nc8cUx+e+hAd1NtL0CzcTbEKA7SN+Ika9XsQI4EX6qKEc1GhfPSKAJq0bSCtLD1Kb8lj7VvUYBTvjVU1ENE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267106; c=relaxed/simple;
	bh=rVLXPjUU65cDFYPGZHSyqE0j6jaP/PBzKrzb3ZaFV1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIS9rPjPKX+8mFDnnTFFasxpwCpq4VNutMZBtUL/dvT3yLk8JB8dJoPDqhINEfvga8w6irZspoVyIW5DTGFJCC+pZuzw1qPMZeVBeZdlGYAP+vOcS5vBA0kFtY03JtGfJnOJBcioSe8E2CTfA2KM0dJTNt+gyWaI6PkJ2pnClqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=zT6JBiLG; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355090.ppops.net [127.0.0.1])
	by m0355090.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 45OEviBT032476;
	Mon, 24 Jun 2024 22:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=UFM48GN3j3TGnx2m6Bd7A0f
	60Mbw6SruFuO0J8syXfM=; b=zT6JBiLGKlW7OsPoAxDU7armuhbSVL4zAti3VIz
	vcbbu4uTtdTgdZuhjEbC6MWV6AabXIk2EHJtQqHZndEl21H0ASABOLFoJoUnVR+7
	XBtU2HQpJh4m0Y9DZpLHM/D103NqBvBDEcMs821PsalH2NBDeaSlHuOebrqxv/tQ
	sYSoUuaDH0Qyj4dpGx5aR6QU+122CzuP4PHvWRoXN9/06km3nwekdAC0+Nf63+jx
	EECjS3rEFp23fORSgPl55HXvDd9E32Qu5j8TvjZC7KBfiEmwMda8zbMSMUQH/7HB
	XgdshYxnT+ZUQ6CsPhoptHDCHJPsbMHO0xVsHw+O4WFfD1w==
Received: from va32lpfpp04.lenovo.com ([104.232.228.24])
	by m0355090.ppops.net (PPS) with ESMTPS id 3yx9xrk9yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:11:14 +0000 (GMT)
Received: from ilclmmrp01.lenovo.com (ilclmmrp01.mot.com [100.65.83.165])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp04.lenovo.com (Postfix) with ESMTPS id 4W7McK3jM7zj9hH;
	Mon, 24 Jun 2024 22:11:13 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp01.lenovo.com (Postfix) with ESMTPSA id 4W7McK1zL8z3nd8L;
	Mon, 24 Jun 2024 22:11:13 +0000 (UTC)
Date: Mon, 24 Jun 2024 17:11:12 -0500
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
Subject: [PATCH v5 1/6] mm: add ARCH_SUPPORTS_NON_LEAF_PTDUMP
Message-ID: <yrgrhwfbl7rnmgekiolmojutaqf24x5zphyrwijakzma5pjhre@3yncjv5tqvar>
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
X-Proofpoint-ORIG-GUID: aFZWZNnXyYrEtj8CTtxn_sgc6qmXaZgc
X-Proofpoint-GUID: aFZWZNnXyYrEtj8CTtxn_sgc6qmXaZgc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_19,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=615 priorityscore=1501
 clxscore=1015 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240177

Provide a Kconfig option indicating if note_page can be called for
intermediate page directories during ptdump.

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
 mm/Kconfig.debug |  8 ++++++++
 mm/ptdump.c      | 26 ++++++++++++++++++--------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index afc72fde0f03..41071539bf9e 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -201,6 +201,14 @@ config PTDUMP_DEBUGFS
 
 	  If in doubt, say N.
 
+config ARCH_SUPPORTS_NON_LEAF_PTDUMP
+	bool "Include intermediate directory entries in pagetable dumps"
+	help
+	  Enable the inclusion of intermediate page directory entries in calls
+	  to the ptdump API. Once an architecture defines correct ptdump
+	  behavior for PGD, PUD, P4D, and PMD entries, this config can be
+	  selected.
+
 config HAVE_DEBUG_KMEMLEAK
 	bool
 
diff --git a/mm/ptdump.c b/mm/ptdump.c
index 106e1d66e9f9..3c8eea232282 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -26,6 +26,11 @@ static inline int note_kasan_page_table(struct mm_walk *walk,
 }
 #endif
 
+static inline bool has_non_leaf_ptdump(void)
+{
+	return IS_ENABLED(CONFIG_ARCH_SUPPORTS_NON_LEAF_PTDUMP);
+}
+
 static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
 			    unsigned long next, struct mm_walk *walk)
 {
@@ -41,10 +46,11 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
 	if (st->effective_prot)
 		st->effective_prot(st, 0, pgd_val(val));
 
-	if (pgd_leaf(val)) {
+	if (has_non_leaf_ptdump() || pgd_leaf(val))
 		st->note_page(st, addr, 0, pgd_val(val));
+
+	if (pgd_leaf(val))
 		walk->action = ACTION_CONTINUE;
-	}
 
 	return 0;
 }
@@ -64,10 +70,11 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
 	if (st->effective_prot)
 		st->effective_prot(st, 1, p4d_val(val));
 
-	if (p4d_leaf(val)) {
+	if (has_non_leaf_ptdump() || p4d_leaf(val))
 		st->note_page(st, addr, 1, p4d_val(val));
+
+	if (p4d_leaf(val))
 		walk->action = ACTION_CONTINUE;
-	}
 
 	return 0;
 }
@@ -87,10 +94,11 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long addr,
 	if (st->effective_prot)
 		st->effective_prot(st, 2, pud_val(val));
 
-	if (pud_leaf(val)) {
+	if (has_non_leaf_ptdump() || pud_leaf(val))
 		st->note_page(st, addr, 2, pud_val(val));
+
+	if (pud_leaf(val))
 		walk->action = ACTION_CONTINUE;
-	}
 
 	return 0;
 }
@@ -108,10 +116,12 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned long addr,
 
 	if (st->effective_prot)
 		st->effective_prot(st, 3, pmd_val(val));
-	if (pmd_leaf(val)) {
+
+	if (has_non_leaf_ptdump() || pmd_leaf(val))
 		st->note_page(st, addr, 3, pmd_val(val));
+
+	if (pmd_leaf(val))
 		walk->action = ACTION_CONTINUE;
-	}
 
 	return 0;
 }
-- 
2.43.0



