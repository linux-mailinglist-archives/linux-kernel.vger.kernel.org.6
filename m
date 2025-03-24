Return-Path: <linux-kernel+bounces-573089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DFCA6D2F5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 03:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5FE189277F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 02:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D98378F44;
	Mon, 24 Mar 2025 02:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wlm9x1M6"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E61B1362
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 02:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742782166; cv=none; b=dJTwO0BK5qoy0muFsM41TimDodA6WpNs15HcgswLJ0dGiB8utrC54wzMQR70ysnkp4fI0snQj/d2hjuNtoGQUMWK9s3Y3v5h2H1gmcEsTuMDSyWugX3M1sFND5AIe0+tg8jnodnRzbw6A46W/PDGDrdO4lXAH0Y0ppHnAg0k5nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742782166; c=relaxed/simple;
	bh=aQndsgFh0ls7ZiU3AM1Ti998DPtvCFNQqX8RJ/XTbec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9wdJ5ntsuLQ9FYJv5S6yFpSGaUlzYDFfpB0uKPT5g66dzSDZyEKyD7zCBUtMP2eLHgNovwy8rnu8tLVkAPVLdCdGTZHGCDisXId4fH+RK0wZUC3y9bEh+7hejG9MJ1zi6TcLWBa+WEagflmLPzEXppqtFxovfKP4i4SKIKypgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wlm9x1M6; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0d0b186d-6e07-4a46-b8e2-698a97796e44@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742782151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WtkT2sFPkvaRr2EpQOKnyEL8TzZftahOePw5vU1CoQs=;
	b=Wlm9x1M6ZZBe+EmmRP4KUu36JDl7bW+ukb9U42OLzSc9bg1yOhkw/CVgK6nvBvwqE+Ani5
	VGCnmBc9lSJvCe2smWf13fSajRyuhh1xLlHZUSWrijPGw02b85B1jfXihNHO0BXOGHQTFH
	zGJ3x0CVfA0U6qHhPwFbvsK4kUWg57Q=
Date: Mon, 24 Mar 2025 10:08:29 +0800
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
 <Z-BL_DFA3afcRYGE@Mac.home>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <Z-BL_DFA3afcRYGE@Mac.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/3/24 01:59, Boqun Feng wrote:
> On Mon, Mar 17, 2025 at 04:13:50PM +0800, Kunwu Chan wrote:
>> From: Kunwu Chan <kunwu.chan@hotmail.com>
>>
>> When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
>> with ARCH=arm64, the following symbols are generated:
>>
>> $nm vmlinux | grep ' _R'.*CondVar | rustfilt
>> ... T <kernel::sync::condvar::CondVar>::notify_all
>> ... T <kernel::sync::condvar::CondVar>::notify_one
>> ... T <kernel::sync::condvar::CondVar>::notify_sync
>> ... T <kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
>> ... T <kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
>> ... T <kernel::sync::poll::PollCondVar>::new::{closure#0}::{closure#0}::panic_cold_explicit
>> ... T <kernel::sync::poll::PollCondVar as core::ops::drop::Drop>::drop
>>
>> These notify* symbols are trivial wrappers around the C functions
>> __wake_up and __wake_up_sync.
>> It doesn't make sense to go through a trivial wrapper for these
>> functions, so mark them inline.
>>
>> Link: https://github.com/Rust-for-Linux/linux/issues/1145
>> Suggested-by: Alice Ryhl <aliceryhl@google.com>
>> Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
>> Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
>> Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>
>> ---
>>   rust/kernel/sync/condvar.rs | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
>> index 7df565038d7d..a826896ba3f0 100644
>> --- a/rust/kernel/sync/condvar.rs
>> +++ b/rust/kernel/sync/condvar.rs
>> @@ -181,6 +181,7 @@ pub fn wait_interruptible_timeout<T: ?Sized, B: Backend>(
>>       }
>>   
>>       /// Calls the kernel function to notify the appropriate number of threads.
>> +    #[inline]
>>       fn notify(&self, count: c_int) {
> Hmm.. I think CondVar::notify() gets inlined even without this
> `#[inline]` attribute, do we need this actually?

Actualy, after add '#[inline]', the build result is (compilecmd is 'make 
ARCH=arm64 LLVM=1-j8' ):

$nm vmlinux | grep ' _R'.*CondVar | rustfilt
ffff800080019e90 T 
<kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::panic_cold_ex
plicit
ffff800080019e90 T 
<kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::panic_cold_ex
plicit
ffff800080019e90 T 
<kernel::sync::poll::PollCondVar>::new::{closure#0}::{closure#0}::panic_cold_e
xplicit
ffff8000805b8c7c T <kernel::sync::poll::PollCondVar as 
core::ops::drop::Drop>::drop


And before add '#[inline]',the 'nm vmlinux | grep ' _R'.*CondVar | 
rustfilt' appear 'notify' function,

Seems like the LLVM didn't make it inline.


> Regards,
> Boqun
>
>>           // SAFETY: `wait_queue_head` points to valid memory.
>>           unsafe {
> [...]

-- 
Thanks,
   Kunwu.Chan(Tao.Chan)


