Return-Path: <linux-kernel+bounces-249775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFD392EFA4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48981F22B52
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079B716EC16;
	Thu, 11 Jul 2024 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCAxkjv2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CDA16DC16
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726206; cv=none; b=b+v6By5w6h66uWxYKi9KaNQOtQDiaIT4y75cBMAdg52tryI1nr7pbR2uDNwxS+PNFQpjF6BEQ2ji66FrInzunHrCuDp8p+xdcnNC3B+3O/G+OzzKfg1VR6vH+qH6J6SKubVOwDT9LFROdVVcMYkhceUY2I4m9xLRRnOQYOHURLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726206; c=relaxed/simple;
	bh=6PZa26qh4ymqFwVL8Iv7QFaHKJWBv371YVweZ2Zn+Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgcMyZ2+cVAm3EwrC45bkL0vBwqbuOz3nRf7SynPvqo3HlX6BCXozZPTIKc4NoZYh/B9eenMMNUSDdkBAc3G+soVViVuL757YfFNqAhsx1+gA/0K4HWAJOjWV8b3IlQ+WNPTu1NH611LKOe3KNG029d0zn2RD5nX794zx5rBZ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCAxkjv2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720726202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O/kdd0m2F7APQz5PEDRpjUvqai4YyztOcotNYxJFWVw=;
	b=TCAxkjv25TmvR9FHK3xHJoiyLWx0tQsP+VgpqQv6sC7EJ/YmDUEuEsCEl06aBSMjDklRm/
	TG7qxrAwoheIDrVCBIzjeNKVoUfQMPWswMWhoPy9hs5Kuo8qCt+YTlMnQOsxDOnkCI+f9L
	8hEA0EFtbsvB2qBrzB5Gj8c7XOuQJGE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-sovNFfwoN3ijfo5emT_STg-1; Thu,
 11 Jul 2024 15:30:01 -0400
X-MC-Unique: sovNFfwoN3ijfo5emT_STg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53DCD19560B1;
	Thu, 11 Jul 2024 19:29:59 +0000 (UTC)
Received: from [10.22.64.119] (unknown [10.22.64.119])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 59AF43000181;
	Thu, 11 Jul 2024 19:29:57 +0000 (UTC)
Message-ID: <a033dc74-2362-40f1-a091-b8bf22a8d3cb@redhat.com>
Date: Thu, 11 Jul 2024 15:29:56 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cgroup: Show # of subsystem CSSes in cgroup.stat
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Zefan Li <lizefan.x@bytedance.com>,
 Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kamalesh Babulal <kamalesh.babulal@oracle.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
References: <20240710182353.2312025-1-longman@redhat.com>
 <20240711134927.GB456706@cmpxchg.org>
 <4e1078d6-6970-4eea-8f73-56a3815794b5@redhat.com>
 <ZpAT_xu0oXjQsKM7@slm.duckdns.org>
 <76e70789-986a-44c2-bfdc-d636f425e5ae@redhat.com>
 <ZpAoD7_o8bf6yVGr@slm.duckdns.org>
 <e5348a85-22eb-48a6-876d-3180de5c7171@redhat.com>
 <ZpArhD49OonR6Oz6@slm.duckdns.org>
 <c54651db-1a06-49f6-aea7-02768ad70756@redhat.com>
 <ZpAwx358QVr4V7RN@slm.duckdns.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZpAwx358QVr4V7RN@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


On 7/11/24 15:21, Tejun Heo wrote:
> Hello,
>
> On Thu, Jul 11, 2024 at 03:13:12PM -0400, Waiman Long wrote:
>> That will means cgroup subsystems that are seldomly used like rdma, misc or
>> even hugetlb will always be shown in all the cgroup.stat output. I actually
> Hmm... yeah, that does increase the amount of output, but I don't know. The
> trade-off is between consistency and brevity and I think I'd go for
> consistency here.
>
>> prefer just showing those that are enabled. As for dying memory cgroups,
>> they will only be shown in its online ancestors. We currently don't know how
> So, one peculiarity with memory is that when you enable io, it gets
> implicitly enabled together and we likely wanna show that.

If memory is implicitly enabled, it is treated as enabled as the 
corresponding cgroup->subsys[] entry should be set. I currently don't 
filter out those in the cgrp_dfl_implicit_ss_mask. So perf_event, which 
is implicitly enabled, is shown in all the cgroup.stat.

If you still want to display all even if some of them are not enabled, I 
can certainly do that.

Cheers,
Longman




