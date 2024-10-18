Return-Path: <linux-kernel+bounces-370943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2087B9A340D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B781C21091
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6553175D25;
	Fri, 18 Oct 2024 05:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uYLqtCaT"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A457D33987
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729228035; cv=none; b=DhD4JAnJkH1pM5sijDEX/gzkiLysElZ4HBX+ElDQ/N1Mob3YVYFAOAjjegcB6ENY/7/mViVv1Ue+eDhA2dZh8Z0pTMnFpxhyt8udntGdRBegYf0i9S85DtQjVHUtsJrk3Z9CmO4NURqj9AG64RjzFTGVNbyqXh6UBiC6AxTSrh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729228035; c=relaxed/simple;
	bh=TRyKIpA2bxCzF2ZQfNDLGqq2DI942cQdfKZ4w0TZUR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9GllCzmIOe1BpGdRxl6rRfZ9EWVEZyn4ylh69wfxg2v82eK6vQyDj9kLoLHqLncl+zpodY5DL56zfh8xLd47ed54/M0ORXI54mPiVQMwAs+N3L+rf/uA1qQPWOcymdRMAUvvkaqp2Q1cBY89UrTR+4ekUBrH/AfJ8jUnJgZ7Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uYLqtCaT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=edrTfUxRMP+2NqIsYy8r9egi/AhC94PJ5tiYy0kQOBE=; b=uYLqtCaTfYJarEqPHTsgNhca87
	Xox72akA+3ncmhexXlUH99++f5igw1+82x93j+bXQ7zslJfv+nJTV+IQNtG0EVdz7oeBzNnOj2xaz
	Aac499886i9ZFmtSKesknnVAbUveC2LbcYRt5xYwFOuDDVIy4rYQXKYsr4voF9FLKMQbmdjN0oxxC
	E8NAziVU3nZq2lxrvPgWVAVjEg0uCR9UHFW8Pv4hKD6AeNIxVzkOTgN4GsV4LVmXPyPfPv9xbag0H
	EjYDmJ6OU51ReCrvvw59WcfuuCAPljxACOfsSpvZLtX7e4DxUvrW8mLhhHBGVUhYpFoai6TBw8J+2
	CF1VdGoA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1fCL-0000000GvRq-0xGV;
	Fri, 18 Oct 2024 05:06:49 +0000
Date: Thu, 17 Oct 2024 22:06:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Waiman Long <llong@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, lizhe.67@bytedance.com,
	peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	boqun.feng@gmail.com, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC 1/2] rwsem: introduce upgrade_read interface
Message-ID: <ZxHs6WyGcJEfd_DI@infradead.org>
References: <20241016043600.35139-1-lizhe.67@bytedance.com>
 <20241016043600.35139-2-lizhe.67@bytedance.com>
 <7f7b277a-7019-4bf4-b100-0505c6ce9737@redhat.com>
 <ZxEn0mIcQbu4OHaG@infradead.org>
 <a094f899-018c-4eb7-9bee-46f102a33b8e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a094f899-018c-4eb7-9bee-46f102a33b8e@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 17, 2024 at 01:36:41PM -0400, Waiman Long wrote:
> > At least for the XFS use case where direct I/O takes a share lock
> > that needs to be replaced with an exclusive one for certain kinds of
> > I/O would be useless.  But then again we've survived without this
> > operation for a long time, despite the initial port bringing one over
> > from IRIX.
> 
> That means XFS only needs to upgrade to a write lock in certain cases only,
> not all of them.

Yes.  Basically when we detect a direct I/O writes needs to clear the
SUID bit or other metadata, or when it is an extending write.

> Right? In that case, read_try_upgrade() that attempts to
> upgrade to a write lock will be useful.

Yes.  But I also understand Peters reasoning that it will be very hard
to actually have a useful implementation that does better than just
unlocking (which is what we do currently).

