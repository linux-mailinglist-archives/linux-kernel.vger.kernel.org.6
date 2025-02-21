Return-Path: <linux-kernel+bounces-525808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BE0A3F5CB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF9C428158
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1527120D50F;
	Fri, 21 Feb 2025 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RwvpD8k7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C3020ADD5;
	Fri, 21 Feb 2025 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143783; cv=none; b=Etd7z7UfU3BEJzcDyorlFBmP3uAFIeRqGUhnTYS2N9/LfbaBD707Bj/H0puRI0q+Id796v0Bz0W7pySgzlJKAYwXrjK7Mkthz6P0PfBVj+Luk20MpTJPj8EkDmsXKyZz+Rv4A+vQV70xvPIU1zom5glpLHGyOj/tRYsLm/0xFKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143783; c=relaxed/simple;
	bh=hEfxolmO06K0UStHo90/Om11/E8igLCbiEfZngCLRSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2JG7mBhPgs/hdAKlGgxNVr3K8HI9Wpkw5h2WXHPwgC8yjTpaCqG2o0EFfS5zgVgg7H9RBAnMzaYjL8LVGHalb+RzuO/pQQo9L3lUmp4prw16xAjJ7VvfTaUOoRpKyqkM3zQVcsbVGqrrcKJaqFKgDgtJ4IHEZqkAKuahbpM6VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RwvpD8k7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740143781; x=1771679781;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hEfxolmO06K0UStHo90/Om11/E8igLCbiEfZngCLRSU=;
  b=RwvpD8k7jqT8Y+BG0/45viudiJKhC4Ih9TCFQqL6nxHtdSTy0q8pWWgR
   1qdAMyYlUZSqjHDCyO7DGZ0n7vsaQ6gUwNCWk320qX+66yTzh3dBCcjPo
   Uk0b4EHUHqZ0gU8FOoOSN1KOxtx2K9NvHLRaGTava1ehDgw3elkKpsRO/
   ZP7+6g96tLLw3zKQh0sHMNyylLWTHIygKbItdoSp5JYFmHtmjZOw+vvoL
   jnKD9ta1Tdl3Ss53wQpR/4y7sJ4n4n8vBjFZMsJLB4JPqp2snP70U/DMq
   1P8pNqAdL1EGbCmSNf9gkR/tO42ZEPj/2iPXshciSEWKSwhsEI2p9GJjT
   g==;
X-CSE-ConnectionGUID: HoXzTk5aSL6FNYMG2QvShw==
X-CSE-MsgGUID: QgwfFuyWSd6IJZQkGsxdwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="41085662"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="41085662"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 05:16:21 -0800
X-CSE-ConnectionGUID: wa5aUpxnRLmpKI5R8IrZtg==
X-CSE-MsgGUID: y6zMRK2LSIOnzghgfLl3lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120613445"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa005.jf.intel.com with ESMTP; 21 Feb 2025 05:16:19 -0800
Message-ID: <e72b2f2b-d327-49f6-bf16-d846e9283e00@linux.intel.com>
Date: Fri, 21 Feb 2025 15:17:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] usb: xhci: Skip only one TD on Ring Underrun/Overrun
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Niklas Neronin <niklas.neronin@linux.intel.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250210083718.2dd337c3@foxbook>
 <20250210084220.3e5414e9@foxbook>
 <7bb25848-c80e-4ba8-8790-8628951806b3@linux.intel.com>
 <20250221021712.48c07fe0@foxbook>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250221021712.48c07fe0@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21.2.2025 3.17, Michał Pecio wrote:
> On Tue, 11 Feb 2025 17:41:39 +0200, Mathias Nyman wrote:
>> On 10.2.2025 9.42, Michal Pecio wrote:
>>> +				if (ring_xrun_event) {
>>> +					/*
>>> +					 * If we are here, we are on xHCI 1.0 host with no idea how
>>> +					 * many TDs were missed and where the xrun occurred. Don't
>>> +					 * skip more TDs, they may have been queued after the xrun.
>>> +					 */
>>> +					xhci_dbg(xhci, "Skipped one TD for slot %u ep %u",
>>> +							slot_id, ep_index);
>>> +					break;
>>
>> This would be the same as return 0; right?
>>
>> Whole series looks good, I'll add it
> 
> I hope you haven't sent it out yet because I found two minor issues.
> 
> 
> Firstly,
> [PATCH 3/5] usb: xhci: Fix isochronous Ring Underrun/Overrun event handling
> 
> increases the number of xrun events that we handle but doesn't suppress
> the "Event TRB for slot %u ep %u with no TDs queued\n" warning, so the
> warning started to show up sometimes for no good reason. The fix is to
> add ring_xrun_event to the list of exception for this warning.
> 
> 
> Secondly,
> [PATCH 5/5] usb: xhci: Skip only one TD on Ring Underrun/Overrun
> 
> can be improved to clear the skip flag if skipped TD was the only one.
> This eliminates any confusion and risk of skipping bugs in the future.
> The change is a matter of moving that code to a different branch.
> 
> I also changed 'break' to 'return 0' because it gets hard to follow at
> this level of indentation.
> 
> 
> I'll send a v2 of those two patches. Sorry for any inconvenience.

Patches updated, they are now in my for-usb-next branch

Thanks
Mathias


