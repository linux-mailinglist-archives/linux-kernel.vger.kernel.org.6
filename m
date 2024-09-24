Return-Path: <linux-kernel+bounces-336881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08176984210
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B803A286C10
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4A115E5D3;
	Tue, 24 Sep 2024 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="LxmGRXYX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="WF+iLKSI"
Received: from smtpout143.security-mail.net (smtpout143.security-mail.net [85.31.212.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF5015574F
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169947; cv=fail; b=C0wuupb5XrVIKw1aGESlFMCW5aWv6mn3MTXkMevl8VBmXxpxenSHzMEUzg3IScCI5VoUTSA7AvU/JmjiThEwTxuiFzsfLf6IC8hpK+LuBZj8AsiVNpbzgSXh4zimC0ZXqg7ioebRR4DhnB1FZaLjHwoJv8f6zGGkNe3hDHwBQlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169947; c=relaxed/simple;
	bh=Sa6Z9JmPstN0uE49orm4pHgrd+JYXTZCci5kRiY18p0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LBtSmmqP3BwWJArOxai+1kfJXxEy2CQ7s/A/YpOtd9W/PtSVPmWfToDWfLL8OYNReNktCIUZRpd79QSyueb0rOOXuK6aTvf9zzSPvx5AIi3zNW5MrdLzoUFAhx+crXCQsy/DUarL4E1mPQ7WM4xH9i/rWOnkZUiVf1Gr2KiaxMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=LxmGRXYX; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=WF+iLKSI reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx403.security-mail.net (Postfix) with ESMTP id 346A98EAF31
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:23:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727169780;
	bh=Sa6Z9JmPstN0uE49orm4pHgrd+JYXTZCci5kRiY18p0=;
	h=From:To:Cc:Subject:Date;
	b=LxmGRXYXtdV2V8Eq3vGO0YDz61teav1lBDDSAw0ieFGRM36AZRhVVZ0DUpTe7z2kJ
	 2mwNf/ujdENcnIrZCkbLIobeLGufy77V1bB/wAmTweBHhz/mgB6gr1aXNAzZMJ/HTP
	 o8OquYPlmlZXOyK9An7eKIA4e81O2cctFjIBvY8A=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id B01158EB39C; Tue, 24 Sep 2024 11:22:59 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17010005.outbound.protection.outlook.com
 [40.93.76.5]) by fx403.security-mail.net (Postfix) with ESMTPS id
 B19A68EACB6; Tue, 24 Sep 2024 11:22:58 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB3073.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Tue, 24 Sep
 2024 09:22:57 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7982.022; Tue, 24 Sep
 2024 09:22:57 +0000
X-Secumail-id: <4fca.66f284f2.aebed.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hE4tZ6dGQk7R0NGCDVv/o3gW3+z4DNm04c2Z7ulTUX06BuSO53yyar4t6JqFaV+L5Z3fwRKdY/lje2mrbiAisOx6RAdssB2S10VNh7Fvf+s5usUe4LJLR10+5viZl0Qo/X4IZmrDjHHaK7Y3LA7vUpqwJx7lDRXaLoQdPlcIbedlDTsT0MJKhBWHaIjNE/q0lT7pjdD3v14jYsQAJegZWnRIhXZ7rL6Ut96PUKjsbZH3DZQ7TDjwUUFJnTMQWLIPnoFUyaj2NSGJSgSNg1Q5V4tesZXV0O7tf8uIUzdZpsqVlujGDV+9Ickg49rZQMiJcfNscFzGXMgTEQ/bq5lG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=si6Vj4qUg6X0mSSRLN+6z+Qu/oIHq66tRZ3JiDKOS1c=;
 b=jaVqHpBH3R1libBDU9LcQRliQREoOzTTD/akYjEk3wbaOrFTrWZyMOYJdlZjFjz5nX4yHLAapPCRC3/eWV0zmBxmbdpOUzRmdkm+n+/DK0SwYEjOTaz23SYUQbQiaJyiwExEOOtaEU7akO5QvXQPH9/g5wj4pGK1fPpfwVjyETZG+hj8jl/HzS31NHppvZSGTesGqKOCu4ujanMMQC2POa5S6LZrqKRL6RLcNl3C/h+mtldTfgZr2tClGGzzO1d0dpb4MJPmjhqaNGgcs1OI+y3Yd6Qc1jAMWS9qY3QgV1vtdRnxbTQ0g+ad3l06FzGXBI1GRMtNndE2ZwAPTzrN0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si6Vj4qUg6X0mSSRLN+6z+Qu/oIHq66tRZ3JiDKOS1c=;
 b=WF+iLKSIB81YoloBBkv59Hf3Ns6O8j+1GNYE7ts6MCH5NJKmFmmaPbIIRQ57MUKCZLx+UGQLtUtBbwF/5Z7+ZahjKgRR+sKFGxa58202bRNJlxDSfpNXKuDGmID406xmRHYr+8K68hAnUcxXA71U3kBt4E7mocbIOLDzIYt4Qgw3+AlK6JKmMiy6whrfPvl+sFZKBYStmHrrFIPASf/oBanPKZ/1F1AGC6DWTBcShqsR2sbGMVZI9CtA95EaGsf+HT9X6MZklAfylM4gmc7MOj2mBLat19vesUySG0KORJ2H0Ndw3bLrv4kDSKC8Jic/EUmQuoNG7LoUQ0OYO5Jcdg==
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
Subject: [PATCH v4 0/5] Consolidate IO memcpy functions
Date: Tue, 24 Sep 2024 11:22:18 +0200
Message-ID: <20240924092223.534040-1-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: c318327a-d7c4-4436-f5e2-08dcdc7a79cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 2ipsg2wqSZhhGQRbdHBu900xhV/LmSaJb301GdiQmQZ9DuzntkXKY4K5cb1Ku6x/9lFMAeRvfxE3BkYE1KD9DdzH1dRcaU/zQdnGlh5m6WkV0YAhWiPCWuMuxYs+ryeECMDCRe99dVH0Is578eNROlvNk/Ay7NC8Z5NvDPMNN+DT6lm98yMc7x5bQeWvZgpfzCg5Nn01Vg0RGm72Fbj6LxfDVnacxwAj840GumFSlZfkXVgQJdMJzW3+E8G2lBU5RwpykMBNr86+wec93YnXHzt87CnbD81MBdskriD07cSKwFA37Q2mO2GiXTrR8gyNN2nvHVuFVqkYL1p4XJx3ARIYsUTvE4E3zJZXJ57g1xElDMMVga50LEnw9qvPtEGuPFJcQpEL5tjf6D46Z7/f59Lp57B87hV+JyTOjlxwKyJfU9h1dPfO7UxCDGHHQf8XKgvCWWpC7Ud9c2EE6KMH5SE/36OgxzHjpuowKMTflsDIE47zbdQKgoAGepXEWTESl8p05f9eBb/i5gmUk3MQ3BVAd6unRCgK4xhai6z7vwsNomFXIECxQVw071ejQSQKK1HeQhlDL6k6udpwml0OgzkXLY5sskzxKSzQaSyWCHu6r0HnDjNGb6I/mwQch3VTjNvJPN2b3SJLXpnxB3ngaunM7y6mGOZxj5Bq1M1lyqFgZbZF1l96/KTq6ruZdvH8kcpqjz+O5FZCk257NXWW9uYuL0S8kmsHnUx9sSwaicHVaLxO5LaD5O+1gH+O9T9L+NiKJ7Ftf4cXOwUKcioo7UlUhdmvzJGRWUhcJGuhL5/l+mFVM1ziBkYn56nuqvuKR/mny9OzIk2jvh9PSg6l5EiYsIu9pKw2tDRJxCqJbxpa6XPES74Mhel0nN14lEpXRCL2E+dOoTDBsMyKAPGdSl+sDSxE2Et/lLZ515u2VNhEmP8DQ0la6TM4cMuggS6RWZR
 JxTku/UQZtqjnesD6+sP4sAwEGAK7DrYyIXgnT0TuTuykY20CRIzJQ3KodciXV2hzNHc1IvKO+b6/3oD1zvoOZd++G//SYaIspCQBpAxeTkmq1uXPQ0qaNG6Misj8368QAhg1xGcE0XOpsA0T0TqlCiZqU0zJF9lfZiKCpmhkprOx5q5y0Bikh6yeB4PHL+n73bDEDbxpwPlEuWfl5Tf8s1GZfg2Q1uO5NWlxMhTGXahscJu+YW+UrH48MBIvWaGHRC/msl6lNlzXqN1KbDKH3+q1S3GqggpUdaOiSB9Wv/Zkq0LkTgj6J730+EZG3/+bDXaffwyBq+/gDPpAKTLn+yQnBdsNwYrvm1RH8wBubCwZ1+u3iJmAl1h5zQpA3K1Ow5RFkbRr+n0ez8d1rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZGP0vHlMa4mATeOi4pGP2NSbyDX8ZURnmwUAF3WQurfvIWpzKlwLCBP2Dk3qsyTyvm85Ds1a/HTCcvdMewqv72/FgwErTe7Vdl0Cg3QeSkqBFpUXOPh1vbWEN5F7RMUHwQebVudurfSQtZNUFpR4TaPEAXtrSYu6MTXijcWh4DC6FXFRxh/scvR41nLflOhtqi4f0bdXvTni9lkPHbKL/PWy9eBebq2ax8kpMar31Lz13lflKvDRfqCHqRe+sRhFbuEbBVtqGrdMXK3R194W+PkmdS4FrwkGftmLz4UayWWZHss2L91ddfLeQTfuDgUP389qmFZnBAiHgNHwaZ5hnJ04E9gmhplZgZdQIxg/2vf8ZvXpnmoW9hW9yo6J18HVJvHtlJoeaFEoPHjnerEsLrwUv6ffkxqyWKQE0H174V8IxPJaH7Jx9HQzgT6kGXkz8yrhe8XiYrFlOJZgDEjS84lswmMl5bW//Uci9B/Qw3lNsDBQnpY27X/IKZF7eQrdtmyReYmvdWLKZXXOyE/DhatU1CIFECHaMOtmPOCJlxFHvD6Ho1VVtyAqq0m9vBlaRuvWoXL+fS3HC2L2MekD3kP2OOVrVGtblM9HGF0L0vNF38gOrf/urS0ggscv1pcNfq587NxzoikOHqRHV2FS0xUVQgSRpCcqfAdR6N3wokFpWpKZxrB40JYGpGXgwHY/U90AejFUnvhoMI1D2B++FoDdVa3tH7+u9jPCLYyd5LRLa9iD23vepSE/UShDNbqzmAcSjyC3vbaMPtZkh/UIhNZE2mxbwUDLgBja2QF+aZWAZUzfQcY/ihuhiMfbDA1phJHUFiHk4njG0hHPFQiNOLbjVxz8szSLuv0zqJhkjdQmXLCWu8kJeIjv+FHp0wRcPwSwp86j4VfgIoocY+wJlW3/6xPx+w/aloKDjIpOfGYfFzTIHBa+FicOn0KHc92a
 stCz4yDDLg2WmhgxJDX5mlnTx8yGNOhf5/b4p2g3tTgXY0OrF5mx910Fw72o+obYYx7Skw5OCO6/LJzFGCLqSp8kQgsqdnwN0koiFqZTHeKoa77AGhv04h3mTriYkOzT3X1s288Yj/HEpY+D5t1ISXZ3ZI88GGe3pLfaYUGZdbttDOdMNNyIpxfj9k2G0pARkKQ7hI8dxxCVSBK+6FVP8JBn/ObxDGF4PWUEeWtx9N/5HHnBH6usSdjDgfKAicSRhg/RjvRBNI1Bb2nAdA4/9x7dL/4YntsvhhVN/R7xNi5hSeTcCHAhIdk4TjXf4gQh6Mu7DSsVrCWhVEYTqMntwp/7BbMbK3y8BWpE2IgH45kqFdwDRsK5oUVJ/1QEdyGWPemt0A1oloVS8fQZpdlxWVr7NjoNVnyFwYlX8FUnpysXuM8/ZbJw4UnjB296Std7jEE/+esWak7C8qxtXlcwxqnS8KH9KzI9WPA72DpLsg07cEVIcHP8Op3xj62gYc/dvGaxk5vRNIVCREEYtAR/b46APBS6TCSm8JBKXfXOq+Fe58gF2BlcyMkCzNfR/pIjDZB+2r9zCMZ2bcaG82GVv0cHGGh3wWkS+sF4o92ntoZ4yxMUvo6KLBrtMmHDTGhe
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c318327a-d7c4-4436-f5e2-08dcdc7a79cd
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 09:22:56.9499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYELGBPTjIw8ns0pjuUoP2zl6caKnGZ3y4INoJuZOyT+qBDiwcseWLrWMIAztg2sd3mPXfzl6ZU9kuu0NBLq1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3073
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Thank you again for your feedback. Sorry for the delay, I didn't see the
remarks you made on v2 of the patchset in regards to the
asm-generic/io.h. This patchset takes your remarks on v2 into account.

Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>

---
Changes for v4:
- Replaced memcpy/memset in asm-generic/io.h by the new
  __memcpy_{to,from}io and __memset_io, so individual architectures can
  use it instead of using their own implementation.
---
Julian Vetter (5):
  Consolidate __memcpy_{to,from}io and __memset_io into a single lib
  Replace generic memcpy and memset by IO memcpy functions
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
 include/asm-generic/io.h       |   6 +-
 lib/Kconfig                    |   3 +
 lib/Makefile                   |   1 +
 lib/io_copy.c                  | 110 +++++++++++++++++++++++++++++++++
 12 files changed, 122 insertions(+), 277 deletions(-)
 delete mode 100644 arch/csky/kernel/io.c
 delete mode 100644 arch/loongarch/kernel/io.c
 create mode 100644 lib/io_copy.c

-- 
2.34.1






