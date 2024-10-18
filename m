Return-Path: <linux-kernel+bounces-371587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAB19A3CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B91B21D89
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD1620101C;
	Fri, 18 Oct 2024 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z931uTz3"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABE320E30A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249969; cv=none; b=tz1m0jU1YYAfGLvguNxh71PIq5lcX2sxTkT9uMCtEFWa0FU7rRE4bwWp4v4DaMVe5K/UWxREXp9/hbJ171KjJVm2YAxIOoRlPQP82NEpwUKVl5pscIKn8qmqKzoJcro0u5vyNjf6owJaq3oqZqU8PLCq5GD/eXchPDv1vLcdoQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249969; c=relaxed/simple;
	bh=ujez7prqVlpncp0z5lp/uS/b24SU6eiomOhFlAEvD8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPtpUpBK0wUI0W+9Xp2+P1LKFqxRJ7y9+3R0xpD9GKiF9C/coBbx4afzHI8m2ufQEexTRn7Q4msb47n9NcvWhxd1rY13rq0bc7UBzuTwBUhKz35X4NxZmmetqW466n8CxdIorqdPVE2Ht8pTfQU+cuzhE3BZnA/kLibPU/OW2lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z931uTz3; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539fb49c64aso2889307e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 04:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729249965; x=1729854765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wMrIqcIO3asGG/JG/6XWJDUY49KVWLwXoH76P6xDGg=;
        b=Z931uTz3NUsXY5Z38JhIXE5Y+S5IZOjBQFOOrQ8tpsdckhgwgptO1oQHz3mxHdmhdd
         1PU2LWu8/qU+BzxBNFHvIHf8dXIKt/xJdAUrJCm6cwixzsS6bT1DYlNhPscp+mFVPw5H
         KlPFtXJW1MbZKRsSByBFdw8TcqtOkTtFcoVADnOprE0D5J6OIi0P0BVqt2Z9cAxpFRRC
         iWcg1Ku3pZj7bLuDZaNZnunA4drvhfizl0y+S7fdLwB8eW1AJqYuREXpdfEkWwYvTITv
         KS7qJmiXFSOt+3yxtYcnutR1OqIm83rfkssOhIy/HBl22L0fD/FEzpP2giobhX5OAG/v
         Gbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729249965; x=1729854765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wMrIqcIO3asGG/JG/6XWJDUY49KVWLwXoH76P6xDGg=;
        b=vTLnb8Et2cWyEoqEnyBfgKYUVzLABfZc8QEJnEMm1asUi1Ju+DC0X8YlhZ9+eR82zC
         uz+QHfewAY5gaWfV948/e88C0RZRtsQqj4SHmIZmM4unST5k0AwVsDtUE9ef+26FozSD
         rqWWlynscy+5Ts1xs9r6DLI9qxSTWnaKehjpsQD8JLUiXzF/DZVCstdqz+qf7PlY9lSl
         Lc5VLMntd5ZMC6permF8of0gBS2IYA8EXronndy7Fas4R9N6z22ajJ0v1pSZpZVi/Odp
         NIzG1xxBlF2kW/MOy8+wWlWmR9SLiufra7yHovlEzpazTTLhW0l0CT64p1bdEnPUOpKU
         6rDg==
X-Forwarded-Encrypted: i=1; AJvYcCXuHK/NuHFz52T9eBoYvueux16qfaNmjnWrmecfuUWOCGY4FVgpuSxW44SRFBKJBfz4lyyLEnZ8ScXue00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs8bJOgsRlZpEjV+Qd275T6k8hf0WNqX+wLifJCz5vZ3sFGiCk
	MfAvsOzW0lPB80UO5upt/h1AJpSViH9ySd/J0jtKHOrTjtG+JLJ8SpjMRSaMs+Via3xdHEx0AUy
	xaIOXR2IcW6C/2hW+q4U2wIzXmj0=
X-Google-Smtp-Source: AGHT+IEwVMfCsuv4hFswLze6aFcyRvFehCYXreVL2ktl0KrjZ57F9JgaqyUTm8NtBn6zrPpbg6gCwaK5leTxaufNQP8=
X-Received: by 2002:a05:6512:3a82:b0:53a:7e:bcc5 with SMTP id
 2adb3069b0e04-53a1533f6f9mr2082549e87.9.1729249964912; Fri, 18 Oct 2024
 04:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018064435.7695-1-yuan.gao@ucloud.cn>
