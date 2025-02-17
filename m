Return-Path: <linux-kernel+bounces-518343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F8BA38DA6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6853B2A14
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58E223906B;
	Mon, 17 Feb 2025 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wbb0lRqS"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ADD372;
	Mon, 17 Feb 2025 20:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739825289; cv=none; b=AG23b7GfoCiz/+Za38QO8BzugGDkig4n4BCyno62QEnMicdSrEwD36tIztdlbxV4EEafzhdk/ogpGFqF9i2X+cVeHuj36Fwq1e6B52WbpB3es2uVBp/caxBhl5eE8xUCSiN2aqy+4bYX+ivBFFxTyqLrQhKrC3O6w+N6jzynp/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739825289; c=relaxed/simple;
	bh=sI5r+O0It/cjZ9CmL0lR7e4Q/GPxg0ZGywqZjOSz+vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPnkKX8ovo4CQXaO7pjaHnj4FBCGyDIyJ5azg/0DHDkVaD25AIlLdHZpqPyqnMuisEhsc/PzkK1jlgaJxnml6P/NQ2G4rH8p5GNqte/RcHTXcEE1ZYHhb1ybKXJvO3sL/wBNxrq0HWUI09x/n7DCm0zhJbbn5xPV7PC6tAJ5mYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wbb0lRqS; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30920855d5bso34950281fa.0;
        Mon, 17 Feb 2025 12:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739825285; x=1740430085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBnEtgDXrS3Iq43NK/WiujJi82KZNp8oMdM7dL15NAw=;
        b=Wbb0lRqSCn6gUB0uV5hD95+fQNHTMixflJChN7TOs76bEdk4HWZJsZJ+OWOWC0mW43
         7/4V/6GJBZIWKQ265DJSNCAuBPmf5SUaj+2UiXmC0+iLj8VoxVvSjfGtuEx6Jjb5RYYr
         2F32Xz2NAhz323eFEeIiBdjwlXcmnxZzcD3KnsCTzyuFFa9hH09NYSTmk0Q9QwbOR1MI
         6qqMkCGU7M2ZBn7qLdyROyhcEvhq1dwoT2kt9SrQf07nt7M7vDY1YPpb2Hsp2FDsWkbn
         AqVYuwCMQkt4D4j5QD1YiaFSB8dXKQolHI+BonTIQzvQS2IcfvrHBpd/KzhNp0uNAodQ
         /kuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739825285; x=1740430085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBnEtgDXrS3Iq43NK/WiujJi82KZNp8oMdM7dL15NAw=;
        b=HCD8hOudSbFXRQmTE+seSq6wHqut243jabmgp84qXlWlQN2Z1FElhAv8Lduk4Q9yhF
         W5JJdXQdfA0IqYl6xzqo1GFh4+zggGskG1/igPakUnqKV30D0Bk6wUeBQAxK42tSixJf
         KOFaK0nHzqFCWltO4/tl8a9Zo+Xyvbd4JUF+Yl1eyLc9GRxvwdEUHaMPTPgRCQRkHeEs
         crG5tMMM4Toch7pCZK3Km+LpqJ1nHT4e6h7WCDaR4FWx481x+wVFYkT5BSuR81pdHNIv
         TmXM8OISDY66aswW69NLdZ7xB/wbuBAp1YAokvO1QTdSozaVMmbzoEW8QriDu1Pggt4e
         XZEA==
X-Forwarded-Encrypted: i=1; AJvYcCU/X7jSLB/e/tdm/74jMA9Gq8vGo5FGZTSmjcW6T4//tiFZrNnJQBQ5u1FdhV76Sf7jDq6WRf9Ek1UUni8Qf5c=@vger.kernel.org, AJvYcCXqIQCKHAmp/kNndMxfBWRbzjCWyJqXaLl4OxLl7Kwosx+vUAVDkRnzlLjmx3k2GqAmkVCWKYZ1q51RC10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgTdhHij2Hus4TGi5IyXyROSwf+wSvrxv5Y0NGThraPK2IqUZM
	h36CerTq0ivsnLzoomYJgHLBHbvIV9KQeNSLkZuVqNjrnbwXltXWKl6YadIBQTRDttpdOxh9Xt9
	oMrseGAemHIf2OutnFb4nLxbOYBzxaoWQh6Q=
