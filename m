Return-Path: <linux-kernel+bounces-439713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 093BE9EB2F7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFB51882676
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2151AA1FD;
	Tue, 10 Dec 2024 14:18:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F7278F4E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840282; cv=none; b=D+3kTmEVET36RiLv7od9bfbLyJg7H8uMOHeLoe1PI6d1BZSW0+t6GyVGLg8mSfs1VzEQHEUkqOYK8OIB2fXdyfaPaPdatOfJZI7vBs3jKPZ4jidY0N47x2F16ZYdPeqhnRavXXcrhHJRSPQL9sULp0aMiMSrcz+VcLIE1/RRssc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840282; c=relaxed/simple;
	bh=Sk+xe2BuGF2QZejbbwuH1DAn5+Ci6lCfrNGZmOPNmFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGnJWkMrLOoUqUc8pf37u3QCWrZAz0CKlzMhzouVdophMHvCLf7YHhotmV/MFH3Co7yNLQVN0YOYqCxVcvB1ZuqRhO77fHDed2Vi5OnQ5b3MMNERkV/6JigFUi6308Twd03cyIXUXDCw3be9oyonlDoozcdWvKxJaqpkf8lnYPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0502C4CED6;
	Tue, 10 Dec 2024 14:18:00 +0000 (UTC)
Date: Tue, 10 Dec 2024 14:17:58 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] arm64/signal: Silence spurious sparse warning storing
 GCSPR_EL0
Message-ID: <Z1hNllCWa4u-IxrH@arm.com>
References: <20241210-arm64-gcs-signal-sparse-v1-1-26888bcd6f89@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-arm64-gcs-signal-sparse-v1-1-26888bcd6f89@kernel.org>

On Tue, Dec 10, 2024 at 12:42:53AM +0000, Mark Brown wrote:
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 14ac6fdb872b9672e4b16a097f1b577aae8dec50..83ea7e5fd2b54566c6649b82b8570657a5711dd4 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -39,7 +39,7 @@
>  #ifdef CONFIG_ARM64_GCS
>  #define GCS_SIGNAL_CAP(addr) (((unsigned long)addr) & GCS_CAP_ADDR_MASK)
>  
> -static bool gcs_signal_cap_valid(u64 addr, u64 val)
> +static bool gcs_signal_cap_valid(unsigned long __user *addr, u64 val)
>  {
>  	return val == GCS_SIGNAL_CAP(addr);
>  }
> @@ -1094,15 +1094,15 @@ static int gcs_restore_signal(void)
>  	/*
>  	 * Check that the cap is the actual GCS before replacing it.
>  	 */
> -	if (!gcs_signal_cap_valid((u64)gcspr_el0, cap))
> +	if (!gcs_signal_cap_valid(gcspr_el0, cap))
>  		return -EINVAL;
>  
>  	/* Invalidate the token to prevent reuse */
> -	put_user_gcs(0, (__user void*)gcspr_el0, &ret);
> +	put_user_gcs(0, gcspr_el0, &ret);
>  	if (ret != 0)
>  		return -EFAULT;
>  
> -	write_sysreg_s(gcspr_el0 + 1, SYS_GCSPR_EL0);
> +	write_sysreg_s((unsigned long)(gcspr_el0 + 1), SYS_GCSPR_EL0);

Would we now get a warning here?

-- 
Catalin

