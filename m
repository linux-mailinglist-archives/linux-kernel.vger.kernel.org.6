Return-Path: <linux-kernel+bounces-306375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A84963E24
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE831C241D1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19D418A6C8;
	Thu, 29 Aug 2024 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgOfs7AH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4A318A6A4
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724919252; cv=none; b=TGa5Y+I1qP4pEXz5TIf9OAGgbYKex33Kun/hoxErCxiyEDTELROBnIp9gDhrYmGD/zv2jopd3ykj2Lh8nvVNi2qCq51d4Mo0+zjvID7CiH/I1umcBIfmCaVAQxebuj+uVSBCWzwI6LUqqi33SDFr/jO/q4Dly02zwjh2iVUu9hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724919252; c=relaxed/simple;
	bh=C63qneNtil0ILxvX2PmFNrec6dbDbLg9jnXehRXdwaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqOBh3wfQgDvScYPSC400j7GXWedz3/RnkX5lihVmY5l6sZejzT8g4bAKMirve2fjFMJA4XdlqVFdd9kkz/h/x0f6vTvSOifVgeXlEc27bbgHEDUyV7a86WRz7NfJBLfRnVg5QuZGnWM+/A1xZMqubi/UEyIUfKQvf/VNw5tRZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SgOfs7AH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724919248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q1j+4TK2NxmQ3QaGv4Fl11VeIRELMS2HVZQYGsINBHY=;
	b=SgOfs7AHWtOhHPSZf+85z3oP/7KMsM17yUIMDZlynoKaBOBlMjd+Fh78BBUMXEaPkWlVUk
	1Bt7MERmEX7cGfGAchTV2h753jnX16s5FeR5U15RZ3senF+D4MWotpxp7Mo9C8n4iciYt3
	xY5WkHj1GdwIsMoWTPKxKedrQV+HyqE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-SQaX-dhXM9ahEr1Yg8xD-A-1; Thu, 29 Aug 2024 04:14:06 -0400
X-MC-Unique: SQaX-dhXM9ahEr1Yg8xD-A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374939415easo261140f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724919245; x=1725524045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1j+4TK2NxmQ3QaGv4Fl11VeIRELMS2HVZQYGsINBHY=;
        b=bATgzUgcILGMjf02fLVD2abWk4/us/Wd+KKvePfRS2tHA3+rN22gDwHIHwBjCo6xfg
         hDQhCL7MVLXsz9dPcJ6DNQjQmbUZTnv+3UtZrjdPeb/TqrXcjpke352FxHsq2MRb31DA
         0Fi9LzcosyFksiGRX14YsRzSXeoOc9eI4NE7YbigNk3dUsqz5YcqlAnwtRod9L+PPxiM
         d9Wq+hGCUlBBqsJG+rNPLiMsQeLgZMq9rTX0tNhRRSSxgdHvyNHYQs1+6CLve7L3soUY
         +vWxoOyhPXTYBoRwYL8n0Z0TP4c16rny4lC7npNSMRwvA9RUqbYdRwylNfA6SQ9EXd9W
         p8hQ==
X-Forwarded-Encrypted: i=1; AJvYcCV45vyPoi+rAeA0rcPFaAz813IbogHsGu8ACcNEYZ5WsCzCd9ULYButCgwnV8omZuYGfTavejF5OofRcbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiwoho3i1C68Vd+b89YnAhALKvcxAnI9SGtB6JcZa4Dcd+fQqC
	VwYx6KWFBzFchWwgZeQk4EB6rSZidWBouy4l3jEzAIIwz9zFPJGzc11cSSZiRVla4RVv9tXjIk3
	fJf3EGbw857DSH3P/Gn3wFUVx9L7I4git0JZBTVuXwoVZgPogU8J2bJ/F8ssZrw==
X-Received: by 2002:a5d:54c2:0:b0:368:4c38:a669 with SMTP id ffacd0b85a97d-3749b52eb0bmr1349375f8f.10.1724919245380;
        Thu, 29 Aug 2024 01:14:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp1YhG1YEmCwdoqkOXUHdcT8XnXmrRdIDliSy2CWT1PhF7TZlc9ZynOLbd2m/V1fdBI84jtQ==
X-Received: by 2002:a5d:54c2:0:b0:368:4c38:a669 with SMTP id ffacd0b85a97d-3749b52eb0bmr1349339f8f.10.1724919244835;
        Thu, 29 Aug 2024 01:14:04 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.33.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639643esm43482865e9.1.2024.08.29.01.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:14:04 -0700 (PDT)
Date: Thu, 29 Aug 2024 10:14:02 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: mingo@redhat.com, patches@amperecomputing.com, peterz@infradead.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, vineeth@bitbyteword.org, bristot@kernel.org,
	linux-kernel@vger.kernel.org, hongyan.xia2@arm.com
Subject: Re: [PATCH v3] sched/deadline: fix the hang in dl_task_of
Message-ID: <ZtAtymo-KB9c20Q8@jlelli-thinkpadt14gen4.remote.csb>
References: <20240829031111.12142-1-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829031111.12142-1-shijie@os.amperecomputing.com>

Hi,

On 29/08/24 11:11, Huang Shijie wrote:
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
> So add check in:
>             update_stats_wait_start_dl()
> 	    update_stats_wait_end_dl()
> 	    update_stats_enqueue_dl()
> 	    update_stats_dequeue_dl()
> 
> return early for a dl_server dl_se.
> 
> Tested this patch with memcached in Altra.
> 
> Fixes: 5f6bd380c7bd ("sched/rt: Remove default bandwidth control")
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
> v2 --> v3:
>    Return early in:
>             update_stats_wait_start_dl()
> 	    update_stats_wait_end_dl()
> 	    update_stats_enqueue_dl()
> 	    update_stats_dequeue_dl()

This looks better, thanks.

Peter, what do you think?

Best,
Juri


