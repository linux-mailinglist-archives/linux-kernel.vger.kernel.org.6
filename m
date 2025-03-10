Return-Path: <linux-kernel+bounces-554081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EA9A592B7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4071E188F2EE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C0E21E0AA;
	Mon, 10 Mar 2025 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PL9L+ipc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060ED28EA;
	Mon, 10 Mar 2025 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605924; cv=none; b=X8ucUPkIp06mf72JAb+JG1S7eTopBE7I9kuJwBoqzXuYMVhNOPuleYq7+CMs2BD43AKrc6ZbW2rg5NFobA738CyD1eIyZP4UEqEIeKpmG9er3pdYh7GfYzd3Z9r3MbJEL5XUebXltJW6NuBDsvFmABWxhokXmTZNiWp1/ycxBPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605924; c=relaxed/simple;
	bh=i/7QjVV7rIb5AvxHrpWor82wSEVgjqYwZDr90kTdXOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUIbUYHNZ7/82yvYDhCy3S3aqyDtr7ezmiRkNvWYoueK5w38Kercp9Xx8odywLEkDOdrcxcRc3xnY7HcBf6n2EW6ncNgLESk8GqebD/s0M5RUqVsazbMK6fFFUrHv41+3ABJwv+tn7peUy1v1Bn3b2VoyG6ZaYc8RV9slgHkhd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PL9L+ipc; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741605923; x=1773141923;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i/7QjVV7rIb5AvxHrpWor82wSEVgjqYwZDr90kTdXOk=;
  b=PL9L+ipcN+XaFMxYQXOWqINJ/k5P7J/3m4fJOxb5MA/sANzxE6j/xE71
   uGCJf3FzWmyygwQddaBCbMuG7mbA7aoTlUALxpJH8FcanWfTRRtiCFc+M
   nbxgKYYqp5I+rzadV87jYu4hLorjCznn0yXjnGIB9A3tjbebKE198aECr
   PgS1vHxg0O9RlyCC96rUbHagNYLft2UE9m2YIoPCO/71ixl6DLJDAG+4M
   gohltjfLg6IvRxoeoLvy2bbTUG7gN2cMajRAp45KkzVNApkcjn+ukWmst
   2fl9nMaAUaQy+A+V2CV3GIgWE6t/bmE/P1m2eG6pfqkITofK/RCaRM4bg
   A==;
X-CSE-ConnectionGUID: TDPsM6gOQjGSVT8GJ5huqw==
X-CSE-MsgGUID: YBVSDdwFQjaBfBqG4+RoEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42634063"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42634063"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 04:25:23 -0700
X-CSE-ConnectionGUID: hJMWasBGToeid9xeZGyNeQ==
X-CSE-MsgGUID: cx2Dvm+2RPqB4/EUr8hb2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="124964273"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.8.107]) ([10.94.8.107])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 04:25:19 -0700
Message-ID: <f9436b0d-8cfa-4f37-9b0c-395c033f849e@linux.intel.com>
Date: Mon, 10 Mar 2025 12:25:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] ASoC: amd: acp: Implement acp_common_hw_ops support
 for acp platforms
To: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 broonie@kernel.org, alsa-devel@alsa-project.org
Cc: Vijendar.Mukunda@amd.com, mario.limonciello@amd.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 syed.sabakareem@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>,
 Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20250310104601.7325-1-venkataprasad.potturu@amd.com>
 <20250310104601.7325-3-venkataprasad.potturu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20250310104601.7325-3-venkataprasad.potturu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/2025 11:45 AM, Venkata Prasad Potturu wrote:
> Implement acp common hardware ops for acp_init and acp_deinit
> funcions to support commons ops for all platforms.
> 
> Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
> ---
>   sound/soc/amd/acp/acp-legacy-common.c | 50 +++++++++++++++++++++++++++
>   sound/soc/amd/acp/acp-pci.c           | 13 ++++---
>   sound/soc/amd/acp/amd.h               | 36 +++++++++++++++++++
>   3 files changed, 95 insertions(+), 4 deletions(-)
> 

...

>   
> @@ -252,6 +274,20 @@ int restore_acp_i2s_params(struct snd_pcm_substream *substream,
>   
>   void check_acp_config(struct pci_dev *pci, struct acp_chip_info *chip);
>   
> +static inline int acp_hw_init(struct acp_chip_info *chip)
> +{
> +	if (chip && chip->acp_hw_ops && chip->acp_hw_ops->acp_init)
> +		return chip->acp_hw_ops->acp_init(chip);
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int acp_hw_deinit(struct acp_chip_info *chip)
> +{
> +	if (chip && chip->acp_hw_ops && chip->acp_hw_ops->acp_init)

Shouldn't it check for ->acp_deinit() instead?

> +		return chip->acp_hw_ops->acp_deinit(chip);
> +	return -EOPNOTSUPP;
> +}
> +
>   static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int direction)
>   {
>   	u64 byte_count = 0, low = 0, high = 0;


