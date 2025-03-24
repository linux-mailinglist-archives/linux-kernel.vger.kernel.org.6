Return-Path: <linux-kernel+bounces-573378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D21AA6D68D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0A93AF15D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58BB25D8F8;
	Mon, 24 Mar 2025 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RpFTgJ0c"
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D225725D54A;
	Mon, 24 Mar 2025 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742805925; cv=fail; b=sftOm+M3bpJn01buSY9TVX760EP1YfkBaJPuvvnbUQT9zkyKrooUt4CvqCmCGVr+2FB20rE+BfX+LBndA7N/zq8agNE/TMBK2+k5lZjSle0hSLhQMsOF0YdRMVgaXRG21KScLd0CCS/i1GgS6bAyu0jLzOQkmE7pR3JqFO0WiPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742805925; c=relaxed/simple;
	bh=xkFRXjf8dw9OrqMe8IwBXZdjszqE9MMXgd5kttkgNZs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UYPGznnCDqzELEo+nL+l8y8hD0o/QjADTEUcYtldQxxqDXsqPylAGaPCxIbKdrh11XcV9s0MhfQG063ZFECCjdn6u6exP5jQnBx1Oc3At+QgAw4gIw7obh+HPr+1LOw+HlHPXyaBZL+QVJ7PU0FkVZ1xrC2zmnAf9XBplyEG8RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RpFTgJ0c; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O6A9fa011774;
	Mon, 24 Mar 2025 04:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3wiYl
	iFZBP3+sg7C9qXgnjdGypfV35Qd7xwwj8Bw55Q=; b=RpFTgJ0cg4rwHnNfnfIFi
	dLzYq0ZRj/fj0xo+C4CqfMECgKwUmf31ORgzJQS9Y4mlPtpEMVjgAFsBM9mdDvgy
	8yfDTV/XMNeeSRD+0lSrBAiM/Cd5AwMEQ3b1LqEk06z8CbBJ0flOdkvGWyDCP+0Q
	TPWa3qUgVTr46OVPRJ/owiKQA5tHI0g+SzpKOmdbg8AvP9nmuEW6Wa51qp/gFIB+
	ijzOODAA2+Aha+9LFrjdIxtzpQ7RCaBODpJaHWqUO4nI91HiIgRfoVONfMpVm90G
	rhIXj8ziMU8Nb76aGlabCXTmaOJbfBIpKhbsL0zbXDN0tsRqEZ6D+5fIS/UbVL1k
	A==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45k1vw8jtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 04:45:06 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhrwV+Nszpi4KcDd1aLXtjNVm9kJLT12KOF3mdagX/NYrvTmNTMbj/+paB5GJUvA4Js9rDygIEc4cRlogRATdnHrXXyb2nB5FP4qRC3/0+B5YrmIVYKBt7yRp7xVCOik0W73u8DIzYEI3bycMW/z7MT5fjcY1zx9sS7hRBWapsNwJz0PDh0H4SXIVsb+O0CM+PP/V4ShRTdxSgntF3A2t1u/8Ff38+7Pc8ypU1TPDSqCmzveZiNcR0TfGM/Og6MwX/idbftXT3hV43Bel2eqyx+s2TadocmxYi54nPcm+CQxItBBGj+YlXl2NmCDQWciBoAp0s0y5Fjlh3qyDuL1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wiYliFZBP3+sg7C9qXgnjdGypfV35Qd7xwwj8Bw55Q=;
 b=gTOYbTfwSid4H3escz0RhAOF4jMWCiCyOSD0I/btnUEEfdlv/7NtaN1xFKgiP5l2iGd/POrR7U060ASHwHrUFCZ75v0/lqjQDGtaln/gwiC2U3eKengBn7IL1YINzgiVg1tkvOEo7QQn3sAZnBCT9eErVZH2XQrT9Ww51d3mkV0mo1s/bQZwH1Xt88zItVQgvmLlY8fYHtDnG/QU0b8MpUR46027N/y7p6oMTSydoeHUB9k30E44d5rLu8giOzVILZCt+AQi6wcfOQMCBru3IeNNFAmEvI5PDpAJ2O3eAbDQn/NN2O6ld5mDGF9P403ef8pHqtiqktuzHbpUeLkqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by LV8PR03MB7493.namprd03.prod.outlook.com (2603:10b6:408:185::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:45:05 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::71f7:8e63:e91:a354]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::71f7:8e63:e91:a354%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:45:05 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: regulator: add adi,adp5055-regulator
