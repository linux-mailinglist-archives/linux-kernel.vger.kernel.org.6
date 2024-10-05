Return-Path: <linux-kernel+bounces-351917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BB0991797
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 17:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A7D1C21087
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 15:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AAF1531F9;
	Sat,  5 Oct 2024 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Akmed4yz"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38FF14C59B
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728140627; cv=none; b=LroAqhbu1oIpsRwBl9++NmcSG4UV+klfJshAbAJkJy1VIqDfT9wXzbvo8cc8xHd5oq1F5XAYQY/z5s2Ts/dk3LwWak3mSa2dezuTew37NIVy8WOp3A6mfAlCBlRc8fH313llXugzkXrb3h7XU9BtEa88gqQ/p7bHYBSOV/9pFHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728140627; c=relaxed/simple;
	bh=yIYJNIjtAl6iXueJ36njn30NBnOohb+/nQThn9Cqruk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LoqOKfFIy6fxZJEsIxFMl+04ZSeclyvRAzEWIWUPeaTA4zxyQg6SY+mLLWgcI4QlsU6ufy4KF8kL4xn+beK417drE+yN7haOiGlgd0JtFNviuiKYGTDBtM0jMYjvStdFm/nHAdtoeOdnrejT0xNymAHxK39NkMEgLjq2WjXpJs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Akmed4yz; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728140617;
	bh=yIYJNIjtAl6iXueJ36njn30NBnOohb+/nQThn9Cqruk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Akmed4yzVmdmaLxCuRfjm11/UD3c/2FcADW1Nyppp6o5TFmsSgSH8AqC7hMDvNfT9
	 iF+wxWcRyJwhkjKnjVl6SRO39+4v187ydmwvXrIXirb9zsXWU6o1tXKyOaGt/mRETs
	 Reh6xzScwAMuG0srgPflIEtd818hGcDfIUcXUz34FkYTCZtyWu9LG85MO8c6b5Y+kA
	 5ZWsgM5sgW2gMmWUymDEWiAgu5MmbHtyaCGbNxyqkQIlvIxWR6eH/nnzlQ6T5W84wo
	 hZu2K0J/MK3/W/QK8aw3JdYhBuh04foUwUx5d/ZV9TDHfCtXdUwyo5Sj/AXAwFz3bq
	 3ISQNOWb21yrw==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XLTFP3BXKzZRp;
	Sat,  5 Oct 2024 11:03:37 -0400 (EDT)
Message-ID: <cdb54cc8-4cbf-4a52-94cf-cab37b0851d8@efficios.com>
Date: Sat, 5 Oct 2024 11:01:37 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Hazard pointer enabled refcount prototype
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, paulmck <paulmck@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <3b749585-1286-4a4e-acd0-1534b60172da@efficios.com>
 <2024100538-acquire-imprecise-ecee@gregkh>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <2024100538-acquire-imprecise-ecee@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-05 10:43, Greg Kroah-Hartman wrote:
> On Fri, Oct 04, 2024 at 03:52:01PM -0400, Mathieu Desnoyers wrote:
>> Hi Greg,
>>
>> After our discussion at KR2024, I've created a prototype adding hazard pointer
>> dereference support to refcount.h:
>>
>> https://github.com/compudj/linux-dev/commit/234523dc9be90f1bc9221bf2d430c9187ac61528
>>
>> Branch: https://github.com/compudj/linux-dev/tree/hp-6.11-refcount
>>
>> It allows dereferencing a pointer to a refcount and incrementing the refcount,
>> without relying on RCU.
>>
>> A good candidate for this would be the "usblp" driver which is using a static mutex
>> for existence guarantees. Introducing a refcount as first field of struct usblp
>> should do the trick.
>>
>> I am not entirely sure if this kind of use-case justifies introducing hazard pointers
>> though, as this can be done just as well with RCU. I'll let you be the judge on this.
> 
> How could it be used with RCU?

This is a trick I've used a lot with liburcu: Using RCU guarantees for
object lookup (pointer dereference) chained with reference counting
(obtained with refcount_inc_not_zero() to keep using the object for
longer than a RCU read-side critical section.

Object reclaim then goes as follow:

- unpublish pointer to object (e.g. list_del or set pointer to NULL).
- refcount_dec_and_test
   -> in release callback, use call_rcu to reclaim object, thus
      chaining reference count decrement to 0 with an RCU grace period.

Object lookup/refcount inc goes as follow:

- rcu read lock
- rcu_deference() to get pointer to object
- try to grab reference with refcount_inc_not_zero
   - if it fails, rcu read unlock and return NULL.
   - on success, we have a reference to the object.
- rcu read unlock

return pointer to an object guaranteed to exist due to refcount,
or NULL if it was not found.

The same kind of trick can be done with hazard pointers rather than
RCU, e.g.:

Object reclaim then goes as follow:

- unpublish pointer to object (e.g. set pointer to NULL).
- refcount_dec_and_test
   -> in release callback, use hp_scan before reclaiming object, thus
      chaining reference count decrement to 0 with a HP scan.

Object lookup/refcount inc goes as follow:

- hp_dereference_acquire to get pointer to the object
- if NULL, return NULL
- try to grab reference with refcount_inc_not_zero
   - if it fails, hp_retire and return NULL
   - on success, we have a reference to the object.
- hp_retire

return pointer to an object guaranteed to exist due to refcount,
or NULL if it was not found.

> I'll have to look into that, but thanks
> for the links and I'll dig into this on Monday to see if I could use
> these to get rid of the "static mutex" pattern that almost all drivers
> need to have these days (which in turn will mean we will not need to use
> that in new rust drivers either, which will make them simpler as well
> because the static mutex pattern in rust is rough to make work.)

If your target is Rust, I have ideas on how we could turn this kind
of Hazard Pointer + Reference Counter combined scheme into smart pointers.
Let me know if this is indeed your goal, and we can discuss this further.

Thanks,

Mathieu

> 
> thanks,
> 
> greg k-h

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


