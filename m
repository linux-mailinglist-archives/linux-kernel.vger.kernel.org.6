Return-Path: <linux-kernel+bounces-420666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9409D8187
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE02281B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEFF18FDC6;
	Mon, 25 Nov 2024 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wLNpswc6"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0513189BAC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525797; cv=none; b=N74RTV6BvYwUM168aZCq6doGYXns8dx9i77gMwsHtO/xGdVrMqzl5g/xxyVsoiA/W/9AR62gnDWQWP/zxvh0a2hbGxdQDqxNSap5pXGhok8dPS3abeJHhfXnLdHtzAmS2+u4UXzWVhXz0i6lbKTToJtUSMD68mKfUN3UcTb6hPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525797; c=relaxed/simple;
	bh=+iYj/LXeXfLCayyBoWgVOM4VHVy9tGibHOMx4/PqDv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3+8ihyYLxKYVh/z31p1f0pJoLmQc/n/7fvDfl6SalG/hmWjVUiaQbuRCzlCpGk0z7ULsHlgDl1+vjZBMHNiWhssx1atTE5PnOoXQ4hSHL8ATQWxqZdYVP21g/4fAmxcM7uIlucqdtkp8ni0CfP7//bjsH0zlQg7T8COKGjK2T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wLNpswc6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-382423f4082so2955588f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732525794; x=1733130594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iYj/LXeXfLCayyBoWgVOM4VHVy9tGibHOMx4/PqDv0=;
        b=wLNpswc6TLRa72Gdcjwmz+1mvkzVjYK3fX7Kbic6NhX1xtHXnWnwswD1bU45s8Gn4Y
         8mSeujVvBXL5V7u2RNv/eSwZZzk16qAkBca1RDo3wRVSB0TeUm75SOL8Esst9K1+3z2v
         VyT2I398diIgAuxgtBlvQXSpuYm7oDvdKenYcjBHrmaby5Y74g4vk8t/b9oZmUcIY79l
         hJRUuVPolk5b+6ClJKJReCP+6KnxH/2bkE7OM/sbAQxIWe73//vk0fV8W90Xl3tQeCU9
         uJH4ih4gCCmkUYYTLuL4sEkQZjAWr21SX7PEYmJ+GGEjw6n2czxKj5JIPKtkbhg5S2kf
         kBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732525794; x=1733130594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iYj/LXeXfLCayyBoWgVOM4VHVy9tGibHOMx4/PqDv0=;
        b=rL/qPLrh7XGrB+mPdkTA5B5tdOF1uVE7L27VbCTyHACkT3f1jVX327yFMjxl1B1a0T
         fAm6P7ekn/cdEVlsHgdbT/b04m22NfAWsiqO5ds4phkCMFIQHQOjgEhq3S4PbKEIVts2
         nMBZyWtl/qG+8kQJx0yyAvtuUuFvfobRudEnEzBU6xbiry/0Ggel1m89vOd695ycJG3b
         2fVIQqeR7/jNdTNrlc64u3v24Um7CFo+nC7+pB+EIEtojxfjX+6iGNxrGhwjB2dthXY5
         ZoPYJRnm9Fe/ZhWyw7DZFb+Lc8ttkkGCMGmyRMVszYUCAeByjV1/wL8/OGOlKputTFuD
         00FA==
X-Forwarded-Encrypted: i=1; AJvYcCV/Ry8wMcviWofkM2YREGGfKtsVSS2+pvtMjsJE2kCgcVxMu0/eElC0PmZb03s3skVa8XUST/tH2jmjUic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVzTHl5sJRn1MJWyE5f7/KuWp95O9+Zz5r+0wtp/2uLZCEuOKC
	199yLR0zgJUrk6kqmnjnMwapkXQgUOz/e8uVXOawafHGKOK223jENrRF8mGTpEJSelO+9wzRpNM
	GIc1SiiPwtQ8nRLgbQ4S1sX1wWA+PpNczgC49
X-Gm-Gg: ASbGncvi5irT8L2opENIovPxQSWA9FbnlCQX2G5Beo/cKp/Rz1PQTyOGuJE9wJJeWBA
	sOg4ddu0numrGQQ5YQPn74n3/TQQw3IccPOOgG0yZ0gENaiszonu3BhEo6wkpuQ==
X-Google-Smtp-Source: AGHT+IGUuEuCPmk+t9yOajZz2nGezK7YqZW9Qfb/96OWC3HZfQsiSBJ5BzwP+t8u98N6IXgnX1LVesACO+Kn/Ohc0AA=
X-Received: by 2002:a05:6000:1aca:b0:382:3210:4de0 with SMTP id
 ffacd0b85a97d-38260bcba20mr9942093f8f.44.1732525794090; Mon, 25 Nov 2024
 01:09:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123222345.346976-1-ojeda@kernel.org>
In-Reply-To: <20241123222345.346976-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 25 Nov 2024 10:09:42 +0100
Message-ID: <CAH5fLghVxRbiNTVBF=Xh77gGGTF8K+jtgFFSe5HRSS_76GdttQ@mail.gmail.com>
Subject: Re: [RFC PATCH] rust: give Clippy the minimum supported Rust version
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 11:24=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Clippy's lints may avoid emitting a suggestion to use a language or
> library feature that is not supported by the minimum supported version,
> if given by the `msrv` field in the configuration file.
>
> For instance, Clippy should not suggest using `let ... else` in a lint
> if the MSRV did not implement that syntax.
>
> If the MSRV is not provided, Clippy will assume all features are availabl=
e.
>
> Thus enable it with the minimum Rust version the kernel supports.
>
> Note that there is currently a small disadvantage in doing so: since
> we still use unstable features that nevertheless work in the range
> of versions we support (e.g. `#[expect(...)]`), we lose suggestions
> for those. However, over time we will stop using unstable features
> (especially language and library ones) as it is our goal, thus, in the
> end, we will want to have the `msrv` set.
>
> Rust is also considering adding a similar feature in `rustc` too, which
> we should probably enable if it becomes available [2].
>
> Link: https://github.com/rust-lang/rust-clippy/blob/8298da72e7b81fa30c515=
631b40fc4c0845948cb/clippy_utils/src/msrvs.rs#L20 [1]
> Link: https://github.com/rust-lang/compiler-team/issues/772 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

