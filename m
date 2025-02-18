Return-Path: <linux-kernel+bounces-518844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E84A39552
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B9A176BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9A31D90DB;
	Tue, 18 Feb 2025 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFgD8noi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1932206F15;
	Tue, 18 Feb 2025 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866790; cv=none; b=NpW9HIAob9WfRt7V8K1v3+ZnAEdbZXIOA/gJgdmSPa5oOWF/WSNY0gaELP5VnKmhQ56q+nOHoWNh53/FxfYPwIBa/boQAhwjRha05X63HOXSDHoW2cl6H36Y0R9pDav6wjtrpeUMnsJObmeVeEKq+Gj3vZAeA/XTGZczxLFtpUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866790; c=relaxed/simple;
	bh=kRU3BBM+6pq6tmllpt/bIuIdjTWZr2MiffpU/uDWsS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVCL7iXXVwjlXu3xlwxCRDjnwfDKuKbbtHtNpNClONi49mNysEOZSxVKep5riC/CwCpwcCr/tYkLty5mcgK0zwfuoVnqeVhKZCe+el7NmGCwPucqhxN4RbS0UfuHjvyYC/obeuDA9dXZz7w7fZ/5kXqnOC9qLRlC33Q8gc/LNM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFgD8noi; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866789; x=1771402789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kRU3BBM+6pq6tmllpt/bIuIdjTWZr2MiffpU/uDWsS0=;
  b=XFgD8noigUFOIB7P8T4GHHx/Phu72E9ibuSadxyS9yktJ1gD8bDmmaDU
   OR/6Z2F0f8yNJB/G7aA4duIACj3IfFW91oX+qFUslazbtWv9Iqok2exbi
   ZyzgkSXqISxsNJPIwgP5RAgowBOO5l+Hm+fFidj8EDqNcjy240TF6Rxhz
   m2nRLm+30yBZA9bK7LQBzIt6i3b3zbS+olQj0eKKm9pNwT1O2z7BRxx7N
   A8gJUnzfN/jHcjLYT23Tyff0n/hRgG0qwNUJosKM4Fc70lyh0OAR8EoQ+
   wXsT3RieviYa+p+ZzWOlzO9mGRv4PAFfB7ajIH/jMv7G9H6O/NRVJ/FbW
   Q==;
X-CSE-ConnectionGUID: 14949JObTp+ibAPOc90VnA==
X-CSE-MsgGUID: s2bneEUCQFyomUbZAkVFiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="28150455"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="28150455"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:19:48 -0800
X-CSE-ConnectionGUID: IYj6E66YQH63xLaNCe56vw==
X-CSE-MsgGUID: fqGS+T4jSJq734ReKLPe/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="119247941"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.49])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:19:28 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: kees@kernel.org,
	julian.stecklina@cyberus-technology.de,
	kevinloughlin@google.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	justinstitt@google.com,
	catalin.marinas@arm.com,
	wangkefeng.wang@huawei.com,
	bhe@redhat.com,
	ryabinin.a.a@gmail.com,
	kirill.shutemov@linux.intel.com,
	will@kernel.org,
	ardb@kernel.org,
	jason.andryuk@amd.com,
	dave.hansen@linux.intel.com,
	pasha.tatashin@soleen.com,
	ndesaulniers@google.com,
	guoweikang.kernel@gmail.com,
	dwmw@amazon.co.uk,
	mark.rutland@arm.com,
	broonie@kernel.org,
	apopple@nvidia.com,
	bp@alien8.de,
	rppt@kernel.org,
	kaleshsingh@google.com,
	richard.weiyang@gmail.com,
	luto@kernel.org,
	glider@google.com,
	pankaj.gupta@amd.com,
	andreyknvl@gmail.com,
	pawan.kumar.gupta@linux.intel.com,
	kuan-ying.lee@canonical.com,
	tony.luck@intel.com,
	tj@kernel.org,
	jgross@suse.com,
	dvyukov@google.com,
	baohua@kernel.org,
	samuel.holland@sifive.com,
	dennis@kernel.org,
	akpm@linux-foundation.org,
	thomas.weissschuh@linutronix.de,
	surenb@google.com,
	kbingham@kernel.org,
	ankita@nvidia.com,
	nathan@kernel.org,
	maciej.wieczor-retman@intel.com,
	ziy@nvidia.com,
	xin@zytor.com,
	rafael.j.wysocki@intel.com,
	andriy.shevchenko@linux.intel.com,
	cl@linux.com,
	jhubbard@nvidia.com,
	hpa@zytor.com,
	scott@os.amperecomputing.com,
	david@redhat.com,
	jan.kiszka@siemens.com,
	vincenzo.frascino@arm.com,
	corbet@lwn.net,
	maz@kernel.org,
	mingo@redhat.com,
	arnd@arndb.de,
	ytcoode@gmail.com,
	xur@google.com,
	morbo@google.com,
	thiago.bauermann@linaro.org
Cc: linux-doc@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH v2 11/14] x86: LAM initialization
Date: Tue, 18 Feb 2025 09:15:27 +0100
Message-ID: <e1a92159d657d1f389a8ee799a33ee2173098bb6.1739866028.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To make use of KASAN's tag based mode on x86 Linear Address Masking
(LAM) needs to be enabled. To do that the 28th bit in CR4 needs to be
set.

Set the bit in early memory initialization.

When launching secondary CPUs the LAM bit gets lost. To avoid this it
needs to get added in a mask in head_64.S. The bit mask permits some
bits of CR4 to pass from the primary CPU to the secondary CPUs without
being cleared.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 arch/x86/kernel/head_64.S | 3 +++
 arch/x86/mm/init.c        | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 31345e0ba006..87158729f138 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -206,6 +206,9 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
 	 *  there will be no global TLB entries after the execution."
 	 */
 	movl	$(X86_CR4_PAE | X86_CR4_LA57), %edx
+#ifdef CONFIG_ADDRESS_MASKING
+	orl	$X86_CR4_LAM_SUP, %edx
+#endif
 #ifdef CONFIG_X86_MCE
 	/*
 	 * Preserve CR4.MCE if the kernel will enable #MC support.
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 62aa4d66a032..5499ba683b53 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -761,6 +761,9 @@ void __init init_mem_mapping(void)
 	probe_page_size_mask();
 	setup_pcid();
 
+	if (boot_cpu_has(X86_FEATURE_LAM) && IS_ENABLED(CONFIG_KASAN_SW_TAGS))
+		cr4_set_bits_and_update_boot(X86_CR4_LAM_SUP);
+
 #ifdef CONFIG_X86_64
 	end = max_pfn << PAGE_SHIFT;
 #else
-- 
2.47.1


