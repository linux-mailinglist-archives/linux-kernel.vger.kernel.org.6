Return-Path: <linux-kernel+bounces-224615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5979124D1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD07C281F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362C7174EDB;
	Fri, 21 Jun 2024 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="cT3azjG5"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09648139CE5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718971847; cv=none; b=ALxjpD90rSVLCciZ0YDGtIiL7W5Fb88cbHZz+9/ccNyIfCDMgRgJMCXMCvHzibRitkhkK1HlXJq5/P0REhKiWcfFEUfS9Alm5MDQTAyfnCadQLSr+9EQDuYQ8jhZYthZK/TWf/5YIWQbCyyEHBx3aEKyXZXZu4Mn6rhs8EV0Pp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718971847; c=relaxed/simple;
	bh=hYfb0a3eCGf8ykplVBIG1npqvx5J/IHFUDDQGZ2qm0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E93phv7LISBsxMvMgaMCM4gtPasYtzVr3oVP+0b5HhdzkRlgDVgjtreguGNzYeV26yfKKy4K2akpMRiE/N/6L3UTkQv1NSPn7f9uspQlaplCzqQYOBTliIV5be51xoXJ8DHRjVKIiytdwIxj22DnCf5KSq4jYireugjaTYGQs08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=cT3azjG5; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-375858224adso6478845ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1718971845; x=1719576645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXUId7BgiOrJKlvj4EXPaiwGxRE3QDT7xYFFY6+6a4g=;
        b=cT3azjG5elplraJ1w5TkxKPn9Og1JS4tB7eQlziMFNSjltVT5P7D53Jl4uKyDTGZWS
         rKrNJLCKpSuVCvwle5G/aGFtoLujR9LX9q5dPn2Nh8A3qZiIev1+JugjqvnoN3Osj1hu
         ZTeZa8EFkiBhJsV6qBb+GxGoXNaOGyRxFh1c4Kzlyu+4M/G4SqsaMGKpbnZdQ+S442GK
         ukBrDb/FPJpJ3FItm9FAw9IVNgPA7vsQAVsazFipFBL1Fm57sdmZiTE/QXG0xGsLS6tF
         dlkBWLRr8A0WRiOQXSuwxtqZCa9MMqIQLEf6I1WYFfObEMzXfV7tysdjIR2QIISDqgFH
         ocyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718971845; x=1719576645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXUId7BgiOrJKlvj4EXPaiwGxRE3QDT7xYFFY6+6a4g=;
        b=pN4TDwa31PgxwS1ZTtaYTCV19YjGnIgPOdNVqSWMnZFN8EcXdSXYFSH3V2w0eeliBW
         e2XAJdmBVYySPji/6jMYcRnduLawqIbdFZcPU/F0+IpxqUH8pGJo1izyNAdupKIJPt07
         eRU1U98sWLXpSUz2nd1oaojHwMMJLshlnXA3rOQq3rD7r666i/Uib9ss/vKw5wex4Ds9
         dW0AzpKd8VxXVhHqH89r18L278J7OMmJtlz17aLENCmHKSGK2O0c5uzEEiK8IS+81ZDq
         LFVqWpjfK2ktTxs6lu+HKvNvreAPqoKz5kd8YyB6BY6L2tYV/oR0zbZYe4BvDLTJlD95
         VzpA==
X-Forwarded-Encrypted: i=1; AJvYcCXhgP3tj+/wWE6wlZ2+PUqRwi8K7diJJaC10UCDhDmLoEJT5dBSxc12sCWIuFfMHeHEQAQbpoXWm/KgdCH3BHP5G+AsnqKolDqoynAy
X-Gm-Message-State: AOJu0YxKTtN0xjmv9CdIINsJK+CPm3o4Wi++mYNE6axZR+I1KXN4cbn1
	3bsNRdD5R4K1buwLEeFIyaHFcugUezjxmeqr7mpKsj2m2JXmHzi1PAa4VQkiSUQ7euC9X2pVHHz
	yf3FD7WyGXzl/csNCLu+20E7Pf6G7W6JeKClwUg==
X-Google-Smtp-Source: AGHT+IE+Q+KOOE0S07ldQyv/lyyHoya7PZRDhlWazWZX8wdUbyDfKI4hFTF8xA69bxE3aHWLPp9UAq+n4zkSLmp8Cqc=
X-Received: by 2002:a05:6e02:1fc9:b0:375:c240:e7a6 with SMTP id
 e9e14a558f8ab-3761d70b3f1mr87707435ab.24.1718971845149; Fri, 21 Jun 2024
 05:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621113143.35827-1-cuiyunhui@bytedance.com>
In-Reply-To: <20240621113143.35827-1-cuiyunhui@bytedance.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 21 Jun 2024 17:40:34 +0530
Message-ID: <CAAhSdy2wU2NCXAJ_muYTkxxx4YECis2HWwRf55u3nuAtNBDVfA@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Provide the frequency of time CSR via hwprobe
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, cleger@rivosinc.com, evan@rivosinc.com, 
	conor.dooley@microchip.com, costa.shul@redhat.com, andy.chiu@sifive.com, 
	samitolvanen@google.com, linux-doc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 5:03=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.com=
> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> A handful of user-visible behavior is based on the frequency of the
> time CSR.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  Documentation/arch/riscv/hwprobe.rst  | 2 ++
>  arch/riscv/include/asm/hwprobe.h      | 2 +-
>  arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>  arch/riscv/kernel/sys_hwprobe.c       | 5 +++++
>  4 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/ri=
scv/hwprobe.rst
> index fc015b452ebf..c07f159d8906 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -229,3 +229,5 @@ The following keys are defined:
>
>  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
>    represents the size of the Zicboz block in bytes.
> +
> +* :c:macro:`RISCV_HWPROBE_KEY_TIME_CSR_FREQ`: Frequency (in Hz) of `mtim=
e`.
> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hw=
probe.h
> index 630507dff5ea..150a9877b0af 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -8,7 +8,7 @@
>
>  #include <uapi/asm/hwprobe.h>
>
> -#define RISCV_HWPROBE_MAX_KEY 6
> +#define RISCV_HWPROBE_MAX_KEY 7
>
>  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>  {
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/u=
api/asm/hwprobe.h
> index 7b95fadbea2a..18754341ff14 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -73,6 +73,7 @@ struct riscv_hwprobe {
>  #define                RISCV_HWPROBE_MISALIGNED_UNSUPPORTED    (4 << 0)
>  #define                RISCV_HWPROBE_MISALIGNED_MASK           (7 << 0)
>  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE    6
> +#define RISCV_HWPROBE_KEY_TIME_CSR_FREQ        7
>  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>
>  /* Flags */
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwpr=
obe.c
> index 83fcc939df67..fc3b40fb9def 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -8,6 +8,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/cpufeature.h>
>  #include <asm/hwprobe.h>
> +#include <asm/delay.h>
>  #include <asm/sbi.h>
>  #include <asm/switch_to.h>
>  #include <asm/uaccess.h>
> @@ -226,6 +227,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *p=
air,
>                         pair->value =3D riscv_cboz_block_size;
>                 break;
>
> +       case RISCV_HWPROBE_KEY_TIME_CSR_FREQ:
> +               pair->value =3D riscv_timebase;
> +               break;
> +
>         /*
>          * For forward compatibility, unknown keys don't fail the whole
>          * call, but get their element key set to -1 and value set to 0
> --
> 2.20.1
>
>

