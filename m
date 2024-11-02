Return-Path: <linux-kernel+bounces-393078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA9D9B9B9E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA57D1C20FB8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A54C4683;
	Sat,  2 Nov 2024 00:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAEuthYf"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39394690
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 00:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730508306; cv=none; b=bVnPcA44eWU6TOgZ4CVFtTGVqMHhQq7CxWKw9w2A6+geyAnvvsdHZedohr1+spoZxNIRNLs6iGi0X3rjT5w3eC3jWt/Blxy0ADbvP4IsytCqjkcOq9jTRHAYG0gFj5r4MJa1mDXFLdXCC7T6UDaMpqv+2wz5QXj+eokJZ7BIqbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730508306; c=relaxed/simple;
	bh=jpRD3eTMcPddO23rCzW0ZavWy2zn3C7yK4a8e2fkEDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5QBTO0sQYiXr2orQqWxUV05UcofQiSMzbN2Wga6WYyFy0uEX3NzHxzquD3/aUEClrHBUbs3g6+3ylpACNBiEDlroBTTLDdHQyY4YzS/XTiM5zm9v5Wk5QH3CY5BqcutBPzodWEsuS9n1ndGcRyoE10TfjdT4V6osCetfKYgJzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAEuthYf; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b157c9ad12so152307785a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 17:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730508304; x=1731113104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RieSEGRFECNoYnymVD5nrcg0rqpxUfp5OOHkWhYRlDU=;
        b=GAEuthYfB3J1ed5GdYT56pyI2RCTjOnXgNE2eGx1i2TGFLGg3VPcyYJMMJTZ/eAKeQ
         mjSblCcaUUDjFB3ZW2vMK16m5/lDg9OS11PciXSMhbFSeWvEudpj7HPsilUBWN06PZuI
         w55YjICMSdLRc8wJbmOslyssFowVAQKWgvAwHg6QJDYNPQFqx6GB7Pd2hRs2uaf71phe
         4umg6mZ/ygRTZuw40DGFCfvvdXQTiy7a5ZkDBufgK5Xmg7O6UF2fuov0iAYy6wl0KF2B
         JzkerYUkr/WLquwCSxuJ7Vb2ZbM1AApiDzrZyIJJewCYgxe+WiMbRkFcWf9uqPqVH49U
         ayHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730508304; x=1731113104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RieSEGRFECNoYnymVD5nrcg0rqpxUfp5OOHkWhYRlDU=;
        b=Q3SqCsBuBLdL+IWoTwfiX8qXMOBx9a7zbLOSbd1gUhadwps0r/urq2T1DaZXgnG1qN
         7nLtxEdigKEO2NVQxYEw2CoO8qxqJ3Zpla7bDc8MRhYBMd8pSxqZOfwlau0Gwd3WIS6x
         Cqt5J/WFhc8NdcQjUpFbfvo/Szff/A2DSCcxo2yBZszgw96tF8OgQXFF66x1rS8riQ2O
         i9iHcRJJBkVWBHDk/9guPzSVmGLOnLsmaaxBL4Mhd/mQnQG5B6N5jI6H1mS/3g8gpSf/
         B/ds6Dv+1D3z/+SwdI1li6bI4YGAYxX2SDZcakKWTjAWbIXC5MP8WSiZ4kgmsR/dk7+F
         op8A==
X-Forwarded-Encrypted: i=1; AJvYcCWC/WDoToKrXGBd2/haXO69iop5XEQ2jfuzf5sB6sjUMYv5jHArAT0hi0k4q4/OY5YzCDSuDvqFEsRfepc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqpGBADpF9CRobdmhJhJNQe2b8TfMS7j51ttWuClv0SODhNELV
	8klu+lbGQRO0BCGWduRfriQSriyzyqQvMXdAwKLnuxkJySzAi77yb6dKlA==
X-Google-Smtp-Source: AGHT+IHwzEJPY40lNB2fYE6ro24AkBISvOGNAksKj8u/0kD7eM//dLscLkM/7hKZIZMd+qssH/Kr1w==
X-Received: by 2002:a05:620a:1724:b0:7b1:4436:cf12 with SMTP id af79cd13be357-7b193eedb9amr3800573585a.25.1730508303664;
        Fri, 01 Nov 2024 17:45:03 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39e9b77sm219683885a.4.2024.11.01.17.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 17:45:03 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id C9A2E1200076;
	Fri,  1 Nov 2024 20:45:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 01 Nov 2024 20:45:02 -0400
X-ME-Sender: <xms:DnYlZ_szoPYy3mFONE3cYyIT-RRic4Z-LBxNhQOg3Y1-qi1lQD24xA>
    <xme:DnYlZwfAQ86J8SlPYZwu4iAIPv9wyFD0QSWKADs4OKEBbwW5FqwvB04quOoGp0Chz
    zWe_vzABDoEZWUcTA>
