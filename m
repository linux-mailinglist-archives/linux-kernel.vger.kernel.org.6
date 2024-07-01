Return-Path: <linux-kernel+bounces-236513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E594F91E342
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 457C4B26B26
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A7E16C871;
	Mon,  1 Jul 2024 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ltBGd5Wb"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF8416D334;
	Mon,  1 Jul 2024 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846236; cv=fail; b=hqsV009LN1/jqyA5aEtnvYZ9DE/M7c8rVOdWjArsWha+6kSstFVyvCNAo6SdTf4QeKLHhbWSKIfpgq+HfzguXEornHH6Jp9aJVikxAnuM8s4iOH9/BjJ5QZAnGtnaJreIQ6qxB7BKLU+l5Y18orlm0jYuNlbZRDkVlMm4NWmEcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846236; c=relaxed/simple;
	bh=6CJPAZ8e8BI6FjuCSEqwivhlEFglrjeb/i0fDBlJHdc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lftRaW9lfBLnUJzofG/h7vUoEVxYGPTGOCbC/71MwhKK2IQJBJwtYU/JVkUAlkhZn8wk4Ff5Xi8FFXagr/6AaQcF4FSoKstRSCdXoHYueb/gRf9fd25NOPQ7W8bmXzjKgkM4ZDJ7PDaQFqhvbjCg8oRTYni4YiFiTl+9v8+rr1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ltBGd5Wb; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kf7DbzDXU8zhNxgfC4DVgBOVOrLBHEbw24twD/tWLII3OngzLSaUfigAMa+x5ydaJXh+qIB2zlOJwNsXzD7/aC10gdkB1IA+6kXjD7X+GUXiycXFJUzGwIxu2V7PTOE6TnJbPTsPgws84/j+lolxFS9vOY8JRhKQ3OhNhmJq7U6GLN8bHC0BbBwXqlU7LNbOwY1dYdn1PFUSaHooHdcjGOh3DYThSCYZdfcMyZbdycMYWy+VltSy6PDBJkvXyGlwAhYPOJ6jvVU5kTaeyLLc8Slp4IMZ9203ByYT4blm7+ETDwQ94QC81YyBZOk8BGVz0WSWzpLCtz7JX5PvDxqhGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6cmgDLhxwvgBjRZI1xtc3M5EhP5vROWvCU9HID4XuQ=;
 b=KSu48AWrbl6a5JGWRebQnKLgE89wtBg61KcX4ooWlnPjMtMIQeYPKcoT0da6SZB8ITNfMwvdrr3Axla7zjljBs30Zbytvc1bedpjjNwv3FDzN/4pYdy3qzLsbkFxgYl4QJo+hTRkRnqQCJxOWtmcvOHWIoHf7Gr6pixv7Km16BVRfriAtJqxG0nmAz6v6e8NlJT5+97ufkE0uXJ791KmYKgxgIi0QTw5hb4cAeZ27BbK10RYdyD8wokHApgEsmKiI5cOae3yECLTjEDMHxF47/3r7GLVaattyUPVY5mV9aeyvMHLLe/xNx1ztnEuNGsk+mf9k/21TgTh9sBjjXOG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6cmgDLhxwvgBjRZI1xtc3M5EhP5vROWvCU9HID4XuQ=;
 b=ltBGd5Wb5SeSM6020GV+fnze+IQxntXL9ws3mtN2RqU1OLFChxEQFKic7VEkMFEv9MD6NZBDVPoUcVLUhDrpumrcUPtjgewpf7Oq13I/+m3tD4PeoXMo3V+xETFFi6y6C01Z/wIq3sbJDh/fBYfYkh0MUR9QoZz77FOapPtYudc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8166.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:03:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 15:03:51 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 01 Jul 2024 11:03:27 -0400
Subject: [PATCH v4 1/8] arm64: dts: imx8: add basic lvds0 and lvds1
 subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-imx8qm-dts-usb-v4-1-03cdbc8c44b6@nxp.com>
