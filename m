Return-Path: <linux-kernel+bounces-510665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF95A32028
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56A177A3D14
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA10A2046A7;
	Wed, 12 Feb 2025 07:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZRlapBVZ"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC922046A5;
	Wed, 12 Feb 2025 07:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346113; cv=fail; b=pgc3p+JSk3by9cuuAQhxsqURlT/GYkabrIiK+Pt+ujdK9UguSd6mNC66xUJnXoV5od2WmBjgfyUHFvOFeyMOzxzjNKBTZHVwJVUeROje/s+z9AKEC049WPDaWFiojfflxXdXy6p39r4pTQpNfUJC/RJgwSJEAYw6naqHtlvGD5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346113; c=relaxed/simple;
	bh=bmyicavOlDbNG4Xj3Qaq6cb2ZU7PdILiOoFVniwg9CI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=a5zClgQDfGVpzoPipDq/BhhKEcMq5kiTkRQtYSvs1i474xQdyI97+Lo5b0ry3l+mh0Tkf7UQdmyrLmo7VLRn84Y9wXXU3i5CSJWIg5zXVs73V5sX7qFknEG4ofXSya4LAKwkhZaGb7FAsDGncEgFW+2mHKUDN9r5WmZBIskCZwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZRlapBVZ; arc=fail smtp.client-ip=40.107.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eucVAusdF2VFaY2yi8IQxIMLs3VZs1WAYEx1XfJoFLovFQLq6q87AQ9UdyxsyJbm/l0jiheW3F7PCL/LObvvXTeKZlNdm/AVyWcBwOIgfrUn9grlAN7j/YIqfvyY/x+J4+xvqQ3iTU2NFjvxHbn5qf/RD4zsOVcFXs4TMSfZu2OUcNds3or61lWTeIhWZXnwufPuwM+Ymr8OtDxNTQy0w7CXrd+BSJlWyMiuu+hRbbgOme9rI1mDw0jc2BukLR6xVfXaUmewG0zPsqTplbOO7N5b90HP30j6txxPV1qN9Km/98IkI/cGcdHd1jiiaIS/zGU3pyrmTl2SjMb4gNpB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSP0XDMY0TfQbgL6hb2bpJpAy/LolSImVLH+edvMo1I=;
 b=REwMxwTaFtzhZBv5YaqsD0zw1x5Taj/I+vQuBqGtP7IIcJYkb77mnfgdLFIXQGFwK2KSMT2d3CnQH2x6gDx5/bQWbyFgrucoSVioKH+Ed/gspkQyFi3Fdkl1RaFbIeBPxRxPRHpVAeWcRtKvG1xOp7m27VYlNy+funyzem9+FJwDzLpyQLbZUJ6eBfAcB1ahA8wPt5v8oGXgRmMcTcYb1PpILvUb2X1ejRfuMfdHLOAplhdsOCqvYKB8awxu5d0dKTry/XeTnTqyoGVUcTFTMZjsTnSTDXUuTwUUPkMQd6GZGJM8LOMNdCy6J+9FnnqndrJELrGEf5nwx3pa9Ay+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSP0XDMY0TfQbgL6hb2bpJpAy/LolSImVLH+edvMo1I=;
 b=ZRlapBVZxgJOFje87si9UmdNw/sN7Br3qGHMujqE9dnt2KNldmFfd3F0VGjAAZFP/7YfMvrq23ljA9WK2PoI+uUAEnwlTQNUe5xmZ/yerY2Yx2VVyshe7LWtFvjcbGugWzkVR5I2EEEa0gJRK0uZ0fSwB0bb//I9ujhVz6tRiOOumbfUb/qd5enQv0jreoMgUi+ZYJSdX1AOuqIvQBe8cYpORfa4MnjmfxQ2uYSaAMeI3qiD5E2H3p09xxbTVatC78QyE7xXljfaPPVw4urQaD/1zE34LcST/Xy+VHcsko4gknypf1efxYLnNyplZ72NaHEgS09XEivez4UY/ySYEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10865.eurprd04.prod.outlook.com (2603:10a6:102:48a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 07:41:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 07:41:48 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 12 Feb 2025 15:40:28 +0800
