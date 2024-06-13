Return-Path: <linux-kernel+bounces-213067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDCE906A91
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618DF1C2242A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D8E1428F5;
	Thu, 13 Jun 2024 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="UzwupdY/"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8D313D534;
	Thu, 13 Jun 2024 10:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276321; cv=none; b=tldWYsjfVwt8bE3+LipC9lcA0UVe/SAOHQp9csN6MA7UgCkC22fm/vINm0JDpm9geVAUnQ13MgORkCzykY01qkGfkip4kG/W4DsboqdRRu5483eFj4z/+0anNZAQmx8EUm2BkT7N/aAModjUm0mEuT3PdKCDbEBwcgJeOdLSWgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276321; c=relaxed/simple;
	bh=xn1NLopsPGDM9FSzN8JBsWn2CIEUUIIf+VQzj4DUEF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIJ4nWDNvC8FZo4CB/lcvTY8r45SbzzGZPcUTTJq06spSmmH4qE2SBt0Qn73rmhFYF2HBjGt6E/gaIqgBvVfl7syfeftq0OVqn0dO5tl5l31GSr1LUFxo9IHoz4DvzZmcj+BmQ24++4OXFvE+d9k1fdvuKR8bl+EzJPMy8LKQJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=UzwupdY/; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3E1051C0082; Thu, 13 Jun 2024 12:58:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1718276317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6QQ5va+aQlfb/vFalaHPg5H34Qi6y4ixcQX/yxfzk4Y=;
	b=UzwupdY/Ac2rvSWK4CcDb7IHw17P1YQfhSJeFe5Eiaf5ZQnXaNRH7FLMZMq4nUB4esdAa1
	MdXvLUELmlq3RYK5tK03k0Oxba9oFa+to0qIHHQ4OMxwsVhOqHkw0+qZBpXenPrb/YRxzd
	m1khVbAGHM8KN8XWo17biXMw9eDXRiE=
Date: Thu, 13 Jun 2024 12:58:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jason-ch Chen <jason-ch.chen@mediatek.com>,
	Singo Chang <singo.chang@mediatek.com>,
	Nancy Lin <nancy.lin@mediatek.com>,
	Shawn Sung <shawn.sung@mediatek.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	Jason-jh Lin <jason-jh.lin@mediatek.corp-partner.google.com>
Subject: Re: [PATCH RESEND,v6 0/8] Add CMDQ secure driver for SVP
Message-ID: <ZmrQ3NWxwy8719Vr@duo.ucw.cz>
References: <20240526144443.14345-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ugZqD1PtgeGMHeh"
Content-Disposition: inline
In-Reply-To: <20240526144443.14345-1-jason-jh.lin@mediatek.com>


--0ugZqD1PtgeGMHeh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2024-05-26 22:44:35, Jason-JH.Lin wrote:
> From: Jason-jh Lin <jason-jh.lin@mediatek.corp-partner.google.com>
>=20
> For the Secure Video Path (SVP) feature, inculding the memory stored
> secure video content, the registers of display HW pipeline and the
> HW configure operations are required to execute in the secure world.

This feature goes against interests of hardware users/owners. We
should not merge this.
								Pavel
							=09
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--0ugZqD1PtgeGMHeh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmrQ3AAKCRAw5/Bqldv6
8hagAJ91OcdTYdDnoCizlMOqRMmJHUnS9QCcDaoEoZdKMTlzCo9uoGaVA2KHcyI=
=iTbB
-----END PGP SIGNATURE-----

--0ugZqD1PtgeGMHeh--

