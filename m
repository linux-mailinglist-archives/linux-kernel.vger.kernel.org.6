Return-Path: <linux-kernel+bounces-545532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEF4A4EE3B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2EB3A9B58
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13F0200B99;
	Tue,  4 Mar 2025 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNIIIksu"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C925282866;
	Tue,  4 Mar 2025 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741119526; cv=none; b=sMG2Boa/2MSZ4HJZQEAXo0hd1HrGx1PCO0IxgX9KXxYRYIIbUjmOmb9zeoP+kyOKk1k2eGrT6MNsDvQJNjEPUzGaAGEYCBpnpE+xpWF4M07PxpRmOoswMWpkmEmCD0GZvjvcT5P77+6cGl0GyOioZj01yLy9Ov3aVPXRXZBxhXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741119526; c=relaxed/simple;
	bh=gh7XHpbhvestM/azgi5si4Oj6DL7TzJx6Da/dbWM0eA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ejwEOCMZNci/V70KZ+/gcPAKQ/FO+Y8jFtT+OVfyYVtC9UirsFLNhJ5XtGbgECAo739E43Ni4EwCWbSKeGFSb1akHAwmX71G/wj5DKiPLtV7nbNA7GqvSrrG8iOWdCVoYXYy+nxWWsGxX4HDF5weHmIyoEpXmL2HZQQPpRmka3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNIIIksu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22356471820so98490695ad.0;
        Tue, 04 Mar 2025 12:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741119524; x=1741724324; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMUbl0wCaQRcm05eyFZBGbWJJJSjNxpwjfTPkpDtM9Y=;
        b=KNIIIksuRXqX1T+8blHiyxtP0hmqdu3fB3T7qwyS2nqUVB4aXSfH6AL67S60UoyxlI
         9HoySufMhXLgsgla/2YqK+8J/KOTqd+u70zrG+0dGlR+5mLOiLoRzxRQuCSjfzRoaXa7
         veLbfNzLewmHUb2vsxBPuBv2D59bn3G/iPKBXoPu4NKXafmQmHsHBVYwbnDwKt7SGp3v
         XeKaflYZp6hBBRZhvP1Sx1buFdF8+lozhWLZXlH4QvXSrYd179ex7JEUhZATigclqM0J
         fI0uy9cLXPg/b/XV0g/RzHm2rhDhvExW0InNCd6mePlop61ZBgexLDk/H4n60KITycdH
         y9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741119524; x=1741724324;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMUbl0wCaQRcm05eyFZBGbWJJJSjNxpwjfTPkpDtM9Y=;
        b=LMCH9Sk9u7s/DKmz/IcP6o2zJwQc7BxfK8ZKhHctixoIT07+62Un6aTlQEZNuNpHGL
         gPmlJDIdIQWXkG5B8hWRIpwl89/UkqlAoVtJIT7n0JUNlsXUA661thq5SaMRmZ3LL1Th
         blBzlFmPyeC2ztQ6cgmvk5oEsfRE2QGeCAXn2vpkDOp1UfPq1kFkHJm/9//PnN+Wr0FA
         Bis5s+0qDeU8tsoijsnBVpgrVRvxwpRGiUs8iQYSbYai4i4QBJmaeAgQEbKbv57dFvR6
         2WYeyEnogDGec5/SKJLUO8UDt1MqAtaDxnWy8CsLGD+NZo+lNKEspZF/f+85oLU9ECr5
         9EeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBv05uyEmLgA7sIkaYc270CVxkZgCGfB1v9A/6xzP4UkvqBdQFC8Cde2ZWMtpGCaEs5InDwQI7153vPYx0U58=@vger.kernel.org, AJvYcCXrjnXPzcwrlXefv8GM/c0neRgEYBxMmH14iOLyaC5qWkNFUwfDMpbdFL3kHE9RWzZ0CgfsPl22tqeF5ng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+MLtnPB+LOV1XGMZ35ZL/zXFUy3dkQ3HHJEoLtMcTCSQmlsvp
	CZYhFOEDx2V78wvT5HjzoL1ngJHI93C4AjUkPqglUyfuAA5pI+8I
X-Gm-Gg: ASbGncvonKwjQwcTQkGwaO9+oXHH+6Veq7Zimhj1ZynidMeE98rkMhGglNpAlLc8bdy
	+1Ddy/CzhIG/wvQ9yCt1ju2W0yuSHtMBWfxY8eTH9Zz0SNbbpLxLiM8aULMOE7e/1ekRFZBBFSQ
	ghNcllhjcFsaGS5V1U29FDm0Wh+5vej9WguqVGQ76l80nRmJEsFJTYh12DXo/fV1xTBmFnBAeY2
	sYhuYJaiyOGz3ihyvPKHWfJsgsLc9TB/QBBV2Gxd3pgcZjpKnhPoaqr4f7uTJEux69DJmkJwDxW
	NeoADvneOz+c8uAhZw2YCQwYXN/EaTS2xQ6OQuavFXMI97kU1U1ZAdF9ePaJBhCwsvw=
