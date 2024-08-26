Return-Path: <linux-kernel+bounces-300743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3043D95E7CB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F9728147B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 05:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907886EB5B;
	Mon, 26 Aug 2024 05:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aRxR0Gb+"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6CB25622;
	Mon, 26 Aug 2024 05:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724648443; cv=none; b=CDVxOYGk2SsJkUBdk3fYHZS6z65ILNKoWJqCxPydyeyER1kqZMWFdwSx/h5KHIAeoPYPqa0wvGNoWgchhzRl/pTSkoz+hA4dLCbdFd9x3Pb2pLHC1CuUfXQ3gU4OEAf9BU9iuO+KxIfgp2qYVwcPQ01U5G6WaJhAxthvd2EQDgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724648443; c=relaxed/simple;
	bh=U5lQpCDK5XyKukvTc1DBeqadWMCLg1JyCNac5p1AX3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LlvLE1JWU7peUENXnHgIsXCf/Y1wr+oyJHKttrJmG28O4a3PzGnujJWEhn99Ha/e7hx2pBsON5wWv/DyTMs1iytfGgoxK4mkH+yB9dBkLA1hTpI/MtTpnUePBvi5vp/5EycAAaWfW9wMUhMY4H6JiQqQf2pRSHD6JVZPKuC2aQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aRxR0Gb+; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47Q50OYB005887;
	Mon, 26 Aug 2024 00:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724648424;
	bh=wSTsnn+PWQNFoNG75S2Cjt2YLi/eYQRz0ftArtFCxbA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=aRxR0Gb+vUHNkYf5MZ7LzkYyRIBMoOw+DVivwgKdLkfm+iLZf63T5i94TrkTEBbPF
	 feDuOsZiknY5hXM5tygRYiShdCYV1HH+Ro6zAmUKm8AbdZWCZ+Fk7jeGh1WMnNwDJZ
	 dDcqWSP37TenCkDuW6Br3YLcJh7HWw0TEpqUJ7ac=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47Q50OxM022704
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 00:00:24 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 00:00:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 00:00:24 -0500
Received: from [172.24.19.209] (lt5cd2489kgj.dhcp.ti.com [172.24.19.209])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47Q50JfI091793;
	Mon, 26 Aug 2024 00:00:19 -0500
Message-ID: <3f0002df-7ff0-4fd8-b8df-105ae9a5b051@ti.com>
Date: Mon, 26 Aug 2024 10:30:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] arm64: dts: ti: k3-j722s: Change timer nodes
 status to reserved
To: Beleswar Padhi <b-padhi@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <tony@atomide.com>, <bb@ti.com>, <d-gole@ti.com>, <afd@ti.com>,
        <hnagalla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>
References: <20240816073908.2343650-1-b-padhi@ti.com>
 <20240816073908.2343650-6-b-padhi@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240816073908.2343650-6-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 8/16/2024 1:09 PM, Beleswar Padhi wrote:
> The remoteproc firmware like of R5F and DSPs in the MAIN voltage domain
> use timers. Therefore, change the status of the timer nodes to
> "reserved" to avoid any clash. Usage is described as below:
>
> 	+===================+=============+
> 	|  Remoteproc Node  | Timer Node  |
> 	+===================+=============+
> 	| main_r5fss0_core0 | main_timer0 |
> 	+-------------------+-------------+
> 	| c7x_0             | main_timer1 |
> 	+-------------------+-------------+
> 	| c7x_1             | main_timer2 |
> 	+-------------------+-------------+
>
> Fixes: 29075cc09f43 ("arm64: dts: ti: Introduce AM62P5 family of SoCs")
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index dd3b5f7039d7..e03beb0b5aad 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -566,3 +566,16 @@ &mcasp1 {
>   	       0 0 0 0
>   	>;
>   };
> +
> +/* Timers are used by Remoteproc firmware */
> +&main_timer0 {
> +	status = "reserved";
> +};
> +
> +&main_timer1 {
> +	status = "reserved";
> +};
> +
> +&main_timer2 {
> +	status = "reserved";
> +};


Since IPC is not up-streamed for J722S , So I suggest to drop this patch 
from this series

and include this when you upstream IPC support for J722S board .