References: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
In-Reply-To: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719846224; l=6535;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=6CJPAZ8e8BI6FjuCSEqwivhlEFglrjeb/i0fDBlJHdc=;
 b=P/A7+cM4y4Og1MRDRECe8EUowiUg5tjYzclEhXbqJnPX7ExXyGKRpV6iRRFPb25fvuDKMjm+Q
 B1haErILad8DqVwEfInzJPLqzWhowS+V1iqiAgrtupv56LUVHtJd2xq
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: f79bb152-2ba7-4c61-fa41-08dc99df046e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkppbUxneTdQT2xkMzF3N0hxZm13aWxQNFZJNTBNb1R0NmlGYlVFQlJheDFE?=
 =?utf-8?B?UW1XOHdmVC82MU5DdWVncHU2ZmhkaWtGeXlWVm5IVHlya3pqUTA0UVpXbVA4?=
 =?utf-8?B?YnUvN2tLbUpqdU1MbzN6dkdjUW52UE1KbDEzUTdOazVkbkdUOVdEUGpaaWRs?=
 =?utf-8?B?czRqNUppVW84dXhTazFsUjdSOGIwUFIvbFdia0NTcHo4c09TdkxYbTdzMzVM?=
 =?utf-8?B?ZGVlckYwSWlpYkU1QkJnRVphS3VONUZvL3l0OHhkbW1NU2hySXR2Z1B2QURD?=
 =?utf-8?B?THdDa1FDK2tJaTRrR2pCeGpGL3AwUUZycWVnTmJrdHdHYUFZaFhZSHY5SnZS?=
 =?utf-8?B?aytjQ04vd2x0aStHSTNGUkttcG56ZWZMRmxUeFQwZko1VjJjdzZId0oyQlYw?=
 =?utf-8?B?Qk9jck5vZVBxcEdPaE12M001aTg0SW16b25yU2xBOVQ0d3pvRTJTanArNElX?=
 =?utf-8?B?N0RLT2xHc3R3cUFKd2JXaEkvUGNyUFprckpMMU5WdW1JVzFETk9zMkVQb0d0?=
 =?utf-8?B?L0ZsUnNGYzhNNWdWRjNYa1lVQUNBS0VyQzJIVHBTVFFYWnVrQkxmMWg3clJl?=
 =?utf-8?B?N1R1U0E4OGNxQnNLbzRwSGFZWGJzL1VSOS9Ydml0ZlBjSS9SMkpGSm9RcFJn?=
 =?utf-8?B?RmxyTHNIbGlmTlJVOCswSjFhMUtYWWhOSDhEM3B2eG1vUEJlUTdHZDZRMHNV?=
 =?utf-8?B?WGJwTjFsditlM0ttSWZUL1E4K3VFTitBK0NGYm5pMTNONTBUZGk5UG1UdnJq?=
 =?utf-8?B?ZHJ0YXArRUdDemx4WWVrVzR4QnpnR0J0TU5ycGRheG9HN0tPeTErUXBTL1NE?=
 =?utf-8?B?Y2xiYzVSakhta2h2RUxqajY5VjFHVnlwV2NzbEVRNWk2cm1acjgzYzJXZEFG?=
 =?utf-8?B?RHVLenBtemc2eVNyQjk4MWpuaWlWWWxyUVRLTXJEQTV4Y3p2Mk4xWW05V2sr?=
 =?utf-8?B?Ny9JM05nUW1aK0FPU1lFck55bkRqeTRNMktvV0NkcGFSQ1gzTXd2N3lHVTJo?=
 =?utf-8?B?MjRDUERHZFllQyt3Vys5emZ1ejQrRnFoWDZSaGMvb3Z3Wk8xemdmMUROUHFj?=
 =?utf-8?B?M0ZCdE5SbjB2ZEIxMkhSc1VwNFZVZGY5MHBsbzZzN2ZEMnQ3UFQ5RjVzSW1y?=
 =?utf-8?B?QlovMUZkaE0ydGxTUStRbGdxeE9vcy9HRGVIVVhjOFVGNmV6Zys0UlhoVlJK?=
 =?utf-8?B?TFRXQ0RxZ3hmamhQWFpzcnRaQllNYWt4alBHQkJOWTUzc09POTJJR1ZqM0V4?=
 =?utf-8?B?REI1MDd0aXh2UVJjQ1ZTV0k4MWRJRm84VnFYYkQ0V1c1eEdXTldNeWdOWkc2?=
 =?utf-8?B?TFJpRWdlMUJKMXAxVDJiQ3UrMWcyQkxkWDQ4bW8waDFjaStVZnN6QU1zdldF?=
 =?utf-8?B?MElBYkRWREZpODFIVy9CRnBIdExCRVk3Sk4vL1VOV3BNcWlJTGhIQVFYQ25n?=
 =?utf-8?B?d25lcndDM0dXOEZEMTl2UStKSEVDYVlEVkQ0cDBOZDh3cWsxa1F3M3NtWWND?=
 =?utf-8?B?ME44WHg0Nldrd0lZcDloaW5SZFZCY05pL1RNZ3U2b0NLckFnRmtvNFlTSm1N?=
 =?utf-8?B?WGpoNnlzQ3pUTEpwRTVHTEpYNEYyYXZvblQ2QWQrdjNkUFVaRVBjVHdsamla?=
 =?utf-8?B?SGFKUHZ0U1JsVUhjeUhlMEFrL1BsRndRNjNGTEhra3pWcW1QcGsrTW9wQzNC?=
 =?utf-8?B?VlRBamg3MmVUM2xSNnZwRkNaeHBwb2ZPOVZkSEpDUk81eTd0UWQ5aWhiT1lu?=
 =?utf-8?B?aDROcFBxdjkvTXIxYVdwSlVIUnEwbklMYW5sMndpWm5ML29odTFxK2p5c3Q4?=
 =?utf-8?B?ek9samprWm1wNDNSdTZlb1dlZUFNUWtCaGF6UXZyNkhWdzJmdUM1NVRGNlJi?=
 =?utf-8?B?M0M3S1lOMVlDajFmZzFKOXFVdGVrNGYvL1hFTzJSMFlYV3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmY2SEFTSXpZK21CaHpqaEhXZ21UUHVyQnlMWVRUYlhmWm01ZXZ1WUxkNVVn?=
 =?utf-8?B?a3hmWU5FSjhhUTRRaXMzdllmbGVCblZacDJ4VEZKSHJpRnBaWW8xUXZJUTNs?=
 =?utf-8?B?WE5NNlFET3NCbXJKMkdVbmJ3OWpDUnF3QlFtTjE3ckFpa29uOTJORXoySzVz?=
 =?utf-8?B?WHJWTC96eFpwRlFtTmxOREowMjhXQ21GSmhDYm9KSlRseFd4djBxbmFsTmZH?=
 =?utf-8?B?RUlHNkNjR0tJOTBSL2c5R3ZMd09xclVjMkxRSlNEc0pVQ3BqMGY2ZlB3ZWRl?=
 =?utf-8?B?NzdYQ1ptTUVLUUwyam5VVjY0V3pzZWZaa2FTZHB6K2VhN1BIaElEMGdYTzNS?=
 =?utf-8?B?aFdkRzY2cVhvT3VLNlF0Tlc2STlwQVpTYnlyekYwY3hRR2pDSlVmYmd2VmJT?=
 =?utf-8?B?U2VUUTFCbEFETlEycmcwQlNoT0Z3cXpnTGdKZGFrN0loOXd3T3JrOUF5U2hO?=
 =?utf-8?B?OVVpNjh1RGJDWWpZZGVjMlYxSGxVYmtQZmt0RE42OXhSeHVRMjJTTWhLM1FJ?=
 =?utf-8?B?a3FGbSsrSnZzeEVNQnhWRzhyRzZUdUV4bk9yT0QwN0JQNkNPYlZBS3oxLy80?=
 =?utf-8?B?alNXSGkwSTJJNGFEN1FHdXo4VzVzUk9kSS9lRVROTjd6MmNVZVdaQ2NoWWtC?=
 =?utf-8?B?OGhzQWc4SmozRUhEZ2J2emgxeHMzSTlleFVEQkd4dWE3R3NkUkNLWGZWbVhL?=
 =?utf-8?B?cWFqK09QbXZRVWJ1SmcrTVBKaGJyN2QzVU9idnJPb0dNaGY3OTJFNzA5UFlU?=
 =?utf-8?B?VG81VkozWUx0THI0WUJaRzgxZTE3V0ZwckJYSXdKVmkwaXdNeW4ySWVVS3Zv?=
 =?utf-8?B?bThTM1Foa1paYmU4V0tSNHlQcTlLRlBQNEVURVBRRkVrK0Fhd1ZpL0VKVHha?=
 =?utf-8?B?ekNBelV0YXk2Y29mNnhOS2JKZ0VXRkhkK21BR2tIV2hDcHNGL1lBcjRXZ3lS?=
 =?utf-8?B?VUx0VDBzczVZTis3WCtXcWpIOHdoWFJMcE1JS1ZVVVlvcnAwbG9rU2NnS3dy?=
 =?utf-8?B?OUNrdVBybzMrY0VCemFhQkxobEVXYjRhdHZ0cFRlL08zKzdiN0VJc284Wjkr?=
 =?utf-8?B?U0dzT3M3TFkzdXFSNGNVVktqTGQ2WmJQd0R2bTQ3WmNWQm9zWS9wNEoxbXN3?=
 =?utf-8?B?cUhRNkVCTk0rbTlPMFI1TDh5OUtrNW13MWpHb0plT242TE55eEZzeVIzMlRY?=
 =?utf-8?B?L3duSXpxeWpQNlV3R0MwdGVhT1o1R1kwbHAvUlBCRU1kMmtVYUFnd2puNjFl?=
 =?utf-8?B?WE8rUjAzODAwV2VwZ0NMWG1DSm1KMExtb3ZxNWVWNFQ2dldUTkt3K2dDQWRi?=
 =?utf-8?B?N0NDOHZRWEJjUFRDMjlaQTJLL21lVUZDS3NGUWtaU01VWG9TUlJMbHZmbndS?=
 =?utf-8?B?Q0ErZlNKVWdIeE8velppZGlpYy9mZVlJKzUxRmhMQTh6clEyTmJGanROTVNJ?=
 =?utf-8?B?VUlZam1kN0xzNzRWMVU5Y0YxS1NyVGI4U1pGbUVEQmdTbGpWQ0MrdThDeDlQ?=
 =?utf-8?B?ZkZydGZmdVlvQ3VYZGxMcmhVa0FwNTJtK1VrRjAvYXpWSmNNTFRJdEcrS2ZD?=
 =?utf-8?B?enJBMVJ1eW5nU0JEelZtZFJMbnFsS1VpUSs2RlV4UXdEQk0zalNCVXN4WXJr?=
 =?utf-8?B?eDZEVXIxa2ZraTk1N3pDSWp0eFNUTnVRMlJZMEo0NXBWS1E1ai9WNVNkVlhE?=
 =?utf-8?B?TVgyMzQ1VFVGTXFvMTYyR0poYXZua3psUnIwTGFGbkRNNUZEbHVycktkMlhm?=
 =?utf-8?B?dGNzWGJhb2F2bzNjYVEycWwzajBkcWxRUFB6ek5uMnJXOHpaK25lME1ud3hv?=
 =?utf-8?B?WnZuZ2QrSU5mUnJMYXlwd08xUFREZk9sbnJMYTdsZERWVmVMNUpyb2ZLd0Uy?=
 =?utf-8?B?K3B3WGlnYnpyazJ2WVVUaDZzVFNxQzc3bkpkZ1lzQ1paVjd1Uys4Q2tCV1dD?=
 =?utf-8?B?d2p5UFkzTUYwanM4VGE1L3ZKZklDUlBYRld0M01BTytiTVM1UkpaWDczcmtZ?=
 =?utf-8?B?NEV6NDZYOTNYb2Y1d2tzQTIyRmpCOUxPVm9hQVcydzYxa2M5MTE1eXozWkds?=
 =?utf-8?B?R1hYeWZKdjV3bVF5YjhqYmI5aXlMbDlvbkFlSDRXVmtvdVNQOVNNcUk4MzZD?=
 =?utf-8?Q?FnmQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79bb152-2ba7-4c61-fa41-08dc99df046e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:03:51.1940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qEsqM573bctX44yFZq6Q0xUleeYg7pzhWVnc9qMipBxDfUIIAXgs6r3/8KfW8IDNTpi4QiyiAAOgjzcD0rxoOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8166

