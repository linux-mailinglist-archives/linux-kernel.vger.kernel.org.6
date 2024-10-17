Return-Path: <linux-kernel+bounces-370743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1C19A3181
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB431B20E87
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05347200B87;
	Thu, 17 Oct 2024 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="IuCAEbAD"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CB920E304
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 23:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729209331; cv=none; b=kEQoF7TA75xVpdZd5UgeB2YmpYYIOdLJQgX2nR7mcSw1lLH3mraPn3onUOzspD3JYfT7m6DnD+cm188fPbYmpEw11RX5m73aVbevK8i50pPwAuabyf/x+U2uUzw10NexDEhR0mBWXVG4+6IM4CAePl8rWxrubtKmXiQvO5Zsn8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729209331; c=relaxed/simple;
	bh=ttVT//6SOV1llrYR/MA7CtzyvkHnpfmNPPULVHmCYK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLXCmiQltWOjLAFQgVcuG89V2BNArZlY0EM/A1SnFUc/LJkZTTqNeaMaMwQQOqPGyRVjFul9snHJVM67Ct5aD3No8dP6P334UQcsjDSnThpJnjMujwaXiTH+U1jXJcNDVs8XepdsIYO4yxdk9eXSJc7E4Eis43Y6YZeRbBV8SgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org; spf=pass smtp.mailfrom=atishpatra.org; dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b=IuCAEbAD; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f7606199so1846371e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1729209326; x=1729814126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFhqsamjD0SMhzdfzPtmk29EXMRuhu+6CqUAUkCoVbQ=;
        b=IuCAEbADGqTP67cjzEqSzszmWbybF8VI8PMFXQgPswZxZe8LVNH9/GINO4+ZLwslJL
         GyFTHJoFfcYBh0EQAXw5Q5SjiK8OeJqpvInfmY+WMx0fFhK7ph3tTf4whoIW73cMp2RD
         +o7mT45sj9mro7UKN6BfXKHU59nC+a3xbSlAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729209326; x=1729814126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFhqsamjD0SMhzdfzPtmk29EXMRuhu+6CqUAUkCoVbQ=;
        b=JiZusoIx1UAc3KEc2TCNAeVYaODj97uxV+sz/+P3ku8Bsu2woK04bhaq2ZQk4QK52P
         rWxAVnJ8jel7NczGHiiITr40a17RFUlNheK+AHxP2c5aJXEMzkho7iLsQTh3BRDysNRU
         oQ0u+dEYHxwXgpLOvAzSG6UjOPHfyaBXMiNiZKDoE2zuDpa5AV0ZkbuJk9zH1HZGicWt
         Gp7ek1guJ64oZlK7PK4dO7QFWcc3ryLRAAb69Ac1u7oiru/s8C/T5OHTwO45iKM78Nys
         CCd2vqpUp1f1OjYleJhMD/MoX6FFDVNolZO316j63Em8tnG0oRhjszllko9gTrfIXNQd
         BzcA==
X-Forwarded-Encrypted: i=1; AJvYcCUyr4lcAD3plHRtdG/lD74g51YaEKRhXFg3zhPMX/mQQdTFqRc028M1516f44w/jG8B+f7QuPSZDJMUWsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCIIi1XNxyGbxeSeuQBBYWvf7tY7tKGCrs3KPj9b7l25LwdihI
	ncigCkEAMf64wMclG0DDn+SOPH+WP6FMFb64oMpcyuzHvGqsKcKrh7P7BiTtL97C1pOVVAXe009
	LhnIwMkR8g1PXwCOhtP5UOC2/jBKIwjlIE5jhCkCdKoKAb64=
X-Google-Smtp-Source: AGHT+IFfavOLQH5lk4D6zPJWCHlvDUam0vrMnnqxXT2a99DOrAAj8R1edWukPti7f53E+Dm8plX4tDMSBeJ397PTZtc=
X-Received: by 2002:a05:6512:3095:b0:539:ff5a:7ea5 with SMTP id
 2adb3069b0e04-53a15218abamr247138e87.15.1729209326192; Thu, 17 Oct 2024
 16:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719160913.342027-1-apatel@ventanamicro.com> <20240719160913.342027-8-apatel@ventanamicro.com>
