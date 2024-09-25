Return-Path: <linux-kernel+bounces-339144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADBF9860BB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABB8282FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107521AE86B;
	Wed, 25 Sep 2024 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Kf6NQD/E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="c7ERJE3f"
Received: from smtpout144.security-mail.net (smtpout144.security-mail.net [85.31.212.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C3618C933
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270689; cv=fail; b=MrdU8mTz9CoD/Uop/dnkNx+lqkQhvFCSy5523w/Fsw4HWWNTVwUSPjrVrYiHY13GEa80xz6Ezyim6+94MA63JZ14DcfPvAVaOuyhN9uDIwgb9j/C3zsEAwBis4dUHksvNzmGiV3vJogl0Fi0yWE6KFrV3G0BvXgQ8lVsg4AKQt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270689; c=relaxed/simple;
	bh=+p+S77kM14dl8jkDF2qDbZduMPFzmpo1uUeWISo9iQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cnHDzJNEHkptX1nNdiEDx8FSO3TS6vfQeoroZxIrVpcZTHXj/5wfdTcU/VPmm8FnVay3C+pofh1ejMpnP0wSOQMCtuvpFsY7Oru2nbsSrlEUG2VU52zsbaJZIweFkQo2RMVuyP3BbsxMS/JrhOxiVjo2cu0G+muD8js7uOpSJnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=Kf6NQD/E; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=c7ERJE3f reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx601.security-mail.net [127.0.0.1])
	by fx601.security-mail.net (Postfix) with ESMTP id 56EDB349A25
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:24:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727270679;
	bh=+p+S77kM14dl8jkDF2qDbZduMPFzmpo1uUeWISo9iQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kf6NQD/E+2wdH29CfQtc0EFHEgSlxNuTx04IWw+WB7JLE5ioYN6vZ3Mrw3KAymJXi
	 lX7DbhFSnI3QlKGv9t412qnFMxwToTL169N1HhOkUkqfhPwgU+3LlVGNtNwP4wMjaj
	 wYtiVCqkuhbap4GHin/+rr3jJI/oR8CepTHaw83U=
Received: from fx601 (fx601.security-mail.net [127.0.0.1]) by
 fx601.security-mail.net (Postfix) with ESMTP id 1FBA23499A7; Wed, 25 Sep
 2024 15:24:39 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012048.outbound.protection.outlook.com
 [40.93.76.48]) by fx601.security-mail.net (Postfix) with ESMTPS id
 87B00349817; Wed, 25 Sep 2024 15:24:37 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PAZP264MB2543.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 13:24:35 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7982.022; Wed, 25 Sep
 2024 13:24:35 +0000
