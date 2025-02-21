Return-Path: <linux-kernel+bounces-525954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAA2A3F7C9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695A93B523A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C592220F09A;
	Fri, 21 Feb 2025 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSXM//ND"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318AE205514
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149719; cv=none; b=OrefXnOMfh8B4KechDFLK+eO8GwODE1wbzgrAY52qXNTeRNI7NAgzySD9qZaEAQmAf+DyQxxSM7ILNIo9Y+gmK418xsGLyqRdjq2FaAFUgcFB+Hs0E/I/vwSoS7ODHn3dkkSj7bt55GQb1PldWn9NMMfz1/VaX+YlAD9qB3UgJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149719; c=relaxed/simple;
	bh=XtWO7IZGeVOG4s5bQUKGzp4rBpQT5RouY9R7IjvPx7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzK0M57KTWn2CVCVnV9nAEQQiv2qDQTpH6Q1lqmbgTYJcDtJYI8/r8k5A/rlZ5+CBKKUbs4Tcj5UP8sIfrGk+i7Tg7mgQQNEZKHMdbuXHU5wU/yqV/zOjyRZnr7WDck0adwIPDwqQO9tXPwvghqTaCVZ51ovOTUKd2Qb44kHPYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSXM//ND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB61C4CEE9;
	Fri, 21 Feb 2025 14:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740149718;
	bh=XtWO7IZGeVOG4s5bQUKGzp4rBpQT5RouY9R7IjvPx7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DSXM//NDZfJsNGrDESXfeNq+/JoaOflIxwktoYQmxXLKdrU237JO1FFf0fvlTs2Uz
	 +oeA191d+g/Su30U1v4fJJnXcibs60lsJxljM1lH6gUBv1DSJ6XNCYQKoF/ohk9qLs
	 aK4h3p04skCBS3SbiN6xVj0dw670YudCy9+To9TickEtaYgMCPTBGT45aaJRNg2/Yu
	 IzStYvD4nVmSFfREH+9R/MByuztTrvOUSXCysqdFQ2AP5xXktJ7W0+4To5le34lsJ2
	 MQfafd8kNcnOB55/C+uc0Yo5t6fDiD0qWjHDXolWUu9o80Ndkak5i4g8VCcqzuMDq2
	 DCbAkG8fm7jfQ==
Date: Fri, 21 Feb 2025 14:55:14 +0000
From: Will Deacon <will@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: Don't use %pK through printk
Message-ID: <20250221145513.GA20567@willie-the-truck>
References: <20250217-restricted-pointers-arm64-v1-1-14bb1f516b01@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217-restricted-pointers-arm64-v1-1-14bb1f516b01@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Feb 17, 2025 at 08:39:06AM +0100, Thomas Weiﬂschuh wrote:
> Restricted pointers ("%pK") are not meant to be used through printk().
> It can unintentionally expose security sensitive, raw pointer values.
> 
> Use regular pointer formatting instead.
> 
> Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/arm64/mm/physaddr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/physaddr.c b/arch/arm64/mm/physaddr.c
> index cde44c13dda1bc0924d2d50369ad87f544a0a802..7d94e09b01b35094e883875a46b979666549095c 100644
> --- a/arch/arm64/mm/physaddr.c
> +++ b/arch/arm64/mm/physaddr.c
> @@ -10,7 +10,7 @@
>  phys_addr_t __virt_to_phys(unsigned long x)
>  {
>  	WARN(!__is_lm_address(__tag_reset(x)),
> -	     "virt_to_phys used for non-linear address: %pK (%pS)\n",
> +	     "virt_to_phys used for non-linear address: %p (%pS)\n",
>  	      (void *)x,
>  	      (void *)x);

This is part of a WARN() and knowing the actual address may well be
useful in debugging. I suspect it also ends up being dumped as part of
the register dump _anyway_.

Will

