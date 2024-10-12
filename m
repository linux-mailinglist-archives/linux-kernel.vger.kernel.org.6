Return-Path: <linux-kernel+bounces-362151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E011399B19E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FAEC1F231DD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C548E13D53F;
	Sat, 12 Oct 2024 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cOdnq3JH"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2081.outbound.protection.outlook.com [40.107.103.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88774130E57;
	Sat, 12 Oct 2024 07:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728718609; cv=fail; b=gz5oGwblyX/9QZlaDaHwD4MKLnzNh4j3qUbZzNkO2RhfboFNaCYXjNSktT/APp6Mf2tVDFJP4QN38F9yPUuCmuo/w9MBV00VCd/cQe/4yaI8jLDBt2DdE7WYWzQAfMVnGBHybu5O3lTT6z1VIFgtIPwoPfeMfQtpV7jXOqPoVvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728718609; c=relaxed/simple;
	bh=cdA/xKrnEB6lb2TYAp1ynog3osf3YJ0EM6KZiHja+kM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Iolx1bUisLxnRMnd9aVkON7nw+SIzHzPn2ojc8452zEpagxOAV+J9DqZ9xz+q3us6F7b5dlswa8udH0A61NKgK99dUh1nh0H4VBiNdFqv4MCrsJLlV5mzcT0uDq3IxEagntcX4VbxHzXtWp2MAZUhUFyp/Fp17CJtNKI1ktbuW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cOdnq3JH; arc=fail smtp.client-ip=40.107.103.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uk6sKsZU11WtVbRgpBZP2PgaD/dYecNfX7ka6LtCaNtawUsDWsmwnEVfuB/hB5jsArvQm99q4sfSJbSmEfLJtih9hAru/BWq7OughRBx9CK++j8JTY58zUHschGsvkJX+U4Xq8aGALtkpKmwDdsi5YseK8CRyA9zb/F9vPLl7O88q5nbh5nRoJe2Sp4EieGdTG23yPkOXgAdvR/BDhk1AXikwd6c2GOCqOyyFyzKYgA8BTtcjvqon+fseNhvLVJF77Py0wQpi39SkG42H29+pJm28ia3iQve4G7m121UlAN935hONJR6B4u+4LzOTbu8IT/3T9CsJ+zKudgxFQmemA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PakUKgPebLdmTKolLCYJs5cifQJN3owwREhVsV/LLEU=;
 b=l3kvMC9ypSyoCPXruI8t+9hG0d0JfjRTyFhNmhOsHZtIjDee1215TE0a725vO88oMqxS0Wpu134X4pn49DkYqNV0EW1t7GEqrPiG9YVJstvVIsW5oeOz+Br/XMR48FjTvSyt6YD6u4MkiX1MvtoXWf9BDR7DKxx09S5Ru6THbcNiIPC8Bfs1lvY3Dlm3MezA0iNPwTxbyYxYl0Rn1XmzDhOFLbnH063H1IGx0gGkk/4F+dVDmUrLpWUyyuj3VQfG2HudeYE6gTz9W5zCzONwipbtZN5c7sI511HYM0elIMutS6ErzhyQhrlW7HdyXnxUqqu749uoY0RAVkwNInCUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PakUKgPebLdmTKolLCYJs5cifQJN3owwREhVsV/LLEU=;
 b=cOdnq3JHqDppLI6fiI7qqZKMKNT/qa0FXeBQRsAzvgcxySBGs/SADxbFYkgADjpOln2Ueo06nptfHrk2daOotdGuZgfH1vRHfNJsBp7KlDXKWB6vE4AYtNVagGEtTgXcEQntyFUFc/FURfTdPlL8B8/eshbtqvnsZQ4WTkx+14Zd0hlebzlrpfuygjhTJT0h3GZxWQd2Zb0ZpAsUBXWW0C+5fuvDLzpv4d0gOc7k5gwrIHLAv2BOwGpStq8YMBI+q81f9sxEDf5zFkV2tmfkxuJJTzzgU6b9ndBAI/EyluHsBKQddqH6LykLiYC/MiD1oM+bx5MVIvCyLDMKGgBckA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB8PR04MB6986.eurprd04.prod.outlook.com (2603:10a6:10:116::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Sat, 12 Oct
 2024 07:36:43 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%4]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 07:36:43 +0000
From: Liu Ying <victor.liu@nxp.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	quic_bjorande@quicinc.com,
	geert+renesas@glider.be,
	dmitry.baryshkov@linaro.org,
	arnd@arndb.de,
	nfraprado@collabora.com,
	o.rempel@pengutronix.de,
	y.moog@phytec.de,
	marex@denx.de,
	isaac.scott@ideasonboard.com,
	biju.das.jz@bp.renesas.com
