Return-Path: <linux-kernel+bounces-285054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2379508B5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52A1EB24798
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23861A0B09;
	Tue, 13 Aug 2024 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="buYRvvH7"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD84D1A0AE0
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562144; cv=fail; b=Kxs1RbwBO8Jxkzo0hUe9T88wVTZwqsW/Y5pEQlqZdTb+rRz3yzL+Dh6gPMMHWUjlGWYSwbHenmJTiqFFSrnkWZLXbxjO0V3+RapSjwV2mlCtkGevyGvxvD8bBw+2jR6CWFHpWx6Y0Z2jMweij9suELGQ0r51KVk4SA3Aj5drICk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562144; c=relaxed/simple;
	bh=An63rdNKf8siEFmhpUTOtrd2drbSwaCzp/D7qZONW80=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JgUadubXJfO5gmTLCxS9cL8RHKVIQSBXInGxmgF59DGE5+hmc03oJOV8ChHolTLIwPtXNLdMTqKx3Xb7froZfhFh4jZHjzpe3JWsz92MO7yPUIP+3IIGlh4NofCY7JhJrDT/M8wnZlZ2dLqxJlT6tIqSTUILYFtd10F7TZ9qJwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=buYRvvH7; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPauQw4BIFSzfCwqqEC8WKgcjJuP64L9ALR8BlR/jT+ZLnWj0shV1WCkAbshOEJ41NYLIlb+Pe72pd9vhvYJptQ+j9QHxrWAtOc3uF6f9Z4uIdI6EmgsCgPsCGAPaYaHz6K7WsaH0riLbaETWt4FLY2uzw6RQi4qOSZdoRNlHCMHEVErsN1yCB7s07ku0Ve+oUEnY5ZJ9bFLI4xD8pL/7ASSAbtDYVI2d8ALP8553cWWxI69SvlPTOZ1IJCm67gJq3AZaUAUmFR84ZO7uDNTj1tK9GOxrBFYIKsk1vfHqtZ2HCX+gDN/KleUZjrFV5KkIlADswE+7IW0WWdfx/nRrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDbmmbFgBxhKaOhHOUp/UpYi2/c+KPJaw5dvLjPdxrI=;
 b=t6rWn0/UxNUY1VJHt0XYTN431SF2niS2PpwvFgDN4wn3BXmVjZmYT4gxzNJE2ux0gIl1BuTG6txnoPetqge1Nc9xjTcxwa5wCOcqEiAVgUDfjFC3YtNLEQdEKrVnP5/Gf1TK3fe89pouTWwy4JphJMFwWTRzB9gMQ/PGRTgAg14fK3us/GAJDEzXdkDHIN/iC/I7yzYCeAURG5GH/3oQ6Q04BdOsyOBk9TX8kKKgd6cWlTzxcXTebVrAqR6QASVAcf4a10eXPbpvxiu1NiRyeRhi79PFk/Qx9YGwBLupjT+WC1oNYereRtslghsgmkI8HtGHB2dOBP7jyoK9+gpolQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDbmmbFgBxhKaOhHOUp/UpYi2/c+KPJaw5dvLjPdxrI=;
 b=buYRvvH7fP32ZJURl+KNcepblO2k6vRVYAJC1zTFIikXy8L2dZnWpt1rV1xrIQ0wlSg6zXXzMN0EAFJxemtW4PjAo4EgzEr7562E4LdR+k/vRI1kCotftYhh9RAa/bJjxA8Kc9Y+QHbRWH3Yitei/4puY6OpJyD4UqmpNE5Yfv0epgoq8F24th8kmnhL5fWyHFF2f/SpmcRDHx0SihNcpF4rS+nmCKeQik9oVDMZZ5nbdsOwtBAO7uePXMya9cZxBsY80MnUOeG8wC1thCymsFw8FGQgTz183F2hvY/LF6UYhAZEy0Xwbuq+Y/cgXxkMRzhzSwyztfHGgk6H0DLNhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 15:15:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 15:15:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 11:15:04 -0400
