Return-Path: <linux-kernel+bounces-283054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0384E94EC61
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B3D1F22D86
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B5C178CC3;
	Mon, 12 Aug 2024 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STxhfA3h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38BD178375
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464482; cv=none; b=tEPQUPi1CWf4ubtvmn2FkEEquSt/zXLefUQN9bTeRFJ1jAXd3AYlgSbQWsNUw0ZYDz59M5FPBuGQnyYCs92+5F9jBYsgQd6USFGzor743FwHRZf4YMFzWJriYw9y3DNWZ6D15gdaC7mwODT9lUtGfIiIA9f3+NaYNIXd2wJj6us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464482; c=relaxed/simple;
	bh=PMCWb/0PTWSgHvamdQF/W9znRp+UxNqupXxMMuexuYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnyXXzX4f5PySz2tu6bDI24/Giy1ZmmXV0JcHydIUMfdJY6eFN2Gxb3dEUidPcdU1GfLtl5Ndgwhqo6ygrNP48cOLdcRv/F3qsAoVLtIG8Ww2z+NQZzcgB8TS48rCzzFlAnEhl6wdtUVRzomkdJZAQzOhmlWED8IXo0FFHhrBDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=STxhfA3h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723464479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rtTF2UP57ajERZ/GXdvSw/ibPhg0GHZMEjMALltzG2Y=;
	b=STxhfA3hCOUOhYbf6CzHE1RxSS8tC3YNelU/gfl0fSXDoSuA7FsXkH+VdWLYgI9iOdNVf5
	vs/uoNXAlOPVXxHK87JCB0rjYBbCKtP+mXWl8WoqddEHqFFrCZJ1sj3sUpTaRIp+p7m8MJ
	2S2uAwucTSOsFHHN5Ro4D08V2F0DhAo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-y87KBRpZP2uxXyEPc3WXPQ-1; Mon,
 12 Aug 2024 08:07:53 -0400
X-MC-Unique: y87KBRpZP2uxXyEPc3WXPQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0851818EB22E;
	Mon, 12 Aug 2024 12:07:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.102])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A006919560AD;
	Mon, 12 Aug 2024 12:07:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 12 Aug 2024 14:07:46 +0200 (CEST)
Date: Mon, 12 Aug 2024 14:07:39 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Liao Chang <liaochang1@huawei.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, andrii@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/2] uprobes: Remove redundant spinlock in
 uprobe_deny_signal()
Message-ID: <20240812120738.GC11656@redhat.com>
References: <20240809061004.2112369-1-liaochang1@huawei.com>
 <20240809061004.2112369-2-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809061004.2112369-2-liaochang1@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 08/09, Liao Chang wrote:
>
> Since clearing a bit in thread_info is an atomic operation, the spinlock
> is redundant and can be removed, reducing lock contention is good for
> performance.

My ack still stays, but let me add some notes...

sighand->siglock doesn't protect clear_bit() per se. It was used to not
break the "the state of TIF_SIGPENDING of every thread is stable with
sighand->siglock held" rule.

But we already have the lockless users of clear_thread_flag(TIF_SIGPENDING)
(some if not most of them look buggy), and afaics in this (very special)
case it should be fine.

Oleg.

> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  kernel/events/uprobes.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 73cc47708679..76a51a1f51e2 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1979,9 +1979,7 @@ bool uprobe_deny_signal(void)
>  	WARN_ON_ONCE(utask->state != UTASK_SSTEP);
>  
>  	if (task_sigpending(t)) {
> -		spin_lock_irq(&t->sighand->siglock);
>  		clear_tsk_thread_flag(t, TIF_SIGPENDING);
> -		spin_unlock_irq(&t->sighand->siglock);
>  
>  		if (__fatal_signal_pending(t) || arch_uprobe_xol_was_trapped(t)) {
>  			utask->state = UTASK_SSTEP_TRAPPED;
> -- 
> 2.34.1
> 


