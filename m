Return-Path: <linux-kernel+bounces-221945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9499D90FAF3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 025C0B22D22
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 01:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C87212B6C;
	Thu, 20 Jun 2024 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ac3vsA+J"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6234125A9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718846912; cv=none; b=YCCmPheKrBEGR9CatO60IZ6jaPhH4rWHBg8uQZKxxgbNJbiO7Qkm7wYKCFeL9njzXHx64BXx/NP0OPH5CiCBn0RFF6Hg9Z3ZodCFnPYbUQcTPZMF5pyRkLp8NI78+khA0Q9So3EXX7nfR4ebFuIYyzLuRxNewjTOrqP0+8LQUiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718846912; c=relaxed/simple;
	bh=H6vCEco6jQVwaOX7xUNWdQhOvu/xshILozEhAN0RF6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXvCBXpIO7iC/6k3/cbs/uefoStLYWlHZQES6Ka5YCzvEepzX0nacrj9M/LmvCNjpBL3qOqAtg3juYdqmf1EBl7PET0dMMPKFYZnGhoTslT6N6D6b5TKwzcZnbQWt2BHPDUwSDdJ5PjYrO02D7jsGQvZRkWWqFAGMm1LkuIQOx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ac3vsA+J; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-254c8e27c80so274139fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 18:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718846909; x=1719451709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/ekbBeZLQlbT2zg5ACeIcCnuktUUqjjWBwu4AREAPo=;
        b=Ac3vsA+J4TlIo9yDoKGnepxJthAbJFF0JQm1AEG1fEXrJK/RYhXxYJFd7+CeA4/XJY
         3kgeJHqOHcoqP9spKzmGjCA0PHoI1QNvsm87rSltLoV+1J3UTDZKZ+eeXwBVSdAm/6p+
         6Iju8rQg2atR4hkcBF1Yk0Rtp0gLumoUXq72wjnwl2qV2A/JpKfedhfPjbEdiwVqDUAw
         aAT6FvsB/LTgylH4RgA/+1vASpwkrtVEPw99+FSKm2zLce89HwMxDwAHIPWYP4ACKtYn
         RQDBpoOwtW06vR/krk96mIUP7kYrqNAOUWo4OZYr2nEsU2xs3vZWErbrVHs0jdGPYtCm
         RWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718846909; x=1719451709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/ekbBeZLQlbT2zg5ACeIcCnuktUUqjjWBwu4AREAPo=;
        b=ZmzgrLhhR5F2sAFbpKiqcBex/vhlP4QlGJPv0pvZ6fRkuFsEwpgaX+I/CFZrZQ6KgO
         fBfUTHrsqDMyHTTN0L+eDz9x1J+pzEuldfU21+iAHgyxrwaXCQLXQmyu6j0ZuicWAuuv
         PqzJWYHAdZbQf+gY6Yjj/NI4eR3Tyr5hc4+n4KxidmbjLG2kdiryoPBNBQD5K7za0Rqr
         WbflynNtRHz477TRjIsevL7LK09MpuPruHtXA0ZFt+dQn2/ZTU9cOM6a35Rg6gFsTG8v
         dlU+g4VINNCPRm2O7bWvcjO3Y5WY2i0nEJESj2E4V/wW9Oe7V/OC57RXCQresDrm3F/5
         3cVw==
X-Forwarded-Encrypted: i=1; AJvYcCXygfnRnGqn+NFhqEEl5mHH3hGHxrBGvc3lZOWUmV9grYm51LlkFBYw6ScVDIPwfSBMkkjIWgIUsHFmoy1uNsjWp8Zw8peOJzCe0avT
X-Gm-Message-State: AOJu0YwjQX3/hTN3gwpcduhCgHDek8U6p6iryUKIgUbrNM1Xl2odqqmn
	Nzmac00pOvV0qiDmmSyEIPKiT7SSQLSvn+b7aaOh/2TJlqQobpOP0c6qZfMb+kNho28KyYLY97Q
	r8ykkGOnBuJo2/Z83ZSZ6dqaZqlYix1On/6cyRA==
X-Google-Smtp-Source: AGHT+IGBBD4sgjyzChNhQD41x5cYm6++WrkWNpZZqXfJd6go6IeSymufFhAE2wLDdg5D7Zri2qLbf+MT7kpvOJiYs18=
X-Received: by 2002:a05:6870:148d:b0:259:8b2f:8d76 with SMTP id
 586e51a60fabf-25c9498dc84mr4604434fac.20.1718846909622; Wed, 19 Jun 2024
 18:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617131425.7526-1-cuiyunhui@bytedance.com>
 <20240617131425.7526-3-cuiyunhui@bytedance.com> <CAEEQ3wnkQsfmLbyMrG_YBvWvhHJdSTg7dG5W_mxv_wxCjatgCA@mail.gmail.com>
 <ZnLY3mNxyv9QOmGn@sunil-laptop>
In-Reply-To: <ZnLY3mNxyv9QOmGn@sunil-laptop>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 20 Jun 2024 09:28:18 +0800
Message-ID: <CAEEQ3wmarOoWWYrdpf7YNQdZG4rf_O4dHkeiO3W1cuavVh8TMQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6 3/3] RISC-V: Select ACPI PPTT drivers
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, bhelgaas@google.com, 
	james.morse@arm.com, jeremy.linton@arm.com, Jonathan.Cameron@huawei.com, 
	pierre.gondois@arm.com, sudeep.holla@arm.com, tiantao6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sunil,

On Wed, Jun 19, 2024 at 9:11=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> On Wed, Jun 19, 2024 at 07:32:18PM +0800, yunhui cui wrote:
> > Hi Sunil,
> >
> > On Mon, Jun 17, 2024 at 9:14=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance=
.com> wrote:
> > >
> > > After adding ACPI support to populate_cache_leaves(), RISC-V can buil=
d
> > > cacheinfo through the ACPI PPTT table, thus enabling the ACPI_PPTT
> > > configuration.
> > >
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> > > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> > > ---
> > >  arch/riscv/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 9f38a5ecbee3..1b4c310a59fb 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -13,6 +13,7 @@ config 32BIT
> > >  config RISCV
> > >         def_bool y
> > >         select ACPI_GENERIC_GSI if ACPI
> > > +       select ACPI_PPTT if ACPI
> > >         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> > >         select ARCH_DMA_DEFAULT_COHERENT
> > >         select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGR=
ATION
> > > --
> > > 2.20.1
> > >
> >
> > Gentle ping.
> >
> Actually, my RB is still valid. Anyway, here again.
>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
>
> Thanks,
> Sunil

Okay, thank you. BTW, when will this patchset be picked up to linux-next?


Thanks,
Yunhui

