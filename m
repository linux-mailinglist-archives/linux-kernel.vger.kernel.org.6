Return-Path: <linux-kernel+bounces-274351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E521947714
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4907D1F21A16
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD7F14E2DF;
	Mon,  5 Aug 2024 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ibzO+Ctr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A7313D26B;
	Mon,  5 Aug 2024 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722846067; cv=none; b=o83HFFiJn0EZZNUpG9i7OgxhFE0X5MQ+ruhQnFZ2IzLHhq1qOAFqKbuGZygGuUXZftdYB4yQVxxLKhJsfqYWCCJ1yNTXyV3+dq7NJccCfiX6XG4G1fQYUF8wxIgRMSxrFeAptDvySicr0dJzJV2+zDebLTGEC4Xf+BS5hPXPYHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722846067; c=relaxed/simple;
	bh=coDKCquEaSa9dhb349rsJ+ib143fvS4NbzUz7GkXh5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCKwSjfZGKcqYK87qknq13at6qIu+/IvjkXl8jlXHYYYS1Je/E3itiS/YdLGIKcWUMx9H8RY29uobpbGvL2JOGptwJJsXhpO97qn6I8YuiYdFgvs2buFUkKRyCWZxxpdT+IEk4Op+UQWEDmqCQz2mIVXJLAQzfKaxCoN7uM9GT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ibzO+Ctr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722846064; x=1754382064;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=coDKCquEaSa9dhb349rsJ+ib143fvS4NbzUz7GkXh5g=;
  b=ibzO+Ctrs2b6WL5dYMFH+4mRNlmus3A6zgTPoVlXojfMHO7t5cEpTF5K
   5LM5o07gAHpUZhbUytRRJOkf4qzPstXqCVPtL3vFf/GS17UPkqiiQb+l1
   yxD118A9Y7oLh7iOwe0vGhacQPM2X1jAq4FSk07xR7ZbwWN/hX6UDiZv9
   q/EoxdxJDbz01/k1/VEbxiz0Z3Dylc49te7SIi3pmrLMdD/PKtFQdHCku
   g5PtE/E4wFrNdDKtXm8uyopKuQcNMZy5KVzoldrTqaH83yXGggBOQAO3c
   DC24TWPVxz31RNo7IvcZOZBsDg2F7usRRM2BfxGf5MIymRWxLPklRPSzy
   w==;
X-CSE-ConnectionGUID: qZaHaEyMSyiv99UndwaPxA==
X-CSE-MsgGUID: gWZab3ilQFCjhVo7TSz8Hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="20946526"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="20946526"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 01:21:02 -0700
X-CSE-ConnectionGUID: IF26ls0fTIW1hLFLduZ/HA==
X-CSE-MsgGUID: cXGbxKkCSbO/IQjEVnwKeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="55758075"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa006.fm.intel.com with ESMTP; 05 Aug 2024 01:21:01 -0700
Message-ID: <d3f16547-80db-48a8-9a6c-7eaf26da9ece@linux.intel.com>
Date: Mon, 5 Aug 2024 11:23:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci: Check for xhci->interrupters being allocated
 in xhci_mem_clearup()
To: Marc Zyngier <maz@kernel.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Wesley Cheng <quic_wcheng@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240731205910.2060752-1-maz@kernel.org>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20240731205910.2060752-1-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.7.2024 23.59, Marc Zyngier wrote:
> If xhci_mem_init() fails, it calls into xhci_mem_cleanup() to mop
> up the damage. If it fails early enough, before xhci->interrupters
> is allocated but after xhci->max_interrupters has been set, which
> happens in most (all?) cases, things get uglier, as xhci_mem_cleanup()
> unconditionally derefences xhci->interrupters. With prejudice.
> 
> Gate the interrupt freeing loop with a check on xhci->interrupters
> being non-NULL.
> 
> Found while debugging a DMA allocation issue that led the XHCI driver
> on this exact path.
> 
> Fixes: c99b38c41234 ("xhci: add support to allocate several interrupters")
> Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
> Cc: Wesley Cheng <quic_wcheng@quicinc.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---

Thanks, Adding to queue

-Mathias


