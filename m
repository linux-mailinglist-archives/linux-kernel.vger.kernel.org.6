Return-Path: <linux-kernel+bounces-320842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB54897113C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60707B22591
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0C21B3B0F;
	Mon,  9 Sep 2024 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="flXp6vxt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B8B1B2ED9
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869227; cv=none; b=h5Pv67swv3a4srN5uOBQRNxslPb5BJFcsOfinERlSSnKX9j33Pb2vW3nzoy3iSyvg9oaEk54UnHVxKXFjSmfYoLSzpo4JxTK0G8UIjXwTtZQC9qX/iJkzOuOXtzi2WLTpUPbS+maF5DPCAP54RhNKIgMph7lekA9gvVUpd4cd/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869227; c=relaxed/simple;
	bh=ynMS14lA2B7Xh4ng+Fh0LXLrThwwbRF5QeEvUeRiZX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLZik1LEK+DKBmYoiBjYAg6Y8Eq5xwOYkJ27yRtoWP7v3G5AwmXfFU0+apXR5frXyoiHbt91zLAhqogOrrlDbKyFVZ+oxcQIyr1rULYYlwPsOAu/mc7ZG1XPMt8aq+HikKTgVdr7aUvc9IQPqlBvIeiNkgae5y8cirIVb71Gctg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=flXp6vxt; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725869226; x=1757405226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ynMS14lA2B7Xh4ng+Fh0LXLrThwwbRF5QeEvUeRiZX8=;
  b=flXp6vxtfN9EiG7feuzIwGsstAMlvcgwfErI6vwoNkioywuMzOsjPkQX
   wt1xoM4JmKmPkaH4wSZot2BxGwPNGsbMHwMxDfMdXV7iLKoD3x3o0j3Bm
   /Phb2m/2iIyXzVo5c/DxND1Ixa9avWTbyOt0GqPORTztFLSC/agvd0w8G
   U1ipWcV211EJxVfcxbdJNDn3HUuVTbqbJ2RlNK8kdhWTuJyMslo7MdOE/
   KM0EFTEr4ytSQwZIryk+xxF5UwgDkvWOqQZafx2uHMYZDpRTsQJnT6j1L
   phq1+KJ2M0AsHkMxKxJWXXGIgkGm+8M4cmE4Ik+kYH9RJ8vXxfJENVoh6
   Q==;
X-CSE-ConnectionGUID: bG2CwGcTQ8WKkQaWPQLNbw==
X-CSE-MsgGUID: wyHgxN1dQNKG5W08pVVfqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24410620"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="24410620"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 01:07:06 -0700
X-CSE-ConnectionGUID: naf7TqEaRQyhHEKh0xVieQ==
X-CSE-MsgGUID: DYuxD+UNTbGoI1D6+UvZpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="67327078"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.222.253])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 01:07:03 -0700
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	peterz@infradead.org,
	mingo@redhat.com,
	hpa@zytor.com,
	kirill.shutemov@linux.intel.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	dan.j.williams@intel.com,
	thomas.lendacky@amd.com,
	rick.p.edgecombe@intel.com,
	isaku.yamahata@intel.com,
	ashish.kalra@amd.com,
	bhe@redhat.com,
	nik.borisov@suse.com,
	sagis@google.com
Subject: [PATCH v6 5/5] x86/virt/tdx: Remove the !KEXEC_CORE dependency
Date: Mon,  9 Sep 2024 20:06:27 +1200
Message-ID: <1280a4b722f34e92d4036c09998f927f2643055f.1725868065.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725868065.git.kai.huang@intel.com>
References: <cover.1725868065.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now TDX host can work with kexec().  Remove the !KEXEC_CORE dependency.

Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d422247b2882..2da088202969 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1979,7 +1979,6 @@ config INTEL_TDX_HOST
 	depends on X86_X2APIC
 	select ARCH_KEEP_MEMBLOCK
 	depends on CONTIG_ALLOC
-	depends on !KEXEC_CORE
 	depends on X86_MCE
 	help
 	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
-- 
2.46.0


