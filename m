Return-Path: <linux-kernel+bounces-323173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9279738EA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3CA1F25AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282B6192D83;
	Tue, 10 Sep 2024 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="kyh4Aprx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="NXwF8FGv"
Received: from smtpout147.security-mail.net (smtpout147.security-mail.net [85.31.212.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672AC18EFF8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.147
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725975846; cv=fail; b=OIR3WcM1RaB7hHvRSpTl+P78IZKLgv0UjCXoC+x8W5aJtLd8f/9zrr1mMsiXPRedo+jK8I4ei8FQoc7fHcwlB2OFlQqFoqdJm+jghIOV49c5+lNCpSCE7g1PCbYXWJO+RwRtPwyVqRUZe9p/4z8AkjuqLSSSO7in2fw9oNGdKBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725975846; c=relaxed/simple;
	bh=QbuGHasZdIbbP6NSaoNlc0C5jgIaNH3v9mke7hL4pTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Un5KHcI6NvKAfjtQoHt2ZRSPV/TGt/qDqLyo3RRxsHC8iHCMD1ctAKxQkr4ixxAokmpet8+a76Bw/+RHsh8zKiA9iNID7yXzHFonPtexU/2gH8/l8hp6U+MCjag9FPhX4rLqJGpinrE+36VDV6K2NzgdpsBle3PQAAAlYE+a9R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=kyh4Aprx; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=NXwF8FGv reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx409.security-mail.net [127.0.0.1])
	by fx409.security-mail.net (Postfix) with ESMTP id 09E0F349B9C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:43:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1725975836;
	bh=QbuGHasZdIbbP6NSaoNlc0C5jgIaNH3v9mke7hL4pTg=;
	h=From:To:Cc:Subject:Date;
	b=kyh4AprxWzkfdtngPFJn/ghJ+s9B9okd8b1O8E8uEAc8f5Rngosh2iWrRzCHAwgAw
	 sCZMOfxguQ+Kf6OAjLJ5s8LFFbQcb0Uokf2vEsbrSb0mWcf2B1hFEhxy0DvEKjqJTC
	 fv0BYyZjgq7TuU0NP7gpCIYXsvUAwSqEM1PkhItU=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id C1E1C349B85; Tue, 10 Sep
 2024 15:43:55 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012055.outbound.protection.outlook.com
 [40.93.76.55]) by fx409.security-mail.net (Postfix) with ESMTPS id
 310AB349B84; Tue, 10 Sep 2024 15:43:55 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PATP264MB5061.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 13:43:54 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7939.022; Tue, 10 Sep
 2024 13:43:54 +0000
