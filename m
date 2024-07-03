Return-Path: <linux-kernel+bounces-239747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0AD9264DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDAB81C21064
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E36179641;
	Wed,  3 Jul 2024 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dpolakovic.space header.i=@dpolakovic.space header.b="Ff6ayhG2"
Received: from m1-out-mua-14.websupport.sk (m1-out-mua-14.websupport.sk [45.13.137.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0980417CA1D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.13.137.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720020614; cv=none; b=ZPao4B7OZBe6W4/nWCAuwtKIsZp+W5vYDlOZaXBYas58ZPy/Q4Eis68QlHjho8y/CrVUdArI8BE4+biBaBlaBjGA5GzJnbZgewmeIfSZh9XQpqwKXcB+4/LOYf4fvdestznCH1Ho1upORJ/PRST9ZzAYblyFvo4/DHLFBK1uDCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720020614; c=relaxed/simple;
	bh=y+y08AM3f5TOY4c9E78hb87lm+/c2eOErjtpjPBqmEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mmLWAul8exrqtF53IFxSMgu/hZXuc47rA5DV31WSk8YdZzxUeaoIj2Cff1gSJS6mPAUkjsrNO4oMDYPPVtOt3yoVDj6Sg2Y0vCQFrZ0uiBPHO4lekv8T8dHNuakN0E+YLl0J/7eCZXDhsXEM6BbirPaGhtQ7S7CyyUvX5nRCJRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dpolakovic.space; spf=pass smtp.mailfrom=dpolakovic.space; dkim=pass (2048-bit key) header.d=dpolakovic.space header.i=@dpolakovic.space header.b=Ff6ayhG2; arc=none smtp.client-ip=45.13.137.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dpolakovic.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dpolakovic.space
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dpolakovic.space;
	s=mail; t=1720020601;
	bh=y+y08AM3f5TOY4c9E78hb87lm+/c2eOErjtpjPBqmEM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ff6ayhG25KPL0NT5fYLPKokke6QeJPAHBQcXVN8yVMs6VHllQ8ixPv5WdS900oMLz
	 1+P2vbYa9vnJWX8SBPb2neRg/XkMlU4s0sS7YjYgAQ3izxfcmc1AYjl4KgY1bNWbra
	 VfVgBncEhHOqBiHnbMFYx2uZ84a2CXtc2pesqKeYrNbLT99STVVdykqJv5n+AIUtEg
	 4EOKXaMmEIagCpUyypIdqT0O+E9eueT0HCS6vJCl+tBz9RtXWimcWV1v9seXcYhzm2
	 6PbJuu/t5mB8/lEI5g2UvXFZpt3X+Hhcuu8KVVpsbH0VHZduKfUvVvmAF8/4yXpaEC
	 eqtlCe3Jb/Irw==
Received: from m1-u7-ing.websupport.sk (unknown [10.30.7.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by m1-out-mua-14.websupport.sk (Postfix) with ESMTPS id 4WDkHF6RSCz1wrg;
	Wed,  3 Jul 2024 17:30:01 +0200 (CEST)
X-Authenticated-Sender: email@dpolakovic.space
Authentication-Results: m1-u7-ing.websupport.sk;
	auth=pass smtp.auth=email@dpolakovic.space smtp.mailfrom=email@dpolakovic.space
Received: from [192.168.0.54] (dev190.net181.ip-net.sk [46.227.181.190])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: email@dpolakovic.space)
	by m1-u7-ing.websupport.sk (Postfix) with ESMTPSA id 4WDkHD0NqPzmhkX;
	Wed,  3 Jul 2024 17:29:59 +0200 (CEST)
Message-ID: <d88861a6-ccd9-3fe5-67e0-b50a72ca1e51@dpolakovic.space>
Date: Wed, 3 Jul 2024 17:29:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: proposition for fixing Y292B bug
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Theodore Ts'o <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <3be3235a-dea7-a5ca-b5ea-4047bdeb695d@dpolakovic.space>
 <ZoFgga45QCh2uA0i@archie.me>
 <9e3b638d-76f2-8520-2a24-7de0cd0bc149@dpolakovic.space>
 <ZoJx5GaBDHg7nayw@archie.me> <cef39a6f-426d-4c4d-950e-edbbe5e95acf@intel.com>
Content-Language: en-US
From: David Polakovic <email@dpolakovic.space>
In-Reply-To: <cef39a6f-426d-4c4d-950e-edbbe5e95acf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Out-Rspamd-Queue-Id: 4WDkHD0NqPzmhkX
X-Out-Spamd-Result: default: False [-0.10 / 1000.00];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[intel.com,gmail.com];
	ASN(0.00)[asn:56349, ipnet:46.227.176.0/21, country:SK];
	ARC_NA(0.00)[];
	HAS_X_AS(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	GENERIC_REPUTATION(0.00)[-0.49974851024184]
X-Out-Rspamd-Server: m1-rspamd-out-5
X-Rspamd-Action: no action
Feedback-ID: m1:dpolakovic.spac

On 7/1/24 15:31, Alexander Lobakin wrote:
> From: Bagas Sanjaya <bagasdotme@gmail.com>
> Date: Mon, 1 Jul 2024 16:07:48 +0700
>
>> On Sun, Jun 30, 2024 at 05:27:24PM +0200, David Polakovic wrote:
>>> Thanks for reply.
>> Please don't top-post on LKML, reply inline with appropriate context
>> instead.
>>
>>> My proposed solution was to create this BigInt datatype, which
>>> stores the value in array. The functions for division, multiplication,
>>> addition, subtraction and comparison could be stored in separate
>>> ".h" library for manipulation with BigInt datatype. The paper speaks
>>> more in detail.
> IRRC there is big integer type somewhere in either lib/ or crypto/,
> I don't remember exactly. It's used only for crypto tho.
>
>>> And yes, this truly is an userspace solution, but for kernel space
>>> implementation I have zero to none experience. Therefore I wrote
>>> here.
>> There was a proposal for adding 128-bit unsigned integer (see [1]).
>> The signed counterpart should be analogous.
> I have generic 128-bit integer API/infra for the kernel in my internal
> repo. I've been planning to upstream it for a couple years already, but
> every time couldn't find a slot to do that.
> I can upload it to my open GitHub, so that maybe someone else who needs
> it could pick it up?
>
>> Thanks.
>>
>> [1]: https://lore.kernel.org/lkml/20220722145514.767592-1-alexandr.lobakin@intel.com/
> Thanks,
> Olek


I am not sure if I don't understand your solution, but extending the
memory designation from 64 to 128 bits, is another temporary
solution, which will again overflow one day.

The sole reason why I was proposing the new "BigInt" type was to
store each digit of the time_c as separate element of array, which
could be resized (added one digit) as needed. The only limit would
then be the physical amount of memory in the machine.

dpo


