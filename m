Return-Path: <linux-kernel+bounces-208063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FC5902021
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6218A1F21F11
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BA47BAE3;
	Mon, 10 Jun 2024 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QUvHbJY6"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6238874C14
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718017800; cv=none; b=FD3Vf+id7+WnqTAZ2xDT/96e1o++3HcZnBGCIgcO1yJBJYWHiza/NHBh5iOKHUrew15Lu8lZ+lknYR9gO9y9CxEwASiFUK71kj08efglx/8cUhgtJ80G8fxuBz8E3tbAvBk/JbPfYZueQpFkRe4bC6/DoZfT+0U37FrfB18DQYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718017800; c=relaxed/simple;
	bh=8C6pLA7BjzKwJzNCufqiUtuF8G+MiFoWgewXtYg1WMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vnkh8/wV+CmEmRY74K3AyNl9yBJIoakCWQt5bNLBGEe+gNzVgydBpApwjl86Vm9sWVHE/C8ZMHNlyLNxWFMl+lq5Wl2r5UAneiljHyuv/6KCRnmTiiAcvAWM65rLz2ATSaacFt4fOVlNXdgaDPiMgCmkvLEoxfnPkUzMTmvCKAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QUvHbJY6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42179dafd6bso11464965e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 04:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718017795; x=1718622595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Prk73DnmPJ51cZiVZTBIXtupptZ0v+zxwxhwZVetsmM=;
        b=QUvHbJY6JcLEtw3//8kz/gdzJi3+588XwMPXRtZz3l5iEVzTiKzztOOldIuXXZApjf
         1JzdFxB79D+FhyMh9Zc9kflCRTynbd3Y2mXTH9ljpJpdtdz9KyYCetHwme9fqWaVzn+Q
         7XRhyhMufk7DhbFZelr7qjoDDfmJ8wtXdPRPh2uBC4RIZydgcGls1qODj9wRIFADNABN
         DNzJ4pFix8xA8Rm7HqOXst6p8HbRGrsfFR7Mwh+lCKpz4ys/JoC/KFrQJkqWMnFg0SK7
         +tuL5N+94OpSktTufPuFFnEQwT7u0rD2z9URwWE+a4QMg2vQUrEzmUNj6jEVIzTa0BaS
         pzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718017795; x=1718622595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Prk73DnmPJ51cZiVZTBIXtupptZ0v+zxwxhwZVetsmM=;
        b=CoFIPq+0mdjv8BAGfyBpksHH+3NLUlnRCHPf/a+kytGlx1E2+mcjLRu0GI6Pk3T83d
         VTCgYd7ZnzYQM7Auh/RfvMRgiXMZUZFQwdQDUfINM92PsSzps0DbaX22d9DmtHiVqBWW
         sHjfc9u6OG2skNuqg2nESbl7wz63/VZ8O5mVgVWyvdz7YW+G8v0dU/fexOT6G7Qa5X0F
         60UtAnBtZx35Z0NCWZTKh8qK/RrzFxYLTMWg5643z6uUEAe9nPmQaDpGuPAgaRLH/PBO
         dXb63br5541hUazld4tVrOu4X2rt4tqI73UPZ6QjNkK7+tUg5+OcdX1zHCwgzdPEIfsj
         lhCw==
X-Gm-Message-State: AOJu0Ywle63qWUjFyshXgm8qImShO4QySCq9jETXl5dfixf4FmtsqJzb
	EqLKlmZoIw3Az+dESkjyg2LdDW62yRr7r1jxA0/cJRB2ckA73BS2AdxD6rq/ReV6XqTukL/LN96
	RsfynU2tD0jRW28PIYBPaqlkifP2Uc16wibp3sMHpNpZYip6s
X-Google-Smtp-Source: AGHT+IHDrzvkYTQO7a1HswOxY54QWUnr1lL0+aFtNp8beJCPB7XJGXVKY971cEuujaGhdfBQBjgtOJxj99AGY9+QH2o=
X-Received: by 2002:a05:600c:4f07:b0:421:661d:89d6 with SMTP id
 5b1f17b1804b1-421661d8dacmr84761065e9.14.1718017795456; Mon, 10 Jun 2024
 04:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529185337.182722-1-rkanwal@rivosinc.com> <20240529185337.182722-3-rkanwal@rivosinc.com>
 <20240605-manila-exploit-d7191ec7a4bc@spud>
