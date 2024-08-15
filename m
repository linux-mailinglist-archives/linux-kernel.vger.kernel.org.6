Return-Path: <linux-kernel+bounces-288343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A25953904
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06FF1C245CA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21A957CA7;
	Thu, 15 Aug 2024 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lW9ynsNv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2734F4F602;
	Thu, 15 Aug 2024 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743107; cv=none; b=G8+mV5dHQJbpG8ZQgOGNp5Cxy9r1NhFEuB3goHUWqNyZCbg3OP1xXe1FyIEwEv/QH6ALIodnqox5HB70oxrFBtZTg5P6wbvDXgpcOezJXrmD/628JfOi+eX3YAFr2EkVO6UnioaQ+K9ynpB4U1SUyLb+nggUun1ovWF2PW0ark8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743107; c=relaxed/simple;
	bh=U+jRELET6AVBXyt+G5LhJTKwYebbuw6k806cmUl27d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KObWVtU0k7Oq8FV64DvlQ4ghfk5sPMtkAJ91NCjLv1K4Bm0zSKTJZ2pQlLY/K+lz4mG9LwirwV/2jSbQWDW9CZSDvms2OoHMq006GwZPH/+Yh8jdbbU4a2DMTap1aqRlq9QhY7wZrA0v3eN02TeW6W7kFnB6Xpen0+8L9W1qkA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lW9ynsNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDD2C32786;
	Thu, 15 Aug 2024 17:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723743106;
	bh=U+jRELET6AVBXyt+G5LhJTKwYebbuw6k806cmUl27d4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lW9ynsNvLMwK7q2CJ6/FKGAkz3vZhFuQk7Tt913Eb3STEgbG6S8JmT5YxEgQ7jikl
	 s5tMS27uL/3rJ685dtYV/gLpnJ5fclQD8vaf4/v4sYwgoy6d3MejUG/1bb+C2+jKB4
	 Ql8SZFLapCQEm+xCQEUhh9DfAp3kCEikAWT1u5aBWlm2KmcOqfhB8mHVO4r3h5yG/M
	 iHPHWai5MCOC1PuGak7223GaADjxgkNXghQDseW2Y6pPrQMPFpgISYFPxp4bqAMfhO
	 8GOGjmzbfVx41lszNAW25tpjoTkBk1NhBm6vx+dDbjStokOqGqkvg8OZj9eJwhrOoE
	 s9RMAtsIdln8w==
Message-ID: <0864ea20-b75d-46c1-844c-9f65da25e6b3@kernel.org>
Date: Thu, 15 Aug 2024 19:31:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/26] Generic `Allocator` support for Rust
To: Boqun Feng <boqun.feng@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org,
 daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
 boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com,
 zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org
References: <20240812182355.11641-1-dakr@kernel.org>
 <Zr0GP0OXliPRqx4C@boqun-archlinux> <Zr1teqjuOHeeFO4Z@cassiopeiae>
 <Zr44h-4A3rm-ALS2@boqun-archlinux>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <Zr44h-4A3rm-ALS2@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 7:19 PM, Boqun Feng wrote:
> On Thu, Aug 15, 2024 at 04:52:42AM +0200, Danilo Krummrich wrote:
>> On Wed, Aug 14, 2024 at 12:32:15PM -0700, Boqun Feng wrote:
>>> Hi Danilo,
>>>
>>> I'm trying to put your series on rust-dev, but I hit a few conflicts due
>>> to the conflict with `Box::drop_contents`, which has been in rust-dev
>>> for a while. And the conflict is not that trivial for me to resolve.
>>> So just a head-up, that's a requirement for me to put it on rust-dev for
>>> more tests from my end ;-)
>>
>> I rebased everything and you can fetch them from [1].
>>
> 
> Thanks! I will take a look later today or tomorrow.

I'll also send a v6 soon, which will also be based on rust-dev, so can also
take this one then.

> 
>> I resolved the following conflicts:
>>
>>    - for `Box`, implement
>>      - `drop_contents`
>>      - `manually_drop_contents` [2]
>>      - ``move_out` [2]
> 
> Have you considered naming this `into_inner` which is aligned to std
> `Box`?

Seems viable too. I can rename it.

> 
> Regards,
> Boqun
> 
>>      - `BorrowedMut` for `ForeignOwnable` for `Box<T, A>` and `Pin<Box<T, A>>`
>>      - `InPlaceWrite` and updated `InPlaceInit`
>>    - for `RBTreeNode`, make use of `Box::move_out` to replace the original
>>      implementation partially moving out of `Box`
>>
>> @Alice: Please have a look at the changes for `RBTreeNode`. Maybe it's also
>> worth having them in a separate patch.
>>
>> - Danilo
>>
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust-dev/mm
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/commit/?h=rust-dev/mm&id=ef80ccca2ccebf3c7bcafdc13d1bfe81341cbe63
>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/diff/rust/kernel/rbtree.rs?h=rust-dev/mm&id=c361d66df7fb7760064fbca6bf9d72171c352a73
>>
>>>
>>> Regards,
>>> Boqun
> 

