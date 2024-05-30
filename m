Return-Path: <linux-kernel+bounces-195692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF158D5060
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14601C21F8D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEC33FB94;
	Thu, 30 May 2024 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ym5uA+he"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C172A2E620;
	Thu, 30 May 2024 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088451; cv=none; b=i0QsWnRHfMlimBctmYbsOeoyUyzMMIzpLgmMNsbGXUt3HHvGzPOyeLqBFaNEV5xd8XBDYtqzJfsfT14g2qqlV3VQdbFzTaxWlvaIaaH2N+UPB/sB5pb7XsT8DYuVDtzYAl2H76OE4AlO2jIo05plEQkkl+FKi/BLeUfET7PEOV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088451; c=relaxed/simple;
	bh=bbdJwx1WdI6hxVv7zkvFnNMBwDtodR0O+WkjCEAlr2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXfGopdgksEEm7a33YtBkTWQ9RhJx5LI4Bh8X9hRSeom8mZqFT2Sx96ja77UKcwuIF3tHeHrJOOY9ui+XvonPLGqJGzK73nMEBJhLldKMHUrV+KXQLNZW/rHqRN12GwWJhFWtf4WQB8ea+y3tj7R/z2nSXLt1JSldK5wvKy5v94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ym5uA+he; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-794ba2d4d82so55421185a.0;
        Thu, 30 May 2024 10:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717088448; x=1717693248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSxUji88N/0NxFl9gX5AHTL6yyOqY2Ahz7gjZDA3w2s=;
        b=Ym5uA+heeRTMZcRrSGGutokPsRIUohHxraqlivzO02FG2yafHsZ7YlGK8hw8HLn73d
         hty1rjlA4yzzNRwlE44Knah52SNh3ijydS0nz2IWM7XgAWlktbfVZ7NolUidL4yLEMCB
         r5H6utrA9u6MpRB3X+JZ6Rr17czar8jVyNcUDaNlYhMjTSqa8TNPtHnnkeN2S26zGC50
         P4kzwVLCHyGGLb6igtyLgVwHyc1wgpSV4fxR7MGLCvyKJu+yBtYQzCysfiSjwBhQKyNE
         5pX5ztqSObToGQeYzTCMejWDR6jBgycv5VsZFdBPugf495v18RfTN/ZKZ34YB/5NCrg0
         LcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717088448; x=1717693248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSxUji88N/0NxFl9gX5AHTL6yyOqY2Ahz7gjZDA3w2s=;
        b=T0R4GgsUwPSa9ImRlL4RcfDUYEir+A00T3GHCwLKEc4tAhjrJMiMGdQXvSAMZbbyuD
         bo0KfkS6IrZUIEvYL3ucFvvx0JNcjO+UoyUObAryQR7gjzC6eisF9oAbM5TS+EOQwEBU
         AHYuOCGgzOKXM9Fk6wJ/XfyWlNRmXezkyFvssn0WGyK6fdhV6ZJTprptsFtSrwufX9w3
         3Blb4kbaUjqbxoYTlOJsokWGeziAhF5jNyHyMgk44oRmLRCiQ2WmzTGUM0M72tjv3+zl
         QaRSEqoYCjbryFVBEJTJskjYQ4elQa4FD/i96dsmqyHFGIILnoYzTb6AeGTFwBQbjY2J
         RJcg==
X-Forwarded-Encrypted: i=1; AJvYcCUe09rulD3i7Q0/cmCzlKtN/qgqae50/hYl7gq1QJFR1h6YF2EybmcM2zCnp3tT0nU/2SelyEs2n5/tXzRsLdD6MSYw/FXlM7XjtDBfafC5p+Uc8E94GDmeOEj1B+SZD4uvJBB/krGkIWKXYo4=
X-Gm-Message-State: AOJu0YzWEnqQEC25uLA+3FG76mtLjDtEzzAlL+Ag73J+CQO+6/YhAfZ/
	rtM1xojb4KS9MTATKsxLqESBuLBg08pgx86wjmdzq+ykLKVlYaid
