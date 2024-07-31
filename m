Return-Path: <linux-kernel+bounces-269313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00569943164
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815F01F2132B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D3D1B150C;
	Wed, 31 Jul 2024 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="UUqj6GzZ"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A521B1414
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433943; cv=fail; b=ogSuZpmFKG04ZLI42ZAaUDC1ZO0469EvprQ0Mk8nrKx/nAK3CMe98G4ZZXoI7sefKKqG5MXgmvCV6/J2ab29n966GqHJjEATaYFTLI0jqfX8rPKFl4z2lRj5wEd1hL5KRF/ZLHPk8/ql1vLCJNFaXkqEOovq02VwXSuxGuJP5eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433943; c=relaxed/simple;
	bh=w8a742o+kx2DAAyKotZc/f70MNbmavmuVK56fVdpF4g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f+gCf0ttOLgTYUz4/bZmBrpI4+YXmZFsm2DQ4yAM1ZSeb2AQBJ/mPN7W2jUYf5hCls4BieFz8L/IktxPtRkBQAdGYwnEh67/ULthdWxPh1bswWw0iREot+tw4nTXYRZ/A+HnRb+86oZgXZewgcnGLcogj4SWHAzhh63Kc7TCVH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=UUqj6GzZ; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V4fC5x026337;
	Wed, 31 Jul 2024 06:52:11 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40qeeut8fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 06:52:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXZtUrBIbTtHFpZ4OTkMGRdt68aSWVRxAlYZQ1I/cg/3tSlNLMP1Ht93KmxcVhcvuKEB9sCtLbK1cULrtJ4Fh8cGk0BGXd+chOy3fSHZ4F/YHYVL8+cmcTcVXbx4uUq8LS11RxeGvojxuuqKEBZkneVuAbDuIc1HYgJj8EAHrSM9/6PlFSeHKek7F3MX8F9hcsazf9JKDNWVtaVK7cqOpX8ZAWdBAnKrFFALlqbEPwf1sX3ohBieg17GU2k6jL/qAzkJrbIG3C2GIq1NZlVpARDWWI+h/6A2IajejenmLReeDeG6e/ciU85JpKQblv3//l+Rln8ud9uaAomKkIQvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=813evzfX/luIWcdArBilXazsYXN7aRqIbxDZGxY5IvA=;
 b=yvHfwjn4olwkLvpBfZyTC5uWAJOvv9XqE+fjbfJjckQB3lvg+1Va9rAWFu6z4Ii82lBIS/QBQ8Zwi77bTPqbuWCIvjH6QzbwjAnOJOsvgUprGLPn34ZtvVHm7GdOayFJ7aIZANOEmEsLmJNVjGPey3f+wXTDRPg8gwYPywhuJ07YV90HzmsXnkkbbTviGMqyCjOnf4VTx2rjsRKDngrWduafbzozpXx+ttmAKW6o3UPdqlHGQs1YJN6LHno1q2B5GtnU/vFB+CilgRqxusBhRgQjWUqKjLJjDFIb5ItVGxoYyxSCIbdoiElDlnQLZtz1SZXbHEmYYqTcPH9nKkn0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=813evzfX/luIWcdArBilXazsYXN7aRqIbxDZGxY5IvA=;
 b=UUqj6GzZugTwnlUTQqLfXHT72TG1jQmRDFzGh7HDEKKFUcWEjLPI7GtwOd+BeXPaVlyLfpJ3bdq/FwiXJ7m/5bePObP8F+cmalhsgLiHeQBqMWXs0Pu1gQ60xZ5j7yCZvnRHzkyiww6BUrCu0YjfyJEtqeKHFr/cOKma6q+OkFM=
Received: from SJ0PR18MB3865.namprd18.prod.outlook.com (2603:10b6:a03:2ea::22)
 by SA0PR18MB3664.namprd18.prod.outlook.com (2603:10b6:806:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 13:52:07 +0000
Received: from SJ0PR18MB3865.namprd18.prod.outlook.com
 ([fe80::697b:186f:f4bb:a5fc]) by SJ0PR18MB3865.namprd18.prod.outlook.com
 ([fe80::697b:186f:f4bb:a5fc%7]) with mapi id 15.20.7828.021; Wed, 31 Jul 2024
 13:52:07 +0000
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: "will@kernel.org" <will@kernel.org>
CC: George Cherian <gcherian@marvell.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 0/3] Marvell Odyssey uncore performance monitor support
Thread-Topic: [PATCH v6 0/3] Marvell Odyssey uncore performance monitor
 support
