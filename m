Return-Path: <linux-kernel+bounces-249278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F386292E935
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68BC9B21FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DD715E5D0;
	Thu, 11 Jul 2024 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VICHXETS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969401514ED
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720704070; cv=none; b=WtBi5OLIlW3uw6PsYijvTgwrk2cZjSuWbgOyST6aEqLxE6YCTRcx5dzZ6VRCbnZ+ePT3vu7IJKamLroIteZt+pg4LmUWIqDQBm3F1MtxjS7WMV2xFgxQR4liY85Kn86z8L/WYIUKSBfC8ZReFKKgt3ELPaf9CftJ6Wf3rgHsIWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720704070; c=relaxed/simple;
	bh=Uy9I9T/tN9JJUlWQ/p6H0LUGVt6skO0x/JqhCMzMy7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WycMeCGVnyJbTplDHC4NXY7iQ+ExV/lEcU/O0D+gl051vQx+9S2ftwukJvbHtOsXimwx8y223+GRJ9Y/I4Nd2Hzh8M3Q/BF/aNjyAFLq7NCyEkfxR8/zrrqdewGgnULPxOYipq9lwQ51/iOjt6QBw09uYXu6W5SdTGgcl/2+HZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VICHXETS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720704068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zCgO4S5Trmscfbn2cBjRYOQFsKPBWlxEUZ+TlU9yQ9Q=;
	b=VICHXETSQvJvNbg7/+ebFO0wez0tlbYT7jaYmbvDGGMrAODUJIlw8fRL8K4VQKbmwJprYx
	bVV6aH3e9tW4raV04p9zf2079QdncNKdf86d2oNSGlR51gCRJpY2WvgPCNq5DJNI6GTW0b
	FZTjDYWCRUR+MsDfjoYJuMOnYmyPcIE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-IDrcX-ZUOW-EIF2bPrWOaA-1; Thu,
 11 Jul 2024 09:21:03 -0400
X-MC-Unique: IDrcX-ZUOW-EIF2bPrWOaA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 306381955BC7;
	Thu, 11 Jul 2024 13:21:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.32])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 39A7019560AA;
	Thu, 11 Jul 2024 13:20:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 11 Jul 2024 15:19:24 +0200 (CEST)
Date: Thu, 11 Jul 2024 15:19:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com,
	paulmck@kernel.org
Subject: Re: [PATCH v2 11/11] perf/uprobe: Add uretprobe timer
Message-ID: <20240711131918.GC16902@redhat.com>
References: <20240711110235.098009979@infradead.org>
 <20240711110401.412779774@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711110401.412779774@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Not sure I read this patch correctly, but at first glance it looks
suspicious..

On 07/11, Peter Zijlstra wrote:
>
> +static void return_instance_timer(struct timer_list *timer)
> +{
> +	struct uprobe_task *utask = container_of(timer, struct uprobe_task, ri_timer);
> +	task_work_add(utask->task, &utask->ri_task_work, TWA_SIGNAL);
> +}

What if utask->task sleeps in TASK_STOPPED/TASK_TRACED state before
return from the ret-probed function?

In this case it won't react to TWA_SIGNAL until debugger or SIGCONT
wakes it up.

---------------------------------------------------------------------------
And it seems that even task_work_add() itself is not safe...

Suppose we have 2 ret-probed functions

	void f2() { ... }
	void f1() { ...; f2(); }

A task T calls f1(), hits the bp, and calls prepare_uretprobe() which does

	mod_timer(&utask->ri_timer, jiffies + HZ);

Then later it calls f2() and the pending timer expires after it enters the
kernel, but before the next prepare_uretprobe() -> mod_timer().

In this case ri_task_work is already queued and the timer is pending again.

Now. Even if T goes to the exit_to_user_mode_loop() path immediately, in
theory nothing can guarantee that it will call get_signal/task_work_run
in less than 1 second, it can be preempted.

But T can sleep in xol_take_insn_slot() before return from handle_swbp(),
and this is not so theoretical.

Oleg.


