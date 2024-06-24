Return-Path: <linux-kernel+bounces-228002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0ED91599A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C60284B26
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C3F1A2548;
	Mon, 24 Jun 2024 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="z1hvrSNs"
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB971A01B4;
	Mon, 24 Jun 2024 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266892; cv=none; b=p4d6F6ZtD0y8As9aMmLUZuQZjSUmxTWOZO8II03DEl7M4MXHcPkJeZy+WJjMZRVrS+SFqcMKYQ6nSF9cp/WXiYIZNsR3nQBpfTn1vgY89gLGRwve85MwqpGWaaJqTnaP7FBtYg/BWfdk/NMHRDL865BDPp87zSKfgetqYKxtc3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266892; c=relaxed/simple;
	bh=e1mlxflYcobsNxnMgqj/AyP0hSinTpvsQU/K4JMmvRY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sR/fPhjzwnmpBoSjFdei6ConVrei5lEO0epADe/LWBlyuaXH7ZLzHq564Q5sw4IiifLHKvtg43fQPvEHgzxdp9uLUVUU6kYgClKZ48gFEY+RtAiZVo2DUhGu0q7iL8RsPo1MXLfvX3C5XTRnDvoGzon7ggmbLG6CDodwi2VFI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=z1hvrSNs; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355087.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OEu2kd021591;
	Mon, 24 Jun 2024 22:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	DKIM202306; bh=rh6vKXe7UkpTIRLRBOBHrto3kTiRhPZ1UTIBaRKUd9U=; b=z
	1hvrSNs0b2F/HuX0iLBrIxbIWWtprDdu46KpaHdefI4ZusVDvm/PXMqwzPnCfCZx
	fQkP4TcYRrTxxl2klotx6hgUfbd4yUsHQsubAydUmsZxe962Po4UZv/O7YPw/So4
	noyNzNsxSg/NgEwNHsk6tnh1tcxaCA6bZWuxc0Aw/PaSyIh5MOXjBXtPYe28KBmO
	a+7smItmRoU5IeoG3FD4fP14PvgYeip+b1gJ9sLzLEceAQuRv49XXyGE/DXgoNbT
	/y3Pi5DhBpq6humP9+lKCyciEPN1bsP4DeHAv4OT4Umow3JxcbseilC8N18+tt4y
	zeKUiYgU9OajVT2/ETFdg==
Received: from va32lpfpp02.lenovo.com ([104.232.228.22])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3yxbfkaye0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:07:38 +0000 (GMT)
Received: from ilclmmrp02.lenovo.com (ilclmmrp02.mot.com [100.65.83.26])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp02.lenovo.com (Postfix) with ESMTPS id 4W7MX953C0z53xyW;
	Mon, 24 Jun 2024 22:07:37 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4W7MX93R4jz3p6jp;
	Mon, 24 Jun 2024 22:07:37 +0000 (UTC)
Date: Mon, 24 Jun 2024 17:07:36 -0500
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
Subject: [PATCH v5 0/6] ptdump: add intermediate directory support
Message-ID: <2bcb3htsjhepxdybpw2bwot2jnuezl3p5mnj5rhjwgitlsufe7@xzhkyntridw3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: raIFYTMSO8rW7zddTOUtcmSxsmAxGQ34
X-Proofpoint-GUID: raIFYTMSO8rW7zddTOUtcmSxsmAxGQ34
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_19,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406240176

Makes several improvements to (arm64) ptdump debugging, including:

- support note_page on intermediate table entries
- (arm64) print intermediate entries and add an array for their specific
  attributes
- (arm64) bitfield definitions and printing for hierarchical access
  control bits
- (arm64) adjust the entry ranges to remove the implicit exclusive upper
  bound
- (arm64) indent page table by level while maintaining attribute
  alignment
- (arm64) improve documentation clarity, detail, and precision

Thank you again to the maintainers for their review of this patch.

A comparison of the differences in output is provided here:
github.com/maxwell-bland/linux-patch-data/tree/main/ptdump-non-leaf

New in v5:
- Clean up and fix ptdump.c calls to reference right directory level
- Change "pxd" bit specifier for non-leaf directories to tbl_bits,
  introduce a proper delineation between blk_bits and tbl_bits,
  where table entries will no longer print attributes that are
  specific to blocks
- Because we now support printing details on table descriptors, add
  encodings for the ARMv8 APTable bits
- Make attributes uniformly capitalized, make their explanations more
  precise
- Fix typos

v4:
https://lore.kernel.org/all/aw675dhrbplkitj3szjut2vyidsxokogkjj3vi76wl2x4wybtg@5rhk5ca5zpmv/
- Inclusive upper bounds on range specifications
- Splits commit into multiple smaller commits and separates cosmetic,
  documentation, and logic changes
- Updates documentation more sensibly
- Fixes bug in size computation and handles ULONG_MAX bound overflow

v3:
https://lore.kernel.org/all/fik5ys53dbkpkl22o4s7sw7cxi6dqjcpm2f3kno5tyms73jm5y@buo4jsktsnrt/
- Added tabulation to delineate entries
- Fixed formatting issues with mailer and rebased to mm/linus

v2:
https://lore.kernel.org/r/20240423142307.495726312-1-mbland@motorola.com
- Rebased onto linux-next/akpm (the incorrect branch)

v1:
https://lore.kernel.org/all/20240423121820.874441838-1-mbland@motorola.com/

Maxwell Bland (6):
  mm: add ARCH_SUPPORTS_NON_LEAF_PTDUMP
  arm64: add APTable encoding to pagetable defs
  arm64: table descriptor ptdump support
  arm64: indent ptdump by level, aligning attributes
  arm64: exclusive upper bound for ptdump entries
  arm64: add attrs and format to ptdump document

 Documentation/arch/arm64/ptdump.rst    | 131 ++++++++++-----------
 arch/arm64/Kconfig                     |   1 +
 arch/arm64/include/asm/pgtable-hwdef.h |   6 +
 arch/arm64/mm/ptdump.c                 | 150 +++++++++++++++++++------
 mm/Kconfig.debug                       |   8 ++
 mm/ptdump.c                            |  26 +++--
 6 files changed, 214 insertions(+), 108 deletions(-)

-- 
2.43.0



