Return-Path: <linux-kernel+bounces-309160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9297D9666E1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5188128249F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9EA1BA876;
	Fri, 30 Aug 2024 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N2/FSbNa"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F891BAEF5
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035262; cv=none; b=US/2tzs09fo3j8V5UzOzvw9rib7zb3X51nYN3pHi/9jeu4JN1tQ6qpciv2WEZUGkyrJghy26pmKyeZVViM1IqvSqN3zz9JI0cmKzeuqXJd6G4k1L/8nqIEcs5cdU5g75tRguoSXWMZAsfEy8hn91efwt3NkLWR0K/S/eO1RAtrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035262; c=relaxed/simple;
	bh=AXr8qG8tIygoEKcf7AKMHYWTkNPB8Nv9qUqlMLkvA/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeMXxRaYsXbBMP82wEdnENmMWdi0nleuAxHwRnLGqJnsKgXGtaJ+Xvr+5IiEm/IFq0mpseFyKaNQr1IdPchvKe1AurqzNwLdnoziVx3CyN40VJjiC9V3KH+Vn8KdTXYf0/HvrZlhfk2/+YOOMzrlbgEY65ct4zvvl7sHPylWc+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N2/FSbNa; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bed0a2ae0fso2109915a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725035259; x=1725640059; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4blPcePziWLyzuPvJxOTQGTR3QYe2HPCb0g45Ev3gcA=;
        b=N2/FSbNavDcOn7tClnjGMLBumDMxoSqv5ms6P57gCM3OlWOpo+I7NSzs5KuB18E5rI
         nSP0YWBd/gyjIxgaIui2Oz2Sb724RpAIEvdI/nck1H8y96t+cPwxpxupu3ifzEgik1JI
         tpfRpEba6AhzR6TgXU1bwXrCh4weH+HAFbIuAoEpCF4UTc2I6Pd/Y1mjHl0xb70NRSAm
         lhSaGwY3PoHoIt5JR1T1YFmgf5oMUcAvDrovWUnXgOlAkFX2zPHKE5UF1dMhbYqx5b3P
         StGrEn51fM6ks3sYSXTOrsgLO1uFWkRmTQjlPFOxhrlEQ4AmvYdGUoTXz56e/eREFbCf
         5H6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725035259; x=1725640059;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4blPcePziWLyzuPvJxOTQGTR3QYe2HPCb0g45Ev3gcA=;
        b=b070bIeWeacLmuWD5NGhLSIQHix4Q9iW8PjY/ZlQ+VUcXJkF+c8iJobtKjgqocJhBM
         mUfYCCrwVr8oQr8GfKOij1E/h2+jYYZJRPiklHLXhSJdsk2lqEfksaKcoFQEtb+qiOYw
         jZs+jX9xi6s83B7oq053VXjHoRKNUSclWMjSI82ZjPb92KnZnK5EP+E1heo7iNI2Nbeu
         tZPg0mDy+IWi0uXmGsAIT3aZTfHoU5j+I/F5slHqqkA8ZWFBSZCAdR4voXMz3JENM5Mz
         Hmhh+5K/sQN+qkaNcRW+3dvfJ9B5ZE5wfZLBmuc67Q5CibEPbO8oV3CYnCKNoeZWtcFy
         cfww==
X-Gm-Message-State: AOJu0Yxya1iyrbSvAxmMthPs4/th/bzP15PBKpLWI42ndPXcDD0uNaCx
	OWYhDI6r0ctjdZsNUjRl9EYslc7SRW3TNfLOMqeQKhwFc6304dhVHwUgiJ0kEjFwXMBsKEq9HXc
	bUvtM3NrGUL+MzPE4aXUN6/s57v5XtD9XIrgiq+DmebYDdZx+
X-Google-Smtp-Source: AGHT+IFwkkcq1m0brgFB+wZdvpZoo9DWCXjBJZUFaFjTNuFDCSe61rwDAQw9f5TUteoh63/mT9oXpuuYj91NFQKfQew=
X-Received: by 2002:a05:6402:2696:b0:5c2:18fd:8a22 with SMTP id
 4fb4d7f45d1cf-5c21ed31392mr5566950a12.7.1725035258972; Fri, 30 Aug 2024
 09:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
 <b88fe895e6f71711387ca153f4f1b3fbb0aa2176.1724556967.git.mchehab+huawei@kernel.org>
 <CAFEAcA-OaQ1ypa7LXz5nOs+6+fjmYNHzNL0VVgapoXEHU=rHnQ@mail.gmail.com> <20240826035324.6b1edcc7@sal.lan>
In-Reply-To: <20240826035324.6b1edcc7@sal.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Aug 2024 17:27:27 +0100
Message-ID: <CAFEAcA-wD6U+onh3y4Y-LDTFuYoeWbGShkRPx7emi1ZPfKJP0w@mail.gmail.com>
Subject: Re: [PATCH v9 11/12] target/arm: add an experimental mpidr arm cpu
 property object
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Aug 2024 at 04:12, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Sun, 25 Aug 2024 12:34:14 +0100
> Peter Maydell <peter.maydell@linaro.org> escreveu:
>
> > On Sun, 25 Aug 2024 at 04:46, Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:
> > >
> > > Accurately injecting an ARM Processor error ACPI/APEI GHES
> > > error record requires the value of the ARM Multiprocessor
> > > Affinity Register (mpidr).
> > >
> > > While ARM implements it, this is currently not visible.
> > >
> > > Add a field at CPU storing it, and place it at arm_cpu_properties
> > > as experimental, thus allowing it to be queried via QMP using
> > > qom-get function.
> >
> > >  static Property arm_cpu_properties[] = {
> > >      DEFINE_PROP_UINT64("midr", ARMCPU, midr, 0),
> > > +    DEFINE_PROP_UINT64("x-mpidr", ARMCPU, mpidr, 0),
> > >      DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
> > >                          mp_affinity, ARM64_AFFINITY_INVALID),
> > >      DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
> >
> > Why do we need this?
>
> The ACPI HEST tables, in particular when using GHESv2 provide
> several kinds of errors. Among them, we have ARM Processor Error,
> as defined at UEFI 2.10 spec (and earlier versions), the Common
> Platform Error Record (CPER) is defined as:
>
>    https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html?highlight=ghes#arm-processor-error-section
>
> There are two fields that are part of the CPER record. One of them is
> mandatory (MIDR); the other one is optional, but needed to decode another
> field.
>
> So, basically those errors need them.

OK, but why do scripts outside of QEMU need the information,
as opposed to telling QEMU "hey, generate an error" and
QEMU knowing the format to use? Do we have any other
QMP APIs where something external provides raw ACPI
data like this?

-- PMM

