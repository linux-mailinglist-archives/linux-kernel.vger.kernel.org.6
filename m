Return-Path: <linux-kernel+bounces-244764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A76692A91C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8771C2136B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51E0149C7E;
	Mon,  8 Jul 2024 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Q+4Bw9Zh"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2131.outbound.protection.outlook.com [40.107.93.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E3015A8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464233; cv=fail; b=LB+tNokQFxr9OMuI+OycpwxzrW7XqCuspz6xRoJ3AjEdeH51xleRDlN0GLkHQgTLe12ugWFAO2b2EUGPhvERDrI7aEcEctgyzYIA6L+euKb2uecFGVM5Xsil0iymzpTTaBsJjuAtJIVYt8jZRSkMB08W8NFZCkQLlzwfqmRcfsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464233; c=relaxed/simple;
	bh=DjXYJTd+nMv0msPowetwp+5m5BVcGNFUIaQH09bZQEM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uegV0obUeY1Gi5J3Mw0cnYZq2CW/dl0+jLekFKq3yMk0Lgvfi6nuRC1/BtPmJYM96bUZhP+A/C0VprjcEbpHKmSH0Djjc6Uax1aI3JaSfXxIXis7rG+G+VUb8+3hp3Wek+EyB/UDFln5JathnULtwsIa9VF4sf9R202GKorIffU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Q+4Bw9Zh; arc=fail smtp.client-ip=40.107.93.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJ7YFkzddAEf65tlQEVDoZ10qw4p2SvX/UbjPNIg6JtCE22EVxf3Z9DJRm0K72SyrA2m1Y6QfpZ4JOSmL1e5XOl8c4vjKW3Q9Sz8Gxkw6mUFHPphiyC3jEHmxer6CFcqPTl1GqeLOeMlJmYIpAnlfxUU9dQjlSbuU2rKThBNnvoI6Nn7dlu/D8zS+deSDGEd38vMgn8z7rfneuqvgc//pLeuWPno+KdAQnRKIdqGYZ5xm2w8d3hlXCFWFQdGVoJ1e2thKZq2MdB1y/9hY+VV2OjDdhvqahOCfYxsSBvXvvtEAMctUQgiDsrLCGa8uHvGpZfbKwO/iZA7zl4TeoeQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjXYJTd+nMv0msPowetwp+5m5BVcGNFUIaQH09bZQEM=;
 b=G/QFDRl5gniwYxmvpgLhP5Ri4Z1H5pWuquGfeI2Ub5ehfTvjUq8AZ0XzDGtR55Ly5MvdB9cBdC/fP+RNLsFC/9CCWi+CQ5a3RBwX9iei6gcogmMj2KYNNLkBR2gF9hzRFDA8CN5PmvaXRKx0vaokZmurlcfVyWhYedBnH7J6JKgpYkAiw5CxvNjZ9P+izOq6+O9PBV+DbQFDMKwh4yf/0l+wxGjfUv9cJIgUr33Dp5DEhhTXVTiXkj8roL0C6VxygPqnXiZzmgpknm0hTk7cL82RnaLc0CKGtTM1/7oRf2KepWnkfafHmN7o4vxIaoSGaJYKAm3NWtIRgWzjXoesKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjXYJTd+nMv0msPowetwp+5m5BVcGNFUIaQH09bZQEM=;
 b=Q+4Bw9ZhAxEw7qt0aI1iCIaDJqTpfR/NNNAvRBRWTlfA6KMK1Mk+AYsUgoUNlAfU4v9szYWXNGLP2RZzsuWUnbn3xwAT1ZtdRsyIFff3VGexOaFoYTWchOqtX0+LP9C6/MrXQjPK5doPR99M7DFtKR+PrAm5Grl8W9fvuEnZcJI=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by CH2PR21MB1399.namprd21.prod.outlook.com (2603:10b6:610:8e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.4; Mon, 8 Jul
 2024 18:43:49 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%6]) with mapi id 15.20.7784.001; Mon, 8 Jul 2024
 18:43:49 +0000
