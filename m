Return-Path: <linux-kernel+bounces-205673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F7F8FFEB5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC32F1F21B0A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FC515B556;
	Fri,  7 Jun 2024 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fCVgziKp"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA16615B13F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751141; cv=none; b=RvtY8IfaYgI9/DlEfOZR4YYmXiAdR4FAU5HycJjYDuK6vs3hN078mcTMB171WLbrsP00Nf400qL4jUIL1onE+NXB5AleBBooC9zxHLjGqZGUsBQcJneWguMGfkSrWPbGiLSgTHfXyBqY2HMNGeRMn1/SOYFtziPAvuO3j5O0TIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751141; c=relaxed/simple;
	bh=4ODdNXcGE+i4Br2kt9apEV26P18IMtkc2SHLbyldB5A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=KFK9DTMvkImw7P+pOZRNqvP+2jsJllbRnWFOjlmZy5dlPKaIMRSG9AlI4VgEHswNzQc1lN9Q/7+2HjYERwtpXjbY2IqLsk20g0o820UUHHhEA2Rnp0CB1vb0UP/5CiqrEbTup4dE4z4E1O+X5LTLYsb2P490mH+12UkVSE8aiqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fCVgziKp; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240607090530euoutp02f5a40142546f2864b75767045c9e50c7~WrY1R57c91536515365euoutp02N
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:05:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240607090530euoutp02f5a40142546f2864b75767045c9e50c7~WrY1R57c91536515365euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717751130;
	bh=Vpq9H/kjmvAhMY3dJIj3g+/MrXJEf4iiYcsIacCQpuk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=fCVgziKp+Yl2jIaAOsp57pSCenPHYdTk8sAwAj0byO5zxaafXYQt5Lze2FBgCTPHq
	 4QrraFuQ5SUbEHicthbxPpjk1qZxOEtp1lMBiVztnJUUZHX0tWIt4QXhDvcyq6D1Sl
	 mPUwiAllZm0trZ0fejQ64j1HWo6+JO3APpXYpPUw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240607090530eucas1p2897e6f5b0457164edaad0b9894d07b28~WrY1B8UL20052000520eucas1p2N;
	Fri,  7 Jun 2024 09:05:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 36.9B.09620.95DC2666; Fri,  7
	Jun 2024 10:05:30 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240607090529eucas1p2cf7749091a1d6e42edde4a2d646781a4~WrY0o8Pv33266332663eucas1p2z;
	Fri,  7 Jun 2024 09:05:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240607090529eusmtrp2f5b006b465e7abe99b140e05cb2464a7~WrY0nnllW1942519425eusmtrp2W;
	Fri,  7 Jun 2024 09:05:29 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-4d-6662cd594847
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 71.50.08810.95DC2666; Fri,  7
	Jun 2024 10:05:29 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240607090529eusmtip2c7a341d54e780e2c90f5786321db4ca1~WrY0R6sK82892028920eusmtip2l;
	Fri,  7 Jun 2024 09:05:29 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Fri, 7 Jun 2024 10:05:28 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Fri, 7 Jun
	2024 10:05:28 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: David Hildenbrand <david@redhat.com>
CC: Baolin Wang <baolin.wang@linux.alibaba.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "hughd@google.com" <hughd@google.com>,
	"willy@infradead.org" <willy@infradead.org>, "wangkefeng.wang@huawei.com"
	<wangkefeng.wang@huawei.com>, "ying.huang@intel.com" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "shy828301@gmail.com" <shy828301@gmail.com>,
	"ziy@nvidia.com" <ziy@nvidia.com>, "ioworker0@gmail.com"
	<ioworker0@gmail.com>, Pankaj Raghav <p.raghav@samsung.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] add mTHP support for anonymous shmem
