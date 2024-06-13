Return-Path: <linux-kernel+bounces-212485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85EB9061A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 04:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8061C20A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 02:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B63374C4;
	Thu, 13 Jun 2024 02:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wnz1/3pp"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2050.outbound.protection.outlook.com [40.107.13.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D2A7F9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 02:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718244780; cv=fail; b=fsbHXDSGUXBJRGcP5vkAoiCqswH7PswPrVWN7tXItjMO5X6MvPd2vWoKjiyUiI4GujC4ynKobS5f3BejpIrdZHKPkK65njlpqAGs4MpngAPc5XMe27gcfFEbMKLZi6vTvNNUsvqbxRJeWC/3gkaEmLg912yTWcuSP9xvHgzddLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718244780; c=relaxed/simple;
	bh=Naup4q1Ktbnj1Ee8IOHKk6GxGhJolU8E1gW3DA+z+F8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B2Sm2fGiNmi9zHTxCBysQyOmeuBuk4NCH+7QpfoVD3CujVNwPTGlyk4rUsJkTib0WQCBvy0d29a57qkhKfsRxgEVYkqWqeNWvvZzWkusrBZMr0yp8CoRn+oIaACcyBClL0dKpt9QLtRuEdN5OJWot38JPH514mBaRltDcaGM3WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wnz1/3pp; arc=fail smtp.client-ip=40.107.13.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPjNCKIJTyjnuBt3Angq6CZt7FnvbyZO2PH74pMhOGEzyMkbQY343rQtv7qxZprl7FRb9OFhkk4sppia7woV9zPVAg4Tv7xGkyZGd6BgE+7tyP5JJTEAiMlPUGGoENf3BPUTh4UhLcB8lseYK9ZvJ0AHeiQGVvl/H83Ie3JytRtLrVrhggnT93Sszv5lyWEsCuOxUzo/w+BMFGUOHRUz6HiEEVYQeGLAae6X9tgU+uJveWUPaR8tJ8nppUbxY4hAn1YZxdhfqY/zpPrdS1iP+f6PM9EMuYd7LKk9YBZ7pRNahtTgazlIorkSIr8oPKlcS4K0BJXPSaecFJ1YVlDZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbCQLfxF9PRnImxflHH6gFzyNHD9w8Q8bVcMW4MXvAs=;
 b=UakJjDcaWSdMFYaLJBbN3SY6KpHsnlI/fkFlvVMI+GRCBEK2G66p8z0uPXfnOU7CYIAFwZdhFDL9yGSAMe5cnFE5bzJ0wZjBwHrfspXcWDy4gRxpDcbBc1Z58JLa9QD9lSAdVMoL1gBfVhD5VpTVWasEVoaOTwZvcwU+l2AfCwdjARMLSm0pTMkJM5fIe6gdYjJPvWgEm0SX+tKik6NrWHkffxMgZKf04PpPpxsDpmUXQZtwJYLz/dHa2NjrFDiLaLpvnXgtZGGSlN5ln8RwRzzOJGtd/Khv2E6NCTfsU+UDX2J9ZVmlanTP3P1gE20c36VqdpFXuk8Js84SXjz1OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbCQLfxF9PRnImxflHH6gFzyNHD9w8Q8bVcMW4MXvAs=;
 b=Wnz1/3pp8R823254FX6EQll8xd+mikVfZERQUoC1LoBmNCX6xn4mZS0j5AJYUb5EoTFr+LqHo77zLJwpaV/9TRv5mj+SfJwa399ZFTZCNXeznlgmWHPttVXyRyZNCqs+S32xvwGUTx0Mvo/y2ZGUtI/ZGO3qYYmqjTy31RZVd9A=
