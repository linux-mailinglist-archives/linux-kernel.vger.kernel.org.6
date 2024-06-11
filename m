Return-Path: <linux-kernel+bounces-209601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EE990384B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D32C81F259A4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350B6178367;
	Tue, 11 Jun 2024 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KP7GF76V"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2E3156E4;
	Tue, 11 Jun 2024 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100078; cv=none; b=qFLj0NGBit0xcKQ8XlbQKtPwjr7Hnsh2K5EEn6X388mog7l/cBYHH1nqhQaRJqWNPovhOklTbu4tUwe6CBzGmNDYxXNB6flMWgR/GvjnJPvjUyEm3WYGNdCCXpRZAxA4AbESThIyhcL6dMTcPUm2taDINgIHHnWpVKAFlrjgOyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100078; c=relaxed/simple;
	bh=ggPG9b6TNNKiUjNFos4MILcxXVYMu4KqSdYzkK1KBIo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=lmjm6AXHqUWoMq2Q14Wzfywl/Ga3+aL0cK61L8LIA7q8MD+Udop5Pp0Ws58tjbl+TGIMCnWtPHim4t+kgYdKRajuqBfYknF4Giva/qQgHsDAmvNBktJz1Pa9kWPDh+WIqeslCDt4FuHAoKVKJX4uFbFvPTQezGvbPsVmTHS9HZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KP7GF76V; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718100077; x=1749636077;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=ggPG9b6TNNKiUjNFos4MILcxXVYMu4KqSdYzkK1KBIo=;
  b=KP7GF76V5sczUL4+Kzmj7ZKtEmMJhRVz/48Pf+j7VDdYReN8ujwcAOjE
   nfY/zJyiT2ydgUsvAnK+T2x6d9eqN65xG0iLwVPkX1BESfeRn35dCJMSx
   2EhA/GBwrpswdqDKIv+se+M231vkN5X5vIdJp7u72D4cjzR9CHQxSFQWN
   S2PY8W88WAZsAPA+b3GZG0rBB87ucCSIcocToo43WeGg/VmPQqdR+A0Dp
   gKvFDX3qIIbBFAu6p3COmWy/U5b2uO8wJDnvL5gxGrfXxvJ1W/CBrtyZH
   s85UaC/MAUiYP+ZDSIxG+2lsC6BwwuHfs/smSubfskxDZYDU4WDXxrkdf
   A==;
X-CSE-ConnectionGUID: TUlSm3vmTFKGWp8fUya5Yw==
X-CSE-MsgGUID: 4ykGU5E6RGevU/LLWRAsIQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14677621"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="14677621"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 03:01:17 -0700
X-CSE-ConnectionGUID: Xsy7rSy8R3ewTSD0fVjORg==
X-CSE-MsgGUID: 4aEFUERaSFqFeOyYa1LB+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="44509583"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa004.jf.intel.com with ESMTP; 11 Jun 2024 03:01:15 -0700
Message-ID: <2521588d-30a6-0224-c7c9-3015e9cc65a3@linux.intel.com>
Date: Tue, 11 Jun 2024 13:03:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: joswang <joswang1221@gmail.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 joswang <joswang@lenovo.com>
References: <20240601120640.73556-1-joswang1221@gmail.com>
 <1662c9c9-7330-4794-843a-940f05802021@linux.intel.com>
 <CAMtoTm1u+8ynBRaWgCMVgaR+dBoZfNGhzGqmvooBSDxZm5Qx+g@mail.gmail.com>
 <c9430561-ecfe-5b36-9574-73a946410eea@linux.intel.com>
 <CAMtoTm1xYUuaV1rO3dZexS=q_5Xf61+QAZ1++VvzK10VtGHexA@mail.gmail.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [RFC 1/1] usb: host: xhci-plat: add enable XHCI-AVOID-BEI quirk
 by dts
In-Reply-To: <CAMtoTm1xYUuaV1rO3dZexS=q_5Xf61+QAZ1++VvzK10VtGHexA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6.6.2024 17.08, joswang wrote:
> On Wed, Jun 5, 2024 at 6:31 PM Mathias Nyman
> <mathias.nyman@linux.intel.com> wrote:
...
>>
>> I was thinking of turning XHCI_AVOID_BEI behavior into the new default, so no
>> quirk flag would be needed:
>>
>> Currently without the quirk flag:
>>
>> - ISOC TRBs trigger interrupt if TRB is the last in the TD
>>
>> Currently with XHCI_AVOID_BEI quirk flag:
>>
>> - ISOC TRBs trigger interrupt if TRB is the last in the TD
>> - Interrupt is additionally triggered every 32 isoc TRB (initially).
>> - if more than 128 events are processed in one interrupt then the
>>     32 is halved, and we trigger an interrupts every 16th isoc TRB, and so
>>     on, 16 -> 8...
>>
>> I would remove the quirk flag, and make all controllers interrupt
>> behave as if it was set. i.e. interrupt at least every 32 isoc TRB
> 
> Thank you for your detailed analysis.
> Excuse me, I have a question, do you mean to set "Currently with
> XHCI_AVOID_BEI quirk flag" as the default behavior?

Yes, unless it causes some issues or there are strong objections

>>
>> Is there an actual real world case where interrupting every 32nd ISOC TRB is
>> too often?
> 
> I mean that if the XHCI_AVOID_BEI quirk flag is set, an interrupt will
> be triggered every 8 TRBs, which makes the interrupts seem to be quite
> frequent.
> Thanks
> Jos
> 

It should start with interrupting every 32nd isoc TD, not 8th

#define AVOID_BEI_INTERVAL_MAX   32

ir->isoc_bei_interval = AVOID_BEI_INTERVAL_MAX;

Thanks
Mathias

