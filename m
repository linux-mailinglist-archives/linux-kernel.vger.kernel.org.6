Return-Path: <linux-kernel+bounces-530204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EF7A4307C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57AAB17579E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C724430;
	Mon, 24 Feb 2025 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ks4zqbtL"
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0C6197558;
	Mon, 24 Feb 2025 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740438268; cv=none; b=rM/f2lEqBMoIm/yFT65QpAhx0+xj70oWKHhMHZlq9fxf8YPAVsI+NGPYmiUM3VVfVGJqU2nbATH+3OVZOsufNThlnfyU5vVBiYEwLcRs3hyMkPHJ+d1M9orurZj1Rc20LU2PXd568O55LxVVDpDlPk3zquKDwVfSHBV25dDIynY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740438268; c=relaxed/simple;
	bh=9dolYcrAbvw6zVWOc0wIyblpS+7dFxmtgKlmfHND2C0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQbru5TNreA9MApaHFMPA9h1LtiOIv3vE/NT0mKIz268lxB1XNlP8IN9zTR3bbX7DzqFo5HQtN4OXyu+b7iOJVJ0VksJqPFUjxYDDcZRFHYU/YPUD7IyfBG794ucbDhJdOYPLl68dv82JKd7n2CkwPZcM5CPRKKOeP0VQ2qMcc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ks4zqbtL; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-5461dab4bfdso5997786e87.3;
        Mon, 24 Feb 2025 15:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740438264; x=1741043064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bX2vJHkSIfnPYXDLQCf3MUVX+uxwLZX1jGt0RGQn/JM=;
        b=ks4zqbtLBYZxHpNs6Da0MddYiPsLXa90wZ4Di/coV4WKlaDuEyTr9+12D+g+8lVia+
         UgHWb4gNwf4N7RmUiM5JJXa/Y5Wl5BPSB5aO8Qe6L3xLLdZh4ebkDuQJoVNOqhbBb7YI
         tjuDypSpIoKw4yYxYEbW6bV3AkKXpVUStLjVc3vqoL8odKQ7VMm9SfAx+BWdwyaP0Gd1
         2B5FEU4C6F0wXusn6M/hegzikatQcQtCjklnbL8gvyIIIhWkZvuAs50k7cOKfan1Kwe6
         CObZG5lEDlf/Z5B6kFMmZ1b8NnKt5GESptfJevzi3LHjZPBVAEmhCVjBlIey5q7Qz1nQ
         MKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740438264; x=1741043064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bX2vJHkSIfnPYXDLQCf3MUVX+uxwLZX1jGt0RGQn/JM=;
        b=LguMaakpM5WiMZl9rw1y6vGmlCqmQWAT5hW3aRg2tM47NhkLA35Gyyxpi13YR2Yzae
         rCe7SBipyT6F7kqR5fk9pDs6JpzakwuxAgmrPJEOOS5jaGgokPLdbb3OH9GGMesf2p2v
         A2ydevCT5Xms/0jqI4IJ4sVcmNTZfsAS8DvnQ91QPwMj6AtByOaNgckYtptVeLkCz0ag
         zyp7L6iKap+bgOOAaVgD7QdaWi2shByMF4+ny1UUqOxBHu2axze391TWVxO93gMpNq/Z
         EG7AUZQr//K8cdJuivJfipWETI3uEAU8GCW8KGJX4HzYtafdUWWz9iPHzrkV8p9bB+xh
         j75A==
X-Forwarded-Encrypted: i=1; AJvYcCWU1j0wXOckZdAEx7Pq8qdPdo8ag4TimDZh8aDJ3tVDMVczE7lu3lGdiiHmnuo1aYWzyby0zcRl1izT8+U=@vger.kernel.org, AJvYcCXrmmXiwndGggsr9XBPASp0+OLuBtsJe5FkqNdAMp59hwUGB/+ZW8bwXkqxI1JGwYXVn40H5uSr1XMUzXUfTSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3s6ACWKEIFDb+r2ztMMWbe9/InM2H4brsFwIBf+eU1N2IuY/e
	JiQhvNOqXq5nAFefV33wyT5lTTXFFzE2FNlnf5GTn6JZhsQPEOf8Cddr3I/5UgpZf12y9tR8Hax
	dcvDhp2s4pxSiWi3DrvYEHaMhJtY=
