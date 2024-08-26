Return-Path: <linux-kernel+bounces-302303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E4E95FC5D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDB01F225BD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BCD19FA9F;
	Mon, 26 Aug 2024 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="T7/prHdk"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2128.outbound.protection.outlook.com [40.107.100.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5C719DF83;
	Mon, 26 Aug 2024 21:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709588; cv=fail; b=BzCerJmgON23JFkevgOn5d2YPnxv25QP4DhIH0qPqXfc6iHVwjnc9rMVJZT4ht9zpq8HvsBDvCwkZKUBnKYHHQGkj60cuIcwtUYupOXQhqTwpYoxmMf6/AVPf5ychqkPIvFGyceNi3RTDI1r4uXDhmfOIngC1FOn/b+LpXzcW7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709588; c=relaxed/simple;
	bh=zLfpYm6AnS6Hsn18brml5iWARS++T/1F2ZR8u0PQsdk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dYQYpBU1eFkd3bMEOtv+f/F21tmaCMv1NDZLMztwYTh9sSYZiXYS7NSr7HVdARgT71Y3LyCGjdmgVMWuTF8UYliX/mA4s9d1ar51En1NNxof2GMftQ83FEVBhQOl1/cCpTqpoNV2Xq5Z5fkVx487cXDYu5UNzD1uHZ4a5Wyf8C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=T7/prHdk; arc=fail smtp.client-ip=40.107.100.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtD+jv6gUAliJlO3KIkhP1R6/Du1qJIXBuGZSnUiDRq+4CEkWhPDhQGMI2tObnCqWP6SBBiZpWTPCvai40JNOCzGcM3nY/tEgVb1ROa0mwVB74dYcxLr2BG38azHYNM+zUOYiRupJRbU4e/WbfaCSlX/fqdyQZIpshCIVOFY6B8ccAQpWEhuf0eDyfnisOVfpAerq4wgolIUFqzZ9/Flj98wWLhE/BIfRlTre/KrbdZluvHFkF5xyfQ6rA5UCVCRijf4NWx/CacTFsRMgeMP/QQHUmO9CC/yzC8rxLH3n/SpHJzyMuk0qg9a0P2xIDw1hbYS3lgipBIow6D1XL383g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPaioYXh5JegFva4DLUN+LPJLoJXuagoY0hT62RNGhI=;
 b=hUt3slcfe5m1cFZQdghQgKt7wUa7yJIDS2Ms7Bm9BwAivY0jcN13boQsXwxn19nVn9367Da112ma1Vz8zQBcnW2EVfjK2Hm6Vh1ywgstpeRLoa7CAlwUkapoybBFm/rxVoWe7F9dKuohTKE8gigt/zy6GDYvWLZLrLYRlknC3d6oDB4q5kNLRdEHVrMPElHlbziqDdQsdo27+0vat9JKT2igxIS6+I4G/imES6QlyOCuKhSXWgjml29plXjWIB+fXDQOh5ss78y4xsulV9fTi1m/2Gz9br7QbYkHiseOsdXyga5engKm3X5cpZikgahp3FFOrc69oBFqaBtvIyNMcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPaioYXh5JegFva4DLUN+LPJLoJXuagoY0hT62RNGhI=;
 b=T7/prHdkogW5sO2ak76N30PKFzPXNDvN/ySaQqF9vXLqk4yoDwxEzCFryoeyARdQPOEzhJzAGM7yG2KkDHx63kOg895nEDVN3ttx/uV9MZX8llLPlJMldrqx3WNS3hTNPfGU10eox0+LXfaeCqmDDQGqeF76Tr4QX4ZfOkjhLtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from LV2PR01MB7792.prod.exchangelabs.com (2603:10b6:408:14f::10) by
 SJ0PR01MB7480.prod.exchangelabs.com (2603:10b6:a03:3d6::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Mon, 26 Aug 2024 21:59:41 +0000
Received: from LV2PR01MB7792.prod.exchangelabs.com
 ([fe80::2349:ebe6:2948:adb9]) by LV2PR01MB7792.prod.exchangelabs.com
 ([fe80::2349:ebe6:2948:adb9%6]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 21:59:41 +0000
From: D Scott Phillips <scott@os.amperecomputing.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org
Cc: Besar Wicaksono <bwicaksono@nvidia.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Rob Herring <robh@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	linux-kernel@vger.kernel.org,
	patches@amperecomputing.com
Subject: [PATCH] arm64: errata: Enable the AC03_CPU_38 workaround for ampere1a
Date: Mon, 26 Aug 2024 14:59:33 -0700
Message-ID: <20240826215933.1263453-1-scott@os.amperecomputing.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CP6P284CA0039.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:1ac::9) To LV2PR01MB7792.prod.exchangelabs.com
 (2603:10b6:408:14f::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR01MB7792:EE_|SJ0PR01MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a1662bc-ef65-44c4-eeb3-08dcc61a62e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V6jAA7LFjs0D+5NLCODRttQLUnlXmGHqVMzoQ96diz77ziIxhNzCT/fEA1iX?=
 =?us-ascii?Q?iLrzj4Mh5Vn73+I9+/mfl2yVApCCRTiY+ssa8qfJh1AS2DPGlfvS29rRJa5+?=
 =?us-ascii?Q?3VCau4LSZnwe0yQnuKSm7xNKzA6imD0KmrfIFLTXvYS2kDlvBAcc1VIovc+j?=
 =?us-ascii?Q?F1Z5Wc0OPE0yxT/tBYAmaD+0CwNg6BnanQp3hRG/+YAEUMrvwTvWmgG1BIQp?=
 =?us-ascii?Q?ktGY/kfuQOJ/wuZKJ6/uhH3qjn9sGAsdEJiC2knvuyuiNNbq+i265vCw4cRh?=
 =?us-ascii?Q?pUiH1kkytSfsL7AiPgdn3vnbuciFfYWVuL3Z4uQUFIIZ3VB498wP8lMdW5Tp?=
 =?us-ascii?Q?TU7+ILzdTY5T44SlG/gtYwNwH2vC9CJuM8IbwJDd5ykLea9l0kjFUlgAOpzj?=
 =?us-ascii?Q?Cg4vaJE/iT2uWJgQoCyrDUY4lCVMXmTzxNyPOb3NSCWjqiUTtRC6JcIF3qaQ?=
 =?us-ascii?Q?aqZaCAEhxiVCWXaJDdLBRiEkGkvvS0+sHPxfMnu6hnmWMmJfkKN7SFlp/bsr?=
 =?us-ascii?Q?Lhq1sDaD4cavbuUdBOhJmcDF0y3PwTt8P4C0OzM4FdP9vVIwEBTt9PyCJXX/?=
 =?us-ascii?Q?/e+17ZeKilEjS4Uk409/ZE4WLtRsnmt3WVnAtpmiPql9tgsadeXMaH4Quhn6?=
 =?us-ascii?Q?q3K/ceDmNoZ6V6d7KwRSwqrrkj6i38bBRQG4qlDG7bsjKrLeODlvJ1+NIHKn?=
 =?us-ascii?Q?7OqY6W9qIbfT6MKjGNBnDJf/03fD2yTKeiZXd7rBJMvYhDTOPcr7mWGEXdHn?=
 =?us-ascii?Q?xaGlI1IZMCHLgzCosVKGOMPsP5cMG1OELzxeesLKG8kKr4yFEpUn4CR2ZYSQ?=
 =?us-ascii?Q?+gor5nW/yoftJbre98Ia9lQOpgCjDESR8OCqewDSVk0zwGwa03yKdd5wtEa7?=
 =?us-ascii?Q?ZdtxqI26dwN3EVLBr3Wu1dIFUS35hiZmlAZC2ZduDpmIzej+J34wXq+bWswr?=
 =?us-ascii?Q?yEFZmzX7pD/OCwmkMcQ8lAN2hEcZ1pa6eJwcO8ZH1AesEFXpyUrZ4Uh+UAg0?=
 =?us-ascii?Q?GTmGHuzV6GIOkvqBN3v4+pjo3ZU9YOgMB4WeO8RakJy0heA9aU7S0y9jlvJL?=
 =?us-ascii?Q?irbwLag6hlO9sKZmncyhgnhIePtWATo8IKv6EnuIe7U3HY5Qu20CrTrowTw/?=
 =?us-ascii?Q?uZsevGQ3MksMMM65bhjWSam0ndAmiyxT7DSsJeDEtLvIjC6o9oDV6/LaknTl?=
 =?us-ascii?Q?XAJQKL9LRjczyzvygiZB6EbPIKNXqlOd7Xy7qfhpLHpwiQHruyErMOaCdcKC?=
 =?us-ascii?Q?KpU/J0k6vY3uFpbistLt6BGKvd+MqgY8UnNN9jdzYcOsMTIq6ionCXLpxj3J?=
 =?us-ascii?Q?9clUADtQl5HKKJtFRkSTbyuPBUYxplZWdt+ymhOZNuUGYWUtgz5lPscA6OKl?=
 =?us-ascii?Q?831nz1lil+V1jiYuMRWI0p4Z4fRxvbGxlklxlCliTs3LriuFwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR01MB7792.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e997wIoeUjC6M8LfXBSQuxNFVNdP1PENfGIX8hRWBgZOBmXkb2smBpRA3kbY?=
 =?us-ascii?Q?heqOqm6q2mlRkjOJeGKHNGJcWiJxjzn3Z4fGRT4de8Ssxwrvs+l4L6Wz9xsH?=
 =?us-ascii?Q?1kaYIl6upkuqN5nP5+Gadb2wjcF/c4XmiHf90aahQy5zqLEDgY0/OQ10MHal?=
 =?us-ascii?Q?M5oHVFwn7P1gsIEJVvTJm8aFuqrfO1oKN9wsgJxvxOTQXzsWSLtcZTVpO3wa?=
 =?us-ascii?Q?VriDgY5+z8EswYI0ddilzKXUegCey7GH+e8dI4JV+xI1hzahV4//pF6p3N2W?=
 =?us-ascii?Q?3ZuZB5HxW8sFoGeDpj4nJhIjCfhswJRJjZSQTaWNt+LuwCK7VhiG1HrrLEyU?=
 =?us-ascii?Q?DlxApmNQk0fgI7GPRuUhMrUJdGehcAN+8jUUUJpp9BelmJrZOg2WViOORyff?=
 =?us-ascii?Q?q0CeA2Bso/iHgkS6Y8wU9rGDapOu83hIGlX0Kj5eskzv+9sm3CkFV6a1h5kw?=
 =?us-ascii?Q?I0ucCfNx1p+FEwXljMbG3QHXm+zfnbO1eMv3AexU8M303htR+KApV6ozI+5e?=
 =?us-ascii?Q?/MRBzRb7cxZnvHnTWMzADj+L3xZutguGyVypktetef78ZBGD5ePiUBPQ68lO?=
 =?us-ascii?Q?LkqXmROAnEeeR/MoPUb7/OeGKPiL9l9qWsrbAFNl8AoQ166Trzfvx9f5dYoV?=
 =?us-ascii?Q?wH0Ln3dViXhr+cOXE3IfX8yZBAzH6nP5sTlhd/53KdEjMA3i2VnWIJVdwOE4?=
 =?us-ascii?Q?jxf2V1jDg8slKa3uf/pXB5vsBXl+0L3CNBad76B9DkNcFR6CI2L5actmWCqh?=
 =?us-ascii?Q?EDgEKFu4/vMJ1oGtvl8sLFxOp56O1RfBTphSnr55eJe3F53+gsbts+TaUMLH?=
 =?us-ascii?Q?cZUq9WhiZZd3zMKwtsNrA9nvkLNIAEUy+vwEy2eFKKCwHFVCi0CM/mjDrN+N?=
 =?us-ascii?Q?YVb8M31w0sbaPVWiv6vXqbtFkoHEH8IH7IdJgAOr1N560hqYhWRJg7BzgJ6k?=
 =?us-ascii?Q?UU/3anBDXFjheYLM9GlmFJbrVKwqueBb6PkiCpwBEWn3SNTuN2TtaN/eJrS/?=
 =?us-ascii?Q?/Qrd5j24et3yIRoL5bQQHWzam3afhpyyVVcVEgykHgZoIcocVwJcBUuaMyfU?=
 =?us-ascii?Q?7P6Yrrnxib7qKFAxD1FKfjLXUwajfZvff7P/RAqOIZbaL3A+C+Xcyyw10UDI?=
 =?us-ascii?Q?LoKzl0mX9OVCTOC4jxBT0GbkwZqeV7yQt7VZ9e0nnB9FzkZcFy62H1UIBbpP?=
 =?us-ascii?Q?aY5VFt7j+HKbPyHBF7oiT5q50vVAq9GhPpk/ilnni8NqdEqBwqY3Aw+adJUb?=
 =?us-ascii?Q?X3TxoiioLPVZn/6Vc5hKy1S22AwL3zPJmxuHySGGHS14IgH5Szvb9OLVd5uO?=
 =?us-ascii?Q?VGe7s9oeUyo1Q4QewbeKuXVTmtjNClhi41ncK+r0xLT8kLVvFltSLNV1aZVE?=
 =?us-ascii?Q?YvA5r5wwI1IJI2QIZ1NLZOvNnMzaR0H4/dXYcKa/V1AerCJeMxjJr68UEsVu?=
 =?us-ascii?Q?PucUtWzUaMzKv+SUwPIy613VEyDztdjI97TEiNpnARlmx9JkXjAJAsZBmVR7?=
 =?us-ascii?Q?+1i5+bDRNy6jUvN+THFAoQD+INaFHnYZUwqIR1ndUqMYPDi7q6jUXu2E10q4?=
 =?us-ascii?Q?n4m2T3f/gd4Ifopdalkw6yT9A+D9uBPkVcxNycBIEcyQnUK9oGpfSctEpfAx?=
 =?us-ascii?Q?g1ZqVrVGHrxFrP09Phfn7rE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1662bc-ef65-44c4-eeb3-08dcc61a62e7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR01MB7792.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 21:59:41.4332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+pX1F7mJApshDyPtNwcSqyCEStt27IV7Ijlh8S0vmlHhJRwKBMYo7Eiba8WPcUNWbUSSk0REj+mnKQRnbkmDKnj8FKlDE92IZXY02uCtbaG1PRtSzblMcF8GUFsshYH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7480

The ampere1a cpu is affected by erratum AC04_CPU_10 which is the same
bug as AC03_CPU38. Add ampere1a to the AC03_CPU_38 workaround midr list.

Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
---
 Documentation/arch/arm64/silicon-errata.rst | 2 ++
 arch/arm64/Kconfig                          | 2 +-
 arch/arm64/include/asm/cputype.h            | 2 ++
 arch/arm64/kernel/cpu_errata.c              | 1 +
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 50327c05be8d1..39c52385f11fb 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -55,6 +55,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Ampere         | AmpereOne       | AC03_CPU_38     | AMPERE_ERRATUM_AC03_CPU_38  |
 +----------------+-----------------+-----------------+-----------------------------+
+| Ampere         | AmpereOne AC04  | AC04_CPU_10     | AMPERE_ERRATUM_AC03_CPU_38  |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2457168        | ARM64_ERRATUM_2457168       |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2f8ff354ca67..c8cba20a4d11b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -423,7 +423,7 @@ config AMPERE_ERRATUM_AC03_CPU_38
 	default y
 	help
 	  This option adds an alternative code sequence to work around Ampere
-	  erratum AC03_CPU_38 on AmpereOne.
+	  errata AC03_CPU_38 and AC04_CPU_10 on AmpereOne.
 
 	  The affected design reports FEAT_HAFDBS as not implemented in
 	  ID_AA64MMFR1_EL1.HAFDBS, but (V)TCR_ELx.{HA,HD} are not RES0
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 5fd7caea44193..5a7dfeb8e8eb5 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -143,6 +143,7 @@
 #define APPLE_CPU_PART_M2_AVALANCHE_MAX	0x039
 
 #define AMPERE_CPU_PART_AMPERE1		0xAC3
+#define AMPERE_CPU_PART_AMPERE1A	0xAC4
 
 #define MICROSOFT_CPU_PART_AZURE_COBALT_100	0xD49 /* Based on r0p0 of ARM Neoverse N2 */
 
@@ -212,6 +213,7 @@
 #define MIDR_APPLE_M2_BLIZZARD_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_BLIZZARD_MAX)
 #define MIDR_APPLE_M2_AVALANCHE_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_AVALANCHE_MAX)
 #define MIDR_AMPERE1 MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1)
+#define MIDR_AMPERE1A MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1A)
 #define MIDR_MICROSOFT_AZURE_COBALT_100 MIDR_CPU_MODEL(ARM_CPU_IMP_MICROSOFT, MICROSOFT_CPU_PART_AZURE_COBALT_100)
 
 /* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index f6b6b45073571..748aa536446ae 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -773,6 +773,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.desc = "AmpereOne erratum AC03_CPU_38",
 		.capability = ARM64_WORKAROUND_AMPERE_AC03_CPU_38,
 		ERRATA_MIDR_ALL_VERSIONS(MIDR_AMPERE1),
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
 	},
 #endif
 	{
-- 
2.46.0


