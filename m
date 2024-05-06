Return-Path: <linux-kernel+bounces-169416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A038BC861
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D95281C05
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9356413FD9E;
	Mon,  6 May 2024 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lRANuV1w"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2027.outbound.protection.outlook.com [40.92.99.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3756137747;
	Mon,  6 May 2024 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714980593; cv=fail; b=e3WIzta5brzDbwsih1aze8V50MtQTf7BQf+JVWXc3n/BiI9PWFsoZ6WGP57cKj/a04nEgX0AKEG/E8EpyOEoLyKppTIgZtCQUrZNp8vJ9a5BUZQyVbHouYTOGHoy6336jeeJlVHFt+dj9GDAPJEszPz4Zn+gpYEQhkr0ET4BsbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714980593; c=relaxed/simple;
	bh=1N1aR7JQCOwYa+dfTwPn3wRV4vy2PH6vJrQmOEnth0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mpf1xs7sWcGR+q77UgXqqEgJV1C2gCivxzrxVRLhNomefDnDY9Zj/KWlvPiF7gEGy4ykToM3PE5XqYp5qUikJwhlFOy1j72asnKm1hbBGMzfSSDqEicvCqQkIUqbO0gHuqnJGbGaMzpb+OyhI1tHcQKEiEjPiZNHXwr6jfB02pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lRANuV1w; arc=fail smtp.client-ip=40.92.99.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbGc/XKOJhpmlCwaRYmXxAvAr5BHUN3TKB68u9DL8BxdSHL4njo3HqqSslvRCc+Es4Mim3ZJ4Xbm1UQlW6MQ8QDQcKSpzHPzkaZtj46cuT3CBdUmxkPoPoyJPccs0D5Un6uTESI1uEb7tRtDjHFS3aNvgjjeLjO2EQPj6AFKrWcCqMm7gVdAPcm2lO3bxHOlOH0glcLi5oIzcZHR9q9JH3iMeIb0xojX0BLYPM3CdZXDvd/Xq9KQsu5VFxsKnxcpoAirIpclGKUCSSCSK4YoxBj3ji6f0N5Z79Fc7m7kAGfBNFS1AC+4EQKILvWD1PPQ8aVXyvcbyePgBfvBDhX4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6luzOSUPRdWp3nncD5HM3XEkvoQI0vXxyvSXy0p2u0=;
 b=V/ekIliTtxGOIOiD07i7jvstbk3jB6PuXETSJaL9fkPxnjHoXlHdzE9oxF441n5gdqrC0HyBhdyCu8aF0+IKo9NzDWiyIsolH1ggUtoYztpDtdS5qIxQ4f+y3k8i9NfnD6phDx4EQiWaZYCKJGpc0ji0JQ1JmpvSGTe+F4nkIS60/xmkn8yK1yEOUX0NAYYwDZJxWoKO9GXehvHt4eREvdC3quBAUcp/ixyEtzsPx2VcYZckjX5Rs7A+/EouGkBZHMTs9Qf7jv5vKof14z0P3aBWNk6WQm1vLvkvy1n4gghpB3UYAAHfjRholKpxgO3N89gp/McnroEH5KsTv+M+Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6luzOSUPRdWp3nncD5HM3XEkvoQI0vXxyvSXy0p2u0=;
 b=lRANuV1wnwkEFfkqURisVWtAuJMxoSzocJg/UdWCcOhz7floPIQf5A1ukcDU/8AN7jfK/22wPZkzorn7ns6w2Cde6qT+NdkpEUMxIjMXfbkptJ7obhqtZBiEprmS6TE0/sRgbOyPX3ymtNJT3snOncpwAoazZ+/o/KKJxuDrGPtujiV8zH9fy8nKpjW5a+0JuW6o3NlQtPE3E2Pc55vtdVL1EBLSiVdvSc0bhcKuFgQVEakXIfsAkhIB3VitPZYO9tDZ8oDEX+PtvAkuKBk9kuZdUa0KLGTnspoBmmyYJjRy9Tojh0yyAT0EWiq8h4rC3r0VyVmengpOTk7qBtCwKg==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by TYCP286MB2880.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:307::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 07:29:49 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 07:29:49 +0000
From: ArcticLampyrid <ArcticLampyrid@outlook.com>
To: tiwai@suse.de
Cc: sbinding@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	rf@opensource.cirrus.com,
	ArcticLampyrid <ArcticLampyrid@outlook.com>
Subject: [PATCH v4 1/1] ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7
Date: Mon,  6 May 2024 15:29:39 +0800
Message-ID:
 <TYCP286MB25352DD7AD08FD3C0F6F01A4C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <TYCP286MB2535F8C34EB5E3D826B74C17C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB2535F8C34EB5E3D826B74C17C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [JXLz9AdoOHaSbjfh4UnyoikYSd+/ch88]
X-ClientProxiedBy: PU1PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:803:29::23) To TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:209::11)
X-Microsoft-Original-Message-ID:
 <20240506072939.38255-1-ArcticLampyrid@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2535:EE_|TYCP286MB2880:EE_
X-MS-Office365-Filtering-Correlation-Id: 372cdca7-e5af-4410-b86d-08dc6d9e4faf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	WsaNzUgXwkU9AScE6FOyuJ/eJFc3i6Ry6STbYUU0KnDOBwmyuJGwRnQhxug1NV1S1RpYPukhVqJfldw70ri0dAzjm5YnY1rM3rciHlHc74mZhrQPFa58ZxU+V+ObGAYBDs4RQ0mwg3rMYQFFtbl7udJCeZof8Esy/GlWmWr7ZCiawA5XqAGvCuT/uWq7hCz9OR/i3ClLnXPCiTBANDWa6udM0zL298ja8WMf1K+4cLDzbHmobqJN6ahaWHGlOQXL/rzfcW8k/WeStqrtLYbQiCr0FnLQ0Lho2/qq1hYeedpBeJJ9yRfoFaL+wXsZcoXoanlnxQZOLpRFzT1tsL8XiX+jy9q9hdvZNF4pY/u9mnYUWZVq75YXxLkfare9wID5wIIKAuaFaImZz90ElPaGfrkXwhBDM58etQmifBckqNtq0tu9KNkiGsg3faE5TY56XZukyqvd8Sa+NcVoho6+FboavYgma+DXnDit5AEmGUIVN6fr20Nn96JU/LzdXUalfXwXJyY5WbtgB49e5D6nnZggz0BJjx6J28H7vEqjfwlKnukboN3c+hL3r6zLtH1vhvodqhOVbrjGtkh6DaJOm8Ry61OT/p3BhAj73LRPijdck+90xV1Y/7sqJmWkhU12lo5S7WeZ58xfjSDmmKmPZ8anaeF6Rfe2go77iQEg5zwQ6SqfTp/pCt40h6/AJHPX
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TVeWoQEbGErcwlWH5Xz+J5/kAZO1lFWFgW8QVdLqrr2DhjTJP4WbSemjlMga?=
 =?us-ascii?Q?zQyQF/i87kzuTCq1zMnC9UZMUhs3yNQ84mD+tfnBXTjRyZ9WSIvIJt/KWRc0?=
 =?us-ascii?Q?mDmg45t88LEDLFmELgZFi29QoymePDQ5ludNt0JN10RA2zld3i96HMBsmt3E?=
 =?us-ascii?Q?BQgcfvTFX4McIjVqYbsIysTYB9bzfBo5F4FS9eVSw78cYa9aw1k1yN7Z9EAW?=
 =?us-ascii?Q?qtyvep0Y0wOPonNjLWHtYZoiDrxsG0wiA7KhVQh72BhUdQ2ZEwHfrOCWMcRR?=
 =?us-ascii?Q?YY6keJUkWVO7AJDXB8Ho9kiYKUKBPr4+EJ+OeN9kDlJOa0tegCZxMxZMO7no?=
 =?us-ascii?Q?SZDN+GWvh3jTshgx3UNUBZPq26tVREd+iWUSjBbe+NBlJbg17LSVT1cZPLVr?=
 =?us-ascii?Q?A8X8+8aNuPEOWFCYWlLq2Ab9Vra5kAYrg0q/VEJBEnTb4UJocMOF5GFgHGs8?=
 =?us-ascii?Q?QmqdTfQOlL1W+s4BKcYhleH7PvJoixK/VxCV765M7nMqR6t/zNFWOZ4TQ6AZ?=
 =?us-ascii?Q?PE9hymh83ulK8mo4pfE+JeB5Id+nhV+87wG9ng2yENYbRR+Mmvj3gDi65cOG?=
 =?us-ascii?Q?dBwk7Putc48jTjvcccJn+vUN6QdNPJYpJH5fUlVGBd8h22K7ilPMFahIni+4?=
 =?us-ascii?Q?SWrssS7bLr6YCqke2H/83HN+7NcxlzcxiIAXJDCcoKg7ZvdDk8cNBMP7AcVM?=
 =?us-ascii?Q?rLYFM6ZLFi4/B6U3kKJmSOfs2fKFrVK+ATjIjjpdBZXLMM3kJwFdT3cGyWCz?=
 =?us-ascii?Q?6LHLOW6L078SLX+HxrMbOUZEwPphOqxY7pgfHuevxNi7bIKzHw3JdTFxLpPD?=
 =?us-ascii?Q?mr6CsJH0bsxZICOAAMyPJO5QMqyVEYB+ylixMPDWbSNyEdiDn9X4QMpIl/Yn?=
 =?us-ascii?Q?QtEF3/N8oT9JC5NvlM4iSVOYQR8VjR+/y3I3Y4g6uarfY9ehV0TuME4m9cbw?=
 =?us-ascii?Q?EIw7dRX5uk+W9FTYWTivfglzi24eGoW+koeK+3GoX13v9zEYkDMV9W2xPjwC?=
 =?us-ascii?Q?VGzGWVPgx3e4GJPFUoVjvXNqpcJoFFHXuf8KM5D10MYG9a+ac2wOzRcqjeos?=
 =?us-ascii?Q?lXH31y6SXk4du64og4WbzcTZTTewtbjeNz8j1bC25CK+Tjgzu+nYuEQlcHJH?=
 =?us-ascii?Q?XkiZv1ijrZP1kzRnb+8M/f/yn1XOAqaU02HSWxP673HITZUgx5Zac/uVsazD?=
 =?us-ascii?Q?TVNIcTYu6CQ6bN3T2ISgMx40UIo+Pkdvi1hpuHQzNYXrGGI3BzVUKYYcB8uT?=
 =?us-ascii?Q?YN4u/okyngm+IFBsPKzZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372cdca7-e5af-4410-b86d-08dc6d9e4faf
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 07:29:49.0570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2880

