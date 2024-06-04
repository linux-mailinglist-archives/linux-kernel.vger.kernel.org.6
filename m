Return-Path: <linux-kernel+bounces-200596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3438FB23F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26CD4B23102
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F821474A9;
	Tue,  4 Jun 2024 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NPlsiefb"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918B81465BD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504223; cv=none; b=BXWEUuK0t2eugffoQ19MxI2/1qtLXcSIoYDYjY29bhDo4X8d4mbzu3MuIFf3GqOjGzn07OH97It7UZdDz1VyQ1iKLBsaeUvMJzxi78b829hNUm49S9PMq2ViKJyHYOISdFoXixWER2R++stuiHi55dLRkSWtaY0+v09cK2jky+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504223; c=relaxed/simple;
	bh=+R0CyuekIIs2kJ0/KdSGJbYmXIfxmG1NnI+3Q6A5c0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=eBiJxSzDo9kMfnmZy0Gr/Ubfs7FZIJ9f4MckikPgmlC1R25w4fMiuRwhfGR/q9vRzzQ1yYZYrOO3EFFJJUiQ6HXhmj8Y2YGYrpRIdspVHs7WlvGvo5Nn9rdK3JOXltYRZ2nPLjRQ3cs0+YRsjX/l7GTug83A+9U/NT0M8q7ftM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NPlsiefb; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240604123017euoutp0129c6ba3c10ccb01e03aa6400d9c78255~VzPyHGuAR2798027980euoutp01N
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:30:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240604123017euoutp0129c6ba3c10ccb01e03aa6400d9c78255~VzPyHGuAR2798027980euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717504217;
	bh=ptN2NoUr8+zXcwT/nGN/WWLMPkbqZEov7GTpzp2ymR0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=NPlsiefbBATIXj4Oc6mIHDzh2KZW9Dt+qysKZ/9vBuVc/UFCzIyXfxt/rVfO2foqe
	 ioT75Vd3qLG7J+Lgs7ubdHwAjVeIjLv/HJnaL+Xe0gqTvMWzRln4gXzyLT8kcFH2gf
	 VavIQLJtT3fNCtKphyyglilrJhOEgi//F2MEI22c=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240604123017eucas1p1c254d540fb72bb34a17ea56ab341a0aa~VzPxsB-kH2591625916eucas1p1O;
	Tue,  4 Jun 2024 12:30:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 7C.37.09624.9D80F566; Tue,  4
	Jun 2024 13:30:17 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240604123017eucas1p15d97838b2fca70d8611d6bfdc0da53b5~VzPxTpEZ-1279712797eucas1p1-;
	Tue,  4 Jun 2024 12:30:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240604123017eusmtrp2b15a6267d2d94c78a262fce68baf0605~VzPxS9WUg0243602436eusmtrp2P;
	Tue,  4 Jun 2024 12:30:17 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-ff-665f08d94c81
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id A2.96.08810.8D80F566; Tue,  4
	Jun 2024 13:30:16 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240604123016eusmtip1aa07394fa46cd4cd92382f0a88527450~VzPxHfAc02215322153eusmtip1B;
	Tue,  4 Jun 2024 12:30:16 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Tue, 4 Jun 2024 13:30:10 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Tue, 4 Jun
	2024 13:30:10 +0100
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
Thread-Index: AQHasjX9yP1IBMh0VkC4Fzv01OfbabGxBpEAgAA+eQCAABeXAIAF8ZEAgAAIgICAACn+gA==
Date: Tue, 4 Jun 2024 12:30:09 +0000
Message-ID: <v5acpezkt4ml3j3ufmbgnq5b335envea7xfobvowtaetvbt3an@v3pfkwly5jh2>
In-Reply-To: <8e10beae-b3cd-4f5a-8e50-3f6dfe75ba9f@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21F0390E4BBBFE45B78B9DCD82BD59F5@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7djPc7o3OeLTDL7cFLH4fFfIYs76NWwW
	//ceY7T4uv4Xs8XTT30sFot+G1tc3jWHzeLemv+sFj27pzJaLDixmNGi8fN9RovfP4ASJ2dN
	ZrGYffQeuwOfx5p5axg9ds66y+6xYFOpR8uRt6wem1doeSze85LJY9OnSeweJ2b8ZvHY+dDS
	o7f5HZvH+31X2Tw+b5IL4InisklJzcksSy3St0vgynjy9QNrwV3fikvfmhgbGBtsuhg5OSQE
	TCT6Vr5g6WLk4hASWMEo8aPvP5TzhVHiQscUKOczo8TcfTeZYFruzJvCDJFYziix69cyZriq
	OQs6mSCc04wSXxdeYYWb3Lu8mx2kn01AU2LfyU1gtoiAhsSmtg3MIDazwFxWiYPtISC2sICD
	xMzFvawQNY4SN5quskHYYRKf24+B2SwCKhKX/70Gu4lXwFdiQstzRhCbU8BO4vHLjWBxRgFZ
	iUcrf7FDzBeXuPVkPtQPghKLZu9hhrDFJP7tesgGYetInL3+hBHCNpDYunQfC4StKNFx7CYb
	xBwdiQW7P0HZlhLv9p5khLC1JZYtfM0McY+gxMmZT8CBJyGwlUti0pwpUINcJA4dvA21TFji
	1fEt7BMYdWYhuW8Wkh2zkOyYhWTHLCQ7FjCyrmIUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/d
	xAhMlKf/Hf+0g3Huq496hxiZOBgPMUpwMCuJ8PbVRacJ8aYkVlalFuXHF5XmpBYfYpTmYFES
	51VNkU8VEkhPLEnNTk0tSC2CyTJxcEo1MAW0LjoTxRc652LUCvap3mePuC3cIPCq/fcf4yXT
	S1RWfKky11CznfRK985kkevBIcWfBZwdJZ6IxSQXR7DeVruvwfhC7XFvSNA+6UMxvd+fhy6O
	DWZcnXk4rJ/vmoXdru12GXtbXMtOuz51zD4w/be7cJRz8om/x2aJZV689Wz95KsFx+WfZvRe
	c2pivB2gOvNjVdZLl64YP4krr+w3PJGu0C4Ifh4WnXk6ZcbHlSfyXwqULQw7UV7Ucngna9u9
	N2ddoyLTX/z7E/gjynFnrpCTdvDme/GfrS7OMHDpmSD2s35mzbW1tZN6Kwq7XzwXP/ZytrQx
	c9aPGVduRHw6ah8SMSPGznydlmrr9D/z6pVYijMSDbWYi4oTAV4K71gDBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsVy+t/xu7o3OOLTDPZvtrT4fFfIYs76NWwW
	//ceY7T4uv4Xs8XTT30sFot+G1tc3jWHzeLemv+sFj27pzJaLDixmNGi8fN9RovfP4ASJ2dN
	ZrGYffQeuwOfx5p5axg9ds66y+6xYFOpR8uRt6wem1doeSze85LJY9OnSeweJ2b8ZvHY+dDS
	o7f5HZvH+31X2Tw+b5IL4InSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3
	s0lJzcksSy3St0vQy3jy9QNrwV3fikvfmhgbGBtsuhg5OSQETCTuzJvC3MXIxSEksJRR4sWU
	t0wQCRmJjV+uskLYwhJ/rnWxQRR9ZJT4/HQ2E4RzmlFiYtcTFghnBaNEy6oDLCAtbAKaEvtO
	bmIHsUUENCQ2tW1gBrGZBeayShxsDwGxhQUcJGYu7mWFqHGUuNF0lQ3CDpP43H4MzGYRUJG4
	/O812Em8Ar4SE1qeM0Is28EssXvLL7ChnAJ2Eo9fbgQrYhSQlXi08hc7xDJxiVtP5kP9IyCx
	ZM95ZghbVOLl439Qv+lInL3+hBHCNpDYunQfC4StKNFx7CYbxBwdiQW7P0HZlhLv9p5khLC1
	JZYtfM0McZygxMmZT1gmMMrMQrJ6FpL2WUjaZyFpn4WkfQEj6ypGkdTS4tz03GJDveLE3OLS
	vHS95PzcTYzAJLjt2M/NOxjnvfqod4iRiYPxEKMEB7OSCG9fXXSaEG9KYmVValF+fFFpTmrx
	IUZTYOBNZJYSTc4HpuG8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5O
	qQamaesSPuvcCboffKdhk4iK9iKLhy6sPuu3K4Xcr3786euyDSuWiXZ9nLeIfULzuzjWjbNl
	OtiXvE2+bNZ49XTx4qpaixjjf3tildd6Xi+sOuzbt3r716hHmzWvpmSsWHH9bvTfHYuXnWI+
	6Ri9585h4dcWIZdEmb0Kgzy8i4/lPTGuu/dlwTWR7Xn6HWJLt0h1nJW2X/niu+ANjiOyypvs
	7lzr7D7M9d99a6zpWWXlE29kBQ8I7bXiUJs4SUiI9cDBRpl357br3501JVF7YoFr+QJDH6EZ
	auvWmLXNuXj+SueFjiDtF0eW3Fq5SU1856xPG2/tS/XqdryW9zvbx1f7JFdnSjr3x3RD/o5n
	1YULryqxFGckGmoxFxUnAgCQu6e3CwQAAA==
