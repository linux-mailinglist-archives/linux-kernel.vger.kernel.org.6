Return-Path: <linux-kernel+bounces-276665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE6D9496B3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C458328803D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186D852F9B;
	Tue,  6 Aug 2024 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehnhhqF9"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FE444376;
	Tue,  6 Aug 2024 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965305; cv=none; b=cElzNf1uIjsTbsqSvtJFSVoNdcoeA6z8/RXgxFKvlbim3mXFBWF33+HMzLjtokiXyn3LAhJOIsbsy/XjhtwDMzTAVUHS1EqEkpDrewcA+WnjzH/Jmwe0kfPvgMq3Ta+kpO+FA2BlE33vTq/EutzCsNh/6cptTIq3lu6NBxaps7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965305; c=relaxed/simple;
	bh=WOQzR1oQzYIbVgPmprQSRRrJW2JnPO/HsIpHRpW9kFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEyWqUjROYCZDeOqmkIQtJAz02p5N6Me60o2BeT1S9LSUODoSI4/U71fRx1j9B+V2SXcE1oBOWPcTiBnzP2U/+ngw6R+KCabs82ipna6b+c5f5YVHxG1SKL4+2mRmNL3s543+mHRWf3K+TU4XeBUuP2Ry69cFEaZvPFN4yAueVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehnhhqF9; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-493e8ef36b4so263040137.2;
        Tue, 06 Aug 2024 10:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722965302; x=1723570102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9vnUaR6wRRGopZQQHqDc26o4aOyMH38ZUHe9FK1Kw0=;
        b=ehnhhqF9RG1z3rXw8UXp3kI8kkB0XLj2sPQZjmGGyeSTXeGTz6LQSzch6SwKoy/ipl
         eiR27SGgdynaMI104Eg/TG/xZvW3yZu6U07MHpRGOXFMtUNY4ofDnyj6hqKmQZweP43+
         6CueozjnRS2XLNnJuTIaQnEpdVuOuw55CqQrSGbluUYSmCBfHTcoQFl6p6tZ6YL/IvAz
         2oVEl1IdLLlI/HKJ4/2q9gsRWDtxWsfduuK4Zp28D64qUQa3rh/tzHYzqLT4qj2Ay9so
         D0lUGPmiuRmvzKl5mGZI8Clt1SAWWJ+dhcQzvTdNdiy1JpGQ1Y1dHutard0FH223zwqN
         cYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722965302; x=1723570102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9vnUaR6wRRGopZQQHqDc26o4aOyMH38ZUHe9FK1Kw0=;
        b=HLWtIP7prJu1Ana4CXFdKqtz/IR9kLodloyhT1U81kt6H4qPYO9vAM1UfeyAtSaDno
         fI9vyJjDRraX0Oao+8nwms/J0dVxEarLR8U95O70kf5zNZ4Bd+QQt7Bb9JLm6YOEd3KA
         6FvxWKyszvdhPX9zJU7q28UGWX1Xb3IdMsDppM4sr5azQt9ajyIM86LTPnlON3V9u54u
         VtI2LoitcfkS4pM9brWuHi/RKvT/kp52/sLEMIExNttnUIC0KLxQJKidXsKyG/kj5Ure
         H1c8IhEYGwLKYn3wkGjCf79fAyV/PPaqKgLf0b35vd3WNofEWPdT7Qipv7CjDgCp21dc
         9B8A==
X-Forwarded-Encrypted: i=1; AJvYcCX7k+lJNsqnJCpAxT+mrTvIwVGWVQyIMmwxyXWXUTb0U/3QeoRAkSM7Beo+ec28lGCMvrBUhxm8oziAtLm/IbHE9Gtj29ki6b9p3eW1rCNFmA3i+z+IhzUt+BE+mwFe/ItLAS1n3b0n3QP+JKg=
X-Gm-Message-State: AOJu0YyXrMoNHhSUnghvdSgz8w8puihT4m+FZB6ttubFuNOVF1L++nm1
	AD0uaRKVL6eLJlooSezX+EEmUZa+OM7echE8maERrxeKz/IExrM9
X-Google-Smtp-Source: AGHT+IFB0y+M9Oc1CoQ2lVXqpIciFEC2ygrvj68zOxkubs8DCO/oCBgJk2Lkrlac1mnmzqIBMfk1LQ==
X-Received: by 2002:a05:6102:d8f:b0:493:b0c2:ad3c with SMTP id ada2fe7eead31-4945bed096cmr22410368137.22.1722965302554;
        Tue, 06 Aug 2024 10:28:22 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f78adb9sm476610385a.124.2024.08.06.10.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:28:22 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 93BB2120006C;
	Tue,  6 Aug 2024 13:28:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 06 Aug 2024 13:28:21 -0400
X-ME-Sender: <xms:NV2yZmTgAfArMt_wJJkvCxUWMVmunu0_1RzDmDKQjyukMQQ_d26n_w>
    <xme:NV2yZrx-jLx9AwBqc8Dc4O43XVvvR_msuY7YNLypTsuYPQFxF1BURctuHCGI8dNOq
    ns6KYCDx1lQcXA3AQ>
X-ME-Received: <xmr:NV2yZj02X1ZSeUoz93Esk081oi2Ba7MUbgnuyXccDm3UDJXI9zI9lL4B0FqrYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeejtefftdfgueehgffhkedttddtgeetvdeukeetueeggffhhefffeeuledu
    ieefveenucffohhmrghinhepiihulhhiphgthhgrthdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsoh
    hquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghr
    tghpthhtoheptd
