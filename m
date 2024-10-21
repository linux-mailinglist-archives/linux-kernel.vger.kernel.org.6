Return-Path: <linux-kernel+bounces-374922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5D69A7206
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D0E0B22106
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FCE1F8936;
	Mon, 21 Oct 2024 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SN4jxCOu"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B081F8EEC
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729534296; cv=none; b=UrFMAr+w2oDf5nfBy80CanFGVPoLEgeYAowGlsioTUa7zJZedqlbAB7pIwEv6HWNfCQdDDQAj690aUlkISLX1rQsV0KQGNbKCOkjWGLDTG4L6K2FaRsaLksJOTLzc5vOhgC7be5YXZb8xciS1hyYPrSrKn1qXxKZXmOymlA+wVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729534296; c=relaxed/simple;
	bh=atlq6EJZlTUamqKbARjC1T81tVfECLt13AYd3t0SsMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aw2YX0iAXMX3Hq7XEOcL7ym3fCb2z1MAijFOPOLkTBGU45XSh5Dww9eOtkgWhdU25Oay11a6t7hJIi8FZwPVo5uR2LU4FidSSkIVRx8WQBwuoPGL8vXOzyito7qORbCGS4qTjHLp0bg34QucEH3GPmEVgfjZCNYl/DSRESlOy80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SN4jxCOu; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460b295b9eeso34531cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729534293; x=1730139093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tACD3NSgh6R2mLkJ9fgIotgfH/ICSRfUl2Vu0RXEPVY=;
        b=SN4jxCOuryusJLiJccJobcoYtr0UjCwir023QgqZmD3ouTQ9yLGLfC6RWlOrDn1uay
         X+zVj9QL4XufhgHnZ4ksw8aOEn7eV4mqNj4Xkz9B8mFrRES+GCPKPm+USaSUQJcOCCRu
         pJ8NRFh4AUBJrsiKeqpn8oONSIaTh+JG3aoaQDKdGPfKcXc5SUF0IGQLke8fm1ZLQ2/Z
         HXgk72rX0O+DfczUiUIehQC3xgiErGBc9rk43655PpkYIZvXp6pekiXlZGzDTm1y89LJ
         t9NgeYDyG9IynXdICYt207//tnPbRklkPRFcpZ2SHO3mDLkm7RHDu0sxcfYsLz3H2k43
         Nd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729534293; x=1730139093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tACD3NSgh6R2mLkJ9fgIotgfH/ICSRfUl2Vu0RXEPVY=;
        b=eolvopDmjHIs5+ioAAo6pjTn6pRVzl4PD827dJXOabK05m6cIM2Wg9dmdIKl2Avex6
         U5Dvwmgj+/v4KMerJ8OMxK92z2YJzVvHR3DjBDijQmzPndKb6XiHVttoDYWnMsS7fHE8
         l2RS4D3GA6ry9/r5aEZ56wKlWnbYWtRpcyc47CFmeJiTBG0V1grZKNttyOcF915EY0ft
         6cjvYKW1LyRFpZ9JTxA50Xrks1nZPmx9ORWdP4zs8AgN/0T7Fr/9itXjgevCEalgBFJs
         1nkP1LnLu5EFZT0HLC4OxZYARG3//p5XBcf0B/x8z3lVb6fCNDNeI+SGAwDWuc+JH1bD
         iUlA==
X-Forwarded-Encrypted: i=1; AJvYcCWDPLdFQiZ3caTryOutFJ6MnksVortVVm6ShdVptPnRsSQ/wkoYMKKDlC1CSgB4eIyizXaKga3lN5hABhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ4RqKyllU+oKn0+qvCjt1BSrflUOIwDRWO1lGcBKdX4hhHH++
	7Kq6J4RnImD263gMe4NAh2gh8U7bDAy3o/pxhAslgpfHmtphdxCgBZQQ76pRiHFNI54zl0fCrGE
	+Lb+9XqifbHi8yHuV+p4MXmTlRrB2e8soA3X3
