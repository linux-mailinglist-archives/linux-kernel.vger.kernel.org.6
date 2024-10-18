Return-Path: <linux-kernel+bounces-371397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979E99A3A87
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525272839E0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73322201028;
	Fri, 18 Oct 2024 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HiinE3L8"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2088.outbound.protection.outlook.com [40.107.247.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4D8201022;
	Fri, 18 Oct 2024 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245176; cv=fail; b=A/W/n57AxxD4lJFOC2PRirb6iA8YDggtYJvy1on8v2x6SKE+pSY0i9rsQyNe/GGTGS8uhFaI2u3HLEDmt0IJIE+klPbMB1TS6ZVBuEduE6dpcU/SNQGJLpmXN8dUSsZeYsRhJvLKgBC8ERLeqj0nX4hCpfgnAcNmMKRv0YjvDLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245176; c=relaxed/simple;
	bh=YZFP2ut1ozz6BeuzTp96FlzaXbQr4fqELBEGph/16b0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uTNFrpOyc8CJo+mGwcdHGwRam6HnFlDVoBS2F/vAMGwrZpLkUsE8l5qmFI7tQJoavfNsR6PBQyA4ywVyVUkVNE90Dv7lQJsBUadLe0O2Wk+4g9HXnRmUB5OFZ7UM2OZ58CThCYSmO1A1hh2hLzTnoulKir4TlULxghNLNufsEVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HiinE3L8; arc=fail smtp.client-ip=40.107.247.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+DcYc3Y7wPAHJnCmyaIrNUA65vtUSQS7QhDdR8mZYZmhv+1gMgp71QJD+Z/LLf8SM/WswNhrlTtXHIARST+P/2YRuh3Z1OZv1WHJa9xFiMWXjrrsyrs1wsFXrDhbDqD/AXWfanPDxwMycMxGdOMyd5NrhVJhUVdUXntWxMcVwi7XMEHa1qudrAFxT3VwdeWAYv0Ba7s9lm0wUN++G0J5n2qEh5utkl/aaSbYbHKEQePmakf4DmnJ+rz8EBi0Hr+y89mDxO63nOzYL3Jj4dumPpY/lRLdRcZwVAe3+NBcoYhDgi1zK1U5qlIEcsa7ma77zo8quRf9ZRrpY+Ncfkn/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+kcPrphzLGA7BGzbN1UZPB/S9IXEYPjoakvnz0Egv0=;
 b=XL9KuMBL8IQsy8nNkOYBiZ49tp2ytk0jY1ghIqqy0u5v0Wk5i0GHgAa9gwjrEFxIDH39Akx8QZX6YoyqHEUK0yw4Lpueknv1CtiNVVlklLym++af8CWAhVpxSX1ABtHOITco38r/b1LYniiI0uM5N1g8aXGmKlyQJsl5nQrFWBS/IyBtJjxZpl9FBFjrQ9wgeNti/NKXfL6y5Vb8N+R751/WillIGo/lvL3U/PmEty77uLbH6PB29HfCeIcaAQ8Bvs6XzYtkQzmPO72GbmUmRsiSq/w8MA0Ts6rxPBGdrYkC9s0UTksYLFmTllYRZmpdGzh/YW0KznJCm1uwwO8yNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+kcPrphzLGA7BGzbN1UZPB/S9IXEYPjoakvnz0Egv0=;
 b=HiinE3L8YSDl59ZzScWCpuGOlFuUIg3gQcXFirtcjR5tY1AjPKkPVUUdQFE7qUjtUcuwnVFLFvIMEcy0Rh2jVGptn5n9SHIYrp4Jzi9bd+9G1l7gPNf3epKLmwOGNM/EyAI/OCSTI5BXcPdkVojy0HOxysIqar6mvCDGJVmltP8TIrNiUCB21SedSr4Qat+S0/hqFKYQtJMdCqoyO1K8GNpeYiNpgo3Bg7HD1S95+kWCgjhgWeOyxWBWWd5GVAzIu16UoHVvF/jac0eY3h+BaK8DmUfubLk6GtXjMdISgdE4h/ewVJHffqav/VIAwyXPJu8GuVDgLaQqxpGrAVLAuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 09:52:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 09:52:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 18 Oct 2024 18:00:58 +0800
