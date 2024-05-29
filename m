Return-Path: <linux-kernel+bounces-194053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD088D35F1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557C91C223E6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE32180A81;
	Wed, 29 May 2024 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EPcWYr+x"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1524414B952
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716984230; cv=none; b=VerPHtU6RK0bMf1npPOXvtuwunJYn53SZj1xO8rFccJ/Uct9vqcWuQDKQiVzNpfIkwvg5hlDsY61XyiWkEI+WXV7nPKBDIMwKZeMnsxMcRjtL5JONl/zWngYknJ326rzxXpK6w5Q5QfH8m5nOIdclckBe7v4sc0yeMJBLOtAeNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716984230; c=relaxed/simple;
	bh=fv1yq+b8Fa0zizeYZwsTuPk1aDZTv0z3x5xDzjMhKpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAq8G3k+P/G456LrNVKvxuh7VOlLuDk+Ntw66MD/jDXktECRnruYYt6sgZ0KSPIJhsViSijwCtUVbfiXCw2NUJR0JHyQU+SO2l7TX0zMPrXCS4x7xVgd+DCUuT2awfrXguzt71jR1itKKDAn2ZUMPL04+eNFkh8JyrAMQw9r4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EPcWYr+x; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e95abc7259so21135891fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716984227; x=1717589027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fv1yq+b8Fa0zizeYZwsTuPk1aDZTv0z3x5xDzjMhKpo=;
        b=EPcWYr+xhalJP5SNZlWIuX4d3NypR/N6n3itvP+3Ul72jQBXdnM2nGrCMXJ34MzS6j
         s2mt2am/ivw45LDcNn9e+IF+3Ur2Fw7GK8aKSfXemJGAE/dmOw5ckVGhq1hR2C8abfNt
         ILbsWN0Kx/8s8knbM8mAljWsAZ74Q0AhLFBPQgn6ijPaFSg2OaucTGpE8fNSqxuIRyWf
         AQzxgxAp1GUDeerpmiU7rojpB05r86HjVf3PWvy7Zra3bR3wQAE2LRa44qTW0TKXd8JY
         CXc1O5202jnG8ymgX/QOH/qxIP4YguZ83xwIfFB+BEXrWZxJIQjIXVLqs1DJrpk5Lykh
         kPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716984227; x=1717589027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fv1yq+b8Fa0zizeYZwsTuPk1aDZTv0z3x5xDzjMhKpo=;
        b=Gi5SpqsbQ+dWSVyrG75zLI5yxOfV5/pJEs+Kda9YGw95+Nzh9K/fKs70NWx3r2as6o
         YsQ8mzxS479RCsDD0+2EEpbGYe6Tw3NwKw9BFvJLU4KcOssFIkaxn6442P+CghRR1fyv
         djaLNGl5o7x5TTZVTcaI9+RjFhmKdVMJ3z2I+sF2ip0Ok8gfeP8aNvl9eVfEO2hByuGH
         X2dpprdq5TkNHJU8u5DA4aEEPK1Efats1dDcf7ve0cpaFpJcvrDTlvL1ry64HXPz5hn1
         5PZe7i3UIn9XD0NR7HPnAX1AGiKWimAzdeJYjO7Hugm/ns2ljuVQxV1FwsOPQONNZnRe
         B5OA==
X-Forwarded-Encrypted: i=1; AJvYcCXSOoVm4jURsPKSde1YLJUMvgVwULSb9pfkOdYKqsSabmpkArijGfiFNNCeaLW4UzvapoZSiDVaDiuxSqYqoYKfY6Kgc+avL9idtxZf
X-Gm-Message-State: AOJu0Yy7cj9u+txfEgqH7htHplOx1WvSjHUHBzntbU0gInOmHgoHnqoN
	O72X82Scj8gYmuQBxFc+40BsqSFUkryq+iuFvM3rTYIfyOSpEz16ib041WO3ia45WduvOypEa8k
	pbY4jfDOv9Jxnj2cP/aH4/ocgG8EIJhrx6DohYw==
X-Google-Smtp-Source: AGHT+IGW6Y1JTq7jxiTaf3GJCoqW86C0BmTISHbEl1PyYE6+lvvfHlDg9UjgH3WZhsxNA+9t6gJf44zVkSYI0Jz9jM8=
X-Received: by 2002:a2e:83d6:0:b0:2e7:1b8:7b77 with SMTP id
 38308e7fff4ca-2e95b0c163cmr94367011fa.22.1716984227064; Wed, 29 May 2024
 05:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716967982.git.matthias.schiffer@ew.tq-group.com> <56cb8a4f19ac0596318d740ed14091d6904d3f7f.1716967982.git.matthias.schiffer@ew.tq-group.com>
In-Reply-To: <56cb8a4f19ac0596318d740ed14091d6904d3f7f.1716967982.git.matthias.schiffer@ew.tq-group.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 May 2024 14:03:35 +0200
Message-ID: <CAMRc=Me_JMjp55VYLFH_gX6+fdCR+3zpsWtds1W+hCmf+k70KQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] gpio: tqmx86: change tqmx86_gpio_write() order of
 arguments to match regmap API
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andrew Lunn <andrew@lunn.ch>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Gregor Herburger <gregor.herburger@tq-group.com>, linux@ew.tq-group.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 9:46=E2=80=AFAM Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> Conversion to actually use regmap does not seem useful for this driver,
> as regmap can't properly represent separate read-only and write-only
> registers at the same address, but we can at least match the API to make
> the code clearer.
>
> No functional change intended.
>
> Fixes: b868db94a6a7 ("gpio: tqmx86: Add GPIO from for this IO controller"=
)

This is not a fix.

Bart

