Return-Path: <linux-kernel+bounces-332772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E13497BE91
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57362838BD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B758D1C3F16;
	Wed, 18 Sep 2024 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FjgOI30K"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2070.outbound.protection.outlook.com [40.92.44.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5200A79FD
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726673066; cv=fail; b=d6Sc+MxWGsRyHnClD0Ig3l/Hg142A/s7SlTQhxF7zQJMkzP5JoC/rxDj+72sXanCmQX2MwZxwgTrZeI5YzkZFPAuA5b9YKjSUxxgpx6v4Iquo1SLyIbJFThZSUcRqIvCN8cN/I95Th0pf589G8Qnh6I4ACXmPugrcrW6qu8hV20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726673066; c=relaxed/simple;
	bh=6/KX8h6EGNHSGbwnAIJgwsAdU0CxUASu3KbcitO6CCg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=keYR0Ltf5Sv6kghyl8Tx2tyEsPZ5/bAIbGxUpA7LPRbkZ09Z4H05QprbPgOLcPv49Sn1v+ygcPx80SDcd/x0mOgCXFBmgxahKv6mej9Kr5wruMmrcqghGh5IPuh4gSGWIbehsw6KGKS5xb+6whgfUNsUTRcyc4598nSMH0XZjHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FjgOI30K; arc=fail smtp.client-ip=40.92.44.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceYfAEzxMUBe3ONFrtAV02K5Rzrens7dDIG7neEmHMGLFbTI/IzBiQ0NYbDCLxn7/vDH2013JQLc7bxirwP+2rENEPWkLP5gTMHyfzRJLBxwoWH1EjdKsYm1yaMi8T8r7VWD9VbB/cSiIdVHubWWDcBFzbmqr4yFMvw3ZidndxCFWuR6nhNjH/hTTSF4UgGOCwX/aqqkxJwpryirTb+7fIVtRzFaMTR5JOAdrHjaU+MfEaz5EIgzWaPRJwrQ1Vfu+8xH35/RPfyKMoAhXslGw7wGrp01j8p168L1ppK8Vz9OCktG6nQlGWjIJrEgDVIfdVbMfD6hEfdfhDsUlUn40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5sDzeocy/oy8RfCDx5Ou5zfnHviu5QnxvIavNEnp8U=;
 b=uGAYX+utJk/LkNeHzWobRD5k+Cyi8/LKeOPy9PswmelK6JMQwiAsPA5ybjV/1+DMY1fwY9Fyq+589jok5Jy+dqz1WYLZk+mTA3JPy2+PWBDUS931kQQcJs8W4RdJBYl3MWjLBxMzZHcJnEIapp0TVpVTwxzIb/1OXOAWCivHc3aPSVVFrJTPGO7oUy4HAF94HYe5A2WNaVgAHxWV5+6VV7N0xGzo8oHtfC+nKCsGztR5Yg1sMIpATMAo+9gVXUcmOcNaefLpSmYS8bR9HmLD+ZnLLJ5T8qRks44Y72BLXee5T17spjp+LJ0QzM237R23ojsrBtveL8tcKj1MOajTTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5sDzeocy/oy8RfCDx5Ou5zfnHviu5QnxvIavNEnp8U=;
 b=FjgOI30Kwtd8SyIOWw3Jx50PijvHGE6aFdOEvn7Lu27RFew2DO4J0icG1hedomAt6WoGbdi3hJ330JOYVF8Bxfq4mQRIY81Kqnad5BgyA72zxhJNue9Z81h6GSfgqyeGy0GBEP1iY1OzrMjILQz/PGzKdoslD4qa2l8c96q+waGyoNigiope95yxmBcDyd628MyD8QRLgY6V15yM7zovE2K5VLC5ozXgafAVrQvyaU6NiVsEB1Kg1SYojK8OTGWG8EvRBroWMOZvc183nmSSJcgpbNYNltbskrw1svLhq5jsaSuaY/p4Df7dGb4OAPxC91geJH37SA6Ad8Kj7GVOvA==
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:a03:570::8)
 by SA1P223MB1186.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:3dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Wed, 18 Sep
 2024 15:24:22 +0000
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd]) by SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd%5]) with mapi id 15.20.7982.012; Wed, 18 Sep 2024
 15:24:22 +0000
