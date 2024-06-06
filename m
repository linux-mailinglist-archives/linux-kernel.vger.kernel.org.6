Return-Path: <linux-kernel+bounces-203533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC06B8FDCBA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 04:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36391C21997
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2842618E29;
	Thu,  6 Jun 2024 02:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ6JPv3f"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7837A1B285
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 02:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717640899; cv=none; b=QpZG+f/sKYOV0cJfSGEtn/mqV4ATUjHQNthZvIf7TeFyskxX2ClN+uNHo8XKPO6COWPnlhIVu1pzBYdzpnmfZsQ+kEfkb5gH08WueoOXCT1PYGCvCS2W0onTWyS7x0aAb7Gt2ekvD+kaSb2VVDfSTCf/bAbhhcuwZ9q1csxiMAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717640899; c=relaxed/simple;
	bh=MQ6zr58kRmReZXOMjg8EaWksghH8iS+5N907X2sBLno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hj3yGyUJns9+f4hIR9Kpy5DftPXj7Cixo00hr+vZ2QvSN8tUnXPic/xLF6NEFMWZg8UKxDiR51SCOdrqctL5RMybP9wYQho9p+S8+cj4eLTyhjs3rJytLr5F8SNHkB+EPj3mT/sEd6X7r2q2uY45Xy/eKG9PBDtRSZeXQP4i3DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZ6JPv3f; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52b9dda4906so653885e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 19:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717640895; x=1718245695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHMh/PZ5hRlBQq//Nja97uI/czGva41PtV0OcxeHB5I=;
        b=IZ6JPv3f7ykxMPtcgkHmWJEhi3nICUukfQqS0Nh0sf8slnMvn1qE6EFqFefzHlt/xl
         xUckQ+Il5eXB3PFPlbzReGqftInNkxmH3ffRSPMpoCIPKEZPsMUWHNGTJTM/MVEGiFax
         i62wEAhNM5NnQmzUzdpP+TgubQHPYoKJf4VbH+wF/oAN6jWjkxGJTDfz1Nxv7kLQZzrS
         jnsX6ivZ1JoeGUxGRc+A8X7/+M3WMwKaKWpDbOdjGvMFoa6Q+K9q4JYWK+MF1op5Fnzt
         d69goAwQ964Uu5u4B8QbxHoX689L8+bLIJA/axKsaahTxqhI2L7FWQsEhvMCx8m1nIbs
         jtvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717640895; x=1718245695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHMh/PZ5hRlBQq//Nja97uI/czGva41PtV0OcxeHB5I=;
        b=rKcNZz9NU9uzyleeoliofuFGh/zdL0NlnWZsPFWIFTOcuI9koSksI+OUHhlcP/oU/T
         MFYXFI0WXInr3sASkxpn0cZY/8Qvfo3JkKGlEU9DAWbNGcuZcZe9kSf8mbWlsf8WzFHW
         8NMRh9pcqAmsizPJ0NeRzWIKrtzV/qwPFqq7QMTjMhmpFMjLkQ+4d3rurG/954UBMH+T
         YiyPAEozMMORmFTPWBMa/LL7rM1Ye68h9C4wxV1GdE7xcORB+62TkV3mmHbNOvuGkXT7
         5YMPARaC97IZDPT5pUWES0Szx4qEoNV8yqXhkZchMVSh1WxbXwLcHssraFTRjpBYRDpF
         RSgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWf967f/fBP626sQHQoIojuhe7dP9yQGnqkgme0lZn6tWGCk8sw7UcR/FrIIUY9EwQC6I4otpunJyi1V6V/J1QjKIlpntrnOkQvYFg
X-Gm-Message-State: AOJu0YzS6x7pcFNZQCCn88/6kTa6zT+XhuaQgWyJknHT/HJ6wHvstME3
	Pkh9w5AP4cInQdhanq+rtJb1TnaqtzmTDhMVCDkaB5xVCf9ys1OsI49uz5JydFhFAl+r4cH8+0N
	nnHN0L4POztoyg0wXfgJmapPqYWc=
X-Google-Smtp-Source: AGHT+IFiNiF6n0TTdIzUtQYTp1Y4mPTYhbra86Wu7SO1hrfpM3738KffG5vCrSHmT7IK1z17wS3Ot1njFKQJTLRWJM4=
X-Received: by 2002:a19:e053:0:b0:52b:8411:20e5 with SMTP id
 2adb3069b0e04-52bab4dd189mr2947152e87.15.1717640895226; Wed, 05 Jun 2024
 19:28:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604022232.1669983-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20240604022232.1669983-1-zhaoyang.huang@unisoc.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 6 Jun 2024 10:28:04 +0800
Message-ID: <CAGWkznHt3p=+bW=+CKCDdXEjqDkUqj89AO1F=zje-A_cDkx2NA@mail.gmail.com>
Subject: Re: [PATCHv4 1/1] mm: fix incorrect vbq reference in purge_fragmented_block
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, hailong liu <hailong.liu@oppo.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch is urgent for the Android world which uses v6.6 now. Is
there any comments on this? Thanks!

