Return-Path: <linux-kernel+bounces-310534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7320B967DFC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 05:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB042823D2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 03:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D36374C4;
	Mon,  2 Sep 2024 03:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWxj1ax9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C741D79C0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725246032; cv=none; b=Nz43R8nyrDedW+4yyTykCNIXjOLBzH7b6Bq3bQiB9NZwxeV7jhbxeUNUVPcxgUZ75rjRyqPdhGNso8xH/TznyvOINyi/I5Ic+p5Wyu1tp9ixIqvY3N+Rr1mN6tBLvQ8ON4LuXxRQZQroAUMELLxI7BDTtrcoXLmjnK2hpT8TmHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725246032; c=relaxed/simple;
	bh=yoDqWgMOr7pVVms5BtuNbWKIRetsSsNQlSf0TCPoEJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6h+gCs9/PjtW3QE/PSogzWV9d+89OG2opX/wjNDE5Esig7soQRMpYw+kc/5irU3TvVu3QMq4iuyOURs3yf/C/nLEMXSlevJFAJg6v2pF7xSTKdGNuK2OvnUP3fk0FsF9PPoUArUgzsASlT16zujduAqMn6ApNsSUkM9IN7N9R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWxj1ax9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725246029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bwatozFoRFqFdpEKQTT0ARySzNx2fnhl3VyblIZ4u6A=;
	b=gWxj1ax9dqPB1xVlnpizVEj7DU7i3op+//ViKQMD658ka14DySfAAH9UlUieERQRMdimhz
	vqWeLsmXEF2riqUiWxb63sNYzi/BAmF35mTFbrAMFdA7uBgkRUVFM3oB/Xg4RJhl15in0s
	w6RB6hRQFR3WqgalhIqTt0iD3p1Qq3U=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-dbYqf4VsP9qd9lXPJd2oaw-1; Sun,
 01 Sep 2024 23:00:24 -0400
X-MC-Unique: dbYqf4VsP9qd9lXPJd2oaw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C9B219560B7;
	Mon,  2 Sep 2024 03:00:22 +0000 (UTC)
Received: from [10.2.16.23] (unknown [10.2.16.23])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D4F919560A3;
	Mon,  2 Sep 2024 03:00:17 +0000 (UTC)
Message-ID: <cb3a3f3e-727a-4cbb-b4a8-f9469ed4f08d@redhat.com>
Date: Sun, 1 Sep 2024 23:00:16 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BQuestion=5D_Include_isolated_cpu_to_ensure_that_?=
 =?UTF-8?Q?tasks_are_not_scheduled_to_isolated_cpu=EF=BC=9F?=
To: zhengzucheng <zhengzucheng@huawei.com>, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, oleg@redhat.com,
 Frederic Weisbecker <frederic@kernel.org>, mingo@kernel.org,
 peterx@redhat.com, tj@kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20240725120315.212428-1-zhengzucheng@huawei.com>
 <3e68ccda-1606-9494-f57a-75be9668b83d@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <3e68ccda-1606-9494-f57a-75be9668b83d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 9/1/24 21:56, zhengzucheng wrote:
> In a cpuset subsystem, cpuset.cpus contains isolated cpu and 
> non-isolated cpu.
> Is there any way to ensure that the task runs only on the non-isolated 
> cpus?
> eg：
> isolcpus=1, cpusete.cpus=0-7. It is found that some tasks are 
> scheduled to cpu1.
>
> In addition, task run on isolated cpu cann't be scheduled to other cpu 
> in the future.

The best way is to avoid mixing isolated and scheduling CPUs in the same 
cpuset especially if you are using cgroup v1.

If you are using cgroup v2, one way to avoid the use of isolated CPUs is 
to put all of them into an isolated partition. This will ensure that 
those isolated CPUs won't be used even if they are put into the 
cpuset.cpus of other cpusets accidentally

Cheers,
Longman


