Return-Path: <linux-kernel+bounces-175490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FE28C2063
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419F31F22CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F561635A0;
	Fri, 10 May 2024 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aUR+dNVz"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2064.outbound.protection.outlook.com [40.107.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E1516087B;
	Fri, 10 May 2024 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332272; cv=fail; b=bLpzrEovM8o9IFw8uiJIITGlWLpYOuYze1mSjLz5TF0nzT4Gd5jzF9zcVKJWFuMTW6xO6R0zi3GWUo9h+pMCJOk65DXUQWMLnhzZicWESIXabpZFNR0aEP6TRYAmvvt7ySyt1UjQpLh1I1ZkbrMdz8GNYvaMs+Pho+yIkium1BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332272; c=relaxed/simple;
	bh=6/uXzMe9ujeP8ExVd72jKCKMGDAeu5lzc8+vYoPu7XU=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=OsAquzYSRGKeNBu58rdjP7CHhLfa6PZVaVB5QuYQrDslJ1YoZqtVyRhDLFd1euYsw3I8CHaH9elabWKjbiwHKc0Tn/a3m+kPh/mryBqr1BoJSjizi4hiqLpd/OWH63yn3pvprsNa4mMLUtwFe+K5AJaqZUpNVMQGDCHgozDhuhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aUR+dNVz; arc=fail smtp.client-ip=40.107.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8+uRgcGbiXULNr24E7eI1/4ZbnwAAGTKbIfmSHgRHA+ZYAitmRbBf6O0UTlM4u7WE4ANoLVG8mx8RcWbU30VGbdKeSMFyG07caWqYvYK3PHfjKO8aq4nujEkXcfydCi1yMmIetBjvnMotGmdfZPHuDhSdn8WB34Gh+YlMB2R3UbOsjLOpNQKgi1fNh2ZzOQhPZkpxSQ7+T5MFAeMvWCcQqDFENQNH8TSqsL2CkpSAKMkPgAFVF/nK+W0qQnHJAXkgSloW5hXGYCPi7WVssueZ6y7jL50w8JvVjM4kb+fryy+lq51n/lduzaQFRDkNTaIQFX2Ggi6t1GnjU4oPDWOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Xr03dJM24GJnBJL0BZl+PxyGfRDkQlPluHxvztgIjc=;
 b=jR2FI3ka6kSVzhapbCmsUfhQBxYnxti/lR51fs/Oc+iCfT/e5RPG3OJ6gnDM6c8iB/DKn32pQXFmeC4MtmjWzDCam+uj35ysNA8ThptxOIl163T+05WuFSLcRKWXWWnMM4pazuzaAf0eNznGL+S+qocNSiT+pXGAv74pwW6TbYwKRZdmyAqnwgkdnPFrC5J+jNsntA4G6IXasognmjcVL1ixGd/qFoylm+9RjUEgOjDDIwo6ovn+SShdK5SqFiCNEsAVDpx9eGwd0SY3NKGaMyeNxxlIChZGmHlazskiFyoQWRWmcg3Ar8Ao3mvzKKQnc6oHDmaaJvlVl3/vMH8CGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Xr03dJM24GJnBJL0BZl+PxyGfRDkQlPluHxvztgIjc=;
 b=aUR+dNVz5N1aTed4QG6Q2Zo+x1k+g8XOK1+Iv6BUUGT+sz60D4GqJg1cVl/bzsUV1KBRDPB4Ny1AKDm7PPUZ+Lyt+NBTPOvmsSGH5HPKVhkMvHKmopMoMV7HrZdyqba0oHUxcZwjJRJA2838HV92Nrb9zCJ61/wR1CqADXc+wWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8065.eurprd04.prod.outlook.com (2603:10a6:20b:3ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 09:11:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 09:11:04 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 00/17] clk: imx: misc update/fix
