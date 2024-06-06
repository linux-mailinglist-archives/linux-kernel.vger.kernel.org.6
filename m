Return-Path: <linux-kernel+bounces-204716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9768FF2C1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17A91C21FF5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5602198A0F;
	Thu,  6 Jun 2024 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="rdBXanAf"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2814317BC9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692163; cv=fail; b=hTS5Ls/0vnItphr+/DsG36ydMojwKow86ba8LWkxr31iAEy1/VLjKLJtqm+a+mDFXlf/7qryXMUHVCh8kRwaQwmgl85SGZrL0SWhjfWw9KTi+k7X99iKau11Y+8TA5U08f5gdClIW27qscoixxmj2P/cZK7pBVtklTMOqvED+c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692163; c=relaxed/simple;
	bh=iA0CdC5c7jq3R9m5c608/kBOffx4pgY3ZUqz0ftXbMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aPnpcdGVfflAzFCZ7LAL4EqCtL1m2BvKPtTuVZHRgsPup2MF8oLQLxOBZcAKta/roC0HriBcNE3uLV0yXpyOwBvZUv9W1sNNiRmcy+LbHlLDY06oJ0z8MG096gZzHu0ZN4qalr6WxS6I6bMZ5NT40OUo31sO5XRywVZGOs3ygfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=rdBXanAf; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 456Atpn2008656;
	Thu, 6 Jun 2024 09:42:37 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ykbq71s1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 09:42:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YH95WFuZVBwVY+HgvBGP3U8nUmhlcGkTVy5j7+QbdQE1wiQ6AQpHL1H24x8MQqYb5qxoWSQ3C0PwSyljxmD21MVj2BVsWlgwtzcq7SMFFi7daIkHYnYRJKgoEeL/EjJlKW/s2hCXSmsoAArUv5LPtZAeajF4xaHgsharNCZ1XaBXlFBJ10+pLq0ut6DI3hyVFXUprG7JF5A3Oh3TMGUMw+r3s7CQ3h10Y6SRqd8Zx1TLXtbYk2iODdtB+87Mm/V5xbhY5NV9j/eE5LZNA/ihFFkWZHYFkfH2ANDR3qAc7XIRJQSqeZIr7qyF9MiOhnu9FxdfPGJnVO3eXG8mB94kOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjaRVUjEU9fZaRzLuniGfALAOkDwKP7KoQU8TJM9/Cw=;
 b=SWO/w/LfHu2Trxel0ZG3RV6fKyGE+A608rVdLauUD4Q17s1jEc5IyoIhpsTSXHa3iW2dblYdQdT3X5bAvouQuawZll8+6oalgpEDRk91GdnnwsV1x7lUQJtlDsv3ehGIqzY0y4quod1TfvnDiZcVIjnDKBDpBMcujJDNDchmpgcodoCufoasbmCOh9Vd+UP37zncVZiLzg5xjJ4EXw5W98r19+c3dlX184sv7R+of2DGTgrN2XxNxcHjoJVO+YZdJ6rVqbG/L68FFV7bJPH+pOwjA6tw8XrEM9GfXB+XAZv0hZzYARWoOSjFmnUxmfmRoNNzYS/SfKbhcZbWJtTZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjaRVUjEU9fZaRzLuniGfALAOkDwKP7KoQU8TJM9/Cw=;
 b=rdBXanAfucAl0ZyGOkW++oqdAlo6oH6VCV+UcrWmiv9U2mq5WIxYbSULrjzzg2eqmC/c9D70c88PuGmVFmi0CZK/vyoa6+b3DoTcshA7boruIXf8lgRgOKfWixwdYs87oFVMxaYxflzlWNTjCuX+e8Du6T7WlY0XQDDBWY97x0Q=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by SA1PR18MB4776.namprd18.prod.outlook.com (2603:10b6:806:1df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 16:42:34 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b%6]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 16:42:34 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Jerin Jacob <jerinj@marvell.com>, Srujana Challa <schalla@marvell.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v7 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Topic: [EXTERNAL] Re: [PATCH v7 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Index: AQHaqqXUeJduCBvv+0e3+QVunpJsgbG32TAAgAAF9zCAAyjT4A==
Date: Thu, 6 Jun 2024 16:42:34 +0000
Message-ID: 
 <MW4PR18MB524422223AC92181942C75E2A6FA2@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <2024042950-refurbish-duckbill-77b4@gregkh>
 <20240520110630.2568767-1-vattunuru@marvell.com>
 <2024060412-amulet-unflawed-f37a@gregkh>
 <SJ0PR18MB52462AA2A9F15103D5198CC5A6F82@SJ0PR18MB5246.namprd18.prod.outlook.com>
In-Reply-To: 
 <SJ0PR18MB52462AA2A9F15103D5198CC5A6F82@SJ0PR18MB5246.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|SA1PR18MB4776:EE_
x-ms-office365-filtering-correlation-id: c63848c7-4b18-44b4-b742-08dc8647aae4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?g8PtnklHvddAMwdFXHojXhQ/hXJ2LA7ZQUfQS1bnd+gbAqMRM5y6of9MhFDi?=
 =?us-ascii?Q?8NOKbpcCbB9B+DJ4SsUhbcHJKYWOB3LJlaJlnljLnUz7wLbrnWb5kc7Zn34q?=
 =?us-ascii?Q?hkdx+uZTvrRLpMYmLGxOr1OSLnJOUtwPK0lk2Dutv2pmuyzp6F+P5XkZyB+C?=
 =?us-ascii?Q?Y/a50T1106E4BCFAWygiVGP3WEAift/XyMSDr9WFOQ4Y9zeT64LMerpfKFRg?=
 =?us-ascii?Q?3uyFJ9A1HikMwTumUAEcMahIPVZaEMWW5cPVo/fdF8mou53KkOrD6ISeC9xw?=
 =?us-ascii?Q?x3gzMFMD82kYFoTkRnmiOQ/pQsrptbIaM+9vQaUvPNBW8QUKioWsH5AbknpX?=
 =?us-ascii?Q?Rb9/mzzu1ML9ESFkpQhAvw9JuflMKT7dnmNTp9FMzSuNT3/3dBZ7LxDyCnlQ?=
 =?us-ascii?Q?CjySD8J2WE5TeFeChIcvVCuK8xBxGkuPvVhR4MdD+zOXtUD2g1LaOooiMe3E?=
 =?us-ascii?Q?t18mtW+SXlq1CDkxJh3YHurSlfBIOrZbS54VNOsk6Yc8QeBfcM7N8qKinL7j?=
 =?us-ascii?Q?qdCv/s/UHeQK7XsdIJCPFMmlAFzQXDFzOJNWLfpibnpZkbE2SZVwVL6nqRrH?=
 =?us-ascii?Q?ZQ/yF4Pqn6t/qjd/GulWZI1FeafaepTfWDwNlWpSXtYuMWXqgVqBtld2tJWz?=
 =?us-ascii?Q?NSUVwr6wokRCJoeGVxzbCJtcANw80lhInEClr0VhLFm1hMfJAPPk/3KgRU4L?=
 =?us-ascii?Q?Z73960bflCunjxYCq75MW+v4Jkg3pP8DQrVBipebVMGiGbZZF98NIPJepn2k?=
 =?us-ascii?Q?GnQQNHhdxchFinVPjoCfQxZ9gV8lyD7PMEziMCZR0jjJ6AE+tq1GaiDsL0qe?=
 =?us-ascii?Q?4zwmWj8gPxQACp6Ojy0/zWMlpHDtMtWysKE+TMa7UNr3hkJAFtrPT4Zl6aXd?=
 =?us-ascii?Q?ya9UiyxUct8sXnpo2immJr/o7nNZpXCJy1OKUR6S6AEAVoqq7yrQuqkOfqc3?=
 =?us-ascii?Q?pIKw1+vv8KVhUFe3QCLxIE4MIXaRUhobdWnH9QboNILY2jry2ynK8B1mX6F9?=
 =?us-ascii?Q?IU83Ld/d54ABnvxXV/xmfWg8eSi694JOecU1WacPuLfrLoRTi/ZcxE8cmudT?=
 =?us-ascii?Q?tCua3KgIq+R/9iCt/kcDYoZ8tqQGt/tuyEf4w1QSsvXsDlxkEhIdg/KMU+ac?=
 =?us-ascii?Q?FBm+pVumuS+YUOgSpiRW5nXWBBPMKiSGnobPeWUNpDM4h5dVGmQPxqytRFHZ?=
 =?us-ascii?Q?eM/KtlP8c16B/UTF3mX/jCKCsnt/x7cVFbMWWklh0OS01VCuuaIBIFySpDxN?=
 =?us-ascii?Q?LeGQHP0UPSCldQmZqYenaujgGGiltJUSjQg/rcJ2iF0567uMhcag+YWyr40T?=
 =?us-ascii?Q?RxGC34xsC0btOyXNadNOn8FFDOW0QZSzc03uPohdwYm/XVZqTZiLuOsBuJbz?=
 =?us-ascii?Q?VRkCQbc=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?GWKI5sQtQymulZ3gs7SRmdzh63fUcV7TZt9vDN3wQJUdt0PRVD0Rm4LCbd8z?=
 =?us-ascii?Q?CJM+BIm3WOaSn8CUB1RuaKZkkGj+mPOKX12Ly0GuqJDV5ER5rMkHXjTRGWlY?=
 =?us-ascii?Q?ofnuHLHVfsR9ReAS8U4JYW9l0DCgGJy70IfBf5o6q9xv7OxXpykXtg6VYZLv?=
 =?us-ascii?Q?K9y6PzU6dPCupl/hVcAtgcrnlAH2AS5K0IkrOOnWxX38Wa16Zq0kcRC1cp2a?=
 =?us-ascii?Q?C5mGqehcTtm5mRPbInh3swBjLwfXsvuEUjn7qb0LMq1RaE4djsngfLD7iy1s?=
 =?us-ascii?Q?jbGJPfYpiJc7EQJM5zBd1SRIQJl4D+XZvZUyrNAmkZXb9zYc+D654VCA7uy7?=
 =?us-ascii?Q?Jr42rd+O0/txoJXRWWENEQTDdF3SYFRBvUPWIdEOAzG2nDyt4VgrpoPSySFS?=
 =?us-ascii?Q?9+dBEZ2cDM9rX2AHdmT5tKlgTiNOr/XTbfvLDPD3ScH3qhp0X8VHhispA6Sq?=
 =?us-ascii?Q?zzeupOCuBl+xWORDJVsIHDJ9T1rDY0Wo/6ihtDT0O/+Y9+WYi3b48x6LTfPw?=
 =?us-ascii?Q?B6gUkWc5lfNLxZzjwSxYERTpDkRSfc4YKXX0A8ROajYM6QCHMQCOfYcmD6dz?=
 =?us-ascii?Q?kE5KB7ghJgdoXxLi/QGYGznBnp/nMKku5v2dvizNDXHCoi5VbAGTVS1goCev?=
 =?us-ascii?Q?/gTDSZZfhe6ysbu8AhLWdS5z+7RlPzdOzcRQq5VIN13kvDJO4Se0SW67gi1T?=
 =?us-ascii?Q?ZTk7u2ygNbE6IOserZcF1sc5oiY1Usxuo0epX6ZPJM/w/l8IZOtvsjSPwojk?=
 =?us-ascii?Q?VFIBt+PXIhuDr9cNsjdnu7vR1pdGychW4vScbV+z7tUKt5h50UeavNFAWhs1?=
 =?us-ascii?Q?McG9dNwHtAlLBPQZWU181J4d0ivhwFZb3N2BknUHek3lq5ERUBr1STG53xpI?=
 =?us-ascii?Q?QNxKBMRry5rOb9DqlNnbLBN8KLzHchAf/nkukl6a217Ixvqn49lQBCYzhJmq?=
 =?us-ascii?Q?6fbS1vQsmOLWKxdxX2AGK3YRA+2E8vLBEUmkT2dilDceE4JSIuZhdoSEvhL/?=
 =?us-ascii?Q?KiWU8lz0Skkn1wSJJ/D+qD8KfwhqkYQL/xGaQRGDhCuv8AZYCu//6+GuoFvC?=
 =?us-ascii?Q?295M9PNyXQwOoTNb0niMKJQN7JW2Ae1xs1hRv+MoloNL2BEG+kA+fDMRPrwz?=
 =?us-ascii?Q?oGt5524cJoJaoJ+miRxKcvyvfM+FBO31o7mNDSlTQlzoo9nDHadgDGpTFka2?=
 =?us-ascii?Q?l2BTETHfx9b0yArON2Xt9zWI62q4dM7swSyg6ELywHLGFgMvNK7o2F91DXtj?=
 =?us-ascii?Q?PKfojSC7KIOBtzK23LjBSUOC7soICWn7j3mSjxRr4q+zTpq6gF+ia03Wcec8?=
 =?us-ascii?Q?+eSQAqwduYjQT+vWxqED5A8UcTwDBdDGqAuVz2KV2e+XYhuCo/A/2uK8Jny4?=
 =?us-ascii?Q?0f/w4FY1SCGKW3rTc5h8Bbmv5BPDGKfhBh7dE0HSKYbqO6XhKw3RbjgWTpaa?=
 =?us-ascii?Q?V8nb9z3Ik+We7hANjZG6CGUfzTJEaM9rYAG7mLyCTmPMe/j4bQbe/ArBWIEI?=
 =?us-ascii?Q?lchf0bCXUHBnUA7lWPXla2zl7084rq1BFYzdOWmneADFUxT4SnAed3pWJzhT?=
 =?us-ascii?Q?TIoJ1N9uAUymfZgCyrVpXXyolpdz9pvSUQgB5hHv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5244.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63848c7-4b18-44b4-b742-08dc8647aae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 16:42:34.7067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G86LyoXbBSafxe9VkI5Ly8GhICU+7jA5kXNYOC+IRflLVpwmoK+lGQtspUmL3JqBSZ45F8KXafy8Uk4Z7Sa9mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4776
X-Proofpoint-GUID: 5jzwqnbQS126sLH8m8xOWvTqT728KiYT
X-Proofpoint-ORIG-GUID: 5jzwqnbQS126sLH8m8xOWvTqT728KiYT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_13,2024-06-06_02,2024-05-17_01



> -----Original Message-----
> From: Vamsi Krishna Attunuru
> Sent: Tuesday, June 4, 2024 9:51 PM
> To: 'Greg KH' <gregkh@linuxfoundation.org>
> Cc: Jerin Jacob <jerinj@marvell.com>; Srujana Challa <schalla@marvell.com=
>;
> arnd@arndb.de; linux-kernel@vger.kernel.org
> Subject: RE: [EXTERNAL] Re: [PATCH v7 1/1] misc: mrvl-cn10k-dpi: add Octe=
on
> CN10K DPI administrative driver
>=20
>=20
>=20
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Tuesday, June 4, 2024 9:23 PM
> > To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> > Cc: Jerin Jacob <jerinj@marvell.com>; Srujana Challa
> > <schalla@marvell.com>; arnd@arndb.de; linux-kernel@vger.kernel.org
> > Subject: [EXTERNAL] Re: [PATCH v7 1/1] misc: mrvl-cn10k-dpi: add
> > Octeon CN10K DPI administrative driver
> >
> > Prioritize security for external emails: Confirm sender and content
> > safety before clicking links or opening attachments
> >
> > ----------------------------------------------------------------------
> > On Mon, May 20, 2024 at 04:06:30AM -0700, Vamsi Attunuru wrote:
> > > +union dpi_mbox_message {
> > > +	u64 word[2];
> > > +	struct {
> > > +#if defined(__BIG_ENDIAN_BITFIELD)
> > > +		/* SSO PF function */
> > > +		u64 sso_pf_func  :16;
> > > +		/* Aura of the command buffer */
> > > +		u64 aura         :20;
> > > +		/* Command buffer size in 8-byte words */
> > > +		u64 csize        :16;
> > > +		/* Command code */
> > > +		u64 cmd          :4;
> > > +		/* VF ID to configure */
> > > +		u64 vfid         :8;
> > > +		/* Reserved for future use */
> > > +		u64 rsvd_85_127  :40;
> > > +		/* Work queue completion status byte offset */
> > > +		u64 wqecsoff     :7;
> > > +		/* Work queue completion status enable */
> > > +		u64 wqecs        :1;
> > > +		/* NPA PF function */
> > > +		u64 npa_pf_func  :16;
> > > +#else
> > > +		/* VF ID to configure */
> > > +		u64 vfid         :8;
> > > +		/* Command code */
> > > +		u64 cmd          :4;
> > > +		/* Command buffer size in 8-byte words */
> > > +		u64 csize        :16;
> > > +		/* Aura of the command buffer */
> > > +		u64 aura         :20;
> > > +		/* SSO PF function */
> > > +		u64 sso_pf_func  :16;
> > > +		/* NPA PF function */
> > > +		u64 npa_pf_func  :16;
> > > +		/* Work queue completion status enable */
> > > +		u64 wqecs        :1;
> > > +		/* Work queue completion status byte offset */
> > > +		u64 wqecsoff     :7;
> > > +		/* Reserved for future use */
> > > +		u64 rsvd_85_127  :40;
> > > +#endif
> > > +	};
> > > +};
> >
> > The ifdef is cute, but not correct, sorry.  Please use bit shifts to
> > handle this properly without any #ifdef needed at all.
> >
> Ack, will fix it next version. Thanks for the suggestion.
>=20

Hi Greg, the ARM64 cores on the Octeon CN10K hardware platform always run i=
n LE mode and this CN10K DPI PF driver is only supported on Octeon CN10K pl=
atforms as the DPI PF device is an onboard PCIe device. Can I remove the BE=
 format and only define the LE format for the dpi_mbox_message structure?, =
other HW device drivers of Octeon CN10K platform also only support LE forma=
t.

Regards
Vamsi

> >
> >
> >
> > > +
> > > +static inline void dpi_reg_write(struct dpipf *dpi, u64 offset, u64
> > > +val) {
> > > +	writeq(val, dpi->reg_base + offset);
> >
> > No read needed after a write to ensure the write made it to the
> > hardware properly?
>=20
> Yes, as it's an onboard PCIe device, writes will happen properly. I will =
modify
> it as write followed by a write barrier to avoid any reordering.
>=20
> Thanks
> Vamsi
> >
> > thanks,
> >
> > greg k-h

