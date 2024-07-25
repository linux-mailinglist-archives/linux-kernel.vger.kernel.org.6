Return-Path: <linux-kernel+bounces-262596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182C893C92E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 21:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ACE31C2203D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCA778676;
	Thu, 25 Jul 2024 19:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tgptbb8w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0227347D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721937194; cv=none; b=i2JNHYb7rDK+ybxawe31fZsy+YX3Rhr66OPwOsofCo0QF9vU348E2km53JXIcfDxVbXTA9bpaIpOggYf9mo5/coAt/Lej22E8nnmIaitwBqBUapGPA+A8W7SUtBghJsHyI62jZugE1xZQSE9nHnkyq1sTdqBzUA+4NLTAHlBcr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721937194; c=relaxed/simple;
	bh=1GUKT+Tr8H8BV8Q3JRMZKHBO8rTKGsVcjYt7Y/016Lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iHoci7bT6532+p/AYOdIMhTcGGXAvlXKkysTP05+ebeeot6nEo2ztBp715VbGjD7YJHarJ8JpB0RucEpJTWhWD8eRdy9zaRzzqaE//3E0TTwSi+QdcaKhvfV97Z4oZKPMK/MtT1j8sfauStl+A2h1LgayREDcthGzUkheEMsCp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tgptbb8w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721937191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvBDGnocb/47TFKjbfZhFnyqxdYf6JzZyxnyKcBwno4=;
	b=Tgptbb8wuntnyuUYud2oFbNXhW8ZwFfsOE2kTtyDsM5t8oewkK4Xbd+jvRUM9xGeXQ705Q
	4ef+l7M0I0BTb7E78yiHWk1ivFbWJ0wm/P6g/KtZuW4/2ckDH23PjZXgZm93uZHnCUeMOX
	QSKkkoiTSLTu2i4PLoOZQ4bGCUtsH4o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-R4o-vMywNqW_mBxYDbVDtw-1; Thu,
 25 Jul 2024 15:53:05 -0400
X-MC-Unique: R4o-vMywNqW_mBxYDbVDtw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 371D119560AD;
	Thu, 25 Jul 2024 19:53:03 +0000 (UTC)
Received: from [10.2.16.78] (unknown [10.2.16.78])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42E931955F40;
	Thu, 25 Jul 2024 19:52:59 +0000 (UTC)
Message-ID: <ee69d1a0-3ecd-4e69-afc3-ea711d24b509@redhat.com>
Date: Thu, 25 Jul 2024 15:52:58 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Use system_unbound_wq to avoid disturbing isolated
 CPUs
To: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vratislav Bendel <vbendel@redhat.com>
References: <20240723181025.187413-1-longman@redhat.com>
 <20240725153552.GA927762@neeraj.linux>
 <96aec91c-aa5c-4352-b93c-323b22011370@redhat.com>
 <20240725193302.GA927854@neeraj.linux>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240725193302.GA927854@neeraj.linux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 7/25/24 15:33, Neeraj Upadhyay wrote:
> On Thu, Jul 25, 2024 at 01:02:01PM -0400, Waiman Long wrote:
>> On 7/25/24 11:35, Neeraj Upadhyay wrote:
>>> On Tue, Jul 23, 2024 at 02:10:25PM -0400, Waiman Long wrote:
>>>> It was discovered that isolated CPUs could sometimes be disturbed by
>>>> kworkers processing kfree_rcu() works causing higher than expected
>>>> latency. It is because the RCU core uses "system_wq" which doesn't have
>>>> the WQ_UNBOUND flag to handle all its work items. Fix this violation of
>>>> latency limits by using "system_unbound_wq" in the RCU core instead.
>>>> This will ensure that those work items will not be run on CPUs marked
>>>> as isolated.
>>>>
>>> Alternative approach here could be, in case we want to keep per CPU worker
>>> pools, define a wq with WQ_CPU_INTENSIVE flag. Are there cases where
>>> WQ_CPU_INTENSIVE wq won't be sufficient for the problem this patch
>>> is fixing?
>> What exactly will we gain by defining a WQ_CPU_INTENSIVE workqueue? Or what
>> will we lose by using system_unbound_wq? All the calls that are modified to
>> use system_unbound_wq are using WORK_CPU_UNBOUND as their cpu. IOW, they
>> doesn't care which CPUs are used to run the work items. The only downside I
>> can see is the possible loss of some cache locality.
>>
> For the nohz_full case, where unbounded pool workers run only on housekeeping CPU
> (cpu0), if multiple other CPUs are queuing work, the execution of those
> works could get delayed. However, this should not generally happen as
> other CPUs would be mostly running in user mode.
Well, it there is only one housekeeping CPU, a lot of background kernel 
tasks will be slowed down. Users should be careful about the proper 
balance between the number of housekeeping and nohz-full CPUs.
>
>
>> In fact, WQ_CPU_INTENSIVE can be considered a subset of WQ_UNBOUND. An
>> WQ_UNBOUND workqueue will avoid using isolated CPUs, but not a
>> WQ_CPU_INTENSIVE workqueue.
> Got it, thanks!
>
> I have picked the patch for further review and testing [1]
>
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/log/?h=next

Thanks, let me know if you see any problem.

Cheers,
Longman


