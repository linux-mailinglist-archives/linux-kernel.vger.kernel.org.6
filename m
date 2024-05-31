Return-Path: <linux-kernel+bounces-196977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75918D6486
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA25E1C2548E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7C61CAA1;
	Fri, 31 May 2024 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KBTH98bx"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5311CD18
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165685; cv=none; b=T1VzN3DwyjoNwxtcBe3qXjCix2jb1H82nx+OCdOqMm7uuonSwVixOhOq3jtJxuISOXjjoDGzzeCWKouIKKMyil4hIZV4WQIiDu2daHDqF6E53k5LXspbj250BUK1OR+CwRLqzWGWy8SaCxa68lIKfv/JHVJ/s78pXCXdi8FsvVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165685; c=relaxed/simple;
	bh=7hpH3odedZZbPPmIncZVYx6LW4uKLBeFqjxVRPj1sqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYqVJw+xWB5EmVOvV+B00MF+YwtNAp4vFnpCANztfYfndXxKgMDRhtL2iilNzkbRVMmSTAGXDh52wV17WjPWCsWk5x0dtuXR+WR4aAjhVeYcZI2JCtpPtFA2kcWmmbksWK9l5DBbracCkAARCIExhg6jD+Hjb32pETTsXkp6Q8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KBTH98bx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sFxJyQ/io0aHDuu0zh2SmigHrUNsFJB5zun4ic5Vs/g=; b=KBTH98bxJtCBJ4ffi0DXzONGEt
	nkbR1Md7j1pE7pP1L0v0NS63ADdPT51alwW0QmJs1NHFrvvy4BenX/WdA6BIpbP3oClfXyg+ecyFh
	PNsGl6FRM9ajDYokoD7nWPpbKC7SW9lwK2tsjg1/DbTVe01d3N3gahiUvVRmCg1WGx35BEukirKtt
	eI2hw5EWF53rTreEtcYuysiMky73k+IVDspV4WxhIUg7a9ahcNrDTgqc9jedNZb9KnCEd0YXIT9lK
	Pp/nybQIGeFVbNtrPUazk3BhPBnmgbdd52vpFXM0OTXL/FK5+tnZM87xUUmhIcXzdusAJCiLF8Mmt
	X17VLJrg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD3Eb-0000000BmJT-1wAY;
	Fri, 31 May 2024 14:27:57 +0000
Date: Fri, 31 May 2024 15:27:57 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, Minchan Kim <minchan@kernel.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH v2 3/6] mm/zsmalloc: use a proper page type
Message-ID: <ZlnebQ0dRUvx2SgP@casper.infradead.org>
References: <20240529111904.2069608-1-david@redhat.com>
 <20240529111904.2069608-4-david@redhat.com>
 <20240530050123.GA8400@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530050123.GA8400@google.com>

On Thu, May 30, 2024 at 02:01:23PM +0900, Sergey Senozhatsky wrote:
> On (24/05/29 13:19), David Hildenbrand wrote:
> > We won't be able to support 256 KiB base pages, which is acceptable.
> [..]
> > +config HAVE_ZSMALLOC
> > +	def_bool y
> > +	depends on MMU
> > +	depends on PAGE_SIZE_LESS_THAN_256KB # we want <= 64 KiB
> 
> Can't really say that I'm happy with this, but if mm-folks are
> fine then okay.

I have an idea ...

We use 6 of the bits in the top byte of the page_type to enumerate
a type (ie value 0x80-0xbf) and then the remaining 24 bits are
available.  It's actually more efficient:

$ ./scripts/bloat-o-meter prev.o .build-debian/mm/filemap.o 
add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-40 (-40)
Function                                     old     new   delta
__filemap_add_folio                         1102    1098      -4
filemap_unaccount_folio                      455     446      -9
replace_page_cache_folio                     474     447     -27
Total: Before=41258, After=41218, chg -0.10%

