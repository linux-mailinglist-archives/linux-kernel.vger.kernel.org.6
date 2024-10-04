Return-Path: <linux-kernel+bounces-350335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9912399039D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95F01C21EE2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17A921019F;
	Fri,  4 Oct 2024 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvF0VK3f"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C8D20FAB6
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047378; cv=none; b=lBfvs2vSJZAk9TXbNoNQr7DFP5UFUHhe672I5w3DDSizj5HwU5sW8npnJ6fzwaQePrK/GesFADWR8rjo0xarMpW5/laMLPbeUicbaGXnlrcLK1wtDZ3uqeul4IOV1xGiVh3WIjF9ZuKYRkLQmF9gsNRrTsaI4mYhljZWX5wWvPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047378; c=relaxed/simple;
	bh=e4ZhVHNkBAzYmsO0ZGXrAiB+IgektorsBuRogI5Nz5g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NZ7Q9C6F4+ahThp2yKFtOUid5ULXCgkpFXDyByQkzUyMwe1p8sMLrNW4WJYW4R0qt45FzusvCwUw9ykE8m1E01bvHJRdgmuMMdnNetc4hVq0femphFIR/+Yq21XQKAUlMM2Cf3PIaZKt+3A6lFH/ymNWmdt5csoeTytCjnH/akY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvF0VK3f; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-717839f9eb6so311390b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 06:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728047376; x=1728652176; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e4ZhVHNkBAzYmsO0ZGXrAiB+IgektorsBuRogI5Nz5g=;
        b=dvF0VK3ffk/DanrUePcbJSq74Fd5mpBj69LmBJRxj7RFxGLG+jBHrQnb6gIeHNQc4d
         C6LswOW0rZ+NegIE2YD0NndDiqvMEPrPRzjQ7gsf94xitUG3RiG7qZtrR7uk2z7KdYC5
         MpkEhKVRx6vASt3pYEk7G6GSE7PiprdSSKP2rupCyrQFOfAtoKxnr0oGTYbJPP+THBko
         KDqJ0hdMS3c5WAET1DT8B9ymuacK0Ax0TaIHr6hozdw+6YPnfr/6JHAxdsMEHWb7ZjGg
         5fj+zrUkE2XwWJqlxA2lTbFcuxaVhdfHJ3S1TEGKtomrF2NioCsRAShV+KvXyaRvEK7C
         BvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728047376; x=1728652176;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e4ZhVHNkBAzYmsO0ZGXrAiB+IgektorsBuRogI5Nz5g=;
        b=Duv74dsk99U4pv6TyIMyXry5pnpb2iHZ+d3xWz1Nk5+uP4hGlvrFjtmAR4mAvmnWg/
         DAiJc9wZXHTSxWdbNjmfyVaG+iZrTWYGKFH/H4RrByNkDIQYX/zMMyP4zNTH8b7f7w8R
         0o6OrtLV69XDySwk/kqJdjZhI3+0EAYP8bdb9bOIYoXuZasZDghSYrV8QBIva4kQQMjG
         ys43t7AXNKTDfLzB3dwn5sVpkrtVgWLsftBLPcIeomsvJjSuvGy1vjPu0qHCKTps61op
         4Jk88MGb4rtmsZY6FOPsSqDyBbZqmQVY07L/1AGuV5MAhs12X2GM7q6mAx+jspVEyOhT
         PaFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ4YdLH3u07ExEGg+zbIjYBnBTQSR18/kDobZ02K2RyMR9ht/fcQko+Equ5R6o9UeCSrpMs19gD+PXwZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGZZ3mc/UM0a+alLQUhY/Q3Sag60SslAWa1tjm+7SIEYnOsuol
	ui1F92jMHtUqRSb16xwsGhImMqvR3XuVdSljFmww3hcgup9dIQ5EKHwSsxvDFLMebzFb7KbsS3N
	M9DsPd9afVqPLyNDJktvVNwIOPulMEBk6mzE=
X-Google-Smtp-Source: AGHT+IHg+G4TX0kPJfI06ALZgDkNwEzzofGoP8Ha/LpJC21IwlTeMCQUaiHCQ5UVPBFNBp3SNVwbFRCW8Rzlc7A+MmQ=
X-Received: by 2002:aa7:88ca:0:b0:717:8ee5:e9d2 with SMTP id
 d2e1a72fcca58-71de23a0d3dmr1761038b3a.2.1728047376137; Fri, 04 Oct 2024
 06:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 4 Oct 2024 15:09:22 +0200
