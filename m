Return-Path: <linux-kernel+bounces-168659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 136448BBB9E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0EFE282D3D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 12:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8068522611;
	Sat,  4 May 2024 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HgzmWuRe"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A7620DF7
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714827055; cv=none; b=s1LaMPq7Kye3fGdygMAnu1eJN2eNhw5N+msIplKyfT08azUmJJfvbGWOMD45lu39JbvBXfeFh3HFlJcfgDwyLq66InPZgvsbAOtlDZysWcn79iveRG42l9qunPbHViOMTcLqRhNE9/tJfiXG6Yu+gVrnHd7U0slnCyYPtzfG7/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714827055; c=relaxed/simple;
	bh=KrH/zPSxhqvTk7sGZgx4edGzXm2L3D1bxrw/uv0GL+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zo7xOM0T8s46+GcjvbmLcxrWP7vglWGAvWvHoFzrkQ5rZO1NJ8B9fLEqjDkScaqJqfQcQIobc1LvmjOTXJYCIh+eWXPx2OH+tivYxbRQgvCWcL1xXqADQlRXKFhbmc0Bh/jrMUZ47OitFgI3kOCl7SnTQr+AuQEFHyyNPipJpLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HgzmWuRe; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C0E6C40E0192;
	Sat,  4 May 2024 12:50:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id b1ygzvNIHZiP; Sat,  4 May 2024 12:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714827049; bh=XNK1mK0mvPkPIhkijCeRz+GV9/JqvJGZB+kG2twbOVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HgzmWuRebHI6UuoqLIM3aWNs5tn4rHtIgT1a/F3O/7P6HkHSmLRbU/TkNcGURad64
	 Jkh/2WAuvK29QE1huLlnQ2WMDMWCqa8LIVre6DzUd8NaikhH5EltMef8gILD3s65yn
	 E+z2Ui8LftpQw/fn8rb4mInpKNgIGLvSKsi5V0b3BB5e7udaWkgQ1tICRVkGuAhQxY
	 2dqzJwVpbwr+bpa0ACds623MXBYJ5sE+xiUf5895C2mMCvucq3JIKuv2Mq+dqOiIYx
	 BdknC6p4O2XePmmXu1JttvtvADliWd/5WjG6dYMH67HszpWKO5kJUNrsCusx8NP6bP
	 uv6/IpYKU5/qrrUrNxDnx8iUbzEzuo4wc5QNs84Te5ouMAOTTlW+wLG/bmL04Y6gCc
	 kBSgNtB/8JYvf237R1r2o1w1YDaUz1l1QWwX8N4CxGxhxT3xFbrE/tKc/xjtrxA9nD
	 NF/tUxK68G8pQcvvFWjOdSFfzLTP1oY6IXD/r9WjBSMD76kZI04BaVEhO5KRbRJ+LS
	 DF6Nrfbb0ICi868SngOu3cvy4jJvU/RkKz8BsRAfaMta/8O3dwkOStrC8I4NITMKmB
	 fuqzTVpH1bFXrc+gQCI/Fy6tvwOSVtEUuLIWJsT8B/Holp9R6HvbZpzgAdCjHLAccb
	 N7SLFvXPl6hdTy8Qj9d1DwRM=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 37E3440E01A1;
	Sat,  4 May 2024 12:50:41 +0000 (UTC)
Date: Sat, 4 May 2024 14:50:40 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>,
	kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
	Srikanth Aithal <sraithal@amd.com>
Subject: [PATCH 2/2] x86/CPU/Intel: Do the MSR_IA32_FEAT_CTL setup before
 alternatives
Message-ID: <20240504125040.GCZjYvIAK9_DzKuHXh@fat_crate.local>
References: <202404302233.f27f91b2-oliver.sang@intel.com>
 <20240430172313.GCZjEpAfUECkEZ9S5L@fat_crate.local>
 <ZjE7DkTBSbPlBN8k@google.com>
 <20240430193211.GEZjFHO0ayDXtgvbE7@fat_crate.local>
 <ZjFLpkgI3Zl4dsXs@google.com>
 <20240430223305.GFZjFxoSha7S5BYbIu@fat_crate.local>
 <20240504124822.GAZjYulrGPPX_4w4zK@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240504124822.GAZjYulrGPPX_4w4zK@fat_crate.local>

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Thu, 2 May 2024 15:15:41 +0200

init_ia32_feat_ctl() goes through the MSR_IA32_FEAT_CTL settings and
sanity-checks the configuration on each logical CPU, while setting or
clearing X86_FEATURE flags in the process.

However, it does that after alternatives have run, leading to settings
which have been patched by the alternatives to become invalid and
irreversible.

Move the settings detection to an earlier path, before the alternatives.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/oe-lkp/202404302233.f27f91b2-oliver.sang@intel.com
---
 arch/x86/kernel/cpu/intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index be30d7fa2e66..d8575511a143 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -406,6 +406,8 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	 */
 	if (cpu_has(c, X86_FEATURE_TME))
 		detect_tme_early(c);
+
+	init_ia32_feat_ctl(c);
 }
 
 static void bsp_init_intel(struct cpuinfo_x86 *c)
@@ -682,8 +684,6 @@ static void init_intel(struct cpuinfo_x86 *c)
 	/* Work around errata */
 	srat_detect_node(c);
 
-	init_ia32_feat_ctl(c);
-
 	init_intel_misc_features(c);
 
 	split_lock_init();
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

