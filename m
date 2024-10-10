Return-Path: <linux-kernel+bounces-359032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0859F99869D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC0AB21D97
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AED1C57B5;
	Thu, 10 Oct 2024 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Qsoa3ViP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="JeXiX1LE"
Received: from smtpout144.security-mail.net (smtpout144.security-mail.net [85.31.212.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE7C1C243D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564605; cv=fail; b=Sov/Q9yAt5BzrlYFNv0jbrGQl8t9fURScBVggyUoUlSy+mYZRffXBCknrkLGbylA86YuRjiPGl9vZISwnxRpGMIDk7+mcRmfUb49uGK68y27d+NFsTngfwQX73kI2WEupdS+4yFcywYTzefycg6cYLPS5n/i8ZZCPnar3gGZAOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564605; c=relaxed/simple;
	bh=ZTSa5eF3W1402K0h/xi5QUvCCPtERTNR0o70TnhcL44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IU3EnR+LZkBPxVlYeXwN5Z1bO29sRHR2ZhCuTX+Lbj1OTnx6VcCzII2ZE9BCyvJDHH9CiXLfDoUCJZMjscUVFHt00WHXgMJBEI7e7pNXDLSYpH4qWxQimBPoB/tykDx96EG9EqUiH6SsyNp5fyS/TFGg1Eo/dvIB4Zn5pYudQ5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=Qsoa3ViP; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=JeXiX1LE reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx601.security-mail.net [127.0.0.1])
	by fx601.security-mail.net (Postfix) with ESMTP id 01BB8349704
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:46:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728564392;
	bh=ZTSa5eF3W1402K0h/xi5QUvCCPtERTNR0o70TnhcL44=;
	h=From:To:Cc:Subject:Date;
	b=Qsoa3ViPmE/2lVnkokyXZhZ/KG3VmbBu/LqR9qBbyUhz/lWhBD74Ku1K7kxcUlU6c
	 xLTNYS6n05IPlzr2OyzH6lzNAaa+YRz21So4eJfalajZf+ITOEfvhPPTAd9A7O3foX
	 0i/FZ5cwgSSk+Y6GDCT9Fo3YLtMCfco7GmDDAKgc=
Received: from fx601 (fx601.security-mail.net [127.0.0.1]) by
 fx601.security-mail.net (Postfix) with ESMTP id D4C0C3496B6; Thu, 10 Oct
 2024 14:46:31 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17010001.outbound.protection.outlook.com
 [40.93.76.1]) by fx601.security-mail.net (Postfix) with ESMTPS id
 E6F28349972; Thu, 10 Oct 2024 14:46:29 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PASP264MB4793.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:432::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Thu, 10 Oct
 2024 12:46:28 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8048.013; Thu, 10 Oct
 2024 12:46:28 +0000
X-Secumail-id: <10635.6707cca5.b468f.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaFNonXCZCAuH9/Ay3iLzNpJjVftB4UTFwajDAFbdo40lZDobvoiZGw8nG7IptnYgVgUs2FiqXA+XgfPo2JiFAvH9igPhg+JqGTrp0chBymFIn8750Z24DkgQ4VPZKkc3DWB/7NehPwTfRIwcl0AbL8z4Qdm1RwVKd1lhQok8zHYUz0/PPgh9aW79MDEsdKKwglHl9fwTIIiWgS/1BiHQgXkaOY3K8yuZYsl88h0pQIepzUEFfuFyu7mGUA13tojZoo37FYg38W3ZXVCBJ2xZx+x69VzFGNg3+gx55Hal7NDNn14uo3uhP4kfzRwgt2NYJJhT/2Lphnyzy1jqmt4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nns6IfU6iZSS5Xhn9RqtJruG10S4MtZGeqhbL5xN8ac=;
 b=locBqyMV0jLLINuXUfFCuDZKw8hy5dhSYRBHGzig+Ayyjwz4qqjwXyy07nsW92TuDDVTPCHhmWxswdhNuQtQV4/6Bl62kSnOwHttQIYXWYg0BNTGgSpICcFOop0kHPfde0MC62Mw/2linwHFXURm8T5ho+KpjT/UrylTAbJMbFoIFIT/6ZiSEoUbWlj376tAVGqFnoz8WRs85rCdBw+JLvmhTz9dTC+c1zprbzRLFEpGQn+yW4d+7mvQo7hdPzz/WP/cNl1JWZw9AkA/+lkVZgA4DV5vp9Q8zygeJMPMsiHq0QKrq6oX/xwlY6DEoBphk4WxvHI9RtElLmqZ0yohUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nns6IfU6iZSS5Xhn9RqtJruG10S4MtZGeqhbL5xN8ac=;
 b=JeXiX1LEXW+/xeza5NnhOHtUBGOTI3cgnFQ+aP1nfPFsztoTYm42atLOZ7DigsjzhxTaCQxRF7uHiTwITKyYEaZOolAhITysJhTJdBZbp8QlwT7b9MZUuVck90S8Subgcetxgha5W+uO5Yv9Bb4EzT6k73r0d+iLQecDJOLpgPQSYEgCWjpTOl2kgwoeRaUyjFBEXqrXUGU6UEdfSSMV0B0VAiIi/aycMjUlKO94dE4DbPbIoLOLPmWG/7ZRSIInHEA2urEggZ3oSWGFDl3GVBh/lSDcbU+odNuBtcj0q3ep8SF4fl4K1ToWsF7PpOLEHc6P1HuFZWPT7l3qbAe+ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
