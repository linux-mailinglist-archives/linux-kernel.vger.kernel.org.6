Return-Path: <linux-kernel+bounces-303041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A72496068C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086CC1C20F33
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B1E19CCEA;
	Tue, 27 Aug 2024 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Dv+LP9bb"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7FE156C40
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752881; cv=none; b=tNsVY4WqcEBTo4MA9dAhOAPLaRIxhuU9KRyDvaUU3z7UkTmEFlDHrCs+Ll3kMA0wuDPCIb8csueN/df0JQIO3QGt0PvkoiKbBjW4rhdaVEV1PPjnQQnyL9EcHlv1ESvuPEvQDcinnBgIw/gFMXptt7VovgTzFfGMCSlfwP/Qkos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752881; c=relaxed/simple;
	bh=AEIGOuTI6UpoUzSg2FhlkyKfWuH2HnHgDD+UAdr1jp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CD2sHpRc8g3v/eTDnKSfwVfvhEN+VpJY/GVSZlnZBq6ZATQJ4fznkeEih/6qW9bi7LhQU67yEdR3BCk1PRZmSnNDcIADa2+IDCCqtCgdofhup0UlNT7t8YI89khqgkXwgG8HEC2ZFT2GL76GbXwNi5yYDcMrhGdeEmEI6xiRxno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Dv+LP9bb; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4fce2c0707bso1624820e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 03:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724752877; x=1725357677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dSraDAg79g9fYTVssRCjHuK+JCZKBjJLg4ztbHwyVQ=;
        b=Dv+LP9bbTH/ui6gxMaNNJDPcDCpSwrnZpvb/rTrsJLEvFfXRB2FIwCyQz3F5de42NT
         R34ihOWiXztnCU/m7ctmYTIDKuF/q+x1RuhlQeWpa5oqEqxIbSQfkOC8laadlXxzXj0G
         59IyrSIjA2IZ+uBYnsAYVQEPsgrnxn/8yO912gv/iHmA/UmNDGU9wyWOS5H6l3cxHT47
         cV/Vk9YRq8BRVfOIvqPPFBIYKgeDJHvegh/XglIWvWadWrk+oJovxVYipajwY7omY9GG
         kgYVeQJknHyCQptve+2bJTyA/4fHZwHF4DRRKgKBP7dkajHuBzk5Sok6kp2Zr5YcfHYb
         +flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724752877; x=1725357677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dSraDAg79g9fYTVssRCjHuK+JCZKBjJLg4ztbHwyVQ=;
        b=Do/26/xJotTqxUMQJ8oV1Nu22Q4GtSbrxnZ7h9st67F/stmtlK8SCkcje1QBAveUUL
         NBKa5SDHPyUoKo6QMjgKEUY8GfzyAjh7KC7fIsybDgfhGqRiC6HUHyrWX2AtyJpZ5Hme
         AlmktHKiVwVF47TZpgMfVrlAYWQu1DKanUKRcs95C871AMt/lJTw5Okj/3jNxfo5bhrP
         qGmN3zVEgXIW4vqXmQUWK/u2eV3Sju5ydIqi+u3ELOD5R/lqBu+1+EcpCaKj1fGMLNVQ
         SMfFkKIHV2b13VjnWSJbbgyML1Zj1WQlvaDsT3wKmNr339aqbX2pJkyj3gxgwxfwBc+7
         2Dyg==
X-Forwarded-Encrypted: i=1; AJvYcCVeWYunuo619XRIYYcvjjYCXj/Ui03b8BmCxRZhtvcFgzouJdihbzNJhv0t5uOeLywtc7pROJScNVoMcWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjIXUeYIbwpbhzUiKVZcsiv4QTSMWckWZ9u2VB0c3lOQsva8Yr
	3lbxtHkCX33qyIYEXjc2MnAJJySPuvnOCjEIBkf3kPZIh/3uy4iCfNR+Lj7Be+QKY6Go2pRUooQ
	LtOe5YhsdkB+f/+JJCwOlhUNL71XeZbVzLkFtBA==
X-Google-Smtp-Source: AGHT+IF+70aS+Fj5Y0z0sydZNI8+KAHMG8pH/47VrgYDrhwY35pv4MkKNRzrAUWXjFX62TgXxAVeIvtv85EGaT7La0g=
X-Received: by 2002:a05:6122:1d4b:b0:4ef:65b6:f3b5 with SMTP id
 71dfb90a1353d-4fd1acd19f8mr15385262e0c.10.1724752877105; Tue, 27 Aug 2024
 03:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529185337.182722-1-rkanwal@rivosinc.com> <20240529185337.182722-6-rkanwal@rivosinc.com>
 <CAPqJEFoJ4qz523nxccOD4VD=uufbwxfkR-5MDfzQFxGfiK+hrw@mail.gmail.com>
