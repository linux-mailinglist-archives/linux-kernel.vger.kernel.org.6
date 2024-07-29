Return-Path: <linux-kernel+bounces-265122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7A693ED01
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FAD61F21F5B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 05:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DB481AC6;
	Mon, 29 Jul 2024 05:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmNRIpR0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2CD64D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 05:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722231461; cv=none; b=PKbmTfFGnb8os4ljSzdWcw9+hOnuJcynHswNzvADzbhkbnGbI1K+csI8QEwE4RUz3p+8cls7zDwlOrPcM24dCaWo5+eq/dK1xcDNsv+k4kU0LmEHb3gZYdUEhtMuSkdq0UiP5MuKLmGNN1hjgatD9f2GTzU668EhRUBk+yedOpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722231461; c=relaxed/simple;
	bh=I5AyL0PIaSIryk035XCmbFKvN2GWmRrDu3BcdzLjeq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgxJvjv1k0+ci8BQkgHjw3eMKJCRNVzGQgC2m3BW0xYLY9VxU0+RhA3ffW6UdNeruNeXV9ROseMkWN7nnuRjQYH5JWLAPyr4P3rsJylc3Xoin/CPPW7ltCOVxFz+cE31Ws59hA39KejFTYVQ9EpjLACU83aAwsWSLWLdENVXJ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmNRIpR0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D93C32786;
	Mon, 29 Jul 2024 05:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722231460;
	bh=I5AyL0PIaSIryk035XCmbFKvN2GWmRrDu3BcdzLjeq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CmNRIpR0bbPCzvZtjzZUBZNzzLw19QAsIPcwTKiWUr6W5fANJwGVhU+XUMZFJa1Cz
	 oJ5031yoVuJd7QsqTR8dLPvSg3xz5sRbTkXve+WgakjTvVk0MFBIuXrQB0mJFn+32x
	 K1YIpQUB3LwSTa+gpXuvD2RMe6sX2TJNiRZIvpWItla2Skd6AXgarwuOum7CexEiGR
	 aWoWvMf9hRFLERKYn8GSWpVoMCaCSKBe7jdJN7bcpBjXkvNy8lH6OMkVF3o9a+qu9P
	 wa9PXoz4DWL554OL9iOFRvBFNUstd7J0dPkK8UhrxYysFpRkod0d8LRGGX4YaBz1d6
	 p9bUcHc7Nz9Sg==
Date: Mon, 29 Jul 2024 08:37:23 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/5] memblock test: fix implicit declaration of
 function 'virt_to_phys'
Message-ID: <Zqcqky8XdiQy3mO-@kernel.org>
References: <20240729014725.29839-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729014725.29839-1-richard.weiyang@gmail.com>

On Mon, Jul 29, 2024 at 01:47:21AM +0000, Wei Yang wrote:
> Commit 94ff46de4a73 ("memblock: Move late alloc warning down to phys
> alloc") introduce the usage of virt_to_phys(), which is not defined in
> memblock tests.
> 
> Define it in mm.h to fix the build error.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> 
> ---
> v2: move definition to mm.h
> ---
>  tools/include/linux/mm.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
> index cad4f2927983..9db45c5d00fc 100644
> --- a/tools/include/linux/mm.h
> +++ b/tools/include/linux/mm.h
> @@ -20,6 +20,8 @@
>  #define pfn_to_page(pfn) ((void *)((pfn) * PAGE_SIZE))
>  
>  #define phys_to_virt phys_to_virt
> +#define virt_to_phys(p) ((unsigned long)p)
> +

Please don't break #define of phys_to_virt from the static inline
implementation.

And please make virt_to_phys a static inline similarly to phys_to_virt.

>  static inline void *phys_to_virt(unsigned long address)
>  {
>  	return __va(address);
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.

