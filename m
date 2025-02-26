Return-Path: <linux-kernel+bounces-532860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5184EA4530A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F2A17B6F4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C33C21B8E0;
	Wed, 26 Feb 2025 02:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xSX8rS0U"
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC690199E94;
	Wed, 26 Feb 2025 02:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740536722; cv=fail; b=TUPaehOnZ1ux8xTONg/oPeP+SffFQRC1TETPYE2s8RgZtdNpza6A0fL9tiMC3KuRx2sp64ZwvVXr29aXVPXuqwd2ANBeJxuiMpFbzDJSnCgqVy5wVm05fPq+5AdldRGoR2PxShsqJsyw2/6249U+KjBG62qtdtamLuQd0AYHIkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740536722; c=relaxed/simple;
	bh=byC29Ojjqi3IHiIGjACic+Ux7IC/HsxRea0Abnpg7F8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fmyImwkOWSCKCmpFA1XXnCau+Dn+oU6DpDtuzP54Tc6hkR4tgfbCPjwMiZKfcwkZmXnKmAhhz/kFiK/hG8s0cVsWemruWv/0W3Ey7tNYlm2DUWfJuxWc3Fi1skPwxhERGiYMf2ItvvNotC6I9JoSknF6JRn8JAqf5/Kec5C3cq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xSX8rS0U; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q1U05M029693;
	Tue, 25 Feb 2025 21:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=uetyg
	z4+cdX8WjGSLIuYNAJQYmb0erhrem4NFnDG2EA=; b=xSX8rS0USFlnc0fQiEJPz
	PzJlozjdu1XGg53NX8Ong7Ic8ag9dGbhOZQpfoHRreoDkuesKxvU/bkFiziEI0k2
	OQYi38k/Zbrvj1r0Aezl8KTRlJdMs2aSpz4wr69nsvGiEYXe5P+edcF3BNSx/cXa
	6oHNTiJNX8boa5mDEC7VxUchMc/5JLr7l7TtlLlsA7OGwS7zk1ZB0PQfPVCZyoL+
	uesBVxF+DlD6NZL9yHEFiqPJkbAikHBCvAltke4d/sCBkbjGLLQcxzjgDiSuvS9p
	YskuyB9njzW70Knj1+5YBYKSEiWP3SM8upAtS7STMb48TvL0H4YvsxhWu0PLebSP
	Q==
