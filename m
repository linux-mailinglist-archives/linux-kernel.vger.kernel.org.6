Return-Path: <linux-kernel+bounces-389730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B54209B708B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20EE1C20A62
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051761E2605;
	Wed, 30 Oct 2024 23:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hWsBf2z0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7457519CC24
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 23:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730331187; cv=none; b=Jr/M86KDaLN9cS3xyBQVY5YjnXYpAwA4oX1uOD+7c/I5coydPrZ3+Pym1SY1XsM8JLPSwMDqU/a6gVFi+BhhDEfc7F7N5dHrwpqEow6cxpi9rW22mZhDM7MaU/oQqLcAFb8/A5cfPkup6mVy8yJJOwtE+BFrYZ9/NVI7r/nwWeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730331187; c=relaxed/simple;
	bh=qi2UnnxJp8299leWppoI0G9jTaDMl4oofuewHXnqfmk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QjMkpbKSm1v/ZmaYEPO2G5juIg1jp9lcQxKQgq5mjPey6RHvZO21r74/aEvAB0+cF2o03H/P8MvWIN1w4ad1k4YIl9nGYfdG4xS1xCrOAYJEhF3d/v4+hccOnsORblsEPbmURSeOjQrWF9T2VOsKWz+XSSDSzhYnA0M3/emBMp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hWsBf2z0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730331184; x=1761867184;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qi2UnnxJp8299leWppoI0G9jTaDMl4oofuewHXnqfmk=;
  b=hWsBf2z0EZUpChqj4319Gx8EE/J4tnJdXh6+lLFMw5kWK8iEFwyd90WZ
   ff27UVug8/+oeLU7v97IFWnAoqCRODij8kMkZ0AF6jeTyJPOLohn3lrWV
   TVsBVdTu5FcTJaAW5ICz2J4SsnbagWFhfQQJCEzaYbSh+Vnb47kEiVYdt
   7OjNiuoaQlHepPQN93DtGkw5+7tg7TmrcRJEZOVARK1iFCauVHDC/bfa8
   cw6QU1ljNo19+mM+r/lojJb5qxONAutUl1OrCLK8uyzA9ov07yv7mcLXx
   p0AVaNmXHOdCe6F4r9M7kVcFTQuVNsII+MgjxMJsHR8dGGjZ0kCqHOyqF
   w==;
X-CSE-ConnectionGUID: 0IoDBidPQvyKqwoLQm78NA==
X-CSE-MsgGUID: OfEd4GZISDi7ODZt1RFqVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="40631960"
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="40631960"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 16:33:03 -0700
X-CSE-ConnectionGUID: 8upHZT16SySZEJyhX3dTfw==
X-CSE-MsgGUID: t1CvAVN4TH+Xe9tZ2lE3gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="119920337"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa001.jf.intel.com with ESMTP; 30 Oct 2024 16:33:02 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Tony Luck <tony.luck@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Eric Biggers <ebiggers@google.com>,
	Xin Li <xin3.li@intel.com>,
	Alexander Shishkin <alexander.shishkin@intel.com>,
	Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/cpufeature: Add feature dependency checks
Date: Wed, 30 Oct 2024 23:31:18 +0000
Message-Id: <20241030233118.615493-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the cpuid-deps[] table is only exercised when a particular
feature gets explicitly disabled and clear_cpu_cap() is called. However,
some of these listed dependencies might already be missing during boot.
These types of errors shouldn't generally happen in production
environments but they could sometimes sneak through, especially when
VMs and Kconfigs are in the mix.

Unexpected failures can occur when the kernel tries to use such a
feature. Rather than debug such scenarios, it would be better to
disable the feature upfront.

Add a simple boot time check for missing feature dependencies and
disable any feature whose dependencies are not met.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
I considered merging filter_feature_dependencies() and filter_cpuid_features()
but they operate on slightly different structures namely, struct
cpuid_dependent_feature and struct cpuid_dep. Operating on them in the same
function didn't seem worthwhile. Please let me know if someone feels otherwise.

v2: Use cpu_has() instead of boot_cpu_has() (Sean)

RFC-v1: https://lore.kernel.org/lkml/20240822202226.862398-1-sohil.mehta@intel.com/
---

 arch/x86/include/asm/cpufeature.h |  1 +
 arch/x86/kernel/cpu/common.c      |  4 ++++
 arch/x86/kernel/cpu/cpuid-deps.c  | 10 ++++++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 0b9611da6c53..8821336a6c73 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -148,6 +148,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 
 extern void setup_clear_cpu_cap(unsigned int bit);
 extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
+void filter_feature_dependencies(struct cpuinfo_x86 *c);
 
 #define setup_force_cpu_cap(bit) do {			\
 							\
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index f1040cb64841..b7491e57a74e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1610,6 +1610,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 		c->cpu_index = 0;
 		filter_cpuid_features(c, false);
+		filter_feature_dependencies(c);
 
 		if (this_cpu->c_bsp_init)
 			this_cpu->c_bsp_init(c);
@@ -1862,6 +1863,9 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	/* Filter out anything that depends on CPUID levels we don't have */
 	filter_cpuid_features(c, true);
 
+	/* Filter out features that don't have their dependencies met */
+	filter_feature_dependencies(c);
+
 	/* If the model name is still unset, do table lookup. */
 	if (!c->x86_model_id[0]) {
 		const char *p;
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 8bd84114c2d9..8bea5c5e4fd2 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -146,3 +146,13 @@ void setup_clear_cpu_cap(unsigned int feature)
 {
 	do_clear_cpu_cap(NULL, feature);
 }
+
+void filter_feature_dependencies(struct cpuinfo_x86 *c)
+{
+	const struct cpuid_dep *d;
+
+	for (d = cpuid_deps; d->feature; d++) {
+		if (cpu_has(c, d->feature) && !cpu_has(c, d->depends))
+			do_clear_cpu_cap(c, d->feature);
+	}
+}
-- 
2.34.1