X-Google-Smtp-Source: AGHT+IGV7ZPNOH3YDDZHf9Sd2eAgkWszz8iLg4/6bG0aWMLHnBpxy5z95jAMTy+wZMioCxWgJXKGfA==
X-Received: by 2002:a17:903:2348:b0:21f:3e2d:7d2e with SMTP id d9443c01a7336-223f1ca9089mr6210605ad.27.1741119523988;
        Tue, 04 Mar 2025 12:18:43 -0800 (PST)
Received: from smtpclient.apple ([2601:645:4300:5ca0:60d5:8b0e:4648:9d9b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7ddf2b0asm10607980a12.9.2025.03.04.12.18.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Mar 2025 12:18:43 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: Allow data races on some read/write operations
From: comex <comexk@gmail.com>
In-Reply-To: <ae8ac31f-c6ad-46ae-80dd-10ec081a16d1@ralfj.de>
Date: Tue, 4 Mar 2025 12:18:28 -0800
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 dakr@kernel.org,
 robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com,
 iommu@lists.linux.dev,
 lkmm@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <88456D33-C5CA-4F4F-990E-8C5F2AF7EAF9@gmail.com>
References: <6dea7b6a-1534-47e7-94d2-d67417c3d4c1@proton.me>
 <tnwDK3QN_Xr0Yoa3U8HVxS5OqjvxIhgmmO_ifTGJR_EtIzjoxawOHtnbOJ9yChsUWXyFPcU9beIdrgbpfGZI8w==@protonmail.internalid>
 <3202F69F-397E-4BC4-8DD8-E2D4B0AB056F@collabora.com>
 <87bjuil15w.fsf@kernel.org>
 <t4HxdvR7WBX_861hiTXo72jqC9F9oRpIzgA_dD2yhcSuLISEkC-shMfSgllrFPpnkSZXGfRcc47keudMooNiIQ==@protonmail.internalid>
 <CAH5fLgg5MuUu=TX8mMsPf5RcLhMLHSU4Vct=h8rFX6Z7HjPxeA@mail.gmail.com>
 <87ikoqjg1n.fsf@kernel.org>
 <KpWTCfIlcLYFBpSvWPfALJ9VQn5a99_RAvxgMBc1aCrSalPB-qaW9IhXyaDG7HM1AcFPX5chj_Yr7IQp3F7UqA==@protonmail.internalid>
 <CAH5fLgh6ubawHh76wq7JPbcuBCWhm91m7Rc01MVsX-a3C6qaVA@mail.gmail.com>
 <87mse2hrd8.fsf@kernel.org> <Z8YMTiKS4T9wC4t_@boqun-archlinux>
 <ae8ac31f-c6ad-46ae-80dd-10ec081a16d1@ralfj.de>
To: Ralf Jung <post@ralfj.de>
X-Mailer: Apple Mail (2.3826.400.131.1.6)


> On Mar 4, 2025, at 11:03=E2=80=AFAM, Ralf Jung <post@ralfj.de> wrote:
>=20
> Those already exist in Rust, albeit only unstably: =
<https://doc.rust-lang.org/nightly/std/intrinsics/fn.volatile_copy_memory.=
html>. However, I am not sure how you'd even generate such a call in C? =
The standard memcpy function is not doing volatile accesses, to my =
knowledge.

The actual memcpy symbol that exists at runtime is written in assembly, =
and should be valid to treat as performing volatile accesses.

But both GCC and Clang special-case the memcpy function.  For example, =
if you call memcpy with a small constant as the size, the optimizer will =
transform the call into one or more regular loads/stores, which can then =
be optimized mostly like any other loads/stores (except for opting out =
of alignment and type-based aliasing assumptions).  Even if the call =
isn=E2=80=99t transformed, the optimizer will still make assumptions.  =
LLVM will automatically mark memcpy `nosync`, which makes it undefined =
behavior if the function =E2=80=9Ccommunicate[s] (synchronize[s]) with =
another thread=E2=80=9D, including through =E2=80=9Cvolatile =
accesses=E2=80=9D. [1]

However, these optimizations should rarely trigger misbehavior in =
practice, so I wouldn=E2=80=99t be surprised if Linux had some code that =
expected memcpy to act volatile=E2=80=A6

But I=E2=80=99m not familiar enough with the codebase to know whether =
such code actually exists, or where.

(Incidentally, there is a compiler flag to turn the memcpy =
special-casing off, -fno-builtin.  I pretty much expected that Linux =
used it.  But I just checked, and it doesn=E2=80=99t.)

For Rust, I don=E2=80=99t know why we haven=E2=80=99t exposed =
volatile_copy_memory yet.  All I can find are some years-old discussions =
with no obvious blockers.  I guess nobody has cared enough.  There is =
also a somewhat stagnant RFC for *atomic* memcpy. [2]

[1] https://llvm.org/docs/LangRef.html, search for 'nosync'
[2] https://github.com/rust-lang/rfcs/pull/3301


