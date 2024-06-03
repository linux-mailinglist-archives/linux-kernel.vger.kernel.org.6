Return-Path: <linux-kernel+bounces-199289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 221A78D84F0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC0C28B000
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C16C12FB0B;
	Mon,  3 Jun 2024 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRHEBQYl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25B312EBE9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717424819; cv=none; b=FQ/qdyuzgxNAWYdG+igbCEdtxHKm+P/mXBuIs6LTUSK+aQA6GVbPvdpmPn41MQR4BlPS9JcKJHiOho9a76ZuLs/FoM1VRmMPOyqXH2CGX9b3xdHPh2YwrVtcq7rz6JouVNTJZmR/scD0xggsZN32iDt++GV6zaj15DsYhdRFiOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717424819; c=relaxed/simple;
	bh=VtIjSjKPYRKLwZt7ntdBOuy3fX4+L/KfyjORLwZjLEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5ddl7CBytk4fGqlsB9r8ktAhA76+Bfxboi6HrM4At///1YoQQbGXVbyjg8lnI5t7T29A92ibyQz/skkH4zKpN4YBLFfmhXCwx33kEoVZfG5/as+he93XdvnyeBXlMN4EiCnEu6JWn6uJQWrv/NNwwLzBPIcZyAqdD9w0qoPKgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRHEBQYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C22C32781;
	Mon,  3 Jun 2024 14:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717424819;
	bh=VtIjSjKPYRKLwZt7ntdBOuy3fX4+L/KfyjORLwZjLEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SRHEBQYluUxY5pPVoXE6L+WlAM6fKnPVSihl9tpA1tHeEpsHL0hjJ7SJpe3MabhzK
	 MUBvzjvgE1h1ZZoUCfGbunoyRwiVlwQ7viVkK/s4r63FO0voH3NoZs5uMYMARS/A1E
	 Za4rDrF9IbOSKeWd9U8Kb1X9mh6G6gVvWnqICsLAViJDSbzE59ukEL1yyjwwS7AzXT
	 tMutLqotTraDuRgdjdiBUzizUszmaOBr0zk05Ser1/w5OGEVpj82VD4d3Kffdxkfn3
	 EJJdwgPGt13PVix/4DBrFIa9Xg6dJO3s/m5mm9Fc2D/VYQyCqV9Dk5eGRRyGcNI4Fq
	 Kwhks1I+cLOAg==
Date: Mon, 3 Jun 2024 17:25:06 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Borislav Petkov <bp@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Narasimhan V <Narasimhan.V@amd.com>
Subject: Re: [PATCH] x86/mm/numa: Use NUMA_NO_NODE when calling
 memblock_set_node()
Message-ID: <Zl3SQmHNddFDOMQP@kernel.org>
References: <20240603141005.23261-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603141005.23261-1-bp@kernel.org>

On Mon, Jun 03, 2024 at 04:10:05PM +0200, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> memblock_set_node() warns about using MAX_NUMNODES, see
> 
>   e0eec24e2e19 ("memblock: make memblock_set_node() also warn about use of MAX_NUMNODES")
> 
> for details.
> 
> Reported-by: Narasimhan V <Narasimhan.V@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/x86/mm/numa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index ce84ba86e69e..b44a3ae51e9a 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -614,9 +614,9 @@ static int __init numa_init(int (*init_func)(void))
>  	nodes_clear(node_online_map);
>  	memset(&numa_meminfo, 0, sizeof(numa_meminfo));
>  	WARN_ON(memblock_set_node(0, ULLONG_MAX, &memblock.memory,
> -				  MAX_NUMNODES));
> +				  NUMA_NO_NODE));
>  	WARN_ON(memblock_set_node(0, ULLONG_MAX, &memblock.reserved,
> -				  MAX_NUMNODES));
> +				  NUMA_NO_NODE));
>  	/* In case that parsing SRAT failed. */
>  	WARN_ON(memblock_clear_hotplug(0, ULLONG_MAX));
>  	numa_reset_distance();
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

