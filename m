Return-Path: <linux-kernel+bounces-219725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC5590D882
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FE52B35119
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE703D579;
	Tue, 18 Jun 2024 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="QJ/s0Hbb"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2141.outbound.protection.outlook.com [40.92.63.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EAD4D599;
	Tue, 18 Jun 2024 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723590; cv=fail; b=eW7ezhBetvRhMk6C6vvWiJcXFT+vJgi47GbbQYy9J6OM7cD/LDadItVruHyEDHcGnDKsYIghwlGcYLc6EdSYCGPgl23SydqHoWTPtTgX6JFsFzM54ytNpnWBoJETBDrX7CaxznTdZ3Ox24LvkxkMo+z/zaA0FNNgbCXsMuChPjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723590; c=relaxed/simple;
	bh=aM6zulsjhqf5OyjgnMz15UgjaDjLA1y6pf0utKpZsr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hojzP5JOMjuA+z1CDlKqMW0Id8eiZb9Z+WSDP+EwG4URa6z8QIX+bz+wKpemD7Vw2wY0gEYJxoHt4YuI6RR8/kg7B8jW2MlIMD/aOsBIUW0mYuwcK/tpcUaNsXUQS4tFRB2F6KofF4iNfseh+vhDtHEbLlSrDRGj6Yab0aU4HJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=QJ/s0Hbb; arc=fail smtp.client-ip=40.92.63.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E91G3qBiW7Aeo/jHIc8LMiO0vZQxgIO80zwU3216e/byIulmtDXHPltLLcuBF67is1BMJK0yA7xRZOg5oSsQV4jx5LThX6CDEPsG6nM8LsE7058Jaig8Gc6pdunjvjJTt6dYhNClr/NJuraDx9N9NDC8AWuY13VNvWckVwe6oo1Jc34hgNoSQUg1jIJui/LYSWeUAVQ+i+qo3pdqUrIHOIckpE5C91OmWlNIXFCne1n+w4qwznfXfBDKctj7qssq4PGkESTlzRm+IwwkaTzX4fghkUT75oK6sYe1h/E1qbdprd+wCmdGE+oLzd7NVpC9JRAOmaNft+kYZBzRnwi1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKTCwDIG8pgERnO8qAnoPLFo+Gwfzux11mjqdeBWce4=;
 b=SeZXUJJzo+XhtRdg9V8Q0uKb/2XSGxhmO3Hi4IzLovEjxfCnWt2gYiV6ivLDUdDcN7BdpB3RHf6i+4jtPxSAWLlGU4zaLuTCCWeceP8D5kQDGsQcrUr2ZuWNTDMrUPHr1ie0HgSUbqmcfDwnsWhK4Eq572WfHXPCDZb6xkedFfM9PAqwPjSwIqVWrSLRaQ/MjXl8TUto/X0gUISaa6mmsibIijSJnaXVVdzSSA9+TVGZ3lHygckMZ4/0+qUyHxSa9u08HQw7ThnCyl2OlFdNe2IxBrDhepNmCCEpH8Sz4R2SanQUq1ZQrK+OOVsXa5tr3T0NBwtQqg8NuCGJtOf2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKTCwDIG8pgERnO8qAnoPLFo+Gwfzux11mjqdeBWce4=;
 b=QJ/s0HbbSmALNm0Yshrft3KLuVEHpKNwcdSskPY7SK1DPakxHHmnTYdQHFBsSmEfmi4XdHTBtBLd9Q2XvTXpeB768mpyt88lr1N8faZaUB70SakNpmBfTsNvjtQAJGuWWN+9+jLfW9KYoUE9cx51+WsbFFqtvVlNGZgnfuq0riVJueLNBT7/bdCtwqelUgzJstilsUv0q1h4tJD/j4C9aLuzvpNIM+TMUl1fj5h/cxrY02nDX2MFnGzEE234hF3Ieii+vYCOV/a20GQYFcpTD7sq3eN+hAnfVO3eg07xIyx8SlXsZ4F6n2Z6k4ONxsjeK7VdujiqFFkuZ6AKWCG8Vw==
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:9b::8) by
 SY7P282MB5268.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2a9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Tue, 18 Jun 2024 15:13:03 +0000
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3]) by SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3%2]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 15:13:03 +0000
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
Subject: [PATCH 1/3] dt-bindings: mailbox: add Sophgo cv18x SoCs mailbox
Date: Tue, 18 Jun 2024 23:12:33 +0800
Message-ID:
 <SYBP282MB22389FD1E07BBDC6FE1D90A0C4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <SYBP282MB2238DE0DA19C6EF411B2356CC4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
