Return-Path: <linux-kernel+bounces-376156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B689AA0F3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659D81C22078
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC71019C57E;
	Tue, 22 Oct 2024 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dDQ9iWCT"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC67199FD7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595695; cv=none; b=YB4MEOuqIybObrCVV8vPoEYmsbAXplnRKeJug7AhQy5cFLOSqe6DFTJCWyJiLgjl97ecMcZw3MtVLsBgLyi3HxWmXoiP2rcnnKn0IhWS8EKGVYWLoyRhrtYD9VStHzIxbIr/h3zCPI3vgXIv7xFIuXA9sl+ozdvx3KYBiEjHMTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595695; c=relaxed/simple;
	bh=ZYBOM0Jau2KE+DeEZtdtpLKVsuWrpJoV7dldPsJ+eJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1KlyU/ogkTW6oygYmNxyN/qA6N0Xi4Amen86ZnPhhe0UBqZwOD2DsoPOqlj3ECsBrpcpfUSn7iHEAUYkIxuhlSZBBhNzDx3PHI/r2ufnV0/VWwxW55FFalFFmA04S2tof09IzQfLcoDimg78bLgl1ZO+xAsrDn36zAi8nn/IRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dDQ9iWCT; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e28fd8cdfb8so5118257276.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 04:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729595692; x=1730200492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GictTW47NVZdcyH3FJJptxbRgTusXnwflsx0uPHCDvU=;
        b=dDQ9iWCTggCSkTc3ZNJ5++FB5Be4o+PRjxjmM9r+ofGaUOe+AolVfKGM+xKjQmjWT/
         lHsHpPCzAMvNPi7wgvfE4SzaP5sj/wVWRGaWXKzkLj8MPYq19m/n3ayIHwY2B5VhvCEq
         V63ri2p8ZBiKgJnFvWxi6pqFD0AuLZIdFu8PdVbFxpf+bcHZBJGF2nhlc43ErKVimQUT
         /7OHg+Ro1L63alwYtFjFYuln5t1+aVI629kf5iPeAF4/rsMGI++kES9MXadTWDC1/c3m
         1E7CLwmn5R5dA/qvbejWveyCgRaMlkwsBlrXtjkc5GKMzE/tHMsyJvYkt5HLoNCT/Wnu
         tlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729595692; x=1730200492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GictTW47NVZdcyH3FJJptxbRgTusXnwflsx0uPHCDvU=;
        b=vLTw4btaCxRbaFfSgSTWFIAeYd/Whb4g3Az706mvwiPQD/OzJEp5RPczv4InXOzGSX
         E+Y3WdNnbLQwZcMh1/tKUA7B50p49dWuBKJ1SdSVEaEo2q+l03zo9b8+aUDO9lANzsAY
         7A1CBmQVqVCfy1rWBEof9MvZtVOksE48KB8ULQMnAm60NJb/HStaLhMBQ+VTvYIKSam0
         rp01fL2ehDPognfuBIE7DEKG2s10W8tPloy6xbIEsz3nkzZHdeFDThVHbGk2Y1o2dCNy
         Cpexvo7I+T6/LQkKgf32FKiCIubvhIwsLNXsxa7wvGMbAGbH733OKoKdn2vOectpVddN
         mRKw==
X-Forwarded-Encrypted: i=1; AJvYcCWa+n7j/8fvkWbfsvDsUD6cPS+vzGJVm5cwUGg7FOjJvXEh54sUh49p0f+YAcphsbTH0zeL4ExYrpT4PjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZDFXCBKrupGY/XN2/d118JTjmRe9S1pgHhW+pp7/vE1AMWW12
	ARbm7l9OZy8/NhFPfTIvprpgcgFw5vkWLAvoJPGiWElir6KwLoIe6zW2gaiyISu3eiBf6qKBJ04
	m5iVPFd/MiUd2zjlBQY9IA9CGrXEQzVd7ucxHMQ==
X-Google-Smtp-Source: AGHT+IH9MD5E5lYj8E/oQc+5K6zST27pAY+/VTNfDX0GfVv9ZMy+u3+C60NydhtrbgFJRydQX/YUX9VDVGRxCtC6cP0=
X-Received: by 2002:a05:6902:1141:b0:e25:cdc2:ed93 with SMTP id
 3f1490d57ef6-e2bb1442cf0mr12189028276.30.1729595692446; Tue, 22 Oct 2024
 04:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022-8250-omap-no-console-suspend-v2-1-cc3d102b8a1e@bootlin.com>
In-Reply-To: <20241022-8250-omap-no-console-suspend-v2-1-cc3d102b8a1e@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 22 Oct 2024 13:14:16 +0200
Message-ID: <CAPDyKFonEKezL2xpTCsW8aH=kvxDX67w+3FNUwukvjp4tKfjcQ@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: ti-sci: set the GENPD_FLAG_ACTIVE_WAKEUP
 flag for all PM domains
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, tony@atomide.com, khilman@kernel.org, u-kumar1@ti.com, 
	gregory.clement@bootlin.com, thomas.petazzoni@bootlin.com, 
	theo.lebrun@bootlin.com, richard.genoud@bootlin.com, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Oct 2024 at 10:23, Thomas Richard <thomas.richard@bootlin.com> w=
rote:
>
> With this flag, if a device is marked on the wakeup path, the correspondi=
ng
> PM domain is kept powered on.
>
> This commit fixes the no_console_suspend support for some TI platforms
> (tested on J7200). In case of no_console_suspend the serial core marks th=
e
> device on the wakeup path, but without this patch the power domain is
> powered off anyway.
>
> Suggested-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> This is the second version of the series to fix no_console_suspend in the
> 8250_omap driver.
> For this second version, the patch 2/2 "serial: 8250_omap: mark the seria=
l
> as on the wakeup path if no_console_suspend" was removed. No need to mark
> the serial as on the wakeup path from the driver, as it is already done b=
y
> the serial core [1].
>
> Regards,
>
> Thomas
>
> [1] https://elixir.bootlin.com/linux/v6.12-rc3/source/drivers/tty/serial/=
serial_core.c#L2407
> ---
> Changes in v2:
> - remove patch 2/2 "serial: 8250_omap: mark the serial as on the wakeup
>   path if no_console_suspend"
> - Link to v1: https://lore.kernel.org/r/20241008-8250-omap-no-console-sus=
pend-v1-0-e7f0365c02f0@bootlin.com
> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/t=
i/ti_sci_pm_domains.c
> index 1510d5ddae3d..38448b4a035a 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -186,6 +186,7 @@ static int ti_sci_pm_domain_probe(struct platform_dev=
ice *pdev)
>
>                                 pd->pd.power_off =3D ti_sci_pd_power_off;
>                                 pd->pd.power_on =3D ti_sci_pd_power_on;
> +                               pd->pd.flags |=3D GENPD_FLAG_ACTIVE_WAKEU=
P;
>                                 pd->idx =3D args.args[0];
>                                 pd->parent =3D pd_provider;
>
>
> ---
> base-commit: eec50dadcc91583e08dcabdf83147f6538831b5f
> change-id: 20240819-8250-omap-no-console-suspend-1073308d3714
>
> Best regards,
> --
> Thomas Richard <thomas.richard@bootlin.com>
>

