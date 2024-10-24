Return-Path: <linux-kernel+bounces-380534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 370D29AF1D0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DF11F23A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEE6218D78;
	Thu, 24 Oct 2024 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4iVuj03"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4729F21730E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796945; cv=none; b=kbhq4rSb2rKy1BTpUoQiZZz38vVyqVsJG0jICho+kDS6vLu4bMu2xsWQJDYEyfI+f292K0+qMEM0zqaOxgbgfOmxdFiA2qYp+lcN7ayQGmhdreAUVJgl5J2aqxvQPw9bj3H5oBaw6olS6rtHAoEYytaSloy6EjmlrQWOnoowduw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796945; c=relaxed/simple;
	bh=2eA9EOl3HC9/GnzLC7POscomQwnN5i9LKrBbdl1GkII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVCyFIV1FR6oR92kfN0ywP39XU85EP6524LwJLYGPuH8uBCyUwdE2886vPO0doO8V60mxU9rUb7jXjOIg9xxfzW2cHDCeOpwhCx6MKEP/2at+RCsG6LfQ+ijXXfxElJmM726oOKDxNPbVpeU2N7w4WOfXLy1qjH9GgL/0rc28q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4iVuj03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAF0C4CEC7;
	Thu, 24 Oct 2024 19:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729796944;
	bh=2eA9EOl3HC9/GnzLC7POscomQwnN5i9LKrBbdl1GkII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4iVuj03Sfl8R0t80flJPI8fUKTTsseDJbwPscuW9LSMtWAE1Au4hYlWfVu9xIeXl
	 uEB6RizCcEeOKzYE7qMVmBtnLbnfZYDNiBZCVaGz5/+8aCDwUPviDtXCOVbBlTxdnf
	 xWnY18d8e9Y/Y7ZzInq11gOaBS3+0/xw0O3xdeVTve6kQsj0AniTSM2IgSqoOIDk4Q
	 5qjKrzPBE+sJuPe/UTU5Mtrna99lWx1lVMdELwmxKjXJ2oUrP1snnvn7Xx8Jz8dTRx
	 co72Tu7n5LrRX125k/yNLdI1RMIxsspDESynsGIcH94X9TTl4dw7KAeYWWIS6ZaAHr
	 y/VPLYj+oLVBQ==
Date: Thu, 24 Oct 2024 12:09:03 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH] x86: fix user address masking non-canonical speculation
 issue
Message-ID: <20241024190903.qlmfegs4y7rxl6q5@treble.attlocal.net>
References: <20241024013214.129639-1-torvalds@linux-foundation.org>
 <20241024110822.GBZxoqppmxp0xxG7ew@fat_crate.local>
 <CAHk-=wgynHGhG9dzwRdySJSHZTOCp9jBHChomEF-mERJmsUeQg@mail.gmail.com>
 <CAHk-=wjBkvHNTy3orkjw=2GH25S4MSFWesSjni2zZNW2+gjomg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjBkvHNTy3orkjw=2GH25S4MSFWesSjni2zZNW2+gjomg@mail.gmail.com>

On Thu, Oct 24, 2024 at 11:13:35AM -0700, Linus Torvalds wrote:
> It does result in a few more casts on the C side, since you can't just
> do bitwise 'or' on a pointer, but I think it's still the right thing
> to do. So that thing becomes
> 
>   static inline void __user *mask_user_address(const void __user *ptr)
>   {
>         unsigned long mask;
>         asm("cmp %1,%0\n\t"
>             "sbb %0,%0"
>                 :"=r" (mask)
>                 :"r" (ptr),
>                  "0" (runtime_const_ptr(USER_PTR_MAX)));
>         return (__force void __user *)(mask | (__force unsigned long)ptr);
>   }

On a non-related note, doesn't the inline asm need a "cc" clobber?

-- 
Josh

