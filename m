Return-Path: <linux-kernel+bounces-254621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 837EB93358F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46B31C21D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 03:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EAF6FCC;
	Wed, 17 Jul 2024 03:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1EYJ7Wt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C2B3C00
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721185252; cv=none; b=Ma5O/MaiOI5+YZacNJZYFNH5vXbGc/cofzy3ojyXk7ie8rxUA2d1a7i9HMJgilKdxxB6SVZJR+Zmz92S+ePznTXHVfDg+6qeRMQ6os+j4pBd7e4Nv6k9vXJ0/NAupYvDoS1JtUtfo+pn59UXTa8QX75ykK6DueA62uAZ4WehTr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721185252; c=relaxed/simple;
	bh=cQ5233xOzUs1cEnLWD5BkcP66jU3nnLpHaurtW/kg5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tb19QwcBOAzSynr4R7OVZDzukNdOISz4UIEdc/D87wlxd4TfBOkKikm9kFeJnZ7RDLFIJGqmDhG2LZzPC3XSRUKjxKI57dcRroaws4Aw66SOt+HVCleP0EbsJbA86+NsFEcD4FpTR4uDQ0WwsuYPrgk2DwTb2Vr1us1lR/GI9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z1EYJ7Wt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721185250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azJ33/H5zwxD3RGrWtXQAc8hehxfq2WWZbzzVI9AlkM=;
	b=Z1EYJ7WtNp5wBqO/BKAPBhhlHmCZvnRskRihMiyFVetJ9ufNilobnt2Z2MKovpaVyO5Bk/
	NO0rdckD2eSLss0oZCv9UVGoB8R+QWySBgabUHf5VNcY+DCO58JEf34NDhfupUycUBdbs+
	iG+cs09GGMNGBcPZMOs713RL3h+4Jl4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-MA57ON2wMPuVgbDFGpzJqA-1; Tue,
 16 Jul 2024 23:00:44 -0400
X-MC-Unique: MA57ON2wMPuVgbDFGpzJqA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26CCF1956095;
	Wed, 17 Jul 2024 03:00:42 +0000 (UTC)
Received: from [10.22.32.24] (unknown [10.22.32.24])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7AA231955F40;
	Wed, 17 Jul 2024 03:00:39 +0000 (UTC)
Message-ID: <623e62c5-3045-4dca-9f2c-ed15b8d3bad8@redhat.com>
Date: Tue, 16 Jul 2024 23:00:38 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Yosry Ahmed <yosryahmed@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev,
 hannes@cmpxchg.org, lizefan.x@bytedance.com, kernel-team@cloudflare.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org>
 <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 7/16/24 20:35, Yosry Ahmed wrote:
> [..]
>>
>> This is a clean (meaning no cadvisor interference) example of kswapd
>> starting simultaniously on many NUMA nodes, that in 27 out of 98 cases
>> hit the race (which is handled in V6 and V7).
>>
>> The BPF "cnt" maps are getting cleared every second, so this
>> approximates per sec numbers.  This patch reduce pressure on the lock,
>> but we are still seeing (kfunc:vmlinux:cgroup_rstat_flush_locked) full
>> flushes approx 37 per sec (every 27 ms). On the positive side
>> ongoing_flusher mitigation stopped 98 per sec of these.
>>
>> In this clean kswapd case the patch removes the lock contention issue
>> for kswapd. The lock_contended cases 27 seems to be all related to
>> handled_race cases 27.
>>
>> The remaning high flush rate should also be addressed, and we should
>> also work on aproaches to limit this like my ealier proposal[1].
> I honestly don't think a high number of flushes is a problem on its
> own as long as we are not spending too much time flushing, especially
> when we have magnitude-based thresholding so we know there is
> something to flush (although it may not be relevant to what we are
> doing).
>
> If we keep observing a lot of lock contention, one thing that I
> thought about is to have a variant of spin_lock with a timeout. This
> limits the flushing latency, instead of limiting the number of flushes
> (which I believe is the wrong metric to optimize).

Except for semaphore, none of our locking primitives allow for a timeout 
parameter. For sleeping locks, I don't think it is hard to add variants 
with timeout parameter, but not the spinning locks.

Cheers,
Longman


