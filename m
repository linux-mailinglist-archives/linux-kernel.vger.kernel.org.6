Return-Path: <linux-kernel+bounces-287176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2806095244A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9281F28B61
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529621C8FD9;
	Wed, 14 Aug 2024 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0zFhJJg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE811BC069;
	Wed, 14 Aug 2024 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668829; cv=none; b=SiZpMGzLxT1DmDrfiuAEQHf4y9N1dn3+A7jmxSBm9CFQh3MAlMwrbJ5aR3LMvSR4/82h3m5DNuqKorv+Trcl8x6z6I7LiVwhx9lh1PcoZvDSbmsq4GHnQfiIQoyqdjGE6v2PRlkRh3bMm8D/QSuUgACr7kWW5B2mjJQkf7BJp5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668829; c=relaxed/simple;
	bh=b8U7/CVYHFqEb0myiU2fWm7aWYNYOtrimMUhZTNfUoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMyXV1rKJh4H1w6Fc08Tk62jvaKQDJImU13bEiohkxc4U4agz6QcZHzPTS7Qvl7KwYTksFGgZMNMn18A6ERpTXnONjCa2nT/mlZNO//3L/aAMw41oLbWrE8favvX18VtZIeqIrWQStJgPVrOAh5mQe1it/quDh1UiRIAPXd11OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0zFhJJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E95BC116B1;
	Wed, 14 Aug 2024 20:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723668829;
	bh=b8U7/CVYHFqEb0myiU2fWm7aWYNYOtrimMUhZTNfUoA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J0zFhJJgVxjIWb6mDLr2ZcnWHqCV8whhcOoSvCgqco4CtV44gEGmdN3z3KyFoWurh
	 yhdV4Yd0OdXXlSiEfo0ojfadxkPP1Qqhvh5t4u7TnxAarU3gKqWBbJtkwi2Q/1cn59
	 vKthCyXWivsTZzW+IbPaNb/YFsgfIegWFa7rydgcGqsSbzcJpUWMmBXIrs/QWuWOyX
	 ILU59WhDNJniZLQetykQBgXZ71+ZFoVRLyXE9P8MYHOdNzH/+OQpA4Uk7xgb0VEoOf
	 /BTUloyoX1aZN8VCjPWZ1K3gFyLq8tAt3H8BCaE7oFMw8C0gRzXzrS51439tXvWIvC
	 B4NDgBawX3kpQ==
Message-ID: <e428c15c-f11b-4bbd-9cef-1ad252b206bb@kernel.org>
Date: Wed, 14 Aug 2024 22:53:41 +0200
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
 <Zr0GP0OXliPRqx4C@boqun-archlinux>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <Zr0GP0OXliPRqx4C@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/24 9:32 PM, Boqun Feng wrote:
> Hi Danilo,
> 
> On Mon, Aug 12, 2024 at 08:22:46PM +0200, Danilo Krummrich wrote:
>> Hi,
>>
>> This patch series adds generic kernel allocator support for Rust, which so far
>> is limited to `kmalloc` allocations.
>>
>> In order to abstain from (re-)adding unstable Rust features to the kernel, this
>> patch series does not extend the `Allocator` trait from Rust's `alloc` crate,
>> nor does it extend the `BoxExt` and `VecExt` extensions.
>>
>> Instead, this series introduces a kernel specific `Allocator` trait, which is
>> implemented by the `Kmalloc`, `Vmalloc` and `KVmalloc` allocators, also
>> implemented in the context of this series.
>>
>> As a consequence we need our own kernel `Box<T, A>` and `Vec<T, A>` types.
>> Additionally, this series adds the following type aliases:
>>
>> ```
>> pub type KBox<T> = Box<T, Kmalloc>;
>> pub type VBox<T> = Box<T, Vmalloc>;
>> pub type KVBox<T> = Box<T, KVmalloc>;
>>
>>
>> pub type KVec<T> = Vec<T, Kmalloc>;
>> pub type VVec<T> = Vec<T, Vmalloc>;
>> pub type KVVec<T> = Vec<T, KVmalloc>;
>> ```
>>
>> With that, we can start using the kernel `Box` and `Vec` types throughout the
>> tree and remove the now obolete extensions `BoxExt` and `VecExt`.
>>
>> For a final cleanup, this series removes the last minor dependencies to Rust's
>> `alloc` crate and removes it from the entire kernel build.
>>
>> The series ensures not to break the `rusttest` make target by implementing the
>> `allocator_test` module providing a stub implementation for all kernel
>> `Allocator`s.
>>
>> This patch series passes all KUnit tests, including the ones added by this
>> series. Additionally, the tests were run with `kmemleak` and `KASAN` enabled,
>> without any issues.
>>
>> This series is based on [1], which hit -mm/mm-unstable, and is also available
>> in [2].
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=mm/krealloc
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/mm
>>
>> Changes in v5:
>>   - (safety) comment / documentation fixes suggested by Alice, Benno and Gary
>>   - remove `Unique<T>` and implement `Send` and `Sync` for `Box` and `Vec`
>>   - use `KMALLOC_MAX_SIZE` for `KVmalloc` test and add a `Kmalloc` test that
>>     expects to fail for `KMALLOC_MAX_SIZE`
>>   - create use constants `KREALLOC`, `VREALLOC` and `KVREALLOC` for
>>     `ReallocFuncs`
>>   - drop `Box::drop_contents` for now, will add it again, once I actually rebase
>>     on the original patch that introduces it
> 
> I'm trying to put your series on rust-dev, but I hit a few conflicts due
> to the conflict with `Box::drop_contents`, which has been in rust-dev
> for a while. And the conflict is not that trivial for me to resolve.
> So just a head-up, that's a requirement for me to put it on rust-dev for
> more tests from my end ;-)

I'll rebase later on and send you a branch.

> 
> Regards,
> Boqun
> 
>>   - improve usage of `size_of_val` in `Box`
>>   - move `InPlaceInit` and `ForeignOwnable` impls into kbox.rs
>>   - fix missing `Box` conversions in rnull.rs
>>   - reworked `Cmalloc` to keep track of the size of memory allocations itself
>>   - remove `GlobalAlloc` together with the `alloc` crate to avoid a linker error
>>   - remove `alloc` from scripts/generate_rust_analyzer.py
>>
> [...]
> 

