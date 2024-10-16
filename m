Return-Path: <linux-kernel+bounces-368899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F599A163D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C204B22787
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9911D5154;
	Wed, 16 Oct 2024 23:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hloGVJNt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A261D26E0
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 23:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729122515; cv=none; b=sk/pjXCXNJvcFVpSWzV+RIRfuJq/kVmdSIWKwbF9Tq1zDOowIv9Az2LmAYGMZJIM60ZQInFsMbDFKYUHk1gjZV44j9dquer6O1vW0Td6bnS6lUyiXyqtv5sdEpKljjIwMBG7CQzfMCE0zQZPkKTxXPNLKHRyyFbzjKmBojrm+x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729122515; c=relaxed/simple;
	bh=PaGsx/p0g1rFIDlC9skbTCx5rM5FzER3gMJF5RCNy3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4kqHD1yTtgzHy34DXi+VnMnlG10N5KcjnM2eE1ZnGUuneyhIa3kP5fPHjsjnM4R5gN2IDQZs4OI9Ko0dxqKz52Em4yCTGMHYZ7Uz/PIVnQU5bP/381UNmVoLcnBEluR7wOTcsu/4jDZLvLoL/hIImoYa0+QR+yaPt/kIGhd6AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hloGVJNt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729122512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5zbNhf2ti3veBbqghgqqHYmZD0VaAPt+Z/wXzjXNA4=;
	b=hloGVJNtPMc/kGKg21JoVWq0U1t5yNE+PRSgae5rXGbfARCZG8zy4dTiLS6kGavecfb56L
	i/NUfaj7Es1pZwqyj59hPgkMTTqequ7qZXpD3VnCkltNxPaDbihhPafivKq1Tm6X4X5w8J
	Fe4Zi/fonsvfWw7bxGoBTx7o/n9eIrE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-QXFk1vzHNKWcuwhiSxyKfQ-1; Wed,
 16 Oct 2024 19:48:27 -0400
X-MC-Unique: QXFk1vzHNKWcuwhiSxyKfQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3C67195608F;
	Wed, 16 Oct 2024 23:48:25 +0000 (UTC)
Received: from f39 (unknown [10.39.192.145])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CC4D19560A3;
	Wed, 16 Oct 2024 23:48:22 +0000 (UTC)
Date: Thu, 17 Oct 2024 01:48:19 +0200
From: Eder Zulian <ezulian@redhat.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	williams@redhat.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
Subject: Re: [PATCH] rust: Fix build error
Message-ID: <ZxBQw1X_OG26RO9o@f39>
References: <20241014195253.1704625-1-ezulian@redhat.com>
 <Zw1_rXUyjTBOh0QH@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zw1_rXUyjTBOh0QH@boqun-archlinux>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Boqun,
