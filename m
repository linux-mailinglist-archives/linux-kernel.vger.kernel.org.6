Return-Path: <linux-kernel+bounces-264281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF2193E10C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 23:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCEE281F8F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 21:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE5C374D1;
	Sat, 27 Jul 2024 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OxdjyAHs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gh0DZxbZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B2728399
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722115224; cv=none; b=Hw5EFYRXiQPxO35AGUogZhvVpz6tiwE3bSBjHBg/yTIcuBql2xVhYg+p2kPcgm2RwItDiCyJr/phPx1xWWyrTUcXHuxcUqIm8W7Qrirjs/frsFAK47WE2URfSIOHhVeVbJXUD5i9a6TgBTBb7FM+PxzYAFMOJA0SjoeOivKcuug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722115224; c=relaxed/simple;
	bh=63diY6qNnDu76L4HmK7nk4UcGNDUcZPQVSozrwFziJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MHfnMv3IRlibUCMnNGmOcyAuaEnVedUlDtRDw0QkCOswS289Ryzvu4sMIp6aZYsGDtyHcao8DV8m1TKejLDMepo63wArNgc0EYaGZFjiFnN1b1/OsvV2yRdTjrMlD+36ElHWUpEiY8W5pI7ldqTpmYZPns7Qaxv35hKBjGAyOKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OxdjyAHs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gh0DZxbZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722115220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iu7FEsf8KZ6rgCkZp06yldWeqGjZHRURM3QWPHRGKvQ=;
	b=OxdjyAHsWKkE2r7PdkcfMgz5EDVsdq/dlzyBv5zTQ9PJ3lis1/sHVJ7ESPdErWQ1GDtlk/
	A3PxKxb6HLzLepQWkrzgzXRlUDL7OMsJkfpYTS6KVkkGiTQM9r69BWSyn0J09y4WBLFdqL
	I3Jq838PnfVH2NX20EdGehgCGa9iNno14VmBv8gBYYY6DPIYBPHLZt2cH8DLTobJuvSA25
	A9Gjcmal8FzlO+VKW71ydk0/gUxjhA9NWWnQ8P790KkRABBs5aVQ0oWvqasAj+VDiEptJp
	tfnqegDRXllmqfMp/ardNHzJ2bPCfO6JTrrszPsWQV/zOwqw6fzkYAmcplPu8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722115220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iu7FEsf8KZ6rgCkZp06yldWeqGjZHRURM3QWPHRGKvQ=;
	b=Gh0DZxbZIAzELxCu1HZ/QOFJqSata/7BL/OYYLQiErPpIBFXjllK29JHA+E3Pt0Wkw1pH+
	v58xU56Il1Fi/QAQ==
To: Linus Torvalds <torvalds@linux-foundation.org>, Tetsuo Handa
 <penguin-kernel@i-love.sakura.ne.jp>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>, Andrew Morton
 <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Mel Gorman
 <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>, Peter
 Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Ingo
 Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] profiling: remove prof_cpu_mask
In-Reply-To: <CAHk-=wgs52BxT4Zjmjz8aNvHWKxf5_ThBY4bYL1Y6CTaNL2dTw@mail.gmail.com>
References: <5e42ce13-3203-4431-b984-57d702837015@I-love.SAKURA.ne.jp>
 <CAHk-=wgs52BxT4Zjmjz8aNvHWKxf5_ThBY4bYL1Y6CTaNL2dTw@mail.gmail.com>
Date: Sat, 27 Jul 2024 23:20:19 +0200
Message-ID: <87a5i2ttv0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jul 27 2024 at 09:54, Linus Torvalds wrote:
> On Sat, 27 Jul 2024 at 04:00, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> We could replace alloc_cpumask_var() with zalloc_cpumask_var() and
>> call cpumask_copy() from create_proc_profile() on only UP kernels, for
>> profile_online_cpu() calls cpumask_set_cpu() as needed via
>> cpuhp_setup_state(CPUHP_AP_ONLINE_DYN) on SMP kernels. But this patch
>> removes prof_cpu_mask because it seems unnecessary.
>
> So I like this one a lot more, but it actually makes me wonder: could
> we just remove the horrid per-cpu profile flip buffers entirely?
>
> This code predates the whole "we have _real_ profiling", and dates
> back to literally two decades ago.
>
> It's there due to ancient NUMA concerns on old SGI Altix hardware in 2004:
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=ad02973d42f6b538c7ed76c7c0a5ae8560f65913
>
> and I think it's past time to just take all this code out of its misery.
>
> Nobody sane should use the old profile code for any real work any
> more. I'd be more than happy to just remove all the magic code and see
> if anybody even notices..

Only people who indulge in nostalgia will notice :)

