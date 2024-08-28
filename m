Return-Path: <linux-kernel+bounces-304957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 039FA962755
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5DC284851
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9DA176AB1;
	Wed, 28 Aug 2024 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxlx5hPj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0444C15A86D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724848767; cv=none; b=gqAUL5yyiR1WOJDhdH3fN7pN5Y8zTslTdvfRoJxt1htEJ4Zic8UCor5rVboKVQcQc7czZT8i/mJOnyc6mxxUL8XISUpv/QxNWZfJhiwoxoUBcdW3iMGiUibyyCw6lVbU6Blyg12ouCNClB3/Y/HItBbTv2QPhPuMYwrLVh8PRag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724848767; c=relaxed/simple;
	bh=hX1hLy2MoKUQXvF/Gq0xzF+0GkfTu7wR3OxlMH7WLck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bciRd9iAdpD9VzA9WCpHK+pTmDHRpkH7WcLpkrTReLEp/c5sGF7HOxQhTZm1kQyFvjWd/YQUW1HIUh44pof/5SW4zSG24Fe+/ErSODQjLTDcbTsOAZkjm1DVi7q070kpo8ntzeaVKR48LAiW13GWhmAOb1XtgPOjqJUdu93qd6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxlx5hPj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724848765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Wi7gol5AezBn3aW0wWddaLOyN2Kl2M8xOXpQkaOx4o=;
	b=dxlx5hPj5NIrtUgvo11FnpstAFnq111R99hjrc8AgXzI2vuVfoyMTPsAZr0dCRngTXJ7D3
	FsNt/9WiX3EVVOEExE5DunOJGdpgPH0mQqiUKH69ElWl3JehVwdE+YEPd/0MvTYBjffI4F
	Q7WvLSVIQlO5+X6Z0JehKWWrlLHf23A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-TH0JqPcrOua9dk1uCuB7HA-1; Wed, 28 Aug 2024 08:39:23 -0400
X-MC-Unique: TH0JqPcrOua9dk1uCuB7HA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-371ab0c02e0so5384778f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 05:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724848762; x=1725453562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Wi7gol5AezBn3aW0wWddaLOyN2Kl2M8xOXpQkaOx4o=;
        b=oF0Mms/EcGYxSf9+uPw2stINdsay92pfyhxTOeinA13dEz15HNjs7+hB60WL/cvsFZ
         QsyLp3wilATuFnPrBqKuJ8rSkeHig0PIEIVm/RMtW7AYp7wPl49W+nr8+K7ykbzEaOtP
         ZISgtk/MlRle+JIVmTu7Z3fCood7hg+3UpPPyClGgiHfeFwVC16Cno8t8RXEuwNLiHsT
         aD3nMq1Wyw/aA0yYFXYfuZ0WKa8PUsAoJCFQzCdKJvYRitcO9N6DmN+RYPH3GhEoCWI/
         IQmvS3NLMhKrWHwdHEl4xJqS6eMTQi5sAi67I3Ga+Vkk+Lb0xSb0iculKPeQAas7J7l3
         Xrtg==
X-Forwarded-Encrypted: i=1; AJvYcCXZHwtNoBZHcHuZyfGfg9M3SjqSd4hco5K2FgQuCAWK9F7kwXywSKkyaFrSJQQFmtRflCS3utKX3IPF8po=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKXpwq4ALHSDS6c/83JNmFeUkFC3L4E5o63LqR/R2snDlj7pFX
	MnHFWmvY+pBzCzoL60ErLcsd/1G78BCRlxXtTS5FqH8UA/oO5Fe8RUdFh5mJ++1MTH9l/OSMHBY
	+HpPG7khhsT8Jns2+7/v3QXEAeFig3rhUB14JH3LBINgEdmPdQLMjAQkGtmaDtQ==
X-Received: by 2002:a5d:6052:0:b0:36b:d3eb:17a5 with SMTP id ffacd0b85a97d-37311864639mr12918686f8f.36.1724848762093;
        Wed, 28 Aug 2024 05:39:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaLcfAmQD9dkeCY3RwnM3bsIBMHfTMDkKq58vpwHc85uEDQb5RGpoQaD0FEd6wKQiChbaMkA==
X-Received: by 2002:a5d:6052:0:b0:36b:d3eb:17a5 with SMTP id ffacd0b85a97d-37311864639mr12918654f8f.36.1724848761523;
        Wed, 28 Aug 2024 05:39:21 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.33.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308161042sm15497617f8f.59.2024.08.28.05.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 05:39:21 -0700 (PDT)
