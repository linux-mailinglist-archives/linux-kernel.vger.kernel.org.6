Return-Path: <linux-kernel+bounces-522627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FE4A3CC99
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781C516FF76
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427DB25A652;
	Wed, 19 Feb 2025 22:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZ8Oj+p6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF90E2580DB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 22:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005061; cv=none; b=fXtX08Y1g1n842QATN4N6qdbPMhDdwwnq7QiapFx4hD2deykUzHCVerPoOotFDM74TPDRUr54LAU5gOL70xdCDYIR3qL566ByFj8e7zcdVsZv/geDOikBbbgwrYNE6RJw+1nuG5KZlyvTYC/sKBmcG11ukYH+LsOW0X4X3xcEl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005061; c=relaxed/simple;
	bh=oywJUiIAln9EV/Tx9+5k0m/GHgxc0J/w1HMzUhIMQlc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ENIhFnTCAlkX7rx2vVGhf+o7Iw+1EmZSNIvwkZfB7vY/Hz/+Ov0RU6SDE4zv74I7BAJaqdBFH1/Z0MppGFzFh+TDKZ6zTm68MiDROrSK41Is3MgSTXSEDhlTpQB3in2VW5afgR2OmRZrnqsno990FbUP5QF/Hez+fHvDC/XkD5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PZ8Oj+p6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740005058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DMvitgvDIjDepeC3+06xX2GwpCGnJs2yXLfJOe51Cy8=;
	b=PZ8Oj+p6pr1lv04MYNYw8gpr4pjzGPuYrbUcV2+nN/0WDRde15edynYBB7bZ6kbPirgyHL
	I8z5ae3QLZ58ycpeY6Ic67Ka2Db5UUmOz3isyK4cLxuL7ihG7YkSli/4FrcNcT4Axc2eiu
	hnTaXe2ad1++IRsqNtM/+sfxVTTnuuE=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-GMgGkhjNP7WBrHDTH8CsWA-1; Wed, 19 Feb 2025 17:44:14 -0500
X-MC-Unique: GMgGkhjNP7WBrHDTH8CsWA-1
X-Mimecast-MFC-AGG-ID: GMgGkhjNP7WBrHDTH8CsWA_1740005054
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-727294aa679so430171a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:44:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740005053; x=1740609853;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMvitgvDIjDepeC3+06xX2GwpCGnJs2yXLfJOe51Cy8=;
        b=AI+n6C2FOMCqEX15MqpwRZ18/f3cuzHxBZZxwtXfJMw+IC/zKcunq/bIg2QR2BjIkS
         OAgtrja1L5dzNnPMxrhNBwms020i5vK93ahn8+0DYrZrnsckcOxTt39j418oAqeKhXOz
         DtI7XMQ7PDzQUgnyztXYr/0Jzkfdd1d+j79xxY3KW0r/Eb2UHT7QjgZAo3vVxVCeAD60
         fbf/yxRanI6ZLe+m5DKiaRWox48ShXBtuKi854MNbWYB3NAOHsm9p5ixCcoSTxZpgA+X
         I1DNFxRwYj0vahfXSC/aeRw4yGCjaUAxVRQjTk7aVMNGuQd3noqtny//rGxCGtsKoqpz
         186Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvrIzq4S8jiBGczm7PrLjoHwUm524oJrot0lu6fTzp1mC4lbnwZUZzRxAtIv8U9Hnm/spOogCenDP44Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Nj0XifcspJxUuDs/Icn2fR2I25Yc6VRlxLNpXVgYgxqCoLAv
	T3JTwCtz4D8nvMBSNy5EXqRiLRRthlJ3I+e0hluQWbn5pxj30xOBsEV/ffRLoykZBXOJ5a9sEeI
	3D5eKj0ElSfnE0dWraloc1LYGw6EXgL8r0KI/ZQopr0QPLC1lm6mTj4ncf1RZKw==
X-Gm-Gg: ASbGncvVECprZLihzwGV5j57egKP4gpmgUWmQX/Nu4IamJyZzNLNUXJjfsJiz1vw8Ri
	HyqVMvMZShU9b8CJ3JLnEjrztG9Zfth4Dipkt/eWDOT+8DR3zfTA6+mAKqDiKA63w3rMwYQf1U2
	Qug1PeC8htKg7ELSPJ2RhgjSG02dvRlrnukwkWyyw69rDWt3OJ8UIpuOVubIa7C0C/BTEFkZR+w
	wFepQXS1o8Ro6DDab2wTD0cXxLHmStcvkiMaDNG4vKgzk+VIQfLrF98YPT3yGNkJ/t2LDZ+uqoN
	PciJSjYumWPb0AkrPIR5Ed+YwMrDSPMbP2tv4IXBJ3+xHGcv
X-Received: by 2002:a05:6830:6a97:b0:727:2fa8:c0e3 with SMTP id 46e09a7af769-7272fa8c31emr6915951a34.11.1740005053728;
        Wed, 19 Feb 2025 14:44:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6YLEg0w5nPagcW0zAe4o5WqKQSTn3wQrAQr5zobu9Z1tzgyRbtNSptj5SQOAnkE26MH94hQ==
X-Received: by 2002:a05:6830:6a97:b0:727:2fa8:c0e3 with SMTP id 46e09a7af769-7272fa8c31emr6915927a34.11.1740005053392;
        Wed, 19 Feb 2025 14:44:13 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7272ad5fbb9sm1783536a34.13.2025.02.19.14.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 14:44:12 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <db4ee5e9-56bb-408c-85e7-f93e2c3226dc@redhat.com>
Date: Wed, 19 Feb 2025 17:44:11 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hung_task: Show the blocker task if the task is hung
 on mutex
To: Steven Rostedt <rostedt@goodmis.org>, Waiman Long <llong@redhat.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, Joel Granados <joel.granados@kernel.org>,
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
Content-Language: en-US
In-Reply-To: <20250219152435.35077ac3@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/19/25 3:24 PM, Steven Rostedt wrote:
> On Wed, 19 Feb 2025 15:18:57 -0500
> Waiman Long <llong@redhat.com> wrote:
>
>> It is tricky to access the mutex_waiter structure which is allocated
>> from stack. So another way to work around this issue is to add a new
>> blocked_on_mutex field in task_struct to directly point to relevant
>> mutex. Yes, that increase the size of task_struct by 8 bytes, but it is
>> a pretty large structure anyway. Using READ_ONCE/WRITE_ONCE() to access
> And it's been on my TODO list for some time to try to make that structure
> smaller again :-/
>
>> this field, we don't need to take lock, though taking the wait_lock may
>> still be needed to examine other information inside the mutex.
> But perhaps if we add a new config option for this feature, we could just
> add the lock that a task is blocked on before it goes to sleep and
> reference that instead. That would be easier than trying to play games
> getting the lock owner from the blocked_on field.

Yes, it could be a new config option. This will be a useful feature that 
I believe most distros will turn it on. Or we may just include that in 
the core code without any option.

BTW, this field can also be shared by other sleeping locks like rwsem 
and rt_mutex as a task can only be blocked on one of them. We do need 
another type field to identify the type of the blocked lock.

Cheers,
Longman


