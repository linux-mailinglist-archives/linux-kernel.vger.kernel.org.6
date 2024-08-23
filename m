Return-Path: <linux-kernel+bounces-298684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE1195CA33
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03EB2873C6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9718B18BC1C;
	Fri, 23 Aug 2024 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fU2Txd61"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41626187335
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407871; cv=none; b=sfPvUoxDJ6c/2PH1rjqsANthnD+hmjVUxtozA0Ca7zseMUaESX+MQGUwQ7U0965NeL1/JmGFPv1uEc7wfFklIpsIHpyOcHNNPuc5Tla3/FD+bcQJ62b/HUU+4RuXUlnXz4OKSRycbCJeE2UqyW1vl4FCTBJMNZoTm56wCu2rE7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407871; c=relaxed/simple;
	bh=QpcuazOnyseJ5P/75JZGJzYJIZkjK3slrOjOLNMHRNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKKTsPGGMHEUWScwOlN4SISabzRaKLbV/L1aLW7AoyiJPl9C9/huPifa15f0I+5z+1rWsUQI+16ubb4RvgNJSaEW8s8y2jACsCRIx3refj65YMD/32I+xb36wK4dHLZxbgUruL2GUVBOYXRFYSeQ0XEQV68PgmWOxADMxj0r3HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fU2Txd61; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724407870; x=1755943870;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QpcuazOnyseJ5P/75JZGJzYJIZkjK3slrOjOLNMHRNs=;
  b=fU2Txd61y2RhKnc8QSx8lchPU09zN0AHw268Aue97/znEo4xa4gLoTgf
   RkKucMSzALgWg9dJJjJxxTrNdN1Q0+JdbbauCX8C7LQtiuVqTUpOkp1va
   IKEfiY6oF4qolLIyAgiLEhDNDrsU3rv5GsFY+ukiMdT9e88kKiRnl2AU0
   SnouodEZdy1ZxbW+tT6TV9z99jKhmjbCwaGFJz72zirpgTi3QNbEssC7Q
   9aISNdpaPWZRinRrhoPrEGcX5wZSIISbhyH45Ij9CM8XkAKiEV6uT708k
   H6uz9pRr/hpelWQ3eupAlz//5WnfPa8HykjX6iRqmnhvRt7nI+U81EOj5
   g==;
X-CSE-ConnectionGUID: GlA6MJ98Sf6FyzdIhXPJ5w==
X-CSE-MsgGUID: BJkH3eaARxeFxgHfcVYJVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="40383827"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="40383827"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 03:11:10 -0700
X-CSE-ConnectionGUID: zUmtfBfnSdKz9AUiOW87fQ==
X-CSE-MsgGUID: Aux2LsAWTdiaA7cLk17DHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="61758366"
Received: from mylly.fi.intel.com (HELO [10.237.72.154]) ([10.237.72.154])
  by fmviesa008.fm.intel.com with ESMTP; 23 Aug 2024 03:11:08 -0700
Message-ID: <9cc7f7a1-72b5-42fd-b5eb-6cd1cf59f3e7@linux.intel.com>
Date: Fri, 23 Aug 2024 13:11:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] i3c: mipi-i3c-hci: Add a quirk to set timing
 parameters
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240821133554.391937-1-Shyam-sundar.S-k@amd.com>
 <20240821133554.391937-6-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20240821133554.391937-6-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/24 4:35 PM, Shyam Sundar S K wrote:
> The AMD HCI controller is currently unstable at 12.5 MHz. To address this,
> a quirk is added to configure the clock rate to 9 MHz as a workaround,
> with proportional adjustments to the Open-Drain (OD) and Push-Pull (PP)
> values.
> 
> Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
> Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>   drivers/i3c/master/mipi-i3c-hci/Makefile     |  3 +-
>   drivers/i3c/master/mipi-i3c-hci/core.c       |  6 +++-
>   drivers/i3c/master/mipi-i3c-hci/hci.h        |  2 ++
>   drivers/i3c/master/mipi-i3c-hci/hci_quirks.c | 33 ++++++++++++++++++++
>   4 files changed, 42 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
> 
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

