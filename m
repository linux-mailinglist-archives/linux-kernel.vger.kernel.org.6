Return-Path: <linux-kernel+bounces-415530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D679D37E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 102B6B2A281
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DD21A0730;
	Wed, 20 Nov 2024 09:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L32172MS"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2049.outbound.protection.outlook.com [40.107.103.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802481A01AB;
	Wed, 20 Nov 2024 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096399; cv=fail; b=V7LlHnhmkyDRlWCRFx3L8tAY0jOP31xWnNSGioQUsvTlWARjYym86BWtR5wYrcq1cyll7rpMIsxkahy/MPMNA3/2lAh3dyiwyGXh7gk4aO3C3iwVylkMuspyBhtI6Y9YAEkVMe5keIj/YiXjBnrd4EAnMVKuE+CTqSfL9295Gpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096399; c=relaxed/simple;
	bh=0tVqF+vre/bqRhLGIxqOqtx+8T0lVKs5jTu3/t4IuEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RlKC3uK0QySSNweYoiuU9ug9cVov25RZ1AB3izGOBsz3zhDXH1Dv6yX/GAjMPLjVgCetzXPBZC+JE6/s6eOiijYECAlOlw870c6dk6w8v60WWmBt8RU8GGrh3Um10a2VJD/I51Z2nyujm46nyd8UwqFsITGtkzGG3bjdNthC1gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L32172MS; arc=fail smtp.client-ip=40.107.103.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fcw19Tj7SvceQRVtCwFMQ4i8Veq8u0QfsGpnzNQrB9wKkB7n1m5x1jUryISu9mlX0tQHVZ1wt1OD+cjbSi6iTWMDHG+uw9Ad8jkqdyViTiZcVyksH0KmanI54oPGFJes8FLBR+d6wPg0Ve7w+uaCpL04Q6q/N/6YgBW8X+zxMq1OhiWxo+uVxOpgwdDyLi4iZ8v8XIQE38S2SMu9fbJQedjjdFwfjZufDLeeIJ0/21NlVweD3MC22dFM9LxOlrFdPR45w1hfRL6saMoAhcyBWORIfJrPIUcVs+KIVSilvmHe9W69cuw+mh8MRUkuLJjOpN5qJYxW4+ezg9mesPj0Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feFK7wolF5alAL3O8LeNS6AWeIX6iHNOvrm+4rLB5iI=;
 b=PaUBkOkgLvXDGs29hOAs2/53gMCpaHJq1MDfN34kNmey7sRGdQ2m1Gs32/MgF0RTQQmig1ma1ShMdShHlkwckErF8fZg4zreqPotU+uKVWmg01d3D7djq2mwPpMfWwhQ/J6/5MrWqUpEOHe2BtAVAu/APWMyn9jK2gjFIlboUf9S4p7G1mYvLxtPnxrZ8ewu6Rw1TVY+2qv+mZ1kuyD2UpxAb6cKPZeY/Q94NWaF7xYm+t0I1F0clc5IVPMiiv0DPM+0QajaFDBcLYngWIYRc93ZIWp6jpE8Wv8vWc3n0zSRbJDUpI8HOjr7gYWSRoxERLFFMLemBceOFcz4Z7rmYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feFK7wolF5alAL3O8LeNS6AWeIX6iHNOvrm+4rLB5iI=;
 b=L32172MSjilbFOaC9G4MAuJAzAmyLFQipQx/Te97s3eXXsT8vCS18K8Ofmgw6sSR1FRu2BgF1Ug0udUpN/r6yRkC3F/5jjw3n8bN8SuwDSyDr8Mzk2DL6EbKjjnCgmFt4VRAejxwDHHO4iFvmDhz3kFKpyTVOQhytvB/uggmsEfZV/lHbJUknLGRLBcIg43BxgzYL2nghD2vQ9pUK4lWLrPY8K6Ze90gbFBVRuLIEl9a436fTjoRGtY++0XMyBB7prYyB5b4f3lZAqHpvTbi6ufVsHSOpQ+0o5YZGa34KxwETtB5pYeBC4qetoTqp7E0Pi2a0jLoZdIPI2SuWaZPqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by GV1PR04MB10128.eurprd04.prod.outlook.com (2603:10a6:150:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 09:53:14 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 09:53:14 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: joao.goncalves@toradex.com,
	marex@denx.de,
	hvilleneuve@dimonoff.com,
	hiago.franco@toradex.com,
	peng.fan@nxp.com,
	frieder.schrempf@kontron.de,
	alexander.stein@ew.tq-group.com,
	m.othacehe@gmail.com,
	mwalle@kernel.org,
	Max.Merchel@ew.tq-group.com,
	quic_bjorande@quicinc.com,
	geert+renesas@glider.be,
	dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org,
	arnd@arndb.de,
	nfraprado@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com,
	carlos.song@nxp.com
Subject: [PATCH v3 4/4] arm64: defconfig: enable i.MX91 pinctrl
Date: Wed, 20 Nov 2024 17:49:45 +0800
Message-Id: <20241120094945.3032663-5-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120094945.3032663-1-pengfei.li_1@nxp.com>
References: <20241120094945.3032663-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|GV1PR04MB10128:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e81945-41ea-4e00-bfcd-08dd0949268d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qnaMMK76SbgXgvKLk6bhmV6zwbdK94gkAnmeN5Z/ODYbpgNRjr+AaRY4WzKA?=
 =?us-ascii?Q?UY8evvvj0k7/LB4853w/OXfbA5tZ7vI3oK4LUWXRMR9y9bu4ua2Pd7LIRoTm?=
 =?us-ascii?Q?fhCoZ+pQ61riqhG8YtFestXe4Z40p4N5k+Zul/q0FGiJF70HYAf4acjM44MG?=
 =?us-ascii?Q?/vcipszIYJvIO3roaUO5Qzd4CbMNesPr4y2KBFmz6bgz3XBH0SoFf10VmKvo?=
 =?us-ascii?Q?mNNp/Rk2skgoh1O5WnOpJAy7XxhI8X5SX8c4JEOMefH1327hh3csbHm18hqY?=
 =?us-ascii?Q?n3YJw1Y6NJu2O/anXWl75ki83fo9NTsNwMhn8tFnB1O3prrgjYIUdnsj/XQ2?=
 =?us-ascii?Q?1ehwTou1FeNaiMTVrVGC9OJWEMlZdCY1D0fal9HS3jIZTPhXUjKMdZDLJmGG?=
 =?us-ascii?Q?40DsX5oijL15jHZ2naTUqAFTsVdqTRWw4fGkdGG6Rxvo3DuK4F49Dnw+HUZn?=
 =?us-ascii?Q?fhK9ArMTmHqZKj38fOfi5OEgM4+C1o+T5NNsI2Pbnu46ek223w/M9j2FXILb?=
 =?us-ascii?Q?8JIOqo3jF5JkTZP+eas9Pb1AB1jw2LoqzOOkX27PRajPttmxHWZQMCdrs73K?=
 =?us-ascii?Q?UAs7RhmgIYI4VFGQ7SGZxhj8dWMi52Hy/1Ur9ujwua1BKnpP9PBzFtkg74Nl?=
 =?us-ascii?Q?3TbCxa7SP+UnakPe9IfXBNxolqVyMXZ3WIAhcKVx1SMl33ZBYyYE3NTeu5jD?=
 =?us-ascii?Q?7yo32yySRNL32T+vJuXTUoIQQUjNDM+kpGuP1zlTMlIdE6C93syA42JuIPhD?=
 =?us-ascii?Q?9fuK0Jw2rHW0GuydRmaICbpnD53eNh4ku+HukoPAtOqP7lV3cQ3jFfF52IPH?=
 =?us-ascii?Q?hhs6l3AB5bAsVaCnqwgYqEn7ZkrdMgfDx3TN7hOGtPMi9yPX8b1vis01wV06?=
 =?us-ascii?Q?CO7noVGH4wnJbGi/k/qX+I1VTtv28vmS6NPr81ep4fpkzturt/Gt+jZQ8rcZ?=
 =?us-ascii?Q?p3eYveqypd1kY1omCmG1i3rdyC/lGtjVm7hoQepiWgOOocgltqHvEJLvVYo9?=
 =?us-ascii?Q?AJq2g6nTMRz896MNdqwvxk0Fq39tCLsiUez1A1GCI1XV5LvfpNocUEhgfz6p?=
 =?us-ascii?Q?jomjysq+0gQlamny4e/xDDpLXQwo8G6nHY0pUHbapzIFw6rzB7T9eI6wE+nx?=
 =?us-ascii?Q?Rn80R3AZhAHWrPS7wOS4T7Q7mmwf+Ih4nZ2bePE/wfOmAIemmgvT4ejPMhaG?=
 =?us-ascii?Q?7LQ9ugRrhp0CTyOxpWEVEDzsD68HzHTRbwHmZgjxuj5OWWm6cxiMt6vmUltF?=
 =?us-ascii?Q?OzZR3OM2Uw+jPlD1XodJKikgygBmgeDy5MdUfmWNPGHnbhlQlkiDNHYzB8Xz?=
 =?us-ascii?Q?qxfU45WXb30lSLESjRYYPqdSHslSsr5eFKWRe74V+4CxGIZwqsaGDV8lQz7A?=
 =?us-ascii?Q?3LRLXTE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7EUsQvnawmMewgsXXSPmZ62TXsI0j69g1QR3FA5GAAVqqEifkixCO8R+qOqh?=
 =?us-ascii?Q?SrfeZjuR8u+4nJxfdvKn3YndwnlkNnBlrlELY3XIUz733S+2HEo28h/w0ZQa?=
 =?us-ascii?Q?JuUqYMnfHO22nrmugiYJFB4V3ppa5JWopn9d0CxHendRpeg2SFeZeDi89RYE?=
 =?us-ascii?Q?Vr/GlFY8mhHt1dVad8Y+/dogGUDpm52KYD9B/1EoP5WcTjDa9cz6G9W3ESpP?=
 =?us-ascii?Q?faR1MkaAkHNNXoXzVuGCknQQpDcP7FvomPP5CKfJdNz75QreXuRv6Yn167wN?=
 =?us-ascii?Q?oFOTHm1LuhigktS9mghhMOCrm1gDEemqIlQP741SKzGW2F3SmQO5uPek4XBl?=
 =?us-ascii?Q?lYJLowLKmmrDtaTAhdtPD1pC0a8ZAc6RyyCG4e4cvjUtipvbERCdonSQ8MEt?=
 =?us-ascii?Q?jjfGCOZtXSIjM08mGjPVVnM9k6nZT0OkfzC5F9+Xgwh820Z+U1xIOaNDrUOz?=
 =?us-ascii?Q?LndOBxhCFHtTySV00fho0KIgCZy+A0Gzg8+8/LxSC2Y52NC0MVCZNzrHp5/9?=
 =?us-ascii?Q?2iO0Q9WYD0/XfKTo6zfSNShKbkuNzZKCaUz6m6cufs05Tcts5YfLIo9B9Q2A?=
 =?us-ascii?Q?+pYHl5pUSLAXV00875gXd1+cSDA/LuiHxQ09pg5I7Zt+BPVZsuGy8gFUTJOr?=
 =?us-ascii?Q?pIttivP+wJRucvh7CGt0CE9WW9+cQ7FFz6V0mFvW/xLLeyCP+nUA8H0nB08L?=
 =?us-ascii?Q?p4gEiOmkK2Aw/DS4MPieHcNkqAtQrnQUrTIEqzKuj5smnYW3v29yz8x2ma8d?=
 =?us-ascii?Q?LhBv1wHbssyah+i6EBkw3oowbEQ0NOZWvn4YvP0hl0tF4j0KwA0qztNBQBdj?=
 =?us-ascii?Q?1lA0tARVq0rWENa0J+Iz33yorn2tpBEf6ZQ7/jWZpPKigDVLQuGyYo+vtzI+?=
 =?us-ascii?Q?jXDsgj9yHa/rCiMx95kjOGMKVIlneAdHdrQzg/0uZ0bqOGJfE2Z+ZAM2fLFG?=
 =?us-ascii?Q?SGMYyVDWlJuvlBzCIoNmXhh4p9emw+mgLKEkWANoD8Ox8QNatSYu92uSaFUN?=
 =?us-ascii?Q?LUYdP5A7YNPlsxvsk/d1ApGnTrv2AiYo3ikiv1z6miNLKUEyhvNAHQ4WTyIX?=
 =?us-ascii?Q?RU8E3Gpj2xKSLCKhEZOGe0Aw7ZBuZFCp878Wb12KUIFyAlcs6NYwY1QSfu47?=
 =?us-ascii?Q?QRU+BvKLWNYqHZmHHWxqEg1DYHtEl0z5RYNp8PqwmfwrMVexTwuXK0vK5HoH?=
 =?us-ascii?Q?Y3BwmMg49PtMvFfOdCyu+7ZaZIznClX2RvO7fKXyDXkQ3GUaJt6nYjvXJMn3?=
 =?us-ascii?Q?yLIv6A0XUJDIqShpQyUb6JqQqoZ8S/mw4aGou1CKg0z56eTGVnGTNZe7vvc4?=
 =?us-ascii?Q?TLTrg7QlQUPyThymtSTnQ2tSC8dzClIoESTcCBA4sAt63PDFJhlT4eKwnYIg?=
 =?us-ascii?Q?3z2Sf+o8hjlh45StbJKQvg7XrpKIlUdkaryroSW8DDKcxxEcv2CNdAU5F3Py?=
 =?us-ascii?Q?gsCPRV5zO7MfXw+YKf8onIINLLo6PjxBtnuSY9Y3kl6ONpIqIPrJyLVVnfsP?=
 =?us-ascii?Q?owf4z3ACU+QDrzaA/dFy8uXJBhDPfNcsrhpXDWAzniyb8/FuUVC1hyCjSDsg?=
 =?us-ascii?Q?JyBfyDtMaIBcDtOMRUWCFSGWFNmPgUDMOacGz7FY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e81945-41ea-4e00-bfcd-08dd0949268d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 09:53:14.3923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dRW0WoO/dVXS0WhC8VfTfRhFh8wQ35ahiOThngUNiaVyw+x5tNl+Br6e934ia2GIeDa6MnS7oMrApgksNNxmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10128

Enable i.MX91 pinctrl driver for booting the system

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d13218d0c30f..013bed6a4f00 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -592,6 +592,7 @@ CONFIG_PINCTRL_IMX8QM=y
 CONFIG_PINCTRL_IMX8QXP=y
 CONFIG_PINCTRL_IMX8DXL=y
 CONFIG_PINCTRL_IMX8ULP=y
+CONFIG_PINCTRL_IMX91=y
 CONFIG_PINCTRL_IMX93=y
 CONFIG_PINCTRL_MSM=y
 CONFIG_PINCTRL_IPQ5018=y
-- 
2.34.1