From: Julian Vetter <jvetter@kalrayinc.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, Julian Vetter
 <jvetter@kalrayinc.com>, Takashi Iwai <tiwai@suse.de>, Yann Sionneau
 <ysionneau@kalrayinc.com>
Subject: [PATCH] sound: Make CONFIG_SND depend on INDIRECT_IOMEM instead of
 UML
Date: Thu, 10 Oct 2024 14:46:01 +0200
Message-ID: <20241010124601.700528-1-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0084.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::37) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PASP264MB4793:EE_
X-MS-Office365-Filtering-Correlation-Id: 057cc345-6685-4c42-73f1-08dce9298f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: vFkKxQpE538MrAZSWk/KveIQ3XIW/wxv6VrIH3Kw3ne19Je6bkTZSJ/VlvVaH6h0LMwYXMX5cggbE43JbauH/1eXdTV3LC8bHk5IoUEoru38ZqRryNTvOJIeLI3t5bTkIUoy8VmoL9ES5L1Fu6bckamv/GL2R1nAaiX1VbYA0vONHTB8cKf4UF0kg4XFmBtdsoXLRh9XAD+bWlUeR/GznBgSHXY4ZY5hlJpPB7hjggQ0WwNIrU2DfQ+y5nodlig5Pq37P9uzESM3EM4EXt9wZfCicBxN/F82t2rorfzqXek/2m5wAchDxKfj0Favby/wsjAZ4I9CgilQijti7fPO3XxV+KOSOPfOEprJ0+L0dSFJMn0A7AnFDUACjhu+KgKCAcRCYVjsHYMzDqOldXssbqzB6oIzpRW7VUOpconPpSHB974tBB74wfFZevMrQCfWJ2C+SdeLzdGUX6qwVoytJD6fe6WKVwPodvnHFGZ+QIKCFUdsn9saE5o/l3YeCvmFzVtASWkoBSa0RcNWtCVIJhNYW6+7mNR2Q0z62M0A+JcdzCwtELnJb4W/wQN0szzlopsGw7gP+GVVm86asQ6aG1+o/earXT9+0IaLJZpX8hHMSbI91WO1G6PPqFKzzvYWVx6+w+xXilqG+Ih28sVMwwFWeMfmLYv7t7/+BZZqZgIWxImTCX6RUmT2cVoOYirkuEvhrI1L4Qdy+7uGh/mBCe+sDIQcedyN6nWT3b8Lp9i+UNPmPlqMjA5ST28thkIDZ8q1zJqlUMmIlizvOTr114zN8024HpnT/+atj3j0WFOHic0sLElk4ySw8gLXfNtFuYuAnrPi1Y57mt4pPX9Q4h04OKcKzFWdJ1OhXwDl6SsdXL87b/ox0DfBVVcG6/0nZ7qfGsFry6/uupiRJJczYX8L/XX9LVMytJIEomsW+ozbPwx62iFUyR6LdEZUKI0c4ke
 ssR1n+nUyhdOUgHgb3jIBXc83yVMi+AkygkeU9QpypRbZie4ASdp06wn0MJqRxAMFD/5yY91gN0Mnr81iINo7JaiF3GV2QCEp4xhbpKQR3e3WzHvUIGBekPqf0wf7B149hwLlp353aTsiJ7aOS1ZNVw3tvTa0D1yKjTy4ioTzdurVBFi19lOf/q+ahdZLaxoQTgYhX1KfKLNIxX9rTazt2iG21fk5BjpmUu/Br8o2MZuNk+fifpWkDIvLLpdJ4B/n8agoQRzXV8JBg+A0hktIFEf4ZjFkxs1TYLWew13cJ03v6Y9qoqYnUbvZ66lH00mp98yXU91dTKKaI76l9WQoYHgaVH6yvrfvk78GRPq/GG8/o1Xs5wqqUGBv73lw/DbGM+Tl0a5N7lIPAPKdUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hyTUp479ZZgSROVD+e4dL+04y18dC8FYMDOsWeed4p9OqlWYMUuMjTEwkZg5mmRi0ufFKb20BdDcW7bh3BnTMw3nxdpfxy2/Oyo9chVZ1nrj6fqhrztBGbYWrNlPWBTaf3qGaGHQOP4LdxNAClfI+puSm14P5TLmrMcoBD52FD8FzhC9j1b1fv7LfS3uGNAtRGGJIi5YgrqQj2igvQ8Lm9QNsCc8BLMt2qmsQ9c3k5BHUspN/zZHEz/nLLDZV5OqwyPiND/pfpVNx4Fwlep7gIguGiFSIRhnFDDfJkocLOoSUpGkyGJSntf8fH4bBKexdh3w6U4aEOjrj3vxXm+HUBGPKdAna3Ecyl7J+bzCd4UmTgYFuHA5GsBG+VzDwGXC4/4CxNBWY7x1AzjBXJXl53jgvnAJ/hH8+wrGhlqPmDv7dPCuHc1uDzs1rv/3AZlz6ftJAnyOldDddPrqoZMHaa237comV6N3vaer9ww+Bcy7xPhwOIBgMjTXjGXsKEvabN4IIXLmqy5H57dEFVi1DS3vc+j0DuchHyty+blD950krqqADf+VluqNLLkrx0Nawmhn1TaoyfBE/xzMJFUx4dyP7w4+v+dHFw+mVFdlYjE9SGPDVB072M3enxZ2+Y2O1ddt8GfDtYrzpPp145tcyy/dgkmAwRAHYWC3XKEwtZyYR6/dDixUDrE4vkhQVt3hUgN/xw62s7LJOEMs0LhfddJly+J8wbOlJFWq2Bp9mNv2ML3wX9m9y/uUxnKl5/GlFsXn23W5K6WOu+mVicngAxxURhv2tOc5FkjH9pTDpGHy7uv2J/G5vJe+UCquOVieDyaPBKpVwKHljGNmI/QGPOpawqIE85HsAOWw2rJdL39rq3H3RzC8NNbBqq5mpW4S/qVWRTObQbS4TIo44oqFYBSMUrBr2rK+6RIrA80YR4cpVdt4BcrVz43BzJjjCis8
 AUWBlCz2Ts1pj/znlVwZSYA4IuM+Z3l0Nd53lcuRAKxPBNv5Zvxgp9bVi4K9TfnE7yhHnW4NqUPbvI/I4pMogrn3CiraMSSrdTohDkdqWr4+WwKY3N3zqUftHdWtsxbglunClKJ1e9PEE8IQkl5qhq/vYSmY9sS1TxvB1Q+6rVJGYN2ZcD/oypCHkZpGoUqPLIm0u+s19MGW78zVvQkLz9IyUvMmaJf6087CnAvQ37wgD4t3S0NlkTwnD3T4wcYY2NIa/uZNmpifFsnU383IzJwXci7vWkLnJfbgHsC4Yo7KG7w16FgMGQGRKCHTKHvmSurxsA6lDBkgyeTdMVwVXWa3YtJnBxh1Xzry5CrBIUfMnzdAlDJrxKPR6Ix4UUrlGBFfEpkKWP6RZwtZM1V08b013ffglJ1iIcZQBq8SkJ22a615WknCIC2zSWm76qCbuB8+FBaYJ2Ed2kiHpHBkjvchihyGq2i/zkC8SMXY79kaiIOa4SgBCM97zaNM2J+ad2qUbbWh8qlDOhrAse91gSTHOsWfBzM+iYLVAwXxgu0ZzyTHWnV++C9GOo/loHGgxNdZ8gac/2pO4ig9VRGWw5DyHXXjpxLNVG8R1DT7qB0eMWgpG5/xcguzyXZoSL5L
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057cc345-6685-4c42-73f1-08dce9298f1e
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 12:46:28.4999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rsPjkaUO73ZleRTwqx7cOycxJX4x+nzSuzITzdwcKpHF0S+Xd5GMlerdYKx6ejpWYXmSm0CDzpWMVskHD1xww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB4793
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

When building for the UM arch and neither INDIRECT_IOMEM=y, nor
HAS_IOMEM=y is selected, it will fall back to the implementations from
asm-generic/io.h for IO memcpy. But these fall-back functions just do a
memcpy. So, instead of depending on UML, add dependency on 'HAS_IOMEM ||
INDIRECT_IOMEM'.

Acked-by: Takashi Iwai <tiwai@suse.de>
Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
 sound/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/Kconfig b/sound/Kconfig
index 4c036a9a420a..8b40205394fe 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig SOUND
 	tristate "Sound card support"
-	depends on HAS_IOMEM || UML
+	depends on HAS_IOMEM || INDIRECT_IOMEM
 	help
 	  If you have a sound card in your computer, i.e. if it can say more
 	  than an occasional beep, say Y.
-- 
2.34.1






