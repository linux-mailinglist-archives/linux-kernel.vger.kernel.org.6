Return-Path: <linux-kernel+bounces-561556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7A5A61371
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059093B1B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EFF1FFC78;
	Fri, 14 Mar 2025 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fA2MZDoX"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0882DF60;
	Fri, 14 Mar 2025 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961746; cv=none; b=mMt3rrmgfr0lphnkeFCp/H7BOkVcHmbmXuRmYac6aGdANZGb8nIT83a3PW4Sbuzi4dtc/0KlKuQv7JyaRwrXZP4wdYAB2Femzne6rPWNsyhTLyDaXyU2Z4QY4BqR0ZbYs+9/erUzyR2qW749/OU/bNdq1LMx2l0YSmBuRqlmqcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961746; c=relaxed/simple;
	bh=hoD5OuQ9XrVOKR/0IYi9oyZiNH0tYknwNIdLHImmP2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMdcWRuqd0OlnZHqI5gfwJVRRR9iCQvxXZel4BVkWwHOvoSbI35jJx+stLHwSx4qQc+d/gDuFWdHm93/iHTUVFgXCDtbMAujOzAzPF1wzzroZuJVrULZu8hZRtrnlJgZBZ7bQtwVv2TrQkS4MZwoIKjnrHJ8Uf8Q1LMgfeCdsRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fA2MZDoX; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30613802a04so23280201fa.2;
        Fri, 14 Mar 2025 07:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741961743; x=1742566543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoD5OuQ9XrVOKR/0IYi9oyZiNH0tYknwNIdLHImmP2s=;
        b=fA2MZDoXNrIg2rsGJQtW/NTHHlA43tboUya2BMD5ERJVJNcE5jRPe4vPrPJ6RvBpoX
         bMI3S7PWkj3CSBIwAkisWfZSdqO+XrTaY9M/zvdOhkbL+Ah7pUX0DFk1ZFuZKGe6GCqD
         DeJ5st+T6hyPEs+nAHBU6p/q27ByFNJAHKJX8oduqZhHWfSwaGT56JL+CL3abrmWdNqD
         rF90XO6BFaTiziW2BbFAY24rGAH0Gz5xyYsxyC6xF8J9M3Nfhwa6p+9CZooPcabP3LxA
         ufO9zbHwK+9zbpvO1ov0P+zraefyXEUlgSoWlsU9Ad+6aAAoCDQ9fHrjJmwwvutiHgqh
         P8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741961743; x=1742566543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoD5OuQ9XrVOKR/0IYi9oyZiNH0tYknwNIdLHImmP2s=;
        b=J8sKeAlRlVYI3QdDn+F/0LjonYMxKQwvtMWgSzhcwmEeSvGFz53QvA2GirfBHDDsdp
         6MeLa9pUXpZhV+MwHBJYg3eYL+qlGwRRq6aNpXfx6ba03fZIViSrQvfKxCX1h5NMlClg
         k7hHgU0VISftk867WCjkPLUgpOT44/x0vHoE94gwWxOghjserHdI36YmhBCWgA95utLN
         xCdtoEUVTiL9zUwiA9ZRP68Tpp0pFo2ZKDfMY6ZKo1CF22ogNWbXjyUTxiCLma/pYbTy
         Op/CkBdFUIt9EgGAAjNHpmVfFMlReAMaGq4jTElis95bDGvv9BAvoEes2KUCYXUrpeLu
         xeYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP5RiXMD2lxZTXwmP07IdaQrapTs/7+GurQcthzLh4NWQeL/gnKpXFryiKc4LlOe4rJWonkCN+ExQWwdLDb+U=@vger.kernel.org, AJvYcCVz8VwoGGHqiD9gDS4tQifZqoUZSNQi5vFwhnjKNy3Gv+SOO8j6KNd/qCvlGG/D3LmM7KfHC7RRvDt5joM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuUjQJ6GwcnsKQq9kGvgWimy3+Zp1sNTjde7W0QQ/2tqX+7ozk
	IZR6d4g+TounvGACJlXWyeEps7f+hzL6VBC3cjcyh6Op1HSeeoNErRVEYk1jfAmi0mLpJNmaJ7Y
	PrZ3ei4+177wcbAcl/edsbWZr614=
X-Gm-Gg: ASbGncv6cq3U6agcpAccAPTzn8chKV6x/RpMU9RraDZ/uTmz/zwKsM9BSGz4cWMKUTV
	is7bXivtTYNFmmgFbtwtDnl4BUAcWh58jweAGK+bMAw2WlyyXcLzxfAW8hNPr55d+kLUo9g/0Ro
	UV3k+eUw0E/YSxl0caNY+s5Fmi0Vd8Tb/1B27o3qd7sUggEt67+wx66h7Er4ez
X-Google-Smtp-Source: AGHT+IE+cuUx3bVzPL1OFOTxDv+ajzkYB2XUMolDVCyX8pmDfijIlkLdfwFg4aM/XXqZBFG7pPWD4W8UgPyMK+NI60Q=
X-Received: by 2002:a05:651c:b14:b0:30b:b987:b676 with SMTP id
 38308e7fff4ca-30c4a754753mr9968651fa.2.1741961742896; Fri, 14 Mar 2025
 07:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203-cstr-core-v8-0-cb3f26e78686@gmail.com>
 <CAJ-ks9kyozt45VeXG7GBTN-ejy_HGMOekFYFMmzS8AbEusZMWQ@mail.gmail.com>
 <CAH5fLgjUuCo5Ayx4WCfnrVAC1prvUbY-pvZdinkAb+KcSOWvpA@mail.gmail.com>
 <20250221142816.0c015e9f@eugeo> <CAJ-ks9=9OozDw7XotP_0Hpb4-p4VmPMSwmEdnnCpk1gCEJyZiA@mail.gmail.com>
In-Reply-To: <CAJ-ks9=9OozDw7XotP_0Hpb4-p4VmPMSwmEdnnCpk1gCEJyZiA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Mar 2025 10:15:06 -0400
X-Gm-Features: AQ5f1JqYWCwq_ty-NbNFuS5vkmJGhsSJl0kLU7uEsFDM1IlS7NQin4l0aSlBzoU
Message-ID: <CAJ-ks9=Q3qwY-efP=hRH2N9XSZf6pN-2fCUMyC8z3p1jwVj3wg@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] rust: replace kernel::str::CStr w/ core::ffi::CStr
To: Gary Guo <gary@garyguo.net>
Cc: Alice Ryhl <aliceryhl@google.com>, Michal Rostecki <vadorovsky@protonmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 10:59=E2=80=AFAM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> On Fri, Feb 21, 2025 at 9:28=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote=
:
> >
> > I'd want to add that we currently also have our own `BStr` and then we
> > have the `CStr` -> `BStr` -> `[u8]` deref chain which is quite often
> > useful. If we move to the `core::ffi::CStr` then we would lose ability
> > to do so.
>
> True. The best we could do is `impl AsRef<BStr> for CStr`, I think.

BStr now exists upstream (though it is unstable for now). Please see
https://github.com/Rust-for-Linux/linux/issues/1146.

I sent https://github.com/rust-lang/rust/pull/138498 to see whether it
is possible to retain this functionality in the end state where
upstream's BStr is stable and we're able to use it.

