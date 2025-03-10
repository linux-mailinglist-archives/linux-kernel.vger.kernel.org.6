Return-Path: <linux-kernel+bounces-555082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B12A5A543
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E653AE4A8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360D81DF26A;
	Mon, 10 Mar 2025 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HtMFkh8M"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686571DF244
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639614; cv=fail; b=jUcCsK2C9+RBWOEftmA2UGFMO4EzUWIAfYsrioLGObuJs8vITHDp60Y7Y09MSRB9IcP2iFTaTdWfUYopAxEHENhz4k26IkWuaVseA75B8KeZoV6R0e6zx5W/GYfRLkhA9SJy9d90xn3FmOu+aLdaktW5k922DRulh+mtIN7x2tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639614; c=relaxed/simple;
	bh=jPtNGC2uRrWwAMVYm7RslfP3/G8JPc7+BXLpNQWWZ+8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b+abaqODlKDTs6Alf/kCs+Pbevh3+Bn5CpGOlO7N/kT1AvKsylK93/1I3z2Fo5y04fRTLvG+wdI62w0wubDSH+troVAyNoLzbU0ELwjPFfFF/CFQ6nrreMBk87CQJW10Q5aMvTzW8IIUwUDfy9uLfae/oy83t068k4kwQWabGos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HtMFkh8M; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kci2EJuisGY5rw373uvVE6uqHkbLCcmayxHAMKz/aa378yTfc5A/DW11r8RgTquDNRniHE8lOlLTUAh1g1ik4S+Ogr0D4A2zyR40jmBNVHY9kyP7GHYr7CpB6u0AGCNU1hYeGwfCevHIXsytCJ32G2OKfQiGfL94k+aqWrueRQigPgbmvO0RaFLScks6Q8OTC4t4lfqmBqXgm3W9D2ZQTp0mZughc5wYS2CLPXWmVRLG/zy9RslYVfMJ/stpH738a1KcHfuVkJwW4qPL33FsoPhuTdLLX5BKNxEGKG/3p44u5ooPphg4A77VwNmb8Fq05aMZaV97+mjL8aOGmd/Xew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piS7EdiqWRKK182c+8oc3LFr1Po+k7B5CTmVS4PcJKM=;
 b=ghexLvEcM1fZQ1/W3pvWtzGyHbEPoE/v/WpncPb/TBIy0XthV4Sxg1YY9m8vCXL1Vkjp9Z0Top+/J3I8gxqjo+PA1pcky2Cp0QhGNkMis7V87h44sFg8GZg0F2zwA72iJLyV08ZjZW+wVVGoCVFyY9gBzLJQGVCBpiVAGCTKhQe4x3uhg3RivxemCIQ1obhOTJqjIFBlcsWtNZ3aKPMR0HEnN0eimICDSrxhAqXPTR4ZuvH4TfAmOga0dl5R8a97MAO3K4wH2qCRvV6QU1676Gttjq7Kcr8aeILh+7vX6p5aZyn1YkBEfacLSeL5LWlfAdHnrn1PW6OCrJSuF7W5AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piS7EdiqWRKK182c+8oc3LFr1Po+k7B5CTmVS4PcJKM=;
 b=HtMFkh8MbBn2kFIKvOCYHRiFDAxDYLqMJeB2ZrNuvOVuk/Xh0oCHs6gU2Jkcu8TGC5zoB6To5uyJmm5nnYVo3ewPYZ+VW0oMSrr4F7U9YnGJYRalq86/QsuPuNp9N7i236c6wXv2s0IjTPVkg1qjTImsKSvU5LaEjuwiU4XPBIY=
Received: from DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14)
 by CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 20:46:47 +0000
Received: from DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6]) by DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6%5]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 20:46:47 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Ingo Molnar <mingo@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brendan
 Jackman <jackmanb@google.com>, Derek Manwaring <derekmn@amazon.com>
Subject: RE: [PATCH v4 00/36] Attack vector controls
Thread-Topic: [PATCH v4 00/36] Attack vector controls
Thread-Index: AQHbkeyTEUFLlLtsqUuXsm/HABEO57Ns1x+g
Date: Mon, 10 Mar 2025 20:46:46 +0000
Message-ID:
 <DS0PR12MB9273553AE4096FCCBBB4000E94D62@DS0PR12MB9273.namprd12.prod.outlook.com>
