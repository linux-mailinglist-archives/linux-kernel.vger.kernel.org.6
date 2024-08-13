Return-Path: <linux-kernel+bounces-284094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFF294FCD8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93DAAB22174
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ED147F53;
	Tue, 13 Aug 2024 04:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kb9WnyIR"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2050.outbound.protection.outlook.com [40.107.249.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917F0446AC;
	Tue, 13 Aug 2024 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523739; cv=fail; b=J0CLi1OF/OqVnkxpspNjI4zzKQ2vAP3IS/cqHvHRy2+2Mn1F3//WzRBfHzD1c7ItUJd7kTonJVNeFQ0CAmKn249aPUYJ+IpXa/Hvhc3pJpDN2RUOsMUW54U7b576yk3wZ3/qnqC3cHOvwujvCTVyITHb+PLH/Aw8uhlZamz4slU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523739; c=relaxed/simple;
	bh=2wSd2JTNeNCvn5Zxn3x7FFJIOhm37AY47lYbNx4m3ws=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bDgjVzZXinAMaf5GTGg5328MEai+9FDLCeGvif4ULhb2dNHNsekAntl2C+TSCp0dcY/9MrRCzHLE9TQzQWFj2GfdG8WphUFqold+c6X4ejRFRfou3Ft5jePd4u//HfeCsBYuYHtuhgHh8Jd953wVB0lq6siCn7NbEkkm6vuBIOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kb9WnyIR; arc=fail smtp.client-ip=40.107.249.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tE9H8taM/x9JlI4BXpkp7k0+hqOuVAAURCRSaE9D71ljUwc11xDMlFlnuFVLPUbcTS00kq4b2lEciDPXLqNllrwb/Xb3KLLTMiILcIF6zLoQQqfKIVZHgz7UX+FHStyWBvdGsDZsgB2mhBstCJ1rxFMDboVAuz58hip/dvlo+p88sxuAzVzqUREpfmnby5cTshRQSxVswHnXT1Rm8heZha32CuuKxd5V0061Mswll1U4jdW+3BFzjubEIGTcrYKw7AOcNGBuw1QISfXMwGvMd3wmlpH/oHSlc7uDLgoh2u/pELkSSEJ/qhZpJpYvT/A//bw7Ky6WSjjmQHuEa7tkHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zE8qjIRxPRLoBHb6pDA0JZmSWgFkW4fFb98ziakOWIs=;
 b=PtD6ajWvNvWsDzLsT6O1K7V1pEjJ8Jacogr287THkuMpa7i2wa8CnIqtY8jnGiRBDp4ScMEf20x6zynDGkh9Xb4mWzXA9V2c1lnywRHVpUkrXkiEAIKvlRYLh8Q56ZfOH1Ohh+6KFw1EScNtXKANOG2c3FONghtDxWwEv3rElkTgjuWiH7czV/PL48NnzObDYVWrP0g6+4qeppB26QUGHE+9QfpihoyHAiEsfH6CC5u65VIqP7m2C/p1QQYPW624PPwCjXpCrws5S/r1Tzr+EE/oPXF7twfagez6yiwDmre4RMoB1rNWuDU4VQUa80xQ8kAKDCdAvmQ2O6ULdcWOHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zE8qjIRxPRLoBHb6pDA0JZmSWgFkW4fFb98ziakOWIs=;
 b=Kb9WnyIRXJvzfai3qfmG1jsMLDsordl37a8mEJKLsNIk2cNjo9OJlwQ9wnMkJO7rpzxqtxjHJFYKlAb2QvdqymCd3wNaepmAfyBobqMLm6w1fofoLHITO2MGVd73mzWEc5hm4rBJ3dVOficCP+CEK4bXGIumaIcSBEwR8V5aX+jl43JpL9lM6XJi0MiR0kwrmzUFAdrE4AyqNrXZufpe14Pp+6otF0/skb30RWx99LKaz68h79fCU9UFvhijw7Y/Uz1ptgZQa8FiKJIZBdbWzDt1ECJ+btoTjOuny9pfT2tXCBqsuAO6KMapQwTuhXOanphJAhLFmqvzQtz655Nipg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 04:35:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 04:35:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 00:35:02 -0400
