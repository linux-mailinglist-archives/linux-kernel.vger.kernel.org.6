Return-Path: <linux-kernel+bounces-231174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505F891871E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036141F22BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F76318EFCA;
	Wed, 26 Jun 2024 16:17:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3DA6E611
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418646; cv=none; b=KotQDG+5WE3tqDJaxbP8UEIu67NZ+A6ltyFz3vRP+qdgH9BI4X0Xa+DyMhnA8Mp6wGUQSf+pwYWDFuq9gMb24rmpTxLaZl7o+YyTYgNsLLa7C64soF71DP0uo7AUEd2R7ePubluEznFvAlhPjl66EYRmNZwTZMl11cp8cTb0XNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418646; c=relaxed/simple;
	bh=GwAi6zqoaV4pJ798T1tU40n9yaG2QPacobbro6Ag6/M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sg10acHq64iPTXiAGY5nQz5VOWD+TqSohuWXZXWbwMUVY2PMVzrHca6myreBVKYjD38Nh0ET2BfXb35X/SKOkE3IE3K/F4x4EeZAY09MHlz3lCHa2s7nm0DPihOzneuDSqP+q5bCXmb4iZolOltWkp4tcH6Y1udDU5hl08Hdg6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sMVKc-0008Dt-Ad; Wed, 26 Jun 2024 18:17:14 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sMVKa-005ASZ-1K; Wed, 26 Jun 2024 18:17:12 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sMVKZ-000FZ7-39;
	Wed, 26 Jun 2024 18:17:11 +0200
Message-ID: <5500e3d44be69f5bc843e5b2159f6d0aead24ff9.camel@pengutronix.de>
Subject: Re: [PATCH RFC 1/3] reset: replace boolean parameters with flags
 parameter
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>,  Geert Uytterhoeven
 <geert+renesas@glider.be>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  kernel@pengutronix.de
Date: Wed, 26 Jun 2024 18:17:11 +0200
In-Reply-To: <o3rf7gprs7mrldglqg7e4scibumdno36iuvtlr3c43sofjcb2t@w3d7jsjyddxe>
References: <20240621-reset-get-deasserted-v1-0-94ee76fb7b7d@pengutronix.de>
	 <20240621-reset-get-deasserted-v1-1-94ee76fb7b7d@pengutronix.de>
	 <o3rf7gprs7mrldglqg7e4scibumdno36iuvtlr3c43sofjcb2t@w3d7jsjyddxe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Uwe,

On Sa, 2024-06-22 at 09:47 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Philipp,
>=20
> I like the idea in general. Just a detail concern down below.

Thank you, much appreciated.

> On Fri, Jun 21, 2024 at 04:45:02PM +0200, Philipp Zabel wrote:
> > @@ -999,8 +1001,9 @@ static struct reset_controller_dev *__reset_find_r=
cdev(const struct of_phandle_a
> > =20
> >  struct reset_control *
> >  __of_reset_control_get(struct device_node *node, const char *id, int i=
ndex,
> > -		       bool shared, bool optional, bool acquired)
> > +		       enum reset_control_flags flags)
> >  {
> > +	bool optional =3D flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
> >  	bool gpio_fallback =3D false;
> >  	struct reset_control *rstc;
> >  	struct reset_controller_dev *rcdev;
> > @@ -1065,7 +1068,7 @@ __of_reset_control_get(struct device_node *node, =
const char *id, int index,
> >  	}
> > =20
> >  	/* reset_list_mutex also protects the rcdev's reset_control list */
> > -	rstc =3D __reset_control_get_internal(rcdev, rstc_id, shared, acquire=
d);
> > +	rstc =3D __reset_control_get_internal(rcdev, rstc_id, flags);
>=20
> If RESET_CONTROL_FLAGS_BIT_OPTIONAL was passed to
> __of_reset_control_get(), you're forwarding it to
> __reset_control_get_internal(). But the latter doesn't do anything with
> that flag. I wonder if the API would be still less prone to error if
> you'd filter out RESET_CONTROL_FLAGS_BIT_OPTIONAL before passing to
> __reset_control_get_internal() and in __reset_control_get_internal() add
> a check for unsupported flags.

Yes, I'll do that. For every enum value with the optional bit set,
there is a corresponding value without it.

> >  out_unlock:
> >  	mutex_unlock(&reset_list_mutex);
> > @@ -1096,8 +1099,9 @@ __reset_controller_by_name(const char *name)
> > =20
> >  static struct reset_control *
> >  __reset_control_get_from_lookup(struct device *dev, const char *con_id=
,
> > -				bool shared, bool optional, bool acquired)
> > +				enum reset_control_flags flags)
> >  {
> > +	bool optional =3D flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
> >  	const struct reset_control_lookup *lookup;
> >  	struct reset_controller_dev *rcdev;
> >  	const char *dev_id =3D dev_name(dev);
> > [...]
> > @@ -1422,7 +1423,7 @@ EXPORT_SYMBOL_GPL(of_reset_control_array_get);
> >   * Returns pointer to allocated reset_control on success or error on f=
ailure
> >   */
> >  struct reset_control *
> > -devm_reset_control_array_get(struct device *dev, bool shared, bool opt=
ional)
> > +devm_reset_control_array_get(struct device *dev, enum reset_control_fl=
ags flags)
> >  {
> >  	struct reset_control **ptr, *rstc;
> > =20
> > @@ -1431,7 +1432,7 @@ devm_reset_control_array_get(struct device *dev, =
bool shared, bool optional)
> >  	if (!ptr)
> >  		return ERR_PTR(-ENOMEM);
> > =20
> > -	rstc =3D of_reset_control_array_get(dev->of_node, shared, optional, t=
rue);
> > +	rstc =3D of_reset_control_array_get(dev->of_node, flags);
>=20
> Is it an error if the new devm_reset_control_array_get() is called
> without RESET_CONTROL_FLAGS_BIT_ACQUIRED in flags?

I'd be inclined to consider this not-an-error.

There is one user of of_reset_control_array_get_exclusive_released(),
so it should work in theory. Of course nobody is using both devres and
the acquire/release API at the same time, and there is no
devm_reset_control_array_get_exclusive_released() wrapper.

regards
Philipp

