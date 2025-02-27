Return-Path: <linux-kernel+bounces-537121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACA3A48839
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945D416C64A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D7F26B2DA;
	Thu, 27 Feb 2025 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhUuAJsM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95A226BD92
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682242; cv=none; b=ZB7xNgnnR+6L+V4kBdazdeOO1ej9hWjuvo54jDKXD9E2BW23v51wPzYexTKRUfkPUvMbO6az0Br+jx60bx9ZJiZdSPLXtWbXIENZlL1pRtqgGrGVo4zWk7k0aGO9r074zecTXfgmRMh+2rRmV2owmERHfTikgRkLALUHWFp91mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682242; c=relaxed/simple;
	bh=11uRd/PwHiz7z8o9Mh2WCAHrRhiDeHVGyk7lTrv19SE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCw6ZRVf+eww+1Rlv/eCagnqQhHQ6+pFrlQu0wjqoiHBDID1mBayzqzaGWFBwlyEIkfNKa+hSgqBhMfufQebP0LEStg/4ynHxdoZlNqEfP8wZNIV4Y0VP+/J3KCYzpJIZAKdKc1k5VRFR3ceRnD05KhdOkVQC7YzJtbKqyi4q3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhUuAJsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A358EC4CEE5;
	Thu, 27 Feb 2025 18:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740682241;
	bh=11uRd/PwHiz7z8o9Mh2WCAHrRhiDeHVGyk7lTrv19SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uhUuAJsM1Rw0k7NFX05vRIoNGFUZuuDZoMkSNz8+BkYNh2LZZyXGXOM/wRi+ixU/v
	 gK+n1YqCmnHBw3Hs8KO+9RNifwKlBIX/vnUFpfRdV2r1XQKIdLmcjasRZs2SWIkQsN
	 /lcTqksiNaLZD5YEr6TcDM9I023ot9TKBvOdyWOk+vo2oC9bjfX/Z2gcRhyROsrFCv
	 glOu2bt09L2xuSdz+8sVMvTl38mihfBrV9R2ccvbpNB6KyUxw0xO72L0YPaGn4hTkS
	 5H1opyUk2ty3Ci2YDXCqUqssDSTaZVdFhn9Bu129hp60mSC3mwxP5UgChUTvLRliA7
	 3huzQdriFgFPQ==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Ryan Roberts <ryan.roberts@arm.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Fixes for hugetlb on arm64
Date: Thu, 27 Feb 2025 18:50:28 +0000
Message-Id: <174067805978.3571552.16163970723385377562.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250226120656.2400136-1-ryan.roberts@arm.com>
References: <20250226120656.2400136-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 26 Feb 2025 12:06:50 +0000, Ryan Roberts wrote:
> This series contains some fixes for hugetlb on arm64. It turns out that I will
> need to rework the companion performance improvement series a bit and as a
> result won't be relying on the purely mm fix that was patch 4 in v2. So I've
> dropped that patch and will send it to mm separately.
> 
> I think this should be ready for merge now.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/3] mm: hugetlb: Add huge page size param to huge_ptep_get_and_clear()
      https://git.kernel.org/arm64/c/02410ac72ac3
[2/3] arm64: hugetlb: Fix huge_ptep_get_and_clear() for non-present ptes
      https://git.kernel.org/arm64/c/49c87f767774
[3/3] arm64: hugetlb: Fix flush_hugetlb_tlb_range() invalidation level
      https://git.kernel.org/arm64/c/eed6bfa8b282

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

