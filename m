Return-Path: <linux-kernel+bounces-410762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E60F9CE0B2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF9928E463
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42161CDA04;
	Fri, 15 Nov 2024 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Xhqf/Rjo"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5F21B85EB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678873; cv=none; b=EttZRsUpZ0zJDGoHEsv7QD7IFhRzNSZDxKovpa2gD6FJbatZImF5bGaamEE8520ddpzeLaTkQ62OMbL2k3eXqruYTM5X3MvF6V+SH1N83kxPs+lacZRr88Bs7Cnj++tTrser9Bs5vfG7Pv8aNEalUzss07ihlCmeD65aKj+DbZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678873; c=relaxed/simple;
	bh=nf4yWog6XTYGEGzuDqGqrURMaLEh+ETes95vDmGXy/U=;
	h=MIME-Version:Content-Type:Date:Message-ID:Subject:CC:To:From:
	 In-Reply-To:References; b=ZqQRBlfi7Tzinaqjwyr56ew9f967ywuBJNN+QyzUqG482AjrPt2eVOMZUTwKGu+gEQojziHftztFog6e0KRlEhqTj6Pyb2UwQ651mxMqEoY2YH/+u1m4em4y9oV+IpFUOGW+KvYfNMV7xoG6b6ZJKTgiKKzfvDvpwgoMoqwQIRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Xhqf/Rjo; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241115135429euoutp028cee5563b55bd85250383421d3c4b3ce~IKMG20GK90927709277euoutp02H
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:54:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241115135429euoutp028cee5563b55bd85250383421d3c4b3ce~IKMG20GK90927709277euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731678869;
	bh=EjRzgJOOBbr/Yf3XScGiAqFlns7wVl0GfI2Gqifa78Q=;
	h=Date:Subject:CC:To:From:In-Reply-To:References:From;
	b=Xhqf/RjogMdGmnjBkSaFpk6lYH/N8ALlOEV1VDGl6CxCGsYo2i4myCooZzsF3qP+f
	 5CiROl9yDSKvb2Vwd6Cxpiy1BSKBddbbJjPlIcF8b/ht8+tL7Q0Cy0mDCNVg2n+D+8
	 YA1gFfpOc4swqGuTlWRb7Go8IWwyFbztDqYlKxMo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241115135428eucas1p2413a743917dc62d53e35bf70096bd3cd~IKMGk8XCT1382213822eucas1p2M;
	Fri, 15 Nov 2024 13:54:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id CE.46.20397.49257376; Fri, 15
	Nov 2024 13:54:28 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241115135428eucas1p2b266175fadfb08cad9264c89fd395407~IKMGB2DrO2839028390eucas1p27;
	Fri, 15 Nov 2024 13:54:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241115135428eusmtrp1b4a426a4598f32f9a315c3a31dc2405a~IKMGBR3x20931009310eusmtrp1A;
	Fri, 15 Nov 2024 13:54:28 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-dd-67375294f5fe
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id F8.5F.19654.49257376; Fri, 15
	Nov 2024 13:54:28 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241115135428eusmtip14ee0d0e098ddba1c5239c6caaeae20e0~IKMF0S6z22532925329eusmtip1t;
	Fri, 15 Nov 2024 13:54:28 +0000 (GMT)
