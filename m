Return-Path: <linux-kernel+bounces-535067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20171A46E64
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A0516A4C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C5B25BAD1;
	Wed, 26 Feb 2025 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="woDywbbt"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24E121CC79
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740608338; cv=fail; b=H8BFpFyTLYSEXbysbYmXTMiO6AmrNyklrMVnh4gFfX+Nsbl4viDwKJe9xvffVdeHgfP9naXxg5nbHzlh3CWlA9EcmDZkFhXD6j7EposdINX3wmWlNBwsDF/SQ3xDq4zIjYaQwT+1PIzyvzOeNzKLf/18CqbyRCfStoot99klrBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740608338; c=relaxed/simple;
	bh=f6Po5eWUC6u6BsMYCFu1jJgjK/FK7qe07ph4QVCF1tk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mHB8N/4ikID3OmtIrqV9s1B3AU6vGoRla0GOU+RHILBIowav7B/pruJ7xrA+P6JKYYQyt/GY9lRDIQTqX/2QT8umDQKODWinhbowfA/IPOMSE8DwHCCpEJQ0a2tSNPGebFBtHvhWV6yvF3+2jwjAGHj2UrgstVlptGGIlFOO7yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=woDywbbt; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwkWIAVt23CugwR6lf/0j0gfIMksdVAkNkRG7gO8Asd+jWVYkQneS5rsDA3oNyPVAU9e5mxJPyz+raqmhih0ZCwtBPfq8jNqjkk2PRXGpixaCopdIH7Eajfv0GfTVyD5uq1tYNUjqxEVi8xXw2n8InqXRagvxSzIiypyFD23F2J1GoOXA/v5y9VLrb2AYoTMuAixt1Q2CC7/3fmgloDke9k2oEyotzuMIeTLh2Cmo9ytymv7ZFwvqAUhUIDjwgbujYC2dD0b/h8yt8WS+AW9/SSNDx0ot1PV5a0wIIdkD0yTAI7U5taUPhrfDd9u9gfpXjBp213gyIEkDK901gq9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kN1CrEb61eI1U3cH1lCIssBG595W52S9g0c20VtWBMc=;
 b=JTO47MoENxScxTdipFTxitoKBCqkJLCzYdFiVs8hELbC4jS/t1pM2dWODzHJ8aodendmuQeHOZ7alkGvfwNJfHDqyNnceFJTekj1q93nc1JbJEydaE2dcax19qZlZFmGeiW4s7y/KBZSYxzXGrOWvfojF0qLGknEnkCqF5ZCWMIcfi1UXNw1D4irAgiFkVM1RJO8jTjdxkI0qy11wYah0+MYJTtf2AIIfVO+YPXH4BkO66ZECAUr4ouhzZBBujkoXXbpqTVOWDPgBJIlrOXhPJ3ayblUhTqXKdeqwAe8VXxiYXNgAeelONY2ZsVcmZL8v5U/ZNTsw2/Qw5cx7frRzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kN1CrEb61eI1U3cH1lCIssBG595W52S9g0c20VtWBMc=;
 b=woDywbbtBdXeyYh9EkZgFpWb3oVE+17u+CNNoUpkWHiLenIkjPoyShW/LEVcN3W+BBLTlYKdGNA87yiqM3t5fDN+FF7W9iRHAIhWMB8kBBw+2R8SWjyrr2LZawx7+BS+nGSg22tiV0LYESK7VXNbTUpN6zJB/Ea1N1Swvj6IO1c=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by CH3PR12MB7713.namprd12.prod.outlook.com (2603:10b6:610:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 22:18:52 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 22:18:51 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Josh Poimboeuf <jpoimboe@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 20/35] x86/bugs: Define attack vectors
Thread-Topic: [PATCH v3 20/35] x86/bugs: Define attack vectors
Thread-Index:
 AQHbfK/msIIkfjoqOkyd6FXsW3bSnrND631ggAfdInCAADBpAIAAAIOwgAA3cwCAACLxwIAAWYuAgAAd6ICABAIeAIAJN77AgAAXk4CAAAqGMIAAFpcAgAAAWUA=
