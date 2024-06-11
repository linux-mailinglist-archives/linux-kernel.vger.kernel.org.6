Return-Path: <linux-kernel+bounces-210318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD41A904246
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7309B21C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555AD4CB55;
	Tue, 11 Jun 2024 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UsYhHLqk"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2093.outbound.protection.outlook.com [40.107.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60C142052
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126234; cv=fail; b=knwr9jRMXb5+FtX0lV/rCG+rD+nHJ5EheY8giofcvKFO8KBumZf2i8jh5avowx2x3ChuaycPri0iBZWO6LnqloaMkvioNh65ePX9q2ayoWnjfbT02BQAx7WLYcX/57cXGaSFbctwrVOWdZsW80Rh7tTQEP+TRfHt7n0yYSxa59g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126234; c=relaxed/simple;
	bh=Ipl1jiPKVa3KUU1TB5M4YNxe/3gODa2JEx9edysMuy4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=al6LoEZ3oBXclOhgy4VfObeRZ35hqMuj2xVN65iFGaB8Q/DuFeWRVXazlmfo8K6XJdnEVB9QQPDBIPDzgJUc+aclSCqj3jOv3KumaUk4jwNoidqdmrfqzqg32JytCT5iWOSYS0DaYwShXFGF+bH5DtFZ3xv4fBvGtfNeF/pBBLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=UsYhHLqk; arc=fail smtp.client-ip=40.107.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXN2WYcChqHo8JzJaKaE6RI+YPrX1JOU9VwtCe059JPwZl7MfcDYK+9OK89uEmk3OZEL1JnzYU/RHfPU4QUyy6y1GnER6boyujNOX7e1JRL1u4zX1hRTXzHuS4JC6Nd2yFSpO33rzHie9E2KUBtJjnf6QCCDIPn749BT0nzMMBOiHRhYYemtvt0fUI8MBQypzYRNj7IDG0Oz3/Z0n3g4uXkhD6GnKczG1B18ObhYoM4dPOUAc01B4He+szJdb3snUAMzw3z6D8jhpWzUvLbKzoW0DW7G3VU8hT79O87WqEPS5Ja4nwVFGqfinKy+mvaqSeFTVYhLeSzeiv+R8QMhUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOLZF0mmbYMBPabmTN/un+iITAEoYgvT9ZozK2KMEso=;
 b=dGroKIRLngeOI/Zm9h0/wXqsB5bW/U59ujFPFrdU65Mq1NKTbxnTjRKRKO/IFzfZuvQ6I/xmtcmrSeslJjItayBXtUvmhQjpwQlJFRRHvsgVtt4uWceN6r0UcZDnNN8lkFFhAhgrbnDVyDnzf7yi6l1itarxSW+vbaMHldY0ehNGfEl6mCWvJ8UDTS/yz9Q3+ltgpGCOZsGEKTmP124+MiduaT/rhOpPmPIwMREtc1TSATPnj4m4ZVm0HO/JRTsmQtdF84yS/opLWYkjVIO3Gl4JaDpFCIGlkVBVxRFW7nr1Wn7l/UOz1vgQONnbqEJgE11AGROQOCPOpkas/SZ3AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOLZF0mmbYMBPabmTN/un+iITAEoYgvT9ZozK2KMEso=;
 b=UsYhHLqkpRg3scYXn1dyga2bnZ/uzkP8v79rfjqALvFY9oG1S1aOqzAV80i6iVHItoklI4aVZOEL8QJj5yFk5nIuDa3ryf5gMdh5pNRHosKSGDZqaA99EUklZfJ3ov7fqSwuDSAp81La3EbKbNboaMJy4Pw2DUMzRwWebiNzg98=
Received: from DS0PR21MB3863.namprd21.prod.outlook.com (2603:10b6:8:122::11)
 by BYAPR21MB1334.namprd21.prod.outlook.com (2603:10b6:a03:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17; Tue, 11 Jun
 2024 17:17:03 +0000
Received: from DS0PR21MB3863.namprd21.prod.outlook.com
 ([fe80::b7d2:74d2:a9a6:4a6e]) by DS0PR21MB3863.namprd21.prod.outlook.com
 ([fe80::b7d2:74d2:a9a6:4a6e%3]) with mapi id 15.20.7677.014; Tue, 11 Jun 2024
 17:17:03 +0000
From: Chris Oo <cho@microsoft.com>
To: Dave Hansen <dave.hansen@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>
CC: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dexuan Cui
	<decui@microsoft.com>, John Starks <John.Starks@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH] x86/tdx: Generate SIGBUS on userspace MMIO
