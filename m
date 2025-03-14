Return-Path: <linux-kernel+bounces-561085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA1CA60D62
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222F23BBCAE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737851EB187;
	Fri, 14 Mar 2025 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brVBEtOw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83291DC9B3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944861; cv=none; b=GmCI5zff7v15OtO3ak9iHuHHKhQO7ewAIVx8Mj1SFRBy2lOwpyPH8N0DGtKVhcNdhOthAmNqGLIelr27ugYvu0pss72R1uqCU8o9H4c2tBvzlQgkACT8UPOR4IRsMd4TBrWnj3xzsUSdvT6JY3dgB5D5w1R9QRY3cnL9uWnIUC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944861; c=relaxed/simple;
	bh=fDIs4eN9xYKXL8BiR8/NJt+eM0rz07tPhoB1maFKxhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtcVs1YquSc0yylHBD3sQpEzzmACPt+9l7txej7eqq/wGnWuyppuIUHcfVoaXetkDqbw+Y3MRgJ7QS31zZI/c4v4FBgNlybkk2JAU61H5RhXObwOaFeqPyHxktOUfgKR50V9/DB0okR3rf3SgQmK5EFKuG2BE4CNN4JnRK6yOXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brVBEtOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A02C4CEE3;
	Fri, 14 Mar 2025 09:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741944861;
	bh=fDIs4eN9xYKXL8BiR8/NJt+eM0rz07tPhoB1maFKxhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=brVBEtOwpPWZkTRUScHvGiqa0E7c1a7X/l6AcEqT4U5f2K/BzLvIi+TbLKcCPgCBT
	 0CIUoeRlg/KkN4Txtrtwh7IsV3x4lgC5KmEnqlMYSCE0WNWF2ZDSJjUfMQZrW7Z5Do
	 8ehb1guXz9cS2tGUczEVifSwZJxyE8Xn5YifvLJ17ZD/X9264LNYUgTtEmyxs8j72h
	 QhXf3I2B6iDCM2G2wcj9eEyw2+rxUBuZhVsJzAx2HSx0kFadwMxEGc8R8zKdvNGf9c
	 b+arfsjOZwDsdS1SPKm1RXx5m0KHl0ijUUamjE597A9KOzkGzRwqFb9T+dBsYQ5cst
	 86iGa8Tdcw6Qw==
Date: Fri, 14 Mar 2025 10:34:15 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 4/5] x86/syscall/x32: Move x32 syscall table
Message-ID: <Z9P4Fx9Kl7mkSh9F@gmail.com>
References: <20250313182236.655724-1-brgerst@gmail.com>
 <20250313182236.655724-5-brgerst@gmail.com>
 <a30872ce-3acf-4d6a-8d96-c073c6f33895@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a30872ce-3acf-4d6a-8d96-c073c6f33895@intel.com>


* Sohil Mehta <sohil.mehta@intel.com> wrote:

> > +#ifdef CONFIG_X86_X32_ABI
> > +long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
> > +{
> > +	switch (nr) {
> > +	#include <asm/syscalls_x32.h>
> > +	default: return __x64_sys_ni_syscall(regs);
> > +	}
> > +};
> 
> There seems to be a stray semicolon here. The original code also has it
> but it doesn't seem necessary.

BTW., seeing that you've gone through this series with a fine comb I've 
added your Reviewed-by tag to the series (with the caveat that the 
details you've pointed out will be addressed in followup patches).
Let me know if that's not OK.

Thanks,

	Ingo
	

