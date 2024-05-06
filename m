Return-Path: <linux-kernel+bounces-169413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267698BC85A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77FD1F20FD6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B733F7D3F6;
	Mon,  6 May 2024 07:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="h1n782Bn"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2049.outbound.protection.outlook.com [40.92.99.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7628757EF;
	Mon,  6 May 2024 07:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714980494; cv=fail; b=PYj/pM0IwGrIy7JC6cDQiliRFmxpsANBzuwLqjN5P7HtGAPdgHxU7XN3o0IxDyuWlojDQ/IH0/Cdr+2kYHoivRD7GNGyGEpRSiMrGYHm/HhpaiDOTXcPMPw2mh0kO7wCcl4ZgjNpu8CzbOCxn7nHR9Pg/aspjs+C1kOBxw1CmGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714980494; c=relaxed/simple;
	bh=VV0DbhIye8Cf4ocFNllZFQ6ke00TjkTonNE5kfdFMqM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GydjjlRPe+/M83LTJ10yb9x/RzCD3DE9GdEMzzRYaLbC5HZCihBMqz9AJ+8BquSgL3YIIeHsyYsLGaGXa6AqqYiaNjBHE6jk/9eRzHPrHk2bQi9J/ADZNg1O1pGSQ04FQZJuDepyqjExFcADJqbjh4GiU3148ySxKCX+Sde2Abc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=h1n782Bn; arc=fail smtp.client-ip=40.92.99.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDnS45pP22iSIMU7KSW/Zz2+RNFWyNN62S4Dug72iGSGEyApZXS8y7A0Aj/yMOdBLW/9LqNuNMjwSQnacUsR2DLygkdf3o1Uq+a1OvSeM4ZV6UY1QhCa8uyEOt8PwYe4n09ZtW/YZAObFNqFBSI8UY47H5jUAVNGtV8vyOVq+79D0nxqkj+sHU7FepCu5M+ufnFj78DRzSSvHUMSI8s/4mfHDQP+ZqC4OgOVWX9BaUn/k7AvgKMvODDKroLFgwBNVdwjTkinmA5cp3e3dytjeTP8hm+qlHDafvUdBbmw/dNjXALc8qKGtJu0TSI2N1Od6xhQqZfU/gZ9AozRLuqwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v72WQHyTPhGrYIzCgQdtiEl3r4rL1dd5Q0WuJyabzkY=;
 b=iU+FfYRbYu+wgSVHgSZ0jIBxwnrhYg9dd3ZbEdRGlSEYfBfv25P6SXwqYBwLYnp1EvvuRQknrgmPAYvS5xGoJnhhVlauGhHLg+BxhLBEJefPoXCQ4MQeLxoHT6A9LdhoXhVtklhJcj1E8zTIBRum8r3YeIch8L3CyLNzO5a5pmXVWlR2qu5z6haW1kNcgp0ywoTLdk7veLZmSabQFR11unm3UQc92rbACWsI/CWjWFusN7TvtUQQ24ERLxGE3TpNnHy96J3KpZK1H/pyxyCi9zHw8Pc26z+n6Ri5J5M3a35WmaR6qzYtz5081Emq5BR2CrP22p4RvfZ13u0iEUM0Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v72WQHyTPhGrYIzCgQdtiEl3r4rL1dd5Q0WuJyabzkY=;
 b=h1n782BnBkyne1EwsrYjHYUnhVqrrkafNAgvxqskHuzEEpLnMpWB5oEXyjxkd1Tu850sZjJ9aGQfPRm2eG6rHpBPIIdlM7USrYoHRATXi2EhHwCcHHq3HfKaZqyRxIG22zP38TVh/2BTJuqOjA6pMY8H95a30IRkmkJs/etIpa4DcBdHyEAxxZGEmaxERlX43lyY9YTxQVTmqEapidgC6d9aKmkE06JfbnsqRY8KFW/DhyWsf2V46/BEuus34Jn0JBgcxwIwcC83qjGG0QqI9oYCxYqfKd9ghT+PT2DJ0MZrVpsUVidViK9ZJYMYmxayUK7mwJjIHpjfsYrW0P2YAg==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by TYCP286MB2880.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:307::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 07:28:10 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 07:28:10 +0000
From: ArcticLampyrid <ArcticLampyrid@outlook.com>
To: tiwai@suse.de
Cc: sbinding@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	rf@opensource.cirrus.com,
	ArcticLampyrid <ArcticLampyrid@outlook.com>
Subject: [PATCH v4 0/1] ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7
Date: Mon,  6 May 2024 15:27:50 +0800
Message-ID:
 <TYCP286MB2535F8C34EB5E3D826B74C17C41C2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.45.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [/ZbDCzQmffZeUlJlrGGptitwpnRMvvQR]
X-ClientProxiedBy: PU1PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:803:29::24) To TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:209::11)
X-Microsoft-Original-Message-ID:
 <20240506072750.37272-1-ArcticLampyrid@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2535:EE_|TYCP286MB2880:EE_
