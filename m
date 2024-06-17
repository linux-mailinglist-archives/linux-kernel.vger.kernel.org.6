Return-Path: <linux-kernel+bounces-218346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2363790BCEE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5462EB21590
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4B01991AF;
	Mon, 17 Jun 2024 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zmL/tEBM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7560B18F2E1;
	Mon, 17 Jun 2024 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718659792; cv=none; b=N/9o86bphvLesYV5vCicCIokjc4dSEhBzJPr3OnUMr3CcIhd9BzY1bQoct2D+jGBgPBp8mwi17a1oT/jd6R01oqrHNwvGO4bjPcvn3YVYUh8k9pEWMld9pTmDBcBqhP7Ba1ReylMSM+qVp9SIEbiQfPfJHvbPpje0kp1X4FVsNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718659792; c=relaxed/simple;
	bh=Ut0KAyrVV4smqcRV54hBWMF2hJaIfY47Llm6WJvhIYM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rCaNbX9KUG7l8gJWw8h1TX/OTAjTlZqxAfyrAdwKXEHPkHG9RQ9A7nQUf7iztSmPDYU4UpK8MB1U7zq749uA4RIBcj8v1LAfsefP5+pGf8FAExGSX7nmN5sJgXhswY57/1rj3EhwKJe1YHkN+oop+/FeIjBNFH/Lw0iehiLaUFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zmL/tEBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6A4C2BD10;
	Mon, 17 Jun 2024 21:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718659792;
	bh=Ut0KAyrVV4smqcRV54hBWMF2hJaIfY47Llm6WJvhIYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=zmL/tEBMrfdGilrS36BdO+Nqc6pivOT+eFsbUpD7PzogUbAj0zq+5VJPNi6yfMJtW
	 jOd8Fi901UZR4AUlpU6QjTv0eYjG/RXPESwadqPOcurAcyoV6Tu4uaM0Hf/dgTJOJW
	 9Jn2l6i4fepY3sAzeD4IDhjRVN4o5gCy1azVLd9U=
Date: Mon, 17 Jun 2024 14:29:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Omar Sandoval
 <osandov@osandov.com>, David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Hao Ge <gehao@kylinos.cn>,
 linux-debuggers@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm: convert page type macros to enum
Message-Id: <20240617142951.08a9cdc791c8edeeca50509b@linux-foundation.org>
In-Reply-To: <87bk3z1f76.fsf@oracle.com>
References: <20240607202954.1198180-1-stephen.s.brennan@oracle.com>
	<20240607212738.bf55318aebd7172fadaa11c5@linux-foundation.org>
	<87ikygo1yb.fsf@oracle.com>
	<87bk3z1f76.fsf@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 13:34:21 -0700 Stephen Brennan <stephen.s.brennan@oracle.com> wrote:

> >>> Fixes: 46df8e73a4a3 ("mm: free up PG_slab")
> >>
> >> Should we backport this into 6.9.x?
> >
> > Hi Andrew,
> >
> > Looks like commit 46df8e73a4a3 ("mm: free up PG_slab") is introduced in
> > the v6.10-rc's, and not backported to 6.9. So PG_slab is still part of
> 
> Hi Andrew,
> 
> I saw that you've merged this into mm-unstable, thank you!
> 
> Since 46df8e73a4a3 ("mm: free up PG_slab") is part of the current 6.10
> RC, it would be great if this patch could be part of the 6.10 release so
> we don't release a kernel missing the PG_slab info.
> 
> Can you confirm if mm-unstable will get merged in this release cycle? Or
> else, would it be possible to include it in a branch that will?

Turns out the patch as sent was based on David's "mm: allow reuse of
the lower 16 bit of the page type with an actual type", which changed
the page flags a lot,  I redid this patch thusly:

--- a/include/linux/page-flags.h~mm-convert-page-type-macros-to-enum
+++ a/include/linux/page-flags.h
@@ -944,15 +944,22 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpois
  * mistaken for a page type value.
  */
 