This fixes the sound not working from internal speakers on
Lenovo Legion Y9000X 2022 IAH7 models.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218744
Signed-off-by: Junhao Pei <ArcticLampyrid@outlook.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 sound/pci/hda/patch_realtek.c        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 8fb688e41414..ee195737d388 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -109,6 +109,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
 	{ "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "10433A60", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "17AA386E", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
 	{ "17AA386F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
 	{ "17AA3877", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA3878", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
@@ -500,6 +501,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431F1F", generic_dsd_config },
 	{ "CSC3551", "10431F62", generic_dsd_config },
 	{ "CSC3551", "10433A60", generic_dsd_config },
+	{ "CSC3551", "17AA386E", generic_dsd_config },
 	{ "CSC3551", "17AA386F", generic_dsd_config },
 	{ "CSC3551", "17AA3877", generic_dsd_config },
 	{ "CSC3551", "17AA3878", generic_dsd_config },
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b29739bd330b..5c13af8a11a4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10496,6 +10496,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
 	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x386e, "Legion Y9000X 2022 IAH7", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x386f, "Legion Pro 7/7i", ALC287_FIXUP_LENOVO_LEGION_7),
 	SND_PCI_QUIRK(0x17aa, 0x3870, "Lenovo Yoga 7 14ARB7", ALC287_FIXUP_YOGA7_14ARB7_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3877, "Lenovo Legion 7 Slim 16ARHA7", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.45.0


