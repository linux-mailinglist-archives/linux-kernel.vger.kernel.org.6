Return-Path: <linux-kernel+bounces-248440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FA792DD30
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F3B1C21DB6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF09158A06;
	Wed, 10 Jul 2024 23:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAQ1WsoO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6720D157467
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720655505; cv=none; b=WroI5xedDw5DILJ31WVTFS5lErtGvxF7Z2y3M4i7y9stbAOmT/k1nDoVVo5bR1F2u6Q1iAAu2OBq3daWvN2jsY6yY4lqJ5P3F+lZBH2CQmG5D68et8JL+4bCUGu6LvpDmLVhR82t3iRUpmfHAp3ad7N2/Z1vO1WqbSYhqHbsjfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720655505; c=relaxed/simple;
	bh=npGFZ7+tSqeY2xxryGCHThpOWXBJ+gAv7JI9axGTi9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFtS569QYvmuuJOcENNr7O/XqGzXHue5cUuktAMTL2uO4MZyUNoEKJEwxeL/JfTYE39TAQpoT8NfLkQ/1ndCJ5240KVbsL1izCxehmTPYep6qnN6/f6tLAk22gH1TG5PV5YzHuDf6JQZ/mg6TxraLDd+co05LubJj07Ay9r2NgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAQ1WsoO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720655502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NA5BtkAtts8DBgOsaPfYF+PKA9KEchHy7+koVC7lhY8=;
	b=eAQ1WsoOIohbSWDbIMVss3bQwt3n+Zy6HK32OaNGnyikBKDFdNHSmBOAEu3uQczdLwIe0N
	vUGeZy0UwNY4tMzPJngUluPsY3fbfBBwn4jQqyiORWA+TMWNhCEqLMIbc1Y+7WSPqGHK/n
	TXHrmgS/gVsR39gP/uIjln4qsbMxfa8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-gbRn394WMUSJ9IOq0kwrXQ-1; Wed,
 10 Jul 2024 19:51:35 -0400
X-MC-Unique: gbRn394WMUSJ9IOq0kwrXQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AAEF1955F43;
	Wed, 10 Jul 2024 23:51:33 +0000 (UTC)
Received: from [10.22.48.10] (unknown [10.22.48.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5DBBC1955F40;
	Wed, 10 Jul 2024 23:51:31 +0000 (UTC)
Message-ID: <fc72e655-bb17-4b55-b00e-1fc640d35d77@redhat.com>
Date: Wed, 10 Jul 2024 19:51:30 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cgroup: Show # of subsystem CSSes in cgroup.stat
To: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kamalesh Babulal <kamalesh.babulal@oracle.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
References: <20240710182353.2312025-1-longman@redhat.com>
 <Zo8ELsGOyFwkpKUj@slm.duckdns.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <Zo8ELsGOyFwkpKUj@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


On 7/10/24 17:59, Tejun Heo wrote:
> Hello,
>
> On Wed, Jul 10, 2024 at 02:23:52PM -0400, Waiman Long wrote:
>> With this patch applied, a sample output from root cgroup.stat file
>> was shown below.
>>
>> 	nr_descendants 54
>> 	nr_dying_descendants 44
>> 	nr_cpuset 1
>> 	nr_cpu 40
>> 	nr_io 40
>> 	nr_memory 54
>> 	nr_dying_memory 44
>> 	nr_perf_event 55
>> 	nr_hugetlb 1
>> 	nr_pids 54
>> 	nr_rdma 1
>> 	nr_misc 1
> So, css may be too specific a name but this looks a bit disorganized. How
> about using controller as the common prefix? Maybe something like:
>
> 	nr_controllers_cpu 40
> 	nr_controllers_io 40
> 	nr_controllers_memory 54
> 	nr_controller_perf_event 55
> 	...
> 	nr_dying_controllers_memory 44
>
> If controllers is too long, we can shorten it somehow or use subsys, maybe?

I think "controllers" is too long. I am fine with "subsys". Will make 
change in the next version.

Thanks,
Longman


