Return-Path: <linux-kernel+bounces-409566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 737259C8EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028271F2101B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C151B0F18;
	Thu, 14 Nov 2024 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NRHkB1SR"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34579150997
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598610; cv=fail; b=Xfl1eMSjrbf3wRxS0Wh+amEpu+QEfjMiA+7npywXTIyovF562D72gCHvkt+VCFDk8aY04htaaqSenDB/61af4CwBzk0ttaLuG0jntg+YuQ8WxEbPJBgvbCEOTr0qQQhrxQ4pB3amIz67Scw5H6iGbnfJY3nMK2MgwX+siaSlDls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598610; c=relaxed/simple;
	bh=MQdd2hLYaM9RK3DYmhCiex6BvZtOkkYnqkmGBL9kZwc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YXbL1XUrdmUlnnUJJsIRFp5AHgz07ldSZ4VYRiT+kv4FL03HbyLS4zOlE571S7fFJXtiOcOQNIwwFPpe/ae8QM5w7YiualsInQh+K2IavWcKHM3Vz9K+la9AajThit8M2V+si76qz2POZbg+K+9TSs+tvlSY/AdGj7VoRDxkZYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NRHkB1SR; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igHSb0g24Y8EsC/YAf6gEYA6k8JBV0nYEQx4IrzT3jcxgkrphnkceUdeDa35VsjLm6oNXZHy526z6MQ1E1kqCB9GPYX+9BuQv8IZ0RzskRU4bpZsEQdto/gGfWOwcM2ECEMaMqUwEEN0Ta25fPOzNdUXWHOb3QuxkID3WKHB/fMKv3L5goJ1tnGACCTBd5kV7FSDtS9GaA70azfvUNcKeTMDozr8+/chNJz3M9nUVRhcU8aWWS8FshV5lvz4Hs2ESoRRnfCHG+7mBY+sg9MuQJR85c1fRD6/A6l2HRU3pYgA4vGt7PzZu+06MJKoCj1QnA+P/IeaVZwK4OnQTfoVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZuqyIZyp1WCV1GJxogYLqqo4Wlgqgq4bYoR60NLBgo=;
 b=fG9IMidPY6u1Wjoi2MSwmzZETYEJv2OmUPz1g+KLJ2iKNQn0Gx8AqrXrnCqPj9wZwsD0PK0Na66GZZqe8H3eRNhqWIKJ1Rh2hyY+pkbh0ZxCL/Mf/IeJusT4HcWTlHmZ5tf7zfPFStVzkI6d0Statacfw2VM0pQtStFTATAO4OCEacrJHlP7JZmDhSeR1Z5MliUrPmXOhSoekFnPvuUyo3/gDfvgulft1exPYFgXXqDxzeoRtUoDKvFbPCQnd23du/fIpzMnfK5dkFkGuBJXW5aGO8XgYKsKRthHiEbaxmMEY1NFOh0zcImvHYZIaUw+KXHoQprdRemcc6GpWlXjDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZuqyIZyp1WCV1GJxogYLqqo4Wlgqgq4bYoR60NLBgo=;
 b=NRHkB1SRi1Tb+C3P2XUZPxEHW99TzEPXatbGwKG+Ly5H9CYUc24nWzq7SOyi2ZK1VJkbPDzKbQf5/KcB/hdDRkxJ5vSNqkdGYP5vwHsnT3vkZT7PfUxHGVSCORd2CXXnnqTae800ZokL2Yw5LrLAiv/e5k99LXgQ0r9NDe8Opq0=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by SA1PR12MB6869.namprd12.prod.outlook.com (2603:10b6:806:25d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 15:36:44 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%6]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 15:36:44 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 11/35] x86/bugs: Restructure spectre_v1 mitigation
Thread-Topic: [PATCH v2 11/35] x86/bugs: Restructure spectre_v1 mitigation
Thread-Index: AQHbNmJz5HBORjzra0GiYVanrEde3LK26Ebw
Date: Thu, 14 Nov 2024 15:36:44 +0000
Message-ID:
 <LV3PR12MB9265747DB95F1F54E826A971945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-12-david.kaplan@amd.com>
 <20241114064001.v6ogsiaptrh6oixc@desk>