Subject: [PATCH v2 4/4] clk: imx: fracn-gppll: fix pll power up
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-imx-clk-v1-v2-4-92c0b66ca970@nxp.com>
References: <20241018-imx-clk-v1-v2-0-92c0b66ca970@nxp.com>
In-Reply-To: <20241018-imx-clk-v1-v2-0-92c0b66ca970@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Aisheng Dong <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729245675; l=3036;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=84M7E9SFxBK3SAqAyey+G62IZbKKHtL8RhiilZogEI0=;
 b=xlHiWobNppTS/0cbCmCuEwUr+/L3eCAQYme3vG5dICODTaDLGrODTHTveR3ajfiDB6IK1yx+4
 dMR5jtNcE0bA31D2oR+01venJIBsdiN0oypLD9J9f0rXeZtqzSrHOwR
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBAPR04MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: e60789e4-a748-4db4-228c-08dcef5a9d62
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1JiZTJ4aUc5SFVmTTJmMHpQNG9HZUZFKzZ2OCtkcU5kdHNTc216aGp2VmZM?=
 =?utf-8?B?bjVic2tIUzErSHZUaUg3dzBwSENwbEgyV1hRaXFhTEx3RzJtcmF5N0Naazhy?=
 =?utf-8?B?Rk9aVld3VjdBVGdESzAxT1ZodnZLcy9VWS8zUk5LU3kvbXNKNmZXeVBhR1Mw?=
 =?utf-8?B?TkFFZElNdWttV2Y1NjZCMHRUYkY1VnB3ZU03eDdlZHdRNjhSVXE2S2Ixd2ty?=
 =?utf-8?B?S0hPemNBaWpzQllvanpOV0NXVUo4ek9HY2x1V3FEaUdwbThqRFBjenc2dkh5?=
 =?utf-8?B?Z3R6czNVUUJNdjdvRi9GWTA0UEI5NE0rTWlUTndQcmpvTWVPOUhqY3I4ZDZM?=
 =?utf-8?B?VnRWdFZEQmZmQ21TaTdEUE16Vzd0Y3NyV3YrbEJtS3R6VE1UNFFrVWNjL21V?=
 =?utf-8?B?V1dka3h6TXJiY0xOeEdiaHV2UDFETTFmZXpoeE5kOHpTQWxJaUlmY29qL2lS?=
 =?utf-8?B?OStWNks2YVk5MVBTRUMwb3hyczJndVlsOGc5U09MOTc3bHpxZ1ZLeFg3OWEr?=
 =?utf-8?B?c3l0STVLS3NZV2NlbkVPd0hRRGxkMXdLM0FTV0N1RlZvdklac21LemxHa296?=
 =?utf-8?B?TkVUVDR3NGFaa25qTitFaU1mSUFiU29tZlBncXJOeHZuOFdvTnh5ZXEvbk5M?=
 =?utf-8?B?dHViSEx0RlA4N1ZXL1dTMGdRL3FJWWJQRlduVWJDU0tqNGN5eElHcE1ZU0FR?=
 =?utf-8?B?Y3FIWFhqYWV0ckdiVm8rai8zRnhFQk00YVVraDZjUkxQUHUwOFNrbzc5aGxi?=
 =?utf-8?B?UEMvUDh1eGVHem5vODd3NUlnN2dLR0NsbXBtZWNjeFpKTXFhdUVTazlDSHFx?=
 =?utf-8?B?bkJjSEp5Q3dOUkdZUDhQemZpaVQwQkxib1VGZWxQK1F2cGxMQXl0R251L1Rs?=
 =?utf-8?B?V2t6cXBBeFBXZTNvVVppU3gyVE83V1IvM2JrZnZjUnVtVGdwamd5RFFHRU9u?=
 =?utf-8?B?TWsvOTFOZ2NBQS9EOVR5WHM1QVR4dFdnallVZEd4K3RnY3o2TUFybnpOT2h3?=
 =?utf-8?B?RGtubUtrb3U3MXRXUDBkN1RBbjBVQ3R0R0dRaXdEa0dyZzl4c3V2STNqN1Ay?=
 =?utf-8?B?czM2V3dFQklDMWhMSk5uUmc1cnVoWWY2VktSbkpjUXluSGpIS21mem5KMlpI?=
 =?utf-8?B?SGZsd1RTcTVuUGhpcTk4bk8xT0pxak1XcVZQSEdBV1NWK08wanAzL0l2ODJl?=
 =?utf-8?B?eThMVjdnOFdnRmZUdENIYVRkbU9sOTZZaWJSTG9FSVZuQkdwY0U0NnRGRVFx?=
 =?utf-8?B?UWdSTjZtS2FyY1k2YVJNakxmTmVZWGxXcm9HTXA1ZEFSbmhTSWxKU0hMZkVh?=
 =?utf-8?B?dDRHNHVodmtsN0YzSVNsL25XQzIrOFdleTZVRGJoZ084OWFLaXlGSEVHVkl1?=
 =?utf-8?B?Q1l2RzRSVTBHTGhFTnQyUW9QMkh1aFhqQ0FIOWhDSEV1MFo1QzZ3emcrMjd0?=
 =?utf-8?B?QWF1Vm5OUGpXWHQyNUtLZkRoR0FRVFJPcUxPKzZiMFVLTU8vNlRMcjllVzVy?=
 =?utf-8?B?OW5WTUU2U2dtNFNkVWxyTko3UldiN1crWEFxK2FlUTFuWlBic2drQ3ZmMkVR?=
 =?utf-8?B?K1oyeFVya2ZvaGV4V1o3UWpIT3RVNWoyRkdZMXkvdFRPYUJaTzQ2ZFlOV2VF?=
 =?utf-8?B?dkZQM2NZdkVwQ3U1bHhZWjZsUU4yZlg1NDJHUnM1UjMyM2FtUGhjMGdXNHk3?=
 =?utf-8?B?SEk4dlRCUnd4OFJwTGY2OHZBWTNVWTIwdS9aY1RNaUwrRll6Qmw0cHFHekJ1?=
 =?utf-8?B?T0FDOVMvRm9WMm1mMmJtdENnNnU3bmNyWTdQL1RzTktTWkJHaWxKT2Ixc1ZP?=
 =?utf-8?Q?sYG0a2PcN9vyUW8lSlDBZVBlVdRimFqr+7vGs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlJNb08wZEVBSjhvY29tWHBwaXh2Snp2ZmhDb2xZSWdNM3ZmTENMZlJvZ3Z4?=
 =?utf-8?B?azR3OHI0MjI0YkJRaUV2RVlnTXdOSlA5d04wdTBLWHlVZGxLbGxWaFVLUm5H?=
 =?utf-8?B?VEZGbVJvK216Qm9kWG5RTGVWS0xRMStmMDA3MnVnL0tLV1N2U3pJanlEVkcr?=
 =?utf-8?B?WEk4ZXVURG15TzRuWm5GUStybVFneG01S3dpOUZQL0JDL2pOazB4WkRLNCto?=
 =?utf-8?B?Q3VyK0h6UmJFME9wT1BNVHlJc0pCbjl5dDZ1U1R5djd4a09zakhoNkloTTdM?=
 =?utf-8?B?MzlkWTRJYURLSGN2VldQbElGMUZNQkNVYzFYT21nZjliOHdYZkxvNWh0MWtx?=
 =?utf-8?B?TUFoMjkrbkkrVk5qdS81OERtNm5DRWlXZ3NKZmdxR21seVFXRWFCdnJKdDc4?=
 =?utf-8?B?TEVVUDd5b29oT0Q2V0ZFL1puTnVCZld2Z2kvZVl4cGJ2cG85NGVucWwzZ1Jq?=
 =?utf-8?B?eWQvYTdHWjNQTTVka0w3Q3hXSEpTMVMrTVN5K01wQ1pEZXJCU1M5eHVXeW84?=
 =?utf-8?B?aEQ3ZlltVU51cUtBZ3pjaGVQeGpwaWtSbnVla3hmMXRqOU5GNnFtckhzSTQx?=
 =?utf-8?B?WDRVVUZmek51dnlLSUluNVc2M3hQL2VraWNZazkzZnFWcHA2WHBJalpyVDd4?=
 =?utf-8?B?SVdLUC9VajY2RmpOQXVROUwyUG0rMTRnMUVza09LMHdSMURDUUNtZUFBWDJB?=
 =?utf-8?B?MlBaOElmdzR1RDJSSnltb1ZoMHJVeWx4ZktmWVBQcm95UXdTRWxtUmc4ZVcw?=
 =?utf-8?B?T2hyR01sZEcwN3VhaEpUc2txeTg1TEpWWUVJY2NNcTU3ZXExRnRRMWFJeW5h?=
 =?utf-8?B?dXRVelBBbFphWHdYUHVRQUMxcUI3YjJlTWZpaWtJK05XZEVvOWc0aSs3T203?=
 =?utf-8?B?YkpNVk91Y1VveDVwbnhYMjY4RzJyS0UrbFBTZENVMlM0dnJKenRqSFdDYnhD?=
 =?utf-8?B?WjdzSUl6ZWxVYkpIS2N1RENUMkoxZXJ6QWVLSGRZZjlGSzNpRklkV3FqWnVD?=
 =?utf-8?B?S3pVNGRvcXNnWGFMRms2ZzdDa2tVUENHL3R2MXhnNkZPNG5GYXlzTVhhaVV2?=
 =?utf-8?B?SnJoOHJIWC9xZmtDODVjcHdyUXduVkVnQ0tKekdzQ095V3ZEZUFqTmVMZDZZ?=
 =?utf-8?B?aVplOWd1OWJqaWxMVXN5ZktHblRNUXpQWEZOUTN0OXFESkdzcDRtTk81MkdC?=
 =?utf-8?B?K09xeVNSZkI3Wmw5cSt2N2Q0ZVVxZVd0ZEpVd3VMbU9SNzlCQWxnejhlQ25n?=
 =?utf-8?B?WEVzT21lYWFQSklWeld5TFRBS3M1K2hNRFBQUjFrclptbU5nVnowOWVWTmJH?=
 =?utf-8?B?R2pGMG5GYXlJeHU2aHFCWjUvQzRzTmdXZE9zRHhLWHhXc2lXQms1VDY5Y2xI?=
 =?utf-8?B?akt1V0VmbGJWZ1FKWExIVVZUdzhhWjc1VU5ybGhiT2xBRDhCbTJtTktxbGNa?=
 =?utf-8?B?d1BEU012akRyemVBTDV6R3V2RTZOdW9YOGJPYkJkVXlFaThVbmdtbXE0ZFc5?=
 =?utf-8?B?UFBOWTdJeGFmU2YyekMrTVJoWTRuSXNlaUsvNWhLMklKMTY2RkxEWkNZVHp3?=
 =?utf-8?B?dVIrTmtQTlA0NkJqbW5pZXdoUUZIYmR3b2xpVFB3RjVjM0hRWjhVSHNPamNo?=
 =?utf-8?B?czVMRTh0MkMxUXg2R0Y1aERXeGxjdE9UOUJZVC96REs3VUN0RUplaEtKQ1Qv?=
 =?utf-8?B?Qnl3MDlUU2dLdElzSy9RWit3YnY5UzNieHhQdDJVblg4czF5SGZ4emoxWGZX?=
 =?utf-8?B?MjRtZUJhTHVNNXFVNmNBMlFrK3NOUjcyR0VSSWVramNGMjNiTXQzUStZNk5q?=
 =?utf-8?B?eUp4TzVoNGpsNktPcGI4bTFTVm9PeFJUcHF1RUFLV2c0b2J1cEMxb3pveW5N?=
 =?utf-8?B?OHZFcW80b3ZJcFdOaXRDalpJdW9mWTBEenRBbTlrcEZxQVk2Z1RHbUFXV01l?=
 =?utf-8?B?c2hvbWVMQTJORURlZENiY2Q2UGZBM3pEMVlSUGFzZFo2WHlvWkhTQy9kOVRB?=
 =?utf-8?B?c3NLc3AyYnBNektyemdqdGpZczE3Y3F1WFVXUUU0T0lnWkkzQVlaUis0QTd3?=
 =?utf-8?B?SmFHdlI1d3ZKOEpmUWwyTnkzRUVNN3h5bzNVMERPLzBydjIzc0dIV3VkcWhP?=
 =?utf-8?Q?2KlvNhG7YTKLe+p8icH01jgsW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60789e4-a748-4db4-228c-08dcef5a9d62
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 09:52:44.7693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhCTU/4TpMvf0fbmMxCfRwK0VtbIZCNb0aBNZTNPvxy3ZW8OYMv4CdUbKuAMzGUuznCLTLjdKuRk5SUfOwAwAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285

