Return-Path: <linux-kernel+bounces-318802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 956EA96F38F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04579B24EC2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74821CC147;
	Fri,  6 Sep 2024 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="gmN8Uhst";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="hC1gjkAQ"
Received: from smtpout144.security-mail.net (smtpout146.security-mail.net [85.31.212.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004F51CBE8C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.146
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623406; cv=fail; b=CwdxSXWfAISadZo+aQaim3wSSiAbApyVe/bEUinvJ4RtrgeIK8O9qqEfBtzbk+oe8LSKq3eBJgnB+6VYxS55nESiuNLEG89PcnK6cVnZItx/eGFnlDMIC2zbtMcplpNk+cFwS7jwSuingxeY60I739HxrdQMjBccyQBffZI0Edo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623406; c=relaxed/simple;
	bh=jQeIwSeV9x5cNLkMOCKbfvh2gAzZ0rXmkbBIP4/OHZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KwY4ZsqISAKXtg+yW5NpE7PFsPlOrVVi4OnxtcXmORmIWcjL1usKmIqvcfehY/ByEzTgFHQGL8emVNmtvSDFVMaKsmBdQZg6bDRNwYopXNL/BMPw513JhQcLTLBELpWR+2UxjZLii8s6exRBl/i31cPEk9Y79OZzGiHOfH7u4zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=gmN8Uhst; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=hC1gjkAQ reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx601.security-mail.net [127.0.0.1])
	by fx601.security-mail.net (Postfix) with ESMTP id 276EA349824
	for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 13:47:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1725623245;
	bh=jQeIwSeV9x5cNLkMOCKbfvh2gAzZ0rXmkbBIP4/OHZs=;
	h=From:To:Cc:Subject:Date;
	b=gmN8UhstvLsnS9m6obVAhFjBDNxB+zpKCx7ydSyygbW3N6fEzf8EH19p49KXcTaoQ
	 zky/krWF/AnkrYj26DBw+gQEEWtMUeMcntL5Hr+biE278emke/z/czA39DP1rAPbKS
	 FRolSjpG9zOrG2Bt03zyryPwvhy8yFOASNJfQ+yo=
Received: from fx601 (fx601.security-mail.net [127.0.0.1]) by
 fx601.security-mail.net (Postfix) with ESMTP id 9F2B53497E1; Fri, 06 Sep
 2024 13:47:24 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011024.outbound.protection.outlook.com
 [40.93.76.24]) by fx601.security-mail.net (Postfix) with ESMTPS id
 DF7953497BF; Fri, 06 Sep 2024 13:47:23 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PR0P264MB3466.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26; Fri, 6 Sep
 2024 11:47:22 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 11:47:22 +0000
