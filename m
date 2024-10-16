Return-Path: <linux-kernel+bounces-367993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401679A093C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C0E1C231D3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BE6207A3C;
	Wed, 16 Oct 2024 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UcS+SPbO"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987971B395B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729081268; cv=none; b=pUwhsAZLHcovNoSCgBksIgLfN6NbD3fpXBvrJn8ofZhT514xo2jeabDaud8Rr0SeCIEHR22HLDzj1sPlXQSk9/jxmK9lyYk3xDgaUVUvLgKmHY8kR8a76kj59LziD/4vRiapzOmMJO2Go1becmpsjQqyfGwiuZHOHg6uitXPgMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729081268; c=relaxed/simple;
	bh=3+5cJ+TPtK4t1KogVa6yiCibSZq0HCZst389ECDxIHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAQhY8WmwuTyhYjOKRsFwGxPmqmj59HTOPAuphjWeC2olzJCoP0CUDWZ74f2EwI7p6wQCodrQwaWU5F1j6i65JtkdGxYGLnpGu+FI4wpYTPQCAX4l6yjLuYy2Co9DHQPSfWRzMM+c7XyJexwFPU4c4FT6rYrscBH5VqotVWdoBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UcS+SPbO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nicdyFTZX9ieCZYp6ZmfHdLzBRvz0j9w4YIafplZsjI=; b=UcS+SPbOrwzSnT08ot3hY/CSeL
	pZqWiTKxdylFrPmkWX4QHs3BoBsWdVjdAnEHBKXUSivgHMfq4NUx8z4yCgNXOdBDfA4EbUunyq1TH
	gzXJKE5fuRS/XSEO/+MFweEuqt/0uJ3bzL8zjia95AlhcpWPiR4CBVhbIoB5zHcht8mQ+6JQMAb0L
	kO0Wd0hR1vtQFH4qhweyGDtP5sEI+Z2lTkbfgc/RIJNVesy9DwTbtMQNNv35kL6stWzybL7ouCHN2
	n5cTl6PVTjSnNHXkXoRhrrqakP+a7bTPu19O/hc1dsUqK2EmNWNF9w6+8Qd2EkbyB7Ac2ZldSSGlA
	e3T3EY1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t131Q-0000000BiEc-3hrM;
	Wed, 16 Oct 2024 12:21:00 +0000
Date: Wed, 16 Oct 2024 05:21:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, lizhe.67@bytedance.com,
	peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC 1/2] rwsem: introduce upgrade_read interface
Message-ID: <Zw-vrAFdO5aZKSmy@infradead.org>
References: <20241016043600.35139-1-lizhe.67@bytedance.com>
 <20241016043600.35139-2-lizhe.67@bytedance.com>
 <Zw9Hk_9OO-Aqsshc@infradead.org>
 <Zw-ou7gsqTMGQDdl@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw-ou7gsqTMGQDdl@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 16, 2024 at 12:51:23PM +0100, Matthew Wilcox wrote:
> > It's obviously a try_upgrade_read, right?
> 
> Well, that's confusing.  "try" usually means "don't sleep", and this
> sleeps.  Maybe it shouldn't sleep; ie we make this fail if there's any
> other reader?  It'll succeed less often, but it'll be easier to
> understand.

To me try primarily implies that it can fail and the return value
needs to be checked.  But I guess it has different implications to
different people.


