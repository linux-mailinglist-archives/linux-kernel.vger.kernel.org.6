Return-Path: <linux-kernel+bounces-278920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 366C594B69F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E9A283F63
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68240186E37;
	Thu,  8 Aug 2024 06:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lk/1kyGB"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA539186287;
	Thu,  8 Aug 2024 06:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723098107; cv=none; b=CUGv1LZMU2hG/BNvg4dNcuUrNA2DdEU/VM7wEpSbll3YRxozOOhEYyfogSMXWjCnDj9G6/Fmn2XZr+Wy6a96GMcD16ciRvxBdMmPsutdjmYSW0xgdp8vEBuxpBRICCyT4ZeUyuZGw4hcaLGDF5o2cQlblgc3iAdRNAFfMlREfXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723098107; c=relaxed/simple;
	bh=jpLNvjxdVEi+BUave8sff5gtGoB1Z2gLoxOBl+Q2aFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cQgX8txZHC6ExoAMMsXf7wRAFIkF3Izn0GFptrSrhMcCtyyw7/BHBlSTu9QDXd4HOey4Eoq//BEhMcIh3VVQLvdA/QowVIg6wSpVdZHFNqfbjmJUclsu3gfyiOyyGo9z7j4TGGOauEi7gxGWGtsuBrVc1t516Ts5VTHFbZ9neQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lk/1kyGB; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4786LbNp103834;
	Thu, 8 Aug 2024 01:21:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723098097;
	bh=mYeZTB/P7COTWpl2PPGfjqerrY3e2tbfbb8ZLpejTHQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=lk/1kyGBQuDSh4MhYXNE5NmhYr0qr9NbcUCLjumfPev9LaGHAoppt807Kk1fOqu8H
	 CvCCpnl3b6eEpVy8eX7HjTiLzEOmHmBAWcqEpIX+g+5VLbGLlj74cZiexpslUCPc04
	 hvlE71h85p7YV8mLUFp+dlOVk9ZLfEa81RlIBcJ8=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4786Lbas046753
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 01:21:37 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 01:21:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 01:21:36 -0500
Received: from [172.24.227.36] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4786LWuF018091;
	Thu, 8 Aug 2024 01:21:33 -0500
Message-ID: <8fa39624-9a92-404d-8651-9ade5700a7d3@ti.com>
Date: Thu, 8 Aug 2024 11:51:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am68-sk-base-board: Add clklb pin mux
 for mmc1
To: Bhavya Kapoor <b-kapoor@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <m-chawdhry@ti.com>, <vigneshr@ti.com>, <nm@ti.com>,
        <sinthu.raja@ti.com>
References: <20240807101624.2713490-1-b-kapoor@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240807101624.2713490-1-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Bhavya

On 07/08/24 15:46, Bhavya Kapoor wrote:
> mmc1 was not functional since pin mux for clklb was not present.
> Thus, add clklb pin mux to get MMC working.
> 
> Fixes: a266c180b398 ("arm64: dts: ti: k3-am68-sk: Add support for AM68 SK base board")
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
> 
> rebased to next-20240807
> 
>   arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> index 90dbe31c5b81..d5ceab79536c 100644
> --- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> @@ -204,6 +204,7 @@ main_mmc1_pins_default: main-mmc1-default-pins {
>   		pinctrl-single,pins = <
>   			J721S2_IOPAD(0x104, PIN_INPUT, 0) /* (P23) MMC1_CLK */
>   			J721S2_IOPAD(0x108, PIN_INPUT, 0) /* (N24) MMC1_CMD */
> +			J721S2_IOPAD(0x100, PIN_INPUT, 0) /* (###) MMC1_CLKLB */
>   			J721S2_IOPAD(0x0fc, PIN_INPUT, 0) /* (M23) MMC1_DAT0 */
>   			J721S2_IOPAD(0x0f8, PIN_INPUT, 0) /* (P24) MMC1_DAT1 */
>   			J721S2_IOPAD(0x0f4, PIN_INPUT, 0) /* (R24) MMC1_DAT2 */

How is this different from the P23 pinmux for MMC1_CLK? Could you explain what 
CLKLB is, since it doesn't have a ball number I'm finding it difficult to 
understand what it is?

-- 
Thanking You
Neha Malcom Francis

