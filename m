Return-Path: <linux-kernel+bounces-316805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D1196D5B4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF33287105
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341EB19882C;
	Thu,  5 Sep 2024 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="la2oEhqJ"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C18918787B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531594; cv=none; b=jke4vvpe32j1RelHtkixaxPPMegTVye9+vPuCLCTbpVnbIWh2D3wHCpl9Yjf/53fbQN9EGqjfJp2NGICChHxfpl+sS20iw3JKEGVXIfF2767E6ZtDdsHq716j2SRyRRVjwEVB+U8ZRfZrJhwVNFl1rk6Yb1kxke+x4f/I/byWWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531594; c=relaxed/simple;
	bh=h7rWohIA/QX82EMwsi8586ME9pJ0kxgRqfxC7F2NNIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RboiNOtTpedt0tepGzzVN2NUgbqkgjlfVGBBTmxaPI/o/vDhwO0SPdb1HIQjTwQvQSxKiN57NpYYBAtL/jgMEpvojgj2A+FC/nzYZ7HBdFdBTwm8Lwln6sVuguJ4tmjKvHltZCR/OeJAWgQiTkI34q/UU5FdP1EfNS3M4FNvd+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; spf=pass smtp.mailfrom=konsulko.com; dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b=la2oEhqJ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d8f06c2459so423346a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1725531591; x=1726136391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PA7JIemCyiEdqILj6UaKRiRobVb7jaWwTSUCykQJ3Wk=;
        b=la2oEhqJzeB4EKlY75gupriXdz9E2VlEtfEHMrDbJvWb6gMBerNOwdam/UZ9qTwO3N
         MuL1YiwKAGWJRYfQA4k4zHXupuk30vMZsuJZdUWlZc/2NiscVE0cPlpdoKwKmL9UeHaw
         A88LgBrwf/xD9ipfiDll9ACnogfsbaXXFFssM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531591; x=1726136391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PA7JIemCyiEdqILj6UaKRiRobVb7jaWwTSUCykQJ3Wk=;
        b=vqEygDPeFjAovSECsfxsLlbUuW+WwSSwUyGK8tS9pyht0KuvZvhTYd2hM0GijgMRTN
         ZxAi3cTgrWdmeaxPXK0BI2GkQtkm0ebQZ9DL5VPFpOuc3mjSszTEiBBJJRxlTiSBc/ss
         hRSy7BQKweEmsGJy0hL64QpU9jAowKgK63yezXU8fifie8oLSYL3Q02/VsVVzp0eOius
         uAsfYrWl4hDh91wKV281GD9HXfHSinFOMEUNyQoRD36PkEhgQqgPgYTfUYUhVWAqwr6l
         vvpL/h39w1Svd51WVj9pPRN+u9Ro1S2YJaVYOLnAmmM6NoUp8bPrOEDPw5BRhJ9LGu88
         KBzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5u/4IjqNmbSizQSc5f63uf0QMro51jirWohexdeGMRCNtYWN4uRni0RDzk3qegm6ajoMOSgF34OmtGd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfkUrz8DOPrWex76+GWam5cRK/U7O+sCf9p2XKVW4z9MUtPqZN
	RHJUOwhrG5UNmtWD4G4DH9vuGnTBTgrymKe0Ph04JuyvuXnE7fgY9dx/Jum/fVHbfU9eslK/UUX
	26youhYGJGKQrx+g+NfCImRlTuExcayJSpnkkpQ==
X-Google-Smtp-Source: AGHT+IHyTnBl3/mA7BCy8C7Mdrgi4kraU3T2YISEDkiQ+C22fRtuX7dRpdTavjnbTJxnBQ32e09vaczZ2IZyJiMaQuo=
X-Received: by 2002:a17:90a:ba94:b0:2d8:cd04:c8f0 with SMTP id
 98e67ed59e1d1-2da55a78cb0mr10646151a91.39.1725531590333; Thu, 05 Sep 2024
 03:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904233343.933462-1-yosryahmed@google.com>