Thread-Index: AQHazfNrEgjgpojRLEaNeRxzHtq0eLIRBOaA
Date: Wed, 31 Jul 2024 13:52:06 +0000
Message-ID:
 <SJ0PR18MB386546CFB80D1D17477CDF40DBB12@SJ0PR18MB3865.namprd18.prod.outlook.com>
References: <20240704092022.1136805-1-gthiagarajan@marvell.com>
In-Reply-To: <20240704092022.1136805-1-gthiagarajan@marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB3865:EE_|SA0PR18MB3664:EE_
x-ms-office365-filtering-correlation-id: e992cd3c-3f84-4326-1463-08dcb167f76d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?f0keGoPMBz6lfL3VFDIZ7Mb442EF1tnTSumhkQ7wO0fvGJUMQdptrwhfTjrH?=
 =?us-ascii?Q?umHDjFOuSMScsSVK/ue6FqfSfTBMpOI3slt3yoEi3fFGgihqnVYQuVyD1UFR?=
 =?us-ascii?Q?2j/xkIwUGkd/FL1tXnCFPEktFJcUYFd4I0WshQKLHiRAd30BT7/O62Hq5xTQ?=
 =?us-ascii?Q?DYPh8EUXUmST1nc5tMpPEy4lUjSMJ2sppQOs43SsppgMFeRuf4Zu/UIv1xCF?=
 =?us-ascii?Q?spwJf8pLUw84FfMMbUbb1N7UCpnqbWi+Mmpa8vIYklBEWbuGWfy0tZ1FhxNl?=
 =?us-ascii?Q?qi2QLhZeaCsSet/Ab6aqzxrvungoDCa6gO7XdqojwW+9gDX8yaMKpQzrfYm1?=
 =?us-ascii?Q?v11mX4IuptcZclbq6CCV5ZO5DT2fm/D8de4O4KF/9FrkE1ssblOHgj9nBrZg?=
 =?us-ascii?Q?2q9AKQbcyuB43HA26dU3CjtJxuD/BfBkz4JzZ0TjI8CQ6KqVa+ePbr4SQkRz?=
 =?us-ascii?Q?vxvt7h0Y5QkLJW+a7xtWc5wBL/GMUjxHEwGTXl5SLQBcz0EGtPmsCPb/Vfbe?=
 =?us-ascii?Q?YYfensdWCda8nV0/M0F5ajY8zk3S0L+75pngU1xeUm9nWFQW6FCyOCdJKYz9?=
 =?us-ascii?Q?YjFuANovAaCjZMVwwDWyhSDP4zRbPfUnFhW+U1eSn4MaenP0z4LV6IHsx00H?=
 =?us-ascii?Q?WvN6CK1vEnJ5z54BlF8keYPvbGKLcMQpuHf2rVdSlZH3REMlOzWzfN7Iv03W?=
 =?us-ascii?Q?Xp0ymneUjINAIzTazJy8AVu681q/sGR/SkiOhYqqnvBfsLrgAHqEy4CGMBQE?=
 =?us-ascii?Q?K/8gwLkYtCnGsNkfOylN6sFi7Oo+oPli6bx3Eut3XlrpQANq4fw03Beg5eL0?=
 =?us-ascii?Q?UztyLxCoiSLl0qvyY9QlqnjkStgBVf19NuCTabmVhP7nsp12xEookx3PcZTH?=
 =?us-ascii?Q?6RGxrHYSmDwHv+QjQhK6SerxVOTmJGRYcQSPl+WVyss1AMwrqTOMlFgGGAjA?=
 =?us-ascii?Q?QzM6R08prlb3oxLYlVSmnWs80ksPbDzTWUY3oGqhOitflWtdTi+yuyk2IEf3?=
 =?us-ascii?Q?EHA/hIKC6s4vzAS968uzzdnGFMDEFWg7IcbjqUruTJsgQkr2wjXX9MfiFdWp?=
 =?us-ascii?Q?VcVHrVOarI3qP6m9KwuaX6vxG8Ig474RUKgyAaPcpuBXGo+ALu77QtGfC/m2?=
 =?us-ascii?Q?RWqaD+tlzPRA9abYbKQ+2kIDDz5bashB3owgkSufXBrx8UeE9owyYW97fDMG?=
 =?us-ascii?Q?tXqlhnr/Ssz8w3qUShzNn6iPYih9+O8kK6/BhmlhYYUBlAzLpo7lBUpEb8SL?=
 =?us-ascii?Q?UTWVY0diRxqtQ/DYfsp6XfosRYbvdgtDIUMibekJIgYAh9TsAR2h+D3W5WRE?=
 =?us-ascii?Q?RBbN6nLFxE76Nj+EYPM2EzcuTwIq70zwbVLrOfn6+BSvmBe84SSppUhbUdXz?=
 =?us-ascii?Q?Psea6DjpWd4QCGWwq3u/DF/Xl+QsceJNzb4x05YcokVyEaY/aw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB3865.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RH2XTrTgYxTIkbBWgGGEuX3NwYLuy+s3QhTFbqRY+Z4iZLWE09yrMC3j3uPa?=
 =?us-ascii?Q?ICuIDBBsGKGra0jR+jJobuX9zIHo6RbdEjQP20Z4mzq0pgweY89Kd3qc0HGP?=
 =?us-ascii?Q?xUI9k6T+Uooa3oJfXohrCMX0KVTxtohEuoHsVT6eVORXv39YcvJU/zk5FFrT?=
 =?us-ascii?Q?dUvmOOynIf99hfPJ2J264n5KW3QabNVdWHMcRshRkQjsOrl2Hxay2if1AKVw?=
 =?us-ascii?Q?i9eVPa6mj0Qk5tDWZ6oktHIzh5OVd/wTMt+jwBF3rx25uc+puHA3sIDMs3Kh?=
 =?us-ascii?Q?afwerrFHiMTO3hh1v+mlP7+ZqzxLCB1TpHFYl39Ta2M+qWunOzOEI0TNYkY6?=
 =?us-ascii?Q?vV6YNhLOBKb3O7o3UOI0sxdI6m1qyjZ8Lpbc8nJJwzaFxp1sRCf70+EB+nRd?=
 =?us-ascii?Q?eqatTmZdw4Zfyg+Ph8CQDPsroZUpYwvPzG5Ds4LnHeGs+Re5zi9m1JKUI/K2?=
 =?us-ascii?Q?5sCQD4tOXk1LWEOujAYtpioLGw2nplfwB4c5wrFXDZUEDAlb89qk+suUZDVf?=
 =?us-ascii?Q?vxJ3jf4GgyLUWEJliiYhMiF4TVGo/Ch7KfwYvoUJUR3k5M0984OUMEoY0Pbd?=
 =?us-ascii?Q?45311Y1EmdDu6oSDbVgRvJIwsUkslSEVgxXeADu6fyZCLql5MCSauvo0xdM2?=
 =?us-ascii?Q?q0PvKB9uZkdcB+br62tXMEDuS/IFZaMyseCz4KHQ1ZG21EUaC62gUah9Urhl?=
 =?us-ascii?Q?oQzRjx5Q6loTU7COc6n6GHTTorBmWHftSp24lqwo/k1RNzw7XIuY+xMTNbS6?=
 =?us-ascii?Q?dpVRURDvmOcjv7zKNnevCF6EmboAR4FBBIyY8GARcNCiXJ/YzUsOpoR3fwc4?=
 =?us-ascii?Q?21qF0ADmeaP361O7e8U0H+lkjDAj1UMp185jW9YvaoCzGfEmICQ1wHMh7A6m?=
 =?us-ascii?Q?orsxQSV/yodLHaC+4ayynzm5GKuD+BK9M+eIFv4jERaC34i09wbSWYGgwNK1?=
 =?us-ascii?Q?5Yf9qwVMdOZbSgPe9isPwKnJ+LNPj8pUItWLRTZEi/JpJMBSvttMPo5Cy5R1?=
 =?us-ascii?Q?g63hOUVUFGgIHSYvBGfHwm+rPg4vGNSBmRIoSvEU6odg1tZ69BXT0oKuzYIe?=
 =?us-ascii?Q?gVgnm9b62XkFzPckGlzCTiqpCEYCuhNczjFX2mWOehv6/LykCcrKnnXGnW+8?=
 =?us-ascii?Q?9kwIb7/mmTrJlpHdSmAasFG/fKGU7MZwH7xvkNjHuxgCgCig8Gm53aE6mgNC?=
 =?us-ascii?Q?/1gwQB1Nsm8qX5uNmLRwFOlVtXbyhYjebF05LrfwGlQGegq5d39VliJqHuX1?=
 =?us-ascii?Q?yybwoSrsUVLsrfz1wZX0M6IC1383Aavxvxf4Datf9MN+sVSeROvrNyT0GSWt?=
 =?us-ascii?Q?AnT4kQAJCyfSxX9bkyWvBLfvh20WJZxjOGjR68+bO2/SEqgpl+6lcaJ/Du+H?=
 =?us-ascii?Q?rWNPvSePKN93ifXhYwxPM1/puqryIqZJZFrouRHIhhWgSP3y5YEK+3JDbAFp?=
 =?us-ascii?Q?P/tO/Ia5KU3e4eUvajQUs+bLq7VKfPC7O+r5PnhT8gPmUG6x0nnjX7Rav/zj?=
 =?us-ascii?Q?QW5Y3qiXJCogEPYY6ysjgIZbzJKXJrbJYl3CrgsPOBfLzsHpcibdw8tqDZgg?=
 =?us-ascii?Q?43euPBLlIsWZvAFyCuwLroytikqBdY+vLSw3xNUl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB3865.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e992cd3c-3f84-4326-1463-08dcb167f76d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 13:52:07.0062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A80Lkb3sXLO5kFUHIgQp4KlTKjuT0FTRqrFDM9d0TLVZsTHKVOm6ZBvIgPIKsSp98Yppd+73P5daGN4kItQ98/w5MjqB677eEI7Huv8bwkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3664
