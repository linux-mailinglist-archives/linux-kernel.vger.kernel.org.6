Return-Path: <linux-kernel+bounces-523657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325C9A3D9B8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE2470037D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6271F5839;
	Thu, 20 Feb 2025 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kHhGWk5z"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D431F5616;
	Thu, 20 Feb 2025 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053903; cv=fail; b=sz9Bpb/LJxZrrPksFoYwQpSI5D02Z2xO8uI3qcfWG5x5jS8aBVi2qowcCuY6LhSmEJCSnmov+kYWzZ2EF7cH9PPOseTjm82mLlPEfCF8hKpDsJOlelIQ6mwrtcWOHQJvaJf9/orrf+2LBGxQ6OWeC2JiwTZTENT1dPAFQktaBYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053903; c=relaxed/simple;
	bh=ibu09nLkvsZxWlfRO9FEXJT49HlqS6WSzjIep16s898=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g6go2cE/QWDQnmBpCvm1ZYPTjdeSBOpeHC/kXxirUzxPdxCIv3tXndO9/ZCl+lzs2t7O6p8CaTUg1IXG4fD2DYk73BdvIcrzXAWQNuNh24lqb15PDsUrtcfAb/EtQRP66igtHa+ccmIgkhquWvfl8T8bK0LBHmi947YRkFqR/SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kHhGWk5z; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDgEtwRsThA6hGKz21DtVDbYDgYSHNf0RdBrUO9cjb8UNogw1z1T1zpWNi+s7pkJtaZtYccKN3m3ICA0r/+4x1wkEo1NpIU9e4pPN9s+zOApsCha/WwPdhHDT7HxatohiWowDfvEhXy3nctgQxkaDSzaDwfGASy7wfWBnI5kw4mDNjb+UGfOIeOLh4RQrFTYxB3NnT6q2dmM+L35MuV0GvaOSvn4qp61o2HcFxET/QBAFLqP6HcGR/fcNtcD5qsSddJ1QbGH2EmftomqGpF1S9N5Hg1t+AOiICpqDVIAGuVfiP+cNjdqTfpT0+gG8SU9LzSeRHp3NvhW3OMAsgR1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyVn8F1j83P2h1SIIaf4A5m1QjkGL/J6B5PlPRgkcIU=;
 b=Z60Pfpt8apijliy2Pg+kU3ykvq8Pk6KR69YuPnaXDaU262rnB0DWENpQebcviFm7IE19Zg3IwvTRszCrZJQHHIliCRYiOxBi1jNzfApe83EQ6jXf1EY5Q6LtvoR9BXob5AvhhCU64Fxo1ha47ukp/bK94pkhr83R0IhWqppdK5vliR7X09TuFTdnaG0jE0eCzFBWDez5Vkg1NplZbUp+UAQIR6lEYaxkcoCuHMXqKbB2JRuHCN5uBaylAKo6fYPX7XkhbHu/LXvV35gxdhinIoZJm6Mpy2Za/zsrZVc3ixAc1nSzebBDRjGHfqRiD29pAMSA6X9vTdFdnvbgyq7zgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyVn8F1j83P2h1SIIaf4A5m1QjkGL/J6B5PlPRgkcIU=;
 b=kHhGWk5z4IbjiY4q4SB9YiKotP1IuXKFBNu8xDtojUwe3ZJHW2pVP0Y+EN/SDEo9OSdvgl41j0Y024I9u4W6lY5917/fLhDaV+wK3v0dMFZ5PLR+vPSOKU3Ew0jgywPboJg9uhsBZHb/gJSk63fOjOix/fq8AFA+mU4tinPRm4A=
