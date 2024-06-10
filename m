Return-Path: <linux-kernel+bounces-208152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9542F90218A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104C41F2205E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642067F7C2;
	Mon, 10 Jun 2024 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="S6Nm3ea2"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AF577113
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718022191; cv=none; b=f715PPkXcK7BTSUo0QjLujMGkY+KI9qW84mq5gnX45xW/GPv1tbIoj4jgpSGkgPjNmDmWAiyioYcmryWTJaRFzvWv7aRgoGzwTeDtbHdaRkPcnimhKrGGEsX0ss//yV933BCK9F47gt4FU6FrDbuPtKTL+Vf7BbgOJPQrKMj8YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718022191; c=relaxed/simple;
	bh=7d9i+58e6dBb36/sG8fYBpYkG7bSXUpkicJTqR4VD+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=q0zQFH3h90uRk9mbXSX6/vsVvaN2zM1RXXYC4/TbU3xypJAR4ob3Eek2JxAUzP6R7er5f7D2G7nnHH+a2nO+A3ihhtRkqcgRN7EnKFcJBkI+DReRuQ93TcM5vj1mVqowOYNDbt6UeXq/uKg2OK96cO3WCPK+IrEGvECDKSpruNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=S6Nm3ea2; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240610122306euoutp01c47954fdffccf9c9f6c4fad44d333d1f~XpBN5sRNW3033030330euoutp01P
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:23:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240610122306euoutp01c47954fdffccf9c9f6c4fad44d333d1f~XpBN5sRNW3033030330euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718022186;
	bh=CnCZsV5T/yRx7EJUWazsH/UdvMjfCnEdsLuy6KtMCQY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=S6Nm3ea21u/g5O3Fwfu5cKfKtqygnuiR3ZiAIPCoN1YBr1+mPzfM7MyUAY6HCiQKW
	 INQ8w1sHfSyZO6bGUtoUJuSr0UI7V6uG5AtJxAa7ZT5/PFEbSwK59JKKUXzrIb4BCh
	 3jQwuJpaJj8/6dr9yfDSaTru0ehvNTi1A9CHzKv4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240610122305eucas1p1eec65f06d63065d0fd54cac8346403ec~XpBNf9_se1780817808eucas1p1S;
	Mon, 10 Jun 2024 12:23:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id B3.3F.09624.920F6666; Mon, 10
	Jun 2024 13:23:05 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240610122305eucas1p21bfd8a8c999b3fc8bfce04e5feea7bf7~XpBM9vXo02945629456eucas1p2U;
	Mon, 10 Jun 2024 12:23:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240610122305eusmtrp1b91027164b551ccff02e20fdfeeacd0d~XpBM86_6q0452304523eusmtrp1T;
	Mon, 10 Jun 2024 12:23:05 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-07-6666f029f713
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 63.7F.09010.920F6666; Mon, 10
	Jun 2024 13:23:05 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240610122305eusmtip157b12ffc46f2f23b4bc088546aec8df2~XpBMtRb1P0220802208eusmtip1_;
	Mon, 10 Jun 2024 12:23:05 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Mon, 10 Jun 2024 13:23:04 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Mon, 10 Jun
	2024 13:23:04 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"hughd@google.com" <hughd@google.com>, "willy@infradead.org"
	<willy@infradead.org>, "david@redhat.com" <david@redhat.com>,
	"wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
	"ying.huang@intel.com" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"shy828301@gmail.com" <shy828301@gmail.com>, "ziy@nvidia.com"
	<ziy@nvidia.com>, "ioworker0@gmail.com" <ioworker0@gmail.com>, Pankaj Raghav
	<p.raghav@samsung.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/6] mm: shmem: add multi-size THP sysfs interface
 for anonymous shmem
Thread-Topic: [PATCH v4 3/6] mm: shmem: add multi-size THP sysfs interface
	for anonymous shmem
