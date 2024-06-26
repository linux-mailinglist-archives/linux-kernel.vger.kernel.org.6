Return-Path: <linux-kernel+bounces-230159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5751D91792E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB431C22D77
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 06:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C140158D75;
	Wed, 26 Jun 2024 06:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KS75edXI"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2053.outbound.protection.outlook.com [40.107.247.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB87155C91;
	Wed, 26 Jun 2024 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719384586; cv=fail; b=FTN45aimO0DDciPD3mx9nl5x6tP3yZ8+rHi0q3lzyCQ1PeyGnWbFo1LlrFjdDvQoIcKRAr3Ocvc4OE5WHIqnPWUWmB+KwGTps/v2D7XChQh8/a09s5NztGx7BjPT+GiBPaksznx86akN5Wn/LK8IXsAI8fBGooGu5mWu3gQ5b+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719384586; c=relaxed/simple;
	bh=OOXTDgamNph/DPa7zoSLRZUv0lgUcMOXqG7ClqDl8Kk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=U/PCT7k6F6IqHXcScLeMZ2a7rUmLN3n3bSA0v2PIpv53lB34cZGyvj+e3VqmO9533tilQZI2LmuFYfDStHXGYkKlARDmjMEaM/3sepvZOZDG07ZruF5cja8aVCtJIVeyP0/r69Fynwc3mSCzaa7iyIGz3PUR1k4hI43QPvtijoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KS75edXI; arc=fail smtp.client-ip=40.107.247.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvgfuZizAkqruKWOsKCPj8GLyQQI52retfek5tPMta1z6uRfOZJxlSwQb/0YPphofnqG5Wdzqkk5xgBxTqRyGd8AQDhfmLS42AYPKrO+RhDsE++v2yWcnV3d4kS3yJ25RtvApID5bR0WCbGtmA9VkNZqe4Rer+Lu8ykt+EMU659QIundMRZpTccpvdVIDwn38ZwdJGvOe691qarHXLsF7aYNGn2hUPODQ1j3xdMRZ+Z1R6i86nghHLdn+8HfU+73s28h8YwwdCZ/1ZV6ou8IPHREbEyjSbhZjJxTuqz2VI6dJixNnPwR1YjUM5Iet/73kupplmQIU74V9OuMtPXphg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfaWCLzA2jLdddaj7QK5X0wpdDcKI+14W2K1MW/wPPM=;
 b=mCqrBJSRCPRjb+P2G47eaZ73sIA6YW37jXq9s63Hx5qjsGQJPVMgbCULucl5Po3Ub8rStl2nmS6GzXgzESE7OnKiR6frAInfCNqW41m1cOAVpGexX0mPUNzrC91+4+OxTh/uxzD03IlEGIjfARIofInAzzNip3w2oeyXAmxSe2WOgScJysA1p3j3fdHRu19PazMUOn8kNPcSlAknPnUXzbe3y8AtV7NALFCLzix41O3/K1O2PQpiFaUN8SmNWYdDCOfQrxk5hutSwsYnjXmjBqDTwFIRBG4wWzQHmWGb1wAdcolS4ovSVS628N3dquqCv+ig0l5DAzapoKePxpoqzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfaWCLzA2jLdddaj7QK5X0wpdDcKI+14W2K1MW/wPPM=;
 b=KS75edXI8GHIzkPg/vDwVAGjAiRaoKyhzcXyyfVKsaSquWN7rnfzDp982PCToatoHaC16X36PSs8sfvEUiHa1g9ibAOiVXSu3Inv0ZmkRycGJfstly6QgHJrQayyOxjF6ToT/LxE2QSonP2G7tVDUgLxWnz7Vu8FvAXJnm7YuQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PR3PR04MB7449.eurprd04.prod.outlook.com (2603:10a6:102:86::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 06:49:41 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 06:49:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 26 Jun 2024 14:58:40 +0800
Subject: [PATCH 2/2] firmware: arm_scmi: create scmi_devices that not have
 of_node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-scmi-driver-v1-2-f16d777e004a@nxp.com>
References: <20240626-scmi-driver-v1-0-f16d777e004a@nxp.com>
In-Reply-To: <20240626-scmi-driver-v1-0-f16d777e004a@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719385128; l=2429;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=KX7Kdgf9QfsnuWYcJzLQxwAzaDusfFPpuNBhRr96mX0=;
 b=ColW6ui3H7Px19Y6qIHqIQNVqLnk4O07qiKCRzu4mobRmXyUKwNr80t8DuTLz67bQdNxOjc+O
 X310O2vPZT+A5sJvY506fQdC6pfMKkqC+gI+QxU3jLdz2tJSxzGRWv4
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To AM6PR04MB5941.eurprd04.prod.outlook.com
 (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|PR3PR04MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: f0de233c-fe47-47b7-1a3f-08dc95ac27e4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUdINjlWVVAzdzRWZlJXand4RjRDbEFMWkNQand6NmJ2N0UyaXZjNlBWbDYy?=
 =?utf-8?B?Y2J4ZGl2Rk5vem5lSUF4U2MwdjBaT1R5MXJ1NVNWZnh3SVI0WTNHZHYrWFVH?=
 =?utf-8?B?cnhndVlVVGdacEpaeDU5ZDE5Tng3UlR4bUgyN1k0K21JUkRwS21lRFZMeTha?=
 =?utf-8?B?UnpybHlLN2l6ZVRMeGdZTWdkcTFOeC9vK0tEZnEzWlJ2NkhiUnZVZEY5MGF1?=
 =?utf-8?B?NnVQNkxOb3lMWGhtQkRxL25EK2k2SXB6QUVIakhKbms1SGJIZ3ArcTBPa2dn?=
 =?utf-8?B?Zm02SGJVRXozdXNSUUQ0MVdXUnpibHpTNENxVmltRm9ndnQwNGZEUHhKM0Ru?=
 =?utf-8?B?Z3JhTENhaW9yK3QwaG9TWkJsWXV6eVp1TW9LWlFNVFdGLzdnMFRPT2JzWEIy?=
 =?utf-8?B?aFgwbFhXRkFYUFpQWW1QeDh1NVVlek5kckZsR000K3NRMXB6T0RGbjRDbUJE?=
 =?utf-8?B?QzRpM2x6RzlkdnhRS1htM0trQzl2cWdxYUVHNWFiS3R3VlBKeEoyaGtidzNC?=
 =?utf-8?B?WFI0R1dFS0sycndjWHUzc3JNSnc5ZDNrZExVMlNodjN1ZjZZbXovd2wxUWpC?=
 =?utf-8?B?dGlRb0l4bFYzbTBMaUppVjBsWVBXSlhvSUtDeFRkdVRVaWZOdXQ3UXpmWTFO?=
 =?utf-8?B?dFo5dFZ2UDZ3Tlh3T0JNbU5Ea1V6bDdZeXBLdEdNQ2RnQ1hsZmZ2WmVOczNh?=
 =?utf-8?B?T3dNVVdrY3Eya0VYOHUvSEJNUGRIbitGRjdHOWVHZEcxbThwRTNadUR2TUVI?=
 =?utf-8?B?OHYyTDhNRUh4VXp5cmxjTVVRQ0lLSVNqUHJNdlVhMUNLN2JRemREK01DSDhh?=
 =?utf-8?B?YXZLZTlPUjNzL3FhR0hCcHhTY3N0UUVsN004c2MyYlpCSzN3SkpMWXo2ZjJo?=
 =?utf-8?B?QVVGMjM2dFdvQWtGeWtBMU9zNGcyUDdqOEtwZ0ZoVk04ODlKUksrcmF2R2ZX?=
 =?utf-8?B?QVVBbmlZZC9JS3hNeDY5QVRWNXo5MWh4TTU5MnU3MzM4THJPMEdqNUsxK2VF?=
 =?utf-8?B?cEwwVG54alIwc0dpMlpwRlVmM3hnZGtlRm1tNGJkdTh3bFpQTys2ZFFsaHlw?=
 =?utf-8?B?OWtYbWRVU003WEUyZ1pKbzhHWXI0WForK1owYnNZU0FmMHNTT01mdG5FVXlN?=
 =?utf-8?B?WG9mT1Q1OUFGY3FGTjhPTVVkdGppQm81RHNyRnk3Y3krVGZVVWZCbEVxQS9G?=
 =?utf-8?B?Qzh0QVlQcjc1cVBlYktkMTBEaUpYTHJ6Qzg3djMyR0l1NkRZeUpzMEptZkJQ?=
 =?utf-8?B?MkcxbXRjSmRhWEdoVU5KOXB6ZkxHbSs0dXlEc0VEYThsZ29JNTVOekVwNC9T?=
 =?utf-8?B?MHNvZTR2Y2toMjkrTEc4VHpWUWtacGFLalZFYmNtdXk1emlrUjlPR0ZLMHBI?=
 =?utf-8?B?YStaMkpQNHN2Y1dkMi95aERwS2QrbG13RG5PUzVObkxxMHRLN3Q5S1JZbGlq?=
 =?utf-8?B?cHJnWENWelMzMWpwUE4yOWV5cU9CTHhMVTdiYUxMaXpsL0FkaUI2VWM0N2NO?=
 =?utf-8?B?SUxneUYrSktrckJ5eC9pd2UzaVBwMVNqTFJkbW5jSHhXemZ0TFRjcU9vVUVi?=
 =?utf-8?B?TjR4TzZmS29ZcDBvTUcrSC9MdkZWd0dnSGU3eUQwSVhYN0RBQ2JrOTJFcjJy?=
 =?utf-8?B?aU05TDRKcTJVcjJwbHlJRHRFTXp3U2RLMHR5RENVYlZwOE0reGkwMmdlR1hp?=
 =?utf-8?B?ZklTVnk3V05uLzlVS0ozTzVkUGtuNjYxSCtnakNTbGR1S0h2c0Z3NHo1Mmhv?=
 =?utf-8?B?Y3IwRFJFMENGZ3lDbEROKzE1dlVMNStEUllhdGVJR0hzVWhLTWNsMlRwU1NE?=
 =?utf-8?B?NzIrM0oyYk55UEVBd3JmaGU3SWo3VXVET0liVlQwMU9Eb3BWVUxQWlFoOUdZ?=
 =?utf-8?B?VHN4UndkR1FvVUxkY3BqWm4vSmhpT2xtaTV1dVBUeHZtUGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0xHN2FGYkVXdDlmalBwUzBJQ3V1RnpwS0tZQWhwdkhRMFpQaExnSGpHREts?=
 =?utf-8?B?NnllVnNYMjVnZllJSjFTRFdXU2hySjI1bTRNUnJndWpXUUZET0ZlVGVwdDhS?=
 =?utf-8?B?cUFRMXhiTjVJR3JLSHZvV3ZvSjJJTXFMSEY5VWlJci9Pa3R5MFhydC84dXFt?=
 =?utf-8?B?c3YrNDZKMjlycVZqMEwxSU9KK1dacGFHT1VyWndiRVhiT1pUeTJPTTJiVkZQ?=
 =?utf-8?B?eUJkaitteTBkS24wbUFyQ2FIMkVPcWxKUDd1cW1WSDI2eFdETU5IUVM1dkFY?=
 =?utf-8?B?enBVbWJMbHVHZ1BzRVpkYzhWUXUySmdUYTc0YUpBQ1RCYlZuRFFEVDRXOTNW?=
 =?utf-8?B?QU4wVGtVc1BrYVREWEY0K2U3Y056M08yMnRoZnk0dmJobm01S2xoWmo3MnhJ?=
 =?utf-8?B?TjFuYis4Q3pwUCtNL0hJSlEvRlFpY01FMXkxd2Fxb28xR3BqUVBMR0N1UVdn?=
 =?utf-8?B?THhIMnpMZUEzcVFKVVk5a2cwcjBrQTdwRVFReHNwNldIZk9EZVJaeEI3b3RY?=
 =?utf-8?B?NGJPcG82QUdnRWxXeUtyZFUzMnhiMXNnaUhRZkcvV0NXR3ZJMFRITTVVZDNK?=
 =?utf-8?B?Um5Bdms0T21XOERFS3EzYWowd0tPQnd1REcrRi9UbUZpMTFIMjRHZnRjODRq?=
 =?utf-8?B?OFRyVnF5Qmdid2ppc1NLNUI1VnYwVEVmVXEzc1R4WkhxVEF5bno5NldEalRH?=
 =?utf-8?B?SUtJeTlTY3h5ZlZBemk0dVo4b0dvNVY5cTJDUXlBNjZ5WXNhaDUrakxyV210?=
 =?utf-8?B?TGgxUmExcS9ldTNyZzRzUm5mNlZIZ0tMSTVzQlZ3UTdxTFkxZjhyeUVpT256?=
 =?utf-8?B?MzhDbWZueUdUejFRRFBvdDFMZXVFNHErQlMvb3BTQVZzSlgxaWxVQUY5OTBn?=
 =?utf-8?B?Uys1NTFVZXJPa0tHYkVKeDh0QTMzR0k4bEs2K2kzd0tjRGxNLzdpaHFtdXo2?=
 =?utf-8?B?SmJCL2IzZWxTSTFiR1JPemd3MFlQQSsyeXJ2cHBBN1BiMEJwcEVIK1lxc3ZY?=
 =?utf-8?B?VzhGSkFWY3k2MzBjVlBFdnUwK2RlRERIV2hwc3VCNVkvS0FzanNFb2dzVmFS?=
 =?utf-8?B?bDl4akdUcDJ1azR3UjRDYTc0ZnRtcE82Q09VK3l1Y1diU1ZtTmZSQnpaUkQ0?=
 =?utf-8?B?WGxxWndpanBtWFY4dkYwMUxydE5qNzhSbldOVmEvazFZRnZ1Ly9VSVY0TW0z?=
 =?utf-8?B?RHZVL25sUDduM0dzb285dzBySUE0UERsckVNOWtVOWhNMm04K3hReU5HUGtv?=
 =?utf-8?B?Ykhla0p6WkZzbTBlY2o2Mzc5bjZSTmFXa0g1Vm5ZaUFFSk1hNHZWN1gzQnNM?=
 =?utf-8?B?WUhOdUVYemV0aW5HSVQ1MzMra1EwSWN2cmYrQlFGM3ZxS0tEUlJmWjlDZzhy?=
 =?utf-8?B?bTd1SUh2VXNBMkJacWlwZGYxeWpLeHZneU1mR202dlFrWnpNQmFBOFNLVUQ5?=
 =?utf-8?B?RnlEMjg4YVluK2QvMERZQVFCV1NXeDhkbEVZQTNIdU1tU0o0OVkyN2UzamdO?=
 =?utf-8?B?dGIrbDIvUkpPMU1LWXc0aWV5Tzk1ZEhtRUh1MXdmckxBM0tBdkVQZUVhOTAr?=
 =?utf-8?B?Q0toSFQra2dBcmE0bVF3RTFYRit2SWd0TWMyS2NIcy83bWx6U2tHOGJLZkZ6?=
 =?utf-8?B?S0xXVGphSGdXaFViODMxVnlsZWhFSUhaVk02WnZoWjVkcE5HcE1YMGtYcVMy?=
 =?utf-8?B?b3JKMmVKOFhaTXQvUDFCRklsQVpyR04xS0xNVUcwc01CMnRvZE85UjBNTU4w?=
 =?utf-8?B?a2FybHlmblA4TDVmSWJRT2FYVXQ1SWsyQlhzb2FOdk04WndkODVPRWIzeFdI?=
 =?utf-8?B?akRFTGw3THZUL2s2bm5KTHhmYnRzOTlWbTRzZmdjT0svaFZOZU9kMGNjb3Rr?=
 =?utf-8?B?d1VFWkN3M3FHWXFPa2UyMldlMEF1YVQ5VkVKRmxhRUNPZ0Y5K1RUQ3M0dDZY?=
 =?utf-8?B?WDgwNzlDbUxtbFcwaUJEN0YrMVVaL2JnaHZNK1ZXazF0RHZraHN3bjMxWWc3?=
 =?utf-8?B?YmovaXpIR0JyQ21GTytlcDV6RTIwU1lwclZqUXI4azA4cDNUTi9PYkdyYzlT?=
 =?utf-8?B?VzZHZ0d4ZFVIQ2ZwakIvbjFaR3hIZWxiRFF2OGJJVmpiazhnOUkvRU8wRkx1?=
 =?utf-8?Q?qt9AH18fSGg0Ta/3AIgP75QhD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0de233c-fe47-47b7-1a3f-08dc95ac27e4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 06:49:41.6623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8fbxM+0+Ihqc6wLT3LajC6enufvtkV/br0BqT26LHsHRD+efHpqExN+DoV578n4vM+MTn1+pZBf3/M18XLpHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7449

From: Peng Fan <peng.fan@nxp.com>

The scmi protocol device tree node is expected to have consumers or
per node properties expect `reg`. For System power management protocol,
if no per node channel information, no need to add it in device tree,
and it will also trigger dtbs_check error "scmi: 'protocol@12' does not
match any of the regexes: 'pinctrl-[0-9]+'".

To enable system power protocol, need to explictily create the scmi
device and bind with protocol driver.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/driver.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 6b6957f4743f..eac4dab979c2 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2952,7 +2952,7 @@ static int scmi_debugfs_raw_mode_setup(struct scmi_info *info)
 
 static int scmi_probe(struct platform_device *pdev)
 {
-	int ret;
+	int i, ret;
 	char *err_str = "probe failure\n";
 	struct scmi_handle *handle;
 	const struct scmi_desc *desc;
@@ -2960,6 +2960,7 @@ static int scmi_probe(struct platform_device *pdev)
 	bool coex = IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT_COEX);
 	struct device *dev = &pdev->dev;
 	struct device_node *child, *np = dev->of_node;
+	uint32_t protocols[] = { SCMI_PROTOCOL_SYSTEM, SCMI_PROTOCOL_POWERCAP };
 
 	desc = of_device_get_match_data(dev);
 	if (!desc)
@@ -3114,6 +3115,36 @@ static int scmi_probe(struct platform_device *pdev)
 		scmi_create_protocol_devices(child, info, prot_id, NULL);
 	}
 
+	/* Create devices that not have a device node */
+	for (i = 0; i < ARRAY_SIZE(protocols); i++) {
+		void *p;
+		u32 prot_id = protocols[i];
+
+		p = idr_find(&info->active_protocols, prot_id);
+		if (p)
+			continue;
+
+		if (!scmi_is_protocol_implemented(handle, prot_id)) {
+			dev_info(dev, "SCMI protocol %d not implemented\n",
+				 protocols[i]);
+			continue;
+		}
+
+		ret = scmi_txrx_setup(info, NULL, prot_id);
+		if (ret) {
+			dev_err(dev, "SCMI protocol %d txrx setup fail(%d)\n",
+				prot_id, ret);
+			continue;
+		}
+
+		ret = idr_alloc(&info->active_protocols, NULL,
+				prot_id, prot_id + 1, GFP_KERNEL);
+		if (ret != prot_id)
+			continue;
+
+		scmi_create_protocol_devices(NULL, info, prot_id, NULL);
+	}
+
 	return 0;
 
 notification_exit:

-- 
2.37.1


