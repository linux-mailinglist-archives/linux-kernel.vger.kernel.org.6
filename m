Return-Path: <linux-kernel+bounces-528938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE35A41E38
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14844422E89
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF18257AFC;
	Mon, 24 Feb 2025 11:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EtBBr8i6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864D624BC09;
	Mon, 24 Feb 2025 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397712; cv=none; b=SaRHTwba130cQxfsaI/IQBh+PtP3Se/cGT0ePIoblpigExsLaD1xgLxFSamUUvYgOhc5zD1SbTWqdlqu0gFJe00oSniltuhzCsw4s6xbu8d7nFyVrDIMTxeeLWM1QAoJ0M1BfdpQMTEYkTpgW8D+bVpu5MF1X59m+2xQuKreWnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397712; c=relaxed/simple;
	bh=Xw9Qjb3C2GV9IJofjL+2f+6Vhp0kkxBbZpqQ9nfYZCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NStfE7G54NvF9+0aSkOkFJEYpwXCsY53Ffb3KfA/t2uIdAyJsBSkkQb7lkv+TJ2zFL7AGElOo67eO5itaz8NijQBFx3ZRVLS1aN1ACAoMZcd9KLbb9R/Td3aQazLA7+J5kUKCJEyFThZOwam+QqcVY+VHOdMOmCoCZ37xO5TXgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EtBBr8i6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740397710; x=1771933710;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xw9Qjb3C2GV9IJofjL+2f+6Vhp0kkxBbZpqQ9nfYZCU=;
  b=EtBBr8i66I78rTo2cWgtbmwfQ7lFOMRVeyUIu6RBxzGf958U5h1+earG
   msLqOZZKthSMwOr8B3gPtdt3kMAxeac53QNo/noBS0b1Fm1fTuUDlt2uo
   l8Z6OgvFIIIn8qTZy/MF1OSuQArf/2KRviOGVh/jFGVGZM292cKjaOwvP
   zplXf3D2+NJGElDuLSxBzLEb7/xDj79TuHuuGQHT3UTp3eF3KJ/QZ0kPp
   /c1+WgsUeKcfogXWG5a4+Yaz1wh/JYLMW+IU4VuY4ZA7YrXMBP7ZnfX7t
   /reND5+F8LdxY2dldkm+wFi9Ofzs/7hUk/hQ8llOa3zpnyJr3xXKvt1j/
   Q==;
X-CSE-ConnectionGUID: DqYWd9aNSoOYFdLJrgrT3A==
X-CSE-MsgGUID: TSaKvwg6TWWzOIHmWLtbDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="40335707"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="40335707"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 03:48:30 -0800
X-CSE-ConnectionGUID: zp9kI7nMQpGhT3DpmT/uAA==
X-CSE-MsgGUID: +Gr0B2k2SkWpxLo2Z453rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116665750"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa009.fm.intel.com with ESMTP; 24 Feb 2025 03:48:28 -0800
Message-ID: <91e9b2f6-d9f6-460e-965a-bf2d5b13878c@linux.intel.com>
Date: Mon, 24 Feb 2025 13:49:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] usb: xhci: Unify duplicate inc_enq() code
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250220234355.2386cb6d@foxbook>
 <20250220234719.5dc47877@foxbook>
 <d59a6694-e0e7-46b7-874e-0c6acd8c9126@linux.intel.com>
 <20250224004542.5861d4dc@foxbook>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250224004542.5861d4dc@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.2.2025 1.45, Michał Pecio wrote:
> On Fri, 21 Feb 2025 16:54:11 +0200, Mathias Nyman wrote:
>> On 21.2.2025 0.47, Michal Pecio wrote:
>>> Remove a block of code copied from inc_enq(). As often happens, the
>>> two copies have diverged somewhat - in this case, inc_enq() has a
>>> bug where it may leave the chain bit of a link TRB unset on a
>>> quirky HC. Fix this. Remove the pointless 'next' variable which
>>> only aliases ring->enqueue.
>>
>> The linnk TRB chain bit should be set when the ring is created, and
>> never cleared on those quirky hosts.
> 
> OK, I see, there is stuff in xhci-mem.c. I'll remove the above text
> and any code which touches the bit on quirky HCs.
> 
> Speaking of which, I have some evidence that NEC uPD720200 has the
> exact same bug as AMD, namely after a Missed Service Error near the
> end of a segment it fetches TRBs out of bounds and trips the IOMMU
> or stops with Ring Underrun. Link chain quirk seems to fix it.

Interesting, I wonder if setting the link TRB chain bit would
also help with the TRB prefetch issue on VIA VL805 hosts.

Maybe we could avoid allocating the dummy page by just setting this
quirk instead.
   
> 
>> maybe
>>
>> if (trb_is_link(ring->enqueue) && (chain || more_trbs_coming))
>> 	inc_eng_past_link(xhci, ring, chain);
>>
>> Avoids calling inc_enq_past_link() every time we increase enqueue,
>> and explains why we call it.
> 
> I can do that too. By the way, do we actually want this while loop in
> inc_enq_past_link() at all? Currently links only exist at the end of a
> segment and always point to the beginning of the next segment.
> 
> I noticed that per xHCI 4.11.7, "Software shall not define consecutive
> Link TRBs within a TD". I suppose "consecutive" means "one pointing to
> another". And if it's prohibited inside a TD, it will likely always be
> easier to avoid doing it at all than try to manage special cases.

I don't think that loop is needed. The xhci driver is the only creator
of link TRBs, and at the moment they are placed exactly as you said.

Thanks
Mathias


