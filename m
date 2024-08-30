Return-Path: <linux-kernel+bounces-309557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1346966CC2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7B81C22222
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426FD18DF91;
	Fri, 30 Aug 2024 22:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HgTx/wDu"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2104.outbound.protection.outlook.com [40.92.42.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B556F18C92B;
	Fri, 30 Aug 2024 22:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725058616; cv=fail; b=o6jrDQPLkMcBJ6nr/yRW1nWWbSlxBIpR5lgJIh3Khjfj4x6e0YFLHrdIHzEaQutNW9sawcOZcaDlAtfa93Z/+ce18fw8BO5WaTEENA3vCaVfa5TnHr/Z9p4n4j5QTT7j1/K9V3F4YfXYaPHEWbd2Hig5geA27EOLqHeRGkIsxPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725058616; c=relaxed/simple;
	bh=tZDJL6paZNB1zdXx3OvX7qIpgId8kYSM7b/ng216LFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c8GXo8TlEOAl9SCDOpNSzCaNKT7yGSQeAPIHFsnR40Fz4i2BnFiYQE5/0iOp4lPh/8z1rkZVGg8e+/oO2f9zEEnviX6/XYs+FN2lSc3DzetBn/sV/s3BSs7Z9NRYPbdiphu38DLpeRPSjiddefpxNUroht8nog++VIl+IFPqemY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HgTx/wDu; arc=fail smtp.client-ip=40.92.42.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTkIgjmLLWE32ogR6RUtIFXmleP2CTHWHFOFXkMewaTR4KJU4fAeropb/9DHlx+tbET0vf1wYmci+8Z4ULmL/12RVaps7k+V2nmnWX78Z24+Ls8rX3ri20jKdccqeRWIOlfhpJV/gEvQkW9tKbGaNKMRpC0yXz3/qq6M6xKLvYR/Cab2iMDlDd8neOGwfegewStAmY999RFFCxY3OkPjdoQ3mPl4YpTvAfRrqsqtWwQt/u5tZoh2OZeZDf8KWg+dLnwIyeNe8rstsneGRRY0GgBjH/MGxuNdjToUMQNeY9oV1w+sEJH14oet8H2TlZn27rSjU6u5be1FRh4bVjmbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doX6CZ7+GGwWjxYdrYFir9j341r6ePGjvDMAXSpAFkU=;
 b=tC6YhAmCpgWoUxs7FJfo4XtUrOVbkrDenFggRg0gGdFVBOMrALJYO6gaBrPPHdma4YlCtW/UysnBmEGP1n3BZbcqmx6XbinxU3xSlGosxRjioWllYaYIswn1e+3UQEym/8YfkESNyhALLR26dA1cheJwcckDABEYDFe8b+dahLYHbTVreNM0ZdsZQsRqyuqjDmdIirHfP7JvBVt7XZ7RL7i6Txmi6IBux+Fk/Z+0TVACsgh1V+4/bY0K7wE4/DcYxG956BOELbRB0t+/V2dbCxb7NK1X2RN9xhOUlA+MGitHNMJPEIkJcFXlGVaiX7KuC9G76Kq6QnbE4rNS9fSUGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doX6CZ7+GGwWjxYdrYFir9j341r6ePGjvDMAXSpAFkU=;
 b=HgTx/wDux//4KfOmUVTuNWcEXVeGkCZiiOUN7mvV4MOayHqZYkfrS8C+N/6O9szmSumu5rU6NfUqf+3aFzE62bCaH0NfrHPMThHnva0HYJEIql6bqAW3CSIaEORiZIVxFlYGKU+zJlWhzoPgFrzWOFuRX6En8+jQUr7V+Q/zM3ofSHlBwayDENLhCJBOL7qOto+8F2O8MCwE/gbFsiFESJHvPC8oMFA6/CAWPMNppg2F27C4dIY0xv9vPWx+bq7eYQ//mzs5T537VDywbc01PR4lVDZc10teE4LTrqST9rzyYmWNfrNd/ipj0Fc2IqWGO5A0aYIVju1sNcdjZcVqGA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by LV2PR20MB4655.namprd20.prod.outlook.com (2603:10b6:408:178::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 22:56:52 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7897.021; Fri, 30 Aug 2024
 22:56:52 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Haylen Chu <heylenay@outlook.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] riscv: dts: sophgo: cv1812h: add pinctrl support
