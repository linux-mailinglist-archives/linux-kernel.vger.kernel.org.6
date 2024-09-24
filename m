Return-Path: <linux-kernel+bounces-336878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C85984204
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88E68B28893
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF9915624C;
	Tue, 24 Sep 2024 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="UHXgvGfF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Tlj0u0l1"
Received: from smtpout144.security-mail.net (smtpout144.security-mail.net [85.31.212.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482BA155326
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169907; cv=fail; b=m8GP0p/X9iWj1qqt1vYTBAvXk5Vb6IN5xveXg68iI2DZBWQOLiX6Kt7X5dGFoZAIc17NjEKvWq6Bktgi5saszpp84AUr7sGOuTAIOeUvMn3HCQ9cG3zCgq1gPugKF6PS+ZvsIFZ3ZvMBrFbhx2KPQDIRh940C3vGAK0CoWQ/RFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169907; c=relaxed/simple;
	bh=fm74sZv+wQupqd1aA35tAP0V73LJDMRwcbwSpgpGSEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ryz+iVtsTMCZr/Fa85hMH3v5zGdRVR52w/E/cJfdYY0MeMoM3zf9bT12JZMcvvi+mAMSn4AATwM6X+lIYEwdKRRb0Ie2/CujHtfhWe9wfea6WPlqjvM6wfoZdqKANEfNd1oLaxgbC9jlNp+UTDz0rUratF7nsmO3ORfR6OkV3EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=UHXgvGfF; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=Tlj0u0l1 reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx601.security-mail.net [127.0.0.1])
	by fx601.security-mail.net (Postfix) with ESMTP id 8B0813495A1
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:23:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727169781;
	bh=fm74sZv+wQupqd1aA35tAP0V73LJDMRwcbwSpgpGSEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UHXgvGfFgAXFIGBtK06mzRsjq874a90Njx1YHt+TnRjdJR8xal0tN5fDZRXvH7ebz
	 bs1tr6Ymn0MsU3jzaEZfL1fY8BIAxSBo68IkY9IT5zp06likiNjC8MSFZA2UPbiipL
	 bFTEpZ9vMCR8COJzzJ068l8PgLVgP07T9S1TTcXg=
Received: from fx601 (fx601.security-mail.net [127.0.0.1]) by
 fx601.security-mail.net (Postfix) with ESMTP id 5ED4C34956B; Tue, 24 Sep
 2024 11:23:01 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011024.outbound.protection.outlook.com
 [40.93.76.24]) by fx601.security-mail.net (Postfix) with ESMTPS id
 534313493D7; Tue, 24 Sep 2024 11:23:00 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB3073.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Tue, 24 Sep
 2024 09:22:59 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7982.022; Tue, 24 Sep
 2024 09:22:59 +0000
X-Secumail-id: <143a5.66f284f4.4fcef.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpIM/jRfgOBDAWTuyvgrOlNVo0NhuBq5Y0Am33r5Wnjag8tPVrWYh/oj/zatlPXiftdDyYwB5E6Gek0xV3GwJfCwaBttD5BYO2CTbLmfyjFC35sAFqps0I7N9SGBtksu9NQTr7HnTU18Vd/kU/CZNBlZLGjj1Iv3avGMewFIcPSJaAgoDmO1uRIupHLxxfSQyXEMjfgyqnxlU1nlEQd1SQZoUWD2JujqDyAgI2TCWOtnWfQTpGDZbnk/h6oUjDP2sL1KR9AXdh2wVGeUDpPzPe5CWqG5s8H28R8tRovZvnYGrCSlRNHpAoS37063n6GgdCu5SxmsHAl+jXk2BHbahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVUX+6s45Z0ge65VzI3FZt7ZlDdHSX5oJ+Km/4ciA+s=;
 b=PV1o09Fcs2v0TL5rlZR7K8K+PBu+g3apDV1C4XdpnzCSqBf9sUY99dXrkv+PFcwAmZnnAlMpgb5NbJE+Q6NIHxt+bQp4ryHNq4dcNRjSBaMZEhcOLUlCJWp3NJGZNQrUB6QD3V0hUWHBP9237x1nf+Y5R0Yr3XEPjECaUHfjlczKXr3oe8mJVwzerUPTuTvRgKJsjLhg8rSlem1IjAyeDDb06iYSs0cPz14SvARVy60rIQ+ceckRkFch4P3UFx5/1Im47sAJfjtJv2UzRPB9Zp2prqHjWsNto4BNjqnEM48Yq9L5VtJ2Bx20Z8bo2yWGO3gs48ZuwtRX9JiFIHpdeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVUX+6s45Z0ge65VzI3FZt7ZlDdHSX5oJ+Km/4ciA+s=;
 b=Tlj0u0l1+GtT3OAb255rjGllJ5DCEKOa6h1vkEcNayN2SJpgt8OUkOyO2Xk8Gb47KegB+p42tYzyQ62guy+OC1axTBLqk4yCB9mQ8qEaEqLiDRw2x0BsVs4rwuM+RaevVca341rWNPOEbpkuxWCHSPs92TY3aWoGnlhPGHncCjecsrf2xtPrTe4XErFqqj+6u/Uh7q+YGBzfnhjbzAtjy+/aU0BSx3gjil0sAK+zouS7o00axmmAMC2Gx7JJy8CbICC4kAfCAxPGOpjtI1ixa5LPB56UaktdORYUdmcci585moEJgXwVLa3xQrD1U6dBs/PMn5tW64ajEekzSCkfBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
