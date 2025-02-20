Return-Path: <linux-kernel+bounces-522826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACBCA3CED4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435503B17E4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FA6146D53;
	Thu, 20 Feb 2025 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIXLHQW8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1085012B73
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015612; cv=none; b=akSG+wEiwxkORvbhhECO8ePyrBPc4AR9aXrqr0WspZ+NR9rcsZ8I2aDZ1sEa4DI+Pt8ZWI+iJ9/FRSpk87GyoFrLyR6+9W/2YTF1ZlwKKkv0OddZpKTeEolwlurE15gGPS+zvh+W6IrQA4Bx53sa7rvkA5LPsWIPFYdJB7EHbTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015612; c=relaxed/simple;
	bh=PsPq3lWzj/hdHs7bBGraH17Zrm5OigDZI1546jIH45g=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sLGmkoDQpUHZQdTb2sSycO2bgUHn1x8HEJaXcB6Q66KRg83PdICibD1//W+y1/LGLXZcF4g3UirLeqxB3KCm8RdJKOVa4OKAqv+eRYIoIUS/PhH8b71YogZznq3Y6iE8fDTAuWyZ7vO5+8bCsHOSJLOuLzDIdo+ubNeFb/LS59g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZIXLHQW8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740015608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OfAZsqmDSvrBYe5gnIlvFXYr3WozDrc5RY5TF4JVOqQ=;
	b=ZIXLHQW8r5bdZNYBOIP2OVtMxXCSNldCvU55gTDES4t9IteKjKjSZTyw21a6bd4FSuESGp
	UEFGwnB4/A52q8bb4u+hGv+/p6WfmId2eSmotYnrmPqYPqoGKeQfJV33jszPHaC03J49jU
	F7mBSbY5FS29P+khbg0d2WMhXsEMbKA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-M9i081XjPYukt_KuB8Gymw-1; Wed, 19 Feb 2025 20:40:06 -0500
X-MC-Unique: M9i081XjPYukt_KuB8Gymw-1
X-Mimecast-MFC-AGG-ID: M9i081XjPYukt_KuB8Gymw_1740015606
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3f411884e5bso147199b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:40:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740015605; x=1740620405;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfAZsqmDSvrBYe5gnIlvFXYr3WozDrc5RY5TF4JVOqQ=;
        b=dB7+qruhyXfc8txTxxMxCwJ+QFOS15l5WgBhm+gYyMXRcDZzVBirMQkeHvTtSlXbJk
         heKuZ4fONnrKpT+ThyGcUdTmx4Leb1DFPLbuHGmjKVLS9pD4itUiKsLrpEIwMcP0nYvk
         yNQIN/YxmeIW2p0cTQSLSPuV2k21PJW132AbUcvlr9U8pIIPhAvd8/J2oqUcxHRo2Z2C
         UkNU8gMwAx8Y4jashsyVKfR/mFtCs9h/vvbqN41nSpA4qlp/jQsr1NNvrv2b6ZbJdsMX
         x4s0mTw1L50sWL78AKZiFHsJ4EyfniTzeF0Q2SSj8BvbDf8ajgFdxug12qcLArknkEo3
         wrqA==
X-Forwarded-Encrypted: i=1; AJvYcCUowoHeSBkes5F3ldzmX8VY3OfRuRPw/BUU5hDeMq6j4A151kmbYCmnpmkY3Ih4TRT/CcsIJT4NMHXCauk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwp2lbulMm2XY9X49kgqrOJc0Up1Y7eluw5xGhvUxsoUtqHiin
	ekfaLCm4Y/cv/iA0PPZadhz9Oxk2W20NqgbZtat8Y9Yuys07HUwzNFIVCVWdvhlsYvmDwBwLeKL
	x54GEcmmdirjAqsowssN7lQhxqsbDnwySbIDfGX74MYu8e2PwF3J48c9TgqhdWRCUBvHCtCjW
