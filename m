Return-Path: <linux-kernel+bounces-422926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C899D9FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 01:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929C6168A89
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501D7EEBB;
	Wed, 27 Nov 2024 00:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFugOuZl"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB2BD299;
	Wed, 27 Nov 2024 00:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732666789; cv=none; b=F1HntnBCnZ5c3KzwksxTogsZxOgHstLDD5coTafDm4jL12JTirxQejcdg2lAoJoL+MSWN6tWdwmJblkSKWT5Zc8tZFCfJAggTZBTXeXN5ccdipWr9xySgK26ORKc3XhpB+0y782253vYHNvY2ARmFmvt3nF1utpzf9VT30ahF/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732666789; c=relaxed/simple;
	bh=I3q7+8H/IRUE11x01SLQFzhUcQJk8GU1SjhCmYh5sJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftA+09LWmx0J6zvEuUgZhpmeB+NKTG/75ZE1FiMv2WxwGaMqceNpaE6evq4Vh/6OaL4dRrvk9lSYD3rF43/YTAqq0PW312VVxoYNdX9ycRLWqbEoi5YlLGgqX+XMKLhSMOhYpnuKdHh9+Z6XQ28NU/bTF6jQfxYUOMSAd/dFbqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFugOuZl; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-72500192fb1so207527b3a.1;
        Tue, 26 Nov 2024 16:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732666784; x=1733271584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgWMvYgq1/u+4Duk4eENcZ/oGabbjJAipZ5tGvxjPHY=;
        b=kFugOuZlV7Jgts5ILNPIRowCmUMNU7d32ClcZ2XY0did4gpOxHCkAvb3NvnMHmxVk7
         XxCEzL6xJGQVzLQ0P5ZX6w4n4wmV3AiWM5lTjpYo2pmyeJdkRL5n4pujaMSp2j59VOcc
         UIGzsON4HKhr4FrU6F6+iIxaJZv5h95RyXEyQmnjJ4976yezKH2Ggzy8VpuLCuSOAkRF
         qEtIka9uq+MDWOk4v4hSGcOI29rvR9yXxCaB46xNf8eOvrWcF+P0bSI2GysJOF6qCYir
         Gybu5iNXEpgcV+SNJWJoex9n5uNCyIZFDge8lK+oSA3nLzvHhyI202bmING7bZjFI6nZ
         DcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732666784; x=1733271584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgWMvYgq1/u+4Duk4eENcZ/oGabbjJAipZ5tGvxjPHY=;
        b=SKiY53c17rMN3nDkjKSNNlJW7OVc1yyZcZL8fxil1y2pxuU6egu4D/AxZw93WFJb/X
         iQBu4AFEo0y4GWFxEJtAQlCqXWDTDFlKFcz70GK0dBIiUjJ0LjlbHUd/I1G+Zzb4U7JQ
         L6picc6vTCQK4JNuhdqRTsSny7upCxAMqWP8+UgnVcCNMBBmgwZHq3ktM2Lhd33vGe48
         0sEue8YKVVvsAFFst47GKs8JmP0bxu8awR8935rcjC7zXfqhkt8LGnk5NnvZDkl7svzd
         +KPOtu6DS5WaD+h55nrpgZAXcj/MfPZvQ/6lmpsY8d5CoxN0DpfVAVW+uPtDfjICPa1m
         k6qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZV+H+pjVnlnFJHBw9lDayfCzhqmX4dQQCi19SZvYX4H//GjQQ4SvIRgExz85bwAj7bmocfjHGWMWywkStnz8=@vger.kernel.org, AJvYcCWsKaKgDTzi8jwA6pq/axzwr3MXcmdGsnYtrifSvEUUevJSMINGalujCrky0YJNhk0+WAl+5hXFdb1J4l4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqO6rkexu6ShA5fXGE6ot2Abhlis6MTKqdvb9f/7l8tmQbet0O
	8P4OSRo0Y31BrkWcGM/yZY7l5IskvdySsQTv87sBi32G9K8GStyRyXaZ5+2dbaNQjhH5HUKH2dz
	nmo6Sp4HI97p0QkTvhBoGMre6oyw=
X-Gm-Gg: ASbGncsOK26w1OJlqsI055E664M0aIZ6Vl7HaqOohL5Wi6+UgCU3vIU6xcVYYCePzQN
	mIwauRusIsEszD4pwHiNqfI0j6eO6+mA=
X-Google-Smtp-Source: AGHT+IE87Xc+AzZ/3VRDSw1v4b8ixJUQL4fysOSonIzDvgH4OqSaBH6c09rTzC7WgmsUNulYaazkGNQVxwoFBhtPUkM=
X-Received: by 2002:a17:90b:38d2:b0:2ea:5e0c:2846 with SMTP id
 98e67ed59e1d1-2ee08eb7c59mr675446a91.3.1732666783906; Tue, 26 Nov 2024
 16:19:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126022500.718070-1-ojeda@kernel.org> <CAHk-=wgRSWz=5e39P3Xb8FmsD6Qa-_LFBTs1q2m53yrw-yCSzA@mail.gmail.com>
In-Reply-To: <CAHk-=wgRSWz=5e39P3Xb8FmsD6Qa-_LFBTs1q2m53yrw-yCSzA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 27 Nov 2024 01:19:32 +0100
Message-ID: <CANiq72nqyFHkQFRLoXSA5BEvgNz_8iOCK+A1gU+2ubnJRd-OwA@mail.gmail.com>
Subject: Re: [GIT PULL] Rust for 6.13
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 11:08=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Well, please humor me. My conflict resolution isn't identical to
> linux-next, and my rust is still very much "monkey see, monkey do", so
> you should most definitely check it out.

It builds fine -- both after the vfs pid_namespace and after the rust one.

...except rustfmt wants to move the `use` imports a bit in
rust/kernel/task.rs. Do you prefer a quick patch, or do you want to
run `make rustfmt` on your end?

Doing the latter would leave you with what linux-next has for those
`use`s. You can also move the `ffi::...` one inside the `crate::...`
import and run `rustfmt` which makes it look a bit more consistent:

    use crate::{
        bindings,
        ffi::{c_int, c_long, c_uint},
        pid_namespace::PidNamespace,
        types::{ARef, NotThreadSafe, Opaque},
    };
    use core::{
        cmp::{Eq, PartialEq},
        ops::Deref,
        ptr,
    };

Thanks!

Cheers,
Miguel

