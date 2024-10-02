Return-Path: <linux-kernel+bounces-347739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5614F98DDE6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13199282B47
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7596B1D14F6;
	Wed,  2 Oct 2024 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gK6zHIDD"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A781D0E3E
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880659; cv=fail; b=YQc7+gQZyo497evdfoR8uy4pfNA2DN7oyHx8R09GIUwEPqTA1cxw2KLbwSbJaZbh/gnqPzyOCJHk5bYbZ9Eg2sBISyIlwUbOhvq/I8L6+G5xAtyFEPN2Dk8t115Usp3u4Dg+23yN2P4TE+rnW+hjpAhsOVmYd6JgaShfb9/DZDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880659; c=relaxed/simple;
	bh=PBBSfHDVYCdWWJVtSVLzuz59brGY1sY/p66hu57yrIo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=doVVWnX8jyPI+j5VAqVRIMIMOg8T+tKeTh2SwnTAVErqdAhYecVHL/PBpkvdAK5VOq+a857/FIFulFd/JjTfuNDYIaSTfhYGk2DqV9R1YNqrO7PIvvqQHCwPslKZEDR8efxT/t2ivFvROQx18HkBa39KCnx6aRJrVGOF2x+x+gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gK6zHIDD; arc=fail smtp.client-ip=40.107.20.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcqAXDoRfpbPsI54GXq03TzX0VQBfiT5ZCQ0LL9agOLnvPz7Uf/aYQ+dG0X1lEblO1CZk4B//nkRtoI4/ABpujInduq6BoduNcLWsZObUJnB8VBSmV1M5GIENeWdqH1wZlhpPkq9ZLivrListtoYYfenBjwqY8jAWBDpfId5aU5mU6iS1dC9UWWx0ImT8S7F8kDQAhDydIglHVvEpmINz6sZZW9bgvmysmVyx9AqWT3sJgE5Aelr9MZuMMtp47T50MaEbtdyDRjqY7XF3vHqZ//e+ZxZyL814XRs84oL0GO7+LY7SM9btyedW52g5Jx5+7XSbPKSs71tNA4JDObafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igRMisCW/2kVicUCWragCOXWuSz9w6K+xZKwl+FSnWA=;
 b=MoyRAvCs7ebSBBiP3vo08gOqWtbUu4IrLxnfEPfhv36rSWcC3ABceIFV1Zb0YusSyd3FzkroCaeHBcPldJoFDnnyvCeoV39IWBMP0NEEnMJA1qKub94Qkv6awoqGdLQLVYCyyKdZlBzYdcfPqumD0et7ja3RCLLZjAAPQUBkkJ3AQjuU9+F2XWzuZVUW5Y2Iz5tNe/78EB88fpt9qgKc5TOqw8mlp8dZOXaPJ/65vsxiMiJvPGL3sn6DjXXkMkxPKnSGKywVGbc3ax1JWlX2lze2DLXJUcwXG4wZALKzTgqjOrO/bsbRssQc1tVreak82YTbemkfq7lBCk+5aLsrVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igRMisCW/2kVicUCWragCOXWuSz9w6K+xZKwl+FSnWA=;
 b=gK6zHIDDBdNjhJfxVjBNAeaMg65Yp+PVGznW+g0E+LDALYXkc+P22EziQhnBVW7aW71U8oxdMzJzUYxwa0MVmuOxylXuSE96K+v8OeUfftCPcy256tLLTpgJ0Hj91cki6y2ocajcaUeaHnP9Y56kfHSfuGkPHAF7K2qvH9PB9swy+Tru9Y7uD5+m6e22QWSBTuM1/Rgl7zAw4rJ7H9c/s5V1KBgowtirTvzRcNt8L1Uu6pYMQjFuSTNmW4tReoPjY+Dt3x612+fI8fLi+V/qjBYBelObAjNay+3Mh/Q3LB4RCqn748PPSFV9ZRBK3zYcAfHqsnDPynyOxJ5fVnU+0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9699.eurprd04.prod.outlook.com (2603:10a6:20b:482::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 14:50:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Wed, 2 Oct 2024
 14:50:54 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 02 Oct 2024 10:50:33 -0400
Subject: [PATCH v6 1/6] i3c: master: svc: use repeat start when IBI WIN
 happens
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-svc-i3c-hj-v6-1-7e6e1d3569ae@nxp.com>
References: <20241002-svc-i3c-hj-v6-0-7e6e1d3569ae@nxp.com>
In-Reply-To: <20241002-svc-i3c-hj-v6-0-7e6e1d3569ae@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727880649; l=3676;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=PBBSfHDVYCdWWJVtSVLzuz59brGY1sY/p66hu57yrIo=;
 b=RfKmOMlSE5qLM+Nbfkb7OcOpVIojBrrVkI7oYYjq/k2xEK4mPjR4p/NDeLqFAMQk9kuxPo7hP
 GoZ/z9mtBUBCkLaz/ohcB8fAEyYN8nbyvSSb8TOdD4dx34U4tWnKN82
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9699:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ecbda3e-4031-4a2f-ee76-08dce2f19d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MU9XQ2RYT2pXSVZVU2UwUm4rdUZXN0hTK3I1NjMxSnBRSnp0cjFSUU56Q3lr?=
 =?utf-8?B?eHRhUHVONTMyVm00elZZTzNuTU9KRTRPaWc2elZITnEzQ2lteEU5eGxmbk9k?=
 =?utf-8?B?U2V3N2NUb2VSS283dE5SbkE0d2hScGkwcmQrZWFzNjJ2d3YrVG9rSUpFRFBp?=
 =?utf-8?B?eEE2OERqTUpWSTBlbEpTY3dSVkdQUDNZSnV2N3gzUVJEYVlXQmZNbjREOUlX?=
 =?utf-8?B?dDZmS1Zxa1A5YmNtLzV6UXdFNzlYTiszd0ZzanlmVEdOZFJZS1N2T1ZiYldo?=
 =?utf-8?B?SWpHTXpZbGovSW4xM25XRHZySXVMTjhKMklJcmthNUtQQllFVnc3dEVXVkNx?=
 =?utf-8?B?bDF6SzVCN3NRL21OdTRuMHJ3NzkxenNXd1N0TVBwcDZKR2sxcE9zaG5qUnN4?=
 =?utf-8?B?d2h5RlZiSVVsYmNGYVlvdHZaL2hFYUZRaFhzWExhOWVuelN4ZjZDUlU1cTEz?=
 =?utf-8?B?eVhQUzl5WDFWd0ppejhoK3dLOUJTaFZ2bmZ1dE0rSUh5elN2NW13bjE3R0pU?=
 =?utf-8?B?MGxNeTBSelhXaEF0SG15Y0FCdEZXREpsby9IZFJDWjhKNkZLNWhYcXp0S3dx?=
 =?utf-8?B?bmV3VW4yNzAxTEJicU5jQzUrazVROGVldllwMHBEdCs5R0RnNmx0UlE4eTVu?=
 =?utf-8?B?d3B2UzJOMmNYaDZET0kwN082dktPODFLMVV5YmNBL2Jwcnl6VDhrMnBDazhj?=
 =?utf-8?B?RTRPeEwrbDBQZGdTK25VRGx1bHRNd1BtNVNZN296NnU4RGJNdVJrNGlxSTlJ?=
 =?utf-8?B?d3dJYzlLNFl3ZXRIbGVlRFNCMkVrWUk3Y2dtSGFPREFpcDRlb1piUTY0NXZ0?=
 =?utf-8?B?RlphUUl3UHcxUTlveDVKeHRyUGUwUU9waUFoV2VEYlVtWjExaDJjbDRvTEJs?=
 =?utf-8?B?RW16eTUxekNpWGJtSStKNldJaUhJckxXUmIyZER3Y29Za2k1T1lqeWYrbjZW?=
 =?utf-8?B?MEZhUThxT2h6M013S2hWOFlYREhsc2dwbnliUjF0MFU1TWVMcWl6UWo1U1Bw?=
 =?utf-8?B?VStMRmFxZWtLVnpYcWhCeWhTRjZYeXNVNlAxMUFqLzFwL1dQVFRaU2gwemdM?=
 =?utf-8?B?KytvTXA2UnV2ODJZSjRUZnovQXhXcTZVRWF6cFNWODBGRjk3ZERDMEhKT2Jw?=
 =?utf-8?B?VldYeVZHSVMzdkJicWpSTEw2WVY5c2lZU2hNK1FFWE9mbWJjeUJjVTJBOUNJ?=
 =?utf-8?B?NkptS1puT04vTHRWUDUxVjlEUlZiQzVRT3NtR3RtL0V5eXJ2ZHk5NkJzVGJQ?=
 =?utf-8?B?WDVoaW4yMkgxMVFMMllFRUZTT05xbHQwN2lMUlFHMWZiU1FSS21ScVBxcXR4?=
 =?utf-8?B?SzRhYmdSM3o1Z3dEOHdWMC84THhoR1VlektHR2lZZ1E4L0lFQmROdHhXMzZ2?=
 =?utf-8?B?YUVyTlFrZGJBVHBqZXNOdzhUZHhEZFZ3bEFMQnBFOHpVUTNFTDUvQmZGQzE0?=
 =?utf-8?B?MTB5RHlsay81YWVEMEt6K0ZudDdFNWttRDVnTWFhSHAwRXlmeGFPbDNQUGpy?=
 =?utf-8?B?bVRHT2lGNkhOVy9ybXBNZUNPWDZQc1VGeVlsaFk3cURoR0ZMUnR2NEE1SmN3?=
 =?utf-8?B?dE9MWnVDbEJGcGsrMmVzNFJkR09qZU4wZlV5TEZKb3FSdUZJcmhzSGd4YU5r?=
 =?utf-8?B?NEpYWjZ5WVFzU1I3QU50bHR1ZDRTMGhGWDZrNU1odTByZ1hkVlRPTzYrYkIv?=
 =?utf-8?B?bTRCWUI5MVJKTnRLQm44ZGkvNUFYa1JiUGQrK1hLbGFlcnJHZllQYjUwRzIz?=
 =?utf-8?B?VE5YVFlTNUowV1A3UnV5bTJadU5hcEUyd1JKZDd2SGZxelc1ZHBMdHNXRTNw?=
 =?utf-8?B?dk4yQkVCNUNwWW5RaWZydz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHZjZXZsRWYwdFRpNmY2ZFpFb1UzMTc4VjZVbWtiZXpKaUpuaERnMTQxeitw?=
 =?utf-8?B?RUhPTXlYNW9YOW5NMVAyY3lEWExSUHI1VEVKakNxL0J2bDVTNjNoOUJ5S05X?=
 =?utf-8?B?WnVSTFVRWk9jaUEvZVJoWjJTSHo5K1RWSWZyOThOSHJ1Qm1DaEJsdUNYQzQw?=
 =?utf-8?B?aU16S2lST0FadENFRkZ1T3ZpaFEzOHA1eXA4dlE2VE0xRzh2ajYxZVFhaTNI?=
 =?utf-8?B?bjErM3FwaVlaVnR2MGUwYWJkelpDa1Yzek5ITnNpMS9lRHptVi94QlB4Skt4?=
 =?utf-8?B?OWJ6ejNaenE1eUZqdk5CajllTTlOa29HU0J6Tkp3ckRqdkpYRzh5TS8wNlY3?=
 =?utf-8?B?TEk0Qjg5ZVlGblJsa2VDZmRSNTduOFE0RURYenRkaWFwM2oxNjRRTlhSRG1v?=
 =?utf-8?B?WStVRDlZMVRoZHpOSUlOV0lMSzJqMWZqZEt3bHZOelpKODUyeG1jUjhBSnky?=
 =?utf-8?B?OXNKeVlRbDBFaWVMZmgvb25CU25iM1dLb29OSUZUNkVTcTFZcnBpNDdxcFUv?=
 =?utf-8?B?OTFqT3RZa0ZkSVBuVFNRWC8yM3ZOKy82MWw2Q1dpNSsvancxMm1GS1FuRUFq?=
 =?utf-8?B?VlVZM0U2TFdyNm5sb2xDTlRCQ2pmY0ZaTjBQZURyZXFjOFk0YVdJL0JhQUll?=
 =?utf-8?B?ZDFaTnhkYzF1cVVzZ0Frd1RUdENkVEJDOXlZc3RDNWVGdDIwOUtSc2pualBE?=
 =?utf-8?B?R1phempjZk9EUEt2ZnFGZ05KaWRtaVVoQlVYb0pLTzM5dlpRQ2hydXMxT09K?=
 =?utf-8?B?cjhaYVlOUXlyOEJrTVlOUWhrYnNzZHpCZmNxMFRWSXZueHdlY1kvVVEzb1Nw?=
 =?utf-8?B?YUFMVWtnMEhLbjlvNFlHaGcxK25OOGQxeWIvL0VuNUo1NEluc0tQR2c3OCty?=
 =?utf-8?B?WkErd29SNzlSQlNwZVJBaDJjTnJROGtLbTIyZUM0L3hTSjJiR3VHalZKU2dy?=
 =?utf-8?B?QUQwNTFPYmJEYzhuTWlQTkluOEZjMHE2UDVPU2JmYTJmRi84UmZKMmloQ1Vt?=
 =?utf-8?B?VllJRThYOU9DMzJyRXV4Rml1c3V0Znl3eXBnUEx3MURMMFNTbXdINjk2T1l2?=
 =?utf-8?B?N1hCejA5VGFDMU42Yk9mcGNjOWhyRVhxT1NIVE1wVWZIbmxReVRtTms2S1Uw?=
 =?utf-8?B?T1VmOFM3TlJxNENZY25hcGs5eEJhemxpZ05qMlJnQ3BMcElkM2duZ3JtTHk1?=
 =?utf-8?B?OHBiaEdTTCtRZ3E4SWE0QUNLbDI4bG5LRzFKWnVSd0QyNXRZcjBHbHVZcFBP?=
 =?utf-8?B?V1RMUEJjUjMxUGVQSU16S2RpK2drSTVDQUt1bmx6T004bUp6b1dGZU5TUTlP?=
 =?utf-8?B?L3VDcVBTOFN5cUlROS9ZRkhnV2d5NGVuMXhhck0ycHJFdTU2bkw3akx3cks2?=
 =?utf-8?B?SStDWFZuWHRoWDZVYW5oQTVHU0VsMy9YSkIxMW9ZNGtpTjc3SDlhUituaklJ?=
 =?utf-8?B?OTA5cjVtZG82QmFYc1Y4dGxiRkpYQlNlVFpMajdZOFRKQTFmYTFGVHl1ZVls?=
 =?utf-8?B?TWpqUXpDK3o3QUlDNGRiTkNhTVZZYmxDZUlnNmN5dFJHQXErZnRCNm9jbUZw?=
 =?utf-8?B?RXFxSEpaT0crNFVGMkFjZVp6Q0hDREV2WmtWQ21iL2wvNDhNMmVhb0NyZ0VB?=
 =?utf-8?B?N1NrOWNteXAyZkxlVGRXdlIvNmlYQWhEa0t2cU5Mc2VpWFZwMlJWSEE2dG92?=
 =?utf-8?B?WTR4TmtRYm5xTDJrSUY3bUtZTlVkdHFhUDB1c2IvOUp6MTlLQWVyOWREbHdL?=
 =?utf-8?B?TDZkUTZzUXhDUWFaYmNxUUV3VnFYZks5MGdsdXJZbmpEeEtocHp0UUVqUlBa?=
 =?utf-8?B?d3Y5bFFSVXhNR0lzQzRNdlQ5MkxWbTkrYkhGMDdnbllmdEVKYm1PMEswOHd0?=
 =?utf-8?B?NHA5TE5TNDFPVzFWdmlyQk8xeHhlQ2Y3cjl0bzZHcE16UTdUVTE1SThTUTdI?=
 =?utf-8?B?N2tXZXlwbVdXOEpVazRZU3FaTmM4VmJRSHE1S2hMVkVzL0xVSUFJTGN1dFVr?=
 =?utf-8?B?bVFqcEpTVTNBQ1RYVVU3RFVFMFU4anZkZFB4eDJFQld2TzRQdXdQcFZGT3FK?=
 =?utf-8?B?ZTQyanRPQUpqbHh6by9oSkxxWnZ3WGZUK21yS0M5dXd5a2pKdEhGTER4eG1R?=
 =?utf-8?Q?qcJNPFm4C0WYJJvRVPZbSMA3q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecbda3e-4031-4a2f-ee76-08dce2f19d8e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 14:50:53.9236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgQn+ppliJUAE4CYVlgW0/1CVPGOCVwgSFgS+HBRvz6xygEQHObz4ABtUtjfAzMb791+5K0wZ4xhIfyMT/NoIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9699

There is a possibility of an IBI WIN occurring when addressing issues, even
when sending CCC commands. Most of the time, returning -EAGAIN is
acceptable, but the case below becomes highly complex.

When a Hotjoin event occurs:
- i3c_master_do_daa()
  - i3c_master_add_i3c_dev_locked()
    - A dynamic address (e.g., 0x9) is already set during DAA.
    - i3c_master_getpid_locked()
      - Another device issues HJ or IBI here. Returning -EAGAIN causes
        failure in adding the new device. However, the dynamic address(0x9)
        has already been assigned to this device. If another device issues
        HJ, it will get this address 0x9 again, causing two devices on the
        bus to use the same dynamic address 0x9.
      - Attempting to send RSTDAA when the first device fails at
        i3c_master_getpid_locked() could also fail when sending RSTDAA for
        the same reason.

According to the I3C spec, address arbitration only happens at START, never
at REPEAT start. Using repeat start when an IBI WIN occurs simplifies this
case, as i3c_master_getpid_locked() will not return an error when another
device tries to send HJ or IBI.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Chagne from v4 to v6
- none
change from v3 to v4
- add miquel's ack tag
---
 drivers/i3c/master/svc-i3c-master.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index a7bfc678153e6..7cd3ce2643f1a 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1163,6 +1163,24 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		if (ret)
 			goto emit_stop;
 
+		/*
+		 * According to I3C spec ver 1.1.1, 5.1.2.2.3 Consequence of Controller Starting a
+		 * Frame with I3C Target Address.
+		 *
+		 * The I3C Controller normally should start a Frame, the Address may be arbitrated,
+		 * and so the Controller shall monitor to see whether an In-Band Interrupt request,
+		 * a Controller Role Request (i.e., Secondary Controller requests to become the
+		 * Active Controller), or a Hot-Join Request has been made.
+		 *
+		 * If missed IBIWON check, the wrong data will be return. When IBIWON happen, issue
+		 * repeat start. Address arbitrate only happen at START, never happen at REPEAT
+		 * start.
+		 */
+		if (SVC_I3C_MSTATUS_IBIWON(reg)) {
+			writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+			continue;
+		}
+
 		if (readl(master->regs + SVC_I3C_MERRWARN) & SVC_I3C_MERRWARN_NACK) {
 			/*
 			 * According to I3C Spec 1.1.1, 11-Jun-2021, section: 5.1.2.2.3.
@@ -1196,24 +1214,6 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		}
 	}
 
-	/*
-	 * According to I3C spec ver 1.1.1, 5.1.2.2.3 Consequence of Controller Starting a Frame
-	 * with I3C Target Address.
-	 *
-	 * The I3C Controller normally should start a Frame, the Address may be arbitrated, and so
-	 * the Controller shall monitor to see whether an In-Band Interrupt request, a Controller
-	 * Role Request (i.e., Secondary Controller requests to become the Active Controller), or
-	 * a Hot-Join Request has been made.
-	 *
-	 * If missed IBIWON check, the wrong data will be return. When IBIWON happen, return failure
-	 * and yield the above events handler.
-	 */
-	if (SVC_I3C_MSTATUS_IBIWON(reg)) {
-		ret = -EAGAIN;
-		*actual_len = 0;
-		goto emit_stop;
-	}
-
 	if (rnw)
 		ret = svc_i3c_master_read(master, in, xfer_len);
 	else

-- 
2.34.1


