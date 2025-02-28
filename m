Return-Path: <linux-kernel+bounces-537731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827FEA48FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602D83B1937
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9582D19259F;
	Fri, 28 Feb 2025 04:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Z1DoD++X"
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0685C85626;
	Fri, 28 Feb 2025 04:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740715316; cv=fail; b=ngcRCxVjD3rb8+Oi/Tx671EiekfHpQg7lLZyXWG6i5z67ZDLZwedHPWP08kCdoU/FZDUbkAK+eftEq9JIDj9P0oGlJeFkHm8DAvnccLLZgnxsa3jKcZBHw2LPuvIisY99mFkzb66GaadY5Q+3Fb7l5bZ78+nvMm4v1srpl/RBr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740715316; c=relaxed/simple;
	bh=9Z8KjuHhVOwE/X6VUmZpJtZWe9cBZuZx1/ITP9wN7Mg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m+FX2WjH2M3K6YYoM6i0ydS2A3cqgFY+PG+0/2I0Cezz4dq/DUQ2CJI8tETvPVXFuTXit8gJFAvDY8LSK38oRsRWSjQD8zAMxOOi/c85My0UbXBJ+Ngk8P39ucyOsiOMLMj3S6sUgpE4YWIiH6DA/LJv9h3qCXxAjUEl0VqEJjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Z1DoD++X; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S0OLbo017706;
	Thu, 27 Feb 2025 23:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Z0Iem
	pKZaahsXrfgTQ190489Gh/pvf49l/k//DWvvxc=; b=Z1DoD++XIQrE6ph2cLSrs
	WT6+lDhMgmw0AK0YJP5p7ts1eAFvpKocTiESOkPw9ulz1MtIsZHoifXOOVu8JgFl
	tT0YOuY4GfNGupG2t+GdttutPbD+T0DKUiz5XLUey2vI5LvuOMar3/cVaiOSFiSd
	nvKZIMZxnE+xzIDpT7kU1v4UGbDu8kvA5c17l+nlDRm6gR9Z+xvTLftUqoAV/hfh
	RR+/Ps+485uvRroRe0BPLdCBJVfqZGTiyLzfc4Nl2fpVw+np4bzZJR0ktR98qGUQ
	cxOFjX7h+QcnZW7sPtAuJAQs8VuptA5VRwil7IGJmO+1QKrgK0qAK+BJfi2xMb5c
	g==
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010004.outbound.protection.outlook.com [40.93.6.4])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4525gps0kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 23:01:39 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dl/dDkmIFmEQIEostgR7jjm2n3Kk8yfqB1W2J7jJrU+BBspCSlSNkKk+mrY2eFWarxYEGUO8QqyZZDXwY/0xMV/6ZQpoL6QESFLjryVrCvYbeWBu3Zl8+rSVHyQgerOcUEYbUNOfEJ6LeprJkawtdSRPOjxVZ5gVUuMzQF8oiAI6hxlNsyd0+zn5k38WLVnYO7iS5ng7rUMqZuHZZDLfnV4a0et+OYdecXSgddeXLpz1gIyq5yc8SNctLPBbeesV8+6xZ+sZt/4kBOBzYvoGUNd7dVvAgYFw58MZgzas/3Y6vGknluRo0NMx0D/usCvWovbApXHx/Y83hsTWOu5Lrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0IempKZaahsXrfgTQ190489Gh/pvf49l/k//DWvvxc=;
 b=ZEoPowfNtxSyRMsBqqMSfpFfX/z95/u04fX7gyJfew/t9kS506ovNZgmq/EqRIi5aoeUyRjAak7rKw7vW1fvmV2hmm6zTxxSAvTMMPjums4OOu1Olqcsk31Md5s8i1+xYdRdO/iZGuBOZet4Dz7Cf0Mykh1w3e7PkxY455iXt0mdhGr6fh5bOGD8Zrj2SsR8GY/LBsr/P3Z2WmyTj7vjQxst40UdWFMk3tuxNafy0cfOV4k+kcuumnuDuvE35nrdME9zlnErNMoUukhA9fdrqPEbaihTfUTl9baYBdWC226VIfH6a+fyk9JwnGTqrQ+5xB809w8Q+U7FeiFjiYEoxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by BY1PR03MB7309.namprd03.prod.outlook.com (2603:10b6:a03:52e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 04:01:37 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::71f7:8e63:e91:a354]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::71f7:8e63:e91:a354%4]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 04:01:37 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: Mark Brown <broonie@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 2/2] regulator: adp5055: Add driver for adp5055
