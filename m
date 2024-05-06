Return-Path: <linux-kernel+bounces-170110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2DB8BD1F6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B26C1C21C69
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4D6155A25;
	Mon,  6 May 2024 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="esCn/+us"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE9C6CDD0
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011100; cv=none; b=TZapyUP5niKO/9v8QonoZq1yws6GwJkDaN0VyDIrLX2sQTew3U8wj9dZprbaHfNyPfI935GVq8T6JvD8QU5QB60tf/7ahNNVNGSOLbVi45aBMhDPwCKUWmdQULf5PecjsOLLRfs/KlAWe75CTlJJlgTa1adYRYytTBX5wNIYjjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011100; c=relaxed/simple;
	bh=Aw9f+LLZ5sHan1vBUy1bKxeUrbEGvBPDzxWoW45wqxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6vm9cRDN953ZaLnOEO8YntFzFnqRlzIvYGFy6WGn5naWfSMsFs2belDDcbutLgRZnqfWnUeGSHxkos8LyaIvoz9lQLIkZ7muThgi1VhIAFEpYhCPj+nm3XC11fTbJ1cqk6v3w7fZ+D7cI+OMc+5U9Cii+zn7XcgPgE0w9AEDJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=esCn/+us; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8102240E02A6;
	Mon,  6 May 2024 15:58:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EkHFRr0eYoCh; Mon,  6 May 2024 15:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715011093; bh=of4cpwaJyl5GvP5v0b10za3Tbh1fMIcPtE6G83zdPUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=esCn/+usfD3pSS7PV/FP3vii3yCV4JzpeZ+Lumvyp7iF8Dxkt+55n5LK8fhqrxJZj
	 6L7SUimhHzItS20BotXBPkr/MEIpzObRCpQte4cCNrOYwX/gUYwpQgnyP6cWdGePsl
	 hb9AHeZ7zTYQmr8l/0ts/JhSu+9PG7eBv7tJhSBxQN8nS/CD2u/gtCnof7srE2Mbct
	 sQuVgUisKCct123WQfLHWxWYVs1ZRuMwzLJKKSvbw4ZTGyyjwwO8+3tEwJwhwa+3O8
	 QSZ6rdYHPrWm6EtQ6GhAuVotXe+H139/xi5NfJR1qaxnn/roABERbLdFmX0rPm5KvP
	 5DMB4UMwhWvXmp66Ekqe0aGE31ekcMUTH0g2A2tlaBScDb/mPHulHes36lRVM/3ncw
	 jgWM52gOfhI55cMctE3Q2IJyBxtR5t0mMbn7//QHRoJdV28mkuTZP8kUsH1B9061XK
	 fe2jZZrYgcIFImPsNxa/SK4XuQl1KEguqNQjFuGHTKh2o8AohoNXa/C1jyxxLdyFeO
	 ilXpai8RCw8+YvS/2SMVvaeOtSaq6eg8+ml21qzUzRA8PZyVRHOLv9Mjz3T/PBjOQ2
	 fh/bhD0ArjkkDzJWMy6lFeN+gZi28do9AfG8BqL9xOxQz/dt6udE+19PtDf2DDdBCq
	 Wt+srd66VAf0RAyu4EEfBHQ0=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E5DD40E0187;
	Mon,  6 May 2024 15:58:05 +0000 (UTC)
Date: Mon, 6 May 2024 17:57:59 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, Srikanth Aithal <sraithal@amd.com>
Subject: Re: [tip:x86/alternatives] [x86/alternatives] ee8962082a:
 WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
Message-ID: <20240506155759.GOZjj-B_Qrz4DCXwmb@fat_crate.local>
References: <202404302233.f27f91b2-oliver.sang@intel.com>
 <20240430172313.GCZjEpAfUECkEZ9S5L@fat_crate.local>
 <ZjE7DkTBSbPlBN8k@google.com>
 <20240430193211.GEZjFHO0ayDXtgvbE7@fat_crate.local>
 <ZjFLpkgI3Zl4dsXs@google.com>
 <20240430223305.GFZjFxoSha7S5BYbIu@fat_crate.local>
 <20240504124822.GAZjYulrGPPX_4w4zK@fat_crate.local>
 <ZjiCJz4myN2DLnZ5@xsang-OptiPlex-9020>
 <Zjj3Lrv2NNHLEzzk@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zjj3Lrv2NNHLEzzk@google.com>

On Mon, May 06, 2024 at 08:28:46AM -0700, Sean Christopherson wrote:
> The only way the WARN could have fired without this series is if VMX is enabled
> in BIOS on the boot CPU, but disabled by BIOS on one more secondary CPUs.  And
> _that_ is a bogus setup that (a) the kernel absolutely should WARN about, and
> (b) _still_ occurs with one or both patches applied.

Right, that's my suspicion too.

> So I don't see how this series could possibly have fixed the issue Oliver
> encountered, nor do I see any value in moving init_ia32_feat_ctl() into
> early_init_intel().

Hm, right. I should've done this from the very beginning:

Oliver, can you please run the below debugging patch *without* any other
patches ontop of latest Linus master?

Also pls send /proc/cpuinfo and dmesg.

Thx.

---
diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index 1640ae76548f..74d2f0a351aa 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -117,8 +117,14 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 	bool tboot = tboot_enabled();
 	bool enable_vmx;
 	u64 msr;
+	int ret;
 
-	if (rdmsrl_safe(MSR_IA32_FEAT_CTL, &msr)) {
+	ret = rdmsrl_safe(MSR_IA32_FEAT_CTL, &msr);
+
+	pr_info("%s: CPU%d: FEAT_CTL: 0x%llx, tboot: %d\n",
+		__func__, c->cpu_index, msr, tboot);
+
+	if (ret) {
 		clear_cpu_cap(c, X86_FEATURE_VMX);
 		clear_cpu_cap(c, X86_FEATURE_SGX);
 		return;
@@ -165,6 +171,9 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 			msr |= FEAT_CTL_SGX_LC_ENABLED;
 	}
 
+	pr_info("%s: CPU%d: Write FEAT_CTL: 0x%llx\n",
+		__func__, c->cpu_index, msr);
+
 	wrmsrl(MSR_IA32_FEAT_CTL, msr);
 
 update_caps:

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

