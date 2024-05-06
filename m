Return-Path: <linux-kernel+bounces-169472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDDC8BC92D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A23E8B210F3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03C0140E2E;
	Mon,  6 May 2024 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hlo0eir2"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2078.outbound.protection.outlook.com [40.92.98.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB21A27456;
	Mon,  6 May 2024 08:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714983054; cv=fail; b=ZL03GLHL6wPurE6DfIynbEmyCJPBx7+KCSn5/bw9HMGt92/6HmxY5bU/knGU1c3XFF43t9VHukp3v//C9XWyMAXO7Y/JD6F8RQraSJ1tJmOvx+Lxwfb2pxP/+6TRwCvfk4ReuFJFy6u0dMK9pSgQORZ3ZvNR7JngsJ2eBIMXlIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714983054; c=relaxed/simple;
	bh=+EbJCqwf0x4kv8pvruRMqEcjYN9sRX9uOgvMZJoAmHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OS7t+iadVyBEwckI+LTehs7BW63di9SR6w73W1e/R+eXUyKdSjBZ60VygyM3fC9V69RhgaagH39xI9LjjM9MJcErcR6QY0+60MVkex15fBnIHB8egwB6Dm4IQUmEhDHMiueKJZiMth+y3q7GuUYyJ4rwLTJ7jRhnzOBm0vniv9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hlo0eir2; arc=fail smtp.client-ip=40.92.98.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5yrsyWNYVY2WNg5eKqu7Wr1LEOJioqK9DkPBZCTWvcpsjyF3BcEXRWX2E6CHQh37W58lk2TJYmCJt4DOo1jr2Thlgvl21Xq6+77huoZrtJ3cJBVQlMIf7YpXX4KPlY2i9m5rcLcJaF+g57yPQjdBPHADSXxHMG76DeSv2ZqGCVHAdAiPZj9sRrixMhZiZGd/zHT1/QN+w8EBaJ1UrP+brUPwSHKONcwCjc+Hyd4raSYtX/k5BeRBCjvobxt9Z141m9Y2jAb+P14GD6YwlVlmqzSM0VtYUbhBOCFf96TLf+8j4qmyHhMtjoSJb8C617uuc+YFfzaIgf7MaOcBbmPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGoLJqoLwl12o/2YaUAIzUkK2IQt9w4eRNFjPy2HiRY=;
 b=dTf1/ymg5HO7014o6LSpkz4DuoiZCOdEUgvBiGeGCyObLaCsQALGDJ2Bp0CGXsdjKxCH+zF4XZSXFbdptfD+TqvVcOazQYvTOH5fVMWz0KGZRtHBCjKSPDPyKs9D8M1zMXa5s2/x4hG6jSBh5mEhYTRvbpx342faZJ8BsCpxgLqLXyoTqh8sQQy+BdeJksDvWvXQcyxPfpJhoqbYQGpBWF+dpCvlXJB+BAAPt4CLNKEDc1jpvdRhHoYTa8/1OePVwsRAIuIko2Bokodmy8JgyCau3g8r0oQfzpv3lq5d9xqsplps0Aay9Kl2eV14fAAggh1Mg9nWjVHUKL65Rdwk+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGoLJqoLwl12o/2YaUAIzUkK2IQt9w4eRNFjPy2HiRY=;
 b=hlo0eir2FSyJ+NQmYfHvuVbiijfPGhC5F+F37BNDpjbHqc0r/ldhf/cjCti3HWoRJ/+xgbaWwzi0eZPnhH4dMlAWjr1Xrrnh8OsNwK6iW+de72QWLeAj2Cmc1zC/XTsKLMQzT9xWFnTnRtSleY8QWioJcV8+O27TMajLqCsdAFc0kbCJhgpJ/Bo4UgBeUaSPEBs1qQUCOxhpSET88SAZqsVPXbKEuO2GB7UU+hZ6cnHHV+qy4PmkxADQuD+p8OwYgJe4ATpHH9/Z5dA20QjZKjPJ1ATN/aMhTj52Ml0F4evjlKKFqKvc2Sn2lg/1kdOQzts8suOJUr8UugvZ3rdB0w==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by TYYP286MB1523.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 08:10:49 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 08:10:49 +0000
From: Junhao Pei <ArcticLampyrid@outlook.com>
To: tiwai@suse.de
Cc: sbinding@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	rf@opensource.cirrus.com,
	Junhao Pei <ArcticLampyrid@outlook.com>
