Return-Path: <linux-kernel+bounces-169471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C86B08BC926
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83CCA282822
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A94314039A;
	Mon,  6 May 2024 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Mpo0hmfg"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2036.outbound.protection.outlook.com [40.92.98.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7449127456;
	Mon,  6 May 2024 08:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982985; cv=fail; b=R0AlCj6Dj0sOPIUcpR+NQ1UVlS6txnNXs7EXRlqIwN7nP4coOsRT0FdxA6q6Gx65jqgfC6BdtIFiWWMQy26MQVAK1hSDANsp8vtl33HtuNrcij7dLDQH6ceKWcKlWmTsCw2jEOOZt5MG0VnvtRvcLJYR6PxjmY0qylXZKXgXvPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982985; c=relaxed/simple;
	bh=39RcingTPtAMlDiaC88eoTw93f55CjD3iWjHLFQY0g8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ssMw9g7E6YXxY1QAEgVWRt2Kixt7U3nQVrK53R9K2IEJIh/eFucub3NguJNY+28gVnLMea9NOBaTy6vd9ZemnQwttyHSVK5JBXqXHo93FppZ/eTjRxxNNkEdiNkrtlXHJpEZ+K+1GQb41op7YpST0SmqBgq5ysGES6Plu5URBYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Mpo0hmfg; arc=fail smtp.client-ip=40.92.98.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3ACGnFqwFOEzLa1Bh6CdirNzwTXqcg6zhEts8Nk3A/7Ltv2rVxQu+W+ppV7dwbb5x+MvN0Ht7SJAGuwrULM/LfUCZ5kwosQ/aG+HLllHzok3JjPAGWOKYZuXKWiuadgFgkUxQ8m4/g2LOlCiI2jGWLT3vwULIQ6pfdgkF64070jBlC/gnMP4Pp/W2MxUH66RNSQn92+TfJIu+WZnXZt1Yw+R5zBhbQS9onw6XgjTQs/4DRHK0LqKeXVt9zrY5xtki2SGwNXitOWN5SG8Xvl+lgiKms4T0an+wfcdpLkDgJcWo0D3y0os6BqA+MmZLBK5l8BMIOib3vRFam/sJ8rUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pU1HG2n2YjqugN7pz/7YST+OIaXV45r1A1CJfxzAseA=;
 b=n+WpZZQZKHPKfqDIfhoCtiayVvpM/oaaTVGHlJaDwTbhVuImhIoHTNqUW7t1Oo+KO8bZ8DOwljY32QRcUcFg5ynqV0Y392BwuNoy43T3QNtFkOw1ezn75WD8Fn7vdCAX41jFu8M9jD7+xtHvROTIQN9r0fu3K88rIDYCbPH83QR01+ry4znp1YT4himsUl2KCpBtva8oJ5WSkvAMqBce9O/G0/GFXwt6vTqhzbss6+959Sy2PMAEVFjYQc7lgal5lB1Xl74Bak1GA0rGQHWv3QAExOzjOnKc78qkWsuWOlpVAO4kBxfQwOX9ccyd5IGx/TyUcJePHxmhf+9CXRGoxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pU1HG2n2YjqugN7pz/7YST+OIaXV45r1A1CJfxzAseA=;
 b=Mpo0hmfgPDK6hanKs8Gg5+pChrNYOBdj8fJcCL8SqwD8GDjp8YBxrop/5mNabG4rNqZ/qxFizI3XA3S+fqC/qbUb4QrSuwY61RJPiCGCUvFoEJlLPNavqn25CSr2kIeUe0GAhOHa+hwj15B2oUJ50DTsXHR0kQE29UNfjW02/KFEof/WWg27BPbAXRFn+hIEJ8gLvZiXbt7YR/AyGclvuP50WOQzfi2X1REN5uqRJ+Z6Tb8EhEioLkvCp3K1a6LbVPOsiInViKXdluUN9C4Um8WK7uzT8DE5wWnH8IE6ffN2U8UL2TwthtqN50tA8GYD+dzR/mK5gowApMh+n+NnDw==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by TYYP286MB1523.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 08:09:40 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 08:09:40 +0000
From: Junhao Pei <ArcticLampyrid@outlook.com>
To: tiwai@suse.de
Cc: sbinding@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	rf@opensource.cirrus.com,
	Junhao Pei <ArcticLampyrid@outlook.com>
Subject: [PATCH v4 0/1] ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7
Date: Mon,  6 May 2024 16:09:27 +0800
Message-ID:
 <TYCP286MB2535E8C7B2F9E7EDD75C4382C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.45.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [nR+vI7soU2wCMsNo4Hmhjf2r/zOaAqBMjXQPSmJsqPE=]
