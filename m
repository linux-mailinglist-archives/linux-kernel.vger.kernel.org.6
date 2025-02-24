Return-Path: <linux-kernel+bounces-528111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B663A413A7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE893AA176
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FD8199E89;
	Mon, 24 Feb 2025 02:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lckFGeSE"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78BB1A23A4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740365107; cv=none; b=pMgMzpIeBQDb8yo1GP+8ORSCuXEFeMJBr7pLI5vaBjYUcwBpkpPX17FPOzB/ycr0XH3QsGb+yjy41TwgS1hHOOw1ALjbnMGCJhJ9t9qZBGpWTVruLL+NI6rGZaZ10UBDH+d4IVPKUb553LHdcn7UEd9BuYdaDJX1VZv3XqFHOqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740365107; c=relaxed/simple;
	bh=gIvuAsizv4OccMrpbZRQXctJ6ZyhnqJpBjpWH3ek0/s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=K6ZgnbK1PmNmvcWt/yKO/IZCNOkRNutJ262l8E9++XicqmOmY+ERdQjCUmvNrm3TIAVSyp45XYaojJVUlqRgHqe+XZxC8BirHQGox76bNIzEX59+RQpCMR8AyK/a4FvA4hPLFVKfpulJblnTJMruLdB/CSalk503plrQlRaAtpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lckFGeSE; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250224024455epoutp0270d3652abe9551df7b65ed6643d5ae4e~nBNVovgko0634306343epoutp02y
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:44:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250224024455epoutp0270d3652abe9551df7b65ed6643d5ae4e~nBNVovgko0634306343epoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740365095;
	bh=IDjRyZ2SFUCnrvJYVPXNwQBBwEP9C1Vcieg5xe1ZKOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lckFGeSESTSa9ukMw/+i8EX8PBXeYdKUEMtI6Yars2QGlNSPjCnlgxg/jhFwa6i4E
	 jnsIoGmjY6TYrYbeLLDAgyAA3pICnrBnrORR/EENuT0Jj5c743JeiUOmlJr59bUP7y
	 ca9ZwQU1UuyhDw9/0hnuDMvPOqx9bzZYY8BUnyQE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20250224024455epcas2p269c8a732e32defd846b0c908d6e13441~nBNVMrf_Z0302903029epcas2p2R;
	Mon, 24 Feb 2025 02:44:55 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.98]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Z1Q7V42qMz4x9Q7; Mon, 24 Feb
	2025 02:44:54 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	41.B1.23368.62DDBB76; Mon, 24 Feb 2025 11:44:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250224024453epcas2p3ae9f54efec7b6ece6192b2b350150cf1~nBNT-5hZB2996329963epcas2p3k;
	Mon, 24 Feb 2025 02:44:53 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250224024453epsmtrp2779b75680f21c9ef03466d404917cf45~nBNT_8iQ42275022750epsmtrp2R;
	Mon, 24 Feb 2025 02:44:53 +0000 (GMT)
X-AuditID: b6c32a45-dc9f070000005b48-11-67bbdd26b0ad
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B3.7F.23488.52DDBB76; Mon, 24 Feb 2025 11:44:53 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250224024453epsmtip16aa712af71bc77eea18bc0bfe5406be6~nBNTvGvtT1185911859epsmtip1R;
	Mon, 24 Feb 2025 02:44:53 +0000 (GMT)
