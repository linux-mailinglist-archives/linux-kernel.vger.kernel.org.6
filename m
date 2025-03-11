Return-Path: <linux-kernel+bounces-557043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F06A5D2E9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34103B56E6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1131C1EF087;
	Tue, 11 Mar 2025 23:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mo9K+zR5"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261C57B3E1;
	Tue, 11 Mar 2025 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741734082; cv=none; b=mVlxpIZw4u38VSQiiRuVtkB/AlSJxJ4h0bCiHeo8V/Nw2S750xEpeDhi5ExCFf16R2JJh4+x5iSJLQtNmCpYsBH52kcvLvleKGAChLcXfr9qiSW0nBvH/VQI8lndK5Hqa5O/J/N49uWSmrNaotQfhEzctvP6cXdFUxd/egAwnwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741734082; c=relaxed/simple;
	bh=067un8fOuEgN7Z61hoe7uWs3BRycmqNfNpveg9VSU38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAQFUviWh/w6z42EOcoSfTq2Y9sswiA8ix3weK3FDS56r1u984X1hrXf8dmZ+1FHZ/+czHn26+52//rPnVOoCqzNIdFocLzXb9NVDHxtpeMjgInRD9gNVW8otAh/7sKQcES2dyRnrvHZLVawSGrK+IPItMj0v5dlsgVsanM2Qv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mo9K+zR5; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fd02536660so1575707a91.2;
        Tue, 11 Mar 2025 16:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741734080; x=1742338880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=067un8fOuEgN7Z61hoe7uWs3BRycmqNfNpveg9VSU38=;
        b=mo9K+zR5WVX0iMFosINOArX6mTt1UKNlrJNuXlSw7Jc6Pog+ufj4BXRdwhCcT/scQG
         G2s72Lr4SvHqQ8bKOcNS5prYliSSRnvf6xNck/0V0capCj5ejAiejy2PAl6dWGws1YJ8
         zerFjFhfJFc2OMW0WGTOJ77il4nIkeJ/XRV2MIUf06ZsP9w6ffNuXhdGwu7CY8YHILNr
         55bgA1qATTccQ/MiiOPrZNZkyYHmQxDyXYNhPh1U0nBzj3TE9pvpvY0B+XUZQT4xbEGf
         85UI3jYZR0oQjRsVZ4EEKLPCJcqwHk463URAot/58TXS7Ok/CeRXkrZM9iCZOHIu8k3V
         tLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741734080; x=1742338880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=067un8fOuEgN7Z61hoe7uWs3BRycmqNfNpveg9VSU38=;
        b=JbDxscGSwYEEyOwOlisQ+VCQjlCpfrtPEsMGR0xTZOH/ztfCMThd0lzmtm58iVY5wE
         vsctZkOr8vpJg/Z3+BcQaKjp0Rs/tt4VRc3BM2jKWLRyxYjfoquFqEzKzUsJy2YCStR4
         OTDfNvDvoA/VaB5bxFi7QVieEJz8GFLN9Gz3By6DyBO+Yuk2sIC9rqyYsApoW9L0DEHg
         SY0Mxr6LVYEt2HsE1fJIvDV+YPh9LvpQmeWS44gd+KtLvxmfwjGegvOORYxGamlpvQMW
         BOqHDQ3Srr90mG8lLc6v+pKdZbmtMcA7HYw/TZeAusgRNuwQ7+XVJ9+b0/99aKQnBnjo
         /Hbw==
X-Forwarded-Encrypted: i=1; AJvYcCXX+LAsMn0F6FRD4ONGhxzXQQ2kgg1inF1oH7LoGej+0hYUMvUTzCbpqxVOYDKYO/NnlbGRvDNSX7VDWc4=@vger.kernel.org, AJvYcCXaFeCJcNpEPXzrWMewsFE3+ePCaluH3O+PJm8uewXHpRr5emO3CzmYQMQJ0ulQBr4ULHWVhkPEte0f3yj5AEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0i/u9j5Im7zU74wqxerM0QXcXbzGc7whvHU6ET1//NP6EpKwN
	+HlByxaeMdkgw9+EMOCkVZAaCyMUraLnTay3b9MX8cpf+AjtmOC1kN+PitoTMXYmIZxZ7qlc667
	US+buXXU5Y4IPN6XY7ZVpu0GZwx0=
X-Gm-Gg: ASbGnctyAiHaplETmvYEGKK5luuA0EM4D1Bc7PnXKnuYqqP0cwG0fJAQZW++yh50Ffi
	7AtRoq0+79RYYuFebY77/tc+MKrRWY2l5vomv/96dKm54wAzWwRROAYrAM3r9vtA1kn6BQkiDjd
	7pVc1E3n19wNKtyHa8cULc5kPN5Q==
X-Google-Smtp-Source: AGHT+IHAtKn4hDo0U6vh9FlN/Lb4EIPVxsOHrP7TuYtAYYHAthh+Sj3skKNW0q5UR3pMaLkmwuPAcSheSsHaazzZj/U=
X-Received: by 2002:a17:90b:1b52:b0:2ff:7b67:2358 with SMTP id
 98e67ed59e1d1-300ff724c14mr2597548a91.2.1741734080165; Tue, 11 Mar 2025
 16:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-rust-analyzer-bindings-include-v2-0-23dff845edc3@gmail.com>
 <20250210-rust-analyzer-bindings-include-v2-1-23dff845edc3@gmail.com>
 <CANiq72=YhXGKLuEfvK5XnAsc0sbuf4FBRt_GnzmrZoW_L-S-ow@mail.gmail.com> <CAJ-ks9mSqxzV8F=SwGeHpXbRZ1814Cxk+AiyMnyjS5h94JqxFw@mail.gmail.com>
In-Reply-To: <CAJ-ks9mSqxzV8F=SwGeHpXbRZ1814Cxk+AiyMnyjS5h94JqxFw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Mar 2025 00:01:08 +0100
X-Gm-Features: AQ5f1Jpmd8XCv7vn7M6R4ZxjilgmKw2Gfhx5DNV6JYkSn_Lx_9Tj89MM2Nujth8
Message-ID: <CANiq72=s8mtLQwWuKj+VER_rR2PzHv5JHEW5o026qvvidj6ZzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] scripts: generate_rust_analyzer.py: add missing include_dirs
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Kees Cook <kees@kernel.org>, 
	Fiona Behrens <me@kloenk.dev>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Asahi Lina <lina@asahilina.net>, 
	Boris-Chengbiao Zhou <bobo1239@web.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 11:48=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> I don't follow this; there's a bindings crate at 8c4555ccc55c
> ("scripts: add `generate_rust_analyzer.py`") - at least as far as RA
> is concerned.

By "before being in mainline" I mean before Rust was in Linus' tree,
i.e. a long time ago in the old `rust` branch.

Back then, there was a period of time when there was no `bindings`
crate. At some point it was split from the `kernel` crate, which did
have the `include_dirs` for that reason, and at that moment the
`include_dirs` should have been moved too, but it wasn't.

So we ended up with `include_dirs` in the `kernel` crate for no reason
(because AFAICS it was not needed until we got
`generated_arch_static_branch_asm.rs`, but I haven't actually tested
that in RA) and missing it in the `bindings` one where it was actually
needed.

(I was trying to understand how we ended up here just to double-check
why we had things split like that)

> Yes, without it `generated_arch_static_branch_asm.rs` is not found by RA.

Thanks for confirming!

Cheers,
Miguel

