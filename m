Return-Path: <linux-kernel+bounces-298525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1584495C863
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC1C284B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583941482F0;
	Fri, 23 Aug 2024 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gp44Cj1z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF9944C76
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724403053; cv=none; b=nMgerCmzqFL33MniEnQTaBfn3QEFQugxtBOXW6Baq1F2cuaSh2Eh4HanQxBurYcy9VrUSodElu5Qk/sZifwuirvHABEJr4joY798npKIgHwtQLlXaSiAWVPEkx5prRADLfJLqyAOez2R65OE39qGFpSkou6xATSlNEQ+hyqr5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724403053; c=relaxed/simple;
	bh=S4820Yj8epkSdTFs9Td/DHO5A96eHtVbmEjYzzVrkKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sxu9P7/t92/dZsZbayoeHNDHjbfsf0W+24NvRxv5CJUXav16PcqH7l5Ytxy+FFmYM75UANrLFwgBVPrfxOBXDdjNl884uOymia9FixdZpqY1wT1ble9PqKr+4+OCJdWNc2RSDjD0tYr0JvvvRl47+5V0dJTeOsG111Rz4oc0pCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gp44Cj1z; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724403051; x=1755939051;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S4820Yj8epkSdTFs9Td/DHO5A96eHtVbmEjYzzVrkKE=;
  b=gp44Cj1zszbeaHueZOQJz4A3vZmGfeD3Arzcwl7pg7nMpYrfQt0T74F+
   TTzZDIClJuhYyb8GOSuPAmIMlzcT1TX/RRDPGIGgIs3PVLm5ev9azVjbP
   /bWzui23vs7/9uqPIx/Ig9IcbayC18Z2tPw8fweGVsaxi/xOfHX52tkjX
   tfpYxORK2UzZT2ZOP9mTX3dvntwys8XbhTH8/LJDJDGCqL5Il1NTHCWu3
   /iHQumCwx7iQ1elQ1ZkFXhfODyYHGVgXBjPJdPN23021Z6QsqS0xfF+Jz
   Aj613ZNf5akWbBL0k/BpjCx1ZivsLMg7UJlVqmYlUhaeZQm0Az7OwGN6w
   g==;
X-CSE-ConnectionGUID: X4JZnnCmQraKM916Z/x2CA==
X-CSE-MsgGUID: KCVti8/MSyuzyQk+nblD7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22671272"
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="22671272"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 01:50:51 -0700
X-CSE-ConnectionGUID: iv/lGtahQDqenJfIU935KQ==
X-CSE-MsgGUID: /EvWJKMYS0mXx8taZkTpig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="66055615"
Received: from mylly.fi.intel.com (HELO [10.237.72.154]) ([10.237.72.154])
  by fmviesa005.fm.intel.com with ESMTP; 23 Aug 2024 01:50:49 -0700
Message-ID: <c394ba6d-c219-4b9f-aa6b-3a48389c317a@linux.intel.com>
Date: Fri, 23 Aug 2024 11:50:48 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] i3c: mipi-i3c-hci: Read HC_CONTROL_PIO_MODE only
 after i3c hci v1.1
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240821133554.391937-1-Shyam-sundar.S-k@amd.com>
 <20240821133554.391937-3-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20240821133554.391937-3-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 8/21/24 4:35 PM, Shyam Sundar S K wrote:
> The HC_CONTROL_PIO_MODE bit was introduced in the HC_CONTROL register
> starting from version 1.1. Therefore, checking the HC_CONTROL_PIO_MODE bit
> on hardware that adheres to older specification revisions (i.e., versions
> earlier than 1.1) is incorrect. To address this, add an additional check
> to read the HCI version before attempting to read the HC_CONTROL_PIO_MODE
> status.
> 
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>   drivers/i3c/master/mipi-i3c-hci/core.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> index b02fbd7882f8..d1952a5619d4 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> @@ -33,6 +33,7 @@
>   #define reg_clear(r, v)		reg_write(r, reg_read(r) & ~(v))
>   
>   #define HCI_VERSION			0x00	/* HCI Version (in BCD) */
> +#define HCI_VERSION_V1			0x100   /* MIPI HCI Version number v1.0 */
>   
>   #define HC_CONTROL			0x04
>   #define HC_CONTROL_BUS_ENABLE		BIT(31)
> @@ -756,7 +757,7 @@ static int i3c_hci_init(struct i3c_hci *hci)
>   	/* Try activating DMA operations first */
>   	if (hci->RHS_regs) {
>   		reg_clear(HC_CONTROL, HC_CONTROL_PIO_MODE);
> -		if (reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE) {
> +		if (regval > HCI_VERSION_V1 && (reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE)) {
>   			dev_err(&hci->master.dev, "PIO mode is stuck\n");
>   			ret = -EIO;
>   		} else {

Actually here after this patch regval doesn't contain the version but 
HC_CONTROL which is read some line above. HCI_VERSION read is added by 
the patch 3/6 so this patch alone may cause a regression.

I'd say better to use already set hci->version_major and 
hci->version_minor since then code is not vulnerable if some other 
regval = reg_read(OTHER_REG) is added later before this code block.

