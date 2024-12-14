Return-Path: <linux-kernel+bounces-446137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 676E89F203F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 19:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB13E1887AEE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E2419B3E2;
	Sat, 14 Dec 2024 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HiS6z5NB"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0518190049
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 18:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734199542; cv=none; b=nHjgGH/tmOZBqTjDNouFEBQ8Li+7Dw8hRBWpIqLGTKCGn+9edfdLyWS29IKhIwrq7tVgb032v3MTrI7zumi4SzYHejn7LTkFNlb9wYNZgQNBceoB+LTzyk/goQhRLR9TO1gkndcC0UWwRHAuoTCtS5rxtRb+Spom3YlaCvLNHqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734199542; c=relaxed/simple;
	bh=l+XQb6SxMvKWcWSW+7tGlOSgBFAFSlDdjVPjAADwolA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNgcElF0lRA6r5oIiJ1QQy6vlxeWLCdo/Ud3SHnBDLF42xBUq13wmI5u9E2tEoHxdLmKmGskbZ6nZO8pA+4V6d0jcGMfSFEqFXoBfcj5qJ7G4G1AD+KfseWcRY+930njUy8yvkkK5EN2YFxAKZnYyVh3CGQcefo/sy2yG9aKmS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HiS6z5NB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tCQ2jjH+bSRDMvpwlyw3LZciMoEKgsp+e5XKqudh3EU=; b=HiS6z5NB6a+2alRxGWmA9aNx7M
	tEpSbS+GvaCSjhClht9eESGzBIJhM2BRNTHFZw0GsrKMlC/hJKHxu+roYZTe9aezjAgFcC+nCDJcI
	aMY6SUmheVEEtip12qB4sY9078RitubNqHUJmS7p+5b/LOC85DcE8VtIl5Xn5VZ9OxryfAc4Hmh3T
	1Oh6NHmQkhk8TrEMZT7Gytx9rvcqmBv1i6nZZOWF7DhHXHwNNrjDZeFZjfTyJRhG7Y38x1z7TheKS
	uqhtaCAClEEji/a+VcfycNu90Q5Gh1I9xiilLYg/4Q1oNigtCBsDRQc59C/tpun2qIGqcR/1CIBc8
	ZvsG24kg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tMWWI-00000004Xpg-3HFw;
	Sat, 14 Dec 2024 18:05:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EA34130035F; Sat, 14 Dec 2024 19:05:37 +0100 (CET)
Date: Sat, 14 Dec 2024 19:05:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sched/urgent for v6.13-rc3
Message-ID: <20241214180537.GA10560@noisy.programming.kicks-ass.net>
References: <20241209094822.GAZ1a85tp2J_T7_Ctd@fat_crate.local>
 <Z13BzesSJDSuSXRc@lappy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z13BzesSJDSuSXRc@lappy>

On Sat, Dec 14, 2024 at 12:36:07PM -0500, Sasha Levin wrote:
> On Mon, Dec 09, 2024 at 10:48:22AM +0100, Borislav Petkov wrote:
> > Hi Linus,
> > 
> > please pull the sched/urgent lineup for v6.13-rc3.
> 
> Hey Boris,
> 
> I'm a bit late to this party, but I've started seeing the following
> warning. I'm not 100% sure that this PR is the culprit because Linus
> ended up pulling it before I could run tests on it, but I haven't seen
> this warning before.
> 
> [ 1107.003243] ------------[ cut here ]------------
> [ 1107.010677] WARNING: CPU: 0 PID: 16 at kernel/sched/deadline.c:1995 enqueue_dl_entity+0x4a8/0x570

Ah, yeah, no. That's a known issue which we *finally* managed to track
down last week. Unfortunately this sched/urgent pull does not yet
include those patches.

If you want them, they can be had here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/urgent

I was meaning to push them to tip/sched/urgent on Monday, so they'd be
in next week's batch.

But if people want them now, have at :-)

