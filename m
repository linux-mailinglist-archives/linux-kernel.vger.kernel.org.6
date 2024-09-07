Return-Path: <linux-kernel+bounces-319962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C5E970467
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 00:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3AE31F222AF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 22:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB9616A934;
	Sat,  7 Sep 2024 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pv1NlDNp"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87849168C26;
	Sat,  7 Sep 2024 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725747753; cv=none; b=ktjq7aPDkwKORSTFv+5hSC6xN7MO8JHWkAPKY5ZYiI0qN03D/az2cOK5SMXaH2R3BDh8qf0aSZqaLtnsf6mVueZbMYQcPnB8RgIftbO7EYxmrquPOaMVI1l7ym495EhZLC+dWz0a/MSbRxKiYSfrWX1KdLEw6vD+SMVLPy1Hsno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725747753; c=relaxed/simple;
	bh=5Ya+GrOx8iFM33Lbbtk9RoMuJPVWPdjs5LKsBxWWcko=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=c+e+LakJW5zHSzes+gBB/ZNDjnrqo0gdAUMoMCBuT2lcdK0loaq5KU0nKFjRueta/MBhral1HWH/hus0TrcIq5RfrloLEpCpbx0aF8RfxTwxYCm0HhbdnWuV94Wfy//eqmpETbsfV0lPc3hjzwRW9ShCkKvhAc+wV/8nIjvkccA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pv1NlDNp; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d889207d1aso2351954a91.3;
        Sat, 07 Sep 2024 15:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725747752; x=1726352552; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ya+GrOx8iFM33Lbbtk9RoMuJPVWPdjs5LKsBxWWcko=;
        b=Pv1NlDNpJ7IDXsppcfvxxq4QTTuON/qAi6TUL2zZH/vtFJuOl073NfYdOy9feE1UOw
         w18059c7lcB/nqI4p1vM3EAYTcd/ymv3uTGiOq7xgK7AMS8qeG9TxBLMcq2U17hZkhIx
         2oT0Qmcos6Ng9afbCYw8dcU31i5UiwQka2ygHbVGfiUTbhVfXi+u8p9Gmtr/wbTUuCTo
         tZzyc7KezxUvDXReQmawf+YQcf400gAnLRgBuV+1yPA7KsH+wcu/vYvgJd/ASrgUWbaC
         ugU82WloBN0hHhoPzWEybqbz7BD5TpBpdY0P/PvrCqPsyy+1JNweQONzQfEbJyaBEPzx
         Rlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725747752; x=1726352552;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Ya+GrOx8iFM33Lbbtk9RoMuJPVWPdjs5LKsBxWWcko=;
        b=XB0gQtlsKgEV96zStKtMqiMa5Va+tg/HO89empTkcPvl2U3a4RaBLWk1HvRpMiqMlQ
         YbHjaSKRwNZMbJvYBmeoBGUnBDoYw2sNGh8Ssli1Qtkok77xDnW3QKfMU/pzv1xtVQbn
         KMj3S17ym8SPQSHqLUiJeLA3OH21Qkc2e1gg/tPULtfFGo1V6Hl0uaVuD3wC6EFzeqWn
         ZmqctKgOPRREjtdIb8KFy0N01MuWOmYcxTWieYEUOQg283zaBULM30/sWJIxnryiQDWv
         4lgdUl2kjV4phMSzuQ1ebQP+7gBvdz53yVFywruN3JfO069/yAZTOECWdpv8VguTUX0g
         8g/w==
X-Forwarded-Encrypted: i=1; AJvYcCVSv5MMqyreCYjWW5USdCurML0LEhkaOwmDtHthxfivCg53H6jWFVb+ytR62OuyDxeHf0JdGYAnlezbazs=@vger.kernel.org, AJvYcCWrCyeUEdAc4lzLT6gZqej0JlcJeisSTDBtVYpIB05Q/3lQ03PSg71rmY34eqWR6hoSX3BqlMFQmDfioLgyjck=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz7WLb/tusqH3p2sv4OOaEM14Y7h4PIXLi9s4+0TPXXqhA/oH0
	8z0p9mfEqsfE6v9isqM/dHkaOwPaUooDY15Ea0nYSEoPeN7g/zM4
X-Google-Smtp-Source: AGHT+IG/HV5r+YZqFHMlZOHZKa+nFuVeg9UR3D8/72VNjiZ/5r4muwDJe42wWMrU28RnU1tIZRYyDg==
X-Received: by 2002:a17:90b:4c84:b0:2d8:87d3:903b with SMTP id 98e67ed59e1d1-2dad5196fe1mr6549829a91.35.1725747751627;
        Sat, 07 Sep 2024 15:22:31 -0700 (PDT)
Received: from smtpclient.apple ([2601:647:4d82:420:7c04:afa9:dac3:3f3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db044f37dasm1732529a91.34.2024.09.07.15.22.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Sep 2024 15:22:30 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH 16/19] Documentation: rust: add coding guidelines on lints
From: comex <comexk@gmail.com>
In-Reply-To: <CANiq72ktnMSfMfGEhN1kO0F+C5O_KsUY1y_eb7ZL+qzzSkg9bw@mail.gmail.com>
Date: Sat, 7 Sep 2024 15:22:18 -0700
Cc: Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <22A86237-4168-4D4A-8782-7A65AFAEC44C@gmail.com>
References: <20240904204347.168520-1-ojeda@kernel.org>
 <20240904204347.168520-17-ojeda@kernel.org>
 <CAH5fLgg20kDCJfD_6+fTSogOnpqK0x3a6eKaTahgSvdgfFzSEw@mail.gmail.com>
 <CANiq72ktnMSfMfGEhN1kO0F+C5O_KsUY1y_eb7ZL+qzzSkg9bw@mail.gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51)



> On Sep 5, 2024, at 2:45=E2=80=AFAM, Miguel Ojeda =
<miguel.ojeda.sandonis@gmail.com> wrote:
>=20
> On Thu, Sep 5, 2024 at 10:16=E2=80=AFAM Alice Ryhl =
<aliceryhl@google.com> wrote:
>>=20
>> Wow, does C really not have an easier way to do it?
>=20
> Yeah, it would be nice to get a similar system in C.
>=20
> There are targeted attributes that can annotate certain things, like
> `[[maybe_unused]]` in C23 (and vendor attributes too like our
> `__maybe_unused` macro), so `-Wunused-function` is not really the best
> example in that sense -- I will think of a better one (it was nice to
> use the same as in the other examples I wrote for `expect` later on,
> which is why I used it).
>=20
> But, as far as I am aware, there is no way to handle lints (and levels
> and so on) in a simple and consistent way like Rust does.

You can always hide the pragmas behind a macro:

https://gcc.godbolt.org/z/WTEaYWW8c

It=E2=80=99s not perfect, because warning names sometimes differ between =
GCC and Clang, among other reasons.=

