Return-Path: <linux-kernel+bounces-512473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF46A339B9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087261604BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97BA20B7F8;
	Thu, 13 Feb 2025 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nBCPXnm+"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC8C20AF82
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739434327; cv=none; b=NvdCm8xK10Yp3PAZCadz73GM4xLG1fzqxBy76d6HmjqvPc4Gxa16UTsI3Jw+Diz8YLzgHj/nO9Pp9x6sDIRSYo+jumiQJ985gPyCEUa3bJBmWW+vZ5vy95BKfp/DzjMkahsElq0urkkszBorQZh2RiNi5vghFNOras9UPPdsgHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739434327; c=relaxed/simple;
	bh=+dFfwgX0CbcC8ID7JA7WN/WcTf8Op76swd4beDyWCTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtDFV/IrDIL2+yecFJqaGA5r0MviYFhW0/EXRZjTtyhM5A59j8Z2t/a7zuCf5lYc6wifBWIZc6p0ZnVY0oQxku84kbVdTruzV5My+RJKupFKRA3NXn+QQXhbSH41ceHi/MMZbEzmLxYH40RLOlfB+rqvTilGBDub9g0odSp+99M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nBCPXnm+; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54509f46614so570403e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739434324; x=1740039124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dFfwgX0CbcC8ID7JA7WN/WcTf8Op76swd4beDyWCTM=;
        b=nBCPXnm+aVWW4XKLBxHOvFNzjuOi8ievurtGudwsFEqg+kqElVsHxMnS5iRv9O6uzh
         TvnuvnOUT3ZsWkiM0A11FzmDLHTC1wHN3oOfx57TtrVZJ3Jk7uGhzjS0d67oqtRrWgaI
         M46jE0rOM/3f8o2/WfNs5XsZ838rLPK3vKmnknhdLCAjPyoKnTmc/TFwJwl9/KSdXyif
         q6Dc2Ov4Qm33ng8eLoALbCNxi4jsiXbib5gLdQu5fsm1F3HNwoAjl/Ruo29N3XFLBI7/
         UJxB3bBClYQlh8JxVtnfAMB6bOXiheT1YG3JPyFIAO9/bdZezgO+7RsUujAEacJCmRdM
         z+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739434324; x=1740039124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dFfwgX0CbcC8ID7JA7WN/WcTf8Op76swd4beDyWCTM=;
        b=Hvd4UimJlioXuUQu/xCRkjpKcbatFC1jXVBISAOUwBZtffdIj3XQR45ppiRXY/Yyw5
         zzGIrmUfp0+7CHc3TcVK4wU4RaEUl6JrBQFE35T3bIk1iZZXaxa35x6TCJ9XERCMnErM
         WUo0nbdYrdrCZz7bYxCA0NjRoBWOK/Mw5RarW41U4hU8G1yWCBKoktUmuVUeH5vAwJ/d
         jybtyIrYPZJ82pgRpv+vTQlSmoMMukNIJhzwA+lhYkCrbR70IoOyRkeS214sU1F1m5hV
         7h3+rWHOn099EA1C/1a4v1F1JBkIC2lrhMW/DdsVAZIWGjbxJgqy8V86QCl/FYr0eCOv
         zRng==
X-Forwarded-Encrypted: i=1; AJvYcCUnATYpkH+3chIDgflt+ygmMzK4YmJV0HXO8s3uyEryoHtS3WFtapSOneYvI4gBYS3k/scqPUbcXkjzI2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFHfz+sP1c20Rz3nQjhQJGVQ2jgJxyoXneKjXjqnRrBAPPHV1S
	5nx0pHVKqRkh4nagSnoyykDRUalrHbr1WIJ00ZPzugPjGRp8a5l6LsKXm4X/i9M77ROBMOr3ujP
	grTl3ujMZBMMe4KgMqlCETs/LOtRV+tSOGggIeQ==
X-Gm-Gg: ASbGncseXjHxNOAoj8srgCPaqHUkSOYBw1DME4yKngcEK41lvAEzhVv6p7gw66XOP8u
	6NquXIJ1JEgL2dyYaWXwfaClrfesadviWUUYRcMJnXkHobMhgIoX3A19uz+hk6xDbQRrEL24kzS
	2rKlCu+VPtU4ZrQBZP97w0WkVWtja/
X-Google-Smtp-Source: AGHT+IEIAFhRMajhJpOtMGjvIxm2QdCbWm4QaFxeLh+n1Rj6FPuiVieLB9SVYIYG1UUPR2y+YCRUUAl/3rRdA4PZnvQ=
X-Received: by 2002:a05:6512:159d:b0:545:ee3:f3c7 with SMTP id
 2adb3069b0e04-54518116604mr2088771e87.30.1739434323801; Thu, 13 Feb 2025
 00:12:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113225530.124213-1-s-ramamoorthy@ti.com> <CAMRc=Meqjy+cqfueM_dQE8uP32zS0ib41qE+OPPWFkhoVTGc2w@mail.gmail.com>
 <065cdaca-cc37-4b1e-9c1e-e2dedbb2ffd5@ti.com>
In-Reply-To: <065cdaca-cc37-4b1e-9c1e-e2dedbb2ffd5@ti.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 13 Feb 2025 09:11:52 +0100
X-Gm-Features: AWEUYZkbTb8bENEVnsn2E-MYQzjbnZkeB4d8wppWNtFqHw8XqmJeTxrvnmw4bYw
Message-ID: <CAMRc=MfR2q8TTcEHtbX9HxyFikHP_nS+Mva3dTwmgu4tvkxJ1w@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add TI TPS65215 PMIC GPIO Support
To: Shree Ramamoorthy <s-ramamoorthy@ti.com>
Cc: aaro.koskinen@iki.fi, andreas@kemnade.info, khilman@baylibre.com, 
	rogerq@kernel.org, tony@atomide.com, linus.walleij@linaro.org, 
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, m-leonard@ti.com, praneeth@ti.com, 
	christophe.jaillet@wanadoo.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 10:12=E2=80=AFPM Shree Ramamoorthy <s-ramamoorthy@t=
i.com> wrote:
>
> Hi,
>
>
> On 2/7/25 2:53 AM, Bartosz Golaszewski wrote:
> > On Mon, Jan 13, 2025 at 11:55=E2=80=AFPM Shree Ramamoorthy <s-ramamoort=
hy@ti.com> wrote:
> >> TPS65215 is a Power Management Integrated Circuit (PMIC) that has
> >> significant register map overlap with TPS65219. The series introduces
> >> TPS65215 and restructures the existing driver to support multiple devi=
ces.
> >>
> >> This follow-up series is dependent on:
> >> Commit f84464ec8190 ("regulator: dt-bindings: Add TI TPS65215 PMIC bin=
dings")
> >> Commit 8206c20f4c82 ("mfd: tps65215: Add support for TI TPS65215 PMIC"=
)
> >> Commit 0e0b7f00c111 ("mfd: tps65215: Remove regmap_read check")
> >>
> > Did these go into v6.14?
> >
> > Bart
>
> The dependencies listed in the cover letter were just applied by Lee Jone=
s:
> https://lore.kernel.org/all/173928615760.2233464.12306998726512431222.b4-=
ty@kernel.org/
>
> The rest of this series still applies without a need for code modificatio=
ns.
>

I'm not sure I'm following: should this series wait until v6.15-rc1 is
tagged? Or did you ask Lee to create an immutable branch? Or doesn't
this series depend on the MFD changes at all after all?

Bart

