Return-Path: <linux-kernel+bounces-521777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C7AA3C22E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34C11885836
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED841EF0A5;
	Wed, 19 Feb 2025 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AL+Jc1Nq"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD981EEA5A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975415; cv=none; b=YdL3lqSUfr7lOg0+4X65xO+8F93IxQfhb+AEtW9cZDW6PEQc8W6GhgrwdN40s2MCLyX6gQWRb1lvBhhO4yB6EMIHaOge302Cz3BU+Or0HaiVdcT3pco85JUBLVNLDqYlI8GKer3epzR5tlUvsgnXbWHBCsuOFR6AFeEBhNbppTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975415; c=relaxed/simple;
	bh=1p6FdfQ3eMnbMKelGEYIDRmk6QavZdCBbv/rQIHHhIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWxYoIhfi16qD/sNeUCmf5XpHo1vzfWQA1sxYqxAw36I3x8vegXyerjwDl29DtH8N8nrK3BEXGTx+RFaKh+HBLfSie9q6baBY2gGVFKCxbgMYFBvqjfs1I156IRpq6i7VWpdIB182i8SNaYr2iFM2qbjU0SBQilj7QGLelXUTxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AL+Jc1Nq; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30a303a656aso32623841fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 06:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739975412; x=1740580212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuIDDV8XizcdY0WvVB2Kx3sOucvN0o/9tPcHbGKOfP8=;
        b=AL+Jc1NqCA8PmzMBjcXF4uiPdVSjNanEP6D47+v7tiK3e9H7TWuy6N24ckDO4LKXAC
         GEogIbAumU5zyfgPq60ABEDcegytXowvunFUFPbg6bhmRsc6dtsE4uI8fHQ9kcc0GXk9
         ufGfkgnx8yQ9Gb00Yut+6di9HiQc/zm9rLbgHuW7wbCTb0txklA19EMQcGynv9ybYAHl
         MlOBlNMX6+Z9KLW1ooopy+w10MWSJXwBR4cxZWtT+K0qTCtM8e5FAA4rEDyIUwFr4Krj
         vijvSHijlkBWkZl6/diBHd31oh0YdVplWI0Hd1aWIQEn/vb32IChQBAd5a55l+EHW64A
         u37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739975412; x=1740580212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuIDDV8XizcdY0WvVB2Kx3sOucvN0o/9tPcHbGKOfP8=;
        b=xLfsIOkFYCmQNmjPTJ21W8O9xtNFELr/I1IlyERMKrP0JVaJ31chosR+G7/irwNf6x
         ATXvl5qjww6Mt+P5sZ9gWyIHdzWCEbgFgIemGuQaw8PZozZFhwRd9a3xWfFJdBINEfQa
         04xTU5FQ4YuCCQONojXru11iebla7AM77v+/bjMcWfLRUpJzDJOr60m6j5F4K8GpiypP
         wobjoM8dJigh8oKFCYNqMukkiZJxlgxCzjiIEnfps3PvX4mxuUXhbmLg1DCM7EPeXiNb
         LjbpYARS7ldrunFLvbIK0WHNlaK0Qg84udSYb7UwYvduSiZnTzCbuoFeeAhEvEGJrKzE
         ERBg==
X-Forwarded-Encrypted: i=1; AJvYcCWGRq77JJAyIO3dfzVZMUjP+7MSXv3+cBS/meMOlV20T83v+/lEIlNZnXxpJuvJDV3+2BERgSz6nRqeuFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRrzluNuBU+qIC+op2aAiW5F4Y1c/hwLLP8ViKV1YHOYmDB8qc
	SZty27dffNDX6ASfvEcrLLsyHw53pZkiKRUmJxP6uDxyi07te0rc25lVLoamnGixEaSIH5AguKc
	MqChZ7FOozhVpWsHxyPDg2IGPtWvICH7UCmV8/A==
X-Gm-Gg: ASbGncu+mtBcN47HZF1DK5jua48GgFsXx+mx37d+8/LjblR9oBX0wivi9xFNGDNfsvt
	+egbVvv0PXJMqjxWpTB79eXi/Ms9xLOhNnTcbOAjV4rwZs+y8BDJv+KUhTL89TKaZ0EA+ieMuwh
	qc6vfO53Z9IXtcmGTxlDBCnVDoAj0=
X-Google-Smtp-Source: AGHT+IHOMtfBh/a511ZAJ8gik3yig8Gf8tft31WvSnZ/9U8LQBfynkf9Rv5xxIK5889YeSWOE/kZLOcF9FoI8gDV8D0=
X-Received: by 2002:a05:651c:a:b0:2ff:8e69:77d7 with SMTP id
 38308e7fff4ca-30927a64cacmr52017231fa.20.1739975411736; Wed, 19 Feb 2025
 06:30:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219102750.38519-1-brgl@bgdev.pl> <Z7XqSVfhPGI5J63B@finisterre.sirena.org.uk>
In-Reply-To: <Z7XqSVfhPGI5J63B@finisterre.sirena.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Feb 2025 15:29:59 +0100
X-Gm-Features: AWEUYZk4HNm_SmluZtNRXIOXfJN4_JOCBah2ClXW_YT2EcZ78XVjnV_7fdlN460
Message-ID: <CAMRc=MdEcjFUp2OEutcnDqSHbbait3f25NEWbdp7mARyKZLvBw@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH] pinctrl: bcm2835: don't -EINVAL on alternate
 funcs from get_direction()
To: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>, 
	Liao Chen <liaochen4@huawei.com>, Chen-Yu Tsai <wens@csie.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-gpio@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 3:27=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Feb 19, 2025 at 11:27:50AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Since commit 9d846b1aebbe ("gpiolib: check the return value of
> > gpio_chip::get_direction()") we check the return value of the
> > get_direction() callback as per its API contract. This driver returns
> > -EINVAL if the pin in question is set to one of the alternative
> > (non-GPIO) functions. This isn't really an error that should be
> > communicated to GPIOLIB so default to returning the "safe" value of
> > INPUT in this case. The GPIO subsystem does not have the notion of
> > "unknown" direction.
>
> I see this was already tested for these specific boards.  I've also
> found that Avenger96 is failing with bisect pointing to the same commit
> this is fixing:
>
>     https://lava.sirena.org.uk/scheduler/job/1126314
>
> as is the Libretech Potato:
>
>     https://lava.sirena.org.uk/scheduler/job/1126285
>
> neither of which produce any output before dying, they'll not be fixed
> by this change.  Seems like an audit of the drivers might be in order?

Right. I don't know if they return EINVAL or some other error so let
me prepare a change that will not bail-out but simply warn on
get_direction() errors in gpiochip_add_data() instead.

This patch can still go upstream IMO.

Bart