X-Secumail-id: <5434.66daebcb.dd4a8.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfOB1Qn50tmh0wKyHby8mRDcSdtBkXwvgOcqqDteXwQku+vwAsPrnGLqDhiTEMTNLBcd++Jamo0UQiOEmRvmR6pGGmjOx+G+2QNhF4/yF8fibZj/IkMOEVtWZCNIfgaN/RD+O6ZQyiFAfoUQ0Y7HALPrN1DoilRRzegKufl94LSi04tb2kL6a9X/tQpXCivG1QYe7+BhyUkTDWXG4kqIGOT4oZ88fewXdsh/z7bW79MUpCLglFHUBjBQk8jI9loOCWGHwI/FimVoO3pV2wu59Qw2W1jaISo/4fvgwBg/taFuhm2oPPIaJ35JQzWKRD5YMIPbIwIr+OskXpoE0l+kOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiAnJIoHpbJxj5la1hMTIQmk3Srj/8Pr4XZVaZQhkpo=;
 b=i4qEJUQRmW/KEH0TlOZdgDFAnwiSD35Rib0/R1WjYtWn8lK76AmQfo4hOSprxLwqz6ZyEbeVA1q0FIg3AYFdQpCu0FC6g7Ib8INTAVKzGflnPXhqbuIfIzYX+rmC+NRggJYHcB7Rl6uTkeGNHihq5lMGZs25LCEnvosSn9T16r0bN5SBZKKgLhLvc3yWH9FDaasuY199MQfTx721bT2LuDQXfRu1WQK7CkJCkVtEsx3939UBVSu5THqhJK+NRpw0UPHiNp+79m65h1WAR0/g7F/9U+F0wxErGfgWOBacplmqg8OyzdV8G7vvpAaDjhjUl/YybLz4Hmclq03Bu1ildQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiAnJIoHpbJxj5la1hMTIQmk3Srj/8Pr4XZVaZQhkpo=;
 b=hC1gjkAQ+yspNCizMHr1Xq/LGLySeTggjqzTej+o40u+ooXjsQ6CgqCVAGoc1aQsIWXSsWCgyn+BP3sRdWJtKYxRhPFceWnqMXwWKWFzMQwPJwfr1OoG04q7UH+BbKFlLelXmsr3SWyoAweaaOpVxbIXkRfMl1nWe2ySHJVQt3svPuylgVmHwiMGXOq/ju0sZEbAhuk1Mr+tdUkp8eI0edb+rTHWiDcGFFzNOPq8+hah5o9/xNUqJfEQh9CC2TUQ5j1VZ73/9aokrFYCzNTJ/RC+k5Sma4qoIeIRgDcVQ22zyyCZu8HAAMs6yksSJ43jJNxdCpaSHMceiO7wDkeqWA==
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
Subject: [PATCH 0/4] Consolidate IO memcpy functions
Date: Fri,  6 Sep 2024 13:41:47 +0200
Message-ID: <20240906114151.519028-1-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0021.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::34) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PR0P264MB3466:EE_
X-MS-Office365-Filtering-Correlation-Id: 3afe11b6-8068-4afa-5312-08dcce69aba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: NwmKa8CfwphrOkxMicqezozWgDxeevxNxwSPIbK8JdzErPooHv9EJGkt9MdBr9ugpGtU4bBMOmtw553O9ZvS9ClAmHNzJd/wPFEv0eN/G6obuBmnn7WnBYGGytq2dkci0xWxVFmgX7caq5DXQS/eL9V9BG85ZuhmotDumHha2NM1SgvWB8JwLD3gDzRrvdJLc1JCdJknuBzmrt3VXvuugeXucW5jiSDDv28muw0cWN6EzRKYVpFIi8wYo98LKq/eKdM+aWxVpjxWCEDElZji/5nBWkLgNXjIcLeHvMOKd1TuJimTIu+LU19dIn7DA46GpJRXCWYx7rfHFVy+I6zLr2QqQ2C6GkZotkVExHKwwJwLo/R5+LaUqQhoeuOCUr52X4C6yYmCL7GeoqJKeOLzMb2NVo4Ox4hF8qqyXpfaqCv0UnOm5n6piflAceQYiCyHdxOEM0yLm2lrg1ND/OAfDMSNKMAB/KWeSD6XrxUXHXFtoQAa+woK1m9QoDEXMkdY67p69qkU4u6hny0YZzvfnLkjsF/9BMnHX15hKtJSIan+8cBzxr0W6EvTqa/6BMCHbk5qFUFsk8H8D6R5YYiGIaCSi+70vFCHQY6agilSGbDO6zaGumkPmqUFZog/zEzvTD/arEXwEJBlS7uWz4j0mk4UlxMliZEQ+m3pJiwVlG2L0NUf3C2PTebp7fkyE+rEclFJqBTLP8d+T6TU+JP4hnpUkgXDrVeQaeCHJd2Tqdjxdfcu/r6P2kGfhKkXIHL29LGqcmpqRDEEOfzOgNVv0bveOogYZhZH8sIUIOC+BW0MAGXHP/YuqJJ/oCYTJcnBGMdVxHRB7dAkxFlsHK/gPjaW4FQJux9EWKQ3xkl5EFzteM700zZfFHziA2Q/axSudLMkJxSZbCZPpqzFzW8k0NaIpXytyJnvoSBv/Qik89pXCU61nszNY38sdWlHWOWk97B
 4g228M75OLDBJZf0Fbj8fN/KDLRR+GKuH8znSWqFCPtdeoi2t7/jnqLEjT+sTMDFOTidZWllCp9uMv9c9kdjgndwAr8QDGJrS/y8ifwJ1k+5tchxFDu/5t5HjwfaZex4hc9VnruOkPV/k93cnClnMZBIui+dLL4dTAfFJKLqbbSHiNpYUkO/7uavLaS4010xDcDkbF5u+gRKsMOqyMDQ8sBbNTTsX0Xkw7G05XjzY8R6N72itibDMBUgqUUDuuNFBxQKTlogzYNmkm9KKfpvTnMKfWRYbAVDkiv3DtRk3YbAm+7JlV36BX9k3/QoUeWuXbCHvL/YgmGkb2RodR7v9sMvMaKFTfTItJMbBbUYU1ar6TjJmVuy/Ji3rwtzENM37oUU+rsOaUNgYn02hsC8TsLujE9EgcDasf6lJXzb7f2d2eTfISZePjEbMnQlPE8lyUt6h5h7RNL/9GQVpjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EEYvN/b/Cpp/Drow8JeRP1aQYJ7xkPXJF+SMj3Q3WQRiL7T8VnOdwyRzS/lajfWXxvQFpIT/4jRTZf+rD6MCtwJqmNgSgDr9ka/LLFYMIqbuVvgxRwdJOBp/LlIb/yLz/Uq33YAGwC0W1rZf3Q4xC21R0TWcPCKmywAOGsQeaiA5MSSKHf7ck82EiCcpi7Oi/OpEXkVFibC36ChRYltshbCWjBD6AhYjVrPWDRD2ID6CL/xgiyoTjjqYenhQ4iN/xwW3p1hWT09XjqgjlyK9E/CUuptDuNiovA0DmcSyIh3y7C5KnHZx20Y7Q7YexGW5uglO5pmjj9foq7C8Z5986vTvClktF0qBU7qPa0+oO+ToKSuZLqVxCeWVYCfmEq2LhpW5UXTOlCLB3ar5NZXinbUF4LiN/s43IeVtkdhWStsCNoL9Ys5ViFsQb2NMSdlJ273aul7ZaaRstKBe8+vCh81WkwY6ngdq0VwKPoaFGcimKmBvFqsZJmLgpUqR5c/IiOenPULM6hH03eNQ+ki5hUe4Bh2UepdaW/vFOxO9BHwxKsVxqeIZ43Shvtnljd8u9OrWHGzNlcGBAzLB1VXow5doSR2yqmqecHe6lxDkF/BSz8pD8dI3Itb9PfdFvmhurpkhmG0pYngyPcU7vTS8Cntdtp4ve0RVFU0667XiX8tLG8Q0Hj0sJBD5lIE8kVx4S0epSDXovDW2VFaHnVITlnkWEmkptoYzgj2nNTTBsgx02hLyMP1/qA72xMhXmrU/kz/EmLP/zGeWxXrUeZQiv7tMyju6pRQIXhGspXCnfeo+jNXQohUr/lEs1m+rJMXnt39tW2mprIsGoiJQvrQIlN0J2s7Fj+TQyCda2cMXOheS8h4P6NchObNVM4g6S5BvoR5eeBc8jlDmx3LQB88sOUXR+RWncAopZKb3Cdxcud2oO8jzo5kEnOENLFEqIKlJ
 +4GClKKf1PkJ5tZQifWynt9MsOIFKifGcdhI+JXWcs/c6Q5ZJ67UCVLC/6sJICFzKzMI32EG/urix3ERLZ3yvR3/CyOj0TDLi53zBApVGEReZ71COoeXxPXplCNQcbV//AYRG3RTBRDPN9ICxKd4L1EL2/51bd6j0S+cPc3RiiCjU9jHZftfrTfOaOf+DE5ae/iWJOIschrEMkqnR7QrC4hV3cuDLlqAGIQmjDQrJQ726/gnuz8B2zctQJw2ug084swGFQdVnKOxUeZvd1ENzA2Dh1+VVI5VYyJSm5Mgv33hw91tDJqHcW4MO6XB3Zdh0X3O1M3wupVZeIXyXwXbFxujZRpQo4LouDPDUTPgVTLQBWM3gG8wtlxeVvjwmgLTkMOkI5iBn61r5w6OKMqr0IXJ35c9UfdibBZ12+3oDdqNn2VXjd2vVY0s+Kk5vBRA6844BwRaAp0Q7jN7c9/D2n3BetyxL9V6vfI4xX/LpwEEEg+C/wNAnq3if+HDePd/q9ia4CPw85PmHQm7lwcKnGUDL/iScrTay4RZFegniQxc7+V/6xFHdW2bvhM/YRXw/+C2/KYGpQWxc1hegxPJTEHtj4GjhVGjR/3gh9ygCKE6whlpJx8QPf20TDg4/1n9ka2EA6uUQC9jQj4GFHlEPA==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afe11b6-8068-4afa-5312-08dcce69aba2
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 11:47:22.7749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PXTLuLTQE8wbEVxomkrrfPWQp+/COsl4hU0dfs8x14troLalGYU/dTv26sb41lYSzOZzqUC3fljrBqzx/5/SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3466
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Several architectures have almost the same implementation
for__memcpy_toio, __memcpy_fromio and memset_io. So, this patch series
consolidates them all into a single libs/io.c file.

Julian Vetter (4):
  Consolidate __memcpy_{to,from}io and __memset_io into a single lib
  Activate GENERIC_IO for the arm64 architecture
  Activate GENERIC_IO for the csky architecture
  Activate GENERIC_IO for the loongarch architecture

 arch/arm64/Kconfig             |   1 +
 arch/arm64/kernel/io.c         |  87 ----------------------------
 arch/csky/Kconfig              |   1 +
 arch/csky/kernel/Makefile      |   2 +-
 arch/csky/kernel/io.c          |  91 -----------------------------
 arch/loongarch/Kconfig         |   1 +
 arch/loongarch/kernel/Makefile |   2 +-
 arch/loongarch/kernel/io.c     |  94 ------------------------------
 lib/Kconfig                    |   3 +
 lib/Makefile                   |   2 +
 lib/io.c                       | 101 +++++++++++++++++++++++++++++++++
 11 files changed, 111 insertions(+), 274 deletions(-)
 delete mode 100644 arch/csky/kernel/io.c
 delete mode 100644 arch/loongarch/kernel/io.c
 create mode 100644 lib/io.c

-- 
2.34.1






