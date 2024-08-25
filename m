Return-Path: <linux-kernel+bounces-300380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AC295E300
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 13:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FE46B212C3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 11:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C6A13A89A;
	Sun, 25 Aug 2024 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NmW0+cZE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mB09hM6Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041F62F3E
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724583918; cv=none; b=ATJcPPHMmgeCkYLLsMdVvwi5+kDpZ9KESxv0ICiGtgUnnbkbsmyV4DL1IB+iJ60Mi9DmU6Lbo3p+TEHdStu4JmbkAJFLg+oKj7vB6zngE77tCDe5Va3Jj9IcAclx0LFFZeO5+CTykxIwQLUBn/GokQx7Pg6BnOGDKTM6wZvwYhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724583918; c=relaxed/simple;
	bh=gnvf3qdEHqFzz5dOGXJgvKpjcNiLE16xj7zXnd+XpoI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=ZDuLIobb/bDlPAJwu+tu7EjRnNn0/hyr6wYAwqSBrnPZ12WiDATDpuPgT7lVo8qsxOlKkzO6ZvvZQyLRFH3zm5rnKOo+ZsDzIgr+JjQkHG++3VBbpK6YwedBRDohWBugpf2VQLO7Hi5lMSlODADBM33lhehV/0b3psKJ7p1aumE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NmW0+cZE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mB09hM6Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724583914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=FLxSUEPFhr9uwNzXq7VSq2mviA+E+mOZjh03ETzXRF0=;
	b=NmW0+cZEftSk8G1bl83zLYCTyTfAVkIvJtik9es5FKBvsaweFAWCY6MmpQXpufAPmBhiUX
	LSK2KRVHQi/hg5K7D9KXA2u0jnmB8MvHltZRU9yqQJegiC1x2Yd1VIka/fcZXWJk3tv354
	2OMALHLy5iHreTvQdH/X1Fj1hIyDP0XuJ4cO0ONU91X6WCNDRv113MKlNql3Bf9agnO0cN
	ASGhSw9j+FAaaR+Z2LjEAAAkvk9Zi3EicZg3+DrckKiyEUdrnMt1xiN3ze/QcAHCU5/yp+
	YTQb6ukIQKSLqNJWBlfXBtP67CkLbCu9iysymY09w9GMw+QlJyYiSVjHoyghjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724583914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=FLxSUEPFhr9uwNzXq7VSq2mviA+E+mOZjh03ETzXRF0=;
	b=mB09hM6YQgNSNC+Z51PAH4vK6V8AnCffF9M5FwK7NaHsCwu2pgNGfCN6b+fD34AYCjmOkt
	3DGysFqXUQT7VwBQ==
To: jeff.xie@linux.dev
Cc: linux-kernel@vger.kernel.org, xiehuan09@gmail.com
Subject: Re: [PATCH] genirq: procfs: Make smp_affinity read-only for
 interrupts marked with IRQD_AFFINITY_MANAGED flag
In-Reply-To: <f2e282ae3c502561d8ae302f535d969250dd967e@linux.dev>
Date: Sun, 25 Aug 2024 13:05:14 +0200
Message-ID: <87msl0g8wl.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Aug 24 2024 at 14:54, jeff xie wrote:
>> This unlikely is a pointless exercise as this is not a hotpath
>> operation. Also please switch to S_IRUGO / S_IWUSR and simplify the
>> whole thing to:
>> 
>>  umode_t umode = S_IRUGO;
>> 
>>  if (!irqd_affinity_is_managed(&desc->irq_data))
>
> Okay, I will delete the unlikely.
>
> After thoroughly analyzing the code, I think it would be better to
> replace irqd_affinity_is_managed() with irq_can_set_affinity_usr()
> like below.  What do you think?
>  
>       if (irq_can_set_affinity_usr(desc->irq_data.irq))
>              umode |= S_IWUSR;

Makes sense

