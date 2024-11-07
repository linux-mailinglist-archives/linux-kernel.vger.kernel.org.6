Return-Path: <linux-kernel+bounces-400141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 573129C097A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100181F246F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C87212EF5;
	Thu,  7 Nov 2024 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyA2iR39"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BA1210186
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991543; cv=none; b=JsdoF6H23EoUpP41Ivqa2n2ZpuqUEBXFmWXKvdXrbmwOOmRy47ILQVeZC5+9pDXsYNHnQmDl+ezKB1+T9aAvT4nqqOMDfXi462akPCDXi+ERg5eKuwOX9qZOgx5jVOGripLEOcGYg4bl5ln+BI6yCVWniZFUqi4y4qM2y2xFGic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991543; c=relaxed/simple;
	bh=IzQePvWWbEAMJ6Uu+Ozp1ssBbJp2cbnOC4cg/d3FG/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sETmjLm7tgJtoSr4V3+0tT9K6MG4R7BbnWiFvK/sMIVFmpVEGFzra5HgVVbBDCXwwwMLSh3bXN03IfG5weZhdibgoZDirQ+9wvLuJm7Ot2wk8fcAGmpmjT0E1pbb+xvLgGtKeBe+Ap2LhGBADsIZtISzDcWtwvyMaBAyaknmJjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyA2iR39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6505AC4CECC;
	Thu,  7 Nov 2024 14:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730991542;
	bh=IzQePvWWbEAMJ6Uu+Ozp1ssBbJp2cbnOC4cg/d3FG/U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qyA2iR39Rj3TTFKQ2v9jiA2YkUQOPzcC6WtcWmoKc6AidAgz00J6pgGRimFtJKGVU
	 70U4A6uhjsR1NjJORzfwW5LSzO1d6WaOvqR6W5KiGrkvz4E+mg5D//MlAvyaq5BwV+
	 /dtyqT5tupEtCGjgpkcvzmy8k0SeK7XdEvfTnVX51ou6M9JynzAiFzTF6w81yw0THU
	 MyWZrfOopKWbSWmnm8MaKRJQRskW1GDJwgGiPKpQFI/hBwV0OifUFoO2ID7/E3qn+J
	 y+Bva6wKTSpnVGjykEGeR+lvi7Z/He0Y31IcNW3+abaUErszaSIXeqZT0mRlzqz6Gw
	 aF6t3rHurfCug==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0EDB0CE04CE; Thu,  7 Nov 2024 06:59:02 -0800 (PST)
Date: Thu, 7 Nov 2024 06:59:02 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	sfr@canb.auug.org.au, longman@redhat.com, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org, Tomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] scftorture: Use a lock-less list to free memory.
Message-ID: <9cb78f76-7ab9-4b60-974e-8620bac69424@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <88694240-1eea-4f4c-bb7b-80de25f252e7@paulmck-laptop>
 <20241104105053.2182833-1-bigeasy@linutronix.de>
 <20241104105053.2182833-2-bigeasy@linutronix.de>
 <ZyluI0A-LSvvbBb9@boqun-archlinux>
 <20241107112107.3rO2RTzX@linutronix.de>
 <45725c86-d07f-4422-a6fd-c9f02744ac75@paulmck-laptop>
 <20241107144300.gbzCzBRf@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107144300.gbzCzBRf@linutronix.de>

On Thu, Nov 07, 2024 at 03:43:00PM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-11-07 06:08:35 [-0800], Paul E. McKenney wrote:
> …
> > This statement in scf_torture_cleanup() is supposed to wait for all
> > outstanding IPIs:
> > 
> > 	smp_call_function(scf_cleanup_handler, NULL, 0);
> 
> This should be
> 	smp_call_function(scf_cleanup_handler, NULL, 1);
> 
> so it queues the function call and waits for its completion. Otherwise
> it is queued and might be invoked _later_.
> 
> > And the scf_cleanup_handler() function is as follows:
> > 
> > 	static void scf_cleanup_handler(void *unused)
> > 	{
> > 	}
> > 
> > Does that work, or am I yet again being overly naive?
> 
> See above. I can send a patch later on if you have no other complains ;)

You got me on that one!  Thank you, and please do feel free to send
a patch.

Interestingly enough, this has never failed.  Perhaps because the usual
scftorture run injects enough idle time that all the IPIs have time
to finish.  ;-)

							Thanx, Paul

