Return-Path: <linux-kernel+bounces-302516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CC495FFA2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE9D283497
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DDE17C9B;
	Tue, 27 Aug 2024 03:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="i/7zrNCd"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2057.outbound.protection.outlook.com [40.107.255.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3210517993
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 03:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724728135; cv=fail; b=kWRpVVmvdm7IkJQOkp8uZ913/h88CeXr8jSay8YAigUQNBIztKwWbtdlzFYuQI8mhyuOYcuRkznUItDGBNLyprOLV5fVcQozYnYu4PZtHXuWRACqgrWyEjHHwO6KsN1hX0sJvQ69L6R3cc84ErdgFkYUkki2lY02+SzNKpAbj5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724728135; c=relaxed/simple;
	bh=ejI8B1Tu52m8uhSqvYDQFQXtjbhlUVqcJQv7eGKizlM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Cge8AII+DXoSO7VZFhi3IqahNu/Ok8CSuCfad0dXddJ0sOen2HC1vxl5ZULxK54j7uVkcuK/V4hZmoj0sM1Fsp+2uq28+mUMgipIh3YEqjtQjK5o2k7jT2HXbbW6nfa2OtBpRahe/hZZ0S2iNFy6FwZ3LtOaxXgQf7T2rFZspqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=i/7zrNCd; arc=fail smtp.client-ip=40.107.255.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6n93Ixg1jsoZId08eL8CAvFYt9lLii3IibxfE5zfeeDyqsYTsRP/3Xn8bCHiirGhsCMJQyOIp9RDHFNI/Y1ujHfsEo16Z3q1koartGtoZsPqlqO/vlJIFRkDT7NhaQBwr4z+7OZPJQVb4nQXtDV5PFulAuvFfh0RHVvCG8k9oR3Z0EYklvkzN1w6xEOz12ivzCUPsvNDqaSlEaTFHmL+mvz1X3w6R1k6wicEZuCSk/v+CkY60q6x0Ne+ULhEjs2qDqLpe7rfLHYCGWNvLLrnLoi47zmHbY/m3ltbj7zEaES+FvMi99i86wUm7z/tgdZ4zZR1SInvC4Ant1VRXuSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EHUn24YG36cLVjG5O/14gIB0agEy14wH49NLOISuHQ=;
 b=q5NKFLIllJvY7sTAhhvOkT3jay2ppzLtZZSK6E92JS9arJxnXEB9gVPL6CJ3w2wLqTSzf/CwU/m4tKUhAuUlKnGZ19Veh5USg+5xKJERJfJCdF9LHIwTTjF+eL128zhfLlIw6jsLtcELla1iCF1xok4UsCfiFrQ4BmmdoUMPzm9pN5Ygy3Wux4ALdJvej0MtS7SbUKDZObBhP4woB89hrJ0U1llvFLKd69tgi3W34/fkPXuJDp0CCXB/h2DjxlTlZhMFIlZt0r1WkRKhoIG7Dls1o8ICPlxrE3RhormmBaqueBcRTMbG0yAEtTYPJYQbe+ob98pji4DYSbRuFi3tfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EHUn24YG36cLVjG5O/14gIB0agEy14wH49NLOISuHQ=;
 b=i/7zrNCdi5tvhOE6a7kY2AlPPqfAUsBPe7gTr+Bml+YVfK5DBL+gZs5WLrUwpc+ERupLtg/rp/JuAoqLnEz7n8ZAVbHVJ+riHlRMYV0XnyBw52klgpp6cpg9iY3ZosuET5R5jcoZJER+aWBIALPdBvuG5sv/Wx0vDlBOG8SKQF+JbTTHJPiuAmlqUuQ4gHPf2Ta0wisl85R8A0h7sxEpWWt6SsOAUrlQyhVfvmdU/QWL+CSxxGxCJHqklN7tLxb3Kr3KuPoDF1GcWbp84fKUxa2ZoeA45JUJngyiyraKC14Dg2XbvAgRD2rE11WjgItrUSz69/k8wIxrpvWmAdMXqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by KL1PR0601MB5512.apcprd06.prod.outlook.com (2603:1096:820:bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 03:08:47 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%6]) with mapi id 15.20.7875.019; Tue, 27 Aug 2024
 03:08:47 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Wu Bo <bo.wu@vivo.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] bus: imx-weim: support compile test
