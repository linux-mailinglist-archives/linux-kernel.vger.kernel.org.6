Return-Path: <linux-kernel+bounces-370026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E15FE9A2614
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A606E28A9DB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C061DDC32;
	Thu, 17 Oct 2024 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WbqRl4/B"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8521DE89A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177562; cv=none; b=rgFApOBTGbxgb39LvGuA2oYNdGmw9BWXn3cjcdgh4f2x4/RZduJHl7+sG/XY5XG9wUh8JT5KLCzEC/eom350nbMfHHwdRSWuhzKZRVsf6tuDLZpeJhUGkWoH5QKEE6oTvhDP9fo23Id9dzRAU/HNkDUqE51SUw1s5ZrsLaOePCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177562; c=relaxed/simple;
	bh=+Rzp0oBN7RHhGTtSx0jpnEX484NKlGCj9IkHttB3jkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NM0yq1IJfN6ehubP6Ct+pqr+yzODbUnG7Ia7rWilwKPkIfUr30spFf8LEmAwN63qVHJgrm6V3ubb7QvDs96WUIzf8eecCkpl6y/xN3RskrBVbMGIGMXOmb9UZqtABky650MWmjMc5TSG/Sxe5vI2R+pcONovsKG3seVzvoLHlDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WbqRl4/B; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aui/cZ2V9PGTfr+05NMlL/X+UUw+ndlvk9GG+An7uO8=; b=WbqRl4/BZmy51zZh2qxanceEsi
	+49QMgV+HycpusVAyyTUJv9CKCkus6Ta+bUF3BSTSkBAWb+7FUX7KjSJ6oyKCYybkqQtpgrwxb7Yd
	zIPUrVxOjhcv+iAUpXvINr3E6qo+bqxrHOGjwB911YH3dYgxCem+cSxNRvjTovJtaWThwcYem2WZ0
	iSvwjFYrWkZTohW2G5T2DBFw1oR+gI3Nula1JAQE+CbsZy2nBVBZ8baTUTYbTJlWwpcVOoWhS81Xn
	wmwCK8s4JFKZW2cSetu3mP6ggJJTnTh0F52UTkWXhJ4P1nKH9un5ffyW1+tcT7zKbe8Gn7oRDuS7b
	5gvMMbMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1S4Z-0000000FDoJ-05BF;
	Thu, 17 Oct 2024 15:05:55 +0000
Date: Thu, 17 Oct 2024 08:05:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Waiman Long <llong@redhat.com>
Cc: lizhe.67@bytedance.com, peterz@infradead.org, mingo@redhat.com,
	will@kernel.org, boqun.feng@gmail.com, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC 1/2] rwsem: introduce upgrade_read interface
Message-ID: <ZxEn0mIcQbu4OHaG@infradead.org>
References: <20241016043600.35139-1-lizhe.67@bytedance.com>
 <20241016043600.35139-2-lizhe.67@bytedance.com>
 <7f7b277a-7019-4bf4-b100-0505c6ce9737@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f7b277a-7019-4bf4-b100-0505c6ce9737@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 16, 2024 at 10:23:14AM -0400, Waiman Long wrote:
> Another alternative that I have been thinking about is a down_read() variant
> with intention to upgrade later. This will ensure that only one active
> reader is allowed to upgrade later. With this, upgrade_read() will always
> succeed, maybe with some sleeping, as long as the correct down_read() is
> used.

At least for the XFS use case where direct I/O takes a share lock
that needs to be replaced with an exclusive one for certain kinds of
I/O would be useless.  But then again we've survived without this
operation for a long time, despite the initial port bringing one over
from IRIX.


