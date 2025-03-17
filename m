Return-Path: <linux-kernel+bounces-563889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34502A64A20
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D3C188AE37
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832FA22F17B;
	Mon, 17 Mar 2025 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w01TRXCH"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FB222257F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207596; cv=none; b=Qx8V0of/O27dkIcZSXSVNTnC2jIhPFd6Z6pQUNJgRckueqtZdGz70NuQPUIAHLF275972/uWGeyZ+P8DqFvH4ppQEvZf1+nMM7QG/O40gYw0d/gza5+v7Quq9jEMJnZYBe8rhAZcTc43PVtG0XleJ8d1N5evSD7jqpM0EQZSLnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207596; c=relaxed/simple;
	bh=wxqfJvAeKGlWHNzYJYtMeNgpJTRM7JG0J2iuiWF/RpA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VrP2zizMo2T/EHtuH3ceVnuyt25lhZYANJFjYdrLYLRKUcXF54+c0zHDlcQnTkFpoQh6xiA8xQA5mpXyBukq72BwLzsOEMTijO1TwQOMykS5FkxN1Tfs4DC0nAvjXPfFQCfjMrp7QW/K9CZx2Q2BqM2+NXqG14xuN5+5J64PCGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w01TRXCH; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43bd0586a73so11836575e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742207592; x=1742812392; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IvLoYXAbsczx0XYVJotNCJOKB5QuWZcwFTDWX8BS84g=;
        b=w01TRXCHBJr7gT9Xscr8FR6hGlfkYBDs9gMKnvu3BwlFjxtqWJEn5sLY+EimuUWIdW
         z6K37eeTxJMVtE8pXkwnaEYHbyT7pC2Q/3G264VyDwaEHUpSAtNom8nUIVF/aPo7bUx4
         lyUkEUEv9aacrR4qY8SBxgak4CPc1oQ1T6nxAvqFBmD3F66/CTNDsjE3c+OOCmSD+H1Y
         nQBS64SKGD/YBwcqfpDdBYxAPIqfVJerve3pIDaBduSZjo2Hp5XyrKYiSzxKoGuNRXGT
         pWrvY0jcpJzE30fB2vc2ok7T9sFlDuNYMFDFpCj8ZRPWdfN/Rm4Lm1W0frU/yPWiTcs8
         B4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742207592; x=1742812392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvLoYXAbsczx0XYVJotNCJOKB5QuWZcwFTDWX8BS84g=;
        b=mC4blWikXrjjtQCpzWSjDWt1P766wc9DhT4Muro6gApmAAT+78NPFCeMn9Krm4KhPr
         G9ilwI63Okt31hrNGHFvDdbKjRpECS7yO/CsCVVqk/OcXqE65xQzVhrvI0Yp2Je3YwMa
         3KPpZgeCsbT+3rsY0wfrIrkafgkR+WbfxHHvr8z4O50BV4PkHaFUtOeT4580MedR6flw
         cAuypNuUd9pk08ZkS4GogHlufg21I6te39cCvcapUycvUvIVIXThgiQx66TGJRyl+x9L
         XVDTzM7Q1Sep5FiFRjsjQFuTGMuUHE4ghc6YM1UvghsM89/BGW+Z3lOmUQt5zDzOW1Lr
         E78g==
X-Forwarded-Encrypted: i=1; AJvYcCVC3jdENIMPzcZwzh+EUDsgqfu9Cb5ZSLe/4lax0p4V6no5/Nl9pDk9t9J2GvKEDIumF6dfOKdxlpfWJ3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPro/fJewi2aVFjmeMqrEpmr40XKHz9BzGTzLFYSXW+ICHUIag
	GI3tyguIVUB8I3YeXVSoCw5CjfIG4K44pQ1/pNM9e/5JuS6oPSpRWMO47on8GD0qW/2ah8zEwl/
	CSpdDy83nxAcFIw==
X-Google-Smtp-Source: AGHT+IHGHyX+6ByhebHTO9V3LY5GS887qbOd27cikxIO2WguSKFpckY3Ttr8Dc4mg9GMsrlGAQAL0Lzpoi+1cFY=
X-Received: from wmbgz10.prod.google.com ([2002:a05:600c:888a:b0:43b:d6ca:6dd3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35c9:b0:43c:fd72:f039 with SMTP id 5b1f17b1804b1-43d1ec835e8mr138658855e9.11.1742207592764;
 Mon, 17 Mar 2025 03:33:12 -0700 (PDT)
Date: Mon, 17 Mar 2025 10:33:10 +0000
In-Reply-To: <20250317094004.2622640-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250317094004.2622640-1-kunwu.chan@linux.dev>
Message-ID: <Z9f6Zi2_eZFFY0Q7@google.com>
Subject: Re: [PATCH] rust: page:: optimize rust symbol generation for Page
From: Alice Ryhl <aliceryhl@google.com>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Kunwu Chan <kunwu.chan@hotmail.com>, 
	Grace Deng <Grace.Deng006@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Mon, Mar 17, 2025 at 05:40:04PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@hotmail.com>
> 
> When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
> with ARCH=arm64, the following symbols are generated:
> 
> $nm vmlinux | grep ' _R'.*Page | rustfilt
> ffff8000805b6f98 T <kernel::page::Page>::alloc_page
> ffff8000805b715c T <kernel::page::Page>::fill_zero_raw
> ffff8000805b720c T <kernel::page::Page>::copy_from_user_slice_raw
> ffff8000805b6fb4 T <kernel::page::Page>::read_raw
> ffff8000805b7088 T <kernel::page::Page>::write_raw
> ffff8000805b72fc T <kernel::page::Page as core::ops::drop::Drop>::drop
> 
> These Rust symbols are trivial wrappers around the C functions
> alloc_pages, kunmap_local and __free_pages.
> It doesn't make sense to go through a trivial wrapper for these
> functions, so mark them inline.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
> Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
> Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>

For sure `alloc_page` and `drop` should be inline, but the other methods
are not as simple. It is less clear that they should be inline.

At the very least, the claim that they are a trivial wrapper around
"kunmap_local" is false. They don't just call that method.

Alice

