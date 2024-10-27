Return-Path: <linux-kernel+bounces-383747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7255A9B1FCB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 19:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D91B20E25
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 18:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E9E17A58F;
	Sun, 27 Oct 2024 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=benjarobin.fr header.i=@benjarobin.fr header.b="rNDYLgRh"
Received: from 7.mo573.mail-out.ovh.net (7.mo573.mail-out.ovh.net [46.105.63.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39EC79C2
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.63.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730055558; cv=none; b=kFS67rt5FEu2dFcdNR7WebSCVK/VcxqGwaLFCT/mRDSChqd3717Ds7hg3gopGLcfwAupDrCPlqCDJ4hCwE1JpwINx9SPf9Jyoxwh6BlUX1ds7goDbLJWUohg6VLlE16kXEndMozjWQnEa3oT1kycS99EieUGcBeYzUQtjKsnDMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730055558; c=relaxed/simple;
	bh=ZRoPodyeJ2/Q4ddxxgMFakrvWcGuR4ZJFiEaFm/D6yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLJZmmQnzbdlmmN9KlRFS4tIFv46yGgH8Pu6821h7PKOWLAp9X2ASvbzedB2q0pXjaDEG0DQkMsqJEa55Au28QOzUu+EjAMRUGuElupWi0nSL7Y6t2Iy+Sc8eAQz4L7hDQvQ9z3VjtMZ/iQdQpg3csUPlUUf0D7Xo3cZbWG1sEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benjarobin.fr; spf=pass smtp.mailfrom=benjarobin.fr; dkim=pass (2048-bit key) header.d=benjarobin.fr header.i=@benjarobin.fr header.b=rNDYLgRh; arc=none smtp.client-ip=46.105.63.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benjarobin.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benjarobin.fr
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net [79.137.60.37])
	by mo573.mail-out.ovh.net (Postfix) with ESMTPS id 4Xc3k549NDz16MV;
	Sun, 27 Oct 2024 17:42:05 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net. [127.0.0.1])
        by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <jstultz@google.com>; Sun, 27 Oct 2024 17:42:05 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.96.178])
	by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4Xc3k53RgRzyCZ;
	Sun, 27 Oct 2024 17:42:05 +0000 (UTC)
Received: from benjarobin.fr (unknown [10.1.6.3])
	by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id D0AAED42F40;
	Sun, 27 Oct 2024 17:42:04 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-101G0041d641528-e03a-4807-8b92-0f8d2b2d6a24,
                    DC00860D008CF58309D7786EEAF0FFC46D55EBDA) smtp.auth=dev@benjarobin.fr
X-OVh-ClientIp:92.161.126.4
Date: Sun, 27 Oct 2024 18:42:03 +0100
From: Benjamin ROBIN <dev@benjarobin.fr>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntp: Make sure RTC is synchronized for any time jump
Message-ID: <gyumkaygfe3jow65bpzm2bgj2tgipbxuj7xa4oxwngkq6xfvyh@ojhlg4oaaaii>
References: <20241006165805.47330-1-dev@benjarobin.fr>
 <87y12pc86o.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y12pc86o.ffs@tglx>
X-Ovh-Tracer-Id: 8893764839574682587
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejiedguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepuegvnhhjrghmihhnucftqfeukffpuceouggvvhessggvnhhjrghrohgsihhnrdhfrheqnecuggftrfgrthhtvghrnhepgeeiffdvieehtdfgtedvtdfgueeufeffueduudehveffuedvveelleeuvdehgeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpledvrdduiedurdduvdeirdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeguvghvsegsvghnjhgrrhhosghinhdrfhhrpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepjhhsthhulhhtiiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeefpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=/DZPPmfj7x886Z4X5Rdgzm9UClvOhA08uDQTAev1+rg=;
 c=relaxed/relaxed; d=benjarobin.fr; h=From; s=ovhmo1728415-selector1;
 t=1730050925; v=1;
 b=rNDYLgRhZAWiTMplLiQfJzuDDG7U9MYDCcTVB33/ewuOrcpI9fgMpqIrs/m09+I77LtyD8zH
 4OyFvb3558sZNGpzy7UIXHxuLgoaCCWX+VLmpqc/twAguFfp/hjNHDb5NuBzaj18+jqmjCJDDUP
 GdJrMIMrKlH92q7mm3oLzPJ4S2cc900Hv6gpTGCp0etmgtmLMQH0J/qNFl7qsd2IOR4GFx54xIE
 SvOJRwjCGHTQbNOg4H++yoyLZRedfN4gml/R2V+t9cVnFm9I0gZn4PbY+nVR67BKXsDhpdsoHRA
 IDFuI4PvxGKmaA/LGSL023F561DXJQzfHPPMivUOGssDA==

On Wed, Oct 16, 2024 at 12:28:31AM +0200, Thomas Gleixner wrote:

Sorry for replying with such delay, I was not really available...

> > @@ -2610,7 +2611,7 @@ int do_adjtimex(struct __kernel_timex *txc)
> >  	if (clock_set)
> >  		clock_was_set(CLOCK_SET_WALL);
> >  
> > -	ntp_notify_cmos_timer(offset_set);
> > +	ntp_notify_cmos_timer(false);
> 
> Can you please add a comment why this does not need to cancel the
> hrtimer? It took me a few looks to validate that this is correct. Six
> months down the road we both forgot about it. :)

I tried to add a comment that explain it in the v2.
I hope this is "good enough". From my understanding of why this is not
needed to cancel NTP sync hrtimer here: Because NTP sync flag was not cleared
since (either):
 - The frequency was adjusted, which has no impact on NTP sync hrtimer.
 - TAI offset was adjusted, and it should not have any impact on REALTIME.
 - Leap second was handled, which does not require to restart NTP sync hrtimer.

> Also can you please rebase this on top of
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
> 
> which has a larger change of the NTP code.

I did rebase on top of this branch.
I will send the v2 patch in a separate email.

Thanks, Benjamin

