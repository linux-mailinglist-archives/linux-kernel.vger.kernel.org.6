Return-Path: <linux-kernel+bounces-528112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DF8A413A8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFEBC169B60
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3841624EB;
	Mon, 24 Feb 2025 02:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iLyWyQBr"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F3E4430
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740365204; cv=none; b=T0AOA5L6zX7kzoXunAhYRNvADPxC+iAnCokOhow+aAyuQMLmPeggnf+EdU6j3MUjRABvWjG+ESW3lnp3ipeSHBJqV359eRh4ecepITrx6QsSPfPSvLQM3KiLnCykWno5rxpxR5HHlmgEOR2jxJOF4DOyjiMLVh75N3CcDZHYlDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740365204; c=relaxed/simple;
	bh=J+6Gds2G6zU2eiV77k0cnAbFvcXvEbxDN2tg5IHW2KI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=kVCq1JAlqpqPb3j7a2tHf95/a/sLWUjy6jZt6qUeXNC8kzN2LNLFEqenNRNE3uq0RI2BACG6oM8SwTV2REKebx1tw67W6DDRwggTSEVjO+VW9HJ5RIGpL7ZOAcyiBO+lUl4T8yiAuWJtXI9wEU2K9M0bAC8XSxFnU6ZzmsxGWds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iLyWyQBr; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250224024640epoutp02be75edc4e2a8c87abcdcae18404e9fa2~nBO3QpMTO0925909259epoutp02J
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:46:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250224024640epoutp02be75edc4e2a8c87abcdcae18404e9fa2~nBO3QpMTO0925909259epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740365200;
	bh=RseA9vRLicI2hZtcPLQnaq9yqG3Xe6FVC7uCnuf+cbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iLyWyQBrmIjejZf2EFbu0oEG7yw9atAXj1tCtcjiH7rDP1I9zBWcfoxmigEFTd5Up
	 5HVRG6b698BMWYiA3XIrplc+rUeiv1y5u6Zb/+qBWeF7emhUYlK1ndl7KnhssKj0Xs
	 N/KgH3qdNtXRS+rUOyVETlTHxIbrVXZAAKT0QFJ8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20250224024639epcas2p3fc88412e50c73bcf1d4a4ce63256e2b5~nBO2zX1ZW0307003070epcas2p3E;
	Mon, 24 Feb 2025 02:46:39 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.69]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Z1Q9W4D0Xz4x9Pw; Mon, 24 Feb
	2025 02:46:39 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	A4.52.23368.F8DDBB76; Mon, 24 Feb 2025 11:46:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20250224024639epcas2p13f0d1fb193b771a4e7507175278ca036~nBO2I1eSx1571215712epcas2p1D;
	Mon, 24 Feb 2025 02:46:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250224024639epsmtrp20ffa7b505cdbb78437f10b881bc7950b~nBO2IHVcq2394423944epsmtrp2A;
	Mon, 24 Feb 2025 02:46:39 +0000 (GMT)
X-AuditID: b6c32a45-dc9f070000005b48-c2-67bbdd8ff7ee
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8C.31.18729.F8DDBB76; Mon, 24 Feb 2025 11:46:39 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250224024638epsmtip12c42eedce9e75d3493a8d6cdcb9e3ef1~nBO15k2Tx1038710387epsmtip1J;
	Mon, 24 Feb 2025 02:46:38 +0000 (GMT)
Date: Mon, 24 Feb 2025 11:45:12 +0900
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: janghyuck.kim@samsung.com, vbabka@suse.cz, Christoph Lameter
	<cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes
	<rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton
	<akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm: slub: call WARN() when the slab detect an
 error
