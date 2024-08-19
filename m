Return-Path: <linux-kernel+bounces-291633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2BA9564F6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0172B1F22D28
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059E71586CF;
	Mon, 19 Aug 2024 07:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eODZ1V7S"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B173614A62E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053770; cv=none; b=rzZoUwrjMdTBFHPIU5EwiOse2YUNwyhEUYGOJTQwYY7ZOC7hpLg1qYS3pKsJ+O6cA9gBg1gKdPHF85kHup67k0Gzio2whv+sfix1ifTnTUG6lvFb3UufhuK7Mj6Y/eQaw8Zf1OjguVP/aqcGDwfHBi1++DSvHLrD0ehxkKBLNw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053770; c=relaxed/simple;
	bh=dBBrPIfbp6qwkjh5voowEDdDMFxyyxt5vSOUgIS7qlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrbK5VWrikArAB36O6lddVZlsdL2AlbFxuFVIyc9DwF/RbaobN91ZfUSQU93dO2PQ9B9Ew8yP8oDKY8W+QsWZYTTrkmPRGG+I3fOl2Jy7hV/6zDGv1OJNwMb/ZLW9xKV2D28KJkNyV63LwcW93tDSlYvPyc+dyH8egpshNgzhBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eODZ1V7S; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d3b36f5366so2710492a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 00:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724053768; x=1724658568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUVuHKHVrcEtqoNkxteJqRlTWi2IdXz9WHlXJpbxXpI=;
        b=eODZ1V7SMZx3JS87TxqBgCHFFrbeMMJtJtXuc/9ftnSOgfTd0FO2qXzYex2IOAKsIs
         vb9WlHHkAqNoM5/ltQFNJWYAKStkCPNQAa167gHsp5vANSihQ2SUkbc0AwYsrB66kRyo
         nxdQxed2iRniy45Bg6EkOJvb6RCBuwudhN4m6Oud/BD06H4qwzORfrwPkjeRVYXr5hya
         dYhiWqLdnZ529UUR1wpw4fT1kaEp0a6AJU9q14+sdj5+rFB6TiEk1Yx8l/vGEUKg+wOy
         to9r2Fk7jQtwxXngpdl8rEFKxvSqdRS+WD5QakqTzCVd2UJXJNTxEKyt+46eJ0Ru92iR
         bezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724053768; x=1724658568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUVuHKHVrcEtqoNkxteJqRlTWi2IdXz9WHlXJpbxXpI=;
        b=tqHcvD6bkgY3cxjD4yXzmskRp0xrdv8xkPIgnh8CA9U1uiVHHmL781D51KnDVYR4EM
         DCDAo3I72X+dM0UjU99/VJfX3BYK2AQuoC5Mt8qzCqn+VCpANQPHn7YGFK/vXojjRc6m
         ZPu4RjW4DdmEGKhfp1etAtSlf1sLtRVGtt9ODcFgWf+r4X6sG1GdwOiMJqqmxUsQmhMS
         3pF4K5pm+SZ+ZfTiel8V0N6KwiLxcldai5hFYjm1yZLuvooGyuo2MWiKh/pDu0k5Pyv4
         4mpXXjymmz1/6Z9TaXDjBtBKL2OIv78KbtWJSfAH3d5+52vaEN1eYGwoNleachV9xFWM
         gKxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYchXJz9U3bYCTQ+hyp6u5s5K2fOB7a3LXmSBnTn8QJuK6NoHDvf0Hm7Sih/geoj8Dxcm4O+hi4mtWDc8Y6iMzvaJ42ee3qlkL2ZE0
X-Gm-Message-State: AOJu0YzWFh2qQEjNXXD6JQkR+OPHeYCVLD3YrQGsrfEN646C06QD2L9O
	I9Aljd2mU3/LAIeS/dN9694mz8fnOlBLRVOnfTnGPvT5YkIai4lxYqntEx2SPQ402PQ+C2W+rPu
	Anb2VcoTlXRpcQ51WBipZ/DTGuGRrsFZcgtclIQ==