X-Proofpoint-GUID: k4lJbA6hVs6OF-He_FQBJ_58AB733gMl
X-Proofpoint-ORIG-GUID: k4lJbA6hVs6OF-He_FQBJ_58AB733gMl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_08,2024-07-31_01,2024-05-17_01

Hi Will,

Do you have any feedback for this patchset?

Thanks,
Gowthami

> -----Original Message-----
> From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> Sent: Thursday, July 4, 2024 2:50 PM
> To: will@kernel.org; mark.rutland@arm.com; linux-arm-kernel@lists.infrade=
ad.org; linux-
> kernel@vger.kernel.org
> Cc: George Cherian <gcherian@marvell.com>; Sunil Kovvuri Goutham <sgoutha=
m@marvell.com>; Bharat
> Bhushan <bbhushan2@marvell.com>; Gowthami Thiagarajan <gthiagarajan@marve=
ll.com>
> Subject: [PATCH v6 0/3] Marvell Odyssey uncore performance monitor suppor=
t
>=20
> Odyssey is a 64 bit ARM based SoC with multiple performance monitor
> units for various blocks.
>=20
> This series of patches introduces support for uncore performance monitor
> units (PMUs) on the Marvell Odyssey platform. The PMUs covered in this
> series include the DDR PMU and LLC-TAD PMU.
>=20
> v5->v6:
> - Previous patch series didn't apply properly. Fixed the issue.
>=20
> Gowthami Thiagarajan (3):
>   perf/marvell: Refactor to extract platform data - no functional change
>   perf/marvell: perf/marvell: Odyssey DDR Performance monitor support
>   perf/marvell : Odyssey LLC-TAD performance monitor support
>=20
>  drivers/perf/marvell_cn10k_ddr_pmu.c | 530 +++++++++++++++++++++++----
>  drivers/perf/marvell_cn10k_tad_pmu.c |  66 +++-
>  2 files changed, 521 insertions(+), 75 deletions(-)
>=20
> --
> 2.25.1


