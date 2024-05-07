Return-Path: <linux-kernel+bounces-170793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE8A8BDC1F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403331C22418
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CD713C3CB;
	Tue,  7 May 2024 07:09:33 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2097.outbound.protection.partner.outlook.cn [139.219.17.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3E413BAEF;
	Tue,  7 May 2024 07:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715065773; cv=fail; b=bzZI1a6xevjGNiAuCGn5F90XnBPMeDJiRP1Q0GUBswT9utGadVE5nG1Z9WmHn6YCDR1jBm7Fsk/QiCjIxNwsVE2sGw6jJpnE718jJnr5jrCdfYpT7ReRobrGmvrD6F8tG4dSy6mJkuYjxKBoYWWU7JxY5hULe/HQCHZs4GZIUiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715065773; c=relaxed/simple;
	bh=qrcgEyYysVmhcc8hsDQZQw/gS5keWzqY7iVOFHv216g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W+c/K4Jt4YNk92jKMJHpwmnXyLlvua2KJ+d9NVVZTr348j6w2uNWnUjOD+AaC+OiU9LeKq9RyTP8WnIA4QzFPFiP8BYb71Yvvzr7qlCvlpHnsy6xjnapQmjO9ljwAZfQS/Jvla1jTyecJfq60P6ND2uLtdfmWgc2y+C7C+fH/J8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHc3JTFc+tcfNcVHDi77FRsmm0y8bktVYShbqpu/qPSxYJGJg/7R4najQaQnGBeTbbMrJw7QfmMXY6oXGn8fbb0kx4P62E+6wgC/9bCQi3PIyrD9o17PdoHv7b0dvksiqiitIjy5YhaRynuSqZ1cGWf/wHQMMKoOGl0fQFq2nEgcedGOGwGVHNs7ZvZ+L2+b6rf3LMGLySihOyn2ZKqGUqohPtNZD0btgPOfQchyb8xJhaDrvb/CNehFU4bbEtWOXFf8kYiYuEQgh51cGBPRp3SPMmkzFWvwq1PEoHdzTnHi1rbvcucbHD22o1UOxE409VNFdH6KlyhRtm+OZWGbuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L03T6HL0Dwpy1svDh+d4rMoEWtYmJr7+2sII/xQd740=;
 b=LhnnXdu+c+aei5ySezisFZ5ijnAWlA8azXIlvecaJYVnGtFtxM+7t58dBPw0dn7XQMuhTcWYZEoVrx0lEEu9Kx8dKbdYDAOsqUJKlAw1X5S7CxiV86Twi67WdIt9pZy28rrtqibHxmrjsHEWUw5quyUz/BFmdsrc8kgCDkon9E3HqXF5LrKdnnR7L21HYgBJEc1qCypcEnoobikjmma/s6rUZ+bz1u4pWmED9naftcw5S5XQc0ySZqJHe9HYYEdLuK/z9DDMxSNR0ZTmtBRLVv6lWHZKZ7ZCCyWjtlfXkNA4StSYz2oewpTahj9Pq2SAr28xB5jA0A8z6WWO0ekCrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1034.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 7 May
 2024 06:53:27 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::e903:99a6:10b7:304d]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::e903:99a6:10b7:304d%6])
 with mapi id 15.20.7472.044; Tue, 7 May 2024 06:53:27 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v5 2/2] riscv: dts: starfive: visionfive-2: Fix lower rate of CPUfreq by setting PLL0 rate to 1.5GHz
