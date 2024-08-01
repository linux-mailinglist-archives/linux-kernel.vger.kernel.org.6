Return-Path: <linux-kernel+bounces-270902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C569446D2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4791D1F2531A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7374B16EC00;
	Thu,  1 Aug 2024 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JY/ZaKic"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A5116DC35;
	Thu,  1 Aug 2024 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501758; cv=none; b=eVMnbgka535ohuzp+MKiT7k/wMkKklWki4MEgj5bGNFNqdftMuNoiDzuIRFPs0NYYDxhjtHgQxtZSoHT4B/NIWzm3Z4GOp4VqophhWez/XjsUybOyxz/b/onffFlmO2P5x8RLmefKLR2ND7IcHT/6idqh1Tn1gC8F3OSvcnKRiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501758; c=relaxed/simple;
	bh=N9KouQbbI1+nDypmiL3+dWzkOL29t/edZhc21iB9p1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbrubsBNY2vhdQ0J6Vg0kvKv6mJ2oUzfr8742EObGUSHm2rEKzrA7zAZAzM9xrVcTuHt1QfYdWfbe6iaF8Hc90mEM1rpMrpZmhYyPSHA+v4Q+DS4UuaM16iq58Z7Lh9QGHsVGlnt0qo5D1ePg4RXe+vkmVITeQv5eYy39k4RdPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JY/ZaKic; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722501757; x=1754037757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N9KouQbbI1+nDypmiL3+dWzkOL29t/edZhc21iB9p1E=;
  b=JY/ZaKicwQtZoeTgtGYC335DKuOmHZbgiQ/OLf5+sVu33+OS3qoiCSiN
   Fca0MNA9uBiN7CcYg7ghzYIYwnxZnoD6pn8v1bbn9OpQyqvRyfyrlfSTo
   /IYVc12uomBHHtUOZY1Xysu24zjTYtWGFpc931noP5loFNsWrzlIJhkqi
   To7E8ioj9ykKwXIlIyDr5c7ZSpeVgL9mo5tOHZy4a/EuNgU4lBBZnKfAt
   TH7TjCj5G2yRecis2hpOLR47lxEAjqWSGLM3DRmsQFQ0FJmVy9TtIVm7r
   lYq59mRC4v3pKVpLzuH0f6LC1LgRyWCA5zLqYpNAS4Zt9WC/n6atLTD9f
   g==;
X-CSE-ConnectionGUID: YZUfrU82TR6wcOUV6Og1YA==
X-CSE-MsgGUID: nqkcmdIFTaig1H6EhQ2jsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="37903952"
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="37903952"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 01:42:36 -0700
X-CSE-ConnectionGUID: s7RDhoKZQO67FgexHK40nw==
X-CSE-MsgGUID: f1bOP/cJTeyuaJVzbDqSYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="59812235"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa003.jf.intel.com with SMTP; 01 Aug 2024 01:42:32 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 01 Aug 2024 11:42:31 +0300
Date: Thu, 1 Aug 2024 11:42:31 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v3] usb: typec: fsa4480: Check if the chip is really there
Message-ID: <ZqtKd8Cin4TvcVH+@kuha.fi.intel.com>
References: <20240729-topic-fs4480_check-v3-1-f5bf732d3424@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729-topic-fs4480_check-v3-1-f5bf732d3424@kernel.org>

On Mon, Jul 29, 2024 at 10:42:58AM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Currently, the driver will happily register the switch/mux devices, and
> so long as the i2c master doesn't complain, the user would never know
> there's something wrong.
> 
> Add a device id check (based on [1]) and return -ENODEV if the read
> fails or returns nonsense.
> 
> Checking the value on a Qualcomm SM6115P-based Lenovo Tab P11 tablet,
> the ID mentioned in the datasheet does indeed show up:
>  fsa4480 1-0042: Found FSA4480 v1.1 (Vendor ID = 0)
> 
> [1] https://www.onsemi.com/pdf/datasheet/fsa4480-d.pdf
> 
> Fixes: 1dc246320c6b ("usb: typec: mux: Add On Semi fsa4480 driver")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v3:
> - Don't sign off twice
> - Pick up Dmitry's rb
> - Link to v2: https://lore.kernel.org/r/20240726-topic-fs4480_check-v2-1-901ca449db15@kernel.org
> 
> Changes in v2:
> - Prepend the new defines with FSA4480_ to make them more obvious
> - Link to v1: https://lore.kernel.org/r/20240212-topic-fs4480_check-v1-1-d9969e4d6f9a@linaro.org
> ---
>  drivers/usb/typec/mux/fsa4480.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/usb/typec/mux/fsa4480.c b/drivers/usb/typec/mux/fsa4480.c
> index cb7cdf90cb0a..cd235339834b 100644
> --- a/drivers/usb/typec/mux/fsa4480.c
> +++ b/drivers/usb/typec/mux/fsa4480.c
> @@ -13,6 +13,10 @@
>  #include <linux/usb/typec_dp.h>
>  #include <linux/usb/typec_mux.h>
>  
> +#define FSA4480_DEVICE_ID	0x00
> + #define FSA4480_DEVICE_ID_VENDOR_ID	GENMASK(7, 6)
> + #define FSA4480_DEVICE_ID_VERSION_ID	GENMASK(5, 3)
> + #define FSA4480_DEVICE_ID_REV_ID	GENMASK(2, 0)
>  #define FSA4480_SWITCH_ENABLE	0x04
>  #define FSA4480_SWITCH_SELECT	0x05
>  #define FSA4480_SWITCH_STATUS1	0x07
> @@ -251,6 +255,7 @@ static int fsa4480_probe(struct i2c_client *client)
>  	struct typec_switch_desc sw_desc = { };
>  	struct typec_mux_desc mux_desc = { };
>  	struct fsa4480 *fsa;
> +	int val = 0;
>  	int ret;
>  
>  	fsa = devm_kzalloc(dev, sizeof(*fsa), GFP_KERNEL);
> @@ -268,6 +273,15 @@ static int fsa4480_probe(struct i2c_client *client)
>  	if (IS_ERR(fsa->regmap))
>  		return dev_err_probe(dev, PTR_ERR(fsa->regmap), "failed to initialize regmap\n");
>  
> +	ret = regmap_read(fsa->regmap, FSA4480_DEVICE_ID, &val);
> +	if (ret || !val)
> +		return dev_err_probe(dev, -ENODEV, "FSA4480 not found\n");
> +
> +	dev_dbg(dev, "Found FSA4480 v%lu.%lu (Vendor ID = %lu)\n",
> +		FIELD_GET(FSA4480_DEVICE_ID_VERSION_ID, val),
> +		FIELD_GET(FSA4480_DEVICE_ID_REV_ID, val),
> +		FIELD_GET(FSA4480_DEVICE_ID_VENDOR_ID, val));
> +
>  	/* Safe mode */
>  	fsa->cur_enable = FSA4480_ENABLE_DEVICE | FSA4480_ENABLE_USB;
>  	fsa->mode = TYPEC_STATE_SAFE;

thanks,

-- 
heikki

