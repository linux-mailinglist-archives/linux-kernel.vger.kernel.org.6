Return-Path: <linux-kernel+bounces-231466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 213BA919910
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404E61C22294
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01295194A5E;
	Wed, 26 Jun 2024 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KTaAsmGt"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2041.outbound.protection.outlook.com [40.107.249.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736471946DE;
	Wed, 26 Jun 2024 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433582; cv=fail; b=PUdeV8Sr/rgJTTA7p6+dIKGIvASwPugRI6kzw3gtLtdSozFYv1zq2UZP0V4l8WT6Mt2Cdd7VX4k3rbAJuwil808u8w1iU4J08s+7RThK0bNEYtMkT/6wjXyJP9+4k0pKhNWZfDt8oPoBHRUrwpZybbFCME1i8EtLUUj5RJUQr6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433582; c=relaxed/simple;
	bh=JSXxvGC/3k7fVF/NgeEwHLaQei/5SG5nMc8nyw1lOa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qb35GjWFr6JyX9ap3Pd1rCETwPeNrZjHrB5iXQNt0lTiDq7khLqG+0mBt2OoB0/bMnJ4xp6UPrKtSC9WrpENEl1MjpGb5Fr9FQqUCAQ0AUPilWS20KpZ3z52ltYKOoSrg9etGETuHoVReoauhvGt34sNV0D//tZ/tstUw4FvqqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KTaAsmGt; arc=fail smtp.client-ip=40.107.249.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2uxf336OqDN74pv+HVg7OVb5oaNst3LNjAGrtwzzOptoXsXsly1ZruBgx8PHQvAO7mR5N93msU1/NjOoWsIaUgt9LFNDokw5E4g6NQ/f6mnYya/Ra6VDGqUAj00bZLewooYxvgVtJXFfQf69YK77wEp+xzE7RPq3Vvm0PEPQiK2AELo+G0x2fZpBfnGchQhoTbPlq7ms4nIHjw9KGBxZ+65TQfnovitFTerxwzvkj8eMeBAUu0w7MojOlr46vHCieQ+U/koHdanF6IwU52WskKM7e+xufi2aigoix+gvecRSzaA4BSBDsrUi9QWNSGYfpgrtY1sqbIhyMMh0DLIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fchyGPSpO0zGv+7L8Gx2iDNgYmJjtSE+lZYuKZ34tak=;
 b=lFw8ri4xK2VxHWDq73Q15czj0DxUVCCAyGHcuy0+f86MXKmDgNuYSgWW7E9E8u36UB8QghrJxHnONZDF1qkka1JWUbc1OAAiN7cIg/tB7AfmF4O23YrRzkiOfT9cqrPMui5H1M3omwbYQObPzJDsRPZ9nzgx7OaDHUpxrmuADxQ2wW/h1N3az1hKsxZ3vJ12Xfn/IH33xIGU9YNZMLhqwRhsynM6OKWuG4EuqaILbdKkA3u/r72CB8t+syFZ3nALxdDro1BnC+dAKDcDGy05nO60Ng5Ul1OSgLUy8jlC3uiRgeudnAcW6Nu5jjVntq9y479bQ9gEzY8LW1GlnvGpmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fchyGPSpO0zGv+7L8Gx2iDNgYmJjtSE+lZYuKZ34tak=;
 b=KTaAsmGtsgVIKnysl/Ukmx6netkmfBS6MfuKXJt9qfP/87W7XeqS1FE2vmmEMhn1GeaU5UllpCOEMOFOvgjGooiiQzqYuJXcR98pnsb87DxucDW1SpF2zMzuVLnq30PGthJC22rczia7Yb3Iu+P7LyqRMzR6OcO7uuzjhNU7XHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10838.eurprd04.prod.outlook.com (2603:10a6:10:581::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Wed, 26 Jun
 2024 20:26:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 20:26:18 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 10/13] arm64: dts: layerscape: rename aux_bus to aux-bus