Received: from localhost (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 15 Nov 2024 13:54:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Nov 2024 14:54:26 +0100
Message-ID: <D5MSXD4BK3E4.2IN0397LA1BWB@samsung.com>
Subject: Re: [PATCH v2 1/5] mm: factor out the order calculation into a new
 helper
CC: <willy@infradead.org>, <david@redhat.com>, <wangkefeng.wang@huawei.com>,
	<21cnbao@gmail.com>, <ryan.roberts@arm.com>, <ioworker0@gmail.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
	<akpm@linux-foundation.org>, <hughd@google.com>
From: Daniel Gomez <da.gomez@samsung.com>
X-Mailer: aerc 0.18.2-67-g7f69618ac1fd
In-Reply-To: <582997bd09b17a292124ea47dabc2ea5642daade.1731397290.git.baolin.wang@linux.alibaba.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7djPc7pTgszTDfa8MLD4fFfIYs76NWwW
	//ceY7T4uv4Xs8XTT30sFot+G1tc3jWHzeLemv+sFj27pzJaNH6+z2jx+8ccNgdujzXz1jB6
	7Jx1l91jwaZSj5Yjb1k9Nq/Q8tj0aRK7x4kZv1k8dj609Hi/7yqbx+dNcgFcUVw2Kak5mWWp
	Rfp2CVwZv7vmMhYs5K14tuctUwPjLa4uRg4OCQETia/LjLsYOTmEBFYwShzvZO5i5AKyvzBK
	/PjdwQ7hfGaUOLr7LhtIFUjDtZ1rWCASyxkl5p1czgxXdfHQQyYIZzOjxJ2GiewgLbwCghIn
	Zz5hAbGZBbQlli18zQxha0q0bv8NVsMioCrR3LyYDeQmXqAVXTsqQcLCAiESfXPvsYLMZBY4
	ySgx634T2BkiAkkSjXN3gM1hA5qz7+Qmdojz1CT+908E28UpkCLx581ZqLiixIyJK1kg7FqJ
	U1tugR0qIbCaU2LxZZgiF4kH3Y8YIWxhiVfHt0DFZSROT+6Bak6XWLJuFpRdILHn9ixWSEBa
	S/SdyYEIO0q03epngwjzSdx4KwjxLp/EpG3TmSHCvBIdbUITGFVmIQXQLKQAmoUUQAsYmVcx
	iqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEpq7T/45/3cG44tVHvUOMTByMhxglOJiVRHgv
	uZqnC/GmJFZWpRblxxeV5qQWH2KU5mBREudVTZFPFRJITyxJzU5NLUgtgskycXBKNTA5Ohgw
	SOwMD39iNeFTe8jCsA85mUoL+o5omIkEhMx4askw/X+k3QSFV7Xng3hesq23XmBzZucktuIX
	+2XLtE6FVl8o1s1N7FG4y3+4PGHuIs2aqx3rWVw0BYUjShgFYooEmqf76lbdmNs5+7U25xId
	vfYo0af+1hXhzC5i7QyrZ+3RfProBtMz0cZprx8pn2hnFbSedbRGy9i5LHLtg2/3d2gcY7+b
	ftL9ysT1H5eeE4/Ku1U4/WHz7v4nWYZCSlGTLFXdWYSd1jI/CS2bdeqjdpWM8qqJfy4px0Zd
	TkmOF2HLz/ONrDRzZDKK9hCZ6R8bdKb091HW38FWH2x2XnXvKEqZvMDXsa3HPSZCiaU4I9FQ
	i7moOBEAukJBA8wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsVy+t/xu7pTgszTDVbP5LH4fFfIYs76NWwW
	//ceY7T4uv4Xs8XTT30sFot+G1tc3jWHzeLemv+sFj27pzJaNH6+z2jx+8ccNgdujzXz1jB6
	7Jx1l91jwaZSj5Yjb1k9Nq/Q8tj0aRK7x4kZv1k8dj609Hi/7yqbx+dNcgFcUXo2RfmlJakK
	GfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZv7vmMhYs5K14tuct
	UwPjLa4uRk4OCQETiWs717B0MXJxCAksZZSY+mMeK0RCRmLjl6tQtrDEn2tdbBBFHxkl1rU+
	ZIRwNjNK3Dy7gRGkildAUOLkzCcsIDazgLbEsoWvmSFsTYnW7b/ZQWwWAVWJ5ubFQJM4gOpN
	JLp2VIKEhQVCJPrm3mMFmckscJJRYtb9JjaQhIhAksS9PTvBZrIBzdl3chM7xEVqEv/7J0Kd
	PYtR4sGSDiaQBKdAisSfN2ehihQlZkxcyQJh10p8/vuMcQKjyCwkt85CcussJLcuYGRexSiS
	Wlqcm55bbKRXnJhbXJqXrpecn7uJERjh24793LKDceWrj3qHGJk4GA8xSnAwK4nwXnI1Txfi
	TUmsrEotyo8vKs1JLT7EaAr09ERmKdHkfGCKySuJNzQzMDU0MbM0MLU0M1YS52W7cj5NSCA9
	sSQ1OzW1ILUIpo+Jg1Oqgam2T9eGW8IjPkFoA2Oq1l8OXtP6I8anFS7r3xJfcYyx5PPGrAq7
	j2J7vFhU/q0q/x3cdz72ZZLBkcWq8SfLn+4qFj634N2cdL+qlws0twV+O/Xx6WqFas53GtZ6
	sy3dNv1ZdWqFq+ZDjsTny3a/vXB1/hmj1WqJF356Myp++lhz+PC5PY4RIk23FZ3sDYUb3no5
	8q/iTsp//brqepKfeJmRoYHJ6hI+8S1fT7MvzPI7L+ZaKB6S77OIvzjaIdHgJlt6ysSpSk99
	Vt49cnDBmWtZq6VvahxkZVbaH1oh51l2/aGwu5qe7MGzqXfm7apIa18ex3DxwKt7HlUa3kqB
	vtrzlLbJF6i8awqbs3u1jBJLcUaioRZzUXEiAMOCWsN5AwAA
X-CMS-MailID: 20241115135428eucas1p2b266175fadfb08cad9264c89fd395407
X-Msg-Generator: CA
X-RootMTR: 20241115135428eucas1p2b266175fadfb08cad9264c89fd395407
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241115135428eucas1p2b266175fadfb08cad9264c89fd395407
References: <cover.1731397290.git.baolin.wang@linux.alibaba.com>
	<582997bd09b17a292124ea47dabc2ea5642daade.1731397290.git.baolin.wang@linux.alibaba.com>
	<CGME20241115135428eucas1p2b266175fadfb08cad9264c89fd395407@eucas1p2.samsung.com>

On Tue Nov 12, 2024 at 8:45 AM CET, Baolin Wang wrote:
> Factor out the order calculation into a new helper, which can be reused
> by shmem in the following patch.
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Barry Song <baohua@kernel.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

> ---
>  include/linux/pagemap.h | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index bcf0865a38ae..d796c8a33647 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -727,6 +727,16 @@ typedef unsigned int __bitwise fgf_t;
> =20
>  #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
> =20
> +static inline unsigned int filemap_get_order(size_t size)
> +{
> +	unsigned int shift =3D ilog2(size);
> +
> +	if (shift <=3D PAGE_SHIFT)
> +		return 0;
> +
> +	return shift - PAGE_SHIFT;
> +}
> +
>  /**
>   * fgf_set_order - Encode a length in the fgf_t flags.
>   * @size: The suggested size of the folio to create.
> @@ -740,11 +750,11 @@ typedef unsigned int __bitwise fgf_t;
>   */
>  static inline fgf_t fgf_set_order(size_t size)
>  {
> -	unsigned int shift =3D ilog2(size);
> +	unsigned int order =3D filemap_get_order(size);
> =20
> -	if (shift <=3D PAGE_SHIFT)
> +	if (!order)
>  		return 0;
> -	return (__force fgf_t)((shift - PAGE_SHIFT) << 26);
> +	return (__force fgf_t)(order << 26);
>  }
> =20
>  void *filemap_get_entry(struct address_space *mapping, pgoff_t index);