On Mon, Oct 14, 2024 at 01:31:41PM -0700, Boqun Feng wrote:
> Hi Eder,
> 
> Thanks for the patch!
Sure, my pleasure.
> 
> On Mon, Oct 14, 2024 at 09:52:53PM +0200, Eder Zulian wrote:
> > When CONFIG_DEBUG_SPINLOCK=y and CONFIG_PREEMPT_RT=y the following build
> > error occurs:
> > 
> >     In file included from rust/helpers/helpers.c:22:
> >     rust/helpers/spinlock.c: In function ‘rust_helper___spin_lock_init’:
> >     rust/helpers/spinlock.c:10:30: error: implicit declaration of function ‘spinlock_check’; did you mean ‘spin_lock_bh’? [-Wimplicit-function-declaration]
> >        10 |         __raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
> >           |                              ^~~~~~~~~~~~~~
> >           |                              spin_lock_bh
> >     rust/helpers/spinlock.c:10:30: error: passing argument 1 of ‘__raw_spin_lock_init’ makes pointer from integer without a cast [-Wint-conversion]
> >        10 |         __raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
> >           |                              ^~~~~~~~~~~~~~~~~~~~
> >           |                              |
> >           |                              int
> >     In file included from ./include/linux/wait.h:9,
> >                      from ./include/linux/wait_bit.h:8,
> >                      from ./include/linux/fs.h:6,
> >                      from ./include/linux/highmem.h:5,
> >                      from ./include/linux/bvec.h:10,
> >                      from ./include/linux/blk_types.h:10,
> >                      from ./include/linux/blkdev.h:9,
> >                      from ./include/linux/blk-mq.h:5,
> >                      from rust/helpers/blk.c:3,
> >                      from rust/helpers/helpers.c:10:
> >     ./include/linux/spinlock.h:101:52: note: expected ‘raw_spinlock_t *’ {aka ‘struct raw_spinlock *’} but argument is of type ‘int’
> >       101 |   extern void __raw_spin_lock_init(raw_spinlock_t *lock, const char *name,
> >           |                                    ~~~~~~~~~~~~~~~~^~~~
> >     make[2]: *** [scripts/Makefile.build:229: rust/helpers/helpers.o] Error 1
> > 
> > Error observed while building a rt-debug kernel for aarch64.
> > 
> > On a PREEMPT_RT build, spin locks have been mapped to rt_mutex types, so
> > avoid the raw_spinlock_init call for RT.
> > 
> 
> This is true, but to keep lockdep working I think we need to open code
> the PREEMPT_RT version of spin_lock_init(), please see below
> 
> > Suggested-by: Clark Williams <williams@redhat.com>
> > 
> 
> ^ unnecessary emtpy line here.
Thanks for pointing it out. Should I fix it and send a v2?
> 
> > Signed-off-by: Eder Zulian <ezulian@redhat.com>
> > ---
> >  rust/helpers/spinlock.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
> > index acc1376b833c..924c1a380448 100644
> > --- a/rust/helpers/spinlock.c
> > +++ b/rust/helpers/spinlock.c
> > @@ -6,7 +6,7 @@
> >  void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
> >  				  struct lock_class_key *key)
> >  {
> > -#ifdef CONFIG_DEBUG_SPINLOCK
> > +#if defined(CONFIG_DEBUG_SPINLOCK) && !defined(CONFIG_PREEMPT_RT)
> >  	__raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
> >  #else
> >  	spin_lock_init(lock);
> 
> This should be:
> 
> void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
>  				  struct lock_class_key *key)
> {
> #ifdef CONFIG_DEBUG_SPINLOCK
> # if defined(CONFIG_PREEMPT_RT)
Even though I don't have a strong preference on this, in my opinion, there is no
much difference here just a line break and inverted logic. Perhaps it would be
better to write like this: 'if (IS_ENABLED(CONFIG_PREEMPT_RT && ... ) { this }
else { that }', however, spinlock_check() is not declared for PREEMPT_RT
kernels because its declaration is conditional to #ifndef CONFIG_PREEMPT_RT in
'spinlock.h'. spinlock_check() as is does not make sense for PREEMPT_RT
because spinlock is not mapped to raw_spinlock but to rt_mutex (cf.
'spinlock_types.h')
> 	rt_mutex_base_init(&(lock)->lock);
> 	__rt_spin_lock_init(lock, name, key, false);
Apparently, this ^ matches spin_lock_init() in 'spinlock_rt.h', if true, we could
call spin_lock_init() for PREEMPT_RT kernels. However the debug version of
__rt_spin_lock_init() (instrumented with lockdep in 'spinlock_rt.c') depends
on CONFIG_DEBUG_LOCK_ALLOC. Luckily, in my opnion, the #ifdefs are already in
place.
> # else /* !CONFIG_PREEMPT_RT */
>   	__raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
> # endif /* CONFIG_PREEMPT_RT */
> #else
> 	spin_lock_init(lock);
> #endif
> }
> 
Please let me know what you think, and bear with me if I'm missing something.
Thanks.
> Regards,
> Boqun
> 
> > -- 
> > 2.46.2
> > 
> > 
> 


