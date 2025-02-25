Return-Path: <linux-kernel+bounces-530344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5C5A43249
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E280F3A8B51
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5E5171CD;
	Tue, 25 Feb 2025 01:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GANMeJBs"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9A82571AA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740445847; cv=none; b=tv2y/fogiB9bxlbslJTitv5f8wXVJrYhfMr2P27ZAGk3EqFWJ7UC37tiDTcHxeCop5L/Jp8fb5kc+qbaIbPEG2r/hXbDbkHg1iBybfQOZWswHKMRVlZTYXnR1clK1ck7pwzoFEoMlPm1k7mwdkW7RNToQZbeOGYJs7X5rHKwvbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740445847; c=relaxed/simple;
	bh=rqYK+dTtvQ6LcS2NEXaOs245twfms/S7WfG5YyQq9Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=JOssOv7S78qXWI0oS/AGjvqN86rqY9qCSe0a90R21f48l8TAnXOOZTUEhdXPdVaycVwG4S/5erVb8fVjU7ImI0ULtatStZVOkJngcj/nLo747w7to14dFRcymP3WN1Ffl4bJpZzBkGjfWPayK6dkGaTb1r4TG+BirX51N0rQFvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GANMeJBs; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250225011041epoutp01c4e80cd272fd2a29303d919e2bde2374~nTkWMNPFK0258502585epoutp01Q
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:10:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250225011041epoutp01c4e80cd272fd2a29303d919e2bde2374~nTkWMNPFK0258502585epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740445841;
	bh=EdONqYoMq0EdSOWUpFdzkynB+zbmHVGaeqB64/2Cyrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GANMeJBs0OInYpBd1nEbLr3LKi+mtASBSbpeNI8+uirVnFSBxDHVHX83y6AUUTkMW
	 udde3IySHIpmnTvgWLln6+AIhS9LHrmi9Rf5mO3iKAUC+FiE1NX2Y4WvG0c4D+T7yE
	 7LVhpaJXJSQCuupbsElSwzPCz4vgG/n7Ag7UIUyw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20250225011040epcas2p3c0c9c2bc082112d1fb56cea3acb6d212~nTkVeh79X1249612496epcas2p3Q;
	Tue, 25 Feb 2025 01:10:40 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.91]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Z200J1tPrz4x9QC; Tue, 25 Feb
	2025 01:10:40 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	65.09.22938.0981DB76; Tue, 25 Feb 2025 10:10:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250225011039epcas2p4d53bff9314b8f446146cec459283cbab~nTkUUPArn0221702217epcas2p4-;
	Tue, 25 Feb 2025 01:10:39 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250225011039epsmtrp295f2b2abd812fef115a2b0e1ef4eed18~nTkUTVboL0152701527epsmtrp2s;
	Tue, 25 Feb 2025 01:10:39 +0000 (GMT)
X-AuditID: b6c32a43-0d1e67000000599a-f8-67bd1890c36f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D2.76.23488.F881DB76; Tue, 25 Feb 2025 10:10:39 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250225011039epsmtip1cfb34258776a7f5eca20a3c46976c10b~nTkUEPieS1676116761epsmtip1h;
	Tue, 25 Feb 2025 01:10:39 +0000 (GMT)
Date: Tue, 25 Feb 2025 10:09:09 +0900
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, janghyuck.kim@samsung.com, Christoph
	Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes
	<rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton
	<akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm: slub: Print the broken data before restoring
 slub.
