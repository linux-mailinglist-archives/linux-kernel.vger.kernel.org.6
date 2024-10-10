Return-Path: <linux-kernel+bounces-360187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFEF9995A4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 01:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85BA41F2491C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 23:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD38C1E1A10;
	Thu, 10 Oct 2024 23:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLsVZ3v1"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511FA1CEE97
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728601931; cv=none; b=hoyuCfylZ8gnBmghUdR4jNJJHuk66nEXnfCvuExGYSmbuTw9QFXdCyOLo5FyzxT61HK4Ss4iKc8nG+ATxmWimi6fMQIeeCz7+4MzRZ7oZs+SKhxijae4bpAcfj5ahRNb6dusWeoBWxHL9iN5jPciKYrTm33ypwkr7rsIpp/2UxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728601931; c=relaxed/simple;
	bh=VFhgqoAMqz8/DMv0t7OI3Lza0ZKia9Wm1/aX7zTHSLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCHRlfqJsMvoDphDmyxbRQdZGKMGjuZf1lyldnUQiusf3uTITM3iDuHYoJ131q1aAHZV0YgthrB7o+yWYzTyGPe94wgMW+LWuNN6Ja8wmmNfh5VDZPBSxh0r7spM+T+Fj75eACRhK2nqum6K2v1168DqjIn4xuuF9/ynNTIgYjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLsVZ3v1; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbd57cc35bso16237816d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 16:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728601928; x=1729206728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcxIjDDZyK1auBweAC1lVQgQTGthPpguFIstR5d9/1Y=;
        b=TLsVZ3v17OwlkPCZIjwl3RFZ208glS3/yR3spRJ0JOHYFvecTyODe2ZwT8HI0H4QSO
         O8ECWSz9gRoTVpleNg8WxXGu3q/3ME7vqWUlReLP4c6Se959rUPLzkjPPjZEWbYrbDQc
         y/5ORSbXbhcpjk/0rk/wX+Rbmqsxo8xDMVHzAqpNmEAKH5hJfMtYicwpeVM9mIoIvIip
         957PDpuCJAd1lcWwierVjU/w9IblH9L5yAerLa1fjEDPfocq+LnlXjk1mGOztiq1FHF5
         vFS3MkhQGVNTr+cJK+0XyKMYFZSLJpedgaHVeQuzgWURQL2YihhZDIoctNrGduuINCfL
         s6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728601928; x=1729206728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcxIjDDZyK1auBweAC1lVQgQTGthPpguFIstR5d9/1Y=;
        b=OZThG1Jz1gLNIogtosmNNlr8NFZwIgqA68FuB9jMlM17zgKG9SYaDFSnrkVBO8uoNT
         KLMlZ1Gy797ByN5sFE000IsItuIyH5IxlRF6+i6kx9VejGDZetUjv00DLw7fhCrTd8RI
         5EKd/jsCH1iQH8Eg+ml3o7nVtevczzu638/LNj0mNr7chVgtSBGJcgPzTwzQwqTlfZ51
         H62WnAz7izJfvxoqXqUEc/B5I1qI3MgHOh7B69Le4YMpgBKH2/epU+MmU5/HszPGaDg/
         /sBeXahZ7+td7Y1XpPaCdo4V7a1y8RWmnKIhee3MzLihcUzUwBhy1vT6nkLyxrZX2fwG
         FlvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+XTs5gWXr8xuAnbtBdvyN2gEsTutUZCD84mHixeaWGlNv8jg+h+niBOHV7NOW3SNeCf97VRjm7+JPPYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2TfxdMohNBuUaOuWh3Px+WdzZhjVEL8Ui5YfHImjrMVUZSBfb
	GHQnbRnKHddJ3yzgEuU7JCHqawvqVnYH/647NRZpIJB3fkTBmiVOTU0Om1jV
X-Google-Smtp-Source: AGHT+IFMNG9KnA/yQaCRlIciQJD+K1Cy/mZq48nD0Hy8WbbDQ0haOVGGlHfgssqYX5R/LGFVASSCOw==
X-Received: by 2002:a05:6214:4607:b0:6cb:81ba:8ac1 with SMTP id 6a1803df08f44-6cbef9bc73emr20001956d6.0.1728601928098;
        Thu, 10 Oct 2024 16:12:08 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85a7817sm10180396d6.27.2024.10.10.16.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 16:12:07 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id B7215120007E;
	Thu, 10 Oct 2024 19:12:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 10 Oct 2024 19:12:06 -0400
X-ME-Sender: <xms:Rl8IZ6bTJ9xhDnQuAVObxJ3GdZ2eFflN-tFawNRRA7ru_goZkDmv_w>
    <xme:Rl8IZ9ZdGt7eKfIa5CrRLaCQeGREN3eesxoewPAZY54PmK6_caPJiaen81FXXdrzO
    e9nd-wPmY47nQHkQQ>
