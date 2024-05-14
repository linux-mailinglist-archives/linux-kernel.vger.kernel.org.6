Return-Path: <linux-kernel+bounces-179034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9078C5AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBACA2829EA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2282180A6F;
	Tue, 14 May 2024 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qsELbkk/"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB051802BC
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715709657; cv=none; b=OJTJpWmwtBe+N/KaI1axNXvzqUgW1b1upCDE5fstmOox237x1IdFa9PF6GpHKHUfucuXUTIrL+fsGjDxT528kvUX4xW8gBFelJs90SKNsrjANVQWUIi2aXNjPXOArPiHI5vJL8vcg+dWHKEFqPdI1TuEOZQxwojhN+/CTegzuec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715709657; c=relaxed/simple;
	bh=QpLFeA2HlNqOEmnHE/cIxn51kUcvHow4/it0St+9Ios=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X52gHrCrOz242gVyKVtZ4B0P+NEFEa5SMdzsMfkRKwIB03TKFjbGBB05EA7CrhXKLU/QVM/fyUBTYj0m8Vwq1dRZocD9MFxQ6sektpVKugGvOirCgjnbmUaF9h3QxYelsRqmFA2FkPxz6uEn1ae+G0cvjvSUbC0BoC1NpiXL494=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qsELbkk/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-572baf393ddso1760434a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 11:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715709653; x=1716314453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPFkuGbhnZyO2YuOasmxxVswDvCK0WBgSsmUFjTxFvY=;
        b=qsELbkk/YNyiZCI+GNKMpfBlODtyqwmrZjQVHDWo+Otqb/UNbu+arQw2nc2ZaD4Ia/
         is47yvxW7oWPA27ZeDuqxu4CLgsxY872KmDVdy0DVR1sgVwmotl72pPqzPj8LGnPO5o6
         kfZGIjKc2S6NfaRBSIgpbntyY8FIPvOQMYpzm8JIkTt6lwSzHcfxlpOCGZqlwoX/srJ1
         mBKSAKrr/DVQYPaQJgGc0BsNY/+MP+VAy4NzvyzF8cFV6NV72b3bHlIQp4/2CczVpi8L
         BOUJM1MEVmBs+QUe/HVJQCnARJeIy4zlN3G12A0Q/JjdN+pg4NhqbgjadCIBUSbChP0Y
         iUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715709653; x=1716314453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPFkuGbhnZyO2YuOasmxxVswDvCK0WBgSsmUFjTxFvY=;
        b=VuXamrjwdjkOFjkq/vbyxaVRWXKnmITOueu+koUQAn+5G2lDvV+hGwE9x6Wiha+uwz
         SmXpjLxCl83sAyb8iNX1ExWFumMw9ArkEDllM4R0kRMDoxJvp6CWgXvYK/3XkAdvivX1
         Zi3He/cMpRbBrarYDfoSWnejRheniCrMr8ZKw4gqnnF0j7hpocKHQ+SWuqb+Nn6vwy2p
         DCoec+vaT6n+rSatsOrQyS7kItWW/4B6a2Cq080Hr/yqzrqCUQ6Ld8Bm9I7daAuXg1xN
         gPg2KLAcFZ+mG+6MrzBf4Y1kdul1r8EUS/zTJXeaYHDR+8UWjsQ42dWi8aNt6Kl+SRyb
         fWOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUswKFjkT86KR/8wNjvQOKqsCRvpxN3WUVc6Pv3K1cpDlYKw3QpL//hZI55e4icGQwzN7PgAaWC0OXW1fL6sDwBQuRgB/nRtHAa0JW
X-Gm-Message-State: AOJu0YwRV2WuJG3Sjz+qOnxSz3/fMr9nxPSeVL0JqvN8En4pFSrslfLi
	RAtpKV3qry6/Ptj4vPueXLIhjlRLo/tlY0X4kWVnNfkxtig539XF73x5vPZrZirZRQq045/Vy/N
	pw1TFm4Ix4/PVWuKe8irBaK5W5GhpMsHVuGRncw==
X-Google-Smtp-Source: AGHT+IEav+Kv/bYUpFPfTWv7r39urrL/VjCf1N0diMj0Pjq5+EuaD+cN5qt0Ndddnyt68aDR99gcExBIUX9EIjG6mjI=
X-Received: by 2002:aa7:d392:0:b0:572:7014:230a with SMTP id
 4fb4d7f45d1cf-573328e4ec7mr13569756a12.14.1715709653683; Tue, 14 May 2024
 11:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514140446.538622-1-bjorn@kernel.org> <20240514140446.538622-7-bjorn@kernel.org>
In-Reply-To: <20240514140446.538622-7-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 14 May 2024 20:00:42 +0200
Message-ID: <CAHVXubi6Hv_FCTi=a5FFoxqiUBucrX_NhVGBAWE6qXRXdzOYsA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] riscv: Enable memory hotplugging for RISC-V
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-riscv@lists.infradead.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Andrew Bresticker <abrestic@rivosinc.com>, 
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Santosh Mamila <santosh.mamila@catalinasystems.io>, 
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 4:05=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
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
> index 6bec1bce6586..b9398b64bb69 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -16,6 +16,8 @@ config RISCV
>         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>         select ARCH_DMA_DEFAULT_COHERENT
>         select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATIO=
N
> +       select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM && 64BIT && MMU

I think this should be SPARSEMEM_VMEMMAP here.

> +       select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
>         select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>         select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
>         select ARCH_HAS_BINFMT_FLAT
> --
> 2.40.1
>