Thread-Index: AQHatmiqHXo76DMAnkOAbuMz3VqPKLHA5EyA
Date: Mon, 10 Jun 2024 12:23:03 +0000
Message-ID: <denilwdvfb772l432ezexwmy46rzv7disxhryf2ktqmtfk5khe@ghq3sohl5z3w>
In-Reply-To: <119966ae28bf2e2d362ae3d369ac1a1cd27ba866.1717495894.git.baolin.wang@linux.alibaba.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9AB363482B0A1E419D5905675E523BEF@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7djPc7qaH9LSDH6uMLX4fFfIYs76NWwW
	//ceY7T4uv4Xs8XTT30sFot+G1tc3jWHzeLemv+sFj27pzJaLDixmNGi8fN9RovfP4ASJ2dN
	ZrGYffQeuwOfx5p5axg9ds66y+6xYFOpR8uRt6wem1doeSze85LJY9OnSeweJ2b8ZvHY+dDS
	o7f5HZvH+31X2Tw+b5IL4InisklJzcksSy3St0vgynj+7SxzwdfgimdvNBsYG127GDk5JARM
	JDYdfsXWxcjFISSwglFi9t0OZgjnC6PE5DPLWCGcz4wSk67uZoJpObDxJjtEYjmjxNKL+xhB
	EmBVV9p8IRJnGCX27DnKCOGsZJTY2rCABaSKTUBTYt/JTUDtHBwiAvoSvXPBGpgFprNKLL7c
	wwZSIywQL9F9cRMriC0ikCDR1baaDaLeSGJPjz5ImEVAVeLD40Z2EJtXwFdi2uzFYOWcAikS
	H1tOgq1iFJCVeLTyF1gNs4C4xK0n86E+EJRYNHsPM4QtJvFv10M2CFtH4uz1J4wQtoHE1qX7
	WCBsRYmOYzfZIOboSCzY/QnKtpTY9OU3E4StLbFs4WtmiHsEJU7OfMIC8peEwFYuiYdNXVCL
	XSR6+n+yQ9jCEq+Ob2GfwKgzC8l9s5DsmIVkxywkO2Yh2bGAkXUVo3hqaXFuemqxYV5quV5x
	Ym5xaV66XnJ+7iZGYIo8/e/4px2Mc1991DvEyMTBeIhRgoNZSYRXKCM5TYg3JbGyKrUoP76o
	NCe1+BCjNAeLkjivaop8qpBAemJJanZqakFqEUyWiYNTqoEpZmOndcGR895qZx1kkrY99N50
	8qrYw/likcumMqWKeqycm+bPYPVaJE3T6PM9wZbt5g53D0h2PjqssaDK9MuUS7IT3bY1HFA+
	aLlNQ8WTy+Je1flNsjG+v7rPCYi2cF6xk1w8f0I8R4lA52sNOa/E/0+jBX4sZmmc/dCrOMt2
	xiz7vXePaEvKc0xpOd08Uc2tq9+/y8bNRGD+d3tnOeFJK+StjyVP993Qumajk07UFg/Gec3P
	Dx+5FZb2MOnCn3LF3KvNn1ZdeJC6klvm72uDB2bXixQ7k+x29pjI7mtcoS1uIpMcynH3gvHc
	1K0zpp7a4Nb4WHZeDDszz/nUcMfbs29c/myVzjZ75QFNXi0lluKMREMt5qLiRAD6apE/AAQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsVy+t/xu7qaH9LSDPbcFrD4fFfIYs76NWwW
	//ceY7T4uv4Xs8XTT30sFot+G1tc3jWHzeLemv+sFj27pzJaLDixmNGi8fN9RovfP4ASJ2dN
	ZrGYffQeuwOfx5p5axg9ds66y+6xYFOpR8uRt6wem1doeSze85LJY9OnSeweJ2b8ZvHY+dDS
	o7f5HZvH+31X2Tw+b5IL4InSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3
	s0lJzcksSy3St0vQy3j+7SxzwdfgimdvNBsYG127GDk5JARMJA5svMnexcjFISSwlFHizoKl
	zBAJGYmNX66yQtjCEn+udbFBFH1klDh07C1UxxlGiRmXdkJlVjJKHNk5iQWkhU1AU2LfyU1A
	VRwcIgL6Er1zfUFqmAWms0osvtzDBlIjLBAvcfr3OrB1IgIJEjNvXGKBqDeS2NOjDxJmEVCV
	+PC4kR3E5hXwlZg2ezErxK5ZjBLzrkCcxymQIvGx5STYXkYBWYlHK3+BNTALiEvcejKfCeIF
	AYkle85DvSYq8fLxP6jXdCTOXn/CCGEbSGxduo8FwlaU6Dh2kw1ijo7Egt2foGxLiU1ffjNB
	2NoSyxa+ZoY4TlDi5MwnLBMYZWYhWT0LSfssJO2zkLTPQtK+gJF1FaNIamlxbnpusZFecWJu
	cWleul5yfu4mRmAC3Hbs55YdjCtffdQ7xMjEwXiIUYKDWUmEVygjOU2INyWxsiq1KD++qDQn
	tfgQoykw8CYyS4km5wNTcF5JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8T
	B6dUA1Ooz97fp3Qr2td6RkR//SfFdaTVS+BdWclat8IVc4NE903knhR5ybZZtSbFlXX2tVt3
	bG79LGW/qjlbOnHNjOeFcZerp8pyTP8+eb3ZzSNimavDlS2zsicabk79Uijec71QtFjrxew3
	Uw9cvPnZ7NbxC8Z3BXNUE5UlTdwap293NP0c0TXdgt9YnLXg0Iklzz0+xdozMB+f8ezv9Jaj
	b2f+MkqTuHnW7BtbP2e/+Qx+vdaXJVs3dT3L+8nxbs3sa18+T8uOsP/grMQZ/vlV3dFixXb3
	E28DJswPjtE9nauSUhTCGvrqp9nBP2p/r259wvX2wbSFLwSZpi5oX3/2gdPafw0uK3f/nfTe
	gNvy+tI8JZbijERDLeai4kQA3GmlnwkEAAA=
