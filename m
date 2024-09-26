Return-Path: <linux-kernel+bounces-340429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B38987349
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BBF7B24F74
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C7C15B97B;
	Thu, 26 Sep 2024 12:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLdaRyQ/"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2413E5A4D5
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727352590; cv=none; b=Q1bskq7EUo2Eu5Q+F0ZSjDKkUrmQ97E7Y4qyBPk1bwyqQoCyKBjfze/Xu46PCVhAMML1UkxG+bR2YxNfxvGPvlp8DYiCpU5ZSdGwijzasajm2nkApmJtXliUSb4/UEHEuXvntR58+H9e8+KaXhqMOYl7hKpmAIflGJkELfceCoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727352590; c=relaxed/simple;
	bh=2Xs4Z4XMRFuZo1yYC9z+yMeYOLVw2KbAFJwUMIFS3yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgiwNvIxXzfnuIL1MWfus3/gX5jw9a3O+6F5PgTRD0VUpw4PoucrQvJX2R2Ue6qU1T7w5EnHszo6eTKbg3YKE/a/2dV/20Um1y6NB6NofJ/82jlkDaB7d4eS249sgKVEvXIxb+NeURQwHm+uQEGxwCqV2SJtHvte9rcUrFDY+es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLdaRyQ/; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cb284c1a37so7356466d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727352588; x=1727957388; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W840e8HFFLFfZ+i9Iiwm8VnFcBie+GNJRmWoT8502Ws=;
        b=FLdaRyQ/iqSLvlOUEi8bK9RtbsMhNSKQxZm03hf5/Ov7tMaMg5qTuyO0i5grB7Y000
         KFBdpclR9Mrt8xorcZUnf2KRLenAh1DwsOo7NHn8/7VvElgf5otwK3rxSmp7pFQtMDBB
         hdSCj4kydklI1R79USWpNXouG0gs0EOJpao0zBvP8D6Huy++MXnHgWUlYPatNRl+Mkd3
         pfKy/2IR/aE9OfdN78cAhFrF0gnMIEdVPhBICaKHrUycU8+L4EB8KMBqgY53oUE7tZB3
         5erT5qQQ4Emdh+Na6Zv39v6JNklRUUEf/mZijyLe1Cfy6aFcnVhKUV7bYYrq2JGnKCxM
         NXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727352588; x=1727957388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W840e8HFFLFfZ+i9Iiwm8VnFcBie+GNJRmWoT8502Ws=;
        b=OOV48fTKwAJ1DeTz4EUIkSHYocHIlMNpdRlT/xGoZn/YgpjeoxSq+7Rvi1s8Kd+wD3
         pMRIvDF2rIopdtCo0P1Zwo9nX0qmghmGSOFSWiZEVP396bsMZ88srqDy3jEH1Zf2XAI8
         +crqDncKAVGXKYGLwzGDxEG3UtvMtBoa/K7kL+kLSxiy05ljyTh/sDCn21fru8yHl8GY
         spmdVE/B4C+5ctsjqXzMaPCZQ3LljnH0wY0aEYswJcaUtxX2kToYaCxtN/OSVw1cw+E+
         punPLOix/ybjQugzwecCpnVNAlQukkjxPOcYs0lg0EOt39/At4SfX6iun8UrCb4K426I
         01Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUnY/kXrGD0xIxRgt2C42gBGR2Rv00MPOT4sKjASkimlF/B6ZtcNS1NMceqKVnibLQMt08f52JrBNjZJEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3cmbrqJE3YgdopnT/9DnTHobsUvf/8h2ofrqQOS7nUiEDE0DV
	zviotp1id8N/Z8Sp4qHgzB7BGCUQotk3mVdfz30uUZjR7WPqVToI
X-Google-Smtp-Source: AGHT+IG2iRtg94meK9wmAIQX9j00Y1OrWlnY/76YMbFsTGMEtSB958NmTDMAlLnflWA5DzxNKugE6w==
X-Received: by 2002:a05:6214:5993:b0:6c3:6a68:499f with SMTP id 6a1803df08f44-6cb1dd4e179mr104380556d6.19.1727352587854;
        Thu, 26 Sep 2024 05:09:47 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb1faf7c63sm14832326d6.101.2024.09.26.05.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 05:09:47 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6872A1200069;
	Thu, 26 Sep 2024 08:09:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 26 Sep 2024 08:09:46 -0400
