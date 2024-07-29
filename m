Return-Path: <linux-kernel+bounces-265008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5865E93EB25
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC4BDB20BA6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211047D41C;
	Mon, 29 Jul 2024 02:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ML7Wh8ak"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10D77A15A;
	Mon, 29 Jul 2024 02:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219727; cv=fail; b=Kx5DGCxLNXcpgTAAbzkQ7Q292Kj7lqupPrPhspvqLiMfdjHFqbEvMWONIXCr7EkrJLz/n6I/CY6JhoAJGRcEWj/PULtT+kEtPfolK+Zpjdj4SQmt+uU1DiN2UD+1xhf9hkQI0Z0bEmKtEj9hq0xIyNf7jLtWfcojrapnBIixylU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219727; c=relaxed/simple;
	bh=Fa969aBC9+UYuRQ629gtOlqO5zXOE83b8T81dJ5UB7k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ko2umpxHUgrJt+/PSvXUiS/HiTUNQ62EC7pvgoSfAk5C2UhTHdlDBHxY5LTYGHg1+rAVgTV2eZvomYmliqySdEpBFw1r6UJZDK3DZvjJlDFYEKTLGLSkYHik1UDtakfJYvHjrb2dR5kUAwwlpSPjrxCiaaPqYDdOaODe74Mg9Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ML7Wh8ak; arc=fail smtp.client-ip=40.107.21.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llbw5H7+qLoB+7ZNpSdWyOcXPQz1cY3YdV6WsOvI0keY2AXi19Aw2K/EeC201PwtCy7b0oEzNN+norlrDZv0yr19zc1gq74wozJj6B4pBe4w6NA1g3BrnLUaLx2XSEI4AM9j+WRTEG7rZESh73Fd9r10QZBaS0RtarUy44lGUrrURe6jAgr+8nLjl5qdTqUiRpfyrJDWAtHo/ymZOajhkVZVOAGZy+dK6VSksoyORDnvUpwBeZwss/sT4b2YXZmOLeBoRZ5LQ9TLLEVHxtgLRI+m6rwKWFzc/vdMutxVN3qvyEZwKXX2GxrKraeHyfVkxTcoSson1zMGuTDOiYVzrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbAkF85iaFHvFTLjOWB5s5r8w1kYs2rFztU495YBbr0=;
 b=BQgC13EEbAldOzk/6BG2WOY9hoyReWX4WBdR7DWxr3GLV9yTuu6Hv8cSu54Kr1Ue3U/pqUz/SuxXXFViY/MrPol1gvsN9VxepOEb9ExXvw0XZNhhP0lBC+a+oORtLEX8HK7Qnd5a5yAsJmu5Y46YrJ1LkKQHai9bFGo1TooD03ugFl16beq/poNYptujlFNAqQvTH/gbf4avHBpL9Jl3hA0Xd5PB1Ils/GDqalXdxoMzkgXJRvSG4oA+6Tbkv65tioU8k7kDjtdROo1hOLtS9kSSow+ckFlwZQbNt9NOqRKNvfAB86d1i64gY0mDbe+S1XDmdlI18emfqS+1Cnthhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbAkF85iaFHvFTLjOWB5s5r8w1kYs2rFztU495YBbr0=;
 b=ML7Wh8akQB4tGmoVx6D7Y6a5MtvRfwFX/RNBqAm3bY6rcoDXXnkJgf78nVK4qZWwUUe0l5VJ+dVtxIqddXi55kamIKbe5ZoEIX3C2k2yK9/rzm1An9jfJuvqZNPCfOxn0VBcIPg19Hm1ix7hYa4S156Y+b7rTy3xY3QRKfgmMjx2T6x0TmAc/yYnXN7hvRQBRn9HSlqpJuja6OWMcZ6s2xgpjoCfy6s2dZrJwk95mmzFctiHh6qjxQGX/jt2AIkXlSb8AKtIcrlZNDVFSycgwV/U6I5LompfHWv3LXMeVRM+OzrFwGpJcTuh6Tw2KkHttbMWDQkd8CfVIMZT/C1uqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBAPR04MB7368.eurprd04.prod.outlook.com (2603:10a6:10:1ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 02:22:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Mon, 29 Jul 2024
 02:22:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 29 Jul 2024 10:30:53 +0800
Subject: [PATCH v2 2/2] clk: clk-conf: support assigned-clock-rates-u64
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-clk-u64-v2-2-ffa62ee437e6@nxp.com>
References: <20240729-clk-u64-v2-0-ffa62ee437e6@nxp.com>
In-Reply-To: <20240729-clk-u64-v2-0-ffa62ee437e6@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722220263; l=3649;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=K25e/IwCaHk/VnfjjVO7hUUmnIl5zCnqg1J7sgDRSfI=;
 b=94BPFdDFZ3u2K7BYWoMG/KL+zR/aaEwwqLDU95lJ20oO9PXtUMF8EMBoZHDLiP1dpIzh5YQc3
 ZSWeL13eA71Ci+5d0Jcs4twizC0ant0mn+zIXyLY1gdloCklqsT50+K
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:3:17::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBAPR04MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 5187f2b9-81fb-48f6-c8c1-08dcaf753b66
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjNDbWtaSE5Sb1daR2lQSEg1QzMrNThraHp2RjNJdFVTR2hiZ044YjdRZ0Ra?=
 =?utf-8?B?R3k4MDZDQ2VuOUx0T2pFM0QwdkFOWWk2ZmNTK1JEdEl2TTFXZWt4anIxV2o0?=
 =?utf-8?B?eVJabmlmSC9rMHBNVzBHVllqb29kR3EwUytJTVVHYXRsM2t5enN3cFpRMG5z?=
 =?utf-8?B?ditDc1ZmV2lhNkVMb3g5eU5jMkROUGtNVWNUKzlSZVlWaDBPNTdzUUJwNlNN?=
 =?utf-8?B?WU12MGJjN0NLak9HTW80VHlYbUZFcDBXcFEva1BpeldObHIrVTllU2trMHo5?=
 =?utf-8?B?LzgweU9zUlhzKzlLdkhrOVdNYUlMTGZMSTF5aEdRN1BPWkFuS0JpbjVpQ3h1?=
 =?utf-8?B?NUtJUTNsTUhhSDRYUDFDeUZ2bS9TUXBhTXpiNGNYUEU5Qy9qTkptTldKRTZL?=
 =?utf-8?B?UVhablhUeVkzRytDZWM1MjZGSlFKMHhSb2dEek9tVzFjdzhmTk54T0NsVmtR?=
 =?utf-8?B?OW1PWmNqOGg1WkQ0WFpaNmtlZm53eTZNeHdyYjR1SXZuT0w5d2lXWXZiakxI?=
 =?utf-8?B?UlZoT09EVTdDTVlBZ3B4Z2hQMWNYR1dFRTVoVFFTNi9kbDVHUXNYRlFoNDJO?=
 =?utf-8?B?VWl4eW1wMDBlT3lXdFZqdjlqU3hRT2ZzQ09IVHg5UG5rNTVzOCsxNDVHeitQ?=
 =?utf-8?B?M1pNMVd1Qm5QbXVPL3RibVNyWFhWL3ZUTlJxS3J2QjJUeE8xZTBqTVNnY0JY?=
 =?utf-8?B?SGdHTGxhOFFLTi9URkxTRVE0R2V6dWdDT0tVcFYzTUM5QzQzSzRSUU44Q0Fk?=
 =?utf-8?B?VGd5aDdZNk9PRHJ0clBBN0xNcFhEbnZCelZYZlRXVlkxajhFWFJZM2FYaGtv?=
 =?utf-8?B?bGdJcEUvU2dML09oaHJGL1FZdFF4Z1dqdmJjMTJvajJDNXpLbVJTb0tIOVBx?=
 =?utf-8?B?SUg5UHRrV1g3d2l4Q09KeGNKVzQ3VTRsajVlRGxjRUwxTkZyekNmclduR2Qr?=
 =?utf-8?B?WTQyb0lZSEJkcThmcHA5SXliWHk4UUFRZlBVTGN4NWdPVC9CaEJjTWp4all3?=
 =?utf-8?B?amtjeTNUUURjQlBOZTVEY2FPQVBhVWdaUlJxU1JGN2Rya2Q2bGlpS1FTMmlq?=
 =?utf-8?B?TktLMGUrQStVT0xzcDI2L3lrdTNXZ0dEZHVEUVFJbWZQUkx3aWdORmpPemJq?=
 =?utf-8?B?Z3BIVDY0NitMQjkxMm9tUDNPUHhraXJ6YjdSOUtFVUd1VGxrTURLNzVCNHZx?=
 =?utf-8?B?a01EMTVQZFBoaEZNWHYwUk5jQzFELzlWdVdVWmxUVENTNnNrVjFZQ0NhWHh3?=
 =?utf-8?B?RDZuTlg4aXJ0Q0JZL1dYMkg5b2QzVWtZYlhPZWRTQW9lTXUwY0J2MEQvRXZo?=
 =?utf-8?B?QlJrU01BeTZKS0VCZ1VyMmxyNHJxYWxqUDVhdzNQR1krZ0hVd2lnRERBa1h4?=
 =?utf-8?B?emRMblVjVFMzQzhOS09RTmFFZ3l5STFZZnQrNFU2ejYzTGkwcjhIZm5CNy9q?=
 =?utf-8?B?K20wL0ZHZXpkUEMrd0d2Z3N2SmlOeC9ZQzdBN2o3bjU4UHJDMTBxaGQrTHVZ?=
 =?utf-8?B?TExJODVjc2ZRdXdnOUcvNVRRZTB6SUJ3U1RWWndJdEVLL0cwLytUZFQ4S3ZX?=
 =?utf-8?B?TVNVRWVrbSsxcjd3V3pjRVN6cEw2ck96UjNPZU1oR2JqNFVMZjVoREorZlUx?=
 =?utf-8?B?V3BrRmNzQm1ScXBzWDJIL2xnVW1DS2RxR2RUdjVENHU1MFJucUlKR1VIOHJS?=
 =?utf-8?B?bEdQbkRZdGM2SHdnUzZQL0RBL1llTWd3NnRzcUp2eFF6Qm4wWTd6N0lxMFhW?=
 =?utf-8?B?VmFZbkZreXdJaUw5UWpyei9VVDNsbUhmcmNyNndPYmJwL0N6Y3A0REltOU16?=
 =?utf-8?B?Y0hjRzNvUUNMeW9ZYTlKQVpJd0Uyc0RCZFNVaUpiWEM0aE9pVmFxZmVrSUV1?=
 =?utf-8?B?RXUwdHpSRTFHNjlGY0dSeVlBL3FsUWRMdStkbWxZQlUrUFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3VUL1E2T1JIK2tEaFA2Sy9vRzVCWXp3RWg3clk5bEMvMjNOM2dmKzhDOWVQ?=
 =?utf-8?B?andKWk1qWkM0V0pLVG9KdVY2NFc0VTlXc0lCSEdtSjJ5MERudytoVkFhR1pk?=
 =?utf-8?B?UmRWUjdHQ0JqNTFuZk9MbGFlbnl6cnNRN0ZvakxYTFhqNDh6S2x6eXlTMFU1?=
 =?utf-8?B?VW9pMTQvaUdhZ3F0MWEvSys2K000N1paZVh6dEtETWJ2d0liWlNIaTJkWEtr?=
 =?utf-8?B?SDZiTXh2SGR0TWh0bWVZMWVqUUphd09kR0JKOGY3Nmd5VkQ3MTVXMTBuTVlN?=
 =?utf-8?B?MWdwYlFiekMrV21nYnFob3ZueXI2UXFvOXRtWEczOFBvUG1UN0d2NXhKZ2s3?=
 =?utf-8?B?UnE5RURNNFhDUVlTNWcvSlNSZDE4NmMrWGh0YVdiSytRRkJYNEFLYnRnQ0ow?=
 =?utf-8?B?TmV0YkhyOTMrTFZ0eHJTY1VyMUdxMWpFMEJTSVZrZzFRL01oamxmaUYxeEhu?=
 =?utf-8?B?ZFVVaE1pekVQTEVYNisrQjN2QTc2STkweEZmb2U1WU1yOTJkaERQMzlHYUVj?=
 =?utf-8?B?REIwTG5idFlZb3ZyZEorOEdDSHlNVFYwZjcwZCtLZ1FNMjVra0RXV0FyOTdv?=
 =?utf-8?B?bkNmQ2xlUm83RCtkSmFXalJNaUJ4SmtuYkhpYkc0dTVRUWFtZEQzaERwZ0l6?=
 =?utf-8?B?SWwwV0RkRDBBaUQwMXdldFlMWjVvNGRGMmkxK0thbnlmWGlEcGJUM3AwYzFH?=
 =?utf-8?B?NlhpUlpEMlNEazhjeHdWVXdJWmNXZzVzdXh4azF4TjVLR2dMc2QwazVlYkE3?=
 =?utf-8?B?OElDODRhaEJuQW1rNm1ZWXRRWUZBZEcxQmFpckdvZ1ZxOW1QaW4wb2t5dEJ4?=
 =?utf-8?B?a1U2em80SGZ0aHdWZFBsVHZ5MC8yTTRiL2hRb3dKMGhBcldncWpJMno4SHda?=
 =?utf-8?B?WUtkWEU2eG82YjBVREtzdXI5aUp1d1JJZnhpMysyUHJZQ0hiUlZzbi9MMDQr?=
 =?utf-8?B?Z3FMRzFZdG1BNjlmaWlRVXpIN3VYVG5lcCtGOVJleVVEeWowam9RaDB6T1dX?=
 =?utf-8?B?czE0dDJId0c4MHNadzVEVGJRSXNvK0wwWmkvK0hhZlZPZ1dESzdSUkFtR0VI?=
 =?utf-8?B?OElHaUNQbjJCUEsxcFVyTkN1eDRCS3k2S3JrQU16SHp4U3VDbFUvYUJNL1V1?=
 =?utf-8?B?cFRLOG5QRytyaEZZRG1IK1RnSFFGQ250TG9qMldMdU5hMVF4RFR6MHVIN0t6?=
 =?utf-8?B?RnRyK1IvVEphWEZxc2ZGTWNDaU1EOElBRitiaXJvWHl0SkZqdzBJZHErZWxm?=
 =?utf-8?B?ZVFRNlc2bHlHRVc0MldpMzhod0ZQd0RYVGZKT0dLSXI4K20xUyt5RlVxLzBH?=
 =?utf-8?B?WlM3aHVJb1JXRElyYnk5RzU0bE9Qb3d1TU44S3B3dlp5VGVEeDZZMnVKSytQ?=
 =?utf-8?B?L3BJcFZEZ1FpdWVMZ0d5YkF2WE5lYWw0bDNENkNUYjN2WHNDblhhcENQMzJ4?=
 =?utf-8?B?V3l0S25SZW83REpsMytTWTllOFBqeVl6b3RCYk1xZFVFNlpPL3lDdHFhZEZD?=
 =?utf-8?B?TndrZWtZU0VDR29hbWtkUmRCUjJ3dWRUdnprWUJZbVBLdXpTNC9aUUp4MnpF?=
 =?utf-8?B?RUV3eEc0RCtRZ2VUbFBHeE5aZm5DQW1GM3JURGh4NEFDaGRQa3ozUHM3Ti9u?=
 =?utf-8?B?WC8weWl5T0FjK1VZV1RJcHFreGJmR294MTNvVEFkaVFoZnQ1S2g5cElTRmM5?=
 =?utf-8?B?S2dYZ0wwemd1TFdUb0RTSnJ6YVMyelVHZjI1SHByNlpPaS9VcTYwdDdsclEr?=
 =?utf-8?B?cXBXazZhS2plZldvb0hLUVgwekVOZXBhaHlIQnZGUUxwMnJJaE91N1d5NHhh?=
 =?utf-8?B?Y2lwVUpRYWxBb2V1MXRWaHdaY3ZuelY3dlNqTkgwODdJL3YwdkFrRVowTGdT?=
 =?utf-8?B?RFpEZzV3NVhGNDIzVC9OUWtSdGlyazNzUXNHSVZGbkZiY1VEVEJyYmhwMmNE?=
 =?utf-8?B?VHlxWnpTWnRLbDVHeG5KRkh2VlpIN2gxNVg4ZmJWZFpuTFVydC9ITFBEY2Mx?=
 =?utf-8?B?ZmVyTEFNL1o2cHdwVlV6aFBEUytmT25KUVdIQ2dlckR1UjZqSWt0MHgxdURs?=
 =?utf-8?B?L25RdDB5NHdOYkU0STFYS1dDTjlsdGZiZndQOURiV2Vab3NpcTRHT2docmNu?=
 =?utf-8?Q?ZdrtEMslNvI/vE76PNFjwO7cv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5187f2b9-81fb-48f6-c8c1-08dcaf753b66
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 02:22:02.3138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSXp1aJgniPWNjhSvbNFX0XMQm9CDyObORJs4Q6qoE7GuMNyGxjqg8neX4vxszNRzFYWcUs8owYT4EIenXHpUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7368

From: Peng Fan <peng.fan@nxp.com>

i.MX95 System Management Control Firmware(SCMI) manages the clock
function, it exposes PLL VCO which could support up to 5GHz rate that
exceeds UINT32_MAX. So add assigned-clock-rates-u64 support
to set rate that exceeds UINT32_MAX.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-conf.c | 104 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 73 insertions(+), 31 deletions(-)

diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 058420562020..37b72600b296 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -78,47 +78,89 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
 	return rc;
 }
 
