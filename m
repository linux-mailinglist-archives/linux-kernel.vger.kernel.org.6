Return-Path: <linux-kernel+bounces-225227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A10C7912DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43EDF1F2333B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 19:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD4617BB2B;
	Fri, 21 Jun 2024 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wy2iKkI7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lJttQ362"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEA317BB01
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718997777; cv=none; b=ClkiE7cw81CmNhJiXsPbLrKkmMGN9X6CXT5eh9T7t5awDO818OTAI05p3QdS1DFLekljs6zSRixKakHduI+T6sGfLgaIIWM7Bt6aPT4aM8yiyx4aNxjuW46cZorO3eEHFNfUtDU4coFtvSNAZFmRd8LwypKiIQCDGdhvPj4sXkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718997777; c=relaxed/simple;
	bh=JUlWsAMB1jxwwOj6uw3ptcHahhiIDFuD+/+iPluqHa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QO0+kW0G1tq53JlGrsbC25t68xNfLr1B6076zNjc4AdMCgGG8X1SkFeMX9Yne0rrwJmosQ+qKtbP5rGBfDDVTAwVyY61gFV+aUb5iAndyI3AZOFE+qAc7lfcNYn9Rwh9aNgYGYUV60CLyMl56mXAuhFSYECUOKowr0WJ54rNnA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wy2iKkI7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lJttQ362; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Jun 2024 21:22:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718997774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUlWsAMB1jxwwOj6uw3ptcHahhiIDFuD+/+iPluqHa4=;
	b=Wy2iKkI7qtDir4I9fRhkk+LpCwEmTjeiV5LvpkL/Pu6Ohj2Nh5dSv2yM5ASFfpdbDdHY8s
	V51Ta7lCv6AH/46y749qgn0zjiE8SC+mla87zG5cN4TJYocafQYhvFmfHZWUQZjv9/fidw
	6kTketWxqfS4o6bKqRmZMi7/4T7kidvZrVM38amLz1uoXfeViFi1EYVKHhsmlklJbtUJfb
	jdFVfPZTHtABPbExKko6rvcxBgdfUrxmY40q3FLV/mcnmWWwn0E7rwTgQoHkaWXLOwcBjT
	eFFVgm8QYRJJsQQD8IbN/gf3UmHtLqmlCKwiVMb9uOtFfqF/d4/NM8BMnWd2uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718997774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUlWsAMB1jxwwOj6uw3ptcHahhiIDFuD+/+iPluqHa4=;
	b=lJttQ362DLbgh6tndVMGK4rBqRcfiskbLbTD39L18iJ0AIVIJgQcSAns9DV8VvMcFf5peF
	77KYbr+tPzShgFAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Klara Modin <klarasmodin@gmail.com>, Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/task_struct: Move alloc_tag to the end of the
 struct.
Message-ID: <20240621192252.-whn_Ae8@linutronix.de>
References: <20240621102750.oH9p1FQq@linutronix.de>
 <7zretxxixkpfxt6lr7x64n67ql2v2qpb7abbbjklclwlu4u2kx@22o5sdlnpkea>
 <20240621182915.S-ULWn0O@linutronix.de>
 <yjkte7jz6meaon4tvtwrefvhegwthnxorj3vrz5so6h6kftukv@azvug3smbd3p>
 <20240621190719.TeLTxI9M@linutronix.de>
 <elqyw2tofbojh6rfkfyrjaz6dpwpq4vfd3ni5r3cgkwdumginc@ctizxnu4jkff>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <elqyw2tofbojh6rfkfyrjaz6dpwpq4vfd3ni5r3cgkwdumginc@ctizxnu4jkff>

On 2024-06-21 15:13:19 [-0400], Kent Overstreet wrote:
> > > > random code=E2=80=A6 Puh. So if the end is too cold, what about aro=
und the mm
> > > > pointer?
> > >=20
> > > Not there, that's not actually that hot. It needs to be by
> > > task_struct->flags; that's used in the same paths.
> >=20
> > But there is no space without the additional 52 bytes. Was this by any
> > chance on purpose?
>=20
> No, that wasn't, and it doesn't have to be the exact same cacheline, but
> we do want it near current->flags; we store PF_MEMALLOC flags there that
> are converted to gfp flags and used exactly where we're using
> current->alloc_tag.

Hmm. `stack' and `usage' are the only two member that you would have to
move (away) in order the stash the conditional variable there. The
`ptrace' one uses the same flags as `flags' so it wouldn't make sense to
move that one.

Sebastian

