Return-Path: <linux-kernel+bounces-184377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5565B8CA641
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6081F21CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5A11CD13;
	Tue, 21 May 2024 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jO48A+0n"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C4118054
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716259219; cv=none; b=s3DjJczS0jixbSqn4g52NdKD2Da5+q7D8qj98sUVDBw7MiJaIF/8wCS86Qz+1/GO/D+7/VaF+J1sJmlMKNSzsaC63DqZ1OVx6/6NpRhjVjn+BWbY02rMfKWKhn/xc0B20s61+TdOdutChPZM7zUfqbdt3ymyLWyJIMu6YN4ioWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716259219; c=relaxed/simple;
	bh=p1LIY4nA/ORBBuK5Yt6eAXXigY9eY+XuuCSpefG0JBY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=I6O7tOLmfy8jHCF5N7Mcs4gC0xDDEDSx5Qd5yqNpu8BSfig5pJGloe47bnMtyx18ZNKXNlOqwmxJCt02hL4idJeTu6nRk3Rw4J0RIb+CuANTfvZyshB6jyf4q1crChtYOO0/Ts1FV0ezamCrjCx0o+QsbLcXG6a2XzYm065R6x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jO48A+0n; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240521024010epoutp0381a1b0b22cc0e663af2baccdc722b333~RYKiMOJfr0903709037epoutp03Y
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:40:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240521024010epoutp0381a1b0b22cc0e663af2baccdc722b333~RYKiMOJfr0903709037epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716259210;
	bh=2nyw+C7rNp+l+xPXOp2Qx9L1AYg4BMnfedd/ZCD1HbI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=jO48A+0nhry5TPIeFUlp1Mf85t/dskGK9LyipAyGt7qld3oQX5/IHbzQiv+r9Ww2e
	 ecibNebBwxeTfvgCgJDMU7uJgKgfy+d2Dat22Yq/PpIxFxQllMdOQPQyL/di6Sf4fE
	 Gbt8Vd6sCkpJcvsdqg78N+yjp0dvaolDwWt1O8OQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240521024009epcas1p2b2862f74e82056485388c1927517d774~RYKhps6ou0671506715epcas1p2w;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.227]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VjzDn2YPRz4x9Pq; Tue, 21 May
	2024 02:40:09 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	AE.B2.10076.9890C466; Tue, 21 May 2024 11:40:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76~RYKhQBRoC2349123491epcas1p1Z;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240521024009epsmtrp2f02cd063e59c1418c1cdcf0d843f09e4~RYKhO8aTB2496124961epsmtrp2m;
	Tue, 21 May 2024 02:40:08 +0000 (GMT)
X-AuditID: b6c32a39-59dff7000000275c-c5-664c0989c64a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BD.EA.09238.8890C466; Tue, 21 May 2024 11:40:08 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.104.99]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240521024008epsmtip2f022c4301ade9151768656be3085c125~RYKhF2BnR1132711327epsmtip2Q;
	Tue, 21 May 2024 02:40:08 +0000 (GMT)
From: Jaewon Kim <jaewon31.kim@samsung.com>
To: rppt@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [RESEND PATCH 00/10] memblock: introduce memsize showing reserved
 memory
