Return-Path: <linux-kernel+bounces-368156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E989A0C13
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D963C1F25C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD11C20C00A;
	Wed, 16 Oct 2024 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vwb225Ni"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8696420C02C;
	Wed, 16 Oct 2024 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087103; cv=none; b=SL9JzfYugzpTwHelhomAXj+t285FouujOoYJ5fQpFrdcA03Qy3ViAA5Loo9OTQhy1o+x/s2tDrIg7dGiTlqS1bTSkIr12lt7gDg41rSNK4wEBFOAXvpG2z3MzVIA07jZ4hPMnviCjAzRi7XK9apX4i2Syu5MPaMowudKzSiDV9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087103; c=relaxed/simple;
	bh=tNXxexRa63qPQgCE/PAc1Z8lcuufpKEk5QRRnDaJq+s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y72N0+2KRyG6SWdc+1hDG6hXd5PJUhlO6ttiuCpjajHxnYOBiX416J9r6AVyTZ686MvfnqIE2AKq9dnmwlFkN5upo9DWEH6RShndzgDJYdlqIrolAUljd/p4TjPYYUby2zGDZl6KmuXtaTcde645K/YO0SDmTKF+gsFjS6+xF/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vwb225Ni; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729087103; x=1760623103;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=tNXxexRa63qPQgCE/PAc1Z8lcuufpKEk5QRRnDaJq+s=;
  b=Vwb225NiHD3hYho3ad8U/qD03Weyyff5yHqDZ8PKbyhJv/VbJ+WBZtrH
   csBKE8yLQTcWzn0GRMQFoDl8TF6k8TULETJ6qpAxSxFS+1P+RWaxEn72P
   az/pYrbl+FTyMtqCntBnEgVTECoO2astNq9XMwAGl1PG3nSvBf/XQAFKj
   8o+F4ww643ETh157JGd3pHmS0zA0v3oHZbR+GNCTyExvoiGDg7Mni6GZR
   1iMqnSgPMhh6RAwcTj/kZJZIvKqV+ucptj4Kn072Zv4W/fgXkMbpuMsUU
   9sKS/1n26dTDs7BpSp6tmU6zSoTtPUp58PcP8Buiktfa1YwiNw6hFIbr5
   g==;
X-CSE-ConnectionGUID: 1yfAEEkPQWm1VClMgPbcxw==
X-CSE-MsgGUID: KEx9i6w8SuafP7k4QH0rKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46009054"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46009054"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 06:58:22 -0700
X-CSE-ConnectionGUID: WVAU1CeSRDWu8KSQ5l2xlA==
X-CSE-MsgGUID: EOjd0EyUQf25Dm3DlX9PBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="78124999"
Received: from yungchua-mobl2.ccr.corp.intel.com (HELO [10.246.104.225]) ([10.246.104.225])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 06:58:20 -0700
Message-ID: <7f9e4378-3d96-4eee-9b66-cb37739a12f4@linux.intel.com>
Date: Wed, 16 Oct 2024 21:58:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] ASoC/SoundWire: clean up link DMA during stop for
 IPC4
From: "Liao, Bard" <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org, tiwai@suse.de, vkoul@kernel.org
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, pierre-louis.bossart@linux.dev,
 bard.liao@intel.com, ranjani.sridharan@linux.intel.com
References: <20241016032910.14601-1-yung-chuan.liao@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20241016032910.14601-1-yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/16/2024 11:29 AM, Bard Liao wrote:
> Clean up the link DMA for playback during stop for IPC4 is required to
> reset the DMA read/write pointers when the stream is prepared and
> restarted after a call to snd_pcm_drain()/snd_pcm_drop(). 
> 
> The change is mainly on ASoC. We may go via ASoC tree with Vinod's
> Acked-by tag
> 

Mark,

This is a bug fix. Link: https://github.com/thesofproject/sof/issues/9502

Can you pick it for kernel 6.12? Also

All: Cc: stable@vger.kernel.org # 6.10.x 6.11.x

Thanks,
Bard

> Ranjani Sridharan (4):
>   ASoC: SOF: ipc4-topology: Do not set ALH node_id for aggregated DAIs
>   ASoC: SOF: Intel: hda: Handle prepare without close for non-HDA DAI's
>   soundwire: intel_ace2x: Send PDI stream number during prepare
>   ASoC: SOF: Intel: hda: Always clean up link DMA during stop
> 
>  drivers/soundwire/intel_ace2x.c   | 19 +++++-----------
>  sound/soc/sof/intel/hda-dai-ops.c | 23 +++++++++----------
>  sound/soc/sof/intel/hda-dai.c     | 37 +++++++++++++++++++++++++++----
>  sound/soc/sof/ipc4-topology.c     | 15 +++++++++++--
>  4 files changed, 62 insertions(+), 32 deletions(-)
> 


