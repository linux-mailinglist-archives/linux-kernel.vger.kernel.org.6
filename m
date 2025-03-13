Return-Path: <linux-kernel+bounces-560477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25FCA6051B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 819837ADBEE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D50B1F8ADF;
	Thu, 13 Mar 2025 23:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="r1LbO++h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767D018DB0B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741907440; cv=none; b=n5BNu2HwTxurl8ggzT1TgI/YdzHpim09EqgBfSCd7v8zx4fPCYczHHOGQGH1mwra3mH9fJCrCoEt0bWRx1VvdDpSg9zLtyCuCiCi8iLUQtdZv1X56LmlLSpFQroaXGbe4Kdnlpsx++gzZiHGuuRN1Gz2HqcfkvABAyZFFAJoXDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741907440; c=relaxed/simple;
	bh=85C5EaLBPcNm+VfXMxlgckNkHScFkxqfwrT4hbCXaS0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mZvSSmbXRwfxEwyi3fKC/1c0humDSN6raofBKZlcV2nGyQyi3Mcs8/DCbg4zu3XyjpnPK2rxqtbnS9zsw1Do9fIX67H+r/EPWm06CcPIqdUM+9Sd6//sAYk9BOuQOtNf6ntSyYY0c1c5/fttDKoHHtuMvMilOFuNukcpBsXwt7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=r1LbO++h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839ACC4CEDD;
	Thu, 13 Mar 2025 23:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741907439;
	bh=85C5EaLBPcNm+VfXMxlgckNkHScFkxqfwrT4hbCXaS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r1LbO++h2zt9ITOCp8zaBNp5bCW3oO8IYrW9fm3oZilRLz2OfzDBHOVialXmivLvD
	 bsPejXMhoq8EeEH1UfZGgQO5BcyfMZ6opeDWAKOUunCcWeso9WZv2uAjmotrBYRJrB
	 wRsd1Lld8tuszHDkPkn9GPUZwcBYsR4A0hlP64N8=
Date: Thu, 13 Mar 2025 16:10:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrew Donnellan <ajd@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com,
 sweettea-kernel@dorminy.me
Subject: Re: [PATCH v13 04/11] mm/page_table_check: Reinstate address
 parameter in [__]page_table_check_pud_clear()
Message-Id: <20250313161038.8bd10fa54778e984d8f849d7@linux-foundation.org>
In-Reply-To: <20250211161404.850215-5-ajd@linux.ibm.com>
References: <20250211161404.850215-1-ajd@linux.ibm.com>
	<20250211161404.850215-5-ajd@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 03:13:57 +1100 Andrew Donnellan <ajd@linux.ibm.com> wrote:

> This reverts commit 931c38e16499 ("mm/page_table_check: remove unused
> parameter in [__]page_table_check_pud_clear").
> 
> Reinstate previously unused parameters for the purpose of supporting
> powerpc platforms, as many do not encode user/kernel ownership of the
> page in the pte, but instead in the address of the access.

My x86-64 allmodconfig exploded.

./arch/x86/include/asm/pgtable.h: In function 'pudp_establish':
./arch/x86/include/asm/pgtable.h:1443:46: error: passing argument 2 of 'page_table_check_pud_set' makes integer from pointer without a cast [-Werror=int-conversion]
 1443 |         page_table_check_pud_set(vma->vm_mm, pudp, pud);
      |                                              ^~~~
      |                                              |
      |                                              pud_t *



#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
static inline pud_t pudp_establish(struct vm_area_struct *vma,
                unsigned long address, pud_t *pudp, pud_t pud)
{
	page_table_check_pud_set(vma->vm_mm, pudp, pud);
	...

