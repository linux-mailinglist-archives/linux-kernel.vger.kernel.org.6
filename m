Return-Path: <linux-kernel+bounces-409488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0538C9C8D77
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8931B1F21304
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B38126BEE;
	Thu, 14 Nov 2024 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1+bzw0kf"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E46D262A3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731596380; cv=fail; b=ohuWu8NhcwZR1Ov7eeQRcjEyKASyVvHordp9Kp8XMWWSq0b612nF1O01eIYkcBk0gxfpzcIA6Is1IJaeWeV6ggAwsCxPoGIC2ZO798br1E+3Qx3NQrVbZsb3lxCeO1xVw1lfhOJQRSUQ7IRs4ps7apao6N67LITZfckPEQMCyM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731596380; c=relaxed/simple;
	bh=J5fjGGwhXyzhEA8s24AADQZYrlVLbkbIbYFvKROroDs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b2WZ9zlLM9zTkJWZzl0rmDx0OdxMukfkGC0dLFqKGSze89norv1WMDbcmRjD5wCEOzN8s6BeaNR36qftDhEvmV0xGUjFl5nyEtlKu2G3uW5O207VLoNf3uAOOow906aT14ER4CmEPQWlcj9+M2TcRnTU5E+pfxV4YlXqx0uxWYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1+bzw0kf; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t25KLL1tBXEJPcVgQCr9Dz06XfF5mpWJDR2VAnlRFNzPbgdhU9f9KgA4RG4+Vxf/4vwRlPZVcUjMiPbGUJePBg2/1m2ZfwDEhayYOdXnigHaZ2kNmhoFaoSqyKII+7yT+3+pstLL69/aMZoAfXZENlIXltvIkoUa5bKRzANQ7lkpllxMc9/DUlXVXLvGweEgt96SXtTQwWpC8UkXVMaAULSJLOSvZ2E+z11wZKtx9kPsoHJN1U4YGY6I606h611BX8/lgHE8NfUQ8B4qZPIsIrI0bhBrNn3ghqq8OgB3RN8ZdoBDBxF5O33tMcBtVD/UKLwaTwzfqlm4ILblamU7Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5Ilc9aKcJU0ELhhbWlOzOmu8b4g5lekHzuwUU4vdBE=;
 b=Q5kRIpFYgcRLGEDFf3VVDNtOCslOVdom7QBkotbGYh7QiaRH/2JEMIbrimCrviB7fZ18Nfbw9BfPAqbOiV7+4JjJZGAgP+orncvYrvBA0m/BbBYzVnBOd80yEy+ya7+kstEMHUPdE3kXXwpvS0XNaH5GQtt9ycDeQ3z2c7NyJoj3pD/52PY9RBXarIS1Ywa3RNabySh+HrTpkO9FQKu+0pwhcp8xiM4/j9H967kkd5+F+Lb/HXtYnNLmeD/hOj9MaMRaOA27gRAeoANaprIn7tJ4VyEcONIXEhaYDIvTA/osz/DjrtBs9Up8VPoDiOuzVstYZiST38yq3S6CneYAYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5Ilc9aKcJU0ELhhbWlOzOmu8b4g5lekHzuwUU4vdBE=;
 b=1+bzw0kfbic+j7e6xAWOG+FA2fDroIQg6qbdFECgWOZg5CpTIerC14uXPxlyWJK6oPGmt5ykI9OBuGrtPIYiONBZtHO7t9fSSr//NAV+9Rrm6HPew/Unwm0WroCYaLyKcgGvgrpLMXSq8zFkHhpHow32AvNNPnXJJLpvQOUyYQA=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 14:59:34 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%6]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 14:59:34 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 03/35] x86/bugs: Add AUTO mitigations for
 mds/taa/mmio/rfds
Thread-Topic: [PATCH v2 03/35] x86/bugs: Add AUTO mitigations for
 mds/taa/mmio/rfds
Thread-Index: AQHbNjywIA/H+otxtk2Qbt3DGqgFdbK23m4A
Date: Thu, 14 Nov 2024 14:59:34 +0000
Message-ID:
 <LV3PR12MB92654DE00F67C170DE47B575945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-4-david.kaplan@amd.com>
 <20241114022654.qr35ebyspjh4zayj@desk>
