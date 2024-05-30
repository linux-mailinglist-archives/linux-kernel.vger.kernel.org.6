Return-Path: <linux-kernel+bounces-195045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3CB8D46C7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2111F22E99
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704B9149C43;
	Thu, 30 May 2024 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="TrhXUW4X"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFFE142E78
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717056739; cv=none; b=JU0xX/W1jd5hfP1avVGja3QaGHEetFypI2ro+X5UKsRnjZkBCs9swMTUlSeBP5gbAF1+rHGv6KW68gMXkgPUcQQYNUS+jlOWmsyxPWEGRKE+AqRpcjD0/tXfnHtpHKJyjH/xnH1709kQ/x9J4gQZwgiB56DH4E7pluReKf5iZa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717056739; c=relaxed/simple;
	bh=b36ptOrZLbp9VgClGgn062bTf6HSEnqFNMuWkc2DGak=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=rgjv4RCCrolxVMxaIpSNNJp1Tdn3MnrOoijjJkIb/wSkGVrNNygyjwbUXsaSotvRQx1y+FnmhMulnyRjfduumNrheLVyEj7wJtREiyvDbXxoShuiZj7iZ7bHX6oyhWORi1/ABfs/ckLxvTPaAjZcTNqBHowb2X7cALf4iv0lS64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=TrhXUW4X; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f12eb91ec7so352456a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1717056737; x=1717661537; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mk8s2JgIgahnLhxv8haFG9bKYTOSppYDnekfr0DIiA4=;
        b=TrhXUW4X4AolxoNmvUFmUItC2cajjchb8tyPxpqKi/eEz7woeV15HG0hZI5uZ2hOwi
         krvLDDQ1AhWYVn0Sfgo/CHsO8qS19eT3p9VXJYDxBS8YSLEPZSwKC86nHhgjilusZ2aS
         T3ZstMBgXW28nF4Va5wtb6xfxGTEGj4kLuYiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717056737; x=1717661537;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mk8s2JgIgahnLhxv8haFG9bKYTOSppYDnekfr0DIiA4=;
        b=ax0rb5zFf4uZdPnnrnGrvyp0AP8vO3Fbw7GqkAsayssWbopwRPv+a0nHW3MOE14CXm
         1Cu4GKjoF0WS+F9hGK0D+6f5D8VHcKHkf0bq/crgHsNOkdPuIfp61fuyrQw5HvxgZL3u
         2xacQr+SKV8NGNxyx3xtKqvqWCCSHcVcZVTDoQuRpRzidC39suJpEtTMnGLSedqYhfb7
         lAzlb0dm+EMBCp5bxe3GsOXQwjuGLHiDzyMytG/JhUnvCBCE0M2JdWlCWWGyKy860NK3
         c9S688gT1jRynifKcw6CyHAw4HQgEBuA80ldgW97snlOkPSt9T4K4rLwTuvUYNiqcyNW
         auWg==
X-Forwarded-Encrypted: i=1; AJvYcCWIXzaW5j84eQa5A38xGQpHBWJJE//37kcFkpXaQCEb/mEvXPRtPvf0XvyhZYoVPk++UQ/s4U0agFBLSXjLq8HwVErDF8uv4Rqni1co
X-Gm-Message-State: AOJu0Yxo+r6K3oyYZoxH1p9/DkOFDpH5V4/0zqkAgcL5bVqIAJLlx0u6
	ZDztIyR0turKHNp3hcub7qkHH3Ed22ohYTOdEJFbdvYTMpaZPc0s5CrOZLeZvqk=
X-Google-Smtp-Source: AGHT+IFK4mB7zaoLDcur2cxaiz3r49gqRI/eWfg8N/RgZbGgE7M/Gjpol66O2D0g+WZ1JMs9CRYt9Q==
X-Received: by 2002:a05:6830:2083:b0:6f0:e7da:6637 with SMTP id 46e09a7af769-6f90af28fd1mr1528286a34.31.1717056737174;
        Thu, 30 May 2024 01:12:17 -0700 (PDT)
Received: from smtpclient.apple ([50.35.64.139])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f8f1f8cdf1sm1238165a34.35.2024.05.30.01.12.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2024 01:12:16 -0700 (PDT)
From: Yaohui Hu <yhu@digitalocean.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: md_raid: mdX_raid6 looping after sync_action "check" to "idle"
 transition
