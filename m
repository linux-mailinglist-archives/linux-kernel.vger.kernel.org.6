Return-Path: <linux-kernel+bounces-179385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84038C5F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0689728154B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4016C3838A;
	Wed, 15 May 2024 04:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQtvvyHV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AD837708
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715745610; cv=none; b=MFAKxnh7EvrLoKEjRh/1ANAzmnwVNrm8eaFG4VbPfaGMZ7qswGWTkJ1XImYBtUt9kP5T2uuESAvBuzs7Ln/RVbMHv/O0D3FaTI51H1qVlWVBssAvRDt07cKrcsPDWrARUIZxARVTdEqKUsLtCMONc5ANv0ym9vnUScRd92irhcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715745610; c=relaxed/simple;
	bh=FS8BxcGOh1QyUsPCb/Z1Pw2aO5KhRVPLl/8FppUGhgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMrmy8dFoAw77vV3E5tkQeichg6CAppjEdrJFriPmUNORqM6xik/iBD0vfZtObY6OB0Qvkxgy7I5stkNrPnVqlmCcepPFQuaZjBqefovukgZZM2VTszVnXjoWEM1wZyDEDbuq7jRPdVK7S+2Xms9ME1h7GSrjwx2Kzu7yhV6j64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQtvvyHV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715745607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rfxw+vb/eMFY8ya0z6a2BGMJqEE78GiWToX1LII8WvU=;
	b=UQtvvyHVa9VPU6Znd/Nq0+bqLcejy4AWqGxXiZODaa/oQMCfU+UAi4IOws+cXDyUzqD149
	geanEeGeNY0k5q+VReZEjJARjfifO8yiLlCYnFVpIb0W6HJINmcLcQrx8Uy0E/QY6fQGei
	pC73lF+hoM9vxNHF0Z3/G2qugeSGIXs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-9owWtM1FNJSMY9rCzR2n2w-1; Tue,
 14 May 2024 23:59:56 -0400
X-MC-Unique: 9owWtM1FNJSMY9rCzR2n2w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 298621C4C380;
	Wed, 15 May 2024 03:59:56 +0000 (UTC)
Received: from [10.22.8.47] (unknown [10.22.8.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D22FF3C27;
	Wed, 15 May 2024 03:59:55 +0000 (UTC)
Message-ID: <3ed32279-904a-411d-91a4-a62f4ca2dde2@redhat.com>
Date: Tue, 14 May 2024 23:59:55 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cgroup io.stat propagation regression
To: Dan Schatzberg <schatzberg.dan@gmail.com>, Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZkO6l/ODzadSgdhC@dschatzberg-fedora-PF3DHTBV>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZkO6l/ODzadSgdhC@dschatzberg-fedora-PF3DHTBV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 5/14/24 15:25, Dan Schatzberg wrote:
> Hi Waiman,
>
> I've noticed that on recent kernels io.stat metrics don't propagate
> all the way up the hierarchy. Specifically, io.stat metrics of some
> leaf cgroup will be propagated to the parent, but not its grandparent.
>
> For a simple repro, run the following:
>
> systemd-run --slice test-test dd if=/dev/urandom of=/tmp/test bs=4096 count=1
>
> Then:
>
> cat /sys/fs/cgroup/test.slice/test-test.slice/io.stat
>
> Shows the parent cgroup stats and I see wbytes=4096 but the grandparent cgroup:
>
> cat /sys/fs/cgroup/test.slice/io.stat
>
> shows no writes.
>
> I believe this was caused by the change in "blk-cgroup: Optimize
> blkcg_rstat_flush()". When blkcg_rstat_flush is called on the parent
> cgroup, it exits early because the lockless list is empty since the
> parent cgroup never issued writes itself (e.g. in
> blk_cgroup_bio_start). However, in doing so it never propagated stats
> to its parent.
>
> Can you confirm if my understanding of the logic here is correct and
> advise on a fix?

Yes, I believe your analysis is correct. Thanks for spotting this iostat 
propagation problem.

I am working on a fix to address this problem and will post a patch once 
I have finished my testing.

Thanks,
Longman


