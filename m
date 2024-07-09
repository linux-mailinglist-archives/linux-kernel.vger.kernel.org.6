Return-Path: <linux-kernel+bounces-245302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 466AF92B0E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96D61F21DB0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB3413BC35;
	Tue,  9 Jul 2024 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="otI5jyJG"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD3B13A24B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 07:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720509127; cv=none; b=XBtHWA73Q1AS1inmorQjBvfcavWCf0E6a1TEyzZ81oIDZ3HgDL+fymLRlcZ+cCrqySjU4eSidlaqXjkAw5FodVN1pv3y3EP/KPoicaR3C7i/GenMlUvr7DPSpxMQLSIbwYRRnb87/s9q8YBzJ3WeNmQiTx7pHT/CRvQnjAbotHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720509127; c=relaxed/simple;
	bh=cal+tItctVGVOqgW6123+Mbqvsytk93RsGGJG3e4iKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrdV3LPGdTU4MB6PZu6dCjZrgohn12e9DXYcZgkILCx+Q3tfSpn8KI1qgt8iRF4ervsNzxRKodIWFb1chr3TuNbiRJ/gcSC5VH1F9OHR/EfHkLaa0a56HcqNw3OCJRFemksjD5ilUreW8mCu8PLs5V+37k07COMJv7vnzskRlRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=otI5jyJG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3l02WOEt5kg5FkXpnI2T3jtmmE5KskyQNFfXYWU+cAU=; b=otI5jyJG30kcyX2RXmmuLr8x/f
	S4DQRA1j844H9M/Pv7mm0z2um7FlfEKctRBga7c1JbsYX8wO3u9V72T4Lsz6oPzx/eMYzz1j69eAT
	1uijLQlyTTVaMFYITUtG1PMyHwmy6yK31kphBi+URYZPnbEObhalEQt3wk0+/zAuwFyqRr723cN11
	7ngB0spq6ryReIKLEuZHvQrsnm/mMtS8U2W7r94yMzEXBnhfPw4I4X3BKQqDswJkth/kS9KXhkOAx
	KTihW1pNOV65gG0kTPHHvMw+/G47cEfVt4pG57WQVHBHaqMsiI8POq8QwMxrb2WK3cs4anAZcUM1e
	eBWqBd9Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR515-00000000hlM-2VCP;
	Tue, 09 Jul 2024 07:11:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9F92E3006B7; Tue,  9 Jul 2024 09:11:58 +0200 (CEST)
Date: Tue, 9 Jul 2024 09:11:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <20240709071158.GE27299@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
 <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709075651.122204f1358f9f78d1e64b62@kernel.org>

On Tue, Jul 09, 2024 at 07:56:51AM +0900, Masami Hiramatsu wrote:
> On Mon, 08 Jul 2024 11:12:41 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Hi!
> > 
> > These patches implement the (S)RCU based proposal to optimize uprobes.
> > 
> > On my c^Htrusty old IVB-EP -- where each (of the 40) CPU calls 'func' in a
> > tight loop:
> > 
> >   perf probe -x ./uprobes test=func
> >   perf stat -ae probe_uprobe:test  -- sleep 1
> > 
> >   perf probe -x ./uprobes test=func%return
> >   perf stat -ae probe_uprobe:test__return -- sleep 1
> > 
> > PRE:
> > 
> >   4,038,804      probe_uprobe:test
> >   2,356,275      probe_uprobe:test__return
> > 
> > POST:
> > 
> >   7,216,579      probe_uprobe:test
> >   6,744,786      probe_uprobe:test__return
> > 
> 
> Good results! So this is another series of Andrii's batch register?

Yeah, it is my counter proposal. I didn't much like the refcounting
thing he ended up with, and his own numbers show the refcounting remains
a significant problem.

These patches mostly do away with the refcounting entirely -- except for
the extremely rare case where you let a return probe sit for over a
second without anything else happening.