Date: Mon, 24 Feb 2025 11:43:23 +0900
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
Message-ID: <20250224024323.GA2153960@tiffany>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z7g2QeQp6HkyqCol@harry>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc3rL5eJgubYqR9gIubgZcK0t8rhMIMvm4yaQhYAu02WwO7gp
	pM/0tm7MbANhgGwyqlkqpSFFDWjDQwoq4xFYEUQxhGU6GBnSNQWnEWS8dKhll966+M/J93zP
	+Zzf97wwRDSIhmEFGgOj19AqAt0kvDoQHS95e6pbITvRE06afpCR1tYmlBxffQTI6YZZIXnp
	+xKUbLey5G9dVpS817QeQJYtebnmQpuANDVtJWuLq8B7wdTPlqlAyuYwUg77SZRyLJ4OpCrn
	7gio4bPPhJTnjllA1Rf9hFD/zEwKqaoOO6Bu264HUkuOiIzgo8rkfIbOY/SRjCZXm1egUaQQ
	aVk5H+TEJ8jkEnkSmUhEamg1k0LsS8+QHChQcfGJyGO0yshZGTTLErtTk/Vao4GJzNeyhhSC
	0eWpdIk6KUurWaNGIdUwhnflMllsPDfxM2V++dggoquHXzpL0CLwu7gSBGEQj4MT3S3CSrAJ
	E+GdALY/nkP4ziKAqw+G/COrAJ6orQ18iZTd8voHegG8O1ztR2YANLf9gm7MEuJvwZHmioAN
	jeI74XBHA9jQW/AdcG7IiW4ACL4igGt3x3yAGD8Ea8wbSYKwEFwK3Z5hhNeb4c0aj88P4had
	PzfigyHej8HG0RcIn2kfbP3LhfJaDB/e6PBnDYNL871+n4VXzw8IeLiI22rFtB/eAy2z5b54
	CF4AZ5rPcj7G+VHw+qSQt1+HFQMvAnk7BFaUiXgyCvY11Al5vR26m8sDeE3BsVtXAvhT+ZM7
	yA4rqAYRllf2Y3mlGq/fgbbuRdTClUDwcNjoxXgZDVu7dttAgB1sY3SsWsGwsTr5/1ecq1U7
	gO89x+zvBGfmFqROIMCAE0AMIbaESAydClFIHl34FaPX5uiNKoZ1gnjudkxI2NZcLfchNIYc
	eVySLC4hQZ4YGy9LJEJDjneWKkS4gjYwSobRMfqXnAALCisSyJd7Eqq+taCTUOT+TpomfrJr
	RSkp2fbG84nyZauxZTJjFOyPCl8/mAQu/fF8PTVX3DX1dKE2ZbZ/eGLXjKsw+pq4r95dknk5
	uC45NFf9pgcd6Yd7uz8/73FlSjPHd4Qqx2JKW0wmwULpaGrv5W/e7zNdiZp2Z6/svC0xv5be
	I1qznjqpvgYZm+XrA4ZPjtQcpQ87RZHwwkf6B6zr3/THcm+D0xaRHRx7+ubm6o8bcaow+2nx
	qV+HjJl1U5aCLKYNbB98olIewz7du948fcPgvG9fjtNig88uHtrzt0OfhlPH17zj5oNV9wa+
	SDinqLG7HrXP3/8w60hncX3jwMMfCSGbT8tjED1L/wfAgd2WWAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJTlf17u50g9WLtC0m9hhYzFm/hs3i
	+rc3jBb3lz1jsVjZ3cxmsXlOscXlXXPYLO6t+c9q0fb5H5BYspHJYuIaUYvZjX2MDjweO2fd
	ZfdYsKnUY9OqTjaPTZ8msXt0vb3C5HFixm8WjydXpjN5LGyYyuzx8ektFo++LasYPc4sOMLu
	8XmTXABPFJdNSmpOZllqkb5dAlfGjH1vmQvuiVY8vHiAqYFxjWAXIyeHhICJRNupfyxdjFwc
	QgK7GSWe9k5hhUhISsz6fJIJwhaWuN9yhBWi6DGjxLHlc9lAEiwCqhKn13aANbAJqEuc2LKM
	EcQWEVCReHvsEFgNs8BPJompDZkgtrBAiMTM6etYQGxeAT2JR09OMEMMvccocX3BE2aIhKDE
	yZlPWCCatSRu/HsJdAUHkC0tsfwfB0iYE2jvu0Wn2SYwCsxC0jELSccshI4FjMyrGCVTC4pz
	03OTDQsM81LL9YoTc4tL89L1kvNzNzGCo0tLYwfju29N+ocYmTgYDzFKcDArifDqluxIF+JN
	SaysSi3Kjy8qzUktPsQozcGiJM670jAiXUggPbEkNTs1tSC1CCbLxMEp1cA05bHDf0v33rMT
	EtlvtyhpX5rJzM55wka54rmsYM7v8oaFkh/LKxgWajFO3xm5cMKsyYZBW7OTtty4eW2CrOm5
	JfPup62S7JfW/hjN8fJRt4IU3zbePaEctptUSlum3j6fOd3jwauorVPmXbdu/Z+4NTez2ejq
	yyjj+NZna3PmzP0VXe3Aa65yLTvv1uvVn6QLZNPur5123+uFja/BnqPK/Xvmz+MN035yPN55
	QdGHVcF6bvcWf/v9/dzppsVzuVef3FNxJcAmvVa82W3pnQzB1TkWEidXFyjvv7F6tfyWXSum
	zUp5q8vAZf9uw7ay3z6aihd6RKO17Tvypry0vbDzau+yl+0HtHiUjyRKvz25VImlOCPRUIu5
	qDgRAApYst0dAwAA
X-CMS-MailID: 20250224024453epcas2p3ae9f54efec7b6ece6192b2b350150cf1
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----souVHaJ2v40ysJO-goJgDtKdm5PFoGmT3TNK2tOxyR5.xT_N=_12e1d3_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250220034153epcas2p286194dda687b47a3dec8fb89b868f96f
References: <20250220033953.1606820-1-hyesoo.yu@samsung.com>
	<CGME20250220034153epcas2p286194dda687b47a3dec8fb89b868f96f@epcas2p2.samsung.com>
	<20250220033953.1606820-2-hyesoo.yu@samsung.com> <Z7g2QeQp6HkyqCol@harry>

------souVHaJ2v40ysJO-goJgDtKdm5PFoGmT3TNK2tOxyR5.xT_N=_12e1d3_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Feb 21, 2025 at 05:16:01PM +0900, Harry Yoo wrote:
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
> > ---
> >  mm/slub.c | 29 ++++++++++++++---------------
> >  1 file changed, 14 insertions(+), 15 deletions(-)
> > 
> 
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
> > +	if (slab_obj_print)
> > +		object_err(s, slab, object, buf);
> 
> 
> Wait, I think it's better to keep printing "%s overwritten" regardless
> of slab_obj_print and only call __slab_err() if slab_obj_print == true
> as discussed here [1]? Becuase in case there are multiple errors,
> users should know.
> 
> [1] https://lore.kernel.org/all/2ff52c5e-4b6b-4b3d-9047-f00967315d3e@suse.cz
> 

Hi,

__slab_err() doesn't include print_trainer(). It needs object_err().

How about including the specific error name 'what' to pr_err ?
And then object_err would print "Object corrupt" at the beginning once
without buf like below.

	if (slab_obj_print)
		object_err(s, slab, object, "Object corrupt");

	pr_err("[%s] 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
 	       what, fault, end - 1, fault - addr, fault[0], value);

Thanks,
Regards.
> -- 
> Cheers,
> Harry
> 

------souVHaJ2v40ysJO-goJgDtKdm5PFoGmT3TNK2tOxyR5.xT_N=_12e1d3_
Content-Type: text/plain; charset="utf-8"


------souVHaJ2v40ysJO-goJgDtKdm5PFoGmT3TNK2tOxyR5.xT_N=_12e1d3_--

