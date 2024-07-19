Return-Path: <linux-kernel+bounces-257655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83515937D10
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 21:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4211F2286C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 19:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF76F1487F7;
	Fri, 19 Jul 2024 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1qLf8wa8"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE1F145B25
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721419028; cv=none; b=PsG309LTn1306ugyvXLIfZD6fuYwUFr8EWARJW7tMpqq324MHKZhph0faoSrKQ9xRoQ5/N5HXV7EQxabnugM8UnrrMyBp632sbSqJ5fbmLNJ//muRfRp43dwHp2ZyvJE+Ml+X7oDqkMHv3MPoik72VexNFyUd0kNsj4429ZpfMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721419028; c=relaxed/simple;
	bh=KkB0LKiiP3HMvRIhfAm3yM0pM8vg+pJ5iOZIl++tVg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snkiwjwTxmekNYHa0kUuAmqvztm+T8IROxJ3K4SmfGr2XhsFOzUY79uY77V85q86RvvfG9PaXXRnhd0cWLYIMn82tEt+PNBgK8VLN9gXL+JUOSFF3Al/w+wP87B25FiSo2NsQQaY4umi++yGMTTdFDRHrD5iuVX3AGauPCQn5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1qLf8wa8; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77e7420697so265844666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 12:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721419024; x=1722023824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71CBKJ5o7I4cy2JXrEI11tVDU0uyHgYLiRo2v5Mi+QE=;
        b=1qLf8wa8SqVB9/cKN37XVE0lWIlpHdAyBP8a7mRRLI3pAqYmQ7RJOvkDJxnXoBHiXy
         xaVwN7ZOMyr625FAYcU+YRtcqy+fYx5xmXOv+pybljXyieZcwF02E8PPHV6wmjSx+WUw
         B1WgnuD1EY+mffSkgngJB/ekltneBOFddYU/eWRoyG9gDi1WYtNt5CGjzLb9U/gN4TYq
         NsA7ymp1ikPnReY23mOKqrlC2R3xv9Idg/5e6g5aVJzs17kEXYqnKEPTcoZiWZDdSC63
         pHfU1OButbMpStpd9IclcR0/rap54Wyz56CBwbrsF7J1r/BAg3nyDgX7sJWQj7TI++Zg
         bJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721419024; x=1722023824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71CBKJ5o7I4cy2JXrEI11tVDU0uyHgYLiRo2v5Mi+QE=;
        b=iVVW2DtvmlDXZh/AUTs/njcVmDvbslgXSCICgB3eljJwjxAecF9V+zrZ3ybhnUHk4j
         xTy/2WvmdJNQhRZz5/Mqxfvx70svwwk9kxdkqpYzlBYYVukdvpiEB6ysYpGCnsuXq9Tn
         LAoVZoxF4iyJk0qY8/+jX2/KbyGG/YYdPdSl1SdQEtCk6POsvr10D4U5h/vxSzd0wiMz
         gs9DBv1R94n9GneXBkVaAYmcFd4FE3Xnt8Hafqf+dCYLxazVlwWkhG9x9ohCQUDyJQD5
         ai6ySQVblQOAMampNChgroRLoGSmCgQ4it+O6ef7trhh3GLNFoPczU5VR++u8KxclC8W
         kTpw==
X-Forwarded-Encrypted: i=1; AJvYcCUUL6ziFqeg/jlI6j0GO8JfWnlIqdj3ZIuL9bmJFhS+NS5pyzEcCEB6eD46WW9GGOc9En5syevD0Je3jmtVJs3P1qofZYACEP2taaX+
X-Gm-Message-State: AOJu0Yzp54Rm/LOAkf2WeNv5L10UsqB//yqSICLqI08V9puOJ8+l3E2s
	WGReayBLA1Kdvk5Bsmp6rrD+OdFTUUrdX485o6h7RzB9XfZ/EqwhlbJF6UyyJiLCVBl1wcj905p
	AqpjVoqeiDpPl+8zJexH2qgUFpYhua2webis8xg==
X-Google-Smtp-Source: AGHT+IGMKZ7Id6PZ9k5+krjiDl6iseri2cr1uDlMZ6EwfH9XwMKTFPCtWo++b63LltYV6CLMBQXdC/iIw073Dt+So4w=
X-Received: by 2002:a17:906:fa1a:b0:a6f:b58f:ae3c with SMTP id
 a640c23a62f3a-a7a0116c6acmr543296366b.26.1721419024408; Fri, 19 Jul 2024
 12:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717180727.4180475-1-jesse@rivosinc.com> <20240717180727.4180475-4-jesse@rivosinc.com>
