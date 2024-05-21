Return-Path: <linux-kernel+bounces-185005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D35528CAF51
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856562837BA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4C8770F1;
	Tue, 21 May 2024 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Yh1ebM59"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374A06EB5D
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716297841; cv=none; b=GrtJ1NR4I5rBLKYJRNen0DI8tWpsgxVuMjqcQ63kWtQDzqUm8KnPo5DNi9jD0OvASW2VZzn7DR606vGwI3RGObvkrJVvLFnwDTIgGMWLlfSnEsYr8QOC94cbgdZduveAseJri2tUQSwVzxitpNR19S2DiRXLzggR30kZ5lnEp3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716297841; c=relaxed/simple;
	bh=HtMYnwo+7zhOK7FuVJSuWZ8y7KproGqd4tIRPgFjtdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLBDzJvm5ECdmEBEboiPAO/fRtRVjEJWAR4SnCoEdoJSStSS9yCcevvOgPLgdnjxnjW5b9U0wFcpTZKDO8h3NEqJbQRFGERlDUSIYrWS2kPvCS4kckDbAUeTqWCfhInrHwHZgv9mlSHpXk2lpKFLCsWZ1TOgz5vaSO1JdbdmwFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Yh1ebM59; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5a5c930cf6so863619966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 06:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716297838; x=1716902638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ch94/MUKajfhml6j4NyfbEOexox9CsSjGOQusf6QZ7Y=;
        b=Yh1ebM59W3TYA2jLsOKMr2Du7Pw5d4zi4bkyPTo5Nr9YioKGEtQSqAu/c5sSLR29j5
         iAXDm+K6F5hlTTeQTua2OJbRSJW66uiEuuDlLqek1GoqR+ZXyMz63mbYKMduV4fGMnO9
         1jbjFMGXNFpbHLmKp8lG9vRopG6xLpr0ywAyZCYm+jeHE3aBoqr8IOK548G2y8vqI9aq
         8jpG0jObG5nXGPblIWLCB5Rd0nK2+Tkr9BpSwQ8cYA3Iw9Jf7PkZ/Pw1q8g0zXo83ZVB
         glBag4xuU0ms6m9uESlJW/12HFnhxdJMqU3e9D4YOzYR/0B74ofZEy9yIq9fOUuPt229
         CQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716297838; x=1716902638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ch94/MUKajfhml6j4NyfbEOexox9CsSjGOQusf6QZ7Y=;
        b=DGAyHDGFQC6qvT/bgXIuuMNrwl7mE2TRiHxWULq8oXWU8T6avdE3uFKoVWeCCByILS
         pNDEPRwUelvvEK1vLdkPrEXictk2sAxdMpBYhlafC4IuY+U4YixA9CY83Q165Gd9WdMe
         JdmAIMmiMZ/Fqg+8zUM41SZ+8qvcgK7P8YPWqc16WQjVc/9AgS7BEEy0ORIVUKskLtV/
         witcF3sVZFKR1hYMe0zK/OixVt3dsXW3KcZBGbodniMTDcIotJjjhTKsNdNq1q/xE0cE
         MCJDAg75B3qC1QgmTGWvI78l3ju6lvQrmQMG0wPUgUs49r4awKGNfkTnrYzPaqz05dUM
         6miA==
X-Forwarded-Encrypted: i=1; AJvYcCXzZKIiaRRjO71Pam3NiQJTliCwPzbzCpHEuH6DDzKSYThINnZHjpE+N3VeCrXbDKpqoI+EDFXEUSqq3aOFLNfhalMbRS5O3nP0IEuF
X-Gm-Message-State: AOJu0Yx0QgGh/Rp3ZZjTLHbDdspoJnFbV1FmRYWN5xpuV3Ldve1OChnM
	efy0CKQh+kVnTluSKMs7Pf9nTgEjEQ0Nmy0egHpucentNZ0awYj9/i6kDQQIWBWTE73KWCwgM/+
	7L8qz4ax0IYbfZPXZlZmi9MBCWoQiMmFYT2DhGQ==
X-Google-Smtp-Source: AGHT+IFNPqteIERuQeyx8fOJtXwMedVB6JFT7AeuGshPQDCn+zzfFh7PvOccTzqO4JtW047q2vYzycQdAe7WDgqQFSA=
X-Received: by 2002:a17:906:ca8a:b0:a5c:df23:c9c6 with SMTP id
 a640c23a62f3a-a5cdf23d59cmr1178417366b.47.1716297838602; Tue, 21 May 2024
 06:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521114830.841660-1-bjorn@kernel.org> <20240521114830.841660-8-bjorn@kernel.org>
In-Reply-To: <20240521114830.841660-8-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 21 May 2024 15:23:47 +0200
Message-ID: <CAHVXubjQr1xzKcjRgB8zA3opj6N93PGpF2=5yKkKK6R07Rpntg@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] riscv: Enable memory hotplugging for RISC-V
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-riscv@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Andrew Bresticker <abrestic@rivosinc.com>, 
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Santosh Mamila <santosh.mamila@catalinasystems.io>, 
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 1:49=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Enable ARCH_ENABLE_MEMORY_HOTPLUG and ARCH_ENABLE_MEMORY_HOTREMOVE for
> RISC-V.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index fe5281398543..2724dc2af29f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -16,6 +16,8 @@ config RISCV
>         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>         select ARCH_DMA_DEFAULT_COHERENT
>         select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATIO=
N
> +       select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM_VMEMMAP && 64BIT &=
& MMU

Not sure you need 64BIT && MMU here since ARCH_SPARSEMEM_ENABLE
depends on MMU and SPARSEMEM_VMEMMAP_ENABLE is only enabled on 64BIT.

> +       select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
>         select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>         select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
>         select ARCH_HAS_BINFMT_FLAT
> --
> 2.40.1
>

But anyway, to me that does not require a new version so you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

