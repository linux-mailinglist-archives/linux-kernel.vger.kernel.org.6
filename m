Return-Path: <linux-kernel+bounces-559775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628DFA5F99A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B694B3BFE90
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250382690EC;
	Thu, 13 Mar 2025 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WwnmLC3F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD92B15E97;
	Thu, 13 Mar 2025 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879153; cv=none; b=MZWWSbdVw6Ct3y2O+uxE/4dsP4pfmi6Sq1q+72aaPKUT9iHocwPfmJ44okrbFR8kMLDABX1q/8zIYV2rTFm/OnEL/WnJUnyq/FAqJB4TMdcDzv5XlQpViaw5/Oq6HxQGxoSM9oOOWCKZ7SpKrsAaHqRQsFntT16ea8T6DL3dBp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879153; c=relaxed/simple;
	bh=LC011z6AwHjc7tVf34PLdUgUl30pEZi9+T4ZlM0W3y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=um30Ds/r6WiCraZcDEt3GzShDsoEjrKdej6jg0jelmoXOX0KOBWtdVucaHmqy6FFIuuuSUMUSosTCNBXWFHm8b/P3Ry9yCH2zwtDReic3KBfkDcq93SSDWZd7tfyoLmy8CHhJsKliHuPOA7QU3oR34j53x7IDNwaPZ4eBN1vvWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WwnmLC3F; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741879152; x=1773415152;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LC011z6AwHjc7tVf34PLdUgUl30pEZi9+T4ZlM0W3y4=;
  b=WwnmLC3Fu65HJdIB8zNLTqawENDCw8qRYpdzhRNkeSqMyiB4h8r5MhOG
   wu6bKdticVTxBk+5DzeiEvPGON9SVoW84mXWa+dbUhPIKxXfE3LmnaaPO
   wzL2WVhZvFldgX7P8O78j/Xo9tmiHKbmJUnlmrpFLQ5Jfk6C2xohJm0xL
   FSEkezcrlIKf6cJVEAo0h0Qs7LHrSeP9Nvw5Ui+F8ScbRDPpXhav31s7i
   +Mcc55j3l+3BJjODKjTMud/93T+K6TMbcfUsUPMEkwDNt0drmiYsy7cNW
   Wzt68mhWXL0xkRgs/hU05tIy6IremSdmoAAIh1jGgYpnZ0TkPeQbZw4+s
   Q==;
X-CSE-ConnectionGUID: aLrmJK9eRUmvTvXIDdsoAQ==
X-CSE-MsgGUID: Uec/1IdST4ymbLwvrqtI7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="60404188"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="60404188"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 08:19:11 -0700
X-CSE-ConnectionGUID: 4obyxuIlS0aXMAj7NLH8Ew==
X-CSE-MsgGUID: 5T3/LeCkRhmrGnHgFI4YdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121202588"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa008.fm.intel.com with ESMTP; 13 Mar 2025 08:19:09 -0700
Message-ID: <8001828c-f623-409a-8ba0-6da00d1db4f3@linux.intel.com>
Date: Thu, 13 Mar 2025 17:20:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5] usb:xhci: Add debugfs support for xHCI port bandwidth
To: raoxu <raoxu@uniontech.com>, mathias.nyman@intel.com,
 gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 wangyuli@uniontech.com, zhanjun@uniontech.com
References: <20250313132132.2856-1-raoxu@uniontech.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250313132132.2856-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.3.2025 15.21, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> In many projects, you need to obtain the available bandwidth of the
> xhci roothub port. Refer to xhci rev1_2 and use the TRB_GET_BW
> command to obtain it.
> 
> hardware tested:
> 03:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Raven USB 3.1
> (prog-if 30 [XHCI])
> Subsystem: Huawei Technologies Co., Ltd. Raven USB 3.1
> Flags: bus master, fast devsel, latency 0, IRQ 30
> Memory at c0300000 (64-bit, non-prefetchable) [size=1M]
> Capabilities: [48] Vendor Specific Information: Len=08 <?>
> Capabilities: [50] Power Management version 3
> Capabilities: [64] Express Endpoint, MSI 00
> Capabilities: [a0] MSI: Enable- Count=1/8 Maskable- 64bit+
> Capabilities: [c0] MSI-X: Enable+ Count=8 Masked-
> Kernel driver in use: xhci_hcd
> 

...

> @@ -2463,7 +2497,16 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
>   	 * will be allocated with dma_alloc_coherent()
>   	 */
> 
> -	if (!xhci->small_streams_pool || !xhci->medium_streams_pool)
> +	/* refer to xhci rev1_2 protocol 5.3.3 max ports is 255.
> +	 * refer to xhci rev1_2 protocol 6.2.6 port bandwidth buffer need to be
> +	 * 8-byte aligned.
> +	 */

The context size needs to be rounded up to nearest 8-byte boundary.
We allocate 256 bytes so we are covered.

Specification unfortunately fails to mention about the 16-byte context alignment
requirement here in section 6.2.6 'Port Bandwith Context'.

This info is hidden in section 6.4.3.14 'Get Port Bandwidth Command TRB' in
'Port Bandwidth Context Pointer Hi and Lo' field 63:4

"The memory structure referenced by this physical memory pointer shall be aligned
  on a 16-byte address boundary."

> +	xhci->port_bw_pool =
> +		dma_pool_create("xHCI 256 port bw ctx arrays",
> +			dev, GET_PORT_BW_ARRAY_SIZE, 8, 0);

Thanks
Mathias



