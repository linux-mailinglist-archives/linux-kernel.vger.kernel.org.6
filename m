Return-Path: <linux-kernel+bounces-268666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2BA94278C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0729F281366
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7207A1A4F11;
	Wed, 31 Jul 2024 07:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QINaSfa5"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DB716A39E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409849; cv=none; b=CoxtJax3ov6M6ChTxZ8RFq1eBKYYLiq5gqMbc/oTzsbbp3tSC2NSqBLkMud7rKrMKitYqSQG2X71hc81z5xO2sjq6g+EHlO+ENmCQoJ1m0ihiWW37UJcAiIWeIB0LNQclA9LbDXkizkdvEDbNJfIipx+dgL+b5goWe7+L0NuZDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409849; c=relaxed/simple;
	bh=xO8K6Mhpi49vHI0hD/R3LJFRz9UzoDtAj7UGbP4GDIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzKapg2U/2dhJZCrV3l3KZyGw47uvdhvdfKVFOH+YVbJFxQl988VDUdoMSAjqVfHizXTl4zpB6f+3jHIGYNMKXfUJQWgYziCvBrSVgyaX/20EmtD2ng0INpW/MVuxCW8rnyUBZUuQ5/f/OSRZiCIVSyBf/UehqL/8xAkyNimjZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QINaSfa5; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a156557029so8756757a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722409844; x=1723014644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rM3knuOZHaqsTFzkDvpQFpGqEOzU5UQ/01PDBT9efdA=;
        b=QINaSfa5a064e65U/mhsfN0EwG3lP9R3+T8erxPldIBaIXzqpNd/Jllpa0ZFIzWLW5
         kB2FhkM68KHuIgJhZIp8BMGhXRvH6AxlWJoSnc+eMhm4WQWuU+tkqZYH//Qh789by1Rk
         TdRsu9QmpWGrKnpWfg4IbpnLktr/hIdJGcPyOEm9sk+F7UK2N1l0omoOJoxEcJPj23Zu
         Ga6dEYhXV7Ufg+NvZqYvKZSgQNMLBIdrOF4e6yIx0lu19RsEErwSLdrFuhrC/h8K42p/
         aLhTeFgSUCJvSOeUvQkq9frAC05HLbs4CTXY/aXbVYGswVMCsjOYEKxFZ+JiDJE/X3uT
         hWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722409844; x=1723014644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rM3knuOZHaqsTFzkDvpQFpGqEOzU5UQ/01PDBT9efdA=;
        b=eIyZe769a/XInBbTXn7kdLZe1peugEnxVPu3XrDVPJpH8CYHpWFpwsRUWJ9pal92f0
         ceNM5yTjfWnbBl68oX9vsFcuUw6M+/mfYz0inxlt6QQKb3quubNIeiNu3wNSpVzhGA2e
         RUkvOneMPEHTOhDVa8hqp8iSYyPNxvfgAxB0CD2N40jqqJYvyWlzRvvslEE5veUe3tJw
         GO6mb2bNLfV7BvjkD8G1aRnOF2oQeu/uqlw2An+sJY+OF6gMsUMKZW0OMfVRRv2cqtC9
         m2aYsfAvSTlkfcY67I98nBVtnuriwfXjxLzDCl4+IlXlucrE595A2tY5t1KtCLZudfvO
         iMeg==
X-Forwarded-Encrypted: i=1; AJvYcCX0Nqyp4ZfcObV0Yr4tAapR8irjTcXc+7b5IweNU6RgrjhCgCirN5Cx/At+DePzZe2pldx99vMqAqwYnWIb00wJaPEA6n5LiWG9xbWb
X-Gm-Message-State: AOJu0YxrQan7YCDE9wJk/NiD9WcT2fqmEQTInYROfRrZa74OmuDG0gVU
	PKTSQyL0l8HK+8BkjNDYNKCX/klS8mea+cZm+Kgk0ib5lR8kq88VcU7O4YrWeL3PuhcSpjoLbDB
	c6dkPqO/+3MaV3WNI0M8s+2ngl8fzNecPhLpb1w==
X-Google-Smtp-Source: AGHT+IGUys3WnYAg9sQ+TuEMKkqzevv5FUJda7lT6udM7lAkPAKhnz7RRtQdNEaRKDEN5SpkAfN9qgIvkzT1vcXEvPo=
X-Received: by 2002:a50:d6d4:0:b0:58b:9561:650b with SMTP id
 4fb4d7f45d1cf-5b021d21cd1mr8461697a12.25.1722409844400; Wed, 31 Jul 2024
 00:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731032627.59696-1-qiaozhe@iscas.ac.cn>
In-Reply-To: <20240731032627.59696-1-qiaozhe@iscas.ac.cn>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 31 Jul 2024 09:10:33 +0200
Message-ID: <CAHVXubh2MawWGzcL38DPnj2Xa=ZGNr6JK3of3v=eSEOkMeu8Bw@mail.gmail.com>
Subject: Re: [PATCH] riscv/mm: Add handling for VM_FAULT_SIGSEGV in mm_fault_error()
To: Zhe Qiao <qiaozhe@iscas.ac.cn>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	surenb@google.com, akpm@linux-foundation.org, wangkefeng.wang@huawei.com, 
	willy@infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zhe,

On Wed, Jul 31, 2024 at 5:26=E2=80=AFAM Zhe Qiao <qiaozhe@iscas.ac.cn> wrot=
e:
>
> Add processing for VM_CAULT_SIGSEGV to mm_fault_error () to avoid
> direct execution of BUG().

Sorry to bother you again, but since there is a typo
(s/VM_CAULT_SIGSEGV/VM_FAULT_SIGSEGV), do you mind rephrasing the
commit log like this (or similar)?

"Handle VM_FAULT_SIGSEGV in the page fault path so that we correctly
kill the process and we don't BUG() the kernel."

>
> Fixes: 07037db5d479 ("RISC-V: Paging and MMU")
> Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
> ---
>  arch/riscv/mm/fault.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 5224f3733802..a9f2b4af8f3f 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -61,26 +61,27 @@ static inline void no_context(struct pt_regs *regs, u=
nsigned long addr)
>
>  static inline void mm_fault_error(struct pt_regs *regs, unsigned long ad=
dr, vm_fault_t fault)
>  {
> +       if (!user_mode(regs)) {
> +               no_context(regs, addr);
> +               return;
> +       }
> +
>         if (fault & VM_FAULT_OOM) {
>                 /*
>                  * We ran out of memory, call the OOM killer, and return =
the userspace
>                  * (which will retry the fault, or kill us if we got oom-=
killed).
>                  */
> -               if (!user_mode(regs)) {
> -                       no_context(regs, addr);
> -                       return;
> -               }
>                 pagefault_out_of_memory();
>                 return;
>         } else if (fault & (VM_FAULT_SIGBUS | VM_FAULT_HWPOISON | VM_FAUL=
T_HWPOISON_LARGE)) {
>                 /* Kernel mode? Handle exceptions or die */
> -               if (!user_mode(regs)) {
> -                       no_context(regs, addr);
> -                       return;
> -               }
>                 do_trap(regs, SIGBUS, BUS_ADRERR, addr);
>                 return;
> +       } else if (fault & VM_FAULT_SIGSEGV) {
> +               do_trap(regs, SIGSEGV, SEGV_MAPERR, addr);
> +               return;
>         }
> +
>         BUG();
>  }
>
> --
> 2.43.0
>

That's a very good catch, good job! You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

