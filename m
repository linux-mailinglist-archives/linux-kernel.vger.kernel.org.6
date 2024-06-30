Return-Path: <linux-kernel+bounces-235256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEF691D252
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 17:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E927B209D2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 15:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F970153517;
	Sun, 30 Jun 2024 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dpolakovic.space header.i=@dpolakovic.space header.b="Lpj97W8C"
Received: from m1-out-mua-14.websupport.sk (m1-out-mua-14.websupport.sk [45.13.137.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF8F1527AF
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.13.137.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719761253; cv=none; b=XEa97OT7i4Abi33MECTXpb68/TtJJKpuv0ugxgkcKZdkUOZLt2cxZdyr0174Bf3CSMaTmkwYs9MSbGpMiU+4otTmW5stiA11FdNBe96vES3LWm7Pjk/e8gKjzTJqafnGBBxqd5yWarEaPhTb/fBFUKz7EcbrOj/XDquDZ1ptHtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719761253; c=relaxed/simple;
	bh=hVsbcKrwrQ3OoEgw8Y8zg8NGLkzoqomWNcuzWMWboO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZdjDQEV+fzPtBZGeeg3XsSO/j3DQ7Hkk2e+V0IPZWK3bJEtrnfDsBVAxtbLZJc1YMo0wEbSXtVD5FvXsgTRxdWwJfN3wWkGXL3PXcwqfDYFKCP7hr5t8FgAxNSOY1xx6Qbm6vI769Kx8iWGh0meq0P/Lc7oh6HgNGAudRl3pts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dpolakovic.space; spf=pass smtp.mailfrom=dpolakovic.space; dkim=pass (2048-bit key) header.d=dpolakovic.space header.i=@dpolakovic.space header.b=Lpj97W8C; arc=none smtp.client-ip=45.13.137.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dpolakovic.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dpolakovic.space
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dpolakovic.space;
	s=mail; t=1719761246;
	bh=hVsbcKrwrQ3OoEgw8Y8zg8NGLkzoqomWNcuzWMWboO8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Lpj97W8CtjWQ6T/Mp78pXlScLJ8uNwxDU3tYDRoz8lMzSvkmI/bC1N74WRkqztDnH
	 Q4eTjhDOYiEKvon8OChNtkn/5gp7X5xtpLcegWnrfyZD6SD/arm0k/ocRoyENnlufo
	 idKgZ3wKwLs1Vdl7Wift/ng5VthhHUgCj++yFzE1nkeWw7eug18LnK7BbK4LhIZlEU
	 kNdyOHsh+pK0yL1TLhLnTgehuF/KqyLfxtHo1XBr53HSWNvmMp3mKTGohwxMpNJVyt
	 aXiwz4QLIODByxYzUSzURncdch5jfWWg38u2AI2E7DcYFM27Y41frpRYxDqAvtApX9
	 7v8YVYF2ptCKQ==
Received: from m1-u5-ing.websupport.sk (unknown [10.30.5.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by m1-out-mua-14.websupport.sk (Postfix) with ESMTPS id 4WBtMf6Hhqz1G26;
	Sun, 30 Jun 2024 17:27:26 +0200 (CEST)
X-Authenticated-Sender: email@dpolakovic.space
Authentication-Results: m1-u5-ing.websupport.sk;
	auth=pass smtp.auth=email@dpolakovic.space smtp.mailfrom=email@dpolakovic.space
Received: from [192.168.1.29] (static-bband-88.87-197-167.telecom.sk [87.197.167.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: email@dpolakovic.space)
	by m1-u5-ing.websupport.sk (Postfix) with ESMTPSA id 4WBtMd2g8fzY9Ml;
	Sun, 30 Jun 2024 17:27:25 +0200 (CEST)
Message-ID: <9e3b638d-76f2-8520-2a24-7de0cd0bc149@dpolakovic.space>
Date: Sun, 30 Jun 2024 17:27:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: proposition for fixing Y292B bug
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>
References: <3be3235a-dea7-a5ca-b5ea-4047bdeb695d@dpolakovic.space>
 <ZoFgga45QCh2uA0i@archie.me>
Content-Language: en-US
From: David Polakovic <email@dpolakovic.space>
In-Reply-To: <ZoFgga45QCh2uA0i@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Out-Spamd-Result: default: False [1.90 / 1000.00];
	INTRODUCTION(2.00)[];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	HAS_X_AS(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:6855, ipnet:87.197.0.0/16, country:SK];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Out-Rspamd-Queue-Id: 4WBtMd2g8fzY9Ml
X-Out-Rspamd-Server: m1-rspamd-out-5
Feedback-ID: m1:dpolakovic.spac

Thanks for reply.

My proposed solution was to create this BigInt datatype, which
stores the value in array. The functions for division, multiplication,
addition, subtraction and comparison could be stored in separate
".h" library for manipulation with BigInt datatype. The paper speaks
more in detail.

And yes, this truly is an userspace solution, but for kernel space
implementation I have zero to none experience. Therefore I wrote
here.

dpo


On 6/30/24 15:41, Bagas Sanjaya wrote:
> On Sun, Jun 30, 2024 at 10:05:18AM +0200, David Polakovic wrote:
>> Hello dear developers and enthusiasts.
>>
>> My name is David and recently I wrote a blog post about "necessity"
>> of fixing 64-bit signed integer overflow of time_t, sometime in year
>> 292 billion. I proposed this to simply have software complete solution
>> for timekeeping. The blog had somewhat nice feedback and few people
>> told me to write to your mailing list.
>>
>> As I mention in the list, I am no way experienced enough in kernel
>> space to turn this into full merge request, so I post it to you and
>> if anyone would like to build on this idea, it is GPLd for your convenience.
>>
>> Any feedback is highly appreciated so please, include me in CC's.
>>
>> The blog is written with funny attitude, but it is in no way meant to
>> be joke, parody or insult.
>> https://dpolakovic.space/blogs/y292b
> Reading your paper, it seems like the userspace solution is to introduce bigger
> int type (i.e. int128/bigint); and you want the same to apply to kernel, right?
> Also, if that happens, I think C also needs built-in bigint type.
>
> Confused...
>

