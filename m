Return-Path: <linux-kernel+bounces-556400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54218A5C646
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51C2D7A9012
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A147E25F782;
	Tue, 11 Mar 2025 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y5zCKpAA"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291D725DD08
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706558; cv=none; b=kcq2xiyQTvZs48+fOlirULlsmKQszxuPakKjGyLI98tY3RuxnN53PHo8R1mXvC+4OrXPFeBR+Sj2z7j8VTR+r01D4cBtZd4KeT1ILjwFwFZpL3i2yZJqxzrzN95oC7Uaak74PEjaN25O0m5nfQu/Lp+z9uZ9nsXASCw5n+zw4E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706558; c=relaxed/simple;
	bh=UxtYwYns0MvhCa2m5ObZdAnlsKQGOnGlpHac9oEyev4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcPoJsP0XxlDPVjFftAmaxGd8ReZIjSJdqKdk8KFJpmZlxE9JVY8itV3tqAzItqJYfzZB6MuaUzZi4zpIALe+ijM5auh2Fk7KSWyQydPMixhH211JaE0RxS5UXQY05ljVmoy566aLcu5BIK7bBAbEJCG5OHrYJBVGiBi02rr5zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y5zCKpAA; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6fd8be1e534so52935377b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741706555; x=1742311355; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HdiaqU+kYXkNBNnpqC5PVQou0G4lEwUYRv6GT9pOGpI=;
        b=Y5zCKpAAqvWWdwWu3jfhumpmdT2BGNTxA4Pm54r6smnlF0Eyvj6uRToq4TXKY/r6nL
         sO7XcgyWOp/djAQjvurj2fhezVxcxIKfOts9SzpvpF6KTyUm2A8pIAhPV8qHUTp/4XA/
         wpF3+pLFVig7ddquS7HSTFK2hKxfm2wIXK7B6N7T3xTLPnbRiQXTiMvgkSbi9wEAGuTz
         BxOdl1y+89pkyoaGAo6ZdpcKaj8H9f9SStR1Tf6AykwsEq3iJxbGsjoOwdnoVuV2cOAL
         xt9wU1gg4Gs7AULsLI/dePUBD6xlLWsD8QpGjSu/+nXInCInULD0DeXg7uEBTBECL1np
         qckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741706555; x=1742311355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdiaqU+kYXkNBNnpqC5PVQou0G4lEwUYRv6GT9pOGpI=;
        b=mvs4GORdyb9yL2lDdTbKD+HKDHlQCGlv6QzKtazrTn1j/NSX8iTxhPzPfkL3H9577i
         NixgiI6Fk1Cxl6FMBcvteggKUmmOsSEznFocqB8Xv4crjqd600A1V4ezy/DQoWMCDk/8
         s8IQKpqQLfVGv57CC8BHPLRaYNNUeAvMhvbqO32rvqDDIoHPU0IkUFeUuv9P04TUbRgE
         L8tOy4Wql+m9oOdRCFBvxnZN+j1oqs+tRDpXoiU9Qag0oznEEh25N7WVIK8RB/R7SHfm
         Jo80TjAgfw3JG39OY6cJNAc2PZ++tooJ7YYn6MaTpSvN+62aosQ1Zj8bl00T+pRCC49/
         9nEA==
X-Forwarded-Encrypted: i=1; AJvYcCUdEVZRo0gRiEFGNBgnuH+RG7LNHVLKNCFYt69FjMb/dOXQ/xiKm+/upvwD0bjmV49qUjYE7Q9lkraYYRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeKAcO4XhvTUMOYTv9Z5UrlmLEvhVPwtr5ANo+X1r25jEt/dvy
	dFAjaxPqa+nzLQaMn9MLOgUqEfc1rmZT2W448n28oRuX1tPyk1zx5K/Xj4RTt/ks/U3Q6VGk5A4
	WFS0jM30q4xaQzprm+Y0Giy8wW2i7xbW1GXdIag==
X-Gm-Gg: ASbGnctfh0/1S7BXFbnHS4EwaMvByS0Jvt79SfelRZ1gFEsuzmOVpLaEV1hS/83Z9xv
	k6gqiQ0t3oifEOk7YBLBx/VbtuRM68McqIArNn9HuSijfp2QPdQjt0QjucbC3vLbQOE3Exr+kdy
	huhdDadjh0jYzF8MaUnzqqtQJFJOc=
X-Google-Smtp-Source: AGHT+IGAy6+55/xUbWPLWAhWa/JJEH75eRRXo5nC8iwxe2xNn2XBzu/ByvzI/h9Bw5amhUiPp08ireVcbtB30aKD1pc=
X-Received: by 2002:a05:690c:688f:b0:6f9:88b7:b6b7 with SMTP id
 00721157ae682-6febf3e990dmr252844457b3.37.1741706554935; Tue, 11 Mar 2025
 08:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250310090220eucas1p1d5cf6a56935e21b5854f77fdc22236b1@eucas1p1.samsung.com>
 <20250310090211.286549-1-m.wilczynski@samsung.com> <20250310090211.286549-5-m.wilczynski@samsung.com>
In-Reply-To: <20250310090211.286549-5-m.wilczynski@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Mar 2025 16:21:59 +0100
X-Gm-Features: AQ5f1JoXRXq5ucc-B5U0o3JR0rVlad9-RVtJACjXjl-xVuXRu_bgY0MVKH5Qe8E
Message-ID: <CAPDyKFpAxkVgscMQpe2MZFCmNyaFq9YqiPQknLDf3CJ9zMdZ6g@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] pmdomain: thead: Add power-domain driver for TH1520
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, 
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, jszhang@kernel.org, 
	m.szyprowski@samsung.com, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Mar 2025 at 10:02, Michal Wilczynski
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
> +       aon_chan = th1520_aon_init(dev);
> +       if (IS_ERR(aon_chan))
> +               return dev_err_probe(dev, PTR_ERR(aon_chan),
> +                                    "Failed to get AON channel\n");
> +
> +       platform_set_drvdata(pdev, aon_chan);
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
> +       return of_genpd_add_provider_onecell(dev->of_node, pd_data);

If this fails, we should clean-up properly, not just returning an error code.

> +}
> +
> +static void th1520_pd_remove(struct platform_device *pdev)
> +{
> +       struct th1520_aon_chan *aon_chan = platform_get_drvdata(pdev);
> +
> +       th1520_aon_deinit(aon_chan);

The genpd providers need to be cleaned-up here too.

Or, as I said before, if you think doing a proper clean-up is going to
be a problem (in most cases it is), we can also make this a
builtin_platform_driver() with "suppress_bind_attrs = true".

> +}
> +
> +static const struct of_device_id th1520_pd_match[] = {
> +       { .compatible = "thead,th1520-aon" },
> +       { /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, th1520_pd_match);
> +
> +static struct platform_driver th1520_pd_driver = {
> +       .driver = {
> +               .name = "th1520-pd",
> +               .of_match_table = th1520_pd_match,
> +       },
> +       .probe = th1520_pd_probe,
> +       .remove = th1520_pd_remove,
> +};
> +module_platform_driver(th1520_pd_driver);
> +
> +MODULE_AUTHOR("Michal Wilczynski <m.wilczynski@samsung.com>");
> +MODULE_DESCRIPTION("T-HEAD TH1520 SoC power domain controller");
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
>

Kind regards
Uffe

