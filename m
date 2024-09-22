Return-Path: <linux-kernel+bounces-335152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 577C197E1F0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 16:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043EA1F211E0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 14:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494BA4C6C;
	Sun, 22 Sep 2024 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aTaq48gZ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707D063D;
	Sun, 22 Sep 2024 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727013806; cv=none; b=AzbZy/KXh6WWZxEiSHtiNWNhEQuxhAwiAJVezp5dqDPZjwQbNXW7M/5GqZbrphgC+QVuGnnsatZjVknoyObUhsQ68BWfkcgXdaGsok7z3gTme5TLgHwHPC5GnJhrsaumhM4bDgCHEnNyhGxq25Xs61Q7vmuwd/mK4v93aIUdBGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727013806; c=relaxed/simple;
	bh=k86zEx3ofrkqw4phrOzlxuLf0+ZDRjH+ULGWkEejKYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpC2uD/8aeC0r09XA43JqlMcO2RuFyi7jrIdVu17Opt2YtNiZBAAfS1vulplXA1nODESsNFNY7wBZgv+GJNAcZbjargCvvXlJC/FVGFsE8BL86WggMh34PUs5ACMfYhQW7AEFQ/QFyOZ6dbsGbP6N1658bLvw/CfDzJfFHxJ9A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aTaq48gZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k86zEx3ofrkqw4phrOzlxuLf0+ZDRjH+ULGWkEejKYU=; b=aTaq48gZWOxdFMQfvjVewBTOpL
	e/kNvnNjxHlyz5IkGwG2u+7+TPcL1QEMLaZAweehMHCkZCdyRmrDB0i6a5/qRTHudSyLdxnjHu65p
	QxtvPz0giYgaNyLswyyIXsJKKGGVAkGIxFgBLtV4BqMGiplU44YxX7Xo+/jHZWFAqv8+/BnoTXNlb
	je4/1VCMgXxGErqW9Exk68Bndba2V5WvU3Y+rR5MQyYFLMMr8vKNJny+obP5iVoFGjlUk7wvK9BOy
	t5XZVuNaqhSA53IFGVi9Gu1v9l7f0ow8rkSzlLt6cjHKTqNHb9bnTu55AN0mymBTVpYHZrtcJ8nMo
	jcu/RkfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ssNBK-0000000FEJA-0fz5;
	Sun, 22 Sep 2024 14:03:22 +0000
Date: Sun, 22 Sep 2024 07:03:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Xi Ruoyao <xry111@xry111.site>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.12
Message-ID: <ZvAjqjrWj_AXK6DX@infradead.org>
References: <Zu2Bd50GdSxF_-eA@infradead.org>
 <19e4bdbcda78ace200c78c56eb7173097337b921.camel@xry111.site>
 <Zu5VoW1ZkViSOws3@infradead.org>
 <9a84a7c6f943209cc87a54075ed22df37ebda5f8.camel@xry111.site>
 <Zu7PW07FmBgs_dpI@infradead.org>
 <38bc765eaba8a646a87ce14e1ff06f28d449fcd5.camel@xry111.site>
 <Zu-kCdMau6127_vM@infradead.org>
 <11368b7c0b7370aea61b3dda73e462fb70f306a7.camel@xry111.site>
 <Zu_FDfHZAVzPv1lq@infradead.org>
 <20240922103236.GA11337@unreal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922103236.GA11337@unreal>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Sep 22, 2024 at 01:32:36PM +0300, Leon Romanovsky wrote:
> Another chunk that is missing according to this BZ
> https://bugzilla.kernel.org/show_bug.cgi?id=219292:


Can you send me a formal patch for this so that I can get a pull request
to Linus by Monday night or Tuesday morning?

