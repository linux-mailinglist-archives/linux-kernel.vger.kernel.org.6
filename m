Return-Path: <linux-kernel+bounces-427876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0359B9E0766
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C142179BF0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA80820A5C7;
	Mon,  2 Dec 2024 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GaUvdVgJ"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDF520897A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153061; cv=none; b=RwMul8Y60oLClMXxSjYU48ChhhIOiOnJoUKaGcXXohzLTn0/k8tXjDlISTnpn9pZ9zPdNl8OUNj1XA3wEklFMqOZgzKqh+lrPG8/8EDA3cOAC5L4BqDt2hLhDTZOhXP3y6Y0umIHJZApkvN1tOm0ptsY6ZC6Br47CaNk05wY9BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153061; c=relaxed/simple;
	bh=s+q08AhHsFGE1EfP39d6m5AmxX15U2YOkkHYuDiep54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ON8UzeIQ1z3vO9qWW3kYEZaRtxMrYSB3j4P8ih/pU+0NoTwu+6tDSh5FjJXLFaIejfG79QMMaQJ+fMfprbTkRNN9EGd/pF7vDR6nYlMpbczsc9gTPfBPNoPThWt1Mq2lvURUWq4GnL6jSUXK2oS19SxF/I0xyiqimfu6BOKs73E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GaUvdVgJ; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e396e33d47dso3815942276.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733153058; x=1733757858; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vZdmxpNfvpO1w4hAAEKWGZSvaKeExVY5BF0241uhp8o=;
        b=GaUvdVgJpVtPmh9fidIX87aQxQIlNacs8Dg4iPNAj8wv7lOdhvlkuqeW37fU60tbsp
         0BFYezw7NiTSWu42tbhjtoL1ENyLJCGa42iGDPUd3bFVeSMv7fYGC5iboAOPtz6/ZthX
         AwJqE8XlxaZ/uRxjAtM/IT3wEgtHy/dUGwPENge/ueb6AAagvCv7o8nN8fkuslHb7E2K
         xUpF5XPsuimcIyPgwPShSnMJPoh2M9tzSqI+NdchUCmIXAkF3xLJR4Qs3cKIRJWxdM0S
         69Wmkkl1sC4gJXc9CpU/ZNk0qbkRh8JLH1QBgqt7MF7nHP3apCmaEv3KAmpk8OvelwKm
         9K3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153058; x=1733757858;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZdmxpNfvpO1w4hAAEKWGZSvaKeExVY5BF0241uhp8o=;
        b=d0v7sYhkncv1FGUvJSL4RpQyL1VNx7zHvvjtBdhm0dfCHvkT8ig4v7dxoqLCgG3YFA
         ZLIH0fMqTg/GMQC/lqCuctRyixCGzeVPzin2XWvuMaJus/9cdUh5weSp1j7QcQvpZFe1
         jg4SJRGItHmFZJE3vF01cg2DDwb1/7/v0H7JyerGXAuVOQgzqvQcGm3ydSi3zr2wXQtj
         1kgn7ZLVg0FLDFscmGpuRgJsActKEgaGCSBu7j/F4gfVPvJXuMpiTu2G4I8eSwJTu3le
         hDQ+H5Fx+vKt4jU9yvxzjMNR1p3fgdItm7W3TCwHg6uA06dWqBLgdIBngeA6wLI8o4zN
         8XaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpybUEeOy0zRZ0MNy9lQ3v/IPnRa37w7npIg5tA3x1P4QNL0DYYa0XvmX2zjJfYoz1C/W/l7pX45bKL7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLlDjSznHxzafdNgPXJ67cDyP3NxBbBebwMk/MTbtKSZ2hgLfY
	lBfIqsifMfixj0GOWZ1MpxzqZxJgH4g+FD1aVJSkzyuYXiBNafWACqV/o3jFlCR3ApNa3FCbWeU
	PFSPE9lNzAbfOAJj68FacJwXTNZWddbKtU5siDg==
X-Gm-Gg: ASbGnctzcvdzjAGCqp1hCFNPJSirSnftCH2kHMjb6Slf/0WMqi/4yMJmkv/VcMnzP2l
	vHwW1V14r2doArmTq2z4v/Mw/WkMsAOT/
X-Google-Smtp-Source: AGHT+IFOFC5zPUF0itgIKsAUHr0BlLtuJZtIXZEze3rfpOri9Ohtmk1VeC2LzJL5dOFw7QQghHYnT6Ig09tgFYZXMYk=
X-Received: by 2002:a05:6902:18c1:b0:e39:8482:5d5f with SMTP id
 3f1490d57ef6-e3984825e68mr13245250276.46.1733153058435; Mon, 02 Dec 2024
 07:24:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125083357.1041949-1-ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20241125083357.1041949-1-ciprianmarian.costea@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 16:23:42 +0100
Message-ID: <CAPDyKFpkSRmGhZ68m7TyQNSqYKa7gnHigKpu4nKOpb-HWfCdeA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: enable 'SDHCI_QUIRK_NO_LED' quirk
 for S32G
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Haibo Chen <haibo.chen@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, imx@lists.linux.dev, 
	linux-mmc@vger.kernel.org, s32@nxp.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Christophe Lizzi <clizzi@redhat.com>, 
	Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 09:34, Ciprian Costea
<ciprianmarian.costea@oss.nxp.com> wrote:
>
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>
> Enable 'SDHCI_QUIRK_NO_LED' quirk for S32G2/S32G3 SoCs.
> S32G SDHCI controller does not have a LED signal line.
>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index d55d045ef236..e23177ea9d91 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -304,6 +304,7 @@ static struct esdhc_soc_data usdhc_s32g2_data = {
>                         | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>                         | ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
>                         | ESDHC_FLAG_SKIP_ERR004536 | ESDHC_FLAG_SKIP_CD_WAKE,
> +       .quirks = SDHCI_QUIRK_NO_LED,
>  };
>
>  static struct esdhc_soc_data usdhc_imx7ulp_data = {
> --
> 2.45.2
>

