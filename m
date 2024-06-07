Return-Path: <linux-kernel+bounces-205541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D85F8FFD3F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44AE71C228EC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4766D154422;
	Fri,  7 Jun 2024 07:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ec3Lk8rG"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5211C2BE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717745647; cv=none; b=jZ7Rt6aohiOTy63xbYD0S8vhfF2H86fGA0XQF32mRAVURlMTsbitECHIzR77FGZJqWynFNRPDisEM3WK/BYzi0GOI/0+tGokCAWtAdeaxzA/UdLWLBMr4HVpFcVBfGo5d3yYHm1/6mMeDIbh4BmlUuFOxKakCNdcdH0XzA/zD40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717745647; c=relaxed/simple;
	bh=vYYXsEBTb0bzmGXVrvmnqmApDuO+F9CPi3HsvreDUD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEJtgAQxN25RMLCRlKoNEFpxisAqWyU3CeS+NRlOcVN0O12PFbmyeEzXzJ4w2/Q/vRdPugjGvYlJQZYoI60/MSCh29Rnr6mdqJ2Jg7O+DOITPhfe2qSn1qqFO5Oc+z0RDUxRjd9Bak94MCHZXDRVGF5Nk8ymnpwFr7pJzeWj8r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ec3Lk8rG; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-80ac76f1226so1691795241.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 00:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717745645; x=1718350445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyL/tEXv9q+vrjmq0MkI7TdwwhxQ4pIHED6hCiXm55I=;
        b=Ec3Lk8rGgOMtpOq/c7XPvLrIcR41PcPPljnTjLJGoV5GBhvtkGmzzPNA3Gyp+1RWIT
         zTVY4kW6KG1bq15eAoSsgOlJIpXprK0Rpmb2trNyrU5mXYvZuleaAbaa9i7frlxotj3+
         5H4xs9FDF9OwDJtNkjO0NTjnEl7GxjUXG/H0ptKO1QtwLzV5l7l/JlCvHoV5RGsDSe4U
         ZcXzgHrcsKJ75dbmkxPqHQ0K+svgRpYJr/BVXgOUxZf8znzXQxL8CIH1cV7mvfqv1UOS
         h5DhFTMBcx07vmzvhLCZvrGdLUHAuKa3/3GRYyYke/YSBIhcnisXqy9mhTc+AtnhB+5v
         e/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717745645; x=1718350445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyL/tEXv9q+vrjmq0MkI7TdwwhxQ4pIHED6hCiXm55I=;
        b=KKQgCn9FfCAAHju3EffRw+udGdAhfTk96drxA/KVdYhsWV2dCcUqH1KA2Nx8jRjRbH
         Eiv1jALw9huqZRSFrLCN7wMXr4oJZnTTcrFWLD+BRye23MjV2Kif7fh4x0ja9hAlVrGx
         z+TBpJvV1ZtTtIhWkp+Z+CrBiQlfGf75xpDVZ4QvKeszxxGFjfFpaptZAix0zUbTQuzr
         XCj4s2g376hvjtCjM3rcfuAqayY/VMC2OGoIsXlte2xazNR4Ujo847Bp7KmXI3UP6Adx
         AXSBUgBJxd3+oC8W1Yvy8ZOeRwDddm1Uf6tAaGsn5aIoKiOPuBYkiMvcEo1s0eVqgj2s
         5+LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLnnPJB0tOX1w+s5N8eaMue9gbDJsOOTwnS5opAcMz/+1gFRrMQcOVem1gRv0izLkuKmO0nSXcYnKiZioa4yjnqfUelK9xbtr6hv9R
X-Gm-Message-State: AOJu0YzcUfaCc/wm7x4Pbm+yF/EC4P5recQjlZ+hviSTxYXXLMgq3xTV
	BYqa/JDoXvwD5qsOOeVlt9WoqbqtMhSqroWVQAqFoG3hkzEDCr3PHkbU078KjLbDdMRxQTjiYHr
	h9o/MxPypR4R5MkxpEzMc0rDG+PJ62oFsbs2G
X-Google-Smtp-Source: AGHT+IHaeNJ1MuvAGR+aV7KvBD3fVvaoUgs7b6DZps3nGdlcGBq99EDHwsn/36ZgdH683W6QJ5rrHAkUVbBp7XVOcDg=
X-Received: by 2002:a67:f34f:0:b0:48b:c32e:2185 with SMTP id
 ada2fe7eead31-48c17159270mr5112575137.9.1717745644465; Fri, 07 Jun 2024
 00:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606-kvm-arm64-fix-pkvm-sve-vl-v2-0-c88f4eb4b14b@kernel.org> <20240606-kvm-arm64-fix-pkvm-sve-vl-v2-2-c88f4eb4b14b@kernel.org>
