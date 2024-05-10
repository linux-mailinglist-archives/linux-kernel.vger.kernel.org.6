Return-Path: <linux-kernel+bounces-175500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 768038C2078
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2172829AC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8348C1635B8;
	Fri, 10 May 2024 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XGVeI+HP"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2045.outbound.protection.outlook.com [40.107.8.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7BB16F85C;
	Fri, 10 May 2024 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332315; cv=fail; b=GJnK5dnmv+2eQv0SEG8o/MXMKD40aZIar56mkLsJ0giVwHy9fJQfOQwDhlI/ZVcmuue0h5Vd53o/yDFDYDjLJT9hA5vQGAyj7rOXglqhfKUT+LYlk5i5V2F2CfRmalU4ME56c93tYIBMS5Zg0Sf1xmhPZJ7bA548YVJwoCqV/Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332315; c=relaxed/simple;
	bh=nvSam4mK3om9TVz6wuJK2Z7DSK/o6N1d+PGOO/OShvI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dQfO0St/JdT0pH12WyWta543jSohdh4o9NYrd5FmJSg4Kc0kdwsWy7oStVgy0ycy8HOs4AbjWVf/tfoDOcrbVLtPitWsYNiKc/VJPo7ywlRGZuu34Rx0inDnPGGTYrQaF2OF5gHncxsotrX91a0iwha0/IR4EPxDpFzddvej7gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XGVeI+HP; arc=fail smtp.client-ip=40.107.8.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FphXK06iXuYZJgInURNh06p/6j85+z04juU94iJPJV66MQV1quIoQoXgj9MxfFJhqWhSflhe1xYfp2qFlhEk/tvIDV4ehnUxHT0O2f8TJbTlMB5Fwulj8uQTHm//Ko1qyZ3K5b+IZl4czt6GFU3oI2E0haPmL3WnE/OVWsDOfpiEq/rqh6uYOqthoudTc7LSwU5LlU1AS2x53Gzs+rCnpuVqMAE0d2BxjHn0lZsMzigYRiL1NSbkXF+6I/4tdMvNU1gjylSwbxnHjVzw4Mc5mp+57QNF6CEfyf/cAuf/F5bvssujugV+y16LmAcM0kRI2PWYqxSnk6WJF0Va1+mFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usPxMF+abDDxGyg9lU1ffDPQeliZbPP71G7yzsYJVQ8=;
 b=E3LPeYBeUc9PxrKgiG6MIqx44Hpu5nlFJwJYvhIja4GKvoMkSvy+we6Hy1RStJsf/EUJFIG/C51QrJ0735J+a7M4zmAp7wWUpDxWpr99P2cOpfv44MY94OXkLihDOm5zUrl6QV6bmkhR0huvBig9Ua67r/SI7f0sb3kCLGhAaav5fx5KQiMg8NJw9hkMgzFl219vCynLO54qqTeJ6+D8IwymkCQiQ6E4wQkRJq5HaHGMcWq8vZ72xpYrqP71W6kYBXoSYMc345SpkKzMt3r4CTKdMC+oI005PO2+Mc1R2LPRJ4Sm0QRNpemF9y59NlZ3G4LNDN3ZPBU3HmENTW74VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usPxMF+abDDxGyg9lU1ffDPQeliZbPP71G7yzsYJVQ8=;
 b=XGVeI+HPi6vcP2n2UHKyRNZzuzOXwiLR7Z7xkhmfoxHJbTUN6WD8XA+t7h0IBsah7RdFw9fAMPY+sJO9w+A3UGd8fH9yb6nDBrpEaHhJL2O/Mwf5V1KFHMox7KoUSpSE3oBJ2/Uf38sxq1QJN/wZsjYKdQKmk1Nhk7H3oQdAQi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA1PR04MB10399.eurprd04.prod.outlook.com (2603:10a6:102:452::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 09:11:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 09:11:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 10 May 2024 17:19:03 +0800
Subject: [PATCH v2 08/17] clk: imx: imx8mp: fix clock tree update of TF-A
 managed clocks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-imx-clk-v2-8-c998f315d29c@nxp.com>
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
 Zhipeng Wang <zhipeng.wang_1@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715332748; l=2375;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=a0EXy0fZ6h4g3hX/vQwYN1ZZTioQoMQK+mQT/+3QweE=;
 b=XwJxC9OUx2jRhp+GlBmHpmQv4o447U6v4NK8sIdXX6d2Y//GrTvS3y1qyOEtgEX39Bp6XxigC
 aAioSvpPVkdBOQt1FpFdiWFALd8sg1s7fD5y1d6dd2pqfOznDR5xk4O
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA1PR04MB10399:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c19b88-699f-4421-9070-08dc70d139d0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|52116005|7416005|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDN0L2ZNRExuVW51TUtsWkZRUzRGS0orQVp6SXR3dHZXYWZ4b3dCQUVTZjZl?=
 =?utf-8?B?ZGp6ZzJuZHRpb2g5L3FSbWM1d2h3Lyt1LzBEZGcwcEQzTkdSYUVpdjRNdHFE?=
 =?utf-8?B?WGlSMUZpRksrdDExaTRLdjJwZkowdDMxV2ZJckV2bE43cG8xNXBKUmdBbmVG?=
 =?utf-8?B?ZWcyUmdIODFCNVdsREZXZzZVU09xbEZDV0YwQ3Zzb09GakY0VUhUUVJibFp2?=
 =?utf-8?B?WXA1V0xUc0Z5N1hJNTdGWUdHQnhBRkh3T0htdFYrOUk3UGRZK0xXeVVWNTVV?=
 =?utf-8?B?NEd3YVlNc0llWEM4dmpYQzIvdDgvSVBLNm0xMXhCNG9aMU1VRVJ2VTFnc0Ru?=
 =?utf-8?B?bld6T3lmSElTVG5LZ09tU1NZajNlM3dtMVNQV1lZTytlL05SY3IvUTlPbld0?=
 =?utf-8?B?R2RIRFNWOUkvTkdIa3hXc1JqMnZSVlNYTGZGYmRFOVJqNENVQmE5K1ZYRkV5?=
 =?utf-8?B?SDJBcmlCbzRoSTNCWlUrQzlmTmVYM3UxSWl4T2ZiYkhjajdsOUFqdG1qRXdi?=
 =?utf-8?B?Z210bHpobTVXc1JxL1pEUG91Q0xqQW9QY2N2T0lLU1VZVW16eTJrc0E0OThI?=
 =?utf-8?B?ZmxUOUtSYzFLdDFLZ3FBRTllTXdnZXV5V05IWDVrdkdSWktCV2R5SThIQ0sv?=
 =?utf-8?B?MVREVjZCUDErQkpRMFRWN2xaWGxXVWpFT2NGTWVocFhUazdDaXkvdDE4RW1h?=
 =?utf-8?B?dHpWMHlkRGZDeCtBcmN2RVgwUWU0bWNhVUgzalArMXVtK3l3YXR2QlQyY0dP?=
 =?utf-8?B?dTc2aG1sdUcrUGRUaU9ta2FRUWpxVFZvMzM2V05HY1Rla0ZTeXY2OVJtYmR6?=
 =?utf-8?B?V1JTL1I2RFh4MGJhUnErdUg4UStzemRIZ0tQNGpMbk5kUVRST0RIR3k3UFdF?=
 =?utf-8?B?cFVWdUs2ZnM4aDdRT0U1WGVpNVhJdTRwZVpYbHhRa2orUUlXUG9iYk5MTWlh?=
 =?utf-8?B?NkpEeFlmVVZaalpLL05OSHZvQkE4dGtNNlJub3NvZzRJYmpuOGN0RitQWCtV?=
 =?utf-8?B?OVlCeTFMYlV1eFZNTlU1QURaM0RBSC9MbkxIRDlrcVBsc0dLNnozRzhnTkxP?=
 =?utf-8?B?cFZMR05JZkp0d0NydFBrSWxVZWdIYWNyRXJNMDU3dWFDVTNMd0xHTGMzR3ky?=
 =?utf-8?B?dlhYLzg1aGJ2N0hLd2pPdmRXUHpsNFhiME11OW9TaHRlRjNTVVhHSVlpM3Qz?=
 =?utf-8?B?bkpwOGY1eGMrSkpnNHdlbFUvNnJKZEtKdzRlOUJ0YTlsUGd1Wm1WQ1dxSG1U?=
 =?utf-8?B?L3lxYXJkTmlLZHlnTlNyWFBiU05OWFU1SVhYeVBEZlhtZXU2SXNqak5hL1gy?=
 =?utf-8?B?aXpWQjFqZUVBR3JaeHAyaVRkSDA5ZTltZDFwUmdnQVoyWmM5RTU0MXZjWkht?=
 =?utf-8?B?bGxpQUNOR05BMHlFTElCTWdzU3drem1HUHNzdnNGOGJ4V0lPWktycmRnZSs1?=
 =?utf-8?B?SS9yYjd5RzhTcU1pYUpUMGlxT2NGTFE5QU12RUxiTTUzZGtudWhJTUlGWVZa?=
 =?utf-8?B?bTM5cVRWeXJ6TjIvK1J0a2JMWHpvYlNDaVhIWGFNNHA0K2ZrN3lxdEN0YURt?=
 =?utf-8?B?WkE2THlKM0FhUkQ5ZVQyTzBYcWZKNE1acFNqMnVySnhrbG9kTElxRG9KVXJH?=
 =?utf-8?B?elNDaUZqV29xcXBuT2Z5WjAyaXo3SlFpby9sOVVzQWRNUnQza1U1VDExM3lD?=
 =?utf-8?B?YXBLZnBoSG9QeGx1eGlNMTdOYWErMXhJbm9UcDNFcUpQeGIrTm1LU2p1eElE?=
 =?utf-8?B?R3l3NXlBYTFFUU9BNGoveWVoWGMzWmtBdUtWekRjeWVYQnlZdnUwbUV0TWZX?=
 =?utf-8?Q?LRFLchAkA2USJkkQIOUPtIHaL7VrFedTBLea0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(7416005)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEVjck9hV1ZLcHIvSnZnNFNoMUhaSVR2QzNMc3dVTTh6aW05bWlseVZZUWxq?=
 =?utf-8?B?c1VYdTZUaGJWdDJhbG9CNHRwMm1id0J6enNxM1NrSUUrcUtZMEhiM0d4NEdF?=
 =?utf-8?B?ZzNNTnJsNEV5cGQydWdQNWYzUGV4SlpuQ2ozVkowWUdZWmVaV3Q1VkQ0c3Ir?=
 =?utf-8?B?YVJwUEJQT2pFOUxqOGlhVmNYb2c2VnVxVmhOQ0trWU1WMmJyZU9ZRUQ4OXJG?=
 =?utf-8?B?V0N2b241N0ExWjRIMUV3TklFTWhRVFN2QTFzaHdMVWNDK0d0cXdSQnRkb2dk?=
 =?utf-8?B?Wm1FQXh3UkRNSDN3YVNjY1hFdms2Ym12clRnNElwMUF1Zk9FZzF1ZXNCUGNL?=
 =?utf-8?B?dkFWcUQyRWlUdWxSc29XdWxnRFRLdGZ0aW5JNVVIeWp3NjFVWWJsb29GRVJa?=
 =?utf-8?B?OWFCNklTN2pnRTdhVUdHVlFYOXRDMGxWcUFBN0w0KzZOUnM0U1lVbGxsWENr?=
 =?utf-8?B?RVhFT2xyL1RVRmkrSTJscm43bTZJVG1KQUhmMjI4dHB1dHRsaHR2YzFhNnpu?=
 =?utf-8?B?MlFkYnNSMGpRdlVMV3pDSVlOUGU0MStYdS8zSEd5Sis2WGYxVlRidVE2c1Iz?=
 =?utf-8?B?OWNhM1lKNUROTzdwUkNwVkxVeGdrNW55M3ROcVppUnlzblY0ZGdRQ0cvMUdz?=
 =?utf-8?B?dlFtdU9EN0tQNnNralFVVDF1TmovbC9DR1FWY0ZKREgzaFE5UXdsc3FlZjg2?=
 =?utf-8?B?UUlBaC9mZHQ3R1FsdkpWdi81cU9YUUxCb3UvZzRnTU9iT0REbmIvUTQ0eFlU?=
 =?utf-8?B?cE5URStxYXA5ZDdDTk81UU9QTzRLZkxvRnQ4MGpiK1k3RkoyZk8vbGk2MHJx?=
 =?utf-8?B?RFFFa01SZHBxS3N5eGtBdWFZekErdldnc2FqeGhHU1o5c3oxdGdQWVpLdDVt?=
 =?utf-8?B?UFprYlhieDFPTUpSTkxnLzVmamNlTHZQbFNYYWsybVd6dGIvLzF0TjZIR05u?=
 =?utf-8?B?N2tOSW5nMUJSbmhzcUhCT0M1c3c0YUhoeDEvTlNYWkNveitPU2ZIanllUDhs?=
 =?utf-8?B?UGpWbE40cHJqR0N4czM0djB0MWliS1hYcnM1ejFhTzlhZHBCL0E3NDQySHpm?=
 =?utf-8?B?aU1vdTBjcEJlczBmckpld2JqbW1FdndaaUhONEVMRDluRGY3NGhETmFuaS9E?=
 =?utf-8?B?ckVvb0VQU3BpN3U3SVFkYXZGZzlYelg2Q2dtdGJLTlZsT1FvYzNpTkNQdDJw?=
 =?utf-8?B?Y0VKcEtmQmtpVnFaRlpXb3J4Vy9NVVpvUDA5VldQSU9hZExpa0tLamk0Ujdh?=
 =?utf-8?B?bUhaOTFHTXlCc2R0TFdLZTdsM2FUV052RGZQM2VPYmFHUzJZZWp0TCsrMTRH?=
 =?utf-8?B?UjI2SEZhOFFhelBQaXVEengvQnNKQU5RemxteVJDZWVTcncrWVRwVlhiMFMw?=
 =?utf-8?B?YWpWMnZ6V2pCWjZVMXJyWGpzcE5HYSsrZDE5dUg0TU5LOFFFWlpuMkRwNS9Q?=
 =?utf-8?B?MkhxM1NmZjhyU2lpRE9jNDlDalhoaVJaMWtVUnI1UzJoVGd0Z1lmcnMvR1N1?=
 =?utf-8?B?bkFTVHViT1ZGSTJSVlk5WnZHelJVOEhrR3NpUDV4SkZjM3J1VWdqU3NyKzBT?=
 =?utf-8?B?WCt2NEFxTW95aXJYTkxPRkZRb2MvQ3UwdENqUXJYS2dnL2VCNkZSaWgzYk9n?=
 =?utf-8?B?aTJaUVZOdzNrWXpZMnJNemlnd2NNd0FQdHEzV1FOMFNkd2l3bERpYkRXalpH?=
 =?utf-8?B?R1pZMEpqVzNNNk5yd2pGeHJFNlhkaDlOQU5uOUYxckxsUnh0bCttZGxnTnls?=
 =?utf-8?B?T0JDcUZONk9FMlJBekRUamEzeU9nb3lpTjVsczlMeTQxblVkWjVHek1JYVQx?=
 =?utf-8?B?aldvQ3YxTVc2NFd3aDNlankyYjFtNDYyYmxmNHQ1NW1ibWJXTkY2ckhBQk0r?=
 =?utf-8?B?aWMvZk1qZkJqRlVVV0hrbmtBQVR1aXMrTnk4M2kyQ0VRNHV1Wm9ObmpBUmMv?=
 =?utf-8?B?elhwUkM4bFhvVkRiajA1WHpqSWlwOGEvSS9yemh6K2V5d0FzVWphYkJOa0lz?=
 =?utf-8?B?OVQyMnBhVHNJNXJDaFhNak5PWkVhbU9PSWNhU1lJYTZ3bUc4a0J2b0ZYblgv?=
 =?utf-8?B?TzBMVGI5RytMRFdmTmh2bXpjUllGODVnaWdkSVVpQTg1M0ZDK3NicXU0SEJh?=
 =?utf-8?Q?riBDntCxw8mvrxhBNKBlzjUlt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c19b88-699f-4421-9070-08dc70d139d0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:11:50.1832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x94WhFat2nc0WGnjTBU2GwZHxMCZGZQK3e6SHrnT3fnc9Px7nY9pMtJchtDS2RJcFpP0Xw+zt+pE+4EeZlFJNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10399

From: Zhipeng Wang <zhipeng.wang_1@nxp.com>

On the i.MX8M*, the TF-A exposes a SiP (Silicon Provider) service
for DDR frequency scaling. The imx8m-ddrc-devfreq driver calls the
SiP and then does clk_set_parent on the DDR muxes to synchronize
the clock tree.

since commit 936c383673b9 ("clk: imx: fix composite peripheral flags"),
these TF-A managed muxes have SET_PARENT_GATE set, which results
in imx8m-ddrc-devfreq's clk_set_parent after SiP failing with -EBUSY:

clk_set_parent(dram_apb_src, sys1_pll_40m);(busfreq-imx8mq.c)

This is safe to do, because updating the Linux clock tree to reflect
reality will always be glitch-free.

commit 926bf91248dd
("clk: imx8m: fix clock tree update of TF-A managed clocks") adds this
method and enables 8mm, 8mn and 8mq. i.MX8MP also needs it.

Another reason to this patch is that powersave image BT music
requires dram to be 400MTS, so clk_set_parent(dram_alt_src,
sys1_pll_800m); is required. Without this patch, it will not succeed.

Fixes: 936c383673b9 ("clk: imx: fix composite peripheral flags")
Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 670aa2bab301..e561ff7b135f 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -551,8 +551,8 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	hws[IMX8MP_CLK_IPG_ROOT] = imx_clk_hw_divider2("ipg_root", "ahb_root", ccm_base + 0x9080, 0, 1);
 
-	hws[IMX8MP_CLK_DRAM_ALT] = imx8m_clk_hw_composite("dram_alt", imx8mp_dram_alt_sels, ccm_base + 0xa000);
-	hws[IMX8MP_CLK_DRAM_APB] = imx8m_clk_hw_composite_critical("dram_apb", imx8mp_dram_apb_sels, ccm_base + 0xa080);
+	hws[IMX8MP_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mp_dram_alt_sels, ccm_base + 0xa000);
+	hws[IMX8MP_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mp_dram_apb_sels, ccm_base + 0xa080);
 	hws[IMX8MP_CLK_VPU_G1] = imx8m_clk_hw_composite("vpu_g1", imx8mp_vpu_g1_sels, ccm_base + 0xa100);
 	hws[IMX8MP_CLK_VPU_G2] = imx8m_clk_hw_composite("vpu_g2", imx8mp_vpu_g2_sels, ccm_base + 0xa180);
 	hws[IMX8MP_CLK_CAN1] = imx8m_clk_hw_composite("can1", imx8mp_can1_sels, ccm_base + 0xa200);

-- 
2.37.1


