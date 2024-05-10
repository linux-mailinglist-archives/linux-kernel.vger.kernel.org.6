Return-Path: <linux-kernel+bounces-175504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5968C2084
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B85C283438
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610A517084C;
	Fri, 10 May 2024 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="E/1Dy61j"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2055.outbound.protection.outlook.com [40.107.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C091170850;
	Fri, 10 May 2024 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332345; cv=fail; b=HLH2rxOkPmj2yqFqxHjNFjvyJP19QbrG41RFyEEhIEL/VZDKw8lHFBMmaW/TjaDF9ORT1xSUYExYnpliZ5sqlT4TdISMbtWsbyK6WUe9G/ewBUq2iFTVmEcAx9errfL7m6U8hLxrCgFeIfkimtNWzOjJ3U4UanNmv2cOMJOICX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332345; c=relaxed/simple;
	bh=dNAJjUOvWj4gorUyU/vJ5YGaC6ol01WXuVkktew2KDo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sytuVGhEdEqPZCGwE0aJzLRSMvMYigFGHsHJSb2D0jcnON+oJrtNWndLhmwlqdzaLiTv35CGq/dmfv7TVdQmxhBJdQEqQctmKhEzwF7qUIBEFrGYWC/Luz3Z7CtbpRdxjAy/wHNrOSbRPRw0MvIGndkzuVPi3wHY9mC1Cbmv9bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=E/1Dy61j; arc=fail smtp.client-ip=40.107.6.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gowi3IAb703pQTlIHKWnlLI/VwxBzgTlnLEmeJQp9YrTsgk+cBzrJdrOk/ZVNhZWh/OXz22EaXtm1XUfti//4NL0DwPDxkDeGdDF/KDS/B89B0tXTuWwIso4o5zGQKIrf4Vf8u5XSYlrJ06dM905YjCHnZoiyAO6sTCSNpw5LrK/epeDUg+4bXo8EVWAUeZJBic8m3W85dSpZaQY2c+n2HmGx0APK01JrFlC1oAzLPxHhJmun1xgunBCqK2WM8N2lpYTRBPYtyBlEthCcBYz0YjYvQ8dj32AfoJnbmT5KccvEc/NekYEZ/5YuCgphxLmmERUik6kclYrkM66nMbLKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxYqLlXJwDglTN2OhR5UoatELjnUAf5TIH6f/O5wCko=;
 b=ZEQWNYwnRtwihFHS3tupaBW+aoNGYsBDCX9zmCgkZKspObOyVAbstH53bvbUwgg+X6JEdnhnOgdg1jWoVk3OgKhf03g1Ftp2FkgA1bDpMfBF8hbxXnaqWinyNxuUNvBIV0uNH553ViSD0JSXW/EvlQftddAkHlYvWwOW0LhcJtUFTooBifRwwsNKMXY653K8qoseNrHdlG9Vg3jQDknlGNKjyvMnIUhEzNp1ANsoeH1D/vh3F1bD0CIr/Z3HYeSPopblrrgvylNrB+EKRATS2cY4RrxcYTzucZmKC3ac6MuyrLSQRYKnfWjWLKZxwq4vmpzP0YNgK3IDVq820RI4RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxYqLlXJwDglTN2OhR5UoatELjnUAf5TIH6f/O5wCko=;
 b=E/1Dy61j10cXtzZ/xTiCK19LbHA2TSBBXdpUSC1CpOVtKyyoBQt3eG0apalNLyARSSCRRNpbQV+tvn6pox0vulSBq0iChjgI2z4NheQEL2+uSPxUIoCHErQ4YMPZ13kar5pvbWgbbty6dGLgmm/k/pDOmQIQrhFutGwIyGmWPJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA1PR04MB10399.eurprd04.prod.outlook.com (2603:10a6:102:452::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 09:12:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 09:12:06 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 10 May 2024 17:19:06 +0800
Subject: [PATCH v2 11/17] clk: imx: imx8mn: add sai7_ipg_clk clock settings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-imx-clk-v2-11-c998f315d29c@nxp.com>
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
 Adrian Alonso <adrian.alonso@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715332748; l=1071;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=WifVIscFAtMHZ5cUN2mG03VXL3S/wRmq7jI1v73ZwVg=;
 b=ZlBuFc1SFDGR91jMFSD7Wcw4eW5eg8/jiUvmjoDyXK6yV9gsgHm8BSf+/7x061IJl0HQQ3RnQ
 3VmstPFIOT/AkBLO1drlGgE7ZEiOVyEj39Ku1Tvb7j2bsN/DG3yBAQY
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
X-MS-Office365-Filtering-Correlation-Id: e7e08fc3-659e-438f-9f56-08dc70d1438d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|52116005|7416005|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWwvRHZhRWY2RzI5OGRLbVdNNHFFQzUrUWY3Nit6cW9WTXJEZmp1ZDUraVVW?=
 =?utf-8?B?RlV3akVpUHBjdUhzM1F2QXMrci93WmVRTTVTeGtiVUhETlZETmhzYjNBK1U4?=
 =?utf-8?B?UHdKcmFTTURSdnQ5SHNHR3lMOERZcWdIVDZ3L1Jpc3diZklldEN4QVRsbmRT?=
 =?utf-8?B?NHlVVlliTGZYS0VpRG5VbHZTd2NBNWdIYXVqZklCeXBLK0ZEZHZBRytSQnJF?=
 =?utf-8?B?UVUxYWUxd1dEV20yR3RXZzM5UmtzTU1rZG4zWXhVdElVRWZ6aCtwdmhPeTF2?=
 =?utf-8?B?cHc5TXpGT3Vqc0xId01mYjlzTWV1emUyVjRud0Mrdk5OYjByTXJlS3N4R2JV?=
 =?utf-8?B?N2xReTl4a1dlem5heWxuR1VNZG1mWms2eTlzMGVhTndUQTJXUWpiNFFHZVBa?=
 =?utf-8?B?czdqYkp0TmtSaGNpREZlaEdEa3g2cWRsd2dRNjFxdG9nWGx6R0diMWxoRjYr?=
 =?utf-8?B?Rno1TWVoYVZNOXpxbHhXRjczRlFqRElpbE45Z0k5R2p6a0dTRU5uVC9GWXR1?=
 =?utf-8?B?SkMzS1VXc2JibTM2QjVpbXJjcURhVERuTHdLS292UGpreVE0dVpjdThkVFV6?=
 =?utf-8?B?Q0VwVjBvQ1N1bUpoL3Zaa3d4bmxFUWF3WkpyenNVeDFyNUIxam5vSG1sdnFh?=
 =?utf-8?B?VmxDUnBPNFIwOWlVQmE0MWFOODhIOTFlREp3c2NNWnVnbDkxZzNGdkZud1Y4?=
 =?utf-8?B?VHc0MXVjUnE1MGNoMVdNQ09FUEs2YlFST243bjhGVmZUVktoWTlGR0NtbENH?=
 =?utf-8?B?dngyKzR5M1Myb3FHek9RTFF2eGxscmxlTVhMSjM5YWl2RzZ0OE9ldXR1QWgv?=
 =?utf-8?B?R0lCL0VVOEhVWHVBMGpHMVJVT2duNStVcG5RN2N0ZlBVaDFlOE9XU1RGT0RU?=
 =?utf-8?B?NWk5OWo3ZWF3MEVhTDBidXBqek9HMkRpeXRPL2ozYWlEZGJsUlhMYUhMeWJh?=
 =?utf-8?B?NVFUaSt5Y1RFanp5MzU1ZG50aThNL0VTOExFbXRNb2h1RklzYVV2eGFzcmhQ?=
 =?utf-8?B?UU1sQ2VZTzN2OENYKzVLNGVORVpwNUowQ0NqZC9ZcC9TL1JMUHBvL2ZOL041?=
 =?utf-8?B?WlF2dFpyaExBTCszZWtMWUoyUlBQa0JIMk1BdnordlE2emNUaWw1MmtadXMz?=
 =?utf-8?B?WGFxYTJxdm1VK1VSUHVhMDRtOHR4VFpxMXlkL1QrSHB5bWYxcU9mYlo5eW10?=
 =?utf-8?B?L0lFY3hmTlRWb0RHekxlcnlVZUg2NW8vMzQwVmxYNnU2eHpMT3Qxam9pRUJQ?=
 =?utf-8?B?RUF0d1BHVHJ1RTYvSDRFcXdqZEdtNmV2WDV5VGEvRk1qbnFOa1lWeTQ0Zmho?=
 =?utf-8?B?cGRGTDZuNllIa2Z1NFNjeGZYVmp1aitoemhWTnE1R3BhWDhIRGRuSTdPdnJZ?=
 =?utf-8?B?K2M2cDh4ckhaa0pLRGxPdUhtRm8vN0t5Tk11bkNvTXRkdjZKbnZ2bm1aUXlM?=
 =?utf-8?B?cDJJb1UwNXI3S0tpZUFSYS9zdGx5M0JYV0dvWnJmOHZCbTJqeEVzU0VCVEVl?=
 =?utf-8?B?K2g3WVhGT3BzUlpWN09zekZhZ3dCWnhGK09NNENPSUVwOGRHbWJJMFNPdUE1?=
 =?utf-8?B?Y2ErOGNUSGhYMjY5VnhiOXdaekNFOGhnVlp0anZKTEZJQ1lybVBRemVkWU9C?=
 =?utf-8?B?UnUwOHJueWhSYmFwODVoY1BIRW8vU3NpQithekFuSmp2bUFXZ1VMdFZHVE8x?=
 =?utf-8?B?WWgvdGlRWmNEWGNYUjhzdEdCWWVaOVlpN2ExdWRFMHFYS2FObjdEd2kyZjdV?=
 =?utf-8?B?SEY4UUkrSG1JRzQvNldHM0J2dEJQOWU4NzZobHpjeVVhdGxhRFlYQUdLME9j?=
 =?utf-8?Q?Qs4pWchxDNdtvbtLhp2piKcLlCRqyrB4qBH/I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(7416005)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmNOT3BZSXRBV29ldU1oTlozc3prUHRoUjJJYldvakNlV05hTzQzdmltOStM?=
 =?utf-8?B?cVdzRVprUEN3UXRNY3hNVTY0ckZKaGlrQXN0ajhhUkwrRkw2R3Bwbk1pN3BL?=
 =?utf-8?B?dGlQM2NjaVpkbzJ0WnFBaWNiRDNaODZXT0FVR1RqbFVxNnVqdXBhSjFOTHQ0?=
 =?utf-8?B?bG9vU1FUb0JmN3k3bjFrNTIwODRheDVQYk9BNzZrTjl4MjdUb1VKb0gxalJE?=
 =?utf-8?B?UjQ0UFEwNzBkS09JMGlEK0dXdVhabVFoenptRjQ3YlUvc1JJK0FWMFJxc05s?=
 =?utf-8?B?YVc2dTBMNjl2Z3BTY0xNT1YzNGJRbE85d3pUTVRpNzhVYTdYQnF3Zi8rbmth?=
 =?utf-8?B?MTBMOWl1UW9SejBhQnN4b2xlb3lXQmNQanh0R0NnYWNiSlE1dkMwRWhJL2FI?=
 =?utf-8?B?V3VKbzI4TG8zK042emV6M3JjRXRlZGQ4b3ZQM2FLZkR0M0NmU0JNb3A0WXFr?=
 =?utf-8?B?VkpqZy80YTNHS0JpYjlzdFdEM3kxRW1hOVlRSVMwWXYzNmVUa040Y1lJclRk?=
 =?utf-8?B?TFVpU2FMYkwzZEJHL0tlaGVOcEt6bElrdUlJTmtydXlSRXh6dlJyeldIKzBl?=
 =?utf-8?B?b2pDODhqVVpBQ2dGU2VDSFo2eVVDaW5tMGRUQUNMUFhmVjk4bkp3RWJHYWl5?=
 =?utf-8?B?aTFmc1pWOERaOUVFK1pIQm5LTDg0MkJNd0w1SFcyQm5LSVZmckt1T1pNN3VH?=
 =?utf-8?B?YWpvT1JDcE53OWZjNytMcERpeDllOXhHUVlEVTF5QWtFL3J6bnR0SUxjWW5q?=
 =?utf-8?B?a0llaUpBY1VFSUdNTmIwcGwvaXltck1hRXNlbXJsS08zOG8vYStObVhVWTVh?=
 =?utf-8?B?TjJXOHRyY0piNy8vUXlOWUJqS1BabFIyWmpLMHgvVVRGRFRNdlpnOVgwdldj?=
 =?utf-8?B?aUt2NEIwTXlFNE4yTzgxWTArNkpxdmxjYkd2Q1lhempqaFBqNUY4bmRyTFQr?=
 =?utf-8?B?eFN6NXRhcjFud1VnTVFYQlFhTy8zeEQ5amRIRTJFRGxXZmN1VGlVWXlzODRM?=
 =?utf-8?B?UUdkTVJoQWRjQk5HanZVZEk0REI1QjBnTFVLRDZOVEplQktBNzlHOVRZYjkx?=
 =?utf-8?B?L1NyVFdYYXJBSUxyZDlFcVZkYzh1RWtkNjkxVnN6QzM0TUxkYjh4dGRLN1lt?=
 =?utf-8?B?WklKOXZlSXd4NjBDL2ZXZ01SWnVndVpJY2tTbC9HNnZtcVZJWFJjN3F0aGlv?=
 =?utf-8?B?Z2NjQWMxdFdVMlBZTThkWURVS1B2dW1SdFUySit4QUFtV1FRQWxud1JCbGl4?=
 =?utf-8?B?aUVsUkhyVll4WTBSV1JTeDBYcFo4eGdaREVwNE1CQ0hXdExObERnU0hyQlFH?=
 =?utf-8?B?aXltbS85WDlLdDRhdndGMUF3R1BodmhHNCtVdU9ka3lMYmNUdk1xUy9NWDlh?=
 =?utf-8?B?WHY5aFJZVkw4ZFl3YkF5QUZqQjI1Q1BxaGNpemNkK1Y5b3AwUHZzRE9HSWpr?=
 =?utf-8?B?RDNlUUhQa1lOL29lVWJWNDEraEJJa2c3ckk0K0RXcmJ5UXMzdTNJMDl1YXNx?=
 =?utf-8?B?aTlVZUZpeG5lOTJyUU5CQTNSaW50eXJRSnBGaU5IbW5lazFFL3hqM1JIQVAz?=
 =?utf-8?B?N2V6YThQUHRRK3dLUUJqTEQxcUIvYXJlOEpGVVJwVGJqeDhGMUI3N0Zkc3JK?=
 =?utf-8?B?amRyOTJvbUFOUlcxdG1wZTRFbVIxeWlNenVvMFZKakNLdmZKalAwc2w5dEhp?=
 =?utf-8?B?M3llcU8vaWRUQmNxNWxObnVBNkZXTVhYeVNyYk91VDRVRVRLVE5mTm1iNEJK?=
 =?utf-8?B?S2lzUkM3TEcwb3k1VnlhQ25HVlRQQkxwanlGY3NTWjdBU3lacGIvWVBHemZJ?=
 =?utf-8?B?QzZvMEhZZ0RLREI0a3BtSGQwWnd2TVUwWjNPRWlJMXJwY3RQYmtkbldwODZo?=
 =?utf-8?B?aFZCZWJYdzIwV2FqTlFjK3VWOGh0aDdCak9MN0gzNklSbTZhY0pJQ1NnSVk1?=
 =?utf-8?B?RHR4ZDAwZkorRTF1TXNid29HdnpNQ1R1cTZHbThTRVNqT1lmVE42akFkRXZ5?=
 =?utf-8?B?Y2xtYTF4SlROUW40eVJEMjZKZjJsZDdVeVduUEZaQXNHemdSZ2hTZnpTWWh3?=
 =?utf-8?B?cUpSU2lReWRTRWtlb1ZUNFl5U241MXRKMkFKS0dGZDJVVnFnVVVCVEIxaW5v?=
 =?utf-8?Q?3rdLV50kDV9OPqFmnJGDU1jF3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e08fc3-659e-438f-9f56-08dc70d1438d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:12:06.5420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: on93hySYpQuK+z8MennEevfBNJ86wJUEZBFIsGeCWTua1d+7y0/sXoQu9pYzV5eDjBzzYi0zJg9iMNCkgrS+oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10399

From: Adrian Alonso <adrian.alonso@nxp.com>

Add IMX8MN_CLK_SAI7_IPG clock entry.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Adrian Alonso <adrian.alonso@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 4bd1ed11353b..ab77e148e70c 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -583,6 +583,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_CLK_SDMA2_ROOT] = imx_clk_hw_gate4("sdma2_clk", "ipg_audio_root", base + 0x43b0, 0);
 	hws[IMX8MN_CLK_SDMA3_ROOT] = imx_clk_hw_gate4("sdma3_clk", "ipg_audio_root", base + 0x45f0, 0);
 	hws[IMX8MN_CLK_SAI7_ROOT] = imx_clk_hw_gate2_shared2("sai7_root_clk", "sai7", base + 0x4650, 0, &share_count_sai7);
+	hws[IMX8MN_CLK_SAI7_IPG] = imx_clk_hw_gate2_shared2("sai7_ipg_clk", "ipg_audio_root", base + 0x4650, 0, &share_count_sai7);
 
 	hws[IMX8MN_CLK_GPT_3M] = imx_clk_hw_fixed_factor("gpt_3m", "osc_24m", 1, 8);
 

-- 
2.37.1


