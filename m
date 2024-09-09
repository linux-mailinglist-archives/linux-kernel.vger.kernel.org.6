Return-Path: <linux-kernel+bounces-321605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B04A971CB7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105CD283B44
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFCC1BAEC6;
	Mon,  9 Sep 2024 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s94maB6x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xIc23Af9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F80E1BAEC0
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892545; cv=none; b=Tmsog8ZDnC5RgXhWz/kJ3EAWI2DIbi3FZh8eKmrg9cpFCauG6Vq7bd62LsSzu/lcp532p2yawiyguIWtMi4dZVwbrysoOy4Ypp83GAWCirOViYufOb4sabHtI3zl5VvDzDei/PlqFxLqOoA01qq3Bx4PQaYSxvoXIOjyHwPwX44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892545; c=relaxed/simple;
	bh=8BooXKx+0NMVyYcENQHrkHCr3S5WhZLvm5MskPnbwZY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZmtH7z2uoNtgSt18SHZVKP6870VW8ZWLpIPr/qL/P5fwIQTAa7Ork17LW78VVFt8EgNqnTPmDki87z8UW4TPvor3nZc19458jkgEi6k1uNl0OIPl3YxXpDl1iyv2p4nIkhZdGoEipT4g3+eCLHvyyveyHh2OnHJjZUMVZYwvKPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s94maB6x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xIc23Af9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725892542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXWVXbsPAOgMbGglFMBRssrA39dzXM6BIm/pJcSgIk4=;
	b=s94maB6xQmjgULZMRDcrHTi1No7N4VwQOGOIAb/h8k/OfCCW3gSSsBplotDMHSwTeDHseP
	zbjeNG4GczLTEF3LZwfCF9booWUMGKjdoWVAfehFsWwQxO3cS5U6jnqp378gVJFJfv77Nw
	xsrpAUAvcpu2IsPYeoq7yIGcBCllOEwoD8Q6lGKHgZIKWT7PblWr4iEgbZrnJQBwFwEbvB
	njUsBQuouu3WvxSQS58ulpquuA54G32nybzj22URMf2qN/2Sr5FwPUl6+KbbnJFMXzCaeO
	XKDQXAT7tteO75BHhZffnauHwt4v9o2R7oA2ygY9ydv5XgZEpDtK0uuoXqkTsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725892542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXWVXbsPAOgMbGglFMBRssrA39dzXM6BIm/pJcSgIk4=;
	b=xIc23Af9nDS6hocFcmqZ3dw1pdQUoeVNDonn4EpQjvA4BOvRUYdKCQw5/6hJC4EVJ7O+vZ
	r858lWrYEIDGrZCA==
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] debugobjects: Don't start fill if there are
 remaining nodes locally
In-Reply-To: <32bd93ec-747f-b5a1-917f-f885b87600a5@huawei.com>
References: <20240904133944.2124-1-thunder.leizhen@huawei.com>
 <20240904133944.2124-5-thunder.leizhen@huawei.com>
 <336109d9-2eea-4d67-ee22-ed218b9504c3@huawei.com>
 <7613ce35-0c65-341f-c6ed-412de79890e6@huawei.com> <87ed5tchc6.ffs@tglx>
 <87bk0xc9iy.ffs@tglx> <32bd93ec-747f-b5a1-917f-f885b87600a5@huawei.com>
Date: Mon, 09 Sep 2024 16:35:41 +0200
Message-ID: <87wmjkc2te.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 09 2024 at 21:51, Leizhen wrote:
> On 2024/9/9 20:10, Thomas Gleixner wrote:
>> So something like the uncompiled below should reduce lock contention
>> significantly with a reasonable safety net.
>
> It looks very good. Especially flexible use of 'state' and 'cpus_allocating'.
> In this way, there is almost no conflict of lock 'pool_lock', and the more
> cores, the less possible conflict.
>
> Hi Thomas Gleixner:
>   Do you plan to post this patch? But this patch will conflict with my patch 5/6.
> If you're going to merge my patch 5/6, hopefully yours will be applied
> after mine.

I'm short of cycles, so the best way is when you pick it up and
integrate it instead of 4/6 and post a v3.

>   By the way, Do you have time to review the patches in the link below?
>   https://lkml.org/lkml/2024/9/4/1094

Please use lore.kernel.org links. I've seen it but did not come around
to it yet because I was staring at this one. I'm single threaded :)

Thanks,

        tglx



