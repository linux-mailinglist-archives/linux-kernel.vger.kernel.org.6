Return-Path: <linux-kernel+bounces-339140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6AD9860B4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD5A1C268CB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACCF1AE868;
	Wed, 25 Sep 2024 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="QDA/+wZA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="RBrFgkOU"
Received: from smtpout144.security-mail.net (smtpout144.security-mail.net [85.31.212.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2E618C92B
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270686; cv=fail; b=rpEuykV8Q8M6mUpemqntg1JIUDGM4z6DZGampq6HntsQ4Gik21oMsjai9Qma464D1Bty2fj0u2Wwkv82+8You7YecjNIg1itBvOPsHiiCjuMomuAKT9+GpMn0p9yuF4Qd23L6K0HlZ7y27xFIDx7upEWHs8Hc5Wlspia9Rn6gdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270686; c=relaxed/simple;
	bh=8lEi+VuejbU/yw6FJTZvefT4xKEhJd0dp0LwFqP0BmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OcmDlX0L68TSeYHxmRSI8dDiDH27wzqkhNAjAKsAxaQE3IrC8dGlEXpjnzsg4VWXEDJQKvfWaUEYGk1hpCfVSxlPDfdiqI2WHwjw6TLGtvv3F8BlfgkhxqVqrZkICdXKX49pJJVv5nTMWTmTbT65SKMMTguhhBFOHbhZfPGzQXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=QDA/+wZA; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=RBrFgkOU reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx601.security-mail.net [127.0.0.1])
	by fx601.security-mail.net (Postfix) with ESMTP id 451193496F6
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:24:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727270676;
	bh=8lEi+VuejbU/yw6FJTZvefT4xKEhJd0dp0LwFqP0BmU=;
	h=From:To:Cc:Subject:Date;
	b=QDA/+wZAAHf8y1xIHFixTWFHNNkH4pqVzSO13NjFE23kwqrpvhRqTtlqVqWYF93NP
	 qw5QpYkB8UO8GNq23MZonVb5aCDdeIXPkbokADqsUVPleJzoRjSo/RXw6AlaF6Z2ID
	 5rsYrxCu+iaFdajbuJ4PhI/8auAn9Moaepr5pZ74=
Received: from fx601 (fx601.security-mail.net [127.0.0.1]) by
 fx601.security-mail.net (Postfix) with ESMTP id EAB2C34969D; Wed, 25 Sep
 2024 15:24:35 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012048.outbound.protection.outlook.com
 [40.93.76.48]) by fx601.security-mail.net (Postfix) with ESMTPS id
 1BBE634962F; Wed, 25 Sep 2024 15:24:35 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PAZP264MB2543.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 13:24:33 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7982.022; Wed, 25 Sep
 2024 13:24:33 +0000
