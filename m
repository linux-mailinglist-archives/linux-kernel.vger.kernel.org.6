Return-Path: <linux-kernel+bounces-244329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 564FB92A2C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B4C1F22378
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58AB13FD72;
	Mon,  8 Jul 2024 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V2Y4Zg3f"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C615C13A400
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441485; cv=none; b=rLhB0W5xaqSk/Yi+zb05tD6XaFNefdVzuyf1EYbs312vgS9u7j7z3/Hn1pG9Mjh06XMJqodzQ2F+O6SGWxcUBK2Jwe8VXtuYeB1aqAd20zt4igtDJWrEj+Vp9MC6qdBgDESJU9M/OfVH4ZEkhTNoKXfl4jx9OZDdhnxIhF/m1pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441485; c=relaxed/simple;
	bh=9dx+1t0EH+JyvUfSEueYnrqzhW9tjyVNxMt4fmD8BkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzuKYhEAjUOYnZzXGV40ri8MgR9uvDDbgRhSx8HPfVkGhWmPzss4xXhYWrt5zG52vluni0suVHM4icCIJGUdZIfQP1zgKSZ68v6tbmUNqp1QWTKGbMESVKegrj+r235UuSWuoPgp6ulYem6gEJ9CTgPbmlQq1At2IpQ9pCMtApg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V2Y4Zg3f; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e03caab48a2so2533734276.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 05:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720441483; x=1721046283; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6eRPNGTqIoXzzDaZTM/Tr50ep2o9S4rIQJljxJPqpqo=;
        b=V2Y4Zg3fUP7QQJbxLn8eIOSSBqQEB96ZxPf2Ymm6QgQUD67OA7M1d96CFwuSkfKyR1
         GSHEnWO4uTo2lHcQhgz8+vGYRwI93+mRFuZQbWbWTh/VK3PiVODpCwrI3/eCq5NVwqdJ
         Xy/5NrC/dEYEtXpG0uXpeBGLThdHpTl7WLfpXlwX1Sq40ggAQfVSCh/cgiHo2GasSupp
         eVtePL+5KpVJMQyfMTiXdbpwcZ0hJBjENIwWjDqXC+GmNda7/NVbXwTBDeVV8RWqskjQ
         HNw4pC6T/UZjWV5bPb4V8IJ3k8IxJW9I9r/t1W/ebiMcGUCGpFMk9h8qAUEXVCQ7bapX
         qVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720441483; x=1721046283;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eRPNGTqIoXzzDaZTM/Tr50ep2o9S4rIQJljxJPqpqo=;
        b=BpVY1bhEsW7HuN6nX9Y5UMe82kc8xpU0zgOuQYgXsn206kXHRrUAFfSrdzx/yeRc54
         VPdWxmv4gIBui9wWakwLPy9b8CFqoMBDg5bcQ51n9j8KlmYtTMqCUEUYCfCQuw9M5362
         m7TZe5RiT2rijFe7YsiS81dQlrJ4MbEtGusMd5C9liv97Ad9qvZcDUcbeUJTboXUNIge
         VkiIwpzVWblKnXTwCWuWC9yIStunsN+BFwX8MVxZLihm+mpK5BpFZBDH/dp5DhnX+phD
         w22JP310Osn7R1AhKNJdc4cZSypj4cdbNbe9WtMOwJpXzHm0YthsBmY6dpVwyDdvDnX5
         LHmg==
X-Forwarded-Encrypted: i=1; AJvYcCVcv0WwH1wV+yIimqKyClMf9BR74SV2nB03E/ztOQA1d7ngweiOZ1Gc9gIzEL1KopBzji8pwlfN/tW27jpeFDBkP6T6T2BMngs9enMS
X-Gm-Message-State: AOJu0YyTPdaOeX1y+L1gvxmksh4mEggWXXOaRLm4oA0J5Bdf5LAqys7x
	NFcYpiIYNXWfX05VHjR0NPoxBgObNaO0/lX4b8cuuNZ3bgjKC7hjCoTUF2BklWJzFqp5cqvDZd5
	PH/Rf78yhTK1UIPlO6UOyMLHmf1rcwWpI1Eb5CA==
X-Google-Smtp-Source: AGHT+IHl3b/Ar3/pE/PZjIf5qiMkFEnQS3z5ng1Yvah7bFG+Q0Vdpj1Y/cyeF92Xic9N7Tkw5LUBVLrQqCOtgisQjOI=
X-Received: by 2002:a25:e90c:0:b0:e03:4f13:75da with SMTP id
 3f1490d57ef6-e03c289a18dmr8025908276.7.1720441482828; Mon, 08 Jul 2024
 05:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705-sdhci_am654-const-regmap_config-v1-1-c166a8d48a66@gmail.com>
In-Reply-To: <20240705-sdhci_am654-const-regmap_config-v1-1-c166a8d48a66@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 8 Jul 2024 14:24:06 +0200
Message-ID: <CAPDyKFq3axtXAsPfZsowEjE0rJ-YJvxO_1XM8okoZyCFN9+Ksg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci_am654: Constify struct regmap_config
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jul 2024 at 12:51, Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:
>
> `sdhci_am654_regmap_config` is not modified and can be declared as const
> to move its data to a read-only section.
>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci_am654.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 17ad32cfc0c3..64e10f7c9faa 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -90,7 +90,7 @@
>  /* Command Queue Host Controller Interface Base address */
>  #define SDHCI_AM654_CQE_BASE_ADDR 0x200
>
> -static struct regmap_config sdhci_am654_regmap_config = {
> +static const struct regmap_config sdhci_am654_regmap_config = {
>         .reg_bits = 32,
>         .val_bits = 32,
>         .reg_stride = 4,
>
> ---
> base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
> change-id: 20240705-sdhci_am654-const-regmap_config-f97903ce0e7f
>
> Best regards,
> --
> Javier Carrasco <javier.carrasco.cruz@gmail.com>
>

