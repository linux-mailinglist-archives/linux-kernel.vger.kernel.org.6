Return-Path: <linux-kernel+bounces-349200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 109DA98F26A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33EF2813DE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DFF1A287E;
	Thu,  3 Oct 2024 15:19:36 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC572747B;
	Thu,  3 Oct 2024 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968776; cv=none; b=AXmbW/bsqsKG6VqiZbmGVpkjKraT+e7RqLGl/K8cE+sKhPUmqozoNw1cepJi9ohrXWJPe3bFTs8Ce58fhIw2MAaZy6W43/dfWPXD7k1OLqHoTd5HmNoIa7/6iZ0UX9pn69dpv76BoC7JZS7dmg6pbnKsXFhasSTw95IfQnfD1Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968776; c=relaxed/simple;
	bh=qOBripUtAi6zPiMt73YB1Jwrl/ECFz0MdjfoZ5SWjhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hn5BipIJMvhXMPI7HSmFVkJiE920CsaEXR5LGnpfkRS/OOWUPCp8oWppBgRmvLIj93WahhZXCfLdLQ4ivzQ2FWNdFTHNRh8Tc92D811zyZw5rMrGKTShHsSa3qunD6tc8ipb1/4ZO2A8LAz8+5g+tl2bohneslYH8yCG+MncB1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5389fbb28f3so1181961e87.1;
        Thu, 03 Oct 2024 08:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727968771; x=1728573571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EUoJLCJlNOrdcCBBrdtSB2Ow6qmvTKXbEuWR7svHuGY=;
        b=SGb4W/gUBWmlHWgeKZy92BWI6hrpDkx3WG+DhMBIpXsjdjeXv/D58KxV9J+aJr0XTC
         R7oj745x1bbLY78Dfhp+2CKdVyXJOHUTg4QXjvvF1VfgcVbjIukzoMdWxd5nnYS+MhDV
         4osHNFfNiVhoIFWXKmaAnjRNJiU5TxlM6236tqEe+CiPJjRr6PnMrNmyh7PqSXmSeh+z
         ZRJXQqwcphMk3OIWBK2UpmPTBZuiajFg3i+hgw1msbVh/NSSaMNAw8UUvyZ0xBa+P0gK
         mFgKVFQxwP+h2gk0W0a+GXSjwaJRGalVOQM1v6HG3VEPUTW2PfpeEEwi2v1gdcW0Jdv3
         uS8A==
X-Forwarded-Encrypted: i=1; AJvYcCVka/LGFQAsxGDb9uQlQEFXdrgScXN/i0haTFdu7DLqe0v4z++iSQz4y0mrUk3x/mwkkU2vniSLhWN50nJ3@vger.kernel.org, AJvYcCVnvfXjwvuTpCJDH/32sWvfh1WFmUNtnauf7Hsb0DY0HOZULjhyRYO/Oq3IMHSHgTyPkQIBnIQZAii0@vger.kernel.org
X-Gm-Message-State: AOJu0YysmCtADc84fMpe/x6DeJrHrXzyb4gNrrZGIhhPftLMVz0zPUrl
	C6YmLYV/z1aixqQyiN+TSEHJsoyz4lGZ8XPcrqrWKp63fnU2rms1C6NLDhZwVqs=
X-Google-Smtp-Source: AGHT+IHGp17z66hexRVSFg+rzv6eNyYaVg9ZhM/nP/QlE89k10uk+zGdbRnm0RU0w36kJQTXjuWaqw==
X-Received: by 2002:a05:6512:e9c:b0:539:9452:6927 with SMTP id 2adb3069b0e04-539a625c69bmr1278206e87.2.1727968770774;
        Thu, 03 Oct 2024 08:19:30 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faecc959d0sm2309761fa.114.2024.10.03.08.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 08:19:30 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fac5eb10ceso11298251fa.1;
        Thu, 03 Oct 2024 08:19:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDsS4j6MYglqNNJMDMUGL8R/AyzR0jWUyVuvtI+b5n4vXPxoYj4D0sPkpkQPxZ6sagappSX1H1kNecPODR@vger.kernel.org, AJvYcCXRPNvxY4NYBsRo29Nz60XTcPmDDAq2M9Nzn46rD39EcrKVO6uXEZF+Yrp1j0lAHR2JeksIhB53izeg@vger.kernel.org
