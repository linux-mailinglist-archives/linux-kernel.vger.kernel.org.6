Return-Path: <linux-kernel+bounces-175508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 977BB8C208C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B0F4B2193D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB60B17109E;
	Fri, 10 May 2024 09:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="br0EUVtn"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2068.outbound.protection.outlook.com [40.107.241.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D1E171093;
	Fri, 10 May 2024 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332359; cv=fail; b=oghDhI51hhClPHpHUxyN/eJQQEb/nMghACttwjMdCRKhq3CW7fCcywunT/z1fE5V8Q++/Ic7hii989vF1IxbefVapd4J98Wh7tlZGWeYyiYkemWvH/Ph2uDSkqNEEban6snG1JpdsZTV7Iu2UwdBlxGWujZVpYWYZDfQEBDmqcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332359; c=relaxed/simple;
	bh=zB0ZVdk0Qm7I8UWyqi5Qs3uBnGOodb2WAs9gToNGiDU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=roRGNBI+U1sc83arlqGAxdro8aXCh2eFiDbMlFfp8QWL1MXUmQ4J1gqUUFgFLtMmYX+P9xmAw5AnQqbmThfrgdpErSmXmiT4rU04fdsJe7svMsZ2f9LKso7wD45n6hGwhL45/EHECwyM7tQhnB3XJ0AMMFm9akz6PJRyqTHzXI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=br0EUVtn; arc=fail smtp.client-ip=40.107.241.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcanEAijTStnPfpP2kjZ0iDKrSzDh4/4m6D2pwoIg5kzGRsaWDt5Ef2G6MDVgebGTNkiQ5ceJYDvYSpOX2+qlTbEtsHL+D1s0WXBzNkEo2j+83+dOUaU0g2LgFhiKqtRZQ5CDBLnJNmNrLvGTvaEgYcmqy57/EDOphMxIrAQA62HsjGOmfbnambL929vs7L/w777RpMmj+iQsocYi5h70mPPrXn5werQpWW47Nt4f6nOXuzkBvU1ZV1niaTC/J9uSWfANXF0zmEp9XI0mdQ4JQa+g1HQUUZp4aNgNRYWPsrq8kAgrHwLW7vMBhq03k2A2tt0WlfCo7jRbW++qNq52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=morjSPZoht/sZgZZlrJFTpm7VksD0m/Vy6jf//XeATM=;
 b=gSO25yuHZ6I54pEs54x0FLDjChlbuxRHehqeUaTV6DROtvC/6MuPqn62w8oX32mZKD56NLWkNdUCPmLQ5kiEDMcmGrVM8G/oXTNK28G3HPVHwL5KGhped8Sga0G6PyNtP1pZ78mdY7zqjOsXLCLKnCKDxlWJh2+z1Z/XcGtYGlTovzfGdVYSonaS4r8G2lQ3ypDHCY4ydErE4ftaZkOMIP45/sSsQmTlIf4ZVikOBvfml1air5nCSJJ8orPgjKEyupkbu80DR08bA0tGThwrOTgkAmqVGBjd5Dm5GiUbCTsC/Mo4uKf4hogBIdgVvzkA84Sw1PAIYhyLpn7FK0T7KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=morjSPZoht/sZgZZlrJFTpm7VksD0m/Vy6jf//XeATM=;
 b=br0EUVtn1emiD1+StDsz67fWvXt1AjIk3vZvPJd/jYzBmAgmjRsBewc1i7joWNee+mv+K6mcudnguhnsI2+ksgo2fINnLbbfF9sxNp/XQmDPxiQUbUDHr5IBNcFmrBo4k3CTXoq2bKwAcYQqWqZIAyDrE/qrvnswXnBSEzH75OE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8065.eurprd04.prod.outlook.com (2603:10a6:20b:3ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 09:12:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 09:12:34 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 10 May 2024 17:19:11 +0800
Subject: [PATCH v2 16/17] clk: imx: imx8qxp: Parent should be initialized
 earlier than the clock
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-imx-clk-v2-16-c998f315d29c@nxp.com>
References: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
In-Reply-To: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715332748; l=2435;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=hrw2P3sZckBHVBC6N5CEm5mGrpqUDVpTtcM6jOZ4s+Q=;
 b=jggKi1wisSCi/5BQEhEURqg21rIzv+YQNnC+W9Q+DsaeUAQW/t9YSylKpfycKj+1x9W/dYolp
 ET7hxSCzLtJCOwApAnfBZKjW/kdRVcTWlt/4kAncJtTod8ScFA+fu4P
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 694f0e34-d08b-4ccd-a750-08dc70d15469
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|1800799015|376005|7416005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHgrWTRqVkVRTHMvbU5wbkdpY2NLblAyWFZKbGtmTVY4ZjdOcFZqNmZhOStC?=
 =?utf-8?B?V0ZseDZQRmtiU1N6QTlyY1Z2YWtwS0QzaUJaWkpUL2lnQzJzVzBnTS83OWw3?=
 =?utf-8?B?c2VaeEVoMWVlcEsxczdyaVRJcVJJczEwaC96WEprQkpLZzZQNXdsSTVPdjJ4?=
 =?utf-8?B?R1lnUk5OUnRNOHN1bU83d1lGY2VBQ3dUSDRxNHBTWnJqajI0ajdEKzBIdDRN?=
 =?utf-8?B?dVVNdEFsRVdyRUJwRVk5eDhkYVdWSE5VQjZHcitwdEZ3WDNqTEg0RitFRDBu?=
 =?utf-8?B?S01tSFBSM2JJQ25LV2dxWjBWbXFSdTR0TlRObm1rNldZdDhsV2RYUmhvWUhu?=
 =?utf-8?B?SERwRC9DUGNvQUNaZHRvM0Rzc1MvcDVvWksxdjl6RVl1bHI3c0xWZjZnczR3?=
 =?utf-8?B?M0xSOUJJUDdXRnZSVVFRaWU3R21BYWVoY2k1ejZrVSszNHhseE1rUEtueUZ0?=
 =?utf-8?B?VlYxR1o2eTBMM1lacFJpU2FLYlFWYUZhMnFsZkRjaDY2d0dZbmlXTnoyNzYr?=
 =?utf-8?B?d3o0eU9XRlVFOW50NFVrbmE0dllnOVlsbVFPNXd6b2U0dHRyakJBVGdLQ0tT?=
 =?utf-8?B?Q3JTU2hmQkZmT0VYZXNRcGJQdks2SEhNdXBzRkxzNlBheDhmVlVMdjdUNHo2?=
 =?utf-8?B?L3VFZUt3UnJtYkFUWEVKQjBrdUhKQVJRUUtYNmhtSW5odnR6ZjlUVzFXUnM0?=
 =?utf-8?B?bFpzcHZDc0dyV2tQMGJEM0I2R0h2Yk90d04zSWp1VTNNMzNhS2MwNFplRHVv?=
 =?utf-8?B?eTk1NXZYSkx3M09GSlZPMllOUU91ZXgxWU5kTmtQbUNRSUFaRkRmaVdTdm1Q?=
 =?utf-8?B?THpwaUI0ZEppNU9aN2k5WGhYZUlRQ01kd0JwTGcveWRXQnJoRXdnZTlJR0FY?=
 =?utf-8?B?Mmo2elA1cGYyUDM4THo1V1NQZnlsZy9McnN6UUZBbFU1UVR0bmtIN0hibkNx?=
 =?utf-8?B?SlNjM0RxVnRMcG80eXVHTjJwQ3Q1RS9HSUtlYWFjK0M4VkJwNFp3QitHelpi?=
 =?utf-8?B?STBKVGhlcGo2T2RhWFROZEhTRXdzVGZjRWFoL241QXA5R1c1VkhzS2FzWU50?=
 =?utf-8?B?Y0MrZDJkUkpBeVBsSmhzWGRnbzFYVDhQajg1d0ZQM3I4NlBNNTJXcW5GZDA1?=
 =?utf-8?B?RXh6TWJSeXd0Nk5jbmljTG9ybms0Unc1aU0wWUozV0svR0NoUGppV3Byc0RY?=
 =?utf-8?B?ekVhQ3lKZDYrc3lWdjFSb1dtNmN0bHlvLzZZd0xGTHo2SVNpMnhUNXJZVHlB?=
 =?utf-8?B?d01jbmxqeHlTSHhnamJVcFNSU28rbEtzT1dKNTgvbVNaUnoyNHlGd2hNWFNh?=
 =?utf-8?B?UFNTakptNEtlTHRUVmMySWRBbVcxK3R2RmJGMlVXRm1oQ1BNNzBORkJFNy9C?=
 =?utf-8?B?ZjYyc1JtdzIrZEV3Myt4VTBtWFpGem9xc1puTnVZcE1SMHFrc0dhK0pEMW5S?=
 =?utf-8?B?Y1p3NzNEaVd5eHhhNzJwN3ppRDU4WDZ6Q09LWEtlZmovSGhTMEFVajhBMTBw?=
 =?utf-8?B?dUNhVWQwZDZoWWl4L2EyUFRYMnh4Z25CMGtIdEpmeTExcnV2UlRReHNJR21M?=
 =?utf-8?B?WFhEMnA5M3BrN2RtQzZEOXl1b2p0dzV0d3NVRGxvWWtoQ2N2TlJMN1NnVkZE?=
 =?utf-8?B?ZURMKzNqd3ZpY0wybXNQVzZWMjBYL3R6UDB0dzE3STZ5bGpjcCtLcFJjSGFy?=
 =?utf-8?B?Q1lkc0JPVVhzSkRqZUc2N1NDNG9yazhUN1RFRENjKzcwNFBRRU1KVlh0QzlR?=
 =?utf-8?B?Y2xVWEFBQ0U3clJDTFlnM0lZYWt4RUhSUzNieDVpNGJrY2UrYkNUUnVJSm1T?=
 =?utf-8?Q?n85Pj9tg1sL0raBFvw9Uf4oxoC1yCOOLv0L5E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y25UYmJjTi9IdEtvSStrZFgxVTlVT205eWNweE5DbG9JaXFLbzFIQlphb0FG?=
 =?utf-8?B?TDFpanZsanZoWGZWblFzOHNTNUdQcE8vU2V5bktaQzZSUDdjWXFJc0tLdW1R?=
 =?utf-8?B?K2JVaE1RYjNkS1Z3QktuZGxQWnVkK2hhOWEyaXNLNEFGYkN5YmQ5Yk5FQkJz?=
 =?utf-8?B?WEVLNXdvRVFaSmxHNmJBNTBSUHdWWmkybmRDK2tYbmlpUVQ1Sm4ramFUVFli?=
 =?utf-8?B?aGdjdzRBamtvc0FVY2V6N0s0d3NYcENFd0VtczZoYnkwajRERXhLUVNmVkhR?=
 =?utf-8?B?SXl3a1Rwb1RmUlZ4NXRGYTcwK0VDSjNoamtRVDNaR3FNcVNQYUFXUU1oM3lI?=
 =?utf-8?B?b2xDYlZxUjhVZjVJb2dMMDROUlFIb3YybEdoS3RqN3YyaStEZDBWRkZIS0Jh?=
 =?utf-8?B?YnNNR29XOEVRMnJRZ1d6NzdkSkg0WkZjUFBocXZlZXVCSEFMKzRWclVPMlhS?=
 =?utf-8?B?cWtYdE9rSytxdUxDTWFESzIyV2d0K1JXSnF6UlRZSnA3blo4V0h6SlgwdWVI?=
 =?utf-8?B?cWh1UXBCeWRhT0hOSVg5WTZYZUFRM0RaVG1XYmxiTjg5Z3Y0VnZ1dTdBL3d0?=
 =?utf-8?B?R2hpc0NEbDFrdnVsU0pKTVNNNUdzNVk3cG1LMzNJZmFFTDdVai92cVluNnJz?=
 =?utf-8?B?ZXlzWktqenp2djVLTHF2SEptc2k1ZHRURzlJNmtRTXdUT3dKSDJXUzZjMUJM?=
 =?utf-8?B?clNpSTJmL1NYam9yOXFTNVBCT3ZKcFF0cjRkZlpLWkdtOWpmK2RmWWVkYnlO?=
 =?utf-8?B?VzFBMlZhNnRhaTlOOXVxVzdjTU1JY3hCWVlTL255Y2FnTC85Z0F6UjN6WlZ0?=
 =?utf-8?B?QXg5NWd5RG9wMFZyM3Ixb1h0OGJGdEttQ200VS9CSVNwWlVZbHZQWGh3dHFH?=
 =?utf-8?B?L2pMRk1TcDNiREFZUUgwZjlzbkt6dFpCTzU2UTdxb04ydzhlaUFqeXJ1TjdX?=
 =?utf-8?B?WC93QVoyM0lGSjdncTJaRHFlMDBvYlVVVDU5WVA3VmkwOWRLMXRLVm82K2Nl?=
 =?utf-8?B?d3RQY3M0M0FGSlpGNDZKTExNMTdGQm9rdUtGa08rc0EycC90anZWZUhGT1pH?=
 =?utf-8?B?VFlrQ1FLQnI5bi9SeTQ5OHhDWW42Z2xwYzE2QXZWeGw2RE4zdEVMdDNacDFU?=
 =?utf-8?B?VTR1Q0xwUStoRWhIUW8zdWpobFpNUXhYUGI3ZWs5RTRsc0Z0a0JSMmdDSTBo?=
 =?utf-8?B?K1cvWkx3R0NnVGZpYlpwUnBreGt3WWg4cHZlMHpubEJYclNTcy9OaGZZb1cr?=
 =?utf-8?B?VmJjNzFpVGFSQk9mQ2ZhRUo5Z0UyNHBXNGVLYytWeFlnWmQ1YUhTUk5YbGZn?=
 =?utf-8?B?UnVBSjN4VEF6TjR6MkoybkNXbjR0TW1yQ0hmWk5HOUFyK2crZW9vK0hmT2F5?=
 =?utf-8?B?WnNwWXljTUFqa0xWWWZBY20vcTlCQlFOeGVUaWVOSVRnRWFLTnd1am0wZkdz?=
 =?utf-8?B?VktCZmsrbDU2L2Rpb0pOU0FBbEpXendEa1RhVGtsbTlBY0Z1R3pwMW9uVVJz?=
 =?utf-8?B?VHN0TURCMzhUdHVaQ2JIZUhaZFZINXJibmVKSVJWYnhUSEZXSHVTUHJNbmdI?=
 =?utf-8?B?UFJJamNzNDVNN1MwN1BqdWw4MnVKQWZBWkZ2RUl6OHM1TUVVb1liT1Vnd1lG?=
 =?utf-8?B?b1hGUEFzc09obEdQRWNsUGxEdDdUVCtLakxEYXQ2SXNLMlZwTk1QMzJIL2xx?=
 =?utf-8?B?S2s3ZlBUdHV0cFFBUUY5WWdGNUI3MG96aGE5S1NtNVFoZWZhSWpDTFFzRzV5?=
 =?utf-8?B?Zy9wREtVblk5c28zV0FhKzFTZ3pWT3plUlpYNEkzZU4rdE5XVEhDUXoyOVdp?=
 =?utf-8?B?aGtrUU42UW1vYVZpbXdLWG5GdTU1dHpvRkdrZTJYTlFOTWpqOGdhUngzNDhX?=
 =?utf-8?B?UlkyaDZSTlE1cnJydFFBOFM4UmkxRjhZMG5vdWhGWmZ5YUk2T2s2SVlLNjBY?=
 =?utf-8?B?T1J1Tk1IT0lWRGRNendISXFvMkt6YzhrWmoyelhwMGY0Y1ZWbjBiR3dQNmdT?=
 =?utf-8?B?a1FKZXV3Mm54MVdpdXVSMFVqVlFXSUZ0OExQdzZwaWUyclZ2QUxHY28yVlpI?=
 =?utf-8?B?L3VkYnlnRmt3ZmRqRTEvUE50eTA3SDBUQ0tmMktlYmNnTi9yeW9lNGRWdEdw?=
 =?utf-8?Q?eWf9KK6iDjhdMu0h+dIXLf7sj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 694f0e34-d08b-4ccd-a750-08dc70d15469
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:12:34.7631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4CIeMXS0VK31cFzarRKT3WtglViYSFRQ8Crg1FgIdqP1QszQ5pst1j2SIxON8RoOWgTwvrTOWv6yN5hbtSn1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8065

From: Peng Fan <peng.fan@nxp.com>

The initialization order of SCU clocks affects the sequence of SCU clock
resume. If there are no other effects, the earlier the initialization,
the earlier the resume. During SCU clock resume, the clock rate is
restored. As SCFW guidelines, configure the parent clock rate before
configuring the child rate.

Fixes: babfaa9556d7 ("clk: imx: scu: add more scu clocks")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 47f4ceab1179..3ae162625bb1 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -186,8 +186,8 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	imx_clk_scu("pwm_clk",   IMX_SC_R_LCD_0_PWM_0, IMX_SC_PM_CLK_PER);
 	imx_clk_scu("elcdif_pll", IMX_SC_R_ELCDIF_PLL, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu2("lcd_clk", lcd_sels, ARRAY_SIZE(lcd_sels), IMX_SC_R_LCD_0, IMX_SC_PM_CLK_PER);
-	imx_clk_scu2("lcd_pxl_clk", lcd_pxl_sels, ARRAY_SIZE(lcd_pxl_sels), IMX_SC_R_LCD_0, IMX_SC_PM_CLK_MISC0);
 	imx_clk_scu("lcd_pxl_bypass_div_clk", IMX_SC_R_LCD_0, IMX_SC_PM_CLK_BYPASS);
+	imx_clk_scu2("lcd_pxl_clk", lcd_pxl_sels, ARRAY_SIZE(lcd_pxl_sels), IMX_SC_R_LCD_0, IMX_SC_PM_CLK_MISC0);
 
 	/* Audio SS */
 	imx_clk_scu("audio_pll0_clk", IMX_SC_R_AUDIO_PLL_0, IMX_SC_PM_CLK_PLL);
@@ -229,11 +229,11 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	imx_clk_scu2("dc0_disp1_clk", dc0_sels, ARRAY_SIZE(dc0_sels), IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC1);
 	imx_clk_scu("dc0_bypass1_clk", IMX_SC_R_DC_0_VIDEO1, IMX_SC_PM_CLK_BYPASS);
 
-	imx_clk_scu2("dc1_disp0_clk", dc1_sels, ARRAY_SIZE(dc1_sels), IMX_SC_R_DC_1, IMX_SC_PM_CLK_MISC0);
-	imx_clk_scu2("dc1_disp1_clk", dc1_sels, ARRAY_SIZE(dc1_sels), IMX_SC_R_DC_1, IMX_SC_PM_CLK_MISC1);
 	imx_clk_scu("dc1_pll0_clk", IMX_SC_R_DC_1_PLL_0, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu("dc1_pll1_clk", IMX_SC_R_DC_1_PLL_1, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu("dc1_bypass0_clk", IMX_SC_R_DC_1_VIDEO0, IMX_SC_PM_CLK_BYPASS);
+	imx_clk_scu2("dc1_disp0_clk", dc1_sels, ARRAY_SIZE(dc1_sels), IMX_SC_R_DC_1, IMX_SC_PM_CLK_MISC0);
+	imx_clk_scu2("dc1_disp1_clk", dc1_sels, ARRAY_SIZE(dc1_sels), IMX_SC_R_DC_1, IMX_SC_PM_CLK_MISC1);
 	imx_clk_scu("dc1_bypass1_clk", IMX_SC_R_DC_1_VIDEO1, IMX_SC_PM_CLK_BYPASS);
 
 	/* MIPI-LVDS SS */

-- 
2.37.1


