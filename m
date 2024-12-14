Return-Path: <linux-kernel+bounces-446077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A0B9F1F98
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 16:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823A3166EC1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 15:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AE9194A66;
	Sat, 14 Dec 2024 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCjMuodX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAAA18AE2
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734189373; cv=none; b=BCq2CCIkQkNRXBYz/CyyuRqTkSCJxDSKYAqpqVuJvFFwONvRXUC3CRxh7GbDy7DCtkxY76lSXJJRpFVfBB/ZYPqjsjWLXZHmlQdsL8/CrzKAz6Awspafa6qKC1BryoR60mGLrIycxqW4qe/9UttqhP6Eh2o+VUVs8E0Dx3HkydM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734189373; c=relaxed/simple;
	bh=UJEbzQUsyGX9L5ShWN3KaIYn3YGKc0az784D/C357Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KACs4BRT0kDkTSBwgwZpD2ecLiDeXrB7uw0MaKN9lo6DX36pxV6SkD+sQZzwvm7u6oG2h9UltFO8C8eFC6p3i3Tg+TQJqoCbT/1JfIJW7gcXmtx+Ebez6DPGcIa0/C2Ak6QXaoHtQAzU5UfA6HDj0MlGgkkPElyxR/wBypyhF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCjMuodX; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734189371; x=1765725371;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UJEbzQUsyGX9L5ShWN3KaIYn3YGKc0az784D/C357Hs=;
  b=HCjMuodX4yeNrw/IDWRrmt8ON+acO6T3MK2GssyIwNLZkTSHrwFKjPoR
   616d693Lpx86MrwyXQTtt6a1nTKEDlTBqdYPIcnwV+XG2wh9I0rhJRBqZ
   CIIjpyjFx4GB59WlTnZtPeSGo04JyNzv4resZdNPr2jfqJa2H7/M6mp0F
   e+QVC/0l11wNz4Ye3WD3/zKloZL1SDio/v7VozseZov0VN3x0iiEm3rOJ
   762+iAyuhmvh1ruxUwo/22XaQJuPgUkDQqHyzUhYwGWqasTKvTr3VhlVN
   nYNGugyPOEF9ayxeNh8iJA6i8aYqro5KVYEcyHgip9Z84DRhJ4LP27TBJ
   g==;
X-CSE-ConnectionGUID: MPN1GtwNREaw+dRDoY6k3Q==
X-CSE-MsgGUID: oM0YjF6NS4mICmZQsBzWJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45109865"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45109865"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 07:16:11 -0800
X-CSE-ConnectionGUID: lzkCSsGuT8eR9uyPhPkb/Q==
X-CSE-MsgGUID: Ungf8jI+TFOig8L2nEC7/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120050120"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.223.200])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 07:16:02 -0800
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@intel.com,
	kirill.shutemov@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	peterz@infradead.org,
	mingo@redhat.com,
	hpa@zytor.com,
	dan.j.williams@intel.com,
	seanjc@google.com,
	pbonzini@redhat.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	rick.p.edgecombe@intel.com,
	isaku.yamahata@intel.com,
	adrian.hunter@intel.com,
	nik.borisov@suse.com,
	kai.huang@intel.com
Subject: [PATCH v9 0/6] TDX host: metadata reading tweaks and feature mandate
Date: Sun, 15 Dec 2024 04:15:41 +1300
Message-ID: <cover.1734188033.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series replaces the existing TDX module metadata reading code with
a new auto-generated global metadata infrastructure for basic KVM TDX
support:

1) read "TDX_FEATURES0" field to mandate the "not clobbering RBP when
   exiting from TDX guest" feature is supported during the module
   initialization.

   Some old modules can clobber host's RBP when exiting from the TDX
   guest, and currently they can be initialized successfully.  We don't
   want to run TDX guests using such modules.  We should just fail to
   initialize them to avoid memory/CPU cycle cost of initializing TDX
   module [1].

2) provide metadata reading infrastructure which is required to read
   more metadata fields to support KVM TDX.  The patches which do so
   can be found at [2][3].

Hi Dave,

This series targets x86 tip.  This is the bare minimum pre-work to
support KVM TDX.  I appreciate if you could review and take this as we
think we have addressed all the comments.

This series has dropped all changes that are not required for TDX KVM
base support.  It includes only:
 - Host metadata infrastructure, which will be used by the KVM patches
   to get TDX module information to boot a TD.
 - The NO_RBP_MOD enforcement, which is required to avoid clobbering
   RBP when running TDX guests using old TDX modules.

The script used to auto-generate the metadata reading code in patch 3
can be found in [4].

History:

v8 -> v9:
 - Take out the "running out of reserved areas" bugfix:
   - Remove CMR reading code in patch 3.
   - Remove patch 7-8.
 - Take out the patch 5 which adds nice-to-have header file inclusions
   but it is not mandatory for KVM TDX.
 - Minor changelog improvement suggested by Rick and Reinette.
 - Rebase to tip/x86/tdx.

 v8: https://lore.kernel.org/lkml/cover.1731498635.git.kai.huang@intel.com/

v7 -> v8:
 - Address Dave's comments to remove the code to print module version
   and CMRs:
   - Remove the code which reads module version in the auto-generated
     code.
   - Remove the patch which prints module version (patch 10 in v7)
   - Remove the code which prints CMRs in patch 7.
   - Update the changelog of some patches that mentioned "reading module
     version" and "print CMRs".
 - Collect Nikolay's tag.

Previous versions and more background info please see:

 - https://lore.kernel.org/kvm/6ab90fd332bccdec7b64e5909cb4637732d6bb01.1731318868.git.kai.huang@intel.com/T/

[1]: https://lore.kernel.org/fc0e8ab7-86d4-4428-be31-82e1ece6dd21@intel.com/
[2]: https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?h=kvm-coco-queue&id=594fc3256733fe2c5b8bd9007effea2083431861
[3]: https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?h=kvm-coco-queue&id=8bb81c97ec53b8a3dea29572cdb6ecfa4ff3a181
[4]: https://lore.kernel.org/762a50133300710771337398284567b299a86f67.camel@intel.com/




Kai Huang (5):
  x86/virt/tdx: Rename 'struct tdx_tdmr_sysinfo' to reflect the spec
    better
  x86/virt/tdx: Start to track all global metadata in one structure
  x86/virt/tdx: Use dedicated struct members for PAMT entry sizes
  x86/virt/tdx: Switch to use auto-generated global metadata reading
    code
  x86/virt/tdx: Require the module to assert it has the NO_RBP_MOD
    mitigation

Paolo Bonzini (1):
  x86/virt/tdx: Use auto-generated code to read global metadata

 arch/x86/virt/vmx/tdx/tdx.c                 | 95 +++++++--------------
 arch/x86/virt/vmx/tdx/tdx.h                 | 40 +--------
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 48 +++++++++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.h | 25 ++++++
 4 files changed, 108 insertions(+), 100 deletions(-)
 create mode 100644 arch/x86/virt/vmx/tdx/tdx_global_metadata.c
 create mode 100644 arch/x86/virt/vmx/tdx/tdx_global_metadata.h


base-commit: 564ea84c8c14b007d7838bfb1327295b873573be
-- 
2.47.1


