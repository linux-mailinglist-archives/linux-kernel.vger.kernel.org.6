Return-Path: <linux-kernel+bounces-364700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E062899D821
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3712CB212A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1951F1D07BC;
	Mon, 14 Oct 2024 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4HwZa2o"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B5C149C47
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937415; cv=none; b=XxaopuJZDu7tKEu2yvFiUtnoz2RlpSDzkDSPAt6lvYBGwKi5SB+HstRj7eElhD3LiDXhkw+q+PxiJuQSXVCQzCBMWRc+m6ocGm56f88OmZ+XKtkaj4LUH1WRJvkqGDcPUaaQzDq3wwDb9UIw5/awBdX12wGZs/U+Rq1b31LAZcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937415; c=relaxed/simple;
	bh=WcMzyO4cJE+xvcZaXtDnD3jDU3z5Pc5fL5vfePv30TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aW+BV9BJIrePlgWhfj67jqKCLCp+IqVG3iTNAHHt/b+VDUijj1vjff6LiVM2ovHMpmhkKX4S/+/uJGENK1irjttlUbZic0Wuldc2rdksiLD5tVmM39cZNhxCFEyu1PosLqICiNrBp+Mdoba2oTyQCzMJHMl1U046l+RnDAONH8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4HwZa2o; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4604b48293dso30796451cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728937412; x=1729542212; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt98ZiFFLOkpjChOt0j7iW9N/0ozbXeRldYiUup84+8=;
        b=h4HwZa2oG6mdW2Bi6n1oimHGU1XdJubYCsO0pMJRmPtNSyLNRrKMULGYgG//580oeS
         9IXiw960l8Js68neaWyOdPeaNIMxyB5ecUMTJnNlL6H+G1J/ZG/xPyXKlricyNAzAnzu
         YK8Z3oP5XK7fkWKb+wbCEKk2+F/yuOLHT/QIVNn+adGMqSSAQGnoAFoDD3i9LUtYf6Fd
         Sh69Tuoo7f3SDzCezae/Vuw2DspJ1OpOgeXv62AtRLEli6at5wI1SuYEKZWR3/xYShdt
         KLBduojDK85LZPCv5kOtV694/6sWRsomdxyIQWeOUUH9grUuvYGsmTllS8sFAFCUhQV2
         Pmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728937412; x=1729542212;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pt98ZiFFLOkpjChOt0j7iW9N/0ozbXeRldYiUup84+8=;
        b=XJxSN+/4Z1ff/4dQEXt+PkUa3Oy0FpBL97U9VNm5lvRc/hWSlB6oMIwXlaz7qXnVp1
         FDBfM9cMKzwuCYethc7Rl+BSMtWJPbvxlzRKfMoui4w/OTAQf93nJCC+jpsbQ0/GuTM3
         i5AoPRijpDdwwn+WpbgrwG/rG5kaQqIdnn8KTMFfclsSL3StBWFzMgnRFxWtF2/8qG3a
         +6XDfG0hKyG/RQLboYjSAZahayvJbg5iacx97dYr39Uisrb3z6+rz6YLsEjfLoqp1upf
         2zdT+rwvAKXcS6dzSqW7gQ0dPkZupPfrHk6+LcHknkEYMgeFbzi34t1SAgfB+tDrgh9K
         qm0w==
X-Forwarded-Encrypted: i=1; AJvYcCVOvdG9IxsieQFDshRwtK5YMSEeRV0sF3iwmbSu0DcrEv3kcU6qSZQ+XY5O5r8vvsoSacyEuBzgcgsm6sE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8pr7O2QP6WFt03HCMOcxGfwucq0TSIZypU3uX5P1uybt+hMtz
	VxF8UtsW4qqIyma9ICIp5oEpu6lHWKF7bXojUDvOGSHHfvy7O8Qh
