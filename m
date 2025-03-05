Return-Path: <linux-kernel+bounces-547973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A81A53E46
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1C51887E3F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA682066FA;
	Wed,  5 Mar 2025 23:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU3rURh2"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4714141C85;
	Wed,  5 Mar 2025 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216490; cv=none; b=d4LFC4Fu/OlqJpXeDSccqFztSKyH5sJ2eS0qYfmxbN1E53CkN7mbgxR1G3n/rw/oxJFlyaRJotsM63Nh0cnV9tx+n1O192B0eJEr9CXvU20Q/j9b3J69mHX7xgM3lkiiyaSIk4n5WA3e+clZFO5bbf2Ia1+Ukzh6QC4c0EYDi18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216490; c=relaxed/simple;
	bh=xzcNzQCQI05nT+orbSUWP8MClliAPHzBH3EdWb4UZ6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RW2esFh+Yq3/fEIR1GfDN6Edh7irCq0ymnB7Xv8WtPOsuVWPIrUWK1/5CAPyWBbTsVlHkeh1CJ3ZQTYT87Jb6EbrFSwq9f4ztdfFEdkJe2R2hGt3OkedVADT7N5o8lmRRlM1BGuj8AOFKs8qTGu67KcbqEdfdbiNL+K71XIIqT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BU3rURh2; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5496bc767abso11204e87.2;
        Wed, 05 Mar 2025 15:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741216486; x=1741821286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUGuIKSVgfj5PkulMXy+9B3uvmZJaSgoO5LYtespsTk=;
        b=BU3rURh2uRjPjjMW3W5u2I6D1IgVhMawyeeGWIRnISVQ+G1ajBIVWzXkGsSfN5rdrh
         lHglkiUN4iwJZFShcCE2BVAoCFiyfswf9uzA3ZRLa94IoaZpoPAUbxelbwdUSlh/Nbh4
         Sh+/avHUvTnWKqzQ6AwDECpL3fbhUBu7/Wu9GT1p4MeS189x8fMIdSLyICUrxc3t2p/Z
         GNvUUz1uL+mRITOVHCeR4jjsgUL3vTzdWCCyPvkGtrNHAhBrETzHfci8bxm31dkAd8Hn
         dRT0xZQk0Qt5YQO+T0Wd1k6bRx0yybTnphsre+TxKw1KwcNMJB7OWFqL7779XylhEjf4
         3JMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741216486; x=1741821286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUGuIKSVgfj5PkulMXy+9B3uvmZJaSgoO5LYtespsTk=;
        b=wPmblf6MT0nI1iuQbX2lcPJry+pO01mat1qNc0apkCnrIIoAVZGJqL3x0zPnRctBmS
         JqTg9II0uDrBcjNVsCc74OvzM5vpZiugW7xUHyNdGkCfPHGawdIiwi/3gL5wwyCnnPJu
         6qIfPwbOCVuTYaGcfSzuChm2sLohlU4tcHKX5vDSC4ZQ/TDrJHhemKJ4dB5xC6iCx+j/
         fsmW5Hlw9i0GURgzWsGoYKuTCZXWO0VkMnndDO3xUt2qxxHGLCtVZBw4RPewkmQX8I9u
         sKY8djnfD/+cwY0/FMly01pn3Gj3mmIgQ/HXOZwwLudqNf55U4vLtxnTsG/3s1BAES4o
         rtnA==
X-Forwarded-Encrypted: i=1; AJvYcCVx6lNGDok/jZrA0x8MJ3PLpAVWYzwYiAC08C/G4tagi7hpv94JUI7PytIQYdNgVsPL+rjKV21uiXwhTRIIlyA=@vger.kernel.org, AJvYcCWMp6M8XQN12XClucn4EWS6iJmvTnqiCltjlYSY9MxNq2HdIH3dAqKSKLAfAGjCqtYLz6Y1sa6aAUpuT/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2OXOVoLXwXE56zyvk01l8ThCtWcdRHKbvdep86mLVo7F6yDAz
	732VrTUzJon22B1lK19f7Z6iT09CNeJBmq1BpvN/n+TM2e2mNZqCkWVAlg2Gz3y4/bWAjGo381C
	TO1kXj1slSw0cW30XLxzrP6SdKPQlxfzi1OcOEA==
X-Gm-Gg: ASbGnctNuemeby2i3YOm35ZTYcDlgfrw+zhGtFOhOlGdiTOT3oj6Imh/IAcbYevvulK
	GZfeeMnTc5qTFHPSFtRlogbNbHdmrrZPznPtxR5QNciKj4YU23X0mYiCtSn01+Ob6yJdSKF77gz
	veDXdMiVt3rUdKcGN+IzekjQlt5w==
X-Google-Smtp-Source: AGHT+IEr9pv/Ty6qoqALxAu2aJ1hniw0q+/wjFtUb5Krnv70uLpYyT7wk9+0Lt39dL1lEjK8WJs9xv+e1E05Sqex5Zc=
X-Received: by 2002:a05:651c:1507:b0:308:ed4d:6291 with SMTP id
 38308e7fff4ca-30bd7a49e53mr6286981fa.3.1741216486028; Wed, 05 Mar 2025
 15:14:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-rust-analyzer-macros-core-dep-v3-1-45eb4836f218@gmail.com>
In-Reply-To: <20250210-rust-analyzer-macros-core-dep-v3-1-45eb4836f218@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Mar 2025 00:14:29 +0100
X-Gm-Features: AQ5f1JrcrHxe4U5dLj0y88YDDb8_c31Nb34eN7reE1F_5k9VWPv9YuiQUkFemDM
Message-ID: <CANiq72mvhp-LiWAKEuiptyCV=-nh5i_7kJMgPq3yLbAQOqq09A@mail.gmail.com>
Subject: Re: [PATCH v3] scripts: generate_rust_analyzer.py: add missing macros deps
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Boris-Chengbiao Zhou <bobo1239@web.de>, Fiona Behrens <me@kloenk.dev>, Kees Cook <kees@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chayim Refael Friedman <chayimfr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 6:03=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> The macros crate has depended on std and proc_macro since its
> introduction in commit 1fbde52bde73 ("rust: add `macros` crate"). These
> dependencies were omitted from commit 8c4555ccc55c ("scripts: add
> `generate_rust_analyzer.py`") resulting in missing go-to-definition and
> autocomplete, and false-positive warnings emitted from rust-analyzer
> such as:
>
>   [{
>         "resource": "/Users/tamird/src/linux/rust/macros/module.rs",
>         "owner": "_generated_diagnostic_collection_name_#1",
>         "code": {
>                 "value": "non_snake_case",
>                 "target": {
>                         "$mid": 1,
>                         "path": "/rustc/",
>                         "scheme": "https",
>                         "authority": "doc.rust-lang.org",
>                         "query": "search=3Dnon_snake_case"
>                 }
>         },
>         "severity": 4,
>         "message": "Variable `None` should have snake_case name, e.g. `no=
ne`",
>         "source": "rust-analyzer",
>         "startLineNumber": 123,
>         "startColumn": 17,
>         "endLineNumber": 123,
>         "endColumn": 21
>   }]
>
> Add the missing dependencies to improve the developer experience.
>
> Fixes: 8c4555ccc55c ("scripts: add `generate_rust_analyzer.py`")
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Suggested-by: Chayim Refael Friedman <chayimfr@gmail.com>

If this is a fix, then it should use Reported-by -- or the suggestion
was about the implementation?

Anyway, I can fix it on my side, but I am also supposed to add a link
to the report/suggestion -- do you have one?

Thanks!

(Tested-by's welcome, by the way!)

Cheers,
Miguel

