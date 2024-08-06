Return-Path: <linux-kernel+bounces-276612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B14E949605
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E7E1F229FD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1750F487BF;
	Tue,  6 Aug 2024 16:59:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44644C81;
	Tue,  6 Aug 2024 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963566; cv=none; b=j86Uz3URVDbIuhLqCGD3bvpDFALuzi44tQFLmLtmrfzBER4UtcqV27XKrPcVs625t+LO1trZuuZoO+Fn/SvF19kKFTdFQB1M5rHNJ1sjNBQEzYAQPHWpvPPnFSq7RLUfbDX9BC4PppVIgzJsf/iHKmKBmNqWKY+V3LGADOpWbD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963566; c=relaxed/simple;
	bh=txm31E3ifUBqVKlsk6u4OqrlgjGSh72ZVE4tmxXc8b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfFt9mGHzJZYGNqyCSQ2PEgoJmWvJxocathAHJvoJ4pvnPmyup4tk7nUKbc/uADKYFwlvKZ8Lxopy7TFWxA/mzB7UC/4ZGEyLcd3/EI6Qn21FhN/BuPFhqjfgpR1VlK2zyZu2sZdGCtUIJeE9W+j7zdB/t8pda6qlRaOUebNJ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80584C32786;
	Tue,  6 Aug 2024 16:59:24 +0000 (UTC)
Date: Tue, 6 Aug 2024 17:59:22 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: will@kernel.org, corbet@lwn.net, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH -next] arm64/kdump: Update the high memory reserve doc
Message-ID: <ZrJWarQnhFiM-e17@arm.com>
References: <20240806113320.2388386-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806113320.2388386-1-ruanjinjie@huawei.com>

On Tue, Aug 06, 2024 at 07:33:20PM +0800, Jinjie Ruan wrote:
> Since commit 282c3a66b724 ("crash: Fix riscv64 crash memory reserve dead
> loop"), if reservation from the high memory failed on ARM64, the kernel
> will not falls back to searching the low memory, so remove it in the doc.

This commit doesn't exist in -next. I found it with a different hash but
don't add it in the commit log here.

> diff --git a/Documentation/arch/arm64/kdump.rst b/Documentation/arch/arm64/kdump.rst
> index 56a89f45df28..11b9b84bf422 100644
> --- a/Documentation/arch/arm64/kdump.rst
> +++ b/Documentation/arch/arm64/kdump.rst
> @@ -79,10 +79,6 @@ To reserve memory for crashkernel=size,high, searching is first
>  attempted from the high memory region. If the reservation succeeds, the
>  low memory reservation will be done subsequently.
>  
> -If reservation from the high memory failed, the kernel falls back to
> -searching the low memory with the specified size in crashkernel=,high.
> -If it succeeds, no further reservation for low memory is needed.

I recall long discussions over a year ago where the conclusion was that
for sysadmins it's easier to have crashkernel=,high the default with
fallback to lowmem. No need to worry about how much low or high memory
there is on a SoC, just specify a preference for high memory.

Can we not have a different fix for the infinite loop problem while we
preserve the fallback behaviour?

-- 
Catalin

