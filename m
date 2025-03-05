Return-Path: <linux-kernel+bounces-547775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2083AA50D6B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CECA3AEF22
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEA5256C9A;
	Wed,  5 Mar 2025 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kovSYpc6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AFB1FE469;
	Wed,  5 Mar 2025 21:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210012; cv=none; b=UdjOWSKpH/sjN/2KBHSjaZ531NxTiuwNYIWW5jEjiByYf8Eb6Eq1aCfudNUhUFodCjnEZg3DNsVtCO3UvxH/PtMVv7SePg1VAJqHDLHd3ILq7/vgM7mIwiYo99/E94WcXgz7Kf+byuXQwXxHklj/0qJVNVUk70QVW0RdVCQz0is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210012; c=relaxed/simple;
	bh=mCVySOkr7YXVjXIB2HwJbECGnpXQPFKjKUezXQs5VPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JA3QcCtNYxLLhyByG8APZU3AH4r0PJUGHhSV4F30rc85PxA5ZqA4PNLG75/p/m5DmwEZq/FZWfaalffJCCyakvwHYZKWho6bOmWbvQ68lafN+U5QkPxsn664JkMpzqBy5mBKT5V8UDT5O4c0AioW3IH2Y9eBVXI2W6e4pffqj9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kovSYpc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5639AC4CED1;
	Wed,  5 Mar 2025 21:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741210011;
	bh=mCVySOkr7YXVjXIB2HwJbECGnpXQPFKjKUezXQs5VPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kovSYpc636KtErlQgI2ZrNJBoQ/pjYkksty4vMPUUMpBGOyxFAPMBz/6FNkHTWoRx
	 L62czdOmKEJTVno2l7heHrhYrcfcrkjHDRlhX5bmCerH5ugD5wL301q4PwlF0tiFZ0
	 5DlA96gMAopnFu6YrJqabIu3H1xyarWhBvcthEzJAccKUIuCTkGywBipQ/+syUOWv4
	 WEILPjO6jURny7wcmoDW90+0+Qe+WijyJGL1zxnecbDSVVDiVh/QlUgYa5WWcxNFFD
	 zm60kfT4cqPfvWuJiDSbeRfxQAG7Tp6L/ULQzozB0ovV6m32cFp+FU0/eh8zBlHB4W
	 ht/yd8BZwA7Ow==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Ralf Jung" <post@ralfj.de>
Cc: "Alice Ryhl" <aliceryhl@google.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "comex" <comexk@gmail.com>,  "Daniel Almeida"
 <daniel.almeida@collabora.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,  <dakr@kernel.org>,
  <robin.murphy@arm.com>,  <rust-for-linux@vger.kernel.org>,  "Miguel
 Ojeda" <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Gary
 Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Valentin Obst"
 <kernel@valentinobst.de>,  <linux-kernel@vger.kernel.org>,  "Christoph
 Hellwig" <hch@lst.de>,  "Marek Szyprowski" <m.szyprowski@samsung.com>,
  <airlied@redhat.com>,  <iommu@lists.linux.dev>,  <lkmm@lists.linux.dev>
Subject: Re: Allow data races on some read/write operations
In-Reply-To: <915eacce-cfd8-4bed-a407-32513e43978f@ralfj.de> (Ralf Jung's
	message of "Wed, 05 Mar 2025 20:42:05 +0100")
