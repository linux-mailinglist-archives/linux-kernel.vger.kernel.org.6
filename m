Return-Path: <linux-kernel+bounces-175494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3222A8C206C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C941F20FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FEF16D32D;
	Fri, 10 May 2024 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IX4kXX39"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D1E16D31E;
	Fri, 10 May 2024 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332285; cv=fail; b=afgy3QCuBhyQdhZiqcHJbAjsCuhhYeIDLJleDmeZy4BJdtpWaQXDe1yyEIQmhulWzMsgyY20PjmMKaNnDqevqbVQJ9QrrgciETmsZr4E/NoAXzpZbwbgouhtfLvW7Z4441nOlb/iEN8awXx9TXLGrFvrbC+ulJwN0LtqXqkt1Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332285; c=relaxed/simple;
	bh=q1A0+hU7W4e/wLAiXmKNBgA/x/XkBiviRb5Vkelujko=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oQpIo3h9EZNPSi7NOl6mRiZuxBbuDVtBnI5e0GonDtqD8UqsKqsWl3BmI79120CpNpVYWEZNGhEPQlm8B9+3zWQHgqRuolpZg297ZFa3pLUbD539YBGEbww1v8GGaPiBjsIplFBO7n3etWBv/P0wzkpPBoz0UFAI9Jy5Cx6DOsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=IX4kXX39; arc=fail smtp.client-ip=40.107.241.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCsUfQsa8rJH/JKf4GsW9WLxdK7jzgkbol8VFBP9lqcHSa2Wln2fV5S/avW9GmhQBPJRJrr7R9dx48Psm97ijV1WFW8R+KdgwTI48GYm44XjIOZIZoFdTtB27So2vW/owmF3npSm5ht4eMttqYv5tok3+l2lLDhy8uABxbBCMYG2OLt4Kvta0o558+OccAlOgl9MwvPfpOsuE41uglJzn42E9zw0j9bWvvP7csF/hJTK6a0rwkzTzH1Ive96t1mJnQVhaD/d+QeFLeBdeHHuhaniPeb2X3ZAE9lNXwdnbxzyc9Ykhiw1RrsYSvrEHC7u9Xyb74UpPoM4+By5UcyiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IV//EdgGByvRtKbvLoHynbxEW/SMWswnYjQkG4VShQ=;
 b=UnRYpQRRyg0O7icj+2ntO4J1TTTTd6gEhebTGRGGSLuy+q/qJSolti6Tx8CyndZfSUqY2JPLhDQv/4O47aO/tuFe7xF2U4h0MB32Np5YT1U5btNuunD3IwhMr7b3BILR66ANYCImr7NZCGnwXelmNRz6nMn0bExahz7MTqjfxcEg5Ui4Az6JXSOvk2sQNUqAuDfB93IHcytF9Kn9e2gXIeAfKmZN0z2zBdetgqEQO0RcZCTyovywN/3sIM+hhOdmtaKDpmoucFVHS/iMZY1DrjqBlcvIrNb64A8hXJJXkxt6KpKuXc418lXUDBie2A+CqzZ8lmzSjPabiacgqCCRTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IV//EdgGByvRtKbvLoHynbxEW/SMWswnYjQkG4VShQ=;
 b=IX4kXX39KdazVCeRZH9MuUUl82FFOoPcVhNWgIrjBSUxz8wKUsIqNGrOEn5A/TFDdlQ54Fzea53KGqzLHmcmsoUDy0c8neKULahD7jyn7sPQOCSCOWorHe41xYuiUlTCKtMNMBv3q0ldVLZAAgUs4F2I8EP7Xe02Oxm2yjx+vog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8065.eurprd04.prod.outlook.com (2603:10a6:20b:3ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 09:11:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 09:11:20 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 10 May 2024 17:18:58 +0800
Subject: [PATCH v2 03/17] clk: imx: composite-7ulp: Check the PCC present
 bit
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-imx-clk-v2-3-c998f315d29c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715332748; l=1147;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=/EJNZA8jzAtJukHgOj2MT46tK7VZuwWKGrAynGdc6BY=;
 b=BhoYzWzem12RyUlfKIjN1K4C3wb0zCgV1enXgWI10eziSlgjuC0tKyCCVvapVqZBFkW5yxXnH
 8eFKXY3BvJyBwIo37YbCjpGdsjoXEvP0BEv/AhMPjF+2BJA5gA8qPTP
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
X-MS-Office365-Filtering-Correlation-Id: b417e008-c4c2-4fe0-e9f5-08dc70d12837
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|1800799015|376005|7416005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkkrbGtxSlQ2RWtCaEFVMkc5RDRnVjVUMG8yekJUUUJ1L2d3WjJBVjM4VjJr?=
 =?utf-8?B?NHcwRWVackZmc0g5dkNKRng2bkRwZFlVTFI0ZVo1TTYwVzIwU2d6QWg4aXFB?=
 =?utf-8?B?VWgxNXBFOUZjdC85ZTdJakc5UDFhTEhqbFpZZ1RMdkxRaHF6NnVOZ2w5ZzB1?=
 =?utf-8?B?NkczM25LdnRBMDc0ZnUvd0hLUU1ITE9Fdmt1RWpjVGpIdTRybWNabWlKVi9W?=
 =?utf-8?B?U29KTmFzOXN5ek5PSzgwcGlqb2EzSFRCcVdJSEFQclVjOFhHTkFZekFxTi9Z?=
 =?utf-8?B?TkFpcmpHaWlDdWJvTzlwTE9vZ3N6QVV6MjRqNFRpaHVqbEJESjJCaGdTazVB?=
 =?utf-8?B?dmYzclozUm0xelQ0UlhaY2pvcktDNGh6dkhsbXNMNFVsRzljcE1lMWs0OXRW?=
 =?utf-8?B?Qy83Z0VHWTF1dllqcUdoZHRYajdqNDFNK0RPOEE5ckljeVJ6UzY4TUJzMVU1?=
 =?utf-8?B?cnVwVWI2MWI5dHNGdlRYVmw2RStUaWZVbVFLZTRvdjYyUGxhOE9CWmZ6d3lF?=
 =?utf-8?B?citjR3FPYVhGMnpLY2loNTNpOFVzWXFzMVVxdFpnK3BWZWhrUXhlN3RTalBh?=
 =?utf-8?B?VU8xTmVTRGtGdStmTGJBemdKV1ErTStuWm9YdjJiamp0dnIreE5RN24rdXpH?=
 =?utf-8?B?ZldBNHNLYkFQRTVRYjloeEhkZ25uaTZnYzY2bTVZRDRJNksrQUV4dmQzR0Iw?=
 =?utf-8?B?RUlUMmp3ZHpYaXlhQlRqSjZtaC9vcExmcmlNa2R1RGdETmVHNUFYYVV3Ui9G?=
 =?utf-8?B?TEt4bU9UZStQajhHa01MRjBwUVVlQ01vaEkyS2RvbHhwQkpiSzlCNGxCYTZ5?=
 =?utf-8?B?MkJGNGVGci9GWTZ1bTVKS29TazJlaGpWZktscmhwd1pCSGZxTURlRzJkQVlY?=
 =?utf-8?B?TVhQQlVqSGx1djJQR2hqNFBPaklyc2VubkVxUWhLb3Rkakdlb2RiMGUzYzZu?=
 =?utf-8?B?bFI1K09Hazc1THF4VDdCTUlva0JhbkNKTWdZVW0zckNuMEtnWTRRRTU3eVU2?=
 =?utf-8?B?djJlYWd6bk8yUWlhTGlPK2dsR2ZMUFpnTEtWa1FjV1pNcXNOaFEwNXZkOUJ6?=
 =?utf-8?B?RXJ3dE5wbmt5NTlSY0FjbDR2ZEE1dFlHOU9UejFHKzd1anNuY0VoZFJUc29L?=
 =?utf-8?B?Zk5QNFQrSmc0RnA0My9iWkp5eHQ1UlFQRlZHZ3pmK1dEWnJkV3Z0ODlyK2dv?=
 =?utf-8?B?em1PV1lubXZhQzV1NjNUQndoZGFCNE1ISkU5cFIyVERzZ2lmbDhKZzJsM2gx?=
 =?utf-8?B?RXBycFFuMDJXb1pROS8vWlhEY2YyMVRlS21VSjZPQlY3U2E0NG9yK01ta1Jy?=
 =?utf-8?B?YlJneEZsUGhaVHNCaStlUm1yd0FzZDZHMmkxRFFabnZpMmFOcWVaMUxZb0p0?=
 =?utf-8?B?OEM3TEFhVE52UW9kRmxCSnpKdzFBa0x6YWNBd3JPRDBJRVJJWW8zNWdLZEYv?=
 =?utf-8?B?bVFKMlR2T0R4TUhTbnBpMUVEaXFjV0JkNUpxcG5lYkFvMk5ERE5zUHZZRmlq?=
 =?utf-8?B?SmN1QUk4QXpvejhISlF4QnBrdHk1Y2F0TEt1eVRiMzQvbGN6eEpVdmt6bk5H?=
 =?utf-8?B?V3U4Qkw3RHNpSkpWWjRkNkNaRWZld1UwTTZ6NHlSQ25IWldpbFQvSnFxdEpU?=
 =?utf-8?B?OU9tME9LbXNzTVN6WnJCR3dKdGtBeEdVRnhyQU41Y055SFVlUDBhRnVwNExy?=
 =?utf-8?B?c3hxOXg2eVo5RUZGNC9RcEJ2Q3JVWnBJTDRTRFgzUFhlUEpjR0ZIQ2kzRkVr?=
 =?utf-8?B?ZGp0RUVHWnJlSEZ4WDkwemd1WmsxSVcwM1lsc3dCY3BRVk9CQlVHR05VYmgr?=
 =?utf-8?Q?7zaIDR4v5pz2ZIjWv/ouimwkMj2wrHptGNK+A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE9aeFVWYkVuMldxTWIxbXUwN2ZxQXBHRU5zbldWQ1VHcmdiajgvZmVDQ0lI?=
 =?utf-8?B?blc0YzRQZWFtZFpHdnVlaXVUOERVNWdCdjRNVWRVUW9ocitrc2dMcHU3OHd0?=
 =?utf-8?B?eVRXYmwrUmxmdGJmdW5uejZUUnE1M2hhQ25PL2g0cXJUMWdsMTl0anZNNk04?=
 =?utf-8?B?Q2xwNnhCYk9SRHdhSzJvdkhLUlRSUThIUSs2QkUxSTEzOEtsaXBTUm8rYUdS?=
 =?utf-8?B?blpFOVpVRFBNZkt3TC92SVRDUm96WE5JUlRZeExyZUYwdStidGdpajlINEtD?=
 =?utf-8?B?cHA1QVhlYmNtdUpFUi9PYkVjYWk1YmZ0emszWGNzR29Na3VjcTZERk8rQzhL?=
 =?utf-8?B?eEV4bnN5NVh0OVlubWJJS3lIUG9RY2RFOEQrYWFld05HWnBJUTV4YzVqUldZ?=
 =?utf-8?B?dWdnSU10K0Q2YUVKMndnYlhCT0ZVOXdIeXBnMVRYYXpacTJjK0pPdEUvK2pZ?=
 =?utf-8?B?K0lZYjhoN3ZwbUQ0a1lmeHNxcE1PY2tyWDNkU0tXY29yOU5hc2hrZzd0Tlcv?=
 =?utf-8?B?OXIzQ2Y1RkRYd2dkMzNxbUY5bWxpV05JeGwzdllvbjdjY0JPTUc2b2QzdGEx?=
 =?utf-8?B?VzF2VGdsSVBWOGxmZFFMY0tHbE5VNlpNKzJhLzVGaWpCTmNubUNMTTFmdFFO?=
 =?utf-8?B?enJSVE1yT2FSd1JNQnI1czl3bGJFUEdoazc4RzhqcUFETWQ4THh4OXpiMFg1?=
 =?utf-8?B?dmFPYXNNY3FmVjJaclBVcE1SL0ZhWTE2QWd0RDlzZFZsSFY0eE85NVNodjBj?=
 =?utf-8?B?UW5mU01GSWNkKy9hRlRoQ2tnTlAvOWt4anRLK1lWLy83U1hFMmlQUkgrc05B?=
 =?utf-8?B?blpRT0JNdVMyLzFzYlJWaDczcTFTa2lkNWg2dFpZdWNpUDBCbkZXQ1gya1lD?=
 =?utf-8?B?TWtNRFM2Y2FobGFhSEVNVEQveGlucXMwNmh1QzRsN05WNDcrcDNwUW83ZVB2?=
 =?utf-8?B?Um92ekpERThIZlpLYWJNc1BkMHRjKzJadUl1aFYra0VwdnJubUZ0YUhSQU5a?=
 =?utf-8?B?TU9ZTC9pZUxCREpQZjJSWDNIODR6ZGtuMWJpR1Z3dGZIY2NVVlZKZzg1VitY?=
 =?utf-8?B?RXdqVXdyNXdncTE0Z0d0TzBqckRrZDdWdWVXQ2FCNDJ6UTVIaXlqbnl6UFVp?=
 =?utf-8?B?eWlKbGdqT0I4T0EzdWN1Mm8wcnRMQkUvOHZlTXZvUHVLejlBUWhYOXZzWXRH?=
 =?utf-8?B?cUczK2k4L0J3dTdrV0VXYlh1b085L0NZalh0UEFJNjJTUDhiYmRwL0d3L3U3?=
 =?utf-8?B?MFoxWGZURHZySkNzVmRyZGtCbzNXL0llekx2QVYwdjhIbEZXa041akVEU3Rq?=
 =?utf-8?B?VkY0VUZqZjF3bjVYUUR0V1NiN1BhMzIwZEcvWXpLOG9ZNFU3ZldhbEJLdHFw?=
 =?utf-8?B?VHZOdjJFU2srVXJmdmJpeDk3NzdGRmwzZ0tOZ00rc2lHYW1wQ2VPQkNRZ2V0?=
 =?utf-8?B?dlZrSkE3bTBYUlpuV0I5T3dGU1F2eWZ5SGdqNk9EcXVTbC93RnEzSmFRWG9K?=
 =?utf-8?B?QmpIbWxRL3FBZ1hlMldPa3VkZndpNjQxUmZuOGxzRWIwdGo5OThRQlg4aEd3?=
 =?utf-8?B?YVJGQ3Zkci82SEt1TkxFSzcxeU1sSEEyY2hqWEJ3Ulp4WkxNVE1XaDZ6Q1p6?=
 =?utf-8?B?SS8yam1LL2ZFaXJsM2xVL0FCSy9DV2xiVEpFZktjY25DV3pvd3lZa3FnVjdK?=
 =?utf-8?B?ZEVwNlNIQlVxcHdybkliZlZTbnlydGtGSGZ0M29DOGMwaXhKcW5pREYzaTN1?=
 =?utf-8?B?N0V1YlhoZG0xZTNBZWowLzBCVFF0VjhlR0cvelJvUDZqZXpaNWVodXhORkNV?=
 =?utf-8?B?QWxQZGhLRDZwNzBsZHFsbEsxTnFCK3RZY3g1SHc0bzlmWWErQ0V1OU1aeTNU?=
 =?utf-8?B?cEJQZ29hcGk5VkJSNTltR1NNeG1EV2JpaG5IWWJxVGJlUVdZUmpVb0hnZFZI?=
 =?utf-8?B?aVlsc1MwUWtaZlZqSVhxWVA2NFllZXg2Ly95ZkZuRy9kYlpFaTV0RmRhQTdm?=
 =?utf-8?B?YjF1S3FtQmRadDZ1ZzdROTYrc1JRUDVWQlBNa3M5TjE2WEF4SzR5RXYvMUVX?=
 =?utf-8?B?Rk1uVzE2anR5dFUzclpBaGhsL25VUUpHM29aSldESDZxSE5CMisrM1JaVmFm?=
 =?utf-8?Q?/g5++Ck0l6H9KzlbbL5ldo22V?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b417e008-c4c2-4fe0-e9f5-08dc70d12837
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:11:20.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgUNBs82w59an/CsbVdI2FyDCsB2sPB1cDbtzS24AeYwBOIxznMYE5T3WcnlEon9htKVU2Ob5q/LA7EVvp1Uww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8065

From: Ye Li <ye.li@nxp.com>

When some module is disabled by fuse, its PCC PR bit is default 0 and
PCC is not operational. Any write to this PCC will cause SError.

Fixes: b40ba8065347 ("clk: imx: Update the compsite driver to support imx8ulp")
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-7ulp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/imx/clk-composite-7ulp.c b/drivers/clk/imx/clk-composite-7ulp.c
index e208ddc51133..e70a03e7299c 100644
--- a/drivers/clk/imx/clk-composite-7ulp.c
+++ b/drivers/clk/imx/clk-composite-7ulp.c
@@ -14,6 +14,7 @@
 #include "../clk-fractional-divider.h"
 #include "clk.h"
 
+#define PCG_PR_MASK		BIT(31)
 #define PCG_PCS_SHIFT	24
 #define PCG_PCS_MASK	0x7
 #define PCG_CGC_SHIFT	30
@@ -78,6 +79,10 @@ static struct clk_hw *imx_ulp_clk_hw_composite(const char *name,
 	struct clk_hw *hw;
 	u32 val;
 
+	val = readl(reg);
+	if (!(val & PCG_PR_MASK))
+		return ERR_PTR(-ENODEV);
+
 	if (mux_present) {
 		mux = kzalloc(sizeof(*mux), GFP_KERNEL);
 		if (!mux)

-- 
2.37.1


