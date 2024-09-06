Return-Path: <linux-kernel+bounces-318804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2159496F391
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9CF1C24387
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC4D1CCB21;
	Fri,  6 Sep 2024 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="C5xALkyG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="kVsiJbWr"
Received: from smtpout35.security-mail.net (smtpout35.security-mail.net [85.31.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4271B1CBEA1
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623407; cv=fail; b=VC1LkwwKXYO4szqTSYAEpO2cDmk/CF+oGd/3hVZnfKGCWLqsDgafh+LcQINt+8L9lO3SqdJVvXz0SMMpgIhNu3EUFxMzOjjJj7EJoDqpBg8uykPSIfLA/EePGth5j2WoVDj/kGY93DF3bxYRIEU5VSO6TXaMgdUp6HFNm9AED7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623407; c=relaxed/simple;
	bh=T0Fa8pGvpZhWa/TIa0csqoizV9XTmLf4rUAw4StyBuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWOiiGiAOUu2cQD8wA60vjb/4hVAlguMmfOALwEjEsr+GAOGxlbHRbSgUXi3mvY1oTEJ0QnixzXBF49zfBGyv9O0mNjX7xOxaInOOA3jVytJZUj5WYVJl1owg9sxtq1FZPLmH66ue/VPafjPmGo/ptfNE50jeHodkxjP1PGJCAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=C5xALkyG; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=kVsiJbWr reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx305.security-mail.net [127.0.0.1])
	by fx305.security-mail.net (Postfix) with ESMTP id 2826030ED20
	for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 13:47:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1725623251;
	bh=T0Fa8pGvpZhWa/TIa0csqoizV9XTmLf4rUAw4StyBuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C5xALkyGOhgdg3uSzC1JHSTLaOYP7MRfkJKtJyqVNoYlSmKbUyiT6wC2tPJ3g6pY6
	 6s06y1lppoawWysXe/t04uvpm5zu007TRtlNgYjg84ifq2yhCDWuiaA2ZOTSEHjx/F
	 E0DgpAz4eGmqHFEokyYuJm2sY49oe01WMN7M6r5c=
Received: from fx305 (fx305.security-mail.net [127.0.0.1]) by
 fx305.security-mail.net (Postfix) with ESMTP id B56C130EC42; Fri, 06 Sep
 2024 13:47:30 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012048.outbound.protection.outlook.com
 [40.93.76.48]) by fx305.security-mail.net (Postfix) with ESMTPS id
 C5C4A30EA38; Fri, 06 Sep 2024 13:47:29 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PR0P264MB3466.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26; Fri, 6 Sep
 2024 11:47:29 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 11:47:29 +0000
