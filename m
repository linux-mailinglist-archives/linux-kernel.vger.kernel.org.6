Return-Path: <linux-kernel+bounces-524776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC12A3E6FB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CDAE3BA699
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D24A1EF0AE;
	Thu, 20 Feb 2025 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YTy2TBVC"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861691EA7ED
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740088240; cv=none; b=f4kAS39v1la2wbKeE2pOBba5TkpKgWjc70tvFVEnzZhq6ajhD6vg40M4v5YGB+BT+T8xkOyHnaF9xm+woXOb6+Tcp/Xr2W2XKmT3sDXV9A1pmFQB1fYLKUPzIZm5NNC9Gx09/XNUHVm/26drEImYxVPjsW1+iqTfzsHtQxnkRXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740088240; c=relaxed/simple;
	bh=fr1hGc0vDLQUmpGdlBBC3TsNjFtQ1B0Hq/qKa2PlI0U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=qreKXcDCOf7SSVaNT+IqnFIpdF0CYJE6vZB6FR2LpqVDi8uf+53wRQd5yDgWQXczdmV2lSHfH8vMNEA730E5E3Z6i6XDq23/MbsOlCUJ2gp0pLdE3tDMXZzL+dZFToHe+orFJ/NLe4AJil11c6HanOz431sbUfRZHet/Cq27Fng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YTy2TBVC; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250220215035epoutp0116ccbc8ab8a1bafc869fb73d48a2bcf9~mCQfUtMdu0818708187epoutp01P
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 21:50:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250220215035epoutp0116ccbc8ab8a1bafc869fb73d48a2bcf9~mCQfUtMdu0818708187epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740088235;
	bh=ZxIkNIdFMGqUJaSZawzJpuNu+j+SCPH8m0XekEsle1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YTy2TBVCj6/1wi7KjihshUesIqv22U2Nh3405xxDu7t+c4fy+6Fv+1BFKYVjl9BUX
	 5Eq77SF5hzgKBLk75ZeE44amns5CybTX5V9JGwOPTlLR+q9r3I7SIfx0veA2gJDqK2
	 iySQ9pNiTr454pwnbgswncZDbRxqwqlnUGzX5F8g=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20250220215034epcas2p44048ae7ff2398344c7109c347a15faea~mCQeoeMcG2049320493epcas2p4K;
	Thu, 20 Feb 2025 21:50:34 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.97]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YzRlG1CyBz4x9Pv; Thu, 20 Feb
	2025 21:50:34 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	1D.A4.22105.AA3A7B76; Fri, 21 Feb 2025 06:50:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250220215032epcas2p3c8635ea4e8948b8e4621a818664ba26b~mCQc6uf3_1045010450epcas2p3V;
	Thu, 20 Feb 2025 21:50:32 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250220215032epsmtrp189e41f8ab5c93d44e9e0ff50259ee010~mCQc55cfL0493604936epsmtrp1H;
	Thu, 20 Feb 2025 21:50:32 +0000 (GMT)
X-AuditID: b6c32a47-fd1c970000005659-fd-67b7a3aa68fb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FD.64.18949.8A3A7B76; Fri, 21 Feb 2025 06:50:32 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250220215032epsmtip2adcac8532ab4a0d663cc4f5d672bb34c~mCQcp26oi2747127471epsmtip2F;
	Thu, 20 Feb 2025 21:50:32 +0000 (GMT)
Date: Fri, 21 Feb 2025 06:49:04 +0900
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: janghyuck.kim@samsung.com, vbabka@suse.cz, Christoph Lameter
	<cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes
	<rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton
	<akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm: slub: Print the broken data before restoring
 slub.