Subject: [PATCH v4 1/1] ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7
Date: Mon,  6 May 2024 16:10:39 +0800
Message-ID:
 <TYCP286MB2535ACD5188A91C000B7CD13C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <TYCP286MB2535E8C7B2F9E7EDD75C4382C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB2535E8C7B2F9E7EDD75C4382C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [DAAeoqFVB92Knt8dtd//yZsfgOf7QdeFWyCkcFfcasw=]
X-ClientProxiedBy: TYCPR01CA0205.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::6) To TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:209::11)
X-Microsoft-Original-Message-ID:
 <20240506081039.62830-1-ArcticLampyrid@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2535:EE_|TYYP286MB1523:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f692fc8-6885-46e6-ab83-08dc6da40a73
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	OgjIiiW0KEvLp8AJngVvUPNrP4Qp3XztZkMy4s+lXdCA7QketFpWyd3Nh0KyMrZO9TwLeI4IoJyyMlQajAnv1QEETHt7L//L9yRAy1aFmG3XXitBAn6E+dkJImKriLTjcbWLxs622Wv5k7MQhD0BfTQsC9AQwTw6is42/KUsrqSxDPKo6kcHrRIUmgkGcJi4+gUWOahbwdPPagym63g2S1Kbedo5G/xM5QovJhI2qNgXBzEUEjFBZ+yH06QSndTGoiXa2i1EAAbll/msN+opw+oLriZnE78P1eGVKC1fOD75IOpnX7ht0kfcwsiWd7QRVUvDV+CpoMB8T9EBZ5cudqV17UCxmi7mEa14KqKj+wtt31Iasddcwmmj/CX2CQsR8mD+XKNP6+tVDQG6UOzbSEqy1V5a3ZIhbaB4ELCUf5/7osk1gBFaWSympySPyaN6Adl73aoaSLHNlRI8r2qGcoQtihXRBsuVCDhCtMPWdGx96Hr8SSdsgj169g+v7NHwdauE0iQFe33EIbyWbUgV6Le8xjTJaM/Xym9/Ej2kU7jzGaQwJvr5orzxNcrCqUPcWEcX+w0QTQkQT9sHbGxYQT7iV/4UPcjLYYb1faUaeMHFQxTlLjQgePAiNAT5KcXwJ3M39A7fno/gZLkXP9MzBCP/3sgp9/JgGbXs65AkKjsKS/kMx0GCqaJaSmqqsRRE
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TOGVxwdcoZS6VYWcBj/hUolQuthXh8gD3S+tGriqlYDO00D5X458WHLvKPVI?=
 =?us-ascii?Q?lG2wbAy59pSuxEYdm3zWNJb9TpIKKSb15BJfOJRCtF4G8fI98ujq2Tkqi1Ql?=
 =?us-ascii?Q?XKyoaoxi17wN8Ot2EyyXjHCKY1aDcNPhurRJfAn6BemBlfm3gfM5iymmR8Bo?=
 =?us-ascii?Q?4hYfsW/FNENgYJTDXsk/vT+D5T5AffuSBXPBp8JNEGaiaJaxtmba/7ekgB83?=
 =?us-ascii?Q?MUzv1DOkmPgcHxlgKIUDFPJI2Em0gGs/de7DCebjXwIh6PB3KI/ioM6riuyR?=
 =?us-ascii?Q?do6Intj1LGon1it7Ga091U5HpD0SmDlp57pz9HgxilHh3OYBn1ZhxsT+3ViE?=
 =?us-ascii?Q?G/8wfs39rha7epEiBdbIe9jGZXeDkwzS+TrSmZoIWY7CQlkIuu19iTey3MsQ?=
 =?us-ascii?Q?VWfhk3viRPf5Vbiwk19ieqpUuE7Hg4r5vUEpzeMiVIBStHsTRTodBV/A0pSk?=
 =?us-ascii?Q?1b2gFuc6H+6xEfNyOePx8HPMfntnDSatgn8S7xWavMAO6jeONKcvSUb9dDbv?=
 =?us-ascii?Q?gVKjzEmGLrhrz8P2EK90ZdAkvhs6ipZ5EZku3scV7EMFjIGjTOjEV3Xgq3YP?=
 =?us-ascii?Q?5nSGx+/bYLVTcTp6CQpUaU0mqRmM2T/4N4x3NGAKQiO+t+Wg3GiMDdc0Q3tE?=
 =?us-ascii?Q?wvf+IWBSa8o/yBxjjrM58VGOixpF+j/ByoCNrVhCsXPX6YRWL0hmk5VgmFHr?=
 =?us-ascii?Q?exQ03Yc1yI0aHE2wZouf3RSXFZy+oaeKPQWt5UBOnbuxjLLd+t4YSsQsjcof?=
 =?us-ascii?Q?CtwiUxdHmeVYxXhb8xdCjmio5gLA72xYVZljGDENUgfcIgkBfwJ9qrYE2j54?=
 =?us-ascii?Q?Q05wrZyHQMqoJihWd9IEbo9HAG3UP2bL7itZyf9uNp7kODJiNo1er2gnLEEw?=
 =?us-ascii?Q?pvGPrqMKn6F+ab/wwgiEc6AlGmH04lLdvNbFThZT3Ma+sZc3F1isee6EHLu2?=
 =?us-ascii?Q?1nLGCifaVyu9z6k5ccrGrGfkiO8K3S2V2rb7nMNV8YtyIJmmBRXoyCjHZkxU?=
 =?us-ascii?Q?s9HrmwAUBVPT/MkoeLFq6Nd2G4mBd/SpBBmL6g5ys43LFJNsvFqP2qaGFK9T?=
 =?us-ascii?Q?aRVrHD00lZWTnlVOomDQR3vMP7+4B2bGvAsRMOgp/7J5J8fEF7ZAARZOzJeF?=
 =?us-ascii?Q?/Ay1VGKTGunTjWaKcMvRIP2k/pNpQOvZyxy5Ep7RFYcjSpruBQAIz5r0uGSk?=
 =?us-ascii?Q?nQhYZoBxt8bu8X47lbi0Z2gFPF8FMYgNgFwSEjYoNdmO99IdnY8iiLGpYPrW?=
 =?us-ascii?Q?aWv4NvNrVcffNrA4plOz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f692fc8-6885-46e6-ab83-08dc6da40a73
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 08:10:49.8464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1523

This fixes the sound not working from internal speakers on Lenovo Legion Y9000X 2022 IAH7 models.

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


