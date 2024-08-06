Return-Path: <linux-kernel+bounces-276520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520499494DF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7208B1C23710
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A2F38382;
	Tue,  6 Aug 2024 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zz3rVwxD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B21946F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959603; cv=none; b=DDJTDpFYU/rz53o+aoij/72YXqb0+39t7hfXE63ukkhNUwIiNJm48HNA2fFVEEeMA4yLM1+MTfB5Q5PDVgDHroJ+WdTg7wcIzYLV3eo8NQs31qCfISWyrEWwNoKyC/T5qF1eGE7cmWNYf1r/9j5mOBmMTJcN4trHuCetAu77ETc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959603; c=relaxed/simple;
	bh=A+i3SJaMQSi4qXke1HZ7gPMdCRVR5PaNut4kzXUujhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf+HLq/RJucvPvnD2Y45N6f3cWdB7Ix2AFGduzQMpk222EfF9GhuN8LgNFx0R6Rl7jOB5XQWKhzCPETB5xzhGgcibCvSzmKe/3DBsumCHZTjkyLIuhEa/WUghUFoM6C1cePA9EJwFtJYkHPSwzirhqCfOFsjSAoDe1Z9pQELP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zz3rVwxD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722959600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9UD0Jw05zo3Zj1VI2tYqdujVE+E+8rHDPdQz+qajNaQ=;
	b=Zz3rVwxDnOZHizqL5+IpByG5cYn/FVPXlUo7oHeQ+nzgUE3uZ3dheYmrSrqDHLRlv7HbaH
	XC3HjnFcns29ozDpgdJuOxrpqpPgoN2F2t5G4jMPYUKBYi9oskoY3m8RMwo7x1EuarR3TN
	1VzJtwUs6VKm2F8uWmzSOoxh+ctrS+w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-krutXpwgNUOnra2NaUVWrA-1; Tue, 06 Aug 2024 11:53:16 -0400
X-MC-Unique: krutXpwgNUOnra2NaUVWrA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428fb72245bso5902135e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 08:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722959595; x=1723564395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UD0Jw05zo3Zj1VI2tYqdujVE+E+8rHDPdQz+qajNaQ=;
        b=Rn7G5JEjTdU94whfxfm3CIJIZwkHnN8kQ9IqiUVr0OV2CiH4J7rKdEWmPdYMVAUBgJ
         ZmmsYmAOtTQcOoADTOq9HGGPajuOM7zb+Kmqu8GZeOWMBzYVjWFWfFl0bAv4Hjm78IkF
         F7gjfshX9LDPjRRlHjKP2xWOFvPFbkVyX7/QPy+bRl5Yiehb8fWBCuG5FVPO7Zws0wD9
         GzoBJw1wtqetsUSajBfTIdu/Qiex/H7lz0ZuKxI/VXRIHy+sacnJ7R5tJh7WaJuKQplJ
         mwztjwBiqFllXCT4VkQEKxhqTrmXJ2CUOVvfQAExon7QC69CTJe2aYR3g7AyoCCfPg/6
         U4IA==
X-Forwarded-Encrypted: i=1; AJvYcCV9eJVbsZyvdva6skcsa9w+ifwsC8L82WZRofnW1R7l+lAqmsE4V1wk58w7xGDQFoOHmC47kWazgJoyrevqqohGFicvOlhLuYMhkoRk
X-Gm-Message-State: AOJu0Yy+x7d+p6IfqrH4hC5vuWNiyH/yOnynj2yyjRpn5Ym7THEw8a9k
	LXOvUlCs22uCSfr2kCBilcYMUdvZKuinRcYbXauXuck6DmQYXFvMp3hm//DCIY+zNrNEaX4Nqgu
	4nZ6xx4u41RZKioV6Sm/42syHMlQJU3++Ucp+tmpkt+Biy5xS8uYFTbhswdbjTA==
X-Received: by 2002:a05:600c:4fd5:b0:428:837:7015 with SMTP id 5b1f17b1804b1-428e478cf83mr145934015e9.13.1722959595390;
        Tue, 06 Aug 2024 08:53:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIlwrKAD+SBPIAzanZG/6Hiz6wydVc6e2RnpFoDIp1PQtlnWhPYRQw0BqE3UES07bPqhM27A==
X-Received: by 2002:a05:600c:4fd5:b0:428:837:7015 with SMTP id 5b1f17b1804b1-428e478cf83mr145933785e9.13.1722959594920;
        Tue, 06 Aug 2024 08:53:14 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.159.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd02b15csm13510432f8f.65.2024.08.06.08.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:53:14 -0700 (PDT)
Date: Tue, 6 Aug 2024 17:53:12 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] mm/memory-failure: Use raw_spinlock_t in struct
 memory_failure_cpu
Message-ID: <ZrJG6OtoQCUadS9L@jlelli-thinkpadt14gen4.remote.csb>
References: <20240806142535.1033323-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806142535.1033323-1-longman@redhat.com>

Hi Waimain,

On 06/08/24 10:25, Waiman Long wrote:
> The memory_failure_cpu structure is a per-cpu structure. Access to its
> content requires the use of get_cpu_var() to lock in the current CPU
> and disable preemption. The use of a regular spinlock_t for locking
> purpose is fine for a non-RT kernel.
> 
> Since the integration of RT spinlock support into the v5.15 kernel,
> a spinlock_t in a RT kernel becomes a sleeping lock and taking a
> sleeping lock in a preemption disabled context is illegal resulting in
> the following kind of warning.
> 
>   [12135.732244] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>   [12135.732248] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 270076, name: kworker/0:0
>   [12135.732252] preempt_count: 1, expected: 0
>   [12135.732255] RCU nest depth: 2, expected: 2
>     :
>   [12135.732420] Hardware name: Dell Inc. PowerEdge R640/0HG0J8, BIOS 2.10.2 02/24/2021
>   [12135.732423] Workqueue: kacpi_notify acpi_os_execute_deferred
>   [12135.732433] Call Trace:
>   [12135.732436]  <TASK>
>   [12135.732450]  dump_stack_lvl+0x57/0x81
>   [12135.732461]  __might_resched.cold+0xf4/0x12f
>   [12135.732479]  rt_spin_lock+0x4c/0x100
>   [12135.732491]  memory_failure_queue+0x40/0xe0
>   [12135.732503]  ghes_do_memory_failure+0x53/0x390
>   [12135.732516]  ghes_do_proc.constprop.0+0x229/0x3e0
>   [12135.732575]  ghes_proc+0xf9/0x1a0
>   [12135.732591]  ghes_notify_hed+0x6a/0x150
>   [12135.732602]  notifier_call_chain+0x43/0xb0
>   [12135.732626]  blocking_notifier_call_chain+0x43/0x60
>   [12135.732637]  acpi_ev_notify_dispatch+0x47/0x70
>   [12135.732648]  acpi_os_execute_deferred+0x13/0x20
>   [12135.732654]  process_one_work+0x41f/0x500
>   [12135.732695]  worker_thread+0x192/0x360
>   [12135.732715]  kthread+0x111/0x140
>   [12135.732733]  ret_from_fork+0x29/0x50
>   [12135.732779]  </TASK>
> 
> Fix it by using a raw_spinlock_t for locking instead.

IIUC this is executed to recover a fault condition already, so maybe
latencies are of no interest at that point, but I wonder if something
like 

https://elixir.bootlin.com/linux/v6.10.1/source/Documentation/locking/locktypes.rst#L434

would still work and save us from introducing a raw_spinlock?

Or maybe the critical section is anyway tiny and we don't care either?

Thanks,
Juri


