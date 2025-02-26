Return-Path: <linux-kernel+bounces-532861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4099A4530B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A429C17BA6F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CE121B8EC;
	Wed, 26 Feb 2025 02:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="NyoRqYJ6"
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6F321A92F;
	Wed, 26 Feb 2025 02:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740536722; cv=fail; b=UXb6jNqRnGbQbHI6hSbm7gLSSSLtPuG6B+uNB+ErdlC+OePy4LAP0ythveMGRqqYXfvpN8iLZnTRttSrWI3geh1YyD2zE6uGCVutadoGbkJHQuTs/P+xPbNLrKYb0O0Lx9EN6KweL1fHRZC6bfAaSORxGcPoWCb//zH/5trKHpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740536722; c=relaxed/simple;
	bh=Zex++kQXTx63fVjD59qvhZIyOEN7WZjqCeO5zFMPY7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ok6qM++IchINzwXORXwcUnyGbZfIe30S5c4DQGOAFP6HpfrEkEpNhX7MuLfAbkN/f4/y300eky4iEA3JqA2UVq/QWu/nJg8fEDFKBi1o+P2w2XjOQ9w9UR1BAojKolc8steSxEJCDZ1gNlKS5E8HDywnukOGY/zw/qG3ws0o0yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=NyoRqYJ6; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMZg48013246;
	Tue, 25 Feb 2025 21:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XjfFP
	83PNLAjqStNYSM+FpCoOufN31bb/xSCncGIAFQ=; b=NyoRqYJ6ojnIOs4wkEsGa
	qBw1VkqoD7Hgdc0cnW4wxD3xrslG1RC5huS3RoG8C0VQTdx8kMVWKu2W9KmGkpww
	6oghzrHLHRWDLTyixmceS2v6R7L9auCs2d+dE0MXqlpRbTvg2PIKSp0iZ10hZI6Z
	6Rle3iOIKYJxMyFdK4/bGF6b8ajQWxxl9cQzjCynz65fMssIajNRaiEaY5EPLDld
	dQCcecvXVWzHd/xKD87Kk5pTaNBkalvjXYyXc91Dfi6QpyQI+vHo1R0vUwUSAQWP
	tF9dlJ5Vd28VOC4fufyyaNBMcMrtZH66cppdFVC+gabXl/DdDYV/M5hZSkhdpBwV
	A==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010000.outbound.protection.outlook.com [40.93.13.0])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 451psvrvxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 21:25:04 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYD+MV3TKnano5KpSctJpmcABwrad/cdK/E/hD2fueyijptxDRLnvnauq+B7fbJlSo6lmBicq5gxDMG0MP3vwIAIInqFAbU+rW4P+EpQzSRCAs0AUElMgiMGxjw5ILIQP4nddAx7U7Z9qrDZMfkrELaL9c0tidhq3lf6tJ75beAAc5EhA1xr7nKu/LRahTcRcUZQ0/ZWTSQVUY35Ob2yCVS9nEKf89X0XFFhprgxR7Wp97GvnWZdXoQR2z6cyR9UzT5ck0Go0Tt90c8TfApqC1WvghGXgLSao4jkkGuxuxDZIsWTXrrqAjG6P/fsEUwuFAw2E84pv79DtqI5e/tFhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjfFP83PNLAjqStNYSM+FpCoOufN31bb/xSCncGIAFQ=;
 b=Zq0EPNexMmRGFglfeM04imT3XbfE0mmngiWtkS2eGqXCE6y/JCwiCE4PBknCen+xDfR/wOTx5BOXscu5DMWCAqihSqFxDjab6F2xLT9isYlKmVonBzk+0CUN7b5snr82IqX9lh24fUG0iPqXappqzF63+GlpItioRbyktoG3ZckoqpXZovmkuMhN/yJOfbvJ9cH9IDXbgK3ITPHX2l2mrj7CipdSlrbGwv7uLhTkcycYjxmPPSn3IJCeUvY9gKSGSHe+Zrfom3RThKaMzMlJTQM694LEWiteFFHqk3uASDGP0eW79qIDffhX1DyARwaaqb/jG9RkAnUV72WvJw/YRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA1PR03MB6340.namprd03.prod.outlook.com (2603:10b6:806:1b7::21)
 by PH0PR03MB6637.namprd03.prod.outlook.com (2603:10b6:510:b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 02:25:02 +0000
Received: from SA1PR03MB6340.namprd03.prod.outlook.com
 ([fe80::e5cb:7005:50c5:6f76]) by SA1PR03MB6340.namprd03.prod.outlook.com
 ([fe80::e5cb:7005:50c5:6f76%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 02:25:02 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: Mark Brown <broonie@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: regulator: add adi,adp5055-regulator
Thread-Topic: [PATCH 1/2] dt-bindings: regulator: add adi,adp5055-regulator
Thread-Index: AQHbh2XG8/ucQBMR6kCIi3C4MhBRwbNYDiSAgADG2XA=
Date: Wed, 26 Feb 2025 02:25:02 +0000
Message-ID:
 <SA1PR03MB6340A94474EBFE0F8428A581F1C22@SA1PR03MB6340.namprd03.prod.outlook.com>
References: <20250225-upstream-adp5055-v1-0-a5a7f8e46986@analog.com>
 <20250225-upstream-adp5055-v1-1-a5a7f8e46986@analog.com>
 <cf90cf64-202b-456c-9a9a-ba33d0e68961@sirena.org.uk>
In-Reply-To: <cf90cf64-202b-456c-9a9a-ba33d0e68961@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR03MB6340:EE_|PH0PR03MB6637:EE_
x-ms-office365-filtering-correlation-id: 83eaff7a-baf5-4787-a34a-08dd560cc66c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hI49LDvmgIcRquJpAZEDy3LSFpdzFq2OBHBiQKe/+40bs/40lj98RhLrQ+P3?=
 =?us-ascii?Q?4o8LzPQ0I/Fyrm4IQrhYveCZSryW1okwwV6TW7bQt86GFSKXojkZmNQqKL/N?=
 =?us-ascii?Q?lX/28nXBheQH/Bh2gNurniTMS3R0Tea5VKJQJgtTzusC0OTvOhVtm44VaKBS?=
 =?us-ascii?Q?IgticY574Dy/S/Br9u4qGxn7KoLPEXNb6NudoLybgC37RYMQK9gOm1rzVd2p?=
 =?us-ascii?Q?eTf1Sth5h2Epi9nGoxJ5pswzK8X/Np9JPACiZooDn8bYeHbVAPlLiGxFsqrI?=
 =?us-ascii?Q?kwuWJfxsq8apQnzjGmXveFBPnfKyEf/hpK5/ud+CVWFjAlhfi8stFU0/8hao?=
 =?us-ascii?Q?v+EHxkd+h+gIWTykFIe82k8pJLCkT6IbLqPjaWQKzFe7STc0Hx90nysXLAqx?=
 =?us-ascii?Q?OoIorFY0WdARu9D473fNieKj7cPJDWASY1KRfuappMbW0CBmkd40RA/N30AO?=
 =?us-ascii?Q?r477wlvx0jrlEZ2x3MI3CM0RYtqKdrZSGDx6/Lvip1i/quVC+iXITW3GuVUK?=
 =?us-ascii?Q?PyHAhs3tElouM2DOGiSaTnsX2jwqJkcLevRSws4paRJEtv4pKte8sU/yYG0a?=
 =?us-ascii?Q?1ft8QyOyZLyYzo8vU3DhN5i2bxRD5OyGhoJcZUABBATbK8yEiHJefB1c7yG+?=
 =?us-ascii?Q?Os3+YE0FFJiH2/2b0DWrOHgmu8IEYmd7c8ru17ftEWaI/J2e30P8rxC052jk?=
 =?us-ascii?Q?WO3N3kYxOvCLGHbn3WFJUSb63S182Jz77ZV1/WC+hO9h9sSZhf+jhXuiLr1p?=
 =?us-ascii?Q?zss7k1hMyVuq3Xs+OZxM/20nt0vOtYpz2ISWGD5TWjLw6J+rY1/PHTrZzflE?=
 =?us-ascii?Q?5OApxGrUgYEVxm+E/BhUIahzV1qlKAng1MqE6PD8InVlZWQIrx1rW3M5fpX2?=
 =?us-ascii?Q?O209yff7uB/a9wLGDUXmdUdoSljRRyvjW0+/dnksH5vU1EcnLXKkfukGPr7p?=
 =?us-ascii?Q?8/Pc7RENqxb2AMMAv7a1WjQpTtGEkCkG60OtelNES6xArsSWYXtUtMSlCrwW?=
 =?us-ascii?Q?sel5Hr0fDnIriWb0aOre7I9k/DGEUxq0Hk32mJ9OU5gAdXl+Z9U0CjSxMiBs?=
 =?us-ascii?Q?R6cf8Bd1ZojQkuta7hLsROQnCtMncnkqIdb2g7DkkL6qYFGyWVLvL/BsR8Sx?=
 =?us-ascii?Q?/VljTtICqKyxSdQaORbdQFQNYTSK03Iz8LdkuLagwumRXX2jJbbqKOcp3JVZ?=
 =?us-ascii?Q?TSrfqaNQfuh93+O5NXIZ5yQzzO4tGAmwVI8d+7SBl74sAtxiVRqGn1vpu/EL?=
 =?us-ascii?Q?4t/GUN+vpm5I1q1ze4cB1CsPmdwY6AvrgYx26RSZNhQf2B6PBw0jZmj/Uvg3?=
 =?us-ascii?Q?M3Ol7th+u+rcaQkPHquSV2KdfXEpxyCzn5jCpgyTBr/atp/G1hO4CX99GsUJ?=
 =?us-ascii?Q?sYKMVlt6s3dCrt6sZF26sThOPps2j448TRgBWrEaEkfKvPTtEez4JKC2YDO4?=
 =?us-ascii?Q?30fKMZwmLAuR8ex+VWPEw8PQsOyEfYUw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR03MB6340.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MGMen7RGkZjCqRSYTbGv2oEVnxRh4HF1NQFtxNsINl4kZozzTQzx4s/de4Tn?=
 =?us-ascii?Q?bOF9sio3TxqAQTL0K/Mi6Kp6lZnnuWW8WWviJCPl/lYmjVyyKqn2v2iC0XUn?=
 =?us-ascii?Q?CpetaG5EfUVUtEOjRP7sF00qE02Rprv3CDOd63/eiRxEzxFlB0e8VLJp+8u3?=
 =?us-ascii?Q?Ti3ngQb02vGRTsEVKR7zoVQwDKy36aWTnaAAk1MBaI5NLXsBWkYFspQGbilv?=
 =?us-ascii?Q?iZILvkrpMRTk5hsFyBMZicUC3y5ixvDOTXT8Xwqx/nWpNr+QRdpUhNoYJma3?=
 =?us-ascii?Q?Fpg0zqXDh6ddPCvFRP9zu8hMkGFnibDL2VzJRnlXCe1wIW/PYxsrLIS1hG0+?=
 =?us-ascii?Q?0RGG7tEAwBfp/dvu8vGhuimquhzWghyTQcMu+rG1Qc6F38Jt1SpFr70ekDbm?=
 =?us-ascii?Q?XkYTqmgLwyq/GZU1DbdILEstE7JC/dyPG8X02UumP8kOdLY6+e7o0x3XV9Zj?=
 =?us-ascii?Q?us1r6QUGtoRg1nJ/G46r+l/cKhKPx0GjmEQeIa/h0tzjI+g8G2hDRgMgOAU4?=
 =?us-ascii?Q?6o/iT9JkhidEAd1ZVkvMroRAylo2teSXizlVqpnYXb+v+m78UU1y9VQg1EV+?=
 =?us-ascii?Q?vZye6n259TnDyrR3WjJzfrxsfJCiHaDbdR1Ilr6SmqoiQW1CrgPYs1xiAS8K?=
 =?us-ascii?Q?LN4+6tPRT2acrmrQ7C/8GFBPHe+zANG8RThU/CahQO2tXHozN9f+TkI6oRLj?=
 =?us-ascii?Q?AD+3vpkfpY5SGBsMwj+p9/nZ5xTnsahojqNQ2+zjQDK9NnVejRHJe7ygO2mt?=
 =?us-ascii?Q?gcmCGRnKmHKZMDTFFL6AGb1EWqUCzrpWoi06U82uBZwkvzoPuruWLZCrb51h?=
 =?us-ascii?Q?HUIotpMDoOTQYhxrBXOAyfHU+Sq6fEPN5WS8nuBaGayHrVYHgC62UaSXf9CG?=
 =?us-ascii?Q?Wk3lwN7imt5SnQMEyvimfLM/Bo5f6cGw4ZaDDxjQWJVJioV03x2VE/Zw2fFJ?=
 =?us-ascii?Q?E8bEhmySpdc/EuWAsfXjQGR82B1Om6Lu0xnWrpIqEyl2uCxFjUXQ57rIPbUs?=
 =?us-ascii?Q?d9z/fBlJ1tH43At9uosUDZfROXWK0bMo3vF6Y091I/CoJR+ICzy87ek99AR5?=
 =?us-ascii?Q?u1+2kATWqo07JzjbSIsBw/xPP8CErIVjPU0zOrhTMgX/J4fSStPirlhHXcQa?=
 =?us-ascii?Q?5UCodZD+edVVCYivj2kdknp5JbJSQaXwOVLeNK160cOSHr16/CowvZNutne5?=
 =?us-ascii?Q?xFoHkoiItCXn6M60Wz9rmxZx8Z+mQsbJjMEsHzNcU3pelUQa70gbvEhD+89z?=
 =?us-ascii?Q?JDV4YE/hlCBAUHNVZK1Qfq1lhJEW0/aOpKosoW3bMtTBB0OWjsnhn+Yempgr?=
 =?us-ascii?Q?IQ1DPR4iaGK2wkPTaHNJ1OwqdJKD9SjrNd/ItIjFjFJaX31d25Ln6/nQPh+A?=
 =?us-ascii?Q?xQM85mVR5hduDahb8iWocSEefaREGV5OdFepU0pSamBFtiqn/iS4b1Dn9BPP?=
 =?us-ascii?Q?b4GgmhEtIajmBWMPNkJoiAVtZgM6VfaB33nKownDNOKkNE7+lt3wVY8tqkv1?=
 =?us-ascii?Q?7lKBXkOlbC5Mo0ZiYIlB0hhntfc49W19CTToV01/HxYhBbZ00QaMoFSUs2lX?=
 =?us-ascii?Q?wGrFMtByw5sa4s6IaCdi7gRR8VN4jFxRLKXO7MLYny/RGyQ89unY0ZIDwxM8?=
 =?us-ascii?Q?ig=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 83eaff7a-baf5-4787-a34a-08dd560cc66c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 02:25:02.4531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WudmpoVEKIkDyqeA2SSI2DOkgeHJoEqEDb0JKTF8mK+3AZt2EQETPzrcTHxDlR0voiOdrVbcLhZC0GmpFn7j4aKr26sarntxA12S3kw9dmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6637
X-Proofpoint-ORIG-GUID: jrxldPtmgARjMEMdpWHTyWjA6pmmSZvK
X-Authority-Analysis: v=2.4 cv=eJ/pjGp1 c=1 sm=1 tr=0 ts=67be7b80 cx=c_pps a=TrQpY+9r/vRMYizkUk6pNg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8 a=u9vyKhjbUfcBmaVBd8kA:9 a=CjuIK1q_8ugA:10 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: jrxldPtmgARjMEMdpWHTyWjA6pmmSZvK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
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
> Subject: Re: [PATCH 1/2] dt-bindings: regulator: add adi,adp5055-regulato=
r
>=20
> [External]
>=20
> On Tue, Feb 25, 2025 at 05:08:33PM +0800, Alexis Czezar Torreno wrote:
>=20
> > +      adi,power-saving-mode:
> > +        description:
> > +          If present, enables power saving mode for
> > +          individual channels.
> > +        type: boolean
>=20
> We have standard mode operations, please implement those.

Will implement

>=20
> > +      adi,output-discharge-function:
> > +        description:
> > +          If present, enable output discharge functionality
> > +          for individual channels.
> > +        type: boolean
>=20
> set_active_discharge()

Will implement

>=20
> > +      adi,disable-delay-us:
> > +        description:
> > +          Configures the disable delay for each channel. Dependent on =
Tset.
> > +        enum: [0, 5200, 10400, 15600, 20800, 26000, 31200, 36400]
> > +        default: 0
> > +
> > +      adi,enable-delay-us:
> > +        description:
> > +          Configures the disable delay for each channel. Dependent on =
Tset.
> > +        enum: [0, 2600, 5200, 7800, 10400, 13000, 15600, 18200]
> > +        default: 0
>=20
> This looks a lot like the driver should implemnt the enable_time() and/or
> set_ramp_delay() operations and use the constraints to configure this.

Based on what I understand I agree implementing the enable_time() core
function for this. However, shall I keep the code for the disable-delay-us?
I don't think I saw a disable_time() equivalent