In-Reply-To: <20241018064435.7695-1-yuan.gao@ucloud.cn>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Fri, 18 Oct 2024 20:12:32 +0900
Message-ID: <CAB=+i9TjnJrTjaFCZw7Gpp3-JiS5k1PjnfQfNV21QKLhVxni_Q@mail.gmail.com>
Subject: Re: [PATCH v4] mm/slub: Avoid list corruption when removing a slab
 from the full list
To: "yuan.gao" <yuan.gao@ucloud.cn>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com, 
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz, 
	roman.gushchin@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:45=E2=80=AFPM yuan.gao <yuan.gao@ucloud.cn> wrote=
:
>
> Boot with slub_debug=3DUFPZ.
>
> If allocated object failed in alloc_consistency_checks, all objects of
> the slab will be marked as used, and then the slab will be removed from
> the partial list.
>
> When an object belonging to the slab got freed later, the remove_full()
> function is called. Because the slab is neither on the partial list nor
> on the full list, it eventually lead to a list corruption (actually a
> list poison being detected).
>
> So we need to mark and isolate the slab page with metadata corruption,
> do not put it back in circulation.
>
> Because the debug caches avoid all the fastpaths, reusing the frozen bit
> to mark slab page with metadata corruption seems to be fine.

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> [ 4277.385669] list_del corruption, ffffea00044b3e50->next is LIST_POISON=
1 (dead000000000100)
> [ 4277.387023] ------------[ cut here ]------------
> [ 4277.387880] kernel BUG at lib/list_debug.c:56!
> [ 4277.388680] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [ 4277.389562] CPU: 5 PID: 90 Comm: kworker/5:1 Kdump: loaded Tainted: G =
          OE      6.6.1-1 #1
