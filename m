Return-Path: <linux-kernel+bounces-179995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C1D8C68A1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A241C21C84
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0791D13FD8C;
	Wed, 15 May 2024 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFBIA5Ip"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E805A13FD63
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715783217; cv=none; b=gXdUXJT/T0DPs3uTZx87f4fuQmOFJ/Q9lE7S123fofu6+OMpNP37se5lpHNith0C95vxXDFMTSLHaiNEO+3hUW0JgV19rbPIlY4p6gWZglwIVbgqkpDIiP9aG55JYp9DbxI7PvD9yTwiIwJNjbATAyfkwjeVPdjEGjN6mciXG3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715783217; c=relaxed/simple;
	bh=3/kkrVAGWdyljIyHay2GaPkAwneBSvii/bd21+FNYVI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cMNIkpcVF6KxKzIGMsUq5Wih816CMcCWRw8r1ZvY2R/WGys4X9CNVa1BwSx19YLxf45UfDO3cFV2qgDUcFIR0pbhEqxeeB3q0QEj2ze1fPuO1nUaY9i9EjRrxg2ohFk2VNQcPih13vLvO0Qdgh4uzdXy5lcQdB+mc3qS6SFGsx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFBIA5Ip; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715783214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dr9mNswvcvBd9WqlAZgQGwBLXCaYq7xTM96/AZTgX+A=;
	b=CFBIA5IpuMKFC3hoT8whw9jfEFZRy2NddSELjLPzsidnB0ArIizHlOIsaQUtbqEMnZ77Vl
	QVTm/Ci/F+CTfxagcqrgZYmv4/AenvvWNWvBUbXTRXL5Qqf+5BXtHUzVVDR7T2u7JE+a9K
	uxKDGqQzynLjneGwWSlFo4+GAet3ahE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-IMkfSYF_MDGVrIvfYLsGcw-1; Wed, 15 May 2024 10:26:34 -0400
X-MC-Unique: IMkfSYF_MDGVrIvfYLsGcw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5501585A58C;
	Wed, 15 May 2024 14:26:32 +0000 (UTC)
Received: from [10.22.33.50] (unknown [10.22.33.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 15ACC28AA;
	Wed, 15 May 2024 14:26:32 +0000 (UTC)
Message-ID: <11b8c1e4-45a7-4895-a1f3-6626744cee1e@redhat.com>
Date: Wed, 15 May 2024 10:26:31 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cgroup io.stat propagation regression
From: Waiman Long <longman@redhat.com>
To: Dan Schatzberg <schatzberg.dan@gmail.com>, Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZkO6l/ODzadSgdhC@dschatzberg-fedora-PF3DHTBV>
 <3ed32279-904a-411d-91a4-a62f4ca2dde2@redhat.com>
Content-Language: en-US
In-Reply-To: <3ed32279-904a-411d-91a4-a62f4ca2dde2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5


On 5/14/24 23:59, Waiman Long wrote:
> On 5/14/24 15:25, Dan Schatzberg wrote:
>> Hi Waiman,
>>
>> I've noticed that on recent kernels io.stat metrics don't propagate
>> all the way up the hierarchy. Specifically, io.stat metrics of some
>> leaf cgroup will be propagated to the parent, but not its grandparent.
>>
>> For a simple repro, run the following:
>>
>> systemd-run --slice test-test dd if=/dev/urandom of=/tmp/test bs=4096 
>> count=1
>>
>> Then:
>>
>> cat /sys/fs/cgroup/test.slice/test-test.slice/io.stat
>>
>> Shows the parent cgroup stats and I see wbytes=4096 but the 
>> grandparent cgroup:
>>
>> cat /sys/fs/cgroup/test.slice/io.stat
>>
>> shows no writes.
>>
>> I believe this was caused by the change in "blk-cgroup: Optimize
>> blkcg_rstat_flush()". When blkcg_rstat_flush is called on the parent
>> cgroup, it exits early because the lockless list is empty since the
>> parent cgroup never issued writes itself (e.g. in
>> blk_cgroup_bio_start). However, in doing so it never propagated stats
>> to its parent.
>>
>> Can you confirm if my understanding of the logic here is correct and
>> advise on a fix?
>
> Yes, I believe your analysis is correct. Thanks for spotting this 
> iostat propagation problem.
>
> I am working on a fix to address this problem and will post a patch 
> once I have finished my testing.

Actually, I can only reproduce the issue with a 3-level 
(child-parent-grandparent) cgroup hierarchy below the root cgroup. The 
dd command is run test.slice/test-test.slice. So both test.slice/io.stat 
and test.slice/test-test.slice/io.stat are properly updated.

Cheers,
Longman