Date: Tue,  7 May 2024 14:53:19 +0800
Message-Id: <20240507065319.274976-3-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507065319.274976-1-xingyu.wu@starfivetech.com>
References: <20240507065319.274976-1-xingyu.wu@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::32) To NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB0956:EE_|NTZPR01MB1034:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd31bc6-e76a-4ca7-16b9-08dc6e626608
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r/XOblMHQvrjHYj6m+3A38s34+LNYRVZix2I/ITO9LDR+0QM4yXPtKL306oCRMwWL9npteMFf4WhKmxlDv31o46jdGamdlRd6vFZlXZ6JO2arerMbR7BYlD1y5+PRIvNDlMaEXZIS7Nm7hSuVEGPhKPkoqpq6XCedN0eC2OOYWGFjPObdWDPVHYV9sB3KdpsLHqmsGtUdnL1oNOIst1QWkiJlxqXZt9HWfyHQpth35kszt1jo8LMjljbajj0U79c/jfzRxqE7YAgJYRV3bzuggV6hdnt5w+sd8x0bzsJb33CdcqOwjMKYPZMXVj3e7XHdFrnpwKhA8lRFE3zAENAjjGrQMxKhDuvj4uv5pnRQFaBfZajftiesCz+XjNsL0+TQiHSMb3LGepcAyk4aiUUujD5zJmPH+wCnovmdeKIt+VJW5jJ0h9qvZbLJwlpdmSnT77VvbzXaly55Y0C4Aco4ZxuPKaVBExUS9kCrICVLCARdx58ob9/zuF8vrsKVadMwXNnc/DtJqtpKC8n4XLeGBZWeTxUbp2CmusBoiGYagH4RDCCXAa+Ut7H8UEMrtbhCkoshW+jFlk+vkpqjEVunrPHYtMTiUrU3TsW6ORJetL6ge5P/BvbbVzTGpADE2Pv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(7416005)(41320700004)(1800799015)(366007)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qC3CzZeCsgSdQNLEcGc7ww0u8hZYTDTu60YofRufsiKTvkQUd+QEbuV+bnXb?=
 =?us-ascii?Q?43vZ+tfGm7eg4GNo49B9uBDWfnqiluOrohvhfDAqtpKq3jrtVz/P4rbICaVS?=
 =?us-ascii?Q?si/O3m5VpNTZhcIWqnUPdRWnF0lIt2KpUg+whQDiHDnTNN4vfbb1sytoiH7y?=
 =?us-ascii?Q?2ymp5gpWoWRzhpfjirgOxvMQeDI6N22SNk4TYHqTWKUOCWGYTEkiAgAeIgE2?=
 =?us-ascii?Q?tpLk05elzBVNajhSPvcS3zi58mXAP4O16TwU5btEwW88TxNELweAxNq0tP8k?=
 =?us-ascii?Q?melrLm557FSeoQWyhG2VUfOtUpNtl1y/Lu/rmIixup2KWdQwyXPwRdpvToVa?=
 =?us-ascii?Q?P2ldYh22XeLafi9XpEnff/YLcyUkcSH6tVn7/99He4CHE2g4lFWr4J/eCxg6?=
 =?us-ascii?Q?o2P2orrth0Vor4uKVPgLHxFYfT1Iiw9sEs2yb5cJnHZGd7tXN/DlP9ScizKV?=
 =?us-ascii?Q?IvAk+wf5inFdvHOJIAXqqYT6kUa9RvMLA/cz4K6uPUv0v4d1IvLNSIoFrlb5?=
 =?us-ascii?Q?XNjuCon5kTcqHi/9z+ehrZk6f3pJ021PecLExHfliPR0UC9+RAKfy8kJX6UD?=
 =?us-ascii?Q?f5f16NYPjSNpsHEZMEOR2/a74Fn9EpaVKn/xUlPi163RMqhYRYYhf/1ZOrMU?=
 =?us-ascii?Q?WXAvUkidAdP1BxjWpHDDvyruN9oJqbOh8noJ4ZxsdZXQrzdqn9IYmScnlGcs?=
 =?us-ascii?Q?s/599NnmT4Z6MQ7SPq0Ks5ycv7/v1kLLidRGyToE8DhfxwoOpf+oEi0PEoqN?=
 =?us-ascii?Q?NEIVwGcra4tiDsIM1KJ6upMPuWlHlctMA1F/KBdyCXHkssAX1tvJVHO5Td0i?=
 =?us-ascii?Q?8v6kXqThycmpTxRJgJbb4i6MOAwoHzJh4UXSCbUS8wqJdJFuJibf09Xr1HMS?=
 =?us-ascii?Q?amHhwrylw+gRIfMUuwdjni3pvqsOHZN7zDbr1dw7ykCTRNEdZ9SAbAdKBh11?=
 =?us-ascii?Q?bIxQbxxA+kvZLiHxgQW9ImGzjZIr26ED5CCyz1/DdTBwAH5hM3bvCJNjk/7T?=
 =?us-ascii?Q?spEX8kmdrdX7VWi7XfXrvyN0Wwz5OQFcUnyQvMad0pKIB+FnYbog5VZON+OB?=
 =?us-ascii?Q?DteveNHtzxUB3aQUSXJqjdX/X+CVEKQ/p+WclX3ZLR6joBCP8es2dO7C/ZT/?=
 =?us-ascii?Q?VKacVF75ennGrQsmwEpeiAsUiON7JQK6Trn2tXPavWVYUQKCrUEvf00LBxSz?=
 =?us-ascii?Q?RICRHUiGkOr0WkP1dqGq9Xy87bb8EbvpzumYw6kIsAqkVUJVQaS5ZLf0ZYXZ?=
 =?us-ascii?Q?9mcMCDLT3cW3a0B5gFUDrYMuo2oi7Ur5nP4E2SyvPsBpCo1ePyEhDACNNG1j?=
 =?us-ascii?Q?JTUD5g2u3je9n++OE/DEGCxBn+Oed6GmNyZOpeRZyVIEksPx//68YFM2BJ7T?=
 =?us-ascii?Q?zm2xIstGI8ElnU+ROSz2qvC6/HcZIiJUD7uIt0qpZG41M2b8mg7boeOozuX2?=
 =?us-ascii?Q?b0psSLBQ2HLcB93H4BjtSdBJxUJBSqmu+Fsg5giAoY30tI5b92hrV3JLlkcE?=
 =?us-ascii?Q?ZgTm9YCsIjowwoYNo1iV/JP/K8U76K8kaiBHwdeU7tWM6umocOASAO3Z9H18?=
 =?us-ascii?Q?wHGsb0HEC047+zLGT1hE5+OrxXIDpoaAXOeR4NM0b2Zpzxic1W5w6D1J4QhR?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd31bc6-e76a-4ca7-16b9-08dc6e626608
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 06:53:27.8158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+B65rcOYh0sMM7ll22P6ObTX3ryR+Xg1IkrX6FwNK68rO4/OPQ/KxkgugvewGwhjQwaFnCleb+ULDXy/XeEQQ+gmHM+MEkAixLbseUgdkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1034

CPUfreq supports 4 cpu frequency loads on 375/500/750/1500MHz.
But now PLL0 rate is 1GHz and the cpu frequency loads become
333/500/500/1000MHz in fact.

The PLL0 rate should be default set to 1.5GHz and set the
cpu_core rate to 500MHz in safe.

Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH7110 SoC")
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 45b58b6f3df8..28981b267de4 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -390,6 +390,12 @@ spi_dev0: spi@0 {
 	};
 };
 
+&syscrg {
+	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_CORE>,
+			  <&pllclk JH7110_PLLCLK_PLL0_OUT>;
+	assigned-clock-rates = <500000000>, <1500000000>;
+};
+
 &sysgpio {
 	i2c0_pins: i2c0-0 {
 		i2c-pins {
-- 
2.25.1