Subject: [PATCH v2 0/9] Add ITE IT6263 LVDS to HDMI converter support
Date: Sat, 12 Oct 2024 15:35:34 +0800
Message-Id: <20241012073543.1388069-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DB8PR04MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ac3c75-0ef5-42b4-4e69-08dcea909e29
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?BSmK00zFzQ7f1LLb1HQYl7Its0zS+PBGp+T8WA5dW2mscD4FyU5mSyXBFPkL?=
 =?us-ascii?Q?ZpavUiyXOTc/JXNl6M/IaJ+aG/ugbWnBuf0N4FacizHYQTW/QMNV5YueACUX?=
 =?us-ascii?Q?IxGqKeLHLU8FRFanXTC2seqWp86I9hg2RO9L/md7LjcpEWJcC4seMGqEXq+e?=
 =?us-ascii?Q?tqjYKLpkzvsAl6hpP698l1J+lcETO15Y4GQlzvZRraNEf9F3ODT42TSHHjO7?=
 =?us-ascii?Q?m5osYBww2/FZMXg4z3STR8PWtqhsJ/hhX/F0PdPZjhWDkMrv+5TFY5J/c7C3?=
 =?us-ascii?Q?shOHi5T3L9rhzGzDqCTdWY7aHbdMxwz1uhn4dYwM+0yurxJnDDOXta1JT2e8?=
 =?us-ascii?Q?wXqEQTi8BBKtR3Rck2fMZrQqsHNlhk5KdlV7ix0Tse4rAM7ZZGQoUqNEpwjw?=
 =?us-ascii?Q?TIVnw3F/oX6QRlGkHyjon6+1c0lkZbmfDBwQuTHa6sESdg2z6qVC0kqFVVes?=
 =?us-ascii?Q?lcbL6XrSsaei45pCihJccQk/GhiI1ebmUppa2af8+SBnNh7nEYfryGFFyvSm?=
 =?us-ascii?Q?Y/xdZkFqBzVjjWV5FyzuYofEtLPDPr8n5yCD2vMqtPjZVnN2OqiUUkHkY41D?=
 =?us-ascii?Q?fbJRMmaEmJub+dPSqDMI6I7Lvc4oktOp7jLjCStibyNTIsfyvfzu8xwlnAO8?=
 =?us-ascii?Q?aCaljDrdl8xTtt17OUnmpFsWWw9OmKHDEjOjBsUYAJaaP2NW3kzA2Cn6ZHJm?=
 =?us-ascii?Q?pM4NYOAhxgNvQW6uGAvG9lAFCqSa5M0KXgvA1PudOOqx37zqzQhtn+vsFDEE?=
 =?us-ascii?Q?eWqc4N5Ch4RS6VgUlacBw1B4oBw4cqqnAyn/rpkFn7BPUM0rCDP5AyVRc4hH?=
 =?us-ascii?Q?uAapEl8FpG5QHdYbEF701FD4P4MjOtNntg5YI7jR4K56Ftv4RlcaxIVp4mA1?=
 =?us-ascii?Q?JME3hVaQqbMfxuygJ+rYi3XMTrHy4W9kSItw9AK8z/LYDV9cQ2JNksLjUX9u?=
 =?us-ascii?Q?APoS9M+m08A4y7l+Bq53iWMzWfEleJtS7dk/aACAZDkqqVAijjrOro1DreLV?=
 =?us-ascii?Q?/vFiFAXWFxdzzw2XS/+dvRnft7q8DzrHbCU2oseeLS9h4ITZoRw+CyxlH9Hy?=
 =?us-ascii?Q?dwEDFnDyv559K+MoZwkaIlGwiz2N1qvNTyt8pv++k6bVRq0DGbud2+QtGXGX?=
 =?us-ascii?Q?u3vgSkkV0E833Z0xtp92pUPSlRdZWmJa+lEfWrlpds8PcERCd83fUmTcDkRJ?=
 =?us-ascii?Q?AuM2qXOhq79LWv5LjA2q8y8/oGRpddgDym0SwuROMrfHzNztRQII/4nHn9xY?=
 =?us-ascii?Q?j4IXaC8EklpKR5erHXMP33p8xLI4c0hkzO7uviRn7JGvPTHY+h/i5kOZ7imS?=
 =?us-ascii?Q?hijp+4ZZx3PfSN694NGj3qos09Hl77bV7/ZXDCRHHffk2g=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?I85sOnP21sJnH27BszWQYVM+a3CljttVvOco1pDeamsBm2iQBBy4g71wF0ne?=
 =?us-ascii?Q?MbAM717lau65VWXpec8p3rqsue1wvmStJTIWmQEmfkREeNSD+EaZFt+100Pc?=
 =?us-ascii?Q?wEQlUolUcHTggZ+L61vYV+xEm7941RhBno6jodkDWldEr6FgPRFT9uSP2CHR?=
 =?us-ascii?Q?RFsXEe2NnUDBzUpiuTBz2KQtT7atB9mWO0NaNtiD0/aagyXafR1vHw9Ek/Mb?=
 =?us-ascii?Q?uZfm4K1Xj99XWz51n/hDwOGq2Qpf9nNt1vSVwKCXbd5/EhRbwfT/mGZFgD4V?=
 =?us-ascii?Q?DB8jkbQ2a20wJ0B65fsTOY32RqzEu8qS6V60fUQ6EmOmtl3q9hLuh7NBDuXG?=
 =?us-ascii?Q?g8QEFr2/K9gfXfHFYrNtsDhGuxr/wj0PhVljfx+aq3iwLLpAhX4PbdKOYQE4?=
 =?us-ascii?Q?hjmsp+cWXZ6RR89QLhnjNlvDEOXsAyox3ZOy6+22qC2Sb6Y9mMehI73UgMbO?=
 =?us-ascii?Q?DqtLBmEgKPBnqenpThPU+dBcTAkp9XL4gJC4pPyPc7/WS9N870VuObS3IxyR?=
 =?us-ascii?Q?6h/HtDHolEHY97V6OBwyI1t7SiOXweD9Tye5WXImDaKY/JlhR43F26ySURtR?=
 =?us-ascii?Q?TU7l58l/nda4cd8SrGZWznnM6DdH8wWinsPJbv/mhNrcmjSmsuzbr3bWm5oF?=
 =?us-ascii?Q?qJbdgCdzjmWYUT//alGm56jIvp6MpItu90ket15c8HpxW8g9GAcGSaEgH3+y?=
 =?us-ascii?Q?Kv/DhZfwltSUTa4Vbf1nG1EgKltj2/wZQ7Xj6y9F6ffZCGo6Zu9wHqEOOf0f?=
 =?us-ascii?Q?cRJ2OBT9rLVm1QXGV/upwU3s5/SdRevsl5w7cFBwT4ZucWHuUlNYNeUv7wdu?=
 =?us-ascii?Q?t+V7jcpuscOOC4/nb8EdrPODfGq9PaJOZ/7LPXQ6KZ+mD3PPJvaD+8c+PY9S?=
 =?us-ascii?Q?B1TFA0PBhzu1DuhVQKs9RscCjUuoR1NQarNHSrWGPjOtnwDkotpp35sDoBWG?=
 =?us-ascii?Q?Ubq3kk3P9UM6RZct9co5Yd6Zqx+DWDqJVsLShZs50SZmWpoT50VZgNsaUiXS?=
 =?us-ascii?Q?kA/gVAqBl3ZK95Q3WAjbmAUZdQY1fC6xL0tdXZWEtp2oBstfGNbYStCqkUPv?=
 =?us-ascii?Q?bVoyEbmgqNw7h4qOwikbuL/wrfIDmOVo8m5/UGyCEQFauwYdV5/z6/CLUZ/N?=
 =?us-ascii?Q?tFp8ZPFjic0z2YCj1gC8LqgO6bD+H/CBleyZyrP2dE/CZ0dpRj8Ou2VxvoUG?=
 =?us-ascii?Q?nPPND3U+IbYvQsPQFov2VwfL3ZkuMHO4c+6wSQeZpRj8oRYe0jvwDBS9/5XJ?=
 =?us-ascii?Q?up3djLTKEh1C33HJnsGyUJeDnAomMivrBKbi8X6M82N8pAZWu+6yYILY4TUf?=
 =?us-ascii?Q?3y7nInvuJm9wZK4xFHnZAP6C9k3/Kpk7/vCV0mNhTdUcQ4gX4tMvpcGK719g?=
 =?us-ascii?Q?uN0AQeAXmhHXrhkdQYF8D7YKXToLq0xsprgXgAVGdphqLYMWzxmHbSq+iKLO?=
 =?us-ascii?Q?jP96NJ7hIoQdQLulm9POdWlzGi57xitg9yjxGXryB/OAp5luBGbluPJvuDVk?=
 =?us-ascii?Q?165Pzz2mOm0A6IOtHe6NDmaElQ8n4ClhZ4lICVJ6wkojXBTJk541N4h+SPzo?=
 =?us-ascii?Q?sRjnJQu2J5EtW8ndCMaUHuttIejEuDxvZqJw+fYU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ac3c75-0ef5-42b4-4e69-08dcea909e29
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 07:36:43.1257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8N2cRsx5KXw0O2SKTLyKX94CkwpZjSX4aGtEMVCQ8+rrmRmO6wY1zz43Di1FH9Yu07EnLaB9ypRVO+VqAPmf9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6986

