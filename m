Return-Path: <linux-kernel+bounces-349624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768F098F938
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A73B1C21983
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E961C1753;
	Thu,  3 Oct 2024 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ0Y38c7"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC321AAE36;
	Thu,  3 Oct 2024 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727992324; cv=none; b=iPla34Yb6UjEbL8RehqGXpKTMKt9pXIvX+Uzbzeq/lWgYPetyIKIIDkBAgk2G7eUB5yD6ouc0oagu1HoYCyV3cJODqivYbhWojtbyYb1TY09pqMnv1ZQRgzqaSWuVDxJD2v9622hJcIDzCX2Sefmnqc4Fs7BAdUYB28agCGiphA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727992324; c=relaxed/simple;
	bh=Qkgylb9eQTwPDhGkklvlART8vOuDVtTpvqJn4T8hEuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OM55M2Rjo+kWEYwMsivxNVWTLUEYsm9Cb9PtdCdo7DMB/AmawhYTftweCRP1fJ0a/nUvEROmwrLflBymplP9G2DOV/84LabBrYne25yz7rM7RDbkFsQc1r4PF4dEU9OwhOm+bsIOjN+UIrIXjW4v1B4k/LQRS64wT/qGt/H/4QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJ0Y38c7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-718ebb01fd2so224496b3a.2;
        Thu, 03 Oct 2024 14:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727992322; x=1728597122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1ocYpbXaC5mU/aFXMsvBK/itd7YFUGOalmomO/3cJs=;
        b=MJ0Y38c7NFVps5VIsKS6ZwsyBzO3bLvP26PMANiNOmfo4RQ6c76w/kKe9HKuk9pb26
         1W127+5iZSBxnWai3F5qVNKfFnTvmSvR+CWkRA2Thgvo4gv+tUxRtJc93N823Tyfe9uQ
         BLxP7VIP3U656Rjd6EWIf6PElOrMBtxSuAqb48LUdcazA9kvih4WNF/c3uyoM51xtQZR
         AMyrl4dVH9jMXuMhwZm8/O+7OmYsjNIZSjIyjafCGfg+LLwKXOP8WT23qzWy2c4c1OWO
         thqBUX1QlQaIIVKkrfzxLKYGe/E4iBEVAQ269+oPLtgOX70q0FB7KosHzT8XMXp4+FhO
         nmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727992322; x=1728597122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1ocYpbXaC5mU/aFXMsvBK/itd7YFUGOalmomO/3cJs=;
        b=TgpFPzzRBinK5FL2u1C+52R+U/gyj4z4uoCpvDTTtEPQEfEJzXZwL8fbtEVaGqy+yX
         lxeSW2hwXo8V5+Sn/Vw7GCjNXg4pfxE1VlucfSFNfq/aUerV4mNvIrw4ngIQhg5cWhYd
         UHvlo0CA0rJyQUY1V4nFOoDp3KWHsf90Ccc34fqCzyjOs9caniDi16bnXgoxuWrzuB05
         UhxQ8fzTsH2zFQmYDdejoysuY/65Tv+XuS2rmk5I/z+7T1SBjPXheLLObZVqRlSAhrqR
         2mc9X94XMt1AQkooe7AODQhtFdKelGKhu/hHXVi+y5OazmyrZPinvD0CQkRu27CiNxrZ
         zAwA==
X-Forwarded-Encrypted: i=1; AJvYcCUFRNIXvjEdhO5Jo6WvukUU4PvOdHdoAv1R6Xs2W/Xr11Kt8khompj82axGL6fH7xrEX+X/cfCGBXETQk9tAvs=@vger.kernel.org, AJvYcCX/3sCIi4ie+rOySwJBUpPx6gMD1wxDDyzx8pRLQueiDBnDN/mEz65Z77llHtCO+fKYM2dDmlA6HzPni/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo53Y3GquYYQElRghu2lAhTeo4ZT1S/Za0KXdBJeEKCF7muwuk
	QX9cGKo/7i3si8kjQi82MtlqZtJu7cZ3oAGcNt/13g0fyVDRN/hlJU1I4nrTt2S6dIe+KwKVHji
	vVmGt5bwigD74EEoLArSI0yvEATkGRjEGYO/hRQ==
X-Google-Smtp-Source: AGHT+IHTh3t5d79tqkJbOqxEb5kcbUgEmnwOVGF1GZDA1wqj2rKreT3LCSAdvi67msvAAPCh9G8GXqYnPiYwwYJIwPE=
X-Received: by 2002:a05:6a00:464e:b0:70b:705f:8c5d with SMTP id
 d2e1a72fcca58-71de2446c96mr317654b3a.4.1727992321935; Thu, 03 Oct 2024
 14:52:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Oct 2024 23:51:50 +0200
Message-ID: <CANiq72m36NBNaSLL2phtFPKL3CYdamSOzd-e2t3imP3nY9ed0Q@mail.gmail.com>
Subject: Re: [PATCH 00/19] rust: lint improvements
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:44=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Hi all,
>
> This is a series that contains a series of lint-related things:
>
>   - Cleanups and other improvements and fixes, including removing `allow`=
s that
>     are not needed anymore for different reasons and a workaround for
>     `dbg_macro` detection.
>
>   - The enablement of some safety lints so that the toolchain enforces th=
at we
>     write `// SAFETY` comments and `# Safety` sections properly.
>
>   - The addition of `.clippy.toml`, which allows us to take advantage of =
a few
>     configuration options.
>
>   - Start using the new `#[expect(...)]` feature and add documentation on=
 it as
>     well as lints in general.
>
> Overall, this should improve the quality of the code and documentation as=
 well
> as reduce the time needed in reviews.
>
> I want to mention Trevor's nice work on lints from a while ago [1]. I thi=
nk we
> should still do something like that: discuss which lints we would like to=
 have
> one-by-one and start enabling them (and perhaps have a file like Trevor p=
roposed
> etc.).
>
> For the moment, though, I am sending these, since we would like to have a=
t least
> the safety-related ones enabled soon [2]: now that more code and develope=
rs
> are joining, it sounds like a good time to start enforcing it -- it shoul=
d make
> new Rust kernel developers aware of the need of writing them, which has p=
roven
> to be a common request from reviewers.
>
> If needed, the series can be applied partially or split, but most of it s=
hould
> be fairly uncontroversial.
>
> Link: https://github.com/Rust-for-Linux/linux/pull/1025 [1]
> Link: https://lore.kernel.org/rust-for-linux/CD29DF8F-7FF3-466F-9724-BC92=
C14A68BD@collabora.com/ [2]

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

