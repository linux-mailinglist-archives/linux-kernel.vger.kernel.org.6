Return-Path: <linux-kernel+bounces-266309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22C693FDF9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93161C225F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71168187861;
	Mon, 29 Jul 2024 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Glicz1FV"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011036.outbound.protection.outlook.com [52.101.70.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D818A95C;
	Mon, 29 Jul 2024 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279614; cv=fail; b=mmJ4qpdqadrfUt3I3DnzV8o7Icvn+y6iskLbRzCeV25CAqCBujECoiwQDQzBmCGME6YHR3XHhqgw7tgl8ut/83soPsJKxuPjbgrzHPhyMzsfCS8ODi+GoX1Gp8DHOH8dDXNbLxiBlkZOtbum3u0ixQHBJAztJBPitzJDvmvDjEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279614; c=relaxed/simple;
	bh=DwG65Rs7M8rGP+g2lSmQfj0Q4a0qRJC/REezFQ/y30U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PgKjsWj3snjAa1hagkxGNjtYPRz2Vi+7QdU6vCUmVQalLNUX4lPy/9OCbZAITedhF8xzf26RZ4XFbBnZTSuRNmR66aKWIy1xhWZA5/parS5ioVVtjt/60X9hR4iqlEYVkCPkKX/dj50XKJFvKkDHuckwEkTnvheSGHEqoPQRapQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Glicz1FV; arc=fail smtp.client-ip=52.101.70.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5z+ZTOnYfvYTvnVKE8h10JSopKW/DMtSp/ER8U2Qp3H3sg3u8LeSWIoZQXdcFmHPBjdkrZB8n30m+2CBYq8uDOYdbm5oJSMHfP/u7Lw1Y0C79VnWdM3jMJA/jw9esnjPrqG15775oOrj+oTK3ovI8tQ1fJrIyvasT2DNDdROHrzo7e1IxsDSKhrIbsa+1gq92TVUIrGqIuG2E49C/9bck9zH4bgPjOxv66+RnR0wn7RMiz/UbtDSg6NhrMeUJw2xLluCs1Rrd5gDV66NLy/6Bb7k6y4/fOC1V6Y8Zzh0Yx29Uy3qf4SGroCKx8mO1Dw4eoiu+6MD4EgL+qqld3Cag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PfUUOibS6+fiSplVVwkVGcSltS7eF2R6ubYc/GRIv8=;
 b=VLcW7Ticgh4rJyztOr+1DL1sb77/hRSN8NbbKifzaOnfwt8HGfXfjJf0CIm9FZGadxFtvzLgYxgkZ6foOMFFJJpNJvWe9e1JbPb5QRohsIyIeQTgYdNjip9F+GQVhsbfyBCM2RVmZxiS6gezv3mLCXc4Q4i5Axjhq4SN6ILUqIl/26pyLD7sgSDR1tg2tJ9H4MRtNiqa9m0JJ+1ftQDb+2ucHfKwlx2OfbQpdF0au/gHWo98uBqpoqKyG1/XHw6jubx5fgaPFeobTH16EHrkVr6oYT2SXsc9Vsz1LqQqmkRtA6lJO5fJUbdz2NdYGHaiwV6j0ruVfnY8SqpFR/GxaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PfUUOibS6+fiSplVVwkVGcSltS7eF2R6ubYc/GRIv8=;
 b=Glicz1FVK9qAbpg5BCN25ujYA28FXCyiELa47uY0gqw5vuwLM/4jpbUsO+nlAht7h9oDv2ukKKmesYcuxxVFafYybdVoOMVPHqKvFYpag4wSvQ+0IhqIMaczq9w28TmVACRGW5l+Dh3bKbRmfShRdMrL4Ln4IF2bv+Kyo0uVVZN1ek8p/M4thzhedrBzXX0fSUD+Xkge8ZccXta7cJhVxBpJ+VlcaqHnF6Reut86xVty55QCAPXnkOKKHSe8WEwhX/KYgy8oNdZC5E6jnssoP6Hmz31tEyw173i2WzGk9CvJfpLwUTaMsGGkFQSnWWYN9mcAGte5uugyH8L0jDV41Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6939.eurprd04.prod.outlook.com (2603:10a6:10:11d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 19:00:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 19:00:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Jul 2024 14:59:28 -0400
Subject: [PATCH v2 06/10] arm64: dts: layerscape: add msi-cell = <1> for
 gic its
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-ls_warning_all-v2-6-942d80ddd441@nxp.com>
References: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
In-Reply-To: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722279587; l=9968;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=DwG65Rs7M8rGP+g2lSmQfj0Q4a0qRJC/REezFQ/y30U=;
 b=gaub+iukSLXHP97JURDC5k8dBtQO1PzUNhZXvmBHpqBb3j9g2uIF/BI4lRyuyC8WUXEvwYkA7
 X82Ey2h/eIKDOHTw9gzO21P6w6wiTqXLV5B27RH2mW6MHPU7kB8tGjy
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ebe7f8-fe1a-4de5-f5e4-08dcb000a7d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGV2QjNxaDBFbk1jU3JROWtmZ2VJbWhldHdCbmxXbHZQdUFFcGhrV2tuQ28z?=
 =?utf-8?B?c2NRbk1aQS9wQmtLRWlWQlRnaFJINWc5TC9yemJwMkNqUUVzcjFoVUU3OS9F?=
 =?utf-8?B?dU1qci9HWWFHcTNKNUdlczF0d1c4dXNrLzVuWm9wMEtmS2cvakdsb0xLZlJq?=
 =?utf-8?B?ZGhmTjV4M2pSeFBPRy9lQUQ1YmR3OWlqRXRPV0Z3MC9oRGhlSlBYVXpLdXNx?=
 =?utf-8?B?UFpjdzUxMXU5V2MxUkFEYzF1b01zeGJvR211aXQ0cFFoZWhyUGplUFdxTU5S?=
 =?utf-8?B?YmxzVkJSWTV1cER3QVBwOFdaR0dNVU9nR3BONmdLZ3B6R2dXUnhnYUdocEFO?=
 =?utf-8?B?SlNyVGl0bUh4UlJZNU40NnRxZnZ6b2cxRk03cFVzaVMxS3ZaTkR5UWlZdjRN?=
 =?utf-8?B?MXZMUHZhUkxFOHZweDgyQjBsTTAxNUt5UHBkK2ZxRDVTcHZRa3c5cXdzUlVM?=
 =?utf-8?B?TGczZENXeEt4TGcwVGNHTExXRDZMbEczTWtiN0JpaDYwSEVGZTVJTHVyZDVk?=
 =?utf-8?B?Yi9oREgrQ04wWWM4MHM1dGJnMlZiREdpR1FDdm9NNHFDNUZiSStWZGxXYkdT?=
 =?utf-8?B?Ty9vbTIxclBwNGJ3Q1RSTHJwTjZZK053RVBCU1RhTFBvS2hteHg5cXlDR0U5?=
 =?utf-8?B?dkN4UVZOVEp4cXJ6eldMY3hjZk95ZTR4NXUyMjZZYnRJdlpmTVgxbHI3UndM?=
 =?utf-8?B?S2F0M3hZVSs5UjZtcHpFS2FJcU81THZHemlRWW1BeHFGU0ltRkRzMnk1TjdL?=
 =?utf-8?B?dng5dVljaU9PZ2xMMWhvSVdVazUxUWxmdWhCTlJoYzNRdU16eGtJblVTNFRw?=
 =?utf-8?B?SW1oc01yTEJPN1JYbkwvenZ3aHlSdW10YWZMTWt3aTROS2NQQTN2QkdCSDBX?=
 =?utf-8?B?NGdQZlQ0K2RTeVlOZUhyNGpubldqR2sraEM5MFQ1VVI5SUZKSjNscmdGNUNS?=
 =?utf-8?B?UU1iOEhsZFU0OUphV3ZWLzhDM3JxNGZCVWpSMHRrOVd4YXQ3L2M2VnBNTjg0?=
 =?utf-8?B?Qm1YR2dzQy9IUGx1NkJvdmtsSFYvdERUUkxnNFN4U2NxMUFuaGZPb3Z2eTd1?=
 =?utf-8?B?YXd0dlpkK0xueWI5UXhqZW5JeG1PT2JJWnFRVHNrMEU1MGwxdzVxdjVDZEI2?=
 =?utf-8?B?RTR4dVRSdDQxRWx3YUdoeW1VbjVUWjM3QjBob1ZYbkRUOCtwbzhnVzFhTGlk?=
 =?utf-8?B?VFJPdCtGU3lycEVydm9xSjRld2ovUEFrNHdaMWFUOThZTjJGTDdDU243UUha?=
 =?utf-8?B?RkNoNllXTjJZS21tUEJpMTRDUXNVaDM1all3blg2VXZienBiTkNhU3hGT3hM?=
 =?utf-8?B?TVlkclNKSUV5UVc2YitBdEx3ay9oYkVxTjRSUlJpb2dVNGpCYnJ6WkdWV1JK?=
 =?utf-8?B?VmhrTzNCS29rSlFITmZhVkJPMHU1U2ltMTFxYjgrZk56c0dqK3gzdVNXUnVU?=
 =?utf-8?B?U0VCOWc1WTRyT3lwUEdCd210L3duU0d4d0Z2S3dZcjhFeCtmSDhlZjZ0NUor?=
 =?utf-8?B?bGZwejlKbkcwTnk1K0VZd3FrbkYvanMrSTlrYnQ1UzE3Y0lRa3FnWURmRUIw?=
 =?utf-8?B?TU1jMWl1T3g2VG1RQjlSNnJnRENlWEJOWmR3NEUwbC8vRWtmWklhcENGcnBV?=
 =?utf-8?B?OGxZay9uNUFVTittTkVqbHZoRjRDdElLSlg3LzBHWTNJVUVXbExWTUdKV0l4?=
 =?utf-8?B?MWl6czNHV3pRdTVLSUF6endUY2d6bXNDVWZpOUo0QXN6d2xHM3FtU1BDL3ZP?=
 =?utf-8?B?ZTdKWWdURXA0ZDI2cWYyNFFNdVpBcEVybm5NZFhkTEpaT0lpM21BeEcxM1Zn?=
 =?utf-8?Q?d4Nsy0yT+plXt0XkjPzJ8ogWzDTwAQOZjMYL0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3ZrVUJndlVvTE9QaVhmcjRqVmE0U3dWWmprRHVqdVc5Z042S0VTRERqSDIy?=
 =?utf-8?B?OGdTOGh1dlp4WmNzalhzb3dDbVJzVHpwOWxENG4xUUw0ZHpaMUJlZmtGdTBX?=
 =?utf-8?B?b0h2T2hrTW00ekI3d2dRNm1EcXJHVHRsS2UzWUpXc0RvZVdwekp6VWtISG5E?=
 =?utf-8?B?Tk9PM2hWK1NLOUJ0Y0NGNWlnOWFHNGdzVmFoTDE4MUtNN0czbGVzWE9rMVZH?=
 =?utf-8?B?bGd6SUpYMXEzbVZEWFgxOElRb3c3ZFZ0ZFdkOVRwREwrZ2NVWndiVlhaQk1z?=
 =?utf-8?B?SkxkdG9oRU9MaXZqNzBIcXpZWTBiT3dHOURac0cyNjZFMlNhWHRnT09EOUVw?=
 =?utf-8?B?NmFaZ1VMbWlBRnRRZTlsbm12dHkvSlBBK1I4OHVwRnBkQ3laWmRvaURZb3Nj?=
 =?utf-8?B?U0YzOE5ldGVKYnYwR1MxVGo5RXkyQVZzaURDaUlmRlBRd3NjOVdGZXc1UUpk?=
 =?utf-8?B?T3N5QlNEREdEOW9McWE0L3ZlQmRBeUJ3V1VuUWlUb2s0RThjY2dVTVBhbHN5?=
 =?utf-8?B?QjB5ZzlvYldlOHpNOFFXUzVWcWtSNTVjV1l6SGdPek00cTJMcFNja3A4Nys3?=
 =?utf-8?B?OXBOanczNzdheWgwN1V2SjJmOUMzNDNGTlA2VFNHdm5mVENITFJmVGM4d3h6?=
 =?utf-8?B?VXVlcTdUZzVKTG02QVhBQ0FqNjFKcUZQeVRxV2dDTjBnUUJpTjFZVEl1UWVZ?=
 =?utf-8?B?eEQxNmoxelo1dm04SC9JbEdROTBpVjZrbUg3dE1FcS9PdEZJRTIxY1VUUVV6?=
 =?utf-8?B?L3FlUUk0WWdvVnZuY2l3dm45VHFYbFhscmJpRERCYjlrWCt6YjZWVDVqTnlT?=
 =?utf-8?B?THR3aUFOamVUb1Z2aUZvSVNYNVcyeGtBRWtpejV1T3QwZDhUdDRJM2lwTFJ1?=
 =?utf-8?B?THYyVHJnYlhZUjhGUmJPQm1LSnY3OUxIV25uTEFKYWNQWFpua2hhdUt6Qm0z?=
 =?utf-8?B?czdrWXk2Vzl1eFVkc2x4S3AwTzlUYmEwQTJpOGJGTVZLWnpYakNldmRXZ3pn?=
 =?utf-8?B?ejVzZjRXTzN1cWlJcGV0SkdiUTFTakhzd3RXYStlOGR5L0pobHVUbjdTTlls?=
 =?utf-8?B?dUtSM3hXZFp0TnNiNXh1SDlRNUpaYkFjMDdIVkdGWmVBMW9XaUJIaVVGblJq?=
 =?utf-8?B?ZDM4UTIrWXRjRjZXWU5JK1FxMG10Zk9ScW1JbHBjS3E5cmNkVXZXaGRmTnRs?=
 =?utf-8?B?MVR1UDdSUDAzaGpMRFRxRlAyTFVJRDc2VkV4N014dkhkTml5Y3RZb1VpL2hX?=
 =?utf-8?B?OFY3NWExL1pGL3JxaE5aSTcrMmN4Q2lyR2pUdncwQjdQSEpSbVVpUDgxb2VE?=
 =?utf-8?B?K0Iyc1hOVituV2R3T1hEVndUWXQ5UzlJdndIQzFPL2NtazB1UUJ4ek5CcW1Y?=
 =?utf-8?B?S3RtanVWaHl3MXZJMlFWdWxtWEllUTJxYnJVOGpYZ3RhM1pYdmlDYmU5ajVP?=
 =?utf-8?B?MUNsaFpOUk53YjRyQTlMNVMzc0plZWh5eDFrYzU5TVRTNWp3RHo0OFRpUXNs?=
 =?utf-8?B?cHlyb2JUTXVid1JjY09rdnZNclVvbzhUZmtURWxQNXVZRUxjWWRCNzkwcEJW?=
 =?utf-8?B?NFBYQlJIVHVBbEt5YXhWSG42L2FNeEl3b1gxMW45cVRwQ2R4MU1kd2wvcFMx?=
 =?utf-8?B?UXhZOUhmRGhKMlM2QnBZbnFHeHBLbm1LSVROdkU3YlNrK2NiT3AyQU5XbGhC?=
 =?utf-8?B?ZDhOeWg3VGJIUmtQcUVvWS9NZXYySE9nYzZ5aGNzekdrL2xZU2xWNko3dHFs?=
 =?utf-8?B?QXdQaVFMcFZRTUcxNnh6UElDVlRmMFBqSGg4cE01Rzk2eEFsNFhHZDR6UkpF?=
 =?utf-8?B?N1VtS3h6M21ZaUdJMzVrVjgxWi9OckJySXlRZzJIL2NtMXFDMXVQaUM2bUJa?=
 =?utf-8?B?WWpSOXlEOGlSeGgxZnU4amcrY29jR0NrMTVlZnJEd002YUcyenJna2RVS2tH?=
 =?utf-8?B?M1JkMklsQSt1enpTOVdROWgxekRPTG5UTmpJOHUzV0xNc1lSZmlvbUYrYURP?=
 =?utf-8?B?b1M0N29NcGlBSEdlWUhvVHpTUXFtL0tmTXEva3hUc0ErVjhGdE1uZHJ4QWVa?=
 =?utf-8?B?R0pwUnZnN1NMb3phVk9zMnFFTzFyM204SkJmZDFJZnNpZ1MwWVVwWExVWkJQ?=
 =?utf-8?Q?egXun57ntmFNa4jylmyvcOLfW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ebe7f8-fe1a-4de5-f5e4-08dcb000a7d4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 19:00:04.2710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhJv+5WrNYHRgD1ovZqcIGRJdlwnOx5rSOqHjyPgpyD9RrydkTiM0fFj+OsFcnsuf31n3AG9prnwBtm3sjeShg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6939

Add msi-cell = <1> for GIC ITS. msi-parent have to be kept because it is
checked by U-Boot due to historical reasons to fix up msi-map.

Fix below CHECK_DTBS warning:
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: interrupt-controller@6000000: msi-controller@6020000: '#msi-cells' is a required property
        from schema $id: http://devicetree.org/schemas/interrupt-controller/arm,gic-v3.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  7 ++++---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  9 +++++----
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 11 ++++++-----
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 15 ++++++++-------
 4 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 701f0b2a3e579..5e77c438f8840 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -143,6 +143,7 @@ gic: interrupt-controller@6000000 {
 		its: msi-controller@6020000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
+			#msi-cells = <1>;
 			reg = <0x0 0x06020000 0 0x20000>;/* GIC Translater */
 		};
 	};