Subject: [PATCH v2 6/7] firmware: imx: Add i.MX95 SCMI CPU driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-imx-lmm-cpu-v2-6-3aee005968c1@nxp.com>
References: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
In-Reply-To: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739346036; l=5658;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=jnqCj8AkedEQ9gtARM7DQLSPNZL2HiFxGo0lP+P4RLA=;
 b=OV37mNXSGzRyca89q7GCG6r73vcCc2n7Vvf4yzwO1O1B5Op7ve7bo1xy4W7Y1Z6ya9dhkMN51
 zefTWTPNZfuDT2k+UnBMyjPca7eaEop8wAYNN+hj6bWzgoBGecZrKvg
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10865:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b9203b3-53f7-465f-4401-08dd4b38b524
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlRKREQwZG43N3U5UDcxd3BxdEc5eWdJYU5rbEE1bFh5djA5RzNKb3A5SW82?=
 =?utf-8?B?YWRMTHVaUnMwN0hVYmNTMWxGaXNwWXJyQWdxRTVIa2IrUmpkVjVmOE1ZL3ow?=
 =?utf-8?B?ZG5CSWYzWVlGQ0VyNE5OYUMxVS9KMVlvc3A1aStjUk1reE1hWFhCeUg0dFV5?=
 =?utf-8?B?eEtCQ0ZaNmJ4RDRmdk1pZHBla2IyZ1FkRU83WVlpZDRHN1I3L2VWcE1wZnB1?=
 =?utf-8?B?VE1OODdUMnlVa1ZrRm53MHZzVFh0OEFXaWlJaktyejhFZzBIRVYrMUs0NkR4?=
 =?utf-8?B?RnFiRWpoWXpKMG9ia0V4UDE0aS85alpSSGtPcXpKaHBjUEN4ZTlhWFB0ejlm?=
 =?utf-8?B?YTF5OVdoWktCUEIvZ3gyRkVGRDNudTlKOURQMDQxUmhyMkREVTZPdVdYMDk2?=
 =?utf-8?B?TzlqNy84NHhQcmhOOHViNHJkU1p4L0QwelhBcnhoWWJjeVRYT0YyNVFOcTd2?=
 =?utf-8?B?RnNhUXdrRGhNbGRjbzZyZlJsVU5HanZBUVZBM282SXNoMXJBWUwrdVdLMlpw?=
 =?utf-8?B?dDJZNGtjdDlKdG44dm96N3hwQjZId3BxVUVoZjdETFEwc0wvbVRjMTM3ektu?=
 =?utf-8?B?OVdpODVYZ0hLTmI4QVh4QVhrV05OYkVDQU5iR01Tb3dGT1Q5RTFrb0ltRnJv?=
 =?utf-8?B?MkxIbzVlRmlkMWhacG5LdXNDSjNkUGJ1RFZXcm02L3NxZEtlSmI2b0E3dEdL?=
 =?utf-8?B?aldGMng2bVpVR0tnSkJrK2VDV0gxc2VlTVZmeHJpZ0QvOXlFUG5OTFZ1M3A1?=
 =?utf-8?B?WXBZRER2M2FZaERoZjExOXE0M0RtVGxrcjNUd1kzYjZlazI3ZXZaeEhySnFK?=
 =?utf-8?B?cGlJdmwyQ1ZGdU8vVndxWTZqd21tYnRyb3AwVlFDNWFzSFVNQkJJczZPS3Jn?=
 =?utf-8?B?T1gvWTkyYnBSZ1N5NHdzRDdkdFZhQVJWNXpKendNWE9IQW9POFVCdmpUdHRI?=
 =?utf-8?B?Sk9zOVcxR0EwYkdXNkNQUGRUdU1xZW1jOGZObTluWHpIdmRXV2E5QUIxVTFX?=
 =?utf-8?B?TnBOZ2R3bVg0V3hIaWsyUTVyeTRGbFlCUlNkVXo3aWt1K0lTWDY5ZThaalA1?=
 =?utf-8?B?V3ZFeUExUC8ydGZ4L3JLREVNYWdXMUVPQlFSSnc0WkY3QVBEalRsYVNkRXUr?=
 =?utf-8?B?d3NnOVJYTUJGanJhdE1KN1RFTW81dzYzMUlUR21oOXRuaGhiN2FKNjBqQ1p0?=
 =?utf-8?B?Z0xGQWNuNGRKc2hRUXlFYlA5VWNMVnc5VUxoR2pCMXdORU91bEhPdG9YUUFk?=
 =?utf-8?B?ZkZFclF2V0grT3JGSFVsMktEcEQ1dll6U256eDFTdkNGcDZDUURiZVhmWHIr?=
 =?utf-8?B?Y3c0QmRJSmxMbFVSNVh4RzRZdUtQZnY0VTlQVVpWM3B2dGM1UTZOOXM4M0Mv?=
 =?utf-8?B?WnZTU3lQaW9rOENtbU12bnpjaUZLb0l1dHpwUXJIallNTG5WRFF4SytBS2N2?=
 =?utf-8?B?d0VHaFVFZU9FRjl2NUpUK21acU41T3NuL2tnRU9TTElCMnFIQ2NSVGVEa0s1?=
 =?utf-8?B?cjVEUTBROEpwMDR0MWlEN2tEaEtqVHRDWGZLUVBvSXM0VTRUVnNWNlh3Tis2?=
 =?utf-8?B?N09SbGJhZ2tXQnlQYiswa0o0bmdvbmF5SzhaWE5xRVloZUU3SUJIOTQrMW9r?=
 =?utf-8?B?Tm9QR2kwZFlycW1ybWRob3grcDdjZGd0cTErcGxMbkR3QU1TYXhpeTJ3Nklo?=
 =?utf-8?B?SmNsbWJZRDNId3BidHNxb2x4allOTEVndFlmR1RmeGx1dSt5UEErN0hielg4?=
 =?utf-8?B?SXBma0dkblBMbHMvNHBBb1ozTjd6akowaWpKekpHRFJYNXIxYWlhcXB6Z1M4?=
 =?utf-8?B?N2FTV1o3MVdIbnhSSFpkeHVBdzlUSE9DN3phdnJGcHRlbjg5R1o3bnJlSHo1?=
 =?utf-8?B?cDVpV2dic0Z1WmdGanBtVEhhdnMrZ0dzQUYyWGw1QnZ5QTIyWllnUXZ0VTA0?=
 =?utf-8?Q?ZVOboMeYFqbS7pNNUVbK3EOhRIcUx/4Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEtzbEJQY3hQaDhXc1F5M2RUdjUxTkR1c3ZKNEhqL3YxMERYTTBRSXZNZHFT?=
 =?utf-8?B?cDRvbjlkcUoybldSZWt0NEY3VTZLNHNaTEh3RnFvSmJZWjlCd3l5RkxCem9N?=
 =?utf-8?B?MkZaWEcyYnlKeHFpbkpBNGx5bm54ZGJzWlFCM0NiWEhRajEvclRBTlBkRzUx?=
 =?utf-8?B?dmJPdS93UDhRNUQxaHVLOWpMNytKd2NQU3AxYXJWNHo0N0dGbS8vUUo3aU1U?=
 =?utf-8?B?N01oQkZKOTBwc2JIMHVMRjNOWTdsZGk4Y0FkbTJHTXI1S0FTUVZ2bTdRcmNB?=
 =?utf-8?B?TjEwVkVwZGVibVZYSjQ1aXA4bHZIQ1dtNmtaTEtXY2F0L29sSUhIZUIvS1Y0?=
 =?utf-8?B?SHlZZDJWTFR6aEU0UTNENVI4eHdDRWtFU0E0aDF5NlI4Qzc2WVg5VmJPdTk3?=
 =?utf-8?B?N2liRzJ2czR1ZWVHVnpQU1ZtaVZ2bXBhck9YT0w1V3ZyNkh6bGl5YjVJOUNz?=
 =?utf-8?B?elNtVCtOMjlCMnZSRkdrRmU0MUFnTVRCYXZUYlptdzVEYnZQWlFaMTBRZFpl?=
 =?utf-8?B?Y0R3aVlUcWFZcG5PTmRSVTNZYmtaUm45U1VuWitSWFJ5b1VvbkhxTTY0K1k3?=
 =?utf-8?B?aTZqcmVUT1NqM0ZFa0lMQkVWK2h0L1B5NnVRdlBBK0VTSlY1QlRub2RoWlVo?=
 =?utf-8?B?UkdNczdxWHY2cG9vY1JXQUZRQmlNVmZhb25RWC9ObXM0clc1ak5paWdNNUFV?=
 =?utf-8?B?NHBoSlJ4TkRXbmg5ODlyQTBpWGo3TVRNY3hHUDFPcnNqL3FQRVIwNWlFSlZJ?=
 =?utf-8?B?Z0UzeW5IRmd5TmRRaHNPaW1KbkFXNk9jY3ZYNGZlR2lsZ3d6Rk1xMGc4eEtn?=
 =?utf-8?B?NCtvVzB3VFpyYm5rMVdtZm5oaGhuRDNESXp0YmtrcnNoTEhCQlpxa3dtSTBa?=
 =?utf-8?B?dmhQenVEMGZsNDlEblFrbmxzakxyT1d0Y1FwTTk4Y0h3aGEzNnhhbmNjbEZV?=
 =?utf-8?B?T1lRcDV3RXplcXdFd25LM1grRHNzdFRORkl1Y0wzWkpCQkxpVUVJSU1ETWdR?=
 =?utf-8?B?cC9TZzFuREU0eDg0VXYxdUxEN2hsMDlOYzlsZnorTkNBTG5JTmVZSXhHaFNW?=
 =?utf-8?B?S3hUTS9rVExCeXFSUTN2NC9vaVgwdldaRVVubmEyQXNwMzYyUXJCdkx6Z2Jz?=
 =?utf-8?B?N3plcFIySy9uVjk1WHZETmt6K1RWNkUza1dKTzRadlBzUW9zRGdTMU1VK0FK?=
 =?utf-8?B?Qzc4ZTV3QWg1ZVY2Qi9oZUg5amE5aHMwQytmYzdlM1dHejJHdHFQbE4zZkhJ?=
 =?utf-8?B?K1RFVXJaci9FcTlYUUVvbzRwcjNwUlpsZnorMWFsVWZ1N3BVNXRQclpIbGJz?=
 =?utf-8?B?S2JTMm95NDV5T1lpME13dXFrSmpXQUlKRmF5U1B4cFRCdlBsOGRiVXhFb3pa?=
 =?utf-8?B?dW13NWtpWEZhRXFoV25lbDdZVXJLbWFaQm1iSklrY0xGUFBqbTlwVTUwaXB3?=
 =?utf-8?B?NGtSdFBXc1BuNDlRS0dNV0tyVFRVNFBhQ1E0cFU2QnFrRGFNOGZJZVhodThB?=
 =?utf-8?B?WWxXQ0t4VjJ0N1RCT3FLcjM5MHBzbHM3VWNYTWs4bVFwRDRISU5uRVJEUnJl?=
 =?utf-8?B?ME5xQURuN1E3YnFpdmIrdTJuQXNlSlpvS3UvQWhFbnYyNTIzZ1FDMU9MUWZD?=
 =?utf-8?B?MUl1YWxUMloxSGMvTUVTQkUxekRwZDNjZFphQUt3S0xQaHdsam11Ty8vNGJt?=
 =?utf-8?B?Y1NWN1o2b0IyRlJ2VkFEMXhwRFI2elZqVTdvRm1YSG82SVBlTjgzUXgzZ3Rt?=
 =?utf-8?B?b2NkT3lVTzRmRW1aaEMxWC93bmk4cWZDa3EreTdlUUhDSUhobVA5WDFHVzBC?=
 =?utf-8?B?U000ZHhtMTVETG9PVkxlMFFTc1Nnajl1TEhzb3FqdkF6OU9TWVBpT284WVNn?=
 =?utf-8?B?dSt0eUxxZGVkTyszNmI0VStWNEhodDhkeERibE9XOHJvdUprMi9SZUl5cHdR?=
 =?utf-8?B?UTJaazZmSkFoS0d5empoc2tqY0Z1VEwwTE1GZjRPY2RUT3RKam9KVFJvUnNu?=
 =?utf-8?B?N0pQUDhtcFB3NkgrL3Vub3c0bDVyOS9aWm0wQUJ4TTl0TjNaNzBHb1ZiUTI2?=
 =?utf-8?B?WCtZck5reDRNaTR5VEVrNCttbkpGaHJlNlkwbUJaQ0E3dzl2Q1RRNTQrbWdY?=
 =?utf-8?Q?Bam+NUICHWIwQFpevZjnfwyRU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9203b3-53f7-465f-4401-08dd4b38b524
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 07:41:48.6682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WTzK043RQ5JB8BjY08DzsuYvS03AmDdHq6hKj1nqgv461tKMRfyZXAHK621dr39xyNN5epf5RUWvFQ1Av1KdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10865

