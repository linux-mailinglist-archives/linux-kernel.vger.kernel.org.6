Return-Path: <linux-kernel+bounces-339438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7100B98650D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39138285C13
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD707482C1;
	Wed, 25 Sep 2024 16:43:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D991D5ABD
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282594; cv=none; b=G708Fy5SYOin/paP4Xuq1b7+xitgrTS8/PUmsEL5/OFiG5ja+XcZpSKYFRElLB7LRMZ5DaVtLpag1eATrqYlrWzaXUxmKKkhCKqD67k8UyUciRGtE+QZLq99AYPzSFn4H/sEXw7GE+MMuBv0ScWKgiqGcXoTfwcWdQcsceFK2Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282594; c=relaxed/simple;
	bh=r/HE06i+a78kjsVYnCO5zmsL5Jezsj+SnykMbJrZ+Q4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=th3LPHTnqm/Kh3TSnmrnwyJEjLFieNMrr62FRBPuAiB5j0Ws4pNCSYN3kRIu5zpHB1se/+2h0rrZzqARreTNWOcJFRJfxLlhyxC/4QCoCVcL7s1WCmzNspqHDanpZLUFNAIB23h2C36gTbyzeD40uXjR0qbZH2fYawUuhm0ugiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1stV6X-0004ik-9N; Wed, 25 Sep 2024 18:43:05 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1stV6V-001UVF-VX; Wed, 25 Sep 2024 18:43:03 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1stV6V-000PDk-2v;
	Wed, 25 Sep 2024 18:43:03 +0200
Message-ID: <e4319d3b058b8c90436b4401449e028f5e6c209e.camel@pengutronix.de>
Subject: Re: [PATCH RFC 1/3] reset: replace boolean parameters with flags
 parameter
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>,  Geert Uytterhoeven
 <geert+renesas@glider.be>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  kernel@pengutronix.de
Date: Wed, 25 Sep 2024 18:43:03 +0200
In-Reply-To: <hdw5pdty3kwvaxh2hluvx7ia7cygmglcgiee3j6nxcyywtmkcx@dqebckl4h3rz>
References: <20240621-reset-get-deasserted-v1-0-94ee76fb7b7d@pengutronix.de>
	 <20240621-reset-get-deasserted-v1-1-94ee76fb7b7d@pengutronix.de>
	 <o3rf7gprs7mrldglqg7e4scibumdno36iuvtlr3c43sofjcb2t@w3d7jsjyddxe>
	 <5500e3d44be69f5bc843e5b2159f6d0aead24ff9.camel@pengutronix.de>
	 <hdw5pdty3kwvaxh2hluvx7ia7cygmglcgiee3j6nxcyywtmkcx@dqebckl4h3rz>
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

On Mi, 2024-09-25 at 16:25 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Philipp,
>=20
> On Wed, Jun 26, 2024 at 06:17:11PM +0200, Philipp Zabel wrote:
> > On Sa, 2024-06-22 at 09:47 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Fri, Jun 21, 2024 at 04:45:02PM +0200, Philipp Zabel wrote:
> > > > @@ -999,8 +1001,9 @@ static struct reset_controller_dev *__reset_fi=
nd_rcdev(const struct of_phandle_a
> > > > =20
> > > >  struct reset_control *
> > > >  __of_reset_control_get(struct device_node *node, const char *id, i=
nt index,
> > > > -		       bool shared, bool optional, bool acquired)
> > > > +		       enum reset_control_flags flags)
> > > >  {
> > > > +	bool optional =3D flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
> > > >  	bool gpio_fallback =3D false;
> > > >  	struct reset_control *rstc;
> > > >  	struct reset_controller_dev *rcdev;
> > > > @@ -1065,7 +1068,7 @@ __of_reset_control_get(struct device_node *no=
de, const char *id, int index,
> > > >  	}
> > > > =20
> > > >  	/* reset_list_mutex also protects the rcdev's reset_control list =
*/
> > > > -	rstc =3D __reset_control_get_internal(rcdev, rstc_id, shared, acq=
uired);
> > > > +	rstc =3D __reset_control_get_internal(rcdev, rstc_id, flags);
> > >=20
> > > If RESET_CONTROL_FLAGS_BIT_OPTIONAL was passed to
> > > __of_reset_control_get(), you're forwarding it to
> > > __reset_control_get_internal(). But the latter doesn't do anything wi=
th
> > > that flag. I wonder if the API would be still less prone to error if
> > > you'd filter out RESET_CONTROL_FLAGS_BIT_OPTIONAL before passing to
> > > __reset_control_get_internal() and in __reset_control_get_internal() =
add
> > > a check for unsupported flags.
> >=20
> > Yes, I'll do that. For every enum value with the optional bit set,
> > there is a corresponding value without it.
>=20
> Do you have this still on your todo list? I just review a pwm driver
> that would benefit from devm_reset_control_get_exclusive_deasserted().

Thanks for the reminder, just sent a v2.

regards
Philipp