References: <20250310164023.779191-1-david.kaplan@amd.com>
 <Z88zM52t8b1oSfr2@gmail.com>
In-Reply-To: <Z88zM52t8b1oSfr2@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=eb02174e-b7db-4c1d-85fd-14566df6bd97;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-10T20:46:23Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB9273:EE_|CH3PR12MB9284:EE_
x-ms-office365-filtering-correlation-id: cd307ece-d2b6-4549-8bdb-08dd6014acb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?T9eprG8BmccpN3t9Xu7JGieHRgdQhnHCM/jAxgFAtgLMNDY052YAz55lodjl?=
 =?us-ascii?Q?JWpzJqspOP7gLXvD98Q1XAX0hGXBXpdCOxIm9EMFnKuqEcbaxD3ALxS89jDQ?=
 =?us-ascii?Q?btxA0pbmqwT+lDZ5zajBKv3hdefrwG3D9MZvroEpTMo5wClLt4m6rKu8zazj?=
 =?us-ascii?Q?o7rE4neTv+9XsLWHWGepHt8c8mcFJoD83rjKbv4FP4BtIP4GuRVxEFvA0+Kq?=
 =?us-ascii?Q?M/PXRsDsJLlhMIXZsUkKJHzNoA+LkLuFzmXx41JLubhzxfcYzNUt7401eRlp?=
 =?us-ascii?Q?gzGAKmH/8Q4FakxhLj7KJuRlp0AtFt/D28nAHIcOrLhpCzsPpd0mFpOGJYWA?=
 =?us-ascii?Q?U4OuULFpLGh/g7gzNgG7WOh4fiOxkOEP2nQHB1jkv33GVXFHWPJuWBw/DlVq?=
 =?us-ascii?Q?z5G+jOkkrL/gSEaMy8fvcjt6CYMxjxMhB4VT/oV3hJgNlr2HJ7tnk3d27Pmu?=
 =?us-ascii?Q?oMNydX4CyoqO92nCUqbifkL2iQKRCfJhhECXKmTVTGe8iT2kvd/TLfnS/eXp?=
 =?us-ascii?Q?fyIMVfFwnx5BDZ8u+MCOz4HntOTszjo1P3gvGmRFPpoqqotJDLYMkT92ol5R?=
 =?us-ascii?Q?/QtAxv4FXG4G8WWidrpAbbBD8AMPjjpC2B8Ro8HT9cIdFGkptmIn/NH3kILr?=
 =?us-ascii?Q?l59R6xDN4lw0OJATt/ffHn11zcdfZCJzKM0DIwbh8b6R3BzB2gf9o7FtBIO/?=
 =?us-ascii?Q?aOiB9L5xuZXkQe/ZfTB8C0JvZm1B+0kiMKbiqH3A7/UZ1zDkGqt+ViTjM1Vr?=
 =?us-ascii?Q?cVzU72PGTL6gV2YdheBq7zwuWzWVFMAYp239Vn2zyRSvPvoDj4l7I0KCJ2/G?=
 =?us-ascii?Q?proPY/Odqd+9gt6r0Bxuwp+5dR4kGRaI4y1liKemqP9GO/Lh9BqA1XH1BYrf?=
 =?us-ascii?Q?wST5WHDO7WIOeN1h7S6dhQUCOBdSR2vyyAXc8wCsEjeU0rwyiPAi9o2Ob6XU?=
 =?us-ascii?Q?Xg47aQrEmnDGNVcqKcJSPsKrtHOm245rvtfzy7m1/JA99fH7knuUK3MDo+RT?=
 =?us-ascii?Q?Zz+rQ7TWhl7dGnoJJj/133DtZ5Zdcc7PVA+CK2N35EWl9SE9irYzR7vlHA1m?=
 =?us-ascii?Q?Ox6szgJEw1VKDT5PcDg0rpfclHsKzk0TAsaEdMAtjHCyLexdtUvghNoCxDrq?=
 =?us-ascii?Q?SKiU+N1ml5yeYg2y8HTe1P1T3HbeehwLel4jk+JVCNR4JMQIu2OnK6H1rUU6?=
 =?us-ascii?Q?WI/hY8VxXIuI8pEyVLEgBo4X91OOkmRA3E5GJ2skgh8aiom+u8KarrD0n0Hj?=
 =?us-ascii?Q?znfJpDP2UnUzU1P+3juX2rULpQMrM//NXLV1p2CANpZiQ3BvNGOKod1sDA/m?=
 =?us-ascii?Q?Ma1tn3Ct7uA4pmEEIEW64CHbmQi8jwvaItEq7ONMkh/LEowgBc+E2i9UN0Gw?=
 =?us-ascii?Q?wRsGGwSypeQKd8WCuRv/jPRj/bZXQZ61pw02jt/BPiJEY0v87PQKZ/wNmv6S?=
 =?us-ascii?Q?FZH3m4hVOMS5huwr3AkPsCIBCWi02jG0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB9273.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9z9c8aWb7fKzA2hUN8nFekXAoahUXkyolIzCHkNuQP7YJ2p3NX8myYVziijK?=
 =?us-ascii?Q?iliTB7eCKAbHpqsE0D7OytYClxklqC54J/FkhG5gu+kEnfch91l4oDriCOKD?=
 =?us-ascii?Q?QQwMIqy3lT6w88hFESXkyneo1jUUitB8x33cPDFy+TAe6g0BE4TinYxPwd64?=
 =?us-ascii?Q?IDaZdPT8mztXEexyPi5/ZMO9U8vj5LaFWPARy0xh09Nw9r2Xcvzip0Dlkyww?=
 =?us-ascii?Q?Wz85tTDSDrFZvRNIgJFmL1hqovz+PZmv6QAeBRC5oXWBF5Qp6WIOZt7XWQGZ?=
 =?us-ascii?Q?GJe1gnulkDjLUeaO6ebIpCNCRpMfe3Joro6U3PYd4jj15LS/wd47ncAydZhD?=
 =?us-ascii?Q?u5kTNhnT+TAedhFZ+wG/5i7aFL/is0GsZ/0GQWOURjf3qQCrOYz09lvewYbm?=
 =?us-ascii?Q?Uvs7o56NHKdCL8mWGfDMBu9u8aKJxthCrFNMc7d6pvoHzLTckCu0APy/xPIR?=
 =?us-ascii?Q?JpTqo11l1RDqcfPgbgozGun05i+y9+I2QnSPc5qPRq5WfAfVMA4vDTReF+Zq?=
 =?us-ascii?Q?l/wl7RhFOhLs8qlLd4WjE4qLccYQqu240ykIkTyyXrCyO66cCNpVaLKEjjh8?=
 =?us-ascii?Q?snVbx9kKhfh5JRLBLb7HNuMyA8yW08TZrUd3pIxLbmFHo+mM7mP5lARadw/d?=
 =?us-ascii?Q?wxIn43tvuTAIojduvB6yQME06GHblmBEgtn/l1eczO3F0QK65ygiq7+T/awV?=
 =?us-ascii?Q?FiWnDKPo8hS6wRSLX/3s+Y3romHeQ1IQMSzvdxqe6o9dmLL/p04TPXA25Jlv?=
 =?us-ascii?Q?HOI8nQcxp9IQpbmotm9gDG0aD+WbLUMebtLJiZEbpBL7QcGiXlrWKvz/QTZv?=
 =?us-ascii?Q?Oa4q8/rpPhfQ6VJCq5Z1KsckkVxmQZvM60TEHptr5AJPPevq+L22yVQdZFqB?=
 =?us-ascii?Q?HldU2FNB/PJ36v+huJTNrkeYV55wjz9NcEMo+YLYLvJ7xY+6V+cFvk7UbMVS?=
 =?us-ascii?Q?BnESCPoNibLNLx+ZRHdRMXDlk8Tug+xYYMuA6MOHtnu5byqSUhDpZMBJGk2U?=
 =?us-ascii?Q?pdSgm+rW8v68ll3SHR3s8ECI8ESWtsggB225gaf0jC4sT9ud0MDfjmfog2p7?=
 =?us-ascii?Q?qFY4kCKzHg+G2ZwxOs9WXuinfqGwM2F6pvhdlIQz6CQcFAhtiFYYhOYvRvMS?=
 =?us-ascii?Q?g82++xk5J1hJiNp/gJnnKCMPkTL9j53wFDEj73EW+R2fW3b9RAD8L/ugapH7?=
 =?us-ascii?Q?FxRLv4eqPJ6+FyM+G0N36UGFXcAo6HVt3tOG7kkUjkKkqW298/RaolhXpClO?=
 =?us-ascii?Q?x8pR/NTnnIlpuPirg9RGqjDKLeu44GPrMJ+BwhvSCkQQ7TTIH0xTLr/N/vOK?=
 =?us-ascii?Q?YUEiOymUux1ZIrcI61vctFci+UhrwtR+kFQ5qSDSMVOTruZM6iqKncHCrI8U?=
 =?us-ascii?Q?RHqJQEEeePGoJcvbjTU5aUG+2vR/sazYL4G4RduLb1cd1GuhRRw1exiKz+az?=
 =?us-ascii?Q?cN6+mi/RUxKf06PpSCyUvGlvi9KIr171Zbk/7Q3apwAinU7F8WKGVhjzcX/K?=
 =?us-ascii?Q?QdqGcTpS3jg+E1v5rPuEdP5RDsejiN4BoZlLbrhofnb6O00DIuQBSQigFypd?=
 =?us-ascii?Q?rUnHxIw8Qi39GLT9zZo=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB9273.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd307ece-d2b6-4549-8bdb-08dd6014acb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 20:46:46.9198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TqlTmvREfa5EEs4QscBjZZ0WzifNS6e3ReU1JzKTQKZByKSz6dSvSfzembsvX+kQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9284

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Ingo Molnar <mingo@kernel.org>
> Sent: Monday, March 10, 2025 1:45 PM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>;=
 Peter
> Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; Pa=
wan
> Gupta <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar <mingo@redhat.com>=
;
> Dave Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvi=
n
> <hpa@zytor.com>; linux-kernel@vger.kernel.org; Brendan Jackman
> <jackmanb@google.com>; Derek Manwaring <derekmn@amazon.com>
> Subject: Re: [PATCH v4 00/36] Attack vector controls
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> * David Kaplan <david.kaplan@amd.com> wrote:
>
> > David Kaplan (36):
> >   x86/bugs: Restructure mds mitigation
> >   x86/bugs: Restructure taa mitigation
> >   x86/bugs: Restructure mmio mitigation
> >   x86/bugs: Restructure rfds mitigation
> >   x86/bugs: Remove md_clear_*_mitigation()
> >   x86/bugs: Restructure srbds mitigation
> >   x86/bugs: Restructure gds mitigation
> >   x86/bugs: Restructure spectre_v1 mitigation
> >   x86/bugs: Only allow retbleed=3Dstuff on Intel
> >   x86/bugs: Restructure retbleed mitigation
> >   x86/bugs: Restructure spectre_v2_user mitigation
> >   x86/bugs: Restructure bhi mitigation
> >   x86/bugs: Restructure spectre_v2 mitigation
> >   x86/bugs: Restructure ssb mitigation
> >   x86/bugs: Restructure l1tf mitigation
> >   x86/bugs: Restructure srso mitigation
> >   Documentation/x86: Document the new attack vector controls
> >   cpu: Define attack vectors
> >   x86/Kconfig: Arch attack vector support
> >   x86/bugs: Determine relevant vulnerabilities based on attack vector
> >     controls.
> >   x86/bugs: Add attack vector controls for mds
> >   x86/bugs: Add attack vector controls for taa
> >   x86/bugs: Add attack vector controls for mmio
> >   x86/bugs: Add attack vector controls for rfds
> >   x86/bugs: Add attack vector controls for srbds
> >   x86/bugs: Add attack vector controls for gds
> >   x86/bugs: Add attack vector controls for spectre_v1
> >   x86/bugs: Add attack vector controls for retbleed
> >   x86/bugs: Add attack vector controls for spectre_v2_user
> >   x86/bugs: Add attack vector controls for bhi
> >   x86/bugs: Add attack vector controls for spectre_v2
> >   x86/bugs: Add attack vector controls for l1tf
> >   x86/bugs: Add attack vector controls for srso
> >   x86/pti: Add attack vector controls for pti
> >   x86/bugs: Print enabled attack vectors
> >   cpu: Show attack vectors in sysfs
>
> Just an overall meta comment: could you please capitalize all the acronym=
s properly
> and consistently in titles, changelogs and the code
> itself:
>
>   s/mds
>    /MDS
>
>   s/srso
>    /SRSO
>
> etc. For single patches we maintainers will routinely fix such issues, bu=
t for a 36-
> patch series it's rather tedious ...
>
> Also, please put no periods into titles, and titles should begin with a v=
erb.
>

Ack, will fix.

Thanks --David Kaplan

