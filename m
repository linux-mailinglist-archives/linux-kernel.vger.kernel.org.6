Return-Path: <linux-kernel+bounces-263733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D96893D9D6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88481F2467E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC9D149C45;
	Fri, 26 Jul 2024 20:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2Gx+H08"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2881494CD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 20:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722026175; cv=none; b=bBOn6CZCOgiwlAkV1+VLwNNVFSLJMqQ6/QveTJKOOQhCMxSamw8e6XDkrj0NXG9U147Cj3fgIMcf8zScpIC54M3nCbYAaLH0AfNckJ2ixZkH2s8f/SoFvPoZrJrZlvsdFa0dbI+vk+d7gvfjObozsgAp8LXpVvN+UW86mmnY9A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722026175; c=relaxed/simple;
	bh=1yGabOCDYzM1SvBWjFVdPbv5wXNwEiSrRlUjdMYFRN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFUwZcOtmJmbT18iu5nk9iYbR1mfktqBKfFTdSM7iNuF+tK7JW4xwRS/C+QHqFHNgqzxG4NGBZ4NVQR8c0KM92A7Vky0+9Nyj395WtO6PiT4UXsfmDRCUpryRPdvZNqa80mWpKyUEfv9QU96oENgvwt3cisFgXfzrhGTuvcIXk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e2Gx+H08; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722026172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wm2UfiHnnlWhAZuLpVrEtIHN1JiWm1rRJEOIDoqpyDI=;
	b=e2Gx+H08Tz0la3GYGMvmyRWmr6ksFKjzn9NRnLgjsSfIw1aGt+ipg+w03zrNxfHG4kagZw
	4FwnJQ1fgRihD10VjRES5Y7ClKInuz6Iclgg+cDwVsGDJoBccdWTkGx54Q7cXDS3FX0WLL
	faI+aGpKOBRZhVhrXjad0G0V8iJFFN4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-v_DfzpV-PtmoRShQskjrvQ-1; Fri,
 26 Jul 2024 16:36:08 -0400
X-MC-Unique: v_DfzpV-PtmoRShQskjrvQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B467D1955D52;
	Fri, 26 Jul 2024 20:36:05 +0000 (UTC)
Received: from [10.2.16.80] (unknown [10.2.16.80])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B2EF1955D45;
	Fri, 26 Jul 2024 20:36:02 +0000 (UTC)
Message-ID: <463d8e53-0cac-419e-bd2a-584eb1c0725e@redhat.com>
Date: Fri, 26 Jul 2024 16:36:01 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup v4] cgroup: Show # of subsystem CSSes in
 cgroup.stat
To: Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kamalesh Babulal <kamalesh.babulal@oracle.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
References: <20240711025153.2356213-1-longman@redhat.com>
 <23hhazcy34yercbmsogrljvxatfmy6b7avtqrurcze3354defk@zpekfjpgyp6h>
 <0efbedff-3456-4e6a-8d2d-79b89a18864d@redhat.com>
 <qozzqah5blnsvc73jrhfuldsaxwsoluuewvgpukzgcuud4nqgc@xnctlkgk5yjv>
 <ZqQBaeAH_IfpRTnv@slm.duckdns.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZqQBaeAH_IfpRTnv@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 7/26/24 16:04, Tejun Heo wrote:
> Hello,
>
> On Fri, Jul 26, 2024 at 10:19:05AM +0200, Michal Koutný wrote:
>> On Thu, Jul 25, 2024 at 04:05:42PM GMT, Waiman Long <longman@redhat.com> wrote:
>>>> There's also 'debug' subsys. Have you looked at (extending) that wrt
>>>> dying csses troubleshooting?
>>>> It'd be good to document here why you decided against it.
>>> The config that I used for testing doesn't include CONFIG_CGROUP_DEBUG.
>> I mean if you enable CONFIG_CGROUP_DEBUG, there is 'debug' controller
>> that exposes files like debug.csses et al.
>>
>>> That is why "debug" doesn't show up in the sample outputs. The CSS #
>>> for the debug subsystem should show up if it is enabled.
>> So these "debugging" numbers could be implemented via debug subsys. So I
>> wondered why it's not done this way. That reasoning is missing in the
>> commit message.
> While this is a bit of implementation detail, it's also something which can
> be pretty relevant in production, so my preference is to show them in
> cgroup.stat. The recursive stats is something not particularly easy to
> collect from the debug controller proper anyway.
>
> One problem with debug subsys is that it's unclear whether they are safe to
> use and can be depended upon in production. Not that anything it shows
> currently is particularly risky but the contract around the debug controller
> is that it's debug stuff and developers may do silly things with it (e.g.
> doing high complexity iterations and what not).
>
> The debug controller, in general, I'm not sure how useful it is. It does
> nothing that drgn scripts can't do and doesn't really have enough extra
> benefits that make it better. We didn't have drgn back when it was added, so
> it's there for historical reasons, but I don't think it's a good idea to
> expand on it.

I totally agree.

For RHEL, CONFIG_CGROUP_DEBUG isn't enabled in the production kernel, 
but is enabled in the debug kernel. I believe it may be similar in other 
distros. So we can't really reliably depend on using the debug 
controller to get this information which can be useful to monitor cgroup 
behavior in a production kernel.

Cheers,
Longman