From: Dexuan Cui <decui@microsoft.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Michael
 Kelley <mikelley@microsoft.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Kai Huang
	<kai.huang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/tdx: Fix crash on kexec
Thread-Topic: [PATCH] x86/tdx: Fix crash on kexec
Thread-Index:
 AQHayi08OouzMdQ9yk6RhWa7zn+1QrHfHynwgAAFCYCABj7PgIABRYeAgAAEEjCABiVrAIAAZugA
Date: Mon, 8 Jul 2024 18:43:48 +0000
Message-ID:
 <SA1PR21MB13173DD10E57F067095F1251BFDA2@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <20240629130621.1671544-1-kirill.shutemov@linux.intel.com>
 <20240629135933.GAZoATRVAubo7ZDdKB@fat_crate.local>
 <poxeykijyqrz5hxrey46s6hh2qd6byirbevwuwec2gtbfq266c@npegk7sn3ot7>
 <SA1PR21MB1317A2E38083B300256AD5F1BFD12@SA1PR21MB1317.namprd21.prod.outlook.com>
 <20240629194103.GCZoBjTzC4m9a9yw1k@fat_crate.local>
 <SA1PR21MB1317B5850E4274CC31EDFBF8BFDD2@SA1PR21MB1317.namprd21.prod.outlook.com>
 <nx7jjplwvtmxsq675omsi5hc5oxceiffpmkqx754azuv7ee2zh@7fttse2hssti>
 <SA1PR21MB131745AD18D9E91D2ACA1964BFDE2@SA1PR21MB1317.namprd21.prod.outlook.com>
 <uewczuxr5foiwe6wklhcgzi6ejfwgacxxoa67xadey62s46yro@quwpodezpxh5>
