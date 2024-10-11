Return-Path: <linux-kernel+bounces-361363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA3199A739
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B724FB250FF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0661940BC;
	Fri, 11 Oct 2024 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3VgEMIS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6C619308A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659432; cv=none; b=mGaTeDknzuB2bwU/w9mn2Io+Hwn9m/geJdO5Uwce98ylxr587IJay+lLEJMDTHrzznNqZQ/blFvQYqB6pvb75LBwof4ppYfAK8G8vm8XS5KdwADHaRyxNIKRsgLi5e6OVdcpk4MOLNX6YR0kC4fP9JIjKgeJaGr2l4qinRzNkNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659432; c=relaxed/simple;
	bh=lw104qm+G0+JdmIZx7f4XeZ61O0BxitCsy4Oi++bCDU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dY7FBnKWiVCLKx4TFdiMRBqJehjHKO0YbVMEcmP+etbFEXWrWjjsPeg/gYyOpgcwQakXEJSmMJGNBDj4ONRzIcbGRWPp7xV9wdtQiEKorwVLKDWt7tTOxmOYXRRoVx5WDP17KVdz59L1krjwWTmr1skmK4BA2sjwqxkGcmOzot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3VgEMIS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728659429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m24vUpCYQQcbV3XB46UeKIxQNXS2Npg8Axx+7syAJlk=;
	b=H3VgEMISB0Va83xptwD9yucchD8FTZRyDPLa1lJJD3IKqdv4mKECZlPcp940d/EHe4Kq7Y
	AnxK29RN4Nbac3WJh0BxwHt0H43tSaUrcrP95U9c9QTsFMOg5+oXzLx32ye4HXlUnRikPr
	DU7RMb/MY+ZL2j5Spu7w8W7IbZsUWzM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-bIOpoYHWNduNpO6kUl4qrQ-1; Fri, 11 Oct 2024 11:10:28 -0400
X-MC-Unique: bIOpoYHWNduNpO6kUl4qrQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b115cfb15aso212674685a.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728659428; x=1729264228;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m24vUpCYQQcbV3XB46UeKIxQNXS2Npg8Axx+7syAJlk=;
        b=oQxAJM+EfcR6eKhYeRnwucG0XIZeaBeLFQtMd0c8MNsLfTW3eBzvpY9P+scQxOjTvI
         fUCGAYMsvmvrrvzMOzZhRUORPtgugDms1F0DFmIBBjLLEMX4DWYJvgOqbpimfamgWSLq
         b8I+Vj4pFI6FepJ8aW7Btz/BV3MfD5vKaWJejzfjwV0sLHo+XxlcIq/CZwEa1vDZyhhh
         eg03MbDIE9B3EhYw7PmXmqYghOgFiCvUxUBEvzWxi9e5sNSj3vAktSE2SesABdeMoRZs
         AhWfDimXRYfwisKnYjgFH6HM+B/PJ9Gp1x+ksozM4hmcagW2oemP++VW7uIxUjuYghjr
         W8Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXDaKzHkorqmp3FX6C78tgIUnrTn7dDkrEU+KikGGChPrqEYG2TkOoW7O2afGtnBQC63NZUzV3aGcg2hCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7WHZsXHDXD+ZBfRNatvHHIrJtM1/ugHroTACb+T9oI4M7RRf2
	W0Be4jhraWB8G9Y22kLo5mMYBQ3THr3Cy0SVQDFVmJN1sknfgJC+afxX/WKuVvM4PXz1voz3tPq
	9dlvI5OKNFS0dhdNqi4RLee/2zEMgXMsrja4cykyXl4pmD1ItaNx1aXKp3DkFFg==
X-Received: by 2002:a05:620a:28d1:b0:7af:cd33:33b3 with SMTP id af79cd13be357-7b11a3a9ccbmr480236285a.42.1728659427695;
        Fri, 11 Oct 2024 08:10:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNNlcpFHz+ulTVxOY4ANKKzLPBOEsf3PRA5tA3JB3mgtgEjWz+S0wtn4+4mk/xI3zoG884Kw==
X-Received: by 2002:a05:620a:28d1:b0:7af:cd33:33b3 with SMTP id af79cd13be357-7b11a3a9ccbmr480232885a.42.1728659427333;
        Fri, 11 Oct 2024 08:10:27 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11497a783sm139724885a.106.2024.10.11.08.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:10:27 -0700 (PDT)
Date: Fri, 11 Oct 2024 11:10:25 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, lgoncalv@redhat.com, 
    Attila Fazekas <afazekas@redhat.com>
Subject: Re: [PATCH 2/2] rtla/timerlat: Make timerlat_hist_cpu->*_count
 unsigned long long
In-Reply-To: <20241011121015.2868751-2-tglozar@redhat.com>
Message-ID: <d016d069-6c89-3798-18c5-b0038a55efe5@redhat.com>
References: <20241011121015.2868751-1-tglozar@redhat.com> <20241011121015.2868751-2-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 11 Oct 2024, tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> Do the same fix as in previous commit also for timerlat-hist.
> 
> Reported-by: Attila Fazekas <afazekas@redhat.com>
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/timerlat_hist.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
> index a3907c390d67..bbeaba8b5183 100644
> --- a/tools/tracing/rtla/src/timerlat_hist.c
> +++ b/tools/tracing/rtla/src/timerlat_hist.c
> @@ -62,9 +62,9 @@ struct timerlat_hist_cpu {
>  	int			*thread;
>  	int			*user;
>  
> -	int			irq_count;
> -	int			thread_count;
> -	int			user_count;
> +	unsigned long long	irq_count;
> +	unsigned long long	thread_count;
> +	unsigned long long	user_count;
>  
>  	unsigned long long	min_irq;
>  	unsigned long long	sum_irq;
> @@ -304,15 +304,15 @@ timerlat_print_summary(struct timerlat_hist_params *params,
>  			continue;
>  
>  		if (!params->no_irq)
> -			trace_seq_printf(trace->seq, "%9d ",
> +			trace_seq_printf(trace->seq, "%9llu ",
>  					data->hist[cpu].irq_count);
>  
>  		if (!params->no_thread)
> -			trace_seq_printf(trace->seq, "%9d ",
> +			trace_seq_printf(trace->seq, "%9llu ",
>  					data->hist[cpu].thread_count);
>  
>  		if (params->user_hist)
> -			trace_seq_printf(trace->seq, "%9d ",
> +			trace_seq_printf(trace->seq, "%9llu ",
>  					 data->hist[cpu].user_count);
>  	}
>  	trace_seq_printf(trace->seq, "\n");
> @@ -488,15 +488,15 @@ timerlat_print_stats_all(struct timerlat_hist_params *params,
>  		trace_seq_printf(trace->seq, "count:");
>  
>  	if (!params->no_irq)
> -		trace_seq_printf(trace->seq, "%9d ",
> +		trace_seq_printf(trace->seq, "%9llu ",
>  				 sum.irq_count);
>  
>  	if (!params->no_thread)
> -		trace_seq_printf(trace->seq, "%9d ",
> +		trace_seq_printf(trace->seq, "%9llu ",
>  				 sum.thread_count);
>  
>  	if (params->user_hist)
> -		trace_seq_printf(trace->seq, "%9d ",
> +		trace_seq_printf(trace->seq, "%9llu ",
>  				 sum.user_count);
>  
>  	trace_seq_printf(trace->seq, "\n");
> -- 
> 2.47.0
> 
> 
> 
Reviewed by: John Kacur <jkacur@redhat.com>
Tested by: John Kacur <jkacur@redhat.com>


