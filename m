Return-Path: <linux-kernel+bounces-232338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EF491A70E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97871F278D0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284FC179943;
	Thu, 27 Jun 2024 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e9Lm/KO8"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494116130C;
	Thu, 27 Jun 2024 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493044; cv=none; b=Nr09A9ldQW4yGmrJb8pKC6h2I49WBmJy5GvbrgxQuc4xFVstYWyiseE7v3TFjj/GX9TJsLeZRCVRvgJcj3d9thwRNP/cZsAW6/aFQPo0o7nShblZlkGlZhlvPSw+O7ZJUmp0/X4xR6chkvryTFkaDLTOUj/O/ofYHUY0nbVCTU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493044; c=relaxed/simple;
	bh=+EZGP8C/QSVQrNzkCJgw0uHVsjmUzyJntRjHPoiB2Hw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdnUZyOfWIV8BsM1U4m/SboJ63OpY86whTSpcisZiqL828uQph6BT0AHGNbeZ0ZqSh43U7Ea0fy8apGmgPZtBxx1sw4NTCUESi3WIlt/MNuDFZG+NWDAuOp5NZ/ETv5K71DyCmVbG8X7SwsHRpUR2jfa4LDN2fwNUCprpbtR4jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=e9Lm/KO8; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45RCvDsJ114348;
	Thu, 27 Jun 2024 07:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719493033;
	bh=1hw4SXvdnqlCtVk+B4ERB7zZZCcPRDyE+ZeQxTZiBXs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=e9Lm/KO8FUNWAm71EZP9WI3ml0fUGlcH9tAkxcCLpsf8YiSdXvtX5kEJSA4k9d8pE
	 1hqvfw7+WvP3x5ysWT3O6ye7OehCV+Ncc0dguVNVU7H+uPbTJqYNVgq0fAusYEg+gC
	 nqnrsA0lSKru11kjdTNQkNkMqlsWcKGO+lRTysaI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45RCvDUE017982
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Jun 2024 07:57:13 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 07:57:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 07:57:13 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45RCvDJW049365;
	Thu, 27 Jun 2024 07:57:13 -0500
Date: Thu, 27 Jun 2024 07:57:13 -0500
From: Nishanth Menon <nm@ti.com>
To: Jonathan Humphreys <j-humphreys@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-evm/sk: Set serial console
 settings for stdout-path
Message-ID: <20240627125713.gnesqkrilb2ihv7u@heritage>
References: <20240617205143.3147509-1-j-humphreys@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240617205143.3147509-1-j-humphreys@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 15:51-20240617, Jonathan Humphreys wrote:
> Set serial console UART settings in the DT so that generic distros will
> work even if the OS loader doesn't explicitly pass it.
> 
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts | 2 +-
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> index e20e4ffd0f1f..d63293d85d5f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> @@ -18,7 +18,7 @@ / {
>  	model = "Texas Instruments AM642 EVM";
>  
>  	chosen {
> -		stdout-path = &main_uart0;
> +		stdout-path = "serial2:115200n8";
>  	};
>  
>  	aliases {
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> index 5b028b3a3192..c23730c395b5 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> @@ -18,7 +18,7 @@ / {
>  	model = "Texas Instruments AM642 SK";
>  
>  	chosen {
> -		stdout-path = &main_uart0;
> +		stdout-path = "serial2:115200n8";

let the baudrate and uart settings be set by userspace as desired. Also
see commit 6b343136388fe1ef5837e45ab921705de76665ee

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

