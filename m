Return-Path: <linux-kernel+bounces-200499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABF78FB0DD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF032833A2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948CB1459EC;
	Tue,  4 Jun 2024 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L8ErJXtm"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A468146006
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499665; cv=none; b=RgP3bFkom+hGiSgkA2qh54weKgQO0iU2OQrlOcmCaTqZ1pNDn/euCjlH7iuT09f7fksSl83UD4GzyIbAHoT7z/8TuFvxJ5HdWjIx4Pu7G5s4pg4kNeGzJI9/pHSpHg24y3yGX9DQ973Z/kSg9HovJ02UrTVLeRrrKLtUPokeo44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499665; c=relaxed/simple;
	bh=8x1HdwF7lm+0XQBbxfRRHEcS3NdGYDmeY4IfWWJhKmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUwK4QTc+E6168oIQHaK9ZdX5wsEOluJXq8PW0NwuWDd2/LzPkaK+I3gndWWrch1wkrhj3yMTTawH2XAVFwvcvNBt9ySPuBbjbhUXmzeW14Wwr7DGc+6NjOvbXKTjeBGaVo+uelcvyBzPu+DJ9vxN3yDYGFNE4Tbxm1S94VtcXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L8ErJXtm; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dfa65af5367so5055356276.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 04:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717499663; x=1718104463; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eq/HBqCgJ9qMRdIfKiqytQyj6xuMx2f9KN0gcUKcbJM=;
        b=L8ErJXtmEE2WvNIVwgoyzEo/wH/g+tbUdpd6r0uhW9HMX9ju6/ZXs1HUJUuX0QE3bm
         H5WqUZwVcaFBSXtaLj0n1dX28Uy+OMTilHd3wLAubmO8K1aBXyORPtHzRE3odMo2lI9a
         qVBKQ7k2KVtJpX7u2QVahqlPr3M5juWvfFq0aBGqYNzpE6omwylyG1MVenWVtSg8nCCP
         80BzUtnxwIOejo0L6rgoOKBqrm7ZGLq44HWswTTxELQRhY5qqb+ht9DvSoIitS2uoDzB
         P3KUwfNYH2XKf9yeswk/3B/jfTJvQPmvpKnjaXb4ZNWV8nct5CyGzmccynhVf2QWaWSz
         trfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717499663; x=1718104463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eq/HBqCgJ9qMRdIfKiqytQyj6xuMx2f9KN0gcUKcbJM=;
        b=K7ax001/hgTZxO7k/n1FlYPA1FeVOjb8AJ7gDhw26lZ20V7QMwpCgXiDXuYwWhILRg
         mSKk6RH/hXA/P9mPGE4qIDdl2CV8h8MaWAMHxSPx2l+swOdYaR0tc9UhL2fDYXDrefvU
         8OgTWMhU2kNu65Fg+16jfLyPLdwoApUXdy6ZVnXjkgcdOmdl134jqiZKTzBdvDLNHPgB
         GhT3kY3Mupj8snpFBJSRDg8PPodIiDaqSf7p0i4SBktoLCJinREDO8BGlE1lBL0gXi0N
         aSOFkBob0yXIloB55hwIgKKn6fChml/P3oyrUeS3uPbNkQ6dbB8fuov15+/vgTa3WWIb
         94Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVDe4nBHfjTf6Jb1L/LZ+HkN2ZdOE6EVhuT+d3Yqpk/SHyhgwYrG6bM57Yk4ZKMabS/OF0HZ34y5Hy3C4mchDX5KYBBy1R1MEIVh471
X-Gm-Message-State: AOJu0Yx1D+pPwgMLSsfNrC7bopBwl+YyVUDfL/UI8u+3gWFMqeJoeYqB
	LOkj2Oa+tYLKlBJ/3TkNBqJBhINBOVtZIYLGCrRaOLkmu4PLVpoUkFd85iqXF4Ufgd1GX08YLNY
	NotHeQVEQk5wF3LhQvvDNtP2P06cpbmWMXfrXgw==
X-Google-Smtp-Source: AGHT+IHnH3LEJPAZmIpQIaepZMJj/R7GrQgTTuSPsTt7P5EJQI8pQUPXtqblajPZ78RjjZhiUbK9MzR/x9xrz3DwFdo=
X-Received: by 2002:a25:dbc4:0:b0:de6:1645:499a with SMTP id
 3f1490d57ef6-dfa73c24476mr11467680276.30.1717499663432; Tue, 04 Jun 2024
 04:14:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530215547.2192457-1-heiko@sntech.de>
In-Reply-To: <20240530215547.2192457-1-heiko@sntech.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Jun 2024 13:13:47 +0200
Message-ID: <CAPDyKFp3hPJ02W8O0T1RjcNYor3HCK9VTjOHmjPKoP7YJ+1-jw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: set CQE irq-handler for rockchip variants
To: Heiko Stuebner <heiko@sntech.de>
Cc: adrian.hunter@intel.com, serghox@gmail.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quentin.schulz@cherry.de, 
	Heiko Stuebner <heiko.stuebner@cherry.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 May 2024 at 23:55, Heiko Stuebner <heiko@sntech.de> wrote:
>
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>
> The dwcmshc used on Rockchip rk3568 and rk3588 can use cqe, so set
> the needed irq handler.
>
> Tested on a rk3588-tiger SoM with dd, hdparm and fio. fio performance
> does increase slightly from
>
> Run status group 0 (all jobs):
>    READ: bw=209MiB/s (219MB/s), 209MiB/s-209MiB/s (219MB/s-219MB/s), io=4096MiB (4295MB), run=19607-19607msec
>
> without CQE to
>
> Run status group 0 (all jobs):
>    READ: bw=215MiB/s (225MB/s), 215MiB/s-215MiB/s (225MB/s-225MB/s), io=4096MiB (4295MB), run=19062-19062msec
>
> with CQE enabled.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 4410d4523728d..3c203857189f9 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -908,6 +908,7 @@ static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
>         .get_max_clock          = rk35xx_get_max_clock,
>         .reset                  = rk35xx_sdhci_reset,
>         .adma_write_desc        = dwcmshc_adma_write_desc,
> +       .irq                    = dwcmshc_cqe_irq_handler,
>  };
>
>  static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
> --
> 2.39.2
>

