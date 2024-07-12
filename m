Return-Path: <linux-kernel+bounces-250227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D113B92F572
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2F81F22A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F0613D533;
	Fri, 12 Jul 2024 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gTDvAOI+"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011029.outbound.protection.outlook.com [52.101.70.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E2513D88C;
	Fri, 12 Jul 2024 06:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720765408; cv=fail; b=ulLnYbmjgVb9862KmjNmec28QwkEm+Cx2RawaokEQFylp7427eARHfgZrjvjzYd5byts+CobOnOjCeCTBWIj9ZmS0WGm63Yd0fR98Vaob8+IY/NpqC7DoL6RRwHtQjNQiUAfBwRkXjlknuie3/0GwL8qwz5xpe7TZe3v5JeFvvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720765408; c=relaxed/simple;
	bh=JtbBx0yQoAaTNbWkXdPsH4Vzzy2ZXxKhbLKP3eswoUE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gah2auJ+wnD9SPrdN2BAPU1mP4+rLr6a4wVVbZ+C09B84Bz+t99y/Jsos8iWcsDySoiIk/FAtywiFyXucddhKIQsEH9qd1CN4gmdQvzgRG3F8k19AMsZs8zdqvc6e6omDnXkcoKu2ZxUCrY1aik2n00Z1uMKRZUGi96c8rIDEEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gTDvAOI+; arc=fail smtp.client-ip=52.101.70.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yA4ZX75EJ4ELq0d0F2z64m3sGZI9N/Qx/LUx8eJCyFR/7+UUnei9ixEf2FT2ClbgE3s0A+dLwxHNEtMXSnSUp89zfxt7+gi9SKjsWqlaLKooS+MRL3DwsJrlfvysqCOJsKBwQByQTVUZUTLb6SyezHUdSLaqsYCZoNRanG8/IfcYEf2/qTIiaTCud/T59xRuVBShTWKkmYHwmDwggE4wRvSPTazmtiFybqB7mS1Mvq0Da01kalX9RNsrfoNAe8ApsXr5yxZMCiCkVWJ5fEsFOpgFQ2oXbEnPS5UXhp3/pU6m4F/r954f9xp7q1nDf33XvpgPksZWaCCxlFqo6Dzqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ah1WwJJf1pD0+xwYmMkAwafT1y9D9eXkXOAlq7r/suI=;
 b=uSYHh0Pe1ENO7vPkHDysDLkgXj0dm6b0wXxmTu2e0aiAy6eaKPsHIPVV7YM96j8qHDXpZq3Zp5+fb9QFd3g0v7ud/KoR2MSp24fNtU1yvhp4OuzfjFyFKL4fa6cwU5p9+yG8RqQQkl+qXUZeAVflnzigkfBkR+Wq7Aj2UgOIRDHLzchDGOT4AryGZWUxmW8xamVLXBRtFqNAcD+CXFmfmvupgCGZFZevdM3wB1j660Dj/E/fcjURbrWWqMf17W29gDMgtpipx4QsbmCJxV6slshkdWd/h+oN8lscsrS/xvuzwdu1FOGPvA2yIuoAaTEYOcfTYMs1/hNXXOAkf/bSmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ah1WwJJf1pD0+xwYmMkAwafT1y9D9eXkXOAlq7r/suI=;
 b=gTDvAOI+g64rg1D5ikKrYHOuHSp8ka2pa5r8A3J55y6R2BR/EwQgoDnn1IAswhUGrpmmlwyST2B/jFItCgMmhjpcgD//hE5ti5E+AfdnqJMZcogLwjeYs8p8rhqrqSvFztjkIn6joT/0R5Cg4e53SOXQQKeLjRGaZrUM08RTjnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB8PR04MB7068.eurprd04.prod.outlook.com (2603:10a6:10:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 06:23:23 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 06:23:23 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Fri, 12 Jul 2024 11:49:57 +0530
