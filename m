Return-Path: <linux-kernel+bounces-280900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FAE94D0A3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586251C20DB3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05247194C6B;
	Fri,  9 Aug 2024 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yfy4WzsA"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B89C194AEF;
	Fri,  9 Aug 2024 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723208128; cv=fail; b=Z2YfE1PJcCWWQawbnsYEKy1jIhtbhHs1O4ssb8FzdvWwDoC3Oz+uFUkU6t82H/dhXOwiuy9gIvcuAXBnxee0nJ/s56JKVJg4N9bLDHIE8mYLdXg+GMiobJ3d1u7cNxUp1wjRWPXcuZ4/2ElC9wE1SAiCMAHKKv/WTiZcC0fqjqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723208128; c=relaxed/simple;
	bh=CpJLt2qQz35xWsRN0yk3xSdK9u3v/IbV7XfY6f8b1nI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u+G4IpgJ5TrQ9dE+jVoHjtlEflpOItkiFSwHvX0hTuIJ0vXgmMqDN9Ra6A9ykMZ0gqY4RjKHyFRWeUWzOPSWtXAHJHIxemJFrnv/xMqywBh8LvG3slWgVCXhkcmeruUMhWy24RrGa79CfT63j3hRqPMhiayY1HxVcK02TxPJnBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yfy4WzsA; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoRuKJNFQli5NBRk+rCw4ONyEutOa/u1SOksAYk080ogjtPBR251MHN07JpKODoki1FXOv+gjv5RUHb2+nSYBgfCYlD70olHgcDqU+flhwit3HIMT+X6vLKoHdeEhrQ7ruX6DvKjCoHWkGczFHoZ0n/ApIP1Z7xZ7OKl0z50EI3bzTCwPnXDV24FxXiGQDggBtNdLMicWI+S8CGrFkXAMuUGpX8Qiu0zIAh8Gr5D2/IKFcNVINa86vBPMS02gPeEPoqqM75fDg6DWXfHZDsqKAnLawdc61U0cLJqurD4AMN5HBRkp9tpwpN77WoxQojhoR6ZUSxyulZe9OnuFtRMRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dl+AHHWW7vo308KAudGv0my4BAeKWdFvisUdMKAx5oY=;
 b=uasoPkeA7++rUceCFhGJ0QDSIYUwzVPDLMzT177grLrnpZhIxi+qbYi+7IImlN3wveig6ownhY8RI5029BGnJsvStMnIZiHLoaZ9rlL5jOi1ngmn0LJE1LnsZe4NRA2R5j/cnwaRLpeP8ADpSXoS6OsCh6XGxYq9eQt5WNIOGRNLk/S54Ze/UKp+bhtmJuk54tUdEqpelhA0kwkA9q+UUtazGThtHHUnHOByYgFSW2lPuPhcyyy3lSGocz7yNWqlSvll98WkUm+qv1ybiQk4cI5momdpJQplbErwDaGPT2krbMXJNWYIMX2SQz2DwCYmFdnzsnXq7aaBeL7I1hilSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dl+AHHWW7vo308KAudGv0my4BAeKWdFvisUdMKAx5oY=;
 b=yfy4WzsAY/hVHrDHxb4Xgo4ynmDfiUtf99Fci+8NxL/+EuJsKZfmAuBc4J0sgX5utEKbQkBfMsj2reE4vcyFgrr+i3oSpgCrzKn2U6NAyDxwsF7j0PzzZSxT0f/W/eDrelXlbL6t+GoGlprLYzzGsIvTjNlEM4t9EDHbjZjSwww=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12; Fri, 9 Aug
 2024 12:55:21 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%5]) with mapi id 15.20.7828.031; Fri, 9 Aug 2024
 12:55:20 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: "Joseph, Abin" <Abin.Joseph@amd.com>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "Simek, Michal" <michal.simek@amd.com>, "robh@kernel.org"
	<robh@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "u.kleine-koenig@pengutronix.de"
	<u.kleine-koenig@pengutronix.de>, "Katakam, Harini" <harini.katakam@amd.com>
