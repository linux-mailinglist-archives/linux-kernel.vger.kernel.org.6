Return-Path: <linux-kernel+bounces-210650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D979046C4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 00:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A0C1F2668B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051441552E1;
	Tue, 11 Jun 2024 22:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d97d9fIL"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E670720314;
	Tue, 11 Jun 2024 22:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718143725; cv=none; b=RY1Bob4Zpe2962tBH/AMumpQvDN0LhXaktIvwdX9RVBaeq8SUkhSZGMowAkhsxv859+E1zFeBaZekVkS3t6ydu3jWWPa/rjpCljPpiGmEWb1QqUNV6yWycGQy7oUb75XCjCL/FiJGh8lLx5rLDkoDBtrbgFBbR6Svtij0DzyxmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718143725; c=relaxed/simple;
	bh=xDAi/LehtiGuKcebgCW9P5JNBdnm/nWvTWG7gETgqwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JboyArTcYeYbD7RyWpxieveFi9ORlVOfUX4VB9lzRovbk6vEPibb87eOf2Ugb5pj4vMPvqYiQxsCvpwO13XtuGNfbBg+dt301UtEvGh9kmTIKDWwZCfU3vDY/3Cg6uKz3mk2OPnZYxDH54FRcYqDd6cUQmRi5P1bbOMSnaBnsEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d97d9fIL; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c2eb98a64fso2909834a91.2;
        Tue, 11 Jun 2024 15:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718143723; x=1718748523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDAi/LehtiGuKcebgCW9P5JNBdnm/nWvTWG7gETgqwU=;
        b=d97d9fILkRIyxIF0DgpOnwUEgsr/e8B3bvA0GJhmf9FJQm5CZNyvjQa62hZMOqTvNj
         QtiypAhnzdMELMRM8/0sMF2sgn5aAQxmDKXWheXyfl2MStDrKPGE2Vpi+hf3duBofoB4
         GgGy73BE+U/NianoMS6wkJ5EUH11CSJF3kFT71DQDxSXVcE1VwSx2m8QZhCvdRvlnGMi
         1SoCtJip8OpKvORvdkC1Fy1xV+k2883jMnpu4cI1ztEVfn4JL/DFMw80bP35/DM5KyG3
         OpBamcmpzc5ak9gP/VG+yHSVE8gkOo/rfER8P4YGY8IuoMb+peuR4zn9EdX8BzzA4tJS
         3wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718143723; x=1718748523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDAi/LehtiGuKcebgCW9P5JNBdnm/nWvTWG7gETgqwU=;
        b=co5yYr4vzJ8uViJh4eL8tyVhhfG+5BrOfjw6lSwnBWuMFpcFCpGVOLOO6Uxxd3qIez
         7zeZUARu0hCpCsu1cHrchO87IE10zn5ZK4my10+HeYKQXS6VvmrQraFwklEabGbLMhwa
         GTE4NOEuEzt+EzgBNo6yBmLl/NruG/Rlradaw4puDJ+LG5I6UmJPyyMf54LUdY3zcdRg
         QG5EqTqk1Sz4SERvNPnEuJiYfOQdpG6Tiuf1lsHR4vfr2fs81IT+PYhZzYtjgPDj9m4e
         ERKIFw2k06y2hQgAc4McX8NbnHQ3Wh+7JbNWvrEcEFBBhZHes4Eg8/+to+5PikVyx3ou
         7yPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVpP4YwB3lcgcl0XrLAoeeWEsNBd8BnV/cA1wTqfQfTh7S0buD9d3jJ/bmszKnAk722VrxXbXEyEYBwhAItYK2MCu8PEyFP23MOmspbQHHgcM6cIyoUvKfWgI/ekhlksHWfs7GMvM2YTrIgaw=
X-Gm-Message-State: AOJu0YyNZjcn7U4AZzmS0n5AXHKJ80NDtHSUBv5CTzzdQy1Flis4e5Ia
	SG96VnJOCPdZXy4AEhzuNiu+vM3/SXObNiEGVtwKUGBh8tXeQh1mPEwEYJtGs6Gf3ep7ERiR7t/
	C0akD6e4wke1bI0/tOAyvMQd5HGg=
X-Google-Smtp-Source: AGHT+IFBHffem54xLZczBJ5Xe/oS4MPcXIdYx89tohNq89Cp7pMB4O45YjeNBKL1s1OfEMOCHqgJQtN9Pa89PVrrbZU=
X-Received: by 2002:a17:90b:b06:b0:2bd:8378:af81 with SMTP id
 98e67ed59e1d1-2c4a7602018mr213853a91.4.1718143723147; Tue, 11 Jun 2024
 15:08:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529093336.4075206-1-davidgow@google.com>
In-Reply-To: <20240529093336.4075206-1-davidgow@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Jun 2024 00:08:30 +0200
Message-ID: <CANiq72mXWERtFSqQRtcgP28aLokwZmXaBiqcrn_zoASawjfdsQ@mail.gmail.com>
Subject: Re: [PATCH] arch: um: rust: Use the generated target.json again
To: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, x86@kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 11:33=E2=80=AFAM David Gow <davidgow@google.com> wr=
ote:
>
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
> error: <unknown>:0:0: in function _RNvMNtCs5QSdWC790r4_4core3f32f7next_up=
 float (float): SSE register return with SSE disabled
>
> Fixes: f82811e22b48 ("rust: Refactor the build target to allow the use of=
 builtin targets")
> Signed-off-by: David Gow <davidgow@google.com>

I guess this should go through UML, but please let me know otherwise
(I don't see it in next).

Tested-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Should this have a

Cc: stable@vger.kernel.org

too?

Thanks!

Cheers,
Miguel

