Return-Path: <linux-kernel+bounces-263576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E6593D7E6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EEEF1F23B2D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFDE17C7C0;
	Fri, 26 Jul 2024 17:59:39 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7185A3987B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016778; cv=none; b=AJFyJ1CngT3H9wrRlbGpsUaFGbz3rGLvWEr8u97jC9VTvWcAVrDTEbqPHf4jn0L0BFm7tptHPyDWnO2O5Rb+RAREWH1bZdC74ihkcGA5N1Z0rFwJjRIktAmaISFYLuQv/cHVh36mqaxaPUmJHza9tLy8H7SlgbKmhOoYNQus798=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016778; c=relaxed/simple;
	bh=/yTp3HWlCW8kJjkhnQCYVzP5hkmgHw6K9cHAIUEBcKM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3xVgRcB+uKBpE1rPJPaZCdnHg3C18uVFzBgBiuSqCQmFaUdX2r9fE4N2j5E3JPrL7ls0Fxx2ISHmMmZmKIQY/jXjGB0FJZarDFqJXuKqi4LHAVLANSQBX/apj6GJyUdhCxOeVolwGwNniydmChRD/vYmE3d2gTC99uQ9M2oKuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVwT816cgz6K5sc;
	Sat, 27 Jul 2024 01:57:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C238B140B73;
	Sat, 27 Jul 2024 01:59:32 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 18:59:32 +0100
Date: Fri, 26 Jul 2024 18:59:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <Terry.Bowman@amd.com>
CC: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, <linuxarm@huawei.com>,
	<rafael.j.wysocki@intel.com>, <guohanjun@huawei.com>, <gshan@redhat.com>,
	<miguel.luis@oracle.com>, <catalin.marinas@arm.com>, "Linux List Kernel
 Mailing" <linux-kernel@vger.kernel.org>, Linux regressions mailing list
	<regressions@lists.linux.dev>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>
Subject: Re: 6.11/regression/bisected - The commit c1385c1f0ba3 caused a new
 possible recursive locking detected warning at computer boot.
Message-ID: <20240726185931.00006f74@Huawei.com>
In-Reply-To: <20240726173728.00006769@Huawei.com>
References: <CABXGCsPvqBfL5hQDOARwfqasLRJ_eNPBbCngZ257HOe=xbWDkA@mail.gmail.com>
	<20240723112456.000053b3@Huawei.com>
	<20240723181728.000026b3@huawei.com>
	<20240725181354.000040bf@huawei.com>
	<12255504-a80a-41da-b702-094af6957eef@amd.com>
	<20240726173728.00006769@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 26 Jul 2024 17:37:28 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Fri, 26 Jul 2024 10:07:39 -0500
