Return-Path: <linux-kernel+bounces-237727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0B4923D57
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A398F282427
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CE615D5C8;
	Tue,  2 Jul 2024 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J2uZgE6/"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7343D15CD54
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719922395; cv=none; b=cWnjJi72xqomaHzpeNVZJVLTw6wpfKPe9yfxCTYrH8DIBDM/gD6qRT6YV9t8AHCayZRgXFOGxrsr7ZyOypyzccBuTuup/D74EJFH2qR5f9nTbbcM8m2HXGWmicfisON9o4FTumX07JqFednKFxEWlYn1Un/AAPOhcsDD1+aWqrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719922395; c=relaxed/simple;
	bh=pTe1aDPvuuFEJZ/GobIEJEDeVnTdQCn5R9VkL0RK+Qc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=K8SlBL1mGgEoDA5KRDNl1HoTeZ1sVXCqNdIpw4cX5LH91F6ahIpR5jeCUVDrb38A7CP96YDjD4TqZJ+nu730R0omoD8PCsYKtbB5td30wWfM5UQVKqRtP057T4N4kYpmlNRxD0gxirqZRX2jgG2Z8082TE1oSuKn8fyW5yBYnIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=J2uZgE6/; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240702121310epoutp02bf3976a76f78c7c7c3e0ec4a8e05d03f~eZE01ZdZj2405724057epoutp02J
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 12:13:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240702121310epoutp02bf3976a76f78c7c7c3e0ec4a8e05d03f~eZE01ZdZj2405724057epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719922390;
	bh=fQw+IYHbL0xTtgej7CXwhTQ7qvGP/baI3QsyrH+7RPE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=J2uZgE6/+ibHiAAMHLHsO1YHi8aUi6QwaZiPB+ZAC5MnaeZbRmOPk8M5JipCeAWTt
	 4SDGQid2uV/SuAhSH5BUl9SJE/PKmMewX5+pMatKXaXvN07qavXmVN7fmrw6hy0pXY
	 UfUeUC4I/AZHxNMh1wEZWy6akn/h1Hk5a8dUTcb0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240702121310epcas1p1339fc12ca924c194b7ddf2c4bd6c6b2d~eZE0h5cTW3046030460epcas1p1-;
	Tue,  2 Jul 2024 12:13:10 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.247]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WD1yY5Qpsz4x9Pt; Tue,  2 Jul
	2024 12:13:09 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	16.68.09910.5DEE3866; Tue,  2 Jul 2024 21:13:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240702121309epcas1p1aa6092515863dec08bd7fe82e67db7f9~eZEzx9fMj1468214682epcas1p1u;
	Tue,  2 Jul 2024 12:13:09 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240702121309epsmtrp2dec70dfcfc1ab1453dde493aecca43e8~eZEzxXruB1337413374epsmtrp2Z;
	Tue,  2 Jul 2024 12:13:09 +0000 (GMT)
