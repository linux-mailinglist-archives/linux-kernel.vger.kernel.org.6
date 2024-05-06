Return-Path: <linux-kernel+bounces-169441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF158BC8BA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4551C21455
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF2A140E22;
	Mon,  6 May 2024 07:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Fx6fOxCm"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2097.outbound.protection.outlook.com [40.92.99.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54541140381;
	Mon,  6 May 2024 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982226; cv=fail; b=e5tCjxOrCFmS8upYaImUBYAdxBhep0XKAQUGL1bmm1zGXeTmWx62Dph8MVtIeqUOrDq5RymY5DCOrvM2D7vFjvSeeX7+mlUlGA1jMtyiR2p9UgWmGbkVprx5l6yENezPaWbSG0LlMUJbnvrzNz/yaJgyJSsmMfn+R2bFe8MorKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982226; c=relaxed/simple;
	bh=SQTGnV358UUNugOVVY3uztrcZdoT/meNRqazz9Mbkok=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=q9D9ikLhkoJQhg+a0vmLWbl1EPXJ6yTk65aQhl/oEfVIe1whEKPB8p/I0asZcET0vb6a7Vq15pFFb+wpNKYO2fvEV11GcyzifpDQLwUAKpXKoaI6bIhirAIhCvpJw38Oddxy1SHJJfSyUCrtr4QUCbnjj5O6W6GY95gU26f/33U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Fx6fOxCm; arc=fail smtp.client-ip=40.92.99.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmNLd7hrKn2e5mfqrnqhgZsnSUwwg9Vk/oOh7hVii8GooNrfcSrMbIe4tqOCRCMZjNC8a8tTmCClunhMrvamaYfWjvDiYc1oghNFDMwykMreFzRSDZm7W0cKZ5C2IK7cpL7mcfYZBrO1BD5gR0YdV2Tg5k8h6gcrsurC+BYd+yBQiFzI3C7PWJJj/wHSOmAaHBaeQrjIZu6rbM8Lhe8LYDBPAPOSDY2fnFGjQkEJlKSUmU8MylSA73VAG50KICNTthVAxfys2gJr3XgOh+w4EplLTAttjOiIIfBIot/QWidrAJ9rl9LZeIiNQqII8x0dq32R1BhcJSi3CcA7c1LXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcWxNXdOa4P43BCHH3IIZR29LKpYjOGi5i9/34QV7B4=;
 b=m9fwXxtJqz7gg2JjzXANxt4rdToZxY+Y+h1J+DoaTfJ0leItmJJ7eIscyTrKejJ1KaPLYhgtB6M5gTY/BF0YQqd6w1Db8gud/+VWxzXQJElkk2NvREt3OIRaD1lRVpVAvIOUAK2TpnDykJOapoaLHbf3kyP209+R5n1dnvt7aveFICsB5ofLsEv4KqxBanIhuSuaqoi9s3QM6dhDv2ULCNXpMkfaYhOU9v2w0QmHfGV60L/nC7B301bv7JEOUMrJF581udzRtvKi/qznD800G3LSTYADs5khnRaNaEq2mReI9KMzcBzj5ZE7khj62CXonrhF2y+I2xiRDPAn6kX7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcWxNXdOa4P43BCHH3IIZR29LKpYjOGi5i9/34QV7B4=;
 b=Fx6fOxCm6eJ3WZvD1p0RUO6HfyXcVI1381M+SSLsRIFCUb82W8SVcQANd/ReBSv+H9QUuVBEnOa5HorkBXEhZuo7fhAb6ODw7RCL2gt1RETSjrKzzZzlwz7NV2JGc5ScIgE2dLbHkb+Dp4N8Ld/objOgbDWz3If4wv6SZa5XULRJsjHDCZ9GUAPdcAVwOOjvTuNlItYM1npVNzujrEYxaYjIQkI0qK4DvytBBToBSCSM7nxtstzCEY259enLyuBXKGA0ZfZ3Zp9SwZkFtRDw28mfdVxju4n97Vfdh+IIF77bAtXnyZarlswMWpWfJ4EiIbM3fDnhdDmJXWH0l6XQ+Q==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by OS3P286MB3404.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 07:57:01 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 07:57:01 +0000
From: ArcticLampyrid <ArcticLampyrid@outlook.com>
To: tiwai@suse.de
Cc: sbinding@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	rf@opensource.cirrus.com,
	Junhao Pei <ArcticLampyrid@outlook.com>
Subject: [PATCH v4 0/1] ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7
Date: Mon,  6 May 2024 15:56:50 +0800
Message-ID:
 <TYCP286MB2535B1F07F7D6E7045B5CA69C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.45.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [IspXuxNNfv410FM9+Shegcek+19zRy/5KvBcPcvjrRk=]
