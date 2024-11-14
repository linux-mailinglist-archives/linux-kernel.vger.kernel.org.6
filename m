Return-Path: <linux-kernel+bounces-409588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BAA9C8ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA0D1F228EA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A763315B0EF;
	Thu, 14 Nov 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KO8H6hOb"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB4374C4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599388; cv=fail; b=uN8g1iKZxCogKgER7rKK1BuAjNURR+Jf65Ut+eYHIrQn6sgJXz80EuY6XuQEwID3DSyUFd6695IxRvP5tBpU8POfWQKfT6WoD/2x6QJgXL7qDbbUXPcoU4s7NKFtnX5Yxiho9PYy0U3TbgbYJkwDIlik6hULHkYgYbpc9IqSsGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599388; c=relaxed/simple;
	bh=0oAwX+MUsUaPL3aJ1RsU3/WNHVJT1s2AQ5PzyC8/SmE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aJcrosRAGxkwHusZFsRTBenOX37k7SzCXYMPvKWnjLhqgXLVXWEVi64nTbPwm7S4EO1xPMROJnISfDD4Ja0bceOUK/4mj2xQ4vfxJo1ZThwi37HwovOshkF0l6ZdTRmd5g02Nn/qukPeAArszaySqoazCDwxwq8Bd4yCheK37qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KO8H6hOb; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5y2gB659gPK5Vwluxh6v3UXSpxUv5Q3/uUZETKXy3O7Z2p20Ksn6xF8eMJpMN9+8cZ21/uLMQ5H2r0ylTPnILgYMTRoYA+SfYF24qbUHqADNQWTaAQ6qtSzekWVgoOEABpeo27NTQmp8xNLnM+sClKxG4S7xHfXbk2935FjpnxaW6/QtzI5sfA6GKClG0ThxXI3FDuimD9fDVqNZjuHR6K1fhbi1kGFvUnt89DB2lQD4eFJ1FMrJYnfWxW+jUBW6B21et9w1cYBr42avzfB6zbYWtN7dVc5uWtjjeDa3ZHmlkQiEok0hl0PaS+XR+gH2Xms5MQeDsZ3jfR6jQoliw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sTeUHgx2iwNwsC1i6sSqNX5+F4eOW6ZoU9HrTnqSzU=;
 b=am8l8YjotQmTzmWVQatTRABou3mDbOwr/edlS8Aj2wJhcNZIq8CN1KdW/20+/4wublKWJZyoYx6yz/Hrh8LOStLoAIVFOkMSTAPKgx4lBLCV+fGKvrqvdCjtJk5+iOPVFxm187yQAvDAyNOzrQM2WXUWJCJb5Ww0GdZa/LIckR2YyocgL56+G7pYZ8GFy5UJtqn2E1iwuquprvmFpzFvouD+Z0IRsIpZ2yT0U1NoY/Gw3A2D32GHWceTSjPdKFdHZ+stbeizSLq2xBpeuRo8HbFOME56DvLjnmUSQiBhKjyZJIIt2C2yotESpEqNK1buynHKFBvzmi7XwtEhyMo1lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sTeUHgx2iwNwsC1i6sSqNX5+F4eOW6ZoU9HrTnqSzU=;
 b=KO8H6hObkNBJcMos5G7YEWzhf0K6NdR/VmXCHmaUeyU44NQKuPC+899He6OObXk0udmwL6+KiIXGgrt1YFNlJLgwkHaHWYXXBKcTLffnIVadmrCYhpM6u+IVuVjKHgpbvlxy1iZCiqW1mK811lxw+HiWNXWlx10iLiLkZsBqA3U=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by MW4PR12MB5604.namprd12.prod.outlook.com (2603:10b6:303:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 15:49:42 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%6]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 15:49:42 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 11/35] x86/bugs: Restructure spectre_v1 mitigation
Thread-Topic: [PATCH v2 11/35] x86/bugs: Restructure spectre_v1 mitigation
Thread-Index: AQHbNmJz5HBORjzra0GiYVanrEde3LK26EbwgAADgeA=
Date: Thu, 14 Nov 2024 15:49:42 +0000
Message-ID:
 <LV3PR12MB92654B44C7BDB16BA140D342945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-12-david.kaplan@amd.com>
 <20241114064001.v6ogsiaptrh6oixc@desk>
 <LV3PR12MB9265747DB95F1F54E826A971945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
