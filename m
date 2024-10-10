Return-Path: <linux-kernel+bounces-358232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C13D997BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9356EB238F0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F4619CD13;
	Thu, 10 Oct 2024 04:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nnLSv2MN"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8976220334
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728534146; cv=none; b=sfsvuOCCHabf54lbuvJTDMFiwdeBCnXt67lVMprFIYdUm4vw2h7MPi1JrFAqLCa0mc9K/qKQhOwQdGqhYVt7k8RYqoa32Gk+Vhy4uFjU+2FQIbQKAy6c4LXd0RkGlyjQe8eC/Hao3O7pH0pdWRfKSWwoiAPXjhhZjqITSO3q4KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728534146; c=relaxed/simple;
	bh=XE08S0gU6O1ey+7cGRPfMzNdqFMlwKFDi5LYuTNpmMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNaEkio/a2+gTuOop5pdH7lI4UwSx87ujrLCJugGDEWAdD5ODL0Fb8IvU2OI78zOXaxjZv2ZOg9y0G03t0LgFJdzai4tAkxCUEkjEnNRx1cnk7paIfePqAnT3HRqcimy/dRm8Uqq5CS8eOufMRzCIDWjxB/d4GzQKKDs+OvzHvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nnLSv2MN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c5fdd0fe3so131205ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 21:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728534144; x=1729138944; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dYnzX/ygicXmrXwrwnSe5Ie0YJrwJceBZYllZsEBCy0=;
        b=nnLSv2MNgsOLK51+75L/OKkYxg2KVT4kLC2Axjg+QXfgp8i/lUVAtg+dVBsdMnv1vS
         4SfpRU5eyaSAylXVbGJp//MrKOErWudIo374QowrE1vpZGfppDCrWk6nG+lUICzctVgk
         XuNjb1/TXBg29zmxoQ85c2dsGDyvEZAHSFXzeqN7rNVQfPVXkR7tBPd7scLs9V2mKP8V
         IJce+nuz3JNHR57rWOwCD/BS8wbnrBPNSUD9uZuLO/xQNZlkqwxV/kKYuZSI6jq9ez9H
         24PztxSABBEPb8xfcZ3g1Qysu+qLVqJY6lonR/HHfesd9iJkkf6OyITmLAzK9+9uDTGo
         iNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728534144; x=1729138944;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dYnzX/ygicXmrXwrwnSe5Ie0YJrwJceBZYllZsEBCy0=;
        b=OsQPFsq+NifsyCDw6qfQaf+n9BrNcSkiufPQenhLQ9FBm20C4Tl1Eze4npT3lhDCyi
         9QW+nXlQhZY3JzzE7m3pmiZclw1/SmQL0LUDiyEx0jIQP9W30KLaQlIUUKj5Un/9Mh+b
         HAr8AO0+1/hAFKkJjIblOQdFDuxAvSHdtDpBh8w+HmcWHW6cTRalvsZfWAB6a8AGDTTa
         pMaDVrhSjmuwUtsr8ijqN988wib8gQuusC8ko935V72E64OFmBoBY8c/cwZMP27saEfA
         4QLhVnQAzq/W1l7XfERgZLjj//qWPc5pkUkelXPF2EjEYf+DGIUKk+zALVyywDC6nOmT
         FTOg==
X-Forwarded-Encrypted: i=1; AJvYcCX3ceEHQVomJhgmDSH4OiQimxCaBIREI9b04Eze/BsMcinH0O4i/p63kKhddxXd1kbnDYrE5dwkArHDgPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIIkifc9hh1W8DJQmlpODeGtAkiWlMYbcBoXaU/fUUbIJmusFe
	23uoQQMgbOxUbCOF/Gh3gEmmxKwjVN8gGKqooOqhv4Oy/IGM+XHVwlbKLxyaCQ==
X-Google-Smtp-Source: AGHT+IGZ4DY58vKyFJS6CFq59viTnsP7rlKWDcKfosYkedh5t2qjtWmvGzctfWvTcfqOoJnXL+bkLA==
X-Received: by 2002:a17:903:2287:b0:20c:568f:37c7 with SMTP id d9443c01a7336-20c8720f2bemr1223375ad.17.1728534143716;
        Wed, 09 Oct 2024 21:22:23 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9f6fc1sm220037b3a.79.2024.10.09.21.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 21:22:23 -0700 (PDT)
Date: Thu, 10 Oct 2024 04:22:19 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Shu Han <ebpqwerty472123@gmail.com>
Cc: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	surenb@google.com, linux-kernel@vger.kernel.org,
	aliceryhl@google.com
