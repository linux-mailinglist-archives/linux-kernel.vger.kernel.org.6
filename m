Return-Path: <linux-kernel+bounces-171223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581418BE15F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F803284845
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED865156C77;
	Tue,  7 May 2024 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QZ0wPCHY"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED6C153579
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082520; cv=none; b=RxobUtrHkNe9eU6SH9g/LZCOeNQk9/X4RrVOa2aeVcsqTrSPhPg2FvxpVmknuXW+TI+ixynOkQeolvuSNfKNFjX5r8kr8ckAuXSbl3G88xfRPeS98/bNtcp4kbrJwDXdYC26zmwaL2cg95vmGwkxsrlpA48LwQkImpTZIwDGxHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082520; c=relaxed/simple;
	bh=z1nN7toRozqp72FdyOy3sC0V5hmKBZsPJwEDpAqUO60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnZCe0sADjg4ozJ56y5TOjcHLvnYLm6/WY4Tlr3ms2It67s/e9MrHymbgiJLlZlDrbhI3P1IDiVQkKVc90WxreYVulNeUGZrb29ppa3wrYjs4UOwEu/blC9NK6LsAiO+wOaRejWE3FSeyK9/lOXJHBBZ2540GVkyF3zbusqsL8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QZ0wPCHY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7207A40E02A6;
	Tue,  7 May 2024 11:48:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hqhG_HD1IrE4; Tue,  7 May 2024 11:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715082510; bh=kP/yQ174leaMh52mtS/wH9FaH7QQoGonoP+0sEVJ940=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZ0wPCHYjxr+4jOWhYNhg2umbIGNLKcphd1qGZTNaYyX4v3tqKETNU8vL9+HHJr87
	 KNaA0h1E34+GZL+fdLNURO5NQqbVr+BwKs0iNW0ytBdSDBySywzQ0lRdsVSX8J31lh
	 tQ5U1ewHAcnPfZAaAaNY6smU0cwceNHxLOjaJnjU8uNaa8NbvJ+xYMJWA4z/uXK4mO
	 h48xI5S+siFv2HsipS/3iWL01Ly/2tYT6gjXOQbgiEaIJO21dlsUtKpu2NuqmVLhcB
	 Mr8Ylf0DWaE2NyIFCqBTSJ4lXalYhEDhDCcYRAe9NkqvtGRUc1sx6DAjOZjMrlD0Df
	 RvBdMSrniqxpejgvYIPYjcBa4Uboefk7nRpLpyFDUzczdVdbQlmKiADJ+iVMmjAg22
	 G77DemR5YxaNBOzfu40KBNd+pTjw9w3amErmrsud9v0pNNnJlR3n8VRoPi3Y0QBX0w
	 YqfCHnvz8O9YU3YyObOIo+aPRJmSC2uSXoAHbAEsHe6jpuYASbteUBTuO1YXgjb3mK
	 MSuYKLFRGXzP+yyiy/DoZv2mOaFo3T24WXHLBII80dze4jqL82RjzVfVY9/rktkQ6F
	 cvfLDvYzzkOHS9J9Vtlz9eWGmOFDf8FTdpwjG6Umqa9LfgdhND93A+RweVnIE43rlm
	 RwTd/rRTkHDY04c3en8gtifo=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 47B8340E024C;
	Tue,  7 May 2024 11:48:22 +0000 (UTC)
Date: Tue, 7 May 2024 13:48:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, Srikanth Aithal <sraithal@amd.com>
Subject: Re: [tip:x86/alternatives] [x86/alternatives] ee8962082a:
 WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
Message-ID: <20240507114814.GBZjoU_u5kYBhLips3@fat_crate.local>
References: <20240430172313.GCZjEpAfUECkEZ9S5L@fat_crate.local>
 <ZjE7DkTBSbPlBN8k@google.com>
 <20240430193211.GEZjFHO0ayDXtgvbE7@fat_crate.local>
 <ZjFLpkgI3Zl4dsXs@google.com>
 <20240430223305.GFZjFxoSha7S5BYbIu@fat_crate.local>
 <20240504124822.GAZjYulrGPPX_4w4zK@fat_crate.local>
 <ZjiCJz4myN2DLnZ5@xsang-OptiPlex-9020>
 <Zjj3Lrv2NNHLEzzk@google.com>
 <20240506155759.GOZjj-B_Qrz4DCXwmb@fat_crate.local>
 <ZjnTW4XQwVHEiSaW@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjnTW4XQwVHEiSaW@xsang-OptiPlex-9020>