On Tue, Jun 4, 2024 at 10:23=E2=80=AFAM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> vmalloc area runs out in our ARM64 system during an erofs test as
> vm_map_ram failed[1]. By following the debug log, we find that
> vm_map_ram()->vb_alloc() will allocate new vb->va which corresponding
> to 4MB vmalloc area as list_for_each_entry_rcu returns immediately
> when vbq->free->next points to vbq->free. That is to say, 65536 times
> of page fault after the list's broken will run out of the whole
> vmalloc area. This should be introduced by one vbq->free->next point to
> vbq->free which makes list_for_each_entry_rcu can not iterate the list
> and find the BUG.
>
> [1]
> PID: 1        TASK: ffffff80802b4e00  CPU: 6    COMMAND: "init"
>  #0 [ffffffc08006afe0] __switch_to at ffffffc08111d5cc
>  #1 [ffffffc08006b040] __schedule at ffffffc08111dde0
>  #2 [ffffffc08006b0a0] schedule at ffffffc08111e294
>  #3 [ffffffc08006b0d0] schedule_preempt_disabled at ffffffc08111e3f0
>  #4 [ffffffc08006b140] __mutex_lock at ffffffc08112068c
>  #5 [ffffffc08006b180] __mutex_lock_slowpath at ffffffc08111f8f8
>  #6 [ffffffc08006b1a0] mutex_lock at ffffffc08111f834
>  #7 [ffffffc08006b1d0] reclaim_and_purge_vmap_areas at ffffffc0803ebc3c
>  #8 [ffffffc08006b290] alloc_vmap_area at ffffffc0803e83fc
>  #9 [ffffffc08006b300] vm_map_ram at ffffffc0803e78c0
>
> Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized bl=
ocks")
>
> For detailed reason of broken list, please refer to below URL
> https://lore.kernel.org/all/20240531024820.5507-1-hailong.liu@oppo.com/
>
> Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> v2: introduce cpu in vmap_block to record the right CPU number
> v3: use get_cpu/put_cpu to prevent schedule between core
> v4: replace get_cpu/put_cpu by another API to avoid disabling preemption
> ---
> ---
>  mm/vmalloc.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 22aa63f4ef63..89eb034f4ac6 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2458,6 +2458,7 @@ struct vmap_block {
>         struct list_head free_list;
>         struct rcu_head rcu_head;
>         struct list_head purge;
> +       unsigned int cpu;
>  };
>
>  /* Queue of free and dirty vmap blocks, for allocation and flushing purp=
oses */
> @@ -2585,8 +2586,15 @@ static void *new_vmap_block(unsigned int order, gf=
p_t gfp_mask)
>                 free_vmap_area(va);
>                 return ERR_PTR(err);
>         }
> -
> -       vbq =3D raw_cpu_ptr(&vmap_block_queue);
> +       /*
> +        * list_add_tail_rcu could happened in another core
> +        * rather than vb->cpu due to task migration, which
> +        * is safe as list_add_tail_rcu will ensure the list's
> +        * integrity together with list_for_each_rcu from read
> +        * side.
> +        */
> +       vb->cpu =3D raw_smp_processor_id();
> +       vbq =3D per_cpu_ptr(&vmap_block_queue, vb->cpu);
>         spin_lock(&vbq->lock);
>         list_add_tail_rcu(&vb->free_list, &vbq->free);
>         spin_unlock(&vbq->lock);
> @@ -2614,9 +2622,10 @@ static void free_vmap_block(struct vmap_block *vb)
>  }
>
>  static bool purge_fragmented_block(struct vmap_block *vb,
> -               struct vmap_block_queue *vbq, struct list_head *purge_lis=
t,
> -               bool force_purge)
> +               struct list_head *purge_list, bool force_purge)
>  {
> +       struct vmap_block_queue *vbq =3D &per_cpu(vmap_block_queue, vb->c=
pu);
> +
>         if (vb->free + vb->dirty !=3D VMAP_BBMAP_BITS ||
>             vb->dirty =3D=3D VMAP_BBMAP_BITS)
>                 return false;
> @@ -2664,7 +2673,7 @@ static void purge_fragmented_blocks(int cpu)
>                         continue;
>
>                 spin_lock(&vb->lock);
> -               purge_fragmented_block(vb, vbq, &purge, true);
> +               purge_fragmented_block(vb, &purge, true);
>                 spin_unlock(&vb->lock);
>         }
>         rcu_read_unlock();
> @@ -2801,7 +2810,7 @@ static void _vm_unmap_aliases(unsigned long start, =
unsigned long end, int flush)
>                          * not purgeable, check whether there is dirty
>                          * space to be flushed.
>                          */
> -                       if (!purge_fragmented_block(vb, vbq, &purge_list,=
 false) &&
> +                       if (!purge_fragmented_block(vb, &purge_list, fals=
e) &&
>                             vb->dirty_max && vb->dirty !=3D VMAP_BBMAP_BI=
TS) {
>                                 unsigned long va_start =3D vb->va->va_sta=
rt;
>                                 unsigned long s, e;
> --
> 2.25.1
>

