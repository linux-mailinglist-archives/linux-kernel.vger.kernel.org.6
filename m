Return-Path: <linux-kernel+bounces-372505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E46AB9A498A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 00:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DE71C22191
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4942A190462;
	Fri, 18 Oct 2024 22:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NbbE2xBt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B36186616
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 22:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729289604; cv=none; b=IskSc7vT+ndeGeW7KgaTkUksGYr4Ja1Gj/Ok6XYYYeBA9IsGxY/iJgkrezUeoUwNRH/8LoNrVV26W+bPKtrtLjAp8AlynY69Y2WLCAQGwjzhdQmLtu+s8v37kSywB7X3S17/JpX59Mh6AMENEIdI6pb4Q9rv1IteWrrRE/0xlrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729289604; c=relaxed/simple;
	bh=01IippBy04t2PnhWclHzU84lCUJ4MEoU2qZzB54Kk3I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VxxJELQDuwN00kyAwWl3scXb7MLrqEc9f5wBZg+33bTME3l977DFPWUSp06NtJ1b0uO2krXLoS5qeY2Qyx5wXqcMfLvB74bt90/s4tl5MitNm9Xx67+yJU9QZzRi7epuU6E3IfomipfN3jOF7FBKXyJdhsCv9NqVy1awEsLy6kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NbbE2xBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF41C4CEC3;
	Fri, 18 Oct 2024 22:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729289604;
	bh=01IippBy04t2PnhWclHzU84lCUJ4MEoU2qZzB54Kk3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NbbE2xBtvFbyUppE3xnM9F3QMsSQDhExFI2nknwOOWChmRcUm4/D4QAL1AnyzLiP2
	 xgIYwRMyZliOZotwlQH6Jkau+rQsK52EJcixQKFnd4m1f/WwzhAUNXZyzQaC/kSxHh
	 WinWCDyERV1Xb+BLrpP2C+rhj/NKxsV1ezAAfT2U=
Date: Fri, 18 Oct 2024 15:13:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Alistair Popple
 <apopple@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig
 <hch@infradead.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie
 <airlied@redhat.com>, David Hildenbrand <david@redhat.com>, Dongwon Kim
 <dongwon.kim@intel.com>, Gerd Hoffmann <kraxel@redhat.com>, Hugh Dickins
 <hughd@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Junxiao Chang
 <junxiao.chang@intel.com>, Mike Kravetz <mike.kravetz@oracle.com>, Minchan
 Kim <minchan@kernel.org>, Oscar Salvador <osalvador@suse.de>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, Peter Xu <peterx@redhat.com>, Shigeru
 Yoshida <syoshida@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH v2 0/2] mm/gup: stop leaking pinned pages in low memory
 conditions
Message-Id: <20241018151322.6dd3e6ccbbe73599f70179d4@linux-foundation.org>
In-Reply-To: <20241018011711.183642-1-jhubbard@nvidia.com>
References: <20241018011711.183642-1-jhubbard@nvidia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Oct 2024 18:17:09 -0700 John Hubbard <jhubbard@nvidia.com> wrote:

I added cc:stable to both of these.  Which might be inappropriate since
"patch #2 is not really required".

>   mm/gup: stop leaking pinned pages in low memory conditions

Fixes: 24a95998e9ba ("mm/gup.c: simplify and fix check_and_migrate_movable_pages() return codes")

In mainline since v6.1!

>   mm/gup: memfd: stop leaking pinned pages in low memory conditions

Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")

Since v6.11.


So these are quite independent fixes.  Kernels 6.1.x ...  6.10.x will
have the first patch and not the second.  That's presumably an untested
combination, fingers crossed.



