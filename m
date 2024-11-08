Return-Path: <linux-kernel+bounces-402327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 481B79C2670
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB321F23FAF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC691AA1C1;
	Fri,  8 Nov 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZLHQNkZb"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DDE192B6F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097449; cv=none; b=kMe+TZ8NQywmtrZHeaNeyJvwXY5semsDoWrAcuakli13fiKuMAgrYn1dJ3VI2kgCqw7lj32JvvmPgGEoEdp48fYC4aHUVvMVJOmAA0yibQQXEfX5ty7WL8CtZcg4Qd45jVwaP+x/Xqkz/7hP8xwZlI52o2d69/mRnnL2Bpp+xy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097449; c=relaxed/simple;
	bh=OZAeXMox/KlEDAsB/4eMgXmLZQfDG5q4/Gt0jdrhshM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVO5lIbLcD4N1/4GjtlYIDk/1v8nr3nJaGuvWWS0EKb8WSdhKgA2QEntUN6UjvCfypdFncTQX2PkJgNUEzcpkWeb/NBkkHFbeZrZsqHTp41zt8NmG67d0xt9LuJ2np0uX3RQoWYz0QFkIJP2n6pBF0i9u5Cb4HuVlbvcrOv2E10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZLHQNkZb; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b14077ec5aso343346285a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 12:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731097446; x=1731702246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXILrBeBuixnjykDOnFBzIWDX7dpjLHEipvuPBeIMt4=;
        b=ZLHQNkZbEd5D6cVJJnVkOk0n1+UvaW4u5GUusegRODxjwDxZdj0zY2jLtAxQ/2Yi2/
         O8mZgkF53p20gIky71UnTGHkVe09TFr+xzhjEQuqcfe/2U/WiUt577bUGGBOXk29XBui
         sgzdpr1AXgDPVkjY7+ELZylovwg13YKZdjy/3K87eY51OEZzFMAbTt0hRpb+tn3WWI7C
         A5PvmZ2o0nnbiMt00N38ZHLGFuWuIsZSh4Tvr9jy/Z3slP7a4w9Gmrt4jaZggzm0JicP
         ZtKwK2ZdG1oonjElar42i848l/h4ass/XRdKZR+pdX33soaW/l+ooQrFzrHbstgGuKXO
         tZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731097446; x=1731702246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXILrBeBuixnjykDOnFBzIWDX7dpjLHEipvuPBeIMt4=;
        b=LZ38SGzcTJhS6zU/HAvP5K/fd1QGZafi0AY+7L1dhONYSNugTjGk9uLonGi2W73hAJ
         caoSNTPE7TznecDfi1O13YqLiBXtMM/5hmoeRMF6HdFftFW9RJaGN4a5ytNjW0wqiDS+
         NMGGKWJlUA22yO94Cwz1fz/+Meb5Iqi97x4J2V3xVlgJIYeZ45KuHs1Z5PPgntH6BjoB
         Bn49it6RkH1v8NjApjUyPaBZ4e2+hKxkWCVtdYGl5iMxla6OS/G7ZOg/lGlJch6r9NQD
         wYfgYahuQUlhzu/520sAGT6x3Y7pmmNqu3RMiLfQlgamTjrqgUeekYW9h//1Yt472W0a
         pfqQ==
X-Gm-Message-State: AOJu0YyNH/L8EkZ3chGFR1Y5khUPYRHE4VTLGB6JDzpSqTiQN/le67U3
	Gm25Qi2QDOW0Thy5auVMAwgvRQ5nOnIZ1NZ7Dtt0NCyOsiX3iSkvOI2KAQZ8ScVb1S4fcs2bFQB
	rqENc84Ha56xfbSS5R91csAwEnjM1s5MfRabK
X-Google-Smtp-Source: AGHT+IFtVP27mLjrCefU+cBNzDFOK75ljBCTtQMT80A+RFCEJ1lgmg9hWpxu5Kj7hCQvkfsXVxtq5sko7EhVIYtxm6o=
X-Received: by 2002:a05:6214:44a1:b0:6d3:4453:6a48 with SMTP id
 6a1803df08f44-6d39e507f62mr70771516d6.13.1731097446291; Fri, 08 Nov 2024
 12:24:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106192105.6731-1-kanchana.p.sridhar@intel.com> <20241106192105.6731-11-kanchana.p.sridhar@intel.com>
In-Reply-To: <20241106192105.6731-11-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 8 Nov 2024 12:23:29 -0800
Message-ID: <CAJD7tkaWixgwXHKLar9_EFa-ooeU0zx5Q=gQW7utyokm3ARkqQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/13] mm: zswap: Add a per-cpu "acomp_batch_ctx" to
 struct zswap_pool.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com, 
	akpm@linux-foundation.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, davem@davemloft.net, clabbe@baylibre.com, 
	ardb@kernel.org, ebiggers@google.com, surenb@google.com, 
	kristen.c.accardi@intel.com, zanussi@kernel.org, wajdi.k.feghali@intel.com, 
	vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 11:21=E2=80=AFAM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> This patch adds a separate per-cpu batching acomp context "acomp_batch_ct=
