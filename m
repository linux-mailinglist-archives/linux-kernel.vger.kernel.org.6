Return-Path: <linux-kernel+bounces-356211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF758995DEE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 04:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9A01C224AE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E7B13B58D;
	Wed,  9 Oct 2024 02:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qdMdsxeD"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E303E20B0F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 02:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728442236; cv=fail; b=uQ5l/uJUKWw58GoRarOdj8RdLlWzPBgq77MuheDO6Lv4JGxxcaljiiH9KKLIEX29/qjkOeNIM2FCahx/4A/JFqv3NLGgm0puxJrhyfKbJhI0lCto3kZtASLGeN0Ipp395M/Hoowij0DBrZL17xwU7dUk/NGWZL/g1CysiQT2WAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728442236; c=relaxed/simple;
	bh=MesPHBy9AMXgIcyiGrYaqecd6vc6s2Eu1D+Hs7lcXtE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fxcA/owaPqsJySi5lUk14jAhcZakGwsQoykuQaTQR2NdJ5uHHmgFW5o9cYkh5M4P3crToZCXjrZKsnAMF36xXnMfo7OeAanWugWKlIUXt+rYGKSiF9sOSQG6PLDIyjDhp3hEEvh4hNalV1mBsYdSWPGMCU1Wo48igcjJyyx2rL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qdMdsxeD; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klY0Tqkh/QofPeWfGGLl9Hhe1CW68C2cXeSzhK0KZ7RcWrkodIXchIUqp+XQoHrZUvu36Fsigj74T5T9g+DlV9ap2ngtCcAncxC4YOMUKQc7qTk75WKPZW7WrwSX3kIwg1BNY/fK10DKbLW0hm8STu0jDAg2I58V0TcIIOBavDD45T2VlXwuMQeR8mue1uw3/fcHBXim1ngsyLZ2R+yWRZ0rprfqO75yGFpyQQsikzrzJomJW2qMf3LYq5m+3DFkyTSzGcf5mgh8aiTlqUrknqQymtwoH5Ot1Oet/mA90PalC+isOgLmT0Ya7eHtyQqeR4iKqaGI8LWlXZG2YegcLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9MCI123r/ELpJADf3nyJWnD0jeMU/uGAQJxG9X3K90=;
 b=RzCR4Fgn62NnPO9OApIqtjFFr2W8/s/h38yZyZ/EB6s6UgDjZT/YvUwv6YFLhwcLZTicdzF3tJeXf1usz4UMv8o52egA+aBCfbxGrdvG/EnTu0QDTojv0NHJkMRlwgfoxm9VjPUOZ/u4H/8HqS5dtY4KJxRQLmqxg/Xe638WlOeA/jzG+zWuqQpazqRWn0FMh2qGDOUTbhAtjwWCUMuJzOsf744nfYYYMuhsjH62BPCd3NP360lOzZIPLCif6KTPTGjNRiGR6aPW+8ev9gg/XzW+TppBwkJvSlKzGZBycn3DfIZvdUDjybiAgJW41COMGB2HGP0BornuOcLLHxb0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9MCI123r/ELpJADf3nyJWnD0jeMU/uGAQJxG9X3K90=;
 b=qdMdsxeDR8RECilYXmqZlBGt2UmwLwYJ0WFLX9wkL1WEKlvI+NGy0WSb8SySA+YCSlFDgx7ExLjiPJC0xp+fnnrXlxLXYI5kYbBH85nqcOkDGXu4FGm3wBLNocuEEcAaPv/OJD9Q2J9iiGjAs17hTQfMKKXk3RGXWbE1Zo1WfAWYzfqBmOM/W38LzpcfTlwn4MN5ouDVFMCvDSPfGl/FKO4XuTFPg4VwbPX+2a8xKAHFB0f0BnHcA/Zn/7zvKJ+MNDzfU4C8IvP8A2Hm6NtSBa/D5XS0SAs/Q4UkL2X/T3p8Hbg+x/zAJoGQW1KJHy86GNq157S//EsPCgtJZ6znsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 02:50:28 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%6]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 02:50:28 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	David Hildenbrand <david@redhat.com>,
	Will Deacon <will@kernel.org>,
	Alistair Popple <apopple@nvidia.com>,
	Jordan Niethe <jniethe@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] kaslr: rename physmem_end and PHYSMEM_END to direct_map_physmem_end