Received: from LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21)
 by PH8PR12MB7135.namprd12.prod.outlook.com (2603:10b6:510:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 12:18:19 +0000
Received: from LV8PR12MB9206.namprd12.prod.outlook.com
 ([fe80::5447:387a:c920:8a4a]) by LV8PR12MB9206.namprd12.prod.outlook.com
 ([fe80::5447:387a:c920:8a4a%3]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 12:18:19 +0000
From: "Jain, Ronak" <ronak.jain@amd.com>
To: Rob Herring <robh@kernel.org>
CC: "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "Simek, Michal" <michal.simek@amd.com>, "Manne, Nava
 kishore" <nava.kishore.manne@amd.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] dt-bindings: firmware: xilinx: Add conditional
 pinctrl schema
Thread-Topic: [PATCH 2/3] dt-bindings: firmware: xilinx: Add conditional
 pinctrl schema
Thread-Index: AQHbeKKktzakC2pjxUKURYxGjWc/ybNCrZ0AgAJyC8CACw5/gA==
Date: Thu, 20 Feb 2025 12:18:19 +0000
Message-ID:
 <LV8PR12MB9206B51A38A82F5A1730DA3486C42@LV8PR12MB9206.namprd12.prod.outlook.com>
References: <20250206142244.2553237-1-ronak.jain@amd.com>
 <20250206142244.2553237-3-ronak.jain@amd.com>
 <20250211215354.GA1244436-robh@kernel.org>
 <LV8PR12MB9206BA2BC6BBBA184B3E2FCD86FF2@LV8PR12MB9206.namprd12.prod.outlook.com>
In-Reply-To:
 <LV8PR12MB9206BA2BC6BBBA184B3E2FCD86FF2@LV8PR12MB9206.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=539fdae5-978c-475d-a29f-1ee20c5a6419;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-20T12:05:20Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR12MB9206:EE_|PH8PR12MB7135:EE_
x-ms-office365-filtering-correlation-id: 59a31bd8-8c51-462c-e46b-08dd51a8a92a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gIkHPlQnB7efn27nF/7/+IXBOOk9jKKcqOeRdWOfWp739+xQb9BJ7M4ik1HM?=
 =?us-ascii?Q?CVZcpv+SGRnvl1QRwdIGTlq/I5FmFMNDzymfLiPvcVOQpOHKGZGr8oNcf1Jh?=
 =?us-ascii?Q?wrXK3yBR1Pq7zAKn1/1W+lC8aHLWxpcdAEEs7LwwTwoIB8UexhyGFV8zQfZw?=
 =?us-ascii?Q?MCc+lAvvwRoCEGkEkndkc76KVeA0NWRGSdo8R3Qjbx7JB9Lh1VRQo/UeDFCw?=
 =?us-ascii?Q?fwpzufIDTH6Wqisb9/xVnKohJd5i8yok99IwKJJIPUcIuAQnFIYqgWQAGDxu?=
 =?us-ascii?Q?1VQuibwAkv5FBLRjI6V66TxR0DvzstgC2wOlTf7qp/8T5EbZwy+uNcnCNyaK?=
 =?us-ascii?Q?Lu92sxSRQiDl3npyKmurJoUMJKWyYRgujs1f4utXhpFu6PO80eFGjyAYN1uL?=
 =?us-ascii?Q?L+bln+g/8I+mMiPpyiblpzqUToHvwRUe71Kc+v6KwD4igCfU60cFKtq5zxKZ?=
 =?us-ascii?Q?nMH5XVM4FlTJNTSV7tXfrg1hzCzjBwkH31bseGMBMhN7nMseGlgTIqTrHSTN?=
 =?us-ascii?Q?eMj2JZb1y8gFmd7Gbkku47W9tc3tCFnz0DVGu1K4hxWOcNMRyiYQ+qgkdowz?=
 =?us-ascii?Q?Jcd1z2YK5hBXJ5m5hG/dNaCSKWXteP4ZJLzjfrgSywn10qxDpW2A4a2ckY+d?=
 =?us-ascii?Q?7YV96zT9uCOZ97ZpnjlMwp8PFTq5fz7p+T+GYnMW0RGOcpr1LFXaknvbIZPw?=
 =?us-ascii?Q?qONfGYCQejxoEpTz9Q5n7mF/zxDVdAXHh2+Xaz92l1LuhyfMchXmVW54+kSC?=
 =?us-ascii?Q?ZkvNZF1tXcqVS97kgcz6Sk4JXSa0pfesv9ToJC9HB+SYbgAKrnPdH/8i1wvj?=
 =?us-ascii?Q?YbirJGKmIiQXca8zMEgnfvmJ5h6MAMbqr065il9PYot87kboSxGOGHtsxECD?=
 =?us-ascii?Q?Vkj4rLgLmpHrRv4s0T2xMsQ39wu8S6EzFNuXfuVb8x4+nAKYWqAi1DuP3goF?=
 =?us-ascii?Q?yPlH8QnhEE1YfuYQ2UBxE1ptVy1zsDc68e4qRF8ySADfwMpd3Dhe3In/dxXa?=
 =?us-ascii?Q?zZt/vOb9VOIfBBfqSi79Ztb7J+Q5BrhAbQa8q78YoZLGHzADCiAHa/2uvKxk?=
 =?us-ascii?Q?TBOAN/stmQHpkyx7eoh+oUBqCBV2fGT/axGWNgV91JSs9155u/CjzR9rkLzd?=
 =?us-ascii?Q?qnyy9+f7ejcwB0jk1eyfwtrkK9EJfRnaBdRgSOKQat6suwQUesdR93SrT3iw?=
 =?us-ascii?Q?6rpfVCawDhA2r4Hgia9jvj1u8cJ/3gw43Z0zJFD7X1Mz0MONWGBZqWc5405Q?=
 =?us-ascii?Q?U5h4iEQqeH4nd0iDATmRts/5MkM/CWhd/9hy30mL31S33+q40lPy+03ZDcMv?=
 =?us-ascii?Q?75A1jd6kyGKKyn8nSQBhScCjhXXqpC4ehFXAsiyTLfsPJFtWeYnhwER17VMg?=
 =?us-ascii?Q?KYaufSkA15HJUnCfaSYKng507v1dmaJCbzti/fjky40pLOT9kU8Sk/QegtzT?=
 =?us-ascii?Q?2QsJSb4W3YXp0cOf0CZjyAblRRlcYL8F?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9206.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?b2NJTeTQdHzmIkH1gHBFpbgCqI3yZOrVltXQpAtJNVb5otn7GU7/Cb+IFh7F?=
 =?us-ascii?Q?GrhuILTDzymMZOK/aCsoIyIQECXEPeUfiW817b8PMuGuVcV2OGznfSGo/I/4?=
 =?us-ascii?Q?crfD/aD8Sm62eWOxBG+ceQQwzaV2g9fZ7D4YLwydf6WIeczJwF0iWci9ahS3?=
 =?us-ascii?Q?rmSAidPlhabgablwT9OPYc+0n+qfOauPAkjAUmSL78C0uJnJKBPFXua/V5sn?=
 =?us-ascii?Q?n4M3DHv6y9OfR60WdaERUu9zB0X5sTba632xZtLe78/Pn7SP+FwYyhrcE8tq?=
 =?us-ascii?Q?uL7EHW7ACN50kkegibQhPiBPVDYfn3St+FfUUWTVtrTg4pi8Wkz68ZmFOMLz?=
 =?us-ascii?Q?ewjPqerkDTCD3ba7dVBC1xKmLi8QbQGYPqlNvSFp7A/IcuYcGl4c2naSP83S?=
 =?us-ascii?Q?+RV/mD7KSpNOoz96ViMxzMxP5KFg/ht+C6+h6alRzUWdStF3dcVJpPhQ+hpz?=
 =?us-ascii?Q?RwIP0F3GqzbjjV+41TWnIQj1T9233vlHR6gsSrP9EzEDAVIvqYuM73PzyyGT?=
 =?us-ascii?Q?knlEoOJvaNRv8jKNMAzdtjJgbQY2aXsK1lsmvowII3ohy8VGTo2WP6vYinH/?=
 =?us-ascii?Q?Qpc65Z4tcz4nXMgFCcgVmt1m97WjP/fq0B8PvCq5wqGW6zS7ycMFI7T9EPN7?=
 =?us-ascii?Q?QidKSBOG03rzrz3t9jili4I2Mj2LJYgfeBS6U+c5Udt9ZAZ90u0XncwrV4yW?=
 =?us-ascii?Q?lQj08uT7Fv6TjtfKwASbvR43gJOrfYzjI+PTU0FcTJBUmowy1K4WfwCp9rR8?=
 =?us-ascii?Q?RrUilPMeNzE0OuIT3fiSH08/WtSwz7FtGhxW7xFQkejRi/xywy1azuIqcm1J?=
 =?us-ascii?Q?YqwEbOtRK9ntAU6Xn06acUvaohCMbcWZolJirZpCi+eOEfiugPalW7ICGecB?=
 =?us-ascii?Q?tlFcs8CXbHgjfvHMfNYRc2pZoVDJ1r8RMT6CmY9BTnAtVzDAVc1Zy538PA9Z?=
 =?us-ascii?Q?ovo9PskIANmzaqajdAezgXqAROQi/CXtm25yfv8y3FVzqLVcPbi089QdOIBh?=
 =?us-ascii?Q?j1RxJ4rGByqDa4NUUNlacsSs25I98HP1iuRTwen1qqHizfVekrARzf8MoYM4?=
 =?us-ascii?Q?h5O1T7qKKNN4S7L5UGERlhlp5a3Hw3qCVVmILPMf+4/kXXkNauqnaN1Jr8qR?=
 =?us-ascii?Q?LYudBqS4h/Oqgh1FXPT4xLNFKjMHDZU/pkabzWht6kZK1/mYxpQ7RHXWpRct?=
 =?us-ascii?Q?iyZYKwmvfzmMOvKUqu3E7RD5Oh+LTcyjs2EgPkSFxVig7r0iT9bEfZMDSKhU?=
 =?us-ascii?Q?EpWhMhCk9dRX1cfmVryGltOlROpdMRbNE+1iNEe6YU/I4dVp+1QX3Y+mjiR3?=
 =?us-ascii?Q?/ye4RxwT0mIUvve6HgY7zgy2gd3gs8dEeEBZzHMV3Egslp8ar394eSLzCF6c?=
 =?us-ascii?Q?KuzTI4bGdFVl+5ETPPbhttXulvVonrhMlpc3N6VFIp7x+05OncuZTwPURLTL?=
 =?us-ascii?Q?d/Pe4+a8cl8HUCdmYVtxdiWLp0mk2XFeQDCROE459f5goMBOHRVf0wo1yM1t?=
 =?us-ascii?Q?I9t5zFSozLNITQhBGdcI58GhouekbJqSky0ozVyxCJ1QVyYeuX9YmgJ4D23F?=
 =?us-ascii?Q?w2b7v8g6B+6AUUKGVWo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9206.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a31bd8-8c51-462c-e46b-08dd51a8a92a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 12:18:19.0414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zwp3nzb4E+nDII6Jssuie5Wkj99VLOaRX1+fk2EEoXEWiAhYNngGQ3uQTzWn4nvw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Rob,

> -----Original Message-----
> From: Jain, Ronak
> Sent: Thursday, February 13, 2025 4:46 PM
> To: Rob Herring <robh@kernel.org>
> Cc: krzk+dt@kernel.org; conor+dt@kernel.org; Simek, Michal
> <michal.simek@amd.com>; Manne, Nava kishore
> <nava.kishore.manne@amd.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH 2/3] dt-bindings: firmware: xilinx: Add conditional p=
inctrl
> schema
>
> Hi Rob,
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Wednesday, February 12, 2025 3:24 AM
> > To: Jain, Ronak <ronak.jain@amd.com>
> > Cc: krzk+dt@kernel.org; conor+dt@kernel.org; Simek, Michal
> > <michal.simek@amd.com>; Manne, Nava kishore
> > <nava.kishore.manne@amd.com>; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 2/3] dt-bindings: firmware: xilinx: Add conditional=
 pinctrl
