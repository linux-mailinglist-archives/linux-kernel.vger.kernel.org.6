Return-Path: <linux-kernel+bounces-269974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0627594397F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00221F216C4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508D316D9D8;
	Wed, 31 Jul 2024 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="q6RWam+/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3731114B097
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722469705; cv=none; b=bBhaG4byaFnvkOpYWFixFX2FwSKAjFy9xHKjyhtkfusOZV2bvxHpFp0WqtuBSKXN0DE744GrhaTd9z2dXdeVVugEXS208gug72m06VzaKTe3BXRYTAfJl+7U4lrrtUgcICv0+f2gSSHjAQCBFlchzGhZpfDOHihzq6kvI5cklcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722469705; c=relaxed/simple;
	bh=/IIaZdmYNOt4xk2a7EyuaHC4cDYJRlszzg+xMZxGdpw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CysGLRpglHCewbeziBeGZgpQgDCbZA6R75djidjXnIqJvAvmN++7d1SfoTxta8LNZPl7sjVq5OeU2G+HwLvr9D+MGAcOB1u7RH3ruQaLVbhYOvhLjNyYS2Szeady+LzEehgdadb9x7/yGKR2mK+Yv6WxbOvQpawUNKJbC8dsLXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=q6RWam+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76133C116B1;
	Wed, 31 Jul 2024 23:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722469704;
	bh=/IIaZdmYNOt4xk2a7EyuaHC4cDYJRlszzg+xMZxGdpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q6RWam+/TIoT+yhWHSD4A7t9yMd/ceP7lTrzPzAUy+DJC9L3/UsUqAKkQfhz6VyZT
	 RopuopQ7N1o0+WyoLTeWh0D2lmyTGclYl9+WlZbdpczR03a9iYY/QjNW6Jh52bAOCO
	 iTav0yOEdQjyg+r1kP67nYY2wG17RkSf9dMiPt1M=
Date: Wed, 31 Jul 2024 16:48:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, "J. R. Okajima"
 <hooanon05g@gmail.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] lockdep: upper limit LOCKDEP_CHAINS_BITS
Message-Id: <20240731164823.c8ac96ab0f8968ce8213c02d@linux-foundation.org>
In-Reply-To: <20240723164018.2489615-1-cmllamas@google.com>
References: <11faf952-c0f8-6e1d-3560-12d77847a8ac@i-love.sakura.ne.jp>
	<20240723164018.2489615-1-cmllamas@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jul 2024 16:40:17 +0000 Carlos Llamas <cmllamas@google.com> wrote:

> From: "J. R. Okajima" <hooanon05g@gmail.com>
> 
> CONFIG_LOCKDEP_CHAINS_BITS value decides the size of chain_hlocks[] in
> kernel/locking/lockdep.c, and it is checked by add_chain_cache() with
>     BUILD_BUG_ON((1UL << 24) <= ARRAY_SIZE(chain_hlocks));
> This patch is just to silence BUILD_BUG_ON().
> 
> ...
>
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1515,7 +1515,7 @@ config LOCKDEP_BITS
>  config LOCKDEP_CHAINS_BITS
>  	int "Bitsize for MAX_LOCKDEP_CHAINS"
>  	depends on LOCKDEP && !LOCKDEP_SMALL
> -	range 10 30
> +	range 10 21
>  	default 16
>  	help
>  	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAINS too low!" message.

checking your homework...

With LOCKDEP_CHAINS_BITS == 21:

	#define MAX_LOCKDEP_CHAINS_BITS CONFIG_LOCKDEP_CHAINS_BITS

		gives MAX_LOCKDEP_CHAINS_BITS == 21

	#define MAX_LOCKDEP_CHAINS      (1UL << MAX_LOCKDEP_CHAINS_BITS)

		gives MAX_LOCKDEP_CHAINS == (1UL << 21)

	#define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)

		gives MAX_LOCKDEP_CHAIN_HLOCKS = 5 * (1UL << 21)

	static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];

		gives ARRAY_SIZE(chain_hlocks) == 5 * (1UL << 21)

so

	BUILD_BUG_ON((1UL << 24) <= ARRAY_SIZE(chain_hlocks));
	ie, BUILD_BUG_ON((1UL << 24) <= 5 * (1UL << 21));

is OK, whereas

	BUILD_BUG_ON((1UL << 24) <= 5 * (1UL << 22));

will bug out.  So LGTM, I'll add it to mm.git.


btw, the help text "Bitsize for MAX_LOCKDEP_CHAINS" is odd.  What's a
bitsize?  Maybe "bit shift count for..." or such.