X-Gm-Gg: ASbGncumopqTdkpKGJxDwfi1pLK82tBz9S4kdI2CjtroZkU9eOwef2Rz0rp72InBuSC
	pYkaDGFAkUcOLXOMW1cwVoNLwH68/oTcgDv8BW1P3WwoLN6pxlNqxHTNuMI4O0QYFwBR8FgZf2g
	NQU35xt95u
X-Google-Smtp-Source: AGHT+IFFJhRE3Al38mb61oLdXyI6FGFfcEO4jXtiTTGVk6/pwT9T82qqzausAEPp4MaJUT8MU6L1pcwLsqha9GhCWTM=
X-Received: by 2002:a05:6512:108b:b0:545:bf4:4bc7 with SMTP id
 2adb3069b0e04-54838ee9139mr5750419e87.19.1740438263970; Mon, 24 Feb 2025
 15:04:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <20250224002745.7d7460a7.gary@garyguo.net> <CAFJgqgSNjF=LfrCNTH3GdYssXz9YG-AeCtpibejJ7Ywtx0m3HQ@mail.gmail.com>
 <4cb1d98b-f94b-410a-be90-4394c48bdbf2@proton.me> <CAFJgqgQ3P81-iskGu9R+T=c=wyB2K0JqUhx+Gj+6mkYeY8-ORg@mail.gmail.com>
 <a4b79751-f1c8-4476-98a5-c59fb2e545ad@proton.me> <CAFJgqgRdiQ29bWvwsu11yokZb4OFF7pYYUU=ES6CYv9847KgVg@mail.gmail.com>
 <c05cb400-969d-44a1-bd40-9b799ed894d7@proton.me>
In-Reply-To: <c05cb400-969d-44a1-bd40-9b799ed894d7@proton.me>
From: Ventura Jack <venturajack85@gmail.com>
Date: Mon, 24 Feb 2025 16:04:11 -0700
X-Gm-Features: AWEUYZm3FQUc7v5ynrtRFpLc3fAluhwUO3IC2tdoYT596U8GBpUsWxMZSKRfhHM
Message-ID: <CAFJgqgTs3h5YagY1RU2AZf3wKWKfXiPTE2mx7CuWyzN=ee-k3g@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Benno Lossin <benno.lossin@proton.me>
Cc: Gary Guo <gary@garyguo.net>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 3:03=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 24.02.25 17:57, Ventura Jack wrote:
> > One example I tested against MIRI:
> >
> >     use std::cell::UnsafeCell;
> >
> >     fn main() {
> >
> >         let val: UnsafeCell<i32> =3D UnsafeCell::new(42);
> >         let x: & UnsafeCell<i32> =3D &val;
> >         let y: & UnsafeCell<i32> =3D &val;
> >
> >         unsafe {
> >
> >             // UB.
> >             //let pz: & i32 =3D & *val.get();
> >
> >             // UB.
> >             //let pz: &mut i32 =3D &mut *val.get();
> >
> >             // Okay.
> >             //let pz: *const i32 =3D &raw const *val.get();
> >
> >             // Okay.
> >             let pz: *mut i32 =3D &raw mut *val.get();
> >
> >             let px: *mut i32 =3D x.get();
> >             let py: *mut i32 =3D y.get();
> >
> >             *px =3D 0;
> >             *py +=3D 42;
> >             *px +=3D 24;
> >
> >             println!("x, y, z: {}, {}, {}", *px, *py, *pz);
> >         }
> >     }
> >
> > It makes sense that the Rust "raw pointers" `*const i32` and `*mut
> > i32` are fine here, and that taking Rust "references" `& i32` and
> > `&mut i32` causes UB, since Rust "references" have aliasing rules that
> > must be followed.
>
> So it depends on what exactly you do, since if you just uncomment one of
> the "UB" lines, the variable never gets used and thus no actual UB
> happens. But if you were to do this:

I did actually test it against MIRI with only one line commented in at
a time, and the UB lines did give UB according to MIRI, I did not
explain that. It feels a lot like juggling with very sharp knives, but
I already knew that, because the Rust community generally does a great
job of warning people against unsafe. MIRI is very good, but it cannot
catch everything, so it cannot be relied upon in general. And MIRI
shares some of the advantages and disadvantages of sanitizers for C.

Best, VJ.

