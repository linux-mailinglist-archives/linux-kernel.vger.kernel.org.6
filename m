Return-Path: <linux-kernel+bounces-241895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 854659280D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 05:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5231F250EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CAB225A2;
	Fri,  5 Jul 2024 02:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UkYE2oxv"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5061225AE
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 02:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720148383; cv=none; b=RdreX+vJttHX7yk9durE69UYIBRECxQyEKSJw74Q9koSkUeBGNxBySx12oByq8lgq93JYlQ7W2B5kOlqyAnDi1t5ewrDl6rGLcrdWXgwuttv8LNX0xspDKLtlJIZZNH07xNOXSYNFx8GG5bLnopgk38dUf12oDkCCxyTzL3zYxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720148383; c=relaxed/simple;
	bh=2Oiuvj7EbyooIILDkmRlNFGc8GCiYvx6AdilmGgLqFg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=tNugezM/kWhzUS2lc1D1j/wGJFG4LCkrxdpwPLde+fWCMFTyl+ELB1kWN7rvNf71mcnA288YKlhAeXua3a6gIW0puCSNn1u5rzUPw0zMddt9CdEpf3YJ4CDikNcZPPjI3teZ0n+j3qsLOxly2usOuO5dlNaeZSAQv4mCQNo/8dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=UkYE2oxv reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4652xEh11674870
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 4 Jul 2024 19:59:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4652xEh11674870
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1720148356;
	bh=OVCOj6R0uUEzf1Owbcu+39qs+xwwUg7cr2XF4X6ej2E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=UkYE2oxvZHzMxBZJBABsVgGWGZk54lKrD5bH4lsQFOFQcS29wDe+ySmbAI1iGrc2t
	 c62eXgyjrtMFJ2xviowD2VnUi2IXBQAjn8xwXqL4w4T7qPYrVHVwSyM7ugeZ1fchqM
	 FtifWXmFhJSnbTvqYwPe1cZG3rFhpKqkZ7M1xhaUv5NYMM9d/70UfL8heq8MfY9Ywm
	 bZIX3bA6fXGTKv8VG8QymO7qvoJeUeMItC5H830sb++9yXJyVh4xij4xJ2EiaPWPLn
	 X/GtitpxTjz/t+DoTWVQswnEgBvG6Lx5m/WwXipfwVV3NLzT5Kup1nM4ogorcldXg8
	 weQzPv7a5bi5Q==
Date: Thu, 04 Jul 2024 19:59:13 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Polakovic <email@dpolakovic.space>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: proposition for fixing Y292B bug
User-Agent: K-9 Mail for Android
In-Reply-To: <d88861a6-ccd9-3fe5-67e0-b50a72ca1e51@dpolakovic.space>
References: <3be3235a-dea7-a5ca-b5ea-4047bdeb695d@dpolakovic.space> <ZoFgga45QCh2uA0i@archie.me> <9e3b638d-76f2-8520-2a24-7de0cd0bc149@dpolakovic.space> <ZoJx5GaBDHg7nayw@archie.me> <cef39a6f-426d-4c4d-950e-edbbe5e95acf@intel.com> <d88861a6-ccd9-3fe5-67e0-b50a72ca1e51@dpolakovic.space>
Message-ID: <848ADF85-6138-4D56-8DDD-E327B8AFC5EC@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 3, 2024 8:29:58 AM PDT, David Polakovic <email@dpolakovic=2Espace> =
wrote:
>On 7/1/24 15:31, Alexander Lobakin wrote:
>> From: Bagas Sanjaya <bagasdotme@gmail=2Ecom>
>> Date: Mon, 1 Jul 2024 16:07:48 +0700
>>=20
>>> On Sun, Jun 30, 2024 at 05:27:24PM +0200, David Polakovic wrote:
>>>> Thanks for reply=2E
>>> Please don't top-post on LKML, reply inline with appropriate context
>>> instead=2E
>>>=20
>>>> My proposed solution was to create this BigInt datatype, which
>>>> stores the value in array=2E The functions for division, multiplicati=
on,
>>>> addition, subtraction and comparison could be stored in separate
>>>> "=2Eh" library for manipulation with BigInt datatype=2E The paper spe=
aks
>>>> more in detail=2E
>> IRRC there is big integer type somewhere in either lib/ or crypto/,
>> I don't remember exactly=2E It's used only for crypto tho=2E
>>=20
>>>> And yes, this truly is an userspace solution, but for kernel space
>>>> implementation I have zero to none experience=2E Therefore I wrote
>>>> here=2E
>>> There was a proposal for adding 128-bit unsigned integer (see [1])=2E
>>> The signed counterpart should be analogous=2E
>> I have generic 128-bit integer API/infra for the kernel in my internal
>> repo=2E I've been planning to upstream it for a couple years already, b=
ut
>> every time couldn't find a slot to do that=2E
>> I can upload it to my open GitHub, so that maybe someone else who needs
>> it could pick it up?
>>=20
>>> Thanks=2E
>>>=20
>>> [1]: https://lore=2Ekernel=2Eorg/lkml/20220722145514=2E767592-1-alexan=
dr=2Elobakin@intel=2Ecom/
>> Thanks,
>> Olek
>
>
>I am not sure if I don't understand your solution, but extending the
>memory designation from 64 to 128 bits, is another temporary
>solution, which will again overflow one day=2E
>
>The sole reason why I was proposing the new "BigInt" type was to
>store each digit of the time_c as separate element of array, which
>could be resized (added one digit) as needed=2E The only limit would
>then be the physical amount of memory in the machine=2E
>
>dpo
>

So now you are worried about the Y5e30 problem?!

You realize that you are now talking the orders of magnitude of time for w=
hich:=20

"	The estimated time until most or all of the remaining 1=E2=80=9310% of s=
tellar remnants not ejected from galaxies fall into their galaxies' central=
 supermassive black holes=2E By this point, with binary stars having fallen=
 into each other, and planets into their stars, via emission of gravitation=
al radiation, only solitary objects (stellar remnants, brown dwarfs, ejecte=
d planetary-mass objects, black holes) will remain in the universe=2E"

I genuinely thought this whole thread was a practical joke=2E=2E=2E