CC: "git (AMD-Xilinx)" <git@amd.com>, "Joseph, Abin" <Abin.Joseph@amd.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] dmaengine: zynqmp_dma: Add support for AMD Versal
 Gen 2 DMA IP
Thread-Topic: [PATCH v2 2/2] dmaengine: zynqmp_dma: Add support for AMD Versal
 Gen 2 DMA IP
Thread-Index: AQHa6XniS27yBABMvUCRe8enndedBbIe4x0w
Date: Fri, 9 Aug 2024 12:55:20 +0000
Message-ID:
 <MN0PR12MB5953A0E2C79E6CE5B473AA94B7BA2@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20240808100024.317497-1-abin.joseph@amd.com>
 <20240808100024.317497-3-abin.joseph@amd.com>
In-Reply-To: <20240808100024.317497-3-abin.joseph@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|CY8PR12MB7562:EE_
x-ms-office365-filtering-correlation-id: 4f739706-ea32-4b5a-384d-08dcb87286cf
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dj1ok15YEkXl/J7kZC9cJ04CJ6CcnPsl3bp38YjzuzmRKw3DfBqbeYXD2xJK?=
 =?us-ascii?Q?06cnSIvqIWzzri5q2J1eDU3h3U58ziwGLpozs4APRqlAVdS8P8vsCDIIc8Af?=
 =?us-ascii?Q?/kRFwUopumGmXBrLgM/PMjGxc2yupTNiBYycbuV56XvKuvwHGIlmRNubFJ2R?=
 =?us-ascii?Q?Wn1r3qxBoiVYlp3Fv/a6k+UsjJ+9+uZGvMr1Xm/J/MuEUtU1ZT3xa05yhwo6?=
 =?us-ascii?Q?FpdnYgSb5fJEhaJJP7M9Kjt7jcjMJ4CKXwvN61T4nJyb9ic3w/pbeM0qZsIF?=
 =?us-ascii?Q?KTAPUbC15gG3haS2iiLTZAbE1pvIt3nZa1NeqN3P4IK/hcVy216Bjb2LAe5I?=
 =?us-ascii?Q?u0DBv07jtydad6HhNJe/Fha81LFYuqnaB5BHsogdPnbprbYjKV2HbEQP2xP3?=
 =?us-ascii?Q?agUvNRe+nBWfn/xshDqWDPwm+oWWtVVJg2BuvgC2Xfifr6iYdXD998f1PxGn?=
 =?us-ascii?Q?Vao5t0D9xTdI0+BVfxrG7DDEixchpRhb4hVEXNtnYguzeFs3QGYGvbTje782?=
 =?us-ascii?Q?EZvSSRetk+4Yz1gsON+2preyJEDj4J0szziXG5EeJxXaUKQdg3HqXH2n6RqY?=
 =?us-ascii?Q?W+C+eju3nNbG+IRQZvSbht0VD3/YXPCw+OrzFeC983TY9RRdAdsuqrVbZfaa?=
 =?us-ascii?Q?/Ggtc4daHWR7A/Tk2gzwYWo9OhjbOV0AwbNQHFHPrIe4YsIZHzEN07OD7xfe?=
 =?us-ascii?Q?cXc3WXLv5gi4TCivp2KanGjdN6CqrEnpjbbV+k2UxsYHFHQuqA4UZ5FFzC+t?=
 =?us-ascii?Q?d7M9Hs9vuvNqOQ68IwLOn694rklZLddL6WEyWJgtnQz8lN0Mq96R9ghkaO/+?=
 =?us-ascii?Q?SCm7+FUcqd7TgLQJEg9g+Hyul/O94N2s/SinigJ+k9u2l6r4VOPbIke1t1MG?=
 =?us-ascii?Q?G3Bt+j7LPZ/KVOTbFk0KJSwWVeKfifz4mPiVfEBCVrh55rEjOQqa8yi+clIw?=
 =?us-ascii?Q?fHK55lKZkMCGEcWHqtppFUW2IuZUnoh3WRMoQkR9wbM0c6Bvb6fARPGhmO9W?=
 =?us-ascii?Q?KJ2i9coOgg6FMnSDr7bqYX+tPKxeb1cRaKIg2gG2vVidwv1gjvZdzSm7wkLp?=
 =?us-ascii?Q?NUGu8IjZ+DwrqnOTdgTbqZYnG62+FdaMjk5wjb4soqc/XSRnTWXawdk3aCSU?=
 =?us-ascii?Q?xnpq90DgRzWFBJ7mqCct5YKLVaUscNTz2uMmy/9pf44ug9HP/AktZ2/FFHWm?=
 =?us-ascii?Q?F09PaBg4TqB5Vwz1c6fhfje/4d+AF0QEl6ce7vUyBlFiJ9aUaWve7Ky/qzg7?=
 =?us-ascii?Q?HOjsYWAZ+C6KZSSpElnJpPWTOsaGXj7Hf1bkmZuNubtjPvqn6R5Lu2m+e++i?=
 =?us-ascii?Q?MNRgkMUbiSqDnlIA6O0yEeiKRIgOfRMokS6qc/RTD/Rbkxvz4XDJyY53BfdI?=
 =?us-ascii?Q?BTQC5o0GTyJUVASXobxbUEgiHQRMqhbfXtp2tJp21SlFoNV2XASv/GztC2uD?=
 =?us-ascii?Q?exaFjYI+WCM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?juqn5lDhrPfhlPRVdSXcPRKhDMdHVocCLFogx9V9VYfP6eFYDX2KwhXYe6bq?=
 =?us-ascii?Q?RYnkGUShOUVO/AkTKI89DlFo5d9SNmMsTRS7WtwpPwoHumbOx3qKNW/cmI6M?=
 =?us-ascii?Q?U4zV//oBio060B5EF+eiPe9kdnAqppj6gnfNEiK5hPMC1KBAavqIXrox4WnQ?=
 =?us-ascii?Q?6R4GXXdRLeKOlCqF1BuvFmbRNOVxYEQDLQ+5nWYVqEK+aaeaTd/5SmqJvVcV?=
 =?us-ascii?Q?sW608FJD4gfJivWkbHjhec49vd42xAXybYerbqrFk7fS1Y4HzmtxUqYiOiYA?=
 =?us-ascii?Q?G2boPPdaOjJC2e1uGlgH/WiBD/5p4pIK1yzVhhaq9b1mcR5jj1VZ6GDnBu0b?=
 =?us-ascii?Q?FBinedlHOAlaFD656GpW3poyAw4J9maSADg5F1UiJGu/6ShJr3d5fR79F2G2?=
 =?us-ascii?Q?h6Fw7BvV6NN1NtgBbs87icl4z+ROqynoWrXjesiL2JOf7ghbnotfkp+0Aj90?=
 =?us-ascii?Q?+8cMr0ngNs4T21apuuLcCjOPaGianhRegbWPdIPGx07n3pD0m7v1Ajyir4Pw?=
 =?us-ascii?Q?2LOyCfqM0d9pGlgawIiFSdHL8WWSQL+GBO8wNh1sKq/231GxE5N96e9XAADt?=
 =?us-ascii?Q?5I8AfGzU9rCnK72+wyboyOoNqJiMhA1Dxs25XW301n4kLZK0nlPOAB95kgoT?=
 =?us-ascii?Q?UmJhJYLF0tJpi+Ocu8lvLKEVKAWxloFWhuTD0j4tV+U0jyPEvkePMsf+ZKue?=
 =?us-ascii?Q?2v7Nj1fIpVanvtfVxdA2b1shcdOL6MaO03BOnZ6qPOQwd9NYd0hoZJfiRSkF?=
 =?us-ascii?Q?7e/nPxsx/Yf79BI75mX8U/GrlgtKRWI2TU2BzV0Y9FgE3EWVkgWp0Uk2v8E7?=
 =?us-ascii?Q?sAXGcy9ayOsBXZyCKth1q6/hCoPO7i5kfsHJYxYdW2ermGVhBOlH0sMt7Izh?=
 =?us-ascii?Q?oKeAKDmxpbhfYumtKcHkGzv3GFpgTDRSYpsx29dtFgvPxnzMLHk6Gj5w6oO9?=
 =?us-ascii?Q?z7uq3afxgSndfF9GhjH9XmSwTfYDbC4IAODx8nYjmPvI/bSJMP07/5Qfk5fw?=
 =?us-ascii?Q?Y3Ico22wlL2+fXVoIS/yZTnfl9hAJBqvqlCn9UGnU6bW8MTjPlSn0RTdmSzS?=
 =?us-ascii?Q?yfR7xg/S4+VnDz6BtvIxMFGv8MhwtEY1y4RW4Ix76QLZc5Y27wyWYRj/3EWm?=
 =?us-ascii?Q?laSeP1HKYvP3iFCeof2pcosDDOvp5OtziMDHY69ZOxgyEuNwfMiSuTl2Qar7?=
 =?us-ascii?Q?LfS/Tsy9SklCcX5uux3ACzlMA5zVq4ynp5sr3LtO7m5LUFePuD4YgG/hYUEz?=
 =?us-ascii?Q?WHB/5CgiIx/QrYbeSfqFAmXC8T/6gz9ePedry0XnG/JvQTOcIlO4LIT0GKjH?=
 =?us-ascii?Q?LY3T0epa31qXvy0WkTSRlTTOv4yCRb2WK4ouzIa2hn8oyxwCrg+iQvWRNt+S?=
 =?us-ascii?Q?YVitIEpPmpEeZYuCVsL/9VVvw2/qS5KGWflWMHZdtF5n0+NQWrGr457bgIHf?=
 =?us-ascii?Q?BOup09m8dCYYa+T4QpCKDqla4ojZTWuUdWItBRjIQOD5KJV+/RXm6OUwE5lM?=
 =?us-ascii?Q?r2q94QoxznTt7NyN2OM9dchzfwZTYlJxF7d8pst0/84KvlKOyt154J3X+jd7?=
 =?us-ascii?Q?F/A/pGRurbJHN3VvATo=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f739706-ea32-4b5a-384d-08dcb87286cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 12:55:20.6645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hqjpAdHuiamSyh8i3+NsDZVXfLPmsFBa2iIklKckH//VEPCzs83Dh5D6fAlxVf+2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562

