Return-Path: <linux-kernel+bounces-302737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF869602B3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9861C225B5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988608F58;
	Tue, 27 Aug 2024 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DPctIYUC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548681854
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724742492; cv=none; b=WEbl1MXqiej+T9TXZeWbzX8o0C/pm7r15fQTxXQiugN0sh/GyAbEpumX3wBoj288Tzofgv33gDlqITuNesPjJX67TPRjXzPRd5PLX9Iy6FsTz5bio6ZDy8bNdD8A/nb1DtgeciWcBwqu/AfZxTPronTxGU/Trn6M1CQIEoJILPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724742492; c=relaxed/simple;
	bh=LRxPvwgGH3sUNqy7+5c2xlwgfCwTB41TZWDoqLrb+Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roN34MRwOiEC6vJMr1oDD8Eeog3CIIqtSWFP4fzfS1eZwhGrvHZGOsStCMqMuEMNmwsl5xaWMU9pbKHmbs9+lzM0wsIZA+ezbV19n8354AZ6YTltilLdG0Y8EQjr1qT2gmGNnQZINOBcy/Wqml9tQX1ND4H8sz1uRgyEfxNXCBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DPctIYUC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724742492; x=1756278492;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LRxPvwgGH3sUNqy7+5c2xlwgfCwTB41TZWDoqLrb+Bo=;
  b=DPctIYUCdUr2MPZPrWnnAG7q0JKKKUpWso8GsyXoTyyxE8ZRZhBdQArr
   dqP5E1aVPXoKkGQx3HhnH70VHkTd7JuczT3tscXora/Ekzyv3d8SeSrtF
   catM6//MuHCjCis9DWli4WWIdI/lhPq6a3XwnmKD592afinsXPaeYW611
   k+jDHndI7iBDeLc6UcZ2n7LCgj+NTs0no2yCbpV+wjYX2YU71yIIvaBat
   gC+y3wwkthFN+vow0Sm3P1e2GSH/DqZJTZQNp+Z8N68ks/xU763wQTDcm
   hiLch/zR79tV33mc1uCFsA36GZg4/IOAUCXNiNvzDHGohLt0/EaMArBFV
   A==;
X-CSE-ConnectionGUID: OKDLEf6MQ5u2bpHQkDbTnA==
X-CSE-MsgGUID: dhMMyENcSoyF8kDQj8cmug==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="45718053"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="45718053"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 00:08:11 -0700
X-CSE-ConnectionGUID: CISR3S4HSUWI28EeNw/SiA==
X-CSE-MsgGUID: L9XDac7bSU+Gw1KGwLd/Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="67681020"
Received: from mylly.fi.intel.com (HELO [10.237.72.151]) ([10.237.72.151])
  by orviesa004.jf.intel.com with ESMTP; 27 Aug 2024 00:08:05 -0700
Message-ID: <61f5e4d6-5564-4f51-a586-f1a8693b215d@linux.intel.com>
Date: Tue, 27 Aug 2024 10:08:00 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] i3c: mipi-i3c-hci: Add a quirk to set PIO mode
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240823141917.692336-1-Shyam-sundar.S-k@amd.com>
 <20240823141917.692336-4-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20240823141917.692336-4-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/24 5:19 PM, Shyam Sundar S K wrote:
> The AMD HCI controller currently only supports PIO mode but exposes DMA
> rings to the OS, which leads to the controller being configured in DMA
> mode. To address this, add a quirk to avoid configuring the controller in
> DMA mode and default to PIO mode.
> 
> Additionally, introduce a generic quirk infrastructure to the mipi-i3c-hci
> driver to facilitate seamless future quirk additions.
> 
> Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
> Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
> Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
> Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---

>   drivers/i3c/master/mipi-i3c-hci/core.c | 8 +++++++-
>   drivers/i3c/master/mipi-i3c-hci/hci.h  | 1 +
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

