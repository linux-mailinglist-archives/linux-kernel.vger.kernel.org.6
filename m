Return-Path: <linux-kernel+bounces-258578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A59A938A02
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47DA280DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD43B1BDC3;
	Mon, 22 Jul 2024 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwfZHQCy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF471B960
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721633223; cv=none; b=p+Joq7zOPBMHTmnFYY8aUB/uIbCsDdZ6j65NqrejkT4KXVTdTTgdBmeoMFutDWWgJlyQ0YuZw5vufQ+CTl83jSqDWJK7YvxtwV8/uOzS5ZE8Us4qXGeaGLZv+RfFohIIdukTgp+dN+caWXlwqXNeDIvDDVhvwULC9Ui35nz5NBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721633223; c=relaxed/simple;
	bh=dH+wG+QVFbCksW1/xG4MwjSTXFfGmqsXVVmCulccai4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGk2LbrNTi4aP8Ey2hhQx33TNA3p3eL5zsITLEdTWCpiyNQm3blsZJbY96P1gNGM/ISKCUSNfzyx/LLcG2grFw5KU3T92V6lauO3FPG0/EXn5hs1lOylfG7ivXj7du0iAexuOQXtkbWU7vcB6Wh3uxvShhlAzQwxJCc4wSbuaoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwfZHQCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACB7C116B1;
	Mon, 22 Jul 2024 07:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721633222;
	bh=dH+wG+QVFbCksW1/xG4MwjSTXFfGmqsXVVmCulccai4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cwfZHQCyXkx/doLytbGc2a+uUyy/VW2gNvI8YSM5yCJ9jwI5i+3Pgq5CI9zfzBfCA
	 1N81oll60NfA8OBgFmbn+OyDkbBXWbuBkE1zfVgVPdkBE4nIHUtbLbqjiFTRYkrPEY
	 1WqM9Z3XQNb1Qu8KTNqbDSqr8v6inJkyiYFey9HQsAs9ko2sgjxlDCbmcYhV/hL+0f
	 NNIpiSDCVarmxKdtrxTIcOI/5510nKl2/hiuVY9xKUnWeoh3oEsdjvW4CkdZyhJwwg
	 r41+R3r7J8lbTox7FNqKpvaaUYE4qCyQ1/Yk+5/JMMmJ9fYz5K/OcdwQ3HGJ7Xoc0T
	 avfZzoMxlNX+g==
Date: Mon, 22 Jul 2024 10:23:54 +0300
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
Message-ID: <Zp4JCmiZgGZ8jq-b@kernel.org>
References: <20240722035701.696874-1-ruanjinjie@huawei.com>
 <20240722035701.696874-4-ruanjinjie@huawei.com>
 <Zp3-dZHhN7LbMggc@kernel.org>
 <5816d4d5-e038-c90b-5ac2-1a3b3a8b9e46@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5816d4d5-e038-c90b-5ac2-1a3b3a8b9e46@huawei.com>

On Mon, Jul 22, 2024 at 03:08:29PM +0800, Jinjie Ruan wrote:
> 
> 
> On 2024/7/22 14:38, Mike Rapoport wrote:
> > Hi,
> > 
> > On Mon, Jul 22, 2024 at 11:57:01AM +0800, Jinjie Ruan wrote:
> >> Similar with x86_32, on Riscv32 Qemu "virt" machine with 1GB memory, the
> >> crash kernel "crashkernel=4G" is ok as below:
> >> 	crashkernel reserved: 0x00000000bf400000 - 0x00000001bf400000 (4096 MB)
> >>
> >> The cause is that the crash_size is parsed and printed with "unsigned long
> >> long" data type which is 8 bytes but allocated used with "phys_addr_t"
> >> which is 4 bytes in memblock_phys_alloc_range().
> >>
> >> Fix it by checking if the crash_size is greater than system RAM size and
> >> warn out as parse_crashkernel_mem() do it if so.
> >>
> >> After this patch, it fails and there is no above confusing reserve
> >> success info.
> >>
> >> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> >> ---
> >>  arch/riscv/mm/init.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> >> index bfa2dea95354..5d66a4937fcd 100644
> >> --- a/arch/riscv/mm/init.c
> >> +++ b/arch/riscv/mm/init.c
> >> @@ -1381,6 +1381,11 @@ static void __init arch_reserve_crashkernel(void)
> >>  	if (ret)
> >>  		return;
> >>  
> >> +	if (crash_size >= memblock_phys_mem_size()) {
> >> +		pr_warn("Crashkernel: invalid size.");
> >> +		return;
> >> +	}
> >> +
> > 
> > What the point of adding three identical checks right after the call to
> > parse_crashkernel()?
> > 
> > This check should be there and parse_crashkernel() should return error in
> > this case.
> 
> Hi, Mike
> 
> How about the folling rough patch?
> 
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -313,7 +313,7 @@ int __init parse_crashkernel(char *cmdline,
>         if (high && ret == -ENOENT) {
>                 ret = __parse_crashkernel(cmdline, 0, crash_size,
>                                 crash_base, suffix_tbl[SUFFIX_HIGH]);
> -               if (ret || !*crash_size)
> +               if (ret || !*crash_size || crash_size >= system_ram)
>                         return -EINVAL;
> 
>                 /*
> @@ -332,7 +332,7 @@ int __init parse_crashkernel(char *cmdline,
>                 *high = true;
>         }
>  #endif
> -       if (!*crash_size)
> +       if (!*crash_size || crash_size >= system_ram)
>                 ret = -EINVAL;
> 

Why no simply

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5b2722a93a48..64312709877d 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -336,6 +336,9 @@ int __init parse_crashkernel(char *cmdline,
 	if (!*crash_size)
 		ret = -EINVAL;
 
+	if (*crash_size >= system_ram)
+		ret = -EINVAL;
+
 	return ret;
 }
 
 
> > 
> >>  	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
> >>  				    low_size, high);
> >>  }
> >> -- 
> >> 2.34.1
> >>
> > 

-- 
Sincerely yours,
Mike.

