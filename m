Return-Path: <linux-kernel+bounces-544902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE96A4E684
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE36519C7AC3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD4A283C84;
	Tue,  4 Mar 2025 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kgbgKRxH"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC5B27D787;
	Tue,  4 Mar 2025 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104859; cv=fail; b=Hhd9+W+a7MpN0cujctD6Qetl94g2/lGtTGr4GrHRs8n4Kf9wr/lbP0nhAHnPo/oL2q6EsqX5iz6GjXfhLm9uLAz22SJG0Sp+kSh4eYljtzxPpznM628R7U+C3vz/NhHsQuPKX3X6iRMLKx10+XUIkuD1cjax8t8+LPxH9pjM3FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104859; c=relaxed/simple;
	bh=JKlmRQZeHN8odiLq4j1kSU7IrZRuLDbHPr+VScktEyY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DbWYrV4aX6PL9A5/Sfxy9Z/o85OxeAmvJle8FAvtZKuu/A48/odkhq8g1frYqC2bg7xVF/2Y6iBoyKnjKmMG/rOBCva2rIEdXrrdHvgyOF/H4W71t86acauONIfTQ27sk5T/BnjIeVgzxdEEfCKOQiGHw9kh2gOCa27QyhVeOJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kgbgKRxH; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ku5PoRk30aZl/ZVLmFVh9OZf/oPX9RqF5k9RXZtmHK7798pCxB60KcKHadmM4NZhcVZQJJrWysavA6sHcG+AFxRWGvcyvWAbeEzq1oDBCwQpHii64mTByq27jkNefyBby8FTKiUfxWnsNq8mCgZSdBYw492hEXeh9hZyLUYweWfC01cz4eYGYqQ7SqSxVEVo45h/ONE3oReD4tsy1yuopFFDaylEN2eXjVeKc+TIIza0KCNARCzusg5sZA20pVaakSfOJZPFx0YgMafo2yFMB7IwhuSVNqhtDXiYELYKOI9PvanF7FAMfu6UXr3FzPo27B5L/A4sadmqoYhFBaFEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHJkMEgvR5CFt7mMzjuFcVREWomQoP5aUxZyaZk9mII=;
 b=bOwiRoX+olfEsf3dOwx5eWD9dy515srEK/L6Y7vbdwSwHvFMjx6IsuEovDtKhOqDQrXdl5Sh9I4lV325hZS6/HLOnr7i005SkZh1l13z8sCGRIBjTA95WY9LysF9R/Q1W4wgUPB/xOBIMzKpSZnt2jJQk1DcMzMVIg3If1cg99P+xo0tR8aww5diUuqnk0+IHY08WoZM9tm1wTkCcP9R5ZQBljdeqX99icaFw9D/VN9cUF3Ia6aHtXe/RnKWmAQ3A8eEwuPlmrkwxIj+5fYY7HeRuHUPYP4PWbXN67KsjzLlYzP6UyZzelBRT8obtPLVt81dL7iIoo/390skUTO0Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHJkMEgvR5CFt7mMzjuFcVREWomQoP5aUxZyaZk9mII=;
 b=kgbgKRxHHf6iQfidby2riRVZwJOJyaSkzbVKLm6W0Le5tjplK563+pYyprhBc7rnGkK/LqozT8SAr75yFkfUE4sPb96689faxsAhzRie7Q9o+PShn3XBQ9TN31exCvQoH4pgyoPJoxm84Uo3fXbnNOK+AuH90gTthi6mBpnW4c7TH8x/qaRcL+2iit4ht73JZK+oFAXMAtVjxVj+OkqFWMgFQZn/CedsncpTMak26kU1g7FPCpkMluafyhqo2Ame2+8GPtPSJF57USIJJ+Z2ewgiE061L1m3EK5gpJVHBjP0UwdelrhwyhV/PNGbj1uqO2PBIJM3LEqqzC7PDCyFIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com (2603:10a6:10:5b3::14)
 by DU4PR04MB11080.eurprd04.prod.outlook.com (2603:10a6:10:587::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 16:14:14 +0000
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db]) by DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db%4]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 16:14:13 +0000
From: florin.leotescu@oss.nxp.com
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Shych <michaelsh@nvidia.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viorel.suman@nxp.com,
	carlos.song@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	festevam@gmail.com,
	Florin Leotescu <florin.leotescu@nxp.com>
