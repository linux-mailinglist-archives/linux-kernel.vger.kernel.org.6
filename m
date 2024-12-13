Return-Path: <linux-kernel+bounces-445303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E183B9F146F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE8016A752
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC6B1E47DD;
	Fri, 13 Dec 2024 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZNiODeu"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA16618452C;
	Fri, 13 Dec 2024 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112533; cv=none; b=jsbe3hUHejgpP4NFOf0e61jM9RXMSdKKQYFt6fEViKpoLLuv/cWVssQUXEOF8ht/FuzQTQogM4iB8m/WmCW4Mnp728Ma+iyn7CiH0EhKeDkIbQDZqPkU3MHUUpfdUjmvInMwFnM7BeT8bW7w9lRQ7DJqRi+sZBmwWECMFOlB338=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112533; c=relaxed/simple;
	bh=p3OV3cxpvnjrKQbEtfJHlYZ3wSxRsZqXX/eSALSX55g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOz8LZa19NVBqGoVmCmvM0SXtsXzbQ4bOgq2aHOLslQr/owc9iNcfHewRWdy1iAnZtc5szf3BAVqXe1e88jlxHDvBRDnuRw0y0T7cZvtVcDMkKz2bRkpzhRTTSfQaeDLSeMaPkptuq9knKzaEJ/K14bY/4qUAnOFDn9CoA5EPwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZNiODeu; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ffa8df8850so19429821fa.3;
        Fri, 13 Dec 2024 09:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734112530; x=1734717330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3OV3cxpvnjrKQbEtfJHlYZ3wSxRsZqXX/eSALSX55g=;
        b=YZNiODeu67CuFoNcehiHndAkyD5ZQV5ELjQkaTgPWN9VPlgH5JR3MLlaOKWX3l2gZL
         J5h0kBf0HjKGxfQIkW29DTcD90MHXpyRGxZ6SASc2CUg0pDrdU+SYEYP3PfcyWFvz20V
         dlEFygDfuFSwNV01V4+rZiX1t7imeUkZ9aYHAi0KE6AyISzCT4C4ZUOr2Z5XTRp56LUm
         Ge7f/ucGqjKtFOY/itg75Boi+0PXHGm4JbfypxBG5AtJNuj/3DxiNIQdZ1OFdi4DaFDp
         ai3Wo7E4qQ7pTlpRQrzfdddm197nYMYEqkJEbBvoYBM4vVmdw3T82T4HAZB9/3pW18eN
         1u0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734112530; x=1734717330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3OV3cxpvnjrKQbEtfJHlYZ3wSxRsZqXX/eSALSX55g=;
        b=NLhM8swBkD7+xcaeShyBwZXrM+8pIkNfWl1XLKMR7DNtDCKliPJh+olfep6mrusHm4
         fb2OCoq404zTNqBJl2dg3rnyRphRl3URdqM1mo5mgHvVOG46VTdMfKjfX5ozTt5b5rzX
         UmGpl2u8t83t5t7UCcCVoUyH7K4fiw+ornydOEIs552E0JnSbP5EIwL3dOYJCS6EH3mc
         bRPQYjeS96QbNXZzBnA5EcmZCsYjlWUPdy9Pn2cU2CeP1Xs7fF4q8mp8g1m8lryu08WT
         Z13ROSKucRIGEO++fMMtHRbgTo2Tp9oy+4MivRx5cSLUTHMs5Eo7HZyNsL17x6qXLE8B
         RdyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0Oewo2j9JRTN9Df+tXQiuUio1HZGvO+XmebofjjmI1zkZ/aFs6GxGYvDuZZQ6y/CB2S9Igd5uiHpjQ0k=@vger.kernel.org, AJvYcCWDwiW36NkEaQdVdl07N8Ppo36kTCJVAv4cMZMnxRVW67W8Rbus+/7mpm5wlebg5b5TJ1tKMTQvwy5yFLTwML8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDIAuZiLH9FIBS6dXwDixmKMFEVgLZOgUF3ihatTZVu7Nf35xV
	0AmpNRAUQHzWsUJtixsyqORnf9vzoarTNff9ohjL4R07mmOZviLdTrDADymJd7bcJYLnIbNUILt
	doku5hjV9p4fLTSE/3RF44lKyI04=
X-Gm-Gg: ASbGncs453++kQ/k/8r/RlQn7ykknDfOOC/6dXKlZNeObxwrEZzGLzQXAioql8uYyFR
	1FNKpnrkqGpQCxtoqvOlX/oDBv8cOlQcyyJf97kjFw33Ro9qi0xF+7w==
X-Google-Smtp-Source: AGHT+IFOywdTPEna0dez64m8puagTHvJTv82BKhxxmX+nDi2aRCk3GbHibUmf+7Qe+loChT0PkI+fkfyjIPQBHUFP70=
X-Received: by 2002:a05:651c:2115:b0:302:48fd:6922 with SMTP id
 38308e7fff4ca-302545b769emr12303521fa.37.1734112529590; Fri, 13 Dec 2024
 09:55:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-rust-xarray-bindings-v12-0-59ab9b1f4d2e@gmail.com>
 <20241212-rust-xarray-bindings-v12-2-59ab9b1f4d2e@gmail.com>
 <CAH5fLggwK0LXAsBnP3FtFHCnEzzBNNZfsCy3iJ6w=nT07CHgVg@mail.gmail.com>
 <L-1MAJJDE02BClBz6dbLWTKAz6RM33gupqt5fPEyX9tYoW43aDrrH4oY-OerHc17mpVTgy6j4e6_EauQQY8Viw==@protonmail.internalid>
 <CAJ-ks9mTEcRg6=ZiYFX3ebHSYgMwTv692ufUdTCoA1vX5E1nNg@mail.gmail.com>
 <87pllvczag.fsf@kernel.org> <CANiq72kEk5y=As6rOSe6V7w7AV3qg7u3Dd+PKtwWzzDEi1a1RA@mail.gmail.com>
In-Reply-To: <CANiq72kEk5y=As6rOSe6V7w7AV3qg7u3Dd+PKtwWzzDEi1a1RA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 13 Dec 2024 12:54:53 -0500
Message-ID: <CAJ-ks9=_nO292bvG=ir1o8dLvc=MGdT__m0pU48-qn6YdwSJVQ@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] rust: xarray: Add an abstraction for XArray
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 12:24=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> It is also advantageous for the submitter, because one wants reviewers
> to have the easiest time possible reading your code, and reviewers
> will be, in some cases, new to Rust.

Implicit in this statement is the assumption that while new to Rust,
those reviewers will not be new to C.

Anyway, I'm not emotionally attached to this style. Would you prefer I
rewrite it using loops and conditionals? Whatever helps this land, I
will do.
Tamir

