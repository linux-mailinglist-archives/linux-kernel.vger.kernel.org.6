Return-Path: <linux-kernel+bounces-284089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F067794FCCE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC261F2483F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DEA23741;
	Tue, 13 Aug 2024 04:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F9C+OSA5"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB601224FA;
	Tue, 13 Aug 2024 04:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523720; cv=fail; b=PYVdPGUx0Bs7WshRWkmcmkoYLIQC4EE/EXXrM59hEmfPjIQyMCmyq4k4Vw5tM/bGBFkCd5OxpM9Ua2yDslacricXmHb8jXkiFuSckHX/PReDSV9hVp6uJeV53KlRAxDheSjXRZRcCrN+VKa1Vt7zbeygTzp2/DR+FHwS+IuVioM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523720; c=relaxed/simple;
	bh=NMo6sFkFeIc65cjV2JG2Bflkelz/+INVsVxY4jr7p34=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Y+0bk4B1h0JSEy7Tk9qAzPjrDaEWTZ8erGE8K7r6/TaaPiSzpmsoR095v6m6YHu9CRhHbrlOcbXKa7D3Gfn7l3D9cVgt1yxOFVeib4+IW/nwvMYtvvMyIDcDAM+ZkJqKNnfpaAF7uiYNwgarCTY9AWjtIEegqPwKRD3F9KQTrME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F9C+OSA5; arc=fail smtp.client-ip=40.107.20.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsyG3l5zaZOhzDjYKH1B9NdX1HCnqtphtxinHBCS822FlZHV/LDSRhL6bfPHUtRz8kDXIcGDeZxAdthEq34eXJRSqp/egJ7KQ0Ail1ci0MxTze6z690VqJ01Y4W1ipO3RWJ5ZQVcI+eU3yD56Jkw1EpQ/RQ6aUEuDBfzsdxyPgZ/k5QSjsuHXr4fzwlpfOPglAaRsz0nkN6bSKdHFwKbWmuDDIBCKzlcnq5NEPt8N5Z1oZe0pqlQAdqLNjnC6ef3QwYyFXE52lPlbQ5Egew3aRiUk6e9oAdYgpUhAXrwZiYnJrugu4XAoMa8S5EhxehRlH6A9TUaBC+6sz547Mj6uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIZiphfBbg+GPPSmAqMw02Batiw8sXvwnTj8Ves2Et4=;
 b=L02DxfYYv3gUqOY48+lIRjBXJ2Wm6cNFzpe/bm882BJyNX49HU/Njnr5fq4J28n9YW8H959HB5GHSxvdEwVat8VPbJfE16DTonGwYm6XBErClJ1sKq5TCVse952IjMhzCtiABClUtiWZBSeEpl/u36ll/xLtJXldC2ckoJpWZzvmcbWxWD3pX5QML/JV466s6L/cAUgJgXf7WbYGoNujNa9kYpV20ZIezz4Gh+FGvt1x6m1RXCXwLkkjKnqMgduKSiiJg3n816w+80sYwlss85AkBkh1vms8OCbiNPS6r7fyQiInozILalc3XE//5px00p22OyLL0f7IJspO5gvexA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIZiphfBbg+GPPSmAqMw02Batiw8sXvwnTj8Ves2Et4=;
 b=F9C+OSA5V59xYeD5LYCypK5pFH2laJF734TxfgEkCxV+FWNuK1JJBrD2QtdrteTw4slHD0GYzSxiD3hFEj13RCmGS8kgRTHXo+8OnHKxz+V95WxHCENpoqmpRHfaDvu/HwJbkCNndbmACkbDhYjWw5uV3SZMAOUknA8faT1wDRX8YHizivR6Us60X/W3NcKU0rjJ2TBe1n2pj1tPY63S3LI+QtdeYHETbrrNVPyfFVKa379qyrAY7OQavXaFmi1gju8cBHXLDq2apKKg82OwKevTnLr1CzWz0jNNeGU1S6th29lg5nyLrTVaArpaHjEVfnT2XsnrQFzJNlW085Jn5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 04:35:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 04:35:16 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 00:34:57 -0400
