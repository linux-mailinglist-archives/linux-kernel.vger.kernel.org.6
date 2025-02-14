Return-Path: <linux-kernel+bounces-514831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CD5A35C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C8016F377
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779C5261579;
	Fri, 14 Feb 2025 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OI2otWP4"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB5025C6F2
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739531796; cv=none; b=tAwQXD7Ozl9KDAqi8pV3R8aUeOr9wCfSxv4EWQrspNnq2E/NEC7x3Vh/ONSRSSmc5AoZNKvtUAq2+jRhR/LfAc1CKqxIk/Rqm73TcUYLow8qFbkbT2X/5n4zD3bCdILilFikDe+TeES9viteQ9v0QQGc9HM2l5YfK9ebdeiwQ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739531796; c=relaxed/simple;
	bh=Nv+6Ycy+r/YLOTrYHkPYwU3kd5MfJvihnaHXExKMBQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMk/yB1+DWPIXIQMEPLO3AIny7TVfaNsYcuYDuC/UKOCwrquZf3AIPOp5pd1ph9n9nAs8TYbohv/PZTjngEiCl3o8yznkBGIc3KTfUER1sJXM3+7fJ/tn4LW/B7oBch1nCWJGPAJ7+/offWaH/ESzcjZ6jVz0xpii2VGx8rQnkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OI2otWP4; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e46ebe19489so1346380276.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739531794; x=1740136594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9jM48aKf/sbl9H/oOIzSS3d/8y4m7nkDsYlbYDKZEDc=;
        b=OI2otWP44QmJsoWW6RJiWch/jCTDIewr6cfpbcKwj/F7m36rqzqlUgKidAe42S+0S4
         Z7sl3GyDZudsFFofQHZvvXpLyBBeIxAlhSPSmFD2b9fQ8MrDh8lYn64YjwcrstwGrPph
         UcOOQIc6sq3RMSX77WwLDimMAqZosz21ge6REELimIcopeiS/RZF2FNLUhbWcGDpUgbu
         0PACkJqPTYGriSinpNaJtPZooZGLlY1F1SA2cVH4oMNuYPeCktrvhZSCMCgYqCRidG9r
         WD/sauw0CRoqsGpFsTrR1EpxCRtFdzkud54FGFRQCIJlNQzwkGVPWnAEZz9jH/S/AUCV
         PVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739531794; x=1740136594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jM48aKf/sbl9H/oOIzSS3d/8y4m7nkDsYlbYDKZEDc=;
        b=ss7+evrYV6uE3SSBnOp22FPnJReuU7co8O2Vn3C6S5ziW3+LdBIyrxGrNwPly0KIId
         WZiHipoUXUjG38hOl6ArmLcJNfjxKBwHyBnZKoxHMOby41ipyl5t/djydhdtyNMwtD52
         Kj2/oEGHNdl5GQEXloOteBsVCKiQ1iYVXrv986XUsI5ma7nAbukkY0D8j+OtgllXufLi
         JcPLsnfjRjBnyD399PQq/XA2k6Rl3pT3/7DfOs8dDYFNdC2TWukTqdwmm5qkDDcZbGfE
         Jzser2jZoE9ijP8dYYR+GfGFDYtrhE55a+sxTdjsLhrlyvxIVTU1qe8Scivht2bKoEOI
         cv7g==
X-Forwarded-Encrypted: i=1; AJvYcCXbv0hN884X4CzqQqTsZINZJ0ocoSe4TTZDrZCqzJc/5ghqKq1B5MUvu09Vr14iJGR5DA7Vm5qkGwoI1V4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw0atBtg0NTcXxospWGlwHKDc03Dfxtj2hN7A1PqJXp2UomZOZ
	5AcUrBCx4d9q/3rQrAm9ePFVY1FK9JelII9lkA3AnflAUOfZ3umaYjMZSp4UlsL/aPV+2bneE5N
	mnOFzC8FangSeGWpCSkkdqoQ9H6+hi93URhAWgw==
X-Gm-Gg: ASbGncs2a19jfYkOKBko3tTPPKWCQu6pHoe0JoPyC4UfBMmt4vEmLJODIZMGvxIOcED
	NCGYmUIWmouofXildeMu3u6dWYGatkKsXtdrJuBD5CGmpdO0DyEvizNqRP++H51ivB+j+aShG6Q
	==