Message-ID: <CANiq72k-wbyR=FeBVBPMqqF6Re9eO4LtdHYqvMQgXSe3cHQsGg@mail.gmail.com>
Subject: VM_BUG_ON_PAGE(PageAnonNotKsm(page)) defconfig riscv64
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, Linux-MM <linux-mm@kvack.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Matthew,

I noticed riscv64 defconfig seems to reproducibly hit
`VM_BUG_ON_PAGE(PageAnonNotKsm(page))` in today's next-20241004 --
please see below.

I hope that helps!

Cheers,
Miguel

[ 0.676534] Freeing unused kernel image (initmem) memory: 2260K
[ 0.677337] Run /init as init process
[ 0.680562] page: refcount:1 mapcount:1 mapping:0000000000000000
index:0xfffffffffff pfn:0x81034
[ 0.680882] memcg:ff60000001893000
[ 0.680993] anon flags: 0x20008(uptodate|swapbacked|zone=0)
[ 0.681620] raw: 0000000000020008 0000000000000000 dead000000000122
ff60000002751001
[ 0.681846] raw: 00000fffffffffff 0000000000000000 0000000100000000
ff60000001893000
[ 0.682098] page dumped because: VM_BUG_ON_PAGE(PageAnonNotKsm(page))
[ 0.682588] ------------[ cut here ]------------
[ 0.682691] kernel BUG at include/linux/page-flags.h:1134!
[ 0.682876] Kernel BUG [#1]
[ 0.682905] Modules linked in:
[ 0.683094] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
6.12.0-rc1-next-20241004 #1
[ 0.683183] Hardware name: riscv-virtio,qemu (DT)
[ 0.683261] epc : folio_add_new_anon_rmap+0x330/0x518
[ 0.683623] ra : folio_add_new_anon_rmap+0x330/0x518
[ 0.683640] epc : ffffffff801ca72a ra : ffffffff801ca72a sp : ff200000000139d0
[ 0.683654] gp : ffffffff815223f8 tp : ff600000018a8000 t0 : 00000000000000bf
[ 0.683667] t1 : ff20000000013768 t2 : 0000000000000018 s0 : ff20000000013a10
[ 0.683679] s1 : ff1c000000040d00 a0 : 0000000000000039 a1 : f635137454d54500
[ 0.683691] a2 : f635137454d54500 a3 : 00000000ffffefff a4 : ffffffff8142e8b0
[ 0.683704] a5 : ffffffff8142e898 a6 : ffffffff8142e8b0 a7 : 0000000000000000
[ 0.683716] s2 : 0000000000000001 s3 : ff6000000274a000 s4 : 00fffffffffff000
[ 0.683728] s5 : 0000000000000fff s6 : 0000000000000001 s7 : 0000000000000001
[ 0.683741] s8 : ffffffff81526090 s9 : 0000000000000000 s10: ffffffff812c13c0
[ 0.683754] s11: ff6000000274a000 t3 : 0000000000000003 t4 : ff60000001870f00
[ 0.683766] t5 : ff60000001870000 t6 : ff60000001870f00
[ 0.683777] status: 0000000000000120 badaddr: 0000000000000000 cause:
0000000000000003
[ 0.683855] [<ffffffff801ca72a>] folio_add_new_anon_rmap+0x330/0x518
[ 0.683924] [<ffffffff801b9f20>] do_anonymous_page+0x2fc/0x4d6
[ 0.683936] [<ffffffff801bbcdc>] handle_pte_fault+0xe4/0x250
[ 0.683948] [<ffffffff801b47da>] handle_mm_fault+0x1c4/0x28e
[ 0.683958] [<ffffffff801aa322>] __get_user_pages+0x33c/0x78e
[ 0.683968] [<ffffffff801aaee0>] get_user_pages_remote+0x102/0x2da
[ 0.683977] [<ffffffff80228c7e>] get_arg_page+0xa8/0x14c
[ 0.683987] [<ffffffff80228a9a>] copy_string_kernel+0xe6/0x222
[ 0.683997] [<ffffffff8022a136>] kernel_execve+0x198/0x2c6

