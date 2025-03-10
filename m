Return-Path: <linux-kernel+bounces-554382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDD9A5970E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601E3188BD63
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D17022AE75;
	Mon, 10 Mar 2025 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="isq98SkE"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EF411CBA;
	Mon, 10 Mar 2025 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615637; cv=none; b=BQkXA8NQUwj/qcU+dqXc12lAO1p0BUStsE4jdq3zYP/+stpsm0hS5FlSRShfuM6//oK7Q55LTqOcgvixLIs+SG44vSPuZwsGl2sBS4+vmDssnQrelCu0zgGFFYnq1iIXFe6nMi7lH3ofKiwTDZE+d3x+Okn2499sufxIE/VDAQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615637; c=relaxed/simple;
	bh=MXCvGpFSBuVp6krHHN3isLBAZvN02Z1YPRIGbhtklf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d6zQIYgW42NmourBDHRotgIrMEeQeMHglbXFc6fXgXOYBG1Vp99QTcld2WBZJtZQQ0zmZtY3PGXX0EnTn1f5Bowtv9GEozoVWJY680vbqCZN3FYVGfLZmvbIHl6piaN3XyTDnK3Jr4xn6eL7fdGXEB9/CQ4ArJ6oV6ktQPH4j9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=isq98SkE; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3FAF141064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1741615627; bh=X1mozlohMHXfQrE6hTxUIE0Q7zs60BV8xjtJXHV5TZ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=isq98SkEfKvmCJL1snJYwOk2OIUhhPAyWqFwaANJpLKuzqws0YAbHbd21eGOb3Uag
	 SV1UliltHXbSSA+LbZDqnUqeYKYVs7ENkAYeJ9E4nKbcAu7v0IGXFezexPGY0e9dp5
	 yhQH2Q8Mja1FYzI2ymKFtVXGtfMVaokwRoQYJGVgYWygnlWTvW5km76BVqEKralFyM
	 GnMFPvQwhStT5V+jZeyrE71XjAYx6sCVoBH+DXzcBPD7xLcaFAVoBl/rNk9dWRetRO
	 oqhfGle/cltfPG3XIPkN58b66oBA3jtFDu9kATmzPrPwmhuT8kf02Rd6Zx9PT0PKJb
	 msVeFYNzLW3Hg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3FAF141064;
	Mon, 10 Mar 2025 14:07:07 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Yury Norov <yury.norov@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Vincent Guittot
 <vincent.guittot@linaro.org>, Akira Yokosawa <akiyks@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mauro Carvalho
 Chehab <mchehab@kernel.org>
Subject: Re: [PATCH V2 1/2] cpumask: Fix kernel-doc formatting errors in
 cpumask.h
In-Reply-To: <Z8snakYmzhaavkKN@thinkpad>
References: <cover.1741332579.git.viresh.kumar@linaro.org>
 <f4ad81150eaa00b43c161f0d1f811f8ecfe21889.1741332579.git.viresh.kumar@linaro.org>
 <Z8snakYmzhaavkKN@thinkpad>
Date: Mon, 10 Mar 2025 08:07:06 -0600
Message-ID: <87r0350yk5.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yury Norov <yury.norov@gmail.com> writes:

> On Fri, Mar 07, 2025 at 01:04:51PM +0530, Viresh Kumar wrote:
>>  /**
>> - * cpumask_first_and_and - return the first cpu from *srcp1 & *srcp2 & *srcp3
>> + * cpumask_first_and_and - return the first cpu from *@srcp1 & *@srcp2 & *@srcp3
>>   * @srcp1: the first input
>>   * @srcp2: the second input
>>   * @srcp3: the third input
>> @@ -266,7 +266,7 @@ unsigned int cpumask_any_distribute(const struct cpumask *srcp);
>>  #endif /* NR_CPUS */
>>  
>>  /**
>> - * cpumask_next_and - get the next cpu in *src1p & *src2p
>> + * cpumask_next_and - get the next cpu in *@src1p & *@src2p
>>   * @n: the cpu prior to the place to search (i.e. return will be > @n)
>>   * @src1p: the first cpumask pointer
>>   * @src2p: the second cpumask pointer
>
> So the question: if some word in this particular comment block is
> prefixed with @ symbol, can we teach kernel-doc to consider every
> occurrence of this word as a variable?
>
> Why I'm asking: before the "*src1p & *src2p" was a line of C code.
> And because we are all C programmers here, it's really simple to ident
> it and decode. After it looks like something weird, and I think many
> of us will just mentally skip it.
>
> I like kernel-docs and everything, but again, kernel sources should
> stay readable, and particularly comments should stay human-readable.

I'm sure it *can* be done, yes.  In truth, given that we're dealing with
named parameters in a prototype that we are decoding, we might be able,
with enough clever programming, to do away with that markup entirely.

It's just a matter of programming :)

I've added Mauro, since he's in the process of replacing kernel-doc
entirely.  I suspect he has enough on his hands at the moment without
adding extra objectives, and will want to get that replacement
successfully done first.  But it's a worthy goal to keep in mind.


>> @@ -334,7 +334,8 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
>>   * @mask1: the first cpumask pointer
>>   * @mask2: the second cpumask pointer
>>   *
>> - * This saves a temporary CPU mask in many places.  It is equivalent to:
>> + * This saves a temporary CPU mask in many places.  It is equivalent to::
>> + *
>
> I'm OK with extra line, but this double-colon. What for and what does
> it mean?

The :: introduces a literal block, which needs a blank line to start it.

Thanks,

jon

