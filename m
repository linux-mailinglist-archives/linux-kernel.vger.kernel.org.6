Return-Path: <linux-kernel+bounces-190612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096FE8D0074
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A201C222ED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2038F15E5D0;
	Mon, 27 May 2024 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aWtUyG3N"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144215E5BE
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814332; cv=none; b=id6zuSe2bKr2k4o6PDxv8NHXowMg8Iz/MUWATrY72zo/IPvcKITpxHaA7xBxkiyNJciMWZlnZvTN/F8bz3G779ibUeyiDUF70/tmC4i2Abm8vAGy3tA2ZZ6PNKJCsudQ0ptD1e86AQIv665L1yBKZCzWEv4WkCRElYMvjB4ik6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814332; c=relaxed/simple;
	bh=MiGSg2DVarbMyLbJiHXGtEZVkuuMShi5RwBLr/tjlOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Q0p6HhcXWtBpYeNho1S6c4WrIYxsdz3YRamPOavcMXVG1ro7BqI/o6uRgKkf5VvAOFqQ9w5bk9u/YWvWnmmG13Y+d438DPI2vqy+IJ1tMqTuwRt+5zvju0R4qfqrvN4WMGlJNMDTUoop0LiGAv/V/vUBVTul0Y32DAy2Gy7HuXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aWtUyG3N; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-24ca03ad307so1809280fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 05:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1716814329; x=1717419129; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VNs4oFMLk5Bxve1lZWNZ/kvg56aSZ6dBKt3FEfaoOw=;
        b=aWtUyG3N/TYslBGkr156D2iLHLkIadJAzhF0kN+s0+iQrSujsExmPvS5QJ3j1MnEaU
         vgc0y/Ze3v07PKideScYsNy7XS42leI5GYn3FM29MCCIc/GvWUrDcMFDBFTAskjH8vk+
         OAY2OuGB5ZoL1jxR12dKx6I3ZQL8F4l8oV2fL3DanKVKMEoFt4zIMLI8DJcv2yI5m0Zc
         RBkUmKI9DS2pTYIDYvMBjYf5aF5IQRwf3+1bTzxBhSiOmtWGREpbFNnqB2QPd6CR3P2V
         8LanbEc9b1IwAckjuo8ajFNEA6HIx2FAHGR4QZuvj8YQuXFySKvbZMr/FFdEZhV1hjKr
         t2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716814329; x=1717419129;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VNs4oFMLk5Bxve1lZWNZ/kvg56aSZ6dBKt3FEfaoOw=;
        b=CNDZKNM0xcZOBxprqsAkdd5G1oIOp+j9UyZvxYMkz8icf7xPKPRJl2vxAiac6SeZ7j
         UEZkbkRkPcgC0tDI6SunHkEtMg0g7yaDaAt/QPlXXzXO+8KZLVoWbI5352vSBiIGO606
         Hnx444LBXJEhc3T0NhHxxJGqsbFW3CdHcdbuEoFA2iTfs4m8A4IzHrMr9eTfrxv8il0U
         h9U30e7j6cGEDwL+p5VU1INLahiUTmScAmBQmKRnM2XpAkmezGL1Jd2URFtSnVm2kSCt
         RmJQfcQLwklTR1+1MqSav6Nb3NBDPFSGuxlaHAJKH6404hd4lb1dVg0jeQi20tIRzfBl
         QDmg==
X-Forwarded-Encrypted: i=1; AJvYcCXkdmsVAUlf+vOTI2jbV3deFzh8TFArFNbaVk59h/CoBS/nPE6RG9qVGffD5gqMCO5fIBxZZw2OeLabqmV0zkOjdNE3zt9I5UDKKxdg
X-Gm-Message-State: AOJu0Yzufe3cwV2IAlAK/XbadInFcgCVIZGHm541JvIXjhBESE0OdgnC
	RY1H8qDa3NG1g/x095x3IrLOvSiZJ66zh8+yVagC8EOpDecsCqe/Exc+34ewj8fWWgdzUI1tC2V
	R9EXRiUX3xKG/Wa77tBhEogqlwQH/XwRUjPuTAQ==
X-Google-Smtp-Source: AGHT+IFVFWgWxhliY5IXKCFKP9m7cDXkraybWH9+iqYWLKMEa+9I0GGRzLeE9MBVs6oZk8aZlQsaGyKMaOogBnll8yY=
X-Received: by 2002:a05:6870:1495:b0:24f:eced:8a38 with SMTP id
 586e51a60fabf-24fecedcff3mr4083403fac.56.1716814329558; Mon, 27 May 2024
 05:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523111322.19243-1-cuiyunhui@bytedance.com> <20240523111322.19243-3-cuiyunhui@bytedance.com>
In-Reply-To: <20240523111322.19243-3-cuiyunhui@bytedance.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 27 May 2024 20:51:58 +0800
Message-ID: <CAEEQ3wnE+8FXXf76zapqNnC5vruoR9C-y0qjjFw47cHYP57MmQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 3/3] RISC-V: Select ACPI PPTT drivers
To: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	sunilvl@ventanamicro.com, aou@eecs.berkeley.edu, 
	linux-riscv@lists.infradead.org, bhelgaas@google.com, james.morse@arm.com, 
	jeremy.linton@arm.com, Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, 
	sudeep.holla@arm.com, tiantao6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

Gentle ping ...

On Thu, May 23, 2024 at 7:13=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.com=
> wrote:
>
> After adding ACPI support to populate_cache_leaves(), RISC-V can build
> cacheinfo through the ACPI PPTT table, thus enabling the ACPI_PPTT
> configuration.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index f961449ca077..a9ebecd72052 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -14,6 +14,7 @@ config RISCV
>         def_bool y
>         select ACPI_GENERIC_GSI if ACPI
>         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> +       select ACPI_PPTT if ACPI
>         select ARCH_DMA_DEFAULT_COHERENT
>         select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATIO=
N
>         select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
> --
> 2.20.1
>

Thanks,
Yunhui

