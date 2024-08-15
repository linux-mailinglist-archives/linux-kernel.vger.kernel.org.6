Return-Path: <linux-kernel+bounces-288085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BADD9533A8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39BA61C25494
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3AB1A706A;
	Thu, 15 Aug 2024 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuHd6kMf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C871A0712;
	Thu, 15 Aug 2024 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731457; cv=none; b=kY4/H9wfWUpWxdWn1oc8ihU+fTwjhJcS0ZWIXLLq50ZA7N5/Nj61C9XLvQz1vCmLNZd6ORLS2SyLk69LNE+IFHUex8P0Oh4HPUcHqTl0RtX1N9qx0O592PUqKfia14vE7rSfWRXnUKNetMUVk+IJY/Zu+vmSA2+T0sGULA0gxJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731457; c=relaxed/simple;
	bh=Kby6yhzXoUk+UkDsvLSOc5svMZXjS9dbjQp2GqhLQNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBPjr8zXpSwpKwtTLMjXu3Xh86SMtR1rTOLhZplX1JQ0EKqxWPHQ/WTRekJQKSqn8lac3JFDhFKWJvdAYDwURtOhuw+xpzLouV8MzE64x0ZUSRSnVaKuGIK4n6d3EgdVYXz/lZADpqJrzE9PsceB+Axv5rMwL/X5m49ADit2GUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuHd6kMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A1FC32786;
	Thu, 15 Aug 2024 14:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723731456;
	bh=Kby6yhzXoUk+UkDsvLSOc5svMZXjS9dbjQp2GqhLQNY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kuHd6kMfGvDjRn+edV5fGItrR6OXVpZzUpcArLByZhhRNzXDa5CL6Sh2EVHSdJnRz
	 2b4JgMX/44zfYQj6M1pwTs/syPaRkVIPPv3IlrbeVuBJMBj9E70rWz3mc5rXSxj9C3
	 VoDRfa2tMUn3FLGOG+rHOg6DLyT2H3QnNI4TY5M6qjGmHkFsIOFTHIP4EO7pZjZFRc
	 kvFF26IilTJMeFi8CZGPCIwhdi7hE+cihojFF2S+E5I94XD54XrpeU6AhSyQ1ihLMH
	 EugGWpLHK+wqvJWUscTtooPQf2abet8NVMYNHzntIbUBNmFnwEXXzv7aGdu/yzF7SP
	 UFnJR9ytvnKpg==
Message-ID: <3ca1824a-8918-460d-bd99-fd88cdf92329@kernel.org>
Date: Thu, 15 Aug 2024 16:17:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/26] rust: alloc: implement kernel `Box`
To: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org,
 daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
 boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com,
 zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org
References: <20240812182355.11641-1-dakr@kernel.org>
 <20240812182355.11641-10-dakr@kernel.org>
 <a69e7280-7291-49f7-a46f-1ad465efce04@proton.me>
 <Zr0ocI-j3fZZM7Rw@cassiopeiae>
 <56ebda7b-c570-4dc6-8456-ab768d3a4b77@proton.me>
 <Zr4J4e1aLADlyDMD@cassiopeiae>
 <66ed33bf-b17a-406f-b277-501ea9f002bf@proton.me>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <66ed33bf-b17a-406f-b277-501ea9f002bf@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 4:10 PM, Benno Lossin wrote:
> On 15.08.24 16:00, Danilo Krummrich wrote:
>> On Thu, Aug 15, 2024 at 01:24:47PM +0000, Benno Lossin wrote:
>>> On 14.08.24 23:58, Danilo Krummrich wrote:
>>>> On Wed, Aug 14, 2024 at 05:01:34PM +0000, Benno Lossin wrote:
>>>>> On 12.08.24 20:22, Danilo Krummrich wrote:
>>>>>> +///
>>>>>> +/// # Examples
>>>>>> +///
>>>>>> +/// ```
>>>>>> +/// let b = KBox::new(24_u64, GFP_KERNEL)?;
>>>>>> +///
>>>>>> +/// assert_eq!(*b, 24_u64);
>>>>>> +///
>>>>>> +/// # Ok::<(), Error>(())
>>>>>> +/// ```
>>>>>> +pub type KBox<T> = Box<T, super::allocator::Kmalloc>;
>>>>>> +
>>>>>> +/// Type alias for `Box` with a `Vmalloc` allocator.
>>>>>
>>>>> Same here, add that this is supposed to be used for big values (or is
>>>>> this also a general-purpose allocator, just not guaranteeing that the
>>>>> memory is physically contiguous? in that case I would document it
>>>>> here and also on `Vmalloc`).
>>>>
>>>> Same as above, I'd rather not duplicate that. But I'm happy to link things in,
>>>> just not sure what's the best way doing it.
>>>
>>> I took a look at the link and there is the "Selecting memory allocator"
>>> section, but there isn't really just a vmalloc or kmalloc section, it is
>>> rather stuff that we would put in the module documentation.
>>
>> There are no dedicated sections, but...
>>
>>> What I would write on these types would be what to use these boxes for.
>>> eg large allocations, general purpose etc. I don't think that that is
>>> easily accessible from the docs that you linked above.
>>
>> ...this stuff should be covered by the document, e.g.:
>>
>> "The maximal size of a chunk that can be allocated with kmalloc is limited. The
>> actual limit depends on the hardware and the kernel configuration, but it is a
>> good practice to use kmalloc for objects smaller than page size."
>>
>> or
>>
>> "For large allocations you can use vmalloc() and vzalloc(), or directly request
>> pages from the page allocator. The memory allocated by vmalloc and related
>> functions is not physically contiguous."
> 
> Yeah, but for that you have to read big chunks of the document and item
> docs in Rust are often very short, since you only need to know what that
> one item does.

In this specific case I'd argue that the contents of this document should be
read and understood by everyone who attempts to write kernel code anyways,
hence linking it should be fine.

> Would be a good idea to talk about how we can improve this at Kangrejos.
> 
> ---
> Cheers,
> Benno
> 

