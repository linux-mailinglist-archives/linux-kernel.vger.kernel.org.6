Return-Path: <linux-kernel+bounces-363245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7AB99BF95
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1194AB224CC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 05:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323E613C810;
	Mon, 14 Oct 2024 05:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gs12Wgri"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739E713C690
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 05:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728885386; cv=none; b=iGtK7as2LQfF/3UkZBOXWPjLLF+1fWymgVsyuHGXuThJCv7zs+S6FN0Up7eUjt5KJ9aLgcIivu4x4DqP4ctiwvRPhISBU3kZCsauCw3rcWhXM60MqStpczvkwIzoqWYrlLIdWt1QSszKnVwY1+RFHp9NyevTtK/z3WKLbM5Dt5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728885386; c=relaxed/simple;
	bh=U53mgDnO7w3k/vfZEmnUEHzLNCsCZ70eaquHcJBXdhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StCIoiXNtvnwZ61G+07cBT8KCTB2tS9fNUGI5r0WbmBugCmEhOFLFGPxRjrOhZIDukDfkiSexyBajhEzy8U3xLJnyqDYDH2aJ2ykkfgmPl7cZ/UimAjEon1gDXHVerYiYSeTKpXMy4gbWXcCOZYAC8PRYv+cC8Shs/RKuFZjNAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gs12Wgri; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K3iO/MnOLPS2CWyjua7B5ZvmEj83Ox3B2fumTWG/bgg=; b=gs12Wgri1mfwwGkMz8JRS4bsuM
	iYHYSF+OGWpTWVnHTD0vJKAWcgORFLp23qPQqNoJ05G8tQd5XjAHRhGCyv7w0GfdgCNvh/V/h6pZv
	QC2SXZxYd/7A9asVfT83ZKS4e4mJCfXTw/HGK3yCN6hodPP76kjFJuwODDeSmyiR00tYRWdc49aer
	VS9iZK+jLBUJ8XPiCJP4ypCK1dhGIBSy2bk5gqoJGC5pvM+ioHlxZaHCojVk7XS28d2V/iHG2GDx9
	7hSmzTlj3TFDwB4l9JGTWlUz8B3T+YRtdpWKLkzCJPlikD/FMU1BtKVH7VF3jaJrYAkWw6bfMzzS8
	zofwzQog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0E48-00000003oLv-3Jde;
	Mon, 14 Oct 2024 05:56:24 +0000
Date: Sun, 13 Oct 2024 22:56:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>,
	Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v5] f2fs: introduce device aliasing file
Message-ID: <ZwyyiG0pqXoBFIW5@infradead.org>
References: <20241010192626.1597226-1-daeho43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010192626.1597226-1-daeho43@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 10, 2024 at 12:26:26PM -0700, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> F2FS should understand how the device aliasing file works and support
> deleting the file after use. A device aliasing file can be created by
> mkfs.f2fs tool and it can map the whole device with an extrent, not

s/extrent/extent/g

> using node blocks. The file space should be pinned and normally used for
> read-only usages.

Is there an explanation somewhere what a 'device aliasing file' is?


