Return-Path: <linux-kernel+bounces-417048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F7B9D4E42
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62041F2307D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EBB1D90B6;
	Thu, 21 Nov 2024 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jvZ+xgWX"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09BF1D6DB5
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732197900; cv=none; b=V6ocCKUSG+wJGle6DftbusFQZTVDIavXJT/YpSUtavLj8MYut+nRkAHdY3vKhTY4WhkC8wne3t3H32bTDZIDT/VMRoPIEGPF9GhSqbxcGXV7E5dhEqEn9yOL0BLGnyucvJpaPbR5Oes6rVqWCwXKFQR5k5uFirCe2V7IwZYTjz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732197900; c=relaxed/simple;
	bh=O4nYmoel1Gexv8PujvE6jan3LXLfm0fEjCn+hI/Am/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdXfTGvrxMwEwmxes+zgSm1l+ZORf3uDoHvOvFW0RaASVy3iguFKBfLeOLGb9wukpO6zkl8X358T3d4RSfW7S4NDfQsB68WmkSTM2w8zsaqZkobule2/Dspf/qMfirkWycQK8yal4prOPcZVwZhhYRygfydjMCq+9j7NyHmMBB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jvZ+xgWX; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38231e9d518so677163f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 06:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732197896; x=1732802696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CkzzeXPDV0OuvJPIPbzu0+X4+yJU9K+UT0DlmrNc6SA=;
        b=jvZ+xgWXprQVZ4pTiH16PQu9Bm9r6JoLBxahdcktq4EWGuzzuuV7YcMxZ3Vwsb7hFg
         1KtKp/x+ksKdo9mpevQD3YOfQ6a7fXggQqavj5fZOUP8+NDi76X98WQAjAiVY1mNBelA
         wIbnIgQUBqKJ3DLk7wja/HGRQ28dTUn07eSV1r9ADt6yaIldQO9B8sybY0mM/26SHjLJ
         4sk2v0AZfAFjBk46ifjZzECFQessreAIogtZBKBNkN9zuWkl9rqU/ajcI3FEgEgpIrhL
         GnqNeI9p+hGYZJB6KRWyQsQV80aKa+xaC1k/bD60HxMquzqrPmWGQZ/Ak1Jo/FGb7ULK
         NAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732197896; x=1732802696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkzzeXPDV0OuvJPIPbzu0+X4+yJU9K+UT0DlmrNc6SA=;
        b=ePJf3FMXFF2jOcPf30pe1CNFMKm0HPX5SjkT1sjja86JXFO1m69uy1Il1CTD3IdS9i
         ID5yt3KVF4Ek5cL8/ka5taXhgOTk9KMb9Oj3UKR9rL2PfFB1RCxBneMYh9NaSApiCXH2
         Em66ZzY0wRVLtroAK7Mnz2bzNBgzQCKQbI9VGVujlEVmswolVe7G1YP/ka5g+JPIGrXr
         Nn76rQwqzKtcQehkt63fTygQ5VO+bWiGnKO1T/NCDldiVr9F4VE22/FUAxYtVyrePNuH
         pPFYMhH3TyiSM4rN3ty1KvTPD6uISgZXrfkwjKCNU1QAfae12q46hNBTCZ0Rze/ybdJm
         u5aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOk4eaTKUbBxl/M2fI4LczH2du5MMZgNoUShvdE+qugSrwEYlA+GeCfZyeAROUXv9yUqHZ7p1oKFE5Ttc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSk2ap18U/a0J3/O+uveSGPD0avhFoDjRvzyRr+4NUlucp3ijb
	yoFeMSAWbYRu8QxnGv9A8b+tMqKU56QFKVZN3fFgT6pMFRuwDz8fzZXbZTDKI/k=
X-Gm-Gg: ASbGncuPzbG1DM3EDJdt3L80ozf6A4HvHn2DpUc8/dUqS8evgstRuDvKCzKXm2kOy2E
	V3buLc41Ki1QzMsKWh4Gjt9tNfghGyOxL1OG3gfPk4bLHzbgPBDoS+R1SY7RutDY6Y0UW5CwJLN
	prWIvtXnA2Yx/J9eVHXaX3nZVYQy0eMxvX9HjeN9bW8znYAjlO+fU/+iIC4uwY/2PUTDwpQL3CJ
	ZMNimJAzU7a94loCKPl+hqHjJYbOc33XPTcLdpoMGVvRq+TT0bP5Cr80c4U3VSz0R5v8INoZQpb
	gec=
X-Google-Smtp-Source: AGHT+IGOOsfIl1JAjgf7kDd5oywzOAtVaQvQvXfPLIcz9cDfRlZE0jlhvEPwC9EtW28TdNTPrOjdyg==
X-Received: by 2002:a5d:64c6:0:b0:382:442c:2c54 with SMTP id ffacd0b85a97d-38254afc65fmr5321357f8f.28.1732197894429;
        Thu, 21 Nov 2024 06:04:54 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825490c29fsm5083350f8f.32.2024.11.21.06.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 06:04:53 -0800 (PST)
Date: Thu, 21 Nov 2024 15:04:52 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Keith Zhao <keith.zhao@starfivetech.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>, 
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, "rfoss@kernel.org" <rfoss@kernel.org>, 
	"Laurent.pinchart@ideasonboard.com" <Laurent.pinchart@ideasonboard.com>, "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org" <mripard@kernel.org>, 
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "airlied@gmail.com" <airlied@gmail.com>, 
	"simona@ffwll.ch" <simona@ffwll.ch>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"hjc@rock-chips.com" <hjc@rock-chips.com>, "heiko@sntech.de" <heiko@sntech.de>, 
	"andy.yan@rock-chips.com" <andy.yan@rock-chips.com>, William Qiu <william.qiu@starfivetech.com>, 
	Xingyu Wu <xingyu.wu@starfivetech.com>, "kernel@esmil.dk" <kernel@esmil.dk>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, 
	Changhuang Liang <changhuang.liang@starfivetech.com>, Jack Zhu <jack.zhu@starfivetech.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/9] drm: bridge: inno-hdmi: add inno bridge driver.
