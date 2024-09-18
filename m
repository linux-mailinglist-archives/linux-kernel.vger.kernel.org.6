Return-Path: <linux-kernel+bounces-332300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E08ED97B7F5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49882B23CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 06:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACCD158521;
	Wed, 18 Sep 2024 06:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rGvo0yZa"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB44339A0
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 06:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726640985; cv=fail; b=qLlLvmA8wseGY0x05xWTlnCZeCevTO1DDA+MZr1jWjkOwTWu/kF6yObehSdMBrDcsm8DONHjCYZFUng5xK9G4O8iSFcLF8zDzMuBLXGMVbzYoRBB08M4VIZq06X3h/VSJMLg9SXgCBg8Ht8Ix6YBfPevfgsoAX10tWg0Ew9HdZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726640985; c=relaxed/simple;
	bh=8gCNxJCqkYG6G5uPoDqw1+gSkL7wuLVDRog5H8/mTIw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CLCTcou8IgwVDCv9Kmq0aU+I7CjpWquqjiPKF+pa4mj+zYabKI0RYuIiBjKkK7VZcKrNJISuL/Mudo/qb2D+P9mb7cGoBWFSauNV7fL4LcndYw625QMEkNlTEJ91x7Ov+3IezvFBlg55zMU6uVpWRVqkBmiDNhLR9E8avY++8U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rGvo0yZa; arc=fail smtp.client-ip=40.107.100.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZkwgSXavOW5u4degm7htsk1yV3Ujf6oitcIRF2V/lHS6bAcG28uDRa3o4DwpnL4I6PrPiqZOejdVFAdrnKLQc6cXbk/jjJ2daziiVpPvsuk0sevtFrDKvsBdtYPCpetdcfxXANYeU8/uxWmMlwohPpaZr9coYtOOYwzQZzpzUMda3TaAndQYaMU2BMmYeIfAA6x3nCDtsE3saFg7oEtj/eLI7MHI390NYt35zzk4YCPGkILUtxV2nU94xRGbYEpV8H8nZJia3GlOYcGRwGshbJ7oQ4zFwDC9M0l/UlmpIZ4QN5G1Zoooj5OMbjOgd6tpSY0zppjbm2EyW6x85hwpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKM7/yza5t+okBIwV4nfu2scimeo3zjrGu4rwGoaRCE=;
 b=H0Z4HHMK4tuUtHAERByhzufA9MxcHjkRkftQtv+vIJtrX+ZGe7PNB7X6FRsZ8+BGo1k8hZZjVMrLYDdTlwIkNDlApoxR0E7Khv/xbs39Me73Nnz3SFVds6y1faO5CAyQ7NvcvOgUbq/p/5jYmbmRMNx/60VTNF5lpwa1i00rZdNT/YxTZH/CN4VN2MrZbNna/xORCorlvf4+Vs5OMMQqHFPthqtm3DesLj6N/tQkOrWhl+4dCsOKjLcr+9sdtRzPlhiO0T0n4l+pcJ76CQN3cE8E2U38EEBkpqFqbRtS9i1eP5IL0QQeWiFsCE9Vah56PE0o9/HDNRMREBFq/YAp0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKM7/yza5t+okBIwV4nfu2scimeo3zjrGu4rwGoaRCE=;
 b=rGvo0yZarF8WFA6U4vUBcuJzSF/N5VOJQ7XgKnDdJjmq4F2goDOyo/M6WH44BVpMsxk+fmENqTXAxwE6F0GVXfjQKGrZHIYqDLogCG7I0+f+64gMOGbZ9dBuYIi+V5nsk/gp5zDkG0MImOyVyjIxa8Dv6dCqBxb8Qy+vtWdVBlU=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 06:29:40 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 06:29:40 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 00/34] x86/bugs: Attack vector controls
