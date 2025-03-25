Return-Path: <linux-kernel+bounces-574684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4E0A6E876
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 04:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6233B17229B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B6718C93C;
	Tue, 25 Mar 2025 03:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PUu+TYpj"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC1D1494D8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 03:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742871765; cv=none; b=VF8FWH37pkRzoyavijCTsDryQsxuFpDmpS8J2918xgB/aWxs774rodUx0AfLdRcdiZGhtMaAMwovqsA18OCeG46V+qql+fLObKDB0XmJDUd/U3qEQBok//ZTP2rqU+/W4JckD2BTREhJSu8pn3fOeeGXqR2/zYqUkF1aqm6JuWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742871765; c=relaxed/simple;
	bh=p+6PwRCtOXKT7ZJv96aTDIh/LRMyr3o7sI/Y1/kJn5I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=t8Mn2k9KuUTsSqxbXzxwptCEOIbAQ2tZnwZA5Y1BC4sHUywrL45jBoOp21+yGlRzKzXHqMTViiA+wdCB6UZGOx7Duiz66p2bxqTDxA/uJ5T61iqGyX9OLUS+73tqwTdUsUfXjs2iZrMnFhW6uQH7SL7jH7TJEtWfocXyJNabJz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PUu+TYpj; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <52e7d34e-cf86-40d6-a294-b318df98d72a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742871760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGGsd72H09Ek4y5Nasx3ldah0+WIfjmF4R9A3El2Gqs=;
	b=PUu+TYpjV89j/VYrhe12ry4OhxeGSCw5aIZ3H1/JBah4h8SPGbDBX7xlgwnNaSRF5bdnYw
	Ex9q8FoYlmI6FH0MWym2+K6fCdyFdznFmZChjy6qVGWvCS80saUwOh3nqhlOa2H05nGVua
	/ha1F1sMacAizT5OrurYNI8iWw7xMGc=
Date: Tue, 25 Mar 2025 11:01:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
Subject: Re: [PATCH v2] rust: sync: optimize rust symbol generation for
 CondVar
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
 morbo@google.com, justinstitt@google.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Kunwu Chan <kunwu.chan@hotmail.com>, Grace Deng <Grace.Deng006@gmail.com>
References: <20250324061835.1693125-1-kunwu.chan@linux.dev>
 <CANiq72=KjT8HRJA0NStHeqm-9286gay496CU8edNALPQ9_N+ww@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANiq72=KjT8HRJA0NStHeqm-9286gay496CU8edNALPQ9_N+ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2025/3/24 17:37, Miguel Ojeda wrote:
> On Mon, Mar 24, 2025 at 7:19 AM Kunwu Chan<kunwu.chan@linux.dev> wrote:
>> Link:https://github.com/Rust-for-Linux/linux/issues/1145
>> Suggested-by: Alice Ryhl<aliceryhl@google.com>
> Nit: I typically use Link after Suggested-by, to mimic what the docs
> require about Reported-by with Link. (No need to resend a new version
> just for this :)
Thanks for the kind reminder, I'll follow this next time
>> - Remove '#[inline]' for notify()
> It is good that the commit matches the log now, though I wonder if in
> the future we may want the `#[inline]` for `notify` anyway, even if
> LLVM does that one on its own today.
Now, the default '-Copt-level' is 2 when define 
'CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE',
and in  KBUILD_RUSTFLAGS the  '-Ccodegen-units' is 1.

So if the config not change, the result should be the same.

And the actualy compile steps for rust/kernel.o is as following:

make -f ./scripts/Makefile.build obj=rust
# RUSTC L rust/kernel.o
OBJTREE=/media/kunwuchan/68d922f3-5dde-45b0-af93-c45ba81d85ef/linux-next 
rustc --edition=2021 -Zbinary_dep_depinfo=y -Astable_features 
-Dnon_ascii_idents -Dunsafe_op_in_unsafe_fn -Wmissing_docs 
-Wrust_2018_idioms -Wunreachable_pub -Wclippy::all 
-Wclippy::ignored_unit_patterns -Wclippy::mut_mut 
-Wclippy::needless_bitwise_bool -Wclippy::needless_continue 
-Aclippy::needless_lifetimes -Wclippy::no_mangle_with_rust_abi 
-Wclippy::undocumented_unsafe_blocks 
-Wclippy::unnecessary_safety_comment -Wclippy::unnecessary_safety_doc 
-Wrustdoc::missing_crate_level_docs -Wrustdoc::unescaped_backticks 
-Cpanic=abort -Cembed-bitcode=n -Clto=n -Cforce-unwind-tables=n 
-Ccodegen-units=1 -Csymbol-mangling-version=v0 -Crelocation-model=static 
-Zfunction-sections=n -Wclippy::float_arithmetic 
--target=aarch64-unknown-none-softfloat -Cforce-unwind-tables=n 
-Zbranch-protection=bti,pac-ret -Copt-level=2 -Cdebug-assertions=y 
-Coverflow-checks=y -Cforce-frame-pointers=y -Cdebuginfo=1 
@./include/generated/rustc_cfg --extern ffi --extern pin_init --extern 
build_error --extern macros --extern bindings --extern uapi 
--emit=dep-info=rust/.kernel.o.d --emit=obj=rust/kernel.o 
--emit=metadata=rust/libkernel.rmeta --crate-type rlib -L./rust 
--crate-name kernel rust/kernel/lib.rs --sysroot=/dev/null
# EXPORTS rust/exports_kernel_generated.h
   llvm-nm -p --defined-only rust/kernel.o | awk '$2~/(T|R|D|B)/ && 
$3!~/__cfi/ && $3!~/__odr_asan/ { printf "EXPORT_SYMBOL_RUST_GPL(%s);
",$3 }' > rust/exports_kernel_generated.h

> Cheers,
> Miguel

-- 
Thanks,
   Kunwu.Chan(Tao.Chan)