Message-ID: <2ujegy7cw4kka4j6rrjf7fsigk7p4hw4rkitmp4rzt33qnlhv5@c6exsgaou5x7>
References: <20241120061848.196754-1-keith.zhao@starfivetech.com>
 <20241120061848.196754-4-keith.zhao@starfivetech.com>
 <oabm3ahd6vyeirjbbmp74w3tldqkcy3de7u6avio3ohfzfns2t@vfcvn3rl23xm>
 <NTZPR01MB10504FAE3695BF54DADB7B54EE22A@NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aiaflkf5aq5b3zo3"
Content-Disposition: inline
In-Reply-To: <NTZPR01MB10504FAE3695BF54DADB7B54EE22A@NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn>


--aiaflkf5aq5b3zo3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 3/9] drm: bridge: inno-hdmi: add inno bridge driver.
MIME-Version: 1.0

On Thu, Nov 21, 2024 at 02:06:20AM +0000, Keith Zhao wrote:
>=20
>=20
> > -----Original Message-----
> > From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > Sent: 2024=E5=B9=B411=E6=9C=8820=E6=97=A5 22:56
> > To: Keith Zhao <keith.zhao@starfivetech.com>
> > Cc: devicetree@vger.kernel.org; dri-devel@lists.freedesktop.org;
> > andrzej.hajda@intel.com; neil.armstrong@linaro.org; rfoss@kernel.org;
> > Laurent.pinchart@ideasonboard.com; jernej.skrabec@gmail.com;
> > maarten.lankhorst@linux.intel.com; mripard@kernel.org;
> > tzimmermann@suse.de; airlied@gmail.com; simona@ffwll.ch;
> > robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > hjc@rock-chips.com; heiko@sntech.de; andy.yan@rock-chips.com; William Q=
iu
> > <william.qiu@starfivetech.com>; Xingyu Wu <xingyu.wu@starfivetech.com>;
> > kernel@esmil.dk; paul.walmsley@sifive.com; palmer@dabbelt.com;
> > aou@eecs.berkeley.edu; p.zabel@pengutronix.de; Changhuang Liang
> > <changhuang.liang@starfivetech.com>; Jack Zhu <jack.zhu@starfivetech.co=
m>;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v5 3/9] drm: bridge: inno-hdmi: add inno bridge dri=
ver.
> >=20
> > Hello,
> >=20
> > On Wed, Nov 20, 2024 at 02:18:42PM +0800, keith zhao wrote:
> > > +struct platform_driver inno_hdmi_driver =3D {
> > > +	.probe  =3D inno_hdmi_rockchip_probe,
> > > +	.remove_new =3D inno_hdmi_rockchip_remove,
> >=20
> > Please use .remove instead of .remove_new.
> >=20
> Thank you for the clarification regarding .remove_new.=20
> I understand that it's a relic and that new drivers should implement .rem=
ove().
>=20
> I have a question. One of the changes in this patch is to rename some fun=
ction interfaces.=20
> The original code is like this.=20
>=20
> struct platform_driver inno_hdmi_driver =3D {
> 	.probe  =3D inno_hdmi_probe,
> 	.remove_new =3D inno_hdmi_remove,
> 	.driver =3D {
> 		.name =3D "innohdmi-rockchip",
> 		.of_match_table =3D inno_hdmi_dt_ids,
> 	},
> };
>=20
> Rename inno_hdmi_probe and inno_hdmi_remove
> struct platform_driver inno_hdmi_driver =3D {
> 	.probe  =3D inno_hdmi_rockchip_probe,
> 	.remove_new =3D inno_hdmi_rockchip_remove,
> 	.driver =3D {
> 		.name =3D "innohdmi-rockchip",
> 		.of_match_table =3D inno_hdmi_dt_ids,
> 	},
> };
> Based on the principle of maintaining consistency,=20
> does it(remove_new) need to be changed?

If this isn't new code but moving from somewhere, don't change
=2Eremove_new into .remove in the same patch. If you want, fix that in a
separate patch then.

Best regards
Uwe

--aiaflkf5aq5b3zo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmc/PfgACgkQj4D7WH0S
/k5i8wf/XcvUCC2rVJqEZtMZvKrDI/ZGnH8FSDI5ZF6TzlFZ2mmT+IW/9fosKPzw
XThFPhs4q3eRJZEujqjr+ChJ7LAlLRWGFuEQtogLtwLs6PjwEtyjGNrwGbaMwGDu
GVjtp1zsGgG7utTfoUsrvnoj9ZYCMmdiHM/gwUiBMGusJHgpSRTD2M4bIAbduV8m
U6vO11pTdh0KSZgBHp4Rpj814BVjTU3prIDttOs/k9Qhq4B05ZAIOXYig/+g1k56
o+cMqaeeXMHNLE13BKRg37xkzfr4+lQX1RmfX1laQXEUhxO9Fzumyh3+NYgqZ3Rf
2JaY8G8iTmPnrSNSVtdrzpmI8Ad7OQ==
=3HIb
-----END PGP SIGNATURE-----

--aiaflkf5aq5b3zo3--

