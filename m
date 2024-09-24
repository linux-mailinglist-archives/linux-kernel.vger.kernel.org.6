Return-Path: <linux-kernel+bounces-337129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AAD9845BB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784E3283FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A759C1AAE3A;
	Tue, 24 Sep 2024 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="ABXig/f8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="aiMmXvc6"
Received: from smtpout143.security-mail.net (smtpout143.security-mail.net [85.31.212.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787781A7244
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180091; cv=fail; b=FzsJbpm/XhRa3o9ixKvQDgDqvZS/eGdXwX3Ss3uD3XOkkRQp2/t5sKUFv75oen1Z+srFMZv/L+FE//mCl+1WJ3h8yTtYEEliE+7mXD2jg9C2bngQjKmQa++Z/PNIScacb4lkVNsqCBwKL6+RjjLpQu4ATP32VhN9xUSFwzJj+bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180091; c=relaxed/simple;
	bh=QMnA7+j/tist6awVRaL1CsNxoHJDsR1I35iTnhFKLhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/J2NWrqOyMnVicxhEyVKBp90YnS3bErf86ALT8d8jR3yhrpXd++WyIV+PH9uFIcvvpzzq2COXjQcVBrhTRptJJ6oVyuTquwDc8MMTjZr1PDsJkZnaoM0vtGqYhAQCj7SJ7MeFhF6LD1RC5vWfseT6q7hcca+/KQ7yCwPe01rHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=ABXig/f8; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=aiMmXvc6 reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx403.security-mail.net (Postfix) with ESMTP id 8CAFD903F04
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:14:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727180087;
	bh=QMnA7+j/tist6awVRaL1CsNxoHJDsR1I35iTnhFKLhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ABXig/f8mEBC70KOz3O6iA521R+4D9EGvuLITsmrJrAHPjeBm6Ujc96K9968dBvZd
	 yj/oH/2ccxfbNSuzM5HB2sAYtMWIsGa63awmF7Lf5QDGvcyU+WdI6GyASsSts5JRZQ
	 RuqhBUmIzjE3NYb6t9SxhsEQUsotwBGHXEKjyBCE=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id 2B91C9039AF; Tue, 24 Sep 2024 14:14:47 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011029.outbound.protection.outlook.com
 [40.93.76.29]) by fx403.security-mail.net (Postfix) with ESMTPS id
 475639038DC; Tue, 24 Sep 2024 14:14:45 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PR0P264MB2391.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 12:14:44 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7982.022; Tue, 24 Sep
 2024 12:14:44 +0000
X-Secumail-id: <183d4.66f2ad35.457bc.1>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbOfJpwRzKRs4d2jkImlyj7fwcDEAUUSwf3aJBSRUP1gujLdsVVBtJ2o/FypyfgY1Fb1PbFczX3sM0Ht32a6zaI7EjuSSGfKzV3iNarcPMstjk5WkUudO8P/UFfyWJYtv4T4k6wkxZ7h25l4GyVQykyBr3teMOOeUSjX2DdA1H0DlZqT0mFEeQyuJjSBIArCIWTA29sKy9a7r3ZL8IWhg3VMxNg13PG8GIp6W/RprM7MB1QfVP4epo9Jr6Q62N1P/iksp2Sw+Jc6QpiCNO1+h+rY0tbufKNyDr/upmJoTpfURqmsQH2izFOCiGAAHds0HnIhU2RJalBjiCYiGFQBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THhQb3BnW18KKaw4x+7oe+XEfsxz0yeSXMl5vSgztXs=;
 b=khpsAdu+n4YkjQcdHoz4TqluovZ41HaEGQdzf2nLkN8YmUQY1aUw/GMZkvI3I20ZjOOuWxjwwAMupHbxUWw4yN1/fqXoH5cO8GjzCbgCEvPUCT4QobVGCKTn8aoSc2OgF3ELit4fEWNXAas+QdmRLmZnn7myerL7LCoaUYDhPDPZ/tKBArGQsjy7XrQjjb31bJYlEO6X9lZ+OYV9lF7kqTPj34BH341M4mp0RXZSirU+k+8Un4u5F5jcufxF3tqt3k+rLg0iIhQEa/MXI1D76HTPL79DqwPAWs5SQt5RF2iyWhDrTmoniUZ9F9UWQW+MojwBBtlESuq+c4Xo6SBB3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THhQb3BnW18KKaw4x+7oe+XEfsxz0yeSXMl5vSgztXs=;
 b=aiMmXvc6koUwqGp5aSnQF8BQhRQfX3+Qna8ZuX+TrS0JWs3qFjI17yFluNwjE2ucDwsQpSfBlk32uKvbw5n8z5F1uyf4qhYUjmOKXbRRHLvsIhrw/kl1xzg7UNIu1qjVSgCU7WtwFNZL3bVReaZur8o7+BM2DBZM859P4QIl3A6LjTj/ONzmePXZt7UGotuMePwNVHF+R02lV5fBMKE+DceIjN8Z4qv5dzV+2NLTSWgqIxPrJZ/uXxQmZGejfiaNzou/8ceCD98hkkpJyhQVle1QG0ekoHt2rrWXm8lYAtk1Zl+dpE59NKc6eQYK3E+6ETxenoIdHJXEokGb331J8Q==
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
Subject: [PATCH v5 1/5] Consolidate __memcpy_{to,from}io and __memset_io
 into iomap_copy.c
Date: Tue, 24 Sep 2024 14:14:28 +0200
Message-ID: <20240924121432.798655-2-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924121432.798655-1-jvetter@kalrayinc.com>
References: <20240924121432.798655-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P195CA0005.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::10) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PR0P264MB2391:EE_
X-MS-Office365-Filtering-Correlation-Id: 831e1507-a312-4e93-ee79-08dcdc927983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: xvmEIVS6+ra2rI2WjNk2OUYqWGme24rZdVZosRGKGGmIHqZQ19bhd0WphRrzD0v6W75/fdwV3o226Zn5K0zfZipnYWpFVTyqr0HpTqz4fDS/IXmkXLzHDU6L37dlo+8rGuSpnoWgmCYedMc3zaKFNHTrg+hSJluebyM1a0pRVE3m+3oq6HNPxjr1vxKVt+uC9AAH+TsDXo95o/48pTXCpsPZ7yWabJOF5gi26+6HGfIdVZC4bxZpGc4UaE5d9WqA2KFE+NgJik/nXQd2/hTzjLSxI2eySeUqXjagOuDj1U3xmBuOVgYq/8GKdtqEv5md0AIZ1bxHKNbFymRLlVejClqvFYdd2NUJPF9efM4fOIsDShE8/VA/0vmsqk+IZr2xCvDws/IYpDYfR/7rVsE+ZuOFZZkabujJHZtK1hr79uRNZemX73Rbxgr3098YR8GNK3MDX6lF3hsSo2RzEI84FvCQtw59Upz5uCjNoumn1pLEMWP0LVprvuDGFqmlB4oDW70Z/PaN0WxWYnLyh7z3a2xJAhoKB9rMdSjOFy/1Eyv2k7nZQ7SVHD24xVB3pTmZLxrlWpQrq8ZTJhgbNU21IA75O/bbZbDqGaQxy2gm+eEAj8WeNO72B2EKTnBievzkn/ZHDSVO8tZbmmqF26ngaeNVEJknlUfIDXgsFqKpEn9XpF/cg6y43ob4QWLLxbFkFHgyB0WD6VZKNxYdDozNwpe2SjibzigYAVWp76S633ai5JXKvuXhqEJEs2u1SNG9k+7oTb7o42TN0m8A+T7TNqYzE6wjK4XPwLNYAOvYu+/E2fXsE4+m4Y+RHomZFr0nFv1Y6DmRIYL63+eTLVW1Pc/tQvD8lVsqDKYZav8wVfIvBbbteNZQ7IksjXE8qn9XGbunMvo+H5K59eaJZlHeoMNK+dcTW1cf7NV31uCiU6GSZDCdOKlhGi7NZb1l21JVEXh
 bR6NrhrCnb/EqQM7+UvnYjr2gWBVxIUdYZglxjWYYe6ZONAAHc2v1KxpIZVX6pRBFIXVoqxmhq98/vcQuxoYidmkmHbrX1MXV127VIkYWJi3nyuvyYDQKQCgRcaYzD2v0EiCQeZtdgw1Ddvmhia6+ZJHzQaSGSAsizN7l5g8kHbgBYm/5F0tF+LHYu32maSC5UqxQN9T6PPPqVIZ1j4zm3CDVJs96vjzqG6PtZh6vrgTNW3HBYqtW4MSHiyQvhSzb/5dzqEYCz3+cMTBDjxswKhTo6d87IAJaeus6YI+RAmn2sNAnLNwNUSWR97Gh4rwJEJtQ/eJMNLQEVHYB9kyGz1PNPdgS3w+hytJYLQg2g6QKsRRlHHe1q4CKXbheED0hTeuyapO5INLofCFmyjQIEFW6a3qb34p0Hs3JHEvFjG7u0sEnv7iqOgfr/vsyjL5uflodoffVwdrB/gsX6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z4xS5blTC+HvP10+A21fTMwB3sMfrnfm5zxasDS3WiXA1Tuy2ucAHftunIAHpnOsAtypMPveE2fhNvSdyrKoiIf/hGj0Jc5SSddxjRmdoM/BlfrJXYivDBsNTK1kOkQzIrmAQgtEGGYUg5jBGwQL1WioBgYE4b7Us4hDdqKGhyE2Jhn0kApzZO1nOYcR6YwN43rjwpydjrJAA2MRVG9MIOczZfavIQjhgkG5OssWmVLGZWgnMhliXQqYy/spVGENopnt87TOJCO69eNOLdNHiyiZLTDREiDK0yAuSMgriPYRMJm+IxkM/7ffj0SQCSWkSGHLu3xSt1E4xU9kP26MUzcsx9PtAQiX1NDfSdZDc4U8lBHv5yFDkFVldJU8JhELjcSZTEtSTyEFatIQk6L4t8xyPEvBw31qcsfaLw4pT2l4/AHly86abdPU4kT1KQKDgvHO1KLm0F9ame0HvrnEX1PWilnmeLjQnvc3KI9NPoGlDgdWCZvoL1yjnaUIXiS9J5sWt4rm6hTFtnp5S7Z9kLGTP5IUSRJKj1XwDaEepRdmNEarwdtOEpmgk8FaixG0FfleljlldlgWE3gB252O10g4ZxAOhrtvnw1rc4xEHIdGm6kLP97V5DaMBcbFpOwcjVEc9jDCuLBRaTtbfpQmZcKIgLECuHuPiVpjiu1//T6Dre1iL6vsl3wWKvFUEiRobX9ztNqevAqVGQksoAepkiL6CpF+u9lVqn0wJagUjQUUrjkvRZmedhTcQ3u+QAPeHWy+i0EB7MjZ6vlxoGb8iZPsp4YYkcdDhPWI/Y1gpn0dq8QRzedtj54AI6AJbkkFFrMwHQws2iwhS2UixMS8KiMQHmZ/FmQWSQRauC7qaNHYNLcBUtyZFkKkg3bo0n0rSJbeZimfny02tl+LghiRDO/e4wVAVY/yTvdRWxJ0QxlmdiaaFCXKKmJXlEjJq7bY
 31krcn22EZW/pU7FUqRYRF/QqVrTYDFziX87mn6vRL04DllZUU8vZrW3zwTl2U6Nahonm6gOkMlZL0KKrFCsD9ndYnAtJivz9ybSggGpUyI5j3aSsa0FNYi3qaOqi60J6Fd8gmV0hs3hq1x8URqds6ZcAxmHM0r0GvueErIQQoME1QwmZ2grhIJgyb4ur7P3iN67DQ59d9L5dSu7tTwDo32VVkuAI22ok3iRPFSS/3XL6WC6ICLsXu77aLb66foLR11Cg/b3diR6gHzIu1FWpwmmggSJJQuPJgK3pijT/QOeO5ktXSXrFIPTsQ2dbCipxbPZ7+uqJ8VD8ut50uh1tGZDrI/vY2gfcT9piHeyNooa2vPwJzMB9J6i0uttH7c/TscPqmD2x4K+M0N0nXeBGLVSDzNoUW1lWU3xii6VidSW0L40ZWo+/Wr8VFRjxtYCzL1ugP5x81QDzeoku50b15QxU54Z1e8u4rxl8df5LPOyq6flg/xzrCc+H8BG/K0DHtMxMXOR+iXAMjhi8GDhCSR8aTBSAZ4NyJ4EtG9RH822BIH6BldkK6gRzGyeXykCxVW0vrSp6fdFnFpTqNhEV5KUstZClust/XZdyOCvAYQTAD8z19tN+CZmBzLkEv8807sWIA9K2sgQnzlcrmS7Yg==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831e1507-a312-4e93-ee79-08dcdc927983
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 12:14:44.2996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/AZSCweF5We3ScrTFTDBNk7Nn7HkwmNLCmIV9oOBXVop7ucEzlF6+bjJVb5ZYkhGRwkFbB1MQ0aoshdIKo8sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2391
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Various architectures have almost the same implementations for
__memcpy_{to,from}io and __memset_io functions. So, consolidate them
into the existing lib/iomap_copy.c.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v5:
- Add function prototypes to asm-generic/io.h
- Instead of having yet another file, we add the functions to
  iomap_copy.c as proposed by Arndt
