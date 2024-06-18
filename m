Return-Path: <linux-kernel+bounces-218925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EBF90C7C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5981C2229B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98524156968;
	Tue, 18 Jun 2024 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ugTD0KnE"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2100.outbound.protection.outlook.com [40.92.107.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C2915534B;
	Tue, 18 Jun 2024 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702230; cv=fail; b=VbtKDLNZGiYit6gtk4n20y5taLCe9pnHPHRp27QX+lf0Po7WP/9qT/Q7bVww4oxduS5pudI6/FT+GI9ciDS9VAWJGorWs0BbCjO5AL1TpWpDZepp2t6yvIJgAh35wqRKh6c8uVEYvOKFwmoOzl0qNLtygedG8RnXMWjv/dhtTi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702230; c=relaxed/simple;
	bh=xFmLypzc+gzaJ1XtfAmnvldHr3Zvuvl7Vht56zHhGV4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=C4G0dp+zPF2DUbvLhAD5gSGSGfI78J5Te0Ir4ImWySqawsU6ap5JRdN/rlEP+siayRwtVvP98F3yv0Vo2X8gZfVjA8ZN05B3e/7NLUNm/YhFsL/Y/COO6lcq/+k1V3AJPL89Dmibjn+GLW1++V8saTGlsXqOFJZD+BPc4wP+ssY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ugTD0KnE; arc=fail smtp.client-ip=40.92.107.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOGxTsngQDZ8k9IYk+BiDybgQfq8e0rtiQqeEtQ+p/y/PvkNohDwoVZ3K9FF5nIjmCVnh6rnV5ptlUf9+l758QihhECGCJ8bBDvYhRnqhFbpwOxJsEr/q7AUvafHuIeG9tLYkXvPZe3OFdCIXHgqmj1vgqBXoCNan657DZaQkT9iYFASKl7iZp8N41QsNZwx8e3UUAdamuy1dbHiOeuMjpQo7wWA+7OCs2ZNrRX0GZPQSHgpHj9M4/wntL8nHXdtwSZ5bXxhKC8DJ2ikTG+Uzr4zABDhzIFZDKiF5YHa5q/H/AiePiDKeUasHOvln8lifi2d/165BBnE9/4NRkFIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9gFX9PH8ymN0VhgCGvJdAp6CGOs9TymHUHRfKVkU8k=;
 b=dyM2MpK1qn7o/g2KulfNUCW7HFApycJTpqfhkNXiC7KqNlNYNdYKBXzLdJNYPHsnWz6L7zjN7CKkpjYDFx3K4ZZJjHATTMtLLo8ZALN+pQjC12gtNybFq/XiV73ys88iTAC23liPRrNYliFm/vkoWMXZB4in3dBYiSUGZnf0PgX+ViqzTpLUUjjajCB1oum6f6WCIMmkND7kwahblA6xLic8ZW9p0aVuQKKrfKXAE4peZ/BAM1/zixx6fgIhAWzIxAS3qi1sKqLhjPL9BVqfjuXjsAXJY3g621HhO4hQtia8mH4TV61e0+6lYXqct8K4JLTqLuPv8CeedCwG9Eb8Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9gFX9PH8ymN0VhgCGvJdAp6CGOs9TymHUHRfKVkU8k=;
 b=ugTD0KnEAQwU/K1ohw2g2z16rO+m/dm/+maGBVp3hMFzc5Za8fF2LbofULW1v28snfx5cDhst9hUJaQreY5Uw4JWkMWY3oceSoHvZpYun486ZjWu450ozRBlhsm1DRcrnWBIMfIafqfY8UldIxcJmzVnnyFWQD9oxL2RjYvs7mUjGVZPBsoOuFM2lO2Z3XWcn2rtifop0fq1kdRO4vR0i5Jxdjrn3ejEGzsS1gY//4klmHHF/aveB/bODsdbGDpGCGblumGxE4pRfsakCxa6rBGii4EOCI9NZGiic7qucwCeTQG6/B1/FGArgAUgF/FJPh6/QIjFgPuIhrFqzI3lfQ==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by PUZPR01MB5211.apcprd01.prod.exchangelabs.com
 (2603:1096:301:11e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 09:17:04 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 09:17:04 +0000
From: Haylen Chu <heylenay@outlook.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Haylen Chu <heylenay@outlook.com>,
	Drew Fustini <dfustini@baylibre.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: dts: sophgo: disable write-protection for milkv duo
Date: Tue, 18 Jun 2024 09:16:14 +0000
Message-ID:
 <SEYPR01MB4221943C7B101DD2318DA0D3D7CE2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [jkxzcdSKutfol9wnu4B+aRkhLwJkKbPd]
X-ClientProxiedBy: TYXPR01CA0064.jpnprd01.prod.outlook.com
 (2603:1096:403:a::34) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <20240618091613.6221-2-heylenay@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|PUZPR01MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cabb948-67a8-4f1d-b9d0-08dc8f776af0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|440099025|3412199022|1710799023;
X-Microsoft-Antispam-Message-Info:
	IatyqEZaUFZGSm1cSGenRXyQzZkV6sy1Ti8eOzj1l2mmPQafyxwXshd370Y0GiZkVq19ZdLModyInwLmc6KtOK7toLhw0Z+wdQi4PtU1GRbS/tDhAyEZgLjyXPnyNqy6gDW58bf0I9Pp0wt4VtQI+i3deUhHO3V13LpP5dLOgkYQrXciJMCZGtMIT+W2ZbNg6QeS19UYV7o1fSXTkBsieS7YCZ7E7l9wE2i1+921Kl0PfLOSYBcOvfrIac0mGceNAuuGDhxb6/b96dVwyBQ7fXbVbkQkFfHhhFWlxKoOh1hnfrTlGUs0FTpS8ksX/u3jls+1hDTfftE9xuqQp4O5Syb7wrcbK6F/ZTTVrk6kNJDKZrfbHbBcvsv0+5ygEJAIFIM+eZy7BMs9PI6ADV+0ctr6/GpWJgnLg/nh9kU79ggjoF7G0AgooKICvwE1JwuZ1O3oLtEDIu4o60l/qsJ1HkQel16LEv8Y+rS/SbnNJwIpxMaH564e4OVvP+IapM/3hhQvXI9Z0g5r1UEq/iotLq3Z3Rjbczbjcf9dVk803szcVbo5xez0lJjsANQpJ/n+tPMN8b5imenL2DOnq5xM2AuYiwEwlBpB3RYr7y/hZGg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rNhztLSCu/ecAGaA5mtlH6/u2ITUndf82z6iHD8CMYbiSJmiDoZBT9xs7PNR?=
 =?us-ascii?Q?HeDquWhkkwHMaUUFbdA8e8qPYYhNW1tqvg+pdaz+g/6Wss1JqKLpfRksl1Gy?=
 =?us-ascii?Q?m6XeU69DpRcPAKA1aKiK3JB5zy8obYLAWkvxiGHJ9Cjlj2VLM3ZLJ3sL5Duf?=
 =?us-ascii?Q?t0e6Z3yw0wIqQJx88e5InSfkKTnlQMwuKlJF5x1/Mq3N6/m2iaFT0dWXBrwF?=
 =?us-ascii?Q?Lb91CC6J2WOk9+1o6e+pYh/Qd6cE3TAXrAKiGGOYxRzBJ9lk2SXhUd44BTAx?=
 =?us-ascii?Q?+7zUjQ8cLmyR/ak6DkeQ4L/FvbxC0E1tYKPj/GT08cv+5oBQ5AXwrG674DLO?=
 =?us-ascii?Q?OKhD/S7OWfHQnF/r7Ot1COD3AQb7O/AEi0nrBFER0+1H9asMhHERxSVOGDf2?=
 =?us-ascii?Q?DoTSeKLfFuRMhM2dB4YIK86n3xu3cLU09kHFyeTuxPA+hHrA4RknZ4KzzlvE?=
 =?us-ascii?Q?BMuqLLzdKR45ji9DrdIrUmmG7qQJE0f9AC9YBOUMDi+iFjEu18BQ83uLUloy?=
 =?us-ascii?Q?1nj6EotUsCaMHIu2gb3/G7WFVxff/884FS48zj5VKQpM14rcZsO1kKcx7rTz?=
 =?us-ascii?Q?BEk4/KdeJSibvsJQ8EapWdCFDWJjdn51XO+6m17jArcTPPrlljCgs4NMlhRP?=
 =?us-ascii?Q?MSwdVGH5yyiUfJoSQUgrUbxGpz7aAeX90AJTFRwRmZ8Dwz6bwT6H85N/raBP?=
 =?us-ascii?Q?Qm2nCRAxz7FAiELYS3uwOSEZrqBM+NFWI5s8Jd43odGkJoMWViLoHYfLNxW0?=
 =?us-ascii?Q?45lZEzN/PhOT22NOoVtJetCm3WOCNkEJhh7Rd3BvtiDRAUqsVm2OPr/XXsdH?=
 =?us-ascii?Q?9wL7YCrq9HxnVSAFNQ/mDs1TfjuCJHBkG971Y0M3jhHyH0ySAHCtr+idZtZt?=
 =?us-ascii?Q?3cj3JUBUSJIDLa5iyVX6EiX2FYC3D0lRZ0yvi+Bo3G3xJHgNzHtO1FeAwqqh?=
 =?us-ascii?Q?N6LDpOGlAEvb4W87aY/tf3iP/a7xGgdRGe5abodaQhZFfqeBnwoFVfx2+O77?=
 =?us-ascii?Q?bLIPrDN7ZSrBYPrr9Rww/oVyNleItuI19sOND9pvp+xSQaIMWi0VDp/rD1B2?=
 =?us-ascii?Q?8qbhsgD0XIcBouRCoL1bY/XaqVNpmcg4/vgpvR8USdvx43HaQn85UH2SevBa?=
 =?us-ascii?Q?2jq+t2Xr9+iPka1pAelLuBL3lk/MiQayFC3ioDLvIlUTdLx/NsYDTe0oG33n?=
 =?us-ascii?Q?JSf3e/LH0TqPMLYRxJTQAVutdeHnZcpMRNNl4T2J8SUw1R7en1+HmtnE5t0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cabb948-67a8-4f1d-b9d0-08dc8f776af0
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 09:17:04.1521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR01MB5211

Milkv Duo does not have a write-protect pin, so disable write protect
to prevent SDcards misdetected as read-only.

Fixes: 89a7056ed4f7 ("riscv: dts: sophgo: add sdcard support for milkv duo")
Signed-off-by: Haylen Chu <heylenay@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
index cd013588adc0..375ff2661b6e 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
+++ b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
@@ -45,6 +45,7 @@ &sdhci0 {
 	no-1-8-v;
 	no-mmc;
 	no-sdio;
+	disable-wp;
 };
 
 &uart0 {
-- 
2.45.2


