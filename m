Return-Path: <linux-kernel+bounces-532056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA15A447FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9A51889FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF51819597F;
	Tue, 25 Feb 2025 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embecosm.com header.i=@embecosm.com header.b="hgkhFd6O"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E0158520
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504269; cv=none; b=lPvV8Lpn48MoijvUYiHrUE/lmgq1z0YYnJJEVMxRBJ3QG5hrTMPxoQ2YPMXpK5Ph1Lp17n05Uw9y/NF/8V65OsucU+B/71p8uMmwEbTSMrQvQ7e1hP1F4o9TgTgUiJr5rvD8057XihSBdn5nAFTVXsOwavxz15o/qjyQPZazXU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504269; c=relaxed/simple;
	bh=95Dcrv2uDHGC0Dp8iVXfb4heiQgHSuPG8+H5erWocUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCXGi0UZJxtox2erBFPxeezvG+hT5g9G7n/P+tIN4rLpZ0Ovm5P7LjdYbCmudHUwqbz+TsM0NIAwtgRlvM+SsKOUZgPIKNQ4DeDeSVrWgFNngD5FiGVUDpZIs38IUplgLAK2K/XTq21NjqL2M2kVGuc5iGydAIW5cAA4l4oIuY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embecosm.com; spf=pass smtp.mailfrom=embecosm.com; dkim=pass (2048-bit key) header.d=embecosm.com header.i=@embecosm.com header.b=hgkhFd6O; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embecosm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embecosm.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e0b70fb1daso7717364a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embecosm.com; s=google; t=1740504264; x=1741109064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y6zk364J/R5KD/YYx6jHat209JOl1kXKWaOdP8jqqrU=;
        b=hgkhFd6OyQD87FwCjbiWamzHEe2SmlHP3LugXWmrZs409aTnTp6H3ygczZkvOP5gV2
         UTnnV+FPSjm5uepghCDDRXH+8Cp7NbK6era0bp0XL0mTW3k7wjXzFo5nA5tms2FCQ/uL
         naPp1hVm/Wrn6DMfF5WyHa1/ZQAN7WPAy/ZcDDHTgxO82ID6U7/z2q+QD2ZONZDLyNIt
         ZjEQpMMrFtcZqd7CxO/FPKWCPKT2+AczBtMSCm/Rgl8lML/Hom+vVuxjXvEKS/tdhRoe
         y/el8M8EyrYmWtYe+XsJoAyqeKlrt9ztvx6yKmMWwJRY/bk98Jp0Hw+iTbjEeFr1aDv7
         rZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740504264; x=1741109064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6zk364J/R5KD/YYx6jHat209JOl1kXKWaOdP8jqqrU=;
        b=pUnkfZ1uxVrKfCl5fbyWgEEQeTP1zBCzzD+Ht9JlLbIzsSX/q9BAcDT4mETz4VKJ7q
         CBCBFxa/wgzl3pPKcM9nwftJ9zcPpS47hq2+Nt6IzAgdNBAF65jnS+XfCbsbto8HNve7
         szqtnvTyvKJvNiGeyvDuRnPqumoNgtrrGe+rG2+h/XGajarLqnqzSDpDqyrgy7BWYe2N
         miMrbZJLDRTfrLPYcwad0iGA7z0z+wh81QPfb9OxtcuyYau+tgDo6YcYHpVMmuVstT3O
         qtu+JNMqO/YsPJC/czryDZCCYoap5/IJQBoPKezMsfkMy2BmoLN8RVnPnNrvanTpFtJn
         LwNw==
X-Forwarded-Encrypted: i=1; AJvYcCWyAn14GbwjbziUuQbXiZUwfplWv4l4PxJy6ldaGEui0ggjBeWGn4ml1ZQwWijAQkBRMbiObYA84GzrqVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwcFpliVCXXi6PAqHb4DDExWkIH2LRaevqYreLZ17arouCmJNE
	mwWBq8dNohJCsl3tULCuiijCXkf3QbLXbUt5p5NGGCRBiIZp2kJtv+dcov8XsA==
X-Gm-Gg: ASbGnctsqR+PRQF4f1Pe/9Lmgi/2G9Y+vFh+nzDSfr1fEhXOORFAZj8+4IDDffzY2SA
	GUsgFrRRkgOakt+tiCl+UIoli5KMK3Z4EQZEWlZHBkxLdRGQUAfIR24SLVTV7PpuUDc7PbctnFn
	g9NU5jm3wm37t3mnCreXzAhiv3aRCx/QUfRy4mkTOPWpcJNNwt8LU3TXSP6kkdt+zggJAviJpN/
	3XHpNT7z+mc0t06WbSwLWfaJGNzKj5GIMwFBu51J1c7dRAPGXpFuVHtPjLjuggeFgyacXmAo1GF
	vfoAPAIqPsof+ywj3WWO3QE+mIRPEfCFpHBj4L2SB2FRosI+JJC53LRaNVURKo+tmUjC38MJS0g
	=
