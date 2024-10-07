Return-Path: <linux-kernel+bounces-353164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 980B099298F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B8B2B20D11
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684691D1319;
	Mon,  7 Oct 2024 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NJfWi4c+"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B15315D5C1
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298642; cv=none; b=ToflE5mNW9FoweNs+ZZscTlFHiLJmpLZEgZh2bWTDPPDxnovq8YUJoMRRa9IB0nzOxfxDawE/ZYt42zpUl0aZGCU3ylN8qdcLN9ko87GW8KW9la99EjmvoSOsEpZTkWqWr0Ic2pk1K6RD0UZj14BW57HW55sd129zDoY05eEY40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298642; c=relaxed/simple;
	bh=dn4X0hktRj/wRHGaaahxxpFAIsii4Hh22fc+Lp6LLY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJmgbhzX+kZq6hrIr5PoNpdzwbsAHkf+hyw1+fO0XKwVl0y8rp9PYCT2kNy2VY5WnOYkVLao/2QTP7xc5D5RHYPe32BlWP0CIqMCLwcKHNmFtqoYEwp3v+kyU6Raf7NmFVi/Z50Ph9IkV0rTY5NCTQQgx4zoarzpcgJ4As2iKtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NJfWi4c+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b3d1a77bbso221605ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 03:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728298639; x=1728903439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NH9878z7dQuSRPTLVPXr8k7J8PWiV4NBLhQUfEcgW0=;
        b=NJfWi4c+u2VbDXmKkjVeb3f3/+ShseHz15APbpUupDhmc4Kuynbg7GMaPQ5FSJ8CUQ
         XaTfOUas434636xNEWFmsX4F0ho2/D/1fdODKRrnJEccLeankFhw5V8On3oigQgPgAIL
         uwL2YayLqNolCp6W54s+id8dvIAVuFUdRLhxizkyad9smKTuLS1c4cpRK32gKCcEsTMX
         uPUOKpOUJhGtUg+PVKGpktICWilptuKUqHWVQV0zrVU6CVaLNGEaRV0pR9Cb3Bv38Mut
         HfKdaqysDCDESRHtjhlNXyfojBKIkSb8lCLtgO/P3aa1O5+nCKFaX36S/fSQ+HNQhmPA
         2yOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728298640; x=1728903440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NH9878z7dQuSRPTLVPXr8k7J8PWiV4NBLhQUfEcgW0=;
        b=tEfyQkQX/bxbcwcxxmpX0ry/53g13ls+AcZmkUml/QWwVI8jPFRtDRff+Eazfsdq2M
         bXdBk7v3y35g0YrBh3h78h4S/SYUwyGw36OcQ14P/P4wwaJ6Czfb1lJdZWNVoJSd8osY
         uiGOuEp08gjS1bogeLz9hukx2Ikca65KrqrxTBtGUgyXa/3kauvGeacp8e+ibKea8iXe
         h8epoUYdMFVb4a8a8C+iPjTrNPHADQtIAuzPk+raT0xFtzcNhjtNEh73WzblOONFH6wS
         HAb9lh2V7WjhqmTTSIL0CPLahREzbaE8SOwzmmHQ0Fk3A+5zwAtqBJ6IJbx0/BXjKZKa
         /AkA==
X-Gm-Message-State: AOJu0YzxW5abAr4f3KqEANAkxWKH9V+cOmXeibh9q4wEbh6nQdikbCOx
	OSk6yRXXql/7FPbn9E+KGbvndmwVOeg/3fTWFOkZ9tu0q0kLVyVOGta+oGjiU+zGrDa8wXyZn08
	haEX9WPfxMlSrgYmwh/OoZVzAyODIcXZacMEI
X-Google-Smtp-Source: AGHT+IFNdBdVNo669mlzVbqSIRfFshv9Ivfo9gz68mKq+QQz44aMDTFTWohbOA5YzoOslxMdQiCnIV03jaQ7DzGSRm0=
X-Received: by 2002:a17:903:1d0:b0:20b:93be:a2ac with SMTP id
 d9443c01a7336-20c192a45a0mr2223455ad.17.1728298639206; Mon, 07 Oct 2024
 03:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <40555604c3f4be43bf72e72d5409eaece4be9320.camel@coelho.fi>
In-Reply-To: <40555604c3f4be43bf72e72d5409eaece4be9320.camel@coelho.fi>
From: =?UTF-8?Q?Marek_Ma=C5=9Blanka?= <mmaslanka@google.com>
Date: Mon, 7 Oct 2024 12:57:06 +0200
Message-ID: <CAGcaFA1zqcqRNNydCZwn1pXUrjgSwvpLcVrf-ecFub2CABLiUw@mail.gmail.com>
Subject: Re: Regression in PMC code in 6.12-rc1
To: Luca Coelho <luca@coelho.fi>
Cc: linux-kernel@vger.kernel.org, hdegoede@redhat.com, 
	daniel.lezcano@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luca,

