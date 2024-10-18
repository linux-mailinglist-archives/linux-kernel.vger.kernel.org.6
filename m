Return-Path: <linux-kernel+bounces-372118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01249A44A7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18EEFB230CC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC5D2040A6;
	Fri, 18 Oct 2024 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="evP0KyfB"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E8B20402B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272627; cv=none; b=R+zWyY/vQ8iQgrE41sj9nh7owddU+5j9tua/YeUvF9b8Hn0OEkL8v1ZlM3ywkig8iQXBZJgcmjOuhZgoQRqtrRSygth1ycRNV88mS9MH62HVDsb7O5rZr2e6MuXsLD/q8K21uwclPeXqRghgmDB70+hT0vEEzs+HAe4QNzYNqrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272627; c=relaxed/simple;
	bh=JkO/0N/tT/Hg4duiFp3dU7nz8iZObwtLwrgUKhSOVWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFFXvSLHoslO6Ay/fzfQKv9yUEA37kSVj3/8bqiuHWCuzXf979GHGYdH5NW5kBwikbIgwIr8EsN1R/5wgH47ZEin9tq6QkLsAC6qrh7qHYpd/ioenCzA0sdeMY/A3McAbrnaI9ggv1pq1k48hf/aXZIMHXe2FrmucdF71Fp7hcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=evP0KyfB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c87b0332cso203135ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729272624; x=1729877424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yl+RWsDoZHvymXAM3gnR2Dr8XeUMsH4KlJbxvfHYSiI=;
        b=evP0KyfBsKkgl5UFTkUP9Dg8IDgC86XqjWvXd/KeFH5ob69jYNPy3ZHgds3ZJMortq
         zvM7GkMNB7cCerzOqq0Dd1sfZPwLmATdMhYKve7NLj9Qo9sFhzE7bKf/8l3KWKnen/Qd
         z0Uqasz89oa+7fz3Ic3n9I1a6opGMQTDBKzjeGvShraAlydUX/TbwmJCTRMUXzKSPTgy
         Yrh4gKlsUIjQo756aIEfazhDn8NaCqQpvp8Fu/o3ECMT/ufMWipAqCMRCnu60/ZGyqc5
         5eeVYQpWyb+RMHuSRE1hWBkiaQNN4U0tRgrClApFGK1RMz3SzzCTvxgYm5e5Mzhrw44G
         f45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729272624; x=1729877424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yl+RWsDoZHvymXAM3gnR2Dr8XeUMsH4KlJbxvfHYSiI=;
        b=xB+6xJWbOEUxxJx69lLSVP7HsxwghwQHplhZ91I6zNKLdEWPFQcKM7j3U8m1NgM0Lk
         +kbRsDVOdfbbuAKBMthizdzC8r3bh9GbMQkDETDQI+ZIoGkdgxWhWEpm0FdEFa3wbvtE
         GXCAkGxSHbCTTI8oKQGc4g3MZRTSuvzV6pcidHFEuXy5AGHLxzBjPlbhoA0zxxYIcO6s
         SBv2lfhguu6G7v8mj9U/U9e5W6mZuWjXdyuPRoD26qDtR97aTcdIIMEVDXh4POtB1Xg4
         ++uYPa40xIpe8EIpyuqKvlo6ZhaT4s/7j1X7CcdLzatXOJOHunGyeA4YSX+MZZ+eJExI
         J4FA==
X-Forwarded-Encrypted: i=1; AJvYcCUak+nhl0efe/f+fHwiw58AYZubU9E9gAfi2qaC4l5jyoCiYcH8V05f9g/gPEszHBOgCepj8uWu+NAJNdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFJIfebYatC7rmGksk6ZZFihbSzUCl/6huUg3u3J59AelL1Ura
	y0lp7OJtaWTSh2050+1AF6IYHllV6cIA+ba++2f8i82k5Tuc9kMbqxWnNkpptEnRl2HuAjHYO0u
	Lf1ibxli3sPJcAedctfecMeYZr+XYYRRJ9OD1