In-Reply-To: <20240904233343.933462-1-yosryahmed@google.com>
From: Vitaly Wool <vitaly.wool@konsulko.com>
Date: Thu, 5 Sep 2024 12:19:38 +0200
Message-ID: <CAM4kBBKotR4qc3jTsp3McgDCj18FTL6VETWRkfL-FgSYkFbiXg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: z3fold: deprecate CONFIG_Z3FOLD
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Christoph Hellwig <hch@infradead.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Chris Down <chris@chrisdown.name>, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 1:33=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> The z3fold compressed pages allocator is rarely used, most users use
> zsmalloc. The only disadvantage of zsmalloc in comparison is the
> dependency on MMU, and zbud is a more common option for !MMU as it was
> the default zswap allocator for a long time.
>
> Historically, zsmalloc had worse latency than zbud and z3fold but
> offered better memory savings. This is no longer the case as shown by
> a simple recent analysis [1]. That analysis showed that z3fold does not
> have any advantage over zsmalloc or zbud considering both performance
> and memory usage. In a kernel build test on tmpfs in a limited cgroup,
> z3fold took 3% more time and used 1.8% more memory. The latency of
> zswap_load() was 7% higher, and that of zswap_store() was 10% higher.
> Zsmalloc is better in all metrics.
>
> Moreover, z3fold apparently has latent bugs, which was made noticeable
> by a recent soft lockup bug report with z3fold [2]. Switching to
> zsmalloc not only fixed the problem, but also reduced the swap usage
> from 6~8G to 1~2G. Other users have also reported being bitten by
> mistakenly enabling z3fold.
>
> Other than hurting users, z3fold is repeatedly causing wasted
> engineering effort. Apart from investigating the above bug, it came up
> in multiple development discussions (e.g. [3]) as something we need to
> handle, when there aren't any legit users (at least not intentionally).
>
> The natural course of action is to deprecate z3fold, and remove in a few
> cycles if no objections are raised from active users. Next on the list
> should be zbud, as it offers marginal latency gains at the cost of huge
> memory waste when compared to zsmalloc. That one will need to wait until
> zsmalloc does not depend on MMU.
>
> Rename the user-visible config option from CONFIG_Z3FOLD to
> CONFIG_Z3FOLD_DEPRECATED so that users with CONFIG_Z3FOLD=3Dy get a new
> prompt with explanation during make oldconfig. Also, remove
> CONFIG_Z3FOLD=3Dy from defconfigs.
>
> [1]https://lore.kernel.org/lkml/CAJD7tkbRF6od-2x_L8-A1QL3=3D2Ww13sCj4S3i4=
bNndqF+3+_Vg@mail.gmail.com/
> [2]https://lore.kernel.org/lkml/EF0ABD3E-A239-4111-A8AB-5C442E759CF3@gmai=
l.com/
> [3]https://lore.kernel.org/lkml/CAJD7tkbnmeVugfunffSovJf9FAgy9rhBVt_tx=3D=
nxUveLUfqVsA@mail.gmail.com/
>
> Acked-by: Chris Down <chris@chrisdown.name>
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Vitaly Wool <vitaly.wool@konsulko.com>

> ---
>
> I think it should actually be fine to remove z3fold without deprecating
> it first, but I am doing the due diligence.
>
> v1: https://lore.kernel.org/linux-mm/20240112193103.3798287-1-yosryahmed@=
google.com/
> v1 -> v2:
> - Make CONFIG_Z3FOLD_DEPRECATED a tristate option to match
>   CONFIG_Z3FOLD.
> - Update commit subject and log.
>
> ---
>  arch/loongarch/configs/loongson3_defconfig |  1 -
>  arch/powerpc/configs/ppc64_defconfig       |  1 -
>  mm/Kconfig                                 | 14 ++++++++++++--
>  3 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/=
configs/loongson3_defconfig
> index b4252c357c8e2..75b366407a60a 100644
> --- a/arch/loongarch/configs/loongson3_defconfig
> +++ b/arch/loongarch/configs/loongson3_defconfig
> @@ -96,7 +96,6 @@ CONFIG_ZPOOL=3Dy
>  CONFIG_ZSWAP=3Dy
>  CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD=3Dy
>  CONFIG_ZBUD=3Dy
> -CONFIG_Z3FOLD=3Dy
>  CONFIG_ZSMALLOC=3Dm
>  # CONFIG_COMPAT_BRK is not set
>  CONFIG_MEMORY_HOTPLUG=3Dy
> diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/=
ppc64_defconfig
> index 544a65fda77bc..d39284489aa26 100644
> --- a/arch/powerpc/configs/ppc64_defconfig
> +++ b/arch/powerpc/configs/ppc64_defconfig
> @@ -81,7 +81,6 @@ CONFIG_MODULE_SIG_SHA512=3Dy
>  CONFIG_PARTITION_ADVANCED=3Dy
>  CONFIG_BINFMT_MISC=3Dm
>  CONFIG_ZSWAP=3Dy
> -CONFIG_Z3FOLD=3Dy
>  CONFIG_ZSMALLOC=3Dy
>  # CONFIG_SLAB_MERGE_DEFAULT is not set
>  CONFIG_SLAB_FREELIST_RANDOM=3Dy
> diff --git a/mm/Kconfig b/mm/Kconfig
> index b23913d4e47e2..536679d726417 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -177,15 +177,25 @@ config ZBUD
>           deterministic reclaim properties that make it preferable to a h=
igher
>           density approach when reclaim will be used.
>
> -config Z3FOLD
> -       tristate "3:1 compression allocator (z3fold)"
> +config Z3FOLD_DEPRECATED
> +       tristate "3:1 compression allocator (z3fold) (DEPRECATED)"
>         depends on ZSWAP
>         help
> +         Deprecated and scheduled for removal in a few cycles. If you ha=
ve
> +         a good reason for using Z3FOLD over ZSMALLOC, please contact
> +         linux-mm@kvack.org and the zswap maintainers.
> +
>           A special purpose allocator for storing compressed pages.
>           It is designed to store up to three compressed pages per physic=
al
>           page. It is a ZBUD derivative so the simplicity and determinism=
 are
>           still there.
>
> +config Z3FOLD
> +       tristate
> +       default y if Z3FOLD_DEPRECATED=3Dy
> +       default m if Z3FOLD_DEPRECATED=3Dm
> +       depends on Z3FOLD_DEPRECATED
> +
>  config ZSMALLOC
>         tristate
>         prompt "N:1 compression allocator (zsmalloc)" if ZSWAP
> --
> 2.46.0.469.g59c65b2a67-goog
>

