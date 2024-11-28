Return-Path: <linux-kernel+bounces-424513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2354E9DB530
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BE0AB2665E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7838415854A;
	Thu, 28 Nov 2024 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QKGKXIy5"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDA284E1C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732788047; cv=none; b=OvqTvCSLIE+qQKsrJVgohVE6T9vzptD2X9UQQcY1hp7Rp2Xj8AJkmfn8DSldZ8ibFuLIFItn7KPsUShBSvI2C71gWXDPulNQed3HOIlfKPJR+vkrrrJuaC+O7VsKn2FIqU2X5q7uedOaMSNSX5mU6KJWpzYXxgvCf1oLFjzffms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732788047; c=relaxed/simple;
	bh=obWHKoLnCGTrAzAtHZJMkLlp5K8GMlP+wdJO0xtgmGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iY51+LZUs/gyg1qRjurgbmCWFx1bA6irP2MslCNlLxHVCFUJRaGlzGmNyks2MqHLC/+a18E1bH6AEeg8Sdi/jrNh80WHgdMEukVbqY4R5/aPYfbCislVo2Z9Xp4EtvQsPIwShGvyYo8FvwoROWQs5zIhwqxQPVqviK3pz9P688U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QKGKXIy5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa54adcb894so74024366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732788043; x=1733392843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3uNvN9Vik+yVSaq1V2CbU+97+n1V6C+ngl9oMTbvEw=;
        b=QKGKXIy5AXNd25rwVNTM/qCi72x9M5CpZMhNEWAIRmKfaiY4zR7CM3OTcDW9FDLFRn
         NqzpRWNijQksngv4amXeNpf9HN8Hr2nO2u0PT+SDc/TqD6HBxp4DiuL+UdSyp4ePpRVq
         UV6y0PA/4jVrYaAVNr4/sHxUHELNlCzMun/M5NL4i18/WekLsMKxj+WQ5AzI2FeZ/MqB
         9SFDD+QHOfm1/xmHDWkQ0E05UsDYM8XnGH5z0gAZe/HxL1FNoBMD9NWJTXY/1OHJfdXv
         k2rWIjNKj+C5jioNCfFmB2kiXUXnfVMLqc+3i830jRI2gNpY3cEPaR1eiwcJCZG92PfU
         UpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732788043; x=1733392843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3uNvN9Vik+yVSaq1V2CbU+97+n1V6C+ngl9oMTbvEw=;
        b=dLeFIGfbfQcjsU0oHaSRB153ofa3BUAhrtLqN4k0HRNMJKyo4VP6MHnOg4HgcBa1zg
         Kla1uniiHXgLeEJB8iL/hTsz74JKM9cWh8p+6rs8Fo4lBTLqRwpx1VVDyjx7DXaQek4e
         0i7MKAcALmkVUMnOGqaYiLJNtx6dYRUQTEjKzb35w7iSMLZLovdX42IA+1vP3oQAzBpM
         tQ6aOUoKTvmSKpjqr3DJry70HNwXM7FOYjMTxXEJZlmtX00QiG/lSDXrAseJCpghiHmy
         NtpEa4G8DqRp0/tanaRhf1+Co9VnRCJCk7tG+ArQ2MktuKj4U9jIoWptzaZLTncWHtW9
         qvjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYoZTMee/GvFHwDf3C/EP5H4XeWwYid55JO6/EqBHaP6gr91XCFrYXF4ZYC7rCFvGJh++LulbOb/SkL+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ul4YoxoP0F3nBnFvrF3lIPp1tMyG14BEaC8TrS7jU7KEh/PK
	Cc2kN+cxWfyTCqYHTlUivwABOaOCtCu9NhCK22xoKDrpY1RIwnaKjrzCY7anoPONGa0xdxX1YyI
	7ppyqhDoevucVLP1B06hU5eobCtSe9YuZzO9rYopMZLHyIn+TEf+lSg==
X-Gm-Gg: ASbGncs9N1M//tJ+itiF6i/jbXpDt3tWjDNycJzXfIonj4/3mLkE5R1LUwXNMKyYmnD
	8MgzvGJhib9Ef5lyeKHorXZQj77AT+cQxKeKbT6NNG2VrSvUyvPYy5fY8XjWj
X-Google-Smtp-Source: AGHT+IE1zMIjZBi+taScDXXp9yKwBN19ih5hPja8wvdOInhw0bD5uwOEmd8suab3QCJgbMO7M3KYtFiB0uLzjU8xv8M=
X-Received: by 2002:a17:906:bfea:b0:a9a:7f84:940b with SMTP id
 a640c23a62f3a-aa580ee2f7dmr453840666b.10.1732788042838; Thu, 28 Nov 2024
 02:00:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+8cD2CBcaerhwC0i7e0O4LU9oQg1w3J5RsV6qcZMEr2Uw@mail.gmail.com>
 <CAJuCfpGa55gpKHBE_0mwRPsf0f1Wp5UK7+w6N7yZi-7v31vNzw@mail.gmail.com>
 <CAKPOu+-DdwTCFDjW+ykKM5Da5wmLW3gSx5=x+fsSdaMEwUuvJw@mail.gmail.com>
 <CAJuCfpGDw7LLs2dTa+9F4J8ZaSV2YMq=-LPgOmNgrgL4P84V_Q@mail.gmail.com>
 <CAKPOu+8tvSowiJADW2RuKyofL_CSkm_SuyZA7ME5vMLWmL6pqw@mail.gmail.com>
 <CAJuCfpEBs3R8C910eiaXcSMPPrtbMjFLNYzYdPGJG+gw4WHM8A@mail.gmail.com>
 <20241121045109.GA20615@lst.de> <CAKPOu+-_X9cc723v_f_BW4CwfHJe_mi=+cbUBP2tZO-kEcyoMA@mail.gmail.com>
 <b8681f80-f2c5-44a0-b306-9f566dad65a6@linux.alibaba.com>
