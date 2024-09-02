Return-Path: <linux-kernel+bounces-310623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5BB967F36
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137DA1C217BF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1353A14F12D;
	Mon,  2 Sep 2024 06:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Udngf4I1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E43382
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 06:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257738; cv=none; b=LLiAxGgenUKBLKcro6RNp+Psbs/ULb7JsrAvav5qk7aAnOvsRQchxn28Js8CkU/PxYuuCw72+zJrWCTmTttmelibpA9gZkNRyprKOyi59pQ/fth/DF5zSXWkoYiNWuvfTAvwifPeYJBhACod4M9B38Ibj6papcpuuvGc6mxpF2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257738; c=relaxed/simple;
	bh=oQeEtOb2bMnH/NIz8TrJl1Iq8ZuigwPcNPy/sTgYkxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQ8XBkVjbC8ysfaIitKZ3lGlL5GrPvTi0DtZ4DKvTKCB9aTGDHWqyI5yEFkLWM93zVVME4yyckziHSZu3BctSoK7X9wlOu2FDerLUJyxvv8nGCqT998739WNAZuPSH9K9KDPqTB86vQ6lbLugXhfs2xRx7CQ08npSOHW51mkskA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Udngf4I1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725257737; x=1756793737;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oQeEtOb2bMnH/NIz8TrJl1Iq8ZuigwPcNPy/sTgYkxk=;
  b=Udngf4I1kFRV0wFTJDIYcHaO299RXd2H5+VAt+ZUfLRXFWz9Rqj2ZsKj
   8eA8r91UrtEUtpH/GrK1BD8zBSpb43yFe+mHfjiry6p9uEt0y2486JcYr
   drCVKgXmdhXlInhirw+Mc7wfzVQRfo2SA19laNcBLQJq7sLnHMnnXeHg7
   v37xZmE43muGk0b0wjLsAvkroVYuPRL/2NQICfu964mC3Fyf0eO0I6tDi
   TXzGj3gYKubQYSx9Dhy7qltgTYtqM4c2h3bct40v2+2loWQ+OUvzAzlSV
   Zq2Jz4fbGVDRb8GaFY5EEZSI6TdtFivJHS8ZdIGuMH7U03LaQX45L+udH
   Q==;
X-CSE-ConnectionGUID: Z1zV/+5YTJeRXt6vuK39+g==
X-CSE-MsgGUID: WtMl+chgTYijMvphgsDyxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="35189758"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="35189758"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 23:15:36 -0700
X-CSE-ConnectionGUID: Cx2XLCMKT8W4OJJK43fvqA==
X-CSE-MsgGUID: 8dI3IJJARGic2o30bY8kCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64196909"
Received: from mylly.fi.intel.com (HELO [10.237.72.58]) ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP; 01 Sep 2024 23:15:34 -0700
Message-ID: <17e2bf2a-0c9d-4668-8f01-23651ce1970f@linux.intel.com>
Date: Mon, 2 Sep 2024 09:15:33 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] i3c: mipi-i3c-hci: Read HC_CONTROL_PIO_MODE only
 after i3c hci v1.1
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240829091713.736217-1-Shyam-sundar.S-k@amd.com>
 <20240829091713.736217-3-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20240829091713.736217-3-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 12:17 PM, Shyam Sundar S K wrote:
> The HC_CONTROL_PIO_MODE bit was introduced in the HC_CONTROL register
> starting from version 1.1. Therefore, checking the HC_CONTROL_PIO_MODE bit
> on hardware that adheres to older specification revisions (i.e., versions
> earlier than 1.1) is incorrect. To address this, add an additional check
> to read the HCI version before attempting to read the HC_CONTROL_PIO_MODE
> status.
> 
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>   drivers/i3c/master/mipi-i3c-hci/core.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

