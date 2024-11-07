Return-Path: <linux-kernel+bounces-400095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6237E9C08E4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F76283B9C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26848212636;
	Thu,  7 Nov 2024 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSbvVyUb"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7A9210196
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989842; cv=none; b=nqAPSBr2Sh9GCdCBhjUNes4w1ztEbt6SiCMqid3hhUZRfopblz204nJmEZYl/gUCDxuUrYE+wD3UAeRA1/pr5ZZk6FG+fofrOG5HgFdBKnoWilQyCLoRH5wibpzlTbs2zay4Mo+A8KDnFxBsQRmRc2HAlwgfm2Qcp2lFCsGD8Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989842; c=relaxed/simple;
	bh=sdGTUri1lVHykOQAAeLHrGp/uqnc/rwpLtrKKq8QQuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAFNT56BWhJd61SZGQ/9pLk2EubYW+rep/F2MNeQu3/j8t9/ZaFZjDZ5XNWPBfEHGBI1FqzasCz4bR18YoR2RHEhEhnhG/YeHShmrWeqVjDKaERUt8pCMniZo1+w3TKnxHso9qC3mgm7EBmKSPCLZ7EEyUhPpcrc7BTKGaGSi4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSbvVyUb; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb470a8b27so20159321fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 06:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730989838; x=1731594638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3DzRFO1j10BZCdzNgBY0f8TIGH1g3i6yXo3itiQA+E=;
        b=JSbvVyUb3nCQgy0uMsa9YROY0v5/NbX+XZKFnc2lr6487Z0E7YnI/1pHxs1lH5qWHf
         oYcec/ECGYu54ibE9y4+xjuPv+TxsMyaOxpVkRDqjaadQSsb/XCAlq/uqpDLcqR59Bo/
         727idcRQF6fqQOg3U/HMaUUt0M7p0hpGveV2eAh4VIr5IINAfSykN5B14q+aL7ubSx5S
         On3S5KsopaVdwyEuPWPYEA1oxzVk5zEscF7F27aJMdn1ZPLiJjhD1lIiUJ8B5eouOWMZ
         pteSSSAsAGOlrRY6f8U34E7TACpvU1Fqc3GXssLfWZzSozkpRLqvR3zRhoEhwzFgerdQ
         CuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730989838; x=1731594638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3DzRFO1j10BZCdzNgBY0f8TIGH1g3i6yXo3itiQA+E=;
        b=CBa0KYxeJHH9PT8YoFwFyYUVWtsg1Re2I0YTCpxFywfLiPejoIPF6SsPthxWP6QlKC
         FEX082tFxCwoNgvWVv/Nn6HZmj6xx50Tb2a1+7/9AlBU+5atw3IDSCeGxFvWTBev0MPC
         x6YO3nW131c0IdOapRKrMz4DDSnnFNQ2w66pcQhXay+qo4bEPnlQ8b4U939cRGF3D9Ow
         UORABzyChmWb+DLl6mJP4J5adBmltpMjHDY7moH6Ea9nj+VyAsianPfl612BhIAPdGFT
         xC+mshHYAGoahJDyELn1Wp1d5Cy9RpT6MKjsOzF8du12eiARYE7Gaz60f7/OBYKgMWm+
         BhcQ==
X-Gm-Message-State: AOJu0YwijkN01krssIvA2WrW2gAJWfxnj9KEKOGGsg+hblAusY5YQZbJ
	HBK1vAGWkpNmpG3zVwR/H0XyBczzTueeSLK0rMK+8nBPbKy3zMTbS49M0IcilQpGHt0PycYGPxb
	svAijl3CHwnkdNJ3r+rZ3RG2WG/A=
X-Google-Smtp-Source: AGHT+IGgSyaarGGvCbE/nD3rQQTNPlY5f1CWNSjxwV6FbfjWZzSk+RTRw7sgBh5ZSJeTHLrO2EZStSq/tpCCRaB0u3Q=
X-Received: by 2002:a05:651c:150b:b0:2fb:5be4:3645 with SMTP id
 38308e7fff4ca-2ff1e808cfamr1000311fa.0.1730989837803; Thu, 07 Nov 2024
 06:30:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <20241105155801.1779119-6-brgerst@gmail.com>
In-Reply-To: <20241105155801.1779119-6-brgerst@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 7 Nov 2024 15:30:26 +0100
Message-ID: <CAFULd4ZAFuGMdkXz_Lu0vrQHQG4CSgaJzuGSdM0abPpNOO8cPg@mail.gmail.com>
Subject: Re: [PATCH v5 05/16] x86/pvh: Use fixed_percpu_data for early boot GSBASE
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 4:58=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wrot=
e:
>
> Instead of having a private area for the stack canary, use
> fixed_percpu_data for GSBASE like the native kernel.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---

This patch looks like it could be submitted independently of the main
series and should include XEN maintainers (CC'd).

Uros.

>  arch/x86/platform/pvh/head.S | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
> index 64fca49cd88f..b0a9a58952aa 100644
> --- a/arch/x86/platform/pvh/head.S
> +++ b/arch/x86/platform/pvh/head.S
> @@ -159,10 +159,15 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
>  1:
>         UNWIND_HINT_END_OF_STACK
>
> -       /* Set base address in stack canary descriptor. */
> -       mov $MSR_GS_BASE,%ecx
> -       leal canary(%rip), %eax
> -       xor %edx, %edx
> +       /*
> +        * Set up GSBASE.
> +        * Note that, on SMP, the boot cpu uses init data section until
> +        * the per cpu areas are set up.
> +        */
> +       movl $MSR_GS_BASE,%ecx
> +       leaq INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
> +       movq %edx, %eax
> +       shrq $32, %rdx
>         wrmsr
>
>         /*
> @@ -232,8 +237,6 @@ SYM_DATA_START_LOCAL(gdt_start)
>  SYM_DATA_END_LABEL(gdt_start, SYM_L_LOCAL, gdt_end)
>
>         .balign 16
> -SYM_DATA_LOCAL(canary, .fill 48, 1, 0)
> -
>  SYM_DATA_START_LOCAL(early_stack)
>         .fill BOOT_STACK_SIZE, 1, 0
>  SYM_DATA_END_LABEL(early_stack, SYM_L_LOCAL, early_stack_end)
> --
> 2.47.0
>