X-AuditID: b6c32a38-a3fff700000226b6-b7-6683eed58a89
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	5D.6D.18846.5DEE3866; Tue,  2 Jul 2024 21:13:09 +0900 (KST)
Received: from sminjeong05 (unknown [10.253.99.183]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240702121309epsmtip245756f2f05328ac93ac9bac5ad2eef45~eZEzocFCu3163931639epsmtip2z;
	Tue,  2 Jul 2024 12:13:09 +0000 (GMT)
From: "Sunmin Jeong" <s_min.jeong@samsung.com>
To: "'Chao Yu'" <chao@kernel.org>, <jaegeuk@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20240625031351.3586955-4-chao@kernel.org>
Subject: RE: [f2fs-dev] [PATCH 4/4] f2fs: atomic: fix to forbid dio in
 atomic_file
Date: Tue, 2 Jul 2024 21:13:09 +0900
Message-ID: <5f6701dacc79$33afa870$9b0ef950$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJIkRSe0PNvFivjVhHqD787u2nN5QGFMc2+AfNnngSw7ArncA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmge7Vd81pBsfualicnnqWyeLJ+lnM
	FpcWuVtc3jWHzYHFY9OqTjaP3Qs+M3l83iQXwByVbZORmpiSWqSQmpecn5KZl26r5B0c7xxv
	amZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtExJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquU
	WpCSU2BWoFecmFtcmpeul5daYmVoYGBkClSYkJ2xZOkR9oIe+YpXN/4wNjA+lehi5OSQEDCR
	WLplG0sXIxeHkMAORoml9+cxQTifGCUO3F7PAlIF5hzd4wfT8aG9mRkivpNR4tVXA4iGl4wS
	h15cBWtgE9CTmL76H1iRiIC5xJ7Fr9hAbGYBH4nft+6BxTmB4o8PfmEHsYUFQiTOvz8M1ssi
	oCKx89xVRhCbV8BS4uuT51C2oMTJmU9YIObIS2x/O4cZ4iAFiZ9Pl7FC7HKS+HPpNSNEjYjE
	7M42ZpDjJAReskus+vGTFaLBReJX6152CFtY4tXxLVC2lMTnd3vZIOxiiaPzN7BDNDcwStz4
	ehOqyF6iubUZqIgDaIOmxPpd+hDL+CTefe1hBQlLCPBKdLQJQVSrSnQ/WgJ1p7TEsmMHoaZ4
	SGz985R1AqPiLCSvzULy2iwkL8xCWLaAkWUVo1hqQXFuemqxYYEJPLKT83M3MYLToZbFDsa5
	bz/oHWJk4mA8xCjBwawkwhv4qz5NiDclsbIqtSg/vqg0J7X4EKMpMLAnMkuJJucDE3JeSbyh
	iaWBiZmRiYWxpbGZkjjvmStlqUIC6YklqdmpqQWpRTB9TBycUg1MnDZLa4WlLu7fG3m0Tv9s
	uuK8zfVr3kQfVecKkq+SXzTr38Nc2TfbnQ/Lt4R/53T6cFBUWdrT4O5U3e9d1i3PLU20Ys/w
	C86fG/jz1J87E913TSza4L2PN1e9TXAZT2PX7m6RQ87e9SkCBm2L7t9b1NDg9KLqZlnHj4ti
	S72UIqJLJPRvb7S7e3H+h5veT28dzdn17LnW9FffHqYL1awydeT5XPNfIyH1zuM0H8VXcnXe
	WT5mmhfXlp4LVzmsePvS4Zl51o7uhV6/X19zXsxdIfpuomLQ1m1VUyOCXmZ/Kfvncnkhp1Z8
	7BtPkYz8fft4ws3bOpuqfbaIJiVeFH7AtPP4feWYJ6wxTV2inluUWIozEg21mIuKEwHUGRUD
	EAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSvO7Vd81pBmeXCFicnnqWyeLJ+lnM
	FpcWuVtc3jWHzYHFY9OqTjaP3Qs+M3l83iQXwBzFZZOSmpNZllqkb5fAlbFk6RH2gh75ilc3
	/jA2MD6V6GLk5JAQMJH40N7MDGILCWxnlLjX6NPFyAEUl5Y49qcIwhSWOHy4GKLiOaPE3FZr
	EJtNQE9i+up/YJ0iApYSC2adYwGxmQX8JHY9XAEU5wKq38wo8f1AGztIglPAXOLxwS9gtrBA
	kETP/MOsIDaLgIrEznNXGUFsXqBBX588h7IFJU7OfMICcgMz0LK2jYwQ8+Ultr+dwwxxvYLE
	z6fLWCFucJL4c+k1VI2IxOzONuYJjMKzkEyahTBpFpJJs5B0LGBkWcUomlpQnJuem1xgqFec
	mFtcmpeul5yfu4kRHAlaQTsYl63/q3eIkYmD8RCjBAezkghv4K/6NCHelMTKqtSi/Pii0pzU
	4kOM0hwsSuK8yjmdKUIC6YklqdmpqQWpRTBZJg5OqQamPfx5yo1sF0y3HnFWrV62c+mDlR+n
	brzpqOqw5vKdf58YBaWTiw413Uo7cJpjRtJux513DjxdLRIje0bj4KfFl4vWhZx89PbO9+y7
	XLYzd5zK3BZkxdh/U6TmHZ9T6Pz0O65HBR//Euwxr73xRP7Q5hOHTtqbFm3dYb07LP5RbIb/
	zP0bm+62eX0IkerfwKeZyiuwy3jDvfPc4d/ztbU2n8s798k/gZ07NVlQ1oudz/+49P3vUw46
	R358N8O6Y6Gw3oRJXzqf6z+qfbE+j9lLV3Tyc6tt66caFWqbbXg1d+v7RTU/e5a//SoddCPk
	9hbJm5IFzowK5r//TZ35RmWNnYbn1Ih3VVuOPbkwfe/6qDNKLMUZiYZazEXFiQBDpme38wIA
	AA==
X-CMS-MailID: 20240702121309epcas1p1aa6092515863dec08bd7fe82e67db7f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240625031523epcas1p12bf3d3dbe617eb6b8c00e742cf43ae50
References: <20240625031351.3586955-1-chao@kernel.org>
	<CGME20240625031523epcas1p12bf3d3dbe617eb6b8c00e742cf43ae50@epcas1p1.samsung.com>
	<20240625031351.3586955-4-chao@kernel.org>

Hello

I also have been thinking about the GC of the atomic file these days. I
read your patches for atomic write, but I think there are some corner
cases that can't be resolved with them.

First is when the GC of the atomic file occurs right after the writeback
of newly updated page. Since the atomic page flag is cleared at the end
of f2fs_do_write_data_page, the GC thread will set the page dirty and
let it be written to the atomic file, which will cause the data
corruption of the original inode.

Second is the foreground GC of atomic file. Although your patch can
distinguish whether pages should be written to the original inode or cow
inode, it can't handle the case when the atomic page needs to be
migrated but updated page already exists in the page cache as below.

// atomic file's 1st old block is a and new block is b.
// b is in the page cache
GC thread(FG_GC)
  - select A as a victim segment
  do_garbage_collect
    - iget atomic file's inode for block a
    move_data_page
      f2fs_do_write_data_page
        - use dn of cow inode since b has atomic flag
    - seg_freed is 0 since block a is still valid
    - goto gc_more and A is selected as victim again

Third is a race condition between GC of cow file and writeback thread of
atomic file. Since there are two page caches for one dnode, I think we
need to consider the race condition between them such as the case
between the file inode and the meta inode.

I submitted a patch set for atomic write, so could you review it?
The patch links are as below.
https://sourceforge.net/p/linux-f2fs/mailman/message/58790988/
https://sourceforge.net/p/linux-f2fs/mailman/message/58790989/

Thanks



> atomic write can only be used via buffered IO, let's fail direct IO on
> atomic_file and return -EOPNOTSUPP.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/file.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c index
> 0355cb054521..a527de1e7a2f 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2150,6 +2150,7 @@ static int f2fs_ioc_start_atomic_write(struct file
> *filp, bool truncate)
>  		goto out;
> 
>  	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
> +	f2fs_down_write(&fi->i_gc_rwsem[READ]);
> 
>  	/*
>  	 * Should wait end_io to count F2FS_WB_CP_DATA correctly by @@ -
> 2209,6 +2210,7 @@ static int f2fs_ioc_start_atomic_write(struct file
*filp,
> bool truncate)
>  	}
>  	f2fs_i_size_write(fi->cow_inode, isize);
> 
> +	f2fs_up_write(&fi->i_gc_rwsem[READ]);
>  	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> 
>  	f2fs_update_time(sbi, REQ_TIME);
> @@ -4537,6 +4539,13 @@ static ssize_t f2fs_dio_read_iter(struct kiocb
> *iocb, struct iov_iter *to)
>  		f2fs_down_read(&fi->i_gc_rwsem[READ]);
>  	}
> 
> +	/* dio is not compatible w/ atomic file */
> +	if (f2fs_is_atomic_file(inode)) {
> +		f2fs_up_read(&fi->i_gc_rwsem[READ]);
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
>  	/*
>  	 * We have to use __iomap_dio_rw() and iomap_dio_complete() instead
> of
>  	 * the higher-level function iomap_dio_rw() in order to ensure that
> the @@ -4948,6 +4957,12 @@ static ssize_t f2fs_file_write_iter(struct
> kiocb *iocb, struct iov_iter *from)
>  	/* Determine whether we will do a direct write or a buffered write.
> */
>  	dio = f2fs_should_use_dio(inode, iocb, from);
> 
> +	/* dio is not compatible w/ atomic write */
> +	if (dio && f2fs_is_atomic_file(inode)) {
> +		ret = -EOPNOTSUPP;
> +		goto out_unlock;
> +	}
> +
>  	/* Possibly preallocate the blocks for the write. */
>  	target_size = iocb->ki_pos + iov_iter_count(from);
>  	preallocated = f2fs_preallocate_blocks(iocb, from, dio);
> --
> 2.40.1
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


