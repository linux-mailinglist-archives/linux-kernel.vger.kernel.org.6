Return-Path: <linux-kernel+bounces-291974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E04956990
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5961F2297C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE48C166F3D;
	Mon, 19 Aug 2024 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="AaMIVeoU"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5FE166F2A;
	Mon, 19 Aug 2024 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067821; cv=none; b=Wjzr0m/43rFY7lOtRHYs9w/sGZC+qC0KZK4F8TJkI6WZmZ8uEFP7RI3BL7ff69ZAgdWlPRFNM+IejRpveJt2u/2uv6SoFFi6ZFPYFdWuEQ2wNAgnLJaMLWYILoeXVGwh+WIBOKCZToSLtEI2NbidYzW5vaJw0VwtPv3DDk4MLLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067821; c=relaxed/simple;
	bh=ZRnKHej5GGCo7GDzgFRFP9GZMsIsKF0Y8yAgNCG2Ef4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Iz4c8dhh7JVwkYnzzbwgtNMxUORnAjnz45iCInAQ4xehoq+qv+8CylqgYK7A6FRuEH0cT4pT/ivNiFXGmDw7qgBwWuoFLHGCtzw342bnOSfQfgB3G2qiIHclYgGlbY8BaKyhUqtXlNCAfE8HpnXoWsQoyBd+0n95CNGdmEDq9Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=AaMIVeoU; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 41B869C5BDF;
	Mon, 19 Aug 2024 07:43:31 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id l0-j1zBEH9ZD; Mon, 19 Aug 2024 07:43:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4D1A09C5F74;
	Mon, 19 Aug 2024 07:43:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 4D1A09C5F74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1724067810; bh=g3AsLUqBfKMisCl4I03Q1DAj0/8iriOUEYeW7RNSf2s=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=AaMIVeoUp0XGvy58oS1QXH6phQNWz5ic5K/PnB2LvOWK38amBy7c5YOWrudkWD0Vp
	 o4RmMP9VB8zhaet1baBcMCZUWWGHuBnA+M6SZDaP61Bp+yNSalbzTgvVPUV4LN1PQz
	 92OLI92ya8VTtQA1BtmYKMyxy+AzdNKjXsxi8XldIYouc91GD+WFFtf5a6uxySlY50
	 vv5ntTjj6Z8w3hFYFimazNvrJEd52F1UpVF2e2BPIx6iEvyvQrZaAwVyuEKVbVEMTm
	 e9cmcUFdt5RoVKhg6s+8b2NJCjQLLQg3JTAUXTNse/Qgb0DWgXWQ/qd5p64rZ65VOR
	 WSPSc2oOYP2Yg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id G2C6bNsOuPV7; Mon, 19 Aug 2024 07:43:30 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E8A2E9C5BDF;
	Mon, 19 Aug 2024 07:43:29 -0400 (EDT)
Date: Mon, 19 Aug 2024 07:43:29 -0400 (EDT)
From: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, 
	shengjiu wang <shengjiu.wang@gmail.com>, 
	Xiubo Lee <Xiubo.Lee@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, 
	linux-sound <linux-sound@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, imx <imx@lists.linux.dev>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	alsa-devel <alsa-devel@alsa-project.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Philip-Dylan Gleonec <philip-dylan.gleonec@savoirfairelinux.com>
Message-ID: <905560330.155045.1724067809890.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <Zq+QrxKFb3U1IEv/@dragon>
References: <20240627083104.123357-1-elinor.montmasson@savoirfairelinux.com> <20240627083104.123357-7-elinor.montmasson@savoirfairelinux.com> <Zq+QrxKFb3U1IEv/@dragon>
Subject: Re: [PATCH v6 6/7] arm64: dts: imx8m: update spdif sound card node
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - GC112 (Linux)/8.8.15_GA_4581)
Thread-Topic: arm64: dts: imx8m: update spdif sound card node properties
Thread-Index: LseD1k2NMHpDg9FbVlB5JHSqjmcCfQ==

> From: "Shawn Guo" <shawnguo2@yeah.net>
> Sent: Sunday, 4 August, 2024 16:31:11
> On Thu, Jun 27, 2024 at 10:31:03AM +0200, Elinor Montmasson wrote:
>> The merge of imx-spdif driver into fsl-asoc-card brought
>> new DT properties that can be used with the "fsl,imx-audio-spdif"
>> compatible:
>> * The "spdif-controller" property from imx-spdif is named "audio-cpu"
>>   in fsl-asoc-card.
>> * fsl-asoc-card uses codecs explicitly declared in DT
>>   with "audio-codec".
>>   With an S/PDIF, codec drivers spdif_transmitter and
>>   spdif_receiver should be used.
>>   Driver imx-spdif used instead the dummy codec and a pair of
>>   boolean properties, "spdif-in" and "spdif-out".
>> 
>> While backward compatibility is kept to support properties
>> "spdif-controller", "spdif-in" and "spdif-out", using new properties has
>> several benefits:
>> * "audio-cpu" and "audio-codec" are more generic names reflecting
>>   that the fsl-asoc-card driver supports multiple hardware.
>>   They are properties already used by devices using the
>>   fsl-asoc-card driver.
>>   They are also similar to properties of simple-card: "cpu" and "codec".
>> * "spdif-in" and "spdif-out" imply the use of the dummy codec in the
>>   driver. However, there are already two codec drivers for the S/PDIF,
>>   spdif_transmitter and spdif_receiver.
>>   It is better to declare S/PDIF Tx and Rx devices in a DT, and then
>>   reference them with "audio-codec" than using the dummy codec.
>> 
>> For those reasons, this commit updates in-tree DTs to use the new
>> properties:
>> * Rename "spdif-controller" property to "audio-cpu".
>> * Declare S/PDIF transmitter and/or receiver devices, and use them with
>>   the "audio-codec" property instead of "spdif-out" and/or "spdif-in".
>> 
>> These modifications were tested only on an imx8mn-evk board.
>> 
>> Note that out-of-tree and old DTs are still supported.
>> 
>> Signed-off-by: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
>> ---
>>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 15 +++++++++---
>>  arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 15 +++++++++---
>>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 24 +++++++++++++++----
>>  3 files changed, 43 insertions(+), 11 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
>> b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
>> index 90d1901df2b1..348855a41852 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
>> @@ -180,12 +180,21 @@ cpu {
>>  		};
>>  	};
>>  
>> +	spdif_out: spdif-out {
>> +		#sound-dai-cells = <0>;
>> +		compatible = "linux,spdif-dit";
> 
> It's recommended that the property list begins with 'compatible'.  Could
> you flip them?
> 

Yes I'll will do this quickly, thank you.

Regards,
Elinor Montmasson

