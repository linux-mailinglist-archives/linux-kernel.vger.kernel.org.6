Return-Path: <linux-kernel+bounces-222027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8610390FBCB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B151C21A35
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E630364DC;
	Thu, 20 Jun 2024 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EekmkNqI"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FCD23774;
	Thu, 20 Jun 2024 03:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718855428; cv=none; b=pCc02WeIH48lbM2HLm4XanFDr0YYD903Zst9/S67XJudm3sJWArb5gKWIoD+VwAt3ZIvkvwgNAVPRgDgfEqZXhHUKFYAu7SP2JnINfReIuMkl1TIwkjwtcAAtlBPup9RQz7rQFLXf9r50Gi/BX/j839bfhOQLl32yxAZtSht/6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718855428; c=relaxed/simple;
	bh=ZJOXtN4OfYVM26W+iXlULySfkXzaL8UI3kfLu1F/cMk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGIFt0ZNGFmjfkaJvHbn5MzP7X9BAjWrUiJWJYkhf+krdXb8oNAtVHWBi2U9hi/qBGVYZuP+sK/mH/KRiwrCmd6E/RL014PaMCNfSpBnqqO9CVn3H5BA/2Wn4lAkCwaZsNrcbbZPC7YjyZf/4qANTaNLqk+GSj8OcW5ZDdGzlx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EekmkNqI; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 340FA240004;
	Thu, 20 Jun 2024 03:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718855417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JN8Yyr6hltrGEwaFbbPFBck2MIdSHozdx35CMh8gZXE=;
	b=EekmkNqIk2mPGfzybZt8IeBozFPs//bSNImRlf3ocz83y2WQ+AAx7a6boUN0e2a0Id56rB
	2KCwwaM6DSiaRqW5zTFZmfUo9D/zoynEJoreWvcO0V+cQaLjOXVQeI9rXpKvywSUZK3jAh
	3Wa/+ZzyHLCdqrxgm4Bv9ZoHwbkYzFOMW7k1nlvmkWaetGxhd6FNZae4khO7tVaeUBaeE2
	yJx/5jGXw8r3u7kUWfX0GeRlyrsq34sQ3Lvs2wD4yPWjBcpxj0zysRLG5uVWS6m8TAf37B
	a+ZF7p+nRf3g5kfrx3QDU9f2mbbkivokaafl/DUUg5rnRDd3etaf5A+Wj96oKg==
Date: Thu, 20 Jun 2024 05:50:06 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, Antoine Tenart
 <atenart@kernel.org>
Subject: Re: [PATCH net-next v13 07/13] net: ethtool: Introduce a command to
 list PHYs on an interface
Message-ID: <20240620055006.57337c52@fedora>
In-Reply-To: <20240613181812.27d02c88@kernel.org>
References: <20240607071836.911403-1-maxime.chevallier@bootlin.com>
	<20240607071836.911403-8-maxime.chevallier@bootlin.com>
	<20240613181812.27d02c88@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Jakub,

Sorry about the late reply on that one, I'll follow-up with a new
version shortly.

On Thu, 13 Jun 2024 18:18:12 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri,  7 Jun 2024 09:18:20 +0200 Maxime Chevallier wrote:
> > +                                                it's parent PHY throug=
h an SFP =20
>=20
> its

good catch, thanks !

>=20
> > +static int ethnl_phy_parse_request(struct ethnl_req_info *req_base,
> > +				   struct nlattr **tb)
> > +{
> > +	struct phy_link_topology *topo =3D req_base->dev->link_topo;
> > +	struct phy_req_info *req_info =3D PHY_REQINFO(req_base);
> > +	struct phy_device_node *pdn;
> > +
> > +	if (!req_base->phydev)
> > +		return 0;
> > +
> > +	if (!topo)
> > +		return 0;
> > +
> > +	pdn =3D xa_load(&topo->phys, req_base->phydev->phyindex);
> > +	memcpy(&req_info->pdn, pdn, sizeof(*pdn)); =20
>=20
> > +	xa_for_each_start(&dev->link_topo->phys, ctx->phy_index, pdn, ctx->ph=
y_index) {
> > +		ehdr =3D ethnl_dump_put(skb, cb, ETHTOOL_MSG_PHY_GET_REPLY);
> > +		if (!ehdr) {
> > +			ret =3D -EMSGSIZE;
> > +			break;
> > +		}
> > +
> > +		ret =3D ethnl_fill_reply_header(skb, dev, ETHTOOL_A_PHY_HEADER);
> > +		if (ret < 0) {
> > +			genlmsg_cancel(skb, ehdr);
> > +			break;
> > +		}
> > +
> > +		memcpy(&pri->pdn, pdn, sizeof(*pdn)); =20
>=20
> Why do you copy the pdn each time =F0=9F=A4=94=EF=B8=8F

Now that you mention that, I think I don't need to. This dates back
from when I was trying to use the ethnl helpers, where I would keep a
copy of the pdn in the request context, between the parse / reply_size
/ fill_reply steps. I then used the same fill_reply in the dump path.

Now that the code has moved away from the ethnl scaffolding I can
indeed rework that so I can use the actual pdn and not a copy of it.

Thanks for pointing it out.

> > +	return ret;
> > +}
> > + =20
>=20
> double new line at the end

I'll fix that.

Thanks,

Maxime