In-Reply-To: <20240605-manila-exploit-d7191ec7a4bc@spud>
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
Date: Mon, 10 Jun 2024 12:09:44 +0100
Message-ID: <CAECbVCumdNKLqRO8yvgo7PWEmw7P1OvyX88cF5JdYefSQQY9tQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/6] riscv: perf: Add Control transfer records CSR definations.
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-riscv@lists.infradead.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ajones@ventanamicro.com, 
	anup@brainfault.org, acme@kernel.org, atishp@rivosinc.com, 
	beeman@rivosinc.com, brauner@kernel.org, heiko@sntech.de, irogers@google.com, 
	mingo@redhat.com, james.clark@arm.com, renyu.zj@linux.alibaba.com, 
	jolsa@kernel.org, jisheng.teoh@starfivetech.com, palmer@dabbelt.com, 
	tech-control-transfer-records@lists.riscv.org, will@kernel.org, 
	kaiwenxue1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 7:03=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Wed, May 29, 2024 at 07:53:33PM +0100, Rajnesh Kanwal wrote:
> > Adding CSR defines for RISCV Control Transfer Records extension [0]
> > along with bit-field macros for each CSR.
> >
> > [0]: https://github.com/riscv/riscv-control-transfer-records
> >
> > Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/csr.h | 83 ++++++++++++++++++++++++++++++++++++
>
> This patch isn't for perf, so $subject is a bit misleading.
>
> Thanks,
> Conor.

Sorry, my bad. I will fix this in the next series.

- Rajnesh

