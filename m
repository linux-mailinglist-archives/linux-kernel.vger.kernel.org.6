Return-Path: <linux-kernel+bounces-563229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD2DA63A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 02:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625AC3A5551
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 01:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF03984A2B;
	Mon, 17 Mar 2025 01:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zj5It0Pj"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C3481B1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 01:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742174850; cv=none; b=oMvtPz9YnesOnQaDj0unyiHo+FCx36UTJVmTp+I+Isc9wRjotBFrAzKkj1GG0moIe/WvifawnUl/PMgxec/Iy8zBgwzRpOzR9moLfE/aOb6OqKvPvheY8s5spXBrIDZx8vQZqjXbILpDV+pAFqFPSSDBJUQkn06p1lYbJHME65A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742174850; c=relaxed/simple;
	bh=t+bHbAqt0/x0swFV522Yl4VosXMAhw6VzZ3OgIf3mmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKTOLI+UavbQEGlFX/F2WSjqFDjQ19RoFuir0dR1cfOicmKoZ39lPTLJ3OReQdh7mvaXydLJXzdynWFfX4CKTbfJczgRWB4ExvwkgDIGgZl1GSFTC+ECImHRxDcBdBr0xJIiozApe36T/F0VKf/tkA/AWVpTPp2tDpy5YUK13fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zj5It0Pj; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7c949bef-1957-4a1d-b75f-9f642f8c848d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742174845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rjk2EB6B1VDjQml7YtpwBw8uSvBgCyIRa4CuzWf9SSI=;
	b=Zj5It0PjSwe+CJGBHr97bwnRtv6tZUz9TgUtP5Adc1iau/NRZ5gG6tIzufHjMMqrJL8iiB
	Opo4o8t6O+eQX3tCU5feCYqB2fdzwyUS1Sypf9Eo0fZzFsfpOPJuCvlAtuHDdBfLH9C8vE
	sOseEcnIOAvrAAowNsPOhdcA3otIFZA=
Date: Mon, 17 Mar 2025 09:26:32 +0800
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
 <6c874a4f-439e-4ab2-807d-d0f59b9fe569@linux.dev>
 <CAH5fLgjErD9r8h_tjekZ+sNNDmkU3J3kcSmCG+Mew+-6zQq8tA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <CAH5fLgjErD9r8h_tjekZ+sNNDmkU3J3kcSmCG+Mew+-6zQq8tA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2025/3/14 17:21, Alice Ryhl wrote:
> On Fri, Mar 14, 2025 at 3:34 AM Kunwu Chan <kunwu.chan@linux.dev> wrote:
>>> * I think it is easier to read the symbols if you list each sybmol on
>>>     one line like this:
>>>
>>> ffff8000805b6ef0 T <kernel::fs::file::FileDescriptorReservation>::fd_install
>>> ffff8000805b6e60 T <kernel::fs::file::FileDescriptorReservation>::get_unused_fd_flags
>>> ffff8000805b6f08 T <kernel::fs::file::FileDescriptorReservation as core::ops::drop::Drop>::drop
>> If in one line, checkpatch.pl will report a warning:
>>
>> WARNING:Prefer a maximum 75 chars per line (possible unwrapped commit
>> description?)
>>
>> If no need to  bother with the warning, I'll change it to one line in v2.
> You could do this:
> ... T <kernel::fs::file::FileDescriptorReservation>::fd_install
> but if it's still too long I'd just ignore it.

Thanks, I'll change it in v2.

>
> Alice

-- 
Thanks,
   Kunwu.Chan


