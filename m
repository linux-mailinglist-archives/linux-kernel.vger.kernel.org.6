Return-Path: <linux-kernel+bounces-279191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E798F94BA32
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BE81F2294A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE54189F37;
	Thu,  8 Aug 2024 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eVguVVyW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AMjimGSM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652D5145B25;
	Thu,  8 Aug 2024 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111024; cv=none; b=afO1RFUlsCQXp7dkSEpfSY5e7VEv3svTE+5MDNMJbZjKIHHymNK2h7au3AU7m8WG5+zUaHiAC5k31kGTHFNzJgZPQQ2enBAN3pSA5230JHTz1XDaoQYuYZ9SQzcD17EcEnQDYD8R5TV+EdRdkNPEQxOtHEgiLg/Mk4M7z5weIpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111024; c=relaxed/simple;
	bh=Zo81MnJlSvtgcM0U8Z9Vf7MSw8vopGCkiuOytHYtpIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ctfH5i5c68AiADYyL+32ccS4eL6H5GyuFK3Q97Lq4q4eWUeevvhxQO/B/hCALLMhizVo69XzGbtGLmFW/y/JyI3rQCq3lU9mqNOSbiqm1uQHjhNJuTHFFaRKv7C7nxYii4xjbEuaGXXZJgtV/Ark1Rn24Y4XDhBs27VRmTAp5SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eVguVVyW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AMjimGSM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723111021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sO34r1Qxr5Xkr2/DORM0xLF1wvsmMokXf8JtrLHWjEg=;
	b=eVguVVyWfgAiex7NwW6HTa04ePLeBtyhRsiuqFfbL7w+25qS/zF25kJOB37fHwOFp40JTY
	WJccbnCRhYhvO4nTWI10okcvBgN8FnXc26dTwF7sLgp9eAe0R8L/0A+so1yyukQVrFARHt
	Me9V+2S+2V4+k2rayQpVOr87ogOt2jEWzClijguJNqLxMfHD846hQhUv3tAC1e4fQ8ZAzy
	p2yd8tO71f5QUDBStACj0KIvp/NF0urNQ3xSDiTiupJadRGASMaIqMQejVlAKCV1zlX0+S
	fnWpTQP8QUu3uBoRKPPouM8nChq36EftX3yqhWMG6Vao3K4km/PLTmfLzMF1XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723111021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sO34r1Qxr5Xkr2/DORM0xLF1wvsmMokXf8JtrLHWjEg=;
	b=AMjimGSMrqHJro712QgzhDXKpeaWoeXUdygnmWfSPd8TfRHG6Nmk0iFeCUepZ/S9SIvwsK
	CuetYMY/d1KuccCw==
To: Guenter Roeck <linux@roeck-us.net>, Vlastimil Babka <vbabka@suse.cz>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, Helge
 Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
In-Reply-To: <76c643ee-17d6-463b-8ee1-4e30b0133671@roeck-us.net>
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <87le194kuq.ffs@tglx>
 <90e02d99-37a2-437e-ad42-44b80c4e94f6@suse.cz> <87frrh44mf.ffs@tglx>
 <76c643ee-17d6-463b-8ee1-4e30b0133671@roeck-us.net>
Date: Thu, 08 Aug 2024 11:57:01 +0200
Message-ID: <87plqjz6aa.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 07 2024 at 18:07, Guenter Roeck wrote:
> On 8/6/24 16:24, Thomas Gleixner wrote:
> diff --git a/mm/slub.c b/mm/slub.c
> index 4927edec6a8c..b8a33966d858 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1385,6 +1385,9 @@ static int check_slab(struct kmem_cache *s, struct slab *slab)
>          }
>
>          maxobj = order_objects(slab_order(slab), s->size);
> +
> +       pr_info_once("##### slab->objects=%u maxobj=%u\n", slab->objects, maxobj);
> +
>          if (slab->objects > maxobj) {
>                  slab_err(s, slab, "objects %u > max %u",
>                          slab->objects, maxobj);
>
> results in:
>
> ##### slab->objects=21 maxobj=21
> =============================================================================
> BUG kmem_cache_node (Not tainted): objects 21 > max 16

Careful vs. the pr_once(). It's not necessarily the first allocation
which trips up. I removed slab_err() in that condition and just printed
the data:

[    0.000000] Order: 1 Size:  384 Nobj: 21 Maxobj: 16 21 Inuse: 14
[    0.000000] Order: 0 Size:  168 Nobj: 24 Maxobj: 16 24 Inuse:  1
[    0.000000] Order: 1 Size:  320 Nobj: 25 Maxobj: 16 25 Inuse: 18
[    0.000000] Order: 1 Size:  320 Nobj: 25 Maxobj: 16 25 Inuse: 19
[    0.000000] Order: 1 Size:  320 Nobj: 25 Maxobj: 16 25 Inuse: 20
[    0.000000] Order: 0 Size:  160 Nobj: 25 Maxobj: 16 25 Inuse:  5
[    0.000000] Order: 2 Size:  672 Nobj: 24 Maxobj: 16 24 Inuse:  1
[    0.000000] Order: 3 Size: 1536 Nobj: 21 Maxobj: 16 21 Inuse:  1
[    0.000000] Order: 3 Size: 1536 Nobj: 21 Maxobj: 16 21 Inuse:  2
[    0.000000] Order: 3 Size: 1536 Nobj: 21 Maxobj: 16 21 Inuse: 10

The maxobj column shows the failed result and the result from the second
invocation inside of the printk().

Let's wait for PARISC people to run it on actual hardware.

Thanks,

        tglx






