Return-Path: <linux-kernel+bounces-224457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546E29122AC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768A31C239D3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F645171E68;
	Fri, 21 Jun 2024 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBx6KK4b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B58484D13
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966534; cv=none; b=Z5Ge2DHpFBGVkZcf7BTOF1AIzFj8GiuK5b7PsGHoj1C5fiqihYqkV5TVgOgzKjQikXkAZxtl8rmqCr8xceZmK2WNq872FXdDYEuKovWl5PZ+oM3YxpgXnKaV9SoewvY/RkotrWg0OthCIfZ/txgMR8mDt1A8lihR61k3iiZT5Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966534; c=relaxed/simple;
	bh=e0lneDv0XVfAsjpfwlrEeAiY6Nyn4oMTN19eMojpOwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMb2vlqCZDkuS6D94cHrdBfFfIcFebuxGN7rM3vuQsCNFjmIMyJU/maokUUVZx2KrU0xLYktfp5NYMo6f7EE3m8ug9kSYRoDEM+Lb0q44apL9/nHR5fUFVcVTvU5Fqn+21DprQkkckl9FcHVKPyfZapE3OghKNb/QSrfcSZverg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBx6KK4b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718966532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JvHPwnHmvUMWczmas1ZyeH5ED9yTS9wSm2/pLH+otv4=;
	b=fBx6KK4bSw7LA8aaFk8jY+vrDQpawPXevJ03q6mPCQgxF0XwAq1Xz+mWWWTYjdPSMdmHBw
	FPkONZ7uksxzbM1ft8mKqGB7MXFuYV6OF5yPH0IZDsQIca6VaPJ42X8O86T9yBxwt9lYj2
	q2YJKHq30Nq7vXi71zdTvFCxR3bfhEo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-dkxzKmu1MkyDinE017XUcw-1; Fri,
 21 Jun 2024 06:42:07 -0400
X-MC-Unique: dkxzKmu1MkyDinE017XUcw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97E5D1956086;
	Fri, 21 Jun 2024 10:42:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.114])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B2C411956087;
	Fri, 21 Jun 2024 10:42:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 21 Jun 2024 12:40:34 +0200 (CEST)
Date: Fri, 21 Jun 2024 12:40:32 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/17] signal: Make SIGKILL during coredumps an explicit
 special case
Message-ID: <20240621104031.GA12521@redhat.com>
References: <20240613154541.GD18218@redhat.com>
 <87ikyamf4u.fsf@email.froward.int.ebiederm.org>
 <20240617183758.GB10753@redhat.com>
 <87iky5k2yi.fsf@email.froward.int.ebiederm.org>
 <87o77xinmt.fsf_-_@email.froward.int.ebiederm.org>
 <87iky5inlv.fsf_-_@email.froward.int.ebiederm.org>
 <20240619155016.GC24240@redhat.com>
 <87cyocerda.fsf@email.froward.int.ebiederm.org>
 <20240619191105.GE24240@redhat.com>
 <874j9mdf14.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874j9mdf14.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Another case when I can hardly understand your reply...

This patch adds a minor user visible change, that was my point.

If you say that the new behaviour is better / more consistent -
I won't really argue, "I expect no one cares" below is probably
true. In my opinion group_exit_code = SIGKILL makes more sense
in this special case, but again, I won't insist.

But then this change should be mentioned and explained in the
changelog, agree?

As for "zap_threads that tests if SIGNAL_GROUP_EXIT is already set",
this is another thing but probably I misundertood you. It is not that
zap_threads/zap_process do not set ->group_exit_code in this case,
in this case do_coredump() will be aborted.

And to remind, zap_threads() used to set SIGNAL_GROUP_COREDUMP, not
SIGNAL_GROUP_EXIT. Because to me the coredumping process is not exiting
yet, it tries to handle the coredumping signal. That is why I prefer
group_exit_code = SIGKILL if it is killed during the dump. But this is
slightly offtopic today.

Oleg.

On 06/21, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > On 06/19, Eric W. Biederman wrote:
> >>
> >> Oleg Nesterov <oleg@redhat.com> writes:
> >>
> >> > Hi Eric,
> >> >
> >> > I'll _try_ to read this (nontrivial) changes this week. To be honest,
> >> > right now I don't really understand your goals after the quick glance...
> >> >
> >> > So far I have only looked at this simple 1/17 and it doesn't look right
> >> > to me.
> >>
> >> It might be worth applying them all on a branch and just looking at the
> >> end result.
> >
> > Perhaps. Say, the next 2/17 patch. I'd say it is very difficult to understand
> > the purpose unless you read the next patches. OK, at least the change log
> > mentions "in preparation".
> >
> >> > 	- complete_signal() won't be called, so signal->group_exit_code
> >> > 	  won't be updated.
> >> >
> >> > 	  coredump_finish() won't change it too so the process will exit
> >> > 	  with group_exit_code == signr /* coredumping signal */.
> >> >
> >> > 	  Yes, the fix is obvious and trivial...
> >>
> >> The signal handling from the coredump is arguably correct.  The process
> >> has already exited, and gotten an exit code.
> >
> > And zap_process() sets roup_exit_code = signr. But,
> >
> >> But I really don't care about the exit_code either way.  I just want to
> >> make ``killing'' a dead process while it core dumps independent of
> >> complete_signal.
> >>
> >> That ``killing'' of a dead process is a completely special case.
> >
> > Sorry I fail to understand...
> >
> > If the coredumping process is killed by SIGKILL, it should exit with
> > group_exit_code = SIGKILL, right? At least this is what we have now.
>
> In general when a fatal signal is sent:
> - It is short circuit delivered.
> - If SIGNAL_GROUP_EXIT is not set
>    SIGNAL_GROUP_EXIT is set
>    signal->group_exit_code is set
>
> Under those rules group_exit_code should not be updated.  Frankly no
> signals should even be processed (except to be queued) after a fatal
> signal comes in.
>
> There is an issue that short circuit delivery does not work on coredump
> signals (because of the way the coredump code works).  So it winds up
> being zap_threads that tests if SIGNAL_GROUP_EXIT is already set and
> zap_process that sets SIGNAL_GROUP_EXIT.  Essentially the logic remains
> the same, and importantly no later signal is able to set
> group_exit_code.  Or really have any effect because the signal sent was
> fatal.
>
> Except except except when the kernel in the context of the userspace
> process is writing a coredump for that userspace process.  Then we allow
> the kernel to be sent SIGKILL to stop it's coredumping activities
> because sometimes it can block indefinitely otherwise.
>
> Which is why I call handling that SIGKILL after a coredump has
> begun and SIGNAL_GROUP_EXIT is already set a completely special case.
>
> We might have to change group_exit_code to SIGKILL in that special case,
> if someone in userspace cares.  However I expect no one cares.
>
> Further if adding support for SIGKILL during a coredump were being added
> from scratch.  The semantics I would choose would be for that SIGKILL
> and indeed all of the coredumping activity would be invisible to
> userspace except for the delay to make it happen.  Otherwise a coredump
> which every occasionally gets it's return code changed could introduce
> heisenbugs.
>
> But none of this is documented in the change description and at a bare
> minimum this change of behavior should be before such code is merged.
>
> Eric
>


