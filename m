Return-Path: <linux-kernel+bounces-208160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779229021AF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9FD9B210EE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E7380026;
	Mon, 10 Jun 2024 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pX6Q1Vb5"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3ED335A7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718022814; cv=none; b=a6gaifbbfQGVdmGHCtHa8m65PNvzRdZ7fAed17sBHQD7sc2NoQOPJM6av+A0BX/FC0CabIKrXCGMCGi/KgFuPlCnJJ4k2XZH1G5J8UxBST0Ka04W3DVuhjeNXi7SX+esK8t4R0yDcyzFYg+6InRD8GIYmDcMwmOgaIPNzWm9rRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718022814; c=relaxed/simple;
	bh=DSWJ46P/7UUx3bZu8iw6iWx6IOyRJj+hlgFqEdJZuys=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Da+HThzfvlrlWm8x+bs+WSzP9mZ9sOg/gC9PQP0y0G1/vPDkpeLBjQSsx70LDn2XuCxuO/9KwD1sZMD0kPGWFT3Ag37kiXBSlZrxhJlGlACBwuRh2HLRAJ0wydfBnLztIH2ar/xnErcCzmQJqF5vvX0VN0Pbj2OLYHPXAdGewco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pX6Q1Vb5; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45ACWoCR028348;
	Mon, 10 Jun 2024 07:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718022770;
	bh=CfvAuWxdUhU86zISdqqJU3GNhSiPKLLZfNnPIUxxhK8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=pX6Q1Vb53ct/2PIGyhPoWbUFZ8pcTx2Puk3MLp+u6MqOQM51E1ulb1lq4p53nmv9e
	 Y91aDdYcSrraHbGWUmTYnYviiH/rvWTw87nKuYDCWdsJ1+TNiYDcHD4NrgrF2lvFBU
	 UBD1HqhBnkM9ftSQrCcv0F/s0HKODopsu0HyV9MM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45ACWovS008018
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 07:32:50 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 07:32:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 07:32:49 -0500
Received: from [172.24.227.31] (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45ACWf7e116795;
	Mon, 10 Jun 2024 07:32:42 -0500
Message-ID: <a78d5ddf-38d8-4b54-a9b3-7a8745d3b537@ti.com>
Date: Mon, 10 Jun 2024 18:02:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] drm/bridge: cdns-dsi: Support atomic bridge APIs
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Andrzej Hajda
	<andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert
 Foss <rfoss@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej
 Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Jyri
 Sarha <jyri.sarha@iki.fi>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        DRI Development
 List <dri-devel@lists.freedesktop.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, Thierry
 Reding <treding@nvidia.com>,
        Kieran Bingham
	<kieran.bingham+renesas@ideasonboard.com>,
        Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh
 Choudhary <j-choudhary@ti.com>, Jai Luthra <j-luthra@ti.com>
References: <20240530093621.1925863-1-a-bhatia1@ti.com>
 <20240530093621.1925863-8-a-bhatia1@ti.com>
 <4fsu5fa5zbrqgc5bepxscoenrax5c6p5b4eyomavioy3bhwuq3@rjjbur3v52e3>
Content-Language: en-US
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <4fsu5fa5zbrqgc5bepxscoenrax5c6p5b4eyomavioy3bhwuq3@rjjbur3v52e3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Dmitry,

Thank you for reviewing the patches.

On 31/05/24 04:51, Dmitry Baryshkov wrote:
> On Thu, May 30, 2024 at 03:06:19PM +0530, Aradhya Bhatia wrote:
>> Change the existing (and deprecated) bridge hooks, to the bridge
>> atomic APIs.
>>
>> Add drm helpers for duplicate_state, destroy_state, and bridge_reset
>> bridge hooks.
>>
>> Further add support for the input format negotiation hook.
>>
>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>> ---
>>  .../gpu/drm/bridge/cadence/cdns-dsi-core.c    | 70 ++++++++++++++++---
>>  1 file changed, 62 insertions(+), 8 deletions(-)
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Minor nit below.
> 
>>
>> @@ -915,13 +920,62 @@ static void cdns_dsi_bridge_pre_enable(struct drm_bridge *bridge)
>>  	cdns_dsi_hs_init(dsi);
>>  }
>>  
>> +static u32 *cdns_dsi_bridge_get_input_bus_fmts(struct drm_bridge *bridge,
>> +					       struct drm_bridge_state *bridge_state,
>> +					       struct drm_crtc_state *crtc_state,
>> +					       struct drm_connector_state *conn_state,
>> +					       u32 output_fmt,
>> +					       unsigned int *num_input_fmts)
>> +{
> 
> This code below looks pretty generic. Would be logical to extract it to
> a helper and allow it to be used by other DSI host bridges?

I agree, it would indeed make sense.

I just tried to make a helper function that could directly be passed to
the drm_bridge_funcs list - like we do with
"drm_atomic_helper_bridge_propagate_bus_fmt". This would have been ideal
in my opinion.

But, that doesn't seem possible today. The parameter "output_fmt"
doesn't describe any of the DSI pixel formats from "enum
mipi_dsi_pixel_format", which is what's required to ascertain the input
bus format for dsi hosts. Neither do the drm_bridge{_state} help with
that.

For now, I am thinking to just add a common function that accepts the
dsi bus output format and returns the corresponding input bus format.
With this, every dsi host will still need to implement their own
get_input_fmt hook and call that function.

If you had something else in mind, do let me know! =)

Regards
Aradhya

> 
>> +	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
>> +	struct cdns_dsi *dsi = input_to_dsi(input);
>> +	struct cdns_dsi_output *output = &dsi->output;
>> +	u32 *input_fmts;
>> +
>> +	*num_input_fmts = 0;
>> +
>> +	input_fmts = kzalloc(sizeof(*input_fmts), GFP_KERNEL);
>> +	if (!input_fmts)
>> +		return NULL;
>> +
>> +	switch (output->dev->format) {
>> +	case MIPI_DSI_FMT_RGB888:
>> +		input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
>> +		break;
>> +
>> +	case MIPI_DSI_FMT_RGB666:
>> +		input_fmts[0] = MEDIA_BUS_FMT_RGB666_1X24_CPADHI;
>> +		break;
>> +
>> +	case MIPI_DSI_FMT_RGB666_PACKED:
>> +		input_fmts[0] = MEDIA_BUS_FMT_RGB666_1X18;
>> +		break;
>> +
>> +	case MIPI_DSI_FMT_RGB565:
>> +		input_fmts[0] = MEDIA_BUS_FMT_RGB565_1X16;
>> +		break;
>> +
>> +	default:
>> +		/* Unsupported DSI Format */
>> +		return NULL;
>> +	}
>> +
>> +	*num_input_fmts = 1;
>> +
>> +	return input_fmts;
>> +}
>> +
> 