Date: Wed, 28 Aug 2024 14:39:19 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: mingo@redhat.com, patches@amperecomputing.com, peterz@infradead.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, vineeth@bitbyteword.org, bristot@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/deadline: fix the hang in dl_task_of
Message-ID: <Zs8ad6eQiKpIaKIo@jlelli-thinkpadt14gen4.remote.csb>
References: <20240828091141.12043-1-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828091141.12043-1-shijie@os.amperecomputing.com>

Hi,

On 28/08/24 17:11, Huang Shijie wrote:
> When we enable the schedstats, we will meet an OS hang like this:
>   --------------------------------------------------------
> 	[  134.104253] kernel BUG at kernel/sched/deadline.c:63!
> 	[  134.132013] ------------[ cut here ]------------
> 	[  134.133441]  x27: 0000000000000001
> 	[  134.138048] kernel BUG at kernel/sched/deadline.c:63!
> 	[  134.146478] x26: 0000000000000001 x25: 0000000000000000 x24: 0000000000000001
> 	[  134.153607] x23: 0000000000000001 x22: 0000000000000000 x21: 0000000000000001
> 	[  134.160734] x20: ffff007dbf1b6d00 x19: ffff007dbf1b7610 x18: 0000000000000014
> 	[  134.162027] ------------[ cut here ]------------
> 	[  134.167861] x17: 000000009deab6cd x16: 00000000527c9a1c x15: 00000000000000dc
> 	[  134.172473] kernel BUG at kernel/sched/deadline.c:63!
> 	[  134.179595] x14: 0000000001200011 x13: 0000000040001000 x12: 0000ffffb6df05bc
> 	[  134.191760] x11: ffff007dbf1b6d00 x10: ffff0001062dd2e8 x9 : ffff8000801215ac
> 	[  134.192036] ------------[ cut here ]------------
> 	[  134.198888] x8 : 0000000000000000 x7 : 0000000000000021 x6 : ffff0001764ed280
> 	[  134.203498] kernel BUG at kernel/sched/deadline.c:63!
> 	[  134.210622] x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff807d3dd24000
> 	[  134.222787] x2 : 000000028b77a140 x1 : 0000003400000000 x0 : ffff007dbf1b6c80
> 	[  134.229915] Call trace:
> 	[  134.232353]  dl_task_of.part.0+0x0/0x10
> 	[  134.236182]  dl_server_start+0x54/0x158
> 	[  134.240013]  enqueue_task_fair+0x138/0x420
> 	[  134.244100]  enqueue_task+0x44/0xb0
> 	[  134.247584]  wake_up_new_task+0x1c0/0x3a0
> 	[  134.251584]  kernel_clone+0xe8/0x3e8
> 	[  134.252022] ------------[ cut here ]------------
> 	[  134.255156]  __do_sys_clone+0x70/0xa8
> 	[  134.259764] kernel BUG at kernel/sched/deadline.c:63!
> 	[  134.263412]  __arm64_sys_clone+0x28/0x40
> 	[  134.272360]  invoke_syscall+0x50/0x120
> 	[  134.276101]  el0_svc_common+0x44/0xf8
> 	[  134.279753]  do_el0_svc+0x28/0x40
> 	[  134.283058]  el0_svc+0x40/0x150
> 	[  134.286195]  el0t_64_sync_handler+0x100/0x130
> 	[  134.290546]  el0t_64_sync+0x1a4/0x1a8
> 	[  134.294200] Code: 35ffffa2 17ffffe3 d4210000 17ffffb4 (d4210000)
> 	[  134.300283] ---[ end trace 0000000000000000 ]---
> 	[  134.304890] Kernel panic - not syncing: Oops - BUG: Fatal exception
> 	[  134.311147] SMP: stopping secondary CPUs
> 	[  135.365096] SMP: failed to stop secondary CPUs 8-9,16,30,43,86,88,121,149
> 	[  135.371884] Kernel Offset: disabled
> 	[  135.375361] CPU features: 0x00,00100003,80153d29,d75ffea7
> 	[  135.380749] Memory Limit: none
> 	[  135.383793] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]
>   --------------------------------------------------------
> 
> In dl_server_start(), we set the dl_se->dl_server with 1. When schedstats
> is enabled, in the following:
>    dl_server_start() --> enqueue_dl_entity() --> update_stats_enqueue_dl()
> 	__schedstats_from_dl_se() -->dl_task_of()
> 
> we will meet the BUG_ON.
> 
> Since the fair task has already had its own schedstats, there is no need
> to track anything for the associated dl_server.
> 
> So add check in enqueue_dl_entity(), skip the update_stats_enqueue_dl()
> for a dl_server dl_se.

OK, but I think we want to avoid all potentially problematic paths
eventually calling __schedstat_from_dl_se() for dl_server dl_se(s)?

Maybe we should return early from within update_stats_*_dl() functions,
I'm thinking.

Thanks,
Juri


