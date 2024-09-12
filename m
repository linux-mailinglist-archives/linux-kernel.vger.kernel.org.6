Return-Path: <linux-kernel+bounces-326359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735E8976724
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F7AB21B09
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F061A0BC5;
	Thu, 12 Sep 2024 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbv6rYun"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2B518E043
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726139028; cv=none; b=IfzCiMxTEnPJmhqJ97GX+XMJTZv5R7Edawjs1Db6QldfJnn4U2RPfNO6UHRhVRfFvm4jLHDq9Gzpk9O+KnPjIIm9d1xloBZ+0uiSMUVppz8g06EpvaFClU3IzcRXxbqPf/9nJPusuokw9b0zfB/P83F24LH1zCpkgcf/pncqIzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726139028; c=relaxed/simple;
	bh=FY7p87wBqo8q3VrtJIek5LgnSha17sYC8+pwYKBXjdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCFjMlld1MUYbVAebDieuSL9QkMvW7p44kXH1FTjbA5i5ZrZ9Ek+MOwCPDyMnY1v6pAFHVlOsCo3tbUuFMrw0zTFR6K5vhGkpxU7wOo8qjZwJopERUV3w3NWiyWMaWp4MyJ14FyXBz17upXUXdl2E2n25skUMHoO5DHplX7xBdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbv6rYun; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726139025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k483MVuNzC1Os71IHth1bQ3EdMCrVq0ZfZ8ch4uBnn8=;
	b=bbv6rYund7xRvv4gSnTJ1fyC1+yVtLpvTCR4/hqNryWVAlSj2rjL4dr1potbXZvckrFcoB
	0LTNJQm6l2H6prcgt1LFpNWn70omx5hnkhpHvNRs3U1J7Y0NtukbSCe1hYoCgZstEcTWDy
	kyrUAkaBuQVIGaBgGOAJBN6D07flvPE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-YME-Khw2P2S-OeaSduRabw-1; Thu, 12 Sep 2024 07:03:44 -0400
X-MC-Unique: YME-Khw2P2S-OeaSduRabw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374c44e58a9so475474f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 04:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726139023; x=1726743823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k483MVuNzC1Os71IHth1bQ3EdMCrVq0ZfZ8ch4uBnn8=;
        b=FU3BQGJsd7WUqzP+AchRYNVwHOnikr2p4gDDEQBDtSt62iVDMoBCqPZEfZvjEEBbAH
         QgXpWYjaeyyNivFH6/Vy7kjhesrqqvJ+JbPb3YiX+N5myI6KODhVR5K/AcvZ5xewWPAL
         bP4TrD+14aISXQ3MpDOXYFNbosvJbMlST80Dm2+cYHiTVkofnFsDlJHaQ3DN0K3WyDe8
         GgbXajbLzQm5jYQvgva1WF6zJVsPtRICyTt43coOTwjrZY9Y5injOuXok58b2v8dqSKu
         CJ7dZ+SZBX/wU2QmOOThO6KF+U6vDnhxQLTPLGmZz/to/wfFkQ24J6Pi2LzDd10fVWJa
         m7sA==
X-Forwarded-Encrypted: i=1; AJvYcCX/AmoOW5Nmg8P+kUBueX5D5uXYgd+YqB5Vdm8Lr997Rea+zc0sku6Cf5JmQ7G1eiBI8FkMbc9Cdh9MUxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu+KXWGuw9JQZGUj8EY4xUwHO+7EXyacXKhfcay4cA5XQ12Z2l
	HCTCU5Zvk6t7pgKyhUHXuMmIvyHmyZK9bEiDPZf9XkYPsIZ0Dvy2ctfQ+BVf+hv+eyS1XaWuFm5
	S/L7OXcrFKKoy627s8S/vBRxPlItLRUQkY0so7FF61cWwRcqIrFKXUNRL/s/7mA==
X-Received: by 2002:adf:e90b:0:b0:375:1b02:1e3c with SMTP id ffacd0b85a97d-378c2d5122fmr1615937f8f.45.1726139022862;
        Thu, 12 Sep 2024 04:03:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7w2HandC0K6kg9QqXPqaiQbCXZoLVV3rEWeYa1aD66E+kUhvgkFgq35oavTfwf644pCOePw==