X-ClientProxiedBy: TYCP286CA0343.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::11) To TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:209::11)
X-Microsoft-Original-Message-ID:
 <20240506075650.46382-1-ArcticLampyrid@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2535:EE_|OS3P286MB3404:EE_
X-MS-Office365-Filtering-Correlation-Id: 2312afb2-ba89-4069-5274-08dc6da21c8c
X-MS-Exchange-SLBlob-MailProps:
	+b2+gf+2pHQ+UT5Ti/Vs3G4YckIn2X8h0e7jQRsb/TxYDTB2piB6ocvznE1Zkw2YVk5LtZ1mFWD050rJqJT944rAI3MQkfvCszkdwUtRL1+TRvAgxPU3wSoUyMWsK8lkBsZmrHlsSpVQ/OFT9BlWIlGck6NrpS3QLoTHS+l3+XmKvrhwoCk1XHDlLIHwsnlEp2erzaN5o3M/BMa5fSjVAiBXAXIwYtgZhh9ZYwmV9jX98P13Ge/JLtCYB8yk4UvNfWTtc+6vrl/1WnbFi/bH6EsRJ9xPq9vjjYFCudaQR2ZADO9XLeERJ84EONVK+a42fsO6T4bRdB+1lSdpY/LneHQypBrDm/9yQXC/ljD0iCM5wxKKcbrhzt+463+JtWzpCqc0YKK8Rvn43dedc9T6OBq6N5HQ8cFXNIvCHxh8bwLD9o4O+9fjtnfGzaTbowNXiPI5HQpjUlD8hq2XL4l7+opI35cbWNPwHRCdH0x3BvmuAtDuU2uddS6lJ96GGJedvyAcAf8p37afn6HuXDJvRQs+N4ZMRhqTPg9CrMJq/NQnlJ9SkqK/Sp2ydCY6W+vt6ljXRFNMYwM9egsFeG8AL0MbQLySmCsvVC+nXFQ+m7LKH1JmoaMFC1CZwe17M0vLZHfArEmCXLJi6rcXrko3a7dblglOH1BKgkB6yfKTMg3MyfsT+Z9TFO8REXFDa4XK70w8GUdytpwl+P6PwFHA/ax31h4aKOsDFvLfstNOVUemMsZovlVtouSMnoDcscb4SW+8qPm3evyK9LbBbqFU1ksNgDRVaPKw8cF0Kn2h7IjBt4dGwfg/VNFKiDoQwapFM3irS1gJeOh/vNnxbyv4PwK7U0MgBjrYPeX+Z2lmhUDpdUL5kbil3g==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	JuvCQP0a6yc8/CtRE/yYxM8rpJYV8WyiaiIX9KeO68FqtzyJFBDmkcNNcX0Dk8LG54i7qMN4OuVvlMC0iieS/z+KW43BRsBliLnnM/Scl16p3wyN8j0O4O7+Eqff4rrii3c3k/4ACCdPxkP+3Z+Zfa02AQ4DPkt1OM3wta7tVv8YSfYjjw8Q+LLLhW7bGJ3uk4Zwn6df4BfShW2kc/MvyXTZRdS5rSmNCxNFETkkoPql/Zb5+apEES7N+LkfivMQkLRDKQW4KyR3L6Vwni4PFTK2ma/6ffjX9gE8EwRKDFMseD8yirQIdAKWSj0AdkttwGCouPI3vxlv7g/1fIWT7xUOP07qG89DNcqgc5gfBraXsbL4N2g/fAENh5YYsIWcIP1kro4Q8NoF1RkFqRxWAYP+N+CT20AThtOqiR9RqHB9zLSJ5S1dLK0EkQ9IwXWMZ40rUr8p7dtVfSZk3qG+qK+BAWuxv+98urRqvA9SHHMM9HQEaZxwpLfho/wHNoemIlD3AonznHQNmkljlAsjHgBufO1WPZFCSFTXh8BoFM81SJLZNqUSIrTZ6TDPc+RCLrj7rkb8rdhVcykFL/wBETkoMpomfUiEGKtPkrXLrpCQF970LTtsRPb7RpgF6il+Q1H2Nly0oTbF5aZYA6O1e26DMAmaP43ARB7ZBl4xda8bJyJ7XJkvTw3Uz75nDIi5Q4hw8Hjm/jgJ8QiT2aSJ3g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+A8VEGDyRdS3d8qV5p+EJlsbrc1me4swntjx5tKHQvfmlqmmrJ0OdLSwmENC?=
 =?us-ascii?Q?Y3gdJe1EOnZ7El46DYOoatKvPLJbfPOq9AbLz4klkcsSKS8C9r7FgpOyofPO?=
 =?us-ascii?Q?A/5dSwuMZSqs+3EDHS6uuBCTWmTghjEm6kMxvN5BwjQ5HjIYill/8tNPdfdY?=
 =?us-ascii?Q?9awtKLQCLRKf/hhx/EoIQXtZLfqQuZ5RV00lcbJaK79Ls4m4PciuIdTLwlCy?=
 =?us-ascii?Q?LAImY6FoUoRDoJfYzjLK1IseGrlYjAQcCdncyj2Z1q2VqfWpizhMIdOI4rkg?=
 =?us-ascii?Q?V4Kdva17PwxTcf5WkPhu2s49yjNM9QYApz1imOWi5LwhK3uaBP+0dGqQmNsX?=
 =?us-ascii?Q?KoetAIFT5uFRFk8UBhAxxXd4o5BLy7kQbxb3VB4heFpqnoX0OPtmOv0T+uQx?=
 =?us-ascii?Q?r0VdmXvZSCM8u2wysA7HZqD20/trnUJa1iFmN0DXg5OolmC8o24f/3Ij4lPZ?=
 =?us-ascii?Q?kkJGGTVEjCqCUx5PastV1L7isLCdPgncCd1X0SLrcYFT7kOUNzU0Mg5pVwlO?=
 =?us-ascii?Q?UbuDkFEQEB77gWX63dm4cZk4u/kUia4RyYJiaqCVnSehRdBv8FgINcFjKuaf?=
 =?us-ascii?Q?YxHMg3EiHB1MUrUvqAFhXM/QOLsLkHIj7ebk+Ua4gq+HzQcyzBqpN+czp9Z0?=
 =?us-ascii?Q?K/w86zMjGr1qa14S1W34vd6OxK644haBeb1gKY0tizwEbwgtUE0cdBcXe7Qf?=
 =?us-ascii?Q?ERWwZ2PZ1+tqFqXJb4cuVb3MPl430ciBnxt7kmV0l6DOyDMyzQz9DHrLFLLB?=
 =?us-ascii?Q?HkjdlcfMlNpzqn7TJxrQ5jAmHDB6QTzjbPzy4OfyYD0oI0xjcsTk2lxz86Gc?=
 =?us-ascii?Q?oJh9lL7XT2dCcpQL5RA0+fqCokgy0PR6bcvlt5P2g3mEqqtDQdE+heBxwYpN?=
 =?us-ascii?Q?7dOePeWyOeCHZPtzoyWwvC08uLmUzhOiaUQUDPJJpR57wRTCHNsWp9dlDeVe?=
 =?us-ascii?Q?I68AE4bBKdG3DiGSpU7a0WscVtc2DUpFvacEKk9ixjZjf0CZsGqzsoA1ERL8?=
 =?us-ascii?Q?WVu6Rlsp3ORzT0F3PmI8QOvo3uaceVChXHIYLP/NafM7z9xiYzZkhQDfr8l5?=
 =?us-ascii?Q?Kwgl015wwDgn9V+Sr4xkNnY8+jJCRN2Yn3n7JX7ag0NqQHt7Jt7MORocIToY?=
 =?us-ascii?Q?SlsXJ1BCG4VoQ73z3PMJfz8gU7Q1xU+uSXb28HqeQKxDacDETk8REIidMQ98?=
 =?us-ascii?Q?a0V0qTKtipLWASyw607BLQYE+SFe7xy6735el6Q/8t9DgQoeKZ/czSS3roFJ?=
 =?us-ascii?Q?9szl78XlNAr6CcgNpR9D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2312afb2-ba89-4069-5274-08dc6da21c8c
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 07:57:01.2344
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

