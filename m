Return-Path: <linux-kernel+bounces-223165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2F3910ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8372867C2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884461BBBCB;
	Thu, 20 Jun 2024 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADrqJdUV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC9C1BB6BB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904724; cv=none; b=bQxisx40jSEWR7g7lUQL8ctwxtZRMBzWmONWESQSJyx1hxNT+5mQ5urubnloLJp/jiWN8EPj7i5vmZU9dajLyR1SK391/AQo8CziI4elD9YUwmx0sC/av60K+dVbuwA5pGHELFn6OKRukqs68U7oc5x60jrYfg73W4OXLfCtApY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904724; c=relaxed/simple;
	bh=W2QBZGQE5Ixc1JvG2LzlKWnr9tz5Z0WVFoEBw5MHiRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ugv3Dmej6teqvZAQhpaWQDmBhsKWjRe2grGDNOMOPGhbtH9Q0C3a2xFoAXBZiRlH0alNPJ+MwtmvRIeiwf3denyUipx+2AoBmAokzz3GKCXb6pP1okJDWABfZg3Rt4KaMmBIyR6rPi2taEBsj29Nvoa+50Oqd7Up18uDt+BhWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADrqJdUV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718904722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pbk4cgzT1VG7tOZDuYBYOA1Nhbg3doz5Ktn2A96vAeU=;
	b=ADrqJdUVAwpN9TDs2kBDuzqxCOTRSqqfIOiv5Bt3znx+fG6TjIcWeddR+TtWf8B5eUjzmA
	BWVhsRpm3WFFd732u8ABghsq98Kew7DlaKt45JpARv8K1jqsbE4w9bXlZD0nZWZSi+faEf
	U9cReB0u7yFl4XJUbPzCfoX4VAFOOPE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-nIihs8qsPvyqSOk7Jx1A5Q-1; Thu,
 20 Jun 2024 13:32:00 -0400
X-MC-Unique: nIihs8qsPvyqSOk7Jx1A5Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4A25195608C;
	Thu, 20 Jun 2024 17:31:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.39])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id F2CF9300022B;
	Thu, 20 Jun 2024 17:31:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 20 Jun 2024 19:30:25 +0200 (CEST)
Date: Thu, 20 Jun 2024 19:30:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: alexjlzheng@gmail.com, Michal Hocko <mhocko@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, axboe@kernel.dk,
	tandersen@netflix.com, willy@infradead.org, mjguzik@gmail.com,
	alexjlzheng@tencent.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: optimize the redundant loop of
 mm_update_next_owner()
Message-ID: <20240620172958.GA2058@redhat.com>
References: <20240620152744.4038983-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620152744.4038983-1-alexjlzheng@tencent.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Can't review, I forgot everything about mm_update_next_owner().
So I am sorry for the noise I am going to add, feel free to ignore.
Just in case, I see nothing wrong in this patch.

On 06/20, alexjlzheng@gmail.com wrote:
>
> When mm_update_next_owner() is racing with swapoff (try_to_unuse()) or /proc or
> ptrace or page migration (get_task_mm()), it is impossible to find an
> appropriate task_struct in the loop whose mm_struct is the same as the target
> mm_struct.
>
> If the above race condition is combined with the stress-ng-zombie and
> stress-ng-dup tests, such a long loop can easily cause a Hard Lockup in
> write_lock_irq() for tasklist_lock.
>
> Recognize this situation in advance and exit early.

But this patch won't help if (say) ptrace_access_vm() sleeps while
for_each_process() tries to find another owner, right?

> @@ -484,6 +484,8 @@ void mm_update_next_owner(struct mm_struct *mm)
>  	 * Search through everything else, we should not get here often.
>  	 */
>  	for_each_process(g) {
> +		if (atomic_read(&mm->mm_users) <= 1)
> +			break;

I think this deserves a comment to explain that this is optimization
for the case we race with the pending mmput(). mm_update_next_owner()
checks mm_users at the start.

And. Can we drop tasklist and use rcu_read_lock() before for_each_process?
Yes, this will probably need more changes even if possible...


Or even better. Can't we finally kill mm_update_next_owner() and turn the
ugly mm->owner into mm->mem_cgroup ?

Michal, Eric, iirc you had the patch(es) which do this?

Oleg.


