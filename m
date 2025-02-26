Return-Path: <linux-kernel+bounces-533865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C26A45F84
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714111685EF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2692163AB;
	Wed, 26 Feb 2025 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4M6kLak"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9752C214803;
	Wed, 26 Feb 2025 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573648; cv=none; b=SZQxXA8ytMKr/dgNVXk9aVZSQOfTYgrXPtsv6e6sWGoMqLkmHsToVLim0wzLrRU9arcau5sVZPuUr22l9pW7LD1KAlYbLtEm+BB8qbYAW4Dcz7pS1Ig/fOnAy9Jl8kmEchHT1fe9Zfv9hP62tUPuiDDQ+UrRPDT/perchcvLFXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573648; c=relaxed/simple;
	bh=AyX3eeqoqqrJcrTXy8JrokTY4/mNoUqm6EwAoze0Qrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpH/9ZlEKIrbDEOy1dUOerWYV2ooUcL7pGySjzYI/NUETAIefB8o4dLlMjA/lKWLk/wpIwEKUdGD0MDYazPR03l5fim0wYgRez9w5Iy9V3i3wTCH376SFjy1i9WcK+hIxp8FBR+1v6CV5KijKUk1kD0uuA2jWYrm9jF26U1/H7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4M6kLak; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740573647; x=1772109647;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AyX3eeqoqqrJcrTXy8JrokTY4/mNoUqm6EwAoze0Qrc=;
  b=e4M6kLak6JNOaR4quwCawXu0WrUA7M1yPiroOFdAVAG/QZn2GfAuAhJs
   X2O3LZI4CEIMX+scdvdaYBuuHkhclULomn+lSHVlo48l53R87MfLOtpVh
   N2OvuMb+R0FP7xbnInjLQ/mlgWDPGVR8QqKftNDTYeuVasZ1RDg9OZGuV
   /71nWcsURFVkz1f5sblqhsRvu2L46Id3hSNItz1U1LtL8f2L4P936JFL/
   u0WdPel/zYlU47KTKin7TzMFXHAkD8RsZd+sP2TfK3Jv1FYyvP06OPLyq
   be14AJz2XJ8s/im8ljxoCoJzl7znnpWiWJjzy2nFsI8xhEshL4TBy1Fqc
   A==;
X-CSE-ConnectionGUID: HaLQvjarTg+uEbzl3QsG0g==
X-CSE-MsgGUID: h7QwXGJ+RsqRzVQh8HQngA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45065270"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="45065270"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 04:40:46 -0800
X-CSE-ConnectionGUID: AupgKeyPT0WSPrBOkR32oA==
X-CSE-MsgGUID: kEAa4Lc5Q+iXq/ocPSc+Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="121790490"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa004.fm.intel.com with ESMTP; 26 Feb 2025 04:40:44 -0800
Message-ID: <8bf4212a-72af-4c5d-a9b2-f3363d3ee3cd@linux.intel.com>
Date: Wed, 26 Feb 2025 14:41:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] xHCI: Isochronous error handling fixes and
 improvements
To: Michal Pecio <michal.pecio@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250226080202.7eb5e142@foxbook>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250226080202.7eb5e142@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.2.2025 9.02, Michal Pecio wrote:
> These patches reduce latency of error reporting in some cases related
> to 'error mid TD' and Missed Service events and sometimes fix a failure
> to give back such TDs altogether until they are cancelled.
> 
> Also included are fixes for potential packet loss or memory corruption
> due to obscure races. Whether it causes problems IRL is not known and
> the worst case would be hard to reproduce, but exactly for this reason
> if the worst case actually happens, it could be hard to debug too.
> 
> The first three should be safe. The fourth should also be safe, but it
> relies on HC functionality Linux never relied on before, so I placed it
> towards the end in case it would need some tweaks. I tested it on all
> hardware I have and it worked just fine.
> 
> The last one is perhaps the most controversial, though it should be
> OK with typical "complete -> resubmit" drivers. It's the only one here
> which increases latency in some severe error cases. The intent is to
> avoid potentially giving back URBs not yet executed by hardware.
> 
> New in v3:
> - dropped the cleanup patch
> - added Don't skip on Stopped - Length Invalid
> 
> New in v3:
> - fixed spurious empty list warning on xrun
> - clear skip flag if one skipped event was the last
> 
> Michal Pecio (5):
>    usb: xhci: Don't skip on Stopped - Length Invalid
>    usb: xhci: Complete 'error mid TD' transfers when handling Missed
>      Service
>    usb: xhci: Fix isochronous Ring Underrun/Overrun event handling
>    usb: xhci: Expedite skipping missed isoch TDs on modern HCs
>    usb: xhci: Skip only one TD on Ring Underrun/Overrun
> 

Updated my for-usb-next branch to this v3 version

Thanks
Mathias

