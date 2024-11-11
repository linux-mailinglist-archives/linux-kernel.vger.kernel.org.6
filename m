Return-Path: <linux-kernel+bounces-404454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E88139C43E4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786461F22419
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEE61AAE1B;
	Mon, 11 Nov 2024 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GPfhgvbt"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D241A7AF5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346800; cv=none; b=U0/71ly/iLrDp2Juln10rzN5bq1g/XdNldrPKCkSQTu893SkmFXe8TjClxdyeOQg6xxC/bsUUY3/vkTb+zOvQt8lVsjxQnaYW7eFxJazQpFYnxqQBYZzVw/uL/tA9mV+jX5JXwZMr7rOw6paz6lUzJ33lDj93esp4sB2H/jyDGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346800; c=relaxed/simple;
	bh=tjcL0LbBa9Ai1V/5sOI3hTL3tqmtPymVsDfumEV68Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AcHzEiXgxo0KfKDXuHf1kPHw3ueeXJjqBjrXHIduE+t7ELTlH4acOgSs4mkxNZizNXxRpH2tbWnPcTlnJ1AyvMyMITQHMReoGxmtTOubigee3buv/HT87+vpRbLKxBVs9ZEwrOvPHEAQoqy1bwfeSJEJEABU0fl7VlpC1/Si4J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GPfhgvbt; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-718065d6364so2448113a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731346797; x=1731951597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zornXYrQK1q5jDp72wLGbGUMhA7z4OfmXLBGicUzQUM=;
        b=GPfhgvbtBc+B5UsVQSM7C/73J4V0OxTJrWz6rHm+iefdemKS5ASpssooTO+W+AtVwU
         xlFMOs0BBVDkdUtib1+yxbj0f0qjOtNdX+Z3XXffgsaBi/xzPoTDRvV7UpZHRsQoi14c
         BPteC9aSdqpfVcujpj6SEn6+Edcw5oGE2tKw9dTzRebu+qk4vZvABQCe0v16D9GcRhYn
         fFWizib2VX+o7bhF9y2qfBrEO2gvSH5CXBjUwj/HZSmxdTbuMwvx4Bsdk8lx093MZQsM
         X+EuPnMapk4SFNRsH+EJPPSSa2NQjnvgOgLptyYjYeqJOwWn1tCrHHEkxSV4e/3zvGOz
         LDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731346797; x=1731951597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zornXYrQK1q5jDp72wLGbGUMhA7z4OfmXLBGicUzQUM=;
        b=GRO8LTm3rZYclbV84AURuTdnoSMBLRWZjDabgknkCfdcLduZ8J3SX0BtD89slkwv3j
         SAAa1kHgCi096ZO+rVtWuFLt8GbMrnMAgSboNpTIBVa2TIAwKk/KsYFh6v2LWY3tDs/s
         b1YWjVJ1tYBQCQ9TwSgKxw7AqL4jL4CsBdI5caujwlVUbiILFRl+BTdkd6WS2xNUmctd
         bQ/zd4NhrdlRO6KMa18VR4am+AaJl5K9C670HvMVUXYYK9tDG1uoxHainp3wHsAX8ETZ
         mBfdfEZfY/ysKnbXlEs3LmvElivjmVINjgs9zSGYYUON3f5B/xM5AsApdlDtpvxPB2jP
         bSUg==
X-Forwarded-Encrypted: i=1; AJvYcCVhI8jOkUgrHC0gUfK2NFENpHbRm2R4ZO/DPZ/MvDm2KWUFGRtEDyXuYaPXk1WDq7Yg0siuus80dnS19hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmocsiRF22YCIgw+al6bInwMbI4xNCsOCk5hOTdFNU+mRDvA4Z
	9+8H8CmcHwFHG2MFG9duldYmb6XycXaGyizDp7gfR9k6dtj7n2NSUuAV02HePjw=
X-Google-Smtp-Source: AGHT+IG4NBeRv1XZA/CiIhXb6FBtUBNiBbImRao8a/5WPPZ6TVlAlQmjjSke+YET1UaXJNr4aEjOnQ==
X-Received: by 2002:a9d:7856:0:b0:718:c2e:a186 with SMTP id 46e09a7af769-71a1c2b11fdmr9515988a34.26.1731346797472;
        Mon, 11 Nov 2024 09:39:57 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a1092c14fsm2308234a34.72.2024.11.11.09.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 09:39:56 -0800 (PST)
Message-ID: <3c904d74-c685-4f8a-bc1d-edc24da59fa5@kernel.dk>
Date: Mon, 11 Nov 2024 10:39:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v2 0/15] Uncached buffered IO
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org
References: <20241110152906.1747545-1-axboe@kernel.dk>
 <ZzI97bky3Rwzw18C@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzI97bky3Rwzw18C@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 10:25 AM, Matthew Wilcox wrote:
> On Sun, Nov 10, 2024 at 08:27:52AM -0700, Jens Axboe wrote:
>> 5 years ago I posted patches adding support for RWF_UNCACHED, as a way
>> to do buffered IO that isn't page cache persistent. The approach back
>> then was to have private pages for IO, and then get rid of them once IO
>> was done. But that then runs into all the issues that O_DIRECT has, in
>> terms of synchronizing with the page cache.
> 
> Today's a holiday, and I suspect you're going to do a v3 before I have
> a chance to do a proper review of this version of the series.

Probably, since I've done some fixes since v2 :-). So you can wait for
v3, I'll post it later today anyway.

> I think "uncached" isn't quite the right word.  Perhaps 'RWF_STREAMING'
> so that userspace is indicating that this is a streaming I/O and the
> kernel gets to choose what to do with that information.

Yeah not sure, it's the one I used back in the day, and I still haven't
found a more descriptive word for it. That doesn't mean one doesn't
exist, certainly taking suggestions. I don't think STREAMING is the
right one however, you could most certainly be doing random uncached IO.

> Also, do we want to fail I/Os to filesystems which don't support
> it?  I suppose really sophisticated userspace might fall back to
> madvise(DONTNEED), but isn't most userspace going to just clear the flag
> and retry the I/O?

Also something that's a bit undecided, you can make arguments for both
ways. For just ignoring the flag if not support, the argument would be
that the application just wants to do IO, uncached if available. For the
other argument, maybe you have an application that wants to fallback to
O_DIRECT if uncached isn't available. That application certainly wants
to know if it works or not.

Which is why I defaulted to return -EOPNOTSUPP if it's not available.
An applicaton may probe this upfront if it so desires, and just not set
the flag for IO. That'd keep it out of the hot path.

Seems to me that returning whether it's supported or not is the path of
least surprises for applications, which is why I went that way.

> Um.  Now I've looked, we also have posix_fadvise(POSIX_FADV_NOREUSE),
> which is currently a noop.  But would we be better off honouring
> POSIX_FADV_NOREUSE than introducing RWF_UNCACHED?  I'll think about this
> some more while I'm offline.

That would certainly work too, for synchronous IO. But per-file hints
are a bad idea for async IO, for obvious reasons. We really want per-IO
hints for that, we have a long history of messing that up. That doesn't
mean that FMODE_NOREUSE couldn't just set RWF_UNCACHED, if it's set.
That'd be trivial.

Then the next question is if setting POSIX_FADV_NOREUSE should fail of
file->f_op->fop_flags & FOP_UNCACHED isn't true. Probably not, since
it'd potentially break applications. So probably best to just set
f_iocb_flags IFF FOP_UNCACHED is true for that file.

And the bigger question is why on earth do we have this thing in the
kernel that doesn't do anything... But yeah, now we could make it do
something.

-- 
Jens Axboe

