Return-Path: <linux-kernel+bounces-330513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6E1979F87
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2AB1C20967
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C9814B94C;
	Mon, 16 Sep 2024 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9Mk1PYS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0061D38DC7
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726483118; cv=none; b=TvvQRamnTgQxMkqlm9K0fr3uqDilI6/0p2p2nvUUPsTJOwiMoFKQzuNGadndNT8JLaub9wQ0oU/a8/kaMEGxwuRbclGikDfhEvlh8+ErJm6D/+YWsGNzO5nPIfxRBRqmtake9vwFwmVA/2oBB4DRLQuq6hNnRSzGA2Ro0B/D56s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726483118; c=relaxed/simple;
	bh=qjNa3UtU8uCaSWy+UerRzf1K9Z0cHIBE+rP3Q7Oi7rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVfaTokSMbfPKOfo9s6zQyN3l/SIPXCSOAYFspHWnqTdPiuGh206DYIKAvLXJUUrDBJUCY75vzjK65GhEezybpXnYBJwfsmSq2RmxpLlgeHHwZ/6/LItfPkomDyx77QIpLSNQiYSUq0C+eN4+KZMZwOzMKJd45MQ7Uc0X+sMKfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O9Mk1PYS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726483114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TFuK5S8ppIHmZYG3Axev2zHBowrYvgWSkbnTKV3dF9s=;
	b=O9Mk1PYSYWK4QAGiGqNyBp9LcuQN95l9JgG6tcdMwm2IAq+EY6J/auEuBmdBWDGcWT4gDB
	5PyOBPbWTjZRtSt7XIIUwB4VFF1O+t2fKVPRdZB0JJ+vB1LAojabt6m56i4bX7NWboE/B/
	y96wlAr2yoqc+0VSsFqZVBss1Cpgh+o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-lhl6jNH1ORazlwaAqRgEWg-1; Mon,
 16 Sep 2024 06:38:31 -0400
X-MC-Unique: lhl6jNH1ORazlwaAqRgEWg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A4DE19560AB;
	Mon, 16 Sep 2024 10:38:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.82])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EE06D195605A;
	Mon, 16 Sep 2024 10:38:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 16 Sep 2024 12:38:16 +0200 (CEST)
Date: Mon, 16 Sep 2024 12:38:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	chenqiwu <qiwuchen55@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: arm64: stacktrace: WARN_ON(state->common.pc == orig_pc) in
 kunwind_recover_return_address()
Message-ID: <20240916103811.GA14111@redhat.com>
References: <20240916102741.GA13899@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916102741.GA13899@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Ah, sorry for the noise, I looked into the wrong tree, missed the recent
c060f93253ca ("arm64: stacktrace: fix the usage of ftrace_graph_ret_addr()")

On 09/16, Oleg Nesterov wrote:
>
> I don't know the details but people report that
> kunwind_recover_return_address() hits this warning.
>
> I know absolutely nothing about arm64 or kernel/trace/fgraph.c, but at
> first glance this code looks broken:
>
> 	kunwind_recover_return_address:
>
> 		...
>
> 		orig_pc = ftrace_graph_ret_addr(state->task, NULL,
> 						state->common.pc,
> 						(void *)state->common.fp);
> 		if (WARN_ON_ONCE(state->common.pc == orig_pc))
>
> 	ftrace_graph_ret_addr:
>
> 		...
>
> 		if (!idx)
> 			return ret;
>
>
> given that kunwind_recover_return_address() passes idx == NULL to
> ftrace_graph_ret_addr(), it should always return ret == state->common.pc ?
>
>
> Perhaps this connects to 29c1c24a27 ("function_graph: Fix up ftrace_graph_ret_addr()")
> and I have no idea if something like the patch below makes any sense.
>
> Oleg.
>
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -106,7 +106,8 @@ kunwind_recover_return_address(struct kunwind_state *state)
>  	if (state->task->ret_stack &&
>  	    (state->common.pc == (unsigned long)return_to_handler)) {
>  		unsigned long orig_pc;
> -		orig_pc = ftrace_graph_ret_addr(state->task, NULL,
> +		orig_pc = ftrace_graph_ret_addr(state->task,
> +						&state->task->curr_ret_stack,
>  						state->common.pc,
>  						(void *)state->common.fp);
>  		if (WARN_ON_ONCE(state->common.pc == orig_pc))