> [ 4277.392113] Workqueue: xfs-inodegc/vda1 xfs_inodegc_worker [xfs]
> [ 4277.393551] RIP: 0010:__list_del_entry_valid_or_report+0x7b/0xc0
> [ 4277.394518] Code: 48 91 82 e8 37 f9 9a ff 0f 0b 48 89 fe 48 c7 c7 28 4=
9 91 82 e8 26 f9 9a ff 0f 0b 48 89 fe 48 c7 c7 58 49 91
> [ 4277.397292] RSP: 0018:ffffc90000333b38 EFLAGS: 00010082
> [ 4277.398202] RAX: 000000000000004e RBX: ffffea00044b3e50 RCX: 000000000=
0000000
> [ 4277.399340] RDX: 0000000000000002 RSI: ffffffff828f8715 RDI: 00000000f=
fffffff
> [ 4277.400545] RBP: ffffea00044b3e40 R08: 0000000000000000 R09: ffffc9000=
03339f0
> [ 4277.401710] R10: 0000000000000003 R11: ffffffff82d44088 R12: ffff88811=
2cf9910
> [ 4277.402887] R13: 0000000000000001 R14: 0000000000000001 R15: ffff88810=
00424c0
> [ 4277.404049] FS:  0000000000000000(0000) GS:ffff88842fd40000(0000) knlG=
S:0000000000000000
> [ 4277.405357] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4277.406389] CR2: 00007f2ad0b24000 CR3: 0000000102a3a006 CR4: 000000000=
07706e0
> [ 4277.407589] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [ 4277.408780] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [ 4277.410000] PKRU: 55555554
> [ 4277.410645] Call Trace:
> [ 4277.411234]  <TASK>
> [ 4277.411777]  ? die+0x32/0x80
> [ 4277.412439]  ? do_trap+0xd6/0x100
> [ 4277.413150]  ? __list_del_entry_valid_or_report+0x7b/0xc0
> [ 4277.414158]  ? do_error_trap+0x6a/0x90
> [ 4277.414948]  ? __list_del_entry_valid_or_report+0x7b/0xc0
> [ 4277.415915]  ? exc_invalid_op+0x4c/0x60
> [ 4277.416710]  ? __list_del_entry_valid_or_report+0x7b/0xc0
> [ 4277.417675]  ? asm_exc_invalid_op+0x16/0x20
> [ 4277.418482]  ? __list_del_entry_valid_or_report+0x7b/0xc0
> [ 4277.419466]  ? __list_del_entry_valid_or_report+0x7b/0xc0
> [ 4277.420410]  free_to_partial_list+0x515/0x5e0
> [ 4277.421242]  ? xfs_iext_remove+0x41a/0xa10 [xfs]
> [ 4277.422298]  xfs_iext_remove+0x41a/0xa10 [xfs]
> [ 4277.423316]  ? xfs_inodegc_worker+0xb4/0x1a0 [xfs]
> [ 4277.424383]  xfs_bmap_del_extent_delay+0x4fe/0x7d0 [xfs]
> [ 4277.425490]  __xfs_bunmapi+0x50d/0x840 [xfs]
> [ 4277.426445]  xfs_itruncate_extents_flags+0x13a/0x490 [xfs]
> [ 4277.427553]  xfs_inactive_truncate+0xa3/0x120 [xfs]
> [ 4277.428567]  xfs_inactive+0x22d/0x290 [xfs]
> [ 4277.429500]  xfs_inodegc_worker+0xb4/0x1a0 [xfs]
> [ 4277.430479]  process_one_work+0x171/0x340
> [ 4277.431227]  worker_thread+0x277/0x390
> [ 4277.431962]  ? __pfx_worker_thread+0x10/0x10
> [ 4277.432752]  kthread+0xf0/0x120
> [ 4277.433382]  ? __pfx_kthread+0x10/0x10
> [ 4277.434134]  ret_from_fork+0x2d/0x50
> [ 4277.434837]  ? __pfx_kthread+0x10/0x10
> [ 4277.435566]  ret_from_fork_asm+0x1b/0x30
> [ 4277.436280]  </TASK>
>
> v4:
>  - Rephrase wording.
>  - Remove a useless add_full().
>
> v3:
>  - Reuse slab->fronzen bit as a corrupted marker.
>  - https://lore.kernel.org/all/20241011102020.58087-1-yuan.gao@ucloud.cn/
>
> v2:
>  - Call remove_partial() and add_full() only for slab folios.
>  - https://lore.kernel.org/linux-mm/20241007091850.16959-1-yuan.gao@uclou=
d.cn/
>
> v1:
>  - https://lore.kernel.org/linux-mm/20241006044755.79634-1-yuan.gao@uclou=
d.cn/
>
> Signed-off-by: yuan.gao <yuan.gao@ucloud.cn>
> Fixes: 643b113849d8 ("slub: enable tracking of full slabs")
> Suggested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab.h | 5 +++++
>  mm/slub.c | 9 ++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/mm/slab.h b/mm/slab.h
> index 6c6fe6d630ce..8d7caf50ef96 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -73,6 +73,11 @@ struct slab {
>                                                 struct {
>                                                         unsigned inuse:16=
;
>                                                         unsigned objects:=
15;
> +                                                       /*
> +                                                        * If slab debugg=
ing is enabled then the
> +                                                        *      frozen bi=
t can be reused to indicate
> +                                                        *      that the =
slab was corrupted
> +                                                        */
>                                                         unsigned frozen:1=
;
>                                                 };
>                                         };
> diff --git a/mm/slub.c b/mm/slub.c
> index 5b832512044e..15ba89fef89a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1423,6 +1423,11 @@ static int check_slab(struct kmem_cache *s, struct=
 slab *slab)
>                         slab->inuse, slab->objects);
>                 return 0;
>         }
> +       if (slab->frozen) {
> +               slab_err(s, slab, "Slab disabled since SLUB metadata cons=
istency check failed");
> +               return 0;
> +       }
> +
>         /* Slab_pad_check fixes things up after itself */
>         slab_pad_check(s, slab);
>         return 1;
> @@ -1603,6 +1608,7 @@ static noinline bool alloc_debug_processing(struct =
kmem_cache *s,
>                 slab_fix(s, "Marking all objects used");
>                 slab->inuse =3D slab->objects;
>                 slab->freelist =3D NULL;
> +               slab->frozen =3D 1; /* mark consistency-failed slab as fr=
ozen */
>         }
>         return false;
>  }
> @@ -2744,7 +2750,8 @@ static void *alloc_single_from_partial(struct kmem_=
cache *s,
>         slab->inuse++;
>
>         if (!alloc_debug_processing(s, slab, object, orig_size)) {
> -               remove_partial(n, slab);
> +               if (folio_test_slab(slab_folio(slab)))
> +                       remove_partial(n, slab);
>                 return NULL;
>         }
>
> --
> 2.32.0
>