X-CMS-MailID: 20240604123017eucas1p15d97838b2fca70d8611d6bfdc0da53b5
X-Msg-Generator: CA
X-RootMTR: 20240531093540eucas1p257ec781a06607de130ea1fff8cfa080a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240531093540eucas1p257ec781a06607de130ea1fff8cfa080a
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
	<CGME20240531093540eucas1p257ec781a06607de130ea1fff8cfa080a@eucas1p2.samsung.com>
	<f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com>
	<vlkkfcyumveggkddb6d44f55gtx4qonoiijxyofa63mtmkuofv@uf4nbw3r5ysh>
	<f0618bca-119b-417a-a19d-699084476f88@redhat.com>
	<zz23hukm6kpguehfsxmzdtam34bj2opt63oesspwsikw57bpqy@eftgscqy3bly>
	<8e10beae-b3cd-4f5a-8e50-3f6dfe75ba9f@redhat.com>

On Tue, Jun 04, 2024 at 11:59:51AM +0200, David Hildenbrand wrote:
> [...]
>=20
> > > > How can we use per-block tracking for reclaiming memory and what ch=
anges would
> > > > be needed? Or is per-block really a non-viable option?
> > >=20
> > > The interesting thing is: with mTHP toggles it is opt-in -- like for
> > > PMD-sized THP with shmem_enabled -- and we don't have to be that conc=
erned
> > > about this problem right now.
> >=20
> > Without respecting the size when allocating large folios, mTHP toggles =
would
> > over allocate. My proposal added earlier to this thread is to combine t=
he 2
> > to avoid that case. Otherwise, shouldn't we try to find a solution for =
the
> > reclaiming path?
>=20
> I think at some point we'll really have to do a better job at reclaiming
> (either memory-overallocation, PUNCHHOLE that couldn't split, but maybe a=
lso
> pages that are now all-zero again and could be reclaimed again).
>=20
> >=20
> > >=20
> > > >=20
> > > > Clearly, if per-block is viable option, shmem_fault() bug would req=
uired to be
> > > > fixed first. Any ideas on how to make it reproducible?
> > > >=20
> > > > The alternatives discussed where sub-page refcounting and zeropage =
scanning.
> > >=20
> > > Yeah, I don't think sub-page refcounting is a feasible (and certainly=
 not
