Return-Path: <linux-kernel+bounces-548137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F56A540AE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 03:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE83816E25D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D381624C7;
	Thu,  6 Mar 2025 02:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KYbKeFw6"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64862142903
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 02:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741228306; cv=fail; b=I+PXFmeXFEthCnvedeHChTlsgvmO9W8QJyArmnwkLwAb2zLp0cDCk6YVKSQcmOtoIA23YQXxjK8M29L1B3m2QLd8lVcVaqSYKgsiHfSCCLy/OtznlzYlvuB850SqmULQ980SlPLqOg05mmYOXKwX1a9j6vJanOg/FMM/cm9rbo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741228306; c=relaxed/simple;
	bh=Hjw7Dos2YCGrUlaYe0bJCjil2pr0IrlUdX1MBq9fKUI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kuutGgkrRAtX+YwlkeZaKRxyn+FvlBZM1ldRVV4Kdq48r2QhMuw3BfhtHcp4uzPeS0Yz4k7nrTZZFe3nDA0veZ81apu66xJTJ091Z2NKO9LAOn6UbN6aizG2UifbPkXEWlYmj6gbrkXnoYlVyhtCngshx868Faiv+J3sQGAXIeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KYbKeFw6; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHtFytKK/D/rYqTiMwcNeEB2z8gfPW3LxpOe1GZgROnltacqPGPyJXH8zyfc1RBnrZ2ZzkrtMT3ME9rDFtMX/iJolsznoZ9WjpKI5rC/55TCcWJqziio3MmyyBfQqhj4fw3VGQfGq4ivqeQEyheEjaVVI2z9wTcIhtIMPDg/OD/Y5tyRNCLskkHSNf4z7zNyUbjSdOzgdBWkb9CJIcAZqF9acIDecZWFHaGZPEbQAbXK8DIObR6F0e3sPo5P/MSe365n6yvNNIuyQBExX2soO5VLgZ0X23luKZ+s26rnuNWThu1AMvIk9LdzQKoRYfwuq0GFWJtyCL/gESSWlLz14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SC5tJypOOmI1sneTuw2mCJNI9zhZhfmAOHPAkTfUPE8=;
 b=Di/de6hDjsK8/Cpb1eI2ZxULxak5vjuXQVS4usvk/9SVPyVBUy9FTejkULKgIGqk8GyXuS1u9NTBhcq2ZgUmUsBc9rDW1ByhOpuDBAXDZDPKmJQNEobmllEsE/mD4NsLzfm2RoeWsxCYVn1Fa/yhO+PTfYB1uGBRANpquCtVtBNzRDB5WUHzpg7MgSaWIA+oSySSUZu2VpfW7z1STLWgDPSZ7D8DRThCHDtaGHFJT8PTXSZZKn4YmN1cDsiObfQFrju2rxppsHxKJFv9pFa6bPIsB7bvYAURhQaoZ8SRgp8KUBT11S4oseYxmc4S7TzQA3SkvUTRc/ZUL4TirOyufw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SC5tJypOOmI1sneTuw2mCJNI9zhZhfmAOHPAkTfUPE8=;
 b=KYbKeFw657C0B+hvECfCBRrbe96E61kTIvgK05cGjUf680+B7BAcItkPZcrcJTLpfif+pEkE8sxIFryl3GC6hm8esXXBqGvIFd7fNLWPsY+6JMn2hWK6Evi78VN6lEYxvGtNKCsOs3yj+uPRDxkM2gVq11YKvoq8TVa4aCUTvajlKzeC0Ji0C4j06cK5L/fn2MXismRcZE29IgqLr7wUlL7HCytYXbYEjY4sljRYRSdTr/Zvh919htXShSXoyKUgx0seI3wk9EGNJkUshAFORSNI0o8cCttGD8ZBIxRD0Xx3DBx2dwj5HaceXaDwiGUYd01L/N8Az4exWQPg5hpBvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB8PR04MB7195.eurprd04.prod.outlook.com (2603:10a6:10:12d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 02:31:41 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 02:31:41 +0000
Message-ID: <62642284-ab9c-49fd-b682-6606850aa6c7@nxp.com>
Date: Thu, 6 Mar 2025 10:32:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/imx: legacy-bridge: fix inconsistent indenting
 warning
To: Charles Han <hanchunchao@inspur.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250305103042.3017-1-hanchunchao@inspur.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20250305103042.3017-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DB8PR04MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: dd04c74a-1b37-4421-03f1-08dd5c57073f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QnMzcFlGK3d3aTFCMnhXZWNWV2VFU0d6bHg5K3BlZnA3Q3diYW5mcDQ2OU8w?=
 =?utf-8?B?UHp6ZXF5K3poamJCRnR1d3VJQ3BQTWtwdEhEYk1wT1c0MnkvbzU3Vi9YenFR?=
 =?utf-8?B?bWtjUEIyOTVPcU1WcXFqQUpzeExGeUNMQmUyRGpMbWtnSXhRY3dNTEJibkY4?=
 =?utf-8?B?K25wVDEvSnRGRGN5Q2g5bk9DUUg3aWNXNHcxTTlvUXBIcmFtenJLbUNnVWVi?=
 =?utf-8?B?NFY5dHBBdjFESThBa1ZvNXgvK3VHUU44YW1iWGdndUhGYm1YaFQ0bTMwYlJt?=
 =?utf-8?B?NXBNODEwdXNQWGpPNEFFSXJ4TXNtWmxydkxhaXdubS9wSmZ5ZnpheHRrajg2?=
 =?utf-8?B?dHo4NFdscm5Ma3BXeWk0cGN6c2lMUDVDTjNMRy9GeTNKbWU0VWFGNDZ6V3pQ?=
 =?utf-8?B?ZEovZjNqRnpla2xhcWlNdElNMUxhUXY0SHc1TzR6U0RtaExMMDVHdmtVWnJq?=
 =?utf-8?B?cFpLTVlwUEJqa3Jwc05uQjd1YWtNcGdhM1pmWjVYaVh3Yk9lMk84cDZHNE9M?=
 =?utf-8?B?ejFYdUZhZm16ZXJqS1IxNHZiYnBzcXlBNTZ4NXRKalU0UGdqZCtVQTZmTWo4?=
 =?utf-8?B?YmxKaE9iRkxRUXFMWHl0Vk1ISVRrb01CQUJJd2hpZG1LcmVXeWw5UlAyQkY2?=
 =?utf-8?B?dnpCNVk3aHBvNHE4dWNIS1BjRmtOdmtyVjRMai8wYUJ3WWhFYTRnK3MxU2p2?=
 =?utf-8?B?QmlPTUtwTkh5M1BlOTc4d2pmQmVPYTFuKzlab1YxTnZ5b2FQL01EeXllcisw?=
 =?utf-8?B?RHhHUjB5UGd4VGFiM0w4TWVLeXQ5d2ZJQmY5MlMwaDUvYUowRnJ6bmFralVx?=
 =?utf-8?B?NklwMVExS3VNQ2ZsVDErNnFSV1NJMk1sS2xKRUh5REx4bG9ERW1iVUhHTnhK?=
 =?utf-8?B?QklLbTlPeE1IUjIwZ0VjQWtaUWFMMHZZVmUxUHBURnI5NmlIOHRnbGZEaWQv?=
 =?utf-8?B?U0x1eWlkKyswem1qUmUxQVBsR0pyRHdmcUN1SlE4MUl2MEVBUGZocUtVSHNP?=
 =?utf-8?B?UllkN1AydHJXVVpacHlScVdKRUEzTFNIdGZUUWh1WURqdFV2ZnRpeUJHL1hY?=
 =?utf-8?B?UjQ4SEJDSEtpVGJ4S3BnSWxWL1ZDRlczNWFEajFyQm5SQTVYdUtrMUsyK01n?=
 =?utf-8?B?bThuSmNyVEpVckdXZ2lUZEpzTFBUWUdRdVFHa2FGQmowa0VPUDB0ZG9wMHI0?=
 =?utf-8?B?RFI5cjllVUc4YUFXa1FJR3pqOFNPQWJvUXcvWmk5MjRFVWhWSW9ibjZ3NWg0?=
 =?utf-8?B?YVU0S2FYZlFNRWFqNHpHYmpRRnBYODdiZEtPTm0zQnFRNEFXRVhoYnhxcEc1?=
 =?utf-8?B?L1c0SXVVekhSZDlqQWcrR0hJMU5UVDhxcFp1anQzakNHOE50RDdJZWFJY290?=
 =?utf-8?B?RUxOMmRSbjFURmFxUE5IR3U2eXZPOXAwdS9IdUVuUGtvYUZkZ01ZZldkVmVU?=
 =?utf-8?B?VkdTVSttNWgzdlh0OC9TLzRPUjYrQ0lqOVFIWnlkcFl6MHRkMU1VRlZGNDZu?=
 =?utf-8?B?dncwZHFvWit6YWxveDdSSHlxN0sxdUswbzU1REN4UFNDTmpadFA1allGNS9h?=
 =?utf-8?B?NThXdytobUVrMlo1VzRkMHc2VGpVUlN4MGhJOE8zVzdzNW5SVGR0ZCtET1NL?=
 =?utf-8?B?UXlIcTNEQnFnamdxMlpwb2ptRmZzOE4zV2xkcHJLTXc5cUFxRVFaVHZJd2VX?=
 =?utf-8?B?dStlRDJZaHB3aUtiL0M1QmpjN1kzK0EvZFdFcUNGV0JuNGQ1UlUvNXRXR2FP?=
 =?utf-8?B?NlZUYm5YZGtqV3hpRWk3bVlESHBQbmdLREgzTFN3VGtGb3ZTQUJiMllBRXRk?=
 =?utf-8?B?NThwdjVJZ2p4bW1wbTlOOU1LZVVvZE5BQm93WUt5NHNOVWlpd2FFcVdyV3VD?=
 =?utf-8?B?aEdrQm5ZaGRtVnI2NFRqUHBpQjhSUWZxdEg1a1d0WlVub2I3NkFmVktGWUls?=
 =?utf-8?Q?fylJNR95xMw=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SDNVL1o2OURObmh1dmoxM0lHbnBUaktqakJFdm1XWStFR2E3WGduYy9xKzE4?=
 =?utf-8?B?UTUzNWo3MXZ5bURUb0pCQml2NUx0NEVnRHY5bUpZZ1ZDdmVlK1RtNFFPWjJ3?=
 =?utf-8?B?YVlnNlJSZTZkL1JBOVRzOWo0bGpWeXJvcUs1MDFNNldEVWNZR0JBeWFqSGxI?=
 =?utf-8?B?c0FCU000dHNqV0tocVJUSlJVVUcvK1BrTU4rZ3JmbFJPZG5rOU9FbkwrMXF4?=
 =?utf-8?B?UkpUdkZHVEJycGRwdmZjQU4vVHRIOU5rN1RwMHc0MitaRlNmUEliV29xQ3JD?=
 =?utf-8?B?bXdKdS9Ga3ZVUHlydWdXdHorRGN5Uk0rSmd2dGlma1RiT3N0dzIrSE9LQUhU?=
 =?utf-8?B?ZnJTMEJWTk1ubzZGK0tFcDdOaDB4OXBPTjZ1YWxVaENVeS9VbTc4dks3WW1D?=
 =?utf-8?B?TTNiYlIyL1JKckVDQk9DL3R4MmFPLzBlN0hZZkg2MXdVOXdRSldYWUl5Ti9K?=
 =?utf-8?B?K2t1SG4yeGVZdXVyTlBVMDRJQ0ZUcVZydDZzU3V4aFp5ZGNqcm9xSHVuZjFm?=
 =?utf-8?B?ZmVpUG03dkpRT253M2l0VmVEQndwQndvdTMwYTJtVERPb3E0SHFqL2hXU2U0?=
 =?utf-8?B?dElIV3NiWXF5bjlhZ1lUN3B2UEh1RGZaZ3RMTE1CZll1YkY4cWdONEpSaFN1?=
 =?utf-8?B?TGlia0tNRjhzMDVzcks0SlcwVzgrdVdlMTY2Wkhrb0U3bTVNUkpoUm1wNVZY?=
 =?utf-8?B?MjErR0tkRXpURVZxR2FoWE5UdDdzMDRjUjk2eWhGVFFPd0VKMi93ZjFaUUl1?=
 =?utf-8?B?NStNa0x1Sjl4QW1XQU52M29nYjMvRTk3bWFIYTByZUVMd3FNanhMb1NWTXRm?=
 =?utf-8?B?enA3QkhpWUU2Z0RUNU9oMk94bUtnRHprOGphQlI3alJDM1Q2TjBIdityNW5v?=
 =?utf-8?B?VjlJbnV1K25GeWY2eGZMK0g0bDg5RmhrdFE4TDkwN0VmTkx5akFIUWhxRm9i?=
 =?utf-8?B?RklUV2QvTE95VWQ0dFZrNmpBdjlBc0lISGRQNVd6YlR6RUQwV3ZjYW5uT0dI?=
 =?utf-8?B?TXVXWURRYjNXQytQaGt1NmxTTUZRSVBRS295ZmdXQUpvRVVYdmFTbDBGeEZH?=
 =?utf-8?B?TzlNREVzWDVJTTJYUlh5Q3VrS1JIVmUrSHhUS3A2aFNreTNFclJTZ3YxZTBW?=
 =?utf-8?B?ZmdyeHdkOU4wYmgzeXlFb2RudU11aDRWem5Wcml2d2Z2R3p4b3VHdWdqbmdN?=
 =?utf-8?B?K2RYbDhxYTFLc0xwcEVBLzJGclVnZWdGRnVIaXgwZ0x6eWlJSHNwVVAycndz?=
 =?utf-8?B?NktRVjh3MENkbFJueXRTQkZKNzdxa0JGc0orNVR6SmVmK08rbzc3VG0yK0xl?=
 =?utf-8?B?L05XYjIzTkRFREpKK1NwV2ZBd3NXR1E2Smk1UXRLREpjYXpMMHAvRlJYV3pv?=
 =?utf-8?B?dzZjTXlDWlBGbFhxRzBoZ3FQb3orc2NBN1h3U0NQbkVSajJUNXhaa09KWDRB?=
 =?utf-8?B?THRXSUFLajF0SjJHdjVTS1R1TERoYmltS2VOYWp5eWpIZGtITENqT0ZSVTVB?=
 =?utf-8?B?N2l3b3R5VnhoMnRicG1qcXhLU3dFbkQ5cSt3U3QwdnBPY1IvNXVDZWtXeXNF?=
 =?utf-8?B?QVg1NmRTN1liQnBMbXlpOFpMRHBibGJBY1VMVjNybFVKVlh4U09ueFhwZWJq?=
 =?utf-8?B?UzJzQ0I0TlhDK2lBSUFmVHNGeERLcG92NTdlZWpIMEM2VGNCQ3NuWXVadFdF?=
 =?utf-8?B?dE11L3VlOXJsRnVTMWpUTmp4YkdaSlBKNjVuNHYycGpTVlRTTzdEYkJpNDk3?=
 =?utf-8?B?Nko4aEwvRVpheGFsVGhSV2RQUm5rUVloVlFUc0Jtb1FmdGdlMTlNcmNDSVFY?=
 =?utf-8?B?MUtCbkNzRUpvU290WDI2YWJIbVhSQjFJQnBxZThTUDNzWGtJRnU0YUpvQmx1?=
 =?utf-8?B?SXM3V1ErbHdyMGFmc1BZaE5JVUFMNXlRNmMxRXBTNGdVVEpjUXFLQmVLczVM?=
 =?utf-8?B?OTVyeWtNRXA5VzZXamNQRzVBUjZOTzZLdkdMWnhPUW9aMldyQk9Oenkra2c2?=
 =?utf-8?B?ZSs5eEo3RExabEJSZjFnL2hNbE5VNUVpdTRCVGpyOTlUTWh1bUlhTG5tczU1?=
 =?utf-8?B?UHVQQ21Xa0k0Uzd4SkExRHVNQmpCRzRxMlE5QTRERWNiK2tBUnVxRzJrZEdW?=
 =?utf-8?Q?jIB9pAeVcPjJWXneuhdtFW9O0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd04c74a-1b37-4421-03f1-08dd5c57073f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 02:31:41.2734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCRAn/+FLnhgYMC4HlBxfSMiB5PSDAPs2qz+VWeq7RxXmHTA2GtX0VxBY4foGJfBDKUNF7PrXXwk7dG5hcJS/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7195

On 03/05/2025, Charles Han wrote:
> Fix below inconsistent indenting smatch warning.
> smatch warnings:
> drivers/gpu/drm/bridge/imx/imx-legacy-bridge.c:79 devm_imx_drm_legacy_bridge() warn: inconsistent indenting
> 
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  drivers/gpu/drm/bridge/imx/imx-legacy-bridge.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Liu Ying <victor.liu@nxp.com>

