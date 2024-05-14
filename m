Return-Path: <linux-kernel+bounces-178388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6276F8C4CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EC31C21140
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C9218E1E;
	Tue, 14 May 2024 07:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLzPCiiC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564FF11717;
	Tue, 14 May 2024 07:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671451; cv=none; b=o6yT6aHOrX5Eoc7Cl6DKurT3p76A5bSdHk+73TrJSgIufZco8hJiI1d0pfbCQpU+B0fWbpxznBC9wJAb7dYYRLPCbHIAVIrvDJw9r1vt1+2pdceo4fOxEwPG/RocmK6fMNjKyEaJiTAtDOVphHYGWSaSluSLr+gT0dQry1KLVFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671451; c=relaxed/simple;
	bh=BOZXDlQW/ALMT/v+vXYr+gzuWqxOzMY84psbe2mKH9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dKocnQoVtSgkmaxAMra+sBQupohmvo0/hNd6WuXANPyozpERcH+5qWuopVahj7IyxoJsggxlj93MH+23zJ7fttE8piFOY3Sitzv3Q5fepPsbM2y2i4NvHk2t8ZMLKurCMc+wnx+gvQCrwE+HO72h/o/xhZC1RumecWRhSi4CvkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLzPCiiC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715671450; x=1747207450;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BOZXDlQW/ALMT/v+vXYr+gzuWqxOzMY84psbe2mKH9g=;
  b=eLzPCiiC6YZVrc4Mn2MGeHGgEG12yflyIa2VbrB7fRNy6HR7YRLgZY1D
   x3lAGlZ/yq9dLkmj5gQ/erzw7avB2GQKDivMgqfYIMgHhh7zuge0wpu2V
   2eN8CQutZlY8BxhQ2Zos30m8v60YRswSUQBzd+92ZHcvunvdCxOu1ayto
   +fp5OYLmgMEuHSWdoXWk8Sks66ddyyetjhDq1RBvR8FJuq2E96n1GK5P9
   0yF4aTUhZq+Q3inTG+t8MsbPETofbD2vonJ/W5aRSKBnFI4QB3a+CgJ28
   7uS851VOooRnvVLhyN0y38mUgBHudmVs36oPE+HRytgsoQd3HAogkOz+s
   w==;
X-CSE-ConnectionGUID: SeUZwr38Tv2f98s2vMWRPg==
X-CSE-MsgGUID: j0XPceK8S22UlZCrDQfdbw==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11488953"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11488953"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 00:24:04 -0700
X-CSE-ConnectionGUID: TKg2A2hNQSW6FXkQNLQQpA==
X-CSE-MsgGUID: NEldkTQUSX6In4azeNWRZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30638103"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.32.104]) ([10.94.32.104])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 00:23:58 -0700
Message-ID: <9a34ea33-1294-4356-b9c4-295709a86cd2@linux.intel.com>
Date: Tue, 14 May 2024 09:23:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] ASoC: topology: Constify an argument of
 snd_soc_tplg_component_load()
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
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <f2f983e791d7f941a95556bb147f426a345d84d4.1715526069.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/13/2024 7:37 PM, Christophe JAILLET wrote:
> snd_soc_tplg_component_load() does not modify its "*ops" argument. It
> only read some values and stores it in "soc_tplg.ops".
> 
> This argument and the ops field in "struct soc_tplg" can be made const.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   include/sound/soc-topology.h | 2 +-
>   sound/soc/soc-topology.c     | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
> index f055c6917f6c..1eedd203ac29 100644
> --- a/include/sound/soc-topology.h
> +++ b/include/sound/soc-topology.h
> @@ -178,7 +178,7 @@ static inline const void *snd_soc_tplg_get_data(struct snd_soc_tplg_hdr *hdr)
>   
>   /* Dynamic Object loading and removal for component drivers */
>   int snd_soc_tplg_component_load(struct snd_soc_component *comp,
> -	struct snd_soc_tplg_ops *ops, const struct firmware *fw);
> +	const struct snd_soc_tplg_ops *ops, const struct firmware *fw);
>   int snd_soc_tplg_component_remove(struct snd_soc_component *comp);
>   
>   /* Binds event handlers to dynamic widgets */
> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
> index 90ca37e008b3..b00ec01361c2 100644
> --- a/sound/soc/soc-topology.c
> +++ b/sound/soc/soc-topology.c
> @@ -73,7 +73,7 @@ struct soc_tplg {
>   	int bytes_ext_ops_count;
>   
>   	/* optional fw loading callbacks to component drivers */
> -	struct snd_soc_tplg_ops *ops;
> +	const struct snd_soc_tplg_ops *ops;
>   };
>   
>   /* check we dont overflow the data for this control chunk */
> @@ -2334,7 +2334,7 @@ static int soc_tplg_load(struct soc_tplg *tplg)
>   
>   /* load audio component topology from "firmware" file */
>   int snd_soc_tplg_component_load(struct snd_soc_component *comp,
> -	struct snd_soc_tplg_ops *ops, const struct firmware *fw)
> +	const struct snd_soc_tplg_ops *ops, const struct firmware *fw)
>   {
>   	struct soc_tplg tplg;
>   	int ret;

Yes, makes sense to me.

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