Date: Wed, 26 Feb 2025 22:18:51 +0000
Message-ID:
 <LV3PR12MB9265BC33F465DB7D2735290394C22@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250217201910.crsu7xucsa4dz3ub@jpoimboe>
 <LV3PR12MB9265249E8D0FD3920C42A1A994FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250217233928.k3oem3bm7w63jzfr@jpoimboe>
 <LV3PR12MB9265041C9D8D4F3E5760F0B694FA2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250218070501.7mwcxqgsuxl3meef@jpoimboe>
 <20250218085203.GDZ7RKM6IyPDQAkZ8A@fat_crate.local>
 <20250220220440.ma5yfebhiovkqojt@jpoimboe>
 <LV3PR12MB9265DE3082FA0A7FDF9B587594C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226201453.jgg6kucaathzmcvs@desk>
 <LV3PR12MB9265F875F52317BBCDF953EC94C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226221324.hq2nevnnnrpgo75n@desk>
In-Reply-To: <20250226221324.hq2nevnnnrpgo75n@desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f3be8283-37c1-435e-8694-365cb4c5ee7f;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-26T22:14:38Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|CH3PR12MB7713:EE_
x-ms-office365-filtering-correlation-id: 76f78697-cf69-4d18-6aa7-08dd56b38cde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?i6Na+vNDVgU11bRIa5hyBKenwfeL/LeVlK2SGfyJkCaUuT9rV+Y3dhgEtFZZ?=
 =?us-ascii?Q?wwtw+VSxBVO/+fpszejBcK8EgYPNw0RaYrXLvlIALtZKg7ay3De6mSrK5lsu?=
 =?us-ascii?Q?scxk9QdLxkNI339OBtvWx15xg6QC8Nzbc170wiJ8PhzELL2M9bBbXG3FyGz6?=
 =?us-ascii?Q?xM9tAC4v5nFxHO7UcO+mZQqSgES9k/KZHBaEL/8tdRTdvnj97kx0WLX7yLZA?=
 =?us-ascii?Q?aVNEYzRwjxUpLTRL+UgGQIRJ7MyS52lkHxc8KgYisf7uiGaiakLOvy1kKCCF?=
 =?us-ascii?Q?gCSG0GBN8GL6zqEvgyMForn1Ai1DW8vWzZiSkPBxYxdnPQudQcdj+dPeM6xD?=
 =?us-ascii?Q?D6mDnozCG1/ZpXX832+SBZlIp4GN6+3o77xEg8GmdCUcmlFvh+uj1r1+ji/3?=
 =?us-ascii?Q?OmuSZRTgNChg5uMEq/t2sQeyfBEVTAgPEwV6ZxTwNP9RSFOi/QvtAXoJ/amF?=
 =?us-ascii?Q?Sf51F/di5KP3bPiE/dVQZvHcQcWSgO+G2MgpkHTxzQhVfxBgQMUGX4OMv3fM?=
 =?us-ascii?Q?AnVJB3moT9OPpT204YL03e1Pt2eSbmt8zZorXiRk/scibSf7vmIEPMnxJCo7?=
 =?us-ascii?Q?aZs4JVwWYbrCEurjKXjneUSrx2Bu6Xwzr+HNXwcZbxvlMnUn+woovumaZW+q?=
 =?us-ascii?Q?+7EEjEn6QSDmwGaKWwnrs5Z/h+YiLEnjI+TxLR5n2tudp3QlSGcdolTiTjBe?=
 =?us-ascii?Q?upuyYCL3m/pRlrI4U2LWWM2sEeVaL1TkKIhtSKnuGbrqjrDLbwaQ460fchL+?=
 =?us-ascii?Q?xdLyLbQgtN9WoOgER60FrnjFZ5qsGo6cA4wO8XLn9NACZiZYRcuFmKSnaTNg?=
 =?us-ascii?Q?L2aQC2kX7wfA07sMNeU20IJKOUut00YrUUoUUDC6uCVlAQLn8/YfBOrUspEB?=
 =?us-ascii?Q?p7uQkWHMPYlVYmDlqu6M7drcHJpfy/U1j6WE4I/hjTTij87TedIx/mr57soy?=
 =?us-ascii?Q?VuoBague/lyC5Vny+XW58YH5ilGvFK8vNC6sAuqyry+Fbfi6mkRXPnpw1/6U?=
 =?us-ascii?Q?FasAjWaQyqhiBO82gBCyXQSufWX6+UlsNL+EU/gNPTZzlkKI1sF6mmbaVs3Z?=
 =?us-ascii?Q?eanVkIopcvEg2xvPLp456V45IwlzXy6SLRZ3iYbn96MdUzizZeeWf9KCCYMM?=
 =?us-ascii?Q?HuNzlpS2/hE1tRvyPoNZpXQIbI2Q7DT+Olk/DsPeLufYDKs9vp2mgIlq8bfp?=
 =?us-ascii?Q?jlbdDqIKVfblTET7Qlexv0crDYPTfyFNQ6DVVeX9OL6DYMhOCzOFjZjaTAXr?=
 =?us-ascii?Q?CVxhzGpK6Ai1R0HWxEKivNd40w6dTK1rVXeXfQqbwDhsuTEof8iwu04Rz8vG?=
 =?us-ascii?Q?shvnml7iumQOLRKiccfyJSWOwLl5nPhjb/gfPh1MwKO0CE8tjWekN7XNq7bD?=
 =?us-ascii?Q?Sr33G697JS+OF+d8VidNXtQ4PqPLJ0+0y2krXO0QRwr6MBmc3d4VqF0nytq3?=
 =?us-ascii?Q?6etl+r3PFbg54QZzxFU4nPM2IE3er5hw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?O/93xpWzBqeZREWFm+6XBRq7bfMhvkXi+tkhHcwnYvjMPcU77nVBFJea3aLn?=
 =?us-ascii?Q?DvrGVsKN04K89RK2QKLbSST5Wz8zlHcAVu3xXNZeFPMCrvi1Bcm3tmp/MrQe?=
 =?us-ascii?Q?WsZ0rr/dRCMLMXIn3Csvf2woBV9Fm+z7RQ1jCOCvoeJbZtU2JnFVEq5NA0qk?=
 =?us-ascii?Q?cdW2Qx3DM+NKTFt0AsmdDN6v9Bs7A3Citonm4w57OCj7t3+ijscESw/orZoJ?=
 =?us-ascii?Q?v7/kD11gFL6zu+e1OIjQVyFVB8O3tVfjo6OK4/o6AIqLkHJMK4LHzTI6G3bX?=
 =?us-ascii?Q?PO1INyjh5aPz0UDM6bWKYf9JTunAZooxXQqmr8sDrfBe/rKIL3LJpRsxewu8?=
 =?us-ascii?Q?lSBeYejnblkXjmq4XkKPkihDQNgAdXm52qiA+YrcMw97npJqwRlwrjVm/Itw?=
 =?us-ascii?Q?X6p5YNQSQcgXFKpG9i5Cg+o8E8Lz2F9LnUPKy5EcLTUi/faOPJvrvXBfq6AG?=
 =?us-ascii?Q?y0tvtE6SH58GF/LKkKDd7qjEO6vZZh02tWvZ7n7Dtcv04z4uYnK0kTF0jAYp?=
 =?us-ascii?Q?8QQtRe1nlN+7Uf8/jtATzV8tq8dr7lflvHB0oLVeMJ/OmaA0xYQ8nVUNxMCp?=
 =?us-ascii?Q?O0WQ8V9AuJIBrTkClJDqej0Tl+CTLc+ZPmPgOQki4oailSXyXJTvRcjvvmDV?=
 =?us-ascii?Q?BVAA/G45n0Ng4Gj3GvCZWIKQf/AYsoCdxgb3u2mE4cAJCFmRzwKuub6JLwPb?=
 =?us-ascii?Q?naPEg0iWFEVBEBfEsBbLsHN+bRQlO3R0BUdrV1SIopbHw/5fWg1kPaz6D7iJ?=
 =?us-ascii?Q?ZzVwBedgYGJTXjVDwE190a4vFyDJZNnx8pupKEzYif9UyEeC4Tn6MXXcjytv?=
 =?us-ascii?Q?IpKzem0NsiNvX0iGpSz2m3rROt11HPCE9J1wGb4SsJGxwNpV+IcX8L1G6kRZ?=
 =?us-ascii?Q?MgtJd0QrBG4ZDIGoCP6XZdZii9d8R/DYHeJ7RHglDIaq8IuJUD5h7GdaiSUT?=
 =?us-ascii?Q?NPuAIeZOzzNQOsz0reqZdB7Mg+VjeQs8zUFHBp5l6aapYvj0zLP9UllGzW6T?=
 =?us-ascii?Q?i+SQooLEf4nmCI/hvFgExUMyc/GssF297UkterlWbZ4RQbFOU1lbzt5QkJFy?=
 =?us-ascii?Q?/YhIkEl9YKLdWOgrqFQwbfQpfDlDNDEl3w3HCJXxM0hY8Eor81SSZKV+6Kdo?=
 =?us-ascii?Q?paRdXK4t6FZz4UEbci0jEDZJPw+Ew7mIzAT40uIlyZEE0szqyGqQPupHKhEJ?=
 =?us-ascii?Q?YtUU8OurGo4+ZtMwVIFTi+g7Nyd/zbPe3D+44yXLPcYMsjoMlQO94QDN1qyv?=
 =?us-ascii?Q?b+mxZ4WFxudqYGahduCPh9vX+f213AG3Tfi5RAs8aNXS8C/y91kfSwRiNSnT?=
 =?us-ascii?Q?o9DHV7RdXZlB9hLPEOhcDdg1q7e7JJcNCbZk9G5/2nbjFmhKF+EtJzlCSCrU?=
 =?us-ascii?Q?iv6e3voverRhZHPUEkjb3i2QJy30Ah8iiHgdreWBxLEU0y4AtESWDMIxipkB?=
 =?us-ascii?Q?H4u8tYJToyvYiyrryGnRgoxmiqD1GDPmBlZxVDMsdUNFR53oVNTF4ls9QtBl?=
 =?us-ascii?Q?gGub4IPS5+s0K9Tv1ZHUEMx3Ms3Y4dQo9jIPXB6ynZQJW914FIal7LwVWCAM?=
 =?us-ascii?Q?8+HXUPnCiZ3Q3UZKWdA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f78697-cf69-4d18-6aa7-08dd56b38cde
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 22:18:51.8769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gpg+kElwh1z+YX8v0vb4994AwP4Toy6SB1hvWslM6GqXy0PUf4u4slu+sUi4RF4K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7713

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Sent: Wednesday, February 26, 2025 4:13 PM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>; Borislav Petkov <bp@alien8.de>;
> Thomas Gleixner <tglx@linutronix.de>; Peter Zijlstra <peterz@infradead.or=
g>; Ingo
> Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> x86@kernel.org; H . Peter Anvin <hpa@zytor.com>; linux-kernel@vger.kernel=
.org
> Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
>
>
> > But we could also combine that with mitigations=3Dselective perhaps wit=
h
> > tokens like 'mitigate_smt' (enable all relevant SMT mitigations
> > including disabling SMT if needed) or 'no_mitigate_smt' (do not enable
> > any SMT mitigation).  If no token is specified, then we'd default to
> > the behavior today where SMT won't be disabled but other mitigations ge=
t applied.
> > Then everything is in one option.
>
> Agree.
>
> > If we like that, then a related question then, do we agree that
> > 'mitigations=3Doff' should be equivalent to
> >
> 'mitigations=3Dselective,no_user_kernel,no_user_user,no_guest_host,no_gue=
st_gues
> t,no_mitigate_smt'?
> >
> > If so, and we're ok with individual bug cmdlines overriding this, then
> > I think we can get rid of cpu_mitigations_off() and just rely on the
> > attack vectors as Josh was suggesting.
>
> Does that mean to stop supporting "mitigations=3Doff"?

No.  I'm saying that mitigations=3Doff would be equivalent to the above com=
mand line.  The <vuln>_select_mitigation() functions wouldn't have to call =
cpu_mitigations_off() anymore, they'd just naturally chose no mitigation be=
cause no attack vectors would be selected.

--David Kaplan


