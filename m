Return-Path: <linux-kernel+bounces-531694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CF4A443BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8A53BF863
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD8621ABD9;
	Tue, 25 Feb 2025 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TECqFc7h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201C421ABC8;
	Tue, 25 Feb 2025 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495292; cv=none; b=qCjMOUzqvOduCHwmxtV/sJiWHVaxePmNidmSAZwuYR9G99dQ+oSNN3A8OUSS/HDGjO9sFeNvAqHQIPURTuNyzA+4lqksC1JgIRF8YwpVHzbcX/BAxNlVEvdpfKyUj5DFoVQUmRi7Gk6WpTgoQ0f8XrlQstYC9OVb83kdO55cIm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495292; c=relaxed/simple;
	bh=i56r8FelMwZUrbrkv/IGFWT2rnJfRb9fgSFnQoHsSyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHEJxCsJ6nlTBPvKY5LEEc+XhAf9I7iflRSlk5j09+2M/nRPZbEExOzuHgB6ttcVdvKwLSIENkqhzIpFJ1Le4i1pkgSx02VdQ9XNseWGkARWnhwwK7RQC+xs44jmTIn1qTT9gJlhuBoM/lbVg1yTcxhYGb8diXsqsahEcyd73Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TECqFc7h; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740495291; x=1772031291;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i56r8FelMwZUrbrkv/IGFWT2rnJfRb9fgSFnQoHsSyo=;
  b=TECqFc7hvtjM2YP/0aCOmZMF4s53cLa308ynUlbZ6X4T0rRupO8DIP2m
   +PdTGKXQr7eoMAaE12lHL3jIXxo6wckFpE7O9xjwT76A8/ECThr72huQL
   4H5hdhza4+QisuC6vfIlFeyyJucwaGUcDtGZc1KfpD7fa+lwU8aU7/2DU
   Sqqz4WrUTlYf/TLwzF+RmmjcfwVWeTGBkX31oIvlA7P5D2LjaF38bDAuS
   0HAZPInoCbCFDgel9MF0FEmRbTrSxy5Gqze0gf6GWY5JWXoS04GzKdISK
   F4CVkIUm2QFExliY+7Lgw6fXDhMj7RxEQobtPqLZ2b0WTomp/TSkvfwPb
   Q==;
X-CSE-ConnectionGUID: gIfOjBXIRV6axAsvw54ktA==
X-CSE-MsgGUID: It4XKAGaTHyjRiHbUlVZ6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41556962"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="41556962"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 06:54:50 -0800
X-CSE-ConnectionGUID: +vupiwwHRNSqxTeqvBDbKw==
X-CSE-MsgGUID: nk9z2/cxSYK5e0A4gepgSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116219279"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa006.fm.intel.com with ESMTP; 25 Feb 2025 06:54:49 -0800
Message-ID: <b82f9543-2730-48af-81e8-1612b0d30ed9@linux.intel.com>
Date: Tue, 25 Feb 2025 16:55:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] usb: xhci: Simplify moving HW Dequeue Pointer past
 cancelled TDs
To: Michal Pecio <michal.pecio@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250225125750.1b345e2c@foxbook>
 <20250225125939.7a248e38@foxbook>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250225125939.7a248e38@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.2.2025 13.59, Michal Pecio wrote:
> xhci_move_dequeue_past_td() uses a relatively complex and inefficient
> procedure to find new dequeue position after the cancelled TD.
> 
> Replace it with a simpler function which moves dequeue immediately to
> the first pending TD, or to enqueue if the ring is empty.
> 
> The outcome should be basically equivalent, because we only clear xHC
> cache if it stopped or halted on some cancelled TD and moving past the
> TD effectively means moving to the first remaining TD, if any.

This new way relies on td_list being in sync and up to date.
i.e. hardware dequeue can't be ahead of first TD in list.

One bad scenario could be something like:

class driver queues TD1
class driver queues TD2
Class driver cancels TD2, queue stop endpoint command
(Class driver cancels TD1) (optional)

xHC hardware just completed TD1 and stop endpoint command at the same time,
xHC hw may have advanced the hw dequeue to TD2, write event for stop endpoint command, and
then write transfer event for TD1 completion. (xHC hardware may do things in odd order)

Now we detect that hw dequeue is in the cancelled TD2 but with TD1 is till in the td_list.
This new solution would move dequeue back to TD1 beginning, and process it again.

Thanks
Mathias


