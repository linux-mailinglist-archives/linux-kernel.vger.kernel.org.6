Return-Path: <linux-kernel+bounces-355421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF3199525D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC2B7B2BC3A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0DD1E0E14;
	Tue,  8 Oct 2024 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TA2r+SPE"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A921E009F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398220; cv=none; b=f3ZaulUgRvRYLkuMrGwEbbpLR0FgXwEjng2GbIDJwlfNPhYonwY7fr9AR7130eLYga9m5IxJG7hm3ILSIII//Xpl+e5eIeGoh9HSRpZ1rSEzSODVBJJpOU/j6/xnVLQ6Ro/FpY6mkTO3DcIS3SSHjQz63FUCWkUzsQKTg+WUCas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398220; c=relaxed/simple;
	bh=CPocK4RH+zkoIYnYsGTjSXpSwgwC92fpnPq4QTghNoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RF2T5JXH+puSgBwgKbAolWMcpwunr7e7Pl1z9K1GdFpeZJ8ix/vTmtG17t+JkR4Ilr7vF1QBsddpt4kWyUQDyrD7HiCfAH7MKT4ceGacl2mT9LnkUetXmyAJ6pEfJh8PPwgwZ7X/wq+EwlKrMa2iArbwbYNwfbwzO1TdDJ+1Qk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TA2r+SPE; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso5699243276.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 07:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728398217; x=1729003017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PBSoxMT5tskX0/LB2ay8WM44PpeVC9nB3pgkEySXlaw=;
        b=TA2r+SPEkOhjxVP0YP8F7+rUATCA4wSD28O03/lB3qqoY3nWf5g4oYwNmJH+4Qdm2F
         g5DLNzcBB0q/mtmJ0fQxxz8ZfIFKna3lom3MGQxZWskH39UIvnTcqVuDnt79w0OzX1bk
         hkVLu8lTl5jh8atAE8JItSirlMmj+QASGiJ/G5lPFMCdgPvRAG3Pc8Vi2TKW+rTus39W
         RDxrcSUjJmPoW1BHM08XwrQn6uKBhJbZpU7KNKfFicwDzCdIP/ge2Qz4XLkHZeVMtHtq
         BhKeCEzBedL8U14dAFODh0MV5UL4tlenV3WEQIG6IF/6gRhFJ4i4pu0WZQomisBh7oh5
         kjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398217; x=1729003017;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBSoxMT5tskX0/LB2ay8WM44PpeVC9nB3pgkEySXlaw=;
        b=nXNmbZKCZQXbrG54CmsEUE/ibaizRbaOPvmNjSNW/5fU4mdbraMWA6q6s05QzhJa2/
         bekGtmiNKLmUYkOYYxqt+KO00Lu3zz6GChpep5aTpo+Dfr+PSRmzbEKFB0wleecv8Tmt
         9UQ+YVG3hEGB01NS/qhbikANaECcVFxTq0ifCw5SJ6d1iU+p8UUorsR+ZWU4QryYErz6
         llv/7ZgJb3sdTdOMKZ0BfG9GA5ER+mLdmpnSbaNn6wZH8h2TJmwZz2solLmEvMA156pa
         yB4MQHxf5PYhAymsKscpdGWRJNT/2cHIwDYc78fq1jHIFBZj291/8l2X+BJ/vGDJxAXN
         lUJw==
X-Forwarded-Encrypted: i=1; AJvYcCVTzfnM6HulKJkpGnw4PYSWCaDDunr55g7ltZw1zBW+Skj/PsL3/CuU6CyDFsUUWWMP6FKayyLhlxixzfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNAtCAQ5Sjc8FymXT1A2Af5b70ZJI9AbeozYGEM2RGrnryOjvH
	R0bJv6fl8tIlqso4LbzXnhjObrvCWemBHvERtXG7xyoi7kPwWJYLviyQVaFPESwFjHUu8Xuhu8D
	QrayEyNfUpYpi7Rm969/DnNnVDzPZXo50EYewHHYwUt9eEPva
X-Google-Smtp-Source: AGHT+IFzbBnNy51zj7k+Fo2Nj2IaHNXAXdErvOkkHLnaGulENXeswH8iJRV3sjjbfod6shRGbeoEHqR2lugOpojlS2c=
X-Received: by 2002:a05:6902:1b8d:b0:e1a:e74a:d910 with SMTP id
 3f1490d57ef6-e28937e2b77mr11060016276.30.1728398217387; Tue, 08 Oct 2024
 07:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007095445.19340-1-alvin.paulp@amd.com>
In-Reply-To: <20241007095445.19340-1-alvin.paulp@amd.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Oct 2024 16:36:20 +0200
Message-ID: <CAPDyKFoTd8VDKnCEuWC9hzL5znJ-7gLH-VKcf=es+zRC38=fVg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-arasan: Support for emmc hardware reset
To: Paul Alvin <alvin.paulp@amd.com>
Cc: michal.simek@amd.com, adrian.hunter@intel.com, git@amd.com, 
	linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 11:54, Paul Alvin <alvin.paulp@amd.com> wrote:
>
> Add hw_reset callback to support emmc hardware reset, this callback get
> called from the mmc core only when "cap-mmc-hw-reset" property is
> defined in the DT.
>
> Signed-off-by: Paul Alvin <alvin.paulp@amd.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes in v2:
> - Updated the CC list
>
>  drivers/mmc/host/sdhci-of-arasan.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 5edd024347bd..0cb05bdec34d 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -76,6 +76,8 @@
>  #define FREQSEL_225M_200M              0x7
>  #define PHY_DLL_TIMEOUT_MS             100
>
> +#define SDHCI_HW_RST_EN                BIT(4)
> +
>  /* Default settings for ZynqMP Clock Phases */
>  #define ZYNQMP_ICLK_PHASE {0, 63, 63, 0, 63,  0,   0, 183, 54,  0, 0}
>  #define ZYNQMP_OCLK_PHASE {0, 72, 60, 0, 60, 72, 135, 48, 72, 135, 0}
> @@ -475,6 +477,21 @@ static void sdhci_arasan_reset(struct sdhci_host *host, u8 mask)
>         }
>  }
>
> +static void sdhci_arasan_hw_reset(struct sdhci_host *host)
> +{
> +       u8 reg;
> +
> +       reg = sdhci_readb(host, SDHCI_POWER_CONTROL);
> +       reg |= SDHCI_HW_RST_EN;
> +       sdhci_writeb(host, reg, SDHCI_POWER_CONTROL);
> +       /* As per eMMC spec, minimum 1us is required but give it 2us for good measure */
> +       usleep_range(2, 5);
> +       reg &= ~SDHCI_HW_RST_EN;
> +       sdhci_writeb(host, reg, SDHCI_POWER_CONTROL);
> +       /* As per eMMC spec, minimum 200us is required but give it 300us for good measure */
> +       usleep_range(300, 500);
> +}
> +
>  static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
>                                        struct mmc_ios *ios)
>  {
> @@ -505,6 +522,7 @@ static const struct sdhci_ops sdhci_arasan_ops = {
>         .reset = sdhci_arasan_reset,
>         .set_uhs_signaling = sdhci_set_uhs_signaling,
>         .set_power = sdhci_set_power_and_bus_voltage,
> +       .hw_reset = sdhci_arasan_hw_reset,
>  };
>
>  static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
> --
> 2.17.1
>

