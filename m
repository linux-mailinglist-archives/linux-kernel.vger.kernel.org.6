Return-Path: <linux-kernel+bounces-423934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E629DAE7E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013BB281A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3A6202F84;
	Wed, 27 Nov 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gy34Dnyl"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA672CCC0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732739048; cv=none; b=VLQR3zvmh8IDl+S0Ji8DwPUt/p1m0yHyzWcejr+cLkbnzzAIn2GRb2aLi8/q10tNeMkHpPHtzuvTq9XZ/+M/kih0jDSz1lDB+McNI5UxvPqpFXCM8Y7E88oIFzbej+q1P7rJZ3ntdOOCKNq3x8pffFkg569ii4icOxzccxWJCRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732739048; c=relaxed/simple;
	bh=3kQAA6tjOG3i3hymlIKv4AqsvYPm+nWbOIv+s3MvJf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFC4RK+cxZz1pyNubyk/ueDuzmPi5RxyQmdy3LDYfZeDXdUjeKHUMspGbph2HXbyU3Z8/p/vT0J/2nNRFgxXjJibGKQ8GsjpGtLQEcHkbVbqLTgcTdKlo3TJjLFNDNHE3bCzc55jzmglkXOeDHXm4gBCF956//q83o8/cZQYv2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gy34Dnyl; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 27 Nov 2024 15:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732739044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=69vJdznNDa6rQiLJ94o22HONq7hUB59zt/CYuIV9Hjs=;
	b=gy34Dnylj+PE4PxQOKTnRdL9hWmKcy0O4wPNqSjaZiq3l6itNtByxi1NMNbIfIBDRjyx8D
	P1QqRlmaH+Dv76oCfRzsBcWsGLHaF2PA1bNrGHji3I7zIEIfa+gQIwpZPoe44mcbkaw6j4
	UHrb7nlIxCmPwLrNyXMtA1ecFmiPGSU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Jann Horn <jannh@google.com>
Cc: linux-bcachefs@vger.kernel.org, 
	kernel list <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, io-uring <io-uring@vger.kernel.org>
Subject: Re: bcachefs: suspicious mm pointer in struct dio_write
Message-ID: <5jvih6bn7pv5p4btf65bvuxnnt4hli7gf2zlibejyjswmnk5dg@xwfuf3womp5b>
References: <CAG48ez21ZtMJ6gcUND6bLV6XD6b--CXmKSRjKq+D33jhRh1LPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez21ZtMJ6gcUND6bLV6XD6b--CXmKSRjKq+D33jhRh1LPw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 27, 2024 at 05:57:03PM +0100, Jann Horn wrote:
> Hi!
> 
> In fs/bcachefs/fs-io-direct.c, "struct dio_write" contains a pointer
> to an mm_struct. This pointer is grabbed in bch2_direct_write()
> (without any kind of refcount increment), and used in
> bch2_dio_write_continue() for kthread_use_mm()/kthread_unuse_mm()
> which are used to enable userspace memory access from kthread context.
> I believe kthread_use_mm()/kthread_unuse_mm() require that the caller
> guarantees that the MM hasn't gone through exit_mmap() yet (normally
> by holding an mmget() reference).
> 
> If we reach this codepath via io_uring, do we have a guarantee that
> the mm_struct that called bch2_direct_write() is still alive and
> hasn't yet gone through exit_mmap() when it is accessed from
> bch2_dio_write_continue()?
> 
> I don't know the async direct I/O codepath particularly well, so I
> cc'ed the uring maintainers, who probably know this better than me.

I don't know about io_uring but aio guarantees that outstanding kiocbs
are completed before exiting the mm_struct - I would expect some sort of
similar guarantee to hold, because otherwise where are we going to
deliver the completion?

