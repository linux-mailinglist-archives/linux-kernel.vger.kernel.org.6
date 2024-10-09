Return-Path: <linux-kernel+bounces-357106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EBC996BA6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59A32B24AE9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FC3194C76;
	Wed,  9 Oct 2024 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mM1J/c1T"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D425189B98
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728479912; cv=none; b=bh7KSSqkZps6Or9XLsMe0J1cVbu7Z5ZykZDdOhXSi+B0qmlzLE2fqg58XBP1ds5B6NL2A01NUw7MyEgD+uDixEangZcGdpjrKNhwqHUDStQLmwYtQQXxBHJmINBDOoIsqaLnxPQyzUKXADHfMWg8G3WYTNuXt/7yq8nsxXl7IHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728479912; c=relaxed/simple;
	bh=DEs/d30A6OdgSded7yLq86hpsqBzL2gpxnYKoRS9vWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUm7xszj533zLv9ccoAeXzdMAPknIGPnTXbVDclMFdGNrSO3nmwt2wr75sTZ0/x73BkJoRp2utnlqgHtPFus9P0mrU8IZZBlxta5TmUe/nFpXPoy/1JiKJa0Ad7mU9Uh7YXi59UjqWdFQuTqEg8JaMMdH/tbovUPnvWJ4sml4Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mM1J/c1T; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso6830451276.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728479909; x=1729084709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fahjuP5GSwT5SXM4x2ztwRN877oqyqnMQjfzefZnQm4=;
        b=mM1J/c1TOedfqGlDpF0hjCdX9OAj4kbWxx/1tPRvUwuBGhrW2eUkuSiZQg153bzkhU
         BHfoJyHgDBOSwoK72YQkDuYLe/Er+Yqn/9e3MBggW5vuWJJwx+C6k7dBaSLAIAZ56EoD
         yntdjkpFgk85kXnZS8nnO5nBx8JDrT6eP9VlDp4swJ+jMAC7QaZXCnXw0vDU6lPUDkUs
         IFQhPg66TUT2HTQfXB3fqYBt0ghDgC2hkfZwZxGV6CY/SL3wXd6hF55/HfSB47+AFUJG
         WAcdiSylD4pXC3PsjOHXnr22d9GCrWKrvy/hssW16NbWI7l9VsCDPLUORqk0mFFGyQv9
         sbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728479909; x=1729084709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fahjuP5GSwT5SXM4x2ztwRN877oqyqnMQjfzefZnQm4=;
        b=HJyg1uSK2e0FChSmBzAOS7mwa3YFjWrU8truxVpsf9g6Sumck5Sm5LMJCQrdMCsruU
         C6d2XFl+0WQ12MNLBmNOAUnrVicZU3fi367JAT7MerIy38PUluOAqz6HbybrEm3eRbOL
         k+DszuvDB4aBfRpyQOWkczjTS8z6AyAP9xw82UXpoE59uIStNTwmTpLnzrnpT/iKZj0h
         zXPIgR2PBwNpJU4/w0XaBd2nYUKoaxqZK5jv2RaMMMa+s/0u8GyRJTbGSDkUZ+UYT811
         rCZyTHQBOjumvEDO0rCydINCO1mekQXNvzCmGSghOhGnUG5IfQLJ/hnGj8c5XtTmSzvg
         qtrw==
X-Forwarded-Encrypted: i=1; AJvYcCXBzbB4ZxahxsI66vGWsORR+o+E7ublM4lvp4leidb+RPhCPoW0dpDWWdTYJ8kbK2uIT7qoz3LEE9MNWs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF9I5IIYP/BkCd/UqOEsoJITyXU9xRQnTBU2MGL70IpdkABGuz
	h+duKV+fJUUM0174NsQS+4eazlWdbZDOqZX2Uvfx+6bxK8ut8VvAP3agpl/cWC6+qwKGnVoV3ti
	tFWu2EM8Oyern47Tuy/vTHO57w4FzQn//jVuH7g==
X-Google-Smtp-Source: AGHT+IGdMVfirN3r2XR9CcAsjc7P63ptNZgOVR3DTBZovGzj3+iT9kj28KuHzCMjhXPK3VMUIZsVtd+U5lqO0q997qI=
X-Received: by 2002:a05:6902:124f:b0:e28:e605:2dd4 with SMTP id
 3f1490d57ef6-e2909c1b69bmr146400276.17.1728479909496; Wed, 09 Oct 2024
 06:18:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-8250-omap-no-console-suspend-v1-0-e7f0365c02f0@bootlin.com>
 <20241008-8250-omap-no-console-suspend-v1-1-e7f0365c02f0@bootlin.com>
In-Reply-To: <20241008-8250-omap-no-console-suspend-v1-1-e7f0365c02f0@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Oct 2024 15:17:53 +0200
Message-ID: <CAPDyKFroumouYavhaHp=aSh=0WsDO=_4kbVgS-+Y7CADyO-Kmg@mail.gmail.com>
Subject: Re: [PATCH 1/2] pmdomain: ti-sci: set the GENPD_FLAG_ACTIVE_WAKEUP
 flag for all PM domains
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, u-kumar1@ti.com, tony@atomide.com, 
	khilman@kernel.org, gregory.clement@bootlin.com, thomas.petazzoni@bootlin.com, 
	theo.lebrun@bootlin.com, richard.genoud@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Oct 2024 at 11:34, Thomas Richard <thomas.richard@bootlin.com> wr=
ote:
>
> With this flag, if a device is marked on the wakeup path, the correspondi=
ng
> PM domain is kept powered on.

Perhaps extend this with some more information that it fixes a problem
for the uart console too?

>
> Suggested-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Should we add a stable/fixes tag?

Kind regards
Uffe

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
> --
> 2.39.5
>

