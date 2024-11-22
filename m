Return-Path: <linux-kernel+bounces-418526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0189D62A5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E8DFB25228
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B64213B797;
	Fri, 22 Nov 2024 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2SnwCtA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D66A2D638
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732294556; cv=none; b=n3hjFrZ3n4x/fNTtW/3uE0D0d895PlYiqHnkYCu/e7JBmS6DU4uTUvquB0c7YoX1DzqJsJz89cQcNfCpoxoeLnzu/WuQ3U6x4SeJSll2j8bbi0tnFrrFBeNXBPLrV/elsrIA2kiFpZdMoNKRK258TuSJFfuEEVgjFfK8Pq8EeRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732294556; c=relaxed/simple;
	bh=SREq5ZsQNr8ELKFE1tVRPRvrvq2fB9uRtcLKi+GRgoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iger6qQxVcdRK5rnDCCW4IJS7nSLwUj9PXWCT8HU84j+1kcahEusmgyJ3yZtqpmLLYieWSqZEKM5RQ6RcpOBHEKlsWVr8XzIJ6R/4uSb7Cnrj6p6EJLWCto7MHNF6e/OZccM5c/hM54DfZ7TuK+bGLGlYDWrNr0R5pmxTKjS+OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2SnwCtA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6FAC4CED0;
	Fri, 22 Nov 2024 16:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732294556;
	bh=SREq5ZsQNr8ELKFE1tVRPRvrvq2fB9uRtcLKi+GRgoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n2SnwCtA7gLJ/DwObMCmiTQUFcgY2REdEaJUSav5ZdkPq+DpjzAGyhp+xrpcO0THu
	 PF+XA2RNxupy1ZKEylB4dtEzhgw9PiFqf2U6F8ldGzG0Iqwyhrg/Ln+RWjsBsoB3ys
	 dwZleXgd5EbYZkin+N+ybHO+AY+aLAxdb+jXs/hMLRSKxG6RY6m44muD9gdTL9DRQY
	 1RKZkmgPnGrwGYn9q0TrlU9OZRbsLnhSQYAufyt01Bt32kzEmqqfA85ieM6y+v8Ssp
	 QoZfW5PrhQ28kKDifk1mQpfB2vqfgfV5vnt9RN1uNuOlF1g0qJuSIk/wd6mCYXq/rf
	 0uU6VcRdNAOOA==
Date: Fri, 22 Nov 2024 17:55:52 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Borislav Petkov (AMD)" <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/boot: Get rid of linux/init.h include
Message-ID: <Z0C3mDCngAf7ErM2@gmail.com>
References: <20241122163139.GAZ0Cx63Ia9kgYgRIr@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122163139.GAZ0Cx63Ia9kgYgRIr@fat_crate.local>


* Borislav Petkov (AMD) <bp@alien8.de> wrote:

> 
> this is what I think we should do (just a first patch) to decouple the
> decompressor from kernel proper headers namespace so that there's no
> collisions and ugly ifdeffery when those kernel proper headers get shared.
> 
> And if we want to share things, we will use asm/shared/ to put such shared
> definitions there.
> 
> Thoughts?

Sounds good.


> --- a/arch/x86/boot/compressed/head_32.S
> +++ b/arch/x86/boot/compressed/head_32.S
> @@ -24,7 +24,6 @@
>   */
>  	.text
>  
> -#include <linux/init.h>
>  #include <linux/linkage.h>
>  #include <asm/segment.h>
>  #include <asm/page_types.h>
> @@ -32,6 +31,10 @@
>  #include <asm/asm-offsets.h>
>  #include <asm/bootparam.h>
>  
> +#ifdef KERNEL_PROPER_HEADER
> +#error Do not include kernel proper namespace headers
> +#endif

The canonical solution in such cases is to use the existing header 
guard, ie:

 #ifdef _LINUX_INIT_H
 # error Do not include kernel proper namespace headers
 #endif

Then we can skip defining KERNEL_PROPER_HEADER as well, and this change 
will be purely to x86 code.

Thanks,

	Ingo

