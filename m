Return-Path: <linux-kernel+bounces-374447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEA69A6A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F77280FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC47A1F8EF5;
	Mon, 21 Oct 2024 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kDvtQ+1l"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894081F81B7
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517655; cv=none; b=kUceDEKWTm2Z2lFXAEdGlkxRVZkd7nDhpDBcqc4YFvfY1vlK4+KBmxHT9P8VIDGjuaxtCBx0Rfllxf6pUb2DoL3MBIlbjj7lZEkYPGt+vE/2itGM2/UvKUpRwvY2307DRYopqbGTGF2Gp/LI4GZrlNF8qQCdX7IVIP3zVaMWdSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517655; c=relaxed/simple;
	bh=FIMvNEgObPb/O/JTA3PFxB/zJpqd8FpNWC+75m7h46Y=;
	h=MIME-Version:Content-Type:Date:Message-ID:CC:Subject:From:To:
	 In-Reply-To:References; b=f+rdrKUsFNJq9rAfIbWkTJzdI9/JBfLeuMpYT8k8gBHCzTp7TdYWDFAMFOmWHPsaFXFdeZ3hffDe7CYEhIwe60/Yr8MrUustPXk949xpDIF7dizVxImVWeln7Z8VPXf/kyfZeipLLbegDfVzHxcvKS0mQFEQJdJTbs8RGgFtmHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kDvtQ+1l; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241021133405euoutp024075e0c04c8c4b6886be852902862d23~AeyKVY1IY2471524715euoutp02E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:34:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241021133405euoutp024075e0c04c8c4b6886be852902862d23~AeyKVY1IY2471524715euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729517645;
	bh=/GlGoWO1KXI0pNd+E2lielZpzBFWB68sQ9FCHRBX3sg=;
	h=Date:CC:Subject:From:To:In-Reply-To:References:From;
	b=kDvtQ+1lDbDQDbG90lMrqo8vslt6NyL8f6jKrnfaZV1+Ficzhj3YCaXYFnZ1PfqBC
	 W8obrg/XO69CfU8w35UZYmz5RBNp1cY5iaUCkakBLGa8MeTFmw93AZh6AEkF865aH1
	 3iDJ76TRXoIXAUM+oCAwoix7F3nk7B6fd8tg6aKc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241021133405eucas1p14bb0a6b2ab9713c595f363b78207e696~AeyKCMSNk1043010430eucas1p1K;
	Mon, 21 Oct 2024 13:34:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id C1.8A.20409.C4856176; Mon, 21
	Oct 2024 14:34:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241021133404eucas1p24c126e03f496270d49a7d074fe27a90a~AeyJoJ-z72043420434eucas1p2B;
	Mon, 21 Oct 2024 13:34:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241021133404eusmtrp1bd8ff4b0f4ff252b29d71461c3bb0d4b~AeyJnf1C_2503525035eusmtrp1O;
	Mon, 21 Oct 2024 13:34:04 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-cd-6716584ca96f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 2B.78.19654.C4856176; Mon, 21
	Oct 2024 14:34:04 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241021133404eusmtip2a0696345220e5c9e650587cba7149cfb~AeyJbDox52760427604eusmtip2P;
	Mon, 21 Oct 2024 13:34:04 +0000 (GMT)
