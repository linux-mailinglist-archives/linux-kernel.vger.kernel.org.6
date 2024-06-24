Return-Path: <linux-kernel+bounces-226964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE70391467C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4231C2083A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E299A1311A1;
	Mon, 24 Jun 2024 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CwbxnPKc"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7DB2F855
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719221580; cv=none; b=EXgrhRCRMDGI7o7N7cx1GRtSTTlp8FzHndTue7CfpMIsB++kynUGxuvQrtrdc9hQGCsQFIyvvxLvEdzXNunA9ISa+8L/6b2IQXQIUu1xZt0nHzvi96W5LqELumoRVaex+ejuuqRMygiD7/07lxfr7MYd+ONMqGbTUOw0lGuJtrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719221580; c=relaxed/simple;
	bh=xgYPXAcahwrokBgBsI1bgHqC/P6ivXlthaKEV07Du10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pprSfdpwNWLX7syHaX67JqVcAEtScfAgvwbphKA5Np+IYqkTR2575D5IMpMGQJIV7nIgM6aHF2Fqas7mG0U0tLWlvPZwj1jbYah40VQ2IvXTKYJ+y/6n0gNEhsj/cjc/TxcLH7g24QvMxP4tHmlv9NSySIAUYzgVI1aDcawwvGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CwbxnPKc; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d07f07a27so4389295a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719221577; x=1719826377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSDzT24BI2p7JqoVBNan8p02CfsKp3kht22xLj1zjCQ=;
        b=CwbxnPKctSgI3lWN8dPjiV/v3oCragSTAzgNS7nDZ0I5AmzBDx+UC2YD5IymoRq6/d
         8n7ft0K8XCuL4MxAChbCJNHBH0auY88bQzXS5c25DZx57u1NpEeb62lxMGwf+m2urMyY
         TP46KG06r/5wttZihA3d9yLY7cn84MqeJkXeOnEMzzKMMj7gEMA7uFPxKH7IxzlP3vkO
         hwwOo0lZbZL3ZVodCZEbnrBdpZl6Se7ExZ6VJjBWHRmE41GvNfVPjhyylofImB/HgmFC
         9kPvTE45j61G7wdWAq1VM0XtmHoaIVsFUAKrNTkMNksllsZ2GMrZcthHVQRTs5Kj4ANy
         WiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719221577; x=1719826377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSDzT24BI2p7JqoVBNan8p02CfsKp3kht22xLj1zjCQ=;
        b=xBJ9Kq6QBD58xz0gFRi4iL+Qh1JLd5WuWDp3WcoVffeOcf+bjtB2X63ijDVNtNjOze
         PfVZvBPfimmQj8uXi53t4PsJRO1QML7Mrnw/IfJonp5gXbnMT90NN9EcyeDcvd43Va78
         PIm3YEx0gfgd46Yg4NeyVuaolQeqW1t5Ayp3/BhExgflMbxXDxHQaGP6DhHPfBNmArZg
         H+iz/hkRWaNEh3CfyPl+5thOumaaDcNLDiE8FlMga9VTo3MY1ZLXTDWbwniw1hHSZMgK
         7REsmaak9CoffPcZYt9xNV28f9kYglQ8tKThCsHGRK1mCcaZhcA5qNH5r0bRXmSi5RMM
         edXg==
X-Forwarded-Encrypted: i=1; AJvYcCUsD++KqvNo4Z8tAc2pLq2k2Jj/qR0ch1qSSZc+hQPYezcNTaJKyVf0lcRXSW/diSuvVe00lYA1LEkeGa+rK+tavpAPHIvXUcF3F+Ch
X-Gm-Message-State: AOJu0YzoQK6MNF53Hdbqr/bLOg9ENcv6vHuRFWjSZ2GYO3JEIH1hUlcU
	a1WP6tbbh4SeObfl4O8K43p1uEIbvxqa2gKmA06yCXlPUC/xO3J7bHl1t5Gu+wLxoA2aOEN+Wfx
	mpToZHgOgWBcqqdEtW+ezbrbhvKbR715Sis3aYw==
X-Google-Smtp-Source: AGHT+IHXOtFoZ5Ms1VnEXer+u/bYL40w+BzdSznB1Ran7dPtsex2PEoJ5U03ch/VSdRA5dnKWSL056SniQ6koP4dx3Y=
X-Received: by 2002:a05:6402:40c5:b0:57d:543d:e35e with SMTP id
 4fb4d7f45d1cf-57d543de513mr1968208a12.5.1719221577025; Mon, 24 Jun 2024
 02:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605114100.315918-1-bjorn@kernel.org> <20240605114100.315918-12-bjorn@kernel.org>
In-Reply-To: <20240605114100.315918-12-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 24 Jun 2024 11:32:46 +0200
Message-ID: <CAHVXubgBKxOh0UjbSw2J_76MvZuiwSLL7d5=wAfiRZvgiUD=Ag@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] riscv: Enable DAX VMEMMAP optimization
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

On Wed, Jun 5, 2024 at 1:42=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Now that DAX is usable, enable the DAX VMEMMAP optimization as well.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 8a49b5f4c017..1631bf568158 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -73,6 +73,7 @@ config RISCV
>         select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
>         select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
>         select ARCH_WANT_LD_ORPHAN_WARN if !XIP_KERNEL
> +       select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
>         select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
>         select ARCH_WANTS_NO_INSTR
>         select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
> --
> 2.43.0
>

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