Thread-Topic: [PATCH v2 1/2] dt-bindings: regulator: add adi,adp5055-regulator
Thread-Index: AQHbmWTs0tq9YZuaRU+BZzr0M0+ierN7vA6AgAYUWSA=
Date: Mon, 24 Mar 2025 08:45:05 +0000
Message-ID:
 <PH0PR03MB6351B2DCD6C87F1ACCD043D6F1A42@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20250320-upstream-adp5055-v2-0-aac2d3705802@analog.com>
 <20250320-upstream-adp5055-v2-1-aac2d3705802@analog.com>
 <20250320-unbiased-cooperative-coyote-e7e255@krzk-bin>
In-Reply-To: <20250320-unbiased-cooperative-coyote-e7e255@krzk-bin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|LV8PR03MB7493:EE_
x-ms-office365-filtering-correlation-id: c777de76-ea66-4255-e112-08dd6ab02ca5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FsjB40mf/wFBnQKzAR+eMs9aI5C2m1e7am61vnmSthzeCjwiv5m3HpVT6NwH?=
 =?us-ascii?Q?cyOsBChZ290AABerYLCFX0iAdZGOYBmp1gD/5tHX4ksXd1cPBhCdT+b7SZau?=
 =?us-ascii?Q?y9n57Usm/B9C2DyvzoCYeZDwyCzfM3xQ7ZK7Zaop2SeUOdsGUtxBh2xFcZUn?=
 =?us-ascii?Q?Yb5eohi/VhmAs/I96AUlzmZRUIhGl+Zi2i+EJgGDisuwhdtCMvfRd1jNRR0j?=
 =?us-ascii?Q?dnCdbEQDVHwTCF+O9i6/23Or5Vjv3vJns/RbAh9987xKYc1O80POb7Fv7c8D?=
 =?us-ascii?Q?YZFvH+30CRZdfEdq9aRlINzBII/Z83VzgvWw6OFY7r1Dey4JTLIHvlxS1FWz?=
 =?us-ascii?Q?PAmPDaGM3YE1j/fBICxWCvkxjJ40ThnYITooiv4sGFv2boRSXyA2eOIlGfri?=
 =?us-ascii?Q?JjJzEBtcpJ39YzNfVe1afWW3tMYZ0yw385NomlWxp3oSekqcNEO43azyy2Fy?=
 =?us-ascii?Q?jC/lyynLIgygLSWGbg0lPb//34ha5eJPBSuOQtrjpAtWYDXpnFTsC74Wf4Yb?=
 =?us-ascii?Q?Zubat1xmlEHrb5Ql94xYOTbTd4UoiDT8/DP+X4/Xyr5+TR7UD63l1YNe1mi8?=
 =?us-ascii?Q?BDMZkSYkYVaAJRX7gAMeqvZwH3qQA3gjAK1KiRposjubzBAYIVIvyl4IxuXP?=
 =?us-ascii?Q?jqyzS2SvOlpFYnW5EOVBYvvXxwhI1OnANnf4NYBqgb/cqPz9199k6vNdq19u?=
 =?us-ascii?Q?XlVVfL8n7bXG1F9yPpdpZTlnYHbzJ4yyQt6FC/2RZE8ZBtyVeiguV1DRZo5q?=
 =?us-ascii?Q?/QdnAYYBRY1aiYgLkDSTbYm3/vXRAK2AbhWWZs9N5bHHGtHO+vV/NLL2yOUW?=
 =?us-ascii?Q?i6gJPJu3PPe8upm8zpZCc4zuHaOaIkosq+Vz5C3LfwAyJbjA8uAiLq9+uxD2?=
 =?us-ascii?Q?ZLh1gXD8WFfKkeioU2mSd9TLkvPddpPwpNzZXczi3d1YwSgQT2IZr9uB2ISu?=
 =?us-ascii?Q?AuWu3MebuWlGSzUsj2xHIRAxsM3GnMkdzQIXu5qPNP5E8Tkx9luEU5xmrLKF?=
 =?us-ascii?Q?dygR55bynKiYtLn5q8w6lqsPvSd9Ylc5qaj7nFQ5/A/1cq6nEU1rbB2d/vO5?=
 =?us-ascii?Q?woXbTxKOxL594vz042gjpa57hrsGnj7cPLNGRMWkm11npYfNpGBCOxz4jNoG?=
 =?us-ascii?Q?4TfIzQvZMOTOuHxfhwgemBJk8OpLZDPesr3+ZaGcv8ut+RU05MesyNaH9s1v?=
 =?us-ascii?Q?Zr4oDON9e8OEdPrm7eHcW4W3r8XIRpmNh6+P6ZeYYVWWfoH8xdUz5HaGgTd8?=
 =?us-ascii?Q?jhKuVjPhKSd8cCvqnmks1wkGMkJ+tSwvCyfK83XvyyhwBfjEnKcYvMhCyZdZ?=
 =?us-ascii?Q?Bb3LetfGNY0YQBBDODBAnAVJffCDMPthBvYQuoLoXNJyAVRsggSqzel2E2hN?=
 =?us-ascii?Q?RM+mCZF/DckYD18MalSjRazZNhSYXQNWyQnW4JKYyInq6/8dsw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AwoEuHVaTKJRiHAVzb1SnSZV8EyE2G53nrq2N5k/VPcUBagWY/luAKqkFFnQ?=
 =?us-ascii?Q?daRZ6FoGJoyFz3ayXPDIzEuOvBtOpouHf7+JQ648WxtZUkaefnAIc9Y4E56P?=
 =?us-ascii?Q?tAdnbdbbaB9TVlSCq9VJcSnrUS324UuzvxY0ZhzMvkC3XqZZE3uNIKST0s8q?=
 =?us-ascii?Q?qlaC1vYoejK5WU9JEyrDFTNsEiLhq+P2XFo50k3Ap8/R6UFDGJ9KESFmrDIh?=
 =?us-ascii?Q?dBshnY5rjDX6bEEPIcKr4ZslCM6FXnFVJRuRl56LMfN28QPQE+gCHEOQsOTr?=
 =?us-ascii?Q?tX+KjLWCQc4+O8n3jzBtgOB4a9xAxA5F58T9WEw//TOzjWXEZPENNXDao16r?=
 =?us-ascii?Q?bK8GwIdFBuMR7/YZJTykikDNNRpAuzRbpRTePpilVOvreHQjdvb9610Cs+t7?=
 =?us-ascii?Q?KYyF8WlBzpcahRq2r1VZrWA2yX0WOqcbpvorFOxAdD37vttDUwVfMJYX1KeH?=
 =?us-ascii?Q?c2EbT9F2ttxdMx949LZvbM3A0Z3fp8iBUqVMo57tONQX3ZHiRkPk46EFOw3c?=
 =?us-ascii?Q?jpaj7T177VDM/aEruSp1g5eSEKqpf9uH5r09vLtRvtayMK/Gsb7Hr690qlc1?=
 =?us-ascii?Q?FzYLuenegXZTEmFQvwxgeO3XPBxmn9Aacvdhd+QUC8ebAGCESFZVAbwavxds?=
 =?us-ascii?Q?STNWiEM3AUAYS+yqceW7nmsLfOSETbhZSUY/3L3k0qpUvPlw9BqjUV4TR1h7?=
 =?us-ascii?Q?8QAm7XWwIjr3+s8NkKEc/dPstl/xOHNU7H/imz980IL6LAfgVdgd/M2OUc3D?=
 =?us-ascii?Q?/fC7bzTTdBKKgkmdRKcF7ZqXICcS7ryMfQqlBgI4NHNF5x+7HCXNb2lEjbLJ?=
 =?us-ascii?Q?qpqWXwZDPawHQEk65i7mLq+6pAqpQwlYefdhNUp57V1+bNjo9EKLO892mMt1?=
 =?us-ascii?Q?P1JzMO3VvhJXzEuezcvb9rsqtGbl/gR+0C/+dLTERMmah3ubzbi0M5XRJZTt?=
 =?us-ascii?Q?kGd1MmkprnJooJ8uVFgDsgUmNtoaw6f3w7FsKxZSTS+YY2rv6M/X02vNbkQU?=
 =?us-ascii?Q?k2jS4vJwX5UvhcCqFMnxH/I2NerPWEfFHP5PXYCcxCRyqMoZ8BDySM7eE5xg?=
 =?us-ascii?Q?SDBWNZPI8PWGtXR0hTm3FeAodg7UQwALU2V3ZAofWNFvDT2BSA/6U0Y3C7GQ?=
 =?us-ascii?Q?EthGtU3gDgsDdrgOTMg2b+y2ZrBQm+KL6BvGOELtZ02mSfDgYUzZMaOmkFyU?=
 =?us-ascii?Q?J2l5me8UH4X32ejaiJ0kftyoyRTMTcjUsYypxxnp+elumYjuxD0e2GAjBScS?=
 =?us-ascii?Q?krvVTjJ1SGOcqr3lzXj/p016SU6SBWdoZ1j/9cZeg0XB/E4mkNWa5ejm2goY?=
 =?us-ascii?Q?PyJ6cgwVLaK6FfeCdhpjG4hhDgfB8ucGGU4wT4pp324st5oZUBrfVn3gFzr7?=
 =?us-ascii?Q?TmyFGfYDL8c3eECnVxhGo4pUXOh5zejwqODRQEs7KFdYwOU5wE29Bw8QG+3c?=
 =?us-ascii?Q?rZHkrOZ+b16Dlvn0EGnLelXKVKJya5jFavzEiPUS2QYRGMOMj4X9IalOzri+?=
 =?us-ascii?Q?BzWEJAVlrHDxwtMD//HjpMz/clsMBJhApxU8ZBQZrCfcaxg91zuinN4hf8RM?=
 =?us-ascii?Q?stxXj8cxLbjgVFUVOkrc13HW1FLwBSWpr6hTgKJOQLd3lX96tAH/5ieDXz1o?=
 =?us-ascii?Q?Hw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c777de76-ea66-4255-e112-08dd6ab02ca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 08:45:05.2221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7VJH1KzSGH4dHOdQ2oe6eDc2V5dtRTmntlfoX2Fxx9l1WX3CD4ONDz4iCzJwZsfFx7UGQRJxLERB1qg2rWcEYjpdAGUaW8VZCeL4eoic0+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7493