X-MS-Office365-Filtering-Correlation-Id: 399e6aee-a76a-4976-a2a0-08dc6d9e1495
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	+9Yf+p+kZICbxfHULDTbwCegLaO5OlS2Fazr5Q79xZ0Pv7uT4zYrY3r3bwblIZ1XCBHgtf12K6JTHv5+ZZhaTYq8YdJndjsp/uesdIY3BzQTzM6jMAvCzonO9fAYKNz944yNhugTSMYCWZneSztkKckkD5YRbZGWQm1nAtoHIQEmdGPaymZ0H6uT+fr7uQwHnW/AAFbSYrbW26tiCy1p9JLfGRsGl2ndnqHWIVmo3Re1psOpIx0MQ4LJB5DSa7PMA7T7k92CwUUSaKJleGGEkUGijWBz+iwTJLFsBE9+snEewdqGqwLxtRMsWjhtmOgz9HxMLWck/EPOh/T9M7hW0/VK+Hel5f34xWiGFbV7ePm9oWduNrebBdc9QhwIZmFBO9+0WmCTS5ZIpsfZtnzLEv2SR5sBYwYaqNogYX7+ECg7mf/HeSFG78NrujzCzUGI/RGYygMY/1rVsHk7BRRRMPs3Fm5afpGeX8GQ1O/7uMfhNEs7Ffxi4waF0bcjVyCNBOKRyjADfD2PuB728uqCIyMFN0F3XJul3cZbXgA3WRstTV7UmIbmx5nKZoMZMBa5s7d5BsoW2pAgTVf1b0tcfoHCc+bgoPUMispOHVyCOVBzVU+t1PfOM8ryZ7XbdT9rAh1yKqRbB4KvtX4mu0HW899dOs5IZRppZALWv2seaHoqJW9CaSCdBDeHtHGOKzWHY330J8ZH41qXzV1rTUe5vg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZIEkEdByEHpNAxA5qGFidDODLtgZ+p43Ua5ausDZYWIKf8M8VYpJrHQjaMwn?=
 =?us-ascii?Q?qOcC/P2g0LZJh3s1Sfp2HJzDKYls9NEjUN0UzmOxRDyDEh/4fdnSDrero+Hf?=
 =?us-ascii?Q?RGIb+qVrahc28MdporIByip+9oSxR69HAVwkTJbEVjttswIDEuTF8czQp/Cl?=
 =?us-ascii?Q?2hQ5Afrt/seFldF9bVtHdro/Asjfr4ys6PhNumFC0XFEuldObUNlYlnJYdJU?=
 =?us-ascii?Q?CFeKgznz6cpFWYfNjuY3Kmadml/nUpw6COwf+YiWStLdgNVV5hg4t/mWb5qP?=
 =?us-ascii?Q?hyt/k4vubzF/gaG61JI1pHiilaBSxpbq8WG2/Z1dN+67EIslxJ0BM7yantRE?=
 =?us-ascii?Q?yoHKuWjZy+QriInn0wkpK0U/syDkGK4kF89ue0B0PNGgBLekX3z+DI+6dExx?=
 =?us-ascii?Q?s7/VFsns4GOd/zkeovh8Ju+GG3a21AC0ARDrk5oyKbIHmb/ML++7IAIrE46/?=
 =?us-ascii?Q?NlJ1/ja7+eqYQO7lb8h1dbiKqJVDsjxelogmRVeFcwTe+n13eLn4a9VA2PtS?=
 =?us-ascii?Q?y3RTxmaNTh0DYABd6tTpxLF6XdZmHDYu4a0juntJFyRHmzsCcQtCX1ew9KLm?=
 =?us-ascii?Q?j4vyXE2zY3cJozWVSqK2tQWz3oe7weCC2/ig8LIx5vLpeDfPYM/BX3QkbUip?=
 =?us-ascii?Q?h+wQoaETlzyLmuKJU2DHX/SZi0cwr2DM+FdPNTYMn5g3FkjQlS0InnypVPLd?=
 =?us-ascii?Q?Ldd05xOZcMhgvRgV2vFKkJAeXKdtVXRza/t+SqeuKqo5S3BASTr/jsGS13sb?=
 =?us-ascii?Q?fNzwN1Z1W4URVDo1Pw0ooZ5RrI1MDNC/EFGUUMyUJtcgoyh2pf+zpKoXOL9/?=
 =?us-ascii?Q?FRK2DB66TMw7DncRvGkZaG1OdW7imGEdVBbJVY8dkS8W/cGa8BB8BNosgJ8o?=
 =?us-ascii?Q?Qr2L8QuDKoSGNcfagY3g5pMeGoAN+BDu3RJiLFMD0uYVOQZS+O/qwS18TURW?=
 =?us-ascii?Q?xMuuS9gGIyA3Ht59iyyeSKuvoML9eL1ccu2Wtj0rxdahutUtN+3BTJjfVsbJ?=
 =?us-ascii?Q?uPSbO5xoebuTeASP0IpeZ4QOA3cVJjYvJLtzUM31QAgM1dnLs12Hcwn6P7xw?=
 =?us-ascii?Q?3Gq9BAiRcDj5shUKJ4dgdKPw+sX2YjcK3WWs1WZEa/llzEupLrmvWZr6F5pH?=
 =?us-ascii?Q?siIuL56PA6ZIU2e1HPtN0vRNaZ3p6JUQpaDl/zPJaRkR9zFJwXYJhdftsvGv?=
 =?us-ascii?Q?WJUqQ25tsO/rjkxFAg9Ap6PtGKTQL3uBmj+XrahU7oN0qeJSdqJ1mcm3B2uf?=
 =?us-ascii?Q?2HV8Oj8RLp33z1ix10J4?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399e6aee-a76a-4976-a2a0-08dc6d9e1495
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 07:28:09.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2880

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

ArcticLampyrid (1):
  ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7

 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 sound/pci/hda/patch_realtek.c        | 1 +
 2 files changed, 3 insertions(+)

-- 
2.45.0