Subject: [PATCH 02/17] arm64: dts: fsl-ls1043a: move "fsl,ls1043a-qdma"
 ahead "fsl,ls1021a-qdma"
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-imx_warning-v1-2-3494426aea09@nxp.com>
References: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
In-Reply-To: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723523705; l=1038;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=NMo6sFkFeIc65cjV2JG2Bflkelz/+INVsVxY4jr7p34=;
 b=V+t7a3Z4f4UN7kBiii7GcaLlNzc74M+0lWo/qz0D3kvPEWT/jJ7L6BYunbIUWZMSS6fdImzDr
 wMmAP4xvbEDDxJj3o5SiVA6NluxNr1WM/bg0hWGZhNprcrR6brX8kpu
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10321:EE_
X-MS-Office365-Filtering-Correlation-Id: 772d38c5-e21a-4ca4-8f46-08dcbb515469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czRXWGg4VmRjYnZGbExsTklDRlhJNHhFWm1nWUdSdWthbWpreUtBN3RhN1lH?=
 =?utf-8?B?Y3VpRlhteGtIc2NQcEMvdTI0QzNESE83bitxbFVwRk5IeStaQ3dVWG1lVGdy?=
 =?utf-8?B?RDVZaGY0RGp5WFNBMjZuNkc1djRMYnVKVGUzNWVqTi90NytVeXZ2WFYvQXpn?=
 =?utf-8?B?UFBicy9WaE1hVEZRWXE0K0I5Q2JjenlZeUpsQk1OR1ZzK1BNTzJrZk5iMnpO?=
 =?utf-8?B?S1JrMFJSMHVGWHpWa1FXWTRLMDdqOW8vL3RHeGFrTEN0NWgxVCtlNDh3VHFT?=
 =?utf-8?B?MGwrbDBVMm1wSVJBdDNKK25tVWFDQW5veVQ3L29Mc0Z4T24zdWhCaUh6T00z?=
 =?utf-8?B?UEttNmJPa1ZBRmVtUGZDQlV3SkVkVnVtYXFhc2YxUUh4b2g5NTJaTmZEQWty?=
 =?utf-8?B?YXBBYzA1L3lFMkZXbTJJcU13SGhrMnp5Skl3WmR2b0dFV2hoQVJMKzRlWFlM?=
 =?utf-8?B?Wkc5QnRMMm9BREJmbzhYTTNSc2tZSEdUelRlbVJIekI1RC9TcnEwZ2tCaEZR?=
 =?utf-8?B?RVptNCtrdVM5blZ2T2ZHZzZhcG82Yi82MHVTOGV1U0FQUkRudys5UmdRa21v?=
 =?utf-8?B?dFVFY0NzOVFRWXlZbGpNLytIWmltZzNCM2s3SURmQ1JwWXAvNkhHTWIxYmtL?=
 =?utf-8?B?TTR0dkFGV0NvN3Q1c045MU1BWU1rTWt4SFV5b3QxVVNWZmhteE9kS1NrYTUy?=
 =?utf-8?B?ZXh5dUlPSEh5dFZ6T0pYWFlVOHNjZzFJejJSWHlYQnRSOGdNbE5SejlvNWdR?=
 =?utf-8?B?b0N3YldRSDU4OTllVnVBdVJTWDcxdFh3czJvN25hN05ML3dGRjNZQnBnNHd4?=
 =?utf-8?B?aWVSR1pNZ2hYOWtHajVva2tOajVCMmVtQjFBSlNLV1pEbzUxaDI4Si9Gdk0x?=
 =?utf-8?B?ajNqK09jRFUzWlV4K3UrUFE5bmcyMzZvOWhpWU9iMDl2TWozMUl3QS9ORndW?=
 =?utf-8?B?Tko5eElxS01sSVExZDk2ZnRvU2x5WmlsUUJqaTdjSUx1NUsrcmJUeGp6eUxl?=
 =?utf-8?B?VkhCWVFIVzhQM1N1c3daQnFFbFBqZkJabGUvZG5Ja3NBZ1JOcStwV2o5d1JE?=
 =?utf-8?B?dmFSb2doTUxBOVFxYnkrWGdyNjMwN2JKcnpnWFBvVmxnZ0VHYzNFQzlRNUV3?=
 =?utf-8?B?RzNWMXJqemVLMCtXS3VUVXFjZjA4STU2VFVobnJNK1RXTmw3cGpaUitVME5E?=
 =?utf-8?B?Uk5WVkxSVzdmeXZSTFM5MXg2aWJMKzU1VHpQblRuZnBVT01wWFZpazZXQjRT?=
 =?utf-8?B?aGdKaEZ4bW9JNWYrYzJPMm4zMWo0Zlpoa1BzQktaVEhOcmlTc2lNOWVicFJN?=
 =?utf-8?B?N1ZYMjJZMUFSTE5mcFdsQ3J5VjVRNDR4cHpoa0wyNU9OVVFySGJKYnZ3aGtl?=
 =?utf-8?B?UTlwOFBwM0pqL0YwSWJFYzJOSzhIVHNkRUJ0ZnkrT0xqQlEvTnFtQzgzb2k5?=
 =?utf-8?B?NWlzV2p0c3VFK2R6MFlYdUhzNExJY25tUnhsRnA0dW5QN0lBbUh0UVA2Qko5?=
 =?utf-8?B?SFZNSUhEeU5aMEpvNzZJWVVONGllTzQrSENrOGNFMWZJTVJ2d1B0VzlyKzEr?=
 =?utf-8?B?bXRiNzAvd0s5MjFTalczN085eVlYWTViSmpzQUIrdmFQYUpsSXRMdkg2NExl?=
 =?utf-8?B?L01ZK3RqcVIrTWw1OGNzMUZERXNZcm9SWTZrOXpFcWJVY1dmWTJFNTV2YzNL?=
 =?utf-8?B?N2xvakdOcWp4OVU3M1AxQ1A0M2Ryb0ZtRUV2L3Exa3dSTXN0OStLUnZtMU83?=
 =?utf-8?B?S05xdmVGcXoxSTlGY0srTW9pU2FsRXhLclhOT2ZWaVVCZS9rdE91RFBHdHN6?=
 =?utf-8?B?alh1bFBYVUZMMklUSkViODgzRk9mS2Y4VkhFZ0MrWGNmamRuVkRrSGN2T0lO?=
 =?utf-8?B?SzQxRHRwYWY1Q0EwWE1Xdk5xVVQ1NjRRN1BJZjBjbTEzMWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDJlMXptMWprY05yUHFZMEt6VGZmR1JNWWRxTTNHMkRrQXRDWUdvU3ZpcDls?=
 =?utf-8?B?cmN5WEVEUFhtMmxiN3pkdW8rR2x3V1JCTmxvU2xPYldLVVNpRXBkYnR4clJX?=
 =?utf-8?B?RE5mT3pUZlhkcjloMXM2Uk16WnJySlVyNVZJWlFzOXVhRWo4a2dxSlBMVnNj?=
 =?utf-8?B?bGwyL2hscTVNUFZsT2Y0WmljckNuWi8waDNLS2xjTm9EK05vUExnZnRGTFlm?=
 =?utf-8?B?cnFoSlFrT3hvMkxZRHk2b2F4THhCSGZCNldYVmlWUDFnUFpONmFEaVVCbjBP?=
 =?utf-8?B?dG9RRmljUWVoQ0RJUit4TjJENHc2bmFQb0w1b3dBellFQkJBM1Y5anJDQit1?=
 =?utf-8?B?eDRQZ29PRDhoNGN3aHRxV1lpMUR5K0gyN1ZrQWVydFYydEFMb1VrU0kxbjE0?=
 =?utf-8?B?Ky9KanpQWWdhcy8vMnE4eUptUEJUZnhTM244djRMZ0xmRHV0Y1k1NjZTMk9t?=
 =?utf-8?B?NFZ2S2xoZWYyVXl4M2l0a2s4RWtENnVhZTJyallFVWczeWlNNnJCYll4aEF3?=
 =?utf-8?B?V0dwb1I1Vm5FSjNVekJOTTc5clFWanBUWnc0RVI4bW5xcWMyc294QW5MaFhL?=
 =?utf-8?B?TjlmVmVpa0JxRWJzM29TbjB4NWlMSUo2VDBJTklzUzVxTzJrOFI3ZlFRNHRC?=
 =?utf-8?B?eG0yM2JIYXdIYlVzVklRSzl0RERsUzF0N21xcTFQa21IWVNoVjM2M1Vsa2lP?=
 =?utf-8?B?T2w5RmFlL2dUQXdzZmF0Q3doTzhvRzZ1d1JkL1FaN28xd0xFeDd6RGRnWEJY?=
 =?utf-8?B?SndWNnhOV3ROWGV6UXdreEU1dVBnTHJVQlY3ZE1PendJYUhBOWF1aGxOLzZT?=
 =?utf-8?B?c1d6QUxvSTIyRHQxRUtuNy9NaHZVWUhQa1o0R0JUb1RJaHZ3dFF4ZEVOTVY1?=
 =?utf-8?B?dmlSa0RPTEcydmpNeXBJVFI2d05zUVlFYUcyT1ZUbWFMZ3N0d3VZRkEyWTVq?=
 =?utf-8?B?bXprM29WYVU4c0FjWEtBYXQxTXNoZThzK2JrZ09Qb3FYVzREVHB3dFhkOERp?=
 =?utf-8?B?QWpNdytwbHlpNUVLemJpbVJhY0kraXBYZzFSblpFYkREQ0tKTFNETHQ5SHhq?=
 =?utf-8?B?MmJWSHo0TmMvc0hLOUU3bmI5bFhtYkNLWlo0NmJrRkd2dWRJTi91bUhNRDR1?=
 =?utf-8?B?d1ArRmk4dW43UkJxbDJqWnJqMjdTOHA0dEdadGtKM1p1QXMwOUgyZG9oU1Nk?=
 =?utf-8?B?QW1BQ3NQeXMweS9MenlZdWJWZzlHYVZtcjlEU2xCNHpyaDhQZForYmZMRity?=
 =?utf-8?B?a0J1OHgrTDZvSWxxbnI1ZXhXMGRySHVqM0l2a3dzbEllR04xQnJsMDltRlZJ?=
 =?utf-8?B?ZWFYdk96NHh4ME0yTmpsRGNWQ0dieHdsZ0xRK1RPbVVYUXZOY2lIYUtEYm9I?=
 =?utf-8?B?b0RleCtEVlJ4RzlEeVZMV241UkhDamNUeWF5bCtnbDkrOWJBNW9LWkpjZU9h?=
 =?utf-8?B?cS9ySXV1NkRJUTlMcGJ2YWc1WHdjNElWaG9EVFFlUWh6YkFXN3ZMczdaMDZ4?=
 =?utf-8?B?WWdJSkZXOEZObER5YUxhVUpLQ2NtY1dqNzk1Z1p5MHVTNnpSdFZnc1U0UGtv?=
 =?utf-8?B?RDdxUXdvUnErc1ZrcjFacTVNYStxaDhsZ2d0SU9PNVdFVWdvOXVKZGwwOVZX?=
 =?utf-8?B?ckg0cGpoQWhXMUlpSHRHTEVON0g3KzZIR2FrdSsxNm5tUFhGQlVmWnFOM0tx?=
 =?utf-8?B?Y3krbHRFN2hCenpDY2pQYnlHN0FSbDlGQ1p4cWl1MVVtSWgvTi9MRVcvUHQ4?=
 =?utf-8?B?YjVUMzcrRXVSak9WcHlCR1ZJWWpJcW5Pb0V1QWw2V0hRUzZPUmpzS2JnOTFO?=
 =?utf-8?B?US9JU0NpellWN1gwMXc1b1p3aitNRVNUbTNSWUwxNXFwSzhMMjl3eEVyc21I?=
 =?utf-8?B?ZDN5bkswbllZc21vOCtUN2xvTXIvMU9KWHJWVVRqY20wUVMzcHlYUmVqallk?=
 =?utf-8?B?c1d6RDc5VTBZcUxFUjhrOWVWandONzIvT0dRNUZ1WlA0RVhZWUYzR0prSFJD?=
 =?utf-8?B?QmswY1F6K3RjZVJDd2Nsb0lNMjB4cjdvYlJpNWp3K3ArbnE3YkV6NmF2MFpD?=
 =?utf-8?B?NE54d3JKakx6YlFtV2NkZEI4SjhYRURGaUxZZGxINTdISGhUNnltVUk0RW0y?=
 =?utf-8?Q?jZIHNf7tuRRrg5yqE++jj/SVz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772d38c5-e21a-4ca4-8f46-08dcbb515469
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 04:35:16.3395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGBseWb7tpds7oWUlK/DQ/s0IIvg4XtgSLcxpP+ovjj4b7RiOr3CCMIajlsY6FIVnAMIiCa1mUIOLUpwgkHGOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

Move fsl,ls1043a-qdma ahead fallback string fsl,ls1021a-qdma.

Fix warning:
dma-controller@8380000: compatible: 'oneOf' conditional failed, one must be fixed:
        ['fsl,ls1021a-qdma', 'fsl,ls1043a-qdma'] is too long

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index fc38a0e543ab8..c0e3e8fa1e794 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -955,7 +955,7 @@ pcie3: pcie@3600000 {
 		};
 
 		qdma: dma-controller@8380000 {
-			compatible = "fsl,ls1021a-qdma", "fsl,ls1043a-qdma";
+			compatible = "fsl,ls1043a-qdma", "fsl,ls1021a-qdma";
 			reg = <0x0 0x8380000 0x0 0x1000>, /* Controller regs */
 			      <0x0 0x8390000 0x0 0x10000>, /* Status regs */
 			      <0x0 0x83a0000 0x0 0x40000>; /* Block regs */

-- 
2.34.1


