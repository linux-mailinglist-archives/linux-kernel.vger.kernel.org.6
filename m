Return-Path: <linux-kernel+bounces-241720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3610927E7A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 23:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C01FB21CE4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5812B13D276;
	Thu,  4 Jul 2024 21:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dpolakovic.space header.i=@dpolakovic.space header.b="C7rRBMd2"
Received: from m1-out-mua-14.websupport.sk (m1-out-mua-14.websupport.sk [45.13.137.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF591755B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 21:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.13.137.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720127611; cv=none; b=mVKR93Czwe9SglSwDuYzG6q/aqUnUF7VYCCNC6NTR7yibXEsYFOU6baQpJqzYuIzowOJnOoIsupRxm9fYWphALcy5j2sL1W9D5wQMMuKy6+0IGsCGi2H5TFrt75eBsncaMvf+gFyjD9vG02B8K005E5ZMzPSqmclb2xiOQQBUkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720127611; c=relaxed/simple;
	bh=2n7Ew3LFN/EaMJhM3EteRJnKua/b/SDZYfqPbGs/8BY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeSxz7VDJ/TD7tNBxWbhgKiywm3cDRYClOSUmwfPz0xs9ydqGri4yov4FOiR5AgZ1qe7KN8Nar+Vo9JPAUklgYtimrQpgFRLKtfAvKDvPEdNXhD3ADaUYe3JyQT2qPSyhDKPhgZKVNU1KX5Q/jKaPmjFokvFO8cwNRUzsT8terw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dpolakovic.space; spf=pass smtp.mailfrom=dpolakovic.space; dkim=pass (2048-bit key) header.d=dpolakovic.space header.i=@dpolakovic.space header.b=C7rRBMd2; arc=none smtp.client-ip=45.13.137.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dpolakovic.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dpolakovic.space
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dpolakovic.space;
	s=mail; t=1720127598;
	bh=sB6JAZx/NpsLISrwmracNR5FoEyxWM36nyJFLJmMm5A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C7rRBMd2YXxGoxxUlqZu6wjO+PgjZYOVNQJGvi55FLy6cKoJPdB/VA6kjlJymGXVQ
	 QCKNCtUFWDlAQSJ/QEMd14MBdS4t2Nn3U5NQWCUCxFGgU79eRPvthWU0m6+w+GMXeo
	 bZVUQrlPA3HKLh7kKowbM2dZx9J3dO7dxTIUodF5ZoIKbnZiSRwmeeozE1rCfx8peB
	 4MCnvYyqNpKe2qqJRtheMTTtiENNBel7fJ3kLmduI1sKCeS041LrLIMeuAhH2Iyxy+
	 A529IT1W+nE92sp7TBXrFCagY8dD7lt077uvTyDewhpCp67gm1+vjLAJWjMIrzZsH4
	 ilsJ2T7FNXlgQ==
Received: from m1-u6-ing.websupport.sk (unknown [10.30.6.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by m1-out-mua-14.websupport.sk (Postfix) with ESMTPS id 4WFTrt52hhz5WfH;
	Thu,  4 Jul 2024 23:13:18 +0200 (CEST)
X-Authenticated-Sender: email@dpolakovic.space
Authentication-Results: m1-u6-ing.websupport.sk;
	auth=pass smtp.auth=email@dpolakovic.space smtp.mailfrom=email@dpolakovic.space
Received: from [192.168.0.54] (dev190.net181.ip-net.sk [46.227.181.190])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: email@dpolakovic.space)
	by m1-u6-ing.websupport.sk (Postfix) with ESMTPSA id 4WFTrr4nwTzfPsR;
	Thu,  4 Jul 2024 23:13:16 +0200 (CEST)
Message-ID: <a61e3494-1923-3971-c4e2-f32299aa29bc@dpolakovic.space>
Date: Thu, 4 Jul 2024 23:13:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: proposition for fixing Y292B bug
To: Theodore Ts'o <tytso@mit.edu>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <3be3235a-dea7-a5ca-b5ea-4047bdeb695d@dpolakovic.space>
 <ZoFgga45QCh2uA0i@archie.me>
 <9e3b638d-76f2-8520-2a24-7de0cd0bc149@dpolakovic.space>
 <ZoJx5GaBDHg7nayw@archie.me> <cef39a6f-426d-4c4d-950e-edbbe5e95acf@intel.com>
 <d88861a6-ccd9-3fe5-67e0-b50a72ca1e51@dpolakovic.space>
 <20240704174917.GB973460@mit.edu>
Content-Language: en-US
From: David Polakovic <email@dpolakovic.space>
In-Reply-To: <20240704174917.GB973460@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Out-Rspamd-Queue-Id: 4WFTrr4nwTzfPsR
X-Out-Spamd-Result: default: False [-0.10 / 1000.00];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[11];
	HAS_X_AS(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:56349, ipnet:46.227.176.0/21, country:SK];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,vger.kernel.org,linuxfoundation.org,kernel.org,linutronix.de,linux-foundation.org,zytor.com];
	GENERIC_REPUTATION(0.00)[-0.49973361088932]
X-Rspamd-Action: no action
X-Out-Rspamd-Server: m1-rspamd-out-5
Feedback-ID: m1:dpolakovic.spac

On 7/4/24 19:49, Theodore Ts'o wrote:
> On Wed, Jul 03, 2024 at 05:29:58PM +0200, David Polakovic wrote:
>> I am not sure if I don't understand your solution, but extending the
>> memory designation from 64 to 128 bits, is another temporary
>> solution, which will again overflow one day.
>>
>> The sole reason why I was proposing the new "BigInt" type was to
>> store each digit of the time_c as separate element of array, which
>> could be resized (added one digit) as needed. The only limit would
>> then be the physical amount of memory in the machine.
> You state that you're not experienced enough to be able to send "a
> merge request".  Fair enough; you also apparently don't know that
> github merges is not how kernel patches are submitted, reviewed, and
> integrated.
>
> What you apparently don't appreciate it is that performance is
> something that is critically important for the Linux kernel, and using
> multiple precision integers is not really compatible with the best and
> highest performance.  Computer Science is an engineering discipline,
> and it's all about tradeoffs.  You could enginere a plane that can
> travel faster than the speed of sound, but if that compromises fuel
> efficiency and annoying people who are below its flight path, pursuing
> speed at all costs is not going to lead to commercial success.
> (Exhibit 1: The Concorde).
>
> Similarly, trying to make sure that software will work in the year 292
> Billion AD might not be all something that most people would consider
> high priority.  After all, it's.... unlikely... that the x86_64
> architecture will still be what we will be using 290 billion years
> from now.  So if we need recompile the kernel sometime in the next 100
> billion years for some new CPU architecture, and if it's unlikely that
> hard drives brought brand new are likely to be still in operation a
> decade or two from now --- there is plenty of time to evolve the
> on-disk format before a billion years go by, let alone 100 billion or
> 200 billion years.
>
> Finally, kernel development is driven by people who are willing to do
> the work.  If you want to demonstrate that it's possible to use MP
> integer mathematicswithout horribly comprmising performance, then you
> need to do the work.  (BTW, if you don't know what the term "cache
> line" means, then I encourage that you understand that first.)  But
> dropping a pointer to a blog post and expecting that people to do your
> homework for you is not really realistic.
>
> Cheers,
>
> 					- Ted

I appreciate your response, finally some thoughts on the proposition itself
and please let me clear something up. It was exactly as you said, an 
tradeoff
I considered worthy and I wasn't expecting anyone to do "my work".
I thought that someone, experienced enough, might find this worthy
of try.

However, I'll take your challenge, and I will try to do the work on my 
own, if no
one else will. Let's see where it will lead me.

dpo


