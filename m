Return-Path: <linux-kernel+bounces-250098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFBA92F43D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACB8283CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 02:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EA3C2C8;
	Fri, 12 Jul 2024 02:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X/LwbqQP"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E7A9460
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720753154; cv=none; b=I/goTG+n2Zxx/DLwznKtlukQxgxtM8YQbQJo0y/A6zHOLIEusx0+YKDVCfke7k/sMW7LaKZANuksSy7ItfnLsNbh16eipG8QcnwcdDOm5ioCfMVnV6vAz4GELohstaVLrd5qvJtsrCSauOPKEsLskQuHI59serp7fFN4iCpzY+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720753154; c=relaxed/simple;
	bh=LAx6aAujNvB00dOAD57vKQNzCp/fEEERSQiKEx4ARXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwSD9n/AvUZAzyXAIV5hkWoRW28tZFENndB5CY5ozxLvfTxhshXwo21nwZMHhLjPGlS8AJ6UNrpypWoHaXxE1ShsyPzSoMmIrbYk6Fwg3sHAs/C++JrnPIpdvcKyIaZkb4s6GIjMffwO21BWC2T7klm5H4dziYCbBar8Hrqv6K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X/LwbqQP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i9V/ScIZojD8XsoVocyVm5ZLToZi3gLaiIOhUgdAAlQ=; b=X/LwbqQPgV6iIQoyh8M2amdNbP
	CvEd14tZEypHdAoWuqB/WmkGzIEc0rKU/IfD5NSyUswWssuhWSC1mmQ1zb8emXGa+f/LUa66ynRvE
	7Ym0Oyv6h6IkTh3x99lfgHbsyjHZDfsIEqIbqtNWTRPlvGWfj3cdCz4SZtnfaHCSXQbCkPiQsjWeh
	BES4yjMmkGtJJ+h62pJCo9J/CbxaJJ80Ig6TyMHUJtJJ+AY78llaklaCA5O15VuAa4h4+2jqD+YqU
	+NiMDXyUcrZEPoQ0NHQJrQ4qCK9J4t6dqeYMhz5j1bVxxTH90wV0VU0xADwNGVKVFjElaSxxw5TR1
	Vh3CYuuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS6V2-0000000BvEd-19CY;
	Fri, 12 Jul 2024 02:59:08 +0000
Date: Fri, 12 Jul 2024 03:59:08 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: unified folio_test_anon()/folio_anon_vma() and use
 them
Message-ID: <ZpCb_MJzMjG9JZmQ@casper.infradead.org>
References: <20240711130351.2830-1-yajun.deng@linux.dev>
 <Zo_ZULOseAmEQMIw@casper.infradead.org>
 <66e43c92d3b4ecfff50e84bdaeedfad3aa477df6@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66e43c92d3b4ecfff50e84bdaeedfad3aa477df6@linux.dev>

On Fri, Jul 12, 2024 at 02:29:50AM +0000, Yajun Deng wrote:
> I think I need to add a new helper function, like __folio_test_movable. e.g.

I can't understand your commit message.  I think you might be better off
dropping this idea and working on something else.

