Return-Path: <linux-kernel+bounces-280934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A1994D11E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849E3282DFC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C273195803;
	Fri,  9 Aug 2024 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HWYU0oC4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE76194AD5
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209710; cv=none; b=aEfkC+eivXXfgLEc79yzZGZWWtJs/Ld8bAxQeOOqKYXk0cuFoWMYIoRHYMkcGJ86MZfC9mxDgHGsX8+mV+asNHzBxOIesOwZbBket2uwWC2md1WrAOIVAH7RMC3Jl3cN6xUzL9zvt92Dmyz0L82IcMoqMMN0dxX1U3yv9exEkPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209710; c=relaxed/simple;
	bh=TvNTOB1HAdlyewJxARdqizVcew5pentezXVbEbwtJjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=puK1MUz//km62mBUgCbBqzLVMMCi3gle2i93fSkKF/2qxHBuEAwYD40/mDONyY0EoQ3sJnRQKVmORMKAc5JJunLFL0CM8ZRq4ymnEbsscEpXXbWPARmK1w65TKAJHiRSOMteyoPBJ1Z4VgTgq67iwESrwjsncnLFA7XRzktys6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HWYU0oC4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723209709; x=1754745709;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TvNTOB1HAdlyewJxARdqizVcew5pentezXVbEbwtJjA=;
  b=HWYU0oC4BzXm3/W5kA567XjpUDwGRvKgB2MByd6bGzEVkWa+nToGdbTj
   3XATy+wiUk8F2puNSlHtxIbn4peUiC7T5klB+1UnBh+NoNrzFvCUjcV0W
   Op5z2R7yoptd8HYwVB8AWJ6GRVjAjwslnfwcmfKrNb+mFD4ZCEyenwekv
   aCA6WJOunY/Kn5NMTUprAmqeWcDahJ9+kPlcsD8vujZBMlAtNi8bVcIgA
   m/mwRjeMIDPSd8AmYGhZYpDun4gNIeExtHwGtwX0rhZORHQVy/OQMN4m+
   s7pw7psMu/iyKH5beR7AMct8namnRkz4WVzOD1zPNSpUwZ8Zb5OnYb/7S
   Q==;
X-CSE-ConnectionGUID: qMZhB4PhQKalKolrUDqTgg==
X-CSE-MsgGUID: 0KvgVos4RfCh4XTx4PIoDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21534261"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21534261"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 06:21:49 -0700
X-CSE-ConnectionGUID: nPGcVCpUS2G2mwpirOyZYw==
X-CSE-MsgGUID: IoZ+H990TyendS6CA/mgpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="80799582"
Received: from unknown (HELO [10.237.72.57]) ([10.237.72.57])
  by fmviesa002.fm.intel.com with ESMTP; 09 Aug 2024 06:21:47 -0700
Message-ID: <9e8b9a98-a61f-4a75-8869-fdc674cce7c1@linux.intel.com>
Date: Fri, 9 Aug 2024 16:21:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 4/6] i3c: mipi-i3c-hci: Relocate helper macros
 to HCI header file
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
 <20240807052359.290046-5-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20240807052359.290046-5-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/24 8:23 AM, Shyam Sundar S K wrote:
> The reg_* helper macros are currently limited to core.c. Moving them to
> hci.h will allow their functionality to be utilized in other files outside
> of core.c.
> 
> Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
> Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>   drivers/i3c/master/mipi-i3c-hci/core.c | 6 ------
>   drivers/i3c/master/mipi-i3c-hci/hci.h  | 5 +++++
>   2 files changed, 5 insertions(+), 6 deletions(-)
> 
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