X-Google-Smtp-Source: AGHT+IFYgTuccyfOVhiD9IFpsBxuvShI076f0NTIveSZFdhJ2xPS/YHIZsCzb0q4s7AgcB0dNm1cxQ==
X-Received: by 2002:a05:6402:3493:b0:5d0:e563:4475 with SMTP id 4fb4d7f45d1cf-5e4a0e16844mr411687a12.29.1740504263983;
        Tue, 25 Feb 2025 09:24:23 -0800 (PST)
Received: from ?IPV6:2a04:cec2:9:b8f7:ed4c:446e:5532:d388? ([2a04:cec2:9:b8f7:ed4c:446e:5532:d388])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e460ff866asm1483748a12.52.2025.02.25.09.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 09:24:23 -0800 (PST)
Message-ID: <4c9573ba-b939-4ac7-a163-9e8bd7052fe5@embecosm.com>
Date: Tue, 25 Feb 2025 18:30:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: Ventura Jack <venturajack85@gmail.com>,
 Philip Herron <herron.philip@googlemail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Theodore Ts'o <tytso@mit.edu>, Linus Torvalds
 <torvalds@linux-foundation.org>, Kent Overstreet
 <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>, airlied@gmail.com,
 boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de,
 gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Ralf Jung <post@ralfj.de>,
 Antoni Boucher <bouanto@zoho.com>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo>
 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <20250224125805.GA5729@mit.edu>
 <CANiq72k-K3-Cbnm=0556sXAWs0kXBCB4oR67M4UtD=fq=kyp7A@mail.gmail.com>
 <CANiq72mfQk_ViHJ9Y_rU0etS8XpORvZUNMc5m2iHL=pQDiVFSg@mail.gmail.com>
 <CAEvRbeo3QujuvRxjonhzqjQbO5e1_ut0LOSQsukH1T5vx=jzuw@mail.gmail.com>
 <CAFJgqgS8u=HZ4kps=9iEcw4ra2ocLU5YL+=YNB3Vo9E+1jNnXg@mail.gmail.com>
Content-Language: en-US
From: Arthur Cohen <arthur.cohen@embecosm.com>
In-Reply-To: <CAFJgqgS8u=HZ4kps=9iEcw4ra2ocLU5YL+=YNB3Vo9E+1jNnXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi!

On 2/25/25 4:55 PM, Ventura Jack wrote:
> On Mon, Feb 24, 2025 at 9:42 AM Philip Herron
> <herron.philip@googlemail.com> wrote:
>> My 50 cents here is that gccrs is trying to follow rustc as a guide, and
>> there are a lot of assumptions in libcore about the compiler, such as lang
>> items, that we need to follow in order to compile Rust code. [Omitted]
>>
>> Thanks
>>
>> --Phil
> 
> Is this snippet from the Rust standard library an example of one
> of the assumptions about the compiler that the Rust standard library
> makes? The code explicitly assumes that LLVM is the backend of
> the compiler.
> 
> https://github.com/rust-lang/rust/blob/master/library/core/src/ffi/va_list.rs#L292-L301
> 
>          // FIXME: this should call `va_end`, but there's no clean way to
>          // guarantee that `drop` always gets inlined into its caller,
>          // so the `va_end` would get directly called from the same function as
>          // the corresponding `va_copy`. `man va_end` states that C
> requires this,
>          // and LLVM basically follows the C semantics, so we need to make sure
>          // that `va_end` is always called from the same function as `va_copy`.
>          // For more details, see https://github.com/rust-lang/rust/pull/59625
>          // and https://llvm.org/docs/LangRef.html#llvm-va-end-intrinsic.
>          //
>          // This works for now, since `va_end` is a no-op on all
> current LLVM targets.
> 
> How do you approach, or plan to approach, code like the above in gccrs?
> Maybe make a fork of the Rust standard library that only replaces the
> LLVM-dependent parts of the code? I do not know how widespread
> LLVM-dependent code is in the Rust standard library, nor how
> well-documented the dependence on LLVM typically is. In the above
> case, it is well-documented.
> 
> Best, VJ.

Things like that can be special-cased somewhat easily without 
necessarily forking the Rust standard library, which would make a lot of 
things a lot more difficult for us and would also not align with our 
objectives of not creating a rift in the Rust ecosystem.

The `VaListImpl` is a lang item in recent Rust versions as well as the 
one we currently target, which means it is a special type that the 
compiler has to know about, and that we can easily access its methods or 
trait implementation and add special consideration for instances of this 
type directly from the frontend. If we need to add a call to `va_end` 
anytime one of these is created, then we'll do so.

We will take special care to ensure that the code produced by gccrs 
matches the behavior of the code produced by rustc. To us, having the 
same behavior as rustc does not just mean behaving the same way when 
compiling code but also creating executables and libraries that behave 
the same way. We have already started multiple efforts towards comparing 
the behavior of rustc and gccrs and plan to continue working on this in 
the future to ensure maximum compatibility.

Kindly,

Arthur

