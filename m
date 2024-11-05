Return-Path: <linux-kernel+bounces-396246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F189BC9EC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CAC4283F78
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B26B1D2211;
	Tue,  5 Nov 2024 10:06:44 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAE31D1F67;
	Tue,  5 Nov 2024 10:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730801204; cv=none; b=s360T8E5N/I5MK2CvNkq9i+ItQyVQrllOyoq/3J6o6oaT5dSL1I7kCvsK24lqSzph3gJ6lBgzfitP08Q5a2tWHCPM5f8L0x5ihd+kKhnnIIQBujiTXNteMTAoaeps5414c6KAkYgSxrC3YagV/039gu7y+qnRW9kA6M+W9KEHq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730801204; c=relaxed/simple;
	bh=8IWyJQ6E0KkPZy2LIA1xJRCL/KyM2RBX7PgbXYzFmwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWD4J7amcbPpJ/eu/fKhkguNXpT3mKj8kriwVUiBDxZZFKy9vAUwLZU8pNo9pjzcOb/BHMFjuUqupmqJb6gRcG6ktHPygj3B3pRj2+IPt8wfSPC/3IJebtCYUxG5LjyFPjS6HhANcTjrfmINyBnUA8Um4ZvJ++1vQXIn/8BVWeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 488EFFF802;
	Tue,  5 Nov 2024 10:06:37 +0000 (UTC)
Message-ID: <20db5f94-5606-473c-9c5c-ebb0e4488090@ghiti.fr>
Date: Tue, 5 Nov 2024 11:06:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] riscv: ptdump: Only show N and MT bits when enabled
 in the kernel
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20241102000843.1301099-1-samuel.holland@sifive.com>
 <20241102000843.1301099-6-samuel.holland@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241102000843.1301099-6-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 02/11/2024 01:07, Samuel Holland wrote:
> When the Svnapot or Svpbmt extension is not implemented, the
> corresponding page table bits are reserved, and must be zero. There is
> no need to show them in the ptdump output.
>
> When the Kconfig option for an extension is disabled, we assume it is
> not implemented. In that case, the kernel may provide a fallback
> definition for the fields, like how _PAGE_MTMASK is defined on riscv32.
> Using those fallback definitions in ptdump would produce incorrect
> results. To avoid this, hide the fields from the ptdump output.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>   arch/riscv/mm/ptdump.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
> index 9d5f657a251b..58a7322e9a82 100644
> --- a/arch/riscv/mm/ptdump.c
> +++ b/arch/riscv/mm/ptdump.c
> @@ -135,11 +135,13 @@ struct prot_bits {
>   
>   static const struct prot_bits pte_bits[] = {
>   	{
> -#ifdef CONFIG_64BIT
> +#ifdef CONFIG_RISCV_ISA_SVNAPOT
>   		.mask = _PAGE_NAPOT,
>   		.set = "N",
>   		.clear = ".",
>   	}, {
> +#endif
> +#ifdef CONFIG_RISCV_ISA_SVPBMT
>   		.mask = _PAGE_MTMASK_SVPBMT,
>   		.set = "MT(%s)",
>   		.clear = "  ..  ",
> @@ -215,7 +217,7 @@ static void dump_prot(struct pg_state *st)
>   		if (val) {
>   			if (pte_bits[i].mask == _PAGE_SOFT)
>   				sprintf(s, pte_bits[i].set, val >> 8);
> -#ifdef CONFIG_64BIT
> +#ifdef CONFIG_RISCV_ISA_SVPBMT
>   			else if (pte_bits[i].mask == _PAGE_MTMASK_SVPBMT) {
>   				if (val == _PAGE_NOCACHE_SVPBMT)
>   					sprintf(s, pte_bits[i].set, "NC");


It makes sense so:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