References: <SYBP282MB2238DE0DA19C6EF411B2356CC4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-TMN: [ya4n5REVWOzKP9qb85v9Qjesqs2FEZkm]
X-ClientProxiedBy: TYCP286CA0266.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::19) To SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:9b::8)
X-Microsoft-Original-Message-ID: <20240618151235.5846-1-d1581209858@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB2238:EE_|SY7P282MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: 5afa7c5c-eba5-474b-f3c6-08dc8fa925ca
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3412199022|440099025|4302099010|1602099009|1710799023;
X-Microsoft-Antispam-Message-Info:
	A69YsiXfAwnkK2REcDdL3iBqSrLwxZiqpomZwJWxOS85yoFXysMOu40XbHZExopnEk+wTRUE/w8NVfmZN0vF0ATRFhg33raoZrYkZzYitJiuAzHhGmS0aCXcEkgUJcYpNhQrAacFvotQfLN1LS9HgtWCWi0r1t3VAzmaxSkxjR7H404n50yzqJHuCNyH/Dis6W2nFNBi56f507be2j0Zg8effjnB5Au/DLh8EsVlNMvWlYT0GjIRe+AkjDVpaK1YBGbMQBl746fo8kvQA8An/CC8+UY+LjV6SoSGrEx4HKS3/udrRCea4AUIWPwEqN2AHeHAb1dVrl/NUfh3doPK0ndAR0dyiJWgOXZNOODZHuas4n69uTQWa2FdwN4+SSpxX7n5SD7iLGI6eeyTCsqwoeJexCY4jEXJj2ZUkEtUzcIKGqqIYLjGn2whUgPNDqNE2JAIP29+AIBRcNZJezpi1S2t+js2Gh280GzaCjBHTRNfjlJjbuDVQvI9FoRnkwP/Ep5OB/cDROTlpr2zxM+giOyaHIbLKo0p0ssmTBeSweqd2N6fdCHVw6ytRzpxJq/kbH+fPl1DPjlp1v39pvrbp40fPT/Ns/BOFXlVz5vk4CadQDpX9KZyhOr3ttTjFaXCkAZbCi6hO3PHgU3M1XcryA/lQYWqytPsxyuw7WTIoCsJbN0U7hfKId/UM54ojZmitBNu2jg/ZH0SurlsyCpUjwVOZ1FBFlUoIDyOE9381lA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e5Obq+QQMaaIeLMKpCq/jL2PJEf59tHjleMwN+dpu35S94YBRNcwZ4KUpWDQ?=
 =?us-ascii?Q?K1o1Dqth3bE+Kv7nVUiSXiHBUsMjW2ubUY/uo8GWygtjkHNg44KRmL+W2Rom?=
 =?us-ascii?Q?w6V7Z7PW8Kg1JrCk5/4uFZhfZA7MQd0azaovg+fV4abex6hnmHp6n4/M4ibJ?=
 =?us-ascii?Q?Jz66Xsmv1pKBInEk0nxnixgUeHfjgy4jmwfAM71AYbAzWrmlzEuc02//SbCl?=
 =?us-ascii?Q?fNthah+cuwclyLJiUEQwI4uM3TCyTskY844tWCL9EcQbqwo3Ov4AUk4S4O7F?=
 =?us-ascii?Q?dDmcG0Fw1Ixa35suOLw+B7l28VZiThyuEYS+XPQCq/nKZV6bWJeG3XV1cUx4?=
 =?us-ascii?Q?1Os8KvtxhTQqgg4VA4KbxyzJfoXOnR1mwUaBcnEhoB41d12pzg8cisMuGa+t?=
 =?us-ascii?Q?PJP2rrHt4dIKlON39B7BuTirxgfQTs5GgjIiEOUr1sIEQa/fEYsqEVtELz44?=
 =?us-ascii?Q?FQW9U72dhJ5fWHM2+LMNmaeEPT+RzxkR9Y7v0Ymyp9rBUtQEnY/HmXWq2Wyt?=
 =?us-ascii?Q?Qw11gteTyXMCVHwrvXnkuB0Rz7z8sYnmRDnduSKdnn0ly8cE0I69f6+JvBzR?=
 =?us-ascii?Q?AowwKvhwlYZBycllQ/y5SPp/CiWjFsneXX+tGhip6gNqrB7zrg6ZHn285Q7c?=
 =?us-ascii?Q?A4KSCHq7QZm9m7jrgFHrxc3Vadvfdv8ao3DET3p1VAgTs4gIT86lqik1Vozg?=
 =?us-ascii?Q?6XKPxk2Y0HV7zejOPpI+5JX8AOUq+HQRODcD9em9vjPlOAEteLRWlC6xzWzC?=
 =?us-ascii?Q?rtNecY6D5jr3x67ZH/j9cfIJP6ZAf5YY4SpFC+ptdrcKl9cmwXEkvHofxby6?=
 =?us-ascii?Q?d7gJvsG+ZTNw0nSu0aOXqsFRvyQBaofgnXiGYmdi8fiQ1BPXyyE5uqeoHBu4?=
 =?us-ascii?Q?O/zVIoPxWgshGGQQnZeDg5NXHpJ7fQ8jM68LB0SJyo0OfiWy0lDY5o1yNYa7?=
 =?us-ascii?Q?8+5qlKfDaaoGwo0qOIPj3A/vqx/RIOx382LyAIclBbXgIqCujYyNpAXx7uuu?=
 =?us-ascii?Q?5LuW0lPsADOBjxBywzvofas+OfQTek4Kg5xLcqJftZZ73KMkJFT0NLglHH0A?=
 =?us-ascii?Q?nChtYnekn3KeSBY1qTgS61rdsaYGIN6WxWHj2f7+Pewr7XfzX11tIBK45MF4?=
 =?us-ascii?Q?2VbPrfJs8oaVSDM1N7FQcRUKipHnEMmnj3IRVtDnu0mTddCaMUUojiPzmSs+?=
 =?us-ascii?Q?4qExuemIMr0Il2Dt/qObEjt5ajtTRW0vxEoQ+cBzP6WcbCtQVdpw5cpBGi4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5afa7c5c-eba5-474b-f3c6-08dc8fa925ca
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:13:02.8511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB5268

