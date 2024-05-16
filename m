Return-Path: <linux-kernel+bounces-181142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3138C7823
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770891F237EA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F7614A4E1;
	Thu, 16 May 2024 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BhCD22Dc"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFFF4206C
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715868026; cv=none; b=SOG8m4rPGfxeFKUImEC0nfbXVGt8LbGAzTw/I5XzEuIDl/nXjhaB8NEpYUOOBAsXKwsABYJ4lH+st2KXAov6xO4PgrJXCpjZMHLtJFhW3BYSAPrQnjXzTBaMUUjVq+fzMBMe+rYKK19iVCGgeQYJUtDXgnD86e0+gwHxxM0me8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715868026; c=relaxed/simple;
	bh=N0mPA+arP6XJeVtdFeMPRAWdHbtc4Ku64hU43AeRhbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XU/nkRZvpqW6cSGO+nR+RIKQzb7W39GbjBsZrIh+w9O5xZ4+6MklEvR7JDwHiNP/qjfDhxVE0BQ260fdHnDNxusMBQetJU/D9YJQcu3UbUWJt+OlyngeqoCdxggo8eZPb7S/QJuxb+GH2+9zvXTkzr3xQ0u2SzOYqFnASVbFMEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=BhCD22Dc; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61be4b98766so93589387b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 07:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715868024; x=1716472824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cD8EYomjv0kIIk3OrzTD6Ca/3+CIlst2MLQc78I7jZU=;
        b=BhCD22Dc5V68obKgOEVceU+JrXBdI6Ww3G3vWghy1zaiE88ECqEsRB/uAmpOr1z9bx
         g1BgG6RNRJ61JdqrZBf/psEcESg6sODr5Gow38BQ8GA5XnT9g3b8WyGXroOSi4X7x8UZ
         FxMqUsRicsFg7omGr2lUVrtmkLf13OxAwexyDr86xQuyaHTA5W6nhEEIWFJDEdr+x0v6
         JWMYHMifLANNI3fteQmDOHYxQVzE+nXnR1fjkdHEBFE+233sDhlG/4ZLtSkt2eWb6XPz
         NFAG95Ucsym7MfMwnoxiiefv3ojOm9ApGZg8N3H8CihSQGP8vcrgPObnhcYGxJwUAq4E
         1UyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715868024; x=1716472824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cD8EYomjv0kIIk3OrzTD6Ca/3+CIlst2MLQc78I7jZU=;
        b=L1440mFQdOe4/8xo61SdS/+ChYf84OpHyQtmGuHl3vEOEOHUoHYIEwPeF8hoN+ESoM
         yI9tTRdpmtJu6y2/mv0dVZ7sEgLRnityA1NTTNlWtEqVv2ddpNoqrwK76ve2yEojQQxg
         eqpcs/DzH/vhUJ6N9TFgE+lhpS9tPgPhiqgUnf1YfQ2fEv3XM7cBHVUwTIvOFj+Y+yOn
         MkELVekyj8aMmR3HdNlf4Ra59iiYEp+O95KZIjkhyrA8wm7W6J7Ml9PwZJnMtRYfm22W
         VSnZIU8XAYTowgr2YSY7trNis/RCiiLEMdFl9gEIW7IAomK4hlU8hE9n6zyMfAx7aUCN
         CL1w==
X-Forwarded-Encrypted: i=1; AJvYcCWYP4SdC2y59f7E8byaO78+0zF/+rdxMigcH9KfBoAoeoiFJcUyrUa4MqBvp0Drlthud5u7g1IQIpjxx48N6cVylFM76HR3CbDvYu6v
X-Gm-Message-State: AOJu0Yzpcmwc6INfy59Zqk+vqYfh0SvkZfYdENJlse3FzFsJIokOvqla
	2qe+5SEHEqcZ9muFFL10OVCgCra/48wMBdZ3tVnAXygEOgaGEz9+VCWnB4gq7x+tvesZdOcsfAd
	drIAp3DUPBag8GngPplXu14Ypz5fqjznHt1cPHg==
X-Google-Smtp-Source: AGHT+IEiXLNHmQcW5RA/wgj6ioJ1XAjnfrpiTrNjDqI8fGRd+D3gGsZcnD/VKszGvYjANziq7R0rmzEGrccihxPdLyI=
X-Received: by 2002:a81:480f:0:b0:61a:dfd6:fd6d with SMTP id
 00721157ae682-622aff831a4mr186279727b3.25.1715868023507; Thu, 16 May 2024
 07:00:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
 <20240503-dev-charlie-support_thead_vector_6_9-v6-3-cb7624e65d82@rivosinc.com>
In-Reply-To: <20240503-dev-charlie-support_thead_vector_6_9-v6-3-cb7624e65d82@rivosinc.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 16 May 2024 22:00:12 +0800
Message-ID: <CABgGipXg68VEGt=oZZSENmbqs4-g3PB=CBobNwgqQjLHfxo+VQ@mail.gmail.com>
Subject: Re: [PATCH v6 03/17] riscv: vector: Use vlenb from DT
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry Charlie, I forgot to include the mailing list. Here is the same as
what I sent in the private message.