X-Proofpoint-ORIG-GUID: KIIbexAgmRH7hEu5HoCNGLyuFAQ9XFrv
X-Proofpoint-GUID: KIIbexAgmRH7hEu5HoCNGLyuFAQ9XFrv
X-Authority-Analysis: v=2.4 cv=QNxoRhLL c=1 sm=1 tr=0 ts=67e11b92 cx=c_pps a=YkRwJB1Lcas13D3J5+BQ6w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8 a=rxxM7_75LvPRzBu7-vIA:9 a=CjuIK1q_8ugA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240063



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Thursday, March 20, 2025 5:07 PM
> To: Torreno, Alexis Czezar <AlexisCzezar.Torreno@analog.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>; Mark Brown
> <broonie@kernel.org>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: add adi,adp5055-regul=
ator
>=20
> [External]
>=20
> On Thu, Mar 20, 2025 at 02:53:54PM +0800, Alexis Czezar Torreno wrote:
> > Add documentation for devicetree bindings for ADP5055. The device
> > consists of 3 buck regulators able to connect to high input voltages
> > of up to 18V with no preregulators.
> >
>=20
> Please use subject prefixes matching the subsystem. You can get them for
> example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory yo=
ur
> patch is touching. For bindings, the preferred subjects are explained her=
e:
> https://urldefense.com/v3/__https://www.kernel.org/doc/html/latest/devic
> etree/bindings/submitting-patches.html*i-for-patch-
> submitters__;Iw!!A3Ni8CS0y2Y!-
> jfDnjTsrIleNV3xmOgakxTfgfPymC_1VWaNuF4unhOr23s35UCRin2d9qUc5Zo
> 4m92ovjLsDFzFBmdfkrzhqg$
>=20