In-Reply-To: <20240717180727.4180475-4-jesse@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 19 Jul 2024 12:56:28 -0700
Message-ID: <CALs-Hst+Wb4MNoN6y+pOF92+MLenGZqhcZUmZW+rW76DTECduA@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] RISC-V: Check scalar unaligned access on all CPUs
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>, 
	Eric Biggers <ebiggers@google.com>, Greentime Hu <greentime.hu@sifive.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Heiko Stuebner <heiko@sntech.de>, Costa Shulyupin <costa.shul@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Anup Patel <apatel@ventanamicro.com>, Zong Li <zong.li@sifive.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Ben Dooks <ben.dooks@codethink.co.uk>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Erick Archer <erick.archer@gmx.com>, Joel Granados <j.granados@samsung.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 11:07=E2=80=AFAM Jesse Taube <jesse@rivosinc.com> w=
rote:
>
> Originally, the check_unaligned_access_emulated_all_cpus function
> only checked the boot hart. This fixes the function to check all
> harts.
>
> Fixes: 71c54b3d169d ("riscv: report misaligned accesses emulation to hwpr=
obe")
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>


> Cc: stable@vger.kernel.org
> ---
> V1 -> V2:
>  - New patch
> V2 -> V3:
>  - Split patch
> V3 -> V4:
>  - Re-add check for a system where a heterogeneous
>     CPU is hotplugged into a previously homogenous
>     system.
> V4 -> V5:
>  - Change work_struct *unused to work_struct *work __always_unused
> ---
>  arch/riscv/kernel/traps_misaligned.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/tra=
ps_misaligned.c
> index b62d5a2f4541..9a1e94383d6d 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -526,11 +526,11 @@ int handle_misaligned_store(struct pt_regs *regs)
>         return 0;
>  }
>
> -static bool check_unaligned_access_emulated(int cpu)
> +static void check_unaligned_access_emulated(struct work_struct *work __a=
lways_unused)
>  {
> +       int cpu =3D smp_processor_id();
>         long *mas_ptr =3D per_cpu_ptr(&misaligned_access_speed, cpu);
>         unsigned long tmp_var, tmp_val;
> -       bool misaligned_emu_detected;
>
>         *mas_ptr =3D RISCV_HWPROBE_MISALIGNED_UNKNOWN;
>
> @@ -538,19 +538,16 @@ static bool check_unaligned_access_emulated(int cpu=
)
>                 "       "REG_L" %[tmp], 1(%[ptr])\n"
>                 : [tmp] "=3Dr" (tmp_val) : [ptr] "r" (&tmp_var) : "memory=
");
>
> -       misaligned_emu_detected =3D (*mas_ptr =3D=3D RISCV_HWPROBE_MISALI=
GNED_EMULATED);
>         /*
>          * If unaligned_ctl is already set, this means that we detected t=
hat all
>          * CPUS uses emulated misaligned access at boot time. If that cha=
nged
>          * when hotplugging the new cpu, this is something we don't handl=
e.
>          */
> -       if (unlikely(unaligned_ctl && !misaligned_emu_detected)) {
> +       if (unlikely(unaligned_ctl && (*mas_ptr !=3D RISCV_HWPROBE_MISALI=
GNED_EMULATED))) {
>                 pr_crit("CPU misaligned accesses non homogeneous (expecte=
d all emulated)\n");
>                 while (true)
>                         cpu_relax();
>         }
> -
> -       return misaligned_emu_detected;
>  }
>
>  bool check_unaligned_access_emulated_all_cpus(void)
> @@ -562,8 +559,11 @@ bool check_unaligned_access_emulated_all_cpus(void)
>          * accesses emulated since tasks requesting such control can run =
on any
>          * CPU.
>          */
> +       schedule_on_each_cpu(check_unaligned_access_emulated);
> +
>         for_each_online_cpu(cpu)
> -               if (!check_unaligned_access_emulated(cpu))
> +               if (per_cpu(misaligned_access_speed, cpu)
> +                   !=3D RISCV_HWPROBE_MISALIGNED_EMULATED)
>                         return false;
>
>         unaligned_ctl =3D true;
> --
> 2.45.2
>