X-ME-Proxy: <xmx:NV2yZiBSZHz0bPQPUDlVFu7n_p7HPyTH4EMdQjWUcGfX4HY0uqTO_w>
    <xmx:NV2yZvh7Q8oW-2gPrkKx2-i5lg4nI-YiOnF_V5zsRg-Dv-mfRTavyw>
    <xmx:NV2yZuo0o5kY3gFa1uPlG-GbIbs9xpPKsMS3EBpnTajOSWcxVn8fAw>
    <xmx:NV2yZihVXTLC5o_N11UoEGXMN3gsV2T3hBPkMx0jrtN30eUpChlF2g>
    <xmx:NV2yZuT-z4U_qa3jMXw1-jX6yQV5cfFU4LM1zBzBvyQzpaE1coidt9hP>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 13:28:20 -0400 (EDT)
Date: Tue, 6 Aug 2024 10:27:17 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] rust: add intrinsics to fix `-Os` builds
Message-ID: <ZrJc9UE3xAV1ezdG@boqun-archlinux>
References: <20240806150619.192882-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806150619.192882-1-ojeda@kernel.org>

On Tue, Aug 06, 2024 at 05:06:19PM +0200, Miguel Ojeda wrote:
> Alice reported [1] that an arm64 build failed with:
> 
>     ld.lld: error: undefined symbol: __extendsfdf2
>     >>> referenced by core.a6f5fc5794e7b7b3-cgu.0
>     >>>               rust/core.o:(<f32>::midpoint) in archive vmlinux.a
>     >>> referenced by core.a6f5fc5794e7b7b3-cgu.0
>     >>>               rust/core.o:(<f32>::midpoint) in archive vmlinux.a
> 
>     ld.lld: error: undefined symbol: __truncdfsf2
>     >>> referenced by core.a6f5fc5794e7b7b3-cgu.0
>     >>>               rust/core.o:(<f32>::midpoint) in archive vmlinux.a
> 
> Rust 1.80.0 or later together with `CONFIG_CC_OPTIMIZE_FOR_SIZE=y`
> is what triggers it.
> 
> In addition, x86_64 builds also fail the same way.
> 
> Similarly, compiling with Rust 1.82.0 (currently in nightly) makes
> another one appear, possibly due to the LLVM 19 upgrade there:
> 
>     ld.lld: error: undefined symbol: __eqdf2
>     >>> referenced by core.20495ea57a9f069d-cgu.0
>     >>>               rust/core.o:(<f64>::next_up) in archive vmlinux.a
>     >>> referenced by core.20495ea57a9f069d-cgu.0
>     >>>               rust/core.o:(<f64>::next_down) in archive vmlinux.a
> 
> Gary adds [1]:
> 
> > Usually the fix on rustc side is to mark those functions as `#[inline]`
> >
> > All of {midpoint,next_up,next_down} are indeed unstable functions not
> > marked as inline...
> 
> Fix all those by adding those intrinsics to our usual workaround.
> 
> Cc: Gary Guo <gary@garyguo.net>
> Reported-by: Alice Ryhl <aliceryhl@google.com>
> Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/v6.2E11-rc1.20doesn't.20build.20for.20arm64/near/455637364
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Put this one into rust-dev and confirm this could fix the issue with
Rust 1.80. I also add a test with CONFIG_CC_OPTIMIZE_FOR_SIZE=y in my
rust-dev script, so we can catch the similar issues earlier.

Tested-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  rust/Makefile             | 4 ++--
>  rust/compiler_builtins.rs | 3 +++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/Makefile b/rust/Makefile
> index 1f10f92737f2..77836388377d 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -354,8 +354,8 @@ rust-analyzer:
>  		$(if $(KBUILD_EXTMOD),$(extmod_prefix),$(objtree))/rust-project.json
>  
>  redirect-intrinsics = \
> -	__addsf3 __eqsf2 __gesf2 __lesf2 __ltsf2 __mulsf3 __nesf2 __unordsf2 \
> -	__adddf3 __ledf2 __ltdf2 __muldf3 __unorddf2 \
> +	__addsf3 __eqsf2 __extendsfdf2 __gesf2 __lesf2 __ltsf2 __mulsf3 __nesf2 __truncdfsf2 __unordsf2 \
> +	__adddf3 __eqdf2 __ledf2 __ltdf2 __muldf3 __unorddf2 \
>  	__muloti4 __multi3 \
>  	__udivmodti4 __udivti3 __umodti3
>  
> diff --git a/rust/compiler_builtins.rs b/rust/compiler_builtins.rs
> index bba2922c6ef7..f14b8d7caf89 100644
> --- a/rust/compiler_builtins.rs
> +++ b/rust/compiler_builtins.rs
> @@ -40,16 +40,19 @@ pub extern "C" fn $ident() {
>  define_panicking_intrinsics!("`f32` should not be used", {
>      __addsf3,
>      __eqsf2,
> +    __extendsfdf2,
>      __gesf2,
>      __lesf2,
>      __ltsf2,
>      __mulsf3,
>      __nesf2,
> +    __truncdfsf2,
>      __unordsf2,
>  });
>  
>  define_panicking_intrinsics!("`f64` should not be used", {
>      __adddf3,
> +    __eqdf2,
>      __ledf2,
>      __ltdf2,
>      __muldf3,
> 
> base-commit: de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
> -- 
> 2.46.0
> 
> 

