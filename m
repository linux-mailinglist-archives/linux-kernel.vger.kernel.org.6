Return-Path: <linux-kernel+bounces-447842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CFD9F37BA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1E1188E14C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280072063D1;
	Mon, 16 Dec 2024 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lofKPETl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AF925634
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734370807; cv=none; b=XG3RKEttqLNrn9ZKQ1iHiqIS/i5DLbnt6lnooiiUwq31ptrzS7VbIYLKHeJWroL3x9DN18Zv6NhFWAvtGQ2Y7v4J3yfRaHNFNYiBqAoraLK/3nKYufx1cIqNLWSNGe03e0+kPQXGlDSFlIIzj244ia/oi04x8Xw30DKjm97gDD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734370807; c=relaxed/simple;
	bh=qtDrFiZY7xBWFp6O/QCCjAuUsx6f3Ea8LGZhHYyt7tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwo1hy3ZO0pHCQBRBZUAe/9mahFo/SWZSfk7emmriIBmFOknmmA4u4mW15b5tTCm68Z9UrecNDLLDNV2ZJoypjflnxnGfZGI0RVNnyUqfn2fiwbq0PMPOJF444+mLpP8K5UB0pethywFYqtqeqvZC4AbFD+OJGxIZkyZJZl5eFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lofKPETl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7928C4CED0
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734370806;
	bh=qtDrFiZY7xBWFp6O/QCCjAuUsx6f3Ea8LGZhHYyt7tc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lofKPETlkjOhGIA8grhRZU1IYEcLntyHNvNOzmNk0D2Of4MglNdPERxKrNa3s/6Wr
	 mPgjZ/hBx5CNRP9OWHrimUM1btle/Xmn0eaZSCmQua3HqHQTJ8De9wh0BHTmEytCf5
	 nCb1i15vqC3PuxuEuJ/vI0y9X65e5q7eps7PH67OwqfLLSMLPi7Y2Id46AtWEEfaL8
	 W4PTz/kzl+CKO0dQtI8COTuvz8OktpnFKxTBeaQy/k7pW9hIPkBP9CmimOfEeJTQIt
	 cHjMg/8Xu7EhbiBmWRdMwFNEdkKP8HRnmHu0WAJjw5pvBwM8pV7SQBGsCGoZYWMtA8
	 q3UtxkowInLLQ==
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso3234695276.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:40:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWkcETVqq51ipZdLmYePMJPl3cZUOPAaZ+QntI4965ZfRKPoRteR0nVsrPj2aS7w/SQbOgSMiX7IR+b614=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7BWxcIV5WPOu8B4EhrjS/7+yS1+VLlomuuZLUHXK5eD2iXbJ5
	kmjBv1lXJzgJ33Ewt/PVUvAmsUUfegyLlZNGjotaizsMG29EBYsDKQsFdsm831jHS3dalRdXVE7
	Qq9aUWCjNzvPsxi0RWxiu5lXdPQ==
X-Google-Smtp-Source: AGHT+IGQS3Vs33oblkXxnd78UZgfeUEeHd1e/4e87KRInkXttx2wPk1IBtUqJABbOUTemRiw0riLvAe0o7UmZ68pxM8=
X-Received: by 2002:a05:6902:2081:b0:e4a:9ab:6ac7 with SMTP id
 3f1490d57ef6-e4a09ab70c3mr6470987276.41.1734370806182; Mon, 16 Dec 2024
 09:40:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211-syscon-fixes-v1-3-b5ac8c219e96@kernel.org> <20241215203344.46158-1-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20241215203344.46158-1-john.madieu.xa@bp.renesas.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 16 Dec 2024 11:39:54 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+DEWibue5DVB=gSNB7cvaE85rV5XPf8HPqQDz0DgjCXw@mail.gmail.com>
Message-ID: <CAL_Jsq+DEWibue5DVB=gSNB7cvaE85rV5XPf8HPqQDz0DgjCXw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mfd: syscon: Allow syscon nodes without a "syscon" compatible
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: arnd@arndb.de, heiko@sntech.de, krzysztof.kozlowski@linaro.org, 
	lee@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, liviu.dudau@arm.com, lpieralisi@kernel.org, 
	pankaj.dubey@samsung.com, peter.griffin@linaro.org, sudeep.holla@arm.com, 
	willmcvicker@google.com, biju.das.jz@bp.renesas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 2:34=E2=80=AFPM John Madieu
<john.madieu.xa@bp.renesas.com> wrote:
>
> Hi Rob,
>
> On Wed, 11 Dec 2024 14:57:14 -0600 Rob Herring wrote:
> > diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> > index bfb1f69fcff1..e6df2825c14d 100644
> > --- a/drivers/mfd/syscon.c
> > +++ b/drivers/mfd/syscon.c
> > @@ -171,8 +171,10 @@ static struct regmap *device_node_get_regmap(struc=
t device_node *np,
> >                       break;
> >               }
> >
> > -     if (!syscon)
> > +     if (!syscon && of_device_is_compatible(np, "syscon"))
> >               syscon =3D of_syscon_register(np, check_res);
> > +     else
> > +             syscon =3D ERR_PTR(-EINVAL);
>
> The current modification will make device_node_get_regmap() return -EINVA=
L even
> for syscons that were already found in the syscon_list, which I believe i=
s not
> the intended behavior.

Yes, it is. Doesn't Will's fix work for you?

>
> I suggest modifying it this way to maintain lookup functionality for regi=
stered
> syscons while implementing your intended changes:
>
> static struct regmap *device_node_get_regmap(struct device_node *np,
>                                              bool check_res)
> {
>         struct syscon *entry, *syscon =3D NULL;
>         struct regmap *regmap;
>
>         mutex_lock(&syscon_list_lock);
>
>         list_for_each_entry(entry, &syscon_list, list)
>                 if (entry->np =3D=3D np) {
>                         syscon =3D entry;
>                         break;
>                 }
>
>         if (syscon) {
>                 regmap =3D syscon->regmap;
>                 mut ix_unlock(&syscon_list_lock);
>                 return regmap;
>         }
>
>         if (of_device_is_compatible(np, "syscon")) {
>                 syscon =3D of_syscon_register(np, check_res);
>                 mutex_unlock(&syscon_list_lock);
>                 if (IS_ERR(syscon))
>                         return ERR_CAST(syscon);
>                 return syscon->regmap;
>         }
>
>         mutex_unlock(&syscon_list_lock);

3 unlock calls is a sign the code structure could be improved. A goto
or a guard() for example. However, I think this is the same logic as
what Will suggested.

Rob

