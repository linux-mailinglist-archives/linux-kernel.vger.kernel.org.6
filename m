Return-Path: <linux-kernel+bounces-374864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4129A7141
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 480B3B21737
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEBC1F1307;
	Mon, 21 Oct 2024 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ddLKMP67"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFF91D1F78
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532584; cv=none; b=B51GxvO+jrlfMcSccWH8hW5qxf0OAcMSCLklM8HNMlCP5a5oCnF4lRWcJ3d3nRvttu7Qvqn35tp1ZjCXdsZSL6UgRrF3gT5MC1K3Z910N+SRxDjfmfwefQsiDRikOA9bj8QF7w1cL7DUD7VDnw7i2AReYBYE6IhipQxjd2IeMR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532584; c=relaxed/simple;
	bh=8NoLI/VoQe9Sfjk04O8QAaaN2lgqv12kjOKbbzZ7+iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkhzwKsEtxvukl+cSce5UqQxKzO4l8xDjWuUQlEt+0bm7QS75AFs7wiOZmcAPiM1+viUU47QPApyDDRBXLBI4SjUPW1lVQfvVlaQ3n2+NAOv3TGR6ZCs3lSiBLzh0gBfScHzXCpBL9FOmRFGGaf1k8+zvlbiU0JDE2NnU6dW+k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ddLKMP67; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460b295b9eeso25161cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729532581; x=1730137381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DjVGnLTN9kUcdL8TccpaP5Id+H8u32nkEyO4u0gYkQ=;
        b=ddLKMP67MKlzvwnFoYf8aVHmS5ggLz75m5IMFlmgbQn3T8W+Sa1MD5G+eV5nLWFjQn
         oSxDfYe+6zTE2I861FexSgvU//fAkzKfMLFbgcXxVc77iZ2avtA8enXMqcxAqoqvX6M3
         bmKEFBHVpl7Me7AWLopz9pO/3z/ktoCjdDkwKbW8pFAVcX1294tOcAAUXdxRw8U6w4Ke
         vtv6NcWDV+pMboBHQIrZtun+dfY322wTZ1zbPxYd8i1Tg+EHZBxdK1dFiCwlp5NIZjKm
         UYnKZ/372yKv6henYqWsv1jvrChYc+thnLqwWg+I46TZl8K6i55zL7IbnN06GfPo08Wo
         I+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729532581; x=1730137381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DjVGnLTN9kUcdL8TccpaP5Id+H8u32nkEyO4u0gYkQ=;
        b=NjtcWz8ZjM4H0kZuFbNgsh4hoGLwe0NVYMf8sZaa7+zKslE2t47weuSGT74OOwVLb7
         orGu345oZLlxObbllSbdbIjmk/j+pPvV+lwF7j1NLNSIAg9jCVcIxUmDIFI1kEtmUH4x
         OxmvNOUuS1++lFV73AAg0eEtbpW1YXHZqsVaMhdljcWnR8PXR7F99lj6QRE9e488B/qy
         KNYOGrst9dZ1A2bmiHVAQOirbu2BGS0Tdr6ltWY+cTHFsKDHVk15+/AfviuMEUv1RZrU
         0TyUo/9zs8hIfO4pRI+8McSuslqoo1tNdYIrFgi/tEzZFHyPXw92gR/zhM2MTHPalUeS
         cvGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB67SJOZOhHRh57d48cCXEK0PmA+zRXsIklW/JFx6SeA4Kdtk4Pn0sevQD/GAF9DeyExdjG+YGexsuF/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzojqLUBMR+8iUleu/3MIxPzbAGuakYQb3/WKluMC/igxbZos2+
	kCyvAhWAG6oLYXF332NVtytbgWBPLp2mVq7zyWVF4rxjSxUYVNtvX45EhgXk5dICyyOFKGY+H/9
	0HJEvVT4Xb6Bprf+QB09qI0kpAPxbbPaFIZVU