References: <87bjuil15w.fsf@kernel.org>
	<t4HxdvR7WBX_861hiTXo72jqC9F9oRpIzgA_dD2yhcSuLISEkC-shMfSgllrFPpnkSZXGfRcc47keudMooNiIQ==@protonmail.internalid>
	<CAH5fLgg5MuUu=TX8mMsPf5RcLhMLHSU4Vct=h8rFX6Z7HjPxeA@mail.gmail.com>
	<87ikoqjg1n.fsf@kernel.org>
	<KpWTCfIlcLYFBpSvWPfALJ9VQn5a99_RAvxgMBc1aCrSalPB-qaW9IhXyaDG7HM1AcFPX5chj_Yr7IQp3F7UqA==@protonmail.internalid>
	<CAH5fLgh6ubawHh76wq7JPbcuBCWhm91m7Rc01MVsX-a3C6qaVA@mail.gmail.com>
	<87mse2hrd8.fsf@kernel.org> <Z8YMTiKS4T9wC4t_@boqun-archlinux>
	<ae8ac31f-c6ad-46ae-80dd-10ec081a16d1@ralfj.de>
	<88456D33-C5CA-4F4F-990E-8C5F2AF7EAF9@gmail.com>
	<hkhgihg4fjkg7zleqnumuj65dfvmxa5rzawkiafrf4kn5ss6nw@o7kc6xe2bmuj>
	<25e7e425-ae72-4370-ae95-958882a07df9@ralfj.de>
	<CAH5fLgidPHQzdUORNpNhtRFsKPU1T-0xdn5OSwYYZh3BgOVRQA@mail.gmail.com>
	<18cmxblLU2QAa4YP25RWCKEnxuonOwWXavYmSsS4C5D40o8RaCkIXo0UDZ2SPnksk5nWYB29Y4zHkjQeOgd4ng==@protonmail.internalid>
	<3aabca39-4658-454a-b0e3-e946e72977e1@ralfj.de> <87eczb71xs.fsf@kernel.org>
	<M_YejDCAOZ7AX0l8ZZ7Z5EesJicUgsjYJUTm0SzLkhYTAYyXRJFTr4QYZMagG4KX6YdHoT-IPhf8ygjircrs0A==@protonmail.internalid>
	<915eacce-cfd8-4bed-a407-32513e43978f@ralfj.de>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 22:26:39 +0100
Message-ID: <87tt875fu8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ralf Jung" <post@ralfj.de> writes:

> Hi all,
>
>>>> For some kinds of hardware, we might not want to trust the hardware.
>>>> I.e., there is no race under normal operation, but the hardware could
>>>> have a bug or be malicious and we might not want that to result in UB.
>>>> This is pretty similar to syscalls that take a pointer into userspace
>>>> memory and read it - userspace shouldn't modify that memory during the
>>>> syscall, but it can and if it does, that should be well-defined.
>>>> (Though in the case of userspace, the copy happens in asm since it
>>>> also needs to deal with virtual memory and so on.)
>>>
>>> Wow you are really doing your best to combine all the hard problems at the same
>>> time. ;)
>>> Sharing memory with untrusted parties is another tricky issue, and even leaving
>>> aside all the theoretical trouble, practically speaking you'll want to
>>> exclusively use atomic accesses to interact with such memory. So doing this
>>> properly requires atomic memcpy. I don't know what that is blocked on, but it is
>>> good to know that it would help the kernel.
>>
>> I am sort of baffled by this, since the C kernel has no such thing and
>> has worked fine for a few years. Is it a property of Rust that causes us
>> to need atomic memcpy, or is what the C kernel is doing potentially dangerous?
>
> It's the same in C: a memcpy is a non-atomic access. If something else
> concurrently mutates the memory you are copying from, or something else
> concurrently reads/writes the memory you are copying two, that is UB.
> This is not specific to memcpy; it's the same for regular pointer loads/stores.
> That's why you need READ_ONCE and WRITE_ONCE to specifically indicate to the
> compiler that these are special accesses that need to be treated differently.
> Something similar is needed for memcpy.

I'm not a compiler engineer, so I might be wrong about this, but. If I
do a C `memcpy` from place A to place B where A is experiencing racy
writes, if I don't interpret the data at place B after the copy
operation, the rest of my C program is fine and will work as expected. I
may even later copy the data at place B to place C where C might have
concurrent reads and/or writes, and the kernel will not experience UB
because of this. The data may be garbage, but that is fine. I am not
interpreting the data, or making control flow decisions based on it. I
am just moving the data.

My understand is: In Rust, this program would be illegal and might
experience UB in unpredictable ways, not limited to just the data that
is being moved.

One option I have explored is just calling C memcpy directly, but
because of LTO, that is no different than doing the operation in Rust.

I don't think I need atomic memcpy, I just need my program not to
explode if I move some data to or from a place that is experiencing
concurrent writes without synchronization. Not in general, but for some
special cases where I promise not to look at the data outside of moving
it.


Best regards,
Andreas Hindborg