From: Peng Fan <peng.fan@nxp.com>

To i.MX93 which features dual Cortex-A55 cores and DSU, when using
writel_relaxed to write value to PLL registers, the value might be
buffered. To make sure the value has been written into the hardware,
using readl to read back the register could achieve the goal.

current PLL power up flow can be simplified as below:
  1. writel_relaxed to set the PLL POWERUP bit;
  2. readl_poll_timeout to check the PLL lock bit:
     a). timeout = ktime_add_us(ktime_get(), timeout_us);
     b). readl the pll the lock reg;
     c). check if the pll lock bit ready
     d). check if timeout

But in some corner cases, both the write in step 1 and read in
step 2 will be blocked by other bus transaction in the SoC for a
long time, saying the value into real hardware is just before step b).
That means the timeout counting has begins for quite sometime since
step a), but value still not written into real hardware until bus
released just at a point before step b).

Then there maybe chances that the pll lock bit is not ready
when readl done but the timeout happens. readl_poll_timeout will
err return due to timeout. To avoid such unexpected failure,
read back the reg to make sure the write has been done in HW
reg.

So use readl after writel_relaxed to fix the issue.

Since we are here, to avoid udelay to run before writel_relaxed, use
readl before udelay.

Fixes: 1b26cb8a77a4 ("clk: imx: support fracn gppll")
Co-developed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 4749c3e0b7051cf53876664808aa28742f6861f7..85771afd4698ae6a0d8a7e82193301e187049255 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -254,9 +254,11 @@ static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long drate,
 	pll_div = FIELD_PREP(PLL_RDIV_MASK, rate->rdiv) | rate->odiv |
 		FIELD_PREP(PLL_MFI_MASK, rate->mfi);
 	writel_relaxed(pll_div, pll->base + PLL_DIV);
+	readl(pll->base + PLL_DIV);
 	if (pll->flags & CLK_FRACN_GPPLL_FRACN) {
 		writel_relaxed(rate->mfd, pll->base + PLL_DENOMINATOR);
 		writel_relaxed(FIELD_PREP(PLL_MFN_MASK, rate->mfn), pll->base + PLL_NUMERATOR);
+		readl(pll->base + PLL_NUMERATOR);
 	}
 
 	/* Wait for 5us according to fracn mode pll doc */
@@ -265,6 +267,7 @@ static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long drate,
 	/* Enable Powerup */
 	tmp |= POWERUP_MASK;
 	writel_relaxed(tmp, pll->base + PLL_CTRL);
+	readl(pll->base + PLL_CTRL);
 
 	/* Wait Lock */
 	ret = clk_fracn_gppll_wait_lock(pll);
@@ -302,6 +305,7 @@ static int clk_fracn_gppll_prepare(struct clk_hw *hw)
 
 	val |= POWERUP_MASK;
 	writel_relaxed(val, pll->base + PLL_CTRL);
+	readl(pll->base + PLL_CTRL);
 
 	ret = clk_fracn_gppll_wait_lock(pll);
 	if (ret)

-- 
2.37.1


