Return-Path: <linux-kernel+bounces-220099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E191790DCB2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1AC1F23B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BCD16CD3B;
	Tue, 18 Jun 2024 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NambipHs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F6616CD27
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718739858; cv=none; b=iLEPwHTu2ZiyZKQg2/z/R7I81LZXA1tzdkPxuvwNzMZ0oBnknrWK9bFKmUoFTQuQl4zGV9mDmH6z7sU8097RKRCogEWbXgimmMlUY+AlAb6SwFoFsYSxLfXde0dM9kcEXVZ/epmVTjibkoRJ5KhwaL6nU0jt3B2EV9wT7UtPeyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718739858; c=relaxed/simple;
	bh=rIJ5+GUJI1PTS3Z7ZAUJY72TPUFyF93XiS+gkPOXsT8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=niQiYc4xHQY84vTwua/ixo9neVgbW24w+pNv3BjUgZ1ToLHKWkYE7J4MB+jNgEq9oUFtPmQXmiRB0uaihFwM3BVmIk6HjjPncCvtjxMCmViUMpC6siiMTuwQ9vRgx5hv6HW+yD2s7tUuXlMz7SDE/3fRWUYYOOp3/32WGVNOxwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NambipHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD95DC3277B;
	Tue, 18 Jun 2024 19:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718739858;
	bh=rIJ5+GUJI1PTS3Z7ZAUJY72TPUFyF93XiS+gkPOXsT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NambipHs6oeTEEEduV4YC6xIap54zm9+xZq6yO1xkiPG7yW2XUNCq3CS2YJruMwWG
	 fJ8YwSTxZAWzs9MDxacG7cRDB51dOXBqE6LH4Oy7WGqXBy8+v1DuL3qJsbPZbD9RLP
	 b1EvcEfh3nAoZykcYn5gMklmKxXBOPytrBelKQg0=
Date: Tue, 18 Jun 2024 12:44:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Zi Yan <zi.yan@sent.com>, Hugh Dickins <hughd@google.com>, "Huang, Ying"
 <ying.huang@intel.com>, linux-mm@kvack.org, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Yang Shi <shy828301@gmail.com>, David Hildenbrand
 <david@redhat.com>, Yin Fengwei <fengwei.yin@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/migrate: make migrate_pages_batch() stats
 consistent.
Message-Id: <20240618124417.08745f6c08f6ecb2c959a096@linux-foundation.org>
In-Reply-To: <20240618134151.29214-1-zi.yan@sent.com>
References: <20240618134151.29214-1-zi.yan@sent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 09:41:51 -0400 Zi Yan <zi.yan@sent.com> wrote:

> From: Zi Yan <ziy@nvidia.com>
> 
> As Ying pointed out in [1], stats->nr_thp_failed needs to be updated to
> avoid stats inconsistency between MIGRATE_SYNC and MIGRATE_ASYNC when
> calling migrate_pages_batch().
> 

Thanks.  I'll add

Fixes: 7262f208ca68 ("mm/migrate: split source folio if it is on deferred split list")

and shall queue it for 6.10-rcX.

Please don't forget such details.

