Return-Path: <linux-kernel+bounces-301407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 234F795F025
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEBB81F24A40
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B1E156241;
	Mon, 26 Aug 2024 11:50:48 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C2613BACE
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673048; cv=none; b=KDq5sdLr3x5UGQgkIU43pc8/DUbrMnV95J9VGcrPXx6G8mjaAbQTSm7nsRLi6DWiP88WF52ruCgSGZ8hRsdHNk4g11SKeSk7ICy0gths+gftF43SoQQdcEYDV4kIxE25QjCR9+y/NSLHjfi4M9q2Xg/uziA2KGABnhLcIgUkoj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673048; c=relaxed/simple;
	bh=SpB9ti7a+1Xr4/NShERRoEKAxVnuh9w503CDXqETYxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwZZ+59JqVlRB6FFLlo7tCclvVH+koJN4YODut2/2sZSpA/iw/xqZHIXXK1iD/ZRytr2Keas/M+0kvqygdlYS2DWJaPvgYthLCGVUUlsk0K7epg7WipwRASVlkdqZLYnPYskGk7BGEH4f7XdT5OsJXu6EMMR0b2LUbpEruevs+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0255CE0003;
	Mon, 26 Aug 2024 11:50:35 +0000 (UTC)
Message-ID: <9cdf868a-e937-4be3-8e7a-a7d12d3fe5da@ghiti.fr>
Date: Mon, 26 Aug 2024 13:50:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Fix toolchain vector detection
Content-Language: en-US
To: Anton Blanchard <antonb@tenstorrent.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20240819001131.1738806-1-antonb@tenstorrent.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240819001131.1738806-1-antonb@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Anton,

On 19/08/2024 02:11, Anton Blanchard wrote:
> A recent change to gcc flags rv64iv as no longer valid:
>
>     cc1: sorry, unimplemented: Currently the 'V' implementation
>     requires the 'M' extension
>
> and as a result vector support is disabled. Fix this by adding m
> to our toolchain vector detection code.
>
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> ---
>   arch/riscv/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0f3cd7c3a436..939ea7f6a228 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -552,8 +552,8 @@ config RISCV_ISA_SVPBMT
>   config TOOLCHAIN_HAS_V
>   	bool
>   	default y
> -	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64iv)
> -	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32iv)
> +	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64imv)
> +	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32imv)
>   	depends on LLD_VERSION >= 140000 || LD_VERSION >= 23800
>   	depends on AS_HAS_OPTION_ARCH
>   


As Conor noted, we need to backport this to stable releases so here is a 
Fixes tag:

Fixes: fa8e7cce55da ("riscv: Enable Vector code to be built")

Thanks,

Alex



