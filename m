Return-Path: <linux-kernel+bounces-447067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD6F9F2CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA541650E4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EA0201018;
	Mon, 16 Dec 2024 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSX0Jjie"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F01FF60C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734341049; cv=none; b=R7uoQLhDKA70psX3pS2VJN2iXcFIR9itEPy1QZEuC+++dzTxpmnoh5AVWdTRqHjOaDH7uEkedrw7p7RBUOkyNP0kAyY+iSdZH6ltrfUuwFJ8mhu44BjC0tk1N0v3KGYbXQrkX7F+PL5G/ZaRlJ/jqWKc/d7i922y6YuW8hzb70c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734341049; c=relaxed/simple;
	bh=TyL04/ZVPAxtZvX8wOKg+JXhJXaXAwgeyUk9X4CVA8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K28Z+nzA5X22pX7bffxbk3O5GRsLCmpnO+g5LcIz9lypUC+Q/O6sjME8Hkc14HGzH9mHxkli3B9EMgQEriIN5l++gA1crtzzHA+EgyZVVM4Bm9X/JODabBXv83eJzeT4p+t3P+JV1fFfsmbfG1vkc0REWNU4UgBHAsllDktKc7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSX0Jjie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E55C4CED0;
	Mon, 16 Dec 2024 09:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734341049;
	bh=TyL04/ZVPAxtZvX8wOKg+JXhJXaXAwgeyUk9X4CVA8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JSX0JjieFV33vwJvg3fAOGxJ7MhZ/eTzf5vLclbbJMeHdtLscY62SSC4T9kAgkX7K
	 QexrIm7ktRxG4AX+qU24HGUUHkOq2o+NC7YBo9CUQ1yxNz2WgEvGRwNMjF/0KF6n7h
	 wOKpPlI2t6dtRT97n9sDpXQ74hQIcgJu8b9JAKriloxtzxc8sRQy5NgFHNLvuXGh2N
	 i3mC1r40Lz6bfDdpFX1AgBEO0i1LnfjR6IVq4+2vdnUcpii6vZ8MvK932Hqnz1scHr
	 x7kjdTxUCI+krXpgFy4AjshdPKJeAUNnDpakwlUVVRINxMBSFF9cLf4Rs9O9iBWQRZ
	 D5aNvI+lhlAYQ==
Date: Mon, 16 Dec 2024 11:23:55 +0200
From: Mike Rapoport <rppt@kernel.org>
To: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Ning Sun <ning.sun@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	tboot-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 0/4] x86/boot: a few cleanups
Message-ID: <Z1_xq9A2o6h0rWJ2@kernel.org>
References: <20241206103031.737458-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206103031.737458-1-rppt@kernel.org>

Gentle ping

On Fri, Dec 06, 2024 at 12:30:27PM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Hi,
> 
> These patches cleanup x86::setup_arch() and e820.c.
> No functional changes intended.
> 
> v2: update comments as suggested by Ingo
> v1: https://lore.kernel.org/all/20241203112525.591496-1-rppt@kernel.org
> 
> Mike Rapoport (Microsoft) (4):
>   x86/boot: move setting of memblock parameters to e820__memblock_setup()
>   x86/boot: split kernel resources setup into a helper function
>   x86/boot: split parsing of boot_params into a helper function
>   x86/e820: drop E820_TYPE_RESERVED_KERN and related code
> 
>  arch/x86/include/asm/e820/api.h   |   1 -
>  arch/x86/include/asm/e820/types.h |   9 --
>  arch/x86/kernel/e820.c            |  95 ++++++++-------------
>  arch/x86/kernel/setup.c           | 134 ++++++++++++++----------------
>  arch/x86/kernel/tboot.c           |   3 +-
>  arch/x86/mm/init_64.c             |   8 --
>  6 files changed, 97 insertions(+), 153 deletions(-)
> 
> 
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> -- 
> 2.45.2
> 

-- 
Sincerely yours,
Mike.

