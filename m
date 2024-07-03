Return-Path: <linux-kernel+bounces-240160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3347E9269C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57ECB1C21963
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02102191F6D;
	Wed,  3 Jul 2024 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j0FZGDKc"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2079.outbound.protection.outlook.com [40.107.241.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2352719067C;
	Wed,  3 Jul 2024 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040346; cv=fail; b=CqBqRO9IxEnipCTVy4kbaFdg26Nmw7hy/io5MjcvkIR+3S/ikXKvTHgLZA4FSTXmk2XOUcFXsYEmQI3I+20z/1gZuYCJsvNim9plCH1mnm01K49MKQEH7yzA5fDGLKAr0rXUEALMcdTXE2E0LNtRAjrtDNUIejq5ZT6srwhkGk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040346; c=relaxed/simple;
	bh=4csaDRCdreX5toFBhXX3e4E7iMny+I4z5DU6qVJn994=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZjHUKR3OrkfKb9FATUAPYYwe1RJidB0TWg6fQPa7ByKNCZ7MV4/2JYVmaEkA+bIDhlDIUVmu/xeGzJ15RAwzq3fj0L8RCrMbutTYjsgQ6CY8HpZ0t21pFp/5lN5VUaWG2UNdnbVptcB4uwgR2B13sZk5qwBVddK2DnutYBypz2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=j0FZGDKc; arc=fail smtp.client-ip=40.107.241.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekj06o2cforzLgXp7G4ACyEdJ/oMTMIR82cgmArzaI4HB1rpVUR/vXOJkVqLnwWNTOxK8lcNo+moseYCOb0fpzX7oqJTh/LCaDwtoh7SXd67ek4j+W2vASqsFSaFCxlVAX2Fbn1olRC0vL7rcPeefwfBU9yi1SJ9b1XIstHtX92m+vbqZxG9TrCVWHCCkF8WJxh4GBYMXMHF7bledKJxygLdeshKNQIb5SJcykGalA8uoNrRqRfYmrvm43do0sbn/ju+lL+Qlhw+0x9AVJN6BG0smMJrJ8rEdBMZDZLjOM2DK7w4nF4Wb2dKxkuhV2R6OKavODQjvtOdJr6w0gKOnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnBI2GFCIJHl81+E5Qq+M2L/MY7qNQjvoHyWNx9ZF1o=;
 b=BUJQI1JEN5VOLlMzv/d7SHTW4iSZxupKOxtkfSRRN2bSVi9SoNz9wejr18VqRWPkMTroyp8WqZL53qlysrgbqIXj0j9Hlsh+IlDTuPqwN3xhM3diWF4+0MD6qMV2USW995vQJBqxCnlS773YhQqhkZUhEtP7evGllmlBfkcBUVUOawI3dffihxq87xSaDz/xJTrYEm0un0tIhADmlrQFbHaZ94kHSBpkqaBvzxOkUezu3JUllsLRWghrn3j2G2bf8ugBY36qXejLg5LRYxMVxxbQnV/mdVAmomfy1kkR7gU5k+C8p2/SdWgBfHSP9UBltui/9KKYrpZgh4ydhf36OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnBI2GFCIJHl81+E5Qq+M2L/MY7qNQjvoHyWNx9ZF1o=;
 b=j0FZGDKcfmIKdmT4MrWRcLPv4NuZiTlAFXopfUVYM8hd9IE+QhgXS3Qs65pVW5CGjdF2UDQkdsvrkcYo+0HD7IWf6iFFCdfzPIibVbi82PITHvkTkMWW/f8XHIx/eHtkLle7TXR42VuK8m7I/ebm9+nJiNPlN+o7G/G6im9UWlI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB10049.eurprd04.prod.outlook.com (2603:10a6:800:1db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Wed, 3 Jul
 2024 20:58:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 20:58:59 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/5] arm64: dts: layerscape: add msi-cell = <1> for gic its
