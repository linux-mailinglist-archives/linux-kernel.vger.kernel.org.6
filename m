Return-Path: <linux-kernel+bounces-323315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACBA973B47
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5800FB215DE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25664199FB3;
	Tue, 10 Sep 2024 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="C+1RN8+v"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97863199E9D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981426; cv=none; b=LEMFVwyLu/E3R9PbUeeLyXRR3cLAHwiRo3a2/YMICMI3gPev+cgVb3up6lhOpbBj9zJdR+LCvw8fmpvah1WFOlmRISdxmYGj04+Woeql7YeRn2GsE2qtG0q8391ps/cbSJoSnlvfOVpWYilj8Xrv2132ux91E68s0ARUisks06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981426; c=relaxed/simple;
	bh=qPBLXFdi9sN5EuTXj3TwAVl7hnnUfJazOo6zg4PoilE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJGkRlLnnVAzslzY220kQmwkWiZOfvdJZlVu1wYRGyBnqB++ZtsCN7Fx1Lb+PDcVvXTzYWu2PjVppvMKbXYkwb1xi7geqn3tg1k92oZ92on16+TIkG/jwb+r+SmpnjWPRxoc6DvpdSW9RRFdAs0pNwuRKaI81LtxhVZTeQ6fC3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=C+1RN8+v; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-39f4f62a303so3458025ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725981423; x=1726586223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cQlPOIt47P9pJ/HtBNm3/76vtXO+5TET7dTEy1xSVjk=;
        b=C+1RN8+vK4dU2xSajMQmn42OpHLWGXSzy6R/V4TramZgOp+GI6b7Ov8s0XQzcNOypQ
         ENgDmBZwYeNKPkFsJk8fIANpITevYluXfCc4gqVqwLzOQK3OG/c64ovN4edK0ZxsIagq
         7YNQk81Rq76Hcx0bks3XUNoLOSW4QkRspt2DHJP4gDJTKyQgsHY8rUYZXeA7KJH0ZhU/
         CwaYV14gFYj1riegEU6rnyWL0QcaBzD9PqF/GuJwa/lONvY1QnIDPa4Bht5sgVT3LCUa
         pQEa3UjJa77+MSEEcgkzcYF/OAlSjY7suIpqyHvC5LrMmjXNJcAJ+owUpkri+2z6jnOo
         aBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725981423; x=1726586223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQlPOIt47P9pJ/HtBNm3/76vtXO+5TET7dTEy1xSVjk=;
        b=XplANpT++0IIeBgE3tUupSpgYbsbwSUx0TaFNNVaNmFL2DByUIqZ0WEdPdZyale6RT
         XsbmrTpAkiclPCKh1cNR9+GhlPawFSdULezBs8oPy8fAjaHb4pmGkxAmtqo4CPyVkwYU
         hlXs9oPQqYys5BCmAiDCrpe/8mr628c0vx6aHgiu90xFTr/tRaOgXcyKH8T+T+eKdC/e
         Hg/vJP48ntNIgWr+tUX0/kvbU3VEB6SwS4Oq7dJ70tAeA+4EGvXXRro8uX4IUqoPnv8T
         kfmuVkdfrkhqOSSrCLtWKNLkAY/DkItyIqG7oFVOBKUSwOlXwcOWnHHbmI6S3i/0Lw9p
         Sn5A==
X-Forwarded-Encrypted: i=1; AJvYcCUBQz8d8RdbNuiMBB1Pu7BYdyYabrZNVmiNDwq6lsv2QnxiAZlE9xs+VI+H56o7xOOSg2ZM6S8pR+DSFPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUQqGqusB8Iviwwj1cnFPsnfg0kEzNW5BVO3y1+S95k+rxvFqq
	4KBR3kvMJn6pT5vCtMbzS1ExR94LXejnP4lxMgjwFs2NjZBHNFQA45EdiLPAtas=
X-Google-Smtp-Source: AGHT+IHQexFi2cJW5U5TxvLDm6Hn064VKVDu/UEY0lNFV/+YLj+1QFUJ7SOjDDYLXg+K9B6+e+eYhQ==
X-Received: by 2002:a05:6e02:1fce:b0:39d:47cf:2c7f with SMTP id e9e14a558f8ab-3a0742b0835mr958145ab.24.1725981422588;
        Tue, 10 Sep 2024 08:17:02 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d094561ca9sm1641338173.72.2024.09.10.08.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 08:17:01 -0700 (PDT)
