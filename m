Return-Path: <linux-kernel+bounces-549220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7444A54F23
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEDBF3B56CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BBA21171D;
	Thu,  6 Mar 2025 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sI6NcA05"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1658B22576A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741274816; cv=none; b=g8dV31OowAzecT79en/f1rykWkq7343RhEMtT8jd3rdzoFxzKAuzzHtSdmtOn/+2KOj3KEfsYQPKT2dfmhGyX3X7HhSY1wIzZaPXWX23UMLE4Z0IBvNnfGYJ2aIGGSCH2+ozMrpinB290Vhye6YNUhJl5oejr5wfuWpjIWZDOgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741274816; c=relaxed/simple;
	bh=nvJRaj+K8dARRU9iy0o2abF8QxEH+WyKBIUE7J+Q3P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4NGtG3ZzCh+2pszFH9tJgwX0GK5azxsyIpVCkUNx6/HwE1OQrjXc6ZiclwOcGb8yATwaYCmnmhazrWJYLeOTHiHm6GeyxjUUGZWYh74TKKV6xKHJRDOtuGPzKZ7/MDZqxNlna9Ct5DLJIsLbzq6jXOxXLmxnz0haBe8B8F6ThA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sI6NcA05; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5T9N2ceD22uhoxgQHNN1kfiGf/LRNSJbimPTyWXF3I8=; b=sI6NcA052+NV1hoDKNnd5OUSzY
	DQKXgRufvgJahYNPLuwWljgFcC94Ad05DdEN5UmzXxrIIMDTjXCLENcnnoXR0o91YQcvXkiZf23ff
	my9jo9Ixt48xbBFDQXZ4E2/5KN42U+nTY1+IbjPSVFq3HR5ctdBCTBRFy6CfrA3zedCOfgqIxq4bd
	NLQ1u2YZp+FPxanq8ElxF0Lrq7JAnR0b0D0fiVwYw/cmyIJ78urr09YUKQtc3PrLOFQHdiJpD8yFg
	Rpn+GkKvd5e3SBEs85Yw5smpf2p6ZVbhfZABiCKx3GoV/oM5zZsclzP/8vWrTuFPP4GywF9xAlybR
	Uk5O+8tQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqD7c-0000000BJhb-1v7n;
	Thu, 06 Mar 2025 15:26:52 +0000
Date: Thu, 6 Mar 2025 07:26:52 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Sooyong Suk <s.suk@samsung.com>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	jaewon31.kim@gmail.com, spssyr@gmail.com
Subject: Re: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for direct
 IO
Message-ID: <Z8m-vJ6mP1Sh2pt3@infradead.org>
References: <CGME20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f@epcas1p4.samsung.com>
 <20250306074056.246582-1-s.suk@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306074056.246582-1-s.suk@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 06, 2025 at 04:40:56PM +0900, Sooyong Suk wrote:
> There are GUP references to pages that are serving as direct IO buffers.
> Those pages can be allocated from CMA pageblocks despite they can be
> pinned until the DIO is completed.

direct I/O is eactly the case that is not FOLL_LONGTERM and one of
the reasons to even have the flag.  So big fat no to this.

You also completely failed to address the relevant mailinglist and
maintainers.

