Return-Path: <linux-kernel+bounces-303362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0472960B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866CB28146B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E24D1BC9EA;
	Tue, 27 Aug 2024 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBFQ93mJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0DB19E825
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763430; cv=none; b=F3KnHF4EW5z2paoJ0AAbAlOS8nBUhwzLG7jcSrUxg80rmHatNlt/q4ZtyM6++hYfbQIUshNBx39HNmviPoBG0dDz9K74eEe73lgcdVJpueke+CO2BKXM3DdkKqBPTJSQOT+q8wf6xm813p5S/RyCHraYoRnS/+knYqRy3K3nCoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763430; c=relaxed/simple;
	bh=XzQyA4uyTumJb3tdbuxLPAeEDxZUbttVSgddJCasrag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQ9PMZzhIgz6ktwvEMp6f0MKKEs3lJAb4MdGSifsOHTQy8mEtULjy2+6cjGOEzGla1vdGoCRfa09EyTwksG0kzIepJvdfoV7heKw2rexTP+0sb2h8n5djSfp5oP3kyUC82XeOvtH20ASsW2CjfrsgI2Sugh0wrNHRia/PCwxGz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBFQ93mJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724763427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tLWQGTx1k8HON3odrzDwkOHpmdsdJq4M5D3yzTDZAng=;
	b=gBFQ93mJzA6QVChjS+zXbOMzAWLcK+8O5mNJVbzfbYmFaRFBLCunWUiAjoElZPJHGnkhGA
	6Zbtu3hP7i1qG7RtgBt63mNXJca/QdFhDlvqY0Q803KZ/FcmqCtoGdUXzoaA+BMNtBYjPq
	HAlemHreMT1oouZy920AI+EcJTawSe4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-pFVsP7yQPmaXfH5fDINGPw-1; Tue, 27 Aug 2024 08:57:06 -0400
X-MC-Unique: pFVsP7yQPmaXfH5fDINGPw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280cf2be19so49104155e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724763425; x=1725368225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLWQGTx1k8HON3odrzDwkOHpmdsdJq4M5D3yzTDZAng=;
        b=nJaJhBCWJlDjIa1f/Fztao8uG8bRDQJqrUHOifDOFqa7ZqqW56MD3jH/Woo0/nl+E3
         +o7caiEnz0p84dLH4Mejymdr7OG1yYRoOqThNFwg+8fLbauGmnp9ZM7XC0ZJUA+cjstB
         9Bd83XFcmg/GhTR+ZvtERGT/I6ufLWBwiFgF5hsXD3b9ky/42/k/hzf6mpphaftnDIpH
         iQiYmV9WZK0e3hDANZ2J70HQMZ8o4vHvjKtJsrUJ5Hc0r8aRL5OeURuZS4CVsU0ZY/CM
         i4tTneRsEvFgporIUAl9OAfbIAfLRFe5tUY9HiZLAuu6ToQVYBWXOBDHpQxciDvN1EoH
         gTRA==
X-Forwarded-Encrypted: i=1; AJvYcCXQGycq3z/D1KzjvrJV+prKZPrSkxLC7W2sLth0nQEpH/k8z6Q90M3BoB6fp2zQsPXBRHYnYvSg724HyLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD+ucioJwCIe1cqRtqDGj/sqbNCoUiqt+W2WbCA1UeSY7+UAPN
	ixRTgvuJ+WhOm/JO5A6jMJzigknt7FgajjSxUF4YgTiMDcIg1rezzHzO2SptGCs3YwoK853h0vD
	0zGdh0KPXR1Goo3Q5931Y5eQCdh7SZvi74t47KEF8cQ7GcBeMuBXsbNAH/Wdekw==
X-Received: by 2002:a05:600c:1990:b0:426:6696:9e50 with SMTP id 5b1f17b1804b1-42acc8d4d91mr85517605e9.14.1724763425144;
        Tue, 27 Aug 2024 05:57:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdF3iac/7GeyJWqpFmIIs/SqlBUiGNRHb0Zl6icc+uf0fnXZk2rjJ3VKv5izKlh1a5pcRNPg==
X-Received: by 2002:a05:600c:1990:b0:426:6696:9e50 with SMTP id 5b1f17b1804b1-42acc8d4d91mr85517305e9.14.1724763424513;
        Tue, 27 Aug 2024 05:57:04 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.33.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac516251fsm182411145e9.25.2024.08.27.05.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:57:03 -0700 (PDT)
Date: Tue, 27 Aug 2024 14:57:01 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: mingo@redhat.com, patches@amperecomputing.com, peterz@infradead.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, vineeth@bitbyteword.org, bristot@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: fix the bug in dl_task_of
Message-ID: <Zs3NHRmJ-g6zKl5x@jlelli-thinkpadt14gen4.remote.csb>
References: <20240826021115.9284-1-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826021115.9284-1-shijie@os.amperecomputing.com>

Hi,

On 26/08/24 10:11, Huang Shijie wrote:
> When we enable the schedstat, we will meet an OS hang like this:
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
> So just remove the BUG_ON in dl_task_of to fix the hang.

AFAIU the fair task enqueue (the "real" one) eventually leading to this
BUG has already had its own schedstats tracking dealt with and I don't
think we need/want to track anything for the associated dl_server.

Shouldn't we rather return early if update_stats_{wait_start,wait_end,
enqueue_sleeper}_dl are called for a dl_server dl_se?

Thanks,
Juri


