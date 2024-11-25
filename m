Return-Path: <linux-kernel+bounces-420664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531A29D8135
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D883C161DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F055518FDBE;
	Mon, 25 Nov 2024 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zp4RvMHe"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD72418F2EF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525711; cv=none; b=qZF5p1k+Wm7fux62+QHsz+opkzEHoG93eYiNVn3U1Z3HosIaX6b+hMvG089wFRt3ZiMux22QE90gHFPEVeO1z/JCSf0GgHVBNaP1dk4hxqzBv/+ZXUluhsTBQCu9F5BKxG8oCTY3ozhQl+rmqyU3SK+Ak46U4BQcHaRP9sX5zPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525711; c=relaxed/simple;
	bh=ZFiDIMX0PjIK7KxSAeWlLey7+/mh5K+ji23nWIAmMLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7Y3bBcOf+P+JPy80r25fhVkIXDZJ85GUsO5315UP/jA7r5cKry8VgsAB3alYmW2a4dPxNzBdOOAJlh8Jk7IgvbNLZjnV9JxQJCusyp61oDe5Q7EKVa56VeNHIpC0SpxxYQxPf4Z9ldwbjEZjsQUIMES0RPMMk6TVpaicsCX8mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zp4RvMHe; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-382433611d0so3596197f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732525707; x=1733130507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXAcH18gdxYq9GcIQcUwx7uYz5V1gi29j89//5ppp0s=;
        b=Zp4RvMHe8iIW5NNsFyWTQigkRso08GSYLL+ka585fYPJ8YyM7ePLDATDdcmNydZAZW
         NJcQJKluQknLNVzgjf7jqL4iQBiRt6WtCEEn4vCU6ao5DntWml7X8gIKfHNmtXsfl1of
         05+wLjAv2QNFI51i1UeGP8sJSbig0/q8n0YdYPXvWXavmQpi3kdkTSfELzSVQXxa4yEj
         8BdJuhA4hfb/xIZ3tHMduZpX3RyQnXAJ/81tLFcndIVZflGM3kiN5BTad9Y0OkSeNSwZ
         Zpf5eBoZz6NqLhPF3IMLllqVFsqwg6VUME9x3zyjYfjCDl+DYlC8FXo7P28bf2ZkMa7X
         9ErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732525707; x=1733130507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXAcH18gdxYq9GcIQcUwx7uYz5V1gi29j89//5ppp0s=;
        b=UBhrG6i6FSA6ZHumNMwXdezqUp4Pg1+EyH+7bMH652hZrTXFYylvU7Fis+toqHaCm7
         XTjDC6MIa8ukmSGyPWlyIeX5B7rjKse49/0p4Jkpbrk6ZUDykGkOWTSig3R9ART9FgsX
         rqQuyRYXw7haH0Ite544e6BLDw/PaVFDRzpgxVesskFRuylHCFXVNLJT3thNlCht5ZzV
         b5uqrtBDPpVreKMp6PaVyJHCWmatFF5WHurd6oGo/PiiyC+GId/2SXRvkIjTcusxbtaA
         IaLXhYfd2m7ziou1LWvv8+Iy9r26aBdEfr+AWDIA9rpdN5Ip5hh6uSeXN8sO+B3CCMt1
         kA+w==
X-Forwarded-Encrypted: i=1; AJvYcCXXcrcieD3c28tbvYl8bOVm4v3xJeZR0FkJJyGAWcMg8wrdC+tIT5OEfe1UYvlTZJYNi9baXqOAWWPYrOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycNOdQX4nBDR2yBtgsdjPfcWcTWnDb2r/vxvgXeuYPaAjM8QHy
	SWbOMgAXbc+mIL9MYkyKWm8E9xN//gSwSUC74a1vK/kZEDcSQ33mFxJFGLGr+NQ+r+w2V/m1ky/
	MeAm5U/+DvqRvO2ZaSu/t7mRFI1kA7Qw3SLn6
X-Gm-Gg: ASbGncvldXF1RYdi3Rg/F/EAdNl3fNAGN+LnIOZP0Nps0B8yxxhMVP4hcyB8xd4Wsfn
	hE+Bf3Ve4BqH/Pl3x3PwXQ1amJ6in75o+Ew9Ax5EccVSUjXS4EsBXhPBYdj34lA==