In-Reply-To: <20240606-kvm-arm64-fix-pkvm-sve-vl-v2-2-c88f4eb4b14b@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 7 Jun 2024 08:33:27 +0100
Message-ID: <CA+EHjTwBRaCnzPfwdccHGGqsq9hGB5J1tA2aMcJyuRL8yYRZ0Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] arm64/fpsimd: Discover maximum vector length
 implemented by any CPU
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Thu, Jun 6, 2024 at 4:32=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> When discovering the vector lengths for SVE and SME we do not currently
> record the maximum VL supported on any individual CPU.  This is expected
> to be the same for all CPUs but the architecture allows asymmetry, if we
> do encounter an asymmetric system then some CPUs may support VLs higher
> than the maximum Linux will use.  Since the pKVM hypervisor needs to
> support saving and restoring anything the host can physically set it
> needs to know the maximum value any CPU could have, add support for
> enumerating it and validation for late CPUs.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/fpsimd.h | 13 +++++++++++++
>  arch/arm64/kernel/fpsimd.c      | 26 +++++++++++++++++++++++++-
>  2 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fps=
imd.h
> index 51c21265b4fa..cd19713c9deb 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -188,6 +188,9 @@ struct vl_info {
>         int max_vl;
>         int max_virtualisable_vl;
>
> +       /* Maximum vector length observed on any CPU */
> +       int max_cpu_vl;
> +
>         /*
>          * Set of available vector lengths,
>          * where length vq encoded as bit __vq_to_bit(vq):
> @@ -278,6 +281,11 @@ static inline int vec_max_virtualisable_vl(enum vec_=
type type)
>         return vl_info[type].max_virtualisable_vl;
>  }
>
> +static inline int vec_max_cpu_vl(enum vec_type type)
> +{
> +       return vl_info[type].max_cpu_vl;
> +}
> +
>  static inline int sve_max_vl(void)
>  {
>         return vec_max_vl(ARM64_VEC_SVE);
> @@ -288,6 +296,11 @@ static inline int sve_max_virtualisable_vl(void)
>         return vec_max_virtualisable_vl(ARM64_VEC_SVE);
>  }
>
> +static inline int sve_max_cpu_vl(void)
> +{
> +       return vec_max_cpu_vl(ARM64_VEC_SVE);
> +}
> +
>  /* Ensure vq >=3D SVE_VQ_MIN && vq <=3D SVE_VQ_MAX before calling this f=
unction */
>  static inline bool vq_available(enum vec_type type, unsigned int vq)
>  {
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 22542fb81812..ee6fb8c4b16d 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -129,6 +129,7 @@ __ro_after_init struct vl_info vl_info[ARM64_VEC_MAX]=
 =3D {
>                 .min_vl                 =3D SVE_VL_MIN,
>                 .max_vl                 =3D SVE_VL_MIN,
>                 .max_virtualisable_vl   =3D SVE_VL_MIN,
> +               .max_cpu_vl             =3D SVE_VL_MIN,
>         },
>  #endif
>  #ifdef CONFIG_ARM64_SME
> @@ -1041,8 +1042,13 @@ static void vec_probe_vqs(struct vl_info *info,
>  void __init vec_init_vq_map(enum vec_type type)
>  {
>         struct vl_info *info =3D &vl_info[type];
> +       unsigned long b;
> +
>         vec_probe_vqs(info, info->vq_map);
>         bitmap_copy(info->vq_partial_map, info->vq_map, SVE_VQ_MAX);
> +
> +       b =3D find_first_bit(info->vq_map, SVE_VQ_MAX);
> +       info->max_cpu_vl =3D __bit_to_vl(b);
>  }
>
>  /*
> @@ -1054,11 +1060,16 @@ void vec_update_vq_map(enum vec_type type)
>  {
>         struct vl_info *info =3D &vl_info[type];
>         DECLARE_BITMAP(tmp_map, SVE_VQ_MAX);
> +       unsigned long b;
>
>         vec_probe_vqs(info, tmp_map);
>         bitmap_and(info->vq_map, info->vq_map, tmp_map, SVE_VQ_MAX);
>         bitmap_or(info->vq_partial_map, info->vq_partial_map, tmp_map,
>                   SVE_VQ_MAX);
> +
> +       b =3D find_first_bit(tmp_map, SVE_VQ_MAX);
> +       if (__bit_to_vl(b) > info->max_cpu_vl)
> +               info->max_cpu_vl =3D __bit_to_vl(b);
>  }
>
>  /*
> @@ -1069,10 +1080,23 @@ int vec_verify_vq_map(enum vec_type type)
>  {
>         struct vl_info *info =3D &vl_info[type];
>         DECLARE_BITMAP(tmp_map, SVE_VQ_MAX);
> -       unsigned long b;
> +       unsigned long b, max_vl;
>
>         vec_probe_vqs(info, tmp_map);
>
> +       /*
> +        * Currently the maximum VL is only used for pKVM which
> +        * doesn't allow late CPUs but we don't expect asymmetry and
> +        * if we encounter any then future users will need handling so
> +        * warn if we see anything.
> +        */
> +       max_vl =3D __bit_to_vl(find_first_bit(tmp_map, SVE_VQ_MAX));
> +       if (max_vl > info->max_cpu_vl) {
> +               pr_warn("%s: cpu%d: increases maximum VL to %u\n",

This should be %lu since it's an unsigned long. Otherwise it doesn't
build (clang).

Cheers,
/fuad

> +                       info->name, smp_processor_id(), max_vl);
> +               info->max_cpu_vl =3D max_vl;
> +       }
> +
>         bitmap_complement(tmp_map, tmp_map, SVE_VQ_MAX);
>         if (bitmap_intersects(tmp_map, info->vq_map, SVE_VQ_MAX)) {
>                 pr_warn("%s: cpu%d: Required vector length(s) missing\n",
>
> --
> 2.39.2
>

