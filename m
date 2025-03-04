Return-Path: <linux-kernel+bounces-544075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 171D0A4DD19
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62613B4496
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6241A202985;
	Tue,  4 Mar 2025 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ja9i780D"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845A51FF7CA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089163; cv=none; b=BWnAD0yTfrd/R2xwcBA060J4wTT1ypF+C4l1ZplOlifaapatQiUvrZ9MqEPbvsI28YuiiTiBd9GiSzxmmd4TwyyoiGKD5GZ7WnXgjLdD2cnVXs8rzCrbnLRIMzs+0twl0gOpIiIS1UHpxTpCvpkN9lqtJcGGXIszTOA8YpaWnew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089163; c=relaxed/simple;
	bh=7171mSEpkEp3FCZKKXrOCx+U0nZcCWR3wlBz+sOSLnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKUqPRNS9tbXR7ZWAyD7LEnXtmwjajkRTa1iSAfI/VmbDQLzmTjdK9mn+3poUqtPH1idYcqZtFuggk39mAK9Q5g1vW0QqAe/lMj3QHkR4RrfY1VIYxZP9DeUZOSDuLAH+CPrgLDtjGfO6Mc3Xx4rHKqW2PS8US7mGh+/WO0PtHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ja9i780D; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3B45840E0176;
	Tue,  4 Mar 2025 11:52:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KJ37BVY-cF9M; Tue,  4 Mar 2025 11:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741089154; bh=t86EropyYdY0BNiy/V2dzJxb6W+n+s3AAWsyjnhsK7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ja9i780DKJQi1kl/pDe+GFUTej5jzVmzpl1RjJwT7+bSwGzH5ATB2Z0VVZEPUtpy/
	 H8V4Jiv/+K65D7XJiuQv33J+GRod7iZpddqUpdD7bd+1rRzdS7G9InFPepHsbYYvj6
	 TVZ7PgZ1a2XsgKHAckyqHT+LPK1WImDvBjaGn1HVG0xuVdQwaO6hX//g6Ky8Ru8F9D
	 vOCBgUwS3yo4kmc2hd3WQcu8yauXIpQgAUNoSH2nKl1RYSV1c+9UFpz+93vvlJRVhc
	 5xmjp4Oqs43GUD7KiWp0PvaZCRQ0EVffBx2dmO3Ldz1jVkRbsvUhchS4oe4JTVYTA9
	 CHfHNTLY8aglPtwdcW6ViqSgu747Ooz+hi1Y7X3UjIGJyQ1kjT3zBHxkKKwae3iMs6
	 B2QUGJBMEWmQtgoMJpWAdV5IA+EwkPTi/9OGTkC/h3j/dsGNZ4BcRlf5F/NA1kKeN6
	 7NAqCpNDoJeehFddrHg9+i3Q9A9I0bu5sUj0WsBLLTqvHoOHeVxuUlR4kHpBs7Taix
	 TBPLwLViAKOS9o5rX+dFw2HRMSuaPq+U4bpwG8SO/gBru7GUdUhzrXSIxFciYfjpM1
	 Eo2FWT2XArWR1AJ858XwmA9LpJ08RB6AfNQ++KMntg+DV+7fjBDZ+Z+K6VJO7/RA5b
	 H3jIJlnIg4ACfHNTcl0DhCVM=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB5D840E020E;
	Tue,  4 Mar 2025 11:52:15 +0000 (UTC)
Date: Tue, 4 Mar 2025 12:52:07 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Rik van Riel <riel@surriel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v14 11/13] x86/mm: do targeted broadcast flushing from
 tlbbatch code
Message-ID: <20250304115207.GFZ8bpZ83u7L9x43Rq@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-12-riel@surriel.com>
 <20250303114618.GBZ8WWihMDjf-oy8P0@fat_crate.local>
 <7e1ca8c7-6f3e-44dc-9dd8-bd273a03a83e@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e1ca8c7-6f3e-44dc-9dd8-bd273a03a83e@intel.com>

On Mon, Mar 03, 2025 at 01:47:42PM -0800, Dave Hansen wrote:
> > +static inline void invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
> > +{
> > +	__invlpgb_flush_addr_nosync(addr, nr);
> > +	if (!cpu_need_tlbsync())
> > +		cpu_set_tlbsync(true);
> > +}
> 
> One thought on these:
> 
> Instead of having three functions:
> 
> 	1. A raw __invlpgb_*_nosync()
> 	2. A wrapper invlpgb_*_nosync() that flips cpu_set_tlbsync()
> 	3. A wrapper invlpgb_*()
> 
> Could we get away with just two?  For instance, what if we had *ALL*
> __invlpgb()'s do cpu_set_tlbsync()? Then we'd universally call tlbsync().
> 
> static inline void invlpgb_flush_all_nonglobals(void)
> {
>         guard(preempt)();
>         __invlpgb(0, 0, 0, 1, NO_STRIDE, INVLPGB_MODE_ALL_NONGLOBALS);
>         tlbsync();
> }
> 
> Then we wouldn't need any of those three new wrappers. The only downside
> is that we'd end up with paths that logically do:
> 
> 	__invlpgb()
> 	cpu_set_tlbsync(true);
> 	if (cpu_need_tlbsync()) { // always true
> 		__tlbsync();
> 		cpu_set_tlbsync(true);
> 	}
> 
> In other words, a possibly superfluous set/check/clear of the
> "need_tlbsync" state. But I'd expect that to be a pittance compared to
> the actual cost of INVLPGB/TLBSYNC.

Lemme see whether I can grasp properly what you mean:

What you really want is for the _nosync() variants to set need_tlbsync, right?

Because looking at all the call sites which do set tlbsync, the flow is this:

        __invlpgb_flush_user_nr_nosync(pcid, addr, nr, pmd_stride, freed_tables);
        if (!cpu_need_tlbsync())
                cpu_set_tlbsync(true);

So we should move that

	cpu_set_tlbsync(true);

into the __invlpgb_*_nosync() variant.

And in order to make it even simpler, we should drop the testing too:

IOW, this:

/* Flush all mappings for a given PCID, not including globals. */
static inline void __invlpgb_flush_single_pcid_nosync(unsigned long pcid)
{
        __invlpgb(0, pcid, 0, 1, 0, INVLPGB_PCID);
        cpu_set_tlbsync(true);
}

Right?

> >  static void broadcast_tlb_flush(struct flush_tlb_info *info)
> >  {
> >  	bool pmd = info->stride_shift == PMD_SHIFT;
> > @@ -790,6 +821,8 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
> >  	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
> >  		WARN_ON_ONCE(!irqs_disabled());
> >  
> > +	tlbsync();
> 
> This one is in dire need of comments.

Maybe this:

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 08672350536f..b97249ffff1f 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -822,6 +822,9 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
        if (IS_ENABLED(CONFIG_PROVE_LOCKING))
                WARN_ON_ONCE(!irqs_disabled());
 
+       /*
+        * Finish any remote TLB flushes pending from this CPU:
+        */
        tlbsync();
 
        /*

> Ditto, *especially* if this hits the init_mm state. There really
> shouldn't be any deferred flushes for the init_mm.

Basically what you said but as a comment. :-P

Merged in the rest.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

