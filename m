Return-Path: <linux-kernel+bounces-324276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA963974A86
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8899E28897B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9D4139D13;
	Wed, 11 Sep 2024 06:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJw84cNq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167F32C1B4
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726036994; cv=none; b=kwnyYkrSB7eLei7Wyd7WG+aLNjPwG3yuiHznqF4UcMcxUvv5fH6TQKJ/ZYWMSEjwsziShq1mA8t72m2pYy4Lu1tu8GadM64c3oxA6BxJ1SP+JltmQ3xVD8OpfiuxZ92YQiLC8i+tTvyxpqdUjz5UnkTcxWoLcij527GlxlXpCFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726036994; c=relaxed/simple;
	bh=3cWG+X4tIryXCXOVKA+yf4o3lQhStXuPl/otjwBQ0v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=CsV022dCvvZ+uKxWtuNF19fB0v2OSw1x7RzHCMtRsgY8Q+MJ/3UpBzT7DrHt0IWGS+lxbYYbwnkXddU2GFrJL3LthjgPQ+rI8eNklUVZvi7QB4WDCvsaVa9Pu603FxXEI6cDtwr3bDQ4RGoHMoDNg0K0Jdj92zV28cOaNPBc13s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJw84cNq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726036991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GG53hfFZsBWWfq8LdPjycb2UAQG90BS+o/E8pJ1P9Wk=;
	b=ZJw84cNqC35uLy6i9UmDKipLnrkhB/yuHjJuz0aSe9U5rQNjMib2Qm3JQcMRtyzVnsYhfk
	R5LXco6FpWYgU69uhJRxx3W1mryhXgnLaDRVL60Cakyarcc0Tixoov79KBIqobLBpV4gUV
	9l02xihVViyeVSGMaLFp0u1uuHPwR9w=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-UZz4AON7PyaEb3zcGipxEw-1; Wed, 11 Sep 2024 02:43:10 -0400
X-MC-Unique: UZz4AON7PyaEb3zcGipxEw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7179469744dso2565247b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726036990; x=1726641790;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GG53hfFZsBWWfq8LdPjycb2UAQG90BS+o/E8pJ1P9Wk=;
        b=kLp7TIyjgGFhsAtyy47b/36gk2tAkr14qUMghvHUb896pnHCbOZB+i9Uv3qVb9lPZq
         5xRwYJKJ8Pwiu8CWuBFJ3BimMershCDpo89Jjw7fD4Zr7x0j4egaxUF/TabFecH2newE
         6ilWbGTvb7vsevsZRb9sIaoP3Its28sRCkr2NfIJis5y5aiMhH7RqD1PnRX4cCT32usU
         vxStOeUZvHgBliL1mo4fqXzydyw6lIP+V3XIdDrsIEuGEsJnEWGQZ2IJDC/D8q5VK361
         ezygF5Np4FVDWW9SPF69MpP6tnr3XaC2EV6GZ2IsHeVXKT/N2FMS1MXrLmTcJprw5Zb2
         J50Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4iRrbKbfjQeTasAMfEpkNpmuNWoSnUrfxf8O/dDweeUIThMbLfYFvh0tPLFeIrWUzfV7L4xxgUps3udU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtleVp6GjDFrn2g8ZAl+03wAM1KW+vETGSOeruEmmQclyaeDin
	HVRl9X5Vor5Dzl96ZBDy3oUdW3ajQyfI7884kWLUghSp6x2tGMmtDmB15Rn9WVE4SzB416Dg8Pg
	BqNoRbV45U9/bMvucTjbbo4IMJVPXbOZwBJhc9xHIWgfB7atdvoRFH3OB174Rwg==
X-Received: by 2002:a05:6a00:b45:b0:719:1df4:9d02 with SMTP id d2e1a72fcca58-7191df49f2cmr979018b3a.25.1726036989580;
        Tue, 10 Sep 2024 23:43:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwuQeX0ud6nORQ8TR0AXWmS5VlyhnVnzN28k65Xqpf2kX3IMRBU8JsICzb8QWIa+FRdpdzag==
