Return-Path: <linux-kernel+bounces-177763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CE98C4455
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A352829AE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FBF15359D;
	Mon, 13 May 2024 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KczBTHyP"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE6F57CA2
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614491; cv=none; b=RwRpXPY6ejFoOQIDuyK/sdnqx1Bb/RDe5eqvwES386bmdU0MtRsWZUoXusQsSSAfIURyB7VOgb61X/ulwAbCIqPPWu78jBK3HvZ0nuhpUn09OwZaIAUdRuXKM0ySRrayLonobktQtrVb29GMHVF0HXJNjuVfPhAqB1ZGlQCjgJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614491; c=relaxed/simple;
	bh=GhJG+RgS/vp7GCGYTRQD+PlAMONhhgNJGHJTy2Qy1O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLkKY/g4NIHJtrLUKRVsW/1k1J30AIYWyiwKdsu4gTRIZwf+J64a1PH/KpRk0siebctCXuXmPjODIBi4I4A94dUDkSvzI40xjiXb2MBmKrrzwyULVNzaCVZjc/4m+8ZOYr65lL4U+GGaxVAg1EfSgUF0jV2VnWfWZFbl1Qe7yjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KczBTHyP; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a5a5cb0e6b7so363848466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715614488; x=1716219288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4C3Hrs0stE+kgVQ5iHNylL/VPsSbKxrz7oL6n9VAFU=;
        b=KczBTHyPj1VAkotUa5UvVEnkBmL1ws0eIgWoIxVrz9OgsXtbePtCemQ8VUKhpt9BXN
         GM6fpnM9oINShB6jcmss7MkD910nXQaiKob7WrFBEYEOx5CoYUMeT+DTGdW7yUUO4afQ
         MXAUW+j6kofFb73Kp69C27gpj2Zr6++ImgERU9G21SEUt6b3+yM9osv3n8N9ZzCyC2uy
         oCFwukx9Ym7xrGUs9sxCazghvpngMbRcb389UEj2Eu0lEe+vUnBK2nP8303xWsWzvnTG
         cCbUgsTtJC+KkehAnZVOjJuHnk5q86VdaeRu5ADhd5QMBDPPWI3+1Q6nDePdClbfxEks
         U5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715614488; x=1716219288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4C3Hrs0stE+kgVQ5iHNylL/VPsSbKxrz7oL6n9VAFU=;
        b=NTknosjlW7haP7cKwwXXt6BDJakEdTztv4qHPmEYdV7lEvHJh/XHf0OqynSDqmAXEv
         s0ou+mbPVlyQfZvYfA5zz7ae6TyisXpVnRxvtxdtXGjZoud+Qls58zf9f79TCi4GPqup
         Hn35VfH5Kjw99ZlAAHvG9aDv2xDzPxuEt38m/F3yk70aH9qi36+5GMxLcf0EWx9E3w2/
         I2fSO0hzvRdO5JcCLmDdVQ1iaMXunmgKjThH94P1MFKWqd0TpbfkFUXxUK+jqaowRYCy
         Ul1owSR6YFYQtnBAcgyFBlODQvydQ6QvHJTWrMfacNrdcwrSdgK4r8POCIcYnW46F3yr
         EoRg==
X-Forwarded-Encrypted: i=1; AJvYcCWYrKLGRCzkzlM8KILPscE4QJGscLj6ocu0nU1S6+leUc3klaAq08pEXjwGsWKTomfN7O9UULBH50Kw+z6veVlRltuM05ujgmxQwQVI
X-Gm-Message-State: AOJu0YwZ1daTDRy9mxUhf7sjFND5f7BbO8plsDh0V6GD3CUzcVIXTYoT
	xio7v3/jUUq7CHPZ3NvMMGSJr2yhHRjU+5MBedUxDVVjwRhMs9JclP1orXOPcz+EchuM+Xl6jIH
	IiKjiBwXxfqKXR0YrtK7d+yG0B9E=
X-Google-Smtp-Source: AGHT+IGtm7VkrG7t4KXaJAmNoNAbFLWP8iIFvNAwQeurVIPpTHwQl2ttcvr+yUiI178qOhc1sGOFXSlQmxP7LvLXoiU=
X-Received: by 2002:aa7:d458:0:b0:573:5c38:fec5 with SMTP id
 4fb4d7f45d1cf-5735c38ff12mr4740651a12.16.1715614488314; Mon, 13 May 2024
 08:34:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511032801.1295023-1-linmiaohe@huawei.com>
