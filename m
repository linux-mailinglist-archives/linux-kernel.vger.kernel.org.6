Return-Path: <linux-kernel+bounces-362579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D66B99B69A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 20:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC751F220B7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 18:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD7C83CDB;
	Sat, 12 Oct 2024 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2NPp4Px0"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA6282FE
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728757850; cv=none; b=D842x6P04cKuEth6BRZA6hfZSqsVjdsCcH9w7DaA4NZO2fLQcdsqWpzjH+84wFpsinkh4H0jHLiKp7kud6VGMehsBSIFbsVXiKbxqM5VolBylmMWxDKGDDM0CzjXQp2vt4z0ZDdrx/DBtZrVA7Dy2v0CizpZR0YNM8gAwVVdzig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728757850; c=relaxed/simple;
	bh=q9993wst7hUX2uvPC2obwbdFvU7C2cYsKZb7zVOxNRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odCzoF4fTTxHtyDURjKgQhfvf3iR7WetRwgIDPOG7y0lzNx8b/031phiSXJ7D9V/mYF2J9H2Q6iay+CfJn9Ou/KJJubA4D8FLZK9QXDU+v//dQrKLCq/iny2JSe2JN2HGMUB91pNQfvUQ9L5sh1SofozKPesbqUM6MwEpBpB4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2NPp4Px0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20ca03687fdso123385ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 11:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728757848; x=1729362648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4TtbF54eQ1KffXHH0El+WnO6LU402j+y/dLj0ft5oc=;
        b=2NPp4Px0v3B3v7rJtvZTX4Qs4Ckkb+EC2JEWW8dZIQavdRP5lr39T0/p6INhdpEaF1
         4hP2vd2N/GXKvIGwYqm+E7kL3PyJBAMqQdb/NzJ2D0xshk5fwFpa6DBzVparxQKC8TsG
         dtgiXkjbCVxNfatUr8uKCEMhlWSw4ACIT6pnV4wIxEcK+rjYXXWWeMKWvN7OdnkoyQDP
         mN58NVdrKUmHwtFc9/kIdJtzYeSAkF5dGc29L668MgN3kaItU2yAo9GSp9xbabwlar7E
         LDD2q92NG+4k8F2XwuaIPGgCfuIlD4bCNuJYHn+HsQ+DvtVGcShUfmAV6p2HD5O6LM9l
         LoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728757848; x=1729362648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4TtbF54eQ1KffXHH0El+WnO6LU402j+y/dLj0ft5oc=;
        b=hasCv8e4bi7OR1AhpTZCZYElGDnxOxJuP0CtOU7hOrwEeA1CN4bGRAlbdXoKjuLZdj
         tSrhlbBezvjX6GnsyvBnYyOKzzFS/xAU+NA6+rXK8nnRVETeaF+Idr0vIgmlG0vPjYEk
         MnIqAymIafWLmCLEwJk/JeLvpN1+R9H2vtaN3BLynFMICq3864B+g4slaWkVNeauL70o
         /OVpQm7wVVYXKlOkmyjIbyu62ikSINPijvwyUeEtHN3sKf/5ZQ8xwa5fs2GA6WJrgqdo
         V607pe4QHtlFNT+I9aLAzYAe9XF/VtU9lxi/MllHxVeKAvRTMqA5kQZHCY02iVRWEdvS
         ljvQ==
X-Gm-Message-State: AOJu0YyWU8VP9C+UGD3CzI2t69zee5S5qof0R9Jpqhf6eGvNHPj+7+Ou
	AjFyHwWNUZYZIXnFRbaCDG5Qe3tZCAhKnMGZ94JojqznYGz9/FnbfEl5dctLXsNJiMH2RdA2NE/
	Ud7YqvOizwQC5FiVxM7ls99vujb2SCvwdFNm4
