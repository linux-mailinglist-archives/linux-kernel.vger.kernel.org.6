Return-Path: <linux-kernel+bounces-341037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DEF987A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E538E1F2420A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D5D18787E;
	Thu, 26 Sep 2024 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OC2w0nR0"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F61187870;
	Thu, 26 Sep 2024 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727385547; cv=none; b=AoDsrFxQ3VQiqFmTXp4L6kup/V4r7aDcD+OmHOYcwVFSaSZzYQwDv79VqrwipNlJqW3KA8F55UfaSKE9mVA+euW3dmHAPqjOgAPim8KnHy3SJUfT49NfVLR8ioWDCnBmvc67ke1v/r1/i/2ZSJfiB1rt441ScGpaEhx4KovYR6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727385547; c=relaxed/simple;
	bh=AvcDnkUmv2DqPh64tRKzMWvmnXubSlYFjN4hVlRNLk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHP+pNWd3bJmuBCHdf2wF46p2Te+n5xXyGmRxP9TqmMcbUruXdn+bX4gojl94YlIaDkTm3cAjxlkK3gGKHyqpt4AMsm7+3GpVG4ZWs5yPr5lEZXes9/pwBaGsPcO1mEDcwwpyoqDsD5PNcTglG18MKE2XbbREHjhsu4+BIspjxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OC2w0nR0; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71829963767so191763b3a.1;
        Thu, 26 Sep 2024 14:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727385545; x=1727990345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiL/43w7xPDMaXqaTLOfu6ipmJ7ueyEd94vFcLFVt94=;
        b=OC2w0nR05ubb1ZwnW4Zk3yHSAyZSc4gZ+4kgqL9wp7SfQBRTQw4TPfk4gv9is1vHG/
         9AJcmxK4E1pzNjNz7N101mL/NOXxapoAyT5C+vm4GXr//QNahpaTZWbIxWnUSeedIfnK
         fWj9y/z3fdBORTa8W5WTc/uxTv9RfieYptQ/fzp/4Zl8D+67m+xI1nZ7T00ar3QcmqkG
         yHYQW9uAAzfyj0GMJdeRoewE8QimkzDZEUtFT2u+xR9Xp5dtZZaSE4rch+ILw3vKA1Qv
         y1rkOgnxiRqrRpU//NXEoOQwoKImRktfMqQyFhaLEtYllPKcvyxJWof2wZtHKOM+uhaV
         Xh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727385545; x=1727990345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiL/43w7xPDMaXqaTLOfu6ipmJ7ueyEd94vFcLFVt94=;
        b=B/eaOILp/czaKwCtMjUtB0xj4CLZ4o2rS8028ZBvkJBZqyKOaUxnKc5GecYCz1/Q7M
         FvWYqJ98oh6xFSU50o4ebrz1afF3maaa3zKA7By+GYuAGvW9MF5TWLNblyeyooJBruc8
         SzgYQiQX54cysAIO1RLB451AgKjAfj8ozSNSAvzWWy7VFt3DcCozH3T7LtI9SfyovGoQ
         t0ybjbioawWVU86DWy+cfhAJqXybdyipAGkpwJeuaFK01xcYGFKrqOsRkHz6P7Pd7P/9
         Ze8VfMaANXflwQXcJFKEpiJxTn0VfqQ9cHVJKfM6yojE9IyVnQGDd17jqVO4bfmLrcxy
         R2kA==
X-Forwarded-Encrypted: i=1; AJvYcCU4GVtUYqV//RwUyfu1supi5lJkGL1jffYS5L9jFT+gUcPVLGcrXQHfC9k8GD3ufg2PhYy8cyaIpQ7AnkV+szw=@vger.kernel.org, AJvYcCXjmjvfrtu4Ea5mCM484a0hRF8flNajPFkLx0UI0XTKPTNKDZHFlKx89GIOBb47KqQ+AzPMTLLXnfWY1M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAdSRFi5aYWZSM0/6Vto61WVESkF+n433wq2CFLoKDUXqebJ37
	2l83Iuko0vpoKjR2JN7BBXTwa+DMcYyuqFUgJfQ79iAa+ESrFnmaLW8NgBYCl2Uly1tJPDY1nzI
	q8WMQH+RkXgKXTmv+Ayu3sf6shkQ=
X-Google-Smtp-Source: AGHT+IE6Z5Ugs5d9ud90HsPwabxzrmKDL6pJfCR6F+I4Hb2fAl23W6NAluXCqFPTFKmt/02r4eYWF2KDbgYnvtdh4g4=
X-Received: by 2002:a05:6a20:8415:b0:1cf:46ff:973d with SMTP id
 adf61e73a8af0-1d4fa78e94fmr838750637.9.1727385545304; Thu, 26 Sep 2024
 14:19:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202409160804.eSg9zh1e-lkp@intel.com> <20240916003347.1744345-1-gary@garyguo.net>
In-Reply-To: <20240916003347.1744345-1-gary@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Sep 2024 23:18:50 +0200
Message-ID: <CANiq72=qRGkXJoTin69KDgz0YHDaY8uB0vfX=GDZeR7TbhaTdA@mail.gmail.com>
Subject: Re: [PATCH] rust: fix `ARCH_SLAB_MINALIGN` multiple definition error
To: Gary Guo <gary@garyguo.net>
Cc: lkp@intel.com, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, conor.dooley@microchip.com, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, palmer@rivosinc.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 1:09=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> We use const helpers in form of
>
>     const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN =3D ARCH_SLAB_MINAL=
IGN;
>
> to aid generation of constants by bindgen because it is otherwise a
> macro definition of an expression and bindgen doesn't expand the
> constant. The helpers are then have `RUST_CONST_HELPER` prefix stripped
> and exposed to Rust code as if `ARCH_SLAB_MISALIGN` is generated
> natively by bindgen.
>
> This works well for most constants, but on RISC-V, `ARCH_SLAB_MINALIGN`
> is defined directly as literal constant if `!CONFIG_MMU`, and bindgen
> would generate `ARCH_SLAB_MINALIGN` directly, thus conflict with the
> one generated through the helper.
>
> To fix this, we simply need to block bindgen from generating directly
> without going through helper.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409160804.eSg9zh1e-lkp@i=
ntel.com/
> Signed-off-by: Gary Guo <gary@garyguo.net>

Applied to `rust-fixes` -- thanks!

Cheers,
Miguel

