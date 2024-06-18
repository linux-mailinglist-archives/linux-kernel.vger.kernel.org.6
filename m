Return-Path: <linux-kernel+bounces-219651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2495D90D615
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4871C23090
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61B413A864;
	Tue, 18 Jun 2024 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="USndzeMs"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB2C1386A7;
	Tue, 18 Jun 2024 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721835; cv=none; b=Xt6v7PmG0WH/7rkfPPQU/XT9pYqSwvE8kNJmI97WbtuisbWyyuPrqFfjaujDZjkiZjAfrOEaQZv3ShHD8d/Dif1dKyunarJ0luJp8eIK72Nc9BqYxzeH1r0vgracm9t+R7luZGtoWVVeGthAPyvfE1BFBxsi+ZguH05KcKJm9VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721835; c=relaxed/simple;
	bh=ic/sICyrXBTxrq5NFmDCJcshOhfVAFtQx2NlbzmFRag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mU7FbPBaT8O8c27WuCzZe2yvMYHQBdi2QQMcrwQbXhNkqcKkQ7bauls5lHDtL8/xC9e0fg8urN6OXl07zDKFz5D4RRlG5/F15JAVuwWRWesrHDuJGcD9aRnR+s7glDqGeXNSihbvBO6sF8eAzhhlaW8TA7Jcl/qD73V3IfSHhGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=USndzeMs; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355089.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IC8mw9023649;
	Tue, 18 Jun 2024 14:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=BryO1H2z7osolHTe2vGSsXk
	THPwleLKRIftQnHBqaKE=; b=USndzeMsEq25+QaX3Ooi6L+1b7/go4FVx7lbgMS
	UKBFXnzuPWEIx/BQOjd3pSfkFuOJLWXcruEjy1Hqetz4w7maYBVvAHKPK044KrcB
	Z2/KXQHngSRsSVWtJXwqajBs0G4GHzN3nPRv4Rhuy/CEPX5aLR5nykkDq+R8ep0M
	M14Kslpe03MAEbXj9jq0q0VzS55MskQHc6vL/s7X4WD2ZppRYUoK+HquaK7kaAMt
	YCbjoywNsVP9H7d5R6InN3SjZyagRWmTWq1aBFLOERh5uBDCQ/x2Vi5VlxWhH7yk
	+Qztss8cRQKAew5QqFKmdDILZTQIb4UOkIOAVdT0XAD7DOg==
Received: from va32lpfpp02.lenovo.com ([104.232.228.22])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3ysqgmxqcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 14:43:39 +0000 (GMT)
Received: from va32lmmrp01.lenovo.com (va32lmmrp01.mot.com [10.62.177.113])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp02.lenovo.com (Postfix) with ESMTPS id 4W3Tyg0Cs0z50TkV;
	Tue, 18 Jun 2024 14:43:39 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp01.lenovo.com (Postfix) with ESMTPSA id 4W3Tyf59PGz2VZRs;
	Tue, 18 Jun 2024 14:43:38 +0000 (UTC)
Date: Tue, 18 Jun 2024 09:43:37 -0500
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
Subject: [PATCH v4 5/5] arm64: add attrs and format to ptdump document
Message-ID: <2hhihkaeeyyy3xj22mjdx44zlied2sp4mfewj7y6ffrnakw7cy@3fuds6n7f4ew>
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
X-Proofpoint-GUID: 361aNQGQXUBOEgw_wet2N1UkzcVudRSG
X-Proofpoint-ORIG-GUID: 361aNQGQXUBOEgw_wet2N1UkzcVudRSG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxlogscore=989
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406180110

Update the ptdump content with a precise explanation of the attribute
symbols and the identical-entry coalescing implicit in the code.

Remove unnecessary layout example given the existing cat example,
and opt instead for a precise, clear explantination of address markers,
format, attributes.

Update example to match the new cosmetic and intermediate-directory
printing changes.

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
 Documentation/arch/arm64/ptdump.rst | 126 ++++++++++++++--------------
 1 file changed, 61 insertions(+), 65 deletions(-)