X-Google-Smtp-Source: AGHT+IGoKlnl7xUNQSBPqZl0pBOVj3bc3gVRvsXRgAaj7j+IGIDDm+SAPasqUYDbd8quSIfGVgr0XZYr9gVZ2KMM/Cg=
X-Received: by 2002:a17:902:c943:b0:205:968b:31e9 with SMTP id
 d9443c01a7336-20e5b7b85c0mr2861785ad.1.1729272623354; Fri, 18 Oct 2024
 10:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018152925.138341-1-hao.ge@linux.dev> <20241018162559.143548-1-hao.ge@linux.dev>
In-Reply-To: <20241018162559.143548-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 18 Oct 2024 10:30:12 -0700
Message-ID: <CAJuCfpEnRQ9p4V22wWMNwcHMYjToJETwrxkVNMV_EM46WbcF5g@mail.gmail.com>
Subject: Re: [PATCH v2] mm/codetag: move ref and tag null pointer check to alloc_tag_add
To: Hao Ge <hao.ge@linux.dev>
Cc: kent.overstreet@linux.dev, akpm@linux-foundation.org, yuzhao@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 9:26=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
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
> in slub_kunit.c,we still need to move the null pointer check for ref
> and tag to alloc_tag_add here.
> It is sufficient for us to issue a warning to the user;
> It should not lead to a panic.
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
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
> v2: Modify the errors in the title and commit message.
>     Remove the empty lines that were mistakenly added in version v1.
> ---
>  include/linux/alloc_tag.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index 1f0a9ff23a2c..8603e3a9df10 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -137,10 +137,6 @@ static inline void alloc_tag_sub_check(union codetag=
_ref *ref) {}
>  /* Caller should verify both ref and tag to be valid */
>  static inline void __alloc_tag_ref_set(union codetag_ref *ref, struct al=
loc_tag *tag)
>  {
> -       alloc_tag_add_check(ref, tag);
> -       if (!ref || !tag)
> -               return;
> -

Unfortunately this change will result in __alloc_tag_ref_set() and
alloc_tag_ref_set() missing the following important check from
alloc_tag_sub_check():

WARN_ONCE(ref && ref->ct,
  "alloc_tag was not cleared (got tag for %s:%u)\n",
  ref->ct->filename, ref->ct->lineno);

I think the change below would fix this issue without the above
mentioned side-effect:

-static inline void __alloc_tag_ref_set(union codetag_ref *ref, struct
alloc_tag *tag)
+static inline bool __alloc_tag_ref_set(union codetag_ref *ref, struct
alloc_tag *tag)
 {
        alloc_tag_add_check(ref, tag);
        if (!ref || !tag)
-                return;
+                return false;

        ref->ct =3D &tag->ct;
+        return true;
 }

-static inline void alloc_tag_ref_set(union codetag_ref *ref, struct
alloc_tag *tag)
+static inline bool alloc_tag_ref_set(union codetag_ref *ref, struct
alloc_tag *tag)
 {
-        __alloc_tag_ref_set(ref, tag);
+        if (unlikely(!__alloc_tag_ref_set(ref, tag)))
+                return false;
+
        /*
         * We need in increment the call counter every time we have a new
         * allocation or when we split a large allocation into smaller ones=
.
         * Each new reference for every sub-allocation needs to increment c=
all
         * counter because when we free each part the counter will be
decremented.
         */
        this_cpu_inc(tag->counters->calls);
+        return true;
 }

 static inline void alloc_tag_add(union codetag_ref *ref, struct
alloc_tag *tag, size_t bytes)
 {
-        alloc_tag_ref_set(ref, tag);
-        this_cpu_add(tag->counters->bytes, bytes);
+        if (likely(alloc_tag_ref_set(ref, tag)))
+                this_cpu_add(tag->counters->bytes, bytes);
 }

Could you please confirm this fix?
Thanks,
Suren.

>         ref->ct =3D &tag->ct;
>  }
>
> @@ -158,6 +154,10 @@ static inline void alloc_tag_ref_set(union codetag_r=
ef *ref, struct alloc_tag *t
>
>  static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_ta=
g *tag, size_t bytes)
>  {
> +       alloc_tag_add_check(ref, tag);
> +       if (!ref || !tag)
> +               return;
> +
>         alloc_tag_ref_set(ref, tag);
>         this_cpu_add(tag->counters->bytes, bytes);
>  }
> --
> 2.25.1
>

