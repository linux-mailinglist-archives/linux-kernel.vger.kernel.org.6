Return-Path: <linux-kernel+bounces-528964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EDBA41E77
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5043416C386
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA922571AF;
	Mon, 24 Feb 2025 12:04:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0157194A44
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398663; cv=none; b=n6vnGBG3pc/n+jeUnjfN4VTTtrGA2ofniUaEk0xIZAzuCFEyATDS6Fh+R77ThxgQtVDQLT03EWJJ+KlbsZr8SKqGAxV8q/nroQcUzV/BfJqUgXAm9YWn5fPOE/aP0leJCmyl8SaQAOM5asqUh6XYjg5Iud7BIBdF9xqZd7X+Rlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398663; c=relaxed/simple;
	bh=exjiSLOgk+mEzhOvTz8LyReRlc0vRnbs1cgqAleNrkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5SI/9fXVfIQRXfOW/1PZUvw37mn0pSqIL2NZogJnv/sVEAP5zh/1/fJyywnhlO311uMg40oMWPGwFIMcPE3rwwrPdSLwqGBsHIDMNpnua48kTzrjbg/LqdU81CYYGFdKPZKq9kQU6ETTeukAhc63PGaTf5iSNpc0Wk6tTVTd5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFB9C4CEE8;
	Mon, 24 Feb 2025 12:04:20 +0000 (UTC)
Date: Mon, 24 Feb 2025 12:04:18 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/14] mm/vmalloc: Warn on improper use of
 vunmap_range()
Message-ID: <Z7xgQr7_xivV849V@arm.com>
References: <20250217140809.1702789-1-ryan.roberts@arm.com>
 <20250217140809.1702789-9-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217140809.1702789-9-ryan.roberts@arm.com>

On Mon, Feb 17, 2025 at 02:08:00PM +0000, Ryan Roberts wrote:
> A call to vmalloc_huge() may cause memory blocks to be mapped at pmd or
> pud level. But it is possible to subsequently call vunmap_range() on a
> sub-range of the mapped memory, which partially overlaps a pmd or pud.
> In this case, vmalloc unmaps the entire pmd or pud so that the
> no-overlapping portion is also unmapped. Clearly that would have a bad
> outcome, but it's not something that any callers do today as far as I
> can tell. So I guess it's just expected that callers will not do this.
> 
> However, it would be useful to know if this happened in future; let's
> add a warning to cover the eventuality.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