X-Google-Smtp-Source: AGHT+IEfWbnrmLFPebc7Ouv8rsMrkdYVp1pe6j4E8W2sTnCtOgvI2cH9sY2EqFnKQ5croRjNX0091ajDcewV8l6XIjE=
X-Received: by 2002:ac8:7ee5:0:b0:460:bb96:dd65 with SMTP id
 d75a77b69052e-46100e6375dmr120271cf.19.1729534292505; Mon, 21 Oct 2024
 11:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018152925.138341-1-hao.ge@linux.dev> <20241020070819.307944-1-hao.ge@linux.dev>
In-Reply-To: <20241020070819.307944-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 21 Oct 2024 11:11:21 -0700
Message-ID: <CAJuCfpGhWgmq929X2AWxHGMgRntH4PttmyMOragg=LzxLs220A@mail.gmail.com>
Subject: Re: [PATCH v3] mm/codetag: fix null pointer check logic for ref and tag
To: Hao Ge <hao.ge@linux.dev>
Cc: kent.overstreet@linux.dev, akpm@linux-foundation.org, yuzhao@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 12:08=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> From: Hao Ge <gehao@kylinos.cn>
>
> When we compile and load lib/slub_kunit.c,it will cause a panic.
>
> The root cause is that __kmalloc_cache_noprof was directly called
> instead of kmem_cache_alloc,which resulted in no alloc_tag being
> allocated.This caused current->alloc_tag to be null,leading to a
> null pointer dereference in alloc_tag_ref_set.
>
> Despite the fact that my colleague Pei Xiao will later fix the code
> in slub_kunit.c,we still need fix null pointer check logic for ref
> and tag to avoid panic caused by a null pointer dereference.
>
> Here is the log for the panic:
>
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
> Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Yu Zhao <yuzhao@google.com>
> Signed-off-by: Hao Ge <gehao@kylinos.cn>

Thanks for the fix!

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
> v3: Modify the code logic based on Suren's suggestions.
>     Update title and commit message due to code logic change.
>     Add Suggested-by: Suren Baghdasaryan <surenb@google.com>
>     Add Acked-by: Yu Zhao <yuzhao@google.com>
>
> v2: Modify the errors in the title and commit message.
>     Remove the empty lines that were mistakenly added in version v1.
> ---
>  include/linux/alloc_tag.h | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index 1f0a9ff23a2c..941deffc590d 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -135,18 +135,21 @@ static inline void alloc_tag_sub_check(union codeta=
g_ref *ref) {}
>  #endif
>
>  /* Caller should verify both ref and tag to be valid */
> -static inline void __alloc_tag_ref_set(union codetag_ref *ref, struct al=
loc_tag *tag)
> +static inline bool __alloc_tag_ref_set(union codetag_ref *ref, struct al=
loc_tag *tag)
>  {
>         alloc_tag_add_check(ref, tag);
>         if (!ref || !tag)
> -               return;
> +               return false;
>
>         ref->ct =3D &tag->ct;
> +       return true;
>  }
>
> -static inline void alloc_tag_ref_set(union codetag_ref *ref, struct allo=
c_tag *tag)
> +static inline bool alloc_tag_ref_set(union codetag_ref *ref, struct allo=
c_tag *tag)
>  {
> -       __alloc_tag_ref_set(ref, tag);
> +       if (unlikely(!__alloc_tag_ref_set(ref, tag)))
> +               return false;
> +
>         /*
>          * We need in increment the call counter every time we have a new
>          * allocation or when we split a large allocation into smaller on=
es.
> @@ -154,12 +157,13 @@ static inline void alloc_tag_ref_set(union codetag_=
ref *ref, struct alloc_tag *t
>          * counter because when we free each part the counter will be dec=
remented.
>          */
>         this_cpu_inc(tag->counters->calls);
> +       return true;
>  }
>
>  static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_ta=
g *tag, size_t bytes)
>  {
> -       alloc_tag_ref_set(ref, tag);
> -       this_cpu_add(tag->counters->bytes, bytes);
> +       if (likely(alloc_tag_ref_set(ref, tag)))
> +               this_cpu_add(tag->counters->bytes, bytes);
>  }
>
>  static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
> --
> 2.25.1
>

