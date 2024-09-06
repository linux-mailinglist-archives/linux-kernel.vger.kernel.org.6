Return-Path: <linux-kernel+bounces-318981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A60D696F61A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E721F229F3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A051CEAB5;
	Fri,  6 Sep 2024 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="04p4uxbb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TGNZtEcQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFCA266AB
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631163; cv=none; b=NxgMOC1NkNiFWwffx0XO3UEHC3dpsvcUn+CpepwcyciM/KztNvkNUpm5BMMwjvgd487otVe26w3TKTmo8fz0N79HqYZyNLPkph1BI2OTvQye859RrMV9J0gahBSTCienQClaU7QoAmgicG1y1uS9CqmM/LCwaDCnNYbKzpRK5+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631163; c=relaxed/simple;
	bh=lyjxRPPBxg+6WCyuIPBD2310UtmLXMiHJgpOFX+F/jI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NySeXLt0X2pwYW/zDFgm8NSK1hoRMj71Fa1F9IxArllHgM/2OPhX2p++Ewsfj0onACPZS3oOcS8KkERFqGJuvftUsEA0Cl0BzBF3wLonOzGVaRTZY1enkKti0iOLIHdz90DroAJO6qyZaaBthbq+9nkVkVYGuomKKeXyYboMfsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=04p4uxbb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TGNZtEcQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725631160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3pzWBpUMgwR7S025lXojyYJPjbzgL5E0fNEF+GNLZ9s=;
	b=04p4uxbb3ErlCxtNPcu+a3ZuCKEoTZ4kck7ktCE1n3lMp99pSh7RjE0AUhTC5p9knam6+0
	Y23lTwc0vQH62DUIzK7qLlCcwNS1Uh5trSrXC56T94rQfRZobvJMhWIx+H6R9QziVMfaQC
	MvX9aUEUyJt3+Q8/Ikc5wc/NF4HaOH1UEASKP7Kyd+lF2fXSI0hMXfy/BzTSFhvfVikesT
	MJKCK33Dserm7GiF7NEEZuCf6iaTrhstUwEa5loa3WBlqdmZNrHqzPl2u9d9gRHn1pkXmW
	4uXQYm3oRFC7/2iVult+z6F++wL2D6fcuDhNmpbuUfrDiehCPNpRPFWNLlAqJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725631160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3pzWBpUMgwR7S025lXojyYJPjbzgL5E0fNEF+GNLZ9s=;
	b=TGNZtEcQaQrxgUrV8xXqBtSu1ut6sGlauhKUkE8mTezly1S757kNuqMTf2YdFPZi/DZkhQ
	XTm51PCTkz/jaoCw==
To: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>, Borislav Petkov <bp@alien8.de>, Christian
 Heusel <christian@heusel.eu>
Cc: Rob <rob@durendal.co.uk>, regressions@lists.linux.dev, x86@kernel.org,
 Joerg Roedel <joro@8bytes.org>, Tony Luck <tony.luck@intel.com>, LKML
 <linux-kernel@vger.kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>, Lyude
 Paul <lyude@redhat.com>
Subject: Re: [PATCH] x86/apic: Remove logical destination mode for 64-bit
In-Reply-To: <fb5d23fc-2d47-4142-be88-701c4209fc7a@leemhuis.info>
References: <ZqQSmw51ihns03ob@vendhya2> <ZqQl79UhhSQ5IobX@vendhya2>
 <8734nvuvrs.ffs@tglx> <ZqTufKvJKvotC-o_@vendhya2> <87cymyua9j.ffs@tglx>
 <877cd5u671.ffs@tglx> <ZqZ3Kp2NVctgstxs@vendhya2>
 <c7b68723-6ecb-42be-a9f8-14d64c696283@heusel.eu> <87jzgpubxj.ffs@tglx>
 <d9cbe524-ad83-4c48-b6f4-3376ff3172d4@heusel.eu>
 <20240905140446.GCZtm6fu_H5JH_aP-D@fat_crate.local>
 <fb5d23fc-2d47-4142-be88-701c4209fc7a@leemhuis.info>
Date: Fri, 06 Sep 2024 15:59:20 +0200
Message-ID: <87h6asevd3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 06 2024 at 10:34, Linux regression tracking wrote:
> On 05.09.24 16:04, Borislav Petkov wrote:
>> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/apic&id=838ba7733e4e3a94a928e8d0a058de1811a58621
>
> Hmmm. Please help me out here: why was that fix queued for -next and not
> for this cycle?
>
> Was that patch when it was committed considered too dangerous for
> mainlining this cycle (at this point of the cycle I guess it might)?

Yes.

> I mean, it's afaics (not totally sure here, the change is missing a Fixes:
> tag as well as Closes: tags pointing to the report) fixing a regression
> with f0551af02130 that Christian reported (see start of this thread, e.g.,
> https://lore.kernel.org/all/12df8b45-6100-4c8b-b82a-a6a75bed2e05@heusel.eu/
> ). And f0551af02130 is from v6.9-rc1, so given what Linus wrote in
> https://lore.kernel.org/all/CAHk-=wis_qQy4oDNynNKi5b7Qhosmxtoj1jxo5wmB6SRUwQUBQ@mail.gmail.com/
> that fix should likely have been (or still should be?) merged in this
> cycle, unless it's really dangerous.
>
> Or did I misunderstood something here?

I really wanted to cook it first. Aside of that f0551af02130 unearthed a
firmware bug as the reporters confirmed. So I didn't see an immediate
reason to send it to Linus.

My rationale for writing the patch was to avoid this issue in the future
for those who can't update firmware and have it in the next LTS release,
which is what distros will ship in their stable offerings.

Thanks,

        tglx

