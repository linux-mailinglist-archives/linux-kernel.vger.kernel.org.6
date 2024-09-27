Return-Path: <linux-kernel+bounces-341463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5FE988087
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44BE1C2276F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096B4189B95;
	Fri, 27 Sep 2024 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMVCl9Zi"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390A2188A13;
	Fri, 27 Sep 2024 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426398; cv=none; b=EFsE8DbFAmCiciEYLPqZ61bvAGjsOWII5kNdAULeuYW7NONm06gRvYB6FETrVApHzF32/iVaGdak2ospj6JTLabXDUIkfk06x4QogXtGsRCa+Vk88T2/PWNUIIUYqMyBO6wdLsnX0ivbS/eDb/Tc3/ZfNsgPYmqSPfOaylibS6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426398; c=relaxed/simple;
	bh=hYbImJ4Ev4jx5aCpniSYpcjeYjZwxXIkcu27iki++i4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4ztGs1o319s331eYtyIEMFb2vlKXYj0HUb5oUCI5i9nRkUiOHtuw4BLxh2boOrc0EibIvB9TTad77tPq4ZS0QlhULOzuVcsFLAXWriN6Bm8RgHMz/JkAdagYYy+o9F/cXEuDcgX2O444Hcrvcmt61ixPsIznLmwfIBuCwyV2tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMVCl9Zi; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2da516e6940so377594a91.3;
        Fri, 27 Sep 2024 01:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727426396; x=1728031196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYbImJ4Ev4jx5aCpniSYpcjeYjZwxXIkcu27iki++i4=;
        b=GMVCl9ZiAdnGVF/eO+0cz7vMi4vvpKUisj1kCay/i9sfQ/kFQPygSgPRNuDr9ZvjYg
         kbL4ZfUW0PDIlHPq4A4KcGBhiAY5shM89I/GvSB8ZiroY1ugM1fJ8ji589KgBujdpjU4
         NThlJrpULbHIqYlbxBwWOyUkB+30Lw17a5Vq8Pa8qvwvC3D+mcgKVnGmsmaFpKFzvmyJ
         mxrtNujDDzYUUFtvPBg4fiWYkT8GrAFO5UQvKep8QuoeKtXxi+nQRq5vt72etj13Es6B
         1ogx0ZuBulffIhAn7W7VS+G/kaq33gB7Nk+zJRG4u6zGUKWvcJ/7bltcZea1t2S25ujO
         VpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727426396; x=1728031196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYbImJ4Ev4jx5aCpniSYpcjeYjZwxXIkcu27iki++i4=;
        b=HRzPdVPVxqx+p7fDN9lZYNelJr3AeXV5hkEtnL541Jmii+12IxDm5Sh+tWFFNjdLXB
         CX4ujQKAXVet11whdtyR8GaCS0i5u05nyy7kU5o0RMeBFXFDh9ofjp8cQU3OMEhwJDEm
         tNn/FuJljm3gHn4hHf2+3GUhaZkuxpmOQIPW1f6vB28210c6RxXItFwOYFFAF8koYdKH
         cRMj5X24xp1Trpnyj2PtezqRLe+Mbyai9nz8HoZatDuzXjje1gzcp0934BYbwmj1o/+6
         uMx3tuBeNp45eEdWhBrufDlJ5v+Dk+bJHfs167LANIgtmaGX6EoZ7/oVhzQfapoql/qW
         vDeg==
X-Forwarded-Encrypted: i=1; AJvYcCU42oydU+FsFdFMy7PyJHcb9sA+8/2y+wwA3Gxgi4MsE47iYoOvk1Z6n54kuGv0uqsa6FKi7AjmfLgjvahY5Ho=@vger.kernel.org, AJvYcCXkSqNIE1jOmxY82NbYIofeUuGcUt7kIP6DZ3GEElw9p9LlAjK4lW2CF3KjGyQT1KRUz7Vn4CfoKTcNtR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy31aN4OLPjevferUKNyAmwVgb/FlZH9uFiFLFzh13aiwhxcTnQ
	9Hj0tREMLG5SNTkTFWksLHAnrdStvQ5ajl6mnxrPogXwqMKWbvgZdCm1h/t3NyIj7c5IcsjeHxu
	aqfAO9hHtn80zR8VFRzBmd7oD1kM=
X-Google-Smtp-Source: AGHT+IH9QurLB9HGk/Herxmqe5pGQY/6ke+XUcdq9kiZsDiH58lNraRrvoW/7EyVrCJ92UxX4BV4JrXtWgxtGKVARq0=
X-Received: by 2002:a17:90a:ff0e:b0:2e0:9147:7dc1 with SMTP id
 98e67ed59e1d1-2e0b8ebebdemr1237952a91.6.1727426396447; Fri, 27 Sep 2024
 01:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925205244.873020-2-benno.lossin@proton.me>
 <202409270303.kUIAmOmY-lkp@intel.com> <42d17306-1ac6-4fc7-ab1b-69ef045039ac@proton.me>
 <CANiq72kXGNyLg0Ooo3Ne=KmZWBnSO9HE2tcfP=gf+WGFqnjDEg@mail.gmail.com> <1aa088b1-ca4d-4a97-b25c-96a18f62a79c@proton.me>
In-Reply-To: <1aa088b1-ca4d-4a97-b25c-96a18f62a79c@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Sep 2024 10:39:43 +0200
Message-ID: <CANiq72=-bV_=TUoH6gLnPwTcxROBqyrCpOpbumki_S+po1TPhQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: add untrusted data abstraction
To: Benno Lossin <benno.lossin@proton.me>
Cc: kernel test robot <lkp@intel.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	Greg KH <greg@kroah.com>, Simona Vetter <simona.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 12:15=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> Personally, I would prefer adding a symbol. Since if we allow it, then
> it might take a long time until the code is removed once we increase the
> minimum version.
>
> It would be best, if it produces an error when we raise the minimum
> version beyond the one represented by the symbol. Is that already the
> case?

No -- that is a nice idea that I guess could be implemented in Kconfig
somewhere (i.e. when checking conditions). However, one of the common
things to do when upgrading the minimum is to review/clean the
`*_VERSION` uses anyway (and they may occur outside Kconfig files
too), and also sometimes one wants to upgrade a minimum without doing
the cleanups immediately (e.g. the recently proposed GCC 8.1 upgrade).

> Gave it a try and I also can't reproduce the error there...

Hmm... I think CE uses the Rust-provided binaries (and I guess the
playground too). Do you have a link ("Share" in CE)?

Cheers,
Miguel

