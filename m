Return-Path: <linux-kernel+bounces-557526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF9CA5DA60
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D92B7A3614
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323D823E329;
	Wed, 12 Mar 2025 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OmlkWsFp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A38D23CF06;
	Wed, 12 Mar 2025 10:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741774897; cv=none; b=ZnPEIHjUKKQLdiwrl4BdJeJtIfR8uWmEKfDujR1pK86nLt0JSRu/jeLS3hwJcLsTLPaRHyOQ9YYz0UbMw7wUz/zfNYxd3e4RGHww+5DIrPltR56Zb0i8+zW1Fq0sjyZd6yy6EFxCMYc/MGBdI6k8JcedhfaUOa3H/8yRGLKpTHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741774897; c=relaxed/simple;
	bh=TwfYyqb9/mMQUrdLVTvq9KdVsmAKrhEkOXYXu6MsYrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtAiFX51vaptyW2COnO+x9oi1IlILgzxinSem0sRMf9B3ioo3Aztlp9wboxqXfNbPwO+Ir0n7t8OjwHHb1SEoKMTTdQrovFUa49pzllXHz79z+wpnPD5bhTNHWAwYkbSysoPid5seJlzNw+EqAsZIbvLSA7Xd+3CVJLjVLK+KqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OmlkWsFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC24FC4CEE3;
	Wed, 12 Mar 2025 10:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741774897;
	bh=TwfYyqb9/mMQUrdLVTvq9KdVsmAKrhEkOXYXu6MsYrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OmlkWsFpMtUR9XXN7XLsmWVlpBclQ2BZmSnpib54pKhUO0xMGiHMxavAaOcOW4Ao8
	 TJcZBqpd4MZKTw4ud6+x9WajNEhY+iHijSLVXFuGD1aB2ETpG8EmTVtbOzdcx2Iw92
	 mL+KYuP9Qkl3lD9M/k9gMqCsVAqO1wU/xwBGfovQ=
Date: Wed, 12 Mar 2025 11:21:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Akihiro Suda <suda.gitsendemail@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, suda.kyoto@gmail.com,
	regressions@lists.linux.dev, aruna.ramakrishna@oracle.com,
	tglx@linutronix.de, Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
Subject: Re: [PATCH v2] x86: disable PKU when running on Apple Virtualization
Message-ID: <2025031206-require-ranged-e62e@gregkh>
References: <CAG8fp8Qdmt9vLk=8ORccY5B+ec1huhazXG4PBaNyLEkq31HDjw@mail.gmail.com>
 <20250312100926.34954-1-akihiro.suda.cz@hco.ntt.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312100926.34954-1-akihiro.suda.cz@hco.ntt.co.jp>

On Wed, Mar 12, 2025 at 07:09:26PM +0900, Akihiro Suda wrote:
> OSPKE seems broken on Apple Virtualization.
> 
>   WARNING: CPU: 0 PID: 1 at arch/x86/kernel/fpu/xstate.c:1003 get_xsave_addr_user+0x28/0x40
>   (...)
>   Call Trace:
>    <TASK>
>    ? get_xsave_addr_user+0x28/0x40
>    ? __warn.cold+0x8e/0xea
>    ? get_xsave_addr_user+0x28/0x40
>    ? report_bug+0xff/0x140
>    ? handle_bug+0x3b/0x70
>    ? exc_invalid_op+0x17/0x70
>    ? asm_exc_invalid_op+0x1a/0x20
>    ? get_xsave_addr_user+0x28/0x40
>    copy_fpstate_to_sigframe+0x1be/0x380
>    ? __put_user_8+0x11/0x20
>    get_sigframe+0xf1/0x280
>    x64_setup_rt_frame+0x67/0x2c0
>    arch_do_signal_or_restart+0x1b3/0x240
>    syscall_exit_to_user_mode+0xb0/0x130
>    do_syscall_64+0xab/0x1a0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Tested on macOS 13.5.1 running on MacBook Pro 2020 with
> Intel(R) Core(TM) i7-1068NG7 CPU @ 2.30GHz.
> 
> Fixes: 70044df250d0 ("x86/pkeys: Update PKRU to enable all pkeys before XSAVE")
> Link: https://lore.kernel.org/regressions/CAG8fp8QvH71Wi_y7b7tgFp7knK38rfrF7rRHh-gFKqeS0gxY6Q@mail.gmail.com/T/#u
> Link: https://github.com/lima-vm/lima/issues/3334
> Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
> ---
> v2: check oem_table_id rather than oem_id for better robustness
> ---
>  arch/x86/kernel/cpu/common.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 7cce91b19fb2..8d78d34cd434 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -26,6 +26,7 @@
>  #include <linux/pgtable.h>
>  #include <linux/stackprotector.h>
>  #include <linux/utsname.h>
> +#include <linux/acpi.h>
>  
>  #include <asm/alternative.h>
>  #include <asm/cmdline.h>
> @@ -516,6 +517,21 @@ static bool pku_disabled;
>  
>  static __always_inline void setup_pku(struct cpuinfo_x86 *c)
>  {
> +	/*
> +	 * OSPKE seems broken on Apple Virtualization.
> +	 * https://lore.kernel.org/regressions/CAG8fp8QvH71Wi_y7b7tgFp7knK38rfrF7rRHh-gFKqeS0gxY6Q@mail.gmail.com/T/#u
> +	 *
> +	 * TODO: conditionally enable pku depending on the DMI BIOS version when Apple
> +	 * fixes the issue.
> +	 *
> +	 * However, this would be still not enough because DMI is missing when vmlinuz
> +	 * is directly loaded into VM.
> +	 */
> +	if (!memcmp(acpi_gbl_FADT.header.oem_table_id, "Apple Vz", 8)) {
> +		pr_info("pku: disabled on Apple Virtualization platform (Intel) due to a bug\n");
> +		pku_disabled = true;
> +	}
> +
>  	if (c == &boot_cpu_data) {
>  		if (pku_disabled || !cpu_feature_enabled(X86_FEATURE_PKU))
>  			return;
> -- 
> 2.45.2
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

