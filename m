Return-Path: <linux-kernel+bounces-309267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F94196684A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5E0E1F23DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855391BBBE8;
	Fri, 30 Aug 2024 17:45:55 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E861BBBD1
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039955; cv=none; b=GGIYURp7rATmHS2crLsDYRFXr45UAjVq/RBsHu9E0xQ6qNeizThlYmjFBpgORAsQweuOcGBxa59X9tNTOHtLPLSV0VGlWwc532pxR15nTEzJKPRubrImg542dVXWcgq+wmHP7JIFBGljoj0PrBA+OZ9bNS0NDRqK6+IBjlipVXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039955; c=relaxed/simple;
	bh=H1KQCfBQ5A+9IgMefyCem9RLD3ZgGTvgtXV3A0Qhfqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgZ0UjApMO/1Uh1xGv3m8ymyVjegJbh2He2YzvrX9HF1mmgnvO26x3+LOAKVmIvx4l4Jdu5NFEr1pvUe+OhKCiyQsT8EQb9fOWMfyIFPZvuxC19dWhwqU8Ogg1dmfUWSUxt0tJZAfLYgqZSCttCwELpdUyJ613nS9xIMHPHpmFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e1654a42cb8so1988597276.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725039952; x=1725644752;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5VZdYBdunGKr6q5K8iFBXjwecNfK3TfeeWox1Td9ek=;
        b=gpDIwHf0uelbtIXLKtfwNcsghWYpRS0zLv6O0bQ5cXzCxkCzjBQbu6cJkaoerR4oaR
         DZfnCQxEmh5uXAecNPABjyWo3nwC23huBQfMrMs6LwqyMcVFWe2pgwH4lTcLhHt6akNk
         r8w3iVo8O8encA/UatxDByDGA229OMUxeQu73uCWbjd+tDyxD9i3HIY3ngH5GrHmNR+J
         /wcQvl2ntG5DLKsuKiP8Vvuj8NpSmcQu78FMycPgp0I31g0nvzhxD3utACwperEhp7tS
         +ijBCT7XJkUF4SByZiWzaobmUfEh3apze4SJkLJpLxLFLSn345VBQsKK0OW7W5VaV88P
         t83w==
X-Forwarded-Encrypted: i=1; AJvYcCXABueO3DGG1fKiZtdVRiKZQhu0ajo3O8MN1RbpOUCBLpFkcEuPadP5DrrOIi13m1tNaLVLHJxKT2/FjxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEEpa6prZAHUd3/EdFac/pfWibYqbY5+wnN8nJ8vb3meGx4w4O
	sPlIJyDz29rDjNsa1JBiIf7dcDLgkyUvUbakhmbPq0k5oA/m9FKe
X-Google-Smtp-Source: AGHT+IGE3JAIfIWFZoiiShX+tHq4XIG220DamDu5mxWG4sWKBDI8FtEi8BDxzwjc6vj1A4SP1l26Qw==
X-Received: by 2002:a05:6902:2586:b0:e04:e298:3749 with SMTP id 3f1490d57ef6-e1a7a025ecbmr3405874276.33.1725039952023;
        Fri, 30 Aug 2024 10:45:52 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c27a7asm162817785a.40.2024.08.30.10.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 10:45:51 -0700 (PDT)
Date: Fri, 30 Aug 2024 12:45:49 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] sched_ext: Rename scx_kfunc_set_sleepable to
 unlocked and relocate
Message-ID: <20240830174549.GE5055@maniforge>
References: <20240830110415.116090-1-tj@kernel.org>
 <20240830110415.116090-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4sQouU9x8L2T0I4s"
Content-Disposition: inline
In-Reply-To: <20240830110415.116090-2-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--4sQouU9x8L2T0I4s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 01:03:45AM -1000, Tejun Heo wrote:
> Sleepables don't need to be in its own kfunc set as each is tagged with
> KF_SLEEPABLE. Rename to scx_kfunc_set_unlocked indicating that rq lock is
> not held and relocate right above the any set. This will be used to add
> kfuncs that are allowed to be called from SYSCALL but not TRACING.
>=20
> No functional changes intended.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: David Vernet <void@manifault.com>