X-Gm-Gg: ASbGncus4++zfh+h0/JYpUF4h3xiO9oQpj02WGSDNsdQ3uXUtNG659XYAS6IV9q9KYG
	MO8GyCLcLfky2fVuPRkQ0JobfjnmqtGj/h1Ho3vpHPeEZ/w7WJFsw/asRSN7p4BtjiA/VeBqAIm
	SPwmPIBJJxLLN+8BlSpd7zh6+dutArjwo3BfsDn3JOWbJih5YNEtMP8VjF2/Sh/eh/dh6tqcgot
	F4n9K+J2gk8ZwXGzxuILPR7jF9D72dInn6FuzhTYYNWm+wqTOAwB0J8rgBhAnzq5GdeB9BHB/44
	VIFsFfQKLKXiua7R6UwNZbgHO2z8ook23YOGBfYi+LtkF+yR
X-Received: by 2002:a05:6808:2209:b0:3f3:dedb:844e with SMTP id 5614622812f47-3f3eb0b95d7mr14063885b6e.18.1740015605466;
        Wed, 19 Feb 2025 17:40:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2TuolmhmxvwffH53GHrek0Xj75Dln9YH85IUJvu8rKxqcfluF7/J0tZ8qjlhAUA9ObK2A/w==
X-Received: by 2002:a05:6808:2209:b0:3f3:dedb:844e with SMTP id 5614622812f47-3f3eb0b95d7mr14063863b6e.18.1740015604955;
        Wed, 19 Feb 2025 17:40:04 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f3ffedc858sm1921820b6e.4.2025.02.19.17.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 17:40:04 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <141d77e3-19e0-4f1b-9049-13dca0d5f339@redhat.com>
Date: Wed, 19 Feb 2025 20:40:02 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hung_task: Show the blocker task if the task is hung
 on mutex
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Waiman Long <llong@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Boqun Feng
 <boqun.feng@gmail.com>, Joel Granados <joel.granados@kernel.org>,
 Anna Schumaker <anna.schumaker@oracle.com>, Lance Yang
 <ioworker0@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Yongliang Gao <leonylgao@tencent.com>, Tomasz Figa <tfiga@chromium.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
 <173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
 <20250219112308.5d905680@gandalf.local.home>
 <0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
 <20250219152435.35077ac3@gandalf.local.home>
 <20250220080908.fc1494f0f7c611b48fbe0f8b@kernel.org>
Content-Language: en-US
In-Reply-To: <20250220080908.fc1494f0f7c611b48fbe0f8b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 6:09 PM, Masami Hiramatsu (Google) wrote:
> On Wed, 19 Feb 2025 15:24:35 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> On Wed, 19 Feb 2025 15:18:57 -0500
>> Waiman Long <llong@redhat.com> wrote:
>>
>>> It is tricky to access the mutex_waiter structure which is allocated
>>> from stack. So another way to work around this issue is to add a new
>>> blocked_on_mutex field in task_struct to directly point to relevant
>>> mutex. Yes, that increase the size of task_struct by 8 bytes, but it is
>>> a pretty large structure anyway. Using READ_ONCE/WRITE_ONCE() to access
>> And it's been on my TODO list for some time to try to make that structure
>> smaller again :-/
>>
>>> this field, we don't need to take lock, though taking the wait_lock may
>>> still be needed to examine other information inside the mutex.
>> But perhaps if we add a new config option for this feature, we could just
>> add the lock that a task is blocked on before it goes to sleep and
>> reference that instead. That would be easier than trying to play games
>> getting the lock owner from the blocked_on field.
> So something like this?
>
> unsigned int	block_flags;
> union {
> 	struct mutex	*mutex;
> 	struct rwsem	+rwsem;
> 	struct rtmutex	*rtmutex;
> } blocked_on;
>
> enum {
> 	BLOCKED_ON_MUTEX;
> 	BLOCKED_ON_RWSEM;
> 	BLOCKED_ON_RTMUTEX;
> 	BLOCKED_ON_IO;
> } block_reason;

You should add one enum, e.g. BLOCKED_NONE, to represent the normal 
state of not being blocked.

Cheers,
Longman

> For the safety, we may anyway lock the task anyway, but that is the
> same as stacktrace.
>
> Thank you,
>
>> -- Steve
>


