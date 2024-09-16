Return-Path: <linux-kernel+bounces-330937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBC997A641
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E62CFB2DFB5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B48165F18;
	Mon, 16 Sep 2024 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XcYSaJRt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C24165F16
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505400; cv=none; b=JNy/2ujGWrNyq0ha08hl5QihF0B08pOmMFHkgiagi20b77nzOykb2vUt5qnPAlP9lk1ew3c+waMI14x31BWMx4IKQv4QY/0IhZyGJak3iw04dY7OG5oLmDoZ6ieqsKJQRDoTwCKbX19gqoscRWMZO/UQsgopFqcTMEXxAOJ6z88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505400; c=relaxed/simple;
	bh=o+DYVxVDcAlTZVNN1hFyfoqE3+LqsO2LryTMqHdVksQ=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6PmRXY4gm8qKwXGFDoIlpUKN1f8LqOcnL1mpOioZRgyzePV7BoJQAm7w8QutJJxUH6v9kvmWHveIdw+3l78FjyvQJ7xTjELJ/MkAMWI/9YzlG7ZDTTTyd9bmzvnHYL+DQmEoDKjeFdT1OFj8EIyCMw+rCpGCIW9Z8xnTLsVS48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XcYSaJRt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726505398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1GXZKybnTnuNS+nIRSUr5QII9/sx+kMsW3/KaJpCCQ8=;
	b=XcYSaJRtCxa5llGFJ+pVzgcMvcXdIq1ZQPDba+iBBoUygxcKcWiZpMLFsicGY8MbOheT1Y
	sSSJVrsusyeaT79JE8FPfnuGkgsAqU4mEK1z7cdaIu7zs+ol4PqcNsqboglp3f/N3vZFNy
	aZV4zV4t/H6bUir6q7J+Q+z+iaEGHac=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-JhRFv_k2OQm8lBBcWAN_8g-1; Mon, 16 Sep 2024 12:49:55 -0400
X-MC-Unique: JhRFv_k2OQm8lBBcWAN_8g-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a9a95429c4so583457285a.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726505394; x=1727110194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1GXZKybnTnuNS+nIRSUr5QII9/sx+kMsW3/KaJpCCQ8=;
        b=T3Dpy4fAOIgPXbCAhehjePLETIVDIM4fb8M5Cu2q8kQLiKU6uIVyJy7mav2e7EAd0P
         VCcvltM+frCK+4Tey8gGDgffNMRYLzDR7SiP9tWJ34ai90VlshOs+SE6Rpeu0FKio2LK
         HfXDV0msk/JZo5bDv0wzDgADhMlJSa70XIB/tQ2c8lH7ASaxO0xiFJexCGpd8tAtRBi+
         tWMGw14A2j8OG6O2oZzbO2glTwx11A86VeG4IaTIf3/WLdJxfXCujwugMBMpyj01qcGN
         jTXsRTwo3oU8C5KPz5nI3kwx3efnKkdCXzptkaT5gjO5+E5XpgeoMLP3BwTpakFdpnS+
         iBzw==
X-Forwarded-Encrypted: i=1; AJvYcCXUoqiLT4M2YAAq6jduRG+8nfHMJH0Yo/+E87fKNIxVZ4UdISYjvqhZE/M1uYRUMlUviMU4iMM3LDJVqNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBSKRAh8uw1MaRR9tMAThErhZXuK80kmiPTigwEmOG989GqwRY
	k84ylQJnkOoY9lRKpOTHaTK7y0HHYGKzN5sSI4UbAjebaXnIe3B+MdNZrNrQokHSGIlAG7sNV8v
	PXC2N2CZuLL7DKqKJclRSZTL28epDWCfyWDBl14DZ5Q6nNR6DqBwPp2b4uqZoSV1GlczyXDroCZ
	fhyA9hO6YzjsqCGNvSDoqKNbC2GoFbvGLJI8Gd
X-Received: by 2002:a05:620a:4708:b0:7a9:aba6:d033 with SMTP id af79cd13be357-7ab30dcefb0mr1578196185a.56.1726505394316;
        Mon, 16 Sep 2024 09:49:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEpr++i4tcvPceMgrGqzAnmVR09V07s8NPt541CScK42NXb+0pSNQBgOVdc22NfVWwm8atRhs0RB5k3cMyc+c=
X-Received: by 2002:a05:620a:4708:b0:7a9:aba6:d033 with SMTP id
 af79cd13be357-7ab30dcefb0mr1578193985a.56.1726505393925; Mon, 16 Sep 2024
 09:49:53 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Sep 2024 01:49:52 +0900
From: Andrea Bolognani <abologna@redhat.com>
References: <20240627142338.5114-2-CoelacanthusHex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240627142338.5114-2-CoelacanthusHex@gmail.com>
Date: Tue, 17 Sep 2024 01:49:52 +0900
Message-ID: <CABJz62PRAv0QqszOTHDUdrrgY-Za9y9Vq6mYke=FqP=N5qXvbw@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: entry: always initialize regs->a0 to -ENOSYS
To: Celeste Liu <coelacanthushex@gmail.com>
Cc: linux-riscv@lists.infradead.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-kernel@vger.kernel.org, "Dmitry V . Levin" <ldv@strace.io>, Guo Ren <guoren@kernel.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Felix Yan <felixonmars@archlinux.org>, 
	Ruizhe Pan <c141028@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 10:23:39PM GMT, Celeste Liu wrote:
> Otherwise when the tracer changes syscall number to -1, the kernel fails
> to initialize a0 with -ENOSYS and subsequently fails to return the error
> code of the failed syscall to userspace. For example, it will break
> strace syscall tampering.
>
> Fixes: 52449c17bdd1 ("riscv: entry: set a0 =3D -ENOSYS only when syscall =
!=3D -1")
> Reported-by: "Dmitry V. Levin" <ldv@strace.io>
> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> ---
>  arch/riscv/kernel/traps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 05a16b1f0aee..51ebfd23e007 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -319,6 +319,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
>
>  		regs->epc +=3D 4;
>  		regs->orig_a0 =3D regs->a0;
> +		regs->a0 =3D -ENOSYS;
>
>  		riscv_v_vstate_discard(regs);
>
> @@ -328,8 +329,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
>
>  		if (syscall >=3D 0 && syscall < NR_syscalls)
>  			syscall_handler(regs, syscall);
> -		else if (syscall !=3D -1)
> -			regs->a0 =3D -ENOSYS;
> +
>  		/*
>  		 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
>  		 * so the maximum stack offset is 1k bytes (10 bits).

Hi,

this change seems to have broken strace's test suite.

In particular, the "legacy_syscall_info" test, which is meant to
verify that strace behaves correctly when PTRACE_GET_SYSCALL_INFO is
not available, reports a bogus value for the first argument of the
syscall (the one passed via a0).

The bogus value comes directly from the ptrace() call, before strace
has a chance to meddle with it, hence why the maintainer suggested
that the issue would likely be traced back to the kernel.

I have built a kernel with this change reverted and, as expected, the
strace test suite passes. Admittedly I've used the 6.11-rc7 Fedora
kernel as the baseline for this test, but none of the Fedora patches
touch the RISC-V code at all and the file itself hasn't been touched
since rc7, so I'm fairly confident the same behavior is present in
vanilla 6.11 too.

See

  https://github.com/strace/strace/issues/315

for the original report. Please let me know if I need to provide
additional information, report this anywhere else (bugzilla?), and so
on...

Thanks!

--=20
Andrea Bolognani / Red Hat / Virtualization