> > > desired ;) ) option in the folio world.
> > >=20
> > > > The first one is not possible (IIUC) because of a refactor years ba=
ck that
> > > > simplified the code and also requires extra complexity. The second =
option would
> > > > require additional overhead as we would involve scanning.
> > >=20
> > > We'll likely need something similar (scanning, tracking?) for anonymo=
us
> > > memory as well. There was a proposal for a THP shrinker some time ago=
, that
> > > would solve part of the problem.
> >=20
> > It's good to know we have the same problem in different places. I'm mor=
e
> > inclined to keep the information rather than adding an extra overhead. =
Unless
> > the complexity is really overwhelming. Considering the concerns here, n=
ot sure
> > how much should we try merging with iomap as per Ritesh's suggestion.
>=20
> As raised in the meeting, I do see value in maintaining the information; =
but
> I also see why Hugh and Kirill think this might be unwarranted complexity=
 in
> shmem.c. Meaning: we might be able to achieve something similar without i=
t,
> and we don't have to solve the problem right now to benefit from large
> folios.
>=20
> >=20
> > The THP shrinker, could you please confirm if it is this following thre=
ad?
> >=20
> > https://lore.kernel.org/all/cover.1667454613.git.alexlzhu@fb.com/
>=20
> Yes, although there was no follow up so far. Possibly, because in the
> current khugepaged approach, there will be a constant back-and-forth betw=
een
> khugepaged collapsing memory (and wasting memory in the default setting),
> and the THP shrinker reclaiming memory; doesn't sound quite effective :)
> That needs more thought IMHO.
>=20
> [...]
>=20
> > > > > To optimize FALLOC_FL_PUNCH_HOLE for the cases where splitting+fr=
eeing
> > > > > is not possible at fallcoate() time, detecting zeropages later an=
d
> > > > > retrying to split+free might be an option, without per-block trac=
king.
> > > >=20
> > > > >=20
> > > > > (2) mTHP controls
> > > > >=20
> > > > > As a default, we should not be using large folios / mTHP for any =
shmem, just
> > > > > like we did with THP via shmem_enabled. This is what this series =
currently
> > > > > does, and is aprt of the whole mTHP user-space interface design.
> > > >=20
> > > > That was clear for me too. But what is the reason we want to boot i=
n 'safe
> > > > mode'? What are the implications of not respecing that?
> > >=20
> > > [...]
> > >=20
> > > >=20
> > > > As I understood from the call, mTHP with sysctl knobs is preferred =
over
> > > > optimistic falloc/write allocation? But is still unclear to me why =
the former
> > > > is preferred.
> > >=20
> > > I think Hugh's point was that this should be an opt-in feature, just =
like
> > > PMD-sized THP started out, and still is, an opt-in feature.
> >=20
> > I'd be keen to understand the use case for this. Even the current THP c=
ontrols
> > we have in tmpfs. I guess these are just scenarios with no swap involve=
d?
> > Are these use cases the same for both tmpfs and shmem anon mm?
>=20
> Systems without swap are one case I think. The other reason for a toggle =
in
> the past was to be able to disable it to troubleshoot issues (Hugh mentio=
ned
> in the meeting about unlocking new code paths in shmem.c only with a
> toggle).
>=20
> Staring at my Fedora system:
>=20
> $ cat /sys/kernel/mm/transparent_hugepage/shmem_enabled
> always within_size advise [never] deny force
>=20
> Maybe because it uses tmpfs to mount /tmp (interesting article on lwn.net
> about that) and people are concerned about the side-effects (that can
> currently waste memory, or result in more reclaim work being required whe=
n
> exceeding file sizes).
>=20
> For VMs, I know that shmem+THP with memory ballooning is problematic and =
not
> really recommended.