X-Secumail-id: <ab3.66f40f13.1a33d.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BaKTfohv74X/62JrQF5/bzq3xqxMYtmYrhH6CIzFBhVR/nt+xsFrf3ThMzi4z9hfegp/UOG5Cxc5gIY8j8O05nsIukpoCdfmB8td5aT1iUV/HRUlw6sv1QihqFuNTGlG/LVjH5+keMd2y8HphdejX9ThjaGPUcuvcnrozdTtM1uIYus272Npu3cA0Q3uDmKAi1WNy1FUdJpluLmqv+9wtX1awoNhvFk6X/Te2hfBL+V7jvbNUAYIklvjj7KnqWxQjMSPmVb7rNGTu+0gcN4HzktRHnu3VR8nXtZUg7O9WqSg8pz4/DSe3D/BcboCtmZZh2sdwY/OYn/6pTKh4MChiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMEgvJFKFqDrV18lig9ZekYMNCjW6s3gxtl2Zuk1OKw=;
 b=XAz1FMtgHoFatZRDvMaBeSVWHNF+fgzfwLxjEexJbMyjv8jMmvnoh4iD9mB2duwxxYRL52I4OIVtAJnDhaknVDYebl/hwtYLGXK32GUARlIsers6i7zpo0D9lzfCLzJkNhb+RDKEzAQTUI1YzCiKJ6/1jJlc+7iSo4yy0hBo0cTUd8qJPhps/p5X7NwX8CriJ0zcyRzgfOs4i88PPsbuLanUax1MpA0T3IVhLKl0WSO3SmYgh3HqBx3VsLIofeh3/lcGBZgnlXb7drH9E9Yk/re/E1+Q5lx8Z0y7MDCLPdK4treaRrXKSAGAskqqCX+K114ffqnBka2Ccmak6VDp9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMEgvJFKFqDrV18lig9ZekYMNCjW6s3gxtl2Zuk1OKw=;
 b=RBrFgkOUjJYr8perRyLPD//gymdTO+NHVOvLXiOAZFsS4ywsHvNaxqY9FuuWeOIw2bXeIXgWGYYv6ZqRAT/B+21rk+XVT0LbfVfeW/hLP0oSdUll+bUgbopNuYG/9pgb8J5Pn91qPIOer5QonWiv09hTLBKBX9n8RkoSSDtYU/panrUo33AQDCTqQwmGHkIecYl1zebxkFkW6On1mR4LpiovK8c4/t516aZKQAPJGiPuQY3tohqjgcNhhRBFwUcz/JkFJAJzuNStVWv4AZ24e30uyU2GeCLVxcuaKDECNHSxLNg10v1QpL+gwp0y8TqnxKtnFdPBsDg+lxia7ic/WA==
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
Subject: [PATCH v6 0/5] Consolidate IO memcpy functions
Date: Wed, 25 Sep 2024 15:24:15 +0200
Message-ID: <20240925132420.821473-1-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: c055267f-1a92-4285-cb48-08dcdd6564de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: ChIVTiwMfI4r3TRBtZ/iCVDcAPsH9qibf5JuiQ8HqIZAYU7p+gPzufCU5JDq9jHBV1mcNG/1UD9kmOZfLSZ0uwtVzNnLXxSKjecTcfwOnEicfH5TGoEGrKcTPPc8U0zPoYlBDdnHpGBaxN1fMD/Fvab3LGCFNi55aXeBENDo1UaQnrkq8NJza0q/VhV45Qm4n49f3rYOLLZJkKm/m88JAdJJ/kdrBGQnsKHLTnN2VsCovZlhQ9rxRg2mG8fsroFfkZDWZXCkAGjPxVRF+q8ytUmQ5P8OdPoUJWa8rOIOYQVwoKmC7X8Us4qn+KntVPYkkpCqGsy6WoXDLoL3ZpESCxOvikjlKU/NfuRWQILKpawuzo1hx9GkTBJUhmYkq+ClvIbhma6BGdooJkJq3xETqLabbJ+tntkrlh6vr6CItsYGH/gw5r0ke1GUSAW2LTKSmk4QZtIOhOJQkzjMZqNR3YyfUVBPrpWqnVxhzsuy4fNGidFNxkLwhNWmvlLx7wn1pxUleFFTpvw7T8onI+Fq5kprXQLflpzl5yUEfU3vt/OzQnRBGayTSpd7uTcTw0BJ0FjGSi6R3st0fqLz/1EZpMaAEMpHh0yJ1SFOj59opuRGM+Yrvzb0JBkC0L38IR1rZYfl5991VE0LpNoJKMwU4pJfCiVYFTF0vJm8k0fbaX0DCqSEvxaUjeq6v8Tfj5D7dcYaMUh3lUM3qdyH/eaOM60HB8K3fQtDEQEud4whpx9ZUJZSjRuh55lWM2hNw7wYt+3wpkkEzRvVTBD4rJKSOs2VanORReskcNIaI1wtKqK6S0yCrkFPIkHqqxCul363jkIvCBm2zWYx2UG8hPxBft6HyHr8hxHJH5WapSXNlbTd5OWHwaUQ6Xy8YJumjj9eCT6sKluxG2hhU2e1LhPC/480sU/+9EPW5tqGfsuPd7Xd5VM0iSvPSPLdmPiOfNNclWb
 /axxkX7qSSn04GYZPTKVnX2T9xdCcI41B4Vei7jlShDfBimhmPHKRbBWbRhkwGrIgZ1wqjrNjrTLx1bzo8AG2j1+gurA4chZ9iFhwMUSPsH0eUam1xUBceaoddzmBRej94zwSslYFtCf+hBbfd8Q6RWZB6+AdJmvpG/2IVafDeKTtoJp7Lf3E7rsady7qiAsF3C2U1t8W9CWgbBy9ls8bkHq95xn3GXYPu1hNpZ0MqnKi0tND+uzXiH7kCxJGi3mLxd9Tbdl8RMKFYChM/L1OPAmhV34vtE26Xj9YjVyLOYThkHyWf+WzCHzjN0x1sj6MjFEjEgM3duI4DHniKy5c5oSVNSeVcDMZpTzKHXHZDl8BDMeZKTMuRBMitBv193JZvwLeRo0Zsk20xKngHeU2aO8V8jsDMRvhctyOU/AsegoKaaiOJjxZhZ1W+8EIHILoM8x7lfTCXdtJN5IY7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8TZoXZ2OvSiK2X6C1ldAqCYJDUT+EYKXlLlQ9k4ouTc4FRVkiUSP7RniSKLKy/n5nMyehhGCgkhPvBHOrhpBTSJZgA4glPl84Njih6pIDTYIV8Fl44yY0kWxnep8bSCOvnrkX3oxROGtk1+GYVqZIUVHGXaWuJcmJMprdpux5FMb/nN3NrfIz7R599RPP7S3mEYfpwv4QTodwHww6swmLQORU714/LZy87mdzcMdYOxYE1c4YEkqgbQOMQ9tOR3g5cJZwXXFN5aAKW3eI6piVxhZG34ql9gTkNVACHSb4ponpMaM4Y+zTJKdc1Rlbc5vIALMvgbP8f71Dk7IIPPlh/mjp4N6iD2NEXXwSt1IfaW0fogyNl+WVeuU6vgKecIOc1K7CS9SzWQRhkRFFE+QjN+s31Ti4O+FZbSSPA/nmONSaEEfPRTg1LfKMEua+FZBTLpixYc3evKcWH9bVr0TOaDuM32yktHFvKLB7bX9xD2E1Tr24aMGfMoWTrKSWw/qNFzLEJf44fqaPooTq0vNz4MPT2UAsTcJ0/e6kK4ef5DM6d+MYjfpXcTucQ0ml7NDitdW8/co9hPD3X5lE4GUgzKEL7XDX4EsjsoFaduOu6b5FmrzYFIfaN/P68kLofe7ghTeLxBAHm0aiHsCPv0Obe+rncipGnQAukLBunWXu1IQQb0koltKnd2zsgYGVDQy0J6S47a+gpzcATxOO34H7Dc7KNZWP7S6QicqupWEUiGJggi1N9omzmCcS2X2UmdoImiWjmYCoUw5dkH5WnGmOlG4w+SdOYWUeklvo5A05ge6YXWfN9RYcWRI2PnO8xkOqHeL1xxzQR6IKtt2eOxANdYV4VpMSI2GWBse/VrpEj/mGOI0g+UhtzD7Vz/nZ61td+h1rTAuHEbTJvqPMGdX0QSrVn89BDc2JRdEgRmhJKMJS0XCohDFLiumpu7WcCxl
 lCw8nHIQFelPx4U05qfGVGkrr9rxbuOLMdFmKtnYD7ijcSJr8Jw83exUhioOgURncN/j6EcsMQgUmBD0j3bsT4OlOEo7as2BocrwEKOApSA0lP498D3Hyv4j6silQaTRrY1gcqcl5DnuWSbTIIbo+VDywaxNgZSLF0RLcDDh9Rba25wsBXDIV9vOy5S9M0WKmtzM1Y4mE+HpQtKNU4tq29nIQJDTb5dMdAw6VTgSAcw920mCvlgH4DBRipcdJZvl+nCpiGpzvDXcPXv5D5X+CClQhXHM+QuxhqZWueLmgvj2zUo/J0htaJf/uIb2+3JiSxY0bnRza5XiuOGLgbjY5jFc/2pMbpxkM+X+xdWe8E5ss42W/5EN+3YEH0lY41aL/r32IMd5bAMyL1BCsqYA1EPNYoGBye70L69Tt8OU9dC2+bUfJkRCsRShtSrUleOMBZO01u/BMPJvPVp+VvynFoSP6wByHLQklrKeteg47zS03t10++OmwUMaZPqtoLy1iz62gbbO//gehOp2QWWRzYkmIvSvO8IXXTwqYFvILL7Zy4JhM3r6oz32LaO+yJSCajU4czptYZXW8oNKUrr5NwLaiU2KQnT6eqlAz8NK5x59ynypVy0sFqjhmq2JT+p+
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c055267f-1a92-4285-cb48-08dcdd6564de
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 13:24:33.4977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJTlAFWqv6T+I6RhfcGDRNXZQvSko4PirvdN9FIwhGvib7NU699XR070fk+FNZvycVhGr35CcX77GNC7rlwMXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2543
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Thank you Catalin for the feedback. It's not a nitpick. I have addressed
it, and added the architecture before the message for the 3 commits that
modify arch code.

Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v6:
- Added include of linux/align.h to fix build on arm arch
- Replaced compile-time check by ifdef for the CONFIG_64BIT otherwise we
  get a warning for the 'qc << 32' for archs with 32bit int types
- Suffixed arch commits by arch name
---
Julian Vetter (5):
  Consolidate __memcpy_{to,from}io and __memset_io into iomap_copy.c
  Replace generic memcpy and memset by IO memcpy functions
  arm64: Use generic io memcpy functions
  csky: Use generic io memcpy functions
  loongarch: Use generic io memcpy functions

 arch/arm64/kernel/io.c         |  87 --------------------------
 arch/csky/kernel/Makefile      |   2 +-
 arch/csky/kernel/io.c          |  91 ---------------------------
 arch/loongarch/kernel/Makefile |   2 +-
 arch/loongarch/kernel/io.c     |  94 ----------------------------
 include/asm-generic/io.h       |  18 +++++-
 lib/iomap_copy.c               | 109 +++++++++++++++++++++++++++++++++
 7 files changed, 126 insertions(+), 277 deletions(-)
 delete mode 100644 arch/csky/kernel/io.c
 delete mode 100644 arch/loongarch/kernel/io.c

-- 
2.34.1






