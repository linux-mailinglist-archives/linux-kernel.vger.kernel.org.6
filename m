Return-Path: <linux-kernel+bounces-399344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E359BFDBC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6741F2322F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB36A192D8F;
	Thu,  7 Nov 2024 05:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ir0vdmY9"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2068.outbound.protection.outlook.com [40.107.247.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7AF19258A;
	Thu,  7 Nov 2024 05:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730958171; cv=fail; b=mkF+QH32+tJ7Lf+NvHt2/V0XeDQZwMaNgOy1ty4qtNHdIaa/M/x4VImbMQ5hcBtLgGJVGsV265gPMqq66UyxM5K9GOgRiua+rAzlZU+ZfKdWL3hzrOAgaXeY/4BOvfK/GdFwzS3HI/dDfQFPrMTSgwM8VusK7/X4BFkukhw+y3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730958171; c=relaxed/simple;
	bh=ivoi9ar5X+xjANUIH6gyC/gfN1b8Jbl67jo4vegvQqg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=A33iRBUjPFRNoF67nqJhiFL4vtsLOgAEIsKJ4s+0nUNKizh2E0H1dyTW2VDWAMxmgx7crqUEV9Xzhkzh8Pn7nf/QbUb1xGV/blLvg/y7taouWeKdkJroVdeXQ0aQTAVczvdaMtm4jaNnG0r1qHqkTJDpwzk1aeBFtiSsrED3y5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ir0vdmY9; arc=fail smtp.client-ip=40.107.247.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFRA4ggV+SkJdqvjDo9Px6+J/UB16Lll6eo0AMye63xD0ZVW8Fh3qOJaFVT1vC4bNqwitaKO1Pl9tvGEtuldLZGgWYESkjU4SWuAU/Ao/cfzPAewjfdIG/EYZ//mhQ4Am1gKmv0dpEG/F/T+XEmVWrikFzcCt0ITcf0BkBDiYhFnmj1ZRrLwWcaMSMSxoW6IZExboMdGboKWBfcMPfMCwtGL5BPzStaV13AJrUpTx+4ChPy+2dHB/lEq9sWoFvuSzSZutDcpg4h5d2R36yJ4UIpT3C2eKJqHncWLJ+BeGrGr66sfMtfrzBcG7dveAebMBRJMUkcz6SdAYCRTSS/aJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vg4SPtxy/2UAd0wMlLzldmusRgTeeUO7+lUD8JB27Ho=;
 b=kjxUHMUEyxRpdPUpWHA2Kn3cbjU+ZzxRbDfe9smsq18qmolhcxvhk8O4oV9uyQFWYvNRcpgB9y0Axj1erUiE9ZSyq0OAEYpkLBj8OZuSmuOqYNOj5Zn7mxhnWsd6dc0R4OJfthT5/cV26oQhG2oSbxfFESShEgRHh92NexJ1dsaiwWQMc18AL6O2DvZ99k3Yep0B+3meXRViBtWxSu0cUK+PR+Vf8J/OPLKoKH/aB/5DZZeowcB3B+gCNnq2ryrMMu+m5gIsIJjtqQ9tWDhkqbNqT5ElU2ZhI2qd+a/opHdCvl1ss7mnDgqUUVUeUuDQ4+uRd3TrycSu/k50ccRlWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vg4SPtxy/2UAd0wMlLzldmusRgTeeUO7+lUD8JB27Ho=;
 b=Ir0vdmY9JMhrSzEHYaJU7/wCa2XDOUb7uNhoUcDA9tHJz7SrlTD+tCClFBFsmJSZiYA25B8zLx7dQx+a/4JFbybkLs8Ruj853vXT/YYXPJ0iyquG32ZBqqw3PZl/zVEfcMsJ1HkN/uFGvYzQdSjz3o2V9AJJcdwRPGzdHyTaVzwB+WljerarozFNw6jiK7iZWzvO8D+EmPCvByKuhLI3D/IchN6k7EmIwjtXMKWF1MGgSmOLNzTH6MZ/kXGKRII4p3f1P5jnLVOP0mipW2qD3crQ+Cd3EaOugKd/3rUiQlSfm8d7X+XwsDPiJq9Nhb3AH+a1vbQ8dlJgx6Pyvxp6NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9354.eurprd04.prod.outlook.com (2603:10a6:10:36c::10)
 by AS8PR04MB8434.eurprd04.prod.outlook.com (2603:10a6:20b:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 05:42:46 +0000
Received: from DB9PR04MB9354.eurprd04.prod.outlook.com
 ([fe80::3cd3:1ff0:8bae:a7ab]) by DB9PR04MB9354.eurprd04.prod.outlook.com
 ([fe80::3cd3:1ff0:8bae:a7ab%4]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 05:42:46 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
Date: Thu, 07 Nov 2024 06:42:39 +0100
Subject: [PATCH v3 1/4] dt-bindings: firmware: imx: add nvmem phandle
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-secvio-v3-1-ea27f1e9ced4@nxp.com>
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
 Vabhav Sharma <vabhav.sharma@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 932ce2e2-42f8-4991-011c-08dcfeef01de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXVZN0wvU29vdGFvZU9tci9FdVBhWWEvMEhHbmlaVDlEMnpDQUkrVmlMcWNz?=
 =?utf-8?B?aERvUS9ONUNqbXhMY1R2MUd5RVg4TGNIaE1mQTNhRFdQSmllcDdzVU9XNDFi?=
 =?utf-8?B?TE8zdmxIaG1XcE9XdlZ4NEMxNWNRdGc1WVZGUmFFVXVMbCtYakNXYXlOZWNI?=
 =?utf-8?B?VHB0K05Xc3Nkb21kZHNEaGZhOTlhSkRNbHdRZDBCdGx4dUVTYmhMNnZHUW1G?=
 =?utf-8?B?YkR2VkVZaE52UlhnY0U0L3VVRGsxaW9MVitIaVlIT2oxc2JrWEFjWG5rZlQ1?=
 =?utf-8?B?V0tzR0pvSlg2UituZHlibE1BRlNPTFArWHpyeXBKOThYMG1XdktpMVF2MnlX?=
 =?utf-8?B?SUZvRDkrWmZINlcvM01BVVVJUTBkUHNRTXBUckl5UEsvY2dxSGh1UkJ1THpL?=
 =?utf-8?B?T0F3cUNHWXhFekcwV0h2R0ZZemtNUmpTYXhwVy9zMldqeXhkeUNwUE1jZUgv?=
 =?utf-8?B?YjFoYWZvc3gveXpKMG5FbW1YNENXY0ZwMkxlanRsWlJuUUduaEJDUGF4RjRJ?=
 =?utf-8?B?UVN1Sk9GdC96MVl2V0tCU3NrVDRmMDJhaGNScWRISE85OEJWRHRsZnlMUGF4?=
 =?utf-8?B?c1AvQlFuZ2NSWVovUFFteDMycXlFbEltdzVENWxmaHZXYjIxR01JTm1jYWJI?=
 =?utf-8?B?TFVBbTNCWXdPTnhNclpoUVpUQkRFNE5XQ1J6dnJtU09pK3NjZXM0ZTNTUDVG?=
 =?utf-8?B?eUVYelRreVdiald4ZVZ3c0VBUWI0Mmw4bFRkNWtacXdkVlBldUh3TVVZNGlN?=
 =?utf-8?B?QmpzRHdsRzhkN3ZORU5nSGdPT0llZW1FU3BqZXNNTHUrOUFOYkhIUzlmVXh6?=
 =?utf-8?B?ZHhUeGtjM3IyQ3JjanUwWWRudUxJMEp2Z0loTklCMG5SZ3dIRGxVR0ZPMDRV?=
 =?utf-8?B?cHZMM3dLaksxNjh5dElqK2NlQzdMTEFQL2ZzR1VGc3VXNzVvVmgzUGVxbDYy?=
 =?utf-8?B?VFBJUitlaDJPNE5zdTVvMUdXV1h0MVRydFFybFJxdkZoWC9KQUZoUXcyUHBq?=
 =?utf-8?B?YkdiTGxyWmJEUnVKZUpsYUNCRUQ3cEZNYTNLTzJzSkpVL1NTUFFUdTFpTldH?=
 =?utf-8?B?NGVWdWVHRThmUjRUeDJzUGNISjE0eW9QRnJ3ZkV4aGtkMG50ZTdJMXUvL1Bh?=
 =?utf-8?B?KzdoUytqeDZxbjV6MlpCeUlNZ00xZEtQSzNscFNtbTh5Nm5ZM21ZTTQ2TDJv?=
 =?utf-8?B?S0MyME1haGEyK1dBU0NvSFk5SVZHVE5RbVhnUEk3ZHlhM3ZYOFRQYUVLa0M5?=
 =?utf-8?B?c1Z2bzNPK2NsNWtIc3Fmd2pPZTdKQVhEQVl2VEl4dnRsVVZlaTRqQ1J6NFF2?=
 =?utf-8?B?L3ptUGd0ZU1sMFVOMWNNV2N2eXhEUEJEdEk0VDEzYms3TElPMUxPVkNqemR0?=
 =?utf-8?B?ODd4MU00dEgvd3o2aDZsMXlkREZzenNTb3dxU01yMERwRWZhRFJjT3grcCt3?=
 =?utf-8?B?SFRHdklCSGNJTG5OcFhyR1NmTDFRVnF2VXBENlpEWTRGb3V4dWh1alNhMnZa?=
 =?utf-8?B?SGt5ZDJDQUhoRm9pS2dLZlp1d2hVeHFEMVVhbTlubnN2eFFZWEhSeS9TRDhR?=
 =?utf-8?B?OFZVb2xKMnV4WWZjWkkwdmlqRUVGMDNZVUZScERuL0g5N2h3MHI1TEVENlpz?=
 =?utf-8?B?VklGeExid0dZKzBhNjRkR050Y0thMkhiV2paY2xJUDlXZUlDY0VVYWtsRXNT?=
 =?utf-8?B?WFZZeDN1ZVBTWXV0MXF5eGY5bFFOVjlRVUxhbkRzbmgzY2Vwb0hIcy9GdHFW?=
 =?utf-8?B?bXpqRkt0TzhhMC81V2lUVmkrTi9aNGZvckJubUo4U0cyZ2VVSUJUT2xQWGtM?=
 =?utf-8?Q?vMZopmgvTeRkO0FHpKDW7tBHWWZNCIbGZ5M4k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9354.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXpjNVBzRGdqOW4zVUc5QmZCMlQ0OTU1WFR0K2h4T0tkRGQ4b2ZEMDNZbDg2?=
 =?utf-8?B?R2dDNWYyQUlBNWo4Y1ZrRjhHYU90L2RlREdobUI4bVNwei9KUU1BcFQyVUs0?=
 =?utf-8?B?c1MrV0Z1K2MzWVpQSHNXdGp0UUwyVEVJd2hWZ2tqWjNZNG5VM1lkdzlYZ3Fl?=
 =?utf-8?B?bGpQTExQVGFWcCsvQ3J3aTBqTDh2a2ttOUNpNXFZYi9EYThiNitzcnBaYTlk?=
 =?utf-8?B?cTA0bXplWHZPOFFXMjBTd0h2ZytNY2twTmdaUC9UbCsxaW80RkVxeExTWk05?=
 =?utf-8?B?VmFyRHRoMGJkQWM1N1Q2VWozakR0K1pHeDJtR0kvNkNkbHBFUmoxcEhBbk1F?=
 =?utf-8?B?K2JsQTJFSktSd1gvS3c2ckVCeUllYmF4eXViNEQ1YkFodUs1WUhWcCs3SGtY?=
 =?utf-8?B?b2ZaVGYrcDY0MS83bkRkcXlvTEk0UFpqSmlndXFuVWREK1JOUWxCY0xWSGxn?=
 =?utf-8?B?dzE5RTRWYkszbmY4M3Z4T0tPQ2lrRjRxYTQrUWtTanhleXVUMGtrUVBOL3FL?=
 =?utf-8?B?b016UnJkYnBBWDNiVDhUaFNZdEh3RkhpeXBiUzg5REFxVE1oWGZ6b1VoMEpq?=
 =?utf-8?B?a29OTlR0NTJhSnR2M1lVU1Z0QldxRzBjenlmeDM0c3VIRjhrYzRicGtVUEJO?=
 =?utf-8?B?aVNxRDduaTFHdncxWlRHKzdMdHZReCtGd1FENTRoSisvbFpCOEVDY0Y5RFhP?=
 =?utf-8?B?b1FUUjI3T3kzS1djRWZaZlMxVUQvdWMxYkFqY1dQa2xnZUIySlVVTzNmY1JI?=
 =?utf-8?B?eG55TlpjbUdXOG9nZWVLeXRpMDY4ckpXUEhoV1pBYlpWazVtcXZVUlJXRk5n?=
 =?utf-8?B?NFhQeW9YVTNvUHBQc1hUWlhGamdtU3ljOFhHN3ZDRGVnT0VleFBiQkVxYWNB?=
 =?utf-8?B?amJUdlNObUhHbzRJNHNXckc1bU5oY0NERHFhWVNHYkZlc3ZnUU55VWVSQys2?=
 =?utf-8?B?dnM2bzRCSDdiQjN5WjhmS2dHU09UN1N0OTBtb0JDQ0VZdnpjdDdXdHZpNnMz?=
 =?utf-8?B?T3F2djlYaktJM1F2RjBaVTVlRWc3RXMvVUpNUGg4b1lkLzhHQ0RJdFNiWFZY?=
 =?utf-8?B?bmpTUzg4Z2sxbXo0WWpqcXI2Qlo4eWsrRTJ4cFc0U1E2VjIzUGdaVFNNclZw?=
 =?utf-8?B?NTNkMC9NWFREbUdTVnRpeFNjV3ZxcllqTkhsVytEdCtMcGZvUW9OR09RWEVL?=
 =?utf-8?B?VGQ1RXh4Zjc0c3FPOVk3UFAvRlNqWmJiSGZHcWMrM2E0SDJhSUlaQk45bVdx?=
 =?utf-8?B?U1lvcGxiTGFNZlFYZmdJd2dialllZnVjWGV0TTB3bFh3SnBVZzd6ZFVMWldy?=
 =?utf-8?B?STlXN3lUd2szTWwzTUJIRVE1dkZtc3oraDBtV0E4eW5BVHJnRDZ4T09hVC9N?=
 =?utf-8?B?d1FEUHd5cFBaVVBFUm1xYnEvVGpJaCtvK2hNWjNzczJCcGtGMmtkM2VMWFVC?=
 =?utf-8?B?ckNTcEJOWklGeHhSSVRnZUFReFJ5RHFxK3ZHV0pXdndJM2wrcTV1U245Z0FI?=
 =?utf-8?B?RUUrVzZaTXRvQVdQQ3Z2Q05tSU9IZWFWUWVrNFVuQW9QUG12dVhkNUl0Uits?=
 =?utf-8?B?elFYWnU2bDFMV3VELzR6OEcvZDh1c1F4d3I4YXExczd3V2hRSU1nRXd6ZEFH?=
 =?utf-8?B?U3ZMWWIyTVdlN1J5QnlZL1dkcm92TVJEUGpkbEt2ZS81UjNHV3VkWnRZdWQ0?=
 =?utf-8?B?T3F3YlljQXhhRkt1TnExSGZaZTExQTJQakhQV1hZVmFQTEZ6dWFBdVQwMjM4?=
 =?utf-8?B?azc5TVpENUtSUFdZU2YyTWpaUDUvekYwNVhVSG0rNlVnWXRzcTFiN0ZSaXd1?=
 =?utf-8?B?aHBZN2VJK2s2UGpOR0E2ODhmRTJBRjlhWTBmNGlwMTZFbDdhdW4yd3F5bndJ?=
 =?utf-8?B?MnhIbE0vUm12N1hHUFFMMkdnMlFEUXZBYmMvUkwrMTlNVVpBWmtnd1JZNTBx?=
 =?utf-8?B?dW1jZ3Y1WlVwQ0Q5LzFOQWhiR2lkaHdsRnpCR1VVdnVkeThrOUhvMVdnTEVG?=
 =?utf-8?B?enBydU9QWG9nRWVEVTZJc2VyemxGSDBudlJXY3RWWXp1NkRyUE9wNnV1Zmh1?=
 =?utf-8?B?aVRRemlhVXJOeUxnK1VhV1RnUCtWYlQxVTFWRUdWQnVrNlhwaUJkMTVSY3dQ?=
 =?utf-8?Q?BJy39CZknDLuIAgxFx2D/FIGQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932ce2e2-42f8-4991-011c-08dcfeef01de
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9354.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 05:42:46.4165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPKtmlcy9ZskKl73Cs3UtCAr0S0outFszhp7+5Y4dd0mWPav/rWwRCUWD1tmcKy467Vf9+KyHzIySG2Bt36YWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8434

nvmem phandle is required by secvio driver to
read fuse.

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 Documentation/devicetree/bindings/firmware/fsl,scu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
index 557e524786c2..1cc86fed6c27 100644
--- a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
+++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
@@ -112,6 +112,9 @@ properties:
           - const: rx2
           - const: rx3
           - const: gip3
+  nvmem:
+    description:
+      phandle of NVMEM driver provided by the SCU
 
   pinctrl:
     description:

-- 
2.25.1


