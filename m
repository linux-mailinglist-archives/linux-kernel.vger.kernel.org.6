Return-Path: <linux-kernel+bounces-424340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B909A9DB337
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4958D282111
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 07:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6346F14884D;
	Thu, 28 Nov 2024 07:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U11FCHeB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA65146A97
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732779589; cv=none; b=RgqziZfoK9Blk5hCTRNez+0KS6hq3TuSOuow7h0D/jEm6kY4uYSK4Zut1yrIY4xxSEmOtjw60oIbSdW0COhmTD2MyOwhV3E1iQRM49U7zf4td5+7LVlB7MPkBaBBEG75K+Egmeps9hb9d+FPrBsrSppVGcHYTUGwheEjDO0Q5Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732779589; c=relaxed/simple;
	bh=ICYEO3JNczUhVC9alnJmPCUhwkDUucrvPD7zkciKRwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7TvNGSdG0X5Noy6xMYUkO0PpdPrp2U/9Ozy0Jv08/BQEfrxPPVmvRsB4kH5kYZ8Oh1M+y+Nnz0oLNn5F4mukMi65Bc8HmHdLvLAwGztpunr0NwG9jIFqlB6rxnP1e531N5reOXdU986h41fllVNFB+A/Oss3JgnN6OMTrpLYgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U11FCHeB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732779586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+uhfZe6W1m5ISyn1DShF0ivc69FPD+Nahb2/s2sCS+8=;
	b=U11FCHeBrKpo2qNhWt9PpzhYayBylRm0gIgUXpMEp6lN8wwLTgWt4o8ZEisxGSmcg8uIgP
	pu/xFbdWi9rRUvFXIteOXSVusHZon4zH0NmrWLOHABaUBgDQa3AXgRvsjwy6y8cObuJuof
	uKXg+MQIvh2JlTuMMsatj526UUtnd0w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-H8mPa4bbNNStGSYUw_PuZg-1; Thu,
 28 Nov 2024 02:39:43 -0500
X-MC-Unique: H8mPa4bbNNStGSYUw_PuZg-1
X-Mimecast-MFC-AGG-ID: H8mPa4bbNNStGSYUw_PuZg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F34B1956095;
	Thu, 28 Nov 2024 07:39:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.112])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C339D195605A;
	Thu, 28 Nov 2024 07:39:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 28 Nov 2024 08:39:16 +0100 (CET)
Date: Thu, 28 Nov 2024 08:39:11 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zhen Ni <zhen.ni@easystack.cn>, viro@zeniv.linux.org.uk,
	catalin.marinas@arm.com, brauner@kernel.org, zev@bewilderbeest.net,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] kernel/sys: Optimize do_prlimit lock scope to reduce
 contention
Message-ID: <20241128073911.GB10998@redhat.com>
References: <20241120132156.207250-1-zhen.ni@easystack.cn>
 <20241127174536.752def18058e84487ab9ad65@linux-foundation.org>
 <20241128071351.GA10998@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128071351.GA10998@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 11/28, Oleg Nesterov wrote:
>
> The problem is that task_lock(tsk->group_leader) doesn't look right with or
> without this patch. I'll try to make a fix on weekend.
>
> If the caller is sys_prlimit64() and tsk != current, then ->group_leader is
> not stable, do_prlimit() can race with mt exec and take the wrong lock.

... and task_unlock(tsk->group_leader) is simply unsafe.

perhaps something like below, but it doesn't look nice, I'll try to think
more. And grep, may be there are more lockless users of tsk->group_leader
when tsk != current.

Oleg.

--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1464,6 +1464,7 @@ SYSCALL_DEFINE2(setdomainname, char __user *, name, int, len)
 static int do_prlimit(struct task_struct *tsk, unsigned int resource,
 		      struct rlimit *new_rlim, struct rlimit *old_rlim)
 {
+	struct task_struct *leader;
 	struct rlimit *rlim;
 	int retval = 0;
 
@@ -1481,7 +1482,14 @@ static int do_prlimit(struct task_struct *tsk, unsigned int resource,
 
 	/* Holding a refcount on tsk protects tsk->signal from disappearing. */
 	rlim = tsk->signal->rlim + resource;
-	task_lock(tsk->group_leader);
+
+	if (tsk != current)
+		read_lock(&tasklist_lock);
+	leader = READ_ONCE(tsk->group_leader);
+	task_lock(leader);
+	if (tsk != current)
+		read_unlock(&tasklist_lock);
+
 	if (new_rlim) {
 		/*
 		 * Keep the capable check against init_user_ns until cgroups can
@@ -1499,7 +1507,7 @@ static int do_prlimit(struct task_struct *tsk, unsigned int resource,
 		if (new_rlim)
 			*rlim = *new_rlim;
 	}
-	task_unlock(tsk->group_leader);
+	task_unlock(leader);
 
 	/*
 	 * RLIMIT_CPU handling. Arm the posix CPU timer if the limit is not


