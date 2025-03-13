Return-Path: <linux-kernel+bounces-560044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D45A5FCF7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE141883BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A7226AA8D;
	Thu, 13 Mar 2025 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AI68vsZT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF4B267F71;
	Thu, 13 Mar 2025 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885343; cv=none; b=WJRgwK5X35jnfV8cMpD5SL40b9JUj+iNsWW+7JmJbS5YejSoMbdlcVhuHVSDPaAECmLxiSWso9BgQomzPDQnnYvQrJRoFHQocSAsgFSKefGlCTOEeO+pIbVyN67Ludf5bqRimZL3ju9c6XmHylKVh7UwRfbd2qLf9zyHwZW0yJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885343; c=relaxed/simple;
	bh=Pq4GiX3lvKXfmijltB3bBZ70E7uKdot26ObyVre3x2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tu2UpX1RspZ7y5k3s4PNcLA9pY/mPvoTYOQh8g1RdmL4vNiMOa30y+z5dZTeKP6Knub2CLHi/TmR0Kqv4WaqjK8WhsXK1TKieW5qzjpEzknW0waSzwDRgqBSfacTpiT+pD6AsyjomSuLVQFWp9WWWctDqLBRF3KPQLOlUpjMkYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AI68vsZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E92C4CEDD;
	Thu, 13 Mar 2025 17:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741885341;
	bh=Pq4GiX3lvKXfmijltB3bBZ70E7uKdot26ObyVre3x2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AI68vsZT5xSdlZ2dB/0dmjA4jkPMbXzB3rSJFyeto3MaM5yEmxIlC4CQV4xn5jJfi
	 fbLncQghJDiotcfbn9H82dfNnFoSCj40DFMo1YHBhPDRaSArkLGGiAG/gLB/UX0d6w
	 VWZnyJ2X2OtJS/LDspDGQl3TMIRWcNxt0ZrK/OhWpDyxqi8ncvnwcul4TMNfKU9AkA
	 D46IeUKC0+10clFHz7lfTnPO+CKmqDFGbUMIgR3TE3amuZBoDQN/GxX5fTpB+JQElx
	 336a/L6cOKrCNqeGM5SXfkElnEfmMuOnnnrT9fHinvhrKABaPvNaM/mzRdWb20hpA4
	 Mf8xd/upTzyIA==
Date: Thu, 13 Mar 2025 18:02:16 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Akihiro Suda <suda.gitsendemail@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, suda.kyoto@gmail.com,
	regressions@lists.linux.dev, aruna.ramakrishna@oracle.com,
	tglx@linutronix.de, Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
Subject: Re: [PATCH v2] x86: disable PKU when running on Apple Virtualization
Message-ID: <Z9MPmA-myNZxcc-E@gmail.com>
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


* Akihiro Suda <suda.gitsendemail@gmail.com> wrote:

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

So this is rather weird, but I've applied the quirk as it upgrades 
broken guest side code into a boot time warning.

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

Note that I updated the comments here (the git log gives enough 
information), plus enclosed this into #ifdef CONFIG_ACPI, as 
acpi_gbl_FADT is not available on !CONFIG_ACPI builds.

Thanks,

	Ingo