X-Google-Smtp-Source: AGHT+IE2vp0liuTEphEI33DUfS1AUAvd0C1WtDAPNMQ3JfRvM6Qn27MJxTO1lD+HvQOVHygPav4JQtWy16VN1t7wbzE=
X-Received: by 2002:a17:902:c40b:b0:20c:6c50:dc80 with SMTP id
 d9443c01a7336-20cc02a3e48mr1115075ad.9.1728757847509; Sat, 12 Oct 2024
 11:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <40555604c3f4be43bf72e72d5409eaece4be9320.camel@coelho.fi>
 <CAGcaFA1zqcqRNNydCZwn1pXUrjgSwvpLcVrf-ecFub2CABLiUw@mail.gmail.com>
 <CAGcaFA3tZTcppfPMzrpA0W5jS1byYaDwbADMfvKOQfjw8YvMqQ@mail.gmail.com> <331d3a2e-d66a-4118-a6b8-cb0cfbb9b3cf@redhat.com>
In-Reply-To: <331d3a2e-d66a-4118-a6b8-cb0cfbb9b3cf@redhat.com>
From: =?UTF-8?Q?Marek_Ma=C5=9Blanka?= <mmaslanka@google.com>
Date: Sat, 12 Oct 2024 20:30:20 +0200
Message-ID: <CAGcaFA0B=8K7PTOggWkBS7A3MyWpngT6N3GLUkXGy3L_WPvjtA@mail.gmail.com>
Subject: Re: Regression in PMC code in 6.12-rc1
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, 
	Luca Coelho <luca@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Thu, Oct 10, 2024 at 4:12=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi Marek,
>
> On 10-Oct-24 4:09 PM, Marek Ma=C5=9Blanka wrote:
> > Hi Franz,
>
> Franz? I guess you are trying to address me (Hans) ?

Yes! Forgive me for this mistake!

>
>
> > I need to redesign this patch. The pmcdev->lock in the
> > pmc_core_acpi_pm_timer_suspend_resume might already be held by the
> > pmc_core_mphy_pg_show or pmc_core_pll_show if the userspace gets
> > frozen when these functions are being executed, this will cause a hang.
> >
> > Can you instruct me how to revert this patch? Or you can just do it?
>
> Please submit a revert based on top of:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x8=
6.git/log/?h=3Dfixes
>
> with a commit message explaining why this needs to be reverted for now
> and then I will merge the revert into the fixes branch and include
> it in the next fixes pull-request to Torvalds.

Done.

>
> Regards,
>
> Hans
>
>
>
>
> > On Mon, Oct 7, 2024 at 12:57=E2=80=AFPM Marek Ma=C5=9Blanka <mmaslanka@=
google.com <mailto:mmaslanka@google.com>> wrote:
> >
> >     Hi Luca,
> >
> >     Thanks for the report.
> >
> >     Seems that the tick_freeze function in the kernel/time/tick-common.=
c
> >     is helding the spinlock so the pmc_core_acpi_pm_timer_suspend_resum=
e
> >     shouldn't try to take the mutex lock. I'll look for the solution.
> >
> >     Marek
> >
> >
> >     On Mon, Oct 7, 2024 at 11:17=E2=80=AFAM Luca Coelho <luca@coelho.fi=
 <mailto:luca@coelho.fi>> wrote:
> >     >
> >     > Hi Marek et al,
> >     >
> >     > We have been facing some errors when running some of our Display =
CI
> >     > tests that seem to have been introduced by the following commit:
> >     >
> >     > e86c8186d03a ("platform/x86:intel/pmc: Enable the ACPI PM Timer t=
o be turned off when suspended")
> >     >
> >     > The errors we are getting look like this:
> >     >
> >     > <4> [222.857770] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >     > <4> [222.857771] [ BUG: Invalid wait context ]
> >     > <4> [222.857772] 6.12.0-rc1-xe #1 Not tainted
> >     > <4> [222.857773] -----------------------------
> >     > <4> [222.857774] swapper/4/0 is trying to lock:
> >     > <4> [222.857775] ffff8881174c88c8 (&pmcdev->lock){+.+.}-{3:3}, at=
: pmc_core_acpi_pm_timer_suspend_resume+0x50/0xe0 [intel_pmc_core]
> >     > <4> [222.857782] other info that might help us debug this:
> >     > <4> [222.857783] context-{4:4}
> >     > <4> [222.857784] 1 lock held by swapper/4/0:
> >     > <4> [222.857785]  #0: ffffffff83452258 (tick_freeze_lock){....}-{=
2:2}, at: tick_freeze+0x16/0x110
> >     > <4> [222.857791] stack backtrace:
> >     > <4> [222.857793] CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Not tainted=
 6.12.0-rc1-xe #1
