Return-Path: <linux-kernel+bounces-400146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BA79C0989
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F1B284F55
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF77021315D;
	Thu,  7 Nov 2024 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdpwDVlB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA56212F0C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991719; cv=none; b=OveYXXNmM9w1ZIWTDq/mwvZ23Ksxs4YvRhfr+tOt8DcSMY96IYRQ99igMV6QXPWv43xD90QYXkq6dMVUkaMKZCaj0YxHtQ+QHBdrhOV1SvA0Q+afenq0CJGWEiS0hT0wzEUDx+rb4FRRO667ejzm+ndqsz39S5x9RvsNI9nbjKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991719; c=relaxed/simple;
	bh=BcCssuJkh8gL1YcujKqWtRxdJh22MLP0AR8iUfe8AW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3xndFYPe5uvI5VNeHoSbzKCj9Hb5fG+gDwKIXeRqvok840neI9g8uqA3av9ReeTHCfHm5d+M8P3dYHLKQqN49FqoIgxUxg20/3H3QKzaNdNC1nROTYCjLkZKSVcMuretdiPI7FBGrl/ASK7NsaWUxPy4SOzyBstMYgr+XGM5JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FdpwDVlB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730991716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Xmu1kxDhzwlZgXeOwsE6gEAR/pvNGajgUpVujRUjeE=;
	b=FdpwDVlBwYHCzAeAtgoXYapnx7s/sN1KzHCggcDyIpW9wccWVYW30en8CvlVzGGMVgQhSG
	DvDNY3y3uY4wgrNQ9Z3oyS/RPWmZXuvWjq+v6EX/G2HvVdUgvGY1MwYzr1AfwYeir0FUB7
	kU3Fh4dmlMmIPbDxuOd4zo1adkPzS6g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-mn_anOkVPdeC4022HdKA7A-1; Thu,
 07 Nov 2024 10:01:50 -0500
X-MC-Unique: mn_anOkVPdeC4022HdKA7A-1
X-Mimecast-MFC-AGG-ID: mn_anOkVPdeC4022HdKA7A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B7A81955EB9;
	Thu,  7 Nov 2024 15:01:47 +0000 (UTC)
Received: from f39 (unknown [10.39.192.153])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C2F81953882;
	Thu,  7 Nov 2024 15:01:43 +0000 (UTC)
Date: Thu, 7 Nov 2024 16:01:38 +0100
From: Eder Zulian <ezulian@redhat.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <ZyzWUirB25EYTTOO@f39>
References: <20241107182411.57e2b418@canb.auug.org.au>
 <20241107103414.GT10375@noisy.programming.kicks-ass.net>
 <20241108000432.335ec09a@canb.auug.org.au>
 <20241107141212.GB34695@noisy.programming.kicks-ass.net>
 <cade359b-8e58-4031-b21b-3c47e0dcf3af@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cade359b-8e58-4031-b21b-3c47e0dcf3af@app.fastmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Nov 07, 2024 at 06:22:31AM -0800, Boqun Feng wrote:
