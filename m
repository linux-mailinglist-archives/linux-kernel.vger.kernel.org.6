Return-Path: <linux-kernel+bounces-394654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285EE9BB25B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC9F1C212BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169FC1E6DC1;
	Mon,  4 Nov 2024 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwnzXp2G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E361E5718
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717686; cv=none; b=LVkhePHByLlqr/4cpHX7DrH2yx8A0jEGGeMh69o8+vlZvMXe50Fw73yCjSa3cIVT4P9FmZ9VTvDNnk905JaWEpxP5WmA0uwfRMeB9aY3CXFU7wNIuZ55TT/RIN3HeV7Ti0TJ0oV4vNY4mdaBmOU7TVMEwtYfUQ/XyTrztFt4TVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717686; c=relaxed/simple;
	bh=AZEFDAGn9Df4zz3euKGa3AQVFYmfE15fvDMzea7ih0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiujj7AIoOzQwYu66tdl7EI4S2RcaC4BQw2x29XqaGwDTnUjuqw7AuemChgKq+FnNhQnnALJG6JtGz8+grcYyjC6u48ocB2OSUk7Oxf/krfsVQv0EHn6Y9SE0I5KPcjigE7l8Kzh2a5LOqbEqxON3H7bn/nuy2bng7EWcTrxMXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FwnzXp2G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730717683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XzVgG0uptjl8FwWF7UGqUBOphSrjl+c5Bnwr23cuFlI=;
	b=FwnzXp2GfyQGX98CtmCza7BvCt/3qDHmN4AobztbyS7mh3JpdEZmAdfHpfLUMmlJncJV7J
	QizGyaCq1YqFOMdPA1+Esi+piUUkpmak10m+2e86S8RatZsHQXukaR0Ezgzc4ElHVxSbdE
	Iup1jBcG8LUDF3tj756ErUhQsGM6Ams=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-7-3SnQ7aN5ONwuHVEpD-wA-1; Mon, 04 Nov 2024 05:54:42 -0500
X-MC-Unique: 7-3SnQ7aN5ONwuHVEpD-wA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43157e3521dso27346135e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 02:54:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730717681; x=1731322481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzVgG0uptjl8FwWF7UGqUBOphSrjl+c5Bnwr23cuFlI=;
        b=cm3+IcsgeMRMHTSVp5Zq6QveCxSwM4cZKVd5obzdAC1IhgbK5tBJg5RPRC5GeGGQgt
         zl5IngPIYSZ51uaibtp8dNykb4s4/943Gd8KAYPcBraQhKaYV64rO8q43Rwxj+X2hIu4
         CwcbTRzCyQ0ybJ/Uop5XGrSSe7zinQzUWTBExFbYeRAEctPftusII3g/PrAG2uFw4vLq
         g9avMfJtTRbK3K9VI0U4i+dXzdf6Jyw9deTGGsnWgyWYfVR/orbfb9G5qr2R3xaAJEal
         SZoJ0MTR7cqM6aaqmwn8NjhKzu8QYaYeFZGJsqKc613ihO0sKKiFTViX/LT35zq7qWL9
         i/RQ==
X-Gm-Message-State: AOJu0YwLW5ZGMS8ZP/BfbRPgug9RuM/hMSncec5ESWvXnhf9tNi6R8OH
	t9KJf/fTH4U49yYhD+lRaItC0DYXYTeFiIGsmWabiqE2WAuSiBiT+3LAp++SfLc45V4RrXuvuC0
	yTiZsQIUi80uwfCwDhWAgVUY0eXRpdOwuqZ4ANzQhykh6lURpM7CgziujQA4kUQ==
X-Received: by 2002:a05:600c:45cc:b0:431:52a3:d9d9 with SMTP id 5b1f17b1804b1-432831cb2ecmr105794485e9.0.1730717680631;
        Mon, 04 Nov 2024 02:54:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9fwikZott7906EuqtEQkZApSdJWg6D6fp8s9bcz6NCf1Rz0rcP0HUl081Rpncz6rya8i9uA==
X-Received: by 2002:a05:600c:45cc:b0:431:52a3:d9d9 with SMTP id 5b1f17b1804b1-432831cb2ecmr105794165e9.0.1730717680133;
        Mon, 04 Nov 2024 02:54:40 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.142.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e528sm12963451f8f.78.2024.11.04.02.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 02:54:39 -0800 (PST)
Date: Mon, 4 Nov 2024 11:54:36 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Subject: Re: [PATCH] dl_server: Reset DL server params when rd changes
Message-ID: <Zyin7P2WNZMM40tp@jlelli-thinkpadt14gen4.remote.csb>
References: <20241029225116.3998487-1-joel@joelfernandes.org>
 <ZyJC9MkbPeF9_rdP@jlelli-thinkpadt14gen4.remote.csb>
 <20241030195017.GA4171541@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030195017.GA4171541@google.com>

