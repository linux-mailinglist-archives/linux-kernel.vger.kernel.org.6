Return-Path: <linux-kernel+bounces-517447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F9AA38106
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324B71657EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5CB217733;
	Mon, 17 Feb 2025 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="iYQY7nTu"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD21F21771B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789840; cv=none; b=HncDgF5PUnvkxHmTaOqHS3MTfW7Y8gp2ExF5zx50Fws8URNz4BYeIdRLswPzfQ08ZJYI2lREywHY02+xa7qORxSMbPgzdpDjl4c473ToxVqU5sE4ihTcrjLl9a9k/dQxbdRxku4AdcQ2TNC5BMs7m/682IoGJxmPrMcFuSCebd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789840; c=relaxed/simple;
	bh=kDOoIRjHVfHyTXmfCni8DIKhMZzUPwGTSzjeKFPj7pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thdYWIdp/xsqwxIS3Yxcw8WxygbTaS3axvRW8/yWQbDvI1D5kiyqLoIHjsj2fK1qAgCWZ582HbMHxa3ZZkYhsDHdFuY6jQA70H/VqNP0AnY0Ij9A6SSAwrO4Ids06D3nDCbZm+HtHYE2bTJcwRz1W6g5S+O7q4xFWLphhGkKTlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=iYQY7nTu; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d2858ce82fso4670965ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1739789838; x=1740394638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsTtMyTsJbWMVKOlmUKSf/JarHtELa1O22QRRoXh8xk=;
        b=iYQY7nTuMdlP/CofJygSUrvl4TP8sjgmW/RCfsgvNoJjk0maNU+TeHPijjiw2kZFRC
         55diBPrClmBu5u772chLLeSzGCAbVWbNfeDkFSAxo6kInMRpX4gUGBECwZyeeLPpBqEN
         T20Ym7sIbpl4/HEMEVVa+HtV7QF0TWlKbcG4oFg4W55mtW00FNLWiJh6VXpiX8RPKEKc
         4qD9oZi8rtJgMPm/EkB+dXXm5K++cWC6ALhrenN3j7rvDDHT8ZQcTFw6gFg+TCcZqMuS
         wBmyEC4MdKwS2kOCxVrvBOaeUiS90WR7KR1xqiHvK2RunprvamM6NAPzocWsSDdB/uiN
         B3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789838; x=1740394638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsTtMyTsJbWMVKOlmUKSf/JarHtELa1O22QRRoXh8xk=;
        b=DPdtZ7ZJANOZSKHQ5eaV1GTLT6SkUcNeCm/S8NIeCeEINpVunjOvQLnLMcnVGhMMu9
         qBqhqeMs3qsWdJDZjo6gdd5gtk38SvVeviR1ve2jqAecByeNtzEg1aKz3JLSvYgZDgfE
         u9UVLBjB9o7g1r3DE0AeTC5yf4jICErbDkrsG9HkDW9I1DJKnFLbFAGBbi76ULOikrx7
         n4GjbH0bR/G4HX0XdmsfOoVkLqxGDK5bNEcfOF2P6SNlVcNetjDqSOZdxVWkWc0SOrCG
         NrMFX7TxNmfzPSppvGHuMNCXLkRoYJrrwb2hxRqdqCeyn9Cux2fC0FyMczjXYa4kz8uk
         U4Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ3jYyN1YF4Mpzh/F0IUWGr7x4yWg7qQt2o5V1voTqavTMhkowUimNDwJhRazWXgQIqESFadiWFbSH7PI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1y1sAhqLzvIN0BLLUh3nCfXHAyE17xgOySOBpCAaWdUuv/Bvc
	8JvcmQtfiFJFKjcY3b4Afsu4xnd7k7Q4pa/vaa0mkbL4krA/ez2yxg1iIhaslS4p2V5Ax3rankg
	nU+KgCMzs8DRJm/+xMXbyVndxZtyy9JYK0DXnpw==
X-Gm-Gg: ASbGnculo5aXNk3ZLu6FKWuEM9nVLRcDDowjqGAGKG/lO7kW4W2wh9AB5lck3l8KrOw
	ac8X36BVKe4+GDEDYoabT6X8KqiT52VS6bFunr49Hx0DPVWHWUCtysy5VoFk3GPsk6aj/6dooBA
	==
X-Google-Smtp-Source: AGHT+IF4wt3+bCr8smM4abSpg9jynt5wH6JghaDNkG3zGRYN1zSsdl+CZBbn8XESByuGwGBk4yMvzbUqkz5buCnYAwM=
X-Received: by 2002:a05:6e02:20cf:b0:3d1:a3d0:d064 with SMTP id
 e9e14a558f8ab-3d281755de7mr70090045ab.0.1739789837889; Mon, 17 Feb 2025
 02:57:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217084506.18763-7-ajones@ventanamicro.com> <20250217084506.18763-12-ajones@ventanamicro.com>
In-Reply-To: <20250217084506.18763-12-ajones@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 17 Feb 2025 16:27:07 +0530
X-Gm-Features: AWEUYZlXyegh4HuBYLBwZJ9Tly4L0bQenOk0JsQZ_Py81_lO9EAqEQBtXwOwjmo
Message-ID: <CAAhSdy23nJq4Uj9amQ9T4iXtNoCSFLnOjjyp7pm6KdNbH7xkmA@mail.gmail.com>
Subject: Re: [PATCH 5/5] riscv: KVM: Fix SBI sleep_type use
To: Andrew Jones <ajones@ventanamicro.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	atishp@atishpatra.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, cleger@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 2:15=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> The spec says sleep_type is 32 bits wide and "In case the data is
> defined as 32bit wide, higher privilege software must ensure that it
> only uses 32 bit data." Mask off upper bits of sleep_type before
> using it.
>
> Fixes: 023c15151fbb ("RISC-V: KVM: Add SBI system suspend support")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kvm/vcpu_sbi_system.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_system.c b/arch/riscv/kvm/vcpu_sbi_s=
ystem.c
> index 5d55e08791fa..bc0ebba89003 100644
> --- a/arch/riscv/kvm/vcpu_sbi_system.c
> +++ b/arch/riscv/kvm/vcpu_sbi_system.c
> @@ -4,6 +4,7 @@
>   */
>
>  #include <linux/kvm_host.h>
> +#include <linux/wordpart.h>
>
>  #include <asm/kvm_vcpu_sbi.h>
>  #include <asm/sbi.h>
> @@ -19,7 +20,7 @@ static int kvm_sbi_ext_susp_handler(struct kvm_vcpu *vc=
pu, struct kvm_run *run,
>
>         switch (funcid) {
>         case SBI_EXT_SUSP_SYSTEM_SUSPEND:
> -               if (cp->a0 !=3D SBI_SUSP_SLEEP_TYPE_SUSPEND_TO_RAM) {
> +               if (lower_32_bits(cp->a0) !=3D SBI_SUSP_SLEEP_TYPE_SUSPEN=
D_TO_RAM) {
>                         retdata->err_val =3D SBI_ERR_INVALID_PARAM;
>                         return 0;
>                 }
> --
> 2.48.1
>

