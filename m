Return-Path: <linux-kernel+bounces-178392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 814898C4CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201AC1F21C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FFA2E83F;
	Tue, 14 May 2024 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GKsMqq7M"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596CF2BB16;
	Tue, 14 May 2024 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671502; cv=none; b=NGVmIjd7GeQi16/oQ0LtzqnCaciXyxe/pLn2YVPVffZ2QFs9yoA6pxoym38Qi1a8KCgMg3JZlyM8GUuB3UAe9WlC90tdmDYNDT7AxTJfRlhdtighOcYcWKV/GLOJJM9RRJQhDHJBGF/B63BcJbvKsLBuAdD4bJv2aMYokffl+oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671502; c=relaxed/simple;
	bh=Tm+W/k1wIKzjaUhZ1Z193EZWFqmYNWQo8g+1U/Y/oZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sEe2IXsre/pP1IgPmzbWrG6uXV4RENtMcl360XRGNT9yv4J05y4LqmEOZyCcj84jud5y6LYhPAF+TtISzJRJPJrD7Il8e71SOFVKL6a9Oq0fmtW5RVJc1hRsCVgFOtQyRjSwOVVCXjrL8aneUBkcst/8WTTOvgAdXy5MpzNiuZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GKsMqq7M; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715671501; x=1747207501;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Tm+W/k1wIKzjaUhZ1Z193EZWFqmYNWQo8g+1U/Y/oZY=;
  b=GKsMqq7Mxhsr64aWL40wfkm1OaziWFdhAf750nQus2qpMwuYQ1vtY3MA
   tpMrbeU85YVy8npkFK9DB8LyHg6CPNk8UrAaAeZTywSviBvEuZDE/WTHK
   RkySG8WDIrU/tPv5x+PhVzvyf8GlupEgv8154IVx2PP83Kz6k1VMg2dJ0
   lsJCl2Oob2EJFCLfToh/kPBKTF2BD0//xV/f0Lk9MV0dZHw6HJdCzgof8
   cWPP8Xt6kE69IAAdf6ccX3gflD814cf/k3afdAOJavE21jJmhcxN/jDZu
   I1OLdW82ExIukLtmPPzXciRtfXWiA6/ghtaJb+efzGi1qp/64AtizUoQr
   w==;
X-CSE-ConnectionGUID: +FOzu4DwSACYHCNlEfb0fA==
X-CSE-MsgGUID: vBqoat5ESUWldfkWHbeB2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11489031"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11489031"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 00:25:00 -0700
X-CSE-ConnectionGUID: R83TVYkLRTu0dk/2BjcVCg==
X-CSE-MsgGUID: PVXjhZT7RvCGKCbnvxgn/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30638161"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.32.104]) ([10.94.32.104])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 00:24:50 -0700
Message-ID: <db981d27-7e70-4514-b82b-fc452b658019@linux.intel.com>
Date: Tue, 14 May 2024 09:24:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] ASoC: Intel: Skylake: Constify struct
 snd_soc_tplg_ops
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
 peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 srinivas.kandagatla@linaro.org, bgoswami@quicinc.com, daniel.baluta@nxp.com
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
 sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <f2f983e791d7f941a95556bb147f426a345d84d4.1715526069.git.christophe.jaillet@wanadoo.fr>
 <48f096b6dc617ecf3ca53211c2a696a4df33b21a.1715526069.git.christophe.jaillet@wanadoo.fr>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <48f096b6dc617ecf3ca53211c2a696a4df33b21a.1715526069.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/13/2024 7:37 PM, Christophe JAILLET wrote:
> Constifying "struct snd_soc_tplg_ops" moves some data to a read-only
> section, so increase overall security.
> 
> On a x86_64, with allmodconfig:
> Before:
>     text	   data	    bss	    dec	    hex	filename
>    58844	   5282	     56	  64182	   fab6	sound/soc/intel/skylake/skl-topology.o
> 
> After:
>     text	   data	    bss	    dec	    hex	filename
>    59004	   5122	     56	  64182	   fab6	sound/soc/intel/skylake/skl-topology.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>


