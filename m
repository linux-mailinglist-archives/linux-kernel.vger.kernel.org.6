Return-Path: <linux-kernel+bounces-337131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9848D9845BF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3802842B7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377321AAE3D;
	Tue, 24 Sep 2024 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="OCneEbsK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="iroC/xhz"
Received: from smtpout143.security-mail.net (smtpout143.security-mail.net [85.31.212.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2D11AAE37
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180094; cv=fail; b=P0zWvYnxa/l95knFF1s58+xjqLNzVaEQbVu3P0qNFYCjc8CRr9z5AIqjyKEgpckaZtPvQeUyhWq2ZBzsPdgxW5px4whWHG8JeB6iHimIlWo04EZIYngevwjiXExD7SJ9VFRefZ4bORz3qS0UaL8YRMJXOhLVD6c3+cAhLMJpzGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180094; c=relaxed/simple;
	bh=2obkPORmZBMUQ1Ws0SQuQym8aT5lkiXNf6lU5sRFwHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXr+pHrByr/pVwhI1PunoxmWj6AOY1rwYXcNDhF50N6vNbArYiabN/70GD7Io5wfgO5fCQKa0PDMXMd6Chc9+6UnbzoIQEbNGFNC1rqWltgRoKojIINIbIlVZO1VkvrN6PlFUtPZrCU92V4SBvdXo4f8gtzYO+D/4jRJ23QOtI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=OCneEbsK; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=iroC/xhz reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx403.security-mail.net (Postfix) with ESMTP id 334ED903E8D
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:14:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727180090;
	bh=2obkPORmZBMUQ1Ws0SQuQym8aT5lkiXNf6lU5sRFwHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OCneEbsKB1wT84/WoRtMzQqKPedTiJEfhEWkS8ryF/2NhXNDx2pOtshwC4eUZxeBk
	 K2kpcfYuwfbhAIJg85TujrIo7/85tqVRjjN1mK6rzOWvJJT1LNU7xgbmCmEKqFH0Dq
	 Uk8u1nc19jjTG4etsvOet2TWNQOqCAXYrr/aNO14=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id D3ED2903948; Tue, 24 Sep 2024 14:14:49 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011029.outbound.protection.outlook.com
 [40.93.76.29]) by fx403.security-mail.net (Postfix) with ESMTPS id
 B6517903D85; Tue, 24 Sep 2024 14:14:47 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PR0P264MB2391.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 12:14:45 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7982.022; Tue, 24 Sep
 2024 12:14:45 +0000
X-Secumail-id: <183d4.66f2ad37.b4b81.3>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsVK66fh2PeiwJvJsEhqOcIE34zAu67m7UwK3GqCFh0siMSEeYmrXDJSae+8pldqMnvqvACelAY+C/p1lbNLCBjEWQHqEk/P5Iw6IrSLEfqmHbrW6aIgSKaIB4rHfTkD/dhYCczBIgp3U0cpBRH0SGQC55XLqE157YcRAmtXd99t7Lt4Z8lGwgFC13q7MDN/PrS1ueoNTljiI1/z7ab587/qv8fgisALh3ii1iv7Awza7wnmBe6yVBVIyC796kvSS4uZvCMtSj1BnAjmWBz1Cgob0f75YC/zNvX7Y1AJMWxb2pzL33MSQfILKZyRLRB/L6WFy9W6jeEnYKbMfkPcwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QY8OUYCym0D+1vzf2u0UxM4OKV6Ibus96Ju0kY68Fvs=;
 b=UWUY29DYEmFHwSZ4wPsM7B9kGRMLUns2H8t8nrwPm+9df7xyBuq01zlNFgvlCAaV+hfW5/7AeQLqlPpo6E+AdOkkVijoH3qep6fBrXBCmXFuZ1k0zFEoV/P0+bVepHjxU1c+9H6gvLHQtE+tsMK58LKgHkUjIXF6JZ/5tn/X9v8vaY7OZCBvf0/5zhIZid4LEzZepizU1XbuoPVWlTfHxXRS5WJ1kSyyiKQnqaH7j1H7jOy0EIarU2gwoC6BemuInoufMXE5es5V3tdjUn5gc2wcaKGCStWOUx8ZukLucmrZAoZAiuTYtTWQ6XCNeGB2bMOHJgTIEg0VeGnOChUaVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY8OUYCym0D+1vzf2u0UxM4OKV6Ibus96Ju0kY68Fvs=;
 b=iroC/xhz4dvhNSdgpxMq8cm+nVojgFi8o76DvhgwIVD+icrBhqZ+9nRhM5cY97jVyXR45biz5/QEqesgcpwGDp58idRODQT0bFfG6bXuMLWwxiSMeIBR7Rb5lVRxsRguJgw6IsxaqpBE34zfAzgdgBB5yTBt6ucC3t+1p60RaQr+20e5uIOyRmuHf8TIR022nCiwPdbUinfGYeT/8l0o1pdzloZzhIC4G/oZuxR58G36DhuLMqplrQ9zxWy35bemdTCFzhwE/ssfCRZRX8O5S5joEaCq1NRVD4u6OlMzfK2L29r11s4a4GsdICrp/WOkQ7+Zo2g6vnViDGJ4Oq1zOw==
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
Subject: [PATCH v5 3/5] Use generic io memcpy functions on the arm64
 architecture
Date: Tue, 24 Sep 2024 14:14:30 +0200
Message-ID: <20240924121432.798655-4-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: 13c8b3b6-e0bc-4974-f5ce-08dcdc9279f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: GpbeXTTyQCC5ePHdK61dhCkZND8SIxJ9rOCv5ENJI7CjKrclwG+l9PzNU7Y2tRk6xtoQZDYGGS+ufw2izX2qUhq6/jWn7N3OuKufiT8CL5GoAcNVn0iTGkAQ6loaHFSH9ZE+iWsfY3UNHq8dYbA/ctn/4KpvQnfeuK24ZzZp4YXu6Ynl5FNdRbxmu6MwfqDvBKCQGPKklKZWnZh/eSdGp9wDbePZjIrY8JluaxTv6iUAVAxYmGsE+7Z2L9452rpf5kv11FHvge3VFNmoV9Gh4O4QUrTIYXrrw7gNHUyZsXG2psl+USCMoRB01EVmkO9B+4SK7fDlxV9SlGDu82kwgI1yO+sn8pzE6Z4kjoNZDMfChQeBCMzEY3SKyhXTHLhKynEzgOV/pfZH97KI8VP62NMoboEgfLV+MVKDIpI9p8isV8C/PKMewJ5n0p+9eFR7/vGfOnVdWaUMDJL/zMfLZSQYFS0qJqMeIqMv0EGNW1gLD+GTRUTkyui3VR6ppoJP58wnDKN97uD2ZmqOhGmZKJENCKMZHkkQa8Kj5GI2tHs+qw8wmTDcn0CSG+1R2IGMESW+hB12SRDO9MMZlK8pa4BnfqvcR0yY2lMvnxpCVUQ+qe1m3hwkbvItcbEvry7G9PazN/vL/1OihOkjLHltVSubvV3nZZPZfQXyBC307D1hFaWxuBO3aCOykCJ8I5CFxug6wKFiF7qVIVg6dKQR0a/a5Dwy9tj6VwzSwR1W6e+a0tU7wyBRwXiqxd/dgw/hhxJ6wzrCBDO2mBieubUzl+NM7vyXF/OUq+o1SEy1/9p0zNm4zFP/IDx4kmt+B9ksxjvFWodPwml0K4Q/wLsauCEetF3B8lo0RhVrxsuRZUw9YtdZFEXipuNkj7mh24SggpeGug7PJtMcN+ukFZNC8xgtMdwPG+VWnp3HyrUYjwZcmxsHayXDXozpF8ny3yd3bQ1
 7j9doO4P/1rl4uvQ6wkjkbAlbDB6S+haTshnRsZw2t8isx9E0743AI1FMPcY2GXyGR8+HXLr1KstU4rquX0AqSiecUnjkM9elYoEWaFs7/i7qt/5NHFX/g3JjdKijoq8y9vDB720jyHrrYMlgc0/PL5dxDa/xAZMW+s79bNEDeDeYDALQxSHWfXxxzkVJ8aRxWKm0oe49H5Bn+X5Tz/ZY15GpPKyyPiTgK+T7HdLLX2oiwBjmWLyOvHrqHdiWNtRrLO49cM92Grv6ycgn6q/uGWo7IRWZ1bB+Kf4AS0Bv4B7ohWhkT9m7FSXWwbEeroXTGowiOGsIiFuDQZSBAqPkEcGcE2UTKqRhts0YvvnZEYPcq8PYnMr80Y6orma+PCAGwiDIit/l2JGSccgMnftwmTTImjEmuHZ0jj8ql+aBEksCCyCzRSXNMvKCDwhwbohqaP3u7odnfNFgAHLDBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: erqcIbbGJDAoJekeIqoncRF4J8vAlNkcjFPtoqJ2hpO/dX+4Yb+h3xwAQDcxGxL6E1soyuDMA59P/bgPGyYZXdyV5CcOLMwj6SdYMHCt79Z41St/fLNtOFyKeTXXTEUpIcpBIpL09J3CN9dUWpL5ej3xE6W53XXRqCisp6H7g3Nx2zohMRXhJ3b61+p3PzIXjcHMjMlgrhKzAB3xBza2LHtgOw0B07wxwSPU69KHMK2m4BstO+9ZswPDJft6IABeYoFOzicQ2r+iLMjuhXlLFpAbgx/jjG/LiBUn0oPqmSuNSvGZoJUd1hp43662L2es5xClxxot5bFJCS6Qx9HY5MEBvltE3hBUO+eIWRVEchfQ7DVGN4xWYlM0BZDP+t7Tv4MqKhYDeboJD2p+iYZ0ilv5eC/ZkGl0Y3S/tlFBGD8wg+bDDF7rZQDnb2J+naJivE59XnQ7m18NsX7LG3gOoRkzgK8sD3oJFwz3xlfN5n2WF5Tol5yQAl5uaJ39QIpJUCdoLX3f6FvlVblktbf4HG1cRC6h57a9/+tFt6yZ2JwlVXPiuSc84WlVVC5aESxJqEVP2qyPjgYfAiJpxdtl/wBpgufLgh42d86Xb/4oFngj4EMJsFPGPjc/d03CitdeOEtQ3Ypl/BReF7E5SsUP6Dy8frs7JlM1ZJmZzeXWpCgtFRHoeT0YdhXmFHphCs5TvGAL4dKVWb64vX16MPw+TnZUg+OOa2g2lKCRCZ5A0AOE8dPq6Jc2ozOvmMy2yuWtaANVuKolpd9MGeXESXjIfz7pnDlAT6+p56ADXWn4ujCKEF0m7nk/jKIgjoTo+ZJgSWgJBuGuyjCc5Dd2FPFz8O8U7a/wtQvWoXZ4hOhDn+2hJVoshMTjUXvsp+FRiHZJYIlkMubXMxDDTSc4fXLxnVvd6bB3zt7TI9XKZWLmC5om9AG1zFpUdoBOGvU45LXM
 UCmBx+vECdGoQBhnrrYK9AFN3Rq+bUx/rOtXtyBKmhBgcEQ1Rk0iKi3h7l8n6QoiDrIZ+5YLkFWPMrotfvY+MfwL5K5Z8zuh01RuoKb9bRulnXTUT8KXcGJJKlujaOEZ5kgqWM4byZReIYsjB7WBmhSaIpvmLRtPdCVz3ykrY3TkLqnk0Dvv4VyKLdq+k4DKxZ5nQ+qN4QcNvTxKA7nUd1QYEQNhsOO9kK7HPx8eyksTt/q0tuvgFuas+CylVbQJaGa7zizx5ywMgOBV3ub2N+iHzH9QiLelWxxMJ/bVwJHbhJREbXTFd16o1GkFijEEcJQ5OWbBxO9jTOIhK3wB6DzoepLsu1Kv7FLaT9nWSmeBPEreLKPYmUZM5b4Oqx5Xi4J5wHQbro+jtCkXf2R75EbJ8VQrXMKHQ50J/tQEOlRvX12+WP63cMxJQxUMWogExdsqTjtsqTWx8j15Hk4PLHN7Fupeojc9Kqa+itd74sNsDw2Zrcrt+layscnaOqMX0o+1gsT3OoTGxJAv7aomJhhuPevft4AVRSVfccDGIwluS3Axy32lSrEcEfLPqE2onboPdT6Tbe1ZB0T1zT4CmUx+U2oxdEnNAXM5FAqF6SblkGEKa9N/Yb+FfMqYf2KRCFPFca9FnDYZZUUj3y1oEg==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c8b3b6-e0bc-4974-f5ce-08dcdc9279f8
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 12:14:45.0467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9LofSeFXdKu30QI6dNIbBTAvHDNRXDbimuXODnfrn7ysLXOhb9D2vksqlOZX9S8Z7URL4tW+rpd5eM5iZpXtuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2391
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic __memcpy_{from,to}io and __memset_io functions on the
arm64 processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v5:
- Remove 'select GENERIC_IO_COPY'
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






