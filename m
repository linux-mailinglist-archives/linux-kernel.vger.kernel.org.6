Return-Path: <linux-kernel+bounces-576390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A80DA70E97
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 02:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD7F1890F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D5FE56F;
	Wed, 26 Mar 2025 01:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B1y07/b3"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AAD2904
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 01:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742953742; cv=none; b=pHt7fYxHKtwwu2UdJp44BFgvIwfTL/DnXiyUiiRN/AqOIkV1+ak4dLLpj/l4EWw7G8GI/kBKJs6XYUoyUTiL29plwrnjHVazUCq7uHTn5wicd25gLavghJGNBt4/UCHpGLnDkwH8Ezp4u4Lva4MsIxLrxPP/1Kmst3tMwaIuPcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742953742; c=relaxed/simple;
	bh=O7Qk0wXNBps68dTV5i9fSeG1T4a0HtGZ4oJIUpuWXO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nG5YHYoIqeQ1sbYwJKJEyTayBojxA23D/aCB0948OdIU5aU5DZU38R5G+G5+n1bdA/ISdKsbDGpw6O2DxpXswFNHzpm6+UL+J+SjZCwXZwTZ4H9PK7GST3KyyFbhTlvlDImTMhG0dDs0mHGNKwCpHTkfEK9f+Ouoyqi68G+/1lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B1y07/b3; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d193a3bb-8faf-4741-88c3-0173fa36b209@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742953737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0cjfegyVHmVqLXT1DagyHv6BuDO34qa1ULxUGVqEAU=;
	b=B1y07/b3N6ie3Mfn9JnlrdV/pLKng5ESrYZQXroDPWq0bsLRfu26KaPqZdBgcy2poDIknh
	FUjQQ31+gbGD7cZoPTSCohyLUcwg2PqJaT6KKpwHy1WFYocVXzi/SdwLITXGtGXcF5xf9c
	DSo3h4RxT2PCoKhGuzJ5rEgj/bLwxuU=
Date: Wed, 26 Mar 2025 09:48:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] rust: sync: optimize rust symbol generation for
 CondVar
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
 morbo@google.com, justinstitt@google.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Kunwu Chan <kunwu.chan@hotmail.com>, Grace Deng <Grace.Deng006@gmail.com>
References: <20250324061835.1693125-1-kunwu.chan@linux.dev>
 <CANiq72=KjT8HRJA0NStHeqm-9286gay496CU8edNALPQ9_N+ww@mail.gmail.com>
 <52e7d34e-cf86-40d6-a294-b318df98d72a@linux.dev>
 <CANiq72=iMaEOALbh8EBrgEc5t0KQ2BTPADro3vmBtEM75pO3aw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <CANiq72=iMaEOALbh8EBrgEc5t0KQ2BTPADro3vmBtEM75pO3aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2025/3/25 18:12, Miguel Ojeda wrote:
> On Tue, Mar 25, 2025 at 4:02 AM Kunwu Chan <kunwu.chan@linux.dev> wrote:
>> Thanks for the kind reminder, I'll follow this next time
> You're welcome!
>
>> Now, the default '-Copt-level' is 2 when define
>> 'CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE',
>> and in  KBUILD_RUSTFLAGS the  '-Ccodegen-units' is 1.
>>
>> So if the config not change, the result should be the same.
> I don't think that is true, because there are a few `rustc` versions
> as well as LLVM ones that we support, so how inlining happens (at both
> `rustc` and LLVM levels) may change even if the configuration is
> essentially the same.
>
> And, of course, then there are other non-compiler-related kernel
> config options (i.e. not compiler flags, but other stuff, like `cfg`s)
> that influence which and how gets emitted and thus the inlining
> decisions.
> Eventually we should have pure GCC builds too, which is yet another factor...
>
> To be clear, I agree with Boqun that having to write `#[inline]`
> everywhere is not great. Rust 1.75 already started to tag small
> functions as `#[inline]` to try to prevent the proliferation of the
> attribute, which is good (i.e. which is what triggered the message in
> Compiler Explorer).

Thanks for the detailed reply.

Sure on the one hand, the decisions is a result of many factors,

on the other hand the rustc and llvm is rapidly developing.

It's a complicated thing.

> By the way, one difference is whether it is `pub` -- the `notify()`
> isn't (unlike the others), but if it were, then we would have needed
> the `#[inline]`, from a quick test.
That is a easy way to judge. I learned.
> Thanks!
>
> Cheers,
> Miguel

-- 
Thanks,
   Kunwu.Chan(Tao.Chan)


