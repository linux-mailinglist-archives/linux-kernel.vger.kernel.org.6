Return-Path: <linux-kernel+bounces-307701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD339651A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E5F5B21354
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC49B1BC095;
	Thu, 29 Aug 2024 21:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BTe6Cf6V"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A1A1BBBC9
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966119; cv=fail; b=Loz7eq07agTIKcXOWUGTjjd53cNxhoAVZSBasEGzGOR1cObVzqsEt1KlNS/B/PyStuGLPNJtOiR2p6SeKJ9UDFxFhyYFuanD7ilQIqHTT+wHZMUrS1XQXjYNyab4ZUN9Q3QAE30e+cQAz85EPyLLQFbztfQRAHOJooATsA1Aok8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966119; c=relaxed/simple;
	bh=8g39LLjNh6tgt2AoF/k4PMt/JQ4UPEhwPL8LAWtogv4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SzbfRQjAbq/Ev3WGcNqBUaTdQMUfXEXlQn4+r0tw4ab81sMqQ9XejxQXNc5sZp5BtcQZ7JFQ5Z2I0+PDlIDRMG8fK3LxyzsAsVpVDYNsjTiZa53w6ejdOPdF7VBOyvfYZU+ZmkZ5KlmiUMsmnsdSlLx3qj//u6oYL/Iv3px7qyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BTe6Cf6V; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmzREJ9U/uV7loBj03EKBTIoPWKXY0t3QhLgKVl9kkUilVg+175P+ubyEd4G6qbaA1omknPjyp3COPBUZfenKaolKDe88JFo3Q7fpUZDmxwo2Q1pCV//J9Nt1muW7LhIhibGPhsOnFtxEx0GCiZ0WbY1iFmCIe0tJDZSwBEwQi0y3SEKKvNOT79YvfIXBiINWaOeK9vGkqGOgd2yRhKRHsfBiqJAzDlsdyubbG3WTy9k4s1hNR2rhbALexpX2r05EkRPpZX/Jv6RjiStYHgM/lwzuLfnvha4ZY0PvbKV/ityrLhaI8K5lt8qMQS0iIy/KynHPuFA7ZQXtGbRtIpWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXODyE4M+mQV57wFyvfvGmCTZpGJ/QbF0kDJVOYsNqQ=;
 b=MODfhhn+77nRCqQcHUib0BC+fIDTZlNkB5nET2U/WR5w6HQzBVkoIvapHBcBo5N2UR1DsbUhkTbQNX5WiYtUO+9kpNtU6Uv5jorOe8hjCtKKZlTysTG40Y+XWp9LE3kCiVaFbcKjYZS+LrsoPuSjwqY8ZUIi9MKWC5Jvd9LCSMr1nqO3JlwB/jDhWm10ONJqKe6paXa8kPBc6j1ZTG9sUvUhE8LRcv0erQ1c7JPHhJiEj1WEVtODRFij61IbnN4ikAM1335cu7kEXQVQ/beXVAO2dO6GkdBwSCMENNjv9bohNzcBX4RNznZcC0kyhJ1Uj6X4gaG8bWJIvu6ZwGMAsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXODyE4M+mQV57wFyvfvGmCTZpGJ/QbF0kDJVOYsNqQ=;
 b=BTe6Cf6VVW4seNrN0j+uroQvWYmWLgePqb8ZN+C/pVn2IqHvGkCsDAx4Gc4n3hwR66aHosL7+CbaVoq251KGHku07xvGPtk3l3p7vftwIc2pOiPwnAdV9ELbZy2mtZELbrVqeWP9PtAKRIgPpfzkwx7GjCpFEczXoTcw8ToQJsKwN8j0yYfok5ow2akEDOCuXxDNrvG6hcYzIdNSrGtvflc9Mp8HgYEZr4IaqrNYe09UTUEWqCsaIe2roOPhooYCf7lcEKKp77UAWilNKKMX7o44bN01H4sHdAuVs3Jv8CmMcjjHnz7A+kYGWQ5sHIQzMrg1Ij6to3MjG23eG0dd0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8971.eurprd04.prod.outlook.com (2603:10a6:20b:40a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 21:15:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 21:15:15 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 29 Aug 2024 17:14:06 -0400
Subject: [PATCH v4 09/11] i3c: master: svc: use spin_lock_irqsave at
 svc_i3c_master_ibi_work()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-i3c_fix-v4-9-ebcbd5efceba@nxp.com>
References: <20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com>
In-Reply-To: <20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724966083; l=2497;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8g39LLjNh6tgt2AoF/k4PMt/JQ4UPEhwPL8LAWtogv4=;
 b=yxdTXFHmhOc2CVduqHWpwSQ6h86NDCqImqQgbUCn+I+/GqB0N6Fdi/3RVzNBubcePafy4vIRZ
 bD24j/m1eJCBtpC0QCepojrjzHOnVBaFLMk1ErcZny2tQqV1nDZ+8Xg
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8971:EE_
X-MS-Office365-Filtering-Correlation-Id: b242bd20-9255-4397-7a1c-08dcc86fad17
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SllCMzNESE1oa24rMXJER2h2Rm91RnhJZjlRWnNSa0k3Tm5ROW1PcVI4dmVQ?=
 =?utf-8?B?ZUkwb2NJQkF0SnpUNnRVSkdCTGVMQi91Y3hhNnRFWURUL1BaM2NPd3E1UCtH?=
 =?utf-8?B?MUtwMjVxaFJWUXhNUGJacFBSSXJsRndzMU1vTVJyMkRFeTBNcXFVRzJoYnFE?=
 =?utf-8?B?QUxidk5TYzErY3VyWkU5eGlLUERNdXNsQWlzbllNK05SaTVFYTUvbTVHcGVl?=
 =?utf-8?B?RVdoZ3dqdWhzaTdERUhRNjVKcUdrRlBnVFYyTEdSYmxwUVRNWWpOcFFYdE1j?=
 =?utf-8?B?Nzd6K2xYYUFyYzd6QkpxZWM5SFdBUzNwRnAxeU1IMVJQTG11RktHc3RranBj?=
 =?utf-8?B?MDcvU3hyKzFDdjlERzErTWNDZkNHZ0l6SDAydzhhTXJMdFlBU3k3eitTTnl0?=
 =?utf-8?B?L3dLSG1jN0VnTzFoQzUrMFVzSTVXK0pERFZpL3MvUUZNVWQ3dU9haTRWTENS?=
 =?utf-8?B?bHZLN0JQbml5TncxcUU1cUF3WGJoanJLdVJPYlp6V3FlOEgvRDR4Z3IvVDk5?=
 =?utf-8?B?Z2Y1dUgrZVpETFVVNlBiTWJqaVBHVVZTSmUzQmxMK29nelZuYVllV3czZzk2?=
 =?utf-8?B?cVUwNGxzQTlqV290VytYR1BwOXMzS1cvYzRlRXlCSTRzTGxXSFo3L3ZWZm4w?=
 =?utf-8?B?VjBRV3dyRmR0cDJPVUNvTHFUQUZrMUVxTVlXSVd4bm1QeHlyOTlSTktQQ1lB?=
 =?utf-8?B?UitkS1ZvdzIrT3V6ZTBuNjVVOUpjRXg1YkljTG9XM1FlbkNYN2xlTk1RaVQx?=
 =?utf-8?B?bWw3WGFwSUFVbVlTUHgwS0FEUUNWekNZS0thbWhtVDJUVUlpcnJ2TVZhK3g0?=
 =?utf-8?B?WW92NUN0dldvOTNtM09uMGRqUnRwQzFpeGFocEFEZS84OW5VLzNZeHRMSEs5?=
 =?utf-8?B?bkFONUFIM216MmpQZHdqZFNHdGtlYmFJZDlKOUYxcHJRRzZIeUJJbHk1RTR0?=
 =?utf-8?B?UkNob1JtcTdlYTRSVU9NTHlka25DSGxaRzZFNVd2RjJpdGsxRnovbk9LdmFs?=
 =?utf-8?B?MnFGM2dFNkpUckpEMWpkck1HUzBNVFNVS2lPL1N0dFZZSmlnRldSV3FBbFF6?=
 =?utf-8?B?b0poWUNXMk8zRHpteWFMcU9VZmhTckdNTmh4UFVETTZKMUVTWFB2dkdnaXlk?=
 =?utf-8?B?NVRLblo2Zkhjby9TWWJMbWdnNytrZVkyQmt1T005c25tck1vMWVzVk0rVXAx?=
 =?utf-8?B?T3FYMzVnZDVxZ0RxZjVFVVFnYWJneVpXVEsvMU1vTXBDdEdCVmNrT1BRYWk0?=
 =?utf-8?B?V2JIbGdpdUpQem1LSExLSzJIYUdiWDd6QkdpQVJRdHBsR0FYLy9BbksxZjlB?=
 =?utf-8?B?Z2JmdmIyaGhLU0RxSVNTWWRmckNNUUVQR3dYZ0dobHJuRjVTSnJZbnFBVDBB?=
 =?utf-8?B?UlpSSmY4SDlHOENIT2VLMGFiYTRIOE81WDRWcHYrU05yV3J1bElxVlJiekNV?=
 =?utf-8?B?bWN2ZGpiQ1lmRmExbE5BUlJQd25kNVJuMjVsL3hSVVNpS3pnbThZeEZIb0ZP?=
 =?utf-8?B?Z1hVMThsZC85d3VUVlIvNlNLemdEYnlIdHNObXE4dWNMb3dTUkhlK1hMSHlz?=
 =?utf-8?B?bURxZzhkb29MbE5JOFFYS3JJUW1ldEhkWVB3QnU5dGJoOENOYUtiZ0p1NW54?=
 =?utf-8?B?Y1FkeEFaK2dCTEdGajR5N3U5MldWYlM0Nmg2WGtHSUdnQUd5ZElkNVdERnhM?=
 =?utf-8?B?ak4wc1ZRUzRKQm5UT3E3Ni9SK0lZQWdnVmo1SXBsVGtQK3J2NkJySUJ0aTdv?=
 =?utf-8?B?TlM5ZG10N1c2OUkrVHp1amlPbEZKM2hnSmZkazJHY3E4c05abUZkQkdPNjMv?=
 =?utf-8?B?R2VWd3BVSHdUQ0RoRm1ISTQwYzMwRzc5Rjd4dGNnTWVaZ0JFUVkxdGF6bEtk?=
 =?utf-8?B?cHhGTXpnSVpqK3RZLzRqQmRSRGZ0UzNsY2Y5NTlBRmZkelE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?d1JjTHJQOUVkb1JKOVdleFRBK0xYWk01VUJJaEpMd1kvTDNvNDdKLzd3MjhK?=
 =?utf-8?B?OGxmUFh0UytNWlZzTGtaR25rcVY5dGkvWFl1bmo1c1pPQ1FYNmFQVzAzN04x?=
 =?utf-8?B?TUNreXowNGtlM3V1djRzTm5iV1BxNjFBdElhNkN3S0hzUEdMVHRwOG5hb095?=
 =?utf-8?B?ZHpxbjBtSUh2V1RCSHNRUEl1dWhkQVlWSkd2YXpueUEvZlBFWXFzTUFENkdE?=
 =?utf-8?B?UFdwK2l3TTlhVUd1eEREOWhvSXl2bjJtSGYyMDVrcjIraEpLak1TZlVoSEFk?=
 =?utf-8?B?aTBucUh4eWtUSzAzbzlvVEpxRlB0ZE55anJYK3lMMlk2Tm5NVjFyTmhSYktw?=
 =?utf-8?B?ZkFOM0ZCUllUUlFwaCs0aCs1cHBscVlGTzRXM1diUWpYb3doYkZvalcvNnpr?=
 =?utf-8?B?ZWVseVdVNURyUVh2d0FSOGxtUlNRY1RJRlV2NVg4TGkrcGxnYVlFUXpEUExq?=
 =?utf-8?B?a21IYnJzVnlxcXhWVG9DbkRUYlVYSmxIL3VlVW9QYUdwenBtVWJGVkY3K0hK?=
 =?utf-8?B?a0hFZFIxZENuUy9SaW5EQzhPUjVUb0ZCcS9IYjNnQm5PdWlzdlFxNTlSNnRF?=
 =?utf-8?B?a3BONmszUVgwMHo5TDJQak5DVFdLRWxnSVhibGd3OTdIK3krYU5xQ3E0L1J1?=
 =?utf-8?B?elFNNlVZcFVPcHdicHUzLzd6THJEVHFEMDRpbmR2TEkrS1VhaEtrVjUrMU9M?=
 =?utf-8?B?SjE1SVltS0cwbkhhVmlqVTIwM2MyUWtjMGFmSVVTbEtEUC9xRFRza3NsSHNq?=
 =?utf-8?B?SlQxZHdRUjA1YU02c2VVTTFwdXA1eXhMNnFQb3JIV1dOdzRoejBjdGxsQWU3?=
 =?utf-8?B?SlhJR0U1OTFRQW9uS1phZEloRkUwMlc3Vm5Pb05VdzBzeEhlQXlPY0d0TFdR?=
 =?utf-8?B?SmpMM1FuK3ZiRWRVdFAwYTAzUHdVSlhnTkpKeGFNL3E1aGZmZ2x5YzA1ZUVC?=
 =?utf-8?B?VCsxdCtLT2MzRVRWYjl6VllvYnJXeUZMRk9WUE14UlM3OGxsbmZQUHladlhG?=
 =?utf-8?B?clZ6bHdxM01kbVlmenRPeTViL0ZrckJ5ZVgwd3pNb3VMRVJJV3ViU2kyT2ps?=
 =?utf-8?B?Z1M1a1I0dU1KN1BaWHU0U1dqaWhpTDhFbFFiMzJZZnJNN2EzckhOOEk0dEZF?=
 =?utf-8?B?Q1B4aWMwWXFRQ3ZaQk1Sc3BidXdlVU9UeUtxbEFQUlRHMjBxelA4VUVLUWlY?=
 =?utf-8?B?YXE0bjM1WEJab2RsaWs1a2ZSUnR3L1dXUzA5Sk9NdXJvS0pvNC9idXdVR3hK?=
 =?utf-8?B?SHRiOXk2MnpuQzBWcFFVa2IweFo2dnZRYnFmMi9Odnk0aGpxblQzRk1ILzJP?=
 =?utf-8?B?RXBxams3Wm4zZm4wOU8vN01CNkplSStKZ3VYaWxiLysyMTd3em5LQlRWeHlx?=
 =?utf-8?B?amZuTGtFelBGMGtsSnUvMUtPak5pZ08ycWFjUEV4N1orYkZJR3gyaHo3U01h?=
 =?utf-8?B?LzJDbkVtTU9RZFZaR1NNYUV1cVZ6UENOWE1xQThZTUVjVnZIMi94TitDOS83?=
 =?utf-8?B?cWI4U1V6Uy9xcE1GTWJBY0xmYlo2bkZGOWtmQnB4cEhzaEZveGFlYlVtQ2JX?=
 =?utf-8?B?b1oxMUNYM3FjSGZuZ2h1eEZnWUF3VEo2V1U4dXhxUVJCbFQvbmsrY2lTMm1r?=
 =?utf-8?B?WXFjRjhjTFllK3pIMWZWTG5aalF2RHVPT3Y0T3BsSU5EL0N2aTBCRDBCZGcx?=
 =?utf-8?B?NTVXQytrSlFnbDhHL3hSQ1JodmhCY1pGY2cxbGM3MU1IQmlWK1JmOWFyRS9u?=
 =?utf-8?B?THUzcS9DV3VVbXp1Z0lBalA4RHcyeWt4RVg0d0lDZmhmbnlJQ2grU2xMaDZ0?=
 =?utf-8?B?U2wyWHJQNllmNUxYdWhQaFQ0UVdPMFhaT1oveC9XdVdHUGF3ajkxS1VwYWE1?=
 =?utf-8?B?Qzd2dDNpTjJiUzhmVVIxNmxmbjBvdlZnaENpclpnODFPaS9Gb3lOa0N6VEFt?=
 =?utf-8?B?N1JWS2tyelo2aTJRRHh4cjhPbThER1A1MVMxVG1DWU90bjJHVGpMVmJQOVVD?=
 =?utf-8?B?Y29jQ0ZrOWpQZFpHelVjY3lEU0lEK1AwSzhsQyttS1E0Y2NUdVZGRnhDS2x5?=
 =?utf-8?B?VXZlYTh5QWdkb1ptekNMMHI3ZUZtN2Y5RnEvR1l5d2NhbFpzMEs2RDhCQk1R?=
 =?utf-8?Q?R9IxhBlldFPiAR0GasdftrOgI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b242bd20-9255-4397-7a1c-08dcc86fad17
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 21:15:15.1592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xnlt+6GOowj4yAugOqKe+ijCX9V1Ak+CIoaGj/eiS8rRTaoG+j4z23ZkiqM9wefmKub4LrDECkfBaBPh3MRBUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8971

According to I3C spec ver 1.1, 09-Jun-2021, section 5.1.2.5:

The I3C Controller shall hold SCL low while the Bus is in ACK/NACK Phase of
I3C/I2C transfer. But maximum stall time is 100us. The IRQs have to be
disabled to prevent schedule during the whole I3C transaction, otherwise,
the I3C bus timeout may happen if any irq or schedule happen during
transaction.

Replace mutex with spin_lock_irqsave() to avoid stalling SCL more than
100us.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3-v4
- improve commit message
- needn't mutex here, other place already use spin_lock_saveirq to protent
i3c transfer.
---
 drivers/i3c/master/svc-i3c-master.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 9f456639d1aad..2b000f446f1cc 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -432,7 +432,16 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 	u32 status, val;
 	int ret;
 
-	mutex_lock(&master->lock);
+	/*
+	 * According to I3C spec ver 1.1, 09-Jun-2021, section 5.1.2.5:
+	 *
+	 * The I3C Controller shall hold SCL low while the Bus is in ACK/NACK Phase of I3C/I2C
+	 * transfer. But maximum stall time is 100us. The IRQs have to be disabled to prevent
+	 * schedule during the whole I3C transaction, otherwise, the I3C bus timeout may happen if
+	 * any irq or schedule happen during transaction.
+	 */
+	guard(spinlock_irqsave)(&master->xferqueue.lock);
+
 	/*
 	 * IBIWON may be set before SVC_I3C_MCTRL_REQUEST_AUTO_IBI, causing
 	 * readl_relaxed_poll_timeout() to return immediately. Consequently,
@@ -452,7 +461,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 	       master->regs + SVC_I3C_MCTRL);
 
 	/* Wait for IBIWON, should take approximately 100us */
-	ret = readl_relaxed_poll_timeout(master->regs + SVC_I3C_MSTATUS, val,
+	ret = readl_relaxed_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, val,
 					 SVC_I3C_MSTATUS_IBIWON(val), 0, 1000);
 	if (ret) {
 		dev_err(master->dev, "Timeout when polling for IBIWON\n");
@@ -525,7 +534,6 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 
 reenable_ibis:
 	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
-	mutex_unlock(&master->lock);
 }
 
 static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)

-- 
2.34.1


