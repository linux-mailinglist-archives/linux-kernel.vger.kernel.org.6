Return-Path: <linux-kernel+bounces-244784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BF692A983
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3481F2268E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF18914E2DA;
	Mon,  8 Jul 2024 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vz9cR2jS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470C11474AF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720465312; cv=none; b=aTaOOH3RSA0441P3n/aubAc7h+B0aolp7C9X0Z2cg6Qu5m8yIA34fhvbYYUObhy/pfW4JGe7I76qbVy9551ZmEvj15T5jEcuN5LvSGDLKfqzt0MGdLlN4gq8GSwix1wVEjL4uJby9l5MMotzF+E4IHnzcVY4hzn3jboZukbCMGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720465312; c=relaxed/simple;
	bh=jP2M0JpMs2wAYT7RmW+K09ipvg9NM/5VSFNHQgyu+uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QejtaBQw2aSa925wg42LmkmXeCThLJJUAuA39vbX/+iwPJ4wynPLwzVu81cuFFWzS+ovTtRDp+QG6+ua1QhuMWe0/rMPd08zTtuKza99HTr6Yg4tYXnO3YTYlIhS2oGnktOdbcS9ws5J0qA4pPFTOfFUnNSjBueKvHXTimnX3e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vz9cR2jS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720465309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLGoCNz9DClhgM4ZV9QmfktXdqX3rAlfMW12nS2PwS8=;
	b=Vz9cR2jSIxHCjCZQUAeEw3Qpg1MsL/tAB7IFl7xW4B2l92ZbP3MUJzIgWs9XjKXJSEdz+L
	Tnhqh4BKVYG1ESkioQ3087Sc5OaW1rywqgQftUPbx9lsMx4XCbOn250gdM8fYz4fDJSJUF
	K+sjPT/9MDN+HMVU+6hoLw3jRzC6NVk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-HdacGquzPCOi2M7P_MpIWw-1; Mon,
 08 Jul 2024 15:01:44 -0400
X-MC-Unique: HdacGquzPCOi2M7P_MpIWw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6E1519560B0;
	Mon,  8 Jul 2024 19:01:41 +0000 (UTC)
Received: from [10.22.33.83] (unknown [10.22.33.83])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 57C253000181;
	Mon,  8 Jul 2024 19:01:40 +0000 (UTC)
Message-ID: <b505c15b-8fd2-44f2-8e33-46ae29c2696e@redhat.com>
Date: Mon, 8 Jul 2024 15:01:39 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup 1/2] cgroup: Show # of subsystem CSSes in
 /proc/cgroups
To: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240706005622.2003606-1-longman@redhat.com>
 <Zowzvf2NEOzgXYr3@slm.duckdns.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <Zowzvf2NEOzgXYr3@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


On 7/8/24 14:45, Tejun Heo wrote:
> Hello, Waiman.
>
> On Fri, Jul 05, 2024 at 08:56:21PM -0400, Waiman Long wrote:
>> The /proc/cgroups file shows the number of cgroups for each of the
>> subsystems.  With cgroup v1, the number of CSSes is the same as the
>> number of cgroups. That is not the case anymore with cgroup v2. The
>> /proc/cgroups file cannot show the actual number of CSSes for the
>> subsystems that are bound to cgroup v2.
>>
>> So if a v2 cgroup subsystem is leaking cgroups (typically memory
>> cgroup), we can't tell by looking at /proc/cgroups which cgroup
>> subsystems may be responsible.  This patch adds a css counter in the
>> cgroup_subsys structure to keep track of the number of CSSes for each
>> of the cgroup subsystems.
> The count sounds useful to me but can we add it in cgroup.stats instead?

That information is certainly useful to display to cgroup.stat which 
currently only shows nr_descendants and nr_dying_descendants. So does 
"nr_<subsys_name> <cnt>" for each cgroup subsystems look good to you or 
do you have other suggestion?

The reason for this patch is because I got a bug report about leaking 
blkio cgroup due to the information shown in /proc/cgroups. I know you 
want do deprecate it for cgroup v2. How about adding a iine like "# 
Deprecated for cgroup v2, use cgroup.stats file for cgroup counts" at 
the top of /proc/cgroups when cgroup v2 is active?

Cheers,
Longman