X-Received: by 2002:adf:e90b:0:b0:375:1b02:1e3c with SMTP id ffacd0b85a97d-378c2d5122fmr1615890f8f.45.1726139021594;
        Thu, 12 Sep 2024 04:03:41 -0700 (PDT)
Received: from redhat.com ([2.52.4.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d375asm14033311f8f.66.2024.09.12.04.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 04:03:40 -0700 (PDT)
Date: Thu, 12 Sep 2024 07:03:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: syzbot <syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com>
Cc: eperezma@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [syzbot] [virt?] KCSAN: data-race in virtqueue_disable_cb /
 vring_interrupt (4)
Message-ID: <20240912070121-mutt-send-email-mst@kernel.org>
References: <000000000000e2058e0621e7a637@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e2058e0621e7a637@google.com>

On Thu, Sep 12, 2024 at 01:11:21AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7c6a3a65ace7 minmax: reduce min/max macro expansion in ato..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1608e49f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1e7d02549be622b2
> dashboard link: https://syzkaller.appspot.com/bug?extid=8a02104389c2e0ef5049
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a1f7496fa21f/disk-7c6a3a65.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f423739e51a9/vmlinux-7c6a3a65.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b65a0f38cbd7/bzImage-7c6a3a65.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in virtqueue_disable_cb / vring_interrupt
> 
> write to 0xffff88810285ef52 of 1 bytes by interrupt on cpu 0:
>  vring_interrupt+0x12b/0x180 drivers/virtio/virtio_ring.c:2591


Yes, it's racy!

2589:        /* Just a hint for performance: so it's ok that this can be racy! */
2590:        if (vq->event)
2591:            vq->event_triggered = true;


Question: is there a way to annotate code to tell syzbot it's ok?


>  __handle_irq_event_percpu+0x95/0x490 kernel/irq/handle.c:158
>  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
>  handle_irq_event+0x64/0xf0 kernel/irq/handle.c:210
>  handle_edge_irq+0x16d/0x5b0 kernel/irq/chip.c:831
>  generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
>  handle_irq arch/x86/kernel/irq.c:247 [inline]
>  call_irq_handler arch/x86/kernel/irq.c:259 [inline]
>  __common_interrupt+0x58/0xe0 arch/x86/kernel/irq.c:285
>  common_interrupt+0x7c/0x90 arch/x86/kernel/irq.c:278
>  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
>  __preempt_count_dec_and_test arch/x86/include/asm/preempt.h:94 [inline]
>  __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
>  _raw_spin_unlock_irq+0x2f/0x50 kernel/locking/spinlock.c:202
>  process_one_work kernel/workqueue.c:3200 [inline]
>  process_scheduled_works+0x43b/0x9a0 kernel/workqueue.c:3312
>  worker_thread+0x526/0x6e0 kernel/workqueue.c:3389
>  kthread+0x1d1/0x210 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> read to 0xffff88810285ef52 of 1 bytes by interrupt on cpu 1:
>  virtqueue_disable_cb_split drivers/virtio/virtio_ring.c:892 [inline]
>  virtqueue_disable_cb+0x92/0x180 drivers/virtio/virtio_ring.c:2446
>  start_xmit+0x14b/0x1260 drivers/net/virtio_net.c:3034
>  __netdev_start_xmit include/linux/netdevice.h:4913 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4922 [inline]
>  xmit_one net/core/dev.c:3580 [inline]
>  dev_hard_start_xmit+0x119/0x3f0 net/core/dev.c:3596
>  sch_direct_xmit+0x1b0/0x580 net/sched/sch_generic.c:343
>  __dev_xmit_skb net/core/dev.c:3809 [inline]
>  __dev_queue_xmit+0xf3d/0x1fe0 net/core/dev.c:4389
>  dev_queue_xmit include/linux/netdevice.h:3105 [inline]
>  neigh_hh_output include/net/neighbour.h:526 [inline]
>  neigh_output include/net/neighbour.h:540 [inline]
>  ip_finish_output2+0x73d/0x8b0 net/ipv4/ip_output.c:235
>  ip_finish_output+0x11a/0x2a0 net/ipv4/ip_output.c:323
>  NF_HOOK_COND include/linux/netfilter.h:303 [inline]
>  ip_output+0xab/0x170 net/ipv4/ip_output.c:433
>  dst_output include/net/dst.h:450 [inline]
>  ip_local_out net/ipv4/ip_output.c:129 [inline]
>  __ip_queue_xmit+0xbcc/0xbf0 net/ipv4/ip_output.c:535
>  ip_queue_xmit+0x38/0x50 net/ipv4/ip_output.c:549
>  __tcp_transmit_skb+0x15b0/0x1970 net/ipv4/tcp_output.c:1466
>  tcp_transmit_skb net/ipv4/tcp_output.c:1484 [inline]
>  tcp_write_xmit+0x1273/0x31c0 net/ipv4/tcp_output.c:2829
>  __tcp_push_pending_frames+0x6a/0x1a0 net/ipv4/tcp_output.c:3014
>  tcp_push_pending_frames include/net/tcp.h:2106 [inline]
>  tcp_data_snd_check net/ipv4/tcp_input.c:5707 [inline]
>  tcp_rcv_established+0xa12/0xef0 net/ipv4/tcp_input.c:6141
>  tcp_v4_do_rcv+0x662/0x740 net/ipv4/tcp_ipv4.c:1911
>  tcp_v4_rcv+0x1b25/0x1ee0 net/ipv4/tcp_ipv4.c:2346
>  ip_protocol_deliver_rcu+0x370/0x720 net/ipv4/ip_input.c:205
>  ip_local_deliver_finish+0x17d/0x210 net/ipv4/ip_input.c:233
>  NF_HOOK include/linux/netfilter.h:314 [inline]
>  ip_local_deliver+0xec/0x1d0 net/ipv4/ip_input.c:254
>  dst_input include/net/dst.h:460 [inline]
>  ip_sublist_rcv_finish net/ipv4/ip_input.c:580 [inline]
>  ip_list_rcv_finish net/ipv4/ip_input.c:631 [inline]
>  ip_sublist_rcv+0x55a/0x640 net/ipv4/ip_input.c:639
>  ip_list_rcv+0x25e/0x290 net/ipv4/ip_input.c:674
>  __netif_receive_skb_list_ptype net/core/dev.c:5704 [inline]
>  __netif_receive_skb_list_core+0x4f0/0x520 net/core/dev.c:5752
>  __netif_receive_skb_list net/core/dev.c:5804 [inline]
>  netif_receive_skb_list_internal+0x4e4/0x660 net/core/dev.c:5896
>  gro_normal_list include/net/gro.h:515 [inline]
>  napi_complete_done+0x1cb/0x450 net/core/dev.c:6247
>  virtqueue_napi_complete drivers/net/virtio_net.c:694 [inline]
>  virtnet_poll+0x1b73/0x1fd0 drivers/net/virtio_net.c:2826
>  __napi_poll+0x63/0x3c0 net/core/dev.c:6772
>  napi_poll net/core/dev.c:6841 [inline]
>  net_rx_action+0x3a1/0x7f0 net/core/dev.c:6963
>  handle_softirqs+0xc3/0x280 kernel/softirq.c:554
>  __do_softirq kernel/softirq.c:588 [inline]
>  invoke_softirq kernel/softirq.c:428 [inline]
>  __irq_exit_rcu kernel/softirq.c:637 [inline]
>  irq_exit_rcu+0x3e/0x90 kernel/softirq.c:649
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
>  sysvec_apic_timer_interrupt+0x37/0x80 arch/x86/kernel/apic/apic.c:1043
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
> 
> value changed: 0x00 -> 0x01
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 UID: 0 PID: 31238 Comm: syz.2.3839 Not tainted 6.11.0-rc7-syzkaller-00021-g7c6a3a65ace7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup


