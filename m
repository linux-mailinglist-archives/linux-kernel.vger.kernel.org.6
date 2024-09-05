Return-Path: <linux-kernel+bounces-316395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C899496CEE6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51565B22024
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF5215884D;
	Thu,  5 Sep 2024 06:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/+uIeWf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD09155392
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 06:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725516720; cv=none; b=s+wFMm/eXfn4l8ht/Hld8PyxlVxkpTZwwQAOuQhpeDyROUikIOTOM7tJUIDIlf6t7Mlm8cOrHc209kJlCUz1o7sSneHqKH77QhOCxM047H7H5m0yFDtN6luC34kWzGCwKdbebLDpNbTV6a5SFxYwYhwd6HR1vqEiKkJgS++Atk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725516720; c=relaxed/simple;
	bh=1/SCPb2qKEEJMQdohSBCrjDKgVJtEb+/O7GI3pZW21Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dQKcTiRbZirPKSrmfXvel853d1MIBvUExnl2YzcF1FDrj1pVr8PGE54Ac7PcjfA559gnPhDgN6RXMWpE86ZkeQ/LWwgQ4SQPawWd8wB1WTeKJuIIvBXkJHtdB+4kdTVFwFxLgcm1Y17y5nwZZ02RUt5rmKAs9YcKbrONO8NHAjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/+uIeWf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725516719; x=1757052719;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=1/SCPb2qKEEJMQdohSBCrjDKgVJtEb+/O7GI3pZW21Y=;
  b=f/+uIeWfCWEv1ZVC0R5SdC2pIbf3QQbxdXCBwVkZ+veBq0EHe5A049g5
   7eUOTtjCVw4RiSPzEbpvXSs5spUF3Z28WnAudhjK372ad7CypcvV2Va57
   dZH2v5XbAiMGhGY+PbwEL4dOMuYWmeX9uyvsO34puSD2comMl6nSWZrjO
   TV1gIGpqhtoHaGcuZV4UKgy9jUnbvmGEUKCrZ2KuCHIj3uef5f0n3VLnO
   AkPWqGE7BrNjD/hbxIqcGxk2Pw4IhUUnou4o90oHpPYiozre7Z2VnkRcE
   vcpshJ2V9dVDdUzeJiqvTWVj1aYzXx+fE2verH1gqvzcJELqTyVP+9WQS
   g==;
X-CSE-ConnectionGUID: c0fqFk20QmOKi7niQosl2w==
X-CSE-MsgGUID: +9bs26e4S/ujb4uNkpXtLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="27963191"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="27963191"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 23:11:58 -0700
X-CSE-ConnectionGUID: gz9d9Tf5Q12hYSYVsGRczA==
X-CSE-MsgGUID: 7kVQcwKHQ/iFc9x/uaeu9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="69652967"
Received: from yungchua-mobl2.ccr.corp.intel.com (HELO [10.246.104.225]) ([10.246.104.225])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 23:11:57 -0700
Message-ID: <0780217b-1b92-4c22-bb5a-5b290c66dfe9@linux.intel.com>
Date: Thu, 5 Sep 2024 14:11:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: stream: Revert "soundwire: stream: fix
 programming slave ports for non-continous port maps"
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20240904145228.289891-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: "Liao, Bard" <yung-chuan.liao@linux.intel.com>
In-Reply-To: <20240904145228.289891-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/4/2024 10:52 PM, Krzysztof Kozlowski wrote:
> This reverts commit ab8d66d132bc8f1992d3eb6cab8d32dda6733c84 because it
> breaks codecs using non-continuous masks in source and sink ports.  The
> commit missed the point that port numbers are not used as indices for
> iterating over prop.sink_ports or prop.source_ports.
>
> Soundwire core and existing codecs expect that the array passed as
> prop.sink_ports and prop.source_ports is continuous.  The port mask still
> might be non-continuous, but that's unrelated.
>
> Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Closes: https://lore.kernel.org/all/b6c75eee-761d-44c8-8413-2a5b34ee2f98@linux.intel.com/
> Fixes: ab8d66d132bc ("soundwire: stream: fix programming slave ports for non-continous port maps")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Bard Liao <yung-chuan.liao@linux.intel.com>

> ---
>
> I will need to fix my codec drivers, but that's independent.
> ---
>   drivers/soundwire/stream.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index f275143d7b18..7aa4900dcf31 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1291,18 +1291,18 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
>   					    unsigned int port_num)
>   {
>   	struct sdw_dpn_prop *dpn_prop;
> -	unsigned long mask;
> +	u8 num_ports;
>   	int i;
>   
>   	if (direction == SDW_DATA_DIR_TX) {
> -		mask = slave->prop.source_ports;
> +		num_ports = hweight32(slave->prop.source_ports);
>   		dpn_prop = slave->prop.src_dpn_prop;
>   	} else {
> -		mask = slave->prop.sink_ports;
> +		num_ports = hweight32(slave->prop.sink_ports);
>   		dpn_prop = slave->prop.sink_dpn_prop;
>   	}
>   
> -	for_each_set_bit(i, &mask, 32) {
> +	for (i = 0; i < num_ports; i++) {
>   		if (dpn_prop[i].num == port_num)
>   			return &dpn_prop[i];
>   	}

