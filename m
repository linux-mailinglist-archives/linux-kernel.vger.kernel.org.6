Return-Path: <linux-kernel+bounces-200496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2DD8FB0D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12A90B21EED
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A062145B08;
	Tue,  4 Jun 2024 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ThQEnG2K"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C9D145A1E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499659; cv=none; b=L+6fn+AhMJFRmur1HdGpDp0auJvElVh1AB/VapW8Yb9fctbx7bLVCyU6rK17z4cb4IrGXGadr923DWDRjBrNfiBhPHzlR+3CHJjxj1oldkFlvcTUgf3A3KzucOjulxwqQ2ne3je8JV1OzzFAWH3BszIxsd0SpJpqQnF9H27xNtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499659; c=relaxed/simple;
	bh=z+WsJHNaskJCg4/9AjFqG4HscAEnbI/YRzybRuPv8ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejp3gCaVCZwg8h4Kv3SscjqttPjGTWo/+Ss6dHWsAVnl3cZPShcDWDGWH5ssk8i8+uIL0Ru9/yJTX4WwDVkHyRDoKMlG7av0HiPDkhAX0Arm4DIC+gfT82dRUVPQdNCTNwHA9RWbkaQNHbcv8PSt8nW2Zca1AzhjI1MDx2GbDkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ThQEnG2K; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-df771b6cf71so937218276.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 04:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717499657; x=1718104457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SHisJ7CCxndoN5Fdc6xcJmlIiLgKfMyPUBkvpRmDi4=;
        b=ThQEnG2K2geXfZC2nCFr9Z7sKRzMbk+z37SEp/0vfwXG/xu14Cf19ekeFVC+YwoEzp
         eg8RfIMAUDpkq6GO9hu+dkLxjPfAXQ5vj2wq7NQJogpTnFx3X1xGDAiwIwBIpB9/UOx/
         GASAUpy7H5sRZ2R7fBc0nPAQJr4pW6SzEBIG5KjrDniqOl4cyMOAjlJJvYIlML3vsGbM
         vGwvi4rHhWgAtQl1SIj1j3o1AJx5acjWj1fYQGRB1vz0PNzocbpsJ01isI+aZ71dmW2L
         9wsAgekPmufCI4cK9mdy+VZRYuVDxTIJAJtwcpJfOZVm85FbHlomM487O5XdA51bNdZ1
         MJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717499657; x=1718104457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SHisJ7CCxndoN5Fdc6xcJmlIiLgKfMyPUBkvpRmDi4=;
        b=t+MdzUs2i+V/B4OW66UhogOtq9RGUL68KrxDWtpYF43wuHL05O1MVz7MJmSkICDoNR
         NXa1AVw/rOSt2Moow3ULgn4qbiMs2w42+a6HwOQiDiFkDKP97uChmw0NOeGPOOm37aDZ
         Pw0kETvOfXFBgmphXKRmbb4F+gUH8jct5788RVuAFIvWg240AylF+pDwSiluN2gHyoel
         k+jvAs/rmKfKxkFqOxCUwcpNeLSoC0bm+hV58WMKMm+AaQgaxorX1e1mYcGfg3bvTRuf
         yKU1T+bAFyFs9HiRjdsX6t7GPpHqI4xN87+6W8Etgq1KkueOhdZHOypGTdEW0GFcFiis
         1P7w==
X-Forwarded-Encrypted: i=1; AJvYcCVl6XdrW2xR9oLTi6tbMPTBtAs7wEgCUIL2Z+BGPJ/ZOrQPRcT9ShkEi8cKSxbkJEfPXGjjCgRy7mTgoceYfVG53NqirF6mC+acqv1Z
X-Gm-Message-State: AOJu0YyyP99MQQ0xjxpLPZrBrBOZBJfrSuLd+/cC4tJPbQu2CEwCXyht
	HFa7hdWH/+BRJnKLnOPP98Yld+XaRIZRf6aPYgn3Kg/xCPzmBw29skOqw+MJkP09RsgwPbF/lJa
	uGzXUXtjp4YxjqBNUm8IZK1uKpxB1YjaGiYa2ig==
X-Google-Smtp-Source: AGHT+IF7rrqUCsphi5Ci9q0e6oLnlkzOlW/Q14Bh38ZpEZKYw+rO8lP8vt/6KfbzoLfuy1ZokVqzPQbe8IoatP8LzPY=
X-Received: by 2002:a25:74d2:0:b0:deb:c07d:7f5d with SMTP id
 3f1490d57ef6-dfa73bce75fmr12031361276.11.1717499656884; Tue, 04 Jun 2024
 04:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527132443.14038-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20240527132443.14038-1-ilpo.jarvinen@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Jun 2024 13:13:41 +0200
Message-ID: <CAPDyKFpqBMV9SS=1GE2JPR4O-ZzjEY+R41AiOtJrWafib8SuFQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-pci: Convert PCIBIOS_* return codes to errnos
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Fengguang Wu <fengguang.wu@intel.com>, 
	Pierre Ossman <drzeus@drzeus.cx>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 27 May 2024 at 15:24, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> jmicron_pmos() and sdhci_pci_probe() use pci_{read,write}_config_byte()
> that return PCIBIOS_* codes. The return code is then returned as is by
> jmicron_probe() and sdhci_pci_probe(). Similarly, the return code is
> also returned as is from jmicron_resume(). Both probe and resume
> functions should return normal errnos.
>
> Convert PCIBIOS_* returns code using pcibios_err_to_errno() into normal
> errno before returning them the fix these issues.
>
> Fixes: 7582041ff3d4 ("mmc: sdhci-pci: fix simple_return.cocci warnings")
> Fixes: 45211e215984 ("sdhci: toggle JMicron PMOS setting")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-p=
ci-core.c
> index ef89ec382bfe..23e6ba70144c 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1326,7 +1326,7 @@ static int jmicron_pmos(struct sdhci_pci_chip *chip=
, int on)
>
>         ret =3D pci_read_config_byte(chip->pdev, 0xAE, &scratch);
>         if (ret)
> -               return ret;
> +               goto fail;
>
>         /*
>          * Turn PMOS on [bit 0], set over current detection to 2.4 V
> @@ -1337,7 +1337,10 @@ static int jmicron_pmos(struct sdhci_pci_chip *chi=
p, int on)
>         else
>                 scratch &=3D ~0x47;
>
> -       return pci_write_config_byte(chip->pdev, 0xAE, scratch);
> +       ret =3D pci_write_config_byte(chip->pdev, 0xAE, scratch);
> +
> +fail:
> +       return pcibios_err_to_errno(ret);
>  }
>
>  static int jmicron_probe(struct sdhci_pci_chip *chip)
> @@ -2202,7 +2205,7 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
>
>         ret =3D pci_read_config_byte(pdev, PCI_SLOT_INFO, &slots);
>         if (ret)
> -               return ret;
> +               return pcibios_err_to_errno(ret);
>
>         slots =3D PCI_SLOT_INFO_SLOTS(slots) + 1;
>         dev_dbg(&pdev->dev, "found %d slot(s)\n", slots);
> @@ -2211,7 +2214,7 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
>
>         ret =3D pci_read_config_byte(pdev, PCI_SLOT_INFO, &first_bar);
>         if (ret)
> -               return ret;
> +               return pcibios_err_to_errno(ret);
>
>         first_bar &=3D PCI_SLOT_INFO_FIRST_BAR_MASK;
>
> --
> 2.39.2
>