Thread-Topic: [PATCH v3 0/6] add mTHP support for anonymous shmem
Thread-Index: AQHasjX9yP1IBMh0VkC4Fzv01OfbabGxBpEAgAAKfoCAABD5AIAGGG2AgAAYLgCAACcNAIAClQiAgABV3wCAAZnlAA==
Date: Fri, 7 Jun 2024 09:05:27 +0000
Message-ID: <igzsxllakdkjjsum55d6b2rvj4cnjsgg5povgbsu6ylshstqsy@wbvxj6jvpnmt>
In-Reply-To: <d5a22158-e663-43d2-a43e-8ad54bae16c8@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1295E43CB1DCAC4195F0A14C07F6C62C@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7djPc7pRZ5PSDD6EWHy+K2QxZ/0aNov/
	e48xWnxd/4vZ4umnPhaLRb+NLS7vmsNmcW/Nf1aLnt1TGS0WnFjMaNH4+T6jxe8fQImTsyaz
	WMw+eo/dgc9jzbw1jB47Z91l91iwqdSj5chbVo/NK7Q8Fu95yeSx6dMkdo8TM36zeOx8aOnR
	2/yOzeP9vqtsHp83yQXwRHHZpKTmZJalFunbJXBlnJi5n7VguXLFhZOb2BsY/0p1MXJwSAiY
	SDx84t7FyMUhJLCCUWLh7X9MEM4XRompfc3sEM5nRoljx76ywnSsaIYqWs4osfjjXxa4ojvb
	/kBlTgM58y8yww3esm0HWxcjJwebgKbEPqADQGwRAQ2JTW0bmEFsZoG5rBIH20NAbGEBB4mZ
	i3tZIWocJW40XWWDsLMkXs64AtbLIqAi8engErAaXgFfiSvda5lAbE4BO4lp5xeAzWQUkJV4
	tPIXO8R8cYlbT+aD1UgICEosmr2HGcIWk/i36yEbhK0jcfb6E0YI20Bi69J9LBC2kkTDgw9s
	EHN0JBbs/gRlW0osufWYFcLWlli28DUzxD2CEidnPoHqXcsl0X66EMJ2kbg8YT5UXFji1fEt
	7BMYdWYhOW8WkhWzkKyYhWTFLCQrFjCyrmIUTy0tzk1PLTbOSy3XK07MLS7NS9dLzs/dxAhM
	kKf/Hf+6g3HFq496hxiZOBgPMUpwMCuJ8PoVx6cJ8aYkVlalFuXHF5XmpBYfYpTmYFES51VN
	kU8VEkhPLEnNTk0tSC2CyTJxcEo1MEnw9xs5mkU8eP3/uOSyA2/8Fe5U7nRJrJ7Kw+HtrHU5
	9cTBmq76TV87VATVptl2z3tSyv/7/Qmngx8jq+tEu80SGDlq3JeGqCfEvZiRLZoj5Vl9O292
	1ozcRfK3+cumPmwM7l1Y+7mu/TDfcdaqL2cv2So0+lWumfJuc0X3is8+Xgy+buF5V69JCkZJ
	MXj6HBQN8ungZBBcdOCRnmFmr4/Q5VDrbzcN/BeunhwmLTxX58L0tGKzlToxz9Ue33VRu/gi
	T2XJrdXXGYSqztX7M74Tqc5KzPCaeGD22vSWlkWbRX4J3jp/drPOlPcGsxzETjbcPqZ5UmZh
	1DdTpyUnLSs4A3vaP8y6zbp8ittqJZbijERDLeai4kQAtkI79/8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsVy+t/xe7qRZ5PSDDY8lbf4fFfIYs76NWwW
	//ceY7T4uv4Xs8XTT30sFot+G1tc3jWHzeLemv+sFj27pzJaLDixmNGi8fN9RovfP4ASJ2dN
	ZrGYffQeuwOfx5p5axg9ds66y+6xYFOpR8uRt6wem1doeSze85LJY9OnSeweJ2b8ZvHY+dDS
	o7f5HZvH+31X2Tw+b5IL4InSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3
	s0lJzcksSy3St0vQyzgxcz9rwXLligsnN7E3MP6V6mLk4JAQMJFY0czUxcjFISSwlFFiTf8u
	IIcTKC4jsfHLVVYIW1jiz7UuNoiij4wS8/9dZIdwTjNKLNnznhnCWcEo8ex8OwtIC5uApsQ+
	oDUgtoiAhsSmtg3MIDazwFxWiYPtISC2sICDxMzFvawQNY4SN5quskHYWRIvZ1wB62URUJH4
	dHAJWA2vgK/Ele61ULe+ZJG4sqcD7FZOATuJaecXgC1gFJCVeLTyFzvEMnGJW0/mQ/0jAHTp
	eWYIW1Ti5eN/UL/pSJy9/oQRwjaQ2Lp0HwuErSTR8OADG8QcHYkFuz9B2ZYSS249ZoWwtSWW
	LXzNDHGcoMTJmU9YJjDKzEKyehaS9llI2mchaZ+FpH0BI+sqRpHU0uLc9NxiQ73ixNzi0rx0
	veT83E2MwBS47djPzTsY5736qHeIkYmD8RCjBAezkgivX3F8mhBvSmJlVWpRfnxRaU5q8SFG
	U2DgTWSWEk3OBybhvJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkG
	Jr72HVyC3YdWTBN3s1mtm/o4n+2jvcGyrsMtW37LLVH75BwiL59QZnxl3dmM4tSoZPbCWXee
	mLb0rNvxNmiN2cwfud8vcQevslT0OS/8s8lSzoWt371Kc3bNikt7zV7NOcMuJPrQT9RwrUZS
	d9/xFTMvp5flnYzhOCq3i3FViZ/wn96GBx51rcVyCqwlJS/tw6Xkpm6v8pnA7c+w0ca+oV2S
	3eLlintl5jzWugzLuS4a7e3c8v/py/zamSXOx9bsm24sMoVrr0/sQ+8TL8yVPC5c3Xw+7sZq
	1R6N1fLfRJ7s1n32uMrSu3IvH0c958RjCZnTW+3le0TPNvkVuj09oCZ772gZo9nsWwufp75Q
	YinOSDTUYi4qTgQADCdnXgoEAAA=
