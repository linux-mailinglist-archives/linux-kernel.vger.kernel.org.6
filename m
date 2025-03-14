Return-Path: <linux-kernel+bounces-560633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DE2A60785
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45154177819
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 02:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F0935893;
	Fri, 14 Mar 2025 02:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k0cT0AAo"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA922E3364
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741919661; cv=none; b=hriV1xeKM7v01S5Cjri6tMTkKcBYSaLJZuoSqP3rDLitcbjVxbCTKL+oMNbYIlUBFClwyZJ3hT3SPeKiIuI6Tlnc8PgEMAkdvfCWcmG29PDSsx/aDVGf7/4nPvMoyQNWKzPAVzFQGycmfc5BhcZwZG0Kp5GZ+NCjb7UJtvpOkSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741919661; c=relaxed/simple;
	bh=MJbZjBYRRxLsko3DCRXwP/Ob7hw+eq3uF70OQmbeR2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fc9S84E1gd5T9+QNteKGTk+jaB/Yn7qjtxT3ULl54SzEF9RIkxjqWaHQiCRUqgfxlNbCnclVUM2/OsX4F1wbnT6gG4iQM/NBY0ZOF6DWX0mEKHJ422r/4Av9TITKd4iTWkf5F6nmpYOqWwnPZfJKooMC1m9IZ0LEjKXHkL9j4yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k0cT0AAo; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6c874a4f-439e-4ab2-807d-d0f59b9fe569@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741919645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yqL1Zi4/6PZhtmhssx/6TvDWFYb0gRlk77dWOUqI3Zk=;
	b=k0cT0AAorSL11q5p/K6C6bCBPkfT482NrjJM76iCAEysMUjCe8gRZXjY+G1rA0fAheDrxv
	wvWEldj35n+FWNYPJgXoSa69rIETkveLkLXZCTvINSBFc6Lahd0iEm9PsGzwjFXajuElnd
	bu1Wxsg7m92DlJ8Ck6FzX9Uliod+UYI=
Date: Fri, 14 Mar 2025 10:33:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] rust: file: optimize rust symbol generation for
 FileDescriptorReservation
Content-Language: en-US
To: Alice Ryhl <aliceryhl@google.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Kunwu Chan <kunwu.chan@hotmail.com>, Grace Deng <Grace.Deng006@gmail.com>
References: <20250313084525.773620-1-kunwu.chan@linux.dev>
 <Z9K3vokYu5osMCwh@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <Z9K3vokYu5osMCwh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2025/3/13 18:47, Alice Ryhl wrote:
> On Thu, Mar 13, 2025 at 04:45:25PM +0800, Kunwu Chan wrote:
>> From: Kunwu Chan <kunwu.chan@hotmail.com>
>>
>> When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
>> with ARCH=arm64, the following symbols are generated:
>>
>> $ nm vmlinux | grep ' _R'.*FileDescriptorReservation | rustfilt
>> ffff8000805b6ef0 T <kernel::fs::file::FileDescriptorReservation>
>> 						::fd_install
>> ffff8000805b6e60 T <kernel::fs::file::FileDescriptorReservation>
>> 						::get_unused_fd_flags
>> ffff8000805b6f08 T <kernel::fs::file::FileDescriptorReservation
>> 					 as core::ops::drop::Drop>::drop
>>
>> These Rust symbols are trivial wrappers around the C functions
>> fd_install, put_unused_fd and put_task_struct.It
>> doesn't make sense to go through a trivial wrapper for these
>> functions, so mark them inline.
>>
>> After doing so, the above symbol will not in output.
>>
>> Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>
>> Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
>> Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
> A few notes:
>
> * Your own Signed-off-by must always be last.
> * You're missing Link: and Suggested-by: tags.

Thanks for the reply.

I'll change my own Signed-off-by be last and add Link and Suggested-by 
as the following:

Link: https://github.com/Rust-for-Linux/linux/issues/1145
Suggested-by: Alice Ryhl <aliceryhl@google.com>
Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>

> * There are some grammar issues, e.g. a missing space before "It" and
>    the phrase "will not in output" is not good.
I'll  add a space before "It" and remove the last line.
> * Let's also add the marker to `reserved_fd` to be on the safe side.
Sure, I'll make 'reserved_fd ' inline in v2.
> * I think it is easier to read the symbols if you list each sybmol on
>    one line like this:
>
> ffff8000805b6ef0 T <kernel::fs::file::FileDescriptorReservation>::fd_install
> ffff8000805b6e60 T <kernel::fs::file::FileDescriptorReservation>::get_unused_fd_flags
> ffff8000805b6f08 T <kernel::fs::file::FileDescriptorReservation as core::ops::drop::Drop>::drop

If in one line, checkpatch.pl will report a warning:

WARNING:Prefer a maximum 75 chars per line (possible unwrapped commit 
description?)

If no need to  bother with the warning, I'll change it to one line in v2.

>
> Alice



-- 
Thanks,
   Kunwu.Chan(Tao.chan)


