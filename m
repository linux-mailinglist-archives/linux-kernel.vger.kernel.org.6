Return-Path: <linux-kernel+bounces-572640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4275A6CC91
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 22:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8397A74E3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 20:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8632D235358;
	Sat, 22 Mar 2025 21:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5VYlffu"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A705214F121;
	Sat, 22 Mar 2025 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742677241; cv=none; b=Hv3EDugc4DHRnhXefPi6zvtFjLM1LHnUluGv7HXuiwpYKbDTD5szmqC619xNGxa87YWurcbCfWUrGOPADPacuhFpX6NjF9I6IYrfJBdp66qKOmfpvss29tMfaWb3YVIkZxLSuwZS/4EluvlGAwi+37z0/PabrqyqM8Q+gho3x9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742677241; c=relaxed/simple;
	bh=t+uIrP6PQdTy3yUktGlZVz5mBCJ35FKR8kpdNcrZ0w0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnakbxoxbRxf1QzyY//Mpwh1pspTWfTLKJCbmh5x8eLQU87dYXncQK8ThTjRo1DKH29TOy8cZPWX6gaS6YFVoL/EkGYJycT8ZRnVLIQ36RoqgyQS4rRduzEr9U9fR/E17XXi8+O8V22+6wWZuA70aE1UbcsIZxb2ALGNv9KorK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5VYlffu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2241c95619eso7798005ad.0;
        Sat, 22 Mar 2025 14:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742677239; x=1743282039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+uIrP6PQdTy3yUktGlZVz5mBCJ35FKR8kpdNcrZ0w0=;
        b=O5VYlffu2JXIMsNTf86DMIh0tPV7Q1zREfmicCDnPbkdnL1eG/WW1ahQR1afBYn5c5
         tVuiW9pPj9gAWGQrgHBMxlhQuwD+IofRKS7BFUBv5/k10iFB8l+b5SGMN25pxuz9ZncT
         S86JYVeXj20XhnqrD+u6AL2aqcpXfJmqODO/JJP24nTKpb/kl0mx1KnDp2NbeDrQMGj5
         0IRzAKRrLRYGtkeFpEuaxxTi58y7gY6wpaj1VF7K3JCq/ztw/1GJSzCbP4kZnu+uz6XC
         nXRGOTwARwIkmmKOPTUSRopuaLptkL0bwA3wmpFJdjkqVx4z6hfO45moy5RKCh9HIPI6
         hSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742677239; x=1743282039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+uIrP6PQdTy3yUktGlZVz5mBCJ35FKR8kpdNcrZ0w0=;
        b=vFWXtCsdh27rg+Onat8tlI3KC90aQMLQMFnBLUszZUA9DNh7u3tGBATGGCH5ckrkDA
         4S/bqo7kiCBD7PsQyO1BcZqw+kbJPM/tW/DX8cspMEFEb96xmUhS9NCAdz21Wb9hfXhO
         EVfhJOhFLvVNhMERlrprI/Hg1d7bFEWTJQ2oowBJmsyGRwh01HFDi5FSNkG0MlxUCMon
         XmT7jY3SIjWUbFUnHGrjVoA9LQG1f6l0TJTR0S2iZFdENBcOEHJ6XQAHMvGuMlml5Tcr
         8/kx6X5C3cz10a28JqKypvm38FG0uFN4DNJJNaJlMGs2jct8U4HZ5tnvpaaotu4p1Vyu
         Qq0g==
X-Forwarded-Encrypted: i=1; AJvYcCU29vqhsjnHjx+Wd8lg/wx9PegIdysADdx1mY9XHr3BwH3c6GlkF4yIFR11mGbnX+nGSxBe1+VEXmlFjuE=@vger.kernel.org, AJvYcCXQj1yqJLoKKI2p8oL5NhwDOrsrc8e9hz4rOlDQw+Y653NFbb7p7FnPo1/y9AvvJLoKZN+j0QLDDytYw+t205o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw11lxySbwxB4CLVZlpN8dTKYPwuiOoC+x99M3KYflkgkQihZNT
	OWg+u1ShRs6eJtWVFl1FM7T0Qetopil+0/FsZE18nYywWilnwd260D9KXBktZ2pFRUee8XnGhF+
	qsCeCr0a2vvWGit1UpDc58k2MGO8=
X-Gm-Gg: ASbGncs0f7CyeawMUwaJY3pFWzCyUHLNb8UCxpKKvXkqpxJhL3gzRS7K4WDMDq5vDFK
	zStUPDlDri5FeXu9ELPX2kyVU1AkuRguMUyFQOcT4lv2HPppTMoHShE+nInw+tasduMcGphhI14
	TTvyF10SPMdK5t8BGkBLi1jrTgrQ==
X-Google-Smtp-Source: AGHT+IHpMX/UoN6CObJko0seKXczCa07uTX8BTaw7Iu8C8Ux4hkr7raaOl6tqmIY5CTWUTRqbp9tmUtqn25OcYstec0=
X-Received: by 2002:a17:902:d481:b0:215:2bfb:3cd7 with SMTP id
 d9443c01a7336-22780df0f46mr47579105ad.10.1742677238664; Sat, 22 Mar 2025
 14:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
 <v6RopSmSHmV8uiLBqkIh2II4bCry2OIo_7opQKqq2H4DftxIuRvY2YaLdhLUKw-Ndyv8MpHCgBbBEQntdLU9DQ==@protonmail.internalid>
 <20250311-iov-iter-v1-1-f6c9134ea824@google.com> <871pushmw5.fsf@kernel.org>
In-Reply-To: <871pushmw5.fsf@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 22 Mar 2025 22:00:26 +0100
X-Gm-Features: AQ5f1Jp8TYnJfOcFCj5LEg4YDWwMDyEMEIIHodm1diMs_NbP1j_3xAl_CdT2pvs
Message-ID: <CANiq72=QN3Sr5xS-uFhZVX0+L2==moR7cBzRJ8kKxDa5s75-jw@mail.gmail.com>
Subject: Re: [PATCH 1/5] rust: iov: add iov_iter abstractions for ITER_SOURCE
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 7:54=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Don't we have some kind of `build_assert` macro to do this? If not,
> maybe we should.

`static_assert!` is the one (`build_assert!` is the other one, which
is a heavier hammer that should only be used if really needed).

Though our `static_assert!` does not have support for an (optional)
message -- we could add that, perhaps as a good first issue. In this
case it is not a big deal either way.

> How did you arrive at this conclusion? In the discussions with Ralph on

Ralf?

Cheers,
Miguel