In-Reply-To: <20241114064001.v6ogsiaptrh6oixc@desk>
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
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|SA1PR12MB6869:EE_
x-ms-office365-filtering-correlation-id: 4ba7b182-023f-4526-6ed4-08dd04c224fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5AqX/MSnzhk97Q09ICFQ0zgAisSXaGnp3ASZ27F90uh6gwaqDLVizF78YJYi?=
 =?us-ascii?Q?lZ39lugZZ7PzK1v1RJvd1N2CROLPnfEMQK7La8EJJi6Up5LPM2BVuHiGraln?=
 =?us-ascii?Q?e+j3l6A4pGyndTd67EtuxSG5hfpvI+OYRTvsjI7agoDodHnJIgKavQNUaOpX?=
 =?us-ascii?Q?rhyvSTz9p+QT0g2uxEuVuqZ8PblN3RKk/wpETIuXxTbFnSL1ntJnGHbJ0qRa?=
 =?us-ascii?Q?1I3xYIjqbV37zrg18FfGDNhP86/DmekYSfFZRdbKY919CmDOS1eUdz7e3o//?=
 =?us-ascii?Q?4PuVdEzp9WVymHNr06I3R4MUAMe/SX8sVOOBmBfoUCsOJFldKZFoFv56Vb+e?=
 =?us-ascii?Q?PamfEIulUEr4DdQeasj5Gp56VQoNb/GBCcl1g/UEqpbS6eAx2DmWz0iBQqY7?=
 =?us-ascii?Q?TKwbKLW6lT4CPRowY1hBAFfxMW3EexLYAPO2/ubkwqJuc85UGh0HIi6weW8i?=
 =?us-ascii?Q?q9o3h7pS0WgMTQvvLTQ1nm13sCCP0KtWsCRGWQKmkvUS/3AcCbGk9rOhgrCL?=
 =?us-ascii?Q?4VanCmNvSi5cuyahVHHdJgn0LEBS1WylbPFPu3gqDRPGBfHFbqOcxW9DOXmj?=
 =?us-ascii?Q?MuRP/4DpuiPAjZafj2KnmheeTOiyeJrfVWrOXeNa+Y1HJPOrmG6qQWnsX7Du?=
 =?us-ascii?Q?LWHpxg4s6pSMSaeGrwkcs4sMqmXF16f1N7JylAOQsFLrSjFMgiyoJ4VunjAF?=
 =?us-ascii?Q?gn8HqTtv2Ps+ffD3dK+17rlWL8u9ZEf2CiPAsrbxeZatYyn6OxXnJIZQmy9M?=
 =?us-ascii?Q?xsV8RXp6g+3STt7qrxFZ6QCfQ44P6TPFbDpHXrnKHoXUdiX6Fy1/Btl66Xxn?=
 =?us-ascii?Q?bwm0JNDZ6xiboHvcJN1gGExCJ8b0uYY1bcsm0K4oQnAdpX5n/1alute8Pgav?=
 =?us-ascii?Q?jn03jSEwblQJd1qnkhsikQpN6sgyC+fyFDxEpLq7iLGtq+9bEnU6Uq5Qym8s?=
 =?us-ascii?Q?pSd8PGccLBtiweyBQaEk2fI4K0L+i8QF0CqqRvwbudVeMST3dpne8SqtmGRr?=
 =?us-ascii?Q?r7r5PbnHE6fzmU8bXHUjlLRUje/sQ2Am6eXBwpUbZHMnZvngECC3rB+XsfT1?=
 =?us-ascii?Q?qP7Gd+lwCugUwL0s2RmYmubMbr+VgVZBn4bIaKPNVJGHaRvP0IjdRri7Q6Jj?=
 =?us-ascii?Q?u1hIrr9j8boCHCNfUtq7QJ9kyAXAA7cTgVJXUUPBt9rc8l6JrFNM7FzXsRTd?=
 =?us-ascii?Q?SaRpbjywARQq4aayhtLLR8/zQWMLocpgGhnNwhyDA4J2jHDfXKKIjKF3UzKI?=
 =?us-ascii?Q?NBNQOmA0/MMYDcPSICyjiHlNeCCc9vLKwzWN3uzwSi6YUFuE1aJkKeDW8vUH?=
 =?us-ascii?Q?f54gwETa80jMWbwUm9uaKwUsM9LHGVnzHk71y5i9z15993RnbcsTmlUfgVyn?=
 =?us-ascii?Q?1eiuDrU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ht0eQZSKmrQWdyroXFBxR4iW7y1usQjiyUn1vI5ubbs/3d71ji/EJnNrQ1yE?=
 =?us-ascii?Q?6ArAL2hLOS12XAr51pxALTj5f21/j89GkuboRnB24iJXVD1OQaKKYbKbF8Xc?=
 =?us-ascii?Q?eYWcbBIgshg5mdsVSgTbsA9pr5BIay/5uIv5GXhsSHSiN29h722rSq8QMxAg?=
 =?us-ascii?Q?PgGB+mO2pT4GU75mDFoo84OKg/gdshh+xNf996tyjK87Gm0ou3Si1ikLAvI8?=
 =?us-ascii?Q?QXUJCZ9woQANs7UwMBwICT8Bxjzfvy9lEgXUXTcDivE3dO+lfs759cc/l1Qi?=
 =?us-ascii?Q?l2mz1E7/rDs7FtTERiZr9AjDykDfKXUKCszcEVTDS2W5Bo+7q3vbuC/mrBI2?=
 =?us-ascii?Q?mCKWn+xG77PSRxU9lynkbi9rcqMNcjQRI+2UyWgU1x06Luton7noVfEDH4o5?=
 =?us-ascii?Q?zdH2hrDprwWLDzVb6YJwSt0l9nWPQ326oKGKBJDAVOamfrseQkawfrZ8tX12?=
 =?us-ascii?Q?Wku164Db03VenOAEVRm9m0sT/1zMTBHyj+7lmX68BWhnzmjyWqvtMlEe8+uP?=
 =?us-ascii?Q?5ybJJC8jhtGFJ6tMjA1hEmsUgYuoMksN19Nz+c44hkSGVSa9e/kk946Y7tnm?=
 =?us-ascii?Q?/YRCE5M1XlLRg6uRaoAZxFE+zlwzXUpA2g+TB3u+snSYttwzYToJeX78sD1C?=
 =?us-ascii?Q?v19De8Ki/mHQqfBQ1CcSZcHc7RGyH9lLsdV2AnYV5Bs6ukvQcW4RgHSMTjTB?=
 =?us-ascii?Q?7YNWH6wv+af7+0RlYYL5XNBjxL3Zt2gtAT078kGqvAM/ShCbvNJ4k5ONcWFI?=
 =?us-ascii?Q?vWkV0OqCa1COcWHMSiW/245yMsWLIEmCITmwj2Nr6FIAZsWN+/vTQErQieaJ?=
 =?us-ascii?Q?/JYoOVxfeuoKeejeZMKb4quHhL+uhyasVHNsE2ccJYlbLbL9CKnjulITh2QI?=
 =?us-ascii?Q?GRpvyzGQB9oUOZFRMG1Gqtx9c4Hph2VnWjSLT8dJ1V5oISMO7Gv14U7jREk+?=
 =?us-ascii?Q?gPruU2mYc2BMBj3F2q2kRt/1h3FaKe5KVcW4pPsmY6EVZuSfDTnhL8748b+s?=
 =?us-ascii?Q?kSFE34fYtnQ6SrGS9Fiv4etnnmsrwfMkdzWarJ9s35YArwxZrB44x5+2A6VU?=
 =?us-ascii?Q?4M0poMqdK6mYdp/Zg8czOh2EuWuu8eBWWdGLuZ+1kqzCrZ+FswSEzIUgYFCx?=
 =?us-ascii?Q?yw/4y7QmrQvwEz891i44eBDl67tXjG4qmHVkzTmqiQjgTZcaP9OfnjCKVl2E?=
 =?us-ascii?Q?wpXemKJQiua2GrNNLa+Od/1g81KIRUBQcHQ4lMTGtr28yBihYIpGQiDnA6ym?=
 =?us-ascii?Q?Khv/Fv10UuNnXPhortIsAoTTBNw0HGWEVlWUsDnJWklwCXHhSUVvd9H+wzsh?=
 =?us-ascii?Q?D5FgOX3pkKLKWgmOzQhUxuXRCvT3+jwZ8+8bcPmpFf/w3AhJiRxQgklh673E?=
 =?us-ascii?Q?D+8tX7O9PtTa8AWr0VVeaWOJ6w4a80VVRgL0f/UlX1TX+WTDvhVnpuR68Bsf?=
 =?us-ascii?Q?kl80O8UWSacHdW9itAMXlAwqjddVwaMGfz9t/NftEE8etrmWWL5Waa0r4Y1o?=
 =?us-ascii?Q?CxaHM9OBdtF+GV1PWZ5IuybpPzt1YQX5AK1i3lvbJbAtLnB3t7v2KQCfrmN3?=
 =?us-ascii?Q?ARo6xWXteiky9J27Tqw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba7b182-023f-4526-6ed4-08dd04c224fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 15:36:44.7262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFi3Fm6O5NWwWgc5OKoykIfS+zTt0+1MrYfTBVGwqO+qfYlBHLfNHLES+GIjDPkQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6869

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Sent: Thursday, November 14, 2024 12:57 AM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>;=
 Peter
> Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; In=
go
> Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> x86@kernel.org; H . Peter Anvin <hpa@zytor.com>; linux-kernel@vger.kernel=
.org
> Subject: Re: [PATCH v2 11/35] x86/bugs: Restructure spectre_v1 mitigation
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Tue, Nov 05, 2024 at 03:54:31PM -0600, David Kaplan wrote:
> >  static void __init spectre_v1_select_mitigation(void)
> >  {
> > -     if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off(=
)) {
> > +     if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) ||
> > + cpu_mitigations_off())
> >               spectre_v1_mitigation =3D SPECTRE_V1_MITIGATION_NONE;
> > +}
> > +
> > +static void __init spectre_v1_apply_mitigation(void) {
> > +     if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) ||
> > +cpu_mitigations_off())
>
> We probably don't need to repeat this check, is this okay:
>
>         if (spectre_v1_mitigation =3D=3D SPECTRE_V1_MITIGATION_NONE)
> >               return;
> > -     }
> >
> >       if (spectre_v1_mitigation =3D=3D SPECTRE_V1_MITIGATION_AUTO) {

I don't think so.  That would stop us from printing the message about the s=
ystem being vulnerable at the end of the function.

We should only not print the message I believe if the CPU is actually not v=
ulnerable or mitigations are globally disabled.  Although now I realize my =
patches may not be suppressing the print statements always if cpu_mitigatio=
ns_off(), so I need to go and fix that.

--David Kaplan

