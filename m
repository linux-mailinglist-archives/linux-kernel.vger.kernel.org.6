Return-Path: <linux-kernel+bounces-399430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DB69BFED6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98D25B2253B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CD3195FEA;
	Thu,  7 Nov 2024 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGa+NLwY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37ED194A64
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730963734; cv=none; b=lathQFlJd5m2hlw/Cp4TwuV2s9srpPpBjHDnkbPfrOWnE8W0JD4IEL6QZ3MBqfqbehMambxwZlQ7KbNaqrbSXzZcCGL/t6lkCC8n6VTaUx5yTV7AzeNx2A6loVGitt6HCTgNo1cDFzGKRVxpId3z0wtYYbpjmH/dp+Lj7W2+5I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730963734; c=relaxed/simple;
	bh=lXWtxPNo74z5ZeoYBKRsaS68HHO19mRvwGTc8gfz5Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBD68ZRogrPfOq6Q6oSYgTuNHkiC/8RhVMoX8XapMSjJabs+4o61NdJGE7mDVwR7xfiYdC+fm0W92CGKj8ayHWTVJc3ecuFkZXbk59ZHQn+MKP7H1Xv4i2RSETbxbspJ1K1xCCYoLbOEDekQIF+MFcS8nS53rg/3ieDZwOIrCco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DGa+NLwY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730963731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vlnl+BN22QGPgjCM/dg8SoykCXyuozWfzcPdu+gOQ9c=;
	b=DGa+NLwYBUx1vFeduexRZCF60XRXZxMeV4LYiCdrev0ZqMVXQE2aCse/WvNqth2HOD5F1x
	oadCtkDhlhYso+pJJLsgLRWrj2JaXBubRAl0EFoqC8YfU+eLNhLLxjYJ40kEWFLu+ZZxr7
	RQ2tKdMFxQHpzMl655U5yM33vl5pjdo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-w5Bkvbh2PAuhsQxPerlU_Q-1; Thu,
 07 Nov 2024 02:15:25 -0500
X-MC-Unique: w5Bkvbh2PAuhsQxPerlU_Q-1
X-Mimecast-MFC-AGG-ID: w5Bkvbh2PAuhsQxPerlU_Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E1201956083;
	Thu,  7 Nov 2024 07:15:23 +0000 (UTC)
Received: from f39 (unknown [10.39.192.153])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A23261956054;
	Thu,  7 Nov 2024 07:15:18 +0000 (UTC)
Date: Thu, 7 Nov 2024 08:15:15 +0100
From: Eder Zulian <ezulian@redhat.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	miguel.ojeda.sandonis@gmail.com, tglx@linutronix.de,
	williams@redhat.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	jlelli@redhat.com
Subject: Re: [PATCH v2] rust: Fix build error
Message-ID: <ZyxpA2ez-9E4c7G5@f39>
References: <20241106211215.2005909-1-ezulian@redhat.com>
 <Zyv6unk_tRyv_v7m@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyv6unk_tRyv_v7m@boqun-archlinux>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Boqun,

On Wed, Nov 06, 2024 at 03:24:42PM -0800, Boqun Feng wrote:
> Hi Eder,
> 
> Seems I forgot to reply you on your reply to v1, sorry about that.
> 
> For the commit title, I think it better be:
> 
> 	rust: helpers: Avoid raw_spin_lock initialization for PREEMPT_RT
> 

Sure, I will fix it. Much better indeed.

> , because in general, title of the commit should be as specific as
> possible (otherwise, half year later there could be 10 commits titled
> "rust: Fix build error").
> 
> On Wed, Nov 06, 2024 at 10:12:15PM +0100, Eder Zulian wrote:
> > On a PREEMPT_RT build, spin locks have been mapped to rt_mutex types, so
> > avoid the raw_spinlock_init call for RT.
> > 
> > When CONFIG_DEBUG_SPINLOCK=y and CONFIG_PREEMPT_RT=y the following build
> > error occurs:
> > 
> > https://lore.kernel.org/oe-kbuild-all/202409251238.vetlgXE9-lkp@intel.com/
> > 
> 
> Since you already use the "Closes" tag to refer the bug report, let's
> avoid links showing twice, how rephrase the above three paragraphs as:
> 
> """
> When PREEMPT_RT=y, spin locks are mapped to rt_mutex types, so using
> spinlock_check() + __raw_spin_lock_init() to initialize spin locks is
> incorrect, and would cause build errors.
> 
> Introduce __spin_lock_init() to initialize a spin lock with lockdep
> rquired information for PREEMPT_RT builds, and use it in the Rust
> helper.
> """
> 
> Thoughts?
> 

