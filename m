Return-Path: <linux-kernel+bounces-343643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4186E989DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC06CB20A29
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D28C187FF2;
	Mon, 30 Sep 2024 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2PrIxgxi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z+I1C31u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE57185B76
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687185; cv=none; b=Bl/sqTkOaMPUZ7NQWW6AHNuQoTNB7V+ng2MYaRhnhqf5hCvrCHIQWzRKNf7b8Xmqv0YyCRqjy3xdQBK0qPrITOV0MNhslMeksuyli8u73JPrIsf7HCvhuwssc7dPye7W+FgBbAp646ikSr4whAklesgK5dnV960MXIziDrUgbic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687185; c=relaxed/simple;
	bh=0WEWcIZ+8kFtUjErbpNaoBz9a/QW5Ekdz/vpxy/UEbU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tH7apoyhKjmOeZt4RaYzOoIaDeCR9hjZPIejLtae0HBbdZAVzUjHnatyB68sz1+lc3h+NZy1JnUgfxOKCF2mL7CbZC5vSuzrpaOTGSqVcHbrogbvU6KDetsHS/7LaGZSWOiQ6skbER6qA1UpXAd0YUN6DbkdP8YCxNcynCZpFiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2PrIxgxi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z+I1C31u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727687181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qRbyFb55J5wABvqMIJMlx3wiQRqq6mXyWStEuyF8iVE=;
	b=2PrIxgxi7a904srovZmhlM9jVR5Q18Fm2Eox2HCBR6m7KsOaywpz7B3sApI1RS/7gH60lI
	M+scvhyAityxEwro+w0EaNkKIVLNFLeKDyLvbRoOtKTZiVMmMfnUe/UI+MwOAPPhvSxxd5
	qVwM14AjSfI1mI7biSIJcPWGZ26R1fDCa/3coToEJSB68BHorL2l168PwUOt5fqETeMeF0
	Hl5LY7Wja4P9jN72wTuy8CPYTI+OtQOMxQB5i7oZf6ZnTE5koh+R//fryvdIbD5ODbSRFR
	VGvB0MdBEepepkXu+vc7yn4mhf85naazd9Acc0L5fp9qat81STjypDLPcLsPog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727687181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qRbyFb55J5wABvqMIJMlx3wiQRqq6mXyWStEuyF8iVE=;
	b=z+I1C31uwwTgvz7IbM+H+rFg0Ve/SinXCbKEbwSzCB9+XhElL/D0i+D3imc8Th65nClNyT
	Op6AirgTkj9jMQBA==
To: Peter Zijlstra <peterz@infradead.org>, Michael Kelley
 <mhklinux@outlook.com>
Cc: Borislav Petkov <bp@alien8.de>, Yury Norov <yury.norov@gmail.com>,
 "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: Question about num_possible_cpus() and cpu_possible_mask
In-Reply-To: <20240930075600.GC5594@noisy.programming.kicks-ass.net>
References: <SN6PR02MB4157210CC36B2593F8572E5ED4692@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240930075600.GC5594@noisy.programming.kicks-ass.net>
Date: Mon, 30 Sep 2024 11:06:21 +0200
Message-ID: <87msjp1pf6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 30 2024 at 09:56, Peter Zijlstra wrote:
> On Wed, Sep 25, 2024 at 04:04:33AM +0000, Michael Kelley wrote:
>> Question:  Is there any intention to guarantee that the cpu_possible_mask is
>> "dense", in that all bit positions 0 thru (nr_cpu_ids - 1) are set, with no
>> "holes"? If that were true, then num_possible_cpus() would be equal to
>> nr_cpu_ids.
>
> I think we've historically had machines where there were holes in. And I
> think we're wanting to have holes in for modern hybrid x86 that have HT,
> although I'm not entirely sure where those patches are atm.
>
> Thomas, didn't we have a patch that renumbers CPUs for hybrid crud sich
> that HT is always the low bit and we end up with holes because the atoms
> don't have HT on?
>
> Or was that on my plate and it got lost in the giant todo pile?

We talked about it some time ago, but that went nowhere.

Thanks,

        tglx

