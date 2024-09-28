Return-Path: <linux-kernel+bounces-342304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83702988D6E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 03:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C87282D77
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 01:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BC5168BD;
	Sat, 28 Sep 2024 01:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SezEUUz1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C55423AB
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 01:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727487459; cv=none; b=aOtBrz8cY7H5abKdkkoePU5f3LZWBgfbIEpdxwfKULyiJ4qlO+kgWLYku+gDrZu5IULmhWPD1Q6PsJ0VIqD1Kd5FB8VDAaRuu+dCvhaCBe+TfVeiiSar1b+whRoO3HAxl16VJr/VUvrWNUftpRO9PjXU9DtxB74guPppoqFonuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727487459; c=relaxed/simple;
	bh=W1G77aO3c76YZyaQbIFBe+olH2So8C8JcupDO25niHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjWEHg4qzqKcgo1EfEnM2CLixHhjKCivRXGsOQghMcFIrK9DUcd7v29Pzr5abeW+kY90hzt5SEcfdwgCj3APL8CzGZNgzBXACtWel2krFlfAeGLadYdaY7OAmK3j0BBzFvuMkfNVf8wxE/qYSWYM/zkNT2U74i9mKJxljLGVm3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SezEUUz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35ACC4CEC4;
	Sat, 28 Sep 2024 01:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727487458;
	bh=W1G77aO3c76YZyaQbIFBe+olH2So8C8JcupDO25niHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SezEUUz17aJZWnVRXuXZ5KcnD2XEq3fYc7Z4W9KhF0uv+28ZsfLSu3Krl78KYVGkw
	 O+rWVWogkj6vFQ0VIN1dRgOFM48svrM9G0m572EqUpreMgcB0W7Ie0OoMlCBYNYFkt
	 Sya0ZiSw042EMlmpimzg0x6ZF0vg1ZB9PTOEAy5one14b7QAUoVU9kLRH2z62iD0LE
	 5hBMM9qwHCGgZtwKjGUb+IAkTCgbZV63Nj/o0/cduH4oB2+r4QplmG5q3BiUBhdv0C
	 v18IMv1+0JlphogNsl+Mot2wSDdNVU3BrB/cXHMrFFi6oQ3H1p22F5uC/+qvOUL0gn
	 cTxLveFdEaoSA==
Date: Fri, 27 Sep 2024 18:37:36 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jose.marchesi@oracle.com,
	hjl.tools@gmail.com, ndesaulniers@google.com,
	samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
	kees@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH 13/14] x86: BHI stubs
Message-ID: <20240928013736.tirg3rivjf2nb3am@treble>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.707462984@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240927194925.707462984@infradead.org>

On Fri, Sep 27, 2024 at 09:49:09PM +0200, Peter Zijlstra wrote:
> +static void *bhi_args_1(u8 args, void *addr)
> +{
> +	u8 bytes[5];
> +
> +	for (int i = 0; i < 6; i++) {
> +		if (args != BIT(i))
> +			continue;
> +
> +		bytes[0] = 0x2e;
> +		memcpy(&bytes[1], &__bhi_args_6c1[i], 4);
> +
> +		text_poke_early(addr, bytes, 5);
> +
> +		return NULL;

I assume there's some good reason this doesn't return a pointer to the
code like the others?

-- 
Josh