In-Reply-To: <uewczuxr5foiwe6wklhcgzi6ejfwgacxxoa67xadey62s46yro@quwpodezpxh5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5e4a5787-19a8-4529-bb75-b3cb85c63b30;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-08T18:42:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|CH2PR21MB1399:EE_
x-ms-office365-filtering-correlation-id: ff710a4a-dba9-4e82-3ad1-08dc9f7de7e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?e2OattvDcRgKCxuytQm+If4HY2RTiLdBc6YntL+37UDiT38rh+TGtwBwHOEg?=
 =?us-ascii?Q?9n+JXmwbfOE5ze/wMeN5pVRbIJ4vvgtFjHJrVxAXcBPT6WDaSy0dhSUeCu+G?=
 =?us-ascii?Q?iUYOZ/PZIfuLE3JpzV4v51Xd9jeau0c5nt9Jb2qu3mhFgX+nhE7AGfQ6KE8q?=
 =?us-ascii?Q?nX9l+I66AK/R32MUdv/lx3qelWfRBrPMTFd4Gwp0OiKM+9ibxwoUqUA6uR7u?=
 =?us-ascii?Q?y2PlewpAv4r2rb8t1M/u6i3OFypSu4ilMDmEspnJjXIIwknJ2ORK1VsXDrMl?=
 =?us-ascii?Q?uJ8DdHK9iQurOlZ8o9ocq82jYQtK7aQ7hQ4UHJAoo18qN1MIWqloQpuI9NlJ?=
 =?us-ascii?Q?5aKeFap6Ng1xEhLvIPo5Bx60ba7qvolwOBNs97ERScPfgD2IVykYjXyOUp/8?=
 =?us-ascii?Q?ekKc8gZXW4btv3ej51Bh3dNvXrc+JWQWwmwtOvDuZUvIhf6vyGZeISHHvYgH?=
 =?us-ascii?Q?sZUDxyqzEMwV6NUv0/x2+3xAgaJCCbBzz76HiUkGZtFF4qVoPKJ6pgnIzCA1?=
 =?us-ascii?Q?S/xJTzynYvwnmb0+Tkkf5El2TVyDzyVl42/gWiU4Rtlx74TGfIEoClbaWkzn?=
 =?us-ascii?Q?Wi/9L9G90r4sOkCepER0pdi49O67CibVb0JEEA60D6JaUegp3Kd+GjFwUPrc?=
 =?us-ascii?Q?W7u4q6kudJ2ZqpvqY4nkIyqTMvXM74Kqfd/Ijm1h0uQS7Wz7jTZolShrOUfM?=
 =?us-ascii?Q?yDAHmQQAaiixJQi7HiIupzCEv8ibe+6gI7tT1tvfk3ypmCDC1qJHijk3nhFE?=
 =?us-ascii?Q?QcYJ0Z2cs3DcW5D1CxZurcsfglP8rmi6MHKDgglx+IPcBXxcNRJIfLr9VAcS?=
 =?us-ascii?Q?GvewdWy865fiqSUiWKy+UQkQH0lW4twmku0INLl+bLxaObGnkBGjRuUbVO2r?=
 =?us-ascii?Q?UV2PtbLIFBXZIMxUwbqetq4R4b1E5GxolY3dsUBGnQIE+lDmIAkwBxovjWYs?=
 =?us-ascii?Q?kGoRjYOKZ3YVyou2Ed0jAEMmmmwhXXTAobC/3q4N9klTeSUT/bT8nii/uyPL?=
 =?us-ascii?Q?KjdbsDnSW29enO9qoz7kD4WaOC2aSmcSdsun3xndw3UZASv3LWgB4Gb9pW1K?=
 =?us-ascii?Q?WKm+kDJSoLPdlg6nycgOTiEZZ7Pl6YXXEZ2+VeTQsnPHAlVo+dPQs7+yQeuq?=
 =?us-ascii?Q?8HiVCqdSNHxFqJl1eSvux/vBh/ebeRMJz983zYHf0gEzDsN2UOhDMXocQ8Us?=
 =?us-ascii?Q?DkEx8xJBBmPXVxXaj7NTtSQ32wsHBHiwSHr/I7dHRUQ9fAOyawxUZHQxxXri?=
 =?us-ascii?Q?2/TGMXK1rTJlJoma4cr7kHExM4DIi6rX62fNuDtdBZke3bgXj5oQKnGLr94o?=
 =?us-ascii?Q?ywerr9C5NRe3qsoRJfD/bYijgUeWNAwqV1ok488ClAPATdafQH/wGcscNXN4?=
 =?us-ascii?Q?Nk467AYLu/k51EQc4k8nHnxVOpjNjFVYO/q17tRYYZj1Di8y7g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?R2TXTyRVvi3k5IGa5HD6GmT7Rxn3kWFp3WASs02Oj8Tv0sD41Lb+O5KGbffn?=
 =?us-ascii?Q?CoC0dUtMR+fIgT23ASHcIhotTx+hX3euOHvZopkdqvGdIKAG9I7yMr66BJPa?=
 =?us-ascii?Q?INGdCxeOKEZjf38qqcTfssUHwAkbdOORlE/T0vJjIzMC7HClTjusSDSegOS8?=
 =?us-ascii?Q?EI+uyeQBFrcFFO+S0yZfANEQgH/l8jrp8jZUcLvA4PamkERsogtcS9pmFU+2?=
 =?us-ascii?Q?6fxIb+FtyIUMmvb298avj89/uukrN1Agm8k+3sE12aC1ABocYh8b6cf6opLW?=
 =?us-ascii?Q?D5XeBinDCe+wI3R+OWPw034Uxhw7AojR/S2NUi3ctmmAGF9emHfAQXqZ2ICB?=
 =?us-ascii?Q?0R00R+dDMyv2/QK7P88sjLWwBMVwOLbY5Y671QbODB1ZeX2AMITtwOw6000I?=
 =?us-ascii?Q?eewBHKEhks9aOPmcg9pgMNA0KKSXZgbEpLIgt1jSmDFvj/tyBNTzzr5MIJft?=
 =?us-ascii?Q?TdF66WGO9kx6/XwTBjahQABSaielur8WekLjra9ilz1ixVDJxUzRjEExEO2L?=
 =?us-ascii?Q?Y2DH/gn0OeMCFQOcqp+Y9lZ0mBqxCX/qxN8gs5OIOz7kpebRCKYpKtIzsCs1?=
 =?us-ascii?Q?3IUVTOrjWfCvWjKkKEgb2wPEimZSP0XoXnHwiYWVqjG0Y++uiNZNCpNu1NBA?=
 =?us-ascii?Q?MERIRW3n+UOmWbo/j/OO6IyZW9wJ8V34g1chxkdP/mhAe1rv2iN73g+d1au2?=
 =?us-ascii?Q?LWYik28tj1rvrsTLGnomQP3WpQWUcTuGFK81d3D62F0n6+nz5jXpEKBbmw0w?=
 =?us-ascii?Q?xkAMrpsdgDONsV64k1DACIRYT6wGK5xHJSXVplauGO3G7v1lDBkz1CuUIoS6?=
 =?us-ascii?Q?bbnGzr+36JHX76x482Zgyn8uBOSWxfcDZ7Bw/jK8yazIfisl5TSPYj9zxYba?=
 =?us-ascii?Q?n0Xv57Us0ETB5cHcJ4nfBxOFG3X14CgYDI4oh5qkE6DjX4CzdVNV7RkP2tto?=
 =?us-ascii?Q?8TcIGnuFxDFUo3C+5N55UAdsLUaWW4ySFgBj0L7WncFKCAEsTTXindxNwSES?=
 =?us-ascii?Q?5cGibt7+93qdOQrVE1I9KcE/5XN4OU/tIuvwsvFclkgl1QiWxl7lr5jbzpmw?=
 =?us-ascii?Q?hqzqfgJ1P/QEigeuwMAzc3ke4WDfBbjOp8XHcfGdoNiQQAURgHXGGYOR0+wN?=
 =?us-ascii?Q?rZmp515VZyoh8HyUQY1TvNmL1BF1IFhlLR/0+VwoxcPDXGmOfKQVEYgk9J+N?=
 =?us-ascii?Q?+iS/iTezwm6BqqknhZIYWaVCvqlx9tKQhjtuac3zX3HN9hFKKuKTYcorWFnc?=
 =?us-ascii?Q?uxOmXN1yz/JnYucv1yh2z/1nTx171BLSTI8k2DkXzLU3BNk3Ujox/CsWvJ/f?=
 =?us-ascii?Q?SmyH1JCKG9IIX6/f/rEBRWCFY8m1fctQuLZeUkFJW1cZbM1Kctssy6MpYIc0?=
 =?us-ascii?Q?j0kOFFrjlopubmkvZklGLxOp6rPpEqxFo4b4rZ7NlQWf8t+JOhv1VA2qbEvz?=
 =?us-ascii?Q?Ix3h1GHtZHSyC1jQ3+M5tPN3LZJTkegyiR3WbevaZPdmc58Re8/Y3nK8vnGa?=
 =?us-ascii?Q?7hHNKkFQYlyVL4X3P5uJyEjlYwK8kGESmWW5zYXCv+gAAHvOP+FOXFg9cy4V?=
 =?us-ascii?Q?APZZJoMJKBxIK6vCaoNbEpDZrW26zgcXQvYNZGJHQpuM9KD4NVHu7P/h1k0a?=
 =?us-ascii?Q?XmUV/FHWkqWpOFnEpufgRK8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1317.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff710a4a-dba9-4e82-3ad1-08dc9f7de7e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 18:43:48.9789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2XodpB1LEuI/x/CxHX0cJVLsvxJfoHTl2D5IuvX9A+gGkEXTy5vqGVP4GwHQmNKH9AMLk8k5gbsl2eHwNZuR2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1399

> From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Sent: Monday, July 8, 2024 5:35 AM
> > [...]
> Go ahead, post the new version.

I just posted the new version.=20

