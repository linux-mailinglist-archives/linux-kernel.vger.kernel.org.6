Return-Path: <linux-kernel+bounces-379247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202749ADBFE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5C71C21C80
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221DF17B51A;
	Thu, 24 Oct 2024 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="HYF0Z+B3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="rfGPZviW"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AAC158862;
	Thu, 24 Oct 2024 06:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750803; cv=none; b=PCaHfENq/jW6h5nN/69e3n8wEAQBf4Mq+8x8s4YuRBQ2M+9+XmwyIoKUpEXfmZdi7+uhUUPejkV8Y+X8NGOM0ueUl7JNj1pzWh/RwU4YGdJrykodyrMV909YG/yYgdmo9dEh280Tgja/PBrUJSOz5qh/9isU/jvjMmUhQxy+FsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750803; c=relaxed/simple;
	bh=561McIbZSj7RHnQMTrApZaVrdkz4HrsInEu17rVz8zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/TAK0xQ1COkhH8M48NQhNfSfVyL++CaHD2huzmBhxCJtRJExu+0FeJn/BmQTGWa23bXucROGZtOOTN3C1p/UNmYfbmg9pGZlkqZRvfauKJwcWT2NW7Xh1SRLQwNuawfyhIUnrIH+EGs3GPwGfukBVUdfizVQCpGkgdcLDLdMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=HYF0Z+B3; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=rfGPZviW reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1729750799; x=1761286799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SAKgQcAAwB99nkfmznaguckD9Z4cWK5+suxAwPb4ifM=;
  b=HYF0Z+B3VGHItHNed7AWXONqnbE/wIlI59kdvBz+gIVXagd6xhPe1Uo1
   O+QTkfAyxa3SMWaCaAA92T+UNZr63boKcMFoPF3UYOQh7l6ci7ChI6hCe
   2XZFLOUFZrODfzqx83ogswSOuYJbShZpASTbKiznysV26YFbP315G9zA1
   etFmJM9UnqPqsgmBEHRYhT/BMcIuGKvGPGlbqcpn3kt9XaFm18Cg+Yt4h
   JkUUY+ZBNLUN3BepRt3f0K+YxwswFhS5Ed1M7N8snqiMHvAp/GDCGI1pE
   4564YdVXsevaoBjPwup5WhMXpbkhPieqab02yhe4jsDscvp6RD6P7L3J0
   Q==;
X-CSE-ConnectionGUID: 98gikefUReGFnSKpxd2Vaw==
X-CSE-MsgGUID: GeVhVO4AT5CzQqRIDipUog==
X-IronPort-AV: E=Sophos;i="6.11,228,1725314400"; 
   d="scan'208";a="39638990"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Oct 2024 08:19:56 +0200
X-CheckPoint: {6719E70C-C-21611FC3-DAD22B0C}
X-MAIL-CPID: 3BEFDD606C015A394925D4346B86F31F_4
X-Control-Analysis: str=0001.0A682F21.6719E71A.009E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A633A164169;
	Thu, 24 Oct 2024 08:19:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1729750791;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SAKgQcAAwB99nkfmznaguckD9Z4cWK5+suxAwPb4ifM=;
	b=rfGPZviWWgAPCkTUYlomzPpCkvBnP+HFGT0Fvjd3DHINEtGyrFDs0eRL1FWtvkIupW7aJV
	4uFOY+JtAW+CmiIKLbQ0P7/kjZhkdEXHVvUvy7DyyQ+1bd3wFKEBFFp+rS9xfsCk0yzeOv
	z0+s8//ow2vzJg1WEYI9VkHTOvCeuoAC7A3WvDycesGOQEodpKq9XYlfxUVggLH7RM95jx
	7EJ1T2QxDFCU0THaOn68hHIBa8WdIepD3ObdvYm/U9RhSooDZe6eboZD/j38suqhmz7C+r
	rNkmm6/dGGf32ikxtfO8e0lnjYc41imBzvF6r7LunXfEGopQqwMwII/RMNwieg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
Cc: daniel.lezcano@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Fabio Estevam <festevam@denx.de>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: timer: fsl, imxgpt: Fix the fsl, imx7d-gpt fallback
Date: Thu, 24 Oct 2024 08:19:49 +0200
Message-ID: <4933956.GXAFRqVoOG@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20241023185841.1183706-1-festevam@gmail.com>
References: <20241023185841.1183706-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Fabio,

thanks for the patch.

Am Mittwoch, 23. Oktober 2024, 20:58:40 CEST schrieb Fabio Estevam:
> From: Fabio Estevam <festevam@denx.de>
>=20
> imx7s.dtsi correctly describes the GPT node as:
>=20
> compatible =3D "fsl,imx7d-gpt", "fsl,imx6dl-gpt";
>=20
> Document the fallback compatible to be "fsl,imx6dl-gpt" in the bindings.
>=20
> This fixes the following dt-schema warnings:
>=20
> timer@302f0000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['fsl,imx7d-gpt', 'fsl,imx6dl-gpt'] is too long
> 	'fsl,imx1-gpt' was expected
> 	'fsl,imx21-gpt' was expected
> 	'fsl,imx27-gpt' was expected
> 	'fsl,imx31-gpt' was expected
> 	'fsl,imx7d-gpt' is not one of ['fsl,imx25-gpt', 'fsl,imx50-gpt', 'fsl,im=
x51-gpt', 'fsl,imx53-gpt', 'fsl,imx6q-gpt']
> 	'fsl,imx6dl-gpt' was expected
> 	'fsl,imx7d-gpt' is not one of ['fsl,imx6sl-gpt', 'fsl,imx6sx-gpt', 'fsl,=
imx8mp-gpt', 'fsl,imxrt1050-gpt', 'fsl,imxrt1170-gpt']
> 	'fsl,imx6sx-gpt' was expected
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
>  Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Do=
cumentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> index e2607377cbae..a2fcb1e8e74e 100644
> --- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> +++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> @@ -31,6 +31,7 @@ properties:
>            - enum:
>                - fsl,imx6sl-gpt
>                - fsl,imx6sx-gpt
> +              - fsl,imx7d-gpt
>                - fsl,imx8mp-gpt
>                - fsl,imxrt1050-gpt
>                - fsl,imxrt1170-gpt
> @@ -38,7 +39,6 @@ properties:
>        - items:
>            - enum:
>                - fsl,imx6ul-gpt
> -              - fsl,imx7d-gpt
>            - const: fsl,imx6sx-gpt
> =20
>    reg:
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



