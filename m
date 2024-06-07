Return-Path: <linux-kernel+bounces-205420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8261A8FFB51
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D61D1C25644
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 05:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FCD1BDCD;
	Fri,  7 Jun 2024 05:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oxGPd9+w"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B93D38D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 05:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717738291; cv=none; b=Dh+xLKYL0kkdvqdb6aESPy+TY5m7UoBA1xAxgauhyPyMk1F9OnhBD+cepfPKEMo7jKaOLvFG4wC5XhMcagCqz2I+uTlsHQu2UX6Ix+6Fr5duAGmCntr2Z8nKxyMkQU5ok1/PRmYg+ahVeM7RSs5AiXHAjwdQxOX82YgThyfxYVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717738291; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ef3QG4GYARO3JHFUCh9XxsGC2uBmjcL1Kr1AtgLJOqrau55QxkcDeL+rMRXVLUcfoQUzOg7gGlKEu3q4iDBVSbwuuB66yCLoqlskqOlkh2yJC3eStZdhVzRcAH0Zm1an2z1JRsViA/tCNjUiWekZg0XQnkG6GdbJr3BoZ98Tlwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oxGPd9+w; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=oxGPd9+wNHyPhJ+IYvWhU+Unw5
	X3xEB2KRRTdpaBXFBXYqQn9v+B+hBFXdZ7H/Fk8GeE+QCEzdNLiLuEOaYsbrm4jBthQRHw4O30gzZ
	SlHnRLLkrI4BRDE2+7MM75TEKdiRT1+OKlsFoplHCmRlUUG842IExQ3B5IfYQMjpndVnTjsNeMMpD
	gLOPrgXV3dA8BGguVP+KqjEKNZyt/gO2doLmzFsBaBEOPDGkx8KaHMgf/JXXZ6IbB+7JjGxGa2F1s
	vWYTiL/LosXDNDDf4UqMLIeZzb1ke8/ru3ITvjJMGxD39lCCkFlTsjoHfAnpnBfKKGEK9lNqzdJej
	6c69Nixw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFSCF-0000000CUNZ-1SRn;
	Fri, 07 Jun 2024 05:31:27 +0000
Date: Thu, 6 Jun 2024 22:31:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: swap: remove 'synchronous' argument to
 swap_read_folio()
Message-ID: <ZmKbLyf8oy9drsJr@infradead.org>
References: <20240607045515.1836558-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607045515.1836558-1-yosryahmed@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