X-Google-Smtp-Source: AGHT+IE6woj8oPDle191tVLCdn9IrSTd52LbGDiCC/HBR/zbujT5GVfsySFK4K0WQQyEViMhqMK63WlGFClc8+pjkbk=
X-Received: by 2002:a05:6902:841:b0:e5b:323b:a1a4 with SMTP id
 3f1490d57ef6-e5d9f180dc6mr10461212276.41.1739531793901; Fri, 14 Feb 2025
 03:16:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250128194832eucas1p15db9ed3575703812ecc0374ffc5b2861@eucas1p1.samsung.com>
 <20250128194816.2185326-1-m.wilczynski@samsung.com> <20250128194816.2185326-7-m.wilczynski@samsung.com>
In-Reply-To: <20250128194816.2185326-7-m.wilczynski@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 14 Feb 2025 12:15:58 +0100
X-Gm-Features: AWEUYZmWRXn0bzCrMyNA_HXGOtxuTTirzpyDWms-8p0mq8f1JPxvJIR_18CPMCg
Message-ID: <CAPDyKFrcs5Hc-X6qExEA992MoQcakCuKRjw7cek3KpYZihsLFw@mail.gmail.com>
Subject: Re: [PATCH v4 06/18] pmdomain: thead: Add power-domain driver for TH1520
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org, 
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com, 
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, jszhang@kernel.org, 
	p.zabel@pengutronix.de, m.szyprowski@samsung.com, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Jan 2025 at 20:48, Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
>
> The T-Head TH1520 SoC contains multiple power islands that can be
> programmatically turned on and off using the AON (Always-On) protocol
> and a hardware mailbox [1]. The relevant mailbox driver has already been
> merged into the mainline kernel in commit 5d4d263e1c6b ("mailbox:
> Introduce support for T-head TH1520 Mailbox driver");
>
> Introduce a power-domain driver for the TH1520 SoC, which is using AON
> firmware protocol to communicate with E902 core through the hardware
> mailbox. This way it can send power on/off commands to the E902 core.
>
> The interaction with AUDIO power island e.g trying to turn it OFF proved
> to crash the firmware running on the E902 core. Introduce the workaround
> to disable interacting with the power island.
>
> Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf [1]
>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---

[...]

> +
> +static int th1520_pd_probe(struct platform_device *pdev)
> +{
> +       struct generic_pm_domain **domains;
> +       struct genpd_onecell_data *pd_data;
> +       struct th1520_aon_chan *aon_chan;
> +       struct device *dev = &pdev->dev;
> +       int i;
> +
> +       aon_chan = dev_get_drvdata(dev->parent);
> +       if (!aon_chan) {
> +               dev_err(dev, "Failed to get AON channel from parent\n");
> +               return -EINVAL;
> +       }

As pointed out on patch4. Rather than receiving the aon_chang from the
parent device like this, it seems better to receive it from a call to
a library function provided by the FW library.

> +
> +       domains = devm_kcalloc(dev, ARRAY_SIZE(th1520_pd_ranges),
> +                              sizeof(*domains), GFP_KERNEL);
> +       if (!domains)
> +               return -ENOMEM;
> +
> +       pd_data = devm_kzalloc(dev, sizeof(*pd_data), GFP_KERNEL);
> +       if (!pd_data)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < ARRAY_SIZE(th1520_pd_ranges); i++) {
> +               struct th1520_power_domain *pd;
> +
> +               if (th1520_pd_ranges[i].disabled)
> +                       continue;
> +
> +               pd = th1520_add_pm_domain(dev, &th1520_pd_ranges[i]);
> +               if (IS_ERR(pd))
> +                       return PTR_ERR(pd);
> +
> +               pd->aon_chan = aon_chan;
> +               domains[i] = &pd->genpd;
> +               dev_dbg(dev, "added power domain %s\n", pd->genpd.name);
> +       }
> +
> +       pd_data->domains = domains;
> +       pd_data->num_domains = ARRAY_SIZE(th1520_pd_ranges);
> +       pd_data->xlate = th1520_pd_xlate;
> +
> +       /*
> +        * Initialize all power domains to off to ensure they start in a
> +        * low-power state. This allows device drivers to manage power
> +        * domains by turning them on or off as needed.
> +        */
> +       th1520_pd_init_all_off(domains, dev);
> +
> +       return of_genpd_add_provider_onecell(dev->parent->of_node, pd_data);
> +}
> +
> +static struct platform_driver th1520_pd_driver = {
> +       .driver = {
> +               .name = "th1520-pd",
> +       },
> +       .probe = th1520_pd_probe,
> +};
> +module_platform_driver(th1520_pd_driver);

There is no ->remove() callback.

Either add one or make this a builtin_platform_driver() with
"suppress_bind_attrs = true".

> +
> +MODULE_AUTHOR("Michal Wilczynski <m.wilczynski@samsung.com>");
> +MODULE_DESCRIPTION("T-HEAD TH1520 SoC power domain controller");
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
>

Besides the minor thing above, this looks good to me!

Kind regards
Uffe

