Return-Path: <linux-kernel+bounces-568016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01490A68D05
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4AE3A1CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D315E255223;
	Wed, 19 Mar 2025 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="dZ4hay4i"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011070.outbound.protection.outlook.com [52.101.70.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A24F2571CC;
	Wed, 19 Mar 2025 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387486; cv=fail; b=rpvEC+VIHNCo98W3ml8hVtYVL4A/9sgmk1VDteJF5jVsPBfTBWpoPIvgiNVeaRnLLcUJzGZ9BoM5+nrYRHjvhxPv42REiswpv0UP63zAe+y9ykv9LgeBYDblZG3c3eCtE2hSnFdrlRetWygZjoJ8sHCWR3jXtWQaAZzM7469S7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387486; c=relaxed/simple;
	bh=hrouQ+u57fcxMgN63OZO6eGdB9i4azjaxGxEjdw91AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ozaJl6rCZISCIsF5S4RidOGnJaodZX+MZ1wOVH+vOQYK9ygApaH8FHdGQEfHdFx8wVTO6D1O0ovBicBWSpdWAjbYInjencHT3TMG3IZyY7jM/7Yu1NUk7aw/YDuvO86z2OHPEHc/661YzpGbsekV8uOKGfddSr5iyRFGce40sv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=dZ4hay4i; arc=fail smtp.client-ip=52.101.70.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOg3e6szQJSXEbJAZXv3eNCIxbRHfMHjECfyRRR9uPQK1xW+mxUVuwDbaDl17XXInQgix1oJD3nXZew1+x3MrYIo21+hPoedqgH1aD3Aqr0p/vHXuV3Rum4fb5GZCW4OVPr2l2D9S6Y2J7KOjPVvhBC0r6eV0DhdlnioPQeWGkRZjrcpjgEPmscMeOi+0LTFDnoSqdPxxKAig4P8vIGIjOLzr4gGknnGJJgo8/ZCsk6abMD3/uV51Fa+vAiTJBmo1dUUmLcLmpVytiY5BgtZvjyLtvHgEQGK6xBrHnN4hgd9oD/HP1KF1Yu6R+/6pijQpgNFU2sRxg2t+jBVVNO9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7SJi8AHouM9KnZVzJUhOf8dxyu0/KDDQ6tGFWU6W9I=;
 b=vW4pbKSSpLDWbA9LXcH1x1ahsBqZsjLjKFlA6lNjxkrs8OjbI1wpnhC8HFiTgcJaCUdx64DkeGt60yZ6QbIWn2Gvw83sf3wsfF9iF6tsYnpbJyKOzdZycI5fwTU9tbWlkQUAkCHeNbi/P5vSSY0J4jqlV83OEa8uAd7mcX+Om9RJmWuhkH6wQ8dpdCfstNH0TdlAInFDP1LPV7YiTQMt17afl0QWdMX/vFrJhRjiU/8ZoF64pRjp3FjO4CebNV396W1z1tVEHSCZkUm9icD0uJ0YbCbSeesmQYQAwIvG6R1cemudCGU/smSkzIq0XkrJIoDGD9XuU3IsNOJ5TLBbHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7SJi8AHouM9KnZVzJUhOf8dxyu0/KDDQ6tGFWU6W9I=;
 b=dZ4hay4iZiKA7xJNOh3G6cIKKVouWqn0myHP+3OPanen1keUJSRcPYfW42n4IkRujiJ81qqRRjtdO/lt6Z85GiOA2C8ZApUglZ0Dy7kcVqJ60TwoNl1bVMA1JYDGKzUfEEEJ7uNoTNAlxg5HP96MDySC+0T00LwLHKDjf9mo788=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by PAWPR10MB6856.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 12:31:16 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 12:31:16 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Colin Foster <colin.foster@in-advantage.com>,
	Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 6/8] mfd: ocelot: correct Kconfig dependency