Received: from mail.scsc.local (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 21 Oct 2024 14:34:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 21 Oct 2024 15:34:03 +0200
Message-ID: <D51IU4N746MI.FDS6C7GYO4RP@samsung.com>
CC: Matthew Wilcox <willy@infradead.org>, <akpm@linux-foundation.org>,
	<hughd@google.com>, <david@redhat.com>, <wangkefeng.wang@huawei.com>,
	<21cnbao@gmail.com>, <ryan.roberts@arm.com>, <ioworker0@gmail.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, "Kirill A . Shutemov"
	<kirill.shutemov@linux.intel.com>
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
From: Daniel Gomez <da.gomez@samsung.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>, Baolin Wang
	<baolin.wang@linux.alibaba.com>
X-Mailer: aerc 0.18.2-67-g7f69618ac1fd
In-Reply-To: <ppgciwd7cxmeqssryshe42lxwb4sdzr6gjhwwbotw4gx2l7vi5@7y4hedxpf4nx>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfVCLcRy/3/M8W8+y6THRT16b8lIqb+ceh8L549FR3HE6LzF6TGxr7Vle
	ck4hnLqlGFk1lfeM3JrayO4kSyThOvSyvBRdLo5VyjBrz7j++3w/L/f7fL/3w1FhHccfT5Cr
	aKVcLBVxvbFy68Cz0BWxoyUzq/ULSXurkMwv1XNJ5z0rIHtLf6Jkx3c1RhY75pBvPuVjpD67
	CCVf3snnkja9k0Nm3tUAMs3eBkhHfz53sYDS6/SAMmtbvahCQzJ1pLqbQ5VdDaYM33O8qEe5
	Dowyv5tP6WpXU18tjVwqT92BUHbDhFX89d4L42lpwm5aGR6xxXvHW8cGhSFgb3vhI04qOOl/
	AvBwSMyFaQXFnBPAGxcSVwE0au1cdugBsKHyF8IOdpfS9drrX6TpzGGPcAXA2ucazn9XhrHC
	ix3MALZYK9wRATEC1p5rxwYxSoTAy0WfURZPh+kVDrcHI4LgzdZUF8Zd/jnwdxmftVgRWN42
	bRCPJCKgqciMDGKuK2qpNbijvkQc/NnfiLLtpkBnVrb7KR4RDW83ZnpaB8Dc7GsYiw/Ax8Ym
	9waQeMCDnV0mhBWWwTSNyWMaCbtqjJ7wOPjkVKaHl8CLN7UerICVzVrOYGdILIDqOilLL4H1
	j50ISw+Hr7tHsKsMhznlZ1GWFsDjR4UnQaB2yH20Q+6jHXKfQoCWAD86mZFJaGa2nN4Txohl
	TLJcErYtUWYArg/35E9Njwlc6foWVgUQHFQBiKMiX4FINUoiFMSL96XQysTNymQpzVSBsTgm
	8hMExU+khYRErKJ30bSCVv5TEZznn4qUyprW2FYNVCeZQtd+VC14hQ70vv/6MrJj8tNqtX9o
	2/gfi31b9bGxOz+Eb8zJOa+5ZTPvOepT2X976zfLsXDL0oBLp/mFP1qkeY4NF1MCI9UpRs2h
	mJUN9pgxhx7OK8fzfCrPLdoEkGmn9qfLSOvyDHEx1VeyOUkXVOY3w/plWGOn7P4F0Xbds4Sd
	lqxxxXHNaNWYqFndxpV9b170hUSvD8kNpnXcKF5I/Q2VVvFuE8PvUPB7kPblcltwXG7duuOB
	/JJ1i5wR6RPWXJ/UJ3Aw+8ui6ndv9IlMemDLKDA1Z5c+VTT4nVUI9QN4C5ooi60hUpMmT+08
	eLjgQ5Zvb0tUoAhjdohnBaNKRvwXixyF0d8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsVy+t/xe7o+EWLpBn92y1t8vitkMWf9GjaL
	/3uPMVp8Xf+L2eLppz4Wi0W/jS1uPp/DYrFm4kJmi8u75rBZ3Fvzn9WiZ/dURovGz/cZLX7/
	mMPmwOuxZt4aRo+ds+6yeyzYVOrRcuQtq8fmFVoemz5NYvc4MeM3i8fOh5Ye804Gerzfd5XN
	Y3bfUyaPz5vkAnii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMy
	y1KL9O0S9DIe/I4u2KRY8WTBCdYGxglSXYycHBICJhK3pjUzdTFycQgJLGWU+P/jMhtEQkZi
	45errBC2sMSfa11gcSGBj4wS908pQjTsZJRY8KobrIhXQFDi5MwnLCA2s4C2xLKFr5khbE2J
	1u2/2UFsFgFViXV3G4BsDqB6Y4m/m3kgSo4xSWy7rwFiCwvYSexYuJMJxGYDat13chNYq4hA
	nMSvH1eZIe5Rk/jfP5EF4oZdzBJ9lz+AJTgF/CS2Xu1hhyhSlJgxcSULhF0r8fnvM8YJjCKz
	kJw6C8mps5CcuoCReRWjSGppcW56brGRXnFibnFpXrpecn7uJkZgAth27OeWHYwrX33UO8TI
	xMF4iFGCg1lJhFepRDRdiDclsbIqtSg/vqg0J7X4EKMp0M8TmaVEk/OBKSivJN7QzMDU0MTM
	0sDU0sxYSZyX7cr5NCGB9MSS1OzU1ILUIpg+Jg5OqQamjbP3JvnpPBcovpyyptk5fIPz+TNB
	rYGzSwy9m7SPmlvcf5dkUi8kHrL2Xn1kyp7E6U/KFV7olj5pm/6f0UfRd4NRcJBfquP+0/Ys
	wtc2HpR/cavyvZxDrnKvmIhi8R0GjzXxRV8tM/J5bmTtNbmxZuOclGP7DfkO7P8cof5SiSU9
	4wuXxoHNV5dcvxq5be+0GO01l5iS3eakXmavD1/v6b1IeVrDTNPtPumXbzd9P6m9bfF1r3NK
	V1ft6s9nq5up8G/DQoOpjs9UOx2bTh7fYb/4ep0en5X88dN/o/fUyFtIfuc6vPfQZfe7LN3B
	SRGzP076fv720sRfa3rYuqadDq546nqs2HQnV0+154T9SizFGYmGWsxFxYkA+PLwtYkDAAA=
X-CMS-MailID: 20241021133404eucas1p24c126e03f496270d49a7d074fe27a90a
X-Msg-Generator: CA
X-RootMTR: 20241021085439eucas1p10a0b6e7c3b0ace3c9a0402427595875a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241021085439eucas1p10a0b6e7c3b0ace3c9a0402427595875a
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
	<Zw_IT136rxW_KuhU@casper.infradead.org>
	<e1b6fa05-019c-4a40-afc0-bc1efd15ad42@linux.alibaba.com>
	<6dohx7zna7x6hxzo4cwnwarep3a7rohx4qxubds3uujfb7gp3c@2xaubczl2n6d>
	<8e48cf24-83e1-486e-b89c-41edb7eeff3e@linux.alibaba.com>
	<CGME20241021085439eucas1p10a0b6e7c3b0ace3c9a0402427595875a@eucas1p1.samsung.com>
	<ppgciwd7cxmeqssryshe42lxwb4sdzr6gjhwwbotw4gx2l7vi5@7y4hedxpf4nx>

On Mon Oct 21, 2024 at 10:54 AM CEST, Kirill A. Shutemov wrote:
> On Mon, Oct 21, 2024 at 02:24:18PM +0800, Baolin Wang wrote:
>>=20
>>=20
>> On 2024/10/17 19:26, Kirill A. Shutemov wrote:
>> > On Thu, Oct 17, 2024 at 05:34:15PM +0800, Baolin Wang wrote:
>> > > + Kirill
>> > >=20
>> > > On 2024/10/16 22:06, Matthew Wilcox wrote:
>> > > > On Thu, Oct 10, 2024 at 05:58:10PM +0800, Baolin Wang wrote:
>> > > > > Considering that tmpfs already has the 'huge=3D' option to contr=
ol the THP
>> > > > > allocation, it is necessary to maintain compatibility with the '=
huge=3D'
>> > > > > option, as well as considering the 'deny' and 'force' option con=
trolled
>> > > > > by '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
>> > > >=20
>> > > > No, it's not.  No other filesystem honours these settings.  tmpfs =
would
>> > > > not have had these settings if it were written today.  It should s=
imply
>> > > > ignore them, the way that NFS ignores the "intr" mount option now =
that
>> > > > we have a better solution to the original problem.
>> > > >=20
>> > > > To reiterate my position:
>> > > >=20
>> > > >    - When using tmpfs as a filesystem, it should behave like other
>> > > >      filesystems.
>> > > >    - When using tmpfs to implement MAP_ANONYMOUS | MAP_SHARED, it =
should
>> > > >      behave like anonymous memory.
>> > >=20
>> > > I do agree with your point to some extent, but the =E2=80=98huge=3D=
=E2=80=99 option has
>> > > existed for nearly 8 years, and the huge orders based on write size =
may not
>> > > achieve the performance of PMD-sized THP in some scenarios, such as =
when the
>> > > write length is consistently 4K. So, I am still concerned that ignor=
ing the
>> > > 'huge' option could lead to compatibility issues.
>> >=20
>> > Yeah, I don't think we are there yet to ignore the mount option.
>>=20
>> OK.
>>=20
>> > Maybe we need to get a new generic interface to request the semantics
>> > tmpfs has with huge=3D on per-inode level on any fs. Like a set of FAD=
V_*
>> > handles to make kernel allocate PMD-size folio on any allocation or on
>> > allocations within i_size. I think this behaviour is useful beyond tmp=
fs.
>> >=20
>> > Then huge=3D implementation for tmpfs can be re-defined to set these
>> > per-inode FADV_ flags by default. This way we can keep tmpfs compatibl=
e
>> > with current deployments and less special comparing to rest of
>> > filesystems on kernel side.
>>=20
>> I did a quick search, and I didn't find any other fs that require PMD-si=
zed
>> huge pages, so I am not sure if FADV_* is useful for filesystems other t=
han
>> tmpfs. Please correct me if I missed something.
>
> What do you mean by "require"? THPs are always opportunistic.
>
> IIUC, we don't have a way to hint kernel to use huge pages for a file on
> read from backing storage. Readahead is not always the right way.
>
>> > If huge=3D is not set, tmpfs would behave the same way as the rest of
>> > filesystems.
>>=20
>> So if 'huge=3D' is not set, tmpfs write()/fallocate() can still allocate=
 large
>> folios based on the write size? If yes, that means it will change the
>> default huge behavior for tmpfs. Because previously having 'huge=3D' is =
not
>> set means the huge option is 'SHMEM_HUGE_NEVER', which is similar to wha=
t I
>> mentioned:
>> "Another possible choice is to make the huge pages allocation based on w=
rite
>> size as the *default* behavior for tmpfs, ..."
>
> I am more worried about breaking existing users of huge pages. So changin=
g
> behaviour of users who don't specify huge is okay to me.

I think moving tmpfs to allocate large folios opportunistically by
default (as it was proposed initially) doesn't necessary conflict with
the default behaviour (huge=3Dnever). We just need to clarify that in
the documentation.

However, and IIRC, one of the requests from Hugh was to have a way to
disable large folios which is something other FS do not have control
of as of today. Ryan sent a proposal to actually control that globally
but I think it didn't move forward. So, what are we missing to go back
to implement large folios in tmpfs in the default case, as any other fs
leveraging large folios?

