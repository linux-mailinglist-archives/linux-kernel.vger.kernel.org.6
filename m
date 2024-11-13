Return-Path: <linux-kernel+bounces-407084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F539C6893
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4409283EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 05:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC7F1714B8;
	Wed, 13 Nov 2024 05:19:35 +0000 (UTC)
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020079.outbound.protection.outlook.com [52.101.225.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A0823A6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731475175; cv=fail; b=W3E851FsvAZHSBPfGQyf7ydV19nNLXQkBpB8IjAcW2Br5sojedqm4k+y7cgTEl3nwszLyAMwbAxZjcfSxS5CWcSp2xrHOn12ZS/wzT7VVL5NTb3BmtII8vumvf89lm/wFgQLaKT7bY65KZKU0mXdf8mKRxpF+JmSfr94harLuNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731475175; c=relaxed/simple;
	bh=o95pR5HwvRh7fdAFnNa6UYaI7qfDwIeDxNh7ZTC0rWU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NPrYln49wydswo+3h50j6EUb7OeOfcB0EDFizqIYoFqrKqaqjc6wuc240pPChK6QxnbU/UEx2l/Nf9FSC6QltXDeVuXp23BwaX1DbDNGTF3tWFS7MgIM3XAbJO4xrMKz0SIjNIGyUxdF809icZp+kesZddB2+vl1cG7IyzjJ/Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.225.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1XLjR1yKe8Vfp19EZa/K+rgG7ctVA0l4N2HO6gsUpB4f4+oDnCgnZP6A4zyke/r0rEvIgZthqYn+iwGYs2FZEgETYMpwq+bvWP0RXIhemV8WQ5nLftVnJQnTq6BCcXUK3OjJbAPySW/AW6woNqgO6dRFUR7lCPdxVAAxuzNwwXF8KwLB/G+43RcxSjzN4kC8H7KHxKbFtFk8hHWa9T1KPIq/+RP7i17ysNvsPm/tjTrg7V74xOgmrlDARR2wud5lsGAybyogt0opEn8d2T1FFbazNmCTHCnFhtn9m0vHmHawztoja9jjkBqE5FMI4CnvKQcWgCg6Yx7YXoXyGJCiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGpw6IhWulrLsx7SLcv4t5c4V/1E3UeVv54qVGXLm/U=;
 b=izVdiqR84fIFCfRCZc2fIJyUEggtDFwI9KGuExzDfl33Y50Ry1K2iHgvNx4UYtaolEZLo4Xbt0q4q6OCXSI2sppe1nwA8HoO980n8J7O8yllGe7xXPH1C3IVWXe7uLltzknCXWk1iHlBN6aZkw5pqcCbYCWHvbHx2FG3TPgC7cLqrDvKpXU5yAkW4t5GAyW9MC7MMwZ+mrMtVhPhJYmdToyKNPG8nfxPWgYx5p1ix+nh5DwhLc1XQFZ5AGnMzcWIw8rIZ0b9AD+RRqi+AbjGcgqJYjPNDr5W4Pb8k6NiyVpstXfyH9wfBBqHIzRgYpDsJok7QZosenuQ9VVfUdPSGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by PN2P287MB1682.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 05:19:28 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%3]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 05:19:28 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: broonie@kernel.org,
	will@kernel.org
