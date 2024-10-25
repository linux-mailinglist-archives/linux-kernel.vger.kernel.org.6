Return-Path: <linux-kernel+bounces-381760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592F29B03EC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DBF71C22595
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8951B6D17;
	Fri, 25 Oct 2024 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RnP+Znk3"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6518B21218B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862607; cv=none; b=H1tXZDFIFHwCFJdvSRPYZFWMdQ7xytvktg5iAmFmzGeKpzJ6Bvb7bHAWD7dgUbSgavcZwIZ1T5fpiD5yjPKz27+Yd1Vq7eUcmcGY6u0IR4AZ/yW7m54LTbCV50xAIlnshT/ho6gNPDmiDYD0NUbCDIn/o0+EH2N5aecYySVK1rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862607; c=relaxed/simple;
	bh=peqexeuw5wHJv6totkmML0VJIDG0DCMQ+5G4N1JjCyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwGnaj187jAzsRsKlV05Wh6vi3HBdMp76J8ycOaxZGAtaCcicrvJMPvYpRiEpnQ0Tvh7ADneHgc/yKSbZVhis+lHJ6Ak7/cbIrche2e33UMIodPnSoepQZZ+4YGPYzHdOZPFwupu7NTf/Va0heU0yj+OrA91lWvCjirrEP/+BGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RnP+Znk3; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e390d9ad1dso17930777b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729862604; x=1730467404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RSi07GpJCTtbyn49PZY5VKqw+hphFmZmbrjr6WKqC9o=;
        b=RnP+Znk3kbUHkdVoBQ1sEe1sJ+KwwqNOUVuAO9iiizqOrQuWjjYJTsZhmQNGc88n5c
         1PbEMafMQdfVy4xKY36vvtN5mk1GwZqcg49EmoPVWom+ZAxXAe8EATAlpCCpxwgd08yS
         mIsxQiQwEVsnrrOenG0U7Nh6Z8gfTejPT4cLfDIo63kwyNcGEQtTFep5H4amTssdRm4J
         TmiAksbRylzIrKQD8O0HSqKMTy1tXzqor/wpzj+UeHhl4viQCvJ5o+x0LZNvjkQo7K5I
         YC5wbxdSgtczK8K48S/JOgOj99HbtYcqPreNQbCV8jzOK2i7O73E5CDoeRxJStPLXLaN
         po1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729862604; x=1730467404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RSi07GpJCTtbyn49PZY5VKqw+hphFmZmbrjr6WKqC9o=;
        b=tkye3ILzrsldUgVzBOcd4iR8ROUac8UXheSb7vV6u28nQjZOv9izLaM48OuvlyyZ9o
         ypPMh+K633zFdcIKV2uCmhEvmPX26z2fYUTgWvng0ohUbQOVx3xM1Ya438dQsIDQ5h8Q
         PBPrQW04i3H3yCrxFN/cw7QD4fgU0WvaDYep6PJfqrOdJk8OtiRHN9YL5wO5NZ5p7N75
         XrleVoOSm82i8b6VYAYHfds20h/7kBmvzddtGdP+mhGy5UM+aeVoC/U+d2km7MS2ux9p
         a1DnY5yQutL7TKV2pXmCgktfNAaEq+d3F/b9Gdh7XJ46bBqzSYf8k+kZuxEq1XpwKOjk
         yZjg==
X-Forwarded-Encrypted: i=1; AJvYcCWmRo/nkoGAcNzdsu85ctQvRF7y1RTjP/RMGY6Cjig4N2VqEV8RIXThA0imi7jlIrbhE8sMtj23L9jIock=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBz+9MrWosL/UNYfBCHNHJNUBZ0hs5nPmbrT6gezGXY07HsIzj
	1lCNHtqvwSAsPr2IrNXZ/vSPNhofgriIldBUQwqhtH1btlWCisgS08SOiWwnv5/Yp2qcgfMA5bu
	Gd458Lt8LuLMbi4yPQWEDF8nIIHCL7UoLgM2vAQ==
X-Google-Smtp-Source: AGHT+IFnMJBu2OdHwDe03B0G8MXo39DHb96dxUSQUCPRpHdFteV2Ewfi7/O4fZ5SMm83m1s55hqH4aLeqgoc995xDHg=
X-Received: by 2002:a05:690c:660c:b0:6dd:cdd7:ce5a with SMTP id
 00721157ae682-6e7f0e14dc2mr102640547b3.18.1729862604209; Fri, 25 Oct 2024
 06:23:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025060017.1663697-1-benchuanggli@gmail.com>