Thread-Topic: [EXTERNAL] Re: [PATCH] x86/tdx: Generate SIGBUS on userspace
 MMIO
Thread-Index: AQHauz3w8TPRvgQy4ESaPIQSld9qDrHCvt+AgAAN0uA=
Date: Tue, 11 Jun 2024 17:17:03 +0000
Message-ID:
 <DS0PR21MB3863B0D93D5F6D8CBE83931BA5C72@DS0PR21MB3863.namprd21.prod.outlook.com>
References: <20240528100919.520881-1-kirill.shutemov@linux.intel.com>
 <4df2ebee-40c0-4ea3-8909-13b90f049ff1@intel.com>
 <fa788a95-1814-4782-8a36-f9dce7a04b66@intel.com>
In-Reply-To: <fa788a95-1814-4782-8a36-f9dce7a04b66@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=53eb13c9-5e6e-4f0a-9e93-c5c109db8610;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-11T17:05:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR21MB3863:EE_|BYAPR21MB1334:EE_
x-ms-office365-filtering-correlation-id: d84ec222-05ec-422c-0434-08dc8a3a502f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230032|366008|376006|7416006|1800799016|38070700010;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XRxMKGwRYejGx9RGzyGa3oDuytr1Q7xxYCDfjpFk3ZIBRsHm0/4KHpwG/EFN?=
 =?us-ascii?Q?MPwJH4Og4Z+RUWiOCRmHCvInCScefGUTL47KrYUJlGjjay2r2rbFF1eDakfM?=
 =?us-ascii?Q?80jG/InxvoGBkvPfHasTfrc3xy4j0e7pUU+33eOYT+zavRWCluBKLhtd6U2y?=
 =?us-ascii?Q?vBIPc9Usl53jwHA74fDbC3anirM/lNRpNn137LeaPwK+6ZoLnTVVr1VH709F?=
 =?us-ascii?Q?yHVXGaCtfJeRWt5FlJhZv8UE43zW0jqJe2SQRv9lcOWWerdJ6YZsLSjjz+90?=
 =?us-ascii?Q?NPJRYXait5SPoO7RBsWCNU3d3Uv/O1e65tHKPk+H1HdI+fYlPGipX+ioVldL?=
 =?us-ascii?Q?DACmLbPFNu8SNWzcFlKxhGuoAMk+mjtj6CkZ7+9/t3o56+fheNZb9nFsqNxC?=
 =?us-ascii?Q?gyuKfsbLG7J6exQc0d8P94UgF2RROlJZOnZ98hKZfqs+4CDpk0SZTY+2LE3f?=
 =?us-ascii?Q?fajZ9/i0MJwXpQzi6QVlXE7vejV7G32l1qy51sWYjEDT6xtURi8wvSzPRVgv?=
 =?us-ascii?Q?xJ09A4YGmvau5zRr4qLRIla89G15O2jloQXETZV09K/SjPvH904SRreP4y5F?=
 =?us-ascii?Q?W8RZCS3R7NqMMkUto3eWTTSzp8SkhhlogaP0nwejehBN+VElRGalHM68e3EC?=
 =?us-ascii?Q?w9ZJXzl3duMyhmr2wA2CsXjpGOfrp21JqccZp+kjSycvV+7VS8Ss9Q/i1XsX?=
 =?us-ascii?Q?7s3gukJL4QQIB1wPFDVNlaCOnt2HNuw4C1EkzT/bHy+5d0eQIlZfNnl62pPi?=
 =?us-ascii?Q?ueoU4f1aAOU7yaRztoAMK/efzUTbjJbgxqSvj2sJzq+y40I1FiuZDI+EvXsm?=
 =?us-ascii?Q?sm4zVTDbkjcShzhpnzEBa00rk4J390c9r8Kn6oKuTHF4MMYGU9eUe9Ih33a1?=
 =?us-ascii?Q?xyMnrnLLKNAhLoFDLzzW47tY5nT/obnz9mlQtoP50mqg/f7Runln2bitJ30d?=
 =?us-ascii?Q?kdrBTxTyDcBbkLj9UVJVzQ280OkO0VzwfbkYWj6l3P20YJ9RcHcTZfXMKofz?=
 =?us-ascii?Q?RKbcXHZHvVpwplINUkQEq4In3Yg4ISBYapkI2gou8xE4OnE9oRtBMg/hFjkd?=
 =?us-ascii?Q?Xdl9V7X+vPzzxDt4Ize1oM9ralDAF+f6g+9YDDsRrjuc8fhYKEBLVYLZIoIi?=
 =?us-ascii?Q?UHuUw7O83x+8ZZvfnftZY7uTedwwGImwRpQSTJuLseqfhrrEpCdINeqj2HTm?=
 =?us-ascii?Q?pJcTdKVFlgizjgPtC7N5rbVrvY80ME9/2TYo5uO6nCoGdt7JG1fKeEretXwj?=
 =?us-ascii?Q?ixP37QWNN0EnYlDYr8EHCcnz+f4TLvGrB7pTUMJO4s7HgiDKUQVoJhF2f5fN?=
 =?us-ascii?Q?831y9vfWaEfZYNif0Ebh3WWyiZukcXsicAmSAOBEpv1z5XrcW3LHkLtSla30?=
 =?us-ascii?Q?kRT/PRU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR21MB3863.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(366008)(376006)(7416006)(1800799016)(38070700010);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uYFSd60nGAW3YX8IIUrVASrcILu1O+LNvTxcQB34LsOfruYG7w3tV1Nlv1Iw?=
 =?us-ascii?Q?lVO0Y/SdX/bfxVkuBRcjk6BBuH+BpXamTKmBfoXYQks8XWMm1CdAjp/kAFTw?=
 =?us-ascii?Q?yOQYjKpA2Hg47pIccGoY1P4boMjBrMo0NfoxojX4N88pCAkvzeDZ6wLMcYd1?=
 =?us-ascii?Q?cvc3XKC4oYH9wZNJvG1bSJ5YKw/rjTDy2GDzosFwA86holpP5Sp9O1ld2Xx6?=
 =?us-ascii?Q?j3kl7PO/MGDyTPH+6l2nVD5fPlpYcCTAAuQkysPVr9G5yXdoBY4KgZB8ExHn?=
 =?us-ascii?Q?/FueaKF+JAr/AtsY1l85t9i/w9zJmyynb/X8ABvHtYU8SOUg2JfYkb7tsdFP?=
 =?us-ascii?Q?h1W7trm7hHk4kaPHFQyrcSrRFF7OD+S5g8MldL4rdAK9I0u/p/UhlKopFiQH?=
 =?us-ascii?Q?4DQAiXDA2oU5RiqV8DJKR3t9cS2HpdcMy1Rkbp3Fi5JQ/4byXDSypKcTOs6G?=
 =?us-ascii?Q?YXPfKl1ODFHKodGe76ihupNPFSbW0oacy6pTvYdM5JEXHcYkgRG6LuQRRNWO?=
 =?us-ascii?Q?VP9BLnL5EJfof4YbjEAH2Jlw6QU87K55m+vXhR1VwMkA1P36G3al2i6lKnqR?=
 =?us-ascii?Q?t5zFw/mKKEvWX6h787jMrMidvmO7IWcGzeNgOOEPi+U4cb9It0nOdrm/LEpn?=
 =?us-ascii?Q?h7a/EypS9czSSLBZefc2wWsbPSNk24IuWexJWFEzXwQ23bAxDHPf/t6Gnch7?=
 =?us-ascii?Q?AeU+DiLSfKeQIvTAiDwT8NIPZ6DFeAenxtdDm47pdK/ybn8Ay+IAkNesTB8j?=
 =?us-ascii?Q?VMVX4cb1LtIkO4KTi2/lBr1PsJ8Psz17bPFJUM1S3iM0xqZ84rAlKssuiW45?=
 =?us-ascii?Q?dJTKrwuGGLxszwfwG7+S69EbFMJh4iDl1jWJbn2xiRTbjvziO3tk6r1Qt2SI?=
 =?us-ascii?Q?OntDg11F/YwUlQqCv/SsBGAJcqDyfvyUqEAhjwSpyNCmcJewEUWUhQBADND/?=
 =?us-ascii?Q?4ixEjjC3au08dgTIz3vXCrQf4HSgDabf5duodtzxVHaNQIpJ5qgvgFXcrtYC?=
 =?us-ascii?Q?P+rN/thXirFLlEQOyfB2khB8Tsh6WCC4uzgSdkyYqyet/ipatTZf42jjMI8l?=
 =?us-ascii?Q?8Y/EuD42+xFxSnmqG8ge01jAxSh59T+bLVJRoa/YGgCU2IJeGNUcT9Q8SCbd?=
 =?us-ascii?Q?4d1B2AoWIWTiia660bDMMdemg4g27qOyCpAEpdOkvznlspWaqfMZ59Sy8ZU5?=
 =?us-ascii?Q?uH9pnJoY7kTQ9CdaVr/C5aOS4mGGQ/js9hm1OBdFG2K1C+JfMCuAkNMlyq+S?=
 =?us-ascii?Q?C46UdOP65loTEOeUK2uki1Nk2bw8EIVccsJtLo+AqMN6Co3iHdqhmFAxykEe?=
 =?us-ascii?Q?vS63SU544YE0TbcRCQnhf0sgx2PaM8pDhym/wI/3btS97U1Xa+lBrYfwlMmi?=
 =?us-ascii?Q?oszUtMt3vspB7z9XCc4ctrPBu3ld3VDpR6SSAHH4NSrcdEsbJfpRvj1U6xcx?=
 =?us-ascii?Q?L+OvdAgLONPb8AfQlv5s5Z186s6SHKRXMDymq/WjOgvuAcCxDw1z8+dF0DYi?=
 =?us-ascii?Q?72No1YD3RZ1KLWcCdVf1c4JT7oXUr886uB9vrLmIA6V5RWdZyeTF8EsMzlnR?=
 =?us-ascii?Q?uo4yxyKqODzOPbUC50Q=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0PR21MB3863.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84ec222-05ec-422c-0434-08dc8a3a502f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 17:17:03.7532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZpJ9WLdswDIxwtALjHgaO3i7a5T8AhNr2yDg21Hm+gnAPEFb+B2YOcOUApucX2+7+86wt5vxJFuG3hGvaUL8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1334