Thread-Topic: [PATCH 2/2] regulator: adp5055: Add driver for adp5055
Thread-Index: AQHbh2XM+ksjmJIuj06EopF4dymBArNYCtaAgADLzyCAAJ+fgIACixhA
Date: Fri, 28 Feb 2025 04:01:37 +0000
Message-ID:
 <PH0PR03MB6351EBB5118D642D00F853F0F1CC2@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20250225-upstream-adp5055-v1-0-a5a7f8e46986@analog.com>
 <20250225-upstream-adp5055-v1-2-a5a7f8e46986@analog.com>
 <a7f7d4dc-283a-40b9-bb1b-0bc8aceb99c1@sirena.org.uk>
 <SA1PR03MB634020464A151651A08ECAACF1C22@SA1PR03MB6340.namprd03.prod.outlook.com>
 <8afb3d94-336c-4e33-a73b-fc690f287556@sirena.org.uk>
In-Reply-To: <8afb3d94-336c-4e33-a73b-fc690f287556@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|BY1PR03MB7309:EE_
x-ms-office365-filtering-correlation-id: f52bcbfc-da86-43d9-a955-08dd57ac995d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lF0g8sJZNacJrsTi2QCzPr0ow/znLfTDxa89OzVktFt45tG2E2UY6O9unFaU?=
 =?us-ascii?Q?TZR5LsUxyVVICQ6kevWbv4UBibWkXUUQVXJd/20Jbd22+DZlhpiPl16WNHHf?=
 =?us-ascii?Q?G12gwAQTQRZxR3rXy1yFlkcOjKF1xOt7pUoLsXn/uvnEhM1vIyKj7mov7TOi?=
 =?us-ascii?Q?MRPmBAXomdpToj4u15NM+HIeOxG6IS6L6CvokPS05zJPJDQdJV8tH42teXTk?=
 =?us-ascii?Q?StcaQ1ZejZAn0+X30vqBsetJGLSHwgkNli1A20lpMDbZV9LBYsrtd51nTSVP?=
 =?us-ascii?Q?n1z2QfI+9jv5Z6wgzY2LCY6sYe8JzW2jkIZ/6yjkWAjtlOcmxA2KPTlANs/t?=
 =?us-ascii?Q?NfiW89JC8JLYHbSTGC8I75IzyZeuOgF4A0D/f+1+KrE3jXHMMqRaQ3EdZoWL?=
 =?us-ascii?Q?n3IJk0SMjcYimVvA3a+xJShglg5ssui2u7ng0vkfKT007plKVuvybUn2B2io?=
 =?us-ascii?Q?yexLjqGphpLd8GjwO3YduKp2BKz1soSRoS8HX9qrqQZXEht25ecrFO21OksQ?=
 =?us-ascii?Q?QWEuSrlVJR4cHlo0KnqjIRbZ2gF0HLsTgLh/WAAT0t2qiYCj2pFUoJXt//qp?=
 =?us-ascii?Q?Lh3+c6wIh7lfeqCAD9jtoCHS1Lg0RX0wMc9CRh4omscz8zSWZyU2RCsz7a78?=
 =?us-ascii?Q?puKHfYgfeRx7JGmnAw88pCQsPV+dkTD/6txxP7i2uynADkTpnC91GBQi9BmJ?=
 =?us-ascii?Q?puvrUOugpCKNUGH8m0W4KCdImnGy0y/Ol4i5XRzyYZc3fIY91QsQ3/6/rvDX?=
 =?us-ascii?Q?TUIAosGkVdA+3LC/LR1i7GkKlu0zvhJLBmUBxOXYn5A8UjGP0BodbmInWK8V?=
 =?us-ascii?Q?rO7jbGi+zX3IopNCGTS77mF1Rwb7/+s17sQ4ZlhuwRGsjIaQUWJm0tgo9FBu?=
 =?us-ascii?Q?WaJudwp4R0JQGyu9zPWS9OwBgyKADhfWIwvRK6vPq7c6Y50VxQKI+2eH8yAb?=
 =?us-ascii?Q?3P2l1XHAQAZSy7oZpyK40TE/25qeYZMcRTMk2fovrLeEeYvKSV4yYqFbwp60?=
 =?us-ascii?Q?fhHTHE/7h+bq6oOn8fqjjgoPkYAT3QJH1XN1tZOD2R/L9V1MJMxSxMwi8gXQ?=
 =?us-ascii?Q?6Qu2BIC+i/FoU/vcZOgzfMd3iscHiw/ZCPs8B8ZvMZANK8YDZ03WLDKrbM3r?=
 =?us-ascii?Q?uQjAlyKrXxEnKkAjbEs21G1Ia63VmU0Los9bno67UwQy3aMU1/tAzwGQu2R1?=
 =?us-ascii?Q?yt2ETPYreepswMX9pLyOgxa8sdgcBzZbbqQkZIbkl0eHiOvPH0rOSHoQ/n1M?=
 =?us-ascii?Q?u2s3wVh5JV6/ulU4TckMgThquJMEZINrbJNCegoczOB36KVyqouj2/R5nRd3?=
 =?us-ascii?Q?05h5nLiHytPD1f1r52hIV91JtxOLfHzVDJbfz4M1CSVHoO7SbPZ5hPFIUgiq?=
 =?us-ascii?Q?1lcTdE+eJ7WZlgxLzuEoECBH85kfaVrB8fYxrvYxXSDabE9ykWyYZrCTM7w4?=
 =?us-ascii?Q?1QxU5rPNAeC4B0LoNhQw0Q8DLfGru48V?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6NvmAgc9EFbrzGsO5u1iCrVuAwjE5+O+zzowPIQO0CAgqtC1GV76zhEc2Dcs?=
 =?us-ascii?Q?tbbcWu1Fln3UewKXwx80QYEcYetcp6DucDODlsjS6TrIcnvQpZfuOeD+Mo9i?=
 =?us-ascii?Q?2wq0UQD5DhWucUlldl+kuO52aeu5ncmuflRIgFjEG9qgMDfRApgiPAwqsykE?=
 =?us-ascii?Q?/dTr2WrZ0auogPkz3ht4XQO4uGvPSY8ogF+bwKaeRb4Ls6x/7ggGn1Jcn5c6?=
 =?us-ascii?Q?oHpv92/N9lNuk1kPfPWQlqyANyvIocWBzMyaSTt9dDIYjR0liS3R0nbrxuf6?=
 =?us-ascii?Q?PYuCsNNTlXcGYf3wWfdMvE6Jmz9MCoO/sOqDd0u9NcMUAuGzNVCBsnQlR0jW?=
 =?us-ascii?Q?C9140k3BY8jLir9GK8heyJsBM/0Jc21amJLpTYRCkSfRPpVTSTE9UONRfE/t?=
 =?us-ascii?Q?EBuUjfSmRC1jsVzRuVPt8J4sATnNfpBEJFOea1dmgbjoJB2fqXB5SBI4c+hr?=
 =?us-ascii?Q?kHZYqocdL9KMgGs6Fao0qDXutcyRZQUf05gZdnc4kY8DXtdMjGy+3N4svd8i?=
 =?us-ascii?Q?Q3WLt8f/nA4PDZxyZuW6UqYQiuAkdxonAHZNjxlxwIRSxUcZTz+b+Spf2J/w?=
 =?us-ascii?Q?7bHvoLP6mCFUQ4+noogIhrpxQhNB8acXx/w0B3HwExc2U9125NL68zGCsDpl?=
 =?us-ascii?Q?1Xkdsl6fCkpYmDzmgj80ji4A7kbqzCVo55bYLGHiNVk3gdyE8glwTNI294aL?=
 =?us-ascii?Q?XJcUyVW4ND2djv7ZSyJmpR10XCmTkSGJeY2livLZd2C7LgwW11rcPnTBSAnD?=
 =?us-ascii?Q?VL5Sovg1oq6zjX4v9blz+HoL0KurtLXFkpbnJZViykuGsxKQFazgG9kaTeJ5?=
 =?us-ascii?Q?Xg1AzNT0vjenp6MBWH7LHfSesjqNZ2MvdaWNGi4R/B3Ue6igok0jsLVQMNct?=
 =?us-ascii?Q?kjVnhu60z+uYSGV53m86R56LaMd8gEkO+Egj/z88smiRsGmSpMolpdLr7hW9?=
 =?us-ascii?Q?RTOAX+2oVueaDUAvYESmpVWxD4CdfRzti1GCNMb+KIEQbmOIS4ukMRZjFIuu?=
 =?us-ascii?Q?jO1k13PbkpmvdVMtFfSnyBJweHWfggXuAyM6Hv4e731plBxvvb4WvddVa36h?=
 =?us-ascii?Q?xT0GLBMHsUgAHbGem5GyCXe1OrmBlHHX6u4wqb0Jrd9GeN7rwVmVM1OBODI1?=
 =?us-ascii?Q?r+uvXnrS4QPzVmzi5CbOEg19ZdP491k5RyKLXh571Yf4vYaJoA52eAG4KdnN?=
 =?us-ascii?Q?rOZNHf3w16MgELERjIzsJaPQUuENRZucfY3LtnNQqlzQ31Sd0SJHKQQ2kvpo?=
 =?us-ascii?Q?REUNeX63OhyTts9c/UoB9wDh4dxBq80afwSMCwQ+bzWIPxu5HQS9ynDiMEUv?=
 =?us-ascii?Q?IsoIoqUWajPfkwj6X0HNRL67OcyR4fQ+HXxZldeRnP2gIxFWsgoX1lYskfQQ?=
 =?us-ascii?Q?fP1kOFomfucPzFjvcJBx07785Lu+kmlme/Y/3KJrm0BrlWxIrET/+W2jE2/u?=
 =?us-ascii?Q?jM8Utsua285+rY2e9Aq2XB4+bi0ctVFyT5eKSOWGAD7NEVquFzQvA5u+TXqV?=
 =?us-ascii?Q?AT7eLKTbv1cXIlFKVt26Z+cCUhZCGNTScM0M2aJlL9seDwNzboQKZdWNq2C0?=
 =?us-ascii?Q?pDPtsafvwXQPpzUePamAxEcztXIjGPuISsKkWv8JxkCH3XhMzJ8JnuUeYwDz?=
 =?us-ascii?Q?Zw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6351.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52bcbfc-da86-43d9-a955-08dd57ac995d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 04:01:37.5447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /jr7dtQLz87LW2hGKopCq7CD2TC85X1slsVzhsGzaprIBYGIFs7oa305xEheuoFBaKWTNhaGGvLkEomlOvwz36+v6hOyaU9U0kzz79K3EC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7309
