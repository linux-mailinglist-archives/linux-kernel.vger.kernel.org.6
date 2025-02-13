Return-Path: <linux-kernel+bounces-512432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1449CA33939
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90ADD3A15E5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C12620ADF8;
	Thu, 13 Feb 2025 07:50:10 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ED8BA2D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433010; cv=none; b=ldsPsQSPV0enbgSKTmxHbtROQhyryk2j4Yl55aV0I2koRPmN+9TwqnSvt8HW1wUgGjz6A9R513IXsS9PLjXBz+g1dFzTmqlO0tpL5AlHNtrqp6xxcbj9B5g6RtShm5l9+kXTCWy5wE0ThkGf0nhKfk8rTZ9Nfrx++Qr/A5Sts3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433010; c=relaxed/simple;
	bh=Q5DkIPcOjmbab4cd8tLk/Gt9AD8pxjfo+fF4Rxv92vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYRqOOsDWo48Sqg2SdQWKq450GvcfhsPRnUUDd56fX6n7tIkSwBsnyHKcmT2HOEg3UT0dxFHMvXcZYyyyGp42YTEk7Op5miwWbtlWkvnvDYWRJ9cNa5/qKNI2vRhuMULZnavbcXsmR3ZEVnncwxwnDy8UcxKWIttLZJme0aXwTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Ytn0M0XJrz9sRr;
	Thu, 13 Feb 2025 08:30:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uu8P4f59axSR; Thu, 13 Feb 2025 08:30:42 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Ytn0K07lPz9sRk;
	Thu, 13 Feb 2025 08:30:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F36278B763;
	Thu, 13 Feb 2025 08:30:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Abk2ZXThmqKy; Thu, 13 Feb 2025 08:30:40 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8B3D28B770;
	Thu, 13 Feb 2025 08:30:40 +0100 (CET)
Message-ID: <fc4954d8-3ea6-4542-a5e8-17da2bb9650d@csgroup.eu>
Date: Thu, 13 Feb 2025 08:30:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mm: Make GENERIC_PTDUMP dependent on MMU
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: steven.price@arm.com, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250213040934.3245750-1-anshuman.khandual@arm.com>
 <20250213040934.3245750-4-anshuman.khandual@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250213040934.3245750-4-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/02/2025 à 05:09, Anshuman Khandual a écrit :
> There is no page table dump without a MMU. Make this dependency at generic
> level and drop the same from riscv platform instead.
> 
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   arch/riscv/Kconfig | 2 +-
>   mm/Kconfig.debug   | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 7612c52e9b1e..c4cdba6460b8 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -112,7 +112,7 @@ config RISCV
>   	select GENERIC_IRQ_SHOW_LEVEL
>   	select GENERIC_LIB_DEVMEM_IS_ALLOWED
>   	select GENERIC_PCI_IOMAP
> -	select GENERIC_PTDUMP if MMU
> +	select GENERIC_PTDUMP

Are you sure this works as expected ?

See https://docs.kernel.org/kbuild/kconfig-language.html :

Note:
     select should be used with care. select will force a symbol to a 
value without visiting the dependencies. By abusing select you are able 
to select a symbol FOO even if FOO depends on BAR that is not set. In 
general use select only for non-visible symbols (no prompts anywhere) 
and for symbols with no dependencies.

>   	select GENERIC_SCHED_CLOCK
>   	select GENERIC_SMP_IDLE_THREAD
>   	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index a51a1149909a..c08406760d29 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -214,6 +214,7 @@ config DEBUG_WX
>   	  If in doubt, say "Y".
>   
>   config GENERIC_PTDUMP
> +	depends on MMU
>   	bool
>   
>   config PTDUMP_CORE