X-Received: by 2002:a05:6a00:b45:b0:719:1df4:9d02 with SMTP id d2e1a72fcca58-7191df49f2cmr978995b3a.25.1726036989042;
        Tue, 10 Sep 2024 23:43:09 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a800:3c59:c8f1:7d33:571a:fde2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71909003573sm2398061b3a.90.2024.09.10.23.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 23:43:08 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 0/4] Introduce QPW for per-cpu operations
Date: Wed, 11 Sep 2024 03:42:49 -0300
Message-ID: <ZuE76YaeJGl1pCuQ@LeoBras>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905221908.1960-1-hdanton@sina.com>
References: <Zp/k+rJuVV+EcXqL@tpad> <20240905221908.1960-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Sep 06, 2024 at 06:19:08AM +0800, Hillf Danton wrote:
> On Tue, 23 Jul 2024 14:14:34 -0300 Marcelo Tosatti <mtosatti@redhat.com>
> > On Sat, Jun 22, 2024 at 12:58:08AM -0300, Leonardo Bras wrote:
> > > The problem:
> > > Some places in the kernel implement a parallel programming strategy
> > > consisting on local_locks() for most of the work, and some rare remote
> > > operations are scheduled on target cpu. This keeps cache bouncing low since
> > > cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> > > kernels, even though the very few remote operations will be expensive due
> > > to scheduling overhead.
> > > 
> > > On the other hand, for RT workloads this can represent a problem: getting
> > > an important workload scheduled out to deal with remote requests is
> > > sure to introduce unexpected deadline misses.
> > 
> > Another hang with a busy polling workload (kernel update hangs on
> > grub2-probe):
> > 
> > [342431.665417] INFO: task grub2-probe:24484 blocked for more than 622 seconds.
> > [342431.665458]       Tainted: G        W      X  -------  ---  5.14.0-438.el9s.x86_64+rt #1
> > [342431.665488] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [342431.665515] task:grub2-probe     state:D stack:0     pid:24484 ppid:24455  flags:0x00004002
> > [342431.665523] Call Trace:
> > [342431.665525]  <TASK>
> > [342431.665527]  __schedule+0x22a/0x580
> > [342431.665537]  schedule+0x30/0x80
> > [342431.665539]  schedule_timeout+0x153/0x190
> > [342431.665543]  ? preempt_schedule_thunk+0x16/0x30
> > [342431.665548]  ? preempt_count_add+0x70/0xa0
> > [342431.665554]  __wait_for_common+0x8b/0x1c0
> > [342431.665557]  ? __pfx_schedule_timeout+0x10/0x10
> > [342431.665560]  __flush_work.isra.0+0x15b/0x220
> 
> The fresh new flush_percpu_work() is nop with CONFIG_PREEMPT_RT enabled, why
> are you testing it with 5.14.0-438.el9s.x86_64+rt instead of mainline? Or what
> are you testing?
> 
> BTW the hang fails to show the unexpected deadline misses.

I think he is showing a client case in which my patchset would be helpful, 
and avoid those stalls in RT=y.

> 
> > [342431.665565]  ? __pfx_wq_barrier_func+0x10/0x10
> > [342431.665570]  __lru_add_drain_all+0x17d/0x220
> > [342431.665576]  invalidate_bdev+0x28/0x40
> > [342431.665583]  blkdev_common_ioctl+0x714/0xa30
> > [342431.665588]  ? bucket_table_alloc.isra.0+0x1/0x150
> > [342431.665593]  ? cp_new_stat+0xbb/0x180
> > [342431.665599]  blkdev_ioctl+0x112/0x270
> > [342431.665603]  ? security_file_ioctl+0x2f/0x50
> > [342431.665609]  __x64_sys_ioctl+0x87/0xc0
> 