X-Proofpoint-GUID: fEHuBsGO1qOnimaTyOjxMvgoNIAwDpYH
X-Proofpoint-ORIG-GUID: fEHuBsGO1qOnimaTyOjxMvgoNIAwDpYH
X-Authority-Analysis: v=2.4 cv=NM8v+16g c=1 sm=1 tr=0 ts=67c13523 cx=c_pps a=YCJezUkNvC3bKg1Ra8oh3A==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8 a=s2OBVSROKXQO-WnMF4UA:9 a=CjuIK1q_8ugA:10 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280025



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Wednesday, February 26, 2025 7:35 PM
> To: Torreno, Alexis Czezar <AlexisCzezar.Torreno@analog.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>; Rob Herring <robh@kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: Re: [PATCH 2/2] regulator: adp5055: Add driver for adp5055
>=20
> [External]
>=20
> On Wed, Feb 26, 2025 at 02:24:58AM +0000, Torreno, Alexis Czezar wrote:
>=20
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Regulator driver for Analog Devices ADP5055
> > > > + *
> > > > + * Copyright (C) 2025 Analog Devices, Inc.
> > > > + */
>=20
> > > Please make the entire comment block a C++ one so things look more
> > > intentional.
>=20
> > Am not familiar with this, is this where each line use // rather than /=
**/?
>=20
> Yes.
>=20
> > > > +static int adp5055_en_func(struct regulator_dev *dev, int en_val) =
{
> > > > +	struct adp5055 *adp5055 =3D rdev_get_drvdata(dev);
>=20
> > > Just use the standard GPIO and regmap helpers for this.
>=20
> > Confused on this, I thought these were standard 'regmap_update_bits'
> > and 'gpiod_set_value_cansleep'
>=20
> You've open coded the operations instead of using the framework helpers, =
you
> shouldn't need to anything other than supply data here.

I did code this similar to the helper functions like regulator_enable_regma=
p.

I can reduce the code a bit if I use 'regulator_enable_regmap' inside my=20
custom 'adp5055_en_func'.
ADP5055 can be enabled by SW or HW and I didn't see a helper function that=
=20
can do both depending on another property/register hence I coded a custom.

if having both gpio and register enable isn't that common, I guess it's an =
option=20
to remove the gpios and stay purely software

