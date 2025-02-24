Return-Path: <linux-kernel+bounces-529567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CC4A427E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33E53B1BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEED262D07;
	Mon, 24 Feb 2025 16:28:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2F6261566
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414487; cv=none; b=P3u1tNJ5KS7MM1q9Ier0vIY2IWMCokTNIIuL8UzTVKIxxhx0/uUlyzrPSaEIn1PxXm52wYUNxCAEdb/l3eYwxIMTknn/v8S7VrUxpvko+OjW8pBXMTFeExMpyEPL4Bakzi/tTz2+dPL5VxZoy6CgYMFju7V4UWX9WG6BtMlF9Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414487; c=relaxed/simple;
	bh=FaoeYT/iHjZi1G6SmKpRmaQNHEWG3shJOhqhR6BNlxo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bH5148Z4n8+O26ns/lH28hAZDQRhMrZ2DSmSz4eobrxbv7EHzLPaKYmOtzI/W3ajC9W/xL3PDlXxcwgHMeqxB/FoDgNogRa/LQQxXiCL2KUasjXToQfdRZDbet5dpUquPiCBY3vU3LDXL+h/x3Af0vyUHf2cED50Ri4Gc3XXMMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tmbIv-0005GS-HA; Mon, 24 Feb 2025 17:27:37 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tmbIu-002csr-0G;
	Mon, 24 Feb 2025 17:27:36 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tmbIu-000DzX-00;
	Mon, 24 Feb 2025 17:27:36 +0100
Message-ID: <b00aef9582e223a5770cebc714ad65168eab744b.camel@pengutronix.de>
Subject: Re: [PATCH v9 2/3] reset: aspeed: register AST2700 reset auxiliary
 bus device
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>, Ryan Chen
 <ryan_chen@aspeedtech.com>,  Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@aj.id.au>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Mon, 24 Feb 2025 17:27:35 +0100
In-Reply-To: <d5d90f03-3db8-4f90-baad-0be4f3d3e0ea@kernel.org>
References: <20250224095506.2047064-1-ryan_chen@aspeedtech.com>
	 <20250224095506.2047064-3-ryan_chen@aspeedtech.com>
	 <71cf8012-3b77-43de-b8ac-54c84a97f9d3@kernel.org>
	 <d5d90f03-3db8-4f90-baad-0be4f3d3e0ea@kernel.org>
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

On Mo, 2025-02-24 at 11:15 +0100, Krzysztof Kozlowski wrote:
> On 24/02/2025 11:12, Krzysztof Kozlowski wrote:
> > On 24/02/2025 10:55, Ryan Chen wrote:
> > > +
> > > +static void aspeed_reset_unregister_adev(void *_adev)
> > > +{
> > > +	struct auxiliary_device *adev =3D _adev;
> > > +
> > > +	auxiliary_device_delete(adev);
> > > +	auxiliary_device_uninit(adev);
> > > +}
> > > +
> > > +static void aspeed_reset_adev_release(struct device *dev)
> > > +{
> > > +	struct auxiliary_device *adev =3D to_auxiliary_dev(dev);
> > > +
> > > +	kfree(adev);
> > > +}
> > > +
> >=20
> > Every exported function *must* have kerneldoc.
> >=20
> > > +int aspeed_reset_controller_register(struct device *clk_dev, void __=
iomem *base,
> > > +				     const char *adev_name)
> > > +{
> > > +	struct auxiliary_device *adev;
> > > +	int ret;
> > > +
> > > +	adev =3D kzalloc(sizeof(*adev), GFP_KERNEL);
> > > +	if (!adev)
> > > +		return -ENOMEM;
> > > +
> > > +	adev->name =3D adev_name;
> > > +	adev->dev.parent =3D clk_dev;
> > > +	adev->dev.release =3D aspeed_reset_adev_release;
> > > +	adev->id =3D 666u;
> > > +
> > > +	ret =3D auxiliary_device_init(adev);
> > > +	if (ret) {
> > > +		kfree(adev);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret =3D auxiliary_device_add(adev);
> > > +	if (ret) {
> > > +		auxiliary_device_uninit(adev);
> > > +		return ret;
> > > +	}
> > > +
> > > +	adev->dev.platform_data =3D (__force void *)base;
> > > +
> > > +	return devm_add_action_or_reset(clk_dev, aspeed_reset_unregister_ad=
ev, adev);
> > > +}
> > > +EXPORT_SYMBOL_GPL(aspeed_reset_controller_register);
> >=20
> > No, you cannot export functions without users. There is no single user
> > of this, so this is not justified at all.
> My mistake, I missed patch #3 which uses it.
>=20
> I don't get why do you need to export this in the first place, instead
> of putting it in the clock driver, as usually expected. Handling child
> creation is logically the task of the device having children, the
> parent. Not the child.

Also, consider basing this on top of:

https://lore.kernel.org/all/20250218-aux-device-create-helper-v4-0-c3d7dfde=
a2e6@baylibre.com/

regards
Philipp