@@ -661,7 +662,7 @@ pcie1: pcie@3400000 {
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x80 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
@@ -700,7 +701,7 @@ pcie2: pcie@3500000 {
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x88 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
@@ -1079,7 +1080,7 @@ pcie@1f0000000 { /* Integrated Endpoint Root Complex */
 			reg = <0x01 0xf0000000 0x0 0x100000>;
 			#address-cells = <3>;
 			#size-cells = <2>;
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			device_type = "pci";
 			bus-range = <0x0 0x0>;
 			dma-coherent;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index c980f4c5dcfdc..3533779f737ab 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -126,6 +126,7 @@ gic: interrupt-controller@6000000 {
 		its: msi-controller@6020000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
+			#msi-cells = <1>;
 			reg = <0x0 0x6020000 0 0x20000>;
 		};
 	};
@@ -575,7 +576,7 @@ pcie1: pcie@3400000 {
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x20 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x20 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 0 109 IRQ_TYPE_LEVEL_HIGH>,
@@ -614,7 +615,7 @@ pcie2: pcie@3500000 {
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x28 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x28 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 0 114 IRQ_TYPE_LEVEL_HIGH>,
@@ -652,7 +653,7 @@ pcie3: pcie@3600000 {
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x30 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x30 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 0 119 IRQ_TYPE_LEVEL_HIGH>,
@@ -964,7 +965,7 @@ fsl_mc: fsl-mc@80c000000 {
 			compatible = "fsl,qoriq-mc";
 			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
 			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			iommu-map = <0 &smmu 0 0>;	/* This is fixed-up by u-boot */
 			dma-coherent;
 			#address-cells = <3>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 8691117ffcf76..3213a8fe0b3b4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -63,6 +63,7 @@ gic: interrupt-controller@6000000 {
 		its: msi-controller@6020000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
+			#msi-cells = <1>;
 			reg = <0x0 0x6020000 0 0x20000>;
 		};
 	};
@@ -758,7 +759,7 @@ fsl_mc: fsl-mc@80c000000 {
 			compatible = "fsl,qoriq-mc";
 			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
 			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			iommu-map = <0 &smmu 0 0>;	/* This is fixed-up by u-boot */
 			dma-coherent;
 			#address-cells = <3>;
@@ -1085,7 +1086,7 @@ pcie1: pcie@3400000 {
 			dma-coherent;
 			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 0 109 4>,
@@ -1107,7 +1108,7 @@ pcie2: pcie@3500000 {
 			dma-coherent;
 			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 0 114 4>,
@@ -1129,7 +1130,7 @@ pcie3: pcie@3600000 {
 			dma-coherent;
 			num-viewport = <256>;
 			bus-range = <0x0 0xff>;
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 0 119 4>,
@@ -1151,7 +1152,7 @@ pcie4: pcie@3700000 {
 			dma-coherent;
 			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 0 124 4>,
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 73ee45acfde13..8810f78c327c7 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -398,6 +398,7 @@ gic: interrupt-controller@6000000 {
 		its: msi-controller@6020000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
+			#msi-cells = <1>;
 			reg = <0x0 0x6020000 0 0x20000>;
 		};
 	};
@@ -1181,7 +1182,7 @@ pcie1: pcie@3400000 {
 			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
@@ -1209,7 +1210,7 @@ pcie2: pcie@3500000 {
 			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
@@ -1237,7 +1238,7 @@ pcie3: pcie@3600000 {
 			ppio-wins = <24>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x82000000 0x0 0x40000000 0x90 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
@@ -1265,7 +1266,7 @@ pcie4: pcie@3700000 {
 			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x82000000 0x0 0x40000000 0x98 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
@@ -1293,7 +1294,7 @@ pcie5: pcie@3800000 {
 			ppio-wins = <24>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x82000000 0x0 0x40000000 0xa0 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
@@ -1321,7 +1322,7 @@ pcie6: pcie@3900000 {
 			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x82000000 0x0 0x40000000 0xa8 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
@@ -1777,7 +1778,7 @@ fsl_mc: fsl-mc@80c000000 {
 			compatible = "fsl,qoriq-mc";
 			reg = <0x00000008 0x0c000000 0 0x40>,
 			      <0x00000000 0x08340000 0 0x40000>;
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			/* iommu-map property is fixed up by u-boot */
 			iommu-map = <0 &smmu 0 0>;
 			dma-coherent;

-- 
2.34.1