Message-Id: <E5A94FC9-E0E4-4A82-AA51-CBFC766231A4@digitalocean.com>
Date: Thu, 30 May 2024 01:12:04 -0700
Cc: buczek@molgen.mpg.de,
 dragan@stancevic.com,
 guoqing.jiang@linux.dev,
 it+raid@molgen.mpg.de,
 linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org,
 msmith626@gmail.com,
 song@kernel.org,
 yangerkun@huawei.com,
 yukuai3@huawei.com
To: yukuai1@huaweicloud.com
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Hi,

After applied suggested 7 commits to kernel v6.1. There are still =
deadlocks in raid456 such as following. Do we have other follow up patch =
to fix this issue?=20

[2378440.310330] INFO: task systemd-journal:1415 blocked for more than =
120 seconds.
[2378440.318649]       Tainted: G           OE K    =
6.1.51-0digitalocean2-generic #0digitalocean2
[2378440.328327] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" =
disables this message.
[2378440.337306] task:systemd-journal state:D stack:0     pid:1415  =
ppid:1      flags:0x00000006
[2378440.337310] Call Trace:
[2378440.337312]  <TASK>
[2378440.337315]  __schedule+0x1f5/0x5c0
[2378440.337324]  schedule+0x53/0xb0
[2378440.337327]  io_schedule+0x42/0x70
[2378440.337329]  folio_wait_bit_common+0x11f/0x310
[2378440.337335]  ? filemap_invalidate_unlock_two+0x40/0x40
[2378440.337338]  ? ext4_da_map_blocks.constprop.0+0x370/0x370
[2378440.337342]  block_page_mkwrite+0x113/0x160
[2378440.337346]  ext4_page_mkwrite+0x233/0x6d0
[2378440.337349]  do_page_mkwrite+0x4d/0xe0
[2378440.337352]  do_wp_page+0x1d9/0x440
[2378440.337355]  __handle_mm_fault+0x50a/0x5d0
[2378440.337358]  handle_mm_fault+0xe3/0x2e0
[2378440.337359]  do_user_addr_fault+0x187/0x560
[2378440.337363]  exc_page_fault+0x6c/0x150
[2378440.337366]  asm_exc_page_fault+0x22/0x30
[2378440.337371] RIP: 0033:0x7f2b4b7c9e7a
[2378440.337377] RSP: 002b:00007ffcd6387340 EFLAGS: 00010202
[2378440.337379] RAX: 0000000004725c68 RBX: 000056420cb077f0 RCX: =
00007f2b3a7983b0
[2378440.337381] RDX: 00007f2b3fb25c68 RSI: 000056420cb077f0 RDI: =
00007f2b3a7983d8
[2378440.337382] RBP: 000056420caca8f0 R08: 00000000003983b0 R09: =
00007ffcd6387370
[2378440.337383] R10: 86c0275e98fea605 R11: 0000000000244a4c R12: =
000000000000000a
[2378440.337384] R13: e4bdb9e57ca6925c R14: 0000000000000000 R15: =
00007ffcd6387378
[2378440.337386]  </TASK>
[2378440.337587] INFO: task md8_resync:3952093 blocked for more than 120 =
seconds.
[2378440.345699]       Tainted: G           OE K    =
6.1.51-0digitalocean2-generic #0digitalocean2
[2378440.355371] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" =
disables this message.
[2378440.364359] task:md8_resync      state:D stack:0     pid:3952093 =
ppid:2      flags:0x00004000
[2378440.364362] Call Trace:
[2378440.364363]  <TASK>
[2378440.364364]  __schedule+0x1f5/0x5c0
[2378440.364368]  schedule+0x53/0xb0
[2378440.364372]  raid5_get_active_stripe+0x1f6/0x290 [raid456]
[2378440.364381]  ? destroy_sched_domains_rcu+0x30/0x30
[2378440.364385]  raid5_sync_request+0x289/0x2c0 [raid456]
[2378440.364392]  ? is_mddev_idle+0xb5/0x115
[2378440.364395]  md_do_sync.cold+0x3eb/0x96b
[2378440.364398]  ? destroy_sched_domains_rcu+0x30/0x30
[2378440.364400]  md_thread+0xa9/0x160
[2378440.364406]  ? super_90_load.part.0+0x300/0x300
[2378440.364408]  kthread+0xb9/0xe0
[2378440.364412]  ? kthread_complete_and_exit+0x20/0x20
[2378440.364414]  ret_from_fork+0x1f/0x30
[2378440.364418]  </TASK>

Thanks=

