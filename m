Return-Path: <linux-kernel+bounces-294646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E107F9590B5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898231F222DF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21F51C8239;
	Tue, 20 Aug 2024 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DxCcwd0X"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ECD1C7B6B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 22:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724194449; cv=none; b=spH7C1Tm8EYpFdQah7ykofGIOutFESudDKH2SZyvnfLY1PSBI0FPmLRogD7AWGguddNaEEbE4xpjCy0p22jZlcP3ugN8cdvkXvethZUWxBSaWu/3/0o/M1Ru0YMDcyF+y5s8QpltCwy0W9DytPyTg47r2o6F9wUZ+c3fRdIxI94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724194449; c=relaxed/simple;
	bh=r5lBv7Hz+onnRrx/pZsD/8RoMGEs43L7lo0uknauVmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgvAX4Veh9/8dhgkF1miDJKpNeYdBQzbex2/skINW7FHeg/BinlJZ0q/bFcaX6ZyC+C+AGPXnqG59GPT5tt43pMb7o9WkUNgF5n+zlfOnC/hvOcJ+LAp55895XsFg6reUP43u4G3Kkt9AhNFpSti2SSiXb/0am7x9MXehlUf3Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DxCcwd0X; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lKAGCijiX0EyKGs0TgqDBYnrweM5givvvNYv/P0zrdo=; b=DxCcwd0XNiWUCcpNE2+lOPx3iy
	JM9HAeDo1J7YHZQZwFkiB7rV7Y48v3TxUDBokdamUSQvgieL/lbFhIzSYKONX4EnRmS9B+c/Kqlck
	ow8OYQ889KElsfnJfD1wd5x1JGDPszTspJ7dyy07LPzTU2yi0cCF6AofvaHH6zxsojLI8UfOGu5t/
	zmDFciyvdIllLh+YVAmir08HGJlN+L0yT7sroB3xSgmMD4NKMFTY/UOzxXlovypoN7Hu7v9d//hkY
	hX8a1NMEla9WpHSutOIeMXujBjf0CAj1tj/hXOsEV9tDu6Zdji8+1MbXmQShaEGhs9xyKmqYEA1XT
	XW3PchxA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgXji-00000008UIL-2mMC;
	Tue, 20 Aug 2024 22:53:58 +0000
Date: Tue, 20 Aug 2024 23:53:58 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hillf Danton <hdanton@sina.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	syzbot+036af2f0c7338a33b0cd@syzkaller.appspotmail.com
Subject: Re: [PATCH] maple_tree: Remove rcu_read_lock() from mt_validate()
Message-ID: <ZsUehuMKf1dfRfJI@casper.infradead.org>
References: <20240820175417.2782532-1-Liam.Howlett@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820175417.2782532-1-Liam.Howlett@oracle.com>

On Wed, Aug 21, 2024 at 06:38:45AM +0800, Hillf Danton wrote:

Hillf, your email client is STILL broken.  It's using the same message
ID as the email it's replying to, which causes all kinds of problems.
Please fix it or change to a different client.

> On Tue, 20 Aug 2024 13:54:17 -0400 "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > 
> > The write lock should be held when validating the tree to avoid updates
> > racing with checks.  Holding the rcu read lock during a large tree
> > validation may also cause a prolonged rcu read window.
> > 
> >From the rcu stall's view, holding spin lock plays the same role of rcu
> read lock, so what are you fixing by simply dropping rcu read lock?

He's not holding a spinlock, he's holding a mutex, which has very
different properties.