Message-ID: <20250225010909.GA2345951@tiffany>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <746be93d-7e62-4260-9b3e-0d7c1780c9c7@suse.cz>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmue4Eib3pBt/Wc1hM7DGwmLN+DZvF
	9W9vGC3uL3vGYrGyu5nNYvOcYovLu+awWdxb85/Vou3zPyCxZCOTxcQ1ohazG/sYHXg8ds66
	y+6xYFOpx6ZVnWwemz5NYvfoenuFyePEjN8sHk+uTGfyWNgwldnj49NbLB59W1YxepxZcITd
	4/MmuQCeqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfM
	HKDzlRTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYG
	RqZAhQnZGXcezGItWCJXMXHjbNYGxi6JLkZODgkBE4mJS86ydzFycQgJ7GCUODv3OiNIQkjg
	E6PElx12EPY3RomWNdowDbMnbIeq2csocaHdDqL5KaPEuyf3mEESLAKqEi0zjjKB2GwC6hIn
	tiwDaxARUJF4tOEoK0gDs0A7s8S3UydYQBLCAiESM6evA7N5BfQk7i/YxQ5hC0qcnPkELM4p
	YC0xpeUzE0izhMABDomth3pZIU5ykbh9eikThC0s8er4FnYIW0ri87u9bBB2scS2xYehmhsY
	JTZ33GeGSBhLzHrWDnYes0CmxMs3v4GGcgDFlSWO3GKBCPNJdBz+yw4R5pXoaBOC6FSW2L9s
	HguELSnxaG071DkeEhdObWWFhMomJokdz2axTGCUm4Xkn1lItkHYOhILdn9imwW0gllAWmL5
	Pw4IU1Ni/S79BYysqxjFUguKc9NTk40KDOERnJyfu4kRnJq1nHcwXpn/T+8QIxMH4yFGCQ5m
	JRFezsw96UK8KYmVValF+fFFpTmpxYcYTYGxM5FZSjQ5H5gd8kriDU0sDUzMzAzNjUwNzJXE
	eat3tKQLCaQnlqRmp6YWpBbB9DFxcEo1MLHklXrzlx6xerz99ZFrO/gmJc2aFmdvJXX9eYTw
	5S/qd5x2HFp+MOdk30FL1v+7Pwsd+MCfmGMeYmD3rVH62moxvRPJrOeOzM4PX5L/MGX6RKXC
	mos+d25uOzF3yePTar3xa0Q/WedfZkt6FFm37GfM263u59OmzOORtP569dOUI7s9/+YuVtrm
	1lqc2r5Na+K07l1vzLo/fJ1U97X+f7RbmtHe2+kpomarone2Pvpdd9vqmsbPTZOsP9YssT2S
	lsIRWJX44fD5UKXpC53ymBhqPshPuF2ZKlO/UnvLjB8bFddtWOxyOHFakoSqpnBYplWA8MrP
	il4hqyL2Z3z+eu2j2f2sHIkzQs87Xdeu/X1aiaU4I9FQi7moOBEASNZUbFYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJTrdfYm+6wcwz0hYTewws5qxfw2Zx
	/dsbRov7y56xWKzsbmaz2Dyn2OLyrjlsFvfW/Ge1aPv8D0gs2chkMXGNqMXsxj5GBx6PnbPu
	snss2FTqsWlVJ5vHpk+T2D263l5h8jgx4zeLx5Mr05k8FjZMZfb4+PQWi0ffllWMHmcWHGH3
	+LxJLoAnissmJTUnsyy1SN8ugSvjwi/lgofSFVNuv2JtYHwg2sXIySEhYCIxe8J2xi5GLg4h
	gd2MEmfedDBBJCQlZn0+CWULS9xvOcIKUfSYUeLxxutgCRYBVYmWGUfBbDYBdYkTW5Yxgtgi
	AioSjzYcBWtgFuhmlri1+T8rSEJYIERi5vR1LCA2r4CexP0Fu9ghpm5hklh8eRMjREJQ4uTM
	J2BFzAJaEjf+vQTawAFkS0ss/8cBEuYUsJaY0vKZaQKjwCwkHbOQdMxC6FjAyLyKUTK1oDg3
	PTfZsMAwL7Vcrzgxt7g0L10vOT93EyM4urQ0djC++9akf4iRiYPxEKMEB7OSCC9n5p50Id6U
	xMqq1KL8+KLSnNTiQ4zSHCxK4rwrDSPShQTSE0tSs1NTC1KLYLJMHJxSDUzddaq5sc9/62tM
	+x79Mq/v8r5MgbC+wtavh0/v+/T2T/dnXt9p8fkcC5cejGR9JPr7/gKfqL/Wb6o7Pfh7xTnX
	K2owPrdWf7ul9I6TjZf8xCTlbx9ZDj46YP4xcRVX9p679xsbD/2/F3r45m+h8Hjtvjor25+X
	DV7Gubz/PEW1et1hzz83rYL5nsRu40qo8NsVG7xqq7yht+7GDIFqu7hty6e8z2y4ZeEQeabU
	76bNauFAIXtbHUVZEaYXXt8OHPh6iYMzX9zrgueJ71PeLCi7zuz7IyPu8z6R5zeTWh62dGl+
	Ctr/+65nSKD5cosjaQI//d/MN3bW6W9r8HVmFz+jZXKr5Ok2kVWHBETW5SixFGckGmoxFxUn
	AgCzGmBJHQMAAA==
