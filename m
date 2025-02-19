Return-Path: <linux-kernel+bounces-522301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333D2A3C874
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 155DD7A64C1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E9F22D4C4;
	Wed, 19 Feb 2025 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BkuOlkcB"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013052.outbound.protection.outlook.com [40.107.159.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D4C22A81C;
	Wed, 19 Feb 2025 19:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739992895; cv=fail; b=CHscacXSmrCq3CsXAU3WDjSOlsahL9MtMhfSagTcG+Q1gxXlV9mFxraH2oKfUZbPOXT+nGjI4b8njx2Q6Y4aEdeL2xhGrk7TQ5oMZkMRdLWGtrr9jtepUdJ8cHU5fCd/LHzal7WJfWEgJnXdaCU9NZlcWxRjhLiyupye66ZniN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739992895; c=relaxed/simple;
	bh=VPczd2TbssELy4LPMIHcWz9fANCE90vEcGYwOTtjwhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cH9utcyMUvfEi+9/qx8hElK0Bj0imgyGumDbw+dF1EqyDmumeGHDdBYP/1WEr5m0FvEMDS6w9LNhsXBVpktIxlI0/XfM8Y+exfgnAAVs8kQ+sxISEbngLe4lXpUCnnA0ydDOquF2y3Lj4L7Nv/POzhCmpX02uhgX+Es8dhnfJSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BkuOlkcB; arc=fail smtp.client-ip=40.107.159.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iq3L+2WMVQDLJkJFewqVl032p9NQiA9oQuyD988VE1PrGFr/y4nQ1F9x+7LW4mtzl7AL7br8QPahYxGGpdAHbF1+mij5fa6GRI/yj8I1VaQoMO0udBFQU0Y/xj4R72b87baRAf+odEHTTPk44YtFAcaDT3GUDqj9f9enHzWzFbg1MBp0ce1T5+bmjlxoi+f1f/Qmw2JKZYtg1jIYHpz0oA6bceAQ04siOLvsMApDYlwnj+HcnCT0e9zxX7M4nO9qx3HRFkNwpe/R+C5ot6aC4nZacV2LDfSdldDW8JCVjpQIIBeGIkurX8QQ0Iq9VAOeRT/Ttk9WmZhVb9F+FKjj/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOI/CqsTm8xO1oLfT5osng1WvEF/33M3176ZLFNpch8=;
 b=ispR8bsAjsihohxW1niyC5/iXdR9fVXSXCm2MzBITMlMY5pDlc+NCSNDZB9Thh0Mqkf0ID2BQu9sW8wUXfHSpn0ZtQ3z4mM2sX2FXA1eMh/qFtFwVie1tsqpYFYZNPTdJaHDtT6FWl7q0MpUss7Kv6N+CiQCr4FMAhnLkPwezB1cnA2vPwxVTNIKVgZQwApwB488dPrNydkOTVc/fzg6mb4he5geNffWctH/TxCuK+Ig6equujtcrsSenPesZZb9uNQ6XIT98WTF6Rn5zOrhzbdBIu+7Wk4/vXuS/evZkvbG3+r8YeKZL0CnY9UcW0zRm0GhBDKSsiTW5Ysqnp44vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOI/CqsTm8xO1oLfT5osng1WvEF/33M3176ZLFNpch8=;
 b=BkuOlkcBgvfuFH0nq3qVMDlJdpZZdlcjyg2pS6QEC6ikJvmaQf6zAjO+CGlQzft6MoL09dwIGItJiv7gj7jDNjSEsj8QEhPbwMLtQ3R8EeKPN2Q/nHzGqp78Pd2C2ITYDXGbMxXMhOS+KbcHrFnzpJ3500/YVd+umWwNbjY3ibuazwgiu1K+FH0r0ZddVzc9goqr0x48oSlseSYijPJH4OWm1MXfwQwahcOXrzZZXi2urPlTkOkgjgA7i+Qb7jH5ZpDFjZxP37MGCoJPWU03KMZ7Y1d+lQXhyWc/CLB+cRou6s52kOVSEavbm4ug3L6GPdBuMY/EcHcJKopO+LmuVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by VI0PR04MB10951.eurprd04.prod.outlook.com (2603:10a6:800:25c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 19:21:25 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 19:21:25 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: p.zabel@pengutronix.de,
	robh@kernel.org,
	shawnguo@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	mathieu.poirier@linaro.org,
	shengjiu.wang@nxp.com,
	Frank.Li@nxp.com,
	peng.fan@nxp.com,
	laurentiu.mihalcea@nxp.com,
	iuliana.prodan@nxp.com,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 3/8] arm64: dts: imx8mp: Add resets to dsp node