Date: Wed,  3 Jul 2024 16:58:43 -0400
Message-Id: <20240703205847.2826263-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:806:120::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB10049:EE_
X-MS-Office365-Filtering-Correlation-Id: 19dcf332-b4c1-47a7-2e73-08dc9ba2f610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RrxAjKPgm/BnWdACQXx/tGvCH9t/bmzpyiJ1KEb9xRdnvhQe2SmOAadKkCBF?=
 =?us-ascii?Q?MGL6aRGt8vAS4v/A3UTnHX1qrA5u14MNWtpfm2AVl1GHpZ4xAEao4KaMR3ak?=
 =?us-ascii?Q?S28X3ejAgzY3lvcj5XYwpjhTMSgcw81fqxAEJi0rLYfhQKx6ULGUjtVAN+3o?=
 =?us-ascii?Q?ssqriDwdro9023nHSbJbW0LNqN4FY0+qpwEy1pyllsIqt8DXGOd9TVt3Tdze?=
 =?us-ascii?Q?ZgFcl9Sk1W64Fsa8fFe0si9yIoK4mItF3RAgr+4VWAFb88QziDYYDvr3DFmv?=
 =?us-ascii?Q?BN8TG3XVxxVnFbbeox0UhmFce5xdvW91YSCPRPNGvZ+5cRP4yCAgICayq3i5?=
 =?us-ascii?Q?UGIUMzrC9mLIzlMPr6Sv+aAJXvnHKKUtRF83+FFIeCbh9VsWYlT+3YD9OvoC?=
 =?us-ascii?Q?sy9Pl0nGXNf9JR67t/7Lr4SB4cAr9mtescue8RJpwVy+3SGuwM6HR6+4AchO?=
 =?us-ascii?Q?8HNW5F+bZMwz+Nhpvva4LdzjJ+W6XjJPFirVjDG3RkTBMgb4/nL5TRVxWSxo?=
 =?us-ascii?Q?1KB/jLLURuPIQH1gHyR8jPR0KvA6cTz489x5p6g6VltdjJu4xQX41zYl3DYT?=
 =?us-ascii?Q?N8bEfBdz1DXAsXjhROT+fAtf6uKr0VbNBsuW653qI/ltAybPn06msNnwEmEv?=
 =?us-ascii?Q?fcEZTWxwTVQZgom2av+e+PSQHAU0UNYKM+PFR0DP1/xQusNZbJB/MTY1k7DB?=
 =?us-ascii?Q?Gq0Nh6Z4GDitl4iwqbgMAHYckCzErj5Y1tTTll34ZfPg543X9e8GC3QdYJ05?=
 =?us-ascii?Q?5FxwThiTdOuVvev/hg2QcHeQVWsWLc2Jehi/r0Zt6GgiOPW3ff45eRLbf38S?=
 =?us-ascii?Q?Wh7/E84DA3oxJopTIbg7ndNjW3KHNg2HWYQS4MYRUGy9FpsM8DP3z0s7f6k0?=
 =?us-ascii?Q?uCJEr+eLDP8DcAZOb6rYfqUXmM+rX7+bk2ZSg1osJWzzmxC1ljZk5HxhUK3u?=
 =?us-ascii?Q?Eb2W66tdxUyr7fWqn069EUpY6jX94fNOyyXvMBfgF4K0z4soRT0Py5i9m7JY?=
 =?us-ascii?Q?+vEkXZ5c1MssEbyplzGH/h1tPBcyOjL8jSMFkid3lyv22BWLG1J7hgcy/7XP?=
 =?us-ascii?Q?TjFfWzPEQIneOoWvpG6owKItMrOITgMU9cjGDyNAVThqKUVZTgdTafUXcunT?=
 =?us-ascii?Q?7nOZtuSDMOT9lkmRf9gTLt5SmghvuJ9LFbD7CvNsWTpMruYUrbB/jpS/rnwX?=
 =?us-ascii?Q?EVGIazP/TmU2nvoiIwCUmz8L/7oNHnmMgVEOueVB/UjsjlYaXMr06uhq0uVn?=
 =?us-ascii?Q?p1czATAhdoZM/sCAY2PrVoR2NcpArfU5Gh0mGcUgU7BJteq1BDAj9Ym7CIeG?=
 =?us-ascii?Q?AcgFx9LyfNhtQuSQpBcZ1L9ZkQh/oKG2l/KNlKF03DwrVxiQeHPbgiWAKgQi?=
 =?us-ascii?Q?Au+pcBc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZNA5fPfNysFSbqRDQlrSyiWxNFHTi3f4p4F4QauhfwbuZCdHIyBSpWAOLY80?=
 =?us-ascii?Q?KfsXxI6UmqDTknJDEGZ8UtNlFdC9gv35WLllnHzhSPnoCQSFlIe3uXRpw15r?=
 =?us-ascii?Q?su44aCQu1IveDU0T/QaUhIEKICnBiTeamaB3r6TPZ9U6GW8jIYNJV49VyQOO?=
 =?us-ascii?Q?AXHRkUkzV8rDA5jZVGgkP5/g+tYJeSRuBE1peR7a1uFJY3lI0QTQ0ZgjCkmV?=
 =?us-ascii?Q?CDgsAoj9DfkLnjhtuSA7J6vp8QC74Wl9QuglE1mOvxT7+LNmlV2IavCCZ6SZ?=
 =?us-ascii?Q?bFr+GEXNcNqfPsAuGN+t7VhMA0VLll/qoUloKP3H+6vXdH93rThpmc8DT3GX?=
 =?us-ascii?Q?Iq+cmXdCETn1gHFE2yOCTNAJ7x2Gbe+pYxNJb1XYq1QoUSTp89FCwZfqVrgr?=
 =?us-ascii?Q?A+AhaadTBhMTXJ0Nybe/uoT89ZLQHKErjMbLcWC8byALIcz4aq3HhVxaucrt?=
 =?us-ascii?Q?lYX+1vTnenYWwOmaEfjSjJ/CWzVEkVGwXKg4nC3d2cDiqiLFky+9tDJ8YKIQ?=
 =?us-ascii?Q?8wGhWViyhux7AlWjlpd9lXe8IhIfPyrTKLQ9kiU8vHvJtmly7HTvVtLO9/NQ?=
 =?us-ascii?Q?bjnzxcoPZE9vl8jqA0AGrqhhknzZm6u1o+11mZ8esUqye7mA/Ih4ALpRd8iQ?=
 =?us-ascii?Q?NY22cAWpmgHae5ll/ObueGw6kCd4vMqln3HVe7fSKJnUVS+M+Syiofx3kmqj?=
 =?us-ascii?Q?+ImqGUCiAG6NE6/DlsUgJnR8aXE6RB6FxWMWM6VBNmNLe6V2F3Hja/d3fBTx?=
 =?us-ascii?Q?DLt/A96/koKHJa/0Q5jkE9WR/5tjAGpqyI4GjeYf6QljGDaMhmfg2KQof37F?=
 =?us-ascii?Q?alxAcyzW/INH8oQTrFD0lbjHEgQ+F+6mRqNq4jmNO/Xw9DbatJVmfrgVZ21t?=
 =?us-ascii?Q?/5r3//eWD3s3t4Bxk9Dvjy3DOY0u10sbE6JAnQ2NbqW9C0l2j/cGSIaiiRPK?=
 =?us-ascii?Q?DWbk90O+8o22nXu+1PlwKaN0x2PqsWShGLwnGRzQIMp39agSGqwR2bcZLukO?=
 =?us-ascii?Q?2lv7PVz9r32LNucESj9QUwkhwD3kwb8O0UKPL6rKuMUPw4JxxlEJWYBe9NIO?=
 =?us-ascii?Q?GK0eCKB65YwkZKe5yEHis5f5YA3OYtkBx0tYA9Qut4BmqXuniFiWAXwIzMxz?=
 =?us-ascii?Q?C0iFgCjv6gKdFEeF1DRdfttgodBP0HmvBaUca8UnlnsknD6IuOC8KGP4Quyb?=
 =?us-ascii?Q?ajubtSIh2qAHA783q6ipxd26Nb4MN7RQaRZVg0K/ovHJD97p6aM1kwXZ5ev0?=
 =?us-ascii?Q?irwa4IPRbJQ+fpiidw4/h9L6FGhcP7Sh8rPKaDUY6Yo6fUqfzDIwciBa4o1j?=
 =?us-ascii?Q?GbgqrM1DlkjFqwWm1/q/un6JaxbniuqS7KGo6nwHPp5Uo63Y3W5A8nmVGEF/?=
 =?us-ascii?Q?srLNqtxQ3r5YKAcpYlpyIaDyrc32jA5hvHxB41k0QE6rOJcfwA8gLKHbQ1um?=
 =?us-ascii?Q?BlIHbIXBAhz0gaKYqsbAyM7z8hGicXaS8iQQ8MWcEvU+bAxnYxgo82TLy8OB?=
 =?us-ascii?Q?Np8yyeXlfTZ0Crjnvg+4XFCR8pvSEVqiJ/f3gYnGPfzbmYHx7i/h9xHJ/9xW?=
 =?us-ascii?Q?i4ODobrmn1yD8JASMcjQFsmLod+JjoNez86wpZg7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19dcf332-b4c1-47a7-2e73-08dc9ba2f610
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 20:58:59.6251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DO6H78joyfKSQy1Oz/nXSdCmeXSe9znQFeoNJDzPlaQuRI9cTKYNIbZ1i4k2I/Tl/OgfM37lX9+obiTgk64GYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10049