Message-ID: <20250224024512.GB2153960@tiffany>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z7g5wyjsP1ktucDO@harry>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmuW7/3d3pBs33FCwm9hhYzFm/hs3i
	+rc3jBb3lz1jsVjZ3cxmsXlOscXlXXPYLO6t+c9q0fb5H5BYspHJYuIaUYvZjX2MDjweO2fd
	ZfdYsKnUY9OqTjaPTZ8msXt0vb3C5HFixm8WjydXpjN5LGyYyuzx8ektFo++LasYPc4sOMLu
	8XmTXABPVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+Arltm
	DtD5SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMD
	I1OgwoTsjD+tp1gLpohVXOuzb2C8K9jFyMkhIWAicXjqatYuRi4OIYEdjBK/Z05kg3A+MUo8
	OfeJHcL5xiixZkITK0zL9jsfwGwhgb2MEjO/S0IUPWWU+Pb+MztIgkVAVWL39onMIDabgLrE
	iS3LGEFsEQEVibfHDoGtYBb4yiTx6+oFNpCEsECgxP+O1WBTeQX0JO5t+sUMYQtKnJz5hAXE
	5gQa2n12KlizhMABDommXZNZIE5ykTix8ReULSzx6vgWdghbSuLzu71sEHaxxLbFh5kgmhsY
	JTZ33GeGSBhLzHrWDnQeB9BJmRJvX1SAmBICyhJHboGNZBbgk+g4/JcdIswr0dEmBNGoLLF/
	2TyorZISj9a2QwPIQ+LxwtVMkEC5wyix4mkr8wRGuVlI3pmFsGwW2AYdiQW7P7FBhKUllv/j
	gDA1Jdbv0l/AyLqKUSy1oDg3PbXYqMAQHr/J+bmbGMGJWct1B+Pktx/0DjEycTAeYpTgYFYS
	4dUt2ZEuxJuSWFmVWpQfX1Sak1p8iNEUGDcTmaVEk/OBuSGvJN7QxNLAxMzM0NzI1MBcSZy3
	ekdLupBAemJJanZqakFqEUwfEwenVAPThuRJYU9WP2ewOHjgl1DiiZ8KRs0J/f+Syq78Xzbx
	WYi5zZz9Z/Mj1ts9eq9cE3ZGIj4xRcjQ62PkjZvRul8TsyTm1Rk82fbuU1/Tk2XhIgvbfwbx
	FbpWiwvMs+IOZjorZSoV5SNxfHevqr/2Zm+JS8d+yZ7vVrkrevPs/khehessy1Iv1q8RW9PZ
	c+yetcU6qWpJ462K9uHsyzezKr+SuVKpKFDk0H+A+falrFc/tBZbnd33uGji5Fnvcu7+Oyiz
	KCdUapPQqiubN50PDOM4fJhpoVtGvKv2/0mBXhKGBz+/Om05x1T3n16cxd4PEj2+a78LLd0b
	XurEknDB9OmMDDO+E2VSU/+ZbO95eU1biaU4I9FQi7moOBEAtNHdr1UEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJTrf/7u50g2097BYTewws5qxfw2Zx
	/dsbRov7y56xWKzsbmaz2Dyn2OLyrjlsFvfW/Ge1aPv8D0gs2chkMXGNqMXsxj5GBx6PnbPu
	snss2FTqsWlVJ5vHpk+T2D263l5h8jgx4zeLx5Mr05k8FjZMZfb4+PQWi0ffllWMHmcWHGH3
	+LxJLoAnissmJTUnsyy1SN8ugSvjzfpV7AUXhSte3b/I2MC4mb+LkZNDQsBEYvudD6xdjFwc
	QgK7GSUmn1zLCJGQlJj1+SQThC0scb/lCFTRY0aJ5qmLmEESLAKqEru3TwSz2QTUJU5sWQbW
	LCKgIvH22CE2EJtZ4CeTxNSGTBBbWCBQ4n/HalYQm1dAT+Lepl/MEEPvMUrc71/HBpEQlDg5
	8wkLRLOWxI1/L4Gu4ACypSWW/+MACXMC7e0+O5VtAqPALCQds5B0zELoWMDIvIpRMrWgODc9
	t9iwwDAvtVyvODG3uDQvXS85P3cTIzi6tDR3MG5f9UHvECMTB+MhRgkOZiURXt2SHelCvCmJ
	lVWpRfnxRaU5qcWHGKU5WJTEecVf9KYICaQnlqRmp6YWpBbBZJk4OKUamKrsjmxSVptsfER/
	2plHmVYH+gpu+Py/rMP265uuWNWGJVsTSp5esDp1Zn4yV4I7w0nZpfITrsT4SATseD7f8tkG
	rsNrwv8emDt59fTHGW/WciyxXSpS/k/v6vLLgj/kGbVU18azfRKNnfWzJvfKn89X3R+m+V29
	L+AQ//Ttx1Xx+ldzzz7/bXq/lq8ucrnLvfJ+QYb9LewzFd46f3DcErQ95dbGKqW4TWHRsanG
	PClPkx/9PHh7zrMil1sKb0ueTj1zvmIrn71Ktl3NlSW/VRWOLb1ldXeRH8cbFabUPzKB3JJV
	Lc5ru6asmdr6k2P9l0LmkuAQ4YriAzsPan6OWHrN3Ff98IqOGR+UHl3ZxTVZiaU4I9FQi7mo
	OBEABn00KB0DAAA=
