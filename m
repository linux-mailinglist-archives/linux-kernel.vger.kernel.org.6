Return-Path: <linux-kernel+bounces-317037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF11B96D879
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586FA1F275F7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543B719DFB4;
	Thu,  5 Sep 2024 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="NTLxT0LD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="pgblQ76n"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C94817AE1C;
	Thu,  5 Sep 2024 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539063; cv=none; b=m8u5xQx8+gJCLflNuy0FdQDheSXw0S9+RSodqXqJQWHRZ7sqCqp4i0cLTAI3MltO9YCTPnkbpYdLn8g7+3yK5CQ3+4RnJejsrZ4Fj1KwQozj5RpzZUmacpU8t8eofA9hcH0NZIhANXn7Xtat7YgFYtHNG8x18qNDvrR/5tTtfYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539063; c=relaxed/simple;
	bh=ORe+nGeojFGS93jL8TIXAvrBhqYIikB++xOBbHbsStw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHE38fccexo93OD5jalYIIwUJBstCQn5BJFThMjsQYva6TmrplpaAnWnFJfwkevL7WuJIXXLGQNWZDo0X2Lt7HoEe7K1Ohh1zi+6d6Lru9WKhlNWpbXXzgaYDglkvSUzzT7tqe7XKtdDAe6w1iUQs0tdKlIbyTCLtOLndhjR4C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=NTLxT0LD; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=pgblQ76n reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1725539061; x=1757075061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/A+189mhNbtv/u38KE9rtkmb5PippzrNIWSdIiKCgTA=;
  b=NTLxT0LDH9Atksj8Vikjspt2fYvTnBK3lojVX5gbDDRsjHziRbFkqMmZ
   jU/2jgPafc419oceC+qK/0iH4zq4YLKl90bAAilzBU39bDjLXTs2JGLeL
   KI1sxSpuDMYau/BlxlAKIX7s4mFJ4rnNBHbknogpiU26Kb0OPfXPWRtz8
   aEwgF1fVtIllHpQ27x0LgWctlyNTujvlJKIoVucSIMIcXrnAbau8yTyns
   FPkMjrIMFx0SC88ZvoEem3WngQxNJtOwzQl21TcQFtoWqBnaOZ+8pznm7
   CoOGHV9NskpSoLm915ABKMFM9D+VrV2fKr5PwutUGGixwtcFHN+4Z4ZZV
   A==;
X-CSE-ConnectionGUID: rxT9gy72RZ65/l28WT6jOw==
X-CSE-MsgGUID: YXTD4FepRMOXZY0Cg44WHg==
X-IronPort-AV: E=Sophos;i="6.10,204,1719871200"; 
   d="scan'208";a="38787660"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 05 Sep 2024 14:24:18 +0200
X-CheckPoint: {66D9A2F2-25-5FF8EC80-F6CEE9F8}
X-MAIL-CPID: 3DF7ED1CB9DD42C81279A41760AB2AF1_0
X-Control-Analysis: str=0001.0A782F1F.66D9A2F2.0120,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6ADD216AB67;
	Thu,  5 Sep 2024 14:24:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1725539054;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/A+189mhNbtv/u38KE9rtkmb5PippzrNIWSdIiKCgTA=;
	b=pgblQ76nhBwf0K4ZOoScOfVQAFiXz551ec7EO0DAKPXgxK3K7kBxRAgLRH0vT2SBsbwPzE
	nQAOXrWV18Az8ehcwThjPBHdj8ymiQv13l/8ZsS792b4fweo95aYXQLtctfsnXRAUQ8Edm
	zEyRc7mHtg7ADo/oBGrHPLjxkvNlLVHwcPFcKavI2tmwFu+XWuIugdzzBuPETxAoi5Yoxs
	f+G/qEOKTvQV/o6WrxRSPiS3BmO/cxm2FI2AKBs8904mNF5A8V3/OaVuZ/vPx4HMSsdaaS
	2ZLHUoUAqSXRcMkNhA5vpINf+agMtUNaH7m2wM6FFQd+pHzf6CoNkj4teKGEYQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: Re: [PATCH v2 3/7] arm64: dts: freescale: imx95: update a55 thermal trip points
Date: Thu, 05 Sep 2024 14:24:13 +0200
Message-ID: <3587078.iIbC2pHGDl@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240903-imx95-dts-new-v2-3-8ed795d61358@nxp.com>
References: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com> <20240903-imx95-dts-new-v2-3-8ed795d61358@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Dienstag, 3. September 2024, 09:17:48 CEST schrieb Peng Fan (OSS):
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Update the thermal trip points for automotive and extended industrial
> temperature qualification processors.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/d=
ts/freescale/imx95.dtsi
> index 314a45e82c38..2cba7a889030 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -347,13 +347,13 @@ a55-thermal {
> =20
>  			trips {
>  				cpu_alert0: trip0 {
> -					temperature =3D <85000>;
> +					temperature =3D <105000>;
>  					hysteresis =3D <2000>;
>  					type =3D "passive";
>  				};
> =20
>  				cpu_crit0: trip1 {
> -					temperature =3D <95000>;
> +					temperature =3D <125000>;

What about commercial and industrial temperature ranges? Can you detected
this at runtime? Is the bootloader supposed to correct these settings?

Best regards,
Alexander

>  					hysteresis =3D <2000>;
>  					type =3D "critical";
>  				};
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



