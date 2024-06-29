Return-Path: <linux-kernel+bounces-234969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCF791CD9D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 16:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0F59B2260F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 14:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5796823B8;
	Sat, 29 Jun 2024 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uhMMqDAc"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FEB7D3F5
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719671446; cv=none; b=Lxr4Wn7JliIw4tqe9Dk8HmYSl40PjkMIrmDwdcooFE6mYuvlWdH26TfcLyHTxp2A+172NGtN6AugU4UAQZ4ybDXffTX3eml0atiZqfjJXUq3Vpv3iIygISdQtyEEQ00bWpz7zrkpzy0K7Hqiod/TgE1Dr6MueAPJdUf+2oGNEpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719671446; c=relaxed/simple;
	bh=6GbLi1JD0DeqwbARIUWnsx6f1P44NPHpbsq6lRJDRm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwFO2QSutUcGO6qHGoOhv2BlQz7dCUdWfwLRyCYHzmX/0/R5umPbVO2sq8NkyIQN8ZZ3/NE/buywBZPweItJQzEDYunPBSzXddbbe/6w7DKgrs88hLbbc/YuHMsT6odbyxteK/xpRR5l1rPsCo1q2OoNdScmoB4AVMktJoHUTzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uhMMqDAc; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d119fddd9so4844a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 07:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719671443; x=1720276243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrud1JhfOlUfYB81S7Syr/8uTZeCdrf+FlsoxmK/I4o=;
        b=uhMMqDAcFyJ8riw892JZyCOfM+uvTFsVHdWfkXkUnmsbwU2nBP3HkUETwEmiR1JGYR
         Tql2vR59f29RiaynZeU7I3GtqDjhbDvuVpdMX4mT5t5aTLS/BpodWzaJB2VMVHItUpAu
         nVN/WRVqiDRk6DbS0tLQqh9IbhdM7T6pn5ItTUkfEvzzVtYiibkFhKdgUegI4x65yVuF
         DsNYMTCSTa1taqTjcA1DAg4taaPbJ8lyZm+17mMa1M2f0lAh3KnEPR0DZFSOlpPI4Gqq
         jsJ1dvdiz8d+p79tsSiQI4qtiy1gIFEHaSL32cXcZeOkFnz2vVE31hSo9yYwkKU2GVoT
         iULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719671443; x=1720276243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrud1JhfOlUfYB81S7Syr/8uTZeCdrf+FlsoxmK/I4o=;
        b=rGUj8iChEOJFGjwfsE7Ih83VsQbAaOR+SYIFiUNf3JurZFz8k2HIRwDoC1n/X3/okH
         +i7ZYygeO7hxTCZOzyWEOZEf37Ra+TomXSrohH0nOA3d+SOPI2Oc8AjfgCKxJYOTt6Ji
         K5HVbLOUzWBIjF1Shrw/I/2fSYByfKtrb61XHDszo0wk3iK+ifVCVI0hXpugVJCUr1Yg
         xr/2kyALD4izLpCds5rOq6umlpdhwQjJM3BJmErcg1lzxmWkp/MAEKFMy55mkx9avS0/
         8bF+gY2XDSV3TVf1EfHEsGyUSRy9HQxq3oiOUuhQDMXZJdmmsndf0VchGtoA6q4Epzy6
         LzKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH4GYFzXAijvroSd9xOWzL9pwk416NokfZJW3PN2FlW++R6S0cP5o0AF/V73ZyPBTsKtL84HgA0+VVP4zYAwLXj8r6PkPnStACabmM
X-Gm-Message-State: AOJu0YyqUP9nRiaXcMDrGmPwimlCnM+wAlfu9Sjz6uQfgLFnl34gZm9I
	gOj24xi5TczZhl0aLmqaY7dFQSno5AY28TCwohoMj3ExTIKPYcfNlkGIMY7pKe3FQniuk2Rh3ZS
	2Zumh3N0e/zlY0uHWx+pzMpDt3cgXbkQxT/E8
X-Google-Smtp-Source: AGHT+IF6Ig144tkRe+lYrfurwiAb/HGvUlbkbhXr2qYEad3JtuJTL7bhoRuypkZ9VxzjKILvi3jchWLefZw/5jHXLgc=
X-Received: by 2002:a50:8ad0:0:b0:57d:44ab:ecff with SMTP id
 4fb4d7f45d1cf-5872f6702a3mr120663a12.2.1719671442396; Sat, 29 Jun 2024
 07:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a9623e7e-ce3a-434c-a904-39c6934c2ff5@web.de>
In-Reply-To: <a9623e7e-ce3a-434c-a904-39c6934c2ff5@web.de>
From: Guenter Roeck <groeck@google.com>
Date: Sat, 29 Jun 2024 07:30:28 -0700
Message-ID: <CABXOdTc6G9E2SdyP+27Gp3HsxfKqKOPmqkYG2x6Avg5bzCNNdA@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Use common error handling
 code in cros_typec_init_ports()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: chrome-platform@lists.linux.dev, kernel-janitors@vger.kernel.org, 
	Benson Leung <bleung@chromium.org>, =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <groeck@chromium.org>, 
	Prashant Malani <pmalani@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 6:33=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 29 Jun 2024 15:17:44 +0200
>
> Add a jump target so that a bit of exception handling can be better reuse=
d
> at the end of this function implementation.
>

I see no value in this patch.

Guenter

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/c=
hrome/cros_ec_typec.c
> index 4d305876ec08..aff744a0b38f 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -348,15 +348,13 @@ static int cros_typec_init_ports(struct cros_typec_=
data *typec)
>         port_prop =3D dev->of_node ? "reg" : "port-number";
>         device_for_each_child_node(dev, fwnode) {
>                 if (fwnode_property_read_u32(fwnode, port_prop, &port_num=
)) {
> -                       ret =3D -EINVAL;
>                         dev_err(dev, "No port-number for port, aborting.\=
n");
> -                       goto unregister_ports;
> +                       goto e_inval;
>                 }
>
>                 if (port_num >=3D typec->num_ports) {
>                         dev_err(dev, "Invalid port number.\n");
> -                       ret =3D -EINVAL;
> -                       goto unregister_ports;
> +                       goto e_inval;
>                 }
>
>                 dev_dbg(dev, "Registering port %d\n", port_num);
> @@ -408,6 +406,8 @@ static int cros_typec_init_ports(struct cros_typec_da=
ta *typec)
>
>         return 0;
>
> +e_inval:
> +       ret =3D -EINVAL;
>  unregister_ports:
>         cros_unregister_ports(typec);
>         return ret;
> --
> 2.45.2
>

