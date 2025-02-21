Return-Path: <linux-kernel+bounces-524960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 674DAA3E92E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923543BC32C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3149C11CA9;
	Fri, 21 Feb 2025 00:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="QaziQDP/"
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C67010E0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740098205; cv=fail; b=ossAsRB9QNAAGkBGUpmtN3AQJTeAAyjtkuhvPmywjzS6yeQu2eQl35FjqTlCidstwkVcRyDLAKMV0EJoU+aLB3bWoniDQ14KqVl5avwQsARwJA7gW0Ap5gN+J/SYS2CNWHvNKY5HcgcB3hJ/4sMI0IfQmNdiwJMxxCzKPUC/EeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740098205; c=relaxed/simple;
	bh=8tBMq2ZxIFXFkk6FgtPwi/s7R+/TnOmQCMysp4i5I1I=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=V4H4O6lA5AYfBCLhml2ome0g7iZYI4CmmMr2UL4PJT7xKd+9N+81jIYE052AcnkVHUR6rPyf4FHa7P8XDpAlINHcGCmqUlaQ15p2MGdCuvqA++52am9jSAoLAldQ1PqYiy568NFUWgk+KbKi2pDh5v/viHnLCxUAmprmJUf+Yr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=QaziQDP/; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KNZBvl010695
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=Z6DKTnuwHz5ftx5UFFKNPzgggZUqv
	xPnaw+/2Mq3PO8=; b=QaziQDP/47UW4n7TPhzlraVkdlCHbNEa19yro7+b5RV7x
	Qu9Xr1sKnaDp6aT2AhKAKk065lGgpNC7U/webG3SRcbRpWa1VIzFHUMVPlj5k+Iu
	pSyoF1hSdUXeT2SsYsQDptVhQ9Ayyq5HtaBxL+nFNOSxvIHMUN0ps+zE4KWQ4BpY
	pbo78/VpejEoYgDW8aLtYjMPBeWvGrbVfZO8oB8vXitz33gjKk1IybW6trhohJKk
	7WYYTMcu1j6pK0rPa6tns34bG4/gysVAY3knhAJvYihtVSEBpOpclAHJuErQRTX/
	zGSBKJZJidyIHWORBNrEyePOzoLKFOAse1s6T5JCQ==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 44vyyfa7x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:36:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dF1KDZmgwNm/9ItOy3IDnpi1z0vafpu70g9gYb8+53LIDl0y3z1qscwnwPZyOXZ72pjn1pRq8SgyoqM6XGjwP5BHA5nGarV0ccMwRuUb88Ff111AaK/z9vtGhEVZ11XSftCc+8LwOu3SE6aAsVqk/zzc6fulgdEAkE+MirDR96buK5zQw6qhaNnrz5A8u9o6bKdbk24gcKEfxu65R/A2hV2oilKFpUDOOK/3SW2BgrO6mbK+dQnkmV7tNo2J3g/lb9pGv5CO92GhQD3YDOQdjHnRyJWo7sd/huYVYPe3FJgKa2VT6ppsawzsCdaybVSbCKmU59yOXSDuv3TMO0bhog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6DKTnuwHz5ftx5UFFKNPzgggZUqvxPnaw+/2Mq3PO8=;
 b=gGwVKUfeSJFnqlT1Bjc4s1430f7wXz5pApbgU7q8yXQQ2YT/B+qpF4lU9djvsMFVzH2J/pSRYaRf413oH5Wr/Sg1hO0qxEq3+Gq6bWj982gToqUfOwRE7CwgbtDZxwtQveKb0ncEP71HFiogfSDVFNH58tWkU4ryDl+oGCXGbZuDR/h5JREW3BhGP1kGaGA+ngen0NArhY/h4mRBKIHtg++vTRenjRnKtbPNL2a4BUSwrhQjtc9ZhImLxpdO+zFxQhg6gOiqzaWSTHZW3sxaGdzjVUtybjayqiwiein7gLJQf5n6KbOtQuZqVp4p/JAupXGE01yTdDxrUl8w5J5Jig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by SN4PR13MB5325.namprd13.prod.outlook.com (2603:10b6:806:208::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 00:36:34 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 00:36:34 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [boot time] Call for boot time data!!
Thread-Topic: [boot time] Call for boot time data!!
Thread-Index: AduD+Au2+Aj/s/B3TYm/Wzo+GK9ltA==
Date: Fri, 21 Feb 2025 00:36:33 +0000
Message-ID:
 <MW5PR13MB5632D241E8EDE22FF060F791FDC72@MW5PR13MB5632.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|SN4PR13MB5325:EE_
x-ms-office365-filtering-correlation-id: b6fb5840-faab-41aa-4b0b-08dd520fcafa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wdhzLUQ7XUK1uAMwyMk/BM0wl0VkKWYbIwBGtaY5fV+zgarZeiSAI0eXqPak?=
 =?us-ascii?Q?28bGHiI5O7+BrYhBWPgfQ2Twaqf+5TA660Ucf5xIq1a75rrBe+CbaOcEycIW?=
 =?us-ascii?Q?ZUnwXahh+w2ZotL1G/S0n459J7CU9Csgkx+fbU5S96AbdcT2HcnNJHyP7TDn?=
 =?us-ascii?Q?8lObFXUf7JmR45eADeESuVfOBShx0ckegtLxFyU2f5WJiPMZbdqSA8+QIF2Q?=
 =?us-ascii?Q?aCy+rTQQEVSPiZnvke8OPKWKIE1I7cYbQ7WC9S4BUcdrVqp/QWkvwF6mRtsd?=
 =?us-ascii?Q?De+HRBIWTDhjvVLzJ3gXWlLwAeoQdya4Yg7XeSb2PuaBIJquV0EgEokDLsRV?=
 =?us-ascii?Q?1hmvKm+3naxeDR+DOIqZeyOxvljlvDJImxa+jowY85QiVtoCyzQvNTdkzcyW?=
 =?us-ascii?Q?qdMHjf9ehF85RZZHF7Tli7vB7YVnt/DUdKa+o2LCNh9EPjnE1KieFNtpuLQx?=
 =?us-ascii?Q?E+CfUOoYwbjIu/LsWUtAH2L2towSXEpCpPMVlBY11kgv7/xgoyS+hBx/9uqA?=
 =?us-ascii?Q?5vx35mo0/YwisP4uZqmlyiY0iyjBGqkJdPtT8VDIXDUz+o7/ng5uDzjwmzfa?=
 =?us-ascii?Q?WUGIWqaA989ar35LyP8E4LQarkZqk6cDcwfyjznG9HwCEd2BYk4hKEQE6nj9?=
 =?us-ascii?Q?p4eiEryYgLH3PBqSk+SiH+1/+an5WTpxXxx3SYZrpl3bgHSML6H1UW/bN9Rh?=
 =?us-ascii?Q?IJQsIyFYACABU4wtsFmLnQQDVxx/UmFZlNoXMtoXUJkRagajEUBDnTAInbpy?=
 =?us-ascii?Q?C9aQ75IfaLN1OxWpazriWn0eWwBbJ7zLD0d5EgXV7h13Xh44N15OlEsPAbHr?=
 =?us-ascii?Q?axchu1nc6ABJZFYGOa2maPAA4rYk/872oFfbDIzp0n9CbLfsjT4NiEJzI6No?=
 =?us-ascii?Q?kXgQkjQZpiS1Uo5Q0GEiXry8uUH6Pi3gHwLs8pklxNy56GQvu2OyZgJO4Ilr?=
 =?us-ascii?Q?lf2sqz1mNH4NfjlgOuOaYYvwl62mGGcX0yumLpbm8R5Cfau3kQKXdO9VhzAw?=
 =?us-ascii?Q?Jfbb0+uotXOAyDPyqjIylYXTabkkuVhk22uk8PyuUB4SfGzhDP92Vj3z7c/c?=
 =?us-ascii?Q?WOA2NA8/fOql7cygZX8WaavBayjHJ+8T/oMbkHNyYTgT3FXGPAdzDqTl7LPl?=
 =?us-ascii?Q?HsK8ssekpowiFNKxD1kdEFvFaL+sEwbogGOqxwYZMZU3djALcw4YTNb6zqGY?=
 =?us-ascii?Q?u3ZX77gSGFsngz4fWtudwabJpn/SZ7qfh3Jo8ILte5E8y3/MBxRa/IPXbFXc?=
 =?us-ascii?Q?L01KYrHpb8aT14WHl8gVd25HFPL/0SHor+Ye2gpdFMLXKRYw+xdfz9FE+34M?=
 =?us-ascii?Q?z8vbLSWzHgH87R24Clsh4uxnnuG2C894I0UidwSbmRJcVSPufzJY9yCmVf8Q?=
 =?us-ascii?Q?2ZYfuGJ2V3VQP0SOG1E+osZs5AKI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IWl756wJHWl6aG+mkqq48E8aBnYDyLV1lz4QzbACMzybYgMweFma1zxvXS2T?=
 =?us-ascii?Q?4EtmzlvPwgHGMzr3aSO1AY+MbLdidl5uBBxOcINVBeKS/FpdmF5PPj4dDOYV?=
 =?us-ascii?Q?ct1xr6JxWO8OvbSDOouUVXtQzkxzrS/rH6FyBbXcy3XIZc6sJThs15HBAwvs?=
 =?us-ascii?Q?XcBfiTd8WLkevlEWuODu94sxWryVU55KeloAEzOnvQUsCUWFQqLVVzBNu6nW?=
 =?us-ascii?Q?DP95oAuoqxpc+0tNdWL3AmUb0lN71eFiTMxMQ1In8T7xX6mtg9jsBgAnb72v?=
 =?us-ascii?Q?Xb30dc5CIQlKDAMkcdpeF10K/pzvVkmO19ewstj26xM1CvOxmYxxAPbvGqrh?=
 =?us-ascii?Q?8G7T5OWQTgFQAMFKSIJaR0NhYe4fMue2zlaCeDSYUZgtgOUMDP3m7hxeVDPb?=
 =?us-ascii?Q?/ehjQ6i5obmsgpUowyhKOtPwx/Q8oJPaD7KLaS9N2t4ym2hxS3ost05pLoix?=
 =?us-ascii?Q?NETjKmZLkhgAR+OIyzyw/CE/GiYDsDLe7h59Qvqzb8WdYEgMwidgMY9qmgT4?=
 =?us-ascii?Q?4tTua2UwhBMRpvB19mRDTLYHLO/H5A3uxEtnIaxRMzuVy7wFyloCZ1vZOmEc?=
 =?us-ascii?Q?Ah/BfiS4GZ5Oe8ZNwoTWNBDKSulFE4zvQZ5Ex4kW/PbB8iHbMIkJSqcv3NDi?=
 =?us-ascii?Q?XGQI1hpdJXOH4QesuLX9pHbdpwVOw3NPzZMw13u/K36iviIGn1U9Y4m1cAVF?=
 =?us-ascii?Q?Y3iZXhVGmvajhcOF5qo2q+kcIo05noOmI/KDFduDJ17oZlUpP9+Ab04/OLr8?=
 =?us-ascii?Q?4/c8Q6ZJVQlOQGDbVrLv7unt8SXEOAyasROQW8kETL1v6b1G9xl1FOzHN0y1?=
 =?us-ascii?Q?wRrXaw8eTHxUa3nS7GZ3O9Wcq96RfoYzQsOWuRhGfDyrsuWNJIPpgH4cwdKQ?=
 =?us-ascii?Q?vGVvFrJ/0cCwBEQuD1XU2YElnVCmCw+qq3QumgRcuOPZnL4f1zMCr20YQPle?=
 =?us-ascii?Q?u2Y3q7wroXPK3cOvTf9oHjPDnG7xJ3CxIuNJTOhSkRazHTDFd+NF0dBfHBqx?=
 =?us-ascii?Q?VG3RcfcWfHHXCHz6J4qFuLiAzSro1opGNM2XP0RwpkNmn94YzbDmV/DAodRv?=
 =?us-ascii?Q?lzFC8h1CdEItQw4M2AhuKQfyla8VvPo2B8XmtKj3LGln0wuQmxEV2F2iTa1M?=
 =?us-ascii?Q?Zog+hbb48go6O6O3YqzHDo1r95E5q9nskcRNigvsYG5kbcE/m64VGhNCAcTu?=
 =?us-ascii?Q?1LAq3iu9VcpiYs9xRKHK7nDWwLjj1DNzRSxTi8Pj+HiBYGv8V6+4IfDNZn5i?=
 =?us-ascii?Q?ySWljR59IopI2sK3k/mvFJ1HrrA/SYp9B5DxT60L5wxAOGThQjxHj4qDDXqN?=
 =?us-ascii?Q?aTRQhT9acrKr6r8f042HAHM6qtJ0emT+OSm5ewkeHgP4Vfx/V3yD2xbaB+BF?=
 =?us-ascii?Q?RtE/HbSMoUWNIKqf4A7Y+w1jtpsp/kT3aFluWJc8MpHRTQMV3unTaJ2iuuXa?=
 =?us-ascii?Q?Cp9nnbCrWFbncVqbRurO2GOWZHCcEMI9p1YxGe2NxmnBF9YUbwxTMOfv1Jii?=
 =?us-ascii?Q?J0BLkYTFkplH+d13YLYtI/UETp8DimJMPhHCVLKk6tz/jg3SSvUHjLaVRPaB?=
 =?us-ascii?Q?adDIoWisZR7i04UfgnU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2uH8OFRrLRW6ZfYEGLasLN18D+RNUuIQ1TD3bRRPbtYF/oW/Nt+Ud9nS+1hAQhCRsiBpPuOGu+C8nFEaBQf65VrvFXTGZ83W7ekPNqwf2kIOm7XrYUSh+Q9XmueifxHGDDkcq16rAq6dhDp1gb3W5PmfPRpjykDgmeyhf36jUcgO10lUJrMZ1xYjLBnUxdHi2L8yRy0fAfZ6M54pdBNq7rXroXUUBEdlTW9YIV0qXG9cDZAboTtYPrkNjbjtqaiWKKGKfBkVNy2zw4RhEHSlJEsYuCAIj3SrPsOxrBDpKE7W6umztdohAD80PtVQ5ewJIdLaiZcWWswTfCqV6Qa/oiC7DnqryL9o8G68EMsmpTk5jT+9w9ZvcB8lVqL1KmX7JjPsQ8ISh0Xa4ha3tMkn5jIV6YLPuFkX3Baj3IcTD52A28Sxn1JeMyoZeO7SM7BfkdobWj1Gv35NBaleZCsxs6pVKGrOwwp6qOHZFiBUJUe398Mpc8v9x09FVF/itmHuKBkjE4vWFMuqw9IZYv3coHXGVgGpi98qUuZNolMMOTkgU4mUBQEJPvutLMVh8/wlnP9T99COhjie+1ER3dN6uugV65GzTETBJzbU8D2/cIQBwokKQYzlMM8iSFjpZsSE
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fb5840-faab-41aa-4b0b-08dd520fcafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 00:36:33.9434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxbyd/SE1VZ3E6t7zpMgNTrEqxrYRNo4wKUlzlimCCZ90+c3q/8etDZgOTYeWXDAntDMH95A7Kt80DZdCkUoMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5325
X-Proofpoint-GUID: xzWnO-DxTNAXBBy6LjusxHWzLdR6DEaQ
X-Proofpoint-ORIG-GUID: xzWnO-DxTNAXBBy6LjusxHWzLdR6DEaQ
X-Sony-Outbound-GUID: xzWnO-DxTNAXBBy6LjusxHWzLdR6DEaQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01

Linux developers and users,

I'm trying to build
a system of reference value files for an initcall duration regression test =
I'm writing for the Linux kernel).

If you have a machine, or particularly any embedded dev boards (like a beag=
leplay, beaglebone (*), raspberry pi, etc.), it
would help me out a lot of you could run this tool: grab-boot-data.sh
which you can get from here: https://birdcloud.org/boot-time/Boot-time_Tool=
s

This tool grabs a bunch of information about your machine, including, most =
importantly, your boot-time
kernel messages, and sends them to me.  If this sounds too much like a secu=
rity nightmare, you
can just not heed this call, or there's an option (described on the page ab=
ove) to review the data
before you send it.

Optimally, I can get the best information if you run the tool with 'quiet' =
and 'initcall_debug' options
on the kernel command line, but if that's too hard to configure, you can ju=
st run grab-boot-data.sh with the '-s' option.
Please run the script sometime shortly after boot of your machine.

Data for any machine, running any recent kernel version, is fine (any kerne=
ls pre 4.0 are not that useful).

You will need to make up a lab name and a machine name for the machine or b=
oard you are reporting on.
I use 'tims_lab' and 'bp1' for a beagleplay in my possession.

The tool will send data to https://birdcloud.org/boot-time/Boot_Data

If you can send data for just one machine, that's great.  If for multiple m=
achines, that's even better.

I'll be reporting on the boot-time regression test at ELC in June, and any =
data I can gather in the next
few weeks will really help me with progress towards the test and my talk.

Thanks.
 -- Tim

P.S. If you see any problems running grab-boot-data.sh, please report them =
to me.  Thanks.


