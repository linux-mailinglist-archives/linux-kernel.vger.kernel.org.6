Return-Path: <linux-kernel+bounces-262254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 334DB93C316
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654B41C21642
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136EB1993B4;
	Thu, 25 Jul 2024 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHlJ3PUD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE2219AD8A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721914293; cv=none; b=a03ZnREcLmR8o/BrH8aUCDoBQ8LogOscIFICO+KMM0E17IdTaEa0rOwmfMaN+lLriR2ApLPRMDn20pBs7ZgWE1XMTVPQnXBwnD3RWroZZ7WyIAGo5nWmYyPRzUUyXG0jyWQMnZFx8s6sYx2NkHDMzY6FUxrib9RI1rHgf9T4SDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721914293; c=relaxed/simple;
	bh=JWhWEtEvT80oFXyMfRnA4TZ5LOLZsHV2XaD8HK7VlI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikSf+PVkC4bvLS0jBMdjsPvhMwB0vhFR9wI4Dpe2RfWwjKCxg1//5rZN27RMMSJggISBNa1/UjAgoJMpMTXCIBhzwKNf7bg7u0WV7NFIcnRoygepsX4otUBIMMN+lTBl2Jj8yCF+QKkddWH+mUnJ3wdoOId6vAOhAB8CEAEaNGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHlJ3PUD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721914290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k4s9mKj9STWyCGXDNhdbpDBMnK5esXa24tNVCjpHN98=;
	b=NHlJ3PUD3kTqfFvhTKomWvCnBLo9sTiEghKGVn6I4kwpdPmKN+XO4muvBY+HQzPhPYSUqJ
	lqeBgzf9Gfk93u8+XjbWPgrmM3Gb91b2EHfxClH2LGXd+v4qi9dUAvQx2nkVEVDlZCCd7z
	WdgxZTRFlUjpwjKJTlozaUDT2V+EO+c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-oDfnua1QPuur8lU8d8U0yQ-1; Thu,
 25 Jul 2024 09:31:24 -0400
X-MC-Unique: oDfnua1QPuur8lU8d8U0yQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 520701955BF4;
	Thu, 25 Jul 2024 13:31:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.93])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9BDE2195605A;
	Thu, 25 Jul 2024 13:31:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 25 Jul 2024 15:29:40 +0200 (CEST)
Date: Thu, 25 Jul 2024 15:29:35 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk, brauner@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, clm@fb.com,
	riel@surriel.com, ffledgling@meta.com
Subject: Re: [PATCH RFC exit] Sleep at TASK_IDLE when waiting for application
 core dump
Message-ID: <20240725132849.GA6602@redhat.com>
References: <1936bd18-775b-43e3-bfd5-2cd343565f06@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1936bd18-775b-43e3-bfd5-2cd343565f06@paulmck-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 07/24, Paul E. McKenney wrote:
>
> Currently, the coredump_task_exit() function sets the task state to
> TASK_UNINTERRUPTIBLE|TASK_FREEZABLE, which usually works well.  But a
> combination of large memory and slow (and/or highly contended) mass
> storage can cause application core dumps to take more than two minutes,
> which can triggers "task blocked" splats.

Do you mean check_hung_uninterruptible_tasks() ?

In any case,

> Therefore, change that TASK_UNINTERRUPTIBLE to TASK_IDLE.
...
> @@ -429,7 +429,7 @@ static void coredump_task_exit(struct task_struct *tsk)
>  			complete(&core_state->startup);
>
>  		for (;;) {
> -			set_current_state(TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
> +			set_current_state(TASK_IDLE|TASK_FREEZABLE);

To me this change makes sense regardless...

To some degree TASK_UNINTERRUPTIBLE is misleading, in that the task which
sleeps in coredump_task_exit() is _KILLABLE, although not "directly".

A SIGKILL sent to the coredumping process will interrupt the coredumping thread
(see the signal->core_state check in prepare_signal() and fatal_signal_pending()
check in dump_interrupted()) and then this thread will wakeup the threads sleeping
in coredump_task_exit(), see coredump_finish().

Acked-by: Oleg Nesterov <oleg@redhat.com>


