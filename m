Return-Path: <linux-kernel+bounces-175495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7B58C206E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252222831A1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B07816DEB5;
	Fri, 10 May 2024 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GF84DOWn"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2051.outbound.protection.outlook.com [40.107.241.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8DE15FCE1;
	Fri, 10 May 2024 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332294; cv=fail; b=PdZENEZLwtrjubPF5aHIWysS9LPkfW1N7otxpyi0WAvTbcvBKiDY5046PVEPrVZhZKNz1KnQRPbbLV1IzG6zpIqdv2YE5jYmebI7f2YS9cXNb7S5hjGDUNiHLnApfEVJUE3k6fdbrGXUSUWZAuajY1CvWgBkeOH+sjoFJgrhFws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332294; c=relaxed/simple;
	bh=3/ebBXKy2EoNIVdw7nEZvhT7omyA06RAqLLNddA8Y0E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oDyU81zROMul9sPyb29MdGkaLgIzkv9lxbOimxd7E+l3DvPz5mY4fo5fMEXNju9deWpoWh0rAFMz7QgtVRcW+IeJIfQSk8W5A0tvVVO1d0E+6RFG52tgeifie1uQ6Q+19mM19++PbhCrt0WasoOWC6xWnjKxioRYF6HY6RZOAm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GF84DOWn; arc=fail smtp.client-ip=40.107.241.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhSnCkA8V2SiHuMh5fMJdJJNzo3QtYdybz4uRiF0+GfawmKwwb6ER6zP+wvYcKsorr7MaiinoEy1zzlZUhyAAltLi5jGXsY3U+YtteR76OGGL/C7q8pOEQESOO0+8uIfr0Prw06kduAlM8kah2+j9bj7mliMS6yR2EsDLUmzRqqYcbs1121iy3KH+J0u1jr8AvBRz+NxIn/oD3YDhzMV53JIYlI+jbNvJReW2HQIhV+mk5FfPmQz4Sm0zYBkFHMGmFUFJ1yAPODKD35aWioTgJn5rYm55iRTxybfVp/KlyviEDvKzmGI3T7RA4qnhYYBSt9k146zwKGTNXRnVpevVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuO7Ij7e1bLmWdg4m5AsnXdVhWvgoEiSvYg9UuypLak=;
 b=COtSLV5RAOdi4KYWvHodAfTubYUVJOj2Tlg3OB8mOK4WPBLWMWdCWFVXnwmn6vGIbqUf6aaLqkAuziPIJ2I0xTmCLC0b/HGuZQXvxkVrJHVwwtg+RrjaxYQ5P3m9zTmj/7sEIzQOm0eK7yc2YVqQO+nUN/OtCkgw65KeyIvQk01VsGTgU8NzTagOC1hmPAHkJ89hyd1y5DcvNbil7+WqydoX9F5anaMTTou4Q5BJWebxINaOaaDnCeikWterrk9wZB3T6l8I3YSdEUq5FjSgqJoTHcfqJnGP+lkXciIlL2MPx1SErk4oHaTFtRv4fXAWMNt9ZKB+g3+GPez8agoMiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuO7Ij7e1bLmWdg4m5AsnXdVhWvgoEiSvYg9UuypLak=;
 b=GF84DOWn448z+w0+dqQjsQOLUfXFuUcMJyYWXEdmfg3QQ5LqBiHahGKz9vBon9R+iEZzT/3pwJw22LXfPtNDF4nMU/WcWD0xz0FGqm9I+ky7wVsR/PzyxOz6ottd1ezgkSwXFI5pk4b4lO3nfNGj78nRp694Mcu1WURg+fyYe08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8065.eurprd04.prod.outlook.com (2603:10a6:20b:3ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 09:11:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 09:11:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 10 May 2024 17:18:59 +0800
Subject: [PATCH v2 04/17] clk: imx: fracn-gppll: fix fractional part of PLL
 getting lost
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-imx-clk-v2-4-c998f315d29c@nxp.com>
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
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Pengfei Li <pengfei.li_1@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715332748; l=1031;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=YbtICGkfjNb9cX1EM8cRO+LQzM8n6WyxoMB7kWtrQtY=;
 b=LeZ/FGA0DEdEa12W6Gzb7X6btvdYVAKZfB4qQZ8oi4Ly9xh1uxnEbg48Q7k1B3Pt/U7Gwqs/E
 DunKDVWgLzuBV+tlqu0R838Ni8gdpU3AQ3Ac79/e4y3F6r/HTaQ1wu3
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
X-MS-Office365-Filtering-Correlation-Id: 7d9f87d8-99d4-4474-18ed-08dc70d12ba8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|1800799015|376005|7416005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dERaNW5FazNDbm51OTRZaS9mSnkvS0dzZ3VjQ2dialRJUGlBalREb2U3UWsz?=
 =?utf-8?B?ZU1WOUxWY0puL29FeURTZ3QxcGpKK29UT1EwN3dKZFZ3TGNURm1xM0lSTnd1?=
 =?utf-8?B?dyt0cDc1eXcreVhlWnRSNXU3c0ZSY3ZsVlNKVkFpQzM2QU8yL285VlNIMVVJ?=
 =?utf-8?B?V2JWMFErM2g3bnp0MmlmN0xKR1BCdmlBVG9qT0JKUTcyWGtxWXpnNGx5N2lF?=
 =?utf-8?B?UktrdWlrUU5adzQ2NXJERURYMzhvci9hdENUbFg5d1RKV2VETWkvRDZJaWVS?=
 =?utf-8?B?clFxS3ZnTU5Lb2krNjR1cFZZVWI2Z2VIbGxMVEFERDhNVVpxR3JVRWoxM01U?=
 =?utf-8?B?Z0FnWEd4bW1mMC9yNGtYeXZ5a05GVUJRTDlWdXk5Y3hHYy9zWlJrcytzanVJ?=
 =?utf-8?B?TGhPd1N3dWFPMERZSnk5eTQ5MXBoK1owOTlUNy9iSWJhTkI1RzhHSDRvdjZV?=
 =?utf-8?B?WHdxbS92azZxZU1iTUZhUU9ENDlrZlo5KzRmM2tPZUZqNitNN3hiUXZpK0hB?=
 =?utf-8?B?dFdqby9IY284ZXFBWGJFZHZwdlUxSkY1cGhmZnp2MS94TkE0RkNMbmN1dlZH?=
 =?utf-8?B?LytjeTBYb3FhL2RrRU9aK0FVZlFSUXdCYXhDbjFqelVmQ2pwTlpBaFl4bEEr?=
 =?utf-8?B?WEhDOXE0cFJFeEtHaTBVdytPSElxVHB4SGdDa1NZSzFuc2xOWXB6U2xFUGdU?=
 =?utf-8?B?YTA4ckpuSVpuM3h1a2x5a2l0VUlNRWRHVzVoS2M2cko2ZHkwYktDNzNyWWht?=
 =?utf-8?B?VjY3Vk5OQmxqOFdFbW1xYnppaHFGZnJXZlQrUnQ3Mm5MdlNqVUlCQ1VZR1RN?=
 =?utf-8?B?ZzFBZVFmL0tnVEpzRnV6V29YQVN4OExKT3ZuSzhVVVo4eG1qOXUzd2xIREdr?=
 =?utf-8?B?Zkl3S1FKcjdTUkE4bEhPY3puT05FMTBlbVBYeFYrSVdXUnNEREhrVmxHVUI2?=
 =?utf-8?B?T2hLc0xvOEQwN01iZHNEYVhvcEF0QnpGSEJqcXRIQ3NvdWVUSFhLc2IzM05Q?=
 =?utf-8?B?T2M5ZGVNTnErZHl4aHpQbmFmSGJrKytZQWxqd2dVT1NMNzYvVzBYblRFdUN4?=
 =?utf-8?B?d1BHY0RuRU1QSTJwcXN6b29jRE1KSHlNemlQVG5VRFZwTFl1NGlwRzJDaWY1?=
 =?utf-8?B?YzNRRTV2TXhxUk14U1pMcEprOEZZSkJSM1p6WlUyUkpxelNpeENTRS9VSmt1?=
 =?utf-8?B?cU95azVhc09EK0dWWFI3d09HWTRhTk9NbnVQNXZ6UTJXOC9lenZORGs1Tzk2?=
 =?utf-8?B?RDZyeW8wdnErMXgzQ2VyalpEU3pVczNvWDl3M0pjUDBmVDdNWlNSclY0ei8w?=
 =?utf-8?B?L2FiN0dzRlRLcXp1QzZndWhmZCtYdFY2MkxYK2sxZVRYdHQ2OEQ3RVQvbnZK?=
 =?utf-8?B?dDdqd3hWTUxUWnk2QWJ6ZDVOR2RCd1pZL1VCelVmYkdka1NBVWw3YUJLc2h5?=
 =?utf-8?B?R1NWOUdrNkJvNjQxYzU0N0FhMFY0MWQvNGZVMldCVkhnSkpNekE3S0gvVDVr?=
 =?utf-8?B?bTBldU9Sc3hBRDFyNUJabGZVLzRTbFVKRDliOHQ4blhYYm01VVVrL3c4ei9Z?=
 =?utf-8?B?RVUwK0lqdkZkbUZhMWdzcFhMU3E0TUo1bC9pYjJ5VjRJbUNXbEVBZzNIbFUz?=
 =?utf-8?B?b1JSTFc0bDNuaEdHQ3JBTzBkb3dBUi9SSDZDdlp3K0FpdGk5NWg4a1JrNkFH?=
 =?utf-8?B?U1BSZUtCY3FGQlRIYUxnYktRaTJQZFFyWE14eGIrcGZKRWU5NEJsUjcxTTJp?=
 =?utf-8?B?OFNDdnBPQmFmaGJRSisrOG5Lek9NNWVLUEJwd2VmdS9wNE5hVmsxRWJVSE0z?=
 =?utf-8?Q?wy6tYHgFtpCjwLLfP71jBaVIqVfPKwWQfSVq0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDlwbjBHaDRTZlpsTUg0QzJYcmp5SlVQVENkVThVcERud3VyNnFPTkJ0UFlE?=
 =?utf-8?B?bGsxcHJ0NzlKUjFpM2pWRTRhUjdxM0UrR013Wi9pN3VVNmMzcWZDd096aHpj?=
 =?utf-8?B?c0owaEZBRktJYWh3b2oxOUE0Slg1eUMzaHlKVS9NS0ZCZHVaT2ZDZkJEV1VC?=
 =?utf-8?B?TTVqaFF0aGM3WXJjK3RuMHZZN3cyRWgrUVgwamsxK201OGQ5NFNFU21GMEY0?=
 =?utf-8?B?L253RkV0WVE5WnNTZlFMSEtsNlNHTWRsRWpJS2hXd2N5Q054VVJPNFVQTnZ2?=
 =?utf-8?B?aENQditFWDdHemQzUVdqRG9oQWVvZkZocmFhS3FOM3FNWndwOG0zMkhaUzhI?=
 =?utf-8?B?WlBMclFJZE9vTmdDY2w4b0JRQXMwWGVONXFBcE9oUnhLWlJOUFY3cU1UUXBO?=
 =?utf-8?B?ZGNsZnFKMzI4aGl3SlQrSlcrZmtEQ2FIWUY5aFNtblI0bzk5TlBSTGVVeDVt?=
 =?utf-8?B?NHh2dVpKU2ZHcFdnZHVGWDg5ZXh2OW8ySFRVK1NXMDRqNmVEY1kxQ3NqSitK?=
 =?utf-8?B?VkZYRTBoQzFiYnBqZjlxNXE3OElJL3FBa0FLdkpmSjdIcGFnK2VobWpsc3Ri?=
 =?utf-8?B?Znk5TmJDRU0yY2ZQbjRIUzl4dnpyQjZUR0pBVjhsQUI0QS9jRndScXBPcEV0?=
 =?utf-8?B?VGpwYisvaDR0SUovMm5tQUo5LzJ6eDJYNy8yYzlIR0dFekZyYXVtbHpNY2E3?=
 =?utf-8?B?SjBaRWNlb0hhSDBicm5LMVVjRGNGd1FFN01HODNQRElZSTFWbUlPdVNZYytE?=
 =?utf-8?B?ZmU3VGVSdk8zME04MC9jMGZHYjd5WWZWS2VPNC9MRlIrMVYyOWVSQ2szTHlC?=
 =?utf-8?B?YU9yaXVoMnpKaEJiK3ovcjFHZVJGYVZLWkZYR2VZNnlCY2pGTlVlSWRDOUN5?=
 =?utf-8?B?NFhISFpwaUtFdWhXWGVrTjg5SmpraktGZEFJQUUvNnJuUlQvSTZYaGRHMmJB?=
 =?utf-8?B?MUl0V2d4Y1Q1QkhjblpYTkp1Zm1keE5KN08rMG4wcEUwN0RRTjdNbDliSWVy?=
 =?utf-8?B?VjZVbGdESC9hYnJQTW1lK0R6cjhvNW5qRWl0VklWc05sR1RsOTdodXNCV3RW?=
 =?utf-8?B?aktyelg1cDVqOExiaC9SR0FEVDNUQW5uRUVlb3hPeC80eXVoV1NGVndhKytt?=
 =?utf-8?B?a0ZkZytlN2V2cVVwcGs5U0pidWlaUUFYLzBmNHMzOUNlUTlkUjZLS0hRaTZw?=
 =?utf-8?B?K045WllydVpzTnpDa1kyRVJWbG9xL2pCOFlFYnFJTWJXS1lhcmFyOXZMRGEy?=
 =?utf-8?B?UEJ2bGc1ZjZRQnVCeGExYTkxeUk0SXpMekxVd28zYWtZUElUQXJTZHo2Snh5?=
 =?utf-8?B?Sjh1ODcrMXhlWWtodFdkOGwzUm5jRUdJZ1BlVE9jU1lUN1lnb29NcXN6TEtl?=
 =?utf-8?B?d2xPaWw4V3lJaW1NQW1seXhueTU2cjBaeklFZGw2elJORlJpSmV1QVM1NWhC?=
 =?utf-8?B?SXNXUkJyeW1oNnhwckpja1BIR1ZiVUYzUTBmRHlLL1dockp2bUFPQWlkVVph?=
 =?utf-8?B?VUVpVnhReVQ5dFRaSlhlTGkxM0VrNnpxeFdpNnQzazE2YlpJZGpuL3pNWGJm?=
 =?utf-8?B?T0JqZzJ6c1VlVUZma0lHYk0yU2phRWZKaEV3RTBFV1VXU1c1V25ob0YzTFV1?=
 =?utf-8?B?RjNXeFBuaVFkS29GR1oxQmpEWFlteHBrcW8rR2FDcHpNS3dBbEluVFJ1cDZT?=
 =?utf-8?B?WWNmZldsbm51bmhENWtJTFp2K2ZIQ2JvUHlnQ0xiMlR0Vml3dTJlQ1F1dXdw?=
 =?utf-8?B?cURXb1pLYTZrTitpajBRY3lPOExJbEZsbzQ2aTM4OVdUcDRTaTIxbFZZbllN?=
 =?utf-8?B?N0EyRGJIdWFoYTRJWGVWa2p4clRybnNLY2o3V1g3YWpVNnlRSHhKdXJLOFZ3?=
 =?utf-8?B?NGp3YWIwWThhdU5nVmd3ZFNGSzVSVUFwUko5emFnaC9pRFV6bUxKRjR1YTA3?=
 =?utf-8?B?bHpQZ09IcEI5RUF6eGViejVYcmZRczZIZmxOdTRRb0NCbWYzTi9wU0lGN20x?=
 =?utf-8?B?eFNpcUJ2R0xCNVhqWUFGcDZldHZyQU1ObEdRZXUvSlJ0Ty9DQmpweEYzUHRD?=
 =?utf-8?B?UUMrVldOd3pwNm4wOHFWbTViNGRZM2ZHYnZsOGdhWVNiTENLcm9JcC90SmlS?=
 =?utf-8?Q?gqaxLsVG3Ydb+3S1KEA9wsmrP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9f87d8-99d4-4474-18ed-08dc70d12ba8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:11:26.4111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtyCIsQ2A0dTgIxdhb86uoH+kRQtEabY3rqz+T1FDyBO0iUWDq/ujbponglSWKh8OAuEPYBwtATtZ3mR//7pTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8065

From: Pengfei Li <pengfei.li_1@nxp.com>

Fractional part of PLL gets lost after re-enabling the PLL. the
MFN can NOT be automatically loaded when doing frac PLL enable/disable,
So when re-enable PLL, configure mfn explicitly.

Fixes: 1b26cb8a77a4 ("clk: imx: support fracn gppll")
Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 44462ab50e51..1becba2b62d0 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -291,6 +291,10 @@ static int clk_fracn_gppll_prepare(struct clk_hw *hw)
 	if (val & POWERUP_MASK)
 		return 0;
 
+	if (pll->flags & CLK_FRACN_GPPLL_FRACN)
+		writel_relaxed(readl_relaxed(pll->base + PLL_NUMERATOR),
+			       pll->base + PLL_NUMERATOR);
+
 	val |= CLKMUX_BYPASS;
 	writel_relaxed(val, pll->base + PLL_CTRL);
 

-- 
2.37.1


