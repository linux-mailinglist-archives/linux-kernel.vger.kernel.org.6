Return-Path: <linux-kernel+bounces-565347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B3CA66655
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A30237A9F59
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7E61537C6;
	Tue, 18 Mar 2025 02:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mMEPE/Ic"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D3A4A1C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742265098; cv=none; b=mynJQ8dJqoXg1DvT8QE/B3N7edXHPhs7EX8P2eI3ZJ/X4Zaf0R952NZlmvYnGJzkrjNqrdDP4IZMzzRwraxLHcc4KU10hdvSCTVeqEDEu3E9y/ARxAXQfRWeM9R0N+cEPl723+B5+wQGo8or7oARjMfQrZey5oXlVSVt/qmfY6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742265098; c=relaxed/simple;
	bh=vQSLBLyCtrqqUbnB9Jd0JSErcOJ4DeaiJqq0yJ11DkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IeAHjA2fd+mFe9Wp7cFh7UKsTsF8NrExE7mnDSFW/Xz81xRkbRx61QZCwNLEBuCowrhPiYFs6aCsZthIl5qoTIBF3TImkb7fwmEPvBdTdol1kjy7Q4iLbTdF2NQ9VjNEFCArnU5mbP67Zd3mCESp6alPJAQ3LOTb+YaEn3jgXNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mMEPE/Ic; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0a5408e8-aefc-4e2d-8329-094e17484890@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742265093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SU2F01MONWPqBi1tnAE5cvFx2suDORnQGe0qTDWa2ig=;
	b=mMEPE/IcX9CFHq0GR13rSHzBVER0hj/KRdTXlwaI/sf+0uAPAGvCznEhsgqhsaVMNpwLQc
	MgPkV9Q2yncaSIvaYk5sEfvv2iWqOQHntbNNpUQaJwLd/B9PVx3SPqoClEE+ULlIfAyU/N
	dvSO8hkn6ZLUvOLp+ujuYfftjvPg2Y0=
Date: Tue, 18 Mar 2025 10:30:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] rust: page:: optimize rust symbol generation for Page
Content-Language: en-US
To: Alice Ryhl <aliceryhl@google.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Kunwu Chan <kunwu.chan@hotmail.com>, Grace Deng <Grace.Deng006@gmail.com>
References: <20250317094004.2622640-1-kunwu.chan@linux.dev>
 <Z9f6Zi2_eZFFY0Q7@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <Z9f6Zi2_eZFFY0Q7@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2025/3/17 18:33, Alice Ryhl wrote:
> On Mon, Mar 17, 2025 at 05:40:04PM +0800, Kunwu Chan wrote:
>> From: Kunwu Chan <kunwu.chan@hotmail.com>
>>
>> When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
>> with ARCH=arm64, the following symbols are generated:
>>
>> $nm vmlinux | grep ' _R'.*Page | rustfilt
>> ffff8000805b6f98 T <kernel::page::Page>::alloc_page
>> ffff8000805b715c T <kernel::page::Page>::fill_zero_raw
>> ffff8000805b720c T <kernel::page::Page>::copy_from_user_slice_raw
>> ffff8000805b6fb4 T <kernel::page::Page>::read_raw
>> ffff8000805b7088 T <kernel::page::Page>::write_raw
>> ffff8000805b72fc T <kernel::page::Page as core::ops::drop::Drop>::drop
>>
>> These Rust symbols are trivial wrappers around the C functions
>> alloc_pages, kunmap_local and __free_pages.
>> It doesn't make sense to go through a trivial wrapper for these
>> functions, so mark them inline.
>>
>> Link: https://github.com/Rust-for-Linux/linux/issues/1145
>> Suggested-by: Alice Ryhl <aliceryhl@google.com>
>> Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
>> Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
>> Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>
> For sure `alloc_page` and `drop` should be inline, but the other methods
> are not as simple. It is less clear that they should be inline.
>
> At the very least, the claim that they are a trivial wrapper around
> "kunmap_local" is false. They don't just call that method.

Yes, I'm not sure if that's the case, cause there are more layers of 
nesting and it's more complex.

 From objdump, it can be seen that LLVM will currently inline according 
to the 'inline' mark.

$aarch64-linux-gnu-objdump -d vmlinux | rustfilt | grep -A 20 
"kernel::page::"
ffff8000805b6f6c <kernel::page::page_align>:
ffff8000805b6f6c:       d503245f        bti     c
ffff8000805b6f70:       b13ffc08        adds    x8, x0, #0xfff
ffff8000805b6f74:       54000062        b.cs    ffff8000805b6f80 
<kernel::page::page_align+0x14>  // b.hs,
b.nlast
ffff8000805b6f78:       9274cd00        and     x0, x8, #0xfffffffffffff000
ffff8000805b6f7c:       d65f03c0        ret
ffff8000805b6f80:       d503233f        paciasp
ffff8000805b6f84:       a9bf7bfd        stp     x29, x30, [sp, #-16]!
ffff8000805b6f88:       910003fd        mov     x29, sp
ffff8000805b6f8c:       d0006420        adrp    x0, ffff80008123c000 
<core::unicode::unicode_data::white_sp
ace::WHITESPACE_MAP+0x6756>
ffff8000805b6f90:       910b6000        add     x0, x0, #0x2d8
ffff8000805b6f94:       97e98ac3        bl      ffff800080019aa0 
<core::panicking::panic_const::panic_const
_add_overflow>

ffff8000805b6f98 <<kernel::pci::Device>::as_raw>:
ffff8000805b6f98:       d503245f        bti     c
ffff8000805b6f9c:       f9400008        ldr     x8, [x0]
ffff8000805b6fa0:       f1031d1f        cmp     x8, #0xc7
ffff8000805b6fa4:       54000069        b.ls    ffff8000805b6fb0 
<<kernel::pci::Device>::as_raw+0x18>  // b
.plast
ffff8000805b6fa8:       d1032100        sub     x0, x8, #0xc8
ffff8000805b6fac:       d65f03c0        ret
ffff8000805b6fb0:       d503233f        paciasp
ffff8000805b6fb4:       a9bf7bfd        stp     x29, x30, [sp, #-16]!
ffff8000805b6fb8:       910003fd        mov     x29, sp
ffff8000805b6fbc:       b0006420        adrp    x0, ffff80008123b000 
<core::unicode::unicode_data::white_sp
ace::WHITESPACE_MAP+0x5756>


Either we commits and merges the 'alloc_page' and 'drop' first.

I'll change it in the v2 version.

>
> Alice

-- 
Thanks,
   Kunwu.Chan


