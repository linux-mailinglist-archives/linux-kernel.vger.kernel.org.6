Return-Path: <linux-kernel+bounces-235234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E7991D1F0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 16:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30561F214DF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B01814532D;
	Sun, 30 Jun 2024 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fHPn0iE0"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2027.outbound.protection.outlook.com [40.92.40.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B2914291E
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719756190; cv=fail; b=If6sRiDOXL+24MKxUdcdjWOQC62b7Bwg+/ntiGTvPuYgQ9m2WbO8T1xIuzNIP5fnDnlBON/1ujqEyRhADz2wuR5rCkw5y1tejah5vRCu1uSEjESWxmYkoZwtgm9EhKjzdv+A8sWCtu5gY749/wjEyI4o8TlQx9r6hw8muGv0HMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719756190; c=relaxed/simple;
	bh=clCLaKd9X1ji1UiIHJA/tzhE6o20WCoyyJM6PEh8Tfw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QzVMKr6tiNYJYw09XWwOh8UPQj/L0lDJXN5xtZNAUCudSNmgKx6nPX8WNyreF1Jo38xCso8aTC5Gwxif4MHB68hVgK/riPe1JeBqzCMTpTW6CwgaqdDkmTZsn+MbXbim0zwetdJJN7DeLv1bQH7MSRTRLDDFgNk8xXn3NrGq2Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fHPn0iE0; arc=fail smtp.client-ip=40.92.40.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjolRelm4fBf2AJ1viX42J42cGZwBz4dJ7RKBo1ufunzq87nLc+qoqDRw9uQnkwPp42rKimrEf8lvBb+JAdMTXRC5Rjm1lGFkfC2DrfXtbASA9quh8nAzogEbtDkRREJlf6Xfyt79mNms0KLE9kalqrDVvhCWeZLdzDJhCbB9gjIzay+zM5motSpSip7I3sM7mbWV72AxIO3wVSMSUtK63v0L8NnQsL/IDZc7W3XXMc5kaA7UYoVvqXwGQTwubk3ewnL8fBfj+z9LUdzMXAaSQaXVgtg0UR/B/QbMkLHUbR6VOyQuhnN4A4rlYVDHv9Yub6wZI1PNMnVOYT64wkelQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lTk4hRxrZhQ/fhyVY54JOkDpKaShrolCHbrWuRPTV0=;
 b=PGnnSPbu9rczOnneGT1dY6Xz+iTjim8eTRfnvcpb4BLExuQS99cX0EpnjYzUzGg09iK3ESGptUVpfELAheMMYtaytLiWueKmXLT2bVwGPEbH9Nir3AgPWGnz7OFFojBShLkZwmKs3o7vviDAZLjnqcGEV2I6BlQCDfo8Z5sYPgNN8l7dGLCYYLq6h4IGNsE2+TDNzq4UKvZw25wyyxOGvKxL3DN0M6KZrH/P61semK6fKIy+QbWCfjoMLInsAahdQ2MYtCdQ+W0RDaufkjfKnK7l1Vht37JCpEIZcZZ2B5aHQ0AtVEt2POQIQxzpwJTcVfcHfPWClBAa49zWI04lJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lTk4hRxrZhQ/fhyVY54JOkDpKaShrolCHbrWuRPTV0=;
 b=fHPn0iE0Y359ZxUyYBYvs2EzC4l5uO/juVsAb5YsbQTkMcWfHxfMhDT6O9tLBxDDoq2KJvxyeP9bAED9bFv+ni9hLbYKE8MrXPcazPs482X4Z3bgI0RHA2EWUpDdmXYWolK1AdFqk62xGaz2xycSheTBQFv7DYviLAHcaTV51mBE7F1ywRiM5tYpvaNURUF81YiwxeRHj010EvIc+3g/i0YjUsb/XYn7AjyOfKRdapN0e4TDgAv4QdUnjjCsAFd42esMvC88BJJ+WOXMfTzYFP4xfQqkO/bB9uqcLpELtXZlMSD3kU0gXw5SkvSGbtcw5eA13dsW2Nxfrb5IEM9szA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB8000.namprd02.prod.outlook.com (2603:10b6:408:16d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 14:02:52 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 14:02:52 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "hch@lst.de" <hch@lst.de>
CC: =?iso-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, "jgross@suse.com"
	<jgross@suse.com>, "sstabellini@kernel.org" <sstabellini@kernel.org>,
	"oleksandr_tyshchenko@epam.com" <oleksandr_tyshchenko@epam.com>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: RE: [RFC 1/1] swiotlb: Reduce calls to swiotlb_find_pool()
Thread-Topic: [RFC 1/1] swiotlb: Reduce calls to swiotlb_find_pool()
Thread-Index:
 AQHauIjoJBWSrCyO6UWzcncSceBiMLHa1Z9wgABomICAAA3OAIAAhiSggAAJLYCAAAn5IIAA6tuAgAAdhQCAAhqHMIAA6wAAgACDZAA=
Date: Sun, 30 Jun 2024 14:02:52 +0000
Message-ID:
 <SN6PR02MB415735CA2F5487AE3FD74FFED4D22@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240607031421.182589-1-mhklinux@outlook.com>
 <SN6PR02MB41577686D72E206DB0084E90D4D62@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240627060251.GA15590@lst.de>
 <20240627085216.556744c1@meshulam.tesarici.cz>
 <SN6PR02MB4157E61B49C8435E38AC968DD4D72@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240627152513.GA23497@lst.de>
 <SN6PR02MB4157D9B1A64FF78461D6A7EDD4D72@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240628060129.GA26206@lst.de>
 <20240628094708.3a454619@meshulam.tesarici.cz>
 <SN6PR02MB415781789CBD6597142BEC68D4D12@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240630055542.GA5379@lst.de>
In-Reply-To: <20240630055542.GA5379@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [hFWwzBy8j2S1RGuEZXfH7YE/JsHE6jnB]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB8000:EE_
x-ms-office365-filtering-correlation-id: e5c7c2f5-31d9-4bc2-0a6c-08dc990d5538
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 rUNDe6U7okKLMxQ3Y38uxbhxdVTELPNqzikkoDrT49IlbtYsIWeN79BkLYo9V2R5I2GBHHkBA2NOFEnQCmJuSD6Xim4k9u2vASWrJyl4mxupSc7aNhRD9XZxN5UcVfgYVNpjZ+ws7veE7Q08616fqANZiihXFzWb6b51bczbfIHohMo9g4/GgmWDZHG4dn6RvxdkEz7PxYht715cAql++MfYTtTYI9rA3SCihm+I5pazbsLIe+B8lkyKjPmVJrEXywlBSDPygBHtOITcHLzhUma27gL/cB4C8DKTd0hILtUMzE9Jv/fQRvm+WZrj2JRMJbJhxJDfoQpqfdjdLY2jaVTe8ZhPjqk/TpRBMtDi0DqK/oM5LT7J/a6x1LjdCY7/mzbMxNw+apQRP1ifxmv9+g7j5apSajD6kn/7eNBqAtaMY7uulFEwlSDm178vdKplcWOA4Una9ks69+C42oGA02kz2aNnW/ubw42Vh34mIhVJ6/rQ8LU+FyfyHvtHR5Mpeg5JKZ8YR0WWdmTiJaj+kdDEuQh/noMnGRefS0m5Nte7gf6RowWCvXUojWJy4kXNWCa/OD4/gGWZRu6c7iFx4dZA0oUwCp054VBwJtbRM6iAjzuHw4ZIAeffzrtJyVqb
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?d2WOrTpAaya0ZFQLsUGOJCY5fQ2CgHXBhKPOipzluqhENuIbKs6MRxz8R7?=
 =?iso-8859-2?Q?ANgRRp5GQIikIuD2vy3El1hctKGYnxUbIPpR3gjuVXIzdKlZR6Q5fOUcUI?=
 =?iso-8859-2?Q?BSCiYP9OXqtBYIznQsLRjBfKYO8IxjLW0XdFPSjBztxCJpLYErVCi2G0o8?=
 =?iso-8859-2?Q?sy+rBwlq+XBnNkB1b9Lcmqr8Snp4ifz4NUFItShAkyt5Y72rgJ3KvEH3Z2?=
 =?iso-8859-2?Q?L59TQzGBnicReNC2MhUsr6Rp4vG42v0NhYV8tHX4bzVEePezH/hr9x20OB?=
 =?iso-8859-2?Q?ilEcqkdd3rIpD5e1iZRdSUEUS3xLdzj4OM1B38is6C7/dhsms+Qv1eNArr?=
 =?iso-8859-2?Q?xyTCxXz01uuxsEdjnf4tz5nHgM5fAxOKJg38mrueLa8f6V5XvGEwVgg7sG?=
 =?iso-8859-2?Q?sTackw65xPYgLKrKkoFwe4/YJC6dikXC194AxlhP54uT0pNDWMa1hTfLE/?=
 =?iso-8859-2?Q?nGAcb5z9qrO7ZgZnyb+FzQB4Yp6tS2SEWe0NYl8jBBNvQcTTE/gZprKb91?=
 =?iso-8859-2?Q?Hjg0c6rNoWuw77bUhV90t8Ga2LA2+Y4SFsmyQeyhXSeNrHdAAlocO4+gIu?=
 =?iso-8859-2?Q?f+9oJbuTmRdtwY+j6oALXOOFTSYa4QfK3A4MhkqCBZ/xtq/bBORzlN0zvW?=
 =?iso-8859-2?Q?BVBdGqm4NjxQtK16AC2MtRxeeM7W3oY5q/XMAHYk7LqX6RdeDr4OktdeXU?=
 =?iso-8859-2?Q?vOF3Mp93Futd+pYR4LgmZvieNZNA2g/JPMyCrwhK1UdpUtmWuP5NJbKzh8?=
 =?iso-8859-2?Q?tGb8xAeZ5nlboIEWmXSRYGeWhZz2dCkHzG2QIKW0I5kDz0AGps0chU3ugI?=
 =?iso-8859-2?Q?HW4MJHY3wYMAVz+SbyJvyTkLN99z+osthw4qWRgNUp2GkIHQRsFPijrPa1?=
 =?iso-8859-2?Q?xhptO40IuPkzX2wrDqtYfVTuPYTGJ9D1VF+VZiv+6FONFsYhVYwl8bIg/3?=
 =?iso-8859-2?Q?WzNuzlMpHEyvVTkQNDwQkbolhphhKlrLX4USELfLTH8cxF51Bnc+S7PfsB?=
 =?iso-8859-2?Q?uzhD33doAaAPFbxbYRDSJiGHhy3vwVJXjZBtoNwn1HW6L6fX8ROkga4TLA?=
 =?iso-8859-2?Q?yimmnbJ52NtcjJ9nw2AtBUofy2qKEVjvmdtWqOZm/OGanhbIRCywMVn5W2?=
 =?iso-8859-2?Q?T7DlvfwwdY5l0f2GQA5y7g33jvI1cnzpDQpN8fdqXmKfKaxv5U/8K/m3Ui?=
 =?iso-8859-2?Q?A4eWRT/w/ledJAiSBWkL1tdbObKgq4d02/BRkpz4PsCYOVqFppGG4oogIi?=
 =?iso-8859-2?Q?RLaVy6b203LS35BDwM5oOH8JUL7Dke8ETmUC/0IMw=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c7c2f5-31d9-4bc2-0a6c-08dc990d5538
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2024 14:02:52.2910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8000

From: hch@lst.de <hch@lst.de> Sent: Saturday, June 29, 2024 10:56 PM
>=20
> On Sat, Jun 29, 2024 at 03:55:58PM +0000, Michael Kelley wrote:
> > Unless there is further discussion on this point, I'll just keep the or=
iginal
> > "is_swiotlb_buffer()" in v2.
>=20
> That is the wrong name for something that returns the pool as pointed
> out before.

OK. Since any new name could cause confusion with the existing
swiotlb_find_pool(), here's my proposal:

1) Rename is_swiotlb_buffer() to swiotlb_find_pool(), since it
now returns a pool.  A NULL return value indicates that the
paddr is not an swiotlb buffer.

2) Similarly, rename is_xen_swiotlb_buffer() to
xen_swiotlb_find_pool()

3) The existing swiotlb_find_pool() has the same function signature,
but it is used only where the paddr is known to be an swiotlb buffer
and hence always succeeds. Rename it to __swiotlb_find_pool() as
the "internal" version of swiotlb_find_pool().

4) Do you still want is_swiotlb_buffer() as a trivial wrapper around
the new swiotlb_find_pool(), for use solely in dma_direct_need_sync()
where only a Boolean is needed and not the pool?

Thanks,

Michael

