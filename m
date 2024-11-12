Return-Path: <linux-kernel+bounces-406177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A15919C5BB5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D392864B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18085200B80;
	Tue, 12 Nov 2024 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="NXAqkSJY"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020109.outbound.protection.outlook.com [52.101.128.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38191FF046;
	Tue, 12 Nov 2024 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424872; cv=fail; b=a+083PP+eBSQxDNRfpetdToccxNarkmHpGVlMaP6zOmfpQDsPBOJJhSrz4k1T1c8hJRhQppb+mqTR6WHNlbMafsT4Dek/kt7Mg5hWTgo3WA7p8d0RkGUa1VuxnM7RyWA8UoiWI2qyMqx3AgIGTBAk/eNvrfYqD/ecj5kauk4WHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424872; c=relaxed/simple;
	bh=jCSVyD+n0Guhs8C3czX+o2DFCS0eGYXaLv70YxWVi2U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gLYYjzvptE24pyAOAkcEZRPr+cJAwSJdsMLGnSlrT9lzzMnjUKKzP8RQa/Ifzd4+LmgsMlDvclsGJPSDmeBoPwT0WkzybG/doITFXjz4i60Imc1BQwpAXqsG2YZUd6GlXFGfgm7zq6WPVd6XO2chGO5i3WkUPOIC5Id7qcY0seE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=NXAqkSJY; arc=fail smtp.client-ip=52.101.128.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ou6QQxRgUyA9PrtL5h9e31yswH6r69owoPTfLhN/Im4wsGURvg0yJyNatmWbsNRH3otUvv9Q2884xt8KIma3HUrekA1dRYSKVdwYgvAaw8EGPafBw7ElxyiWvtWKjMfgLlVvUEHhYRHP94aGRpMauYqyWO22bOYEW5YMlzv4InoBSsKwSazf2wbk8M6pzdpAbhK6Sw7ejNqQhJ7MpZNEYP4vSUex1W8QlS1cODsu/vfAZ+3EzJOoiXT10sHMIQjDTTRxh4Ht15M1/EhX+zj20TtXRcDJl4H1Kq8vJokCxmfecCgUkfVmN/33HHB451ihIeFGxc6EkeZ/UxEBV78tDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6aGulGMj02SVDXTaC2yN7koGXgxyzZecOebZgktKq8=;
 b=A6XZiFN5uQqZQW7Oi6grLpi2a0toExFi7H/PC7yTJi1t8dPD9Qf1CBVKpiMJadcm55mraL/GQaggxUM5iT3oJTdaBz1u7JwmYDTV8RCRnRGI6Rwimcl3o5Eul/uBZc4Btv7Ffkpwu1JV1TAc4OX+gCZchDkOM41AGNtO0iUJhfNnsALW4FYqjqRVgJR5pOGLZS6uNhmmjvtZWrBGAAu/VAMPcmOA/3j5ul9fDwVDPF/cLHdK1LKGt8FhbijzirKxlS6O80g9HvxDk2ObUt2gS44CxtNiDRqUuUAVPamisSesnvuo2sX9sVyybBJJypP91xAtiFC2UJBdAc+VC97RRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6aGulGMj02SVDXTaC2yN7koGXgxyzZecOebZgktKq8=;
 b=NXAqkSJYZF0+uJmJ+ev7ONlHDMPyhV4Cm1HS/ZGQxzx0ZupInnft8hvFmlAYdtwhiZ2TeAqzoeSZldSgfzJdNQnOzljcCWpmq+UlvJQSj4TBuJpvNYIl6GkwWUQD+hV0F1WewJMXREnOJyWYpSygQNggF5NKGAjfXU6/xTEdYFugHyuSPHsKDlTjG647/t9J6q6AkT88DxrbBHLEj59fAKh9NRe8RtN9FdOwgZWqbp2oZTl73Rh1xbgOZZQ/hL54gY8sMBF+BgPB7UdZXfEeHoPNkPHGSU6HWwXh0GSfgvIcgw3hUCJsdge2+nqG3+MY8fH4M/uHSn8VVUTD7RAFnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by SEYPR06MB6360.apcprd06.prod.outlook.com
 (2603:1096:101:13f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.14; Tue, 12 Nov
 2024 15:21:01 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82%4]) with mapi id 15.20.8137.018; Tue, 12 Nov 2024
 15:21:00 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	angus.chen@jaguarmicro.com,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: [PATCH v3] USB: core: remove dead code in do_proc_bulk()
