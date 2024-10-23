Return-Path: <linux-kernel+bounces-377504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1669ABFB3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C1F1F24CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823B014AD3D;
	Wed, 23 Oct 2024 07:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="axsJdf++"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB34417741
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667139; cv=none; b=YNqs9pPXU/Y/dpnC7Rs1HLilpVYJIsrZyJI/0HgTULE7yMrw1GaqrVMUKB6A0+f1gsN8NCUu+HYNGc9GjFlHj/+wQg1GZ8/MkgwmMbycfM3pkrMMYj2YOfdarJNIfsX5pmGux827RJC+qH8R7fjB5AhXxJTWeQtDQ0n6sksC+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667139; c=relaxed/simple;
	bh=OsniFanEL3Dgve+4KzzT7EAoH3kZ5d6NkRqH3plnZ1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieYJHI9dnQ0zipkQpLIi7gB1JSXmk6CcfJdaYJDuRi1UzVJdm63CTD92Owv0vKaDcV0ap+fyugcBaxC9bic722N9LoDS268q3OOGB76E/xl7sIfU4phHNFab3zkddaSpp7y7zdvifgfGHz64dJ5Bzy57u2HFPCurKRiRUDcLeS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=axsJdf++; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OsniFanEL3Dgve+4KzzT7EAoH3kZ5d6NkRqH3plnZ1Q=; b=axsJdf++TYblxJFfvZHsCQtSTp
	MFJ5Gxp14AVOdhtYdxkRFm8vryrPFsEi3fIjHT96PlIJtkZZioF2nlRsYPK5tVbpctQnbtaOlqZ0n
	iuBk1H1nBxYpBi8GHn6YHvYiC0ac5s+OeIZFdRkO9q67e2ToXiuIXTjGQQfOpGk/VSJLgMA6aVcjW
	hippYP3b54zou+kYzX2BvcC6en3rF9Ax2G2GpjLirInZQj2jS9XtoKny7UditWXN6NpYI5h8nEDfA
	U+9nQ6JI++Ssg8+4agqW7i1VR7UzGbkv9gkpr+Cxrrspa17xCup7qUO1PpgCJZM/Xy8oDDDdFVlS/
	PRI3LnGg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t3VR2-0000000DJkM-4A3y;
	Wed, 23 Oct 2024 07:05:36 +0000
Date: Wed, 23 Oct 2024 00:05:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Marco Elver <elver@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: export copy_to_kernel_nofault
Message-ID: <ZxigQIF59s3_h5PS@infradead.org>
References: <20241018151112.3533820-1-arnd@kernel.org>
 <ZxidW3lvA5Pqu71m@infradead.org>
 <CANpmjNNK_viqTuPxywfvZSZSdWGRsb5-u1-oR=RZYTh7YKk8cQ@mail.gmail.com>
 <Zxiev9UaoUlI1xs9@infradead.org>
 <CANpmjNPvBnov-EFk1PNO4GEOF7XLG7S1bYYjg9i4Ej=ZzaA6ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPvBnov-EFk1PNO4GEOF7XLG7S1bYYjg9i4Ej=ZzaA6ag@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 23, 2024 at 09:02:23AM +0200, Marco Elver wrote:
> Another alternative is to just #ifndef MODULE the offending test case,
> so it's only available if built-in. No need to just make the whole
> test built-in only. I know there are users of this particular test
> that rely on it being a module.

That sounds good to me.

