Return-Path: <linux-kernel+bounces-287912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA2B952E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A555B24605
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E0317A592;
	Thu, 15 Aug 2024 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mo/IZUZR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDB6146A6D;
	Thu, 15 Aug 2024 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723724269; cv=none; b=EOgPJo6U0ANlosCQzdZCTeUlV5UfENJeXC7n1V0gR8ZKY9Y8/2vBX67XqwlvrcV+0aKuYU+o2yI3D/9lgZ4AEZO6So1AQuacyCTOLDca9koGeEk+nvhnYCpucQRqqRzAb2fM5Ntm7NT3SLulHbBrksmybqHHNJ1+LzpoSMIfW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723724269; c=relaxed/simple;
	bh=sKgXj6G3qZ7k0Aq7YegUtpEBhQSBFus/Yl44KMx0kZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ha3a4MCoKiFBdsWAU/uwzfo5ZIQC+RCDyylbXEtQZZ3/DyBu1M0odOirrJL6AoqsGGAsmqCFaUcFUFSBVENms2Taps3w4YA4gEi1JDP19g95yDRU3xAu6v7VUc+liSbGBwA7G0CLSdkWrPTbrfnghkSKvRjw8opqDeIg6S3qFVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mo/IZUZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12259C32786;
	Thu, 15 Aug 2024 12:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723724268;
	bh=sKgXj6G3qZ7k0Aq7YegUtpEBhQSBFus/Yl44KMx0kZQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mo/IZUZR87m061SONyuxATMj5nYLudVagEu+ohuxGe1qYvlMxID6PY0z/ymR7+YAg
	 qDQ1LDn+6sQzmGQlUr0pfXgHsHICWQokyXr5160x+xA4B9AEiPAEF5NwH5UaBLw/9q
	 xluSzp4LmUWWbqNOq+FofqZFoB7Z7fZ3Dtre46HG7CxOe8RqTbU+sL4+FtpQjsUWsi
	 XtvL+GOQh4p7kBTw4nSsIHJMf2hAsQvmAAlXKEP14BWzmxogTSlk9EvdUIDdgs2Ih+
	 R5uN4hGPYcUiRuveRQVKqF6YdBtJkgjj232JSf6sPtAZav7pYKgj7kBOsR83D94ye6
	 aQ48JOwm5P3MA==
Message-ID: <01106f43-3338-4eec-bd6b-2ee820f7267c@kernel.org>
Date: Thu, 15 Aug 2024 14:17:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/26] rust: alloc: implement kernel `Vec` type
To: Alice Ryhl <aliceryhl@google.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org,
 daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
 boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com,
 zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org
References: <20240812182355.11641-1-dakr@kernel.org>
 <20240812182355.11641-14-dakr@kernel.org>
 <CAH5fLggchaAzcRK=i=zRm7hTg6qX0yGBAyAHcO45rG-oEh-AMQ@mail.gmail.com>
 <Zr0z0fBM_acHFezv@cassiopeiae>
 <CAH5fLgjDMuiR07jc=aa-3radEOgU8iMn-u+XttepuWr9r_doYQ@mail.gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CAH5fLgjDMuiR07jc=aa-3radEOgU8iMn-u+XttepuWr9r_doYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/15/24 9:30 AM, Alice Ryhl wrote:
> On Thu, Aug 15, 2024 at 12:46 AM Danilo Krummrich <dakr@kernel.org> wrote:
>>
>> On Wed, Aug 14, 2024 at 10:42:28AM +0200, Alice Ryhl wrote:
>>>> +#[macro_export]
>>>> +macro_rules! kvec {
>>>> +    () => (
>>>> +        {
>>>> +            $crate::alloc::KVec::new()
>>>> +        }
>>>> +    );
>>>> +    ($elem:expr; $n:expr) => (
>>>> +        {
>>>> +            $crate::alloc::KVec::from_elem($elem, $n, GFP_KERNEL)
>>>> +        }
>>>> +    );
>>>> +    ($($x:expr),+ $(,)?) => (
>>>> +        {
>>>> +            match $crate::alloc::KBox::new([$($x),+], GFP_KERNEL) {
>>>> +                Ok(b) => Ok($crate::alloc::KBox::into_vec(b)),
>>>> +                Err(e) => Err(e),
>>>
>>> Hmm. This currently generates code that:
>>>
>>> 1. Creates the array.
>>> 2. Allocates the memory.
>>> 3. Moves the array into the box.
>>>
>>> Whereas the stdlib macro swaps step 1 and 2.
>>
>> Isn't stdlib [1] doing the same thing I do?
>>
>> [1] https://doc.rust-lang.org/1.80.1/src/alloc/macros.rs.html#49
> 
> Stdlib is using something called #[rustc_box] which has the effect I described.
> 
>>> You can do the same by utilizing new_uninit. A sketch:
>>>
>>> match KBox::<[_; _]>::new_uninit(GFP_KERNEL) {
>>
>> How do we get the size here? `#![feature(generic_arg_infer)]` seems to be
>> unstable.
> 
> It probably works if you don't specify the type at all:
> `KBox::new_uninit`. But you should double check.

That works, thanks.

> 
>>>      Ok(b) => Ok(KVec::from(KBox::write(b, [$($x),+]))),
>>>      Err(e) => Err(e),
>>> }
> 

