Return-Path: <linux-kernel+bounces-213469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8283F9075B4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9890B1C240FA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CDE1411D6;
	Thu, 13 Jun 2024 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Racm8eZ+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE541B646
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290265; cv=none; b=Xjqm3oXP1saoThqeyTUoeSFBknnQbLi+c2klJduSdc/S/V6SPDk9pBQH1sntmkxTmjEXjwxkqM5O+Jxok6nIxBWw3K3GtxFOM2XZSuqfyIdJBknS16ELCo1h7ygRkFryHF0mXZSIqVlHVG1bFk/vwtC4YHzZiztghyDz5KP2Mhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290265; c=relaxed/simple;
	bh=Y0WoLZ5dKwSO1CNiA0o+3a8cM1lM7Z8l0lW7Mgayr54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZZChuGes8OGo/4tIqa8Zty9OZN9kh+67Dsq+RSUXXrh8sjBDsJKAKvy7d3wO8b5qDZHoE+CdgnWa+DoH0WD0/j0bz/pMB3ER4KgBczhB4Zyf5CjcQGkGdtTwQdf3RQ2/lqMcPZXdW9bzuOHBUnenCGeuT+pVvAZTqUa0fEJlAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Racm8eZ+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718290262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0WoLZ5dKwSO1CNiA0o+3a8cM1lM7Z8l0lW7Mgayr54=;
	b=Racm8eZ+LTuYGpK9hihgvG7enTEonFAoGw7ThPxDApJPEZxz8VKG6QRKxhQPD7JlnTYa+0
	zt9CveUh9yPHmAIOoUx6vKiTAKp1YF+Q6gtsFbe3IivQEaSIUEbK3m8Dy1+6ioi5Zd2AW7
	V6T6EZL49srdoJPkAd7WiP0caC1YwLQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-1jGJsdWNP2esv4ksrP1ypw-1; Thu,
 13 Jun 2024 10:50:59 -0400
X-MC-Unique: 1jGJsdWNP2esv4ksrP1ypw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D14C19560BE;
	Thu, 13 Jun 2024 14:50:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.233])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5DCE819560AF;
	Thu, 13 Jun 2024 14:50:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 13 Jun 2024 16:49:23 +0200 (CEST)
Date: Thu, 13 Jun 2024 16:49:13 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Wei Fu <fuweid89@gmail.com>
Cc: ebiederm@xmission.com, Sudhanva.Huruli@microsoft.com,
	akpm@linux-foundation.org, apais@linux.microsoft.com,
	axboe@kernel.dk, boqun.feng@gmail.com, brauner@kernel.org,
	frederic@kernel.org, j.granados@samsung.com, jiangshanlai@gmail.com,
	joel@joelfernandes.org, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	michael.christie@oracle.com, mjguzik@gmail.com,
	neeraj.upadhyay@kernel.org, paulmck@kernel.org,
	qiang.zhang1211@gmail.com, rachelmenge@linux.microsoft.com,
	rcu@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH] zap_pid_ns_processes: clear TIF_NOTIFY_SIGNAL along with
 TIF_SIGPENDING
Message-ID: <20240613144913.GA18218@redhat.com>
References: <87a5jpqamx.fsf@email.froward.int.ebiederm.org>
 <20240613140216.30327-1-fuweid89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613140216.30327-1-fuweid89@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 06/13, Wei Fu wrote:
>
> I think there is a case that TIF_NOTIFY_SIGNAL remains set.

[...snip...]

Of course! but please forget about io_uring even if currently io_uring/
is the only user of TWA_SIGNAL.

Just suppose that the exiting task/thread races with task_workd_add(TWA_SIGNAL),
TIF_NOTIFY_SIGNAL won't be cleared.

This is fine in that the exiting task T will do exit_task_work() and after that
task_work_add(T) can't succeed with or without TWA_SIGNAL. So it can't miss the
pending work.

But I think we can forget about TIF_NOTIFY_SIGNAL. To me, the problem is that
the state of signal_pending() of the exiting task was never clearly defined, and
I can't even recall how many times I mentioned this in the previous discussions.
TIF_NOTIFY_SIGNAL doesn't add more confusion, imo.

Oleg.