> > schema
> >
> > On Thu, Feb 06, 2025 at 06:22:43AM -0800, Ronak Jain wrote:
> > > Updates the Device Tree bindings for Xilinx firmware by introducing
> > > conditional schema references for the pinctrl node.
> > >
> > > Previously, the pinctrl node directly referenced
> > > xlnx,zynqmp-pinctrl.yaml. However, this patch modifies the schema to
> > > conditionally apply the correct pinctrl schema based on the compatibl=
e
> > > property. Specifically:
> > > - If compatible contains "xlnx,zynqmp-pinctrl", reference
> > >   xlnx,zynqmp-pinctrl.yaml.
> > > - If compatible contains "xlnx,versal-pinctrl", reference
> > >   xlnx,versal-pinctrl.yaml.
> > >
> > > Additionally, an example entry for "xlnx,versal-pinctrl" has been
> > > added under the examples section.
> > >
> > > Signed-off-by: Ronak Jain <ronak.jain@amd.com>
> > > ---
> > >  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 20 +++++++++++++++++=
+-
> > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,z=
ynqmp-
> > firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,=
zynqmp-
> > firmware.yaml
> > > index 2b72fb9d3c22..d50438b0fca8 100644
> > > --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> > firmware.yaml
> > > +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> > firmware.yaml
> > > @@ -76,7 +76,6 @@ properties:
> > >      type: object
> > >
> > >    pinctrl:
> > > -    $ref: /schemas/pinctrl/xlnx,zynqmp-pinctrl.yaml#
> > >      description: The pinctrl node provides access to pinconfig and p=
incontrol
> > >        functionality available in firmware.
> > >      type: object
> > > @@ -106,6 +105,21 @@ properties:
> > >      type: object
> > >      deprecated: true
> > >
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: xlnx,zynqmp-firmware
> > > +    then:
> > > +      properties:
> > > +        pinctrl:
> > > +          $ref: /schemas/pinctrl/xlnx,zynqmp-pinctrl.yaml#
> > > +    else:
> > > +      properties:
> > > +        pinctrl:
> > > +          $ref: /schemas/pinctrl/xlnx,versal-pinctrl.yaml#
> >
> > The somewhat preferred way to do this would be to do this in the top
> > level:
> >
> > pinctrl:
> >   type: object
> >   additionalProperties: true
> >   properties:
> >     compatible:
> >       contains:
> >         enum:
> >           - xlnx,zynqmp-pinctrl
> >           - xlnx,versal-pinctrl
> >   required:
> >     - compatible
> >
> > Otherwise, the pinctrl schema ends up being applied twice.
>
> Thanks for the patch review and inputs. I'll update and send the next ver=
sion.
>

In your suggested code, the schema allows either xlnx,zynqmp-pinctrl or xln=
x,versal-pinctrl on any platform, which is incorrect. This means that if a =
user mistakenly assigns xlnx,versal-pinctrl to a ZynqMP platform or xlnx,zy=
nqmp-pinctrl to a Versal platform, the wrong reference will be used, but no=
 error is reported. The dt-binding check still passes instead of flagging t=
his as an issue.

By using a conditional schema, we can enforce platform-specific compatibili=
ty, ensuring that the correct compatible string is used for the correspondi=
ng platform. This would also generate an error if an incorrect compatible s=
tring is provided, preventing misconfigurations.

Please let me know your thoughts.

Thanks,
Ronak

> Thanks,
> Ronak
> >
> > > +
> > >  required:
> > >    - compatible
> > >
> > > @@ -164,6 +178,10 @@ examples:
> > >          compatible =3D "xlnx,versal-fpga";
> > >        };
> > >
> > > +      pinctrl {
> > > +        compatible =3D "xlnx,versal-pinctrl";
> > > +      };
> > > +
> > >        xlnx_aes: zynqmp-aes {
> > >          compatible =3D "xlnx,zynqmp-aes";
> > >        };
> > > --
> > > 2.34.1
> > >

