Return-Path: <linux-kernel+bounces-337130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0A19845BC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9F91C22C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B621AB50C;
	Tue, 24 Sep 2024 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="WqD3AyEm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="dV7scw2z"
Received: from smtpout143.security-mail.net (smtpout143.security-mail.net [85.31.212.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0D31A76B2
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180092; cv=fail; b=C+GnYdL5etvhN+xp+V7f3g+wEjUDvbT/J/pzHtSsXlgY06Br/0ocal2bHwYHnW8alDOUHZKiW09jgQt2Jh38jOVs65eLR0BUegc+oKhmPiwDnQxrfR75gULChX5dmHqNJ7uQJn6r1JaILuxuvG0sUjfYm/2AdME2FsMo7XNbO54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180092; c=relaxed/simple;
	bh=SNwdxDHvn8jf/lAUopERKt5pkWfYmeQpDiCuWVDpsLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqfJD/QTgFdWmrWNdq+e53gII+8CInHJQ5ncZlpDe8Jz+iA3vAmWaUcZhueMK6YBnMtjZNoMNetElY7w5c25hh2BnWnz+TtT5OrqM98s2hOjS/+UnbzZYD4GRqAn0XosfPias8ZB82l3RpUazYnUzrp8OV9QR1UowD8OUE8K7KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=WqD3AyEm; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=dV7scw2z reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx403.security-mail.net (Postfix) with ESMTP id F0408903B27
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:14:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727180089;
	bh=SNwdxDHvn8jf/lAUopERKt5pkWfYmeQpDiCuWVDpsLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WqD3AyEmw9Q/iklh7Rb7nw6Ny74IYAeQMV0RQvSdPplOygyWpgDlBHOINr0zBU6r/
	 mhui6cvpK8pf0S48tSlwOcaJ4ZCwBI7RmpzI2MQwP/GqI1MVbE+LKyDakqfL70AfnW
	 0wn9eof/CAlNfQLIXg9amfdDO5T02WosIFLHxzF4=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id A03629034EF; Tue, 24 Sep 2024 14:14:48 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011029.outbound.protection.outlook.com
 [40.93.76.29]) by fx403.security-mail.net (Postfix) with ESMTPS id
 82D8F903B8D; Tue, 24 Sep 2024 14:14:46 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PR0P264MB2391.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 12:14:44 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7982.022; Tue, 24 Sep
 2024 12:14:44 +0000
X-Secumail-id: <183d4.66f2ad36.81085.2>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uumk9wZElWguzLOcC7xzmKZnTy3ttvdxa2Y5vEfZe+ARdSj62QnF1gRtye1i/PmoqiCq2wXwkxxMAftYhetFo6+9jkwHM0AOyVvm8gRaRBN7xg2UIbOGa3XSGttOL6FR+UoWp7PVOtQfoQMvLvajVkqX3MTTj6yPCrB1VZnd12ODOO1mPJoRxci9XAXUQ1TxYCoYqRSd5JqWZYv8iygTlr7gvGvfqXl5818T3Z9oRCodO8cBwiw3zRGrLMVN0WcSL240aJFhymvW2Mh93sncWPMlcpA9lQa/E/jdC1h9v6S4OsVehNZncbBSnlbj4tSY9fvE9Oy2/b9HjtFAHippXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRmJvYAJTqtUxvy9G9oJDYhDjiwT2qQaGFAxZDqB6j8=;
 b=gyu7eDDbbwohZxkTUYRQzMzJvVmIwNKAWSmkTnL2KnlP3cWliMrs/UjfZl4Vi9yI5DYoA55TUoCfO4EhQSfAS3FA3c1SoFUcuLXGc/CmdbRuuV4v1M1az1M04W6hgjZUGXhXfnxoUdhB6FElQpPE6cUdiPCAlirph+I12M4bSt1TViin+0jfYl4cST9SG6wiKO18eN6zW1gBLlNT1TqUrSOaJL1uedbZVzxffCh/Xf534xMlPapyPWobqI40JTtoZ986LrbnpS2/nfjMk8r+MGc0cd0HZAtTivc66uNTZiBPexZfreOqokQe0tgHN/1QHlWqQ+yO3SvcVftd9GjtKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRmJvYAJTqtUxvy9G9oJDYhDjiwT2qQaGFAxZDqB6j8=;
 b=dV7scw2zB/3NeDC7mjplHWID1yFuAGGQn+iLMvD1B1xoNcKbyhay5Z26Lly+N/ZH2Qy9NAAZE08hD5ORwq51WmZeEEr/aAfV86Dy4V7msCndmHmSLRiyITAO2v/jjghTAXhyfH0rVSJRgfr3qkM6nEikZE50UbmwHOkKN+U2fv/Gii1iohEUe4eTFDUZC/e16qMLCBwktKfuThNHw3xAs1jLBxmF32x5/jatYEmJZfHoQ5X9bjbYrLuQAaPMHDN+ebk73njYjmhSxYD4Q+L7xjbwzZblNKN+uCRiOsJ1DY2GLNWHfdPsbdE0PEy/GwPiUTxKJ4FloQ0a3WvI/P0hfA==
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
Subject: [PATCH v5 2/5] Replace generic memcpy and memset by IO memcpy
 functions
Date: Tue, 24 Sep 2024 14:14:29 +0200
Message-ID: <20240924121432.798655-3-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4dbaf19f-180c-4abe-204a-08dcdc9279c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: VRhg7jFbt8iEjkSZe1rbc9knum4kRKHIyaIt3zO6gh66kYaKszVAHYck+OpNQbIyEMT6xedotT7SHlYXGevwlHXoSwXMgoKPrh+j+uwJPIYYjA0yvRsqVfSeSJoBZQiZfa+mchTO91hjk3U8lC0h3kNo2tpXLoFSHpmr76R2Xsd6iSr7cCaPbRojGkPPY/9DjxKtfyxqkwCsXNLU0f7ydhAnvROs+dFXd744oV0sgQ8zIWUg6kRSiNbuAPdZoMJRbAV2l3MeCHmbZOrQmu574l2VFtadg3D5r0SybIiVsobszp0KELQ7L7Yjj8q0jSG8PcSvKDzmQjfDPDRHrau1TGTpjStd2PVYXVpp+tB0/9uFUnFcxVLdWEkgv4vJ3deBeyVv+skKUxKS9nVsrQh3msXzY37I/h06V+i4ZhsmMumU7O0v239whipjZrGtlEtw7mKtFe4M6Am1YJiE4NnVtfh6xHmeo5NtWPrAIHFmhdG439wijTlhsjyWfhyWst1MTGG8n0So55jstyeiLekQPr029ek1iC37dzoQC6Nrrsshj4kiJZvaWSOAPnVPmM0cMaJOM/DRgV53R8NLuEDt5PZJr98JAStDsP87F+NSPVNUwIGDDfHtAAkUrhYQxg3IZKJwMgp6Ay509J+nKs5+cqrRrWOdCrm22OjubD3TQfriyxQe1ieHy1aVBJ0TMEyzZtJwP4StglmL1EUTa8gF+fsRBadqyfZ/zbAXeI/GOnLasM4BZBq8iRepM1sKIxboP34ahgQNk8maku5KWhP3WdAlDdwB5tgespIg93tNs5sPIjpiU+o5FVuc9zTzfmsJZb2ocWfqNBPfIquSDt70OVVxyBMTkUAeHTz7S/7oTlQ0UwLLGshkzcDLwq6iybxtlBWQoHyzExvRK3Qh9up7zJLr9gQmbJ+J1Ao9Hho1HzlVk4juAH91Wei2RyYQUnF6Yfj
 mxzhvM6gnroVm2UPo0b7DKc9FVo8bPI8jOWF40Agu/kcVz3Mw7OIWrXGBokpC4+KEZK/l8149ot6rpgJ8YyYkaGszlIEBdzj6RR838E/HHMrdVklQ6CHuyLJg6V8QEnR0PMymOaBGt8sW8Jtqoay6IWvn65KWkvorvlWymSp3ucz+UsgnaiPnTTueAd82cEUoOnFf7tUakpDskeF72HenCdqEqLqFTSALLlDCbW7M0hM9nwA9L8rmm3QVj233FN/74UlpZ4/mg0ixi9iAYmiB8YZVdiIkXt/QlIZ8mhR33FDuTgivNKxU3Ffgd2RJ66w5n+jqEYLvR9EBq0aeNXWPJOVocFLJjUJVweX6FWLj8sQr0CfDnwySjBmHKGmLy5vH2CFvDglbpE2+Cck96QqpyiicMEedki1iQgkgdPIt7lEiNhdAK1Q9BJv4ZS+CCAhg6V+Q0LrxpDd7UDwYUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W+M7bl94xPnjEMKxhBx57JWr00v46T0YMMQi+ubydYnTw5BWpCH+4DZIGH2ewAf51ov5A97L8j4WI+1bzujsIXCqGP4yvsTxnXUABfvoDWGKAMBL2JWUCMEL6beWyc5SEFobHVw3ub0TX85q2WR4vVhlhwSYpQ0+zGK8q58YTDMOXYIBuDf5FXa8hann5g5K49Xm8SngnVFXE5gx6YGQIlfhrkINMOr1q1k1YlHxGOH9KfPN+KrEt3vK5F70/A6TBH8O0TeTWDqBx6gnQ8jHFjlBQYHcvPLYPZWDvujfladRB/5C9/On8DgEk2KtE97Vnacop2JZEqNw96+o2FZumhJteqjoh16Q/XjWWUqUOH6fBCFIshiRdb3jGZoQr0gtDoxo9kCm5v2Lz9I1Rt05PVn1sXeaQUELh9O09P/Nq1g5Yhshhf1+70mvv2u2/8g5ucgbMc7Dgiuw6+TG1MzWhiPtM4lxunmRBnSLkXYrfsFmKqSb5GhpkU9HRhShE54rl5Nu+TCXT/NiIxCYR945452PhYbSxudsLGuHA/yID4v6xro5tuxuaS24WCSnzV+kIo3R8Bb5Hwu0AAtfxad8Ljh+4bX/CnlJ/995Jb9lUzrI1XRFTGH6CMOgmMewx4t/O5y9Vq/DuYcu+3q0FIdwOb9fhZwhEekgg7a8U/bg1i89eSK8dKgGFNpnsLKlxzJqSugCx7Icz1Q92xvIUuXc0X7jZHT0GsvoVRg+VfCohofBtuQUtaHikCfEgf/eccOV12mEv8peTm6CDnbdHC7CGQGbuz2jrxJmOGgAkcwiAFlAuYBCzIJHCA5aihz6dcyd4gsC5hZRKcXOcYToN0BCuC/PAUxlJ7NjsdQtYn6U0xdE3J0k7D3kC9BSmb4+9hWvqan8XXEA6mVZG1/tddAmcjKH+DCiSVwgv/YKnwcjsYf7cXPqsl8cwvU2W5DZNYMj
 EjJTPE5IN2vbClEBymDwW7iCq41T7ye2AykAr9YvKgvCQxZt5NIBp6R0wOtIms6nCfdpiIlgMEnW7rA64ITVaJG2kBS4Yg1HbUsWQ6RyiMaGQTniMvRXznn6yqB0j2cdGBSGMaIkrA4OphpERKHcUkC/Iyw++OGbpJG31SSj746R9aAoOyUWmDonCLGWdQeTYOxssWhMpx+gcK3zubTXCmiUjlJE+Vqug3CDtI9EU05Of0L/B5UHCg/wmaWV3KQHcl0mUHoOpolZ08AlydSip2wmQ4t6ZLCQc9wrXdmlMNf1MASMu6G686VZ1h/xP9tMNtmimfJKQRsmjVj5TtL2ZGdkAlg+7XCljTd9mLNWMDSRBXH53mJSE9RPTqxAG5GIFHKodtP8Z2sDTpnuQetiO40EUJBSw6eijgaXjseUOYFdGk22gq5oWV/+ITI6iGBBsKzNI+7obnUzanQJO8xottu15XPCUzMLQPCNwL3glNLEiy5hsIYSZEJoERLZeoQkbhBBt/UiefkSU7X4z28DxHoyXOdaX12/rRzisi0YJLa9u+SVRchBycG3dkWgXzhw/Sd5zZYKAGrEtVPVU613SkuNmVxvdsnAEDDrJ3M3qkw/7RRavba3O/JmF2EduCRJH2qVtnFwfLQWgLTeBdGFTw==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbaf19f-180c-4abe-204a-08dcdc9279c2
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 12:14:44.6786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2d4Q9L3yhU0MtmicAeCW4H0PVCgL77Tp4/ULoBb1EUoal/7Sc4Fb60EN/Di72joG7yAyUK3Bjft0im/KEVWJNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2391
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Some architectures implement their own memcpy_{to,from}io and memset_io
functions, because the generic memcpy_{to,from}io and memset_io just use
memcpy/memset.This commit replaces the generic memcpy/memset functions
by IO memcpy/memset functions that respect the given architectures
alignment constraints. So, later we can get rid of the individual
implementations and use the generic ones.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v5
- New patch which replaces the "generic" memcpy/memset by our new
  __memset_io/__memcpy_{to,from}io in asm-generic/io.h
---
 include/asm-generic/io.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 9b8e0449da28..3b7deb724a2c 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1175,7 +1175,7 @@ static inline void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
 static inline void memset_io(volatile void __iomem *addr, int value,
 			     size_t size)
 {
-	memset(__io_virt(addr), value, size);
+	__memset_io(__io_virt(addr), value, size);
 }
 #endif
 
@@ -1193,7 +1193,7 @@ static inline void memcpy_fromio(void *buffer,
 				 const volatile void __iomem *addr,
 				 size_t size)
 {
-	memcpy(buffer, __io_virt(addr), size);
+	__memcpy_fromio(buffer, __io_virt(addr), size);
 }
 #endif
 
@@ -1210,7 +1210,7 @@ static inline void memcpy_fromio(void *buffer,
 static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
 			       size_t size)
 {
-	memcpy(__io_virt(addr), buffer, size);
+	__memcpy_toio(__io_virt(addr), buffer, size);
 }
 #endif
 
-- 
2.34.1