On 30/10/24 19:50, Joel Fernandes wrote:

...

> With some prints [1] in the kernel, we can see on boot:
> 
> $ dmesg|grep appl
> [    0.930337] dl_server_apply_params: cpu=0, runtime=50000000, period=1000000000, cpus=1, cap=1024, init=1
> [    0.949025] dl_server_apply_params: cpu=1, runtime=50000000, period=1000000000, cpus=1, cap=1024, init=1
> [    0.953026] dl_server_apply_params: cpu=2, runtime=50000000, period=1000000000, cpus=2, cap=2048, init=1
> [    0.957024] dl_server_apply_params: cpu=3, runtime=50000000, period=1000000000, cpus=3, cap=3072, init=1
> [    0.961023] dl_server_apply_params: cpu=4, runtime=50000000, period=1000000000, cpus=4, cap=4096, init=1
> [    0.965030] dl_server_apply_params: cpu=5, runtime=50000000, period=1000000000, cpus=5, cap=5120, init=1
> [    0.969024] dl_server_apply_params: cpu=6, runtime=50000000, period=1000000000, cpus=6, cap=6144, init=1
> [    0.973024] dl_server_apply_params: cpu=7, runtime=50000000, period=1000000000, cpus=7, cap=7168, init=1
> 
> For the 8th apply_params, the 8th CPU is not considered. This is because
> set_cpu_active() for the 8th CPU has not yet happened as mentioned in commit
> message.
> 
> With the patch:
> 
> $ dmesg|grep appl
> [    0.961169] dl_server_apply_params: cpu=0, runtime=50000000, period=1000000000, cpus=1, cap=1024, init=1
> [    0.981936] dl_server_apply_params: cpu=1, runtime=50000000, period=1000000000, cpus=1, cap=1024, init=1
> [    0.985836] dl_server_apply_params: cpu=2, runtime=50000000, period=1000000000, cpus=2, cap=2048, init=1
> [    0.989835] dl_server_apply_params: cpu=3, runtime=50000000, period=1000000000, cpus=3, cap=3072, init=1
> [    0.993840] dl_server_apply_params: cpu=4, runtime=50000000, period=1000000000, cpus=4, cap=4096, init=1
> [    0.997835] dl_server_apply_params: cpu=5, runtime=50000000, period=1000000000, cpus=5, cap=5120, init=1
> [    1.001838] dl_server_apply_params: cpu=6, runtime=50000000, period=1000000000, cpus=6, cap=6144, init=1
> [    1.005834] dl_server_apply_params: cpu=7, runtime=50000000, period=1000000000, cpus=7, cap=7168, init=1
> 
>    [ ... here somewhere rd changes as topology init finishes, then all the
>    params are replied, this time with the correct rd. ]
> 
> [    1.009903] dl_server_apply_params: cpu=0, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
> [    1.012409] dl_server_apply_params: cpu=1, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
> [    1.014269] dl_server_apply_params: cpu=2, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
> [    1.019865] dl_server_apply_params: cpu=3, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
> [    1.054908] dl_server_apply_params: cpu=4, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
> [    1.081865] dl_server_apply_params: cpu=5, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
> [    1.108861] dl_server_apply_params: cpu=6, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
> [    1.136944] dl_server_apply_params: cpu=7, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
> 
> The -EBUSY happens for our 5.15 backport. I see dl_b->total_bw to be 0
> without my patch. Even if the -EBUSY doesn't happen for you (perhaps due to
> compiler or other differences), shouldn't we use the correct rd for
> apply_params? The dl_bw is tied to the rd via  cpu_rq(cpu)->rd->dl_bw;

I think I am still seeing something different.

