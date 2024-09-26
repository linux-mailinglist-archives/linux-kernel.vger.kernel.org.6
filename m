Return-Path: <linux-kernel+bounces-340954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 136E8987972
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AF3AB27C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1AC17F394;
	Thu, 26 Sep 2024 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="ZGgy3IPV"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2096.outbound.protection.outlook.com [40.107.243.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D4617BEB1;
	Thu, 26 Sep 2024 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727376577; cv=fail; b=XFrnf7ZlPFK9KiCFbIeD4IJFWXNixeqfCUG0aYoKwa0/jaABaNmfrNkd/Zf1pj4TKBdLo6M2FLxIr4AtbmgdnbfoC87nmeoWYmEWJf33qcKjFy0CTv2gS9nLh+2tx6lizhp9RcVB/vElH+CPbp8Yhv/FG8aBQRq2p+qz0RrU5Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727376577; c=relaxed/simple;
	bh=vBk/PPAe90xbn5GUGJJBHiBgOWy9d5IaJHyYGEqaP3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FqnkrOJ/EE57MeoJMMiGkoXsM73iIpjAif9nTUw8tU5nO1GPTEdIv5ooMgxsovSUD3BpWhMjITBDXRnAkHn+FOnMi41Q4Ukfno+1/Hai0D+7F5+y7+eBJIwhC55kt1wjojYesbfdGlOGbuu8Xojwqm8di13QcEcdXekK7Ee10pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=ZGgy3IPV; arc=fail smtp.client-ip=40.107.243.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHI6yyTWZgWd50b5z5BOK6P+j2M9JCKmfwuxBGBhkKTDE/cKpcCu6A8o56tuVHUkpMD43yQ+zuosyis7sJGQvD6THWQub5UsuO7BZm2X4ZUSWf2jAoe4Oj9dF0RkF/Bljl0uU12Ta8pdpcpuM3Q1xYQD6gkf9X1bxVcAi/vyBfwlwcHjrEvri+ixNcN9vp58g57S6ZJipAFipa6USXuq91xs16tbWUe13E33dGGUaxdc7hIu6vqpbxksmSIVfWVZQSGC4E9jJPa1aiiJeuhrg+FFj8M+O0vOwQNdhyJnVIYRHGGSTgrcWvvruo+FL7dqCRA6D0ZwJsxU6AxXTgS3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lJ8/geIdXI5LF9M3gDv45i2/TRclEE7LNYePchdofU=;
 b=GLUUmnIwuInHU2hyH30gqoM1nLHCnibO83ZYpHYPA7DirxzJvUKMs1UQK5tvXOTU+gIeuWeiLe1+NwxVyL4rq6Ah8RiuNSLhEmv31TkaEs6KYOoXGAqqmvdWImfs7SIYRlYsbVK+4KWVQkT6MZ0wEsQ+MlFnTW9qTYRST2vMA7xHLEha/S+oG1ZlyzyeO0oDfYK1Mgq0gAbdU/4R/jJv7FF/rIUmzaOAkGlfrP53j4Ut1cKaMvaaEBEwiLhGkaFfn4oagy2gHP65s4lV71dqpVE1d8CtOg38vu4e7luufqL3NQ2IxdKc/zDNPZMp21wav0Mr6WxuLtFm9j5cUR0eew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lJ8/geIdXI5LF9M3gDv45i2/TRclEE7LNYePchdofU=;
 b=ZGgy3IPV7UhZAZGl0L1yYOE9kNG0Z2vp3148ZFkF900NOzXRFsyiWHPiU3WDR0FomNUtLBrFuLSVB2MkOBaoCbmr4ingdPeUc31SP1KpCxzgUM4cGugKfX2gZIFpu5+YkyQWd27Yxs3ZNmkS5ApEG+eXfrH4wzPQ8TB6ykkq0/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from CH3PR22MB4407.namprd22.prod.outlook.com (2603:10b6:610:167::14)
 by PH7PR22MB3505.namprd22.prod.outlook.com (2603:10b6:510:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Thu, 26 Sep
 2024 18:49:32 +0000
Received: from CH3PR22MB4407.namprd22.prod.outlook.com
 ([fe80::a87a:b781:ffdd:3256]) by CH3PR22MB4407.namprd22.prod.outlook.com
 ([fe80::a87a:b781:ffdd:3256%6]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 18:49:31 +0000
From: John Ma <jma@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	d.schultz@phytec.de,
	w.egorov@phytec.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	John Ma <jma@phytec.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am642-phyboard-electra-rdk: Fix bus-width property in MMC nodes
Date: Thu, 26 Sep 2024 11:49:18 -0700
Message-Id: <20240926184918.3342719-2-jma@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926184918.3342719-1-jma@phytec.com>
References: <20240926184918.3342719-1-jma@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0253.namprd04.prod.outlook.com
 (2603:10b6:303:88::18) To CH3PR22MB4407.namprd22.prod.outlook.com
 (2603:10b6:610:167::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR22MB4407:EE_|PH7PR22MB3505:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab76176-550d-4927-cdad-08dcde5bf536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6+9YUU7j7mA4CDhiBE+4zZMNQ0VIKZ8o7jAdmZQ0xhgk8wlnUp7X1nIIiACb?=
 =?us-ascii?Q?CyVkN3bph1lIYxzwkYvjUzUKu/tD/5muXt//g4E/sjok2AgzM+uu9jyYhmAw?=
 =?us-ascii?Q?XMv5tf5NtHEuS6PuS48PlcKZUUQvfNUtpPUGrqV0n2Yt4IfFiStBhm1BhwTw?=
 =?us-ascii?Q?Sxb3u2coST2mnEEtLL6/B6fRZmdwrngEYo22Xwz8FBi8Y0w4gepi/VTumlg7?=
 =?us-ascii?Q?H8KUcH88XzbjVrVAUToD1PqHCY4Fzh04mIKT1F5lVYEZXzNB/DgKk1diFatA?=
 =?us-ascii?Q?SeY9Xjhog4kmyoJOrWRS+kIgXgOZxHC/sf+oW1hDDVkBdQCRUN/hbVzp6t1Y?=
 =?us-ascii?Q?VliQiJgkM8OEA7uyFy6JuG41znAKDI9ePQF887udW68dIo+zsPC966Y/29Fw?=
 =?us-ascii?Q?kf8B3LHAHJ3jEEkum1PHri5OUnboUjTzTxUT7mNLrm6B9VYVfHH3ISmDdeEi?=
 =?us-ascii?Q?05lR88zkGhOFNk8Tq/4XV0Ykf/gEc6qZ3Pr0F+WEs9Phy4G2fMxzIX4Jcoc3?=
 =?us-ascii?Q?dRUDgZQudxJES6hJh3LV7V4Yu4YjE5KnpnmwIOHzQ49YU6f0EJRRwwDZPtjX?=
 =?us-ascii?Q?HgmAVi7yj5Um9iYpo9vqTo7ThYS66scl7tF3/45VwOrJ35MYFOwQfMhdTb6f?=
 =?us-ascii?Q?vqsF3nWr+oPziA2wsLOw4b+nuc+8lsz4hTDyUKqLMJSfw/a5P3iWTxfLgQEZ?=
 =?us-ascii?Q?d8SwbwK7DnDUxzOkAuAUDL699kSm2tIUfVeCKSG4XH1dadyIxFx3LBBXdhpC?=
 =?us-ascii?Q?Z5kLNwp2LsLlyA2iyQjLwyS6dX693YIj+gmmKkdwD31cWoXm/hHpzMkFtdUn?=
 =?us-ascii?Q?mTVnR1+AUdxm0pySG1x/dVkr60jxhkzW2lrPBUiv0V/y1fap66aciM7E9eKP?=
 =?us-ascii?Q?T9cCb5ZYU1D+d6PZInlyCM02bfOUPoh7EpEPF25Gb8efd/ToAg+nfrrWVhte?=
 =?us-ascii?Q?USRNMYvGn8p7N6a3FowNB9MJHz67BPiP6POKEOan6lBFXwayFw5ar7oFAHtP?=
 =?us-ascii?Q?+V6XML1h6oMoAy2kPK5l+pTM8j8cbXXmzU/CjfRqKumKclnrm0LqQI4kyDq3?=
 =?us-ascii?Q?FA7UeXEqZfppnJikeGgS/vv7G+yxjt3c3De97RdtagkP6Kwz6/0sunva2UUh?=
 =?us-ascii?Q?NkEi6fgsp0BwxXNpDR9Plwxx+p/jFdCYrCRImVs9By8ASEjrsUqj5Yaj+sS9?=
 =?us-ascii?Q?dGiZp4xPBsXDn+3POczQDlYi6C97BUjPbVagAm8uQKIRHMot9eoO/MGJXY76?=
 =?us-ascii?Q?fLpRoUa1uyFI7J1jhHt9OtuoSK1Qf64Puua9vz06rlnBdZyiE3zuu/0J6fvR?=
 =?us-ascii?Q?awlg9GVT4ObyamdxhF7PCBh3xng2jvo1oihhxBX/E2hsGUE7U/Bz984xVUOp?=
 =?us-ascii?Q?NbWnAXWnBWnj55wmTIUnAZyPR2CHsaHv0/aU6Dz9wUMuYc1Oew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR22MB4407.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iC6iQ6K0a62pR3ayO0Es1f510roiynwptRNq/s0uQWr8qshspeJJL1S+guv+?=
 =?us-ascii?Q?MMp+SHLwExTxFUlsy/B30EVcwW77pBikI45Nx0EgGSSuVNGCEyHgbHz4FoCe?=
 =?us-ascii?Q?ORdPev428hyugu5mpFrtrsBlTJ9FM0PWakdWHtCbNv0Z3WXJ/4Z8mLvX7M8U?=
 =?us-ascii?Q?hhu/rJbhuwV6m5taYIH3JSs0tovCyrHtYX9lPy9WiS3f4g0ODL2UNqOhHWMF?=
 =?us-ascii?Q?dgHWXbhG68s7O8uiP1mwRNbv9TpuoXrkgIivTDuQy2sXg7NKRvYL6dH3DpjM?=
 =?us-ascii?Q?YN9ntt4HpWyP6Zn6+VOIwUknT5kdfhZV2AJCCY2V8Lrv2ab4ul/00VCtD1AM?=
 =?us-ascii?Q?ON7cbjVdH/IIrYUzT2GA/iJvIKuEYecGjnj5E5hcAuIhB3CQnYul+4ji9h87?=
 =?us-ascii?Q?TwTQbBcjnM3lJ1LDq0wDz5AIbZ1VRMrKKEPWcRdQxvfq939qXot/mCXHPhOj?=
 =?us-ascii?Q?09gblHcSQPNKkvDWhOBTv6w8s/H/6hVD1qX6wTGgI1CztBG3A9Mi4bvg7gW4?=
 =?us-ascii?Q?12c8uuGwI6FsWkPfAfs5ukMs0PinxpWvGGLaP09L4Z9zoQSqS2Cn3FbbtJpg?=
 =?us-ascii?Q?RXVL57y9vTBWH5ArFg3Gr9T5Oj4lrxnXiubKpOKu8nuHYUuDeNwVXT1sfjPB?=
 =?us-ascii?Q?u86MPdHW62bgSe/qx1gyFXzNTtvEHT5m3DxDwMtHW14vEkhb1yD9ndYfOQp4?=
 =?us-ascii?Q?x3yWunlGzfClN0c72eQ00v1pccC1C94/3FFcL69UfYxe8WEWERQVbR/2xsJ7?=
 =?us-ascii?Q?PlZgH3Mp78tLv6l9VE5KAc6wQWodWT8/n4s4I2fs4nRGKjaE0jhmfk5O4q8E?=
 =?us-ascii?Q?T4tn20PN9Nqr+kDHAD/DRDab+nhIoJ6Az8H2YZE+txQKc2/Edb2vDKvmLQGL?=
 =?us-ascii?Q?mwlMTfRgxb8ERvoW34ceMaH8+twia7VICpdKgKzqu4eGOw1e7TXCmqV6ctzA?=
 =?us-ascii?Q?ymLj+lN8KF+D1nKMb2EsuRxoGeCUmF4x++9xHgNBCYEcd0+i0J6d9OSXLkME?=
 =?us-ascii?Q?yilvBYmcWlXmxqABIydHuqpsLwoDgAWnm16Tx5620cRlJ62Z8inMv4sOyuOm?=
 =?us-ascii?Q?1/2MYvrQm8T23HCroiNDquje6wHPidDK0ia5cQDpA1AzydHDBoDfr14i88MJ?=
 =?us-ascii?Q?IxK8pPBU44WA3b5DdlKkU/2vKpPCRzoV/vYRfydGWcWb7JRE8QZ8E+tjF51X?=
 =?us-ascii?Q?qVePXeFeZ5DUA3Jcf6yvbr3cbmu/oB/2lZ1VIzBSiGuA66cNAkdE59mIJe5n?=
 =?us-ascii?Q?3TAwqKeKcMSEouxYw44yUhlfSWFtIR+NR6xlaEuk7DIrZJTuHfjbm7Z/OtWi?=
 =?us-ascii?Q?RwOFtJq+BMo2ZuS9GBGc7eQ6C9UATFuFf4OpGkq6dngckuQ0YLmBCgdlpQNm?=
 =?us-ascii?Q?aBmM3+xX6uDBcfy/wH4fShfhzL/+2R3lAAoBU8tDSlz+z0/48XK5W1n7eyjk?=
 =?us-ascii?Q?OKDzz8Rb83Puv2edBZHPgAd7P/o84GkJGoGO9f3PKRwYm54gdDS1/jNwCby8?=
 =?us-ascii?Q?08Bps6GMCv/KLAl2ti5j6vk2DHYXzJkgkSBdtr+QROXHeYdujVbC9GftUivB?=
 =?us-ascii?Q?TsgnpkwAWdRwwoox6b4=3D?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab76176-550d-4927-cdad-08dcde5bf536
X-MS-Exchange-CrossTenant-AuthSource: CH3PR22MB4407.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 18:49:31.9037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gWNb50sH++qhDY5r67Y5YPvV3x9Bvr3DKT2dMEjfrVk/3/1CXnr9FQezPgDk/sS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB3505

The bus-width property was moved to k3-am64-main.dtsi.

See commit 0ae3113a46a6 ("arm64: dts: ti: k3-am6*: Fix bus-width property
in MMC nodes")

Signed-off-by: John Ma <jma@phytec.com>
---
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index 60285d736e07..73b8df86b16b 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
@@ -423,7 +423,6 @@ &sdhci1 {
 	vmmc-supply = <&vcc_3v3_mmc>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc1_pins_default>;
-	bus-width = <4>;
 	disable-wp;
 	no-1-8-v;
 };
-- 
2.25.1