X-ME-Received: <xmr:Rl8IZ0-QME73X_6byauR3JOPYDsmofITS39-4JlqLVfEnIhh3mgwdAzAdAz-IQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeffgeevleeifeeffeejffevffekiedtfeetveei
    feeiheffieelieduvddthfehgfenucffohhmrghinhepghhithhhuhgsrdgtohhmpdgvfh
    hfihgtihhoshdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepmhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhi
    tghiohhsrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrth
    hiohhnrdhorhhgpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhgrghgvugdrmhhitghhrggvlhesghhmrghilhdrtghomhdprhgtphht
    thhopegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Rl8IZ8rXC7yl463eUEwb6_AAOY1XfIGy7gjN9JGTa1n3FN0xkjzlkg>
    <xmx:Rl8IZ1ohZgvbKsW_5_qCe7TorfVSj84QU-TAs2mNet-t9PeT4eTV3A>
    <xmx:Rl8IZ6SrUeiWWraDQstHGR95HS20OYIAFxF2k6DlapxBZF6jwoD3-Q>
    <xmx:Rl8IZ1r-yDCoptP_MDIIgftirnyjYFlYAlcs0u8ozCX5rb_sQGIbJA>
    <xmx:Rl8IZy71wem-nStMFHYs5llDxo-zSfp_QnviK2Nz8exjZPpz6VXlFshT>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 19:12:05 -0400 (EDT)
Date: Thu, 10 Oct 2024 16:11:57 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	paulmck <paulmck@kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Maged Michael <maged.michael@gmail.com>
Subject: Re: [RFC] Synchronized Shared Pointers for the Linux kernel
Message-ID: <ZwhfPS4yyFx_Qrbu@boqun-archlinux>
References: <8b944c2b-7f89-4d05-afd8-612de852f5dd@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b944c2b-7f89-4d05-afd8-612de852f5dd@efficios.com>

On Thu, Oct 10, 2024 at 03:16:25PM -0400, Mathieu Desnoyers wrote:
> Hi,
> 
> I've created a new API (sharedptr.h) for the use-case of
> providing existence object guarantees (e.g. for Rust)
> when dereferencing pointers which can be concurrently updated.
> I call this "Synchronized Shared Pointers".
> 
> This should be an elegant solution to Greg's refcount
> existence use-case as well.
> 
> The current implementation can be found here:
> 
> https://github.com/compudj/linux-dev/commit/64c3756b88776fe534629c70f6a1d27fad27e9ba
> 
> Patch added inline below for feedback.
> 
> Thanks!
> 
> Mathieu
> 
> 
> diff --git a/include/linux/sharedptr.h b/include/linux/sharedptr.h
> new file mode 100644
> index 000000000000..ff925c509734
> --- /dev/null
> +++ b/include/linux/sharedptr.h
> @@ -0,0 +1,163 @@
> +// SPDX-FileCopyrightText: 2024 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> +//
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +
> +#ifndef _LINUX_SHAREDPTR_H
> +#define _LINUX_SHAREDPTR_H
> +
> +/*
> + * sharedptr: Synchronized Shared Pointers
> + *
> + * Synchronized shared pointers guarantee existence of objects when the
> + * synchronized pointer is dereferenced. It is meant to help solving the
> + * problem of object existence guarantees faced by Rust when interfacing
> + * with C.
> + *
> + * Those shared pointers are based on a reference counter embedded into
> + * the object, using hazard pointers to provide object existence
> + * guarantee based on pointer dereference for synchronized shared
> + * pointers.
> + *
> + * References:
> + *
> + * [1]: M. M. Michael, "Hazard pointers: safe memory reclamation for
> + *      lock-free objects," in IEEE Transactions on Parallel and
> + *      Distributed Systems, vol. 15, no. 6, pp. 491-504, June 2004
> + */
> +
> +#include <linux/hazptr.h>
> +#include <linux/refcount.h>
> +#include <linux/types.h>
> +#include <linux/rcupdate.h>
> +
> +DECLARE_HAZPTR_DOMAIN(hazptr_domain_sharedptr);
> +
> +struct sharedptr_node {
> +	refcount_t refcount;
> +};
> +
> +/*
> + * Local copy of a shared pointer, holding a reference to a
> + * shared pointer node.
> + */
> +struct sharedptr {
> +	struct sharedptr_node *spn;
> +};
> +
> +/*
> + * A syncsharedptr has a single updater, but many threads can
> + * concurrently copy a shared pointer from it using
> + * sharedptr_copy_from_sync(). Just like a sharedptr, a syncsharedptr
> + * holds a reference to a shared pointer node.
> + */
> +struct syncsharedptr {
> +	struct sharedptr_node *spn;
> +};
> +
> +/*
> + * Initialize shared pointer node with refcount=1. Returns a shared pointer.
> + */
> +static inline
> +struct sharedptr sharedptr_create(struct sharedptr_node *spn)
> +{
> +	struct sharedptr sp = {
> +		.spn = spn,
> +	};
> +	if (spn)
> +		refcount_set(&spn->refcount, 1);
> +	return sp;
> +}
> +
> +static inline
> +struct sharedptr sharedptr_copy(struct sharedptr sp)
> +{
> +	struct sharedptr_node *spn = sp.spn;
> +
> +	if (spn)
> +		refcount_inc(&spn->refcount);
> +	return sp;
> +}
> +
> +static inline
> +bool sharedptr_is_null(struct sharedptr sp)
> +{
> +	return sp.spn == NULL;
> +}
> +
> +/* Move sharedptr to a syncsharedptr. */
> +static inline
> +void sharedptr_move_to_sync(struct syncsharedptr *dst, struct sharedptr *src)
> +{
> +	WARN_ON_ONCE(dst->spn);	/* Single updater, expect dst==NULL. */
> +	rcu_assign_pointer(dst->spn, src->spn);
> +	src->spn = NULL;	/* Transfer ownership. */
> +}
> +
> +/*
> + * Copy sharedptr to a syncsharedptr, incrementing the reference.
> + */
> +static inline
> +void sharedptr_copy_to_sync(struct syncsharedptr *dst, const struct sharedptr *src)
> +{
> +	struct sharedptr_node *spn = src->spn;
> +
> +	WARN_ON_ONCE(dst->spn);	/* Single updater, expect dst==NULL. */
> +	if (spn)
> +		refcount_inc(&spn->refcount);
> +	rcu_assign_pointer(dst->spn, spn);
> +}
> +
> +/*
> + * Obtain a shared pointer copy from a syncsharedptr.
> + */
> +static inline
> +struct sharedptr sharedptr_copy_from_sync(const struct syncsharedptr *ssp)
> +{
> +	struct sharedptr_node *spn, *hp;
> +	struct hazptr_slot *slot;
> +	struct sharedptr sp;
> +
> +	preempt_disable();

Disabling preemption acts as an RCU read-side critical section, so I
guess the immediate question is why (or when) not use RCU ;-)

