Return-Path: <linux-kernel+bounces-235863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 203F991DA89
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC851F21E15
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49D784D3F;
	Mon,  1 Jul 2024 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqPZ6ZRS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95E87BAF7;
	Mon,  1 Jul 2024 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823823; cv=none; b=dnDhrVZPaDxXE0qhwlrsAC2iY6AjXLTYq97O+r6EHkUaHaViTxGutErFwl181FlDRNQeFuDdQ/rv5KlTstuJRoIejOaeBWOPQUvZaLJ2/DkahqYBmicCfy4PO1QHNDY1PdAz6fEUlKggoXhqprzIOgCqvu6JmIxE5D5Gi1cvCdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823823; c=relaxed/simple;
	bh=lDEozFRfTCwEKXHhCwMeLrpdH7bHbFFnfjg0uB9M5Ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YfqKqhH77ClBLA0gYgBpxppjrVJcOxJMlwm0N9NYFl406YLucFnG7lz6XgJapCFA/FwMPaS4xrTInc+ss/Ejzgyl2cFkZzFK2fUGzdwkS7E0wVo1FbSOFRhJIIeFp6xi8SOAPNWX1Oc2jO4UVRCVmZF3h45PKzBYAbfjFzZ2AsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqPZ6ZRS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719823822; x=1751359822;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lDEozFRfTCwEKXHhCwMeLrpdH7bHbFFnfjg0uB9M5Ok=;
  b=hqPZ6ZRSJpQ8Bc/MfDjdI79sC/bgcpgedVPUsY6yxFyCZNeqTKpZ9ntX
   m1+gfLSY6OG5Q60USE1AGvGsSOSoSjYfRL87UGm+2dsjlR6tHDbR4YbAg
   Uc8psISSRRj7RsjpvzebDkgr9nVBpCTwzQT431HRG3ziMHe94vIalotoE
   SLrjbZWbQ8ZhFHqGThFm37XXdHOgSfDkVEy4m6Ky6v9xbG/ERptv7oPBu
   6e2/S790fg52i3jOFghPp9TaF9BhzYrga4/nXi8Fvt6OxKBw6SvBgGYnk
   Pb4jvi8Dnn3S5SRkZ30N68T+A4Gc+W6mpvma4gzsYTzDoD3HkRnW0AKxo
   A==;
X-CSE-ConnectionGUID: bRhSeLIZR8+dVDGpRddNtA==
X-CSE-MsgGUID: qhtMX67wQlqTNa9O43+I+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="16770389"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="16770389"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 01:50:21 -0700
X-CSE-ConnectionGUID: 83ZZ+qo/Qj2W8cdVYxPECA==
X-CSE-MsgGUID: hQYQXUYaQSWbavLwd0gThA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="45445134"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53]) ([10.94.0.53])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 01:50:19 -0700
Message-ID: <326792b9-e706-4ab0-a1e8-cc48943e357d@linux.intel.com>
Date: Mon, 1 Jul 2024 10:50:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ALSA: pcm: add support for 128kHz sample rate
To: Jerome Brunet <jbrunet@baylibre.com>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240628122429.2018059-1-jbrunet@baylibre.com>
 <20240628122429.2018059-2-jbrunet@baylibre.com>
Content-Language: en-US
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20240628122429.2018059-2-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/28/2024 2:23 PM, Jerome Brunet wrote:
> The usual sample rate possible on an SPDIF link are
> 32k, 44.1k, 48k, 88.2k, 96k, 172.4k and 192k.
> 
> With higher bandwidth variant, such as eARC, and the introduction of 8
> channels mode, the spdif frame rate may be multiplied by 4. This happens
> when the interface use an IEC958_SUBFRAME format.
> 
> The spdif 8 channel mode rate list is:
> 128k, 176.4k, 192k, 352.8k, 384k, 705.4k and 768k.
> 
> All are already supported by ASLA expect for the 128kHz one.
> Add support for it but do not insert it the SNDRV_PCM_RATE_8000_192000
> macro. Doing so would silently add 128k support to a lot of HW which
> probably do not support it.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

 From what I remember the recommendation is to not add new rates, but 
use SNDRV_PCM_RATE_KNOT for all rates not included already.