Cc: tarang.raval@siliconsignals.io,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: Refactor conditional logic
Date: Wed, 13 Nov 2024 10:48:18 +0530
Message-ID: <20241113051852.4806-1-hardevsinh.palaniya@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0238.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::8) To PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:204::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0P287MB2843:EE_|PN2P287MB1682:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e48286a-80f9-4dc5-514f-08dd03a2bf42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FkOqGmFeWSyZOxdBOv7McD1fVrtqJKpH4bDEYPHa5GN8zLnnXZyD90nmGpKF?=
 =?us-ascii?Q?ioifFiJWHsRKQw5lFp/ywO+titXCjgFsOifpm31OqgPac5I/ASQ3UggJ6Teg?=
 =?us-ascii?Q?LhBe16XqRwoH4NgCW4O9ms63CEbwNAvThOyYDHx2ZtVhsNxW/qVX2/rwm/Qi?=
 =?us-ascii?Q?lM+59Pi6L6J7+62BU2iw1LsO8Lf/av5HoCQWHcFGhHgwCWI7zof0kqJbgnG+?=
 =?us-ascii?Q?G+2CKDHAAmv2+1+rAhwl7Rw2HFNtzX1VcdKOA1KOoMVC52a9jTQI6m/3FlRV?=
 =?us-ascii?Q?OpOwC+9M2ujwWZSkLpF4pdpvAzwsSL8LTdr1V8FlOb7zVpSFaj5xBKBIxP+U?=
 =?us-ascii?Q?+SkEIZPPJufOZvG5UusRUpuDEVmaC6R5E+nkjd5dAG2lJTw2t1j2OQECGdeM?=
 =?us-ascii?Q?A70ZKYublYIc3Q3dovzBkqQhtgPYuQp5/c058w5xRT16fqz1Jmr+aEJlu+W0?=
 =?us-ascii?Q?/py/rZrbTw1a63tSRZ9nLbTT4aga4Ndru8GGcNMKCQi8B0yb8QF+U1Ag5I74?=
 =?us-ascii?Q?busEvAFdqg38PX6+bqnpTK2z+W+G6SiQF7dDYOWXsG6nr5EmWyADjOkomlAg?=
 =?us-ascii?Q?8iyef4PUtKaztJWFizSJjyw+48rCDv1PHdp0knsWKDerHa3Dn+hGG4Wfna8X?=
 =?us-ascii?Q?z/YxSgkbXWNytM2goceawgmww6TP+c0luHw2kRDf3C5oSgbKaL5/4eodSsmm?=
 =?us-ascii?Q?N2FZXTKaBgov5kjbkpjL7jZH8rBc2oP8KX8PUHk46he6pmKfcE9zSvkxw7AJ?=
 =?us-ascii?Q?139x/5vyJ8pTN60yFCjCKB0D7UrNdy4nusgfvDdMzvH8uS+BktdegKP+cdOc?=
 =?us-ascii?Q?GU/uuaw2VjIIFMqfLkWy6DKGBYHBC6eFq2zjTa7X4KslDRI0tndfQFNvBU5k?=
 =?us-ascii?Q?T1a5miypqhM+qsyp8rYysJE2woqtxpSYc4HleQQ2l+qI/DDH2luiWpQotmmX?=
 =?us-ascii?Q?B16qZQprVRBbvf+N+Zc2A4cO7STgiPUJV4HCpsKItxnwP9fNGJQR6sbyTDez?=
 =?us-ascii?Q?wPyX80N47Op7noWf7neNHXrWM+mdJeMTGFQuP3uQtWjV/IXu1T9yDSe3+zlC?=
 =?us-ascii?Q?qPlt1KtrsInGGY1LU3mmsp77XWP08loyrXW+tj2Q6M46cRdiGK5BkF7dpZTb?=
 =?us-ascii?Q?LlAh2hectqib/tTVUe6PVK2E0bNJlyafaShiCYenpf1y7/1Z2Dz2aDPMx5+M?=
 =?us-ascii?Q?T6uTz4P4axeFilW6EUFiLLSpmejuULs7BNha8gHassUfSFOGzVV2qQv6n3/7?=
 =?us-ascii?Q?yC3enbON0OS6KUVURFi3X0TOrsSYRocnZ3Q35hRueb5nW7zaEZHyB9LTWpmq?=
 =?us-ascii?Q?PqvpwFsBcz6hTmMuK4pvSRokMzNKhpGhh7ZyOWocWtkeibKQmRlWIxA1BNB7?=
 =?us-ascii?Q?PGTjEmU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dqDo5vrxewFW6ONWXcSXl3t7/cT+VUWJ4P8cbyU/5Th06F1Pr8oMw6I7GZxj?=
 =?us-ascii?Q?D077JUhF4r+7BYwqXPlxl7zef2Rklf+r0jCDKsEMKvFafiyrxitrgOM7McVl?=
 =?us-ascii?Q?pPI/PmrQZyq6qbUnRDoXmqDMKZadrvJlma9e8jBx45Jf+mZyezxgdXIrGO3d?=
 =?us-ascii?Q?FETutYHf4kQVIKqUupBqCqQLsuCS3m+a5QD4LZR+jbFoPNLrVxzickFz1l6O?=
 =?us-ascii?Q?koUTM9zaoTz07hfEkMoK3trrAK2xedHZ5+fp2YKtnn4wVlqiGQfpBKllQt99?=
 =?us-ascii?Q?GeFm7yjIOvZfrg16YfZRXD3k8zKo97fJmNHq6BDNwhJvSvo+ueGRFHYmbVQ+?=
 =?us-ascii?Q?w+yBmK8F383/EG2DDy8bVIS9FVnhWPG7hRqjfWjGnNiZ8LOrIb7jIDoyHf/1?=
 =?us-ascii?Q?5dbM7ODx7bUML0YD+iP3hmNTKB99JDXgj9mgpKPnRpTS9+JPo+cnPlq0vHJp?=
 =?us-ascii?Q?H3tuv7dwTdJVJUnFo7q3OkoMTp+D8BTIjr+uRApoemOurfWQLY5BFCIHOjN1?=
 =?us-ascii?Q?K2b5JGP5bwFBf4LzDpFY5qMPQlPVe8RsWV6jOJnLmgYf8cvhPifDfVinNkjB?=
 =?us-ascii?Q?hqzXMk1dcrRiEFbyyFtzgu5et3J4CmJ1pa3zx3BxnO0bH+sdtqHK1PM3fhT7?=
 =?us-ascii?Q?Tr6szoTJmRDHrI2JIg6ndbGUFC1Wr1BdJ+IrHTIkyixSsAcyo7AzEM2ia2Id?=
 =?us-ascii?Q?G5rP0z4cZcMvOfIJ/UFO1lPcs51nVLcRUu2EYCs0BP93kNZdlE+BjgfR2+4K?=
 =?us-ascii?Q?eAi2oH5IY7Mdi/1JSni8iqEo4k4adZQ6/wK3f0aWiAjj5a+LshjsnKo7fGn7?=
 =?us-ascii?Q?ilw4uDf92bFgGQsFo6Ekex7zuSDwA0VqoWKJjySl2S/C64XUIqB7oJDZ+Fqk?=
 =?us-ascii?Q?REmNXMyJ7q50y2qbhYA810TbNVuU3Ma1c6dFe6chFbA1UfcoZOGDSHWn7fPe?=
 =?us-ascii?Q?sSS/yzhdTPI1l8W801/LyTO9PYRY+Fw8JcRd1ECO4BO882NNpjJSZXnbWCso?=
 =?us-ascii?Q?mqGZPdIdQCYDbzfAVhMF22dktbGdGSk7ykYoJ3w7ukGTpCwsIW7f6w88W93b?=
 =?us-ascii?Q?UbP7MXEK7py2Dbx0tLGLsy8Zb0N8WDJTboMBqsfP/Ou9+CN1KrKuT/pu2If0?=
 =?us-ascii?Q?9s3U6UJVee3XK712LlpScSaTWx1l16zqLtFThjyLV/c3qx2VvOPdV0DX0CP+?=
 =?us-ascii?Q?gi/W5XSMlGI9RaHRgPvh6Tix1FpeUeHsO6kgVyi+IbGhKp9b3cfdWYF2EjwW?=
 =?us-ascii?Q?kZ2710T/xOVejlTGpafG8W3JYQVAgmxRo6lvsNaHo+IfNeIyMqo3zWowlpbK?=
 =?us-ascii?Q?WGscX9+uwavkWr+T7JRajZ/7IGYYh7UKsR4WiSrbpFaTvhgz1tMvoGezdZky?=
 =?us-ascii?Q?lr0Auf9gnAzGg0BQGgZZxGSmsTrlYDK0aowYB5k07RvleI+JR0qQ53E+UOa7?=
 =?us-ascii?Q?AY20WMGWPGaRF6Y9umP1GDmSAHcAiW5IVfVvzmWLFDqpipN69sYlcHE/ZnYx?=
 =?us-ascii?Q?oq3Eon7QAcsPkrqFw4EBHwi9sq6xiXZPl2L3VcscpLXfyS+ant30LT271xKt?=
 =?us-ascii?Q?C50oeDqF8RPiK7e9PBc2mGGvjPb/KKD2aI2gxcFj1XXOIS1H1iy6/VP8THR5?=
 =?us-ascii?Q?wzXnO1/QneeGENAkLq4K6ieiLsbHvCbRRkv4tMqy0CVf?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e48286a-80f9-4dc5-514f-08dd03a2bf42
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 05:19:28.6215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QTOd6AOaSCq/BZSs9LeIOU/kVCjiN/KSMmHBaf7F77B7npALtRf/nFaDNfXKEgu+GOd04r85Df9T7ezoP87c1lTgkO2d4PegNL1SCnLqYd71QbbiADLWmsg7PzXN2Lg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1682

