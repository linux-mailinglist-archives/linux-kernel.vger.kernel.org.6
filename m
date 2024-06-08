Return-Path: <linux-kernel+bounces-206901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD050900F7D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 06:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D543283A53
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 04:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E7F101F2;
	Sat,  8 Jun 2024 04:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nPNnqtW2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6407FC2E9;
	Sat,  8 Jun 2024 04:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717820859; cv=none; b=tOVzQjMZTjhvyeE6WeuWs4KWLp4xQCkTWrODCcvSVPi34d5RvM0PmeqP+tw0CPV3zQXwViYoPq4oQVYFCDbyBPAaEESwPx3VIHi7YJyNzaUjBJncw8JR0FBBeT6wy4im9qD12eg5HXWcmylfBZ+CxrsJsyo+EZUn6k8wWBR5Xmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717820859; c=relaxed/simple;
	bh=G3GoFdX96mK6HyzLxQ8Jmg4Jk5/2/ZubK6p1ksrewKM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DNEX6xA0rE9xwgOc1XlWrryFpFoPIs+xX7gfs8L4fm4GcbVVMWpY/RDzYGjKHricjKDFSZDpRYdk1XFu/mkWqHQWyaXDZdQ1zV2lb4g0ub1XZu6FImugqflsdVauXgj360U3XK6rLdKrhgDPpR16TC+7y07T7kUHQXiULY5htrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nPNnqtW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD24DC2BD11;
	Sat,  8 Jun 2024 04:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1717820859;
	bh=G3GoFdX96mK6HyzLxQ8Jmg4Jk5/2/ZubK6p1ksrewKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nPNnqtW27pDyI8VUEojiXdVrfnbTy1h6O2KDNvm2Fr32HliedMrnEK421WhPXFbJ7
	 Qvk5HtbqY76xqOJ7oOLSrZk7xUqj3+99Ufwgd0BI81ehY3Wv1QIyTMCA3kwDJA86au
	 016UhGyaJJOjfhFBksvSRaLUUTQTtXGklk0JctvM=
Date: Fri, 7 Jun 2024 21:27:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Omar Sandoval
 <osandov@osandov.com>, David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Hao Ge <gehao@kylinos.cn>,
 linux-debuggers@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm: convert page type macros to enum
Message-Id: <20240607212738.bf55318aebd7172fadaa11c5@linux-foundation.org>
In-Reply-To: <20240607202954.1198180-1-stephen.s.brennan@oracle.com>
References: <20240607202954.1198180-1-stephen.s.brennan@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Jun 2024 13:29:53 -0700 Stephen Brennan <stephen.s.brennan@oracle.com> wrote:

> Changing PG_slab from a page flag to a page type in commit 46df8e73a4a3
> ("mm: free up PG_slab") in has the unintended consequence of removing
> the PG_slab constant from kernel debuginfo. The commit does add the
> value to the vmcoreinfo note, which allows debuggers to find the value
> without hardcoding it. However it's most flexible to continue
> representing the constant with an enum. To that end, convert the page
> type fields into an enum. Debuggers will now be able to detect that
> PG_slab's type has changed from enum pageflags to enum pagetype.
> 
> Fixes: 46df8e73a4a3 ("mm: free up PG_slab")

Should we backport this into 6.9.x?