From: Peng Fan <peng.fan@nxp.com>

The i.MX95 System manager exports SCMI CPU protocol for linux to manage
cpu cores. The driver is to use the cpu Protocol interface to
start, stop a cpu cores (eg, M7).

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/Kconfig    | 11 +++++
 drivers/firmware/imx/Makefile   |  1 +
 drivers/firmware/imx/sm-cpu.c   | 91 +++++++++++++++++++++++++++++++++++++++++
 include/linux/firmware/imx/sm.h | 29 +++++++++++++
 4 files changed, 132 insertions(+)

diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index c3e344d6ecc645df1f0e3ee8078934c47f347fd7..91c753921dffbe16ced8c10565d44c15b66b2797 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -23,6 +23,17 @@ config IMX_SCU
 	  This driver manages the IPC interface between host CPU and the
 	  SCU firmware running on M4.
 
+config IMX_SCMI_CPU_DRV
+	tristate "IMX SCMI CPU Protocol driver"
+	depends on IMX_SCMI_CPU_EXT || COMPILE_TEST
+	default y if ARCH_MXC
+	help
+	  The System Controller Management Interface firmware (SCMI FW) is
+	  a low-level system function which runs on a dedicated Cortex-M
+	  core that could provide cpu management features.
+
+	  This driver can also be built as a module.
+
 config IMX_SCMI_LMM_DRV
 	tristate "IMX SCMI LMM Protocol driver"
 	depends on IMX_SCMI_LMM_EXT || COMPILE_TEST
diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 7762855d2a771169d4f1867d27e0d51be7c9ad03..3bbaffa6e3478112638ed031375602389f18ef09 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
+obj-${CONFIG_IMX_SCMI_CPU_DRV}	+= sm-cpu.o
 obj-${CONFIG_IMX_SCMI_MISC_DRV}	+= sm-misc.o
 obj-${CONFIG_IMX_SCMI_LMM_DRV}	+= sm-lmm.o
diff --git a/drivers/firmware/imx/sm-cpu.c b/drivers/firmware/imx/sm-cpu.c
new file mode 100644
index 0000000000000000000000000000000000000000..1ce694a34b22843db5c1697ecb33c0479edb2ed9
--- /dev/null
+++ b/drivers/firmware/imx/sm-cpu.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <linux/firmware/imx/sm.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/scmi_protocol.h>
+#include <linux/scmi_imx_protocol.h>
+
+static const struct scmi_imx_cpu_proto_ops *imx_cpu_ops;
+static struct scmi_protocol_handle *ph;
+
+int scmi_imx_cpu_reset_vector_set(u32 cpuid, u64 vector, bool start, bool boot,
+				  bool resume)
+{
+	if (!ph)
+		return -EPROBE_DEFER;
+
+	return imx_cpu_ops->cpu_reset_vector_set(ph, cpuid, vector, start,
+						 boot, resume);
+}
+EXPORT_SYMBOL(scmi_imx_cpu_reset_vector_set);
+
+int scmi_imx_cpu_start(u32 cpuid)
+{
+	if (!ph)
+		return -EPROBE_DEFER;
+
+	return imx_cpu_ops->cpu_start(ph, cpuid);
+};
+EXPORT_SYMBOL(scmi_imx_cpu_start);
+
+int scmi_imx_cpu_started(u32 cpuid, bool *started)
+{
+	if (!ph)
+		return -EPROBE_DEFER;
+
+	if (!started)
+		return -EINVAL;
+
+	return imx_cpu_ops->cpu_started(ph, cpuid, started);
+};
+EXPORT_SYMBOL(scmi_imx_cpu_started);
+
+int scmi_imx_cpu_stop(u32 cpuid)
+{
+	if (!ph)
+		return -EPROBE_DEFER;
+
+	return imx_cpu_ops->cpu_stop(ph, cpuid);
+};
+EXPORT_SYMBOL(scmi_imx_cpu_stop);
+
+static int scmi_imx_cpu_probe(struct scmi_device *sdev)
+{
+	const struct scmi_handle *handle = sdev->handle;
+
+	if (!handle)
+		return -ENODEV;
+
+	if (imx_cpu_ops) {
+		dev_err(&sdev->dev, "sm cpu already initialized\n");
+		return -EEXIST;
+	}
+
+	imx_cpu_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_IMX_CPU, &ph);
+	if (IS_ERR(imx_cpu_ops))
+		return PTR_ERR(imx_cpu_ops);
+
+	return 0;
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_IMX_CPU, "imx-cpu" },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_imx_cpu_driver = {
+	.name = "scmi-imx-cpu",
+	.probe = scmi_imx_cpu_probe,
+	.id_table = scmi_id_table,
+};
+module_scmi_driver(scmi_imx_cpu_driver);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("IMX SM CPU driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/firmware/imx/sm.h b/include/linux/firmware/imx/sm.h
index e02b7b558afb6f430f6fbeeaf3ee1f59feea3c1b..0eff427e5ba2cb3f93c26f7d055c346a1d1433f0 100644
--- a/include/linux/firmware/imx/sm.h
+++ b/include/linux/firmware/imx/sm.h
@@ -21,6 +21,35 @@
 int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val);
 int scmi_imx_misc_ctrl_set(u32 id, u32 val);
 
+#if IS_ENABLED(CONFIG_IMX_SCMI_CPU_DRV) || IS_ENABLED(CONFIG_COMPILE_TEST)
+int scmi_imx_cpu_start(u32 cpuid);
+int scmi_imx_cpu_started(u32 cpuid, bool *started);
+int scmi_imx_cpu_stop(u32 cpuid);
+int scmi_imx_cpu_reset_vector_set(u32 cpuid, u64 vector, bool start, bool boot,
+				  bool resume);
+#else
+static inline int scmi_imx_cpu_start(u32 cpuid)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_cpu_started(u32 cpuid, bool *started)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_cpu_stop(u32 cpuid)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_cpu_reset_vector_set(u32 cpuid, u64 vector,
+						bool start, bool boot, bool resume)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 #if IS_ENABLED(CONFIG_IMX_SCMI_LMM_DRV) || IS_ENABLED(CONFIG_COMPILE_TEST)
 int scmi_imx_lmm_boot(u32 lmid);
 int scmi_imx_lmm_info(u32 lmid, struct scmi_imx_lmm_info *info);

-- 
2.37.1


