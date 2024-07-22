Return-Path: <linux-kernel+bounces-258508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9104B938900
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33FC1C20EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A58818052;
	Mon, 22 Jul 2024 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4+ac8sO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A074E17BAB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721630511; cv=none; b=k9O6zW3WoilLZfNFV5unzYeoqBIiNJUZFes5R1MYGbphL5wUtz+qJVy4tR5rIHUinCQEXuRiqwIj1sl6E25dyMcBuk5Eu/rZn92mTFmZM8kYA8Je5Sbkn+kYEYMHFU3tCzIXorYxynfYlyb/J3cCUdIy4OFf5IK/81wJJgwNrlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721630511; c=relaxed/simple;
	bh=Uc2H8MzMbL0exp6NDBd0fqrLYZ7z9SrwjguOdZewCxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0g/N4w6ixr5cpkl+CNb8GgA8ZAsCLc/gPj2WvB1xovCNSwrQsVkwn++ekryIygphwQcRTI5Ei61X2HsB4CfJDBQHFJr0adebtksmZCMVizklWxVdJBbd4U0/AJaLpgZsYj6ubTLW9nJSddA/poaQ5WSB/Vb9lh+bQxEaGBtCyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4+ac8sO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B928C116B1;
	Mon, 22 Jul 2024 06:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721630511;
	bh=Uc2H8MzMbL0exp6NDBd0fqrLYZ7z9SrwjguOdZewCxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4+ac8sOH29nEcY30v7JfwQUBbY10MKUUKQRDDkYsEHF3O2B5HPlFnFq63P+ndHri
	 98hYHPANCcLLIXpfRCn+i0RQkBu08yu9XtKvj6OesNHMs89ZbXknaNe0ywTHriBSWT
	 0Od7glk0EMv/qvnMPGg1iOZ8q8M+9CpUTDT0/SlQ1QKBRF985lbN2vQ0Xvn99b8nLe
	 jwB/0ao/Y1b3RmhwAJusTDrD1C5/hDHFRK5WF5ehBhdkhp2819VDjK+cBpOVr/SuU6
	 qDALwmz7Ot/QZLFEL4EYLp+VbntPOE9WX9A3k2HDhe1LMgcduwkTWSqoMJpFx60u+8
	 GBUzk2gmHxqRg==
Date: Mon, 22 Jul 2024 09:38:45 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux@armlinux.org.uk, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	arnd@arndb.de, gregkh@linuxfoundation.org, deller@gmx.de,
	javierm@redhat.com, bhe@redhat.com, robh@kernel.org,
	alexghiti@rivosinc.com, bjorn@rivosinc.com,
	akpm@linux-foundation.org, namcao@linutronix.de,
	dawei.li@shingroup.cn, chenjiahao16@huawei.com,
	julian.stecklina@cyberus-technology.de, rafael.j.wysocki@intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] riscv: kdump: Fix crash memory reserve exceed
 system memory bug
Message-ID: <Zp3-dZHhN7LbMggc@kernel.org>
References: <20240722035701.696874-1-ruanjinjie@huawei.com>
 <20240722035701.696874-4-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722035701.696874-4-ruanjinjie@huawei.com>

Hi,

On Mon, Jul 22, 2024 at 11:57:01AM +0800, Jinjie Ruan wrote:
> Similar with x86_32, on Riscv32 Qemu "virt" machine with 1GB memory, the
> crash kernel "crashkernel=4G" is ok as below:
> 	crashkernel reserved: 0x00000000bf400000 - 0x00000001bf400000 (4096 MB)
> 
> The cause is that the crash_size is parsed and printed with "unsigned long
> long" data type which is 8 bytes but allocated used with "phys_addr_t"
> which is 4 bytes in memblock_phys_alloc_range().
> 
> Fix it by checking if the crash_size is greater than system RAM size and
> warn out as parse_crashkernel_mem() do it if so.
> 
> After this patch, it fails and there is no above confusing reserve
> success info.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/riscv/mm/init.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index bfa2dea95354..5d66a4937fcd 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1381,6 +1381,11 @@ static void __init arch_reserve_crashkernel(void)
>  	if (ret)
>  		return;
>  
> +	if (crash_size >= memblock_phys_mem_size()) {
> +		pr_warn("Crashkernel: invalid size.");
> +		return;
> +	}
> +

What the point of adding three identical checks right after the call to
parse_crashkernel()?

This check should be there and parse_crashkernel() should return error in
this case.

>  	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
>  				    low_size, high);
>  }
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.

