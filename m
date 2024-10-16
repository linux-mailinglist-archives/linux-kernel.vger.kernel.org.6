Return-Path: <linux-kernel+bounces-367945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF109A08AD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB251F2228E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700D12076CB;
	Wed, 16 Oct 2024 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k9q+Q1r+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE85208205
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079394; cv=none; b=BqcBx7YbwDRRcEQzXeoIFdlY8ho6dmZ1H4XUX5iyYKvSDdR1RAv+QeIyQDDSaG779p6GOierRdWwiLae3sG/Ril9X/GxmeQVFjTKokjjGKgiBcWmhUCAK0mUk83KZ5ATIxGm2/al3brRxoN6w00Tv+XGrPpbfUDvW+eyxY4PX7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079394; c=relaxed/simple;
	bh=28Q5qgxQfJlcSrs/AmjGPdnxQ4VtlqnXFrY9th1tMfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pj0PzUiVIxGVHKKmJS8TnNMr2PGyQhMI+s3yJiQ0P9HoRnhqH2vnp7Et9Zl1FrhQDb+Vx+/x1h5vDg2NhlB8Df8bvpgyXQ6kVrRVOscd58b8jQaeQrCeV7AvUR/ZPh641NZaVtT/mdI6Bt4uBLlJrdUOdbegfOZ5HmPw4ANI4pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k9q+Q1r+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Gzu/ds5ICX6mJT/QXCx6YH/IITL1peo2e66IHou9O7s=; b=k9q+Q1r+flmFFfelzViKxHJMG7
	gNGon2Y9YvgQCSSSJN+Sb2/ryZIE4vPQlkpBNskzvZQfcV8gIanoG99kgufqzBsXLLtboEnaC6Yiu
	qNANA+ipVtwM0VS29jQRi7PLosfUZccRyk/XGYP50ZMLB4+GPoCRYaFP9+esrgbMz5QOc0mCkDkMc
	0OnVQdeJTzZu6k6IVts1WnH7oGKDlhg+4YrwcTMehYrxh+6DLQQEtGgTAI7aIhqDnMrD4Ajty9XY7
	ru8yCqu0T5kXxCbXi7fE2t2UzkmAGQfqknmB96bt0zDPv6isBGlHHXx9oYkHcKQ8xtyLFvUnO4roq
	dPpUxZiw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t12XA-00000007own-38uM;
	Wed, 16 Oct 2024 11:49:44 +0000
Date: Wed, 16 Oct 2024 12:49:44 +0100
From: Matthew Wilcox <willy@infradead.org>
To: lizhe.67@bytedance.com
Cc: peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC 1/2] rwsem: introduce upgrade_read interface
Message-ID: <Zw-oWIAPdCnQdyF2@casper.infradead.org>
References: <20241016043600.35139-1-lizhe.67@bytedance.com>
 <20241016043600.35139-2-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016043600.35139-2-lizhe.67@bytedance.com>

On Wed, Oct 16, 2024 at 12:35:59PM +0800, lizhe.67@bytedance.com wrote:
> +++ b/include/linux/rwsem.h
> @@ -249,6 +249,7 @@ DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))
>   * downgrade write lock to read lock
>   */
>  extern void downgrade_write(struct rw_semaphore *sem);
> +extern int upgrade_read(struct rw_semaphore *sem);

This needs __must_check, and I think this should be a bool, not an errno
return.


