Return-Path: <linux-kernel+bounces-221379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D07490F2D8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32A6284CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511B015749C;
	Wed, 19 Jun 2024 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8VkWWUW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99CD150984
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811853; cv=none; b=BgkwJIGh2YpaHjKoZDpPWtn+IIdpF2j9hWaO/RqX45mXXrKcn89BLw8DyFQ4uGqA0wJ13FgiVj35YyKQK4mRvQXQJpzEt2fyJBG2wBfgA9i9ibuD7Z5UWB+SHKMqt/TA+L24/TmoqeOBbcvYTH8sqEkFkR0t4605jNY+IVrBu2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811853; c=relaxed/simple;
	bh=8Mjv0ReOMw49FsSUkznGKWHpctFMfxGczyr14pY4ruw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/q+ZDAPTJsBPQ37uwFHGGpLrWpmzi6awmNqMVZydTiK0UCuyw/2018hEwjn+WpE5H9i/Q3qZpf9DHrBrjkhVvdn+yiUnheG7h4vtyb/WGS0VkoHuvYOnoVDtNJxkW0Um1RpE2hQPvhGFhnkFx3BPztKIlx94xXgKbqwmP8lnDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g8VkWWUW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718811850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crmfw9nGEYND9twKivZHUhF+pajzWUmsBYjoitLN7pk=;
	b=g8VkWWUWXw5fHNe16r4kcR4XR+l+md0j4OhAEz0wdLmZ9VuaP4LEYpVp+6qa2cnHPpj0F1
	BBp+2oZDcWPUpeJJLzWzbdXspq5lL2Y8kyVjSftVUpaUY8cnETAfNZAz+eJ95qsKX0hyk3
	hYi0FlYe/GlFk1VMpwQQridlrVw0g/o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-PkCrYSDMPjiv1lagfPOr2w-1; Wed,
 19 Jun 2024 11:44:07 -0400
X-MC-Unique: PkCrYSDMPjiv1lagfPOr2w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E23319560B4;
	Wed, 19 Jun 2024 15:44:05 +0000 (UTC)
Received: from [10.22.33.177] (unknown [10.22.33.177])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E593119560B3;
	Wed, 19 Jun 2024 15:44:02 +0000 (UTC)
Message-ID: <76f3ded6-7922-4c90-a650-7bbd08e442b4@redhat.com>
Date: Wed, 19 Jun 2024 11:44:02 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] nvme-multipath: implement "queue-depth" iopolicy
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "emilne@redhat.com"
 <emilne@redhat.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jrani@purestorage.com" <jrani@purestorage.com>,
 "randyj@purestorage.com" <randyj@purestorage.com>,
 "hare@kernel.org" <hare@kernel.org>
References: <20240612002034.1299922-1-jmeneghi@redhat.com>
 <20240612002034.1299922-2-jmeneghi@redhat.com>
 <1307c447-65bb-430c-88e1-045191d8d8ba@nvidia.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <1307c447-65bb-430c-88e1-045191d8d8ba@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 6/11/24 21:44, Chaitanya Kulkarni wrote:
> On 6/11/24 17:20, John Meneghini wrote:
>> From: Thomas Song <tsong@purestorage.com>
>>

>> +
>> +	if ((nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)) {
>> +		result = atomic_dec_if_positive(&ns->ctrl->nr_active);
>> +		WARN_ON_ONCE(result < 0);
>> +	}
>>    
>>    	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
>>    		return;
> 
> can we remove result variable ? that is only used once,
> how about something like this unless there is something wrong with
> totally untested :-

Sure I can do that.

