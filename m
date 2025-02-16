Return-Path: <linux-kernel+bounces-516577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8F5A37438
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 13:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1C03AF44C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 12:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEF8199935;
	Sun, 16 Feb 2025 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHalJ6qt"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B182191F98;
	Sun, 16 Feb 2025 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739709644; cv=none; b=qNW2Wke25pBDduOUBLwi/YqkpKS65Rx7lX09bUXd0Ar8RyiThkqz3Unanl8E8gAMyF6RaQGw9O1Nf7U6HHvGAh9mSUVEqxfETgDaXpCIG4zXwpRaGfx0zh27RADBkL9a9ZYfRWFDWTQyW8SvRuKGwThIPuv6u8UYya75v+h2CbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739709644; c=relaxed/simple;
	bh=PiMPkySkppW60OVNSM02PHcpoR5sWMEZlYK3uYSPEM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfNTj5j0L0McIVszZw93UzTcrpf34XRZrozWEEuOi6waa9nNUZTJ3lBbIScU2WZXdNZxhH0GGfPf5Zd5dZkWKwoiVllmBcYIoiU2ZYIpiBbxS7itRkpq7dvGq+EVFTw0OdCfMAXpow1h/YC0JfT46F1Fl1dq4hWDVxHjFJLAHLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHalJ6qt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220cb083491so7496105ad.3;
        Sun, 16 Feb 2025 04:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739709642; x=1740314442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiMPkySkppW60OVNSM02PHcpoR5sWMEZlYK3uYSPEM8=;
        b=LHalJ6qtiqHEKfx0MacPu6VzWjSUjpf/NCENJE4+iaVqqmAeUdkiGrgtYhGWnk7Dtq
         nu2JdOcrAaR4QfKXNa2KO6KsbXzXtXR4gU2yCTL/u0HYSwcsxGTlMU5SUgd4CUR37/Zw
         isH6XXxnmZTFjIF8az6Jr2RM9kK5+NPyZRxrx+KNqxh98SfLdwk5mrS18h6jA6zzSoyW
         Am67zFfnNNtmPhZTqprTL3e/zMiK2YiOczu3MRZr3ft/r3HizNFTv4TPgVRMt0ww8zRR
         3b5lDiA5dobFzFtkqP+ful/IDys/DcSjn6lmGlATWco+lCEHqbRXb9ihr7glHas5tdxm
         /Tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739709642; x=1740314442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiMPkySkppW60OVNSM02PHcpoR5sWMEZlYK3uYSPEM8=;
        b=iyccDN64hAKUj9PsG0RcPrzMFkT8puO0C/ZU9YO4N53oSdTxIEPAkp/5CsCYAi1NOa
         dAsddpbUQiQr5+lBDms5UF3U6z3IgTlX7n0lmu3ph8X6ioJHyIqNC0y3jgibn5MmOlbE
         rv2LEWdDWB8s7cCiowJMLpsAX5/7SXo/Kt0DnhVAAcCnqjycOwTyf64YqUmdEJgzf0Bq
         sAnK+8kEgICgAcrRYBeNSKiEhizE0kl9kSTwdH+2MAlgnEVnlYW0LU+Um+6XelBiaEwL
         QDQ1CgHisPniI2acwDASUPeE0737Aq/not4/CdpoPpTPn9I8UJ0r3cZ9PEHUt/EVjxr9
         PXpA==
X-Forwarded-Encrypted: i=1; AJvYcCVoiptKAoGb93mGAGAxNZ91TYc+muX7FxmiEhwVVwAPsFdtzR2o/aqFvhbISLCJ8lKMXKG+2JYxKANOiFE=@vger.kernel.org, AJvYcCXStyt/J349kOz2YOp7eMZrEiX/DSsGKKaeoo3xDht/GTdz3Uz0nrgsx66dWCkhb8Pctk54/GOSyeJ0M1mqNOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy89DzznQvr03UYh2hjReU+BiJNyZ0pdQEDcThEiVt4sBzrEUo8
	NyT8THpU3BrFXxHkrM0uUfMgyTxxrW8aQSytu5EKCtmvv7SRmPscilAJ16iBvh6bgJ8RWBQb9sm
	F9P1v5hHompFfF4Kl9FbhzGr7f/U=
X-Gm-Gg: ASbGnctbPs3nz2A0dJoHBUGW24OSltIRfdPvS5LKrbYGNNUPBHMB6wFwwvvY1FdoSAE
	yRvx+zkOy7f5sKAfAjIsxKjF2MawFhiE2DsyJRVpYoCCNfTkop2iZq0giPnSuMCUDQDn5ZV5b
X-Google-Smtp-Source: AGHT+IHJTAMuwsJVwkSangFDxZ1CdXoCDX8zCfyQaQkxp0YReVa6st9heBbVKddlUVFJAYIdXIwjVyoBPCBt4bY3ymk=
X-Received: by 2002:a17:902:d542:b0:215:a97a:c6bc with SMTP id
 d9443c01a7336-22103c6dd55mr36013805ad.0.1739709642226; Sun, 16 Feb 2025
 04:40:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215223106.2346285-1-benno.lossin@proton.me>
 <m21pvy927w.fsf@posteo.net> <10690211-eb3b-4b95-8d9d-35c62930d924@proton.me>
In-Reply-To: <10690211-eb3b-4b95-8d9d-35c62930d924@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 16 Feb 2025 13:40:30 +0100
X-Gm-Features: AWEUYZl1Z6eCgO4qp8LwTmSceeqr5juaYSjPp0ON81ODkoRWjJ7FttsuVFTrmnY
Message-ID: <CANiq72myMWv87Me2C6Nmse-p=4YL=J+ZTEHe2hu7AhbpfZhgyw@mail.gmail.com>
Subject: Re: [PATCH] rust: fix clippy::too-long-first-doc-paragraph
To: Benno Lossin <benno.lossin@proton.me>
Cc: Charalampos Mitrodimas <charmitro@posteo.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 1:18=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> I have done some more digging and bisected my Rust version. It turns out
> I was on a rather old nightly from last September. I also don't get the
> error on a newer compiler version. My bisection identified that the
> error last occurs in nightly 2024-10-18, so from 2024-10-19 onwards it
> compiles without the error.

Thanks Benno, that is very useful and saved me some work.

> So probably `-Wclippy::all` implied the `too_long_first_doc_paragraph`
> lint in that version. That is probably because of [1]. It changes the
> lint from style to nursery.
>
> [1]: https://github.com/rust-lang/rust-clippy/pull/13551

Yeah, sometimes that happens when working regularly with nightly over time.

There is an upside, trying to look at it positively, which is that it
gives us something to look into from time to time (i.e. the new lint)
and give feedback, and sometimes we can clean it up anyway, even if
the lint is broken and we cannot enable it just yet :)

> So we don't need this patch, as it seems this never hit stable. However,
> there is already a patch fixing what this lint reports: 2f390cc58943
> ("rust: provide proper code documentation titles").
>
> I think it's a good lint, so maybe we should turn it on?

Agreed, we should -- it is something we tell people from time to time
to fix in review, so hopefully it will make patches better before the
review phase.

...well, assuming it works well enough, given it was moved to nursery,
e.g. in the linked Zulip thread in your link above they point to
https://github.com/rust-lang/rust-clippy/issues/13315 and
https://github.com/rust-lang/rust-clippy/issues/13538, which we may or
may not care about.

Thanks!

Cheers,
Miguel

