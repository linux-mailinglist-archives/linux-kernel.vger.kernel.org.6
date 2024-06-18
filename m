Return-Path: <linux-kernel+bounces-219727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6669090D6F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E467A1F24791
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362061586C8;
	Tue, 18 Jun 2024 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Tu2/F0Kl"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2172.outbound.protection.outlook.com [40.92.62.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B824EB3F;
	Tue, 18 Jun 2024 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723594; cv=fail; b=Mm4qySdxT7xBiFw7wI4bBfRhrzpGvTiPXFliLIoCbRpeHDIuK4oHtFYvf8ReymAQaXQ9vR+o4gtvLMzxblL2FzAOpZGZY99VQymUl+bPO54JAmcUlQbfaZPqVInMq2L4uY3Jhyi/Mm3Qbp5W7d6FRMqPcVzo2fOxgXHCfrywsew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723594; c=relaxed/simple;
	bh=vUqdlBycTfE1cObDnng+E0qYuMon6YgEEyVbv/QSBOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jcld1d/stMtlfzbribSCw653dUQWyBE/v78lD2kba9jzB8vPvbIU7H/m9f/ajslp9oB2moliPqUjhcEe/wbgCJWfa6wiWuvWVpNPq9KHA7SmbwxVHH8P3YxVrBL1g4w7pK6VEtW8V6FiaC6ci5DJjG0BocPkdOVLnBJ2koY7m18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Tu2/F0Kl; arc=fail smtp.client-ip=40.92.62.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gh0hpBBxvz6snPCLEBOBI9myDv4IlDf7NA4WCYJh1dtSyRY9E9dRHnW9qGrmFwjBBhYRAc5ZzdGpfnPQ/wuixIwxpBIV8+lpLij5m7zMxUY3sS4BtSvTZjMcvJfVgr4UTNTmQWbpqvrgtgc26dkHIWywNT6mh93TAHZhOpT1t+D9Y3PzSQZGxJx9+SAYbLrNvYjihViXLOnwJIHBJsLWs+s0b0JhHJTO1Lnplh7rXb/NQ2iyzunk4/6Pk3BRSTeAx10nJ6egGg79PI+8CCfA/MN+9CaKY3jCnm8faFWKj1vGHhOSEUlXI9IPxRIjP5tW06Bn1zNEY8tqpmT8BQ1bUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IX1D+I5IhkXeMvlbXxgultj/wTl/ZQhlfXJeiK5f66o=;
 b=hoZDw19Ac6AUhYknx4O+/G40GQPPbEafbytxgVPGOzXmumWe7W9NDbpw7isEabAHt9o+Zw+CgA7hHY9Q72rMYVGsc76fwD370wNqkKaIdoQUAiMtpE0mUAk2nfeR8tK2xZuQizOFDl9XZlsRM3okeA/Oe5HUgZTdcCLxL6XuLsPJcaAd7t3C+nY31mEkLxTOMB7BGAelUb8eBTui4GohnBKicuL80fJTImUK8wzXGmlDxgVP4wfEqK9kru5rSUMEbFnImCvwpaAEvC27Fq8u26cDBXjmA5O/C2v8uTIZg39C/tWOGZB4zEIvaZE9awKq0a6ekgRilFVr2+3V4nMctQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IX1D+I5IhkXeMvlbXxgultj/wTl/ZQhlfXJeiK5f66o=;
 b=Tu2/F0KliI7ttM8o7J40hJzdsHkIscMd8aW05lP1rO3q6Hl0b2aHoz2EgZ9ZhlPNVoEIwhvhzjt5DCrtBEa1OEMj51+XuuFF5vlPS84RboeXR2xp1c4tgN2Lz1oq6le/VV6h7n5UcmLpKokEGYqpvJleZwKOr+imhxFRuUlvx3vaalLSVcHOc2Ax1w6nI9bpkNV/ckxHmLT/luKr4xclcql7OAGmLzDcwVGevyUQiygOYgyy7Iht8h4oAlEmdBGtLcw43pjAoViomRvohAoQS1h7IijffZCd1oHbhXmRS58AjClsZwYTw6KG1XH/J6iebBlsZZ/FtQUu+/ploacczg==
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:9b::8) by
 SY7P282MB5268.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2a9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Tue, 18 Jun 2024 15:13:07 +0000
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3]) by SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3%2]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 15:13:07 +0000
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
Subject: [PATCH 2/3] riscv: dts: add mailbox for Sophgo cv18x SoCs
Date: Tue, 18 Jun 2024 23:12:34 +0800
Message-ID:
 <SYBP282MB2238D8347CB829735C695B28C4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <SYBP282MB2238DE0DA19C6EF411B2356CC4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
