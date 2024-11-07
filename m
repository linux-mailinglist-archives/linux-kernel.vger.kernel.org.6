Return-Path: <linux-kernel+bounces-399999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF329C0794
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECB41C22BC9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4321D2144B1;
	Thu,  7 Nov 2024 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh/AWMvw"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82E220B1E2
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986338; cv=none; b=mn1pBSSDgZhcTZYqADouheY6T2uHAS9wBfhKg6MA6zrP3zxyA4KO42Z9+9nEeh1VDZPIOlEEhppcbJ7bQ+ZrzZxjDZFcsTI2zYId92iAc3qLMyAcz5LKUC9jO9no/uQz9FD3Omawfd4WmkfibmiZaHwVe8UyG7Rcz0mGBqS7CNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986338; c=relaxed/simple;
	bh=tPkD4J6rY7ve9cnbZ05ph01GouuTSZvd3dgLr8lmYOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PRf6x+4GTRt6jIBL5rHK9reQ0VFwhKT0MH/9r6tD6+u6goAAVQ7K3jZP97To/v4QbVTlIzZ6M2gsk9beivoOSl7fRqLp+hTUJGqpwRjTxTIlHj4EZAthwXwv7sHMo+MAN2aui2VWN/lWr2gfJFry8RhJBUCD+T236FIjiCIwXBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mh/AWMvw; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so8673821fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 05:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730986335; x=1731591135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zc8V4z+AJhWMVZuPq9zyom6WfdPrbVxGZinkzh7Eqko=;
        b=mh/AWMvwBOsPbzo5vWRh/b99YhAAtVkw0tJW/jOGusMIv9sbcHajCCM4D/8KalLNJ4
         ZkvoopGKD0waDnYmkfPoMSeAjNPD2WTk3alt22OV4/hYrHWJK7FlpJ7uMceLsLXJWmTc
         YqTOXjYkaFLSUE+sB6x8B7OpAYsIoOu1egDT7MI8DW06HacuR17sZ8XjHt36lW9UjfXm
         Lzq48VpXleXhW59mxoVglbX9/1ZKFSXoXCqAPVOcT+GY0FBSDUcVz77ah1Qu4CWAXO5L
         8czHeRbG92OvRB4W4R16IguvLCYDwQgFRuPOh5TYrivWymUGeVKHTlDL1pGnqJywsmn/
         9Czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730986335; x=1731591135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zc8V4z+AJhWMVZuPq9zyom6WfdPrbVxGZinkzh7Eqko=;
        b=tHQ90MM8swLGNSIWDAnSegiqBNWsy7aRVa63hu48hMLnAvAqmBTifX6XpU9l1vmqBj
         H3UCy43orWwx15NbWnFT1pStGO/8GRNBECnm3h8r+bdKAYoQ0pdMi45Ld4LuGKASztq2
         PMQJvjVAyWwcOkGgJdpprKcdVYAG9+zmLVJ+wgGEuZB5peb60D2YDvdJF6foU+WWj6KR
         hrz+6udYSjbtvmTuz1vy3ifxPoQbSBpNdv+2N7OHtrck8ozP/j2mX0Oy9OUnXhsgA4rY
         GkWTfMw/vLwZJCSDyYRDXcnP5awIO0iavmZp9hJhRtqAowj8EOE3K/8IYj8BYWkufvAe
         qg0A==
X-Gm-Message-State: AOJu0YwoPZVZxz0u/4rMdP2ODgXwPgf9Y2NNLCgFegGbpLxFE+lF5C9E
	2TYQmr2BiMphF3XqJl8ieXRACLzBdCYTW4MvuZ4+4mkiFC72r85/PMy2dMYBXB8he3C5LP+65JA
	LIncdA+yUSQd4BS0RJWV/te4E9irYZwMeuCo=
X-Google-Smtp-Source: AGHT+IEl5Xh8EhoV3mk6FoMj+BYeDoxUVFIs42PSjIfjLz7/eXH9K631DlGjzlf7sOmfxoOI0jzKRApmhjB1jzuY+ok=
X-Received: by 2002:a2e:bd0a:0:b0:2fb:4982:daea with SMTP id
 38308e7fff4ca-2ff1a9e15cbmr10475331fa.32.1730986334816; Thu, 07 Nov 2024
 05:32:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <20241105155801.1779119-11-brgerst@gmail.com>
In-Reply-To: <20241105155801.1779119-11-brgerst@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 7 Nov 2024 14:32:03 +0100
Message-ID: <CAFULd4ahndLYEv6+CEkFvrW6L+dRTdA0VeV=WMdHeiBUdtYtOg@mail.gmail.com>
Subject: Re: [PATCH v5 10/16] x86/percpu/64: Remove fixed_percpu_data
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 4:58=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wrot=
e:
>
> Now that the stack protector canary value is a normal percpu variable,
> fixed_percpu_data is unused and can be removed.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>

> ---
>  arch/x86/include/asm/processor.h | 8 --------
>  arch/x86/kernel/cpu/common.c     | 4 ----
>  arch/x86/kernel/vmlinux.lds.S    | 1 -
>  arch/x86/tools/relocs.c          | 1 -
>  4 files changed, 14 deletions(-)
>
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
> index ae50d5d4fa26..e1b856e2f944 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -418,14 +418,6 @@ struct irq_stack {
>  } __aligned(IRQ_STACK_SIZE);
>
>  #ifdef CONFIG_X86_64
> -struct fixed_percpu_data {
> -       char            gs_base[40];
> -       unsigned long   reserved;
> -};
> -
> -DECLARE_PER_CPU_FIRST(struct fixed_percpu_data, fixed_percpu_data) __vis=
ible;
> -DECLARE_INIT_PER_CPU(fixed_percpu_data);
> -
>  static inline unsigned long cpu_kernelmode_gs_base(int cpu)
>  {
>  #ifdef CONFIG_SMP
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 1f33d5feb050..d6102e772c7e 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2020,10 +2020,6 @@ EXPORT_PER_CPU_SYMBOL(pcpu_hot);
>  EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
>
>  #ifdef CONFIG_X86_64
> -DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
> -                    fixed_percpu_data) __aligned(PAGE_SIZE) __visible;
> -EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_data);
> -
>  static void wrmsrl_cstar(unsigned long val)
>  {
>         /*
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.=
S
> index 42d1c05b0207..859ff7c0dc02 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -456,7 +456,6 @@ PROVIDE(__ref_stack_chk_guard =3D __stack_chk_guard);
>   */
>  #define INIT_PER_CPU(x) init_per_cpu__##x =3D ABSOLUTE(x)
>  INIT_PER_CPU(gdt_page);
> -INIT_PER_CPU(fixed_percpu_data);
>  INIT_PER_CPU(irq_stack_backing_store);
>
>  #ifdef CONFIG_MITIGATION_UNRET_ENTRY
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index 8b5e2bc3d241..a661a6bab4cf 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -829,7 +829,6 @@ static void percpu_init(void)
>   *     __per_cpu_load
>   *
>   * The "gold" linker incorrectly associates:
> - *     init_per_cpu__fixed_percpu_data
>   *     init_per_cpu__gdt_page
>   */
>  static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
> --
> 2.47.0
>

