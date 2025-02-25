Return-Path: <linux-kernel+bounces-531619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B546A442D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3CA17249E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2B426A095;
	Tue, 25 Feb 2025 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0y6+WsF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8532698A8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493714; cv=none; b=HfZXEgY16qEgBjsD5jTZjGU473x7GnrMkcx8MWJ9LNlaabzPr29sUXSHBEE+kO2aRJkvTnCfpRcUNWb2OqF+jIKprhHgcvoYieWaaytOmWAHhGdio+pSL62PWYDul4WLMfxBeUDF9MgopVr37QhuvUuifnust1QoU7MZk0Al20Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493714; c=relaxed/simple;
	bh=gvIBwaSJNTvZ8M88E/Zqfyzlre6QRNCoiRn2farrnhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJfL01FMuReSPeQDm6QnbBlTDLqHgwUcp5MvxhmN0QTv1aZq0TqO/22FnzXfTJtOZMkfajsXndSmQScSWozz7orZOXl4A5zFrWKY1ePSAY2PHukVP8xQeBE75lnGYS7VYNUc9UoW5aiVzwRYewkM45zdbqsybthkilC8wtRM+r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0y6+WsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5A3C4CEDD;
	Tue, 25 Feb 2025 14:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740493713;
	bh=gvIBwaSJNTvZ8M88E/Zqfyzlre6QRNCoiRn2farrnhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0y6+WsFGO+M1MC082PAovNBh/ze6iQUyhg1hCCIo3nISlQvZVrPFYB6fkZRAsI/i
	 OWuVuGqgg4D+zwOBlyIVgt6IdyZDaz0ta88qAvJVY8Chi9fqYGa7ZYlCob8cGt/BwT
	 rGI2hQ8JJj/dQlu5Qwy8oppOtL9jZsnN3xx6w8XsCsnO29vnITnBwXgoUySvEOzHHm
	 /bolLoaIAauC0ceQERCL0W3Ms9sxv3erenSZd7CwGdU93EZb9iFQnuzPFrQh1YA927
	 IrU5gaRyj9QWANr3m0ozY8eVw+jERb7gQscEXaJ06llH8n7UtFgxSjSyrnHJxg6Ly1
	 sn7BMIXdsCLUw==
Date: Tue, 25 Feb 2025 15:28:31 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] task_work: Consume only item at a time while invoking
 the callbacks.
Message-ID: <Z73Tj3SAzNjaHwV3@localhost.localdomain>
References: <20250221170530.L3yMvO0i@linutronix.de>
 <20250223224014.GC23282@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250223224014.GC23282@redhat.com>

Le Sun, Feb 23, 2025 at 11:40:15PM +0100, Oleg Nesterov a écrit :
> Well... I won't really argue because I can't suggest a better fix at
> least right now. Most probably never.
> 
> However, let me say that this patch doesn't make me happy ;) See below.
> 
> On 02/21, Sebastian Andrzej Siewior wrote:
> >
> > Oleg pointed out that this might be problematic if one closes 2.000.000
> > files at once. While testing this scenario by opening that many files
> > following by exit() to ensure that all files are closed at once, I did
> > not observe anything outside of noise.
> 
> and this probably means that we can revert c82199061009 ("task_work: remove
> fifo ordering guarantee") and restore the fifo ordering which IMO makes much
> more sense.
> 
> But:
> 
> > Fixes: c5d93d23a2601 ("perf: Enqueue SIGTRAP always via task_work.")
> 
> Yes. So, to fix this specific problem in perf this patch changes task_work.c
> 
> And after this change we can never enforce a "clear" ordering, fifo or even lifo.
> The ordering is simply "unpredictable/random".
> 
> I'll try to find and read the previous discussions tomorrow, but iirc Frederic
> had another solution?

This:

	https://lore.kernel.org/all/Zx-B0wK3xqRQsCOS@localhost.localdomain/

Though I'm not entirely happy with it either.

Thanks.

