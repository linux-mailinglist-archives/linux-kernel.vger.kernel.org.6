Return-Path: <linux-kernel+bounces-205401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 163018FFB0B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D95285DFB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB0461FF6;
	Fri,  7 Jun 2024 04:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EUmctDTg"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2069.outbound.protection.outlook.com [40.107.6.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AE31BC3F;
	Fri,  7 Jun 2024 04:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717735951; cv=fail; b=SBe0sm1iB31nqxi58MX5w9YO/W+rlhH6uvkNYmzHJD/k7ag0oLBCXOmLM7KS1IY4KsgT6sQnUzyRSZ/KLPbmIP3OoxI7TN0Z+TNZ4GM5ZnrYRlMvIzfMbNWJTl0lKf+dC+bnhUHnom1KNDFVUpicq7PLRXojFLeIf3Sc45guhAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717735951; c=relaxed/simple;
	bh=/MEpqB+h7XwWhbtpTtnUX1Y62pk9JoHK8LIai8wd9fM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r0M79BBO9wGc57mmdWAfOL/aIpR7q546uysFIqzEvrnIYnIODHUISdYCSSvYeKxrOPmYndBHmRGrS9Hee0PjqBxB5Q6al5TcSspBLQY3MfjF/plWWvj2Uu+0OJywoRFxlXFG2103uQw787TNjhzVNDHwvcQ3KiAlGC61O9rdW0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EUmctDTg; arc=fail smtp.client-ip=40.107.6.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEiiVqX7nbN61icCT6gJcVMKQSwdl2NgCHCVG2P4VQxqEEz+ZopbZHDG/BqotXQipR01gy45bs+Iwkweeld9zME9erPRCgWWEaUV819iDpHqPcmtSS36lxS7CGCxeZQHs094tWeJGjzTfR0JqcA0xaIjrq5twsSvN6LAv0S26B98jGYOf7MX+5PK1TrwXgm+xErTYxZFLHL85DQnvlfe0LImJllbTyRqvfsWW7IN9nhrDFLCb2jCrhuu8Ml649uMQuvEwp8FmOME4W/1ucu+O00/VwV5Y9TIkouGxD7+CJgHWhZksHjBWLCR47q3U076OXDvi2/wECZFHVK0223Mxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MEpqB+h7XwWhbtpTtnUX1Y62pk9JoHK8LIai8wd9fM=;
 b=JIH8ByoYWhl1LZnhUFgf8UCLvBoNr1UW1pnyprYh1V3W5xVccyOfnBmEretV4dj7FZKK85qHgADYISMpT8wjmML1bhdhDPpHsSm9lcESUDqGR8h/RQxGTXBSrz6J8doT36MCqWvqMTJTAOWdEFONvLH7DvOCLCHLC/7QTj13R0nz+ZeKDbp2TLz3H6AX5+HH/IWTojuuNPGEJ8XMxKIn7J52VglbCx5gedVD6BsgTlCuL5mBhYjMQLPbx+YcQpCwWgh01GQZ6C++YjEhwhaGu3bHmAlxLF+C/HEcccohOpBlLxC1a/luB6K28sDH3s0MFOYJGAmaVh6oNN9PhE2cxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MEpqB+h7XwWhbtpTtnUX1Y62pk9JoHK8LIai8wd9fM=;
 b=EUmctDTgza0qGIm4lJfYCRJsJYtt7ErD4Six5RHhtOJ1xB07CBVHU1xr/iv+UDk+6fCjOKVhuOO8jSbRm6XsKDDHesD0mEkbgfnMdyl8yZVYtjbli93G836sRQ6xpVXo4B7KOzgE/cVrDphqrrOXCdTcyA8nwfMjrTXAjFkLYho=
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19)
 by GV1PR04MB10194.eurprd04.prod.outlook.com (2603:10a6:150:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 04:52:26 +0000
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84]) by AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 04:52:26 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Franck Lenormand <franck.lenormand@nxp.com>, Aisheng Dong
	<aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Varun Sethi <V.Sethi@nxp.com>,
	Silvano Di Ninno <silvano.dininno@nxp.com>, Pankaj Gupta
	<pankaj.gupta@nxp.com>, Frank Li <frank.li@nxp.com>, Daniel Baluta
	<daniel.baluta@nxp.com>, Iuliana Prodan <iuliana.prodan@nxp.com>, Horia
 Geanta <horia.geanta@nxp.com>
