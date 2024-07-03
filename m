Return-Path: <linux-kernel+bounces-239874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7A592664E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD854B22526
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E7C183090;
	Wed,  3 Jul 2024 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8qpAns7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B7D17164D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025048; cv=none; b=CwVjw0DiktkQ7FfU90YDJGmswY/vt2ngefj+g7SAQ7TT75cWcRzlCWy79t/+fEThwkO6nqCdFCPACDXSySH8mVmrrxDMOAGD/SlZn2gIM2xVcAkjJifQZFVCBTWWlEEQfmwn8+lM7PB1H/O9snPkGEP8Luz6OoxeRglzJ0NWBh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025048; c=relaxed/simple;
	bh=CBEpIJ+yTTH6tvDwHQChSIuTkQMT98fsO94PQ7OH7K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knfkDQx2GRAqepBbpkadqt9gzxAQGs3NETwFT7jkhuD07bOKxWK/HSP3GC3z+CjWlj23Py6juWONMb1rTn8uU1zvs7ymuufIjTN7SVKzvLD4bijPd6dNhDwg1qvGQk18RkKCx5G/wIZ88My5gXIZUdJ/c5YCbYjahqJ5y4waSlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i8qpAns7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720025045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51F+oMGr1yPpWhqMxtr5v0yeAnKAX4iYRi0FalsXEjY=;
	b=i8qpAns7jujuOG+UL4hmnxwgC6MpthDLRwVpDO0k3fi3nJn91HUr5eRewzJ3v6vjR4eCdF
	+RuMNJYd7RY7dkCU/w0f4Np2hACojtlNS6+y/rsASKmPzcqXPSUb6xlYl62asiksYGel+t
	ykPnpcYqyBii94chuWzSIFJnuMY+ZcY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-Zkdvbkh8PPuYV5D4SQ8WbA-1; Wed,
 03 Jul 2024 12:44:00 -0400
X-MC-Unique: Zkdvbkh8PPuYV5D4SQ8WbA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62DD319560AA;
	Wed,  3 Jul 2024 16:43:58 +0000 (UTC)
Received: from [10.22.33.252] (unknown [10.22.33.252])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0BDF51954B0E;
	Wed,  3 Jul 2024 16:43:55 +0000 (UTC)
Message-ID: <f9e55eb8-82a8-45f2-a949-1db182e95fc8@redhat.com>
Date: Wed, 3 Jul 2024 12:43:55 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cpuset v10 2/2] cpuset: use Union-Find to optimize the
 merging of cpumasks
To: Xavier <xavier_qy@163.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: tj@kernel.org, akpm@linux-foundation.org, lizefan.x@bytedance.com,
 hannes@cmpxchg.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org
References: <ZoRThI4lcZLxBlwc@slm.duckdns.org>
 <20240703063727.258722-1-xavier_qy@163.com>
 <20240703063727.258722-3-xavier_qy@163.com>
 <zkkadtdssdgkndojsvfwbig3xwtqvfleyw3wbg6vewjntmklxe@xle6jq7jvkv5>
 <2ea89e07.ac63.1907836ec4b.Coremail.xavier_qy@163.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <2ea89e07.ac63.1907836ec4b.Coremail.xavier_qy@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 7/3/24 06:49, Xavier wrote:
>
> Hi Michal and Longman,
>
> Please confirm my explanation about cgroup v2 below.
>
>
> At 2024-07-03 17:40:49, "Michal Koutný" <mkoutny@suse.com> wrote:
>> On Wed, Jul 03, 2024 at 02:37:27PM GMT, Xavier <xavier_qy@163.com> wrote:
>>> @@ -1102,31 +1101,25 @@ static int generate_sched_domains(cpumask_var_t **domains,
>>>   	if (root_load_balance && (csn == 1))
>>>   		goto single_root_domain;
>>>   
>>> -	for (i = 0; i < csn; i++)
>>> -		csa[i]->pn = i;
>>> -	ndoms = csn;
>>> -
>>> -restart:
>>> -	/* Find the best partition (set of sched domains) */
>>> -	for (i = 0; i < csn; i++) {
>>> -		struct cpuset *a = csa[i];
>>> -		int apn = a->pn;
>>> -
>>> -		for (j = 0; j < csn; j++) {
>>> -			struct cpuset *b = csa[j];
>>> -			int bpn = b->pn;
>>> -
>>> -			if (apn != bpn && cpusets_overlap(a, b)) {
>>> -				for (k = 0; k < csn; k++) {
>>> -					struct cpuset *c = csa[k];
>>> +	if (!cgrpv2) {
>> I'm surprised that original code wasn't branched on this on you add it
>> here. Why is UF used only for v1 code?
>>
> In the Patch v6, I explained to Longman that based on his new patch, the overlapping check and
> merge operations for cpusets are skipped in the case of cgroup v2. Because for cgroup v2,
> doms[i] is merely copied from csa[i] rather than merged.
> This needs further confirmation from Longman.

Actually, I would like to keep the cpuset merging part for both cgroup 
v1 and v2. I did notice that the hotplug code path can sometimes cause 
overlapping partition roots in some intermediate states. I will try to 
get it of that and use the merging part to verify that all partition 
roots are mutually exclusive.

Cheers,
Longman


