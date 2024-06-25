Return-Path: <linux-kernel+bounces-229794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA9C917446
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613DA1C2309F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ED417F370;
	Tue, 25 Jun 2024 22:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XkL+wqeX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F12149C6E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 22:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719354819; cv=none; b=LQ0uiI7Ixfhh2A+HAUj/FrV/w8kYzq1vKdr1yHZud8Ysq6URbxi3OEwMtq73vtXIMI+e2FisGgTGWGQt4uJCbuGhfIQXYylBcdJnBR13oMex7pcjjn7B6MCJqiVChKyjudaApq4qF36i/lsUentGwe/k/68J5+r4NydEfwFlaG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719354819; c=relaxed/simple;
	bh=zgEpi1akIXE1YRGDNS0N+7CEyHpfnfTeMTlKCJLtUdc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NXF+rjl5s9EubU0RSKYPf4eFkOHXNN10xl6wvZ9e0/QwgJOL1w6/f/kSRN48ZTu+1SSLcotc7ASvTxZkjbXFfXBa/FSI+WpOB+VdjzYfxg7yUIONwP06FPHSRV4X1wOOWvCLto59Yh5eod8VUpXntcm/ZN5cfDLm1X9Fv4kxPvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XkL+wqeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80B6C32781;
	Tue, 25 Jun 2024 22:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719354819;
	bh=zgEpi1akIXE1YRGDNS0N+7CEyHpfnfTeMTlKCJLtUdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XkL+wqeXq+QtvK3TnB/VUUBwmFtPbvn8/HrJSnhIUrVJxgDrS52Pcz5QoXkXJgpQQ
	 Cl6a9ul1dmOxu2ZxUYoijuyZFBzmClMdWVTczEfJWa+tOBCkQZox2KoOBRpAfOtMxN
	 82oJtsjJEektBFMs0cMUXM6zuL7oblIYkmSVrLsE=
Date: Tue, 25 Jun 2024 15:33:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>, Minchan Kim
 <minchan@kernel.org>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH v2 3/6] mm/zsmalloc: use a proper page type
Message-Id: <20240625153338.8a4d049857d59e692a0d31e6@linux-foundation.org>
In-Reply-To: <345161ac-3b42-48aa-ab3d-3b183316479a@redhat.com>
References: <20240529111904.2069608-1-david@redhat.com>
	<20240529111904.2069608-4-david@redhat.com>
	<20240530050123.GA8400@google.com>
	<ZlnebQ0dRUvx2SgP@casper.infradead.org>
	<345161ac-3b42-48aa-ab3d-3b183316479a@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2024 16:32:04 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 31.05.24 16:27, Matthew Wilcox wrote:
> > On Thu, May 30, 2024 at 02:01:23PM +0900, Sergey Senozhatsky wrote:
> >      1409:       83 c0 01                add    $0x1,%eax
> >                  if (mapcount < PAGE_MAPCOUNT_RESERVE + 1)
> >      140c:       83 f8 81                cmp    $0xffffff81,%eax
> >      140f:       7d 63                   jge    1474 <filemap_unaccount_folio+0x8
> > 4>
> >          if (folio_test_hugetlb(folio))
> >      1411:       80 7b 33 84             cmpb   $0x84,0x33(%rbx)
> >      1415:       74 4e                   je     1465 <filemap_unaccount_folio+0x75>
> > 
> > so we go from "mov, and, cmp, je" to just "cmpb, je", which must surely
> > be faster to execute as well as being more compact in the I$ (6 bytes vs 15).
> > 
> > Anyway, not tested but this is the patch I used to generate the above.
> > More for comment than application.
> 
> Right, it's likely very similar to my previous proposal to use 8 bit 
> (uint8_t) for the type.
> 
> https://lore.kernel.org/all/00ba1dff-7c05-46e8-b0d9-a78ac1cfc198@redhat.com/
> 
> I would prefer if we would do that separately; unless someone is able to 
> raise why we care about zram + 256KiB that much right now. (claim: we don't)
> 

iow, "this is ok for now", yes?

I'd like to push this into mm-"stable" later this week.  Speak now or
forever hold your pieces.

