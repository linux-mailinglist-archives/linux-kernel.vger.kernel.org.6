Return-Path: <linux-kernel+bounces-538569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A265DA49A52
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89AD03AA038
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ED226B976;
	Fri, 28 Feb 2025 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdLG6bm/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3DD26B944
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748508; cv=none; b=GL7SpP4l5gPyxGbQjC+OnM8DHQc6fHLXSNjXK+uzKbSBrq+oXUPPi96vx0YbBtuLU/qL/lTa+WNHSqZsWmZssMrmHCKlqlBKk1P+cswlBgWYDW8CGEFO69wqQWvodfqC+Pvws6gfh7ZNZT4s1OkRJJK4mecuUIM9JnAtb1ukDE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748508; c=relaxed/simple;
	bh=qN0S2brDM0m6IRUH6qeUxGxgB/Z9oc1GttwZ/dlWadQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYbUo8OVJG1KnQIbrdpc0SqGo/0lR/WXQF4/rWGECc2fuLLt+x7JMwN5GBbOGyCRT+7E6dWFlVbf/+BrsVc77bj1Ju9/oqdjE+8OTAKCjdFv767BnSJ6QzmBiz+w4J0SwzY5p9JLHOnkTCiXschyeukEFi6qQbgMDeOzR3iNdOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdLG6bm/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740748505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tQqt3r025DJCbsc59QzlMQIjxIUe40/8e/dqEZGAfJA=;
	b=BdLG6bm/lkD6LPaQmRDipdFEdAShpWjs/DLxH7t/RMs03FSyxaR0lt4Q91Ve0b3mWDlKr9
	xFWLifTgyL6hOtBsQ99Lv83w9mPxnKhhLSG23MOJzwF92r7JcvgTEzQdL60g7aVvAuxjU6
	hrzJbo14rgVvA+didcB2pGImpsxFHSQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-k9FfwJOHOByQiLqbKSXXWQ-1; Fri,
 28 Feb 2025 08:15:02 -0500
X-MC-Unique: k9FfwJOHOByQiLqbKSXXWQ-1
X-Mimecast-MFC-AGG-ID: k9FfwJOHOByQiLqbKSXXWQ_1740748501
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D69B61800360;
	Fri, 28 Feb 2025 13:15:00 +0000 (UTC)
Received: from [10.22.88.31] (unknown [10.22.88.31])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9D5E19560AE;
	Fri, 28 Feb 2025 13:14:58 +0000 (UTC)
Message-ID: <72880abf-55c9-4dd6-872d-3c5b3faa4198@redhat.com>
Date: Fri, 28 Feb 2025 08:14:57 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvme: update the multipath warning in
 nvme_init_ns_head
To: Nilay Shroff <nilay@linux.ibm.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Cc: loberman@redhat.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, emilne@redhat.com, bgurney@redhat.com
References: <20250228032541.369804-1-jmeneghi@redhat.com>
 <20250228032541.369804-4-jmeneghi@redhat.com>
 <abd856da-7ca6-419f-943b-80dcc885f68b@linux.ibm.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <abd856da-7ca6-419f-943b-80dcc885f68b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 2/28/25 1:28 AM, Nilay Shroff wrote:
> On 2/28/25 8:55 AM, John Meneghini wrote:
>> The new NVME_MULTIPATH_PARAM config option requires updates
>> to the warning message in nvme_init_ns_head(). Remove
>> the old warning message and add new ones.
>>
>> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
>> ---
>>   drivers/nvme/host/core.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 818d4e49aab5..c2b7e6834535 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3823,8 +3823,16 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
>>   			dev_warn(ctrl->device,
>>   				"Found shared namespace %d, but multipathing not supported.\n",
>>   				info->nsid);
>> +#ifdef CONFIG_NVME_MULTIPATH
>> +#ifdef CONFIG_NVME_MULTIPATH_PARAM
>> +			dev_warn_once(ctrl->device,
>> +				"Shared namespace support requires core.nvme_multipath=Y.\n");
>> +
>> +#endif
>> +#else
>>   			dev_warn_once(ctrl->device,
>> -				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
>> +				"Shared namespace support requires CONFIG_NVME_MULTIPATH.\n");
>> +#endif
>>   		}
>>   	}
>>   
> 
> As NVME_MULTIPATH_PARAM depends on NVME_MULTIPATH, it implicitly implies
> that if NVME_MULTIPATH_PARAM is enabled then NVME_MULTIPATH has to be on.
> So above logic could be simplified.
> 
> However on another note, I really don't understand why do we need to add
> new warning here as there's already a warning present just above your
> changes.

Agreed.  How about if we just remove the

    	dev_warn_once(ctrl->device,
		"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
  
This is real problem.  This is a confusing message since there is no now plan to remove any of these config options from the kernel.

/John

> Thanks,
> --Nilay
> 
> 