X-Secumail-id: <150c6.66e04d1b.2f36c.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mj8FAeWnU9k4jwvel/e4YeeD5Lh29lWF47Vpyn09/niw83yj5X3zaVQHen0dtJm7M4Cl/cAuLqi6ek+l3TrmYznvNWH7lgBfxA5dXGe3GGygkPvGKv3PS/M1W0OJ8Bb1mqt6xSO3wHgBzq9uyxs5MKs8h3M6+ffQm4awh63R9rz5mZiHyr1Y/c49exhnYH9lv2TVIgVJSZ0851z+MeIqNehRha+HdMGtSVN0uS92Lq3mvCIMo3SCinb+VqzUuUXq4I3PG9Y68kVoDWrSSfCXEy5s/cZKrBS92WP1WVaLzNIfOHazIf3ldyOxqGw2LLa356ZW1xXPz5QEHCJI9Q57Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pONA1O0aphSw462BCOJlTWnTtN4oz/C/oPtTOkEurc0=;
 b=CJ8uTBwxthJe0LY/N5K45ZZD4ie2QoVnpqH38T9Ww+ssQkqPG+XEn3pfo3J0pKtK6yxGS8PI7UBAH4anFcI7H6ww+v8Bv2mCGKHDnNJqG8grZX2FU65f+jtj7fFzgzRufjApOefjOLGWAMfudbG3ubhRANHvu6luf1IUgF5ooKI0VE/XIFc3R0kxrjDwQ1LeRt+Ovf/V+7KF6W7eBYxcRuJ/gh57VnxKF80sELogsO+Xe/QbkSTMYkVSMej74tPJo89sUgYLbLM2Dtij2cIZSr2e8QyWi4AWQIPjkxTQ/neCIt3VUxIB9DS09QgMylG00//iRaME611Emtby1/hzdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pONA1O0aphSw462BCOJlTWnTtN4oz/C/oPtTOkEurc0=;
 b=NXwF8FGvzJW+xELgJEUsnezGUKw6zYOCLdgG0ExUXxNSCa/Zu1aUv5/iyKMkC/Bx2zC1QA7s8l7GlM1PUL952YoqVlCsyYluenV/KPghAJBOmWREXmbXn2jTG6MGTYyMjNsCU8Bn59lk6RP2dok7W/I7qTvKmFVDwY75azjM9ugwZHH5rjDpsJpIniqt4FdzvlMru1d6h4PyNRVEEgfVWOlfWfYHbe+hUjEMCKC1sfTO03x5N992BxBfZcNZODwr4dlABpV5tJ4KeFckH57CFjC+0eQX0rxGni6Pd0lj9xFRLGIjI959SgXZOMYLk+PX4HspQ8hrsYnIB88Fh4yQcA==
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
Subject: [PATCH v3 0/4] Consolidate IO memcpy functions
Date: Tue, 10 Sep 2024 15:43:37 +0200
Message-ID: <20240910134341.2537407-1-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0210.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d::16) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PATP264MB5061:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e0c066-d5a5-4396-cff5-08dcd19e9c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: wM20j03d4pk+0r1oT9VpX77ShSay+WXJ09HMs1s+XsVPeG6scU3KXbpSTuOi2xJ8sRoNxINWApEVrJV4Nm9GbnDNvPiynx03rW6fEtBdK30UewTRV5psOTl3xxe7gy3WkEv7r5Wr/InUgm1DbFvPGe46rb+xzaLvvObVHHHJkHZy20UFSfBgMGufo3+RLM/B5TyNTAm0GCoeB7ZKevZcn9L0MUTYtIfLTxU4kRnQ6WmeXqwWP+dXBHM6+UKVtnYRF1LsuWBBzia2wOowBVR8u0XcLCYuex7mbrbR/R+SwC0MC6/jjsgjq1wnDi4fd898U93OXS1bfbh9y97Oly50WWiV/uFR7ltwXfizMQMnCw3kMkJpsNOhXFuYpPwZeM0Ok412DY6GC5sx1Ige1iAOjtnCEQDkzHnN0g7Qclq1D4fPwmX47J0g62kAl3wfgMo/8JHT1pb2IAw9tQ4nQOFXQ1O5MwCXP0CHL6WI2cWt03JPoDQTbJtg7JH+FHfui3UvHiem98S5/gqvM5DSPI4wZ2OxGUCLR8sqUXAnOcgWMMH1WePYgQclh706eOjQeacziP/CRR2p+9canG8vlOc8vdvO28D2q1Yaa32IdJV1GhBKHZilNvWCgrrx7RKiQ2gJaFsQfmOQuQjVPt1+4dTT8O/ERefTFGNTvyK0fF0jtdyk+5CUw4tqjP0WLqqql4NcFmXuMM0OLWuvk8NNtE0wb9K+c+Qj25WHaxEjeIg7Vc/CKw89szsg3Gx6sZHY2wZrhLpnLJesBDrXR8yG9NHuJkrMaGVvnYUnwkPHqspc0eOF2txl21iL/hnMWLwSAbIyY9FoAG7Xi/bqv2RbEiDBL7hQKRlWQNXYUXfO++LLSmBq/4sbW/08jub+nQxuF3Cc1smaGjlssRj2oJwG/l92e3RHISEQqmlLHSXUyWHoGRo687SsA2FvMVAb1cIxbxx9AZw
 5Jh1bxU6Ppi775V8WDUIS6SJEXmx5oqTjV/H3Td1qvRa1vJqY9rLrZ4Fa09jABB7uhlgNa05VnHhBzNKpMFsF0ns75vRM9Mvc6SZ6P3D1z6dQEBq4L5kwgxaRZbBWHKYHvz9gwDk0Lbq0RWhF127Xo1haFPgYeH0JmvFtXJd0TlKBispuu9lcx24wptWtU9JdbY/1VRKscGhNBUooAVyYo4056SudCPL7bOnLAm1uYjoLMuOOjNuCPWZc1lD44BhM8Wi5QbG8kRGH1+OSHnwzter4ONPOBNb0R5d99PZdHmBGnfEqg2ONlfJ+DGTw1AsybaZDS2DIVt0XRnAguVzaY+zn+vDLE/+NIMrXepNMLTpwv3ylxW4TCbAMXNcr/qO70JkQDo2fsKYk/iCGPGa+SbPCoM5I5cO9zc0ROwXsNpnNWyUeOah2NlNghuB52kimrLGCxl6puwnwBtX0Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MZHGDGP4XzatCcRcJLQSpDIvI+YCY+d/N1q4BdiKW4CadcJU6krDT35pEVq4S1EGIH3MqKFi2cH8cf8mh/9VmDhpDyNANXWFJdrPwLCFRsNRYgqaHkocQaYrKZKM/iLKimKV+LLBn5pCZBJKlyZMOpnqjV5kcr8BNS7A+LhJtIZljsmsob/6GTYyFesJtRvV/1lghV3Sbm5yTCINas9zsGRxbM0NOtpeKWUg6SMWX37uVB3+hswy2IqFJHFs6H0ynKNQ+XDv51PIrwK6M/tpC5pVJFm5ZFVmcyoW9AjXMwOkaKMc2HFZnGPTxNS25Ow0QA5TOKdNDSnQiqcmfw5/9y16Tk635QPUvNNnMdBoeSNLmvWj8LMiZIO2dtJnfBqOdlj7bZjBgzDpjjwAlfV9EO4C6NBXaycQUKqnImZfSW8M0+A9zVlAfKm5XcdrmkqrcOOQuV6Fwf/Qkj9TxjkqDY91UNitLOYmdkWPsvRRmWZaWLo2pHHYjrEK5epX2TzoCdBHbnCpmzDPp4hsc1JQfJzG04pdf1cJxnnCIqJICJryppT2aapDRJp65BuKgmpa+SXTKT9em17M0VckP1+SuWZ21ka7/y4Q3TLzLgn6Xs2Vot8bZW6+lCPhQphEmXXbuB40r5KwZNpMUiLLd9zdIYPTvjLDrnIkLZBLSCc1hhybgR2vt0lfOFWwiShY8plMdNOK4R3+IU45cuB4evqeKkdCRKYxZJfNdby5PkFzMRgxSbRX2k7QQwuyzOL6Jr6xRy8HrOfAl/4eChy8pOqwt489NSN8aRsYHK9RTIeDtJwtl0TgGieF4MMHRzab2lSjQWJk0fwzHFcJ6yGw1tTSnbHf9dq2qpLQYebAOlv8ld0SkgOyECqnhNqqZjXvmxJ9hDT+UEr2FyOFAZBdtroXmH+DVf/oKhQF5yC9GGL50R8O8mxlXfivtWRgfzNhDvJ/
 IXUarnf0OHcrA7oL2Tmyw/lO+fypOS43R+7lBSMchSrogdRgRZNAindNEIQK3XWUkcfeXtLL6Kc4NQVz7dDOFXwjgJesfPfltJWzm6OEYLnJI6/084s0DckDQ2cv1v5ZDGNlI73aCC9p11QlvEMov5wKMYmg3p47rww6Dhkk/ehFq6InmkF0O2w+zu2RvljDRDbx8VdFkkYUtt+aexNx2AdbcosVh9Ec+7EcsFTu2Q/FTvAnb6oMbmqbtFygU8POdGqOhff0D8KQVazGni3zFBraLcB0ITcNoMIuf+4t4jL9YbmnOt7ZbUdVznk6RD9Kluxp5G7qoZb0YBuaEnEAj2v3lftTWkQhrNvRHrULlQ+ugd5P1mMLlcaDAqT302tzmIEQD4YjzFxiz8UW4UFCTH79i61qgZkrf01Y1lQm+FCGntWwtNgd5mf8d7oesRCc/Ro8JngOncPG5CJ0EsFKV9EFUapNM9nWKvrPbSNYgy824lWqtDkBO5CXJ9astNn4NFi9daab9BlnQJu30g3UOLWL4qVI9B2F13adOFh+JarFLmGyBqoYxAAzXRa42CqO0n7eT+MMy2WD7XGip4UX/aN2/Y+Mue/4+/MViRlZjofIz7ngqdwnCntuZXY9YC5R
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e0c066-d5a5-4396-cff5-08dcd19e9c6d
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 13:43:54.0544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GImycIt2CkJztirdS9L9HrAzFsVe7+TgHAKLwcu+nrHZWjEYDc5/0uT+a6z2VUalRZwY8PuNGQpI19XQg0Do/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB5061
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Fixed compilation problems on 32bit architectures.

Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>

