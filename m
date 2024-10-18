Return-Path: <linux-kernel+bounces-371258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB129A38B3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C4C1C23BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55D418E759;
	Fri, 18 Oct 2024 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o+dt1qMx"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37AC186E3F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729240715; cv=none; b=MD6cgA0LYvwDN+DgWugGsvyBi1Tlf6Q6+QmJWFmJF/pUNLzUYraU6jIhhAoYnEUivu3WmkGSUnM/yoDfzOOaxqiZUgs6TpJUkzEkpRySiKAKCGbzGoTB8neGJnqziKgqSnCBtf2AT/aIDdx9JuX5P1RlnBPF9ZnJBtRPsEtYh+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729240715; c=relaxed/simple;
	bh=5rsysGuJqIPx87mh5cgfnJY0IcxVmSN/yeZOhX991mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFydXA2IwB0IWn7W6Wo7cf+Bjo6Sihskzg1osicXhmvdQF3wf7bRFRGAYFgSFFEHBDUA1pv2as24UF7GmuI9T66F4lHshG4Zngxtf/5d1zNwlW3ieT1R2KDQ9RUDYoa2Piu9xtvAvTe1Jczw2f279hzQu4yaMPeBi4/uyf7u1q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o+dt1qMx; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so1843738f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 01:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729240712; x=1729845512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rsysGuJqIPx87mh5cgfnJY0IcxVmSN/yeZOhX991mg=;
        b=o+dt1qMx8alKUWaR9VakV/MIw7IqgtEZQNYyIqk+HPKZ24rNOPweKxuJuK3nmFjyhH
         1AZaMAsMsPh3fNNkvI4MN5luMANYGXpvPYxnZ67kXMJBzzAh6aOm90+yQSSKj/BC4dO2
         ugaHK892g3p0g6coQX0TUqjtsIv2QA1iH3FwIkdExC3vgXh03l1QtliVc9gVI98w2xHw
         2Rz+edEUyHeGKV6Vi+c/y1//u/3H+vHxzz6+ybynReWNh8Ydr0msGEtfafWIPuW7uTe+
         u0cZsCZ/rXlUYvJ94Rf4mGVXaUrEFFy98SOql9180/fRftxCylxx5RivE6HYBalJq3oV
         c4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729240712; x=1729845512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rsysGuJqIPx87mh5cgfnJY0IcxVmSN/yeZOhX991mg=;
        b=P/TQYwj1TWE7tzG8mclteBF5YwgFtwrEm2tPTemvNIqPm/ojxMvlQDT6EdKpVmtAt0
         oWca3EG9nrc73axb+ig2u6b0Ff++MWHGbhoj2JK9FklKCDVS+DbnT6iWXsqKvZECacFn
         Wykmhx5vIq9oqTPMrU7knRhnFD+W59/zcTchQbE67kzA1MYflaTcU1w24O5pV+2FKmjl
         reoXuQTc4htM9lPOSY2wJ9oYONVZZQdL9XJxGLpz176gh15ZP3Ud5i8AjD4WU5JSHcdk
         fi8SuTaFls9mgAynRdNsV9pcEhxpwfmudV/YaB3U76g3c2kndd5UTl/7BgsYxSGD8MG9
         nHHw==
X-Forwarded-Encrypted: i=1; AJvYcCXfiUwFmv4x3ZMfUaVAImdBqWpTBrePxDb5B172guNo91FUP3ui44PqDJT4u+720q/kYarhpHaDVd3YOzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmxx+5VXaqb3C5oGWEjDaw/p01Wsz4rxxpVbLk9vXDqPtPCuS7
	4+aKe18Z+EuJ1zPG54B8ivMqyqR/osZp+X7q7v51Z5GVsQTuGtBCwCcJyp3IJsb2tfgVAse3WvY
	47LicjXAX9LqZoCKGKWbiQNbYZwieh3MbE8gh
X-Google-Smtp-Source: AGHT+IEMpABvANAQwaiBdpAUNXgOV+TAluVstbFQL613PUpCigYL4zr3qY0/T+iv7zpvIq0gQsB6fiqggsI3J2pJwcw=
X-Received: by 2002:a05:6000:124a:b0:37d:9508:1947 with SMTP id
 ffacd0b85a97d-37eb476876amr1372031f8f.51.1729240711872; Fri, 18 Oct 2024
 01:38:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH5fLgh3JyY9L6Fg+LXVguyx8iPRbHVHqTyXSfM9gq6jdWRdtw@mail.gmail.com>
 <20241017210430.2401398-2-elsk@google.com>
In-Reply-To: <20241017210430.2401398-2-elsk@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 18 Oct 2024 10:38:19 +0200
Message-ID: <CAH5fLgjv1AcSspv=-owxrsKaJcAGpxdG3g6r10imcOR1Yarr6Q@mail.gmail.com>
Subject: Re: [PATCH v2] rust: add PROCMACROLDFLAGS
To: HONG Yifan <elsk@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mmaurer@google.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:05=E2=80=AFPM HONG Yifan <elsk@google.com> wrote=
:
>
> These are additional flags to be passed when linking proc macros for the
> Rust toolchain. If unset, it defaults to $(HOSTLDFLAGS).
>
> This is needed because the list of flags to link hostprogs is not
> necessarily the same as the list of flags used to link libmacros.so.
> When we build proc macros, we need the latter, not the
> former. To distinguish between the two, introduce this new variable
> to stand out from HOSTLDFLAGS used to link other host progs.
>
> Signed-off-by: HONG Yifan <elsk@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

