Return-Path: <linux-kernel+bounces-282785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FB394E889
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB47C1F22498
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334831876;
	Mon, 12 Aug 2024 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AweE10wh"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADE755896
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723451270; cv=none; b=DRxKABGLnm34cozwMzcuu7uLDqtlu9kQI7ff3CUmIYyDcV24uGPcqjRTbG7a3/aqXg4JArk68xOwvA0bn1yz3v1lve+0fXyWHyqsGpe/XDHW9IdmqOLdWzW1km1F+W1EKuRCvsDJv6YFhxUlpxG/dUihhId2BsXvHn6y6UkbNow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723451270; c=relaxed/simple;
	bh=OHmoPU/0746t+lF6/nNeWLH+w52Eg/DD/mfoy3t7qRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKq8FdkKfh8iARKyixN/ZL5JF+8WxhtZpxVgMPxN04eJCm9ZH3PNuhhrpOg7Sh74LHfVi/OqTCD5cqgWj2+EmvxQuqCYmvpaBhxHal6rNgAwy45c/KzIDigsn+uhys/4cclfeDntiW6O+FA1U/i3+bQfWvIWp+C3vNMQYZSIVTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AweE10wh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JQnSE5CoBf4ckjUProWLARWNQvxgl22xW+4ueUinWWk=; b=AweE10whFtcMVIu3u7iaGee+xJ
	djAMwYn/dL5ZO6fkeEgGZGXuHYvZC41AxxU++rnyP7G/RGzUzTvSD20AMwEjJWq6bNA8TBeHOlt8a
	5ide0/doAEgjQ/UKK5Ox8Tvpl7juIwzq3TLPl8CAWXJNJWfQcOnBeINm47G3qqfOE+ZQ1GJvhz0Sk
	/3vlCY9/NVXehoMs+FZvnzPY2X+HfHlQp5LxbeUw5qh/zSjaComly/kaknzaCT35RgX2Aau3SRuGn
	pdexyg4NReqg7g/yfzl9EYXdsPSYen5HEMFazyvC+7ZW53mgEVIscZp9vK6JdQhuLmUNpqbuBk/Qd
	wpCbUGsg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdQOw-0000000HH1L-3M5s;
	Mon, 12 Aug 2024 08:27:38 +0000
Date: Mon, 12 Aug 2024 01:27:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chris Li <chrisl@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Barry Song <21cnbao@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
	linux-mm@kvack.org, ying.huang@intel.com,
	baolin.wang@linux.alibaba.com, david@redhat.com, hannes@cmpxchg.org,
	hughd@google.com, kaleshsingh@google.com, kasong@tencent.com,
	linux-kernel@vger.kernel.org, mhocko@suse.com, minchan@kernel.org,
	nphamcs@gmail.com, ryan.roberts@arm.com, senozhatsky@chromium.org,
	shakeel.butt@linux.dev, shy828301@gmail.com, surenb@google.com,
	v-songbaohua@oppo.com, xiang@kernel.org, yosryahmed@google.com
Subject: Re: [PATCH v5 4/4] mm: Introduce per-thpsize swapin control policy
Message-ID: <ZrnHerW7VV0YKZh1@infradead.org>
References: <20240726094618.401593-1-21cnbao@gmail.com>
 <20240726094618.401593-5-21cnbao@gmail.com>
 <ZqcR_oZmVpi2TrHO@casper.infradead.org>
 <Zqe_Nab-Df1CN7iW@infradead.org>
 <CAGsJ_4wfWYGZVouK4JTj9DBDNPKTX_zrfU45iivaUy-Nq-P1bA@mail.gmail.com>
 <ZqkVMpbl5pH35uOq@infradead.org>
 <CACePvbV9DZJcYL17MyYrEjRehqfj1LQtj3TwrKuP913NAP4sZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACePvbV9DZJcYL17MyYrEjRehqfj1LQtj3TwrKuP913NAP4sZA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Aug 01, 2024 at 01:55:51PM -0700, Chris Li wrote:
> Currently Android uses zram and it needs to be the Android team's
> decision to move from zram to something else. I don't see that
> happening any time soon. There are practical limitations.

No one can tell anyone to stop using things.  But we can stop adding
new hacks for this, and especially user facing controls.


