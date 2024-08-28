Return-Path: <linux-kernel+bounces-305102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BF796298C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3A61F23DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A5C188CDC;
	Wed, 28 Aug 2024 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4vPRmKm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1419E4594A;
	Wed, 28 Aug 2024 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853612; cv=none; b=ZjGQG2fGCTPfUtMKGBaH9J4Ray7tXz2hmfqfH5+YIIo/fXSK2xz9Q5gSyY7+l9AtPm8AvaIF1NW2gY+Lk9oYH3AA6Hky+RMN7o430D2dljlmTJaGi17/0gqkmaKFPbCGVam8hJTXsUMtHU39jJPvQ7T2VoYdiP6Wd6Pt2Zt+URs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853612; c=relaxed/simple;
	bh=262HsDi8SjTrTZhMptmD29RDun8i+Qy/tLzsixnVHiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNZ3dWBQ1fko1Ohfiysg0Dn6yM9Vni8nc5MolwXh+TQYEo2o5jfY3HGAXuHd2xN57tyRazDO6iv5T2IX3/XEvIDdiKlpS1uLuQtLsPfRMb5ivuJY0M66pw+x3fvz5HMuPKvPMe+yC/XT1uL+xnel/48LeILI0ZAAbdYsP9CYnS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h4vPRmKm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724853611; x=1756389611;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=262HsDi8SjTrTZhMptmD29RDun8i+Qy/tLzsixnVHiU=;
  b=h4vPRmKmXKFwO/8otQ6AfEapHGWgcuqgfM63wR9T89PFoU7E5SChc+10
   cFoYMafaLIt+hgbosyYxZFUv6ThQ9Zq7nx05PhefKzgm6xLn454AWGk9W
   w+FTbQ0gMPFfXVD5qKLl1fI/ybo3iVNOEf/ViZHf6QwL1zdi1M+cdjZ7m
   WuWOWX5MIDE9M8dkhEGwuap1B0Fi9W8Vt13VV9/21kMXMfkNDHOCaJBU8
   4xo8vmUtBTYyjiYsNboiDUUIFRQzYg2lnQmC4K5JLusgUJ8WsaI6Q7HbZ
   rAXFptcAiqOzzGneanE9TdNZFsUn+P/MhIyeeVYY1u0NRPCF9Saj5wyA3
   w==;
X-CSE-ConnectionGUID: sy5c3bJYR3uDnHQ0RLatzA==
X-CSE-MsgGUID: 0owHvAisSeeoYu/ec91iJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23342898"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="23342898"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 07:00:09 -0700
X-CSE-ConnectionGUID: 4hMcv1cbTaOEQ1EH9fyNkg==
X-CSE-MsgGUID: 4L3ogvpNQuSlDFf9P4mauA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="67374791"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa003.fm.intel.com with ESMTP; 28 Aug 2024 07:00:05 -0700
Message-ID: <bd380d71-4ebe-4889-9ed8-aeefec2b2b0e@linux.intel.com>
Date: Wed, 28 Aug 2024 17:02:10 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] xhci: pci: Put XHCI controllers into D3hot at
 shutdown
To: Peter Chen <peter.chen@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: superm1@kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 mika.westerberg@linux.intel.com, stern@rowland.harvard.edu
References: <20240712185418.937087-1-superm1@kernel.org>
 <20240712185418.937087-3-superm1@kernel.org>
 <20240827063206.GA879539@nchen-desktop>
 <4db33660-2720-471d-a017-1fca4c9b7268@amd.com>
 <20240828071303.GA921051@nchen-desktop>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20240828071303.GA921051@nchen-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> Hi Mario & Mathias,
>>>
>>> According to xHCI spec v1.2: A.1.2 Power State Definitions:
>>>
>>> 	Software shall place each downstream USB port with power
>>> 	enabled into the Suspend or Disabled state before it
>>> 	attempts to move the xHC out of the D0 power state.
>>>
>>> But I have not found any USB core code does it, do you have any ideas
>>> about it?
>>>
>>> We have added the similar codes at non-PCI USB platform, but met above
>>> concerns. In fact, we met kernel dump that the thread usb-storage try
>>> to access the port status when the platform xHCI code has already put
>>> the controller to D3.
>>>
>>> Best regards,
>>> Peter
>>>
>>>
>>
>> This is pretty tangential to my patch.  But FWIW in case you missed we're
>> going to discard this patch in favor of another approach in PCI core.
>>
>> Regarding your point though If I'm not mistaken this should be handled by
>> the Linux parent/child device model.  Each of the ports should be children
>> of the hub they're connected to and the hub a child of the controller.  So
>> when doing any actions that start runtime PM on the host controller the
>> children need to first be in runtime PM.
>>
> 
> It seems there is no runtime PM suspend for xhci and USB core at
> .shutdown currently. Alan & Mathias, please correct me if I was wrong.
> 

I think you are right.  At shutdown we only halt the xHC.
We don't force ports to suspend or disable state.
We only put some selected xHC to D3

USB 2 ports might suspend themselves if there is no activity.

Doesn't seem like usb core hcd code, or hub driver does anything either.

Thanks
Mathias



