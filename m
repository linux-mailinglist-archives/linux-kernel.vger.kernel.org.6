Return-Path: <linux-kernel+bounces-220944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D5E90E97E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4CA91F24526
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742E613CA92;
	Wed, 19 Jun 2024 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LWkC4J/i"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F1B137747
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796751; cv=none; b=cyRENAVIdszEZdkikOxDUIk/HSAHpslR3Bugcp/TY/FSL6kcqhQ7HKWHbR3YzIVKlhHOooDnW9QhtQdQUhsEiSKIVCbTVD8S/rHHp9ocW07nHbaMQU9JuX4X48l6WpyMw/LTTLcVINhwUGzp0PYDLcQp6d5EAdV/YATrIkS2wqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796751; c=relaxed/simple;
	bh=ep+bcQ9KIBL3Ur4LJps7I1N9rQ6T3o1g4+RjR962b+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=SxQM5GBmIs7KtfVbpckxFPMDWrCPtRNBbrDToNtbZcf0Jv4USmc6/P6V5rU+XEJlGh/WmjrHUmm7Ll4xaUazWWKQUOzin0qf6R7NYa0PoipsVu/gStIoFaKXjmlRd+JQ6P/EdCCjHKlJ4CVucEO2mnOH5ta+HnMuotxEQCBFxeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LWkC4J/i; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-24c9f91242dso2689127fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718796749; x=1719401549; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pWZByJHXQuXqyJwb/jU6Cx4D/ezIf4+3nq/sxOvdo4=;
        b=LWkC4J/iXumglmKU/NFNi1MwfKSKj4b7vm3Ji/h+MbXZsEnRg1GV2cP8erBxpTQN3H
         ztsdrHCyTHvMdnYd0g0N13U2zjDAHXbqQ6GV17qGKIkbjOxxawZh81pGFRG6liQh0HDN
         XhagqEOwcjQojBgAcAyS6P8T9NzXapi9NWQWy48FHYt6yUZj4hXVVQ+R+bI4Hgz1VZ/q
         r08G9wPAiA5Hg/oYHfGy1sE3mB2ieESzl8+KsPMvaM3Qm0KDiqeNw+/IIh3UHAhGJp1l
         xKEw1WgQ4faaRFwOKbQ7vLIu1jpGmV+MvaRycpWy1FKA83Hx2J4FOYqgX6bD2wSKU4s0
         QQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718796749; x=1719401549;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pWZByJHXQuXqyJwb/jU6Cx4D/ezIf4+3nq/sxOvdo4=;
        b=TTTGru7jkso17E3L7xp79pfHqi3rZTdsrJD5CLGpQKtWpdDHi36PewFaFcGKefYPwv
         qQe3zWQkAxuqJTVXu2ngMr2VmjVH0sDTnOKueZ58sH7J3cNOnzICTHvmGtO6Z0Ody7OG
         crd6hMGjGhOVln2qdb1BoUhxZvHWasUVe66E9pgaDsbYdrSbSbt8Tz5XDwpcm4WgADW0
         vmceo1sD3hWQRIeHxp2b2YQT0T8PV1fTUf7DbRAAARAX+qfY/Guuw7pDbKNuZByGvNrf
         BgIOQQFy2yCoUlod/e3yssb+jFwgilUGcvlUjONZ8tA8prz5SxoCXV/xD33vN5j7zlf4
         S+Vw==
X-Forwarded-Encrypted: i=1; AJvYcCU9c1lcp0GM3Znj1jFkranlu/LEGZ4rJjbZfA3YBEA+YagkLbFYHdPwbQf357VQCtLi4EYfFRmH6nRcxps6OiCWBGM6qlZbINz/TjTR
X-Gm-Message-State: AOJu0YxChE/GIZqAM5OygvGT7HQfx6JJs7vNEm03qV+SVM7QpOBQxmJ4
	04gtkTsf9cKDMO0PeYGIdyBMt3nT5jsfH2Ot7WoSjpBkD5g0j4GpvuQL2UAZdraAne1vYgJS2i/
	MHisx0O8RhWKIcILtFAm6X+EQdpRXFy56hwI8TA==
X-Google-Smtp-Source: AGHT+IFDTJPJUvt5MDx8yXoy50LjAmUvtMJn2QjJIM1rsP4eAxrwxGqnbfFwaWVFBzqTW1RnUYiLxwgToBAi2U6CAmM=
X-Received: by 2002:a05:6870:c0ce:b0:254:783d:aeb4 with SMTP id
 586e51a60fabf-25c94ade8d7mr2582738fac.35.1718796749303; Wed, 19 Jun 2024
 04:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617131425.7526-1-cuiyunhui@bytedance.com> <20240617131425.7526-3-cuiyunhui@bytedance.com>
In-Reply-To: <20240617131425.7526-3-cuiyunhui@bytedance.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 19 Jun 2024 19:32:18 +0800
Message-ID: <CAEEQ3wnkQsfmLbyMrG_YBvWvhHJdSTg7dG5W_mxv_wxCjatgCA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] RISC-V: Select ACPI PPTT drivers
To: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	sunilvl@ventanamicro.com, aou@eecs.berkeley.edu, 
	linux-riscv@lists.infradead.org, bhelgaas@google.com, james.morse@arm.com, 
	jeremy.linton@arm.com, Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, 
	sudeep.holla@arm.com, tiantao6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sunil,

On Mon, Jun 17, 2024 at 9:14=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.com=
> wrote:
>
> After adding ACPI support to populate_cache_leaves(), RISC-V can build
> cacheinfo through the ACPI PPTT table, thus enabling the ACPI_PPTT
> configuration.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 9f38a5ecbee3..1b4c310a59fb 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -13,6 +13,7 @@ config 32BIT
>  config RISCV
>         def_bool y
>         select ACPI_GENERIC_GSI if ACPI
> +       select ACPI_PPTT if ACPI
>         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>         select ARCH_DMA_DEFAULT_COHERENT
>         select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATIO=
N
> --
> 2.20.1
>

Gentle ping.

Thanks,
Yunhui