> >     > <4> [222.857794] Hardware name: Intel Corporation Alder Lake Clie=
nt Platform/AlderLake-P DDR5 RVP, BIOS RPLPFWI1.R00.4035.A00.2301200723 01/=
20/2023
> >     > <4> [222.857796] Call Trace:
> >     > <4> [222.857797]  <TASK>
> >     > <4> [222.857798]  dump_stack_lvl+0x80/0xc0
> >     > <4> [222.857802]  dump_stack+0x10/0x20
> >     > <4> [222.857805]  __lock_acquire+0x943/0x2800
> >     > <4> [222.857808]  ? stack_trace_save+0x4b/0x70
> >     > <4> [222.857812]  lock_acquire+0xc5/0x2f0
> >     > <4> [222.857814]  ? pmc_core_acpi_pm_timer_suspend_resume+0x50/0x=
e0 [intel_pmc_core]
> >     > <4> [222.857817]  __mutex_lock+0xbe/0xc70
> >     > <4> [222.857819]  ? pmc_core_acpi_pm_timer_suspend_resume+0x50/0x=
e0 [intel_pmc_core]
> >     > <4> [222.857822]  ? pmc_core_acpi_pm_timer_suspend_resume+0x50/0x=
e0 [intel_pmc_core]
> >     > <4> [222.857825]  mutex_lock_nested+0x1b/0x30
> >     > <4> [222.857827]  ? mutex_lock_nested+0x1b/0x30
> >     > <4> [222.857828]  pmc_core_acpi_pm_timer_suspend_resume+0x50/0xe0=
 [intel_pmc_core]
> >     > <4> [222.857831]  acpi_pm_suspend+0x23/0x40
> >     > <4> [222.857834]  clocksource_suspend+0x2b/0x50
> >     > <4> [222.857836]  timekeeping_suspend+0x22a/0x360
> >     > <4> [222.857839]  tick_freeze+0x89/0x110
> >     > <4> [222.857840]  enter_s2idle_proper+0x34/0x1d0
> >     > <4> [222.857843]  cpuidle_enter_s2idle+0xaa/0x120
> >     > <4> [222.857845]  ? tsc_verify_tsc_adjust+0x42/0x100
> >     > <4> [222.857849]  do_idle+0x221/0x250
> >     > <4> [222.857852]  cpu_startup_entry+0x29/0x30
> >     > <4> [222.857854]  start_secondary+0x12e/0x160
> >     > <4> [222.857856]  common_startup_64+0x13e/0x141
> >     > <4> [222.857859]  </TASK>
> >     >
> >     > And the full logs can be found, for example, here:
> >     >
> >     > https://intel-gfx-ci.01.org/tree/intel-xe/xe-2016-92d12099cc768f3=
6cf676ee1b014442a5c5ba965/shard-adlp-3/igt@kms_flip@flip-vs-suspend-interru=
ptible.html <https://intel-gfx-ci.01.org/tree/intel-xe/xe-2016-92d12099cc76=
8f36cf676ee1b014442a5c5ba965/shard-adlp-3/igt@kms_flip@flip-vs-suspend-inte=
rruptible.html>
> >     >
> >     >
> >     > Reverting this commit seems to prevent the problem.  Do you have =
any
> >     > idea what could be causing this and, more importantly, how to fix=
 it?
> >     > :)
> >     >
> >     > Thanks!
> >     >
> >     > --
> >     > Cheers,
> >     > Luca.
> >
>