In-Reply-To: <20240719160913.342027-8-apatel@ventanamicro.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Thu, 17 Oct 2024 16:55:14 -0700
Message-ID: <CAOnJCUJUUtRhkroxJ-Kvah7qRfsAApi_5dbrmAWsdObr-KjRfw@mail.gmail.com>
Subject: Re: [PATCH 07/13] RISC-V: Add defines for the SBI nested acceleration extension
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 9:09=E2=80=AFAM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> Add defines for the new SBI nested acceleration extension which was
> ratified as part of the SBI v2.0 specification.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/sbi.h | 120 +++++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 1079e214fe85..7c9ec953c519 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -33,6 +33,7 @@ enum sbi_ext_id {
>         SBI_EXT_PMU =3D 0x504D55,
>         SBI_EXT_DBCN =3D 0x4442434E,
>         SBI_EXT_STA =3D 0x535441,
> +       SBI_EXT_NACL =3D 0x4E41434C,
>
>         /* Experimentals extensions must lie within this range */
>         SBI_EXT_EXPERIMENTAL_START =3D 0x08000000,
> @@ -279,6 +280,125 @@ struct sbi_sta_struct {
>
>  #define SBI_SHMEM_DISABLE              -1
>
> +enum sbi_ext_nacl_fid {
> +       SBI_EXT_NACL_PROBE_FEATURE =3D 0x0,
> +       SBI_EXT_NACL_SET_SHMEM =3D 0x1,
> +       SBI_EXT_NACL_SYNC_CSR =3D 0x2,
> +       SBI_EXT_NACL_SYNC_HFENCE =3D 0x3,
> +       SBI_EXT_NACL_SYNC_SRET =3D 0x4,
> +};
> +
> +enum sbi_ext_nacl_feature {
> +       SBI_NACL_FEAT_SYNC_CSR =3D 0x0,
> +       SBI_NACL_FEAT_SYNC_HFENCE =3D 0x1,
> +       SBI_NACL_FEAT_SYNC_SRET =3D 0x2,
> +       SBI_NACL_FEAT_AUTOSWAP_CSR =3D 0x3,
> +};
> +
> +#define SBI_NACL_SHMEM_ADDR_SHIFT      12
> +#define SBI_NACL_SHMEM_SCRATCH_OFFSET  0x0000
> +#define SBI_NACL_SHMEM_SCRATCH_SIZE    0x1000
> +#define SBI_NACL_SHMEM_SRET_OFFSET     0x0000
> +#define SBI_NACL_SHMEM_SRET_SIZE       0x0200
> +#define SBI_NACL_SHMEM_AUTOSWAP_OFFSET (SBI_NACL_SHMEM_SRET_OFFSET + \
> +                                        SBI_NACL_SHMEM_SRET_SIZE)
> +#define SBI_NACL_SHMEM_AUTOSWAP_SIZE   0x0080
> +#define SBI_NACL_SHMEM_UNUSED_OFFSET   (SBI_NACL_SHMEM_AUTOSWAP_OFFSET +=
 \
> +                                        SBI_NACL_SHMEM_AUTOSWAP_SIZE)
> +#define SBI_NACL_SHMEM_UNUSED_SIZE     0x0580
> +#define SBI_NACL_SHMEM_HFENCE_OFFSET   (SBI_NACL_SHMEM_UNUSED_OFFSET + \
> +                                        SBI_NACL_SHMEM_UNUSED_SIZE)
> +#define SBI_NACL_SHMEM_HFENCE_SIZE     0x0780
> +#define SBI_NACL_SHMEM_DBITMAP_OFFSET  (SBI_NACL_SHMEM_HFENCE_OFFSET + \
> +                                        SBI_NACL_SHMEM_HFENCE_SIZE)
> +#define SBI_NACL_SHMEM_DBITMAP_SIZE    0x0080
> +#define SBI_NACL_SHMEM_CSR_OFFSET      (SBI_NACL_SHMEM_DBITMAP_OFFSET + =
\
> +                                        SBI_NACL_SHMEM_DBITMAP_SIZE)
> +#define SBI_NACL_SHMEM_CSR_SIZE                ((__riscv_xlen / 8) * 102=
4)
> +#define SBI_NACL_SHMEM_SIZE            (SBI_NACL_SHMEM_CSR_OFFSET + \
> +                                        SBI_NACL_SHMEM_CSR_SIZE)
> +
> +#define SBI_NACL_SHMEM_CSR_INDEX(__csr_num)    \
> +               ((((__csr_num) & 0xc00) >> 2) | ((__csr_num) & 0xff))
> +
> +#define SBI_NACL_SHMEM_HFENCE_ENTRY_SZ         ((__riscv_xlen / 8) * 4)
> +#define SBI_NACL_SHMEM_HFENCE_ENTRY_MAX                \
> +               (SBI_NACL_SHMEM_HFENCE_SIZE /   \
> +                SBI_NACL_SHMEM_HFENCE_ENTRY_SZ)
> +#define SBI_NACL_SHMEM_HFENCE_ENTRY(__num)     \
> +               (SBI_NACL_SHMEM_HFENCE_OFFSET + \
> +                (__num) * SBI_NACL_SHMEM_HFENCE_ENTRY_SZ)
> +#define SBI_NACL_SHMEM_HFENCE_ENTRY_CONFIG(__num)      \
> +               SBI_NACL_SHMEM_HFENCE_ENTRY(__num)
> +#define SBI_NACL_SHMEM_HFENCE_ENTRY_PNUM(__num)\
> +               (SBI_NACL_SHMEM_HFENCE_ENTRY(__num) + (__riscv_xlen / 8))
> +#define SBI_NACL_SHMEM_HFENCE_ENTRY_PCOUNT(__num)\
> +               (SBI_NACL_SHMEM_HFENCE_ENTRY(__num) + \
> +                ((__riscv_xlen / 8) * 3))
> +
> +#define SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_BITS 1
> +#define SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_SHIFT        \
> +               (__riscv_xlen - SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_BITS)
> +#define SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_MASK \
> +               ((1UL << SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_BITS) - 1)
> +#define SBI_NACL_SHMEM_HFENCE_CONFIG_PEND              \
> +               (SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_MASK << \
> +                SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_SHIFT)
> +
> +#define SBI_NACL_SHMEM_HFENCE_CONFIG_RSVD1_BITS        3
> +#define SBI_NACL_SHMEM_HFENCE_CONFIG_RSVD1_SHIFT \
> +               (SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_SHIFT - \
> +                SBI_NACL_SHMEM_HFENCE_CONFIG_RSVD1_BITS)
> +
> +#define SBI_NACL_SHMEM_HFENCE_CONFIG_TYPE_BITS 4
> +#define SBI_NACL_SHMEM_HFENCE_CONFIG_TYPE_SHIFT        \
> +               (SBI_NACL_SHMEM_HFENCE_CONFIG_RSVD1_SHIFT - \
> +                SBI_NACL_SHMEM_HFENCE_CONFIG_TYPE_BITS)
> +#define SBI_NACL_SHMEM_HFENCE_CONFIG_TYPE_MASK \
> +               ((1UL << SBI_NACL_SHMEM_HFENCE_CONFIG_TYPE_BITS) - 1)
> +
> +#define SBI_NACL_SHMEM_HFENCE_TYPE_GVMA                0x0
> +#define SBI_NACL_SHMEM_HFENCE_TYPE_GVMA_ALL    0x1
> +#define SBI_NACL_SHMEM_HFENCE_TYPE_GVMA_VMID   0x2
> +#define SBI_NACL_SHMEM_HFENCE_TYPE_GVMA_VMID_ALL 0x3
> +#define SBI_NACL_SHMEM_HFENCE_TYPE_VVMA                0x4
> +#define SBI_NACL_SHMEM_HFENCE_TYPE_VVMA_ALL    0x5
> +#define SBI_NACL_SHMEM_HFENCE_TYPE_VVMA_ASID   0x6
> +#define SBI_NACL_SHMEM_HFENCE_TYPE_VVMA_ASID_ALL 0x7
> +
> +#define SBI_NACL_SHMEM_HFENCE_CONFIG_RSVD2_BITS        1
> +#define SBI_NACL_SHMEM_HFENCE_CONFIG_RSVD2_SHIFT \
> +               (SBI_NACL_SHMEM_HFENCE_CONFIG_TYPE_SHIFT - \
> +                SBI_NACL_SHMEM_HFENCE_CONFIG_RSVD2_BITS)
> +
> +#define SBI_NACL_SHMEM_HFENCE_CONFIG_ORDER_BITS        7
> +#define SBI_NACL_SHMEM_HFENCE_CONFIG_ORDER_SHIFT \
> +               (SBI_NACL_SHMEM_HFENCE_CONFIG_RSVD2_SHIFT - \
> +                SBI_NACL_SHMEM_HFENCE_CONFIG_ORDER_BITS)
> +#define SBI_NACL_SHMEM_HFENCE_CONFIG_ORDER_MASK        \
> +               ((1UL << SBI_NACL_SHMEM_HFENCE_CONFIG_ORDER_BITS) - 1)
> +#define SBI_NACL_SHMEM_HFENCE_ORDER_BASE       12
> +
> +#if __riscv_xlen =3D=3D 32
> +#define SBI_NACL_SHMEM_HFENCE_CONFIG_ASID_BITS 9
> +#define SBI_NACL_SHMEM_HFENCE_CONFIG_VMID_BITS 7
> +#else
> +#define SBI_NACL_SHMEM_HFENCE_CONFIG_ASID_BITS 16
> +#define SBI_NACL_SHMEM_HFENCE_CONFIG_VMID_BITS 14
> +#endif
> +#define SBI_NACL_SHMEM_HFENCE_CONFIG_VMID_SHIFT        \
> +                               SBI_NACL_SHMEM_HFENCE_CONFIG_ASID_BITS
> +#define SBI_NACL_SHMEM_HFENCE_CONFIG_ASID_MASK \
> +               ((1UL << SBI_NACL_SHMEM_HFENCE_CONFIG_ASID_BITS) - 1)
> +#define SBI_NACL_SHMEM_HFENCE_CONFIG_VMID_MASK \
> +               ((1UL << SBI_NACL_SHMEM_HFENCE_CONFIG_VMID_BITS) - 1)
> +
> +#define SBI_NACL_SHMEM_AUTOSWAP_FLAG_HSTATUS   BIT(0)
> +#define SBI_NACL_SHMEM_AUTOSWAP_HSTATUS                ((__riscv_xlen / =
8) * 1)
> +
> +#define SBI_NACL_SHMEM_SRET_X(__i)             ((__riscv_xlen / 8) * (__=
i))
> +#define SBI_NACL_SHMEM_SRET_X_LAST             31
> +
>  /* SBI spec version fields */
>  #define SBI_SPEC_VERSION_DEFAULT       0x1
>  #define SBI_SPEC_VERSION_MAJOR_SHIFT   24
> --
> 2.34.1
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>
--=20
Regards,
Atish