(that's all from PG_hugetlb)

before:
    1406:       8b 46 30                mov    0x30(%rsi),%eax
                mapcount = atomic_read(&folio->_mapcount) + 1;
    1409:       83 c0 01                add    $0x1,%eax
                if (mapcount < PAGE_MAPCOUNT_RESERVE + 1)
    140c:       83 f8 81                cmp    $0xffffff81,%eax
    140f:       7d 6c                   jge    147d <filemap_unaccount_folio+0x8d>
    1411:       8b 43 30                mov    0x30(%rbx),%eax
    1414:       25 00 08 00 f0          and    $0xf0000800,%eax
    1419:       3d 00 00 00 f0          cmp    $0xf0000000,%eax
    141e:       74 4e                   je     146e <filemap_unaccount_folio+0x7e>

after:
    1406:       8b 46 30                mov    0x30(%rsi),%eax
                mapcount = atomic_read(&folio->_mapcount) + 1;
    1409:       83 c0 01                add    $0x1,%eax
                if (mapcount < PAGE_MAPCOUNT_RESERVE + 1)
    140c:       83 f8 81                cmp    $0xffffff81,%eax
    140f:       7d 63                   jge    1474 <filemap_unaccount_folio+0x8
4>
        if (folio_test_hugetlb(folio))
    1411:       80 7b 33 84             cmpb   $0x84,0x33(%rbx)
    1415:       74 4e                   je     1465 <filemap_unaccount_folio+0x75>

so we go from "mov, and, cmp, je" to just "cmpb, je", which must surely
be faster to execute as well as being more compact in the I$ (6 bytes vs 15).

Anyway, not tested but this is the patch I used to generate the above.
More for comment than application.

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5265b3434b9e..4129d04ac812 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -942,24 +942,24 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
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
-
-#define PageType(page, flag)						\
-	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
-#define folio_test_type(folio, flag)					\
-	((folio->page.page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
+/* Reserve             0x0000007f to catch underflows of _mapcount */
+#define PAGE_MAPCOUNT_RESERVE  -128
+
+#define PG_buddy	0x80
+#define PG_offline	0x81
+#define PG_table	0x82
+#define PG_guard	0x83
+#define PG_hugetlb	0x84
+#define PG_slab		0x85
+
+#define PageType(page, type)						\
+	(((page)->page_type >> 24) == type)
+#define folio_test_type(folio, type)					\
+	(((folio)->page.page_type >> 24) == type)
 
 static inline int page_type_has_type(unsigned int page_type)
 {
-	return (int)page_type < PAGE_MAPCOUNT_RESERVE;
+	return ((int)page_type < 0) && (page_type < 0xc0000000);
 }
 
 static inline int page_has_type(const struct page *page)
@@ -975,12 +975,12 @@ static __always_inline bool folio_test_##fname(const struct folio *folio)\
 static __always_inline void __folio_set_##fname(struct folio *folio)	\
 {									\
 	VM_BUG_ON_FOLIO(!folio_test_type(folio, 0), folio);		\
-	folio->page.page_type &= ~PG_##lname;				\
+	folio->page.page_type = PG_##lname << 24;			\
 }									\
 static __always_inline void __folio_clear_##fname(struct folio *folio)	\
 {									\
 	VM_BUG_ON_FOLIO(!folio_test_##fname(folio), folio);		\
-	folio->page.page_type |= PG_##lname;				\
+	folio->page.page_type = 0xffffffff;				\
 }
 
 #define PAGE_TYPE_OPS(uname, lname, fname)				\
@@ -992,12 +992,12 @@ static __always_inline int Page##uname(const struct page *page)		\
 static __always_inline void __SetPage##uname(struct page *page)		\
 {									\
 	VM_BUG_ON_PAGE(!PageType(page, 0), page);			\
-	page->page_type &= ~PG_##lname;					\
+	page->page_type = PG_##lname << 24;				\
 }									\
 static __always_inline void __ClearPage##uname(struct page *page)	\
 {									\
 	VM_BUG_ON_PAGE(!Page##uname(page), page);			\
-	page->page_type |= PG_##lname;					\
+	page->page_type = 0xffffffff;					\
 }
 
 /*