Regards,
Boqun

> +	hp = spn = hazptr_load_try_protect(&hazptr_domain_sharedptr, &ssp->spn, &slot);
> +	if (!spn)
> +		goto end;
> +	if (!refcount_inc_not_zero(&spn->refcount))
> +		spn = NULL;
> +	hazptr_release(slot, hp);
> +end:
> +	sp.spn = spn;
> +	preempt_enable();
> +	return sp;
> +}
> +
> +static inline
> +void syncsharedptr_delete(struct syncsharedptr *ssp,
> +			  void (*sharedptr_node_release)(struct sharedptr_node *spn))
> +{
> +	struct sharedptr_node *spn = ssp->spn;
> +
> +	if (!spn)
> +		return;
> +	WRITE_ONCE(ssp->spn, NULL);
> +	if (refcount_dec_and_test(&spn->refcount)) {
> +		hazptr_scan(&hazptr_domain_sharedptr, spn, NULL);
> +		sharedptr_node_release(spn);
> +	}
> +}
> +
> +static inline
> +void sharedptr_delete(struct sharedptr *sp,
> +		      void (*sharedptr_node_release)(struct sharedptr_node *spn))
> +{
> +	struct sharedptr_node *spn = sp->spn;
> +
> +	if (!spn)
> +		return;
> +	WRITE_ONCE(sp->spn, NULL);
> +	if (refcount_dec_and_test(&spn->refcount)) {
> +		hazptr_scan(&hazptr_domain_sharedptr, spn, NULL);
> +		sharedptr_node_release(spn);
> +	}
> +}
> +
> +#endif /* _LINUX_SHAREDPTR_H */
> diff --git a/kernel/hazptr.c b/kernel/hazptr.c
> index 3f9f14afbf1d..ba772f020325 100644
> --- a/kernel/hazptr.c
> +++ b/kernel/hazptr.c
> @@ -8,6 +8,9 @@
>  #include <linux/hazptr.h>
>  #include <linux/percpu.h>
> +#include <linux/sharedptr.h>
> +
> +DEFINE_HAZPTR_DOMAIN(hazptr_domain_sharedptr);
>  /*
>   * hazptr_scan: Scan hazard pointer domain for @addr.
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

