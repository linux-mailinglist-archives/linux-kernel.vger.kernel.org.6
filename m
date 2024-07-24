Return-Path: <linux-kernel+bounces-261203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABC793B41B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3CD1F24047
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40A315E5DF;
	Wed, 24 Jul 2024 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c3O3efil"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF8615D5D9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835980; cv=fail; b=peyq5pp+5zXTqbS5sKkv8WT41ZW/SKd0FiXqUVn7o/6lS31srhyVXkF58sOyu52in/4XqezBtqi+4q+txYMoHuJHGFmH6J19XwEyGB2ULVF0Um+lc3gCKJJEFFDFzcx/ILiMWYT9sEPnPeb4ou5tkcx6D4jW4QGM6YuoqIbDFqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835980; c=relaxed/simple;
	bh=nvcmTWDJj+SrtpBzaB8l8keUZ2F8Z2oCpFCzJlzH9us=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ARObhNXnzUxPCEL2xzu96rx6X01RuVwMebtx8HunaypriDOLH37AkWxeacD17UshAWQF7u6B+pxYqYy+GTe+hGEiFgUlUURUNHCpxHeoDCW0vcIcaRZRrKWhvWABYcqBwgza5IWcVpiN0OtMQLFY9Jg7Cdtv0cUCw4tImMA1s9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c3O3efil; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8FVY26yIGeFF2nyBwg7kQTqWqUXzmWy9s+68F/SxFvHaD/z9kxKGPiuwS7tLPJadTy0+Hq5rQ+bJl75bFGxvT/SjSBccYkwll+krvhyy0NVDDuTL44kHaDNfvURgsOjTlcwdTyh6j1SJr5QscLqPPoMBkjIPf1CwXWBcCCLwo2OeWbCGdCkV/mHxCwu8pqmOfpyKbCwffMPGma6jK/zOLR69ilN4jNisGq7BuhjHbthYwZS0ZWEM5X8YmIC3IR/6nt1r+4F6zM5hcltTmn6HgAWVtDoWoGz3lJl6bqFED5ovpG1ItRuAJF17KYWnU8FVtEyojQOkTFGSzII5rxWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jk3Sg8K892J5LLK9qnygB0m2WRCfBM/GY0tQ0z2NeDw=;
 b=PWB7KsGIPUzmMPdiTS31D0C9IvGSjU59b650GBEYYzS88CG3vyGUgcokL3yCQJRUFYAmz3gMhkeZHxu8YSXFJTf1dkCuN4+llqt2ushIi7ywAoZuk+y9h2B8fsizazF3cenDOn++p1Ed+M8K7TZS9XfA0l8oMo4FzNKLc0YBa4j7w8uTmqwUWsBwfo1XJDG1IyZfkDnUH//5J1j5sIiulc31IZWZwkmmQK/yBVSc4d7e5i++QyKKiTqnwZUjNtoLJQBtJA5afEH10iIXh+0CEepioXghd6TS+P6xu6gX7rnjdf6AN/GAbI8zG5v87vVQ9zjrJfKnOYLI08cdP2WvrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jk3Sg8K892J5LLK9qnygB0m2WRCfBM/GY0tQ0z2NeDw=;
 b=c3O3efiloGTsEHe02FROPDYyjYgp0L+gn2NjzjPnYNNnVKw6C0wRtsqx7coSmIYQL2Jj7Fkq3Efriq/4jVFR7vTFMZ2hXSe5ylLQu4Q22XuweQWEgOH9acyXehmuC8asxhRIIsRG9r49zGt0RMz9xRA5jHeIU76tb9K9ULAkzr64/+7IIEuxFwcyv9FOoS4SBQQpxzDuhZwmVfBSMiLK9TSM19hRvU3I5k7yCqfcHCmoYHSNEk9rG0Y15UYkOmMJ2RJFv7zP8vLeycmdwvPJa4dxmL/SVfQU2AjkZVQfYHPrsk+WucBHMYDgrWjmfnx8b4WZBGZZ4yBMd1AdPaIhig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8599.eurprd04.prod.outlook.com (2603:10a6:10:2da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 24 Jul
 2024 15:46:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 15:46:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 24 Jul 2024 11:45:48 -0400
Subject: [PATCH 3/7] i3c: master: Extend address status bit to 4 and add
 I3C_ADDR_SLOT_EXT_INIT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-i3c_fix-v1-3-bfa500b023d6@nxp.com>
References: <20240724-i3c_fix-v1-0-bfa500b023d6@nxp.com>
In-Reply-To: <20240724-i3c_fix-v1-0-bfa500b023d6@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721835962; l=5289;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nvcmTWDJj+SrtpBzaB8l8keUZ2F8Z2oCpFCzJlzH9us=;
 b=sjKVN7n3qDvzp/ZKjRO7ubR1ZFpEBwXfqUL6koCoxCnfbSExSMcJzGPnIGBceG5/8TQp8kc0y
 kNJs07FZpdGCA/k+oQpurU9BSuemRwfNxhtrqKD3F92NDBA1KHkN5m2
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b3c391-a828-4821-5ee0-08dcabf7c013
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?V2JPazBvWVBBYVl0TjBGK0txQ3VEL1pnVW1LZDlyOGU5YXUzRUJxaTNXL09K?=
 =?utf-8?B?VnNuR1lBU0o2ZjJNTVhqajdpMTF0WjRyN1ZvUzhEOEF0Y2p4SjducTRiU2k0?=
 =?utf-8?B?NTYzSVBPcmI0MVc4Z1V3dHY5Rkp4YVJrWCs0MnZYZU81anFoTlZvczY2YXNY?=
 =?utf-8?B?TFd0WnVPUEZnazNVaGdMaUhZSFoyVGx4YytEZ2wrcnEyMk1kSnVFWGo0aG1W?=
 =?utf-8?B?cEdHZzk3V3pldTY3ZnFxYzdHajJ4dmVTdlFvSm0wbEMvUFlCd0REK2FmQmtD?=
 =?utf-8?B?QWhkZjZZaTM4SjIzeW9ZUks0Q0IwN2dTUVlUNDhCeWFCWHN4aFRidjdHZ3BF?=
 =?utf-8?B?QUFsYWhVelhrNmZWWWt0VGhKWk5pVkRKVzQ3dm1QR28xWkNSeWFvb3J0TFRt?=
 =?utf-8?B?VDhtbHZYU3M2bGoyOSthREY1THFXcWZmN25LWXI1Snd6WCtIWXY0MDJlN2dp?=
 =?utf-8?B?YmhDWTArWXVSNG10UHczOWlTYmMyak1Pck9wY29vNno5cFErRnkzQXBTVHpz?=
 =?utf-8?B?OFNjNTRzcXJtczR2L3lvNzcxRmZrSFZOdlNzMmFJSXdEOEVNbnRWWnA4a1N0?=
 =?utf-8?B?Wm0rU3dwMHRmUmhNQTVIMUNpSndTWFZjelM5cmZRakFmblpENnFyYVlRRXJF?=
 =?utf-8?B?L2gzeVUrREltOWdQZWxSV0tvSHpqak8ycTltczRvRjBTQUdJSlJ1N2pteW9l?=
 =?utf-8?B?c1YzYzAvTnZ1MDhXTzJqTjBWcTlWQXhkWEhMeXJnem5Yd3JmeXYvYmxGcEJI?=
 =?utf-8?B?cVVwanRVZ043M0JKU0hSak5jUDhNM0UvVVBrVnlIYUI2c2hBV0NNdzlvUldz?=
 =?utf-8?B?Tk1rVE8rbjA2blcxL3BBWmkvVkR6S1h2dDB2MG1kSzZMOTVMWWEyWks5NTRa?=
 =?utf-8?B?d3VlblA1RFU5S0xoQXhKaEhid0s4M2ZKRGRaQTRYMFozTERRZGprWURzZVRW?=
 =?utf-8?B?Yk1Kczg2MVhWRUhBUVJVcWh1Z2RVaHR5bmh4cGgwcUwwU0ttZ01QVGphbFls?=
 =?utf-8?B?dXhyZWgrOTg0TUhHWnZoS28wL3BPYjBOZ0g0aEdUc1RjZ013NldRYnFVY2Jk?=
 =?utf-8?B?Qi9Wb29mRDdvaWpsY0JQZ2ZZSTRYS1lSY1VSWXdUVlhFd0d5L3dmdkh0Nks3?=
 =?utf-8?B?NTBKZkxKekJjNER1NTRGWTJNVUgzMlp0TGFTSkdpVzQ2dlliZVp2YnM2MnVx?=
 =?utf-8?B?cFBYUllVRmtmUHNwL2hXL1F0d3hjMENJSkd4ZnJ6Ukg1QTFzWDVzYjZYQkR2?=
 =?utf-8?B?VWtnQ01Ta0RmN0E5SUVFdXVHQ1dmWXlTN2t6aGNRZmxDK3Fqa01tYVlpNW53?=
 =?utf-8?B?eGxueGVQck9wZVRWV1BRMVJqcFkrcElUdDhENk12eTNoYk9lWUxTN3pudWtS?=
 =?utf-8?B?K3luaVZXd0VKMG5OSXdMS3V0QmMxVXBzdWU3cXE5Z2dFcEFqckpyY0lqMnlx?=
 =?utf-8?B?Z2xQc1VSbGl0ZndlYkQ0SFk5ZEI0bkxzemc2V0JSajYrWW5JMnJWWWl2QVEr?=
 =?utf-8?B?YXp5R3BDc3JUSndrRmg4SXlvODBpeEc0UWNFT001d3BKTFpOTFZpdURISlVN?=
 =?utf-8?B?MEc4dytib2N3bCtzaEs4MUE1eTVQV2J0eDVCUWpmUXEraUdMenllQWJUUngv?=
 =?utf-8?B?OUNRMkdGbzdpcTVGeUZ0TUUrcmxqeVZlMFJxZG5hREVnU1dWRTkwR3RvWk5S?=
 =?utf-8?B?aUdoSE9zclZTUm9VRTJQR240ZnFzYlUyUUppTmZGeDVlNUZNcXJFVngwajJY?=
 =?utf-8?B?Ry8wN0dPa2s1SnZ4SEtKMWdDeEpOcmdXWC80MSt3Qzd0VkFNb3dxMDJsNFox?=
 =?utf-8?B?WjcxN1pUcTQ1VDZmZkJjUmY2YUhrL3Q4SjdoYVE4TFdGZGVIR0Z5VzVoSzB0?=
 =?utf-8?B?NVQ4eXdHT3J3SmcwNHRPVG5JbkZ2OVBLb0lWTk1KSVRaWEE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?T2dKc1lOdnFLTE1qUUxzQThoVkVmZmttT2FndWsvVmRiYzB5N05IbU5BYkxC?=
 =?utf-8?B?T1c2dDdXSWpRQ0JmS0V3eXFEaWxWdWh0V3Z6RmlEalpYN0hoSnZLSFUwcksv?=
 =?utf-8?B?M251V0I2Q2FKVjhsemswemxWRWJTSXg0ZHZmTmRpdXRzanNDWWd5ZnN5Rk84?=
 =?utf-8?B?dHVmM3Z4OUtPRFY1TktEVHVDY1BlTkVEbmREZm5aOVZGWU83aWZRYXphbGIy?=
 =?utf-8?B?MnFrWDIvbTc3VGhHaUpxWVNrQTJncHJ5VXpTa2R3dWV3SlJQanZVNXZVVWFW?=
 =?utf-8?B?WGRpeFdYSlpwdGJDWVlsdkRkajBwQmVJNEZmckNRSEVUeGVjQVpGbWhPbkFL?=
 =?utf-8?B?cEp1eUZldjc4UXN0RGpDNlhrTG5ucG5MK2ZLQndrMnNFSU1NY2xndnY1ekZr?=
 =?utf-8?B?N25zRmlhNTEyRHl1SDduRHg1TFZIZkFuc05NTGRQSi9KMHM3STJLYWVtM3pm?=
 =?utf-8?B?QWc0Rm1vOEVzWldzVmNNR3VvNTB2MmJibHJOWWpGNkpkSWhsZDZ2UkEvYzJx?=
 =?utf-8?B?U0lEUjduZjlWSVNpdElkYkU0QjRSMk90T09kVVJhNk81Vit2TWt2RCtGQnJ6?=
 =?utf-8?B?K1ZHU0RESEJ5S1U0TzQ0QkE0Z0RkRTc2a2U4bkhYb0cvMnFMM21jZmhaUlJM?=
 =?utf-8?B?b3JVTURVeTNvWXBzanNJOGZ1ekJGakpOemNzeDllS3lzeEFheExKaWxlRy8w?=
 =?utf-8?B?djVLLzhJTlpDMWdmMlZMSVcrU2NoUVhPMWU2WUQ5dGE5eVJ4UFBTaHRPS1B3?=
 =?utf-8?B?OWh0TE8wM3hWaTVGdXFMWWRnM0lxS3QzRVNCNG1RVnlmL2R1TWo2bjVWWDc2?=
 =?utf-8?B?ZXNFY1NyMVNQZmtaTm9RUWpTN282QnpPL0VrTkVzTlBuWloxbHdkcW1VNlMz?=
 =?utf-8?B?Y0p2QjBSa2pUaUx4WHJtb0NMclhwNU5PVXpkaGk2MmhycExDYXJZY2JxbStN?=
 =?utf-8?B?K3lIMWUxQ29BcWp4WkhaOHZpcXJycmVya0JzUUlldGtqQWJkRDd5Ly9BRUJK?=
 =?utf-8?B?Zjl3VGsreXNzcHVvZmJvZlFqczdwMkNZT3NVY25BRkE3ajhGeTlyTU5HcXJT?=
 =?utf-8?B?cEEwMEZmQVIvNmgvSzEyOXpML21OVTFtRzlHektUZkxRK0IvK2JFTUlCdWh6?=
 =?utf-8?B?R3FDRmc3MGZiMXZMaFBvVExjYm95RXdVYWJjSXdNS2dzNFlEcS9mK1FrVXhE?=
 =?utf-8?B?aEp6ZjJqcjZrVU9kTWlIeXJRYTZ1ZnE0WXBhOStncGV2RllKUzh3bklpWnRa?=
 =?utf-8?B?MnZxYXJLalduRDZtVHhCOFRtRVpYNzYwVEIvSWNEcXh2VkxWOUh5aTk5TS9h?=
 =?utf-8?B?Yk4vd0VVeWVyaXhLTUMxbzlic1FCZEdlWFR4V2k5bWVpblZkTGVxZEdRWk42?=
 =?utf-8?B?QlJKVEpFYzVsSDlrOHlId0huZmZKellnRk45QWJDa1F2bVpuVGlMV2pYeVRG?=
 =?utf-8?B?dCs5d2RkZm1US0RiQUJJVlRHYUxwaTM0ZThRcFlFVzgrd0duZURuQmdkY0RX?=
 =?utf-8?B?ZUFZK0JpekE4RytkVjV6NGo3TWRJbDBSbFBLTktpTDlsbThZNCt1RUhUbnRr?=
 =?utf-8?B?V2xHRjZMSmVQVnJIcVUzWlNDNDRZZWNVbU1rQnA5Wno0cHphQXJnMFZWZjJ6?=
 =?utf-8?B?bks3YUdwdG1BUGhOVU1za0VobHFZaDNLSDdFSm9YVTJndjNCSXY4VC9vSTUw?=
 =?utf-8?B?QUVHU1ZDR1hxRW9WeXFzYmEybVNxSDdHREVCN1VXODRWcDB6WElPVVFzaklo?=
 =?utf-8?B?SjhmSzAxR1RNZCtERTlHckliZFFXWnNoVWlodUpISktYSXFXMExoanJXRitL?=
 =?utf-8?B?ZHRQU0tOMG83U3JxODNnajJzdjJ0TW01aGwyMlg5NGRpcHk0Rm1wUmc5QnIr?=
 =?utf-8?B?YUNoei9nZGF3dTd6YkY4QnpmNnk0UW93YmZ4SGdLUVh3OFcwQ05Dd2g1STRL?=
 =?utf-8?B?UnhRaUMrejFEMy9RV2NiSDloT1BCT1hrZXJIcEVUMHJrKzdrZVp1OW1IeHF5?=
 =?utf-8?B?YVp0MStxclFuN1ZVa1k0N2lNM2tiK3ZCT1laTWRJSUtqdjRCQnVxSjUwYkIw?=
 =?utf-8?B?M1VJREJWSC84SFJueGJkNmNRYk5DcEl3djdlY3BJMTRWbW9OS2xwOFQ1Zk05?=
 =?utf-8?Q?Fi6QP/GvLtgPSl/un6YlD8c4p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b3c391-a828-4821-5ee0-08dcabf7c013
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 15:46:14.8636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bnee3CB35MGR7ulv/boQFU2Fg8GQeJjN5uD6XW0O/Udi43VoQ1aE3/FdVYWY7qx7WizSEHXgoKvExDre1Ls/qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8599

Extend the address status bit to 4 and introduce the I3C_ADDR_SLOT_EXT_INIT
macro to indicate that a device prefers a specific address. This is
generally set by the 'assigned-address' in the device tree source (dts)
file.

When an i3c device is removed from the bus, the old address status is set
to FREE, allowing other devices to use the address during hotjoin. The
I3C_ADDR_SLOT_EXT_INIT status indicates that an address is preferred by
some devices. The function i3c_bus_get_free_addr() will first attempt to
use unassigned addresses before searching for assigned addresses of devices
that have been removed from the bus, trying to best match the
'assigned-address'.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master.c       | 43 ++++++++++++++++++++++++++++++++++---------
 include/linux/i3c/master.h |  6 +++++-
 2 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 85c737554c940..4281f673e08d8 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -345,7 +345,7 @@ const struct bus_type i3c_bus_type = {
 EXPORT_SYMBOL_GPL(i3c_bus_type);
 
 static enum i3c_addr_slot_status
-i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
+i3c_bus_get_addr_slot_status_ext(struct i3c_bus *bus, u16 addr)
 {
 	unsigned long status;
 	int bitpos = addr * I3C_ADDR_SLOT_BITS;
@@ -356,11 +356,17 @@ i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 	status = bus->addrslots[bitpos / BITS_PER_LONG];
 	status >>= bitpos % BITS_PER_LONG;
 
-	return status & I3C_ADDR_SLOT_STATUS_MASK;
+	return status & I3C_ADDR_SLOT_EXT_STATUS_MASK;
 }
 
-static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
-					 enum i3c_addr_slot_status status)
+static enum i3c_addr_slot_status
+i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
+{
+	return i3c_bus_get_addr_slot_status_ext(bus, addr) & I3C_ADDR_SLOT_STATUS_MASK;
+}
+
+static void i3c_bus_set_addr_slot_status_mask(struct i3c_bus *bus, u16 addr,
+					      enum i3c_addr_slot_status status, int mask)
 {
 	int bitpos = addr * I3C_ADDR_SLOT_BITS;
 	unsigned long *ptr;
@@ -369,11 +375,22 @@ static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
 		return;
 
 	ptr = bus->addrslots + (bitpos / BITS_PER_LONG);
-	*ptr &= ~((unsigned long)I3C_ADDR_SLOT_STATUS_MASK <<
-						(bitpos % BITS_PER_LONG));
+	*ptr &= ~((unsigned long)mask << (bitpos % BITS_PER_LONG));
 	*ptr |= (unsigned long)status << (bitpos % BITS_PER_LONG);
 }
 
+static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
+					 enum i3c_addr_slot_status status)
+{
+	i3c_bus_set_addr_slot_status_mask(bus, addr, status, I3C_ADDR_SLOT_STATUS_MASK);
+}
+
+static void i3c_bus_set_addr_slot_status_ext(struct i3c_bus *bus, u16 addr,
+					     enum i3c_addr_slot_status status)
+{
+	i3c_bus_set_addr_slot_status_mask(bus, addr, status, I3C_ADDR_SLOT_EXT_STATUS_MASK);
+}
+
 static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
 {
 	enum i3c_addr_slot_status status;
@@ -388,6 +405,14 @@ static int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr)
 	enum i3c_addr_slot_status status;
 	u8 addr;
 