X-CMS-MailID: 20250224024639epcas2p13f0d1fb193b771a4e7507175278ca036
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----2jehmUjxW0Gkbg46_GefLyBaSre4jpBnLPH4I-DC_hWbz.jz=_12e179_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250220034155epcas2p156b90cfb655a03cce4bfac9683f0bfe1
References: <20250220033953.1606820-1-hyesoo.yu@samsung.com>
	<CGME20250220034155epcas2p156b90cfb655a03cce4bfac9683f0bfe1@epcas2p1.samsung.com>
	<20250220033953.1606820-3-hyesoo.yu@samsung.com> <Z7g5wyjsP1ktucDO@harry>

------2jehmUjxW0Gkbg46_GefLyBaSre4jpBnLPH4I-DC_hWbz.jz=_12e179_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Feb 21, 2025 at 05:30:59PM +0900, Harry Yoo wrote:
> On Thu, Feb 20, 2025 at 12:39:44PM +0900, Hyesoo Yu wrote:
> > If a slab object is corrupted or an error occurs in its internal
> > value, continuing after restoration may cause other side effects.
> > At this point, it is difficult to debug because the problem occurred
> > in the past. It is useful to use WARN() to catch errors at the point
> > of issue because WARN() could trigger panic for system debugging when
> > panic_on_warn is enabled. WARN() is added where to detect the error
> > on slab_err and object_err.
> >
> > There are cases where slab_err is called before meaningful logs are
> > printed. If the WARN() in slab_err cause a panic, these logs will not
> > be printed. WARN() should called after these logs are printed. Thus
> > slab_err() is splited to __slab_err that calls the WARN() and it is
> > called after printing logs.
> > 
> > Changes in v3:
> > - move the WARN from slab_fix to slab_err, object_err to use WARN on
> > all error reporting paths.
> > 
> > Changes in v2:
> > - Replace direct calling with BUG_ON with the use of WARN in slab_fix.
> > 
> > Signed-off-by: Hyesoo Yu <hyesoo.yu@samsung.com>
> > Change-Id: I90b2ea9ffc58e3826f7ae9f1a774bb48c2d43bf4
> > ---
> >  mm/slub.c | 31 +++++++++++++++++++------------
> >  1 file changed, 19 insertions(+), 12 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index de62fed12236..7f0583a71cda 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -5473,8 +5481,7 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
> >  			remove_partial(n, slab);
> >  			list_add(&slab->slab_list, &discard);
> >  		} else {
> > -			list_slab_objects(s, slab,
> > -			  "Objects remaining in %s on __kmem_cache_shutdown()");
> > +			list_slab_objects(s, slab);
> 
> Could you remove WARN() in kmem_cache_destroy()?
> 
> When a cache is destroyed with remaining objects, two WARNINGs being are
> printed, one from list_slab_objects() and another from kmem_cache_destroy().
> The latter becomes redundant with this patch.
> 
> The WARN() is added there because it's good to catch such an error.
> At that time, slab_err() and object_err() did not call WARN().
> 

Thank you for reviewing the part I missed.
I will remove the WARN in kmem_cache_destory().

Thanks,
Regards.

> >  		}
> >  	}
> >  	spin_unlock_irq(&n->list_lock);
> > -- 
> > 2.28.0
> > 
> 
> -- 
> Cheers,
> Harry
> 

------2jehmUjxW0Gkbg46_GefLyBaSre4jpBnLPH4I-DC_hWbz.jz=_12e179_
Content-Type: text/plain; charset="utf-8"


------2jehmUjxW0Gkbg46_GefLyBaSre4jpBnLPH4I-DC_hWbz.jz=_12e179_--