Add basic lvds0 and lvds1 subsystem for imx8qm an imx8qxp.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi |  63 +++++++++++++
 arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi | 114 +++++++++++++++++++++++
 2 files changed, 177 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi
new file mode 100644
index 0000000000000..d00036204a8c2
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only and MIT
+
+/*
+ * Copyright 2024 NXP
+ */
+
+lvds0_subsys: bus@56240000 {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x56240000 0x0 0x56240000 0x10000>;
+
+	qm_lvds0_lis_lpcg: qxp_mipi1_lis_lpcg: clock-controller@56243000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56243000 0x4>;
+		#clock-cells = <1>;
+		clock-output-names = "mipi1_lis_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1>;
+	};
+
+	qm_lvds0_pwm_lpcg: qxp_mipi1_pwm_lpcg: clock-controller@5624300c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5624300c 0x4>;
+		#clock-cells = <1>;
+		clock-output-names = "mipi1_pwm_lpcg_clk",
+				     "mipi1_pwm_lpcg_ipg_clk",
+				     "mipi1_pwm_lpcg_32k_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
+	};
+
+	qm_lvds0_i2c0_lpcg: qxp_mipi1_i2c0_lpcg: clock-controller@56243010 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56243010 0x4>;
+		#clock-cells = <1>;
+		clock-output-names = "mipi1_i2c0_lpcg_clk",
+				     "mipi1_i2c0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+	};
+
+	qm_pwm_lvds0: qxp_pwm_mipi_lvds1: pwm@56244000 {
+		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
+		reg = <0x56244000 0x1000>;
+		clock-names = "ipg", "per";
+		assigned-clocks = <&clk IMX_SC_R_MIPI_1_PWM_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <3>;
+		power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
+		status = "disabled";
+	};
+
+	qm_i2c0_lvds0: qxp_i2c0_mipi_lvds1: i2c@56246000 {
+		compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x56246000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <8>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_MIPI_1_I2C_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi
new file mode 100644
index 0000000000000..12ae4f48e1e1c
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lvds1.dtsi
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only and MIT
+
+/*
+ * Copyright 2024 NXP
+ */
+
+lvds1_subsys: bus@57240000 {
+	compatible = "simple-bus";
+	interrupt-parent = <&irqsteer_lvds1>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x57240000 0x0 0x57240000 0x10000>;
+
+	irqsteer_lvds1: interrupt-controller@57240000 {
+		compatible = "fsl,imx8qm-irqsteer", "fsl,imx-irqsteer";
+		reg = <0x57240000 0x1000>;
+		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		interrupt-parent = <&gic>;
+		#interrupt-cells = <1>;
+		clocks = <&lvds1_lis_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_LVDS_1>;
+		fsl,channel = <0>;
+		fsl,num-irqs = <32>;
+	};
+
+	lvds1_lis_lpcg: clock-controller@57243000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57243000 0x4>;
+		#clock-cells = <1>;
+		clocks = <&lvds_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>;
+		clock-output-names = "lvds1_lis_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_LVDS_1>;
+	};
+
+	lvds1_pwm_lpcg: clock-controller@5724300c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5724300c 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_LVDS_1_PWM_0 IMX_SC_PM_CLK_PER>,
+			 <&lvds_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "lvds1_pwm_lpcg_clk",
+				     "lvds1_pwm_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_LVDS_1_PWM_0>;
+	};
+
+	lvds1_i2c0_lpcg: clock-controller@57243010 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57243010 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>,
+			 <&lvds_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "lvds1_i2c0_lpcg_clk",
+				     "lvds1_i2c0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_LVDS_1_I2C_0>;
+	};
+
+	lvds1_i2c1_lpcg: clock-controller@57243014 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57243014 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>,
+			 <&lvds_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "lvds1_i2c1_lpcg_clk",
+				     "lvds1_i2c1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_LVDS_1_I2C_0>;
+	};
+
+	pwm_lvds1: pwm@57244000 {
+		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
+		reg = <0x57244000 0x1000>;
+		clocks = <&lvds1_pwm_lpcg IMX_LPCG_CLK_4>,
+			 <&lvds1_pwm_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg", "per";
+		assigned-clocks = <&clk IMX_SC_R_LVDS_1_PWM_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <3>;
+		power-domains = <&pd IMX_SC_R_LVDS_1_PWM_0>;
+		status = "disabled";
+	};
+
+	i2c0_lvds1: i2c@57246000 {
+		compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x57246000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <8>;
+		clocks = <&lvds1_i2c0_lpcg IMX_LPCG_CLK_0>,
+			 <&lvds1_i2c0_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_LVDS_1_I2C_0>;
+		status = "disabled";
+	};
+
+	i2c1_lvds1: i2c@57247000 {
+		compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x57247000 0x1000>;
+		interrupts = <9>;
+		clocks = <&lvds1_i2c1_lpcg IMX_LPCG_CLK_0>,
+			 <&lvds1_i2c1_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_LVDS_1_I2C_0>;
+		status = "disabled";
+	};
+};

-- 
2.34.1


