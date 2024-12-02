Return-Path: <linux-kernel+bounces-427875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F8F9E06F5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D02283566
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110D4209699;
	Mon,  2 Dec 2024 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="URPKnzxz"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA74920897A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153055; cv=none; b=F8ELFm10ajC9fwT4iLyN/eVoLnqCAGzynCOTBlhjaeKVqzvxCOdyETZ3sgmSxKqlUidwJePH3PzWAUAcgMJaU9Ft/78AallwnFaJSMxJT8yO3OD8VoWxE1D/88sEB0hkx/Odr9PpMqjLGozUiXecndw8EOf0KebWZofWxSRQPMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153055; c=relaxed/simple;
	bh=GT/7Ze1ICZzO91X+fJzIIryCuvOoEcn09j4ZdKtLo6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MlkXge0VkgrcHiEmibOvOjcuXlMmr4xCU9vXQ+ytXc6Wctgg96ZPkiANuoRLKqXA0hU/JTURPSDV2rOiPY/F78k7rzWUiomOKWhPa8O0tnXJi/KdNem4gTE4qZCWKpUz2SX1uV8tbzTEKtBZjxRmr8B8tvsd5D3W7o4zs4mlVsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=URPKnzxz; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e396e33d47dso3815821276.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733153053; x=1733757853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m76+jzfpV1Gl7IDVGFQkptedm6l1QHBc35AI5nAO280=;
        b=URPKnzxzvYoI9ybhzsWZwVzc3sQib1Kf/2TWh+EvBAJ2eCmxCfi+VGggKbP7QX0Pnl
         gBRZHTUe2agFetZFdYg1ZGMd5Hb16QFGmRygKH6h8wwKu0UYplSpnJe8J3tv5I1jZRY5
         PngGCeFtm2Geo3mzxVDjBX6RfXd5/hUG3bM/xasjIx1luQTEFVnQPEzlHMtCVCluNAN8
         OSngWCxmilD0WR1V5Pu5kh9n4GoGV8hUCfPOU6cnnw5kCC0ysOyRUHiWp9VcM/p0IDEA
         cJFgIr13ouQd6/afFwCBWzkjp51FlplKybl9TKJnG2xF+X5l77+2EaOS3FmS2XT5k/Dx
         PCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153053; x=1733757853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m76+jzfpV1Gl7IDVGFQkptedm6l1QHBc35AI5nAO280=;
        b=J+gezn9ptiSueDnjJn7ubUtabvZC5wO8IAAYzqTE2xiRN5FQAcDH78ONmNj3AgSLqI
         MbhJbrOG9W2XKgzl/5j+slxItzH3aFK1m1QMX9DpC1TiZOAkT42wwVFbWTU66AVnj3T0
         Qc3bnAaCNr4FCrVd7R8GSTYR/++ubC32YfHpbdUkoAB3pYKhFTIuihvxTfpJlgnrb9BY
         VGfrduRSUsfewOHaDSoQ/hwhjSnjNefrCVU13N/qXFshf6TMcHquAOVSvKkiXtqd/SEr
         bbFuHpd7zV2mkuaBxpTwKqcNo8UGkRlhBxjqAvkhQZRUbB9AirhGUqLFgX4/9t24YXmj
         3ZKg==
X-Forwarded-Encrypted: i=1; AJvYcCXmdmCw1TT00MVvy7j9mtdZ9iLX5/nEdwymFvxqciiiVB0XRd+pXo2Uj6HOy8yBTqbnkidUR5IRsng0G2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA3XBYYCjkUC787y3TfCFP5Ote+97ZdwrfmWJgF+nqLe3va3fW
	b/EHEZ6D4vZGUdheBDoGzl+ctW1v7IQ3TNDb4rD9gO+PWLWyWgIIrEoYfcZxsfrb7wnCzXngoHp
	VtCRmzOavtWrto871reHkFOB40FytEU3wMIQrcg==
X-Gm-Gg: ASbGnct7ZZw2o9NKwCc+B6ndkDPQ6EAseAD0PCZLbTFlDITQJt6MQlGZTIMQMr1XJKK
	8Q0jFpWlqo7g3w7x0Ra8SUYYvIac764lQ
X-Google-Smtp-Source: AGHT+IHH7hIx+e8n6avEfQWiti54KkaNN3HlOI/MmlmrT0lxi9lBcIhv+cnoSDvpFTNHzd+CyUH6RHneSifHab2NRNc=
X-Received: by 2002:a05:6902:1895:b0:e33:20c2:223f with SMTP id
 3f1490d57ef6-e395b869e50mr21994700276.10.1733153052749; Mon, 02 Dec 2024
 07:24:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125122446.18684-1-ulf.hansson@linaro.org>
In-Reply-To: <20241125122446.18684-1-ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 16:23:36 +0100
Message-ID: <CAPDyKFqQaPs1oQ9zgvOSBGLnP=tNe0UdX4B=EPELdY2jFjGRuQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Further prevent card detect during shutdown
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	Anthony Pighin <anthony.pighin@nokia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 13:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Disabling card detect from the host's ->shutdown_pre() callback turned out
> to not be the complete solution. More precisely, beyond the point when the
> mmc_bus->shutdown() has been called, to gracefully power off the card, we
> need to prevent card detect. Otherwise the mmc_rescan work may poll for the
> card with a CMD13, to see if it's still alive, which then will fail and
> hang as the card has already been powered off.
>
> To fix this problem, let's disable mmc_rescan prior to power off the card
> during shutdown.
>
> Reported-by: Anthony Pighin <anthony.pighin@nokia.com>
> Fixes: 66c915d09b94 ("mmc: core: Disable card detect during shutdown")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied for fixes and by adding a Closes tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/bus.c  | 2 ++
>  drivers/mmc/core/core.c | 3 +++
>  2 files changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 9283b28bc69f..1cf64e0952fb 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -149,6 +149,8 @@ static void mmc_bus_shutdown(struct device *dev)
>         if (dev->driver && drv->shutdown)
>                 drv->shutdown(card);
>
> +       __mmc_stop_host(host);
> +
>         if (host->bus_ops->shutdown) {
>                 ret = host->bus_ops->shutdown(host);
>                 if (ret)
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index a499f3c59de5..d996d39c0d6f 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2335,6 +2335,9 @@ void mmc_start_host(struct mmc_host *host)
>
>  void __mmc_stop_host(struct mmc_host *host)
>  {
> +       if (host->rescan_disable)
> +               return;
> +
>         if (host->slot.cd_irq >= 0) {
>                 mmc_gpio_set_cd_wake(host, false);
>                 disable_irq(host->slot.cd_irq);
> --
> 2.43.0
>