Date: Wed, 26 Jun 2024 16:25:30 -0400
Message-Id: <20240626202533.2182846-11-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626202533.2182846-1-Frank.Li@nxp.com>
References: <20240626202533.2182846-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:a03:331::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10838:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e8a885-1bde-4519-0cba-08dc961e3c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r9NAnCe5UYFii9CMwyWMNwm5O+lzy3zlycGRjrx4xTHCvCASor42wVGUNXx/?=
 =?us-ascii?Q?ARY8Jzn2cwPFh+HaS9mbWdXVhP/NI2v9IBFcWW/RrrL/QlIDc1Dk/GEgBsz0?=
 =?us-ascii?Q?I5xWjwLUTdD+WfkMT2a/Wc+dLRTU6Y5E8B3uzidqwDz7+6GlyHMOpNtHw0Lt?=
 =?us-ascii?Q?L4zNrmLgHDPae0Yy2c5E8Mn5vfLkLl1xIDxn0bZgtrPZusS1JkQrg6YixHQK?=
 =?us-ascii?Q?eDLsRkaugsv2Sa9xuPTTSO4mwkcJ7DgpRNH8YfmCc47v3nc0yXgvQg7YTGQs?=
 =?us-ascii?Q?L1xlUS4Fd400zHK2fQN08MNwbtsQcGex9xP7O8WHZLvW/KIOqSDnvNy0z+9I?=
 =?us-ascii?Q?NUq7V5mgxdGN7Yxky/VnE4/TR0fIATHqPXOx7pY8LhYu6PJSIr6Lk+zqKw0Z?=
 =?us-ascii?Q?G7rO2gWiAJ45chpsiv3b5DVfVwgUaysuAKULLmfl0VcH62+xj0CediRrMKPF?=
 =?us-ascii?Q?stt9avsNbW4xF6aS6w6d+528QT8MKxp6QOg/+Jsx3ZTX6z2ujOA9ZxJSavk0?=
 =?us-ascii?Q?vsDvRnHMVuJ4Tv6XuRRoeJTI5hqbtoAr0yJNbRizgnF2hHeqVPqWa8l1G2be?=
 =?us-ascii?Q?6ZSoSrOAVbDbC2bFNSL28/VGm2tSkl1S6NFt7xXYOidms/hkjF0fqHzU4bYZ?=
 =?us-ascii?Q?FHuJfFhlYqnnymZ9RScBj8jDI3UF3pJt/GFtCL0bKfENL21fL+g3P75H5gs8?=
 =?us-ascii?Q?mPyoic8l1D2lE46ExG9YOL1s2iRolCVmEwntupVZRhbUNZhJW6QAL6zTlWpf?=
 =?us-ascii?Q?FPv26AhhsA4enBsfRoXJi7IDYVZTQ3H+MVAqE/AQkvR9Ka4BPhBC2hauiyqR?=
 =?us-ascii?Q?6Dg0gwv35CpRNgHtILpQgTdRaF4eEUdDNjY/8mlRqYSei5sbPQ8gku4dkD5n?=
 =?us-ascii?Q?M5N9fIipmp+kzhObLRJFPFmJcG5ffMbtJnx/uUTbA2fEG0maTV8v6NxaPNDx?=
 =?us-ascii?Q?+syH8fEzABqzb3R+WsEioFNsvYHUBWOU9AxTJ0iDEiJMXOR5/TH46F6nM2JU?=
 =?us-ascii?Q?bAkdrPfAHv/k+h9pd1NozEfs0kU3DHhCb4Rx35P+ChaYiHDkCjq2iV5XHBYQ?=
 =?us-ascii?Q?KcAY3pf1bvQ9ksCncl9ZseDrkoGwwu4xU8yggm17NtStyxdTs/ouNDCyk5NG?=
 =?us-ascii?Q?ODaAVj7OKViS4atUf45nS5jAXTeTh+T+YRUPfyh4NX9s0+x4yc13+vob2nqN?=
 =?us-ascii?Q?pneV6RI9hKQ8yl1WHwhl13cueq2JbPEfbCAIJsPAhnBU/4Ruln3XJkBiBQZ7?=
 =?us-ascii?Q?5qkeqpM4mEkqWF+pR4BJyVUJPcy5QO+JhoLQvpaXvVXyYV9qzgdJpVqwn9zh?=
 =?us-ascii?Q?AiyPTdbcHZOLfUGjHKdCKt6V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xeZSC8MHowWwGUc1Ti7LKOh1YEXBHjTWMUv97NQ/DeTL40Ovo0ko9wYSP3l7?=
 =?us-ascii?Q?TIBPU7PgXV72l+HXKVgBV90gbIwo677mZOiRBB6jFR6tGiJCKJy+NokVbwd8?=
 =?us-ascii?Q?bifmHT+nc7fqitGhZquoSnsY2XycAOJIoOh4xw+F2GmSwnEt2ubzEnHtu0aE?=
 =?us-ascii?Q?TwnrsxKD50U5UYZvfUKwqbobkrOUzteLUM7BlZvwzRND9TrXCLo0zogThord?=
 =?us-ascii?Q?L7beXBprDgz2JlShGt9RaQPTBK3v1oCdzjAlHhg5TiLUVQHjdaRujBBxUwky?=
 =?us-ascii?Q?Zc3awHmB2eSlepwm6tWbAvISJHvgq0M2fjS50rxgc4YxKhPZpvrTUBDwdYOf?=
 =?us-ascii?Q?Qk5YO4KN5w2+qynYUvLW9fyYgMCph7q71UTjlohFT+8Bw9ryhwfj4NgwwcXy?=
 =?us-ascii?Q?PbQbanco4N7nzdS8o+I4cwPSCDLkvYBxJ5f2zy37WEavXage9WqoMVu7ZVVi?=
 =?us-ascii?Q?5nCVfoddKOhBeUtrNjSNoXd1CcAo/pqOnc492WvK9M26sd4vp7Yr6vts2dbB?=
 =?us-ascii?Q?bbEp4bov7HV/GyjvlS4j61YOxLJHkPnucKMJk7vDfUterPpt0vxD3LJoR4rd?=
 =?us-ascii?Q?u3iYeJRd3TsHbf6lDLeq7EFEMfuIz1QQioLLm6VCM2+xaK0CZXgtZ3VlPbZW?=
 =?us-ascii?Q?B6+IMbw214BzpPKkfZdWRp7HydwExV+wJJRoYeGsc37z8N0tJGTrOiZ38/Id?=
 =?us-ascii?Q?/P6yzvSUQvj1KutWzfOH+1y8FZSxoZrrivP6wUA02kRD3CNJVr3gPd0IUtld?=
 =?us-ascii?Q?g29Caz3B5Vnf5/b427G12nsz8oEqixKChRs4Q4YE4YgyYsClrBhdi38NsawH?=
 =?us-ascii?Q?2JVTk8A8IPuTeQw0yH6hsOIwnisWJMwwsmuY7jiSK+mDPk/GPRzNqicjU1I1?=
 =?us-ascii?Q?6zt72OQsEwsMyRBY4Jeyo/DVaBXAHPVJbKCGgGPyoK5G4J+Fwxv9H5ituNfd?=
 =?us-ascii?Q?m7ZQRFc95z2XHBooPBlJjqSue0d1f7eMqqgR/pSPknSIAsZ41rbVMk7DIKcB?=
 =?us-ascii?Q?v2CNzTSI6QMJXDm0MYjcBuWbVhe/7DLH/l2ZzGD/I6aR6zVvTLQ04DlKgzPO?=
 =?us-ascii?Q?wxxzq/iVwyX2BJ9Zu/SmSl3b2HOAq9wzuhOEte2V1+0hv89Lu486yYdCB29w?=
 =?us-ascii?Q?SaXP0A0qY45+kfA7rN+NDgKQwdbVuazWCEZjWJjbwHL9uhjc3HatHagQ3yuw?=
 =?us-ascii?Q?dRyg53vd4+8IHtClIv2Fo6kVaeSHF5XbQTmsjiJ27NYl8YwEBjN7lZPold0O?=
 =?us-ascii?Q?0ZC78CaedsvU5KmKFpWwLX3Yef6XgX319WQiORhFgdRv6gEUyS+jp+VKzql7?=
 =?us-ascii?Q?c/j71swkA27BPWcS+GdZvDqrhVVhraj02Iq4e/XFpkqYSFj4Z5j0awW4kPp0?=
 =?us-ascii?Q?TtRn6YOXd+D4gTiq5ZXsZ/nW7E5eOEsdARE5/11qjlHFAv/j9VfhCAM+GWIP?=
 =?us-ascii?Q?tSxA0cbb+1qyERViy0uPx9YjGb5D55IeXXtml8lxHUptVv+8g/yXmAJr/eLl?=
 =?us-ascii?Q?Xlmv0SSWQK4a++9K0s5cbPxvqyTGwGkCmBuKP7jKxq7FBDRP9BsFu4Id/pV8?=
 =?us-ascii?Q?f/2CE/wvbGAk9YlcXoM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e8a885-1bde-4519-0cba-08dc961e3c58
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:26:18.7108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRor3FR0+jnKCaa7nGHq80wEYSCrLLijUvLg0zDX9RFF7hC8X4r59LuRfIHijuRvGMBlplHWm33V2snh1WN2Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10838

Rename aux_bus to aux-bus to fix below CHECK_DTBS warning.
arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb:
    aux_bus: $nodename:0: 'aux_bus' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
        from schema $id: http://devicetree.org/schemas/simple-bus.yam

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index acf3eab61b626..364eeeab089bb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -805,7 +805,7 @@ QORIQ_CLK_PLL_DIV(1)>,
 					    QORIQ_CLK_PLL_DIV(1)>;
 		};
 
-		aux_bus: aux_bus {
+		aux_bus: aux-bus {
 			#address-cells = <2>;
 			#size-cells = <2>;
 			compatible = "simple-bus";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 8ce73a076e77a..f2fd8f984dc38 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -715,7 +715,7 @@ QORIQ_CLK_PLL_DIV(2)>,
 					    QORIQ_CLK_PLL_DIV(2)>;
 		};
 
-		aux_bus: aux_bus {
+		aux_bus: aux-bus {
 			#address-cells = <2>;
 			#size-cells = <2>;
 			compatible = "simple-bus";
-- 
2.34.1