Thanks for the report.

Seems that the tick_freeze function in the kernel/time/tick-common.c
is helding the spinlock so the pmc_core_acpi_pm_timer_suspend_resume
shouldn't try to take the mutex lock. I'll look for the solution.

Marek


On Mon, Oct 7, 2024 at 11:17=E2=80=AFAM Luca Coelho <luca@coelho.fi> wrote:
>
> Hi Marek et al,
>
> We have been facing some errors when running some of our Display CI
> tests that seem to have been introduced by the following commit:
>
> e86c8186d03a ("platform/x86:intel/pmc: Enable the ACPI PM Timer to be tur=
ned off when suspended")
>
> The errors we are getting look like this:
>
> <4> [222.857770] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> <4> [222.857771] [ BUG: Invalid wait context ]
> <4> [222.857772] 6.12.0-rc1-xe #1 Not tainted
> <4> [222.857773] -----------------------------
> <4> [222.857774] swapper/4/0 is trying to lock:
> <4> [222.857775] ffff8881174c88c8 (&pmcdev->lock){+.+.}-{3:3}, at: pmc_co=
re_acpi_pm_timer_suspend_resume+0x50/0xe0 [intel_pmc_core]
> <4> [222.857782] other info that might help us debug this:
> <4> [222.857783] context-{4:4}
> <4> [222.857784] 1 lock held by swapper/4/0:
> <4> [222.857785]  #0: ffffffff83452258 (tick_freeze_lock){....}-{2:2}, at=
: tick_freeze+0x16/0x110
> <4> [222.857791] stack backtrace:
> <4> [222.857793] CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Not tainted 6.12.0-=
rc1-xe #1
> <4> [222.857794] Hardware name: Intel Corporation Alder Lake Client Platf=
orm/AlderLake-P DDR5 RVP, BIOS RPLPFWI1.R00.4035.A00.2301200723 01/20/2023
> <4> [222.857796] Call Trace:
> <4> [222.857797]  <TASK>
> <4> [222.857798]  dump_stack_lvl+0x80/0xc0
> <4> [222.857802]  dump_stack+0x10/0x20
> <4> [222.857805]  __lock_acquire+0x943/0x2800
> <4> [222.857808]  ? stack_trace_save+0x4b/0x70
> <4> [222.857812]  lock_acquire+0xc5/0x2f0
> <4> [222.857814]  ? pmc_core_acpi_pm_timer_suspend_resume+0x50/0xe0 [inte=
l_pmc_core]
> <4> [222.857817]  __mutex_lock+0xbe/0xc70
> <4> [222.857819]  ? pmc_core_acpi_pm_timer_suspend_resume+0x50/0xe0 [inte=
l_pmc_core]
> <4> [222.857822]  ? pmc_core_acpi_pm_timer_suspend_resume+0x50/0xe0 [inte=
l_pmc_core]
> <4> [222.857825]  mutex_lock_nested+0x1b/0x30
> <4> [222.857827]  ? mutex_lock_nested+0x1b/0x30
> <4> [222.857828]  pmc_core_acpi_pm_timer_suspend_resume+0x50/0xe0 [intel_=
pmc_core]
> <4> [222.857831]  acpi_pm_suspend+0x23/0x40
> <4> [222.857834]  clocksource_suspend+0x2b/0x50
> <4> [222.857836]  timekeeping_suspend+0x22a/0x360
> <4> [222.857839]  tick_freeze+0x89/0x110
> <4> [222.857840]  enter_s2idle_proper+0x34/0x1d0
> <4> [222.857843]  cpuidle_enter_s2idle+0xaa/0x120
> <4> [222.857845]  ? tsc_verify_tsc_adjust+0x42/0x100
> <4> [222.857849]  do_idle+0x221/0x250
> <4> [222.857852]  cpu_startup_entry+0x29/0x30
> <4> [222.857854]  start_secondary+0x12e/0x160
> <4> [222.857856]  common_startup_64+0x13e/0x141
> <4> [222.857859]  </TASK>
>
> And the full logs can be found, for example, here:
>
> https://intel-gfx-ci.01.org/tree/intel-xe/xe-2016-92d12099cc768f36cf676ee=
1b014442a5c5ba965/shard-adlp-3/igt@kms_flip@flip-vs-suspend-interruptible.h=
tml
>
>
> Reverting this commit seems to prevent the problem.  Do you have any
> idea what could be causing this and, more importantly, how to fix it?
> :)
>
> Thanks!
>
> --
> Cheers,
> Luca.