Date: Sat, 31 Aug 2024 06:39:41 +0800
Message-ID:
 <IA1PR20MB495389FD5C7AEC647AD5C236BB972@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB495374DB8C4208575AAC9675BB972@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495374DB8C4208575AAC9675BB972@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [QT/quMCu74hedNUBOe59E/FHTqdCB/VpJiEcD/ySZj4=]
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240830223942.27776-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|LV2PR20MB4655:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab3b023-d9df-4f88-3cc2-08dcc94709a1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799006|19110799003|461199028|15080799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	+233kszJ789ehdkiFOZSQKVtGuO4zXivYbvZqhTbzlzPwuA5/muwYuQwtt68hX3+8bv1+ki1KV9EuJSNpT+rWg9bpJ84xxuhw2wELJlFkScX8zJmKx3NVQVC2IJmS6PRD7GnX97vrbwxUeL5oBLUQU22M97eDNE8m5MifDZn+0BDRxbYwt3cCNf+LBwvHY0hN2cuDN7t0P0slSExyxF85Pn7zAcVjXq/U3I+7fo422sc3UtxRrgBh5LkUMUIR5i6vN6OrU+FLQTp+VDUajGCCvKVhQlFClXQE8tTTT20REtp/uMFNQI2bxLPKiblrbuCA/8y1zlGyesq+ry7wPl+xbLJhv+h+FQHOp30XSvO5uRR3ACr1fAuZ5yHP2d87e/99ksOVU0HTfaf/pUn3rUU3kIOViXFaU8Wplc19nhRTuW390Dxgv0RPhQ21z3IxxkxlHY0pviFShkOUEi6dmN64P8Yppa1+wFfBM8iOjNrZD5CCf8goy2ZEIKakyd9LqNhukFEoYB1Hat0b8cYiJQZsoASpZsxtBzq66zMbHNZrDrSxRQyZGNgdOQ/gK4SmTk9WMKRYBQo0VeLYrUUrGL7iX7i87HvEJRujiXt//uXufaWm8mS/8dK/iN2J8ggTkl2BjMLbfHNaXf7EDCiq5pZIhkFUU4Ctt7Qy5ERJCQXP6T6FxXjPwY2iv5pVMHx3kUAn/AQDi0kkBfb/5aAGtPIP680VhvlAjVIm/g+e/ywlG0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9YzbHCutcRGHoGEDUSBj7aigxI7j+g5H3zblMDG0LrVTYuUJeSYLoQdDaM00?=
 =?us-ascii?Q?vVN4/+WVqR8Bv0XunsKxriEB3xEDLrmi8V06cNi0LRbpIjKj9l/UCd8zEZ83?=
 =?us-ascii?Q?zQpUWsWdG0t1AGz0wwc9BFUuxlSDX57c5pmqicvnnDeaCemk+f8JyxzZ3poA?=
 =?us-ascii?Q?QizgmP2JisDfMXeJFbkr4RRwmNPxhZiYM6svQsf5RPqgKNqX63PWn1u4XHrH?=
 =?us-ascii?Q?rxkv4qP4BUU901ijxF+s7uJeLSS27/s8rAwpV+terVnFGImkNGQnid0q2eVo?=
 =?us-ascii?Q?6VXfGOKILC1GCZcfhDT35AVMw6yFBVv1iZLe/mSpCrAvbx+WgLmxviXdgiLs?=
 =?us-ascii?Q?fvh3VzYXYXi/4xbjgR3/5VeER7vN6lIpbzPoUfxYM0qZYOyclTGH+z4Qrk7i?=
 =?us-ascii?Q?ZRutc9zhKHAXqpCjtn6kK5WCf0boNhmoKCH8c362BD58oaJ879t+PnIjCJqM?=
 =?us-ascii?Q?VdnZv6+MZ4JPUAa5hWqNoxIO6DRJAipl9xHzJXJInwUCFOy1w7x2qS+8AVXC?=
 =?us-ascii?Q?bd+2xAGe6zZS40ouMRKJbjQjWM5GK7TNTcF0obPK11nshWJcfQ1otZyw35a6?=
 =?us-ascii?Q?R9x3pRjICaAGmCuIc5AKoO43a7U0hI+IsRWjMWb2bkz3O2EMaCttcvg3Vzm2?=
 =?us-ascii?Q?YiE6X+2+avbhrH5D+qd2KY/RbEqXhCnHQb57mu7R4ARt4gjcp2qjmw89ZdTV?=
 =?us-ascii?Q?7tTkZ/+CQ9JPl4N4EcW2HrllFEgmpqJ5Z7fvZHem0A2cIS+tH2QJWASRI0wJ?=
 =?us-ascii?Q?R7LRPFTLphqqLOaUwb0LWQAjuZ+dQ/U9O4imRkHm70MEm8uXStcDkLwTtE/7?=
 =?us-ascii?Q?uMJjNOCsgYyTbrBoOKMykYFv3EZr8GPww8B0uE6h51+eIDVA2HpuqD4N+4WB?=
 =?us-ascii?Q?ajFdU52oJKIEDSr4FyGbYNqwrrTOABs0gfALSdb+Rp/D71pkO54DdmoVKvSa?=
 =?us-ascii?Q?cfXCCkSK2eyFxghfHyCkIET22jUeGFWhsCMormIlCZ0PprzacPiHn/9hoGIB?=
 =?us-ascii?Q?mMtt6iDKC9UEKHtYyMB3Bt6GuNhURrKdQfzolwnrWhbfh8idOoiLm3E6oYHE?=
 =?us-ascii?Q?Rpy6slaLMJByytDJFP6BpZfu6ORgMP7QUbalgCBKeVO4Gf2yIugKt1qn0FVS?=
 =?us-ascii?Q?ZqIdA9Wx0JNKgrOH3pGJ9ebKP6ea53AprNN7U1yVn8lrbVp9ejCMkPMPrZ4L?=
 =?us-ascii?Q?w8rXOPd9mVF8/a9EW/KBoWDY/p4tYkCL8g/LUAIFkQ2hsFslkrRotMyttGI5?=
 =?us-ascii?Q?sl8I+RD81gjq7nUFr9pY?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab3b023-d9df-4f88-3cc2-08dcc94709a1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 22:56:52.3512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR20MB4655

Add pinctrl node for CV1812H SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
index 7fa4c1e2d1da..12e44edebfc1 100644
--- a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/pinctrl-cv1812h.h>
 #include "cv18xx.dtsi"
 
 / {
@@ -13,6 +14,15 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>;
 	};
+
+	soc {
+		pinctrl: pinctrl@3008000 {
+			compatible = "sophgo,cv1812h-pinctrl";
+			reg = <0x03001000 0x1000>,
+			      <0x05027000 0x1000>;
+			reg-names = "sys", "rtc";
+		};
+	};
 };
 
 &plic {
-- 
2.46.0


