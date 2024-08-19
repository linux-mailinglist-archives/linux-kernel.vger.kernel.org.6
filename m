Return-Path: <linux-kernel+bounces-292447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AE8956F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D921F226C1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EAB175D20;
	Mon, 19 Aug 2024 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xsb5brOP"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013044.outbound.protection.outlook.com [52.101.67.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D116C874
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083339; cv=fail; b=uIYikv/6zOVTAYpb684ef0y8EPLfaSCRi1y/YP9Hsd4g6WlUuOQZkmkcGoYExNyVTkvAnE91H6l+LERi+IiaZXYbERtz6JACjrjgf0Gc2SiI/vD7xAOaL5yzJEs5D35X19odh8TG3QxfA74skCQcc9Qk8hEvv0WRGKCsyqW4jfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083339; c=relaxed/simple;
	bh=/8gjfrLEbeqdvh2UWIsUOXSQLlEPInExNiw2wP5o2A0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FhuVuuEuG56iwTnRHYO7b8oEQiiOdl4B3iPzLxaYkYqIo2QnBWgsLIWXGZ8VI37Wc3Z3zlXhMhY5z6PVjj0MqbZKsXan8LzP7y5FS6bRrIn4paUNFpJx93v3QU6AsTes2rnEjikuoLDjPWJY/CB3DPiaa5730nRP2XkcfmgwjoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xsb5brOP; arc=fail smtp.client-ip=52.101.67.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFoZl59sUWP2TZ6Jw+NZ80oZgghDvfFYcoqZ8CzNOJATzHXxroWyCuZP3YrnidnBUfTuZ5SIx4lkd/XfQMmpnjCw2d2KBRLJ9cVI9zWK9WqIYhhNHSIg7uV3um7H9VMX+0EdfZjad0sBZek4SfvLVrQ799lx5scomay7doK1cII9UohgMHiLtddzXPYMLPkNrdlNJQ+RJZa9mzLRrk71VkEiDvHwJdvxwz3UwAA/O2WlJ8MImmHB9C/YEZluH16QxlI8PzJTufWLB1jVJRaZJKTRPeKcb8D4cnlwEezz3weKAE/HslMaW56t2Mq4OgbM3kcPlUTez65ETDUS17tXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/H5YFp3nwDhvmKVPeBWxGQWI1IbbbTbtrRrxup0oAxQ=;
 b=NOMi56D9MWEoNAJGfQ0tO/l5ejQS+oxQK9wCFOsXRofSYf0geWuVTP55FbMGn/Hat0HSZzy/n6aBC77LcJs8TynquairyRCagGSlTrZfh9jjbrPyO+dIKcuMcxS4Jr5H4KIP5NHrk0Z4qdKdXui7tCl3QVWMJ8+Gru1Fx2RHwkkzGb1hffEYLrUQyXH9r5/4RYw0umJPbt5MzvYnqrQVsBRHqwm6U6JMWTO7XPOqQa93ICmMEAdTpdRLcEyLpIa7QM67fl7ozth+xOH6F6rfRD1j2/o5alutvgvJeMFCuV76iJr9BEGddSS4MQR1YcWNl7iR46j2o1jDXFdD4IPy8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/H5YFp3nwDhvmKVPeBWxGQWI1IbbbTbtrRrxup0oAxQ=;
 b=Xsb5brOPh9GDcXNYBNuEltP1zxFSbDuZQdL8+iooSJZlQYKAycvLRYmI9PXLhisBXFbybABG8IZBnPtCMg1KbCeU09FjAZQf38R0Cqa3NL3N4W521BqlvjWi8TecFMM2uu/PA/g5ehlXV/hobiNus4SoKj6IqoD1bv80xa3EeqpoN7Z6q71E+WZzOQD3eaTQwmUKGUki58XQ2tmEVFtxKNFCZMtT8mq7anC4e0QXXqxC7CiMs5R0JyCMHFSP3h/++z7bg6gby14L9O7JohmXV8SdTF97AisXGAGPg79TQi7nG/F/Z3RpZNp5QNF9kqYs/ry0TeKq6tl/SM2XtwzqdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9659.eurprd04.prod.outlook.com (2603:10a6:10:320::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 16:02:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 16:02:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 19 Aug 2024 12:01:56 -0400
Subject: [PATCH v3 02/11] i3c: master: Replace hard code 2 with macro
 I3C_ADDR_SLOT_BITS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-i3c_fix-v3-2-7d69f7b0a05e@nxp.com>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
In-Reply-To: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724083326; l=1901;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/8gjfrLEbeqdvh2UWIsUOXSQLlEPInExNiw2wP5o2A0=;
 b=rR5dTmllJap2jATJpl9j2kxuFRoEdc/puEV6YC1vOtpHfaNtxtlfP2Yk+Lwbr/BrUE7GgD/ZH
 1+Cq972U160DozBKnW5azrxjvHHUFAyAHKxTWTOmlQP4SUHdb9d9TRN
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:806:20::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: b679f02f-9201-4ba2-c229-08dcc0684a0a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?S09GQ25VK0hMODRCUVZCZE1sRElvUzd1djRjSU9FRG5rT3p0RVBNTWZ0eGs4?=
 =?utf-8?B?dXpWMjlxWTg1ZitBL2JiblFYd0F1T0NDaDFoQ08rWXNTN3UzTytwNE9nZmVo?=
 =?utf-8?B?K1ZGZk1Jd2QvTHFpaDVhNTVINEZxYTkzOTg1Q0RXZDZ0dVBFa0tROU1ubXRL?=
 =?utf-8?B?RzhDY1hhelNwbHNXRXNrbkdWVDN5R3NBWm02L2l0ZWhONmNHeTRDS0ptR3RM?=
 =?utf-8?B?RjYyZkVKR0srUktUMHJzSXB1UVhZUUd4ZzhTOGNMWHIxZU85Tm9yRWs3VGVE?=
 =?utf-8?B?YWhZSTdkZ3R5dW9ub3Y5S09SanZLaTI4WWZ2L0ZNcmtpS25uTUp3dFVUZkFu?=
 =?utf-8?B?ak91UUtXL1YrY3ExWlA2bEI5U1k1MUoxMnhXcjFxbVlGSG9wd0p2eVRuVDBK?=
 =?utf-8?B?M0NSUS9VR09LSndHa3o3VCtoam40dkdtT0EvcVVCTFRpSHRIY2U5RnNWMTV3?=
 =?utf-8?B?aWZ6ZFNKb1B5bVU5dGJ3Uzd1WTV4VFVIa2k3ZUthZzM4WHNQTWMzaTdoYkls?=
 =?utf-8?B?TEJnTDYxK09ZaWgxWkh6YTdqeGtmSmMvZEg0V0dVOUhpZGVnSmRRbmdBWXRW?=
 =?utf-8?B?U1YrOTVJVkRtcnlDbHVsVStHU3U5L0x3WjhqUGkrcHNiVTdEOWtQUGFRSkVn?=
 =?utf-8?B?eTZnbVRzUi9yQ3Vab01qdzRKV1dWcUh6d2dYMWxLS2EraUgwUmh0QnNaeXp1?=
 =?utf-8?B?aXpRdkJ1aW1zQWJ1ZGkzTjhQTEVhMHdieWNncFRtWGd1cGdwTTRWRnVpN0Fr?=
 =?utf-8?B?VkdnSGhpKzdCNTVqbkY4aTF0VnFNT3pkR3FsaFlreWZmVDJkcSs3R3d0V0NN?=
 =?utf-8?B?UlJQcWh2WTNSMGZncDRvMklHc2Y5bUM4c1BNQVQ4RU0vdDFPNUExak5ySXJk?=
 =?utf-8?B?Y0ZSUFBSSmdWVlhrQVUveVFURnlKeHlGd1lxaWJMZUtDUnZwY1g2SldNZW1W?=
 =?utf-8?B?NEc1UHRJUWhVckJtVWxtcWttdHYwek9tVDdMdVBkZmhISFVXRkFUc2E0RXFa?=
 =?utf-8?B?dmYvNnhyaDBaeGM1MFpkR1hCUVd6ZVJOR3ZXVVZFQmo0ZWJZQUl5aktFUnha?=
 =?utf-8?B?QWZkRzdEVytQZEpkTEhYTGQ2ajduM1kwY1A1VE8zSDh4MnBhNDJjeXNKcFVn?=
 =?utf-8?B?TGw3RUViYkNLTklpMG00WFE5a2ZaRjVLS2YyU3VVZjFQSzFRZmtnajdCNDFh?=
 =?utf-8?B?MEprTVdJV1FvbHFoL2tRL1hlQzZ5cXg4RG4rOElJdWFabDdOM1BHQzdhSDN5?=
 =?utf-8?B?ZjlmSHNkbmZBSlNSN0JRTGdONzhucENUdXkyUDdudGJsSGhoN0FPblcvSC9D?=
 =?utf-8?B?UDlXMnpPYzQ3MGpmb0s0cng0T3daeWhKMmY0T1lXSnhIM082RmxobU53ZDB4?=
 =?utf-8?B?SDc5Nkw5L0p3VVRoZFlYWDdCNmhmZXdIaldXNktObHhGbnpoZ0pMNDBDK1hP?=
 =?utf-8?B?dno0VFA0aG55SzRWb3NNbUthcnlDb0hSeUtjd2MxaEEwcWcwK1VYb3k5TXRj?=
 =?utf-8?B?TDZQMUFIOEs4ckJqazNBa3ROcWpEUXZVVzRGVWZPeG1EUjZWb0pnbmxIcXNP?=
 =?utf-8?B?a2xUUlhyVFFKK29iYS9zQ3ZhZ3NHSCtCanBWMm41S2pscXRKTGUvRTZBQU00?=
 =?utf-8?B?MkxSZm1rOVZuVXR6am9mZERwZE9GWXA2cTdheVdJNmxSQ2FkWWFDS3B3dmJp?=
 =?utf-8?B?T2haMmtLWkZ6VmRjQUhuWndLby9yK0p4L0NSRnpLSk04L2E5MUphbjFMRlo5?=
 =?utf-8?B?TS9DQ29Eb3ZLVnozY0tQT1VqcE0ySS82dHkvWmRadFNjWHoxMDZLRk1RY0Vh?=
 =?utf-8?B?akVmd0gxL09DZWFhcWMzN1A4REl1TFFUZWdaVkJxK2dUcG1TR3BuZzllZjNn?=
 =?utf-8?B?MTFSS05zYzZFcmhMTTRGa1JZSzhIK3lKQnBDMndmRFBmK2c9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?N0dqR2hGb1N2aVBsMlVIRTE1UERGVmNEYjcrZk10VDN2SmZQSTByQy9ZZVhn?=
 =?utf-8?B?bjJaYkFOUU1IYm5TOTk4QlQwRktCNkZQVVR5SjRoZVVIbkhCcW1JNS83dEVx?=
 =?utf-8?B?Qkc1LzRaSVZvT2JieGpSR2hvUSt6SERSS3BMS0ZhMUVOTHNXOHFrUVVwQ2hl?=
 =?utf-8?B?bHN6dThKZW9IK2ZudTdRUVd0QmFKSDBRTXVVWWU2QUVnWUg0Ykw5cCttRU9E?=
 =?utf-8?B?WThwVWx3M1UrN0hyTzllZDlJTkdZbEh1ckZhY01PczJhSmN6MkN1RnMxMkxy?=
 =?utf-8?B?SmxWbmorajNWdVY2SU15UlRWaDJRZ2h4YmVzcVo2UDdodFNUY3VkL3pROVNq?=
 =?utf-8?B?T3BIN2ppUVBGMXduQWhSeWtBSmRZeVM1cXlaZlZkRi8yZHExM1RiZlNFWWMw?=
 =?utf-8?B?Nk53bWgzbGtrKzNnbTRsdmdVZkFQdDljWUl3UHRoVjFXZmZRVHJmaU9JM3NN?=
 =?utf-8?B?OXZVTGw2LzlEZGRJcGM5WFN6SUV1SW1qOUkveWRFYmNuRy82WlZBMkc2eCtY?=
 =?utf-8?B?am0xby9OSFoyM3BFdVFwUDloQStDR29MRXNPUkM3TytLbEN4M2ZGdXlWVEJa?=
 =?utf-8?B?NmZWL0lyZVZ4Y2dIazMxR2daUFF2S0tIMnVLM2JOSlA4U3ErOWk5WExtT0J1?=
 =?utf-8?B?WlBDRGRvZm9NRXRpQUs1aDZrMmNFUHM4RURNTEUyR0ZPbmxOYmVvckVQMFlr?=
 =?utf-8?B?eldqdXdpZTF5NEZ0WDdiUnlkS0pLWkFYL1RQdnNSRzFLUkZWWC9aRVprbk5F?=
 =?utf-8?B?UVgzN1VmclFlYWJqaCs0d0dHOUhOZCtGTXpKYytQZysxWmhvb0tmc0xiRzl1?=
 =?utf-8?B?ako2SHlyWUVleW9GbzByWWN4M2NKR29QN0FGOENCUW5TMUlNNk9MVkVmMXRi?=
 =?utf-8?B?QnUvNSs5MVJGdXFUWFE2bzhYVDFsbm9RaDJRVHdpZTZSVjlYUUZ2VklrcWlz?=
 =?utf-8?B?clZSRWVaMzhXWnRsL0lLM2R1R05qRG9Nekl5N3R4NnVtZzF6SEFBajlLOW1U?=
 =?utf-8?B?VXdqMm44L0J6clhQMEFSY0FRdlNjOUIyM0lGSDc3NDZWV28zdEl0bzlmOGdL?=
 =?utf-8?B?aEo0QXR6WHoyQ0plK2ZrMkdwMlkvT1B4Um9ZNXZENGZJYTZBWVRIcE50Vmxy?=
 =?utf-8?B?Wi96NzkvbUVJOWxpYXova0svQmI3cE5YNkVLTTJiVGRseFd1NTI0aVdxbHhi?=
 =?utf-8?B?K1NRdTJoSFBqdlBWZHRrZUJYclJsOUhiL0RCbVZxVkxLZW9BeEdja3F3eXNh?=
 =?utf-8?B?RkdReWZYemZlcDk0MFlEVG1tS3p3dDN2ODJacUJLV2wxbjRYWWZ3WTVjK1BF?=
 =?utf-8?B?TmR5aGJ5N1J4cEFwQjdERC9jNWJkb0c3VWg5Lys2ZUoxeE9KNHM3TmVLbVdD?=
 =?utf-8?B?TVlUV25QdXh0M21nRHZaRyt2OW1oRWZzZUJ4MSsyM1QxVzQ0Tzl1eE1FNWs1?=
 =?utf-8?B?RFN5SWNnV0pZenhxQStnQlpLQW1wZmNKN0pSVzlYT2k2d1ZWMDB0bWVRQ01X?=
 =?utf-8?B?RFIxQzFab0tLWFhKRzNBLzhzbzRTcEFtRjhOWDFHTXZjclVLZjNvblR5cFRO?=
 =?utf-8?B?SHMxbWdjNUF2anB4dVdDbUpSQ2JNWll3OXM5YlIrMzlXa214WHhadXIrNFla?=
 =?utf-8?B?YkREdUx4YmJlT2J1SzBqcWhkR0llbzFxak9OZWk0U0lERWJ5eUxzTzQrZ3pT?=
 =?utf-8?B?N0QrR2hMbklQYmtreUduMnNaMlBQV2FOTllZQy8rYlJraGR5dlFHd2NWOWxn?=
 =?utf-8?B?SjVrT0psbGdrN3dVdXR2QTNiVzcvRVZEZlpqd1pnTndKaEtQTnpUd0Z0RE4x?=
 =?utf-8?B?TExRbEhZSER1Y1VaRzA0YUtFVEsxRWpUL1ZyWUx2U0tCaklzTmRjOEJlbjJn?=
 =?utf-8?B?SXB6L0ZHZFh4Smg5R0o4NGtmUDVtTTlZNEVLdzd0ZXh0UnpBYkdTTW5mV3Jt?=
 =?utf-8?B?WlpUKzlqaDJrdmRYdE8zZUVrRVQ3amZ0S2RaZEpyUlA5Rzl2M2Z5Q2JQOEFN?=
 =?utf-8?B?OEhBRzFsSmx6bnNheUp2d2tLRzN6SWRFRVh0YXd2UGV2QmwyM0VMMXVBZ1RH?=
 =?utf-8?B?UTg4ZnVWaVYxemJMYWdGbURsYkVtMG45Y09KWE56eG5rWlFYR0RpS3grY3E2?=
 =?utf-8?Q?ubDPHri0Cjaiz/5JBb5bQp42D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b679f02f-9201-4ba2-c229-08dcc0684a0a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 16:02:13.2004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/lD746UogE0sqVNQRhizFANGDLYPwdtd+9UmXUeG3hcN6Hd0BTM02MTiFCth7hwgf6o/6UwIZd0vEGfybSDkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9659

Replace the hardcoded value 2, which indicates 2 bits for I3C address
status, with the predefined macro I3C_ADDR_SLOT_BITS.

Improve maintainability and extensibility of the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master.c       | 4 ++--
 include/linux/i3c/master.h | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 852b32178b722..85c737554c940 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -348,7 +348,7 @@ static enum i3c_addr_slot_status
 i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 {
 	unsigned long status;
-	int bitpos = addr * 2;
+	int bitpos = addr * I3C_ADDR_SLOT_BITS;
 
 	if (addr > I2C_MAX_ADDR)
 		return I3C_ADDR_SLOT_RSVD;
@@ -362,7 +362,7 @@ i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
 					 enum i3c_addr_slot_status status)
 {
-	int bitpos = addr * 2;
+	int bitpos = addr * I3C_ADDR_SLOT_BITS;
 	unsigned long *ptr;
 
 	if (addr > I2C_MAX_ADDR)
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 074f632868d98..4601b6957f799 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -299,6 +299,8 @@ enum i3c_addr_slot_status {
 	I3C_ADDR_SLOT_STATUS_MASK = 3,
 };
 
+#define I3C_ADDR_SLOT_BITS 2
+
 /**
  * struct i3c_bus - I3C bus object
  * @cur_master: I3C master currently driving the bus. Since I3C is multi-master
@@ -340,7 +342,7 @@ enum i3c_addr_slot_status {
 struct i3c_bus {
 	struct i3c_dev_desc *cur_master;
 	int id;
-	unsigned long addrslots[((I2C_MAX_ADDR + 1) * 2) / BITS_PER_LONG];
+	unsigned long addrslots[((I2C_MAX_ADDR + 1) * I3C_ADDR_SLOT_BITS) / BITS_PER_LONG];
 	enum i3c_bus_mode mode;
 	struct {
 		unsigned long i3c;

-- 
2.34.1


