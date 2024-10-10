Return-Path: <linux-kernel+bounces-359029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06312998692
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4342811D3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9584E1C6895;
	Thu, 10 Oct 2024 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n85eOlqh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7ED26AC1;
	Thu, 10 Oct 2024 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564511; cv=none; b=J6K/qBQm7uUVmNJYj5Ixz/076vRsVP9NHzYmqjJqCWp9Phc+ek8gTO60Z7QnfOMTjibEQ0eD/i8xUzcOSQjZdMDuopGgCB0hHbbnkOg+6dbRpE4OwNlG88/rpem5Tu87mH/KTRggGNwzGHocwy6Pv3/xwap+Mz6HxaygEfnuLUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564511; c=relaxed/simple;
	bh=1MwKCCt1VrsU58WzRhO2ITnke9QciobIkouzyPq0K5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkRkEvmTtcraWNBzYdd9joTBVT/bi7BJB7/Y8QLar4D28v0Y+II0KXY4xgLKCnKiz8roT1G6bjPShvw5SAYsJujgRy2QUdWx03i07FcD9ihPLak4lOdULiv0GaPebNFxWpVS0PLqF4ET7eKHIcj9yA9dQDcPJQs5rGaz5RfG1MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n85eOlqh; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728564509; x=1760100509;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1MwKCCt1VrsU58WzRhO2ITnke9QciobIkouzyPq0K5Q=;
  b=n85eOlqhAj6b2p3uHPPlOxHPkWZdDlgxGZJ4G++MORw5fsU93b1B9Y6c
   nbHhlbUQeswiFpL082NsGWuCpeJepnZAu1Xu6p0emQ+pc6AkBoEaajBvY
   oW1jNVuA3WiwVvQe4+SCKVFNmnJyNjqWdzurKU+UU9PCwYJpGzrXSnqbJ
   P42YalOJdphdIbeBk5gTbaFgKzTB6BoLm0HGNlob7duVLRLvfwrEKwi+O
   8EloH6wif1ZgqENnrlZkDuTjA4tTqPtf+XeDctuwgZEpYjG9ja4+DSB9R
   lnw1kO7jYx5/rYasY9/YF7uElILQC/o6XGoPyW9lo2/STLpFIMVECdb1a
   w==;
X-CSE-ConnectionGUID: Wu9MYUObQUmjAZD2Lvx+8g==
X-CSE-MsgGUID: mv5EUB/MRzOgXckczQXPoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31616550"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="31616550"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 05:48:29 -0700
X-CSE-ConnectionGUID: 2bYxUVHcTf+gOm0STMsfiA==
X-CSE-MsgGUID: E8Pyp1w6TS2jl42lDqjQHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="114047840"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa001.jf.intel.com with ESMTP; 10 Oct 2024 05:48:27 -0700
Message-ID: <e24f7662-6945-4aa2-985a-98ca39c68bca@intel.com>
Date: Thu, 10 Oct 2024 15:50:36 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci: xhci_setup_port_arrays: early -ENODEV if
 maxports is 0.
To: Olivier Dautricourt <olivierdautricourt@gmail.com>,
 =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20240930052336.80589-1-olivierdautricourt@gmail.com>
 <20241004125716.75c857ae@foxbook> <ZwA-n56XlNkkLNXM@freebase>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@intel.com>
In-Reply-To: <ZwA-n56XlNkkLNXM@freebase>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4.10.2024 22.14, Olivier Dautricourt wrote:
> Hello,
> 
> On Fri, Oct 04, 2024 at 12:57:16PM +0200, Michał Pecio wrote:
>> Hi,
>>
>>> If the controller reports HCSPARAMS1.maxports==0 then we can skip the
>>> whole function: it would fail later after doing a bunch of unnecessary
>>> stuff. It can occur on a buggy hardware (the value is driven by external
>>> signals).
>>
>> This function runs once during HC initialization, so what's the benefit
>> of bypassing it? Does it take unusually long time? Does it panic?
>>
>> It seems to alreday be written to handle such abnormal cases gracefully.
> 
> That is correct, the case is handled without panic, but the 0 value gets
> silently propagated until it eventually fails on line 2220:
> 	if (xhci->usb2_rhub.num_ports == 0 && xhci->usb3_rhub.num_ports == 0) {
> 		xhci_warn(xhci, "No ports on the roothubs?\n");
> 		return -ENODEV;
> 	}
> The benefits are only:
>    - Reporting a more precise issue
>    - Avoids iterating through the capability structures of the controller
>    - failsafe if future changes
> 
> This is totally a nitpick as the case is unusual, if you think it is not
> worth taking it upstream i'll understand.
> 

I think we'll skip this. An abnormal case like this where the host would be
useless anyway is already handled reasonably enough by driver.

Thanks
Mathias

  


