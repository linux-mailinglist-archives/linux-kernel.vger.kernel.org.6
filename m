Return-Path: <linux-kernel+bounces-241938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8E992818C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639881F22F7A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 05:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D69B13C669;
	Fri,  5 Jul 2024 05:53:58 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DDB33C7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 05:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720158838; cv=none; b=BlvCSBQhXSLtF09PDmhdPFcbChf4cd8lwZb/cgXw5lMzPRfxskHZOGa5IhttFKRvRO4cdQimDhCylKoX2ZOgncDmFBkXz2PYBaCR4rnVLhedwb1tCoM0TB3wsk2Qdx4GASfTANeRBz7NfAle7xuTx7kSNwDR1MkrH5Yl7OjthjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720158838; c=relaxed/simple;
	bh=sDdIt+1e4X/ZeqtH4M9EzPekqb8Iba0mCp/wkm7O2+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bs5mmffyY9EUmNg56e98yIc5S+4KEoRxVwHOqYfxhv43Yn9Bb6XjXO1Lj3AIX3yKex0gYz6e2jvyEcVIurjZ1TiLB19nwzP0iac0apy9iaBEjof7G85ewG2H20n48qA7HbgK3mjqf2yjJqeZZ9tRr5VcgZpdQqgp0uOiYGDIWN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 366F940006;
	Fri,  5 Jul 2024 05:53:45 +0000 (UTC)
Message-ID: <adce9444-a6c4-4747-afec-d70af4a396d3@ghiti.fr>
Date: Fri, 5 Jul 2024 07:53:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: vdso: do not strip debugging info for vdso.so.dbg
Content-Language: en-US
To: Changbin Du <changbin.du@huawei.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240611040947.3024710-1-changbin.du@huawei.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240611040947.3024710-1-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Changbin,

On 11/06/2024 06:09, Changbin Du wrote:
> The vdso.so.dbg is a debug version of vdso and could be used for debugging
> purpose. For example, perf-annotate requires debugging info to show source
> lines. So let's keep its debugging info.
>
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>   arch/riscv/kernel/vdso/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index f7ef8ad9b550..960feb1526ca 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -45,7 +45,7 @@ $(obj)/vdso.o: $(obj)/vdso.so
>   # link rule for the .so file, .lds has to be first
>   $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
>   	$(call if_changed,vdsold)
> -LDFLAGS_vdso.so.dbg = -shared -S -soname=linux-vdso.so.1 \
> +LDFLAGS_vdso.so.dbg = -shared -soname=linux-vdso.so.1 \
>   	--build-id=sha1 --hash-style=both --eh-frame-hdr
>   
>   # strip rule for the .so file


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


