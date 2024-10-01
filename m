Return-Path: <linux-kernel+bounces-345964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C20D98BD77
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6C00B23B23
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB27B1C463D;
	Tue,  1 Oct 2024 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFS5gTba"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208731C3F26;
	Tue,  1 Oct 2024 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789235; cv=none; b=ckttYjPPjlg9loeDFeM2AtYRXeS4yUmr3wnCBi/rY5p7T+KzriAE1ygffvDbsqWTx7BYSZYijIoo5JXekmXQ2GayQaKSBy1DNDBEXKZ/H1znK2R4qbsIq1onda4KHazPzU9sX7xNOANUW6M6jDANp1KCvnUTndsKC9BzSkhSrM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789235; c=relaxed/simple;
	bh=lo+LhlofpgXlCwI69zHLxSTcxLWDkf/fiIg3BNcDXv4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PPSqM+7LZkGEmS8EwCm/zqhF4NQ/O4Ibkv38WepAPtHgi8wtv+WOOzQ9DKALe2KEz7HWGX0m63fIxqkz8iTzTyAQZqPDzob2M46/SJW5h8Q49numhidQfELSU8VJG2Dq9G78FcgFzL0A1QtAwHyRguV+JeRDhiYlGAFaf0LTiSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFS5gTba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222F2C4CED1;
	Tue,  1 Oct 2024 13:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727789234;
	bh=lo+LhlofpgXlCwI69zHLxSTcxLWDkf/fiIg3BNcDXv4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=qFS5gTbaHhXSeyvgEFgpM2FFgO5HEgLCg4qaY9ONUZR0Z8R8lRy5UJ4/aFZO1qYM3
	 w7IFJdmrsNnEnTsX/WdJ0qetntbOs4ZUL2oAKdi2Ed6+2G6XHRhYexKnXJzl7ABasH
	 xE+24mCQe5vUTGVPf4RbIBcTSFW70hLD6wS20Y+1gOGsnl4T4dxvL7LYl1H545LAzk
	 01Ajoh7rXzZYoG60cjGb5DwxQ6uUxFti4NCuH7vkpjrjKVx6NH8jjQfP3pjvDDAwkY
	 A2pNRIRdV12sUTSzelVfMLrRsVHXzMmzCHH53OFwkYwtu7GoFntHG9lkS59cr2waIW
	 ZcHqTZhXC17PQ==
Message-ID: <829c9cf9-9e73-4167-94dc-ca5db3a37e6a@kernel.org>
Date: Tue, 1 Oct 2024 15:27:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 25/26] kbuild: rust: remove the `alloc` crate and
 `GlobalAlloc`
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org,
 daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
 boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com,
 zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org
References: <20240911225449.152928-1-dakr@kernel.org>
 <20240911225449.152928-26-dakr@kernel.org>
 <20240928204357.3a28dada.gary@garyguo.net> <Zvlvg0pBkhmukh0N@pollux>
Content-Language: en-US
In-Reply-To: <Zvlvg0pBkhmukh0N@pollux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/29/24 5:17 PM, Danilo Krummrich wrote:
> On Sat, Sep 28, 2024 at 08:43:57PM +0100, Gary Guo wrote:
>> On Thu, 12 Sep 2024 00:53:01 +0200
>> Danilo Krummrich <dakr@kernel.org> wrote:
>>
>>> Now that we have our own `Allocator`, `Box` and `Vec` types we can remove
>>> Rust's `alloc` crate and the `new_uninit` unstable feature.
>>>
>>> Also remove `Kmalloc`'s `GlobalAlloc` implementation -- we can't remove
>>> this in a separate patch, since the `alloc` crate requires a
>>> `#[global_allocator]` to set, that implements `GlobalAlloc`.
>>>
>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>> ---
>>>   rust/Makefile                     | 43 +++++----------------
>>>   rust/exports.c                    |  1 -
>>>   rust/kernel/alloc/allocator.rs    | 63 +------------------------------
>>>   scripts/Makefile.build            |  7 +---
>>>   scripts/generate_rust_analyzer.py | 11 +-----
>>>   5 files changed, 15 insertions(+), 110 deletions(-)
>>>
>>> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
>>> index 72b1232b1f7d..529ec5972e55 100644
>>> --- a/scripts/Makefile.build
>>> +++ b/scripts/Makefile.build
>>> @@ -262,18 +262,13 @@ $(obj)/%.lst: $(obj)/%.c FORCE
>>>   
>>>   # Compile Rust sources (.rs)
>>>   # ---------------------------------------------------------------------------
>>> -
>>> -rust_allowed_features := new_uninit
>>> -
>>
>> Would it make sense to throw in a soon-to-be-stable (or
>> already-stable-but-beyond-min-rust-version) feature here to not have to
>> remove the build system support for unstable feature directly?
> 
> It's only about those two lines, right? I can only remove the `new_uninit` and
> leave `rust_allowed_features :=` and leave...
> 
>>
>> For example, I know that const_refs_to_static might be added here
>> soon-ish.
>>
>>>   # `--out-dir` is required to avoid temporaries being created by `rustc` in the
>>>   # current working directory, which may be not accessible in the out-of-tree
>>>   # modules case.
>>>   rust_common_cmd = \
>>>   	RUST_MODFILE=$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \
>>> -	-Zallow-features=$(rust_allowed_features) \
> 
> ...this line, I guess?

Seems like I can't, it blows up with an empty feature list. I'll keep it as it 
is for now. Shouldn't be a big deal to add it again, once needed.

> 
>>
>> I think this actually allow all features instead of allowing none.
>>
>>>   	-Zcrate-attr=no_std \
>>> -	-Zcrate-attr='feature($(rust_allowed_features))' \
>>> -	-Zunstable-options --extern force:alloc --extern kernel \
>>> +	-Zunstable-options --extern kernel \
>>>   	--crate-type rlib -L $(objtree)/rust/ \
>>>   	--crate-name $(basename $(notdir $@)) \
>>>   	--sysroot=/dev/null \
>>> diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
>>> index d2bc63cde8c6..09e1d166d8d2 100755
>>> --- a/scripts/generate_rust_analyzer.py
>>> +++ b/scripts/generate_rust_analyzer.py
>>> @@ -64,13 +64,6 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
>>>           [],
>>>       )
>>>   
>>> -    append_crate(
>>> -        "alloc",
>>> -        sysroot_src / "alloc" / "src" / "lib.rs",
>>> -        ["core", "compiler_builtins"],
>>> -        cfg=crates_cfgs.get("alloc", []),
>>> -    )
>>> -
>>>       append_crate(
>>>           "macros",
>>>           srctree / "rust" / "macros" / "lib.rs",
>>> @@ -96,7 +89,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
>>>       append_crate(
>>>           "kernel",
>>>           srctree / "rust" / "kernel" / "lib.rs",
>>> -        ["core", "alloc", "macros", "build_error", "bindings"],
>>> +        ["core", "macros", "build_error", "bindings"],
>>>           cfg=cfg,
>>>       )
>>>       crates[-1]["source"] = {
>>> @@ -133,7 +126,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
>>>               append_crate(
>>>                   name,
>>>                   path,
>>> -                ["core", "alloc", "kernel"],
>>> +                ["core", "kernel"],
>>>                   cfg=cfg,
>>>               )
>>>   
>>