> -----Original Message-----
> From: Abin Joseph <abin.joseph@amd.com>
> Sent: Thursday, August 8, 2024 3:30 PM
> To: vkoul@kernel.org; Simek, Michal <michal.simek@amd.com>;
> robh@kernel.org; conor+dt@kernel.org; krzk+dt@kernel.org; u.kleine-
> koenig@pengutronix.de; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; Katakam, Harini
> <harini.katakam@amd.com>
> Cc: git (AMD-Xilinx) <git@amd.com>; Joseph, Abin
> <Abin.Joseph@amd.com>; dmaengine@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v2 2/2] dmaengine: zynqmp_dma: Add support for AMD
> Versal Gen 2 DMA IP
>=20
> ZynqMP DMA IP and AMD Versal Gen 2 DMA IP are similar but have different
> interrupt register offset. Create a dedicated compatible string to
> support Versal Gen 2 DMA IP with Irq register offset for interrupt
> Enable/Disable/Status/Mask functionality.
>=20
> Signed-off-by: Abin Joseph <abin.joseph@amd.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!
> ---
>=20
> Changes in v2:
> - Update the logic to use of_device_get_match_data
> instead of of_device_is_compatible.
> - Use lower case hexa decimal value for macros.
>=20
> ---
>  drivers/dma/xilinx/zynqmp_dma.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c
> b/drivers/dma/xilinx/zynqmp_dma.c
> index f31631bef961..9ae46f1198fe 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -22,10 +22,10 @@
>  #include "../dmaengine.h"
>=20
>  /* Register Offsets */
> -#define ZYNQMP_DMA_ISR			0x100
> -#define ZYNQMP_DMA_IMR			0x104
> -#define ZYNQMP_DMA_IER			0x108
> -#define ZYNQMP_DMA_IDS			0x10C
> +#define ZYNQMP_DMA_ISR			(chan->irq_offset + 0x100)
> +#define ZYNQMP_DMA_IMR			(chan->irq_offset + 0x104)
> +#define ZYNQMP_DMA_IER			(chan->irq_offset + 0x108)
> +#define ZYNQMP_DMA_IDS			(chan->irq_offset + 0x10c)
>  #define ZYNQMP_DMA_CTRL0		0x110
>  #define ZYNQMP_DMA_CTRL1		0x114
>  #define ZYNQMP_DMA_DATA_ATTR		0x120
> @@ -145,6 +145,9 @@
>  #define tx_to_desc(tx)		container_of(tx, struct
> zynqmp_dma_desc_sw, \
>  					     async_tx)
>=20
> +/* IRQ Register offset for Versal Gen 2 */
> +#define IRQ_REG_OFFSET			0x308
> +
>  /**
>   * struct zynqmp_dma_desc_ll - Hw linked list descriptor
>   * @addr: Buffer address
> @@ -211,6 +214,7 @@ struct zynqmp_dma_desc_sw {
>   * @bus_width: Bus width
>   * @src_burst_len: Source burst length
>   * @dst_burst_len: Dest burst length
> + * @irq_offset: Irq register offset
>   */
>  struct zynqmp_dma_chan {
>  	struct zynqmp_dma_device *zdev;
> @@ -235,6 +239,7 @@ struct zynqmp_dma_chan {
>  	u32 bus_width;
>  	u32 src_burst_len;
>  	u32 dst_burst_len;
> +	u32 irq_offset;
>  };
>=20
>  /**
> @@ -253,6 +258,14 @@ struct zynqmp_dma_device {
>  	struct clk *clk_apb;
>  };
>=20
> +struct zynqmp_dma_config {
> +	u32 offset;
> +};
> +
> +static const struct zynqmp_dma_config versal2_dma_config =3D {
> +	.offset =3D IRQ_REG_OFFSET,
> +};
> +
>  static inline void zynqmp_dma_writeq(struct zynqmp_dma_chan *chan, u32
> reg,
>  				     u64 value)
>  {
> @@ -892,6 +905,7 @@ static int zynqmp_dma_chan_probe(struct
> zynqmp_dma_device *zdev,
>  {
>  	struct zynqmp_dma_chan *chan;
>  	struct device_node *node =3D pdev->dev.of_node;
> +	const struct zynqmp_dma_config *match_data;
>  	int err;
>=20
>  	chan =3D devm_kzalloc(zdev->dev, sizeof(*chan), GFP_KERNEL);
> @@ -919,6 +933,10 @@ static int zynqmp_dma_chan_probe(struct
> zynqmp_dma_device *zdev,
>  		return -EINVAL;
>  	}
>=20
> +	match_data =3D of_device_get_match_data(&pdev->dev);
> +	if (match_data)
> +		chan->irq_offset =3D match_data->offset;
> +
>  	chan->is_dmacoherent =3D  of_property_read_bool(node, "dma-
> coherent");
>  	zdev->chan =3D chan;
>  	tasklet_setup(&chan->tasklet, zynqmp_dma_do_tasklet);
> @@ -1161,6 +1179,7 @@ static void zynqmp_dma_remove(struct
> platform_device *pdev)
>  }
>=20
>  static const struct of_device_id zynqmp_dma_of_match[] =3D {
> +	{ .compatible =3D "amd,versal2-dma-1.0", .data =3D &versal2_dma_config
> },
>  	{ .compatible =3D "xlnx,zynqmp-dma-1.0", },
>  	{}
>  };
> --
> 2.34.1


