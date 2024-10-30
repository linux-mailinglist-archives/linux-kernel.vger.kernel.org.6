Return-Path: <linux-kernel+bounces-388805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C424B9B649A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F322A1C20B51
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDE41EB9F2;
	Wed, 30 Oct 2024 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bZlgUckK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0ED13FEE;
	Wed, 30 Oct 2024 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296126; cv=none; b=tHCs4lAU+b6abEKbYZ17zqKDdv3L58jaQlFwtKVe0dEh/qmoTHTg8yx8W0gMNXxZN1QqR3etGQW+bKBC4X9irNyiOesMhAanMe6aVCjIOYg+EsB24MqjjhUoQDOx5yy+BZf67MMLy3mWBPr89kFLoTj6/GhuRrsgBEnc7t58DHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296126; c=relaxed/simple;
	bh=ARFH4TEnTzr4lsz54biGO4elI4//XnrLvYOYre8ONDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZUSlk7tsEH+D8pKcTJPniXFHYjOjSJIkEgwMNpBtncDQ+ShaTmrV+80ope2B5S9hWKTja/0/45s+zesx0J7ribUvCJCtbq24DfDVSDWGLcgWZsX9YmSsCSGnBPlua1kWozZVab7oDxImICAHj+3z7rK3huI/zm0vohoVVLOGZxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bZlgUckK; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730296124; x=1761832124;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ARFH4TEnTzr4lsz54biGO4elI4//XnrLvYOYre8ONDI=;
  b=bZlgUckKsrwe4kx6WtDCEWrbOqzS99qfGTUSegMSUo50Zk0t9piqYTDN
   6qjBWzaIxICcL23H4NA6Nf/AFew6tMn8B8fmNJBx4l2jujSNvf2tdcqmp
   kXrUuENK/FIIxGXpKld6MQPw7bCZT8QmjmhVQT6mLQO7x49cwtrydyVWi
   WN91F8Gz9MQg7/yVhy2OxBuw/ADNIR2HOj/NOAPqzpI8Oeaf63eiKFjPz
   eU0/x2/4Dh/fMIk2WzM72sM0yncCoKBh28pSBj/uVGnVQIsCtXpm9tCrl
   VekkLhmlyJLgqI826UKT3qKrDfm+k/r7UG9m8kmRi5BmADQ3M7rHUvqWv
   A==;
X-CSE-ConnectionGUID: hMjRfrN7RFKhFnjuIaddbg==
X-CSE-MsgGUID: 6mn19nCjSAOWJGoM0Mfmnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30191875"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30191875"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 06:48:43 -0700
X-CSE-ConnectionGUID: 9MHn8nLBSoyphBM5QO7Nog==
X-CSE-MsgGUID: c1jJA/NuTuanG2toNRmX8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="86871085"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa005.fm.intel.com with ESMTP; 30 Oct 2024 06:48:41 -0700
Message-ID: <dbda76e5-23f1-47a9-af77-b539d07d9ba9@linux.intel.com>
Date: Wed, 30 Oct 2024 15:50:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] xhci: Correct handling of one-TRB isoc TD on Etron
 xHCI host
To: Kuangyi Chiang <ki.chiang65@gmail.com>, mathias.nyman@intel.com,
 gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241028025337.6372-1-ki.chiang65@gmail.com>
 <20241028025337.6372-6-ki.chiang65@gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20241028025337.6372-6-ki.chiang65@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.10.2024 4.53, Kuangyi Chiang wrote:
> Unplugging a USB3.0 webcam while streaming results in errors
> like this:
> 
> [ 132.646387] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 18 comp_code 13
> [ 132.646446] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002fdf8630 trb-start 000000002fdf8640 trb-end 000000002fdf8650 seg-start 000000002fdf8000 seg-end 000000002fdf8ff0
> [ 132.646560] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 18 comp_code 13
> [ 132.646568] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002fdf8660 trb-start 000000002fdf8670 trb-end 000000002fdf8670 seg-start 000000002fdf8000 seg-end 000000002fdf8ff0
> 
> If an error is detected while processing an one-TRB isoc TD,
> the Etron xHC generates two transfer events for the TRB that
> the error was detected on. The first event is "USB Transcation
> Error", and the second event is "Success".
> 
> The xHCI driver will handle the TD after the first event and
> remove it from its internal list, and then print an "Transfer
> event TRB DMA ptr not part of current TD" error message after
> the second event.
> 
> As a solution, we can set the flag after the first error event
> and don't print the error message after the second event if
> the flag is set.
> 
> Commit ad808333d820 ("Intel xhci: Ignore spurious successful
> event.") implements a similar mechanism that we can reuse to
> solve this problem since short transfer and transfer error
> doesn't occur concurrently. Also, rename the flag to make it
> more meaningful.
> 
> Check if the XHCI_ETRON_HOST quirk flag is set before invoking
> the workaround in process_isoc_td().
> 
> This patch doesn't affect other host controllers that have the
> XHCI_SPURIOUS_SUCCESS quirk flag applied.
> 
> Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>

I'm leaving this out of the series due to both ongoing discussion about
this patch, and because it conflicts with another series touching
handle_tx_event()

All other patches in series are added

Thanks
Mathias


