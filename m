Return-Path: <linux-kernel+bounces-291932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF7C95690D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134FC1F227B4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B82165F0F;
	Mon, 19 Aug 2024 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PpfWOrPc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89962209F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724065855; cv=none; b=tsDAJ9chwkSczduOQshpCuZlFRgVAtv1zNPDUeOM4WCGqa8jodghg4EwONvj2sPxKGvPCcqNhHaem7qJqKsnxNclC3SpjT6yzIk7R5NeQHCQAeKQlMXNg2nXj/Y5ULHwoRo9ZH2hgxeGnGcRnAlbSRLVLcMdH62pDN/1HQ7MtjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724065855; c=relaxed/simple;
	bh=TKh/BM6H/e0b9MGjiqzrz0dvtYVC7q2xHrq4K3gMw0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxypg21xkNAGVlD3F8HNDLAuucC7+xa4wWq33tcfVwjPRQfkMeOf7eq9NUULoBeQtlwnp0PhlpQ//aMcUU2UV329xsrBN0gVSXoS2PQbZma9n+anMTNmDrMZdtAh8X9leOGuHTO3jZ0+he++KCc2G/2KQDq6SUyCbTdbrq7PLjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PpfWOrPc; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724065854; x=1755601854;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TKh/BM6H/e0b9MGjiqzrz0dvtYVC7q2xHrq4K3gMw0w=;
  b=PpfWOrPc35LthgO78pa7uwy+8WfbolihNCuUpdmy76Rp7OTgnSgEkc1v
   FQs3Oaj0VU1IFcJ4IhvF90PaJaUfbsqT7gPlwuT378SqQ8id0kffek+PD
   ToD53FJJbAzyNHQBf/qmXl0IFYPKT8gqCSiOiMrd4ATHI5RzB8NGyE/Vl
   eSmFcYvf3bUX+1sEa06LYQsh0zV1QfW6q3ZlAFdYMXYv8qiHOjABSSCCG
   XEe6/cP5yXg+wDP3tC/QApS08eYKnChSEewhK9wv+y76IWE2g+xNRIIo7
   9jPyeadby2fh5+VxgxrOtNRx81xRJ7QWkRR5s8ItBSx7dYcDzxRRzt2Rb
   w==;
X-CSE-ConnectionGUID: X41TiOi7Q0eNJbFTtBg9ng==
X-CSE-MsgGUID: 0rFvueDuSoOwGqyjlie5cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22448276"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22448276"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 04:10:52 -0700
X-CSE-ConnectionGUID: jb32P2gUQ4CGolkfk7ooSg==
X-CSE-MsgGUID: 48UhZ1vDSCyKyKtD9QNURA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60490256"
Received: from mylly.fi.intel.com (HELO [10.237.72.151]) ([10.237.72.151])
  by fmviesa010.fm.intel.com with ESMTP; 19 Aug 2024 04:10:51 -0700
Message-ID: <9fbbefde-443d-458b-b2a7-b8e0c90af1bd@linux.intel.com>
Date: Mon, 19 Aug 2024 14:10:50 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 3/6] i3c: mipi-i3c-hci: Add a quirk to set PIO
 mode
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
 <20240807052359.290046-4-Shyam-sundar.S-k@amd.com>
 <2a9f6c23-9c7b-496b-9998-ea0afe526b46@linux.intel.com>
 <94e789ab-2e64-4a6e-804f-b5e7b2a952cb@amd.com>
 <0ae18e57-ef79-4fd8-9e9a-4c57b480b267@linux.intel.com>
 <d0ca0a49-311e-4af3-95df-f7c6f85e184f@amd.com>
 <9b8f3c29-3404-4db4-80cf-8fd1b5d018c8@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <9b8f3c29-3404-4db4-80cf-8fd1b5d018c8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/24 9:41 AM, Shyam Sundar S K wrote:
>> I can add an additional check with the CPU ID and distinguish them(so
>> the quirk gets applied to the affected HW versions) and just not
>> restrict to X86_VENDOR_AMD, would that be fine with you?
>>
>> OTOH, Since these are quirks (where its a broken hardware problems)
>> and the idea you suggested is related to driver data (where driver
>> data is meant to store private information about the device)
>>
>> static const struct acpi_device_id i3c_hci_acpi_match[] = {
>>       {"AMDI1234", HCI_QUIRK_PIO_MODE | HCI_QUIRK_OD_PP_TIMING |
>> HCI_QUIRK_RESP_BUF_THLD},
>>       {}
>> };
>>
>> does that not conflict? quirk vs driver data?
>>
>> I am OK to implement it the way you prefer :-)
> 
> Jarkko, any feedback on this?
> 
Sorry, forgot to reply... What do you mean about conflict? So if driver 
data would pass quirk bits as above and set only to unique ACPI ID 
specific to that HW then there is no reason to check CPU ID later in the 
code.