Agree. We cannot PUNCH_HOLES when using THP unless the punch is PMD-size.

>=20
> [...]
>=20
> > > >=20
> > > > >=20
> > > > > Also, we should properly fallback within the configured sizes, an=
d not jump
> > > > > "over" configured sizes. Unless there is a good reason.
> > > > >=20
> > > > > (3) khugepaged
> > > > >=20
> > > > > khugepaged needs to handle larger folios properly as well. Until =
fixed,
> > > > > using smaller THP sizes as fallback might prohibit collapsing a P=
MD-sized
> > > > > THP later. But really, khugepaged needs to be fixed to handle tha=
t.
> > > > >=20
> > > > > (4) force/disable
> > > > >=20
> > > > > These settings are rather testing artifacts from the old ages. We=
 should not
> > > > > add them to the per-size toggles. We might "inherit" it from the =
global one,
> > > > > though.
> > > > >=20
> > > > > "within_size" might have value, and especially for consistency, w=
e should
> > > > > have them per size.
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > So, this series only tackles anonymous shmem, which is a good sta=
rting
> > > > > point. Ideally, we'd get support for other shmem (especially duri=
ng fault
> > > > > time) soon afterwards, because we won't be adding separate toggle=
s for that
> > > > > from the interface POV, and having inconsistent behavior between =
kernel
> > > > > versions would be a bit unfortunate.
> > > > >=20
> > > > >=20
> > > > > @Baolin, this series likely does not consider (4) yet. And I sugg=
est we have
> > > > > to take a lot of the "anonymous thp" terminology out of this seri=
es,
> > > > > especially when it comes to documentation.
> > > > >=20
> > > > > @Daniel, Pankaj, what are your plans regarding that? It would be =
great if we
> > > > > could get an understanding on the next steps on !anon shmem.
> > > >=20
> > > > I realize I've raised so many questions, but it's essential for us =
to grasp the
> > > > mm concerns and usage scenarios. This understanding will provide cl=
arity on the
> > > > direction regarding folios for !anon shmem.
> > >=20
> > > If I understood correctly, Hugh had strong feelings against not respe=
cting
> > > mTHP toggles for shmem. Without per-block tracking, I agree with that=
.
> >=20
> > My understanding was the same. But I have this follow-up question: shou=
ld
> > we respect mTHP toggles without considering mapping constraints (size a=
nd
> > index)? Or perhaps we should use within_size where we can fit this inte=
rmediate
> > approach, as long as mTHP granularity is respected?
>=20
> Likely we should do exactly the same as we would do with the existing
> PMD-sized THPs.
>=20
> I recall in the meeting that we discussed that always vs. within_size see=
ms
> to have some value, and that we should respect that setting like we did f=
or
> PMD-sized THP.
>=20
> Which other mapping constraints could we have?

