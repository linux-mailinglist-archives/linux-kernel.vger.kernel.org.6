Return-Path: <linux-kernel+bounces-318769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDEF96F31A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262731F223E6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28291CB12C;
	Fri,  6 Sep 2024 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urHbFJgA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3132D15852B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725622259; cv=none; b=M5/PkMlZc9CpIuH21woXxIqzOVAA3+ceBRFKe6/dPoDKolxY9cqYoyvv2+sHXYVbHsukqMT349Cg/CzL3+7FogSDq0xa7TVGC3hzWmwX0MTHuPGsNWKGIpv5ClFClGhMOayB6xjHHl6ch82rJ14/EWDwEh0yvOZjifDRhW+4mfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725622259; c=relaxed/simple;
	bh=KsFKVOSYoCnztZV+8yPxYOicRIlRK5U8T8o6SXl6mAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cT2s5AZemOLufz++ERJJuARNlZLKHDULCAtWJgZ5drTsS2FURSzwGq07Ip5Csg/NiNLn/Xu2HBjrqUIqzNTrJLhW6QHaufMknD1g0IBBvvvXNhZAKfb1J89GFC8w3SYBF+txgKzd0TS0CpE62lc9nyph7UxfEvP8OUpXaDugA2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urHbFJgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA0CC4CEC4;
	Fri,  6 Sep 2024 11:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725622257;
	bh=KsFKVOSYoCnztZV+8yPxYOicRIlRK5U8T8o6SXl6mAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=urHbFJgAAj29sBoL3XI9E5mPOhSY+tCOietZky9XbeWIixVaxgGI7BTtHW2JDXwuG
	 xazPCb690CLuR0M4lVdyIQ220Jb5iXBzS5pHxcQMefEONS2c0ptVDJeES9+ie8qnqD
	 NYBY0F0h6CcCIZ+Wt+ETt90iAlN1wxzVasjKF/dk4wpVf5ctFwFVJ+gb92sKHxuQcg
	 PabS68QzDFeI7N9l9BGDr96ly/U+L9EhgNZH/DIU0Q65CBMzIm0hSDhmSI7F33r5zW
	 FXd2RyGtTlIB1S/AgYkbbC4hkveoXuVMJu0KyTdRASCWkK7+2ocqwEHgmb9BSbz4Uf
	 7MxTwJB4lceOQ==
Date: Fri, 6 Sep 2024 12:30:51 +0100
From: Will Deacon <will@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Clark Williams <williams@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/3] arm64: Allow to enable PREEMPT_RT.
Message-ID: <20240906113050.GB16124@willie-the-truck>
References: <20240906111841.562402-1-bigeasy@linutronix.de>
 <20240906111841.562402-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906111841.562402-3-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Sep 06, 2024 at 12:59:05PM +0200, Sebastian Andrzej Siewior wrote:
> It is really time.
> 
> arm64 has all the required architecture related changes, that have been
> identified over time, in order to enable PREEMPT_RT. With the recent
> printk changes, the last known road block has been addressed.
> 
> Allow to enable PREEMPT_RT on arm64.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 0e5bd38633936..2cce9cb44c31e 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -101,6 +101,7 @@ config ARM64
>  	select ARCH_SUPPORTS_NUMA_BALANCING
>  	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
>  	select ARCH_SUPPORTS_PER_VMA_LOCK
> +	select ARCH_SUPPORTS_RT
>  	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
>  	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>  	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
> -- 
> 2.45.2

Acked-by: Will Deacon <will@kernel.org>

"Let it rip!"

Will

