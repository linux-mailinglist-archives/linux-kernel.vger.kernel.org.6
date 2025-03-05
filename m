Return-Path: <linux-kernel+bounces-547418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC55A506F0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DAF1173A1E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F545250BFC;
	Wed,  5 Mar 2025 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="KpRJ85NW"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB13624FBE8;
	Wed,  5 Mar 2025 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197116; cv=none; b=LKy7rzb6R8M7yNUD/OvBzEhzkeBiingix2QTZkkhQ4V1EENDjDKCp7z08aYtPJwMdN/qHqkGfuM/uhq3TKHjKB1FZ1iXsd2di8Fw8qOsX/rJEeW2xusmzJyc3nJE6WeiMo/cCihU81cCPA1B3Vy3/BiTK4qNvNFpcAjqsw2upkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197116; c=relaxed/simple;
	bh=KGHc3nvmYgVzQbmJ2PrgAgs03W9zzriGyZFlHGeWr6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saUKOibqAetUs1yBnJDBco12p7sA8P1aN3G+J8lTxWbgteu+IIdzu5WPbZf72VY/5sIrgRdaogn0az8BdtOWXsk/kUtFkVzWneP8ObYAUFxca7PXVpjRLyxFhDxSBLm/n/SIJEzJmk/I+XhAWYO4IM4Slc6bKmpB87st+k6viQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=KpRJ85NW; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=n3fedP2j29dzJv3iQBEaY09Mv/bRRJcSGOL0UIdLpZg=; b=KpRJ85NWygyAHN8HbcxaakUNFO
	ihqAWFrDoZvZSe3SuhLCxT6YmmPsamgr+rOxHYubtTj4ZNO44WafHpBCOaVzOF4DDJnnB73QCFQIX
	GwjN8YdXhA67meKqscS22p4I+iMizwIpETGqUuvZMmLVCXnMi5R2sNgtxkRJW5jWRU4LlLa49fIAG
	3TrXWVo3v26EVFt1pW28cHu8r0DiP1SNirY4lnvF6sgk5ynJ3TYZoIpF3fNnuWHrgIheZrZ/MgBas
	8ovbdMmbCBml1e8DNHxKaaTUr268Ejk/scgoABYiTiL+eTp8KtZq7w0J5EOad+NpLyAW9WeSacMJx
	nq6ghPaQ==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tpsuF-0004MI-U0; Wed, 05 Mar 2025 18:51:43 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, Yao Zi <ziyao@disroot.org>,
 Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add rk3528 QoS register node
Date: Wed, 05 Mar 2025 18:51:43 +0100
Message-ID: <3543865.CbtlEUcBR6@diego>
In-Reply-To: <20250305171724.GA2149138-robh@kernel.org>
References:
 <20250305140009.2485859-1-amadeus@jmu.edu.cn>
 <52155b03-20f3-4e64-b636-70042db03ffa@kernel.org>
 <20250305171724.GA2149138-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 5. M=C3=A4rz 2025, 18:17:24 MEZ schrieb Rob Herring:
> On Wed, Mar 05, 2025 at 04:41:23PM +0100, Krzysztof Kozlowski wrote:
> > On 05/03/2025 15:00, Chukun Pan wrote:
> > > Copy QoS nodes and add rk3528 compatible from bsp kernel,
> >=20
> > No, don't copy stuff from BSP kernel. It results in terrible DTS.
> >=20
> > > these can be used for power-domain.
> > >=20
> > > Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> > > ---
> > >  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 160 +++++++++++++++++++++=
++
> > >  1 file changed, 160 insertions(+)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/bo=
ot/dts/rockchip/rk3528.dtsi
> > > index 5b334690356a..794f35654975 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> > > @@ -122,6 +122,166 @@ gic: interrupt-controller@fed01000 {
> > >  			#interrupt-cells =3D <3>;
> > >  		};
> > > =20
> > > +		qos_crypto_a: qos@ff200000 {
> > > +			compatible =3D "rockchip,rk3528-qos", "syscon";
> > > +			reg =3D <0x0 0xff200000 0x0 0x20>;
> > > +		};
> > > +
> > > +		qos_crypto_p: qos@ff200080 {
> > > +			compatible =3D "rockchip,rk3528-qos", "syscon";
> > > +			reg =3D <0x0 0xff200080 0x0 0x20>;
> > > +		};
> >=20
> >=20
> > Did you just define syscon per few registers? Third case last weeks...
> > so no, define what is your device here. 8 registers is not a device usu=
ally.
>=20
> Well, it is just a new compatible on top of existing 'qos' compatibles.
> And in a quick scan I didn't see other things adjacent.=20

Also, those "Quality-of-Service" register-sets are generally identically and
configure the interconnect-voodoo for the individual devices they're
attached to.

And while we are not "tuning" stuff at the moment, the register contents
need to be saved and restored when the device's power-domain is
turned off or on.