Message-ID: <9cd8bae3-ba32-4b44-a4c0-63f5e5a3de35@kernel.dk>
Date: Tue, 10 Sep 2024 09:17:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] io_uring/io-wq: respect cgroup cpusets
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
Cc: "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "longman@redhat.com" <longman@redhat.com>,
 "asml.silence@gmail.com" <asml.silence@gmail.com>,
 "Schmidt, Adriaan" <adriaan.schmidt@siemens.com>,
 "dqminh@cloudflare.com" <dqminh@cloudflare.com>
References: <20240910143320.123234-1-felix.moessbauer@siemens.com>
 <ec01745a-b102-4f6e-abc9-abd636d36319@kernel.dk>
 <92d7b08e4b077530317a62bb49bc2888413b244a.camel@siemens.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <92d7b08e4b077530317a62bb49bc2888413b244a.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/24 9:08 AM, MOESSBAUER, Felix wrote:
> On Tue, 2024-09-10 at 08:53 -0600, Jens Axboe wrote:
>> On 9/10/24 8:33 AM, Felix Moessbauer wrote:
>>> Hi,
>>>
>>> this series continues the affinity cleanup work started in
>>> io_uring/sqpoll. It has been tested against the liburing testsuite
>>> (make runtests), whereby the read-mshot test always fails:
>>>
>>>   Running test read-mshot.t
>>>   Buffer ring register failed -22
>>>   test_inc 0 0
>>> failed                                                             
>>>                                                              
>>>   Test read-mshot.t failed with ret 1     
>>>
>>> However, this test also fails on a non-patched linux-next @ 
>>> bc83b4d1f086.
>>
>> That sounds very odd... What liburing are you using? On old kernels
>> where provided buffer rings aren't available the test should just
>> skip,
>> new ones it should pass. Only thing I can think of is that your
>> liburing
>> repo isn't current?
> 
> Hmm... I tested against
> https://github.com/axboe/liburing/commit/74fefa1b51ee35a2014ca6e7667d7c10e9c5b06f

That should certainly be fine.

> I'll redo the test against the unpatched kernel to be 100% sure that it
> is not related to my patches. The -22 is likely an -EINVAL.

I'd be highly surprised if it's related to your patches! Here's what I
get on the current kernel:

axboe@m2max-kvm ~/g/liburing (master)> test/read-mshot.t
axboe@m2max-kvm ~/g/liburing (master)> echo $status
0

and on an older 6.6-stable that doesn't support it:

axboe@m2max-kvm ~/g/liburing (master)> test/read-mshot.t
skip
axboe@m2max-kvm ~/g/liburing (master) [77]> echo $status
77

and then I tried 6.1 since that seems to be your base and get the same
result as 6.6-stable. So not quite sure why it fails on your end, but in
any case, I pushed a commit that I think will sort it for you.

>>> The test wq-aff.t succeeds if at least cpu 0,1 are in the set and
>>> fails otherwise. This is expected, as the test wants to pin on
>>> these
>>> cpus. I'll send a patch for liburing to skip that test in case this
>>> pre-condition is not met.
>>>
>>> Regarding backporting: I would like to backport these patches to
>>> 6.1 as
>>> well, as they affect our realtime applications. However, in-between
>>> 6.1
>>> and next there is a major change da64d6db3bd3 ("io_uring: One wqe
>>> per
>>> wq"), which makes the backport tricky. While I don't think we want
>>> to
>>> backport this change, would a dedicated backport of the two pinning
>>> patches for the old multi-queue implementation have a chance to be
>>> accepted?
>>
>> Let's not backport that patch, just because it's pretty invasive.
>> It's
>> fine to have a separate backport patch of them for -stable, in this
>> case
>> we'll have one version for stable kernels new enough to have that
>> change, and one for older versions. Thankfully not that many to care
>> about.
> 
> Ok, that is fine for me. Then let's first get things right in this
> series and then I'll send the backport.

Exactly, that's the plan. Thanks!

-- 
Jens Axboe