Subject: [PATCH v3 0/3] Add OF support for Microchip emc2305 fan controller
Date: Tue,  4 Mar 2025 18:21:33 +0200
Message-Id: <20250304162136.1963384-1-florin.leotescu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0025.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::20) To DU7PR04MB11163.eurprd04.prod.outlook.com
 (2603:10a6:10:5b3::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PR04MB11163:EE_|DU4PR04MB11080:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e5f39c-01ae-449d-6146-08dd5b379ac1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?W8/8fvsvMwa9ZbTtj2AJmWDznJh5pN4YgAGef4sj3zpDl5WYaEc5laPbgR?=
 =?iso-8859-1?Q?zER9yooz7Txb9Bj1vJEI8f1iea24a7R4E1EtGlZcDY8EbH6rKrw0k1Anae?=
 =?iso-8859-1?Q?rY3MpNBBjpCt52Xtk9I3OU2KlXvkbGsSCXEG+9p+KFj7nMF5Xe98zm9aWg?=
 =?iso-8859-1?Q?n7+SqFpjIlY8+vbiZ8euX7xgfMVRoGufuBWgC2XvNMAaaYOeYA1l2j7Xq3?=
 =?iso-8859-1?Q?rQikqp5izh/os2H2qAFkGui9vystjncZnRGBKcfZoTj4w/RpSR8Tr+HohY?=
 =?iso-8859-1?Q?191cHGk/+iYN/WJY3HsSyJhorYxBgZxkQFo+G/DxS4IYQmDOJ36SmohLiP?=
 =?iso-8859-1?Q?Ex6c3ED+DnaZGkN6NTykXor8YD5CAko6/rumqkkhQMl1qqa9kwObhGL59r?=
 =?iso-8859-1?Q?RigLsLoX18IrJWC1NubZulLYM0y8Y8oI6Rh1oRJlz66JOS7z/WDIt/9Ida?=
 =?iso-8859-1?Q?MGnlHsybE39IXicuT2HHzWnbi8AiIhNIvwqZm3B6e0OcEtguKFgG2KMVOa?=
 =?iso-8859-1?Q?99SBag46dW9uhRbEevoCbzzNSV+wUaw7wkPsVqvMAbcQtYz18NCVzOLIYU?=
 =?iso-8859-1?Q?PyuA70kKatjbhQpfntlM0QTru1JGX15ouimMEo/e3DONqGaMgpYD3ArxhP?=
 =?iso-8859-1?Q?qGqCW8XzvqUYEtDR0sNwM7gcFDio1cPTJ48rU4Q6xK2gMTORdZorVwrBWI?=
 =?iso-8859-1?Q?w518DYX1zo14R1IH+b8Lhw9Vll2416sTeFcNx7k9AMVADCp7tipnnKrK4q?=
 =?iso-8859-1?Q?8ZKhYVynN2oTpkcCRXeXSm7NpfP4pJZFDSSTMzsDufLRWJ71lbKMvU/1ek?=
 =?iso-8859-1?Q?4DGUI7hasNbTsEYFIgpYXTsRLCnMqRLTAyfKCkQNYoC2KQuGmePsmJBbz/?=
 =?iso-8859-1?Q?ZCK/OeoM6LiquosqKyWliznGHIpcuhNtg5GBd6+SWfJ/ohmweIdxgWmwZm?=
 =?iso-8859-1?Q?vDsDfl412vbFinFTkcRc8ilUASy/83FuWS4EJ8Jigf8GlgGYQs/EA++u+Z?=
 =?iso-8859-1?Q?A7QGZim4QA613Yan7p34IvKgsBZ3kNDuKIwbH0T+n3YgH5SJIHnpNiIBKv?=
 =?iso-8859-1?Q?+fbSmaCgfM8o7Ozrr0Xa77UpY1eI2dp3QOW22SCWl2X6ZIOhdCBvTdC6wi?=
 =?iso-8859-1?Q?MtEcysL+WlTiSDBhpo2+9n64+Nx+alZrh6Yck00Vh56FfnFe/8tVNax0I4?=
 =?iso-8859-1?Q?4O17xgL/NOwAPEyRyH+ceNO3PhwfhNRTPzgU4vnw7pe9m+mLIzmYMTxPOp?=
 =?iso-8859-1?Q?90we+4lL6BcsoKJLcXFDUNpyOY1fTdSyyYLSjxfYzgc3Z+ecQJZj25cLj9?=
 =?iso-8859-1?Q?ONYSio/x0VNEjiDixp/PsrxbjZn6L46fE3sGIbYKlufSz4L2ezWUacg07J?=
 =?iso-8859-1?Q?nl4K99ZWwc2M0xlk2Kg+0VGpBWk58jyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR04MB11163.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?fkmBM9xIgWTO6pw6JkPxq6hzzjEfXpQySq32DX7TJ6S58LHRRw3PwtCu2F?=
 =?iso-8859-1?Q?2lNXaZRHNFlpSH/jiFAhAd++ykLKIPVxyTJGsY+6BWTrjQhV7dpVvHgA76?=
 =?iso-8859-1?Q?V8HZ7LhlSW9DKDInsF/lVmwjZH3fwjdlEZWONqOANlmPWAlJSjqv4LtyXB?=
 =?iso-8859-1?Q?wIsPBbua5Jfpl67iLAgrlOW+d6kZ8EdqsLmZm97TuTnaR+R1ShYyU/6Ond?=
 =?iso-8859-1?Q?BJjXXlytB/KGw0i1qL/xpm61yFlHnmBjaHIthIWqlDbkfBT3+c4N1N1uOt?=
 =?iso-8859-1?Q?/tIwdcXvmm927Y4lz7HsvxUS1XmYsWPuKI9mCyKPD6wGx9q3bFkxUlMg44?=
 =?iso-8859-1?Q?SHF+ySt8oTC5uhZLG/Vi53ayrjurwPIiNjr24HgeLK3lr2ebpwwBu8wJb4?=
 =?iso-8859-1?Q?9rc/VTi/gFtrSuz7MBNqlLJrz/u+vdW0LfzRdiH2HNa1qNdM7nyxs6n9MP?=
 =?iso-8859-1?Q?w6B5P1MlQ2vhIi+FuMyzkpUupshzmgMEWrNbTfj4FevhyFqmoRP3GP0G73?=
 =?iso-8859-1?Q?hlEew6TEbW0OAGSAUON4QD1FSAmLc5Ur8Y0kGCLV6u2Il+H9WuoTMgUXQu?=
 =?iso-8859-1?Q?NSCRPlCKNL7vRS2ieBzmIXrGalCpkIYEseQG+0dyFsCa9kUnHQt6SNslKw?=
 =?iso-8859-1?Q?d0DtjQ4jnff5x1CCQjO+witQk9NS4/TTYfpUXlNSMCHohTmP4ES+kgVI+L?=
 =?iso-8859-1?Q?SYTcin1yNoz3gHVs9bcBRQYxfcG6buLEup1MokZB883SF5GNTNA6RSf60u?=
 =?iso-8859-1?Q?mC3JCYqPyiFnp9576xlzcnsdTwJg/8OPVVa3e8XDMFzrSyBoPJZohjqO9A?=
 =?iso-8859-1?Q?BBQ6927v50xyNoDq5+BLms3Chi4DP/tgWMUWPsFDu/N/57CBrFaPIb5Gg7?=
 =?iso-8859-1?Q?AOD07gfXKaD7Aac17RvdKnz5+Aa4sVkIAqVXMpsjAG4v7Q82LB1629z/Uc?=
 =?iso-8859-1?Q?bZvcS1Bkw5mFYIFnjCg11qEwIxLEWNKmtRn/MpaOoKW7sCCpzNN+MmEhI0?=
 =?iso-8859-1?Q?IC4jeiTAPVeYSslGWXdiBlHEp613vv0u84FmjZ10M3TUQqLsxY+eBG8u6z?=
 =?iso-8859-1?Q?XBm7uQjS6a/ol6iT/kwV4xRcht1R21renzemw+832EEyg4MC3CkfdvJKbQ?=
 =?iso-8859-1?Q?XNuKq13ogHhAAsPJcaMEgjyBWEyG2am5A2OlcpOqXVYD9cDZ9L6ybP9dR4?=
 =?iso-8859-1?Q?D6Z6gd6XliVkcRC9UKWniw55kfEOucDyQOg0ddT6sPxg28hWJK/eUw7bPs?=
 =?iso-8859-1?Q?oAV1tbj3r+pHfMRkKEud1dKkpNmbd3AlMDtCReTANgWyBhth0ZVtaxy2po?=
 =?iso-8859-1?Q?CMvKs5fxVA7wOEZogIVjFg+c3X/x2WQYoGOG303Xt/Bo+55DxTaCmUniZm?=
 =?iso-8859-1?Q?kLg9IQQZYqgaprNFPDUF173YirI5tfaMx0PZVFWr7xLbw+ELI/Khb9oLJs?=
 =?iso-8859-1?Q?ELWQQx/M1Fp8f0zEyFaPatWsrK9SMRnBYo3DS+N1tkTklDo13x5oMHVji+?=
 =?iso-8859-1?Q?kUP0USLoblcd7z0YRUpD1Tzlk7ecRI8E9MSiqXJ06pKZb24SqIaZZgzSk2?=
 =?iso-8859-1?Q?ThiyiCl0MyheVZJM4mbvEJM8oTaeJbtC5b9exGaRUoZ2qTYkdzgydHgH6W?=
 =?iso-8859-1?Q?rbAeYBCv+nIpeVKpbaLq30BwiExlaJqlBxbepNsajXPUaT9Qbe8MSuJg?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e5f39c-01ae-449d-6146-08dd5b379ac1
X-MS-Exchange-CrossTenant-AuthSource: DU7PR04MB11163.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:14:13.8065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMM8zkfL5gRKghekTKpiM/4khptEs0KKMpi/oLmqjZ9X90XAkFttIqBl9K+ETM1vLlfhNTV1+LMUKKWKDSq7UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11080

From: Florin Leotescu <florin.leotescu@nxp.com>

This patch series add initial OF support for Microchip emc2305 fan controller.

Changes since v2:
- Removed the introduction of new properties for now and we only 
  enable basic OF support.
- Link to previous version: 
  https://lore.kernel.org/linux-arm-kernel/20250219133221.2641041-3-florin.leotescu@oss.nxp.com/T/

Florin Leotescu (3):
  dt-bindings: hwmon: Add Microchip emc2305 yaml schema
  hwmon: emc2305: Add OF support
  hwmon: emc2305: Use devm_thermal_of_cooling_device_register

 .../bindings/hwmon/microchip,emc2305.yaml     | 43 +++++++++++++++++++
 drivers/hwmon/emc2305.c                       | 36 ++++++----------
 2 files changed, 55 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml

-- 
2.34.1


