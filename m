Return-Path: <linux-kernel+bounces-313527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D1F96A6B1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7B25B20D9A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2D4191F62;
	Tue,  3 Sep 2024 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2/msGapL"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB62175D45
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388757; cv=none; b=WUyy4WkzbVmT0zWoUClycV+uNKVCw+iDupGHbeKVbOw0OtY8MFcr+QJmvoOHnRjXrqzz3BPiFvX23ZrReQMMS8vJBhFvzU8QbeGNM7Ui5zVzZwi5bx9o6a4nx9LINPpKLJK3e8jApVG/ehRPVmsAAlxPfe277hHxCcFW8YqzFuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388757; c=relaxed/simple;
	bh=7S6y7vZbqbEkFSElUCkqajh4xoR7NqYWU+0JoeqQEGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhTk/oEcq23BytZMKhkZ/wVmBFlIEyB2HEhJXOqvQRAjUtJ2ZKpH+cuq2zO4UL8Tf4XgqFd+se5/OuDeKQ+Zs1Uq0+dgaI06mwY8wyyPGlb7bzx+9VVBySd5wLodnPw6XGtbihpuSnotmfj/SD2p03iabluSCdZ8YSoBtKgQ4BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2/msGapL; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a86984e035aso691680966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 11:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725388754; x=1725993554; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o7ZyRd+YkYe9/+6vmRhnsrYoSz+GnkaG4/Tw8IFdilo=;
        b=2/msGapLxmXHTqcKCOVLuiBEvurFrw9okxo5g1HEhwO30SU9KTBXt74HF9Sz6dv8Cs
         Mq9fWgyBXfoxqbsryorN3BIcD6JujzmT/R9gJp8/9JHB3W4dr8u33q6LibsUT/XbqrJv
         Df8AK44zAaYwgHBWSLoHHzgWJSDxqM+TFs5TbzbCR1PFi12cdTOmDKYUvj28cMT/y/9M
         mEV6LSYc8ySoMEk7Zf/7yIpd9c7uQD0TxTX/pmb+rQ5bqlOAVfZR9JlblIup+tqJDwvr
         NlhiMj0e7vcJ5pVZYjgmiLbrfl1PKErkkVhSbdjFXfh1b+TWX/e7Gcf3LPIQQMEYZmjq
         Q/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725388754; x=1725993554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7ZyRd+YkYe9/+6vmRhnsrYoSz+GnkaG4/Tw8IFdilo=;
        b=sZeGRApjNkoWRWGz4vAOEI0JPrz2dV03c76XFXcYaeIzuzPT/K2MbQzZkWu5N+oAhS
         9+d4lhQEJDhObsRLBtrjrlLsbECeiJWEG0El2Zrox7R42lzn0Bi/t+Qk40H60h3HHMbC
         A28XBgwSr6pCf3tNBSD/x3h86JaDEV4zL9jyifIaXxrQRmm75RxksInDLYtiLI3bEvgJ
         KA9EHKjK0JYOn1hyZ3xDYPGSneHaKDLos9uaIWah3OC0PKiJQhaDlJJaJINgfa1PsC2O
         suZlasf/HvIeQzY48vm6D2+GboNmnW+OKvtBOgxpjweVkMeENevjzsXbiRVB6/QsOa1+
         wJ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJZFJvXncz43OOdqCQwTKKY8TVzKFussqlopJdzeJ4cUo/lefQc1eN8ZvnVCB+7L+tyGSM8YJDFIn7jsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB0L9NiiqmutKQFDyj6FemEUAJYIGBFm0sh7Ijvr/mfqVzTAL5
	JZpX1QNuN/pzQNlKB7rxIzI+ZNNSrHFRf5EIUk3knlE0k6REKFEJztG2AiBcWzejC5b8+jXNOA1
	5L/dgqtwOtAJEGV59P7fQywVz38QpVUz0RJud
X-Google-Smtp-Source: AGHT+IGj0mWyRsR47LHFVEGQKRqzSzE70fQIG2IcbCUZGxyhvIEZ6EH02JjyFrfCwcAVlEcOsMlNJNgo86eeIPK4uC8=
X-Received: by 2002:a17:907:846:b0:a7a:b73f:7582 with SMTP id
 a640c23a62f3a-a89a350eefemr994272266b.2.1725388753105; Tue, 03 Sep 2024
 11:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821074541.516249-1-hanchuanhua@oppo.com> <20240821074541.516249-3-hanchuanhua@oppo.com>
 <CAMgjq7BpOqgKoeQEPCL9ai3dvVPv7wJe3k_g1hDjAVeCLpZ=7w@mail.gmail.com>
In-Reply-To: <CAMgjq7BpOqgKoeQEPCL9ai3dvVPv7wJe3k_g1hDjAVeCLpZ=7w@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 3 Sep 2024 11:38:37 -0700
Message-ID: <CAJD7tka+ZONNFKw=1FM22b-JTPkiKZaKuM3Upyu6pf4=vN_CRg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] mm: support large folios swap-in for sync io devices
To: Kairui Song <ryncsn@gmail.com>
Cc: hanchuanhua@oppo.com, Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, baolin.wang@linux.alibaba.com, chrisl@kernel.org, 
	david@redhat.com, hannes@cmpxchg.org, hughd@google.com, 
	kaleshsingh@google.com, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"

