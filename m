Return-Path: <linux-kernel+bounces-228877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8938E916810
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14752281C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24D01552EE;
	Tue, 25 Jun 2024 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdHjklqw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E86E149C7F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719319062; cv=none; b=u//9NQR7ShorTLUMYm0ZAE1gzpGVxr6l3rasskuRf9C/TeF38uQuO85IGmUiE7wQ0ODPPGgOabIzA6vVeWQoLKrzvZWrXF+8fE6NMsLNoupushuYFs+YHrKgUo60ZZCCox8dSlbjRDoTyFccSWg68YWWjd56E6ZWOxPvkoVdxdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719319062; c=relaxed/simple;
	bh=V2Koeg4s8w1gx/ttFDPvC6e07EmHfpCsysnLkTyaFt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMQ8+alYD73nv3pL4gN8rJ6C07LmcsVI1GgvUp76sOcRSsrhj52Pr08Hs7zAxUoC7gYR/hk7610F6ZhTZKVAG6A+DTqbepNbV1BfBLhpT7jpnRbM5/divzTQnr4T51Z+OLDT9l65LMe4+fc+IQmqC7pi1yz51f4Q8qBOP2e4qik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fdHjklqw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719319059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8y2n/ywazXiZ6X53dWXL/wMmY8kmaGnmAtAjUyCngTA=;
	b=fdHjklqwXLCqvZ9sLs0RVAZ1EgAshJSkigQCMAuOgRZGVT8yeTrNCcT1JAbk5JFwcJ2Y3S
	jMgLTlt8WetOs1suiMlx3MTwOa7j7ylblTvuZw+GPptdkH/RdVX9xrmCmm52KB/NWHjIbA
	Jv5DLKEJVapmNGk9mnyAOD/7+LkMwvg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-rFah1ZV_Om2ekDZmb-dj5w-1; Tue,
 25 Jun 2024 08:37:37 -0400
X-MC-Unique: rFah1ZV_Om2ekDZmb-dj5w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 723EA19560BF;
	Tue, 25 Jun 2024 12:37:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.198])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8F017300021A;
	Tue, 25 Jun 2024 12:37:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Jun 2024 14:36:02 +0200 (CEST)
Date: Tue, 25 Jun 2024 14:35:58 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/17] signal: In get_signal call do_exit when it is
 unnecessary to shoot down threads
Message-ID: <20240625123558.GC16836@redhat.com>
References: <20240609142342.GA11165@redhat.com>
 <87r0d5t2nt.fsf@email.froward.int.ebiederm.org>
 <20240610152902.GC20640@redhat.com>
 <20240613154541.GD18218@redhat.com>
 <87ikyamf4u.fsf@email.froward.int.ebiederm.org>
 <20240617183758.GB10753@redhat.com>
 <87iky5k2yi.fsf@email.froward.int.ebiederm.org>
 <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org>
 <871q4tinjq.fsf_-_@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q4tinjq.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 06/18, Eric W. Biederman wrote:
>
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1001,8 +1001,6 @@ do_group_exit(int exit_code)
>
>  	if (sig->flags & SIGNAL_GROUP_EXIT)
>  		exit_code = sig->group_exit_code;
> -	else if (sig->group_exec_task)
> -		exit_code = 0;

OK...

> @@ -1010,8 +1008,6 @@ do_group_exit(int exit_code)
>  		if (sig->flags & SIGNAL_GROUP_EXIT)
>  			/* Another thread got here before we took the lock.  */
>  			exit_code = sig->group_exit_code;
> -		else if (sig->group_exec_task)
> -			exit_code = 0;

Well... So with this change do_group_exit() always "wins" the race if it is
called when another thread has already started de_thread().

But de_thread() won't necessarily notice SIGKILL. Sure, the execing thread
can't return to user-space, but it can do a lot of things after de_thread().

Just for example, can it reach trace_sched_process_exec() ? If yes, then it
will look as if it exits with the exit_code provided by do_group_exit()
_after_ exec.

This differs from case when the execing thread is killed after de_thread(),
in this case exit_code = SIGKILL...

I do not see anything really wrong, just trying to understand the impact of
this change, it looks a bit subtle...

Oleg.


