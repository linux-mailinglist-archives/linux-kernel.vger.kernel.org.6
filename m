Return-Path: <linux-kernel+bounces-423171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6169DA3E0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B501647B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8005E186E2F;
	Wed, 27 Nov 2024 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C6qpG9NP"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C5013C816;
	Wed, 27 Nov 2024 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732695998; cv=none; b=rGl6V+xrlphCniNV67wNfx9NEqYNRiKwCOMLeP70ozluLkFCpcAbK+HYOJx8T92tD6o/huG9vN2umq47HyDAL7YawIVDCTXrWNmvC0EIGv5kDR6+F7vD7QRkveJyvintbpZ8oAxB6A7QHnNrY+LkBUYmaosoByqXCVl1M2vsJI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732695998; c=relaxed/simple;
	bh=ttBuqBOm3+1ecIeuoO/LPjdDdzZz47MGwI9SY6l/QHM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMNjWS7DOxLKkyWWQIXbZfFpvDp6ff7JxbVmO3vuhGufwes1lFxORTEGnfEArUpAHnp822AQTNVK57sJoa1veKtlhvFZHj7Dn8CGk1kfbsgCyL1wyx9II0AEWhCI+EqdGNXj0WgQT3D1uigwYDvxZ2R4a3SKFa1ejwN5w0YUUyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=C6qpG9NP; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AR8QQn0969158
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 27 Nov 2024 02:26:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732695986;
	bh=x5MEcsWepkzSagRcBdjCCQ9PHoHda5oErgZwMaMz09A=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=C6qpG9NPchNMwdzzhI2F73hWyMMqNewZk+mct8g+YvmTN9L52rY4N124GsIkTAflU
	 awKz7UVYfCSUVdgxtgiQjKPt91Al5jI6Y05eIHLdAlBpb9ih1auCl7G1VTx3CBFdAB
	 ATCb9bbkCcroJtBrWm5EmjRwUjJXBNrI6wgj+Jj0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AR8QQtT121482;
	Wed, 27 Nov 2024 02:26:26 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Nov 2024 02:26:25 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Nov 2024 02:26:25 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AR8QON2092114;
	Wed, 27 Nov 2024 02:26:25 -0600
Date: Wed, 27 Nov 2024 13:56:23 +0530
From: s-vadapalli <s-vadapalli@ti.com>
To: Enric Balletbo i Serra <eballetb@redhat.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        "Tero
 Kristo" <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dasnavis Sabiya <sabiya.d@ti.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am69-sk: Add USB SuperSpeed support
Message-ID: <2nuncc5rscu6h74ylaiu6yozg34aoigaj5d4uzvdtolt5q7bmv@6hacpxyb2532>
References: <20241126-am69sk-dt-usb-v1-1-aa55aed7b89e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241126-am69sk-dt-usb-v1-1-aa55aed7b89e@redhat.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Nov 26, 2024 at 11:08:19AM +0100, Enric Balletbo i Serra wrote:

Hello Enric,

> From: Dasnavis Sabiya <sabiya.d@ti.com>
> 
> AM69 SK board has two stacked USB3 connectors:
>    1. USB3 (Stacked TypeA + TypeC)
>    2. USB3 TypeA Hub interfaced through TUSB8041.
> 
> The board uses SERDES0 Lane 3 for USB3 IP. So update the
> SerDes lane info for PCIe and USB. Add the pin mux data
> and enable USB 3.0 support with its respective SERDES settings.
> 
> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
> ---
> I've been carrying this patch for quite long time in my builds to have
> support for USB on my AM69-SK board without problems. For some reason this
> patch was never send to upstream or I couldn't find it. So I took the
> opportunity, now that I rebased my build, to send upstream.
> 
> I have maintained the original author of the downstream patch as is
> basically his work.
> ---
>  arch/arm64/boot/dts/ti/k3-am69-sk.dts | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts

[...]

> +&usb0 {
> +	status = "okay";
> +	dr_mode = "host";

Since the Type-C interface is also connected to USB0, shouldn't "dr_mode"
be "otg"? Also, has the Type-C interface been tested with this patch?
Please let me know.

[...]

Regards,
Siddharth.