In-Reply-To: <b8681f80-f2c5-44a0-b306-9f566dad65a6@linux.alibaba.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 28 Nov 2024 11:00:31 +0100
Message-ID: <CAKPOu+9i69YEnSNJpeFffh6_+nONWnFRMk=SS4sBJP9-3nLD0g@mail.gmail.com>
Subject: Re: Bad psi_group_cpu.tasks[NR_MEMSTALL] counter
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 2:18=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
> Just saw this. I guess your _recent_ 6.11.9 bug is actually
> related to EROFS since EROFS uses readahead_expand().  I think
> your recent report was introduced by a recent backport fix
> commit 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted i=
mages properly")
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?=
h=3Dv6.11.9&id=3D9cfa199bcbbbba31cbf97b2786f44f4464f3f29a
>
> bio can be NULL after this patch and causes
> unbalanced psi_memstall_{enter,leave}().  It can be fixed as
> (the diff below could be damaged due to my email client):

With your patch, the PSI warning (from Suren's debugging patch) fired
again last night. Which means there may be other instances of this bug
left.

 ------------[ cut here ]------------
 Stall from readahead_expand+0xca/0x1d0 was never cleared
 WARNING: CPU: 133 PID: 91645 at kernel/sched/psi.c:989
psi_task_switch+0x126/0x230
 Modules linked in:
 CPU: 133 UID: 3221274747 PID: 91645 Comm: php-cgi8.1 Tainted: G
 W          6.11.10-cm4all2-es+ #267
 Tainted: [W]=3DWARN
 Hardware name: Dell Inc. PowerEdge R7615/0G9DHV, BIOS 1.6.10 12/08/2023
 RIP: 0010:psi_task_switch+0x126/0x230
 Code: f6 75 e6 41 f6 44 24 18 80 74 36 41 f6 84 24 d0 08 00 00 02 74
2b 49 8b b4 24 d8 08 00 00 48 c7 c7 20 c8 8d a8 e8 fa 1f f9 ff <0f> 0b
41 f6 44 24 18 80 74 0d 41 f6 84 24 d0 08 00 00 02 74 02 0f
 RSP: 0018:ffff96be9c28b9a8 EFLAGS: 00010086
 RAX: 0000000000000000 RBX: 0000000000000085 RCX: 0000000000000027
 RDX: ffff8997b995c8c8 RSI: 0000000000000001 RDI: ffff8997b995c8c0
 RBP: 000000000000001c R08: 00000000ffff7fff R09: 0000000000000058
 R10: 00000000ffff7fff R11: ffff899abd2a1000 R12: ffff891db3b85c00
 R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffff8997b9940000(0000) knlGS:00000000000000=
00
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f26d7aba480 CR3: 000000c07c61a006 CR4: 0000000000770ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? __warn+0x93/0x140
  ? psi_task_switch+0x126/0x230
  ? report_bug+0x174/0x1a0
  ? handle_bug+0x53/0x90
  ? exc_invalid_op+0x17/0x70
  ? asm_exc_invalid_op+0x16/0x20
  ? psi_task_switch+0x126/0x230
  ? psi_task_switch+0x126/0x230
  __schedule+0x980/0x10f0
  do_task_dead+0x3e/0x40
  do_exit+0x6ed/0x970
  do_group_exit+0x2c/0x80
  __x64_sys_exit_group+0x14/0x20
  x64_sys_call+0x15aa/0x17b0
  do_syscall_64+0x64/0x100
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? get_page_from_freelist+0x60e/0x1140
  ? cgroup_rstat_updated+0x88/0x210
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? __mod_memcg_lruvec_state+0x91/0x140
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? __lruvec_stat_mod_folio+0x80/0xd0
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? folio_add_file_rmap_ptes+0x37/0xb0
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? set_pte_range+0xb7/0x280
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? next_uptodate_folio+0x83/0x270
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? filemap_map_pages+0x4a2/0x590
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? do_fault+0x291/0x4d0
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? __handle_mm_fault+0x31c/0x1060
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? __count_memcg_events+0x53/0xf0
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? handle_mm_fault+0xb6/0x280
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? do_user_addr_fault+0x386/0x610
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? exc_page_fault+0x6f/0x120
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f26dad48349
 Code: Unable to access opcode bytes at 0x7f26dad4831f.
 RSP: 002b:00007ffcd05a7848 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
 RAX: ffffffffffffffda RBX: 00007f26dae429e0 RCX: 00007f26dad48349
 RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
 RBP: 0000000000000000 R08: fffffffffffffd48 R09: 000055c238e82190
 R10: 00007f26d8a781a8 R11: 0000000000000246 R12: 00007f26dae429e0
 R13: 00007f26dae482e0 R14: 000000000000001e R15: 00007f26dae482c8
  </TASK>
 ---[ end trace 0000000000000000 ]---

