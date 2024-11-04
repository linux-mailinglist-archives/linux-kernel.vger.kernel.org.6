Return-Path: <linux-kernel+bounces-394945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9159BB654
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854601F218E0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC22822611;
	Mon,  4 Nov 2024 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/urCzAC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE314A91
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727472; cv=none; b=adKzF2KRQDFufBLmy1DXVKFAY0vf0mcR6T0FA8q1blGFZrVA/ZTmQMo4rsz+HMEuIsEnv3MBSLSbf6V879zJC+9sutlqYSaOzs4SeyLHKbsfVLEUExmrfagkRZPQFD8O1cZPN48UyU3zMp+74J5UoNC/b7XmOStcXw6sEXku3a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727472; c=relaxed/simple;
	bh=IhAcYfdZFdlYF9jACuVXbAJ16EkEdDKfa6QrRiZ0ouo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UqAOFnBzmwsGADWsQiD0h0AC8ZQ7cZue9qQ30rmT4IGrw37Hot5G1bRJam4tQ9xsGHPC5CpRTTrNpfVE00BvnC0uShK7eBhW5W27bIgGJktHPyyvwhaleoyl3kV2ICKVO4VAjmFYJ/E5aKQxw4f1bwTKaCqsnqGgzpOq9UtGAPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/urCzAC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730727471; x=1762263471;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IhAcYfdZFdlYF9jACuVXbAJ16EkEdDKfa6QrRiZ0ouo=;
  b=i/urCzACrDbV4WFC4RNcQhqTdqJZyH4Dw6+DAZvBmbA9iguCQUPzpC7t
   ZFytXUv5cfMUqrZRV7JAbhdRJFNXEUM5zGZ9a9b8O7y3Ha5p36i7nNMjv
   E+FNlnbohPjBmFCE42c++YW9mTcvsWTW2GNYOlp4d9lFpDnfVxUIGAB2o
   90JlsYoa0e1KPKB/YYRkwBtGqAVWszmEErXX21qAQ3xG3wCFx7pzRgt8i
   fkVzaxPPs5GbdoniqhFBKRbMrY7T+OK0T8xTAya/GgWolYOcc4vpHjfb8
   +/OhjPKF6E0xlrBzmTdTd2X4nZgz/O0xCrz4Ag+s+lImNx+Clvf3+ggbO
   g==;
X-CSE-ConnectionGUID: OcquTt2BRkWFBRESt+Kr8w==
X-CSE-MsgGUID: xgYLY/pZSm6PojAHDOjScw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30588261"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30588261"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 05:37:50 -0800
X-CSE-ConnectionGUID: DEQQ5RNSQJG24NzVtUnskg==
X-CSE-MsgGUID: ZRrY1X7NRkq7Mlk18YrqgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="88480485"
Received: from mylly.fi.intel.com (HELO [10.237.72.58]) ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP; 04 Nov 2024 05:37:48 -0800
Message-ID: <286e13ea-360c-4082-823a-e4442528266e@linux.intel.com>
Date: Mon, 4 Nov 2024 15:37:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Introduce initial support for the AMD I3C
 (non-HCI) to DW driver
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Sanket.Goswami@amd.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241023055118.1400286-1-Shyam-sundar.S-k@amd.com>
 <990cdc00-92e2-41fb-bbcb-26f413b97494@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <990cdc00-92e2-41fb-bbcb-26f413b97494@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/24 5:15 PM, Shyam Sundar S K wrote:
> Hi Jarkko,
> 
> On 10/23/2024 11:21, Shyam Sundar S K wrote:
>> The AMD EPYC platform design has DIMMs connected over the I3C bus, with
>> each DIMM containing three components: SPD, PMIC, and RCD.
>>
>> To access component-specific information within the DIMMs, such as initial
>> dynamic address, static address, and provisional ID, ACPI support is
>> necessary for the I3C core. This requires adding ACPI binding to the
>> dw-i3c-master driver and retrieving slave information from the AMD ASL.
>>
>> Currently, the code is closely tied to dt-bindings. This initial set aims
>> to decouple some of these bindings by adding the AMD-specific _HID,
>> enabling the current driver to support ACPI-enabled x86 systems.
>>
>> In this series, support for following features has been added.
>> - X86/ACPI support to i3c core
>> - Support for SETAASA CCC command
>> - Add routines to plugin a SPD device to the i3c bus
>> - Workaround for AMD hardware
>> - Add dw-i3c-master driver with ACPI bindings
>>
>>
> 
> Any feedback on this series, please?
> 
Sorry, I thought I was accidentally CC'ed to the series :-)

Since I went now reading the series I'll some comments.