+	/* try find an address, which have not pre-allocated by assigned-address */
+	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
+		status = i3c_bus_get_addr_slot_status_ext(bus, addr);
+		if (status == I3C_ADDR_SLOT_FREE)
+			return addr;
+	}
+
+	/* use pre-allocoated by assigned-address because such device was removed at bus*/
 	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
 		status = i3c_bus_get_addr_slot_status(bus, addr);
 		if (status == I3C_ADDR_SLOT_FREE)
@@ -1906,9 +1931,9 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 			goto err_rstdaa;
 		}
 
-		i3c_bus_set_addr_slot_status(&master->bus,
-					     i3cboardinfo->init_dyn_addr,
-					     I3C_ADDR_SLOT_I3C_DEV);
+		i3c_bus_set_addr_slot_status_ext(&master->bus,
+						 i3cboardinfo->init_dyn_addr,
+						 I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_INIT);
 
 		/*
 		 * Only try to create/attach devices that have a static
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 4601b6957f799..c923b76bbc321 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -284,6 +284,8 @@ enum i3c_bus_mode {
  * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
  * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
  * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
+ * @I3C_ADDR_SLOT_EXT_INIT: the bit mask display of addresses is preferred by some devices,
+ *			    such as the "assigned-address" in device tree source (dts).
  *
  * On an I3C bus, addresses are assigned dynamically, and we need to know which
  * addresses are free to use and which ones are already assigned.
@@ -297,9 +299,11 @@ enum i3c_addr_slot_status {
 	I3C_ADDR_SLOT_I2C_DEV,
 	I3C_ADDR_SLOT_I3C_DEV,
 	I3C_ADDR_SLOT_STATUS_MASK = 3,
+	I3C_ADDR_SLOT_EXT_STATUS_MASK = 7,
+	I3C_ADDR_SLOT_EXT_INIT = BIT(2),
 };
 
-#define I3C_ADDR_SLOT_BITS 2
+#define I3C_ADDR_SLOT_BITS 4
 
 /**
  * struct i3c_bus - I3C bus object

-- 
2.34.1


