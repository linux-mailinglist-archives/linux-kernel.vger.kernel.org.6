Return-Path: <linux-kernel+bounces-410683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 197689CDFB1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9602283AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6A31BBBDD;
	Fri, 15 Nov 2024 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JpozrPti"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD861B6CE0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731676606; cv=none; b=tfuXiE1yXgWu1fOT3icvIgJbyFQZnjUyCBsfsUBR6HzuC2uCKcFlLsd2DWd/hIcjttdfQkTOika5p9Zxc7iezXux9ROrsrA7jlnsGmIY8nQN+sbKWSaF7c274AT02tqyMf5R0lpkuaKu+H6wTCKb+3HksQ5UsbDPG55cxUBo9eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731676606; c=relaxed/simple;
	bh=EIwoXzsQHOVgmvX5r0YyrQJ0kBDcpOvRVXNODIrKk0w=;
	h=MIME-Version:Content-Type:Date:Message-ID:Subject:CC:To:From:
	 In-Reply-To:References; b=ZishLxxP/Grv7iYkGS0vwrG5Mb4LXX+4jr3nvFPHWr70XvIeyKi5+9JL1Wv22QMiivoTcq1otylogTbqraSAwue5hsu7KDn/GZ22DNDVUwza91VB3hc9AeBvY/AOV77UIny0ucuPWbkH6KSGZOI26Za0XjPw3TC/V2NiDVPVJ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JpozrPti; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241115131635euoutp02e068c1f2761ddd90c8aeaef940c2e09f~IJrBp4Xya3070830708euoutp02Y
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:16:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241115131635euoutp02e068c1f2761ddd90c8aeaef940c2e09f~IJrBp4Xya3070830708euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731676595;
	bh=oKtBlcg+Xk0nMe89sjRussk1NGC8X6gMBOv0pcE62OE=;
	h=Date:Subject:CC:To:From:In-Reply-To:References:From;
	b=JpozrPtiGlJ5ssxv/Ln0+D+V98//lbmBBTemU3rPXoGzsazjO5HEkfZTV9NXZZzdH
	 KN4HVsrWT7e63Z66KD8sQS1AWD5tTe9j+0HcrNT4LPI8BOkvPq3By/30xjCS791ZXv
	 TcvLgKiZujyWwSLnolOI5yCrN4vbvBit1B/+MeFk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241115131635eucas1p11c362344e28e0c34c0cb1c990cef95c7~IJrBPiWLy2565925659eucas1p1n;
	Fri, 15 Nov 2024 13:16:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 32.A0.20409.3B947376; Fri, 15
	Nov 2024 13:16:35 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241115131634eucas1p2db22b75fcc768a4bb6aa47ee180110cc~IJrA0RIZy2411724117eucas1p2E;
	Fri, 15 Nov 2024 13:16:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241115131634eusmtrp1b4622e731af2f59b0ff4f7cd6e4deebc~IJrAzpubZ1966419664eusmtrp1_;
	Fri, 15 Nov 2024 13:16:34 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-58-673749b37ee2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 32.AD.19920.2B947376; Fri, 15
	Nov 2024 13:16:34 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241115131634eusmtip205bf655c0e2988b21bc90d482630c7c6~IJrAnu3g-1697916979eusmtip2z;
	Fri, 15 Nov 2024 13:16:34 +0000 (GMT)
