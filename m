Return-Path: <linux-kernel+bounces-208295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A9D902336
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB101C22A70
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2EC84FAE;
	Mon, 10 Jun 2024 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLY2XxWO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BFD824BB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718027292; cv=none; b=AwxLE+OMTdv/Djh1sPrFaeeUYVxwPkHlf+3D9KNf4MbaJ2G8JyJNnGM4VlsQEBMpIB/ImPQqgiOSC7q0K6H1tVeZGW4eKKuazzY3B3zDN6iAv2aJEKVDa4EAInzDd0QwF36DCj0oVfiMP6Mdzw24DBNRqfqLT2Wvl5eAcQCETf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718027292; c=relaxed/simple;
	bh=lB8V69SYEw9+O2mPvk8otfaMA/yqIX5iFd8IHf5GAjY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8JR0FtGdxeeI4+8OCeX/OrJugdnPnB8zxbPBNH5Aq0CKSpZsuFzjScWKbWqNWqEbJsUXEiU5zgY2CN+zW3VZDNeW90z2E7aCmyC9zPPvwceJz9Yvv1RCplWBmS0gW9bq1vgpgWwEtyeh+f4VZXv0QCSWcpC+yKu+k1F9qMV3AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XLY2XxWO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718027289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5k5xstIiUaqx73pQMuWWQnmfk4y6kOLjKGMcYQ/qatw=;
	b=XLY2XxWOgDpvCZF4k+QRqNqvoq9TvlzSDSXkumJZlBXOJQOol+aWQ9/yZyMX0W3zwPs1cR
	x+/FBwuOSmILUbbB9cV2vKMowQsnHd07SxdQPOhjm5PeloaYHndpa3UGZZSZNUetgYklcU
	WRBhfX0iRm3lMIpVqUb3S5RWeeBMRV0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-6MCqCXS4NYa0-B4aiZMVeg-1; Mon,
 10 Jun 2024 09:48:06 -0400
X-MC-Unique: 6MCqCXS4NYa0-B4aiZMVeg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C5D8195608C;
	Mon, 10 Jun 2024 13:48:05 +0000 (UTC)
Received: from localhost (unknown [10.22.8.210])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 58E491956048;
	Mon, 10 Jun 2024 13:48:04 +0000 (UTC)
Date: Mon, 10 Jun 2024 10:48:02 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rtla/osnoise: Use pretty formatting only on
 interactive tty
Message-ID: <ZmcEEr6OwG5vscep@uudg.org>
References: <Zmb-yP_3EDHliI8Z@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmb-yP_3EDHliI8Z@uudg.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This is a single patch, selected out of a test series. I messed up the
subject giving the impression that more patches were to come.

Sorry for any inconvenience,
Luis

On Mon, Jun 10, 2024 at 10:25:28AM -0300, Luis Claudio R. Goncalves wrote:
> osnoise top performs background/font color formatting that could make
> the text output confusing if not on a terminal. Use the changes from
> commit f5c0cdad6684a ("rtla/timerlat: Use pretty formatting only on
> interactive tty") as an inspiration to fix this problem.
> 
> Apply the formatting only if running on a tty, and not in quiet mode.
> 
> Suggested-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> Reviewed-by: John Kacur <jkacur@redhat.com>
> Reviewed-by: Clark Williams <williams@redhat.com>
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> ---
>  tools/tracing/rtla/src/osnoise_top.c |   19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
> index 07ba55d4ec06f..d539fade99d48 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
> @@ -42,6 +42,7 @@ struct osnoise_top_params {
>  	int			hk_cpus;
>  	int			warmup;
>  	int			buffer_size;
> +	int			pretty_output;
>  	cpu_set_t		hk_cpu_set;
>  	struct sched_attr	sched_param;
>  	struct trace_events	*events;
> @@ -163,7 +164,9 @@ static void osnoise_top_header(struct osnoise_tool *top)
>  
>  	get_duration(top->start_time, duration, sizeof(duration));
>  
> -	trace_seq_printf(s, "\033[2;37;40m");
> +	if (params->pretty_output)
> +		trace_seq_printf(s, "\033[2;37;40m");
> +
>  	trace_seq_printf(s, "                                          ");
>  
>  	if (params->mode == MODE_OSNOISE) {
> @@ -174,12 +177,16 @@ static void osnoise_top_header(struct osnoise_tool *top)
>  	}
>  
>  	trace_seq_printf(s, "                                   ");
> -	trace_seq_printf(s, "\033[0;0;0m");
> +
> +	if (params->pretty_output)
> +		trace_seq_printf(s, "\033[0;0;0m");
>  	trace_seq_printf(s, "\n");
>  
>  	trace_seq_printf(s, "duration: %9s | time is in us\n", duration);
>  
> -	trace_seq_printf(s, "\033[2;30;47m");
> +	if (params->pretty_output)
> +		trace_seq_printf(s, "\033[2;30;47m");
> +
>  	trace_seq_printf(s, "CPU Period       Runtime ");
>  	trace_seq_printf(s, "       Noise ");
>  	trace_seq_printf(s, " %% CPU Aval ");
> @@ -192,7 +199,8 @@ static void osnoise_top_header(struct osnoise_tool *top)
>  	trace_seq_printf(s, "          IRQ      Softirq       Thread");
>  
>  eol:
> -	trace_seq_printf(s, "\033[0;0;0m");
> +	if (params->pretty_output)
> +		trace_seq_printf(s, "\033[0;0;0m");
>  	trace_seq_printf(s, "\n");
>  }
>  
> @@ -619,6 +627,9 @@ osnoise_top_apply_config(struct osnoise_tool *tool, struct osnoise_top_params *p
>  		auto_house_keeping(&params->monitored_cpus);
>  	}
>  
> +	if (isatty(1) && !params->quiet)
> +		params->pretty_output = 1;
> +
>  	return 0;
>  
>  out_err:
> -- 
> 2.45.2
> 
> 
---end quoted text---