Message-ID: <20250220214904.GA1820313@tiffany>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z7cLpWNXSbuKKjpQ@harry>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGJsWRmVeSWpSXmKPExsWy7bCmme6qxdvTDe7+YraY2GNgMWf9GjaL
	69/eMFrcX/aMxWJldzObxeY5xRaXd81hs7i35j+rRdvnf0BiyUYmi4lrRC1mN/YxOvB47Jx1
	l91jwaZSj02rOtk8Nn2axO7R9fYKk8eJGb9ZPJ5cmc7ksbBhKrPHx6e3WDz6tqxi9Diz4Ai7
	x+dNcgE8Udk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6Z
	OUDnKymUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0M
	jEyBChOyM/r+9bMUrFOq6G95ztrA+F+qi5GTQ0LARGLumjtMXYxcHEICOxgl/jY1s0I4nxgl
	7s7ZwgbhfGOUmLG/hRGm5eWulVCJvYwS7xafZYZwnjJKzFr9jRWkikVAVeLbn36wDjYBdYkT
	W5aB2SICKhJvjx0C62YW+Mok8evqBTaQhLBAiMTM6etYQGxeAT2JaRPvM0HYghInZz4Bi3MC
	DZ3SMZcRpFlC4ACHxK7zn1ghbnKRWHPrPROELSzx6vgWdghbSuJlfxuUXSyxbfFhJojmBkaJ
	zR33mSESxhKznrWDnccskCmxbP00oAYOoLiyxJFbLBBhPomOw3+hwrwSHW1CEJ3KEvuXzWOB
	sCUlHq1thzrHQ+LCqa3QgLzDKLHuyASWCYxys5D8MwvJNghbR2LB7k9ss4BWMAtISyz/xwFh
	akqs36W/gJF1FaNYakFxbnpqsVGBMTyOk/NzNzGCE7SW+w7GGW8/6B1iZOJgPMQowcGsJMLb
	Vr8lXYg3JbGyKrUoP76oNCe1+BCjKTB2JjJLiSbnA3NEXkm8oYmlgYmZmaG5kamBuZI4b/WO
	lnQhgfTEktTs1NSC1CKYPiYOTqkGplmP/7Xc2BvjnrJn0+H3L0MOM5/T31Hw1XGOcRWP51f3
	vo0b9wiEuO+y/nrJav6XEw7JW0xuN3JuDInX/f4nNq/e6aSiurHjXX1eU8d0jyPrT3jGx05I
	XXpz94k3/OY/NN/+VVs5q8gnjS+bMeFp36YPuxe+4O474VquzpKjMtu7lveoV6frBcGlL40T
	NNb++nZMRzTji2J6/uNr1YlmpqK9le8e7WWIi1i06dTpo5sXHBLRW7pPwf6+S6rjmsRbYkEe
	k/J//plQ7RT5p/Hg3W0TbNjcO9NbT+tET/A1Kc5pfZoy6cyCU/P/rbQ04RPpiGHd9uDfnflO
	Ur/+SUwqlvfRYk8Lznw+md1HY7PRGSWW4oxEQy3mouJEAFl/Xm5ZBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJXnfF4u3pBjd+yFtM7DGwmLN+DZvF
	9W9vGC3uL3vGYrGyu5nNYvOcYovLu+awWdxb85/Vou3zPyCxZCOTxcQ1ohazG/sYHXg8ds66
	y+6xYFOpx6ZVnWwemz5NYvfoenuFyePEjN8sHk+uTGfyWNgwldnj49NbLB59W1YxepxZcITd
	4/MmuQCeKC6blNSczLLUIn27BK6Mi4uvsRe8lK94+3IhSwPjVYkuRk4OCQETiZe7VrJ1MXJx
	CAnsZpS4NG8bK0RCUmLW55NMELawxP2WI6wQRY8ZJbY0PQMrYhFQlfj2p58RxGYTUJc4sWUZ
	mC0ioCLx9tghNhCbWeAnk8TUhkwQW1ggRGLm9HUsIDavgJ7EtIn3wRYICdxjlHi0XRYiLihx
	cuYTFoheLYkb/14C1XAA2dISy/9xgIQ5gdZO6ZjLOIFRYBaSjllIOmYhdCxgZF7FKJlaUJyb
	nltsWGCUl1quV5yYW1yal66XnJ+7iREcW1paOxj3rPqgd4iRiYPxEKMEB7OSCG9b/ZZ0Id6U
	xMqq1KL8+KLSnNTiQ4zSHCxK4rzfXvemCAmkJ5akZqemFqQWwWSZODilGpjE/hxovfNrP+OR
	OLs9qdzZSW1r5pzvN7u6OmGj1rJg7tyfyxZc4OGuXycdJhzz4wZPybxTil7fF1z8/vTV1Y5Y
	qZ5XzXWLA7YvCeSasFayK5618f2fxnNJebGHOUt7N2XZnPh16az32XyRRy/C2ywLeOs7at/2
	nD6390LL2vKLPZGfJohM7dr6pMH07PQtlz77GHBxH3xw4UnhHT7FW9U7dofW7jjxJb/gs7Z3
	j+Sf9n0Fx1UWvMmX/ZZj6aXyzTd459M4/4mhDSdm7PNLuL7g1qbmO+1KMl0fDokFHraeG5p7
	+HPrroJSpd/rlU7dF58ry1TwrmDm6rORhqVWKU/PrXN5uujixGlPLPLZM44EKrEUZyQaajEX
	FScCAPoaBzccAwAA
