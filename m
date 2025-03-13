Return-Path: <linux-kernel+bounces-560535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138FEA60649
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BDA43B9420
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547C91F4630;
	Fri, 14 Mar 2025 00:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioteEtva"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375335CB8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 00:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741910403; cv=none; b=Ghe5DezlQja3z9uDWdPO3q+7+7jsh1EWmP+zvjSo9e+qHww0VxlHEVBLBefIcvdAT/lCKERnwyb4kkFdztPKtqBvLRjkm6hCQW3zF16xzP7V/3/Kel1BV2obSRs7QqR+4HtaGO7TJNlfkFaZHnZNWJLZ5DxzXEAPFtyJFOip0+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741910403; c=relaxed/simple;
	bh=NYecN2d5FW84CUvbmtTU6zDtzpvTz/dA+S6eEZGrB7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsINZCg6L0odDSTUgHpuRNYhQA/Df5us4d379EzoSFv4bBNRmTkJZmnOZJATsn3np5cIQolYhaKiXyXB5YaCrdOQECdzixd7dQ90vxQONHGWwC+OaZttQPhbfW00v9aXcukNQ96X3R2f0hauWgps3x9TduPq33ErcO52umV7EPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioteEtva; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so3464238a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741910401; x=1742515201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wjE6f9jbNOkbcqnjaYOGa0DQ5kN4r+7bIti2jCK9d4=;
        b=ioteEtva6yWoE7eDSjfP4mmIOPajT1Oc7dbB8XyOxawplVEqi5kbrEB1UPifzph9U9
         TtIMweeOtovaKwVopn0Kqyvbb5US+0Hcp71lZC2AZKWmgB8TyDaSNlk9wlxvU8n0VUL2
         esIuG3TZVeTFe5hynNmHzZAbqZSCzD6m8kQnt2dRW8vj1Ye61JfdwnBUhDwLtPtXc83K
         K01dbjdZ3Z212i3Y+K1C1sjgRg6Z7js+pnutO0+uht+bC4JbGdsQ03wA915mH6jDxmYR
         EC/5t8CzR3LWecSyBR4rq9ZvJw0+IJqONBmfjqfL8s6nkD97UaXZna3P62esGEDKzlel
         aGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741910401; x=1742515201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wjE6f9jbNOkbcqnjaYOGa0DQ5kN4r+7bIti2jCK9d4=;
        b=Ta5v/FPXco5Km+Q9RWp3Lfy5uBwH1/GopzupzugkfJUJ4RPnQXLFEN0iOrI/CnfeD4
         ixmYm0fPAGwHhGfzDMDRaJQwfOEFPEKXo5on8jsSel0mU4ITAG1kygKVxnTIlxLD04sE
         YJFjWW+0SzGYMQl8wElg7jd0wo9DnvNI2mut8ItDjFCDsg89VY7/SNRHqffXwAsWrcYV
         FLsp8WGWJo72o5XaL7uKXOxr0UJQGM/DqCwGtmL5CIL/FU4syp3n7A4o4CZkTUKf60Jm
         ciJckTCetM+TgQ27RIbYJmIMiI8VmncC/CpDN6JatHOKD2oJy3zJGibxE4wYGg2QdbSR
         h0WA==
X-Forwarded-Encrypted: i=1; AJvYcCW4xaoK5BDkvgj/gp60qoyNlUY7sVj7UPlhtGCpZGLGg09XPhu0OlgLHJjc3/GP1jeBFJjS7FzeaZqO0Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtwreFJb9MZbyHutp4KzRMjDw2eUUcHC7OjlWwACgotEXWVoWj
	LY3FkJtLPav1EIzQ3s1H1wR6KJ+YGH0GEcLdUzfLBoB9BuCu6ZZv17vo39Y9xJQAqJG9svJGR4T
	5FybKiqTpXTh6agvAwNpKccHFWyA=
X-Gm-Gg: ASbGncsEHiOHoIGT69BT6gEUZfS2hxNNGDp97W3Oo0qQwFW7MC2Jfen/HcEWxJK8Bax
	8KQiXj03hbBAoWA3cDgPwG7hevtkudVk4nAJ5clp21fDvxQwizcTeF+yd0trVRCk0FZmSrNWClS
	q1525AzXBuWTcEOin0Q29EExfl
X-Google-Smtp-Source: AGHT+IEHkMskZfm5WUkKtYAViNZ8nMkrivbEqLkd9kTor8r6fGxxbprbYeRfyximuVn0fue9V+9v67zGOYeX+rqtClc=
X-Received: by 2002:a17:90b:3d85:b0:2fe:a79e:f56f with SMTP id
 98e67ed59e1d1-30151ca0b77mr546513a91.13.1741910401281; Thu, 13 Mar 2025
 17:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG8fp8Qdmt9vLk=8ORccY5B+ec1huhazXG4PBaNyLEkq31HDjw@mail.gmail.com>
 <20250312100926.34954-1-akihiro.suda.cz@hco.ntt.co.jp> <Z9MPmA-myNZxcc-E@gmail.com>
