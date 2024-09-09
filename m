Return-Path: <linux-kernel+bounces-321486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B293C971B1A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7D1283592
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BE51B9B48;
	Mon,  9 Sep 2024 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="kEGstJQY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="cViN3yAy"
Received: from smtpout42.security-mail.net (smtpout42.security-mail.net [85.31.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457E11B4C4F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888746; cv=fail; b=ltToN/QUJTPNXYXsnz6H/X9pNML9mHqyFSYlsSeaUIJ3ZpAHRojqIkv+2/poUP9OcqbjCVmtfyuAEIvVn1+OxnilraqfLdfsDaehOxt+6+RqbJMd9hNS5TPdTPwPMauferehuG4OHhMQprrFvIGUJ/UoHfmNlgdF6vLk5ERUiNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888746; c=relaxed/simple;
	bh=xWgMObqrjkTD9YxOl5xlHQi1Bwef7/jeXXrsnrr8HWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k2/AXv6p8zZqlwm3SJdNdLaoArugZZExvh2G8+4VOPoi5LoLV0w52Y38SKxRo9feDZthc2tZC8KQ2a7GfEQXkmpm7w20va14/W8G4tp48cwlM8h39L9CZUe0CRMxWUNssHxFAZP9ixVcZKWoqls94gthTX++fWWE9cX2TEM78uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=kEGstJQY; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=cViN3yAy reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx302.security-mail.net (Postfix) with ESMTP id 1219CBFE6D
	for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 15:32:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1725888736;
	bh=xWgMObqrjkTD9YxOl5xlHQi1Bwef7/jeXXrsnrr8HWg=;
	h=From:To:Cc:Subject:Date;
	b=kEGstJQYTZZI/BJ6uaZwluYygCOUQ41MWcTMT9AOIGSscjHa67HRCHYNLt3b0iZH3
	 Sa3faF/G6hJeJMKQot5Pbo25n9PIusjEUr8Ra7U1dy2eb+WtouEmdEfFOSP59l4Eaz
	 vKt0Yd74BEgEdejNMxiBbG9SxgUW1eSui1dEnR8k=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id C41A4BFECF; Mon, 09 Sep 2024 15:32:15 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012051.outbound.protection.outlook.com
 [40.93.76.51]) by fx302.security-mail.net (Postfix) with ESMTPS id
 30350BF7CC; Mon, 09 Sep 2024 15:32:14 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2580.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 13:32:12 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 13:32:11 +0000
X-Secumail-id: <bde6.66def8de.2f1c6.1>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgLjDJzpq4u1Ub907w07NscrwUINNykmzzpHrsLkAg3i9cHO19IixIKuHUgwpnqkK7QNpoHaTF4W/DChTYz6hyek9HVZyQs2zTEahg85dD9V7EyQgBgIcEmJa5n1VoQhVapTl37MM1MCTOKIru9UlslVMdCufNNmQYEsyxiQwUH9jdrc4zImdMyT6QMW4UzbnzS+wGquO2Vm36ojBxRTo+KYyufA9FIHwGOZTgp/vShpWbrPZsQc1zOns66bFF22w9hi/xcs1iSa0q/flYnu97TA6b6m2hQSHDknMMBHu4vDf2pk4nDgh4DKGH5NWrUsr7dwlXf1UKmrEqW1yj1s9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSz+b4HEG8Mlm6Ys8z+Vo2Swu87k+bkYlFDwl21bWHQ=;
 b=TYe8CoGONvufU64hNCIS0NjlLnuJI2P+MQgXoyWqQLAp8ONp4VQhckgypK4SRbzQxsGnZwA+e9gisJ42hqmRE/IrpyVIEtlex7na9cw1Z9wYwfsRbxYjuNL/Ot+KHVFMDeEKYohxxz/K8HmFJjJ3p4agK+aZANrgO3D7YCaZAdpV31wsidMCgP30tLSDWjOQNrq9kZqprUHAjakQU9Rili3rHjmExEqRPSuhnkQW/4zFUkEcfcks9nNWfMGyugUTRXyTxrYEAT2jRbfx3ImahAQdzHQclfwflejkIwkmxej4i3f+H2d8tTt+f3hDFh7IMjePgjn+HFB3+U71JaNFtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSz+b4HEG8Mlm6Ys8z+Vo2Swu87k+bkYlFDwl21bWHQ=;
 b=cViN3yAy8yQqs4iUMiNCxwWadF0b5YEETdxo8qB31vNTZp/W4TZ+lutH5p/pQ671qWud8Yx4srMz7WQYnDWaMVL1aN8OKcX1+cWWNhLVWr/jF5Xs6QqjZ2x/RdmwQCub+5dgvRn/OSvOJV3mcb+pWoB+Hq28mkuicSgi1K8fgsa5BZ8zg/Y2AwrAarwWzNmtXGuy9EB8mofMvLZgu7CUAipkQkZmQ7CedGkL8NziORB0MgXw05QY/pM6W58oKRK/r49tc2rRfF/3kTK2YpHZ/b/0tEek6zeB68mVdmvSkMFd5gA8YUt9iE2y22VBhOnw+y4ZvROB/XtigVJ4TQ2y+w==
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
Subject: [PATCH v2 0/4] Consolidate IO memcpy functions
Date: Mon,  9 Sep 2024 15:31:55 +0200
Message-ID: <20240909133159.2024688-1-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: a7915e7e-0107-406b-83d7-08dcd0d3cf86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: J0hg5uKHJDcM179kn375cJ8zwI4Jd6XmGwLv52Q6O/U6JP00Ee2nVHIhTHjcsRybn+MSCY1nkkERE1FSRa/RzpzqQ7g9svJp96feSyFQSwhlkC6v+Xu81lQGenpVwRw5UpSwuIkueW7H23lzBMc8z6Q+ZnUSIgEzulVQ50MqnulUiR0h3ZeDIWO2v1oJaw5ymJvzpJjEJ1Z+qgS4K/rV8EOSUn7JData+VtYpMUqLUIisn9JeV4wTheM7bE977eLNxROAyfnGqFk/G0fLgqD3K7OPuADg+F3V09RZVlaGUeUkZ/CXMUE5HkX1CyPP3PQZvAHItdAQTgnzp7u0lTtITUpGZmqsCuSc/RN7OOd0ginWSVIAA3mjYn9wjjRqKelTolD7A+Blt1c4nkEB6KaAo0oNm/K+Uyex7Eoc0TSgPExKB0iNutTciiEqsSdHXAoUbKrqoTmjEa/6AdCPw5q+9iXMnicskhBQELosU/7mt+JgP2JezzGIL2e7ohUsocBhQNPbLe/MV/SG8eaVJdG+AYzzrT4hvALJDjCdUuHWBbZodGkparIthitDJk1gVGntINT2zhdUFJYkxZJ6cwNwJWPKU0EsQIDjSOKwufnSho718iealeWcCq7hcyiblteeDCVC+2D9dK/iDrgOiuHBxDHUWfR395i5213wqdD9D4hKmLCUOZUzCT4HQNwKDSP+L0M5bpH0j9n0SgG+mgB4gnoJ7sK4dCy5VQ2qP75kTPagdDabeZHhLlBi8fapFfp3z2ZNf4+qiTSnizNfm3VQjIT0oQ2XTC0pDTp0Y3KPF6ojh0IAboI4r541JeatpHSLFnssnrDsKH5o6UEJbGtK3YxABvMTgtTsZUP5ZPf6RVeXpTvJaFj7jG7BOLAQwcLojKThuWojut8D7+KC6BrxyG7MTD5lNhDJYgmaxhgAfdL4CQ+VJWIAizwo0SbIi/6PZy
 z9pE5azGBd5DfTNjjZE5ixkhhXRIRPkcLtEAF8zLnLHhwSzEX/z1m77+B1V+D9h8SRGNFyAQmAUXUVX/9Ky6oDq2jMqZaeZMhvx20TUsNeOOAxScc8n0dJMINOCAI7ryExyLoCm+UinoyQuBb7QM/udxPOdQp4dx3vdavwBp5udrvmQUwxRISQQL015T6lrD2aWja+j42tgGhdBkQX5PJO3eGRlMHr6ArqZEqb+FxVA9bbJ/H94T5EPgY3akpX7gzULfk+KGJa5S2UE+ArSuYZMQ3tVexOcU3VPoGsZx1G7KnEKmZC66QerEiHMX4D7UkSHBnHTN1I3e6eCx4YFV1HvBPS4HiEnFCA8YWWpVTwJ4dVZgPup1JiM0QS/PiyKvHwv20CaqKe7T4zLTvEX6QJNsdd4stUgBNjZ0jSKwVXjdUjqPUglRx4J3VZSgc+IHkYYGxdkJ+Tj0mpqlEXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mvi7xupC6Xedx5cqH2xSME7s/y02nNI0nL0j+91Ycfrq49zyeKPLi0AjWaJGPRaCc80s/gwegLR3KzE4oV9f1YYlNGaJnVwB+yL9IoeLaETH34rc74Jfkpgqm1+iyC1X5m+Q/AJwxLqUvYLPLbxevTtdSkZ9C69Io5fu2AWIy52TrfHnT7ezQmjRTKk4ldPQwpGfPK35TJ8ew/NAMcz8ynrkIErGpPoLkkjqhJWvUpuCqloAClZRsggCmDr98gkCblgXUx94WBFEKTwJEvuHYdfqy4gzyC3k1b4WdBQoDFkL4Gu5eHajKuv8ikuKJGKpoZDo0hAzkDA9cIcMtPEw1O6Cx8q5OFEJWzjmBtgqnVob57sSNSETJ4+FbaEUSSqKgRNO2opu05iIrUss/wx6L+MdXfyMNlNUreUrzLIrFW+FTNNiRqgD6RszGi7HnacW8kwzedwYs+Z+XmldHqmJ0152J3u672thgC60mefhBBki5YQdq0e86puSz0xeJMiXxfzyi3Ow5JmvqdboP76CrL6ZJ2I5gYTD0y9Vm+6HCL5Oy1pER3kPCuMIHc4WILWGgf/DYkq4SFGjefQmKYS1NNN3qeJAl/jnTlEdb+HYQHBLOvCTFySGhlD5J8cqCEE3Ph8ywACeApuQMgb/sSGzewB2FfK4CwLhm4mO24vIQHLWlAnKogp0xQklPBWbCcsdiALmZ/rR/XEsLr1S/dQ4Mm2MWhXtQ0O4nt3BJYcy0hu3LrvWqscJKxC5+NtyfF5VA1I/6rFkVIOP/kN1RJussS3tgp9PwQ1c8SSD1UjtbzeADZ9Mi1TVHlsDQW6wGDB0Z/wnImz+PLMhY9Ajj12goayz04I/7v07e+sFNnBhx9VGaRfIYWa79jBVapn/z1O5ERsLRzVL13PJco2ByR663NAU3s3OAEWQCIdDnd8BLoJEufZn7nykij0F206UHKcT
 YXF9BakB7s+T4gqVMQJnhZEYc+tiYhzUkURk62Gi99NctM4DfdZP/KSMM2gO422x2SmD+8YGJPrlnB0L87uSWUpymqLtjXusbmYPIMdWna2nMeEA7H1/PhB2YbwikG74aVLMEs3b8T1kmVpCZ17naUSGiHNjfr1j/1duhzYsvkKakuqbAPbr6ncxj3LUiJMNeQX9ZADJcqyMsTUnY9fi74KtUsfQT4xhUH9frk3L3RYQjzBu/nuG++TdkNTIGtS1uxcHNJAkUf+T/oWyvtg45Ql2NfejCbFFEv2jZJy/8kTZk9ewWn1XW6+9JfNkWse7xVRuQnn9jMFqsBNFFXu7rZAmwq1NBRJ+ls1yyhLreQFpa3xjIdKjoyB/Mx5ZwZwxhJYlbRM6CExKJt2klYosBYJzKQ4TvVPMMjzRDmhnvVsPzsJAD+vkK/tsKb11OCYsxl7328Hx8mBLaQKiLd9RfPWD4v32dhlJUT/QurBmw9YXIFjnqX8zOlLcg4ANh9CI2hOy1sPZoqM3m14vUZG2t5yPtvTZX2QQQkUe2fB3ew8kgfWfUg6DRiFvC9vHRHOFfLEF0nRi+G0tngQaiveXaWCptV1o380z2FYZIKrsJFvhiT/r/Bu2jZEh5777196b
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7915e7e-0107-406b-83d7-08dcd0d3cf86
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 13:32:11.9350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHlRDdWRMFOelnautyCU2StIsI1jFtZJbaOvlmW6yHa6UbRzct/5iG4dKUpdkiBZrdNpNQRkR/H9P4J0iLXAZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2580
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Thank you for your feedback Arnd. In regards to the filename, etc. I
went with the first route and created a new file called io_copy.c.
Although, I'm not sure if it's a good idea to create yet another file
that serves a limited purpose. But I'm a bit afraid to add the
functions to iomap_copy.c because there is no common consus in the
architecture code about memcpy_{from,to}io. Some specify it with
_memcpy_xx, some directly with memcpy_xx, and another bunch uses
__memcpy_xx. So, if we want to merge it with iomap_copy.c, I would need
to export the __memcpy_xx symbols for all architectures that don't want
to use the "generic" memcpy_xx functions for now or rename their given
implementation to __memcpy_xx, right? But if you think it's better to
merge the two, I will have another look and modify the code for all
remaining architectures as well.

Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>

---
Changes for v2:
- Renamed io.c -> io_copy.c
- Updated flag to 'GENERIC_IO_COPY'
- Replaced pointer dereferences by 'put_unaligned()'/'get_unaligned()'
- Replaced '#ifdef CONFIG_64BIT' by 'if(IS_ENABLED(CONFIG_64BIT))'
- Removed '__raw_{read,write}_native' and replaced by
  'if(IS_ENABLED(CONFIG_64BIT))' -> '__raw_write{l,q}'
---
Julian Vetter (4):
  Consolidate __memcpy_{to,from}io and __memset_io into a single lib
  Use generic io memcpy functions on the arm64 architecture
  Use generic io memcpy functions on the csky architecture
  Use generic io memcpy functions on the loongarch architecture

 arch/arm64/Kconfig             |   1 +
 arch/arm64/kernel/io.c         |  87 ---------------------------
 arch/csky/Kconfig              |   1 +
 arch/csky/kernel/Makefile      |   2 +-
 arch/csky/kernel/io.c          |  91 ----------------------------
 arch/loongarch/Kconfig         |   1 +
 arch/loongarch/kernel/Makefile |   2 +-
 arch/loongarch/kernel/io.c     |  94 -----------------------------
 lib/Kconfig                    |   3 +
 lib/Makefile                   |   1 +
 lib/io_copy.c                  | 107 +++++++++++++++++++++++++++++++++
 11 files changed, 116 insertions(+), 274 deletions(-)
 delete mode 100644 arch/csky/kernel/io.c
 delete mode 100644 arch/loongarch/kernel/io.c
 create mode 100644 lib/io_copy.c

-- 
2.34.1






