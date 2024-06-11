Return-Path: <linux-kernel+bounces-210108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5516F903F68
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5020B1C23767
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5E91CD06;
	Tue, 11 Jun 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eaH6STUm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F45208AF;
	Tue, 11 Jun 2024 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118031; cv=none; b=IdI6mvyQDvFfRDMxbWaUKGxiE6/nKnBxjHKCFhLmNBDWvvpcWtpWRytxSa1MI3yo3VYtk6cb0Zov7xvY3C4GOtR6AjXBuBFYtAV8lfQU7vhDOdVpT1kViFFrAR9T6yIeggr617p12Cz+5pb5fk/BrPsBs1tL6v49NFSohOBJKiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118031; c=relaxed/simple;
	bh=91mEIWE6KuDoenU3fDkspc4I9RYUULOQfo4L08RhrXI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=sEGEdVtbtjP5TgY4Nd/KNtLnF55Dlth2SpsBI/T5i6TMgyGZ0Nq3+a+eK/KQ1dUu6OMqwY7Efba5aohM5vvp6qN2UoXpDMpt0mSb6zDgFbRusasN869CEjX3FrDgXeuAMGTr2aB//htSkGM/cB/adRvEIlPfVqhRCGVlE0hqu24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eaH6STUm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718118030; x=1749654030;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=91mEIWE6KuDoenU3fDkspc4I9RYUULOQfo4L08RhrXI=;
  b=eaH6STUm11tczp1mrkH+gbSAOBJr1p0v147mn8TLkkcd4V/dno3vGE/j
   EO5W8mQccd4HhMrRdNPRhkBpq+SQwc5JrZ1Bj2tMqnLm5frdzi2PINvoo
   qfk+JTd0U7awviTW0Jj4gh/fAKYVwJ5XpuAgaBWoJU3vq3y4Ai1ZGbvrO
   bFxddHuInUEHb1KGkUD54ts9aS+BetryZzwI6PMXuXnB9SFPrPbnuYsd7
   9iaKEeJIcUkK0efHjX4VkXacvR4kcWv80VgWOBQFwoyFVWoPEcoGO9Nmx
   i/U3aW6mmanWjvWxVUwj6riJxpHc2plFn2AuThaU/JlvstHl1A59JHJAd
   w==;
X-CSE-ConnectionGUID: fznZbByrTUyoo57yEUm1aQ==
X-CSE-MsgGUID: IRW34F2NRdqUBS6IQa30zA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="14787680"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="14787680"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 07:56:10 -0700
X-CSE-ConnectionGUID: WKI8vl8xQ2Wimmzj0ir7pA==
X-CSE-MsgGUID: o2sGCjdnQ364eDUqdQN9ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="39552759"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa009.jf.intel.com with ESMTP; 11 Jun 2024 07:56:07 -0700
Message-ID: <b5deb873-7151-46fa-164e-9e2c6a339636@linux.intel.com>
Date: Tue, 11 Jun 2024 17:58:05 +0300
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
 <2521588d-30a6-0224-c7c9-3015e9cc65a3@linux.intel.com>
 <CAMtoTm2G-w+yRjechji7scJO-JZo6N==VK6Wun3ATRc7do9rEg@mail.gmail.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [RFC 1/1] usb: host: xhci-plat: add enable XHCI-AVOID-BEI quirk
 by dts
In-Reply-To: <CAMtoTm2G-w+yRjechji7scJO-JZo6N==VK6Wun3ATRc7do9rEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.6.2024 17.45, joswang wrote:
> On Tue, Jun 11, 2024 at 6:01 PM Mathias Nyman
> <mathias.nyman@linux.intel.com> wrote:
>>
>> On 6.6.2024 17.08, joswang wrote:
>>> On Wed, Jun 5, 2024 at 6:31 PM Mathias Nyman
>>> <mathias.nyman@linux.intel.com> wrote:
>> ...
>>>>
>>>> I was thinking of turning XHCI_AVOID_BEI behavior into the new default, so no
>>>> quirk flag would be needed:
>>>>
>>>> Currently without the quirk flag:
>>>>
>>>> - ISOC TRBs trigger interrupt if TRB is the last in the TD
>>>>
>>>> Currently with XHCI_AVOID_BEI quirk flag:
>>>>
>>>> - ISOC TRBs trigger interrupt if TRB is the last in the TD
>>>> - Interrupt is additionally triggered every 32 isoc TRB (initially).
>>>> - if more than 128 events are processed in one interrupt then the
>>>>      32 is halved, and we trigger an interrupts every 16th isoc TRB, and so
>>>>      on, 16 -> 8...
>>>>
>>>> I would remove the quirk flag, and make all controllers interrupt
>>>> behave as if it was set. i.e. interrupt at least every 32 isoc TRB
>>>
>>> Thank you for your detailed analysis.
>>> Excuse me, I have a question, do you mean to set "Currently with
>>> XHCI_AVOID_BEI quirk flag" as the default behavior?
>>
>> Yes, unless it causes some issues or there are strong objections
>>
>>>>
>>>> Is there an actual real world case where interrupting every 32nd ISOC TRB is
>>>> too often?
>>>
>>> I mean that if the XHCI_AVOID_BEI quirk flag is set, an interrupt will
>>> be triggered every 8 TRBs, which makes the interrupts seem to be quite
>>> frequent.
>>> Thanks
>>> Jos
>>>
>>
>> It should start with interrupting every 32nd isoc TD, not 8th
>>
>> #define AVOID_BEI_INTERVAL_MAX   32
>>
>> ir->isoc_bei_interval = AVOID_BEI_INTERVAL_MAX;
>>
>> Thanks
>> Mathias
> 
> As you mentioned，if more than 128 events are processed in one
> interrupt then the 32 is halved, and we trigger an interrupts every
> 16th isoc TRB, and so on, 16 -> 8...
> xhci_handle_events()
>      ......
>      if (event_loop++ > TRBS_PER_SEGMENT / 2) {
>           if (ir->isoc_bei_interval > AVOID_BEI_INTERVAL_MIN)
>                ir->isoc_bei_interval = ir->isoc_bei_interval / 2;
>      }
>      .......

Yes, and to me this seems reasonable .
If there are over 128 events per interrupt then we should interrupt more often.

Would this work as the default for the Synopsys hosts you are working with?

Thanks
Mathias

