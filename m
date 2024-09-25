Return-Path: <linux-kernel+bounces-337889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B409850B6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F0EFB22CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA021487D1;
	Wed, 25 Sep 2024 01:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vy/YLieu"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3A51482E5
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 01:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727228942; cv=none; b=Bw4bkjDu654I3/cf2EiYhVmfk05mCsACuePcTtd02Rsrrgx8xxCiYEUBMWBdftIEVzyyg16v4rDoOFOnYqcyaYE2Bq2Ch2hx7Tl8m77oi5SxaMigKpmF7aeu0cuz6zzFGCOxeW32enZjsfCY3SnMTD4vYKJMNHJfQ4JBwEO0RRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727228942; c=relaxed/simple;
	bh=g3Up5ycJcBXiri8FE+jRpYgWBq7NRqptB30sSCdkX0E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Z7l1BYuToG9i0MVw/h31c9Hf8bC13XqOnYT2Vebn9bYpWDRB1aSGPqoUBx/7wZlXqBBqylr0DJ6acTQaerKUSVPXO6IfNgbfps2J/5ruVinpbladQCdcqRdmk0vP0WsnSvRCNvJ053TnFkePPp7iheAgJoew4oe2vasrfSyFqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vy/YLieu; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Subject: Re: [PATCH v2 8/8] block: Init for CBD(CXL Block Device) module
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727228937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R9a1mjfhW8sOmneVxsGeTyR7GmOE/nZ4p8AXfssa9uk=;
	b=Vy/YLieu6gh5aOX72A74Pk3t4c4bhJmwEWsFPmat6BuU729HhBsAsOC1N+HgHj+Ng5YBEB
	dd342ermEnCZTaS0Ylgukj21IwpejePVqd4Bzer7l6pcAvh+3A+4mrpEzYb/SwdmCL5rK8
	QtESlk4hsMZFZpE34jA27wYliDqO49Q=
To: Randy Dunlap <rdunlap@infradead.org>, axboe@kernel.dk,
 dan.j.williams@intel.com, gregory.price@memverge.com, John@groves.net,
 Jonathan.Cameron@Huawei.com, bbhushan2@marvell.com, chaitanyak@nvidia.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-bcache@vger.kernel.org
References: <20240918101821.681118-1-dongsheng.yang@linux.dev>
 <20240918101821.681118-9-dongsheng.yang@linux.dev>
 <27bf8cff-83b6-4a41-923a-7713a847f979@infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dongsheng Yang <dongsheng.yang@linux.dev>
Message-ID: <c8a09654-f27e-766a-58f2-d36dffe34322@linux.dev>
Date: Wed, 25 Sep 2024 09:48:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <27bf8cff-83b6-4a41-923a-7713a847f979@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Randy,

在 2024/9/25 星期三 上午 12:35, Randy Dunlap 写道:
> Hi.
> 
> On 9/18/24 3:18 AM, Dongsheng Yang wrote:
>> diff --git a/drivers/block/cbd/Kconfig b/drivers/block/cbd/Kconfig
>> new file mode 100644
>> index 000000000000..16ffcca058c5
>> --- /dev/null
>> +++ b/drivers/block/cbd/Kconfig
>> @@ -0,0 +1,45 @@
>> +config BLK_DEV_CBD
>> +	tristate "CXL Block Device (Experimental)"
>> +	depends on DEV_DAX && FS_DAX
>> +	help
>> +	  CBD allows you to register a persistent memory device as a CBD transport.
>> +	  You can use this persistent memory as a data cache to improve your block
>> +	  device performance. Additionally, if you enable CBD_MULTIHOST, cbd allows
> 
> s/cbd/CBD/ for consistency. Or does 'cbd' here explicitly refer to the loadable module
> name?

I will use uppercase "CBD" in the next version for consistency.
> 
>> +	  you to access block devices on a remote host as if they were local disks.
>> +
>> +	  Select 'y' to build this module directly into the kernel.
>> +	  Select 'm' to build this module as a loadable kernel module.
>    +	  The module will be called cbd.
> 
>> +
>> +	  If unsure say 'N'.
>> +
>> +config CBD_CRC
>> +	bool "Enable CBD checksum"
>> +	default N
> 
> We usually omit 'default N' since that is the default default.

I explicitly added "default" here to make it clearer. In fact, I did a 
search:

find . -name 'Kconfig' -exec grep 'default n' {} + | wc -l

There are over 400+ of "default n" in the Kconfig files. （I will use 
'default n' in next version）
> 
>> +	depends on BLK_DEV_CBD
>> +	help
>> +	  When CBD_CRC is enabled, all data sent by CBD will include
>> +	  a checksum. This includes a data checksum, a submit entry checksum,
>> +	  and a completion entry checksum. This ensures the integrity of the
>> +	  data transmitted through the CXL memory device.
>> +
>> +config CBD_DEBUG
>> +	bool "Enable CBD debug"
>> +	default N
> 
> Ditto.
> 
>> +	depends on BLK_DEV_CBD
>> +	help
>> +	  When CBD_DEBUG is enabled, cbd module will print more messages
>> +	  for debugging. But that will affact performance, so do not use it
> 
> 	                               affect
> 
>> +	  in production case.
>> +
>> +config CBD_MULTIHOST
>> +	bool "multi-hosts CXL Dlock Device"
> 
> 	                      Block
> 
>> +	default N
> 
> drop default line.
> 
>> +	depends on BLK_DEV_CBD
>> +	help
>> +	  When CBD_MULTIHOST is enabled, cbd allows the use of a shared memory device
> 
> cbd or CBD?
> 
>> +	  as a cbd transport. In this mode, the blkdev and backends on different
> 
> ditto.
> 
>> +	  hosts can be connected through the shared memory device, enabling cross-node
>> +	  disk access.
>> +
>> +	  IMPORTANT: This Require your shared memory device support Hardware-consistency
> 
> 	                  requires                          supports
> 
>> +	  as CXL 3.0 described.
> 
> 	  as described in CXL 3.0.

agreed.

Thank you for your review.

Dongsheng
> 