Date: Tue, 12 Nov 2024 23:20:22 +0800
Message-Id: <20241112152021.2236-1-rex.nie@jaguarmicro.com>
X-Mailer: git-send-email 2.39.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::16)
 To KL1PR0601MB5773.apcprd06.prod.outlook.com (2603:1096:820:b1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5773:EE_|SEYPR06MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: f7bc8338-7e06-4122-6ebe-08dd032d9d49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qkxh0hCCqbEA46Bf0P8BjAvE+nn2QsZTbTDaeYyJIfmqqQdejZdvS5dWZIo6?=
 =?us-ascii?Q?6aQ0XKC9VeruqMNBaVkIs4sU2mbwcYESWpKWQH0ppYsr8IKj5Ont6eiHFVCM?=
 =?us-ascii?Q?RPAmmp8ttngN/dsPoYTQBnMWOCOFAdxVGFJrqYfry6e+z5yhY1kcgMUogqUs?=
 =?us-ascii?Q?54jle6OyNaEqKL91b8R5praSTEJXHw5YHvO4cMrbbQiqGDd/QvSbbxzb+ldR?=
 =?us-ascii?Q?EkNrJ2fkSh+Afe3c1mGz+qyoV3wAu0P7l6RielVr8X4hXpbomnIVWmuQvGed?=
 =?us-ascii?Q?atZ/OTKNH2pmkueGztOF7haV3xTWZEPzmJ6QUu7r/+pzizI9aOOiB82WKvBK?=
 =?us-ascii?Q?eLJl3ckpqNaP39FLgiTsgTt8HITUs7IrB/aTWHElECil8CXWgqHv3TNAtTgR?=
 =?us-ascii?Q?l2hORvznzrdlOyDODIAWfK4SjedGNY5yEaTFw4yHtU8PCtWC/J2wCUMYGTWo?=
 =?us-ascii?Q?nBrj7fAF0hdDJmmfADnVsixJnrkT9mQWN9LdFCGVUCMKXy6oRsQ4frMJw7q1?=
 =?us-ascii?Q?it48d07rbxKzn8/mGiiwhzvzlhpSI8wcohq0Kpsd8ViGVIxR6w5bwp3NbvmK?=
 =?us-ascii?Q?NQiWAj3C79jtDrBDYon0bUcfC6kNBipvPRfdV69k4E4QhTNkw13B7VMQNG0E?=
 =?us-ascii?Q?eAxZQEaLToFQUsOHpQS4d5SnDlGvnILM54V6LTvcJT9+SZX1vCCn2gc96mVx?=
 =?us-ascii?Q?S6uNODvDWTWNfxfB72cGSoS/9a+rYeDq+uzbvqfWWFa6Ycl2vX0Jw5sfKUZt?=
 =?us-ascii?Q?hmPfrrDxVu3pevvCmF3OTggBR5N1bBEAw5M0wj9xHwmVOJmRh/D3VRdvvPoj?=
 =?us-ascii?Q?W7VppUF1aggd92PaH/4KOwuKLdGsTYtcMQ8zLQ6e5ydnmoMRmTWwT9f4YUGQ?=
 =?us-ascii?Q?+pHSHfnVrrmeviyPYG/3kR9gcMNwPRcsGK+2fY+yyDubcx0MXuO5vwWM7+pH?=
 =?us-ascii?Q?KO/HarGjpOxGolWsUFTbvsvLD/MSLmlldWOpgOVAqt8UV9Hr+HLOmFg/PfTP?=
 =?us-ascii?Q?9qXDL2bDbPWmYhpzicTGvz9zvR2Ji7kkfxVFQN+P80yyTKmAWMgulbPnLw/e?=
 =?us-ascii?Q?G/OLR6gdO+h6b5L8CyU7/LVYTeQe9VxNF3cIexKaCbFBrMqgv2Q3kI+u3G34?=
 =?us-ascii?Q?9ing2e/5m9ph+3UijlfFpH2+ylmDHO8kaWnMXOYJJr+df1nBUrTVAekZ6Z8F?=
 =?us-ascii?Q?SUGXhM/n2Vpr8rgyMqcTASuPXSQM1vJSgDhyJPluajS1EeuewY3RX6LvNs5U?=
 =?us-ascii?Q?Tt4gjAHhJKtMwqUNyylunRpmUo/a+Ei0TeZGr+J/XBHhCFVw1FWdoGHKzicB?=
 =?us-ascii?Q?Hc4sIZeF/jm8C+ZlirVeolCBP1lsZwlQ8BqOrvD3//t/Cr3Ps/PQHC7DJUSE?=
 =?us-ascii?Q?kvfwOcIQD5I01i0v6uE7nopsTryB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4tHxuGTzPyBZ+SKLTr9h72q77HmWRfylBfn4EkJk9juk00DUEoLkXIVjyzVI?=
 =?us-ascii?Q?QHbnFxuBCyxizp/m9vWkmgAOhvxNrs8A6GrOoaB+e+FB/V3c+kj3LLsyqg0U?=
 =?us-ascii?Q?XdgLxTvwsAcgcYEOxhjrLaoKqPN15OK8R5M82R6LATfGHkmMNDLF/A0znRe5?=
 =?us-ascii?Q?Jl2nmYpexabb1HNGyfz8LumU7flgCTM627MOmlU99QgDj5zLka8uiPpZM9p2?=
 =?us-ascii?Q?21Ea1iYlQ202RlbjygsSRKPI3mESRl0DQih70+PDZsPAPYWFZTCIdESwPWbF?=
 =?us-ascii?Q?V+AHYm93NtRgcj7Ogd0Q69S3Q5jU6/nSnhTSbYigDFC3Qz4vl6Lf5Tqm0q1V?=
 =?us-ascii?Q?oQgW98O8im0w+EJd8aKotEYZ41tSrRbjOS5zx43OPW2pPUyGqbPbBKLcM7o7?=
 =?us-ascii?Q?pYNu9/B3OW8uhdjwlpTLZvKvhhJumjCQVvirLIPWV1X8uVZABZWAKm8MGVIP?=
 =?us-ascii?Q?NB+gB3MPGt46emSNUhQQHutUhXGFkrPJgw37kwAtXLiTqeEkIu6vAlN2kfTc?=
 =?us-ascii?Q?24XbJbMOOsqYIN0rO4Gv3rmZswoMyOEQu5glSXa4PHmP0+HCtVK7woIt65z0?=
 =?us-ascii?Q?OM2/vBrJJ206gonYXffWW9FZqgj2QhqNPfJGioJrk6PlQ99HOsR+ZttCZnl3?=
 =?us-ascii?Q?IaxokcQLZQFE7zx260O+i2GJABPrXepVBylWGUd/DMEmTS7yZvEbvmmhdWeC?=
 =?us-ascii?Q?zFJ/1u7DfMdXN41cBnu8kWrjJIHiIc2aiDxnGn2wSabY9zhE6ECunuyMdHOf?=
 =?us-ascii?Q?5/axDPQNJeujwKZ6NObDPppgsN0cyjgUV/2gXLnxDdKWud0IuLwPKP+54ksO?=
 =?us-ascii?Q?4Ucj/QLY4EFdwb9BD5nZxi75ab9YG4bidsaerzTQMpStS/sd5IuC8PcdnZfl?=
 =?us-ascii?Q?ZWL8XzZDRkGYmCr9Qf2TWleF3XzADY9rKGal88hNsAKcAt3aMXVu5iXXchis?=
 =?us-ascii?Q?03jLXbLA4OBG6lcaRVB2Vm/rdqjrEDalz9tzyMXiAMyS0/D9X5clHD2OH7DU?=
 =?us-ascii?Q?Nky467ep14GGDKyLo9XCqd4FkK/vA2OUhkNpN3A4cZBfVP+2RfowXA08/s26?=
 =?us-ascii?Q?WZj01eYRQ5oUsYezp8ivbDWXPTC4CfDd6Ee+m1b4bHv+HdDGmRzlkvrTG7Ks?=
 =?us-ascii?Q?XCedoyC46JlS1sdti355yVUnUIxMbKRuGdeg7J07DXuE/4O8PujdwQpB1ppY?=
 =?us-ascii?Q?wVlDrPG+Q8/yNox2TxDSZqgEmjtzkWVO3EHRNc7DRDw3keEpY/Xaw6Oe8hUa?=
 =?us-ascii?Q?x2q+FUoiSyr0BKAX6j6+I8mR3IMkbjuwIqmaqiwVUrQ8EyHX0UndrMdcMUx7?=
 =?us-ascii?Q?+0emNb35V6t6FPs4iAwTAU5d6ck2QtzxlyhWI9hArStTj0oKPEoNuVoq8/kT?=
 =?us-ascii?Q?gJzJtmhaq49icOr7JCyv3ItmTvJ3WWzzS4pO/qfDEnXkT8BDLJL/+3ESSdwW?=
 =?us-ascii?Q?ICe2pQiPbXTTaTcahkZ1NZvGr2f9vLcE4D5+5Q8xbhBuWJeMntdbt675o0cW?=
 =?us-ascii?Q?V/gwg7PBRpI3vRWQN1DVlPHS1XSNRwLuIaNVx2vtPx2t2bY1urV11XnwgpRc?=
 =?us-ascii?Q?J944hVweoj+AFOii5bSV/p27zkInI959S7DTvu2f?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bc8338-7e06-4122-6ebe-08dd032d9d49
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 15:21:00.5639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ns5K4EZNcYYyDY9RBveGRKRjsNWsC49u+cAH8weVQZDJHv7xHir4A0T+azJZQwichOsDZRZVn32q+VoAVG+wXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6360

Since len1 is unsigned int, len1 < 0 always false. Remove it keep code
simple.

Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
---
changelog:
v3:
- do not CC stable kernel (thanks greg k-h)
- Remove Fixes tag
- Link to v2:https://lore.kernel.org/all/2024111249-stifle-mundane-dbfc@gregkh/
v2:
- Add CC stable kernel tag (kernel test robot)
- Add Fixes tag
- Link to v1: https://lore.kernel.org/all/160ed4e4-0b8b-4424-9b3c-7aa159b8c735@rowland.harvard.edu/
---
 drivers/usb/core/devio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 3beb6a862e80..712e290bab04 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1295,7 +1295,7 @@ static int do_proc_bulk(struct usb_dev_state *ps,
 		return ret;
 
 	len1 = bulk->len;
-	if (len1 < 0 || len1 >= (INT_MAX - sizeof(struct urb)))
+	if (len1 >= (INT_MAX - sizeof(struct urb)))
 		return -EINVAL;
 
 	if (bulk->ep & USB_DIR_IN)
-- 
2.17.1


