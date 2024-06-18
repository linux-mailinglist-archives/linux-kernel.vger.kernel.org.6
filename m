Return-Path: <linux-kernel+bounces-219641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FED90D5F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884B2280FB3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CDF156C6B;
	Tue, 18 Jun 2024 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="YzPFJf7R"
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3F015443F;
	Tue, 18 Jun 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721649; cv=none; b=NPhpQOTAjvs9ldGZiBLesIaSt3VLUHhGmMGLFHxDcd+56fLla9z56D2uA85CTWWALB4x2qFCtPqgd5tvuQi8pMQpqYGFQSgw5jG2T3m0SZAwXCxlXVT3JmgsBB5ocNiH/8id5/oUvxvagdFoEXBqrTututqqRNCOU/6xVtkQk+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721649; c=relaxed/simple;
	bh=5sv7yC69OmHnl9wATrVqKLyaJXVEcU0CJKsd3VfL51Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGnGR3qMbpQo/TpqYqlnmqGkTbhgkNo9hYSpwRMmhcOrSHk0GWqY+XoVyvSQf0SHFFmUaLAtOZIuaqQRgzIngN1naILt6QgRBUxXPKblCltzesKxDPktMDakroQrp0YwtSwV2LMu93EEHbzxaqrVIZ72RXV+Z9xKDcLAJo4g47w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=YzPFJf7R; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355087.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IDWdJJ010728;
	Tue, 18 Jun 2024 14:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=bbCv2w4nRPgLR23TBfkseR6
	W0fRU0+Q29X4EO3LvQgk=; b=YzPFJf7R/tL3nNALkgnits8rxljz2OgU6RY5fzk
	AeRVWeGyFGWBcLlns6znE2q+PVWu06Wm8Yp4IlO/5BgLoTimcLZ6+97cMttqZUuB
	vH63gu8rbdihKNQFFbl2+ZgjjvzmUdRK6IUKK4J2pgCeVC7dTdAOqh4FTf36wUI8
	Ygvxknxt96dWmJ7QCNbUbMVJEIlucm9XMlYKaFc115kyAR4z+vQYEthfToO4RXx0
	T9n0PklJ9pKSa6m7OFVqy61LR6CYg/VFZWNWUnDHWMcFKHAqSjGr13xOWyyPe2hv
	WfgIYkVZY8hlkoL0IGfQ4URaJqrroF2maumaN8QDrTy0wUA==
Received: from ilclpfpp01.lenovo.com ([144.188.128.67])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3ysqth6nbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 14:40:13 +0000 (GMT)
Received: from va32lmmrp01.lenovo.com (va32lmmrp01.mot.com [10.62.177.113])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ilclpfpp01.lenovo.com (Postfix) with ESMTPS id 4W3Tth1vDHzcxpn;
	Tue, 18 Jun 2024 14:40:12 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp01.lenovo.com (Postfix) with ESMTPSA id 4W3Ttg5fB5z2VZRs;
	Tue, 18 Jun 2024 14:40:11 +0000 (UTC)
Date: Tue, 18 Jun 2024 09:40:10 -0500
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
Subject: [PATCH v4 1/5] mm: add ARCH_SUPPORTS_NON_LEAF_PTDUMP
Message-ID: <fgvecau2k64sfzvxbs2yxrhzimseogdt2qk4izboywnrtco4od@ezdoxozrt2yj>
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
X-Proofpoint-GUID: blkS0LT6wZdY1-TTwIlfF-qhh7xDcsXA
X-Proofpoint-ORIG-GUID: blkS0LT6wZdY1-TTwIlfF-qhh7xDcsXA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 mlxlogscore=618 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180110

Provide a Kconfig option indicating if note_page can be called for
intermediate page directories during ptdump.

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
 mm/Kconfig.debug |  9 +++++++++
 mm/ptdump.c      | 21 +++++++++++++--------
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index afc72fde0f03..6af5ecfdef93 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -201,6 +201,15 @@ config PTDUMP_DEBUGFS
 
 	  If in doubt, say N.
 
+config ARCH_SUPPORTS_NON_LEAF_PTDUMP
+	bool "Include intermediate directory entries in pagetable dumps"
+	default n
+	help
+	  Enable the inclusion of intermediate page directory entries in calls
+	  to the ptdump API. Once an architecture defines correct ptdump
+	  behavior for PGD, PUD, P4D, and PMD entries, this config can be
+	  selected.
+
 config HAVE_DEBUG_KMEMLEAK
 	bool
 
diff --git a/mm/ptdump.c b/mm/ptdump.c
index 106e1d66e9f9..6180708669fe 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -41,10 +41,11 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
 	if (st->effective_prot)
 		st->effective_prot(st, 0, pgd_val(val));
 
-	if (pgd_leaf(val)) {
+	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_NON_LEAF_PTDUMP) || pgd_leaf(val))
 		st->note_page(st, addr, 0, pgd_val(val));
+
+	if (pgd_leaf(val))
 		walk->action = ACTION_CONTINUE;
-	}
 
 	return 0;
 }
@@ -64,10 +65,11 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
 	if (st->effective_prot)
 		st->effective_prot(st, 1, p4d_val(val));
 
-	if (p4d_leaf(val)) {
+	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_NON_LEAF_PTDUMP) || pgd_leaf(val))
 		st->note_page(st, addr, 1, p4d_val(val));
+
+	if (p4d_leaf(val))
 		walk->action = ACTION_CONTINUE;
-	}
 
 	return 0;
 }
@@ -87,10 +89,11 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long addr,
 	if (st->effective_prot)
 		st->effective_prot(st, 2, pud_val(val));
 
-	if (pud_leaf(val)) {
+	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_NON_LEAF_PTDUMP) || pgd_leaf(val))
 		st->note_page(st, addr, 2, pud_val(val));
+
+	if (pud_leaf(val))
 		walk->action = ACTION_CONTINUE;
-	}
 
 	return 0;
 }
@@ -108,10 +111,12 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned long addr,
 
 	if (st->effective_prot)
 		st->effective_prot(st, 3, pmd_val(val));
-	if (pmd_leaf(val)) {
+
+	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_NON_LEAF_PTDUMP) || pgd_leaf(val))
 		st->note_page(st, addr, 3, pmd_val(val));
+
+	if (pmd_leaf(val))
 		walk->action = ACTION_CONTINUE;
-	}
 
 	return 0;
 }
-- 
2.39.2



