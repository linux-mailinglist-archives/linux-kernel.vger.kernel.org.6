Return-Path: <linux-kernel+bounces-346836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5BC98C983
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F412854AB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE5E1CF5C6;
	Tue,  1 Oct 2024 23:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HfLMWihO"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E64194AD1
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 23:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727825595; cv=none; b=RKeGrlXw7xQpCCms4PqLi37+NjNz1yD1UV7B0tDraqUfsS++JvVNZDJPcCao2F1vlUD6tGnM+dTssgFn/FP+W/M9rietacf2SZ0Vs9ZPM1Z3+0JSjNbWI5OyMBtcZ/D6c4SqCaXIoLZlNXzqJGLQtlrWV7IRRPUgkdl541Hy9sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727825595; c=relaxed/simple;
	bh=UsT54fmI8CdBIwP9723yQfC/u5N0lQNbGULTor+sqf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4wEavnmSWFRuFYI8dVmFwgNMMSBl9s5xHjiGZYy7a/50sAQlhw3Ri1ZcRa8eEPqyd+CKka8kBBLPlAoboKsY57j+mi/2BIPf50ky04e/6mMTaG5x6OKkI5CVJWbMWlEvBu2+EAuQ/HcQHgHZV9YkrytC67zWS5gPDsZb+tr2zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HfLMWihO; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e25d6342837so4892111276.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 16:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727825593; x=1728430393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a+iYkZq+iPYxvfl8T236DGt51ZM6/khmDSEwZJd75PA=;
        b=HfLMWihOcLRZTVDe0cvhgjE/j10iD4cv3EN3AMzJrK39v8zU0mKojZQxDioH3p6v9n
         7Ei/UV1iPUrAAX9DT2jYfEjGcdLhjVTNKwKSvgRu/QUs6zvRoJYZqHKv8ffcT/LIU4Om
         Lw6HENgj0d+QJSQwfi9T96HtmId9eX2/94p23m3lYG0dMpt1kDxupKbRCZugc2XjQuuM
         5JqSU59Gg1w4+9OOQZJ1cfna/ngh1GsrrcPCiLUOwNgAaWuUgyDxamA67b1W1mjn2wqz
         czSlF6YyXLV9HuRlgBFSLBhLlXalo0hc30uzPNUM7boqDGpVLu8OXTcDEJBEx9ageeEn
         9Wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727825593; x=1728430393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+iYkZq+iPYxvfl8T236DGt51ZM6/khmDSEwZJd75PA=;
        b=b3dFalAYIZ6MoiwIif/CX5oEbrjKBV3bbAou6XBk8w2w+vvTEbOCjeo9rnICS56HIe
         /VQrXKoZZdmgrTnQC7P5Zd65DLdgoHepL0HosSDMSn77ocmifbdznl9U1SnrhDoHg068
         QepebKaRIlHQS6W1nviIKMdhxkbOWOJmW89Duo4p5tPeeF8w86c/5Qpehy6BvgJuLlRh
         CA1pb+f4U74tbejOUBNW98P14Aoc31ZsSBoma/2lrRMDDa2YmEazY68b9vX1LCnB4VHn
         47UpMn4b75b+2VZjJHcM9nWGlhov/4b57rOBlyerPuJF+D4HsU+THhL2u7dadTinleLg
         2G2A==
X-Forwarded-Encrypted: i=1; AJvYcCXjhjlKfPkM1UUwoJXD3R3qVz9icRF7bh9sMbtsyqAaeQqca6JfEvktIjfHZxRAzhv9bUTlHgkZdb1xM8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzrlS5nmFarcq6eTHVjaZUw01hjzdbA98gEZKDfyJ9yPCaOKq/
	8y9jtJUiaegHcL91FlEBVzU4F0AAw+swaSE7fpo6hnBErVkOIcU86gHGzBaICYQaPyCsuvgKC2N
	jpRnpwGyBaAkre1ntOrVpgQroTOH28/FuuWXQdQ==
X-Google-Smtp-Source: AGHT+IGlQk6Wy4Pl3cVwIcZh6+8USnAEqDwhrOdOkfctDiC/uDN6CWaRfdqiyEtKTbeKtfvYLZFZut29QuK5LjGg7PY=
X-Received: by 2002:a05:6902:2202:b0:e1d:af44:46b5 with SMTP id
 3f1490d57ef6-e2638382ec1mr1166673276.2.1727825592680; Tue, 01 Oct 2024
 16:33:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3f3660af-4ea0-4a89-b3b7-58de7b16d7a5@stanley.mountain>
In-Reply-To: <3f3660af-4ea0-4a89-b3b7-58de7b16d7a5@stanley.mountain>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 2 Oct 2024 01:32:36 +0200
Message-ID: <CAPDyKFpBEJi6m+V_xVogcAAiJjqbAH+=xQGAYizy=+1BKddQpQ@mail.gmail.com>
Subject: Re: [PATCH] OPP: fix error code in dev_pm_opp_set_config()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Sept 2024 at 16:07, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> This is an error path so set the error code.  Smatch complains about the
> current code:
>
>     drivers/opp/core.c:2660 dev_pm_opp_set_config()
>     error: uninitialized symbol 'ret'.
>
> Fixes: e37440e7e2c2 ("OPP: Call dev_pm_opp_set_opp() for required OPPs")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied for fixes and by adding a stable-tag, thanks!

Kind regards
Uffe


> ---
>  drivers/opp/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 494f8860220d..3aa18737470f 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2630,8 +2630,10 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
>
>         /* Attach genpds */
>         if (config->genpd_names) {
> -               if (config->required_devs)
> +               if (config->required_devs) {
> +                       ret = -EINVAL;
>                         goto err;
> +               }
>
>                 ret = _opp_attach_genpd(opp_table, dev, config->genpd_names,
>                                         config->virt_devs);
> --
> 2.45.2
>