Patch 12 in my RFC for LSF [1] adds this shmem_mapping_size_order() (update=
d
to support get_order()) to get the max order 'based on the file size which =
the
mapping currently allows at the given index'. Same check is done here [2] i=
n
filemap.c.

[1] https://lore.kernel.org/all/20240515055719.32577-13-da.gomez@samsung.co=
m/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/mm/filemap.c?h=3Dv6.10-rc2#n1940

@@ -1726,6 +1726,37 @@ static struct folio *shmem_alloc_folio(gfp_t gfp, in=
t order,
        return folio;
 }

+/**
+ * shmem_mapping_size_order - Get maximum folio order for the given file s=
ize.
+ * @mapping: Target address_space.
+ * @index: The page index.
+ * @size: The suggested size of the folio to create.
+ *
+ * This returns a high order for folios (when supported) based on the file=
 size
+ * which the mapping currently allows at the given index. The index is rel=
evant
+ * due to alignment considerations the mapping might have. The returned or=
der
+ * may be less than the size passed.
+ *
+ * Like __filemap_get_folio order calculation.
+ *
+ * Return: The order.
+ */
+static inline unsigned int
+shmem_mapping_size_order(struct address_space *mapping, pgoff_t index,
+                        size_t size)
+{
+       unsigned int order =3D get_order(max_t(size_t, size, PAGE_SIZE));
+
+       if (!mapping_large_folio_support(mapping))
+               return 0;
+
+       /* If we're not aligned, allocate a smaller folio */
+       if (index & ((1UL << order) - 1))
+               order =3D __ffs(index);
+
+       return min_t(size_t, order, MAX_PAGECACHE_ORDER);
+}
+

>=20
> --=20
> Cheers,
>=20
> David / dhildenb
> =