This patch depends on [PATCH v1 1/2] ALSA: hda: cs35l41: Ignore errors when configuring IRQs (by Stefan Binding)
See also <https://lore.kernel.org/lkml/20240429154853.9393-2-sbinding@opensource.cirrus.com/>

Change from v3 <https://lore.kernel.org/lkml/TYCP286MB25357A4599E935F26A8AAB24C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM/T/>:
- Remove the patch for cs35l41 to obey the trigger type from DSDT, for it is rarely used, and
  the existing samples (Y9000X 2022 IAH7) has wrong trigger type in DSDT, which makes this change
  useless.
- Instead, ignore errors when configuring interrupts to allow laptops with bad ACPI to play audio.
  (via a patch from Stefan Binding)

Change from v2 <https://lore.kernel.org/lkml/TYCP286MB253523D85F6E0ECAA3E03D58C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM/T/>:
- Correct spkid gpio index.

Change from v1 <https://lore.kernel.org/lkml/TYCP286MB25352F3E995FED9CCE90F1F6C40B2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM/T/>:
- Add a patch for cs35l41 to obey the trigger type from DSDT.
- Avoid disabling interupts for second amps.

Junhao Pei (1):
  ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7

 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 sound/pci/hda/patch_realtek.c        | 1 +
 2 files changed, 3 insertions(+)

-- 
2.45.0