>> +static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
>>    {
>> -	struct nvme_ns *ns, *found = NULL;
>> +	struct nvme_ns *ns, *old, *found = NULL;
>> +	int node = numa_node_id();
>> +
>> +	old = srcu_dereference(head->current_path[node], &head->srcu);
>> +
> 
> nit:- no need for white-line above ?

I sometimes add a line feed because I think it makes the code more readable, But everyone seems to dislike extra white lines so 
I'll remove them.

>> +inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>> +{
>> +	switch (READ_ONCE(head->subsys->iopolicy)) {
>> +	case NVME_IOPOLICY_QD:
>> +		return nvme_queue_depth_path(head);
>> +	case NVME_IOPOLICY_RR:
>> +		return nvme_round_robin_path(head);
>> +	default:
>> +		return nvme_numa_path(head);
>> +	}
> 
> should we use another case for NVME_IOPOLICY_NUMA that will call
> nvme_numa_path() and report ratelimited error on the default lable
> before settling on nvme_numa_path()?
> 
> something like this totally untested :-

Actually, I don't think this is worth it. The likelihood that the iopolicy will get corrupted is almost NILL. The only way this 
can happen is if there were a bug in the sysfs code that controls this variable. I've tested this enough to know there's not 
going to be any problem here and I don't think adding a warning to a code path that can only be hit by a programming error is 
needed.

>> +}
>> +
>>    static bool nvme_available_path(struct nvme_ns_head *head)
>>    {
>>    	struct nvme_ns *ns;
>> @@ -803,6 +870,28 @@ static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
>>    			  nvme_iopolicy_names[READ_ONCE(subsys->iopolicy)]);
>>    }
>>    
>> +static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys,
>> +		int iopolicy)
>> +{
>> +	struct nvme_ctrl *ctrl;
>> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
>> +
>> +	if (old_iopolicy == iopolicy)
>> +		return;
>> +
>> +	WRITE_ONCE(subsys->iopolicy, iopolicy);
>> +
>> +	/* iopolicy changes clear the mpath by design */
>> +	mutex_lock(&nvme_subsystems_lock);
>> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
>> +		nvme_mpath_clear_ctrl_paths(ctrl);
>> +	mutex_unlock(&nvme_subsystems_lock);
>> +
>> +	pr_notice("%s: changed from %s to %s for subsysnqn %s\n", __func__,
>> +			nvme_iopolicy_names[old_iopolicy], nvme_iopolicy_names[iopolicy],
>> +			subsys->subnqn);
>> +}
>> +
>>    static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
>>    		struct device_attribute *attr, const char *buf, size_t count)
>>    {
>> @@ -812,7 +901,7 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
>>    
>>    	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
>>    		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
>> -			WRITE_ONCE(subsys->iopolicy, i);
>> +			nvme_subsys_iopolicy_update(subsys, i);
>>    			return count;
>>    		}
>>    	}
>> @@ -923,6 +1012,9 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>>    	    !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
>>    		return 0;
>>    
>> +	/* initialize this in the identify path to cover controller resets */
> 
> nit: If I'm not wrong, this function gets called from
> |nvme_init_identify()|,
> so it's pretty clear. That makes above comment kind of redundant ?
> However, if others want that comment here, please ignore this message.

Yes, but it's not clear that nvme_init_identify() is called in the controller reset path.

Hannes asked for a comment here so I'd like to keep this.

>> +	atomic_set(&ctrl->nr_active, 0);
>> +
>>    	if (!ctrl->max_namespaces ||
>>    	    ctrl->max_namespaces > le32_to_cpu(id->nn)) {
>>    		dev_err(ctrl->device,
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 73442d3f504b..d6c1fe3e2832 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -50,6 +50,8 @@ extern struct workqueue_struct *nvme_wq;
>>    extern struct workqueue_struct *nvme_reset_wq;that 
>>    extern struct workqueue_struct *nvme_delete_wq;
>>    
>> +extern struct mutex nvme_subsystems_lock;
>> +
>>    /*
>>     * List of workarounds for devices that required behavior not specified in
>>     * the standard.
>> @@ -195,6 +197,7 @@ enum {
>>    	NVME_REQ_CANCELLED		= (1 << 0),
>>    	NVME_REQ_USERCMD		= (1 << 1),
>>    	NVME_MPATH_IO_STATS		= (1 << 2),
>> +	NVME_MPATH_CNT_ACTIVE	= (1 << 3),
> 
> nit:- please align above to existing code ...
> 

I changed my tab stop from 4 to 8 and fixed this.

Thanks for your review. I will follow up with a v7 patch.

/John


