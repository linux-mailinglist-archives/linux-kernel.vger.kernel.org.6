Return-Path: <linux-kernel+bounces-530345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72876A43251
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8523A9E27
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2444317BA9;
	Tue, 25 Feb 2025 01:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OrjUtc+d"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DBE6AA7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740446007; cv=none; b=mQtd8UlFHAtjVRIDiCkYbphTO5+DlsqKRQgMqjBcMEkDWZ7mQrr2DtRhu7vS2EbqGXVNVY542NlJXcBtoJrlAU05Of9VaAt4FSocv9CYNG7WB6QiMl1WNCQlR1y0aSaetXv0Svz/Z9qYkztCGJshZXTVqXiGb3AaZgKTWpz42hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740446007; c=relaxed/simple;
	bh=sNyhVyQv0VA1vkJvtKy5BEdJycXecj0nyHKXfyEJWjY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=Im3lLE64AEEQ48dNx8vOV40gnRJsYG1TdoyZC09G03oVhEfoVv+tYFsheT5zx3lk+u/ShXaDNBvKd+WbvtwVhidGnshkfT2L2fKEdJkTK8uY0vajdFIREO/DH6v28S42rWncPnRtmd3ksoXpNEAx14cu6d9JMleNJZTD6MqT79w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OrjUtc+d; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250225011322epoutp037212d1a0b795890a93f56560af89d5dc~nTmsY3i282004920049epoutp03N
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:13:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250225011322epoutp037212d1a0b795890a93f56560af89d5dc~nTmsY3i282004920049epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740446002;
	bh=MTWtqLPydZIhx4hoCh35M7njM0H8vWlViIKvoqL1epI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OrjUtc+dA49/t5uNhfp2QJEMVwWoHaDewuI7LM/sk8eGpK+oQSPuzRlD87LJrVlRC
	 ehGWN7VImXISBqZUPdCJ/qrYhPrcU/bkVsFngS8QnxXrBt8EFSl5VVe/o8UqKWMAUe
	 HTDZbJWwsN4jPthpdaXewS5XUtWRB5OvTy6D1k9Q=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20250225011322epcas2p3c611a053c4b88a576e80c6b8c8d176d5~nTmr_YFb71642416424epcas2p3D;
	Tue, 25 Feb 2025 01:13:22 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.101]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Z203Q03r3z4x9Py; Tue, 25 Feb
	2025 01:13:22 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	5B.3A.23368.1391DB76; Tue, 25 Feb 2025 10:13:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20250225011321epcas2p1dfe6b96f5749767781b113a0b1d57cea~nTmrMDVsM0932209322epcas2p1C;
	Tue, 25 Feb 2025 01:13:21 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250225011321epsmtrp1df0ab98bb664f29f7a45dd3f7a5a87b5~nTmrLDUd31608316083epsmtrp1j;
	Tue, 25 Feb 2025 01:13:21 +0000 (GMT)
X-AuditID: b6c32a45-dc9f070000005b48-d0-67bd1931a100
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	63.0D.18949.1391DB76; Tue, 25 Feb 2025 10:13:21 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250225011321epsmtip1c8473a8c93e38786f6a553a96f8ca548~nTmq_mis51465714657epsmtip1K;
	Tue, 25 Feb 2025 01:13:21 +0000 (GMT)
Date: Tue, 25 Feb 2025 10:11:54 +0900
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: janghyuck.kim@samsung.com, vbabka@suse.cz, Pekka Enberg
	<penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim
	<iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Roman
	Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm: slub: Print the broken data before restoring
 slub.
