Return-Path: <linux-kernel+bounces-315523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB51396C3A4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BF2284D92
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22021E1332;
	Wed,  4 Sep 2024 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7FZxUNF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540651E131E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466374; cv=none; b=cX78Py1si/RcXk7Y0AOS0SmYM3Za713Mb/KkAnmVPhOvh4+8BYSzzrcq56IoQHqNfs2M4jyKGsOIR4gvFFu7idOsfxGoXpuvdzCiUZcs+JXsynnUmlpqyIqbtW0RaJT9uubihxgvbIGn66U0sN4clqOztHRm2EegDCQFQpNdCfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466374; c=relaxed/simple;
	bh=OOYRH+ne+irSS/IueC8R3UOX+QaiCSctU7aSngmqbIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MhIa5QgKgndTHqfaI3kYGdxcAg8lzScE0rVFMOo84Mx5r/P6TZ8tkQDB+qeldglif7qbFKQbf+yP5TnRW9AIge/El8a/QE0ILU2nszLm7MVHnqYmvki/UF6IhGdpyjPQzuUuCQ2hVszHmNoQ1xkcAYx9Ebba0y0mwD26E1qi9ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7FZxUNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAA6C4CECD;
	Wed,  4 Sep 2024 16:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725466373;
	bh=OOYRH+ne+irSS/IueC8R3UOX+QaiCSctU7aSngmqbIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r7FZxUNFeh/uGB4eIgf9RRuB4uGc9WtHxOQ/7UenO3J2/FuqDnHu+ppZPs2dYaRUl
	 5ODhNubmm2nzXQurfFqj9MNQMSuyM/II9EBk8hzJuF9US/U/6eCAQJoumT5Uqh7Wu5
	 pPUM+IxJBC7D5HnN8ZBBWeBtVMgU6ISPnehaanHkC/vvuJ3PhUo6cM7HZtPS69Cywh
	 Vbcn1sawg63YzqK2tKV0WfW0cQMh8ph5kMI/41FfHmJbYHxwBCGJqxhu8QsOtOb2mM
	 XXBcqb8tj+AfGnmi8JM1s5h7h9CTcHAqq6ghmpBs1fm/iOcGOnxz01hTEKm5VL4Om1
	 F/dgpAs3UOhWw==
From: Will Deacon <will@kernel.org>
To: Catalin M arinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	D Scott Phillips <scott@os.amperecomputing.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Baoquan He <bhe@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wang Jinchao <wangjinchao@xfusion.com>,
	linux-kernel@vger.kernel.org,
	patches@amperecomputing.com
Subject: Re: [PATCH v3] arm64: Expose the end of the linear map in PHYSMEM_END
Date: Wed,  4 Sep 2024 17:12:36 +0100
Message-Id: <172546436035.2663988.13656024915203929376.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240903164532.3874988-1-scott@os.amperecomputing.com>
References: <20240903164532.3874988-1-scott@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 03 Sep 2024 09:45:32 -0700, D Scott Phillips wrote:
> The memory hot-plug and resource management code needs to know the
> largest address which can fit in the linear map, so set
> PHYSMEM_END for that purpose.
> 
> This fixes a crash[1] at boot when amdgpu tries to create
> DEVICE_PRIVATE_MEMORY and is given a physical address by the
> resource management code which is outside the range which can have
> a `struct page`
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

I dropped the cc: stable, however, as PHYSMEM_END looks like it only
exists in linux-next.

[1/1] arm64: Expose the end of the linear map in PHYSMEM_END
      https://git.kernel.org/arm64/c/eeb8fdfcf090

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