Subject: [PATCH 07/17] arm64: dts: fsl-ls1012a-frdm: move clock-sc16is7xx
 under root node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-imx_warning-v1-7-3494426aea09@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723523705; l=1299;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=2wSd2JTNeNCvn5Zxn3x7FFJIOhm37AY47lYbNx4m3ws=;
 b=+07rUcLNskeUyGRYIMWRD0sZbqt6xxmPZyQW9rJLBUdUuuTLRsgUCbxET/02J+rFy7q9DQhrF
 E1orOJa+fgQCz9OacibYLeWcgbYKFgV5/wnBqGdQ6sAdtcLv+YeNyWI
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
X-MS-Office365-Filtering-Correlation-Id: 45b93dc0-9597-4f38-e869-08dcbb515f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVdhT2FmSnVwVnNyTnV0SWVjZFJjTlp0bFVSU2R5eUd1eVBlUUpESmFSSXQ0?=
 =?utf-8?B?TnBqSk1jSmN1RVB0TTlKOUtEdVlqVWN1ZkZ0UGZkQkY2c3JtVUFLbElzckZm?=
 =?utf-8?B?dTVVeEt6cUFnOGx2QnJVN25jV05JQXNNQklKcGFqSmFHODF1WlBqbTMwSURL?=
 =?utf-8?B?WU5JU1FFb3dQL05QOHhxTkhGR1BseDk0OXhpck1TaEJpOUIyWk84YmVpd3hW?=
 =?utf-8?B?N0JZL3RacCtKUGZ2QWhNWTNmZ2FWYmRFY3YxdnZsQzc5QlVBazZjN3ZsdHNr?=
 =?utf-8?B?U3I5azdnYU5wVTF2cjhRZ0F3aTdCN2Q2VkdNaklJN1FhQjNxYVZZWUQwZml1?=
 =?utf-8?B?UWhocUxMOW9Kb2tBV05JY1lCZ3gwbUFLYXZ4YXhWa2h5QmpMa2ErSXpXUmZX?=
 =?utf-8?B?VkJxK2N0dXlweVAydmFxdVdHNXpDWkd4S0JtaFZkanYvM3R5eGFHNWs5OVRt?=
 =?utf-8?B?MnIwc2ZNeFNydlJJd01JajB4VXUxZ0lISmpqRlkyWDZFWnppVjkwOHhNajlH?=
 =?utf-8?B?WC9JZUtmZWlqZkdjZWgxR0NGcVBJdUo1MXpnNzVzQXlXYnI4eVMzVmZCengv?=
 =?utf-8?B?ckN4aGpoZ0JmSW5zN081L00xbmtlV01MTGlCeXZ2cjMrU2o2OTFkYldVQjBW?=
 =?utf-8?B?dVlkTU1hSjA2NkQ5Z1VaYndjR1cvL3p4TmFKeWNFUUdKeTFYK09JUi9Ubzg0?=
 =?utf-8?B?bmpZM3g2RFl3QytHUEpGeU51bjlDdVo0QmtzdEcrSUZIbVdHQURJYlliNzRm?=
 =?utf-8?B?bm96QVVLSGhNaE13aWVOK3RVdVZrRXd0d1hJWHFwdTJmMG03b1BOREw0U0Jw?=
 =?utf-8?B?UWMrOFA4Zk5vaFJPUHFsMmpHWjZ2d2tkekhpbWdsckYxOXo3amFjTlhJa0VB?=
 =?utf-8?B?dGRZbHRtVTVFVzJKa1lTSE1vcVgxa0d3Z0FlU3p4WDhPWmhJV2NJTW5ubnRz?=
 =?utf-8?B?ejFDWjV4WnpoUnhaUHFIazdVZ3ZGeW9ZcnI0QjFYcHN4UXlOcXY5OXZycTJt?=
 =?utf-8?B?UXlURnRLSVVqbHRqTzYydVM3NnNyM1c2YzVha1pTbU5MSjdwOTVhL29TalNW?=
 =?utf-8?B?aE9vNzcwRXd0OEIzbHBUZ2ZvY0tzVVRtZ2ZvdkxvT1lQdnc0WlVyUVk5NXk4?=
 =?utf-8?B?b0gycXNRMGZoTXlxajBuZFpwWGlQZlNoVmRPSlp2VUZIUDJ1N3RVOWxmcjRl?=
 =?utf-8?B?eXlGc0tqSGVYOWJ4cmNETnFIRnZETjUyTDM3U0h4QVVuVnArVW5RZldlT0VO?=
 =?utf-8?B?R21USUZVdVdnZDkxemczaS9UTGVualdPaVpuTDBBalkzY1BFditTZkRrWWs4?=
 =?utf-8?B?ZkF2a1VGd0xvNkV5VGV2UTlyQS9weXlTUlNIbXNEZEt6YnllV3M0RmVDM0VQ?=
 =?utf-8?B?cjJrVThSeTNocXhFS05UWGpKcTU3SEh5OGpVb0IrWlpNUVZZUmtiUE5FZEM3?=
 =?utf-8?B?a3JrZlhra1FMckpQTlphUERLUjcxY09uOUFNclJGZmUzMk5RNkYwSS9wQzF6?=
 =?utf-8?B?cXpHVE9NdlhEa0cvOUV6cStKZk8xZlJ4T0pMMjNENlZjMVBtUS9mUjZyZThK?=
 =?utf-8?B?R1BsY2V6Z3FXY293eUM1UFJCektBN09FZ3MyTXY1OVZtN3c2WEY0YmNCUjhq?=
 =?utf-8?B?bk1JWmpjTExYcVFaMXo3Rm9GVERiYXVkS1F5NEZ3WTFKUjNTM2YxeDZzRnE2?=
 =?utf-8?B?eGE1b3U5TEZSZlBYWEVKWHV1bXpmNDlNdDgxZ1RLQzc0UG1ESkRNSEhSRC9Y?=
 =?utf-8?B?Ni82bFg1cklCdnlFWVdFVDhjOUE0RWlQY0pVTklRczhtMFN2WEY5UFBPYUR5?=
 =?utf-8?B?bVg5eUN5aVRIbFhmb3NoQ0Uyb0dWZjZYRlVsYlZCY2xmVEg3dG1CaTJ5U3BZ?=
 =?utf-8?B?b25id2Jodk5FUnpzTmFMUWxjQ2lXTnliZ2p1eUE5aWxKZ1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEdvNndUQ2NpU0lWYy9DOG1XeHMxYVQ5Z1o4MnNiWUFKOHpESTR5UmdJeU5E?=
 =?utf-8?B?QWhIUE1jV1Q2R0NzcWp2N25ZS2ZRTVJIWUJ0bzhQUUkyeDFKSHJrUGo5ajJE?=
 =?utf-8?B?ZzRJYUVwS3pJS2tFMjZPOGlDZWo0VmE5c3VvWk9xbThJOHhxbGxkeFFMYmo3?=
 =?utf-8?B?SXd4Snh4V2pBRGtxK0VCNEd2dDFxU1JWejg4Mml5b0ZLRHZadWVYUG1YalFN?=
 =?utf-8?B?Mnc1MmxnTUt4TFNkRTIyVUZsUjNyck9rL1ZXU2lMS3N4RU5BazVvcndHVzJS?=
 =?utf-8?B?K1hPQUJrYzU1REFPWEpzRWRSNGNjM3JRaGlIZG9VSE9lMHpDVXpqaDhNNVFq?=
 =?utf-8?B?bXJ1REJoOWVlUk51eUY4S0RvazRRODlqZ1FBbnp1YXZzMUJyZmtvRTAzQkV2?=
 =?utf-8?B?ZUszMEFXTVdYenFwRi80SStRMG4wb1E3SkJYcjVPWC9NcmFYRXhxSHgxS01G?=
 =?utf-8?B?QS80RW1ycURPVmxZUUVRMWkyYlhHR2h2SDNGMDdBaVJyajFuMHUxMTM3UU16?=
 =?utf-8?B?aEo5YWxzYTZTc1JQUnhOa3lCZWxsbEVzTzZzancyZ3hObVEzeGpXem1VUUtv?=
 =?utf-8?B?N1UwUENFNWp1b3o0WFFpaGd4bzViWE4xSU1LWjdkTXlHczhPZHNYT3pmOEE4?=
 =?utf-8?B?UXV3Q2poMFlQUUs1R0NZRUlDaUlGcDlmamN3SURudVRyb3lmeXNVTFVvcUc3?=
 =?utf-8?B?QU1nSURjd3pOak9Sc240YU5qejZ3cGFsQityY1BIRXJ4REJpY0Z1cGYyZlFz?=
 =?utf-8?B?MDJHbTFTak9OaDJhUVVhMFRCYXQ1alZTZXB1Y0Qrd3FIL3FCS3NYdVZQeHlW?=
 =?utf-8?B?U21WNERxZzZzTmJxejlpYVdCT2EzQ2w5TFdDckdTaFFVQXdLc0NDcFhBVTFO?=
 =?utf-8?B?Wm4venBPaitWSlVNT2t4b2NQZG5qcTBmTjYzTVd0cXNTWk9lQTJJQ1ZpS3Yz?=
 =?utf-8?B?KzR1SWVVMExTV3pCTE8yZ0o2WjZmZk1UaTgvdHg0VXUrQ2hrK2JuY3FOdWtT?=
 =?utf-8?B?S1Z0Y0MzeDdOSDV4Q0lQSGlPdFVBWnBJK3cveTdVdW9UNFQxMUhHNSswOWZr?=
 =?utf-8?B?a2hqcFpEbFNjVHY4eFI5VmdVa2kyZTl1aktmcXZIT3pKaGl3UWFCek1zVW15?=
 =?utf-8?B?RzVKRmxXcWwvVWVYMktwdDA0djl5U1QxTms0cGtUM2NGMlFaYUxvWnZlTUlr?=
 =?utf-8?B?SCtHb3pIMEtreGF2bWF0M0V6dndObldsTTlwcHo1bXpiQ3NlRHdsS3h3UGVa?=
 =?utf-8?B?ZUpOeldjOHp4bUl5VkVKL3lOVXhVUm81STR0TjdQc3lNdnQ2cDhhbjF0SVJh?=
 =?utf-8?B?U2RWWm5rQlpZZjdFR3JvZ2dXbUJnT3NpNmg3enBxS1Q0cVVpS3Z3T0syaHZL?=
 =?utf-8?B?TFgxc2huWnMrUnhXem55NVdIUnhFUEQ4bnpJSnNHbmdNV3Fvbm5rcUM2MDVI?=
 =?utf-8?B?TWRSY1hhOG9Oay9zY0QvS21Xcmg3eit1YzJobkJwM3R1bXRQelBPNTlFSzZI?=
 =?utf-8?B?a2lIQW1CUyt4T3RZZ2thekJJYmlSZ2ZvMHpZYUIvTDNSVWtlS0YzL3FJbFpM?=
 =?utf-8?B?TnpQVU9jL3YwbFNiTDliSzNndndWQXFoaDc1d3A4eHRQdXd0SnZZZElnamVw?=
 =?utf-8?B?Q2FQTTJrK0ZSM3FYVkxjVXVDbEZQdlZCUEtaTkNTNmxlZGVSY01IUEw3QlE4?=
 =?utf-8?B?b0laYzg3aXUrVDFPM3ZGZ3RkV2VwTUx0bDRSeEwrVGd2YnZnUDc3dnJMcnBn?=
 =?utf-8?B?ejlFelNSQmo4U3V3OUgydUEwa1VJKzh5bDduZjhoWGRlWlRCMm5TdG9Wdldw?=
 =?utf-8?B?ZTlsR1E4UUVIdXJPeUludlA2YjRLRnMzb2YvTm1pRi9GSEltdlBqVXFNdGNZ?=
 =?utf-8?B?dVFtTDEvb2VUWnhra0tZM2p6eUVMRHFyaVRrNEJlWFNYZ200dVE4UlY2dVpI?=
 =?utf-8?B?R3A1UGtXR0Zjc05kOHBJYUJpR1JMbW43U05oNnZyWE1Bdm1FYlRCWlVsaUdI?=
 =?utf-8?B?bG1hZ3N4cXV2bk9qUk5OVkV2Q1RyRGZpYXk3S3VTS3l1SUVtbDRoUWd6L0c3?=
 =?utf-8?B?SkZ2aHlJTVZNTnN2NkV3Q0hVdVdCUllJT3dMRjk3TkZqTWNuc1RSdkZCWTNj?=
 =?utf-8?Q?mtMEO457fP5562jh0Kt4QMHKU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b93dc0-9597-4f38-e869-08dcbb515f9c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 04:35:35.1413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXKcwRtQ2FP0tVFcI0XcJ8hYoQ+jrxDtOhOqrfX+3JL43OyeTTDfJlLJTLSgmKSxw9hll5ZYxcmfX4fAxJlf0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

Move fixed clock "clock-sc16is7x" from dspi to root node to fix below
warning:
arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb:
    serial@0: Unevaluated properties are not allowed ('clock-sc16is7xx' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
index 2517528f684fe..75081ce3e9a6f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
@@ -20,6 +20,12 @@ sys_mclk: clock-mclk {
 		clock-frequency = <25000000>;
 	};
 
+	sc16is7xx_clk: clock-sc16is7xx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
+
 	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
 		regulator-name = "1P8V";
@@ -69,12 +75,6 @@ serial@0 {
 		clocks = <&sc16is7xx_clk>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
-
-		sc16is7xx_clk: clock-sc16is7xx {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <24000000>;
-		};
 	};
 };
 

-- 
2.34.1


