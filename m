Return-Path: <linux-kernel+bounces-525819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55785A3F5DA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923EF1884B76
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97F220A5EA;
	Fri, 21 Feb 2025 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nV/iDQiI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91E118651;
	Fri, 21 Feb 2025 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144135; cv=none; b=jZhlcTPrxYbToDwRBLM08ksQIvfECH8QdmAH3PqyEtFvDyx4AJX6wkcwq/AdE7Nsjy/Xad63sL8M23yaDvVTN+i7zmHacuobCiW9cYYUdj//FMjfCYGNT2a1dZW/tOwzr3vqW3fOWP9k8Nmu6wm8Ms7xFit6Q2WOYXv/UOIJCWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144135; c=relaxed/simple;
	bh=5nofOT4jU2NHxmhSPVYytlfPpDoj8bGuh9b4nzJ/Spo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njQ4O3PZJjGOX1ltOrwmQ5OgC9LoYpo7xT+kcOYbQgpZqxXAOIrqjKN5XHzDxoNMgeNflOAVrtitmtPqZwhKI0X8z6198iZkgVJOt0r5bPolE5r4aPArw3tbUZU/BAjBv4TEXFAXP3GCN/UN+BN2mO+istTpf9MKFUJK4PSndvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nV/iDQiI; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740144134; x=1771680134;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5nofOT4jU2NHxmhSPVYytlfPpDoj8bGuh9b4nzJ/Spo=;
  b=nV/iDQiI6YYr9VKF+RAbvoHe9h67UAwbs2Wsi7Zto27aM/VEgATJthT8
   ve5NsxhLxfSQm9T4BbZMnISYo5BqpGjYpwi/c2nYSm5fHiDR2JVIRWXOB
   iM0x67Wi3pZB/VY1ZXDH8J66nUkmemnOHpSWXp6N8drcV39V9OT31go7S
   YGvV6t/mhHFuZjzdW/5BOyWoz+vAGwhf+1qpALFZV3ur4uSRM0LY+SNjC
   XryaUuA9hwmMKwaP62prNgnAr2C7jv+RpGUMkCR+zsNMTHhVw6lNXXoB+
   +oebbznYi6soSLoVXnPPyPasEvL4n8r6QNaF0r96OvjSmx2QL6vjWF5ks
   A==;
X-CSE-ConnectionGUID: 3VK5NHADR5+urXOx51wvgg==
X-CSE-MsgGUID: BsnSBz0JSii4HV9bkzINWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40977145"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="40977145"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 05:22:13 -0800
X-CSE-ConnectionGUID: I/OOPYLiQXyn5zwOJmiMqg==
X-CSE-MsgGUID: ScytPYCnQ9OSkZAJ6yzYaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="138590447"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa002.fm.intel.com with ESMTP; 21 Feb 2025 05:22:12 -0800
Message-ID: <e3ca349d-c77d-4643-9865-f9991b34540f@linux.intel.com>
Date: Fri, 21 Feb 2025 15:23:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] usb: xhci: Simplify
 update_ring_for_set_deq_completion()
To: Michal Pecio <michal.pecio@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Niklas Neronin <niklas.neronin@linux.intel.com>
References: <20250220234355.2386cb6d@foxbook>
 <20250220234458.4bf8dcba@foxbook>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250220234458.4bf8dcba@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.2.2025 0.44, Michal Pecio wrote:
> This function checks if the queued Set Deq pointer really belongs to the
> ring it was queued on and updates the ring's dequeue state. It also used
> to count free TRBs, but that part has been removed.
> 
> The code is needlessly complex and inefficent, walking TRBs one by one.
> And it could "jump off the segment into la-la-land" if a segment doesn't
> end with a link TRB or if the link points to another link.
> 
> Make if faster, simpler and more robust. Upgrade xhci_dbg() to xhci_err()
> because this situation is a bug and shouldn't happen.
> 
> Signed-off-by: Michal Pecio <michal.pecio@gmail.com>


update_ring_for_set_deq_completion() isn't needed anymore.
Niklas already wrote a patch to remove it.

It's sitting in my for-usb-next branch

https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/commit/?h=for-usb-next&id=ee7dab196a7dfc48a1608274329323cb10b4340d

Thanks
Mathias


