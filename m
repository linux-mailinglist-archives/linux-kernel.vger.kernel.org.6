Return-Path: <linux-kernel+bounces-205624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B94F8FFE3C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81673B23952
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A95615B149;
	Fri,  7 Jun 2024 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kOSKNW0W"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF4315B135
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749890; cv=none; b=DbXCZIr0aIxnHFXFx7rCDlxZ6YlyGVl/s0enntVyyQzv2fxBM1ggeT7z0HukvMyABimB86bcfPZzQcQtzyQ19jb+S/fMNoswi4Jvo9FX8r4dvk2hoSAXwjC4YRXzMqAL3uVTBkQbsoZNLsPJYqdHQ1f+SZfFhjrPRyL81Lp6uaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749890; c=relaxed/simple;
	bh=+6hBIEM5DyxzhidynlmsTx8Qt+LbFMnw7Rl6jR3aSWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=KiNKtbSHxkAVoXy9+1Nu7BiPHg/6oI3yd0/QMTdw3GMMVA0iu77AVmO4Kp9hitRv94QPr4+HddNT5ffaRaG35Ca4w2sT4qszw8l71kI/SlDjzNuYVNXhOHCypV0Oygx44y3R49wMylrdpxJOiL72DZwaAVolOyMQl5wDkcBLYWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kOSKNW0W; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2509f93959bso759381fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 01:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1717749888; x=1718354688; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBhYSibF+a35hxu2YgVd+MGY4jpXCfFZWPQQChFfVoE=;
        b=kOSKNW0WuZplVQ2LUfwSIr//znyUPsshFDZmKwHs68+6AxeUYpWC0vqc6uSG9DHQxl
         ZE8ybDZSroyDg5KXccseFZIKs4Qj/ADuaUl2MeDqNQdvPlur0O9qHTt7Wfl5DVKksjDh
         VRjlsDYzsLqJOaRBRaGwpGrzqRLajEHNprasDVw7FGLMGYGJmiPhdH9qUQ/GPMTMLLzh
         JFUyGIesVQE2if7FJyETRSZjnCmL0zukZKsNkI5FnaEBfodaqZFZIzYPgBsP1MSlJMkD
         wUzoMEOX6XUqdynXVr9mVKEPZMiWxAhXUiruzWR/ZBKpGn/VJjVWfrW7+6lMnZD+5ase
         zmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717749888; x=1718354688;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBhYSibF+a35hxu2YgVd+MGY4jpXCfFZWPQQChFfVoE=;
        b=U3c7Xjz2gkUs/QoFvSuQLNfE9x7bAG6GnzG9O/2WVzSm++atbFKjc1/cwuZZPjGpPn
         ieXhNFG6KwVkElYSeZ2y7/oNXKDNUcifjfGQrMJGtZGzBhJiuVBFMV4KY5Hkj2pEjEAm
         A0aXutckamePONBVr/dKkrXVkPUXJukI6uudfeHvQk3phF53dbfsyG9MTJgUZpA3RU/e
         EmfHBrIyDTfz3NJjqKoUn2cfYmPFPlWEjcZNAG1XZJlz41nV3oscvUw1GVrQ/xkdPODJ
         4FrS6tRTMWWxXm4JPTSxpOgbNUQ2dqaXftgzuEfSKSCxN3YugZLzeTiDq5Y/Ha61kzxz
         yL6g==
X-Forwarded-Encrypted: i=1; AJvYcCUB7Hc5WNp4Bql8ejLwEq0KMS4KcBaKQhVk3IASClvrByVlF2MQpRgcpx6IwiMeiIQv5rVGJ8jfwaRYBZuKgxE6285+2QJwJCUcIALp
X-Gm-Message-State: AOJu0YxCoMT2lDgriqU/VSHjb8+26EQTmfwPPSv2eU9OxRqpDLjLw2qQ
	YxeXXzbNJy/meh+2kvYJC8rkzLsHSkF30RounVjrxl2uFwiuu72b0jaSLRiu3Kbq6JvfrEkBNEM
	DCjX6XQ0o+cpIP8heKRACvlmqxKFr6FCjNQFRqAVXRVwajLO9D+nmro0C
X-Google-Smtp-Source: AGHT+IH4QZY+ZKLUXRGchLj2W3aOWavVA61yDoBIwSD9qlh7Awpft0cnk5o+nzwjFobUUAl+CGuWVVoAbw5HqZ8ZVjs=
X-Received: by 2002:a05:6870:1690:b0:24f:c2c8:4d3e with SMTP id
 586e51a60fabf-254402bc340mr2461247fac.3.1717749887788; Fri, 07 Jun 2024
 01:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523111322.19243-1-cuiyunhui@bytedance.com>
 <20240523111322.19243-3-cuiyunhui@bytedance.com> <CAEEQ3wnE+8FXXf76zapqNnC5vruoR9C-y0qjjFw47cHYP57MmQ@mail.gmail.com>
In-Reply-To: <CAEEQ3wnE+8FXXf76zapqNnC5vruoR9C-y0qjjFw47cHYP57MmQ@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 7 Jun 2024 16:44:36 +0800
Message-ID: <CAEEQ3w==wueTSDvEtJe+t7jamH2ERxta4uPLUFVwX2ueRLJ3Bw@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 3/3] RISC-V: Select ACPI PPTT drivers
To: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	sunilvl@ventanamicro.com, aou@eecs.berkeley.edu, 
	linux-riscv@lists.infradead.org, bhelgaas@google.com, james.morse@arm.com, 
	jeremy.linton@arm.com, Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, 
	sudeep.holla@arm.com, tiantao6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sunilvl,


On Mon, May 27, 2024 at 8:51=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi Palmer,
>
> Gentle ping ...
>
> On Thu, May 23, 2024 at 7:13=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.c=
om> wrote:
> >
> > After adding ACPI support to populate_cache_leaves(), RISC-V can build
> > cacheinfo through the ACPI PPTT table, thus enabling the ACPI_PPTT
> > configuration.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  arch/riscv/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index f961449ca077..a9ebecd72052 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -14,6 +14,7 @@ config RISCV
> >         def_bool y
> >         select ACPI_GENERIC_GSI if ACPI
> >         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> > +       select ACPI_PPTT if ACPI
> >         select ARCH_DMA_DEFAULT_COHERENT
> >         select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRAT=
ION
> >         select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
> > --
> > 2.20.1
> >
>
> Thanks,
> Yunhui

Could you please review or ack this patchset again? Palmer did not respond.

Link:
https://lore.kernel.org/linux-riscv/20240523111322.19243-3-cuiyunhui@byteda=
nce.com/T/

Thanks,
Yunhui