From: Julian Vetter <jvetter@kalrayinc.com>
To: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren
 <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev, Yann Sionneau
 <ysionneau@kalrayinc.com>, Julian Vetter <jvetter@kalrayinc.com>
Subject: [PATCH v4 3/5] Use generic io memcpy functions on the arm64
 architecture
Date: Tue, 24 Sep 2024 11:22:21 +0200
Message-ID: <20240924092223.534040-4-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924092223.534040-1-jvetter@kalrayinc.com>
References: <20240924092223.534040-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0028.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::20) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|MR1P264MB3073:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e1130e-9f22-4987-5746-08dcdc7a7b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: hF3+HkvkEbRk9H9/sCMH9bkc9cqD4I/HJGeHPfbBJvJ5hraU1NskWKJ9vtK/kIpvqGZkTteiNqEUQV1/bJkrW0g9VDSamdujzGUzokspM5vgWlJL57F3xGoHroKSQR53P3PQU0XdvWeUVDFuG6PB0EicYlVmIgTKBwhXKi0aa+UOh8xRxa4Ay61TPu9nKXQ0CJ8WJkCRCv2wmc++WNbMT1grZPnjgjT64oQZ2bKFwCnKf3ePB+d/9aadDL6ByAY44CHtgmvyslC56s8cz3OQlbtsCbGo2OU5zY1Ixhdpayt5+6NXhkx8w7bdJvzSkBwOIpnfphHlkvq8kGW/qn77v7A7tFUoRt7D5kTlEgt65WVnXlEwu4pEZbBlR6KaSK1Emt7EcQ+rJcsWvIFyXbPNm4+ukc0Ay7Rk7UjWVIr+wP7MH+EexNwgFCd3wA7nExpepSdw/Si3HAenvXAyGW4zTJFKyZzxvwn5n9yb+MspSyFaU0LJKEg3jDtTm1/pGkIGhagRQe34iv3yW0AObfJf4mytu9qsfEYeb55umbNBMiMAyN70NPDHomXZN9oXHRMCKGABrv9B1IGJatig0aDkMWaKHbJFjv2Se3zzIXnhFTI0UjU1TGwCYwyPal5Me+cUAkOuyG2uyRX5eepS/AmCACIbS9pAM5nTZYDFsDmkBOLdNr40kL1pfDUZ6B8/k89ZgORptEX0si4CuzfVw99H3zwRuoflUCK35+FAv4tof2buwZpTrVuDjmgoOuFHY5yIli0F4QAH75LumPkthxKO4jxvDWqQoq8gx/oVxM6IuE5FZdMGCPG5ZUmbipfweXowl2QCHcfdXhbjQcfDMABrxhOs3uhkJH85VbN483a7cLjyE4I53ytDXW6LicXRT+F92M1soQ+eqhrEV5KOqutPUDvhTUND8dwt/fXxxojsJ5PVl5JzRWm00UKgO1ehgAsxP8x
 T691xLpql/yGanzMkmx2RKRrno06vHj6PpDZm1cuvWBujq6mP2lP0eK+XnIz4sMw1dkY3QYtGTTlfjmjWZFQfVY5Abr7JYD2G5jsaE5n4S8UGg8XGDOERAh2xd1QbTvpeFM7WLDuCZBmZOcLz1C6JHhyXRI/gd8hPJ9qcHReak/Y/r85A6MMEqUHt1wWgl9CWU/AAQtCh82H9qRom10S7C51D7cjeA1msegbnZkCFSkkUNhg3q4IirFV7S/sOlefvP2OOiHJDTccxviJb0sh5tkmpVHYKeIJr1/nYEp+dUlu4Ge4NWhJQnosz/7MZAxcn8bAAZJF94yqzp6jTPyC2sa5qv7wVIH7UfbrirrLnZmgWou6P0LY3DZYSROImr9LKY3Qwjy3HV8nYQ241Cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f2d59TRD5kJjaT59cH2qyW79ieFhiYc6/Ie3hLdifhdiTbUWe9D8KfleLlTs0yiN+8QLCGvW3KpP0zf3W0Ee4Wv4Do97edM8khjBn74HT3XX3TJAvKfqONooMAaAgSk8TQkFk39La2+lHu6dt+2GmkLrAbX/JvRzVFntWrMytT0M0odyfVfkerASZjyVdshaaF7MdyZODZRMNGvT2wkh+8195nO10HZiwACrAEMM18u6NuW745YyYBGgVWTGsHj2U/9PcwpLu/dvX3j0tokQs7lYKUuXH1JS90Rz23eUge6rrimsnM1DN5cpFMpd0+r96otQ06G7s4ZA2ehJmYoldfHtGKMxICyr1elg9w6JfQE5Gm0WgyHLqFwM/cNZmE29G2b2dg+Az8emXgryuZqCTc2/M9kN1fml8dtKUqUBEc6xiEPGL3qXHKaJWByOiY1vU9qOYFJfr5XaM2X0W8GPd79DyfWXCubCad3mgWazQ8QUfXFMfbg+J7K3sS6ax1VKZHL/Mr7U0DA7mh08HCqbiotQasljgPJLV3zEvkpx75QOCIrrjxUmP5rbbSB++kBtwH+VbF4Yz0TnruxAdEQvTjMd4K0NcbW6Sfj8p2k/yh59y5IpMsyF/8dWVS4ootm2c3RYdisrYrulAWivVmM3kFdlWf3fzXoex2+BasQLxnrzLb+ZJXuICyLvcKn/tua6b5OFIBjyzQvci7vqhCyFCse0wMVa6lr3UTt4J3vXq/laE9/7dXZK1hp/bvhqz0oUTslw66xquuufAQauvfsbZ0AU9mRdkjQIHb+Lwkei6JHBtZk3/yhK9G2zzYb64MFPDgldd1uvIHV/WdCdYKgNAc+nAqA4uBwUw+99vtk0NmsYZvtFetadVnABDxWXlq4I3N2LyxpBfSW5oT2+ZbgRgfsxxB2XmCuvDDwO7Ozc1UgDd2EQFa3LYW5UGORk7n3z
 XLY0bSuvh1Gikjtn2nY1p8iyL8/uz6zgvCr6bgCEWrDuPwZ2E5tjuqp3i6thBhyfaSzybssfAF67cXcd5+imU3eMTHcb50HPdyQVyGTTcZ96yPm2rh5fE9JtzQzCkEgREcWckX5ScocvJgoLHsuWHjgJwM0TfPZe4P5e1uFbAkfiK7s1pBRLNmajDPOJZuRQ40IRKgyda1FOKy9mmKJBxDTd5bVRuF0RMOMy7cchrgLd335ELvTJnpt72NlCWJGvJLEhv51ULQ4fakSkC1Y/hE+V8Mmtm4gRv3diQ4bXAM5xeCaa+6rHtC7m8b/ZeisfxQLG3pEvErXIGlJCZaUf0nFveby6lzaKeQVC5GJhZ+aikjtg1OU0iN5Xz/x79VWUcpsXofzEu6w/tfZpp0y2k32Z78NjM+w0tajTu779XjrPpIGqIhV94toObESNzuhkvrZ+wrdngPWtyHJlH3uXDvdJbGq2sX9UqWXm17CygaZcjWE44JKDq9hVjTfpZB/CAOHCpQCqoRpn5AoA58hfqbwedU0+S6cx4DSkqfDYiYJcVKW9VfrYh+8T65QeEoSsGsZGlOLMSaxJMuvjvh2HQvK2yJ40qXCL8xQNEpNfA0PxNS/EFgsNVRtGmlS+s4aB
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e1130e-9f22-4987-5746-08dcdc7a7b37
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 09:22:59.2024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHqPiTSJUv6pkPQyxy2Wv3g6k1jBK5dEbX8dlhQXwtDWT9fSANSMDeQvgfQm6e2tECbJE/0fus+lGum8TllLmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3073
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic __memcpy_{from,to}io and __memset_io functions on the
arm64 processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
 arch/arm64/Kconfig     |  1 +
 arch/arm64/kernel/io.c | 87 ------------------------------------------
 2 files changed, 1 insertion(+), 87 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2f8ff354ca6..cfb1c729c9a1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -140,6 +140,7 @@ config ARM64
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
+	select GENERIC_IO_COPY
 	select GENERIC_IOREMAP
 	select GENERIC_IRQ_IPI
 	select GENERIC_IRQ_PROBE