X-Google-Smtp-Source: AGHT+IE+OQhREcTfAKueVgcaqoVBWDnV0rrbEkwbQowdAdSPH7dvgYIlFA0qd/qkJIo9gO5cQhqStvOzQrQOvhhAWD4=
X-Received: by 2002:a5d:47cc:0:b0:382:506b:f627 with SMTP id
 ffacd0b85a97d-38260bea7a0mr14291058f8f.57.1732525707135; Mon, 25 Nov 2024
 01:08:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123180323.255997-1-ojeda@kernel.org>
In-Reply-To: <20241123180323.255997-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 25 Nov 2024 10:08:14 +0100
Message-ID: <CAH5fLggg5f0KpaObVtZc7WaxHjUqbhCDsn5CwnA5-3df2HEjnw@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: set `bindgen`'s Rust target version
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Christian Poveda <git@pvdrz.com>, =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <emilio@crisal.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 7:03=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Each `bindgen` release may upgrade the list of Rust targets. For instance=
,
> currently, in their master branch [1], the latest ones are:
>
>     Nightly =3D> {
>         vectorcall_abi: #124485,
>         ptr_metadata: #81513,
>         layout_for_ptr: #69835,
>     },
>     Stable_1_77(77) =3D> { offset_of: #106655 },
>     Stable_1_73(73) =3D> { thiscall_abi: #42202 },
>     Stable_1_71(71) =3D> { c_unwind_abi: #106075 },
>     Stable_1_68(68) =3D> { abi_efiapi: #105795 },
>
> By default, the highest stable release in their list is used, and users
> are expected to set one if they need to support older Rust versions
> (e.g. see [2]).
>
> Thus, over time, new Rust features are used by default, and at some
> point, it is likely that `bindgen` will emit Rust code that requires a
> Rust version higher than our minimum (or perhaps enabling an unstable
> feature). Currently, there is no problem because the maximum they have,
> as seen above, is Rust 1.77.0, and our current minimum is Rust 1.78.0.
>
> Therefore, set a Rust target explicitly now to prevent going forward in
> time too much and thus getting potential build failures at some point.
>
> Since we also support a minimum `bindgen` version, and since `bindgen`
> does not support passing unknown Rust target versions, we need to use
> the list of our minimum `bindgen` version, rather than the latest. So,
> since `bindgen` 0.65.1 had this list [3], we need to use Rust 1.68.0:
>
>     /// Rust stable 1.64
>     ///  * `core_ffi_c` ([Tracking issue](https://github.com/rust-lang/ru=
st/issues/94501))
>     =3D> Stable_1_64 =3D> 1.64;
>     /// Rust stable 1.68
>     ///  * `abi_efiapi` calling convention ([Tracking issue](https://gith=
ub.com/rust-lang/rust/issues/65815))
>     =3D> Stable_1_68 =3D> 1.68;
>     /// Nightly rust
>     ///  * `thiscall` calling convention ([Tracking issue](https://github=
.com/rust-lang/rust/issues/42202))
>     ///  * `vectorcall` calling convention (no tracking issue)
>     ///  * `c_unwind` calling convention ([Tracking issue](https://github=
.com/rust-lang/rust/issues/74990))
>     =3D> Nightly =3D> nightly;
>
>     ...
>
>     /// Latest stable release of Rust
>     pub const LATEST_STABLE_RUST: RustTarget =3D RustTarget::Stable_1_68;
>
> Thus add the `--rust-target 1.68` parameter. Add a comment as well
> explaining this.
>
> An alternative would be to use the currently running (i.e. actual) `rustc=
`
> and `bindgen` versions to pick a "better" Rust target version. However,
> that would introduce more moving parts depending on the user setup and
> is also more complex to implement.
>
> Cc: Christian Poveda <git@pvdrz.com>
> Cc: Emilio Cobos =C3=81lvarez <emilio@crisal.io>
> Link: https://github.com/rust-lang/rust-bindgen/blob/21c60f473f4e824d4aa9=
b2b508056320d474b110/bindgen/features.rs#L97-L105 [1]
> Link: https://github.com/rust-lang/rust-bindgen/issues/2960 [2]
> Link: https://github.com/rust-lang/rust-bindgen/blob/7d243056d335fdc4537f=
7bca73c06d01aae24ddc/bindgen/features.rs#L131-L150 [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Just to double-check, the problem is that bindgen currently doesn't
get any information about the rustc we're using, so it may generate
code invalid on the rustc we are actually using?

Alice