X-Secumail-id: <7fe0.66daebd1.c383b.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfMxhWGj/3YzUKN862eNBJ8zdliFA6fBpxQu7P6a9hbFow1N7vbMg43+pE7Md/8fYQEQXxqgLG2/t8TmoT8QqdCQ3qWmWvbXJY61XoY4qSFwfsC74NDUf8hd5gEjiuT7+gkNfD7X8TDrSdTnOmCtuo2nH4cmYswfY7LeHsu9wRh0656XsAznsOi2mCQeOkuda7TGS7ODOA2yIr+M+scROUBOgIP3C/nZEWF9P6ECxZcJytOfoJBlOEmKrcJgJm3f3NtRgTSBgh7m8N1Ez0POqolHsXdJEI7s+84ppjzHcLKW0pSzcPXabJgpk3SpYa/lWHMGsIJO9ThSjyW83nNOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrMZc/2URVOk97YU3sanaSq6eSIlf+YOvYHpH87r50k=;
 b=e6oxtSHQNNntaL1mkrlSel9Wl3tGJywNOBR18+oMEdtyydIGBWimKJvTZ8cFnl9zL+pT3P7LihD3XKi15BXbRbtPxtNFX9MCOf22l5SfndRYBrKnI8v/rShkPV2K607NakOjTZuSUTnGUEFfFyAO3EAelVvrZp5HeBXjo2Nm3KnY4YqoBDh+8chkzRg185FGsjcIc2BC0guwtXNMTmQvW8ckvSrZyIYtLCjfAN+SBIIrq+o8rvgL0fU5IRCoC+1wIMs6JenSO4hCYFL1TQIjGTIbRoL3vAfj852GuMTn0/qvkpt/AVMC6OU4sIiRMyPXy1kcKKxcVH6YXivgqWIvQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrMZc/2URVOk97YU3sanaSq6eSIlf+YOvYHpH87r50k=;
 b=kVsiJbWrrQK05ICq7gOZIhQQ1FR3JGndw7GvNvviL33Ki0M5iaLvNQSQMbEFu6lZXrlHeAerZFMSKcfRNryM+dnbZyIfJUT/h3D4gElDEJLwevevLoIW2w7ASXEhhjjbs5k0DbyJkQ6Pp9+WV/nekD0bnPE7glUPT8BNl//eZWyI8XezjKnc0LfYDT8pNfv10KGdtOANGwURzfiJbw3PkOLPfMSXJATZoNGgyKaoueUhIoVauKjdbkX+nU01XL7+8uYO0hBpZtAGlv5lKJ3HkvMjMVU2Jh7c0DqwnGDdvQ+3S0fBiTYeI+ocehAvhuDm0EATAYIsGxZb1DQ1ZeYfJQ==
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
Subject: [PATCH 4/4] Activate GENERIC_IO for the loongarch architecture
Date: Fri,  6 Sep 2024 13:41:51 +0200
Message-ID: <20240906114151.519028-5-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906114151.519028-1-jvetter@kalrayinc.com>
References: <20240906114151.519028-1-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9524b9b6-7782-4579-3358-08dcce69af5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: SqN4Df6VyMvHXHJzvMMCmYy/hKrlL73ApliwTFwxot0n3cGNI1FrFHeFjS2DYpf8KWlvftEBGZDY14wNslW8ZuX8+e5aL2sEiW+4YVfjHGyQX4PE2NW6DMZA+9vqhxGPnnn0TGHoU015r0YbwpR4+m0Ui8Q6TczCkSeWMOyjxu4A1HE4Iqv3rWq6TsUxdWeJjxkHruTnrwy4Y+CdSPyMzIIf2XebkS94hbE3Bug9eBUFlRjGP8g5RGVI+E4t19SLpCeD7bzSzqfacB/eY2/NSNdKLZIpp5g0fGbnV7m2wOG+SfCHlq9pVZzNamp7sFu7pr6TewxPBteEkBwmJruqm2RXv8lrHVAwGs4Q+gwDXtU+VVowKgEdT3iH4ON5HYUCDnVyOTy6DcfHEjr+M6nzg2+i8uFQYARA3Su1zgy4gpIX+COIU3KgGy2GJedBp0Yw7HfhkOhkLzd4Zle325TbY0qaRGFn2M61AXUGliAj6KYIyeu0kT5lzHCUR/uqrbO3YOa02TY7O3O/y0JTJdMXFweTH/6YvKJqtJDkKC/XteSxrFaVgHImCUHWMz/ROscLF6VEh3FAZGcaXu63Wq6DFIOHcSBV1Piy+5/y9yhRJ1anAjEvd9X57RwE3t3/BfitkeptHvnnvux+vYVNpTf9MGTatY8Q4nUPror4Jdqe4JMo9/dB7lzWQALwWvny2AiE1IXlAqWY0D6IpY5pf0X7s/0/Xnh7gAPE6mbf34WGxF3th9U3beYYXDVqO246rp+oWHmfN08T6HUIosdHOtovijsDdGN36fFZtpiv18OoyEPudk+/QVILUg/w5YCVDBI35aqvU4Qcj2QwLxh99o9eItkHLCz01FD77OuAgfCKH5nhgpGrMeQUeLMBKu7ogLsEwh9DNmsCUMkpS07qdWImVnmTp+mXRhr8qLjSQRVjBLk2E80FR/QHohojFf7AxRoeJWt
 MlGUh+2lipl/ygVx4IvVZUYRYkSit8ZK2cK4daHGWDq9v5QLgdcLBvWUgSyfxe9V5NfLnl9+newfAiJr2JAV87qlGNeupIOwahmjPTWDt4U8IykQabrhSOuu7OdAMmI5Jw9hOH4TxRksBRjkpYDcFmWjWFPdUcGOPsbJEemjiuTJ9jcN2kwV1y+zKpFk1hWOhAKBuRn77wfEZhJ8hPn4j/2dkWL7Sms95zbV7fNCgDoU+hCdIAdY7uQa6QQ/XxLy+1n8yUjfT6Jjq160WVinwQtjxv+i6sDTOCRwrS2q/kn4GScvya7Vdm0C/o6jbQUdpOl2aHAuP86swWUqUnJCfQDTXX9kHL3L6Po8dU2E/CZVq3j9qQ0OROwfVqjvkcHQBJgvr8TNIA+rF42iPC3gVc+BbuYbXVDFnk/hGTEbUnh8RDtc9/o0zZYWffgFz6Iv6cK4IZ0FdIYeADxzpGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D+S7cxnb07PGpAYq3HHupw5uT35Sn+A39AvnDR9oI2vepZvV57dUU/x5dEkse1x2qdWAcNNXOuYd3cGZuqKGOQXVKVJi2dTftTjzsj5354FbZ/zwM88xLF2HPV/CPmdoZadotpKVBaVxcBv54cd1RKWlVjVIbKZk/dm+8f9Rj3/2qu+mcmbO5Fzs/zXSYH4NiKAZYRpbZf5xkfUsBOScV+JWeKuCJ90cSP5Gb2zygnHJ7gfZeWbmCae327CYbcMd68uUehJnzbRJ0JDhUTleDbW4uMe7TWqaI1mRHPenIfu0DDLAsg3ct5R7wa3KvVK+bQfWuCu8bWnfuGQ5hSQrA2C9l75xcad+1gsOSr1sJaxGwxHCP4dPL6UjvjvjCOXJUcGtwMA3/pap1nxu8s0Z0MNHlA3w+TdLkTvw6I9oBD5QGi6ZzzgPNByOUZikddmRT/IOOrEkkbTpuLHy2BQFk4LbPjARY+K/UqtnANmuJiU5EeHZQF+nwvC0bBlybekq+sIiwi9CuPDbAAjD9OZyl7DYztjdFwhjWdWucIkeyRckuX7Rd6id+D/zqy/ObGkPczH9+9huxxPA36qn3/lu5UsLPr2n6+Qp82VLLdU64G+NRuvLINFfJZxxLCREoRWCXjvBV6xTnGTKEpcL3CYlSW1mnHPkopAhtj7/qdwQypIEad05Bf0xJWF397Uz0zk6+qMC7PbcKn7OJ0emkNca9J/ny+vokaH55FpgFx1ezvcMOu+xV6/6FqqLb94IutPB2m5P/5/rLenH5MiVwyWJfaPguF/fQOosMuRoaq81wMf3ZxWSu7TroS0cWyH4dv6Zfxc3GbCCzwHtvxVQkVngiZzcka8NQB4UL1bh2U/YKrBuHcaJnGbu/e7rFnHPxZzXIVUCuuHyYfKI3OngQ/qDnPfGdbNmdfuB7nGtSOGl+VGm4zu5nZeen/zGw+EDUZ85
 AMfHoCBe+z5ezBRnakqYjlOseQ1TpkNFouN52ICth+Wjpw5pI42JDKnQviQ4DgYvirBwQzRfPQunO0kVE4oEMgoFWTiGDmKk3PxgRrJFzOZbC1YI1rOJjAbVZi9Z4CfIqZAt+wysqSFelke5Q/c4bOpjY5lG3DKz0n9fsnbnuIsgg+j5lMu8JMbZGyznUH8qbjuqWCptPTS8ZEPpws0KXmdZKX7eKNxcbmvjwq8/gcPfJI3q7Qu+Vh/iP7CEvdCuq+8+HDm+89mud+1udlETMxTT3oSnpkQ3Hf2b34Ym5qAJ0Al4y/k7wbtyPTcMeOypQZovVG/mrXxrzahFCVLL5QSwC92lkw+h1BjKAR5qFT84iFtO10e30ukVnoqYoVh48m6uVXsVnD/nE9kC8NsYjADRNj1AvNx89v9NP/dsB4eiRUywWfv8qJC6nYdBOdzKbyjPeb3sETl2OpQhiIlhSOeJPxW09drFJ17EgoytuUNl8tkDRT3y00qLbJeqsXpdGesEaKANulb5QzOqwLpKBYq/rRxrS2CjpFkQlEbSHVT5IzH/IXp3kurZ+Kl23JRJUZDRCVGWiFE/YjQ9g8hVyxeQ74ylYN3KHVjOhebD8bhlVPHXiWJ8YC+gyDiI59yG
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9524b9b6-7782-4579-3358-08dcce69af5c
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 11:47:28.9698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VvD0cXvN/SFEQuDsSXzfWF7kt9u2OqTawLhpD9IJEef0ryzyHQApMLkwYMc98bz//lfSO4K/iy85MrIgmLueCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3466
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic __memcpy_{from,to}io and __memset_io for the loongarch
processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
 arch/loongarch/Kconfig         |  1 +
 arch/loongarch/kernel/Makefile |  2 +-
 arch/loongarch/kernel/io.c     | 94 ----------------------------------
 3 files changed, 2 insertions(+), 95 deletions(-)
 delete mode 100644 arch/loongarch/kernel/io.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 70f169210b52..088137d75113 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -84,6 +84,7 @@ config LOONGARCH
 	select GENERIC_CPU_DEVICES
 	select GENERIC_ENTRY
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_IO
 	select GENERIC_IOREMAP if !ARCH_IOREMAP
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_PROBE
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index c9bfeda89e40..9497968ee158 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -8,7 +8,7 @@ OBJECT_FILES_NON_STANDARD_head.o := y
 extra-y		:= vmlinux.lds
 
 obj-y		+= head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
-		   traps.o irq.o idle.o process.o dma.o mem.o io.o reset.o switch.o \
+		   traps.o irq.o idle.o process.o dma.o mem.o reset.o switch.o \
 		   elf.o syscall.o signal.o time.o topology.o inst.o ptrace.o vdso.o \
 		   alternative.o unwind.o
 
diff --git a/arch/loongarch/kernel/io.c b/arch/loongarch/kernel/io.c
deleted file mode 100644
index cb85bda5a6ad..000000000000
--- a/arch/loongarch/kernel/io.c
+++ /dev/null
@@ -1,94 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
- */
-#include <linux/export.h>
-#include <linux/types.h>
-#include <linux/io.h>
-
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