X-CMS-MailID: 20240610122305eucas1p21bfd8a8c999b3fc8bfce04e5feea7bf7
X-Msg-Generator: CA
X-RootMTR: 20240610122305eucas1p21bfd8a8c999b3fc8bfce04e5feea7bf7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240610122305eucas1p21bfd8a8c999b3fc8bfce04e5feea7bf7
References: <cover.1717495894.git.baolin.wang@linux.alibaba.com>
	<119966ae28bf2e2d362ae3d369ac1a1cd27ba866.1717495894.git.baolin.wang@linux.alibaba.com>
	<CGME20240610122305eucas1p21bfd8a8c999b3fc8bfce04e5feea7bf7@eucas1p2.samsung.com>

Hi Baolin,
On Tue, Jun 04, 2024 at 06:17:47PM +0800, Baolin Wang wrote:
> To support the use of mTHP with anonymous shmem, add a new sysfs interfac=
e
> 'shmem_enabled' in the '/sys/kernel/mm/transparent_hugepage/hugepages-kB/=
'
> directory for each mTHP to control whether shmem is enabled for that mTHP=
,
> with a value similar to the top level 'shmem_enabled', which can be set t=
o:
> "always", "inherit (to inherit the top level setting)", "within_size", "a=
dvise",
> "never". An 'inherit' option is added to ensure compatibility with these
> global settings, and the options 'force' and 'deny' are dropped, which ar=
e
> rather testing artifacts from the old ages.
>=20
> By default, PMD-sized hugepages have enabled=3D"inherit" and all other hu=
gepage
> sizes have enabled=3D"never" for '/sys/kernel/mm/transparent_hugepage/hug=
epages-xxkB/shmem_enabled'.
>=20
> In addition, if top level value is 'force', then only PMD-sized hugepages
> have enabled=3D"inherit", otherwise configuration will be failed and vice=
 versa.
> That means now we will avoid using non-PMD sized THP to override the glob=
al
> huge allocation.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 23 ++++++
>  include/linux/huge_mm.h                    | 10 +++
>  mm/huge_memory.c                           | 11 +--
>  mm/shmem.c                                 | 96 ++++++++++++++++++++++
>  4 files changed, 132 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index d414d3f5592a..b76d15e408b3 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -332,6 +332,29 @@ deny
>  force
>      Force the huge option on for all - very useful for testing;
> =20
> +Shmem can also use "multi-size THP" (mTHP) by adding a new sysfs knob to=
 control
> +mTHP allocation: '/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB=
/shmem_enabled',
> +and its value for each mTHP is essentially consistent with the global se=
tting.
> +An 'inherit' option is added to ensure compatibility with these global s=
ettings.
> +Conversely, the options 'force' and 'deny' are dropped, which are rather=
 testing