> Terry Bowman <Terry.Bowman@amd.com> wrote:
> 
> > On 7/25/24 12:13, Jonathan Cameron wrote:  
> > > On Tue, 23 Jul 2024 18:20:06 +0100
> > > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > >     
> > >> On Tue, 23 Jul 2024 11:24:56 +0100
> > >> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > >>    
> > >>> On Tue, 23 Jul 2024 00:36:18 +0500
> > >>> Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> wrote:
> > >>>       
> > >>>> Hi,
> > >>>> The first Fedora update to the 6.11 kernel
> > >>>> (kernel-debug-6.11.0-0.rc0.20240716gitd67978318827.2.fc41.x86_64)
> > >>>> brings a new warning: possible recursive locking detected.        
> > >>>
> > >>> Hi Mikhail,
> > >>>
> > >>> Thanks for the report.
> > >>>
> > >>> This is an interesting corner and perhaps reflects a flawed
> > >>> assumption we were making that for this path anything that can happen for an
> > >>> initially present CPU can also happen for a hotplugged one. On the hotplugged
> > >>> path the lock was always held and hence the static_key_enable() would
> > >>> have failed.
> > >>>
> > >>> I'm somewhat stumped on working out why this path couldn't happen
> > >>> for a hotplugged CPU so why this is a new problem?
> > >>>
> > >>> Maybe this is just a case of no one is providing _CPC for CPUs in virtual
> > >>> machines so the path wasn't seen? QEMU doesn't generate ACPI tables with
> > >>> _CPC today, so maybe that's it.
> > >>>
> > >>> So maybe this is has revealed an existing latent  bug.  There have been
> > >>> QEMU patches for _CPC in the past but never merged. I'll hack them
> > >>> into an x86 virtual machine and see if we hit the same bug you have
> > >>> here before and after the series.
> > >>>
> > >>> Either way obviously we need to fix it for the current kernel (and maybe
> > >>> backport the fix if I can verify it's a latent bug).  I'll get a test
> > >>> setup running asap and see if I can replicate.
> > >>>
> > >>> +CC x86 maintainers.      
> > >>
> > >> It will take me a little longer to emulate a suitable setup to hit the
> > >> AMD case on (I have it run on arm64 now, but no similar issue occurs)
> > >>
> > >> Ultimately the problem is occurring in arch_init_invariance_cppc
> > >> I note that the arm64 version of that topology_init_cpu_capacity_cppc
> > >> delays some activity via a work queue specifically to avoid some
> > >> locking issues.
> > >>
> > >> On AMD systems arch_init_invariance_cppc is defined
> > >> as init_freq_invariance_cppc which calls amd_set_max_freq_ratio just
> > >> once (there is a static bool) which in turn calls
> > >> freq_invariance_set_perf_ratio() / freq_invariance_enable()
> > >>
> > >> Until I have a setup to test on I'm not going to draw firm conclusions
> > >> but how much would it matter if we set that static key a bit late
> > >> via a workqueue?  In the meantime go with a default value similar to
> > >> that disable_freq_invariance_work sets (which is done via a workqueue).
> > >>
> > >> The intel equivalent is called via an early_init() so not
> > >> the hotplug path.
> > >>
> > >> Any hints on from people familiar with this code would be most
> > >> welcome.  Whilst git suggests tglx touched these paths most recently that
> > >> was in tidying them up to split the Intel and AMD paths.
> > >>    
> > > 
> > > Hi Mikhail.
> > > 
> > > So the short story, ignoring the journey (which should only be described
> > > with beer in hand), is that I now have an emulated test setup in QEMU
> > > that fakes enough of the previously missing bits to bring up this path
> > > and can trigger the splat you shared.  With the below fix I can get to
> > > something approaching a running system.
> > > 
> > > However, without more work the emulation isn't actually doing any control
> > > of frequency etc so I have no idea if the code actually works after this
> > > patch.
> > > 
> > > If you are in a position to test a patch, could you try the following?
> > > 
> > > One bit I need to check out tomorrow is to make sure this doesn't race with the
> > > workfn that is used to tear down the same static key on error.
> > > 
> > > From 8f7ad4c73954aae74265a3ec50a1d56e0c56050d Mon Sep 17 00:00:00 2001
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Date: Thu, 25 Jul 2024 17:56:00 +0100
> > > Subject: [RFC PATCH] x86/aperfmperf: Push static_branch_enable(&arch_scale_freq_key) onto work queue
> > > 
> > > This to avoid a deadlock reported by lockdep.
> > > 
> > > TODO: Fix up this commit message before posting to actually give
> > > some details and tags etc.
> > > 
> > > Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  arch/x86/kernel/cpu/aperfmperf.c | 13 ++++++++++---
> > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
> > > index b3fa61d45352..41c729d3517c 100644
> > > --- a/arch/x86/kernel/cpu/aperfmperf.c
> > > +++ b/arch/x86/kernel/cpu/aperfmperf.c
> > > @@ -300,15 +300,22 @@ static void register_freq_invariance_syscore_ops(void)
> > >  static inline void register_freq_invariance_syscore_ops(void) {}
> > >  #endif
> > >  
> > > +static void enable_freq_invariance_workfn(struct work_struct *work)
> > > +{
> > > +	static_branch_enable(&arch_scale_freq_key);
> > > +	register_freq_invariance_syscore_ops();
> > > +	pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
> > > +}
> > > +static DECLARE_WORK(enable_freq_invariance_work,
> > > +		    enable_freq_invariance_workfn);
> > > +
> > >  static void freq_invariance_enable(void)
> > >  {
> > >  	if (static_branch_unlikely(&arch_scale_freq_key)) {
> > >  		WARN_ON_ONCE(1);
> > >  		return;
> > >  	}
> > > -	static_branch_enable(&arch_scale_freq_key);
> > > -	register_freq_invariance_syscore_ops();
> > > -	pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
> > > +	schedule_work(&enable_freq_invariance_work);
> > >  }
> > >  
> > >  void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled)    
> > 
> > Hi Jonathan,
> > 
> > I was able to recreate the problem using base d67978318827 with a Ryzen laptop.  
> 
> So that's the original reported tag. 
> 
> > 
> > I was unable to recreate the issue using base 72ec37390a71 with the same Ryzen laptop.  
> 
> Huh? - I see that is yesterday's tree so further through the merge window.
> I wonder what changed - I'll poke the emulation some more and
> see if it disappeared for me too.  
> 
> I can't immediately spot any changes in the relevant paths that would
> make this go away...
> 
> Thanks for the info though.  Maybe this explains why we saw no reports
> of this in linux-next.

Nope. I built mainline as of now and still see the issue.
On plus side it finishes booting unlike the earlier version where
something was dying well after this bug raised it's head.

So something is hiding it in your test setup.

Plus side - I also tested tglx's simpler fix and all looks good.

A good end to a Friday :)

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> 
> > 
> > Ive attached the dmesg logs and dmidecode.
> > 
> > Regards,
> > Terry
> >   
> 


