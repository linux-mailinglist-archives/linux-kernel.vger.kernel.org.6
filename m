Return-Path: <linux-kernel+bounces-333794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A276397CE2D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 21:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7701F23DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB53D3B79C;
	Thu, 19 Sep 2024 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BW3ZihHQ"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0135C38F97
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726774768; cv=none; b=Av3ZpUCtMXenmXaR3/jWQ8PWkKU4s84l7okazmDCcnnL77WRRxIaQSPNuZh1thlmWZxVWcez9/Hsrvcw1E10wK+ffHoDzlwB5H+dFQmsxQkBUc5Ddgo53sDjfUsub7edC0YoJK24fN1guBM2uxcfgIXN/R09SY79Ci3sLrLLb3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726774768; c=relaxed/simple;
	bh=fof4Y+XqAIEawmDZiNjGYccb4vYXEW3pxTGZwYqjodc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkHxgFkaqjGKFpdCZ6kgmLIK1B9bA/8xSfGVtfAK8QC7jtS+OwF5LOTDCuO5ftmKYwy/jmvJlVVc0W+mB339gyHcv8pw7Chq8KJVPrBQ7WfZsrewZi4Zm+WmndCok8nTtCHoDKNPOFmTakdQrEwqjDxqwMCtm9/E/jcZvE2vk/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BW3ZihHQ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d56155f51so138901966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726774763; x=1727379563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W7DLrUqqQ4L4ci5VnJmW7hDeRDd57P0ACw668zHYYqg=;
        b=BW3ZihHQVyhgyRPxhILVRVsjkSI5rqeYl6iDkgXipNfyLE3B1Lvow+xh00k9du/1UI
         NL1nt0ILIkLN0I2SWbLfcFw2R5sMsmV0nW0p5n0kPNvDqe8KxIJktm5DWoxV9vbcbmki
         UeB/x9HGboOzDVz+w8FddXb8hbldwgpfh3OGt0UQo/4Lx309rXIoshV82vL7KR6VXkGq
         pQ864xa3z6pMX6wbKgn+XQZA5w9M9Af6DG3HYSVdly+FVui3pmpKh0V7z2xVpPKwTr6u
         6qss0myJTOfEFWrOwOmQgHrFY49CgQisVKOdd5TOnCv/MuLY1Ka2UzfrvTNIdV/V44C8
         TmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726774763; x=1727379563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7DLrUqqQ4L4ci5VnJmW7hDeRDd57P0ACw668zHYYqg=;
        b=q/uuxKy+Eg9x6bn50CJ8Wg08u9l4y6x/Fi9jwtGd+Zwl39PKnD7K9yGGZk8dmGm/QI
         S8eHVsssslrU88MT/1TitNhREi7rbx2dRjhlAndWdQzRr+OzfDF+NhtbWGizzLeQxpho
         DE3h5sV/rV6kdLBG9Xnkzd3XMTlsepth690QJdDruvXhLSFue8mtXQMrlLy/dJ2D2IEl
         dy2IFzPSoUxc56lV4cPMKQ0Op0lfhry9Anx9AeEEi+2+wFXRaNTm397D9tgVoHgLaRIL
         DcHY9rZFRQcEC95wsXWsfEHMM4768pmN9/JWJYyPwfwvpArph2R/lGvN9Pl4OovvyckW
         3ljg==
X-Forwarded-Encrypted: i=1; AJvYcCVA/7vtVuWJoNw7BVvbjRarcelHbBTmwMABm4zKkbNUmq3AKE3DlpYDlzkIqcXTZsvrD1TConiw5rnPtRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE4VpYi5zWyj2XcP0/qkA7Y3ZztayDZhs7VYv8VfZd48Vsk3W4
	yRyr42BfZOYyF7ZENs+dIfU++y1uWaHL3wdesLWX7SOknl2lK7ZD1ZzVKXfg/e0QzrkoivGY8TN
	zLIyGOjf36r6st3Gop9x2T5JlbD6vF1YmG6j8JQ==
X-Google-Smtp-Source: AGHT+IHFssq6SEY8xmjw8fzlMOVLwF7nUAg01vJG44H7tx5slPYYutozOjG4yTxIRsVA+zkzobhXmI1ODIc37gj+aQs=
X-Received: by 2002:a17:907:c897:b0:a86:8f7b:9f19 with SMTP id
 a640c23a62f3a-a90d50eec19mr23301766b.52.1726774763253; Thu, 19 Sep 2024
 12:39:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3f3660af-4ea0-4a89-b3b7-58de7b16d7a5@stanley.mountain>
In-Reply-To: <3f3660af-4ea0-4a89-b3b7-58de7b16d7a5@stanley.mountain>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 20 Sep 2024 01:09:11 +0530
Message-ID: <CAKohpo=x6CvzwcJjYscV6qTdj=K3qECjwNj-EV5L4n8O+-WoTw@mail.gmail.com>
Subject: Re: [PATCH] OPP: fix error code in dev_pm_opp_set_config()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Sept 2024 at 19:37, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> This is an error path so set the error code.  Smatch complains about the
> current code:
>
>     drivers/opp/core.c:2660 dev_pm_opp_set_config()
>     error: uninitialized symbol 'ret'.
>
> Fixes: e37440e7e2c2 ("OPP: Call dev_pm_opp_set_opp() for required OPPs")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
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

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

(Ulf should be picking this patch for now)

