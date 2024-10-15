Return-Path: <linux-kernel+bounces-365470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CC099E2C9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3401F22EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7622E1DDA1C;
	Tue, 15 Oct 2024 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ugvlkZSB"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684921DD87C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984551; cv=none; b=GNduLR/nHyXnzZyKhSq22KMHQpTtZob9nS96wKzIyL2CrWWd0d+X34DZnBGywQ3Od909nEyiTlXZy+NIMtv14BoD2iPrLqFQlYoE+y4Id58Lo5E9krvVWI5mYr5B7YX0611AmVGdslZR1amfUXcn3Geo87Zj/hNeTtGqSOMAE84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984551; c=relaxed/simple;
	bh=bCLG78Crh1GV3W/EPM8qgwmgL0SdLg/aiH/Acy7F8hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr1ytnLK59liad3Afyy/zVXnnxHUi48RlEM3My2WiBwixpZcvNGXaGE7VFBGwtXMg2aU9GaDHFHDwc7NyoDHnB/3NrEp7einM4sQywBnnisnXRCFUqBbDAcncBgbgx6vhKsyonpvehgx/nCEfJuyt0hmRAUSco5thdp69PIFxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ugvlkZSB; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso193433166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 02:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728984548; x=1729589348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OWJKpUrFWHTmjBFhSr4sJy91PPpf78i3mxt/gZRMktI=;
        b=ugvlkZSBgM2EdiPWE7geoIFcgh1EcQ6L+9dJpoufHeIyhtmVx3Gvwpqn/VuLB11PW4
         FboWyrY6IANn6IADVD0HtKFO7O9VoGhHQXadAFZC7CJ8/qCXNCRBwCtptkoYjee/Mawz
         UlfaMDMs3Js6AlKbTbJgMmma4PdAU+7idhLQWRGONEeAq8MKiSRGevQpC4pxIdPzszsG
         5aoCabHwoSoW8/7yP1H+h2F8Qx4ybYPCbRTdoc20kxlRO6S/wZGnkAItJyScDE9zBlA7
         Ml6Yr01OHNJq1THhjjUcApSEP/dAsELy0dXnZvSLoPMhYyeo8Bs4y4qOst/MTd8SwoE6
         IiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728984548; x=1729589348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWJKpUrFWHTmjBFhSr4sJy91PPpf78i3mxt/gZRMktI=;
        b=wPyF7BED8GbnwCwUE4s2xrsKEqaUoXlWL3/LRNgSyOmDy7A0TQk/new46F/LU9xU4J
         +J9xiFW3Gm1qClTUkWIRHrtAfnoAC4oDTi3TIOaxNsJiVFHp4VyTIxya1J3TGKVkQWNV
         VA9/XxDYQ50+7vK2I6i/H4zJTTsiflquOjqGL3d8sghjD0V/XmsCtAEMoksRv0fSLciN
         yHkHd6AEDWMenKyeQnfsIaRCMKoWL0BU8STwzo7lFss1AnYfrS8okUxSZLHdbY4oKlmV
         yqiA0INapEb8pSyeFdyh0fw+lF5QDyu7Phgp7Rb0nTpzOtnaKOItN5Yar7kr1Qm8pVw7
         Ifcg==
X-Forwarded-Encrypted: i=1; AJvYcCX5Q9gNzzq5Ht/riw3zz1ntC8M4z2wpRajlKks3NvJ+02MDnlidbKic3QlDpUhA4x1d/g93dwW4GId0mOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvRG21RXc1JsP+kEbcgSWVNYW6T2EV1qfeuoGZhDgzw7PvOfoL
	wyHnKLhcc5Bo68daQUpIJWbjOSAyQcDuPMFFzymPw8zttIdLOJKszp2XRVEI4hA=
X-Google-Smtp-Source: AGHT+IHhDRrwVFp1FuLVzTq/ELrnulygcAtatsQHXYywZMyik2rtIMFq7W699nFoGF/PuVejr/bvkg==
X-Received: by 2002:a17:907:36c8:b0:a99:89e9:a43d with SMTP id a640c23a62f3a-a99b940f030mr1499224466b.39.1728984547676;
        Tue, 15 Oct 2024 02:29:07 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:c75a:6d73:cead:b69a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29749663sm48451766b.64.2024.10.15.02.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 02:29:06 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:29:06 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
	Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v3 5/9] can: m_can: Support pinctrl wakeup state
