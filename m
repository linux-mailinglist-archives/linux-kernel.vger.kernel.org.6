Return-Path: <linux-kernel+bounces-186779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87AC8CC912
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 00:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE0E1C21BDD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 22:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B57D1487C7;
	Wed, 22 May 2024 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="md/u8quh"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED5A811E0
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716417000; cv=none; b=ec2trv2ZYArDcoOMEFaV0AZ0Pkn92pKFXqyC5jL2YUpkWqrBXEr6sVADzIWc/l7RqKnrlN+Cr4jZ1w4Usf9tpvqsiqAB7bGLZXfchXKTuUmzYXPoFEqxZ/7Etj6cEbetFsyFLh27F5WSfvQ8IXHSfZGi3IOjAewEc5FVfwwfoEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716417000; c=relaxed/simple;
	bh=k8sK4swG0goFnYX0Fd+UivU9IjwQMRpCUWcGlcn5n3s=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Bu6UCRFERDF+M0qUtyahJmBqnR1ldU1R3vGLxy6TfNbaZVt/jGUIStAqbvaAnEUfkGZwSBOMmW4Ep4JT5Mxtk+DScW4c+QcmiPJ9d2YtjhznOXFKlzy5R6FGCr2tgmeJowUMFRRfGkKcKHa8xugyyeQ/aE/6NGh4N0aFeusmvhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=md/u8quh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-574b3d6c0f3so11802241a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716416995; x=1717021795; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8sK4swG0goFnYX0Fd+UivU9IjwQMRpCUWcGlcn5n3s=;
        b=md/u8quhzgw7FfEaYHbwKI1QKl5yoZiAx7t1Wd5VqaMopyRmujjob2YAybmEs0G9Tb
         qUPQQzuwj5Np9XOkWEO8+pLo3ptabztyWIgNADbZkrZuzKLeQ60WQMiO2gvxJ73tXFUY
         Hhp9JhhCmBvXfMt8lplbfNyfUcNUf6U3/yjYcgZJtWuzWv07KIJQnJmn7HNS95lwgfim
         Td3ydGoFUj/e8/WdD28y6tMjvifJH3EcnPvrScFb0+EoUg5eeqzGJLJhQxS5Wsrs9NRi
         X03ylbwpc1I1crW9iaQm0XN7Zl0zugQ1QyPJsHOd7CL5d8IVaYE6reeiPSC28+aPoZNn
         x81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716416995; x=1717021795;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k8sK4swG0goFnYX0Fd+UivU9IjwQMRpCUWcGlcn5n3s=;
        b=wnIUwuqu3T7QUZGJ6eWq8HYkeDVnSayriy2ipmfWg38ZlblSGzcJv1DfAAL2cUm/5P
         StA13jYSmxCtDeg+I+D9u7ROsnofsu+UmvDQXaLlfJCSDJ7aOXse79MNBWwkF8Ci7nkW
         jmUV8qh3AKYQ9/UvRUpRattzhdCGSytXEl4V1TShZJZ6CSEoZ06u7Ks0JFlpGIMfmYpC
         vILb3bTXIHkKuBtTe+pwxfSJPxC1GKvrOkJ+TGUL1AUh8zegy0d+ONVjJhEHJccMoRpp
         Nf/duHTjMvLcLQXCXJgtpjZLcUYBhvZn8LuvFVaRnFmtS+U36q2KDwD45qIYeJEbbjrD
         w0JA==
X-Gm-Message-State: AOJu0YwVpcrHK1JhN/oQqPY5lEgIQdlFFDwOQUr64M0BFrLaAIUiYlKs
	UH6AB7S2N5al+C2X0ca5ZcoqBP58cZ0qqhNZ1D964cXI4dOBk4n7Kyvcf5gF
X-Google-Smtp-Source: AGHT+IHWBZmfUjKqnO5DGHVL0yjqdslnB2UR2CI1/agshin+YicRQztisDfdNXBbt9KM6VIKYjwiVg==
X-Received: by 2002:a17:906:3404:b0:a59:c28a:7ec2 with SMTP id a640c23a62f3a-a62280970ebmr185065466b.41.1716416994486;
        Wed, 22 May 2024 15:29:54 -0700 (PDT)
Received: from [192.168.178.51] (p54a89620.dip0.t-ipconnect.de. [84.168.150.32])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01451sm1861431266b.149.2024.05.22.15.29.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 15:29:53 -0700 (PDT)
Message-ID: <e441605c-eaf2-4c2d-872b-d8e541f4cf60@gmail.com>
Date: Thu, 23 May 2024 00:29:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Johannes_W=C3=BCller?= <johanneswueller@gmail.com>
Subject: [BUG] Task Blocking in Kernel 6.9.1-arch1-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

$ uname -a
Linux jw 6.9.1-arch1-1 #1 SMP PREEMPT_DYNAMIC Fri, 17 May 2024 16:56:38 +0000 x86_64 GNU/Linux

