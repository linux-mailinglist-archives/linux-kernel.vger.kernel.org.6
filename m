Return-Path: <linux-kernel+bounces-211643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF979054D0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4671B1F21D35
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FE717DE1E;
	Wed, 12 Jun 2024 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StgvcIY0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806A217D8A3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201563; cv=none; b=rJ9T/sfjhsiRQi+iA103NwnaxaPaDgsti9yPsgIAafL9WMUb2nHZ0UhO+dQSvCFbzNvMRwEazvp/6I4iyKVirbN0O5zNBEP0j/btfw+dNzDes2T+RuEidlU20+RcUUfeoVAq9QVB/fhuJGCyMuFCaw5rfvuEqj034j1CSvjHyao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201563; c=relaxed/simple;
	bh=e6CithrYoqvWAZTwPj/kYCtycBNrDIODo8TF0DmX2ss=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Onf0VWN/D96xWwLfPckuXuHpLPfQNaRjwtA1MS/U5kfa6zUv94rrFBXa0FuFJ5QxBY0Jo/TVBbHadrUg1DShwKi0j1QwpuKjNiINy3GfSwlhmxZ8jq01TNqGKYFn1MdA4tXX6es3w2izC07g4tcx8i6yIvf7mPLjram0t045S6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=StgvcIY0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718201560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41mm6L+5qDMknpvTMwkuAgq3SgjPtSkdBwaxW2ijW5Q=;
	b=StgvcIY01GgvOEzsnVnPOKpkrULziz5Nc5fAQIQ32FTAtcj5QTOSbxASJzkdFsKQSZ/ROB
	q3MzJqcKrSg3BVLog03jwLJF9Lyci8srSvQah5MCfLN/5OvLVU76YSLVSdVpth9APFi1bH
	8Xk+laGiFmAQPbjl7MtNNY20YPhghIU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504--jUkXuEEPD-MEb8-RDjFyQ-1; Wed, 12 Jun 2024 10:12:39 -0400
X-MC-Unique: -jUkXuEEPD-MEb8-RDjFyQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-79557d418e0so141991385a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718201558; x=1718806358;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41mm6L+5qDMknpvTMwkuAgq3SgjPtSkdBwaxW2ijW5Q=;
        b=LT6ETxM3LZc885u+aMSiWUBlMGTLz3ulxpV/yuLy5ENYMOC54BPhlYiNKPfM5p81Vm
         DisWZqXtPtFQKb0RqrXtG9reYW3Q8al9yXhufOjEk50y7KfR4PjOi4MKEYwPLhajL3Cc
         3epADHM2gsxMHcRiecOylrfrkityqA7mD5u++RVxenkIGwJenZxrUEk3V/NcInDEAZ5b
         TpDmCvUMk74tnXiySyG+cb3vTwwc92OMq9fWIaDOB4SBi6N8HK6rwhzmFcKTzcFJdHu7
         Y/h0VzqxabuaAUrkW76QnS6dVxKCobit+B9s38CvC/ijgaNbc9UjZzJqkaVTzVJS1iS6
         ZpLA==
X-Forwarded-Encrypted: i=1; AJvYcCVP6dKqfP4YAC4Q6SOQH/o5+XWi8rv32/eQib3lKTFF8oPSxAjacJ/3kX/eJSrV9HdWBCScHhxMUMJVZl57siFzhG9edgib53ZSpac2
X-Gm-Message-State: AOJu0Yx2IPDWXaec07FGLSM1uCwwn9rsD//O2hMQU0D6a3WdQ66SZZc7
	/zLna+xMCHyC0JUIGy4smufggCy2gGZzS+w4Ud9n7xjrN0ZngFF1B6cV2A7dNR6+0Xbte/9s4dt
	xXHSscp04Qsqgluws6pZKM9pLedYEDzeHlGVj8Xmm89e7Q1CRI3OqUo5yt3F10A==
X-Received: by 2002:a05:620a:190f:b0:797:84e7:9046 with SMTP id af79cd13be357-797f4db30e5mr352017185a.4.1718201558718;
        Wed, 12 Jun 2024 07:12:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB5vrOLZcD6InRm6Qvq4YB5P6QAVqAA61aZvOvCoo3qbREicdPR4c13qRvHDbOEOnZ6c3QTQ==
X-Received: by 2002:a05:620a:190f:b0:797:84e7:9046 with SMTP id af79cd13be357-797f4db30e5mr352013285a.4.1718201558298;
        Wed, 12 Jun 2024 07:12:38 -0700 (PDT)
Received: from fionn ([74.12.5.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7954de1c077sm453970885a.48.2024.06.12.07.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 07:12:37 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:12:26 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
cc: Daniel Bristot de Oliveira <bristot@kernel.org>, 
    Steven Rostedt <rostedt@goodmis.org>, Clark Williams <williams@redhat.com>, 
    linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtla/osnoise: Better report when histogram is empty
In-Reply-To: <Zml6JmH5cbS7-HfZ@uudg.org>
Message-ID: <9d283173-4ff6-fbac-bcc3-e712daa99572@redhat.com>
References: <Zml6JmH5cbS7-HfZ@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 12 Jun 2024, Luis Claudio R. Goncalves wrote:

> When osnoise hist does not observe any samples above the threshold,
> no entries are recorded and the final report shows empty entries
> for the usual statistics (count, min, max, avg):
> 
>     [~]# osnoise hist -d 5s -T 500
>     # RTLA osnoise histogram
>     # Time unit is microseconds (us)
>     # Duration:   0 00:00:05
>     Index
>     over: 
>     count:
>     min:  
>     avg:  
>     max:  
> 
> That could lead users to confusing interpretations of the results.
> 
> A simple solution is to report 0 for count and the statistics, making it
> clear that no noise (above the defined threshold) was observed:
> 
>     [~]# osnoise hist -d 5s -T 500
>     # RTLA osnoise histogram
>     # Time unit is microseconds (us)
>     # Duration:   0 00:00:05
>     Index
>     over: 0
>     count: 0
>     min: 0
>     avg: 0
>     max: 0
> 
> 
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> ---
>  tools/tracing/rtla/src/osnoise_hist.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
> index 7be17d09f7e85..214e2c93fde01 100644
> --- a/tools/tracing/rtla/src/osnoise_hist.c
> +++ b/tools/tracing/rtla/src/osnoise_hist.c
> @@ -374,6 +374,7 @@ osnoise_print_stats(struct osnoise_hist_params *params, struct osnoise_tool *too
>  {
>  	struct osnoise_hist_data *data = tool->data;
>  	struct trace_instance *trace = &tool->trace;
> +	int has_samples = 0;
>  	int bucket, cpu;
>  	int total;
>  
> @@ -402,11 +403,25 @@ osnoise_print_stats(struct osnoise_hist_params *params, struct osnoise_tool *too
>  			continue;
>  		}
>  
> +		/* There are samples above the threshold */
IMHO The comment isn't needed because the variable had_samples is 
descriptive, but it's not a big deal either


> +		has_samples = 1;
>  		trace_seq_printf(trace->seq, "\n");
>  		trace_seq_do_printf(trace->seq);
>  		trace_seq_reset(trace->seq);
>  	}
>  
> +	/*
> +	 * If no samples were recorded, skip calculations, print zeroed statistics
> +	 * and return.
> +	 */
> +	if (!has_samples) {
> +		trace_seq_reset(trace->seq);
> +		trace_seq_printf(trace->seq, "over: 0\ncount: 0\nmin: 0\navg: 0\nmax: 0\n");
> +		trace_seq_do_printf(trace->seq);
> +		trace_seq_reset(trace->seq);
> +		return;
> +	}
> +
>  	if (!params->no_index)
>  		trace_seq_printf(trace->seq, "over: ");
>  
> 
> 
> 


Reviewed-by: John Kacur <jkacur@redhat.com>