In-Reply-To: <20241025060017.1663697-1-benchuanggli@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 25 Oct 2024 15:22:48 +0200
Message-ID: <CAPDyKFpb5ZePhXziLH3VbuKKywJZbo8UBF1NM1_dyOWq9oLDng@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-pci-gli: GL9767: Fix low power mode on the
 set clock function
To: Ben Chuang <benchuanggli@gmail.com>
Cc: adrian.hunter@intel.com, victor.shih@genesyslogic.com.tw, 
	greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw, 
	HL.Liu@genesyslogic.com.tw, Lucas.Lai@genesyslogic.com.tw, 
	victorshihgli@gmail.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Georg Gottleuber <ggo@tuxedocomputers.com>
Content-Type: text/plain; charset="UTF-8"

+ Georg

On Fri, 25 Oct 2024 at 08:01, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> On sdhci_gl9767_set_clock(), the vendor header space(VHS) is read-only
> after calling gl9767_disable_ssc_pll() and gl9767_set_ssc_pll_205mhz().
> So the low power negotiation mode cannot be enabled again.
> Introduce gl9767_set_low_power_negotiation() function to fix it.
>
> The explanation process is as below.
>
> static void sdhci_gl9767_set_clock()
> {
>         ...
>         gl9767_vhs_write();
>         ...
>         value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
>         pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value); <--- (a)
>
>         gl9767_disable_ssc_pll(); <--- (b)
>         sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
>
>         if (clock == 0)
>                 return;  <-- (I)
>
>         ...
>         if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
>                 ...
>                 gl9767_set_ssc_pll_205mhz(); <--- (c)
>         }
>         ...
>         value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
>         pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value); <-- (II)
>         gl9767_vhs_read();
> }
>
> (a) disable low power negotiation mode. When return on (I), the low power
> mode is disabled.  After (b) and (c), VHS is read-only, the low power mode
> cannot be enabled on (II).
>
> Fixes: d2754355512e ("mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz and enable SSC for GL9767")

Is this the same problem as being reported in
https://lore.kernel.org/all/41c1c88a-b2c9-4c05-863a-467785027f49@tuxedocomputers.com/

?

> Signed-off-by: Ben Chuang <benchuanggli@gmail.com>

Not sure the above SoB makes sense. The below is perfectly sufficient, right?

> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 35 +++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 0f81586a19df..22a927ce2c88 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -892,28 +892,40 @@ static void gl9767_disable_ssc_pll(struct pci_dev *pdev)
>         gl9767_vhs_read(pdev);
>  }
>
> +static void gl9767_set_low_power_negotiation(struct pci_dev *pdev, bool enable)
> +{
> +       u32 value;
> +
> +       gl9767_vhs_write(pdev);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> +       if (enable)
> +               value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> +       else
> +               value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> +       pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> +
> +       gl9767_vhs_read(pdev);
> +}
> +
>  static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>         struct sdhci_pci_slot *slot = sdhci_priv(host);
>         struct mmc_ios *ios = &host->mmc->ios;
>         struct pci_dev *pdev;
> -       u32 value;
>         u16 clk;
>
>         pdev = slot->chip->pdev;
>         host->mmc->actual_clock = 0;
>
> -       gl9767_vhs_write(pdev);
> -
> -       pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> -       value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> -       pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> -
> +       gl9767_set_low_power_negotiation(pdev, false);
>         gl9767_disable_ssc_pll(pdev);
>         sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
>
> -       if (clock == 0)
> +       if (clock == 0) {
> +               gl9767_set_low_power_negotiation(pdev, true);
>                 return;
> +       }
>
>         clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
>         if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
> @@ -922,12 +934,7 @@ static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
>         }
>
>         sdhci_enable_clk(host, clk);
> -
> -       pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
> -       value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> -       pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
> -
> -       gl9767_vhs_read(pdev);
> +       gl9767_set_low_power_negotiation(pdev, true);
>  }
>
>  static void gli_set_9767(struct sdhci_host *host)
> --
> 2.47.0
>

