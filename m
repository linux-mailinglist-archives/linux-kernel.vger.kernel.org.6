Return-Path: <linux-kernel+bounces-204684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 722518FF24F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CC121F26B3B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FEA19AA6C;
	Thu,  6 Jun 2024 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="JmSHwzaF"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3FF1991BC;
	Thu,  6 Jun 2024 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690594; cv=none; b=GcJiw5v941bmbErtnrn3ydXWF61mkPSILEXkahgsH5f2xB9kAkUIoXoHweCndtvqmEbGC38lpaiqsoSrJsqzTDXT9C4dIZJiUWwfCebaPw2q6y6Ky9sy8saUc/DXhu3K5TCPzP4HZL+z3MVC/Gw1gLPZc3/K8SgPVsZqMDwaU1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690594; c=relaxed/simple;
	bh=RFc53pBgTWIlv5uA9fwIBtYs0TJgbzdzSpuTpFwpyqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZeycAklbQAKFBy+E7vHBEN/AlP3+GFrZNTQCG2NR0D1GeGkQjPDyhkKEE1QsfYd3kRLFLH9c+zW9L0HDDzsPzwqgMio6gNriOi+3fuzgUmC/zhqjLdhPTOIw2bJyr45uqioDk+D4DOzrYLozRbI8h/fkeVmedulQ538EwZTF5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=JmSHwzaF; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1717690591;
	bh=RFc53pBgTWIlv5uA9fwIBtYs0TJgbzdzSpuTpFwpyqQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JmSHwzaFzu5SZrgopaWVwEeGeBkdOI8GYilDbZyBQxj1UWZ40zg57BrACmyBRrXS1
	 RU2+cQVfa+AYKlK5sNsujG3oNh4Mrhu8xSJoLx7Wt9zZNvqNe9ZxMkFJfq6Co2xHa6
	 mpDOruR1cNxGcxowWufaEBgvB5yrUKcgKxXaFheK0Dpw6wYg+Lrgrqrnr+4TqjuQ8J
	 EcSsSF9cUJ5PzxS/M96hvHYtfgRtTS6VeWEbDm+hCvSRKKYMoIVcq3I0lHY7fA7kgn
	 CIyHFTAjTpY1S5OpF3wpMSnMMGh2QCg+onAL+cwzmDVGZBlvNI/z0CEQdZ2iPV0Nos
	 oELz9YHBotlGA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Vw8bL6v4lz12m8;
	Thu,  6 Jun 2024 12:16:30 -0400 (EDT)
Message-ID: <d04042cd-0d17-48e7-ae9f-9a4a409408ab@efficios.com>
Date: Thu, 6 Jun 2024 12:17:20 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Tracepoints and static branch/call in Rust
To: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
 <cd4a58d9-3e0a-49d1-8a74-bc9d53fc2dfd@efficios.com>
 <CAH5fLgi4zs5ehDCEgkxPzaamNKn_2cP5+qH8KTy4ujdf2_D-vA@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAH5fLgi4zs5ehDCEgkxPzaamNKn_2cP5+qH8KTy4ujdf2_D-vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-06-06 11:46, Alice Ryhl wrote:
> On Thu, Jun 6, 2024 at 5:25 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> On 2024-06-06 11:05, Alice Ryhl wrote:
>>> This implementation implements support for static keys in Rust so that
>>> the actual static branch will end up in the Rust object file. However,
>>> it would also be possible to just wrap the trace_##name generated by
>>> __DECLARE_TRACE in an extern C function and then call that from Rust.
>>> This will simplify the Rust code by removing the need for static
>>> branches and calls, but it places the static branch behind an external
>>> call, which has performance implications.
>>
>> The tracepoints try very hard to minimize overhead of dormant tracepoints
>> so it is not frowned-upon to have them built into production binaries.
>> This is needed to make sure distribution vendors keep those tracepoints
>> in the kernel binaries that reach end-users.
>>
>> Adding a function call before evaluation of the static branch goes against
>> this major goal.
>>
>>>
>>> A possible middle ground would be to place just the __DO_TRACE body in
>>> an extern C function and to implement the Rust wrapper by doing the
>>> static branch in Rust, and then calling into C the code that contains
>>> __DO_TRACE when the tracepoint is active. However, this would need some
>>> changes to include/linux/tracepoint.h to generate and export a function
>>> containing the body of __DO_TRACE when the tracepoint should be callable
>>> from Rust.
>>
>> This tradeoff is more acceptable than having a function call before
>> evaluation of the static branch, but I wonder what is the upside of
>> this tradeoff compared to inlining the whole __DO_TRACE in Rust ?
>>
>>> So in general, there is a tradeoff between placing parts of the
>>> tracepoint (which is perf sensitive) behind an external call, and having
>>> code duplicated in both C and Rust (which must be kept in sync when
>>> changes are made). This is an important point that I would like feedback
>>> on from the C maintainers.
>>
>> I don't see how the duplication happens there: __DO_TRACE is meant to be
>> inlined into each C tracepoint caller site, so the code is already meant
>> to be duplicated. Having an explicit function wrapping the tracepoint
>> for Rust would just create an extra instance of __DO_TRACE if it happens
>> to be also inlined into C code.
>>
>> Or do you meant you would like to prevent having to duplicate the
>> implementation of __DO_TRACE in both C and Rust ?
>>
>> I'm not sure if you mean to prevent source code duplication between
>> C and Rust or duplication of binary code (instructions).
> 
> It's a question of maintenance burden. If you change how __DO_TRACE is
> implemented, then those changes must also be reflected in the Rust
> version. There's no issue in the binary code.

As long as it is only __DO_TRACE that is duplicated between C and Rust,
I don't see it as a large burden.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