Subject: [PATCH v5 2/5] dt-bindings: arm: fsl: add imx-se-fw binding doc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240712-imx-se-if-v5-2-66a79903a872@nxp.com>
References: <20240712-imx-se-if-v5-0-66a79903a872@nxp.com>
In-Reply-To: <20240712-imx-se-if-v5-0-66a79903a872@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720765211; l=3836;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=JtbBx0yQoAaTNbWkXdPsH4Vzzy2ZXxKhbLKP3eswoUE=;
 b=FoPJl8139JYtMzDo57U2+jgE2gfklxXOgwI+g0WFJroaILiVrFerVBH+eBaiIPzfYrqZ8G/QT
 vHNMEK7caPaA76ctpfjCa3TtRMQXwULNlWsfdR4ZmqUrwFzmDmXuv85
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DB8PR04MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: b649143a-18e3-4a6d-f19a-08dca23b218f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3UvM3Y1TTR4NEc4ZE8wSDQ0NFZjSDF1M0lSNWpyT2lJMEJLWDBpb1N3M2ZW?=
 =?utf-8?B?LzJRNUkvQ2s2T25zRWxKbXhieElGWDZ2bUdPMytydm5lRTM1aFhncDFGeUpm?=
 =?utf-8?B?aE4yNG81ak1vY2dSbXdRd0o5TzlmSlJoV0JnMnhrR3RTU05QUDlDSEZpUXN6?=
 =?utf-8?B?QTZoUjd5NkIyYkExOVNwbE5DSGN6bmNDTDNub1pEeHR5QlBmeFJkcUkrUGFy?=
 =?utf-8?B?S1p3MWJEYm8vZTNyME5ZSVdFcEp3cEs2R1c0dXFFQzVKY1JYN2cxUm82djIw?=
 =?utf-8?B?eFNwdTlTSlpFL0hPangvcm5YSWE4dWlnMXUzV3lQSGsybjdhd3FWa1U5Y3pX?=
 =?utf-8?B?RWFqS2dRekF0U1NzVkdnaHdFZkVUWDByeVZJUkF0Ynd1RnRRUDYyRHlBcU1D?=
 =?utf-8?B?azNSTjRiR1hUbXlXbld1QTBoT003RWpFUFNIVTEwVStqQWVrZFJYTGM5elNp?=
 =?utf-8?B?dW5leEM5dHR3YnBDN3Jua293cmc2WTRhcDRJY0o4aGtOSzA2K3pITWdBSFl1?=
 =?utf-8?B?cXpiWk1iSTUwZHV3eTJGckxhTWRrM2o0VWRKcG0xczRoNEIwNmpTWnh0V011?=
 =?utf-8?B?bnQ3ZGhEb3BLTmtXellrWHdyUTJ3YkYzRVRPQktIQU9ZQ0dTdEs1MlkySmNk?=
 =?utf-8?B?WmV2NkJDYjV4NkdxQjhxcllZTlM2cTJCS0xpc0VndUxVdVRuaVdYUUIrNTEz?=
 =?utf-8?B?Nzk4WnBWbDhNbWc2ZW12QUlDWDZ6eWk0eWlnR0s3V09oSmNuTnV4OE5ZNHQx?=
 =?utf-8?B?SFArMGR6WW16OXRTTktJN0x5TUl4TjlsZklMaVpvL0hnajhCeERveHdVc0Vn?=
 =?utf-8?B?WnNSYnI2bDRIOGI2RFFpNDgvUVM4VVRMZjV5aVljZmpvUXJlb3lhc1ZxZDh5?=
 =?utf-8?B?WVpqR1ViVHpxMStObmFEa2t1dWJ5bXVEV0pZTGFIOVdqQVBpNUJXQ2s0L0pv?=
 =?utf-8?B?YW5LMG5qK1IvWmRVT0hkNFRSdGNIY05VcVRXMS9uK0FPZldTOTdoZ0Y5UEpX?=
 =?utf-8?B?QzlCSXkxSFNSTkpBRGdtZmd2UVNBa3JVdlJrcko1cFN6cFp6ZEFEQllkaXZT?=
 =?utf-8?B?THNMVEIxc1E1cmJDbHhHanppdEhrYVRrOWVYTDFUVUNIamk0VnFtZ0JmUm43?=
 =?utf-8?B?K0tkcXovbTB2RDN0VjcrVmtzWXdmbjlHWnRHWGNMTFlDWG1aS1lJcWNlWlBN?=
 =?utf-8?B?cUFuWGxoalMwZllvN2MwWE9aSnZwYlVYajJTU2dVMlVzTmxPY2MvOENmUFpv?=
 =?utf-8?B?L3R2T1c2MnBXQmtWQ0w1ZThHcDhGNjNnMHY4WkFSZHViUnVtZzZlbGtSaHEv?=
 =?utf-8?B?VGs4MGx6MFZRS3Q0amxuWXQ3MEp5a0QraWR1YzFMNllWdHpSZExKbWl0U1NP?=
 =?utf-8?B?aU9DcjkxN2N1dkRrNkdzcm5Mb1dvanhtNXNIMGdjb3NGWG8xOGZnZU9VdkRa?=
 =?utf-8?B?aXVpT1AxWkNnMWJySlJpNVkzbm9JVzdmMmRHenJtRm96WTdRM0JTY1B5ODRR?=
 =?utf-8?B?NENpMGh1UjdNWkhhM1hycEs5bjNOQ1NBN084cXZxTEF1T2Y1akp1TGU1QWpa?=
 =?utf-8?B?SlliVHBkdTRsL2laeXFRb0RGMUhEcmRFUUx6VENFT1dDNTRJVGRzVFlUTFRw?=
 =?utf-8?B?QndnMGF0ZE42UG9xSll1NnhIWnF4L0d3V1QveHRKYzdjTDVQL09ocWEzUnVp?=
 =?utf-8?B?TzBTSzVnZHNlWVpWc2crOVRuZnJha0I1OHFOcWc1QmphUWdIcSs2SXA5MnNE?=
 =?utf-8?B?VVdvRkNKcUxvSmJ5dWJ3VzNLQUkrM3VaL3lDYVRUT242d092TFFNTFhkWkpK?=
 =?utf-8?Q?ApFiqVypZUlKkHkcwwueq/N/ISGmvaqV076Vw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjByS3lSQzVCZmNTbHJBa2FCQkVhcWwxRmtsanhZam5VUm1Lb25wS0tHalY2?=
 =?utf-8?B?WEdhZFBCWHY3NThkOGVsNUtLZzRmT3BkbHJ1Z291bGhTaVdPTVFHTGtGVnBj?=
 =?utf-8?B?Z21NZG8vWHUzdHVNZyt1dkh4YnVpS3NSRnplVWNkT01uUzNEaUdBczB0L3Bt?=
 =?utf-8?B?eTF0ajNjNDZKWFVoVG1pOWk4QnRPck1OVFR3TlgwRDc3MUMrdldBUUdSTlM4?=
 =?utf-8?B?NjNkS2F4NmUxUmQyN0ViYnY1bmNTZzk4b2VKbXNTY0w3aGZYUWlOQm1USnR2?=
 =?utf-8?B?Y3JwNjUxL2JVZEVpdTNsWExvb3RWbjBUeTJsdDZJVkpxU2NlT2xKYk9SaVQ4?=
 =?utf-8?B?cEc2dFBGUXRYeERibkZVNERidytyN3NtS0NJb0dFa09hbXhUUncvRmI1ZkVH?=
 =?utf-8?B?NWF3cmtuSllEU0Q4WmxNM2s1YjB1eDJmeEdVQ01tUE1HK1VmVzBFVDhNVWRM?=
 =?utf-8?B?ZkxoMlU4Zm96ZlAwMG03ZVN5dzNYZjliWTJNMmplZTlrR1pPTEhCcHgwdTIw?=
 =?utf-8?B?RlMycERoVEJZcUhyMDdsRnR5Q0VuWmRpNnBoZnlBSURZK2VhamE0dlo2dVpU?=
 =?utf-8?B?aDljK2N1U3FsaVBMeTdKSnRMUC9XVCtpeERUem9hMVA1T3cvV2pEYUpCUlgv?=
 =?utf-8?B?dXlvSk52eENsYXZrZVB3bWp0bmNZcWV5S2xZbDFMVlJJRzVhRWpHVU8xZk54?=
 =?utf-8?B?OWpDaHBKZURnUVluU0loUzlnaVpwQUphME1hbXIyUmVTSFhGa0g1ZDY1eEEy?=
 =?utf-8?B?Y0R6QU0ydy9ON2dSbnBmaTJZY1J0YXgwN0s5bGl0b0RtQXkzam1YckZCdDQ2?=
 =?utf-8?B?b29pN0UvRlpOWkRGMnhqWnVKU200SzJHbTM5VVZLZEVlb0Z6TFlNNVB3ZnlY?=
 =?utf-8?B?SzhYTmQxaFltdDJ0bFBjMXk1U3JOSTJMemVHUkVVdFloL3FtNjB0M0plSlZR?=
 =?utf-8?B?SFZVeGZJWkxZYUNRdFBTK3dCdnZtUmcvSWk2ajJRaEw4MHduMkxsWWFTancy?=
 =?utf-8?B?YVVqL2NGQlJya09EN2xRSnd0djNlallMYnlEZE1PUkhteEhxTnZSajNBclBC?=
 =?utf-8?B?UUp2bDNUZlg0aVp0cFMvQ1NWQTVQbEhPNXVOVGFKVlYydW5XN3lsclhrS2Ur?=
 =?utf-8?B?ZWQxaE9qYUFFZ1RyOE0zYjBsd2R3VkZ2OWh3TmJVYmxBa1JYb3JVYnFST0Jx?=
 =?utf-8?B?TG90eVFOY1FaNzlLSi8va3dhbmRSNnBFM0ZKV21RdXBIcy90bXdqb3NrSkE3?=
 =?utf-8?B?dnBXL3ozd2NEK2ZXT00weS9WZ2tkZ1pudnhrSE1mUWZudnNYb0VHRjZnNVVQ?=
 =?utf-8?B?TFJoVU12STlyREJqQ2xBZVlEZjl0ZUwvUnpZbHR5SThVNlUzOVVCeFFMWGNa?=
 =?utf-8?B?OGZ2N2dnVlF6cG8veStsNFFjWkd5STVoV2NIRVYwVWUxZm0za0ZSMlV5TGpM?=
 =?utf-8?B?Mm9BZDhBK0ZGWWtsODFWK2ZiVGRsbDd3YUpBMll0dk95Z3J6Wk9CYnNDbHkw?=
 =?utf-8?B?UTcwSThkVGxsdTNtZkJPcWtOYnl6am5NaTZHM2loV3F5LzNtMzEycFlOT2Ey?=
 =?utf-8?B?WlZwcWdxbGhkRmVhajFKTW9iam1kNGNTeklDWThsL1hxYTZUV2VXV2ovR0wz?=
 =?utf-8?B?WnJJN3MzZGp6QW8rRWpLV2s2YldMb2pYMDA4d29icDRyR0dSV2l1Z0M0WHVB?=
 =?utf-8?B?UGJqeG55MllmZkJyR1RjcUdRenZ0ZGY5MHlDeDZtSjVPOVJUa3ZoREFNRkll?=
 =?utf-8?B?VTNvNExTdDhiUDhzRk9zcUcrSDREUGdZbHN1UHVKaERTYzFJd1gvcXVFMGhW?=
 =?utf-8?B?Sm1hMEhjem9tVkJndGtwc3d5Z080ZjY5Z1cxUldWQkdGU3YyZzV2eks3dG5a?=
 =?utf-8?B?SVZURzFkRkxJY045TkI0bHNNZUx1SEVwSjRER1h5RjZpUmtZUEN3OEFxWm5B?=
 =?utf-8?B?Q2FORlVHUUJNR3hZQWV5L3QyNEQ4YXhGSTM0U1FRY3pNVDMrcDR4NFNHdlBl?=
 =?utf-8?B?aUNXSXFLV3lrUVhsTGVtY2t2R2FmL3gvbFhDQ0JaUkx1TFNJS2VTYlRlSFQ4?=
 =?utf-8?B?ZElPdVp0ZXVLS3lsSzNBOXpmSEs4TFNHQXdDaVh1SjNSU0tXaVBoQTU4ZUZN?=
 =?utf-8?Q?g2rGMeyRBDue3JOsTxytreVvl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b649143a-18e3-4a6d-f19a-08dca23b218f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 06:23:23.1304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxWGT7wbcoe5lG/qS+BfKD+KpvfouHBK55y0JBiooOlZYXqgg6ZaZE6nYNbTD0wDVtU64ZiRdRjr6ScwCqXRkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7068

