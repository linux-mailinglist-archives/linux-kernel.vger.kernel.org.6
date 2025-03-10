Return-Path: <linux-kernel+bounces-553672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA34A58D41
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B9457A41B9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E18221F3C;
	Mon, 10 Mar 2025 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORGCS5kC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6F72046BF;
	Mon, 10 Mar 2025 07:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592958; cv=none; b=o5zuJNXQ+QC4vDrxZCXv6jWo+xAP08PuWYoaATndfkLvxC2Hnm/Pqfc6E58oRQFfAg6udeup1I+CL8ChOO63Bg8G8ckz+pfJjzHMQw7k4NsQty/fVXyUg0LKLhNWuOdLla+rkf0usgETzydQkk6jy4p8vxR7PiLWeV6+X4PE9qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592958; c=relaxed/simple;
	bh=N5vzuCqcFyx4s8ct6bBbLFzZ/cGlLfNv8yq43DhYwqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBoG/klIYvm2K4e4L/9j9x/x8YplwrZHb4WDQl17WA/Ic3g+8URUHXA0AF7X+LzlElQELuhGbwKxlSrS1knK+/3cAyEMfnY0kFxcTxlxhcON54J4i/WlNMIfs+O37s2kfVCTmXlZXE4yxMAYsmACK1WnUKLDVvztG0G8uMzth4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORGCS5kC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741592957; x=1773128957;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N5vzuCqcFyx4s8ct6bBbLFzZ/cGlLfNv8yq43DhYwqY=;
  b=ORGCS5kCt7/d1NnittRksrrSDitGimf6RQtPDHXjEQPQATlb+zVAFj1C
   HAV0yHXmZriT/hWmnhkdZ8zrPnXcitoM5jSitcv7Tl79Xk1TjK3Zvz22B
   sJ/UeEa1rmsMUNmDE9SqL0ga3dNyFexObDzgp85m7DG6HlZz5eDELkCwJ
   PuBtXlaNlpPNxKy0v92O5EPO63cp0u+B+p7uhKpXHgDd4OofST3ipwm70
   HLk5QxshPrBgsC63fpb0jgpyAzmcyofhkIy/jxey7ZNLlK3+L2F6DECs8
   ZhU/X2PFcuJ8bcl4539x0aibY91Fa0lS0d4qoB6PP7tfcS7RAus6S2mjp
   w==;
X-CSE-ConnectionGUID: Z4JckrfXSlmVPGUcg3SNMA==
X-CSE-MsgGUID: 8/x8UJPUSlaYx+sqtDoA1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="67935590"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="67935590"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 00:49:16 -0700
X-CSE-ConnectionGUID: 6nFhWA4IRh++edvRyVpZOg==
X-CSE-MsgGUID: aWDNEfwgQN+tKR30BSI3BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="119870467"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.8.107]) ([10.94.8.107])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 00:49:11 -0700
Message-ID: <2a333cd4-6ec3-4d80-9d80-ba2add234da8@linux.intel.com>
Date: Mon, 10 Mar 2025 08:49:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: codecs: wm0010: Fix error handling path in
 wm0010_spi_probe()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Dimitris Papastamos <dp@opensource.wolfsonmicro.com>,
 Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 patches@opensource.cirrus.com, linux-sound@vger.kernel.org
References: <ee39ba19b8c4c157ce04e06096a8f54016831959.1741549792.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <ee39ba19b8c4c157ce04e06096a8f54016831959.1741549792.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/9/2025 8:50 PM, Christophe JAILLET wrote:
> Free some resources in the error handling path of the probe, as already
> done in the remove function.
> 
> Fixes: e3523e01869d ("ASoC: wm0010: Add initial wm0010 DSP driver")
> Fixes: fd8b96574456 ("ASoC: wm0010: Clear IRQ as wake source and include missing header")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested-only
> ---
>   sound/soc/codecs/wm0010.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
> index edd2cb185c42..28b43fe4dc32 100644
> --- a/sound/soc/codecs/wm0010.c
> +++ b/sound/soc/codecs/wm0010.c
> @@ -920,7 +920,7 @@ static int wm0010_spi_probe(struct spi_device *spi)
>   	if (ret) {
>   		dev_err(wm0010->dev, "Failed to set IRQ %d as wake source: %d\n",
>   			irq, ret);
> -		return ret;
> +		goto free_riq;

typo? riq -> irq

>   	}
>   
>   	if (spi->max_speed_hz)
> @@ -932,9 +932,18 @@ static int wm0010_spi_probe(struct spi_device *spi)
>   				     &soc_component_dev_wm0010, wm0010_dai,
>   				     ARRAY_SIZE(wm0010_dai));
>   	if (ret < 0)
> -		return ret;
> +		goto disable_irq_wake;
>   
>   	return 0;
> +
> +disable_irq_wake:
> +	irq_set_irq_wake(wm0010->irq, 0);
> +
> +free_riq:
> +	if (wm0010->irq)
> +		free_irq(wm0010->irq, wm0010);
> +
> +	return ret;
>   }
>   
>   static void wm0010_spi_remove(struct spi_device *spi)


