Return-Path: <linux-kernel+bounces-555862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A26AA5BD8C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DADC73B2AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2730023314B;
	Tue, 11 Mar 2025 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aA8e4OwR"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0034D23718F;
	Tue, 11 Mar 2025 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688216; cv=fail; b=qCL1ujukueiTBB0ffrNK7QQXhzlCoF6n96QYGrM39t/SATWPw7AG08Cc853edviHwMtK8K+jExdLPs1VrnFC5aKnadCkhbvKhxZDpdkPx+eKQnZGYuEU2GBXEeYZtgY2cwgmXkLQeMpljB7nv2a6MLRfwMt3B4Z7ASJSr1EHs5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688216; c=relaxed/simple;
	bh=badSsJphAR9Ha3eBcAjexsirzd+CG17bvYncxa5iYgo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZjAKYJSGnywGXMqpzFJ7RYRPGFLcxcLVCcxnvDzuoXMumS7NaP2jpLJQDxI2CfLy2ggOZXwMLAQrWW0mjEU02vTLqo7+K2byRxz6lmssu5eMICSNJ8Sz4hqH8iJR1iS8XMYVbiCiCfgso3yYv2wa5zEqofhnuhDVhcMCmogLExU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aA8e4OwR; arc=fail smtp.client-ip=40.107.22.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFEhxXZVAlft81qMgx7nqfubgzLWeUhPXgSEYNGyzYZsDzJKJhzZ0obNhUWWMcbJZiNF2mB7lIStDarE/TKUwq0hM2EFxrUJ3epK+C5p9+AYiT7Hi/pGgFyHEh4aiTg1HEvSrLR5cR4Lxhaka1s1+RAm5USQcV3Am682cTxHYHW6llAp4PVILivF9a6kdApAsmil88S5SO9C/THQHOdtGR7o3UJJQHAgv3XIYr1TJLBR4TK/OoLnwa/6WhCw2VBefi/kLFeAIrCNzXN4RxDOf6E/Nwy0L5Ju5yO4UJ1M2ED/E18EUfXNf+1acK/jlOyRfwWaejwVZHR7ZEZjq6il+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blzDoqMNRpcTmBBNoP0cUp0+QAt/V8L2RCiAPhABTI4=;
 b=bROmnXAQL0RkRnQf8hUNhIxsRZO+nElQVSIUNGeRMXm5Qw0h7MTnh/HdJdGdRLS+n2xvhmYT7wMuTSmxreSMOxhwARyN7sIutwEPsLH/7Xp0oHKRJXyAKnzpIlzGT7/4MMdwscMIzn0W4ciND/Vx/YrliVwnaARDwTO7rQMpvmzLQXdpQeeG1GmOSerBtBUU1ApgGlbrPE2gr1elUWODwsNjNSGxKvkw8rT7oQC6KbjeNlrgiwZvvQBu1YQjrDGZSJvUdfUU5Y5+ByPo6/RXVkI/O+59KaNjOC6CCeO5vYNnnxoItE5qYVmfMSyHNOtYVOaeETisoBJkE8LPy/FuUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blzDoqMNRpcTmBBNoP0cUp0+QAt/V8L2RCiAPhABTI4=;
 b=aA8e4OwR1XiExU/LxNTHLCJGxZjF/AD6NmpJvkmNk1PedLPcNHICpWSF6NOW6JRDFTJ5BL/ojkuWOGcdjH6jA6lxRLEOICZKz8/QCiQLxt1m60I+LAIle34qJWDooav/keJo/L5AhCe32LgPod9l27hjB3aO9L25fmsIJ1hMvrBFxjKBTTVlxKihqOlD+uKJT1U9WOkMrlCOuo/dhxaUH+M0EkbgX9OWQptqFMKksb/+XiOYVXMCeAM9wb6EFjzOj12lmNTOZDH9lGqT8GZopyWLP4b60UdngxRtEKinbnRa2PCPsiWpyfO5mR16FhKqUDXHS1HiJYcG/JFdzQZ3bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS8PR04MB8449.eurprd04.prod.outlook.com (2603:10a6:20b:407::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 10:16:46 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 10:16:45 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Tue, 11 Mar 2025 21:09:35 +0530
Subject: [PATCH v13 4/5] firmware: imx: add driver for NXP EdgeLock Enclave
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-imx-se-if-v13-4-9cc6d8fd6d1c@nxp.com>
References: <20250311-imx-se-if-v13-0-9cc6d8fd6d1c@nxp.com>
In-Reply-To: <20250311-imx-se-if-v13-0-9cc6d8fd6d1c@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741707617; l=41618;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=badSsJphAR9Ha3eBcAjexsirzd+CG17bvYncxa5iYgo=;
 b=m8ImkwsK84BwAxpFJiwXVorPPxK9NxBGnCJagx6mCXpBiYsxjO+4EVWnEseUcyc2nMAwbCmCZ
 vthZSOIAQZ1ByTbGhr0NqtDpauZHuDZXwGXJ8LsWg6s0cYhLvl7D87H
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2PR02CA0094.apcprd02.prod.outlook.com
 (2603:1096:4:90::34) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|AS8PR04MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 73397eee-e1d7-4899-1857-08dd6085d348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHlhOC9TZThkQmlaNUx0c0Rydm1ZQlFlWEdCRHhweWRQd05hYXpMRE1JOVNt?=
 =?utf-8?B?SzMzSGNRWFFGemxyUC9FczZpaG1NR0VXa3BrNVVOUUpDUnJzUENqZHQwU2tB?=
 =?utf-8?B?UTV3MUgvdTBvNEtLQzdrWWt5cXBFWjNYb0IrR2tvRlZPMUJNelRaT1htL29m?=
 =?utf-8?B?QXhmdDF1LzZjZThqVUxxeFBpMi9PWVhlWkJmbTljMmRTQ1Q1R2lrL3pJd00w?=
 =?utf-8?B?RTZkK1BJM0EzZEh2STB3Y0xvaWpmSWFQSGRMWFhiOVpIUTF2ckhZN3NkVXdn?=
 =?utf-8?B?SjBUWU1YYjlaUWs3RXU1ekpNSkp5d0pBUXZoUGJ0YjV1QXNIU2dkQnZhQ2M0?=
 =?utf-8?B?R2JqYlNzaUgyNkFKdEd4YXVpa3AyaVNCa1J0UE5ZTWJqcGpQM1lWaXVSVTEz?=
 =?utf-8?B?TVlva0NqcnFWMUdzUXUyMjRNcW5JZlgvN0V0REF2UnQ3SzdVSUd5YXM3MTFN?=
 =?utf-8?B?MTZBZHI4eUpua0NDYUlOVDdkVGl2STlRTWtLOXdzMVJkK3ZMZGdTajl5dU1v?=
 =?utf-8?B?eXJNd1FBc1dPZlBWQ0ZQNjluc0lJWEs3NFZJSjhYZ055RGdReTZFbzhrbitM?=
 =?utf-8?B?WWdxbXdvdldxUzZLQjBvcXFuNGtGZEJxWDJQNDU2VDJRbDBiSzkwSVJzYkI4?=
 =?utf-8?B?ZElLRjEyR2VQZkVSdWduRmFaRG14SGJvcUMxaG1DY3lPdjRXb1lGb0ZiY20y?=
 =?utf-8?B?R3VRUi9pc2NvbS9SNDBubGhCdnZyNjl2K3RvTHdyeTh2Zkdra0VMUk9mNWtp?=
 =?utf-8?B?bVVyZjFuaFVrMi9vOExnUkdBMi9kdjZnK2xwU1daQUc5dnBkZEdVdDVGRWlC?=
 =?utf-8?B?K0l3Y29ESjZ6UWgrQ00rSGx5VklDV2U3bUpPNW9tQnJ6NjB5U3FYMWFKSUZE?=
 =?utf-8?B?UFZwQWhWTi9CdEo4ZzdFa1ZQWHV1LzcxZHJ1elVwUTJoT1lCYVU3VitQa29m?=
 =?utf-8?B?cHlFRlg1UWdvaVNxcVZnS0lUUklRK1B5U3JocGkycDBCbU8reDNxMXJFbDRR?=
 =?utf-8?B?WUFRUG9hQUhJenVwN3JBRGM3VnVKUFBJbFpLdGFjVnN0R1JUUE1ZdHdTclRC?=
 =?utf-8?B?MVVHamlhekI2R2p1TGg3UFRyK2ZQNUVsUnYwQkhHclE5S1pQQ1laMVM5bzFP?=
 =?utf-8?B?Ky9QQ1BjVWZ4SzFaRzNqM3ZmUXE1UHRrZFR3WHlqaHQwa0hTeFY4aWxkZFhp?=
 =?utf-8?B?Wjd4dUJ6dC9LNXM0MnRibHBXaXhIYktEclBKckFnU3F4SGwzVmppTGdreExH?=
 =?utf-8?B?eUs2ZkptQlh0eW51enhaTy90b0g0d2c3Y1Ard0VpRk5CTjYzc0FWNU8vWElE?=
 =?utf-8?B?SU8zNklKazk5QXFObm01RkgzSnhudnZ2Y2JnSzg2U0l6aER6bkdXcnlyTmk4?=
 =?utf-8?B?L2g2OUV1TXpnQ0pmRDEzK05jTjRPbEJVY0tjRXJWSXhCc1pWRmRuMFdwalJR?=
 =?utf-8?B?UXVGMWdVUWUzMC9FbVR2N3Y2ZUVoRzBCTkVqWG9ZcjB4Rm1oNWl0czFJVWoz?=
 =?utf-8?B?MTl0TWRneGkwYUxrbGJGMm9GbzljN3NBUVN6dHoxL3YxbGJvWnE3YS9TMldo?=
 =?utf-8?B?RVgyUTFWQ1V3d1dibWhzc2U3andsdEFEb0RxdXBINit6WlowWGVvY0pkODhk?=
 =?utf-8?B?S2lLRjJxVVBPN3Q0N2JuQTBULzNTSHNtNXRRYTV2MW1zM2ZOVnNpdXgrTGgx?=
 =?utf-8?B?engzUVhzbXVUUWdqUnArMFlyK1o5ekNsdmFRQWVBeFNBUDFTMHRqeGpHdGFj?=
 =?utf-8?B?ZmNYckMyVHBpVU9nMTNDZVZaTURITHR3QkZpTGJYcDZ2cTZpeW5JbzYwdkIy?=
 =?utf-8?B?bWZSUXNTZlZLK2hMZ20vZldmL3lhY1FDR3hxSnFEMy83WFByYjZQSTlJM29F?=
 =?utf-8?B?aC9kOWkyNzU4ZzVjOE1xYVEveVQ3T1V2WkFaZWFiWHZLTHAreU1NTjJ0VmJH?=
 =?utf-8?Q?jRpuRId/2MO/hw2DYTWxdZvK6wjv86ra?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2xhdU54bWJRalRjdWhML3ZiYlQxNndvL3pwOU5pT0hySEI1bmhpMXp4bWZN?=
 =?utf-8?B?cnZFcFhUcS93NUg2V3FSZ0hZNStJNmNBcVFGbWpxcGpZVGFHbTU3eklMMlR6?=
 =?utf-8?B?VXVBMmRCOEt4b1V5eTV1Q3ZiZTYyVUdHUHUvSUR0ZDNVMVpHanRuOWlLUERw?=
 =?utf-8?B?UkN4L01pS3JnMDlBVVE0S01wVFQwN21HTk8vQWJub0lLeXpJRTRKUWk3SXZF?=
 =?utf-8?B?bWhhU2FRb0w0Q2tsZ2FaS1lVdjRIb0txcFRqR2dvb3VJRXFRQ3pzVFNtZmsr?=
 =?utf-8?B?RkozZDhqeHVqWlBoZ2lnaUx0YVg3VEdOVXlTS1FZaG9JOE5XYmZCbzQvRkh4?=
 =?utf-8?B?OHBYQXhnek5WcmZJR1cyaUMxNjZpSmlLTEpSeU1HMmw1L0lScHdYWWErT1NF?=
 =?utf-8?B?VmZ0WEhxTkRpUHF6NVhTSUloaFU2VlMyQ0U3WTg0MUpGbUo0blZ2STVJTDdz?=
 =?utf-8?B?R3plQ2kwenkrUi9yK0ZZTmtmMmx3Y1lWRlJaY1VVVXdKRElHNDBQRkN0NXVZ?=
 =?utf-8?B?QjdSY0dhbTAxdEhPQzEvZm5sMXlXRG1GYlE1eVNoeXFtR2hHaFdabkduNUFI?=
 =?utf-8?B?emRld0RQc0xqYnpUTVN1eGFja1luVE9vU0lCUXVzUktMYXRhTy9oMWFwQks5?=
 =?utf-8?B?RFBLQmhxVWovNm9tSGNnWkpXMnZLZk9XMXQ4MUdHb1ZiUGk3OWFGUStkM1NP?=
 =?utf-8?B?NXljUXgxUlRUay9rbWgzc1N0S2JRMlF4d0w0QzdEOUdWbXNoQkQ2V0JSWVlu?=
 =?utf-8?B?eEZjRHEremFDVWNHVUpvQW4rVXlOTzlxVDlwV2wxVDNSekVRT0xaNEtHN1I0?=
 =?utf-8?B?d2pNdzdkTnZZeGRQcnZ6QVFCdko0QndTRm15dzg0QS91ZlpBMTBFOW9SbXM5?=
 =?utf-8?B?djlaaWY0UnBFckRObExXTWNXOU53LzdsamdGRk1YNmkzV2xjYjRKMXB6ZlZQ?=
 =?utf-8?B?QzVyOVVnK0VvZmFSVFQ4eW9zUWpqZjJ0NzROdzZ5MGg5aUVGVGtaNi9TZUJj?=
 =?utf-8?B?SkR3Qjc3OExaTS92SkpMYU1yK0NZUlhvRDJ1UnJUa2p1Ym1KelZWRnUyZFpt?=
 =?utf-8?B?aldBWUpwdUhka0doRmk1NjVsckw4d2ZZZVF6c1p2Ym1XR1VVc2hCSnRJM1ZS?=
 =?utf-8?B?bmpOc3lTcVJ6Rm54YWYzem1oOVJPMWdsRld1VWFsR3Y0VzhKWXJuUlQwanhW?=
 =?utf-8?B?WWFJQ0krbzV6ZVdJTXU0UzNveTY4NERzcm4zYTBORDVqUE1xT2FqWjhHOHZZ?=
 =?utf-8?B?N2lTRUNtOXhwKzhsZmZEeWFrUEh6eVdRSUlKRFVuTGxFNll1UUJnMVNlRjFC?=
 =?utf-8?B?Mkd6WjM4RWlkRFFuUEt5UWl6VmdRSlVXeFZNU3N6RDJWZDZNaCtyU3hhN05O?=
 =?utf-8?B?NkZoNzdFYWF2WEtIQ21DOE91Q2VEaFdPd0QvaUlBaEw5U0tsUnRhRjBFUTBY?=
 =?utf-8?B?NEo0aGwvTEVIVCtUN3hEVXNhZDJ1SWVwYmo4cDcxRUM3ZDBIenVCTlhBdFBH?=
 =?utf-8?B?Nm9WcGJRdSs5RTIxYy9YWjhRbE5Nbm8vVFdPelpkNXpSZEpWR3d2ZG12UnJM?=
 =?utf-8?B?TU1IaThXaXZGU3pBSCt6Nm0rVVFZZHg0NTBxb0M5ZldkdGFKUzE4cGN0Z3R3?=
 =?utf-8?B?L2k1UnhEdE5yVU4rUy83RjF3ZGtYTkFnMk9QbHBERkhrUDdpOWpUZ3J2bm9h?=
 =?utf-8?B?U2FZWHpneUJVZVdiK0wzQVM3QTFwYWFJbEJrNjhqSEJJdVlHTlpNZmdqRVF0?=
 =?utf-8?B?RmRuZEFuRStncEg2UFFuWXZ2a1hhQWlIR0lwSHduWG9WNGtSVkxuK1VpV1Qr?=
 =?utf-8?B?d0Q2RHlkUFhzVTdmUFlqTmE2UmhpWjU0aFJiV0p6YnR3aXZLU1RBdm54MzRp?=
 =?utf-8?B?c0JEdzVOQk1kc1Y2NVZWdGRmNWFRZHgrRWJ4UTczRERtMSt5L0ZFMS8vZW1s?=
 =?utf-8?B?dHVmUEZrenRUNEZjOTF2QkRMNjJFQjlxRW5vcklZU1I4S3FJYVNrcDNPLytT?=
 =?utf-8?B?elptcUhlb016bmxtYmNFS1JNc0QzRk1XcFRzZ0lYb3R5RWlKUXZGYjRsN0NW?=
 =?utf-8?B?QTJNWjJWbW5BMFE0bGlqa0lSL29PcHFqWFNvcXFZWjNRdFIrRmlnNE9HTzNW?=
 =?utf-8?Q?V160kC9W3hSioqAEgvWEQuqG8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73397eee-e1d7-4899-1857-08dd6085d348
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 10:16:45.5170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOly19BJvAwjtNR5v22ay6g4pZz3spJe+99fh+GsuVQ9aGD4LSxJoNTq7GbfDWL5TIKeMVMR2vOwenZtSEIWfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8449

Add driver for enabling MU based communication interface to secure-enclave.

NXP hardware IP(s) for secure-enclaves like Edgelock Enclave(ELE),
are embedded in the SoC to support the features like HSM, SHE & V2X,
using message based communication interface.

The secure enclave FW communicates with Linux over single or multiple
dedicated messaging unit(MU) based interface(s).
Exists on i.MX SoC(s) like i.MX8ULP, i.MX93, i.MX95 etc.

Other dependent kernel drivers will be:
- NVMEM: that supports non-volatile devices like EFUSES,
         managed by NXP's secure-enclave.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/firmware/imx/Kconfig        |  13 +
 drivers/firmware/imx/Makefile       |   2 +
 drivers/firmware/imx/ele_base_msg.c | 372 ++++++++++++++++++++++++++
 drivers/firmware/imx/ele_base_msg.h |  98 +++++++
 drivers/firmware/imx/ele_common.c   | 329 +++++++++++++++++++++++
 drivers/firmware/imx/ele_common.h   |  50 ++++
 drivers/firmware/imx/se_ctrl.c      | 503 ++++++++++++++++++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h      |  83 ++++++
 include/linux/firmware/imx/se_api.h |  14 +
 9 files changed, 1464 insertions(+)

diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index c964f4924359..8a487df77976 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -33,3 +33,16 @@ config IMX_SCMI_MISC_DRV
 	  core that could provide misc functions such as board control.
 
 	  This driver can also be built as a module.
+
+config IMX_SEC_ENCLAVE
+	tristate "i.MX Embedded Secure Enclave - EdgeLock Enclave Firmware driver."
+	depends on IMX_MBOX && ARCH_MXC && ARM64
+	select FW_LOADER
+	default m if ARCH_MXC
+
+	help
+	  It is possible to use APIs exposed by the iMX Secure Enclave HW IP called:
+	  - EdgeLock Enclave Firmware (for i.MX8ULP, i.MX93),
+	    like base, HSM, V2X & SHE using the SAB protocol via the shared Messaging
+	    Unit. This driver exposes these interfaces via a set of file descriptors
+	    allowing to configure shared memory, send and receive messages.
diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 8d046c341be8..4e1d2706535d 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -2,3 +2,5 @@
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
 obj-${CONFIG_IMX_SCMI_MISC_DRV}	+= sm-misc.o
+sec_enclave-objs		= se_ctrl.o ele_common.o ele_base_msg.o
+obj-${CONFIG_IMX_SEC_ENCLAVE}	+= sec_enclave.o
diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
new file mode 100644
index 000000000000..eea86f50d276
--- /dev/null
+++ b/drivers/firmware/imx/ele_base_msg.c
@@ -0,0 +1,372 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <linux/types.h>
+
+#include <linux/completion.h>
+#include <linux/dma-mapping.h>
+#include <linux/genalloc.h>
+
+#include "ele_base_msg.h"
+#include "ele_common.h"
+
+#define FW_DBG_DUMP_FIXED_STR		"\nELEX: "
+
+int ele_get_info(struct se_if_priv *priv, struct ele_dev_info *s_info)
+{
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	dma_addr_t get_info_addr = 0;
+	u32 *get_info_data = NULL;
+	int ret = 0;
+
+	if (!priv)
+		return -EINVAL;
+
+	memset(s_info, 0x0, sizeof(*s_info));
+
+	tx_msg = kzalloc(ELE_GET_INFO_REQ_MSG_SZ, GFP_KERNEL);
+	if (!tx_msg)
+		return -ENOMEM;
+
+	rx_msg = kzalloc(ELE_GET_INFO_RSP_MSG_SZ, GFP_KERNEL);
+	if (!rx_msg)
+		return -ENOMEM;
+
+	if (priv->mem_pool)
+		get_info_data = gen_pool_dma_alloc(priv->mem_pool,
+						   ELE_GET_INFO_BUFF_SZ,
+						   &get_info_addr);
+	else
+		get_info_data = dma_alloc_coherent(priv->dev,
+						   ELE_GET_INFO_BUFF_SZ,
+						   &get_info_addr,
+						   GFP_KERNEL);
+	if (!get_info_data) {
+		dev_dbg(priv->dev,
+			"%s: Failed to allocate get_info_addr.\n",
+			__func__);
+		return -ENOMEM;
+	}
+
+	ret = se_fill_cmd_msg_hdr(priv,
+				  (struct se_msg_hdr *)&tx_msg->header,
+				  ELE_GET_INFO_REQ,
+				  ELE_GET_INFO_REQ_MSG_SZ,
+				  true);
+	if (ret)
+		goto exit;
+
+	tx_msg->data[0] = upper_32_bits(get_info_addr);
+	tx_msg->data[1] = lower_32_bits(get_info_addr);
+	tx_msg->data[2] = sizeof(*s_info);
+	ret = ele_msg_send_rcv(priv,
+			       tx_msg,
+			       ELE_GET_INFO_REQ_MSG_SZ,
+			       rx_msg,
+			       ELE_GET_INFO_RSP_MSG_SZ);
+	if (ret < 0)
+		goto exit;
+
+	ret = se_val_rsp_hdr_n_status(priv,
+				      rx_msg,
+				      ELE_GET_INFO_REQ,
+				      ELE_GET_INFO_RSP_MSG_SZ,
+				      true);
+
+	memcpy(s_info, get_info_data, sizeof(*s_info));
+
+exit:
+	if (priv->mem_pool)
+		gen_pool_free(priv->mem_pool,
+			      (u64)get_info_data,
+			      ELE_GET_INFO_BUFF_SZ);
+	else
+		dma_free_coherent(priv->dev,
+				  ELE_GET_INFO_BUFF_SZ,
+				  get_info_data,
+				  get_info_addr);
+
+	return ret;
+}
+
+int ele_fetch_soc_info(struct se_if_priv *priv, void *data)
+{
+	int err;
+
+	err = ele_get_info(priv, data);
+	if (err < 0)
+		return err;
+
+	return err;
+}
+
+int ele_ping(struct se_if_priv *priv)
+{
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	int ret = 0;
+
+	if (!priv)
+		return -EINVAL;
+
+	tx_msg = kzalloc(ELE_PING_REQ_SZ, GFP_KERNEL);
+	if (!tx_msg)
+		return -ENOMEM;
+
+	rx_msg = kzalloc(ELE_PING_RSP_SZ, GFP_KERNEL);
+	if (!rx_msg)
+		return -ENOMEM;
+
+	ret = se_fill_cmd_msg_hdr(priv,
+				  (struct se_msg_hdr *)&tx_msg->header,
+				  ELE_PING_REQ, ELE_PING_REQ_SZ, true);
+	if (ret) {
+		dev_err(priv->dev, "Error: se_fill_cmd_msg_hdr failed.\n");
+		return ret;
+	}
+
+	ret = ele_msg_send_rcv(priv,
+			       tx_msg,
+			       ELE_PING_REQ_SZ,
+			       rx_msg,
+			       ELE_PING_RSP_SZ);
+	if (ret < 0)
+		return ret;
+
+	ret = se_val_rsp_hdr_n_status(priv,
+				      rx_msg,
+				      ELE_PING_REQ,
+				      ELE_PING_RSP_SZ,
+				      true);
+
+	return ret;
+}
+
+int ele_service_swap(struct se_if_priv *priv,
+		     phys_addr_t addr,
+		     u32 addr_size, u16 flag)
+{
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	int ret = 0;
+
+	if (!priv)
+		return -EINVAL;
+
+	tx_msg = kzalloc(ELE_SERVICE_SWAP_REQ_MSG_SZ, GFP_KERNEL);
+	if (!tx_msg)
+		return -ENOMEM;
+
+	rx_msg = kzalloc(ELE_SERVICE_SWAP_RSP_MSG_SZ, GFP_KERNEL);
+	if (!rx_msg)
+		return -ENOMEM;
+
+	ret = se_fill_cmd_msg_hdr(priv,
+				  (struct se_msg_hdr *)&tx_msg->header,
+				  ELE_SERVICE_SWAP_REQ,
+				  ELE_SERVICE_SWAP_REQ_MSG_SZ, true);
+	if (ret)
+		return ret;
+
+	tx_msg->data[0] = flag;
+	tx_msg->data[1] = addr_size;
+	tx_msg->data[2] = ELE_NONE_VAL;
+	tx_msg->data[3] = lower_32_bits(addr);
+	tx_msg->data[4] = se_add_msg_crc((uint32_t *)&tx_msg[0],
+					 ELE_SERVICE_SWAP_REQ_MSG_SZ);
+	ret = ele_msg_send_rcv(priv,
+			       tx_msg,
+			       ELE_SERVICE_SWAP_REQ_MSG_SZ,
+			       rx_msg,
+			       ELE_SERVICE_SWAP_RSP_MSG_SZ);
+	if (ret < 0)
+		return ret;
+
+	ret = se_val_rsp_hdr_n_status(priv,
+				      rx_msg,
+				      ELE_SERVICE_SWAP_REQ,
+				      ELE_SERVICE_SWAP_RSP_MSG_SZ,
+				      true);
+	if (ret)
+		return ret;
+
+	if (flag == ELE_IMEM_EXPORT)
+		ret = rx_msg->data[1];
+	else
+		ret = 0;
+
+	return ret;
+}
+
+int ele_fw_authenticate(struct se_if_priv *priv, phys_addr_t addr)
+{
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	int ret = 0;
+
+	if (!priv)
+		return -EINVAL;
+
+	tx_msg = kzalloc(ELE_FW_AUTH_REQ_SZ, GFP_KERNEL);
+	if (!tx_msg)
+		return -ENOMEM;
+
+	rx_msg = kzalloc(ELE_FW_AUTH_RSP_MSG_SZ, GFP_KERNEL);
+	if (!rx_msg)
+		return -ENOMEM;
+
+	ret = se_fill_cmd_msg_hdr(priv,
+				  (struct se_msg_hdr *)&tx_msg->header,
+				  ELE_FW_AUTH_REQ,
+				  ELE_FW_AUTH_REQ_SZ,
+				  true);
+	if (ret)
+		return ret;
+
+	tx_msg->data[1] = upper_32_bits(addr);
+	tx_msg->data[0] = lower_32_bits(addr);
+	tx_msg->data[2] = addr;
+
+	ret = ele_msg_send_rcv(priv,
+			       tx_msg,
+			       ELE_FW_AUTH_REQ_SZ,
+			       rx_msg,
+			       ELE_FW_AUTH_RSP_MSG_SZ);
+	if (ret < 0)
+		return ret;
+
+	ret = se_val_rsp_hdr_n_status(priv,
+				      rx_msg,
+				      ELE_FW_AUTH_REQ,
+				      ELE_FW_AUTH_RSP_MSG_SZ,
+				      true);
+	return ret;
+}
+
+int ele_debug_dump(struct se_if_priv *priv)
+{
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	bool keep_logging;
+	u8 dump_data[408];
+	u8 fmt_str[256];
+	int fmt_str_idx;
+	int rcv_dbg_wd_ct;
+	int msg_ex_cnt;
+	int ret = 0;
+	int w_ct;
+
+	if (!priv)
+		return -EINVAL;
+
+	tx_msg = kzalloc(ELE_DEBUG_DUMP_REQ_SZ, GFP_KERNEL);
+	if (!tx_msg)
+		return -ENOMEM;
+
+	rx_msg = kzalloc(ELE_DEBUG_DUMP_RSP_SZ, GFP_KERNEL);
+	if (!rx_msg)
+		return -ENOMEM;
+
+	ret = se_fill_cmd_msg_hdr(priv,
+				  &tx_msg->header,
+				  ELE_DEBUG_DUMP_REQ,
+				  ELE_DEBUG_DUMP_REQ_SZ,
+				  true);
+	if (ret)
+		return ret;
+
+	msg_ex_cnt = 0;
+	do {
+		w_ct = 0;
+		fmt_str_idx = 0;
+		memset(rx_msg, 0xCC, ELE_DEBUG_DUMP_RSP_SZ);
+
+		ret = ele_msg_send_rcv(priv,
+				       tx_msg,
+				       ELE_DEBUG_DUMP_REQ_SZ,
+				       rx_msg,
+				       ELE_DEBUG_DUMP_RSP_SZ);
+		if (ret < 0)
+			return ret;
+
+		ret = se_val_rsp_hdr_n_status(priv,
+					      rx_msg,
+					      ELE_DEBUG_DUMP_REQ,
+					      ELE_DEBUG_DUMP_RSP_SZ,
+					      true);
+		if (!ret) {
+			rcv_dbg_wd_ct = rx_msg->header.size - ELE_NON_DUMP_BUFFER_SZ;
+			memcpy(fmt_str, FW_DBG_DUMP_FIXED_STR, strlen(FW_DBG_DUMP_FIXED_STR));
+			fmt_str_idx += strlen(FW_DBG_DUMP_FIXED_STR);
+			for (w_ct = 0; w_ct < rcv_dbg_wd_ct; w_ct++) {
+				fmt_str[fmt_str_idx] = '0';
+				fmt_str_idx++;
+				fmt_str[fmt_str_idx] = 'x';
+				fmt_str_idx++;
+				fmt_str[fmt_str_idx] = '%';
+				fmt_str_idx++;
+				fmt_str[fmt_str_idx] = '0';
+				fmt_str_idx++;
+				fmt_str[fmt_str_idx] = '8';
+				fmt_str_idx++;
+				fmt_str[fmt_str_idx] = 'x';
+				fmt_str_idx++;
+				fmt_str[fmt_str_idx] = ' ';
+				fmt_str_idx++;
+				if (w_ct % 2) {
+					memcpy(fmt_str + fmt_str_idx,
+					       FW_DBG_DUMP_FIXED_STR,
+					       strlen(FW_DBG_DUMP_FIXED_STR));
+					fmt_str_idx += strlen(FW_DBG_DUMP_FIXED_STR);
+				}
+			}
+			keep_logging = (rx_msg->header.size < (ELE_DEBUG_DUMP_RSP_SZ >> 2)) ?
+					false : true;
+			keep_logging = keep_logging ?
+						(msg_ex_cnt > ELE_MAX_DBG_DMP_PKT ? false : true) :
+						false;
+			/*
+			 * Number of spaces = rcv_dbg_wd_ct
+			 * DBG dump length in bytes = rcv_dbg_wd_ct * 4
+			 *
+			 * Since, one byte is represented as 2 character,
+			 * DBG Dump string-length = rcv_dbg_wd_ct * 8
+			 * Fixed string's string-length =
+			 *                      strlen(FW_DBG_DUMP_FIXED_STR) * rcv_dbg_wd_ct
+			 *
+			 * Total dump_data length = Number of spaces +
+			 *                          DBG Dump string' string-length +
+			 *                          Fixed string's string-length
+			 *
+			 * Total dump_data length = rcv_dbg_wd_ct + (rcv_dbg_wd_ct * 8) +
+			 *                          strlen(FW_DBG_DUMP_FIXED_STR) * rcv_dbg_wd_ct
+			 */
+
+			snprintf(dump_data,
+				 ((rcv_dbg_wd_ct * 9) +
+				  (strlen(FW_DBG_DUMP_FIXED_STR) * rcv_dbg_wd_ct)),
+				  fmt_str,
+				  rx_msg->data[1], rx_msg->data[2],
+				  rx_msg->data[3], rx_msg->data[4],
+				  rx_msg->data[5], rx_msg->data[6],
+				  rx_msg->data[7], rx_msg->data[8],
+				  rx_msg->data[9], rx_msg->data[10],
+				  rx_msg->data[11], rx_msg->data[12],
+				  rx_msg->data[13], rx_msg->data[14],
+				  rx_msg->data[15], rx_msg->data[16],
+				  rx_msg->data[17], rx_msg->data[18],
+				  rx_msg->data[19], rx_msg->data[20]);
+
+			dev_err(priv->dev, "%s", dump_data);
+		} else {
+			dev_err(priv->dev, "Dump_Debug_Buffer Error: %x.", ret);
+			break;
+		}
+		msg_ex_cnt++;
+	} while (keep_logging);
+
+	return ret;
+}
diff --git a/drivers/firmware/imx/ele_base_msg.h b/drivers/firmware/imx/ele_base_msg.h
new file mode 100644
index 000000000000..b8c9d9e29ae8
--- /dev/null
+++ b/drivers/firmware/imx/ele_base_msg.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ *
+ * Header file for the EdgeLock Enclave Base API(s).
+ */
+
+#ifndef ELE_BASE_MSG_H
+#define ELE_BASE_MSG_H
+
+#include <linux/device.h>
+#include <linux/types.h>
+
+#include "se_ctrl.h"
+
+#define ELE_NONE_VAL			0x0
+
+#define ELE_GET_INFO_REQ		0xDA
+#define ELE_GET_INFO_REQ_MSG_SZ		0x10
+#define ELE_GET_INFO_RSP_MSG_SZ		0x08
+
+#define SOC_ID_MASK			0x0000FFFF
+
+#define MAX_UID_SIZE                     (16)
+#define DEV_GETINFO_ROM_PATCH_SHA_SZ     (32)
+#define DEV_GETINFO_FW_SHA_SZ            (32)
+#define DEV_GETINFO_OEM_SRKH_SZ          (64)
+#define DEV_GETINFO_MIN_VER_MASK	0xFF
+#define DEV_GETINFO_MAJ_VER_MASK	0xFF00
+#define ELE_DEV_INFO_EXTRA_SZ		0x60
+
+struct dev_info {
+	u8  cmd;
+	u8  ver;
+	u16 length;
+	u16 soc_id;
+	u16 soc_rev;
+	u16 lmda_val;
+	u8  ssm_state;
+	u8  dev_atts_api_ver;
+	u8  uid[MAX_UID_SIZE];
+	u8  sha_rom_patch[DEV_GETINFO_ROM_PATCH_SHA_SZ];
+	u8  sha_fw[DEV_GETINFO_FW_SHA_SZ];
+};
+
+struct dev_addn_info {
+	u8  oem_srkh[DEV_GETINFO_OEM_SRKH_SZ];
+	u8  trng_state;
+	u8  csal_state;
+	u8  imem_state;
+	u8  reserved2;
+};
+
+struct ele_dev_info {
+	struct dev_info d_info;
+	struct dev_addn_info d_addn_info;
+};
+
+#define ELE_GET_INFO_BUFF_SZ		(sizeof(struct ele_dev_info) \
+						+ ELE_DEV_INFO_EXTRA_SZ)
+
+#define GET_SERIAL_NUM_FROM_UID(x, uid_word_sz) \
+	(((u64)(((u32 *)(x))[(uid_word_sz) - 1]) << 32) | ((u32 *)(x))[0])
+
+#define ELE_MAX_DBG_DMP_PKT		30
+#define ELE_NON_DUMP_BUFFER_SZ		3
+#define ELE_DEBUG_DUMP_REQ		0x21
+#define ELE_DEBUG_DUMP_REQ_SZ		0x4
+#define ELE_DEBUG_DUMP_RSP_SZ		0x5C
+
+#define ELE_PING_REQ			0x01
+#define ELE_PING_REQ_SZ			0x04
+#define ELE_PING_RSP_SZ			0x08
+
+#define ELE_SERVICE_SWAP_REQ		0xDF
+#define ELE_SERVICE_SWAP_REQ_MSG_SZ	0x18
+#define ELE_SERVICE_SWAP_RSP_MSG_SZ	0x0C
+#define ELE_IMEM_SIZE			0x10000
+#define ELE_IMEM_STATE_OK		0xCA
+#define ELE_IMEM_STATE_BAD		0xFE
+#define ELE_IMEM_STATE_WORD		0x27
+#define ELE_IMEM_STATE_MASK		0x00ff0000
+#define ELE_IMEM_EXPORT			0x1
+#define ELE_IMEM_IMPORT			0x2
+
+#define ELE_FW_AUTH_REQ			0x02
+#define ELE_FW_AUTH_REQ_SZ		0x10
+#define ELE_FW_AUTH_RSP_MSG_SZ		0x08
+
+int ele_get_info(struct se_if_priv *priv, struct ele_dev_info *s_info);
+int ele_fetch_soc_info(struct se_if_priv *priv, void *data);
+int ele_ping(struct se_if_priv *priv);
+int ele_service_swap(struct se_if_priv *priv,
+		     phys_addr_t addr,
+		     u32 addr_size, u16 flag);
+int ele_fw_authenticate(struct se_if_priv *priv, phys_addr_t addr);
+int ele_debug_dump(struct se_if_priv *priv);
+#endif
diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
new file mode 100644
index 000000000000..3fa8182b302f
--- /dev/null
+++ b/drivers/firmware/imx/ele_common.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include "ele_base_msg.h"
+#include "ele_common.h"
+
+u32 se_add_msg_crc(u32 *msg, u32 msg_len)
+{
+	u32 nb_words = msg_len / (u32)sizeof(u32);
+	u32 crc = 0;
+	u32 i;
+
+	for (i = 0; i < nb_words - 1; i++)
+		crc ^= *(msg + i);
+
+	return crc;
+}
+
+int ele_msg_rcv(struct se_if_priv *priv,
+		struct se_clbk_handle *se_clbk_hdl)
+{
+	int err = 0;
+
+	do {
+		err = wait_for_completion_interruptible(&se_clbk_hdl->done);
+		if (err == -ERESTARTSYS) {
+			if (priv->waiting_rsp_clbk_hdl.rx_msg) {
+				priv->waiting_rsp_clbk_hdl.signal_rcvd = true;
+				continue;
+			}
+			dev_err(priv->dev,
+				"Err[0x%x]:Interrupted by signal.\n",
+				err);
+			err = -EINTR;
+			break;
+		}
+	} while (err != 0);
+
+	return err ? err : se_clbk_hdl->rx_msg_sz;
+}
+
+int ele_msg_send(struct se_if_priv *priv,
+		 void *tx_msg,
+		 int tx_msg_sz)
+{
+	struct se_msg_hdr *header;
+	int err;
+
+	header = tx_msg;
+
+	/*
+	 * Check that the size passed as argument matches the size
+	 * carried in the message.
+	 */
+	if (header->size << 2 != tx_msg_sz) {
+		dev_err(priv->dev,
+			"User buf hdr: 0x%x, sz mismatced with input-sz (%d != %d).",
+			*(u32 *)header,
+			header->size << 2, tx_msg_sz);
+		return -EINVAL;
+	}
+
+	err = mbox_send_message(priv->tx_chan, tx_msg);
+	if (err < 0) {
+		dev_err(priv->dev, "Error: mbox_send_message failure.\n");
+		return err;
+	}
+	err = tx_msg_sz;
+
+	return err;
+}
+
+/* API used for send/receive blocking call. */
+int ele_msg_send_rcv(struct se_if_priv *priv,
+		     void *tx_msg,
+		     int tx_msg_sz,
+		     void *rx_msg,
+		     int exp_rx_msg_sz)
+{
+	int err;
+
+	guard(mutex)(&priv->se_if_cmd_lock);
+
+	priv->waiting_rsp_clbk_hdl.rx_msg_sz = exp_rx_msg_sz;
+	priv->waiting_rsp_clbk_hdl.rx_msg = rx_msg;
+
+	err = ele_msg_send(priv, tx_msg, tx_msg_sz);
+	if (err < 0)
+		return err;
+
+	err = ele_msg_rcv(priv, &priv->waiting_rsp_clbk_hdl);
+
+	if (priv->waiting_rsp_clbk_hdl.signal_rcvd) {
+		err = -EINTR;
+		priv->waiting_rsp_clbk_hdl.signal_rcvd = false;
+		dev_err(priv->dev,
+			"Err[0x%x]:Interrupted by signal.\n",
+			err);
+	}
+
+	return err;
+}
+
+static bool exception_for_size(struct se_if_priv *priv,
+			       struct se_msg_hdr *header)
+{
+	/* List of API(s) that can be accepte variable length
+	 * response buffer.
+	 */
+	if (header->command == ELE_DEBUG_DUMP_REQ &&
+	    header->ver == priv->if_defs->base_api_ver &&
+	    header->size >= 0 &&
+	    header->size <= ELE_DEBUG_DUMP_RSP_SZ)
+		return true;
+
+	return false;
+}
+
+/*
+ * Callback called by mailbox FW, when data is received.
+ */
+void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
+{
+	struct se_clbk_handle *se_clbk_hdl;
+	struct device *dev = mbox_cl->dev;
+	struct se_msg_hdr *header;
+	struct se_if_priv *priv;
+	u32 rx_msg_sz;
+
+	priv = dev_get_drvdata(dev);
+
+	/* The function can be called with NULL msg */
+	if (!msg) {
+		dev_err(dev, "Message is invalid\n");
+		return;
+	}
+
+	header = msg;
+	rx_msg_sz = header->size << 2;
+
+	/* Incoming command: wake up the receiver if any. */
+	if (header->tag == priv->if_defs->cmd_tag) {
+		se_clbk_hdl = &priv->cmd_receiver_clbk_hdl;
+		dev_dbg(dev,
+			"Selecting cmd receiver for mesg header:0x%x.",
+			*(u32 *)header);
+
+		/* Pre-allocated buffer of MAX_NVM_MSG_LEN
+		 * as the NVM command are initiated by FW.
+		 * Size is revealed as part of this call function.
+		 */
+		if (rx_msg_sz > MAX_NVM_MSG_LEN) {
+			dev_err(dev,
+				"CMD-RCVER NVM: hdr(0x%x) with different sz(%d != %d).\n",
+				*(u32 *)header,
+				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
+
+			se_clbk_hdl->rx_msg_sz = MAX_NVM_MSG_LEN;
+		}
+		se_clbk_hdl->rx_msg_sz = rx_msg_sz;
+
+	} else if (header->tag == priv->if_defs->rsp_tag) {
+		se_clbk_hdl = &priv->waiting_rsp_clbk_hdl;
+		dev_dbg(dev,
+			"Selecting resp waiter for mesg header:0x%x.",
+			*(u32 *)header);
+
+		if (rx_msg_sz != se_clbk_hdl->rx_msg_sz &&
+		    !exception_for_size(priv, header)) {
+			dev_err(dev,
+				"Rsp to CMD: hdr(0x%x) with different sz(%d != %d).\n",
+				*(u32 *)header,
+				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
+
+			se_clbk_hdl->rx_msg_sz = min(rx_msg_sz, se_clbk_hdl->rx_msg_sz);
+		}
+	} else {
+		dev_err(dev, "Failed to select a device for message: %.8x\n",
+			*((u32 *)header));
+		return;
+	}
+
+	memcpy(se_clbk_hdl->rx_msg, msg, se_clbk_hdl->rx_msg_sz);
+
+	/* Allow user to read */
+	complete(&se_clbk_hdl->done);
+}
+
+int se_val_rsp_hdr_n_status(struct se_if_priv *priv,
+			    struct se_api_msg *msg,
+			    u8 msg_id,
+			    u8 sz,
+			    bool is_base_api)
+{
+	u32 status;
+	struct se_msg_hdr *header = &msg->header;
+
+	if (header->tag != priv->if_defs->rsp_tag) {
+		dev_err(priv->dev,
+			"MSG[0x%x] Hdr: Resp tag mismatch. (0x%x != 0x%x)",
+			msg_id, header->tag, priv->if_defs->rsp_tag);
+		return -EINVAL;
+	}
+
+	if (header->command != msg_id) {
+		dev_err(priv->dev,
+			"MSG Header: Cmd id mismatch. (0x%x != 0x%x)",
+			header->command, msg_id);
+		return -EINVAL;
+	}
+
+	if (header->size != (sz >> 2) && !exception_for_size(priv, header)) {
+		dev_err(priv->dev,
+			"MSG[0x%x] Hdr: Cmd size mismatch. (0x%x != 0x%x)",
+			msg_id, header->size, (sz >> 2));
+		return -EINVAL;
+	}
+
+	if (is_base_api && header->ver != priv->if_defs->base_api_ver) {
+		dev_err(priv->dev,
+			"MSG[0x%x] Hdr: Base API Vers mismatch. (0x%x != 0x%x)",
+			msg_id, header->ver, priv->if_defs->base_api_ver);
+		return -EINVAL;
+	} else if (!is_base_api && header->ver != priv->if_defs->fw_api_ver) {
+		dev_err(priv->dev,
+			"MSG[0x%x] Hdr: FW API Vers mismatch. (0x%x != 0x%x)",
+			msg_id, header->ver, priv->if_defs->fw_api_ver);
+		return -EINVAL;
+	}
+
+	status = RES_STATUS(msg->data[0]);
+	if (status != priv->if_defs->success_tag) {
+		dev_err(priv->dev, "Command Id[%x], Response Failure = 0x%x",
+			header->command, status);
+		return -EPERM;
+	}
+
+	return 0;
+}
+
+int se_save_imem_state(struct se_if_priv *priv, struct se_imem_buf *imem)
+{
+	struct ele_dev_info s_info = {0};
+	int ret;
+
+	ret = ele_get_info(priv, &s_info);
+	if (ret) {
+		dev_err(priv->dev, "Failed to get info from ELE.\n");
+		return ret;
+	}
+
+	/* Do not save the IMEM buffer, if the current IMEM state is BAD. */
+	if (s_info.d_addn_info.imem_state == ELE_IMEM_STATE_BAD)
+		return ret;
+
+	/* EXPORT command will save encrypted IMEM to given address,
+	 * so later in resume, IMEM can be restored from the given
+	 * address.
+	 *
+	 * Size must be at least 64 kB.
+	 */
+	ret = ele_service_swap(priv,
+			       imem->phyaddr,
+			       ELE_IMEM_SIZE,
+			       ELE_IMEM_EXPORT);
+	if (ret < 0) {
+		dev_err(priv->dev, "Failed to export IMEM\n");
+		imem->size = 0;
+	} else {
+		dev_info(priv->dev,
+			 "Exported %d bytes of encrypted IMEM\n",
+			 ret);
+		imem->size = ret;
+	}
+
+	return ret > 0 ? 0 : -1;
+}
+
+int se_restore_imem_state(struct se_if_priv *priv, struct se_imem_buf *imem)
+{
+	struct ele_dev_info s_info;
+	int ret;
+
+	/* get info from ELE */
+	ret = ele_get_info(priv, &s_info);
+	if (ret) {
+		dev_err(priv->dev, "Failed to get info from ELE.\n");
+		return ret;
+	}
+	imem->state = s_info.d_addn_info.imem_state;
+
+	/* Get IMEM state, if 0xFE then import IMEM */
+	if (s_info.d_addn_info.imem_state == ELE_IMEM_STATE_BAD && imem->size) {
+		/* IMPORT command will restore IMEM from the given
+		 * address, here size is the actual size returned by ELE
+		 * during the export operation
+		 */
+		ret = ele_service_swap(priv,
+				       imem->phyaddr,
+				       imem->size,
+				       ELE_IMEM_IMPORT);
+		if (ret) {
+			dev_err(priv->dev, "Failed to import IMEM\n");
+			return ret;
+		}
+	} else {
+		return ret;
+	}
+
+	/* After importing IMEM, check if IMEM state is equal to 0xCA
+	 * to ensure IMEM is fully loaded and
+	 * ELE functionality can be used.
+	 */
+	ret = ele_get_info(priv, &s_info);
+	if (ret) {
+		dev_err(priv->dev, "Failed to get info from ELE.\n");
+		return ret;
+	}
+	imem->state = s_info.d_addn_info.imem_state;
+
+	if (s_info.d_addn_info.imem_state == ELE_IMEM_STATE_OK)
+		dev_info(priv->dev, "Successfully restored IMEM\n");
+	else
+		dev_err(priv->dev, "Failed to restore IMEM\n");
+
+	return ret;
+}
diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
new file mode 100644
index 000000000000..aceb8c891ae6
--- /dev/null
+++ b/drivers/firmware/imx/ele_common.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef __ELE_COMMON_H__
+#define __ELE_COMMON_H__
+
+#include "se_ctrl.h"
+
+#define ELE_SUCCESS_IND			0xD6
+
+#define IMX_ELE_FW_DIR                 "imx/ele/"
+
+u32 se_add_msg_crc(u32 *msg, u32 msg_len);
+int ele_msg_rcv(struct se_if_priv *priv,
+		struct se_clbk_handle *se_clbk_hdl);
+int ele_msg_send(struct se_if_priv *priv,
+		 void *tx_msg,
+		 int tx_msg_sz);
+int ele_msg_send_rcv(struct se_if_priv *priv,
+		     void *tx_msg,
+		     int tx_msg_sz,
+		     void *rx_msg,
+		     int exp_rx_msg_sz);
+void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg);
+int se_val_rsp_hdr_n_status(struct se_if_priv *priv,
+			    struct se_api_msg *msg,
+			    u8 msg_id,
+			    u8 sz,
+			    bool is_base_api);
+
+/* Fill a command message header with a given command ID and length in bytes. */
+static inline int se_fill_cmd_msg_hdr(struct se_if_priv *priv,
+				      struct se_msg_hdr *hdr,
+				      u8 cmd, u32 len,
+				      bool is_base_api)
+{
+	hdr->tag = priv->if_defs->cmd_tag;
+	hdr->ver = (is_base_api) ? priv->if_defs->base_api_ver : priv->if_defs->fw_api_ver;
+	hdr->command = cmd;
+	hdr->size = len >> 2;
+
+	return 0;
+}
+
+int se_save_imem_state(struct se_if_priv *priv, struct se_imem_buf *imem);
+int se_restore_imem_state(struct se_if_priv *priv, struct se_imem_buf *imem);
+
+#endif /*__ELE_COMMON_H__ */
diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
new file mode 100644
index 000000000000..12a1ceb87866
--- /dev/null
+++ b/drivers/firmware/imx/se_ctrl.c
@@ -0,0 +1,503 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/firmware.h>
+#include <linux/firmware/imx/se_api.h>
+#include <linux/genalloc.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/miscdevice.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/sys_soc.h>
+
+#include "ele_base_msg.h"
+#include "ele_common.h"
+#include "se_ctrl.h"
+
+#define MAX_SOC_INFO_DATA_SZ		256
+#define MBOX_TX_NAME			"tx"
+#define MBOX_RX_NAME			"rx"
+#define SE_TYPE_STR_HSM			"hsm"
+#define SE_TYPE_ID_HSM			0x2
+
+struct se_fw_img_name {
+	const u8 *prim_fw_nm_in_rfs;
+	const u8 *seco_fw_nm_in_rfs;
+};
+
+struct se_fw_load_info {
+	const struct se_fw_img_name *se_fw_img_nm;
+	bool is_fw_loaded;
+	bool imem_mgmt;
+	struct se_imem_buf imem;
+};
+
+struct se_if_node {
+	u8 se_if_id;
+	u8 se_if_did;
+	struct se_if_defines if_defs;
+	u8 *pool_name;
+	bool reserved_dma_ranges;
+};
+
+/* contains fixed information */
+struct se_soc_info {
+	const u8 num_mu;
+	const u16 soc_id;
+	bool soc_register;
+	int (*se_fetch_soc_info)(struct se_if_priv *priv, void *data);
+	const struct se_fw_img_name se_fw_img_nm;
+	const struct se_if_node if_node[];
+};
+
+struct se_var_info {
+	u16 soc_rev;
+	struct se_fw_load_info load_fw;
+};
+
+static struct se_var_info var_se_info = {
+	.soc_rev = 0,
+	.load_fw = {
+		.is_fw_loaded = true,
+		.imem_mgmt = false,
+	},
+};
+
+static struct se_soc_info se_imx8ulp_info = {
+	.num_mu = 1,
+	.soc_id = SOC_ID_OF_IMX8ULP,
+	.soc_register = true,
+	.se_fetch_soc_info = ele_fetch_soc_info,
+	.se_fw_img_nm = {
+		.prim_fw_nm_in_rfs = IMX_ELE_FW_DIR
+			"mx8ulpa2-ahab-container.img",
+		.seco_fw_nm_in_rfs = IMX_ELE_FW_DIR
+			"mx8ulpa2ext-ahab-container.img",
+	},
+	.if_node = {
+			{
+			.se_if_id = 0,
+			.se_if_did = 7,
+			.if_defs = {
+				.se_if_type = SE_TYPE_ID_HSM,
+				.se_instance_id = 0,
+				.cmd_tag = 0x17,
+				.rsp_tag = 0xe1,
+				.success_tag = ELE_SUCCESS_IND,
+				.base_api_ver = MESSAGING_VERSION_6,
+				.fw_api_ver = MESSAGING_VERSION_7,
+			},
+			.pool_name = "sram",
+			.reserved_dma_ranges = true,
+			},
+	},
+};
+
+static struct se_soc_info se_imx93_info = {
+	.num_mu = 1,
+	.soc_id = SOC_ID_OF_IMX93,
+	.soc_register = false,
+	.se_fetch_soc_info = ele_fetch_soc_info,
+	.se_fw_img_nm = {
+		.prim_fw_nm_in_rfs = NULL,
+		.seco_fw_nm_in_rfs = NULL,
+	},
+	.if_node = {
+			{
+			.se_if_id = 0,
+			.se_if_did = 3,
+			.if_defs = {
+				.se_if_type = SE_TYPE_ID_HSM,
+				.se_instance_id = 0,
+				.cmd_tag = 0x17,
+				.rsp_tag = 0xe1,
+				.success_tag = ELE_SUCCESS_IND,
+				.base_api_ver = MESSAGING_VERSION_6,
+				.fw_api_ver = MESSAGING_VERSION_7,
+			},
+			.reserved_dma_ranges = true,
+			},
+	},
+};
+
+static const struct of_device_id se_match[] = {
+	{ .compatible = "fsl,imx8ulp-se-ele-hsm", .data = (void *)&se_imx8ulp_info.if_node},
+	{ .compatible = "fsl,imx93-se-ele-hsm", .data = (void *)&se_imx93_info.if_node},
+	{},
+};
+
+static struct se_fw_load_info *get_load_fw_instance(struct se_if_priv *priv)
+{
+	return &var_se_info.load_fw;
+}
+
+static int get_se_soc_info(struct se_if_priv *priv, const struct se_soc_info *se_info)
+{
+	struct se_fw_load_info *load_fw = get_load_fw_instance(priv);
+	struct soc_device_attribute *attr;
+	struct ele_dev_info *s_info;
+	struct soc_device *sdev;
+	u8 data[MAX_SOC_INFO_DATA_SZ];
+	int err = 0;
+
+	/* This function should be called once.
+	 * Check if the se_soc_rev is zero to continue.
+	 */
+	if (var_se_info.soc_rev)
+		return err;
+
+	if (se_info->se_fetch_soc_info) {
+		err = se_info->se_fetch_soc_info(priv, &data);
+		if (err < 0) {
+			dev_err(priv->dev, "Failed to fetch SoC Info.");
+			return err;
+		}
+		s_info = (void *)data;
+		var_se_info.soc_rev = s_info->d_info.soc_rev;
+		load_fw->imem.state = s_info->d_addn_info.imem_state;
+	} else {
+		dev_err(priv->dev, "Failed to fetch SoC revision.");
+		if (se_info->soc_register)
+			dev_err(priv->dev, "Failed to do SoC registration.");
+		return -EINVAL;
+	}
+
+	if (!se_info->soc_register)
+		return 0;
+
+	attr = devm_kzalloc(priv->dev, sizeof(*attr), GFP_KERNEL);
+	if (!attr)
+		return -ENOMEM;
+
+	if (FIELD_GET(DEV_GETINFO_MIN_VER_MASK, var_se_info.soc_rev))
+		attr->revision = devm_kasprintf(priv->dev, GFP_KERNEL, "%x.%x",
+						FIELD_GET(DEV_GETINFO_MIN_VER_MASK,
+							  var_se_info.soc_rev),
+						FIELD_GET(DEV_GETINFO_MAJ_VER_MASK,
+							  var_se_info.soc_rev));
+	else
+		attr->revision = devm_kasprintf(priv->dev, GFP_KERNEL, "%x",
+						FIELD_GET(DEV_GETINFO_MAJ_VER_MASK,
+							  var_se_info.soc_rev));
+
+	switch (se_info->soc_id) {
+	case SOC_ID_OF_IMX8ULP:
+		attr->soc_id = devm_kasprintf(priv->dev, GFP_KERNEL,
+					      "i.MX8ULP");
+		break;
+	case SOC_ID_OF_IMX93:
+		attr->soc_id = devm_kasprintf(priv->dev, GFP_KERNEL,
+					      "i.MX93");
+		break;
+	}
+
+	err = of_property_read_string(of_root, "model",
+				      &attr->machine);
+	if (err)
+		return -EINVAL;
+
+	attr->family = devm_kasprintf(priv->dev, GFP_KERNEL, "Freescale i.MX");
+
+	attr->serial_number = devm_kasprintf(priv->dev,
+					     GFP_KERNEL, "%016llX",
+					     GET_SERIAL_NUM_FROM_UID(s_info->d_info.uid,
+								     MAX_UID_SIZE >> 2));
+
+	sdev = soc_device_register(attr);
+	if (IS_ERR(sdev))
+		return PTR_ERR(sdev);
+
+	return 0;
+}
+
+static int se_load_firmware(struct se_if_priv *priv)
+{
+	struct se_fw_load_info *load_fw = get_load_fw_instance(priv);
+	const struct firmware *fw;
+	phys_addr_t se_fw_phyaddr;
+	const u8 *se_img_file_to_load;
+	u8 *se_fw_buf;
+	int ret;
+
+	if (load_fw->is_fw_loaded)
+		return 0;
+
+	se_img_file_to_load = load_fw->se_fw_img_nm->seco_fw_nm_in_rfs;
+	if (load_fw->se_fw_img_nm->prim_fw_nm_in_rfs &&
+	    load_fw->imem.state == ELE_IMEM_STATE_BAD)
+		se_img_file_to_load = load_fw->se_fw_img_nm->prim_fw_nm_in_rfs;
+
+	do {
+		ret = request_firmware(&fw, se_img_file_to_load, priv->dev);
+		if (ret)
+			return ret;
+
+		dev_info(priv->dev, "loading firmware %s\n", se_img_file_to_load);
+
+		/* allocate buffer to store the SE FW */
+		se_fw_buf = dma_alloc_coherent(priv->dev, fw->size,
+					       &se_fw_phyaddr, GFP_KERNEL);
+		if (!se_fw_buf)
+			return -ENOMEM;
+
+		memcpy(se_fw_buf, fw->data, fw->size);
+		ret = ele_fw_authenticate(priv, se_fw_phyaddr);
+		if (ret < 0) {
+			dev_err(priv->dev,
+				"Error %pe: Authenticate & load SE firmware %s.\n",
+				ERR_PTR(ret),
+				se_img_file_to_load);
+			ret = -EPERM;
+		}
+
+		dma_free_coherent(priv->dev,
+				  fw->size,
+				  se_fw_buf,
+				  se_fw_phyaddr);
+
+		release_firmware(fw);
+		fw = NULL;
+
+		if (!ret && load_fw->imem.state == ELE_IMEM_STATE_BAD &&
+		    se_img_file_to_load == load_fw->se_fw_img_nm->prim_fw_nm_in_rfs)
+			se_img_file_to_load = load_fw->se_fw_img_nm->seco_fw_nm_in_rfs;
+		else
+			se_img_file_to_load = NULL;
+
+	} while (se_img_file_to_load);
+
+	if (!ret)
+		load_fw->is_fw_loaded = true;
+
+	return ret;
+}
+
+/* interface for managed res to free a mailbox channel */
+static void if_mbox_free_channel(void *mbox_chan)
+{
+	mbox_free_channel(mbox_chan);
+}
+
+static int se_if_request_channel(struct device *dev,
+				 struct mbox_chan **chan,
+				 struct mbox_client *cl,
+				 const char *name)
+{
+	struct mbox_chan *t_chan;
+	int ret = 0;
+
+	t_chan = mbox_request_channel_byname(cl, name);
+	if (IS_ERR(t_chan)) {
+		ret = PTR_ERR(t_chan);
+		return dev_err_probe(dev, ret,
+				     "Failed to request %s channel.", name);
+	}
+
+	ret = devm_add_action_or_reset(dev, if_mbox_free_channel, t_chan);
+	if (ret) {
+		ret = -EPERM;
+		return dev_err_probe(dev, ret,
+				     "Failed to add-action for removal of mbox: %s\n",
+				     name);
+	}
+	*chan = t_chan;
+
+	return ret;
+}
+
+static void se_if_probe_cleanup(void *plat_dev)
+{
+	struct platform_device *pdev = plat_dev;
+	struct device *dev = &pdev->dev;
+	struct se_fw_load_info *load_fw;
+	struct se_if_priv *priv;
+
+	priv = dev_get_drvdata(dev);
+	load_fw = get_load_fw_instance(priv);
+
+	/* In se_if_request_channel(), passed the clean-up functional
+	 * pointer reference as action to devm_add_action_or_reset().
+	 * No need to free the mbox channels here.
+	 */
+
+	/* free the buffer in se remove, previously allocated
+	 * in se probe to store encrypted IMEM
+	 */
+	if (load_fw && load_fw->imem.buf) {
+		dmam_free_coherent(dev,
+				   ELE_IMEM_SIZE,
+				   load_fw->imem.buf,
+				   load_fw->imem.phyaddr);
+		load_fw->imem.buf = NULL;
+	}
+
+	/* No need to check, if reserved memory is allocated
+	 * before calling for its release. Or clearing the
+	 * un-set bit.
+	 */
+	of_reserved_mem_device_release(dev);
+}
+
+static int se_if_probe(struct platform_device *pdev)
+{
+	const struct se_soc_info *se_info;
+	const struct se_if_node *if_node;
+	struct device *dev = &pdev->dev;
+	struct se_fw_load_info *load_fw;
+	struct se_if_priv *priv;
+	int ret;
+
+	if_node = device_get_match_data(dev);
+	if (!if_node)
+		return -EINVAL;
+
+	se_info = container_of(if_node,
+			       typeof(*se_info),
+			       if_node[if_node->se_if_id]);
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->if_defs = &if_node->if_defs;
+	dev_set_drvdata(dev, priv);
+
+	ret = devm_add_action_or_reset(dev, se_if_probe_cleanup, pdev);
+	if (ret)
+		return ret;
+
+	/* Mailbox client configuration */
+	priv->se_mb_cl.dev		= dev;
+	priv->se_mb_cl.tx_block		= false;
+	priv->se_mb_cl.knows_txdone	= true;
+	priv->se_mb_cl.rx_callback	= se_if_rx_callback;
+
+	ret = se_if_request_channel(dev, &priv->tx_chan,
+				    &priv->se_mb_cl, MBOX_TX_NAME);
+	if (ret)
+		return ret;
+
+	ret = se_if_request_channel(dev, &priv->rx_chan,
+				    &priv->se_mb_cl, MBOX_RX_NAME);
+	if (ret)
+		return ret;
+
+	mutex_init(&priv->se_if_cmd_lock);
+
+	init_completion(&priv->waiting_rsp_clbk_hdl.done);
+	init_completion(&priv->cmd_receiver_clbk_hdl.done);
+
+	if (if_node->pool_name) {
+		priv->mem_pool = of_gen_pool_get(dev->of_node,
+						 if_node->pool_name, 0);
+		if (!priv->mem_pool)
+			return dev_err_probe(dev, -ENOMEM,
+					     "Unable to get sram pool = %s.",
+					     if_node->pool_name);
+	}
+
+	if (if_node->reserved_dma_ranges) {
+		ret = of_reserved_mem_device_init(dev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					    "Failed to init reserved memory region.");
+	}
+
+	if (if_node->if_defs.se_if_type == SE_TYPE_ID_HSM) {
+		ret = get_se_soc_info(priv, se_info);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to fetch SoC Info.");
+	}
+
+	/* By default, there is no pending FW to be loaded.*/
+	if (se_info->se_fw_img_nm.prim_fw_nm_in_rfs ||
+	    se_info->se_fw_img_nm.seco_fw_nm_in_rfs) {
+		load_fw = get_load_fw_instance(priv);
+		load_fw->se_fw_img_nm = &se_info->se_fw_img_nm;
+		load_fw->is_fw_loaded = false;
+
+		if (se_info->se_fw_img_nm.prim_fw_nm_in_rfs) {
+			/* allocate buffer where SE store encrypted IMEM */
+			load_fw->imem.buf = dmam_alloc_coherent(priv->dev, ELE_IMEM_SIZE,
+								&load_fw->imem.phyaddr,
+								GFP_KERNEL);
+			if (!load_fw->imem.buf)
+				return dev_err_probe(dev, -ENOMEM,
+						     "dmam-alloc-failed: To store encr-IMEM.");
+			load_fw->imem_mgmt = true;
+		}
+	}
+	dev_info(dev, "i.MX secure-enclave: %s%d interface to firmware, configured.",
+		 SE_TYPE_STR_HSM,
+		 priv->if_defs->se_instance_id);
+
+	return ret;
+}
+
+static void se_if_remove(struct platform_device *pdev)
+{
+	se_if_probe_cleanup(pdev);
+}
+
+static int se_suspend(struct device *dev)
+{
+	struct se_if_priv *priv = dev_get_drvdata(dev);
+	struct se_fw_load_info *load_fw;
+	int ret = 0;
+
+	load_fw = get_load_fw_instance(priv);
+
+	if (load_fw->imem_mgmt)
+		ret = se_save_imem_state(priv, &load_fw->imem);
+
+	return ret;
+}
+
+static int se_resume(struct device *dev)
+{
+	struct se_if_priv *priv = dev_get_drvdata(dev);
+	struct se_fw_load_info *load_fw;
+
+	load_fw = get_load_fw_instance(priv);
+
+	if (load_fw->imem_mgmt)
+		se_restore_imem_state(priv, &load_fw->imem);
+
+	return 0;
+}
+
+static const struct dev_pm_ops se_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(se_suspend, se_resume)
+};
+
+static struct platform_driver se_driver = {
+	.driver = {
+		.name = "fsl-se",
+		.of_match_table = se_match,
+		.pm = &se_pm,
+	},
+	.probe = se_if_probe,
+	.remove = se_if_remove,
+};
+MODULE_DEVICE_TABLE(of, se_match);
+
+module_platform_driver(se_driver);
+MODULE_AUTHOR("Pankaj Gupta <pankaj.gupta@nxp.com>");
+MODULE_DESCRIPTION("iMX Secure Enclave Driver.");
+MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
new file mode 100644
index 000000000000..32547bc97ca3
--- /dev/null
+++ b/drivers/firmware/imx/se_ctrl.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef SE_MU_H
+#define SE_MU_H
+
+#include <linux/miscdevice.h>
+#include <linux/semaphore.h>
+#include <linux/mailbox_client.h>
+
+#define MAX_FW_LOAD_RETRIES		50
+
+#define RES_STATUS(x)			FIELD_GET(0x000000ff, x)
+#define MAX_NVM_MSG_LEN			(256)
+#define MESSAGING_VERSION_6		0x6
+#define MESSAGING_VERSION_7		0x7
+
+struct se_clbk_handle {
+	struct completion done;
+	bool signal_rcvd;
+	u32 rx_msg_sz;
+	/* Assignment of the rx_msg buffer to held till the
+	 * received content as part callback function, is copied.
+	 */
+	struct se_api_msg *rx_msg;
+};
+
+struct se_imem_buf {
+	u8 *buf;
+	phys_addr_t phyaddr;
+	u32 size;
+	u32 state;
+};
+
+/* Header of the messages exchange with the EdgeLock Enclave */
+struct se_msg_hdr {
+	u8 ver;
+	u8 size;
+	u8 command;
+	u8 tag;
+}  __packed;
+
+#define SE_MU_HDR_SZ	4
+
+struct se_api_msg {
+	struct se_msg_hdr header;
+	u32 data[];
+};
+
+struct se_if_defines {
+	const u8 se_if_type;
+	const u8 se_instance_id;
+	u8 cmd_tag;
+	u8 rsp_tag;
+	u8 success_tag;
+	u8 base_api_ver;
+	u8 fw_api_ver;
+};
+
+struct se_if_priv {
+	struct device *dev;
+
+	struct se_clbk_handle cmd_receiver_clbk_hdl;
+	/* Update to the waiting_rsp_dev, to be protected
+	 * under se_if_cmd_lock.
+	 */
+	struct se_clbk_handle waiting_rsp_clbk_hdl;
+	/*
+	 * prevent new command to be sent on the se interface while previous
+	 * command is still processing. (response is awaited)
+	 */
+	struct mutex se_if_cmd_lock;
+
+	struct mbox_client se_mb_cl;
+	struct mbox_chan *tx_chan, *rx_chan;
+
+	struct gen_pool *mem_pool;
+	const struct se_if_defines *if_defs;
+};
+
+#endif
diff --git a/include/linux/firmware/imx/se_api.h b/include/linux/firmware/imx/se_api.h
new file mode 100644
index 000000000000..0d49eb109885
--- /dev/null
+++ b/include/linux/firmware/imx/se_api.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef __SE_API_H__
+#define __SE_API_H__
+
+#include <linux/types.h>
+
+#define SOC_ID_OF_IMX8ULP		0x084D
+#define SOC_ID_OF_IMX93			0x9300
+
+#endif /* __SE_API_H__ */

-- 
2.43.0