In-Reply-To: <CAPqJEFoJ4qz523nxccOD4VD=uufbwxfkR-5MDfzQFxGfiK+hrw@mail.gmail.com>
From: Vincent Chen <vincent.chen@sifive.com>
Date: Tue, 27 Aug 2024 18:01:06 +0800
Message-ID: <CABvJ_xgEQ1PQ-hosLCak2e27_MqVAc_4M+e6gSm+LZvHVa7mjg@mail.gmail.com>
Subject: Re: [PATCH RFC 5/6] riscv: perf: Add driver for Control Transfer
 Records Ext.
To: rkanwal@rivosinc.com
Cc: linux-riscv <linux-riscv@lists.infradead.org>, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, Andrew Jones <ajones@ventanamicro.com>, 
	Anup Patel <anup@brainfault.org>, acme@kernel.org, Atish Patra <atishp@rivosinc.com>, 
	beeman@rivosinc.com, brauner@kernel.org, Conor Dooley <conor@kernel.org>, heiko@sntech.de, 
	irogers@google.com, mingo@redhat.com, james.clark@arm.com, 
	renyu.zj@linux.alibaba.com, jolsa@kernel.org, jisheng.teoh@starfivetech.com, 
	Palmer Dabbelt <palmer@dabbelt.com>, tech-control-transfer-records@lists.riscv.org, 
	will@kernel.org, kaiwenxue1@gmail.com, linux-perf-users@vger.kernel.org, 
	"linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> From: Rajnesh Kanwal <rkanwal@rivosinc.com>