Thread-Topic: [RFC PATCH 00/34] x86/bugs: Attack vector controls
Thread-Index: AQHbCSOmwKg/+Wj/C0651mYFrI2bkrJdEo6w
Date: Wed, 18 Sep 2024 06:29:40 +0000
Message-ID:
 <LV3PR12MB92653FD0D712D0FF24BBE49D94622@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20240912190857.235849-1-david.kaplan@amd.com>
 <20240917170407.jxtpb75iru3qg74c@desk>
In-Reply-To: <20240917170407.jxtpb75iru3qg74c@desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=89104206-7a04-4a53-9c8e-50b84e52cafc;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-18T06:17:19Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|SA1PR12MB7038:EE_
x-ms-office365-filtering-correlation-id: ffae8c81-8374-4904-d295-08dcd7ab4686
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?V0pTdjEFPeGC/Mxf70MI0Q6xNx30glALNdeFPWHjNXNN2Peg5+egRZOo4QQY?=
 =?us-ascii?Q?A/2KcsTh1RBNmGXvL+PRgHSysEP9VIRt6hEEh4FaSxtIfINSN1WTPKfHsjo2?=
 =?us-ascii?Q?im8pd2wbGn2Ydtx7YMi97OAHrJm8j+XtVARDnQcYOPKuy55VPBSq9+s3qqVk?=
 =?us-ascii?Q?pCjrmyPCeaCGDzfR/9fmTXOyDCK5bryGkWQDP67IwkTEtWV94tb1nQ7prUqp?=
 =?us-ascii?Q?RTGhEquOPpc+ZNRn2ZpYS8eJW63xWuUWHUK+ywYJAvYKWaoI0EbMgVlXbVC5?=
 =?us-ascii?Q?brc9IoaecTlsnOZy4X/DFI5uQF8vkLvpUAX8uBI4av5Cvw9U8UwkXP1Rqp0W?=
 =?us-ascii?Q?kq/cf+JOxhfFKE1zgjt6stIvszEhIrtyQ84pDKIzoDmoM8XRzmVgeiyFlcfu?=
 =?us-ascii?Q?MFkHkakcvuXHoQOesfQFLJLLxj2EpA5V+zavDv/ONG1YJKDEGUzRGBdboi+v?=
 =?us-ascii?Q?ldo4NmCFleMyeJ78QXc8vcK4hcxhxJM+XU+Bt++JQkY9lRNzQH0shTf2NmWe?=
 =?us-ascii?Q?KTuRcov2n1kplG9yA2nZEYVoYApLO8rKRjKfkJT+uA29EfeHVzSJwgnPsIVa?=
 =?us-ascii?Q?y8mfItFTu7JGUjpT9LPyUy94/JmXLIYMtWn5lkkrzhKfB8jh6JEkmzDvVn+I?=
 =?us-ascii?Q?VqRIEPDhhzHRcJD+LetP3lwRwOgqLifmJeT6EtDUmPYMPnLIDF5zCvGxj0w7?=
 =?us-ascii?Q?EKkk9mTixwJho0ZhrVhJRyjnoPZ1hga1t3A86G2AIrLJZHIlhBzS6mx/VyB8?=
 =?us-ascii?Q?cQvgkpHYAsdc+wt1AipQxfcoO4HcfW3k5JQgrNTAXEuAkzWArT3wITJHk5j1?=
 =?us-ascii?Q?Skg+RqGJPIR4krX0q7ryLxA0aGeJ6gyhX5NyRCHGX7DGOpDcGhTRL97SgZBh?=
 =?us-ascii?Q?qU8hQ33t0GXfarRchWaCgk53dc7hP7XPduj4e7+aSY5ShexPcyo5peF0ldCY?=
 =?us-ascii?Q?a/Z6zN4HNyiZuP2NHbI7hXl+DMd1lSIAP6PobS7AVpQIVzfjqmESe6i4fmgF?=
 =?us-ascii?Q?z4q9NBP7C+wtiXW+SUA00z8g9SS8a3+0Tbpj5cj8j4nsiaxiGV6+JsLVbzT1?=
 =?us-ascii?Q?+7JzCeB8glC7Lur5YgHLg0ALufwJFWji1ifBbF1NXwz9VZJKhJ/5dAJY2/IP?=
 =?us-ascii?Q?ho+fUU4KY1QHOsMVcdC6/6poGcdYfdrVg91w6k/xRIfczi8xcQzVHwQ+0yIJ?=
 =?us-ascii?Q?nH9TosuBty3XdRZWqFvZGpE2dtJ1ZG24yu7hFpV4hL0k84Mxmd1EYWtrip0j?=
 =?us-ascii?Q?YuwpnbcDKHrwSgP2w7o8iDuJ7Sc9TqqDimAwcVK7yE71LwyZXJ7is1P0sQq0?=
 =?us-ascii?Q?WVzo/tOEceMJ/cbBZ90Hq8L6kT9ZNxVElD860XqTzuauOoKqQ6aOA0v4ikG7?=
 =?us-ascii?Q?yWQvkHQ7Ut+IFfrbTgUuKInT0RcWUcjljOMD9Wbr9c4Vcc2apg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?A26XgDxJZFrWwxkoqGbp12WF4CrFAB702RHN6SKgYQSfjAbdoQ5eh60OJ+jF?=
 =?us-ascii?Q?itTlDg0qTY6sq2SGU1hMPpUHJxaFulsMFGdl/Ah9OZ1IcuVLBjd4V+OZP5s4?=
 =?us-ascii?Q?Fqct+33dgBhoxc0mpbEbbbwEG0kBqKBWdTUcRYQTpETSrRmXUKJHn+Sx4H97?=
 =?us-ascii?Q?fJq6ZJPRua/Oh1AHEDeAVpL8ySpDJpQ2JIlEGinJugP3YlDi3T5nF1YeGEnx?=
 =?us-ascii?Q?wfqiK7OV9QSvCuO7nmdKqbxhnQ1Nr+usgtBgxc/iAxIGwN7aAqOt6mSBbpK6?=
 =?us-ascii?Q?jWAIDmHdlcDqVlJHNYJ4XyzVrSgLYxT4QIuU2sKw8PuCPG1k8spHSStwvSiu?=
 =?us-ascii?Q?8jXpyTbCNJPktHC+lrzlYQ2UDcvIHkfcHrVhoDOo32Ui74FhzQZDWcGa8iMo?=
 =?us-ascii?Q?AfwlJ7HPstcJtHoRGj+hKas76D+NB+qPD5laFz1LJ+33gIQ3SRzsfWUZq/qj?=
 =?us-ascii?Q?IZSiexnTObd8j4ICVUJbJAEwsM0oDDNUyfkDo1T3MsPXJ3s+pAOoAUhAUrvf?=
 =?us-ascii?Q?1s4A4o7z5Us32siVyLJVgbdxRwhdaa2BBb4RjLPiXxw/pBUAPFXckmQ/4moT?=
 =?us-ascii?Q?bCba6KckTUn3/ZvquIrMq0ty6u5hnqUsuLAs5/UrqCJ4jvwbgH5gibWoeNm1?=
 =?us-ascii?Q?LobzGpyCjSFeGR7hJto2kBfkgIZ+fCSrnFq+0D3JSw2he0i/oryrfSGQ6j4R?=
 =?us-ascii?Q?ct2hOVQsfKzCWwr2pZ/CFbsa5h3ELxNvdW3o2GO7bb6Maij8svtG6DaN0R86?=
 =?us-ascii?Q?iCktRe4sOcOQSqVcIO4Y6U9x1q9F5qGjD2nz35MobUsCJZUwcfr2+o+MH3k9?=
 =?us-ascii?Q?mOIHVMh4D58O+Spbqc8seabv0HS/DpNR47HvqKYVGAbIrg4Q9TPR40bVNcXE?=
 =?us-ascii?Q?XORrydqcHP5I6AqTKivUB/1Iac4OU0NTEQxWte1TLu1GYqN3mt93arnCUe2r?=
 =?us-ascii?Q?kTAvoQP39s2jPmIZRpl9+vsl/qwNA02OlNPJGtRchpT5cBSmd639s7CwsDZJ?=
 =?us-ascii?Q?OwYcLQbz9OId4bJ6oU07Bg8iAtPrZddQtls1CapeGH97q2Q+esFwV6dSRZD0?=
 =?us-ascii?Q?f2OK4TBYPsl0zoqUcebz1EsmLuLeY2/s+wbFp2JLc+BNKpda+NedRY419QoG?=
 =?us-ascii?Q?/YOFVxVzsqLJJeW0ZwHHIxcXgdj6Ps080u2zaBmjl/MLbtP7UatSXufa62k6?=
 =?us-ascii?Q?jzTVe33nITvfD5mbr4xg8tbWCy0GXg0/20cPuY7gy0XGKezfxkXcRhqMIAoF?=
 =?us-ascii?Q?2rXOgW3hCzoXAP+3GRWFkWIAc2k/Hc8ouKwkF+8UoJa/62ieYKmQkEZMVfax?=
 =?us-ascii?Q?RYLBo8Ix2HKXMe7RDf4yXC6KXHKUFYinLhiHO40jFa5sCodiCi1PESK4gYcA?=
 =?us-ascii?Q?wlIEqWtVfm32Bl5b7aCa0MWkJPEM36h9epTz+VGwLd6GaaVvy9TLiuhXtmaC?=
 =?us-ascii?Q?WZBc2RZ1z9XqY5nuqckETz+qK85rreGQBfkoVe6KUXF+5CnIhfvLbV2RPGfQ?=
 =?us-ascii?Q?fQhIrneKN0PZp6T32z6PpFRuIqk519HVB6JZaCYfDIMncuetUgdE7h8ZQnbt?=
 =?us-ascii?Q?LFc/ZBbMCn+9EuQT6+Q=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ffae8c81-8374-4904-d295-08dcd7ab4686
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 06:29:40.1789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MFP+eRdWW7eRkD7NfDl0NH/p3pf+S7o0Em1SwmIxgjaAQ4fesyubgTzGTN+b4vQN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Sent: Tuesday, September 17, 2024 7:04 PM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>;
> Peter Zijlstra <peterz@infradead.org>; Josh Poimboeuf
> <jpoimboe@kernel.org>; Ingo Molnar <mingo@redhat.com>; Dave Hansen
> <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvin
> <hpa@zytor.com>; linux-kernel@vger.kernel.org
> Subject: Re: [RFC PATCH 00/34] x86/bugs: Attack vector controls
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Thu, Sep 12, 2024 at 02:08:23PM -0500, David Kaplan wrote:
> > The rest of the patches define new "attack vector" command line
> > options to make it easier to select appropriate mitigations based on
> > the usage of the system.  While many users may not be intimately
> > familiar with the details of these CPU vulnerabilities, they are
> > likely better able to understand the intended usage of their system.
> > As a result, unneeded mitigations may be disabled, allowing users to re=
coup
> more performance.
>
> How much performance improvement are you seeing with each of the attack
> vector?
>
> There aren't many vulnerabilities that only affect a single attack vector=
.
> So, selecting to mitigate single attack vector mitigates a lot more than =
that.

I think any performance discussion will of course vary significantly by mic=
roarchitecture, workload, etc.  Several vulnerabilities are known to have n=
on-trivial performance impacts.

Of course it's worth noting that several of the attack vectors likely go ha=
nd-in-hand...like if you trust userspace you would disable user_kernel and =
user_user.  I discuss in patch 18 why these are separated, but at least for=
 now they'd likely be configured in sync.

>
> We may be able to get better performance improvement by adding vector-
> based switches at the mitigation points. And only enable them if user ask=
ed for
> it.

Right, and some mitigations might chose to now support different mitigation=
s for each attack vector.  This was already the case with bhi (see patch 30=
) where the syscall mitigation was enabled only for the user_kernel vector =
and the vmexit mitigation only for the guest_host vector.  I could imagine =
other mitigations choosing to support similar separation which could lead t=
o improved performance if mitigations on only certain vectors is required.

--David Kaplan