X-ClientProxiedBy: TYCPR01CA0201.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::18) To TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:209::11)
X-Microsoft-Original-Message-ID:
 <20240506080927.62067-1-ArcticLampyrid@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2535:EE_|TYYP286MB1523:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa48833-6c32-404a-889f-08dc6da3e0fe
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	vvj0L9EAKWeYnntiqRzbeWjTqEEgTJcRvhIghnuWIwx8rUMGCdwqUilcG161PzBxYUIy1dDCk8V6m4AMPIU2ntmnB/3bj8E9TneT+fbFc/71Ydv7Kd+pmnXFmQAm7D/khkUVqpnxageN/03eYmFiF2ri56EpHoSjPDrH3s8EVo4MZ1RzYbXF/6YsDoNyqoQGa4rHIfdRrR5xYuZ7J9gbznh7PxbfZ8Gi5hpNXG1juw+96SGoMKL1Lp6EQ4QDAOQSM6lF2pp+bKLkTivupT4N55+dSxsjDFnM2oG0E0rWt1hoWWtE4C7CMDtZNUubamz3DwnK8AS1ZYpQPKAOv6BaYB6n6XmQ11nX0gaCWY40VHa79FsfSjaiAyLTOSRLCOsUW3Rm02i2x1Z/NHxnST6s4748czeTWgS+MmRXrnXmjnDCzFD1DS5A/YkRV4Reab/BlWo5pIOawMJ0aAPIWsWKvk1xenp1hLylmzJbLg6S07hj7D2J+2TdY3JRjgfs3cDDG2OizwcM82iC9np8yeQhRzhD0HNwFpx8oGIUvSHeJDsJrHEyLFSLoY+rbMqQRQXTfFDTw3YkTBcNCvPllKAveLX3b+kvGHIfNyf0iSiNVyGmV+NFT4FCw11/ELRN1AXxJqWQEpeABMIuc4BeaF7v7XsnkNaPA4uJcFg78QmDYNLwDL+GHNljH90lUv/MPN6LYx6jolsVlLEsMxO6Fgyxcg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7/VYRVOSimoxUFFR4btRUferj3NDHLNRL/o1cus8PNmNcUBhUQSH+2nRi/Fj?=
 =?us-ascii?Q?fDK7wIGJQJdgf0WwyNi4O1UBXRT7yiiTsIvrNG/vV/fzpv73kfPG2zseu3cX?=
 =?us-ascii?Q?76mK+sz0r0iDZIS59VCNl4mG1flPo1Nzc22HCcuWM3d9lwDEn+vvV5/7Q7fp?=
 =?us-ascii?Q?IvfkIV+RqbQMrmKPl0yejC1rgTNUT7h5nVpn5aI45vbdWdz+nRcEnTT9FxTZ?=
 =?us-ascii?Q?TKIgGOeE+WUiJv3YAAjAZkMDQaSU6GRNCSu1muAsHtT6aUXe8clxtTjqrbWd?=
 =?us-ascii?Q?4F7hwjeJnQ0bWziN1eplo+UvmWlQQVZ7QJqYrqojJ4pkq56AhRrAfdEton/j?=
 =?us-ascii?Q?gP+xabDeBFOUdBIVFk2v/7+/w7Mkg6ZOFt9XgWB9/A32si6k40lai6Fkbq9s?=
 =?us-ascii?Q?T77sGEccmChYNgjQ21oIPMeTm3yxtDUyjZa4nwNeIXoNaU3oDEDb/ZRSO2/z?=
 =?us-ascii?Q?0AacTker6DI//pBJ2zoMNzPnwhUVFHHDMT5rRhKvGXr1HmiXY03BG4uCH6kf?=
 =?us-ascii?Q?jVNAWInMb+Qwz7Se/3bUd3FdJEBY5oUl84oVf4YHAXYmYNGGl9O/iuOLZlGv?=
 =?us-ascii?Q?pvqNFNOIKqkLFbZ0b1HipXGkUaT7Hym87hWYGUF7oJBEwztZAZYi11GXT0O/?=
 =?us-ascii?Q?5Icgzj/f2+dg7s+qgC0qA4pnG7PLJJSWWQ/lZx/6JyBqHswHQKL5l8Knu2Wj?=
 =?us-ascii?Q?kvNTROS0po04iI/HnACvk58w1KCkWqF+Z0W0xoF5/LlTPbope2pXCK7RrgTM?=
 =?us-ascii?Q?xBtLWfx78EpM8+KS4KYCtfJ8PyU51Xf8LfUMs86VSm7MSAwxMLNXj9uG3B0K?=
 =?us-ascii?Q?3Q81lZeQvPjR0Km4PNIFGQDWtkRx1SRN8EY7sZJEOgw17R6/vk7qNK1QRtwS?=
 =?us-ascii?Q?S4HCm1Rn8vvJ1cRMia+fOJ/pWT8EawcB86ZznxUZvKepT23C84iXIAsaUK9f?=
 =?us-ascii?Q?toU4o/wOXTDx9xvmZuyNYDeVcQPpVr/o4ml4WqItc76rEgwpUNqFotb6KKPp?=
 =?us-ascii?Q?xQpgf0NaIDQyJ2E8ty+u9C1IMbRkKBtLrOvk98xf4smH97cHiLWCnAKjhXk2?=
 =?us-ascii?Q?MnjyV/CnMl1bwT3dgBFd4cO1l6/sBwl8LuX6i956LoDye4QocHnw3erttkmi?=
 =?us-ascii?Q?OLAsM4nLb50OPwgOm/tW9Il/7SF1uetd3FwxSdUSnI5tZCM2uEyiw2toiR4O?=
 =?us-ascii?Q?SwI6GVHrR78WYIGb8P12j24hqERsOPio2jxaiVxa4DsWAXXM1xE3lF1tX7oU?=
 =?us-ascii?Q?DjwrtiwPM7Zg7mcSuXJB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa48833-6c32-404a-889f-08dc6da3e0fe
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 08:09:40.2930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1523

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


