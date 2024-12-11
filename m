Return-Path: <linux-kernel+bounces-441841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3C59ED4C5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF738168DFF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF21204F9E;
	Wed, 11 Dec 2024 18:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aH+/ToxE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E041FF1CD;
	Wed, 11 Dec 2024 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733942242; cv=none; b=K/gmht2sgtq4bXKZuA8YSVYlPzBqDO0r2eKeCARoJcNxpDSwTbxM3HJHneHuTXIz8k+0qwXZIzKL0z5ZX9+QFjszleidg40u8BuOAepSsHlKz9f/t7GU0ySkpc9jds+MLR71pRD5Ss6pMhUz38bb0RLCsjf2koGL1caj8NqGZCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733942242; c=relaxed/simple;
	bh=yW8NEIXdt8OgTLq+qNcqrg8UeS/00IHJeoZcZH4OVrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJr7W4qG8vvZEJUwYXr3pBlFSiHidGeJRFMU13BOXI5csRG3g+MydFOYboM5kwZqAZ2N3bG5RZXaXurLOHXtsKA/KoCNkht0qTUiGXYKGShko3QkgDwqyDRjQzRNz3GbHxX7DHRdkGjwQUADFyNXY/nNVLMndnhaqQNrjM7LKUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aH+/ToxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655ACC4CED2;
	Wed, 11 Dec 2024 18:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733942241;
	bh=yW8NEIXdt8OgTLq+qNcqrg8UeS/00IHJeoZcZH4OVrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aH+/ToxERJ5G0TrDJiyW6v3nPQxSWBCX1BoK092ZPKWLPpQ+lB6O5gKlVro0pOXev
	 KrTFYiVpt4XtPUeJk/5zby/K5AyFKKxj6xUqd57Sjb2gMBU6zNYoCuXMM84a9NIWXc
	 LzDtIRYAKyFSmGcJfwuGELNTFbrsE5qG/L36CXVhtH5sWntYTqd4nan8SIwfjuZktO
	 i/+qdv/K+GFBZIn+ndOWWS5X1Us/5Nts/K7Vqg+N1op+LTaWiS6Afq16lft+1DHgji
	 MB90Dz18wrUsoeeW6aow4jX1yXu7O0bem3C+xZsPCz7GlNhAGumqxvQ4RhbmMXoHYq
	 3GYg3xGL3G+8A==
Date: Wed, 11 Dec 2024 10:37:19 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/10] objtool: Handle different entry size of rodata
Message-ID: <20241211183719.fz4av7mfht3ec74a@jpoimboe>
References: <20241207015915.1159-1-yangtiezhu@loongson.cn>
 <20241207015915.1159-3-yangtiezhu@loongson.cn>
 <20241209195413.gpq7t3nacsnx3xo3@jpoimboe>
 <832fe56f-1688-d128-50dd-3f668815a248@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <832fe56f-1688-d128-50dd-3f668815a248@loongson.cn>

On Wed, Dec 11, 2024 at 11:11:28AM +0800, Tiezhu Yang wrote:
> unsigned int arch_reloc_size(struct reloc *reloc)
> {
>         switch (reloc_type(reloc)) {
>         case R_X86_64_32:
>         case R_X86_64_PC32:
>         case R_X86_64_PLT32:
>                 return 4;
>         default:
>                 return 8;
>         }

Looks good to me, you can add R_X86_64_32S as well.

> For ppc, like this:
> 
> unsigned int arch_reloc_size(struct reloc *reloc)
> {
>         switch (reloc_type(reloc)) {
>         case R_PPC_REL32:
>         case R_PPC64_REL32:
>                 return 4;
>         default:
>                 return 8;
>         }

Also:

R_PPC_ADDR32
R_PPC_UADDR32	
R_PPC_PLT32
R_PPC_PLTREL32

And the ppc64 counterparts have the same values, so not necessary to add
them.

-- 
Josh

