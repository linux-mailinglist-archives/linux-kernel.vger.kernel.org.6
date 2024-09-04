Return-Path: <linux-kernel+bounces-314745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ECB96B7EB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1238E1F273F6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A2E1CEEA8;
	Wed,  4 Sep 2024 10:09:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9D11CEEA2
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444585; cv=none; b=taQ3rphLTVMB6W86mf48u5lyp+QsTTni0KcfCrQZqAwyLJpASUlmtvpRtkL0m3tTj6nzV0NZeZrOLgDE0p2nHGwJYJ1Bf4X1w2QQ2tlPNvxT3n0fmwQu61ZXrokdEBaEYJkSWn5kex/ckjcD2s2Y+sywKQr0NSk28lgLocaCsXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444585; c=relaxed/simple;
	bh=vzMR0JkVVHQXU1oV4NO6hubpUQ/At8ESgc6lgCPOL2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HIFFc0JGuV0GWHbv6m6oL3B0NQxlDVdcw9PYeVrExl0flWCP4P8IIGIllWiwjhWN8sTezDj4GyPyEAfXrO0Avd6iXhhl5ZdkGvEqhHmQiV1T9IgvSyR2hpsBMQfiyLVDlfXQh/RVzYhcUftZJnv7FqKQneMGnGBIJRgLMTkDYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AE1FFEC;
	Wed,  4 Sep 2024 03:10:09 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.43.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 298A33F66E;
	Wed,  4 Sep 2024 03:09:33 -0700 (PDT)
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
Subject: [PATCH v2 0/2] Do not shatter hugezeropage on wp-fault
Date: Wed,  4 Sep 2024 15:39:21 +0530
Message-Id: <20240904100923.290042-1-dev.jain@arm.com>
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

v1->v2:
 - Wrap do_huge_zero_wp_pmd_locked() around lock and unlock
 - Call thp_fault_alloc() before do_huge_zero_wp_pmd_locked() to avoid
 - calling sleeping function from spinlock context

[1]: https://lore.kernel.org/all/3743d7e1-0b79-4eaf-82d5-d1ca29fe347d@arm.com/
[2]: https://lore.kernel.org/all/1cfae0c0-96a2-4308-9c62-f7a640520242@arm.com/

Dev Jain (2):
  mm: Abstract THP allocation
  mm: Allocate THP on hugezeropage wp-fault

 include/linux/huge_mm.h |   6 ++
 mm/huge_memory.c        | 171 +++++++++++++++++++++++++++++-----------
 mm/memory.c             |   5 +-
 3 files changed, 136 insertions(+), 46 deletions(-)

-- 
2.30.2


