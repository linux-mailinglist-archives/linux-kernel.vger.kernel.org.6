Return-Path: <linux-kernel+bounces-337128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 598EB9845B8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173802842BF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECB81A7248;
	Tue, 24 Sep 2024 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="dAHdPo2W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="qldkJg+5"
Received: from smtpout143.security-mail.net (smtpout143.security-mail.net [85.31.212.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF0D1A76B4
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180090; cv=fail; b=MPyc7Wj+mX0YIHxOwQMoD6iUNwsn11AFncGdwV1HSObVGp4xOTQDkkBTj2uyzGaEWuw+k3XwFR/HNn7gDXMxtFxpUnnQyVcc/2Q9zfMta6cp3QCcYieRGNsTfOvJtv4ZndEN7TnJZtdMyFNr5/fimdq2agaCUvf48hvRAucswM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180090; c=relaxed/simple;
	bh=3ECi8fHQVDRG+KsymMA1Fxv2KmgGeKalYuq4swiCZGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=haRrREX33GFovjgpOYbPJ8gnd/b7UCOTs5c6YglAui4TdUqTK0v0dGy7elTsImx+poop8qUzvNY9NXjVJnw/sGPGETpG4wddBysfsaBldcWRczGzBdu3VU9OuefjR8C70LpfmOlXdVB2KLy3K4H36nyC/dd+ng7hxpOqj63bP28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=dAHdPo2W; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=qldkJg+5 reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx403.security-mail.net (Postfix) with ESMTP id 42146903A36
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:14:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727180086;
	bh=3ECi8fHQVDRG+KsymMA1Fxv2KmgGeKalYuq4swiCZGM=;
	h=From:To:Cc:Subject:Date;
	b=dAHdPo2W8/YcgzYc710G2KvdKjxy+sRDNEClWzpkRifg2luh1ebSzm9L2mfYPMgBu
	 n3hABaZ/A6Kj6heduD13XEutt6zY4bOWego293fIyGypOh2DYepUpBbAWhmEtVbCnr
	 TNgUSYyd4dkwbeM04yZMjEvBL3aG09lK5SCxLF/8=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id F3E1F903B1E; Tue, 24 Sep 2024 14:14:45 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011029.outbound.protection.outlook.com
 [40.93.76.29]) by fx403.security-mail.net (Postfix) with ESMTPS id
 11C8A90327A; Tue, 24 Sep 2024 14:14:45 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PR0P264MB2391.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 12:14:43 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7982.022; Tue, 24 Sep
 2024 12:14:43 +0000
X-Secumail-id: <183d4.66f2ad35.febb.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UT7v7ix5dGjWofkygb0HxAzhpW46PBc+oSNpOzqb+zmcMg/c8ysq2d4nGgnjtVSIBM3hA9usXdvsTH+c3+e9yW7voAdUacDVQL5grS8OXFkqeVSJa9tH5hooADtDOieUUdh6QtjgAUzc5GQkVo4atiNl0aD7nnviUyBgFec7P+EiJ1PZLVRBavR5W3BeUygiw3P649WU12NtTbB4x2QowThZ43N/PjC79PFSekJjb0+2hXFnb2kPfjG4mgjqXIUioLTFK871FUXrVzCf4dAs74Dj5QTHIP+fkaXcjZPF1FaH65yqutBvci1b+kW1n3KWxmyLk6b1DLrnWncCqGhKNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMTQCS6YqrcBW2B3U1sogQqmX0jrdwYKxadXhJpwyik=;
 b=HAak/zhvdLK+aMVbq5iNwee5gC2JMMci7gUBr6gZbg8ICNqe3d10QUgZnfC7iJ0sKlJpd77MsSNMgqHyW36lgJsN8KesnkjgFLSbLuCW6TYHtQ8fjF+27wsCG250QYpr852j0NR96KxyVWZQSAxFykSArmDTiW+xbN29uSG1P8uMWkragLxNuA2jAV7Ur9Mt21MLg4wwRnL8CW0acqUgVnQc0hbqSFg//tKVQvn49/jcl2PmsIqna6RomLsoJSbddBDVbaohZfM6fmLD09jaDTRi04gKvoXHI9dJVxUG4iROeX27POeqjidvLkZMWE0J+g8vOjJwU6sgrrqBDiqe+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMTQCS6YqrcBW2B3U1sogQqmX0jrdwYKxadXhJpwyik=;
 b=qldkJg+50aeAv+p0Iisxpb4aVYrAd5lo/wgrcWca4CYhsnLlKPpJUkpEw8CtuukDY2PCSCBlohw6ANzfuGlz99Zgwk6c3X1IttpTsTlsPgKHx9xclitdKeWf6U6dJAvYctm/B/nzK4IIOx99PlXQD6acqVCMxlYaGFpSWkD6Qu8EAVR343iPmvFmWUjYLdDeBaw9JKjn7YGq+v0hSoGp8Lbfv0yEtqr9kt2ZJYrbTOdF8uZwaQA2/SDq7geeSKG659segnshF/dnX5GNDyrs0y9edIr4Cxw2W9WuldNPg4qPuGPJQtQkc029oKiUhPyoJBFkgMBV8alr6rZSTGwb8w==
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
Subject: [PATCH v5 0/5] Consolidate IO memcpy functions
Date: Tue, 24 Sep 2024 14:14:27 +0200
Message-ID: <20240924121432.798655-1-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 9e28ec95-4b41-4e99-423f-08dcdc92790d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 3bELz1oyao4EPwaJLdsIWaBY4vJ6aBSYWiL9VbP5tsLWEKyKcZKqzFERcabcd/HTrCKXJufmSYwt919uk/PeicdS2mOFm6iJt2nBRXaUyql5VkHkT6i04QXh497QEXbJO0G3QOJqMn35ph7vLq7+rj8Z7SlvPZZQJ4OyNIeJea1BqKneYt31cHrU2JTUiShzzDJuW9+2NdMdiYpqouLO09k7fa4LOAOLgUXqv9p3HcWicgKVa57qf6+nipYjArQlDst8QIBlmHITjKXucrAVJaCt+8WhcnB54BBrrzE5jKgc0mSIe2Xrg5/tERWBNTvzqO4yc0/h+TkiVyTYXJQjL9gxU5cdhjibrnfLKY9N/OITXBYBhEelablr/5xLgjw5V7U1A5a2AGbs/QD3AoGpTs0mTds8MPtJgYlRvJ0xwKiGORYRQ9uNuUvr9C9FCTEj8lS+4LaSjUDZBoKYc0AZDL6iDvAHGONtXTya5W0Du7Zp98P433MN4Qu01zWJUk3c9o6sjDqEX5Ui3lkLRDZsiMQSXTJrXabfV7Za3hlpcBHl6Q5nOUD6Y3uZlRv+UoldWsUeJ2pFyouOCGM4XgI7QvP//JzQhZVZSTKW6bUcqLgArvZN6Vd1FEM2x/TsgPDstVL2HQFyyOb1cG9QXQ3FdjcwvqoHGuh0NIknAfFBC7YtG3J0CaqnkP8ldcdxya0W8w3DambzvQr4K3/JlSTTblbVPmzR6mtMukciLVCmZ9nWDo0qk660lXauwDe9B2OKH+4zwMFlVP7AhhMHAcFrUS8nNruRjx1VdXP8AjLCngYLP5bMx0gRhezic9/FmWOcvkNF7zHgCnCVpky/WTbpcVcCD57Qn4uYzh0JUTNHcn/gRxU1jiKPoVZOrZCN4KGuk74e8nal0FH4teOUaAktJeDy6VHQDjd1rbMmEIoM9i4x2j3CEL5yKs0IKjDdwc4FzaC
 uRuaq40usIlHWBdkUe97V5PFIqmV4bzcnBquHIekj184MYMKlzpcO/UZewICXNErTlCIqii36PCfiY8jGNe4npypGxrOeyXinH70k7CZ5sqPxuicm8wj6iVLrUH8MRlZrCci4YQ9o7I9Pz1AU4epuVUJNlPbj29Pmp7AMFKeRCqvQPSA2DE2y+PucZ1nNlrsAr504wmO5jWDgP1z41T79zxxVqg90Cg1eK0GL0ohdUBAlsD2D+QbwkHczKFwQGmtPU3mEX5pWeoEMmJmrNfGysWov7PTaO8C3JalwhHbgSxOZ6AYYG04iSaHm9yRJUZntG3N6uOYy4pEh8iDh1W4RJCpx+wd7PZPLfZoCNVLT2Z7R/+Fl1muxaD+G4bzctryR3WdOHL8OKnEqwvOy6xlHMPbryxriwxcxi0tzVLcE426R7514MRXnblJF9tmQUBXywJOYwszDd6mJW6M0IQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ThJq4zjTb6O6YzLlVHk1s//HUvTFipnjTAjRK2+OAcA7dmC7R9AGtjokeweX/SDNXACO/7CWe6WXpbYftGQsLiVgA3cXK0G6k3KRaf4QfTx6mHvk+dhN8QC9lK83dIZSHs/9sfp8kIaKd9JUZAlMa6Mjy3BDhVijsSiwHEpzQ8LUk+CxBQJfEgQNqdh/9lhbJgPCU7u8cqZNzq+kwukF9s6UzLOBwKK3MhhS7qT2KECTdyR2zdiOCDdYjaFVp8IgUy1AYqrfzCWPvq6uhHKjHfvTERX1sw24O0i6IuPqoAV3LfkxJof+57tV4KilAbRZoEnhGo2QEhgKRTKAs5Ly5MlprMz3h6pFSp1UYcdkLOhias+Z1C5z9+nUlEcZDJ4uOjsYlTOhkQokS7dUNiarew5E05mPwW0cM1PRpEXTt0biLcemkvsdhVTPX8vnsXrIIuTpfLi0/g0k7mJPm316UpFggFqh4s79CBIAoYRvDgZD0GuVDFOKZ/HHs4Xkpk5yCqnAE2Cd6baaqOgjCR03Futg9WS/xUR17bH5+oLCOFqLB2gR/at6M8caqCwzWqKU5j95fCyek6ZYQQqbCyzyJh0bmpswLhbslL7AOopqRwMO6CaUVBMN88520JvFCLQIOn6fSiUTvkN2qSI+Vn45SeGJCF7UYtlJF1bEOW3sqNKrgcHVM/Tfg11/ZRVmbpiJ9EcZiqZcHTUSofHMExVma1tYEvWLodFywUF/qkS6KKAGYUuK4T1ypZuh3MQ1sDVb77AbKzPpWmFxpwUkhvjf2tyGO7tfc43xHNy6Sd1mmWJ8Kf9/qyQEZ0991tqdPhqor/4zNe9Kf1+r07YIruzD1fj4YoEEiISwiEn0pcomyMbJb/RhjZWz8dxzRxvkcxe5IgHtkC+Frb7+mVMDKaj2Wh9Ai25SS9iLe2Lye7itqmf8hpFxMdnGc757Thel2Gkp
 4yFwQtMbMIPbNyP3Zt45yPfuikTruWS3V/jWKs1T8t/kAfdNelEnj0xrnAMOWvdkuPHi0L1plTzyWwEuOklr/40/gfJEdzS5Z75xHkjzQWuv8IzbzY7DJDwYmpXlnYOGeQUZYliY2DYZzqz2m+FAho8yx/HRRmsGq5+84KhdqD4aHNIgWtN/yUHdC116iQ0PYPyG8G46DxtfSqoliTFm8kOdsfys3TjVfwX9OIoRMyW5Q250ktbkRKNABrmhisoRjB8bySWRjfx8BJESkaDwitlGF1bZFIXawbDA/Ca3q4iLEnz1SxIUFlTSsOIwaHVG+idQS+g+ZX6+vVS7fsPjnCs9rbDYhXuEYst7ECGC14WbDQCwQI/GRqwFlB//bT7SN7D4dakuNlQGtQs6vKjJsaMPCYiKGuTXl8vVq0nXtmqHmqgbQpbSdW9rvu/9ICZmyFLwpev30pjtNqgmBEkWzxfKg3JY+XK77xHh1A+NsUzTqW6wPaWhiq9n/sLc0WkCuSomQNg9e/R/u1RQLZTKG5+HDfral1nYvWVSdqbvXzhuGChePwO1rYB8YWkC34VWR4pia9mSv3En4DuPLUD8UjLLAMc6VRQvJJtX2WhJG74Tc64FZGtxa7EN5wsFiu79x2cxHdM5RHlxZfAqaZ9adw==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e28ec95-4b41-4e99-423f-08dcdc92790d
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 12:14:43.4870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9/X+tddNIVPad1FnoqqDsL96NxkAd5MZzQ+vNRrVpDENdaTpys1iFeZsXF5/6NS+8Mv68D692+ZLh08yiEIGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2391
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Sorry for spaming the mailinglist with new patches. But please forget my
previous patchset. It was broken. I didn't fully understand your
previous comments/feedback. Now, I added the new functions to
iomap_copy.c (as you proposed before already). I guard all of them with
an '#ifndef __memcpy_toio', etc. So, if an architecture already has its
own implementation it will use it. If not, it will either call the new
'__memcpy_{to,from}io' and '__memset_io functions' from 'iomap_copy.c'
or directly the 'memcpy_{to,from}io' and 'memset_io' functions from
'asm-generic/io.h' which are just a wrappers around the __xxx functions.

Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v5:
- Added functions to iomap_copy.c as proposed by Arndt
- Removed again the new io_copy.c and related objects
- Removed GENERIC_IO_COPY symbol and instead rely on the existing
  HAS_IOMEM symbol
- Added prototypes of __memcpy_{to,from}io and __memset_io functions to
  asm-generic/io.h
---
Julian Vetter (5):
  Consolidate __memcpy_{to,from}io and __memset_io into iomap_copy.c
  Replace generic memcpy and memset by IO memcpy functions
  Use generic io memcpy functions on the arm64 architecture
  Use generic io memcpy functions on the csky architecture
  Use generic io memcpy functions on the loongarch architecture

 arch/arm64/kernel/io.c         |  87 ---------------------------
 arch/csky/kernel/Makefile      |   2 +-
 arch/csky/kernel/io.c          |  91 ----------------------------
 arch/loongarch/kernel/Makefile |   2 +-
 arch/loongarch/kernel/io.c     |  94 -----------------------------
 include/asm-generic/io.h       |  18 +++++-
 lib/iomap_copy.c               | 107 +++++++++++++++++++++++++++++++++
 7 files changed, 124 insertions(+), 277 deletions(-)
 delete mode 100644 arch/csky/kernel/io.c
 delete mode 100644 arch/loongarch/kernel/io.c

-- 
2.34.1