X-Google-Smtp-Source: AGHT+IHAy7D5m6nzCEmeeIBtaV1KQgHkqVsgWc0XqOfW6IWQYQVTUlDYJIy8MgPdjyJkr7unlpQ/iQ==
X-Received: by 2002:a05:6214:c87:b0:6cb:c892:8c17 with SMTP id 6a1803df08f44-6cbe52a1cb3mr316148016d6.22.1728937412013;
        Mon, 14 Oct 2024 13:23:32 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe8679a41sm49222006d6.139.2024.10.14.13.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 13:23:31 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id CFF1E1200075;
	Mon, 14 Oct 2024 16:23:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 14 Oct 2024 16:23:30 -0400
X-ME-Sender: <xms:wn0NZ3HXYJeiKokFJRo2H2VHQDj-UJ6J10nIkw9PYP5lNqOA0aRtQg>
    <xme:wn0NZ0Vd7VeGSPYPHRqE1d383kbIlfXDRliN-yCXj37dvasC-TE3CQwD5BMgl6vAL
    KJAg0QA_4HdDus3Dg>
X-ME-Received: <xmr:wn0NZ5IM2XqtHBuPNeGrF6fk5A51VQAy5-1a9xUXvy8W_RDIy9sYJnvCiN7IXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    udenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgeehleevffdujeffgedvlefghffhleek
    ieeifeegveetjedvgeevueffieehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepuddupdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehthhhomhgrshdrhhgvlhhlshhtrhhomh
    eslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehinhhtvghlqdigvgeslhhi
    shhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopehpvghtvghriiesih
    hnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonh
    hgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgrrghrthgvnheslhgrnhhk
    hhhorhhsthdrshgvpdhrtghpthhtoheptghhrhhishhtihgrnhdrkhhovghnihhgsegrmh
    gurdgtohhmpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggv
    shhkthhophdrohhrgh
X-ME-Proxy: <xmx:wn0NZ1HyMMew2x3WWs5Zc7DoWSo7xtn6nCqdO00LZv6gSjBuhVygJg>
    <xmx:wn0NZ9W2e6ay1FLFLTAKywjtjBHeQP0pnN2ocEkcBzPMnP5nh19jCg>
    <xmx:wn0NZwPTMszivE8sH-hUF7eruGCGUYtXEqvB9fD1jzbpV4rd9F7PIg>
    <xmx:wn0NZ80bmi4SqKYLPUEBHaBbaYwfaeudHXKxKi5u8TB5KbhFhPAg6A>
    <xmx:wn0NZyXRRLzGqqZXDkjcJGpQaGNfWeZ3LlBvsXOUIfU9c2OtCnwWQm50>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 16:23:30 -0400 (EDT)
Date: Mon, 14 Oct 2024 13:23:12 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Maarten Lankhorst <maarten@lankhorst.se>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] locking/ww_mutex: Adjust to lockdep nest_lock
 requirements
Message-ID: <Zw19sMtnKdyOVQoh@boqun-archlinux>
References: <20241009092031.6356-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241009092031.6356-1-thomas.hellstrom@linux.intel.com>

Hi Thomas,

