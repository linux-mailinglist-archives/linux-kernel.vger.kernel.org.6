Return-Path: <linux-kernel+bounces-361361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 858CB99A735
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B001F247C9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DF319308A;
	Fri, 11 Oct 2024 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsSQ09k2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE5C18EFF8
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659386; cv=none; b=Csz+88r5vvZ5/XAHLs7sP1PyBPr3zVovl9cZ9mK7lGSYFo1oRPj/h3baYDHi8zfdnjVDJKp6DwFgTiLX664GnJ774bNsILKZz0U6aHYLQBOfmBBOYKoxR8rY8fs/8GWJDJvbhFwBWgWKNMO+nDkDfIwa/5nEi4JsjoisY35PhWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659386; c=relaxed/simple;
	bh=+pffSBIZA+a8CSVgLMTRKdxIGcssG/c8mbcHlhem/rI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FkKHL70IiX2A70KfMaNikpZ8Ex7uvrbW05OCIW6SkjytUGm77yjbKI4wgUklH+l73M9Kh1dBD/QEcyy/TUdrD+pEO7gaPzfBCC/gZUVFy5LHwTA0QlFQn2H6OEJ9zS7bCsgxWunmFJVvlh8oW6oSnlXhX0au3ptdDlJVWx+771A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsSQ09k2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728659383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7AyAkq/LD6360rwLpOZDql6SR1jmHq2j/yk3NQnqtQ=;
	b=SsSQ09k2qwaES2cVlFBvrd2VTtR+1PgtzkTZErk1SoxGQ46hRYhH8SJ1Iw15QMkMnz67u7
	LoXGiRK9/avikUm4my/GgBSTOdk8WFEuOX5d94jompPGwrD9eZ7ILFfkrpEPUGxnmhSAH1
	9LdPJ0oiZPPRvezNXa86y4L1icCxtUY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-4lr06x5ePu6QgunvSzeEOw-1; Fri, 11 Oct 2024 11:09:41 -0400
X-MC-Unique: 4lr06x5ePu6QgunvSzeEOw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b111bc482eso440400985a.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728659381; x=1729264181;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X7AyAkq/LD6360rwLpOZDql6SR1jmHq2j/yk3NQnqtQ=;
        b=ntzBx50YgsydB1kogKjWowYUZ9mn/r2U62GODPgG21fh6Ac2mUiIyQSD8YDxwxxDQe
         G0KW2QxX15dtJb0d8EkozO8FNnbj9Pl275H97tceyRVvJDqbPZfD4ZAd/SamaD/CJp5Y
         d8g40ZpPI7weiqqgcCzfvIFTPavMJQIlcq/npRDhgkgtFgc2a739DadVFf170pfDndIa
         ASLLtEkjMx58MbUg5P/ZC+2QCfARy4X0uxbfGB57hV29JViPtntUZV5EBUE9nlvIuJ17
         AyibwamncFDYoePdPNogF406kqD/+ZIWvuTugKFpMUsIqIcmefF/iS2tlXZGIJzpzfFY
         nZIw==
X-Forwarded-Encrypted: i=1; AJvYcCW/F3sNME0lmHPHnDwmLQSid8B+7c4r20Oy2l3hMKv1XbFwRKLCKop06+AngIHcH62YzWZ6TSqYG7bWs6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzsfLuM4JlDWg8dGA6lWwzhg0wYEs/biUVreOS3Dgg78E/VJw4
	wfFqfFB8I1zPYqJeJtHO8W2vIvDXd3cEtjlg/bVtjZE1iBpSovyovqtHfSgz9XFYp5GlEwDlryT
	e1j99fTJBq5EKhtwst9Hckjks9i5QjSMw08QadY8aygY93ZBbb3Asr1bmXhEyO7A6Xwov7g==
