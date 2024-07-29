Return-Path: <linux-kernel+bounces-265037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2501393EBC2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 05:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE9E281262
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F5C7E563;
	Mon, 29 Jul 2024 03:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ymv40tZL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE00762D7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 03:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722222419; cv=none; b=gxDduaneTqd1+15ju5LPgyCuu1zeTagrcLNJytgIZnKA4aqbU9cDcm64YmEIcVkcbjmugDGrSsLp6lFi1LRXBTtk3htjOlKt9HCTXhdAeqoEzKvtjaFsTe2k8b3MLxH3mx3J9vtN5patoKnE8MIpCWQq9veWBbYlacV1qmj53Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722222419; c=relaxed/simple;
	bh=VSu+Q6VDVMHczqzgavruOTErYzI9fPXtiuF5BFZeoYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HD1NwX+fx3wi0+266eFsjRPdCLUZAltKSiYd2V2ItHcrPauQllM+3MgpEVPq4Dc2D48aDMQM/KI9Udm0ffXl9b5JpyVtXrkBhMhot1FBE5Sva6apoLD4birTZ5Zc+YVWdywk84Lbl0GVBdEV6tNxrs3Cvsme1au9TwYv8+vejzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ymv40tZL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722222416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgW4F+8OnYfABRaUBkoY4QdpxE7k/jonJUbzCNjd0j0=;
	b=Ymv40tZLzsOO9P8/LW3spuLYwiSZKk1lq7rFiebp1BCNC+5Z1TvWxCfumHaOeV1l2MqZSU
	CkKTqkWr5kxhx1Aw8GaAcRhIpYUkUfrJsWkCprL92VQdLePoBWYswk80wJYfwBOj6ktTyl
	b6WW2aDvFo1dr+ZOhozFbDwzDkCHlLo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-dPfwVbksOBmIwo9Pzie6WQ-1; Sun,
 28 Jul 2024 23:06:51 -0400
X-MC-Unique: dPfwVbksOBmIwo9Pzie6WQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D53071955D45;
	Mon, 29 Jul 2024 03:06:48 +0000 (UTC)
Received: from [10.2.16.25] (unknown [10.2.16.25])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 953F619560AE;
	Mon, 29 Jul 2024 03:06:45 +0000 (UTC)
Message-ID: <1d011339-364b-42ce-9c7a-fc99f7be0e1c@redhat.com>
Date: Sun, 28 Jul 2024 23:06:44 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Use system_unbound_wq to avoid disturbing isolated
 CPUs
To: Breno Leitao <leitao@debian.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vratislav Bendel <vbendel@redhat.com>
References: <20240723181025.187413-1-longman@redhat.com>
 <ZqEB9Yz0womtmDRg@gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZqEB9Yz0womtmDRg@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 7/24/24 09:30, Breno Leitao wrote:
> On Tue, Jul 23, 2024 at 02:10:25PM -0400, Waiman Long wrote:
>> It was discovered that isolated CPUs could sometimes be disturbed by
>> kworkers processing kfree_rcu() works causing higher than expected
>> latency. It is because the RCU core uses "system_wq" which doesn't have
>> the WQ_UNBOUND flag to handle all its work items. Fix this violation of
>> latency limits by using "system_unbound_wq" in the RCU core instead.
>> This will ensure that those work items will not be run on CPUs marked
>> as isolated.
>>
>> Beside the WQ_UNBOUND flag, the other major difference between system_wq
>> and system_unbound_wq is their max_active count. The system_unbound_wq
>> has a max_active of WQ_MAX_ACTIVE (512) while system_wq's max_active
>> is WQ_DFL_ACTIVE (256) which is half of WQ_MAX_ACTIVE.
>>
>> Reported-by: Vratislav Bendel <vbendel@redhat.com>
> I've seen this problem a while ago and reported to the list:
>
> 	https://lore.kernel.org/all/Zp906X7VJGNKl5fW@gmail.com/
>
> I've just applied this test, and run my workload for 2 hours without
> hitting this issue. Thanks for solving it.
>
> Tested-by: Breno Leitao <leitao@debian.org>

Thank for testing this patch. So it is just us that saw this problem.

Cheers,
Longman