$ inxi
CPU: 16-core AMD Ryzen 9 7950X (-MT MCP-) speed/min/max: 3661/545/5881 MHz
Kernel: 6.9.1-arch1-1 x86_64 Up: 1h 57m Mem: 8.89/58.57 GiB (15.2%)
Storage: 3.64 TiB (16.6% used) Procs: 538 Shell: Bash inxi: 3.3.34

Problem Description:
I am encountering an issue where several tasks are seemingly being blocked by an
intermittent locking issue. Sometimes the system boots, sometimes it just stalls
while systemd decides to wait for networking that's might never come online
because of this.

I've been made aware of this but, that might be related, judging by a cursory
comparison of the symptoms:
https://bugzilla.kernel.org/show_bug.cgi?id=218740

Relevant Logs:
May 21 19:36:48 jw kernel: INFO: task kworker/u130:4:285 blocked for more than 122 seconds.
May 21 19:36:48 jw kernel:       Not tainted 6.9.1-arch1-1 #1
May 21 19:36:48 jw kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 21 19:36:48 jw kernel: task:kworker/u130:4  state:D stack:0     pid:285   tgid:285   ppid:2      flags:0x00004000
May 21 19:36:48 jw kernel: Workqueue: events_power_efficient reg_check_chans_work [cfg80211]
May 21 19:36:48 jw kernel: Call Trace:
May 21 19:36:48 jw kernel:  <TASK>
May 21 19:36:48 jw kernel:  __schedule+0x3c7/0x1510
May 21 19:36:48 jw kernel:  ? __queue_work.part.0+0x18b/0x3a0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  schedule+0x27/0xf0
May 21 19:36:48 jw kernel:  schedule_preempt_disabled+0x15/0x30
May 21 19:36:48 jw kernel:  __mutex_lock.constprop.0+0x31e/0x620
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  reg_check_chans_work+0x31/0x5a0 [cfg80211 e26458db9aeedbfd1117deb28e3ddf74ab47901e]
May 21 19:36:48 jw kernel:  ? try_to_wake_up+0x22f/0x660
May 21 19:36:48 jw kernel:  process_one_work+0x18b/0x350
May 21 19:36:48 jw kernel:  worker_thread+0x2eb/0x410
May 21 19:36:48 jw kernel:  ? __pfx_worker_thread+0x10/0x10
May 21 19:36:48 jw kernel:  kthread+0xcf/0x100
May 21 19:36:48 jw kernel:  ? __pfx_kthread+0x10/0x10
May 21 19:36:48 jw kernel:  ret_from_fork+0x31/0x50
May 21 19:36:48 jw kernel:  ? __pfx_kthread+0x10/0x10
May 21 19:36:48 jw kernel:  ret_from_fork_asm+0x1a/0x30
May 21 19:36:48 jw kernel:  </TASK>
May 21 19:36:48 jw kernel: INFO: task kworker/u130:6:287 blocked for more than 122 seconds.
May 21 19:36:48 jw kernel:       Not tainted 6.9.1-arch1-1 #1
May 21 19:36:48 jw kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 21 19:36:48 jw kernel: task:kworker/u130:6  state:D stack:0     pid:287   tgid:287   ppid:2      flags:0x00004000
May 21 19:36:48 jw kernel: Workqueue: events_power_efficient crda_timeout_work [cfg80211]
May 21 19:36:48 jw kernel: Call Trace:
May 21 19:36:48 jw kernel:  <TASK>
May 21 19:36:48 jw kernel:  __schedule+0x3c7/0x1510
May 21 19:36:48 jw kernel:  ? psi_group_change+0x1b0/0x350
May 21 19:36:48 jw kernel:  ? dequeue_entity+0x138/0x4a0
May 21 19:36:48 jw kernel:  schedule+0x27/0xf0
May 21 19:36:48 jw kernel:  schedule_preempt_disabled+0x15/0x30
May 21 19:36:48 jw kernel:  __mutex_lock.constprop.0+0x31e/0x620
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  crda_timeout_work+0x10/0x40 [cfg80211 e26458db9aeedbfd1117deb28e3ddf74ab47901e]
May 21 19:36:48 jw kernel:  process_one_work+0x18b/0x350
May 21 19:36:48 jw kernel:  worker_thread+0x2eb/0x410
May 21 19:36:48 jw kernel:  ? __pfx_worker_thread+0x10/0x10
May 21 19:36:48 jw kernel:  kthread+0xcf/0x100
May 21 19:36:48 jw kernel:  ? __pfx_kthread+0x10/0x10
May 21 19:36:48 jw kernel:  ret_from_fork+0x31/0x50
May 21 19:36:48 jw kernel:  ? __pfx_kthread+0x10/0x10
May 21 19:36:48 jw kernel:  ret_from_fork_asm+0x1a/0x30
May 21 19:36:48 jw kernel:  </TASK>
May 21 19:36:48 jw kernel: INFO: task systemd-network:633 blocked for more than 122 seconds.
May 21 19:36:48 jw kernel:       Not tainted 6.9.1-arch1-1 #1
May 21 19:36:48 jw kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 21 19:36:48 jw kernel: task:systemd-network state:D stack:0     pid:633   tgid:633   ppid:1      flags:0x00004006
May 21 19:36:48 jw kernel: Call Trace:
May 21 19:36:48 jw kernel:  <TASK>
May 21 19:36:48 jw kernel:  __schedule+0x3c7/0x1510
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? __slab_free+0xdf/0x2f0
May 21 19:36:48 jw kernel:  schedule+0x27/0xf0
May 21 19:36:48 jw kernel:  schedule_preempt_disabled+0x15/0x30
May 21 19:36:48 jw kernel:  rwsem_down_read_slowpath+0x26f/0x4e0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? vsnprintf+0x33f/0x6e0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  down_read+0x48/0xa0
May 21 19:36:48 jw kernel:  led_trigger_register+0xe6/0x1a0
May 21 19:36:48 jw kernel:  phy_led_triggers_register+0xee/0x25c [libphy 62ef5849eba6bb95967a9b99c9f5dfd80cb3790c]
May 21 19:36:48 jw kernel:  phy_attach_direct+0x363/0x370 [libphy 62ef5849eba6bb95967a9b99c9f5dfd80cb3790c]
May 21 19:36:48 jw kernel:  ? __pfx_r8169_phylink_handler+0x10/0x10 [r8169 deaf1b76310aec8b228de15cb4aae9b98656b9c8]
May 21 19:36:48 jw kernel:  phy_connect_direct+0x25/0x70 [libphy 62ef5849eba6bb95967a9b99c9f5dfd80cb3790c]
May 21 19:36:48 jw kernel:  rtl_open+0x2ce/0x490 [r8169 deaf1b76310aec8b228de15cb4aae9b98656b9c8]
May 21 19:36:48 jw kernel:  __dev_open+0xf8/0x1b0
May 21 19:36:48 jw kernel:  __dev_change_flags+0x1e4/0x230
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? nla_put_ifalias+0x42/0xb0
May 21 19:36:48 jw kernel:  dev_change_flags+0x26/0x70
May 21 19:36:48 jw kernel:  do_setlink+0x36c/0x1210
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? dev_fetch_sw_netstats+0x5c/0x70
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? rtl8169_get_stats64+0x54/0x110 [r8169 deaf1b76310aec8b228de15cb4aae9b98656b9c8]
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? ep_poll_callback+0x24d/0x2a0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? __nla_validate_parse+0x5f/0xcb0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? __wake_up_common+0x75/0xa0
May 21 19:36:48 jw kernel:  rtnl_setlink+0x11f/0x1d0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? mntput_no_expire+0x4a/0x260
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? security_capable+0x41/0x70
May 21 19:36:48 jw kernel:  rtnetlink_rcv_msg+0x142/0x3e0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? __mod_memcg_lruvec_state+0x94/0x110
May 21 19:36:48 jw kernel:  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
May 21 19:36:48 jw kernel:  netlink_rcv_skb+0x50/0x100
May 21 19:36:48 jw kernel:  netlink_unicast+0x240/0x370
May 21 19:36:48 jw kernel:  netlink_sendmsg+0x21b/0x470
May 21 19:36:48 jw kernel:  __sys_sendto+0x201/0x210
May 21 19:36:48 jw kernel:  __x64_sys_sendto+0x24/0x30
May 21 19:36:48 jw kernel:  do_syscall_64+0x82/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? dquot_drop+0x24/0x50
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? shmem_evict_inode+0x9d/0x2b0
May 21 19:36:48 jw kernel:  ? __inode_wait_for_writeback+0x7c/0xf0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? fsnotify_grab_connector+0x43/0x80
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? fsnotify_destroy_marks+0x2a/0x1b0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? __memcg_slab_free_hook+0xef/0x140
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? kmem_cache_free+0x3b9/0x3e0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? syscall_exit_to_user_mode+0x75/0x210
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_syscall_64+0x8e/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? syscall_exit_to_user_mode+0x75/0x210
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_syscall_64+0x8e/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? syscall_exit_to_user_mode+0x75/0x210
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_syscall_64+0x8e/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? __x64_sys_fcntl+0x94/0xc0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? syscall_exit_to_user_mode+0x75/0x210
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_syscall_64+0x8e/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
May 21 19:36:48 jw kernel: RIP: 0033:0x76a43ed2c4e7
May 21 19:36:48 jw kernel: RSP: 002b:00007ffc3f657ea8 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
May 21 19:36:48 jw kernel: RAX: ffffffffffffffda RBX: 000063a016834000 RCX: 000076a43ed2c4e7
May 21 19:36:48 jw kernel: RDX: 0000000000000020 RSI: 000063a01684be60 RDI: 0000000000000003
May 21 19:36:48 jw kernel: RBP: 00007ffc3f657f40 R08: 00007ffc3f657eb0 R09: 0000000000000080
May 21 19:36:48 jw kernel: R10: 0000000000000000 R11: 0000000000000202 R12: 000063a01684ba30
May 21 19:36:48 jw kernel: R13: 000063a01684bed8 R14: 0000000000000000 R15: 000063a01684be90
May 21 19:36:48 jw kernel:  </TASK>
May 21 19:36:48 jw kernel: INFO: task (udev-worker):641 blocked for more than 122 seconds.
May 21 19:36:48 jw kernel:       Not tainted 6.9.1-arch1-1 #1
May 21 19:36:48 jw kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 21 19:36:48 jw kernel: task:(udev-worker)   state:D stack:0     pid:641   tgid:641   ppid:623    flags:0x00000006
May 21 19:36:48 jw kernel: Call Trace:
May 21 19:36:48 jw kernel:  <TASK>
May 21 19:36:48 jw kernel:  __schedule+0x3c7/0x1510
May 21 19:36:48 jw kernel:  schedule+0x27/0xf0
May 21 19:36:48 jw kernel:  schedule_timeout+0x12f/0x160
May 21 19:36:48 jw kernel:  wait_for_completion+0x86/0x170
May 21 19:36:48 jw kernel:  idempotent_init_module+0x1d0/0x2b0
May 21 19:36:48 jw kernel:  __x64_sys_finit_module+0x5e/0xb0
May 21 19:36:48 jw kernel:  do_syscall_64+0x82/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_syscall_64+0x8e/0x160
May 21 19:36:48 jw kernel:  ? do_syscall_64+0x8e/0x160
May 21 19:36:48 jw kernel:  ? syscall_exit_to_user_mode+0x75/0x210
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_syscall_64+0x8e/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
May 21 19:36:48 jw kernel: RIP: 0033:0x74691d8fae9d
May 21 19:36:48 jw kernel: RSP: 002b:00007ffee6117cb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
May 21 19:36:48 jw kernel: RAX: ffffffffffffffda RBX: 00005c753ee8abc0 RCX: 000074691d8fae9d
May 21 19:36:48 jw kernel: RDX: 0000000000000004 RSI: 000074691de2d376 RDI: 0000000000000020
May 21 19:36:48 jw kernel: RBP: 000074691de2d376 R08: 0000000000000003 R09: 00007ffee6117d00
May 21 19:36:48 jw kernel: R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000020000
May 21 19:36:48 jw kernel: R13: 00005c753ee8ab50 R14: 0000000000000000 R15: 00005c753ee88fb0
May 21 19:36:48 jw kernel:  </TASK>
May 21 19:36:48 jw kernel: INFO: task (udev-worker):666 blocked for more than 122 seconds.
May 21 19:36:48 jw kernel:       Not tainted 6.9.1-arch1-1 #1
May 21 19:36:48 jw kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 21 19:36:48 jw kernel: task:(udev-worker)   state:D stack:0     pid:666   tgid:666   ppid:623    flags:0x00004006
May 21 19:36:48 jw kernel: Call Trace:
May 21 19:36:48 jw kernel:  <TASK>
May 21 19:36:48 jw kernel:  __schedule+0x3c7/0x1510
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? __slab_free+0xdf/0x2f0
May 21 19:36:48 jw kernel:  schedule+0x27/0xf0
May 21 19:36:48 jw kernel:  schedule_preempt_disabled+0x15/0x30
May 21 19:36:48 jw kernel:  rwsem_down_write_slowpath+0x1d3/0x660
May 21 19:36:48 jw kernel:  down_write+0x5a/0x60
May 21 19:36:48 jw kernel:  led_classdev_unregister+0x8f/0x110
May 21 19:36:48 jw kernel:  input_leds_disconnect+0x37/0x70
May 21 19:36:48 jw kernel:  __input_unregister_device+0xa9/0x190
May 21 19:36:48 jw kernel:  input_unregister_device+0x45/0x70
May 21 19:36:48 jw kernel:  hidinput_disconnect+0x79/0xf0
May 21 19:36:48 jw kernel:  hid_disconnect+0x62/0x80
May 21 19:36:48 jw kernel:  hid_device_remove+0x8c/0xa0
May 21 19:36:48 jw kernel:  device_release_driver_internal+0x19c/0x200
May 21 19:36:48 jw kernel:  ? __pfx___hid_bus_reprobe_drivers+0x10/0x10
May 21 19:36:48 jw kernel:  device_reprobe+0x1d/0x90
May 21 19:36:48 jw kernel:  ? __hid_bus_reprobe_drivers+0x39/0x60
May 21 19:36:48 jw kernel:  bus_for_each_dev+0x8c/0xe0
May 21 19:36:48 jw kernel:  ? __pfx___hid_bus_driver_added+0x10/0x10
May 21 19:36:48 jw kernel:  __hid_bus_driver_added+0x2c/0x40
May 21 19:36:48 jw kernel:  bus_for_each_drv+0x95/0xf0
May 21 19:36:48 jw kernel:  __hid_register_driver+0x74/0x80
May 21 19:36:48 jw kernel:  ? __pfx_logi_djreceiver_driver_init+0x10/0x10 [hid_logitech_dj 39f687323f8fde2b576eb64f7732f5326f391f36]
May 21 19:36:48 jw kernel:  do_one_initcall+0x58/0x310
May 21 19:36:48 jw kernel:  do_init_module+0x60/0x220
May 21 19:36:48 jw kernel:  init_module_from_file+0x89/0xe0
May 21 19:36:48 jw kernel:  idempotent_init_module+0x121/0x2b0
May 21 19:36:48 jw kernel:  __x64_sys_finit_module+0x5e/0xb0
May 21 19:36:48 jw kernel:  do_syscall_64+0x82/0x160
May 21 19:36:48 jw kernel:  ? __slab_free+0xa1/0x2f0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? __rseq_handle_notify_resume+0xa6/0x490
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? switch_fpu_return+0x4e/0xd0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? syscall_exit_to_user_mode+0x75/0x210
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_syscall_64+0x8e/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? __irq_exit_rcu+0x4a/0xb0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
May 21 19:36:48 jw kernel: RIP: 0033:0x74691d8fae9d
May 21 19:36:48 jw kernel: RSP: 002b:00007ffee6117cb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
May 21 19:36:48 jw kernel: RAX: ffffffffffffffda RBX: 00005c753eec6cc0 RCX: 000074691d8fae9d
May 21 19:36:48 jw kernel: RDX: 0000000000000004 RSI: 000074691de2d376 RDI: 0000000000000038
May 21 19:36:48 jw kernel: RBP: 000074691de2d376 R08: 0000000000000001 R09: 00007ffee6117d00
May 21 19:36:48 jw kernel: R10: 0000000000000050 R11: 0000000000000246 R12: 0000000000020000
May 21 19:36:48 jw kernel: R13: 00005c753eeb57a0 R14: 0000000000000000 R15: 00005c753eeca180
May 21 19:36:48 jw kernel:  </TASK>
May 21 19:36:48 jw kernel: INFO: task (udev-worker):722 blocked for more than 122 seconds.
May 21 19:36:48 jw kernel:       Not tainted 6.9.1-arch1-1 #1
May 21 19:36:48 jw kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 21 19:36:48 jw kernel: task:(udev-worker)   state:D stack:0     pid:722   tgid:722   ppid:623    flags:0x00000006
May 21 19:36:48 jw kernel: Call Trace:
May 21 19:36:48 jw kernel:  <TASK>
May 21 19:36:48 jw kernel:  __schedule+0x3c7/0x1510
May 21 19:36:48 jw kernel:  schedule+0x27/0xf0
May 21 19:36:48 jw kernel:  schedule_timeout+0x12f/0x160
May 21 19:36:48 jw kernel:  wait_for_completion+0x86/0x170
May 21 19:36:48 jw kernel:  idempotent_init_module+0x1d0/0x2b0
May 21 19:36:48 jw kernel:  __x64_sys_finit_module+0x5e/0xb0
May 21 19:36:48 jw kernel:  do_syscall_64+0x82/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? syscall_exit_to_user_mode+0x75/0x210
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_syscall_64+0x8e/0x160
May 21 19:36:48 jw kernel:  ? do_filp_open+0xc4/0x170
May 21 19:36:48 jw kernel:  ? __pfx_page_put_link+0x10/0x10
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_sys_openat2+0x9c/0xe0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? syscall_exit_to_user_mode+0x75/0x210
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_syscall_64+0x8e/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_sys_openat2+0x9c/0xe0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? syscall_exit_to_user_mode+0x75/0x210
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_syscall_64+0x8e/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_user_addr_fault+0x34e/0x620
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
May 21 19:36:48 jw kernel: RIP: 0033:0x74691d8fae9d
May 21 19:36:48 jw kernel: RSP: 002b:00007ffee6117cb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
May 21 19:36:48 jw kernel: RAX: ffffffffffffffda RBX: 00005c753eeb7c60 RCX: 000074691d8fae9d
May 21 19:36:48 jw kernel: RDX: 0000000000000004 RSI: 000074691de2d376 RDI: 0000000000000060
May 21 19:36:48 jw kernel: RBP: 000074691de2d376 R08: 0000000000000001 R09: 00007ffee6117d00
May 21 19:36:48 jw kernel: R10: 0000000000000050 R11: 0000000000000246 R12: 0000000000020000
May 21 19:36:48 jw kernel: R13: 00005c753ef0ffa0 R14: 0000000000000000 R15: 00005c753ef10c40
May 21 19:36:48 jw kernel:  </TASK>
May 21 19:36:48 jw kernel: INFO: task kworker/21:4:760 blocked for more than 122 seconds.
May 21 19:36:48 jw kernel:       Not tainted 6.9.1-arch1-1 #1
May 21 19:36:48 jw kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 21 19:36:48 jw kernel: task:kworker/21:4    state:D stack:0     pid:760   tgid:760   ppid:2      flags:0x00004000
May 21 19:36:48 jw kernel: Workqueue: events linkwatch_event
May 21 19:36:48 jw kernel: Call Trace:
May 21 19:36:48 jw kernel:  <TASK>
May 21 19:36:48 jw kernel:  __schedule+0x3c7/0x1510
May 21 19:36:48 jw kernel:  ? psi_group_change+0x1b0/0x350
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  schedule+0x27/0xf0
May 21 19:36:48 jw kernel:  schedule_preempt_disabled+0x15/0x30
May 21 19:36:48 jw kernel:  __mutex_lock.constprop.0+0x31e/0x620
May 21 19:36:48 jw kernel:  ? delayed_vfree_work+0x35/0x50
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  linkwatch_event+0x12/0x40
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  process_one_work+0x18b/0x350
May 21 19:36:48 jw kernel:  worker_thread+0x2eb/0x410
May 21 19:36:48 jw kernel:  ? __pfx_worker_thread+0x10/0x10
May 21 19:36:48 jw kernel:  kthread+0xcf/0x100
May 21 19:36:48 jw kernel:  ? __pfx_kthread+0x10/0x10
May 21 19:36:48 jw kernel:  ret_from_fork+0x31/0x50
May 21 19:36:48 jw kernel:  ? __pfx_kthread+0x10/0x10
May 21 19:36:48 jw kernel:  ret_from_fork_asm+0x1a/0x30
May 21 19:36:48 jw kernel:  </TASK>
May 21 19:36:48 jw kernel: INFO: task modprobe:854 blocked for more than 122 seconds.
May 21 19:36:48 jw kernel:       Not tainted 6.9.1-arch1-1 #1
May 21 19:36:48 jw kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 21 19:36:48 jw kernel: task:modprobe        state:D stack:0     pid:854   tgid:854   ppid:2      flags:0x00000002
May 21 19:36:48 jw kernel: Call Trace:
May 21 19:36:48 jw kernel:  <TASK>
May 21 19:36:48 jw kernel:  __schedule+0x3c7/0x1510
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  schedule+0x27/0xf0
May 21 19:36:48 jw kernel:  schedule_timeout+0x12f/0x160
May 21 19:36:48 jw kernel:  wait_for_completion+0x86/0x170
May 21 19:36:48 jw kernel:  idempotent_init_module+0x1d0/0x2b0
May 21 19:36:48 jw kernel:  __x64_sys_finit_module+0x5e/0xb0
May 21 19:36:48 jw kernel:  do_syscall_64+0x82/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? syscall_exit_to_user_mode+0x75/0x210
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_syscall_64+0x8e/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? switch_fpu_return+0x4e/0xd0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? syscall_exit_to_user_mode+0x75/0x210
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_syscall_64+0x8e/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? syscall_exit_to_user_mode+0x75/0x210
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_syscall_64+0x8e/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_syscall_64+0x8e/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_sys_openat2+0x9c/0xe0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? syscall_exit_to_user_mode+0x75/0x210
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_syscall_64+0x8e/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? handle_mm_fault+0x1f0/0x300
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_user_addr_fault+0x34e/0x620
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
May 21 19:36:48 jw kernel: RIP: 0033:0x718a8d527e9d
May 21 19:36:48 jw kernel: RSP: 002b:00007fffce99f9a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
May 21 19:36:48 jw kernel: RAX: ffffffffffffffda RBX: 00005c00c9402d50 RCX: 0000718a8d527e9d
May 21 19:36:48 jw kernel: RDX: 0000000000000004 RSI: 00005c00c34f1478 RDI: 0000000000000000
May 21 19:36:48 jw kernel: RBP: 00005c00c34f1478 R08: 0000718a8d5f6b20 R09: 0000000000000000
May 21 19:36:48 jw kernel: R10: 00005c00c94032f0 R11: 0000000000000246 R12: 0000000000040000
May 21 19:36:48 jw kernel: R13: 00005c00c9403160 R14: 0000000000000000 R15: 00005c00c94032b0
May 21 19:36:48 jw kernel:  </TASK>
May 21 19:36:48 jw kernel: INFO: task modprobe:855 blocked for more than 122 seconds.
May 21 19:36:48 jw kernel:       Not tainted 6.9.1-arch1-1 #1
May 21 19:36:48 jw kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 21 19:36:48 jw kernel: task:modprobe        state:D stack:0     pid:855   tgid:855   ppid:2      flags:0x00000002
May 21 19:36:48 jw kernel: Call Trace:
May 21 19:36:48 jw kernel:  <TASK>
May 21 19:36:48 jw kernel:  __schedule+0x3c7/0x1510
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  schedule+0x27/0xf0
May 21 19:36:48 jw kernel:  schedule_timeout+0x12f/0x160
May 21 19:36:48 jw kernel:  wait_for_completion+0x86/0x170
May 21 19:36:48 jw kernel:  idempotent_init_module+0x1d0/0x2b0
May 21 19:36:48 jw kernel:  __x64_sys_finit_module+0x5e/0xb0
May 21 19:36:48 jw kernel:  do_syscall_64+0x82/0x160
May 21 19:36:48 jw kernel:  ? vfs_read+0x2a2/0x360
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? vfs_read+0x2a2/0x360
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? __rseq_handle_notify_resume+0xa6/0x490
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? set_pte_range+0xcc/0x270
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? next_uptodate_folio+0x8b/0x240
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? filemap_map_pages+0x47e/0x550
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? syscall_exit_to_user_mode+0x75/0x210
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? vfs_statx+0x93/0x1c0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_fault+0x246/0x490
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? __handle_mm_fault+0x855/0xe10
May 21 19:36:48 jw kernel:  ? delayed_vfree_work+0x35/0x50
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  linkwatch_event+0x12/0x40
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  process_one_work+0x18b/0x350
May 21 19:36:48 jw kernel:  worker_thread+0x2eb/0x410
May 21 19:36:48 jw kernel:  ? __pfx_worker_thread+0x10/0x10
May 21 19:36:48 jw kernel:  kthread+0xcf/0x100
May 21 19:36:48 jw kernel:  ? __pfx_kthread+0x10/0x10
May 21 19:36:48 jw kernel:  ret_from_fork+0x31/0x50
May 21 19:36:48 jw kernel:  ? __pfx_kthread+0x10/0x10
May 21 19:36:48 jw kernel:  ret_from_fork_asm+0x1a/0x30
May 21 19:36:48 jw kernel:  </TASK>
May 21 19:36:48 jw kernel: INFO: task modprobe:854 blocked for more than 122 seconds.
May 21 19:36:48 jw kernel:       Not tainted 6.9.1-arch1-1 #1
May 21 19:36:48 jw kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 21 19:36:48 jw kernel: task:modprobe        state:D stack:0     pid:854   tgid:854   ppid:2      flags:0x00000002
May 21 19:36:48 jw kernel: Call Trace:
May 21 19:36:48 jw kernel:  <TASK>
May 21 19:36:48 jw kernel:  __schedule+0x3c7/0x1510
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  schedule+0x27/0xf0
May 21 19:36:48 jw kernel:  schedule_timeout+0x12f/0x160
May 21 19:36:48 jw kernel:  wait_for_completion+0x86/0x170
May 21 19:36:48 jw kernel:  idempotent_init_module+0x1d0/0x2b0
May 21 19:36:48 jw kernel:  __x64_sys_finit_module+0x5e/0xb0
May 21 19:36:48 jw kernel:  do_syscall_64+0x82/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? syscall_exit_to_user_mode+0x75/0x210
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_syscall_64+0x8e/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? switch_fpu_return+0x4e/0xd0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? syscall_exit_to_user_mode+0x75/0x210
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_syscall_64+0x8e/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? syscall_exit_to_user_mode+0x75/0x210
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_syscall_64+0x8e/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_syscall_64+0x8e/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_sys_openat2+0x9c/0xe0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? syscall_exit_to_user_mode+0x75/0x210
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_syscall_64+0x8e/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? handle_mm_fault+0x1f0/0x300
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_user_addr_fault+0x34e/0x620
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
May 21 19:36:48 jw kernel: RIP: 0033:0x718a8d527e9d
May 21 19:36:48 jw kernel: RSP: 002b:00007fffce99f9a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
May 21 19:36:48 jw kernel: RAX: ffffffffffffffda RBX: 00005c00c9402d50 RCX: 0000718a8d527e9d
May 21 19:36:48 jw kernel: RDX: 0000000000000004 RSI: 00005c00c34f1478 RDI: 0000000000000000
May 21 19:36:48 jw kernel: RBP: 00005c00c34f1478 R08: 0000718a8d5f6b20 R09: 0000000000000000
May 21 19:36:48 jw kernel: R10: 00005c00c94032f0 R11: 0000000000000246 R12: 0000000000040000
May 21 19:36:48 jw kernel: R13: 00005c00c9403160 R14: 0000000000000000 R15: 00005c00c94032b0
May 21 19:36:48 jw kernel:  </TASK>
May 21 19:36:48 jw kernel: INFO: task modprobe:855 blocked for more than 122 seconds.
May 21 19:36:48 jw kernel:       Not tainted 6.9.1-arch1-1 #1
May 21 19:36:48 jw kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 21 19:36:48 jw kernel: task:modprobe        state:D stack:0     pid:855   tgid:855   ppid:2      flags:0x00000002
May 21 19:36:48 jw kernel: Call Trace:
May 21 19:36:48 jw kernel:  <TASK>
May 21 19:36:48 jw kernel:  __schedule+0x3c7/0x1510
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  schedule+0x27/0xf0
May 21 19:36:48 jw kernel:  schedule_timeout+0x12f/0x160
May 21 19:36:48 jw kernel:  wait_for_completion+0x86/0x170
May 21 19:36:48 jw kernel:  idempotent_init_module+0x1d0/0x2b0
May 21 19:36:48 jw kernel:  __x64_sys_finit_module+0x5e/0xb0
May 21 19:36:48 jw kernel:  do_syscall_64+0x82/0x160
May 21 19:36:48 jw kernel:  ? vfs_read+0x2a2/0x360
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? vfs_read+0x2a2/0x360
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? __rseq_handle_notify_resume+0xa6/0x490
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? set_pte_range+0xcc/0x270
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? next_uptodate_folio+0x8b/0x240
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? filemap_map_pages+0x47e/0x550
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? syscall_exit_to_user_mode+0x75/0x210
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? vfs_statx+0x93/0x1c0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_fault+0x246/0x490
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? __handle_mm_fault+0x855/0xe10
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? next_uptodate_folio+0x8b/0x240
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? filemap_map_pages+0x47e/0x550
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? syscall_exit_to_user_mode+0x75/0x210
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? vfs_statx+0x93/0x1c0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_fault+0x246/0x490
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? __handle_mm_fault+0x855/0xe10
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? __count_memcg_events+0x4d/0xb0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? count_memcg_events.constprop.0+0x1a/0x30
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? handle_mm_fault+0x1f0/0x300
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_user_addr_fault+0x34e/0x620
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
May 21 19:36:48 jw kernel: RIP: 0033:0x7f8071327e9d
May 21 19:36:48 jw kernel: RSP: 002b:00007ffed39e0f48 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
May 21 19:36:48 jw kernel: RAX: ffffffffffffffda RBX: 0000601489df6d50 RCX: 00007f8071327e9d
May 21 19:36:48 jw kernel: RDX: 0000000000000004 RSI: 0000601470012478 RDI: 0000000000000000
May 21 19:36:48 jw kernel: RBP: 0000601470012478 R08: 00007f80713f6b20 R09: 0000000000000000
May 21 19:36:48 jw kernel: R10: 0000601489df72f0 R11: 0000000000000246 R12: 0000000000040000
May 21 19:36:48 jw kernel: R13: 0000601489df7160 R14: 0000000000000000 R15: 0000601489df72b0
May 21 19:36:48 jw kernel:  </TASK>
May 21 19:36:48 jw kernel: INFO: task modprobe:858 blocked for more than 122 seconds.
May 21 19:36:48 jw kernel:       Not tainted 6.9.1-arch1-1 #1
May 21 19:36:48 jw kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 21 19:36:48 jw kernel: task:modprobe        state:D stack:0     pid:858   tgid:858   ppid:2      flags:0x00004002
May 21 19:36:48 jw kernel: Call Trace:
May 21 19:36:48 jw kernel:  <TASK>
May 21 19:36:48 jw kernel:  __schedule+0x3c7/0x1510
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? finish_task_switch.isra.0+0x99/0x2e0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  schedule+0x27/0xf0
May 21 19:36:48 jw kernel:  schedule_preempt_disabled+0x15/0x30
May 21 19:36:48 jw kernel:  __mutex_lock.constprop.0+0x31e/0x620
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  set_device_name+0x2a/0x140 [ledtrig_netdev 9ef86161089123f18990e2e814a36d05675e99cc]
May 21 19:36:48 jw kernel:  netdev_trig_activate+0x165/0x1e0 [ledtrig_netdev 9ef86161089123f18990e2e814a36d05675e99cc]
May 21 19:36:48 jw kernel:  led_trigger_set+0x210/0x310
May 21 19:36:48 jw kernel:  led_trigger_register+0x169/0x1a0
May 21 19:36:48 jw kernel:  ? __pfx_netdev_led_trigger_init+0x10/0x10 [ledtrig_netdev 9ef86161089123f18990e2e814a36d05675e99cc]
May 21 19:36:48 jw kernel:  do_one_initcall+0x58/0x310
May 21 19:36:48 jw kernel:  do_init_module+0x60/0x220
May 21 19:36:48 jw kernel:  init_module_from_file+0x89/0xe0
May 21 19:36:48 jw kernel:  idempotent_init_module+0x121/0x2b0
May 21 19:36:48 jw kernel:  __x64_sys_finit_module+0x5e/0xb0
May 21 19:36:48 jw kernel:  do_syscall_64+0x82/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? syscall_exit_to_user_mode+0x75/0x210
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_syscall_64+0x8e/0x160
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? __count_memcg_events+0x4d/0xb0
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? count_memcg_events.constprop.0+0x1a/0x30
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? handle_mm_fault+0x1f0/0x300
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? do_user_addr_fault+0x34e/0x620
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
May 21 19:36:48 jw kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
May 21 19:36:48 jw kernel: RIP: 0033:0x7a7397b27e9d
May 21 19:36:48 jw kernel: RSP: 002b:00007ffced8cf988 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
May 21 19:36:48 jw kernel: RAX: ffffffffffffffda RBX: 00005fb280b89d50 RCX: 00007a7397b27e9d
May 21 19:36:48 jw kernel: RDX: 0000000000000004 RSI: 00005fb2412d4478 RDI: 0000000000000000
May 21 19:36:48 jw kernel: RBP: 00005fb2412d4478 R08: 00007a7397bf6b20 R09: 0000000000000000
May 21 19:36:48 jw kernel: R10: 00005fb280b8a2f0 R11: 0000000000000246 R12: 0000000000040000
May 21 19:36:48 jw kernel: R13: 00005fb280b8a160 R14: 0000000000000000 R15: 00005fb280b8a2b0
May 21 19:36:48 jw kernel:  </TASK>
May 21 19:36:48 jw kernel: Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings

