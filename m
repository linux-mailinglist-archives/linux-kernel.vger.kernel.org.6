Return-Path: <linux-kernel+bounces-169442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265478BC8BD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9249C1F223EC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9CE140E23;
	Mon,  6 May 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oC7EP4ln"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2108.outbound.protection.outlook.com [40.92.99.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B478974416;
	Mon,  6 May 2024 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982282; cv=fail; b=HvQHsFfTgxD8CqZKd8/kG1PvRQ2ZvA5HxlkU7vNrVoeY3ZlAwFavl6Z+kV/vKR+ftrCZR6CT6USpAtckH+dYNShMKEToy5dWdmwpFGnR80mYZrJfp4kvfKcQsbbJUQWNBq9HyyCvwwxGUpPP6/mD7qjhiCRsZZGzTuEOONxpbnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982282; c=relaxed/simple;
	bh=6ZhsiI2Z+Eeymbg3soI0kTIfWbxqovFkughqKOjLoBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LGrmiBECAEx29qUIh9qZ0Je6mJY7AqYsx6tPYNXksyBc0R4mOljn3ksd3YsZElPpFZuXZv1xIL7lfZUgg7Ijo3ZjHrUm9Km4vg+KbeQ1gjtYsgT4jWSuK6xBux2RTBb4IxezFOacaQsScaXr3Beqs+wEDFFLTBkRJn9LkYLycLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oC7EP4ln; arc=fail smtp.client-ip=40.92.99.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8KseQ4t7zdGUVPkPn02F8PAY9MjUSeghgGzeWc8zMRyQwPSMBlNavpnbr7/67UIa9A+wlNNGyRgwfEw50PGZUhUg6/za7SRc2ehLHk81/xy83g9sVqJsIulefKPFJxBBK6CIDlOHkpF+ll4GM8WMf3GlnEiRf7OPBlDHYTWF1ZA4abUAY82SiR+RLh0LaCnSsMp+A03OWG++nSHiUIhGP/4mvFMkbJE3USpLTQzF4b+mZMxoo+FLN6sLA82657z3sGQ72HgRvgNIlegdimy9RDiPZRmgyRNQRxzjeA/N+OAEWkGe9Kppq/7JUG12DF2HgeXWpjvL+jC33MVxssECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Fj4yHonbNn3cYm9KyYLhRfHhkce1cqcWTrQ7DHyWqc=;
 b=WAuLdoa0eOD8aRwApWEBqtCWPq1e3yx4U+dP6SuaVNEqPsABge29x/iC6AKBECk6z6MyT3sUrNgg1krwisFWe0N46qB1l3o4zrbKnq4BVwA1Xgt+t2vi1e9SQMA8SHlLaMDFAjoo1VsB+YqINuw6+24rf1G0qpPvo80GGHMRsfkl/rpVk8BrjpukmNB76sr47Z7PLTGbZ0ZTJQOJpat6cvKZCGjbCfjFpmqXKtyyU6QaokMkOW6LZN7NFIzShgkZbWBbV1qZ/JS+V1ts1YGFiXipPknhHR10O/hegKEbRuOQkjiFOzrfEJQXEe+8m99p3qeixUvVhOloVLHixsL/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Fj4yHonbNn3cYm9KyYLhRfHhkce1cqcWTrQ7DHyWqc=;
 b=oC7EP4lnsKz1kPnapKjDQTsPuaVaHvdGXIU7Wz1ybrcr3bQkw31dX4CxYDjIvzvPuXY94d7CgTFgB9mMsoJJLS8r3oc7VSOsmHrfA5o0fhxd5moUiJ/pVo8fVLkUBtB33Fiyh2ugB9PNX+Dz2806QefJmuOV31/LGTxKEpkwJ6m7SR1UNE8tX52FozPLIqVBS8PCi/bqRJOtsM4vKhpChmT4WZlhUVsfYvjOjSgUEM4QXCZCPRiwVuYAkNV8f8YQqIJI8dQz1ozSwncSby++IbvFInJHn3+MZPW59XcWJBjweUlBIizWAMaSN+3MZ2WQgSjLa91XO/J/zetN9XA5/A==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by OS3P286MB3404.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 07:57:57 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 07:57:57 +0000
From: ArcticLampyrid <ArcticLampyrid@outlook.com>
To: tiwai@suse.de
Cc: sbinding@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	rf@opensource.cirrus.com,
	Junhao Pei <ArcticLampyrid@outlook.com>
