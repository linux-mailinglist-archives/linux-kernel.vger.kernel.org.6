Return-Path: <linux-kernel+bounces-276663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6E79496AF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8801C229F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A0C59155;
	Tue,  6 Aug 2024 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsbJegVB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A08453E24
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965147; cv=none; b=GCHgSW7wm+XtSnRfcUSmrsjhsedlDAVGyAwiMDldL0yjbSglema9kewZXVYZG6nj/LOVSoyEaz0nFjXZyWIrVD1tzOLa8P/17catlY1/rr1ZQ6nDGkvuWT10L5V2ouQ1vZuzcBd/5CcPPGQ98wvW0DXWaK2R9i0FTYOL432bMVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965147; c=relaxed/simple;
	bh=rwF7zEYBr1cCawdnogP3aKnAgnE27YD8P1dhMskhzIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKjFzMDsPJYGz56zKxTi/pKknH2KVkQNhfDfksAv/0oNxhYtUtcGDjzF73O+utnf3nFoiN1nUJ5zemTKRDvAS0TYdZamaGjgDlxF+vSMa6cjU7wWQMlQGOaf2KknEQk5fEkJR5qZzCT0DKWPv6k1T5SUVLa8Zgt9tmEV0OibBjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BsbJegVB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722965144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3QrFC/2gKkg0zTzsJSyXYftIHvsny08W2eAJL61Pv6A=;
	b=BsbJegVBgVgkUMtUXqKlZbltk/B/3Y9+T2EXxyl7NpDHU9ZE4nYCOvLce3c9VrFceG4Psj
	VC4ZABj0NXYx02m3oMmXBRm5xC8LEG4LKkKuW/7Cih6X92YOoZR/gWtI28HNQH5S6Nbzi9
	2qJ2Y7ou0QoD/Jdg6x5fwCiF4t60lBo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-vN1vuqx9OzGAVHK44an-ew-1; Tue,
 06 Aug 2024 13:25:42 -0400
X-MC-Unique: vN1vuqx9OzGAVHK44an-ew-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40F501956080;
	Tue,  6 Aug 2024 17:25:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.155])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id ABE3619560AE;
	Tue,  6 Aug 2024 17:25:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  6 Aug 2024 19:25:36 +0200 (CEST)
Date: Tue, 6 Aug 2024 19:25:29 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprobes: Improve scalability by reducing the contention
 on siglock
Message-ID: <20240806172529.GC20881@redhat.com>
References: <20240801082407.1618451-1-liaochang1@huawei.com>
 <20240801140639.GE4038@redhat.com>
 <51a756b7-3c2f-9aeb-1418-b38b74108ee6@huawei.com>
 <20240802092406.GC12343@redhat.com>
 <0c69ef28-26d8-4b6e-fa78-2211a7b84eca@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c69ef28-26d8-4b6e-fa78-2211a7b84eca@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/06, Liao, Chang wrote:
>
> You're absolutely right. handle_signlestep() has chance to handle _DENY_SIGANL
> unless it followed by setting TIF_UPROBE in uprobe_deny_signal(). This means
> _DENY_SIGNAL is likey replaced during next uprobe single-stepping.
>
> I believe introducing _DENY_SIGNAL as the immediate state between UTASK_SSTEP
> and UTASK_SSTEP_ACK is still necessary. This allow uprobe_post_sstep_notifier()
> to correctly restore TIF_SIGPENDING upon the completion of single-step.
>
> A revised implementation would look like this:

Still looks "obviously wrong" to me... even the approach itself.

Perhaps I am wrong, yet another day when I can't even read emails on lkml
carefully, sorry.

But can you please send the patch which I could actually apply? This one
looks white-space damaged...

I'll try to reply with more details as soon I convince myself I fully
understand what does your patch actually do, but most probably not tomorrow.

Thanks,

Oleg.

> ------------------%<------------------
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1980,6 +1980,7 @@ bool uprobe_deny_signal(void)
> 
>         if (task_sigpending(t)) {
>                 clear_tsk_thread_flag(t, TIF_SIGPENDING);
> +               utask->state = UTASK_SSTEP_DENY_SIGNAL;
> 
>                 if (__fatal_signal_pending(t) || arch_uprobe_xol_was_trapped(t)) {
>                         utask->state = UTASK_SSTEP_TRAPPED;
> @@ -2276,22 +2277,23 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
>         int err = 0;
> 
>         uprobe = utask->active_uprobe;
> -       if (utask->state == UTASK_SSTEP_ACK)
> +       switch (utask->state) {
> +       case UTASK_SSTEP_ACK:
>                 err = arch_uprobe_post_xol(&uprobe->arch, regs);
> -       else if (utask->state == UTASK_SSTEP_TRAPPED)
> +               break;
> +       case UTASK_SSTEP_TRAPPED:
>                 arch_uprobe_abort_xol(&uprobe->arch, regs);
> -       else
> +               set_thread_flag(TIF_SIGPENDING);
> +               break;
> +       default:
>                 WARN_ON_ONCE(1);
> +       }
> 
>         put_uprobe(uprobe);
>         utask->active_uprobe = NULL;
>         utask->state = UTASK_RUNNING;
>         xol_free_insn_slot(current);
> 
> -       spin_lock_irq(&current->sighand->siglock);
> -       recalc_sigpending(); /* see uprobe_deny_signal() */
> -       spin_unlock_irq(&current->sighand->siglock);
> -
>         if (unlikely(err)) {
>                 uprobe_warn(current, "execute the probed insn, sending SIGILL.");
>                 force_sig(SIGILL);
> @@ -2351,6 +2353,8 @@ int uprobe_post_sstep_notifier(struct pt_regs *regs)
>                 /* task is currently not uprobed */
>                 return 0;
> 
> +       if (utask->state == UTASK_SSTEP_DENY_SIGNAL)
> +               set_thread_flag(TIF_SIGPENDING);
>         utask->state = UTASK_SSTEP_ACK;
>         set_thread_flag(TIF_UPROBE);
>         return 1;
> 
> ------------------>%------------------
> 
> > 
> > Oleg.
> > 
> > 
> 
> -- 
> BR
> Liao, Chang
> 


