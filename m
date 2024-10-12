Return-Path: <linux-kernel+bounces-362162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF8499B1BA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17FC51F227D7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955D713E41A;
	Sat, 12 Oct 2024 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jodSjcTe"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062.outbound.protection.outlook.com [40.107.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174111527B4;
	Sat, 12 Oct 2024 07:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728718680; cv=fail; b=kcAWBWcp4pkOF9Tj7RVnNmZyKK0OrrovdZiEeLu3T5sXbgT70NHBQyYykOh52z1eiHOe7Sq/aLQihVcWYXkZROQaqmZQEhHWrFo03CXwxw7Of0QGiGlbQox3JbIBvOmm9J/hDRnGnZ4lyAdyPN0bGq/Eq7i+5Dtg79UDuYm82Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728718680; c=relaxed/simple;
	bh=pU9qabcj8u2O0bzf9h1z5Go+7HnXXCi0Rn64ixm0tg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tl5UUqJfDPvt/ICkEF8Bh9uE6Ab34d0RMNhxluw1YaSy7B/0415E/8lRYnScxDpjlL1rNhqVUMdPpBO+osKbIGCVDaTs65aTX4Nj1f07Rbyg/Lssj1bXiMn11ufkPA5jfH+mKkrSCAvoyzCnUKpMOpKAU96EZq3yVf5ApZKJt3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jodSjcTe; arc=fail smtp.client-ip=40.107.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olnLfCBE3XSTP1k2ZA7V1epwEZvfgYtCUMJV3rTkTrT8erTQ7yZTP0OBGjSE6qH0ODtZU8lrtCycuRAd1MSNMXadOf52pavOIwdMa6HaUBPgmaJuIRr/TD08381q0ipSc9pBbeV5rr2B2154cXpsvE/4BsmTWyGVQElwaepqEkLyCGMSuvP6IjuTGAtPQE1cB/ihWnwD4vZAcoIsD5i29cal6UFQnG4ip1b53bLb73Ub3wc2p9OvjM0OVSWliBUviZApUjURI06QUKUYEGZfLcTMvH5BEweiqBxuR79s9b84EvAaN9VrafS7vLZdY+5wnNwr4xljGZgnMqQMZWz6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTj+YcXC+zR04s0XMza8gaZdmOkGdSdsuqlWU2kcsOk=;
 b=DkEw203ZT/dWeB8AS7mUZvx66Hk99pMon83PaHSk9VOIYLoDr2lx8oQq73J34c+YjEKQ9jHn8l1+dv5cn9QvQKZaIOdlDcrUWGfiHSr00pEqblz5R9Z4eR+VVc6mDtqrgKH3Tn4GPHBnBgJjkx59TXu8a+vtMtUacmOfC+opYL1Nq4QqcOmQUWhxb7hqbO5549OZopyB7ZgyHmjHl48WjQmxkqvl5/eHCwjsnUIs7h36tmD0jCaBPCK/1dsoBEUD9ByViG5tRnDEczUDwHIX0YlbnbtIIlI/+1JEnBVbBE+CSSMghKEmyLbVLFUTsl5ypJY2PoaGuHZ/FfUOfv+Dmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTj+YcXC+zR04s0XMza8gaZdmOkGdSdsuqlWU2kcsOk=;
 b=jodSjcTe9SaviIQDqvZaq+VAJcDpIjszl1ZQTIDEYJNBcd/RBN+AE9UUEVtlGdwN0WxE8kE+vX+P0w3C/3oiWEL5GqzOxzMP/9bkXN2QDo29rWNn8tk0BmP2GByL3IfcdNDHzTpsizS0/Gn9aswJAFXFhLmMEMM1NVt81v2VATbxx0F1GZWc1vQ5ULHndGyGPiKG9sMxnSloYjrBvONjTyQ/5bvqmNcy8BHfJnFpmJM0h723bCv89OyWAbdgEMw6Gfi83P6GICcI6DFXb9WBDvmi8TogVm3YtMRbml6478qZ8+m61plHjwsFls77XTY0vzgqGLMeaLZ29PAy+mxY/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB8PR04MB6986.eurprd04.prod.outlook.com (2603:10a6:10:116::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Sat, 12 Oct
 2024 07:37:56 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%4]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 07:37:56 +0000
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
Subject: [PATCH v2 8/9] arm64: defconfig: Enable ITE IT6263 driver
Date: Sat, 12 Oct 2024 15:35:42 +0800
Message-Id: <20241012073543.1388069-9-victor.liu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241012073543.1388069-1-victor.liu@nxp.com>
References: <20241012073543.1388069-1-victor.liu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 178aab09-f5f6-4be6-aaa0-08dcea90c9f3
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?IrDBOuh+7J6xYrJRLHkIPleknOrRqtj5WrXgeqvLvFOgfgtug6e1PwSnfmzH?=
 =?us-ascii?Q?UpoPhDAgGKx4tv2ZmWWKc3Fc9xxrylAeXItULCQPv9uMQVvIdgByjBSQtAEF?=
 =?us-ascii?Q?ayqOrZsEpEV/1KQY5l9i9GFCKbzU5F5TE+a2xprN4lILtyAMeW7XhkSy2UKl?=
 =?us-ascii?Q?tQBINBhxFgTQN0cQsrfIbJlNgN6N+sDTSFrAlpQc960N+xpYj+mRbMeRiFjM?=
 =?us-ascii?Q?2KLO1taesWAbRUM+IVoQestst82TX5nEVj5uHQfy6XztorKEE58Ms/Yo0YbL?=
 =?us-ascii?Q?H0TIqpB7TXj+5mkoWOQ90Xd3GmEhLkuz+JGlS8cgfPAH7O6lgFNQoJRymbNq?=
 =?us-ascii?Q?FrzRWARso7I34I73SQ9KeGPkJzg83epSWPxjFRML9EzDLBuHSjMuTq9ynZTF?=
 =?us-ascii?Q?WgIztsZnCj+Wpkf/gQmBpcv4v5OoOx8SOnz0RRtAEP0aLkjhKi/0tgNZ7V/6?=
 =?us-ascii?Q?wKgQefNHdK09cL1mBQX78QgcG3d2q+O0PiaMW/UQinSXPRI6tIM8UIlvCMc9?=
 =?us-ascii?Q?Uhxp9ADd5FI25q+hW8v2hxXUOE0+f+pJfFFB/SJSXjZXBxDsYpIzg2Vp+FR/?=
 =?us-ascii?Q?S7CZEhdmHMrkHDSShPTaEvLqcO38t0SekgUthRd++RUnkykrcI8UP/UQbzP6?=
 =?us-ascii?Q?Okwj3jKSGsO3paU/fWTnLEiTyrakLgW+NzkSyQvnEUCBt/plnKvzeJoagmDg?=
 =?us-ascii?Q?t4VcIzhzna806QjJXVRIJOgxjHICjpy/sqSsaqOy0sSDP8pdhHyApHZnNkTr?=
 =?us-ascii?Q?nX+pe4Bf5UkeJAbJOiv6Ia2xcyPxe6GkEWFlagb/FYnFz+kOtakSR/ToYZi6?=
 =?us-ascii?Q?9QZKBpKPTuuBZoRamDE3hqNPGKdFlGSkoYNkptw6HK7P+MqJlBsIyhZ/l1E1?=
 =?us-ascii?Q?ct4woaMrUnGhg2JnCr/qQvwNZ3+kxrJ4pFSLuA8trdwPCGH+KPvZoqMjViIX?=
 =?us-ascii?Q?MAf7lmrRQsCSbdGmqYi+/dXa9S1VAH7YwSkhtSNbMga3ULQ0HIc3j+Oxk3ad?=
 =?us-ascii?Q?nXshMCGu4rcnInWevkcLlrVLOoricfeCxEJ56wuK40VZ8N+jihNyNZSBb24Q?=
 =?us-ascii?Q?OHp0JHy2LEOh35WnS6r0INu6qBdhNRCLKmGV2Vtlh93AtxPk40yZ8z6e/sNR?=
 =?us-ascii?Q?OsKVmz/Vqx/rIeDj5iM1JpovCKVlNLDyb7akCxIwpkCOs39DS1fdUTp+fxrd?=
 =?us-ascii?Q?0nXhfQngsllkufkY41TgAc4e3RkXJOKWa5nBpQ09QhzvqQktL9GT3OH/sB97?=
 =?us-ascii?Q?XNtLAYlD/V0qvbSrFSIfqYxYajpgE9Ng6f0Q4vuo0r3iPN19QCPQi4RzgZwc?=
 =?us-ascii?Q?SwuBbhatYzSXngSH35Kxu0JT7XlZfkQNiEGPRtXsXQU2TA=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?llvh+KIGxBWeYxM2YYIAETvNBAEirNkHdAk0pPcg0hsrkWPIFAmY4juaiOMF?=
 =?us-ascii?Q?U0vQAHXRhGf4EHKblMmsLk2Snn+u0X/dXne6MsNGZK8ecRp2Ud3uW3JfkzPl?=
 =?us-ascii?Q?Baqn8AxHxR9PYiJkvw3WxMA6xOhCrt7kVW43zuXej3ZvDbcR4Q2uWi459VUx?=
 =?us-ascii?Q?mOWeVEykN9zaFRICbH3lXRbjeAvvFqqT6GqiyQzes1V2ZXxu9AW07nLN92kV?=
 =?us-ascii?Q?FV7edfyc5i4mvCwC62zgXxcnFFcCFIPB+SOwNGK6FsqlMxBkyiJyWMk4uL/C?=
 =?us-ascii?Q?findwbbQLYb+jvRWoUrkUeYTXc+sXjrpTeiWwcJNbJ80GTtloTVSugsqbORQ?=
 =?us-ascii?Q?d5jyo2/EMqQp8opypST6yW4THXdz37pHXio5ff2YBzMnICOke6dgue+qytwv?=
 =?us-ascii?Q?KNJyBeXsUB2bkLhC+hSYxKNwgPMFui+eueJA8lV/CxlA96BeBWvge8liL6TC?=
 =?us-ascii?Q?pAN72+pSMfIp+yZ96pAVGU3HFb0NYcnBihPmi334sre8d7uTHMtfHIQmog23?=
 =?us-ascii?Q?gmpffdHiNiD0zBrX9GrVmoYriQ4a3x7J56AruSGxfalWghTZtXwetno8RHyL?=
 =?us-ascii?Q?tuR69rqGkEv/Atc/2TGvsQZ8CmcnjSci8SIW8Bu/35g/jZqck7e23/SY49JN?=
 =?us-ascii?Q?QAxqbYG5o2ako783GlziAZVuTMBV9LrbZfqsT2S0KoTCTR7CtN4+4qoF2IAT?=
 =?us-ascii?Q?cu6NZ0boLmiSayPL+QO8TVWFJQgIVE4E0inWjSFJNPkb7y1s8BUibNh8JEke?=
 =?us-ascii?Q?oFAI24jJ1f9qht/r8TKyBgqTZDwJ6vxgcZ9nesjhYBpWECeHj6bka/I8+UZB?=
 =?us-ascii?Q?YnWfnGPFQGttGL9sABZQHDzr5AJY0jEfyWW5KjvYulT7MebsZbqdQUtbv4pU?=
 =?us-ascii?Q?zuQntrq3okfE1JD7zPKwtVU2Zyq4yf+E0+f09nQc9gQPrFjjPyUDMp0UhdnR?=
 =?us-ascii?Q?Ju+SbnQ+YtFq+gI40Sxj1MfaSBFVWHF3YX4I/XdW/AZrcBbVsyiml/MPIfMR?=
 =?us-ascii?Q?7VUscQoYCq25UuWRAqILSVOJqnlWscUL/9qNBeqqXCsRfRNaOmY2Pbq4itmU?=
 =?us-ascii?Q?tdJxs3eAb6R4bMnk9pbpRxuWIk2/fzs9B87DkDKBqRJc81Extx+aDJ01YXlM?=
 =?us-ascii?Q?VSO9+51cPWIup0rPE/SD4vlobD9LZvfIrr+sEWlKmYJ+DP45eLQvWIxJEH1b?=
 =?us-ascii?Q?nwe89y45wph64Xdv+mM7/1n3qVkYA1xZJhBDj36GQ8DKzebhJFkdVMyLlLRB?=
 =?us-ascii?Q?VpuKgijG0IcIemNX3gVOp94CQgC/1qHwcwY77AbF56pMQMEo6eANbVrJg5Jn?=
 =?us-ascii?Q?YdVp/ecoaFJSrpl7kTQy8oGKqaw4VqMt47iVcNfZxcL1wgthJH0ZrF0dXNJe?=
 =?us-ascii?Q?Qy5sXqxeZrU6DNuZq41oXu0ItKLMCtN/C9Pm2AoZkiaWT/jQD339V/hSFU3L?=
 =?us-ascii?Q?Arrepj/db3TjNtrS40/MX2HXPGUai4W/rQAvmR9uqxuMjue3U9Tpp4FeMHiZ?=
 =?us-ascii?Q?fN/0gOjL4qFyLNEtNDq1SZNorHiu49WBHSGTjeiCWdF/xU9pU9yM9m9H0+GI?=
 =?us-ascii?Q?kbgo0UBVU/4WEoEzaXEmXTvIpkDzlfpyvpJizSDy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178aab09-f5f6-4be6-aaa0-08dcea90c9f3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 07:37:56.7064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: diVoi6lVpPHHxxfmwkD/bUiP1WEBsaeL2IAbWguhaIAwdSQH+W4HpYfAUVFQpEsdatW8jBo3D93WcI8cidCIZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6986

ITE IT6263 LVDS to HDMI converter is populated on NXP IMX-LVDS-HDMI
and IMX-DLVDS-HDMI adapter cards.  The adapter cards can connect to
i.MX8MP EVK base board to support video output through HDMI connectors.
Build the ITE IT6263 driver as a module.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v2:
* No change.

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5fdbfea7a5b2..d8a232e285d4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -899,6 +899,7 @@ CONFIG_DRM_PANEL_SITRONIX_ST7703=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
 CONFIG_DRM_PANEL_VISIONOX_VTDR6130=m
 CONFIG_DRM_FSL_LDB=m
+CONFIG_DRM_ITE_IT6263=m
 CONFIG_DRM_LONTIUM_LT8912B=m
 CONFIG_DRM_LONTIUM_LT9611=m
 CONFIG_DRM_LONTIUM_LT9611UXC=m
-- 
2.34.1