---
 include/asm-generic/io.h |  12 +++++
 lib/iomap_copy.c         | 107 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 80de699bf6af..9b8e0449da28 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -102,6 +102,18 @@ static inline void log_post_read_mmio(u64 val, u8 width, const volatile void __i
 
 #endif /* CONFIG_TRACE_MMIO_ACCESS */
 
+#ifndef __memcpy_fromio
+void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count);
+#endif
+
+#ifndef __memcpy_toio
+void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count);
+#endif
+
+#ifndef __memset_io
+void __memset_io(volatile void __iomem *dst, int c, size_t count);
+#endif
+
 /*
  * __raw_{read,write}{b,w,l,q}() access memory in native endianness.
  *
diff --git a/lib/iomap_copy.c b/lib/iomap_copy.c
index 2fd5712fb7c0..fabcc1e95668 100644
--- a/lib/iomap_copy.c
+++ b/lib/iomap_copy.c
@@ -3,9 +3,14 @@
  * Copyright 2006 PathScale, Inc.  All Rights Reserved.
  */
 
+#include <asm/unaligned.h>
+
 #include <linux/export.h>
+#include <linux/types.h>
 #include <linux/io.h>
 
+#define NATIVE_STORE_SIZE	(BITS_PER_LONG/8)
+
 /**
  * __iowrite32_copy - copy data to MMIO space, in 32-bit units
  * @to: destination, in MMIO space (must be 32-bit aligned)
@@ -76,3 +81,105 @@ void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
 }
 EXPORT_SYMBOL_GPL(__iowrite64_copy);
 #endif
+
+
+#ifndef __memcpy_fromio
+void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
+{
+	while (count && !IS_ALIGNED((unsigned long)from, NATIVE_STORE_SIZE)) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= NATIVE_STORE_SIZE) {
+#ifdef CONFIG_64BIT
+			put_unaligned(__raw_readq(from), (uintptr_t *)to);
+#else
+			put_unaligned(__raw_readl(from), (uintptr_t *)to);
+#endif
+
+		from += NATIVE_STORE_SIZE;
+		to += NATIVE_STORE_SIZE;
+		count -= NATIVE_STORE_SIZE;
+	}
+
+	while (count) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memcpy_fromio);
+#endif
+
+#ifndef __memcpy_toio
+void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
+{
+	while (count && !IS_ALIGNED((unsigned long)to, NATIVE_STORE_SIZE)) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= NATIVE_STORE_SIZE) {
+#ifdef CONFIG_64BIT
+			__raw_writeq(get_unaligned((uintptr_t *)from), to);
+#else
+			__raw_writel(get_unaligned((uintptr_t *)from), to);
+#endif
+
+		from += NATIVE_STORE_SIZE;
+		to += NATIVE_STORE_SIZE;
+		count -= NATIVE_STORE_SIZE;
+	}
+
+	while (count) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memcpy_toio);
+#endif
+
+#ifndef __memset_io
+void __memset_io(volatile void __iomem *dst, int c, size_t count)
+{
+	uintptr_t qc = (u8)c;
+
+	qc |= qc << 8;
+	qc |= qc << 16;
+
+	if (IS_ENABLED(CONFIG_64BIT))
+		qc |= qc << 32;
+
+	while (count && !IS_ALIGNED((unsigned long)dst, NATIVE_STORE_SIZE)) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+
+	while (count >= NATIVE_STORE_SIZE) {
+#ifdef CONFIG_64BIT
+			__raw_writeq(qc, dst);
+#else
+			__raw_writel(qc, dst);
+#endif
+
+		dst += NATIVE_STORE_SIZE;
+		count -= NATIVE_STORE_SIZE;
+	}
+
+	while (count) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memset_io);
+#endif
-- 
2.34.1