In-Reply-To: <20240511032801.1295023-1-linmiaohe@huawei.com>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 13 May 2024 09:34:36 -0600
Message-ID: <CAHbLzkrXRYMj3S+h+zUrrezYrgQYWELcHKmz-VZ=9g0K-o=iPg@mail.gmail.com>
Subject: Re: [PATCH] mm/huge_memory: mark huge_zero_folio reserved
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: akpm@linux-foundation.org, nao.horiguchi@gmail.com, xuyu@linux.alibaba.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 9:31=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.com> w=
rote:
>
> When I did memory failure tests recently, below panic occurs:
>
>  kernel BUG at include/linux/mm.h:1135!
>  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 9 PID: 137 Comm: kswapd1 Not tainted 6.9.0-rc4-00491-gd5ce28f156fe-=
dirty #14
>  RIP: 0010:shrink_huge_zero_page_scan+0x168/0x1a0
>  RSP: 0018:ffff9933c6c57bd0 EFLAGS: 00000246
>  RAX: 000000000000003e RBX: 0000000000000000 RCX: ffff88f61fc5c9c8
>  RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff88f61fc5c9c0
>  RBP: ffffcd7c446b0000 R08: ffffffff9a9405f0 R09: 0000000000005492
>  R10: 00000000000030ea R11: ffffffff9a9405f0 R12: 0000000000000000
>  R13: 0000000000000000 R14: 0000000000000000 R15: ffff88e703c4ac00
>  FS:  0000000000000000(0000) GS:ffff88f61fc40000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000055f4da6e9878 CR3: 0000000c71048000 CR4: 00000000000006f0
>  Call Trace:
>   <TASK>
>   do_shrink_slab+0x14f/0x6a0
>   shrink_slab+0xca/0x8c0
>   shrink_node+0x2d0/0x7d0
>   balance_pgdat+0x33a/0x720
>   kswapd+0x1f3/0x410
>   kthread+0xd5/0x100
>   ret_from_fork+0x2f/0x50
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  Modules linked in: mce_inject hwpoison_inject
>  ---[ end trace 0000000000000000 ]---
>  RIP: 0010:shrink_huge_zero_page_scan+0x168/0x1a0
>  RSP: 0018:ffff9933c6c57bd0 EFLAGS: 00000246
>  RAX: 000000000000003e RBX: 0000000000000000 RCX: ffff88f61fc5c9c8
>  RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff88f61fc5c9c0
>  RBP: ffffcd7c446b0000 R08: ffffffff9a9405f0 R09: 0000000000005492
>  R10: 00000000000030ea R11: ffffffff9a9405f0 R12: 0000000000000000
>  R13: 0000000000000000 R14: 0000000000000000 R15: ffff88e703c4ac00
>  FS:  0000000000000000(0000) GS:ffff88f61fc40000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000055f4da6e9878 CR3: 0000000c71048000 CR4: 00000000000006f0
>
> The root cause is that HWPoison flag will be set for huge_zero_folio
> without increasing the folio refcnt. But then unpoison_memory() will
> decrease the folio refcnt unexpectly as it appears like a successfully
> hwpoisoned folio leading to VM_BUG_ON_PAGE(page_ref_count(page) =3D=3D 0)
> when releasing huge_zero_folio.
>
> Fix this issue by marking huge_zero_folio reserved. So unpoison_memory()
> will skip this page. This will make it consistent with ZERO_PAGE case too=
.

If I read the code correctly, unpoison_memory() should not dec
refcount for huge zero page by calling put_page_testzero(). The huge
zero page's real refcount is actually maintained separately by
huge_zero_refcount. It is different from the regular refount in struct
folio, see get_huge_zero_page().

>
> Fixes: 478d134e9506 ("mm/huge_memory: do not overkill when splitting huge=
_zero_page")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/huge_memory.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 317de2afd371..d508ff793145 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -212,6 +212,7 @@ static bool get_huge_zero_page(void)
>                 folio_put(zero_folio);
>                 goto retry;
>         }
> +       __folio_set_reserved(zero_folio);
>         WRITE_ONCE(huge_zero_pfn, folio_pfn(zero_folio));
>
>         /* We take additional reference here. It will be put back by shri=
nker */
> @@ -264,6 +265,7 @@ static unsigned long shrink_huge_zero_page_scan(struc=
t shrinker *shrink,
>                 struct folio *zero_folio =3D xchg(&huge_zero_folio, NULL)=
;
>                 BUG_ON(zero_folio =3D=3D NULL);
>                 WRITE_ONCE(huge_zero_pfn, ~0UL);
> +               __folio_clear_reserved(zero_folio);
>                 folio_put(zero_folio);
>                 return HPAGE_PMD_NR;
>         }
> --
> 2.33.0
>

