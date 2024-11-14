Return-Path: <linux-kernel+bounces-409513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1314A9C8DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA49286417
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BA4770FE;
	Thu, 14 Nov 2024 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aj9/uTDQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCB413AD39
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731597767; cv=none; b=YrqHeGAYg9eYCC+8ITnYGdXdgjft4iDHsM/1zmoyhThc5EN95W66QHxLrnEGj/xO47Rn/zAN6ygYQcPKMsZYJqkwfyRY0hKyqCcaZVZIDASUS66iYB8iTZGlR2i74hk/6hlrzwlLGLCwz+zGzWR59YUmUNqYeoM668iAK0v0pd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731597767; c=relaxed/simple;
	bh=1eouGy5RKoAbzPTJ1zNM2q2ty+aHjR6VzTEMr9jWGZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HGZ8VIRyaFsCQapGvzASyIpH21HgpgcLlzhDqfqQ0oVr+obONMWuP+97UlPNDIPLPG+H1W1Tt916E4XZAsoHdaDnCWtijpN46s9h3Lw0rmGLqaZpxC772iEEcWUbI5iJIoahxo//5N+/u+UTPeiF+PXoHaoGOSzsEDmQKl48tkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aj9/uTDQ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731597766; x=1763133766;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=1eouGy5RKoAbzPTJ1zNM2q2ty+aHjR6VzTEMr9jWGZA=;
  b=Aj9/uTDQSQVFyJdd7mzXSdsjx2nVHFEjK4xe3gj8jJkbNNsKsBX50R/+
   b9vMFccP9HuxAD/T/RmefsC/ngfNljB1IBYvIecxeY+n3+ihJh9j1BTwb
   sp0NPRPp7e4aFLoRBe8pFder9xiiHb1SYcfuKd92EuA1TTMOR7v6Q2OUR
   ILhoKsuK8c46Wn+FwXuc+qT8b42VCmpjl96ttREnwGszghD4ASlnqzTf1
   B08ySBX27mC2+F7pjwBfdznlROhDSc7cU4GB+tNFeIvcJdiqBibs+oodB
   YdZSrlqJA4r9dEKA1Ovg/knP2Qt3z5S+ZiTrkInja8q9L8hWkgjLja4n6
   w==;
X-CSE-ConnectionGUID: LimCJNVyTriT4Wd6EWjPUg==
X-CSE-MsgGUID: vranqDuMSAOlZtEWdZfnVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31332870"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31332870"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 07:22:44 -0800
X-CSE-ConnectionGUID: 0MPyeRKHTWuxZ8G52Ft6jw==
X-CSE-MsgGUID: x9Zo2Z8mTJWEwNEs9ZalzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="87786355"
Received: from mylly.fi.intel.com (HELO [10.237.72.151]) ([10.237.72.151])
  by fmviesa006.fm.intel.com with ESMTP; 14 Nov 2024 07:22:41 -0800
Message-ID: <ad5375b6-5a1b-4c04-a4d9-c99fb0afaeb8@linux.intel.com>
Date: Thu, 14 Nov 2024 17:22:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] i3c: mipi-i3c-hci: Support SETDASA CCC
To: Billy Tsai <billy_tsai@aspeedtech.com>, alexandre.belloni@bootlin.com,
 Shyam-sundar.S-k@amd.com, Guruvendra.Punugupati@amd.com,
 krishnamoorthi.m@amd.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241113035826.923918-1-billy_tsai@aspeedtech.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20241113035826.923918-1-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/24 5:58 AM, Billy Tsai wrote:
> When the I3C subsystem wants to assign a dynamic address using the SETDASA
> CCC, it needs to attach the I3C device with device info that includes only
> the static address. In the HCI, if the driver want to send this SETDASA
> CCC, a DAT entry is required to temporarily fill the device's static
> address into the dynamic address field. Afterward, the reattach API will
> be executed to update the DAT with the correct dynamic addrees value.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>   drivers/i3c/master/mipi-i3c-hci/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
(Minor comment to the subject. Is this rather fix than support SETDASA?)

Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

