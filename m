Return-Path: <linux-kernel+bounces-180233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B7F8C6BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5311F23535
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4044E158D61;
	Wed, 15 May 2024 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRMdemJ9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1268E158A24
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715795511; cv=none; b=d3qc2NLbBaR/a32EnYodjb4DHl45iEQlu+b4yyMZXELyePrVo2R5bUOkebAP6bObTaFroYcjQPUF5wNGjUvC1x9Og0GG2wTkd6My7SRe4e/rzpc1OqxExGrRwJE8ieZ4LBjPPwP0K311fzYl016TW5/QMYZKsqp6qv2JWbq2AoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715795511; c=relaxed/simple;
	bh=rpJyHwPj75U5yJhb0iHm0cH8HZqi7oZYM4aRh7yf4eA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptHq8AN/jd6bHXr2urFEegOyKdfxxtzMvZSdeQtNwE0GP2wkb1UOS1aiwxhaCj89hq2SuNdi8OiKsgIoYdQN5DEo9mlNqwIB7QQOTzY8ZwIAz4CdszbI0EhHsYuc1eDrNIOPAkhae+DvGOqbecT7EbscKtmWODDi4GqAgXHyJ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRMdemJ9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715795508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHDwRLQMXKViJqBxui2sWgU6FvNiXKY1AhcnSoBsYMk=;
	b=KRMdemJ9bXarS1GStEu+CZEnczLP/hGmm77QMjGSND7a/dNmhyVZjjRv5QCBzZiXJahftd
	QF79r+5h71XI+0cGiQ3+Hk5KLf95Xk2on0XVCFP4hN4IG9u2grfLVkfmPm6TY32DWLAsGE
	dHZPTRx74Qgm2t+p2ilsLCLCivmxQdg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-54LJ7ZUwOgmIWFTKlNc18Q-1; Wed,
 15 May 2024 13:51:42 -0400
X-MC-Unique: 54LJ7ZUwOgmIWFTKlNc18Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B508F29AA393;
	Wed, 15 May 2024 17:51:41 +0000 (UTC)
Received: from [10.22.9.0] (unknown [10.22.9.0])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 716572026D68;
	Wed, 15 May 2024 17:51:41 +0000 (UTC)
Message-ID: <31cef5e2-cf6e-42df-a6d2-10ecd04e60d7@redhat.com>
Date: Wed, 15 May 2024 13:51:41 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cgroup io.stat propagation regression
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZkO6l/ODzadSgdhC@dschatzberg-fedora-PF3DHTBV>
 <3ed32279-904a-411d-91a4-a62f4ca2dde2@redhat.com>
 <11b8c1e4-45a7-4895-a1f3-6626744cee1e@redhat.com>
 <ZkToxDuKxSPEg5aP@dschatzberg-fedora-PF3DHTBV>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZkToxDuKxSPEg5aP@dschatzberg-fedora-PF3DHTBV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 5/15/24 12:54, Dan Schatzberg wrote:
> On Wed, May 15, 2024 at 10:26:31AM -0400, Waiman Long wrote:
>> On 5/14/24 23:59, Waiman Long wrote:
>>> On 5/14/24 15:25, Dan Schatzberg wrote:
>>>> Hi Waiman,
>>>>
>>>> I've noticed that on recent kernels io.stat metrics don't propagate
>>>> all the way up the hierarchy. Specifically, io.stat metrics of some
>>>> leaf cgroup will be propagated to the parent, but not its grandparent.
>>>>
>>>> For a simple repro, run the following:
>>>>
>>>> systemd-run --slice test-test dd if=/dev/urandom of=/tmp/test
>>>> bs=4096 count=1
>>>>
>>>> Then:
>>>>
>>>> cat /sys/fs/cgroup/test.slice/test-test.slice/io.stat
>>>>
>>>> Shows the parent cgroup stats and I see wbytes=4096 but the
>>>> grandparent cgroup:
>>>>
>>>> cat /sys/fs/cgroup/test.slice/io.stat
>>>>
>>>> shows no writes.
>>>>
>>>> I believe this was caused by the change in "blk-cgroup: Optimize
>>>> blkcg_rstat_flush()". When blkcg_rstat_flush is called on the parent
>>>> cgroup, it exits early because the lockless list is empty since the
>>>> parent cgroup never issued writes itself (e.g. in
>>>> blk_cgroup_bio_start). However, in doing so it never propagated stats
>>>> to its parent.
>>>>
>>>> Can you confirm if my understanding of the logic here is correct and
>>>> advise on a fix?
>>> Yes, I believe your analysis is correct. Thanks for spotting this iostat
>>> propagation problem.
>>>
>>> I am working on a fix to address this problem and will post a patch once
>>> I have finished my testing.
>> Actually, I can only reproduce the issue with a 3-level
>> (child-parent-grandparent) cgroup hierarchy below the root cgroup. The dd
>> command is run test.slice/test-test.slice. So both test.slice/io.stat and
>> test.slice/test-test.slice/io.stat are properly updated.
> That's correct, this repros with a 3-level cgroup hierarchy (or
> more). systemd-run should create an ephemeral .scope cgroup under
> test-test.slice and then delete it when the dd command finishes. So
> test.slice/test-test.slice was the parent (2nd level) and test.slice
> is the grandparent.

OK, I didn't get the .scope sub-cgroup when I ran the above systemd-run 
command. Perhaps it's due to a difference in configuration. Anyway, I 
was able to reproduce the problem and devise the fix accordingly.

Thanks,
Longman


