Return-Path: <linux-kernel+bounces-251868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16157930AD5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 18:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF19428134C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDEE13C813;
	Sun, 14 Jul 2024 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="gJyTG4JY"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2185.outbound.protection.outlook.com [40.92.63.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C399C13B59C;
	Sun, 14 Jul 2024 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.185
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720975040; cv=fail; b=p7HHRJp/qS8KghlN87W2ZULQmhTL6rUDLpJXe07Abhm0bxYxtMxaZ+3hVBZlG7Ko3k/k1rHvjKYXts0uDG/wVUUwf9j4TcKgKTwX7JTQMLwUHGd6v4q0BudREoRh3MBsYs1bK8u8Nb1sCSa1OtzmndPqdD0uBQdHD7QgO5PHnKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720975040; c=relaxed/simple;
	bh=Ru9ST9sQvDP4lNa1FZsMBnn9bNkgbyV/fL4xZ/zKcV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=agCSNwiWsehvEZyglbSjcxwX1RWc0Z9qrGgp2YYIskAn/1Fpin0/1jEV5VUVWpfvPWIPJ8KzUr1LMpk5qn9BH92WgpTZvS9TTJh8K5i80/lkieVa49hjZ31p8VYSL01lWcKnubWPywZ6ljTbsIsTcBMVl2tLHqpV5QrA0xcQ1Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=gJyTG4JY; arc=fail smtp.client-ip=40.92.63.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aemzP5yO8EoQMzDOrpNcgZxU8CNRO6I0DHZNBEADJ0ISIjn1uodK66Swj6Ze+LuAs+tJPg2CzawRD2zSsVklK88gKMZ5XpN9ygD7SU04l2Hy6cLS+K5PyGMiLC22TlBn7lI7EVAZsrdqpm+ZC3HS5JKdLXvkH/LumsIls1uy9vdG/mHh0zOc/Mscyn3wSzb8/iWswh4367yjewqU0hx2LTsDtZ+6ykDonQsDhaDE03jmwB5+XHO/zzx0WatSz8ijlzgNqmX3JLw1FkrdNGrXsWUMnVCIkNJulrOSLiwsbhYkVIBUiQuIkAZPD0fDA0lp1H68hMoqoZcOoro6M8HXEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=784DF0A1G4aAnOvLCNc5w9/57JxDiaoyYlT7T/R5pFc=;
 b=e0hbznA6ZQHghfK9RZhP/Fz+WWIUoyQYLwZjuohj3sttHMiVJVd0tQqcsTNAnXcD2+aKdAGZ8Xa1bOC9sWBBhEujcXKSIMfNz8fMG+zCjm8aErFd3suXL63o8ewTTWg8tsYgXSHPRJOCrsDQwkssh23yNAQcwnZCO01ULN6w8LtDWmN3aZDCJXc5+2tY3lKsUCHzqbdN2F3RjrVuQkWrYnUqIg8DjpSc/geB0yKGiY2d3CvT1t49aW1IJewUCSwgUS2avuz8gnm2uGl0teJxI+rGp1K7pSmY/8g/kHx0P/2d/PHsfactSyDh/PuiAXgp2u2NGvQwd2MFtjJljW+WDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=784DF0A1G4aAnOvLCNc5w9/57JxDiaoyYlT7T/R5pFc=;
 b=gJyTG4JYOT514sSKQ2wiWMZoLw1qAx+MJ49A9XI8TGW4qEDiCUgj5wTv8vgscW2G/fYknLoxyiwvSXwDoV2TLw7J5P37gl1vw2lmlPX0cgzzFImgnslbWmbj1lXAuRzxEHHCUR1Jjk6WUd1mB/nyzm5qM5ja0uezK1pHCxNI96BAuSmuBGKJ1IaKtQ4PxF9i5gwFScN1eRZag94m0nktzRpLE2QZZNfeUAQDCJ0SVVBJwqXaQBRaND7maI8+fe1Lh/oF2LSt5gqQtACTmePcmgVXTwg2n6y8TR9e5wi0hqlsOvr71FYlLvQAuKJ++NnqgOaQrxEdjx+OsoJdbvWsHQ==
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:9b::8) by
 SYYP282MB0991.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:b5::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.28; Sun, 14 Jul 2024 16:37:13 +0000
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3]) by SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3%4]) with mapi id 15.20.7762.027; Sun, 14 Jul 2024
 16:37:13 +0000
From: Yuntao Dai <d1581209858@live.com>
To: jassisinghbrar@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yuntao Dai <d1581209858@live.com>
Subject: [PATCH v2 2/3]  riscv: dts: add mailbox for Sophgo cv18x SoCs
Date: Mon, 15 Jul 2024 00:36:46 +0800
Message-ID:
 <SYBP282MB2238CE3A016F21B632E61219C4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <SYBP282MB223825D5903777B937A8A377C4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