X-CMS-MailID: 20250220215032epcas2p3c8635ea4e8948b8e4621a818664ba26b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----2jehmUjxW0Gkbg46_GefLyBaSre4jpBnLPH4I-DC_hWbz.jz=_11514c_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250220034153epcas2p286194dda687b47a3dec8fb89b868f96f
References: <20250220033953.1606820-1-hyesoo.yu@samsung.com>
	<CGME20250220034153epcas2p286194dda687b47a3dec8fb89b868f96f@epcas2p2.samsung.com>
	<20250220033953.1606820-2-hyesoo.yu@samsung.com> <Z7cLpWNXSbuKKjpQ@harry>

------2jehmUjxW0Gkbg46_GefLyBaSre4jpBnLPH4I-DC_hWbz.jz=_11514c_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Feb 20, 2025 at 08:01:57PM +0900, Harry Yoo wrote:
> On Thu, Feb 20, 2025 at 12:39:43PM +0900, Hyesoo Yu wrote:
> > Previously, the restore occured after printing the object in slub.
> > After commit 47d911b02cbe ("slab: make check_object() more consistent"),
> > the bytes are printed after the restore. This information about the bytes
> > before the restore is highly valuable for debugging purpose.
> > For instance, in a event of cache issue, it displays byte patterns
> > by breaking them down into 64-bytes units. Without this information,
> > we can only speculate on how it was broken. Hence the corrupted regions
> > should be printed prior to the restoration process. However if an object
> > breaks in multiple places, the same log may be output multiple times.
> > Therefore the slub log is reported only once to prevent redundant printing,
> > by sending a parameter indicating whether an error has occurred previously.
> > 
> > Changes in v3:
> > - Change the parameter type of check_bytes_and_report.
> > 
> > Changes in v2:
> > - Instead of using print_section every time on check_bytes_and_report,
> > just print it once for the entire slub object before the restore.
> >
> > Signed-off-by: Hyesoo Yu <hyesoo.yu@samsung.com>
> > Change-Id: I73cf76c110eed62506643913517c957c05a29520
> 
> As previously mentioned by others, Change-Id is not used in Linux
> kernel development.
>

Oops, It is my mistake. I will remove it.

> > ---
> >  mm/slub.c | 29 ++++++++++++++---------------
> >  1 file changed, 14 insertions(+), 15 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index b3969d63cc04..de62fed12236 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -1192,12 +1192,13 @@ static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
> >  
> >  static pad_check_attributes int
> >  check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
> > -		       u8 *object, char *what,
> > -		       u8 *start, unsigned int value, unsigned int bytes)
> > +		       u8 *object, char *what, u8 *start, unsigned int value,
> > +		       unsigned int bytes, bool slab_obj_print)
> >  {
> >  	u8 *fault;
> >  	u8 *end;
> >  	u8 *addr = slab_address(slab);
> > +	char buf[100];
> >  
> >  	metadata_access_enable();
> >  	fault = memchr_inv(kasan_reset_tag(start), value, bytes);
> > @@ -1212,11 +1213,14 @@ check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
> >  	if (slab_add_kunit_errors())
> >  		goto skip_bug_print;
> >  
> > -	slab_bug(s, "%s overwritten", what);
> >  	pr_err("0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
> >  					fault, end - 1, fault - addr,
> >  					fault[0], value);
> >  
> > +	scnprintf(buf, 100, "%s overwritten", what);
> 
> How about moving this into the if block and changing 100 to sizeof(buf)?
>

That sounds good. I will change it.

> > +	if (slab_obj_print)
> > +		object_err(s, slab, object, buf);
> > +
> >  skip_bug_print:
> >  	restore_bytes(s, what, value, fault, end);
> >  	return 0;
> > @@ -1279,7 +1283,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
> >  		return 1;
> >  
> >  	return check_bytes_and_report(s, slab, p, "Object padding",
> > -			p + off, POISON_INUSE, size_from_object(s) - off);
> > +			p + off, POISON_INUSE, size_from_object(s) - off, true);
> >  }
> >  
> >  /* Check the pad bytes at the end of a slab page */
> > @@ -1329,11 +1333,11 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
> >  
> >  	if (s->flags & SLAB_RED_ZONE) {
> >  		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
> > -			object - s->red_left_pad, val, s->red_left_pad))
> > +			object - s->red_left_pad, val, s->red_left_pad, !!ret))
> 
> I think you don't have to add !! to ret.
> Converting from int to _Bool is legal in C99 and it will work as intended. 
> 

Thank you for informing me.
I remove !! to next version.

Thanks,
Regards.

> > 			ret = 0;
> 
> -- 
> Cheers,
> Harry
> 





------2jehmUjxW0Gkbg46_GefLyBaSre4jpBnLPH4I-DC_hWbz.jz=_11514c_
Content-Type: text/plain; charset="utf-8"


------2jehmUjxW0Gkbg46_GefLyBaSre4jpBnLPH4I-DC_hWbz.jz=_11514c_--