X-Google-Smtp-Source: AGHT+IGMUxO+SbJNNsJNOeCjlAxiHYJmrGmzXoT7AF6Cdx1Io2AIZBXwOGeT+8FzlSsn1R93xMpQ61uziEW80Qs3BTQ=
X-Received: by 2002:a17:90a:c28b:b0:2d3:c4d3:de19 with SMTP id
 98e67ed59e1d1-2d3dfac98f0mr8696169a91.0.1724053767927; Mon, 19 Aug 2024
 00:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPYmKFsTcurrUiWqM8cFj+GgqfRiaLqPDGOTSE+RLyKJGSKE2g@mail.gmail.com>
 <B0C91D33-8C1C-4C67-B9B4-41206EFD8ECF@jrtc27.com>
In-Reply-To: <B0C91D33-8C1C-4C67-B9B4-41206EFD8ECF@jrtc27.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Mon, 19 Aug 2024 15:49:16 +0800
Message-ID: <CAPYmKFs7ZyHyKo8uULvYp3YK8ABOJo8+FWDG_cr2YU_cXgfRww@mail.gmail.com>
Subject: Re: [External] Re: Some feedbacks on RISC-V IOMMU driver
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Anup Patel <apatel@ventanamicro.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com, Will Deacon <will@kernel.org>, 
	joro@8bytes.org, LKML <linux-kernel@vger.kernel.org>, 
	Yongji Xie <xieyongji@bytedance.com>, iommu@lists.linux.dev, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, wangqian.rd@bytedance.com, 
	linux-riscv <linux-riscv@lists.infradead.org>, robin.murphy@arm.com, 
	Hangjing Li <lihangjing@bytedance.com>, baolu.lu@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jessica,

On Mon, Aug 19, 2024 at 1:17=E2=80=AFPM Jessica Clarke <jrtc27@jrtc27.com> =
wrote:
>
> On 19 Aug 2024, at 04:56, Xu Lu <luxu.kernel@bytedance.com> wrote:
> >
> > Hi Tomasz,
> >
> > Thanks for your brilliant job on RISC-V IOMMU driver. It helps us a
> > lot for what we are doing. Below is our feedback on the existing
> > implementation[1].
> >
> > 1) Some IOMMU HW may only support 32-bit granularity access on its
> > control registers (even when the register is 8 byte length). Maybe it
> > is better to provide a 32-bit access method for 8 byte length
> > registers like what opensbi does on ACLINT MTIME register.
>
> That OpenSBI has to access MTIME piecewise is a workaround for a vendor
> not implementing what the spec clearly intended, even if it wasn=E2=80=99=
t
> explicitly stated (but is now, in response to that). Repeating that
> situation would be a pitiful mistake.
>
> The current IOMMU spec draft very clearly states:
>
>   "Registers that are 64-bit wide may be accessed using either a 32-bit
>    or a 64-bit access.=E2=80=9D
>

The spec's description about this is pretty confusing.
 "The 8 byte IOMMU registers are defined in such a way that software
can perform two individual 4 byte accesses, or hardware can perform
two independent 4 byte transactions resulting from an 8 byte access."
It seems that there is no requirement to implement 8-byte access.
It's OK then if we think this is not a problem.

> Jess
>
> > 2) In the IOMMU fault queue handling procedure, I wonder whether it is
> > better to clear the fqmf/fqof bit first, and then clear the ipsr.fip
> > bit. Otherwise the ipsr.fip can not be cleared and a redundant
> > interrupt will be signaled.

By the way, it seems the irq handler must clear ipsr.fip first to
avoid missing out some faults no matter whether a redundant irq will
be generated.

If ipsr.fiq pending via fqof/fqmf is implemented as edge triggering,
then ipsr.fiq can be cleared at first. In this case we can not clear
ipsr.fip again after clearing fqof/fqmf bit, as it indicates a new
fault to be handled.

If ipsr.fiq pending via fqof/fqmf is implemented as level triggering,
then ipsr.fiq can not be cleared at first and a redundant irq will be
generated after this handler's return. But it is OK as no fault will
be missed. Otherwise it is hard to detect whether the ipsr.fiq is an
old one or a new one.

Please correct me if I have any misunderstanding. Looking forward to
the subsequent code.

Best regards!

> >
> > Best regards!
> > Xu Lu
> >
> > [1] https://lore.kernel.org/all/cover.1718388908.git.tjeznach@rivosinc.=
com/
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>

