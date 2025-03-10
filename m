Return-Path: <linux-kernel+bounces-553843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC32A58FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D90916B0C1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC34322333B;
	Mon, 10 Mar 2025 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fEB/eZTp"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A385B225407;
	Mon, 10 Mar 2025 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599118; cv=fail; b=r791ie6rSy0l/pwBWz1tiO7tVIRvKWJCObSQO/A16l189evnAtyOHy9ZenEYVxqGsrRxHv78rUT1DMhR1r6KU0kDyD7Me9v/BG719RJPqzrGi4xrqALbK4/Wy4Mc/jqWkcb6Jb3LUU8lj6ZfGLTJd4hpfX2wMEl7b4v6lQUU7d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599118; c=relaxed/simple;
	bh=D9J7nJQLQ6MoaujzB/BlogG+d3XjYgTivYm4xAhYEHc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R5LsVHdKV17EBEdXCEK/Uuxpm2hxcA7ECLHhK08SKXoBNc362Tg+aMmdO/glo++XfwW0qWBNk3elLpP3o5njnc23dFkzTCqMtNGlUXqxz+Jp8+FROUpEG/NOneo724ABdQYiJH2SuMBmONCn634vygxGGvZlGbtdj2s9+8Nr4xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fEB/eZTp; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A56muZ013107;
	Mon, 10 Mar 2025 05:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=HSU4l
	UBG5kpU+5rzMqmchPAzxQveMhDwjM/utGh59dE=; b=fEB/eZTp3N4f5+H62AE1x
	6l5Im3WDeI4L+DKSPlu3hRRWdBIPfCoydzNx9nSI8LqTxUan2NS/NDx74bLIQfbT
	XvLT6hpbGDWuMMHsKszWMosG+PXKuRV+SJe49A2YQkayDcz+Lml7cY2G8++4KlHf
	NxSHThrrfeZx8PkPBVQ2FYTyV2Mr6avILT4oHURN6eyGwu6M/zo5eI5N/5i3nSq8
	/cfIAtXwE5KW3wwIMsqHp/TRFVDkHEMfIshAhIG0/ant4aVuquivbZBng8L4NL2R
	FiSwGKgOYYhhEGu3Ps/ikChd08opdWWc4UU6SSDgA8XsFrwMJpICxlI8KBV976qW
	A==