X-CMS-MailID: 20240607090529eucas1p2cf7749091a1d6e42edde4a2d646781a4
X-Msg-Generator: CA
X-RootMTR: 20240531111357eucas1p2338be7f326d8d9176d2ee212a10fc9db
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240531111357eucas1p2338be7f326d8d9176d2ee212a10fc9db
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
	<f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com>
	<db3517d0-54b1-4d3a-b798-1c13572d07be@linux.alibaba.com>
	<CGME20240531111357eucas1p2338be7f326d8d9176d2ee212a10fc9db@eucas1p2.samsung.com>
	<502fb3df-b42b-4f0c-a98d-348c3d544721@redhat.com>
	<slkkien5nc3weyzebdlxs5jjvealqzmctbom7sfvijvkolhsjj@athcc2aqq77p>
	<f11c1b52-67d1-4c2a-834b-47302b0054bc@linux.alibaba.com>
	<5mezgqzg7wmd4iq2d2q3aentziosetwcll3tgdbl3mhriseyv3@pgxsux7qvxno>
	<e7b4aaa1-170d-4500-bf7a-63672e4d81b8@linux.alibaba.com>
	<d5a22158-e663-43d2-a43e-8ad54bae16c8@redhat.com>

On Thu, Jun 06, 2024 at 10:38:22AM +0200, David Hildenbrand wrote:
> On 06.06.24 05:31, Baolin Wang wrote:
> >=20
> >=20
> > On 2024/6/4 20:05, Daniel Gomez wrote:
> > > On Tue, Jun 04, 2024 at 05:45:20PM +0800, Baolin Wang wrote:
> > > >=20
> > > >=20
> > > > On 2024/6/4 16:18, Daniel Gomez wrote:
> > > > > On Fri, May 31, 2024 at 01:13:48PM +0200, David Hildenbrand wrote=
:
> > > > > > > >=20
> > > > > > > > As a default, we should not be using large folios / mTHP fo=
r any shmem,
> > > > > > > > just like we did with THP via shmem_enabled. This is what t=
his series
> > > > > > > > currently does, and is aprt of the whole mTHP user-space in=
terface design.
> > > > > > > >=20
> > > > > > > > Further, the mTHP controls should control all of shmem, not=
 only