Received: from bl0pr05cu006.outbound.protection.outlook.com (mail-BL0PR05CU006.outbound1701.protection.outlook.com [40.93.2.8])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 451sbkg7td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 21:25:10 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wx7wIWrxzGrXa6SYwsR7cAecQiX20kBfQcXA2NyYZ7ds1YGcewZJAm6sH5OKjz/nMbCdBS+kRqlSPx+AeIwS9CLFn62U6nJVRpHG4wG1CRN+Z0xGWaXOUxo1DR7B+3eRK0rHPEMjE0yk6kpJvK0tFqu0vKuW2eHzhKsIwTwSbV4SRo6wdqkqqQtClU10Mw+c+KwjOoGvWxOcGU14+GSmmELoiiPXyojCeVmlbgQ8rYDgLbo+dpbJBF9/kaHdL2NplSrhy+YHoatKoQfltcfUTCPGsoL/X491VDusrfjtgWtZSKQB8lU7GB9yzkgzwgOe8NV9DiTRTuVgKjYafV5iDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uetygz4+cdX8WjGSLIuYNAJQYmb0erhrem4NFnDG2EA=;
 b=roBJjr8Tju+5gWefS9KOub9i93OVUtlT+4LySN0I/0vVhneSJZEfmGTjk8KRcSX6IUYvQGZzJ/D/MxeJllhQjj/MYj7Z28+cpBEggeickq0Gfui2tBpRHAw3rR734tB6ciVwSLOz48iscfLSOLbjyPN3WCna09E3h66qIFzDqfaSqbId0ABJ3GxEn8OFaM5yjWF8Tt2PjKHX/lQSQ+EVqmH1XaJRa6U89JIK/tARD3Sly+lsTATeFLXBiRE0fWYCzcMzb5t787POsoTi+scTjR/I+QhnURmCc2o+OGUvc7Qg3Wp5ivi+8imE3fyVEvBZFrH2I+ztiXtU9wWFUvw+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA1PR03MB6340.namprd03.prod.outlook.com (2603:10b6:806:1b7::21)
 by DM6PR03MB5130.namprd03.prod.outlook.com (2603:10b6:5:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Wed, 26 Feb
 2025 02:25:08 +0000
Received: from SA1PR03MB6340.namprd03.prod.outlook.com
 ([fe80::e5cb:7005:50c5:6f76]) by SA1PR03MB6340.namprd03.prod.outlook.com
 ([fe80::e5cb:7005:50c5:6f76%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 02:25:08 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: Mark Brown <broonie@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 2/2] regulator: adp5055: Add driver for adp5055
Thread-Topic: [PATCH 2/2] regulator: adp5055: Add driver for adp5055
Thread-Index: AQHbh2XM+ksjmJIuj06EopF4dymBArNYDmKAgADIFUA=
Date: Wed, 26 Feb 2025 02:25:08 +0000
Message-ID:
 <SA1PR03MB6340E0399ACB587A8FF5EF9EF1C22@SA1PR03MB6340.namprd03.prod.outlook.com>
References: <20250225-upstream-adp5055-v1-0-a5a7f8e46986@analog.com>
 <20250225-upstream-adp5055-v1-2-a5a7f8e46986@analog.com>
 <3905cff4-4e4f-4301-8aaf-70bd50126448@sirena.org.uk>
In-Reply-To: <3905cff4-4e4f-4301-8aaf-70bd50126448@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR03MB6340:EE_|DM6PR03MB5130:EE_
x-ms-office365-filtering-correlation-id: 40c6ab1b-217f-45ef-305f-08dd560cc9ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JVtC+DyhTjbp5tZpOJoBdo38v3RFRMcjL4yCOHTygK7tc/uRgXEg9e88CKJ1?=
 =?us-ascii?Q?cH4xrGuQeyJnCkKrnpDoXJRQeEmE/OJH0fT6LbwoLIc5yQ9hXD7jpOsj+Wgg?=
 =?us-ascii?Q?mfb0Oes8hZzcvjYapaFQVHv2rJlg8YZIG2QlsNErWNbfpApj1u34bV+2YSyu?=
 =?us-ascii?Q?Y/qzAqLIhuJk7/JGWfBEHpR0VZvniHgB6jSQVf0qoduesHGNvX6yCRaqXA96?=
 =?us-ascii?Q?su2mhypzwZVZ5Cb2WupUHHtzDcTTjSl8MkO15ID5Uk5hUF1b4OJMCviokTx0?=
 =?us-ascii?Q?RIr6nilnMHRS+2ZGOqw7hw7nDo9i1ZoQp9iTNw3qdfj/AvXFx27KsErg1duf?=
 =?us-ascii?Q?CPHu97EQQyfLgNVhwruy3Cokn4QA66GMGndvcGLDDwvfNwLu6CE/0pm8X0gW?=
 =?us-ascii?Q?MrXp8yunbZKAq0JvkHZ29dNdyv656r2iXthjn1aTR91qJQ/bNR1J2JgKRgxA?=
 =?us-ascii?Q?OzsFg74QFAx2M47mJpZS/jrTiQKSjR0LBJgQqnl5Y8saZEMoNqvk01dsUQTU?=
 =?us-ascii?Q?rWNOdkrtP2Ytua98w/oshT/WZHiuw/cq23Udtkp37APKUpYPAjY59gR63YBS?=
 =?us-ascii?Q?1B8s6tZliXK3iqiAAvZi2sJGm9ii5EnDdMcSP0Uy423uXYJDjzSg7lngRO4x?=
 =?us-ascii?Q?PJQQFFWt7z+wY/mwH4jdNcNWSEiq7udzgb0N9RYOEc1Emn+QDDFFS4wBiGHW?=
 =?us-ascii?Q?wJPxFxOpgH6mJXDQTCazmFAT+r7XZGnaZUhCiHrTkk1OXKIkBQWmH5VVqvFG?=
 =?us-ascii?Q?SNuYKpNNqzOLy2+HeWEKAkVRFy7th4QBC0/OQ5fy+kw8DC5pMFhWqpJqkHh4?=
 =?us-ascii?Q?aDuqThWtpWiGKZQOlHmD1UP+40zOI4ympdqjeg52mDIOBqb0WU3dJUNckvZf?=
 =?us-ascii?Q?A53M8porsem6t2gZrbqAO62lEoaVhHrVzPzgFNXrX4+0q9aAel1yUcHjNXbl?=
 =?us-ascii?Q?7wC/9Dhiuayr1SQ5sLMRwR/c96JxcZeq2iELcs528ctoeJQe2/SdcV0D8Jyk?=
 =?us-ascii?Q?viapmbO0fFzjPNvKJ26jkMEsi12BakIA3cc6Z1oAwar36cMhmoboLJKzeC47?=
 =?us-ascii?Q?ze3bK0w3TTe8Vgr4pCNjPGWimd9vjm6yXg1IaPqje1VSvfD3cTcdRjQNC6+J?=
 =?us-ascii?Q?l2UY9ILRo2vLYmF+LEffkyy+h/TxELqwY9w2bjM6drhr+iXtvuNK61lmxgIJ?=
 =?us-ascii?Q?Ta3MWGLe9SOFmKPiiROkKZZ6iMqgX3dWp/wlVtmajMujHYwEsVr4v8vZ2SyX?=
 =?us-ascii?Q?9wfIEVaWnSy+JuFZ2hZ6q0x9iKlOZpux5VjuT5VFreEVf/vwaMdyBK3oHDz+?=
 =?us-ascii?Q?KrLwbSdkxav/Xxct6IabhqQVgUtUFQH2+TfrC41lqQ5mPZajUTpK8csDu/g1?=
 =?us-ascii?Q?+zcFXghOPAB8mov1/8GJOY2H7pdYRYHaDZm/bA1zaksYxA0xAagc+aJrXdSg?=
 =?us-ascii?Q?RS9QSBO3T+mF/x+7+4EUZlwDPJpiURRJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR03MB6340.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0DUoFmKlVRGBAIRglUl3JdFenFmJ6PQp4uixzEOan1pGEnglPryBaJ4PByGK?=
 =?us-ascii?Q?nTL+79cOGQqkY27Qks8fxUossY92WvD14ef9WAAwwxiFUfZ/5M+OX1VRVeJk?=
 =?us-ascii?Q?lm1jrj5FpDilPWZ4h3ttv3QqThTQ9WPmuYOdqo4xW8PDbhJFqA+/NOrn9HxT?=
 =?us-ascii?Q?d1rzYqnTOQunstp+hf6LKcgQbnvyeGhAlWOOfNCpuAwyHmNa/D3q3qrAW7cB?=
 =?us-ascii?Q?dEeZqsMgg9XszRdBwhhU5pkV0ahVNCT7g7Q7H+1S4ObUkMkb4Voe/8sTxG+R?=
 =?us-ascii?Q?KAeJMDszbO8NSvEQiMnFLpg3Z7z80ra/Mkur3BDnhN0s6TPq7GwxSZm2ai7O?=
 =?us-ascii?Q?nTjw0l85FN7CQ9U39/oY5HCY+OV42nPsb65QWYK+Qtf2NpP6UagKniT4B8ND?=
 =?us-ascii?Q?y6t26ztcwfDQXKU3RvarsQu4DAQE1DAUDeslEeK053PI0bcj4wnOZ0l6PZwE?=
 =?us-ascii?Q?WOB9yp/S6zVf9PsgH5jpKKYuIYrDgY+GCjLpd6T2KwzPm6xuzCIwwlkGpmcg?=
 =?us-ascii?Q?nfNBSmtgQ+emYfCKjqS5tuXqsm+4xz/XJgjvdDVBt3MYikAPfm6CM/JE1mi4?=
 =?us-ascii?Q?08mLGxi/6XAndHJuhZcR5TnBsfYYceTHAcEkPgtosvhtGRnByipFplpbxeBa?=
 =?us-ascii?Q?O6V3/NqvLRvNAXIgS1YqSZ2ZOB0sMp/mEjwGVbWlqEjCTaU+HIaNA7fbdf11?=
 =?us-ascii?Q?kzju06LHMuDVP0cZmJZdkroSVDs7/hxZyyMbROG1LGJ1g5RYpf1UXK0ARBSe?=
 =?us-ascii?Q?pPlS0UzSz5E5G2opKI9W8DdZYEQVT5E9lzWF+8M8t20xkTCUWHHTM4/4YV7A?=
 =?us-ascii?Q?b5xZE1oSE6C2Oy69qVWO8dc+C6bh5YgcOX0+s7Ig5zwIp/24u8PPtBxIUcBO?=
 =?us-ascii?Q?964jO3h3Pq9ouHcFO3hyxho7sOmT7RLhCAcJacUNp8gbW0bTS92u8w1bEJ/c?=
 =?us-ascii?Q?OUCvikj1oOfRxQBFkmKRS6G43uBsoModWK1xMDt2iLGEH/reCiTYdnq5dobR?=
 =?us-ascii?Q?o1EcOGYVlM633CaZuow89fkOCJEEJtLcy4SU7JawtJyJ0bkX2KcNeDGbySID?=
 =?us-ascii?Q?hXkMz2WUMBe0fKqG74udtwvgyLMAdy404bA/ZqsMcDCPfecXpy7GYfZ2Iy3i?=
 =?us-ascii?Q?2N929gn3lyDiM57p8W59ZiHanAeN2MRYYpcTi5XH9dwvylpUyyfyn+0fCw7z?=
 =?us-ascii?Q?zJq4wtRzAtljNx/g4I6jIdax/2nI34e5zzktlPfSQvJKQVP7Gq6iw0Bpv59B?=
 =?us-ascii?Q?3sNnYtCoTrGHeceSS4kNHQ4ELYJG045mhrExiV9txVW+cZ1wQi6Fa+vnuSQU?=
 =?us-ascii?Q?nFbsP1x5n1RXLvLYlkqgpcW6cE4u/9qQsNi+HC3ZrnrfYUIMIrETByHG0gkN?=
 =?us-ascii?Q?lMrU3HmBwxqDonDBEPN7vHfSK8JpOrlUahqXH9r8tNQMItxWoB8jZAeC9Swl?=
 =?us-ascii?Q?I0fAt2AyhE7kOZOmmUSZb7Y3Mwwzuw24uBfjkPwt7MS5Z6XWkFZijqiVQqED?=
 =?us-ascii?Q?TOg1Q8rgU6QErpUmQU6A+l6fjeLWu0ARMiqtE5Jh9o/2thgLsMWDPdXAp4+v?=
 =?us-ascii?Q?19SFBi1BJe8OWAulJNOx3yM6H1OUNnzSv22/Yx22PNF/bHgUVcSXve1Y9cNs?=
 =?us-ascii?Q?mg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6340.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c6ab1b-217f-45ef-305f-08dd560cc9ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 02:25:08.3353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Asb9Oa8kR8+dYa/bVZo2co1MqT5L8EhJ2Y4B4KmrmPEz0usIn5IaSoabzDQlc+Ng82YquefZ8kYf7dhqZ7LQdU6ZBQYz/xXv0vS4S5uJca4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5130
X-Proofpoint-GUID: TyWhMAe9mE9L7QK4utnxtAGobRYFO9Fp
X-Proofpoint-ORIG-GUID: TyWhMAe9mE9L7QK4utnxtAGobRYFO9Fp
X-Authority-Analysis: v=2.4 cv=etglzppX c=1 sm=1 tr=0 ts=67be7b86 cx=c_pps a=Kq952KYlFoMAqHE57MuLQQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8 a=ELgXuIxQXlPQrGSgtfoA:9 a=CjuIK1q_8ugA:10 a=iFS0Xi_KNk6JYoBecTCZ:22 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=905 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502260017



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Tuesday, February 25, 2025 10:07 PM
> To: Torreno, Alexis Czezar <AlexisCzezar.Torreno@analog.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>; Rob Herring <robh@kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: Re: [PATCH 2/2] regulator: adp5055: Add driver for adp5055
>=20
> [External]
>=20
> On Tue, Feb 25, 2025 at 05:08:34PM +0800, Alexis Czezar Torreno wrote:
>=20
> > +	device_for_each_child_node_scoped(dev, child) {
> > +		ret =3D fwnode_property_read_u32(child, "reg", &i);
> > +		if (ret)
>=20
> Use of_parse_cb() to parse per-regulator properties.

Will figure out how this works, thanks