From: Borislav Petkov <bp@alien8.de>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, Srikanth Aithal <sraithal@amd.com>
Bcc: bp@alien8.de
Subject: Re: [tip:x86/alternatives] [x86/alternatives] ee8962082a:
 WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
Reply-To: 
In-Reply-To: <ZjnTW4XQwVHEiSaW@xsang-OptiPlex-9020>

On Tue, May 07, 2024 at 03:08:11PM +0800, Oliver Sang wrote:
> I applied the debug pach ontop of lastest Linus master:
> 
> 1621a826233a7 debug patch from Boris for ee8962082a
> dccb07f2914cd (HEAD, linus/master) Merge tag 'for-6.9-rc7-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> 
> attached dmesg and cpuinfo (a little diff, so I attached it again)

Thanks, now what are we seeing here:

[    0.763720][    T0] x86/cpu: init_ia32_feat_ctl: CPU0: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU1: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU2: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU3: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU4: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU5: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU6: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU7: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU8: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU9: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU10: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU11: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU12: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU13: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU14: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU15: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU16: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU17: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU18: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU19: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU20: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU21: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU22: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU23: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU24: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU25: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU26: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU27: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU28: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU29: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU30: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU31: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU32: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU33: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU34: FEAT_CTL: 0x5, tboot: 0
[    0.055231][    T0] x86/cpu: init_ia32_feat_ctl: CPU35: FEAT_CTL: 0x5, tboot: 0

So following the code in init_ia32_feat_ctl(), the BSP'll get to

	if (msr & FEAT_CTL_LOCKED)
		goto update_caps;

and that is the case - FEAT_CTL_LOCKED, bit 0, is set.

It'll go to the update_caps label and there it'll do:

	if (!cpu_has(c, X86_FEATURE_VMX))
		goto update_sgx;

VMX is set if I judge by the attached cpuinfo-2 so the next check comes:

        if ( (tboot && !(msr & FEAT_CTL_VMX_ENABLED_INSIDE_SMX)) ||
            (!tboot && !(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX))) {
                if (IS_ENABLED(CONFIG_KVM_INTEL))
                        pr_err_once("VMX (%s TXT) disabled by BIOS\n",
                                    tboot ? "inside" : "outside");
                clear_cpu_cap(c, X86_FEATURE_VMX);

tboot is 0, so the second conditional:

	(!tboot && !(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX))

FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX, bit 2 is set. So that conditional is
not true either. And the pr_err_once() doesn't appear in dmesg.

BUT(!), look what the original dmesg said:

[    0.055225][    T0] x86/cpu: VMX (outside TXT) disabled by BIOS

So that FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX bit was not set back then. Why?

Oliver, have you done any BIOS config changes in the meantime?

This all looks really weird.

The other possibility would be if something changed between -rc3
(the branch x86/alternatives is based on) and -rc7. Unlikely but by now
everything's possible.

What could also be the case is, the BSP's FEAT_CTL is 0x0 (unconfigured,
whatever), we'd go in, set FEAT_CTL_LOCKED and that'll lock the bit in
all FEAT_CTLs on all cores, then it'll set
FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX. I'm presuming microcode forces this
and am obviously grasping at straws...

Then CPU1 will come, FEAT_CTL_LOCKED will be set but
FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX won't be set, leading to the warn.

But then again, SDM says that that MSR's scope is "Thread" which means,
locking that MSR on the BSP won't have effect on the same MSR on the
other HT thread.

Weird.

Ok, here's a bit modified debug patch ontop of the alternatives branch:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=feat_ctl

please run it and send me dmesg again.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

