Return-Path: <linux-kernel+bounces-316661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C0E96D278
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80CBA287B2C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F171194AEC;
	Thu,  5 Sep 2024 08:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UqeObOrS"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19CB5256
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526168; cv=none; b=KGvPnWr0y23ZqnxGPBOb8me9NCLoxA0SzV+gQnzhpGRk04DahdDFzv5Jw6FjgH9NfJmaOXwGc5PrDOdvlo3TighXzMldZioqRQxt29ir+JBIA6+tUECL9yWguu8l5siLh2kwRXFqzNAJw01aawjz573ZYOWmZ2ExD8pIQ/xc57s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526168; c=relaxed/simple;
	bh=yPM9vBhvNbHjBvHTD+cPHEMNq/7nqxkgyERGdGqus/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fa/ISMC/Uu6YJk7tEDt0Haay5mNT5cWO0Z9rsZkr/qKAA7ZS4B3oYQky+e69SfGqWtGBGRV9h9x7/ZibE+JVpcaQFDjHxRkj6janA2ZxeNMSInESqDGCBgtesECQZh+nFutFZOfYmrSGVNFg9J9XYJd5ZY0qbNRWF+dduXERwTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UqeObOrS; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f406034874so5795351fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725526164; x=1726130964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPMsWyHxkK2NQoq3TeZ4J0A2y8B6YuTsXzVh08x+E4g=;
        b=UqeObOrSpcilB5o9De+wNF/eFD3+uKPblHXYvfx17Q1h9m0Ai56eBYh9TFrXRSF3WC
         qiP9cPjOVHjBmQEf+sx9XIB0f3tps4pQL8JLxtPopnSh4bYCSBhZQElS+f4Gn8Q6mkEa
         5dasuu3nAFFM6MIuYkBpkp9LCyW21e172x0hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725526164; x=1726130964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPMsWyHxkK2NQoq3TeZ4J0A2y8B6YuTsXzVh08x+E4g=;
        b=unD2KKC8umDJdxz5e5APw1ZTRkcg0UEuD9ji2LV1+EPcCVVDPxUflxDJpbIP++63lB
         oU5XVXkYwyghJlV/BPXll49wZK6SHdA/TtYFsdJD85ZeDUm9qFbEIHlJ63o/J+vUH1X/
         53Ch8yZ063t2G2A4JSxHqBZhdqyy2i7FxOtKJWs8e3VID6SVbD41tWeMMgJTaknQRf7c
         yPOlX18JE8qm8SQTwwv5POK9WFsSml+FdbsYG7EKIDSlq8gpY/sVgLUa8tTE2ahq7to1
         1QzfLHUZb6kEZafW65wMxcUdiDcrZ1GIfv3iRDCTolKZr6eF9dt1IylwP5chdirVLWGR
         +NeA==
X-Forwarded-Encrypted: i=1; AJvYcCVsPhFwApn5isTnFXShqluJ1+FZauWDsvf5deFC84iaMZtPJLKNU/I+cOCYQnNHqfFZBuh7K3LYXYk8lfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIuM1XQolNbJfcxGQAu2MIesMZB5nMboNDzaRPGEbEbuVJIQvC
	h4pow4EiT7EaR3+smqcACBCb6Pnw9Qwn26hjkC0vbYcHZIPwx3HIYaV5s4E8v50Nhpb8OFl/U0t
	Kb/R0s4LhF97vjOROSDLc49d+MfDeu9J9+Etj
X-Google-Smtp-Source: AGHT+IFq+YduOnfSAkl8vaajpAMn+1hkW4Ykul9HUWHNSDY87PO+oTjFnXxLUE4V72wKX/NHSAwRstlLK7qu9HDfSis=
X-Received: by 2002:a2e:a78a:0:b0:2f4:4d58:9edf with SMTP id
 38308e7fff4ca-2f650b8559emr42063871fa.20.1725526164327; Thu, 05 Sep 2024
 01:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904190856.1221459-1-andy.shevchenko@gmail.com>
In-Reply-To: <20240904190856.1221459-1-andy.shevchenko@gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 5 Sep 2024 16:49:12 +0800
Message-ID: <CAGXv+5H8LBGQWC9uJk_ai8d5pfCA7FZMnDQve2QfTeA74acXmg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] regulator: of: Refactor of_get_*regulator() to
 decrease indentation
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
	Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 3:09=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> Refactor of_get_*regulator() to decrease indentation and increase readabi=
lity.
> No functional changes intended.
>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  drivers/regulator/of_regulator.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regu=
lator.c
> index d5dd7a9e577b..3f490d81abc2 100644
> --- a/drivers/regulator/of_regulator.c
> +++ b/drivers/regulator/of_regulator.c
> @@ -572,14 +572,12 @@ static struct device_node *of_get_child_regulator(s=
truct device_node *parent,
>
>         for_each_child_of_node(parent, child) {
>                 regnode =3D of_parse_phandle(child, prop_name, 0);
> -
> -               if (!regnode) {
> -                       regnode =3D of_get_child_regulator(child, prop_na=
me);
> -                       if (regnode)
> -                               goto err_node_put;

Nit: I would probably rename this to out_node_put. But if we're going to
move to the scoped helper, we might as well just skip it.

> -               } else {
> +               if (regnode)
> +                       goto err_node_put;
> +
> +               regnode =3D of_get_child_regulator(child, prop_name);
> +               if (regnode)
>                         goto err_node_put;
> -               }
>         }
>         return NULL;
>
> @@ -607,17 +605,15 @@ static struct device_node *of_get_regulator(struct =
device *dev, const char *supp
>
>         snprintf(prop_name, 64, "%s-supply", supply);
>         regnode =3D of_parse_phandle(dev->of_node, prop_name, 0);
> +       if (regnode)
> +               return regnode;
>
> -       if (!regnode) {
> -               regnode =3D of_get_child_regulator(dev->of_node, prop_nam=
e);
> -               if (regnode)
> -                       return regnode;
> +       regnode =3D of_get_child_regulator(dev->of_node, prop_name);
> +       if (regnode)
> +               return regnode;
>
> -               dev_dbg(dev, "Looking up %s property in node %pOF failed\=
n",
> -                       prop_name, dev->of_node);
> -               return NULL;
> -       }
> -       return regnode;
> +       dev_dbg(dev, "Looking up %s property in node %pOF failed\n", prop=
_name, dev->of_node);
> +       return NULL;
>  }
>
>  static struct regulator_dev *of_find_regulator_by_node(struct device_nod=
e *np)
> --
> 2.46.0
>

