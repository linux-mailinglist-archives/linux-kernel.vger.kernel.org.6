Return-Path: <linux-kernel+bounces-392643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F449B969F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6785FB20CBA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53EC1CC8B3;
	Fri,  1 Nov 2024 17:35:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6FB1CC178
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482541; cv=none; b=YgS8ygAhCyaW915tfT65HavjB9ozRGEtdGoQ9KhoVGmb7bD5yppXOBaw7pcyWIuuYPQA44PoJD5r2ReO0wicWtN+IdJJbpnln3nHCjzV99s3+aWvXstzGd8HAATzDAdCvLkrILC/DypvTkH3wACY59O7mtedcYBMKcw7ym5n1s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482541; c=relaxed/simple;
	bh=UHGqxrNqpII4jQb45jjWOpwKjNRgS5RSbbLahYfLcaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KS8Aem9hmBfc943SHm4y3cN0Di2ZVYHJyRfeXQ8z1+mnIVvhlDwNWQsTfkEeXmG9f2/lmiObWogJ2qelbtHy01xcFlNwdCPykrdgiSC4nW0k7cbFaj2GLhiRpjGCNUnMnU2dy/mb+NKZwQ2vh5rADrVoPQ+js3V//pZxdgUXPKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5A4C4CED2;
	Fri,  1 Nov 2024 17:35:39 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Re-organize arch_make_huge_pte()
Date: Fri,  1 Nov 2024 17:35:37 +0000
Message-Id: <173048223682.1108539.16990086073905192650.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029044529.2624785-1-anshuman.khandual@arm.com>
References: <20241029044529.2624785-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 29 Oct 2024 10:15:29 +0530, Anshuman Khandual wrote:
> Core HugeTLB defines a fallback definition for arch_make_huge_pte(), which
> calls platform provided pte_mkhuge(). But if any platform already provides
> an override for arch_make_huge_pte(), then it does not need to provide the
> helper pte_mkhuge().
> 
> arm64 override for arch_make_huge_pte() calls pte_mkhuge() internally, thus
> creating an impression, that both of these callbacks are being used in core
> HugeTLB and hence required to be defined. This drops off pte_mkhuge() which
> was never required to begin with as there could not be any section mappings
> at the PTE level. Re-organize arch_make_huge_pte() based on requested page
> size and create the entry for the applicable page table level as needed. It
> also removes a redundancy of clearing PTE_TABLE_BIT bit followed by setting
> both PTE_TABLE_BIT and PTE_VALID bits (via PTE_TYPE_MASK) in the pte, while
> creating CONT_PTE_SIZE size entries.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: Re-organize arch_make_huge_pte()
      https://git.kernel.org/arm64/c/f8192813dcbe

I think we can now get pte_mkcont() to only set PTE_CONT without
touching PTE_TYPE_PAGE. Previously it wasn't possible because
pte_mkhuge() was clearing the PTE_TABLE_BIT and we added it back via
pte_mkcont(). Give it a try and send an additional patch cleaning up
pte_mkcont() if this works. Thanks.

-- 
Catalin