Hi,

This patch series aims to add ITE IT6263 LVDS to HDMI converter on
i.MX8MP EVK.  Combined with LVDS receiver and HDMI 1.4a transmitter,
the IT6263 supports LVDS input and HDMI 1.4 output by conversion
function.  IT6263 product link can be found at [1].

Patch 1&2 are preparation patches to allow display modes of two
existing panels to pass the added mode validation logic in patch 4.

Patch 3 allows i.MX8MP LVDS Display Bridge(LDB) bridge driver to find
the next non-panel bridge, that is the IT6263 in this case.

Patch 4 adds mode validation logic to i.MX8MP LDB bridge driver against
"ldb" clock so that it can filter out unsupported display modes read
from EDID.

Patch 5 adds DT binding for IT6263.

Patch 6 adds IT6263 bridge driver.  Only video output is supported.

Patch 7 adds DT overlays to support NXP adapter cards[2][3] with IT6263
populated.

Patch 8 enables the IT6263 bridge driver in defconfig.

Patch 9 updates MAINTAINERS to add maintainer for IT6263 driver.

[1] https://www.ite.com.tw/en/product/cate1/IT6263
[2] https://www.nxp.com/part/IMX-LVDS-HDMI
[3] https://www.nxp.com/part/IMX-DLVDS-HDMI