-#define PAGE_TYPE_BASE	0xf0000000
-/* Reserve		0x0000007f to catch underflows of _mapcount */
-#define PAGE_MAPCOUNT_RESERVE	-128
-#define PG_buddy	0x00000080
-#define PG_offline	0x00000100
-#define PG_table	0x00000200
-#define PG_guard	0x00000400
-#define PG_hugetlb	0x00000800
-#define PG_slab		0x00001000
+enum pagetype {
+	/*
+	 * Reserve 0xffff0000 - 0xfffffffe to catch _mapcount underflows and
+	 * allow owners that set a type to reuse the lower 16 bit for their own
+	 * purposes.
+	 */
+	PG_buddy	= 0x00000080,
+	PG_offline	= 0x00000100,
+	PG_table	= 0x00000200,
+	PG_guard	= 0x00000400,
+	PG_hugetlb	= 0x00000800,
+	PG_slab		= 0x00001000,
+
+	PAGE_TYPE_BASE	= 0xf0000000,
+	PAGE_MAPCOUNT_RESERVE	= -128,
+};
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
_

(please check carefully)

and David's later "mm: allow reuse of the lower 16 bit of the page type
with an actual type" becomes 

 include/linux/mm_types.h   |    5 +++++
 include/linux/page-flags.h |   16 ++++++++--------
 2 files changed, 13 insertions(+), 8 deletions(-)

--- a/include/linux/mm_types.h~mm-allow-reuse-of-the-lower-16-bit-of-the-page-type-with-an-actual-type
+++ a/include/linux/mm_types.h
@@ -157,6 +157,11 @@ struct page {
 		 *
 		 * See page-flags.h for a list of page types which are currently
 		 * stored here.
+		 *
+		 * Owners of typed folios may reuse the lower 16 bit of the
+		 * head page page_type field after setting the page type,
+		 * but must reset these 16 bit to -1 before clearing the
+		 * page type.
 		 */
 		unsigned int page_type;
 
--- a/include/linux/page-flags.h~mm-allow-reuse-of-the-lower-16-bit-of-the-page-type-with-an-actual-type
+++ a/include/linux/page-flags.h
@@ -951,15 +951,15 @@ enum pagetype {
 	 * allow owners that set a type to reuse the lower 16 bit for their own
 	 * purposes.
 	 */
-	PG_buddy	= 0x00000080,
-	PG_offline	= 0x00000100,
-	PG_table	= 0x00000200,
-	PG_guard	= 0x00000400,
-	PG_hugetlb	= 0x00000800,
-	PG_slab		= 0x00001000,
+	PG_buddy	= 0x40000000,
+	PG_offline	= 0x20000000,
+	PG_table	= 0x10000000,
+	PG_guard	= 0x08000000,
+	PG_hugetlb	= 0x04008000,
+	PG_slab		= 0x02000000,
 
-	PAGE_TYPE_BASE	= 0xf0000000,
-	PAGE_MAPCOUNT_RESERVE	= -128,
+	PAGE_TYPE_BASE	= 0x80000000,
+	PAGE_MAPCOUNT_RESERVE	=  (~0x0000ffff),
 };
 
 #define PageType(page, flag)						\
_

and that patch's fixup becomes

--- a/include/linux/page-flags.h~mm-allow-reuse-of-the-lower-16-bit-of-the-page-type-with-an-actual-type-fix
+++ a/include/linux/page-flags.h
@@ -955,7 +955,7 @@ enum pagetype {
 	PG_offline	= 0x20000000,
 	PG_table	= 0x10000000,
 	PG_guard	= 0x08000000,
-	PG_hugetlb	= 0x04008000,
+	PG_hugetlb	= 0x04000000,
 	PG_slab		= 0x02000000,
 
 	PAGE_TYPE_BASE	= 0x80000000,
_

and "mm/zsmalloc: use a proper page type" becomes, in part,

--- a/include/linux/page-flags.h~mm-zsmalloc-use-a-proper-page-type
+++ a/include/linux/page-flags.h
@@ -957,6 +957,7 @@ enum pagetype {
 	PG_guard	= 0x08000000,
 	PG_hugetlb	= 0x04000000,
 	PG_slab		= 0x02000000,
+	PG_zsmalloc	= 0x01000000,
 
 	PAGE_TYPE_BASE	= 0x80000000,
 	PAGE_MAPCOUNT_RESERVE	=  (~0x0000ffff),



and the end result is identical to yesterday's mm-everything so that's
all good.

However I wouldn't want to send the altered version of "mm: convert
page type macros to enum" into 6.10-rcX because it gets so altered by
David's mm-unstable changes for the next merge window.  The new version
of the hotfixes patch won't have had any valid testing on its own.

So I'll temporarily drop David's "mm: page_type, zsmalloc and
page_mapcount_reset()" series from mm-unstable.  To permit the new "mm:
convert page type macros to enum" to get some linux-next exposure. 
David, please remind me to restore that series in a week or so?

