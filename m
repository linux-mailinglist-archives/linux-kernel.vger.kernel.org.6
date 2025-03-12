Return-Path: <linux-kernel+bounces-557624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C91A5DBA7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1294189C898
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4D023F387;
	Wed, 12 Mar 2025 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2Fz7ZBj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314B8233158
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779300; cv=none; b=OCkS9p861LejjCoBZV8lyU/+o5n+34X56aH278dMhDmvUvTmGb+ZDdh8i7czX+Qu/OPnU3p/TYLNHwYtkk60hD/tcmH29hOjvreI0/sOgjf9qfPENVEylxsZBwTxByxSAX3gUV0ihlLD5awV9BESkV12hyykDsj2g+GVrhZSR0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779300; c=relaxed/simple;
	bh=wvBfcJ2a+kweUO+Yq2/vprTjpgxiS33jBY6gHcj5ubE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBPmD8sIcaMW5958N+lbry4Wc2XAkF/jlOtQpkXYetsegyk5Rlo7oegOSBwWSocJDwPWU2UKcz5sbjABhEQFLNTA4GPo0c0bjxe3GQ40IdcS+gK0RISwCgiZCumqRFMovxi52f41GVi13OvsZ8iy6Y3SaBDdCHJQpfqZXN07XDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2Fz7ZBj; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741779299; x=1773315299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wvBfcJ2a+kweUO+Yq2/vprTjpgxiS33jBY6gHcj5ubE=;
  b=U2Fz7ZBjyANwonej/FInMap6P6mqrsocsmQnKicE8Zu6I2H6EOq8/BPT
   TK4wY8770cbKnGAAyfut/Kl2/t/7clG5z0UTb7viH3nQ8z5AumA2Vqi8M
   OGJw5aiNLVaTZd/DjDOti1lziqcW4uwXILEYAzgTDHYwFz8PjhPw3z4rA
   QjWAU/tSya0nVDXTVj6siAkuCcjTwCv4k6YZQAiV2wMrlwYmOPZDYMfdW
   MeFVcjGKtdif0Yu4wAcvmU4jsyvy0C/+YEqBd4pHLRbaM67g0gJqnsmM6
   IAR27bwNYQEbESV15ugfKzwhxjHdsADqVvL2t+QZx36YIFbcEzUtjaw9f
   A==;
X-CSE-ConnectionGUID: kt7GlhiKRv+yM4pa8CvJcw==
X-CSE-MsgGUID: 97e8Cya/TuKfydZDSh3lFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42985181"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="42985181"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 04:34:59 -0700
X-CSE-ConnectionGUID: GKDd7LXKSYSwb+lZpDpVTw==
X-CSE-MsgGUID: 0n1/n8xSSg6hjeE97/iEsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="124776085"
Received: from iweiny-desk3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.221.164])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 04:34:53 -0700
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	peterz@infradead.org,
	mingo@redhat.com,
	kirill.shutemov@linux.intel.com
Cc: hpa@zytor.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	reinette.chatre@intel.com,
	isaku.yamahata@intel.com,
	dan.j.williams@intel.com,
	thomas.lendacky@amd.com,
	ashish.kalra@amd.com,
	dwmw@amazon.co.uk,
	bhe@redhat.com,
	nik.borisov@suse.com,
	sagis@google.com
Subject: [RFC PATCH 4/5] x86/virt/tdx: Remove the !KEXEC_CORE dependency
Date: Thu, 13 Mar 2025 00:34:16 +1300
Message-ID: <8ca4ac944560c9c02ef9ba273e2ae8f1cdd31c3a.1741778537.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741778537.git.kai.huang@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During kexec it is now guaranteed that all dirty cachelines of TDX
private memory are flushed before jumping to the new kernel.  The TDX
private memory from the old kernel will remain as TDX private memory in
the new kernel, but it is OK because kernel read/write to TDX private
memory will never cause machine check, except on the platforms with the
TDX partial write erratum, which has already been handled.

It is safe to allow kexec to work together with TDX now.  Remove the
!KEXEC_CORE dependency.

Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ac4d65ef54a5..2d423964beb9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1977,7 +1977,6 @@ config INTEL_TDX_HOST
 	depends on X86_X2APIC
 	select ARCH_KEEP_MEMBLOCK
 	depends on CONTIG_ALLOC
-	depends on !KEXEC_CORE
 	depends on X86_MCE
 	help
 	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
-- 
2.48.1