Date: Tue,  8 Oct 2024 19:50:24 -0700
Message-ID: <20241009025024.89813-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.47.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0371.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::16) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d53673-ecc7-4bf6-99e3-08dce80d222f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z81KeJV4uzocaARxve1qvMp8i0Yfj8Zx6B0E5k/tFWlFpU/GGD6Lnvu/EgeL?=
 =?us-ascii?Q?wuqfaXqM2xOjbOKvHxxlHPuHqmFdQlpK2GH7mqVVUSARXqIo5XxndINYr9q5?=
 =?us-ascii?Q?xfmJbtutNCdE/uyEvl/SB0zCsEwvPX1CAiZegZtZETk4h4Oems9GoJ5aPJhL?=
 =?us-ascii?Q?G0blKwVzkqcYSzSqMXLfZpfZEIS772y4Y9KwppLTYU5W/c3uAAPwMqL3bHxo?=
 =?us-ascii?Q?MwS77Pk2H/rZSGYiIddUtyS3kyMskzFLy2MHOnvTWQIce+aGx/6qm3kmDp0P?=
 =?us-ascii?Q?+Pbkc4yMEO9t7bJLSfU5/+lOpxIncq0AZm7S31+ooY3exNhoh7JqmJyE0mQ7?=
 =?us-ascii?Q?ngfGUVBWyfGbRNFOOdJieBGGfHigaXhAWpyq0nqEMpSfoBKvbFKUmT7eRDrP?=
 =?us-ascii?Q?GuMoCP4XxlSkWEGXfPFqSLGjEx0rpdtbKnho2gBmpFoit283LlcW3alIPtZ8?=
 =?us-ascii?Q?3TUQC5gBvhgS7dAY76OL9+DzJopSv2E/sHYB4Wjvr/T3t7xxOJVD98Dtx53G?=
 =?us-ascii?Q?sofXzT+yCVomnWubg9FtxEJkYWRRO1ubgRCt0FXbEG+s/drKvCaNGHTY7d+B?=
 =?us-ascii?Q?mnQl74MxUFeNHpIYdsNigWHjQmLwpdoMkXNCXpWSFu3RXxrD9V+5mbCI5uAS?=
 =?us-ascii?Q?LMgNFjeFF6AMeDY0mjs1ZgOnyS1zTRZv8hBO+pEqrmd2GJHMkrmp+kjhXmjt?=
 =?us-ascii?Q?nIHPsGr9kqs9pOJu9z/ZRpy5aGWIP5erYqcl4cDXVmfgN6Zu7pvdrT6HIvsG?=
 =?us-ascii?Q?NjUDrb7S/3hyHe+7xj5ADvkJd2xoyD+jqn77bkjqzwUR6RYjzTjCP/2EU9AU?=
 =?us-ascii?Q?HP+aOnWA2RCkiui7suoz8//IK54AnZAAwLTVrHy0qtDHJL/qewD1mvpf1hpN?=
 =?us-ascii?Q?C/4jPmBiOj5x5uwWNc3LVEb/OtDy99W7z5WmqUGJU2ZMNrxUYDrFDKKvEJix?=
 =?us-ascii?Q?OYzbora5rmEfN2w7ae7fi4QP8j3+rbfvqSw7IqA4FwNA2N1PSfoZoxahYS4u?=
 =?us-ascii?Q?7Q2eSMh7QRsPvRvU3va+6oAzsPdEfCg5hCJSFdNLfEgwLa7+A97mkwqsQgpL?=
 =?us-ascii?Q?ZOhlGiFG2KsqWBzX9WRLqObm6+l3uvNz1uFqTmiyEOxXDKzD+/NfWrSLVSTK?=
 =?us-ascii?Q?T/iFPFgxMiHJFWM09XnNVho8DmT5f9NDNY8bY4KMm3khRYh5R9zmnBT7TQv1?=
 =?us-ascii?Q?8LpW1JGWbHom7daJYsfeaFNSNXdz5+cehak0VaROOFdNJYGARHuO5m2JoEGT?=
 =?us-ascii?Q?/lQ/PN/EDYJWYEgitGG1B+2rmmpF/7gCR/NB5lGg8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jh5LVzpuPDM/7lLtpqfJxneAJ0uKhktlVX7NliLb+AmIn5cu4VIs6yntks5w?=
 =?us-ascii?Q?z/rpxwj0FeoxfZjb75lwiZ3OVtIzV0m7aqDzVBdMP8TGoni9n03htGMmdUAK?=
 =?us-ascii?Q?WfLQtl43RtR/BfTmoySRjuybW8PHRY2miJo3isa3EM4kapp4ch6v0Jps7pSm?=
 =?us-ascii?Q?SmeQWmZD4wIgl85gYzYAT/c6Xdl/jyxBYMz6ywcijcX7V4WddcGwk6m3JDG5?=
 =?us-ascii?Q?GIuH2oHmmR9tbSVLKvU1rn323DpmDD/sZtOUHYOVA6jecpMVrgImNB0JY6yE?=
 =?us-ascii?Q?Xk8jxoP/X0NYB7ytC3qIBaIyiEip8CnHiRNrq/uP4SPmQqpEwQGsxE/beoBs?=
 =?us-ascii?Q?BSA8w+p9wWplB0R41XkeUmyfo0hqxMDWQpUBl6QDBmcFz5GPzNVzq/06ekpY?=
 =?us-ascii?Q?hTu/v9ON8H1bjpoQf9+6LNxXJWHJT1ZE2sYY2i5vd/8nKOtOXevU4pCt6ubY?=
 =?us-ascii?Q?UXePn8YCfAvkeEa6kr7V5VEh9NQbHeLp1EHNbr9PZ18CJMlCeEyB3q2TQfah?=
 =?us-ascii?Q?/KewKrRSgPPq5NHetLNS/NCECiLO5nifx0EbIWtbTaGtpcEYwDXuHMlQvjw+?=
 =?us-ascii?Q?qND8jULFfLRaWb2W6q/ZmqjE3zVP5JIFe2E9WVVgqRVQaeIo/AimpgEGuT84?=
 =?us-ascii?Q?UD2WrlzYqqrBpuOD0KnStvVSzBLr3Gpn3Ee+N4jqG9HzRIwHtBaiF8d8mIvf?=
 =?us-ascii?Q?LWPBdrWDR9QDXSHJMEqAXg9dofdko3K3xte8FxKm9UL7t/u19eE1Edee6jed?=
 =?us-ascii?Q?fcpZYzklS5ZxeZhO6E+lUUgY3XP2HvWMJMy2+zK0iiA1ennWvzy5T62uQVhw?=
 =?us-ascii?Q?cr0xI6UmkWcZs0uc0ibSY797FxDiNbQPuDzUIx8YwBu0ykCfHGeutELUSwWw?=
 =?us-ascii?Q?uRxwN2p4qbgBGbhZfkPlrtpgKjoJ4hxmdfgSekufa+3VRU6e7rb0CLPB2VZW?=
 =?us-ascii?Q?HSG8a3AcxYlpWy8GXhg7ru+Kv/H+PmOnwWrP058Utv/W5eF68qZa0OOl4HUX?=
 =?us-ascii?Q?aBsZvVuCWXpom2zN+NUTXGBtSXSfG0DPv+JI2sos8x5DDXVlTG/OyD7fK77A?=
 =?us-ascii?Q?oGVtgXpbz99kgNLbHd/AFN/fAwvilhmkTahnV09AlMYUVGUq1FSgXaRkypdN?=
 =?us-ascii?Q?H8wfVbkzmi5236lAqJjU6bPdnKJzan1Bo2eY3QINXcYFGEJQNotNvz01G8jO?=
 =?us-ascii?Q?A4MRdrg7gITfzrxv2dCqiNc4nPgMJ4FojSZC1RBVHajWMy7yXllMogjzl+3T?=
 =?us-ascii?Q?dkf/yUWJnY3AlbNNxTxDPcBgv3AuNBWp8iryR9X78p2PEkPj43Uu6OVqgjxL?=
 =?us-ascii?Q?pbvM1Sj5vq2UTlgFmqGiOTtP60ABco2urWjlKKzpPckkOZajynps/5XNwmyi?=
 =?us-ascii?Q?CT8b8+PRx7a2fMmLeoS6FLuNc9a6PsKwJeNSc3PcBmo3/GXDGkBIL15tLtNq?=
 =?us-ascii?Q?TqAYaK6fPg/Wi+Wmntwfc1fydqIi/CGJ4iifVfXmf4z7vGQhkKy3buyZJrXa?=
 =?us-ascii?Q?OoNf0/nkfRsdaeVxySTxFsyouFk8Bd8r17t4M4040xv/QMZtWV8GjWqxNdpt?=
 =?us-ascii?Q?S5ec/reNvom06Y+2aUtxYGjiYtuy2dcNZArkyeuo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d53673-ecc7-4bf6-99e3-08dce80d222f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 02:50:28.6449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXKEyM0G/VHjKpI9AmmXQJ1k5qrvLMMVr25jPlfKWlmJXJHWEFzp5sVwW4dlznuvaJUpUlnfg3zFXo43BaqThg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121

