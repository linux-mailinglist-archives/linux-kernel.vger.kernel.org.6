Return-Path: <linux-kernel+bounces-206463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CAE900A1E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555F51C22678
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055B919AA68;
	Fri,  7 Jun 2024 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RdwDewYH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55B019A2BA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776873; cv=none; b=gl3oU3VEo++2cDtLVgKbdbTeEoZzH4quf+vSRbuavZIr0MPOhoOp9cC+57ZS70Tr98VTQlLaKkj3eY32ziicHg/aGPXq9zcH0ULdqlP7qWFd0jJzftuft3gdQbXD70qH+tQ2QhDGjcivbuvQQ6C71wTkzwWb38Zfhf12BiZzzpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776873; c=relaxed/simple;
	bh=9strxmh/teWZJ6BahDMnrBoMEOAPAaV0j6k+qZDc3x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOIl3aIiYfI5OdLn22dno0t0zPKYTkj356pZnjgQ/Y5ulnMMGgMUsJg72/rV3NpBr3lg/QaRrjZa1Bi8kCLuA+sHm7a0Bnqq3iUdn0bj9yl+H9LEQzeHCckdWsmi4hLooZIhDTKDgFR254KaKA9/J0YnX1gor8p/ZQnUVd3NszM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RdwDewYH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717776872; x=1749312872;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9strxmh/teWZJ6BahDMnrBoMEOAPAaV0j6k+qZDc3x4=;
  b=RdwDewYH+2rwRhotCXyfMnOPaFphdqURVGVPRX0Ttoqo7TMlDZownIpS
   ae7eCUiLmMPHaLlVHFD5OM5D8G1/TkZ5YTAj7CIdlnlN7tM+xzDBGkitJ
   792zETVE7AfffcJ0yLErfVIbHw13cMw0KokWzizGeViqVfQQ2UtW7Ye3q
   8zevSGATH3Lkkay/aWttGOMDOdramhtiO+9vxYIWzVdgXpaPdYkHzuvWQ
   ZHSEKsEdMACnC6qzmcXBRSnJqxBzMSRAd2xvHl9IGoQgwPpC7tssAHCdY
   OGm6fhaywkURlwLk51wrD2bDPBORbmNdiRH1chvW2FLaIc3TygEbeHgOi
   Q==;
X-CSE-ConnectionGUID: HrbxdaxkS7q5rAQFUGA4MQ==
X-CSE-MsgGUID: dOnXFeKFSAen5vB5K6QazA==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="18359437"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="18359437"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 09:14:31 -0700
X-CSE-ConnectionGUID: 2euzQzGZQgGl5iqkTtXFtQ==
X-CSE-MsgGUID: Aw/uYym3Twiv/vbsFrFnCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38298218"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.239]) ([10.125.109.239])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 09:14:30 -0700
Message-ID: <1f393cc9-7195-4d58-b1ab-3616a184a88f@intel.com>
Date: Fri, 7 Jun 2024 09:14:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2] ntb: Fix kernel-doc param for
 ntb_transport_create_queue
To: Yang Li <yang.lee@linux.alibaba.com>, jdmason@kudzu.us, allenbh@gmail.com
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240607075720.77136-1-yang.lee@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240607075720.77136-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/7/24 12:57 AM, Yang Li wrote:
> The patch updates ntb_transport_create_queue() kdoc header to specify the
> correct input parameters used by the function.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thank you!

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---

I do recommend attaching the revision history below the '---' line next time for common patch posting practice. Thanks
>  drivers/ntb/ntb_transport.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f9e7847a378e..5d466a3f117b 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1966,9 +1966,10 @@ static bool ntb_dma_filter_fn(struct dma_chan *chan, void *node)
>  
>  /**
>   * ntb_transport_create_queue - Create a new NTB transport layer queue
> - * @rx_handler: receive callback function
> - * @tx_handler: transmit callback function
> - * @event_handler: event callback function
> + * @data: user-defined data to associate with the queue
> + * @client_dev: the device structure of the NTB client
> + * @handlers: structure containing receive, transmit, and event callback
> + *	      functions
>   *
>   * Create a new NTB transport layer queue and provide the queue with a callback
>   * routine for both transmit and receive.  The receive callback routine will be