Subject: Re: [PATCH] binder: use augmented rb-tree for faster descriptor
 lookup
Message-ID: <ZwdWe_I2p3zD-v1O@google.com>
References: <20240917030203.286-1-ebpqwerty472123@gmail.com>
 <ZuyQ8ECy0ypuOStg@google.com>
 <CAHQche-rZODDsxbf6b3uagLfM52YtcoUuaeW0NxXcPTFFNcsZA@mail.gmail.com>
 <ZwWdBIu6j0lL2rbt@google.com>
 <CAHQche8v5CTW0L2cJGCDWOJ---KRv9wxWAk=eUaK1+k9UTcpHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHQche8v5CTW0L2cJGCDWOJ---KRv9wxWAk=eUaK1+k9UTcpHA@mail.gmail.com>

On Wed, Oct 09, 2024 at 11:08:42PM +0800, Shu Han wrote:
> On Wed, Oct 9, 2024 at 4:58 AM Carlos Llamas <cmllamas@google.com> wrote:
> 
> Thank you for your patient reply.
> 
> > I honestly don't remember. It might have been that we required to expand
> > the 'struct binder_ref' size. This issue starts to be a problem when we
> > have thousands of references e.g. 30,000. Adding 4 bytes to each one of
> > them might not be worth it. But let me check...
> 
> I didn't consider memory overhead before...
> That's indeed an important point.

Yeah, I actually started with a solution that kept a list of references
that had "gaps" behind them. This also required expanding struct
binder_ref and I eventually abandoned this idea.

> 
> Fortunately, after checking, I found that this patch does not occupy any
> additional memory for `struct binder_ref`.

This is good news. I hadn't actually checked this. I'll keep this in
mind.

> 
> In a modern 64-bit platform, the size of `struct binder_ref` is 104 bytes.
> If we add a 4-byte field into it, the size will be 112 bytes(aligned by
> long). And both of them occupy a 128-byte slab(aligned by kmalloc_index).
> So the memory cost won't be increased, if there isn't a pending change
> that needs exactly 24 bytes in `struct binder_ref`.
> 
> In Rust, a rbtree::Node costs 40 bytes, 4 of 40 are used for alignment,
> adding a 4-byte field won't change the size of the struct.
> 
> In a 32-bit platform, the number is from 60 bytes to 64 bytes, a 64-byte
> slab, exactly 4 bytes.(very close to the slab bound)
> 
> Perhaps it's caused by introducing augmented rbtree into Rust which
> requires considerable effort. But personally, I think it's not bad to just
> introduce augmented rbtree into C (Rust and C are already quite different
> here).
> 
> > Yeah, I think it would look cleaner if we do a revert of the previous
> > patches though. This way we can remove the noise and see the actual
> > changes. I'll do this locally for now, no need to send a v2 just yet.
> 
> Great point. thanks.
> 
> Best regards.

I ran a benchmark test that creates multiple references on a Pixel
device and the numbers between the augmented rbtree implementation and
the current dbitmap are pretty much the same:

augmented rbtree:
--------------------------------------------------------------------
Benchmark                          Time             CPU   Iterations
--------------------------------------------------------------------
BM_collectProxies/0/10        696251 ns       334494 ns         2363 kernel
BM_collectProxies/0/100      4047417 ns      1886942 ns          390 kernel
BM_collectProxies/0/1000    29510599 ns     14827312 ns           51 kernel
BM_collectProxies/0/5000   136774414 ns     70482303 ns            9 kernel
BM_collectProxies/0/10000  248333277 ns    125898564 ns            5 kernel
BM_collectProxies/0/20000  485156508 ns    245891699 ns            3 kernel

dbitmap:
--------------------------------------------------------------------
Benchmark                          Time             CPU   Iterations
--------------------------------------------------------------------
BM_collectProxies/0/10        646427 ns       291657 ns         1935 kernel
BM_collectProxies/0/100      4203230 ns      2005648 ns          484 kernel
BM_collectProxies/0/1000    30859725 ns     15369365 ns           42 kernel
BM_collectProxies/0/5000   147910844 ns     75179017 ns            9 kernel
BM_collectProxies/0/10000  239196875 ns    121801066 ns            5 kernel
BM_collectProxies/0/20000  481154229 ns    247742285 ns            3 kernel

You should have this test avialable as 'binderRpcBenchmark' I ran with
the following parameters if you want to play with it:
  $ binderRpcBenchmark --benchmark_filter="BM_collectProxies/0/*"

Even if the numbers are too close it seems the bump in memory might be a
problem. Particularly in 32bit as these devices are more sensitive to
increases in allocations.

Regards,
Carlos Llamas

