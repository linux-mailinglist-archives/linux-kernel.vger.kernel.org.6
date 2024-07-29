Return-Path: <linux-kernel+bounces-265007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAB493EB20
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02891F21FFC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32B97C097;
	Mon, 29 Jul 2024 02:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rWl50BHY"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452A6770F1;
	Mon, 29 Jul 2024 02:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219724; cv=fail; b=C7qTMDRIsrke8WWnA4i/IwWfTooyFyuRMAFmzZ0xPMqcgAo6l+KsShgZkCe4KRDtiEVMPnqWVKntq9wA1o2wBaA/DeqddKohGEWL0AbMnSRkhfugNg6FUgAd5ZHkPaNMAzSin9ewsSmCU45vItAhLywiaCeG7RUAUFALKTAX7e0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219724; c=relaxed/simple;
	bh=ECAcC70VNkmHhGoOuWrQrqiUNXqEeLqwVMObpF/upJ8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eeoD5kqU8rhcpWFfVdA4E9JvNXoxvK9XJfcEsRPXk+059nnBVYxGnQyP0btp9a7Dw+dtkg8M0T6gnPZzNxALkh768pduUC5Q+ormS6Pjr89c+XE1BPc3nRPt4FEKju9uOg5B+IhorqKy2GAJxmDNGxkuOwIvSf1w3ZzAIGF+Mzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rWl50BHY; arc=fail smtp.client-ip=40.107.21.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHsO2OzhVcTMZCgbSka1ItDfVrYITXki0qdFZIZTCj8ZObgN0gdp0py9sHMT/ZfV5QiFva7xDEIf5Z7gkKfHWasWlQdnUhyy4e+XeBbRZby90Vt0Tmi13XoN7p3Hxfa9i+grbdJ4oecvT3zjcrLj9Tb5bScwYAjl8m2iaF3RaMAjEeAZCj6cU6FJkLoKDGs2b5lehzidN6pQhwYZDYK4P4VebAikaIYFPiRkubglH5wSlA80ay6LDzLkJKnBmWfzUMJ66yZIMUCT7ZmzHLC33KAF0TZellYZlKxF2tigg4ZL7+mskig5WO9o/+y1hG5hPo3LiJm3e/26pjbPRsz1mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZckXn/OMalNyPvz/0j6CIflrCeicJiMPhPygtPLPC4=;
 b=cGmO46IwmrsH9JRjt1w1dIHSoJGJv0wAsVeqzD7//o4CfxFUFCFcO47IYTTpqoyAqrKOpzrV2xx/OdwoM+q/MlziAo5OXdgK7yjyvLteYmdX/MOaUx4AeTYOFdY+81StgPar4xSFsOG8IvIUPtfIIGKaRZSIGYhlLh1PGvrVpKfKRMmt2ltWc8e+2eodkIMmCnrlAyutny6ZCmqvKA2HpunBnNNfLRNuuyjQr48WUEiXJozgFLZjD5pp7wM2xZea5Bw3EzLIWsUjGVkj+IckuS8CPZcovU0AG8FGWmn+l53tHi0P/XWaGDht0SKLBaeoVUUkovjCbQnHPgOaDatg+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZckXn/OMalNyPvz/0j6CIflrCeicJiMPhPygtPLPC4=;
 b=rWl50BHY+6r71TevAx5LRQRa37ZklND9CFVM3TDgLF9jfxTxtDPOhVszTl8PY5qFYKeIVMP77a3K0kKh0LvinQVf9v5g5VJ+RFWF+FIpsS5CIisNsWW570+R/SVlRbpcHkZB/jFIyn3yTMemIO6P9+uUbJB/PIVK0Nk4PDOW47+2ZdZekKwex1DXVsHSUgWOZsizn7LYSceRPtBTSUXmnGuUxvFFOpaZMMXQQ6lx6YTOEOAZqfK9vHSBxeYlQzT9CvQXf8jYkL5gI39bFkcTTa2e33DGr/tM8pBj7GOoPR1p9OS7E9OyEKXK0rmSGqizR2nYeSHgb6Oo3ZKecLWBCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBAPR04MB7368.eurprd04.prod.outlook.com (2603:10a6:10:1ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 02:21:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Mon, 29 Jul 2024
 02:21:59 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 29 Jul 2024 10:30:52 +0800
Subject: [PATCH v2 1/2] of: property: add of_property_for_each_u64
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-clk-u64-v2-1-ffa62ee437e6@nxp.com>
References: <20240729-clk-u64-v2-0-ffa62ee437e6@nxp.com>
In-Reply-To: <20240729-clk-u64-v2-0-ffa62ee437e6@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722220263; l=2731;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=8CQ/HRjnMclVYkf+T04PTSQpcqAJ1N+X/qi6aupHpMY=;
 b=ER6Oi5XWGKIOZIG6FLrcTDSS9XH+HxBXFXXv9M/Iv6UoWQt7arfyc+Nt2lywzQLAsG8o++gLm
 3BFzlhuzaJRC6OTqc+dJIqU1VcIKj/ggwDbuFDVinLEe0feHd8UrxwO
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:3:17::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBAPR04MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e40a8d-86a4-457c-98bc-08dcaf7539ae
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0VvME1ZdFg5YXNOT2gxbDF2ek5MWnVGcnV3UkwrM3BhTkF1UStUVTRhWkR6?=
 =?utf-8?B?emlRYU1LZ28yRjIralNuRXo4OEhRdjZUNWZaakNxSXRlanQ3cjJ1RVZGQi8v?=
 =?utf-8?B?TUUxRS9wZ2dSb2o1RCtWTkJXQ0lKOFQxdDZ6MHpDbDBtdTFTWDVyRVZ4VW5R?=
 =?utf-8?B?aHdBNGI5NVVuNzRDbnNsdXU4VDFXWjRCNmx0U1h0OWJwWDF5M1hra0RobHpv?=
 =?utf-8?B?RmUzZEJuUFlmL200T0plZCtWTExGK2VWUUJaRGcvbkxrb1NXSFVqQ2s4RE9k?=
 =?utf-8?B?dUx5NW5ZRHpudW5KWEVnbUYrRVNWdUdHbUZLcTFoTjR5UVN3bitWZ0RZUVRs?=
 =?utf-8?B?YXlpck9zWHE1bVhyd0ZWSnhqVjNGY2J3NjJmcTZSbThDNDZmeURLZjc3eWU5?=
 =?utf-8?B?SFBmQTdCU1JLRVhLMEVEbzIzaENZbkhkNnFRdEZOL1JJOXlNaGZubkhMNndp?=
 =?utf-8?B?VmRKRmlYOVc2ZDVmTjYxZVovWWluUUZHLzJsUnJXSmZqa3RiMVJLUDJvVUJt?=
 =?utf-8?B?dEhJZENBb1VjZDFoNGRqQ0txOEFYWVhIcDl3dS9vakIwOHI2TnU5elRFZ3dJ?=
 =?utf-8?B?azRCNzJmc3VMc2VFZi9OMmgvNFMrTUs4NnVQWlMyZEVudlVNS3RzQnEvTEk5?=
 =?utf-8?B?YkZteG9MTmVhOWI4N2JxSU1CUVZNMXZFV1JpMW45Y1ZuRXJyOGFhT3Z6L2xi?=
 =?utf-8?B?VmNUaXBmUVVnREg4eEplRGRLMkVaVVQ0OGo4dVd0d3hRUCsyaEt4WUZmMFlS?=
 =?utf-8?B?NmlqcVI2bVpyaVJPRSs5ODQxNUhjVDJrcGZWTThZeWlpZk5wQ0hzQS9LTVFV?=
 =?utf-8?B?VDcxU0s2N1BiZUVxS3FscWlXT292VDQwYi9rUXZLQlc2eE5SMkJFZENYS2p6?=
 =?utf-8?B?K0tRTTNvZDlXOHFrT2FCWXlBK0VIc0JEK01WNVdJOFN1bDNrVDE3Z0U1Nmxi?=
 =?utf-8?B?QVNHNWx3K1RtY29WTjRXWUR3WUp2Tnp0ZWZHMXhHMHp2THMwV2w5QnZHeEpN?=
 =?utf-8?B?a243d1FFc0E0Tzk0amVxWnhtUFVoU1A4THhVNlV2RTJ3T3A5N3NmWG95V3hz?=
 =?utf-8?B?Z1FkTGdBTWlXeHZseHNOZDQ1OVJ3QkdpWGV6S3Zhcy9zMXlJekQ3Ulp0bzRS?=
 =?utf-8?B?UTd4TEZhN2JwMzNTdzhQN29xVFZidTlkWVlQWEZIM0JMc1hCTDhlaE5FTHNz?=
 =?utf-8?B?OGx2NFRic3EzanVXUHZlNVd3anZKOTB5bzA5Q0tyb1FuZ2MzMGswVmpGOTV4?=
 =?utf-8?B?Tk9Yc1ZDaEwzbWxJbWtLWXlEVmpWWERPS2ZkTUtTbUhSRmpmdHY5SHlhZlJq?=
 =?utf-8?B?amtuZUdrYy9NdXNoQ2pBU0lDNjBjSHFTSjFDWVNMMWNtNnlRcXVQQVVzTlBa?=
 =?utf-8?B?Q1JwSG5CbTU0SStyK21uaEFsaXRYMXM3OWI4aEcraVBJTVNUUjRZaFkwbW5m?=
 =?utf-8?B?QXRsK2Q2ZUxPRm91Z2doanpUSG9uazEyUkhXejFXeHVyZlFmbzU5YktKOUJt?=
 =?utf-8?B?QkNZeE95L0s4dm03dXZ3NERIVm83d1Z5c0xwUGp3eUhCd2x1ZHVRNmZPaXZH?=
 =?utf-8?B?UUNOMTRjRFhkbnR0M05JTDkzTFpRbFJ3ZUttRHNXcHJaOEVOa1RBT29WdnBV?=
 =?utf-8?B?MnpJTFhwUHNIQU1abFhjUXljWkRuKzlxaG51eGZNMmozdjNuR2ZVUzZMenNG?=
 =?utf-8?B?RUxPYlBaczZXZU9ySjRXMVlwZlVZVlZPTGN3L3A2VWhMRC94ekp2ZU04VlFq?=
 =?utf-8?B?UFBvZE1TZ3NnK1VpKzVpNmFaclZrZnVheTFzdHUvY25QeUx1K0l0eittN2c5?=
 =?utf-8?B?MGViYjkxVkNyUmJGQ3A2d2wxNTMxem0xYU9EaXNjKytNcTZDdlhPWVNFRmQ5?=
 =?utf-8?B?SlVhOEdWam5YN3M0Wm9mcGdkV3ltemZIRU9BQW5DakhSZ1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vlp0VnI2TkVlUUg3MklyVlp0bzRDNlNIbkVzQUxyenVtbGJlM25sZWFKd0Ni?=
 =?utf-8?B?S21KcEFpd3B0KzFaTG1FSE1FM2ZmNjVSMlYyZS91a01lRjliSXBQMUtVak94?=
 =?utf-8?B?Yk81OC9Wc242SUR3YTlMb3FjRmNuOFk3OW5oYmFtS0lRcFBTL2VOczFyM2ZU?=
 =?utf-8?B?dW5NWC8wYllNWFV1aXhoaDhIYlNhaFljSFBKelVhOWlnVFVGS2NsSjlRakpr?=
 =?utf-8?B?cXBpdEFIcndjUENNMkQ2MUN1VS9yd3pGc2xnRkRyNVgzZXNKS21LQVR2M0Zr?=
 =?utf-8?B?NHBYNmpnb2lxTWgrL2cwVWRYaXNYNzNUa1ZucmRnZklLamhtOGZ4TjkyeGQw?=
 =?utf-8?B?b21Nekw2TjBTQkpuMXhkamVhUmRTemdoMGlGV1FibFlOVkFjUGZZNmkyR2V0?=
 =?utf-8?B?eXdlTHBsbmZ6M3dZcW9POTZ4bkgxcGpRNGFIN2RFUXpQSHN0bVBxYS9BZW5O?=
 =?utf-8?B?dTd6Zm9MTktLRVIzRVZYcFBySGxRcVpiT0Y4cStRZWFrcndQVUNiTkh4MlNN?=
 =?utf-8?B?SndRTDFtV2JjRkRKZFFxYThrMEdCK25RZ1Q4bHluYU9wRk4yTmpEN2lNRExh?=
 =?utf-8?B?b0FWeEpBOUFxR2VjQU1VSWdXMG1HcVNxcTNxajJJUjA4aW5wdjVkWDBiK09B?=
 =?utf-8?B?OE5wRlh5dnJGd1dTdXJnVGpNLzl4SFVtSlorNGcxUDhOdThRTVc4SzIyQ2NH?=
 =?utf-8?B?WXYxeVpJa0xUQks1S3lyVTFFVzN2QXRxVm5LNCt3SFUxT0tnMFBnWUdUUE9r?=
 =?utf-8?B?bUxtZWdwc3Rvd2MraW8vRG5FRHJxeGwzdjlzRGlJbmdsNFlCWFg3S1VRSito?=
 =?utf-8?B?SDZ0dGwwWUtrZHpwa2I5d0txNndQVlpBUWpTTTMwaXZZaHNmTy9mQjRrelg0?=
 =?utf-8?B?S3M0VDlvcjExcm5SNzV1WklIMjZlbG5PRUUyTDMrRk9jOTI2RTJ1R2dWN01Q?=
 =?utf-8?B?ZCtmQVBVTmUwQTBqam5ZbmV1QitOWFpORjU0Nm1OdUYxcXFreDNETWpIVEhl?=
 =?utf-8?B?Q3lDZ3pHTXlNQTZaUTUvOGMzaDFrUDZac0Y4VEpGS2VBeXpnaVIzUGFUK1VV?=
 =?utf-8?B?bVBWeGpXaG42WEFEOUM2djIzSVdyVHEwMHQ3d2pmNndhZE0zWXovQTIzZmcy?=
 =?utf-8?B?WnFzdExHdSsrdTFpVG4yTmlWVy82ejZJeFNOcmF1M1E0K3pBMjF6WWZ2RzJo?=
 =?utf-8?B?NWtuRFR5VTA2TjFDelRnb3lydGlRQ1NObHBEQVAxNm1aTE11eWRqMWVtMktu?=
 =?utf-8?B?dHlLTDVlMVA2TkU3aU5iRXRxcUNGOE9EeUJPYXJxaEp6alVyQUM1cjRFQU8w?=
 =?utf-8?B?aUtrNnY3ZnF3Y2Q3aGxhL0NzTHpVYkk5ZTZaZklOTGNRM0lVd3JBbGFPS2Jl?=
 =?utf-8?B?dTR1OEpiK3B3QUE2NUkxTFAyQ2V2ZFh5UVRyY243TDZNajAzYUY1cmVaa0l3?=
 =?utf-8?B?UWFvMkNzOFdmMmVyMkZmbEVHNjRwUTZOZTVCcDB2Y09QVlBhUUVraW9jZUNT?=
 =?utf-8?B?WE02Ry9aWGtubkd3ekNoazNYNmtzMGI0TFZXYVkvSENlV2NJT0ZLZkwzT3Vz?=
 =?utf-8?B?emNnRm9nVkhacHdlcDRYc1NLTDhXcldFbVRzR2pnWk9VUjlPbnlwM0hnaVNQ?=
 =?utf-8?B?WTFrTEpKMDNtNFhDa2drWHZoTmhtYkNXRHVpOVZIZHlUUE1DRjUwVGI1VUZB?=
 =?utf-8?B?STYyYmZVMnk0SjJwQUxjeEkrdXRVMG5LejRBUEgxKy9yVWFhVElwMXVVclpR?=
 =?utf-8?B?MWpOQnJUSUZ0Z2FBY2lTbjgyRnFiQ3UvaUVsMHV1blE0QTBoK3hPNmlQU05C?=
 =?utf-8?B?RkFzRjFscGFiY2dEbVExSURLWmVLRWk0ZDhsSEVOOTV1c2RRZ1Nvc1NvcGVy?=
 =?utf-8?B?aUx1aDVrcm9BYTFZUi9pbnRWMWhoaDdSN2ZWZ2t1VFdsRFZVZjJqSzdDYWZ5?=
 =?utf-8?B?enU2ZW5oL25QdDQ5dXoxM0ovZjBqVzVkaGNjM1REUXhlbnpVdEx0d2Q4NW5y?=
 =?utf-8?B?NDdlNkUrc1d1RHFaa0hob2xINjBNU2g2Z0ZHUWdOVXZLQXhYbkFzaGkxN1Vw?=
 =?utf-8?B?ZEFxaUthTXpwaUNjSG1pbkg5aDNmd09lVWJKVk8yRHlaRmdYZnoxVU0wbGJO?=
 =?utf-8?Q?20zB3MW0eTNOHclqzPHw3GoG4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e40a8d-86a4-457c-98bc-08dcaf7539ae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 02:21:59.4427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AA/RYE1wY95DCDX1Ue1XbsaK/m0GJz7dsto8ll9bRNsfbH7EaI6SXDcGr6OQZ3wT+N6GVNbFgXl3h/lf/QgQqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7368

From: Peng Fan <peng.fan@nxp.com>

Preparing for assigned-clock-rates-u64 support, add function
of_property_for_each_u64 to iterate each u64 value

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/of/property.c | 23 +++++++++++++++++++++++
 include/linux/of.h    | 23 +++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 164d77cb9445..f70fd8deb9cd 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -548,6 +548,29 @@ const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
 }
 EXPORT_SYMBOL_GPL(of_prop_next_u32);
 