Date: Fri, 10 May 2024 17:18:55 +0800
Message-Id: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH/mPWYC/z3MSw7CIBSF4a00dywGEOxj5D5MBwjU3mihAUMwD
 XsXm+jwPzn5Nog2oI0wNBsEmzCidzX4oQE9K3e3BE1t4JQLKumJ4JKJfj6IEvJ21rbVTCqo7zX
 YCfMuXcfaM8aXD+8dTuy7/gzxNxIjlExtz6ToeiM7c3F5PWq/wFhK+QCYAqu5nAAAAA==
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
 Chancel Liu <chancel.liu@nxp.com>, Pengfei Li <pengfei.li_1@nxp.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Zhipeng Wang <zhipeng.wang_1@nxp.com>, 
 Adrian Alonso <adrian.alonso@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 "Oliver F. Brown" <oliver.brown@oss.nxp.com>, 
 Robert Chiras <robert.chiras@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715332748; l=2757;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=6/uXzMe9ujeP8ExVd72jKCKMGDAeu5lzc8+vYoPu7XU=;
 b=p9LrtTmXpB16gTcCDLHDo+1i4HEtoe3UoziqVXGii1gTotcS+wyVis3un8x2tSp6tOMWwmdmO
 xBEvrPudLHTDQD3ka8xAvn4RSeC6DpSWWBt3ZgyKd9lCW8q8vYUMfBz
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
X-MS-Office365-Filtering-Correlation-Id: 70808022-cb0f-411b-e814-08dc70d11e47
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|1800799015|376005|7416005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzRIMWVUaEM1V08yZndTUzBVL2VYa2N0UlRzd2ZUT0tGTDM1ZWUwRGV6aUxn?=
 =?utf-8?B?ekJDYzh5aXl1S0FwZU1iT0Q5VmpHNTQxb0pJQUZ0dXVIYnliSmg0STRGVjlw?=
 =?utf-8?B?YjBRblBVMDIwODhieGxjZkhhMlJaR1NwbERPWEZXWWJOTnlzNWJpYVNNUElV?=
 =?utf-8?B?MXpZV294NXBoeXNxMTRYREJzaW1qMUtBRzl5UVlwelo5S2xoZitzTWxKVEZk?=
 =?utf-8?B?YmRoLzc4MjFBakN0azVGVGgzY2dFRGEyb1JGUkk5V0JPK1dlSDRxaVFYWitu?=
 =?utf-8?B?a1VxMmUzanhQOW5GT3d5bHRmUGxreGYycmJTUS9VbVVWLzU0WVlPekh5UXRr?=
 =?utf-8?B?T2ZwUk53dXJ0V0xnWjZ2cHI4S0tnWEg1aHhqUkVobFdCQy9pQjFiUFE1YkxO?=
 =?utf-8?B?S1ZOYTRkTVdDdFR5ZWV1M0dTbyt4djA3VERtWllNWi8vaFl5d1h6ckdvcEhv?=
 =?utf-8?B?bmw0SnJieFg5dmphc05yZ0FjbGM5a2ZiYTR3YlRBUHRlR0VlbTRwdC9QakRK?=
 =?utf-8?B?R2xVY2tVbE5uTDI5ak93QXhReDhtWGc1eDMwWEpHQ2ZXUnVhWGt5Mi9uL3Zi?=
 =?utf-8?B?Zm1FQW9RWG4wWDJYd29JZmxnWjY4QWEvc09EWnRGbUxUb09TelhJQXMvcFB3?=
 =?utf-8?B?UGE3QXFOaHNFOXRLVStjVm10R3dwS1A3QUllVzVmdXNJckZuU3FPbUtrYkQw?=
 =?utf-8?B?bUhrcUgxZExuM1gyNHJ2U3JsZmlsczMvclZHdmVHMUJJRE41eFNnZnhqMjhM?=
 =?utf-8?B?UzdIbjZUSDVwOStqU05xdkRFdVZxM0tPdDZMSHN0TFJMY1FOaTdnYWR6OVpD?=
 =?utf-8?B?eUJLNTlFcW1zNE1DVmtQeXZ1N21IcGxEZ2lXWkEzdEl1b1RObkxlT2lEY1ZM?=
 =?utf-8?B?MGQ4RVY4WFZNbHBFeVV6U3lMeWlnYUh0L3k1b05KTWxuQm1uVWN5dERsQi9q?=
 =?utf-8?B?aWFMekpuOXdzV3hQRFhtSnBLVU5uN3Z1QldXTGRibXNxSFlGSFU3K0Y3NVll?=
 =?utf-8?B?ME85SGMzVUtXNjBlbTl5V0Z2dEdxc0xGdTRzK2lLSTBkM3NNbmxsRnk1V3l4?=
 =?utf-8?B?RnM4YW1DSjBIQXZ2bWV5ZndxbGZEM3R1U1BnVUY4aGxIU1JLcHZVc3l3OW5y?=
 =?utf-8?B?K2FlRlExVXdZZllNRGhvU1JkcEVWak5TK0ZXL0NuT1lWWkROVkVKazB1S3cw?=
 =?utf-8?B?eTNGSmdOQjkwNkJKTDVUTHV6b045VFBObENYeW8wSVMwT2RJbE5KMkRHdUNr?=
 =?utf-8?B?eEppWmYxKzZuU0pSN2FvUUowUGkzUU56cGdtK0pYUnRmL0JaVHYrU0hKZU4r?=
 =?utf-8?B?bCtVb1lCbzlKQURGd2ZHSGpQRGhIYmxiUUtvbFAyLy8wMTU1OWZCcjN6MkdR?=
 =?utf-8?B?dFJRdm1JbU1CcitVVWhoaEp3L1A4NGRFb2hyVlpBRmN6bDVKV0FFWHlDYy9I?=
 =?utf-8?B?a3hsSzNSaVhXTDhxSk1mMFZ3VUxHaUxzUm1BMFRmcTFwdzBlUi9DNEtVRlFu?=
 =?utf-8?B?ekJCVzE3WlFNWXd5ejlDZEZzVWpIdXdUYnJicG81QXdjaTJGdXBwclNEc2hq?=
 =?utf-8?B?bnB2TVlzenhtQmxzcGRSWHVBeDVabkxVekJPaGR3MjRtRFVVbGE4WDQ4TEU1?=
 =?utf-8?B?L2VDazgzMEVoTzMxaUhDWGdodFZLT0lBUXNYZnZrTDNKZkhOLy9iZmR2RXRT?=
 =?utf-8?B?ZGE3YTZVZVZnT3NZYTJvNlBjYStINXpmb2FNNk45eE5COTJNYVdqVFZtYUpW?=
 =?utf-8?Q?Y/n77D5fftoaXZER14=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFhqZkVHMWsvSG9IS1JKM0lZbW1ZS2hjNkhySkx5czFOTUQ1TGtaUEJDNDkx?=
 =?utf-8?B?UTRzU3BRTzJEaGgyTmxRR2RFb0ljUXJWMVltQ0paV1B4MGNQcnJzM0x1WVU4?=
 =?utf-8?B?eVkyR3pjSi9EZy9HNnRPOGI3eGllZlFtdkJYMHNQQnYzQ1RpVktqdFR2Yit1?=
 =?utf-8?B?ZjlPR0hNQ3JLbGFNd3NCaUVGaUgvR2EzOVhaOW5TRjk3SE95VnVydGpqZVNH?=
 =?utf-8?B?azhxeWFHMGdyamdKS2xNaEh6N3NhN1JobzBSd2REMU5XMjN1SE11T2ZrMkht?=
 =?utf-8?B?MUdrWW9aYVNrQVV6RDZTNFpZQUdhUVYwN3lBSlBlWGFMZmEwUjVoeVNYV0Fk?=
 =?utf-8?B?RzB6THpnaDhNWTRiK3UyUVFsMVR0V1BtZWVmQi9lbXZKRXRoNkYvYUF3UG15?=
 =?utf-8?B?QzVGTFZIM0V3ZWxqaG0xd0VsNFlEb3B1Um5qRHFjWVB4V0VtMkNSNytpNW5T?=
 =?utf-8?B?VFdFRWhYMG1VcWt0QkN2SEc4OTNrQkxjRm1OM2hLMjg2R0NxdnVRaFBxNkRu?=
 =?utf-8?B?Y01JeHl3SEZkLyswRHF0Y3FWVHk4OVo0bnlJYkduWHpwRzU5bVRxc1lUT2xj?=
 =?utf-8?B?OXpkUjdGVUJvY1g0RHNHQ3ZlaDYyNXpvZnNjWmhNTHdGRDBERlpwTXFzTi80?=
 =?utf-8?B?VE9wTUdROWhla3NzcHVSclJxUjErZ1kxeUgyYWRHU3R2cnhXWVMyZDhCVmxT?=
 =?utf-8?B?QTk3YmZoNm5qQXh4bnRuZWJXVDlRZWRqdmdLQlpXMWF1aHQwR0VOUFJlUklE?=
 =?utf-8?B?aTB3MElldTFjVUdVT1JHSWpjM3N6Q05IS09OdjU3NE5HcEx2ZVB6bHY5RVZS?=
 =?utf-8?B?S1hRWGRJZUl0SWUvK3VXNE5HeEQrMlNtdEFxektzekE1anhPbm9vWmtCNXNZ?=
 =?utf-8?B?cFA2LzRuNjhWbmFPWmpkSk1LbnByN2sxSjYraFVuZWFnVnFOaGd5RVJPdGxi?=
 =?utf-8?B?VkhaM0hGYWFNRXZZMU13WDZnTmRkYkh1MFRsQ1FUVk9ZWXhBWkw4NUhaeHZX?=
 =?utf-8?B?N28yWnN3V3RKWW9uL2szK2k1a09XRGZ0Z0I5VjV6ZldFVlpYdVFXL09JKzl3?=
 =?utf-8?B?RWhPbklYUzByUkhNcUcvVk5pUkFmMUVwTFlYd1FhSG1HdUxJRkJGYkVYVUF1?=
 =?utf-8?B?TllEWHEvZHdPVldmNGpMWTMySHozeFBLZ2ZWdFE2b1FPVVI0eEErbTI1cis2?=
 =?utf-8?B?Zytzekxta2hKc3FTeEtQaGtMWEUrdHpLeTNaeVZUUWtPMmtyZUl3SVAyNDJ1?=
 =?utf-8?B?SlVmZDU2Ukl0S1VWOERLVXVXWFczbEhjZUo4cmFhUkhROFR5akNxTnBMTFVD?=
 =?utf-8?B?Ui83SVp2dVpnSVcvMVIyMDlEeGtNNU9rbWdnTUxkb2pkdzk3bGNZVHM0Ynlw?=
 =?utf-8?B?bTMvYWl3cHU5YVV0VVI0bWRvMC9ET3FaS0tvY2xEM2ZnVHBLUUgwUlRTc1dx?=
 =?utf-8?B?b1IrWlRnQk1yd1FhOTZMNURCNTRnbWdzc2p6ajJnN2lMcDNrLzUxQjhtdE5i?=
 =?utf-8?B?ajZON0hxOEs2VUtkUWRpNmYxRmtTTDNGNS9aSWtBcUExQ2F6U0syNktFcGU0?=
 =?utf-8?B?eWpBSktVN2Iwa05XZm1SZEhTQ0d0QU9KbFhXdjhpVEJKeGF4WDRFWEhTS2dF?=
 =?utf-8?B?U1IyZTlaWE1weE10UWNxcGZMMTMrS2NjTVlXazFVMDB6L3pLU09HcEk4bmgz?=
 =?utf-8?B?RTlsbm5Nd2s5N3ZUbHdoU3VrandOQTFCMVc2OXBUSjhHM3pLY2pLei9oMUdw?=
 =?utf-8?B?N2c1bkhLZDFpai9xalFFSk1zVlBBdlY3cHM5NXNpVDIxYVprbmRicG1WcUtF?=
 =?utf-8?B?S0UrQS9SK2ljOG5veVBWSkptdVZITEw0azh2UjV1NWRPQUo2VXIxSTlXbWFh?=
 =?utf-8?B?TkVQS1pjU2xjc2htNGVTMmx1Z2o2azRLUXprSnFuM1lieHYxbUw1cGdpa3Bx?=
 =?utf-8?B?YWo3dmVYQkRuUStCenRJb3FZdXk3NkVKTENocks0V3EyWjJVY3ZFMGdYdHlJ?=
 =?utf-8?B?VnlJbmYwUCtBRE1tVndKbjRhTDBQdEtJaXAyVHdGeWJMOE1nMDNNbTJYZ2Qv?=
 =?utf-8?B?WWg3czIzNFdyeHpZTy93Z01NbmNjbWxEaVZkREZUL0t1UEVhWlRqdDNLS2o2?=
 =?utf-8?Q?9KN1jbUF9LllvHRRlJECqVmPT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70808022-cb0f-411b-e814-08dc70d11e47
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:11:04.0104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqcAPZxnS52MY0EMjskmpNGP3a+OFxsjViEweQHkm58RBH9nOpc7FiNZnb388lcukl3UsTzIf140hrOE3UUsGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8065