Received: from bl0pr05cu006.outbound.protection.outlook.com (mail-BL0PR05CU006.outbound1701.protection.outlook.com [40.93.2.9])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 458kp9fdht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 05:05:41 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DaSw+FNdfik3+swFmzsykUpsGliMJiEWeL4w8q7/Uv1ODJN0Sr8qSvPBhWcwywjiItpiylpdb86274S7CVIT3j9VHd5GoCsE0EtGl8qnv9G1iA8P1Nrl1fRAzTmnheiP5BCS4lB0yFdpcipowQASuccdWz/xOONAsIJPzbLjzgVtHCTBfYwRwq2EGYY3vhDfZFRntkpWX+JQiDpPOTeZ//1Zax8vYmwVfTMt6xmsWThCj7wvuQdl7yw/Eb+6fu+s++PP4GYx2DCFGpY6oHDM2aw79Nc+lC5EDIkZhTZriR+aFtapPmGTrN9A7LfW0jNgo+NhsAcnnBE5HDIgVwSMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSU4lUBG5kpU+5rzMqmchPAzxQveMhDwjM/utGh59dE=;
 b=lBna0lSGHag5ue44oLSl2bwjpRy2tpZ8XvF/CqfNKZJzCnnpS3ZV2vJuupSJvpTb/uo3hzpMRGw4V+JlY3UYg+MjtnyG2iKT0FsYYoPmgvqD/m2Mj9AgKwqBql4hLkg8dv/nlK6xaG2famF30p6MCmeRN3GL85GakUu4jvxdiP+/KCBu10ufQXSWDjyjs2f98tnTFoWRtWomtQA6kNi4vu3iu3Pv2aLjb3bkZo06IcxTptjXap2PtOxY/xr8YpBSsYUZ5bTDZeBIzZlfEdZGVjxrOhXS4A0QSr9QL9pC7LCBBYTdDNZen9tkhytdRG23NOlHjXAExPaY0rBYocQN8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB6376.namprd03.prod.outlook.com (2603:10b6:a03:395::14)
 by SJ0PR03MB5549.namprd03.prod.outlook.com (2603:10b6:a03:281::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 09:05:38 +0000
Received: from SJ0PR03MB6376.namprd03.prod.outlook.com
 ([fe80::9515:1981:b065:d4bc]) by SJ0PR03MB6376.namprd03.prod.outlook.com
 ([fe80::9515:1981:b065:d4bc%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 09:05:38 +0000
From: "Libetario, Kent" <Kent.Libetario@analog.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean Delvare
	<jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: RE: [PATCH 2/2] drivers: hwmon: add driver for max42500
Thread-Topic: [PATCH 2/2] drivers: hwmon: add driver for max42500
Thread-Index: AQHbU9NZeBpe/MbDP02kEGbmPYS1tbNsX0qA
Date: Mon, 10 Mar 2025 09:05:38 +0000
Message-ID:
 <SJ0PR03MB6376BDAD3C9D4B5EF16C60DFE6D62@SJ0PR03MB6376.namprd03.prod.outlook.com>
References: <20241220012003.9568-1-Kent.Libetario@analog.com>
 <20241220012003.9568-3-Kent.Libetario@analog.com>
 <6488f38b-7e8b-4b4c-8955-e516e4cf88d6@roeck-us.net>
In-Reply-To: <6488f38b-7e8b-4b4c-8955-e516e4cf88d6@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6376:EE_|SJ0PR03MB5549:EE_
x-ms-office365-filtering-correlation-id: 545b7f0c-5f5f-4566-c29b-08dd5fb2ba08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yf4KxkzDXvxqbGokAi5i5JvwWnUdDNN7m2c7zpTOXYdcquaYNRJh1+v/axyN?=
 =?us-ascii?Q?rrgbajNgWY7FLzNrT4bnPIhbvH8BOJJhmd6y4VomYLIzsFPDCvznFfYM/TAb?=
 =?us-ascii?Q?8TSSNlgGJbLNIRmYAoYEVfGcO50iaN9HGdtVtmVx42khSBriE8VKVvA6IVSM?=
 =?us-ascii?Q?6jLUwIQGSwvNJTVHz0QcE1tvdDunYaWTyz4kfychdRkSL+iftLQSeVCoFeWT?=
 =?us-ascii?Q?F0yESAM+egz+Mlh6IINRjSxi386pOXdl+wvA87XHrRyg8M3KL+DJiygcWe/w?=
 =?us-ascii?Q?nOz0EeoGwiLQeqTB80j3U9oEL6E/zaBZXz5vNnHelA7CPt32PYJzQtMg5Me6?=
 =?us-ascii?Q?QL3a6tKwbuUhwIttgYV0MCPCrDbMUDZZN7cVD6yIc3HIXcSSVzVbRWn01Mgj?=
 =?us-ascii?Q?n7d6mdLHY7NuojBh7Tk/IQeSIHie3TcJjMh8R/4yGSakIpDCqkbxkrixGul4?=
 =?us-ascii?Q?aswBU3mymvCXT7FjgIBATRYWyolqJweawYaA/gLo4K4ID+USTTv3ko//+RSf?=
 =?us-ascii?Q?2EVGkhoehq2hWIAXcefNSJ63MOUvrKD0NdpAni77vm6xNZZ9bWmTwwcLFvIq?=
 =?us-ascii?Q?HzA3g7Fu4OS5Cl3n8HvUEYScI1l3bY/kyjSy2W8JcK9iRwD2/4m313O058wF?=
 =?us-ascii?Q?wkWWsE2XkT0wF7cFCU1yMXsE3WIQGPVIr341ucls0RCg6xlKTKd1zTvPEYeF?=
 =?us-ascii?Q?b8bnbc6xLvs8JaDoqyE8YfywEhc+NZ/qvsgluF0gXBjMd4uxYUlkdCmgG6b0?=
 =?us-ascii?Q?rUNxfe3BOPnVQAbPYbsvv/ypPTPiqVvasz8wATNxkxnd7zRJRlMEpo4BGFGv?=
 =?us-ascii?Q?H4KbPuuVH4BldudWXBeCQo5N9IrdjO2dND7dm8v7D9E2Rqg7LjjV/SIbYcrc?=
 =?us-ascii?Q?p5MfDmDwkTfm5TmLeUbbtk4CqdHfOqx1fw0bVh+nbaFV1oy5YhzB6T3s7mts?=
 =?us-ascii?Q?ikTOEgo5OyxWDyCU/DRdvdYrwbevAt18yPImX+UO81ycTzPUK7nDjeNUvKtH?=
 =?us-ascii?Q?3k3XFpptQkKsBEiZlw9YnEKFlg46k8/Tr5eG0fjJft+uLzGIiTsWHs9sErH/?=
 =?us-ascii?Q?u/ohOd8mRcCF6C3N05cggiiSwTXiME01DgYnHeJ4XqvJNvJvQp4Zfz9hG45F?=
 =?us-ascii?Q?xPFHXxymEPFK6XOsz4A3cwu4TO1HTrkc1sxafCIs5d/yWlh39JAaTg5/ddfN?=
 =?us-ascii?Q?KEoM4nByJz4Kyo8+7UcMI3Al8b9F4WS7N++4RXVOcmKlTgmq+Nv647ixu7+u?=
 =?us-ascii?Q?M4ovJsuRefbjXvOpK0axkScxJw//lBkgC3weFN4dcsadcMMy6ktDmMovnb8q?=
 =?us-ascii?Q?yRVhiLVUViFht0Ggy+QFhoeRuN+mwShWUqOFYb3G0GpxQgrUhBAXMlHkfa6E?=
 =?us-ascii?Q?qtS7E7dxEs9kN5CM7UtBLzYlNIcK3TEvb38o6sa6YJhrWa+iNp8cIuxvWlz5?=
 =?us-ascii?Q?uv5/BY0GO4mUa+pfcHI3QUKMG/Va5Spx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6376.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?g3DBt6atda9hI715kif84k+tKQTNvInbm6WCDG9mjSybHeL9pZ7Zk53earKl?=
 =?us-ascii?Q?JV7jQrlJkui1rneDfjVMgcayZhzVM3RNtwDAbD6TCslyFgKp5OjW+hZQdgs+?=
 =?us-ascii?Q?TVtOx6UJ2ejP10b8NddZFvh4MuHCxk9/ymoP90YD5QgazQ0fJneHfctjHImo?=
 =?us-ascii?Q?i9BYg5xtdsCAImQnkHZQpH0sxjQKEYu5BfwRwXxyEGaCSnwwU+Bo+p5GNqSs?=
 =?us-ascii?Q?UdD+h9glioKRZcZLHfuL4CKpuD3gw4VBcA+w2BjQ6e39D8ojyNioqltabKQi?=
 =?us-ascii?Q?zhH4wYWV/ewubtlr6WTUYqyrtOfNXyU3E0rsR8fButSP4UZkFRCjydk47C/B?=
 =?us-ascii?Q?cHa6OzxBUb8nC7K6ombvoi3UemJgk1lf4H4+d/r94SJy8TYh+tTtPmqGHCij?=
 =?us-ascii?Q?Xp3lFrpGPIiXC5b+GPOEEtuC/1GYki7OImtF961UPoRR4RegR4sZQSfGwEGR?=
 =?us-ascii?Q?TYiFAxUAZETWJc0XZXjZ95UtSCpFwiHrmDWIuL2v/6viLGf2TYwckXMP03rz?=
 =?us-ascii?Q?4aNnmKQSh+jV0NlR/rOt6A4WJfVrKeJZTX4mi38/TDPMIT9o9H847Ff2Cas4?=
 =?us-ascii?Q?LD/UeOsoOYDzwITCwJ7Sp6yrZO5RkRuXi9cv43okAvzpomMhAUzsPRF/LoeT?=
 =?us-ascii?Q?iCo7TIAB28V/ISBJ4nmIVgr0FbSM+l16lNfkdze7Ryznm0nHfBrHikyXKkpo?=
 =?us-ascii?Q?MpP1vjVXu4m/OigeaKHTZa6YqWEmsvSu76oHmffYw8MR8M+rko5LSZf34PkS?=
 =?us-ascii?Q?psIRc596rD9ywctQGO4YF+GYKudQ4wM+dWh5u+Ii4E8LtN6KmFeTdtung7sT?=
 =?us-ascii?Q?YoVm1O+2nxFKijp5UQ56CUCSbzAZJLfi3jmQqOyWLlSVq81fJOruv/1iniL1?=
 =?us-ascii?Q?t7uDYZFPFWYBoXX6t+gJBlV/sjkk0/9FttMRTO5jilhBnEEM2xyY8AQpQsBn?=
 =?us-ascii?Q?q9bYO+V/E4TS2DITaF3TZJoVBG+DvCM/iY4eartPuGI3ygqUtTtaGlB2Nqqm?=
 =?us-ascii?Q?Y+OZpegQa6YJGfzkWRBGftYQmJszUumReEH8qCZRobOzMMXHAISXpBQNv4xt?=
 =?us-ascii?Q?acTO6hlEAUVt3hTNqFF1nPP6w7TzAl8Po3uwP4KMJkU+AR8qlZYaCtv2Te9d?=
 =?us-ascii?Q?OWEjT3pDaSSG1Fqt6G3RK5MTQ7GE1+y+JTu6DTTI71CVX9bzbaNrM6V2eiLD?=
 =?us-ascii?Q?fjfjj1LcVmyySDHYWXzs+i6+MCGunPgRyWesIb+klXrfYNGJ8dfBxET8uJJY?=
 =?us-ascii?Q?tgK4pDjimezD3RJLNVVg3biWT87uKU+wKA5OGbGxBbkR66RuehJlCgrGuajW?=
 =?us-ascii?Q?DdB0bZ5Ho6Ov/Eghb4qDIJqeMGDM0ZluAeWG54w0BZlw1VAW8gJZv4gEQebL?=
 =?us-ascii?Q?hei/mdYYXFldHjPBcdhTNcg565VKDLYHkXSoUXkll7n/io+w8W2y58WGsbbh?=
 =?us-ascii?Q?YdiYJC7SpRJcow/QDYbPDMqCJK+FmNRSSCFvc+AekpGK+vfK/ADVZXFIJAoW?=
 =?us-ascii?Q?vceyPrM0FLFQ4maol3cwnw/fZTbfH+rSN4iPuMRZXcy2AhJpaTm5QapJpd/8?=
 =?us-ascii?Q?C3H48fAvRnqAszAaP/90xhehC3HJ4pnmy9zvjMXlpI7mOlR0jJPh5nN5GwtT?=
 =?us-ascii?Q?zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6376.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545b7f0c-5f5f-4566-c29b-08dd5fb2ba08
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 09:05:38.5847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pdSPTNOW2S89nA/hz9H4HLvToshCbYdvZxa7REEzLwkco8Qf75imb922d8Bcgwg+1Y93dFAiX55jz4ZiwJcgS4TT6F76SLvQ8t94OeX0bAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5549
X-Authority-Analysis: v=2.4 cv=RIZJH5i+ c=1 sm=1 tr=0 ts=67ceab65 cx=c_pps a=yfQ+ne3pfVgCfke9fm/9IQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=SWSBB-OmGhrEcGuGORYA:9 a=7WBuqRits6qg0dyG:21 a=CjuIK1q_8ugA:10 a=xjj0GC5SL0ELW4ibpBgG:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: bKL966jHYdRXVE1HRvqS6Gh4xNenu5YG
X-Proofpoint-ORIG-GUID: bKL966jHYdRXVE1HRvqS6Gh4xNenu5YG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_03,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100071



> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Sunday, December 22, 2024 2:09 AM
> To: Libetario, Kent <Kent.Libetario@analog.com>
> Cc: linux-hwmon@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Jean Delvare <jdelvare@suse.com>; Rob Herring
> <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>
> Subject: Re: [PATCH 2/2] drivers: hwmon: add driver for max42500
>=20
> [External]
>=20
> On Fri, Dec 20, 2024 at 09:20:03AM +0800, Kent Libetario wrote:
> > Add the core implementation of the MAX42500 hwmon driver.
> >
>=20
> Please have a look into Documentation/process/submitting-patches.rst
> and follow the guidance about describing patches.
>=20

Yes, I will look into the documentation and update the patch descriptions.

> > Signed-off-by: Kent Libetario <Kent.Libetario@analog.com>
> > ---
> >  MAINTAINERS              |    1 +
> >  drivers/hwmon/Kconfig    |   13 +
> >  drivers/hwmon/Makefile   |    1 +
> >  drivers/hwmon/max42500.c | 1049
> > ++++++++++++++++++++++++++++++++++++++
>=20
> Documentation missing.
>=20
> There is a large number of checkpatch CHECK messages, almost all about mu=
lti-
> line alignment. Indeed, when looking through the code, multi-line aligmen=
t
> seems arbitrary. Please fix.
>=20
> PEC support should be implemented through the i2c controller driver.
> Please see other drivers such as lm90.c or max31827.c for examples how to=
 do
> that.
>=20
> Some more comments inline. The review is partial. The major problem I see=
 is
> that there are not just a few but _lots_ of ABI violations.
> This is unacceptable. Please rework the driver and follow the hwmon ABI f=
or all
> sysfs attributes.
>=20
> Guenter
>=20

Yes, I have reworked the driver and that is why it took me sometime to repl=
y
from your review comments due to a large revision. I have fixed the alignme=
nt
format issues updated the code and added the documentation as you instructe=
d
and from the driver references you provided.

I have initiated also to divide the drivers into three, including hwmon dri=
ver.
The other 2 drivers are the mfd and watchdog drivers using their own ABI sy=
sfs
attributes standards. Also, I have used debugfs for the non-standard attrib=
utes
in all of three drivers that are not defined in their ABI sysfs document.

Thanks,
Kent


> >  4 files changed, 1064 insertions(+)
> >  create mode 100644 drivers/hwmon/max42500.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index
> > d1703b4834c8..434191e16dd5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14051,6 +14051,7 @@ M:	Kent Libetario <kent.libetario@analog.com>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Supported
> >  F:	Documentation/devicetree/bindings/hwmon/adi,max42500.yaml
> > +F:	drivers/hwmon/max42500.c
> >
> >  MAX6650 HARDWARE MONITOR AND FAN CONTROLLER DRIVER
> >  L:	linux-hwmon@vger.kernel.org
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig index
> > dd376602f3f1..ec0d7aad7789 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1220,6 +1220,19 @@ config MAX31827
> >  	  This driver can also be built as a module.  If so, the module
> >  	  will be called max31827.
> >
> > +config SENSORS_MAX42500
> > +	tristate "MAX42500 Industrial Power System Monitor Family"
> > +	depends on I2C
> > +	select REGMAP_I2C
> > +	help
> > +	  If you say yes here you get support for MAX42500 SoC power-system
> monitor
> > +	  with up to seven voltage monitor. The driver also contains a
> programmable
> > +	  challenge/response watchdog, which is accessible through the I2C
> interface,
> > +	  along with a configurable RESET output.
> > +
> > +	  This driver can also be built as a module.  If so, the module
> > +	  will be called max42500.
> > +
> >  config SENSORS_MAX6620
> >  	tristate "Maxim MAX6620 fan controller"
> >  	depends on I2C
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile index
> > b827b92f2a78..d27d8fc01141 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -152,6 +152,7 @@ obj-$(CONFIG_SENSORS_MAX197)	+=3D max197.o
> >  obj-$(CONFIG_SENSORS_MAX31722)	+=3D max31722.o
> >  obj-$(CONFIG_SENSORS_MAX31730)	+=3D max31730.o
> >  obj-$(CONFIG_SENSORS_MAX31760)  +=3D max31760.o
> > +obj-$(CONFIG_SENSORS_MAX42500)  +=3D max42500.o
> >  obj-$(CONFIG_SENSORS_MAX6620)	+=3D max6620.o
> >  obj-$(CONFIG_SENSORS_MAX6621)	+=3D max6621.o
> >  obj-$(CONFIG_SENSORS_MAX6639)	+=3D max6639.o
> > diff --git a/drivers/hwmon/max42500.c b/drivers/hwmon/max42500.c new
> > file mode 100644 index 000000000000..23b90c766767
> > --- /dev/null
> > +++ b/drivers/hwmon/max42500.c
> > @@ -0,0 +1,1049 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * MAX42500 - Industrial Power System Monitor
> > + *
> > + * Copyright 2024 Analog Devices Inc.
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/slab.h>
> > +#include <linux/crc8.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/err.h>
> > +#include <linux/gpio.h>
> > +#include <linux/gpio/driver.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/i2c.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> > +
> > +/* Implements Polynomial X^8 + X^2 + X^1 +1 */
> > +#define CRC8_PEC		0x07
> > +
> > +DECLARE_CRC8_TABLE(max42500_crc8);
> > +
> > +#define MAX42500_REG_ID					0x00
> > +#define MAX42500_REG_CONFIG1			0x01
> > +#define MAX42500_REG_CONFIG2			0x02
> > +#define MAX42500_REG_VMON				0x03
> > +#define MAX42500_REG_RSTMAP				0x04
> > +#define MAX42500_REG_STATOV				0x05
> > +#define MAX42500_REG_STATUV				0x06
> > +#define MAX42500_REG_STATOFF			0x07
> > +#define MAX42500_REG_VIN1				0x08
> > +#define MAX42500_REG_VIN2				0x09
> > +#define MAX42500_REG_VIN3				0x0A
> > +#define MAX42500_REG_VIN4				0x0B
> > +#define MAX42500_REG_VIN5				0x0C
> > +#define MAX42500_REG_VINO6				0x0D
> > +#define MAX42500_REG_VINU6				0x0E
> > +#define MAX42500_REG_VINO7				0x0F
> > +#define MAX42500_REG_VINU7				0x10
> > +#define MAX42500_REG_OVUV1				0x11
> > +#define MAX42500_REG_OVUV2				0x12
> > +#define MAX42500_REG_OVUV3				0x13
> > +#define MAX42500_REG_OVUV4				0x14
> > +#define MAX42500_REG_OVUV5				0x15
> > +#define MAX42500_REG_FPSSTAT1			0x16
> > +#define MAX42500_REG_FPSCFG1			0x17
> > +#define MAX42500_REG_UTIME1				0x18
> > +#define MAX42500_REG_UTIME2				0x19
> > +#define MAX42500_REG_UTIME3				0x1A
> > +#define MAX42500_REG_UTIME4				0x1B
> > +#define MAX42500_REG_UTIME5				0x1C
> > +#define MAX42500_REG_UTIME6				0x1D
> > +#define MAX42500_REG_UTIME7				0x1E
> > +#define MAX42500_REG_DTIME1				0x1F
> > +#define MAX42500_REG_DTIME2				0x20
> > +#define MAX42500_REG_DTIME3				0x21
> > +#define MAX42500_REG_DTIME4				0x22
> > +#define MAX42500_REG_DTIME5				0x23
> > +#define MAX42500_REG_DTIME6				0x24
> > +#define MAX42500_REG_DTIME7				0x25
> > +#define MAX42500_REG_WDSTAT				0x26
> > +#define MAX42500_REG_WDCDIV				0x27
> > +#define MAX42500_REG_WDCFG1				0x28
> > +#define MAX42500_REG_WDCFG2				0x29
> > +#define MAX42500_REG_WDKEY				0x2A
> > +#define MAX42500_REG_WDLOCK				0x2B
> > +#define MAX42500_REG_RSTCTRL			0x2C
> > +#define MAX42500_REG_CID				0x2D
> > +
> > +/** X is set based on the pull configuration of the ADDR pin */
> > +#define MAX42500_ADDR(x)				(0x28 + (x))
> > +#define MAX42500_SILICON_ID				(0x30)
> > +#define MAX42500_I2C_WR_FRAME_SIZE		(4)
> > +#define MAX42500_I2C_RD_FRAME_SIZE		(5)
> > +
> > +/** MAX42500 Nominal voltage computation */
> > +#define MAX42500_VNOM_MAX_VM1_VM4		0xFF	// 3.6875v
> > +#define MAX42500_VNOM_MAX_VM5			0xFF	// 5.6v
> > +#define MAX42500_MIN_VNOM				0x00	// 0.5v
> > +#define MAX42500_VNOM_STEP_VM1_VM4		0x01	// 0.0125v
> > +#define MAX42500_VNOM_STEP_VM5			0x01	// 0.02v
> > +
> > +/** MAX42500 Undervoltage/Overvoltage maximum and minimum
> thresholds*/
> > +#define MAX42500_MAX_THRESH_VM1_VM5		0x0F	// OV =3D 110.0%,
> UV =3D 90.0%
> > +#define MAX42500_MIN_THRESH_VM1_VM5		0x00	// OV =3D 102.5%,
> UV =3D 97.5%
> > +#define MAX42500_MAX_THRESH_VM6_V7		0xFF	// 1.775v
> > +#define MAX42500_MIN_THRESH_VM6_V7		0x00	// 0.5v
> > +
> > +/* CONFIG1 bit masks */
> > +#define MAX42500_CONFIG1_PECE_MASK		BIT(0)
> > +#define MAX42500_CONFIG1_MBST_MASK		BIT(1)
> > +#define MAX42500_CONFIG1_RR_MASK		BIT(2)
> > +
> > +/* VMON bit masks */
> > +#define MAX42500_VMON_IN_MASK(bit)		BIT(bit)
> > +#define MAX42500_VMON_VMPD_MASK			BIT(7)
> > +
> > +/* RSTMAP bit masks */
> > +#define MAX42500_RSTMAP_IN_MASK(bit)	BIT(bit)
> > +#define MAX42500_RSTMAP_PARM_MASK		BIT(7)
> > +
> > +/* WDCDIV bit masks */
> > +#define MAX42500_WDCDIV_SWW_MASK		BIT(6)
> > +#define MAX42500_WDCDIV_WDIC_MASK		(0x3F)
> > +
> > +/* WDCFG2 bit masks */
> > +#define MAX42500_WDCFG2_WDEN_MASK		BIT(3)
> > +#define MAX42500_WDCFG2_1UP_MASK		(0x7)
> > +
> > +/* WDLOCK bit masks */
> > +#define MAX42500_WDLOCK_LOCK_MASK		BIT(0)
> > +
> > +/* RSTCTRL bit masks */
> > +#define MAX42500_RSTCTRL_MR1_MASK		BIT(2)
> > +#define MAX42500_RSTCTRL_RHLD_MASK		(0x3)
> > +
> > +/* MAX42500 device status */
> > +enum max42500_status {
> > +	MAX42500_STATUS_OFF,
> > +	MAX42500_STATUS_SLEEP,
> > +	MAX42500_STATUS_ON,
> > +	MAX42500_STATUS_MAX
> > +};
> > +
> > +/* MAX42500 voltage monitor input */
> > +enum max42500_vm_input {
> > +	MAX42500_VM1,
> > +	MAX42500_VM2,
> > +	MAX42500_VM3,
> > +	MAX42500_VM4,
> > +	MAX42500_VM5,
> > +	MAX42500_VM6,
> > +	MAX42500_VM7,
> > +	MAX42500_VM_MAX
> > +};
> > +
> > +/* MAX42500 comparator status */
> > +enum max42500_comp_stat {
> > +	MAX42500_COMP_STAT_OFF,
> > +	MAX42500_COMP_STAT_UV,
> > +	MAX42500_COMP_STAT_OV,
> > +	MAX42500_COMP_STAT_MAX
> > +};
> > +
> > +/* MAX42500 watchdog mode */
> > +enum max42500_wd_mode {
> > +	MAX42500_WD_MODE_CH_RESP,
> > +	MAX42500_WD_MODE_SIMPLE,
> > +	MAX42500_WD_MODE_MAX
> > +};
> > +
> > +/* MAX42500 reset hold/active timeout time. */ enum max42500_wd_rhld
> > +{
> > +	MAX42500_WD_RHOLD_0_MS,
> > +	MAX42500_WD_RHOLD_8_MS,
> > +	MAX42500_WD_RHOLD_16_MS,
> > +	MAX42500_WD_RHOLD_32_MS,
> > +	MAX42500_WD_RHOLD_MAX
> > +};
> > +
> > +struct max42500_config {
> > +	/* Packet error checking enable */
> > +	u8 pece;
> > +	/* Enabled voltage monitor inputs */
> > +	u8 vmon_en;
> > +	/* Voltage monitor power down enable */
> > +	u8 vmon_vmpd;
> > +	/* Enabled voltage monitor reset mapping */
> > +	u8 reset_map;
> > +	/* Watchdog mode */
> > +	enum max42500_wd_mode wd_mode;
> > +	/* Watchdog clock div */
> > +	u8 wd_cdiv;
> > +	/* Watchdog close window */
> > +	u8 wd_close;
> > +	/* Watchdog open window */
> > +	u8 wd_open;
> > +	/* Watchdog first update window */
> > +	u8 wd_1ud;
> > +	/* Watchdog enable */
> > +	u8 wd_en;
> > +};
> > +
> > +struct max42500_state {
> > +	struct i2c_client *client;
> > +	struct regmap *regmap;
> > +	struct max42500_config *config;
> > +	long pwrup_stamp[MAX42500_VM_MAX];
> > +	long pwrdn_stamp[MAX42500_VM_MAX];
> > +	u8 ov_thresh1[MAX42500_VM_MAX - 2];
> > +	u8 ov_thresh2[MAX42500_VM_MAX - 5];
> > +	u8 uv_thresh1[MAX42500_VM_MAX - 2];
> > +	u8 uv_thresh2[MAX42500_VM_MAX - 5];
> > +	u8 nominal_volt[MAX42500_VM_MAX - 2];
> > +	u8 comp_status[MAX42500_VM_MAX * MAX42500_COMP_STAT_MAX]; };
> > +
> > +/************************ Functions Definitions
> > +**************************/
> > +/**
> > + * @brief Read a raw value from a register.
> > + * @return 0 in case of success, error code otherwise.
> > + */
> > +static int max42500_reg_read(struct max42500_state *st,
> > +								u8 reg_addr, u8
> *reg_data)
> > +{
> > +	int ret;
> > +	u8 i2c_data[MAX42500_I2C_RD_FRAME_SIZE] =3D {0};
> > +	u8 bytes_num;
> > +	u8 pece_value;
> > +
> > +	/* PEC is computed over entire I2C frame from first START condition *=
/
> > +	i2c_data[0] =3D (st->client->addr << 1);
> > +	i2c_data[1] =3D reg_addr;
> > +	i2c_data[2] =3D (st->client->addr << 1) | 0x1;
> > +
> > +	/* I2C write target address */
> > +	bytes_num =3D 1;
> > +
> > +	ret =3D regmap_bulk_write(st->regmap, reg_addr, &i2c_data[1],
> bytes_num);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Change byte count if PECE is enabled (1-byte data. 1-byte PEC) */
> > +	bytes_num =3D (st->config->pece) ? 2 : bytes_num;
> > +
> > +	ret =3D regmap_bulk_read(st->regmap, reg_addr, &i2c_data[3],
> bytes_num);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (st->config->pece) {
> > +		/* Compute CRC over entire I2C frame */
> > +		pece_value =3D crc8(max42500_crc8, i2c_data,
> > +
> 	(MAX42500_I2C_RD_FRAME_SIZE - 1), 0);
> > +
> > +		if (i2c_data[4] !=3D pece_value)
> > +			return -EIO;
> > +	}
> > +
> > +	*reg_data =3D i2c_data[3];
> > +
> > +	return 0;
>=20
> This seems to re-implement PEC support in the driver. As mentioned, PEC
> support should be handled in the i2c controller driver.
>=20

Yes, I will update the code to reflect you instructions to use the i2c driv=
er's
PEC implementation.

> Also, _if_ it is for some reasons necessary to implement chip access func=
tions,
> those should be implemented as regmap bus. The functional part of the dri=
ver
> should just use regmap functions to access the chip.
>=20

Yes, I agree and will update the code to use regmap functions as you instru=
cted.

> > +}
> > +
> > +/**
> > + * @brief Write a raw value to a register.
> > + * @return 0 in case of success, negative error code otherwise.
> > + */
> > +static int max42500_reg_write(struct max42500_state *st,
> > +								u8 reg_addr, u8 data)
> > +{
> > +	u8 i2c_data[MAX42500_I2C_WR_FRAME_SIZE] =3D {0};
> > +	u8 bytes_num;
> > +	u8 pece_value;
> > +
> > +	bytes_num =3D (st->config->pece) ? (MAX42500_I2C_WR_FRAME_SIZE - 1) :
> 2;
> > +	i2c_data[0] =3D (st->client->addr << 1);
> > +	i2c_data[1] =3D reg_addr;
> > +	i2c_data[2] =3D (u8)(data & 0xFF);
> > +
> > +	pece_value =3D 0;
> > +	if (st->config->pece)
> > +		pece_value =3D crc8(max42500_crc8, i2c_data, bytes_num, 0);
> > +
> > +	i2c_data[0] =3D i2c_data[1];
> > +	i2c_data[1] =3D i2c_data[2];
> > +	i2c_data[2] =3D pece_value;
> > +
> > +	return regmap_bulk_write(st->regmap, reg_addr, i2c_data, bytes_num);
> > +}
> > +
> > +/**
> > + * @brief Update a register's value based on a mask.
> > + * @return 0 in case of success, negative error code otherwise.
>=20
> Please fix.
>=20

Yes, will do.

> > + */
> > +static int max42500_reg_update(struct max42500_state *st,
> > +								u8 reg_addr, u8 mask,
> u8 data) {
> > +	int ret;
> > +	u8 reg_data;
> > +
> > +	ret =3D max42500_reg_read(st, reg_addr, &reg_data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	reg_data &=3D ~mask;
> > +	reg_data |=3D mask & data;
> > +
> > +	return max42500_reg_write(st, reg_addr, reg_data); }
> > +
> > +/**
> > + * @brief Set nominal voltage for VM1 to VM5.
> > + * @return 0 in case of success, negative error code otherwise.
> > + */
> > +static int max42500_set_nominal_voltage(struct max42500_state *st,
> > +	enum max42500_vm_input vm_in, u8 voltage) {
> > +	u8 reg_addr;
> > +
> > +	switch (vm_in) {
> > +	case MAX42500_VM1:
> > +	case MAX42500_VM2:
> > +	case MAX42500_VM3:
> > +	case MAX42500_VM4:
> > +		if (voltage < MAX42500_MIN_VNOM ||
> > +			voltage > MAX42500_VNOM_MAX_VM1_VM4)
> > +			return -EINVAL;
>=20
> The driver should use clamp_val() for value boundary control.
>=20

Yes, I will update the code according to your instructions.

> > +		reg_addr =3D MAX42500_REG_VIN1 + vm_in;
> > +		break;
> > +	case MAX42500_VM5:
> > +		if (voltage < MAX42500_MIN_VNOM ||
> > +			voltage > MAX42500_VNOM_MAX_VM5)
> > +			return -EINVAL;
> > +		reg_addr =3D MAX42500_REG_VIN5;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	st->nominal_volt[vm_in] =3D voltage;
>=20
> I fail to understand how this is supposed to work. The locally cached val=
ues are
> set (only) here, with a sysfs attribute. During probe they are not set, m=
eaning
> the input attribute won't be available because it is only created if nomi=
nal_volt
> is set which is not the case at that time. That doesn't make sense. There=
 needs
> to be some default.
>=20

I will update the code to get first the latest value from the userspace by =
the
sysfs attributes or from the device registers, since the device itself alre=
ady
has default OTP initial values setting.

> Also, the whole point of using regmap is that regmap provides caching. Th=
e code
> should use that facility instead of caching locally.
>=20

Yes, I will update the code to reflect the proper usage of regmap according=
 to
your instructions.

> > +	return max42500_reg_write(st, reg_addr, voltage); }
> > +
> > +/**
> > + * @brief Get the status of the voltage monitor input.
> > + * @return 0 in case of success, negative error code otherwise.
> > + */
> > +static int max42500_get_comp_status(struct max42500_state *st,
> > +									u8 vm_in, u8
> *status)
> > +{
> > +	int ret;
> > +	u8 reg_addr;
> > +	u8 vm_in_status;
> > +
> > +	switch (vm_in % MAX42500_COMP_STAT_MAX) {
> > +	case MAX42500_COMP_STAT_OFF:
> > +		reg_addr =3D MAX42500_REG_STATOFF;
> > +		break;
> > +	case MAX42500_COMP_STAT_UV:
> > +		reg_addr =3D MAX42500_REG_STATUV;
> > +		break;
> > +	case MAX42500_COMP_STAT_OV:
> > +		reg_addr =3D MAX42500_REG_STATOV;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret =3D max42500_reg_read(st, reg_addr, &vm_in_status);
> > +	if (ret)
> > +		return ret;
> > +
> > +	switch (vm_in % MAX42500_VM_MAX) {
> > +	case MAX42500_VM1:
> > +		*status =3D (u8)FIELD_GET(BIT(MAX42500_VM1), vm_in_status);
> > +		break;
> > +	case MAX42500_VM2:
> > +		*status =3D (u8)FIELD_GET(BIT(MAX42500_VM2), vm_in_status);
> > +		break;
> > +	case MAX42500_VM3:
> > +		*status =3D (u8)FIELD_GET(BIT(MAX42500_VM3), vm_in_status);
> > +		break;
> > +	case MAX42500_VM4:
> > +		*status =3D (u8)FIELD_GET(BIT(MAX42500_VM4), vm_in_status);
> > +		break;
> > +	case MAX42500_VM5:
> > +		*status =3D (u8)FIELD_GET(BIT(MAX42500_VM5), vm_in_status);
> > +		break;
> > +	case MAX42500_VM6:
> > +		*status =3D (u8)FIELD_GET(BIT(MAX42500_VM6), vm_in_status);
> > +		break;
> > +	case MAX42500_VM7:
> > +		*status =3D (u8)FIELD_GET(BIT(MAX42500_VM7), vm_in_status);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +	st->comp_status[vm_in] =3D *status;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * @brief Set the overvoltage threshold of VM1 to VM5.
> > + * @return 0 in case of success, negative error code otherwise.
> > + */
> > +static int max42500_set_ov_thresh1(struct max42500_state *st,
> > +	enum max42500_vm_input vm_in, u8 thresh) {
> > +	if (thresh < MAX42500_MIN_THRESH_VM1_VM5 ||
> > +		thresh > MAX42500_MAX_THRESH_VM1_VM5)
> > +		return -EINVAL;
> > +
> > +	switch (vm_in) {
> > +	case MAX42500_VM1:
> > +	case MAX42500_VM2:
> > +	case MAX42500_VM3:
> > +	case MAX42500_VM4:
> > +	case MAX42500_VM5:
> > +		st->ov_thresh1[vm_in] =3D thresh;
> > +		return max42500_reg_update(st,
> > +
> 	MAX42500_REG_OVUV1 + vm_in,
> > +								GENMASK(7, 4),
> > +
> 	FIELD_PREP(GENMASK(7, 4),
> > +								thresh));
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +/**
> > + * @brief Set the overvoltage threshold of VM6 and VM7.
> > + * @return 0 in case of success, negative error code otherwise.
> > + */
> > +static int max42500_set_ov_thresh2(struct max42500_state *st,
> > +	enum max42500_vm_input vm_in, u8 thresh) {
> > +	u8 reg_addr;
> > +
> > +	if (thresh < MAX42500_MIN_THRESH_VM6_V7 ||
> > +		thresh > MAX42500_MAX_THRESH_VM6_V7)
> > +		return -EINVAL;
> > +
> > +	switch (vm_in) {
> > +	case MAX42500_VM6:
> > +		reg_addr =3D MAX42500_REG_VINO6;
> > +		break;
> > +	case MAX42500_VM7:
> > +		reg_addr =3D MAX42500_REG_VINO7;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	st->ov_thresh2[vm_in] =3D thresh;
> > +	return max42500_reg_write(st, reg_addr, thresh); }
> > +
> > +/**
> > + * @brief Set the undervoltage threshold of VM1 to VM5.
> > + * @return 0 in case of success, negative error code otherwise.
> > + */
> > +static int max42500_set_uv_thresh1(struct max42500_state *st,
> > +	enum max42500_vm_input vm_in, u8 thresh) {
> > +	if (thresh < MAX42500_MIN_THRESH_VM1_VM5 ||
> > +		thresh > MAX42500_MAX_THRESH_VM1_VM5)
> > +		return -EINVAL;
> > +
> > +	switch (vm_in) {
> > +	case MAX42500_VM1:
> > +	case MAX42500_VM2:
> > +	case MAX42500_VM3:
> > +	case MAX42500_VM4:
> > +	case MAX42500_VM5:
> > +		st->uv_thresh1[vm_in] =3D thresh;
> > +		return max42500_reg_update(st,
> > +					MAX42500_REG_OVUV1 + vm_in,
> > +					GENMASK(3, 0),
> > +					thresh);
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +/**
> > + * @brief Set the undervoltage threshold of VM6 and VM7.
> > + * @return 0 in case of success, negative error code otherwise.
> > + */
> > +static int max42500_set_uv_thresh2(struct max42500_state *st,
> > +	enum max42500_vm_input vm_in, u8 thresh) {
> > +	u8 reg_addr;
> > +
> > +	if (thresh < MAX42500_MIN_THRESH_VM6_V7 ||
> > +		thresh > MAX42500_MAX_THRESH_VM6_V7)
> > +		return -EINVAL;
> > +
> > +	switch (vm_in) {
> > +	case MAX42500_VM6:
> > +		reg_addr =3D MAX42500_REG_VINU6;
> > +		break;
> > +	case MAX42500_VM7:
> > +		reg_addr =3D MAX42500_REG_VINU7;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	st->uv_thresh2[vm_in] =3D thresh;
> > +	return max42500_reg_write(st, reg_addr, thresh); }
> > +
> > +/**
> > + * @brief Get the FPS clock divider value.
> > + * @return 0 in case of success, negative error code otherwise.
> > + */
> > +static int max42500_get_fps_clk_div(struct max42500_state *st,
> > +	u8 *fps_clk_div)
> > +{
> > +	int ret;
> > +	u8 reg_val;
> > +
> > +	ret =3D max42500_reg_read(st, MAX42500_REG_FPSCFG1, &reg_val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*fps_clk_div =3D (u8)FIELD_GET(GENMASK(2, 0), reg_val);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * @brief Get power-up timestamp for a specified voltage monitor input=
.
> > + * @return 0 in case of success, negative error code otherwise.
> > + */
> > +static int max42500_get_power_up_timestamp(struct max42500_state *st,
> > +	enum max42500_vm_input vm_in, long *timestamp) {
> > +	int ret;
> > +	u8 reg_val;
> > +	u8 fps_clk_div;
> > +
> > +	ret =3D max42500_reg_read(st, MAX42500_REG_UTIME1 + vm_in,
> &reg_val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Check if the input voltage rose above the UV threshold */
> > +	if (reg_val =3D=3D 0) {
> > +		/* Input voltage never rose above UV threshold*/
> > +		*timestamp =3D 0;
> > +		return 0;
> > +	}
> > +
> > +	ret =3D max42500_get_fps_clk_div(st, &fps_clk_div);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*timestamp =3D (reg_val - 1) * 25 * (1 << fps_clk_div);
> > +	st->pwrup_stamp[vm_in] =3D *timestamp;
> > +	return 0;
> > +}
> > +
> > +/**
> > + * @brief Get power-down timestamp for a specified voltage monitor inp=
ut.
> > + * @return 0 in case of success, negative error code otherwise.
> > + */
> > +static int max42500_get_power_down_timestamp(struct max42500_state *st=
,
> > +	enum max42500_vm_input vm_in, long *timestamp) {
> > +	int ret;
> > +	u8 reg_val;
> > +	u8 fps_clk_div;
> > +
> > +	ret =3D max42500_reg_read(st, MAX42500_REG_DTIME1 + vm_in,
> &reg_val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Check if the input voltage fell below the OFF threshold */
> > +	if (reg_val =3D=3D 0) {
> > +		/* Input voltage never fell below OFF threshold */
> > +		*timestamp =3D 0;
> > +		return 0;
> > +	}
> > +
> > +	ret =3D max42500_get_fps_clk_div(st, &fps_clk_div);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*timestamp =3D (reg_val - 1) * 25 * (1 << fps_clk_div);
> > +	st->pwrdn_stamp[vm_in] =3D *timestamp;
> > +	return 0;
> > +}
> > +
> > +/**
> > + * @brief Enable/Disable watchdog
> > + * @return 0 in case of success, error code otherwise  */ static int
> > +max42500_set_watchdog_enable(struct max42500_state *st,
> > +										bool
> wd_enable)
> > +{
> > +	int ret;
> > +	u8 reg_val;
> > +
> > +	ret =3D max42500_reg_read(st, MAX42500_REG_WDCFG2, &reg_val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (wd_enable)
> > +		reg_val |=3D BIT(3);
> > +	else
> > +		reg_val &=3D ~BIT(3);
> > +
> > +	return max42500_reg_write(st, MAX42500_REG_WDCFG2, reg_val); }
> > +
> > +/**
> > + * @brief 8-bit watchdog key computation.
> > + * @return 0 in case of success, negative error code otherwise.
> > + */
> > +static int max42500_get_watchdog_key(struct max42500_state *st,
> > +										u8
> *new_wd_key)
> > +{
> > +	int ret;
> > +	u8 curr_wd_key;
> > +
> > +	ret =3D max42500_reg_read(st, MAX42500_REG_WDKEY, &curr_wd_key);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Calculate the new bit using the LFSR polynomial */
> > +	u8 new_bit =3D ((curr_wd_key >> 7) ^
> > +					(curr_wd_key >> 5) ^
> > +					(curr_wd_key >> 4) ^
> > +					(curr_wd_key >> 3)) & 0x01;
> > +
> > +	/* Shift existing bits upwards to MSb and insert the new bit as LSb *=
/
> > +	*new_wd_key =3D (curr_wd_key << 1) | new_bit;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * @brief Update the watchdog key based on the mode and current value.
> > + * @return 0 in case of success, error code otherwise.
> > + */
> > +static int max42500_set_watchdog_key(struct max42500_state *st) {
> > +	int ret;
> > +	u8 reg_val;
> > +	u8 wd_key;
> > +	u8 wd_mode;
> > +
> > +	ret =3D max42500_reg_read(st, MAX42500_REG_WDKEY, &wd_key);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D max42500_reg_read(st, MAX42500_REG_WDCDIV, &reg_val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	wd_mode =3D (u8)FIELD_GET(BIT(6), reg_val);
> > +
> > +	/* Compute new watchdog key for challenge/response mode */
> > +	if (wd_mode =3D=3D MAX42500_WD_MODE_CH_RESP)
> > +		max42500_get_watchdog_key(st, &wd_key);
> > +
> > +	return max42500_reg_write(st, MAX42500_REG_WDKEY, wd_key); }
> > +
> > +/** @brief Set watchdog reset hold time
> > + * @return 0 in case of success, error code otherwise  */ static int
> > +max42500_set_watchdog_rhld(struct max42500_state *st, u8 rhld) {
> > +	return max42500_reg_update(st,
> > +
> 	MAX42500_REG_RSTCTRL,
> > +								GENMASK(1, 0),
> > +								rhld);
> > +}
> > +
> > +static umode_t max42500_is_visible(const void *data,
> > +	enum hwmon_sensor_types type, u32 attr, int channel) {
> > +	const struct max42500_state *st =3D data;
> > +
> > +	switch (type) {
> > +	case hwmon_chip:
> > +		switch (attr) {
> > +		case hwmon_chip_in_reset_history:
> > +			if (st->pwrup_stamp[channel])
> > +				return 0444;
> > +			break;
> > +		case hwmon_chip_curr_reset_history:
> > +			if (st->pwrdn_stamp[channel])
> > +				return 0444;
> > +			break;
> > +		case hwmon_chip_register_tz:
> > +			return 0200;
> > +		case hwmon_chip_alarms:
> > +		case hwmon_chip_update_interval:
> > +		case hwmon_chip_temp_reset_history:
> > +		case hwmon_chip_power_reset_history:
> > +			return 0644;
> > +		}
> > +		break;
> > +	case hwmon_in:
> > +		switch (attr) {
> > +		case hwmon_in_input:
> > +			if (st->nominal_volt[channel])
> > +				return 0644;
> > +			break;
> > +		case hwmon_in_lowest:
> > +			if (st->ov_thresh1[channel])
> > +				return 0644;
> > +			break;
> > +		case hwmon_in_highest:
> > +			if (st->ov_thresh2[channel])
> > +				return 0644;
> > +			break;
> > +		case hwmon_in_min:
> > +			if (st->uv_thresh1[channel])
> > +				return 0644;
> > +			break;
> > +		case hwmon_in_max:
> > +			if (st->uv_thresh2[channel])
> > +				return 0644;
> > +			break;
> > +		case hwmon_in_label:
> > +			if (st->comp_status[channel])
> > +				return 0444;
> > +			break;
> > +		}
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int max42500_read_in(struct device *dev, u32 attr, int channel,
> > +							long *value)
> > +{
> > +	struct max42500_state *st =3D dev_get_drvdata(dev);
> > +
> > +	switch (attr) {
> > +	case hwmon_in_label:
> > +		return max42500_get_comp_status(st, channel, (u8 *)value);
>=20
> The label atribute is supposed to return a text.
>=20

Yes, I agree and will update the code according to the ABI sysfs standards.

> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +}
> > +
> > +static int max42500_read_chip(struct device *dev, u32 attr, int channe=
l,
> > +								long *value)
> > +{
> > +	struct max42500_state *st =3D dev_get_drvdata(dev);
> > +
> > +	switch (attr) {
> > +	case hwmon_chip_in_reset_history:
> > +		return max42500_get_power_up_timestamp(st, channel, value);
> > +	case hwmon_chip_curr_reset_history:
> > +		return max42500_get_power_down_timestamp(st, channel,
> value);
> > +	case hwmon_chip_power_reset_history:
> > +		return max42500_get_watchdog_key(st, (u8 *)value);
> > +	case hwmon_chip_update_interval:
> > +		return max42500_get_fps_clk_div(st, (u8 *)value);
>=20
> More ABI violations.
>=20

Yes, I agree and will update the code according to the ABI sysfs standards.

> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +}
> > +
> > +static int max42500_read(struct device *dev, enum hwmon_sensor_types
> type,
> > +							u32 attr, int channel, long
> *value) {
> > +	switch (type) {
> > +	case hwmon_chip:
> > +		return max42500_read_chip(dev, attr, channel, value);
> > +	case hwmon_in:
> > +		return max42500_read_in(dev, attr, channel, value);
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +}
> > +
> > +static int max42500_write_in(struct device *dev, u32 attr, int channel=
,
> > +								long value)
> > +{
> > +	struct max42500_state *st =3D dev_get_drvdata(dev);
> > +
> > +	switch (attr) {
> > +	case hwmon_in_input:
> > +		return max42500_set_nominal_voltage(st, channel, (u8)value);
>=20
> This is an ABI violation: inX_input attributes return voltages provided b=
y the
> chip, and are not writeable. Looking into the datasheet, this has to be s=
et using
> the min/max attributes.
>=20

Yes, I agree and will update the code to reflect your instructions and add =
the
ABI documentation to address the violations.

> > +	case hwmon_in_min:
> > +		return max42500_set_uv_thresh1(st, channel, (u8)value);
>=20
> This is a severe ABI violation. First, again, "(u8)value" is unacceptable=
.
> Second, the ABI states that this is a value in mV, not a percentage.
> I don't know why the chip uses a concept of "nominal voltage" and percent=
ages
> of that for thresholds. I undersatand that this makes working with the ch=
ip
> difficult, but that does not mean that ABI violations are acceptable.
>=20
> AFAICS the chip doesn't even report the current voltages, so any inX_inpu=
t
> attributes must not be provided. The limit attributes must set limits in =
mV.
>=20

Yes, I agree and have a discussion with the hardware application engineers.
I will update the code to reflect the appropriate attributes that can be us=
ed
for the "nominal voltage" and the percentages for the OV/UV thresholds.

For the limits, can we use uV to address the decimal part of mV, e.g. 12.5m=
V?

> > +	case hwmon_in_max:
> > +		return max42500_set_uv_thresh2(st, channel, (u8)value);
> > +	case hwmon_in_lowest:
> > +		return max42500_set_ov_thresh1(st, channel, (u8)value);
> > +	case hwmon_in_highest:
> > +		return max42500_set_ov_thresh2(st, channel, (u8)value);
>=20
> This looks like another ABI violation. _lowest and _highest_ attributes r=
eport
> historic values.
>=20

Yes, I agree and will update the code and add ABI documentation to address
the violations.

> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +}
> > +
> > +static int max42500_write_chip(struct device *dev, u32 attr, int chann=
el,
> > +								long value)
> > +{
> > +	struct max42500_state *st =3D dev_get_drvdata(dev);
> > +
> > +	switch (attr) {
> > +	case hwmon_chip_temp_reset_history:
> > +		return max42500_set_watchdog_rhld(st, (u8)value);
> > +	case hwmon_chip_register_tz:
> > +		return max42500_set_watchdog_key(st);
> > +	case hwmon_chip_alarms:
> > +		return max42500_set_watchdog_enable(st, (bool)value);
> > +	default:
>=20
> The above all seem to abouse the ABI and need documentation and explanati=
on
> to even be able to evaluate.
>=20

Yes, I will add an ABI documentation to explain the attributes.

> On top of that, cutting off values such as by "(u8)value" is unacceptable=
; writing
> 256 would have the same result as writing 0.
>=20

Yes, I agree and will update these using bit ops macros to handle the value=
s.

> > +		return -EOPNOTSUPP;
> > +	}
> > +}
> > +
> > +static int max42500_write(struct device *dev, enum hwmon_sensor_types
> type,
> > +							u32 attr, int channel, long
> value) {
> > +	switch (type) {
> > +	case hwmon_chip:
> > +		return max42500_write_chip(dev, attr, channel, value);
> > +	case hwmon_in:
> > +		return max42500_write_in(dev, attr, channel, value);
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +}
> > +
> > +static const struct max42500_config max42500_init =3D {
> > +	.pece =3D true,
> > +	.vmon_en =3D true,
> > +	.vmon_vmpd =3D true,
> > +	.reset_map =3D (MAX42500_RSTMAP_IN_MASK(MAX42500_VM2) |
> > +
> 	MAX42500_RSTMAP_IN_MASK(MAX42500_VM3) |
> > +
> 	MAX42500_RSTMAP_IN_MASK(MAX42500_VM4) |
> > +					MAX42500_RSTMAP_PARM_MASK),
> > +	.wd_mode =3D MAX42500_WD_MODE_SIMPLE,
> > +	.wd_cdiv =3D 0x0,
> > +	.wd_close =3D 0x0,
> > +	.wd_open =3D 0x0,
> > +	.wd_1ud =3D 0x0,
> > +	.wd_en =3D true,
> > +};
> > +
> > +static int max42500_init_client(struct max42500_state *st,
> > +								struct device *dev)
> > +{
> > +	int err;
> > +	u8 device_id;
> > +
> > +	if (!st || !dev)
> > +		return -EINVAL;
>=20
> How would any of those ever be NULL ? Please drop such unnecessary checks=
.

Yes, I will update the code to reflect these changes.

> > +
> > +	crc8_populate_msb(max42500_crc8, CRC8_PEC);
> > +
> > +	/* Check device silicon ID */
> > +	err =3D max42500_reg_read(st, MAX42500_REG_ID, &device_id);
> > +	if (err)
> > +		return err;
> > +
> > +	if (device_id !=3D MAX42500_SILICON_ID)
> > +		return -ENODEV;
> > +
> > +	/* Configure PEC */
> > +	err =3D max42500_reg_update(st,
> > +				  MAX42500_REG_CONFIG1,
> > +				  BIT(0),
> > +				  max42500_init.pece);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Set PEC enable/disable for subsequent register access */
> > +	st->config->pece =3D max42500_init.pece;
> > +
> > +	/* Enable voltage monitor inputs */
> > +	err =3D max42500_reg_update(st,
> > +				  MAX42500_REG_VMON,
> > +				  GENMASK(6, 0),
> > +				  max42500_init.vmon_en);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Enable voltage monitor power-down */
> > +	err =3D max42500_reg_update(st,
> > +				  MAX42500_REG_VMON,
> > +				  BIT(7),
> > +				  max42500_init.vmon_vmpd);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Enable input OV/UV mapping to reset pin */
> > +	err =3D max42500_reg_update(st,
> > +				  MAX42500_REG_RSTMAP,
> > +				  GENMASK(6, 0),
> > +				  max42500_init.reset_map);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Set watchdog mode */
> > +	err =3D max42500_reg_update(st,
> > +				  MAX42500_REG_WDCDIV,
> > +				  BIT(6),
> > +				  max42500_init.wd_mode << 6);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Set watchdog clock div */
> > +	err =3D max42500_reg_update(st,
> > +				  MAX42500_REG_WDCDIV,
> > +				  GENMASK(5, 0),
> > +				  max42500_init.wd_cdiv);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Set watchdog open window */
> > +	err =3D max42500_reg_update(st,
> > +				  MAX42500_REG_WDCFG1,
> > +				  GENMASK(3, 0),
> > +				  max42500_init.wd_open);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Set watchdog close window */
> > +	err =3D max42500_reg_update(st,
> > +				  MAX42500_REG_WDCFG1,
> > +				  GENMASK(7, 4),
> > +				  max42500_init.wd_close);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Set watchdog first update window */
> > +	err =3D max42500_reg_update(st,
> > +				  MAX42500_REG_WDCFG2,
> > +				  GENMASK(2, 0),
> > +				  max42500_init.wd_1ud);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Set watchdog enable */
> > +	err =3D max42500_reg_update(st,
> > +				  MAX42500_REG_WDCFG2,
> > +				  BIT(3),
> > +				  max42500_init.wd_en);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Update parameters */
> > +	st->config->vmon_en =3D max42500_init.vmon_en;
> > +	st->config->vmon_vmpd =3D max42500_init.vmon_vmpd;
> > +	st->config->reset_map =3D max42500_init.reset_map;
> > +	st->config->wd_mode =3D max42500_init.wd_mode;
> > +	st->config->wd_cdiv =3D max42500_init.wd_cdiv;
> > +	st->config->wd_open =3D max42500_init.wd_open;
> > +	st->config->wd_close =3D max42500_init.wd_close;
> > +	st->config->wd_1ud =3D max42500_init.wd_1ud;
> > +	st->config->wd_en =3D max42500_init.wd_en;
>=20
> Why not just setting a pointer to max42500_init ?
>=20

This is a relic from the bare metal driver code. I will remove this
since the device itself already has default OTP initial values setting.

> > +
> > +	return 0;
> > +}
> > +
> > +static const struct hwmon_ops max42500_hwmon_ops =3D {
> > +	.is_visible =3D max42500_is_visible,
> > +	.read =3D max42500_read,
> > +	.write =3D max42500_write,
> > +};
> > +
> > +static const struct hwmon_channel_info *max42500_info[] =3D {
> > +	HWMON_CHANNEL_INFO(chip,
> > +			HWMON_C_IN_RESET_HISTORY |
> HWMON_C_CURR_RESET_HISTORY |
> > +			HWMON_C_TEMP_RESET_HISTORY |
> HWMON_C_POWER_RESET_HISTORY |
> > +			HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL
> | HWMON_C_ALARMS,
> > +			HWMON_C_IN_RESET_HISTORY |
> HWMON_C_CURR_RESET_HISTORY,
> > +			HWMON_C_IN_RESET_HISTORY |
> HWMON_C_CURR_RESET_HISTORY,
> > +			HWMON_C_IN_RESET_HISTORY |
> HWMON_C_CURR_RESET_HISTORY,
> > +			HWMON_C_IN_RESET_HISTORY |
> HWMON_C_CURR_RESET_HISTORY,
> > +			HWMON_C_IN_RESET_HISTORY |
> HWMON_C_CURR_RESET_HISTORY,
> > +			HWMON_C_IN_RESET_HISTORY |
> HWMON_C_CURR_RESET_HISTORY),
> > +	HWMON_CHANNEL_INFO(in,
> > +			HWMON_I_LABEL | HWMON_I_INPUT |
> HWMON_I_LOWEST | HWMON_I_MIN |
> > +			HWMON_I_HIGHEST | HWMON_I_MAX,
> > +			HWMON_I_LABEL | HWMON_I_INPUT |
> HWMON_I_LOWEST | HWMON_I_MIN |
> > +			HWMON_I_HIGHEST | HWMON_I_MAX,
> > +			HWMON_I_LABEL | HWMON_I_INPUT |
> HWMON_I_LOWEST | HWMON_I_MIN,
> > +			HWMON_I_LABEL | HWMON_I_INPUT |
> HWMON_I_LOWEST | HWMON_I_MIN,
> > +			HWMON_I_LABEL | HWMON_I_INPUT |
> HWMON_I_LOWEST | HWMON_I_MIN,
> > +			HWMON_I_LABEL, HWMON_I_LABEL, HWMON_I_LABEL,
> HWMON_I_LABEL,
> > +			HWMON_I_LABEL, HWMON_I_LABEL, HWMON_I_LABEL,
> HWMON_I_LABEL,
> > +			HWMON_I_LABEL, HWMON_I_LABEL, HWMON_I_LABEL,
> HWMON_I_LABEL,
> > +			HWMON_I_LABEL, HWMON_I_LABEL, HWMON_I_LABEL,
> HWMON_I_LABEL),
> > +	NULL
> > +};
> > +
> > +static const struct hwmon_chip_info max42500_chip_info =3D {
> > +	.ops =3D &max42500_hwmon_ops,
> > +	.info =3D max42500_info,
> > +};
> > +
> > +static const struct regmap_config max42500_regmap_config =3D {
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +	.max_register =3D 0x2D
> > +};
> > +
> > +static int max42500_probe(struct i2c_client *client) {
> > +	struct device *hwmon_dev;
> > +	struct max42500_state *st;
> > +	int err;
> > +
> > +	st =3D devm_kzalloc(&client->dev, sizeof(*st), GFP_KERNEL);
> > +	if (!st)
> > +		return -ENOMEM;
> > +
> > +	st->client =3D client;
> > +	st->regmap =3D devm_regmap_init_i2c(client, &max42500_regmap_config);
> > +	if (IS_ERR(st->regmap))
> > +		return PTR_ERR(st->regmap);
> > +
> > +	err =3D max42500_init_client(st, &client->dev);
> > +	if (err)
> > +		return err;
> > +
> > +	hwmon_dev =3D devm_hwmon_device_register_with_info(&client->dev,
> > +					client->name, st, &max42500_chip_info,
> NULL);
> > +
> > +	return PTR_ERR_OR_ZERO(hwmon_dev);
> > +}
> > +
> > +static const struct of_device_id max42500_of_match[] =3D {
> > +	{ .compatible =3D "adi,max42500" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, max42500_of_match);
> > +
> > +static const struct i2c_device_id max42500_id[] =3D {
> > +	{ "max42500", 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, max42500_id);
> > +
> > +static struct i2c_driver max42500_driver =3D {
> > +	.driver =3D {
> > +		.name	=3D "max42500",
> > +		.of_match_table =3D max42500_of_match,
> > +	},
> > +	.probe		=3D max42500_probe,
> > +	.id_table	=3D max42500_id,
> > +};
> > +
> > +module_i2c_driver(max42500_driver);
> > +
> > +MODULE_AUTHOR("Kent Libetario <kent.libetario@analog.com>");
> > +MODULE_DESCRIPTION("Hwmon driver for MAX42500");
> > +MODULE_LICENSE("GPL");

