Return-Path: <linux-kernel+bounces-574958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B616A6EBFB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226C51892078
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9981C8611;
	Tue, 25 Mar 2025 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXZog7Gq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222678634A;
	Tue, 25 Mar 2025 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742892938; cv=none; b=WBXMK1g3zCooOs/qEfFEmaBeCOIB83nDR7CFk8WBHMxcauj429jKQDxyRbUQip2hwbBV1c5N8Iiq85S1HPXGdcsZ+gfhvaToHz4COh+/LL0X1d0KRs6/A8MbMDskxlPz2VY+Y+M9EVSvsE7WJEHmQnwnbqx6XNJou2XLMJLADa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742892938; c=relaxed/simple;
	bh=B5wykLp2NelgHM/2avcbRCi8h2SHxyT0zwenvWusG2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJjzKICwDq0AxbpcFCWmWqNN33AWDNRoqPN/2ohd4MMeliFHJ2jxwO7M+BHPrJgJYIUZIb+zwUZFh0ybxGGyT+9dq67qukJ8c1fY4Xbrtg/d96UFQbDOenYPNYBkZ61ZL0hyAl1sCwpEdHIkJKE3607PiC+SO8lCjo3jGICmC54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXZog7Gq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D7BC4CEE4;
	Tue, 25 Mar 2025 08:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742892937;
	bh=B5wykLp2NelgHM/2avcbRCi8h2SHxyT0zwenvWusG2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PXZog7GqDBpiSrdYdLmWgAmWF+h0LJjE39IxYk759O6g77TGQxEdFFrlMID42/USB
	 UYx5nHTArs1oxBus4Rss948PNDzVKm57l68+d6/fv6BujxCQV4KBwm5TVPllUWMaxp
	 0UV6H1RM6+mYhqxxF0btBk7T86Q18lhNrk5tqgcvoxL/tLUbmV73ahcDK6icPzCDfZ
	 sP5h6pFOcMbDA21duKp6hofdvWB+GZooQZjhWqxVTXs14Drr0hN80tqYyefFubMCUr
	 ShzgtrAaMHWz0m9fLmME7xoX8xaysj7C+5nE0zvBJOM7NEtzsShW0afLi6o/rCm2SI
	 dYwcv5kb34N2Q==
Date: Tue, 25 Mar 2025 09:55:32 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 01/20] tools/x86/kcpuid: Fix error handling
Message-ID: <Z-JvhGRhCg6Jimay@gmail.com>
References: <20250324142042.29010-1-darwi@linutronix.de>
 <20250324142042.29010-2-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324142042.29010-2-darwi@linutronix.de>


* Ahmed S. Darwish <darwi@linutronix.de> wrote:

>  static void usage(void)
>  {
> -	printf("kcpuid [-abdfhr] [-l leaf] [-s subleaf]\n"
> -		"\t-a|--all             Show both bit flags and complex bit fields info\n"
> -		"\t-b|--bitflags        Show boolean flags only\n"
> -		"\t-d|--detail          Show details of the flag/fields (default)\n"
> -		"\t-f|--flags           Specify the cpuid csv file\n"
> -		"\t-h|--help            Show usage info\n"
> -		"\t-l|--leaf=index      Specify the leaf you want to check\n"
> -		"\t-r|--raw             Show raw cpuid data\n"
> -		"\t-s|--subleaf=sub     Specify the subleaf you want to check\n"
> +	warnx("kcpuid [-abdfhr] [-l leaf] [-s subleaf]\n"
> +	      "\t-a|--all             Show both bit flags and complex bit fields info\n"
> +	      "\t-b|--bitflags        Show boolean flags only\n"
> +	      "\t-d|--detail          Show details of the flag/fields (default)\n"
> +	      "\t-f|--flags           Specify the cpuid csv file\n"
> +	      "\t-h|--help            Show usage info\n"
> +	      "\t-l|--leaf=index      Specify the leaf you want to check\n"
> +	      "\t-r|--raw             Show raw cpuid data\n"
> +	      "\t-s|--subleaf=sub     Specify the subleaf you want to check"

Here you missed a few cases of:

 s/csv/CSV
 s/cpuid/CPUID

I fixed this all up in the patches & commits, no need to resend.

Thanks,

	Ingo

