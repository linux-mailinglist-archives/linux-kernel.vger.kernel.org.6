Return-Path: <linux-kernel+bounces-274751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A4A947C43
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06B5FB217B3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36B2762D0;
	Mon,  5 Aug 2024 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="claQdTGS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A59355E73;
	Mon,  5 Aug 2024 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866071; cv=none; b=fe4slpVp067hiDpNM3BS05mYbA1hKL4LmNWF07P42n4EKbZ4/MegnYj3Bml6f9O7pZIOLKxIo3CWMC0xbi9XmlW/iwLS9pRJAaaWJ9bPQ7CR/ft2elfQeLXWwWiPuBplogZPPLLkxBpbCG3Hi6ZetKmPPenixq2/1XjH1/p1CWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866071; c=relaxed/simple;
	bh=BncnyQonmJ5+HmLoE7oS88pIgg0LaOFqG5VcpwZrO4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5uaIe7YOPE+8ldV/il6hBQBWGGaRJqjhUFlIZ7ou3RcDqTmQk2fY4wDJMCbxbbJPdPos20vglAZPZv7u9LsOpMM95T9tCqyHsr4G6wMaWzcgUgV04uV0NKBB51zNx/96fLRtpk8gIjyfaLgmOyCehUQ8F/7yx7Qx2JlrouSCUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=claQdTGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA264C32782;
	Mon,  5 Aug 2024 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722866071;
	bh=BncnyQonmJ5+HmLoE7oS88pIgg0LaOFqG5VcpwZrO4E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=claQdTGSpGAqM40GuXdBs1yWHEy4DZz79ft29R6GbokVsZ8F4XOHs18Q3ipoTQW7e
	 oKWS8tgz1jwbs4lZAPqGvd3ZdySBQ63wMCp0t1c5YsYDOTkflkDJ+FZ/zO3WOdSmi9
	 fMXflvuwb9Y46/u7kLpn9wlXuOdHblrj1a+kf/fhz3jXC0r/BYRT8p9CBXr2aUGP1Q
	 Fn9SL24zBYBQNJr2deVfGnkeM8YWBS0g0QeKRoHkkhkFx3+KWc4jIjNDfyaaVjW2uj
	 6MKfhha5LUxY0Hcg0s7LRVlccttt25IYLNmQt/36D+I4ha+ykur8DGaIqYfJAnLaAa
	 t9bB3is/N0FBg==
Message-ID: <0a634553-023c-4a46-8743-28357021c689@kernel.org>
Date: Mon, 5 Aug 2024 16:54:24 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/12] usb: cdns3-ti: add J7200 support with
 reset-on-resume behavior
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Chen <peter.chen@kernel.org>,
 Pawel Laszczak <pawell@cadence.com>, Mathias Nyman
 <mathias.nyman@intel.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Kevin Hilman <khilman@kernel.org>,
 =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
 <20240726-s2r-cdns-v5-7-8664bfb032ac@bootlin.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240726-s2r-cdns-v5-7-8664bfb032ac@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/07/2024 21:17, Théo Lebrun wrote:
> Add ti,j7200-usb compatible. Match data indicates the controller resets
> on resume which tells that to the cdns3 core. This in turn silences a
> xHCI warning visible in cases of unexpected resets.
> 
> We also inherit the errata quirk CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE from
> the default `cdns_ti_auxdata` configuration.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/usb/cdns3/cdns3-ti.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
> index 159814dfc856..65b8b6f4c654 100644
> --- a/drivers/usb/cdns3/cdns3-ti.c
> +++ b/drivers/usb/cdns3/cdns3-ti.c
> @@ -258,7 +258,21 @@ static const struct of_dev_auxdata cdns_ti_auxdata[] = {
>  	{},
>  };
>  
> +static struct cdns3_platform_data cdns_ti_j7200_pdata = {
> +	.quirks = CDNS3_RESET_ON_RESUME |

But you mentioned that the behavior can be different based on which
idle state the system went into.
Setting this flag will means Reset is required on every resume.


Instead, you just need to rely on the runtime check and set the xhci->lost_power flag at resume.


> +		  CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE,   /* Errata i2409 */
> +};
> +
> +static const struct of_dev_auxdata cdns_ti_j7200_auxdata[] = {
> +	{
> +		.compatible = "cdns,usb3",
> +		.platform_data = &cdns_ti_j7200_pdata,
> +	},
> +	{},
> +};
> +
>  static const struct of_device_id cdns_ti_of_match[] = {
> +	{ .compatible = "ti,j7200-usb", .data = cdns_ti_j7200_auxdata },
>  	{ .compatible = "ti,j721e-usb", .data = cdns_ti_auxdata },
>  	{ .compatible = "ti,am64-usb", .data = cdns_ti_auxdata },
>  	{},
> 

-- 
cheers,
-roger

