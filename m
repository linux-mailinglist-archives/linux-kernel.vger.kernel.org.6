Return-Path: <linux-kernel+bounces-304487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9EC9620CD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39722B23E54
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD1C158D94;
	Wed, 28 Aug 2024 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LVFEoWNQ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4029157494
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724829597; cv=none; b=KwAP0qJwScDySAoC9/2nrkG/qPOEL5ybiZdzc3lvUrWzCGIbTPsgOgse4v8g4TNsFZaZHHvASF6rGQlec6NfZovaT0/q6ln02RkwYM36nV0bpgmyWdzrsPF27i0QZ4kMsd0Vfn8TW5K3SBCUwfrwQKWm1xiuG/dPyl/jGrddGeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724829597; c=relaxed/simple;
	bh=MkoK7XszBNSKmMoQmcyOlo1aXEhkb6Ot/0eN6SbNDa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9FwUljKxPucIBFzBESFfPmQQE0ZMAvpZMCdI3HBo0H1CGsprJqguBlC4OlxKqx2KgQPxgMUMnl6sBGWMffQ44erUVwuTibmDBEqoxcsUBfYwv66ohJfuXxuMwTp6vhPFpwb4nquSgY6FB4GjV/iWzM9CZYCYPwsCR8EY6vRgSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LVFEoWNQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5gFg8xHBnSoG8qZHRRlgTmkwJwYygsa08gHRryjGivk=; b=LVFEoWNQn+OAjVGffEz7cZqQcO
	KhdcBpl4ZCVD11oRw5JzGwJqA1nUAicr376OPPOhhlXPv8XLW9okOGyavTxsVYKwZVDCbLvPZXVJY
	wBjBYfEd/R8A6RK4Lo3cH7Svy/693aVjQLUBPVGC0taypDOci1HU7ASkXTcYyZdphfYG36E1sZ4Pq
	2ZIKVe/By6VSj548xpdQ1COyUYCup0fTvkOMTNWOIsklSXGO8mADDsAAs1AdODuIStgDZ56qpAdFt
	s5/4Hh7zA6KKwUEbENs6WB7+H7i9dc1lsEJcjybLOH41Vn4lLfO2gywud+oe6IhMRtELk7OnjNY+d
	V6lW7vSg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjCy4-0000000EExj-3ROL;
	Wed, 28 Aug 2024 07:19:48 +0000
Date: Wed, 28 Aug 2024 00:19:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/EISA: Use memremap() to probe for the EISA BIOS
 signature
Message-ID: <Zs7PlOqxdz9xGCIo@infradead.org>
References: <alpine.DEB.2.21.2408261015270.30766@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2408261015270.30766@angie.orcam.me.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 26, 2024 at 10:21:47AM +0100, Maciej W. Rozycki wrote:
> +	if (p && *p == 'E' + ('I' << 8) + ('S' << 16) + ('A' << 24))

Should this simply use strcmp now?