Message-ID: <lujsghq3lc2zb5kxdsfgqf4wucv7pre7w7x2oy2yua34a72ovd@de5ehdizo4d2>
References: <20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com>
 <20241011-topic-mcan-wakeup-source-v6-12-v3-5-9752c714ad12@baylibre.com>
 <CAMZ6Rq+E-0jdPHTwB0z0XKkz+UqhQVqT6ghPF21WFF0ZWc3-HA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="palodu6usplwdhau"
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+E-0jdPHTwB0z0XKkz+UqhQVqT6ghPF21WFF0ZWc3-HA@mail.gmail.com>


--palodu6usplwdhau
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 09:27:08PM GMT, Vincent MAILHOL wrote:
> On Fri. 11 Oct. 2024 at 22:19, Markus Schneider-Pargmann
> <msp@baylibre.com> wrote:
> > am62 requires a wakeup flag being set in pinctrl when mcan pins acts as
> > a wakeup source. Add support to select the wakeup state if WOL is
> > enabled.
> >
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> >  drivers/net/can/m_can/m_can.c | 60 +++++++++++++++++++++++++++++++++++=
++++++++
> >  drivers/net/can/m_can/m_can.h |  4 +++
> >  2 files changed, 64 insertions(+)
> >
> > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> > index 5ab0bb3f1c71e7dc4d6144f7b9e8f58d0e0303fe..c56d61b0d20b05be36c95ec=
4a6651b0457883b66 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -2196,6 +2196,7 @@ static void m_can_get_wol(struct net_device *dev,=
 struct ethtool_wolinfo *wol)
