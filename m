Return-Path: <linux-kernel+bounces-302761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A809602F0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FDB41C2218E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8F633999;
	Tue, 27 Aug 2024 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6CsNBO6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A72A145B10
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724743392; cv=none; b=hio8hs1p+DrJgFSHiqgsGHfsNOKD4FueW/TCsMk7T3+KzsX6nyGTotv6oJAHX290Id/WItb1zaNL5Pm7F4yTSglmKE4k94M6h6uVrBdQaVH/cJ27Fh4/wHPw++QVmBKxNYYErTcjd57qSSApn9UILZCkZIU3Jt1OGIyq9yWY/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724743392; c=relaxed/simple;
	bh=B7htdUdtKPddLbS/gIn9aNfjx718NPsbBSd7k3pv1v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEa3i4g9CnA82RU5WwF8L7SBdZsv0g2WWBdcGq8qOFk2ndZZ0397i+8gcUc5ANTLYl8Z/V1612b+6c5ocKv9mGii+NCxuGaQJmr1j5NAmJpm5ZRQ+eMWPT8tCyAD8p8WGDIxGEMlfz1W85YSQxaRGtwu7NlKVP8fDWrN62uPYCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6CsNBO6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724743391; x=1756279391;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B7htdUdtKPddLbS/gIn9aNfjx718NPsbBSd7k3pv1v8=;
  b=Z6CsNBO6Gw41V+CzQfxubdQqey/HpqvDt+B7FEEw/sR67R/A751umTH2
   5aLqVWLm+X3ZlBQLOHclP66CufI6YTyU16JCq7Y4Ke5z+cZ/PxHMMLP85
   hXn77tNPG3MK/AASJH8LCdSvMmaq7rXAhG5abs0a2flRmkLlxOmWJn1W4
   jVhniFS4SuOjAsEQkAOICWoruLnMhZ+P1+fak6ITaq97s7Le/kD0lpzHR
   CQOkiskX5xgLS3ijV9lUVVOjK7UFuBTKU7ArOcx903W2ivZ4IuO0DCko+
   9yeFR7gaUs1HTzSlrd8JkbKP+gLdD9Le027har/1uVHeOvVmi2lLRvhoH
   w==;
X-CSE-ConnectionGUID: e45zHC3nQLqk6fgEz1uE0g==
X-CSE-MsgGUID: /gvAC8zxSte7ACCylbiJug==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23357139"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="23357139"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 00:23:09 -0700
X-CSE-ConnectionGUID: 8VS5XKuRSmWN1f6+r7QuCA==
X-CSE-MsgGUID: Xqv7lKqySpOXbU7l9Me2ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="67584343"
Received: from mylly.fi.intel.com (HELO [10.237.72.151]) ([10.237.72.151])
  by orviesa003.jf.intel.com with ESMTP; 27 Aug 2024 00:23:08 -0700
Message-ID: <5269394f-ad13-4a1f-a8bf-f58249af8913@linux.intel.com>
Date: Tue, 27 Aug 2024 10:23:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] i3c: mipi-i3c-hci: Read HC_CONTROL_PIO_MODE only
 after i3c hci v1.1
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240823141917.692336-1-Shyam-sundar.S-k@amd.com>
 <20240823141917.692336-3-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20240823141917.692336-3-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 8/23/24 5:19 PM, Shyam Sundar S K wrote:
> The HC_CONTROL_PIO_MODE bit was introduced in the HC_CONTROL register
> starting from version 1.1. Therefore, checking the HC_CONTROL_PIO_MODE bit
> on hardware that adheres to older specification revisions (i.e., versions
> earlier than 1.1) is incorrect. To address this, add an additional check
> to read the HCI version before attempting to read the HC_CONTROL_PIO_MODE
> status.
> 
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>   drivers/i3c/master/mipi-i3c-hci/core.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> index 07de1cecfa30..42d2362d072b 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> @@ -630,8 +630,8 @@ static irqreturn_t i3c_hci_irq_handler(int irq, void *dev_id)
>   
>   static int i3c_hci_init(struct i3c_hci *hci)
>   {
> +	bool size_in_dwords, pio_mode_support;
>   	u32 regval, offset;
> -	bool size_in_dwords;
>   	int ret;
>   
>   	/* Validate HCI hardware version */
> @@ -753,10 +753,13 @@ static int i3c_hci_init(struct i3c_hci *hci)
>   		return -EINVAL;
>   	}
>   
> +	pio_mode_support = hci->version_major > 1 ||
> +				(hci->version_major == 1  && hci->version_minor > 0) ? true : false;
> +
I'd rename this as mode_selector etc. since I've understood PIO mode is 
possible in earlier version(s) too.

Also latter part of statement "? true : false" is needless.

