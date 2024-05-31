Return-Path: <linux-kernel+bounces-197098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 005EF8D6623
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2EF91F238B0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D39157478;
	Fri, 31 May 2024 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jl2PWOGq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B80C24A0E
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717170766; cv=none; b=YbUjygnEO2SsC8ViXAkTMoR+ASjf18U9bQkWQyVG5AaXiTUCN0RCKMnrNEvtMhoAPcCn3sAk6+QrzqWAWO4jKEkdJiYQ6vWmo2DtUiTpJWPKkOWk3vYtoxuioWI4MN3qH4/upEbHb/9QAjHh2hCReaLahRVFDvbPDmRAYp8eYKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717170766; c=relaxed/simple;
	bh=J0kbwRHmV/+gyGrwgRmUSbnanlbcmQ5Rx6idzys8fSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2CKZywyx91eXuf1iazH8bb4A1czDq58q/ZyFcSWJM8IYksWpldmwa7/l8+hITwJsNNhIKSEV6u2jGRsVl0yc+LKEhG7/UJdtB77sIEoUIybYUi8k/tldikIQoClqXCyesuvDspHVCIiif/TK/f+Rs1mMVxPpjiLK+tCKGLowQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jl2PWOGq; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717170763; x=1748706763;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J0kbwRHmV/+gyGrwgRmUSbnanlbcmQ5Rx6idzys8fSY=;
  b=Jl2PWOGqwdkMrLN1My//9lWF1ambVxcY/K1yi6qsTFLWlICy3N4ZkbkS
   57/rtrxFR4yAjgjve8YcHMnXDG1cEIsi6y78vGHYwrlcD3YFoVygN4pcp
   wOXCSNasoHliv7srXA7xp3Xq9mlje97dz8xvrYTflmZ4N0N5RGo/s1KXc
   D/wrxBFwgCZKVyoGaz8vjG8my3mzs9J9gSTYoAI66u3w+iFalRvufY6LO
   3GHKBAjQQ26GyQuuxDXCFqAj+9SGY/R+2fz8Nt+1nfS9UoCiHvMjhwU+M
   bcBkSUHWfhiNrDoU7DBkPCN+FR5Fj7RCol1u17moNgrmNoKrqWf9xG020
   A==;
X-CSE-ConnectionGUID: hgUEzJKkRVWaXU+foNpeoA==
X-CSE-MsgGUID: x+kZR9e0RJi9I7cZTj7I9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13587514"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="13587514"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 08:52:43 -0700
X-CSE-ConnectionGUID: zpuuR3eiRQ60zgBo3cKqcg==
X-CSE-MsgGUID: +jYVfnZySUSdu642MgqtqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="59376531"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.108.62]) ([10.125.108.62])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 08:52:42 -0700
Message-ID: <457b2e1c-00b7-45d5-9c66-6d03c39586d5@intel.com>
Date: Fri, 31 May 2024 08:52:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] ntb: Fix kernel-doc param for
 ntb_transport_create_queue
To: Yang Li <yang.lee@linux.alibaba.com>, jdmason@kudzu.us, allenbh@gmail.com
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240531072124.64352-1-yang.lee@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240531072124.64352-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/31/24 12:21 AM, Yang Li wrote:
> The patch updates the function documentation comment for
> ntb_transport_create_queue to adhere to the kernel-doc specification.

I wouldn't say it's not adhering to kernel-doc specification but rather that it's documenting the incorrect/out of date parameters. So maybe something like:

Update ntb_transport_create_queue() kdoc header to specify the correct input parameters used by the function.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Besides the commit log change,
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
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

