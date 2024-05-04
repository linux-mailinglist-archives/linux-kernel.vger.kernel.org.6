Return-Path: <linux-kernel+bounces-168698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B77E88BBC55
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 16:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BBA5282A39
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D0937700;
	Sat,  4 May 2024 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="KrajHldZ"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D9D22F1E
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714831325; cv=none; b=iWqe7V+iC++oZPxNUg3mwFSHnHfnQUSHsOwnMIE599AT9zrLpPC+yiU3oCZIa2NNUmIE68FQAbMgDceG65ZLHgdwHLnWU2XovHDoHO3xOG5RbqRRpHZfOZ2S6BBO6HeTH/2SLwLTE1CQ/A+S9AyohDozgrvDfQB+OHDlUMPl9jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714831325; c=relaxed/simple;
	bh=w1wKLlddgNLRY7sVTw/AmzrPkB5NtGmCyXfNQGsnsrU=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swP4joPtTvWfcm013e/+a7vtRI22v7avM8+RhWHwyZ1b7pvD/YOLksS4PaSkQc3pxe9dirBQG+worpcP4Zqqo21XPK6Yw0LGokUBYjVupUst1jKX22QL4cj8UqYksYRaqeyvVw61nf2nQuel/eED9Uvk0bF26tcqN/Vkna2+0Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=KrajHldZ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E4D573FE13
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 14:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714831321;
	bh=w1wKLlddgNLRY7sVTw/AmzrPkB5NtGmCyXfNQGsnsrU=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=KrajHldZZIAxG/+LAJHq4M9pKBTJFxPRvbTVRVqkVybmDpZ2qpGAUHpV6/9J9xV2d
	 e+fw73WQUMcnuozBG/sa6ofq3+Kw/c5ejKPwjX57Wo+Qww8QOHcCi50M/XKhX/pRA2
	 9UadmqGy0qyxljc97MQQ3wYD6pKZ+LiJSXiT4+XQ8+E6854btcaoMR77MmvBcO07Eq
	 Dlg1Ng5VMe1762gCvD82UBM93xJy+QRg6kRWx/PeGTIDNgt5rAGFGL8QBbWY55/aPU
	 wpa8c0/pJ3NySNa9lj30CvpIhWGOxXozd8O4D1+In2m5iXfgSfakRgf+77+Glw6/iD
	 ApWwWciILHkKg==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-43ab6687212so9357571cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 07:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714831321; x=1715436121;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w1wKLlddgNLRY7sVTw/AmzrPkB5NtGmCyXfNQGsnsrU=;
        b=jHE3vA1Ke2/pxe3IrJxW1EyDFfVjDzcYYXhlYjmeFc1apAdGgaYHe/M0P07fxT5VTC
         adGyHcnh0k4XUoXeMcvz4Xc3R1FXk+Yo4LTSom4i8PWA1YqSaBzsLrO3tWuiW8D98N/J
         IflAyXxvb5YO289lH6HhOF8gO6TrDFmAv/TRBJSqVyOa/yb5y/SnOFYsj38DeejSG4yJ
         Yb126ii3iRqbceyGNu+V0wrTnPtSIMxD8vBVzghiqYx5FHbmwQff9XW2fvc3o/2CF6yn
         SO3y1z5Acb0ONC8eW8vOvNjybIN9n0/LUummQ9iZuPx0sVDz0ide9TgIsdC4bYsLQ4CZ
         BB3g==
X-Forwarded-Encrypted: i=1; AJvYcCU+FK0oPl3B/VvfkOX6Qg/XekgJBehm0pu98JMhMpaQbaj/VlRgw9LQeyQiXnYxsmybzit89BBUi1Pzw4laXbolviATYkhFZfn2G0l5
X-Gm-Message-State: AOJu0YzCjIuXiER2tBPW8dB0SzepvtDonk3GWlN/puCzApvv5R2KXMeE
	+S1HBFz6237i14oy28PWFUnDgWdTvS9CsmJTuOcmk71j6Ydb2i0CjrEuVW2XeLKkgOROtheHYd/
	OgaK27VwA4lUbAajzSV0DNEPKlaEb103Mao6leMyU+XKyQ60FAFhkfbpgFmDBZwCWX75+m/P0kA
	ZLjwlkebQ4ZTnJI0l+sitUx68GDjxBQkZb+ULWzFPMRTo79HMoUTeP
X-Received: by 2002:a05:622a:251:b0:43a:3856:4536 with SMTP id c17-20020a05622a025100b0043a38564536mr6720468qtx.17.1714831321008;
        Sat, 04 May 2024 07:02:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGZgnGwlr5MlquzRD3HBD2jghIOPUIuKhTSH7FRuH4CWfIUsVkG3VAkY/u8aMaKyJFPxi8z4makbKpQ28f8LU=
X-Received: by 2002:a05:622a:251:b0:43a:3856:4536 with SMTP id
 c17-20020a05622a025100b0043a38564536mr6720450qtx.17.1714831320756; Sat, 04
 May 2024 07:02:00 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 4 May 2024 16:02:00 +0200
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <CAK7LNATbseQCgjAUDemNoo9zPd_iSb+4Gz9TaW2YkOKcp3CSEQ@mail.gmail.com>
References: <20240502111613.1380453-1-emil.renner.berthing@canonical.com>
 <20240502111613.1380453-4-emil.renner.berthing@canonical.com> <CAK7LNATbseQCgjAUDemNoo9zPd_iSb+4Gz9TaW2YkOKcp3CSEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sat, 4 May 2024 16:02:00 +0200
Message-ID: <CAJM55Z-MMcePewnMsmTqHtcjLiCnmMMLawtJxPcXs8r1Sr6n4g@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] kbuild: buildtar: install riscv compressed images
 as vmlinuz
To: Masahiro Yamada <masahiroy@kernel.org>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Nick Terrell <terrelln@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Masahiro Yamada wrote:
> On Thu, May 2, 2024 at 8:16=E2=80=AFPM Emil Renner Berthing
> <emil.renner.berthing@canonical.com> wrote:
> >
> > Use the KBUILD_IMAGE variable to determine the right kernel image to
> > install and install compressed images to /boot/vmlinuz-$version like th=
e
> > 'make install' target already does.
> >
> > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com=
>
> > ---
> > This patch depends on Masahiro's patch at
> > https://lore.kernel.org/r/20240414174139.3001175-1-masahiroy@kernel.org
>
> Thank you for fixing the issue for riscv.
> Only the question I have is how this patch series gets in.
> If it waits for the next development cycle, it will be
> cleanly applicable.

I'm ok with waiting, but otherwise Palmer could take patch 1 and 2 and you
could take patch 3. The worst that can happen is that a bisect lands on you=
r
branch that will only package the uncompressed Image in the tarballs even i=
f
Image.gz or Image.bz2 exist. CONFIG_EFI_ZBOOT=3Dy and CONFIG_XIP_KERNEL=3Dy=
_kernels
will also be fine with only patch 3 applied.

> Anyway,
>
> Acked-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks!

/Emil
>
>
>
>
> --
> Best Regards
> Masahiro Yamada
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