Received: from localhost (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 15 Nov 2024 13:16:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Nov 2024 14:16:33 +0100
Message-ID: <D5MS4CMG4N8F.1M5WPZ1T5UT0I@samsung.com>
Subject: Re: [PATCH v2 0/5] Support large folios for tmpfs
CC: <willy@infradead.org>, <david@redhat.com>, <wangkefeng.wang@huawei.com>,
	<21cnbao@gmail.com>, <ryan.roberts@arm.com>, <ioworker0@gmail.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
	<akpm@linux-foundation.org>, <hughd@google.com>
From: Daniel Gomez <da.gomez@samsung.com>
X-Mailer: aerc 0.18.2-67-g7f69618ac1fd
In-Reply-To: <cover.1731397290.git.baolin.wang@linux.alibaba.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsWy7djPc7qbPc3TDbqmi1p8vitkMWf9GjaL
	/3uPMVp8Xf+L2eLppz4Wi0W/jS0u75rDZnFvzX9Wi57dUxktGj/fZ7T4/WMOmwO3x5p5axg9
	ds66y+6xYFOpR8uRt6wem1doeWz6NInd48SM3yweOx9aerzfd5XN4/MmuQCuKC6blNSczLLU
	In27BK6MSdMnMxdMkK6YP/suewPjdNEuRk4OCQETiVOHN7F0MXJxCAmsYJTYuuA9G4TzhVFi
	zsnrzBDOZ0aJg9+/ssG0fF4ylR0isZxRYt3a6UxwVRtbZ0BlNjNKTPrymxGkhVdAUOLkzCcs
	IDazgLbEsoWvmSFsTYnW7b/ZQWwWAVWJT4vOsUDUm0jM/X+ctYuRg0NYwEri6QdtkJnMAicZ
	JWbdbwI7Q0QgSaJx7g6wOWxAc/ad3MQOcZ6axP/+iWBzOAUcJV5NvcICEVeUmDFxJZRdK3Fq
	yy2wqyUEVnNKTO06xwqRcJG4e/4y1CBhiVfHt0DZMhKnJ/dANadLLFk3C8oukNhzexbYoRIC
	1hJ9Z3Igwo4Sy7bNY4cI80nceCsI8S6fxKRt05khwrwSHW1CExhVZiEF0CykAJqFFEALGJlX
	MYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBKav0/+Of9nBuPzVR71DjEwcjIcYJTiYlUR4
	L7mapwvxpiRWVqUW5ccXleakFh9ilOZgURLnVU2RTxUSSE8sSc1OTS1ILYLJMnFwSjUwTVYS
	SGETN7yyc66H/9P3T0v9+o/Psp7yUJLda/lCrz3Lbt3ZwaZvWnLtx8tpUvlRHQuDsnXCmdb7
	c62taV0zQejPktA2aR3THrWgvCfzj0898+jKrsiHPb5Cd7R5VCL+VpRMqXxm23rB/ODJip1Z
	Nx6ct6nNn7yFze9iRJLRG4+qLuufgTeuPF228rQeh6DD8TTlfBPTBVv8eHKaXd65h1Rs67u6
	bwkfk3GM1Yyu5Wukv1hu2jTn7Mc7nx4tuf3qZsYHi1btmNuas2e9VHgleZz3qHLcfYukx5Mf
	sTJqHlJ1qMhdv23ZvKwswyoLnrmhnHuX8+Y/75wzd3JgfnzAuhdbX996yKI9T0plfZ7OaSWW
	4oxEQy3mouJEABJ/YGXOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xe7qbPM3TDSadMrH4fFfIYs76NWwW
	//ceY7T4uv4Xs8XTT30sFot+G1tc3jWHzeLemv+sFj27pzJaNH6+z2jx+8ccNgdujzXz1jB6
	7Jx1l91jwaZSj5Yjb1k9Nq/Q8tj0aRK7x4kZv1k8dj609Hi/7yqbx+dNcgFcUXo2RfmlJakK
	GfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZk6ZPZi6YIF0xf/Zd
	9gbG6aJdjJwcEgImEp+XTGXvYuTiEBJYyijx/9dbRoiEjMTGL1dZIWxhiT/Xutggij4ySry+
	9oYFwtnMKPH42nQ2kCpeAUGJkzOfsIDYzALaEssWvmaGsDUlWrf/ZgexWQRUJT4tOscCUW8i
	Mff/caANHBzCAlYSTz9og8xkFjjJKDHrfhPYTBGBJIl7e3aC1bMBzdl3chM7xEVqEv/7J4LF
	hQQcJLbuPgtmcwo4SryaeoUFokZRYsbElVB2rcTnv88YJzCKzEJy6iwkp85CcuoCRuZVjCKp
	pcW56bnFhnrFibnFpXnpesn5uZsYgfG97djPzTsY5736qHeIkYmD8RCjBAezkgjvJVfzdCHe
	lMTKqtSi/Pii0pzU4kOMpkA/T2SWEk3OByaYvJJ4QzMDU0MTM0sDU0szYyVxXrfL59OEBNIT
	S1KzU1MLUotg+pg4OKUamIxKN7Z5Ob95niVkKbxz6fOFPtuE3rfw/jKKXG7sl9pS9qav+nW+
	A/MXntQ1Qj9OaixqS16r5yfBeDfohdSvSUYlO4T3cgXbT1Cz+l0fyW/W8yPL+t/uc/1RQT16
	xrGv3n22EHIo7wwoX9Eh9ZXxepxLpsaWv8Lry3cEq+beea7Ilq+c31jJ81Lz9RuxnTfLOfiE
	4/fyrp8Yprr99C7ec3b/Xz8+fWGSenT3yQcK4QU7Az5MF/xyYs/kJRnz2BPrgrzeTuxJt1et
	3XipjJt3U+PMh6KpDxXsJrtK7s7n/1pRkyRXvnvZj0itxgcHzoTIN3wrKF9uErzC4YHX7BOi
	ktr/pz6wWPhtNfu1PQLLlFiKMxINtZiLihMBCRvQL3gDAAA=
X-CMS-MailID: 20241115131634eucas1p2db22b75fcc768a4bb6aa47ee180110cc
X-Msg-Generator: CA
X-RootMTR: 20241115131634eucas1p2db22b75fcc768a4bb6aa47ee180110cc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241115131634eucas1p2db22b75fcc768a4bb6aa47ee180110cc
References: <cover.1731397290.git.baolin.wang@linux.alibaba.com>
	<CGME20241115131634eucas1p2db22b75fcc768a4bb6aa47ee180110cc@eucas1p2.samsung.com>

On Tue Nov 12, 2024 at 8:45 AM CET, Baolin Wang wrote:
> Traditionally, tmpfs only supported PMD-sized huge folios. However nowada=
ys

Nitpick:
We are mixing here folios/page, PMD-size huge. For anyone not aware of
Memory Folios conversion in the kernel I think this makes it confusing.
Tmpfs has never supported folios so, this is not true. Can we rephrase
it?

Below you are also mixing terms huge/large folios etc. Can we be
consistent? I'd stick with folios (for order-0), and large folios (!
order-0). I'd use huge term only when referring to PMD-size pages.

