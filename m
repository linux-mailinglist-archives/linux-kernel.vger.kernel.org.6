Return-Path: <linux-kernel+bounces-312921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C00BE969DBA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35091C212EF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDDA1D6DDA;
	Tue,  3 Sep 2024 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DSHOxEmR"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C515F1C9851
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367073; cv=none; b=KJ0SHZM3Sgcm8VtQ0+mjwGV3imPoZqHWN5rc+3rwfOifBPbk2UjxQcyOZes5szUljB/MJhqicev7lbYLUGFfFjV21uPWZFyB4EF/46FaDYJDsz60FeAqKDlT/BCrXi2Hud1mWr5p9+CcEmxIr+VZJEZ8HlfDqsV6ydvY4nOxQTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367073; c=relaxed/simple;
	bh=vAJYUB1JYAdTSCX3IiQu6MnRzSD3ZDq0H7nrMseKveQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NunglB5y1UXUs6bhzVcUf0WyJ4d+Pfew09/atLULNEc4TNFSzsnLI+TAN5AICzrwZmWdgx3wyK49Ujpa9IpqV2KB358wq2bOJE9zJSVrd2pkdyJzbyjBpfOOsi5lErQJA2XG9/KZu/wVmRSknt2bVs/MR8an2Qi20+xodMaKka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DSHOxEmR; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e1cf1a4865aso900472276.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 05:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725367071; x=1725971871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gDo+yVD+3RYI+5zJwy/WNiTtLCeqz/kJT8uN33xHNmA=;
        b=DSHOxEmRM+WOqbDOk8xdSm/1Rg8Rdt4NVzNc5xWfnTKdbAscy4IchfB7kEvG4/BXzT
         Z8kEnjYRDRJvr1kQvAxLvNJ/Rkhtv8odHEeLM15wHFZrjVGbRtuB7fY1gp5ipUQELxMc
         lWkDZVkYhLSnLxMXy3UvZL2g3OqC5AlFS16L0a4bvXNs/Z+Erasrclayn5VxJc+lbrGR
         aFsvrIO79DyOFJNKEWVq3bB2Oy84bfp7UdlP/9YQYrI3yK6KSDuqEQbX9TOfiSGYekLR
         5SssdRf9nRrOY0jzzeaM0E1uYVNWTTFjyPwrevp7dw8A/7Sd+DnvPbs7NUKrOqIvUGbq
         OCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725367071; x=1725971871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDo+yVD+3RYI+5zJwy/WNiTtLCeqz/kJT8uN33xHNmA=;
        b=hpZvUiRdgrpBKvZJ8733rJDua3llFF360uxdNbdlG62UAtagfSF2st57Kf6XeJaRCr
         pokou9LUENtrZZh9lqxcs55xovjK/2dKyjqTBhXiO7bKFxg+iV5ubmiuPHZeykGlLoP0
         2Z+i05rU2mKX+kOo3XB4PsqZ0fyjN77jkSkZE21luBYFzY45gAPMRZdpJGbJFcOusXPz
         FfayYjieuTprM5vpatVGRabDNSbGu1cj1qJsHSgcn179MLkaUNnpi705AJaDdhWaXYfN
         3Yqcy6efFFbEBg1UlKXW7ijHOeJywAb+q9szvXJjl+Ez67ulW9JqwD2io/47fMTApRii
         NxvA==
X-Gm-Message-State: AOJu0YxxdqDzwZRgnX5u9OAx1nvyV0lx2TaVKlooa9wiz8zJk0d/EWGF
	FNEKMOAAqbUWCZ1KoYueqJ2ncD+AfwIxdC8jjozAMCncOcjZB6MFJkNRzg3CdSFH0KxGpefvwJ2
	oSuHstC/87OAJR3ngRCn3qhKQ3LmiGFfKj6TttA==
X-Google-Smtp-Source: AGHT+IG7wVWvBwVm8d9fEbO3Oflgii2VupDav0zWIgeWSdeL76IOqUTeZJcnUewS4XpCOBcCGjv00I2YWnT5Qsdy31k=
X-Received: by 2002:a05:6902:2493:b0:e11:7850:ac6e with SMTP id
 3f1490d57ef6-e1a7a1d0785mr13896773276.50.1725367070896; Tue, 03 Sep 2024
 05:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240829061840epcas1p4ceeaea9b00a34cae0c2e82652be0d0ee@epcas1p4.samsung.com>
 <20240829061823.3718-1-sh8267.baek@samsung.com> <20240829061823.3718-2-sh8267.baek@samsung.com>
In-Reply-To: <20240829061823.3718-2-sh8267.baek@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Sep 2024 14:37:15 +0200
Message-ID: <CAPDyKFrpLoV_X0cp4ycEeEj_Vhv0+1nmQ87+QVNV-o+Z0YEgmw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: cqhci: Fix checking of CQHCI_HALT state
To: Seunghwan Baek <sh8267.baek@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	ritesh.list@gmail.com, quic_asutoshd@quicinc.com, adrian.hunter@intel.com, 
	grant.jung@samsung.com, jt77.jang@samsung.com, junwoo80.lee@samsung.com, 
	dh0421.hwang@samsung.com, jangsub.yi@samsung.com, sh043.lee@samsung.com, 
	cw9316.lee@samsung.com, wkon.kim@samsung.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Aug 2024 at 08:18, Seunghwan Baek <sh8267.baek@samsung.com> wrote:
>
> To check if mmc cqe is in halt state, need to check set/clear of CQHCI_HALT
> bit. At this time, we need to check with &, not &&.
>
> Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
> Cc: stable@vger.kernel.org
> Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cqhci-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index c14d7251d0bb..a02da26a1efd 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -617,7 +617,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>                 cqhci_writel(cq_host, 0, CQHCI_CTL);
>                 mmc->cqe_on = true;
>                 pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
> -               if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) {
> +               if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
>                         pr_err("%s: cqhci: CQE failed to exit halt state\n",
>                                mmc_hostname(mmc));
>                 }
> --
> 2.17.1
>