References: <SYBP282MB2238DE0DA19C6EF411B2356CC4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-TMN: [lYFp8H3WIKmqU1bEb8cQ6qVe/6dFhDgo]
X-ClientProxiedBy: TYCP286CA0266.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::19) To SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:9b::8)
X-Microsoft-Original-Message-ID: <20240618151235.5846-2-d1581209858@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB2238:EE_|SY7P282MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a6ddff0-d055-4cf4-7fe0-08dc8fa928a5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3412199022|440099025|1710799023;
X-Microsoft-Antispam-Message-Info:
	RcpI6mHHDHxOCwUHboeddy8DqbgnQ2ZmloNavYG++e6g+1XItlz0ngcGjnzOKVi/NwLcHl/rLxmocbH+WVvphufyKaawAQHMrBMAtkA+XdTKyEoHC7y3gFQNJQcpTBnUCGpTsFnEEWcyX7wrwKzhUa/Y3rh0wPSHBmf0tHqk9sB7Q64sUA8UitqV5iehH0q94H4a6y4FZxnKX5a091Ut/bKDYJxe9bvhgfvZJltV5sW3oRqDKK0tCBNj3TWz++5EJalyEbtUbso2NfeBPEjnH77KDKTNCvpWFbsk5ISNqYnuNpgVSy76bLMcqIalElwfZV1nxaXN7+X3pJNubGTEAggoEcpped1Sp1yIBkvNoquBKQ3Mn89x7eLzxqRRycm8DfqkBiAV++Wd4ab6b1UvPopdvCj4sZpDoaUslVOCaUkO+UaXdIkt7VFcAe6v3HMxkexzCQSOFrPh6rYLYVwQOCOP5CqyYuOJcTTBaRPUzLHXPLniJ/9lEqRILAl/pGgDHw3lO8DgL8jTbPkhIlnCaGQbuNEudXm84DYfekxKcTfwm0tflg1BFiSkt2A9dch1h64V82RXPM9HjnI//fnB8G9khXzcsrQ9hnM9gu4DV4WAtCUWkhD2WDcMNP2A7URF
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pfNWeR2x0mxd4xIHkYj1dvmWGmIDwT0TVu0SXzBOZBMJJGflfC+GBdL++O5/?=
 =?us-ascii?Q?Z9AwmZfasf6jqS9S7YkiuXxr+TPDTTWcFGiJeucrqcCYUqF5sEtWkvqmD2G7?=
 =?us-ascii?Q?U/aXpS4FZI4vzxXkbQXbSRkmh+ecGY8L+kY85S0tYuZXLZjm4xnQwi3vTGnE?=
 =?us-ascii?Q?PnOkuw36n282havm9NWlAkDGEV0lUguMMh8jTynx7kp/o+AHBC47+AJBqqJf?=
 =?us-ascii?Q?UEJV7q3KH1yxPvWOW/Qc6PKGh4rOq4ryC1TFbWG9s8ALx+S4vP4+U/LC9jn8?=
 =?us-ascii?Q?DEPBlPJXfLiC+Z1SPTKSRP1s912YZijoHuq3gS/FqsgfZVN9UuR5o6xMWpmh?=
 =?us-ascii?Q?o9MrEoZpVeWwNEbdVZdkPHbXbZZEC57Kl4d2lrcTT99hX1MrktJD2vz8re6q?=
 =?us-ascii?Q?MKAvHK7fTp11Y8nJNpi80nDQ9HuCQGVTjK5mtY6BMYXfHg1J9QcM0kcJvnkH?=
 =?us-ascii?Q?hcbvQjD8qjGJ2aWbtLcJqyz3iiXx4QEMajkDncKgAcvEqL1+i1ThbustDShW?=
 =?us-ascii?Q?Nu+iaZf3fJS0h7hStVLX4SRqLLRCpJ4VkY8Re13jasTQ3KB5KCd7Lb4fsgDK?=
 =?us-ascii?Q?gYBRAXNJgBKlRJhc5xRyNLtQh04JUHgBmo7Pcyf+vFZ+oCgHahHCaZ5TbF8t?=
 =?us-ascii?Q?/FhJsGUGVIQ8TIWExYFgRmVS/ZwPupRiIJErVxg68NKeTEXwQKf7oTwKIRZs?=
 =?us-ascii?Q?7eyLJLBO4ouRKEf7ovDWo35lElFz9FT5qMX7T8q0y5ZwXgzvch1yem5hTooo?=
 =?us-ascii?Q?JhjcOmoQn58aN8fnBugheVlIok3NeFJSG3GDxG+gjLgkKfigbHxAfaO7IPzV?=
 =?us-ascii?Q?wk7NQ4KL3ALRPXRAfWxf5iNYdRKOeSjEsW79lt2NFQHslU+EyL60Fy5kj1bJ?=
 =?us-ascii?Q?u6JWFjgvykBlCiYRse5VreAOINGLBYJrLjl/SMIRFVBSnK1tEYWYHo0M1RYD?=
 =?us-ascii?Q?XjQRek7LdVfJ2ubl68RDWphdgOS5W1jqkLUnyLywHpa96ckat/eZbFC4LexT?=
 =?us-ascii?Q?TXu70Ud8WJhCz+gtABtvA/b3L+YcWVpJwzZK2hKZ3gM/krADequD5n/WL3jm?=
 =?us-ascii?Q?UdIYbheqzC5CoSEXA+zmEdt6vmuIsBIt27ElVn3alFKJ1pAMYu5tRU1ghIql?=
 =?us-ascii?Q?FM7AcVhZKcfCFVuvmq4z+fbvtGsxi8OCK+ZI13XGDo+qWBDRYLlt4XwGkM/g?=
 =?us-ascii?Q?uutDXONlLPfFyTYlNUNdxHGX0MOxa3DD2eTBBXGveLukKDiR7qI38mUXudk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6ddff0-d055-4cf4-7fe0-08dc8fa928a5
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:13:07.7980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB5268

Add mailbox node for Sophgo cv18x SoCs

Signed-off-by: Yuntao Dai <d1581209858@live.com>
---
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 891932ae4..48f309bfa 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -310,5 +310,16 @@
 			reg = <0x74000000 0x10000>;
 			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
 		};
+
+		mailbox: mailbox@1900000 {
+			compatible = "sophgo,cv1800b-mailbox";
+			reg = <0x01900000 0x1000>;
+			interrupts = <101 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "mailbox";
+			interrupt-parent = <&plic>;
+			recvid = <1>;
+			sendto = <2>;
+			#mbox-cells = <1>;
+		};
 	};
 };
-- 
2.17.1