The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
creates an embedded secure enclave within the SoC boundary to enable
features like:
- HSM
- SHE
- V2X

Secure-Enclave(s) communication interface are typically via message
unit, i.e., based on mailbox linux kernel driver. This driver enables
communication ensuring well defined message sequence protocol between
Application Core and enclave's firmware.

Driver configures multiple misc-device on the MU, for multiple
user-space applications, to be able to communicate over single MU.

It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 111 +++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
new file mode 100644
index 000000000000..bd99505de6e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
+
+maintainers:
+  - Pankaj Gupta <pankaj.gupta@nxp.com>
+
+description: |
+  NXP's SoC may contain one or multiple embedded secure-enclave HW
+  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
+  enables features like
+    - Hardware Security Module (HSM),
+    - Security Hardware Extension (SHE), and
+    - Vehicular to Anything (V2X)
+
+  Communication interface to the secure-enclaves is based on the
+  messaging unit(s).
+
+properties:
+  $nodename:
+    pattern: "firmware@[0-9a-f]+$"
+
+  compatible:
+    enum:
+      - fsl,imx8ulp-se
+      - fsl,imx93-se
+      - fsl,imx95-se
+
+  reg:
+    maxItems: 1
+    description: Identifier of the communication interface to secure-enclave.
+
+  mboxes:
+    items:
+      - description: mailbox phandle to send message to se firmware
+      - description: mailbox phandle to receive message from se firmware
+
+  mbox-names:
+    description: two names are to be listed, one for rx and other one for tx.
+      The name can be any of the below list.
+    items:
+      - const: tx
+      - const: rx
+
+  memory-region:
+    items:
+      - description: The phandle to the reserved external memory, the only
+          accessible memoryregion to secure enclave(SE) firmware. It is an
+          optional property based on compatible.
+          (see bindings/reserved-memory/reserved-memory.txt)
+
+  sram:
+    items:
+      - description: It is an optional property based on compatible.
+
+required:
+  - compatible
+  - reg
+  - mboxes
+  - mbox-names
+
+allOf:
+  # memory-region
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-se
+              - fsl,imx93-se
+    then:
+      required:
+        - memory-region
+    else:
+      properties:
+        memory-region: false
+
+  # sram
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-se
+    then:
+      required:
+        - sram
+
+    else:
+      properties:
+        sram: false
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      firmware@0 {
+        compatible = "fsl,imx95-se";
+        reg = <0x0>;
+        mboxes = <&ele_mu0 0 0>, <&ele_mu0 1 0>;
+        mbox-names = "tx", "rx";
+      };
+    };
+...

-- 
2.34.1