> Date: Thu, May 30, 2024 at 2:56=E2=80=AFAM
> Subject: [PATCH RFC 5/6] riscv: perf: Add driver for Control Transfer Rec=
ords Ext.
> To: <linux-kernel@vger.kernel.org>
> Cc: <linux-perf-users@vger.kernel.org>, <linux-riscv@lists.infradead.org>=
, <adrian.hunter@intel.com>, <alexander.shishkin@linux.intel.com>, <ajones@=
ventanamicro.com>, <anup@brainfault.org>, <acme@kernel.org>, <atishp@rivosi=
nc.com>, <beeman@rivosinc.com>, <brauner@kernel.org>, <conor@kernel.org>, <=
heiko@sntech.de>, <irogers@google.com>, <mingo@redhat.com>, <james.clark@ar=
m.com>, <renyu.zj@linux.alibaba.com>, <jolsa@kernel.org>, <jisheng.teoh@sta=
rfivetech.com>, <palmer@dabbelt.com>, <tech-control-transfer-records@lists.=
riscv.org>, <will@kernel.org>, <kaiwenxue1@gmail.com>, Rajnesh Kanwal <rkan=
wal@rivosinc.com>
>
>
> This adds support for CTR Ext defined in [0]. The extension
> allows to records a maximum for 256 last branch records.
>
> CTR extension depends on s[m|s]csrind and Sscofpmf extensions.
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---
>  MAINTAINERS                    |   1 +
>  drivers/perf/Kconfig           |  11 +
>  drivers/perf/Makefile          |   1 +
>  drivers/perf/riscv_ctr.c       | 469 +++++++++++++++++++++++++++++++++
>  include/linux/perf/riscv_pmu.h |  33 +++
>  5 files changed, 515 insertions(+)
>  create mode 100644 drivers/perf/riscv_ctr.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6b42d5f62da..868e4b0808ab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19056,6 +19056,7 @@ M:      Atish Patra <atishp@atishpatra.org>
>  R:     Anup Patel <anup@brainfault.org>
>  L:     linux-riscv@lists.infradead.org
>  S:     Supported
> +F:     drivers/perf/riscv_ctr.c
>  F:     drivers/perf/riscv_pmu_common.c
>  F:     drivers/perf/riscv_pmu_dev.c
>  F:     drivers/perf/riscv_pmu_legacy.c
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 3c37577b25f7..cca6598be739 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -110,6 +110,17 @@ config ANDES_CUSTOM_PMU
>
>           If you don't know what to do here, say "Y".
>
> +config RISCV_CTR
> +       bool "Enable support for Control Transfer Records (CTR)"
> +       depends on PERF_EVENTS && RISCV_PMU
> +       default y
> +       help
> +         Enable support for Control Transfer Records (CTR) which
> +         allows recording branches, Jumps, Calls, returns etc taken in a=
n
> +         execution path. This also supports privilege based filtering. I=
t
> +         captures additional relevant information such as cycle count,
> +         branch misprediction etc.
> +
>  config ARM_PMU_ACPI
>         depends on ARM_PMU && ACPI
>         def_bool y
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index ba809cc069d5..364b1f66f410 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_RISCV_PMU_COMMON) +=3D riscv_pmu_common.o
>  obj-$(CONFIG_RISCV_PMU_LEGACY) +=3D riscv_pmu_legacy.o
>  obj-$(CONFIG_RISCV_PMU) +=3D riscv_pmu_dev.o
>  obj-$(CONFIG_STARFIVE_STARLINK_PMU) +=3D starfive_starlink_pmu.o
> +obj-$(CONFIG_RISCV_CTR) +=3D riscv_ctr.o
>  obj-$(CONFIG_THUNDERX2_PMU) +=3D thunderx2_pmu.o
>  obj-$(CONFIG_XGENE_PMU) +=3D xgene_pmu.o
>  obj-$(CONFIG_ARM_SPE_PMU) +=3D arm_spe_pmu.o
> diff --git a/drivers/perf/riscv_ctr.c b/drivers/perf/riscv_ctr.c
> new file mode 100644
> index 000000000000..95fda1edda4f
> --- /dev/null
> +++ b/drivers/perf/riscv_ctr.c
> @@ -0,0 +1,469 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Control transfer records extension Helpers.
> + *
> + * Copyright (C) 2024 Rivos Inc.
> + *
> + * Author: Rajnesh Kanwal <rkanwal@rivosinc.com>
> + */
> +
> +#define pr_fmt(fmt) "CTR: " fmt
> +
> +#include <linux/bitfield.h>
> +#include <linux/printk.h>
> +#include <linux/types.h>
> +#include <linux/perf_event.h>
> +#include <linux/perf/riscv_pmu.h>
> +#include <linux/cpufeature.h>
> +#include <asm/hwcap.h>
> +#include <asm/csr_ind.h>
> +#include <asm/csr.h>
> +
> +#define CTR_BRANCH_FILTERS_INH  (CTRCTL_EXCINH       | \
> +                                CTRCTL_INTRINH      | \
> +                                CTRCTL_TRETINH      | \
> +                                CTRCTL_TKBRINH      | \
> +                                CTRCTL_INDCALL_INH  | \
> +                                CTRCTL_DIRCALL_INH  | \
> +                                CTRCTL_INDJUMP_INH  | \
> +                                CTRCTL_DIRJUMP_INH  | \
> +                                CTRCTL_CORSWAP_INH  | \
> +                                CTRCTL_RET_INH      | \
> +                                CTRCTL_INDOJUMP_INH | \
> +                                CTRCTL_DIROJUMP_INH)
> +
> +#define CTR_BRANCH_ENABLE_BITS (CTRCTL_KERNEL_ENABLE | CTRCTL_U_ENABLE)
> +
> +/* Branch filters not-supported by CTR extension. */
> +#define CTR_EXCLUDE_BRANCH_FILTERS (PERF_SAMPLE_BRANCH_ABORT_TX         =
       | \
> +                                   PERF_SAMPLE_BRANCH_IN_TX            |=
 \
> +                                   PERF_SAMPLE_BRANCH_PRIV_SAVE        |=
 \
> +                                   PERF_SAMPLE_BRANCH_NO_TX            |=
 \
> +                                   PERF_SAMPLE_BRANCH_COUNTERS)
> +
> +/* Branch filters supported by CTR extension. */
> +#define CTR_ALLOWED_BRANCH_FILTERS (PERF_SAMPLE_BRANCH_USER            |=
 \
> +                                   PERF_SAMPLE_BRANCH_KERNEL           |=
 \
> +                                   PERF_SAMPLE_BRANCH_HV               |=
 \
> +                                   PERF_SAMPLE_BRANCH_ANY              |=
 \
> +                                   PERF_SAMPLE_BRANCH_ANY_CALL         |=
 \
> +                                   PERF_SAMPLE_BRANCH_ANY_RETURN       |=
 \
> +                                   PERF_SAMPLE_BRANCH_IND_CALL         |=
 \
> +                                   PERF_SAMPLE_BRANCH_COND             |=
 \
> +                                   PERF_SAMPLE_BRANCH_IND_JUMP         |=
 \
> +                                   PERF_SAMPLE_BRANCH_HW_INDEX         |=
 \
> +                                   PERF_SAMPLE_BRANCH_NO_FLAGS         |=
 \
> +                                   PERF_SAMPLE_BRANCH_NO_CYCLES        |=
 \
> +                                   PERF_SAMPLE_BRANCH_CALL_STACK       |=
 \
> +                                   PERF_SAMPLE_BRANCH_CALL             |=
 \