Message-ID: <20250225011154.GB2345951@tiffany>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8befd391-3741-40ca-fd84-47112a75c7ac@gentwo.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmha6h5N50g6vHLC0m9hhYzFm/hs1i
	+Zy5TBYru5vZLDbPKba4vGsOm8W9Nf9ZLdo+/wMSSzYyWUxcI2oxu7GP0YHbY//hIo+ds+6y
	eyzYVOqxaVUnm8emT5PYPbreXmHyODHjN4vHwoapzB59W1YxepxZcITd4/MmuQDuqGybjNTE
	lNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKCblRTKEnNKgUIB
	icXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGX9X32Aq
	WM5eMefmZKYGxi62LkYODgkBE4nu/T5djFwcQgI7GCXW/O9g7mLkBHI+MUqcmqwPkfjGKNHQ
	+4ARJAHWsHgGG0RiL6PE884L7BDOU0aJayungrWzCKhKHD4/jx3EZhNQlzixZRkjyDoRAQOJ
	hTciQOqZBS4ySTzu3M4GUiMsECIxc/o6FhCbV0BPomvfGmYIW1Di5MwnYHFOATugOb8ZQZol
	BNZySLzbe50N4iQXiXs/D7JD2MISr45vgbKlJF72t0HZxRLbFh9mgmhuYJTY3HGfGSJhLDHr
	WTvYb8wCmRJ7rk+GBoyyxJFbLBBhPomOw3/ZIcK8Eh1tQhCdyhL7l81jgbAlJR6tbWeFsD0k
	LpzaygoJlO+MEicOt7FPYJSbheSfWUi2Qdg6Egt2fwKyOYBsaYnl/zggTE2J9bv0FzCyrmIU
	Sy0ozk1PLTYqMIRHcHJ+7iZGcBLWct3BOPntB71DjEwcjIcYJTiYlUR4OTP3pAvxpiRWVqUW
	5ccXleakFh9iNAVGzkRmKdHkfGAeyCuJNzSxNDAxMzM0NzI1MFcS563e0ZIuJJCeWJKanZpa
	kFoE08fEwSnVwOR26NhKptuiBU3LYp68cjxclnrsicH9B06cq1ubStznRnhwWm2YUt9X8MiP
	can8tPCw7+ZTuB4f3BzaWPCoMOBSeaWv0YYrodN/njHRueon0v/qrrmw7BXH+2f99nx0iSr9
	6dR05kOwpfw0u2dflFOX8y7YKGK8sKVB8w+XIsOFgr4ZvoyhOoVKGzxK8tp3Tbcv7ecv/3bR
	Pmp2oPeLVL994Q846id/abspGGpx4Pbz7P7+1k7GHhaDtQGRnxyPbZK6+bt0v125b69g1PX3
	ujkxeXy/1+5dn+KmJOVWq/DyS7vMHm0p1iDukzosZ57dX71Jx6a7Ye26z4/Tdrw4cbXYY331
	jrtGgQy3/7kuV2Ipzkg01GIuKk4EAKA73KRLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSnK6h5N50g9Y3shYTewws5qxfw2ax
	fM5cJouV3c1sFpvnFFtc3jWHzeLemv+sFm2f/wGJJRuZLCauEbWY3djH6MDtsf9wkcfOWXfZ
	PRZsKvXYtKqTzWPTp0nsHl1vrzB5nJjxm8VjYcNUZo++LasYPc4sOMLu8XmTXAB3FJdNSmpO
	Zllqkb5dAlfGpx0/WAqesFT86nzF0sD4gLmLkZNDQsBEonvxDDYQW0hgN6PElRuOEHFJiVmf
	TzJB2MIS91uOsHYxcgHVPGaUWNqzGayZRUBV4vD5eewgNpuAusSJLcsYuxg5OEQEDCQW3ogA
	qWcWuM4k8ePOVrAFwgIhEjOnr2MBsXkF9CS69q1hhhj6nVGif95pNoiEoMTJmU/AipgFtCRu
	/HvJBDKUWUBaYvk/DpAwp4Ad0K7fjBMYBWYh6ZiFpGMWQscCRuZVjJKpBcW56bnFhgVGeanl
	esWJucWleel6yfm5mxjBUaSltYNxz6oPeocYmTgYDzFKcDArifByZu5JF+JNSaysSi3Kjy8q
	zUktPsQozcGiJM777XVvipBAemJJanZqakFqEUyWiYNTqoFpgkL/ht45/U77M1MU7M4t3de7
	M+H98Zbpx44GB3/9aGLdKK65grN/kvydxR+u9UvKZec9vp86Vb/cguu458+eqDK+k66+eT+e
	fGm3qvU8/NUgJupCgGv23S86t3yS5+UUyB+d1CPhd2+tLaPsrPvfRRf2Npm7S9xmKXkc2tIp
	0pad3RGkt5XhsazY2bsntq2sMfua/eVymfC7++yJ7dcczexvHfDVqrqeUyfe2+HAONXmeqGF
	wsMdSre6kwqtmJmOSfTxzl8cGznlS4pG9V6jinbeHMZL2wOv7i8LveKRsqOVVTxnnpLQHqtt
	6j4aZct2z91rsMjN2cD9WPhBo5O1S1R6wpYlbvMLDpv1WYmlOCPRUIu5qDgRAGy8oGURAwAA
X-CMS-MailID: 20250225011321epcas2p1dfe6b96f5749767781b113a0b1d57cea
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----m7PZ4BT1ldTQPVcONAqyTj2Zy1CXq_CO7oNb.DekQ57E.lpM=_139d21_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250220034153epcas2p286194dda687b47a3dec8fb89b868f96f
References: <20250220033953.1606820-1-hyesoo.yu@samsung.com>
	<CGME20250220034153epcas2p286194dda687b47a3dec8fb89b868f96f@epcas2p2.samsung.com>
	<20250220033953.1606820-2-hyesoo.yu@samsung.com>
	<8befd391-3741-40ca-fd84-47112a75c7ac@gentwo.org>

------m7PZ4BT1ldTQPVcONAqyTj2Zy1CXq_CO7oNb.DekQ57E.lpM=_139d21_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Feb 24, 2025 at 09:24:42AM -0800, Christoph Lameter (Ampere) wrote:
> On Thu, 20 Feb 2025, Hyesoo Yu wrote:
> 
> > @@ -1396,11 +1400,6 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
> >  		ret = 0;
> >  	}
> >
> > -	if (!ret && !slab_in_kunit_test()) {
> 
> 
> > -		print_trailer(s, slab, object);
> > -		add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> 
> No tainting and printing of the trailer anymore?
> 

If there is an error before on check_object, the check_bytes_and_report
calls object_err that calls print_trailer and add_traint.

Thanks,
Regards.

------m7PZ4BT1ldTQPVcONAqyTj2Zy1CXq_CO7oNb.DekQ57E.lpM=_139d21_
Content-Type: text/plain; charset="utf-8"


------m7PZ4BT1ldTQPVcONAqyTj2Zy1CXq_CO7oNb.DekQ57E.lpM=_139d21_--