On Sat, May 4, 2024 at 2:21=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
>
> If vlenb is provided in the device tree, prefer that over reading the
> vlenb csr.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/cpufeature.h |  2 ++
>  arch/riscv/kernel/cpufeature.c      | 47 +++++++++++++++++++++++++++++++=
++++++
>  arch/riscv/kernel/vector.c          | 12 +++++++++-
>  3 files changed, 60 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index 347805446151..0c4f08577015 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -31,6 +31,8 @@ DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
>  /* Per-cpu ISA extensions. */
>  extern struct riscv_isainfo hart_isa[NR_CPUS];
>
> +extern u32 riscv_vlenb_of;
> +
>  void riscv_user_isa_enable(void);
>
>  #if defined(CONFIG_RISCV_MISALIGNED)
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 3ed2359eae35..6c143ea9592b 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -35,6 +35,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __r=
ead_mostly;
>  /* Per-cpu ISA extensions. */
>  struct riscv_isainfo hart_isa[NR_CPUS];
>
> +u32 riscv_vlenb_of;
> +
>  /**
>   * riscv_isa_extension_base() - Get base extension word
>   *
> @@ -648,6 +650,46 @@ static int __init riscv_isa_fallback_setup(char *__u=
nused)
>  early_param("riscv_isa_fallback", riscv_isa_fallback_setup);
>  #endif
>
> +static int has_riscv_homogeneous_vlenb(void)
> +{
> +       int cpu;
> +       u32 prev_vlenb =3D 0;
> +       u32 vlenb;
> +
> +       /* Ignore vlenb if vector is not enabled in the kernel */
> +       if (!IS_ENABLED(CONFIG_RISCV_ISA_V))
> +               return 0;
> +
> +       for_each_possible_cpu(cpu) {
> +               struct device_node *cpu_node;
> +
> +               cpu_node =3D of_cpu_device_node_get(cpu);
> +               if (!cpu_node) {
> +                       pr_warn("Unable to find cpu node\n");
> +                       return -ENOENT;
> +               }
> +
> +               if (of_property_read_u32(cpu_node, "riscv,vlenb", &vlenb)=
) {
> +                       of_node_put(cpu_node);
> +
> +                       if (prev_vlenb)
> +                               return -ENOENT;
> +                       continue;
> +               }
> +
> +               if (prev_vlenb && vlenb !=3D prev_vlenb) {
> +                       of_node_put(cpu_node);
> +                       return -ENOENT;
> +               }
> +
> +               prev_vlenb =3D vlenb;
> +               of_node_put(cpu_node);
> +       }
> +
> +       riscv_vlenb_of =3D vlenb;
> +       return 0;
> +}
> +
>  void __init riscv_fill_hwcap(void)
>  {
>         char print_str[NUM_ALPHA_EXTS + 1];
> @@ -671,6 +713,11 @@ void __init riscv_fill_hwcap(void)
>                         pr_info("Falling back to deprecated \"riscv,isa\"=
\n");
>                         riscv_fill_hwcap_from_isa_string(isa2hwcap);
>                 }
> +
> +               if (elf_hwcap & COMPAT_HWCAP_ISA_V && has_riscv_homogeneo=
us_vlenb() < 0) {
> +                       pr_warn("Unsupported heterogeneous vlen detected,=
 vector extension disabled.\> +                       elf_hwcap &=3D ~COMPA=
T_HWCAP_ISA_V;
> +               }

We only touch COMPAT_HWCAP_ISA_V and the failed case only turns off the
rectified V. So here we have nothing to do with the Xtheadvector.

However, I am still confused because I think Xtheadvector would also
need to call into this check, so as to setup vlenb.

Apart from that, it seems like some vendor stating Xtheadvector is
actually vector-0.7. Please correct me if I speak anything wrong. One
thing I noticed is that Xtheadvector wouldn't trap on reading
th.vlenb but vector-0.7 would. If that is the case, should we require
Xtheadvector to specify `riscv,vlenb` on the device tree?

>         }
>
>         /*
> diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> index 6727d1d3b8f2..e04586cdb7f0 100644
> --- a/arch/riscv/kernel/vector.c
> +++ b/arch/riscv/kernel/vector.c
> @@ -33,7 +33,17 @@ int riscv_v_setup_vsize(void)
>  {
>         unsigned long this_vsize;
>
> -       /* There are 32 vector registers with vlenb length. */
> +       /*
> +        * There are 32 vector registers with vlenb length.
> +        *
> +        * If the riscv,vlenb property was provided by the firmware, use =
that
> +        * instead of probing the CSRs.
> +        */
> +       if (riscv_vlenb_of) {
> +               this_vsize =3D riscv_vlenb_of * 32;
> +               return 0;
> +       }
> +
>         riscv_v_enable();
>         this_vsize =3D csr_read(CSR_VLENB) * 32;
>         riscv_v_disable();
>
> --
> 2.44.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Thanks,
Andy

