Return-Path: <linux-kernel+bounces-372608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CF89A4AEB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 04:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02AF8B21B3A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 02:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4747E1CC17B;
	Sat, 19 Oct 2024 02:04:28 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572571EA87
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 02:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729303467; cv=none; b=KDe7ZSf7uPvS1Q41f1H4vTOU1uliJEu1fA5IxsKb3/sEhWJluc0e1PXHPDNUKz2J2qwaOu2kW7UmXZvpA/Nhx0qiMrbgKNqYf2h3UwjC6ulrh5q+wLjr2HvFS2SjuXyfsce3GlSmjjNfMT2ZCDObmsZLy6noYN2mM/OjWFxJfjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729303467; c=relaxed/simple;
	bh=/66BogwaGO1TZ9c3mvfdx1XuHHVfDnGLOwb/j9TwsWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=BWPcuMZapKsdeuNuEK3Sm06zg1imD34OEWtOGFoItYuZi21Sz2ExyHhd7KPRcclRA+ZzdftPEatfDX63Sfej44m8azD5n2eg5K2L+NMCrFrhT60MVsUjWknAezK+Jz1ZYJctarAk9chc3UEtWyGkOPQWjNc1Z0hG1mECfOA2/qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e59dadebso3790538e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 19:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729303462; x=1729908262;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/66BogwaGO1TZ9c3mvfdx1XuHHVfDnGLOwb/j9TwsWA=;
        b=ZtliI+yBQsGxw4nzcTNowGaRSBmTVAVgmYn8UCxDamCEoJkUhVryjIhLzhVckCX7JX
         UvWEBiJahOH36QORmsiKX+AbzhRVbmP3s32X0vTYVg8hYrHKdj38KIBAMwDobk1t6nFV
         hVchcYCHTTvNX1LMSdjJ/8/yiCEYhxRiEDdf6qK0nf7VdslOcOo3rvlBu7E9jdLugpZb
         nVyCHPdXEJkAOZFHzPwn2ZGYsD2sxtsNUqpwLOoMAZ/hHaPRTxzqb0OmqY8xNHxy+NvK
         nQ0jGFCX+UodQswiCCUUo2aiyLeFRVOuUDitoKSgZQB+O13PnLLpy5hDA+U8r4c6Fb8E
         4pZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYODoLyg+k/fBDn575XIpz4yrQaKutSSyEAH7McF432creHglVeGUYs8mcp1CI7C520lNbonoXPjeMc/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlS+3CLkPFXftW9cMv0LkcRmIfKfuILcKA7tEgkR9/9OkNxApL
	sQLh7cH6fB0wN2WCzN+WpJxr+sCGqs48KabpU+tfbMp9dUKeUd0YzXowj8tI
X-Google-Smtp-Source: AGHT+IEYhuXfXWa93G47IuUPannpnI1F6F1HxYAGt3ywgBFSKb88+8V3H4ovoDFBN39nVqgcI5kSNQ==
X-Received: by 2002:a05:6512:691:b0:539:fc26:74bd with SMTP id 2adb3069b0e04-53a1522a903mr2795483e87.27.1729303461968;
        Fri, 18 Oct 2024 19:04:21 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a152041edsm373566e87.184.2024.10.18.19.04.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 19:04:20 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb5638dd57so30738971fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 19:04:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXLs9toW7lR9QNoaPx0LXEg2ihAKJZdGm+/yCCzJF/YNu5zyH1e946PydhLLFAQzi9H9sZWm58Lx8bw82I=@vger.kernel.org
X-Received: by 2002:a05:651c:2105:b0:2fb:5a7e:5072 with SMTP id
 38308e7fff4ca-2fb83200a6bmr25649951fa.34.1729303460314; Fri, 18 Oct 2024
 19:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908214718.36316-1-andrej.skvortzov@gmail.com>
 <20240908214718.36316-2-andrej.skvortzov@gmail.com> <CAGb2v65Laka+YaPyAecwxEhMkoodrXnDPn+UTwZUS_wsSBMzyg@mail.gmail.com>
 <ZuazIgLz5PP_Z8Cn@skv.local>
In-Reply-To: <ZuazIgLz5PP_Z8Cn@skv.local>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 19 Oct 2024 10:04:06 +0800
X-Gmail-Original-Message-ID: <CAGb2v66-saec9RcQsCTNOz_Tz4+BSFPdDd6CEA+RrGcF6kCY=A@mail.gmail.com>
Message-ID: <CAGb2v66-saec9RcQsCTNOz_Tz4+BSFPdDd6CEA+RrGcF6kCY=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: sun50i-a64-pinephone: Add AF8133J to PinePhone
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Shoji Keita <awaittrot@shjk.jp>, 
	Icenowy Zheng <icenowy@aosc.io>, Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 6:12=E2=80=AFPM Andrey Skvortsov
<andrej.skvortzov@gmail.com> wrote:
>
> Hi Chen-Yu Tsai,
>
> On 24-09-09 16:08, Chen-Yu Tsai wrote:
> > On Mon, Sep 9, 2024 at 5:48=E2=80=AFAM Andrey Skvortsov
> > <andrej.skvortzov@gmail.com> wrote:
> > >
> > > From: Icenowy Zheng <icenowy@aosc.io>
> > >
> > > New batches of PinePhones switched the magnetometer to AF8133J from
> > > LIS3MDL because lack of ST components.
> > >
> > > Both chips use the same PB1 pin, but in different modes.
> > > LIS3MDL uses it as an gpio input to handle interrupt.
> > > AF8133J uses it as an gpio output as a reset signal.
> > >
> > > It wasn't possible at runtime to enable both device tree nodes and
> > > detect supported sensor at probe time, because both drivers try to
> > > acquire the same gpio in different modes.
> > >
> > > Device tree fixup will be done in firmware without introducing new bo=
ard
> > > revision and new dts.
> >
> > FYI I've been working on an in-kernel prober [1] for such alternative
> > components. This does not require firmware support.
> >
> > [1] https://lore.kernel.org/all/20240904090016.2841572-1-wenst@chromium=
.org/
>
> Thank you for the information.
>
> I've tried to use in-kernel prober from your v7 patchset [1] on top of
> -next and it worked without any changes to firmware.
>
> Since there is still on-going review of your patches it looks like
> it's to early to submit my changes for review. But I'm ready to test
> your new patches.

FYI I'm open to either approach. If the firmware can do it, that is also
fine. I don't know if it makes sense to have both disabled by default
though? That would break existing users, but so would the in-kernel
prober approach, which requires both components be marked as
"fail-needs-probe", and also requires that the kernel driver be enabled.

In other words, I think the firmware approach is friendlier for existing
users that have the original batches.


ChenYu


> [1] https://lore.kernel.org/all/20240911072751.365361-1-wenst@chromium.or=
g/
>
> --
> Best regards,
> Andrey Skvortsov
>