In-Reply-To: <20241114022654.qr35ebyspjh4zayj@desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3fbdf4df-5f73-4859-ae30-5d6407ec96f4;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-14T14:56:58Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|SN7PR12MB6958:EE_
x-ms-office365-filtering-correlation-id: e8912d02-2e26-45ef-af1c-08dd04bcf3dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mV6K2CwMH22gNE1sfURWjc1QkSrd9sTvsMRwtQRdsbwcO5cjwNCDT14UQC5J?=
 =?us-ascii?Q?dlDEyRE643eQz8FrvXyTn1s7XK1SXfTtBbu+EDnfI01DAt8oX9BkJJBBTbd2?=
 =?us-ascii?Q?6hFb38A4W/Kkh2AMgCmiLOe5LWVqjcAABVgN0jD2ooHfOv/Zya7t7hmbFhPx?=
 =?us-ascii?Q?tviqvmO3pdMCiMTfjHA6qhDKyD42UCqJtv3PMUS1o6Wu9ApBZlZkSJ/aHYAa?=
 =?us-ascii?Q?fKlqPwDwxgfNkTOwo43A81oONBNA/0gCSfF7Sn2hydQF3i0B52rbGcVEJwto?=
 =?us-ascii?Q?92/a4h1keO+ZTCU5XLSm9MQhhI55BmaIfDF2o9scQOhOn7FdVTSUkIA9l8uY?=
 =?us-ascii?Q?mbRFjguFgZm1pUZ09W3FBxJ5gqyW9p7dRB1UJoGxlenVjmgnprrugu2pEy0T?=
 =?us-ascii?Q?dnFz/SjR14WjXxm0mwrB+8e5LroKNvVxCWUMA8om5t22oY8Ar4AyLAtC/VZg?=
 =?us-ascii?Q?ogpJvzFRw03sPTO1/LXHQuoyfOpJRtzUK829onjmQzY2Yfac8ggz6E6PeIbM?=
 =?us-ascii?Q?DvEDL8qXpy5Z/8GxR4+qQX/hUSibPTzuyPNMyy+Ik8PeXg6668dQW2n0cmAp?=
 =?us-ascii?Q?GIWgDFicmAFQMuWhBlz+LXrlGKOher+IZA7w2Bo6Ci/zAgrp/WRi1efwNMA6?=
 =?us-ascii?Q?q1QZTPYfEg+FBvKmK/KWIP/ybuB9G/WeBJUrgfDM2VoxBcgb8UOaiwY+WgMw?=
 =?us-ascii?Q?9dsfWQL3zqULUXmylAGe7wAH6Kk3y7kTA7CvKpGLJJ4FBP1diW9oXjFU/xey?=
 =?us-ascii?Q?ZGWabd5ExKwE50RQnDPE+Q/HAi/iOyOMUIYHnsu+V8qXrgAdIeYan6Oig3GV?=
 =?us-ascii?Q?jrTCPl4Mb/CpMaCf+sYGgLC98I9lqZQiJki3+IIa/elz4az97yGLUOPKisb5?=
 =?us-ascii?Q?NbZhY+zwf2Hl6UimcZumcxnuakn6hpe1hV/ouK+kKrN0f2KBYu16aUwAdDlY?=
 =?us-ascii?Q?wFYRQ/kClf7uf5SHAGP9yV/y7SZ9UFXzKx7mWa0Xbs7GYLi8IQB3LOvuLp37?=
 =?us-ascii?Q?ilvnH+rHBMbfkmLNSGi9tPCflTwPGy8FzUpnZsbIPV5S07/kcmcscPdk3CE4?=
 =?us-ascii?Q?4TsJ35TmTln3nOZC3t0z27lO3Y5QpwTogkqye0RitBrolfKmQ40RO9z146TR?=
 =?us-ascii?Q?dCgm5shekMJRVOtc0AiktEPKGjrEvFjTALyJI/Ft63lsBI42EqqK1WZbx5y0?=
 =?us-ascii?Q?NP2uUONNF3F0lk+8GJR6u5DQ8GFsDjxcUvXDi29lg+pKqXbL1tTpoglk5BoP?=
 =?us-ascii?Q?mC7fxO2uByKJTa3Wmz7D9UcPMt8pkA/+oPThIgxCksyeKQh6pXBOUmPk6H+l?=
 =?us-ascii?Q?87hJ96pngJx4JY1d8+qfwvWHvRCHJ3F9dBnxYlGhNbIzvitLImeWwDuyvVD7?=
 =?us-ascii?Q?5+5QDk8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GXnnyrk3QsviJLcTawjiWqSpz+wApwK0eBqXwzo3jKXFh1lsRMqQHL801Piz?=
 =?us-ascii?Q?MVPuk/kMvZdd9Dw/NgYwSAGQYk1J/0JmpzS40GF2rl91KgnCAl2HloBB7IUT?=
 =?us-ascii?Q?pzekGIaTfndgq8f7LP19fuuXD3xOu7idq5aXiGcDZ8/eULYym9BpPGacklt0?=
 =?us-ascii?Q?IOoLG/kGYf67T9nTbr0L8Y0etYGCoEAufhN1VgUyc4cHBTN/Luln/rEaRplB?=
 =?us-ascii?Q?2YyeQnVUfueeuEzmbG0qEoK4WlYQIXpstzTK7st1Un1V521hpqJiIp9dX8Ze?=
 =?us-ascii?Q?GV9H7K9J4Se6X+ZPIApmOmEoxVogdrSg1qe1b+LZmkKeROT/9L7ksgPov4bM?=
 =?us-ascii?Q?EjbNOKAVKJ/pCd67bycOCBAXSy7K0jUo1DaGytBAK7qwwWenAdTySM9h0oB5?=
 =?us-ascii?Q?5fwawbpSLD7vqVq6UUUiSKINQ0qZuxmg3I0RdQanKx5urV8Fl8bseFQn0AvZ?=
 =?us-ascii?Q?WIT8/P7N1ynjLmlGejcGrkibVC5AsTYZKMaCC51OILVIHToIhpv4kLst7HPl?=
 =?us-ascii?Q?oqjlFjI/YB/peaSbfOe4r8OUarRARGj5kGzVlVCFaoKeeiEA3Noo4CnC6OpK?=
 =?us-ascii?Q?70uVNPuiy75YMOJZ/N1v9Ktgiefag316BctZ6VdLfgueu55RglBqVyLi3NT5?=
 =?us-ascii?Q?DnhSWzTITa/oUO4OPMcr3zU3fW8k0Tar8PJtjb5jQp5CC38x/C6NwevLtf1L?=
 =?us-ascii?Q?9TfZ9oDpteZPQp+FZg4ptzqqHjMs7E9vTL+Dh+iNoTZ0IOFHD0xAdbxMhPTg?=
 =?us-ascii?Q?1Uso5slVu77MOstiPwCRXnAWVidHZX9r5CRdtBUiaOsvWdJ+zP52MUf5q7hG?=
 =?us-ascii?Q?te5lTxmeK4hwLoU9iOoY67FieeXxZhDDfflSmjI6XnCdRaE2syDdSjAjC2j2?=
 =?us-ascii?Q?TcfYyCrylmNrrkxPUvcgiQXM4EwvtfRicw9CnHwELrQD5lg9jvOvZ/lAnFBP?=
 =?us-ascii?Q?YSMhSDujm83nXNebngr27PRf/v9EGZHtwBET4YvIwfieKbgHQv3Ukg7cRbx5?=
 =?us-ascii?Q?87iN4Al9o/5982g4oiKSP+2Z/cmA+yH93hemIsBJtnd06WrcYE1LGSyOxlkO?=
 =?us-ascii?Q?+VLaCbPd/udHVX/UqBHPghUDkpSi/j7nSt5dKMBJJmR4IGAlOyfs2DtL6mvF?=
 =?us-ascii?Q?jLGy+A0FbM2V+527dN9kEnYknbk/KoWqk5men+upFqwsSO3BP7FEMUFj4mcp?=
 =?us-ascii?Q?kPHxVyrnZMsOzo5qPr07sovSlEFozK8W6Yp0lvT5w+wvcROqbI5fbnE2dbXp?=
 =?us-ascii?Q?tUaSwJa7Xn5PCx32+5qbv1f+B84FFCKM26VOjO2JLMXVZDiItKXM5c/mLzpl?=
 =?us-ascii?Q?ywV92+v+g1JjWzs+y9LYduU0JE1OnqcZ1rMKiCgS02bmACUoZuuFphLPJNTY?=
 =?us-ascii?Q?oC9o8j6c+sIM+wC6qpYmx2ytUpCMvghJkLYRk2GzeaNjDHGYdaRPej1Ds/Ms?=
 =?us-ascii?Q?7nGdPDz1/PBPUhiA+Rv4JXojicqSABrQmAERbo8nbhfOi0ivtef86+Cln2ek?=
 =?us-ascii?Q?vnrjhOwJZHYMXnwbw5ngmmORFAxSnOloaEZxXLq7iXl1IAvoaCWYIkCc+rAp?=
 =?us-ascii?Q?y2OQ1Y2AypLFrMVPBR0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8912d02-2e26-45ef-af1c-08dd04bcf3dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 14:59:34.7633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UuM55g1SfFlTBbIfERTD+ThRygOEBserC1jYorDRNwjgxRAINU9LJHh7g+y0Afl0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Sent: Wednesday, November 13, 2024 8:27 PM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>;=
 Peter
> Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; In=
go
> Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> x86@kernel.org; H . Peter Anvin <hpa@zytor.com>; linux-kernel@vger.kernel=
.org
> Subject: Re: [PATCH v2 03/35] x86/bugs: Add AUTO mitigations for
> mds/taa/mmio/rfds
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Tue, Nov 05, 2024 at 03:54:23PM -0600, David Kaplan wrote:
> > @@ -1995,6 +2004,7 @@ void cpu_bugs_smt_update(void)
> >               update_mds_branch_idle();
> >               break;
> >       case MDS_MITIGATION_OFF:
> > +     case MDS_MITIGATION_AUTO:
>
> This implies AUTO and OFF are similar, which is counter intuitive.
> While mitigation selection code ...
>
> > +     if (mds_mitigation =3D=3D MDS_MITIGATION_AUTO)
> > +             mds_mitigation =3D MDS_MITIGATION_FULL;
> > +
>
> ... indicates that AUTO is equivalent to FULL. So, I think AUTO should be=
 handled
> the same way as FULL in cpu_bugs_smt_update() as well.
>
> Same for TAA and MMIO below.
>

The mitigation is never actually AUTO by the time we call cpu_bugs_smt_upda=
te(), since this happens after cpu_select_mitigations().  I had to add the =
case statement here so the switch statement was complete, but this case wil=
l never be hit.

Should I put a comment here about that?  Or is a default case the better wa=
y to handle this?

--David Kaplan