> with other file systems supporting any sized large folios, and extending
> anonymous to support mTHP, we should not restrict tmpfs to allocating onl=
y
> PMD-sized huge folios, making it more special. Instead, we should allow

Again here.

> tmpfs can allocate any sized large folios.
>
> Considering that tmpfs already has the 'huge=3D' option to control the hu=
ge
> folios allocation, we can extend the 'huge=3D' option to allow any sized =
huge

'huge=3D' has never controlled folios.

> folios. The semantics of the 'huge=3D' mount option are:
>
> huge=3Dnever: no any sized huge folios
> huge=3Dalways: any sized huge folios
> huge=3Dwithin_size: like 'always' but respect the i_size
> huge=3Dadvise: like 'always' if requested with fadvise()/madvise()
>
> Note: for tmpfs mmap() faults, due to the lack of a write size hint, stil=
l
> allocate the PMD-sized huge folios if huge=3Dalways/within_size/advise is=
 set.
>
> Moreover, the 'deny' and 'force' testing options controlled by
> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', still retain the sam=
e
> semantics. The 'deny' can disable any sized large folios for tmpfs, while
> the 'force' can enable PMD sized large folios for tmpfs.
>
> Any comments and suggestions are appreciated. Thanks.
>
> Changes from v1:
>  - Add reviewed tag from Barry and David. Thanks.
>  - Fix building warnings reported by kernel test robot.
>  - Add a new patch to control the default huge policy for tmpfs.
>
> Changes from RFC v3:
>  - Drop the huge=3Dwrite_size option.
>  - Allow any sized huge folios for 'hgue' option.
>  - Update the documentation, per David.
>
> Changes from RFC v2:
>  - Drop mTHP interfaces to control huge page allocation, per Matthew.
>  - Add a new helper to calculate the order, suggested by Matthew.
>  - Add a new huge=3Dwrite_size option to allocate large folios based on
>    the write size.
>  - Add a new patch to update the documentation.
>
> Changes from RFC v1:
>  - Drop patch 1.
>  - Use 'write_end' to calculate the length in shmem_allowable_huge_orders=
().
>  - Update shmem_mapping_size_order() per Daniel.
>
> Baolin Wang (4):
>   mm: factor out the order calculation into a new helper
>   mm: shmem: change shmem_huge_global_enabled() to return huge order
>     bitmap
>   mm: shmem: add large folio support for tmpfs
>   mm: shmem: add a kernel command line to change the default huge policy
>     for tmpfs
>
> David Hildenbrand (1):
>   docs: tmpfs: update the huge folios policy for tmpfs and shmem
>
>  .../admin-guide/kernel-parameters.txt         |   7 +
>  Documentation/admin-guide/mm/transhuge.rst    |  64 ++++++--
>  include/linux/pagemap.h                       |  16 +-
>  mm/shmem.c                                    | 148 ++++++++++++++----
>  4 files changed, 183 insertions(+), 52 deletions(-)


