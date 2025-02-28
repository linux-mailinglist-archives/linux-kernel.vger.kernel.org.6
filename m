Return-Path: <linux-kernel+bounces-538558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCB6A49A37
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E945E17110D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F392126B2D7;
	Fri, 28 Feb 2025 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P18NtLd4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7794261579
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748047; cv=none; b=Cm8hihkT03ix6HaZ3/THjXTaSqp29yC08T01KBef8EgVKfTV5skR+Q2M4GnffhiK0SBJtJeSaApGd5q8Q1lEbYLdeanRIgO3WKu5eH8YISXtBgAhFy0s68sCRr1V1Podv9aa41rZbYWhXr4nm/1vU/e96PFH1X67voqZ+nAz6KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748047; c=relaxed/simple;
	bh=PgLYznw/vhooXKEiRwXMWE6fwDbTxl645oj0tNLj+nU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmMPxQxZlG6/AjyJ8oH5o3+pbWASQ3e82yUUgKl+v4hxQQAp5M5yMetsRpE6LP9J4cIc+J2sMXbjSMMjJzi7y+Eb+bbCekjEOIg3g1DJtnDoc1I1u0duaX2KePGsJfitQdJ7qwVGQw524cqiB3Kuu5terYzDkTOl/x1nDLiNHdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P18NtLd4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740748044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MOu35KTrzd/Q3JC03OViedyLFeYsWkOLSJ/UlGCVsgk=;
	b=P18NtLd4H34qsQ969NuBmG+uPbL2SAiE6xetRXwsoSluTt5exI2zfwPRdab0lZkJ5SDw2/
	WgOeu6epS1i5R9wwQLQVzrLbEjbGxz0jOwZJbfGgMEdSmKaCb7YZiHRzwkewXg6NBXKo2c
	AzIhPPZh1jhBM2bhiOM4T/8+BMlFJnw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-fBzFcLRHOfO0vXUG3bHy9g-1; Fri,
 28 Feb 2025 08:07:20 -0500
X-MC-Unique: fBzFcLRHOfO0vXUG3bHy9g-1
X-Mimecast-MFC-AGG-ID: fBzFcLRHOfO0vXUG3bHy9g_1740748039
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EBF91944CFC;
	Fri, 28 Feb 2025 13:07:18 +0000 (UTC)
Received: from [10.22.88.31] (unknown [10.22.88.31])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A634D19560AB;
	Fri, 28 Feb 2025 13:07:16 +0000 (UTC)
Message-ID: <efedb363-c25f-4e4f-8a4a-3d991bdf3927@redhat.com>
Date: Fri, 28 Feb 2025 08:07:15 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvme-multipath: add the NVME_MULTIPATH_PARAM config
 option
To: Nilay Shroff <nilay@linux.ibm.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Cc: loberman@redhat.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, emilne@redhat.com, bgurney@redhat.com
References: <20250228032541.369804-1-jmeneghi@redhat.com>
 <20250228032541.369804-3-jmeneghi@redhat.com>
 <bc07b3df-4634-44fc-a16c-f4c3bb30e456@linux.ibm.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <bc07b3df-4634-44fc-a16c-f4c3bb30e456@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


On 2/28/25 1:28 AM, Nilay Shroff wrote: 
> On 2/28/25 8:55 AM, John Meneghini wrote:
>> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
>> index 91b0346ce65a..c4251504f201 100644
>> --- a/drivers/nvme/host/Kconfig
>> +++ b/drivers/nvme/host/Kconfig
>> @@ -28,6 +28,21 @@ config NVME_MULTIPATH
>>   
>>   	  If unsure, say Y.
>>   
>> +config NVME_MULTIPATH_PARAM
>> +	bool "NVMe multipath param"
>> +	depends on NVME_CORE && NVME_MULTIPATH
>> +	help
>> +	  This option enables configurable support for multipath access with
>> +	  NVMe subsystems. If this option is enabled NVMe multipath support is
>> +	  configured by the nvme core module parameter named "multipath". If
>> +	  this option is disabled the nvme core module "multipath" parameter
>> +	  is removed and support for NVMe multipath access can not be
>> +	  configured. When this option is disabled a single /dev/nvmeXnY
>> +	  device entry will be seen for each NVMe namespace, even if the
>> +	  namespace is accessible through multiple controllers.
>> +
>> +	  If unsure, say Y.
>> +
> If we want to make NVME_MULTIPATH_PARAM default on then I think we need to add
> "default y" under config NVME_MULTIPATH_PARAM.

OK. I've tested all of the config options.

make mod2noconfig
make allyesconfig
make allmodconfig
make oldconfig

And is all seems to be working correctly, but I'll add the "default y"
as you've suggested.

>>   config NVME_VERBOSE_ERRORS
>>   	bool "NVMe verbose error reporting"
>>   	depends on NVME_CORE
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 2a7635565083..4536ad5fbb82 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -10,10 +10,11 @@
>>   #include "nvme.h"
>>   
>>   bool multipath = true;
>> +#ifdef NVME_MULTIPATH_PARAM
> 
> Shouldn't it be CONFIG_NVME_MULTIPATH_PARAM instead of NVME_MULTIPATH_PARAM?

Oops.  As you can tell, I haven't tested this yet.  I'll fix this up and test these
changes before sending a version 2 patch.

/John
  
> Thanks,
> --Nilay
> 