>
> >  1 file changed, 83 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.=
h
> > index 701963b64fc4..a80a2ee9d44e 100644
> > --- a/arch/riscv/include/asm/csr.h
> > +++ b/arch/riscv/include/asm/csr.h
> > @@ -309,6 +309,85 @@
> >
> >  #define CSR_SSCOUNTOVF               0xda0
> >
> > +/* M-mode Control Transfer Records CSRs */
> > +#define CSR_MCTRCTL          0x34e
> > +
> > +/* S-mode Control Transfer Records CSRs */
> > +#define CSR_SCTRCTL          0x14e
> > +#define CSR_SCTRSTATUS               0x14f
> > +#define CSR_SCTRDEPTH                0x15f
> > +
> > +/* VS-mode Control Transfer Records CSRs */
> > +#define CSR_VSCTRCTL         0x24e
> > +
> > +/* xctrtl CSR bits. */
> > +#define CTRCTL_U_ENABLE              _AC(0x1, UL)
> > +#define CTRCTL_S_ENABLE              _AC(0x2, UL)
> > +#define CTRCTL_M_ENABLE              _AC(0x4, UL)
> > +#define CTRCTL_RASEMU                _AC(0x80, UL)
> > +#define CTRCTL_STE           _AC(0x100, UL)
> > +#define CTRCTL_MTE           _AC(0x200, UL)
> > +#define CTRCTL_BPFRZ         _AC(0x800, UL)
> > +#define CTRCTL_LCOFIFRZ              _AC(0x1000, UL)
> > +#define CTRCTL_EXCINH                _AC(0x200000000, UL)
> > +#define CTRCTL_INTRINH               _AC(0x400000000, UL)
> > +#define CTRCTL_TRETINH               _AC(0x800000000, UL)
> > +#define CTRCTL_NTBREN                _AC(0x1000000000, UL)
> > +#define CTRCTL_TKBRINH               _AC(0x2000000000, UL)
> > +#define CTRCTL_INDCALL_INH   _AC(0x10000000000, UL)
> > +#define CTRCTL_DIRCALL_INH   _AC(0x20000000000, UL)
> > +#define CTRCTL_INDJUMP_INH   _AC(0x40000000000, UL)
> > +#define CTRCTL_DIRJUMP_INH   _AC(0x80000000000, UL)
> > +#define CTRCTL_CORSWAP_INH   _AC(0x100000000000, UL)
> > +#define CTRCTL_RET_INH               _AC(0x200000000000, UL)
> > +#define CTRCTL_INDOJUMP_INH  _AC(0x400000000000, UL)
> > +#define CTRCTL_DIROJUMP_INH  _AC(0x800000000000, UL)
> > +
> > +/* sctrstatus CSR bits. */
> > +#define SCTRSTATUS_WRPTR_MASK        0xFF
> > +#define SCTRSTATUS_FROZEN    _AC(0x80000000, UL)
> > +
> > +#ifdef CONFIG_RISCV_M_MODE
> > +#define CTRCTL_KERNEL_ENABLE CTRCTL_M_ENABLE
> > +#else
> > +#define CTRCTL_KERNEL_ENABLE CTRCTL_S_ENABLE
> > +#endif
> > +
> > +/* sctrdepth CSR bits. */
> > +#define SCTRDEPTH_MASK               0x7
> > +
> > +#define SCTRDEPTH_MIN                0x0 /* 16 Entries. */
> > +#define SCTRDEPTH_MAX                0x4 /* 256 Entries. */
> > +
> > +/* ctrsource, ctrtarget and ctrdata CSR bits. */
> > +#define CTRSOURCE_VALID              0x1ULL
> > +#define CTRTARGET_MISP               0x1ULL
> > +
> > +#define CTRDATA_TYPE_MASK    0xF
> > +#define CTRDATA_CCV          0x8000
> > +#define CTRDATA_CCM_MASK     0xFFF0000
> > +#define CTRDATA_CCE_MASK     0xF0000000
> > +
> > +#define CTRDATA_TYPE_NONE                    0
> > +#define CTRDATA_TYPE_EXCEPTION                       1
> > +#define CTRDATA_TYPE_INTERRUPT                       2
> > +#define CTRDATA_TYPE_TRAP_RET                        3
> > +#define CTRDATA_TYPE_NONTAKEN_BRANCH         4
> > +#define CTRDATA_TYPE_TAKEN_BRANCH            5
> > +#define CTRDATA_TYPE_RESERVED_6                      6
> > +#define CTRDATA_TYPE_RESERVED_7                      7
> > +#define CTRDATA_TYPE_INDIRECT_CALL           8
> > +#define CTRDATA_TYPE_DIRECT_CALL             9
> > +#define CTRDATA_TYPE_INDIRECT_JUMP           10
> > +#define CTRDATA_TYPE_DIRECT_JUMP             11
> > +#define CTRDATA_TYPE_CO_ROUTINE_SWAP         12
> > +#define CTRDATA_TYPE_RETURN                  13
> > +#define CTRDATA_TYPE_OTHER_INDIRECT_JUMP     14
> > +#define CTRDATA_TYPE_OTHER_DIRECT_JUMP               15
> > +
> > +#define CTR_ENTRIES_FIRST    0x200
> > +#define CTR_ENTRIES_LAST     0x2ff
> > +
> >  #define CSR_SSTATUS          0x100
> >  #define CSR_SIE                      0x104
> >  #define CSR_STVEC            0x105
> > @@ -490,6 +569,8 @@
> >  # define CSR_TOPEI   CSR_MTOPEI
> >  # define CSR_TOPI    CSR_MTOPI
> >
> > +# define CSR_CTRCTL     CSR_MCTRCTL
> > +
> >  # define SR_IE               SR_MIE
> >  # define SR_PIE              SR_MPIE
> >  # define SR_PP               SR_MPP
> > @@ -520,6 +601,8 @@
> >  # define CSR_TOPEI   CSR_STOPEI
> >  # define CSR_TOPI    CSR_STOPI
> >
> > +# define CSR_CTRCTL     CSR_SCTRCTL
> > +
> >  # define SR_IE               SR_SIE
> >  # define SR_PIE              SR_SPIE
> >  # define SR_PP               SR_SPP
> > --
> > 2.34.1
> >