[    0.184629] dl_server_apply_params: cpu=0, runtime=50000000, period=1000000000, cpus=1, cap=1024, init=1, dl_b=ffffffffb837c080, dl_b->total_bw=0, dl_b->bw=996147
[    0.185498] __dl_overflow: dl_b=ffffffffb837c080, dl_b->bw=996147, cap=1024, cap_scale=996147 dl_bw->total_bw=0, old_bw=0, new_bw=52428
[    0.371531] dl_server_apply_params: cpu=1, runtime=50000000, period=1000000000, cpus=1, cap=1024, init=1, dl_b=ffffffffb837c080, dl_b->total_bw=52428, dl_b->bw=996147
[    0.372498] __dl_overflow: dl_b=ffffffffb837c080, dl_b->bw=996147, cap=1024, cap_scale=996147 dl_bw->total_bw=52428, old_bw=0, new_bw=52428
[    0.373541] dl_server_apply_params: cpu=2, runtime=50000000, period=1000000000, cpus=2, cap=2048, init=1, dl_b=ffffffffb837c080, dl_b->total_bw=104856, dl_b->bw=996147
[    0.374498] __dl_overflow: dl_b=ffffffffb837c080, dl_b->bw=996147, cap=2048, cap_scale=1992294 dl_bw->total_bw=104856, old_bw=0, new_bw=52428
[    0.375507] dl_server_apply_params: cpu=3, runtime=50000000, period=1000000000, cpus=3, cap=3072, init=1, dl_b=ffffffffb837c080, dl_b->total_bw=157284, dl_b->bw=996147
[    0.376498] __dl_overflow: dl_b=ffffffffb837c080, dl_b->bw=996147, cap=3072, cap_scale=2988441 dl_bw->total_bw=157284, old_bw=0, new_bw=52428
[    0.377507] dl_server_apply_params: cpu=4, runtime=50000000, period=1000000000, cpus=4, cap=4096, init=1, dl_b=ffffffffb837c080, dl_b->total_bw=209712, dl_b->bw=996147
[    0.378498] __dl_overflow: dl_b=ffffffffb837c080, dl_b->bw=996147, cap=4096, cap_scale=3984588 dl_bw->total_bw=209712, old_bw=0, new_bw=52428
[    0.379505] dl_server_apply_params: cpu=5, runtime=50000000, period=1000000000, cpus=5, cap=5120, init=1, dl_b=ffffffffb837c080, dl_b->total_bw=262140, dl_b->bw=996147
[    0.380498] __dl_overflow: dl_b=ffffffffb837c080, dl_b->bw=996147, cap=5120, cap_scale=4980735 dl_bw->total_bw=262140, old_bw=0, new_bw=52428
[    0.381504] dl_server_apply_params: cpu=6, runtime=50000000, period=1000000000, cpus=6, cap=6144, init=1, dl_b=ffffffffb837c080, dl_b->total_bw=314568, dl_b->bw=996147
[    0.382498] __dl_overflow: dl_b=ffffffffb837c080, dl_b->bw=996147, cap=6144, cap_scale=5976882 dl_bw->total_bw=314568, old_bw=0, new_bw=52428
[    0.384527] dl_server_apply_params: cpu=7, runtime=50000000, period=1000000000, cpus=7, cap=7168, init=1, dl_b=ffffffffb837c080, dl_b->total_bw=366996, dl_b->bw=996147
[    0.385498] __dl_overflow: dl_b=ffffffffb837c080, dl_b->bw=996147, cap=7168, cap_scale=6973029 dl_bw->total_bw=366996, old_bw=0, new_bw=52428
     ...
[    0.388556] __dl_server_attach_root: cpu=0, new_bw=52428, dl_b=ffff949bc080e040, dl_b->total_bw=52428, dl_b->bw=996147
[    0.389507] __dl_server_attach_root: cpu=1, new_bw=52428, dl_b=ffff949bc080e040, dl_b->total_bw=104856, dl_b->bw=996147
[    0.390501] __dl_server_attach_root: cpu=2, new_bw=52428, dl_b=ffff949bc080e040, dl_b->total_bw=157284, dl_b->bw=996147
[    0.391503] __dl_server_attach_root: cpu=3, new_bw=52428, dl_b=ffff949bc080e040, dl_b->total_bw=209712, dl_b->bw=996147
[    0.392499] __dl_server_attach_root: cpu=4, new_bw=52428, dl_b=ffff949bc080e040, dl_b->total_bw=262140, dl_b->bw=996147
[    0.393499] __dl_server_attach_root: cpu=5, new_bw=52428, dl_b=ffff949bc080e040, dl_b->total_bw=314568, dl_b->bw=996147
[    0.394428] __dl_server_attach_root: cpu=6, new_bw=52428, dl_b=ffff949bc080e040, dl_b->total_bw=366996, dl_b->bw=996147
[    0.394499] __dl_server_attach_root: cpu=7, new_bw=52428, dl_b=ffff949bc080e040, dl_b->total_bw=419424, dl_b->bw=996147


I added a printk in __dl_server_attach_root which is called after the
dynamic rd is built to transfer bandwidth to it.

__dl_server_attach_root came with d741f297bceaf ("sched/fair: Fair
server interface"), do you have this change in your backport?

> So if rd changes during boot initialization, the correct dl_bw has to be
> updated AFAICS. Also if cpusets are used, the rd for a CPU may change.

cpusets changes are something that I still need to double check. Will
do.


