Return-Path: <linux-kernel+bounces-321485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F12B971B19
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27994283A3F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8007F1B4C5D;
	Mon,  9 Sep 2024 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="bUsFJNLz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="grfeIMZa"
Received: from smtpout42.security-mail.net (smtpout42.security-mail.net [85.31.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF9B1EF01
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888745; cv=fail; b=UbW+lTyfmq+zGuudNIbquVOnEJvgTy++Tq8yrBymgPdc/yfHOkvMXUzOExCTVKP6grAuGzsadPfxHcz3MBF2qd4EsdgIHN2ux4+aWfxTWfzjLj328umZGxQJlkbx0RC237WXHJQ+wpnAVxwtG+fvKF3EORWb+auXSmHv5fV7oqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888745; c=relaxed/simple;
	bh=fm74sZv+wQupqd1aA35tAP0V73LJDMRwcbwSpgpGSEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/r3xXi7QYSTtuIoTAE9JsOkGwe+cW70AMoUwnQmBPfEab42TU8kobGstPF+LjDN7xmZ6YnCjkZU/9sU/DwA6/OI4M5DF6mhyP71jC6z3mGWxrzN1DFt+isRtCXdFZZTC2zUEifd5LCNDVKMDek2oIIx4ASRqv3ipEWnTy6f8Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=bUsFJNLz; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=grfeIMZa reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx302.security-mail.net (Postfix) with ESMTP id E52EBBF8C0
	for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 15:32:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1725888734;
	bh=fm74sZv+wQupqd1aA35tAP0V73LJDMRwcbwSpgpGSEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bUsFJNLz4Y7LBsGYrfR53UrKPNnKEpe75aQoo9qWVff2Qxb5GRCYjPv+N0eRFRkzv
	 B9XRYkeRjxbNioWf0I79uGsCuNzx/EYlhggWDDsWn2BcKuH5hsgpUf3yuXLeaJMmIS
	 gEm3DLV3AbaWDGbOC46nlhPDlFot6KS3cBwRwCdc=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id 871B9C0066; Mon, 09 Sep 2024 15:32:14 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012051.outbound.protection.outlook.com
 [40.93.76.51]) by fx302.security-mail.net (Postfix) with ESMTPS id
 E3642BFAEB; Mon, 09 Sep 2024 15:32:13 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2580.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 13:32:12 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 13:32:12 +0000
X-Secumail-id: <bde6.66def8dd.e17d3.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWjv4DYHlHpZVQH7VzeDCs+828PD37TTOUoaz9IREIecXVl7jkzRNqng0DYSi1smI7xNf61SzHIEXIYiHa9z116SNYfhGxWHHTX8KTiyy2qDgm4cpbL+u0xNl7qgrVuaGgW+UhhDJLyAKJ9QuL8s5KRPWqfDM7HIZjKWCw7WM7ckPFJwc3ExYYWDX39T8u4cprn6jT9/DXisS4iYFK7vVwCnMIOsly/w9eAO9b4Zx8xLIf6KHQAAhsrDYUzP8onecmQbCnGh8hxpxbfdTP9HkXdiPQ1ax/JlD78KYYy82SAu2yEpeXAKZWFFrD1VGyN86Rcia+uADO2UvorOW6iMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVUX+6s45Z0ge65VzI3FZt7ZlDdHSX5oJ+Km/4ciA+s=;
 b=J5GCjBYt8HbB28NjMbmFqHXI+XXTPFUW+isNOJD++JUoYPS+0VqPmclnFb7OHfOfMFtWAB+PGEJdpYshIreNTxyY+ZRS3r4dMiqFgx7DkREnnDlbnkVUFczoML8iVUpn2mXzFTbt7tsNtoc+XJ3Md8ob3IPFOw+oE3BiNesiKLRQ+FYSMRl7FHnWjVbhcNJFbqg2ZWq1QkJi6/XPexW7KcunlwRKkCosYKwQDDCT3X0ZwTGCxAkkg3zwVUpGon7OlhzxD+SFFIjL/8mUCcH9e7NokKvsd7E74v/uXs8dLa1BIzlLWMwey/mBLcvCJRnRYo4PydFNkcsnPOLGRvGNeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVUX+6s45Z0ge65VzI3FZt7ZlDdHSX5oJ+Km/4ciA+s=;
 b=grfeIMZax3zk8DiOduqxwkZOCJTPrVNo6ll9G99jJZ4TMJn3p4J43H/3/eqBb4iRTu4MPJbYOhAwi6hCQaEtlwI+YtQ8ejR/R9THI+PnGi5+ic8XTFJvQ0O6BzbcjQ14XfwbSnprSOybJFyhw/9gVK5ekTCvDwP3+s3fapvoFjurzyrZJFbNgc1aagfMXfJJR7K9qbijLTH1MfPQoxuFtO20069eaiSUFFbmEXPibtcY4vxXIjCrdSp9luqdeSBcaUbe5G0xzMd52pykVDnqfATDvG88PSU35g5/8RAE0OVoJ4q6DXo0rDHKMAgIZipY8ogwVGHnMJUtGNuLtrmoMQ==
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
Subject: [PATCH v2 2/4] Use generic io memcpy functions on the arm64
 architecture
Date: Mon,  9 Sep 2024 15:31:57 +0200
Message-ID: <20240909133159.2024688-3-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909133159.2024688-1-jvetter@kalrayinc.com>
References: <20240909133159.2024688-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0106.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::22) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|MR1P264MB2580:EE_
X-MS-Office365-Filtering-Correlation-Id: 3386f99f-5534-4836-e451-08dcd0d3d008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: hOIToskQQwTquixe7ZyknEDO61S+BH0/UFT+eigrrIT+Gy+3CDiH8L4hyEgq8x22Kxb6yMLAShWjvgfXaUazxK7GIBW2wCEOTplln3mUuDjGVlVKbLMdBA5clNCQGfSullKJw54/B3VxBbfyYicVxang0SJ2cR5QtuykA3DdAlifDQIOeaQVtWeeiaJdYCIj7mMdeVdQV3GkxCxOTIA3gzdRa3qP+5hhP6mqHRBu7oxXq1D/ObSEZQ1t/aExuyI/ye6v92sdgogD20tlkDKvyU9lhyRS2bM0dkIsdwwn32jRnYl2386+C2C4PtmgAF6dKxc5YayUCkvJUPbgA8SAoiG/dAX36XOc7JQi6kfRgj5zGrE+cJb7Z8PX6xawsB6nsN/gY9U53PVhoJ2oGKS61uwpBKZ6GHaLdCFgc0tRORgLDFELZ8+TJwEk1o0eIDu5Mdi2AhIToTTaE3LPpdNyciMQuvEXGENSbLKXMVo+3Ag2RXgyYw1MKssOdUWGpQ55bps5FtaJWLYzHqNLKNU2ZoVf3nghSOCWLfGyJqyKHC6Xbe9kxUu7ohroOUhDyk5ARVQIb3tHR6Lz0Pe3F7rm18jgeqO7Ijbpx/5zLZ5wI9NfQmrsDYOHbY2KMbzZhh9GnddwQHfItoYfilQDtfxFYLWsphLjscnhnVGWeTQxgjnblc2GJGDfmNUC75p+Dw4xsolZLjnyI2d+ujKWmhw4oQLdYI8QAwi5Kb5kQ1ujWsuwNspkmNbYf0DJRc/VBmNgnkM2wxK6QocZEMTU3QhUZYhYO+/a95N1mfdryJpVPkjemC303Hau4yEEA6kvxba/T7ez2MhUNSV0VMPf4KdR6tC5JGOwsVQgzvPiGFHSsDrdbNnc1PvdrMgzkMYrlE99lpqnCfjW4LGE61o2VsrYC56HMCV3ZKi8MpJJH20HWd9PFyrx40z+o01b9yJh5AbAsyb
 TlxK96kIR2jR60xYpcuUsgRDKsR/BBdEfgz3Sr364nGhwFF1WgL7vrtSUlo3RWNaOllL/Qg10QMiVksSvBYPisYFDGuF/YRicOfFYdi3w7KrqjDzPMoildl8cofrkSjh9yi4RGY5w2lSoeuHQwRxgTBCLFSfJlLIu8pgGW/7aDADkACo98XZLmktQ+Ntft+s4/n68jLtioNNuvMNrNFs2alJvo5dmPXR+M+W/IbdIP5yrBGM+jqO3ZIFTjqTSov+E9/F5n9eXrQgg/+ypTkT5qvgqgyuHLoM/7ule2EmOLOPJiFLZLVFHOJTssJP1PRUIC3oSQ6W9Z2WleicbbuHwdi/BVFuwgxN3ouxS4krz3vXSFHhXjVsNprlwB6OpRuR0udvzj4D2PTz4oIVlvM+zvzL0JOdO0YU/pYR3BWUR6O/XUn1clJa1ZNq9FTwl8BSio/e9xw9EB5DjE/FTHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QNOIDnp30BHxCy6YTTlXBTzZnf+yIKn0zi5zcZpPFKiGD2fWB5EkW4TYU/iN9483vDnmQWRP9bq7gWVqidaGyNRBkGiGjmFtufUCP8U3vx1/55kHSOK3aubixYkWoILfnz2HPgqIlZDAqRRTDfKzjDOtd/3iEfbutjMAjQ+XxE38AjWExce2Vs8h54dX65X3UxGXNLd31t5nXd7e1AZRcBC1tUe8P5rOwrC4vxsYwXTka5P/b0NlbQ2+nIxzciNgMzZ56Zb2yF6/DzW6Dodk/fmwoBRd29AEsoD8pgG0UljJ7zcJa4/Y5BlhuhJrOe8zDBa6KgfW5ubF8Do0wD+m0/cJEq50wHA3rF0cc8x5qjCAh6vpbt6J13rty/r74gA+jUNcaAw06a+pU5Fxpp/YBU7/7YfboKZa0ZTNmAB8yo75+2tPbxm7OVy2/8hwbkGPX6JKjO5UHMdc1rC/V14EsfSAeZmKJppPGMESXEEci0fIfoVcpabLlL3o4ifph5oMeR/gKrc06wIXq1GPSFWunLxJkKkgNE+rshBwXCf9Rr9Oc/BzIIWt9H3hFewYfmrFI2isi+bn+QDKDhodpSO6J9yACyWI8r3tgSs4ZkaASp2t1NqMHo1UunF1m0OuqtiHGL68bkoZ+XaRy5pvO1+ImMXRTuLmom89I9EpLTRKSM1saZQyLRrLt6krKbKwDJKc8kiyFRvRYOTO6b4ut9y8A/XkdHT5bbZC7CxcuVqzgWQxS+04RyRAGQLhV3CVAm0BzIHtKn498wFrsvJ64SNGKqTenuUThChGaWvTIsJrt4iuvcBphBSITWOkLjmLnEhIWBvkvjNUjSn1ly0/iGy8niXpuQtT1HBDjgnDachhrHZXzL6cpOGan5hBD7QMHxcDhlrvbu2xxDJAoLSxhaeqf2FA7YxiFRIn2TeYnZ31TRtDXIIeFo41QblxDiYSx/J0
 GXe+Dyu7RqD1CsCDpZFBgkucV+xQcW4ZL5gQo/ld8Nc0Gejz8Ldgr7Xz/pbrj8xjN8o+UpLcYFFFUumv4NN0CZJFVyh0BiFDpyRSQF3z6RQYHmjbdk7CiM7aSS3R/eJpubhGbyx/tb7tDH1kljIlp5vGuV54S0xKTStDnEQFN4Vyvf/efnF78tj5HGdFSc83N73o7QU/MvT4dUzTT3RmGQ9U3UTYnLRLSOsYTV3SORGus8qddEFjacWTxWF74HQ9EAC8knpXdOpKIIHcuJY1G+LH9Z/avhLYZdGL34Q9Tthkyrk4syO7CABVDJE8FApy5YCErK3xTsexOb0u5p94Ml5MLjOIvv3MBzwDlzLGfftJPZNuXLu+Z7X5vODiT+LTdJeStrcvSRLhgpNJ+6MYVPNYOLEy0bDxiLstoL4y+FPPn5ANlaYgwyQr9fRfqJA/tvgjI9HaS/gYV5FvUCLkufuChM/G43akBCc+k1anCkVPE08ZFw1UiXrLDCwfMYizq7XdqJzGdi9uqgmWe2LBc8c0Zip6v/Dg5mMmXOCLi24PDdTGgvpMFR6+tqE3InvW62g4d9HaMDrag5R9X12m1un+etzvUzlvByQNypDge+Iy5JnqJRnd+glnHhOa+we1
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3386f99f-5534-4836-e451-08dcd0d3d008
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 13:32:12.7946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9lZEfMDVHAsCGG37qPh7/CkSuDYWd/MNRRoSUGavv03t6VoRy2KgUqknqhT4BokUUkeyfLLM9TzIADFDDeeAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2580
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






