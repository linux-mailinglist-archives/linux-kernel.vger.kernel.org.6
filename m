Return-Path: <linux-kernel+bounces-556433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 982E1A5C882
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0586A164527
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFB625F964;
	Tue, 11 Mar 2025 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+APva9G"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F0A25EFA9;
	Tue, 11 Mar 2025 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707644; cv=none; b=hd9iIBltph1oL2uB9NCRvyC+Lnd7y1Yihxaami95TzvcJWZzcaslbWWQKj6DycMsuBRdHrdjzPXeSLF8xLSTsyHW7WrNlSZuzJi3Ml0C0eNH7jVKql5oyJmCL5+JNtqEJlc9vyWgV/FnmOORyMWTlbh7jKj5/NX2D5JeACMz/R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707644; c=relaxed/simple;
	bh=WcKRe4L0l1+bomdpAASB5V5cOcgURqGiz54kAs3oai0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIRI8jaVvclkLtpDC7kyjxAXrdC8pG5vvrV6v5UK9P9Y/+zjVPxzNLZatJ5DS3LIBoRTXGXf649OinB/ZYK5FWS5vEvnhN82M9V/rDbuxsIw0Go2GOxkgU9/pDnx165GHO4bwIboVu4y6DjG/arHH/P6VTkoPQBQlSyWDkED3l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+APva9G; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741707643; x=1773243643;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WcKRe4L0l1+bomdpAASB5V5cOcgURqGiz54kAs3oai0=;
  b=g+APva9G9/2xZz8bTtBUhS3YchCEFKFQdOXVaYKct/0dpfEjnvITsxw5
   40/jZj8hiEJpjjKwF+aOF3cIrhleo7DdbMZRwsQ9mzP9yVGVdJN1NJWJF
   jTO2DNH5wQ9XB4Lk7eLivPgfCCkTGOaGY5FTwdde3OfwnDUA+FEd+uSdF
   xlyq6CvO9mLfuwobrDoyqcfmSFHHyJ53tzvusf+JOYXG+H/aKXhKRFvWM
   RDxE+0nTJyVe5FCMMFLEre1VXekQBliO5QS1wIF4bm0Y8zp9rUo8X7gHy
   rTlr/gmgcC2yXXMhHaY+c6vPWdzeCEmIPoGdkFPUPpVWpO7jBp++E3hI9
   A==;
X-CSE-ConnectionGUID: a4vcnmb3QLeSVJVmjetFlQ==
X-CSE-MsgGUID: XMRXdvtIR++oTKSLnaYafA==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="45535761"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="45535761"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:40:42 -0700
X-CSE-ConnectionGUID: L1QGywQIT0+ZNJMhrMXa4g==
X-CSE-MsgGUID: +XzLw+EvQnia3bXQIVj/8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="120188371"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa006.fm.intel.com with ESMTP; 11 Mar 2025 08:40:42 -0700
Message-ID: <bff2ac48-3e97-4bc7-8c92-2aa676a0dc15@linux.intel.com>
Date: Tue, 11 Mar 2025 17:41:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] xHCI: endpoint state maintainability and small fixes
To: Michal Pecio <michal.pecio@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250310093605.2b3d0425@foxbook>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250310093605.2b3d0425@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.3.2025 10.36, Michal Pecio wrote:
> These patches are mostly independent, except
> - 2/6 depends on 1/6
> - 6/6 depends on 4/5 and 5/6
> 
> It is assumed that issues with EP_STALLED are resolved like below.
> 
> They document assumptions currently made by xhci_urb_dequeue() and
> xhci_handle_cmd_stop_ep() and clean up this code a little to make it
> more maintainable.
> 
> Some potential issues with no known significant impact are fixed.
> I haven't tagged them for stable. Maybe 5/6 could go, just in case?
> 
> Michal

I'll send a small fixup series to Greg for usb-next (6.15).

We are getting late in the cycle so I'll try to keep is as short as
possible. I'll cherry-pick 4/6 and 5/6 from this series to it.
  
Thanks
Mathias