X-Google-Smtp-Source: AGHT+IHwxOQVjX4jjMP5xINeb0ZRE7/H4u3Ev9hJuE7HJA0tJskyy/XS+vI2s8I6LF4ZaPYlPA+CLw==
X-Received: by 2002:a05:620a:210b:b0:794:99f3:d407 with SMTP id af79cd13be357-794e9da1730mr288097885a.19.1717088448277;
        Thu, 30 May 2024 10:00:48 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abcd9673sm560623285a.55.2024.05.30.10.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 10:00:47 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id E8A291200082;
	Thu, 30 May 2024 13:00:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 30 May 2024 13:00:46 -0400
X-ME-Sender: <xms:vrBYZp5KRn6Yokrmm4wUm8MbLiDC2d2vDB34oYRw-8gseOQ-u3xAQw>
    <xme:vrBYZm7VlQBIPFw_6yc8qpiFkcBDzved8K32D9x63EutaKeI3SV53a2ru7JVcWPRS
    Qe90z7fLTHh4s4gWQ>
X-ME-Received: <xmr:vrBYZgcMVfpUQ74zHxzzVgKZM5QMp_1mromfpYUDowwJWgwduOi7lGPKTTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:vrBYZiLVW2wH-IWwI4iJ3qIkVixnuJ33bEe0hbyC6OgmmnlXqQtFRg>
    <xmx:vrBYZtIPMtjYzViOTIKer1KuHoFXaKwa2EhHxeOsYUmVsp0CfdAUiA>
    <xmx:vrBYZrwEBjqOnwSGWM4O6vcH6zacpSfL_OXiVkmSfgoCmhqiN0bH1g>
    <xmx:vrBYZpJ9vvRL5BtBH6BEIfilMhuVETT94Lq5OSKBS05-3znEN6hjfQ>
    <xmx:vrBYZgZwNcEGSZh2yW_WcnB51C1Fb65gEeMQqO0a7KBH9hLGayeOq1Ye>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 13:00:45 -0400 (EDT)
Date: Thu, 30 May 2024 10:00:00 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org, rust-for-linux@vger.kernel.org,
	x86@kernel.org, Wedson Almeida Filho <wedsonaf@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH] arch: um: rust: Use the generated target.json again
Message-ID: <ZliwkPY-psgVNhZY@boqun-archlinux>
References: <20240529093336.4075206-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529093336.4075206-1-davidgow@google.com>

On Wed, May 29, 2024 at 05:33:35PM +0800, David Gow wrote:
> The Rust compiler can take a target config from 'target.json', which is
> generated by scripts/generate_rust_target.rs. It used to be that all
> Linux architectures used this to generate a target.json, but now
> architectures must opt-in to this, or they will default to the Rust
> compiler's built-in target definition.
> 
> This is mostly okay for (64-bit) x86 and UML, except that it can
> generate SSE instructions, which we can't use in the kernel. So
> re-instate the custom target.json, which disables SSE (and generally
> enables the 'soft-float' feature). This fixes the following compile
> error:
> 
> error: <unknown>:0:0: in function _RNvMNtCs5QSdWC790r4_4core3f32f7next_up float (float): SSE register return with SSE disabled
> 
> Fixes: f82811e22b48 ("rust: Refactor the build target to allow the use of builtin targets")
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  arch/x86/Makefile.um | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
> index 2106a2bd152b..a46b1397ad01 100644
> --- a/arch/x86/Makefile.um
> +++ b/arch/x86/Makefile.um
> @@ -9,6 +9,7 @@ core-y += arch/x86/crypto/
>  #
>  ifeq ($(CONFIG_CC_IS_CLANG),y)
>  KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
> +KBUILD_RUSTFLAGS += --target=$(objtree)/scripts/target.json
>  KBUILD_RUSTFLAGS += -Ctarget-feature=-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-avx,-avx2
>  endif
>  
> -- 
> 2.45.1.288.g0e0cd299f1-goog
> 

