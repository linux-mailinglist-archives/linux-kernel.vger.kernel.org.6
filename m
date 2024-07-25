Return-Path: <linux-kernel+bounces-262472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD1693C77E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25872844CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCB319D892;
	Thu, 25 Jul 2024 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqHwgswH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399A426286
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926934; cv=none; b=MENir8W/QSV0AptKzSEnOsjnVJxF9TszlTiFyvfg+6hFKxPROnf4PebHU+5/3HGtOUicHktTOrLuNc18qnCQGQ1CSi6WGOV+wddgTrkPWCtU1CavEAmL01VgRqMO3ou7T1svGoTpBvfzHFJ5Wwnr+kmefQtmjHShN0qPEg77hZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926934; c=relaxed/simple;
	bh=kTokRip6+zG139kcI4R3CFeRyk8ffJ8yT6wEqIiNPgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWQaPhbbyMjX+mLZIaPk4HOHqC0iee0HHXkFO4BEgBOG4Id/ktmko465uwhRc5cI1/qH9AVYp3u+b8pUAfoQIMDwqM8+6AbrDF4vGAGytqtyxYbhy2QxzPGjGUhsKmuzwWDMK6yZP7VdDxBbC+iZD5vzug8NM615sSM2S5pUBuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DqHwgswH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721926932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBSxPgh64JOs+4ms35CG8zRXGEwO0ju9A2tPRKm0s4E=;
	b=DqHwgswHWw0j1dyJPfA/b8U2CJfOdnta4gDeZioWh13/ztmGs0lEDr3NdhmQHzDgxkTJ2k
	cneCUsW2VOp5mHkimKPhTSS9tNLbjn1LGEO3Z9RjTRU7MwcLBbOYJLBvdq3Q2Rbwki1/Bn
	J+anmLkqbA0i3jy6snk3aGY67e0L49M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-27ytda8vNNiDWsx6fWT4XQ-1; Thu,
 25 Jul 2024 13:02:10 -0400
X-MC-Unique: 27ytda8vNNiDWsx6fWT4XQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FE7F1955BF2;
	Thu, 25 Jul 2024 17:02:08 +0000 (UTC)
Received: from [10.2.16.78] (unknown [10.2.16.78])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8335D1955D42;
	Thu, 25 Jul 2024 17:02:03 +0000 (UTC)
Message-ID: <96aec91c-aa5c-4352-b93c-323b22011370@redhat.com>
Date: Thu, 25 Jul 2024 13:02:01 -0400
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
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240725153552.GA927762@neeraj.linux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 7/25/24 11:35, Neeraj Upadhyay wrote:
> On Tue, Jul 23, 2024 at 02:10:25PM -0400, Waiman Long wrote:
>> It was discovered that isolated CPUs could sometimes be disturbed by
>> kworkers processing kfree_rcu() works causing higher than expected
>> latency. It is because the RCU core uses "system_wq" which doesn't have
>> the WQ_UNBOUND flag to handle all its work items. Fix this violation of
>> latency limits by using "system_unbound_wq" in the RCU core instead.
>> This will ensure that those work items will not be run on CPUs marked
>> as isolated.
>>
> Alternative approach here could be, in case we want to keep per CPU worker
> pools, define a wq with WQ_CPU_INTENSIVE flag. Are there cases where
> WQ_CPU_INTENSIVE wq won't be sufficient for the problem this patch
> is fixing?

What exactly will we gain by defining a WQ_CPU_INTENSIVE workqueue? Or 
what will we lose by using system_unbound_wq? All the calls that are 
modified to use system_unbound_wq are using WORK_CPU_UNBOUND as their 
cpu. IOW, they doesn't care which CPUs are used to run the work items. 
The only downside I can see is the possible loss of some cache locality.

In fact, WQ_CPU_INTENSIVE can be considered a subset of WQ_UNBOUND. An 
WQ_UNBOUND workqueue will avoid using isolated CPUs, but not a 
WQ_CPU_INTENSIVE workqueue.

Cheers,
Longman



