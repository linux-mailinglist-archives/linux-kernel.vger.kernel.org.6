Return-Path: <linux-kernel+bounces-399343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBDA9BFDBB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0D99B22BA2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9FE192D75;
	Thu,  7 Nov 2024 05:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hw2uYUtK"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3C710F9;
	Thu,  7 Nov 2024 05:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730958171; cv=fail; b=GsPWdvSrjXmsTlIVN8OuVcqHxmXZSdY/bS87u4MfMgmHTC+ym3KvI7XycGUkDRN5nabOSGo402FqWKjb7x1VOxyPSBVGUdD3JZ3SeKaphA5hPLKyGcKn/Qy2tGeoPiq0oB+bz5F8b0/2WjaDyJgKlNZv7rhaqaKXNtpS2eBWKL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730958171; c=relaxed/simple;
	bh=RQ+K4LJpB5Qdwp1Ca1m4Qb46LR4i6L4zgmHSNkvoS7Q=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ajnMc0e/xZtrcelD5gCcxU6KwSFDhrJvvKqDEe79ELPhcud5rpYvoESvYpGH9jC/KYzLjpOHrvpcMxl2b6AvKLzmmwbNaZn73/GfxiftpN51L848Avnqd5Dewt8LYhjeLZyWN20tZFkm6LZNBWkpgeO+aiXxSi4W1SmbtyYh5Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hw2uYUtK; arc=fail smtp.client-ip=40.107.20.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLxeauyNUlVm2qiGUfNVtvvPYW3B9vsp+KhLU5/4NTFPbL9ssOTsca8MuWtPROZGU8StrLDZBwtD4jfr3uGV1kLblG5HvudK5sDZiw9UdNc8d219tCDkIcLbJFHj/oaJKanoNelHjFyTD0Fhw40lfYhRo7R2DwslryPFgCG5Z1566Kfrlczn+WwskrcS9JDRg0H1RDACRUUWKEU5WPZdF1q4yK8tIljctFvnPnvx07mHo3GTpLzFOlRlLVhB2NJeSdrr4MMfjY9gxQhARKt15t1ZdT9Nnhaq1O55bM1a/0oC0svON8zd/3waVXNllfKq8fRsZOgRQTpURtlhcZTWRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jGghA006iEpqwvneq72VVllL4tVNfy1VPejAQZpHvw=;
 b=wmnU5D2Vb8Ic9Umasoyh7EilspwLR+Jpu0C1PObTFxSiHXBgxdcKSeuCotX+UtL4evf4SkUPWoo/7CiTGJzgU2Qc1xJUaSuuQmeZXvcVgRx1EW4bjIHyDhORX3VrgZhDZDBVg0J5Jvf4IyVt36MJz2uANht1HyXsnULMlX17f3Z241TJIoAge/VKm5R5noNwXUsIb2gMf6ThJTakVD+I5BPBncfjriYKUpfWGqcxuu+lQKXginF5Zrk5Xf96ITFrI9nKJcdSX17t29u0YXVcLjD5/syP946AfEbTr3GOtP7rxOlr5zA1LC08WIIIMSHn6RRMTrFeQ1BFtdk9+zpo9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jGghA006iEpqwvneq72VVllL4tVNfy1VPejAQZpHvw=;
 b=Hw2uYUtKLt2e+JQz3UZEiZNeDDWkMfYF4MLebsbDcd7PxQpWkd3e47YQGW9lH5cQczo0O9lCl3bTnRvdNHirN3wYZeOhUoNFCeWKfyxar7jI1ouagvQXYc1t1uA4MTaIPXFHWGQ/EGVC9yfI2AuwwUPRCwc5DQ3Bqxh3CmYDej5inYG1FppOjOirSqSO6DWbxDeNDNMlze28OfF4ii3ARs2GDomDeTeSWzZD5JEqgiEm2VPPiR7dHx8y7fQO7IB6Ph1SOK3zqAmpsNvELAhiQBncKlaIRQmf+R9ZCPuhfuxD7H75LbqgTfpXbh8FwApzNwgCBPwy7iIr2NNWMxITjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9354.eurprd04.prod.outlook.com (2603:10a6:10:36c::10)
 by VI2PR04MB10145.eurprd04.prod.outlook.com (2603:10a6:800:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 05:42:45 +0000
Received: from DB9PR04MB9354.eurprd04.prod.outlook.com
 ([fe80::3cd3:1ff0:8bae:a7ab]) by DB9PR04MB9354.eurprd04.prod.outlook.com
 ([fe80::3cd3:1ff0:8bae:a7ab%4]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 05:42:45 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v3 0/4] firmware: imx: secvio: Add secvio support
Date: Thu, 07 Nov 2024 06:42:38 +0100
Message-Id: <20241107-secvio-v3-0-ea27f1e9ced4@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE5TLGcC/02NQQ6DIBBFr9KwLgYGidhV79F0MeJYWCgGGmJjv
 HvRxLSZ1fv5/83KEkVPid0uK4uUffJhKqCuF2YdTi/ivi/MQEAttDA8kc0+cIN2QDCqnGalPEc
 a/HKIHs/Czqd3iJ/Dm+WengoptAKhK9moBmrDJc/YOcxVchhHvE/LXNkwst2S4X/Zns+z5IK3Y
 ugIOqQe4Tfatu0LWt+nntQAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, frank.li@nxp.com, 
 pankaj.gupta@nxp.com, daniel.baluta@nxp.com, silvano.dininno@nxp.com, 
 V.Sethi@nxp.com, meenakshi.aggarwal@nxp.com, 
 Vabhav Sharma <vabhav.sharma@nxp.com>, 
 Franck LENORMAND <franck.lenormand@nxp.com>, 
 Iuliana Prodan <iuliana.prodan@nxp.com>, 
 Horia Geanta <horia.geanta@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: AS4P192CA0010.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::17) To DB9PR04MB9354.eurprd04.prod.outlook.com
 (2603:10a6:10:36c::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9354:EE_|VI2PR04MB10145:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b2bd9cf-bac9-4163-8af0-08dcfeef0177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmpIUFZzZlBrRHlKZkgxU2ZQWHBFZHZjSHg5dmFBT1NoeTU4akQ5eUpoM2hB?=
 =?utf-8?B?R1hnc2txN25LOFlqalBQYWJxTTM5Zmp4S3lGaXAwbUZqRC9aZThITVdwVHd3?=
 =?utf-8?B?aXJYUDVGUkF0U0lXTmZZRDJEeStPMDQ0cVpjVy9mbWJZeUV0RTI4N2JtaFJw?=
 =?utf-8?B?dnFmRldWL2xyaHFMYjE4c3hvSTVGclpzcVhkV3Y5M3VJcWt6dkxIeXAya2tr?=
 =?utf-8?B?MnFvQ1NxaU0rSHNaa1FRTlJxdDBEeFdjRzFPN09aQVVMZjBvNEhVL3pvVDRH?=
 =?utf-8?B?UFVnZ0krMm5iOEZMVGl0bTFPU2lCaDZPYWFEMnVQYlVCMDlRWThSaTJ5K3Yy?=
 =?utf-8?B?L1k5SjFpV0h4OXM2MUQzaUgraVlldWI2VisyckFGWmd3Q0RnREM5ZDhvcjFF?=
 =?utf-8?B?c0Z3QlBsRHdlbTJ0bkdockx0RjMvYlhxNXR0WVl3MkN5anRtc29sVzUraURp?=
 =?utf-8?B?T3RsOG5aTnJjMUYzczM0NWpiL2xFeEdrWFZ4OWRxSFhBdUVFTUNXbjZMc3ZN?=
 =?utf-8?B?SnkvUnZ6aXlOTmMwMUI0M29tQk04WWoyeVk4QTBnMVFjWnVYZG1TUm5VL0M0?=
 =?utf-8?B?NUtOWWdDUEU2cXZLeW5tVTVST2RvazR1VmgvU29ZM0U1WG5ObzF2MGQ2Tjk1?=
 =?utf-8?B?TFFDODBRZ1psN2JQT2EzQzJKU0Z3dzluMUgwWDMxS1RrWkQ5OVNEN2l1VkVI?=
 =?utf-8?B?M3p6SENEemNVdlRGQjF2cEZaaXk2L3JZamE0ckkwaDVZNG5pV0R6UXFoM1dD?=
 =?utf-8?B?UkVpV1hrY0ZIMnF3TUxJRGFJZE5FQ3JiQ0NQTUVCeWp0aUFkbWVUOWxTNFM4?=
 =?utf-8?B?MVdnVjlpejRjdkJrbXVvTWFQUFNUSlJSa3ZZT0hHQ2J5T0lLS0RlUUdnSkVu?=
 =?utf-8?B?ZGE4akxhdnN2OVE4WDJ3TXcxVktLeWI4T0JkM0lYaFhUV1l5eGhmQWNHT3Uy?=
 =?utf-8?B?VVhXZWt3NUZKQWVtRW1wc3VONHc5cVY5dlNnRTlnUFBhUXNRMlFsSmpMUU5T?=
 =?utf-8?B?WkE4V2F3VEZ0RldFWlM4dEJ5dFE2Q0hzWENVZ3YrSG5XKzhqSW9NS25pbU9w?=
 =?utf-8?B?YVYvMkdQZVFPL3l2NXd6NEV4dVc0K1lER0RpSHVPM2dMWk56d2p5czVuOXVV?=
 =?utf-8?B?dnpISVNud1pWL0dmTHFKV3JTWGdFM1Z3ZFdIR2gwdVQydlhHQTVTeENrR05J?=
 =?utf-8?B?ZzNXS0hydGhsVHN5N3BVREhvcy9XSm8vSWpicjBGWWpaQU1sNFhNMU9UbVl5?=
 =?utf-8?B?elZUdWFGdGRSeXUxT0pLMWZscTRmcXVCVTB2TkJqSnpIQTFWR25FMklUdEZT?=
 =?utf-8?B?aGZaNC9vdGZPaXlsbG1zSWNRbUdMWjArcDRnbldGeUNSV2JQUFNVaE43NGp0?=
 =?utf-8?B?UUNRN0lLTytOYnpJMVFkQ1dVdTQrZ0RVY3lWeGdQVVpQeU5XMytIZ203aU13?=
 =?utf-8?B?RWZISVlsQ1REMUVwalN5Sk5nQkJMSTVCdHZ2aDFHOXpOUEdBNDZyYnlISytl?=
 =?utf-8?B?L2M3eFh6eEpzUmtPeVdudm04SXE2RTV3TVNzVGF6Ri9GRTRMdnRNY251Lzdr?=
 =?utf-8?B?cHJGNVBoVU9kTFRpUzgvcGVyRE5sVnNCT24yTjIvQ1hUS1hNNm9ISTY5cVhD?=
 =?utf-8?B?NC80Mi9DbzBpWVBGcnpDK1dITE5QMXBXeXIxNmF3eFBrY21rRnBNYk8rYU53?=
 =?utf-8?B?VHprZk5IbStTd3J3dTVNS3pxQlNhcmFCREJMUUpRK1FYMGlnZ0diUW1lYy9Y?=
 =?utf-8?B?YWN2OU5QMk9WT1d2ZklXVmdlaVlHM1F6cEJDRDk5WTdSK1pvTWlCSXpMNWY2?=
 =?utf-8?B?Y0IrUDdvbWdlRUlqbUFQQVdoQ2ozZE1TQkc0djY1d29EWVIrTmxOdUpYMTM3?=
 =?utf-8?Q?Cy57QnLGqxvQB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9354.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzQ3UktOdmZXbzIxUnNlYlNqRExuWGVCYU41OE5lY3RTdEVEN0RobGFIQmtY?=
 =?utf-8?B?c3FVS1RsK09VbGhZTTJxcldIOUtlSjQ3dzJ6blpYUmpaTEtHY3dhTTR3Rllh?=
 =?utf-8?B?SXhla1l0UEdTWmJLMHM5SGRyOUtJT0xXR1RDNjZWTEEzSjJDQVZDM09jbW1J?=
 =?utf-8?B?SmFPYS84Z0E0UjVFZGVqUU5wR3Z0by9SWS93SFlOYXJtM0RIZDJoaWhJWGZK?=
 =?utf-8?B?UUNDbnd3SGNtSGRUdFpHVkpINkY2RHJTeGVUVXdYTktyMHZFcXVDa3gvQ2dx?=
 =?utf-8?B?VFpRTTVrTGRnd3V3ZVdpb2c3bmkxMlFtWE5KMWdFYUp5ZnZlZ3RCQVVuQnh1?=
 =?utf-8?B?MW05U0Fpdkt4Skx6Y2ZWaHVNb0VGTm5wV2ExeCtyM1NVYmVIeGpjM1dST1hK?=
 =?utf-8?B?RU9QNmg5OFE5UmxOVXp4NFljVlBVa0FxUFAxYTE1S1JrWm1ZcGxGS3k5aVM3?=
 =?utf-8?B?YXgzeGhpdzFMTEFjNURYMUZCcCtrcEpxRW03ZEU2TFZsbCtSeEdNbzArN0VW?=
 =?utf-8?B?ektrQWxJdFhSbnlKT1BuYk5aLzk2VnBvcHh4ZUlYaHVRbnhIajlWR1k0Q1dv?=
 =?utf-8?B?elhXcm9UZjlQNmUvMnk1Q0U3V09kVjMyQ3hDT3RueDBHWjI3b2NqeUpQNjJI?=
 =?utf-8?B?LzdqUC9uaGtaNVc2S3NRSncxY2Jxa0R4eHhaSnBFNWdBWXBvWUVqWXY2b0Vq?=
 =?utf-8?B?WlUxWTJJd3JGNW1nQmhYUHV2VStGTnZRVkR0T3pxNEs0YmpGc1ZvR1BFSzQ5?=
 =?utf-8?B?T0NKNDFTSFNFRUFwWnlFbklKbnFSdkY0K2ppd3pjclFSSEFhNVVNbDd1ZENi?=
 =?utf-8?B?UTRQTmxFUjBMdWVjMFJJSXl1bDF0UWQrK0F1VUVyd01DR29PdVV4UDNQUmRI?=
 =?utf-8?B?d05QNEtNY0ZCSldnTXlXN3I0MEplNldWci8zckh4eTZXNjVVL2pDWkQyZExU?=
 =?utf-8?B?bmZpQVl2S25aUFRtbVNRVmh1Z2dvdzViODRXcUQrWVRVTlZKRVBUZDVXclJS?=
 =?utf-8?B?SWUwVzkzNGkvSmFuL0dQY3ZJL1lWb0FsL1BjKy9UUHl0MFVGSjN0cDNkdm9m?=
 =?utf-8?B?WitUT2JoL3BGWm45aWdjQnFnMFYzTDlVYnoxdTlVRzRPWTA0ZFp5S0wwQTRa?=
 =?utf-8?B?RWhtSi9Xc1l6L3ZKS0dBcXF6VVZKRlkyY3FPTGRBUkhlWTc5TkVra1dZLzFy?=
 =?utf-8?B?TEtVL3c0b1lBS2xDeHJldFBkTTFIekFsQlNFYmlLbFpZNU9LS2FkOFBRTjBa?=
 =?utf-8?B?M3UxRGhKZDc0Nm5PMDdyTy9xd25CY0gxdi9xaGVtVm0zaXBQTDgraWlORjA4?=
 =?utf-8?B?MXZiWGxPQXFrYzRHMFFlUTMxNmdKNVlCVUxoVGgrSzZ4c3U5eG51Wm91L1pF?=
 =?utf-8?B?cUE5TUJnTnVLNHREeFRaVCt4WHg5ZTFEaWRaOGppVzIvRnJJNTB4c05JMHJX?=
 =?utf-8?B?enM5VGtvNmpwdVlZRW1PeGdFMno0SmhsMlM0amIvNi9aU2F3eFpDQWFDVE40?=
 =?utf-8?B?RWQzeHREZERLVVJsSlpGTWhqcmpIWFByc3AvdFcyQWI4d3QrRWgyMGw2dDVQ?=
 =?utf-8?B?WmdLbHQzcmppMU4yTkhnMVA4VnNjYUQvb0lsTFA0bUQ3UjVZWkVBc0pmUFRw?=
 =?utf-8?B?MXhKN1RtMEdIcExva3JtNVRxQ0tMMUZ3dHl4N080dGwxQ0xOUExCQlJQS08w?=
 =?utf-8?B?SUxnSHR1MGJnU0FHeXY5T0JlbjNnV2xoRmNPOWhIWWZUWGI5T0dqb1gwME9x?=
 =?utf-8?B?S0pKWVBLU0UxeWFrcE1zQ05tRjhZZEd4KzVTUjlodjZZSkpORzRtUkZDVUdn?=
 =?utf-8?B?bmJvRkN6eEpjd1k2V21nakp3RHFza04zeTB0Y0FmNzcwTHI5c3cydGZzeExq?=
 =?utf-8?B?V3NPMk1XK1F0eHJYTjcxSytkYnNQSFMxK2R5UjRuejdGZEhyYlBiSDVQeGRx?=
 =?utf-8?B?eTk2YW4vWkk5QXlxSEFrUlN3K1piNXpka1ZlbTNWMkFydTVzdENuLzlyMkU1?=
 =?utf-8?B?cGh4NU0ySExxd0NmRzdoNStnQkZKL3R4RnJsQ3pDZ0MwUVV4ay9yTEt1SWpF?=
 =?utf-8?B?SzF0ejYzUXpKUkxXdE1uU213KzVpamNmQXRpRE00ejVwQlBJbDlnREM2NXdu?=
 =?utf-8?Q?8vHF/36Zx9Ye4YcidclhxQu8I?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2bd9cf-bac9-4163-8af0-08dcfeef0177
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9354.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 05:42:45.6742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2PAaxyBbUCWjF3bmBkG0v5zwtgBWRoxSTogCBrnhA0E+9YVX0gTLwcDuI+Re8kmQtyTd/PtQThnPK4MYVSg/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10145

The tampers are security feature available on i.MX products and
managed by SNVS block.The tamper goal is to detect the variation
of hardware or physical parameters, which can indicate an attack.

The SNVS, which provides secure non-volatile storage, allows to
detect some hardware attacks against the SoC.They are connected
to the security-violation ports, which send an alert when an
out-of-range value is detected.

This detection is done by:
-Analog tampers: measure analogic values
	- External clock frequency.
	- Temperature.
	- Voltage.

- Digital tampers:
	- External tamper
	- Other detectors:
		- Secure real-time counter rollover tamper.
		- Monotonic counter rollover tamper.
		- Power supply glitch tamper.

The on-chip sensors for voltage, temperature, and clock frequency
indicate if tamper scenarios may be present. These sensors generate an
out-of-range signal that causes a security violation to clear the
authentication and storage keys and to block access to sensitive
information.

Add linux module secvio driver to handle security violation interrupt.

The "imx-secvio-sc" module is designed to report security violations
and tamper triggering to the user.

The functionalities of the module are accessible via the "debugfs"
kernel.The folder containing the interface files for the module is
"<kernel_debugfs>/secvio/".

Get status
Reading from the "info" file will return the status of security:
- Fuse related to security tampers.
- SNVS readable registers.
- DGO registers.

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Dong Aisheng <aisheng.dong@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: frank.li@nxp.com
Cc: pankaj.gupta@nxp.com
Cc: daniel.baluta@nxp.com
Cc: silvano.dininno@nxp.com
Cc: V.Sethi@nxp.com
Cc: meenakshi.aggarwal@nxp.com
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>

Changes in v3:
- Dropped [PATCH 1/4] dt-bindings: firmware: secvio: Add device tree bindings.
	- Reuse SCU node to prove secvio driver asynchronously.
- Dropped [PATCH 4/4] arm64: dts: imx8q: Add node for Security Violation.
	- Removed explicit secvio sub-node within SCU node.
- Create seperate secvio platform devices.
	- secvio driver probe asynchronously.
	- SCU driver keep going and finish the probe first.
	- added new function imx_scu_secvio_init() called within imx_scu_probe()
- Link to v2: https://lore.kernel.org/r/20240509-secvio-v1-0-90fbe2baeda2@nxp.com

Changes in v2:
- used b4 to add the devicetree list.
	- Added all necessary to/cc list.
- Link to v1: https://lore.kernel.org/r/20240501053205.1737248-1-vabhav.sharma@nxp.com

---
Vabhav Sharma (4):
      dt-bindings: firmware: imx: add nvmem phandle
      arm64: dts: imx8qxp: add node for nvmem property
      firmware: imx: Add SC APIs required for secvio module
      firmware: imx: secvio: Add support for SNVS secvio and tamper via SCFW

 .../devicetree/bindings/firmware/fsl,scu.yaml      |   3 +
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |   1 +
 drivers/firmware/imx/Kconfig                       |  11 +
 drivers/firmware/imx/Makefile                      |   4 +-
 drivers/firmware/imx/imx-scu-secvio-debugfs.c      | 274 +++++++++
 drivers/firmware/imx/imx-scu-secvio.c              | 618 +++++++++++++++++++++
 drivers/firmware/imx/imx-scu.c                     |   8 +-
 drivers/firmware/imx/seco.c                        | 216 +++++++
 include/linux/firmware/imx/ipc.h                   |   1 +
 include/linux/firmware/imx/sci.h                   |   9 +
 include/linux/firmware/imx/svc/imx-secvio-sc.h     | 216 +++++++
 include/linux/firmware/imx/svc/seco.h              |  69 +++
 12 files changed, 1428 insertions(+), 2 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240508-secvio-8acfa2838385

Best regards,
-- 
Vabhav Sharma <vabhav.sharma@nxp.com>