X-Google-Smtp-Source: AGHT+IEkqBJK0hz4CfpISudeuR3akBK9MtupqQ0Zk8vNkbdxQ+Cfwyom+/AiKRL6qoO/74+7S5Qy+Fn93EfW+9Z2ffM=
X-Received: by 2002:ac8:5d86:0:b0:460:44db:eb4 with SMTP id
 d75a77b69052e-461007e824emr107331cf.0.1729532580803; Mon, 21 Oct 2024
 10:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_C1486E2FA393F0B97DD7D308336E262A3407@qq.com>
In-Reply-To: <tencent_C1486E2FA393F0B97DD7D308336E262A3407@qq.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 21 Oct 2024 10:42:48 -0700
Message-ID: <CAJuCfpEpxa=jPAZiu5OP=jwQw0awiYDv6x5sz6-BAmAK40iJ6w@mail.gmail.com>
Subject: Re: [PATCH] slub/slub_kunit:fix a panic due to __kmalloc_cache_noprof
 incorretly use
To: xiaopeitux@foxmail.com
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, yuzhao@google.com, xiaopei01@kylinos.cn, gehao@kylinso.cn, 
	xiongxin@kylinos.cn, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 11:59=E2=80=AFPM <xiaopeitux@foxmail.com> wrote:
>
> From: Pei Xiao <xiaopei01@kylinos.cn>
>
> 'modprobe slub_kunit',will have a panic.The root cause is that
> __kmalloc_cache_noprof was directly ,which resulted in no alloc_tag
> being allocated.This caused current->alloc_tag to be null,leading to
> a null pointer dereference in alloc_tag_ref_set.

I think the root cause of this crash is the bug that is fixed by
https://lore.kernel.org/all/20241020070819.307944-1-hao.ge@linux.dev/.
Do you get this crash if you apply that fix?

>
> Here is the log for the panic:
> [   74.779373][ T2158] Unable to handle kernel NULL pointer dereference a=
t virtual address 0000000000000020
> [   74.780130][ T2158] Mem abort info:
> [   74.780406][ T2158]   ESR =3D 0x0000000096000004
> [   74.780756][ T2158]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [   74.781225][ T2158]   SET =3D 0, FnV =3D 0
> [   74.781529][ T2158]   EA =3D 0, S1PTW =3D 0
> [   74.781836][ T2158]   FSC =3D 0x04: level 0 translation fault
> [   74.782288][ T2158] Data abort info:
> [   74.782577][ T2158]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x000000=
00
> [   74.783068][ T2158]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> [   74.783533][ T2158]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D=
 0
