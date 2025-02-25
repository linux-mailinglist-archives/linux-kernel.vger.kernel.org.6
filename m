Return-Path: <linux-kernel+bounces-531477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79694A44118
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE8F16A8F7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BEA26981E;
	Tue, 25 Feb 2025 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4Ds20wG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC086268FF8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490521; cv=none; b=f6+TPbFH25EKtV4B7KUd+8XWTjnqQk62N14aX9sGFjmFLkgLITP2nxILF7n/NW2/PZAzm1f6GHmADwSK6M8sCsgquEQ7jV7Y75BnQVHMzRfyr8IwABkexe3n/uzjJCG2OIMIp3GiaQTyBwUJvwoEhQ5w/X0KwiugZ0+3h1Pzyvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490521; c=relaxed/simple;
	bh=vpWPcNVLmkBSbC5ElRatTgDIB7BIfVf5XaBoa9gZcN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2BiZTYy2U7k8FrZH1zxNZx3AKYsjGefAhRXnzNukQv6TuQON3cJI85a/+2BoClPFGwhcB+IvgeO3/z8uUd6cFS6j7ymHVgK8lN70861W8Hqh3XAw9WH2BfeRBg5lDKac/HVLluTAtvum84n3K3BqnGstDz2MZtvq6E+QseLNTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4Ds20wG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4434AC4CEDD;
	Tue, 25 Feb 2025 13:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740490521;
	bh=vpWPcNVLmkBSbC5ElRatTgDIB7BIfVf5XaBoa9gZcN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q4Ds20wGywnswOj7inuhX6Uc5uieTRA9OUPyOCP3zN0n03DHgD5xjrKjQnf9dR9sP
	 IbpDBbT7+8cGbYJDOCCxXpOmnY1XMrLpH+7dUWJ3Q6oQx1tyUzyGQQld9vdSo6OCdT
	 PUg6nPgQwtB2LWKqLBufE8uW6t7O4U9/WJuuvQFTQ7heMtko/2Q0BC0hM2gGMvcsSW
	 BYYSYf9XbNbEmMPeCyPJhfa4ZUwT0auOQJ0GTbN1XmvV1I2Sp84klIj1p9OW5P1LJy
	 L9jrrUGV+o39UdYEX0oJaOOhSxjl4V55b1RPwB/pb3rGHq/xm3/3+3HjcVRfVMskU2
	 sRp5l6R8b0HaA==
Date: Tue, 25 Feb 2025 14:35:10 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mtrr: Remove unnecessary strlen() in mtrr_write()
Message-ID: <Z73HDk9p2P_Zigu2@gmail.com>
References: <20250225131621.329699-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225131621.329699-2-thorsten.blum@linux.dev>


* Thorsten Blum <thorsten.blum@linux.dev> wrote:

> The local variable length already holds the string length after calling
> strncpy_from_user(). Using another local variable linlen and calling
> strlen() is therefore unnecessary and can be removed. Remove linlen
> and strlen() and use length instead.
> 
> Compile-tested only.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/x86/kernel/cpu/mtrr/if.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
> index a5c506f6da7f..4049235b1bfe 100644
> --- a/arch/x86/kernel/cpu/mtrr/if.c
> +++ b/arch/x86/kernel/cpu/mtrr/if.c
> @@ -99,7 +99,6 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
>  	char *ptr;
>  	char line[LINE_SIZE];
>  	int length;
> -	size_t linelen;
>  
>  	memset(line, 0, LINE_SIZE);
>  
> @@ -108,9 +107,8 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
>  	if (length < 0)
>  		return length;
>  
> -	linelen = strlen(line);
> -	ptr = line + linelen - 1;
> -	if (linelen && *ptr == '\n')
> +	ptr = line + length - 1;
> +	if (length && *ptr == '\n')
>  		*ptr = '\0';

I see no corner-case analysis in the changelog about what may happen if 
the copy fails partially.

Thanks,

	Ingo

