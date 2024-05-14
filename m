Return-Path: <linux-kernel+bounces-178389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E803B8C4CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85A5DB21E20
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D447E12B7D;
	Tue, 14 May 2024 07:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="erVwi7SW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1BC11717;
	Tue, 14 May 2024 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671478; cv=none; b=KjA5Q/4F32DDrH+Ban5wG6gkiKhy5J2mNdmUVaJuxRikbQmRK+N2YQV4WAwiCCcfLHPsdexkNk8x0MR3PFEvusK6UWUae+Adx4F2qGNDt47ud648Segqc3LUWfx1yh/gJKTlK/xnVDFr8GAgI4vAbhu7v3NTZI42KZz+V0yjLpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671478; c=relaxed/simple;
	bh=h+u2Wm6oUPSgHkFoJjK1aRuxkFR0VPr3ulemXFqbNqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvdKldfEZp3OyYIvef7Om7hSUj5Cl0qJKIkBuYw9gBCg+2fc0dTH1fExWg4gclmPiYAmWZlSfW2nqW+fv2cQhGkDRy0LohYbUV/DBEaN1LNxTE4rcWORlwVzX2nzsOUy1cLiCyc6TSb2JVIKG1kMXE0og7LC4Oj1J1eE6D1Lz4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=erVwi7SW; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715671476; x=1747207476;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h+u2Wm6oUPSgHkFoJjK1aRuxkFR0VPr3ulemXFqbNqM=;
  b=erVwi7SWzEVDhN3FpF4WAta4gZYG6MFZDL8LuCYMESP6gzgstg+1U9Ps
   W0k/aoyVgT/x1F8dnOLgEU852pLko+ru6WoVGijEDS+bxKDEcFeNf6MyY
   /pWOgfDfm92/MmdyPncKkQtRiDWyGP+h1yrYJdaB6nWj8PUUPnogt34Je
   LHPSdpSRyJ3nGb1RWEmdQOoy6W+DVVpNYdr9/J7KXSdFjckk7HiHlIO+7
   eoT4IgCcfigbmU4UqgfpbB0v3rNz4NTgW1E+uCx8t8ekPvW72juxyIQmV
   RefHiXLCpnTLtfkwKF/kB0OSNdrZ7FgAnIFearDczBd0VYKo3l2xyJnyV
   w==;
X-CSE-ConnectionGUID: kVQKqJgPRrGYDGUPomSJhg==
X-CSE-MsgGUID: ZVcReVJxSHe7gBCsxcvjUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11488983"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11488983"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 00:24:29 -0700
X-CSE-ConnectionGUID: 4hN61N4NRaStSxwDU6v6Tg==
X-CSE-MsgGUID: Bl6Ybfb1SUioI5nPBUkcZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30638113"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.32.104]) ([10.94.32.104])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 00:24:20 -0700
Message-ID: <e1110221-8b84-4364-bea9-e166ce859444@linux.intel.com>
Date: Tue, 14 May 2024 09:24:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] ASoC: Intel: avs: Constify struct snd_soc_tplg_ops
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
 <01de0157088de0475970c79738284d6c86d702fe.1715526069.git.christophe.jaillet@wanadoo.fr>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <01de0157088de0475970c79738284d6c86d702fe.1715526069.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/13/2024 7:37 PM, Christophe JAILLET wrote:
> Constifying "struct snd_soc_tplg_ops" moves some data to a read-only
> section, so increase overall security.
> 
> On a x86_64, with allmodconfig:
> Before:
>     text	   data	    bss	    dec	    hex	filename
>    28046	    794	      0	  28840	   70a8	sound/soc/intel/avs/topology.o
> 
> After:
>     text	   data	    bss	    dec	    hex	filename
>    28206	    614	      0	  28820	   7094	sound/soc/intel/avs/topology.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>