From: Steven Davis <goldside000@outlook.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Steven Davis <goldside000@outlook.com>
Subject: [PATCH] irq_work: Improve CPU Responsiveness in irq_work_sync with cond_resched()
Date: Wed, 18 Sep 2024 11:23:17 -0400
Message-ID:
 <SJ2P223MB10263844181902531B671FB6F7622@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:610:b2::24) To SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:a03:570::8)
X-Microsoft-Original-Message-ID:
 <20240918152317.5346-1-goldside000@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2P223MB1026:EE_|SA1P223MB1186:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e5bdd0-5ab9-41eb-9609-08dcd7f5f883
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799006|7042599003|5062599005|8060799006|461199028|19110799003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	A0bi84LH1hAuq0A1IKo3Zt3LkZfYxKx1TlKBdy275ZnRCEhz5MCL/IJmOOJhEkmsc6GwUx9hla0FFgHbrS++2WvJm62qlIE9XCyTE3FjNn4PJ4w3kwspDJ/IMN6UZEyHtGgA6hlcHNuaXGDeZ3HTWxfEUJQ5ke8lIKpaH2PtikVyAFDAcIGXK0/jX+c3ChiP1kRd3mEiYyU6sSIQv0762ThQwjGI8MFi7kbjA4613cka65wSZFgGPBjCC5Hrvc5u77WMyC8LRpowyyE2xmEn2d9uLK0TyvFmmqoF/if2rnfwOkVfemW4EurKr91vExY3KPwuxUz/9v5n7guNxwkYGXKpHehW0zx5EplKDTZdsft8gxlLzjw3CGQql4b5BNC1z+I5iDSNmNYq29LsMDIDa5rg89I9UY7oO7u+YEQTmx8ltbProuY02y9DJ+Mk/UI1e78XA1cHWOtGVw1vQrNXW0w+z6fYekiLNRHjnbNNGUwKx7iYX/5Mq4j1TCg6G8YUPFsRuJWwgEuYqhzg6UrHXlsUNtVqqU4+94iTFSHAFcmb7vbda4v3QHajqeyFVlRwRSoW5wR0lu9se4v+geVTQhTnN48ggIIsZtCl88sz1tEGXBvZZ/KM8nt5YgkUHeeA4H5UllgJa6nnd623TJkz7Pz/8nfV1/mDg63r9D/IE6lNBJqkyorOBX9v1e/U5JjJxycfRGrooBOsq6don9M4zdpXAv2hZOAP/uYLwaWoj+NGOQ4pmdYmhqtnLY+M+XmJF4dLbiKtu+iDpnUl4/nSmWNrRTXdE22zmuiXprREPew=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HQNPIUhwhdNBDiZrXpaA1/IJQvPqYYy+UZcmgRKqECy9UfL3JhZAN+yNuFrx?=
 =?us-ascii?Q?achFYuyG5V/sHs4Zozo7mXg4eN7V5uECC6SU5klMbRqbovlcpH5loa0k3upV?=
 =?us-ascii?Q?jagYo7voDLkJNjvwF4KG/KuNn7RvJ3B+L6lOHwqUocfA1y5lPUm2do7PM1nJ?=
 =?us-ascii?Q?PNGKSI5txD459h0ELxfqH6p6qc3A0Cx59vF3G+LsPZvlwrB5NacvsjnYlaS4?=
 =?us-ascii?Q?krcdpdMOxuxs32UMnbdmyKYtwuzjKDwF6D62HUWyWJT5ItGbTTxvZe2HS0/P?=
 =?us-ascii?Q?GyOwZls9m71XzKFErwXbro/1XatjwAzTTioqDtdv+lM4FtGuyAYqR26PEHci?=
 =?us-ascii?Q?fkNMdRLLwihY65k7gC+fsCXuxNDKRoXImsvpXT+FKOrFGfReWSrRh3yvXcUd?=
 =?us-ascii?Q?CjoIxeihXNFUwmKRVumChz330E6eKIIqULtCvH2m8RTb2dplTrxhv/01eLr1?=
 =?us-ascii?Q?zii9cXWN60kjCjGfmKM7U5zHpfNz12bW/DuMo1//zucMH0sr6fqqA/C4WNqL?=
 =?us-ascii?Q?nCEVzddJdquBP91RUS1qEjHLy2WJlw6+euCewkxtofz8jGo4bs3YN7ldJvhY?=
 =?us-ascii?Q?froEBS5DqjwKh9s6maRM4VHbpZ6GM5QJOcmYyVNO7z8DWycZzipsV0gA5GTn?=
 =?us-ascii?Q?/PgUdDgt5ebxu8RBgqYxstyeBCl1e6YD21JXY5DKRyGyIb627z13b/1Al1Q/?=
 =?us-ascii?Q?gtShqx2MjF8ZnbvSqw/6hmmTambFQUG+vtnIGtVHVJRJKRogu1gtrokwKuMw?=
 =?us-ascii?Q?PLyCATB1nm79BZAD0/BjPbyJhViyjATmG+0wi4n0GLQsMnqNQydsYL3Fitce?=
 =?us-ascii?Q?sRzl8bhPirLxmryDXijtOsgWQcxr+HwdEHKM0o2jkWVtytfYCgvjUTrR0uu0?=
 =?us-ascii?Q?LuHoXxzlFK30mqgvA2Q4sHEKKmBhVIRBjxHkNC0tKNlrqAXogCvuD6z2Qp/v?=
 =?us-ascii?Q?fwFCIv7+RcoWKO556gOW1P8kJVMWt3PKUmgj7azNLBx9oGgHds4VkAmvZziO?=
 =?us-ascii?Q?j45SYdhACc3H1pE+hD71FqicAOOlpr7TuwzZrzzNfDMQQbZSgBgSgZgRe2z5?=
 =?us-ascii?Q?xwwhvcpg3uooa8jT2SmpVTqZQCyqt5p52Oykw2c7Tuyj4y1T1GhuDTuK/Tg1?=
 =?us-ascii?Q?W0NtJ5R7tAfeaUOWTAer7gB5qtEsWydaWL57+Oq0YR/qgROHu1gCAjLnfeNA?=
 =?us-ascii?Q?8UGXtEpjRNmo+NnA7dfhaoZcWTYLft1D5vZcTXtQePA0eXAlr9xTgRo64ZkO?=
 =?us-ascii?Q?Ox/qI+OfGubQR+q/39cc?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e5bdd0-5ab9-41eb-9609-08dcd7f5f883
X-MS-Exchange-CrossTenant-AuthSource: SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 15:24:22.2752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1P223MB1186

Add cond_resched() to the busy-wait loop in irq_work_sync to improve
CPU responsiveness and prevent starvation of other tasks.

Previously, the busy-wait loop used cpu_relax() alone, which, while
reducing power consumption, could still lead to excessive CPU
monopolization in scenarios where IRQ work remains busy for extended
periods. By incorporating cond_resched(), the CPU is periodically yielded
to the scheduler, allowing other tasks to execute and enhancing overall
system responsiveness.

Signed-off-by: Steven Davis <goldside000@outlook.com>
---
 kernel/irq_work.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 2f4fb336dda1..bdc478979ee6 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -295,9 +295,17 @@ void irq_work_sync(struct irq_work *work)
 		return;
 	}
 
-	while (irq_work_is_busy(work))
+	int retry_count = 0;
+
+	while (irq_work_is_busy(work)) {
 		cpu_relax();
+
+	if (retry_count++ > 1000) {
+		cond_resched();
+		retry_count = 0;
+	}
 }
+
 EXPORT_SYMBOL_GPL(irq_work_sync);
 
 static void run_irq_workd(unsigned int cpu)
-- 
2.39.5


