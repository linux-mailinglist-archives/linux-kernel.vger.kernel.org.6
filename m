Return-Path: <linux-kernel+bounces-175496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A048C2070
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06FB51C2126F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F3716E894;
	Fri, 10 May 2024 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BcZW5qUh"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2051.outbound.protection.outlook.com [40.107.241.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7BB1607AF;
	Fri, 10 May 2024 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332296; cv=fail; b=TXlpMs+Jmm3kJE2QAiUZsutKwlS0KuJ548GDkJoYc5BJD1J0pFrfUY9fpelYxkd8by8RdC3wVwzGL33PnFYyEFfrA+Rs0CEk2FNKaniCBcHxW3g/NUBlUcoMypXRbDPsoSMO8K2MVMyV+SRFPw/XRuAgqI27gRg4R2aNHH4sa0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332296; c=relaxed/simple;
	bh=5mmWyK9WwIfkcE/cYuEGrNrZK8Et8RVYnJ0d/vH/OxM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MsRv4OG4slFwgRE9k1JaPYI0EuUNmKIre4KFKCmPatnWOGvSMlTONz9RN2JFi8HRkdWhUY25UQdplic0c6sOmTo4m0KfQ33mXwuoSVkHuG8PhtIaz69OoXb0geMXUxDi8FLJaQKL4q8OUDjXJCswPAbgLCTIZ3NPnq7qUcygadM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BcZW5qUh; arc=fail smtp.client-ip=40.107.241.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+OuN3P0BBnIrff6lqiDPyWOhoRDt4/J9w+7HkFSdccCrO2F5M71HaMcWX4pVTycjddlEyQi3509XQsWavQRnDOck7d+kvyZD0bQHJd0fstbzs/uX8zpcWeKTiXhFnw9ow1/pJJJ6oV7vBgMVIjXsOSNPb2wBxHaObUGGydzbIke6EU4185dlzCUmsvuyhkseBRXNjMuq/i92cBJplGV0+RkRA6JiPefH6Mdcb+0LlXGjvlvr7qyuwY38sZ8dNNJEzUjoUlLHGmtsxthpyObMd1rCB4e1QgooyMAVsYPG2znStbGyj4DeDvQRSxN3i1l8oxlPykvPBmOxBMQ2hsOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3G9L/mbRTXzjXiBgvg8oD625HrvNI8EifS6jYATL6qs=;
 b=B+hdHktKLe5xlxUZVmguc6SlaP3QuQkfifjNcFPUDMFOJiQxSNCoxoTGSHD+WnqoGT/0L4oIkFvGBEhrY2ME9fArbvg2877hJpAREMy5kGKC5Nn0Zk3u7QZNT8CddfxMpT11t252dJwNzMYt6eHWuXuh7exGIaDnGcuHV7OyVeHKB3ofz4qBStNY9/8VpAIMuLEk8pxVCzBKkiahphI+TrdmXzchKYtEDOzmxwfgCWw8Y9yyc8tKlxA3Xxc8Nph9hLZ1blG2qP+jI4z8j2OJxNwSz49csxZBe4Pr6JHlV0UgSYUHTmYC/Tc8OiA4op2NSPmq2+TlNlHPScQh8Ef8WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3G9L/mbRTXzjXiBgvg8oD625HrvNI8EifS6jYATL6qs=;
 b=BcZW5qUhb7WQ005+4dgsM11yLwi3VKn2EUXZacFY4MVKkUP0fpjb+MGPNebjBn/cqniBnSWIwbFyU/NE0asu6mv8mFufJkaFk95lcVk4UX243sb9V54edJ0urDbKcqPodfN9GAcA0gQqpUZuwXZQP0wWhvtPqL1N/u3sCPKC0hg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8065.eurprd04.prod.outlook.com (2603:10a6:20b:3ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 09:11:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 09:11:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 10 May 2024 17:19:00 +0800
Subject: [PATCH v2 05/17] clk: imx: pll14xx: Add constraint for fvco
 frequency
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-imx-clk-v2-5-c998f315d29c@nxp.com>
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
 Shengjiu Wang <shengjiu.wang@nxp.com>, Chancel Liu <chancel.liu@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715332748; l=1882;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ITpMc0XDxQEnK8rIvUINBCDmIwwvJJ8hnlCjcXFS7+o=;
 b=q0d88Htu67xc34l/mjpLo3HWwtnOHtQEvXxjZvI8GYibKsmgKpbaScF+f5VOEdJ/A5pT8NXjB
 CXoOJpxLF5SD3lC4mQn+nEULesH1+nRmS4feTJifclE7+NjGC5lnIbr
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
X-MS-Office365-Filtering-Correlation-Id: f4c0d3e2-1016-48a7-5901-08dc70d12f24
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|1800799015|376005|7416005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWhFeUltK29Bd3V5cmZXQmdQZ3FLZW1YdkxGVFBUb0M5QnF5Z1A3N3NpQisv?=
 =?utf-8?B?Y1N4ai9KMkNHeW40Y0VQMlZJLzRxMURsdkZ4Mkg2RnNOYzF3YkhCSjMxRlhm?=
 =?utf-8?B?ZTRncHk0QUM2Y3NjRUtGWXB4ZkJHR28zMHpXNFcyVTFVZ1R5Nm9nVWl6WmNB?=
 =?utf-8?B?OVFvRElWZnN0YTlpM0l0anlaZjhYVk93dzhvTkRDc2QrZldQSjA0enROeGpm?=
 =?utf-8?B?SDhPTEgvWU9XYlpPWEkxckpQNzI1RUkwenMwZEZiRjhzTTVJdzRGbXk5Wmt3?=
 =?utf-8?B?MUoreTlZd0c4MncrZThFNnlpZDhENTQxRXNFUkdWME1McllMM1hOZnkzTDJM?=
 =?utf-8?B?Rm00VUh0YzJKcmhmS0JOUVluS0R0REpYNStvV2FQUlZKb21JRFc1THV3WUE5?=
 =?utf-8?B?ZkZMOWE2bkRpcDRISHZxdUNjWlRzZWhuT256SFkyaGxvTXRtT21kNmNEdlc3?=
 =?utf-8?B?ZFRodXd4cjZ3ZEFkMTRFck56QkIvOTkwYmN3d0k2MXdUb3BvMFJHSlFueDVu?=
 =?utf-8?B?VWNnZ3d2cGlrZEdKMmRtY2s4OGJOdXZVU0ZCNEJibDlqZU1WOEtuTmhLd0xT?=
 =?utf-8?B?QmVBMW8rMHFoWFN2WXQvLzg5dlhVV3Q1V2JUYzlqWUdwVU1ielJLd2F3VGsw?=
 =?utf-8?B?QVVIVEpGMG4wemtIdDFPdVRCcTV1dWF1WWpSRngrRlBLOUV5SUkzN1ZxQVFB?=
 =?utf-8?B?d0h0K3NOQWtobVNqam5QaVh1L2JQMGJURUFrV0gxT0VYeHVwSVF6QWZYbmsy?=
 =?utf-8?B?VEJuMzlyRUZyNTVNVCt4T3ZYSDRtclF5c0wwSHY3QjBNRmhyTzc4QTNKamRK?=
 =?utf-8?B?a2ZuY1hHTzBNckoxMG9raUhreUpOemFoUTg3dHFNSmVQWWYxdnU2QWVtdnor?=
 =?utf-8?B?d3FPWkthd0ZWZ0ZSU09XL1BvWFlzcHZONjdoUVBtY1JJT0tSS1kwREhWTVNR?=
 =?utf-8?B?TENZTnhxdWsyQlhycVJqY1JEeTdCajA0eW9hUW41MUl4RXFBNSt5SVJ1WGJz?=
 =?utf-8?B?ays3WmJyWjVIK0J5TGU3clZ5bTZlMU9lYUxUVW5EcHFxQ3hVOHk2V3NBR3dE?=
 =?utf-8?B?Yml4eVJFcStsMzRGaFBRS1ZLSmRKMEV3YW1zNjhJbCtkK1NndGRvUk04VkRU?=
 =?utf-8?B?d3lXNUZCUWtSSzc3UXJGSXdZL1kwYTJ3K3U0MzVMR3lEVTRzejJBL2ZxRDRZ?=
 =?utf-8?B?amZ2ZUJvOWdhNkpYS0s1OG96TVlxR3VnSDV6QnZ3anVBN2Y1NFBVZElzd2ow?=
 =?utf-8?B?Z01PQllCcXpteklTSmlkelRuQ3FpQnFXZklqUnhsRUw2ZVFRbGRZNVRXQVU3?=
 =?utf-8?B?RytCbnRRejl4WTFPOWwyQXRjUmpFZ2liWHpwb2U5NGJZeHk1Rmlsbis2Rks5?=
 =?utf-8?B?dUhLT2J5SGZSMlkzUGdhd0JPMDRLVGNkWnNtTFNWbjhsWXZZTCtTeWsvWWd3?=
 =?utf-8?B?UGQzclFSNG9Vak9ha3Z3K3REODg0dE1tQi9iRmxJR1hYTXVzakVjcXUzSXBO?=
 =?utf-8?B?eWxyUFFEYUxSZVh5Qk4zVGtiOWFhQ0JKNmh1SHA0UHJVbUNVUVZZSUxCakFp?=
 =?utf-8?B?Y1VqVC9aRVVkTVp1VFJEclYvUEY2NEViVUJWVGdrTG9tNVM4cUlYd2hmVVJh?=
 =?utf-8?B?LzFvM1BRd0t4Z2VONHVhdG1laU1hSS95c3ZHY0swdkRZZllZOTllU0RXVUhJ?=
 =?utf-8?B?Zis5SjlEQk5RcG1pMktlTXo4SVhmaVVXU3IxdGZHenM1dEt2TXQ2dlJYNkRY?=
 =?utf-8?B?ekhjbTFWME9HcTFvNGxRb0VkWGdlQmloMkRJTHFJZFJNRThuV0ZINjdhOTdW?=
 =?utf-8?Q?gW90EJcu6io5tFoGdH+f4kfsfGIEb0tmpwPxY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnlkVXF5d2hUNGZLZXh5ZWwxRHZPVklOTXRRdUpPLzl0Tkx1NERWanNibVVl?=
 =?utf-8?B?NzZUNmtOQVR3bGlZSFliVzhNRmtESXg4NDBhSnR3YWFDTUdJczFiRmNxWkJC?=
 =?utf-8?B?ZDBsVXVidUFDZEN2M0l4MFF6akZaS2prbi9RZjlvbzV0cXQ2TU8rZXpjTlZs?=
 =?utf-8?B?ektkZUhMWHNzT3BQVnB6bEFHclNaWWk4VzVvbVhWTGY2T2V3TUVtR0FGS2hh?=
 =?utf-8?B?RDVvM05RWDV6TGErZ096dC82dGhCaVpUbzVsWXBQc05KcStRNHhseWNFUGpr?=
 =?utf-8?B?aFF5a0g4UUFXUFRvOEJKRGlsaDZsYU1tbU53YzNvWUVQb1kzTHQ5N2JIN1Bm?=
 =?utf-8?B?WE53aVJhaDVyR0ZXb3hrVldyc2F4VVorL0hCRS9XeVlFK2xuRitNN2hBdHU0?=
 =?utf-8?B?WVVCRTJBckNZeDRqaUNNRy9RRER3ZllIOVpZRGkzMjd4UllRY1d2UzFORk5z?=
 =?utf-8?B?dkc3cThBWEhsaGlCUFROdGZsK3BQRXlmRVQyUnVMSmxBS24yVlJjSkxZZjQ5?=
 =?utf-8?B?eWE2bnpJQjEyY1dYSFdweU94MkVWMUtQWURBRlZFcG50ajVhakliL3FUbDJz?=
 =?utf-8?B?WTg3eEhYSUlHMmI0SnorOTJRb1ZKZWZHWWhIeXJqbWFhd3A1SUlJR3I0QllM?=
 =?utf-8?B?MG4yN3BaYWZDVmFjb1NkaXNzeEc2U3FYdzgvQjJxSFJEL1pvWENCOTE4V29z?=
 =?utf-8?B?dmVlenM5M0c3YnlKTDZheExjY2lJVktCa0ZKbjJYRkdZSkVuZlVTVUsweWFT?=
 =?utf-8?B?d3NxZFlaNlRmeW9LTjROMlhaNnRxRFljU3FIaFROTTlhRzNDNlJ0dm1yWTdG?=
 =?utf-8?B?aEhYakVoNC9RUUZtbUoycmJkcjBRdU04VjBEOVU3dGxXallkUFZhNCswOXVY?=
 =?utf-8?B?bjhIU0VDNjdHTWRYU09IWGd2eWRkSXlCcEZaTFJwSjkxRE95RkoremN5cjA4?=
 =?utf-8?B?cjArK1Y0czkxR1VRd2FHNFRHYkdOQndWWEVPUkJ2Tit0U2x3d0NtT3l1dG1L?=
 =?utf-8?B?ZDE3a3pOdFRLbExZdWtlMEtmNFQ3aGFoLzM5a1RXdG51VGJDS1R1clVUcEZr?=
 =?utf-8?B?bFVLaVVyTHRqNStsMktmYUhzM1JqOS9rS2N2V0VnWm5PdFNRdnpieFpXQ09a?=
 =?utf-8?B?QzNDQXNFRWNEdW5mNjBiVmZiaWo0N1hwOSs3eEhhRHlVc0xDdXA1d2VYdW11?=
 =?utf-8?B?alR0a0NsdCttYVhuc3ArZ3hrUlQ0cnNtM3d3ZDh2emVpRWZGRUFVVUI5bVdG?=
 =?utf-8?B?VTVWVXRJbi9kYndEejg5SEdPNzFiQ3VmbkxiTVFuTDluMzhUNGVUanhBakJa?=
 =?utf-8?B?KzhTUnQ3VE9qeXExbE54aVhqOXJHVnVJVnl5TklQUFpiTWxaTGNXVVFXeUpG?=
 =?utf-8?B?QlEwQytXMWsyNTZFYTNyTEpieVhMcC84T3phNjArNTRNL2ZVbXpPT3ROK1Bq?=
 =?utf-8?B?QWZDUWJUWmtBTUoxemcrV2ZjZG1FZjI3YzVXMU5XZElaeTRGM3NkcnlmUCtU?=
 =?utf-8?B?ckpnR0xSb1RPYU9ualJobkwyVFEzc01wLzU5aWxPeElzNVFicFRyUFhEcnJY?=
 =?utf-8?B?anZ0TTRhRWhCLzFmcWltY1poZHVZTkpRNE9KNm02OGxXTnJYOExmMjlKSXZO?=
 =?utf-8?B?UTNuNUpSU3FpTkNxdTM0cWgyRVNwcWZqcFRKMnpoRUZFSzZHWEg0UGI3R2dr?=
 =?utf-8?B?NGVZNVFpVjZqY2hGSk5xOGNIM2h2N1pua1d0Q3FaYzBNdGVWWkwyMGQwY09S?=
 =?utf-8?B?Z0dWcTlYZFBXYUZJRXNFUFBRNHg3OWxEK3JtYTJlSEhoVTNqVEhrRnVSU3VF?=
 =?utf-8?B?aGt6R05Da002MjB4ZjRvdmZMZlFpZXVtYWtHZzBwQ2svaHpIeFJQRTY2SXVK?=
 =?utf-8?B?M1BRNUF4Z3ZBQU9md2Eya0xIeWZjY3VjZGs1aDEwS0hNNDVUODJDeGR0UmFm?=
 =?utf-8?B?TytXNnRwS3dWMFMxaVlOM2ZZUXE3UzhsU2w4bWVTK3VFbmpEdmNaZUp2NzZ4?=
 =?utf-8?B?U0FYTTg0cEJCcFk0cCtZeEhveEdROUF5WENWQjFqM1FvZGc3VHNhOE9pSFh1?=
 =?utf-8?B?dnNyK3hRcVFGQys2Wjh1bjZtRHplU2JHbG1qNEU1L3FTY1FYd3kvMWZaQVR5?=
 =?utf-8?Q?kEQr4ZChngdaUI8KDhBgAxaEL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c0d3e2-1016-48a7-5901-08dc70d12f24
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:11:32.2188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3oqMpmuTyhYmYbYPw61Pr0hcA3ZO1X7JiyRiwGHABPIvLTskRBmTwb54GrUWUvxgZ+A0xAbRTBVyZM6wmGn7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8065

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The fvco frequency range is between 1600MHz and 3200MHz, without
this constraint the fvco may out of range, the real output
frequency is no accurate.

Aslo correct the name for fvco and fout clock.

Fixes: b09c68dc57c9 ("clk: imx: pll14xx: Support dynamic rates")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Jacky Bai <ping.bai@nxp.com>
Tested-by: Chancel Liu <chancel.liu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-pll14xx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index d63564dbb12c..55812bfb9ec2 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -131,7 +131,7 @@ static void imx_pll14xx_calc_settings(struct clk_pll14xx *pll, unsigned long rat
 {
 	u32 pll_div_ctl0, pll_div_ctl1;
 	int mdiv, pdiv, sdiv, kdiv;
-	long fout, rate_min, rate_max, dist, best = LONG_MAX;
+	long fvco, fout, rate_min, rate_max, dist, best = LONG_MAX;
 	const struct imx_pll14xx_rate_table *tt;
 
 	/*
@@ -144,6 +144,8 @@ static void imx_pll14xx_calc_settings(struct clk_pll14xx *pll, unsigned long rat
 	 *
 	 * fvco = (m * 65536 + k) * prate / (p * 65536)
 	 * fout = (m * 65536 + k) * prate / (p * 65536) / (1 << sdiv)
+	 *
+	 * e) 1600MHz <= fvco <= 3200MHz
 	 */
 
 	/* First try if we can get the desired rate from one of the static entries */
@@ -193,6 +195,10 @@ static void imx_pll14xx_calc_settings(struct clk_pll14xx *pll, unsigned long rat
 			kdiv = pll1443x_calc_kdiv(mdiv, pdiv, sdiv, rate, prate);
 			fout = pll14xx_calc_rate(pll, mdiv, pdiv, sdiv, kdiv, prate);
 
+			fvco = fout << sdiv;
+
+			if (fvco < 1600000000 || fvco > 3200000000)
+				continue;
 			/* best match */
 			dist = abs((long)rate - (long)fout);
 			if (dist < best) {

-- 
2.37.1