X-Received: by 2002:a05:620a:4556:b0:7a9:bad0:4572 with SMTP id af79cd13be357-7b1124cb767mr1240065885a.17.1728659381198;
        Fri, 11 Oct 2024 08:09:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEphbyV5tig9Nw95QtLJTUGp11LFAs48h1xyWPDR/B8YigrZvhaCucr/272XMaK38i4e2X6LQ==
X-Received: by 2002:a05:620a:4556:b0:7a9:bad0:4572 with SMTP id af79cd13be357-7b1124cb767mr1240060785a.17.1728659380839;
        Fri, 11 Oct 2024 08:09:40 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b114956044sm139874785a.79.2024.10.11.08.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:09:40 -0700 (PDT)
Date: Fri, 11 Oct 2024 11:09:39 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, lgoncalv@redhat.com, 
    Attila Fazekas <afazekas@redhat.com>
Subject: Re: [PATCH 1/2] rtla/timerlat: Make timerlat_top_cpu->*_count unsigned
 long long
In-Reply-To: <20241011121015.2868751-1-tglozar@redhat.com>
Message-ID: <f67e508d-5d40-596e-9d98-55b9ce2c8f8e@redhat.com>
References: <20241011121015.2868751-1-tglozar@redhat.com>
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
> Most fields of struct timerlat_top_cpu are unsigned long long, but the
> fields {irq,thread,user}_count are int (32-bit signed).
> 
> This leads to overflow when tracing on a large number of CPUs for a long
> enough time:
> $ rtla timerlat top -a20 -c 1-127 -d 12h
> ...
>   0 12:00:00   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
> CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
>  1 #43200096  |        0         0         1         2 |        3         2         6        12
> ...
> 127 #43200096  |        0         0         1         2 |        3         2         5        11
> ALL #119144 e4 |                  0         5         4 |                  2        28        16
> 
> The average latency should be 0-1 for IRQ and 5-6 for thread, but is
> reported as 5 and 28, about 4 to 5 times more, due to the count
> overflowing when summed over all CPUs: 43200096 * 127 = 5486412192,
> however, 1191444898 (= 5486412192 mod MAX_INT) is reported instead, as
> seen on the last line of the output, and the averages are thus ~4.6
> times higher than they should be (5486412192 / 1191444898 = ~4.6).
> 
> Fix the issue by changing {irq,thread,user}_count fields to unsigned
> long long, similarly to other fields in struct timerlat_top_cpu and to
> the count variable in timerlat_top_print_sum.
> 
> Reported-by: Attila Fazekas <afazekas@redhat.com>
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/timerlat_top.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
> index 210b0f533534..ee7c291fc9bb 100644
> --- a/tools/tracing/rtla/src/timerlat_top.c
> +++ b/tools/tracing/rtla/src/timerlat_top.c
> @@ -54,9 +54,9 @@ struct timerlat_top_params {
>  };
>  
>  struct timerlat_top_cpu {
> -	int			irq_count;
> -	int			thread_count;
> -	int			user_count;
> +	unsigned long long	irq_count;
> +	unsigned long long	thread_count;
> +	unsigned long long	user_count;
>  
>  	unsigned long long	cur_irq;
>  	unsigned long long	min_irq;
> @@ -280,7 +280,7 @@ static void timerlat_top_print(struct osnoise_tool *top, int cpu)
>  	/*
>  	 * Unless trace is being lost, IRQ counter is always the max.
>  	 */
> -	trace_seq_printf(s, "%3d #%-9d |", cpu, cpu_data->irq_count);
> +	trace_seq_printf(s, "%3d #%-9llu |", cpu, cpu_data->irq_count);
>  
>  	if (!cpu_data->irq_count) {
>  		trace_seq_printf(s, "%s %s %s %s |", no_value, no_value, no_value, no_value);
> -- 
> 2.47.0
> 
> 
> 
Reviewed by: John Kacur <jkacur@redhat.com>
Tested by: John Kacur <jkacur@redhat.com>