Upstream several patches landed in NXP downstream repo for some time.
- i.MX8M/93/7ULP composite clk update
- Fix Fracn-gppll MFN got lost
- PLL14xx update
- i.MX8MP DRAM CLK fix
- i.MX8MM/N misc update
- Init i.MX8QXP parent clk before child clk

Downstream tags are kept for the patches got R-b

Although there are a few fixes, non-urgent for 6.9.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Drop "clk: imx: pll14xx: potential integer overflow eliminated by
       casting to u64"
- Add Fixes tag  "clk: imx: imx8mp-audiomix: remove sdma root clock"
- Link to v1: https://lore.kernel.org/r/20240504-imx-clk-v1-0-f7915489d58d@nxp.com

---
Adrian Alonso (1):
      clk: imx: imx8mn: add sai7_ipg_clk clock settings

Jacky Bai (2):
      clk: imx: composite-93: keep root clock on when mcore enabled
      clk: imx: imx8mm: Change the 'nand_usdhc_bus' clock to non-critical one

Oliver F. Brown (1):
      clk: imx: imx8qxp: Add clock muxes for MIPI and PHY ref clocks

Peng Fan (8):
      clk: imx: composite-8m: Enable gate clk with mcore_booted
      clk: imx: imx8mp-audiomix: remove sdma root clock
      clk: imx: Remove CLK_SET_PARENT_GATE for DRAM mux for i.MX7D
      clk: imx: add CLK_SET_RATE_PARENT for lcdif_pixel_src for i.MX7D
      clk: imx: imx8qxp: Add LVDS bypass clocks
      clk: imx: imx8qxp: Register dc0_bypass0_clk before disp clk
      clk: imx: imx8qxp: Parent should be initialized earlier than the clock
      clk: imx: fracn-gppll: update rate table

