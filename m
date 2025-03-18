Return-Path: <linux-kernel+bounces-565266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AC4A664E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488E9189DCFF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBF1140E30;
	Tue, 18 Mar 2025 01:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cg8Q+mfA"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4E927701
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742260964; cv=none; b=fq8jHv/jgMmpWxC9HgQCP1Trc3cpGp9NF030PaiGq8BT1HPERX+IXgKPFRIVjQmjMTR0jiTHuTDisgJxMNjELydz6ahziQ66VD+z8RWArxfI2Jp6hXB/NctrBVBY40JiRFJdPhgmD9qPuTlds+ogIlAAM7WUlcoxPfnCH8Ib7o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742260964; c=relaxed/simple;
	bh=r8/U/IPJWLoespvwRuDJcsnKkJLHIhLwyhXh8dkA3fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YxFBfEMHlV9LGNiu39C9MHOVQ3iVowH0WsfPGzfVK1l6O+cYR1kS6QWCuJfpqwEPcFAKSTcZ2wTJkGjMWEQZ2yAU82NjPhyApf8+swoTiHY6Pm7zd3tMM/MIsRIn49yW0kyKlEuG0AQSq1rEZJer85RsNp9mQB8daR7e2u9vpg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cg8Q+mfA; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6a852867-42b1-40ec-b2f6-3b869603c2f9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742260960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DVUIPR22yim6bsskBIwlUguvazbMUdyjRz6svgNIar8=;
	b=cg8Q+mfAGht8qZimogMX13sA0+adAHoz53ycZLkaA8Ki3L/RA/IEvRTkEGPSPY62jOXMzN
	Ph4zh69ddTZnnrvcQQyzv9yRkOLjsfDA64vN1+5zEuRHDBK201PADiyaPboXaF5jsVPCbj
	jMqVSAFsiA0mCKBkTUNelwg9e31KXwM=
Date: Tue, 18 Mar 2025 09:21:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] rust: sync: optimize rust symbol generation for CondVar
Content-Language: en-US
To: Alice Ryhl <aliceryhl@google.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Kunwu Chan <kunwu.chan@hotmail.com>, Grace Deng <Grace.Deng006@gmail.com>
References: <20250317081351.2503049-1-kunwu.chan@linux.dev>
 <Z9f5fehO186xoNAV@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <Z9f5fehO186xoNAV@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/3/17 18:29, Alice Ryhl wrote:
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
> You don't need to send a new version just for this, but please format
> the paragraphs better in the future. For example:
>
> The notify* symbols are trivial wrappers around the C functions
> __wake_up and __wake_up_sync. It doesn't make sense to go through a
> trivial wrapper for these functions, so mark them inline.

Thanks, I'll remember that, try to fill one line first and don't start a 
new one easily.

>> Link: https://github.com/Rust-for-Linux/linux/issues/1145
>> Suggested-by: Alice Ryhl <aliceryhl@google.com>
>> Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
>> Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
>> Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
-- 
Thanks,
   Kunwu.Chan