Will take note, I guess 'dt_bindings' and 'sub_system' are switched on a fe=
w=20
subsystem like regulators/etc

>=20
> > Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> > ---
> >  .../bindings/regulator/adi,adp5055-regulator.yaml  | 161
> +++++++++++++++++++++
> >  MAINTAINERS                                        |   6 +
> >  2 files changed, 167 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/regulator/adi,adp5055-regulator.ya
> > ml
> > b/Documentation/devicetree/bindings/regulator/adi,adp5055-regulator.ya
> > ml
> > new file mode 100644
> > index
> >
> 0000000000000000000000000000000000000000..fc8f1e61ba321f8b4c6f
> 8c1e3d0e
> > 91d570fb4953
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/adi,adp5055-regulato
> > +++ r.yaml
> > @@ -0,0 +1,161 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://urldefense.com/v3/__http://devicetree.org/schemas/regulator/a
> > +di,adp5055-regulator.yaml*__;Iw!!A3Ni8CS0y2Y!-
> jfDnjTsrIleNV3xmOgakxTf
> >
> +gfPymC_1VWaNuF4unhOr23s35UCRin2d9qUc5Zo4m92ovjLsDFzFBmdSUR
> y26w$
> > +$schema:
> > +https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.y
> > +aml*__;Iw!!A3Ni8CS0y2Y!-
> jfDnjTsrIleNV3xmOgakxTfgfPymC_1VWaNuF4unhOr23
> > +s35UCRin2d9qUc5Zo4m92ovjLsDFzFBmdXh_3TTw$
> > +
> > +title: Analog Devices ADP5055 Triple Buck Regulator
> > +
> > +maintainers:
> > +  - Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> > +
> > +description: |
> > +  The ADP5055 combines three high performance buck regulators.
> > +  The device enables direct connection to high input voltages
> > +  up to 18 V with no preregulators.
> > +
> > +https://www.analog.com/media/en/technical-documentation/data-
> sheets/a
> > +dp5055.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,adp5055
> > +
> > +  reg:
> > +    enum:
> > +      - 0x70
> > +      - 0x71
> > +
> > +  adi,tset-us:
> > +    description:
> > +      Setting time used by the device. This is changed via soldering
> > +      specific resistor values on the CFG2 pin.
> > +    enum: [2600, 20800]
> > +    default: 2600
> > +
> > +  adi,hw-en-array-gpios:
>=20
> Drop prefix, drop "array" and this probably will be changed anyway.

