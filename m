Return-Path: <linux-kernel+bounces-215340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA507909169
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A161C2314B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB971A01C2;
	Fri, 14 Jun 2024 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ctEn4gJS"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC49319DF51;
	Fri, 14 Jun 2024 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386030; cv=none; b=Pm1Yzq4ns1xp4IPmdA1TML0rJ/f5DtobiBZmz6Y3nki1itqAR1qWo4/Xqkze+e1i23Jb3iFvDpiRUpC2Xf1qqMeQ5fb7+bWHJbZyXxuUWPys10Cx11ATKH9uHk8GnhPdwkmloQkHH/382BhVVxfi80BkZz/58I+MwyUuYuUXJzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386030; c=relaxed/simple;
	bh=m1lLm+WZC4v+Y35S1XB9lWwlw3k4bRL9Y21+zCpCDBQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Um1D4tgXWZ+RiGGxwS5csYJY3/xlJNIFMuCsmatRkIQKwcZl4sErfT8WwNnnyuq+HtXN5MFqR3SJfdNW0UE4Hv81evHmJQquZyoVB7LQDOkYmtc3UFH5YqbR4ztjsvjf5jsYrKLyc3Dg7cYTXB7uONgUcgfT2lsAokLmSDImxe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ctEn4gJS; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45EHR2TK020312;
	Fri, 14 Jun 2024 12:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718386022;
	bh=XewSngMq7bNS3KBsgmr6l1N/bnY3ToVln2WUXlo0Z6k=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=ctEn4gJSX5tYMgvzBRYJ6xnk2sDRV91wXRcrNTf5ZQZNAt70ruXZWxlT/miB39qNA
	 brez0qungSVOWIwhxbd6L5/IBP2y2kr6hinh7sp+RzwgAIc6UvNJrujtORIpzbntgT
	 WEDzoF35fLrbt7lEQvTPBP41UtqrZzzz79d4UAc0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45EHR2l5010617
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Jun 2024 12:27:02 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 12:27:01 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 12:27:01 -0500
Received: from localhost (udba0500997.dhcp.ti.com [128.247.81.249])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45EHR1gJ066390;
	Fri, 14 Jun 2024 12:27:01 -0500
Date: Fri, 14 Jun 2024 12:27:01 -0500
From: Brandon Brnich <b-brnich@ti.com>
To: Devarsh Thakkar <devarsht@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <praneeth@ti.com>, <a-bhatia1@ti.com>,
        <j-luthra@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-am62a7-sk: Reserve 576MiB of
 global CMA
Message-ID: <20240614172701.3xxs2ydagj3sjrwo@udba0500997>
References: <20240613150902.2173582-1-devarsht@ti.com>
 <20240613150902.2173582-3-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240613150902.2173582-3-devarsht@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Devarsh,

On 20:39-20240613, Devarsh Thakkar wrote:
> Reserve 576MiB of CMA as global CMA pool starting after initial 1GiB of
> DDR.
> 
> AM62ax has different multimedia components such as Camera, Display, H.264
> VPU and JPEG Encoder which use CMA for buffer allocations.
> 
> The 12x 720x480 realtime VPU decode use-case requires 544MiB of CMA,
> additional 32MiB is kept as buffer in case some other peripheral also
> require it while VPU is running.
> 
> The reason to choose latter 1GiB is to not overlap with existing memory map
> which is utilizing initial 1GiB for remoteproc firmwares as shared here
> [1].
> 
> Also some drivers such as JPEG require 32bit addressing so not allocating
> from higher DDR address.
> 
> Link: https://lore.kernel.org/all/20240605124859.3034-5-hnagalla@ti.com [1]
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>

I have validated that this patch works with VPU. 

Tested-by: Brandon Brnich <b-brnich@ti.com>

Best,
Brandon

> ---
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> index e026f65738b3..67faf46d7a35 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> @@ -40,6 +40,15 @@ reserved-memory {
>  		#size-cells = <2>;
>  		ranges;
>  
> +		/* global cma region */
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			size = <0x00 0x24000000>;
> +			alloc-ranges = <0x00 0xc0000000 0x00 0x24000000>;
> +			linux,cma-default;
> +		};
> +
>  		secure_tfa_ddr: tfa@9e780000 {
>  			reg = <0x00 0x9e780000 0x00 0x80000>;
>  			alignment = <0x1000>;
> -- 
> 2.39.1
> 