> ---
>  kernel/sched/ext.c | 66 +++++++++++++++++++++++-----------------------
>  1 file changed, 33 insertions(+), 33 deletions(-)
>=20
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 140a4612d379..5423554a11af 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5395,35 +5395,6 @@ void __init init_sched_ext_class(void)
> =20
>  __bpf_kfunc_start_defs();
> =20
> -/**
> - * scx_bpf_create_dsq - Create a custom DSQ
> - * @dsq_id: DSQ to create
> - * @node: NUMA node to allocate from
> - *
> - * Create a custom DSQ identified by @dsq_id. Can be called from any sle=
epable
> - * scx callback, and any BPF_PROG_TYPE_SYSCALL prog.
> - */
> -__bpf_kfunc s32 scx_bpf_create_dsq(u64 dsq_id, s32 node)
> -{
> -	if (unlikely(node >=3D (int)nr_node_ids ||
> -		     (node < 0 && node !=3D NUMA_NO_NODE)))
> -		return -EINVAL;
> -	return PTR_ERR_OR_ZERO(create_dsq(dsq_id, node));
> -}
> -
> -__bpf_kfunc_end_defs();
> -
> -BTF_KFUNCS_START(scx_kfunc_ids_sleepable)
> -BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_SLEEPABLE)
> -BTF_KFUNCS_END(scx_kfunc_ids_sleepable)
> -
> -static const struct btf_kfunc_id_set scx_kfunc_set_sleepable =3D {
> -	.owner			=3D THIS_MODULE,
> -	.set			=3D &scx_kfunc_ids_sleepable,
> -};
> -
> -__bpf_kfunc_start_defs();
> -
>  /**
>   * scx_bpf_select_cpu_dfl - The default implementation of ops.select_cpu=
()
>   * @p: task_struct to select a CPU for
> @@ -5766,6 +5737,35 @@ static const struct btf_kfunc_id_set scx_kfunc_set=
_cpu_release =3D {
> =20
>  __bpf_kfunc_start_defs();
> =20
> +/**
> + * scx_bpf_create_dsq - Create a custom DSQ
> + * @dsq_id: DSQ to create
> + * @node: NUMA node to allocate from
> + *
> + * Create a custom DSQ identified by @dsq_id. Can be called from any sle=
epable
> + * scx callback, and any BPF_PROG_TYPE_SYSCALL prog.
> + */
> +__bpf_kfunc s32 scx_bpf_create_dsq(u64 dsq_id, s32 node)
> +{
> +	if (unlikely(node >=3D (int)nr_node_ids ||
> +		     (node < 0 && node !=3D NUMA_NO_NODE)))
> +		return -EINVAL;
> +	return PTR_ERR_OR_ZERO(create_dsq(dsq_id, node));
> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(scx_kfunc_ids_unlocked)
> +BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_SLEEPABLE)
> +BTF_KFUNCS_END(scx_kfunc_ids_unlocked)
> +
> +static const struct btf_kfunc_id_set scx_kfunc_set_unlocked =3D {
> +	.owner			=3D THIS_MODULE,
> +	.set			=3D &scx_kfunc_ids_unlocked,
> +};
> +
> +__bpf_kfunc_start_defs();
> +
>  /**
>   * scx_bpf_kick_cpu - Trigger reschedule on a CPU
>   * @cpu: cpu to kick
> @@ -6462,10 +6462,6 @@ static int __init scx_init(void)
>  	 * check using scx_kf_allowed().
>  	 */
>  	if ((ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> -					     &scx_kfunc_set_sleepable)) ||
> -	    (ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
> -					     &scx_kfunc_set_sleepable)) ||
> -	    (ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>  					     &scx_kfunc_set_select_cpu)) ||
>  	    (ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>  					     &scx_kfunc_set_enqueue_dispatch)) ||
> @@ -6473,6 +6469,10 @@ static int __init scx_init(void)
>  					     &scx_kfunc_set_dispatch)) ||
>  	    (ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>  					     &scx_kfunc_set_cpu_release)) ||
> +	    (ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> +					     &scx_kfunc_set_unlocked)) ||
> +	    (ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
> +					     &scx_kfunc_set_unlocked)) ||
>  	    (ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>  					     &scx_kfunc_set_any)) ||
>  	    (ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> --=20
> 2.46.0
>=20

--4sQouU9x8L2T0I4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZtIFTQAKCRBZ5LhpZcTz
ZMj/AP95sa/AeXEIv+kibts6vi2xt/iHAo1ThcD9Etw3BHFGhAD2JXgx7Hb9xLms
DqCWqly9aFVZOJJiu1iDNzClZfwnBA==
=ecme
-----END PGP SIGNATURE-----

--4sQouU9x8L2T0I4s--

