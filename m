Return-Path: <linux-kernel+bounces-298677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 367A195CA22
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74D1286E09
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E020517C7A2;
	Fri, 23 Aug 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L3xPAtjV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E46F14B084
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407820; cv=none; b=g/F3v0mjQRf62RmFnuFN007yUUMk+NGX7Skkp3bgwMAwq7hrBXUij1ixajwT8HLszXUyNyUAuX4cMy+JXBbzjuQQ55h0KVH5gslzCCtZVKrgYHa8E5X3Mnem8W2p1cyOY6o8TVdwJ7S464MDt+r+Ekr+ytxYoQ5iIgYrQGzeK3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407820; c=relaxed/simple;
	bh=oMufABWSu43Zhd3K6WgT6JTK0bNbHhwrNC7S1QzUR9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K81F6XfabbGV0Jv0IDMnVUboanhHnKCRO7ivX9NRB7UnnlMCjnb7sKE4JEDyRxd6KP5emS54VqVwTcbwLUzrue7Bge4dQM4iDzVzyyvMfT/zgQ2ZhVIzB3YOl/gHaYmth8QFH69mTIw7gJCTHwM4XM3NZjKpWw6gNjyUfeNlVZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L3xPAtjV; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724407818; x=1755943818;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oMufABWSu43Zhd3K6WgT6JTK0bNbHhwrNC7S1QzUR9U=;
  b=L3xPAtjVPPB+65X4AomYlCvl8n3WZfSU/R7Rv3cXv1qRlOhT4Got/qAZ
   x01XasDl8xpDvt8j7lKvTe61DHLT9Tbvw1vRR4uuCKDEQ01IVyta98XcT
   80tAEzC+gaO87001cqwe5R/QLEM0j8DfpUGoOQEg9QHsiJTjB38PfNSjs
   jzaUt6ryy54/h+515vZx+ba7YOkjgnqzEi32OgmCgtnAm7T4cJfGbSpC6
   2ra5bsMXAYU81Meb2pCNDsSqoQmzqwdvr5YvdMMbscMrsfrRuwIIUYCdZ
   qGpc7LC0VGx+lK/xL5bevJ1ZIqiuUaRoafAJHBfWDrYL1LEAjLdxfz/lL
   A==;
X-CSE-ConnectionGUID: zsiNOpiNTwSH9QuckvgNcw==
X-CSE-MsgGUID: 6AaXI4HlSCKplo5ktjTsww==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="40383747"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="40383747"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 03:10:18 -0700
X-CSE-ConnectionGUID: Ue0gGeQiTMGH4g6tjuUukQ==
X-CSE-MsgGUID: gNJkznafQ4ySYqejExBovw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="61758299"
Received: from mylly.fi.intel.com (HELO [10.237.72.154]) ([10.237.72.154])
  by fmviesa008.fm.intel.com with ESMTP; 23 Aug 2024 03:10:15 -0700
Message-ID: <5a0ee0ce-c44a-426a-9019-bf801f22d8f6@linux.intel.com>
Date: Fri, 23 Aug 2024 13:10:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] i3c: mipi-i3c-hci: Add a quirk to set PIO mode
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240821133554.391937-1-Shyam-sundar.S-k@amd.com>
 <20240821133554.391937-4-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20240821133554.391937-4-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/24 4:35 PM, Shyam Sundar S K wrote:
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
>   drivers/i3c/master/mipi-i3c-hci/core.c | 9 ++++++++-
>   drivers/i3c/master/mipi-i3c-hci/hci.h  | 1 +
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> index d1952a5619d4..3aa4aa9deb56 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> @@ -754,6 +754,11 @@ static int i3c_hci_init(struct i3c_hci *hci)
>   		return -EINVAL;
>   	}
>   
> +	/* Quirk for HCI_QUIRK_PIO_MODE on AMD platforms */
> +	regval = reg_read(HCI_VERSION);
> +	if (hci->quirks & HCI_QUIRK_PIO_MODE)
> +		hci->RHS_regs = NULL;
> +
>   	/* Try activating DMA operations first */
>   	if (hci->RHS_regs) {
>   		reg_clear(HC_CONTROL, HC_CONTROL_PIO_MODE);

This looks otherwise ok to me but with "regval = reg_read(HCI_VERSION);" 
removed. I commented that in the patch 2/6.

