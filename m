Return-Path: <linux-kernel+bounces-349914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C7898FD3C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3821C22257
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 06:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7528F1311B5;
	Fri,  4 Oct 2024 06:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4o9pnFC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114F184E14;
	Fri,  4 Oct 2024 06:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728022810; cv=none; b=KneuobzxfyJRTmLqEC+hydbOA5kd0T9BBC5NJcsCdfc5g6hOrgCl52LQCpoVbrABaDT2xiOAYxWvd8x23qNKGQbB4+ajxU0p0/RSpB3t3EXfGtfL2dYDtnQvP780cDcxQj0szjpKloJUgyCnUpPm27fE56hg9XqVZhaq0fNBNog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728022810; c=relaxed/simple;
	bh=u0ROQGIKvHYwdRfflIP+jEihYIQYG+R7/MJxd3/po+Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NqO6f648D25a9hYA8241bk+KiI6Xb0EYlloCEDkgyqoqLSvbJlbDVhLxqOEkcLBd8hO0sImF4oUxNCvMwI1UvDWXcgRNM14Pk1tasdCT+KYgxLOjnpDbinnZRl5monc6fyAq9O0MfKF1TAzu9+ziccKIXuIllFqbU+FXQ+ub3vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4o9pnFC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728022809; x=1759558809;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=u0ROQGIKvHYwdRfflIP+jEihYIQYG+R7/MJxd3/po+Q=;
  b=n4o9pnFCnrYvZ2Jfy/wO2Z4TrxyGquWCfcernkKYG3YqisMpWtXgRNnc
   kjbSpHTWahuI/ofkZMnCDS7TMJPE+yKedEuAL5F5NfnyZKT7iushPOhNm
   wHMjaTobmPgiXIutNtNYNaKE3KGAT4vmgU80IFrEhzHlVlWr8CX++sM2v
   P/s804VhI1Ufen3m714hvkBdE0JVE/r0nRTXdr5Ty05/B2cUX7lVfiDD1
   D9AIub3K3yAioTbtSrD5n6SrkTf5FS4UNEF+MZJrDoFyTibJYDlacFy/j
   1L0ocqUTXCbcqpixXxl8cRukBSDw6/mI5hhwqgO0moZr5A1T2dqI4xRZe
   w==;
X-CSE-ConnectionGUID: wb8OLJV3QROMeudHtGC6Zw==
X-CSE-MsgGUID: Hz1/9c9yT6GO378GfHBvXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="26704163"
X-IronPort-AV: E=Sophos;i="6.11,176,1725346800"; 
   d="scan'208";a="26704163"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 23:20:08 -0700
X-CSE-ConnectionGUID: Mg9fEK4RTNy1I03QnObZ2w==
X-CSE-MsgGUID: v+UZnQapRpKt/A1Lf/CftA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,176,1725346800"; 
   d="scan'208";a="74860934"
Received: from kkruthiv-mobl1.gar.corp.intel.com (HELO [10.247.176.17]) ([10.247.176.17])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 23:20:03 -0700
Message-ID: <5862746f-d594-4e7e-9b54-c5ea77596ef6@intel.com>
Date: Fri, 4 Oct 2024 11:49:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/bridge: sii902x: Provide data-lines property to
 input endpoint
From: Aradhya Bhatia <aradhya.bhatia@intel.com>
To: Wadim Egorov <w.egorov@phytec.de>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, bbrezillon@kernel.org, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, upstream@lists.phytec.de
References: <20241003082006.2728617-1-w.egorov@phytec.de>
 <6523649b-9143-42d8-b301-a143088530b9@intel.com>
Content-Language: en-US
In-Reply-To: <6523649b-9143-42d8-b301-a143088530b9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 03-10-2024 15:13, Aradhya Bhatia wrote:
> Hi Wadim,
> 
> Thanks for the patch.
> 
> Probably a nit, but the dt-binding patch should come before the driver
> patch.
> 
> On 03-10-2024 13:50, Wadim Egorov wrote:
>> Introduce a data-lines property to define the number of parallel RGB
>> input pins connected to the transmitter. The input bus formats are updated
>> accordingly. If the property is not specified, default to 24 data lines.

One more thing. This driver also supports the older way of
encoder-bridge connections - that is, with no
DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.

In the sii902x_bridge_attach, you will see that the bus_format is being
statically assigned to MEDIA_BUS_FMT_RGB888_1X24. When the
ATTACH_NO_CONNECTOR flag is set, it doesn't matter. But when it is not,
the RGB888 bus format will get trickled back to the encoder even if the
dt property says differently.

>>
>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>> ---
>>  drivers/gpu/drm/bridge/sii902x.c | 27 ++++++++++++++++++++++++++-
>>  1 file changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
>> index 7f91b0db161e..3565c3533597 100644
>> --- a/drivers/gpu/drm/bridge/sii902x.c
>> +++ b/drivers/gpu/drm/bridge/sii902x.c
>> @@ -180,6 +180,8 @@ struct sii902x {
>>  	struct gpio_desc *reset_gpio;
>>  	struct i2c_mux_core *i2cmux;
>>  	bool sink_is_hdmi;
>> +	u32 pd_lines; /* number of Parallel Port Input Data Lines */
>> +
>>  	/*
>>  	 * Mutex protects audio and video functions from interfering
>>  	 * each other, by keeping their i2c command sequences atomic.
>> @@ -477,6 +479,8 @@ static u32 *sii902x_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
>>  						     u32 output_fmt,
>>  						     unsigned int *num_input_fmts)
>>  {
>> +

And this is probably a stray.

>> +	struct sii902x *sii902x = bridge_to_sii902x(bridge);
>>  	u32 *input_fmts;
>>  
>>  	*num_input_fmts = 0; 
>> @@ -485,7 +489,19 @@ static u32 *sii902x_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
>>  	if (!input_fmts)
>>  		return NULL;
>>  
>> -	input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
>> +	switch (sii902x->pd_lines) {
>> +	case 16:
>> +		input_fmts[0] = MEDIA_BUS_FMT_RGB565_1X16;
>> +		break;
>> +	case 18:
>> +		input_fmts[0] = MEDIA_BUS_FMT_RGB666_1X18;
>> +		break;
>> +	default:
> 
> For backward compatibility - in cases where the property is absent - you
> have already defaulted sii902x->pd_lines to 24 below, which I think is
> the right way.
> 
> So, the default case should be kept separately, as an error case -
> which should then return back NULL / num_input_fmts = 0.
> 
>> +	case 24:
>> +		input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
>> +		break;
>> +	}
>> +
>>  	*num_input_fmts = 1;
>>  
>>  	return input_fmts;
>> @@ -1167,6 +1183,15 @@ static int sii902x_probe(struct i2c_client *client)
>>  		return PTR_ERR(sii902x->reset_gpio);
>>  	}
>>
>> +	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 0, -1);
>> +	if (endpoint) {
>> +		ret = of_property_read_u32(endpoint, "data-lines", &sii902x->pd_lines);
>> +		if (ret) {
>> +			dev_dbg(dev, "Could not get data-lines, fallback to 24 data-lines\n");
>> +			sii902x->pd_lines = 24;
>> +		}
>> +	}
>> +
>>  	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 1, -1);
>>  	if (endpoint) {
>>  		struct device_node *remote = of_graph_get_remote_port_parent(endpoint);
> 
> --
> Regards
> Aradhya
> 

--
Regards
Aradhya

