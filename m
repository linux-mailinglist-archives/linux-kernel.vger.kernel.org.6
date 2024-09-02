Return-Path: <linux-kernel+bounces-310625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6053F967F3B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DAFE28249C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523F315688E;
	Mon,  2 Sep 2024 06:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XAxuFiaj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814721547C6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 06:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257840; cv=none; b=L28+Khz0HbTDyitEu9K0YdWqJ7CjlfdwcE+WlQUUy/hj7/CeLgPuOOq8nQiD7Xn563PCrp/dlsgDWF49EaehGWvUYKpnvE0LE9nltU/y9H6YNPcdztg5lI1ch7XUNbP5RHBa9Zr+iqSSiGasn7fe5xpFY0A4VB65m5pGva8DVRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257840; c=relaxed/simple;
	bh=NhnQQVmqO2sXYSwuZSo9bUAfvG2luwZXQ0/0pV7TRJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KL6N73ER6k06VVlmncs99m+XtkZn4ImgDYu3ev1P7JWZIH0aIfz9KDSwb+hCDDaZYLzPoI4Y+/+wcMsQehu/01/KcW9ClE5ctlbjdO5CPWW6iMH12i3udFpSXBpt3ueNfm/mVX4lZS/ZSmojM+wKPY47cu+iKXiGFRFoKI88OFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XAxuFiaj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725257839; x=1756793839;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NhnQQVmqO2sXYSwuZSo9bUAfvG2luwZXQ0/0pV7TRJQ=;
  b=XAxuFiaj/Dml1Gmfb1Ye2MI2w1kf76nVZra5pNTrweeoQW1aX5PAIeTV
   h9qEJcycs8adsDpaW/JIgvefSQetT5rI6nilYZghy95qZKYGUSOQLcQoW
   wNzUKY3QiB4K3FaygqlbBKiKlHPVwLD3KZWPdlmXH+vNTPvFsGV6CAH5l
   3nXeHKfJ5O9fHaCOigwu0zodmK9xKtUuK+Iw6jPaMCK+tUEs27aTQgGxt
   ePqc1lPKS+cbakLtmPseP7xIhh9JHdSzy0UByZZzrhTPOsLodGw39vzfR
   Y5VfF1VF4nVqBC+Ed66PGhVT3DcDIdQOkqcvvY9XwLT/02o60XiMIhvta
   g==;
X-CSE-ConnectionGUID: WjvNp1epQFynbk7UyLLIWQ==
X-CSE-MsgGUID: MgyyFE9DQV6QoFPonHz6bQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="35189865"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="35189865"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 23:17:18 -0700
X-CSE-ConnectionGUID: hAHGdfuhQumbegvrmC+Bpw==
X-CSE-MsgGUID: iSDzmkMtT1qMqGCYN1bU0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64197559"
Received: from mylly.fi.intel.com (HELO [10.237.72.58]) ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP; 01 Sep 2024 23:17:16 -0700
Message-ID: <f7476172-32b8-4eea-b1d9-bae9de8f2ffa@linux.intel.com>
Date: Mon, 2 Sep 2024 09:17:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] i3c: mipi-i3c-hci: Add AMDI5017 ACPI ID to the I3C
 Support List
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20240829091713.736217-1-Shyam-sundar.S-k@amd.com>
 <20240829091713.736217-2-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20240829091713.736217-2-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 12:17 PM, Shyam Sundar S K wrote:
> The current driver code lacks the necessary plumbing for ACPI IDs,
> preventing the mipi-i3c-hci driver from being loaded on x86
> platforms that advertise I3C ACPI support.
> 
> Add the AMDI5017 ACPI ID to the list of supported IDs.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>   drivers/i3c/master/mipi-i3c-hci/core.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