-static int __set_clk_rates(struct device_node *node, bool clk_supplier)
+static int __set_clk_rate(struct device_node *node, bool clk_supplier, int index,
+			  unsigned long rate)
 {
 	struct of_phandle_args clkspec;
-	int rc, index = 0;
 	struct clk *clk;
-	u32 rate;
+	int rc;
 
-	of_property_for_each_u32(node, "assigned-clock-rates", rate) {
-		if (rate) {
-			rc = of_parse_phandle_with_args(node, "assigned-clocks",
+	rc = of_parse_phandle_with_args(node, "assigned-clocks",
 					"#clock-cells",	index, &clkspec);
-			if (rc < 0) {
-				/* skip empty (null) phandles */
-				if (rc == -ENOENT)
-					continue;
-				else
-					return rc;
-			}
-			if (clkspec.np == node && !clk_supplier) {
-				of_node_put(clkspec.np);
-				return 0;
-			}
+	if (rc < 0)
+		return rc;
 
-			clk = of_clk_get_from_provider(&clkspec);
-			of_node_put(clkspec.np);
-			if (IS_ERR(clk)) {
-				if (PTR_ERR(clk) != -EPROBE_DEFER)
-					pr_warn("clk: couldn't get clock %d for %pOF\n",
-						index, node);
-				return PTR_ERR(clk);
+	if (clkspec.np == node && !clk_supplier) {
+		of_node_put(clkspec.np);
+		return 1;
+	}
+
+	clk = of_clk_get_from_provider(&clkspec);
+	of_node_put(clkspec.np);
+	if (IS_ERR(clk)) {
+		if (PTR_ERR(clk) != -EPROBE_DEFER)
+			pr_warn("clk: couldn't get clock %d for %pOF\n",
+				index, node);
+		return PTR_ERR(clk);
+	}
+
+	rc = clk_set_rate(clk, rate);
+	if (rc < 0)
+		pr_err("clk: couldn't set %s clk rate to %lu (%d), current rate: %lu\n",
+		       __clk_get_name(clk), rate, rc, clk_get_rate(clk));
+	clk_put(clk);
+
+	return 0;
+}
+
+static int __set_clk_rates(struct device_node *node, bool clk_supplier)
+{
+	int rc, index = 0;
+	u64 rate;
+	u32 rate_32;
+	bool is_rate_32 = false;
+
+	if (!of_find_property(node, "assigned-clock-rates-u64", NULL))
+		is_rate_32 = true;
+
+	if (is_rate_32) {
+		of_property_for_each_u32(node, "assigned-clock-rates", rate_32) {
+			if (rate_32) {
+				rc = __set_clk_rate(node, clk_supplier, index, rate_32);
+
+				if (rc == 1 && !clk_supplier)
+					return 0;
+
+				if (rc < 0) {
+					/* skip empty (null) phandles */
+					if (rc == -ENOENT)
+						continue;
+					else
+						return rc;
+				}
 			}
+			index++;
+		}
+	} else {
+		of_property_for_each_u64(node, "assigned-clock-rates-u64", rate) {
+			if (rate) {
+				rc = __set_clk_rate(node, clk_supplier, index, rate);
 
-			rc = clk_set_rate(clk, rate);
-			if (rc < 0)
-				pr_err("clk: couldn't set %s clk rate to %u (%d), current rate: %lu\n",
-				       __clk_get_name(clk), rate, rc,
-				       clk_get_rate(clk));
-			clk_put(clk);
+				if (rc == 1 && !clk_supplier)
+					return 0;
+
+				if (rc < 0) {
+					/* skip empty (null) phandles */
+					if (rc == -ENOENT)
+						continue;
+					else
+						return rc;
+				}
+			}
+			index++;
 		}
-		index++;
 	}
+
 	return 0;
 }
 

-- 
2.37.1


