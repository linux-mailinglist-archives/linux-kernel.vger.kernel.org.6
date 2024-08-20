Return-Path: <linux-kernel+bounces-293862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B75FB9585E5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378381F242D6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF68B18E04E;
	Tue, 20 Aug 2024 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rsPjizOU"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB6918C91C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724153650; cv=none; b=HmAIs+9BTD0PX5DgvkK3RP3/tdnRav2f7xY1XBdBOsjRCdBI5YZjIij8GKIU+jto6Q0KenALuU7cnMk7tZVwWBJgkWR9IU/zIupeDVnscOpu4MZnXdPhNau/d5CmlbwVQWK88ARq2qRJgEuq01b4X+peI+2BTsxRMyWRFKA0Ug4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724153650; c=relaxed/simple;
	bh=V8yPuizcIylxeDCeOzPGi07mQj2+6phX/qbJUs3DZfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVggTa/y0zbp/u2gxYrqAgF0Ek0SuULhMC0dnaAJHEyWJgR2RzqprlTrNG0wk2XAVZxBz9xPKgCzxzIQ5sZewW+wcyj+8b5Ze6r/uhV/vfYmwQ6aKuqDUhWiAvM3/jPu0sD2prlcYiUhg1qyNupP7aQiQo+NKpXHa2+AHTu6j6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rsPjizOU; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e1161ee54f7so5443590276.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 04:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724153647; x=1724758447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tfzk9n1IikXnAiqdG2H8JF5Wb4UFD6B8FqPf43l4vMQ=;
        b=rsPjizOU8V0sK7xcG380IBpDZaD+0Xk9tYLz3PrhdZbO0vO/iyTmRkcBd5NDPAdjiN
         DJpeRNHryZ1Xq/ernYzYtT39KJFEUMs+z9VXGp1SaC6nX1wEoXm10QpHwED+EyfK/bED
         qt/si6uiH2TwWc9v0idtmjq5uPyfbxAFtxMIKwxbddcF+3KXI0NGbn0nVMLG+RMopLgT
         Vaj3yIsOpaK/5k2FFNBct8ne6qAym7xmtpvpOVsMHj5Y3uz+3I36aWcs13dQ6VW2XeRX
         rSlPHY9QAm8JjMdI38ZOA6J53qo6J0CY+nvmdUYg0b7/fKKeSCDl/OOxH6uaHVbCwb0P
         lSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724153647; x=1724758447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tfzk9n1IikXnAiqdG2H8JF5Wb4UFD6B8FqPf43l4vMQ=;
        b=Sj3vMgckQZHfKL/pxoevAESZqvhm6Es5ztjpbw8GMNSYe0f2E0hXhe9+LWUpySX99d
         JmXLwuTmJQ8hdwoAC2fZQ02QkaugC8w3gV++1fpB44OCu7ugx7Gs4xl0yT71LMYl9DB8
         SXHd0yDXmrCwTAxOeWlayrKdRajT3oqF5IJrWpbjrfSy7MSNq9nZLBedoyD+FYDZQ/oD
         bZXY6ld8pdzOpzb6I2oBBlqC5QwT7p0V6Ygd/gR3PdYsxlFasadPkgBYhQfdNPPpfRS4
         8KooPidK6FkwwZqZXOrdCug1L2HYwwqLJ6LlBs8eEne7mTm4PNhSwuEEh1StQCxEeROT
         aU6A==
X-Forwarded-Encrypted: i=1; AJvYcCX8bVCSbO4EzQYoqVlB5t8+5UmetxeVE0/v2NAP+4O3R6UsIQJMNhJCSE5BklaWhPMjfXYtXEd7J/XioMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4hSVM8/r4N1BngaW33nmF9JI6NttYjyXGFVr05H88U4Wz4bSS
	SkFwT2D5Oe/iqt1zW7X4+Tci1elo83GcciAOYJCd0Y51OKIcf+NEV1/2dlZtJz9wvnG46cNmwyi
	LaNcrmBvBEsuR2ZC0G1GYF3BDUb+RerVGmMmQyg==
X-Google-Smtp-Source: AGHT+IHkfw0AJu8RuBQC2kePHD2sJITUraJr5xbXPvkPjc37kfnNc0eDyFECKEmVdGoyjdSG8ua0Yxk2HpjOA8QIHzg=
X-Received: by 2002:a05:6902:2b13:b0:e0e:8319:c6e4 with SMTP id
 3f1490d57ef6-e1180e9967fmr15935198276.8.1724153647422; Tue, 20 Aug 2024
 04:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815201542.421653-1-jm@ti.com> <20240815201542.421653-3-jm@ti.com>
In-Reply-To: <20240815201542.421653-3-jm@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Aug 2024 13:33:31 +0200
Message-ID: <CAPDyKFpb0o2w9=nRp98XnqoLKtFOCDssJzy+53mg1bW8y0UmUw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci_am654: Add tuning debug prints
To: Judith Mendez <jm@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Aug 2024 at 22:15, Judith Mendez <jm@ti.com> wrote:
>
> Add debug prints to tuning algorithm for debugging.
>
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  drivers/mmc/host/sdhci_am654.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index c3d485bd4d553..a909f8de0eabe 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -457,11 +457,13 @@ static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
>
>         if (!num_fails) {
>                 /* Retry tuning */
> +               dev_err(dev, "No failing region found, retry tuning\n");

A dev_err seems to be too heavy, but I am not sure at what frequency
this could occur?

Why isn't a dev_dbg sufficient?

>                 return -1;
>         }
>
>         if (fail_window->length == ITAPDLY_LENGTH) {
>                 /* Retry tuning */
> +               dev_err(dev, "No passing ITAPDLY, retry tuning\n");

Ditto.

>                 return -1;
>         }
>
> @@ -505,6 +507,7 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>         struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>         unsigned char timing = host->mmc->ios.timing;
>         struct window fail_window[ITAPDLY_LENGTH];
> +       struct device *dev = mmc_dev(host->mmc);
>         u8 curr_pass, itap;
>         u8 fail_index = 0;
>         u8 prev_pass = 1;
> @@ -542,12 +545,14 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>
>         if (ret >= 0) {
>                 itap = ret;
> +               dev_dbg(dev, "Final ITAPDLY=%d\n", itap);
>                 sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
>         } else {
>                 if (sdhci_am654->tuning_loop < RETRY_TUNING_MAX) {
>                         sdhci_am654->tuning_loop++;
>                         sdhci_am654_platform_execute_tuning(host, opcode);
>                 } else {
> +                       dev_err(dev, "Failed to find ITAPDLY, fail tuning\n");

The commit message only talks about debug messages, but this is an
error message. Perhaps update the commit message a bit?

>                         return -1;
>                 }
>         }
> --
> 2.46.0
>

Kind regards
Uffe

