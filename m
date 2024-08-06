Return-Path: <linux-kernel+bounces-276842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C76949914
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6AE81F21873
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41CC16F8FD;
	Tue,  6 Aug 2024 20:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cIxwze3f"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9DF16F824
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976089; cv=none; b=UFSd3F+wBocVRJXnja4qmlF6ZLfSuMhkBl/GZciVFVAdH/H0Tq1uWQip2LOfyRmIEGkcyUiQsEVQuE7pl7lor7tJvB6dXIZ+W7q9gRqE9mGF0gFsBSSCGlqdRpeSiawQc18YU84dO1CxBC079X5RjX5bMvDvMNiNyQgEQ4URsAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976089; c=relaxed/simple;
	bh=PIqwq05eeSJrJAxwn95ybQWvhk0Dn6GFtbODZZoaYKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1rSoDbAtTiwoyr8cHu1LAdptdoMWMA9f/ycOflIk1Sjzfvm+Q5fN0kKSD3a2jJ0CW+JBioeMgVJXb6l0oU3kNo+zp4GysLRN3eT6c2l5AJKSvrKaTaGHBqZrEoSXMU45ikqwjr2XBH4k+TbkmSyVgQwwoKG06MJSN4q6WCN/pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cIxwze3f; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d1cbbeeaeso800246b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 13:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722976086; x=1723580886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNJJxbMCTacBJYMokN6YIRV7m5EBShQyXf92BOxMYb0=;
        b=cIxwze3fhA0NLN5oMfEGkw+Y+xhu0TRfWOc2qTlDrGupWGFLzfyL/DX+6f9XCXLVcJ
         1Cms9JgteDFeN046O9vit8bsnW0a4LwamURs0iyyoEPod2HTK6gHhQ/wYeHxJprNBkRd
         jDMk6BkyJJAHoYYzcC5peFdhjQaFFSQTd6o+t1XlhKW4F2ooJriHHtBsZcWGGqs4Buo+
         yKWxa3wu6u20VydzceJhdt9fBbCGCrwap5PesKkuUB2WHaFmgx4wftLMjM8u32DR1Fkq
         Tw21bG/IjN0hQJes5NBLNous4M3X4HC74mhalNQhzfzyTvcxVoKQLA4dp4vF+6cU1YGI
         eLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722976086; x=1723580886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNJJxbMCTacBJYMokN6YIRV7m5EBShQyXf92BOxMYb0=;
        b=tnnV2GMpIiyw10p54nOcmzrHh38b5gKprQo7BOXP9p7jFAtBbGjA7tVPSpisf7rjIR
         84QuCcQXOwERg+H6/RPAYiru9Ta8Eeyz2DUGVJB8sf7jeSL4+jHXvOulytukIkCKPYs4
         i1nHJwpA2zP0R2XZOHeSjtROLoHA4USZL4eVY39N9Gr+txV7CiEE4DgPoR4SQLA4kfHL
         kC3+2CHgzw/x8688dTVR1byRHAFatVaBevzNplx8MqgpDJBTL3SqpeuSXywjnBbgEOkj
         xka6inz1hwIX7H5IHboceNiwkJwoDt/4JeZ8BAB0iJl/mEqpGvgHh3GzCn1fT5/BGYo8
         lndQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpg/oAMpsqtBoH82YjfDFr4GEf0rpI82ii6O5xlHhZZJ2EgI4Il/DyOUmX6b+p2a0r5HgGNjFl9tJ1QIrzMFhjEFlswYruC7rZ/f01
X-Gm-Message-State: AOJu0YxnHt/KzFR/BuCs4Syg6jz6Pbcd7x2hNMRNOfV58gsSGqoBXQdA
	/dmlC55P2Scl3jw0zH2GbOo2XruQPyxBd0AE1/M0RiyXbv9t2UBSU3afBAi9vg==
X-Google-Smtp-Source: AGHT+IFm9uhPYUcX6BBhhu0nbe6Hn1ROfYd6y3IS8Wi4xqj74fV2681KS5TuBgKc0cmX3bLcvOgaPQ==
X-Received: by 2002:a05:6a20:b910:b0:1c6:b364:dbd1 with SMTP id adf61e73a8af0-1c6b364e170mr7596007637.19.1722976085743;
        Tue, 06 Aug 2024 13:28:05 -0700 (PDT)
Received: from google.com ([2620:0:1000:2510:6419:5b4c:3008:6065])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b763562989sm7403878a12.34.2024.08.06.13.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 13:28:05 -0700 (PDT)
Date: Tue, 6 Aug 2024 13:27:58 -0700
From: Sami Tolvanen <samitolvanen@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v5] rust: support for shadow call stack sanitizer
Message-ID: <20240806202758.GA1634260@google.com>
References: <20240806-shadow-call-stack-v5-1-26dccb829154@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806-shadow-call-stack-v5-1-26dccb829154@google.com>

On Tue, Aug 06, 2024 at 10:01:44AM +0000, Alice Ryhl wrote:
> This patch adds all of the flags that are needed to support the shadow
> call stack (SCS) sanitizer with Rust, and updates Kconfig to allow
> configurations that work.
> 
> The -Zfixed-x18 flag is required to use SCS on arm64, and requires rustc
> version 1.80.0 or greater. This restriction is reflected in Kconfig.
> 
> When CONFIG_DYNAMIC_SCS is enabled, the build will be configured to
> include unwind tables in the build artifacts. Dynamic SCS uses the
> unwind tables at boot to find all places that need to be patched. The
> -Cforce-unwind-tables=y flag ensures that unwind tables are available
> for Rust code.
> 
> In non-dynamic mode, the -Zsanitizer=shadow-call-stack flag is what
> enables the SCS sanitizer.
> 
> At the time of writing, all released rustc versions up to and including
> 1.81 incorrectly think that the Rust targets aarch64-unknown-none and
> riscv64-unknown-none-elf don't support -Zsanitizer=shadow-call-stack, so
> the build will fail if you enable shadow call stack in non-dynamic mode.
> See [1] for the relevant feature request. To avoid this compilation
> failure, Kconfig is set up to reject such configurations.
> 
> Note that because these configurations are rejected, this patch only
> allows SCS to be used with arm64 and not on riscv. However, once [1] is
> implemented, I will submit a follow-up patch that allows configurations
> without UNWIND_PATCH_PAC_INTO_SCS on sufficiently new compilers. That
> patch will implicitly allow SCS to be enabled on riscv, but this is okay
> because unlike arm64, riscv does not need any flags for rustc beyond
> -Zsanitizer=shadow-call-stack.
> 
> It is possible to avoid the requirement of rustc 1.80.0 by using
> -Ctarget-feature=+reserve-x18 instead of -Zfixed-x18. However, this flag
> emits a warning during the build, so this patch does not add support for
> using it and instead requires 1.80.0 or greater.
> 
> The `depends on` clause is placed on `config RUST` to avoid a situation
> where enabling Rust silently turns off the sanitizer. Instead, turning
> on the sanitizer results in Rust being disabled. We generally do not
> want changes to CONFIG_RUST to result in any mitigations being changed
> or turned off.
> 
> Link: https://github.com/rust-lang/rust/issues/121972 [1]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Looks good to me, thanks!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

