Return-Path: <linux-kernel+bounces-248371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E5592DC46
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10592825F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D64158870;
	Wed, 10 Jul 2024 23:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OEGRCNFW"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010051.outbound.protection.outlook.com [52.101.69.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194101527AA;
	Wed, 10 Jul 2024 23:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720652573; cv=fail; b=UK+Q2xjXysW2K6zZbFernSBCQCS/FlpMnemDjjfLt/809eEbEZf2G7MP/cAHDSb6pCroy4yDPf4+qopwk6DzfhMbvdX2b3PhSBOPTPFeFvtu8kPM6S9exkuhXmeeYcFsQzntkjsMu5qo3LRpWN10NJlaU65POK9lMovIrTH74PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720652573; c=relaxed/simple;
	bh=P1y28FrMwhzY+EU28qrhKcw7mczE/TQPAFCv7KbwcGE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HP0ixcgnRGI9iqzdgjsXFDxBWpWZ2OMFv8J3moq+GGV6NXljNtbo+3uz6vz98EsqulL+V4jqJ1VUBuyW76/gzBLqfH/9IyQlqI56R+EtVRd1RYSJSYBZpFWk1r2UIcOhEwM2ehnEMoaPeOGJdZ7bUVU3ZkIbBCGVbspFCxIYRfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OEGRCNFW; arc=fail smtp.client-ip=52.101.69.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRCeuywN++BY2q33hrSNDvfqAleDutZiYfBDlLQSlZ3bZwVJ5nvb6Fj5COnxSLfRdB+pX5FkHyLy8jeQMSh+UFbu7EbOX3rZEhFNk2h2YW1efZ4lStpxqT3CrjoVzU3c1bg3u5BhzqoKtgFkey8Od4cQkRBnxxnDxvq3+kEzq1c/zCo6uhyZT2BtUgbe3R56sATje4LsV9R9bhLyGG9zx8Lvty7b38K5wa3ZTsDJtaB1/Ymsa8CrkkBFBS5Nf/LYZfLOcw3OKIZBldjngv9GTainlUI1M5gChOW0es0GDNZ2TQ7ttSAkM8FnvyanufxOLqOdMuB9sjXhYEpCaZpljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCTO9n6odMfygt46otuWdURYJdub1uDc7jpoPRQ2DJU=;
 b=ioAPzBpoI+hr4u77lqdM0yCO9dn28SQxXG1NCN8dVA1LRQZEZdqIvvpcY4U02J7HWKskVGd3srvw8ioZcOmDvInS5sgev7s9UvE4OeuE6mzscB8kwxHt+UJXYG1dxc9FPaNuI5oMyCs9bQYpWG9bZSOEpZHFel0Us6WRJiNbM3y83dj6oPgdxPXKfCWixz3vG/naQ3lxy3ljkwuNdaelg5s6rpkAUGe3JsWd1A05H3YqX8OXWh0XymEdXHuy8YurXipU9TRJpLNZEfpKUwou/kEi2l95iUe2IyXHULTu1j3OGwigUga54rD8XaZ0Z2vJ2dFHV0Xp7JFwnIcc3Z1vSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCTO9n6odMfygt46otuWdURYJdub1uDc7jpoPRQ2DJU=;
 b=OEGRCNFWRl8OMwwtgpuQW0cq74ovAW5UoVHKMMNKKusw/NVGbGuhZos4SZyIah1Zp34JEVmTqSPgGN+BYI/m/ZQ4ieaEvaLuYY4arLzRFjT3kaFHAfXqFMR2BA2uTuqdJdZaaf0UO5+Oo/bPMuJUl/3mzoU6ZPr21MHdEJqFTCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10751.eurprd04.prod.outlook.com (2603:10a6:150:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 23:02:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 23:02:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 10 Jul 2024 19:02:23 -0400
Subject: [PATCH 2/3] usb: dwc3: of-simple: Add compatible string
 fsl,ls1028a-dwc3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-ls-dwc-v1-2-62f8cbed31d7@nxp.com>
References: <20240710-ls-dwc-v1-0-62f8cbed31d7@nxp.com>
In-Reply-To: <20240710-ls-dwc-v1-0-62f8cbed31d7@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720652559; l=2030;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=P1y28FrMwhzY+EU28qrhKcw7mczE/TQPAFCv7KbwcGE=;
 b=n+8X4ca1EDlIOrcGGE1ySXB4yG2sEJkjZDw+UxW9zPNh8CLqHpVwN9TwpneygMwlyWbJ9TbKR
 7rjYoi7b8knDOZ+Xe2lqe5Qf4AOYccn5UZmcI1KUyGykLvWguHiF1xd
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10751:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7421ec-00da-43a3-a2a2-08dca1346b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzlpYU4zeFFWZk9VK1ZGREFBSFBVbzlCVkR2akxXWEdETnZqR0YvNzgweU5V?=
 =?utf-8?B?aXQ5K0JISllhSENqMTdXUlZ1YzBpNnM0NFRuWnFlWVhXc1piWXd5aHpuVmpI?=
 =?utf-8?B?UjJhK0N3bEVPcmtJQXJjcjlPOGlQV3JYL2VEK3F5VWlXTFZxT1BydW1IMlpu?=
 =?utf-8?B?enJIT3Z4akhkZjhLcE9oQk0ycm5EWGY3bDV5TUNTMm5vSmY0aFBkOHRCUHJJ?=
 =?utf-8?B?SnBQNFJ4dnpqZ3VZU2oyZHpSVGppOWdIWlFwZUI5ZXg2UVo5WU5PL29Ebnhv?=
 =?utf-8?B?SlVCZ0g4N0ZQeE1DNi95eGJwblhYOFRTZmVyNlM4cks3cWxsTVJTaHFqS255?=
 =?utf-8?B?Q213ZWswTGM4bUU0Z0RxSmhHVytSK3BLZVIzRlBwRzhvU0w1cHJtaS9CK3dL?=
 =?utf-8?B?aUtYVzhEMml2ZEQ5a2hpRFpGWnlzODVjUytjSVJxSk1MOVJLRGgzdkJlYTZL?=
 =?utf-8?B?VlVuc2lPT0JRcUVlMTByV0xjcGRMc2lrZW1XWXdySUhZa1VhajFTang1U0ZO?=
 =?utf-8?B?OFprTWVJNXlmWi84citDK1JwSW9hM0U0OGQzekkwUDIvOVhtZlAzRFFqOWtU?=
 =?utf-8?B?bEpwd3hrNWcxT0FmaUovTzVDc2E3aUJyNS9SK3lpYVBvMm9TbCtNWFE3QkNE?=
 =?utf-8?B?N2xGWE1lOUw2b09UK2hYWmxVOEdqYzNHT2xNdEpxKzJMS24vYXo3NkUvclRr?=
 =?utf-8?B?WnNaTjNFUjFtbkxKYmUwNTgwUDBzNmNmK21RV2oyNFlJNVhYMGJhckdMZnU3?=
 =?utf-8?B?bHF0K09ENklCQXdSTnV5a2t6WU91NUM2S2ZXL2F6Tmx6dzZJblJiL3J6OTBU?=
 =?utf-8?B?QkJ4SE1BdHJFRVhTL3dacXFrdGExTGJqOWZPbmlZci8xNFIzYnlXNld5QWNU?=
 =?utf-8?B?cVZ6Q3phSndaYXVRbndmcUJ1UTZBcm5hQzFMSm81bk04RkxwamNVMGJNSStF?=
 =?utf-8?B?YzNjLzNObkp0eGxIcFpUdGZPSWNpSTR6dFQveHlrQ1gwdG5vS0poYVBZbmNz?=
 =?utf-8?B?d2h6TTlQZTR3ekxVa2J0ejJoN0xpdkIvRVZ6QVN5eEU0Y1NWOXlaVTJHR0Fu?=
 =?utf-8?B?aEdiNUZIc201aXVLRkN0bEdhVnpGK1RSZEcwVlcxRG9QYW1kWXZFdzFNUHVi?=
 =?utf-8?B?NjV1eDZZcjh4QzF3by9tVnM0RkNmMUNOQ0hyZ1hQdk0zTENaYUg5MEVRUWF6?=
 =?utf-8?B?blVzS0VuZGEwZmYzaUdibWRUVk5DUVJzWmZNZnMrdUp6QVUrdzlNL2pURjE4?=
 =?utf-8?B?elFZbm03NVJyenl6VmFmbE54N3ZvS01DTkpubzdlc3ZzVklac2VHQlZRamxT?=
 =?utf-8?B?VWFONUNjTlc5TkN0VUcrdHRQeTYwTkdSencyOFBiZ21xYzU4YlVIUXdLZ3JM?=
 =?utf-8?B?Y3F1MXVQeGk1clBudnBOSjBiUTJnbThNRVVROXkrZTJwRGJhUXo5dG5yVlEw?=
 =?utf-8?B?YnZ1VUEvbEk5T0ZLQU1BTDFXN25YVlQ3Y05xWFdEUU1YSmUwSEVFQjczSFEw?=
 =?utf-8?B?bEJaZGZsNXhZdHFrMUpzbE1WOWJYYmhZZjVkaGVISVh0a1JKYVVqbkxBSzFr?=
 =?utf-8?B?S2V5eHdDVXNTT29GL0UwRkVSWHoxbmJoQmFXenBSY3pvQk5JVjhxNU1VOUFm?=
 =?utf-8?B?c1VMYklRTW5VeTJYUWFBb3JrSU5lM1l3dlFwSUxuSXZSVnEwbG16eXl2SWt0?=
 =?utf-8?B?OE9LeXZjaGw2eGNWVk9lcWlPbjQxaS9BcWdVSUlEMUtoZzZuTG5QdUp1Q3c2?=
 =?utf-8?B?UU9VWk5JcnhXcklqL1ZkdVVwNnZtRk9MT2Y0d3NlUjZmL2x3ZGpXaXhMem9C?=
 =?utf-8?B?V0hUbUwwMGh1cldONUtCY2dYcklQSUxGWmE3VTJjS1R6RHQ5U1RjWGlnVG5t?=
 =?utf-8?B?dUJxbEI2ME94UTNCVFFnamtsa1BHTGFnNURsWmV3Y1FtZXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bW1HQys4ZEk5V1d5VzBjOEphZytlZVptSGVhcy9uZmMwaklqeWY2YlZDdmlG?=
 =?utf-8?B?cktRNXpaNFEvOEtmQVc4Y2VPTmV0ZndRQTJXV0hoN1UrNXZpcElEaXZTRWdl?=
 =?utf-8?B?Sm5JNE94TlFhenY1ZFh6UGR5dkVrMlAwNFNFSUNxaGJUTnE1TTJndi9QT2Ur?=
 =?utf-8?B?YVNuRER6Tm8yZ05ZQWh1Mkl5UmMzOVlDOHdzOXZJd21uaXRjaHdPT0ZiZjFa?=
 =?utf-8?B?MHhvOXI2T1NTMHFsNE9sUGxZWjdtVGVLd2hrNzhSbncvQWRtNFcxTlJoU1Z4?=
 =?utf-8?B?Z1VuaDl2TXZMUExlREJYVkxGbmYycnQycjVxME9jOXpIUU9Ha3NHeHVxYVhS?=
 =?utf-8?B?TGFJQUJ3bjZVYTlKbW40dW1GdkM5L1BLWVZteVZEUFREYnZaNUVjZDhmYVVw?=
 =?utf-8?B?ZWRmLzJEYVdUdkt0QkdXWmpMSjZxYmF2SUNXd1dqRUlkY2IwU0ltVDUvWXVy?=
 =?utf-8?B?QXhFaVRVZGFvSmdFTytoSmdHb3NjVmhkL1g1SVNHVk9mb1ViRU5seVZzeE0w?=
 =?utf-8?B?aWpsSS9XanVMZHRVSDRySnkyOWRUUVpSQ0tJMEpsSlF4TmdYUDdsajBsSTR6?=
 =?utf-8?B?VnpnbDNLREVHMEJjK1ZBOHNpZ2thWm5tdlBGTFgvclVxODltOWNPMGowTUtq?=
 =?utf-8?B?S2UyOVYzT2FUaHZ5NVpEQWpiYVFlcjIvcEdDM0VGSng3RzdKMGZPdWNCYzNB?=
 =?utf-8?B?VkxjZ3ZTNXlrN0lQSG5ZQURYbGU3T0dHejhHNkd6NnMzZzJPWVFrQkNIZDEz?=
 =?utf-8?B?RFZwM3gvTEpBbFhYMnJZZmcwTm15YWNNY3NmMEovNUxxRWdBSFRwaW5VOXhV?=
 =?utf-8?B?ZGxleS9NTENQNDNEeUJVZ3prY1RkTVNxQVFFb0JFc1BZdTdvdnZaZXZ3UC9W?=
 =?utf-8?B?Znc4QWlOT1ZjRWlTckZNaDdQT2hFd01KTGFXRVQ1M2RvYVBBNldQMHZuREE4?=
 =?utf-8?B?L3FBSUhSczhUQm1HWTdJUzRHUVI4SUIvcnJpWXBxaHo1U0F4YnFqa3lzamZI?=
 =?utf-8?B?Rm5jWU1tLzl0aElXUXhnd1kxdzFuc3ZGMFV5dlMrNThnQ0V2RkJIZEZGQXNP?=
 =?utf-8?B?VW5WSzcrNUE2OFA5WWI4UDRMcVMvWHBnQUFSR3d4a2JsbVJCdmd5eGQ4RC92?=
 =?utf-8?B?M0MzSlpnK1pEQ0FTNnpwb2VxZ3pOVUpFYU5adzlrd2dwZFhHeFZVT2xLUU5Z?=
 =?utf-8?B?RExnbmhYVndJaTdNcklHSXpuMGVlYUg4MWUrcHhUVWEzbmd0ejZLcGRlaVEr?=
 =?utf-8?B?ZXFNOVFiWVpnejZQWGROL2ZWeVIvUGxjZjdsUXVBRTJ5L0NqT1gzemFzRG5R?=
 =?utf-8?B?ckJicWdkQllWNk1OQ20rU2U1VkY1MzhXcU1EZ0dZSWVUa0VsUHd0VEFSSnJU?=
 =?utf-8?B?UFJBektkaFRqRkJLSEJyejQzU1BSWjc1MnN1dFN5L09MbHpya1dFYmRUaHEy?=
 =?utf-8?B?eVh4d1FJU0RHTldDcjE2bndwZmpJQ2VUaisxT1RYVHBHMEtyRC8rMTRNRmlm?=
 =?utf-8?B?dXU1OGNDa09HT3VmdXdyZHEyYVRwaW9HV2J0YlJjdU9wNko4MHB0NUZwM21U?=
 =?utf-8?B?SlR1Y01qMEZLUVpRMjY3a0YveU9vclJ5NlJUZ251UVgreTZPY2RUUThHenZY?=
 =?utf-8?B?eTgrdE5SeFVBTy9saERGRDIrS0ErK3pmNjVMSVJUS1BrSVhLdkRuUWpXcUJn?=
 =?utf-8?B?cTRTRExqdFV6bHFhRmRPb0UydEphNzR1ZFhGZGdZcExBdStQcEdaWGtUbldw?=
 =?utf-8?B?VW1VN0l0RGwzeHVIVzdFQXA1RWo4SitWSDlrTU1hZVRpVXRxc09aemJFdW5x?=
 =?utf-8?B?MEVWc0lndm9GcDZiSTlJVGpkeEM3ZHVaTTZJUi9DSTZyT0VCWlBiaHpqWXhy?=
 =?utf-8?B?RW42QVN2MWVUbXZrczVyTkZJV1cxcmJ1VVp3KzV2YndzUFZYYzhlQ01tUHdX?=
 =?utf-8?B?Yk1CZlJUeWNhd3J3TElXY1UxSVVlNVU5SGIxUWNLcHZwL0RubDVFOTFmNGhV?=
 =?utf-8?B?S2ppNkpRaWRiUEhGajJpcVZsZGNIeS9hb0V6NlJ1RTdkTUJGVkJ5N24rSWZI?=
 =?utf-8?B?MXFwR0xLSnNoVkZrd2lIQWFraFhRSjRoY1VpMHNONTBac2FoNlJlcDlVUG1G?=
 =?utf-8?Q?GVY0i5N33Xhc0Q4xeXsvbf28G?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7421ec-00da-43a3-a2a2-08dca1346b7f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 23:02:49.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtp4HiakJ9BK3zxD//nMcJpTjShWB5G67IuMVQoyb2C/wFJ8ROD4BdzZsYfDgQz4L0OHL2Vh3HqlyA/KSfX7kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10751

Add compatible string fsl,ls1028a-dwc3 and create a software managed node
property 'snps,gsbuscfg0-reqinfo' to enable cache snoop if dma is coherent.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index be7be00ecb349..0aa21ddd93cda 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -18,6 +18,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/clk.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
@@ -52,6 +53,26 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3"))
 		simple->need_reset = true;
 
+	if (of_device_is_compatible(np, "fsl,ls1028a-dwc3")) {
+		struct device_node *np = dev->of_node;
+		struct property_entry props[2] = {};
+		int prop_idx = 0, ret = 0;
+		struct device_node *dwc3_np __free(device_node)
+				    = of_get_compatible_child(np, "snps,dwc3");
+
+		if (!dwc3_np)
+			return dev_err_probe(dev, -ENODEV, "failed to find dwc3 core child\n");
+
+		if (of_dma_is_coherent(dwc3_np))
+			props[prop_idx++] = PROPERTY_ENTRY_U16("snps,gsbuscfg0-reqinfo", 0x2222);
+
+		if (prop_idx)
+			ret = device_create_managed_software_node(dev, props, NULL);
+
+		if (ret)
+			return ret;
+	}
+
 	simple->resets = of_reset_control_array_get_optional_exclusive(np);
 	if (IS_ERR(simple->resets)) {
 		ret = PTR_ERR(simple->resets);
@@ -174,6 +195,7 @@ static const struct of_device_id of_dwc3_simple_match[] = {
 	{ .compatible = "hisilicon,hi3670-dwc3" },
 	{ .compatible = "hisilicon,hi3798mv200-dwc3" },
 	{ .compatible = "intel,keembay-dwc3" },
+	{ .compatible = "fsl,ls1028a-dwc3" },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_dwc3_simple_match);

-- 
2.34.1


