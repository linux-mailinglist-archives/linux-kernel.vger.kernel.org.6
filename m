Return-Path: <linux-kernel+bounces-522387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A37A3C97C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51C287A775A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAF0EEAA;
	Wed, 19 Feb 2025 20:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFa6tZkX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF95A21B9D1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996305; cv=none; b=gwfNaV8cJtKL37lkaQ0uv5Cpm1FO6Zu2866nNOo38M7Z8ymUhTSmOrJpKABeFgSdcsBuyXUCmMkGvAJSnhHjtV2QVCv1sTX5L4IwlB7Emb5DtS5yUYSDaTWRtM/naHYreCg7gh8iNbhqNK/YBFBXC95x8LrFmIgKL+AaRhVe2/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996305; c=relaxed/simple;
	bh=htF0r6kx/S7tQY8cEb6K/3jw6UP23ugfC+8gBe9WF8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMpaqqE9z1mBBsT+3PkyIBWpKtO+saofUTuXJRMOqW7GRHBcprt3cJTRasDbOV4iS8JPNKvH1es2YVR0RhdW4UxALbx8oiWiaKWPGSP84DOOqvHoOLXsHSUcx9AvHCRj8UGHZVPKYSItpGnAwGOyGJ5C3LfW+PlM9pHcTStOIjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFa6tZkX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739996302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cly/NXz6wazzzBHR6ULlMjYuQlQdlZukgLVDG9F7dVo=;
	b=HFa6tZkXCdxQj7j7HRAfdfA/w1hKBim8MCtJ2Zjo0J3Y1JinNqMeDPYKM2W2W8mMObNk80
	fZ5bnU55d+QzQdfv/jo2axOT/q9oF10kMuvQDbKH/ypfQUPYPSjCf6CSespSrBwrW9UsGE
	Eef16V2TE8kEPSz9OfDHpQZ/ROkRab0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-WhEuTI77PvWpZ_bkU6GrGg-1; Wed,
 19 Feb 2025 15:18:16 -0500
X-MC-Unique: WhEuTI77PvWpZ_bkU6GrGg-1
X-Mimecast-MFC-AGG-ID: WhEuTI77PvWpZ_bkU6GrGg_1739996295
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC8CA19783B7;
	Wed, 19 Feb 2025 20:18:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.102])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 134401800359;
	Wed, 19 Feb 2025 20:18:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 19 Feb 2025 21:17:46 +0100 (CET)
Date: Wed, 19 Feb 2025 21:17:42 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] yama: don't abuse rcu_read_lock/get_task_struct in
 yama_task_prctl()
Message-ID: <20250219201742.GD5948@redhat.com>
References: <20250219161417.GA20851@redhat.com>
 <202502191125.1A6F07E@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502191125.1A6F07E@keescook>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 02/19, Kees Cook wrote:
>
> On Wed, Feb 19, 2025 at 05:14:17PM +0100, Oleg Nesterov wrote:
> > current->group_leader is stable, no need to take rcu_read_lock() and do
> > get/put_task_struct().
>
> Can you explain why this is true? In trying to figure this out again,
> it seems that the only way current->group_leader can vanish is if
> the entire process vanishes (fork or thread exec), in which case the
> "current" in this prctl can't be happening; this appears to be locked
> behind tsk->sighand->siglock ?

Well, almost, but this has nothing to do with tsk->sighand->siglock...

task->group_leader can only be changed by thread exec, when a non leader
thread does exec, see de_thread(). But de_thread() can't succeed and change
->group_leader until all other threads exit, see the "Kill all other threads
in the thread group" code in de_thread(). The "current" task can't exit, so
current->group_leader is stable.

Note also that we already have a lot of current->group_leader users which
don't use rcu/get_task_struct.

That said, we have a lot of buggy users of tsk->group_leader when
same_thread_group(tsk, current) != true ;) For example, sys_prlimit64().
And note that rcu_read_lock/get_task_struct can't help in this case.
I am going to send some fixes.

Oleg.

> 
> -Kees
> 
> > 
> > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> > ---
> >  security/yama/yama_lsm.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> > 
> > diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> > index 1971710620c1..3d064dd4e03f 100644
> > --- a/security/yama/yama_lsm.c
> > +++ b/security/yama/yama_lsm.c
> > @@ -222,7 +222,7 @@ static int yama_task_prctl(int option, unsigned long arg2, unsigned long arg3,
> >  			   unsigned long arg4, unsigned long arg5)
> >  {
> >  	int rc = -ENOSYS;
> > -	struct task_struct *myself = current;
> > +	struct task_struct *myself;
> >  
> >  	switch (option) {
> >  	case PR_SET_PTRACER:
> > @@ -232,11 +232,7 @@ static int yama_task_prctl(int option, unsigned long arg2, unsigned long arg3,
> >  		 * leader checking is handled later when walking the ancestry
> >  		 * at the time of PTRACE_ATTACH check.
> >  		 */
> > -		rcu_read_lock();
> > -		if (!thread_group_leader(myself))
> > -			myself = rcu_dereference(myself->group_leader);
> > -		get_task_struct(myself);
> > -		rcu_read_unlock();
> > +		myself = current->group_leader;
> >  
> >  		if (arg2 == 0) {
> >  			yama_ptracer_del(NULL, myself);
> > @@ -255,7 +251,6 @@ static int yama_task_prctl(int option, unsigned long arg2, unsigned long arg3,
> >  			}
> >  		}
> >  
> > -		put_task_struct(myself);
> >  		break;
> >  	}
> >  
> > -- 
> > 2.25.1.362.g51ebf55
> > 
> > 
> 
> -- 
> Kees Cook
> 