Unnecessarily checks ftr_ovr == tmp in an extra else if, which is not
needed because that condition would already be true by default if the
previous conditions are not satisfied.

Additionally, all branches set the variable str, making the subsequent
"if (str)" check redundant

Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
---

Changelog in V2:

- remove str check 

---
 arch/arm64/kernel/cpufeature.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 718728a85430..728709483fb7 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -989,17 +989,16 @@ static void init_cpu_ftr_reg(u32 sys_reg, u64 new)
 				/* Override was valid */
 				ftr_new = tmp;
 				str = "forced";
-			} else if (ftr_ovr == tmp) {
+			} else {
 				/* Override was the safe value */
 				str = "already set";
 			}
 
-			if (str)
-				pr_warn("%s[%d:%d]: %s to %llx\n",
-					reg->name,
-					ftrp->shift + ftrp->width - 1,
-					ftrp->shift, str,
-					tmp & (BIT(ftrp->width) - 1));
+			pr_warn("%s[%d:%d]: %s to %llx\n",
+				reg->name,
+				ftrp->shift + ftrp->width - 1,
+				ftrp->shift, str,
+				tmp & (BIT(ftrp->width) - 1));
 		} else if ((ftr_mask & reg->override->val) == ftr_mask) {
 			reg->override->val &= ~ftr_mask;
 			pr_warn("%s[%d:%d]: impossible override, ignored\n",
-- 
2.43.0


