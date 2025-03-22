Return-Path: <linux-kernel+bounces-572678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF9EA6CCFF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 23:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 778807A4528
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 22:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B9B1E0E13;
	Sat, 22 Mar 2025 22:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYNlm6j5"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351472F5A
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742683071; cv=none; b=ewqTI3ZeA7AlSP+J57BzkdVtinjc5q7rGG/msJ32tv5NF5PjqchJ8aJ17Tpl98gWiRTzfwbvHSDheg4CThiJhXjXLzaRyx5ZovcbFbdm13ZVs0PtcedVjSuoGluqifgRIv/YgHH/9cpkAkxe0zd8EstKRNjWMSpr3HCzbUGbKro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742683071; c=relaxed/simple;
	bh=TaV/5KmqmPs1iCZzOoE+QZX5YDS9/5bSENRjdkC1WeE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/PRyG+pWq9jsNIjOh5WbxJfr71Dmx+uYgTMbU5HHgP19I0FbArr8/wd9BVjGnv0ppM5Go4zT/9s83ZV0Pg1QipEGlv2dA0TlYJs3kK9dz8SHBKPiTUlGtU4F/yyIOOb8/L/bj8ACZ1YX4kRHgk7n+rnXSlf0Zc98EMJOMYbiQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYNlm6j5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43690d4605dso20996555e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 15:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742683068; x=1743287868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BR2Wt+NtBkxsY55Q/Z1OEPHz+u0IiLUMBm1qt82lBE=;
        b=UYNlm6j5ofYyH1xKxGxoICfDa/YqiUZLeduKK928A+5F0o5E8eQRsis3QC+m4+YkID
         zS/9/t0p9ndBZ8fECHrN337pht7xehkLNi04KFo/MGIkxfriLIR1CY+fMNJGWARPF9WB
         QWmkDhVfWZTKfQUgmpYn7hxJmeSsHKW1KMxhm9nsC+tVxHmDPnDo1hW4fqqprHoYcTJE
         OeC7oPxTebk84mfOlII9EH2PVWsKGxZXkbmUGdTiN8gmFuHkTH6KWAxF2Yug5992Fuwt
         YRy+t3F9gGoC/ytwSqsL+MggTgFGlS3EXyeuXRTt1/0V4mlPVQJcug2qYdbF7roB+gwX
         s2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742683068; x=1743287868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BR2Wt+NtBkxsY55Q/Z1OEPHz+u0IiLUMBm1qt82lBE=;
        b=arBZkXGlRZV7rVRE9eUspdLJA22EP3P7uC808+kg3O+0i/b0CpZb5gzO5AHbCFNeXU
         RFrCZmkprrybDNWPqnXM6QazzNe8K0Qlzte7ledI5m6KyGUSKK9rig2fAyw8R+CV52yo
         hGfwVOBXdxPgjz2UMNmiNQ+ZbckUhRNQPjcE8Ufkh1a78VLzeDWRm85czunwS7OjV4C0
         1K5T/Gth5CXaN3jfyDSnrRvgtttKG7s+mf6+tB0VPSkmpEEkHMjZ+SySTTRdzIe8tluN
         UqCVCSpmm192+r7SRRZE2eaOCugSn+DQ/aLrybHxz8jwavrpySAlDVFh6GQFbjoSz7B8
         tbMg==
X-Gm-Message-State: AOJu0Yx3s3lP45rMhQyBNHJBmdGU33FP6rY+tYshUgClx0jEPoR9G/8d
	AniGQuWKP2mM0rqTASyKCFYUM57NinMwDES4o/6c0paBRRmecNyX
X-Gm-Gg: ASbGncvSCD4bpJzo6DdSVoJyxfEiuYvUddBrhs4paijZ3UOWlrjyBN9pPVDimOKczGg
	yeowOXlmUnlPeowRcx3iVhDKo/yuOOHLyHFN+GPI+vdfDCzKxDIadKZWfLBEuP0XUVVbWXIVkYL
	n5pxmQZMrPwRGj6jwp2peCfZYeVyc79mdcMKe95AUtUEwWKTXM9cHTV5n3RhKSQf2tcePrL/B5H
	kfCxfB95+UCDDCMRMGInnW2sFZkXAlMzTeiHN6gp1fiEYqNGZnc5dJYsofBncn91FqFoOp1nlSs
	pezjMrB0c41jqkSjalSItisEjlwkiGSUQopzsRP54vSTaiR8H0foqmV0SoDdscV8y8rl0x7JDmQ
	OHvbY6TA=
X-Google-Smtp-Source: AGHT+IFp/s3Uff2G9r0pv6lq8ceKZZqOFKHKMXqTdzZaNamIqP3LNpiJTDQYO3phlN/uJxlpf10CJA==
X-Received: by 2002:a05:600c:1e18:b0:43c:eea9:f45d with SMTP id 5b1f17b1804b1-43d509f64b8mr84822525e9.18.1742683067404;
        Sat, 22 Mar 2025 15:37:47 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdbcf8fsm68480415e9.37.2025.03.22.15.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 15:37:46 -0700 (PDT)
Date: Sat, 22 Mar 2025 22:37:44 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, David
 Howells <dhowells@redhat.com>, Matthew Wilcox <willy@infradead.org>, Andrew
 Morton <akpm@linux-foundation.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH next 0/3] iov: Optimise user copies
Message-ID: <20250322223744.353bf74f@pumpkin>
In-Reply-To: <CAHk-=whs5oVkHMrNP=xkJP4Z4fObn=6Mz3fYp4wWMNQWtyjo9w@mail.gmail.com>
References: <20250321224557.3847-1-david.laight.linux@gmail.com>
	<CAHk-=whs5oVkHMrNP=xkJP4Z4fObn=6Mz3fYp4wWMNQWtyjo9w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Mar 2025 16:35:52 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 21 Mar 2025 at 15:46, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > The speculation barrier in access_ok() is expensive.
> >
> > The first patch removes the initial checks when reading the iovec[].
> > The checks are repeated before the actual copy.
> >
> > The second patch uses 'user address masking' if supported.
> >
> > The third removes a lot of code for single entry iovec[].  
> 
> Ack, except I'd really like to see numbers for things that claim to
> remove expensive stuff.

Except that some of the 'expensive stuff' is missing!

copy_from_user_iter() does:
	if (access_ok())
		raw_copy_from_user();
So it is missing the barrier_nospec().
The error handling is also different from _inline_copy_from_user().
(It doesn't zero-fill after a partial read.)

The observant will also notice that it is missing the massive
performance hit (and code bloat) of check_copy_size() (usercopy hardening).

Talking of performance I've dug out my clock cycle measuring code
(still full of different ipcsum functions).
I'm sure I got 12 bytes/clock on my i7-7 for the loop in the current kernel,
but it is only giving 10 today (possibly I don't have the latest version).
OTOH my new zen5 runs the adxo/adxc loop at 16 bytes/clock (i7-7 manages 12).
I'm going to try to find time for some memcpy() experiments.

	David

> 
> But yeah, the patches look sane.
> 
>           Linus