Subject: [PATCH v2 06/11] i3c: master: svc: use repeat start when IBI WIN
 happens
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-i3c_fix-v2-6-68fe4a050188@nxp.com>
References: <20240813-i3c_fix-v2-0-68fe4a050188@nxp.com>
In-Reply-To: <20240813-i3c_fix-v2-0-68fe4a050188@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723562115; l=3542;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=An63rdNKf8siEFmhpUTOtrd2drbSwaCzp/D7qZONW80=;
 b=GSS/gw4GojrWatSW1LvUBE9BTakbtuHGDQlwuo4o99k6ZGQ60UuOoY5oYQqbmC03xloO/SQrR
 GFYNL4yb2WFCXdjSvRCpurSuBGhYaeU4N+4/DwpKYIq2LfSdqP2Enwj
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0125.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 8990f59e-35e6-499e-232a-08dcbbaaca6a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?T1poTFluaWNyYStKUU9MNDlGaFl5U25kUmM4clRhRE5zTDlSd0ZCakF3czBM?=
 =?utf-8?B?QWN4SlVOS0tWa3JJdzVRb29jOUhwSUQ4eHpuekRWV3hKQ1hlVUZocTd1OFJp?=
 =?utf-8?B?NUgrbE9uMkdwSDhWQmFMT3RXazF0UlBYMUwyTWpFalErejJlQ2JmS21WNEdi?=
 =?utf-8?B?R1FNaDF0NEZjc2M5cWFaTjFVNzFhSWN1VEF1L3pLeEdGTWdFQ3VYTWtNc0lT?=
 =?utf-8?B?T3BRM3RGUHJZNVcvMFpXazJGSmxHak9LRnZnOURyb1pOQ1dFQW5DZUoxYlBx?=
 =?utf-8?B?RzVOR2grUEVIdjNIQ3k4Z3JkMWQ5K0x2ZWV6UmczUkk5bHlybjEyS25CTnY2?=
 =?utf-8?B?VGQxcE83dkVQY2Q5VzRTQkZ6akRmQmpYTmg5dWhreU1WYU4vYVl3SUFGb1du?=
 =?utf-8?B?Sjdmb3VISW4xbGh3cW9JVEVTQVBPOC9RTVNOcW91N2llMWdDNHJhbTFDeVhn?=
 =?utf-8?B?TDNLMDBuZ0grb0RKRHE4ZjJTUFJIRklGOWJHUHUrYWFJYlBQOElsakFiSUxh?=
 =?utf-8?B?c1o0Um9IWWtFNldMNFJaTVNCM0lQSUlFT0l6eE1TTmlrRVFubnZEVWZxNGw1?=
 =?utf-8?B?bFZWQzZsampyUWdua0ZFY1hxeDNuTzB1SFo2RXFnejlzaTJuanI5dmZZajFG?=
 =?utf-8?B?M1FOanBRWDBuRGdQeHFBVkRaYUlSTmd0SEFPWHlrVGlEWDdleGJBc1F3RkhY?=
 =?utf-8?B?QW00WnBxUndpUHBQaE5YdGtRekkweFNmeGZKcXg1Mkp6b1NGUWtlS0lDNnpm?=
 =?utf-8?B?YWxmUTNpQlo4bEhZU3l6cVNYOFFuMWF4WXhBNkVjK0kxT2xyS29kak1yKzVn?=
 =?utf-8?B?d1ppN1dWWlNrRlVISy9HVkRPaXpvV3QrSnhIMVBCY0cxZHJocC9URmhpUjI3?=
 =?utf-8?B?NmRncHh2YjhXNGVlTDkxUm1ydGdyRVJvZTNwclViQnpHMVRlU2RIY0ppekNt?=
 =?utf-8?B?SEdXbkFTM3NkRHlEdWszTnQrU0M5eWM1OVljUTlVRGtzc1ZhVnhtN3g5cEc4?=
 =?utf-8?B?QmVWTzZIbVF1TkRkS2EvTVk0aTMrTGdad2F3eWxXenBqb0llcGlyN0Jscmd2?=
 =?utf-8?B?dDJBQktGYm83N3FzNlFkNnhta1lMU3VqZDFTa1ZQd2FWekhXRXV5YmVkd2NO?=
 =?utf-8?B?cVNGVHNha3ZiWCtqMVFXMXFsUUdoUVhWY2kxUkMyclZqejNUY3VGcVE1MGY3?=
 =?utf-8?B?NWdWNU1DUEhHZHMzN2FRSE9EcnpYTk81T1RkVW5mRVJOQlZNQll0ejdkWkFV?=
 =?utf-8?B?OENDQ21XZVVoOFFiSUZIUnNacyttbGJIZVNldUJUMjVyVDhoREdWSXpGUkhB?=
 =?utf-8?B?M1lldU5uengvS0ZwNmZIdzRlZ0pmS0xja2c4cUozM0IyeVUwUEJ2cnJkWEZy?=
 =?utf-8?B?OVNMbEc4RmpvaWZEZzFZZXhzRGcxN2ZWRnpQd1BzYWdiZ1JSU0RHMUJYZWJL?=
 =?utf-8?B?c1FBdG05eWZlYUdOYzhvOWhPL1FPdmxJTjdBdGcwUUlRK2Q4dnJVaGsxVndl?=
 =?utf-8?B?WGsvazBISVhlKzB2bXpYVHpUcFM3MGI3TmNZSE8wR0JxSXJqMDNCYW9NdDVw?=
 =?utf-8?B?MHJjS3UxZFc1aDc4M0tVajk0TkFXbU9iZEFJZmk5N2dDN1RxZ0R5NXhDYnZM?=
 =?utf-8?B?eDRzWERFbENyV2kwOEIzUFJRMkxuRDBFcFV6QXNYQ3dkdkJ6NFh1T2VZdmhh?=
 =?utf-8?B?djU1K09JdEs1TUZtY3BwdFY2aTFOM0JBVWVsYlBBeWR2Z0s4ditTS1BNQWlP?=
 =?utf-8?B?dmh3Yy9LcEpPdTIvcFRqeEQySU9aMlNmK3BSb0lLMEpTYlR0bExaV05MSm9V?=
 =?utf-8?B?SXRJeEhwYVZxYk85L3Zsc0ZsMWpON1Y2TWxJOHN2V1BkbDdpdm81dWcxK3Fx?=
 =?utf-8?B?dWo5bHhSRmlxUVdnKzZhYjBNWmpSRFYrU2srMUtqVFZ4bEE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZHJlYjlzS2UyTkJ4R0lsUVlIUVAzdUJBNExSR1VYWkEzekRwQlBMd2ovcEUw?=
 =?utf-8?B?cjhFaG56b3JmZU1lTmFsS2J1RkJjaTFyOVlWMk1LQlc3VmlQSTFzWUNrU2ZN?=
 =?utf-8?B?NzYrd3FJczU4VW9KLzhmaCtQYlUyMFYyTTJ4N1BVUE8zenE0b3N2S0FkUlQv?=
 =?utf-8?B?VHhFSHl3N0dsN3BwYkthdDZNK1FUMU5qcnU1VzZqNkFyWHU0UkgwN0xRN3dN?=
 =?utf-8?B?VDVrSFQ0QUxNeVRNZlAzQXV1RVZvRXJrSUFTSEd2d2NOR2F2eExCVTh1N2pI?=
 =?utf-8?B?endlR2xUcUFsUlNyeGtudC9LWjBhS2M3VVNObk1NQ2hqRnlQeWlScEoydGFv?=
 =?utf-8?B?WWZWMjNWSXM1ZUs0TmtCbE9iaHBDVFVjZ2tZcU9TZTd0czBuWTZ6amZhODhL?=
 =?utf-8?B?SW9BVTZpYlMwYWJ3a1Uwd3JYbVdSL3FwTUsyeHQ4ZCtFdG1ieFBQNUFkZUJ0?=
 =?utf-8?B?eUx3bEpXQlk3SXNTcHZMQWJlM1l5aFV6TmRWRVNTVWdPS01Kdlh4cEFTR05O?=
 =?utf-8?B?NkhaQTYrcFYyOS9kT0RJaUZEcUV1RGR3ZnJMTWR0aTdyL29idUdUUUtSN09P?=
 =?utf-8?B?ZTliUzZUMzhwTEhvaldwZUNOUmRPN0NkQzQrWnZ6czAxWWdHRWlVUjcrRDk2?=
 =?utf-8?B?ejUwWGZYK1FsMmlHNFByNE5TUzNSZVhwNWZhR2hUcHQzcHpOTWc3Y3IyZHRq?=
 =?utf-8?B?NVMzYWNrUmlKYStFNWpzMU5TMDZhaGUveFljWFgyRGpuVlZ0VjU2RFZwVzVN?=
 =?utf-8?B?SFcvK0ZwVTc3S29ja0lpTXRRKzBsVjdBUXVnYlljbTl5clBjcUlkejhVc0JW?=
 =?utf-8?B?bVkzYUR4M0h5VWs3MmVKSU5hUFNBY0V2UkZtZVppd3VhQjVVWDdjVzdDTGdk?=
 =?utf-8?B?cVprS1JDNmw3UGk4N0ZuTVdGSHJUVzBzS1dwOVpWOVdYdHFwaFhsVmRCa0sr?=
 =?utf-8?B?dG45UksxVUJocmRMcEVRUzhiUWk0SzNmTHFkdVFKRVNsbVU2TEl1cUxia083?=
 =?utf-8?B?SCsyd1RGMTR1Z2lkQmd0R0hwY011UmlBRHQvU3Y5bkI1TTNaMUhmL2JUR045?=
 =?utf-8?B?b25KZlJSMFI2TFl3d1JCcmQ0dWgwaG54dXM1OHRTTUdzd0Z6UURUNGhnMW9T?=
 =?utf-8?B?UHMvVlQ2T24xSFV4S2czN243UndCTmtRNlpsd1FDWERMVWNEellkRGZ2N0RG?=
 =?utf-8?B?ZE1kdDdETU5lZUh1amVKUURUb3ZjN1ladjAra2p4ZXZ2TDlVaXZEME1QQ21t?=
 =?utf-8?B?VHA0SlFrUFpUWmJjdkI3NktPNEZvV1FBMERGRnBTZGx5cWx4cHNwNkJ5eGdC?=
 =?utf-8?B?aGEvaFN1U05wV0pUUGRYcTBwanFOOWR5NWxieXFIQkhlVVZMeFV1SEZRWXNa?=
 =?utf-8?B?dVU2aU43NjV2MUw4cVczZjFGR3VCV1QxYzAybk1ZcVpoM3ZISVhyekdCVE80?=
 =?utf-8?B?U2FKNlpmeWxUNWlEeDJLT05jVUE2R1o1NE1nYkpnckxESzhTQjBsMllYZjFa?=
 =?utf-8?B?em81TGJRSG9xS0RsTjB6UytxSnc2K29RUDRxWjVvalZoN0I3NHV6WXpHSUR3?=
 =?utf-8?B?aGpkOUxPUFl2blRRYnluRlJEbFdsTHk0SWRCNnZDOWdDbStQbXhTaWcyNjU3?=
 =?utf-8?B?MlBIRzZBdjZBQmJSUUw3dVdpSlQ4Q1NPRFMvNVZXdHdSTitaNGRickRBR3g4?=
 =?utf-8?B?M3BCTDg4NmpDY0FoSVh1ekVkTDRMQnh6R2Y5cHR5WG05RGpJVGI2UWZzK3Qy?=
 =?utf-8?B?M2F0dXF0cTVKUDZrU0Z2dVNKVktsTzAraDF2MEFGcHJ4SVpQWWFRQ1JlMzA1?=
 =?utf-8?B?TGtMZnA3TWxPRVZVWnpDVUtsNnFucFJMOEQzQkFZcE5Rb2NXbzFSN1o4S2sr?=
 =?utf-8?B?cGREbHlJbStWRXRad2FoaVJKa0lXSDdjalFGZEVNdkdCcWgxRHNiNTJWeHJU?=
 =?utf-8?B?Q1JFRUxpdUkrVWZrTkl2Y3g4NzVYWUx4ZlNPZzV0WC9jTE5NcWplZmt4QTQr?=
 =?utf-8?B?ajZxNklPSVpHV3lGQWdybmNHV0hhaTFIU0FVcnFuNWtPTHN3YUp4cVkvajRW?=
 =?utf-8?B?dkZVWDZCSDBKeGlUYUZyYzl4SVREMTlUVXBHNkJEVHJrMU5LbnNLa2JzK1R6?=
 =?utf-8?Q?k84c=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8990f59e-35e6-499e-232a-08dcbbaaca6a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 15:15:39.5414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDk9XidUxZzH7CGiOTIPxUS4Ifa8P/wIpkp2pjkTAIX2DknUVu56HwDjdLLXShddwBg1viopkgN3RwI3fEIDLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8404