v2:
* Add more comments in fsl-ldb.c and commit message about pixel clock
  rate validation for patch 4.  (Maxime)
* Document number of LVDS link data lanes in patch 5.  (Biju)
* Simplify ports property by dropping "oneOf" in patch 5.  (Rob)
* Add AVI inforframe support in patch 6.  (Maxime)
* Add DRM_MODE_CONNECTOR_HDMIA in patch 6.  (Biju)
* Rename it6263_reset() to it6263_hw_reset() in patch 6.  (Biju)
* Check number of LVDS link data lanes in patch 6.  (Biju)
* Add ite,lvds-link-num-data-lanes properties in patch 7.
* Update MAINTAINERS.  (Maxime)

Liu Ying (9):
  arm64: dts: imx8mp-skov-revb-mi1010ait-1cp1: Add panel-timing node to
    panel node
  arm64: dts: imx8mp-phyboard-pollux-rdk: Add panel-timing node to
    panel-lvds node
  drm/bridge: fsl-ldb: Get the next non-panel bridge
  drm/bridge: fsl-ldb: Use clk_round_rate() to validate "ldb" clock rate
  dt-bindings: display: bridge: Add ITE IT6263 LVDS to HDMI converter
  drm/bridge: Add ITE IT6263 LVDS to HDMI converter
  arm64: dts: imx8mp-evk: Add NXP LVDS to HDMI adapter cards
  arm64: defconfig: Enable ITE IT6263 driver
  MAINTAINERS: Add maintainer for ITE IT6263 driver

 .../bindings/display/bridge/ite,it6263.yaml   | 276 ++++++
 MAINTAINERS                                   |   8 +
 arch/arm64/boot/dts/freescale/Makefile        |   8 +
 .../imx8mp-evk-imx-lvds-hdmi-common.dtsi      |  29 +
 ...8mp-evk-lvds0-imx-dlvds-hdmi-channel0.dtso |  44 +
 ...imx8mp-evk-lvds0-imx-lvds-hdmi-common.dtsi |  43 +
 .../imx8mp-evk-lvds0-imx-lvds-hdmi.dtso       |  28 +
 ...8mp-evk-lvds1-imx-dlvds-hdmi-channel0.dtso |  44 +
 ...imx8mp-evk-lvds1-imx-lvds-hdmi-common.dtsi |  43 +
 .../imx8mp-evk-lvds1-imx-lvds-hdmi.dtso       |  28 +
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |   6 +
 .../freescale/imx8mp-phyboard-pollux-rdk.dts  |  15 +
 .../imx8mp-skov-revb-mi1010ait-1cp1.dts       |  15 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/gpu/drm/bridge/Kconfig                |   8 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/fsl-ldb.c              |  55 +-
 drivers/gpu/drm/bridge/ite-it6263.c           | 919 ++++++++++++++++++
 18 files changed, 1551 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it6263.yaml
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-evk-imx-lvds-hdmi-common.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-evk-lvds0-imx-dlvds-hdmi-channel0.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-evk-lvds0-imx-lvds-hdmi-common.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-evk-lvds0-imx-lvds-hdmi.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-evk-lvds1-imx-dlvds-hdmi-channel0.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-evk-lvds1-imx-lvds-hdmi-common.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-evk-lvds1-imx-lvds-hdmi.dtso
 create mode 100644 drivers/gpu/drm/bridge/ite-it6263.c

-- 
2.34.1