On Wed, Oct 09, 2024 at 11:20:31AM +0200, Thomas Hellström wrote:
> When using mutex_acquire_nest() with a nest_lock, lockdep refcounts the
> number of acquired lockdep_maps of mutexes of the same class, and also
> keeps a pointer to the first acquired lockdep_map of a class. That pointer
> is then used for various comparison-, printing- and checking purposes,
> but there is no mechanism to actively ensure that lockdep_map stays in
> memory. Instead, a warning is printed if the lockdep_map is freed and
> there are still held locks of the same lock class, even if the lockdep_map
> itself has been released.
> 
> In the context of WW/WD transactions that means that if a user unlocks
> and frees a ww_mutex from within an ongoing ww transaction, and that
> mutex happens to be the first ww_mutex grabbed in the transaction,
> such a warning is printed and there might be a risk of a UAF.
> 
> Note that this is only problem when lockdep is enabled and affects only
> dereferences of struct lockdep_map.
> 
> Adjust to this by adding a fake lockdep_map to the acquired context and
> make sure it is the first acquired lockdep map of the associated
> ww_mutex class. Then hold it for the duration of the WW/WD transaction.
> 
> This has the side effect that trying to lock a ww mutex *without* a
> ww_acquire_context but where a such context has been acquire, we'd see
> a lockdep splat. The test-ww_mutex.c selftest attempts to do that, so
> modify that particular test to not acquire a ww_acquire_context if it
> is not going to be used.
> 
> v2:
> - Lower the number of locks in the test-ww_mutex
>   stress(STRESS_ALL) test to accommodate the dummy lock
>   introduced in this patch without overflowing lockdep held lock
>   references.
> 

Have you tested your patch with lib/locking-selftests.c? It reported two
errors for me:

	[..]   | Wound/wait tests |
	[..]   ---------------------
	[..]                   ww api failures:  ok  |FAILED|  ok  |
	[..]                ww contexts mixing:  ok  |  ok  |
	[..]              finishing ww context:  ok  |  ok  |  ok  |  ok  |
	[..]                locking mismatches:  ok  |  ok  |  ok  |
	[..]                  EDEADLK handling:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
	[..]            spinlock nest unlocked:  ok  |
	[..]                spinlock nest test:  ok  |
	[..]   -----------------------------------------------------
	[..]                                  |block | try  |context|
	[..]   -----------------------------------------------------
	[..]                           context:  ok  |  ok  |  ok  |
	[..]                               try:  ok  |  ok  |  ok  |
	[..]                             block:  ok  |  ok  |  ok  |
	[..]                          spinlock:  ok  |  ok  |FAILED|

