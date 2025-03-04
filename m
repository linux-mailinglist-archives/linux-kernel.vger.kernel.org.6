Return-Path: <linux-kernel+bounces-544151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C40A4DDF9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4FE189CD66
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95BA202C32;
	Tue,  4 Mar 2025 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fsCFCsfy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7D78472;
	Tue,  4 Mar 2025 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741091505; cv=none; b=ia9+Zk5CjbB+DpZo8lMYYid7Kcg0DleJ8LbO32GFCHZD+WnzbWmCLX38Ybtcq5cklBQ/rxN1cYZTmd7opjKJ+7EmmEC3Cey6mMWmmuk/MVmAql1E2nuTsPFTDQ0EQBsFut19cMPaZVCOBdyY7qPFTlp0gnGgnMM0SGPCs1900/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741091505; c=relaxed/simple;
	bh=ch5HuCNaSbBnRrFzcfCE8Js6kll47DRucNUGWtDz8Uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A97FtcAtWbtapUtIfOMWTmj5MSvyUzGijiZPLQntxyKdpIBnZOblhydGiAiQJFQdiHYJU9QK8bKSMsS82lQdVW1fJMEpt2LWy/iI+FMewEub9ehqArC8vB8qy9vdlOYDU6qRKusFACieNWrobsG6OnEe7ZO04SyNLwmh0TvgDaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fsCFCsfy; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741091504; x=1772627504;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ch5HuCNaSbBnRrFzcfCE8Js6kll47DRucNUGWtDz8Uo=;
  b=fsCFCsfysbXu9ELDMDfgBzh/ZCgn0TRLB8a4Bxmu205WW+KZ23Ws8u0I
   1U8mKTwOpAUAc4RU18/F0EDsq0geF2unBdIqq+FEQWaO+x478PnHzKQjf
   9HDkzRfRUWthJLdeqvtquvxED+BJ4qAWvafOZUfURla+I7D2s7xC9IT5O
   KQoWsvZ6Seu8mtaKbcgkywcEmAocYxo9B2jh0LGuB4XPqAD1pyYtyvPBS
   D87NzpU1Lnpv41oDHSDgC2YalnrnMGdbkwShDP86sI6pmO+FWgNqhX+k3
   YNA+GK5J2aAYf+kILhmY+c1M0U1m9W4DBQUdi1k+NKsS8Q2uKGRsC+y1A
   g==;
X-CSE-ConnectionGUID: bsjl6KcnSV2faoLruAaXVw==
X-CSE-MsgGUID: 5mHGIu6WRy+KadY1OU2ARA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52212322"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="52212322"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 04:31:43 -0800
X-CSE-ConnectionGUID: GNZ7DyeVQieqBGQjFMgPAw==
X-CSE-MsgGUID: hfgsoOjpRnaaHRCY0h85oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123557789"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa005.jf.intel.com with ESMTP; 04 Mar 2025 04:31:41 -0800
Message-ID: <7f231ac1-69de-43ce-a9f6-23beade42fc8@intel.com>
Date: Tue, 4 Mar 2025 14:32:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] usb: xhci: Add debugfs support for xHCI port bandwidth
To: raoxu <raoxu@uniontech.com>, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 wangyuli@uniontech.com, zhanjun@uniontech.com
References: <20250303105635.21290-1-raoxu@uniontech.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@intel.com>
In-Reply-To: <20250303105635.21290-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3.3.2025 12.56, raoxu wrote:
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
> test progress:
> 1.cd /sys/kernel/debug/usb/xhci/0000:03:00.3
> cat port_bandwidth
> /sys/kernel/debug/usb/xhci/0000:03:00.3# cat port_bandwidth
> port[1] available bw: 79%.
> port[2] available bw: 79%.
> port[3] available bw: 79%.
> port[4] available bw: 79%.
> port[5] available bw: 90%.
> port[6] available bw: 90%.
> port[7] available bw: 90%.
> port[8] available bw: 90%.
> 2.plug in usb video cammer open it
> cat port_bandwidth
> port[1] available bw: 39%.
> port[2] available bw: 39%.
> port[3] available bw: 39%.
> port[4] available bw: 39%.
> port[5] available bw: 90%.
> port[6] available bw: 90%.
> port[7] available bw: 90%.
> port[8] available bw: 90%.
> 
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

Thanks Xy Rao,
Nice to see support for 'Get Port Bandwidth' feature in xhci.

I do however have some larger rework suggestions to this.

Instead of queuing three commands on one file read, parsing and
copy the content from each context dma into an array on stack, we could
have separate files in debugfs for each speed, and queue one command
for each. we could also skip the array on stack and print values from context
directly.

Something is also very off with the locks in this patch.
Looks like every lock/unlock got replaced with an unlock

Thanks
Mathias


