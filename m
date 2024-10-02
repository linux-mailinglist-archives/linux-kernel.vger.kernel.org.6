Return-Path: <linux-kernel+bounces-347037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3391398CCE0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85F81F22E07
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 06:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C807978C75;
	Wed,  2 Oct 2024 06:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="FStuLaLf"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A521328F4
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 06:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727848956; cv=none; b=GwmdYx2F9a4JQzxSYhO0QDCliw9MJSDjvEOTZ1LFKxCUyU/cVDon5x+LuC56qgqk3UArs4ndg4ZE11jzveSh/elhRslyQHX1F+rD2W4CIVtoCtilkQb7O10qiPzoCs0LqR0zS39WDbepshQFAFR0IoKJMEVZvCMk30EJuaw+UiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727848956; c=relaxed/simple;
	bh=hcR9RSTutCIIGxDwRJgJlZY0Y72Kiqc7MkfQwzQ/KdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qUQvUsB7ilwc7YI3apyElPE2Xgw3GvhmBGAfW511bcmv5YBw6wajRM0cJBat++Rep5rHZkupvwrPiEybU0flgWVLRwBqO6Q0UvaIqcp6kNZZeA+S8JoD8VfKlH1SnEKSd0r5QGDpFmzs1PUBMMBPIf84QQc0mc52QMsLjyshSts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=FStuLaLf; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1727848952; x=1730440952;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hcR9RSTutCIIGxDwRJgJlZY0Y72Kiqc7MkfQwzQ/KdA=;
	b=FStuLaLfAXpS3cG0KDc/rnsb0Ak9I/aaazDbVdEhWFrkuWRsvqbiuMSmxFHm/h/B
	xNRV5lj5X/2Qqq1p5j+7s+zlAUTm6q9qWvSdiCB2j7ajEgAytNMx5wcs+IksR8i5
	NQjVHZjrxszQgik2taP+//mjf1gPAubDDLBspXO1y9A=;
X-AuditID: ac14000a-4637f70000004e2a-a9-66fce1f80d41
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 9E.6D.20010.8F1ECF66; Wed,  2 Oct 2024 08:02:32 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 2 Oct 2024
 08:02:30 +0200
Message-ID: <1060b415-8605-41d7-8b28-050926d928c2@phytec.de>
Date: Wed, 2 Oct 2024 08:02:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH] arm64: dts: ti: k3-am62x-phyboard-lyra: Fix
 indentation in audio-card
To: John Ma <jma@phytec.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <upstream@lists.phytec.de>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240926175522.3126038-1-jma@phytec.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240926175522.3126038-1-jma@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWyRpKBR/fHwz9pBtcvSVms2XuOyWL+kXOs
	Fs86m5gtln+ezW7xctY9NotNj6+xWlzeNYfN4s2Ps0wW//fsYLfofqdu8f/sB3YHbo9NqzrZ
	PDYvqffo725h9fhz8R2rx/Eb25k8Pm+SC2CL4rJJSc3JLEst0rdL4MqY3ZFS0MJeceTeH/YG
	xnusXYycHBICJhLPZ/WydzFycQgJLGGSWHjiJDOEc4dRovHCCrAqXgEbidkf7jGD2CwCKhLH
	D2xlg4gLSpyc+YQFxBYVkJe4f2sG0CQODmGBdIknjZwgc0QEpjJKrNt2kgnEYRZoY5R4sKEb
	rFlIwFTiV8sNsAXMAuISt57MZwKx2QTUJe5s+AYW5xQwk1j8fD8zRI2FxOI3B9khbHmJ7W/n
	MEPMkZd4cWk5C8Q78hLTzr1mhrBDJY5sWs00gVF4FpJbZyFZNwvJ2FlIxi5gZFnFKJSbmZyd
	WpSZrVeQUVmSmqyXkrqJERRvIgxcOxj75ngcYmTiYDzEKMHBrCTCe+/QzzQh3pTEyqrUovz4
	otKc1OJDjNIcLErivKs7glOFBNITS1KzU1MLUotgskwcnFINjH46r4o+nha8ZxDg2xymqlnj
	euhpn/LcD6cPS3uc6z2UltUn3FH4U1Z8r8ejZAUfRaZfC/da39j0xSWXXbnC544j66lI4wdL
	dr5VX/XfKcx9tanHefGGG4XxK34aKz28Mc0jUtaz2uO7cJua5KNNQfeVekvlp4d/+7GAcVn9
	ow8L87tYdh28ocRSnJFoqMVcVJwIAHgAUe+lAgAA



Am 26.09.24 um 19:55 schrieb John Ma:
> Corrected the indentation for the audio card node in the phyBOARD-Lyra.
> 
> Signed-off-by: John Ma <jma@phytec.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
> index e4633af87eb9..0b434dcfe256 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
> @@ -82,8 +82,8 @@ simple-audio-card,cpu {
>   		};
>   
>   		sound_master: simple-audio-card,codec {
> -				sound-dai = <&audio_codec>;
> -				clocks = <&audio_refclk1>;
> +			sound-dai = <&audio_codec>;
> +			clocks = <&audio_refclk1>;
>   		};
>   	};
>   


