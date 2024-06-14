Return-Path: <linux-kernel+bounces-214573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E60190869D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7261C20CCF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C652818C32B;
	Fri, 14 Jun 2024 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HJ7die3K"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5F4186E4B;
	Fri, 14 Jun 2024 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354512; cv=none; b=AD5qQkB1hC2HaIb/E+s6aMi/4pvONndku983mi/NSECDbkIVf3UlYQIt7QuEkd+Vx68maThe5niW4Jh8ioPgImNe7j8bam5+KLCOFWRlOPVLZO1vE4YfXQT/cONOWbmpIIF5CmjuWrbca4FJylIrxey2jilZGaDg+8MmUBYQB2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354512; c=relaxed/simple;
	bh=On7Y/DDU3GkgnfqvHOUglKP6bFOHQHpoQr+HpbT+xLA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyoYn395rz8v5H1SFp/GLSlgcK4Im1mv5lgD+yjIprLpcq9mR01HUE9K0HFiaeneX1pPSMqLWIiQ3BSK19bUlRd+ZUSAwOFiNVKb8oKMIyYmC2gec+zOywbtYbgSLqOy59RhlgWSH0jS4T4c5p1MIqJkADK7WaihZTbR41ZfWzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HJ7die3K; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45E8febQ012182;
	Fri, 14 Jun 2024 03:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718354500;
	bh=1fUXeG+uZBVXVqCXgr832W2bhJnWN9uWXVLoh5IRUgo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=HJ7die3KmTRIGSSZAOoItyfhcviiCwZb4mvpkbdcQ36L/eEKKmbLD7rS8F+aoYBYg
	 MQfr3+a/QwDlnexioZr7TIfy1uQziVxIeGO4fX7VnUySYlBlUqsgH3PgvLIrs6mlBJ
	 k2f469vYP5cVQhydZa/T1v71JoOfFZFsl/XdkOfg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45E8feuE102641
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Jun 2024 03:41:40 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 03:41:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 03:41:40 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45E8fddN044560;
	Fri, 14 Jun 2024 03:41:39 -0500
Date: Fri, 14 Jun 2024 14:11:38 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Jayesh Choudhary <j-choudhary@ti.com>
CC: <linux-kernel@vger.kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <robh@kernel.org>, <u-kumar1@ti.com>, <kristo@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j722s-evm: Enable analog audio
 support
Message-ID: <4jf5dh54yc3jvvhacdcx52nfsk2uhuab7dvbnjulm45uqp4dse@artxmi5a2ebu>
References: <20240612051246.41117-1-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240612051246.41117-1-j-choudhary@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Jayesh,

Thanks for the patch.

On Jun 12, 2024 at 10:42:46 +0530, Jayesh Choudhary wrote:
> The audio support on J722S-EVM is using TLV320AIC3106[0] codec
> connected to McASP1 serializers.
> 
> - Add the nodes for sound-card, audio codec and McASP1.
> - Add hog for TRC_MUX_SEL to select between McASP and TRACE signals
> - Add hogs for GPIO_AUD_RSTn and MCASP1_FET_SEL which is used to
>   switch between HDMI audio and codec audio.
> - Add pinmux for MCASP1 and AUDIO_EXT_REFCLK1.
> - Add syscon node for audio_refclk1 to set the enable bit in
>   CTRL_MMR reg and select the parent clock for the external clock.
> 
> [0]: <https://www.ti.com/lit/gpn/TLV320AIC3106>
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>

Reviewed-By: Jai Luthra <j-luthra@ti.com>

> ---
> 
> This patch depends upon the bcdma driver fix posted upstream:
> <https://lore.kernel.org/all/20240607-bcdma_chan_cnt-v2-1-bf1a55529d91@ti.com/>
> 
> v1 patch:
> <https://lore.kernel.org/all/20240611082820.17442-1-j-choudhary@ti.com/>
> 
> Changelog v1->v2:
> - Fix dtb warning for pin-muxing
> 
>  arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 121 ++++++++++++++++++++++++
>  1 file changed, 121 insertions(+)
> 
[...]
> 

-- 
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

