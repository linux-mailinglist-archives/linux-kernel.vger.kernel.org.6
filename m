Return-Path: <linux-kernel+bounces-201642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683ED8FC12D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8E528542C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06573D529;
	Wed,  5 Jun 2024 01:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fJ0e/DL+"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2082.outbound.protection.outlook.com [40.107.103.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F14C133;
	Wed,  5 Jun 2024 01:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717550043; cv=fail; b=ROLmMW5AVXCduxs/IMJZDOWqHXkSgAvDDTQdCb0UNoQeDnMWpWm393tRZ8+MLo1ZuvibwvRtECpXiHFbx22uwj2b53u40ws7n1GV0g+7mqfptbhK1KlRcE7rRCtphvKOXduDzuCLySbja1WqMhQu5ywKJ+FSiVw4Cz0cUSae+3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717550043; c=relaxed/simple;
	bh=bx28az3ePOPU0VUh94Z4aS0tfni01t3N6UobyD8VmG8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bJx7cN1yhL+EdD2XRrnN5PFEu9bW/3mukOgw1hkxuA8B8jpPnbr4e7kdl2J/Kb+dgcrR0aNd/L0QcI1r2aUHrOuetso6whqcE2VZR49rXyAfMEO5jj8JN1uKgkde05vZA0a2hfY4LqUGgMyVMKYo6Z1RbPSV/uU5zGzNxzQrbbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fJ0e/DL+; arc=fail smtp.client-ip=40.107.103.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TipIp10cye5sj0hNu4IeFeVYM8JPAZfKfVNbzk0SxEeRbpA/C9MgaddwwFUTcn27+xNhNkqbgOZaKIVQqD8qYQAayke0YGJrt/EBHUHUrYuMhYifjFMUbFTcHEXImytk9+awiEaDjwvb1D8laGjKarVpsIVjOL+AOLeFPQ4am+5MMmatqWuQpI5HmdAAd78QgcGPSR7DkEZb0CqABYkflfS0URR4xM9CphwA/8xIhwGrHYwpBraGHXY6Qw5gXhDOFEtB1EU4ar7lXbGKlpzu7ph7ESb2LgUgjxJDYAkeTaF3J/UIyNLuB7UbE0lHmAXsUDEtCif75qFNn941zZOrow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1cuRznwBBCFztAAmtEmfFPa3B9gNpa9zLWfjFslTxw=;
 b=igYAmZfxg8pXMIG1JYNEv8nHv96NI0hqxVuf2Pw4niNoNWnzt8TzTj3O0l9OGEJvYtvENshDkDj9OJDx2d/nkk1j5wiRc4+9N4e29rcCP7Jb7bn7nBbkByCMo4OZ46gTxE1+F1jC9HirlWuFyp2FwCqApZjOh3ALnhXIXQ21vY0NJRjUbhBppW6+qteU833QqiR30AJEDlXdWnpA4yHh8zvoP2eXjBx7phVsq+DvZ9GSuiGjXLBvVMDhLzdFla4RNtymRfuMJZv37eeXRpgRmEcqF/SzHae5sPLtbQYsGXSWHUqh4BBHMnKyAoVHKBh+E7aZO6rYB0TScyhWRSrpSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1cuRznwBBCFztAAmtEmfFPa3B9gNpa9zLWfjFslTxw=;
 b=fJ0e/DL+QftJx4Gj0qiAFA3rliYyKV+c6HRQpt40gjb1ZGTUqYgk3Pr6uOIXqsrjlOl5hqJFd5G9dzCK9iKpxOsbLajphw3RzIATBzn92t9W4w+x8Vl4OoMYAOO1+v1UfAXXTsTPW1+jdIl+1vAacIjAPvNNW+AuyPetx7Ik9Nw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9668.eurprd04.prod.outlook.com (2603:10a6:102:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Wed, 5 Jun
 2024 01:13:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 01:13:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 05 Jun 2024 09:22:50 +0800
Subject: [PATCH v6 3/3] arm64: dts: freescale: add i.MX95 19x19 EVK minimal
 board dts
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-imx95-dts-v3-v6-3-2ce275ed0e80@nxp.com>
References: <20240605-imx95-dts-v3-v6-0-2ce275ed0e80@nxp.com>
In-Reply-To: <20240605-imx95-dts-v3-v6-0-2ce275ed0e80@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717550578; l=6852;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=UCjvqFW5Qo13fFnueDa71qcBnQ8Gxyqod4aW0CarYVI=;
 b=HLVxSDzNyHSZTC2CkH4LbiLkAylNZPK8NJg2JCjhZMdtFVh2pO9PDLKSYalAu+u97EqH0he2k
 oZmY1TV9H+gCD2zdSQzuWHNIkBrERTnuUYBY1k4NwuAEYU121oY8RNZ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5bd2bc-feb2-4540-97dc-08dc84fcc565
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3ZRZExLYy9SSithVCtDR0VWK0FkQUd1WngwVm5rSnpackhwRkdIU1Mxa1BU?=
 =?utf-8?B?L0VvTzUwSDFqTk00NlM1anhqeDVnMW5CN0d1VjBSTjNubS9naVk2WVpYbURi?=
 =?utf-8?B?M1IzM095c0FjNnFTK2pNMm5ReW9WSmV0aFE2RjRtaGQyN2UzbU5kTklkQ0Vt?=
 =?utf-8?B?WHpYb0ZmQVRPWUZMS3NpWmNpMTNqZlFIQXB3UkRxb005dkxYYW9vZkhxaHpH?=
 =?utf-8?B?UXVlaEhGcVJISkp4c2xBS0FzeUEzVnMrbzBBVzMyNnRjQ3hiU0MrdER4YmlW?=
 =?utf-8?B?cWVsR2Z6d0h3VEp5Ulg4R2I0VEdUejI5OGZBbDdnUXBwWHBvb3pvc24wcVNx?=
 =?utf-8?B?T292SkdDKzJTaWVMNWk0U1g1bDhSbjBFUFM4MnB5a0ZWM09Vc0dxc2FJSnF5?=
 =?utf-8?B?U3JkMTBlQlppc2lPV3hibjdYUjN0eUF5U0V0RjRsNUZ3ZXFOUEdneCswa0NP?=
 =?utf-8?B?a3pCN1M4Wm5lQWJQZUtIV000cUNuV0tST0RLL1BWTVh1cm10cjRIN0lWaTRF?=
 =?utf-8?B?TDFkMTNrMGdFdHhqcVRqTXN4Nzg1QWVOcFhMNG1wcFJjNHZaWGZJSW5Ddmlw?=
 =?utf-8?B?UmVJZHl5VmpCZHJMS2xjc2ZocVlCRFg3c2hTM0lld1dIaHc2M21lRGN4dDQ5?=
 =?utf-8?B?SWVTRkhRckdva3k5aGRuTUdhU0JENVM5dEVLVmpYUDlRWUYzNW1kVmR6ZTh1?=
 =?utf-8?B?aVpaL0VRQm5DOC92aWJwRFdraUVrdTlSbnNXR0dpbm51RFpmT0tya2hCV2NW?=
 =?utf-8?B?OGJ3MFlod2kwTW9HaTZ4NVhOdjRnK21tcjRrWHppTmhRc2Y0NThBNW04QUww?=
 =?utf-8?B?R3lnTWI5bHR3L1ZhK0lWdi9wMWlNQmJwWDV2MmZZSmFxTFA5SFVFRzZGRWVO?=
 =?utf-8?B?VkdEWUNuS0hqV1RiTDc0Ylp3c1FMcHArWURxWU9GaHBGVjltNW9PZlc0c21B?=
 =?utf-8?B?SUlFUGZIMDkzWGZabVkwRm9KNWdhUFYyUmovVTY4clZoMklzcnhQV1JGdkdR?=
 =?utf-8?B?cWVOMmhIbExBQzAwUmd1MW83SG5Jc1hmM1prMDBOdkpTTktlaWpNTEpQQkRJ?=
 =?utf-8?B?amQzRVg0cTJtNlUza3FEQUY2NjN4RytDendqZ3JaVjBrTGtNMFZKclg5K1ZE?=
 =?utf-8?B?clRPN21kSTFXSTdvY0xHK3pIWWdMSnJrZXVUSVo3amxGYzZmVXVEemdaOVd3?=
 =?utf-8?B?VFhTenZLcXlpY2JUSjRxaStINDUrSG5xRjQyNUpLYTNUQ1J5NjdWa1dUb09B?=
 =?utf-8?B?RDg2cTU3RnV4VCs0aUNTc0xlQ3VDcHF6WFUyRmlmRUJod25aT2tTajRNRXg3?=
 =?utf-8?B?Sk5xZWR0KzNCSGxqSWM1eWJETjdHUGJpUUcvQjlvcmxzUG9kZEg0bXdQbmJ6?=
 =?utf-8?B?Mkg1bTQxWEwyNytmNEVURnJhQnduV2Z6L2gwdVAwbXphYVdNdkQ0SS9mTklS?=
 =?utf-8?B?YkJyTW90SXpOOXR2eThkRmwrRURabk40NWJaeTRLWGc4eGVvTmN2UkpLdmRh?=
 =?utf-8?B?c21vSWlnOGpzZk1wd3Jib2RPbmcvRzNNaU1Bb1MyMU5oSi9hOWtsR0JjTWlO?=
 =?utf-8?B?U0tmM0VtNGo4OFFWd0kyUGRYZmM2UjcrYjRKbFlvVUg0eHNFbjdoRDF3S2tm?=
 =?utf-8?B?M0x6dFUwUWhVR0NQbnpIWEc1NE10dUM1U21tdi9mTGFuU2tUcWJVeGJwd1VM?=
 =?utf-8?B?aThkTGova2pLUkJnV1prTEhUMFhZZmg2RmlndW96SXdyMWJQR2RhMk1neG1t?=
 =?utf-8?B?STlNdjlObWZCZFYvWk1RdTNrM0NrbFkzRmlrWUdPY2N0QnlWWVAzOFhnNWph?=
 =?utf-8?B?blpIeUFuV21uVXlOMHVUZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjNyTDhnam13Zm96SVl0Ris1TFd1UWljZkwzTHpBd3ErMDVWdnY2M0FrVTJp?=
 =?utf-8?B?alBFVzFtMTRMV2VpWmhUKzNWNTJ4R29Bc2Z3T1BYR242YktVSm1hWVo1aklV?=
 =?utf-8?B?dkM0bHFSQUhwdGE0cmw4TTVESy9vR2VneWZqcnBuWkRPaUJPaUhQWWQ4c0ts?=
 =?utf-8?B?MHlWUkFsYlloODZONTcraXVpMEUzd2tObzBBakZxQUxmdVJzVXVmV1VqclZh?=
 =?utf-8?B?RHlBODQ2R3ROR1BUdmF3SDRXbzZGaUFaa0Y4eVVwUEkyNUM4eC9hWEU2dy8z?=
 =?utf-8?B?STZKYUo2YktENkNvd0U3WXlrVGw5VWpuK0RvaEJTdUR6UGhmaE9DNnJjcEpu?=
 =?utf-8?B?WlNNOUV3M0M3R2lFOVREVnJqTDJYRnpBSGVJSUFyRUJ2Yy83Q1dwZ2xOajdF?=
 =?utf-8?B?aVN0Q01SbjN0RDhmc2QydG5LNmp2UHViRDYxVjA3Vmh4UEFmQlBqbVVua0ND?=
 =?utf-8?B?VDBrTHNsOW8xcHd1MDR4a091am9JWkYrbDhTZlZaRUxkU3IxUXB6RXk3TnNw?=
 =?utf-8?B?aW9WaDBGYzRwMlZER2xnMjgyQTROZDNlckJLY0dkNHM2OG1zcDVKMHNUZ1Iz?=
 =?utf-8?B?WDhNaVMrczl6RVExMEhjMUFxQW5iSnY0M1hCL05HcVpjVVFSaUF6dDlpVmls?=
 =?utf-8?B?b3BhSHUvYk1PNEo3YlBvbmNnTUNlRHNwRlgxN0hTUC9iZm1JYjN0ZXZVYnNO?=
 =?utf-8?B?Z09PZzl3TFJEdVRXRDVpYmlUTVhzTmhHWjVzSXIzWE5MZDRrYTNDS3EyT2Zr?=
 =?utf-8?B?bTg1ZnVpSkFjTXZXMkpQdGRTMEhrODBheVdOamNIRGdaZlJ5VG9aRExQcTI2?=
 =?utf-8?B?ZHdTS2JES0Z0aC9JU2V1MTdIaUI5akpQbEFtZHQxcjJXWGhETitSOG5HL0I1?=
 =?utf-8?B?QTEvdDRsR3VoS1pFMWp0bHVQalBmSjdnSitNVFpUakY1eDh5QXFRczZKZDlQ?=
 =?utf-8?B?T3JnUWpOSjZSdm1USUl4R3BzdnBVMWtiOUlNUE5xN2E2RlJQMGdEaXpINVo3?=
 =?utf-8?B?aGVKVjRjdzFVd0JTV29TYWY5amdadFRSeWRLcmZUK1lFT3Z2Z05VaGZYQ29L?=
 =?utf-8?B?MVZBaGhkdU1jWHVrMzhOTDVGbXp6MXE5Qjd6S005MHVFcWwvZWhjZnZTOHZZ?=
 =?utf-8?B?c2NhWWNUeDlpdTc3VkpoZTFHNTJ4Y05FTkVITWVHYytUUllwV2JwRmZuZ2xn?=
 =?utf-8?B?K2l1R1prbUNKSUsxQ3prUDNJS1p2UGl1amFwVUFBMHJicFhVb3haNTZHcTMr?=
 =?utf-8?B?U09PYmZzWTdIeE9kSnJnbXl2VVZNejJjR0NwMlVzd2hISGZ3ZmZtUlUyZEVs?=
 =?utf-8?B?RmVKcG1rMUhpMXZnVnJMZGxWaVErU2xucXBTRVZRVnk2bTRYUkJSTEZCcTZF?=
 =?utf-8?B?bWk2WFhuZlREdmdjdGR4RERCWkRySGllL0xLVE1kVzJyclRKV1N0TVoyRkNQ?=
 =?utf-8?B?bWhvaG9KaGNTOHB1SmkzUWZUdjI5QlNtamQ2RlNJQmlZeFpTVVV1dWRpUHVY?=
 =?utf-8?B?eXREZ1F2MUc3Vzg5elp5U3ltSnVvRUh6bVM1V0pUODdnWXRLa2QwekwxOXE3?=
 =?utf-8?B?RXh0ZWtWazB0RkN2N3dnYVpQcVJNNFZEdVo4ZERxZEVlclRLaEtSdmF1RXh1?=
 =?utf-8?B?VzlzNXowSWlPZnBKbW56UG5EMWFVNzA1bVRCRUkyZjE3NHJmUGxxYmNSdzhS?=
 =?utf-8?B?bllIVlNxOXlaYi9JRkg2ekY3Q1p0SjZTb3BPNFpBNjhKSjFpdk5DU0hrbzds?=
 =?utf-8?B?MFpNSW5VNWZDbklrYUp1Ukt0SC85SGdOcERGeVNYU3VDTU5zTEdvRGJQRFZ3?=
 =?utf-8?B?K1BxMGYwMzdBc1J1QXlnNHEwYjBDTnp6U1Bqd2pOWWtkaURPMk9aWmsrVjZV?=
 =?utf-8?B?WlZWK3FWNGlFYVVKd0doVDdueU1Qd3RtaUpoNWhoMHcwbnlhb0h5NFZUbmtt?=
 =?utf-8?B?ckt0YTltbVE0cGtGUGtLZG5PV3NWWkJ1RVQ4eW1ya3ZYZ1JiRWZkOU9XWjJJ?=
 =?utf-8?B?aXBqMnRCcG9CS2Y3NSs5eVA3TTU3b0hlWkF3eUVWem96WExQV2x4K1BqbTBI?=
 =?utf-8?B?M1czaW1xZ2N4dks1azhCUWRkcGZ2emswRGQxWWRzWVlWaVpIS2tNbVNrcmFn?=
 =?utf-8?Q?bAteJAKY2/mymPcSpNLDav8Vn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5bd2bc-feb2-4540-97dc-08dc84fcc565
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 01:13:55.8960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgbVaN2UloJY+N3NB6R60CktjFj1niZ23bcUbqn4+06lx/U7DR9awqbt0eve+EQAd299bwQX85OnnKOFAH0aZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9668

From: Peng Fan <peng.fan@nxp.com>

Add a minimal dts for i.MX95 19x19 EVK board:
 - lpuart1 as console
 - sdhc1/2 as storage

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 200 ++++++++++++++++++++++
 2 files changed, 201 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 1b1e4db02071..c3fef4e4d8dd 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -239,6 +239,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
 
 imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
 imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
new file mode 100644
index 000000000000..2c2f3cfbe11a
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 NXP
+ */
+
+/dts-v1/;
+
+#include "imx95.dtsi"
+
+/ {
+	model = "NXP i.MX95 19X19 board";
+	compatible = "fsl,imx95-19x19-evk", "fsl,imx95";
+
+	aliases {
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		serial0 = &lpuart1;
+	};
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux_cma: linux,cma {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0 0x80000000 0 0x7F000000>;
+			size = <0 0x3c000000>;
+			linux,cma-default;
+			reusable;
+		};
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-name = "VDD_SD2_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <12000>;
+		enable-active-high;
+	};
+};
+
+&lpuart1 {
+	/* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&mu7 {
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	pinctrl-3 = <&pinctrl_usdhc1>;
+	bus-width = <8>;
+	non-removable;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-3 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&wdog3 {
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&scmi_iomuxc {
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX      0x31e
+			IMX95_PAD_UART1_TXD__AONMIX_TOP_LPUART1_TX      0x31e
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			IMX95_PAD_SD1_CLK__USDHC1_CLK			0x158e
+			IMX95_PAD_SD1_CMD__USDHC1_CMD			0x138e
+			IMX95_PAD_SD1_DATA0__USDHC1_DATA0		0x138e
+			IMX95_PAD_SD1_DATA1__USDHC1_DATA1		0x138e
+			IMX95_PAD_SD1_DATA2__USDHC1_DATA2		0x138e
+			IMX95_PAD_SD1_DATA3__USDHC1_DATA3		0x138e
+			IMX95_PAD_SD1_DATA4__USDHC1_DATA4		0x138e
+			IMX95_PAD_SD1_DATA5__USDHC1_DATA5		0x138e
+			IMX95_PAD_SD1_DATA6__USDHC1_DATA6		0x138e
+			IMX95_PAD_SD1_DATA7__USDHC1_DATA7		0x138e
+			IMX95_PAD_SD1_STROBE__USDHC1_STROBE		0x158e
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			IMX95_PAD_SD1_CLK__USDHC1_CLK			0x158e
+			IMX95_PAD_SD1_CMD__USDHC1_CMD			0x138e
+			IMX95_PAD_SD1_DATA0__USDHC1_DATA0		0x138e
+			IMX95_PAD_SD1_DATA1__USDHC1_DATA1		0x138e
+			IMX95_PAD_SD1_DATA2__USDHC1_DATA2		0x138e
+			IMX95_PAD_SD1_DATA3__USDHC1_DATA3		0x138e
+			IMX95_PAD_SD1_DATA4__USDHC1_DATA4		0x138e
+			IMX95_PAD_SD1_DATA5__USDHC1_DATA5		0x138e
+			IMX95_PAD_SD1_DATA6__USDHC1_DATA6		0x138e
+			IMX95_PAD_SD1_DATA7__USDHC1_DATA7		0x138e
+			IMX95_PAD_SD1_STROBE__USDHC1_STROBE		0x158e
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			IMX95_PAD_SD1_CLK__USDHC1_CLK			0x15fe
+			IMX95_PAD_SD1_CMD__USDHC1_CMD			0x13fe
+			IMX95_PAD_SD1_DATA0__USDHC1_DATA0		0x13fe
+			IMX95_PAD_SD1_DATA1__USDHC1_DATA1		0x13fe
+			IMX95_PAD_SD1_DATA2__USDHC1_DATA2		0x13fe
+			IMX95_PAD_SD1_DATA3__USDHC1_DATA3		0x13fe
+			IMX95_PAD_SD1_DATA4__USDHC1_DATA4		0x13fe
+			IMX95_PAD_SD1_DATA5__USDHC1_DATA5		0x13fe
+			IMX95_PAD_SD1_DATA6__USDHC1_DATA6		0x13fe
+			IMX95_PAD_SD1_DATA7__USDHC1_DATA7		0x13fe
+			IMX95_PAD_SD1_STROBE__USDHC1_STROBE		0x15fe
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			IMX95_PAD_SD2_RESET_B__GPIO3_IO_BIT7		0x31e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			IMX95_PAD_SD2_CD_B__GPIO3_IO_BIT0		0x31e
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			IMX95_PAD_SD2_CLK__USDHC2_CLK			0x158e
+			IMX95_PAD_SD2_CMD__USDHC2_CMD			0x138e
+			IMX95_PAD_SD2_DATA0__USDHC2_DATA0		0x138e
+			IMX95_PAD_SD2_DATA1__USDHC2_DATA1		0x138e
+			IMX95_PAD_SD2_DATA2__USDHC2_DATA2		0x138e
+			IMX95_PAD_SD2_DATA3__USDHC2_DATA3		0x138e
+			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT		0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			IMX95_PAD_SD2_CLK__USDHC2_CLK			0x158e
+			IMX95_PAD_SD2_CMD__USDHC2_CMD			0x138e
+			IMX95_PAD_SD2_DATA0__USDHC2_DATA0		0x138e
+			IMX95_PAD_SD2_DATA1__USDHC2_DATA1		0x138e
+			IMX95_PAD_SD2_DATA2__USDHC2_DATA2		0x138e
+			IMX95_PAD_SD2_DATA3__USDHC2_DATA3		0x138e
+			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT		0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			IMX95_PAD_SD2_CLK__USDHC2_CLK			0x15fe
+			IMX95_PAD_SD2_CMD__USDHC2_CMD			0x13fe
+			IMX95_PAD_SD2_DATA0__USDHC2_DATA0		0x13fe
+			IMX95_PAD_SD2_DATA1__USDHC2_DATA1		0x13fe
+			IMX95_PAD_SD2_DATA2__USDHC2_DATA2		0x13fe
+			IMX95_PAD_SD2_DATA3__USDHC2_DATA3		0x13fe
+			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT		0x51e
+		>;
+	};
+};

-- 
2.37.1


