Return-Path: <linux-kernel+bounces-312539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EFE9697E0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47465B23D91
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A91E1C7691;
	Tue,  3 Sep 2024 08:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="f4+0cmfn"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2136.outbound.protection.outlook.com [40.107.249.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2C51C766D;
	Tue,  3 Sep 2024 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353562; cv=fail; b=XbCxzD5vEsdOTHvYOvu52HiiyZyXwDaiyt2L+PFpkoMli9G9cRulotRq2fRBk3OsZ/ajEyNSDdVE+thTn6mz5csgoHNq/wZTQEZOyq6DoWd204sESpbVDt/Osav6ZZDfN2tWCLCTzH7FX8B552K+ND/SlBHEN8InWl+JvsXJ7jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353562; c=relaxed/simple;
	bh=i89FeADLX/w0OAYzMqkQWsIEJmYst4LgEPKD/ec/1Kg=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=IksmdflDcEptsWtBmXWBRhxon3kbWoyynKlf08Km+BsjnGdIAZLk+wyX4yrrxEfBz1zcQfmjZcjk2TM3wYog2T1QM8xdwVH9/3XhKwYT0NfhmS8B+RWVvEkmG73joQkUTpIXJ2D1K/4MsWxMERNJpaGqsTWUxN7JNwWxaXs2wvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=f4+0cmfn; arc=fail smtp.client-ip=40.107.249.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZWBzo4d+NhJfzlSsHm2ocAICHriJEisF+O4j3FhJL4GhZK2HVROd+4luSaVFCyGT8KHcdjPALYConwYva0F4q/TTXaHVXfBD1sm2UdMVCBcIALbaHLpf8iEC2AaEpqhYyrChzAvhIII5uojLTTNDBHaaN3e0xJL0UFn0o4RtG3qjANZfdyDatj1MgWkd7gobil3J0qGMVsdCTACR2YHFZ/e7g4lGEOGxiJRTL+Mcg7iADf4JmnUEUWmKa48VmeJkyD7krxYkeoYm2l86cjtju+h/e53LYPucs560vJEPaokOVL9+KRLFgp5vnDA/GwTDqIVCuj9R93Sl6jnVbR2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRWs4ht2ukU1OGMsZ+jOXbFDlQvHpjMtZGbBYPWOa7c=;
 b=KPLueF7ptfWKxJpp5wFABtlgtqCgQIu57rekkXj6fhPZlrl3XoUUAwMdM2S4wc3h/wQ06aH1SmvqrnB9/WvuN0GGi3bQ5o9yreOxBEsOhV7UKfVUW07NT1iNtasrf9kA8RvwN0ZGtHysvUt5mhwxIC+5oGXwbZYkS147KtNXzzMiAxrtmN4MLAWGsw5SsmDgJbwhY3XrkofnMAdvWxfvqbRB2aDG7e+OU1mojuZVEzjKxC4iboxUKBoyTq9x7wOV3rGiabVXd7xaH2cSfMYchzAx1yG4R7AGWMTLSmzk3pnKGAR2++1xDYcofOjhvfuPBg3mLcgBUkKFWbjxQdz6Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRWs4ht2ukU1OGMsZ+jOXbFDlQvHpjMtZGbBYPWOa7c=;
 b=f4+0cmfnMJYsXyV6OLD19D49C+zV6ItTyvvz9NsvfwytJZAr6ZrJKz0gMvXO/asKOy0P/HfTLvH+1hGgUrt8E4gUeG3ilsNR2eU4Znv8CbpCLCc0GaJvV3IVKe0xbwsWuuYcUL5KKDMDgOVUbKx14gVYoTQVWCDnJgRN6b15aAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PAXPR04MB8607.eurprd04.prod.outlook.com (2603:10a6:102:21a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 08:52:37 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 08:52:37 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 03 Sep 2024 11:52:10 +0300
Subject: [PATCH v2] arm64: dts: ti: k3-am642-sr-som: mux ethernet phy reset
 signals input
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-am64-phy-lockup-v2-1-8cf6bd138ebd@solid-run.com>
X-B4-Tracking: v=1; b=H4sIADnO1mYC/3WNQQ6CMBBFr0Jm7Zi2VkFX3sOwaNqpTARKWmkkh
 Ltb2bt8L/nvr5AoMiW4VStEypw4jAXUoQLbmfFJyK4wKKG0qIVGM1w0Tt2CfbCveUIpajJn741
 SDZTVFMnzZy8+2sIdp3eIy36Q5c/+b2WJErU5NY6c1v7q7in07DDO49GGAdpt277gOrdosgAAA
 A==
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: TL0P290CA0014.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::8)
 To AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|PAXPR04MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: ab312fb1-e8a9-4ad6-a250-08dccbf5c26e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjFvNm4rL3g1MTVCZ202T1VlZ3Q5Z1FZNFV0ZmhvYTE5V3dWVk1LMXRYN3Nk?=
 =?utf-8?B?S0RnS2Q1UWdFN2VVSHRNYk1EMVErOStWYXpxRzVTQzdYQUMwWWNOV3Z4R2tO?=
 =?utf-8?B?c3ZYRmg2MC9lSkhxS2NVWm51VVJqeHdqUXloYlFWbzNWYm90ckNBQkZWUjUw?=
 =?utf-8?B?dHpZMHpxN0QvODFPYUlVdXRGRDJ1ZXBOKzloQ3dNNkhTTzhobnNHNGdkSTVr?=
 =?utf-8?B?dDYwUEtoWndZSTFzUzRUTlVSMUloeFNRV2YzWkpFdnEyZU8zWXlBd3Q0SVlz?=
 =?utf-8?B?bVdDeEx0VTcyWkQrOVBtVmtGZmxkMWtYZ1pBWE14dW1ZQnp5eElWMkZreFVX?=
 =?utf-8?B?Q2d6N2RyYjNGV0VUQmNkMjd5RXZncmpIZ2RrbUZVWFMveXNicTUyTTg2VWoy?=
 =?utf-8?B?Ym5FdzYwakkxOHVpWjN1R291TklyRVlkRnVCTzVobS9DTjcwWnhjRDZFdkQw?=
 =?utf-8?B?OUU4dHFuZXVTR2xXeDd0N2xpTkdtMGtzdzVZQStFUzNFeVhwQVRoYlRTdW1J?=
 =?utf-8?B?L1pjdTRsRkExQXI1STBPdWp4Y21HY0NLeDRRTk5nNExQZitpRHJkRlJwK1Nz?=
 =?utf-8?B?dFpDYzZ1eFN1emN6aUhhcU4rRkhDNHZ4N1NIckNWRktYZk54SWZFazIrM21l?=
 =?utf-8?B?WksvbFB2VnlJcHpPVDNPa2RGclNWZllqdGR1TG9BNEZVRlY5SDl3dUpoNHVG?=
 =?utf-8?B?MVJ2RkhsVytjZkdleW51MVJ3aURRakUwRHp1UWhNa2kyaEpWNWZmazJ1aW52?=
 =?utf-8?B?b2VDMkZhRzU5NmlITFdhUHdyc21oT0IrTzVvdmVnbUw1THB4TlRGdGM0K21y?=
 =?utf-8?B?V0xCMm5WL1NPRTdMQndtdzlCZUJyaUhlaVNremRTVUNsYytNZ0xYa044dUZ2?=
 =?utf-8?B?KzFvd0p5RkJuaVJaYnZaNm5BbUtZSGROTDA2UDN2NUVvMlQrT3R1bjBXTzhm?=
 =?utf-8?B?R0VlYVhCcDJlRzV0TFhuV3RTREw3UndlbHVzZWRXNUNPb01jU2h2QThPdEJS?=
 =?utf-8?B?ZXN6aFZ0ZGhXNjdIaUVXMytKenRaQlIxM0taMlUxbm0zVlNPMFF3bzl5aU9q?=
 =?utf-8?B?SU1LcjNkc3U3VW82allaK0dCYXBNeDBsY2s3Y3cwUnBLSExzbGFzMnRkRUov?=
 =?utf-8?B?WXJCMk5ETC85TWNMOTNqWWJSNWUvZ01ZUUJ3WCtwa0JLZk03bnBXS0FQUGlE?=
 =?utf-8?B?eWMwZHRnNm9VVytIWDFqZ1BLNURSYUtCeVd0enJzajdvR0g1NE9HWkM2Ylpj?=
 =?utf-8?B?VFc2SFpSdklNUzdWL3dzWjNFWkI5aTNHR0ZJTXZaV2hkRE84bno4dGFVRk5y?=
 =?utf-8?B?VlF4NlRncjdXaHFnSEo4V2NZQ0tZYTI4dWJ2UjlQV2JBRGNRWXEzNE1EREtZ?=
 =?utf-8?B?TGgxdVpjczd0SzFkV1VKdUhKL2lNVi9La1RQR21pMlpIMEowUkptM0VxL1JZ?=
 =?utf-8?B?NWdGRG5GenJVbDZSVjlyZnJYUURyYzBvQmZNVm15VUU3cGZWU3Y5TElEcVF3?=
 =?utf-8?B?SmJpSmxkR3E1dkh3OVJ5VmFOZ1B2Y1I4NmlVbzRrajRlSW1yeWpXQWljeDFH?=
 =?utf-8?B?ajJqZ3A3cGdPOXdDT3VMeEVtTVRqZmx4L3A3blVGYVNLNmZ6M1k4NnJDSjFB?=
 =?utf-8?B?bXpvUmcxK0RqZm9tZG4zRlRPTVErSEVvWUhKS05PS0pkNDF5ejBJR1I3SHZY?=
 =?utf-8?B?TXg3UzY3SzZoaFlZT2pacEN6QjNRdy8rTEJhSGZUbGl5UlpFS0N0NVR2MnpK?=
 =?utf-8?B?OEFYSHlBT2RzL0ZPVTRwU2FLMXd4QUczN2dTRmxqYmlSbjRZTnpMdXB6dlMv?=
 =?utf-8?B?QjVhZ1F4dVpuYWlQZVRXdlNRdERiNHJEdWtjT3FxOTNDWjNRMzB1M2hmWnov?=
 =?utf-8?B?L0pWOERxNFZ1S1JPRDF0dkFROXg5QW41d3pQSjQ3T3Q4T3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGdKcGk0NExtTmhYNzExM2M5RFNwbXJEbG5wbldCZHNqbWVFZG94SzhJVGpx?=
 =?utf-8?B?ZUZnU2tLaHl2QUZud21xQTJOSFZFS0lSNFMvVmh2RDlTamhjNEE5QmF1SEUx?=
 =?utf-8?B?RExXR0k0cGpIVWFXZDNtWlBFMWQ5UW1mSkxpaFAzakdWZ2RXTm1oSFUzVzNv?=
 =?utf-8?B?Y2gwUXVRNFdsNUQ0V2MyZUYwNFRkMXlFSzAwNDg1ZmZJdzBYcU1abUZFL0hW?=
 =?utf-8?B?OERnNXcvb0hEcHlyY1BHSXlyeVRFZHVqeS9HQUxRYlZVMGV0dnNRZDVnU0pa?=
 =?utf-8?B?WEJkQXUwVEd3MkJRc0lUVEFaY2VsQ0pmRVowRzhaNXppdmhYL3ZlOWQzNEpx?=
 =?utf-8?B?MEJLNVpBdG1HdVBHM1ZuWUlzN1ZZVHBsdGpFS3BPL1lOZGpxRmIyTWxPR1ov?=
 =?utf-8?B?WllBRU9VdktoWGpOYmlmSkhEbGNBZGpUTkU5cWR1NG4rTzNuU1MrL2pHeTNO?=
 =?utf-8?B?UlNtZHpudFp3Z1hIN3ZWSjEzWTFLLzBBSVZpOUtqbmxIMTdLTDZYbm1EMVdD?=
 =?utf-8?B?Qk5DNmJLaDRMMFF0eVJsMTFqakF0dWVvOTFGU2l6MnJSTUNVL0syR3ZLV2ZJ?=
 =?utf-8?B?QlYwWkxPNjZIbFZYaXgwamg3T1g0bTJEYXM3UnBUZTUvd29KQXNuVnJONTFE?=
 =?utf-8?B?dlI5KzVxNm12UkZCQTl2dG5VQk56b2xOeDh2Y2xmVkNNSUx6N0xNczhma3Q3?=
 =?utf-8?B?TzlqVTRtdUlPZUZMUGNkcmt5aXoxaUU4bXRSRm9VTmwvY3pmbFZvcGVoVVFj?=
 =?utf-8?B?UCt0QURCajZBTkhlamhrVlFGL1NHTnMxa0pLYUJkME9tc1lkVDZJOUczaUR3?=
 =?utf-8?B?Y1JYbVpMdW5QYTllMjBzeGgrZUhxQkZOdWdxSW42eFFnb1RJKzE1UERBTGVT?=
 =?utf-8?B?U05JVWxmMUJMSHJYQkFHemt5NUtkY1NLVHFhZjJ4cXRmcUtWRkl5UEMzampk?=
 =?utf-8?B?c1NYVnNYYjVNWnhZcWdoeTZmRU12OWpkeWYxL3Ewa1lpaTZNSFQ3eHpNNFgw?=
 =?utf-8?B?SWltTk1zcWs2c1FzR2drdUtCQmUzQitGbjQ4YUEvZ2N4bURmakZVM2w0cmdT?=
 =?utf-8?B?NXpXUHBBMUxtbU1jbk8xS3BsTzNRNDc2QjdoOWZFdFZ3Qk4xTFRVVE41SG1t?=
 =?utf-8?B?bE9GU0xsZGh2OERNVGFKUENhSE1sVUFLaU9YbmZsYi9oK2cySWhWMUxLazN2?=
 =?utf-8?B?b056cW4rOGduQVFWazNjNlZWQ0Ryb3lLbjFTbHMxYURONmRlci9GYnpRdGs3?=
 =?utf-8?B?bldPbHdQalAyWFRmbTFudlhKTHJ6OUJhUCt4aE9oNnlMelNqUE5sckxwMnRB?=
 =?utf-8?B?bGRYbXFQczIxc2l5THBuaXV5ZEVBUmtpOXI0TjRnZ1VEWmVIdjV6SWx3ZGFH?=
 =?utf-8?B?aVhMb0RIYlhQNW5KelFKTkpEVFNkWEI5VWlOS0JNZnJzdDVZLzExeVFWdUVp?=
 =?utf-8?B?bmxOa2YzNEUwdU02K0lTcVZOeDdTN0wzeFRxRGdobzhpemIrM0tPZ2psRU1J?=
 =?utf-8?B?VXJaR3p4RGtnYVlrR21XOU5oMmFqWklybWsvZ2tHZFU3MXNTTUlEcmtJZUR2?=
 =?utf-8?B?VksxMyt3U01TMmtaSHVuaDdmaWh3eVk0UjdleTlRRkdJQ203THRPQ1c5cTcw?=
 =?utf-8?B?Q2ZNdkxMYURyU1k0cDBndjF1OEgvYk1ITEFseTBpeGdYUDZRQWNscXpsZUJF?=
 =?utf-8?B?Qk8zREtTRkpPZ1ZyOXFORnJCNWphQWhmTmdFbjVoNjNSeWl1ekoxK29TRGcw?=
 =?utf-8?B?UXZuZ0dUeHlQdjhlRHJlTk5TV0dQRms3amZENWp2eERnYWYxTTQvTXhnbGhY?=
 =?utf-8?B?YXRmRlluQ3VJekUxV3l6dXhJaElXTC9mVm5FTGhxbmdTbEdzNlBIdm1FaHRY?=
 =?utf-8?B?QjlIVmU4Q2h5VGQ1M1VkTkR4WDloUHlsdnlSVHl5clhLc2hMQXpXK2dwZWZS?=
 =?utf-8?B?VE1UUitFV0t2VmxzN3hXVHRIS3R3QjVlQTNGMndjMnJDb0dtUDBsdUpyVVhO?=
 =?utf-8?B?WXoyTUJSblVjTmpCV2pBWW1rd2IrcHZqRGFqUWFuZUVZblY4WTF1cGl4VThj?=
 =?utf-8?B?YTB6cEhOOUt3UEZvZ08zVWpMZUsvQzhsblduN0wwYTE2ejFFVXFVNUF6aWFO?=
 =?utf-8?Q?o+fKJa6T0eCZFmSuL4Yk+rcdv?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab312fb1-e8a9-4ad6-a250-08dccbf5c26e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 08:52:37.0021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRpBhn+qi/v9DNflrUVaDAOkaWbYd6ICkn6Co2Bo8MCph0VMTHiLGX3JWZ6fc3EbLvd5TtN8S0q9Myy220sQ6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8607

Specifically on AM64 SoM design, the DP83869 phys have a chance to lock
up if reset gpio changes state. Update the pinmux to input-only,
strongly enforcing that these signals are left floating at all times.

This avoids sporadic phy initialisation errors mostly encountered during
power-on and reset. In this state the phys respond to all mdio messages
with a constant response, recovering only after power-cycle.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v2:
- update commit message with additional details
- rebased on v6.11-rc1
- Link to v1: https://lore.kernel.org/r/20240704-am64-phy-lockup-v1-1-4a38ded44f9d@solid-run.com
---
 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
index c19d0b8bbf0f..b1f06071df4c 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
@@ -320,7 +320,7 @@ AM64X_IOPAD(0x0278, PIN_INPUT, 7) /* EXTINTn.GPIO1_70 */
 	ethernet_phy0_default_pins: ethernet-phy0-default-pins {
 		pinctrl-single,pins = <
 			/* reset */
-			AM64X_IOPAD(0x0154, PIN_OUTPUT, 7) /* PRG1_PRU1_GPO19.GPIO0_84 */
+			AM64X_IOPAD(0x0154, PIN_INPUT, 7) /* PRG1_PRU1_GPO19.GPIO0_84 */
 			/* reference clock */
 			AM64X_IOPAD(0x0274, PIN_OUTPUT, 5) /* EXT_REFCLK1.CLKOUT0 */
 		>;
@@ -329,7 +329,7 @@ AM64X_IOPAD(0x0274, PIN_OUTPUT, 5) /* EXT_REFCLK1.CLKOUT0 */
 	ethernet_phy1_default_pins: ethernet-phy1-default-pins {
 		pinctrl-single,pins = <
 			/* reset */
-			AM64X_IOPAD(0x0150, PIN_OUTPUT, 7) /* PRG1_PRU1_GPO18.GPIO0_20 */
+			AM64X_IOPAD(0x0150, PIN_INPUT, 7) /* PRG1_PRU1_GPO18.GPIO0_20 */
 			/* led0, external pull-down on SoM */
 			AM64X_IOPAD(0x0128, PIN_INPUT, 7) /* PRG1_PRU1_GPO8.GPIO0_73 */
 			/* led1/rxer */
@@ -340,7 +340,7 @@ AM64X_IOPAD(0x011c, PIN_INPUT, 7) /* PRG1_PRU1_GPO5.GPIO0_70 */
 	ethernet_phy2_default_pins: ethernet-phy2-default-pins {
 		pinctrl-single,pins = <
 			/* reset */
-			AM64X_IOPAD(0x00d4, PIN_OUTPUT, 7) /* PRG1_PRU0_GPO7.GPIO0_52 */
+			AM64X_IOPAD(0x00d4, PIN_INPUT, 7) /* PRG1_PRU0_GPO7.GPIO0_52 */
 			/* led0, external pull-down on SoM */
 			AM64X_IOPAD(0x00d8, PIN_INPUT, 7) /* PRG1_PRU0_GPO8.GPIO0_53 */
 			/* led1/rxer */

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240704-am64-phy-lockup-107ea5ffa228

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


