Return-Path: <linux-kernel+bounces-573187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CA5A6D3FA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135693B1644
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 06:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B74A18E377;
	Mon, 24 Mar 2025 06:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q/itCYGO"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14B44C92
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 06:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742796170; cv=none; b=iCcfm1xpfniTqn1RWTDn5iZoskyLgcD5ZZTaUh3wC7gDWm6uPE8KjkZ692NnFM8fn+GRIJVpV5OdO5K0JJB9DY+ti0XiZckpzAiE0nPZdwhxJsQQ89JPZiSaig00NYrBClDAirwlBpp/woLF2YTub9fJbajPSKabbiLw40RBbqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742796170; c=relaxed/simple;
	bh=OjuHwzZy1fDH8hUH/qkLbPBSKDMKbHAYEurbzkK4X6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i03l+/YTGKXa+wYkt48nC2tuatBQvdm1ZBhVQIcHgjiKZLyDeXFvV3NnMglv79328PvbxP/q6z2ZebquG1RQNIDAZgtrjK7ju49U2Gd878qgONNrz3kgdMBhK4i5IhtSiZ8+ZkfzeAZ+0XfVAAQFSM2P69Y5+c9xO7irbQ8nzrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q/itCYGO; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <01c67d96-6477-4851-81ae-0cbee3b9e893@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742796156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tLb2IZkCs0bDiF2iretT/d5drfU5zFcnC3Q5G3NqRrw=;
	b=q/itCYGO/j4kiRkJ8toFeEMJoRFzpbkRLesA0lMZR41R+YiIQz8MsbLziQHFJTJnZKr65Y
	WscrDtH57UAR4s6BHfPXvmWUUZ1nmdKfukLJ8uzpiI0QBDyS8ihorGNNLpKTCWUMuKrvnp
	tDnavqWrElbr+l/v0gXXsCDdD9DsIuA=
Date: Mon, 24 Mar 2025 14:01:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] rust: sync: optimize rust symbol generation for CondVar
Content-Language: en-US
To: Boqun Feng <boqun.feng@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Kunwu Chan <kunwu.chan@hotmail.com>,
 Grace Deng <Grace.Deng006@gmail.com>
References: <20250317081351.2503049-1-kunwu.chan@linux.dev>
 <Z-BL_DFA3afcRYGE@Mac.home> <0d0b186d-6e07-4a46-b8e2-698a97796e44@linux.dev>
 <Z-DeUmA-aouWUZBT@Mac.home>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <Z-DeUmA-aouWUZBT@Mac.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/3/24 12:23, Boqun Feng wrote:
> On Mon, Mar 24, 2025 at 10:08:29AM +0800, Kunwu Chan wrote:
>> On 2025/3/24 01:59, Boqun Feng wrote:
>>> On Mon, Mar 17, 2025 at 04:13:50PM +0800, Kunwu Chan wrote:
>>>> From: Kunwu Chan <kunwu.chan@hotmail.com>
>>>>
>>>> When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
>>>> with ARCH=arm64, the following symbols are generated:
>>>>
>>>> $nm vmlinux | grep ' _R'.*CondVar | rustfilt
>>>> ... T <kernel::sync::condvar::CondVar>::notify_all
>>>> ... T <kernel::sync::condvar::CondVar>::notify_one
>>>> ... T <kernel::sync::condvar::CondVar>::notify_sync
>>>> ... T <kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
>>>> ... T <kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
>>>> ... T <kernel::sync::poll::PollCondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
>>>> ... T <kernel::sync::poll::PollCondVar as core::ops::drop::Drop>::drop
>>>>
>>>> These notify* symbols are trivial wrappers around the C functions
>>>> __wake_up and __wake_up_sync.
>>>> It doesn't make sense to go through a trivial wrapper for these
>>>> functions, so mark them inline.
>>>>
>>>> Link: https://github.com/Rust-for-Linux/linux/issues/1145
>>>> Suggested-by: Alice Ryhl <aliceryhl@google.com>
>>>> Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
>>>> Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
>>>> Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>
>>>> ---
>>>>    rust/kernel/sync/condvar.rs | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
>>>> index 7df565038d7d..a826896ba3f0 100644
>>>> --- a/rust/kernel/sync/condvar.rs
>>>> +++ b/rust/kernel/sync/condvar.rs
>>>> @@ -181,6 +181,7 @@ pub fn wait_interruptible_timeout<T: ?Sized, B: Backend>(
>>>>        }
>>>>        /// Calls the kernel function to notify the appropriate number of threads.
>>>> +    #[inline]
>>>>        fn notify(&self, count: c_int) {
>>> Hmm.. I think CondVar::notify() gets inlined even without this
>>> `#[inline]` attribute, do we need this actually?
>> Actualy, after add '#[inline]', the build result is (compilecmd is 'make
>> ARCH=arm64 LLVM=1-j8' ):
>>
>> $nm vmlinux | grep ' _R'.*CondVar | rustfilt
>> ffff800080019e90 T <kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::panic_cold_ex
>> plicit
>> ffff800080019e90 T <kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::panic_cold_ex
>> plicit
>> ffff800080019e90 T <kernel::sync::poll::PollCondVar>::new::{closure#0}::{closure#0}::panic_cold_e
>> xplicit
>> ffff8000805b8c7c T <kernel::sync::poll::PollCondVar as
>> core::ops::drop::Drop>::drop
>>
>>
>> And before add '#[inline]',the 'nm vmlinux | grep ' _R'.*CondVar | rustfilt'
>> appear 'notify' function,
>>
>> Seems like the LLVM didn't make it inline.
>>
> Your commit log said:
>
> ... the following symbols are generated:
>
> $nm vmlinux | grep ' _R'.*CondVar | rustfilt
> ... T <kernel::sync::condvar::CondVar>::notify_all
> ... T <kernel::sync::condvar::CondVar>::notify_one
> ... T <kernel::sync::condvar::CondVar>::notify_sync
> ... T <kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
> ... T <kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
> ... T <kernel::sync::poll::PollCondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
> ... T <kernel::sync::poll::PollCondVar as core::ops::drop::Drop>::drop
>
> so no *notify* symbol even before the patch, right? I also checked with

My bad,I mistakenly thought it was some other 'notify_*' functions,

it should be LLVM automatically inline 'notify', I will remove it in the 
next version.

> my local build, without your patch, there is still no symbol for
> notify().
>
> Regards,
> Boqun

-- 
Thanks,
   Kunwu.Chan(Tao.Chan)


