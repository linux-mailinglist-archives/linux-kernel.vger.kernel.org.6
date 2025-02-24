Return-Path: <linux-kernel+bounces-529544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB4EA427B7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0593B524D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D7325A658;
	Mon, 24 Feb 2025 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LpFZ5ejL"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EECD1474A9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413841; cv=none; b=jMidKts+/oG5qLVECm488g8Zsl7nwSpaa+fBu+MlydDa7oMX8XJW0DP5F6zYvRk0Ymp8rGQt9cm+cyjIsGDKg3jUAJwAtr/5ESFatViNseh2IxXXTVVJgayzbkweNuq+hjWd/dNooQy2vhwwDnbipyAEJDNrsXWMuGbp+B4MngI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413841; c=relaxed/simple;
	bh=yo9JxgjYf/ScCj3LEzwDAFGCnXQxy+7/7XKdoZmi/rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SA7whjPnks6ld1D0rgye9pgD6KY3fHoAB+tdnPDT6kKtuF25+sTbfrKYhOuVs+OOs3j3hmx/QcxvO/4sBdpiepLtEj9rzQ7TF8ZB/2Yid2OhtHDy7g3RPaVXTev7T1NAoNwFh++HAa8hca54BQXEjCPdfEoQfNxyJmTZYByE/fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LpFZ5ejL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=riN2xThdQC9GaUY8tQqX5se0PRjowKE8bLS+k67G0lE=; b=LpFZ5ejL2ZTl+3ySDHDn4BHamR
	8hxGwPb2vsGJPLQpGXhvd+38OlvCFfwHL7bLtsY8IDqWeVXQBiXPREaTkjDXe7x53nvc1sVZ038yg
	q7+JdzQ/CKvv3ttbLYsxjjQvcZTCdL1oEdypdOHfd0v4JtUy1ghEhwf8Zht9GYYbcNOacLe0FNUNb
	KxLg0IiXs4efcO2qvlqfpr7rcdeQTuoI8DPXB0qMijcMqYsIYHYJwHPMy8CoUquqlJ99m0TuMgbFf
	ZGSgoN69N6yvLmkKvJwXLaoNlhwN0hCtk1JmPtxK5S54DzCP06Lr90AvFNHutuTJ6a6Sm3m0/oPcQ
	zEPtX5xA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmb8w-0000000EQhm-46gF;
	Mon, 24 Feb 2025 16:17:18 +0000
Date: Mon, 24 Feb 2025 08:17:18 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: David Frank <david@davidfrank.ch>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: Efficient mapping of sparse file holes to zero-pages
Message-ID: <Z7ybjloC5fobHbTE@infradead.org>
References: <CAOR27cSr9yxodkctfp-Yjybh1NsKBeSkhdbZYeK7O5M87PfEYw@mail.gmail.com>
 <Z7cygtpjGDJadgg0@casper.infradead.org>
 <CAOR27cQ8oHmA8fWnmB7Wk5pTL4TRjMPzRuqT=uA1cVROYZH7UA@mail.gmail.com>
 <Z7p-SLdiyQCknetc@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7p-SLdiyQCknetc@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Feb 23, 2025 at 01:47:52AM +0000, Matthew Wilcox wrote:
>  - Choose a data structure in the VFS to store this range information
>    (a tree of some kind)
>  - Design a protocol such that the VFS can query this information about
>    a range of a particular file, and the filesystem can invalidate the
>    VFS's knowledge

That information is always going to be incoherent in some way.  Reads
are already done without i_rwsem for most file systems and there is
further work on reducing locking.  So anything needs to come from inside
the file system itself.  That probably means you can't reduce the folio
allocation overhead, but at least you don't have to persistently use the
memory.