---
Changes for v3:
- Replaced again 'if(IS_ENABLED(CONFIG_64BIT))' by '#ifdef CONFIG_64BIT'
  because on 32bit architectures (e.g., csky), __raw_{read,write}q are
  not defined. So, it leads to compilation errors
---
Julian Vetter (4):
  Consolidate __memcpy_{to,from}io and __memset_io into a single lib
  Use generic io memcpy functions on the arm64 architecture
  Use generic io memcpy functions on the csky architecture
  Use generic io memcpy functions on the loongarch architecture

 arch/arm64/Kconfig             |   1 +
 arch/arm64/kernel/io.c         |  87 --------------------------
 arch/csky/Kconfig              |   1 +
 arch/csky/kernel/Makefile      |   2 +-
 arch/csky/kernel/io.c          |  91 ---------------------------
 arch/loongarch/Kconfig         |   1 +
 arch/loongarch/kernel/Makefile |   2 +-
 arch/loongarch/kernel/io.c     |  94 ----------------------------
 lib/Kconfig                    |   3 +
 lib/Makefile                   |   1 +
 lib/io_copy.c                  | 110 +++++++++++++++++++++++++++++++++
 11 files changed, 119 insertions(+), 274 deletions(-)
 delete mode 100644 arch/csky/kernel/io.c
 delete mode 100644 arch/loongarch/kernel/io.c
 create mode 100644 lib/io_copy.c

-- 
2.34.1






