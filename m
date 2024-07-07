Return-Path: <linux-kernel+bounces-243566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E70349297C8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 14:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225B21C20A2A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 12:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA1C1CD32;
	Sun,  7 Jul 2024 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="N9tbjIy9"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3521C694;
	Sun,  7 Jul 2024 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720354683; cv=none; b=EdVy0kSRs92Z16VD6R1busCn7sXeKd5qbtXpdcJ0Hv3g9yBEzCYpzvOk7HY++KDope+0j/QYZ0RXhnTpNi4LbrBOGsMPO2J8wNzKhbhxePIKaaVYL/cymb79pnv7yIU2IA98mDEz+d/wrOVgiRtqftCcJS4bEdtBc6nqO9hDo70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720354683; c=relaxed/simple;
	bh=/ZE98uSxNAbfzHkH31FBNDLThBe/haeN9Vnngj4CFRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgJW/uvtTHJk6PReOiLebCqzhRVVAUEoYEym5+mkvkUpVEVQbLhyUdkapX2geXPp09vM4IdgOKv4Ajnv5Du2e0nVKzwpKzdr0bXKRR3yRopN8gReHCSAYoHivULIyuMPpCtf8IN5TdPIWUsz4cRHe2FYZv89dTgT+/RjfU6KzLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=N9tbjIy9; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1720354672; x=1720959472; i=j.neuschaefer@gmx.net;
	bh=wOY2LTVtor9c0uh4sZNyK/qPJ5Ak71J0G4tckDfFQzU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=N9tbjIy9QZbwZCaOjcLLmAIhLQ35YZsTqGiNPsM4LojXWbONQO0lLDx8F+jMmEqk
	 i2n+SNidrO6TmTr9cTokLSHiQmLKKle8iRl/Z3LfIu2dzUlHCLYEoBwAPaBHaUS49
	 AonpM1jLresat1y6sulftZHioMX+LnGn+RjvQOXXHxAuTClkCqUyGGu3oWudfPD2i
	 /0ncmybCL9Q0AkwrQHyhIl0FuVQek+lESZlbzOVcrkx2HQ6b1uHNTGrtGA27sEEGy
	 ulnBlHGDN+j7sE7BCL2UPZibjg81hDMscOs9YrXJ1GYLnSZTZ0a/36u+rU+VU+IJN
	 cg+kxbL1FYI79ptsDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.0.46.161]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MysRu-1sCd4k23Bi-00xmgG; Sun, 07
 Jul 2024 14:17:52 +0200
Date: Sun, 7 Jul 2024 14:17:51 +0200
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, openbmc@lists.ozlabs.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: nuvoton: wpcm450: align LED and GPIO keys node
 name with bindings
Message-ID: <ZoqHb93S6j-_jaRo@probook>
References: <20240701164915.577068-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240701164915.577068-1-krzysztof.kozlowski@linaro.org>
X-Provags-ID: V03:K1:b4mry7pjbZIt6XKul32V8zWb7qm4V36BMOV1anIacoWRyYBuYrx
 uWIeweF7djxvaYIjhUFzpl1+zKZP6ze2aWiiTmQFfBtn4Glw/E9TKhcPemzk7fHCzPLoqfJ
 nrQ5eIfx/8rrvyMtkYcNlEWcvUb1EuL9vHm78AxGO3NfkFVCGf9JwvozGMnpD18K4V9XXxz
 cKxBsT/L5k1ZA+f1OKzlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iobDFNDXXZ4=;pJuCc/1CkdUEyqNPsAqpRgO60r4
 dAgJiXZ/eHyUTv9uc9Lzt01g4j5Zbn3AI6hisd2rjyZ2951CCgkaQMs0avIWEmsU2IK0JReJb
 ThObmSeDPbJe7kQgOZVFFlr1gr/3ferB18uIZZ3TxzYSa+gPDS/N+jiZ0f7MNcwH739aO7uRM
 LyXM+L9xeHUoza20NExz8t3fk40dY+grkNpwN3oLUyGCPm7Oas+YxWZe0Wzb2iuVZMuQniY+z
 LjX4H7W9LvDr6UgFikA51xpw3f/dB0rf/qK4lOZOVykPt+s9+Z2MMNAlJAjCIY6SuVQgE28KP
 c8PKgCECwY8I/ViRHyZBvSANNc+e2jOh3YmpNsfhYwviagzuCiDSBeZ9anAq0uYkRhtnbbf40
 hlv1IXulfeAMHl4vncJbKkxyzr3bzPs8NIafkSuuoxGOaL80aol+sl51gUhBa+jmcxi+KC+WQ
 hHcREWtqII4YrgjSdyCuyUndMazV1rJtkNWGZXF+c0PtfexFNQpviGbJvxayRQ3p6h87PIrAS
 15moPSBJKqz+bBp8P4R6qZ9Fwyl3LMiDk+EViLOF9AOIxGwMW2jj+jPmvtmQLTCL/a/P8GWcm
 SmtGIAijzOVH1zP55e1HVKCU+pF22AYQ1cxuw82kX1LHS0/YrRLNo9XHXDyoaJTe8QZPNRLSg
 qy9WKoGGSrFMOt+6/3dqAqX/nz4z09fMvdCgeyqWI5b16w/fEHFOw15wNReNq+my//3hj4DP0
 kSqrunjXUR24ZEllZWvZ4EZ1flSn+P5DeCUsy+Jyvc/p6yDN8ts0+5+K7hIhjImzEjlVuDNru
 rLx6XgNm/LR3fSS1JSMOBXqHKPh7qHqF96ZUrQVY5Vpbs=

On Mon, Jul 01, 2024 at 06:49:15PM +0200, Krzysztof Kozlowski wrote:
> Bindings expect the LED and GPIO keys node names to follow certain
> pattern, see dtbs_check warnings:
>
>   nuvoton-wpcm450-supermicro-x9sci-ln4f.dtb: gpio-keys: 'uid' does not m=
atch any of the regexes: '^(button|event|key|switch|(button|event|key|swit=
ch)...
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Looks good, thanks!

Reviewed-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

>  .../dts/nuvoton/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts   | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450-supermicro-x9sci-=
ln4f.dts b/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450-supermicro-x9sci-ln4f=
.dts
> index b78c116cbc18..edb907f740bf 100644
> --- a/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450-supermicro-x9sci-ln4f.dt=
s
> +++ b/arch/arm/boot/dts/nuvoton/nuvoton-wpcm450-supermicro-x9sci-ln4f.dt=
s
> @@ -34,7 +34,7 @@ gpio-keys {
>  		pinctrl-names =3D "default";
>  		pinctrl-0 =3D <&key_pins>;
>
> -		uid {
> +		button-uid {
>  			label =3D "UID button";
>  			linux,code =3D <KEY_HOME>;
>  			gpios =3D <&gpio0 14 GPIO_ACTIVE_HIGH>;
> @@ -46,12 +46,12 @@ gpio-leds {
>  		pinctrl-names =3D "default";
>  		pinctrl-0 =3D <&led_pins>;
>
> -		uid {
> +		led-uid {
>  			label =3D "UID";
>  			gpios =3D <&gpio1 7 GPIO_ACTIVE_HIGH>;
>  		};
>
> -		heartbeat {
> +		led-heartbeat {
>  			label =3D "heartbeat";
>  			gpios =3D <&gpio1 4 GPIO_ACTIVE_LOW>;
>  		};
> --
> 2.43.0
>

