Return-Path: <linux-kernel+bounces-569578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40422A6A4D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241193A920B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3559D21CC40;
	Thu, 20 Mar 2025 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAExXYuQ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4721C1F2F;
	Thu, 20 Mar 2025 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469719; cv=none; b=LheY4GZDf3WWHivv8Uu5tQhH8H3V2TEbwmdVuiSc33jfa7dwdHJsxYdW00wHWiEPd/DL3EPePdChcaHUAels5nH+03rOE+gnFOKAa1YpWv+G5b80vvO2Y4G8qNTwikl7JyT1VgIRLmbI2g6m2qAJya4UhFV1eQvKwDkJT1MpHdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469719; c=relaxed/simple;
	bh=k3mrXD+OZ3IUnCcb5OnLyDwzPqKGoZTi9oVugUiEAVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ttyr9puFXakZAVmOH0nU4msRSVFykEx83nP4NLApRR1tHCplZWH+micgepstn3PodN5sRihWe19c9xoI9dZ+GJ+K5/GNHXlVS4PqOCRhNiMn04Wu0SBRO0x6kpwvbzj89dj+IvXfhdDr5tp0BauTQviJaPWjUZyE9cwEiO3tgZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAExXYuQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224104a9230so1415335ad.1;
        Thu, 20 Mar 2025 04:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742469717; x=1743074517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFB3BqXH2e8TxvxT6l759Ym4N0OaYQbHqoLpgW4lhNg=;
        b=GAExXYuQ+uvLtKTGENbOzAlDUdsf+QEtiLIZ7Ukz2l9r8mzV9f3MR+srOgbzjvudNW
         W1c9pJCK81cuWPFKhKZyU4R+KF69TwIW8uuornruPS6RKDn8bn9L8QiOVZWeq0wYawtK
         CxiW9hfBSpcD508uwMsE92QKazijAQeIKlEQAbXMJHoIw5/t4KfkQ5A+IYZNLtcR1tr/
         JJ1638KO4DLaJMvEi2moZtImDdniw/fuJJa48MWSVoKiT9PWvl03LLj2tnMElplP8UKx
         SWju0CTD0xUhzwMpNa30G3fMgySG38jGRKFQadjBroBQRZf44P0401TPD0HzLidrDYAy
         xLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742469717; x=1743074517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFB3BqXH2e8TxvxT6l759Ym4N0OaYQbHqoLpgW4lhNg=;
        b=kxguiyqiv9UV3q/KGIey0G6WoZNX+EF1jsPNEVR/6+8c7rnjP/BKJPCzRllnIoTc7/
         6ZDYzsQOqI7BiI+I4qaZr8fTNGDthDtWqM35Lhqft0aPOz5ICl2/sIpAHHDGd1npSG02
         ldphY5BQZ0a9dBk/Z7eq3GGLa56yltGQMVOOSbSGYflB3EpermOwIvOuTrZyIxywoSEn
         XhsRAFvFRfsLd23xLS4A6SYc0CTP0sxxnFlgHYGGtCbBTSJbrNwSPYHUmLKjwWIxOYTq
         6RB9EDuhDYujA0Jk+D24LNhB5aYEPLHUMAadIp6jveMUOvVvEZ//ZTLMHeKCbIIIeLJP
         3uTA==
X-Forwarded-Encrypted: i=1; AJvYcCVsLeLR0Q55R/gJvYP7YlEs+EmDAOteJOBoFiD3p72FQj4TCiWxoo7afjzLfUMnnACOC0i9xkeDHHwlseB808M=@vger.kernel.org, AJvYcCWJOoEtXoFTcGAPLKTZOKCOCd7v/0+oO/sLI3CS6T6wALAc9JyfEGmJCHV5Y0ZivamJKnD48ehsVHpL/wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjjIcmVvaL4+9qsni4pzsurdo9N/tSCCkBe2SCWr39+/pIBR2v
	NyaWQ87O4qHOfCCRFbi0uk92wmjM6Sr5h8MtTn4ViLAHmXfP6UmzUnhQTZu4houQgienifJqrVb
	4ut4Eyg6cLmBKYMvtV6NFAdLJHpE=
X-Gm-Gg: ASbGncuJTiMe0qSCPTFMLJ9PYw4MZjz87oCUmgkcsQ4J8WEZVzUbWjZOerhOAWR2crZ
	YzvUBGncSUW+A25rKe3K+Sl/oj7E6xumzp/BWHFchy3EsmQaTkIGCAhLNg4SWHFuq9lL6QerLv6
	oOKKCYi2eJ1L2LtXuOhPmTrwJp6w==
X-Google-Smtp-Source: AGHT+IGASnHt9kNdq4d2lMO0TzafwSvDobso+TMwUI77RRq+dwIZX0mnFiZmhKy1QI2Pzn9arbywzIffrQpEHdWmdiU=
X-Received: by 2002:a17:903:8c7:b0:221:7854:7618 with SMTP id
 d9443c01a7336-2264c6053e1mr35338755ad.8.1742469717435; Thu, 20 Mar 2025
 04:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208-rust-kunit-v1-0-94a026be6d72@weissschuh.net>
In-Reply-To: <20250208-rust-kunit-v1-0-94a026be6d72@weissschuh.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 20 Mar 2025 12:21:44 +0100
X-Gm-Features: AQ5f1JpS94wTwKsmexWFYTQXZEkTRXemKuXOU31dkuRuFGtc1-F5e7wOCbLzIPk
Message-ID: <CANiq72=UKxv9EeV1Ozg5bcOtuoaFwCkm=7Yi+kBihoR7XzqHpQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] rust: two small improvements for kunit
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 2:32=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisssc=
huh.net> wrote:
>
> Two quality of live improvements for running kunit tests for rust/.
> While today there are only the doctests, more are coming [0].
>
>         $ ./tools/testing/kunit/kunit.py run --kunitconfig rust/
>         [14:25:48] Configuring KUnit Kernel ...
>         [14:25:48] Building KUnit Kernel ...
>         Populating config with:
>         $ make ARCH=3Dum O=3D.kunit olddefconfig
>         Building with:
>         $ make all compile_commands.json ARCH=3Dum O=3D.kunit --jobs=3D16
>         [14:25:53] Starting KUnit Kernel (1/1)...
>         [14:25:53] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>         Running tests with:
>         $ .kunit/linux kunit.enable=3D1 mem=3D1G console=3Dtty kunit_shut=
down=3Dhalt
>         [14:25:53] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D rust_doctests_kernel=
 (135 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>         [14:25:53] [PASSED] rust_doctest_kernel_alloc_kbox_rs_0
>
>         ...
>
>         [14:25:53] [PASSED] rust_doctest_kernel_workqueue_rs_3
>         [14:25:53] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] ru=
st_doctests_kernel =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>         [14:25:53] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>         [14:25:53] Testing complete. Ran 135 tests: passed: 135
>         [14:25:53] Elapsed time: 5.431s total, 0.001s configuring, 5.314s=
 building, 0.086s running
>
> [0] https://lore.kernel.org/rust-for-linux/20241213081035.2069066-1-david=
gow@google.com/
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Applied to `rust-next` -- thanks everyone!

    [ David says:

          (...) this is enough to get Rust-for-Linux working with gcc under
          64-bit UML on my system.

        - Miguel ]

Cheers,
Miguel