X-ME-Received: <xmr:DnYlZyxlM8H3CqjyFtzslAsNHcOWlxW4W4wqKLn2FokJs2E1uskAv8O3hEY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeltddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hhuggrnhhtohhnsehsihhnrgdrtghomhdprhgtphhtthhopegsihhgvggrshihsehlihhn
    uhhtrhhonhhigidruggvpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepvghlvhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepth
    hjsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhu
    nhgurghtihhonhdrohhrghdprhgtphhtthhopegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:DnYlZ-MHOyFGXoN9MYg8EcRkevU_zSHtqc53TSXZo42d_I0EwjpfRQ>
    <xmx:DnYlZ_8RwIphf3tiSkubSLm6JSm7OwNZ0SmVf4dOvWb7ZK--qSWg9A>
    <xmx:DnYlZ-Vf7d0udZssUdHnvKrMdYW9ohz3CpA68Tv31AhLTEqQeP143A>
    <xmx:DnYlZwck8zHXdPfCxQOwJl0Jxoll6BdVheGQ4mew-Ilriz3k3EPxxw>
    <xmx:DnYlZ9dtCQjuE6Vroz8DZUNKVIHNAihPtm3qrjkxGBXySen0i_ZsQOGQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 20:45:02 -0400 (EDT)
Date: Fri, 1 Nov 2024 17:45:01 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
	tj@kernel.org, gregkh@linuxfoundation.org
Subject: Re: [BUG] -next lockdep invalid wait context
Message-ID: <ZyV2DfuIPsISds-1@Boquns-Mac-mini.local>
References: <41619255-cdc2-4573-a360-7794fc3614f7@paulmck-laptop>
 <e06d69c9-f067-45c6-b604-fd340c3bd612@suse.cz>
 <ZyK0YPgtWExT4deh@elver.google.com>
 <66a745bb-d381-471c-aeee-3800a504f87d@paulmck-laptop>
 <20241102001224.2789-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102001224.2789-1-hdanton@sina.com>

On Sat, Nov 02, 2024 at 08:12:24AM +0800, Hillf Danton wrote:
> On Thu, 31 Oct 2024 08:21:36 +0100 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > On 2024-10-30 16:10:58 [-0700], Paul E. McKenney wrote:
> > > 
> > > So I need to avoid calling kfree() within an smp_call_function() handler?
> > 
> > Yes. No kmalloc()/ kfree() in IRQ context.
> > 
> Another splat [1] with no link to kmalloc()/ kfree(). 
> 

Because it's a different bug.

	schedule():
	  __schedule():
	    rq_lock(); // <- rq lock is a raw spin lock, so no sleep inside
	    switch_mm_irqs_off():
	      trace_tlb_flush():
	        bpf_trace_run2():
		  stack_map_get_build_id_offset():
		    mmap_read_trylock(): // this is actually ok, because
		    			 // trylock() on rwsem won't
					 // sleep.
		      __mmap_lock_trace_acquire_returned():
		        get_mm_memcg_path():
			  cgroup_path():
			    kernfs_path_from_node():
			      read_lock_irqsave(); // on RT, read_lock()
			      			   // is a rwsem IIUC,
						   // so might sleep.
						   // hence the issue.

Maybe kernfs can use RCU instead of read_lock here? I don't know...

Regards,
Boqun

> [ BUG: Invalid wait context ]
> 6.12.0-rc5-next-20241031-syzkaller #0 Not tainted
> -----------------------------
> strace-static-x/5846 is trying to lock:
> ffffffff8eac8698 (kernfs_rename_lock){....}-{3:3}, at: kernfs_path_from_node+0x92/0xb00 fs/kernfs/dir.c:229
> other info that might help us debug this:
> context-{5:5}
> 3 locks held by strace-static-x/5846:
>  #0: ffff8880b873e598 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:598
>  #1: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>  #1: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
>  #1: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2339 [inline]
>  #1: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run2+0x1fc/0x540 kernel/trace/bpf_trace.c:2381
>  #2: ffff88802f7129e0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_trylock include/linux/mmap_lock.h:208 [inline]
>  #2: ffff88802f7129e0 (&mm->mmap_lock){++++}-{4:4}, at: stack_map_get_build_id_offset+0x431/0x870 kernel/bpf/stackmap.c:157
> 
> [1] Subject: [syzbot] [kernfs?] WARNING: locking bug in kernfs_path_from_node
> https://lore.kernel.org/lkml/67251dc6.050a0220.529b6.015e.GAE@google.com/

