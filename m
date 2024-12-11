Return-Path: <linux-kernel+bounces-441509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6E19ECF71
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9E91885436
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3446B1A0BCF;
	Wed, 11 Dec 2024 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="H0eTi/Hh"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751E324634C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929925; cv=none; b=BiTIllmGx/b1+ktVp/mfxkPs8YR8csmQF/Z3wx3EP+mFo6vT6B7YtPLQoh9jyHZwD74CfaJTzN9Yx+EkqMPGrIlg+zugfN7hiDif3nqIKL8XiPCcST5a+LAerlXDPRf98Zs9cM6iOuUVviC+p7GNXPNM/GHCFfx6gvhluItNz/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929925; c=relaxed/simple;
	bh=/fbSKmNg2u+Y4UnSPAfvQRzSqmMlOyu+5kS5NYWq6hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/fYtCIpAPs1ENBSDCnSTHawEBSfrT2obOYSSGtmTC5QoQM5NemVA9N4bZ6pZQ4BkVQCibKJ1KzFkQlBGR2coDB5063S9VRvqc6Fki8aQ77hR1FW8SKXCIPwzJi7h54AwTYYejqftyzCaK5D1+BmN1yEfOqdJh9Z0Ft588OV7Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=H0eTi/Hh; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30227ccf803so29867331fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733929920; x=1734534720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DkasB+WpYyiIPsHiP3HzywtShV9peIAKRCRE8C07g4=;
        b=H0eTi/HhWsapKLrCrEGK5R1yIKPYIrXkbSsxvVbHtmmTBd67nwXXeowtE6BroK2PyZ
         /N/XsNUc8VfixgINoda5KtLWpOp4MGi3tbDBDlgPtyFkG4vnUzBweVeKoD++tct1ilFr
         QknYgOZc13JfDhE10xPBREZsxa8MT3x9R9Ef0p0ZqEn1VEuQeqxnnyIwEyx+EcxyKxZR
         MrtGxuQTNXcAk9XvsUmuYSg+h3JDZOolJ5RsdV0y9YDiN/JWVS2/DMDvbztBrYVSHIS5
         MIz38b5ePchtXDwhDNBevDeNs7y8bXIRVQYZyJT9nxrGGJMkQwZp/rNwgsNv7Qar6NIG
         A7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733929920; x=1734534720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DkasB+WpYyiIPsHiP3HzywtShV9peIAKRCRE8C07g4=;
        b=YATp6s28gDkTAO3dYEpbormZfaW+zgoZlxs6qy0oIL7dWSesae7Sw6Gi0qfhLMUXrJ
         8AAK+naejo2pBEwosxe4vOH0GiWKuwGgsh1ogRsE+Be0mIxJgUFP7Z94nj25tbTfToN6
         qNysfvhHDlhgZlVmBa9DRGH4iT9J0wd3GSUdC5I/p6s02ksOBF55gzZdahpH5nOnMLU7
         mou9LvQAopiUBhP38/1Ykb0lbQO81wpfNNA98MOFxgtv/lI0C3XdFue7FIrcf1hmzdKk
         IQm2hw6ATFnpe+iLZhk45H5W9UM7ROYY15XMib8fuIP5GKdb47c21kAq+Ofl6i+QYpan
         5Q9g==
X-Forwarded-Encrypted: i=1; AJvYcCXs1E69sI+CF2kMAvJHk2xWlVhqXR5/owfA3HX5E/4mzXdfpQBsSnEokgXGt2yN9HZzZXFHXgNQJktJLN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Q51hYwrg4/uf17AMvlu2RVWQkGmUzg6NuzdjnIbysOwziPB5
	hxxrzFyvVhn3ZzoOeY2wMlyZG0rY+bUgh+ytlzJytWQmKDw+kqnw/YUeoNC3P+4ObU5PT5rvGgz
	uAVXtNyMbI2g6J0Mfs4TX5Pj1P0PnAORpV4KpqXEjlx03N1fN
X-Gm-Gg: ASbGncuzg5J8iBkmwADoEMPYHFQl+okusO/12ELiUnt500gijPHZw0sJlf6/2qhORyR
	Z3cUPfNtkOOwXetSF5YD89XlCv0vwHqRKO8TSn2mV5mn5TokFoMg6aE9eU8AyvrLzkSA=
X-Google-Smtp-Source: AGHT+IGszQqaB3fBa9w6UmnSUZco72wFv/6k1127oe+o2ZL4zElM2PbP0pKWNsQUi3nGqynG26NjsN93L+GvnT+S6vY=
X-Received: by 2002:a2e:bc27:0:b0:300:34b2:f8a3 with SMTP id
 38308e7fff4ca-30240d088famr11276841fa.13.1733929920342; Wed, 11 Dec 2024
 07:12:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733739697.git.matthias.schiffer@ew.tq-group.com> <fba6114b73634d0327d5d34a0634d3b500aab059.1733739697.git.matthias.schiffer@ew.tq-group.com>
In-Reply-To: <fba6114b73634d0327d5d34a0634d3b500aab059.1733739697.git.matthias.schiffer@ew.tq-group.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 11 Dec 2024 16:11:49 +0100
Message-ID: <CAMRc=MdDdkoMpd+pAJGTC1bMpNVb8D__5KGcxYK=OmOEP-C-Dw@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpio: tqmx86: add macros for interrupt configuration
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux@ew.tq-group.com, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 11:36=E2=80=AFAM Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> We now consistently use TQMX86_INT_* flags for irq_type values. The
> TQMX86_GPII_CONFIG macro is used to convert from TQMX86_INT_TRIG_*
> flags to GPII register values. Bit patterns for TQMX86_INT_* are chosen
> to make this conversion as simple as possible.
>

Please use imperative clause in commit messages. Prefer "Consistently
use..." over "We now do this".

> No functional change intended.
>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/gpio/gpio-tqmx86.c | 43 ++++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpio/gpio-tqmx86.c b/drivers/gpio/gpio-tqmx86.c
> index 5e26eb3adabbf..667cb34b882f0 100644
> --- a/drivers/gpio/gpio-tqmx86.c
> +++ b/drivers/gpio/gpio-tqmx86.c
> @@ -29,18 +29,21 @@
>  #define TQMX86_GPIIC   3       /* GPI Interrupt Configuration Register *=
/
>  #define TQMX86_GPIIS   4       /* GPI Interrupt Status Register */
>
> -#define TQMX86_GPII_NONE       0
> -#define TQMX86_GPII_FALLING    BIT(0)
> -#define TQMX86_GPII_RISING     BIT(1)
> -/* Stored in irq_type as a trigger type, but not actually valid as a reg=
ister
> - * value, so the name doesn't use "GPII"
> +/* NONE, FALLING and RISING use the same bit patterns that can be progra=
mmed to
> + * the GPII register (after passing them to the TQMX86_GPII_ macros to s=
hift
> + * them to the right position)
>   */

If you're changing this, can you switch to using the preferred:

/*
 * foo
 */

pattern? Checkpatch should have warned you about this.

Looks good otherwise.

Bart

