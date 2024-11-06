Return-Path: <linux-kernel+bounces-399040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BAF9BFA18
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FDA71C21ADF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C8620E004;
	Wed,  6 Nov 2024 23:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="mgxojSU/"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AB11DDA3B;
	Wed,  6 Nov 2024 23:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935774; cv=none; b=SvEs3vh7cHdQF/QgekbcfeKVev9uWhpxggLI6KW0qeSzPULyY8907zixrBeZfwwMaApOH7RgPdPI+E2+CUCe7ynN+bB7GOffOO8U/Hp8qi3IryG7i+mrQ6zceO3qoRGF+UYCVkqSsiVEn6SjY4x4CDcNnf324HDDu10+WsEYxpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935774; c=relaxed/simple;
	bh=2ijiQCEH3WfXxOUZjWlN4bEfTNV+PzJeCvTZGqxK0Uc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G2/AEWeoR+XABaP7hf4NGLHOsxNzYcL2tGJCJjCv6N9o+xCcOlQ18OS0BkIoFne7H2e5Wp9nByerYkt52d8zixEOl4d8kssBN+I7CdPsH8qeZ97b3J2ekQqntwhvpcMrkB+IbgBkWIzoj1DpmIO9eeE8McOTDEUOupzN/Nil+VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=mgxojSU/; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730935768;
	bh=TOWl/eUFXyJWI5BavbOyBodSpQ5DsXBDLmnGE28bD/o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mgxojSU/QnQp9VU5DKq2xgfomwoyPOCHI920rgB3KltLPzJzfSjeRTuR5h8zXY/n0
	 /7FStouaMtU8Z0oLhTVNLNiTQ3sb/TcABKBTyIWdUNGiJo1QOSkibJaPc/rRr5SRco
	 HOT7khJTWNqG7ZCaVxVzj0ucNW0IjwQJc5tcoKldWCcfVxq7BG6yOe2eK2c6t2rlxx
	 EFof0MeJeEpTE2VwBu6yre/jMPmA0gydBKYhH7mebThgK+gyfzdd9kGciK6yC4L3BM
	 c4pHGo2NSw3m17JgMSq2RaV/yS/wlIBxF6CEWLtX4kr+boCIzsiF0yOe72F84FXYhD
	 ab49POf2aqdXQ==
Received: from [192.168.68.112] (203-173-7-89.dyn.iinet.net.au [203.173.7.89])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2ACBD6B7C8;
	Thu,  7 Nov 2024 07:29:27 +0800 (AWST)
Message-ID: <6a2f9268449b08a8e48e882bf1b1ce6f605fe3a0.camel@codeconstruct.com.au>
Subject: Re: [PATCH] arm: dts: aspeed: Everest and Fuji: Add VRM presence
 gpio expander
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Eddie James <eajames@linux.ibm.com>, linux-aspeed@lists.ozlabs.org
Cc: joel@jms.id.au, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 07 Nov 2024 09:59:26 +1030
In-Reply-To: <20241106193303.748824-1-eajames@linux.ibm.com>
References: <20241106193303.748824-1-eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-06 at 13:33 -0600, Eddie James wrote:
> Add the gpio expander that provides the VRM presence detection
> pins.
>=20
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> =C2=A0.../dts/aspeed/aspeed-bmc-ibm-everest.dts=C2=A0=C2=A0=C2=A0=C2=A0 |=
 27
> +++++++++++++++++++
> =C2=A0.../boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts=C2=A0=C2=A0 | 27
> +++++++++++++++++++
> =C2=A02 files changed, 54 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
> b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
> index 513077a1f4be..9961508ee872 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
> @@ -353,6 +353,33 @@ pca1: pca9552@62 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"pr=
esence-base-op",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0led-controller@63 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0compatible =3D "nxp,pca9552";

So Lee has queued the binding for the pca9552 in the leds tree[1], and
I've applied the patch on that basis.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git/commit/?h=
=3Dfor-leds-next&id=3Df92d2e9334171d07b47189397f222f64dcb77617

However, when merging for-leds-next into a tree with your patch here to
test, it surfaced a bunch of further (unrelated) issues:

    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot=
/dts/aspeed/aspeed-bmc-ibm-everest.dtb: pca9552@65: 'led@10', 'led@11' do n=
ot match any of the regexes: '^led@[0-9a-f]$', 'pinctrl-[0-9]+'
    +       from schema $id: http://devicetree.org/schemas/leds/nxp,pca955x=
.yaml#
    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot=
/dts/aspeed/aspeed-bmc-ibm-everest.dtb: pca9552@31: 'led@10', 'led@11', 'le=
d@12', 'led@13', 'led@14', 'led@15' do not match any of the regexes: '^led@=
[0-9a-f]$', 'pinctrl-[0-9]+'
    +       from schema $id: http://devicetree.org/schemas/leds/nxp,pca955x=
.yaml#
    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot=
/dts/aspeed/aspeed-bmc-ibm-everest.dtb: pca9552@32: 'led@10', 'led@11', 'le=
d@12', 'led@13', 'led@14', 'led@15' do not match any of the regexes: '^led@=
[0-9a-f]$', 'pinctrl-[0-9]+'
    +       from schema $id: http://devicetree.org/schemas/leds/nxp,pca955x=
.yaml#
    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot=
/dts/aspeed/aspeed-bmc-ibm-everest.dtb: pca9552@33: 'led@10', 'led@11', 'le=
d@12', 'led@13', 'led@14', 'led@15' do not match any of the regexes: '^led@=
[0-9a-f]$', 'pinctrl-[0-9]+'
    +       from schema $id: http://devicetree.org/schemas/leds/nxp,pca955x=
.yaml#
    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot=
/dts/aspeed/aspeed-bmc-ibm-everest.dtb: pca9552@30: 'led@10', 'led@11', 'le=
d@12', 'led@13', 'led@14', 'led@15' do not match any of the regexes: '^led@=
[0-9a-f]$', 'pinctrl-[0-9]+'
    +       from schema $id: http://devicetree.org/schemas/leds/nxp,pca955x=
.yaml#
    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot=
/dts/aspeed/aspeed-bmc-ibm-everest.dtb: pca9552@34: 'led@10', 'led@11', 'le=
d@12', 'led@13', 'led@14', 'led@15' do not match any of the regexes: '^led@=
[0-9a-f]$', 'pinctrl-[0-9]+'
    +       from schema $id: http://devicetree.org/schemas/leds/nxp,pca955x=
.yaml#
    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot=
/dts/aspeed/aspeed-bmc-ibm-everest.dtb: pca9552@35: 'led@10', 'led@11', 'le=
d@12', 'led@13', 'led@14', 'led@15' do not match any of the regexes: '^led@=
[0-9a-f]$', 'pinctrl-[0-9]+'
    +       from schema $id: http://devicetree.org/schemas/leds/nxp,pca955x=
.yaml#
    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot=
/dts/aspeed/aspeed-bmc-ibm-everest.dtb: pca9552@60: 'led@10', 'led@11', 'le=
d@12', 'led@13' do not match any of the regexes: '^led@[0-9a-f]$', 'pinctrl=
-[0-9]+'
    +       from schema $id: http://devicetree.org/schemas/leds/nxp,pca955x=
.yaml#

Can you please send a follow-up patch resolving those and any similar
warnings for Fuji?

Thanks

Andrew