Subject: [PATCH v4 1/1] ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7
Date: Mon,  6 May 2024 15:57:46 +0800
Message-ID:
 <TYCP286MB2535097837AF4009B503AF0EC41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <TYCP286MB2535B1F07F7D6E7045B5CA69C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB2535B1F07F7D6E7045B5CA69C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [3kq2XzvRqZ/DMTVkIcYCoAs75bDPjzSSsEAkUzi/Cns=]
X-ClientProxiedBy: TYCP286CA0340.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::20) To TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:209::11)
X-Microsoft-Original-Message-ID:
 <20240506075747.46942-1-ArcticLampyrid@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2535:EE_|OS3P286MB3404:EE_
X-MS-Office365-Filtering-Correlation-Id: 1628bde6-53f4-46c9-cabb-08dc6da23e3d
X-MS-Exchange-SLBlob-MailProps:
	8U9+OAG/EBKBQd51+oDGzxLlZa0VSMGWTpslDkAoPz1GhCpdJVE5HgxvlXoJyHvIbsn91k7EvsVzINClbtuDZX0UQAo/NvnVrtxKUVSxOcyOFXxnZL7+ZsBPp3/zQ456G2hJ8olPYTpshMpYtULVy04T7K3VGBMrlKBC8b+qf0GNIIMeJNaj182qVVetDPOPZHOiuIpHv1VsQU75n8ozZCQ93HPlISZV0dwFDMtOQB3SiXUm4SN/pDaukNSxUWpkCiPiP1kGra6ATcKq54zBWybPYmvMxzR4HdFbCGC5JrTrTBvnlYZqcTFIEYMVPaqxV2ys2XsnEC+Lpbs2FtrwkWEfmVzEbfCwUBGK9TkD/pnp74iEtba8ygj7gEQnF2JqFIAnsEaldZMPaBGa78csNUzm+KjuUdp3YnwGmV0nMs2CwzuzNIJkQQX7JxUpXq61rdAKMx+sHq+ZH5xHxijqV5H4Vfe9HMCEPGpYBYvtA5l9V5uFcvRs/2D+bh8Iphp+ovlcI/xrtXXMjuk/wzyT1gLDx65IF2s3J9yReI23ihLBLEVf2q5ChWDzSSrVGlq+terX28PTmYjMcQUyP5HdCW1+b6DyaeRqnl2ksYsI8ru1V5R4PLMbc4ukJvIFjGNF/Q2RjIbATYlw+vhix1+jE2SKFMEn9zK+cEeDjDNLr3+1SNZqVC0Rb6JWb7sW3+PNqz9CDkOp9cFDYdQ6k1NuPc+SqSAnDvUfhhANK/Em8AwHeZNgsyTtPR+CYkN/0K5BjNedvMUw6BlHl2e513BsdUQ6thVIoeJ9W0HJSMByTjRueSuIkMJxk5ZDoBNXCud401OkV6YfJePon6hxZFi69w==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	xxj4S27ecXjGWn005jXilZIEy5MZfrzi/ZtEohZ01rwZxsumOnA0gxKCanxUVrmX2HiY8vmgDAK77VaP/JeopBtNlG3vt/CFm1P2CwYBAz6I7awBxPFU99dA4UCwmd7mhxdvb8gPCDro+qHdtKtY2KwUlm2/8IQlO8pnU1N9Di4lYfsekg3Ndq/XJj0Ee2/fjK3Bk4IiX/ZzY+ZIJzD/odEqUKKZwKV91n/Laf+gHjzPa+3/rpJlLuQYz93oIQK35twfcr2FZJ7HXw7M7Cs5RKWDy+D8NhWqNiQIXHjN/fGw/f7/c6AgUa2iSbvlUmFGL/S9mGjokAId4GRysGMlRHpFWOgmqBq3W/EYsm1yxbkvT9bW/i+4Z+DtRTn0cuHyLlMlyFtQgvMyLbKeHErz4H6gx43BGMsd/7NgC/3CygPlapk9KMNb0Zk0q7uQhX+AMDd7SXWAs1PsdTBxUhijJf1oYJbdFKX6JjlkGFiePNxny3Q+XY672CbSf3lbw4BQX2TAr7t8lXR1wCLaDVHkIGLwnqm9WW1HnWmgx1JMrSMZEoGOH8qEReMyfQg0FJpf51210/yCF/wi0FBj4j1h5whRDqi9tauoZdFqjbwVL8PV1ytnYbaLYth3hgS8FBQ5MVjzujpfI+IoXTjq1NcIUMwCxibj3IzdIybaE9+3GIIkJUfQIvt/MyQaeUG9p8bQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qeZGnxYr8AHLrSGm00+F0PETHyaZfvAXWTMI1+d82G7H6ugPzpVKZiP+8JqT?=
 =?us-ascii?Q?Cm+Dx19lrPwzyhjFlxHh8TOpsfHehZiqmkG/UNwDxei+dgwREVLMWXyHQwa2?=
 =?us-ascii?Q?YyVYM+dkY6qZFu5yW8+41nkezhjggMqQubfyqFJqC9SwtrLEq5vsK51JTQdh?=
 =?us-ascii?Q?WJPikKJPkfzAsuMe0Be7qFUBu5wL1JUqBEhPZDmGopbRMwTbCT6ueoGPXwWU?=
 =?us-ascii?Q?SRWiVVJx1STm4iJCq7AfZJ59ZJpIB/R30mPvCjppK2LksGf4jq/mMsTTghDL?=
 =?us-ascii?Q?LoN6/ClI4cppdpINp3eA6ZBrcSJkBkHfb9DHOP/8o8VOnk6dCQo+hxE77ygo?=
 =?us-ascii?Q?iiNO0t4BqmBIdgRKPp8n1wt+UqDYzHNLEVklDKB7viM9hahGoch9QXkO6eK0?=
 =?us-ascii?Q?am0WJqhp04k/1bomsyOgaBp5cqYuwsZgJzFjzl9FLWZehaiOjVqPnjlXo7Sd?=
 =?us-ascii?Q?m5MUhuC2P2KrlHP6J58J8mgEL+Ifvj7oMIErkuRDdcdMc6dxXpS8bJSCi07w?=
 =?us-ascii?Q?t/+dllzALOnLH2v8OtLbf0vpeN4X3UWzk7ptpcGdPGzjjCpMMn7EbPTouSkp?=
 =?us-ascii?Q?7fXqcVaqhasdFHSg/oOh/th/lS/garPZXgHxR8+v/Sa6OcrJRDVKI32fvh36?=
 =?us-ascii?Q?oZjVhVbRGyAowJyNu1ln06WD6lTdsIR/gtDDc1kIHeohBMgF5+WILV2lntR8?=
 =?us-ascii?Q?RPYzDepf9t45IE8p2oaMSzzPVx8CnVAKLb1EHsBPQ55diWIYXzv+d5Gbdet8?=
 =?us-ascii?Q?PNJ8m5s5CBgxjwiXLnxDb1wKoQcdeMqQTJG+R1DptO8YrodnfRWEXtf6/Fis?=
 =?us-ascii?Q?5LqRz+sl5gYd11KcMzf7TXVuwB/F/k5Xo03ZemhVh81Xem+Kb34KT8LPpZmR?=
 =?us-ascii?Q?KhdCDcPIzAedtRJqXPql7+3iTjp3J8jsV2Ox/l3HYEwAb4uraC1Dnj89G2NT?=
 =?us-ascii?Q?YrFaHg9Uom+ADR2S0wUqEt9joVivRMomMoLu8sFyZrDxFDiS0/efR8/oJ4RL?=
 =?us-ascii?Q?ymBOJdzZlpU1cgFUSw88O0c8sM3ufEJXbq8uiPStKbnFypTPtzURKpSubpIn?=
 =?us-ascii?Q?HUyyNmfomsWhupgJfeYJG/Pw36pOEGJ7uqRMo28rLJ3CH6npcJHm5EfmUWly?=
 =?us-ascii?Q?n6N4oO4hYL2a9ULVHZ/Iei5YB06c2TefztNxy9dS2cQ7a+hGx9CnqL7adL6k?=
 =?us-ascii?Q?lqTnqd584Ip4EIbctQKEODDk9i5/ovXQMcuYlPxNENr41JA2P+AVghWqk8pj?=
 =?us-ascii?Q?pXHSkBRepi64h7LpMTzG?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1628bde6-53f4-46c9-cabb-08dc6da23e3d
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 07:57:57.8674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3404

From: Junhao Pei <ArcticLampyrid@outlook.com>

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


