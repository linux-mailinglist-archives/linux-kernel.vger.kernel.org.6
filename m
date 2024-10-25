Return-Path: <linux-kernel+bounces-381165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9369AFB78
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7901C221CF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF461B6D0A;
	Fri, 25 Oct 2024 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bD/KKtXH"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DAB18BC34
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842584; cv=none; b=qKTU7B2DsaYrAbTihFglJ0kaQJdPsilW2oRHRXBy2yDCFJYcQYLPw0oL+1rwazqbs9GhCN4AqNkDWXcEfdowHWRDJoPefcnmiVJGwUlXp4j32IZ1SFt1PE72/KM/7PMf9LQbj+Ry+WTGIneatUfLs1hSuMXjhl1HhH/uQtJORLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842584; c=relaxed/simple;
	bh=gjafrcVtfqag/tkHs+Y7A+P9H26TBkClB6/mz6WGJ88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JttSOQbdyAjPMA6eATGKJE4OS7rNFsl/Lgmp8W9n44pnGOocuJbaG9Ud7OLNFrg6F9BgOZG+ROUZBVXaHo+k45r4F3I1dRamU9eLiV+v4LrBZTvsqJdgMZYj0IsnEhPibtX2Sn0K3lMlzz/m3syn+ikEburbnZ4t6549wnWf+zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bD/KKtXH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=/M6RoevycaioY2WEEYV1CQLEKxvmaixqwiDcMLETF+8=; b=bD/KKtXHgrAmTR8AOgOtY4LDBy
	9k057d+AOp3ayxoa28djaIOOGEyOvzJQpmMlRQvTg0vcvx5hVrd1KYw5CJw6V6xTbZ3JHCTrDbb8K
	u6sBW3vKh7HLv0mQTanAQm+fkXebLr2EihBbz/vaWhhs16GgaTLkcNqwLWfGsk11LxAW9FrJRzEKm
	BO1S3213C9IoN2Mu/Zedgah4oektWJpanQYSLf6+/fHwtJyP+TYzwbUjQB1LelYKYfBJTy3b1KgDa
	0Hywxmb+2auQ3av1mMF/3b6HCACD8YMLOvODplp7C9Ax51ydYj8nNLkzvPGBN7khOR21FUj+BB4gc
	4YXxeapA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4F4l-00000004ylD-0LaG;
	Fri, 25 Oct 2024 07:49:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 57D3730083E; Fri, 25 Oct 2024 09:49:39 +0200 (CEST)
Date: Fri, 25 Oct 2024 09:49:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -tip] cleanup: Remove address space of returned pointer
Message-ID: <20241025074939.GC14555@noisy.programming.kicks-ass.net>
References: <20240819074124.143565-1-ubizjak@gmail.com>
 <20241018112259.GD36494@noisy.programming.kicks-ass.net>
 <CAFULd4bBaFWVZv=hERmHExn7ToJbJ6a+VCtZPQ3FvbPO=5EJCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4bBaFWVZv=hERmHExn7ToJbJ6a+VCtZPQ3FvbPO=5EJCg@mail.gmail.com>

On Fri, Oct 25, 2024 at 09:35:29AM +0200, Uros Bizjak wrote:
> On Fri, Oct 18, 2024 at 1:23 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Aug 19, 2024 at 09:41:15AM +0200, Uros Bizjak wrote:
> > > Guard functions in local_lock.h are defined using DEFINE_GUARD() and
> > > DEFINE_LOCK_GUARD_1() macros having lock type defined as pointer in
> > > the percpu address space. The functions, defined by these macros
> > > return value in generic address space, causing:
> > >
> > > cleanup.h:157:18: error: return from pointer to non-enclosed address space
> > >
> > > and
> > >
> > > cleanup.h:214:18: error: return from pointer to non-enclosed address space
> > >
> > > when strict percpu checks are enabled.
> > >
> > > Add explicit casts to remove address space of the returned pointer.
> > >
> > > Found by GCC's named address space checks.
> > >
> > > Fixes: e4ab322fbaaa ("cleanup: Add conditional guard support")
> > > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> >
> > Thanks!
> >
> > Now lives in queue locking/core, and barring robot screams will make its
> > way into tip.
> 
> I noticed that the patch was removed from the queue. Was there
> something wrong with it?

Uhh.. damn. I thought I pushed things to tip, but instead I seem to have
lost a bunch of patches.

Let me try and figure out what all went missing :/

Sorry, and thanks for noticing!

