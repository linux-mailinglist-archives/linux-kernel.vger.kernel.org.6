Return-Path: <linux-kernel+bounces-228015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196E29159B6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39B7282ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9CB1A0708;
	Mon, 24 Jun 2024 22:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="PrP3P5Sv"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7FD17BCC;
	Mon, 24 Jun 2024 22:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267399; cv=none; b=YWbX81oHK/n/9fjFXem7GZWOHHEO+7O+P/SAwaKIG0cf90TBh4jYqyb10ODwmKBxEMEF1p51AyIAZL13abrX2F/tcDS/8dWp2l0MOYd41BzYfRmsHOVr9QvLX1NBJfQUqpf550hQ/gtXAzI6UwEO9TrwP1P66fpCos644KIePxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267399; c=relaxed/simple;
	bh=7kJ6ORtXiv120dUdsmz1KTqJvK5XWMRf40PXfoe2VVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbCQIEfN6HnO58qC69FvHr8z0dGNp4lRkSIg8bm1PKeuzjfpDc6bAHChf5WmEkVzyjiTbIU8vfBSW7ksM8Pa+PyWsZ9Dk4HzF+wBdzbgzSvrvuBlPLOl08aZSLbp6gFiydE8TAVxgwldPHlyOHHvnYm5jdPMSMFO6aRKqoLWoIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=PrP3P5Sv; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355092.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ODoKln017548;
	Mon, 24 Jun 2024 22:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=gZCJlBi8DE484qacbTVY678
	Pgp4eLQRFW/HaquAhFOI=; b=PrP3P5SvKBxjv7d7dvpcx+IB8ke1xj/q6kCyrbB
	NFdYlcqBk++M7o8c8bLmiJlXeUhfwx6aIWUB91CJ68q27nl4pgnY+OGjFbu3OzlT
	Y/aKwz7UmZv5l67K48PGzIEDanWo+QSeRPJtGUN1VtBt+jCNnQc0SHo9kmNgk3Zp
	YW8Dr5Qq7ad7HlaoObJnlddNowPQYNCWi71sKhmNohIzikzgW/WFr8i5btXERFHD
	wrLdOjBqzCaeOKQF2rFjy/nxVp4Z+KmfV9FE+vvbM5837Ms7/yPVOGZ0sQQ4KYhh
	ODhz7n32+PBeGCUL7zlFye5SmFECzY2QoN+6ikBGTcoH+JQ==
Received: from va32lpfpp01.lenovo.com ([104.232.228.21])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3yxcxf2vqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:16:22 +0000 (GMT)
Received: from ilclmmrp01.lenovo.com (ilclmmrp01.mot.com [100.65.83.165])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp01.lenovo.com (Postfix) with ESMTPS id 4W7MkF4tV5zhWB3;
	Mon, 24 Jun 2024 22:16:21 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp01.lenovo.com (Postfix) with ESMTPSA id 4W7MkF39R6z3nd8L;
	Mon, 24 Jun 2024 22:16:21 +0000 (UTC)
Date: Mon, 24 Jun 2024 17:16:20 -0500
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
Subject: [PATCH v5 6/6] arm64: add attrs and format to ptdump document
Message-ID: <uz7euxemnah4fhoyj7brop67mqjzzkm6tctf5s7alkhvrmhkgw@ziq4h7kzsdvz>
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
X-Proofpoint-GUID: LlMeeVVbZ8SJ4SyDN-hV-5CbZZYHi3lJ
X-Proofpoint-ORIG-GUID: LlMeeVVbZ8SJ4SyDN-hV-5CbZZYHi3lJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_19,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=896
 impostorscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240178

Update the ptdump content with a precise explanation of the attribute
symbols and the coalescing of identical entries implicit in the code.

Remove unnecessary layout example given the existing cat example,
and opt instead for a precise, clear explanation of address markers,
format, attributes.

Update example to match the new cosmetic and intermediate-directory
printing changes.

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
 Documentation/arch/arm64/ptdump.rst | 126 ++++++++++++++--------------
 1 file changed, 61 insertions(+), 65 deletions(-)

diff --git a/Documentation/arch/arm64/ptdump.rst b/Documentation/arch/arm64/ptdump.rst
index 5dcfc5d7cddf..785b96ab2e89 100644
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
+type of mapping, i.e. page descriptor PTE or table descriptor PGD, PMD,
+and PUD.  Assessing these attributes can assist in determining memory
+layout, access patterns and security characteristics of the kernel
+pages.
+
+Lines are formatted as follows::
+
+ <start_vaddr>-<end_vaddr> <size> <type> <attributes>
+
+Note that the set of attributes, and therefore formatting, is not
+equivalent between block (or page) and table descriptor entries. For
+example, PMD table descriptors can support the PXNTable permission bit
+and do not share that same set of attributes as PTEs.
+
+The following attributes are presently supported::
+
+F		Entry is invalid
+RO		Memory is read-only
+RW		Memory is read-write
+X		Memory is privileged executable
+NX		Memory is privileged execute never
+UXN		Memory is unprivileged execute never
+USR		Memory is unprivileged accessible
+KRN		Memory is unprivileged inaccessible (e.g. APTable bits)
+SHD		Memory is shared
+AF		Entry accessed flag is set
+NG		Entry Not-Global flag is set
+CON		Entry contiguous bit is set
+GP		Page is guarded with branch target integrity protection
+TBL		Entry is a table descriptor
+BLK		Entry is a block descriptor
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
+ ---[ Linear Mapping start ]---
+ 0xffff000000000000-0xffff1affffffffff                  27T PGD
+ 0xffff1b0000000000-0xffffffffffffffff                 229T PGD   TBL    NX UXN      RW
+     0xffff1b0000000000-0xffff1b397fffffff             230G PUD
+     0xffff1b3980000000-0xffff1b39bfffffff               1G PUD   TBL    NX UXN      RW
+       0xffff1b3980000000-0xffff1b39801fffff             2M PMD   TBL    NX UXN      RW
+         0xffff1b3980000000-0xffff1b39801fffff           2M PTE       RW NX SHD AF NG         UXN    MEM/NORMAL-TAGGED
+       0xffff1b3980200000-0xffff1b39803fffff             2M PMD   TBL    NX UXN      RW
+         0xffff1b3980200000-0xffff1b398020ffff          64K PTE       RW NX SHD AF NG         UXN    MEM/NORMAL-TAGGED
+         0xffff1b3980210000-0xffff1b39803fffff        1984K PTE       RO NX SHD AF NG         UXN    MEM/NORMAL
+       0xffff1b3980400000-0xffff1b3981dfffff            26M PMD       RO NX SHD AF NG     BLK UXN    MEM/NORMAL
+       0xffff1b3981e00000-0xffff1b3981ffffff             2M PMD   TBL    NX UXN      RW
+         0xffff1b3981e00000-0xffff1b3981e1ffff         128K PTE       RO NX SHD AF NG         UXN    MEM/NORMAL
+         0xffff1b3981e20000-0xffff1b3981ffffff        1920K PTE       RW NX SHD AF NG         UXN    MEM/NORMAL-TAGGED
-- 
2.43.0



