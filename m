Return-Path: <linux-kernel+bounces-399346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 116149BFDC0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888131F2326E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D618194C6A;
	Thu,  7 Nov 2024 05:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kby7q8b5"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2068.outbound.protection.outlook.com [40.107.247.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BB6193434;
	Thu,  7 Nov 2024 05:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730958176; cv=fail; b=qpMDW/rczWOQBhPVQUNtb98iOsZUGUVkD3Zj+N4EbisBPaTBVaYq/oBvUeymO4DXtd6hBRjsc+bGG2ohKDUbEE4UNDBek+dP89Y9A4jeKA23nqD7JIQBbe2ajx7wcbA/Gv/21TruABjJSxTGkxD+Cd+ACrupeFgXhQejAwDJ5fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730958176; c=relaxed/simple;
	bh=un9iXQ5xghbtZREQMJotfWmXPPOY7jR+nhscSRxZpvg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jyD0J18GWgbukrrNTVNjkcppfMXqvnCItZMkz4+swef3ByLW9OXzE6Km0opPrLDpvMMkErDpDJpz0fQwpAO0PiAgYuf4ZnpbY4E+GQa9iDEc7SoABV0GY+EwPxAcWjflJ3sutLDbJo9EwGYQPtmizdrk6resIpXaOYsRxZ/NuVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kby7q8b5; arc=fail smtp.client-ip=40.107.247.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRZav1oIoAxJtfp5yNkcoOfLUmPMxBkbfq2lJhHWeXJ1f1r//O34o8UJxyeZ0F61utatm/nCs5mpSjTRqCT6DntYYe3Un53l70+mElMeplE1O0shiVDq66RkLFxLzsR6Be2k7G5AjGa0E5mizHhBfEesOpD6jl7mkO/MgsA0fAMQHFiIucA5RY7QmsGar36xtxHa6GrCdIbxhQrkqsQjLYFv5w03sSwAqlt4ZFdxW1i5cBbuDHM01cwBMKTWoU3E4rk/bwW6RkY9sZXAZcg4NpWnWbyBhQeSueSqMoDprPoPAqdTf0xs9Zk8xEL1Brf6oDlM8HgFMmniL8oKA+RGjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7veCpghGih4EyT0+UxUfwK10HmZpxhIQyYrVveOB7c=;
 b=ItaS3tHiwUS3uCndAtMvCzu9wCS5g7gisnGCtMiR8jFw5IB6xziwQARnaF0rpdYUajpdviLfjhn87irxVfI1dRpAtqiGqb46XRDtSpANt7jXMnm/Zj7/v5kQe1lQXI9usSvL9GMq9PHn14r9KmqEz3C+98Roq/fIaGNVPpMxfO5GMIfemPCTif0+aj18+GV0PGTnHLq92Nuch7UWk08kqpkwzIKnjH3svn9azicnGBFaezm/NytjToXhvgIEdS3wrKAgzcf1E1VHPVCjGn8Y1Z867VvUVDk/9BybUkUqVupmVQKXXmJ0xq8E9Hzu9UTHCJWqnLSik6CwcdLEz3L5Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7veCpghGih4EyT0+UxUfwK10HmZpxhIQyYrVveOB7c=;
 b=Kby7q8b5Q/y6R99jjrdo++7rrkf9D7ZbSwPzBfzp4Di8n5WVu6P1GeolX7wu2vf+MzDx21eqGP7KNEvm5463xV8ZUxpizedMrVVuUwOoj7jqcZibxCWq5QYhlq7tce+U19N6E62zEoN6dXApFsUEgY6uKpZQ5ywtkIsafqnyMyyIZEB+VktjvxFJCU1TG+jUIxP0AIw9PJAlR8lfv1NCVSE3Txa4vtOqxZV0Ds51rxLdXegNhrPnO/IaSHlhn1X5/WaI+uaT4btfh8ltBo0w32xYtAhqwzrsNjktyONMNbboJOBwoc1LMSBuiuceseh6ffR+UEbgeanZfnwIGoiVTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9354.eurprd04.prod.outlook.com (2603:10a6:10:36c::10)
 by AS8PR04MB8434.eurprd04.prod.outlook.com (2603:10a6:20b:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 05:42:47 +0000
Received: from DB9PR04MB9354.eurprd04.prod.outlook.com
 ([fe80::3cd3:1ff0:8bae:a7ab]) by DB9PR04MB9354.eurprd04.prod.outlook.com
 ([fe80::3cd3:1ff0:8bae:a7ab%4]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 05:42:47 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
Date: Thu, 07 Nov 2024 06:42:41 +0100
Subject: [PATCH v3 3/4] firmware: imx: Add SC APIs required for secvio
 module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-secvio-v3-3-ea27f1e9ced4@nxp.com>
References: <20241107-secvio-v3-0-ea27f1e9ced4@nxp.com>
In-Reply-To: <20241107-secvio-v3-0-ea27f1e9ced4@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DB9PR04MB9354:EE_|AS8PR04MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb56b9a-b29d-4547-6cac-08dcfeef02b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkIwK0VvdkxKcVZOUERVWDR5MlJYZVpteUY4WXZGd0JWRjQxWGhhcjRCeEhK?=
 =?utf-8?B?ckJMWVFRbHBMajRIUFJFbzI3V2U1Nnc3d01mU1Q4QitYZTZwZllKei82NTVR?=
 =?utf-8?B?UnNLekNlZFlTNE5BUzV0R0d4NGo1ZjhaMzd6WDBLSWdJUjI1M3J2Q0ZnYjdp?=
 =?utf-8?B?c1h4MWtHVlpVa2RZTjVyYWprZUM3dnUrczc5L3FvZ1hFRDdyWUxHZnhkazgx?=
 =?utf-8?B?UjV6YzRzVnZXek00ZFRYN1VLclVvUDd3cFI5alg5ZkdEejRhSkVQTDJKNTd3?=
 =?utf-8?B?cGFtZzBFSTJlb2F1M2M5SElidmgwUmtGYmNDRjVWNHdyV2ljaWxEZVdGK1ND?=
 =?utf-8?B?cnBGYXdVeklabGt1b0tKeTBmcERsT0NBTWdTUnpLQ2hpSkVuampFektpRHV1?=
 =?utf-8?B?UDZEWWI5VVpLaU91cFNQbXF4dm9CNXNXVzFBbStnbWxVdm02Wnlyc1hlMEQ3?=
 =?utf-8?B?U3gyREZHVlBjUE9aMFk1UWRCTzBYYXo4R2Y1ekJSN0JVNk1jRHBVNG1PVmxv?=
 =?utf-8?B?ZGxmVm0vSUhFM0hwekpENFU3aGdyTW93T1hHa2UrTEVJOVJ1cWhFR3ZLUnl1?=
 =?utf-8?B?bVpmNUw2RkVKK3c2eXZDemNMbWRmTkdiSHdLanlnNjN1VlV2S25UU1lNcHZQ?=
 =?utf-8?B?KzBHK0Q1aTJlZFRGKzJTQWJLRkJQUFFmZWlVNVB1THZwUVZwRjFqTXBkTG1W?=
 =?utf-8?B?TUlpbVZNRW5jRFNXSzlSbEU2akRiYkEyblh0Q1UrMk04dithbGZjNStMTmVM?=
 =?utf-8?B?ak5hS1g2enBFeXgzYzgxU3BieTBDVXVCQnlqdmFKTURySGdzM1NpbURTMzM2?=
 =?utf-8?B?bTU1NFRrNFVOVVl3OEJxbVVhRm5vZnRIWTBtWEcvVXhJVGZFVm91MGVyaDZP?=
 =?utf-8?B?RWNDSTRvaXU5THdWWVZSUmtjMi9HSzZCMzVsMS94QmpuZUZvMFF3U3VXWms4?=
 =?utf-8?B?TG1uWS93SWZwUkhLSnl4cFRwU3JrS1VHRGprWVNpSE9VYzdPVDhPZWZCTGQy?=
 =?utf-8?B?U1dNUGtFekx2T2kwNjhFbkU1VlZtV2JzVmF2RWhnaDVXbCs0TFk0WFhtVVpY?=
 =?utf-8?B?UGh3bklFRm1pQkRhNTlvU1kxRTU3by94bE1JektqY2VPOEIrVGhzWFFRWngv?=
 =?utf-8?B?RVlmY1dMYnBQYUtUTmRHNDAwYk1tZlZLcjJlR3BybzN6Y3E4ZDZMSmFFaGdD?=
 =?utf-8?B?S0pRV0pIVThzODZJaUcvNzQ2M0ZJSytpTHdRNGthYjJVbTB0S0w0aThtSVlm?=
 =?utf-8?B?aTNOZHMzZ25Pd1NZbDdsK1pZTzcxb3B4eENuOVoyUitCaTRPL0JZMWVZdGVt?=
 =?utf-8?B?cVVoS0pyTmtlTDBFRlJxS1RkSW1qblQ5eWZTNlltUWtydjk2amNQbzdjNHVW?=
 =?utf-8?B?a0xraVgyU3NDN0VUQzd3OW51OEh3b3Z6cGE0S21IdjdnazRmcEsrdGVtTVAz?=
 =?utf-8?B?RGxlQkt4dzFtNDRValNTVUIwUXdKSlkveWJMY0s4QWdmbFBSd3RENnlsRFJS?=
 =?utf-8?B?M0tJcG10b2wwVkJoL2NxeTdRRUZYZTVBcXV5cGtJYnE1VjVlMHpmNXhIdzZj?=
 =?utf-8?B?UVBnTTFWWFVLRnNCNjV5NXNtVVFSOTFWUHIzbnBJRUM2OGk1UjFXQ1AwOG5q?=
 =?utf-8?B?TmZ6SzYyVjBKckNxdkhETkp3M3p4VU5BYjFpQUtneFN4RnJ5amVaTlZkbXEr?=
 =?utf-8?B?YXU3ZDNBbHdwUkZJOGNzbHRwYk5JUisrUHUyTW1tREgzc3pnWFJDejFqWkJ6?=
 =?utf-8?B?cmtzS09BS1VsbVNaQXNuNTk0Z1p6WUoxb21RR29HNktZNmdBZTZjRzJ2Umhn?=
 =?utf-8?Q?szKUpRorxdNVhxFA7dB/zwb3v4z6qAxNGfx9A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9354.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0hWQkJYNzFwNUhtV3RaSVFSNUZHTW15UFFnQ0VLRkJzdnE5WUFmQmVHM2p6?=
 =?utf-8?B?MlRLeml5b1Uwb3dDNUwrVXZzbWR4cUYxS0tLVVV6amJiQTBldHNpZWxoSTdD?=
 =?utf-8?B?cHBxUXU5MzFQUFVsVEgzY2UxYmJGTmNIVXkwWG5ITzdhZndPV244bmF2QWlK?=
 =?utf-8?B?aUdDOEtIbzNOOXBUdStPSThobkoxMmVJUFhIRU4xOE1JM051Y2c1RG1DblFr?=
 =?utf-8?B?c2dvZ21xQ1cxaEZvTG9aS1VtbllBZHgwb3liT3llNFpCY2xFOUlKa29VUzg4?=
 =?utf-8?B?eHRtdWxGRXg0U0xWWlJudm5FclBqZ0VKbnRGcXRnNWM0RC9CVkZ3QUpPTjJQ?=
 =?utf-8?B?MElxRGFYOVFERkR4V3JzbXRpanhVYVNBSVVUM1NQY2g3SjFmSXNRTzZBMy9k?=
 =?utf-8?B?VkdmRy9wM3VxTDFNeFFBY0hmY0Z4clFWMU9BUTZwWUMrQnh5dldCN3ZHc2N4?=
 =?utf-8?B?WVVtOEFiWEtoOWRTWlZKZDlSYmpBL3EzdGNBL0hCZXI2bzlycHYybTZBRitU?=
 =?utf-8?B?TkU2eHJlRVp2ZkhWZVFDZG5LT0h5eXlKTEo5SHdTOTdYTExJaFZsYzZCUWRO?=
 =?utf-8?B?TjQ0KytpOTFoalZYMHhtSExqU1JMTW5tbXg4V3VIVTdvWmJqUHVxR1QxaS9Y?=
 =?utf-8?B?SjNGemFmUVBLbDB4TWx2QUhGQzBKQml2VXhNRW1tcVZaV3ZqMUVGN0NabWxB?=
 =?utf-8?B?UkZ0MG1za3Rxc05sQ0lsQzllLzd6aWpibzdhb082d0VlbitHRUdRbU1Zamhs?=
 =?utf-8?B?VFNBN214NWpRZklPSXFYai9IVnFpQ1pUc1R4aWZPQmp1VEdYUU9HRXVIQkRX?=
 =?utf-8?B?MDlvUEJHTmR5ZWpqQ0FmaVJuZEoyTCtZUHFoZlVYNjd3ZkZHVTdHc2hVdkdJ?=
 =?utf-8?B?Z0tVVklIY0RSVU0zUjRCVUpNTDVnaGJWVDU1YVk4Z0F6VFNnM2pjdUUxdy9P?=
 =?utf-8?B?ekp1cGxsTk85OC8rQTQ3NGFBRjdrdnAzQ2htOGJYdnlrMWorV2I0b0RhVkdX?=
 =?utf-8?B?Z210cFNrcDAwSGlBYlo3RlZIaHJrOCthTFlrRnFMYWdGNEF6YStDK3gyOTR1?=
 =?utf-8?B?VUZsYU5Pa05wSEJPTVhWQkIrRWJtNzNBTEdpOEhvOWgwRmdIa1BKOVp6Nks1?=
 =?utf-8?B?UkZtREhjNSt3c292SXdyZWltYk5GbXc5aDc4MXNxdXI2RnlSb3FRR2pBdGhn?=
 =?utf-8?B?V01Qcy9Ccm9hRXlyV1FvRnhldklpKzR5d0hBQjVsbGs5enV3VHU2RVhQbTZi?=
 =?utf-8?B?SCtnOU9ET2sraUVmOWtWYmtVSFg1ei9hRWhOWE4wclhDUEpaTFk1RWJVeVFO?=
 =?utf-8?B?Yi9xWkg2bmtJUEx5VU9uUURSc2hpbW5ySXFMY1RWUWl5dTdvekNtN1B0VUJm?=
 =?utf-8?B?OFZYRWpJV1kzUHJlTUdBbUR4Q3EwSE5xQzQ0UzhtNi9Sd2hUSXB2Wk1tL2RQ?=
 =?utf-8?B?ZEZUQjY4cnl2SGYwRlhpcGphbDBzMDBvRGZ5c25iOVF5bE5DY2dSdXVNN2Zs?=
 =?utf-8?B?TDVvWGZiWDBwRmFKaTJjOUJvVW5iRnozdDNhODk3WmVIR1lDRDlIWU5ZQjFv?=
 =?utf-8?B?eUd2RUJaVlFWSytSbWFVMUEyc0hiUUhPc0h5WHhBNmpRamJaNVRTQThFRjl0?=
 =?utf-8?B?T3g2VzlSTVVSUStDbnRPMjRWaXAva0ZYdmlzb21VNUZqbjhFV3IweUlmTjNs?=
 =?utf-8?B?SzlXNVdiVHFieitlbmxzaVNaUXRrNmJjSFAwcm1TaGZaUC9tb2FlS3JLRE9y?=
 =?utf-8?B?ckZ6TDJPaVEzWmlBaGtSd0psMWxvV25jL1ptdTA2RFRnMXV1N3JuWVRpVVFU?=
 =?utf-8?B?WnZoSkFYMGYzMGZpZ2x6Y1NGWG5ORmRYV0ZSa0E4M0VGdjhUZUVjOEFvYkp6?=
 =?utf-8?B?am5qVURBdFhDMW1kLzJNU3VXWlp4a0VZT0pNS2F2T1NKc0hsWVFZWE9BSkFW?=
 =?utf-8?B?SFFyblpXUTNxRFhpOGlFTXVQUCtYbys1VHRXQ0pSU2RYdXh2Wm8vVE1uRVQy?=
 =?utf-8?B?ZkdjdzJ4OXhnaGd0VFdnUXNWQW1PWThGbys4U2Z1cW5Fd05IL1ZWT3E5a2VK?=
 =?utf-8?B?VUNua2pHSmNrYjA0b2xlNkNLMFU2aFJjMkZsL3gyL25mVFRQOVJxKzA2TnpV?=
 =?utf-8?Q?BaSHBwYJTl3n9K5YvWuBgWcZb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb56b9a-b29d-4547-6cac-08dcfeef02b3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9354.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 05:42:47.6981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74fvoQnsMgpdZiqGIj6kyzRj6h+mF0odvvhO1dRrD4JIYZWXq6Po387YA8FwTsAoeV4WHvc8dsTgLIw9p/9rmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8434

The Security Violation module requires below System Controller
Security controller API to interact with SNVS block via SCFW
    - imx_sc_seco_build_info
    - imx_sc_seco_secvio_enable
    - imx_sc_seco_secvio_config
    - imx_sc_seco_secvio_dgo_config

Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Horia Geanta<horia.geanta@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 drivers/firmware/imx/Makefile         |   2 +-
 drivers/firmware/imx/imx-scu.c        |   4 +-
 drivers/firmware/imx/seco.c           | 216 ++++++++++++++++++++++++++++++++++
 include/linux/firmware/imx/ipc.h      |   1 +
 include/linux/firmware/imx/sci.h      |   4 +
 include/linux/firmware/imx/svc/seco.h |  69 +++++++++++
 6 files changed, 294 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 8d046c341be8..7aaecf570c56 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
-obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
+obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o seco.o
 obj-${CONFIG_IMX_SCMI_MISC_DRV}	+= sm-misc.o
diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 1dd4362ef9a3..c96dc73689a8 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -242,9 +242,11 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
 		 * APIs are defined as void function in SCU firmware, so they
 		 * should be treated as return success always.
 		 */
-		if ((saved_svc == IMX_SC_RPC_SVC_MISC) &&
+		if (((saved_svc == IMX_SC_RPC_SVC_MISC) &&
 			(saved_func == IMX_SC_MISC_FUNC_UNIQUE_ID ||
 			 saved_func == IMX_SC_MISC_FUNC_GET_BUTTON_STATUS))
+			 || (saved_svc == IMX_SC_RPC_SVC_SECO &&
+			 saved_func == IMX_SC_SECO_FUNC_BUILD_INFO))
 			ret = 0;
 	}
 
diff --git a/drivers/firmware/imx/seco.c b/drivers/firmware/imx/seco.c
new file mode 100644
index 000000000000..2d6bf301ac87
--- /dev/null
+++ b/drivers/firmware/imx/seco.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2020, 2024 NXP
+ *
+ * File containing client-side RPC functions for the SECO service. These
+ * function are ported to clients that communicate to the SC.
+ */
+
+#include <linux/firmware/imx/sci.h>
+
+struct imx_sc_msg_seco_get_build_id {
+	struct imx_sc_rpc_msg hdr;
+	u32 version;
+	u32 commit;
+} __packed __aligned(4);
+
+int imx_sc_seco_build_info(struct imx_sc_ipc *ipc, uint32_t *version,
+			   uint32_t *commit)
+{
+	struct imx_sc_msg_seco_get_build_id msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_BUILD_INFO;
+	hdr->size = 1;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	if (version)
+		*version = msg.version;
+	if (commit)
+		*commit = msg.commit;
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_sc_seco_build_info);
+
+int imx_sc_seco_secvio_enable(struct imx_sc_ipc *ipc)
+{
+	struct imx_sc_rpc_msg msg;
+	struct imx_sc_rpc_msg *hdr = &msg;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_SECVIO_ENABLE;
+	hdr->size = 1;
+
+	return imx_scu_call_rpc(ipc, &msg, true);
+}
+EXPORT_SYMBOL(imx_sc_seco_secvio_enable);
+
+struct imx_sc_msg_req_seco_config {
+	struct imx_sc_rpc_msg hdr;
+	u32 data0;
+	u32 data1;
+	u32 data2;
+	u32 data3;
+	u32 data4;
+	u8 id;
+	u8 access;
+	u8 size;
+} __packed __aligned(4);
+
+struct imx_sc_msg_resp_seco_config {
+	struct imx_sc_rpc_msg hdr;
+	u32 data0;
+	u32 data1;
+	u32 data2;
+	u32 data3;
+	u32 data4;
+} __packed __aligned(4);
+
+int imx_sc_seco_secvio_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+			      u32 *data0, u32 *data1, u32 *data2, u32 *data3,
+			      u32 *data4, u8 size)
+{
+	struct imx_sc_msg_req_seco_config msg;
+	struct imx_sc_msg_resp_seco_config *resp;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_SECVIO_CONFIG;
+	hdr->size = 7;
+
+	/* Check the pointers on data are valid and set it if doing a write */
+	switch (size) {
+	case 5:
+		if (data4) {
+			if (access)
+				msg.data4 = *data4;
+		} else {
+			return -EINVAL;
+		}
+		fallthrough;
+	case 4:
+		if (data3) {
+			if (access)
+				msg.data3 = *data3;
+		} else {
+			return -EINVAL;
+		}
+		fallthrough;
+	case 3:
+		if (data2) {
+			if (access)
+				msg.data2 = *data2;
+		} else {
+			return -EINVAL;
+		}
+		fallthrough;
+	case 2:
+		if (data1) {
+			if (access)
+				msg.data1 = *data1;
+		} else {
+			return -EINVAL;
+		}
+		fallthrough;
+	case 1:
+		if (data0) {
+			if (access)
+				msg.data0 = *data0;
+		} else {
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	msg.id = id;
+	msg.access = access;
+	msg.size = size;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	resp = (struct imx_sc_msg_resp_seco_config *)&msg;
+
+	/* Pointers already checked so we just copy the data if reading */
+	if (!access)
+		switch (size) {
+		case 5:
+			*data4 = resp->data4;
+		fallthrough;
+		case 4:
+			*data3 = resp->data3;
+		fallthrough;
+		case 3:
+			*data2 = resp->data2;
+		fallthrough;
+		case 2:
+			*data1 = resp->data1;
+		fallthrough;
+		case 1:
+			*data0 = resp->data0;
+		}
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_sc_seco_secvio_config);
+
+struct imx_sc_msg_req_seco_dgo_config {
+	struct imx_sc_rpc_msg hdr;
+	u32 data;
+	u8 id;
+	u8 access;
+} __packed __aligned(4);
+
+struct imx_sc_msg_resp_seco_dgo_config {
+	struct imx_sc_rpc_msg hdr;
+	u32 data;
+} __packed __aligned(4);
+
+int imx_sc_seco_secvio_dgo_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+				  u32 *data)
+{
+	struct imx_sc_msg_req_seco_dgo_config msg;
+	struct imx_sc_msg_resp_seco_dgo_config *resp;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_SECVIO_DGO_CONFIG;
+	hdr->size = 3;
+
+	if (access) {
+		if (data)
+			msg.data = *data;
+		else
+			return -EINVAL;
+	}
+
+	msg.access = access;
+	msg.id = id;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	resp = (struct imx_sc_msg_resp_seco_dgo_config *)&msg;
+
+	if (!access && data)
+		*data = resp->data;
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_sc_seco_secvio_dgo_config);
diff --git a/include/linux/firmware/imx/ipc.h b/include/linux/firmware/imx/ipc.h
index 0b4643571625..df38ab8e7e2e 100644
--- a/include/linux/firmware/imx/ipc.h
+++ b/include/linux/firmware/imx/ipc.h
@@ -25,6 +25,7 @@ enum imx_sc_rpc_svc {
 	IMX_SC_RPC_SVC_PAD = 6,
 	IMX_SC_RPC_SVC_MISC = 7,
 	IMX_SC_RPC_SVC_IRQ = 8,
+	IMX_SC_RPC_SVC_SECO = 9,
 };
 
 struct imx_sc_rpc_msg {
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index df17196df5ff..947e49d8bebc 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -15,6 +15,10 @@
 #include <linux/firmware/imx/svc/misc.h>
 #include <linux/firmware/imx/svc/pm.h>
 #include <linux/firmware/imx/svc/rm.h>
+#include <linux/firmware/imx/svc/seco.h>
+
+#define IMX_SC_IRQ_SECVIO            BIT(6)    /* Security violation */
+#define IMX_SC_IRQ_GROUP_WAKE           3   /* Wakeup interrupts */
 
 #if IS_ENABLED(CONFIG_IMX_SCU)
 int imx_scu_enable_general_irq_channel(struct device *dev);
diff --git a/include/linux/firmware/imx/svc/seco.h b/include/linux/firmware/imx/svc/seco.h
new file mode 100644
index 000000000000..508444c02d39
--- /dev/null
+++ b/include/linux/firmware/imx/svc/seco.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2020, 2024 NXP
+ *
+ * Header file containing the public API for the System Controller (SC)
+ * Security Controller (SECO) function.
+ *
+ * SECO_SVC (SVC) Security Controller Service
+ *
+ * Module for the Security Controller (SECO) service.
+ */
+
+#ifndef _SC_SECO_API_H
+#define _SC_SECO_API_H
+
+#include <linux/errno.h>
+#include <linux/firmware/imx/sci.h>
+
+/*
+ * This type is used to indicate RPCs/RM/SECO function calls.
+ */
+enum imx_sc_seco_func {
+	IMX_SC_SECO_FUNC_UNKNOWN = 0,
+	IMX_SC_SECO_FUNC_BUILD_INFO = 16,
+	IMX_SC_SECO_FUNC_SECVIO_ENABLE = 25,
+	IMX_SC_SECO_FUNC_SECVIO_CONFIG = 26,
+	IMX_SC_SECO_FUNC_SECVIO_DGO_CONFIG = 27,
+};
+
+#if IS_ENABLED(CONFIG_IMX_SCU)
+int imx_sc_seco_build_info(struct imx_sc_ipc *ipc, uint32_t *version,
+			   uint32_t *commit);
+int imx_sc_seco_secvio_enable(struct imx_sc_ipc *ipc);
+int imx_sc_seco_secvio_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+			      u32 *data0, u32 *data1, u32 *data2, u32 *data3,
+			      u32 *data4, u8 size);
+int imx_sc_seco_secvio_dgo_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+				  u32 *data);
+#else /* IS_ENABLED(CONFIG_IMX_SCU) */
+static inline
+int imx_sc_seco_build_info(struct imx_sc_ipc *ipc, uint32_t *version,
+			   uint32_t *commit)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline
+int imx_sc_seco_secvio_enable(struct imx_sc_ipc *ipc)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline
+int imx_sc_seco_secvio_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+			      u32 *data0, u32 *data1, u32 *data2, u32 *data3,
+			      u32 *data4, u8 size)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline
+int imx_sc_seco_secvio_dgo_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+				  u32 *data)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* IS_ENABLED(CONFIG_IMX_SCU) */
+
+#endif /* _SC_SECO_API_H */

-- 
2.25.1