X-Gm-Gg: ASbGnctXaeLlrL+r9noiJVHGuZDme+6MI8Y2gLIDOQFx/GsHVStDoxI7V46jeFbWToD
	zxXL/mJ6b8JVGMYNj1h3HJJIb874Pi9tlOMR+XT+1Ml4ToYMSXSVePpzWFfCfg/XdBL5dHAM=
X-Google-Smtp-Source: AGHT+IE2HIK55IZ0WC8oiPzUGf3+qIkZjooYuFgwlxN7ic0lMuYmKdXdCrYqMbDIIPjb16hn+uYvN37aRRh2Mmw54r8=
X-Received: by 2002:a2e:8615:0:b0:309:1f1a:276b with SMTP id
 38308e7fff4ca-309288dd3d9mr24735151fa.10.1739825285303; Mon, 17 Feb 2025
 12:48:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-nova_timer-v1-0-78c5ace2d987@nvidia.com> <20250217-nova_timer-v1-1-78c5ace2d987@nvidia.com>
In-Reply-To: <20250217-nova_timer-v1-1-78c5ace2d987@nvidia.com>
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Mon, 17 Feb 2025 21:47:29 +0100
X-Gm-Features: AWEUYZkhMupaOKDqUFGG02klV236GSJkG6vgCUJ5hwk1HNdZbu8uVT8mYAd_O24
Message-ID: <CAA76j90OV5OpCVLGFrGVL4-DRSFreZDj8FUmx_nkOq9HL1x2cQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] rust: add useful ops for u64
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Feb 2025 at 15:07, Alexandre Courbot <acourbot@nvidia.com> wrote=
:
>
> It is common to build a u64 from its high and low parts obtained from
> two 32-bit registers. Conversely, it is also common to split a u64 into
> two u32s to write them into registers. Add an extension trait for u64
> that implement these methods in a new `num` module.
>
> It is expected that this trait will be extended with other useful
> operations, and similar extension traits implemented for other types.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  rust/kernel/lib.rs |  1 +
>  rust/kernel/num.rs | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 496ed32b0911a9fdbce5d26738b9cf7ef910b269..8c0c7c20a16aa96e3d3e444be=
3e03878650ddf77 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -59,6 +59,7 @@
>  pub mod miscdevice;
>  #[cfg(CONFIG_NET)]
>  pub mod net;
> +pub mod num;
>  pub mod of;
>  pub mod page;
>  #[cfg(CONFIG_PCI)]
> diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..5e714cbda4575b8d74f506605=
80dc4c5683f8c2b
> --- /dev/null
> +++ b/rust/kernel/num.rs
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Numerical and binary utilities for primitive types.
> +
> +/// Useful operations for `u64`.
> +pub trait U64Ext {
> +    /// Build a `u64` by combining its `high` and `low` parts.
> +    ///
> +    /// ```
> +    /// use kernel::num::U64Ext;
> +    /// assert_eq!(u64::from_u32s(0x01234567, 0x89abcdef), 0x01234567_89=
abcdef);
> +    /// ```
> +    fn from_u32s(high: u32, low: u32) -> Self;
> +
> +    /// Returns the `(high, low)` u32s that constitute `self`.
> +    ///
> +    /// ```
> +    /// use kernel::num::U64Ext;
> +    /// assert_eq!(u64::into_u32s(0x01234567_89abcdef), (0x1234567, 0x89=
abcdef));
> +    /// ```
> +    fn into_u32s(self) -> (u32, u32);
> +}
> +
> +impl U64Ext for u64 {
> +    fn from_u32s(high: u32, low: u32) -> Self {
> +        ((high as u64) << u32::BITS) | low as u64
> +    }
> +
> +    fn into_u32s(self) -> (u32, u32) {
> +        ((self >> u32::BITS) as u32, self as u32)
> +    }
> +}
>
> --
> 2.48.1
>
>
Looks good :)
Reviewed-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>