diff --git a/arch/arm64/kernel/io.c b/arch/arm64/kernel/io.c
index ef48089fbfe1..fe86ada23c7d 100644
--- a/arch/arm64/kernel/io.c
+++ b/arch/arm64/kernel/io.c
@@ -9,34 +9,6 @@
 #include <linux/types.h>
 #include <linux/io.h>
 
-/*
- * Copy data from IO memory space to "real" memory space.
- */
-void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
-{
-	while (count && !IS_ALIGNED((unsigned long)from, 8)) {
-		*(u8 *)to = __raw_readb(from);
-		from++;
-		to++;
-		count--;
-	}
-
-	while (count >= 8) {
-		*(u64 *)to = __raw_readq(from);
-		from += 8;
-		to += 8;
-		count -= 8;
-	}
-
-	while (count) {
-		*(u8 *)to = __raw_readb(from);
-		from++;
-		to++;
-		count--;
-	}
-}
-EXPORT_SYMBOL(__memcpy_fromio);
-
 /*
  * This generates a memcpy that works on a from/to address which is aligned to
  * bits. Count is in terms of the number of bits sized quantities to copy. It
@@ -78,62 +50,3 @@ void __iowrite32_copy_full(void __iomem *to, const void *from, size_t count)
 	dgh();
 }
 EXPORT_SYMBOL(__iowrite32_copy_full);
-
-/*
- * Copy data from "real" memory space to IO memory space.
- */
-void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
-{
-	while (count && !IS_ALIGNED((unsigned long)to, 8)) {
-		__raw_writeb(*(u8 *)from, to);
-		from++;
-		to++;
-		count--;
-	}
-
-	while (count >= 8) {
-		__raw_writeq(*(u64 *)from, to);
-		from += 8;
-		to += 8;
-		count -= 8;
-	}
-
-	while (count) {
-		__raw_writeb(*(u8 *)from, to);
-		from++;
-		to++;
-		count--;
-	}
-}
-EXPORT_SYMBOL(__memcpy_toio);
-
-/*
- * "memset" on IO memory space.
- */
-void __memset_io(volatile void __iomem *dst, int c, size_t count)
-{
-	u64 qc = (u8)c;
-
-	qc |= qc << 8;
-	qc |= qc << 16;
-	qc |= qc << 32;
-
-	while (count && !IS_ALIGNED((unsigned long)dst, 8)) {
-		__raw_writeb(c, dst);
-		dst++;
-		count--;
-	}
-
-	while (count >= 8) {
-		__raw_writeq(qc, dst);
-		dst += 8;
-		count -= 8;
-	}
-
-	while (count) {
-		__raw_writeb(c, dst);
-		dst++;
-		count--;
-	}
-}
-EXPORT_SYMBOL(__memset_io);
-- 
2.34.1