There is a possibility of an IBI WIN occurring when addressing issues, even
when sending CCC commands. Most of the time, returning -EAGAIN is
acceptable, but the case below becomes highly complex.

When a Hotjoin event occurs:
- i3c_master_do_daa()
  - i3c_master_add_i3c_dev_locked()
    - A dynamic address (e.g., 0x9) is already set during DAA.
    - i3c_master_getpid_locked()
      - Another device issues HJ or IBI here. Returning -EAGAIN causes
        failure in adding the new device. However, the dynamic address(0x9)
        has already been assigned to this device. If another device issues
        HJ, it will get this address 0x9 again, causing two devices on the
        bus to use the same dynamic address 0x9.
      - Attempting to send RSTDAA when the first device fails at
        i3c_master_getpid_locked() could also fail when sending RSTDAA for
        the same reason.

According to the I3C spec, address arbitration only happens at START, never
at REPEAT start. Using repeat start when an IBI WIN occurs simplifies this
case, as i3c_master_getpid_locked() will not return an error when another
device tries to send HJ or IBI.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index e80c002991f75..5d19251238ff8 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1099,6 +1099,24 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		if (ret)
 			goto emit_stop;
 
+		/*
+		 * According to I3C spec ver 1.1.1, 5.1.2.2.3 Consequence of Controller Starting a
+		 * Frame with I3C Target Address.
+		 *
+		 * The I3C Controller normally should start a Frame, the Address may be arbitrated,
+		 * and so the Controller shall monitor to see whether an In-Band Interrupt request,
+		 * a Controller Role Request (i.e., Secondary Controller requests to become the
+		 * Active Controller), or a Hot-Join Request has been made.
+		 *
+		 * If missed IBIWON check, the wrong data will be return. When IBIWON happen, issue
+		 * repeat start. Address arbitrate only happen at START, never happen at REPEAT
+		 * start.
+		 */
+		if (SVC_I3C_MSTATUS_IBIWON(reg)) {
+			writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+			continue;
+		}
+
 		if (readl(master->regs + SVC_I3C_MERRWARN) & SVC_I3C_MERRWARN_NACK) {
 			/*
 			 * According to I3C Spec 1.1.1, 11-Jun-2021, section: 5.1.2.2.3.
@@ -1132,24 +1150,6 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		}
 	}
 
-	/*
-	 * According to I3C spec ver 1.1.1, 5.1.2.2.3 Consequence of Controller Starting a Frame
-	 * with I3C Target Address.
-	 *
-	 * The I3C Controller normally should start a Frame, the Address may be arbitrated, and so
-	 * the Controller shall monitor to see whether an In-Band Interrupt request, a Controller
-	 * Role Request (i.e., Secondary Controller requests to become the Active Controller), or
-	 * a Hot-Join Request has been made.
-	 *
-	 * If missed IBIWON check, the wrong data will be return. When IBIWON happen, return failure
-	 * and yield the above events handler.
-	 */
-	if (SVC_I3C_MSTATUS_IBIWON(reg)) {
-		ret = -EAGAIN;
-		*actual_len = 0;
-		goto emit_stop;
-	}
-
 	if (rnw)
 		ret = svc_i3c_master_read(master, in, xfer_len);
 	else

-- 
2.34.1