Date: Mon, 26 Aug 2024 21:23:47 -0600
Message-Id: <d0d3877a33db855e232ec4c6911a6937402d501a.1724728767.git.bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|KL1PR0601MB5512:EE_
X-MS-Office365-Filtering-Correlation-Id: 04f0fcf7-ebe4-4f04-0e06-08dcc645911f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1fMsb1k1lcvBC+wo0vraUz9OSKtuubDZueKFveGzEMjSAT9l0uEeof55Wm26?=
 =?us-ascii?Q?oAYjUKdyERexdjtgxxj6++SsOqBmFKVkbuJm3Ql1UFT6V8xr1hSSOru8gcHl?=
 =?us-ascii?Q?3A5YehhgY+KFNlrvkziiaRkRjPKbAtu72St1TsBWnFgdrBTL0Xvx7deXOLqm?=
 =?us-ascii?Q?4IS+JlOjvbdDFiVcfWZCUrdMoQKquKAe6pye745Ozo6U0pwo/p2Z07mtlY1R?=
 =?us-ascii?Q?o7tzILzpFSyafu4ch+ygHoYvHPV9BlqJ3+TkFdd4wcn3kBPcDR+++HZq8uT4?=
 =?us-ascii?Q?3X/OkdrRwKhjbJVWv3YilOXc+uyEN8SmWL/9Byw6knQtrTPVKXD9HR+KedRg?=
 =?us-ascii?Q?EVHH5Awm8OyK+yXeBAYjNfqHF3lFpIzEFktK1L4zxbu9ImDya1Q63i76ChE3?=
 =?us-ascii?Q?SfiGS5lRr0CqxHXhjU4rCer7pup39NrlevB/5YLGx3tPU6TqIaHxc4spT5vw?=
 =?us-ascii?Q?AKuR0WqSfGF8ewWVGwOoDxXHbpXG+cgtceNFFJq/0qMDOETmJ6O81siB7BB/?=
 =?us-ascii?Q?cEw+PemW3dHZA0IgwjsYtS51VV4I7c4PeEREk4qbIiOuAcFwTakKeejy48E0?=
 =?us-ascii?Q?6K/JoSgHVKoEhsExK8f/F0cCbq19tot2fmylE4OQFui3FH4jVwjL7XTzqyFy?=
 =?us-ascii?Q?r4Q7DX0nih7vewaPpoBLufHcrfdccXTHsPHJMM2o0/xgZ7CNdWIB2I902BTA?=
 =?us-ascii?Q?5OrZaQhoOuNqpHVt4omAujSk9cMen0Q4OTG95TTjDKIwte2ZnZ541ne+G9Ky?=
 =?us-ascii?Q?kWrZQkM2MlsxQF4OlBfjGRVmBKkGqNhFG2h+DUFdwSYov6qPuc1y+i3QGTde?=
 =?us-ascii?Q?2lC0eMsikva2W9BdiYmEEo/7A39P4iuxsLq1iuo6m60T3D4byFAvpw28Uwjh?=
 =?us-ascii?Q?sJ78weImNMt91cfPST3ABpZaGVhndeF/J6qhgiJu6r3HHTHRkFW/hYVKPahs?=
 =?us-ascii?Q?n9fTP1chaZOoUt0cPo3hWX6RNOzxAa6xJi8KnUWuT+PYedSM+PLZg/FWqkfS?=
 =?us-ascii?Q?zDNzZimAi4mBJyB48GNxS1lq836XU1jxMT0EQIIF7DfbgwRhg9dTwuKfnObg?=
 =?us-ascii?Q?BQ+qsbJJVl1+SmTnForZUkONYS7YmW7h8RYKJBjDwWJrI1bsd3SlpXtuigA9?=
 =?us-ascii?Q?TfIhwAMuadNS3eXLQRUBaBL36beqXah9AOOHfe3QeizO9MIkkDIYeL2FS0mD?=
 =?us-ascii?Q?T1jeGwmLihbPyv+1v4aurPsAX5Ireq/Ocqj/L3mTjragfJU0PDJk9UDuNSoT?=
 =?us-ascii?Q?pIYCcxJWs+7PxhwuLp5/e00JNb4/ek/fn4D0yUsDrhJNYpLVr7z/mtbprccx?=
 =?us-ascii?Q?Qgnwaz0TT3ZH+dOwGRB5RmyrPUv6dSvhHPX92goHeWKucOfD2Jv8Pdnaxg8j?=
 =?us-ascii?Q?M7iGK8SVYt825+nhtkfvIS2UDFnhdu33O7dip53GGR2SbywkwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mbT/WlUye4N53d0LEGTsr4ysbXa1uCzpnDigPFRgEAmlkhPTD6+X7gWSk946?=
 =?us-ascii?Q?aLpNPtzqjFaBnfniNn2TMfl/HW3Rxkvq1o2FU33T3D1KAHOd52BvCV/P9KbF?=
 =?us-ascii?Q?tIRS7cs7wOVgpMki7fPoFDpHBe6uNk5y94ZSmV+MXL3d8PIchaq20IPqWlCB?=
 =?us-ascii?Q?Qwd8n1kv9AtD4NoA7qFoUskG/BpxK7LmS+mfHoYA4aOG7QeqGXDqgXcFpgyl?=
 =?us-ascii?Q?iYCSNLQ5m08/G9QF7OGeqvTzkWo6O22Qbsv+o13WKOV6nt2ufdCpMnYWpG45?=
 =?us-ascii?Q?INIAiBznYjgMlFbbaVeRViLLefb3TtkOBK5RuaOLui1K6tUtnbroCZYANBhU?=
 =?us-ascii?Q?i84DhsX9+jc9Vet9zpKwpjU34klOafVyAIz7JSL3scKdaXwKB0MovRrTankX?=
 =?us-ascii?Q?MOstwHV9TrTtYUlJsRUImk8KOnRCOf9YZthokepQ4Cvxsx5BnCYx99XFzfAr?=
 =?us-ascii?Q?F0XY10AEOOS4X+zZh9kvzUIokjsFC/6IaX9NGbjIhKaUg8eVSMFSpXrcnQYQ?=
 =?us-ascii?Q?2iM2ktHkRFPOd6V3+SmLkNQqF8UqIh+lFlrSdzg0BPWGd71qv+i+bcIuhW6E?=
 =?us-ascii?Q?LQYn8/Vyx3qKFiRWPrfKYmf6CSg3RnFZ9xI1QBx/bvYIfQ+3/gX7NpcIhu6q?=
 =?us-ascii?Q?6xwbnfGwR+jE1DGikgGdxim4f7TUoTwHVQpQpjfmaxPSqNuY4DusMgd3s866?=
 =?us-ascii?Q?UajT5qi7KsCWGIqraMV+yiXSmC0HHLlPcc0+WwEcEAAME8TieLUqjNqJL9Yl?=
 =?us-ascii?Q?lnu3xOuQ7QxrGtdoGXaAnBiAyi0sk37V5mvqZbG0gj4p2x/Wp0y0CsQRdkzG?=
 =?us-ascii?Q?q24J34SIqNo2bJPZsNZdILO2ReDFdw31DBvQKw7CLnphk9Du5/EECetVlyX7?=
 =?us-ascii?Q?kdhLlWPegzklK78eNC3AxL80iTl8ZfQupF2L3brWYpt4gbfh+k6YN03zSDnK?=
 =?us-ascii?Q?vBF0Qx1677fvqTLeTJjKzHidzCmvSagIOM3TZbxrjxBMsW9VQ0Fr7IhaQUEZ?=
 =?us-ascii?Q?1fo3Blq8K7kJ9Bz0op8xwWAUMoXRqchgmXe67e/YHBq2CSAXIrXJZl/QsQgJ?=
 =?us-ascii?Q?BQw389zNgIJZMuAyXjd+dYJNFRtIQZs65p/1waEjGB3wIJrsrnT1KvRYHslX?=
 =?us-ascii?Q?fdz9SRdh2UnBOEmS3qMcioDitA+UILPoUQN2sHJnxCtDbfYORbibYtaMzAtp?=
 =?us-ascii?Q?vAZjgP9znLu4hbKvAx4oMsJ6+lNEi9cNcR5HrEGGcjt0mLkHz7AaRLquRAob?=
 =?us-ascii?Q?Yc/JcqRjMg91vasjBR7A2LJzAbCOaqcDDB+llMO177Now9qBPWNOH9e+wXqg?=
 =?us-ascii?Q?MW51HYeNF1/qKGktf27bhWHSYfkZ5LVN72sfdwTZa0TIFVws+pqj1S4lAo1Y?=
 =?us-ascii?Q?dkwfqj8v5VESyOAXYfMdRZYUg6KDGVGnNlV4XNbFx+jLhziPd/Dm0mg4Envo?=
 =?us-ascii?Q?QL5iz84/jUkQDQbKKgOgALGFbJO3OPSYGM2NSxObgqbvU7DdN5zaatk47CLB?=
 =?us-ascii?Q?h4GXphVQmBK0DIRYC3ayMVHTu76eIhSg7AQDr5JeTZ3bg4dNcL/os1G2k8JV?=
 =?us-ascii?Q?ecwnR+NjCkqN4XfoeABysTnYNWJVCPrWh16Uvpwf?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f0fcf7-ebe4-4f04-0e06-08dcc645911f
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 03:08:47.1914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XRBwYKkEJK2mBcFciPpMBG1QEsTmvMIot++8KNIBmLRqpxDFO4y/1VOyIK2H6FAuHNeUJ0KeyLJVc1IVYTrvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5512

Add COMPILE_TEST to support code compile test

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 drivers/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 64cd2ee03aa3..ff669a8ccad9 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -89,7 +89,7 @@ config HISILICON_LPC
 
 config IMX_WEIM
 	bool "Freescale EIM DRIVER"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	help
 	  Driver for i.MX WEIM controller.
 	  The WEIM(Wireless External Interface Module) works like a bus.
-- 
2.25.1


