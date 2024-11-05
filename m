Return-Path: <linux-kernel+bounces-396534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532AC9BCE95
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DED9AB21991
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7EB1D8DEE;
	Tue,  5 Nov 2024 14:03:36 +0000 (UTC)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEE21D5ABF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815416; cv=none; b=hf/+k/TyIuC+afUsGQ5szTZcOGBQhC1hDAaTCR6EdQ1Q1naFT8+9X3E5RI1dMGNMKpilKFi95zSsFsBVpNjrK6feNi5XftcL7BQ89yclOvsYzyKalfqC7JORAYmpBZnsrVYghAQHMVxgZFA2q5/uGGvCwOT41stN6lIZWPTVsjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815416; c=relaxed/simple;
	bh=sFwrPmsss5hpN9ZFw1O/B/a548zydPbn3UKb6dMBOZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtKpKy9PuEFpBVBvNSNGQZO8OqU4dF0lH0eNM7o1cIJaJ/qMf4/UmzTJDW/Tu3FrJdWR3ktYV4XYUBGAXMIdjuaRUA1inZCoOWeLLLOscEi/DedSfo4Yw6KRk4LAlCY05rkVJ9ZGTRgk1Z5kHBCblpILVvxbtjktQeKswNcYe9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e290e857d56so4921039276.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 06:03:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730815411; x=1731420211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lngjfys+B2JzssED4s3MaYSB3SB4j6D4iWEuTRe5Sew=;
        b=NYxBwH7WMRGKcaMt2TVe1/EBjxNYWK43LQTYA2mc/fordPc0A/mdmkWou2C1n6uwRB
         /cAvI2wRkygeS+/ZVn+PXJSuazEuLO4dMDKa9R/zXUpsBMOkWbkCBa+gXSfxXCIwHYbr
         FSyozeABsD1brBl8Pt1keYkLmsJzqMVBhRn/MQiJ4ta4lV7MqaYj4dFfFlbWnuI4maVj
         KH9aWMmS0eqzUMY2d6Xmv07HRtprBX4IF/jz7/GagMqHO2NvqdcVg5L880L6lcLhAoKp
         qRIRBpYSt7hPIpXF3m+EXUZPAtQp6f5AkF+LREnyKn4RgNdWZanphD8w/L0qzSw94gzG
         SFNw==
X-Forwarded-Encrypted: i=1; AJvYcCWJlYnjNwNo+OsvCj69BOy+z8vWA/TT7abdFF6BSMHoQfmB20HVnWLCCvzBSQ7Tp71bzDt0BtvUx5vVwNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqcD6dYoKmZ708EF7z7KFRyTdk44QiRs4xX8xYFsaO65n9yzni
	yY/8ABrdKoQfjEf6aVBw6mW2SJwU0Sfqv5EtX9KGVOExwQV3HzQXaWbrk6Q7
X-Google-Smtp-Source: AGHT+IFDqzw7WBRXHI8oK+uVWdezliP3y3DwmNzRgb4lzVcw56S8GHk86IuzYdQRby2SN5uFmwZaYA==
X-Received: by 2002:a05:6902:1242:b0:e30:cd90:b62f with SMTP id 3f1490d57ef6-e30cd90b6c7mr23440815276.26.1730815411236;
        Tue, 05 Nov 2024 06:03:31 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8a7fe72sm2512275276.24.2024.11.05.06.03.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 06:03:30 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e30eca40c44so4884770276.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 06:03:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWePsHOvtiRk8YHan0MXLiazUOAWK16DvVZEaF0E6BkdDCI8Oca11P7KUJp+6tjoo1ThCzgbomAfK8agw0=@vger.kernel.org
X-Received: by 2002:a05:690c:5:b0:6de:c0e:20ef with SMTP id
 00721157ae682-6e9d88ecdc1mr349956627b3.7.1730815410638; Tue, 05 Nov 2024
 06:03:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016-fix-jump-label-v1-1-eb74c5f68405@yoseli.org>
In-Reply-To: <20241016-fix-jump-label-v1-1-eb74c5f68405@yoseli.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Nov 2024 15:03:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdULfk-_VGXBsnD+Gc7h4c5PRAYDdgx1zEeW=4+1fA0N_Q@mail.gmail.com>
Message-ID: <CAMuHMdULfk-_VGXBsnD+Gc7h4c5PRAYDdgx1zEeW=4+1fA0N_Q@mail.gmail.com>
Subject: Re: [PATCH] m68k: Initialize jump labels early during setup_arch()
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jean-Michel,

On Wed, Oct 16, 2024 at 6:18=E2=80=AFPM Jean-Michel Hautbois
<jeanmichel.hautbois@yoseli.org> wrote:
> The jump_label_init() should be called from setup_arch() very
> early for proper functioning of jump label support.
>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

Thanks for your patch!

> --- a/arch/m68k/kernel/setup_mm.c
> +++ b/arch/m68k/kernel/setup_mm.c
> @@ -249,7 +249,11 @@ void __init setup_arch(char **cmdline_p)
>         process_uboot_commandline(&m68k_command_line[0], CL_SIZE);
>         *cmdline_p =3D m68k_command_line;
>         memcpy(boot_command_line, *cmdline_p, CL_SIZE);
> -
> +       /*
> +        * Initialise the static keys early as they may be enabled by the
> +        * cpufeature code and early parameters.
> +        */
> +       jump_label_init();
>         parse_early_param();
>
>         switch (m68k_machtype) {

This is indeed what some (but not all) other architectures are doing, so
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

I assume you saw some "static key used before call to jump_label_init()"
warning[1]? Since I never saw such a message, can you please elaborate
and explain your use case, so I can add that to the patch description
when applying?

Thanks!

[1] https://elixir.bootlin.com/linux/v6.11.6/source/include/linux/jump_labe=
l.h#L81

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