Subject: RE: [EXT] Re: [PATCH 0/4] soc: imx: secvio: Add secvio support
Thread-Topic: [EXT] Re: [PATCH 0/4] soc: imx: secvio: Add secvio support
Thread-Index: AQHaoao2BMLM0yIe10SBmGVz9u5tJLGOZm0AgC2CcDA=
Date: Fri, 7 Jun 2024 04:52:26 +0000
Message-ID:
 <AS1PR04MB9358A02564F8FDA89077D92AF3FB2@AS1PR04MB9358.eurprd04.prod.outlook.com>
References: <20240509-secvio-v1-0-90fbe2baeda2@nxp.com>
 <81241dde-da0a-4817-90f4-37741d652600@kernel.org>
In-Reply-To: <81241dde-da0a-4817-90f4-37741d652600@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR04MB9358:EE_|GV1PR04MB10194:EE_
x-ms-office365-filtering-correlation-id: 9ab4e4b4-a760-4767-169a-08dc86ada094
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|7416005|1800799015|376005|921011|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?NlpWSWR3OVJENFc5Q3dEUHQ0M3JWbm9qVUFPQVpxbVk1VU1VN0lyTVU1WWFw?=
 =?utf-8?B?d3hhTUxnblp1UFlCYnhLTmZkRkY1QzNGaVlRelNRUlV5RE0rMGdxbTNleEFF?=
 =?utf-8?B?Q3pwTzRmV0UvclRDR05vS3dRZEVHRFlXS3kxc0NVRmRSaHlKVnlwb1pxMVNj?=
 =?utf-8?B?MUE0aTJKWGg0Wlg0eFMwUnlHTGJDRzlHbVAyTmUzTWkrQm91MEVMdkFVbWtP?=
 =?utf-8?B?c1NtWDV0b2tXMERrYWQ3OXZEdmVlN1hxcHB1ZmRITmdNT1d3QS9XdXJmL25H?=
 =?utf-8?B?aUFra3l5MXZqWUpZK1FsenJyU2dhdzZSTng5cVRxUTAxb3NCWmF5Z3UvQ1Za?=
 =?utf-8?B?STFYemMwbGZwejNMREp5dk1HbzIzU29jNlcrbzBGeklpbUsyUS9ZUmNFQ2hn?=
 =?utf-8?B?cEhqYndOMC9jMjlBT2RBTGFiT0RtS2NDMDljTDVCNmlwNnQ0MHR2Z3lFcDN0?=
 =?utf-8?B?UWJVR04rVUZYUGxVcmJCek1XUGxFVlBPRzhzU2s5RHBwZmpVRStGM2puMmpp?=
 =?utf-8?B?NnMzRi9YMkN6aXpzR00rak0wM200ZlZ2N2h2d0pEOU9Zb1hvbkFuN0pucWFx?=
 =?utf-8?B?Q3BvMzhYVlcyL0MwcnprT1NnbWhuemxmVWpCeU5iV0puei9RR2JXVXBnYWNk?=
 =?utf-8?B?djBocFdaOEZ0VS90TE1JYVd1dkFBVGJjaFVpQWZKWjVvOGIvZmRldDFEbEtS?=
 =?utf-8?B?YnpMVVlibENVMk1LRWZLblVuMGFyTE1jVUFYNlZNSzYrQnp5YVFKcllsNEtJ?=
 =?utf-8?B?eGpxbWtybjR5UzRJSk8wRmFVOWZOWVFWRVpEWlc4ZDV5ZmE5bUF5UStQQlM5?=
 =?utf-8?B?T1Q1RVM1a3pNNk1jRG1xR3E4WldlQ2VhT2wxRVFqQk5QNHhheXRKWUVuVGo3?=
 =?utf-8?B?L3ZOSGZHdGJubFF6djVxMlJoQkpTcjFiS2p0NWFhRkE5QTJBYVkvdXI3ZHNV?=
 =?utf-8?B?ZjhCdnA4V2t2a3VVOCtpU0hSQ2xqWjluRTc4Qk45RVpWSWNVd1VhOHFCZGJh?=
 =?utf-8?B?ZWZUeW94bVg2dzRLTDdCZmhyV0lBQXk5M1pXd1hEdjdITndjYWtvUkJaWnIx?=
 =?utf-8?B?MTdtVUlDd1ZyVnlxS2NBci9IOE82YXBCMmpaUWFqd1hGM3l3Zks0MXIyaDlm?=
 =?utf-8?B?M0xXSXU5d042SmY2NkpzQVZ0b1FzeEd1bzlpNkNodys5L3ZKcmZxeTV3VXNU?=
 =?utf-8?B?NGxBUXJrU2xqQzl5MnlKa3FEL2xvL0xXT0JWWlhYc1NRNysyNXlLOEdrdmF3?=
 =?utf-8?B?emJSeEcvb3lCcGRqdndSNHpING4wQzdHSk8wbEdiMzlVUnJsMEFmQzFvdDdJ?=
 =?utf-8?B?a1pKaTZHZUJMZndXTW5TS2ZSQ1lFNi9qcU5PTjVjZEVWVnR2Yjd2cFBwQ0JD?=
 =?utf-8?B?SzhpQWlMbEFjTDJtc1lJVmJOelhycW45b0FXL1hkUTVsZ3JDSXVFRkxneEFD?=
 =?utf-8?B?aDNNQ2JZOWQ4elhGTkt6U1JsTnp0YmQzZHpUeVlFSmFmRmJWbURXdnFCK2Js?=
 =?utf-8?B?aEV2SUI5R3BHeWZ0c2E1dkw4TG9jVUllZ0hmVUU1WlJpT3c1OVQ3UFZoOVE0?=
 =?utf-8?B?b2xJSThNTWwyL2xmNnZWdGpvU3VVZ2lrWFhyRnNQOCtlWHhkZWxWS1pScC9p?=
 =?utf-8?B?VUppM0lyUUFjVlRSaTFqT2xWTmFJd0tENktyOXRsNlZ4cStqVGxrSG1KeWQ4?=
 =?utf-8?B?N0FJbVV3RWJVU1k5MWMxWk5NRmIyZ0Ria09ablhxUkVvcUFUaVUrdS9XT3d4?=
 =?utf-8?B?VFVQSXdvSkM2VmdldUxoZjFmTFhYN3p3N0g4dW41SmJpN05WZ2lKZ1NUaTBp?=
 =?utf-8?B?ZFBpWWNIOStxcVZnOVNwY1g1RUs0Y25PZEZKMmFnNHR5RmVXUVlsS2kxMW9k?=
 =?utf-8?Q?ngg8jqFhGJZZF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9358.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cC9YeDdPWHNYdlliMXloYjE1bG5vVVNBSVFOYVA1TnRoSkh3TTlIQ0xTZWZt?=
 =?utf-8?B?TlAvMmt3TVEzNnh0M2I0cU02T2hGeEdBV2VXMXk4ZjR6NGFKcVNhWTdXekFT?=
 =?utf-8?B?UTBjTmNNbThBOWRrUFdlYlR6d25nUk1RbE1MakhQWGdJSTZFYXhUSW1tS0p1?=
 =?utf-8?B?RjBQVUVYTnJpbmhzcFBJbW94d1BWZGVJeG81R1ZZblFvVWRWTGNtU3FTY1NS?=
 =?utf-8?B?c3pEMGhMR1RmeXBpVEtLL3d6UDZTa1FWVnovbVY2dTkxYnJNc3hvWjdzS3Mv?=
 =?utf-8?B?TzNZYUV0Wjd4ZUZyYTlMNDNoYmE1aWZmM2FIMHhCUjJ6S1cyQUlDOE1HdG5Y?=
 =?utf-8?B?eUtOcjdINlJYb2RHMEdrazJpck5kTm9xUlIwZWxaUG9FUVRhNHJKQTBiczVT?=
 =?utf-8?B?UXVuOUNmM04zbE5Nc1N5dkhMYTM3dWxoVUxMbmVYa1FpSkRETjFER1VncVhr?=
 =?utf-8?B?V1NFVGNoRlk4UmZqeDNiRXlIcXcvYUpsUml1VjNFVkloRnZIMkZ2c0tOSnlQ?=
 =?utf-8?B?cHkwQko3OEd5TFhyUzVFQUtZSGRoeVVkY21hcm43OXRPTnpPZUlzVXNjeldM?=
 =?utf-8?B?SnUyVmQwYU5GRmRUM01QNjZaN0xuMkpySDRNQWZEczFGd3NtMFNKMGxnVXgz?=
 =?utf-8?B?UHJwc05ENEVhTFNNdlFXQ3NMNGZMTGhDZG53bTg0UW9jL2lEYy9sTGFtc0dq?=
 =?utf-8?B?bnlOYWE0TG5tcllGQ3ZjRHF0S3lQdzM2cjdCVEJHMUQyM1p6K0wzZGJINHRH?=
 =?utf-8?B?S09yK3paM2xUZFBNaEVoNlhwc2UwN3MvbDVEbkpCRlN0NkZPVlY0bEsyUE9p?=
 =?utf-8?B?K0IvSXRsZGU5RDFUQzdXU2tEOTZ1d3FZMjQybSs3OG0vVFpuNmFOeGZlNStu?=
 =?utf-8?B?U3dqeWFoUm9uOEh3c3YwWHRrcS9DZ0pybUREaGhYRGtnVmxvRlh2WUY5ME9j?=
 =?utf-8?B?VHQySXV4bXo3Z1ZPancvdU9jM0E1RDRtVDNOczJpM2s2NFdObDEyQis5cTFF?=
 =?utf-8?B?b29jWG1MQWhwL1RDdnJ3OGVCQWRyMXhLZ0lyK21oRGh5Njc2WnBXVDlsNXBE?=
 =?utf-8?B?R3NlV3Y1dElPdDQ0bVc0UlM0bTRYaU1UTzEyaVJRUmxEN1pwSitDa1JmVUtj?=
 =?utf-8?B?NWtqN0FPaXZnNW9EdEJ1MHYrdTNlMFVYWEY4M1FCUlh1TUxVNHY3azBqRmhO?=
 =?utf-8?B?THBRNTFEOVplZWJTNXZ3SWpwVlF0NWEwSlppL0Q1ekpmS2I5c1NVZGFBZnh6?=
 =?utf-8?B?MEZlV2ZCRmZwQXIxWHlPTE5tNDNzWkZFL0pvVE9GR1RpR0JPQ2VsMU1NM09k?=
 =?utf-8?B?L0FySjVDaWxBcXJ3ZkF4S1JnR09HQ2NUSnJtM1FYZnJmYkNPUVFkdkJxU0gw?=
 =?utf-8?B?c3FYTFh6TndLSTlpc3FxYW9Od2tEVlRSSXJXYUVKcWVWN2NMUU8wZUxsU24y?=
 =?utf-8?B?NloxRktsZ0VhaUxJcHRVaU5yQ0lTUEhhcjUzWmxhRXZpVDFhc1ZibVdFN3Vz?=
 =?utf-8?B?M1B2T2JlTUJJRmFaNzBhQ1ZXL0J2Z3A4cEc5aG1ac0xvc0RlbHZxQndTaHhu?=
 =?utf-8?B?UGRXSVBOVHpwQ2psWTk1SGRhR1VUaWpZZU1ZZ1ZTRWExeDVEdHhXUERTWWIy?=
 =?utf-8?B?VklJeE50WlB1NmFYWC9mUXBoZndLNC9OOFJtRlZ6M0lIRWhwQTUvbEpIQ0dR?=
 =?utf-8?B?VDFLditYS2hRVWZlZjJ4Sk9rZDJJV2sxVGtLTFhBYUVMSVBPVTZUVXdERmZJ?=
 =?utf-8?B?SVY2RlZtYXAvK0IyVlplV01XVXVVTW55OHhKbE1uTWdPNUpXTmVWWkQzY1k0?=
 =?utf-8?B?WExxajB2OEdtQ2tVWlBrZEhnaHNxMXMvTk5aaC9EeFkrM2JtblZKd0I2aWhm?=
 =?utf-8?B?L2FZeHpwb2RZaVZ5S0Y3V1hQM2MxRHpaWWJ6YzVTcGpORldUa2I3MXpRS1dE?=
 =?utf-8?B?eEhEc2VQeFgwUTlWeEViT2pwbUh1NlZVcnVEOHoyR09uTGJmSjJEUmhiQTZh?=
 =?utf-8?B?TUgzOHJoczl4TDJVM1JiWGhVTUwyazFVYWJKQ3lPeG1helRJdTIzSGVsZlIz?=
 =?utf-8?B?Y3NCMmZ2WVVHbDFmU1pSYjRpbmg5NW1nOW83ZkVoMks4M0trNitGWHNVblh5?=
 =?utf-8?Q?U0dJ0kVNoelLjhHMRDxXXH4Lp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9358.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab4e4b4-a760-4767-169a-08dc86ada094
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 04:52:26.0909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j9jUApgcR2299uyHZL9F1zJjMckPAPtmTOg8eW8WA/L9X47137SMpw+0QoT1FXuObb3NexgOZ/zauQ8IqJ0rJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10194

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDksIDIwMjQgMTE6
MjEgQU0NCj4gVG86IFZhYmhhdiBTaGFybWEgPHZhYmhhdi5zaGFybWFAbnhwLmNvbT47IFJvYiBI
ZXJyaW5nDQo+IDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprK2R0
QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkNCj4gPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBGcmFu
Y2sgTGVub3JtYW5kIDxmcmFuY2subGVub3JtYW5kQG54cC5jb20+Ow0KPiBBaXNoZW5nIERvbmcg
PGFpc2hlbmcuZG9uZ0BueHAuY29tPjsgU2hhd24gR3VvDQo+IDxzaGF3bmd1b0BrZXJuZWwub3Jn
PjsgU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsNCj4gUGVuZ3V0cm9uaXgg
S2VybmVsIFRlYW0gPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IEZhYmlvIEVzdGV2YW0NCj4gPGZl
c3RldmFtQGdtYWlsLmNvbT47IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiBDYzogZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgVmFydW4gU2V0aGkNCj4gPFYuU2V0aGlAbnhwLmNvbT47IFNpbHZhbm8gRGkgTmlubm8gPHNp
bHZhbm8uZGluaW5ub0BueHAuY29tPjsgUGFua2FqDQo+IEd1cHRhIDxwYW5rYWouZ3VwdGFAbnhw
LmNvbT47IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgRGFuaWVsIEJhbHV0YQ0KPiA8ZGFu
aWVsLmJhbHV0YUBueHAuY29tPjsgSXVsaWFuYSBQcm9kYW4gPGl1bGlhbmEucHJvZGFuQG54cC5j
b20+OyBIb3JpYQ0KPiBHZWFudGEgPGhvcmlhLmdlYW50YUBueHAuY29tPg0KPiBTdWJqZWN0OiBb
RVhUXSBSZTogW1BBVENIIDAvNF0gc29jOiBpbXg6IHNlY3ZpbzogQWRkIHNlY3ZpbyBzdXBwb3J0
DQo+IA0KPiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBj
YXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBp
biBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMgZW1h
aWwnIGJ1dHRvbg0KPiANCj4gDQo+IE9uIDA5LzA1LzIwMjQgMDI6NDUsIFZhYmhhdiBTaGFybWEg
d3JvdGU6DQo+ID4gVGhlIHRhbXBlcnMgYXJlIHNlY3VyaXR5IGZlYXR1cmUgYXZhaWxhYmxlIG9u
IGkuTVggcHJvZHVjdHMgYW5kDQo+ID4gbWFuYWdlZCBieSBTTlZTIGJsb2NrLlRoZSB0YW1wZXIg
Z29hbCBpcyB0byBkZXRlY3QgdGhlIHZhcmlhdGlvbiBvZg0KPiA+IGhhcmR3YXJlIG9yIHBoeXNp
Y2FsIHBhcmFtZXRlcnMsIHdoaWNoIGNhbiBpbmRpY2F0ZSBhbiBhdHRhY2suDQo+ID4NCj4gPiBU
aGUgU05WUywgd2hpY2ggcHJvdmlkZXMgc2VjdXJlIG5vbi12b2xhdGlsZSBzdG9yYWdlLCBhbGxv
d3MgdG8gZGV0ZWN0DQo+ID4gc29tZSBoYXJkd2FyZSBhdHRhY2tzIGFnYWluc3QgdGhlIFNvQy5U
aGV5IGFyZSBjb25uZWN0ZWQgdG8gdGhlDQo+ID4gc2VjdXJpdHktdmlvbGF0aW9uIHBvcnRzLCB3
aGljaCBzZW5kIGFuIGFsZXJ0IHdoZW4gYW4gb3V0LW9mLXJhbmdlDQo+ID4gdmFsdWUgaXMgZGV0
ZWN0ZWQuDQo+ID4NCj4gPiBUaGlzIGRldGVjdGlvbiBpcyBkb25lIGJ5Og0KPiA+IC1BbmFsb2cg
dGFtcGVyczogbWVhc3VyZSBhbmFsb2dpYyB2YWx1ZXMNCj4gPiAgICAgICAtIEV4dGVybmFsIGNs
b2NrIGZyZXF1ZW5jeS4NCj4gPiAgICAgICAtIFRlbXBlcmF0dXJlLg0KPiA+ICAgICAgIC0gVm9s
dGFnZS4NCj4gPg0KPiA+IC0gRGlnaXRhbCB0YW1wZXJzOg0KPiA+ICAgICAgIC0gRXh0ZXJuYWwg
dGFtcGVyDQo+ID4gICAgICAgLSBPdGhlciBkZXRlY3RvcnM6DQo+ID4gICAgICAgICAgICAgICAt
IFNlY3VyZSByZWFsLXRpbWUgY291bnRlciByb2xsb3ZlciB0YW1wZXIuDQo+ID4gICAgICAgICAg
ICAgICAtIE1vbm90b25pYyBjb3VudGVyIHJvbGxvdmVyIHRhbXBlci4NCj4gPiAgICAgICAgICAg
ICAgIC0gUG93ZXIgc3VwcGx5IGdsaXRjaCB0YW1wZXIuDQo+ID4NCj4gPiBUaGUgb24tY2hpcCBz
ZW5zb3JzIGZvciB2b2x0YWdlLCB0ZW1wZXJhdHVyZSwgYW5kIGNsb2NrIGZyZXF1ZW5jeQ0KPiA+
IGluZGljYXRlIGlmIHRhbXBlciBzY2VuYXJpb3MgbWF5IGJlIHByZXNlbnQuIFRoZXNlIHNlbnNv
cnMgZ2VuZXJhdGUgYW4NCj4gPiBvdXQtb2YtcmFuZ2Ugc2lnbmFsIHRoYXQgY2F1c2VzIGEgc2Vj
dXJpdHkgdmlvbGF0aW9uIHRvIGNsZWFyIHRoZQ0KPiA+IGF1dGhlbnRpY2F0aW9uIGFuZCBzdG9y
YWdlIGtleXMgYW5kIHRvIGJsb2NrIGFjY2VzcyB0byBzZW5zaXRpdmUNCj4gPiBpbmZvcm1hdGlv
bi4NCj4gPg0KPiA+IEFkZCBsaW51eCBtb2R1bGUgc2VjdmlvIGRyaXZlciB0byBoYW5kbGUgc2Vj
dXJpdHkgdmlvbGF0aW9uIGludGVycnVwdC4NCj4gPg0KPiA+IFRoZSAiaW14LXNlY3Zpby1zYyIg
bW9kdWxlIGlzIGRlc2lnbmVkIHRvIHJlcG9ydCBzZWN1cml0eSB2aW9sYXRpb25zDQo+ID4gYW5k
IHRhbXBlciB0cmlnZ2VyaW5nIHRvIHRoZSB1c2VyLg0KPiA+DQo+ID4gVGhlIGZ1bmN0aW9uYWxp
dGllcyBvZiB0aGUgbW9kdWxlIGFyZSBhY2Nlc3NpYmxlIHZpYSB0aGUgImRlYnVnZnMiDQo+ID4g
a2VybmVsLlRoZSBmb2xkZXIgY29udGFpbmluZyB0aGUgaW50ZXJmYWNlIGZpbGVzIGZvciB0aGUg
bW9kdWxlIGlzDQo+ID4gIjxrZXJuZWxfZGVidWdmcz4vc2VjdmlvLyIuDQo+ID4NCj4gPiBHZXQg
c3RhdHVzDQo+ID4gUmVhZGluZyBmcm9tIHRoZSAiaW5mbyIgZmlsZSB3aWxsIHJldHVybiB0aGUg
c3RhdHVzIG9mIHNlY3VyaXR5Og0KPiA+IC0gRnVzZSByZWxhdGVkIHRvIHNlY3VyaXR5IHRhbXBl
cnMuDQo+ID4gLSBTTlZTIHJlYWRhYmxlIHJlZ2lzdGVycy4NCj4gPiAtIERHTyByZWdpc3RlcnMu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBWYWJoYXYgU2hhcm1hIDx2YWJoYXYuc2hhcm1hQG54
cC5jb20+DQo+ID4gLS0tDQo+ID4gVmFiaGF2IFNoYXJtYSAoNCk6DQo+ID4gICAgICAgZHQtYmlu
ZGluZ3M6IGZpcm13YXJlOiBzZWN2aW86IEFkZCBkZXZpY2UgdHJlZSBiaW5kaW5ncw0KPiA+ICAg
ICAgIGZpcm13YXJlOiBpbXg6IEFkZCBTQyBBUElzIHJlcXVpcmVkIGZvciBzZWN2aW8gbW9kdWxl
DQo+ID4gICAgICAgc29jOiBpbXg6IHNlY3ZpbzogQWRkIHN1cHBvcnQgZm9yIFNOVlMgc2Vjdmlv
IGFuZCB0YW1wZXIgdmlhIFNDRlcNCj4gPiAgICAgICBhcm02NDogZHRzOiBpbXg4cTogQWRkIG5v
ZGUgZm9yIFNlY3VyaXR5IFZpb2xhdGlvbg0KPiANCj4gUGxlYXNlIHZlcnNpb24geW91ciBwYXRj
aGVzIGNvcnJlY3RseSBhbmQgcHJvdmlkZSBjaGFuZ2Vsb2cuDQpTdXJlLCBJIHdpbGwgdXBkYXRl
IHRoZSBjaGFuZ2Vsb2cgZm9yIHYxIGFuZCB2Mi4NCj4gDQo+IEkgd3JvdGUgYWJvdXQgYjQgYWxy
ZWFkeSwgd2hpY2ggc29sdmVzIHRoaXMgYXMgd2VsbC4NCk9rLCBJIHVzZWQgaXQsIHdpbGwgcHJv
dmlkZSBkZXRhaWxzIGZvciBjaGFuZ2Vsb2cgaW4gbmV4dCB2ZXJzaW9uDQo+IA0KPiBXaGF0IGNo
YW5nZWQgaGVyZT8NCkFzIGhpZ2hsaWdodGVkIGJ5IHlvdSwgVXNlZCBiNCBzY3JpcHQgdG8gYXV0
byBhZGQgYWxsIG1haW50YWluZXIvcmV2aWV3ZXIuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEty
enlzenRvZg0KDQo=