> [   74.784010][ T2158] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000=
105f34000
> [   74.784586][ T2158] [0000000000000020] pgd=3D0000000000000000, p4d=3D0=
000000000000000
> [   74.785293][ T2158] Internal error: Oops: 0000000096000004 [#1] SMP
> [   74.785805][ T2158] Modules linked in: slub_kunit kunit ip6t_rpfilter =
ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_n=
at ebtable_broute ip6table_nat ip6table_mangle 4
> [   74.790661][ T2158] CPU: 0 UID: 0 PID: 2158 Comm: kunit_try_catch Kdum=
p: loaded Tainted: G        W        N 6.12.0-rc3+ #2
> [   74.791535][ T2158] Tainted: [W]=3DWARN, [N]=3DTEST
> [   74.791889][ T2158] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.=
0 02/06/2015
> [   74.792479][ T2158] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -S=
SBS BTYPE=3D--)
> [   74.793101][ T2158] pc : alloc_tagging_slab_alloc_hook+0x120/0x270
> [   74.793607][ T2158] lr : alloc_tagging_slab_alloc_hook+0x120/0x270
>
> [   74.794095][ T2158] sp : ffff800084d33cd0
> [   74.794418][ T2158] x29: ffff800084d33cd0 x28: 0000000000000000 x27: 0=
000000000000000
> [   74.795095][ T2158] x26: 0000000000000000 x25: 0000000000000012 x24: f=
fff80007b30e314
> [   74.795822][ T2158] x23: ffff000390ff6f10 x22: 0000000000000000 x21: 0=
000000000000088
> [   74.796555][ T2158] x20: ffff000390285840 x19: fffffd7fc3ef7830 x18: f=
fffffffffffffff
> [   74.797283][ T2158] x17: ffff8000800e63b4 x16: ffff80007b33afc4 x15: f=
fff800081654c00
> [   74.798011][ T2158] x14: 0000000000000000 x13: 205d383531325420 x12: 5=
b5d383734363537
> [   74.798744][ T2158] x11: ffff800084d337e0 x10: 000000000000005d x9 : 0=
0000000ffffffd0
> [   74.799476][ T2158] x8 : 7f7f7f7f7f7f7f7f x7 : ffff80008219d188 x6 : c=
0000000ffff7fff
> [   74.800206][ T2158] x5 : ffff0003fdbc9208 x4 : ffff800081edd188 x3 : 0=
000000000000001
> [   74.800932][ T2158] x2 : 0beaa6dee1ac5a00 x1 : 0beaa6dee1ac5a00 x0 : f=
fff80037c2cb000
> [   74.801656][ T2158] Call trace:
> [   74.801954][ T2158]  alloc_tagging_slab_alloc_hook+0x120/0x270
> [   74.802494][ T2158]  __kmalloc_cache_noprof+0x148/0x33c
> [   74.802976][ T2158]  test_kmalloc_redzone_access+0x4c/0x104 [slub_kuni=
t]
> [   74.803607][ T2158]  kunit_try_run_case+0x70/0x17c [kunit]
> [   74.804124][ T2158]  kunit_generic_run_threadfn_adapter+0x2c/0x4c [kun=
it]
> [   74.804768][ T2158]  kthread+0x10c/0x118
> [   74.805141][ T2158]  ret_from_fork+0x10/0x20
> [   74.805540][ T2158] Code: b9400a80 11000400 b9000a80 97ffd858 (f94012d=
3)
> [   74.806176][ T2158] SMP: stopping secondary CPUs
> [   74.808130][ T2158] Starting crashdump kernel...
>

CC'ing Vlastimil.
This patch essentially reverts Vlastimil's "mm, slab: don't wrap
internal functions with alloc_hooks()" change. Please check why that
change was needed before proceeding.
If this change is indeed needed, please add:

Fixes: a0a44d9175b349 ("mm, slab: don't wrap internal functions with
alloc_hooks()")

> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  include/linux/slab.h | 1 +
>  lib/slub_kunit.c     | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 10a971c2bde3..0149d36cd311 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -827,6 +827,7 @@ void *__kmalloc_cache_noprof(struct kmem_cache *s, gf=
p_t flags, size_t size)
>  void *__kmalloc_cache_node_noprof(struct kmem_cache *s, gfp_t gfpflags,
>                                   int node, size_t size)
>                                 __assume_kmalloc_alignment __alloc_size(4=
);
> +#define kmalloc_cache(...)     alloc_hooks(__kmalloc_cache_noprof(__VA_A=
RGS__))
>
>  void *__kmalloc_large_noprof(size_t size, gfp_t flags)
>                                 __assume_page_alignment __alloc_size(1);
> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> index 80e39f003344..4bf38f52dbbd 100644
> --- a/lib/slub_kunit.c
> +++ b/lib/slub_kunit.c
> @@ -141,7 +141,7 @@ static void test_kmalloc_redzone_access(struct kunit =
*test)
>  {
>         struct kmem_cache *s =3D test_kmem_cache_create("TestSlub_RZ_kmal=
loc", 32,
>                                 SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZON=
E);
> -       u8 *p =3D __kmalloc_cache_noprof(s, GFP_KERNEL, 18);
> +       u8 *p =3D kmalloc_cache(s, GFP_KERNEL, 18);
>
>         kasan_disable_current();
>
> --
> 2.34.1
>