X-ME-Sender: <xms:Ck_1ZjVjmIomqCBhl_le3EzZBppp64gOeQtWMMA-qUCigWXW3zB57w>
    <xme:Ck_1Zrn31Z7Le-8Q7pvkT_AbmtN6zGuMqcuRQ5fDcsmhXDcvQPdfVCBJG-jbdpCfl
    C40OXlp71Sg3IFveQ>
X-ME-Received: <xmr:Ck_1ZvYHl6EOr_UI8C_FezoWogAGcJ9dLqQDRCwORiRfFE9AF4-7AfcBOIOLTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddu
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgfelheetkefgudetjeejkefhjeefvdeifedt
    hfehgffgheehieeliefhtdetheefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epugifmhifvdesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehtghhlgieslhhi
    nhhuthhrohhnihigrdguvgdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrug
    drohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthho
    peifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhgrhhoshhssehsuhhsvgdrtghomhdprhgtph
    htthhopegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Ck_1ZuXTIG6OAOn1hppPU4WTYuyp_oefCukEYDabbkEWN9BBRtQAmw>
    <xmx:Ck_1Ztm6uYtBBFpN1uumNJnUyjAoj5sb74CEwZfa5iDjjyNOKhfJdQ>
    <xmx:Ck_1Zrcg5ko1b1crZSrpGu3Q9I80uBlfNCdAAfdnUhemJf6s6gPQiA>
    <xmx:Ck_1ZnHpsfK8YZo0BX0wQ4PDlufYhs0qb43ujNaQNjb5Itko1fYeZQ>
    <xmx:Ck_1Zvm3WGg_FEcU4hwvo_FVpfiIHNtUqNZGgHWCdZJHB0YC6M1MI3_U>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 08:09:45 -0400 (EDT)
Date: Thu, 26 Sep 2024 05:09:00 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3] lockdep: add lockdep_cleanup_dead_cpu()
Message-ID: <ZvVO3F7BJW7OwbEg@boqun-archlinux>
References: <e5ba02138c31da60daf91ce505ac3860d022332b.camel@infradead.org>
 <635fa006e8f3816b4a36b964d6281f0d8efa789b.camel@infradead.org>
 <2b8c36376fa01fa6a1bac9570eb7d41e7e232a29.camel@infradead.org>
 <1da59ef5df8e8a2bebd31535fa13264113a316ff.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1da59ef5df8e8a2bebd31535fa13264113a316ff.camel@infradead.org>

On Tue, Sep 24, 2024 at 03:20:05PM +0100, David Woodhouse wrote:
> On Mon, 2023-10-30 at 08:45 +0000, David Woodhouse wrote:
> > From: David Woodhouse <dwmw@amazon.co.uk>
> > 
> > Add a function to check that an offline CPU left the tracing infrastructure
> > in a sane state. The acpi_idle_play_dead() function was recently observed¹
> > calling safe_halt() instead of raw_safe_halt(), which had the side-effect
> > of setting the hardirqs_enabled flag for the offline CPU. On x86 this
> > triggered lockdep warnings when the CPU came back online, but too early
> > for the exception to be handled correctly, leading to a triple-fault.
> > 
> > Add lockdep_cleanup_dead_cpu() to check for this kind of failure mode,
> > print the events leading up to it, and correct it so that the CPU can
> > come online again correctly.
> > 
> > [   61.556652] smpboot: CPU 1 is now offline
> > [   61.556769] CPU 1 left hardirqs enabled!
> > [   61.556915] irq event stamp: 128149
> > [   61.556965] hardirqs last  enabled at (128149): [<ffffffff81720a36>] acpi_idle_play_dead+0x46/0x70
> > [   61.557055] hardirqs last disabled at (128148): [<ffffffff81124d50>] do_idle+0x90/0xe0
> > [   61.557117] softirqs last  enabled at (128078): [<ffffffff81cec74c>] __do_softirq+0x31c/0x423
> > [   61.557199] softirqs last disabled at (128065): [<ffffffff810baae1>] __irq_exit_rcu+0x91/0x100
> > 
> > ¹ https://lore.kernel.org/lkml/a079bba5a0e47d6534b307553fc3772d26ce911b.camel@infradead.org/
> > 
> > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> > 
> 
> Ping? Found this lying around in a branch today...
> 