Makes sense. Will do.

> > Fixes: 876346536c1b ("rust: kbuild: split up helpers.c")
> 
> I'm not sure this is the correct "Fixes" tag, that commit is a code
> move, so it's unlikely introducing issue itself. Moreover, we really
> need PREEMPT_RT being able to trigger the issue, so I think the correct

One may argue that we need 'RUST=y' in order to trigger the issue.

> "Fixes" tag is:
> 
> Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
> 
> (yes, I know PREEMPT_RT is a long existing project, but it was until
> that commit, you can build a kernel with PREEMPT_RT=y IIUC)
> 
> This will help stable maintainers for backport decisions.
> 

Perhaps omitting the 'Fixes:' tag would be a solution. Is that an option?

> 
> The rest of patch looks good to me (we could maybe provide a
> __spin_lock_init() for !RT build as well, but that's more of a
> cleanup)
> 
> Regards,
> Boqun
> 

Thanks,
Eder

> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202409251238.vetlgXE9-lkp@intel.com/
> > Signed-off-by: Eder Zulian <ezulian@redhat.com>
> > ---
> > V1 -> V2: Cleaned up style and addressed review comments
> >  include/linux/spinlock_rt.h | 15 +++++++--------
> >  rust/helpers/spinlock.c     |  8 ++++++--
> >  2 files changed, 13 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
> > index f9f14e135be7..f6499c37157d 100644
> > --- a/include/linux/spinlock_rt.h
> > +++ b/include/linux/spinlock_rt.h
> > @@ -16,22 +16,21 @@ static inline void __rt_spin_lock_init(spinlock_t *lock, const char *name,
> >  }
> >  #endif
> >  
> > -#define spin_lock_init(slock)					\
> > +#define __spin_lock_init(slock, name, key, percpu)		\
> >  do {								\
> > -	static struct lock_class_key __key;			\
> > -								\
> >  	rt_mutex_base_init(&(slock)->lock);			\
> > -	__rt_spin_lock_init(slock, #slock, &__key, false);	\
> > +	__rt_spin_lock_init(slock, name, key, percpu);		\
> >  } while (0)
> >  
> > -#define local_spin_lock_init(slock)				\
> > +#define _spin_lock_init(slock, percpu)				\
> >  do {								\
> >  	static struct lock_class_key __key;			\
> > -								\
> > -	rt_mutex_base_init(&(slock)->lock);			\
> > -	__rt_spin_lock_init(slock, #slock, &__key, true);	\
> > +	__spin_lock_init(slock, #slock, &__key, percpu);	\
> >  } while (0)
> >  
> > +#define spin_lock_init(slock)		_spin_lock_init(slock, false)
> > +#define local_spin_lock_init(slock)	_spin_lock_init(slock, true)
> > +
> >  extern void rt_spin_lock(spinlock_t *lock) __acquires(lock);
> >  extern void rt_spin_lock_nested(spinlock_t *lock, int subclass)	__acquires(lock);
> >  extern void rt_spin_lock_nest_lock(spinlock_t *lock, struct lockdep_map *nest_lock) __acquires(lock);
> > diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
> > index b7b0945e8b3c..5971fdf6f755 100644
> > --- a/rust/helpers/spinlock.c
> > +++ b/rust/helpers/spinlock.c
> > @@ -6,10 +6,14 @@ void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
> >  				  struct lock_class_key *key)
> >  {
> >  #ifdef CONFIG_DEBUG_SPINLOCK
> > +# if defined(CONFIG_PREEMPT_RT)
> > +	__spin_lock_init(lock, name, key, false);
> > +# else /*!CONFIG_PREEMPT_RT */
> >  	__raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
> > -#else
> > +# endif /* CONFIG_PREEMPT_RT */
> > +#else /* !CONFIG_DEBUG_SPINLOCK */
> >  	spin_lock_init(lock);
> > -#endif
> > +#endif /* CONFIG_DEBUG_SPINLOCK */
> >  }
> >  
> >  void rust_helper_spin_lock(spinlock_t *lock)
> > -- 
> > 2.47.0
> > 
> > 
> 


