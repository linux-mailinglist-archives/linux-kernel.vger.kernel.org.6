Return-Path: <linux-kernel+bounces-260037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B178F93A1DB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A87283F03
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D482B15252F;
	Tue, 23 Jul 2024 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dIHK/KSM"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DE615358F;
	Tue, 23 Jul 2024 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742304; cv=none; b=T0BKO7dLnCH39gm2LNK/+3Bj15GE6p+28F0yS4+S+Yxq5Sr084iruI3zwMLolR9V0KOxr0w02jr164sgQNVUp8YzDzcqMW0Nm7qxCoSrrB92PEUbMphtLFxZBK6R7QYHK5zqg7IIwQVFAQVMF6Co0su5Qezqpsh43+7aDqN4V8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742304; c=relaxed/simple;
	bh=Sn0CDcdSSakfYKqkdT4pe6s0EKu6ygEWp5+SsH4x6Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L85n2zUTB2LizlvQ+dJ9viGkcNt+w9o2Ld5HY8/5lysj1ONaOWYOuyzsGTIJu+DYMT5OSiBVSM2mUTvnzp7+CYsDMvTSAmvkN2Gkq4W5XRCzX6z291WElMJF0LR2VQux8VRsBDbubG9UY3oBkr2hQwlVN6YW/2zA/kkan2Z6FCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dIHK/KSM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HqBoWdQW3d7BDVKfO4jErZs5Wg237Hb37/MqqUbF078=; b=dIHK/KSMuQ+ggwMwKxtD3NE3t8
	/kPspbHJcE1xTJCHP1S1S4zBfKZaQKhFvK4WjKMSD8bcXvBimh2sHldi08Kst1LnBSU+Zyb1QyC03
	iCo/P8ecrjBGHiH594HQSjXfbdYQzks8AxW96gB48rLhPz8QJkA/tHcV8KsXEbDYFwtHuAXd/H4VN
	u8wjU1wjjzQRydhdFFixDFRjYCCGIJTASUig/hcTNMeWrd3gtQjoZnn0MuiS3TTNgUHPbdiiqLXll
	pYK/bmZb0vtMeyF1WqsZr/7uOf46LDGmKB8ua6WV7pjMwKlwzgC97jNnW7oFfN0AL7ofqH/Yy+pXI
	6fz0tqJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWFp2-0000000CbKT-0X2L;
	Tue, 23 Jul 2024 13:44:56 +0000
Date: Tue, 23 Jul 2024 06:44:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, cl@linux.com, penberg@kernel.org,
	rientjes@google.com, iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org, vbabka@suse.cz, roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com, hch@infradead.org, kees@kernel.org,
	ojeda@kernel.org, wedsonaf@gmail.com, mhocko@kernel.org,
	mpe@ellerman.id.au, chandan.babu@oracle.com,
	christian.koenig@amd.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: vmalloc: implement vrealloc()
Message-ID: <Zp-z2IWwGtIH9O4p@infradead.org>
References: <20240717222427.2211-1-dakr@kernel.org>
 <20240717222427.2211-2-dakr@kernel.org>
 <Zp-T4F42tk_aKKc-@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp-T4F42tk_aKKc-@pc636>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 23, 2024 at 01:28:32PM +0200, Uladzislau Rezki wrote:
> Concurrent vfree() will lead to use-after-free. Either add a comment
> that a user is responsible for not using vrealloc()/vfree() on the same
> pointer concurrently or use find_unlink_vmap_area() which might be more
> complex when it comes to design of the vrealloc().

You can never use *free concurrently with *realloc.  I guess it doesn't
hurt to clearly document that, but other than that we should not try
to cater to that use pattern at all.

