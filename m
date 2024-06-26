Return-Path: <linux-kernel+bounces-230538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A096917E45
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52358281B14
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EF117B405;
	Wed, 26 Jun 2024 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gCVi/Odj"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6247C16D335
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398290; cv=none; b=i788wL5pbQdpw+64RB5ZtA9l6im8nDUd5OVI7iJgSZS/hOV+c+7KzAMxsW8ujfPQ7JkstuQlF+Wf7xS70GiZCSPgE0JZ/xu4ffFydagwKu2PPUd5AS8RB6c+VXaC4ZetapjxK8FttsnulB0+22JdRQ+HjYdvkkmpaZSShY42wQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398290; c=relaxed/simple;
	bh=VYUz5N4gtv8iv/6U7Fma+w++MYKM4dTro8aD5iMAqJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZlgfj+5GBo6aSF4MzdFcU6qVCLcKgcO25U/cmJoP2ZJ8IFAip5vxndw2WPPm4+oc+YMdX1Oy6DaNjLKvNtVfksIZSw1YKzef5O44TfXY6z5XIvPiKFHZHIhFct30Djkoct4LObomIJFsnej6VUx7cV06jF/oKXJ7vmHiK3XTVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gCVi/Odj; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cdea1387eso4241900e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 03:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719398285; x=1720003085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAP7Avo0NqErHhw/LgeqaI6OS2BfZZmGrKu2N8kUgqY=;
        b=gCVi/OdjXk1Y+PwpYIimpHcOd6rlm3EMdwPd+qg7wNDxO30YSdDKf+Wy1sJGxbJ/uo
         1m7IWGK1Q6YNDxOOexYKXdCB51zrmPR4r/wYD0/kNtIdvw1Z8O2i1d9igV/bOwf8PPih
         pZtEX55l1npz7Tm25GTml+EascAMpqfmopNa9l+ALEFPoBy/YVRJqerPoRSZaoS6ODS2
         uYIlDuIki+ZaWyfnfeOMNHWZV1sDzcbN4zxAaYTDEIqvcall1MIVi4ytLDITCOdWixG/
         dWSTeD/RM+3XzC+qJnhuh6HzsQaWw7uqDIFAcIWFaT0P58/Qtkp7mA3xT9RkK/mqcne1
         b7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719398285; x=1720003085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAP7Avo0NqErHhw/LgeqaI6OS2BfZZmGrKu2N8kUgqY=;
        b=inqChmektXGBE8vPu/PHMw3fURbB1ZvPgTe8a8r0ECsw+XVCsoqCrrbUs4o4zS0B2s
         NIyP0+zYT7nLJh/xvVgeKlugjLzHfsyCSZXIEJehskOPeR+8hr08hsnVyZoO2VaJkhmc
         pBrm5AX6BNML24FZYcny3kPqM+N1yK/EccsB83EPFDdDT63H4mzudxfzxxkZCLaD6lWi
         wW270YVT+1S7RcSfei3yPqrSeFvxd23TyXhaTmWAaen2yOSdoJ6Lbe/JrmYkln2x/JSs
         ADdCMew4U4K87B5TlA1IxvA2tLu2pwKJVtcqqSgbuV4Snf6QfpvoEzGo6xHnZyDesLv/
         Vhxw==
X-Forwarded-Encrypted: i=1; AJvYcCVUUO688g2w15Cs/rkWOG9YYjREt8kvM9uDJGLUWtn71EDcnymEJhTna7ODSwGGqq2bTxd1Oc+x7ZhLNsoTQikz0j/Lfq6lTGqkD+/G
X-Gm-Message-State: AOJu0Yxi8vy+/nmzGMx2uB8qPealBdpBQzA2ZxCi+0hKHgN+yW3shVQl
	ra5I3jBTOF5gNc2P6Wt3G2IeDnrhLetcLeGHxADcIEN0RPMTsLiZEP0tuMg5f1+frvo0zWsiQ4L
	pepimmGo8NeGUGZZeR/GU0E8i12YMVdC29vz1jQ==
X-Google-Smtp-Source: AGHT+IGzCEHmUW20SzJfj/AOkF92f/FKlba7gvSlxZWz6Yna1JEIXVmc39gid0pFCtGiZI+oDk6MEqv5XprFAgIE2Tg=
X-Received: by 2002:a05:6512:3091:b0:52c:e54e:f84b with SMTP id
 2adb3069b0e04-52ce54ef9fdmr6615691e87.14.1719398285525; Wed, 26 Jun 2024
 03:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d01818abd880bf435d1106a9a6cc11a7a8a3e661.1719125040.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <d01818abd880bf435d1106a9a6cc11a7a8a3e661.1719125040.git.christophe.jaillet@wanadoo.fr>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Jun 2024 12:37:53 +0200
Message-ID: <CACRpkdZ-DOLV1ZHALCDKaUjj4HjwX_qLJ9GttKMvrRJ867q64Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] power: supply: samsung-sdi-battery: Constify
 struct power_supply_vbat_ri_table
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 8:45=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> 'struct power_supply_vbat_ri_table' are not modified in this driver.
>
> Constifying these structures moves some data to a read-only section, so
> increase overall security.
>
> In order to do it, some code also needs to be adjusted to this new const
> qualifier.
>
> On a x86_64, with allmodconfig:
> Before:
> =3D=3D=3D=3D=3D=3D
> $ size drivers/power/supply/samsung-sdi-battery.o
>    text    data     bss     dec     hex filename
>     955    7664       0    8619    21ab drivers/power/supply/samsung-sdi-=
battery.o
>
> After:
> =3D=3D=3D=3D=3D
> $ size drivers/power/supply/samsung-sdi-battery.o
>    text    data     bss     dec     hex filename
>    4055    4584       0    8639    21bf drivers/power/supply/samsung-sdi-=
battery.o
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Really neat!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