I think this is already fixed by:

	9bb69ba4c177 ("ACPI: processor_idle: use raw_safe_halt() in acpi_idle_play_dead()")

, no?

Regards,
Boqun

> 
> > v3: Add forward declaration of struct task_struct.
> > 
> > v2: Fix spelling. 'Offlone' wasn't quite what I meant to type.
> >     Add reference to ACPI patch.
> >     Fix kerneldoc args for lockdep_cleanup_dead_cpu() (thanks lkp)
> >     Closes: https://lore.kernel.org/oe-kbuild-all/202310290041.L5ndwcQ9-lkp@intel.com/
> > 
> >  include/linux/irqflags.h |  6 ++++++
> >  kernel/cpu.c             |  1 +
> >  kernel/locking/lockdep.c | 24 ++++++++++++++++++++++++
> >  3 files changed, 31 insertions(+)
> > 
> > diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> > index 2b665c32f5fe..9b44f8b042a0 100644
> > --- a/include/linux/irqflags.h
> > +++ b/include/linux/irqflags.h
> > @@ -17,6 +17,8 @@
> >  #include <asm/irqflags.h>
> >  #include <asm/percpu.h>
> >  
> > +struct task_struct;
> > +
> >  /* Currently lockdep_softirqs_on/off is used only by lockdep */
> >  #ifdef CONFIG_PROVE_LOCKING
> >    extern void lockdep_softirqs_on(unsigned long ip);
> > @@ -24,12 +26,16 @@
> >    extern void lockdep_hardirqs_on_prepare(void);
> >    extern void lockdep_hardirqs_on(unsigned long ip);
> >    extern void lockdep_hardirqs_off(unsigned long ip);
> > +  extern void lockdep_cleanup_dead_cpu(unsigned int cpu,
> > +                                      struct task_struct *idle);
> >  #else
> >    static inline void lockdep_softirqs_on(unsigned long ip) { }
> >    static inline void lockdep_softirqs_off(unsigned long ip) { }
> >    static inline void lockdep_hardirqs_on_prepare(void) { }
> >    static inline void lockdep_hardirqs_on(unsigned long ip) { }
> >    static inline void lockdep_hardirqs_off(unsigned long ip) { }
> > +  static inline void lockdep_cleanup_dead_cpu(unsigned int cpu,
> > +                                             struct task_struct *idle) {}
> >  #endif
> >  
> >  #ifdef CONFIG_TRACE_IRQFLAGS
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 6de7c6bb74ee..225f5bc3708f 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -1371,6 +1371,7 @@ static int takedown_cpu(unsigned int cpu)
> >  
> >         cpuhp_bp_sync_dead(cpu);
> >  
> > +       lockdep_cleanup_dead_cpu(cpu, idle_thread_get(cpu));
> >         tick_cleanup_dead_cpu(cpu);
> >         rcutree_migrate_callbacks(cpu);
> >         return 0;
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index e85b5ad3e206..62bfda8991b8 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -4538,6 +4538,30 @@ void lockdep_softirqs_off(unsigned long ip)
> >                 debug_atomic_inc(redundant_softirqs_off);
> >  }
> >  
> > +/**
> > + * lockdep_cleanup_dead_cpu - Ensure CPU lockdep state is cleanly stopped
> > + *
> > + * @cpu: index of offlined CPU
> > + * @idle: task pointer for offlined CPU's idle thread
> > + *
> > + * Invoked after the CPU is dead. Ensures that the tracing infrastructure
> > + * is left in a suitable state for the CPU to be subsequently brought
> > + * online again.
> > + */
> > +void lockdep_cleanup_dead_cpu(unsigned int cpu, struct task_struct *idle)
> > +{
> > +       if (unlikely(!debug_locks))
> > +               return;
> > +
> > +       if (unlikely(per_cpu(hardirqs_enabled, cpu))) {
> > +               pr_warn("CPU %u left hardirqs enabled!", cpu);
> > +               if (idle)
> > +                       print_irqtrace_events(idle);
> > +               /* Clean it up for when the CPU comes online again. */
> > +               per_cpu(hardirqs_enabled, cpu) = 0;
> > +       }
> > +}
> > +
> >  static int
> >  mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
> >  {
> 



