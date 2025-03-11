Return-Path: <linux-kernel+bounces-556275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3A7A5C38C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226453B0DDB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5B025BAA1;
	Tue, 11 Mar 2025 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EvbQQnUv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YRKNibT6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E409D25A653
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702448; cv=none; b=KOwmV8CkAZwFXR3K05mcF3fym5i0G5raTEN747bxE9obzVabb/0pRHSl0cMG+2hYpgHyjvrgg8o97z20EuWqcNa1xwcUBduX1+svqWvZWtJxY4sIkjhXJZ57JfOjBTTbIusoWzj98KlRyMnDHwoxQBRGGCISIlWzFRFfinEeQ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702448; c=relaxed/simple;
	bh=SJzweYvvAjkk4nXVWtAc9YG5JrzU72YCGI/uizZLN7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LOKuBi2RRDLphtCElW8c01kIlNLwtKZIegdpV9Ry3lHfHQ9r1v1kwjaBNg3jyn3FguN5uTUrIg86hM9u96WH7tk+1f1GnbhqMWyV/vRexP31AYiCMr7lg4gCtqpaX5Cyfh8hBPaksiAOr4Rlk0VhJMr9wImg8Y9eR4V6GN1Z3tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EvbQQnUv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YRKNibT6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741702444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AE8/gageOOWljGwuK3f0FDauIaeV4p0/TC1zdmgv2Eg=;
	b=EvbQQnUvp8GVNsz1GXDyeNqERdgvKGN6VxR/jwd2ju/YSQp5BroxXI3BiB1V/rJrygLv1/
	nCUZnb0oixJs2WIiYWsOuYOZK2qhE2+7BJZWAZzHqf6C9LPm5vG0eOEp8bzGJZY5cOdK+c
	xSooQgTvrWkJpsSkRrdlSz3s7L97CQK0nAGUQlGqad2DwvL+0jhJhsh6xdywPENgeBCAJt
	dz4EHBxG/A8gp3L3eGQnElEwlHu6lJffeubzM0gt2ATSYa8qtQRVB/4oN6JV9HdJtcU0qF
	ab/YswK4EFRWWTITG3BuAqmdSpPQhfGquAQTlYRPX6srn85gojMGCCXSEQPQ+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741702444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AE8/gageOOWljGwuK3f0FDauIaeV4p0/TC1zdmgv2Eg=;
	b=YRKNibT6X+M3p5+rT4KjQrmVeUxvXgYP9GRLEdNLWH9SYvPGMaVFGBcZqSlbDxeAZ9i4zC
	CvuYamUxuLdv4JDg==
To: Yajun Deng <yajun.deng@linux.dev>
Cc: linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: Re: [PATCH] genirq: Keep affinity_hint unchanged if it has a value
In-Reply-To: <20250311013352.2727490-1-yajun.deng@linux.dev>
References: <20250311013352.2727490-1-yajun.deng@linux.dev>
Date: Tue, 11 Mar 2025 15:14:04 +0100
Message-ID: <871pv31wpf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 11 2025 at 09:33, Yajun Deng wrote:
> affinity_hint is a hint to user space for preferred irq affinity, but
> it could chang if the value it points to is changed. In other words,
> the hint is invalid.

That's a problem of the driver which provides the hint.
>
> For example, if affinity_hint points to smp_affinity, smp_affinity
> is changed by the user, and affinity_hint would chang. affinity_hint
> couldn't as a hint to the user, it should keep the value if it has.

What is 'smp_affinity'? 

I really fail to understand the problem you are trying to solve.

Thanks,

        tglx