[..]
>
> With latest mm-unstable, I'm seeing following WARN followed by user
> space segfaults (multiple mTHP enabled):
>
> [   39.145686] ------------[ cut here ]------------
> [   39.145969] WARNING: CPU: 24 PID: 11159 at mm/page_io.c:535
> swap_read_folio+0x4db/0x520
> [   39.146307] Modules linked in:
> [   39.146507] CPU: 24 UID: 1000 PID: 11159 Comm: sh Kdump: loaded Not
> tainted 6.11.0-rc6.orig+ #131
> [   39.146887] Hardware name: Tencent Cloud CVM, BIOS
> seabios-1.9.1-qemu-project.org 04/01/2014
> [   39.147206] RIP: 0010:swap_read_folio+0x4db/0x520
> [   39.147430] Code: 00 e0 ff ff 09 c1 83 f8 08 0f 42 d1 e9 c4 fe ff
> ff 48 63 85 34 02 00 00 48 03 45 08 49 39 c4 0f 85 63 fe ff ff e9 db
> fe ff ff <0f> 0b e9 91 fd ff ff 31 d2 e9 9d fe ff ff 48 c7 c6 38 b6 4e
> 82 48
> [   39.148079] RSP: 0000:ffffc900045c3ce0 EFLAGS: 00010202
> [   39.148390] RAX: 0017ffffd0020061 RBX: ffffea00064d4c00 RCX: 03ffffffffffffff
> [   39.148737] RDX: ffffea00064d4c00 RSI: 0000000000000000 RDI: ffffea00064d4c00
> [   39.149102] RBP: 0000000000000001 R08: ffffea00064d4c00 R09: 0000000000000078
> [   39.149482] R10: 00000000000000f0 R11: 0000000000000004 R12: 0000000000001000
> [   39.149832] R13: ffff888102df5c00 R14: ffff888102df5c00 R15: 0000000000000003
> [   39.150177] FS:  00007f51a56c9540(0000) GS:ffff888fffc00000(0000)
> knlGS:0000000000000000
> [   39.150623] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   39.150950] CR2: 000055627b13fda0 CR3: 00000001083e2000 CR4: 00000000003506b0
> [   39.151317] Call Trace:
> [   39.151565]  <TASK>
> [   39.151778]  ? __warn+0x84/0x130
> [   39.152044]  ? swap_read_folio+0x4db/0x520
> [   39.152345]  ? report_bug+0xfc/0x1e0
> [   39.152614]  ? handle_bug+0x3f/0x70
> [   39.152891]  ? exc_invalid_op+0x17/0x70
> [   39.153178]  ? asm_exc_invalid_op+0x1a/0x20
> [   39.153467]  ? swap_read_folio+0x4db/0x520
> [   39.153753]  do_swap_page+0xc6d/0x14f0
> [   39.154054]  ? srso_return_thunk+0x5/0x5f
> [   39.154361]  __handle_mm_fault+0x758/0x850
> [   39.154645]  handle_mm_fault+0x134/0x340
> [   39.154945]  do_user_addr_fault+0x2e5/0x760
> [   39.155245]  exc_page_fault+0x6a/0x140
> [   39.155546]  asm_exc_page_fault+0x26/0x30
> [   39.155847] RIP: 0033:0x55627b071446
> [   39.156124] Code: f6 7e 19 83 e3 01 74 14 41 83 ee 01 44 89 35 25
> 72 0c 00 45 85 ed 0f 88 73 02 00 00 8b 05 ea 74 0c 00 85 c0 0f 85 da
> 03 00 00 <44> 8b 15 53 e9 0c 00 45 85 d2 74 2e 44 8b 0d 37 e3 0c 00 45
> 85 c9
> [   39.156944] RSP: 002b:00007ffd619d54f0 EFLAGS: 00010246
> [   39.157237] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f51a44f968b
> [   39.157594] RDX: 0000000000000000 RSI: 00007ffd619d5518 RDI: 00000000ffffffff
> [   39.157954] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000007
> [   39.158288] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> [   39.158634] R13: 0000000000002b9a R14: 0000000000000000 R15: 00007ffd619d5518
> [   39.158998]  </TASK>
> [   39.159226] ---[ end trace 0000000000000000 ]---
>
> After reverting this or Usama's "mm: store zero pages to be swapped
> out in a bitmap", the problem is gone. I think these two patches may
> have some conflict that needs to be resolved.

Yup. I saw this conflict coming and specifically asked for this
warning to be added in Usama's patch to catch it [1]. It served its
purpose.

Usama's patch does not handle large folio swapin, because at the time
it was written we didn't have it. We expected Usama's series to land
sooner than this one, so the warning was to make sure that this series
handles large folio swapin in the zeromap code. Now that they are both
in mm-unstable, we are gonna have to figure this out.

I suspect Usama's patches are closer to land so it's better to handle
this in this series, but I will leave it up to Usama and
Chuanhua/Barry to figure this out :)

[1]https://lore.kernel.org/lkml/CAJD7tkbpXjg00CRSrXU_pbaHwEaW1b3k8AQgu8y2PAh7EkTOug@mail.gmail.com/

