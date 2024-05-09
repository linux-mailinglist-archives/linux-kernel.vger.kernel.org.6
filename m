Return-Path: <linux-kernel+bounces-174056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D9D8C09B4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E051F2255D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D441F13CA8A;
	Thu,  9 May 2024 02:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwWz7Ov2"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF6B3FBB2
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 02:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715221217; cv=none; b=f0uIMfeUBR4cwAMxZ8rZtwBjO/POwHxyrAsToQvasyagWTf0xIkjHcTneOxs/7v2+v4W/SK2omw9hACD9GJJQgtqQcyYiQASa8HcVTJhqLBqxnlSDZx8I0dyzDgItjbregr/8w+q+ycrOd9pNkZ3wCgcg2MsmRoHhwiol+KG/fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715221217; c=relaxed/simple;
	bh=xLDIGKFKTO+tLE5DVDCQ6deg4vZT4lu1SaB22dqvSws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHBfAM2QzvkQztXL1Vf2/X/WjyDiVMjp4d+I5oWZo64ZUiopAGqIwDl1WXZsMusupmVJnYs10lho/dVA6lma6sHil3TaZlg+56gX3p2gOBN91pptq1uuta8XGKnJkH9wtnoMo3WfQFqZqn4durx/CvObIBSNogHdQd7v6i5RagY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwWz7Ov2; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4df550a4d4fso172234e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 19:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715221214; x=1715826014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16ufiicew0m3mWhNX+CcZ/zKAVzfqZM1+hj2NNR8WOI=;
        b=LwWz7Ov2FibIg7muTx3tvrF+bckPB0nN2w9eO//P1wXmjElcYJAIGgMi6AYNouQDHm
         gH3db3BVVMXqPi3muuq4GwPH+g9KMHI81SkMV4uuGlE8JrrXtWOxDXGX/sXXqiNIbYy6
         cwRpqnaoT8FW/emtwlAFBLaJiqQH1R1hzOpbD8xlxLRxRppgxLluLCAz8ooqGo62TnRy
         8N9xpZQouE3KhsHeZKtKq2n6NQXY0SW9URKbZSnBlQzLP8ILjBJyqGmgqvhcYGkMNUu9
         0DqAbz09rh6Fzq6mD+TVua2CH4kgl8GyFxwzGa6VcS9rZPFG5+NVJp5adKboifMtYsv+
         0T8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715221214; x=1715826014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16ufiicew0m3mWhNX+CcZ/zKAVzfqZM1+hj2NNR8WOI=;
        b=JbuJ01FAXPzgxwvfc2pmDzaCOUOyPSmbf4rGntD7KNMntpIlpRhqWtL1vzUW9sVb0w
         jVKeDRkKrga1BCtJTQRpPzzTQnbcEgz5vGIZrRS5eu7RQpXe8w2kjFzpmG6t9umx48Kr
         UiARQLECSy1QKV3nZhAvTfCIruhlHyYGBGvTBwEBwZPrIayFaaQ0J83k3JUxEHWakOBQ
         sDUSweOv74ZG3CKwECthfV8ybZI0wPXTvPZsHEiABAwWcjVAoGqH7fSrz7Mj02N2C8Is
         ZktjlvHJDC+nQa1fjEq8b/KrLEpCqqs6w9HRAKDt5Aew1amHcIpEDFAcYGmUolFW87XX
         KPAw==
X-Forwarded-Encrypted: i=1; AJvYcCXKZktMqKaKr363NUZMByD3/QSXIrIuyVJdAWKRQoIoaQpB4QHGa5y38EPyHjHVFxZIuscjZmRSDG4aCSfXUZJA7lnOXNsAaqVj9ayw
X-Gm-Message-State: AOJu0YwTX+j43OpM3kt2N1qyLgCIQLb9fDUHmXuWxffkLOfU6+dKTZSa
	OLCBuTn4+Sy/Dn5GVDeYoDsU8LkniMGplwHY69Gys9EdK8fwA4ZOTFo7/8M/2I6qXakWI1s/hYo
	Ofic6PbfKZ4c+w3E65Vlk+clGW6I=
X-Google-Smtp-Source: AGHT+IFfbbQmOoLrnvLxc0mIPwN7/ziRbLsk9SuYfrgRc1ypExGC2qC3Fn3TrpGCMdsA6LWVE1oXHUbBvhSCk0uloAo=
X-Received: by 2002:a05:6122:25fc:b0:4df:7ba8:5c73 with SMTP id
 71dfb90a1353d-4df7ba86309mr623903e0c.14.1715221214350; Wed, 08 May 2024
 19:20:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508125808.28882-1-hailong.liu@oppo.com>
In-Reply-To: <20240508125808.28882-1-hailong.liu@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 9 May 2024 14:20:03 +1200
Message-ID: <CAGsJ_4xN0MBz_73wUvMp74upd9SaQ+TCRJufEj26Y619Rtr7Zw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
To: hailong.liu@oppo.com
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org, 
	lstoakes@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	xiang@kernel.org, chao@kernel.org, Oven <liyangouwen1@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 12:58=E2=80=AFAM <hailong.liu@oppo.com> wrote:
>
> From: "Hailong.Liu" <hailong.liu@oppo.com>
>
> Commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
> includes support for __GFP_NOFAIL, but it presents a conflict with
> commit dd544141b9eb ("vmalloc: back off when the current task is
> OOM-killed"). A possible scenario is as belows:
>
> process-a
> kvcalloc(n, m, GFP_KERNEL | __GFP_NOFAIL)
>     __vmalloc_node_range()
>         __vmalloc_area_node()
>             vm_area_alloc_pages()
>             --> oom-killer send SIGKILL to process-a
>             if (fatal_signal_pending(current)) break;
> --> return NULL;
>
> to fix this, do not check fatal_signal_pending() in vm_area_alloc_pages()
> if __GFP_NOFAIL set.
>
> Reported-by: Oven <liyangouwen1@oppo.com>
> Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6641be0ca80b..2f359d08bf8d 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3560,7 +3560,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>
>         /* High-order pages or fallback path if "bulk" fails. */
>         while (nr_allocated < nr_pages) {
> -               if (fatal_signal_pending(current))
> +               if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(current=
))
>                         break;

why not !nofail ?

This seems a correct fix, but it undermines the assumption made in
commit dd544141b9eb
 ("vmalloc: back off when the current task is OOM-killed")

"
    This may trigger some hidden problems, when caller does not handle
    vmalloc failures, or when rollaback after failed vmalloc calls own
    vmallocs inside.  However all of these scenarios are incorrect: vmalloc
    does not guarantee successful allocation, it has never been called with
    __GFP_NOFAIL and threfore either should not be used for any rollbacks o=
r
    should handle such errors correctly and not lead to critical failures.
"

If a significant kvmalloc operation is performed with the NOFAIL flag, it r=
isks
reverting the fix intended to address the OOM-killer issue in commit
dd544141b9eb.
Should we indeed permit the NOFAIL flag for large kvmalloc allocations?

>
>                 if (nid =3D=3D NUMA_NO_NODE)
> ---
> This issue occurred during OPLUS KASAN test. Below is part of the log
>
> -> send signal
> [65731.222840] [ T1308] oom-kill:constraint=3DCONSTRAINT_NONE,nodemask=3D=
(null),cpuset=3D/,mems_allowed=3D0,global_oom,task_memcg=3D/apps/uid_10198,=
task=3Dgs.intelligence,pid=3D32454,uid=3D10198
>
> [65731.259685] [T32454] Call trace:
> [65731.259698] [T32454]  dump_backtrace+0xf4/0x118
> [65731.259734] [T32454]  show_stack+0x18/0x24
> [65731.259756] [T32454]  dump_stack_lvl+0x60/0x7c
> [65731.259781] [T32454]  dump_stack+0x18/0x38
> [65731.259800] [T32454]  mrdump_common_die+0x250/0x39c [mrdump]
> [65731.259936] [T32454]  ipanic_die+0x20/0x34 [mrdump]
> [65731.260019] [T32454]  atomic_notifier_call_chain+0xb4/0xfc
> [65731.260047] [T32454]  notify_die+0x114/0x198
> [65731.260073] [T32454]  die+0xf4/0x5b4
> [65731.260098] [T32454]  die_kernel_fault+0x80/0x98
> [65731.260124] [T32454]  __do_kernel_fault+0x160/0x2a8
> [65731.260146] [T32454]  do_bad_area+0x68/0x148
> [65731.260174] [T32454]  do_mem_abort+0x151c/0x1b34
> [65731.260204] [T32454]  el1_abort+0x3c/0x5c
> [65731.260227] [T32454]  el1h_64_sync_handler+0x54/0x90
> [65731.260248] [T32454]  el1h_64_sync+0x68/0x6c
> [65731.260269] [T32454]  z_erofs_decompress_queue+0x7f0/0x2258
> --> be->decompressed_pages =3D kvcalloc(be->nr_pages, sizeof(struct page =
*), GFP_KERNEL | __GFP_NOFAIL);
>         kernel panic by NULL pointer dereference.
>         erofs assume kvmalloc with __GFP_NOFAIL never return NULL.
>
> [65731.260293] [T32454]  z_erofs_runqueue+0xf30/0x104c
> [65731.260314] [T32454]  z_erofs_readahead+0x4f0/0x968
> [65731.260339] [T32454]  read_pages+0x170/0xadc
> [65731.260364] [T32454]  page_cache_ra_unbounded+0x874/0xf30
> [65731.260388] [T32454]  page_cache_ra_order+0x24c/0x714
> [65731.260411] [T32454]  filemap_fault+0xbf0/0x1a74
> [65731.260437] [T32454]  __do_fault+0xd0/0x33c
> [65731.260462] [T32454]  handle_mm_fault+0xf74/0x3fe0
> [65731.260486] [T32454]  do_mem_abort+0x54c/0x1b34
> [65731.260509] [T32454]  el0_da+0x44/0x94
> [65731.260531] [T32454]  el0t_64_sync_handler+0x98/0xb4
> [65731.260553] [T32454]  el0t_64_sync+0x198/0x19c
>
> --
> 2.34.1

Thanks
Barry

