Return-Path: <linux-kernel+bounces-518968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B96A3967E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B96188D3C0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E993522D4FF;
	Tue, 18 Feb 2025 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pis013iR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F2822AE59
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869648; cv=none; b=dZFlnOXM6Zv+zo7rqnpLpcXcPDtcxTO7BFiKOlYEKAZal6Ce4R+1IzSSoWy67gfyXhV/L6nEYN2AwxjhhmFkMJldP4JBsF8T8sIydoHiD/4C4bMarCQMgHEIaX346WpI8ds79T5AD3V4crTXxAWmj+k2DQYbYQc5junfwRVMvk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869648; c=relaxed/simple;
	bh=zuwMhmH8w50LYsAFHKURsu2l9zRkMmG5Ds5XAKofXRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJa58+tbNUEuQOaR5QPW1YhgDLQUahvYQCHZR8jY8SjL9VBHYf8z6X+QoTa1hP1mixteHbdNPhOn7ZojuRIJIqsoYMl5WM6Ch2vLLC8fjhKH2Ev1zx3vWp/L+8Iso+Io/D+0HEwO2Xpx+FvH1L9B8uFp+vXgu902BJ7b1ot3sQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pis013iR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECA5C4CEE2;
	Tue, 18 Feb 2025 09:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739869647;
	bh=zuwMhmH8w50LYsAFHKURsu2l9zRkMmG5Ds5XAKofXRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pis013iRqbUbwFMPEPXWPcuFx2fqSMpj6sjL3SQ4jHJJJRW3JY+NYCM27XgX/KwMY
	 hOLbylf9ZC/Z6v8oV2N6wsgaCrIlrCm+OTS57eNT5AIdm3fM7sWdjaXQlgC51xNN0a
	 wDoJuGAU170FYk4fIR+93CINZCUtzg3MJbhzgivzT1MWeB80+T6TetVfXb8yu/USQu
	 lFYKDJs+AS/0mQweKp4lwtf74GBkD6HCrMcYSpMKv+tl7ghqspdn+YKgKes5Y5Ytao
	 5ix9vViVF722wmzFJsIMzEvHlKOCgLMly9iJpAnfmA128tbCfMjIyT2T+ErjzOeQxL
	 v4SgL9soBT63g==
Date: Tue, 18 Feb 2025 10:07:17 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH v6 06/15] x86/module: Deal with GOT based stack cookie
 load on Clang < 17
Message-ID: <Z7RNxf9NWmGZ6aDE@gmail.com>
References: <20250123190747.745588-1-brgerst@gmail.com>
 <20250123190747.745588-7-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123190747.745588-7-brgerst@gmail.com>


* Brian Gerst <brgerst@gmail.com> wrote:

>  #define R_X86_64_GOTPCREL	9	/* 32 bit signed pc relative
> -					   offset to GOT */
> +#define R_X86_64_GOTPCRELX	41	   offset to GOT */
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +#define R_X86_64_REX_GOTPCRELX	42

Uhm, I'm pretty sure this won't even build, should any code use 
R_X86_64_GOTPCRELX - which it doesn't currently...

Also, each entry here has a comment explaining it - except these two 
new GOTPCREL variants.

Thanks,

	Ingo

