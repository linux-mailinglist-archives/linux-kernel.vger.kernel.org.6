Return-Path: <linux-kernel+bounces-385151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8B89B3330
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766AD1F22101
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7221DD864;
	Mon, 28 Oct 2024 14:18:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3451DA631;
	Mon, 28 Oct 2024 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125136; cv=none; b=iUEwyjSGHZBaRy8CImH9x3Sg32jt3c3DSK4Kl7C6pw3cqaY2KRBUoU5UDXI1/zGAZf7NkHAWk6sDVO4mK+oj627RDMRsCzsAyJs3gV1m0P575M/JJsfEhYLNnSDZBNwG/8YTrGBPZOGcTBxzeX94X9kqs4ylrt0363wuATlJO7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125136; c=relaxed/simple;
	bh=3bu6BASM1fOVsLRziZGcyMrGRXJyUtI91nwotpR/K1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGizzIFlNzrp+yoiV6So1yXYpVRp25+VpHeIwuNTNGSW/XkUERcWnWdtjRQ+m2EbQRfPslN+TUucliXwV3O1oj8w3s6UR2SKl7FTCISv/oVpraCzC8a6iPLmx/m+meSJ9XPC5rt0/gQ2xWx5SUgZZQr7jghBm2IqXRXGIRlNEC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41535C4CEE4;
	Mon, 28 Oct 2024 14:18:54 +0000 (UTC)
Date: Mon, 28 Oct 2024 10:18:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/5] ftrace: Use guard to take ftrace_lock in
 ftrace_graph_set_hash()
Message-ID: <20241028101850.548f0fcd@rorschach.local.home>
In-Reply-To: <20241028091656.GJ9767@noisy.programming.kicks-ass.net>
References: <20241028071228.575900713@goodmis.org>
	<20241028071308.406073025@goodmis.org>
	<20241028091656.GJ9767@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 10:16:56 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > @@ -6846,13 +6844,8 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
> >  			}
> >  		}
> >  	} while_for_each_ftrace_rec();
> > -out:
> > -	mutex_unlock(&ftrace_lock);
> >  
> > -	if (fail)
> > -		return -EINVAL;
> > -
> > -	return 0;
> > +	return fail ? -EINVAL : 0;
> >  }  
> 
> Isn't the fail case more a case of -ESRCH / -ENOENT rather than -EINVAL?

Could be. Although this is mostly for internal use. I should check to
see if this gets back to user space. And yeah, it probably should be
changed.

> 
> Anyway, that's orthogonal, the patch preserves existing semantics and
> looks okay (as do the others fwiw).

Thanks for the review!

-- Steve