Date: Wed, 19 Feb 2025 21:20:57 +0200
Message-Id: <20250219192102.423850-4-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250219192102.423850-1-daniel.baluta@nxp.com>
References: <20250219192102.423850-1-daniel.baluta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0267.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::34) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|VI0PR04MB10951:EE_
X-MS-Office365-Filtering-Correlation-Id: d30435ab-8115-42b0-138e-08dd511a9a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qiLugfzY/CUI9W2jrFDD9Pi38Dnpjb2PMsoSPx+jOB3SMVurjnY980GPqbTe?=
 =?us-ascii?Q?7EQ56KPOXC5q2F7CdK6JYbZW7DYy+BnMpG41GKLN7tyCK3Pj+/ETx2pQxMM8?=
 =?us-ascii?Q?kam64AmQNgLhwVTdORtt10wjH+8rKNBjRfedJRZfQ6O2NpaW1v2r83M5gSdb?=
 =?us-ascii?Q?DsFiXCBrQxIRCiFGtx3FuqGZj+y0rSTtRtscSthweoqteIdUIouIeML2MnKV?=
 =?us-ascii?Q?jiBt0lEaAa3tAXIjswgQemJTxp7nICG5FsLep1VTp+V71AeGjuxvgGbGiVjb?=
 =?us-ascii?Q?JuVubLvb6sWx7PcruVZG8O4UygSaBMCGCCaqhqbXqMGRDgh/XbaXS98vrCxy?=
 =?us-ascii?Q?+mwDUeNmKVxdFZBLGGgVVRwHsbo8JZaFCiqapGgFEBeojW4sW2X4ZYrRFhp5?=
 =?us-ascii?Q?IJkdLZtglvC4c+spOmUGsBZmHiSkYVM3R3OCid3mXxnxhKDHOfpsnaBpqyKG?=
 =?us-ascii?Q?OPpekJ+kIT2ie0pxCSxjPHsvA9+b2WWqGK3z5gX1PW/oPkWVpLevfLrpu+eM?=
 =?us-ascii?Q?YiuOF8eJx8mIolX2Eabw/FD6dy+PB+OdbKgYTzRH1VH0MIRX8fZt2WWI2SLQ?=
 =?us-ascii?Q?5GYKhpAcoeSQc09K7/+KjSyAD1y8thSZjwsw8yLqRo955fY24k6JPeP/cigK?=
 =?us-ascii?Q?xTyX00d/2fpAhrzPjYpUVrncwckeB7LRBw23vVtXh8KxVU0b11H2m9nWTVdg?=
 =?us-ascii?Q?JxNiSJZ6xVVb0S+nF3/rWHp8I2kONCTiJG7ibJmeClJw3FV3qbF4BtRTNgmE?=
 =?us-ascii?Q?WSRDvU/XJEtjz/mpGokKtKyRvonB4b+jUIYv2YcFXGFI0tjY8pZedEbDcxPz?=
 =?us-ascii?Q?7GBkiyGXer6F1sprk+xJTSvzyCI3WWVQqrwZxyMAsgEtkzxufqoCJa1Ib57s?=
 =?us-ascii?Q?wW2egZenz0dxD3CLVtI8IfypPUlvbfYvhQzMZoPKUu8/XVaikGUYRw3IEHAY?=
 =?us-ascii?Q?sWuRjSWzB1C7aOPQN9+wdXAUaXVvBepgXI8gZiUh5SLjYPttbmsB8QJfJ4CE?=
 =?us-ascii?Q?i9RD7WMRc53wLRwRao/KFCXgp6CooFr8BsA+KTBdMqgxPhBoJmt6EQ/4spkz?=
 =?us-ascii?Q?OZpnSxJXXAg2HnGuVEUFtVoRqZU90b76tkIg2W2XCuKv1OvIeRdxetBDozzA?=
 =?us-ascii?Q?J1pQc4TyDc3CaFOE3hKfMlk7HrMUUTpWKWn2jFArtu7bT7IUT0lP0z09Ce5q?=
 =?us-ascii?Q?LCvMPGFaS5iEHJVrLNC0AdO2b3tXOnoNQv2emH7lsjoZHWktF8grx9twQ5cS?=
 =?us-ascii?Q?4Ix+PHMxoAQ3JVD4T9Y/Z+CIA/t5/7owdN3HupvdkwgIMqsj2BBMr3VLCTqx?=
 =?us-ascii?Q?n5zHtygMLOd2ab0PqnRLGO2AFNjz8G/Rf0Jp9zH8m7PpinJTJyaP7RtmgaKb?=
 =?us-ascii?Q?kL1bxiN3Jqf+JUMTZd7khD+DOWiM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I3Zn2jdlajxJGl9yQXeuix5aV2FpzzdKI8pw3+ll0zSiUOiPs5qp1IDS/YEF?=
 =?us-ascii?Q?ihvG5jUddxm8WwvK1EbKX1nm4JFTbmS6YjeXlT1EOYezjX9L8LLdNUbiBOp7?=
 =?us-ascii?Q?dx95533eTehfJco4HrYO3Tl/TqQMlXxYiIPgZUxcx2szUoD6MTMhWR14AuwL?=
 =?us-ascii?Q?QfMe2vz3tSnc/bLH2awMxKReWGvddhCG6Twv2g2144zzeJ4EuMSu0oiK5/wU?=
 =?us-ascii?Q?3YSBJrZ3D2XIuO49JjW3NMGhh/CiU6hWlEzFuS9uxlocr4azOoNcjkby8N97?=
 =?us-ascii?Q?S1EyxKMvp31aT7FmyiESskbRQGII+JIGFuecx1ZpxESzAov77LSNcKKOHjSH?=
 =?us-ascii?Q?x1K9DZvf+jB4mSjgtiZ4DqB09bRG/rQLfK+qnlSORsgbAik7AtDxKcwt8EIT?=
 =?us-ascii?Q?6UcSmA0jYU/hMYKk8HKcZX8Nj/ujF5pLjF4OcU9AFJE7AgQbkYahoyDQecb/?=
 =?us-ascii?Q?28mKw399V/tqyUuJQQdJFLaAqXNF41HLGqeGh/OOzQmFqyjXSaDYpBf9dozn?=
 =?us-ascii?Q?OxEqpwXc2kuGFVzZvI3h+WSDw7aZV4FqVzQrIL7iZsh3lvwWt6AkwaulTrAa?=
 =?us-ascii?Q?/NmN6L37e6wYap2fB8LKA2oQMDl1Zxbx2eKbncJOEMK3zBYGH2SA9ln5dAWo?=
 =?us-ascii?Q?sU2x36qD0Pbmz0BXj+O8gAFQlQNl38BWWbuYZLsO/1Jq8OaGoG0uxpydjQVt?=
 =?us-ascii?Q?IPAN/8uJMX6e0I+wYd++as0jxPEbfTUHaRWmLAr0Mna1OVeR6UD5GpSEO9NW?=
 =?us-ascii?Q?28XfDbE/sc23m0Jw4cCxrp+bMdh29uwlycahQ9BnqlgwsMySS0jW/VTZbSnK?=
 =?us-ascii?Q?YT7bWYUERourR9zYcKDelDLrJTGBu6rQ6Qx7G7/nu0/qBRllnKMrP5KQtsEs?=
 =?us-ascii?Q?2Gyo/GChlCwTN/18EMyyGGUO8g2x5dMuePQXNoGDTjsqOOvWjVsE2Ec9fZF1?=
 =?us-ascii?Q?bpPYDtx1F51AM/Xz3YsIpliWaxVg8S9I6yNafpztYvjTduM9eZ5/mwvUOt/C?=
 =?us-ascii?Q?lIqA/t35ywGORw2G/eHzPJUnlUNL2UT0FlYgwRC1v1hejf/CWtfCTdnCq1ao?=
 =?us-ascii?Q?OOxhsP9187RbUpSe5BPIef69pIKCrr014n75O2jxpqso63y2Zwujg+usz2ar?=
 =?us-ascii?Q?eyT3nVUaxe3kxMToMsHCrPQ/MmFZGPm1lE2AQIPDF/IsuiTvH8M4vuiaw9dK?=
 =?us-ascii?Q?bIENnrhHpVd4MkIhpqfCAWAM/ibjMeubKfCsSnsUgFufMggx8AI3Hy+6/H5l?=
 =?us-ascii?Q?g+ahRyqJDS5o5v9gAUymNIbpq3Ilzg4DDgIZ+Inkw0zAFBPYSHMD5J1TvwL9?=
 =?us-ascii?Q?2eRWftFmuzs5uWFfK74eLrhokWHYyQ/NwUrRAq09M+rP92JZMZMcaS62A5P3?=
 =?us-ascii?Q?4g9XDPH/GWh3Vl06kVPUWc2ScaP58rR8v+XiqAowtaz1TIcc6Ql+pvmohtAH?=
 =?us-ascii?Q?L96wvKQKpJygtWXzLNIUHDNXEwbe3iMUWZVwUJRKijNh2DxKXJcrcDe19rij?=
 =?us-ascii?Q?b/nNDu9d2XzMLMPpIwAXDxyVyxGbJVyUXf8wfT14qd2g/f+zbtkqBPfOthBb?=
 =?us-ascii?Q?RYEHTnFM3DYiv0PwEPiLYNLiYxhSG+OMt4tSWF9d9jzyYvDscxWd5xYRuuLm?=
 =?us-ascii?Q?UKcI/fAQpUrDdAkI3vYNEymcBWA1iCsTM64ZRywuvejHJ0tX/BafIVLDKPp4?=
 =?us-ascii?Q?6tRJFw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30435ab-8115-42b0-138e-08dd511a9a01
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 19:21:25.3035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VLbtIrv3Vz7nlZfQ8plTs347YYTFsetPUQ11Aewn/OI6QLkUaYQw9lMZ/F+1S8F0PSIPndKOQ/xlP2sJzEN9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10951

This change adds resets to dsp node in order to be
able to control the dsp run/stall bit.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index e0d3b8cba221..780245d4ce61 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/clock/imx8mp-clock.h>
 #include <dt-bindings/power/imx8mp-power.h>
 #include <dt-bindings/reset/imx8mp-reset.h>
+#include <dt-bindings/reset/imx8mp-reset-audiomix.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interconnect/fsl,imx8mp.h>
@@ -2421,6 +2422,7 @@ dsp: dsp@3b6e8000 {
 			mboxes = <&mu2 2 0>, <&mu2 2 1>,
 				<&mu2 3 0>, <&mu2 3 1>;
 			memory-region = <&dsp_reserved>;
+			resets = <&audio_blk_ctrl IMX8MP_AUDIOMIX_DSP>;
 			status = "disabled";
 		};
 	};
-- 
2.25.1