Add devicetree bindings documentation for Sophgo cv18x SoCs mailbox

Signed-off-by: Yuntao Dai <d1581209858@live.com>
---
 .../mailbox/sophgo,cv1800b-mailbox.yaml       | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/sophgo,cv1800b-mailbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/sophgo,cv1800b-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/sophgo,cv1800b-mailbox.yaml
new file mode 100644
index 000000000..e1868aaf2
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/sophgo,cv1800b-mailbox.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/sophgo,cv1800b-mailbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo cv1800b mailbox controller
+
+maintainers:
+  - Yuntao Dai <d1581209858@live.com>
+
+description:
+  The Sophgo cv18x SoCs mailbox has 8 channels and 8 bytes per channel for
+  different processors. Any processer can write data in a channel, and
+  set co-responding register to raise interrupt to notice another processor,
+  and it is allowed to send data to itself.
+  Sophgo cv18x SoCs has 3 processors and numbered as
+  <1> C906L
+  <2> C906B
+  <3> 8051
+
+properties:
+  compatible:
+    enum:
+      - sophgo,cv1800b-mailbox
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: mailbox
+
+  recvid:
+    maxItems: 1
+    description:
+      This cell indicates the mailbox controller is running on which processor
+
+  sendto:
+    maxItems: 1
+    description:
+      This cell indicates the message sends to which processor
+
+
+  "#mbox-cells":
+    const: 1
+    description:
+      This cell indicates which channel is used
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - recvid
+  - sendto
+  - "#mbox-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mailbox: mailbox@1900000 {
+        compatible = "sophgo,cv1800b-mailbox";
+        reg = <0x01900000 0x1000>;
+        interrupts = <101 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "mailbox";
+        interrupt-parent = <&plic>;
+        recvid = <1>;
+        sendto = <2>;
+        #mbox-cells = <1>;
+    };
-- 
2.17.1