Noted but yes, will probably move/change depending on discussion below
on the gpios/enables

>=20
> > +    description:
> > +      Asserted during driver probe. Each array entry acts as the
>=20
> s/Asserted during driver probe.//
> If driver moves this code to other place, does it mean bindings are wrong=
?

Will remove/edit. You're right, it shouldn't imply the bindings are wrong i=
f ever.

>=20
> > +      hardware enable for channels 0-2. Should be marked 0 for active
>=20
> What does it mean "0" for active low? No, active low has its own flag.
>=20
> Use proper flags and implement it properly in the driver.

I was using GPIO_ACTIVE_LOW before just '0' and it was generating errors.
I ended up wording the property this way due to it.

I was only made aware today of my colleagues that I was supposed to place
the flag back before sending my patch as this was more standard.=20
The error is due to our setup.
Will correct it and be more careful.

>=20
> What is hardware enable and software enable? Is it enable-gpios per
> regulator? Then why this isn't in the regulator node, just like we expect=
 for all
> regulator bindings?

There's a register called CTRL_MODE1 and 2 bits of it configures how "enabl=
ing"
works. This is not per regulator but for the whole device
00 - only HW or gpios enables each regulator
01 - only SW ie register writes
10 - both gpio and register are needed to enable
11 - either sw/hw=20

We decided to support 00 and 01, but the fact that all regulators are affec=
ted
there can't be 1 regulator enabled via software but the others are via gpio=
.