For clarity. It's increasingly hard to reason about the code, when KASLR
is moving around the boundaries. In this case where KASLR is randomizing
the location of the kernel image within physical memory, the maximum
number of address bits for physical memory has not changed.

What has changed is the ending address of memory that is allowed to be
directly mapped by the kernel.

Let's name the variable, and the associated macro accordingly.

Also, enhance the comment above the direct_map_physmem_end definition,
to further clarify how this all works.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Jordan Niethe <jniethe@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

David Hildenbrand, I recall you had an unanswered question in this
vicinity [1] when tglx's recent kaslr fix was being reviewed. Maybe this
will help with that.


[1] https://lore.kernel.org/linux-mm/ee205448-5fdd-495e-9d7c-c8a2b59f9c9e@roeck-us.net/T/#mdf442f077c9023590e144dbed2b04a109793484d

thanks,
John Hubbard


 arch/arm64/include/asm/memory.h         |  2 +-
 arch/x86/include/asm/page_64.h          |  2 +-
 arch/x86/include/asm/pgtable_64_types.h |  2 +-
 arch/x86/mm/init_64.c                   |  2 +-
 arch/x86/mm/kaslr.c                     | 14 +++++++++-----
 include/linux/mm.h                      |  6 +++---
 kernel/resource.c                       |  4 ++--
 mm/memory_hotplug.c                     |  2 +-
 mm/sparse.c                             |  2 +-
 9 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0480c61dbb4f..73eaa8c2536a 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -110,7 +110,7 @@
 #define PAGE_END		(_PAGE_END(VA_BITS_MIN))
 #endif /* CONFIG_KASAN */
 