> +artifacts from the old ages.
> +always
> +    Attempt to allocate <size> huge pages every time we need a new page;
> +
> +inherit
> +    Inherit the top-level "shmem_enabled" value. By default, PMD-sized h=
ugepages
> +    have enabled=3D"inherit" and all other hugepage sizes have enabled=
=3D"never";
> +
> +never
> +    Do not allocate <size> huge pages;
> +
> +within_size
> +    Only allocate <size> huge page if it will be fully within i_size.
> +    Also respect fadvise()/madvise() hints;
> +
> +advise
> +    Only allocate <size> huge pages if requested with fadvise()/madvise(=
);
> +
>  Need of application restart
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> =20
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 020e2344eb86..fac21548c5de 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -6,6 +6,7 @@
>  #include <linux/mm_types.h>
> =20
>  #include <linux/fs.h> /* only for vma_is_dax() */
> +#include <linux/kobject.h>
> =20
>  vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
>  int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> @@ -63,6 +64,7 @@ ssize_t single_hugepage_flag_show(struct kobject *kobj,
>  				  struct kobj_attribute *attr, char *buf,
>  				  enum transparent_hugepage_flag flag);
>  extern struct kobj_attribute shmem_enabled_attr;
> +extern struct kobj_attribute thpsize_shmem_enabled_attr;
> =20
>  /*
>   * Mask of all large folio orders supported for anonymous THP; all order=
s up to
> @@ -265,6 +267,14 @@ unsigned long thp_vma_allowable_orders(struct vm_are=
a_struct *vma,
>  	return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
>  }
> =20
> +struct thpsize {
> +	struct kobject kobj;
> +	struct list_head node;
> +	int order;
> +};
> +
> +#define to_thpsize(kobj) container_of(kobj, struct thpsize, kobj)
> +
>  enum mthp_stat_item {
>  	MTHP_STAT_ANON_FAULT_ALLOC,
>  	MTHP_STAT_ANON_FAULT_FALLBACK,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 8e49f402d7c7..1360a1903b66 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -449,14 +449,6 @@ static void thpsize_release(struct kobject *kobj);
>  static DEFINE_SPINLOCK(huge_anon_orders_lock);
>  static LIST_HEAD(thpsize_list);
> =20
> -struct thpsize {
> -	struct kobject kobj;
> -	struct list_head node;
> -	int order;
> -};
> -
> -#define to_thpsize(kobj) container_of(kobj, struct thpsize, kobj)
> -
>  static ssize_t thpsize_enabled_show(struct kobject *kobj,
>  				    struct kobj_attribute *attr, char *buf)
>  {
> @@ -517,6 +509,9 @@ static struct kobj_attribute thpsize_enabled_attr =3D
> =20
>  static struct attribute *thpsize_attrs[] =3D {
>  	&thpsize_enabled_attr.attr,
> +#ifdef CONFIG_SHMEM
> +	&thpsize_shmem_enabled_attr.attr,
> +#endif
>  	NULL,
>  };
> =20
> diff --git a/mm/shmem.c b/mm/shmem.c
> index ae358efc397a..643ff7516b4d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -131,6 +131,14 @@ struct shmem_options {
>  #define SHMEM_SEEN_QUOTA 32
>  };
> =20
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static unsigned long huge_anon_shmem_orders_always __read_mostly;
> +static unsigned long huge_anon_shmem_orders_madvise __read_mostly;
> +static unsigned long huge_anon_shmem_orders_inherit __read_mostly;
> +static unsigned long huge_anon_shmem_orders_within_size __read_mostly;
> +static DEFINE_SPINLOCK(huge_anon_shmem_orders_lock);
> +#endif

Since we are also applying the new sysfs knob controls to tmpfs and anon mm=
,
should we rename this to get rid of the anon prefix?

> +
>  #ifdef CONFIG_TMPFS
>  static unsigned long shmem_default_max_blocks(void)
>  {
> @@ -4672,6 +4680,12 @@ void __init shmem_init(void)
>  		SHMEM_SB(shm_mnt->mnt_sb)->huge =3D shmem_huge;
>  	else
>  		shmem_huge =3D SHMEM_HUGE_NEVER; /* just in case it was patched */
> +
> +	/*
> +	 * Default to setting PMD-sized THP to inherit the global setting and
> +	 * disable all other multi-size THPs, when anonymous shmem uses mTHP.
> +	 */
> +	huge_anon_shmem_orders_inherit =3D BIT(HPAGE_PMD_ORDER);
>  #endif
>  	return;
> =20
> @@ -4731,6 +4745,11 @@ static ssize_t shmem_enabled_store(struct kobject =
*kobj,
>  			huge !=3D SHMEM_HUGE_NEVER && huge !=3D SHMEM_HUGE_DENY)
>  		return -EINVAL;
> =20
> +	/* Do not override huge allocation policy with non-PMD sized mTHP */
> +	if (huge =3D=3D SHMEM_HUGE_FORCE &&
> +	    huge_anon_shmem_orders_inherit !=3D BIT(HPAGE_PMD_ORDER))
> +		return -EINVAL;
> +
>  	shmem_huge =3D huge;
>  	if (shmem_huge > SHMEM_HUGE_DENY)
>  		SHMEM_SB(shm_mnt->mnt_sb)->huge =3D shmem_huge;
> @@ -4738,6 +4757,83 @@ static ssize_t shmem_enabled_store(struct kobject =
*kobj,
>  }
> =20
>  struct kobj_attribute shmem_enabled_attr =3D __ATTR_RW(shmem_enabled);
> +
> +static ssize_t thpsize_shmem_enabled_show(struct kobject *kobj,
> +					  struct kobj_attribute *attr, char *buf)
> +{
> +	int order =3D to_thpsize(kobj)->order;
> +	const char *output;
> +
> +	if (test_bit(order, &huge_anon_shmem_orders_always))
> +		output =3D "[always] inherit within_size advise never";
> +	else if (test_bit(order, &huge_anon_shmem_orders_inherit))
> +		output =3D "always [inherit] within_size advise never";
> +	else if (test_bit(order, &huge_anon_shmem_orders_within_size))
> +		output =3D "always inherit [within_size] advise never";
> +	else if (test_bit(order, &huge_anon_shmem_orders_madvise))
> +		output =3D "always inherit within_size [advise] never";
> +	else
> +		output =3D "always inherit within_size advise [never]";
> +
> +	return sysfs_emit(buf, "%s\n", output);
> +}
> +
> +static ssize_t thpsize_shmem_enabled_store(struct kobject *kobj,
> +					   struct kobj_attribute *attr,
> +					   const char *buf, size_t count)
> +{
> +	int order =3D to_thpsize(kobj)->order;
> +	ssize_t ret =3D count;
> +
> +	if (sysfs_streq(buf, "always")) {
> +		spin_lock(&huge_anon_shmem_orders_lock);
> +		clear_bit(order, &huge_anon_shmem_orders_inherit);
> +		clear_bit(order, &huge_anon_shmem_orders_madvise);
> +		clear_bit(order, &huge_anon_shmem_orders_within_size);
> +		set_bit(order, &huge_anon_shmem_orders_always);
> +		spin_unlock(&huge_anon_shmem_orders_lock);
> +	} else if (sysfs_streq(buf, "inherit")) {
> +		/* Do not override huge allocation policy with non-PMD sized mTHP */
> +		if (shmem_huge =3D=3D SHMEM_HUGE_FORCE &&
> +		    order !=3D HPAGE_PMD_ORDER)
> +			return -EINVAL;
> +
> +		spin_lock(&huge_anon_shmem_orders_lock);
> +		clear_bit(order, &huge_anon_shmem_orders_always);
> +		clear_bit(order, &huge_anon_shmem_orders_madvise);
> +		clear_bit(order, &huge_anon_shmem_orders_within_size);
> +		set_bit(order, &huge_anon_shmem_orders_inherit);
> +		spin_unlock(&huge_anon_shmem_orders_lock);
> +	} else if (sysfs_streq(buf, "within_size")) {
> +		spin_lock(&huge_anon_shmem_orders_lock);
> +		clear_bit(order, &huge_anon_shmem_orders_always);
> +		clear_bit(order, &huge_anon_shmem_orders_inherit);
> +		clear_bit(order, &huge_anon_shmem_orders_madvise);
> +		set_bit(order, &huge_anon_shmem_orders_within_size);
> +		spin_unlock(&huge_anon_shmem_orders_lock);
> +	} else if (sysfs_streq(buf, "madvise")) {
> +		spin_lock(&huge_anon_shmem_orders_lock);
> +		clear_bit(order, &huge_anon_shmem_orders_always);
> +		clear_bit(order, &huge_anon_shmem_orders_inherit);
> +		clear_bit(order, &huge_anon_shmem_orders_within_size);
> +		set_bit(order, &huge_anon_shmem_orders_madvise);
> +		spin_unlock(&huge_anon_shmem_orders_lock);
> +	} else if (sysfs_streq(buf, "never")) {
> +		spin_lock(&huge_anon_shmem_orders_lock);
> +		clear_bit(order, &huge_anon_shmem_orders_always);
> +		clear_bit(order, &huge_anon_shmem_orders_inherit);
> +		clear_bit(order, &huge_anon_shmem_orders_within_size);
> +		clear_bit(order, &huge_anon_shmem_orders_madvise);
> +		spin_unlock(&huge_anon_shmem_orders_lock);
> +	} else {
> +		ret =3D -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +struct kobj_attribute thpsize_shmem_enabled_attr =3D
> +	__ATTR(shmem_enabled, 0644, thpsize_shmem_enabled_show, thpsize_shmem_e=
nabled_store);
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE && CONFIG_SYSFS */
> =20
>  #else /* !CONFIG_SHMEM */
> --=20
> 2.39.3
> =

