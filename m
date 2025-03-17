Return-Path: <linux-kernel+bounces-563962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5912A64AEA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C50816FCF8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E695D2356D5;
	Mon, 17 Mar 2025 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gliBOS/1"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0494225A22
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208718; cv=none; b=Jddi4Q460P28JXIgOyH6q/qp/SOfK5iPaVKST3BxWC3tRoKOjRw0/keTFcNZkkwQ6H7FENyfQBhY9nb5dBpj5OVodNivnfvBSq5AV37w1JkBtTM/29y35N7YPp+X/fXuffbsUZ3z/WFfN34gcUVLlewP/MmatrB1SEROFKBhzas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208718; c=relaxed/simple;
	bh=9QI//LPCNtLBsXPXDl5fXPWjOCldy5bw6wjeMAKK2ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFM/osCeju/rRfgrTxJRnYesrZU4qkjumubG2h8uQqmxjram6T1UFxk1N7QtUA10ySh5pHQpve/33Qw395mahJDpfBdwkWKcmWlp+1HgDm2ngnHgejsa46EITdW1yceF8BIkKKw/IvGHyiTALF8iCVJfmXlaSbDZKhkr8Jhcedw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gliBOS/1; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ff4faf858cso18011757b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742208716; x=1742813516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FX4+nDjPa97pvqp6xc2jGfEChrIN3m+xL1+vCvUQBXc=;
        b=gliBOS/1/vdNxgFn7xA7Z4Iint83yZqOICWgKYP8CajW1+nH1PQe2PnXZ2KwAvi0K1
         5pS0UwwCQSalGSe33s14/6gcaCznPr1jS9ge2gxbpspFwHLCOY9wGD0bYZzTdrcLd+Lj
         wv5U1u2Wv92TVt72BPX3/t5713mMofaRW/BRI1luOKT3hKm+wep86xb9dsjAA5NM/FCq
         RBIO+8jM+iwUmv3d4d5Ngh7Uyygw61gIQHaxqCxfyYWtgTgk8x8GpgmcqF84yqc2+weZ
         Om7fPIFOUBrdaK9nifbEqMlqBkjPBQh0jezK2ixg7naLk/ES6Js396FX9kHTfx9XS7xi
         Bgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208716; x=1742813516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FX4+nDjPa97pvqp6xc2jGfEChrIN3m+xL1+vCvUQBXc=;
        b=SeJC8TOCNbryBjvX07CHulKU9enx9xHA0N3vox9l14gQtUEw8ODo0KgO4QOkMTaOy0
         lN6LkaEuTFXPTi/KeiHnySUyU+89RnH2ezNmCOfuy91XY4TijG5R3D0HoHBJMrKFcwRS
         WRIXlJdF2DKmuqE32ayKhYvA7dH1gmhW8i2xoQXd9i5j2B4pnZG3wMKD3sWLdBLtTdbI
         rmqZNx/SMh++FJboNdzuXN90N8X60sdha3mK86zcLxd6mD0wvX56Usjkxrl2x95xe9/z
         +SsLNucscrmnzZSsArHbleGTfjZ8H/CSGfZBgTO3qgmdile+tRSzbK3pPn4drP3IHjxc
         J86A==
X-Forwarded-Encrypted: i=1; AJvYcCXkNPAFp4KkJL4AEsepQ09yw/6isCKKb7vIOJp/YyxFd3VK/IlI+AaBXgS8xP9muasrKaShvoWjjo+jFAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxspVFrP4S6Y3JwoSPzbYlY/t9xYIAeIXk1V0usTRPRMfkUERV
	OfnAoiSk9tbV3WLA+t5RqHy8qQZSEaZ4nHVQSolRVmqDAHpnJHgDnn0hzuOZtkz2bGGB98h0426
	0ybxbwA8vNQZe2Iryl0AckmGto0eX0I122KLwzA==
X-Gm-Gg: ASbGncscyu/2Bf0n8RTdNm3u40pQ6izQf0uNBkPqhP80XKkC6eVCtNNTPqqraVSSOHO
	PEiuZXJvI3bLkklNZqIl1JO6AGDWB721ZIOh7GK0XyMy5Mqi7vqI/1GrnnRDbT8WlC4GR0tbOu+
	NNzQ5q0tgNjYJrivUSSAHqhUq9ClI=
X-Google-Smtp-Source: AGHT+IFZ/UCb9MAufxXsxDOXjmjeGY1kTReIoU2wd9M3G+bvTRZCBrdHJdToart9NFB/Ee7YBzyERYwjT+84mB4ubDo=
X-Received: by 2002:a05:690c:48c4:b0:6f5:4304:fb8 with SMTP id
 00721157ae682-6ff45ef2016mr162355087b3.18.1742208715994; Mon, 17 Mar 2025
 03:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311165946.28190-1-kamal.dasu@broadcom.com>
In-Reply-To: <20250311165946.28190-1-kamal.dasu@broadcom.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 17 Mar 2025 11:51:20 +0100
X-Gm-Features: AQ5f1Jr1xpf9ZmYsy9fSxESDDI1HTBIwGCZnYOTiOa6oMo4jyXPgFf1L5kdmj9g
Message-ID: <CAPDyKFoDh-9L49Yh+Xv10t9Dt_Vyvn7dGCb5dKV0RiNJi5aoZg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Al Cooper <alcooperx@gmail.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Mar 2025 at 17:59, Kamal Dasu <kamal.dasu@broadcom.com> wrote:
>
> cqhci timeouts observed on brcmstb platforms during suspend:
>   ...
>   [  164.832853] mmc0: cqhci: timeout for tag 18
>   ...
>
> Adding cqhci_suspend()/resume() calls to disable cqe
> in sdhci_brcmstb_suspend()/resume() respectively to fix
> CQE timeouts seen on PM suspend.
>
> Fixes: d46ba2d17f90 ("mmc: sdhci-brcmstb: Add support for Command Queuing (CQE)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 0ef4d578ade8..48cdcba0f39c 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -503,8 +503,15 @@ static int sdhci_brcmstb_suspend(struct device *dev)
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +       int ret;
>
>         clk_disable_unprepare(priv->base_clk);
> +       if (host->mmc->caps2 & MMC_CAP2_CQE) {
> +               ret = cqhci_suspend(host->mmc);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         return sdhci_pltfm_suspend(dev);
>  }
>
> @@ -529,6 +536,9 @@ static int sdhci_brcmstb_resume(struct device *dev)
>                         ret = clk_set_rate(priv->base_clk, priv->base_freq_hz);
>         }
>
> +       if (host->mmc->caps2 & MMC_CAP2_CQE)
> +               ret = cqhci_resume(host->mmc);
> +
>         return ret;
>  }
>  #endif
> --
> 2.17.1
>