X-Secumail-id: <ab3.66f40f15.86acc.3>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2sOHsZCJfyfLMXMaIsOo8gtPK+RTA124+u2ZU0LmUePu78wSdsX6FPIpGY4eQrYpu4rNoxte+flWKmV3kwuP8JG2y1cukVcRPYZq2nkXh6u7tTDzjzl+yGPMzr+MvvtTuOlAeVqka5KL+3ENj1ZbEoJAnLZSgupFu/ELmr8Hf3IbfAPayO8+n9LQsXIhIJMBCTgUong0B2X1o7PKfgtCdKdUSYP465wW7yLyH7Q/kv3NYK7kUp+qd/7AQLypkl369/ZT2KSi2mG72m0zkcTXFGEKPHsPX0D/FjAljUxp0TnKBIHHpVr70+JKjQ3E+JN4MxyB3qz5JsvXAi/4nAIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ut08L4O7r8TPBHWlQDboYcOzmoTMwqPYwCivLnwoiB8=;
 b=mcs/AG/+iFOjDKEJzmSGgXHHsgG/P2saBLfMG2DsiVVX6TWRmO7ztjnuxw686FQYHw2wFk1etw/lKDwlTFkQXOgGVt1n3sikYLY2iZ2i8RnHkd6TWqCbEG0gCJd6l6JfW7fKtu+lwsUL+qbh6whmv6zqWI8FloLy0YOHxYt47Vh7NhferH0ZmRI2r8KIrxH5V4Pf/AbmpIngcIhBMUkCi0LP5BC8bpMSy/wD49YLtflGIk0g/FR7K7hRL3Q4Nj0ThWVdPfcZKxYZ2kwMr+Yvqm1dPx8m3FombBQPjFc7DJg9WEuJdv/zq4fJpU4E5qdvMYn4V2oMyTJ6EOyqSebLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ut08L4O7r8TPBHWlQDboYcOzmoTMwqPYwCivLnwoiB8=;
 b=c7ERJE3f3t5Zzbm5ZdV0THHYlTuJLhPrH4PgqjMuCrI0JWZtwq4mrTRUkG9vyQ4PMzCEFb9pBq1OhTt8VrzKZIIFRdW+uyMcUojzkgkdHRro5A1dV2JqOBLfTyszHBjHkMGr2WK3+j2GXWkuOKYNtnUQHnrMWjG86M8MAjrzg14beUxYRYa+3WoqvurjG8HyberNBPzvYROoSETOHdV4FBvJeaNmuKLIa3hKqNIxlOa4xisS9Rm+vFQxDsnxdNBE0IevJnFIZmhQCo4ea57Re0oje5RuSpqDzKvYxhKJuM+iKvLGcRhz5tIsiDaiEiqD7rSd3NALGpnmz56SN0mTYA==
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
Subject: [PATCH v6 3/5] arm64: Use generic io memcpy functions
Date: Wed, 25 Sep 2024 15:24:18 +0200
Message-ID: <20240925132420.821473-4-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925132420.821473-1-jvetter@kalrayinc.com>
References: <20240925132420.821473-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0138.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::43) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PAZP264MB2543:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c459b6a-6703-4343-443f-08dcdd656613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: NnIs0Ua9P+GjuOboi/8NBeSngkWf0ZCz0XbS4pQSnLWoQA4fFZ/+xHKGNj9m88u343jSOgidj350m3wkR6B9MOwmeqqk8rw7f6GozwyF3leWn/XxKuXpohg/xVUzj2LFZp9A0L003jx4nyiV+FJacfISK6ew0ssGdZWziE5U7rznzGfvcQj0FHCmMTDRrv+2/K29t12aJWffAScKvUD36YUomng3hmnSL3la41INHoZKQPZwg1jyPQ8YNtgl9YUjtmUb6oL2YhT7QKLh70EPyG937g0Nv2hKcCaCwC1ZhwPRKKIKASBxEDKbcLqZ1GleilGJwuwEm8Kmr1CM2uAABt4h2l4UNIOOxHh76scDC4WKNWJjL1Id6nIZLzW4secUaRa9wxwqDrHAMPwmW+6uZElZvgr9LefUkR9az0tVvr9NXGDLGpDgOqBTwwoiS1w6qbdZpqs7YxfyKYdpPPD5vdlqOxaCwDJGCpNZeLhIoMbdLxt4dDxd4LqnQqX80HCaDbfgcSYVbwzABeXJxlrE0TakVffffjnx5i78dbHr8iPOgvPtzbD14at2MlvvhPDkfdfBAsGYCvw2dpZqG/7UvIk9JNcrFYOSCBl04xSxsZ5lbN0GfR1JGHARaMV+WdOA9saX8YCamC2QfVKHwULMNyC3dgl9n0uw33LPiM44v9zefO70Zhnuyb7oVjtymRFZ9BzUO6AOw2trvXuPjqyEn5qSufD4yx868LcLdulW4xQ6v+Z/3L/5hW0XElyzw02vIP7p+iOlbnEPr9ejbQT8TzWX80Li6BiSrKr8sDpbpAdYhBguKG/56N0vnoUu8An9thhkue9wVp71UlFjMjMJDkVX6mQCigGYJW8jwYG9OXnuyLkICXssGhbSD446Ei1kERhdFOIbCcdcfJTlvQWq39rUCZHI3Ed4jNvQKPqsTlc2iSb7IOHjV+dbQyKvzhHYj1t
 yITN7pc1pLpIntiaJdcJvRz2ryz9aPMGtkmrKyUsrSKhGy8G1r0FfYIoCbnEbscqCQTvNsERKDPJDT2LOsV27Bk+7x2Jbpd/t+z0Zy2cs6i5Zgam25LvU1qgfSBHUqLR0sv9U0114O388KDqBwwItElAGZX3tpxO9pM5pHLFnZpUiaCsdMpRdxjeMdImKRmf6vgIb+pApWOo6xZZKmW3QRg2ei0c3asiX4Ext0zQ/fJYZptShyDBfzv8fwWr1MnWsa+7j7LgzJqW9OQmbY7rS7oEyLla6iW+wMoXzZPplicPIQY4wxBQGIQdabztkJp/0CgUpLDnIUMixjnZiIPDYM8FiHdx+zGbdgcd4pEIPfbMk2ulstcFPCtgRMsjYHxTQwGI8lC7ZNzUTa1bB9QPIAHsdotNs0NvqCpPV5eJn58dMfSMFI+gGR3dnggLsm+la3SFpu9MYqrdKS21yxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PmSliev0Se2XieXc8BFrQpMDI/GghURLAB7crP6VcGRn0/5MNMvtdbcJXphM/4F+rOc+n4vL0Rft99+7EvlCvAYWPDFeBSiDEQmiuJgxMeuHZsF1uhW2XM+kXnr33n5D+6+S+WUNSN9KVzdBbfjUxffo0aDxgkvawLzeKfXbrZDarQqlIjOLuaP36EAkxzwg+jU+f0qANnkN6pSWRdg5RsR2f2HDP1LdMqMI7Gvk4w1q3qOhalTU0stGADQo50vRkn2kGXAVzhTZEJ55ZscgnlzcynVexy3rwm9CrtebGhIFWEiXWH/t6TVO9p5AnxbIrvexx3c7wOzQxjdzf1HARLajFH42352BocN3i1+AdtehWNlpp6b3HV+mCAhqoyfz+mBoHhuK8oj+a58p++tgZwO+ghBrdzxxmJSH+fytiU3K/b8I5yFUndRXM2FOnCclZEx+dO3DxJfd0ruNGbWqLWGTCrstxw24fsxpmhEVdCJq7KRHdfo4Q+tabAbEBriUulKOYfPApx46pwOjseHrlClJfiOhnJKGR7elCkaXUqtUJQJGnDw5r6CIMRs8/J8dAzFiiE4XGVHbGhMcBBY71k2NNysHOlXvTbZyZ/m2pH8cl0pj7ln22FAMo+tFiIwm+CTc8H4/hrZh4FNoaPknF617SV4XdRQrPipSx+MESF7MRLj8TvyFLSTCKuFPRsHue+UDAgOWoZnsglvP8tE6WTG724bPBZZlbfjDNuN55EW8vJW1lOiYZn0lxB265GbYslyxUGrbYElPJcYeIDxQRf1rHPAb/TMe2zF8R8/1VfAEmkDnNziRSHEthuqoiu+IQPlaXmjfPZQQP7O3Or+T5lExnZ/JP56tBGgy910jntDZSwyGpG6JRit/dY7ihnAEAgHahfZ8lo6q6xFD3gEKrc24i7KaOzAKQyYqUFDYDiySSMDVzCa/25UY12fS0CoV
 2l3Uxqd6pJ1AgUYQ8lF0Id5MmWzOslPp25ugMd0ZwzqrwnUwzB8PtwPK+nF1B57/4eX99MSBuF46y5Ee4gadUe5Xw8UIEuw3FE1KOzBimKYdHwi/8y09lqoviWFW7DoXI0ZHYoSRjsDOy6uVz/0ZprET46k9MKxC3aux1Aw2q0qlvi/QF7FWlMwbiAKN3sIU5Hadx08gfZ0CNVlNViKgG4lMwIPxPLReZZ4Vd6vhJ9VBNImSFbSCqdJuxUD0Lf3JgeaOxJL9hJs1CixYR8d2op6foUvGLX+qNAUOxDxlM62gsXMAdePfqHmLs7buzXQ3x1NQE6pZIooH4O+JYrcr0mDWlleyI4oMZ3xCYY4GymBhroaLkvSUPpSzKXhZuHfQDt8a8Kn3P3FY533DVOvOJbJv3flN/1dCOLWuGvEnW6LucJiAjIumHWfeWXIgI6Biw1RZ5HOCNmnuXiT28AG8aulBwjT27ZEd86BRtBaqv29OpObop6O80Jtvrr7eR0jjPkKG5E1TCtC93hJj96mvmC+MIYu73DWWlUzWuSoPSful/7CZdm1QpejKbDqHwgIt4+F/F1PQrwYW9P1LHG2kOctLEIfjS64f23xM7JofXlhFO0BSvvyx5zk5dH6QtD2L
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c459b6a-6703-4343-443f-08dcdd656613
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 13:24:35.4715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cCqEHCc96IkQ6Br7tblSxcJrBs1ZAUTRwUyF+SsL7aR2mg4MNYQe2O3bSf1YUC9Oihimn/GISPw9qftEKD8ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2543
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic __memcpy_{from,to}io and __memset_io functions on the
arm64 processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v6:
- Added proper commit header suffix: 'arm64: ...'
---
 arch/arm64/kernel/io.c | 87 ------------------------------------------
 1 file changed, 87 deletions(-)

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






