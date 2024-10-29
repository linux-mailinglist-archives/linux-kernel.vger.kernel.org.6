Return-Path: <linux-kernel+bounces-386179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29BD9B4016
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598C11F221B6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989B1126BE6;
	Tue, 29 Oct 2024 02:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="S3ihsoMf";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="R2dOcoC0"
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62C41863F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 02:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730167468; cv=fail; b=rOoBTlwIYJo3bHn7x4NOtsJvLltGI2pDBZjBDogzCz8rSBwTPSeAe/V3iA041rKHF6QT8UXvkvx1ZjAX+0zOkJlxf1ykh48nHeFIiok0qBbDMBWq7b9QLlkQEhnfsFHG6buRh+qajQbCLKqB7C3bIIAw6abxoygu/mglsVlx/eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730167468; c=relaxed/simple;
	bh=1VSlgN1wEeA6OcopPfjiacaMXrPhYcE7+Xl28VZQHY0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ki18bVK/DxcrOwB6kkcBZAuCBF/XghRRlHmLMCO6RXr4E7xiJJAPQgsd1LCsHAoukSGgrqHZEiYr+3HKsmvR7/+7uv4JqFK8c8n3dS1y7703pVasrLZhWVPG67Fwk7Ljpo8C4yFLuJYqrdI72VMMQWcZrtaCaKUHmnlamwThPq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=S3ihsoMf; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=R2dOcoC0; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SKubgc025737;
	Mon, 28 Oct 2024 18:41:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=proofpoint20171006; bh=N7
	8N6qVdSXcaUEzvr6Sf4olh7OVVm9tqyifQkVvmnnU=; b=S3ihsoMfCmNqdyoUds
	0nTQF7sqKEHn51mB5RIXhD3MMKXRoup7Ud4702v57vDpuoOq3RMFL7XqJdNL5DG5
	5SHkuEzDZWgXSxahFTSmATwHnhJl+uYtZX7hsMtv+blNIFlJmU10q2nf3uKo4CwN
	sf3pWLZLqKf+vEps9sjptB3NE/C+wTNtLa4FcJvRzJMPrIPZ7scMxMB2sgUO2gGc
	R7wYRlyT6KfTVCoTFHNujWqXRiPbAK4Aotbxz88Ft2BGWnnkqMMl+DjO9Ouqr0yY
	96f246iU7clW0oosPFSnts2xuaRJwgu8B/zVP7c9aPyxfsT6qxXLyGAOMnPg7vPj
	a0fg==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013078.outbound.protection.outlook.com [40.93.6.78])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 42gyyxd17y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 18:41:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2dqsts7MZFq8c5HOqNQFNrDfqky5sdMfALCFTtINxU9BcBh8fdPwxdep4bXuKUcDztaJekSnfgJ444ZeuBcB5eIlQGBnly7WLEjArI6K4c61lboVfBhA/Hed4PT8af1sn/J7RA1qrpWk/dFv5vs7q89IxaiRCuPPY6njTtIHM1C+/37bPeUBUwLn0l0DcJC8rIJxq40y/Vh1oFSPU0lgLrhtuvCY/lHe2QiC8kzNM/CgRvIyY/0p4ofag5M2xctOcGfLKP+P6/8lCRC7jIRcIJQympewtgMS6fxD7SJj8JpSjGAluEbl7YoMTROSHaJJj1KOPaMIiNsJeWiSWo1LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N78N6qVdSXcaUEzvr6Sf4olh7OVVm9tqyifQkVvmnnU=;
 b=GkwpQ0OcNVIo6xGpD+TOKUsFIwBDvcmI34AIifD7BApZVt0XZ46jCWpUUsht5vCQz+o/Z18v5dLRhy/4VKkyEOG9Ea+hjnPPtJ5Pxt1+gWx3m46njaFWdqYSDMIUEqrsjIBFho0clU9/6aK/sr/9JIlkxrckR5SWu+9KW53efs/kuoZEDXVbHMUbL5H+osaSpwRIyRZ9REJPM54GqvcDJxbLTnOc2TyJQZtLWAmn1ru6+EOFRXCkz1RoUcZSmqSE5fyJP9316UVF6zWba2qtnNLywQMb/+K6HX4Bi0mlB4k33YYGk61E1dhHNt+HkCzLvqJYoxXdhcRNUJ5doPNMHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N78N6qVdSXcaUEzvr6Sf4olh7OVVm9tqyifQkVvmnnU=;
 b=R2dOcoC0BaBvfdZFOf/Ny6zWkmKErixRV44cCOa5gwa7MTawOAF62R6Q982s74ueQ9YpdfI0rgNEAMbZpTTZMOAqsC9SI/PwrWmtOnVydbYLTo8VqV58Mp+0HgaYJMjVrrI/IYik+I2hJCtcC+urk6GDb+ITU1zYoAv+g74TcR8h1wazY6cBUHRdsKqyX8OsrW8nHvW5v17AHZWkajAn5aSEOWHpBOpEOwOKCHDemTXgxeISW0Q+hNlZfnLD2f67yB6dFhMC/p60CdnZ+RftBKrnDcipMhAnG1p19WgTmNoLf6oaDVuCGLsoZBlu082v0edk9kOB/HxAQm/6qUoh7Q==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by SA3PR02MB10014.namprd02.prod.outlook.com
 (2603:10b6:806:380::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 01:41:19 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 01:41:19 +0000
From: Jon Kohler <jon@nutanix.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Subject: BUG_ON in Kernel 5.10.205 pick_next_rt_entity kernel/sched/rt.c:1616
Thread-Topic: BUG_ON in Kernel 5.10.205 pick_next_rt_entity
 kernel/sched/rt.c:1616
Thread-Index: AQHbKaOmXNCiavzSrEmML5og9wQ9Ng==
Date: Tue, 29 Oct 2024 01:41:19 +0000
Message-ID: <39C96BD2-7DED-4E31-BDCF-D81863D37827@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|SA3PR02MB10014:EE_
x-ms-office365-filtering-correlation-id: f833c9f0-8c81-4173-feb1-08dcf7bac974
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?91LW+AeASyPom0gKn1+U1O1geXDwKCULtR6J+SSuprCCVa4Q42Wk+LBnSG7O?=
 =?us-ascii?Q?mdDauYmCso0/Wbhi/1fxiH+dfh6L1NBqf7RlA/u2asvFx48Ui+BVFqohW0AQ?=
 =?us-ascii?Q?zY3SZiWZLDwWGbCST1tHeLUKlCH/oFKjoOXOPJqQqpr4T0/GKZQpig+Tq6hf?=
 =?us-ascii?Q?NUl9pRpVK69ctuGcI7fFSsgeimmqtjtSJ4bdR+4qSla311I+km6CYdrhzOFJ?=
 =?us-ascii?Q?YDSAvTiN1C7Sz2m+YgY+LqHUPvZOgEIXEZEnfNs5XH5pzxH+vnXL3/Mf6EbO?=
 =?us-ascii?Q?Ge9vVxzlBLpG/0v783OE93W5+qBi1ThWxe759FxygsRWpy/a4k7w2+4hM8gy?=
 =?us-ascii?Q?3VRIafmpSFbE6oYW56BlW2jDee9HtXCsEtboNvZIXqgaIYYykauRcgNB/1Ib?=
 =?us-ascii?Q?dXROW8tq6AbPZvEC2BcI7CFd54gUf5YH9k7H6B7tIpIowEOO6436pVFTGOvs?=
 =?us-ascii?Q?pwVLMGjCxbotc63u1eKUJZ4eSJlTiTFDDjFEAv4bXAvePxhtcGj6Ve8Jumy9?=
 =?us-ascii?Q?qowpAD2+4s4KIdjl+l0/bGvyIOXWz2dEQA+eR5MndQt03dwSXjat6CV4YxAy?=
 =?us-ascii?Q?MqyP6hY5YlYibxkeT+0bhRTEv7K17BcfdBjEgKy2381V1kxc97Pu3uW3w9lQ?=
 =?us-ascii?Q?p4GdNg9SAKzi08kGWFoxvLUHuzTV9x00tTWguryYLnKZVoFp6426gomUkZmX?=
 =?us-ascii?Q?2c1NArI/k1N/2MvCbbYYTiZOH6GkZIFe+rsyOps2wQ0I0EVoPrN7AYLRqEcb?=
 =?us-ascii?Q?SWKS7ZsIK44AzOfPvInYRDy8yI/PsRcLdaV/LNP/xw9C3VWYTtvuOSm76sVV?=
 =?us-ascii?Q?jT3q8pC4Wk4zwmRt8pKBsYfqXwBNLbJF0CJ4swTlWdT4ShgtHHF1MVhfk2Z/?=
 =?us-ascii?Q?6sys8fnSi3xPBZVMmJa6qBVp91DkNC7VtKjno3z42pWTpTM+0Dq8kx71D7Wz?=
 =?us-ascii?Q?eODCWAq05/peSr8dClgL6NmiduDt4xI/iy1avy/diaOFLtgxzTPpuu4USeLd?=
 =?us-ascii?Q?buAU5zMQb7I6BCYsmLLF5MQNz46eiQbsOJlmF7K9y1F0Pi02HOsbdyyiBGHy?=
 =?us-ascii?Q?sF1NYZEuYbVWwijOubtujWTeE/K2Fli3UeaaFdy7ccrYR+mJgHUFZ+exAPOi?=
 =?us-ascii?Q?GY+B16nJOG25TUm0JKDGh0SFjvAR5kMJ2os8T1au7W80y3iWRwjAQ/xLOSBm?=
 =?us-ascii?Q?3GCvJKbX0q/du8hrfNv2ISzZB2sVc8Mvzys4+fxnK472m4AxgNREu3HPdFuY?=
 =?us-ascii?Q?ki5oTIGlHSP4p7v1rDDiBkDCx5FWXG96BH4oDiWkxedY33kjB/DeNDYFpIlD?=
 =?us-ascii?Q?rHNgTKzUx87YlFkhxlvYahWXyG1ZoUW/QStuEb4ABi5aqrKcsFHlpd8Nfg3n?=
 =?us-ascii?Q?LO0IVCs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9xaWTaf9+bd5p3pyQpRkhvyYx0mwnRh9H6gEs95LKl9QO+dKICc9XFe5IXKG?=
 =?us-ascii?Q?4fgKjawK1czJu3nIyboCju3f5wEvhEojmXNLrvMaVQe+hxBM+mZQ5N18Z1yE?=
 =?us-ascii?Q?xDFcrV9hyIGmJYkLVaG66altwQG130ngpiWMjf4nB36SxwOazRRxL+uVwoZC?=
 =?us-ascii?Q?sGGPgp5MDotrw88EO1+YMQJoly1eBoRhSaR19d3Z2umjSH3C69gwXfoMtaWd?=
 =?us-ascii?Q?YEalJKYOLqrzknn+ASkBZ4Zc9VpT89ZpUN8y6lZ/D268xPQziuH2yd15ao1L?=
 =?us-ascii?Q?GMPjZQ9o06IRYRTgC2CsYR3QQnTvECwTM/zcdHRomLLmwbilBX/7jifjueTI?=
 =?us-ascii?Q?aV/JreVIH5xzPPZsk3xqCYrz867T6eF5h6Ng/QQUly/NuwyA7r425E6ZKipl?=
 =?us-ascii?Q?jJbqrjc01GPg/g2Yx/6sjt7A4jLpH7b67xyN0jdzv8eSsD4irL+0LNACDMR7?=
 =?us-ascii?Q?5DhsoeUiQc7uyBTIF7ke+ov8YU8v+mt8ECndYaPkq/Dgvs7MkBAv/PNYgbvu?=
 =?us-ascii?Q?TQrgFpTgOOZzxuC+CWalZYAqFMMHRCaEBXchnRvdP9QhUGRjAWikXz5MEScM?=
 =?us-ascii?Q?kXY8289L12A8gbYkeKGMKljgKL8QikkQJxkJLOYfKEXmTyAz86ZyAA+EQtMz?=
 =?us-ascii?Q?TUMdXSjvGRhwi8uVDtTypQsXK6IEjM9Xi4/BL7RHHb/h/ksBX1QYwT8sYDBM?=
 =?us-ascii?Q?YcDxzIydroq1QLnX8f1b8boS1ZwkXlUFmCL6XkVVWh8FgL+2qUDDYyWid7S0?=
 =?us-ascii?Q?Sk8/rC+YwlQCnVt1Jwp8x3/JwULBbQhHHaY61KgjwS7gIJKiPlclLzkbFvCo?=
 =?us-ascii?Q?eUDRaGVpVJ0L1vvVE+buEp0yMzYayN/Q0/zFVyW7hOD4ESuuaBnzAZmsmQjI?=
 =?us-ascii?Q?ThkRGn46Bwy4lQ/HLwg8RHe/PSDYihz/3Q86RJ7oHBEhAVRzt6gTm5B2nsDC?=
 =?us-ascii?Q?1+YGmctk58J+NXd8/blJ729bhziM6c+LlsTW1SdKYLgbBcjNkBwulXDhyyT3?=
 =?us-ascii?Q?tC2ZzcK+yzh0258nOPNiDLHWUOSYmnu5bnbfVAGi98J+BPThsmHjNrdzFxFe?=
 =?us-ascii?Q?I3GK7Hpa8GT2DLfd+mTeNiCR0MUpoGUsRIcUsT5A7V3LadkxbscmCxxRyS7l?=
 =?us-ascii?Q?n6f9wvrCR4W+srsnV9NZWiIiMLbfjKPmvO+Nb9+Zye/bngegJjtj9vNSQQXt?=
 =?us-ascii?Q?LYdCthkm2erw3dhoZ/lPV2MxC1ajSI4EUD8rLbul7kWkr8LUWkpvOlzbuP1C?=
 =?us-ascii?Q?IJAwM8QJiqGpEMlSg42kXYw/+u8+pE5tIocP8RuDdwAx8aEoKgxN0MJ49hVd?=
 =?us-ascii?Q?VBX9GO2DfQOjDHast6syxo1yIfSd3XZRBueE6T6eSZ9iyEdonPH5JT9rqfWs?=
 =?us-ascii?Q?Jx9xrASTQGTvPkXNvaJue52rSs25VfMlyxlrGI27EYTXCYCifOqWdJsf9cBW?=
 =?us-ascii?Q?0CahiXlqDuA/EZSgpRPKuqxQgHrg4c3gTVI3rk8XdXAkRXi+MZKzSiQz2XxQ?=
 =?us-ascii?Q?rrCs41VI2xZmL6Ox/pIX6QfiYK0ACLq+LknEtBomQPgTCwCPD7zHI40k5qt+?=
 =?us-ascii?Q?wLo9/QDyH9NaW/JQCKpav0m16B0Nuwkm3e60Co+QamYDY6FM1T+ibEP2+Tr9?=
 =?us-ascii?Q?VZDdh4+VYQkjEDF4oKE97EUwJAiNJjsl7Dft9SNH+VyHSSE691EyU6GZprqQ?=
 =?us-ascii?Q?vme4pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C627C4EED5C52B4E9E6B41FE28A27DC7@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f833c9f0-8c81-4173-feb1-08dcf7bac974
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 01:41:19.5543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: diX0hDTPTYAjMsYZfa7PCwCvlBXRGOAuxSPsZeaRGziP08uvgmEsNgT4Lwd6FNZBhQm481nkTzFetZ5QV1Hia+xskDZ4Y06KPxQFfPdG3h8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB10014
X-Proofpoint-GUID: JjWZdJ7n42-9Y3lM4Hypa5EggISUvCoa
X-Authority-Analysis: v=2.4 cv=PfethThd c=1 sm=1 tr=0 ts=67203d43 cx=c_pps a=BALyy5icRfvvzfOMzojctg==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=DAUX931o1VcA:10 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10 a=fOlSF1HVpDTeqFd188gA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: JjWZdJ7n42-9Y3lM4Hypa5EggISUvCoa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_12,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Reason: safe

Hi all, reaching out with a bug report for a kernel BUG_ON assert
with version 5.10.205.

The crash occurs at BUG_ON(idx >=3D MAX_RT_PRIO).

We've been encountering the following rt.c crash within our fleet and
are having a difficult time reproducing it in a targeted manner.=20
However, we see these crashes and core dumps with a fair frequency
across fleet machines.

I did a spot check of 5.10.205 vs 5.10.223 and did not see any commits
into rt.c since .205 that appear to address this issue, so I believe
we'd also see this issue in 5.10.223.

This particular fleet runs a collection of processes with various RT
priorities. This crash appears to be correlated with a moderate, but
not extreme, amount of load when there is context switching between one
group of threads with RT priority 10 and another with RT priority 5.

We have primarily seen the assert trigger when RT priority is 5. That
said, we've seen this trigger when the current process has both RT
priority 10 and RT priority 0 in the case of the provided crash data
below.

I do not think the absolute value of priority 10 or 5 is causal, but
it may contribute to the rate at which this can trigger.

I've included various excerpts from the core dump below, but there are
definitely some oddities here that have us scratching our heads.

Namely, to get to this assert, the call chain roughly needs to look
like this in the most minimal way:

pick_next_task_rt
   sched_rt_runnable =3D=3D true (i.e. rq->rt.rt_queued > 0)
       // NOTE: in all of the crash dumps I've analyzed on this issue
       // rt_queued seems to consistently be zero (0) by the time the
       // crash dump records the value.
       // This is odd because this would indicated that we shouldn't
       // have taken this branch at all, but yet we did.
   _pick_next_task_rt
       pick_next_rt_entity
           idx =3D sched_find_first_bit(array->bitmap);
           BUG_ON(idx >=3D MAX_RT_PRIO); <<< this must be 100 or higher
               // NOTE: value of bitmap at this point in crash dump is
               // bitmap =3D {0, 68719476736}.

Based on the value of rt_queued being zero at crash dump time, but must
be 1 or higher at runtime, we thought there might be some sort of=20
mem barrier issue, locking, or other data race, so we did run with both
lockdep and kcsan for extended periods, but were unable to have that
machinery pick up the issue here.

Past that:
The general fingerprint here is that we see highest_prio.curr =3D=3D 100,
and based on one of the crash dump analysis, we believe there is the
possibility that this value of 100 will flow into set_bit for array
bitmap in such a way that the only valid value at the time of the
assert in question may be 100, causing the assert to fire.

Note, we do see that in 5.11, there appears to be an unrelated commit
that would have clamped setting highest_prio.curr to MAX_RT_PRIO-1:

Patch in question with related commits
b13772f8135 sched/cpupri: Add CPUPRI_HIGHER
934fc3314b3 sched/cpupri: Remap CPUPRI_NORMAL to MAX_RT_PRIO-1 <<< patch in=
 question
1b08782ce31 sched/cpupri: Remove pri_to_cpu[1]
5e054bca44f sched/cpupri: Remove pri_to_cpu[CPUPRI_IDLE]

I believe that clamping the MAX_RT_PRIO with the patch series above
should plug this pinhole-esque bug, and would love any ideas anyone
on the list has on how I might be able to minimize such reproduction to
tickle this assert in a more narrow way (its been driving me nuts!)

Thank you for your help in advance,
Jon Kohler

// Possible callchain on how we might get highest_prio.curr to be 100
// and have that flow into array->bitmap
futex_wait
  futex_wait_queue_me
      schedule
          __schedule
              prev =3D rq->curr;
              rq_lock(rq, &rf);
              smp_mb__after_spinlock();
              if (!preempt && prev->state && !signal_pending_state)
                  deactivate_task(rq, prev);
              next =3D pick_next_task(rq, prev, &rf); // We're dying here
                  // Switch to call chain below


core.c -> pick_next_task
  put_prev_task_balance(rq, prev, rf);=20
    // Possibly runs pull_rt_task, which with NO_RT_PUSH_IPI can=20
    // activate_task() on current CPU RQ
    // Switch to call chain below, specifically to activate_task
    // HOWEVER, we have seen this issue with BOTH RT_PUSH_IPI and
    // NO_RT_PUSH_IPI

Call from either enqueue_rt_entity or dequeue_rt_entity
  activate_task
  deactivate_task
      dequeue_rt_stack
          __dequeue_rt_entity
              rt_se->on_rq =3D 0;
              dec_rt_tasks
                  // Decrements rt_nr_running and rr_nr_running to zero
                  dec_rt_prio
                      if (rt_rq->rt_nr_running =3D=3D 0)
                          rt_rq->highest_prio.curr =3D MAX_RT_PRIO; // 100
                          // This is fixed in 5.11 as noted in analysis
                  dec_rt_migration
                      rt_nr_total--;
                      rt_nr_migratory--;
                      update_rt_migration=20

  // Call from enqueue_rt_entity
  for_each_sched_rt_entity(rt_se)
      __enqueue_rt_entity(rt_se, flags);
          // See call chain below where highest_prio.curr could be set to 1=
00

__enqueue_rt_entity
  if (move_entity(flags))
      __set_bit(rt_rq->highest_prio.curr, array->bitmap);
          // This may potentially set bit to 100 if highest_prio.curr =3D=
=3D 100,
          // which is what we see in crash dump
      WARN_ON(!rt_prio(prio)); // We've seen this warning fire
  // Switch back to core.c -> pick_next_task call chain below


core.c -> pick_next_task
  // Return from balance_rt and pull_rt_task + activate_task
  class->pick_next_task(rq) // We eventually die in here
      pick_next_task_rt
          if (!sched_rt_runnable(rq)) // rq->rt.rt_queued > 0 =3D=3D true
              return NULL;
              // Note: we proceed so this must be observed at 1 > 0 at runt=
ime
              // But in the crash dump we see this as zero.
          _pick_next_task_rt
              pick_next_rt_entity
                  idx =3D sched_find_first_bit(array->bitmap);
                  BUG_ON(idx >=3D MAX_RT_PRIO); // We die here as idx >=3D =
100

// CRASH EXCERPTS //
crash> bt
PID: 0      TASK: ffff8d2b402d1640  CPU: 8   COMMAND: "swapper/8"
#0 [ffffa63ec00b7bb8] machine_kexec at ffffffffb005440b
#1 [ffffa63ec00b7c10] __crash_kexec at ffffffffb01236fa
#2 [ffffa63ec00b7cd0] crash_kexec at ffffffffb0124501
#3 [ffffa63ec00b7ce8] oops_end at ffffffffb002e268
#4 [ffffa63ec00b7d08] do_trap at ffffffffb002af05
#5 [ffffa63ec00b7d50] do_error_trap at ffffffffb002b034
#6 [ffffa63ec00b7d90] exc_invalid_op at ffffffffb0b4cfbc
#7 [ffffa63ec00b7db0] asm_exc_invalid_op at ffffffffb0c00ae2
   [exception RIP: pick_next_task_rt+110]
   RIP: ffffffffb00c0d4e  RSP: ffffa63ec00b7e68  RFLAGS: 00010002
   RAX: 0000000000000064  RBX: ffff8d36efc2f400  RCX: 0000000000000000
   RDX: ffff8d36efc2f640  RSI: ffff8d2b402d1640  RDI: ffff8d36efc2f400
   RBP: ffff8d36efc2f400   R8: 00044d8c1d8cde4d   R9: ffff8d2b40242148
   R10: 0000000000000000  R11: ffffa63ec2c27e80  R12: ffff8d2b402d1640
   R13: 0000000000000000  R14: ffff8d36efc2f400  R15: ffff8d2b402d1c90
   ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
#8 [ffffa63ec00b7e80] __schedule at ffffffffb0b58a1b
#9 [ffffa63ec00b7ee0] schedule_idle at ffffffffb0b58ede
#10 [ffffa63ec00b7ee8] do_idle at ffffffffb00b0e9e
#11 [ffffa63ec00b7f28] cpu_startup_entry at ffffffffb00b10c9
#12 [ffffa63ec00b7f38] start_secondary at ffffffffb004a2d7
#13 [ffffa63ec00b7f50] secondary_startup_64_no_verify at ffffffffb00000f5

KERNEL: ... 5.10.205 ...
DUMPFILE: ...
   CPUS: 16
   DATE: Sun Oct 27 13:23:00 UTC 2024
 UPTIME: 13 days, 16:43:10
LOAD AVERAGE: 31.53, 32.69, 29.71
  TASKS: 2013
NODENAME: ...
RELEASE: ... 5.10.205 ...
VERSION: #1 SMP Wed Jun 19 04:58:21 UTC 2024
MACHINE: x86_64  (4093 Mhz)
 MEMORY: 48 GB
  PANIC: "kernel BUG at kernel/sched/rt.c:1616!"
    PID: 0
COMMAND: "swapper/8"
   TASK: ffff8d2b402d1640  (1 of 16)  [THREAD_INFO: ffff8d2b402d1640]
    CPU: 8
  STATE: TASK_RUNNING (PANIC)

crash> struct task_struct ffff8d2b402d1640
struct task_struct {
 thread_info =3D {
   flags =3D 16520,=20
   status =3D 0
 },=20
 state =3D 0,=20
 stack =3D 0xffffa63ec00b4000,=20
 usage =3D {
   refs =3D {
     counter =3D 1
   }
 },=20
 flags =3D 2097218,=20
 ptrace =3D 0,=20
 on_cpu =3D 1,=20
 wake_entry =3D {
   llist =3D {
     next =3D 0x0
   },=20
   {
     u_flags =3D 48,=20
     a_flags =3D {
       counter =3D 48
     }
   },=20
   src =3D 0,=20
   dst =3D 0
 },=20
 cpu =3D 8,=20
 wakee_flips =3D 2,=20
 wakee_flip_decay_ts =3D 5478057266,=20
 last_wakee =3D 0xffff8d340ccf2c80,=20
 recent_used_cpu =3D 8,=20
 wake_cpu =3D 8,=20
 on_rq =3D 1,=20
 prio =3D 120,=20
 static_prio =3D 120,=20
 normal_prio =3D 120,=20
 rt_priority =3D 0,=20
 sched_class =3D 0xffffffffb17c60e0,=20
 se =3D {
   load =3D {
     weight =3D 1048576,=20
     inv_weight =3D 4194304
   },=20
   run_node =3D {
     __rb_parent_color =3D 1,=20
     rb_right =3D 0x0,=20
     rb_left =3D 0x0
   },=20
   group_node =3D {
     next =3D 0xffff8d2b402d16e8,=20
     prev =3D 0xffff8d2b402d16e8
   },=20
   on_rq =3D 0,=20
   exec_start =3D 260043972,=20
   sum_exec_runtime =3D 0,=20
   vruntime =3D 0,=20
   prev_sum_exec_runtime =3D 0,=20
   nr_migrations =3D 0,=20
   statistics =3D {
     wait_start =3D 0,=20
     wait_max =3D 0,=20
     wait_count =3D 0,=20
     wait_sum =3D 0,=20
     iowait_count =3D 0,=20
     iowait_sum =3D 0,=20
     sleep_start =3D 0,=20
     sleep_max =3D 0,=20
     sum_sleep_runtime =3D 0,=20
     block_start =3D 0,=20
     block_max =3D 0,=20
     exec_max =3D 0,=20
     slice_max =3D 0,=20
     nr_migrations_cold =3D 0,=20
     nr_failed_migrations_affine =3D 0,=20
     nr_failed_migrations_running =3D 0,=20
     nr_failed_migrations_hot =3D 0,=20
     nr_forced_migrations =3D 0,=20
     nr_wakeups =3D 0,=20
     nr_wakeups_sync =3D 0,=20
     nr_wakeups_migrate =3D 0,=20
     nr_wakeups_local =3D 0,=20
     nr_wakeups_remote =3D 0,=20
     nr_wakeups_affine =3D 0,=20
     nr_wakeups_affine_attempts =3D 0,=20
     nr_wakeups_passive =3D 0,=20
     nr_wakeups_idle =3D 0
   },=20
   depth =3D 0,=20
   parent =3D 0x0,=20
   cfs_rq =3D 0xffff8d36efc2f480,=20
   my_q =3D 0x0,=20
   runnable_weight =3D 0,=20
   avg =3D {
     last_update_time =3D 0,=20
     load_sum =3D 0,=20
     runnable_sum =3D 0,=20
     util_sum =3D 0,=20
     period_contrib =3D 0,=20
     load_avg =3D 1024,=20
     runnable_avg =3D 0,=20
     util_avg =3D 0,=20
     util_est =3D {
       enqueued =3D 0,=20
       ewma =3D 0
     }
   }
 },=20
 rt =3D {
   run_list =3D {
     next =3D 0xffff8d2b402d1880,=20
     prev =3D 0xffff8d2b402d1880
   },=20
   timeout =3D 0,=20
   watchdog_stamp =3D 0,=20
   time_slice =3D 100,=20
   on_rq =3D 0,=20
   on_list =3D 0,=20
   back =3D 0x0,=20
   parent =3D 0x0,=20
   rt_rq =3D 0xffff8d36efc2f640,=20
   my_q =3D 0x0
 },=20
 sched_task_group =3D 0xffffffffb2b49240,=20
 dl =3D {
   rb_node =3D {
     __rb_parent_color =3D 18446617815632648400,=20
     rb_right =3D 0x0,=20
     rb_left =3D 0x0
   },=20
   dl_runtime =3D 0,=20
   dl_deadline =3D 0,=20
   dl_period =3D 0,=20
   dl_bw =3D 0,=20
   dl_density =3D 0,=20
   runtime =3D 0,=20
   deadline =3D 0,=20
   flags =3D 0,=20
   dl_throttled =3D 0,=20
   dl_yielded =3D 0,=20
   dl_non_contending =3D 0,=20
   dl_overrun =3D 0,=20
   dl_timer =3D {
     node =3D {
       node =3D {
         __rb_parent_color =3D 18446617815632648488,=20
         rb_right =3D 0x0,=20
         rb_left =3D 0x0
       },=20
       expires =3D 0
     },=20
     _softexpires =3D 0,=20
     function =3D 0xffffffffb00c6fd0,=20
     base =3D 0xffff8d36efa22b00,=20
     state =3D 0 '\000',=20
     is_rel =3D 0 '\000',=20
     is_soft =3D 0 '\000',=20
     is_hard =3D 1 '\001'
   },=20
   inactive_timer =3D {
     node =3D {
       node =3D {
         __rb_parent_color =3D 18446617815632648552,=20
         rb_right =3D 0x0,=20
         rb_left =3D 0x0
       },=20
       expires =3D 0
     },=20
     _softexpires =3D 0,=20
     function =3D 0xffffffffb00c5280,=20
     base =3D 0xffff8d36efa22b00,=20
     state =3D 0 '\000',=20
     is_rel =3D 0 '\000',=20
     is_soft =3D 0 '\000',=20
     is_hard =3D 1 '\001'
   },=20
   pi_se =3D 0xffff8d2b402d18d0
 },=20
 preempt_notifiers =3D {
   first =3D 0x0
 },=20
 btrace_seq =3D 0,=20
 policy =3D 0,=20
 nr_cpus_allowed =3D 1,=20
 cpus_ptr =3D 0xffff8d2b402d19d0,=20
 cpus_mask =3D {
   bits =3D {256, 0, 0, 0}
 },=20
 trc_reader_nesting =3D 0,=20
 trc_ipi_to_cpu =3D 0,=20
 trc_reader_special =3D {
   b =3D {
     blocked =3D 0 '\000',=20
     need_qs =3D 0 '\000',=20
     exp_hint =3D 0 '\000',=20
     need_mb =3D 0 '\000'
   },=20
   s =3D 0
 },=20
 trc_reader_checked =3D true,=20
 trc_holdout_list =3D {
   next =3D 0xffff8d2b402d1a00,=20
   prev =3D 0xffff8d2b402d1a00
 },=20
 sched_info =3D {
   pcount =3D 0,=20
   run_delay =3D 0,=20
   last_arrival =3D 0,=20
   last_queued =3D 0
 },=20
 tasks =3D {
   next =3D 0xffff8d2b40249a30,=20
   prev =3D 0xffffffffb1c13d30
 },=20
 pushable_tasks =3D {
   prio =3D 140,=20
   prio_list =3D {
     next =3D 0xffff8d2b402d1a48,=20
     prev =3D 0xffff8d2b402d1a48
   },=20
   node_list =3D {
     next =3D 0xffff8d2b402d1a58,=20
     prev =3D 0xffff8d2b402d1a58
   }
 },=20
 pushable_dl_tasks =3D {
   __rb_parent_color =3D 18446617815632648808,=20
   rb_right =3D 0x0,=20
   rb_left =3D 0x0
 },=20
 mm =3D 0x0,=20
 active_mm =3D 0xffff8d2bab11b300,=20
 vmacache =3D {
   seqnum =3D 0,=20
   vmas =3D {0x0, 0x0, 0x0, 0x0}
 },=20
 rss_stat =3D {
   events =3D 0,=20
   count =3D {0, 0, 0, 0}
 },=20
 exit_state =3D 0,=20
 exit_code =3D 0,=20
 exit_signal =3D 0,=20
 pdeath_signal =3D 0,=20
 jobctl =3D 0,=20
 personality =3D 0,=20
 sched_reset_on_fork =3D 0,=20
 sched_contributes_to_load =3D 1,=20
 sched_migrated =3D 0,=20
 sched_remote_wakeup =3D 0,=20
 in_execve =3D 0,=20
 in_iowait =3D 0,=20
 restore_sigmask =3D 0,=20
 in_user_fault =3D 0,=20
 no_cgroup_migration =3D 0,=20
 frozen =3D 0,=20
 use_memdelay =3D 0,=20
 atomic_flags =3D 0,=20
 restart_block =3D {
   fn =3D 0xffffffffb0084800,=20
   {
     futex =3D {
       uaddr =3D 0x0,=20
       val =3D 0,=20
       flags =3D 0,=20
       bitset =3D 0,=20
       time =3D 0,=20
       uaddr2 =3D 0x0
     },=20
     nanosleep =3D {
       clockid =3D 0,=20
       type =3D TT_NONE,=20
       {
         rmtp =3D 0x0,=20
         compat_rmtp =3D 0x0
       },=20
       expires =3D 0
     },=20
     poll =3D {
       ufds =3D 0x0,=20
       nfds =3D 0,=20
       has_timeout =3D 0,=20
       tv_sec =3D 0,=20
       tv_nsec =3D 0
     }
   }
 },=20
 pid =3D 0,=20
 tgid =3D 0,=20
 stack_canary =3D 11200344866084499968,=20
 real_parent =3D 0xffff8d2b40248000,=20
 parent =3D 0xffffffffb1c13940,=20
 children =3D {
   next =3D 0xffff8d2b402d1b50,=20
   prev =3D 0xffff8d2b402d1b50
 },=20
 sibling =3D {
   next =3D 0xffff8d2b402d1b60,=20
   prev =3D 0xffff8d2b402d1b60
 },=20
 group_leader =3D 0xffff8d2b402d1640,=20
 ptraced =3D {
   next =3D 0xffff8d2b40248538,=20
   prev =3D 0xffff8d2b40248538
 },=20
 ptrace_entry =3D {
   next =3D 0xffff8d2b40248548,=20
   prev =3D 0xffff8d2b40248548
 },=20
 thread_pid =3D 0xffffffffb1c49180,=20
 pid_links =3D {{
     next =3D 0x0,=20
     pprev =3D 0x0
   }, {
     next =3D 0x0,=20
     pprev =3D 0x0
   }, {
     next =3D 0x0,=20
     pprev =3D 0x0
   }, {
     next =3D 0x0,=20
     pprev =3D 0x0
   }},=20
 thread_group =3D {
   next =3D 0xffff8d2b402d1be0,=20
   prev =3D 0xffff8d2b402d1be0
 },=20
 thread_node =3D {
   next =3D 0xffff8d2b4026de90,=20
   prev =3D 0xffff8d2b4026de90
 },=20
 vfork_done =3D 0x0,=20
 set_child_tid =3D 0x0,=20
 clear_child_tid =3D 0x0,=20
 pf_io_worker =3D 0x0,=20
 utime =3D 0,=20
 stime =3D 28532720612,=20
 gtime =3D 0,=20
 prev_cputime =3D {
   utime =3D 0,=20
   stime =3D 0,=20
   lock =3D {
     raw_lock =3D {
       {
         val =3D {
           counter =3D 0
         },=20
         {
           locked =3D 0 '\000',=20
           pending =3D 0 '\000'
         },=20
         {
           locked_pending =3D 0,=20
           tail =3D 0
         }
       }
     }
   }
 },=20
 vtime =3D {
   seqcount =3D {
     sequence =3D 2
   },=20
   starttime =3D 260044102,=20
   state =3D VTIME_IDLE,=20
   cpu =3D 8,=20
   utime =3D 0,=20
   stime =3D 0,=20
   gtime =3D 0
 },=20
 tick_dep_mask =3D {
   counter =3D 0
 },=20
 nvcsw =3D 0,=20
 nivcsw =3D 4848458348,=20
 start_time =3D 104691263,=20
 start_boottime =3D 104691263,=20
 min_flt =3D 0,=20
 maj_flt =3D 0,=20
 posix_cputimers =3D {
   bases =3D {{
       nextevt =3D 18446744073709551615,=20
       tqhead =3D {
         rb_root =3D {
           rb_root =3D {
             rb_node =3D 0x0
           },=20
           rb_leftmost =3D 0x0
         }
       }
     }, {
       nextevt =3D 18446744073709551615,=20
       tqhead =3D {
         rb_root =3D {
           rb_root =3D {
             rb_node =3D 0x0
           },=20
           rb_leftmost =3D 0x0
         }
       }
     }, {
       nextevt =3D 18446744073709551615,=20
       tqhead =3D {
         rb_root =3D {
           rb_root =3D {
             rb_node =3D 0x0
           },=20
           rb_leftmost =3D 0x0
         }
       }
     }},=20
   timers_active =3D 0,=20
   expiry_active =3D 0
 },=20
 posix_cputimers_work =3D {
   work =3D {
     next =3D 0x0,=20
     func =3D 0xffffffffb010ca70
   },=20
   mutex =3D {
     owner =3D {
       counter =3D 0
     },=20
     wait_lock =3D {
       {
         rlock =3D {
           raw_lock =3D {
             {
               val =3D {
                 counter =3D 0
               },=20
               {
                 locked =3D 0 '\000',=20
                 pending =3D 0 '\000'
               },=20
               {
                 locked_pending =3D 0,=20
                 tail =3D 0
               }
             }
           }
         }
       }
     },=20
     osq =3D {
       tail =3D {
         counter =3D 0
       }
     },=20
     wait_list =3D {
       next =3D 0xffff8d2b402d1d28,=20
       prev =3D 0xffff8d2b402d1d28
     }
   },=20
   scheduled =3D 0
 },=20
 ptracer_cred =3D 0x0,=20
 real_cred =3D 0xffff8d2b40250fc0,=20
 cred =3D 0xffff8d2b40250fc0,=20
 cached_requested_key =3D 0x0,=20
 comm =3D "swapper/8\000\000\000\000\000\000",=20
 nameidata =3D 0x0,=20
 sysvsem =3D {
   undo_list =3D 0x0
 },=20
 sysvshm =3D {
   shm_clist =3D {
     next =3D 0xffff8d2b402d1d80,=20
     prev =3D 0xffff8d2b402d1d80
   }
 },=20
 last_switch_count =3D 0,=20
 last_switch_time =3D 0,=20
 fs =3D 0xffff8d2b402871c0,=20
 files =3D 0xffff8d2b40259600,=20
 io_uring =3D 0x0,=20
 nsproxy =3D 0xffffffffb1c49460,=20
 signal =3D 0xffff8d2b4026de80,=20
 sighand =3D 0xffff8d2b402cb180,=20
 blocked =3D {
   sig =3D {0}
 },=20
 real_blocked =3D {
   sig =3D {0}
 },=20
 saved_sigmask =3D {
   sig =3D {0}
 },=20
 pending =3D {
   list =3D {
     next =3D 0xffff8d2b402d1de8,=20
     prev =3D 0xffff8d2b402d1de8
   },=20
   signal =3D {
     sig =3D {0}
   }
 },=20
 sas_ss_sp =3D 0,=20
 sas_ss_size =3D 0,=20
 sas_ss_flags =3D 2,=20
 task_works =3D 0x0,=20
 audit_context =3D 0xffff8d2b4012e800,=20
 loginuid =3D {
   val =3D 4294967295
 },=20
 sessionid =3D 4294967295,=20
 seccomp =3D {
   mode =3D 0,=20
   filter_count =3D {
     counter =3D 0
   },=20
   filter =3D 0x0
 },=20
 parent_exec_id =3D 0,=20
 self_exec_id =3D 0,=20
 alloc_lock =3D {
   {
     rlock =3D {
       raw_lock =3D {
         {
           val =3D {
             counter =3D 0
           },=20
           {
             locked =3D 0 '\000',=20
             pending =3D 0 '\000'
           },=20
           {
             locked_pending =3D 0,=20
             tail =3D 0
           }
         }
       }
     }
   }
 },=20
 pi_lock =3D {
   raw_lock =3D {
     {
       val =3D {
         counter =3D 0
       },=20
       {
         locked =3D 0 '\000',=20
         pending =3D 0 '\000'
       },=20
       {
         locked_pending =3D 0,=20
         tail =3D 0
       }
     }
   }
 },=20
 wake_q =3D {
   next =3D 0x0
 },=20
 pi_waiters =3D {
   rb_root =3D {
     rb_node =3D 0x0
   },=20
   rb_leftmost =3D 0x0
 },=20
 pi_top_task =3D 0x0,=20
 pi_blocked_on =3D 0x0,=20
 journal_info =3D 0x0,=20
 bio_list =3D 0x0,=20
 plug =3D 0x0,=20
 reclaim_state =3D 0x0,=20
 backing_dev_info =3D 0x0,=20
 io_context =3D 0x0,=20
 capture_control =3D 0x0,=20
 ptrace_message =3D 0,=20
 last_siginfo =3D 0x0,=20
 ioac =3D {
   rchar =3D 0,=20
   wchar =3D 0,=20
   syscr =3D 0,=20
   syscw =3D 0,=20
   read_bytes =3D 0,=20
   write_bytes =3D 0,=20
   cancelled_write_bytes =3D 0
 },=20
 acct_rss_mem1 =3D 0,=20
 acct_vm_mem1 =3D 0,=20
 acct_timexpd =3D 0,=20
 mems_allowed =3D {
   bits =3D {1, 0}
 },=20
 mems_allowed_seq =3D {
   seqcount =3D {
     sequence =3D 0
   }
 },=20
 cpuset_mem_spread_rotor =3D -1,=20
 cpuset_slab_spread_rotor =3D -1,=20
 cgroups =3D 0xffffffffb235ff60,=20
 cg_list =3D {
   next =3D 0xffff8d2b402d1f40,=20
   prev =3D 0xffff8d2b402d1f40
 },=20
 robust_list =3D 0x0,=20
 compat_robust_list =3D 0x0,=20
 pi_state_list =3D {
   next =3D 0xffff8d2b402d1f60,=20
   prev =3D 0xffff8d2b402d1f60
 },=20
 pi_state_cache =3D 0x0,=20
 futex_exit_mutex =3D {
   owner =3D {
     counter =3D 0
   },=20
   wait_lock =3D {
     {
       rlock =3D {
         raw_lock =3D {
           {
             val =3D {
               counter =3D 0
             },=20
             {
               locked =3D 0 '\000',=20
               pending =3D 0 '\000'
             },=20
             {
               locked_pending =3D 0,=20
               tail =3D 0
             }
           }
         }
       }
     }
   },=20
   osq =3D {
     tail =3D {
       counter =3D 0
     }
   },=20
   wait_list =3D {
     next =3D 0xffff8d2b402d1f88,=20
     prev =3D 0xffff8d2b402d1f88
   }
 },=20
 futex_state =3D 0,=20
 perf_event_ctxp =3D {0x0, 0x0},=20
 perf_event_mutex =3D {
   owner =3D {
     counter =3D 0
   },=20
   wait_lock =3D {
     {
       rlock =3D {
         raw_lock =3D {
           {
             val =3D {
               counter =3D 0
             },=20
             {
               locked =3D 0 '\000',=20
               pending =3D 0 '\000'
             },=20
             {
               locked_pending =3D 0,=20
               tail =3D 0
             }
           }
         }
       }
     }
   },=20
   osq =3D {
     tail =3D {
       counter =3D 0
     }
   },=20
   wait_list =3D {
     next =3D 0xffff8d2b402d1fc0,=20
     prev =3D 0xffff8d2b402d1fc0
   }
 },=20
 perf_event_list =3D {
   next =3D 0xffff8d2b402d1fd0,=20
   prev =3D 0xffff8d2b402d1fd0
 },=20
 mempolicy =3D 0xffff8d2b401f1140,=20
 il_prev =3D 0,=20
 pref_node_fork =3D 0,=20
 numa_scan_seq =3D 0,=20
 numa_scan_period =3D 1000,=20
 numa_scan_period_max =3D 0,=20
 numa_preferred_nid =3D -1,=20
 numa_migrate_retry =3D 0,=20
 node_stamp =3D 0,=20
 last_task_numa_placement =3D 0,=20
 last_sum_exec_runtime =3D 0,=20
 numa_work =3D {
   next =3D 0xffff8d2b402d2020,=20
   func =3D 0xffffffffb00b2aa0
 },=20
 numa_group =3D 0x0,=20
 numa_faults =3D 0x0,=20
 total_numa_faults =3D 0,=20
 numa_faults_locality =3D {0, 0, 0},=20
 numa_pages_migrated =3D 0,=20
 rseq =3D 0x0,=20
 rseq_sig =3D 0,=20
 rseq_event_mask =3D 5,=20
 tlb_ubc =3D {
   arch =3D {
     cpumask =3D {
       bits =3D {0, 0, 0, 0}
     }
   },=20
   flush_required =3D false,=20
   writable =3D false
 },=20
 {
   rcu_users =3D {
     refs =3D {
       counter =3D 2
     }
   },=20
   rcu =3D {
     next =3D 0x2,=20
     func =3D 0x0
   }
 },=20
 splice_pipe =3D 0x0,=20
 task_frag =3D {
   page =3D 0x0,=20
   offset =3D 0,=20
   size =3D 0
 },=20
 delays =3D 0xffff8d2b401f76e0,=20
 nr_dirtied =3D 0,=20
 nr_dirtied_pause =3D 32,=20
 dirty_paused_when =3D 0,=20
 timer_slack_ns =3D 50000,=20
 default_timer_slack_ns =3D 50000,=20
 curr_ret_stack =3D -1,=20
 curr_ret_depth =3D -1,=20
 ret_stack =3D 0x0,=20
 ftrace_timestamp =3D 0,=20
 trace_overrun =3D {
   counter =3D 0
 },=20
 tracing_graph_pause =3D {
   counter =3D 0
 },=20
 trace =3D 0,=20
 trace_recursion =3D 0,=20
 memcg_in_oom =3D 0x0,=20
 memcg_oom_gfp_mask =3D 0,=20
 memcg_oom_order =3D 0,=20
 memcg_nr_pages_over_high =3D 0,=20
 active_memcg =3D 0x0,=20
 throttle_queue =3D 0x0,=20
 utask =3D 0x0,=20
 pagefault_disabled =3D 0,=20
 oom_reaper_list =3D 0x0,=20
 oom_reaper_timer =3D {
   entry =3D {
     next =3D 0x0,=20
     pprev =3D 0x0
   },=20
   expires =3D 0,=20
   function =3D 0x0,=20
   flags =3D 0
 },=20
 stack_vm_area =3D 0xffff8d2b40256f40,=20
 stack_refcount =3D {
   refs =3D {
     counter =3D 1
   }
 },=20
 security =3D 0x0,=20
 thread =3D {
   tls_array =3D {{
       limit0 =3D 0,=20
       base0 =3D 0,=20
       base1 =3D 0,=20
       type =3D 0,=20
       s =3D 0,=20
       dpl =3D 0,=20
       p =3D 0,=20
       limit1 =3D 0,=20
       avl =3D 0,=20
       l =3D 0,=20
       d =3D 0,=20
       g =3D 0,=20
       base2 =3D 0
     }, {
       limit0 =3D 0,=20
       base0 =3D 0,=20
       base1 =3D 0,=20
       type =3D 0,=20
       s =3D 0,=20
       dpl =3D 0,=20
       p =3D 0,=20
       limit1 =3D 0,=20
       avl =3D 0,=20
       l =3D 0,=20
       d =3D 0,=20
       g =3D 0,=20
       base2 =3D 0
     }, {
       limit0 =3D 0,=20
       base0 =3D 0,=20
       base1 =3D 0,=20
       type =3D 0,=20
       s =3D 0,=20
       dpl =3D 0,=20
       p =3D 0,=20
       limit1 =3D 0,=20
       avl =3D 0,=20
       l =3D 0,=20
       d =3D 0,=20
       g =3D 0,=20
       base2 =3D 0
     }},=20
   sp =3D 18446645387173002832,=20
   es =3D 0,=20
   ds =3D 0,=20
   fsindex =3D 0,=20
   gsindex =3D 0,=20
   fsbase =3D 0,=20
   gsbase =3D 0,=20
   ptrace_bps =3D {0x0, 0x0, 0x0, 0x0},=20
   virtual_dr6 =3D 0,=20
   ptrace_dr7 =3D 0,=20
   cr2 =3D 0,=20
   trap_nr =3D 6,=20
   error_code =3D 0,=20
   io_bitmap =3D 0x0,=20
   iopl_emul =3D 0,=20
   iopl_warn =3D 0,=20
   sig_on_uaccess_err =3D 0,=20
   fpu =3D {
     last_cpu =3D 4294967295,=20
     avx512_timestamp =3D 0,=20
     state =3D {
       fsave =3D {
         cwd =3D 0,=20
         swd =3D 0,=20
         twd =3D 0,=20
         fip =3D 0,=20
         fcs =3D 0,=20
         foo =3D 0,=20
         fos =3D 0,=20
         st_space =3D {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0=
, 0, 0},=20
         status =3D 0
       },=20
       fxsave =3D {
         cwd =3D 0,=20
         swd =3D 0,=20
         twd =3D 0,=20
         fop =3D 0,=20
         {
           {
             rip =3D 0,=20
             rdp =3D 0
           },=20
           {
             fip =3D 0,=20
             fcs =3D 0,=20
             foo =3D 0,=20
             fos =3D 0
           }
         },=20
         mxcsr =3D 0,=20
         mxcsr_mask =3D 0,=20
         st_space =3D {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0=
, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},=20
         xmm_space =3D {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, =
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, =
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},=20
         padding =3D {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},=20
         {
           padding1 =3D {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},=20
           sw_reserved =3D {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
         }
       },=20
       soft =3D {
         cwd =3D 0,=20
         swd =3D 0,=20
         twd =3D 0,=20
         fip =3D 0,=20
         fcs =3D 0,=20
         foo =3D 0,=20
         fos =3D 0,=20
         st_space =3D {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0=
, 0, 0},=20
         ftop =3D 0 '\000',=20
         changed =3D 0 '\000',=20
         lookahead =3D 0 '\000',=20
         no_update =3D 0 '\000',=20
         rm =3D 0 '\000',=20
         alimit =3D 0 '\000',=20
         info =3D 0x0,=20
         entry_eip =3D 0
       },=20
       xsave =3D {
         i387 =3D {
           cwd =3D 0,=20
           swd =3D 0,=20
           twd =3D 0,=20
           fop =3D 0,=20
           {
             {
               rip =3D 0,=20
               rdp =3D 0
             },=20
             {
               fip =3D 0,=20
               fcs =3D 0,=20
               foo =3D 0,=20
               fos =3D 0
             }
           },=20
           mxcsr =3D 0,=20
           mxcsr_mask =3D 0,=20
           st_space =3D {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,=
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},=20
           xmm_space =3D {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0=
, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0=
, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},=20
           padding =3D {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},=20
           {
             padding1 =3D {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},=20
             sw_reserved =3D {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
           }
         },=20
         header =3D {
           xfeatures =3D 0,=20
           xcomp_bv =3D 9223372036854776551,=20
           reserved =3D {0, 0, 0, 0, 0, 0}
         },=20
         extended_state_area =3D 0xffff8d2b402d2500 ""
       },=20
       __padding =3D "\000\000\000\000\000\000\000\000\000\000\000\000\000\=
000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000=
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\00=
0\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\0=
00\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\=
000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000=
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\00=
0\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\0=
00\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\=
000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000=
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\00=
0\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\0=
00\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\=
000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000=
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\00=
0\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\0=
00\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\=
000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000=
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\00=
0\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\0=
00\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\=
000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000=
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\00=
0\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\0=
00\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\=
000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000=
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\00=
0\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\0=
00"...
     }
   }
 }

crash> runq=20
CPU 0 RUNQUEUE: ffff8d36efa2f400
 CURRENT: PID: 3165237  TASK: ffff8d3259262c80  COMMAND: "counters_collec"
 RT PRIO_ARRAY: ffff8d36efa2f640
    [no tasks queued]
 CFS RB_ROOT: ffff8d36efa2f4b0
    [no tasks queued]

CPU 1 RUNQUEUE: ffff8d36efa6f400
 CURRENT: PID: 36992  TASK: ffff8d2b52d99640  COMMAND: "ScanPrefetchExe"
 RT PRIO_ARRAY: ffff8d36efa6f640
    [ 94] PID: 36992  TASK: ffff8d2b52d99640  COMMAND: "ScanPrefetchExe"
 CFS RB_ROOT: ffff8d36efa6f4b0
    [no tasks queued]

CPU 2 RUNQUEUE: ffff8d36efaaf400
 CURRENT: PID: 928131  TASK: ffff8d33d909c2c0  COMMAND: "Incoming TCP - "
 RT PRIO_ARRAY: ffff8d36efaaf640
    [ 89] PID: 886837  TASK: ffff8d2b7d79d900  COMMAND: "epoll_1"
    [ 94] PID: 928131  TASK: ffff8d33d909c2c0  COMMAND: "Incoming TCP - "
 CFS RB_ROOT: ffff8d36efaaf4b0
    [139] PID: 1982614  TASK: ffff8d2b53095900  COMMAND: "grep"

CPU 3 RUNQUEUE: ffff8d36efaef400
 CURRENT: PID: 886898  TASK: ffff8d33af83d900  COMMAND: "rocksdb:low3"
 RT PRIO_ARRAY: ffff8d36efaef640
    [ 89] PID: 886898  TASK: ffff8d33af83d900  COMMAND: "rocksdb:low3"
 CFS RB_ROOT: ffff8d36efaef4b0
    [no tasks queued]

CPU 4 RUNQUEUE: ffff8d36efb2f400
 CURRENT: PID: 886822  TASK: ffff8d2bbb2142c0  COMMAND: "control_5"
 RT PRIO_ARRAY: ffff8d36efb2f640
    [ 89] PID: 886822  TASK: ffff8d2bbb2142c0  COMMAND: "control_5"
 CFS RB_ROOT: ffff8d36efb2f4b0
    [no tasks queued]

CPU 5 RUNQUEUE: ffff8d36efb6f400
 CURRENT: PID: 886945  TASK: ffff8d32b209c2c0  COMMAND: "spdk_epoll0"
 RT PRIO_ARRAY: ffff8d36efb6f640
    [ 89] PID: 886945  TASK: ffff8d32b209c2c0  COMMAND: "spdk_epoll0"
 CFS RB_ROOT: ffff8d36efb6f4b0
    [139] PID: 1982558  TASK: ffff8d2bb2189640  COMMAND: "links"

CPU 6 RUNQUEUE: ffff8d36efbaf400
 CURRENT: PID: 886817  TASK: ffff8d2b7bbb42c0  COMMAND: "control_0"
 RT PRIO_ARRAY: ffff8d36efbaf640
    [ 89] PID: 886817  TASK: ffff8d2b7bbb42c0  COMMAND: "control_0"
 CFS RB_ROOT: ffff8d36efbaf4b0
    [no tasks queued]

CPU 7 RUNQUEUE: ffff8d36efbef400
 CURRENT: PID: 887871  TASK: ffff8d325714ac80  COMMAND: "oplog_disk_55"
 RT PRIO_ARRAY: ffff8d36efbef640
    [ 89] PID: 887871  TASK: ffff8d325714ac80  COMMAND: "oplog_disk_55"
    [ 94] PID: 41031  TASK: ffff8d2b91705900  COMMAND: "HTTP_PROTO_STAG"
 CFS RB_ROOT: ffff8d36efbef4b0
    [139] PID: 1982573  TASK: ffff8d33b23cc2c0  COMMAND: "links"

CPU 8 RUNQUEUE: ffff8d36efc2f400
 CURRENT: PID: 0      TASK: ffff8d2b402d1640  COMMAND: "swapper/8"
 RT PRIO_ARRAY: ffff8d36efc2f640
    [no tasks queued]
 CFS RB_ROOT: ffff8d36efc2f4b0
    [no tasks queued]

CPU 9 RUNQUEUE: ffff8d36efc6f400
 CURRENT: PID: 1501707  TASK: ffff8d340bd18000  COMMAND: "kworker/9:3"
 RT PRIO_ARRAY: ffff8d36efc6f640
    [ 89] PID: 1501707  TASK: ffff8d340bd18000  COMMAND: "kworker/9:3"
 CFS RB_ROOT: ffff8d36efc6f4b0
    [no tasks queued]

CPU 10 RUNQUEUE: ffff8d36efcaf400
 CURRENT: PID: 1982567  TASK: ffff8d340a668000  COMMAND: "lsof"
 RT PRIO_ARRAY: ffff8d36efcaf640
    [no tasks queued]
 CFS RB_ROOT: ffff8d36efcaf4b0
    [120] PID: 47685  TASK: ffff8d33d784ac80  COMMAND: "medusa_1"
    [120] PID: 47684  TASK: ffff8d2b65dfac80  COMMAND: "medusa_0"
    [120] PID: 47688  TASK: ffff8d33d784c2c0  COMMAND: "cass_epd0"

CPU 11 RUNQUEUE: ffff8d36efcef400
 CURRENT: PID: 0      TASK: ffff8d2b402d5900  COMMAND: "swapper/11"
 RT PRIO_ARRAY: ffff8d36efcef640
    [no tasks queued]
 CFS RB_ROOT: ffff8d36efcef4b0
    [no tasks queued]

CPU 12 RUNQUEUE: ffff8d36efd2f400
 CURRENT: PID: 886825  TASK: ffff8d33d8a55900  COMMAND: "control_8"
 RT PRIO_ARRAY: ffff8d36efd2f640
    [ 89] PID: 886825  TASK: ffff8d33d8a55900  COMMAND: "control_8"
 CFS RB_ROOT: ffff8d36efd2f4b0
    [no tasks queued]

CPU 13 RUNQUEUE: ffff8d36efd6f400
 CURRENT: PID: 886843  TASK: ffff8d340da72c80  COMMAND: "epoll_7"
 RT PRIO_ARRAY: ffff8d36efd6f640
    [ 89] PID: 886843  TASK: ffff8d340da72c80  COMMAND: "epoll_7"
 CFS RB_ROOT: ffff8d36efd6f4b0
    [no tasks queued]

CPU 14 RUNQUEUE: ffff8d36efdaf400
 CURRENT: PID: 0      TASK: ffff8d2b402dac80  COMMAND: "swapper/14"
 RT PRIO_ARRAY: ffff8d36efdaf640
    [no tasks queued]
 CFS RB_ROOT: ffff8d36efdaf4b0
    [no tasks queued]

CPU 15 RUNQUEUE: ffff8d36efdef400
 CURRENT: PID: 1982592  TASK: ffff8d2b53e51640  COMMAND: "python3.9"
 RT PRIO_ARRAY: ffff8d36efdef640
    [no tasks queued]
 CFS RB_ROOT: ffff8d36efdef4b0
    [no tasks queued]

crash> struct rt_rq ffff8d36efc2f640
struct rt_rq {
 active =3D {
   bitmap =3D {0, 68719476736},=20
   queue =3D {{
       next =3D 0xffff8d36efc2f650,=20
       prev =3D 0xffff8d36efc2f650
     }, {
       next =3D 0xffff8d36efc2f660,=20
       prev =3D 0xffff8d36efc2f660
     }, {
       next =3D 0xffff8d36efc2f670,=20
       prev =3D 0xffff8d36efc2f670
     }, {
       next =3D 0xffff8d36efc2f680,=20
       prev =3D 0xffff8d36efc2f680
     }, {
       next =3D 0xffff8d36efc2f690,=20
       prev =3D 0xffff8d36efc2f690
     }, {
       next =3D 0xffff8d36efc2f6a0,=20
       prev =3D 0xffff8d36efc2f6a0
     }, {
       next =3D 0xffff8d36efc2f6b0,=20
       prev =3D 0xffff8d36efc2f6b0
     }, {
       next =3D 0xffff8d36efc2f6c0,=20
       prev =3D 0xffff8d36efc2f6c0
     }, {
       next =3D 0xffff8d36efc2f6d0,=20
       prev =3D 0xffff8d36efc2f6d0
     }, {
       next =3D 0xffff8d36efc2f6e0,=20
       prev =3D 0xffff8d36efc2f6e0
     }, {
       next =3D 0xffff8d36efc2f6f0,=20
       prev =3D 0xffff8d36efc2f6f0
     }, {
       next =3D 0xffff8d36efc2f700,=20
       prev =3D 0xffff8d36efc2f700
     }, {
       next =3D 0xffff8d36efc2f710,=20
       prev =3D 0xffff8d36efc2f710
     }, {
       next =3D 0xffff8d36efc2f720,=20
       prev =3D 0xffff8d36efc2f720
     }, {
       next =3D 0xffff8d36efc2f730,=20
       prev =3D 0xffff8d36efc2f730
     }, {
       next =3D 0xffff8d36efc2f740,=20
       prev =3D 0xffff8d36efc2f740
     }, {
       next =3D 0xffff8d36efc2f750,=20
       prev =3D 0xffff8d36efc2f750
     }, {
       next =3D 0xffff8d36efc2f760,=20
       prev =3D 0xffff8d36efc2f760
     }, {
       next =3D 0xffff8d36efc2f770,=20
       prev =3D 0xffff8d36efc2f770
     }, {
       next =3D 0xffff8d36efc2f780,=20
       prev =3D 0xffff8d36efc2f780
     }, {
       next =3D 0xffff8d36efc2f790,=20
       prev =3D 0xffff8d36efc2f790
     }, {
       next =3D 0xffff8d36efc2f7a0,=20
       prev =3D 0xffff8d36efc2f7a0
     }, {
       next =3D 0xffff8d36efc2f7b0,=20
       prev =3D 0xffff8d36efc2f7b0
     }, {
       next =3D 0xffff8d36efc2f7c0,=20
       prev =3D 0xffff8d36efc2f7c0
     }, {
       next =3D 0xffff8d36efc2f7d0,=20
       prev =3D 0xffff8d36efc2f7d0
     }, {
       next =3D 0xffff8d36efc2f7e0,=20
       prev =3D 0xffff8d36efc2f7e0
     }, {
       next =3D 0xffff8d36efc2f7f0,=20
       prev =3D 0xffff8d36efc2f7f0
     }, {
       next =3D 0xffff8d36efc2f800,=20
       prev =3D 0xffff8d36efc2f800
     }, {
       next =3D 0xffff8d36efc2f810,=20
       prev =3D 0xffff8d36efc2f810
     }, {
       next =3D 0xffff8d36efc2f820,=20
       prev =3D 0xffff8d36efc2f820
     }, {
       next =3D 0xffff8d36efc2f830,=20
       prev =3D 0xffff8d36efc2f830
     }, {
       next =3D 0xffff8d36efc2f840,=20
       prev =3D 0xffff8d36efc2f840
     }, {
       next =3D 0xffff8d36efc2f850,=20
       prev =3D 0xffff8d36efc2f850
     }, {
       next =3D 0xffff8d36efc2f860,=20
       prev =3D 0xffff8d36efc2f860
     }, {
       next =3D 0xffff8d36efc2f870,=20
       prev =3D 0xffff8d36efc2f870
     }, {
       next =3D 0xffff8d36efc2f880,=20
       prev =3D 0xffff8d36efc2f880
     }, {
       next =3D 0xffff8d36efc2f890,=20
       prev =3D 0xffff8d36efc2f890
     }, {
       next =3D 0xffff8d36efc2f8a0,=20
       prev =3D 0xffff8d36efc2f8a0
     }, {
       next =3D 0xffff8d36efc2f8b0,=20
       prev =3D 0xffff8d36efc2f8b0
     }, {
       next =3D 0xffff8d36efc2f8c0,=20
       prev =3D 0xffff8d36efc2f8c0
     }, {
       next =3D 0xffff8d36efc2f8d0,=20
       prev =3D 0xffff8d36efc2f8d0
     }, {
       next =3D 0xffff8d36efc2f8e0,=20
       prev =3D 0xffff8d36efc2f8e0
     }, {
       next =3D 0xffff8d36efc2f8f0,=20
       prev =3D 0xffff8d36efc2f8f0
     }, {
       next =3D 0xffff8d36efc2f900,=20
       prev =3D 0xffff8d36efc2f900
     }, {
       next =3D 0xffff8d36efc2f910,=20
       prev =3D 0xffff8d36efc2f910
     }, {
       next =3D 0xffff8d36efc2f920,=20
       prev =3D 0xffff8d36efc2f920
     }, {
       next =3D 0xffff8d36efc2f930,=20
       prev =3D 0xffff8d36efc2f930
     }, {
       next =3D 0xffff8d36efc2f940,=20
       prev =3D 0xffff8d36efc2f940
     }, {
       next =3D 0xffff8d36efc2f950,=20
       prev =3D 0xffff8d36efc2f950
     }, {
       next =3D 0xffff8d36efc2f960,=20
       prev =3D 0xffff8d36efc2f960
     }, {
       next =3D 0xffff8d36efc2f970,=20
       prev =3D 0xffff8d36efc2f970
     }, {
       next =3D 0xffff8d36efc2f980,=20
       prev =3D 0xffff8d36efc2f980
     }, {
       next =3D 0xffff8d36efc2f990,=20
       prev =3D 0xffff8d36efc2f990
     }, {
       next =3D 0xffff8d36efc2f9a0,=20
       prev =3D 0xffff8d36efc2f9a0
     }, {
       next =3D 0xffff8d36efc2f9b0,=20
       prev =3D 0xffff8d36efc2f9b0
     }, {
       next =3D 0xffff8d36efc2f9c0,=20
       prev =3D 0xffff8d36efc2f9c0
     }, {
       next =3D 0xffff8d36efc2f9d0,=20
       prev =3D 0xffff8d36efc2f9d0
     }, {
       next =3D 0xffff8d36efc2f9e0,=20
       prev =3D 0xffff8d36efc2f9e0
     }, {
       next =3D 0xffff8d36efc2f9f0,=20
       prev =3D 0xffff8d36efc2f9f0
     }, {
       next =3D 0xffff8d36efc2fa00,=20
       prev =3D 0xffff8d36efc2fa00
     }, {
       next =3D 0xffff8d36efc2fa10,=20
       prev =3D 0xffff8d36efc2fa10
     }, {
       next =3D 0xffff8d36efc2fa20,=20
       prev =3D 0xffff8d36efc2fa20
     }, {
       next =3D 0xffff8d36efc2fa30,=20
       prev =3D 0xffff8d36efc2fa30
     }, {
       next =3D 0xffff8d36efc2fa40,=20
       prev =3D 0xffff8d36efc2fa40
     }, {
       next =3D 0xffff8d36efc2fa50,=20
       prev =3D 0xffff8d36efc2fa50
     }, {
       next =3D 0xffff8d36efc2fa60,=20
       prev =3D 0xffff8d36efc2fa60
     }, {
       next =3D 0xffff8d36efc2fa70,=20
       prev =3D 0xffff8d36efc2fa70
     }, {
       next =3D 0xffff8d36efc2fa80,=20
       prev =3D 0xffff8d36efc2fa80
     }, {
       next =3D 0xffff8d36efc2fa90,=20
       prev =3D 0xffff8d36efc2fa90
     }, {
       next =3D 0xffff8d36efc2faa0,=20
       prev =3D 0xffff8d36efc2faa0
     }, {
       next =3D 0xffff8d36efc2fab0,=20
       prev =3D 0xffff8d36efc2fab0
     }, {
       next =3D 0xffff8d36efc2fac0,=20
       prev =3D 0xffff8d36efc2fac0
     }, {
       next =3D 0xffff8d36efc2fad0,=20
       prev =3D 0xffff8d36efc2fad0
     }, {
       next =3D 0xffff8d36efc2fae0,=20
       prev =3D 0xffff8d36efc2fae0
     }, {
       next =3D 0xffff8d36efc2faf0,=20
       prev =3D 0xffff8d36efc2faf0
     }, {
       next =3D 0xffff8d36efc2fb00,=20
       prev =3D 0xffff8d36efc2fb00
     }, {
       next =3D 0xffff8d36efc2fb10,=20
       prev =3D 0xffff8d36efc2fb10
     }, {
       next =3D 0xffff8d36efc2fb20,=20
       prev =3D 0xffff8d36efc2fb20
     }, {
       next =3D 0xffff8d36efc2fb30,=20
       prev =3D 0xffff8d36efc2fb30
     }, {
       next =3D 0xffff8d36efc2fb40,=20
       prev =3D 0xffff8d36efc2fb40
     }, {
       next =3D 0xffff8d36efc2fb50,=20
       prev =3D 0xffff8d36efc2fb50
     }, {
       next =3D 0xffff8d36efc2fb60,=20
       prev =3D 0xffff8d36efc2fb60
     }, {
       next =3D 0xffff8d36efc2fb70,=20
       prev =3D 0xffff8d36efc2fb70
     }, {
       next =3D 0xffff8d36efc2fb80,=20
       prev =3D 0xffff8d36efc2fb80
     }, {
       next =3D 0xffff8d36efc2fb90,=20
       prev =3D 0xffff8d36efc2fb90
     }, {
       next =3D 0xffff8d36efc2fba0,=20
       prev =3D 0xffff8d36efc2fba0
     }, {
       next =3D 0xffff8d36efc2fbb0,=20
       prev =3D 0xffff8d36efc2fbb0
     }, {
       next =3D 0xffff8d36efc2fbc0,=20
       prev =3D 0xffff8d36efc2fbc0
     }, {
       next =3D 0xffff8d36efc2fbd0,=20
       prev =3D 0xffff8d36efc2fbd0
     }, {
       next =3D 0xffff8d36efc2fbe0,=20
       prev =3D 0xffff8d36efc2fbe0
     }, {
       next =3D 0xffff8d36efc2fbf0,=20
       prev =3D 0xffff8d36efc2fbf0
     }, {
       next =3D 0xffff8d36efc2fc00,=20
       prev =3D 0xffff8d36efc2fc00
     }, {
       next =3D 0xffff8d36efc2fc10,=20
       prev =3D 0xffff8d36efc2fc10
     }, {
       next =3D 0xffff8d36efc2fc20,=20
       prev =3D 0xffff8d36efc2fc20
     }, {
       next =3D 0xffff8d36efc2fc30,=20
       prev =3D 0xffff8d36efc2fc30
     }, {
       next =3D 0xffff8d36efc2fc40,=20
       prev =3D 0xffff8d36efc2fc40
     }, {
       next =3D 0xffff8d36efc2fc50,=20
       prev =3D 0xffff8d36efc2fc50
     }, {
       next =3D 0xffff8d36efc2fc60,=20
       prev =3D 0xffff8d36efc2fc60
     }, {
       next =3D 0xffff8d36efc2fc70,=20
       prev =3D 0xffff8d36efc2fc70
     }, {
       next =3D 0xffff8d36efc2fc80,=20
       prev =3D 0xffff8d36efc2fc80
     }}
 },=20
 rt_nr_running =3D 0,=20
 rr_nr_running =3D 0,=20
 highest_prio =3D {
   curr =3D 100,=20
   next =3D 89
 },=20
 rt_nr_migratory =3D 0,=20
 rt_nr_total =3D 0,=20
 overloaded =3D 0,=20
 pushable_tasks =3D {
   node_list =3D {
     next =3D 0xffff8d36efc2fcb8,=20
     prev =3D 0xffff8d36efc2fcb8
   }
 },=20
 rt_queued =3D 0,=20
 rt_throttled =3D 0,=20
 rt_time =3D    360210300,=20
 rt_runtime =3D 1000000000,=20
 rt_runtime_lock =3D {
   raw_lock =3D {
     {
       val =3D {
         counter =3D 0
       },=20
       {
         locked =3D 0 '\000',=20
         pending =3D 0 '\000'
       },=20
       {
         locked_pending =3D 0,=20
         tail =3D 0
       }
     }
   }
 },=20
 rt_nr_boosted =3D 0,=20
 rq =3D 0xffff8d36efc2f400,=20
 tg =3D 0xffffffffb2b49240
}=

