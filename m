Return-Path: <linux-kernel+bounces-564450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1B2A65548
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7AEA3B4C33
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51022475CD;
	Mon, 17 Mar 2025 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gxx93T7W"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528AB221F04
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742224511; cv=none; b=cU/vIxTYk9OvddRWPBoakaQFuQkUrcAXh337OQil6qognFEJI7J6inhH6QCqubc6K9DXFF6PkMUGywSFYdzFSbzCqPbnCFoWlQPnso3Xql2/gHH92gaui4AynBAEIzhiw+WToZXOBnJyivvJstuIlQ/WCQBygiZoC73Zh9FHhas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742224511; c=relaxed/simple;
	bh=h9PL9ucB9gsIDo6IjcbHErDkJJq9iOtMWS6lg/8BckE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSZ2GeXvtgt9+23D7Pngp6Pm+mnJIXgT41X9ogm3PhZM4hACzMj7Pk69x62xSiswtQx4dRklE6rWYpEJJannsX7XtGbaqPFws8I+WG+AAY1j5YZExvXUVOpHLHbG/COQNT8KlaQm9SWWqXVDv6LGWjXz69+oTmqQ7MHfMcm95Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gxx93T7W; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E8E5E40E022E;
	Mon, 17 Mar 2025 15:15:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mdl9N0Vqod41; Mon, 17 Mar 2025 15:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742224501; bh=ejghOMb7YHMlvv77rsBEj53OgwbVeGBFdZXem+2KX3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gxx93T7WeXVZIpPa25CJPz1mJKBUI/ZrKWPo6kYay2vipr+aq2za3cJ/0z4b1l4X1
	 PGftflCir7fRjaFayIQ2jEbgeUXo2QAECKvniIGFZcrG4dj+X+fmsMOIGX8MP+pYWX
	 HcetOjZrzwizkjbfy8OFE+YiWK8hwDa65pATdXqmRh1iiWRX8r3xBQUwP2ls84ocMO
	 YcheQMuq7rU7WBHjk1hWhpx7ePt+LweS0J/7XBVKvKkmJPJJmPT/XB8JU1Ajtk4/3t
	 xJt+VFqB9PoFAXZDIgyDpy2CBAbJyAWwaTZiKqOXalkRAKAxmEyyfDpzj8ts3F2wrI
	 jQWYEv6YJM3pbDeI1GPEK72HibfHbVhj5RyfqTyRE/fKCoeSj8moouDAvud1ULiXGI
	 xlpZxp4hLrr8mToPNOTlHajltVVCsAJsqmakYVH9DKSJeYQHgtSQMu6k7RJLyinEz4
	 YRajuVHBZFrelh5g5zbXxvjS+BjmgD+1qp+w8gp9Knr++QQegSgTi8Z7J7ODmi68JI
	 6wkzd9rjjfQ01gF9se/o8zeZ0QnioLBPnkQSFXcuRmblCsL4RixwdV92yUNQeB3+Oh
	 oOIRewyBRs35oefDVBJaI2xzsWz48vI0ENUQFK+z5uB1M0tFu12/Ctx5g35ZNvkuen
	 5CRXfn99sMWnnJykgOU7YmVg=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9372940E021D;
	Mon, 17 Mar 2025 15:14:52 +0000 (UTC)
Date: Mon, 17 Mar 2025 16:14:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	kernel@gpiccoli.net, kernel-dev@igalia.com
Subject: Re: [PATCH] x86/tsc: Add debugfs entry to mark TSC as unstable after
 boot
Message-ID: <20250317151446.GFZ9g8Zi3qmBwOTuz_@fat_crate.local>
References: <20250226132733.58327-1-gpiccoli@igalia.com>
 <20250317144028.GEZ9g0XPSkOQU7A-nO@fat_crate.local>
 <eaef4f28-5531-f8b6-1c29-7a225715012f@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eaef4f28-5531-f8b6-1c29-7a225715012f@igalia.com>

On Mon, Mar 17, 2025 at 12:03:02PM -0300, Guilherme G. Piccoli wrote:
> We as in we, the Linux users. I can change to something like "Right now,
> TSC can be marked as unstable" - let me know your preference =)

Yes please.

Personal pronouns are ambiguous in text, especially with so many
parties/companies/etc developing the kernel so let's avoid them please.

> For example, my team and I debugged recently a problem with
> TSC+sched_clock: after TSC being marked as unstable by the watchdog,
> sched_clock continues to use it BUT the suspend/resume TSC routines stop
> being executed; for more details, please check [1]. But the thing is:
> during this debug we tried forcing TSC unstable, and did that by
> changing the command-line.
> 
> Problem: with that, tracing code sets its clock to global on boot time.
> We were suspicious that the issue was related to local trace clock, so
> we couldn't mark TSC unstable and let the trace code run with local
> clock as it would, if TSC was marked as unstable by the watchdog late on
> runtime.
> 
> That was one case (easily "workarounded" with trace_clock=), but in the
> end, I thought that would be way better to just have this switch on
> debugfs to be able to reproduce real-life TSC cases of instability,
> while system runs. Hope that explains better my reasoning for adding
> this debugs entry.

That sounds like a debugging session and we all change the kernel to do things
it doesn't normally do just for the purposes of debugging. It doesn't mean
that that should be exposed upstream.

> The same that happens if today someone marks it as unstable via
> command-line, right? You will see that on logs, and could simply reply
> that the user marked as unstable themselves, so..no bug at all!!
> 
> But let's think the other way around: what if some user marks TSC
> unstable via debugfs, later on runtime, and with that, unveils a real

I don't understand what you mean here.

> bug as [1] and then, we can then fix it? That would be a win heheh

No, marking the most important clocksource on x86 deliberately as unstable
better scream bloody hell in dmesg. But regardless, I'm not convinced this is
nearly as needed to have upstream. Just use it locally or cmdline.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

