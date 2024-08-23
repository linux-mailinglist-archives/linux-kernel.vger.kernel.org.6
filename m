Return-Path: <linux-kernel+bounces-298754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F20AB95CB1C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF26B286459
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD208181337;
	Fri, 23 Aug 2024 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dThpBYkL"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71026381BD
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724410882; cv=none; b=KfVu0fsHhWSQoX6SM4NVVOT0grX6lRSMjK0Y9IhekcZsOKvGAHLuD/TtteE/yPP329llYqhP0VBr8rR3h9r0aXm39VHRoBSQkkVw+SQ/HUDioVHPSS3K64eKxD2epm37TTHVG0Zi1lKpnmULO8DIU7Nfz6z+eP8lqFp8xHizV+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724410882; c=relaxed/simple;
	bh=jCGcYJC3DcdlK/VJvH61PlRhurr+EMpSesr1zeYyMyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLUQo62+7Dax3DtIYilPwHS1kILMckwDVpOGZt38PGLExVsO46nPQvuNRKmS7GWx6xaMhmcBmXDXph/DGOSm1evMZQlOJ/eU2iAoZNIZUG5L16wdFP6xuEzHf4b/SJA06UA6/OxbO09tQf1YsYsc7Wb6XR/i06IzUsFfypR9MIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dThpBYkL; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e1171e57a0dso2327084276.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 04:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724410879; x=1725015679; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Etw9lAfOptH5bhz4rHuyZG/BeS9l3H1TyR0g0f0YHgo=;
        b=dThpBYkLrk15e3uITe6scEzGmQwLja/lXQOY6fECwjIzqgHPeP7+6aLPxkLQhYDcJG
         uflbgPnchpShL8hrmkdc+9DrIwpong3FX6fn4u9vPPFKRA7+YyLkFrSROssJO4zj6W8+
         zIqcsaD+L/VEHLSp2SPPmQUYNosnYQuEFBrXREutHfHXv14nnR1qjV2+cpGNxXHu0kwU
         P1f/V2AQ6ntvgcTMcDWlsLQhL8RRxPdmXPtylBOcc2BlqeLK8G9UY74nTdZXtFYiYpYq
         maHiLoq6AI1KlCKnQRY77p/BwYHKf1Osu9iatm+DtRzWDhxIOhdKZODRk+ycF3rBceJO
         WRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724410879; x=1725015679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Etw9lAfOptH5bhz4rHuyZG/BeS9l3H1TyR0g0f0YHgo=;
        b=RMvpnEIjSzDOpQdPo1n1BkavoDDRlwRJlt/vBL89HD7rJ20MluaDWUz3MT4nk0eN/2
         4Wzfetu2rUkC71kN5jcheYDvz23NxdUQXOdC0aJ6QXj6YJOofhT16v+19b/E1BcKVMcL
         t6FcvZ5vfiUa+f5kfhRdoFNgTj8yzHkXLO61NITAvPFWqhh2ZxnrBGv3HPtqqhuQFfkN
         O1VzlcsL5nPg/G4CqywxTrn2/wHgaM2AgSx//cKeaORsXcZqYoZHvdWC3L+0SpqswrTG
         +i981IlTM3kOHQ1gEJzVBj6wmrlAHiGh2vjob49O8srnTR/nmsJRMrytLZ3fhs4uchil
         OQJw==
X-Gm-Message-State: AOJu0YzbL7dFIgkZqVmPjzCReTQBEv8HRQzILfBZEgLv6i5Nl6+nAMgb
	PpTbTZnh9nZl8TUfVGcStKiaBRKf8qOF3yDse9QG8nT4fbCS5JJJYwhs9GVK/GtxqbBnD8VfHW8
	3d3ZcarcBWeZT5ucmul0OHl8ExMy1HCoD4LX90A==
X-Google-Smtp-Source: AGHT+IGuTAUXYGuoFczcZ9F/O/HV4ODtqiVstn6XEgheiBsiZuK98u0eN9pDPYlFkhTi88W5GaiKyT/7b2gDM+Hwqys=
X-Received: by 2002:a25:6608:0:b0:e16:7070:97e6 with SMTP id
 3f1490d57ef6-e17764c6e59mr5879394276.9.1724410877637; Fri, 23 Aug 2024
 04:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240823071040epcas1p1309967537fb6286a9e67a38e598ce104@epcas1p1.samsung.com>
 <20240823071025.15410-1-sh8267.baek@samsung.com>
In-Reply-To: <20240823071025.15410-1-sh8267.baek@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 23 Aug 2024 13:00:40 +0200
Message-ID: <CAPDyKFpSf8GZppkqJCs1r990QXDJMHWHAbVXS2XoffCLQdgSug@mail.gmail.com>
Subject: Re: [PATCH] mmc : fix for check cqe halt.
To: Seunghwan Baek <sh8267.baek@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	ritesh.list@gmail.com, grant.jung@samsung.com, jt77.jang@samsung.com, 
	junwoo80.lee@samsung.com, dh0421.hwang@samsung.com, jangsub.yi@samsung.com, 
	sh043.lee@samsung.com, cw9316.lee@samsung.com, wkon.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Aug 2024 at 09:10, Seunghwan Baek <sh8267.baek@samsung.com> wrote:
>
> To check if mmc cqe is in halt state, need to check
> set/clear of CQHCI_HALT bit. At this time, we need to
> check with &, not &&. Therefore, code to check whether
> cqe is in halt state is modified to cqhci_halted,
> which has already been implemented.
>
> Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>

Hi Seunghwan,

Please re-post to include some additional and needed maintainers.
./scripts/get_maintainer.pl drivers/mmc/host/cqhci-core.c should give
you the needed information.

Kind regards
Uffe

> ---
>  drivers/mmc/host/cqhci-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index c14d7251d0bb..3d5bcb92c78e 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -282,7 +282,7 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
>
>         cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
>
> -       if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)
> +       if (cqhci_halted(cq_host))
>                 cqhci_writel(cq_host, 0, CQHCI_CTL);
>
>         mmc->cqe_on = true;
> @@ -617,7 +617,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>                 cqhci_writel(cq_host, 0, CQHCI_CTL);
>                 mmc->cqe_on = true;
>                 pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
> -               if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) {
> +               if (cqhci_halted(cq_host)) {
>                         pr_err("%s: cqhci: CQE failed to exit halt state\n",
>                                mmc_hostname(mmc));
>                 }
> --
> 2.17.1
>

