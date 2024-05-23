Return-Path: <linux-kernel+bounces-187693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5EF8CD6B5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7B11C20BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B94F11723;
	Thu, 23 May 2024 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijiOajyY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0733111A1
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476936; cv=none; b=n4xv7+0USk3cryMCbs/IFHpg06eLkFrEtvZ/dJozDptyl99rHgNp66Kqc57lva+xmrfndA1WDtt4p4HYJ7SU5+jc9p/LHC2k43synuJSVlJg1jJPMFHPStv7eNXCr/VEW9FYT9k163F8uAlRRbRGOK0RTPk2FBIphFB9E/yY+Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476936; c=relaxed/simple;
	bh=BBBOrh0Mu693e8NCMquwX1UC+oxgL+eLPM2+hr3VEf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDLfCq5on69nqfrloPBd+ufNyigXZ0Vpb8L0Z5D5JAXxQ7oraPVNMd6U3ekVjK2uIEgxW/v4M2M6vpcPn59wjMSJSU4N8Rg/wGW2jELvoSlVOUbbvgYyHBxHKmpJAVok3TRJ1OOIIgGkOokoDRauDUBfpLACRv+dLLQxuHwvsoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ijiOajyY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716476933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uryHqSo7J6emxdG0G3D06GB408oVW6DLwiUMV2hxBbo=;
	b=ijiOajyYRjD0xnlsiaBJ5M/6YzzBlbC+VoEcqB1YCsRNf2VWRPtXq/taVGpwJa4kYoSEqi
	lLAhU6DClvkOwcjtxG6p3v+RTB9j6mLp89ZfVQaEFpldpRIIUFRIHRBGawtD0JfayCBwWO
	5aQeaTGv+6U3myynYBS6wSmctaEBVg8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-wtZUeLnaOWSKQ2SN78HIoQ-1; Thu,
 23 May 2024 11:08:49 -0400
X-MC-Unique: wtZUeLnaOWSKQ2SN78HIoQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 258E93C025B9;
	Thu, 23 May 2024 15:08:48 +0000 (UTC)
Received: from [10.18.25.182] (unknown [10.18.25.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D036A2026D68;
	Thu, 23 May 2024 15:08:47 +0000 (UTC)
Message-ID: <40122d01-9e5b-4c85-9cf4-93f7abd2532b@redhat.com>
Date: Thu, 23 May 2024 11:08:47 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, emilne@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240522165406.702362-1-jmeneghi@redhat.com>
 <20240523065257.GB28524@lst.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20240523065257.GB28524@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 5/23/24 02:52, Christoph Hellwig wrote:
>> +	/*
>> +	 * queue-depth iopolicy does not need to reference ->current_path
>> +	 * but round-robin needs the last path used to advance to the
>> +	 * next one, and numa will continue to use the last path unless
>> +	 * it is or has become not optimized
>> +	 */
> 
> Can we please turn this into a full sentence?  I.e.:
> 
> 	/*
> 	 * The queue-depth iopolicy does not need to reference ->current_path,
> 	 * but the round-robin iopolicy needs the last path used to advance to
> 	 * the next one, and numa will continue to use the last path unless
> 	 * it is or has become non-optimized.
> 	 */
> 
> ?

I can do that.

>> +	if (iopolicy == NVME_IOPOLICY_QD)
>> +		return nvme_queue_depth_path(head);
>> +
>> +	node = numa_node_id();
>>   	ns = srcu_dereference(head->current_path[node], &head->srcu);
>>   	if (unlikely(!ns))
>>   		return __nvme_find_path(head, node);
>>   
>> -	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
>> +	if (iopolicy == NVME_IOPOLICY_RR)
>>   		return nvme_round_robin_path(head, node, ns);
>> +
>>   	if (unlikely(!nvme_path_is_optimized(ns)))
>>   		return __nvme_find_path(head, node);
>>   	return ns;
> 
> Also this is growing into the kind of spaghetti code that is on the fast
> path to become unmaintainable.  I'd much rather see the
> srcu_dereference + __nvme_find_path duplicated and have a switch over
> the iopolicies with a separate helper for each of them here than the
> various ifs at different levels.


OK I will turn this into a switch statement.

>> +static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
> 
> Overly long line here.

I can fix this.

>> +{
>> +	struct nvme_ctrl *ctrl;
>> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
>> +
>> +	if (old_iopolicy == iopolicy)
>> +		return;
>> +
>> +	WRITE_ONCE(subsys->iopolicy, iopolicy);
>> +
>> +	/* iopolicy changes reset the counters and clear the mpath by design */
>> +	mutex_lock(&nvme_subsystems_lock);
>> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>> +		atomic_set(&ctrl->nr_active, 0);
>> +		nvme_mpath_clear_ctrl_paths(ctrl);
>> +	}
>> +	mutex_unlock(&nvme_subsystems_lock);
> 
> You probably want to take the lock over the iopolicy assignment to
> serialize it.  And why do we need the atomic_set here?

Since we are targeting this to 6.11, I will work on refactoring this code.

I'll remove the atomic set here, but I may also add a WARN_ON_ONCE someplace just to be sure our assumptions about the nr_active 
counter state is correct. I agree with Keith that these counters need to be accurate in order for queue-depth to work.

>> +
>> +	pr_notice("%s: changed from %s to %s for subsysnqn %s\n", __func__,
>> +			nvme_iopolicy_names[old_iopolicy], nvme_iopolicy_names[iopolicy],
> 
> Pleae avoid the overly long line here as well.

Hmm... I thought I fixed this already.   Will do.

>>   	NVME_REQ_CANCELLED		= (1 << 0),
>>   	NVME_REQ_USERCMD		= (1 << 1),
>>   	NVME_MPATH_IO_STATS		= (1 << 2),
>> +	NVME_MPATH_CNT_ACTIVE	= (1 << 3),
> 
> This does not match the indentation above.

I must have my tab stop set incorrectly in .vimrc or something.  I'll fix this.

/John