-#define PHYSMEM_END		__pa(PAGE_END - 1)
+#define DIRECT_MAP_PHYSMEM_END	__pa(PAGE_END - 1)
 
 #define MIN_THREAD_SHIFT	(14 + KASAN_THREAD_SHIFT)
 
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index f3d257c45225..d63576608ce7 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -17,7 +17,7 @@ extern unsigned long phys_base;
 extern unsigned long page_offset_base;
 extern unsigned long vmalloc_base;
 extern unsigned long vmemmap_base;
-extern unsigned long physmem_end;
+extern unsigned long direct_map_physmem_end;
 
 static __always_inline unsigned long __phys_addr_nodebug(unsigned long x)
 {
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index a98e53491a4e..ec68f8369bdc 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -141,7 +141,7 @@ extern unsigned int ptrs_per_p4d;
 #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
 #ifdef CONFIG_RANDOMIZE_MEMORY
-# define PHYSMEM_END		physmem_end
+# define DIRECT_MAP_PHYSMEM_END	direct_map_physmem_end
 #endif
 
 /*
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ff253648706f..5a564130b9d0 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -961,7 +961,7 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
 	unsigned long end = ((start_pfn + nr_pages) << PAGE_SHIFT) - 1;
 	int ret;
 
-	if (WARN_ON_ONCE(end > PHYSMEM_END))
+	if (WARN_ON_ONCE(end > DIRECT_MAP_PHYSMEM_END))
 		return -ERANGE;
 
 	ret = __add_pages(nid, start_pfn, nr_pages, params);
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 230f1dee4f09..70d3353c92fa 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -52,7 +52,7 @@ static __initdata struct kaslr_memory_region {
 } kaslr_regions[] = {
 	{
 		.base	= &page_offset_base,
-		.end	= &physmem_end,
+		.end	= &direct_map_physmem_end,
 	},
 	{
 		.base	= &vmalloc_base,
@@ -62,8 +62,12 @@ static __initdata struct kaslr_memory_region {
 	},
 };
 
-/* The end of the possible address space for physical memory */
-unsigned long physmem_end __ro_after_init;
+/*
+ * The end of the physical address space that can be mapped directly by the
+ * kernel. This starts out at (1<<MAX_PHYSMEM_BITS) - 1), but KASLR may reduce
+ * that in order to increase the available entropy for mapping other regions.
+ */
+unsigned long direct_map_physmem_end __ro_after_init;
 
 /* Get size in bytes used by the memory region */
 static inline unsigned long get_padding(struct kaslr_memory_region *region)
@@ -94,7 +98,7 @@ void __init kernel_randomize_memory(void)
 	BUILD_BUG_ON(vaddr_end > __START_KERNEL_map);
 
 	/* Preset the end of the possible address space for physical memory */
-	physmem_end = ((1ULL << MAX_PHYSMEM_BITS) - 1);
+	direct_map_physmem_end = ((1ULL << MAX_PHYSMEM_BITS) - 1);
 	if (!kaslr_memory_enabled())
 		return;
 
@@ -145,7 +149,7 @@ void __init kernel_randomize_memory(void)
 		vaddr += get_padding(&kaslr_regions[i]);
 		/*
 		 * KASLR trims the maximum possible size of the
-		 * direct-map. Update the physmem_end boundary.
+		 * direct-map. Update the direct_map_physmem_end boundary.
 		 * No rounding required as the region starts
 		 * PUD aligned and size is in units of TB.
 		 */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecf63d2b0582..92c35fb60d18 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -97,11 +97,11 @@ extern const int mmap_rnd_compat_bits_max;
 extern int mmap_rnd_compat_bits __read_mostly;
 #endif
 
-#ifndef PHYSMEM_END
+#ifndef DIRECT_MAP_PHYSMEM_END
 # ifdef MAX_PHYSMEM_BITS
-# define PHYSMEM_END	((1ULL << MAX_PHYSMEM_BITS) - 1)
+# define DIRECT_MAP_PHYSMEM_END	((1ULL << MAX_PHYSMEM_BITS) - 1)
 # else
-# define PHYSMEM_END	(((phys_addr_t)-1)&~(1ULL<<63))
+# define DIRECT_MAP_PHYSMEM_END	(((phys_addr_t)-1)&~(1ULL<<63))
 # endif
 #endif
 
diff --git a/kernel/resource.c b/kernel/resource.c
index b730bd28b422..afa3ad09b834 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1871,7 +1871,7 @@ static resource_size_t gfr_start(struct resource *base, resource_size_t size,
 	if (flags & GFR_DESCENDING) {
 		resource_size_t end;
 
-		end = min_t(resource_size_t, base->end, PHYSMEM_END);
+		end = min_t(resource_size_t, base->end, DIRECT_MAP_PHYSMEM_END);
 		return end - size + 1;
 	}
 
@@ -1888,7 +1888,7 @@ static bool gfr_continue(struct resource *base, resource_size_t addr,
 	 * @size did not wrap 0.
 	 */
 	return addr > addr - size &&
-	       addr <= min_t(resource_size_t, base->end, PHYSMEM_END);
+	       addr <= min_t(resource_size_t, base->end, DIRECT_MAP_PHYSMEM_END);
 }
 
 static resource_size_t gfr_next(resource_size_t addr, resource_size_t size,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 621ae1015106..c43b4e7fb298 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1681,7 +1681,7 @@ struct range __weak arch_get_mappable_range(void)
 
 struct range mhp_get_pluggable_range(bool need_mapping)
 {
-	const u64 max_phys = PHYSMEM_END;
+	const u64 max_phys = DIRECT_MAP_PHYSMEM_END;
 	struct range mhp_range;
 
 	if (need_mapping) {
diff --git a/mm/sparse.c b/mm/sparse.c
index dc38539f8560..4cb9793f0b52 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -129,7 +129,7 @@ static inline int sparse_early_nid(struct mem_section *section)
 static void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
 						unsigned long *end_pfn)
 {
-	unsigned long max_sparsemem_pfn = (PHYSMEM_END + 1) >> PAGE_SHIFT;
+	unsigned long max_sparsemem_pfn = (DIRECT_MAP_PHYSMEM_END + 1) >> PAGE_SHIFT;
 
 	/*
 	 * Sanity checks - do not allow an architecture to pass
-- 
2.47.0


