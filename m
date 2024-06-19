Return-Path: <linux-kernel+bounces-221428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A7590F378
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D261C20F98
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C0D15A850;
	Wed, 19 Jun 2024 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGfT/ou1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6750C1534FD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812318; cv=none; b=ZbL5NSrMA9uJvr8O6JefPU/pym81tFuNhYdl+fK1hL1qXvx/N1UIBcOJbHOpY20VGX+YXTTn9qZAmCaJ50tEZg2r/GcZSp1y4px7W0T15ZxeTuP/8P1rkdc66ZpE9Zn/Mq96ZR6dZT/eOA7C9NLQQBBUKeh/+J7OBaTX2rjU9cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812318; c=relaxed/simple;
	bh=34RScb7gxw/Yp50N/EE+gfdXpQ3Dp+K6v1Va+Fk8o3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNK6DD6Is80ARKM8QhLamBegarXOoQaCUmh5if/xVWmTTXAqlI5vEiBJY23SrI1btwC3NZMSCbIPTCB+fZHs+K2zSoujtJHiPRYmKD4phOshO03/FnwHIjYpAWZbRLfPn0SC1kffdfnCwzE3Xh4O2p8Jhv03Uw0cR7KfziKsRTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SGfT/ou1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718812316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9JqI/LAuaUFgB9TLpPBaaCDWA4te0tvM+w4q/2+xqbU=;
	b=SGfT/ou1jWwMq8QMvLvZqV3I1sgCnU+F2s9Ply3AzvmpIhuG7p0wIHviEgRoJOMPytIwUD
	H0EuasVZQGOO3D6byyqqb5DQvojw0wR6Qrh0TrWOtDdaRf4Qb63q5v63TYl5mr2X3i9gnA
	LYMysSuTQSSZ9Eop7DBLWuqQNMxjqCM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-MsxMLdZaP2O5dZaxBDx9bw-1; Wed,
 19 Jun 2024 11:51:53 -0400
X-MC-Unique: MsxMLdZaP2O5dZaxBDx9bw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1EEA195608B;
	Wed, 19 Jun 2024 15:51:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.168])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8328119560AE;
	Wed, 19 Jun 2024 15:51:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 19 Jun 2024 17:50:20 +0200 (CEST)
Date: Wed, 19 Jun 2024 17:50:17 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/17] signal: Make SIGKILL during coredumps an explicit
 special case
Message-ID: <20240619155016.GC24240@redhat.com>
References: <20240609142342.GA11165@redhat.com>
 <87r0d5t2nt.fsf@email.froward.int.ebiederm.org>
 <20240610152902.GC20640@redhat.com>
 <20240613154541.GD18218@redhat.com>
 <87ikyamf4u.fsf@email.froward.int.ebiederm.org>
 <20240617183758.GB10753@redhat.com>
 <87iky5k2yi.fsf@email.froward.int.ebiederm.org>
 <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org>
 <87iky5inlv.fsf_-_@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iky5inlv.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Eric,

I'll _try_ to read this (nontrivial) changes this week. To be honest,
right now I don't really understand your goals after the quick glance...

So far I have only looked at this simple 1/17 and it doesn't look right
to me.

On 06/18, Eric W. Biederman wrote:
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -907,8 +907,12 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
>  	sigset_t flush;
>  
>  	if (signal->flags & SIGNAL_GROUP_EXIT) {
> -		if (signal->core_state)
> -			return sig == SIGKILL;
> +		if (signal->core_state && (sig == SIGKILL)) {
> +			struct task_struct *dumper =
> +				signal->core_state->dumper.task;
> +			sigaddset(&dumper->pending.signal, SIGKILL);
> +			signal_wake_up(dumper, 1);
> +		}

and after that it returns false so __send_signal_locked/send_sigqueue simply
return. This means:

	- the caller will wrongly report TRACE_SIGNAL_IGNORED

	- complete_signal() won't be called, so signal->group_exit_code
	  won't be updated.

	  coredump_finish() won't change it too so the process will exit
	  with group_exit_code == signr /* coredumping signal */.

	  Yes, the fix is obvious and trivial...

Oleg.