diff --git a/Documentation/arch/arm64/ptdump.rst b/Documentation/arch/arm64/ptdump.rst
index 5dcfc5d7cddf..fee7600dd4d1 100644
--- a/Documentation/arch/arm64/ptdump.rst
+++ b/Documentation/arch/arm64/ptdump.rst
@@ -29,68 +29,64 @@ configurations and mount debugfs::
  mount -t debugfs nodev /sys/kernel/debug
  cat /sys/kernel/debug/kernel_page_tables
 
-On analysing the output of ``cat /sys/kernel/debug/kernel_page_tables``
-one can derive information about the virtual address range of the entry,
-followed by size of the memory region covered by this entry, the
-hierarchical structure of the page tables and finally the attributes
-associated with each page. The page attributes provide information about
-access permissions, execution capability, type of mapping such as leaf
-level PTE or block level PGD, PMD and PUD, and access status of a page
-within the kernel memory. Assessing these attributes can assist in
-understanding the memory layout, access patterns and security
-characteristics of the kernel pages.
-
-Kernel virtual memory layout example::
-
- start address        end address         size             attributes
- +---------------------------------------------------------------------------------------+
- | ---[ Linear Mapping start ]---------------------------------------------------------- |
- | ..................                                                                    |
- | 0xfff0000000000000-0xfff0000000210000  2112K PTE RW NX SHD AF  UXN  MEM/NORMAL-TAGGED |
- | 0xfff0000000210000-0xfff0000001c00000 26560K PTE ro NX SHD AF  UXN  MEM/NORMAL        |
- | ..................                                                                    |
- | ---[ Linear Mapping end ]------------------------------------------------------------ |
- +---------------------------------------------------------------------------------------+
- | ---[ Modules start ]----------------------------------------------------------------- |
- | ..................                                                                    |
- | 0xffff800000000000-0xffff800008000000   128M PTE                                      |
- | ..................                                                                    |
- | ---[ Modules end ]------------------------------------------------------------------- |
- +---------------------------------------------------------------------------------------+
- | ---[ vmalloc() area ]---------------------------------------------------------------- |
- | ..................                                                                    |
- | 0xffff800008010000-0xffff800008200000  1984K PTE ro x  SHD AF       UXN  MEM/NORMAL   |
- | 0xffff800008200000-0xffff800008e00000    12M PTE ro x  SHD AF  CON  UXN  MEM/NORMAL   |
- | ..................                                                                    |
- | ---[ vmalloc() end ]----------------------------------------------------------------- |
- +---------------------------------------------------------------------------------------+
- | ---[ Fixmap start ]------------------------------------------------------------------ |
- | ..................                                                                    |
- | 0xfffffbfffdb80000-0xfffffbfffdb90000    64K PTE ro x  SHD AF  UXN  MEM/NORMAL        |
- | 0xfffffbfffdb90000-0xfffffbfffdba0000    64K PTE ro NX SHD AF  UXN  MEM/NORMAL        |
- | ..................                                                                    |
- | ---[ Fixmap end ]-------------------------------------------------------------------- |
- +---------------------------------------------------------------------------------------+
- | ---[ PCI I/O start ]----------------------------------------------------------------- |
- | ..................                                                                    |
- | 0xfffffbfffe800000-0xfffffbffff800000    16M PTE                                      |
- | ..................                                                                    |
- | ---[ PCI I/O end ]------------------------------------------------------------------- |
- +---------------------------------------------------------------------------------------+
- | ---[ vmemmap start ]----------------------------------------------------------------- |
- | ..................                                                                    |
- | 0xfffffc0002000000-0xfffffc0002200000     2M PTE RW NX SHD AF  UXN  MEM/NORMAL        |
- | 0xfffffc0002200000-0xfffffc0020000000   478M PTE                                      |
- | ..................                                                                    |
- | ---[ vmemmap end ]------------------------------------------------------------------- |
- +---------------------------------------------------------------------------------------+
-
-``cat /sys/kernel/debug/kernel_page_tables`` output::
-
- 0xfff0000001c00000-0xfff0000080000000     2020M PTE  RW NX SHD AF   UXN    MEM/NORMAL-TAGGED
- 0xfff0000080000000-0xfff0000800000000       30G PMD
- 0xfff0000800000000-0xfff0000800700000        7M PTE  RW NX SHD AF   UXN    MEM/NORMAL-TAGGED
- 0xfff0000800700000-0xfff0000800710000       64K PTE  ro NX SHD AF   UXN    MEM/NORMAL-TAGGED
- 0xfff0000800710000-0xfff0000880000000  2089920K PTE  RW NX SHD AF   UXN    MEM/NORMAL-TAGGED
- 0xfff0000880000000-0xfff0040000000000     4062G PMD
- 0xfff0040000000000-0xffff800000000000     3964T PGD
+``/sys/kernel/debug/kernel_page_tables`` provides a line of information
+for each group of page table entries sharing the same attributes and
+type of mapping, i.e. leaf level PTE or block level PGD, PMD, and PUD.
+Assessing these attributes can assist in determining memory layout,
+access patterns and security characteristics of the kernel pages.
+
+Lines are formatted as follows::
+
+ <start_vaddr>-<end_vaddr> <size> <type> <attributes>
+
+Note that the set of attributes, and therefore formatting, is not
+equivalent between leaf and non-leaf entries. For example, PMD entries
+can support the PXNTable permission bit and do not share that same set
+of attributes as leaf level PTE entries.
+
+The following attributes are presently supported::
+
+F		Entry is invalid
+USER		Memory is user mapped
+ro		Memory is read-only
+RW		Memory is read-write
+NX		Memory is privileged execute never
+x               Memory is privileged executable
+SHD		Memory is shared
+AF		Entry accessed flag is set
+NG		Entry Not-Global flag is set
+CON		Entry contiguous bit is set
+UXN		Memory is unprivileged execute never
+GP		Memory supports BTI
+TBL		Entry is a table descriptor
+BLK		Entry is a block descriptor
+NXTbl		Entry's referenced table is PXN
+UXNTbl		Entry's referenced table is unprivileged execute never
+DEVICE/*	Entry is device memory, see ARM reference for types
+MEM/*		Entry is non-device memory, see ARM reference for types
+
+The beginning and end of each region is also delineated by a single line
+tag in the following format::
+
+ ---[ <marker_name> ]---
+
+With supported address markers including the kernel's linear mapping,
+kasan shadow memory, kernel modules memory, vmalloc memory, PCI I/O
+memory, and the kernel's fixmap region.
+
+Example ``cat /sys/kernel/debug/kernel_page_tables`` output::
+
+---[ Linear Mapping start ]---
+0xffff000000000000-0xffff31ffffffffff                  50T PGD
+0xffff320000000000-0xffffffffffffffff                 206T PGD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL
+    0xffff320000000000-0xffff3251ffffffff             328G PUD
+    0xffff325200000000-0xffff32523fffffff               1G PUD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL
+      0xffff325200000000-0xffff3252001fffff             2M PMD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL
+        0xffff325200000000-0xffff3252001fffff           2M PTE       RW NX SHD AF NG     UXN    MEM/NORMAL-TAGGED
+      0xffff325200200000-0xffff3252003fffff             2M PMD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL
+        0xffff325200200000-0xffff32520020ffff          64K PTE       RW NX SHD AF NG     UXN    MEM/NORMAL-TAGGED
+        0xffff325200210000-0xffff3252003fffff        1984K PTE       ro NX SHD AF NG     UXN    MEM/NORMAL
+      0xffff325200400000-0xffff325201dfffff            26M PMD   BLK     ro SHD AF NG     NX UXN                 MEM/NORMAL
+      0xffff325201e00000-0xffff325201ffffff             2M PMD   TBL     RW               x      NXTbl UXNTbl    MEM/NORMAL
+        0xffff325201e00000-0xffff325201e0ffff          64K PTE       ro NX SHD AF NG     UXN    MEM/NORMAL
+        0xffff325201e10000-0xffff325201ffffff        1984K PTE       RW NX SHD AF NG     UXN    MEM/NORMAL-TAGGED
-- 
2.39.2



