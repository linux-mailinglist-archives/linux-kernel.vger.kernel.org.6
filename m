Return-Path: <linux-kernel+bounces-510797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8FCA32219
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF2407A3736
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2966E2063C7;
	Wed, 12 Feb 2025 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="beDZ1uQ6"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE246205E2B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352463; cv=none; b=axcrrdkFqJE4V/SaQz2v57wuOu+tvy/eI5PPFqoFVe5I3QxffvnszvxgW5+tBI/MWHwX5GkIQDEyQHQPIYERtVroO47f7xUDiZNGLXa7tu3ytNwJR4/y1AXj/0fMzaUVydMvpbqvPof0Okb0cYoEdphfsLJy2fwDXSphfZzXlOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352463; c=relaxed/simple;
	bh=B/wuOw3hID9CJP9Am9Ym39ADJx9EIF0zXIaexPlV3eQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgjqrsaFVPMDsFK8W2S/A4fp+QseNOYFPUodRf+6LFnPCklgEXvNSB6b7uo+ge+abH8pQ7SXmvGyhWP01SMbXr04C9fzTeb6X8kSHB50zS/knktxfAnj+a0oEw7fWDcrzuFp3aOUJ9p5qwI5Mkut9abXPCImYrg5l0K50lHQ7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=beDZ1uQ6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4394036c0efso21785205e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 01:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739352460; x=1739957260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bc1m1amq8DZ3YHH8BDcjtNrzUYHqM5J0JjXdezkBnZY=;
        b=beDZ1uQ6lH3+IXmi1dTjSFqFv7v9XNhRbO2TldxKHxI3yRk/gnR96hIK2ctBidNwIP
         wsHX6E1zumsftptXVrRGJc2a1Py52eUCN4/YP3h8s740kOdIK8gZ+R408ZdmsY2tjApQ
         duh/Bz4WAPIn4UoAL1UidYrOK8SicywvpkEJQY8XaOA0fhYHUO2J9npebFXY5MSC+ATM
         V1hb4NNCclzpwv767UPZLbFkrjoauDeqOzeA4yKNWb1Q8uGcuwX7SnkgDOWme271w5pb
         b98xyNR7LHGAPaVeTmCuBkukoFAZ0XP1K0AvNfSr0qeyfV9s7UHo6xQCk6Gca1y/tnAh
         pB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739352460; x=1739957260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bc1m1amq8DZ3YHH8BDcjtNrzUYHqM5J0JjXdezkBnZY=;
        b=ZIo+zMyzSDyC7k0ocer2Cn4hq3vRCUky1Ujc0g6ZVARBPdirYbDqAYH6aYGyVDVbOS
         yCyCUa8AGWdvAedlNHRcllRnVbO1L81VO0lW0yOcHj2fPxVYB13FjHLSeuLdyhDOjt0Q
         mk+L67ZDPGwkKEINUPPl8u1OMM21GWjIjLGSmUXGXCuNOPShnNQklbJ4q6HibD6QE93N
         qWCWerUQPTHxwOahdM7Luc8BdEqze3bUIE2Y20FvYYSohl0h9YoNL02bxLW0CPi6RNCV
         xNuRN/4oB9sbHpJjcljpJOe6LwtImgXsgKgtlbUkd2ITp2awBxci0ctPPUZDz1WCAMWQ
         NpbA==
X-Forwarded-Encrypted: i=1; AJvYcCU2U48JPnWcOY8GuS7KpPOA0l6UsyslAGKQ6fY3W4Pxb8e892VhplLx6bN7DPIbAhwwExgHtG4hobWTMzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXpoviGU8ShOjs4X2QY17iHE1YFOzw7KNwLkwJ3tFwWwnX+OIg
	p0C7tGUmwr3z1NEhW2fstI557lq/H5AtL6HpEkFKEngNsijz/DwtWK6xMVY/5CSMMtsuWYyKQOE
	iY4iSCKDANb6AbKEJZXjQRubeYtu2LyglCHDG
X-Gm-Gg: ASbGncvtYUc2CTgqYsRq6OWohxfszNSulCTf8EdtJYXrZJXVFsONA3DhfIYIsKhJgck
	sr/NZDZ0vvMXutdY+P4a18DZdTup1vJ6Ss0F3SytDOcYftslvKsavUnTwHwgOPp0T1O3ZiItkeQ
	==
X-Google-Smtp-Source: AGHT+IGFvvPcb8mwE7p42LVWeaeA+rWLPBy/3/tBPUkRHCkxCRjbs9fMbGYAzeixSBWbbJDbiF4tjdlW10GZogWG+oo=
X-Received: by 2002:a05:600c:1d14:b0:439:5516:dad1 with SMTP id
 5b1f17b1804b1-439581b76e6mr21779605e9.23.1739352460098; Wed, 12 Feb 2025
 01:27:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210163732.281786-1-ojeda@kernel.org>
In-Reply-To: <20250210163732.281786-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 12 Feb 2025 10:27:26 +0100
X-Gm-Features: AWEUYZkYetDDLcmE6nDR_-R5xfXvCqjqr2MixcJqSNgrzdBxocsoOKPAtwlLknE
Message-ID: <CAH5fLggGLbL+oTfOPjtCvw1cTLzJU6e+dmZoF1uy1QVTtRq3yQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: rust: clean Rust 1.85.0 warning using softfloat target
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, 
	moderated for non-subscribers <linux-arm-kernel@lists.infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>, Ralf Jung <post@ralfj.de>, 
	Jubilee Young <workingjubilee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 5:38=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with Rust 1.85.0 (to be released 2025-02-20), `rustc` warns
> [1] about disabling neon in the aarch64 hardfloat target:
>
>     warning: target feature `neon` cannot be toggled with
>              `-Ctarget-feature`: unsound on hard-float targets
>              because it changes float ABI
>       |
>       =3D note: this was previously accepted by the compiler but
>               is being phased out; it will become a hard error
>               in a future release!
>       =3D note: for more information, see issue #116344
>               <https://github.com/rust-lang/rust/issues/116344>
>
> Thus, instead, use the softfloat target instead.
>
> While trying it out, I found that the kernel sanitizers were not enabled
> for that built-in target [2]. Upstream Rust agreed to backport
> the enablement for the current beta so that it is ready for
> the 1.85.0 release [3] -- thanks!
>
> However, that still means that before Rust 1.85.0, we cannot switch
> since sanitizers could be in use. Thus conditionally do so.
>
> Cc: <stable@vger.kernel.org> # Needed in 6.12.y and 6.13.y only (Rust is =
pinned in older LTSs).
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Matthew Maurer <mmaurer@google.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Ralf Jung <post@ralfj.de>
> Cc: Jubilee Young <workingjubilee@gmail.com>
> Link: https://github.com/rust-lang/rust/pull/133417 [1]
> Link: https://rust-lang.zulipchat.com/#narrow/channel/131828-t-compiler/t=
opic/arm64.20neon.20.60-Ctarget-feature.60.20warning/near/495358442 [2]
> Link: https://github.com/rust-lang/rust/pull/135905 [3]
> Link: https://github.com/rust-lang/rust/issues/116344
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Thanks Matt for boot-testing it.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

