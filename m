Return-Path: <linux-kernel+bounces-389027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D35869B67B5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796531F2282B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DEF213EFB;
	Wed, 30 Oct 2024 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCbz804w"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA2E213EE5;
	Wed, 30 Oct 2024 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301719; cv=none; b=q9nvobmAshkPpTIWDQrdZciZ66XyMKNxush/voVtnYcIki+fUZ0eVzX1lmkxC71w4kHRr15mUhBdLnPm/ak7+1BIchiOZjKO5mqjncb5CFl3/0f4HwGJ3qL/tH5q+0zj9lHBXBtTM358NdjMi7RM/PsawttNpB7Q7PAmajXFU2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301719; c=relaxed/simple;
	bh=q28afKGBxlWaTBYntLh/Nt9kA9+T1WZwBlrU/Kj/q2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pc6+g7e/x5lSp8sc/7T2FIHEZxs0OlrC/dRODAE14KS0MSGywQmQjhvETc53HiUBLt2reyYHDz8BrZxgGzEfZLpFbdNZC65GXKLvEBeAnmRXbcq/ZdqDiEZL1IBRwvFuFf/YEnceCkW472+oix3eyhShjdLvmojIzo1/jKceshs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCbz804w; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e56750bb13so818034a91.2;
        Wed, 30 Oct 2024 08:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730301717; x=1730906517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q28afKGBxlWaTBYntLh/Nt9kA9+T1WZwBlrU/Kj/q2k=;
        b=FCbz804w2xs/H0OeT+prJKRVbRaGq4P9g0fiTXEra+CQNGywRAck0Qqh+3x2gjfShT
         LonP3Qn4f7udZt3r3gbjrma5TpLCUKVO+fbUsKEEGb9WzWBTNY6vXdWKl20rwhIVPtkV
         EyFQ41B75TaggbUBD75Bq9dHAJScdpgp9vL5ozAKmf+6kibSG+rhPB2nFPf/S1em4tsc
         IsKT/EVzkBOZLwfxG6AyjPsH6ghog0+9UeHyrMu9mLeALv8oZoVDnBtB7gX5GnH928Wo
         7+e+1tU8x5f7PxAXvxvpxgp1n2Kt8AKG/V2ovYh4gfVGYXWPYEtDB6DcNDhTs2UhELYB
         MNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730301717; x=1730906517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q28afKGBxlWaTBYntLh/Nt9kA9+T1WZwBlrU/Kj/q2k=;
        b=VHw81dKipwhYtNsF3PSvqI1YG2uZRhV1qGFYq37La+/eaYIunYTzeb2VeqqCCEWY3+
         vwWLpgKQ637Ywe5yieseeBbU0WD7rhlt+f3hNuyrD6FzRJNUWfjChI9Zzf7nu6EDX0eD
         Wk1T+imFklui5NkSFXDkLreZESKL/3OAMWHTQ3L5jCWZMraNEgyOsEYrwmP/QkzVs1e6
         YCE2taGFP15sDf/DNQARugA2WWboyW/VDb5JE2xSqLxkMPIbETL9xMrdaR9J94suTqJt
         uS4+PBtkgXD7dE2xw+E9m7+22OQxGOEM993T04+ikGpfLhT6DKL1llpX2rGGnZOTK3d7
         ehLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5yyWzk5HWIpLwUoQcQVWk7XavFD8KNzoGNBUb7SGIs0Pmnd4a1JLthRVbtfkLjn3RnRDDs2CXq9eJKBI=@vger.kernel.org, AJvYcCXFfNEYtBTjKnKl5ElvLECIWdg03qRGBo8/uwan2fH0Cw6E/6MPG8wYOBZ7QnGNd6noyZ71BMKROEYQA9Wm0H0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5htbpvToTmROKvYLY4Ag0kqTrtXBMa1hnO0VATJym9UPwhcst
	u9Vu38vEBcpBrbFWhKlYMv3VbgsI0vbjYcJXTz6ErRj84J7u5l3Gimbx96LjuPS2sNw6wOc1XYp
	bRem5CU981WMMB005lWVSWpPVmD4okIckQLo=
X-Google-Smtp-Source: AGHT+IG+aJnZ7jclz0dMGPso6SfR+Fgv1OkYRsN/+ljD+v2cjeK5jtibjdfVkk6WAVK6iHGm/ocR141Vkiewt/KDjKw=
X-Received: by 2002:a17:90a:5205:b0:2e2:da69:e3fa with SMTP id
 98e67ed59e1d1-2e8f104fc1emr7272695a91.2.1730301717024; Wed, 30 Oct 2024
 08:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-bindgen-libclang-warn-v1-1-3a7ba9fedcfe@google.com>
In-Reply-To: <20241030-bindgen-libclang-warn-v1-1-3a7ba9fedcfe@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 30 Oct 2024 16:21:44 +0100
Message-ID: <CANiq72mkKsj2JNg-iT4UTC_fRt88n8PWuFW96cAj17oHpW0MQA@mail.gmail.com>
Subject: Re: [PATCH] rust: warn when using libclang >=19.1 with bindgen <0.70
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 2:41=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> However, the regression fix is only available in bindgen versions 0.70.0
> or later. This means that when older bindgen versions are used with new

No, it is also available in bindgen 0.69.5 -- it was backported there.

As I was mentioning in Zulip, I want to gather some information first
before deciding whether to put a warning here or do something else,
especially since there is no code triggering it yet in mainline (that
we are aware of).

For instance, I have been checking some distributions. Fedora 41 will
get the backported version in 2 days (according to the maintainers),
and indeed the new one does not trigger it (and the base one does).
The Docker `fedora:41` image is OK as-is, but only because it seems to
have the update because it is still a pre-release. Fedora 40 is OK.

I also tested Debian and Ubuntu: Ubuntu LTS is OK, but Oracular is
not. Debian Testing is OK, but Sid is not. I have pinged them to see
what they have in mind.

Cheers,
Miguel