Add msi-cell = <1> for GIC ITS. msi-parent have to be kept because it is
checked by U-Boot due to historical reasons to fix up msi-map.

Fix below CHECK_DTBS warning:
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: interrupt-controller@6000000: msi-controller@6020000: '#msi-cells' is a required property
        from schema $id: http://devicetree.org/schemas/interrupt-controller/arm,gic-v3.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  7 ++++---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  9 +++++----
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 11 ++++++-----
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 15 ++++++++-------
 4 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 6b6e3ee950e53..d3f69163ecd55 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -150,6 +150,7 @@ gic: interrupt-controller@6000000 {
 		its: msi-controller@6020000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
+			#msi-cells = <1>;
 			reg = <0x0 0x06020000 0 0x20000>;/* GIC Translater */
 		};
 	};
@@ -662,7 +663,7 @@ pcie1: pcie@3400000 {
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x80 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
@@ -701,7 +702,7 @@ pcie2: pcie@3500000 {
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x88 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
@@ -1080,7 +1081,7 @@ pcie@1f0000000 { /* Integrated Endpoint Root Complex */
 			reg = <0x01 0xf0000000 0x0 0x100000>;
 			#address-cells = <3>;
 			#size-cells = <2>;
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			device_type = "pci";
 			bus-range = <0x0 0x0>;
 			dma-coherent;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 8ce4b6aae79d4..c9459e251e59c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -126,6 +126,7 @@ gic: interrupt-controller@6000000 {
 		its: msi-controller@6020000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
+			#msi-cells = <1>;
 			reg = <0x0 0x6020000 0 0x20000>;
 		};
 	};
@@ -575,7 +576,7 @@ pcie1: pcie@3400000 {
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x20 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x20 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 0 109 IRQ_TYPE_LEVEL_HIGH>,
@@ -614,7 +615,7 @@ pcie2: pcie@3500000 {
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x28 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x28 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 0 114 IRQ_TYPE_LEVEL_HIGH>,
@@ -652,7 +653,7 @@ pcie3: pcie@3600000 {
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x30 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x30 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 0 119 IRQ_TYPE_LEVEL_HIGH>,
@@ -964,7 +965,7 @@ fsl_mc: fsl-mc@80c000000 {
 			compatible = "fsl,qoriq-mc";
 			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
 			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			iommu-map = <0 &smmu 0 0>;	/* This is fixed-up by u-boot */
 			dma-coherent;
 			#address-cells = <3>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index bde89de2576e1..8a6c883379c26 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -63,6 +63,7 @@ gic: interrupt-controller@6000000 {
 		its: msi-controller@6020000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
+			#msi-cells = <1>;
 			reg = <0x0 0x6020000 0 0x20000>;
 		};
 	};
@@ -758,7 +759,7 @@ fsl_mc: fsl-mc@80c000000 {
 			compatible = "fsl,qoriq-mc";
 			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
 			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			iommu-map = <0 &smmu 0 0>;	/* This is fixed-up by u-boot */
 			dma-coherent;
 			#address-cells = <3>;
@@ -1085,7 +1086,7 @@ pcie1: pcie@3400000 {
 			dma-coherent;
 			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 0 109 4>,
@@ -1107,7 +1108,7 @@ pcie2: pcie@3500000 {
 			dma-coherent;
 			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 0 114 4>,
@@ -1129,7 +1130,7 @@ pcie3: pcie@3600000 {
 			dma-coherent;
 			num-viewport = <256>;
 			bus-range = <0x0 0xff>;
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 0 119 4>,
@@ -1151,7 +1152,7 @@ pcie4: pcie@3700000 {
 			dma-coherent;
 			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 0 124 4>,
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 26c7ca31e22e7..e7f730d7a72e6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -398,6 +398,7 @@ gic: interrupt-controller@6000000 {
 		its: msi-controller@6020000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
+			#msi-cells = <1>;
 			reg = <0x0 0x6020000 0 0x20000>;
 		};
 	};
@@ -1181,7 +1182,7 @@ pcie1: pcie@3400000 {
 			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
@@ -1209,7 +1210,7 @@ pcie2: pcie@3500000 {
 			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
@@ -1237,7 +1238,7 @@ pcie3: pcie@3600000 {
 			ppio-wins = <24>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x82000000 0x0 0x40000000 0x90 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
@@ -1265,7 +1266,7 @@ pcie4: pcie@3700000 {
 			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x82000000 0x0 0x40000000 0x98 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
@@ -1293,7 +1294,7 @@ pcie5: pcie@3800000 {
 			ppio-wins = <24>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x82000000 0x0 0x40000000 0xa0 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
@@ -1321,7 +1322,7 @@ pcie6: pcie@3900000 {
 			ppio-wins = <8>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x82000000 0x0 0x40000000 0xa8 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
@@ -1777,7 +1778,7 @@ fsl_mc: fsl-mc@80c000000 {
 			compatible = "fsl,qoriq-mc";
 			reg = <0x00000008 0x0c000000 0 0x40>,
 			      <0x00000000 0x08340000 0 0x40000>;
-			msi-parent = <&its>;
+			msi-parent = <&its 0>;
 			/* iommu-map property is fixed up by u-boot */
 			iommu-map = <0 &smmu 0 0>;
 			dma-coherent;
-- 
2.34.1