Received: from AS1PR04MB9559.eurprd04.prod.outlook.com (2603:10a6:20b:483::21)
 by AM0PR04MB6881.eurprd04.prod.outlook.com (2603:10a6:208:18b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 02:12:54 +0000
Received: from AS1PR04MB9559.eurprd04.prod.outlook.com
 ([fe80::4fdc:8a62:6d92:3123]) by AS1PR04MB9559.eurprd04.prod.outlook.com
 ([fe80::4fdc:8a62:6d92:3123%3]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 02:12:54 +0000
From: Zhai He <zhai.he@nxp.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "sboyd@kernel.org" <sboyd@kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Zhipeng Wang <zhipeng.wang_1@nxp.com>,
	Jindong Yue <jindong.yue@nxp.com>, Barry Song <baohua@kernel.org>, Christoph
 Hellwig <hch@lst.de>
Subject: RE: [EXT] Re: [PATCH v2] Supports to use the default CMA when the
 device-specified CMA memory is not enough.
Thread-Topic: [EXT] Re: [PATCH v2] Supports to use the default CMA when the
 device-specified CMA memory is not enough.
Thread-Index: AQHavKBGxUJQI1jHm0WeihrG1yRS87HEeMkAgABzWTA=
Date: Thu, 13 Jun 2024 02:12:54 +0000
Message-ID:
 <AS1PR04MB95595065EF7A3C2DD9F51913EAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
References: <20240612081216.1319089-1-zhai.he@nxp.com>
 <20240612114748.bf5983b50634f23d674bc749@linux-foundation.org>
In-Reply-To: <20240612114748.bf5983b50634f23d674bc749@linux-foundation.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR04MB9559:EE_|AM0PR04MB6881:EE_
x-ms-office365-filtering-correlation-id: ebfc20ef-b902-47b2-0782-08dc8b4e55cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|1800799018|366010|376008|38070700012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UqoD7vIh7zGbGHw6n3rVpVqfl7/3Ej8EcP51D8kZLUG1c27loOoi9omR5nPh?=
 =?us-ascii?Q?eL+Fk3Uo6MhmYx5WKcpGKmzRlzoqGmTKv3Rjf3fNl9BM2NYXsuF2MZbq4Cca?=
 =?us-ascii?Q?knGmkvyYG9EZ+5xNp1pDiGqkbfBy1k2tWEZ2pp4/kNbFWdBkHkD0zKfZNfFn?=
 =?us-ascii?Q?b8Oq4qwECM5ItGljSrpeGt/u9mtuUATlU0VOje5oMpKeSm3KUgdO3/CRxV0h?=
 =?us-ascii?Q?q9AxdxTJz3RcVtDlh2kTnfvA15YSzEKe490Ag+8gPsbowKLlNabEFNKYRJ3S?=
 =?us-ascii?Q?dtNT181qcA+da+UctXS6WIMnn5bBO7dafrHmgk26Pn4B9T1q7ZufR0tEHnZv?=
 =?us-ascii?Q?zHLXh3TwBsRTsD7+oA9KrcXy0LbFfKV2C91oXcXPLLQW/Egs7NDzfFaLSeiQ?=
 =?us-ascii?Q?VfBcqqVi1rZ8aUErvr95jv+9DRmrVnfOfCbxz2mhv8pKoekcSqs/fkGl2wkA?=
 =?us-ascii?Q?qJb7CqgHqNbBcYkALT2YsAunnfYXNo8srgR848qjqtoZxqEnv/SIy7kZFGMC?=
 =?us-ascii?Q?uyY3+W9eIzKk//Hk7moZLmmapt4B2OzOBYZ+ZqlldKb9AkzFTmWfHHzuv3uT?=
 =?us-ascii?Q?cLuetVTshMKL7MGWKyuVR1kUow80DkVMgQMkLqasOIn1PqTkZpmEsbr9iVjk?=
 =?us-ascii?Q?NWTdUdtQEkiFadFfVSLRqw4Um8hj7o52wE7MYZCcsrVM/rFz5FqsrvNnhZSP?=
 =?us-ascii?Q?Q9h646tz8by0bU4FATQVE6hoVC+JNw//++z6zHNA08Fm36R6MSbERgpnruo4?=
 =?us-ascii?Q?qM9WC6nYMx/M4vc31zXKV3xTIzdfeF+wOR7Ao8Lh93kk1Hgi2Y7i4dp9tyI0?=
 =?us-ascii?Q?5tqcNWhiIKQpd/nNj4lx2xWV3AOUGkEUj1quGLrkmeXbIFxBCHiroZGE+RU+?=
 =?us-ascii?Q?yeZLytzq44+Rm3dZFIU8Ec2SVHOyAP/oNba1BFa+JaDkW/ie7yxew9eH+gOY?=
 =?us-ascii?Q?sQe0KHZ0oe+zKf6ZgwNjeO36Aa5kJV/O789txPO5FEnHMjyXQyvWYLPO4X1D?=
 =?us-ascii?Q?r7v93wAtWf7y2HfXnSPwlEesmgPXuwkzZ4Tj4NbKd4j9zx5rCj+UrQabNf6N?=
 =?us-ascii?Q?epfnaqZ5tLXr2HXTvd+oLmfaAZbn/VZmFlSny30GyqbeOo2ATusp+gxHqcrP?=
 =?us-ascii?Q?7xt1IkKcUeLkXM0Vnl3UZ9yKYzHPVSm2KfV+QKn1rN7m/6BV2lF6GrFJyP4I?=
 =?us-ascii?Q?0vHtZDLlnd4Wra8tXR4r36K1Np4uD9GcAFsrM30TTrApHNKXpijNaN2dt88B?=
 =?us-ascii?Q?7c/A4hzb4WcR2JVy7OMXvPBPbRVAcdP7tivUn6VhPCVhqo5tkIaDAty6XH85?=
 =?us-ascii?Q?qt8k1ibc58HSV7gsD0KZvo7XLp03O3P30Ge/TSQBfuptChkO1a7Ti6ZwOsUS?=
 =?us-ascii?Q?m4N1SwvJqA+blLl2yUOvpB7SINbY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9559.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(1800799018)(366010)(376008)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7Yo41RVHRPxxIB/K2Nj5VT7iv7Y3KGMm1+K/KroB9rE2r8gcijFFYHCT4sS1?=
 =?us-ascii?Q?o+q6F5FQA9YL02ncYKBoVwqNgv1KgHwOnZ+i6oU8QGwAti0qaPHHGsfVMv/H?=
 =?us-ascii?Q?Ldl5zpc3VdZZ39rpjz7ijQVA7xKc6+w57ezgqrVz0ovD3Uhw2/xgzu8/JHY/?=
 =?us-ascii?Q?MOLqISCcWBeqxE37qhT6W/4QHxioBo4c2k589TnRE+9slIWrd9aTJbcisSM+?=
 =?us-ascii?Q?yiPQFIe0FuYcnY/XRMCVqqWjGKZWnzB9CZf1wdY8FpR03SEJV4d9/aNchaRj?=
 =?us-ascii?Q?ezHVcs1lfd+pOTPm6XtteVyxwGNZQKtMl8/yLX9iSVa8hx/9DPZcsDfmyMLs?=
 =?us-ascii?Q?8+Q0X/1NWPJb9flcp1AOpwkJt8wZtQ3z9bnhU4WXS4s16S02keCfeF/A6ncE?=
 =?us-ascii?Q?x/+jktpE3vMaXEE4ggmRi2qjCMZcodTtjmlbN5egjp7kQFXotw+2qWJJAoE4?=
 =?us-ascii?Q?ruVbXiCF3WUULWmEzSXz2NoeYoO9xV0q8zoq/AfPm7j1TGyIq5m2L8A9Yjz+?=
 =?us-ascii?Q?S1NuUm5rCmNH8NhLqerop9nwhFr7oVD/Ti54Nb2wKl+iFRb7j8sFZMStyipS?=
 =?us-ascii?Q?pk/bNf3RC+g21CeciFowVR/s2riSnHV8q/aJSbbGcVzcT3x8/+A7B2P3CMfq?=
 =?us-ascii?Q?6onhp/5JmCzs6TGtTddLRkjVvLw0l8sUnr7eUSEdRCHHb9ztlOodaS3akDiR?=
 =?us-ascii?Q?wcKy0Meb06nPXJ6Igeg27lhDNGZOxOzAHIB/af9WhJb1d9yRURUvXZ5v8X5v?=
 =?us-ascii?Q?w7hDMdUpI4Ab/xOi0g65b0ZdYpT/gudhVIDDE3pBI5cxg5duVdyqIOY6xOoE?=
 =?us-ascii?Q?Bs30oh3kQYIV/iRsgPs5VVj461t0ZHpM6ZM+tstzm4uiNfYBiGsWR3Xcz4G+?=
 =?us-ascii?Q?YH+e7aXQzD/kLDaey+bj8dTqlypzkJBLt7KNn+/G0bQ8qcMDj5RptzWNL+Xs?=
 =?us-ascii?Q?RjftN+9ivSETcr4PSQc9Ln+PxnemCD6nUPFwubac++9rq1Qu4TVN8KsslLXY?=
 =?us-ascii?Q?mQMYgYunWoPI6rezLHydn4wh4JVXBV8UvAwiGRkmfl8eOhLk5SUae1J5wvKq?=
 =?us-ascii?Q?42K6zy8oq6NnfzUdu2MUarbJ+GXFQoVD4LJTXMc8DuFtCtX5sMZ6RC9PSjPk?=
 =?us-ascii?Q?ZYLFotw1RSaJaI5zVDDX1vbwVyWKqOC7lRaxCJWoJs8Z2fHsGuYZs5KtzWPz?=
 =?us-ascii?Q?GhNYRVieFRxTWtRZZZyvJT2ZVzn9urog6YcdkSwUKvyzci9imlD16mkHLHkl?=
 =?us-ascii?Q?qDk6p3CEVhP4XYFXLTgM5PgRY4ylzZwT8K33T5B2aZgEoiQ/hjhagTdoggjp?=
 =?us-ascii?Q?VNQUdWm3zETSHYsLE3H2HXji8/YuIZRr1hQs8GlsNaPYJABSqx69mN8EJ69S?=
 =?us-ascii?Q?set9RfMwZ510G2WtkvFScjXN1fTTdwFUtygP/s1w2YKPqVJEYLI+jpVQUMvt?=
 =?us-ascii?Q?tbeh7xQrFxtQd4V9cNlGnnu82l6HbSy/vVLyRjp5Z+fa4l3RCWidke0fEVd7?=
 =?us-ascii?Q?8Lhw8eTKtR4qWAlcaPz+FMGYMEaLtw1mt7GvcZR2KIaaac3W/h9x1/4LyisX?=
 =?us-ascii?Q?8KCYIIkNR0i08Gaclg4=3D?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_00F3_01DABD7A.3F477B80"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9559.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfc20ef-b902-47b2-0782-08dc8b4e55cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 02:12:54.2431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QeNrVDfpLK0e0fiUI84UemzKL33TUgV0rztmMjQpnIy0sepGzug/8fA0GP41Eo33
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6881

------=_NextPart_000_00F3_01DABD7A.3F477B80
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Andrew Morton <akpm@linux-foundation.org>
> Sent: Thursday, June 13, 2024 2:48 AM
> To: Zhai He <zhai.he@nxp.com>
> Cc: sboyd@kernel.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org; Zhipeng Wang <zhipeng.wang_1@nxp.com>; Jindong
> Yue <jindong.yue@nxp.com>; Barry Song <baohua@kernel.org>; Christoph
> Hellwig <hch@lst.de>
> Subject: [EXT] Re: [PATCH v2] Supports to use the default CMA when the
> device-specified CMA memory is not enough.
> 
> Caution: This is an external email. Please take care when clicking links
or
> opening attachments. When in doubt, report the message using the 'Report
this
> email' button
> 
> 
> On Wed, 12 Jun 2024 16:12:16 +0800 "zhai.he" <zhai.he@nxp.com> wrote:
> 
> > From: He Zhai <zhai.he@nxp.com>
> 
> (cc Barry & Christoph)
> 
> What was your reason for adding cc:stable to the email headers?  Does this
> address some serious problem?  If so, please fully describe that problem.
> 
Sorry, I don't think this is probably a serious problem, just something I
discovered while developing that I think might exist. 
I will not continue to cc: stable.

> > In the current code logic, if the device-specified CMA memory
> > allocation fails, memory will not be allocated from the default CMA
area.
> > This patch will use the default cma region when the device's specified
> > CMA is not enough.
> >
> > In addition, the log level of allocation failure is changed to debug.
> > Because these logs will be printed when memory allocation from the
> > device specified CMA fails, but if the allocation fails, it will be
> > allocated from the default cma area. It can easily mislead developers'
> > judgment.
> >
> > ...
> >
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -357,8 +357,13 @@ struct page *dma_alloc_contiguous(struct device
> *dev, size_t size, gfp_t gfp)
> >       /* CMA can be used only in the context which permits sleeping */
> >       if (!gfpflags_allow_blocking(gfp))
> >               return NULL;
> > -     if (dev->cma_area)
> > -             return cma_alloc_aligned(dev->cma_area, size, gfp);
> > +     if (dev->cma_area) {
> > +             struct page *page = NULL;
> > +
> > +             page = cma_alloc_aligned(dev->cma_area, size, gfp);
> > +             if (page)
> > +                     return page;
> > +     }
> >       if (size <= PAGE_SIZE)
> >               return NULL;
> 
> The dma_alloc_contiguous() kerneldoc should be updated for this.
> 
> The patch prompts the question "why does the device-specified CMA area
> exist?".  Why not always allocate from the global pool?  If the
device-specified
> area exists to prevent one device from going crazy and consuming too much
> contiguous memory, this patch violates that intent?
>

In our environment, because of Widevine DRM, we enable secure heap. When the
VPU decodes 4K secure video, 
the VPU needs to allocate a large amount of secure contiguous memory. This
will cause us to need to shrink the CMA
in order not to affect other devices that require contiguous memory. So I
specified CMA memory for VPU, But currently, in addition 
to the secure heap and CMA, the remaining continuous memory in our memory
configuration is not enough to support the VPU decoding 
high-resolution code streams, so I added this patch so that when the CMA
specified by the device is not enough, 
allocated in default CMA.

Another reason is that the secure heap requires secure configuration, so the
start address of the secure heap cannot be specified arbitrarily. 
Therefore, in order to reduce the impact of shrinking CMA, I used
multi-segment CMA and assign one of the CMA 
to the VPU. When the VPU decodes the high-resolution stream, if the
specified CMA is not enough, it will continue to be allocated from the
default CMA.

The VPU will not consume a crazy amount of memory, it just requires more
memory when playing high-resolution streams.
Therefore, this patch is mainly to prevent the situation where the global
CMA size cannot be satisfied.

> > @@ -406,6 +411,8 @@ void dma_free_contiguous(struct device *dev, struct
> page *page, size_t size)
> >       if (dev->cma_area) {
> >               if (cma_release(dev->cma_area, page, count))
> >                       return;
> > +             if (cma_release(dma_contiguous_default_area, page,
> count))
> > +                     return;
> >       } else {
> >               /*
> >                * otherwise, page is from either per-numa cma or
> > default cma diff --git a/mm/cma.c b/mm/cma.c index
> > 3e9724716bad..6e12faf1bea7 100644
> > --- a/mm/cma.c
> > +++ b/mm/cma.c
> > @@ -495,8 +495,8 @@ struct page *cma_alloc(struct cma *cma, unsigned
> long count,
> >       }
> >
> >       if (ret && !no_warn) {
> > -             pr_err_ratelimited("%s: %s: alloc failed, req-size: %lu
pages,
> ret: %d\n",
> > -                                __func__, cma->name, count, ret);
> > +             pr_debug("%s: alloc failed, req-size: %lu pages, ret: %d,
try to
> use default cma\n",
> > +                         cma->name, count, ret);
> >               cma_debug_show_areas(cma);
> >       }


------=_NextPart_000_00F3_01DABD7A.3F477B80
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIhTTCCBaIw
ggOKoAMCAQICCE4Rpu+H69FRMA0GCSqGSIb3DQEBCwUAMGUxIjAgBgNVBAMMGU5YUCBJbnRlcm5h
bCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJ
RWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0yMzA0MjEwNjQzNDVaFw0yODA0MTkwNjQzNDVaMIG2
MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQ
IEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmS
JomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTEL
MAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAWrnSkYP60A8wj4AO
kATDjnbdgLv6waFfyXE/hvatdWz2YYtb1YSRi5/wXW+Pz8rsTmSj7iusI+FcLP8WEaMVLn4sEIQY
NI8KJUCz21tsIArYs0hMKEUFeCq3mxTJfPqzdj9CExJBlZ5vWS4er8eJI8U8kZrt4CoY7De0FdJh
35Pi5QGzUFmFuaLgXfV1N5yukTzEhqz36kODoSRw+eDHH9YqbzefzEHK9d93TNiLaVlln42O0qaI
MmxK1aNcZx+nQkFsF/VrV9M9iLGA+Qb/MFmR20MJAU5kRGkJ2/QzgVQM3Nlmp/bF/3HWOJ2j2mpg
axvzxHNN+5rSNvkG2vSpAgMBAAGjggECMIH/MFIGCCsGAQUFBwEBBEYwRDBCBggrBgEFBQcwAoY2
aHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFBJbnRlcm5hbFBvbGljeUNBRzIuY2VyMB0G
A1UdDgQWBBRYlWDuTnTvZSKqve0ZqSt6jhedBzASBgNVHRMBAf8ECDAGAQH/AgEAMEUGA1UdHwQ+
MDwwOqA4oDaGNGh0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEludGVybmFsUG9saWN5Q0FH
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
MqAfBgorBgEEAYI3FAIDoBEMD3poYWkuaGVAbnhwLmNvbYEPemhhaS5oZUBueHAuY29tMB0GA1Ud
DgQWBBRnNp0/tSrFNJlgS+ZRdCT+c5yRQDAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhed
BzCCAUYGA1UdHwSCAT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnBy
aXNlJTIwQ0ElMjA1LENOPW5sYW1zcGtpMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2Vy
dmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9j
ZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9u
UG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9o
dHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUF
BwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBD
QSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNv
bmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVj
dENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtp
Lm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNlcjANBgkqhkiG9w0BAQsFAAOCAQEA
ggGwWe/YcZgJiMbIhUsSO/bYD09itDFnYO+uQqGwvPalRuHk3rA6pXfNb4DoA+gFZLgVDHNul0YA
oS8u+LYHUwXe/tP1HZvoInRRnUjPCP7o3uoQFcX2Ay0pVz3AoByHaFAqF3zCCsAdDhTksMPZu2eQ
oapJc06m3ZaIBpjT6aVZOXnRFVcHUjaMAZrpm2jqv3jJt58kP0dRsCrfKUkeTflak885rGuUypZC
j9tjOii+7/qAsUR/JqMZADUo2cD+PvCwHZRPpj0x1b5Ain8/3mRDTCaa7mMOUApMdd7De9fNjosF
LLTdnTiUXO+gnVgwXLvMOhuHTI6aWS+Z9pD1tTCCCDgwggcgoAMCAQICEy0AC58oXPwK6O6UsbsA
AQALnygwDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJ
BgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQI
DA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhw
MRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yNDAyMjcwMTIyMzNaFw0yNjAy
MjYwMTIyMzNaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMw
EQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAkNOMRYwFAYDVQQLEw1N
YW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGY2NDU5ODCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOFpbP807BLOCF4Zt9RudYkITj3hHgHYcWcIYUiT
PmR5wym2ussl7jezDSHHlEvPmzhgdSx/PVPpYcv80hjMDHFw3aoV0qyOU+W/pOT2oCL/7S/fHWUe
2Sahoup+MvYXycNdoONBohwwdCcWt71fxvxzsCq0XtnkUdgoTXFlZb53vhD3rAHvP/QhY8jLGvMa
I/xK5kFNYIC5EBH5m+atfPB7qERZIUU9nCacRfJVAZpkK0j8L1YBjG28Xm9OcDdgQAsOVRFdkFxk
3YVjHiSmGfDmd8QdvPJrlIDb/mdVXR/FGSl95J16mkithq2e3DBNOJtWrxxj3XDkmXpr9iAUGpEC
AwEAAaOCBFcwggRTMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRVhu2FOILrmUua
klY/heaKboS14X4CAWQCAUEwEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/BAQDAgUgMAwG
A1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZIhvcNAQkPBIGG
MIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBGTAL
BglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4GCCqGSIb3DQMC
AgIAgDAOBggqhkiG9w0DBAICAgAwUQYJKwYBBAGCNxkCBEQwQqBABgorBgEEAYI3GQIBoDIEMFMt
MS01LTIxLTE5MTUyMDcwMTMtMjYxNTA0MDM2OC0zMDc2OTI5NDU4LTk0NzgwMjA7BgNVHREENDAy
oB8GCisGAQQBgjcUAgOgEQwPemhhaS5oZUBueHAuY29tgQ96aGFpLmhlQG54cC5jb20wHQYDVR0O
BBYEFDrgyxq3zDcnhNi/Mb2VXLlr7Mn3MB8GA1UdIwQYMBaAFFiVYO5OdO9lIqq97RmpK3qOF50H
MIIBRgYDVR0fBIIBPTCCATkwggE1oIIBMaCCAS2GgchsZGFwOi8vL0NOPU5YUCUyMEVudGVycHJp
c2UlMjBDQSUyMDUsQ049bmxhbXNwa2kwMDA1LENOPUNEUCxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2
aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXdiaSxEQz1ueHAsREM9Y29tP2Nl
cnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Q
b2ludIYvaHR0cDovL253dy5wa2kubnhwLmNvbS9jcmwvTlhQRW50ZXJwcmlzZUNBNS5jcmyGL2h0
dHA6Ly93d3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3JsMIIBEAYIKwYBBQUH
AQEEggECMIH/MIG7BggrBgEFBQcwAoaBrmxkYXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENB
JTIwNSxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29u
ZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0
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

------=_NextPart_000_00F3_01DABD7A.3F477B80--

