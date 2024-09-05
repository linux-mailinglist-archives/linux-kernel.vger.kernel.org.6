Return-Path: <linux-kernel+bounces-316536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C3896D0D8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF691C21B3B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FD8193428;
	Thu,  5 Sep 2024 07:52:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D96C1925B5
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522757; cv=none; b=PeY2v9BsDKemhEuD7dtC9PZbLrhO3REfSLUituJ6FWPCYPoOdypHX2UZTg0af0hLXOizTcKKKhmmMbRWAKhwZ9Ag14mFTEK3pkIpD0rmetjkxjL/bASLZtY3vvFkpei2tlzLcsauLBA/GmcTHNe5r45in1XUYyKzwAIjm+NEWhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522757; c=relaxed/simple;
	bh=QruOEX77o4IzM0/p+F25QvRXbfV+dn+E1QX9bbaGKgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MviZjUELE4nReEf9zAWpMbsvXSpqBsokJKvqWhNZGP29HrIRNXma5qxAvzpwVsg8v+Ax/8WLGg3olo6lfnyHCu7Pql8fbdberLzAeE7Q1Nb3KKm+XEC36ttOYWxxgdmCjHc0tYfsxpEjfMDcrZbjIrvx7tfFbVgsPyr9c94Gzzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA39C4CEC3;
	Thu,  5 Sep 2024 07:52:36 +0000 (UTC)
Message-ID: <30445b83-50eb-40ae-a2db-43b98d0c3224@linux-m68k.org>
Date: Thu, 5 Sep 2024 17:52:33 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] m68k: disable SRAM at startup
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20240904-fix-cf-virt-mem-sram-v1-1-fb007028d717@yoseli.org>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20240904-fix-cf-virt-mem-sram-v1-1-fb007028d717@yoseli.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi JM,

On 5/9/24 00:26, Jean-Michel Hautbois wrote:
> Some of the internal SoC registers have a higher priority over the MMU
> virtual mappings. The SRAM bank is one of them. If the bootloader
> enables the internal SRAM at address 0x80000000, virtual memory access
> at this address will not hit the MMU - so no TLB data misses would
> occurr.
> 
> Since 0x80000000 is the virtual start address of all applications that
> bit of memory is getting stomped over with inconsistent code and data
> access.
> 
> Fix it by disabling the internal SRAM at startup.
> 
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> Tested-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

I know this change fixed your specific problem, but it is not going
to work as a general solution.

For one not all ColdFire parts have an SRAM region and thus not all have
a valid %rambar register. Secondly some ColdFire parts (like the 5249)
have 2 SRAM regions, with mapping control registers named %rambar0
and %rambar1.

Some ColdFire uClinux applications use the mapped SRAM, so a blanket
disable is not the best idea in any case.

I am thinking it would be better to have a new Kconfig option that
allows disabling by the startup code for those ColdFire parts that
have SRAM (so appropriate "depends on"). That way it will only be
disable when that is what is needed. Maybe also have that configuration
allowing to configure and set the rambars so that a mapping
can be forced on if wanted.

Regards
Greg


> ---
>   arch/m68k/coldfire/head.S | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/m68k/coldfire/head.S b/arch/m68k/coldfire/head.S
> index c6d7fd28c6023..3901a49c47c89 100644
> --- a/arch/m68k/coldfire/head.S
> +++ b/arch/m68k/coldfire/head.S
> @@ -207,6 +207,10 @@ _start:
>   	movec	%d0,%CACR
>   	nop
>   
> +	movel   #0,%d0
> +	movec   %d0,%rambar
> +	nop
> +
>   #ifdef CONFIG_MMU
>   	/*
>   	 *	Identity mapping for the kernel region.
> 
> ---
> base-commit: 431c1646e1f86b949fa3685efc50b660a364c2b6
> change-id: 20240904-fix-cf-virt-mem-sram-abadb27fff2f
> 
> Best regards,