Date: Tue, 21 May 2024 11:39:47 +0900
Message-Id: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmrm4np0+aweTpghZz1q9hs+jePJPR
	ovf9KyaLy7vmsFncW/Of1eLI+u1MFrMb+xgd2D12zrrL7rFpVSebx6ZPk9g9Tsz4zeLRt2UV
	o8eZBUfYPT5vkgtgj8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVV
	cvEJ0HXLzAE6SEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFagV5yYW1yal66X
	l1piZWhgYGQKVJiQnbH7x2vGgk3CFTM+X2BpYNzP18XIySEhYCIx5cxvli5GLg4hgR2MEivW
	fmaFcD4xSjybcIkJwvnGKDH9/h8ghwOs5etDcYj4XkaJGyv3Q7V/ZpQ4fXQzK8hcNgFtifcL
	JoHZIgJ2Et9mHwCzmQVKJd6+OcEMYgsLBEssOHSHEcRmEVCV+LjpCROIzStgL7H+6Go2iPvk
	JWZe+s4OEReUODnzCQvEHHmJ5q2zmUEWSwjcYpd4Ob+JEaLBReLdyzZ2CFtY4tXxLVC2lMTn
	d3uhhuZLXLj4CuqbGomFEw0hwvYSu77OYAUJMwtoSqzfpQ+xik/i3dceVohqXomONiGIajWJ
	lmdfWSFsGYm//55B2R4Sd6/tZgEpFxKIlTh8wWACo9wsJPfPQnL/LIRdCxiZVzGKpRYU56an
	FhsWmMKjMTk/dxMjOBVqWe5gnP72g94hRiYOxkOMEhzMSiK8m7Z4pgnxpiRWVqUW5ccXleak
	Fh9iNAWG6ERmKdHkfGAyziuJNzSxNDAxMzKxMLY0NlMS5z1zpSxVSCA9sSQ1OzW1ILUIpo+J
	g1OqgSmlUcL58FGHj4zFBp+2HSg1PCfbdPDjYumTwVeVv7Ln51581u3x9dtjT7+1XkK5N7+K
	bHtVdeaO5q18Uf3rO5XfSNbNONP3W/KAuiHjkrTzwV2sxv+vunxyspqXv/HEwQ3535fHXNLR
	v6y2i/1D43P5VI011w6GK2Yv+SX6xqSgXGB7zpZY5Ucfz56Mnsecfcf89ZlN5vflpYszbjnz
	vdgquzMqgPVDSGmk74KQzH+Pdn7YHvtwvrqbwhyplTcDni8MCTzA9rw/YI16sfOfhgkqd2uu
	Rr+8wZ4385yUNofytEZzlcIPtscrOP7Msootcdwd2f88TW8j16Vpy6+J2HuI3/h/NkPyQHR+
	MtvszXZKLMUZiYZazEXFiQBHPXi1DgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSvG4Hp0+awcPLlhZz1q9hs+jePJPR
	ovf9KyaLy7vmsFncW/Of1eLI+u1MFrMb+xgd2D12zrrL7rFpVSebx6ZPk9g9Tsz4zeLRt2UV
	o8eZBUfYPT5vkgtgj+KySUnNySxLLdK3S+DK2P3jNWPBJuGKGZ8vsDQw7ufrYuTgkBAwkfj6
	ULyLkYtDSGA3o0TT1O2sXYycQHEZiTfnn7JA1AhLHD5cDFHzkVFi1pRbjCA1bALaEu8XTAKr
	FxFwkthwZTULiM0sUCnx7/YtsLiwQKDEvMNbwepZBFQlPm56wgRi8wrYS6w/upoNYpe8xMxL
	39kh4oISJ2c+gZojL9G8dTbzBEa+WUhSs5CkFjAyrWKUTC0ozk3PTTYsMMxLLdcrTswtLs1L
	10vOz93ECA5bLY0djPfm/9M7xMjEwXiIUYKDWUmEd9MWzzQh3pTEyqrUovz4otKc1OJDjNIc
	LErivIYzZqcICaQnlqRmp6YWpBbBZJk4OKUamMKbLRaIiDtk2U6o+HmVc6l2+zXl7UyuCT/v
	Fx3eXx1wtsQ+7buN807z/OxnHJp3W+1lsrhVNYLu1ejaV7nK/ebJya6NWvmPYQFvJVNg6pPO
	iE3Nc+bw1dxzlG5c23/00abp5f4aW5l9uJRnu8+7LKTMpp/qeyZGL8PFsnGVczyHh+aMs4qR
	kgIM75T9JfmnrPGXXOZU7jJRN6D/v/aXU2WibysO/n8r9fH7obfrDvsekviuVbO8ZNGu9LbE
	GC8WscJ/z1Ydcv3k+HFO+Grz3cFnyp4/WR20PbJk9Ue1Z9nPOdTjmH5MnTKt51flR+N1DWdT
	ixcuZtSUbeu7+vMs741ZDp6rNX+35D0P+rNEiaU4I9FQi7moOBEAjXhfpMoCAAA=
X-CMS-MailID: 20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76
References: <CGME20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76@epcas1p1.samsung.com>

Some of memory regions can be reserved for a specific purpose. They are
usually defined through reserved-memory in device tree. If only size
without address is specified in device tree, the address of the region
will be determined at boot time.

We may find the address of the memory regions through booting log, but
it does not show all. And it could be hard to catch the very beginning
log. The memblock_dump_all shows all memblock status but it does not
show region name and its information is difficult to summarize.

This patch introduce a debugfs node, memblock/memsize, to see reserved
memory easily.

Here's an example

$ cat debugfs/memblock/memsize

0x0000000000000000-0x0000000000000000 0x02000000 (   32768 KB )   map reusable linux,cma
0x0000000000000000-0x0000000000000000 0x01000000 (   16384 KB )   map reusable vxxxxx
..
0x0000000000000000-0x0000000000000000 0x004e0000 (    4992 KB ) nomap unusable unknown
0x0000000000000000-0x0000000000000000 0x00400000 (    4096 KB ) nomap unusable cxxxxx
0x0000000000000000-0x0000000000000000 0x00e00000 (   14336 KB ) nomap unusable gxxxxx

Reserved    : 1223856 KB
 .kernel    :  275208 KB
  .text     :   16576 KB
  .rwdata   :    1963 KB
  .rodata   :   11920 KB
  .bss      :    2450 KB
  .memmap   :  186368 KB
  .etc      :   55933 KB
 .unusable  :  948648 KB
System      : 11359056 KB
 .common    : 10306384 KB
 .reusable  : 1052672 KB
Total       : 12582912 KB ( 12288.00 MB )

Jaewon Kim (10):
  memblock: introduce memsize showing reserved memory
  memblock: detect hidden memory hole size
  memblock: handle overlapped reserved memory region
  memblock: take a region intersecting an unknown region
  memblock: track memblock changed at early param
  memblock: recognize late freed size by checking PageReserved
  memblock: track kernel size on memsize
  memblock: print memsize summary information
  memblock: print kernel internal size
  memblock: support memsize reusable to consider as reusable

 drivers/of/fdt.c             |  11 +
 drivers/of/of_reserved_mem.c |  12 +-
 include/linux/memblock.h     |  29 ++
 init/main.c                  |  13 +-
 kernel/dma/contiguous.c      |   9 +-
 mm/Kconfig                   |  16 ++
 mm/memblock.c                | 502 ++++++++++++++++++++++++++++++++++-
 mm/mm_init.c                 |   6 +-
 mm/page_alloc.c              |  10 +-
 9 files changed, 597 insertions(+), 11 deletions(-)

-- 
2.25.1


