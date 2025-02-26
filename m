Return-Path: <linux-kernel+bounces-532859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE9BA45308
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A9E17C347
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB32221A94D;
	Wed, 26 Feb 2025 02:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kALGQqHB"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3C321B1B4;
	Wed, 26 Feb 2025 02:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740536707; cv=fail; b=YY3wYlDsIk08jAq9rXNDoBCd9292G80xHtSgGTBhyVWzdVdHkBQC+Xmqim1xt8VIAvfsK0fSwctm1kA/JjVwC22LzWf0FfHqYzw4NbKn6+r6aOeXPRu0pye0jKTqct41InAq5S/s8DxQFprDAcmR9iXaSlQ98Z1IGMpfuzVR6gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740536707; c=relaxed/simple;
	bh=bv5wOjqzk+9Dpz6Rp+l0MuG9lQV2fnQ9qRR5gJjIjj8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oErm7q0u93yASxA8VHBHd1AG0Qy8r2yRmZLznaMybxhmdM2kThiFEh+QUvIWQC3JEdNBr0BN6KGxgE4itrTomIHApC3iyijbzLwS+hBJUZ7xarqW96Cof5LnJVkGcBI2X4q5CYJmZ293z4wOlBLo77w9wTugHWAsiHcetdp52Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kALGQqHB; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMZoQS003432;
	Tue, 25 Feb 2025 21:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=yY9Z/
	jza5EoZNVPg0RwqPIjPDcnncucPnx6kVKb1tiM=; b=kALGQqHBkz02fgkndq++A
	y4ZMu+dkAWZb4y+C4Pzdkw2TBnDdFC0A1zsEqGnW101xhWwirokAwJDnklZHK+NJ
	vtMm1f9NE3c7fOVT19xOxxWai9/ttC54tMNE0rjibOeOq8khEDGx2ANOnJOKIea3
	p3viVBhFhTIBq1Habm82TBqK2SHmdS2DvNq61bdgfJ4Jx3vsHnlZJ5ogElUVkk+V
	SJQMtZSsg13ekGo7dDgkjZ4MDTBxPaIMbqL8Q47CfOjv+qu3Cq2jujUoEyr/EZhs
	7D+LI0JUo5697b98hbVt2Cdzn8daBRSZ2NoHQwxL2BYpQ2YHKmY6AhtmJsTfuXhT
	Q==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010002.outbound.protection.outlook.com [40.93.20.2])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 451pt08wfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 21:25:01 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcM3XL8DBp7LpFH17h42Y2NvDnrKLHlU89htWIMIMs0tajfoIaUYTcuIkUQKbnyGHznL4AjoSakUJ6dYcOUv1MQqrfPKx8gfCK09C7ScWxN1DAN2RBbni0kwbnmZdkIMC29ib7rNowI5DDipR7ItPOGw1w5f4jqSxdnhvZUEOfzXWU+R64BKqA17Pw1iCQ1HflAzI3C++lXRIzHuZj5zRuYzGIwJfnDxCxUHeI8zOu9RmTo4EHBLKpIRaC1O31rC9pYTOlmIqyNn3GJFVDSu+7ZjZtwhvbnjGBputjcbvE5zKOHyxDutMiz249RVql4Xzrvov7FIuqHqXVfen6Y3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yY9Z/jza5EoZNVPg0RwqPIjPDcnncucPnx6kVKb1tiM=;
 b=h0bWSz7YgYnLhsNu2q7cZL3lXSLZbnnxkjk0x3eF+EGod8TP1SU6f/BHXH0LO7RHbq0KmulrkiIwqyMt+tIbSiNDJhukYu6p2rot5Ohg8v5SZHF5HRC7wlmd70vliPt+kWPgnZ7leCGLSddWC/thOWiYxNiXw54KnV5tRMz4YX1rozSvu+7yi/w2PHzmhcruMHMMqZxQWJgpyiRB+Aecua2RswfJrgB/lFkMiZa3K/jArUbbggvDstXQcO1Wj5a9SH/xIMFWpW96hmJK7gIFwMPZR7qdhdKScPs1VOOLUHVUIQv+XW00gDqSNxcLboOan3FyngPq524CIJaf5jFUoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA1PR03MB6340.namprd03.prod.outlook.com (2603:10b6:806:1b7::21)
 by PH0PR03MB6637.namprd03.prod.outlook.com (2603:10b6:510:b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 02:24:58 +0000
Received: from SA1PR03MB6340.namprd03.prod.outlook.com
 ([fe80::e5cb:7005:50c5:6f76]) by SA1PR03MB6340.namprd03.prod.outlook.com
 ([fe80::e5cb:7005:50c5:6f76%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 02:24:58 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: Mark Brown <broonie@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 2/2] regulator: adp5055: Add driver for adp5055
Thread-Topic: [PATCH 2/2] regulator: adp5055: Add driver for adp5055
Thread-Index: AQHbh2XM+ksjmJIuj06EopF4dymBArNYCtaAgADLzyA=
Date: Wed, 26 Feb 2025 02:24:58 +0000
Message-ID:
 <SA1PR03MB634020464A151651A08ECAACF1C22@SA1PR03MB6340.namprd03.prod.outlook.com>
References: <20250225-upstream-adp5055-v1-0-a5a7f8e46986@analog.com>
 <20250225-upstream-adp5055-v1-2-a5a7f8e46986@analog.com>
 <a7f7d4dc-283a-40b9-bb1b-0bc8aceb99c1@sirena.org.uk>
In-Reply-To: <a7f7d4dc-283a-40b9-bb1b-0bc8aceb99c1@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR03MB6340:EE_|PH0PR03MB6637:EE_
x-ms-office365-filtering-correlation-id: 0738ee7d-0e3e-40b5-5533-08dd560cc40a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MFLKE3QdDJlL/YGsPFzIdWJsNOj3bhAa4zW/pirtJFUihapS77SUdRKwWeCZ?=
 =?us-ascii?Q?bHhUtoFbEUY4LQaBM7XgmXwt1ibKwusPDAL5JcQdPPLXn2ltt3s5qPIHsC5z?=
 =?us-ascii?Q?K1Nl3sGR4rLE2zzORutDCujpJyQpy1qQvPNky1sOGIf486sjJrTL5jZt2aRk?=
 =?us-ascii?Q?iU04Nc/3PSiNLlESq4PoN87QZ8F6lXkmeKkfZ6Wt1v9zvYszkgBxooseP6Os?=
 =?us-ascii?Q?WNaBygFbY14yXi5JgekxZIX/omEVNvSxw9rHg7B8sz38mhavOdUJRFFnUIfC?=
 =?us-ascii?Q?Ih2uSPyoG7Lb1pOWt/BZ/iz46UkprtapnjqmATv7VqOlZ56ErdTSt2mbrWvu?=
 =?us-ascii?Q?PtPKNUFYc2y/pJ0D+iVkTQ7UZBJdtCz2+p4S6U9ApKijPndXx8qglUXOEugE?=
 =?us-ascii?Q?jsLSrkHwaYgKhiM0vQ2Dwj+T4upCeXB1d2F0HS4Mh6R7S20LlqGE3Q2m3ifY?=
 =?us-ascii?Q?9XxIStGzedrQvsxrQgCMC7AQOzTXEps7WTmxWUzijQdnv7kre4Z0Ilt8wKcF?=
 =?us-ascii?Q?hMW0LyXJYPo+afQr92Xgb1r7tEoVq/D7jrWfnJJDs7PRvv9qz4WPT1rP3plA?=
 =?us-ascii?Q?vRqxVaIMnG1d8rCVEldFTMIrxNoElZQ8hScl5LqOz2kqmzoJup8LA6Np730A?=
 =?us-ascii?Q?jOhlq5OLAxQl9Vcz6SrohCjYWC5w/BLln6wzCwz3wQnC/CZWWznu1CQdSkZi?=
 =?us-ascii?Q?MrMoccQxoppXukMz+JKKBE9Tn7CzHNxHTeMdthuEkivncLuk4SAwTIYf6mh4?=
 =?us-ascii?Q?+lpaKlwBC3gfj6KCkprkZASmcSJ/30AKCEfgDh95QVeK/9FPND9yBNwi1RDF?=
 =?us-ascii?Q?TuOqPn+3dmDE2GJL/V6MNJ4y4WLL2S8E53GUbhTcb9mAvQCSf5ymM5cCO6fG?=
 =?us-ascii?Q?Qns8/BhS3E1Esiix3zOKg91JIpmmF7QYcpyDbBT7ESpEziO+2TSTmj+AyXMI?=
 =?us-ascii?Q?cx/sUaudelayLgBj1bmwfqHDvNm37224cFZKEGaIiFACoTrQhYLzoWCybj7E?=
 =?us-ascii?Q?8+GFa0jRpqP0ipZ225SBQh41tIM+E9YieIFNJGMQJp06qlfMEaruXIqmU/Du?=
 =?us-ascii?Q?haqh1dqL1sfnXDW+M51gjEL3D0ImthnW4B66ZroHxn2C6av028ZrDuB4xqMZ?=
 =?us-ascii?Q?SaQFjZCFWDEm6X/ZUWg36UqlN89SdezpXcCSZMJH1Xfzr42aCn+kcMM/qxp2?=
 =?us-ascii?Q?qBu4g/5Ur4rbFpljAZcVauIpPsAoIMcuHtf5ZlXMmwN4RWDLGELW5MI++6Ij?=
 =?us-ascii?Q?ZfypdDn7Y1VVM1V1uzwBdrZAEOOJ0XVisvSzkb8Iw7YZ/ORnCtJNJyLBaEFS?=
 =?us-ascii?Q?KhPQAojH9KXNSrAcTubSjLN97QQqYROLhmLY2Xut6+Z0+PNIP2vJEHvl5dUk?=
 =?us-ascii?Q?oQ6GE08vqsVeo/WBcjjG0Br+noz6y6oAYOwrhZg4w/p/Mawzgm6dsXJ9Upkb?=
 =?us-ascii?Q?ix6suegqQQTPKDF3D4+GUoJp45hU14ep?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR03MB6340.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ThaOBsICVzQzdb/qRCQVOkW5b8fWUJj4RCLsq4bt4WLGN8Lm9pgwVsyxgN/I?=
 =?us-ascii?Q?ZNf1Qt6RnWxF3HZY/bGb88h7fpC2mUILaN/wq/NoqeMqZOBhzJYgNYflvVWw?=
 =?us-ascii?Q?r7ofNzRw2S+n8Sz6wvRDs9GLypWjo77Zayomxq0sQtDy+vIBLXYQpn/Yjln4?=
 =?us-ascii?Q?VvUqnhed9gHsfWts27TCAt9wdIy0CmZp91PZLTCtjShmNsBivXbtdAcIlYfG?=
 =?us-ascii?Q?bB7iOQy6q39nSs9A7xwLr91REJ4CzsTkcIDGgM/CteSoQa17mInIO50pQn2o?=
 =?us-ascii?Q?OuaDMIXTV1X+z5QtCw1OR8sB9qU6dbcKUgrBNrSANmKl0ThfJDQl7NeVXihm?=
 =?us-ascii?Q?vGuF/plMHVAedJxvFArblyw1rbHdwinv/So4oxRFZLkGpn23ijIvwvqEhvNf?=
 =?us-ascii?Q?lkCZ5/bthaD3Dw+kxWD57FK+p2SN0/s+Vfy+l9uMw1ys48zSIi3FuHUOH28N?=
 =?us-ascii?Q?dfvXXChmkDNsAuoH2uJRlkCjAaKhL2Gv7kaxJLc3j/m4DH1lnSKL7LNwOTzT?=
 =?us-ascii?Q?rQERnm/ddCqXxZQ1dMhtiTclIxWYwbc8tLkljGvTbRfUYujwNRrNEznA228S?=
 =?us-ascii?Q?zUzM/+AeV9qO6wuLB88kNjop6Q7ofG3gEartjo16iCpR+b8On/ZTmeq8ztW/?=
 =?us-ascii?Q?5UJXU4nxW4q2cmEo51sPGJxVPfEQyAfqw79XgyUGDtQ/hiTSS2EvhfAA1QHL?=
 =?us-ascii?Q?HWgAhPC8GbRqayVTRlne/LYZ4vTJrv/HjjB3qtfclvXT6Pk+tp4T2AvsiTQZ?=
 =?us-ascii?Q?ZxyZqg39dAmyYdSjlCxfG+nS+gGcEF7kGGub4JM/yif5iskcZBjckUwf3/3O?=
 =?us-ascii?Q?rDaIl/3kD3TJ6MAa34c4gBmOe+LK0epogbzw7xxWVEf5JIoearMBryuYT6hj?=
 =?us-ascii?Q?/5kUFp7CkJr47JjGrYQnZEzD91rOXp3glmp13Atz8vqRL6iHxxuChINKObfM?=
 =?us-ascii?Q?LyhaSBQs/eb0ZNwstrncCCVjEb35DVERWfnuPbWyTdY3DhW4QDG3tEIxi7+m?=
 =?us-ascii?Q?h+mFCF8pPE8/mAP1oRt9uZj2DOjKDbWysFfEYgSGzowB2+wRgpERu3v1GtcT?=
 =?us-ascii?Q?N5p4Ic6YFebhgkEHhWjXjyPi55aenbMzLVfPDSsvNvGPLGA4l9zpcGvzO2Mp?=
 =?us-ascii?Q?m902TvkFkODQP10eFBOEgWYghLg+pmsn0zSy+T/a+jI2GX9Cgt5Pn3fodTx+?=
 =?us-ascii?Q?VBv7TzZIyepVoB6yUeyjZKno0oDmI1k9p6d6v/ZP5oCeG7DyxpGB8xcNCvpQ?=
 =?us-ascii?Q?4RE5CcpUzg4eyqCQuTUiAX/YupqcwUGg4ESn6HHjalxfJkliZPYT10/4u5pv?=
 =?us-ascii?Q?xjNAtCw331ZgJN3rmBKLyPoI0wv8VKYomzYouVEhh0V5sgpiUebwF7VQ2z1S?=
 =?us-ascii?Q?qWy+dNSHzchXmkgYLcgSIpcL/Ir3gRkKH6YCdVzdA/uq/OMiI/fitwvxXKsx?=
 =?us-ascii?Q?xI9TECkif80rq4u/896LHmNtlmP6yeFY7l6a7gg/65NYcuDDaNgAMtCWz4J7?=
 =?us-ascii?Q?5hoqkx6qzyDYaMMJ61YHxnmg/+KdIXFVLXbVvxi64q+BRJmKOJu6GXJ8vW9O?=
 =?us-ascii?Q?f04TkYNQmcg2N7Zi3MYI7FmtZB3GuaiZXBLXe1hjZV2FcTXdt9YC8Br0kPGq?=
 =?us-ascii?Q?+w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0738ee7d-0e3e-40b5-5533-08dd560cc40a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 02:24:58.4886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TOXkzlI8Of2Lj+ARIpk90XaIMAUgiBmoBkzHwTCIpqvYtNtUV4KTfne9dG1OAmSFHfJlS1g8l58TAAyn1a8yxnSY+0qa6WDTuSjFl1013W0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6637
X-Proofpoint-ORIG-GUID: K49TXYMulpbxsv4oUBuCej2c2n3s09zn
X-Authority-Analysis: v=2.4 cv=Ra5qC0tv c=1 sm=1 tr=0 ts=67be7b7d cx=c_pps a=qtOW3xRV1T1JVXeTS8V0gg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8 a=fyvpMD8DeGvdZdAQiAoA:9 a=CjuIK1q_8ugA:10 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: K49TXYMulpbxsv4oUBuCej2c2n3s09zn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502260017



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Tuesday, February 25, 2025 9:55 PM
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
> > Add ADI ADP5055 driver support. The device consists of 3 buck
> > regulators able to connect to high input voltages of up to 18V with no
> > preregulators.
>=20
> There's a bunch of stuff here which should be using core features, I'll c=
omment
> some of those on the DT binding patch.

(Addressed on the dt binding patch email)

>=20
> > +config REGULATOR_ADP5055
> > +	tristate "Analog Devices ADP5055 Triple Buck Regulator"
> > +	depends on I2C
> > +        select REGMAP_I2C
> > +	help
> > +	  This driver controls an Analog Devices ADP5055 with triple buck
> > +          regulators using an I2C interface.
>=20
> The indentation for the select and the second line of the description is =
weird.

Will fix, it seems my I had used space rather than tabs for those

>=20
> > @@ -0,0 +1,490 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Regulator driver for Analog Devices ADP5055
> > + *
> > + * Copyright (C) 2025 Analog Devices, Inc.
> > + */
>=20
> Please make the entire comment block a C++ one so things look more
> intentional.

Am not familiar with this, is this where each line use // rather than /**/?

>=20
> > +static const struct regmap_range adp5055_reg_ranges[] =3D {
> > +	regmap_reg_range(0xD1, 0xE0),
> > +};
> > +
> > +static const struct regmap_access_table adp5055_write_ranges_table =3D=
 {
> > +	.yes_ranges	=3D adp5055_reg_ranges,
> > +	.n_yes_ranges	=3D ARRAY_SIZE(adp5055_reg_ranges),
> > +};
> > +
> > +static const struct regmap_access_table adp5055_read_ranges_table =3D =
{
> > +	.yes_ranges	=3D adp5055_reg_ranges,
> > +	.n_yes_ranges	=3D ARRAY_SIZE(adp5055_reg_ranges),
> > +};
>=20
> The read and write ranges could just be one variable.

Will simplify/merge

>=20
> > +static const struct regmap_config adp5055_regmap_config =3D {
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +	.max_register =3D 0xFF,
>=20
> max_register is set to 0xff but the largest read or write register is 0xe=
0.  Might
> be worth considering adding cache support too, there's read/modify/write
> cycles here.

Will edit to 0xe0. Will also check on cache

>=20
> > +	if (!adp5055->hw_en_array_gpios)
> > +		if (adp5055->hw_en_array_gpios->ndescs !=3D
> ADP5055_NUM_CH)
> > +			return dev_err_probe(dev, adp5055-
> >hw_en_array_gpios->ndescs,
> > +				     "Invalid amount of channels described\n");
>=20
> Are we sure that ndescs is going to be an error code?

My mistake, this should be -EINVAL instead

>=20
> > +static int adp5055_en_func(struct regulator_dev *dev, int en_val) {
> > +	struct adp5055 *adp5055 =3D rdev_get_drvdata(dev);
> > +	int id;
> > +	int mask;
> > +
> > +	id =3D rdev_get_id(dev);
> > +	mask =3D BIT(id);
> > +
> > +	if (!adp5055->hw_en_array_gpios)
> > +		return regmap_update_bits(adp5055->regmap,
> ADP5055_CTRL_MODE1,
> > +mask, en_val);
> > +
> > +	gpiod_set_value_cansleep(adp5055->hw_en_array_gpios->desc[id],
> > +en_val);
>=20
> Just use the standard GPIO and regmap helpers for this.

Confused on this, I thought these were standard 'regmap_update_bits' and=20
'gpiod_set_value_cansleep'

