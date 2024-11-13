Return-Path: <linux-kernel+bounces-407514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7888A9C6E86
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E211282166
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736652022E2;
	Wed, 13 Nov 2024 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPCdB3y5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEFB200BB7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499049; cv=none; b=I/Jzp3XEtTg0d7s2Z5FcAJ9Vtlt8AfM9DtQtgYgSY0kimjg5/0VoaO1xa7gPqAZK4YTr7JHYD+4UdSabWGhJ5VGo+jTpaXA+ulrdc96XsZH1ombkmukbb5rcI0eadMPT/AZTNOhCuUBXyFfkDEjSNU4ER9NexNY7GdbKCfoWRUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499049; c=relaxed/simple;
	bh=FOkhZ3YwPjjFd9QoFBtzh5+kVoevaEfYuq9sCh3nft4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nvvm5omvqVQvecCZBEdIipdw4n8GIxS2ER84YWgL8vOhCGK/w0A/pN94eGYJ260+H/NzpS3syUYpd6pUwP7fzgcCFxboF/pG+E3GH34fA0VaTOGMj/LKa6hTlXwTDd4t4Es/rFO3DYnMVQcKkJRjR/Ram0ikK6kx8YGKz5ZakFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPCdB3y5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731499048; x=1763035048;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FOkhZ3YwPjjFd9QoFBtzh5+kVoevaEfYuq9sCh3nft4=;
  b=mPCdB3y5np6v2r6ARw88AG+clWUBkqXoozkLuOunDBBzH9RfItE1mgz5
   8ZnQP3LI1LaDsGb5uCf+0KCQAu2c2lckgjmxIxdCew/6BrW1W75eM9ZCl
   6Fb4G7BZ5/1lQMjTI3zyx95wtlLgiIsxa6I5gcOY+XQPHpu5SKZ5Q3aJW
   VmRG+NS/T7O/lp1vDba3w/+6GwLeeEWPeIXrVLi28KQJqcyJ2VUzsShfP
   LuHAxijb6e1Ly3QZluBT97RiEzEvxU5stHCi3bIlSekZhCBtdtXIKzbtG
   r2Idcp7sRDW1zzsBO4b1GYw8gweLshW7hHSrCv38Ek3FI+pKD3u97E3s2
   A==;
X-CSE-ConnectionGUID: jvlB/ZjlQ7uEUYtTfLLPSg==
X-CSE-MsgGUID: IhFkoeghTruFpsJjlje25g==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31630716"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="31630716"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 03:57:27 -0800
X-CSE-ConnectionGUID: +hj0XYNPQ+KeUoVUWsHyVg==
X-CSE-MsgGUID: t2/L3MHzTJSHh2embeY+CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="92323453"
Received: from daliomra-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.220.169])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 03:57:24 -0800
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
Subject: [PATCH v8 0/9] TDX host: metadata reading tweaks and bug fixes
Date: Thu, 14 Nov 2024 00:57:05 +1300
Message-ID: <cover.1731498635.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series replaces the existing TDX module metadata reading code with
a new auto-generated global metadata infrastructure to:

1) address two issues in the current TDX module initialization code, and
2) have an extendable infrastructure which is super easy to read more
   metadata and share with KVM for KVM TDX support (and other kernel
   components for TDX Connect in the future).

And the reason that we need a new global metadata infrastructure is the
current one can only read TDMR related metadata fields and it is not
extendable to read more metadata fields, which is required to address
both 1) and 2) above.

Specifically, below two issues in the current module initialization code
need to be addressed:

1) Module initialization may fail on some large systems (e.g., with 4 or
   more sockets) [1].
2) Some old modules can clobber host's RBP when existing from the TDX
   guest, and currently they can be initialized successfully.  We don't
   want to use such modules thus we should just fail to initialize them
   to avoid memory/cpu cycle cost of initializing TDX module [2].

The first 6 patches introduce the new auto-generated global metadata
infrastructure (which is auto-generated using a script [3]), and the
rest patches address the above two issues.

Hi Dave,

This series targets x86 tip.  This is also a pre-work of the "quite near
future" KVM TDX support.  I appreciate if you can review, comment and
take this series if the patches look good to you.

The script used to auto-generate the metadata reading code in patch 3
can be found in [3].

Also cc Dan for TDX Connect, and cc Paolo/Sean for KVM TDX (but I
removed KVM list since this series doesn't touch KVM code).

History:

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

[1]: https://github.com/canonical/tdx/issues/135
[2]: https://lore.kernel.org/fc0e8ab7-86d4-4428-be31-82e1ece6dd21@intel.com/
[3]: https://lore.kernel.org/d5aed06ae4b46df5db97fdbac9c01843920a2f96.camel@intel.com/


Kai Huang (8):
  x86/virt/tdx: Rename 'struct tdx_tdmr_sysinfo' to reflect the spec
    better
  x86/virt/tdx: Start to track all global metadata in one structure
  x86/virt/tdx: Use dedicated struct members for PAMT entry sizes
  x86/virt/tdx: Add missing header file inclusion to local tdx.h
  x86/virt/tdx: Switch to use auto-generated global metadata reading
    code
  x86/virt/tdx: Trim away tail null CMRs
  x86/virt/tdx: Reduce TDMR's reserved areas by using CMRs to find
    memory holes
  x86/virt/tdx: Require the module to assert it has the NO_RBP_MOD
    mitigation

Paolo Bonzini (1):
  x86/virt/tdx: Use auto-generated code to read global metadata

 arch/x86/virt/vmx/tdx/tdx.c                 | 146 +++++++++++---------
 arch/x86/virt/vmx/tdx/tdx.h                 |  43 +-----
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c |  67 +++++++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.h |  32 +++++
 4 files changed, 183 insertions(+), 105 deletions(-)
 create mode 100644 arch/x86/virt/vmx/tdx/tdx_global_metadata.c
 create mode 100644 arch/x86/virt/vmx/tdx/tdx_global_metadata.h


base-commit: 7ae15e2f69bad06527668b478dff7c099ad2e6ae
-- 
2.46.2