X-CMS-MailID: 20250225011039epcas2p4d53bff9314b8f446146cec459283cbab
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----RdGIdtKpq9gE1V3j7PuPL63Cok.9YsQMFtrTWahmlx-pp0Iy=_139873_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250220034153epcas2p286194dda687b47a3dec8fb89b868f96f
References: <20250220033953.1606820-1-hyesoo.yu@samsung.com>
	<CGME20250220034153epcas2p286194dda687b47a3dec8fb89b868f96f@epcas2p2.samsung.com>
	<20250220033953.1606820-2-hyesoo.yu@samsung.com> <Z7g2QeQp6HkyqCol@harry>
	<20250224024323.GA2153960@tiffany>
	<746be93d-7e62-4260-9b3e-0d7c1780c9c7@suse.cz>

------RdGIdtKpq9gE1V3j7PuPL63Cok.9YsQMFtrTWahmlx-pp0Iy=_139873_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Feb 24, 2025 at 03:08:55PM +0100, Vlastimil Babka wrote:
> On 2/24/25 03:43, Hyesoo Yu wrote:
> > On Fri, Feb 21, 2025 at 05:16:01PM +0900, Harry Yoo wrote:
> >> On Thu, Feb 20, 2025 at 12:39:43PM +0900, Hyesoo Yu wrote:
> >> > Previously, the restore occured after printing the object in slub.
> >> > After commit 47d911b02cbe ("slab: make check_object() more consistent"),
> >> > the bytes are printed after the restore. This information about the bytes
> >> > before the restore is highly valuable for debugging purpose.
> >> > For instance, in a event of cache issue, it displays byte patterns
> >> > by breaking them down into 64-bytes units. Without this information,
> >> > we can only speculate on how it was broken. Hence the corrupted regions
> >> > should be printed prior to the restoration process. However if an object
> >> > breaks in multiple places, the same log may be output multiple times.
> >> > Therefore the slub log is reported only once to prevent redundant printing,
> >> > by sending a parameter indicating whether an error has occurred previously.
> >> > 
> >> > Changes in v3:
> >> > - Change the parameter type of check_bytes_and_report.
> >> > 
> >> > Changes in v2:
> >> > - Instead of using print_section every time on check_bytes_and_report,
> >> > just print it once for the entire slub object before the restore.
> >> > 
> >> > Signed-off-by: Hyesoo Yu <hyesoo.yu@samsung.com>
> >> > Change-Id: I73cf76c110eed62506643913517c957c05a29520
> >> > ---
> >> >  mm/slub.c | 29 ++++++++++++++---------------
> >> >  1 file changed, 14 insertions(+), 15 deletions(-)
> >> > 
> >> 
> >> > @@ -1212,11 +1213,14 @@ check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
> >> >  	if (slab_add_kunit_errors())
> >> >  		goto skip_bug_print;
> >> >  
> >> > -	slab_bug(s, "%s overwritten", what);
> >> >  	pr_err("0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
> >> >  					fault, end - 1, fault - addr,
> >> >  					fault[0], value);
> >> >  
> >> > +	scnprintf(buf, 100, "%s overwritten", what);
> >> > +	if (slab_obj_print)
> >> > +		object_err(s, slab, object, buf);
> >> 
> >> 
> >> Wait, I think it's better to keep printing "%s overwritten" regardless
> >> of slab_obj_print and only call __slab_err() if slab_obj_print == true
> >> as discussed here [1]? Becuase in case there are multiple errors,
> >> users should know.
> >> 
> >> [1] https://lore.kernel.org/all/2ff52c5e-4b6b-4b3d-9047-f00967315d3e@suse.cz
> >> 
> > 
> > Hi,
> > 
> > __slab_err() doesn't include print_trainer(). It needs object_err().
> 
> print_trailer() could be used directly?
>

object_err calls print_trailer, add_taint and WARN_ON that we need to call here.
I think direct calling is just redundant.

> > How about including the specific error name 'what' to pr_err ?
> > And then object_err would print "Object corrupt" at the beginning once
> > without buf like below.
> 
> Could also work.
> 
> > 	if (slab_obj_print)
> > 		object_err(s, slab, object, "Object corrupt");
> > 
> > 	pr_err("[%s] 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
> >  	       what, fault, end - 1, fault - addr, fault[0], value);
> 
> Probably in opposite order so object_err doesn't panic_on_warn before the
> pr_err?
> 

Yes, I tested and found that logs are not printed when panic_on_warn is enabled.
we first call pr_err and then call object_err.

> > Thanks,
> > Regards.
> >> -- 
> >> Cheers,
> >> Harry
> >> 
> > 
> > 
> 
> 

------RdGIdtKpq9gE1V3j7PuPL63Cok.9YsQMFtrTWahmlx-pp0Iy=_139873_
Content-Type: text/plain; charset="utf-8"


------RdGIdtKpq9gE1V3j7PuPL63Cok.9YsQMFtrTWahmlx-pp0Iy=_139873_--

