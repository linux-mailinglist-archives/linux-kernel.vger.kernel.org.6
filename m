Return-Path: <linux-kernel+bounces-169177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322028BC482
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 00:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77E31F2189D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 22:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55172136E3C;
	Sun,  5 May 2024 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDYPc1G1"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690D013774C;
	Sun,  5 May 2024 22:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714948081; cv=none; b=sGdkA5C8ovZfKCoR93qnTh/NEIvDW/PDYGzVmW/J6uJjg0ESJfBzhs4uyMRd5wW5Xbxh4ywKcLj3biegxPNul3z1Xsf6rrL/ZnLUIkktxHAHxwKXq/9x2wsnqzhtxvvIMQAbOHoGKuLzeg165uK0x6TA12G/dO+pxqPAgVbaf4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714948081; c=relaxed/simple;
	bh=PnhuRaH7kHDqdvetOTUb+849eKiSXQDg8yfGRBbMzSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGolhU1u43W2VG8LDrab7QY22PFfytS7VtKXrzuKpyR5OZFn4ABy4013N6zUT1DvLdjEhTCTHqhKb7U0brvT6vnwSVuQOnTMubWTPvqhh1BbQAHkLxNRMz6bWbQ5S5HDhwyofPiHZ73nReaXDlCuP6Hskwfh1ct0PuLKzpdn0jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDYPc1G1; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1145098a12.2;
        Sun, 05 May 2024 15:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714948080; x=1715552880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJO6mPxAclOgImrRki1ODylm8SwqUcxhxstV0gj46N4=;
        b=mDYPc1G1WgUZSVu3hVlzsGtSMQjS/XMvQiRQue1GIekiOTM6Rdz6YXVL938cn8ceGx
         iXFWHhgwJ4T8gSP5X001gEIakz+nowo6IZeUa40ZosLG0I7o5AWdunal7lcRG5qnkoX+
         6RzY2Z5Eq5rMaEnx3n9rGQYWFTYxy0FMCIhpbcg3DJO8CRc3W2Giu2LJypT0C8bM5roa
         PhrTHH8M3G4+bj7cVdPnnCH38smrZmXsNwZOeNIZRzee2wesjJkMxC58gHMkpSNCVuiG
         HjykOiwuCDxdH4ppRPr0o1aUONo62fWty7FOm3hkMbHuKM74pZECpAx3H6QpVOhq40up
         ElFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714948080; x=1715552880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJO6mPxAclOgImrRki1ODylm8SwqUcxhxstV0gj46N4=;
        b=hKM3gfrCkORE59rNZAqamPAz89BO9B7ZcIDdg3dCNHUwl5vJXfASPEu/5xQLGzRmnW
         YUVEfz7QA6pqDvS3OrxIWByjUlcQRiULPrJpwxjKKX6huKajBHXbRmKh0LinUoL9shQt
         0HFXjNiI04iSCZ0tkq0RBuQT4/ByPrP/KSWVm0/kJs7PiZT351tYPOs2sPIYrMGxMFYw
         AqluCGlXY6oYpv7rAYRq2Nd8Lxm0L8O9jS3Av/qMBvZS9TLXbH7gD6U+p2ZtXGlDE5Qt
         KN8+HbTbpX2jL5GrPbL5P4fVR8L/F0Fz1a96Z1sG4CLQqsvr4fHD/raq+xdSKp939R+4
         Y2sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP/hTiYlDW2RjhSJ0bEpDU2+p6STYHy23sJYNM0PqhMhUDLrlZNtkvwKHxS5RNxffjqIGuflcQIZLZRbS0KqhS/c+S4xdfvfqeHHGe
X-Gm-Message-State: AOJu0YyiEVVpu1N20blrSHB0coUGZqofngUlU9o5Kvd6Yvan7sZj5+wy
	MudwX0XXKOZh0DVEJs01g/b0vrOpuf/RZ/GAmEfS2hvjY24O3lrgse+ZYCkYw+McQFaqc58QnGj
	myU1l3L40bRLrN9IFhITPL9gF9jk=
X-Google-Smtp-Source: AGHT+IG4ulaU6tR3gNMHRoRU5RYl0MWGDXaAG1VrXszEVrVYMtmTRrEDdFqEwCn0lIe/RtrGzUxqPNvAVJacuHl623o=
X-Received: by 2002:a05:6a21:31c7:b0:1af:35c7:afb8 with SMTP id
 zb7-20020a056a2131c700b001af35c7afb8mr8889237pzb.3.1714948079558; Sun, 05 May
 2024 15:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401214543.1242286-1-boqun.feng@gmail.com>
In-Reply-To: <20240401214543.1242286-1-boqun.feng@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 May 2024 00:26:34 +0200
Message-ID: <CANiq72k64Z+kexebgi50dVTMpx6vsm=tt+kipe8HQH8Rhykqjg@mail.gmail.com>
Subject: Re: [PATCH] rust: types: Make Opaque::get const
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Obei Sideg <linux@obei.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 11:46=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> To support a potential usage:
>
>     static foo: Opaque<Foo> =3D ..; // Or defined in an extern block.
>
>     ...
>
>     fn bar() {
>         let ptr =3D foo.get();
>     }
>
> `Opaque::get` need to be `const`, otherwise compiler will complain
> because calls on statics are limited to const functions.
>
> Also `Opaque::get` should be naturally `const` since it's a composition
> of two `const` functions: `UnsafeCell::get` and `ptr::cast`.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

