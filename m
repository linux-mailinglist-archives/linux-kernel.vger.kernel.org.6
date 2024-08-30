Return-Path: <linux-kernel+bounces-308345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F86A965A97
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAB19B22021
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D2916D9C0;
	Fri, 30 Aug 2024 08:42:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6086C16726E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007328; cv=none; b=WEHQR999irTyiZWTAvc+0+BTvl/tYlrunBtLdRuE6XrStqJt+Hiat7eVCXCw1GT+kiOgxUnXc4ZAFA0zPjYygnREvMhx3MoPfHz7t2meG+dH+FTJvXFE0QyoPhw7hl0BFdrsd1YLpItSOqIN1NaMJHzSZTHXnF5g1KGgrAXASO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007328; c=relaxed/simple;
	bh=zKiDMChZzJpexzuwsEGk3WtO72I9rPwDdbKxGlMS+Pk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hKId9d2o4uNC8a0Gu/DVY2blgZiDlPgxwmDCE8joofj2Ih2SZve0hifa93bG87Tc8/1L5vc5P8Zgq+AyM0gjf7jMBsdkfz3DZ6qxFxlPFIo0U5BjHZDGId/rZL9Dm2hiAWvdFEK+F3R022JrAWrYjGo9ZIAQsVR6FnXRkUvF4v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD1F71063;
	Fri, 30 Aug 2024 01:42:31 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.40.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2286A3F762;
	Fri, 30 Aug 2024 01:41:56 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	willy@infradead.org,
	kirill.shutemov@linux.intel.com
Cc: ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	vbabka@suse.cz,
	mhocko@suse.com,
	apopple@nvidia.com,
	dave.hansen@linux.intel.com,
	will@kernel.org,
	baohua@kernel.org,
	jack@suse.cz,
	mark.rutland@arm.com,
	hughd@google.com,
	aneesh.kumar@kernel.org,
	yang@os.amperecomputing.com,
	peterx@redhat.com,
	ioworker0@gmail.com,
	jglisse@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH 0/2] Do not shatter hugezeropage on wp-fault
Date: Fri, 30 Aug 2024 14:11:15 +0530
Message-Id: <20240830084117.4079805-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was observed at [1] and [2] that the current kernel behaviour of
shattering a hugezeropage is inconsistent and suboptimal. For a VMA with
a THP allowable order, when we write-fault on it, the kernel installs a
PMD-mapped THP. On the other hand, if we first get a read fault, we get
a PMD pointing to the hugezeropage; subsequent write will trigger a
write-protection fault, shattering the hugezeropage into one writable
page, and all the other PTEs write-protected. The conclusion being, as
compared to the case of a single write-fault, applications have to suffer
512 extra page faults if they were to use the VMA as such, plus we get
the overhead of khugepaged trying to replace that area with a THP anyway.

Instead, replace the hugezeropage with a THP on wp-fault.

[1]: https://lore.kernel.org/all/3743d7e1-0b79-4eaf-82d5-d1ca29fe347d@arm.com/
[2]: https://lore.kernel.org/all/1cfae0c0-96a2-4308-9c62-f7a640520242@arm.com/

Dev Jain (2):
  mm: Abstract THP allocation
  mm: Allocate THP on hugezeropage wp-fault

 include/linux/huge_mm.h |   7 ++
 mm/huge_memory.c        | 171 +++++++++++++++++++++++++++++-----------
 mm/memory.c             |   5 +-
 3 files changed, 136 insertions(+), 47 deletions(-)

-- 
2.30.2