To handle this, our first idea was to create a gpio array to make sure all =
three gpios
are declared. If it is not exactly 3 gpios, the driver automatically uses S=
W enable.

Can move this to each regulator node as enable-gpios.

>=20
>=20
> > +      low. Requires all three channels to be initialized. Not adding
> > +      the property turns the system to a software only enable mode.
> > +    minItems: 3
> > +    maxItems: 3
> > +
> > +  adi,ocp-blanking:
> > +    description:
> > +      If present, the over current protection
> > +      blanking (OCP) for all channels is on.
>=20
> Don't
> wrap
> at
> random
> places, plese.

My bad, edited the first line without considering the next.

>=20
> > +    type: boolean
> > +
> > +  adi,delay-power-good:
> > +    description:
> > +      Configures delay timer of the power good (PWRGD) pin.
> > +      Delay is based on Tset which can be 2.6 ms or 20.8 ms.
> > +    type: boolean
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +patternProperties:
> > +  "^channel@([0-2])$":
>=20
> This is a mess... never tested and makes no sense. Either this is a regul=
ator or a
> channel. Looks like regulator, but you called it a channel. If regulator,=
 then
> missing ref to regulator schema.

I approached this as a channel initially but understood later that it shoul=
d be=20
treated as a regulator instead and failed to completely update the doc afte=
r.=20
Will fix, including other properties that called it channel.

>=20
> > +    type: object
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      reg:
> > +        description: The channel number representing each buck convert=
er.
> > +        maximum: 2
> > +
> > +      adi,dvs-limit-upper-microvolt:
> > +        description:
> > +          Configure the allowable upper side limit of the
> > +          voltage output of each channel in microvolt.
> > +          Voltages are in 12mV steps, value is autoadjusted.
> > +          Vout_high =3D Vout + DVS_upper_limit.
>=20
> And how do you configure vout?

Calling this vout seem inaccurate when I read the datasheet again, might ch=
ange.
But this vout is tied to some feedback resistors (600mV x (1 + Rt/Rb))
I added the equation for context, but the interest is only on DVS_upper_lim=
it

>=20
> > +        minimum: 12000
> > +        maximum: 192000
> > +        default: 192000
> > +
> > +      adi,dvs-limit-lower-microvolt:
> > +        description:
> > +          Configure the allowable lower side limit of the
> > +          voltage output of each channel in microvolt.
> > +          Voltages are in 12mV steps, value is autoadjusted.
> > +          Vout_low =3D Vout + DVS_lower_limit.
> > +        minimum: -190500
> > +        maximum: -10500
> > +        default: -190500
> > +
> > +      adi,fast-transient:
> > +        description:
> > +          Configures the fast transient sensitivity for each channel.
> > +          "none"    - No fast transient.
> > +          "3G_1.5%" - 1.5% window with 3*350uA/V
> > +          "5G_1.5%" - 1.5% window with 5*350uA/V
> > +          "5G_2.5%" - 2.5% window with 5*350uA/V
> > +        enum: [none, 3G_1.5%, 5G_1.5%, 5G_2.5%]
> > +        default: 5G_2.5%
> > +
> > +      adi,mask-power-good:
> > +        description:
> > +          If present, masks individual channels to the external
> > +          PWRGD hardware pin.
> > +        type: boolean
> > +
> > +    required:
> > +      - regulator-name
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        regulator@70 {
> > +            compatible =3D "adi,adp5055";
> > +            reg =3D <0x70>;
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            adi,tset-us =3D <2600>;
> > +            adi,hw-en-array-gpios =3D <&gpio 17 0>,
> > +                                    <&gpio 18 0>,
> > +                                    <&gpio 19 0>;
>=20
> No, use proper defines and proper flags.

Yes will fix as discussed above

>=20
> > +
> > +            adi,ocp-blanking;
> > +            adi,delay-power-good;
> > +
> > +            DCDC0 {
>=20
> Your schema said something else. Test your patches before sending, not
> through our systems.

Apology on this again, I forgot to run the dt_binding_check for v2

>=20
> Best regards,
> Krzysztof