x"
> to the zswap_pool. The per-cpu acomp_batch_ctx pointer is allocated at po=
ol
> creation time, but no per-cpu resources are allocated for it.
>
> The idea is to not incur the memory footprint cost of multiple acomp_reqs
> and buffers in the existing "acomp_ctx" for cases where compress batching
> is not possible; for instance, with software compressor algorithms, on
> systems without IAA, on systems with IAA that want to run the existing
> non-batching implementation of zswap_store() of large folios.
>
> By creating a separate acomp_batch_ctx, we have the ability to allocate
> additional memory per-cpu only if the zswap compressor supports batching,
> and if the user wants to enable the use of compress batching in
> zswap_store() to improve swapout performance of large folios.
>
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>

This isn't needed if the sysctl is removed and we just allocate the
number of buffers during pool initialization, right? Same for the next
patch.


> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>  mm/zswap.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 02e031122fdf..80a928cf0f7e 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -160,6 +160,7 @@ struct crypto_acomp_ctx {
>  struct zswap_pool {
>         struct zpool *zpool;
>         struct crypto_acomp_ctx __percpu *acomp_ctx;
> +       struct crypto_acomp_ctx __percpu *acomp_batch_ctx;
>         struct percpu_ref ref;
>         struct list_head list;
>         struct work_struct release_work;
> @@ -287,10 +288,14 @@ static struct zswap_pool *zswap_pool_create(char *t=
ype, char *compressor)
>
>         pool->acomp_ctx =3D alloc_percpu(*pool->acomp_ctx);
>         if (!pool->acomp_ctx) {
> -               pr_err("percpu alloc failed\n");
> +               pr_err("percpu acomp_ctx alloc failed\n");
>                 goto error;
>         }
>
> +       pool->acomp_batch_ctx =3D alloc_percpu(*pool->acomp_batch_ctx);
> +       if (!pool->acomp_batch_ctx)
> +               pr_err("percpu acomp_batch_ctx alloc failed\n");
> +
>         ret =3D cpuhp_state_add_instance(CPUHP_MM_ZSWP_POOL_PREPARE,
>                                        &pool->node);
>         if (ret)
> @@ -312,6 +317,8 @@ static struct zswap_pool *zswap_pool_create(char *typ=
e, char *compressor)
>  ref_fail:
>         cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->no=
de);
>  error:
> +       if (pool->acomp_batch_ctx)
> +               free_percpu(pool->acomp_batch_ctx);
>         if (pool->acomp_ctx)
>                 free_percpu(pool->acomp_ctx);
>         if (pool->zpool)
> @@ -368,6 +375,8 @@ static void zswap_pool_destroy(struct zswap_pool *poo=
l)
>
>         cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->no=
de);
>         free_percpu(pool->acomp_ctx);
> +       if (pool->acomp_batch_ctx)
> +               free_percpu(pool->acomp_batch_ctx);
>
>         zpool_destroy_pool(pool->zpool);
>         kfree(pool);
> @@ -930,6 +939,11 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, =
struct hlist_node *node)
>         struct zswap_pool *pool =3D hlist_entry(node, struct zswap_pool, =
node);
>         struct crypto_acomp_ctx *acomp_ctx;
>
> +       if (pool->acomp_batch_ctx) {
> +               acomp_ctx =3D per_cpu_ptr(pool->acomp_batch_ctx, cpu);
> +               acomp_ctx->nr_reqs =3D 0;
> +       }
> +
>         acomp_ctx =3D per_cpu_ptr(pool->acomp_ctx, cpu);
>         return zswap_create_acomp_ctx(cpu, acomp_ctx, pool->tfm_name, 1);
>  }
> @@ -939,6 +953,12 @@ static int zswap_cpu_comp_dead(unsigned int cpu, str=
uct hlist_node *node)
>         struct zswap_pool *pool =3D hlist_entry(node, struct zswap_pool, =
node);
>         struct crypto_acomp_ctx *acomp_ctx;
>
> +       if (pool->acomp_batch_ctx) {
> +               acomp_ctx =3D per_cpu_ptr(pool->acomp_batch_ctx, cpu);
> +               if (!IS_ERR_OR_NULL(acomp_ctx) && (acomp_ctx->nr_reqs > 0=
))
> +                       zswap_delete_acomp_ctx(acomp_ctx);
> +       }
> +
>         acomp_ctx =3D per_cpu_ptr(pool->acomp_ctx, cpu);
>         zswap_delete_acomp_ctx(acomp_ctx);
>
> --
> 2.27.0
>

