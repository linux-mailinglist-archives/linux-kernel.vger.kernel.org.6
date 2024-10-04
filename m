Return-Path: <linux-kernel+bounces-350163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA57E9900B3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91D41C2358A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B6B14F9D0;
	Fri,  4 Oct 2024 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gOMCkEWX"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1218F14C5B3
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036970; cv=none; b=t6KKG6Va8AoAC5Xs0xjCke4kgNtkWuw5nQqNWgzzrNPVd55P9GWblNEbOP83IRJxpDWnm0myFe5EUscRAQ85rNynrDQqTuMZFdLH1wIElij9LQelihsORo90N5Y4ukY7Bz6dzLhORvKxDbU1Zcm18lo21UGM+57havHx3MigiWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036970; c=relaxed/simple;
	bh=1+fHTvNXJJUizBom3bZq+hqVsjY65BX90vqBBAchQN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjN0nW69afL71+qCJpQAs1VWFfjISl9aLyULt/6oeklizTQbDm3ZeHNvprR+d4xFHTwzE+n9lmHi/OtrKvpzMAeuHA1Qr5qJJOPuAK+ExzWxtJ7UMyABFgoZUFBPM04vlXNgH8qgB792f30G2rzVEkqVVsQsU8bVIApaFIRoI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gOMCkEWX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=u1NWgOqMNyUtDvE04Axpn1gDc+Ve2ri/GBG7osPQrOg=; b=gOMCkEWXOJRBXfM0ddK81Q71DG
	4OY3tAjYpeIZ8X/iteABsPzv77ZA/bJAu3Q1vTKBeCva1EhxUpS4Fjw6KI2BsZwc3So9Dr0EZVvm4
	GE8SYL82QOlnDDDrAuWBaU4Yz3XmPDD2oa9PpNI6megKX3AAZRUVn+6xogNfat+DH8vZDdsw4wr06
	gt5nDiZYX9ThnwqNjGBJgP0aWOzbA6rVSczOJGGSPHIL5K51nL3ZnjrJ5CPREIr7Nl5T4xcldr07s
	HkgqUv0+UHFCQhRIdXvUsnbpd9Kcf/7WoZNNZAxJ4fFy+xRN4PtDpWtjMxdu9kGqxW1IGtpUTxaa7
	Kw+7kjeQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1swfLt-0000000A9yn-0Mev;
	Fri, 04 Oct 2024 10:16:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 56BDA30083E; Fri,  4 Oct 2024 12:16:01 +0200 (CEST)
Date: Fri, 4 Oct 2024 12:16:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Maarten Lankhorst <maarten@lankhorst.se>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] locking/ww_mutex: Adjust to lockdep nest_lock
 requirements
Message-ID: <20241004101601.GQ18071@noisy.programming.kicks-ass.net>
References: <20241002125611.361001-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241002125611.361001-1-thomas.hellstrom@linux.intel.com>

On Wed, Oct 02, 2024 at 02:56:11PM +0200, Thomas Hellström wrote:
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

I'm assuming you actually hit this?

Anyway, work around seems sane enough, thanks!

