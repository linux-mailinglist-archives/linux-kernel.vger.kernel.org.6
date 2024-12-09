Return-Path: <linux-kernel+bounces-437648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11B69E9671
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A862B282CEE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859273594F;
	Mon,  9 Dec 2024 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyTWFuub"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2C035944
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749850; cv=none; b=hoJX4Gxo76Rm5etPdKKlfnvJRvfIzIpqGg9daRHgGYCg2FQf2oD0rV1lYkiq3ORGJUPgKLoiM4hiUI/1OK077P4EccEU7WD7RI6YYqWAWs94iEcEby5xfJNNv54iWN5J6M1OL4jCaRZBXzgV3UKzep+LSBe0Dt/Ud4jVzH4rAtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749850; c=relaxed/simple;
	bh=55YEyJVUZ+5Y5/XJDnP+9mjqMg06KWMzQ0/tsjFl5RA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ehs0n1ultM2w2EPzKMV9G975w3PEOYtv+i9TxS5oxx/QE0TWzBZu8/Bp9zTXsx0KovP+uxKtT7iyQYjdoKchr8ZSNRBULrNddleJ+CB/bgqG/FXjeZJ4JEsyaxa+xk1EQ9lbTRVyKc7qKgQYFlvW442sTIrT0+ZftuNKaMOGI8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyTWFuub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05009C4CEDD;
	Mon,  9 Dec 2024 13:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733749850;
	bh=55YEyJVUZ+5Y5/XJDnP+9mjqMg06KWMzQ0/tsjFl5RA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IyTWFuubcBBCb+QXnGxAImTSR05A0ZNLKM83An0ajlmcmkVvzIvSkdTzA7bAGtC6F
	 98/aZVXpWXGAjsNsqULzKfRZEDG3X9dC9Tq2zK/S/nMxh8nCuQlqwGd1H8o7uoZZdP
	 GZ2CHPCGEhlq0qvgY5yo79DXeJotErG9vt+N/zyBKy3T24gVVfOkRWnYCi3XPjdjad
	 TNGOGgNv2Y5TyFMJz+WFqfA74IohmTCK+o6d5GKJZLGDVZbYPzc3dTzxmbz8vGfxf/
	 RC/i9X+vLtNEVu0yYnrtuopyEOWJwvNbT8C7tw0m0BbID/0uHpjMStJbzEOeDMhvWm
	 j/e3+dODuBACA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Xu Lu <luxu.kernel@bytedance.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, alexghiti@rivosinc.com, bjorn@rivosinc.com
Cc: lihangjing@bytedance.com, xieyongji@bytedance.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Xu Lu
 <luxu.kernel@bytedance.com>
Subject: Re: [PATCH v4] riscv: mm: Fix the out of bound issue of vmemmap
 address
In-Reply-To: <20241209122617.53341-1-luxu.kernel@bytedance.com>
References: <20241209122617.53341-1-luxu.kernel@bytedance.com>
Date: Mon, 09 Dec 2024 14:10:47 +0100
Message-ID: <87r06h3stk.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Xu Lu <luxu.kernel@bytedance.com> writes:

> In sparse vmemmap model, the virtual address of vmemmap is calculated as:
> ((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT)).
> And the struct page's va can be calculated with an offset:
> (vmemmap + (pfn)).
>
> However, when initializing struct pages, kernel actually starts from the
> first page from the same section that phys_ram_base belongs to. If the
> first page's physical address is not (phys_ram_base >> PAGE_SHIFT), then
> we get an va below VMEMMAP_START when calculating va for it's struct page.
>
> For example, if phys_ram_base starts from 0x82000000 with pfn 0x82000, the
> first page in the same section is actually pfn 0x80000. During
> init_unavailable_range(), we will initialize struct page for pfn 0x80000
> with virtual address ((struct page *)VMEMMAP_START - 0x2000), which is
> below VMEMMAP_START as well as PCI_IO_END.
>
> This commit fixes this bug by introducing a new variable
> 'vmemmap_start_pfn' which is aligned with memory section size and using
> it to calculate vmemmap address instead of phys_ram_base.
>
> Fixes: a11dd49dcb93 ("riscv: Sparse-Memory/vmemmap out-of-bounds fix")
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>

Verified that the kernel is not trying to access vmemmap/struct pages
below VMEMMAP_START.

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