> >  static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinf=
o *wol)
> >  {
> >         struct m_can_classdev *cdev =3D netdev_priv(dev);
> > +       struct pinctrl_state *new_pinctrl_state =3D NULL;
> >         bool wol_enable =3D !!wol->wolopts & WAKE_PHY;
> >         int ret;
> >
> > @@ -2212,7 +2213,28 @@ static int m_can_set_wol(struct net_device *dev,=
 struct ethtool_wolinfo *wol)
> >                 return ret;
> >         }
> >
> > +       if (wol_enable)
> > +               new_pinctrl_state =3D cdev->pinctrl_state_wakeup;
> > +       else
> > +               new_pinctrl_state =3D cdev->pinctrl_state_default;
> > +
> > +       if (IS_ERR_OR_NULL(new_pinctrl_state))
> > +               return 0;
> > +
> > +       ret =3D pinctrl_select_state(cdev->pinctrl, new_pinctrl_state);
> > +       if (ret) {
> > +               netdev_err(cdev->net, "Failed to select pinctrl state %=
pE\n",
> > +                          ERR_PTR(ret));
> > +               goto err_wakeup_enable;
> > +       }
> > +
> >         return 0;
> > +
> > +err_wakeup_enable:
> > +       /* Revert wakeup enable */
> > +       device_set_wakeup_enable(cdev->dev, !wol_enable);
> > +
> > +       return ret;
> >  }
> >
> >  static const struct ethtool_ops m_can_ethtool_ops_coalescing =3D {
> > @@ -2380,7 +2402,45 @@ struct m_can_classdev *m_can_class_allocate_dev(=
struct device *dev,
> >
> >         m_can_of_parse_mram(class_dev, mram_config_vals);
> >
> > +       class_dev->pinctrl =3D devm_pinctrl_get(dev);
> > +       if (IS_ERR(class_dev->pinctrl)) {
> > +               ret =3D PTR_ERR(class_dev->pinctrl);
> > +
> > +               if (ret !=3D -ENODEV) {
> > +                       dev_err_probe(dev, ret, "Failed to get pinctrl\=
n");
> > +                       goto err_free_candev;
> > +               }
> > +
> > +               class_dev->pinctrl =3D NULL;
> > +       } else {
> > +               class_dev->pinctrl_state_wakeup =3D
> > +                       pinctrl_lookup_state(class_dev->pinctrl, "wakeu=
p");
> > +               if (IS_ERR(class_dev->pinctrl_state_wakeup)) {
> > +                       ret =3D PTR_ERR(class_dev->pinctrl_state_wakeup=
);
> > +                       ret =3D -EIO;
>=20
> Here, ret is set twice, and the second time, it is unconditionally set
> to -EIO...

Thank you, this was a left-over from testing this error path.

>=20
> > +                       if (ret !=3D -ENODEV) {
>=20
> ... so isn't this check always true?
>=20
> > +                               dev_err_probe(dev, ret, "Failed to look=
up pinctrl wakeup state\n");
> > +                               goto err_free_candev;
> > +                       }
> > +
> > +                       class_dev->pinctrl_state_wakeup =3D NULL;
> > +               } else {
> > +                       class_dev->pinctrl_state_default =3D
> > +                               pinctrl_lookup_state(class_dev->pinctrl=
, "default");
> > +                       if (IS_ERR(class_dev->pinctrl_state_default)) {
> > +                               ret =3D PTR_ERR(class_dev->pinctrl_stat=
e_default);
> > +                               dev_err_probe(dev, ret, "Failed to look=
up pinctrl default state\n");
> > +                               goto err_free_candev;
> > +                       }
> > +               }
> > +       }
> > +
> >         return class_dev;
> > +
> > +err_free_candev:
> > +       free_candev(net_dev);
> > +       return ERR_PTR(ret);
>=20
> Here, you have three levels of nested if/else. It took me a bit of
> effort to read and understand the logic. Wouldn't it be better to do
> some early return at the end of each of the if branches in order to
> remove the nesting? I am thinking of this:
>=20
>           class_dev->pinctrl =3D devm_pinctrl_get(dev);
>           if (IS_ERR(class_dev->pinctrl)) {
>                   ret =3D PTR_ERR(class_dev->pinctrl);
>=20
>                   if (ret !=3D -ENODEV) {
>                           dev_err_probe(dev, ret, "Failed to get pinctrl\=
n");
>                           goto err_free_candev;
>                   }
>=20
>                   class_dev->pinctrl =3D NULL;
>                   return class_dev;
>           }
>=20
>           class_dev->pinctrl_state_wakeup =3D
> pinctrl_lookup_state(class_dev->pinctrl, "wakeup");
>           if (IS_ERR(class_dev->pinctrl_state_wakeup)) {
>                   ret =3D PTR_ERR(class_dev->pinctrl_state_wakeup);
>                   dev_err_probe(dev, ret, "Failed to lookup pinctrl
> wakeup state\n");
>                   goto err_free_candev;
>           }

Thanks, yes you are right this is easier to read, but I don't want to do
it like this in the m_can_class_allocate_dev() function to keep the code
flow through the whole function and avoid early successful returns.
Instead I moved this to a separate function called
m_can_class_setup_optional_pinctrl(), doing it similarly to your
suggestion.

Best
Markus

>=20
>           class_dev->pinctrl_state_default =3D
> pinctrl_lookup_state(class_dev->pinctrl, "default");
>           if (IS_ERR(class_dev->pinctrl_state_default)) {
>                   ret =3D PTR_ERR(class_dev->pinctrl_state_default);
>                   dev_err_probe(dev, ret, "Failed to lookup pinctrl
> default state\n");
>                   goto err_free_candev;
>           }
>=20
>           return class_dev;
>=20
>   err_free_candev:
>           free_candev(net_dev);
>           return ERR_PTR(ret);
>=20
> >  }
> >  EXPORT_SYMBOL_GPL(m_can_class_allocate_dev);
> >
> > diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_ca=
n.h
> > index 92b2bd8628e6b31370f4accbc2e28f3b2257a71d..b75b0dd6ccc93973d0891da=
ac07c92b61f81dc2a 100644
> > --- a/drivers/net/can/m_can/m_can.h
> > +++ b/drivers/net/can/m_can/m_can.h
> > @@ -126,6 +126,10 @@ struct m_can_classdev {
> >         struct mram_cfg mcfg[MRAM_CFG_NUM];
> >
> >         struct hrtimer hrtimer;
> > +
> > +       struct pinctrl *pinctrl;
> > +       struct pinctrl_state *pinctrl_state_default;
> > +       struct pinctrl_state *pinctrl_state_wakeup;
> >  };
> >
> >  struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, in=
t sizeof_priv);
> >
> > --
> > 2.45.2
> >
> >

--palodu6usplwdhau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd8KHufh7XoFiu4kEkjLTi1BWuPwUCZw412QAKCRAkjLTi1BWu
P57tAP4uuV9yJ6+QzXueKq4WAPFsyaynsHEldo+v67KWm4fFzwEA6Yx3HTEO98Pa
JU9jn2FQX6sU5iUmcPYwRNBH8T4dvQ0=
=z4Lx
-----END PGP SIGNATURE-----

--palodu6usplwdhau--

