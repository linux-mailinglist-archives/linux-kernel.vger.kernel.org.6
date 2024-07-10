Return-Path: <linux-kernel+bounces-247806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB74A92D4C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3781F23B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494DA194131;
	Wed, 10 Jul 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTjT+rem"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F332918635
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720624520; cv=none; b=TMXsGCnoPc95ex8qT37lJTmqrjZFVYNVh8I1ipylLzhKGvn8EjQEyRinjH3KxKb2Bwef3uwB6aJDmbdPQUBwaMpIaqXTUGJ2+tnTuQZegMGcld7eqcvvUw4Ugz/X0v67O4g1F9biFZq05SMZFtXYQYe/qkslA3A4H5ZxVM6nt0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720624520; c=relaxed/simple;
	bh=FfUIvAoGgrICtX2UtlualkM/7Z6PkggeIsDM53BE+hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPyMmgLCvQ410Xp+hEmVnPmLVPPBakrU6AJrDMdy94vFwluxRO8Cc8gf8d30/kUjmsRA2ThU701hqOkvkSRJ3JfecHAP6LAJsbB3AXsXT0cr9SpuOxx6BGf6rYX+crk1C7rGRWbDxLbYq1RkmNS0o3/dmKz/ZRBZtYAQdE4Q3OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTjT+rem; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52e98087e32so7243171e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720624517; x=1721229317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11bwyp3mzRgMF9CNOeJnvGVtvdDnSAqFTcq7kcgU97Y=;
        b=LTjT+remq76qPeUwRIPP+R9/opDz6/mGmikadXFekaneLHvDFVsTNC1DDTEk3xMPwH
         SWp8jRdpKBrCLAFWi8auUfTDdhEXvWBMsxftT1//VP30F/X2Csuq8FP0tbNlf+ghZkWl
         +SE4/21UyfBo+3JBIgjNGDNYJM5+ZWU1WDNXVmCI3m6Mo/Wh/HZSqeX1gzwWNp56YoLt
         qIBgWYowUwfOxqDvGja27RwcDkAt5cvHlFyLpShLIKWyWEt0oMcFKN016huh0B80JC17
         dk/43TeVXCf1y6wVgak0gHDQbRrjTOQV2jK/KzZ+AAJXsSz7Q1lu2PxCZ2vQkBrlMGGe
         j4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720624517; x=1721229317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11bwyp3mzRgMF9CNOeJnvGVtvdDnSAqFTcq7kcgU97Y=;
        b=C5cNbOtJ3AtZb8VfRUyRcTZ80IsTv3i5HFysRi6SkAEmmOzuvFQtoFetVWZqed8jWG
         O0VNjw7l50RHwKroCLTjuyXFmR8ZJJR+LV3mXEZu0lfG5rUHDbp7xJrG72ffV9e/Ntw9
         jZIcJ6v7kpRTHjlbNISqgzPrWWBqWCpMCzqN0a8uSBfZ1IDKrQ4rEbc8dHgMR0GOzJl7
         tmADtklqs0TunBxiapjjQ83ZNVR78jvcWgtdNjG4T2O7UEqFpGXG3xST4jrbSCnT9RIQ
         KwShQ0pcNQKOGHKZvx0nEsBE6CH/lAX9q2KxPOCtjz5CD5gZZJPRQ2NWENiT0kfTxuY4
         XtGg==
X-Forwarded-Encrypted: i=1; AJvYcCVsmayhYx/dEiMzRO/waT5amlrTpBGYyPi7x2UPHmVUgeqBrNRO1oTrrKh+WozQg6J9jNe0TkntXYpuHwjw5hD9uZX8/82emXHaK6s7
X-Gm-Message-State: AOJu0YzhI79rGr0JOEAGbNMtRnIXQ1tagxTKwexedMdOmOP5XNDts5eK
	aNDwuXf1HcEWQMKAZEB/19rhljexwBA/rLpvLk2D+vKJaXwVZdptIhkcstvHTkI68E8mX8N6Lr3
	5NmAMSO+E6Jlxid053xLZ2AWqLZU=
X-Google-Smtp-Source: AGHT+IFf2/IqU+lWECTTK4YpYuwcHyu16mdGNAy0zcyMCPJx2FjekA7dU0dJBEbjuqpOiS1E0WQUSrCr6SZ7kj1+qUs=
X-Received: by 2002:a05:6512:304f:b0:52c:e16e:6033 with SMTP id
 2adb3069b0e04-52eb998e74emr4207069e87.2.1720624516844; Wed, 10 Jul 2024
 08:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710140017.GA1074@redhat.com> <20240710140108.GB1084@redhat.com>
In-Reply-To: <20240710140108.GB1084@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jul 2024 08:15:02 -0700
Message-ID: <CAEf4Bza94=39M7s1fNTZYFcx7QG1SotcdZ-O+WnyEza=rFkETA@mail.gmail.com>
Subject: Re: [PATCH 2/2] uprobes: is_trap_at_addr: don't use get_user_pages_remote()
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org, clm@meta.com, 
	jolsa@kernel.org, mingo@kernel.org, paulmck@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 7:02=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> get_user_pages_remote() and the comment above it make no sense.
>
> There is no task_struct passed into get_user_pages_remote() anymore, and
> nowadays mm_account_fault() increments the current->min/maj_flt counters
> regardless of FAULT_FLAG_REMOTE.
>
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/events/uprobes.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>

Makes sense

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index d52b624a50fa..1bdf386485d4 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -453,7 +453,7 @@ static int update_ref_ctr(struct uprobe *uprobe, stru=
ct mm_struct *mm,
>   * @vaddr: the virtual address to store the opcode.
>   * @opcode: opcode to be written at @vaddr.
>   *
> - * Called with mm->mmap_lock held for read or write.
> + * Called with mm->mmap_lock held.
>   * Return 0 (success) or a negative errno.
>   */
>  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *m=
m,
> @@ -2024,13 +2024,7 @@ static int is_trap_at_addr(struct mm_struct *mm, u=
nsigned long vaddr)
>         if (likely(result =3D=3D 0))
>                 goto out;
>
> -       /*
> -        * The NULL 'tsk' here ensures that any faults that occur here
> -        * will not be accounted to the task.  'mm' *is* current->mm,
> -        * but we treat this as a 'remote' access since it is
> -        * essentially a kernel access to the memory.
> -        */
> -       result =3D get_user_pages_remote(mm, vaddr, 1, FOLL_FORCE, &page,=
 NULL);
> +       result =3D get_user_pages(vaddr, 1, FOLL_FORCE, &page);
>         if (result < 0)
>                 return result;
>
> --
> 2.25.1.362.g51ebf55
>
>

