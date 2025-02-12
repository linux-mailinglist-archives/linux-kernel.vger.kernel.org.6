Return-Path: <linux-kernel+bounces-510666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EED0A32027
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E793A842D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5172204C22;
	Wed, 12 Feb 2025 07:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ikXY0VVp"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320AE205AAB;
	Wed, 12 Feb 2025 07:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346120; cv=fail; b=t5kbm21yzy7Xe7HgOQ1JiKG/YWCti0C1/lkRg4D0s61I2h7UHr9v7Lec58wapdflS2+HFj9FDlN1id7y+tEwWS79aO0HPBGgaeNpuwpkpruvvD4aU801pEcr/u4FtnyOyAWNXxUNsQ9p4dqAObK9+8g9yIupXuvMf+WABjT5SBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346120; c=relaxed/simple;
	bh=bYyb0ZqU/jVvoPkFjCrUUvRwrziPhK36/q8DkNsJRpc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=r5EK3sbK5wY41KMXTP2i54N/K3w77vVOFIMxv05SRdkibWQXAmkRQ6Gf745nopRvPcVI2P/4mXqAf18I4LGakgyhY6KKCjgKrAZyLX2duJPVEOp0USTvBf+TmeJs5sQxJxOGBoDBnUsnSfAMStoKf4Nia6QTvTOGHNk6XPhJDUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ikXY0VVp; arc=fail smtp.client-ip=40.107.22.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgfXTY4fkcEJ+IXD2KXBct4opT7t1xGpFyixLOvPEZ+9VYGTtmeYUgxBNLpmytqCSLPMg4VJFDjaTUjka3rwy0c8mYu+KyBaoMPiLY1ooESp6rTS5OeeQdacoedTtPiGN64HGgkmto2WMvgK4xAt//lFjUfgDIUn7Poe4FrKCUaoTSWzybVYtB94EPc6DEICb8d40/I0223AUbGEXnUVseqD+3WTxOWqGhOEPlgSdztLJMfNpxYMkEXNGs1VFpUalaiCHDe8Ax5d9b3y5s9Ob6kmH7FDNoiEVBF5WXPhEgDOO8c3OLmZpuOZj3nxiZUGvTCLqdACiskk/YUWlFr7Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9H/UZrGNJ2uV2Kffx5loszWsQdrI+3pBlee1YOkCbI=;
 b=RAujjNsGYHXVyeYdzT/bk7QgK0nyaOuZPR9bVIh2cBDSzi4H2B5bHxch1FxXEeBjL2DvJwf51t7apeNgMSx3vlHH1H8n4JElfUdZtuz2/D0gLTQBbT+4s4PTqOOFQqiHK7TEtJ5bQLr6OWqqJMSAclGtMjWidmFvdf3pzWfXEyVIqt/+tPcMBcDxlr24qXewjzYYX7ILyBOJaRVTPcBK0cpQT/7kQ6fj+i37sVc6/ZJkVbua8Hx90w+Rt5/BNiG6oFnEGz/kG9qmzev7ONVkI0Et7pzvg95lvcCdTtO4miQ004ePuk5mWc9h7e8Uwf/qk1YNOYWxcXiDAXV27mzdEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9H/UZrGNJ2uV2Kffx5loszWsQdrI+3pBlee1YOkCbI=;
 b=ikXY0VVpZOsbBz/B1i0ZuHXE0rKnhqJKv3g23wsZQKczxw9KCISSVDbIGpXyo/zgiLTIByWrnLV4KECAc3yYJVX6GTz/BFZ8D++X0jnrRy4UBijWJhlN6UnPF7of9FjoJZQYKwCWfuH3+oMXrGBJId5pvFyuURCCbD3pBsUeFqvLM2rsYMs/BRIdJ3ctGOQgpJqvlWSzfbSW12E+7HVGL0K1oOxrEOCgco/9BfvCESPjHygBS189vuhncUJAYmT1RPOaLujz3pMMfMwkHkXJRvQp78O0bH+9lqG0gNtHwohQlOX4Um8J7E4ZJV2rEBj2EJO1WvBLWuWnxxw+YAzh2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10865.eurprd04.prod.outlook.com (2603:10a6:102:48a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 07:41:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 07:41:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 12 Feb 2025 15:40:29 +0800
Subject: [PATCH v2 7/7] MAINTAINERS: add entry for i.MX SCMI extensions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-imx-lmm-cpu-v2-7-3aee005968c1@nxp.com>
References: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
In-Reply-To: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739346036; l=977;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=BIymGkA7Nj8ryPe/v/aNAs5333irqosIJ33tNalCWTs=;
 b=szFeeck/SpY1sSS8wc/++V623KjdAVWKCB7vVybseLbTtowtBtaHJbAIH5M1sNjXxdNzR1PZg
 8Tqq1NCsrP8DznNxyIK80+nDc6m4wXLmx7reb7h/Dwac9I+MmHzWzLh
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10865:EE_
X-MS-Office365-Filtering-Correlation-Id: d9968534-3cb4-4362-4ead-08dd4b38b7de
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGlQVE5WUU90Wk4rTmsycGs5dUI4b2x5LzRoN1hQWWRoVGtiNDEyKzd3N244?=
 =?utf-8?B?TnhDSmhBOEZDUFpZajF5ZkZjL21uRmNYU0tCSDdsV0RMOWJ2TUVvUlIrOWx2?=
 =?utf-8?B?QW5ORG5JNnJOc2QrSFZ2dVJrK2lSQmtIOXM0WnZKR0lZQzRySFF4NzBiUVZD?=
 =?utf-8?B?aG5lSkpIZm45Q1JHbTY4UVMrNVJWRGREdFBRUzdNaitEdUorL1VPalBiQ1Vs?=
 =?utf-8?B?akhPMlZidnJxWGdFWnhsMnJDS2ROK3JHSGg0VnEzZFhRejkxREhXc0gxYUh5?=
 =?utf-8?B?aTVMZlpoeDYwSGUzTytzaG54NTBBcTNhNUhaNGJpdDhuYVQ3eEE2aTRkZXR4?=
 =?utf-8?B?QzZkdWxXcUJDQ2RobTVMSWd3NGNhaVoyaG1XRHlvcTJZUnMxZnVOZWJiYkJP?=
 =?utf-8?B?b2VHRTM1TDRiVHZPTjFoNDZ0bzFGdEV3b0hiZ09kNm9BZVE2aHF2bitEYXhw?=
 =?utf-8?B?MUVLQzg0SytwZk90VDF3T2RNVHMvbkJFTUZRblQ1cXFtSVhKdGRiQ1R3N1J2?=
 =?utf-8?B?WjJhY0pYQjczd1MrdDNUZmgwRFlUSXRBbTk1c2FpTmZ4TE0rdEovWjFLdER5?=
 =?utf-8?B?MW8zWFV0YUlTN1RxUGFxcVVtODlDUTd2eGZwUHBCNms2WjlNdm5mdzc5RHpG?=
 =?utf-8?B?R2Rva0VsSndPVlVmR1BoZERmZkVCTXEwMnZsbENNMllaLzVSbjhROFJLeTU5?=
 =?utf-8?B?SittMVZ1WmQ3U0J4TEg1bFJaeVdFUnhxL3BmbkxUQ2FGZ1lsK1hROUdiclFF?=
 =?utf-8?B?MGhOWmpzN0EvdVpxNjZpSFZlczg0WEpqemhIamFqeUVTTE5mSCtXRU94Q1J5?=
 =?utf-8?B?VFV1RDdGbUlVMUVNNG5sUktyRjdUaTkvRThidUIvaGtaSzNWRUkvNWwzSHky?=
 =?utf-8?B?WTAvZk9qNnMzRnNQYmp5Y3BwTGdTbG40OHhOVVBSSHpkS29sYjMwdjNFK05S?=
 =?utf-8?B?Q0MxODN3V1UxQTA1eDRBTWtRYWhqSHgyL3lCL0FhTjlWeUtYbFRnRGRwR0Zr?=
 =?utf-8?B?TmpncU1WTTYra1UzZjViRHZ0cDlNaWdreStWNHdMaTRGdjh4KzdXVVRvQkR4?=
 =?utf-8?B?bUVlVHBnOW5vUW4vUzhlVGo2dEFmREZnRStSSHRQbUdiRVJhSTAxdzR5a2xQ?=
 =?utf-8?B?QW9YNUdNT0pxUTZJUnpjRHVsdUVBQVJoYU1zZ3QwTWtMZUZoQURVajR6Mk5s?=
 =?utf-8?B?c1lrZ3BpTHdvVjE0cTBIUVQ2ZVM3Q0R0Y0NEV2xBYjg3a1NWRmhraDlESWpH?=
 =?utf-8?B?bnJjWUtjdC9RMTZpSHVOQWlmb0Jra3RqdmtBZWQ5ZStvTXNhRWVQbTFTMXdw?=
 =?utf-8?B?MTFaSkE2OHRKblRRY3hIS2dBSkxGWVd4N0hqRTRmTks5Z0ZoTFZIaEVVRTh5?=
 =?utf-8?B?SEVuSGhwbVI0eC9ydkR4d3NsN1o1ZnlnMXBRbWhHVjRjL1FEOFZwcEdkYXYx?=
 =?utf-8?B?NVE3dERSTGdVbVF1d0lKRysra21OeUdiTFI4b2JWQ0xTb3N6dzc2eS95YnhO?=
 =?utf-8?B?RTJHN0VtRExtM3RMdjkzeklaRjVwMVcwbThoY1VlclRmdDl1dUdyQVlRczN1?=
 =?utf-8?B?Rks3dUhNNWxnSUh4WTdCTkQ2R3B6NmNxQzA4eEdzZHZFelBIVll4RjYwWVJ0?=
 =?utf-8?B?cm1uV1pLaWdHSXFoeHBBREpONVdxTWRkRU51M2xFNzJVRFBMdHJwL0xWT0Z2?=
 =?utf-8?B?b2hkZ1lQZFRHTFRjK0pCVnNsY2FvL0VuckxJRXJaaVVsaHZkNXZnQTdEQy9D?=
 =?utf-8?B?OXZKUlFacy9PMVV4eFg1L25DVnZaRXdMbjZJdmtNK3RYM1NQK1dzUmEzTFRw?=
 =?utf-8?B?blo1TG9yUFVqZWQxT3BFLytLK0RUblVWRXhyYmloQ29XVFJ5OEs3a1VqUXRT?=
 =?utf-8?B?czNBQXlXZFBWd3FQeUFyVXBqRWczbTd3ZWRjMWk2dUEzQnB6RTJha3VGZjF3?=
 =?utf-8?Q?Xoeb1fKVzJ6415lbPGpsEf6ST2PesZQg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHlIT0R2TGtuM25EQ3l1dFVXcG9pTDB2U0tOYnFxQStQa0hmMDN2YVNteDVO?=
 =?utf-8?B?VlFzWDVPcXphbTRWTEc4anpnWWZCbENPRE9tR2V4cjRGWmJHM1lKRmE0eEFm?=
 =?utf-8?B?T1NTQm1VUWlQbTBHUzh1eTF2dEFVVDJBMUJpaG16S0JoMGowYVNEeVlsNnFW?=
 =?utf-8?B?Ymo5M1BFMzlVZnhKb3FFVXhpZWpxbFdVa1VMR0c4QXVUWTdkcWFGdnhrdGV5?=
 =?utf-8?B?Z0w5YU9HQXlSZjJiYWNQaU1NaUFiMW1VdWlsc29ra2dmYlN0RERQZmFjODUz?=
 =?utf-8?B?VmExNjhMSlNRdERFOHlXVkZoaDB6KzlTOFBKbTB5R0NLcE5VMmhuSy9LTkp2?=
 =?utf-8?B?Rmkya0Y0ZUZQYTZlZ2RWNlY2UzZIKytGV3pwVndmYUw2eERCdEFXTk9pekQz?=
 =?utf-8?B?djRmYitlUEdIRkdVMHRtYU02UTR6Vzk1cVRyazVGZFM2STlJcTZ4QjNUYXA2?=
 =?utf-8?B?QzZHR3J6bFJWZ0VkZFpObEU2WHJCcjh3bHBuK3JjMHlxVURxY2I4elhGQ1I0?=
 =?utf-8?B?U1NrdStZWVhrZjJsSkJXR01TNlhVQmIyZDFhYVhaV2ZwQ2lmQzFEdmtqdUhk?=
 =?utf-8?B?ZWI2VUJWS1hTcjBqQ24yM205OVBzQnJLS054SHlLMWZGM0huU1M2cGFiQjQ3?=
 =?utf-8?B?RXRXcS95by9hLzhEZTJuQXRIY285eDkyM3pDTHhqbDV4YzdaOTE0d3dCK3lC?=
 =?utf-8?B?bW01UW5VQXZGRmMzNFJKMVZiTFBPeXI2S1oyV1NEVEpGcS9Wb21UcXR0dldi?=
 =?utf-8?B?TENrK2NEMWNndUthRG5TTE1ObW5nTTBvbFRONitHWVdhUlhxOCtnTnZsZTNk?=
 =?utf-8?B?djhhNllGNnRJai95ZG80U1BzUWtPbkhmMU9HbHF0SE5PNmpOY2FwKzdhcTMy?=
 =?utf-8?B?aktoK2puckVndW5YaEZzR0Z4SVRtQ25PZFpUSlVUbXFsWW9uMzVWcGQ2Sjhr?=
 =?utf-8?B?V0V0a1FLd0tzbGx4a0xZZ0lFSXdSTDViZlM0eUJpakw3amxUY0JqU0RpYVQx?=
 =?utf-8?B?Q0IyRldkUkNBNDJhTW9vOWtXQUdscmdLRXowSkFjWkVpeVZVeGYvajBlOUxq?=
 =?utf-8?B?bzVjakxQZERFN3VNdVBzcUFJaWNnWTIxN3BTUGdNbktzc0NqdHlLVUlMTitw?=
 =?utf-8?B?Vnd1SVR3UTdzeDJmU2pWcEVwaXpwRFFuK0xtdU9HT05ZZ2NzRitTaDVlNitR?=
 =?utf-8?B?K2pBaDRTOExmeGZ6ZTJqSHBNSmZHSEhUWkZXNTZOU05ubTU3SFkvZnJGVkdK?=
 =?utf-8?B?THRBMWJqemc0a1dyL2xSbTFMWFlmWjd1RnhaMnZBR3F6YVFoMTBwYnpuTUlD?=
 =?utf-8?B?YitoejJTZktSeHBJaVNWanI1cUtRb0RZQ0RxNzZSSFJ1RGZCYjNLT1JEWDBs?=
 =?utf-8?B?bk9idVJQTG42M3lSb2Z2VHhPbjh4dWJhMlpmUHVwVVQvekhrcFpRaXhxT3RD?=
 =?utf-8?B?dnVKNXg2M2wycXN2eE8veU84aVRIcjYxbW9ZS1V1YW1PTWtqdGJDeEdCb0VV?=
 =?utf-8?B?R0N1YXI2ZXNmNnQrdzMxeDBlYis5UlZ5VG5aSVJ3REljWDl4cHN5a2srY0N5?=
 =?utf-8?B?Zy9tK3JjMnM4UTBLZkMvRWtma1pJbHd2Vi9tWnJyZ3Zad2x2U2xpa2Y1N3lp?=
 =?utf-8?B?S0xNcUNXdUNSMEJRaGN6ci9ZdjY3RDNvcWNEK3NSV2ZQeW5DNDF5bEttVy9T?=
 =?utf-8?B?bUxENm9CejBsK3ZHSWI5MkFIVVFPNnNOS3ptL3JyQkhLZzdHOXQyd1hscHlL?=
 =?utf-8?B?SUJRUHF5Lzl0eWxJazFmeDUzVkU2RThpb1JPQUdPTTh4c1lia2MrWGZiRm5L?=
 =?utf-8?B?VHA5N3lVbmwzUnhEWFMxNTEwWEVpKy8xOHVtRnNVeVhUOFdPWXBPcUVudVdv?=
 =?utf-8?B?MllLZHh2U0JFMEZkQ0QvYURKWk52MlhqR3ExK1g2WDc0WFR5VnQ1dHZCaW80?=
 =?utf-8?B?VmFZUERlNVlPY1crM3Q2S0ltSHBNVnpwZEZ1Y1RrbkJ2c3FWakNscnVjeTdG?=
 =?utf-8?B?SXVHQno1TjlIZHNyQk5SSzNoOUJwVk4yUWpHUkhGU3crNjVlVlBKQTNVVG03?=
 =?utf-8?B?b2J2cFRzS1cxNDRVbXAzNWZzdHArc0RBMWFXYy9QdHFGa2RIVHYwUW42aTBF?=
 =?utf-8?Q?EwyjjThk0mRj/Z9e9MtOb1ptI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9968534-3cb4-4362-4ead-08dd4b38b7de
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 07:41:53.2979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWxPUg1sc1ALeBUGOsZwvJhXE2iU5yqodpQt/GkWoneTrIazbEFtv/6oZl0rcxdXMDcKoc8XDSuQCasiJ8/CIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10865

From: Peng Fan <peng.fan@nxp.com>

Add entry for i.MX SCMI extensions and myself as maintainer

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3520ce6f98592f5057bb220da35eaaffa5dd33c4..4a704c98a04b4f17707573f6b7fc1fb4b89c3733 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23052,6 +23052,15 @@ F:	include/linux/sc[mp]i_protocol.h
 F:	include/trace/events/scmi.h
 F:	include/uapi/linux/virtio_scmi.h
 
+SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) i.MX Extension Message Protocol drivers
+M:	Peng Fan <peng.fan@nxp.com>
+L:	arm-scmi@vger.kernel.org
+L:	imx@lists.linux.dev
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/firmware/nxp,*scmi.yaml
+F:	drivers/firmware/arm_scmi/vendors/imx/
+
 SYSTEM RESET/SHUTDOWN DRIVERS
 M:	Sebastian Reichel <sre@kernel.org>
 L:	linux-pm@vger.kernel.org

-- 
2.37.1