We have a usecase where we have device drivers in usermode using vfio that =
mmap regions of the address space to access device BARs. In this case, when=
 the #VE handler cannot emulate mmio on behalf of usermode, we need the SIG=
BUS to know if we should retry the attempt via doing a write via the vfio f=
ile descriptor.=20

We don't want to have every mmio go through the vfio file descriptor, becau=
se for pages that are actually backed by physical device's BAR we won't tak=
e a #VE and introduce a bunch of extra path length, but only if the host ha=
s chosen to emulate some page in that BAR. We also don't have any way of kn=
owing which pages will cause a #VE because there's no way for the guest to =
query which pages the host has chosen to emulate accesses on.=20

Chris

-----Original Message-----
From: Dave Hansen <dave.hansen@intel.com>=20
Sent: Tuesday, June 11, 2024 9:16 AM
To: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>; Dave Hansen <dave=
.hansen@linux.intel.com>; Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar=
 <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>; x86@kernel.org; H. Pet=
er Anvin <hpa@zytor.com>
Cc: linux-coco@lists.linux.dev; linux-kernel@vger.kernel.org; Chris Oo <cho=
@microsoft.com>; Dexuan Cui <decui@microsoft.com>; John Starks <John.Starks=
@microsoft.com>
Subject: [EXTERNAL] Re: [PATCH] x86/tdx: Generate SIGBUS on userspace MMIO

[Some people who received this message don't often get email from dave.hans=
en@intel.com. Learn why this is important at https://aka.ms/LearnAboutSende=
rIdentification ]

On 6/10/24 06:55, Dave Hansen wrote:
>> Enlightened userspace may choose to handle MMIO on their own if the=20
>> kernel does not emulate it.
>>
>> Handle the EPT_VIOLATION exit reason for userspace and deliver SIGBUS=20
>> instead of SIGSEGV. SIGBUS is more appropriate for the MMIO situation.
> Is any userspace _actually_ doing this?  Sure, SIGBUS is more=20
> appropriate but in practice unprepared userspace crashes either way.

I also can't help but wonder if there's a better way to do this.

Just thinking out loud.... Ideally, we'd reject creating a potentially trou=
blesome VMA at mmap() time.  That's way better than, for instance, panic()'=
ing at some random place in the middle of program execution.

But I guess that's likely not possible because someone could be doing a VM_=
MIXEDMAP VMA that only has normal private pages and never _actually_ needs =
or has a shared page mapped.

I'd still love to know what actual kernel drivers and actual userspace woul=
d be involved in this whole dance.  It's still way too theoretical for me.

