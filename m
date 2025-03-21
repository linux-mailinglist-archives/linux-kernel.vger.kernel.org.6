Return-Path: <linux-kernel+bounces-570979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A06FA6B773
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAEC33ABF06
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3141F03F8;
	Fri, 21 Mar 2025 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IjFqRArv"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EF48BEE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742549569; cv=none; b=dGSpppf3w/ptLEqJ8TDueFCuI7GnbN40y9UQN3XaVS8WD/Hd8P/fufl61tnepy6U1x3ArwxaboFqy+88yyXFStIuKSi6zbaFc0jLcsjJxgRBPKTi/5iSM2T9oLgu481Hxp5ZtNAInUtl9pKhvToqzqZlq7r9FR+0rwq/qP2bXVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742549569; c=relaxed/simple;
	bh=8l835NqhtHKDpDCF8TwkawTXg6ZyJjQcteu/6vzckqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihjQuNwEfqdXxdnp/x4/89Vy3s1nNbaW35CBFEy9p8hwZHGqsgqFepobgcxyJGNLnQGWASwr3gtfKTDPRDUaVERUEHO+5U0rt+jJyw7AeYOI+oR66QhMSKM/z6OS/g53RxBjfZLbMtbJVuY47cH2vWs4gMNy5HOfj8Cepa5Lwco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IjFqRArv; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5495c1e1b63so2168449e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 02:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1742549565; x=1743154365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XERU60U+/917LDlw8Qh1PwVjkqJc5Zc5clGeyplc/uQ=;
        b=IjFqRArvQCCOyZNnIhbdiOJG9/gQzY6vje4x5AAahlO6piZuqc44yOga+q7gL0GQmw
         vxVTKWdgRM7vYCrL5FMdHmqoPykBGayyT3ZKqY6zmuthrtq89LXf9kfh+fBuqgcIHR9x
         oHylLjrQyPdqqaP6cp6Bwm2xdfzmBASBGnv5UrAtwoCQtfDiG23/VMdmRicEQa/yHN7c
         zJPg55gk1DH3EOrZWJGORI4hpQT4YhDq5ttXIZC9ooTkhR58eOhdIUvbVb9a5kpU0dqv
         SUJ6Z88zWSnDBe+5Lx5PCmOh1lZSFWvzQ0j3pyc66l1LnriLyQoAHoDc0Bb5rL+8mpsN
         8pSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742549565; x=1743154365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XERU60U+/917LDlw8Qh1PwVjkqJc5Zc5clGeyplc/uQ=;
        b=Te62kVjTpXMsYSTur8hCc6hOHcwGD87K7iM1iSUaiOaUngWPNSVrznm1n/Hmglf4d+
         IePmzHzxhASOMVjEnMdyv1gVspCkfReiZqsvWFN/kIsubkrKRSx1ixVINoDTHekHdfX1
         TfM7t7SL4p3LFVUr+rm+HMWNIfRzLn/+Fd2znIiZrPFbtl1BGKTyWfOg4yb5zE90HSfY
         f1jhO+/Kr3deFDVoTHDampwM81pgzN4yQ97cdUxgEXK6BTqSA3LNyINuAOo0KD2zqeeV
         fGAugqsG2uf27EJKKXxSqEF+FS2wo7ceVFs+UQqyyenu2MgpdcLCo3fTKdnkzzaXRfuE
         igHg==
X-Forwarded-Encrypted: i=1; AJvYcCXSxLUFOHwJfdj2g5JpsFiQSfEo0Szx5KUpEJVzZBeo08mA4dB1aJxe44M12VHzkRQW7zxTfsuNE823mBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx4vbNkUHZXTTdp418z80A7Q34YfJQPyr4YWV8IrmeKnhELuPJ
	SEe0HoUeW6TAQD8SBsZw6Y6BhRQOH4qWxE8ZcRkDVV2U+WaUVammF9Z9NTiv7Mj2seKjMRN0GGX
	y6ab8nf5LtRrNBIiRazHYsfwQikT9ICFmEXLPQQ==
X-Gm-Gg: ASbGnctWzgbop5ikQIIUm+2oVFj5tap0M6omt9Nd/tAaEo12cy6vhJr+0w8aQjLVu6l
	KeSvIxATXlmIJLZN9S1Z3FlZKjvCoIZ7V+NJbHcURw4z6vGxV2CT9O5fP9eX9gulJWdh6WGZBUg
	inGHMP3Qpcrf1ku9lpmpkfr5EpWIZZOcC1srTg3sgjwRs250KajiscYve2ZA==
X-Google-Smtp-Source: AGHT+IEBY/fAkajQuSRVyTlgq4N4SP7Bkx/9OIDkKArz9qXyC4VVwsnCnYIMkFFYjCEYx/lIBp/Z82J5Ve+iwB/DbQQ=
X-Received: by 2002:a05:6512:3b0f:b0:549:91db:c14b with SMTP id
 2adb3069b0e04-54ad6483b20mr867660e87.8.1742549565227; Fri, 21 Mar 2025
 02:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315164123.1855142-1-koichiro.den@canonical.com>
 <20250315164123.1855142-4-koichiro.den@canonical.com> <CAMRc=Md8nB1U--qcZxpcKVzxTcON2hi-pmsUKFn+aBEqHuBzcQ@mail.gmail.com>
 <llbybv6dpkfrtir75dveqnphrj6nuephvkoyywy6tx6vfbunl2@ft5io3thby6v>
In-Reply-To: <llbybv6dpkfrtir75dveqnphrj6nuephvkoyywy6tx6vfbunl2@ft5io3thby6v>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 21 Mar 2025 10:32:33 +0100
X-Gm-Features: AQ5f1JoHHL9KDzZ-SWQEW7Y07v2J_ZxYiDw8Jn6eKd_fUK42Cla39In5LPZr_GQ
Message-ID: <CAMRc=Mcng+jW2WrAREOf-GC1mCbGEyAiMP_Ms9B3BzXnCoFGFQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/9] gpio: aggregator: add aggr_alloc()/aggr_free()
To: Koichiro Den <koichiro.den@canonical.com>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 3:37=E2=80=AFAM Koichiro Den <koichiro.den@canonica=
l.com> wrote:
>
> On Thu, Mar 20, 2025 at 04:51:04PM GMT, Bartosz Golaszewski wrote:
> > On Sat, Mar 15, 2025 at 5:41=E2=80=AFPM Koichiro Den <koichiro.den@cano=
nical.com> wrote:
> > >
> > > Prepare for the upcoming configfs interface. These functions will be
> > > used by both the existing sysfs interface and the new configfs
> > > interface, reducing code duplication.
> > >
> > > No functional change.
> > >
> > > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > > ---
> > >
> > > +static int aggr_alloc(struct gpio_aggregator **aggr, size_t arg_size=
)
> > > +{
> > > +       struct gpio_aggregator *new __free(kfree) =3D NULL;
> > > +       int ret;
> > > +
> > > +       new =3D kzalloc(sizeof(*new) + arg_size, GFP_KERNEL);
> >
> > Please prefer declaring the auto variable and initializing it at the
> > same time. Should be:
> >
> > struct gpio_aggregator *new __free(kfree) =3D kzalloc(...);
>
> Thanks for the review. Should I send v7 for this change?
>

You should send one anyway once v6.15-rc1 is tagged.

Bartosz