> +                                   PERF_SAMPLE_BRANCH_TYPE_SAVE)
> +
> +#define CTR_PERF_BRANCH_FILTERS    (CTR_ALLOWED_BRANCH_FILTERS         |=
 \
> +                                   CTR_EXCLUDE_BRANCH_FILTERS)
> +
> +static u64 allowed_filters __read_mostly;
> +
> +struct ctr_regset {
> +       unsigned long src;
> +       unsigned long target;
> +       unsigned long ctr_data;
> +};
> +
> +static inline u64 get_ctr_src_reg(unsigned int ctr_idx)
> +{
> +       return csr_ind_read(CSR_IREG, CTR_ENTRIES_FIRST, ctr_idx);
> +}
> +
> +static inline u64 get_ctr_tgt_reg(unsigned int ctr_idx)
> +{
> +       return csr_ind_read(CSR_IREG2, CTR_ENTRIES_FIRST, ctr_idx);
> +}
> +
> +static inline u64 get_ctr_data_reg(unsigned int ctr_idx)
> +{
> +       return csr_ind_read(CSR_IREG3, CTR_ENTRIES_FIRST, ctr_idx);
> +}
> +
> +static inline bool ctr_record_valid(u64 ctr_src)
> +{
> +       return !!FIELD_GET(CTRSOURCE_VALID, ctr_src);
> +}
> +
> +static inline int ctr_get_mispredict(u64 ctr_target)
> +{
> +       return FIELD_GET(CTRTARGET_MISP, ctr_target);
> +}
> +
> +static inline unsigned int ctr_get_cycles(u64 ctr_data)
> +{
> +       const unsigned int cce =3D FIELD_GET(CTRDATA_CCE_MASK, ctr_data);
> +       const unsigned int ccm =3D FIELD_GET(CTRDATA_CCM_MASK, ctr_data);
> +
> +       if (ctr_data & CTRDATA_CCV)
> +               return 0;
> +
> +       /* Formula to calculate cycles from spec: (2^12 + CCM) << CCE-1 *=
/
> +       if (cce > 0)
> +               return (4096 + ccm) << (cce - 1);
> +
> +       return FIELD_GET(CTRDATA_CCM_MASK, ctr_data);
> +}
> +
> +static inline unsigned int ctr_get_type(u64 ctr_data)
> +{
> +       return FIELD_GET(CTRDATA_TYPE_MASK, ctr_data);
> +}
> +
> +static inline unsigned int ctr_get_depth(u64 ctr_depth)
> +{
> +       /* Depth table from CTR Spec: 2.4 sctrdepth.
> +        *
> +        * sctrdepth.depth       Depth
> +        * 000                  - 16
> +        * 001                  - 32
> +        * 010                  - 64
> +        * 011                  - 128
> +        * 100                  - 256
> +        *
> +        * Depth =3D 16 * 2 ^ (ctrdepth.depth)
> +        * or
> +        * Depth =3D 16 << ctrdepth.depth.
> +        */
> +       return 16 << FIELD_GET(SCTRDEPTH_MASK, ctr_depth);
> +}
> +
> +/* Reads CTR entry at idx and stores it in entry struct. */
> +static bool capture_ctr_regset(struct ctr_regset *entry, unsigned int id=
x)
> +{
> +       entry->src =3D get_ctr_src_reg(idx);
> +
> +       if (!ctr_record_valid(entry->src))
> +               return false;
> +
> +       entry->src =3D entry->src & (~CTRSOURCE_VALID);
> +       entry->target =3D get_ctr_tgt_reg(idx);
> +       entry->ctr_data =3D get_ctr_data_reg(idx);
> +
> +       return true;
> +}
> +
> +static u64 branch_type_to_ctr(int branch_type)
> +{
> +       u64 config =3D CTR_BRANCH_FILTERS_INH | CTRCTL_LCOFIFRZ;
> +
> +       if (branch_type & PERF_SAMPLE_BRANCH_USER)
> +               config |=3D CTRCTL_U_ENABLE;
> +
> +       if (branch_type & PERF_SAMPLE_BRANCH_KERNEL)
> +               config |=3D CTRCTL_KERNEL_ENABLE;
> +
> +       if (branch_type & PERF_SAMPLE_BRANCH_HV) {
> +               if (riscv_isa_extension_available(NULL, h))
> +                       config |=3D CTRCTL_KERNEL_ENABLE;
> +       }
> +
> +       if (branch_type & PERF_SAMPLE_BRANCH_ANY) {
> +               config &=3D ~CTR_BRANCH_FILTERS_INH;
> +               return config;
> +       }
> +
> +       if (branch_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
> +               config &=3D ~CTRCTL_INDCALL_INH;
> +               config &=3D ~CTRCTL_DIRCALL_INH;
> +               config &=3D ~CTRCTL_EXCINH;
> +               config &=3D ~CTRCTL_INTRINH;
> +       }
> +
> +       if (branch_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
> +               config &=3D ~(CTRCTL_RET_INH | CTRCTL_TRETINH);
> +
> +       if (branch_type & PERF_SAMPLE_BRANCH_IND_CALL)
> +               config &=3D ~CTRCTL_INDCALL_INH;
> +
> +       if (branch_type & PERF_SAMPLE_BRANCH_COND)
> +               config &=3D ~CTRCTL_TKBRINH;
> +
> +       if (branch_type & PERF_SAMPLE_BRANCH_CALL_STACK) {
> +               config &=3D ~(CTRCTL_INDCALL_INH | CTRCTL_DIRCALL_INH |
> +                           CTRCTL_RET_INH);
> +               config |=3D CTRCTL_RASEMU;
> +       }
> +
> +       if (branch_type & PERF_SAMPLE_BRANCH_IND_JUMP) {
> +               config &=3D ~CTRCTL_INDJUMP_INH;
> +               config &=3D ~CTRCTL_INDOJUMP_INH;
> +       }
> +
> +       if (branch_type & PERF_SAMPLE_BRANCH_CALL)
> +               config &=3D ~CTRCTL_DIRCALL_INH;
> +
> +       return config;
> +}
> +
> +static const int ctr_perf_map[] =3D {
> +       [CTRDATA_TYPE_NONE]                     =3D PERF_BR_UNKNOWN,
> +       [CTRDATA_TYPE_EXCEPTION]                =3D PERF_BR_SYSCALL,
> +       [CTRDATA_TYPE_INTERRUPT]                =3D PERF_BR_IRQ,
> +       [CTRDATA_TYPE_TRAP_RET]                 =3D PERF_BR_ERET,
> +       [CTRDATA_TYPE_NONTAKEN_BRANCH]          =3D PERF_BR_COND,
> +       [CTRDATA_TYPE_TAKEN_BRANCH]             =3D PERF_BR_COND,
> +       [CTRDATA_TYPE_RESERVED_6]               =3D PERF_BR_UNKNOWN,
> +       [CTRDATA_TYPE_RESERVED_7]               =3D PERF_BR_UNKNOWN,
> +       [CTRDATA_TYPE_INDIRECT_CALL]            =3D PERF_BR_IND_CALL,
> +       [CTRDATA_TYPE_DIRECT_CALL]              =3D PERF_BR_CALL,
> +       [CTRDATA_TYPE_INDIRECT_JUMP]            =3D PERF_BR_UNCOND,
> +       [CTRDATA_TYPE_DIRECT_JUMP]              =3D PERF_BR_UNKNOWN,
> +       [CTRDATA_TYPE_CO_ROUTINE_SWAP]          =3D PERF_BR_UNKNOWN,
> +       [CTRDATA_TYPE_RETURN]                   =3D PERF_BR_RET,
> +       [CTRDATA_TYPE_OTHER_INDIRECT_JUMP]      =3D PERF_BR_IND,
> +       [CTRDATA_TYPE_OTHER_DIRECT_JUMP]        =3D PERF_BR_UNKNOWN,
> +};
> +
> +static void ctr_set_perf_entry_type(struct perf_branch_entry *entry,
> +                                   u64 ctr_data)
> +{
> +       int ctr_type =3D ctr_get_type(ctr_data);
> +
> +       entry->type =3D ctr_perf_map[ctr_type];
> +       if (entry->type =3D=3D PERF_BR_UNKNOWN)
> +               pr_warn("%d - unknown branch type captured\n", ctr_type);
> +}
> +
> +static void capture_ctr_flags(struct perf_branch_entry *entry,
> +                             struct perf_event *event, u64 ctr_data,
> +                             u64 ctr_target)
> +{
> +       if (branch_sample_type(event))
> +               ctr_set_perf_entry_type(entry, ctr_data);
> +
> +       if (!branch_sample_no_cycles(event))
> +               entry->cycles =3D ctr_get_cycles(ctr_data);
> +
> +       if (!branch_sample_no_flags(event)) {
> +               entry->abort =3D 0;
> +               entry->mispred =3D ctr_get_mispredict(ctr_target);
> +               entry->predicted =3D !entry->mispred;
> +       }
> +
> +       if (branch_sample_priv(event))
> +               entry->priv =3D PERF_BR_PRIV_UNKNOWN;
> +}
> +
> +
> +static void ctr_regset_to_branch_entry(struct cpu_hw_events *cpuc,
> +                                      struct perf_event *event,
> +                                      struct ctr_regset *regset,
> +                                      unsigned int idx)
> +{
> +       struct perf_branch_entry *entry =3D &cpuc->branches->branch_entri=
es[idx];
> +
> +       perf_clear_branch_entry_bitfields(entry);
> +       entry->from =3D regset->src;
> +       entry->to =3D regset->target & (~CTRTARGET_MISP);
> +       capture_ctr_flags(entry, event, regset->ctr_data, regset->target)=
;
> +}
> +
> +static void ctr_read_entries(struct cpu_hw_events *cpuc,
> +                            struct perf_event *event,
> +                            unsigned int depth)
> +{
> +       struct ctr_regset entry =3D {};
> +       u64 ctr_ctl;
> +       int i;
> +
> +       ctr_ctl =3D csr_read_clear(CSR_CTRCTL, CTR_BRANCH_ENABLE_BITS);
> +
> +       for (i =3D 0; i < depth; i++) {
> +               if (!capture_ctr_regset(&entry, i))
> +                       break;
> +
> +               ctr_regset_to_branch_entry(cpuc, event, &entry, i);
> +       }
> +
> +       csr_set(CSR_CTRCTL, ctr_ctl & CTR_BRANCH_ENABLE_BITS);
> +
> +       cpuc->branches->branch_stack.nr =3D i;
> +       cpuc->branches->branch_stack.hw_idx =3D 0;
> +}
> +
> +bool riscv_pmu_ctr_valid(struct perf_event *event)
> +{
> +       u64 branch_type =3D event->attr.branch_sample_type;
> +
> +       if (branch_type & ~allowed_filters) {
> +               pr_debug_once("Requested branch filters not supported 0x%=
llx\n",
> +                               branch_type & ~allowed_filters);
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +void riscv_pmu_ctr_consume(struct cpu_hw_events *cpuc, struct perf_event=
 *event)
> +{
> +       unsigned int depth =3D to_riscv_pmu(event->pmu)->ctr_depth;
> +
> +       ctr_read_entries(cpuc, event, depth);
> +
> +       /* Clear frozen bit. */
> +       csr_clear(CSR_SCTRSTATUS, SCTRSTATUS_FROZEN);
> +}
> +
> +static void riscv_pmu_ctr_clear(void)
> +{
> +       /* FIXME: Replace with sctrclr instruction once support is merged
> +        * into toolchain.
> +        */
> +       asm volatile(".4byte 0x10400073\n" ::: "memory");
> +       csr_write(CSR_SCTRSTATUS, 0);
> +}
> +
> +/*
> + * On context switch in, we need to make sure no samples from previous u=
ser
> + * are left in the CTR.
> + *
> + * On ctxswin, sched_in =3D true, called after the PMU has started
> + * On ctxswout, sched_in =3D false, called before the PMU is stopped
> + */

Hi Rajnesh Kanwal,

Thank you for providing this patch set. I have a few questions and
findings about it and would appreciate your help in clarifying them.

> +void riscv_pmu_ctr_sched_task(struct perf_event_pmu_context *pmu_ctx,
> +                             bool sched_in)
> +{
> +       struct riscv_pmu *rvpmu =3D to_riscv_pmu(pmu_ctx->pmu);
> +       struct cpu_hw_events *cpuc =3D this_cpu_ptr(rvpmu->hw_events);
> +
> +       if (cpuc->ctr_users && sched_in)
> +               riscv_pmu_ctr_clear();
> +}
> +

My first question is regarding the context save and restore for the
CTR log. If I understand correctly, I noticed that Intel's LBR
performs context save and restore when PERF_SAMPLE_BRANCH_CALL_STACK
is required. However, it seems that we don't have a similar
implementation. Does our CTR implementation not require context save
and restore for the RASEMU case?

> +void riscv_pmu_ctr_enable(struct perf_event *event)
> +{
> +       struct riscv_pmu *rvpmu =3D to_riscv_pmu(event->pmu);
> +       struct cpu_hw_events *cpuc =3D this_cpu_ptr(rvpmu->hw_events);
> +       u64 branch_type =3D event->attr.branch_sample_type;
> +       u64 ctr;
> +
> +       if (!cpuc->ctr_users++ && !event->total_time_running)
> +               riscv_pmu_ctr_clear();

I ran the entire CTR environment on my side and noticed that the value
of cpuc->ctr_users is likely not 0 at the start of a new trace. I
suspect this might be because we increase cpuc->ctr_users in
riscv_pmu_ctr_enable() and decrease it in riscv_pmu_ctr_disable().
These two PMU CTR functions are called during the pmu->start and
pmu->stop processes. However, in Linux, the number of calls to
pmu->start may not equal the number of calls to pmu->stop, which could
result in cpuc->ctr_users not returning to 0 after a trace completes.
I noticed that in Intel's LBR implementation, cpuc->ctr_users++ is
incremented during the pmu->add process instead of pmu->start process.
Perhaps we could consider referencing their implementation to address
this issue.


> +
> +       ctr =3D branch_type_to_ctr(branch_type);
> +       csr_write(CSR_CTRCTL, ctr);
> +
> +       perf_sched_cb_inc(event->pmu);
> +}
> +
> +void riscv_pmu_ctr_disable(struct perf_event *event)
> +{
> +       struct riscv_pmu *rvpmu =3D to_riscv_pmu(event->pmu);
> +       struct cpu_hw_events *cpuc =3D this_cpu_ptr(rvpmu->hw_events);
> +
> +       /* Clear CTRCTL to disable the recording. */
> +       csr_write(CSR_CTRCTL, 0);
> +
> +       cpuc->ctr_users--;
> +       WARN_ON_ONCE(cpuc->ctr_users < 0);
> +

When I tested this patch, I also encountered a situation where
cpuc->ctr_users became less than 0. The issue might be due to
riscv_pmu_del calling ctr_stop twice with different flags. However, in
rvpmu_ctr_stop, we call riscv_pmu_ctr_disable() without considering
the input flag. This could lead to cpuc->ctr_users becoming a negative
value.

Thanks,
Vincent
> +       perf_sched_cb_dec(event->pmu);
> +}
> +
> +/*
> + * Check for hardware supported perf filters here. To avoid missing
> + * any new added filter in perf, we do a BUILD_BUG_ON check, so make sur=
e
> + * to update CTR_ALLOWED_BRANCH_FILTERS or CTR_EXCLUDE_BRANCH_FILTERS
> + * defines when adding support for it in below function.
> + */
> +static void __init check_available_filters(void)
> +{
> +       u64 ctr_ctl;
> +
> +       /*
> +        * Ensure both perf branch filter allowed and exclude
> +        * masks are always in sync with the generic perf ABI.
> +        */
> +       BUILD_BUG_ON(CTR_PERF_BRANCH_FILTERS !=3D (PERF_SAMPLE_BRANCH_MAX=
 - 1));
> +
> +       allowed_filters =3D PERF_SAMPLE_BRANCH_USER      |
> +                         PERF_SAMPLE_BRANCH_KERNEL    |
> +                         PERF_SAMPLE_BRANCH_ANY       |
> +                         PERF_SAMPLE_BRANCH_HW_INDEX  |
> +                         PERF_SAMPLE_BRANCH_NO_FLAGS  |
> +                         PERF_SAMPLE_BRANCH_NO_CYCLES |
> +                         PERF_SAMPLE_BRANCH_TYPE_SAVE;
> +
> +       csr_write(CSR_CTRCTL, ~0);
> +       ctr_ctl =3D csr_read(CSR_CTRCTL);
> +
> +       if (riscv_isa_extension_available(NULL, h))
> +               allowed_filters |=3D PERF_SAMPLE_BRANCH_HV;
> +
> +       if (ctr_ctl & (CTRCTL_INDCALL_INH | CTRCTL_DIRCALL_INH))
> +               allowed_filters |=3D PERF_SAMPLE_BRANCH_ANY_CALL;
> +
> +       if (ctr_ctl & (CTRCTL_RET_INH | CTRCTL_TRETINH))
> +               allowed_filters |=3D PERF_SAMPLE_BRANCH_ANY_RETURN;
> +
> +       if (ctr_ctl & CTRCTL_INDCALL_INH)
> +               allowed_filters |=3D PERF_SAMPLE_BRANCH_IND_CALL;
> +
> +       if (ctr_ctl & CTRCTL_TKBRINH)
> +               allowed_filters |=3D PERF_SAMPLE_BRANCH_COND;
> +
> +       if (ctr_ctl & CTRCTL_RASEMU)
> +               allowed_filters |=3D PERF_SAMPLE_BRANCH_CALL_STACK;
> +
> +       if (ctr_ctl & (CTRCTL_INDOJUMP_INH | CTRCTL_INDJUMP_INH))
> +               allowed_filters |=3D PERF_SAMPLE_BRANCH_IND_JUMP;
> +
> +       if (ctr_ctl & CTRCTL_DIRCALL_INH)
> +               allowed_filters |=3D PERF_SAMPLE_BRANCH_CALL;
> +}
> +
> +void riscv_pmu_ctr_starting_cpu(void)
> +{
> +       if (!riscv_isa_extension_available(NULL, SxCTR) ||
> +           !riscv_isa_extension_available(NULL, SSCOFPMF) ||
> +           !riscv_isa_extension_available(NULL, SxCSRIND))
> +               return;
> +
> +       /* Set depth to maximum. */
> +       csr_write(CSR_SCTRDEPTH, SCTRDEPTH_MASK);
> +}
> +
> +void riscv_pmu_ctr_dying_cpu(void)
> +{
> +       if (!riscv_isa_extension_available(NULL, SxCTR) ||
> +           !riscv_isa_extension_available(NULL, SSCOFPMF) ||
> +           !riscv_isa_extension_available(NULL, SxCSRIND))
> +               return;
> +
> +       /* Clear and reset CTR CSRs. */
> +       csr_write(CSR_SCTRDEPTH, 0);
> +       csr_write(CSR_CTRCTL, 0);
> +       riscv_pmu_ctr_clear();
> +}
> +
> +void __init riscv_pmu_ctr_init(struct riscv_pmu *riscv_pmu)
> +{
> +       if (!riscv_isa_extension_available(NULL, SxCTR) ||
> +           !riscv_isa_extension_available(NULL, SSCOFPMF) ||
> +           !riscv_isa_extension_available(NULL, SxCSRIND))
> +               return;
> +
> +       check_available_filters();
> +
> +       /* Set depth to maximum. */
> +       csr_write(CSR_SCTRDEPTH, SCTRDEPTH_MASK);
> +       riscv_pmu->ctr_depth =3D ctr_get_depth(csr_read(CSR_SCTRDEPTH));
> +
> +       pr_info("Perf CTR available, with %d depth\n", riscv_pmu->ctr_dep=
th);
> +}
> +
> +void __init riscv_pmu_ctr_finish(struct riscv_pmu *riscv_pmu)
> +{
> +       if (!riscv_pmu_ctr_supported(riscv_pmu))
> +               return;
> +
> +       csr_write(CSR_SCTRDEPTH, 0);
> +       csr_write(CSR_CTRCTL, 0);
> +       riscv_pmu_ctr_clear();
> +       riscv_pmu->ctr_depth =3D 0;
> +}
> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pm=
u.h
> index 5a6b840018bd..455d2386936f 100644
> --- a/include/linux/perf/riscv_pmu.h
> +++ b/include/linux/perf/riscv_pmu.h
> @@ -104,6 +104,39 @@ struct riscv_pmu *riscv_pmu_alloc(void);
>  int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 *num_hw_ctr);
>  #endif
>
> +static inline bool riscv_pmu_ctr_supported(struct riscv_pmu *pmu)
> +{
> +       return !!pmu->ctr_depth;
> +}
> +
>  #endif /* CONFIG_RISCV_PMU_COMMON */
>
> +#ifdef CONFIG_RISCV_CTR
> +
> +bool riscv_pmu_ctr_valid(struct perf_event *event);
> +void riscv_pmu_ctr_consume(struct cpu_hw_events *cpuc, struct perf_event=
 *event);
> +void riscv_pmu_ctr_sched_task(struct perf_event_pmu_context *pmu_ctx, bo=
ol sched_in);
> +void riscv_pmu_ctr_enable(struct perf_event *event);
> +void riscv_pmu_ctr_disable(struct perf_event *event);
> +void riscv_pmu_ctr_dying_cpu(void);
> +void riscv_pmu_ctr_starting_cpu(void);
> +void riscv_pmu_ctr_init(struct riscv_pmu *riscv_pmu);
> +void riscv_pmu_ctr_finish(struct riscv_pmu *riscv_pmu);
> +
> +#else
> +
> +static inline bool riscv_pmu_ctr_valid(struct perf_event *event) { retur=
n false; }
> +static inline void riscv_pmu_ctr_consume(struct cpu_hw_events *cpuc,
> +                                     struct perf_event *event) { }
> +static inline void riscv_pmu_ctr_sched_task(struct perf_event_pmu_contex=
t *,
> +                                           bool sched_in) { }
> +static inline void riscv_pmu_ctr_enable(struct perf_event *event) { }
> +static inline void riscv_pmu_ctr_disable(struct perf_event *event) { }
> +static inline void riscv_pmu_ctr_dying_cpu(void) { }
> +static inline void riscv_pmu_ctr_starting_cpu(void) { }
> +static inline void riscv_pmu_ctr_init(struct riscv_pmu *riscv_pmu) { }
> +static inline void riscv_pmu_ctr_finish(struct riscv_pmu *riscv_pmu) { }
> +
> +#endif /* CONFIG_RISCV_CTR */
> +
>  #endif /* _RISCV_PMU_H */
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

