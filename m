Return-Path: <linux-kernel+bounces-173540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B238C01F3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2045CB215DA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A1812A16C;
	Wed,  8 May 2024 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jT+7B2za"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0AE128803
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715185677; cv=none; b=auwUYGRpwUz6Y0KCWWlRIiDmXCPyzgq1r4oApbGdsa+H1B6GniN71azZHExYDmxclCLtOVyaBw6Wh/ajvDb48UFW1dm87pCM5AlL4x34WrMPRwld4i/TQU04gOaBWSlXmLIdPk+SKndXR+IlQh/pCCzj+dtbA94e+f5OgCxtxlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715185677; c=relaxed/simple;
	bh=L1QBFOlO/NdA1MFpDgz4XHe5aYdivtT6EbOIH6mGJfk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rBYBmB1ZFhPyqHnSF/bCam5HnBzE5iI9ApwqDDhaCRFPObmDfCHMzd6V5C4Ak62YsZ9nBI4Yv0Ls8hm6l3pft6Xsxu0XgXq+5OiBRLLlMc22bGKMam5qV9MOLZ+2Xip9aJsNXiRgN1dWe6lR3Peq0bWDTHRvy+18Mp5o8HRdrxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jT+7B2za; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B24C113CC;
	Wed,  8 May 2024 16:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1715185677;
	bh=L1QBFOlO/NdA1MFpDgz4XHe5aYdivtT6EbOIH6mGJfk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jT+7B2zaE1gDYONCDwX6NLuwtxU+sqrhKVQbk5C5m1cVZ/1fHqzqACKx4DGzHUTrH
	 3p8JAG1FryLJQWyCTCMWxKb6xyrhyKkVFKzE6arQ0qph+v/cQgwDI9ULN+FoL/ebTP
	 XjUroUnyFQcZ/JlRUw6gi9vr+CfBF8+2XNpOrOBI=
Date: Wed, 8 May 2024 09:27:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland
 <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/9] Merge arm64/riscv hugetlbfs contpte support
Message-Id: <20240508092756.58fba60e4b6ce0986e8f5f73@linux-foundation.org>
In-Reply-To: <20240508111829.16891-1-alexghiti@rivosinc.com>
References: <20240508111829.16891-1-alexghiti@rivosinc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 May 2024 13:18:20 +0200 Alexandre Ghiti <alexghiti@rivosinc.com> wrote:

> This patchset intends to merge the contiguous ptes hugetlbfs implementation
> of arm64 and riscv.
> 
> ...
> 
>  arch/arm64/Kconfig                  |   1 +
>  arch/arm64/include/asm/pgtable.h    |  56 +++++-
>  arch/arm64/mm/hugetlbpage.c         | 291 +---------------------------
>  arch/riscv/Kconfig                  |   1 +
>  arch/riscv/include/asm/hugetlb.h    |   2 +-
>  arch/riscv/include/asm/pgtable-64.h |  11 ++
>  arch/riscv/include/asm/pgtable.h    | 153 +++++++++++++--
>  arch/riscv/mm/hugetlbpage.c         | 227 ----------------------
>  arch/riscv/mm/pgtable.c             |   6 +-
>  mm/Kconfig                          |   3 +
>  mm/Makefile                         |   1 +
>  mm/contpte.c                        | 272 ++++++++++++++++++++++++++
>  12 files changed, 480 insertions(+), 544 deletions(-)
>  create mode 100644 mm/contpte.c

Hits three subsystems, so I guess mm.git is the place.  I'll await
reviewer/tester input and let's look at getting this into mm.git after
6.10-rc1?

