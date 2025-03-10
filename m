Return-Path: <linux-kernel+bounces-553832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDC5A58F75
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2413ABA09
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E3C225397;
	Mon, 10 Mar 2025 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RzHd05F1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747A9224B02;
	Mon, 10 Mar 2025 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598679; cv=none; b=ROEuFbXzCItdnxkZUy8Q23MVmafDxNMk/V5bo5iGzquXV7pWHiI7sg9xnTaI9yedB3hRdWvIKqPzLtOxK/30H9z4WucOWf3SkWehutPyLc/q1Vxvj6htb/MGYnq+5d7InAC0EgiRMB5GmhEaik2BTRjFZ0nQUDQDvtdylJZKssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598679; c=relaxed/simple;
	bh=hECfRF2FQ3Pedwa24aBis0e5mmu59YMNNbs0XD5bavg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OhE/UEyW/E0DKLdha9scI6I4Bs4pqzwwlJYoOWUU+qzDkcEGJvTZMY/h5+q7eE75HpHQabiXGE+F+dTPiuVRIHZHUQQPns5Sbrpn/Pk+1/An0ZkTK9FIXppS11Nv/3hnB2Ichq5zCm5e9O62ATwMxGIafRMimuZyf4RbmetzAtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RzHd05F1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741598678; x=1773134678;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hECfRF2FQ3Pedwa24aBis0e5mmu59YMNNbs0XD5bavg=;
  b=RzHd05F1ZShBaCnOcN5QVr4TlGKpH64hnhHlrEUHvyAtGO2aJcSeZ4pF
   wOTjSMcnaRxT4qL17QDjKS0QTsaVDNS5J+kFLcrhJ1wvZ4X7wRHtC3Nnv
   le3G7cxV8lTfqoLnJwe8F7z8t0WWGR0PGJ2Pp4GqAwE4MIBt5PcWte3NA
   /GV4u4+ZtexO8YuGVfKiw0A0xy0EOyM/P6VnLGV2xMUXphlD1fDIXbbAk
   1f9dxyfkNMM+2xsg0oxVUeXHvTZ51CrIjKOi+LvATxKUJ7mpB77/F1Lc7
   mw6RxYd9YGXutR3B4CtbKyn3ARadl4UDgWqWcGgwjw/xuVQlt+3qY01wu
   w==;
X-CSE-ConnectionGUID: CCN5GCg9S6619ylr55bpUw==
X-CSE-MsgGUID: YiJVLevDTnOoSWGu9EBkqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42774720"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42774720"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 02:24:37 -0700
X-CSE-ConnectionGUID: lObWUbnQSMqjeYX90UBaCg==
X-CSE-MsgGUID: A0MUXrBjQ9iRi1uV8s+lKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="120426977"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa010.fm.intel.com with ESMTP; 10 Mar 2025 02:24:35 -0700
Message-ID: <fd9d007e-5957-42e0-a4b4-fef2d43d3410@linux.intel.com>
Date: Mon, 10 Mar 2025 11:25:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] usb: xhci: Document endpoint state management
To: Michal Pecio <michal.pecio@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250310093605.2b3d0425@foxbook>
 <20250310093659.04b082e3@foxbook>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250310093659.04b082e3@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.3.2025 10.36, Michal Pecio wrote:
> Add systematic comments describing xhci_virt_ep.ep_state flags and
> their relation to xHC endpoint state.
> 
> Add a few paragraphs about how they are used to track and manage the
> state of endpoints.
> 
> Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
> ---
>   drivers/usb/host/xhci.h | 44 +++++++++++++++++++++++++++++------------
>   1 file changed, 31 insertions(+), 13 deletions(-)

Nice cleanup and clarification

Thanks
Mathias