Date: Wed, 19 Mar 2025 13:30:56 +0100
Message-ID: <20250319123058.452202-7-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319123058.452202-1-ravi@prevas.dk>
References: <20250319123058.452202-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0056.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::29) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|PAWPR10MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2beda0-f85b-40a6-083d-08dd66e1f1a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i+kV9yC+baeedM/yc+zARnhhDAnW68PEn0QbQy8nNY8wAKnBcdPtcYUjUYy+?=
 =?us-ascii?Q?w9NJpNJheGJPhJ4K6mbkDkETrJTUGQeDwJqHE40upS6dFRfTzDEm0ebKjPyf?=
 =?us-ascii?Q?pYvSu6qFxjm9UEfB3jTWU0ZEliygveRyBN/52VOFH7NraWZKB5TBhCGXPa6u?=
 =?us-ascii?Q?LWOP2nDOmbEXRJSpNOk+YbFMfwje7tL/dVln3Rgew31utIDQ5PCr6LBB9hny?=
 =?us-ascii?Q?WJ6emJIxZ25q2ZXoe7phg3mEEuobJx2edLV2X7ofO+33ZFNryfTNV6BSKU0B?=
 =?us-ascii?Q?nE0PMXZ19cLOW/os4KwUHsOoHeoUwJPRR47ylINUqPyHDYOQjWtQaeCT31tt?=
 =?us-ascii?Q?J5hFl6g+PbshTQhxx3UN+R1kM1EHwvDgC0tVYy8EVIiqJ3Pyq61P8aZNVCrL?=
 =?us-ascii?Q?ha1ZaVnD1hh/K4/A97th0E4u/36TSQFuvwenf1FqWtDnH4JTFKhn0wKANxi2?=
 =?us-ascii?Q?p9AFV6AEvrvAO1E6StT82CTjeKtLyfi1fpvY8RA0FlnaPcNZNcp7wch705iz?=
 =?us-ascii?Q?LU3+S6GC+Pk0Ylbo9Vl3yIyjrdj1Rx6zjfyDEkWZECG6ToMnab/4iMTxP8Q7?=
 =?us-ascii?Q?HodGxj6vLPn+hLbBQsF55SeCgqBbZTZ6HYtgOyv4nB1yCF4fMIanpaGWjsVv?=
 =?us-ascii?Q?dv0YSUYsHbL80R+1ptjFaWDardQDHNSlNYBjTa7pJU6ml1BWTJ9zPbchAdL2?=
 =?us-ascii?Q?ZqVsIuNzvvPMfQDJ2h7fpHlDbLsObgRZ8rDlq2ADdE6WxvMGFrszm6kVHPoA?=
 =?us-ascii?Q?sJyeihymQhAi/jHq70mxy2tj/bGvGw/0XSvut3CeAPBSOrulCMxV/dT6tVwI?=
 =?us-ascii?Q?P96xX2xRvsJcVcg30PphJfEogiyrq+c58Ykc3pZbPg3d85M0ULHh11Y+b8sj?=
 =?us-ascii?Q?h91CeERefhnbH4/9qLQeGcKa2epOfesKM6S6Es0yFr9b8mF+4U9G2XyizyqB?=
 =?us-ascii?Q?Mk8i1t21i/J1+FoZFvPBh45hEG7oE2u+vUyxu+hBuaVSlCuGqyaE9A+If57F?=
 =?us-ascii?Q?AGvzQsgvmyKZvETOMqOHhvULWOuj3eOqYcza6s/VX5i/AU3mBLrfvq0Xvz/C?=
 =?us-ascii?Q?kq5PaNCvl3wIQo3eNflYTm4hwC7bxKcZamKh7i6Q4THIJdHwU4ouDX6lmBSE?=
 =?us-ascii?Q?fUWKDciltsE6DOTHTBhPsyHVeakcEEblxxBXWrzTHZ0jHBSbRiXe0blzq7jC?=
 =?us-ascii?Q?zZJOSmpeEzdSpMI4uJtaKfZk8dCwsXYzH0EV3CzptWWDr3yfrEq4FxRUZHG5?=
 =?us-ascii?Q?jFJCsuvgDyNdbBHctJXOG9gcd/3s72pmEU9OD+7JU0UTY7TqG4U5OxMygFZV?=
 =?us-ascii?Q?G9m9v7uS+d7T8LSP0IjEPJni90qhZLtOl/FubcJBlYqnmkYiWjK1L/vWYjRr?=
 =?us-ascii?Q?aYAObjfm2a7vr6WOt2Nzd34wKXlwRm9djSFIJQ6r37hjTbL04ehJ9DuMCKC5?=
 =?us-ascii?Q?PrzQ7ycsCuApctO9FDVmNRH5JA6958Ap?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?55dS1MiXHn8jxJxm3vCZbWsAtpI+mLWHr1dFkrTqd08P+kytrLVyzGLCzbEl?=
 =?us-ascii?Q?Y9Rr2jHoZ1fgAzKaob+2HpgnhIP1oE3/M60MhXTJgBfI56GzkM3AouWlwddy?=
 =?us-ascii?Q?4xyMMPU35iVMrQkCh1ucHa2H3zx4CDUbVuXXTQjMxw37gremI9KN5ozKuiVX?=
 =?us-ascii?Q?XNNV7IP7Znw3PhhSjuJE0J/Vzv2yz6YbT8e4s5fug4gHQHfXd13HkWc+E9Hy?=
 =?us-ascii?Q?rK0oyfKOySCpgzJcK7ZmFr58bqko0dPvcf5SfheAhV3ohrcuyqk3F+3s/Z4Z?=
 =?us-ascii?Q?8VMNQh59EhA4GXy0ziQ5DaKpWNVmcvhAOAuwB6ZOx4eamRlztlNKpqqaypEo?=
 =?us-ascii?Q?pOEIT9KGzJ1sVZXh2mE+QTl8mbQD3u9Z1gzFvKuZo+fqk5D3df46jiAbYWAV?=
 =?us-ascii?Q?BpafvuEUtsj/bLRSot8+F5G662WusRg6bUAnxTqf4rdjnA+JyXr91hwLtdFt?=
 =?us-ascii?Q?WhYAi4y1eNmEigPe6yYEeUJGTARD6RNwIA4otB6tDEo0YgeYZxKsB3TxhZHc?=
 =?us-ascii?Q?YKvGdB4E/V5cVH6RVjKEXzfSyi5nqt2hLlQG8ah/9KHvqSmQh2KQjZsVbRTw?=
 =?us-ascii?Q?EqXsYVQAAavSMm2fp2DiHUyoGdHLpSP1VDqvjlqtsbo28mwJofoVcaUlwvPN?=
 =?us-ascii?Q?yGG8gSGzkkLGI9t1DOb+zTBIDYRLnD/fIMOdUPRR3OtifQ5K9Pp0CcYGjcQ+?=
 =?us-ascii?Q?f3aQ64fjLUxKACzvy941tLLZdVlnjzlF8bN2T9cDl5QFnur+4nedO1BZhgEX?=
 =?us-ascii?Q?bBHGaSjkistb+mTOo1ZeaGqzNnzHUtnqAOSMa81mrazLWk0ZV8sQx2uCe7Aw?=
 =?us-ascii?Q?lfvizvIqqA6XHrSJtq0AaszpeAaUXjqgXPgAwiahhUWWg56XMWDLAMae76pc?=
 =?us-ascii?Q?gsQ3/MV9d/9vY0ltymyQZ2B6QBxQlV+ifIqI8YGb6ZE3jHmIvhiiARVQxYtw?=
 =?us-ascii?Q?6cG32fcd7Hz9N/Ks/jhV3jbRSvTaKxROAM/ufAwtfK85uEZKQsXUZ6Wc+xv+?=
 =?us-ascii?Q?OIxH9lexlLKZRHXK7AU4MOMGfZdnoscgbmWedK+YKb/MTlC+jKhjwMMdrrtr?=
 =?us-ascii?Q?A1on10DjtWeLOcXNcENBvbPwac0Jb6mqAEFavUERzORGT7dvwqnrDlHUbHTv?=
 =?us-ascii?Q?Y7P/9nIaNcAtKbOUPTvRvMJo9hv4/aIbzldUiD3wRVBnErh4sI0lVbvzFPJ5?=
 =?us-ascii?Q?2jmL8LRTXdc8vwbDCoFmDnDF2g23piMxscqNwJoBMIFIgtj0isMKy7sHWnGT?=
 =?us-ascii?Q?9ZZDfh5DoeWV8z3AyKc3vXiJkcoMxWh1SEeBhuJHEP/ZFPO1qlBwEWoM7g/I?=
 =?us-ascii?Q?cdIPtkWjkntS0WXkv4IxOlO2katBw4PHQKAgH4HnhJPo184MvQzO3zMvVn+W?=
 =?us-ascii?Q?bFgTHDLPg+8Ql/NOOfYa89Tl0C+V56w+mVIXsuP9a3GRg/sBMW+mfWmW4IHq?=
 =?us-ascii?Q?64t65PHYd4PYmoeDqW/JTtNSalmo82LSBcziZvdtD2+4qdBrOFLkIk9t9MB5?=
 =?us-ascii?Q?sF/fTvPminMvFYTgdVTq8H0TfNj1aAaKDjvi+BxQk68qPCdIOF4VI8PzzOkZ?=
 =?us-ascii?Q?LByZy/SeR5yY62AlGmW4L/xBwF6BuzkgXYk8th2QJv8R0drkk0Lm4dzDmvnb?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2beda0-f85b-40a6-083d-08dd66e1f1a4
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 12:31:16.5850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMFL3bAhdcjLeAYWEMaz3jbykkU72fWbhihfeOZTDOMqkkhwxg2I/vya0EO63JVMbcf6gwEpYxwbdoJ1mPNO8I4kvsVbVC4Ej+MZuUsPntI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6856

The ocelot-spi.c file does not actually use the generic spi regmap
support (i.e., it does not call any variant of regmap_init_spi), but
instead implements its own specialized regmap (though of course with
spi as the underlying bus). So it should simply 'select REGMAP'.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6b0682af6e32b..4dc894061b62e 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1049,7 +1049,7 @@ config MFD_OCELOT
 	tristate "Microsemi Ocelot External Control Support"
 	depends on SPI_MASTER
 	select MFD_CORE
-	select REGMAP_SPI
+	select REGMAP
 	help
 	  Ocelot is a family of networking chips that support multiple ethernet
 	  and fibre interfaces. In addition to networking, they contain several
-- 
2.49.0


