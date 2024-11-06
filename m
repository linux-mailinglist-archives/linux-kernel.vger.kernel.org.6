Return-Path: <linux-kernel+bounces-397732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BDE9BDFAF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C051C22DE7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE73E1CC8B0;
	Wed,  6 Nov 2024 07:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IyK9CsY8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8611E3C39;
	Wed,  6 Nov 2024 07:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730879347; cv=none; b=LOplYHn4u4r87WlYJUbwEluXLDjbk6bypdX/ll6Dv2Kgjpt8sSvlyKm5Ysj20dfuRhB8JOQe7W8vzmJ1hdga1/QqF852M+/Z0XCU8dwh1x7O57ZNTtzgcAUCj8u9Qjfxf4LezJU9+fT0vDdjZcj1HegpRcao85tMEMskUpcYP+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730879347; c=relaxed/simple;
	bh=Gzdi/yUD+spkYaz59CYkeZqVqjhh9eyFjRvYedwnjtU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eqZn9MVQUUj/MljN6l9obmvw6Xhw1An6n2/vbc1VhVvckuIqUa73fSud/tRtMCvQaMAfyTFFPMKBiA6nRrMwaES+maYnX6TfCES76PYp0eC5M+CimN92xqOviLYUD3QmVhQUZAhjJoQXbmLhSIR5FcE+gZFsvHcSeL3f+YLR+EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IyK9CsY8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730879345; x=1762415345;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Gzdi/yUD+spkYaz59CYkeZqVqjhh9eyFjRvYedwnjtU=;
  b=IyK9CsY8wBtsZ78Oia/xexscWUBiZTAKuHD7GmyrM3TN9Ud3p9Taf9s8
   wQEFzwe5L7yxnk4oexPqKU5iQXG0dt+em2qUMW4x6ryl9Goeh5nIGXPJv
   9u2JtwcQOcCiitfK11LANQ/uNnKkM4h4LSGf9olk61I48RsEVRaRZY3Mr
   dKnh6VkbOohhMPO+gjWH8z0fKnDX5GGGZ+O7Ui2AqKUxcY4iNMhi7eS93
   NJtzPB/vppKGD504nAPBnzWPMtLKzuaWKHeOEmjgthH1Stgr+/M9edV26
   BGDfsf9ySV59680DNAIk4Y0dsgQhT+dPrvGJkhHfyCKGnILtJt3J6iGk5
   Q==;
X-CSE-ConnectionGUID: 2eWafqquT0CReQU3KaEe1A==
X-CSE-MsgGUID: MP0RZl5fTmGl8pMhaK7LrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48125079"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48125079"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 23:49:05 -0800
X-CSE-ConnectionGUID: ldNt2ObVTlmCQAYOw4pe0A==
X-CSE-MsgGUID: +GEzy4uoQeuofeW+ClZPlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="89525719"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO [10.245.244.56]) ([10.245.244.56])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 23:49:03 -0800
Message-ID: <b26086ef-07b4-4013-97d8-6a8ff151d42c@linux.intel.com>
Date: Wed, 6 Nov 2024 09:49:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: compress_offload: Remove unused runtime pointer
 from snd_compr_poll()
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
To: vkoul@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 broonie@kernel.org, amadeuszx.slawinski@linux.intel.com
References: <20241106070646.2599-1-peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20241106070646.2599-1-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 06/11/2024 09:06, Peter Ujfalusi wrote:
> runtime is not used as seen with W=1 :
> sound/core/compress_offload.c: In function ‘snd_compr_poll’:
> sound/core/compress_offload.c:409:35: error: variable ‘runtime’ set but not used [-Werror=unused-but-set-variable]
>   409 |         struct snd_compr_runtime *runtime;
>       |                                   ^~~~~~~
> 
> Fixes: 04177158cf98 ("ALSA: compress_offload: introduce accel operation mode")
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> ---
>  sound/core/compress_offload.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> index 5ecdad80a0d8..c08afbd0155b 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -406,7 +406,6 @@ static __poll_t snd_compr_poll(struct file *f, poll_table *wait)
>  {
>  	struct snd_compr_file *data = f->private_data;
>  	struct snd_compr_stream *stream;
> -	struct snd_compr_runtime *runtime;
>  	size_t avail;
>  	__poll_t retval = 0;
>  
> @@ -414,8 +413,6 @@ static __poll_t snd_compr_poll(struct file *f, poll_table *wait)
>  		return EPOLLERR;
>  
>  	stream = &data->stream;
> -	runtime = stream->runtime;
> -

Probably it would be better to _use_ the runtime in the rest of the
function. Please ignore this patch, I will send a new one.

>  	guard(mutex)(&stream->device->lock);
>  
>  	switch (stream->runtime->state) {

-- 
Péter


