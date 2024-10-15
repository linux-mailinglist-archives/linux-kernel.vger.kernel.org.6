Return-Path: <linux-kernel+bounces-365088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF4899DD59
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBDC91F23035
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 05:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B2516F907;
	Tue, 15 Oct 2024 05:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l7M1H4Gk"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C804409
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728968540; cv=none; b=Jnmed08qklI8s+F8L0Hv+Y1gcGXxRXllBOZy6S2+p5aWNYaOfbr1t7/7Ipw5ekWRruf2QTUT3xeAfnGezhDJiBOhrQmhQO5X/rgYY5PhLRz0FOPU2PrI/kFU1ubEJbO+NBclhVChpuXM4vgio6ELxICtqQsbBZIKwamvxA181PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728968540; c=relaxed/simple;
	bh=5ZxbzQ4ukpg9S2lPW5Jl0+eQ3D/GRcQ5hJeqPXsJl7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFkM+fyyN6UCkTpoyLNcDi2MBZMoFbr+9wr33vmf1L5iRUdnwdkdEO6ZL1DiQVEAoVvPDAgOpM4NfK2QRZMAVZfIwkfUfPUfwYkZJDa2gWwvZwXKMYDuARJY6XoWsJ60HUq4XpIESw2w403X86BVb7vQfjtow2esaJluhnXMobo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l7M1H4Gk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=0MA9WHJL/WVIgmEkBwYvdGDLHEtwUJ2Z4YXr0YnVjXs=; b=l7M1H4GkHKRrvkacu9ZQzsm6Mx
	H9DZoioQynJmTDmmdQJcOnZyug4DzPpbqGPkdj9txTC6kJEyH0xfwAy4h6Vs958lufTzXcJuPqtji
	YWgxPttQ7tLXqts9tVY1P3vR/ThQdlWOw9fukAkIQlC2txBVzM8V0svd/zhW6Z3yFdXSn7MNHM/mL
	94zYtK3Sjku+sIl6TGsrmxx7b8zuYdosM23DuL9yzDZno1L1xaETFF++kDfGF6Odk9IT/orojli4q
	ss5VZlpH/GrmU2wPv2ATmY9ax6B5Ne97ChJvW0w+wgboVtHpm+VZCCM1+1Fu1QjjaMq+UaEL3uo5K
	foeLjk7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0ZhK-000000074su-0NrT;
	Tue, 15 Oct 2024 05:02:18 +0000
Date: Mon, 14 Oct 2024 22:02:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daeho Jeong <daeho43@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
	Daeho Jeong <daehojeong@google.com>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v5] f2fs: introduce device aliasing file
Message-ID: <Zw33WgpF09IHpKLB@infradead.org>
References: <20241010192626.1597226-1-daeho43@gmail.com>
 <ZwyyiG0pqXoBFIW5@infradead.org>
 <CACOAw_yvb=jacbXVr76bSbCEcud=D1vw5rJVDO+TjZbMLYzdZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACOAw_yvb=jacbXVr76bSbCEcud=D1vw5rJVDO+TjZbMLYzdZQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 14, 2024 at 09:28:04AM -0700, Daeho Jeong wrote:
> On Sun, Oct 13, 2024 at 10:56 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Thu, Oct 10, 2024 at 12:26:26PM -0700, Daeho Jeong wrote:
> > > From: Daeho Jeong <daehojeong@google.com>
> > >
> > > F2FS should understand how the device aliasing file works and support
> > > deleting the file after use. A device aliasing file can be created by
> > > mkfs.f2fs tool and it can map the whole device with an extrent, not
> >
> > s/extrent/extent/g
> >
> > > using node blocks. The file space should be pinned and normally used for
> > > read-only usages.
> >
> > Is there an explanation somewhere what a 'device aliasing file' is?
> 
> Plz, refer to this patch and the description there.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/commit/?h=dev-test&id=8cc4e257ec20bee207bb034d5ac406e1ab31eaea

This is about the extent I know, and I'm still utterly confused.


