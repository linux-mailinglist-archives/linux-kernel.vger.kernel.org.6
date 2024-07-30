Return-Path: <linux-kernel+bounces-266982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0122E940AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B160E2815DB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DA51922CA;
	Tue, 30 Jul 2024 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Gza4Y6Q3"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00448187322
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722326633; cv=none; b=iOd2Dq+65S7LCVx5YqSzuQZPDtakbECchSxGdiEHHOkmMgSYG6ZqLjcPrs42KjR51S23wS0NPWLuZgCoL6douZiL2/l8yqonIIOjkjh26so1zBxsq9YlfCK2V/JqkYXIRtDOyP8H0lwLQuBZDfh5HqB2eflhF32rnuJ3T8o8Ays=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722326633; c=relaxed/simple;
	bh=DWNGubRHzRjEGM6zExLcknP5Nhoynsr4fLCjY31dlVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=av/nnWw47sv4rJ7XNGTr3orXETVCB2NuX3O8DjdgnfMt/Ye9qwg0dkOqmd2sUAAHG1O5MrBmelBWY4fuBHH2127nsRlenYfRm9RZlqQ3SXfk+Vw3fBFpgRGjatxQneLr/2C1dAHDpjvuJ79ksZCxgruWlppbtLhDQzcoSZ7+2y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Gza4Y6Q3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0F7F140E019C;
	Tue, 30 Jul 2024 08:03:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id L0jvRNJ3Hi_0; Tue, 30 Jul 2024 08:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722326618; bh=uS3wYUx2MIQdz67Z0GsNFcq352DD4UyeUgFguSrShBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gza4Y6Q3mVzoO/ieO9julrMhVsdsn2Fp82fRyCIxnf9q6DtczIhRHYoNisb1AvpL5
	 wlHN57sGvNQuYZR9sOgvqGyJvjdng5mvWMpNvS4ubKIkS4y0oRbZfTSy4Ht+B/xzy5
	 HqTuOdU+Din0kGBkwhfEIUhe7PccA5/THisY9ptVQn93WwtCinT/Xw2oTRVyuwwiNb
	 IMcR7+4m4QHS9+17SC9v5oUn9BwEyPv2gEA/Kfhmg79KPOsBVz/xX5V6NUHUc3ocFv
	 5Sy0WpHGTW/Y8cFfCuo+DM2JOcG7Vs4gcjb2tlbZcQoNWQd3OBHvjblVN+qbakCnUe
	 NsVoth3ZzxbFgWKGt4pvuMekIfB109Em0ApoHrnVLgbNTYkv8r609HGyzDsDCCZE3B
	 eNxisJS0IrGKigXASPe+6Bx/gE9DDybblFBDhfqzi901WaFLOIleoH61Q6NAUCnrvG
	 SDPDlieuC5nmQudaoVWfadELWZRjkWD8vHYBo36rWSplEvt1pJibgonyoNCaPxpjQY
	 xW6oP3NI3TlDSDNUd/OcaNKINyE5ADrllXUjwE5GZONbUUlAkpdRPj0adGv5TckpOv
	 XOCPHIVZRpBh9cPeLLswKSdEG3XUAFK+lLw9FTV+7bFJfbYCTk4HrjQWh/UAYzD9Oc
	 FDzGWpv2aIIUtU6vuB+cU9Q8=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF5D140E01BB;
	Tue, 30 Jul 2024 08:03:32 +0000 (UTC)
Date: Tue, 30 Jul 2024 10:03:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip:x86/microcode 1/1]
 arch/x86/kernel/cpu/microcode/amd.c:714:6: warning: variable 'equiv_id' is
 used uninitialized whenever 'if' condition is false
Message-ID: <20240730080326.GAZqieTl1Gz4RheSiI@fat_crate.local>
References: <202407291815.gJBST0P3-lkp@intel.com>
 <20240729112614.GBZqd8Vu27mFVSHynA@fat_crate.local>
 <20240729153008.GA685493@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240729153008.GA685493@thelio-3990X>

On Mon, Jul 29, 2024 at 08:30:08AM -0700, Nathan Chancellor wrote:
> Right, as clang does not perform interprocedural analysis for the sake
> of warnings. That's partly why GCC's version of this warning was
> disabled in commit 78a5255ffb6a ("Stop the ad-hoc games with
> -Wno-maybe-initialized").

So why aren't we shutting up clang too?

> While it may be properly handled now, I think this pattern of
> conditionally avoiding using a variable uninitialized is dubious.

Well, in this particular case of the microcode loader, this is the best
compromise I can think of - I have two different paths of handling a microcode
patch - Zen and newer - and before - so I need those separate flows.

So sometimes it makes sense.

> So I guess you can just ignore this if you want but others (maybe even
> Linus) will likely notice this and report it as well.

I think this warning should be behind W=1 if it can trigger false positives.

Anyway:

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Tue, 30 Jul 2024 09:52:43 +0200
Subject: [PATCH] x86/microcode/AMD: Fix a -Wsometimes-uninitialized clang
 false positive

Initialize equiv_id in order to shut up:

  arch/x86/kernel/cpu/microcode/amd.c:714:6: warning: variable 'equiv_id' is \
  used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
        if (x86_family(bsp_cpuid_1_eax) < 0x17) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

because clang doesn't do interprocedural analysis for warnings to see
that this variable won't be used uninitialized.

Fixes: 94838d230a6c ("x86/microcode/AMD: Use the family,model,stepping encoded in the patch ID")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407291815.gJBST0P3-lkp@intel.com/
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 1f5d36f92b8a..f63b051f25a0 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -703,7 +703,7 @@ static struct ucode_patch *find_patch(unsigned int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	u32 rev, dummy __always_unused;
-	u16 equiv_id;
+	u16 equiv_id = 0;
 
 	/* fetch rev if not populated yet: */
 	if (!uci->cpu_sig.rev) {
-- 
2.43.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