X-Received: by 2002:a2e:a552:0:b0:2f7:5900:1a37 with SMTP id
 38308e7fff4ca-2faea25332amr11916321fa.17.1727968770274; Thu, 03 Oct 2024
 08:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003111444.543964-1-andre.przywara@arm.com> <20241003111444.543964-4-andre.przywara@arm.com>
In-Reply-To: <20241003111444.543964-4-andre.przywara@arm.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 3 Oct 2024 23:19:16 +0800
X-Gmail-Original-Message-ID: <CAGb2v64c-KoCwzfXpPbyLtxgZbwoQ+e4uYAk7pcHCkrTRbfr3A@mail.gmail.com>
Message-ID: <CAGb2v64c-KoCwzfXpPbyLtxgZbwoQ+e4uYAk7pcHCkrTRbfr3A@mail.gmail.com>
Subject: Re: [PATCH 3/5] mfd: axp20x: Allow multiple regulators
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Martin Botka <martin.botka@somainline.org>, Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 7:15=E2=80=AFPM Andre Przywara <andre.przywara@arm.c=
om> wrote:
>
> At the moment trying to register a second AXP chip makes the probe fail,
> as some sysfs registration fails due to a duplicate name:
>
> ...
> [    3.688215] axp20x-i2c 0-0035: AXP20X driver loaded
> [    3.695610] axp20x-i2c 0-0036: AXP20x variant AXP323 found
> [    3.706151] sysfs: cannot create duplicate filename '/bus/platform/dev=
ices/axp20x-regulator'
> [    3.714718] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc=
1-00026-g50bf2e2c079d-dirty #192
> [    3.724020] Hardware name: Avaota A1 (DT)
> [    3.728029] Call trace:
> [    3.730477]  dump_backtrace+0x94/0xec
> [    3.734146]  show_stack+0x18/0x24
> [    3.737462]  dump_stack_lvl+0x80/0xf4
> [    3.741128]  dump_stack+0x18/0x24
> [    3.744444]  sysfs_warn_dup+0x64/0x80
> [    3.748109]  sysfs_do_create_link_sd+0xf0/0xf8
> [    3.752553]  sysfs_create_link+0x20/0x40
> [    3.756476]  bus_add_device+0x64/0x104
> [    3.760229]  device_add+0x310/0x760
> [    3.763717]  platform_device_add+0x10c/0x238
> [    3.767990]  mfd_add_device+0x4ec/0x5c8
> [    3.771829]  mfd_add_devices+0x88/0x11c
> [    3.775666]  axp20x_device_probe+0x70/0x184
> [    3.779851]  axp20x_i2c_probe+0x9c/0xd8
> ...
>
> This is because we use PLATFORM_DEVID_NONE for the mfd_add_devices()
> call, which would number the child devices in the same 0-based way, even
> for the second (or any other) instance.
>
> Use PLATFORM_DEVID_AUTO instead, which automatically assigns
> non-conflicting device numbers.

That's weird... I don't remember running into this when working on the A80,
which had two albeit different AXP chips. That was a long time ago though.

> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  drivers/mfd/axp20x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 5ceea359289f..bc08ae433260 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -1419,7 +1419,7 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
>                 }
>         }
>
> -       ret =3D mfd_add_devices(axp20x->dev, -1, axp20x->cells,
> +       ret =3D mfd_add_devices(axp20x->dev, PLATFORM_DEVID_AUTO, axp20x-=
>cells,
>                               axp20x->nr_cells, NULL, 0, NULL);
>
>         if (ret) {
> --
> 2.25.1
>