In-Reply-To:
 <LV3PR12MB9265747DB95F1F54E826A971945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f3aef4bf-6562-4aeb-b164-e441d0a6e32f;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-14T15:33:15Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|MW4PR12MB5604:EE_
x-ms-office365-filtering-correlation-id: 6102635f-b75d-44a1-afab-08dd04c3f481
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yNqcKUIsvdOuza8eQ3h5kT5vnDlaBUCsXFdognwZX9q/yVN7KaYWxy4AoXDn?=
 =?us-ascii?Q?KufZ2uvAbUwDFSSYI71W4WUxjBJ+n9RAWIM5y4AxXgWl8Fm4cMiNTciUgFu1?=
 =?us-ascii?Q?m3oPwLVmAIfjGcEAxqQ+W6iE2uO2R2XyhJkKZgkUtg+rczoI0edZMCIihw52?=
 =?us-ascii?Q?GX05TQzNEyCu5YJNvLO11dhr5wSCiTqNifsqwF1Q6xna1On3YVdDYuPa1q9f?=
 =?us-ascii?Q?i1TXT1htGbzpfg1EsY/nA8y7qYpMR1Q89zCV1mUqCrQgpwaw5phPYaT5jc+5?=
 =?us-ascii?Q?g12u7inXaUUudT+iuKTbUA9WD3DNYb4N+QNZAjGbH11DbkctJ8p9mIC2rQpw?=
 =?us-ascii?Q?OnX0ujipFp20KgjBHYJpt9gT29+C+W+d8FFwuwku+nDrUsfnBwdRrlYd7ynp?=
 =?us-ascii?Q?d75iLM6wP+hoVi5YaHW68qfdj/afHyRwvlgB35zyZpmUXBnqqWNA4a1S4bod?=
 =?us-ascii?Q?IhNED+DxXMfeH3496IpUNG4QeR7aW75sOtVYHKjM16tzHTyvaQ6ftIWop1wB?=
 =?us-ascii?Q?+3wR9LH1FcEeQAZJXcBt6lFjVADeMj2kAT2uxh6W3r6We+X71zo0eZ2bDHki?=
 =?us-ascii?Q?Wjn4Xr03m7/N9styL5J5zwrQS54h8YwPQ9WaLeUyFYZ0hN3F/EpvHhAHFnYK?=
 =?us-ascii?Q?q2IKeGEroVFgisjPNxJMLFwbbX/1/p1DYISdREdsYsmPVq163kfKIXoD0x7D?=
 =?us-ascii?Q?ZNE3JeaUM2r2jNnU21KdaMOolB/nZa8H6SuGRz+NPhcchjMOAJ0Qa8Bg3Uk3?=
 =?us-ascii?Q?xljAFTDsr8Q53vower+d8uTIABjBfgQ/ixpQ3tk1JYpPP7+WAHjVIDkiYsb3?=
 =?us-ascii?Q?hMEPJOcDjuYX+354xZPrg2AP6zPWAZCYkYsRGvsODq60FMcKbA5IjXLU2BkY?=
 =?us-ascii?Q?XAGPCKKY2vEAjeTwR0FVPYieDiYwP+E1SBaOLODncRz5qJIE7O3/Kf8m7M2W?=
 =?us-ascii?Q?CzpmDuz2NNLcvBCs9EX1VREKwvzRZV1tuMDzmfnXv6k29aH/ue4qzqRQrWjJ?=
 =?us-ascii?Q?ePNXAjGEJxFHIdRMKUVxsUmfHiv7QBcy1YH4Qh1640+Et6MQPl+h4X7vZB/k?=
 =?us-ascii?Q?/KN3BFc7S086PTwMOxLyh9gnk4AVqHs58Jn0UheOXMFOO+Iepy+3IKDovRjl?=
 =?us-ascii?Q?eLNbUx7AGjN+8+jCjJcN5DR+YMxjTRJfqNlUZTbiqwmN7owisa0uXj03/QPQ?=
 =?us-ascii?Q?UbDPif/B6Ue5jGk6x5pq9nmkZThBSpGgYg02qVH6ZFajY6Gpa1Ys0KvNysAp?=
 =?us-ascii?Q?TvwjlQxaVgoltse/eoEINsOVuqDnAp9Y78DE9eMCeWS5H1r28jgLX1RKlx28?=
 =?us-ascii?Q?C7OTAbxC441UZ7qFDPY5k78eZN5pB74g4KBtMJ6HBKS+qsYCHoHWeNhkyhJT?=
 =?us-ascii?Q?HIGRl+M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VrVVHMSoUCJzJ0Qf0D2oxchGnYl/6UAe4A75+6cznZEruds4Vp1reBgd6b0b?=
 =?us-ascii?Q?91FHTZ9TjNvyCkULJQRtJaZjJhgH1AwK97wV1P2ht7wCdPJokat2D4Ljx2x7?=
 =?us-ascii?Q?F6I1okm6St/jEabrnhV7t5Tjf5Zivs9yM3SyOxog0lZaRFfpt8ZuN6krPG8S?=
 =?us-ascii?Q?o+a568ln1z1m3Rah74YY1BFCkSjoHtp3mbeRG8lMSG32mr5V0lxYTHSh9o0j?=
 =?us-ascii?Q?otpOj2mRjht7rvkYde0tg2BxYqYBpj6y4mvuo/975YIWnZdYGJQZn2yVp3rc?=
 =?us-ascii?Q?Oa7ocfVkSXw9pG3aG+BAJL/PxEWArQpgCgG38jCLxLQuub2XVJICBYiLmZfJ?=
 =?us-ascii?Q?tBwjPBY65l2kEIfaOfGwtyjEbpO98IGQVdrX0V/bQvOm4ZDvumpJVZXsMnHc?=
 =?us-ascii?Q?4SIf8ZEMMZEY/8UvqBXr1Z5UkWTca7bQxfb3Lpv3tR39lF7Isa040JJul9Ui?=
 =?us-ascii?Q?SPVDX9uO8VdzxtGsHgixt3kMx7I4XMO89ahLK0k+8Z63EQrmb/7Twx8IWrVP?=
 =?us-ascii?Q?hQrQtg4m790hE9aKwA1wuqX7BCVq6NjpzcWArOyrS87YqzFYCU0yq7fKScsz?=
 =?us-ascii?Q?CSYLMAsGmKnF4RnDvgXfAGXhvcg6pwc1da/ItIoZOdo+p5sBUv/4Rn1xaH6a?=
 =?us-ascii?Q?mdL0Mh7jaPasoFbklYR7INH7aoWTL/xD9/mOIFRgVMFxpH+SLsjf/m4yWOlX?=
 =?us-ascii?Q?iPnoy1pOxoe/gXSNdDmgJqU7wBNSmitJ88M1Q4AUgpeXAo0u0AcKz7weo2a/?=
 =?us-ascii?Q?2lZU0WKeWHW9tCB5zLqPjNB+ePytWcdegyR4GKsocZ5ZbSoypfo1mgGikUvi?=
 =?us-ascii?Q?RNxYhRNy7jJ84i28FpVfVR+yb6wiajp9kJoLoSl+FfjfGeVW5VeMvKJPvbz1?=
 =?us-ascii?Q?noXYrOZByau9U7iwaCZjP1WZQ+6aV9K5zIwe7At7SUCo2eUAtGZYWY3ha7A9?=
 =?us-ascii?Q?W1d68yyX8H/ILkVfZUDFvBo/bCkgwyVmE8RvHOiWsSxBBQLkZ9yqyyQr/rxF?=
 =?us-ascii?Q?v90gdD2doo5IQhLUiIXlnetKd+Q4I8k04J8HZFE/r1+kyA/zeO1FRQ6xQyLL?=
 =?us-ascii?Q?w8pnXsjnaTVvRynekV5jMbfiUUQ3SDQwX8wt+em7S9myLcTHxyB1Afdr0l/m?=
 =?us-ascii?Q?hEdH4y5gmvPn77V7xUSgJHTVQ0rnkGQeWMyAhRRPKyW1Jg61EfYdp2Q1JoaL?=
 =?us-ascii?Q?Op4K0/IXvpXMs8efwPdCha4VobQPb04jpVzRK3BQZgIfOqaXIUCVilxaadYW?=
 =?us-ascii?Q?sq20aXfKPfy7zW8oCqnPQB2pnTrpXydbJc7vdM8acglKXoepbq57mloTxpfq?=
 =?us-ascii?Q?GBSKanj5BL9hNCMZUNTXUUFBHSlXqGOJNMGB38I/Ofn4yrNk02369dq4/e9q?=
 =?us-ascii?Q?BF0jXaMlpAG2dGDi1KclVOgBHWy9pqNc4LqKXg1LND0ZuYttBcDBob9c1xe6?=
 =?us-ascii?Q?roNZTnbR4h6ujj6TZILjYTgIeoqgNOtxWvgmGen426AHEa19zCJ4b6p/On+p?=
 =?us-ascii?Q?Iob2rZDoh8ak4gylt+8AzSNDJa1uqSmyCQfZAH9P2h2pA8gUnCy1dBslplGp?=
 =?us-ascii?Q?gNPtTnt1oLQc7sXx5Pk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6102635f-b75d-44a1-afab-08dd04c3f481
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 15:49:42.3476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5W/x3Uei8w55L5QF4AQz4dfoi2qHGNG3Pl7tg3vhYsA9EKuKxKjls6QrX+iCT+dX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5604

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Kaplan, David
> Sent: Thursday, November 14, 2024 9:37 AM
> To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>;=
 Peter
> Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; In=
go
> Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> x86@kernel.org; H . Peter Anvin <hpa@zytor.com>; linux-kernel@vger.kernel=
.org
> Subject: RE: [PATCH v2 11/35] x86/bugs: Restructure spectre_v1 mitigation
>
>
>
> > -----Original Message-----
> > From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > Sent: Thursday, November 14, 2024 12:57 AM
> > To: Kaplan, David <David.Kaplan@amd.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov
> > <bp@alien8.de>; Peter Zijlstra <peterz@infradead.org>; Josh Poimboeuf
> > <jpoimboe@kernel.org>; Ingo Molnar <mingo@redhat.com>; Dave Hansen
> > <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvin
> > <hpa@zytor.com>; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2 11/35] x86/bugs: Restructure spectre_v1
> > mitigation
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > On Tue, Nov 05, 2024 at 03:54:31PM -0600, David Kaplan wrote:
> > >  static void __init spectre_v1_select_mitigation(void)
> > >  {
> > > -     if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_of=
f()) {
> > > +     if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) ||
> > > + cpu_mitigations_off())
> > >               spectre_v1_mitigation =3D SPECTRE_V1_MITIGATION_NONE;
> > > +}
> > > +
> > > +static void __init spectre_v1_apply_mitigation(void) {
> > > +     if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) ||
> > > +cpu_mitigations_off())
> >
> > We probably don't need to repeat this check, is this okay:
> >
> >         if (spectre_v1_mitigation =3D=3D SPECTRE_V1_MITIGATION_NONE)
> > >               return;
> > > -     }
> > >
> > >       if (spectre_v1_mitigation =3D=3D SPECTRE_V1_MITIGATION_AUTO) {
>
> I don't think so.  That would stop us from printing the message about the=
 system
> being vulnerable at the end of the function.
>
> We should only not print the message I believe if the CPU is actually not=
 vulnerable
> or mitigations are globally disabled.  Although now I realize my patches =
may not be
> suppressing the print statements always if cpu_mitigations_off(), so I ne=
ed to go
> and fix that.
>

Actually looks like the existing code wasn't always consistent here.  For s=
rbds, ssb, and gds, it would still print a message about the system being v=
ulnerable even if mitigations=3Doff was passed.  But for the others it woul=
d not print a message.  I think I'm going to suppress the message for all c=
ases, but if people feel it should be the other way, let me know.

--David Kaplan

