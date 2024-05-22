Return-Path: <linux-kernel+bounces-186491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D40928CC4DE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCF328230F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3A4140397;
	Wed, 22 May 2024 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpUW4hC2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E43313D8AA
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716395041; cv=none; b=lF7iGDqJ+cL//ixOve9nEzm8dEH5G+U1WDQ16hMzv00P2hDU7ifa9uyjvAlnRXKlVud9yokv0R0tv/l80V6jtomhmtb2OkwSWlgK6udv3obI6BMd8uoQgAUSIdi8NJj9Sz+FavPJ2reegcpnU/gZtlyHzFXP2NaAeIruFgC1H5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716395041; c=relaxed/simple;
	bh=WzzACzeOEfdxxtrcE38+k9lmcbN8RjTur9kWqmXDwNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQ4ppTSZKy9jzMwktf77SceM3qE7HKmA4p6TMyyEJL5ElPlwtEixUBOzq8y3SgsBKcYudGrrRU3gyD8VDBkVawKp3rPaFmLq3ez2cLrthBZwYKDyLn2tC4Mg17Agj1liOO/j+lwngGkzTNqYNGOU14I4/26D6vw3Z+1UQNbZsII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MpUW4hC2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716395038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hB44jEoNckFCuyEM1NsGtowIzM2T9RXtZ2BqaZ5qjGY=;
	b=MpUW4hC2iWeLvipwP947yeIESEdLCdKdJewL4t1LgN+DuGuxDU8RjnPtQIZStO0RAZjubi
	agLEOuspFu9GhbWorX8aZo1xVedCTNvSo3CuGvxWLjdFMTJ77Hz2+ruGW0T7PvMHU1QoWb
	r6bhfHI4DcB5qNrzCLHbgawhr7rSaZk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-uwP77EvXMSml3iGLmDurqQ-1; Wed,
 22 May 2024 12:23:52 -0400
X-MC-Unique: uwP77EvXMSml3iGLmDurqQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18C423C025D2;
	Wed, 22 May 2024 16:23:52 +0000 (UTC)
Received: from [10.22.8.193] (unknown [10.22.8.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4C970492BC6;
	Wed, 22 May 2024 16:23:51 +0000 (UTC)
Message-ID: <cef5a764-ffab-495c-bea2-e4c6a7c76944@redhat.com>
Date: Wed, 22 May 2024 12:23:51 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, emilne@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240522154212.643572-1-jmeneghi@redhat.com>
 <20240522154212.643572-2-jmeneghi@redhat.com>
 <Zk4VtiCjeqkBKCBA@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <Zk4VtiCjeqkBKCBA@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 5/22/24 11:56, Keith Busch wrote:
> On Wed, May 22, 2024 at 11:42:12AM -0400, John Meneghini wrote:
>> +static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
>> +{
>> +	struct nvme_ctrl *ctrl;
>> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
>> +
>> +	WRITE_ONCE(subsys->iopolicy, iopolicy);
>> +
>> +	/* iopolicy changes reset the counters and clear the mpath by design */
>> +	mutex_lock(&nvme_subsystems_lock);
>> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>> +		atomic_set(&ctrl->nr_active, 0);
> 
> Can you me understand why this is a desirable feature? Unless you
> quiesce everything at some point, you'll always have more unaccounted
> requests on whichever path has higher latency. That sounds like it
> defeats the goals of this io policy.

This is true. And as a matter of practice I never change the IO policy when IOs are in flight.  I always stop the IO first.
But we can't stop any user from changing the IO policy again and again.  So I'm not sure what to do.

If you'd like I add the 'if (old_iopolicy == iopolicy) return;' here, but that's not going to solve the problem of inaccurate 
counters when users start flipping io policies around. with IO inflight. There is no synchronization between io submission 
across controllers and changing the policy so I expect changing between round-robin and queue-depth with IO inflight suffers 
from the same problem... though not as badly.

I'd rather take this patch now and figure out how to fix the problem with another patch in the future.  Maybe we can check the 
io stats and refuse to change the policy of they are not zero....

>> @@ -1061,6 +1066,9 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
>>   {
>>   	return false;
>>   }
>> +static inline void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
>> +{
>> +}
>>   #endif /* CONFIG_NVME_MULTIPATH */
> 
> You can remove this stub function since the only caller resides in a
> CONFIG_NVME_MULTIPATH file.
> 

I can do that.  Since I have to spin a version 5 patch, do you want me to make the change above?

Is there anything else?

/John