References: <SYBP282MB223825D5903777B937A8A377C4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-TMN: [SgknK0oMQFsMbktC7MvLH4M5kfx000TPHRV0c/i27lU=]
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:9b::8)
X-Microsoft-Original-Message-ID: <20240714163647.10814-2-d1581209858@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB2238:EE_|SYYP282MB0991:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ac4dc7-8fd9-4c45-304d-08dca42336ee
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	jmWTaualU8TrAEm7WFJYPvgBBN494s7kE472xyMG5NndePLKcjgNwyRY0fGvfpnmsB6QDLraE6zIpjiuwd/bLxOT/KRM2sbw/Z8gMt9Q4Yj+i/XMqzOEwltx7JZkNwWg7FJLNsLx6dQTk1A8jLYArFS1zrZqXPKywtW0B/tngIwSYAi8qKIvxik1XBwXUJMNVdBgrbZVjWCYGHs4XCG+JqjTGLqh1uOkHxjLHSRGCJbDPexPIjKS1SlFPobMU+D1q7jtK/XtaA3ejph0v8sQF/FQ7Pk9I4RoAhix+c8feHjIAb9xUatr6gemgk8xPy4Of6mqmggtbohT+Hp6Cta6AIlLvy9JV7eCPCTvUXA1Lm8QLKDpWVvdD4/onxUoLVbcAXIZLrkfkUKEFdQCAJi1QvpDxdLadxlscwY7v4d2xS7kHp8vMM4XUj/IHpbCMVQScLnzfv4OnNplSKdY1DP8Sn8YgRlJr7ojEH/pqCQ/wVvje2SmaMRTcCQXPWGy/m/tfGrikasMUdbxyvZbBRMAwrAg0sqy8U0h0vBvniLtrCu3b6Ukevh8MUxB4WCu5MWuiu0TSDNpk45FB9ju+cRtJvAk7G6/C2Fqw604pZMfpmvGMJlM1bcgtBHkG1Ci6VyIsC8Sun+1qmkq0HawdLuy/kmLk0TSXxOprzO5ZT5AyN+uvpg/tRUqx9vsIn5WH73X
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZMefWgkzoqjk9rLVFVXP1/DlEjllu9IGN+0MpCWLbfMzdXY0olNduagtLIIK?=
 =?us-ascii?Q?nx3Nzsl8x8W7GgfwUonNQsirGt88euZt+tIrWpOqIDpRahXY6pW74hyIt+JT?=
 =?us-ascii?Q?w/zarb/yZHiKqd/qO3gDof/tXsI7EaGW9WMpP05cctw86LyY4VN9HfoNrtHk?=
 =?us-ascii?Q?KKM+UN61ttLaigSUyJfrpnxEdHXn80g66XlkpzH9MyJd5s85ZIAjBO6Nb5xA?=
 =?us-ascii?Q?ctbUrOb1k3fCaSM/uEvmgFai/1LZGo971zGIbAf8zGuLJCHuAkUqvtrjf+Iy?=
 =?us-ascii?Q?3In/HxjsQrM+qVBXo1gSxhlndFYPZXwEpH2zhxbKwA6Z4yguu60YFnWe59kI?=
 =?us-ascii?Q?B+W1dtFpUMlrTyQ4PbrBqA5MXXyW1J0VF0kiU1E59pwNWhNNbmsSUo/uIlua?=
 =?us-ascii?Q?flPbbOrOItza4AfbElJPRSx3YI9N2uiek2c/uqL9p0/DDUH4ReVnNgRdxeCP?=
 =?us-ascii?Q?t/orpBkcJd/5u1wzJX6CPb93SzX8YSs53HJiQSe1yXcb4rkXSE+ARlbbBsrY?=
 =?us-ascii?Q?kJLLkQxa+dJ8gHVtyggJODGckES3bJcXcu8/yd3VAyv6O1+vZF7HYWQ/O3FF?=
 =?us-ascii?Q?DCrCHXZkJQmGUWge4nNFFabTQ7pn6s/ygcFVw7vsA4HZVfwWkSRkgxoHwBBw?=
 =?us-ascii?Q?nIJrBRant1qOt1NlfScxlp3Np89nRBH8gzEwP12pyu1cezQ/RRSFm1QWwPMS?=
 =?us-ascii?Q?fWvv7QdDj+aphWsmu60FhIytoBw2oX+pwZVbfrEDBeuniOtBML7Z4sa2Ahnd?=
 =?us-ascii?Q?6r46x1yZDj1lXdSQr29hL5uCnqqf3QLmBm6S8sertcJfLZNnLOa8rwSUqw+E?=
 =?us-ascii?Q?S3XoRVIyyR+PAJjKJcp9jycZ1rY1V7CmO6g+RioS83i40pWS1DxX7QkHVzdH?=
 =?us-ascii?Q?fNm9YY4tfsvqU3D4YFSfOocJXPVxouEuqCFFxJpMR9fXb4GxOOm3+Dhipazk?=
 =?us-ascii?Q?nbvUyxOranQIIurDR85TTPw8VHzTy5gf+78/LpfiQWzrPtHBrcQoVejbBQad?=
 =?us-ascii?Q?seW1msE43AO+u+8EprxvIH8DZRx3f7hfzrC9kzc4i9yDDZTj7IhFWmOYhOmT?=
 =?us-ascii?Q?VmMxm48T4lMwCsuvDrhG4VX8hzqurzLPSpfoMpsWXBecuWCiD5WuCdvpHIn5?=
 =?us-ascii?Q?ehqoyosNrN4pCpWaMoGhwczIhUelWRc3v2UHKNbRQ54/ov0hak+iMpMfdM+D?=
 =?us-ascii?Q?hk1IVANCWdKTeWo8K25BoFYQG9GQg5gzQMmC9km9yQbE9dbqXs8sDyftM38?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-722bc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ac4dc7-8fd9-4c45-304d-08dca42336ee
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2024 16:37:13.5038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYYP282MB0991

Add mailbox node for Sophgo cv18x SoCs

Signed-off-by: Yuntao Dai <d1581209858@live.com>
---
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 891932ae4..1c7035737 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -310,5 +310,14 @@
 			reg = <0x74000000 0x10000>;
 			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
 		};
+
+		mailbox: mailbox@1900000 {
+			compatible = "sophgo,cv1800-mailbox";
+			reg = <0x01900000 0x1000>;
+			interrupts = <101 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "mailbox";
+			interrupt-parent = <&plic>;
+			#mbox-cells = <2>;
+		};
 	};
 };
-- 
2.17.1