In-Reply-To: <Z9MPmA-myNZxcc-E@gmail.com>
From: Akihiro Suda <suda.kyoto@gmail.com>
Date: Fri, 14 Mar 2025 08:59:49 +0900
X-Gm-Features: AQ5f1JoZyeOCRp5_8DpQtv90_RPgHEmesRvIxoyfNUozBXTXt9IsmaD09aaUU04
Message-ID: <CAG8fp8Tjt2utmE79DfkETE96DnnwtvzHqEXmuYDi4O4azWQRLw@mail.gmail.com>
Subject: Re: [PATCH v2] x86: disable PKU when running on Apple Virtualization
To: Ingo Molnar <mingo@kernel.org>
Cc: Akihiro Suda <suda.gitsendemail@gmail.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, regressions@lists.linux.dev, aruna.ramakrishna@oracle.com, 
	tglx@linutronix.de, Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Ingo, and sorry for adding #ifdef CONFIG_ACPI

Regards,
Akihiro Suda

2025=E5=B9=B43=E6=9C=8814=E6=97=A5(=E9=87=91) 2:02 Ingo Molnar <mingo@kerne=
l.org>:
>
>
> * Akihiro Suda <suda.gitsendemail@gmail.com> wrote:
>
> > OSPKE seems broken on Apple Virtualization.
> >
> >   WARNING: CPU: 0 PID: 1 at arch/x86/kernel/fpu/xstate.c:1003 get_xsave=
_addr_user+0x28/0x40
> >   (...)
> >   Call Trace:
> >    <TASK>
> >    ? get_xsave_addr_user+0x28/0x40
> >    ? __warn.cold+0x8e/0xea
> >    ? get_xsave_addr_user+0x28/0x40
> >    ? report_bug+0xff/0x140
> >    ? handle_bug+0x3b/0x70
> >    ? exc_invalid_op+0x17/0x70
> >    ? asm_exc_invalid_op+0x1a/0x20
> >    ? get_xsave_addr_user+0x28/0x40
> >    copy_fpstate_to_sigframe+0x1be/0x380
> >    ? __put_user_8+0x11/0x20
> >    get_sigframe+0xf1/0x280
> >    x64_setup_rt_frame+0x67/0x2c0
> >    arch_do_signal_or_restart+0x1b3/0x240
> >    syscall_exit_to_user_mode+0xb0/0x130
> >    do_syscall_64+0xab/0x1a0
> >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Tested on macOS 13.5.1 running on MacBook Pro 2020 with
> > Intel(R) Core(TM) i7-1068NG7 CPU @ 2.30GHz.
> >
> > Fixes: 70044df250d0 ("x86/pkeys: Update PKRU to enable all pkeys before=
 XSAVE")
> > Link: https://lore.kernel.org/regressions/CAG8fp8QvH71Wi_y7b7tgFp7knK38=
rfrF7rRHh-gFKqeS0gxY6Q@mail.gmail.com/T/#u
> > Link: https://github.com/lima-vm/lima/issues/3334
> > Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
> > ---
> > v2: check oem_table_id rather than oem_id for better robustness
>
> So this is rather weird, but I've applied the quirk as it upgrades
> broken guest side code into a boot time warning.
>
> > +     /*
> > +      * OSPKE seems broken on Apple Virtualization.
> > +      * https://lore.kernel.org/regressions/CAG8fp8QvH71Wi_y7b7tgFp7kn=
K38rfrF7rRHh-gFKqeS0gxY6Q@mail.gmail.com/T/#u
> > +      *
> > +      * TODO: conditionally enable pku depending on the DMI BIOS versi=
on when Apple
> > +      * fixes the issue.
> > +      *
> > +      * However, this would be still not enough because DMI is missing=
 when vmlinuz
> > +      * is directly loaded into VM.
> > +      */
> > +     if (!memcmp(acpi_gbl_FADT.header.oem_table_id, "Apple Vz", 8)) {
> > +             pr_info("pku: disabled on Apple Virtualization platform (=
Intel) due to a bug\n");
> > +             pku_disabled =3D true;
> > +     }
>
> Note that I updated the comments here (the git log gives enough
> information), plus enclosed this into #ifdef CONFIG_ACPI, as
> acpi_gbl_FADT is not available on !CONFIG_ACPI builds.
>
> Thanks,
>
>         Ingo

