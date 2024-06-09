Return-Path: <linux-kernel+bounces-207390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F16E901665
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 16:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923071C209A8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 14:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7603645016;
	Sun,  9 Jun 2024 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b="h1ozhQb1"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2134.outbound.protection.outlook.com [40.107.13.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6586141C69;
	Sun,  9 Jun 2024 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717944574; cv=fail; b=jU1wB9doYmrjLeakFCB2dzYwfSFNN/yEYbHVFyq5yRle7byQezn7QYiihSHI7Rx8GqCciwAnhxNtHbSWzzJNSV5dnjac3+LFVmJYscvdMqmxRmWAG5p8xoaxvR7toHilaJ/TNaUzvMuxFwgLbLibARLte/B/orYEn289eQ/me4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717944574; c=relaxed/simple;
	bh=M973e6qEWFOAs9Wo7H1yiEGs8W1/JqPMsLGsHD7S1og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RvBMa/dr3QCxWLyqusFZ+ioEz39zQcta9Wgc22oV1WcJNHqf+nWoHuF7af3jGqgAGNSzD/Jpfix2xZybLUQImZ2pF5Uc0iFI7z2sxR7WSs9G4o/q4qLHAaPC7c24vneq4QamtHqgNMewNn0NFkr2eLSPTq3n/SMBqE+z7m/3uJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn; spf=pass smtp.mailfrom=supcom.tn; dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b=h1ozhQb1; arc=fail smtp.client-ip=40.107.13.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=supcom.tn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/KQ42QlafB+30s7rRWiepbVJaie/0dTtEbGlaMd+nybC8Kg05N5BwJQQaEVGHmicbrIcC/JkAwhdN2I9yBfAl59/9D/YSssv3JcFrwpiCfCUWO1zF0jLYZvjJwgjOMAOl+W8zDaTUnp4XvVeGTcrmc4q8/+Fjukrs1zl40ZwLIaUBVQA5zZbbUk9t9GdLdZHJajJiUAKAYEW3APCj8xaKRUph/ETxp3qa7CFFPlRGyRwKueuMLoQEAt26jP0IYMT75w9BFgAyQTuLtl142jsFIrjF/QdIUbDNKil8fxOqHh0DImWlLsOeR7LWEqBa4qxyG086fhJAj5BiAmjGLAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTNklBGn0dcAl2MaJbVY3f9iV9um6DRVa8fbAGvmYQ4=;
 b=Fw+gfoU2agB+SV4uhaTEihRRAO5PgFSZ1hBMF6rsV8TTC3SxWkkPxznLvw3ThhR8TAr7e2oSEbxlY2ESQ261J/wjUhBp9H/iNR3vAHXVxm1ehyLV3ujSA9y8fXZaVeg3/g+J/EWIBMX95P5urG+On9OEBMMLcU22PiD06zcGIiNiJaRLcVA8ek5kwzKNC8YKVVX0f4qgeRxWW1/jaH/7OK4QUa7uGZZ/VQJI9VoZUCioRY9jicVPjynkJJ59BOCX3t7O/8V8X/fSPHMidnzSgG4QCSRcsmm/iFX6tZp15elqq8XCTgOxRSecxocj+7Gw8p/PhqRhvcHr6MnzsL5R6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=supcom.tn; dmarc=pass action=none header.from=supcom.tn;
 dkim=pass header.d=supcom.tn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=supcom.onmicrosoft.com; s=selector2-supcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTNklBGn0dcAl2MaJbVY3f9iV9um6DRVa8fbAGvmYQ4=;
 b=h1ozhQb1gtJyPKbX1EOwaUylBBLAlOoiSHSNjfKb8Q1TZvVChxq/pJ8KTgtUxU3Mza1jWEC/YV8Xv+u3yfqe9TOCsgtU6E7EPIfNmlEgu+bYiVMu2a9FYt/dQzvTJOkLIsPRlDSLfUDUbW/MKBSeTofN6DjmiqQjPpuyQGwbBcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=supcom.tn;
Received: from AM8PR04MB7908.eurprd04.prod.outlook.com (2603:10a6:20b:24c::18)
 by AM9PR04MB8131.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Sun, 9 Jun
 2024 14:49:27 +0000
Received: from AM8PR04MB7908.eurprd04.prod.outlook.com
 ([fe80::eb8c:cdd5:a0a:757f]) by AM8PR04MB7908.eurprd04.prod.outlook.com
 ([fe80::eb8c:cdd5:a0a:757f%5]) with mapi id 15.20.7633.036; Sun, 9 Jun 2024
 14:49:27 +0000
From: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D . Jones" <luke@ljones.dev>,
	Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Subject: [PATCH v4 1/1] platform/x86: asus-wmi: add support for vivobook fan profiles
Date: Sun,  9 Jun 2024 15:48:49 +0100
Message-ID: <20240609144849.2532-2-mohamed.ghanmi@supcom.tn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240609144849.2532-1-mohamed.ghanmi@supcom.tn>
References: <20240609144849.2532-1-mohamed.ghanmi@supcom.tn>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To AM8PR04MB7908.eurprd04.prod.outlook.com
 (2603:10a6:20b:24c::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7908:EE_|AM9PR04MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: d88cbd80-a434-4a25-9b22-08dc88935c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|41320700004|1800799015|376005|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?44xuivk8yKfCfZzzCHfTFOXbUN+J57AvhpM+oi5L2CSbBugXPeNycjOamKlQ?=
 =?us-ascii?Q?objOyPqFRyXfMbSPAtM/JTuyHKc978U3cWVluLvdVO8aA2ZKTjRCmB9puEb7?=
 =?us-ascii?Q?OMkNJR1E3AFOIBOUp9gMTYE2H+ut5JLC/9aZDcf8E60Jfz11sfenuG7lQMpd?=
 =?us-ascii?Q?bVVvqrLAWUJzjX2Ras3jfRTe3ZRKRbX2PVsIKJ/fDdB83t3KfD645dzSo0zO?=
 =?us-ascii?Q?UuEiKGCmnMzhKWXgdNeMv47PUbLnbpAb2Bu5ZXk4lncvToqMT7V+9JcdHtbY?=
 =?us-ascii?Q?9H9Hj4N5bHvpiKqJ8XojmWzQgGOWP+9EofxQgLkcl38ZTGd3ndCl+7ON2DzV?=
 =?us-ascii?Q?8yQouf+RBZrC0C1bllEWFjJVd7eDNOIV94u5z9hoOfhVe4rZ7/8EGNKl+ux2?=
 =?us-ascii?Q?3iF79DcpK8r3tCsUsj3enmVfaavILwcxEK55LzcGimY3J3XA9MOEAhfqv38/?=
 =?us-ascii?Q?CSRVJ9wt/wJxHdA4DuyrMGvG+n3shJbDURKNCc5zaangowDNJhSQJNby2eL5?=
 =?us-ascii?Q?a8CUeqZQpxe30ZjW3ATOJHxwdMmD9usNEWTdoYonoeP0JTfL6BBpIQebGzb3?=
 =?us-ascii?Q?WC3zdF7mqKwwWxiw3hA9hWuAPZ/GGNl6eC7dLa2fI/BBuv3gGkbSfP6dYyXG?=
 =?us-ascii?Q?KK48vyqeX1ZTpD1gSyXm8K2W2tEdQn2C8zCgki4tDLr/PNOlP4hn2ovPi6+O?=
 =?us-ascii?Q?AE3OQGVq/SaEsMZiAFt23l/dgN2mdXUHKbaNE08F4XGEvLH+61jvNErQFMFC?=
 =?us-ascii?Q?Eau9XnP4dpIbA9xlkLhH9s3zEWlOcnXzDMnnVZDjMkRx+k7ZNkO/rlL12dHI?=
 =?us-ascii?Q?VbZDDsp0DS2Nk5lvEYPpBhVqtjMxLFoWd/TOAze8tlT2ZRuHu0SnPk8r5GF0?=
 =?us-ascii?Q?y2gAvos1qAC0CPfWc7MHfQ+h+VhGv4jRrysYEQ6Gp6XLp9hQ+LRNLm16a4QP?=
 =?us-ascii?Q?3q7t4O8ZbRWPuDFjohseNcufWphQ1lEcbO9ccP6XHGc+9alQKbEVtVSOdCNq?=
 =?us-ascii?Q?dwQZN/XR1CWYCvtUNoVpKHJd3/Xya1tVHzOABFEmcWjj413D7z2RRoQkOajx?=
 =?us-ascii?Q?KUmlOjMb18F+K1UNmCWS8slXifpM3bHG/1Z0JPow8voBnSwGvXUaRkGhkZwt?=
 =?us-ascii?Q?32Vm7km1jaGIftKgze0JrlvZsx1dhAy/4assXOYIZwE19nCh54GLDSoKmgEU?=
 =?us-ascii?Q?/oKsdPuF7eNu1aiDG6r7LHl7ph/Fpy3tbxz2d5CcmEaEVJROovy6bhJUIwlk?=
 =?us-ascii?Q?PptkCTd6UHNTTi9AELDOHYyhwxiU7yfArkDdx7rCoz/H0YYQaILi7taiQGKq?=
 =?us-ascii?Q?oBF21hXwYqgQi9Tlu+4d2+/tmNJy1K8hUKtPvQQoiZiUwc3fMok5VOC/LR0j?=
 =?us-ascii?Q?98fM0oE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7908.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/x/fV4DzQ/8f1kZNGtv9D0fkUFdkg/L/4fsLnb3TRzC1QJl7eDcsgDYl1RGl?=
 =?us-ascii?Q?HgJrRQ2PUjgE03iQNYw634WJ/+1roADzq7FWWq3+BSaq3h3KCwklhDsFdSLk?=
 =?us-ascii?Q?NrE3W9fVRI8Z+dEZvX8P2kuBpJShvwafVmEiPfz+RusJetzkqro8DD4FaaUq?=
 =?us-ascii?Q?TgH6sOJHXa+olIklg3d9I0bwjVHwozif/cIPROoGAYx295IY+uRVu5yr12Ru?=
 =?us-ascii?Q?kJIbx8glNSK5greiaiBc8FUGq9pgW/NySyTn3lSBcdwnh1tial7wUaDgMFyr?=
 =?us-ascii?Q?cL/hA5ym+JlJfne+nWAB6w501mqbbRbJvoy7sbfVwSrN6smcOP/7p847LxY6?=
 =?us-ascii?Q?qoY17yZDai2AZG9ISppnP8NVL8RUv7RnhQdkREuSyQjD5HcL7qgcmZs4XOdQ?=
 =?us-ascii?Q?yVp+xq3bIN8ch5jWhIc3+ldW/Fk8U5hOXG2pFDO8dDfvhfADBhMJPlpfcV9T?=
 =?us-ascii?Q?JuA9l7T8sjDEEf89gFlxT+DVrF7jZnNoawKedUFtJSrOdjCWswQFJ8h1clEP?=
 =?us-ascii?Q?CEOyWY96FiH/gsUgWWuOSQ97+8as2sMZaiUlInMe2D1EAtYtU+AHUX/xQfs0?=
 =?us-ascii?Q?Wu/8ckaQLgjXuZCV0EPrS+rM9cFhBM85BDQUEqd0ZdDZm9HfNWg/cq827kp7?=
 =?us-ascii?Q?LkOiw1wtQgkQVxMGto+rxgTT8zXKCtM9g3+mkm7QddEqj9BNcpnISXQR2S1E?=
 =?us-ascii?Q?BRYpOmVRGDU5NRUMM9Q8+GeqEsGcJze62jh0Ob1gRa8mbF/Gey0kr8JmJOjh?=
 =?us-ascii?Q?Butx0X6b7T8tqcC9r92TcTOLaLvj2hozPKX9HpeBUb1UVbqo4eVdrTCQvMwz?=
 =?us-ascii?Q?Ll5LTEaFiboZ0xsB18j4xFUxPkrhhne3g4eTdebqz/7e9bukTc+crfWpGC6J?=
 =?us-ascii?Q?55yNN0wMYKpIXHn7dSc2Zlol9Bxzx36ggw5wovSgRz58JILUJqRzS6LZybPE?=
 =?us-ascii?Q?PzC89U8pQWYAOFiFskyBMBSMJuP71dPbXpngbhsn9Q5ix+bFftS883darpzV?=
 =?us-ascii?Q?Jph9EceKdEjx03JSk0Yb1LKC9ou4JDlOUaMV2K4QYG1njS51fBdGviU9jBRB?=
 =?us-ascii?Q?B6gA8aKU/pkBic4NhA3S9wclsZZQCboj2F6Z3MWYRlRFuC0OMUI/tADj9xXl?=
 =?us-ascii?Q?SF07rK/Vqp44uddic/geaSEChDXyKz/GADVQmm1X9We/awrUXUX/USSXEFUe?=
 =?us-ascii?Q?6/zsgWxYpn6EnNthudeGfOusUZlgYmdHCCJ6jx8GrbDNCbIm4GS48AHZWFY/?=
 =?us-ascii?Q?OqJROIOt6JyVrmYbmNBk+XKFo+KG+957smo3NEWDUXvV/oLNpn+TJ1jQCo4E?=
 =?us-ascii?Q?yCBky57Yp1uGzzMFJ2ws3AQBPJZhMxs70uDTXmtvxqGwo/ehBzL+ug6N1k9i?=
 =?us-ascii?Q?zsjr6bxZ6+CrWkt/+ezs0YDAZnF1gZAAAFwiVnB61UoMU6PY3zRFATJ3gq2f?=
 =?us-ascii?Q?FP9f3Gt1CMNdXFGwLiw1jmqPD67hFAsp3/DGY4zyRZiz/8bFZdp9K2p03Hvm?=
 =?us-ascii?Q?aD0v3to4aqR15SMLMh83gajrXsICDY+ANRDSZQlhsgTZJI58iiA+Be35XrnQ?=
 =?us-ascii?Q?hhVis9T4KE+tbVQUfAV4GXHuL2dayfzd9LjvasDax3axRvaDAmCttCzZAbHp?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: supcom.tn
X-MS-Exchange-CrossTenant-Network-Message-Id: d88cbd80-a434-4a25-9b22-08dc88935c4a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7908.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2024 14:49:27.4583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8f85f528-6195-4e97-8e41-f5a9ad3bed4a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVLza7U74J3uTt0ubmnrF6o3cEsHgLgpG6npxyMwSEuBWPLs0X4e0vIVjQI8d44WE5q6mRUmiJM02Iogq/mz2OeggMgBqrFkI8ktC8KWhYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8131

Add support for vivobook fan profiles wmi call on the ASUS VIVOBOOK
to adjust power limits.

These fan profiles have a different device id than the ROG series
and different order. This reorders the existing modes.

As part of keeping the patch clean the throttle_thermal_policy_available
boolean stored in the driver struct is removed and
throttle_thermal_policy_dev is used in place (as on init it is zeroed).

Signed-off-by: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Co-developed-by: Luke D. Jones <luke@ljones.dev>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c            | 125 ++++++++++++---------
 include/linux/platform_data/x86/asus-wmi.h |   1 +
 2 files changed, 76 insertions(+), 50 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 3c61d75a3..2e3d8d8fb 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -97,6 +97,12 @@ module_param(fnlock_default, bool, 0444);
 #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST	1
 #define ASUS_THROTTLE_THERMAL_POLICY_SILENT	2
 
+#define ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO	0
+#define ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO	1
+#define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO	2
+
+#define PLATFORM_PROFILE_MAX 2
+
 #define USB_INTEL_XUSB2PR		0xD0
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
 
@@ -293,8 +299,8 @@ struct asus_wmi {
 	u32 kbd_rgb_dev;
 	bool kbd_rgb_state_available;
 
-	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
+	u32 throttle_thermal_policy_dev;
 
 	bool cpu_fan_curve_available;
 	bool gpu_fan_curve_available;
@@ -3152,7 +3158,7 @@ static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
 	int err, fan_idx;
 	u8 mode = 0;
 
-	if (asus->throttle_thermal_policy_available)
+	if (asus->throttle_thermal_policy_dev)
 		mode = asus->throttle_thermal_policy_mode;
 	/* DEVID_<C/G>PU_FAN_CURVE is switched for OVERBOOST vs SILENT */
 	if (mode == 2)
@@ -3359,7 +3365,7 @@ static ssize_t fan_curve_enable_store(struct device *dev,
 		 * For machines with throttle this is the only way to reset fans
 		 * to default mode of operation (does not erase curve data).
 		 */
-		if (asus->throttle_thermal_policy_available) {
+		if (asus->throttle_thermal_policy_dev) {
 			err = throttle_thermal_policy_write(asus);
 			if (err)
 				return err;
@@ -3576,8 +3582,8 @@ static const struct attribute_group asus_fan_curve_attr_group = {
 __ATTRIBUTE_GROUPS(asus_fan_curve_attr);
 
 /*
- * Must be initialised after throttle_thermal_policy_check_present() as
- * we check the status of throttle_thermal_policy_available during init.
+ * Must be initialised after throttle_thermal_policy_dev is set as
+ * we check the status of throttle_thermal_policy_dev during init.
  */
 static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
 {
@@ -3618,38 +3624,13 @@ static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
 }
 
 /* Throttle thermal policy ****************************************************/
-
-static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
-{
-	u32 result;
-	int err;
-
-	asus->throttle_thermal_policy_available = false;
-
-	err = asus_wmi_get_devstate(asus,
-				    ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
-				    &result);
-	if (err) {
-		if (err == -ENODEV)
-			return 0;
-		return err;
-	}
-
-	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
-		asus->throttle_thermal_policy_available = true;
-
-	return 0;
-}
-
 static int throttle_thermal_policy_write(struct asus_wmi *asus)
 {
-	int err;
-	u8 value;
+	u8 value = asus->throttle_thermal_policy_mode;
 	u32 retval;
+	int err;
 
-	value = asus->throttle_thermal_policy_mode;
-
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
+	err = asus_wmi_set_devstate(asus->throttle_thermal_policy_dev,
 				    value, &retval);
 
 	sysfs_notify(&asus->platform_device->dev.kobj, NULL,
@@ -3679,7 +3660,7 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
 
 static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
 {
-	if (!asus->throttle_thermal_policy_available)
+	if (!asus->throttle_thermal_policy_dev)
 		return 0;
 
 	asus->throttle_thermal_policy_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
@@ -3691,7 +3672,7 @@ static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
 	u8 new_mode = asus->throttle_thermal_policy_mode + 1;
 	int err;
 
-	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
+	if (new_mode > PLATFORM_PROFILE_MAX)
 		new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
 
 	asus->throttle_thermal_policy_mode = new_mode;
@@ -3730,7 +3711,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 	if (result < 0)
 		return result;
 
-	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
+	if (new_mode > PLATFORM_PROFILE_MAX)
 		return -EINVAL;
 
 	asus->throttle_thermal_policy_mode = new_mode;
@@ -3747,10 +3728,56 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 	return count;
 }
 
-// Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
+/*
+ * Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
+ */
 static DEVICE_ATTR_RW(throttle_thermal_policy);
 
 /* Platform profile ***********************************************************/
+static int asus_wmi_platform_profile_to_vivo(struct asus_wmi *asus,
+						  int mode)
+{
+	bool vivo;
+
+	vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
+
+	if (vivo) {
+		switch (mode) {
+		case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
+			return ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO;
+		case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
+			return ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO;
+		case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
+			return ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO;
+		}
+	}
+
+	return mode;
+
+}
+
+static int asus_wmi_platform_profile_mode_from_vivo(struct asus_wmi *asus,
+						  int mode)
+{
+	bool vivo;
+
+	vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
+
+	if (vivo) {
+		switch (mode) {
+		case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO:
+			return ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
+		case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO:
+			return ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
+		case ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO:
+			return ASUS_THROTTLE_THERMAL_POLICY_SILENT;
+		}
+	}
+
+	return mode;
+
+}
+
 static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
 					enum platform_profile_option *profile)
 {
@@ -3758,10 +3785,9 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
 	int tp;
 
 	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
-
 	tp = asus->throttle_thermal_policy_mode;
 
-	switch (tp) {
+	switch (asus_wmi_platform_profile_mode_from_vivo(asus, tp)) {
 	case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
 		*profile = PLATFORM_PROFILE_BALANCED;
 		break;
@@ -3775,6 +3801,7 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
 		return -EINVAL;
 	}
 
+
 	return 0;
 }
 
@@ -3800,7 +3827,7 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
 		return -EOPNOTSUPP;
 	}
 
-	asus->throttle_thermal_policy_mode = tp;
+	asus->throttle_thermal_policy_mode = asus_wmi_platform_profile_to_vivo(asus, tp);
 	return throttle_thermal_policy_write(asus);
 }
 
@@ -3813,7 +3840,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 	 * Not an error if a component platform_profile relies on is unavailable
 	 * so early return, skipping the setup of platform_profile.
 	 */
-	if (!asus->throttle_thermal_policy_available)
+	if (!asus->throttle_thermal_policy_dev)
 		return 0;
 
 	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
@@ -4228,7 +4255,7 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 	if (code == NOTIFY_KBD_FBM || code == NOTIFY_KBD_TTP) {
 		if (asus->fan_boost_mode_available)
 			fan_boost_mode_switch_next(asus);
-		if (asus->throttle_thermal_policy_available)
+		if (asus->throttle_thermal_policy_dev)
 			throttle_thermal_policy_switch_next(asus);
 		return;
 
@@ -4436,7 +4463,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
-		ok = asus->throttle_thermal_policy_available;
+		ok = asus->throttle_thermal_policy_dev != 0;
 	else if (attr == &dev_attr_ppt_pl2_sppt.attr)
 		devid = ASUS_WMI_DEVID_PPT_PL2_SPPT;
 	else if (attr == &dev_attr_ppt_pl1_spl.attr)
@@ -4745,16 +4772,15 @@ static int asus_wmi_add(struct platform_device *pdev)
 	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE2))
 		asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE2;
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY))
+		asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY;
+	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO))
+		asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
 
-	err = throttle_thermal_policy_check_present(asus);
-	if (err)
-		goto fail_throttle_thermal_policy;
-	else
-		throttle_thermal_policy_set_default(asus);
-
 	err = platform_profile_setup(asus);
 	if (err)
 		goto fail_platform_profile_setup;
@@ -4849,7 +4875,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_input:
 	asus_wmi_sysfs_exit(asus->platform_device);
 fail_sysfs:
-fail_throttle_thermal_policy:
 fail_custom_fan_curve:
 fail_platform_profile_setup:
 	if (asus->platform_profile_support)
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 3eb5cd677..982a63774 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -64,6 +64,7 @@
 #define ASUS_WMI_DEVID_SCREENPAD_LIGHT	0x00050032
 #define ASUS_WMI_DEVID_FAN_BOOST_MODE	0x00110018
 #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
+#define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO 0x00110019
 
 /* Misc */
 #define ASUS_WMI_DEVID_PANEL_OD		0x00050019
-- 
2.44.0


