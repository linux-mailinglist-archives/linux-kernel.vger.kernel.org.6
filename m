Return-Path: <linux-kernel+bounces-175387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C058C1ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5633B22BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104FE15ECCB;
	Fri, 10 May 2024 07:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tj67IyiS"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67B41DFEA
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715325179; cv=none; b=W1X7MnAnbcyy34MczzM3TnpFPjAti98nxJgjzQ/poXJDlVFRoRvTtdzbBxJVKjJaYrvqGQlY7gvvFTi7myl8hyTwtwRGdTRusbGWD4OLMqQ6oyDqRnD1FyHJr2IiXyjTAw2l0aIjXVTVy+8fP33Bau+FLBwU9XbbnCQ9vb8EpF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715325179; c=relaxed/simple;
	bh=nSEvWn/MJ1GuLe8np3Sa/SeLRLIZLDwhELro+CKV/is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=J6M9x+DY4ndndBGMTjuZvLpl0JlQI2T/o/sTcpkjSSUwxkneTn74xsNt6oF9eZ8TTyYfBE1RrloN3TaLMFaOrQuF4o1cAi2v3NifPa0cl1hVzctCdfcKfuP6omNXAt8C7rs4lIZ4XM6F6vy/FEXT96QzMtzC6BXjtTWAnTzKWMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tj67IyiS; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-61df496df01so14463407b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715325177; x=1715929977; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5v3LNTx5UHv7DHicqQqCxhP1sKbUlvhOMCjKZAm7hSo=;
        b=Tj67IyiSPqxaCZNLp/HZQR9X8L5BQmhhFmBCGKzD3YkLtc463TsENvI9hCfjfJbCTK
         lgCdB6i5S41bz0pjRYqxRy/vsgjkFoC6kZqCBmmu0NYUEE2SDIT+H/Dwlsrr5grw3Vlr
         5rRGRAIfGQtH/jyfTGM18GiqA6ql98ASHUO1H3/xJkSEnoivFuNyuqPWqq6H/2YuAOXX
         8Vz/pdzDSdIt73mj9H9xlSeRoVxFu76pHqiwYrHmF2b3dODd29xue36k/3rTE/Ej9Uq9
         QE8i+V/6oXIPmE6H4if3L3O4QAYCRJ8ngNdxs4Qsxrdt9kfjDhpOPGozlIkqIE1WRry7
         N1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715325177; x=1715929977;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5v3LNTx5UHv7DHicqQqCxhP1sKbUlvhOMCjKZAm7hSo=;
        b=wbACTEoYC00bhWi8AKAguVlnejQZDlttFTBYdpns72QjMIcvkaIOFsh+EuDS9Afgus
         HAuOp2DEHjw76gTtJZScPGu4wxObKHr8EERRPaTcS+GVtZ3zq3fA6pXznRAjStjzo+HH
         XX9U9rlLRC55K/WHZiNsFEoVtZTEtaX8DHxnLvqzexblJznicCWikAvH6ndQ7CONlLJs
         QmAh8hzD8ijVOrkPC4/FgqCF5P5kUzEY0eidX7Up/5Nl07i3WMu4nWeKRCBJ+r9nzDe1
         dsgmPEYyT8gR8Uw7huubQATW+9bGZWU4lR2+myfKuGUPjPTUQbymalBXxyzvDRrRpCDU
         IpOA==
X-Forwarded-Encrypted: i=1; AJvYcCWu7X+p0EMdQISmwdG5616YNWP6ryfzVqoaE6VUO0dtWQw+MTzwPzm83dGxLMQdAJ4Y++dKBO8+LjWJ+HsZoqZcS1A26oORwazwEOqL
X-Gm-Message-State: AOJu0Yz18Lsh2oWkezgsVajZjlppJE52z+MTtQWd0k+qZT8YoHXyJ58s
	4DBWJwyXALPUGwjXLLv6bXlXreC2nCzPI5sAZj7iPMrI9Uk4HKEXrZs798KDUqauYFshpcKNLIR
	I2+A8lGoeVmjRoIeY6eF9rlsTxPs=
X-Google-Smtp-Source: AGHT+IE2wxh/kp8jdgXj7C62ifgVpsjtE/ghDxMXs4QCeLp9oEKr4/fHfpsQiA8E4yrhdLLTMA0JXZq2VX4G2j7T64M=
X-Received: by 2002:a05:690c:4382:b0:61b:8623:3718 with SMTP id
 00721157ae682-622affda7a7mr15482777b3.42.1715325176320; Fri, 10 May 2024
 00:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SN7PR11MB660461A6E5F3FB4546B5BDB9D9E62@SN7PR11MB6604.namprd11.prod.outlook.com>
 <CAHhAz+hvb+8sT3BYS_pT3Lmi5X4PjYWRJR=hvmX1e4Ays512FA@mail.gmail.com> <SJ0PR11MB662433ACA8369FDCADC085A2D9E62@SJ0PR11MB6624.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB662433ACA8369FDCADC085A2D9E62@SJ0PR11MB6624.namprd11.prod.outlook.com>
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Fri, 10 May 2024 12:42:45 +0530
Message-ID: <CAHhAz+gsOpaGPOMLLeGUrDjvUPSp=ZwxgQvOzvjk+zj4=gwo=w@mail.gmail.com>
Subject: Re: Seeking Assistance with Spin Lock Usage and Resolving Hard LOCKUP Error
To: "Billie Alsup (balsup)" <balsup@cisco.com>, kernelnewbies <kernelnewbies@kernelnewbies.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 11:27=E2=80=AFPM Billie Alsup (balsup) <balsup@cisco=
com> wrote:
>
> >From: Muni Sekhar <munisekharrms@gmail.com>
> >In the scenario where an interrupt occurs while we are servicing the
> >interrupt, and in the scenario where it doesn't occur while we are
> >servicing the interrupt, when should we use the
> >spin_lock_irqsave/spin_unlock_irqrestore APIs?
>
> In my experience, the interrupts are masked by the infrastructure before =
invoking the
> interrupt service routine.  So unless you explicitly re-enable them, ther=
e shouldn't be
> a nested interrupt for the same interrupt number.
>
> It is the code run at process context that must be protected using the ir=
qsave/irqrestore
> versions.  You want to not only enter the critical section, but also prev=
ent
> the interrupt from occurring (on the same cpu at least).  If you enter th=
e critical section in
> process context, but then take an interrupt and attempt to again enter th=
e
> critical section, then your interrupt routine will deadlock. the interrup=
t routine will never
> be able to acquire the lock, and the process context code that was interr=
upted will never be
> able to complete to release the lock.  So the process context code requir=
es the
> irqsave/irqrestore variant to not only take the lock, but also prevent a =
competing interrupt
> routine from being triggered while you hold the lock.
>
> Bottom line is that if a critical section can be entered via both process=
 context
> and interrupt context, then the process context invocation should use the=
 irqsave/irqrestore
> variants to disable the interrupt before taking the lock.  If it is commo=
n code shared between
> process context and interrupt context, then there is no harm in calling t=
he irqsave/irqrestore
> version from both contexts.
Thanks a lot for the detailed clarification.
>
> Otherwise, the standard spin_lock/spin_unlock variants (without irqsave/i=
rqrestore) would be
> used for a critical section shared by multiple threads (different cpus), =
or when your code has
> already (separately) handled disabling interrupts as needed before invoki=
ng spin_lock.
>
>


--=20
Thanks,
Sekhar