The first one is a use case issue, I think and can be fixed similar to
your changes in test-ww_mutex.c:

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 6f6a5fc85b42..6750321e3e9a 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1720,8 +1720,6 @@ static void ww_test_normal(void)
 {
        int ret;

-       WWAI(&t);
-
        /*
         * None of the ww_mutex codepaths should be taken in the 'normal'
         * mutex calls. The easiest way to verify this is by using the
@@ -1770,6 +1768,8 @@ static void ww_test_normal(void)
        ww_mutex_base_unlock(&o.base);
        WARN_ON(o.ctx != (void *)~0UL);

+       WWAI(&t);
+
        /* nest_lock */
        o.ctx = (void *)~0UL;
        ww_mutex_base_lock_nest_lock(&o.base, &t);

Please confirm whether this change is intended.

The second is a case as follow:

	ww_acquire_init(...);
	spin_lock(...);
	ww_mutex_lock(...); // this should trigger a context
			    // invalidation. But the mutex was
			    // initialized by ww_acquire_init() as a
			    // LD_WAIT_INV lock.

The following could fix this:

diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index a401a2f31a77..45ff6f7a872b 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -156,8 +156,8 @@ static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
        debug_check_no_locks_freed((void *)ctx, sizeof(*ctx));
        lockdep_init_map(&ctx->dep_map, ww_class->acquire_name,
                         &ww_class->acquire_key, 0);
-       lockdep_init_map(&ctx->first_lock_dep_map, ww_class->mutex_name,
-                        &ww_class->mutex_key, 0);
+       lockdep_init_map_wait(&ctx->first_lock_dep_map, ww_class->mutex_name,
+                             &ww_class->mutex_key, 0, LD_WAIT_SLEEP);
        mutex_acquire(&ctx->dep_map, 0, 0, _RET_IP_);
        mutex_acquire_nest(&ctx->first_lock_dep_map, 0, 0, &ctx->dep_map, _RET_IP_);
 #endif

A v3 with all these fixed would look good to me, and I can add a
Tested-by tag to it. Thanks!

Regards,
Boqun

> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Maarten Lankhorst <maarten@lankhorst.se>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  include/linux/ww_mutex.h       | 14 ++++++++++++++
>  kernel/locking/test-ww_mutex.c |  8 +++++---
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
> index bb763085479a..a401a2f31a77 100644
> --- a/include/linux/ww_mutex.h
> +++ b/include/linux/ww_mutex.h
> @@ -65,6 +65,16 @@ struct ww_acquire_ctx {
>  #endif
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  	struct lockdep_map dep_map;
> +	/**
> +	 * @first_lock_dep_map: fake lockdep_map for first locked ww_mutex.
> +	 *
> +	 * lockdep requires the lockdep_map for the first locked ww_mutex
> +	 * in a ww transaction to remain in memory until all ww_mutexes of
> +	 * the transaction have been unlocked. Ensure this by keeping a
> +	 * fake locked ww_mutex lockdep map between ww_acquire_init() and
> +	 * ww_acquire_fini().
> +	 */
> +	struct lockdep_map first_lock_dep_map;
>  #endif
>  #ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
>  	unsigned int deadlock_inject_interval;
> @@ -146,7 +156,10 @@ static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
>  	debug_check_no_locks_freed((void *)ctx, sizeof(*ctx));
>  	lockdep_init_map(&ctx->dep_map, ww_class->acquire_name,
>  			 &ww_class->acquire_key, 0);
> +	lockdep_init_map(&ctx->first_lock_dep_map, ww_class->mutex_name,
> +			 &ww_class->mutex_key, 0);
>  	mutex_acquire(&ctx->dep_map, 0, 0, _RET_IP_);
> +	mutex_acquire_nest(&ctx->first_lock_dep_map, 0, 0, &ctx->dep_map, _RET_IP_);
>  #endif
>  #ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
>  	ctx->deadlock_inject_interval = 1;
> @@ -185,6 +198,7 @@ static inline void ww_acquire_done(struct ww_acquire_ctx *ctx)
>  static inline void ww_acquire_fini(struct ww_acquire_ctx *ctx)
>  {
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	mutex_release(&ctx->first_lock_dep_map, _THIS_IP_);
>  	mutex_release(&ctx->dep_map, _THIS_IP_);
>  #endif
>  #ifdef DEBUG_WW_MUTEXES
> diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
> index 10a5736a21c2..5d58b2c0ef98 100644
> --- a/kernel/locking/test-ww_mutex.c
> +++ b/kernel/locking/test-ww_mutex.c
> @@ -62,7 +62,8 @@ static int __test_mutex(unsigned int flags)
>  	int ret;
>  
>  	ww_mutex_init(&mtx.mutex, &ww_class);
> -	ww_acquire_init(&ctx, &ww_class);
> +	if (flags & TEST_MTX_CTX)
> +		ww_acquire_init(&ctx, &ww_class);
>  
>  	INIT_WORK_ONSTACK(&mtx.work, test_mutex_work);
>  	init_completion(&mtx.ready);
> @@ -90,7 +91,8 @@ static int __test_mutex(unsigned int flags)
>  		ret = wait_for_completion_timeout(&mtx.done, TIMEOUT);
>  	}
>  	ww_mutex_unlock(&mtx.mutex);
> -	ww_acquire_fini(&ctx);
> +	if (flags & TEST_MTX_CTX)
> +		ww_acquire_fini(&ctx);
>  
>  	if (ret) {
>  		pr_err("%s(flags=%x): mutual exclusion failure\n",
> @@ -679,7 +681,7 @@ static int __init test_ww_mutex_init(void)
>  	if (ret)
>  		return ret;
>  
> -	ret = stress(2047, hweight32(STRESS_ALL)*ncpus, STRESS_ALL);
> +	ret = stress(2046, hweight32(STRESS_ALL)*ncpus, STRESS_ALL);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.46.0
> 