> > > > > > > > "anonymous shmem".
> > > > > > >=20
> > > > > > > Yes, that's what I thought and in my TODO list.
> > > > > >=20
> > > > > > Good, it would be helpful to coordinate with Daniel and Pankaj.
> > > > >=20
> > > > > I've integrated patches 11 and 12 from the lsf RFC thread [1] on =
top of Baolin's
> > > > > v3 patches. You may find a version in my integration branch here =
[2]. I can
> > > > > attach them here if it's preferred.
> > > > >=20
> > > > > [1] https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@s=
amsung.com/
> > > > > [2] https://protect2.fireeye.com/v1/url?k=3Da23e7c06-c3b56926-a23=
ff749-74fe485fb347-371ca2bfd5d9869f&q=3D1&e=3D6974304e-a786-4255-93a7-57498=
540241c&u=3Dhttps%3A%2F%2Fgitlab.com%2Fdkruces%2Flinux-next%2F-%2Fcommits%2=
Fnext-20240604-shmem-mthp
> > > > >=20
> > > > > The point here is to combine the large folios strategy I proposed=
 with mTHP
> > > > > user controls. Would it make sense to limit the orders to the map=
ping order
> > > > > calculated based on the size and index?
> > > >=20
> > > > IMO, for !anon shmem, this change makes sense to me. We should resp=
ect the
> > > > size and mTHP should act as a order filter.
> > >=20
> > > What about respecing the size when within_size flag is enabled? Then,=
 'always'
> > > would allocate mTHP enabled folios, regardless of the size. And 'neve=
r'
> > > would ignore mTHP and size. So, 'never' can be used for this 'safe' b=
oot case
> > > mentioned in the discussion.
> >=20
> > Looks reasonable to me. What do you think, David?
> >=20
>=20
> That mimics existing PMD-THP behavior, right?
>=20
> With "within_size", we must not exceed the size, with "always", we may
> exceed the size.

But right now we only check the inode size. With large folio support in
write_iter() we can have access to the length as well. I think this would s=
olve
(paratially?) the cases where we don't have access to the file size and if =
we
perform writes in bigger chunks.

E.g. xfs_io -t -f -c "pwrite -b 2M -S 0x58 0 2M" /mnt/test/file

For 'within_size', the example above would allocate 512 pages instead of on=
e
huge page. After patches [1] [2] we can get the size of the write to alloca=
te
whatever mTHP/THP makes more sense for the length being passed.

[1] https://lore.kernel.org/all/20240527163616.1135968-2-hch@lst.de/
[2] https://lore.kernel.org/all/20240515055719.32577-12-da.gomez@samsung.co=
m/

Here a quick hack for THP:

@@ -561,7 +561,8 @@ bool shmem_is_huge(struct inode *inode, pgoff_t index, =
bool shmem_huge_force,
        case SHMEM_HUGE_WITHIN_SIZE:
                index =3D round_up(index + 1, HPAGE_PMD_NR);
                i_size =3D round_up(i_size_read(inode), PAGE_SIZE);
-               if (i_size >> PAGE_SHIFT >=3D index)
+               if ((i_size >> PAGE_SHIFT >=3D index) ||
+                   (len >> PAGE_SHIFT >=3D index))
                        return true;
                fallthrough;


>=20
> > And what about 'advise' option? Silimar to 'within_size'?
>=20
> Good question. What's the behavior of PMD-THP? I would assume it behaves
> like "within_size", because in the common case we mmap (+advise) only wit=
hin
> the size of the file, not exceeding it.

It allocates a huge page on request when MADV_HUGEPAGE (regardless of the s=
ize).

>=20
> (the always option, as I learned during the meeting, is primarily helpful
> when writing to tmpfs files in an append-fashion. With mmap()+madvise() t=
hat
> doesn't quite happen)

Let's benefit of larger writes as well if the chunk matches any of the mTHP=
/
THP sizes.

>=20
> --=20
> Cheers,
>=20
> David / dhildenb
> =