> 
> 
> On Thu, Nov 7, 2024, at 6:12 AM, Peter Zijlstra wrote:
> > On Fri, Nov 08, 2024 at 12:04:32AM +1100, Stephen Rothwell wrote:
> >> Hi Peter,
> >> 
> >> On Thu, 7 Nov 2024 11:34:14 +0100 Peter Zijlstra <peterz@infradead.org> wrote:
> >> >
> >> > On Thu, Nov 07, 2024 at 06:24:11PM +1100, Stephen Rothwell wrote:
> >> > So I can't get RUST=y, even though make rustavailable is happy.
> >> > 
> >> > make LLVM=-19 allmodconfig does not get me RUST=y
> >> > 
> >> > I started out with tip/master, tried adding rust-next, then kbuild-next
> >> > gave up and tried next/master. Nada.
> >> 
> >> Just on Linus' tree allmodconfig gives me:
> >> 
> >> $ grep RUST .config
> >> CONFIG_RUSTC_VERSION=108100
> >> CONFIG_RUST_IS_AVAILABLE=y
> >> CONFIG_RUSTC_LLVM_VERSION=180108
> >> CONFIG_RUST=y
> >> CONFIG_RUSTC_VERSION_TEXT="rustc 1.81.0"
> >> CONFIG_HAVE_RUST=y
> >> CONFIG_RUST_FW_LOADER_ABSTRACTIONS=y
> >> CONFIG_BLK_DEV_RUST_NULL=m
> >> CONFIG_RADIO_TRUST=m
> >> CONFIG_HID_THRUSTMASTER=m
> >> CONFIG_THRUSTMASTER_FF=y
> >> CONFIG_TRUSTED_KEYS=m
> >> CONFIG_HAVE_TRUSTED_KEYS=y
> >> CONFIG_TRUSTED_KEYS_TPM=y
> >> CONFIG_TRUSTED_KEYS_TEE=y
> >> CONFIG_TRUSTED_KEYS_CAAM=y
> >> CONFIG_INTEGRITY_TRUSTED_KEYRING=y
> >> CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
> >> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> >> CONFIG_SYSTEM_TRUSTED_KEYS=""
> >> CONFIG_SECONDARY_TRUSTED_KEYRING=y
> >> CONFIG_SECONDARY_TRUSTED_KEYRING_SIGNED_BY_BUILTIN=y
> >> CONFIG_SAMPLES_RUST=y
> >> CONFIG_SAMPLE_RUST_MINIMAL=m
> >> CONFIG_SAMPLE_RUST_PRINT=m
> >> CONFIG_SAMPLE_RUST_HOSTPROGS=y
> >> CONFIG_RUST_DEBUG_ASSERTIONS=y
> >> CONFIG_RUST_OVERFLOW_CHECKS=y
> >> CONFIG_RUST_BUILD_ASSERT_ALLOW=y
> >> 
> >> $ rustc --version
> >> rustc 1.81.0
> >
> > Yeah, I'm not sure what's going on. I occasionally get rust stuff, but
> > mostly when I try allyesconfig. Weirdness.
> >
> >> > Anyway, I think the above needs something like this:
> >> > 
> >> > ---
> >> > diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
> >> > index b7b0945e8b3c..5804a6062eb1 100644
> >> > --- a/rust/helpers/spinlock.c
> >> > +++ b/rust/helpers/spinlock.c
> >> > @@ -5,11 +5,16 @@
> >> >  void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
> >> >  				  struct lock_class_key *key)
> >> >  {
> >> > +#ifndef CONFIG_PREEMPT_RT
> >> >  #ifdef CONFIG_DEBUG_SPINLOCK
> >> >  	__raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
> >> >  #else
> >> >  	spin_lock_init(lock);
> >> >  #endif
> >> > +#else
> >> > +	rt_mutex_base_init(&lock->lock);
> >> > +	__rt_spin_lock_init(lock, name, key, false);
> >> > +#endif
> >> >  }
> >> >  
> >> >  void rust_helper_spin_lock(spinlock_t *lock)
> >> 
> >> I will try to remember to add that to the tip tree merge tomorrow.
> >
> > Boqun, could you test the above and make it happen?
> >
> 
> FYI, Eder is already working on this:
> 
> https://lore.kernel.org/rust-for-linux/20241106211215.2005909-1-ezulian@redhat.com/
> 
> Eder, could you Cc locking for the next version?

Yes, sure.

By the way, I'm using linux-next/master here and I think I had to make
(MITIGATION_RETHUNK && KASAN) false at some point for x86_64 to get RUST=y.

$ grep -i '_rust\|preempt_rt\|debug_spin' .config | grep -v '#'
CONFIG_RUSTC_VERSION=108200
CONFIG_RUST_IS_AVAILABLE=y
CONFIG_RUSTC_LLVM_VERSION=170006
CONFIG_PREEMPT_RT=y
CONFIG_RUST=y
CONFIG_RUSTC_VERSION_TEXT="rustc 1.82.0 (f6e511eec 2024-10-15) (Fedora 1.82.0-1.fc39)"
CONFIG_HAVE_RUST=y
CONFIG_HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_RUST_OVERFLOW_CHECKS=y

> 
> Regards,
> Boqun
> 
> >> > > Without the revert CONFIG_PREEMPT_RT=y, after the revert it is not set
> >> > > and spinlock_check is only defined for !defined(CONFIG_PREEMPT_RT).  
> >> > 
> >> > Right, that moved PREEMPT_RT out of the preemption choice. Now I'm not
> >> > sure we want it =y for all{yes,mod}config. Is the below the right
> >> > incantation to avoid this?
> >> > 
> >> > ---
> >> > diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> >> > index 7c1b29a3a491..54ea59ff8fbe 100644
> >> > --- a/kernel/Kconfig.preempt
> >> > +++ b/kernel/Kconfig.preempt
> >> > @@ -88,7 +88,7 @@ endchoice
> >> >  
> >> >  config PREEMPT_RT
> >> >  	bool "Fully Preemptible Kernel (Real-Time)"
> >> > -	depends on EXPERT && ARCH_SUPPORTS_RT
> >> > +	depends on EXPERT && ARCH_SUPPORTS_RT && !COMPILE_TEST
> >> >  	select PREEMPTION
> >> >  	help
> >> >  	  This option turns the kernel into a real-time kernel by replacing
> >> 
> >> Yeah, that will do it.
> >
> > OK, I'll write it up and stick that in tip/sched/core along with them
> > patches that's causing the grief :-)
> >
> > Attachments:
> > * signature.asc
> 