+const __be64 *of_prop_next_u64(struct property *prop, const __be64 *cur,
+			       u64 *pu)
+{
+	const void *curv = cur;
+
+	if (!prop)
+		return NULL;
+
+	if (!cur) {
+		curv = prop->value;
+		goto out_val;
+	}
+
+	curv += sizeof(*cur);
+	if (curv >= prop->value + prop->length)
+		return NULL;
+
+out_val:
+	*pu = be64_to_cpup(curv);
+	return curv;
+}
+EXPORT_SYMBOL_GPL(of_prop_next_u64);
+
 const char *of_prop_next_string(struct property *prop, const char *cur)
 {
 	const void *curv = cur;
diff --git a/include/linux/of.h b/include/linux/of.h
index 85b60ac9eec5..de481a4bdad0 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -437,6 +437,16 @@ extern int of_detach_node(struct device_node *);
  */
 const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
 			       u32 *pu);
+
+/*
+ * u64 u;
+ *
+ * of_property_for_each_u64(np, "propname", u)
+ *         printk("U64 value: %llx\n", u);
+ */
+const __be64 *of_prop_next_u64(struct property *prop, const __be64 *cur,
+			       u64 *pu);
+
 /*
  * struct property *prop;
  * const char *s;
@@ -832,6 +842,12 @@ static inline const __be32 *of_prop_next_u32(struct property *prop,
 	return NULL;
 }
 
+static inline const __be64 *of_prop_next_u64(struct property *prop,
+		const __be64 *cur, u64 *pu)
+{
+	return NULL;
+}
+
 static inline const char *of_prop_next_string(struct property *prop,
 		const char *cur)
 {
@@ -1436,6 +1452,13 @@ static inline int of_property_read_s32(const struct device_node *np,
 	     _it.item;							\
 	     _it.item = of_prop_next_u32(_it.prop, _it.item, &u))
 
+#define of_property_for_each_u64(np, propname, u)			\
+	for (struct {struct property *prop; const __be64 *item; } _it =	\
+		{of_find_property(np, propname, NULL),			\
+		 of_prop_next_u64(_it.prop, NULL, &u)};			\
+		_it.item;						\
+		_it.item = of_prop_next_u64(_it.prop, _it.item, &u))
+
 #define of_property_for_each_string(np, propname, prop, s)	\
 	for (prop = of_find_property(np, propname, NULL),	\
 		s = of_prop_next_string(prop, NULL);		\

-- 
2.37.1


