Return-Path: <linux-kernel+bounces-412644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75649D0BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72622B2523F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F6E1922FA;
	Mon, 18 Nov 2024 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQZL6Tiw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CAC170A26;
	Mon, 18 Nov 2024 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731922526; cv=none; b=bD5QfADb98T1pktxGeWfqEXim26jV/8oh+XBPjr0l1Un/5lWa9jS061H72RJokvxojh6BItGOLwHX4aXVcaPfIHta0XifVEKBEA/VxiL7RWFZco60/ChiSTMG8HbJMimZ5d+y6+/S9qEA7hJGP14UqDVACJjOTuDlu0JAFH10ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731922526; c=relaxed/simple;
	bh=jslPtYrvtvcWRCmGsXNvAPvGPzRKrRWo4jeCdN00/1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fb96T9Op2evBKsPj/Q5zKOTNKnhzXy+tsckABkWID1H+z7COGevmc5KDCnltO6TkYY6tr2tS7lnkSo1q4DuxkTWaYFkHxcfnNl9wKR4gTa1zefeGDbGax+ApP29C6XPhRa6JxGH303DmQWxDrpP3Y3OAXdtGT+M3SfD6aStvSGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQZL6Tiw; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731922525; x=1763458525;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jslPtYrvtvcWRCmGsXNvAPvGPzRKrRWo4jeCdN00/1c=;
  b=IQZL6TiwHdDcO0P0BHWEjH6lfUVzGxY7/Q6xdSWxI2jr1IftOst7OXWe
   naascFuK7C+UceYAQKwKOwmVdkxjDz7ByBEAm8iw2RyEViTOYD96bPfGi
   g55sQipuEj9EEst72UNuS5e35qGYZJDxMNbZcF5ep/44baM1F1MC+JIMd
   Q55mrIJ2i0Dkm3MrN8VapAlJy4/htXdNbEf3P40qbZIfnEscuuSMx2MQC
   BsusHuN/9h+jh3U3pgA1QLfbCX+1S+4FN67IW/4YrudALQJnz/4V9gdwO
   xA1jqouFJjEmNRCXuAygmy02A7Poi9OD9wouoLE+MVPVFhzsOYYL4iV8G
   A==;
X-CSE-ConnectionGUID: Tlw4ZL/xQsqNlMpM8VqnnQ==
X-CSE-MsgGUID: Hvg97boIT4+l/NKpabDs3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="35541607"
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="35541607"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 01:34:33 -0800
X-CSE-ConnectionGUID: 2MHzv7hNSYGlPszQhLbJXg==
X-CSE-MsgGUID: 3pTaRrHrRNuLdOn/bHcrGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="89587388"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa010.fm.intel.com with ESMTP; 18 Nov 2024 01:34:29 -0800
Message-ID: <a02cfe06-b227-431f-baa1-a504857a8dea@linux.intel.com>
Date: Mon, 18 Nov 2024 11:36:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] XHCI NULL Pointer check in xhci_check_bw_table
To: Sundtek <linuxusb.ml@sundtek.de>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>
References: <b90d48df16cf74bb682af870cd71d7c5cc4a9d97.camel@sundtek.de>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <b90d48df16cf74bb682af870cd71d7c5cc4a9d97.camel@sundtek.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 17.11.2024 17.32, Sundtek wrote:
> This patch fixes a NULL Pointer exception when a device using the XHCI
> controller driver is not properly initialized. It's relatively easy to
> reproduce with a faulty connection to a USB Harddisk / USB Ethernet
> adapter.
> The way I used for testing this patch was to short USB D+/D- and pull
> them to ground.
> 
> We manufacture our own USB devices and use Linux for testing, lately we
> upgraded the system to Ubuntu noble with Kernel 6.8.0 and our system
> also crashed multiple times just when plugging in some devices (no
> commands need to be executed).
> We connect/disconnect devices > 100 times (eg uploading firmware, do
> electrical tests etc).
> 
> I would rate this issue as highly critical.
> The problem is triggered via some fallback code in hub.c, a second
> patch will follow which
> removes the endpoint reset in the particular fallback.
> 


> 2024-11-16T22:14:12.122224+08:00 sundtek-UX32VD kernel: RIP:
> 0010:xhci_check_bw_table+0x100/0x4d0

This looks very similar to a null pointer issue I fixed recently.
Patch should be in 6.11 and recent stable releases:

af8e119f52e9 xhci: Fix Panther point NULL pointer deref at full-speed re-enumeration

What kernel are you running?

Thanks
Mathias