Pengfei Li (1):
      clk: imx: fracn-gppll: fix fractional part of PLL getting lost

Shengjiu Wang (2):
      clk: imx: pll14xx: Add constraint for fvco frequency
      clk: imx: pll14xx: use rate_table for audio plls

Ye Li (1):
      clk: imx: composite-7ulp: Check the PCC present bit

Zhipeng Wang (1):
      clk: imx: imx8mp: fix clock tree update of TF-A managed clocks

 drivers/clk/imx/clk-composite-7ulp.c  |  5 ++++
 drivers/clk/imx/clk-composite-8m.c    | 53 +++++++++++++++++++++++++++--------
 drivers/clk/imx/clk-composite-93.c    | 15 +++++-----
 drivers/clk/imx/clk-fracn-gppll.c     |  6 ++++
 drivers/clk/imx/clk-imx7d.c           |  6 ++--
 drivers/clk/imx/clk-imx8mm.c          |  2 +-
 drivers/clk/imx/clk-imx8mn.c          |  1 +
 drivers/clk/imx/clk-imx8mp-audiomix.c |  1 -
 drivers/clk/imx/clk-imx8mp.c          |  4 +--
 drivers/clk/imx/clk-imx8qxp.c         | 51 +++++++++++++++++++++------------
 drivers/clk/imx/clk-pll14xx.c         | 19 ++++++++++++-
 11 files changed, 119 insertions(+), 44 deletions(-)
---
base-commit: 9221b2819b8a4196eecf5476d66201be60fbcf29
change-id: 20240503-imx-clk-a45b6ce7c15a

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


