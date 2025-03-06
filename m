Return-Path: <linux-kernel+bounces-549252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B807DA54FA6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D346A7A7772
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D1720F071;
	Thu,  6 Mar 2025 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kLHdFKCA"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826DD148FF5;
	Thu,  6 Mar 2025 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276366; cv=fail; b=G3ijfOUR8U94uaWkiqMRiK4eUSNE1MgHBrt7FPnLDWu9uhrnrytAwy6q5L/4tkaky+34XgCMXkfo8CnQjikeSl5gk+DvE2yABet7+0q+K21CoDsi2Vj8RfR5QfcwvTWMuC6NQhrHxQnMUamcVsJrJUkKoS8myo2X4IBfb+Vuuiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276366; c=relaxed/simple;
	bh=o+bjQTxrC2+pSVwtOo5VYKZNCMgQsSVVyPlApBG4oWI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GWQU4Mx+1+kOoM7XAEok1nQjDBBVfblS8tFje2lM7iWfw8f2gxOYXv5xFWAcPBf8x3kHSLPP+dbT4nITHEY/blhUK44AaQZwDJBHDdIYpeO16enxbLS4wSKIg9gxi4J0mlECtwJHPjo+mycRljbC3kZ0uxSZ8R1G8pELUUZ7LLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kLHdFKCA; arc=fail smtp.client-ip=40.107.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRYEmm53KTu+MPUFhGHvCUzI5/LUv3KiVFWw36iTTBHl6yX4udrGOoKAzc9RICXqVlJ3SuRtrQsKYpyrv71+OXpXpIa+232YFd3awY4qCoVHFPNYuBVc1o0yB4EJYHLEHIK5TnK235r9E8m3dZ/9wApbw+r7Dt9i8bm3oIvNCfDwJIiee31q8zTIwDECirXchSHIery4QtUmbtPVcSis3EFQJa/tKzje70dKKKMZw6J/R7otL0cmgfHwzj62z4QefdaERhTel1lrPzgd/JOc1j2ikabZX7xzZqG1lViyvn5jxixehA4kRWDwGSirlq2drlJrmr3rodXzlZgRbkkLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFl3DBk19Nh26K9HEFcXjYVM7QpcmqwJ42XnF4B8vd8=;
 b=QNo3022xA3TT1lAFnQpnP+HNz//uRcjm0pObJ81Lg52PrrX3uAYvDtYHPyt9cBgtIcLWZCAYSBgoOLHJiZ4kLLiqMtar0xpRR22y/todUbqz+ZofmBhOhBX9kVuY1FZwf5ZJBgLTqvDAFMhhYWOj0f+x6elpnKat3St4i8NB3vzL2PJjBTBmRVx6MwHoKO2WOhmoTf9pQOZdJYMOEUCERxYkIxVxduIfpmZvYQG8Kr7EvGYs9a0/je3aeoFDeaY/+KyRBP3paU+TYY9KGj8yf4qq+xTftbK6TgBcJqepd8o7uNcBuV0UAVZjcasFnYV2nMFikDNntCpRdQXih5CR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFl3DBk19Nh26K9HEFcXjYVM7QpcmqwJ42XnF4B8vd8=;
 b=kLHdFKCALuay2YIF3lFqSUadVHXdUow/thkC5rRCzMkgFdOH8LgijH9+uCkHZnGohpBKKXzprtZhyrEl6RmW53Mac3jznWwirzV9L3VqbO05PqThm95lCjetcSWtWcODTvwN1pj43indb3UwCNfNgk1dtoTAZ8kieOLmwYmD9IzOvk0JRZw2fkPBHmfohSUgPd8tbpU9YLcg3LANSQNyjiDXNVpbDg05wDj7pBVWb4AGWFY5EV396FjFbJ+jz/aGaNxjeFRGuyRZLEd06N0d4xkv9qZ3Udafy1VS5nq5b/ygBGPFbD6899lY914jy1Va/lB5btgd6YMcQWT2czt2Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7746.eurprd04.prod.outlook.com (2603:10a6:20b:235::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 15:52:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 15:52:41 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	linux-kernel@vger.kernel.org (open list:MAILBOX API),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: mailbox: fsl,mu: Add i.MX94 compatible
Date: Thu,  6 Mar 2025 10:52:24 -0500
Message-Id: <20250306155225.99807-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: a2651985-4e92-475f-285f-08dd5cc6ed40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?coC6JEwCeWff1xsasTCikMwsVcycmwdrnDw7pW3MuVb2QgR7tFaL0MQcspSl?=
 =?us-ascii?Q?xTEBCIkQy860VImGTqJ7dvWOJT5SHPulpntU7LWXE1AIomVDwnWZqmXwIJEi?=
 =?us-ascii?Q?aJdhrDmiRFsJq5U0iHxqev/rjO/ult+QHUfKMTFIpwTqSimFkKJuUZ0VWQy3?=
 =?us-ascii?Q?lH9mJge710/8t7V7PXuEEAawnEnbIo0NA1Agili6Jw9Y0AOgeVcPy4Yvv1Ij?=
 =?us-ascii?Q?hSMBmAqHiV+B3cClSm2yb+d9piqkMWeGlYxVOdIMowFGjyh9FnEXK7k4UlWe?=
 =?us-ascii?Q?44/E5lkroFoZ/k6bB9kxlxvZ5+7iXP8M6T9T/JvpUFs0e+uIfpN+yLRNLCxh?=
 =?us-ascii?Q?gKwPKfhFK1mydsmctPFrheTls2KAIstkxK593RC4pakEb7WD92V5ZUrIRVQg?=
 =?us-ascii?Q?BtNGkh1gmDUf4Xv43ZO13VxDbqEpmZVm7IGveOEqIQgOW/upAS4Xe9a2ERwo?=
 =?us-ascii?Q?IzTNILBVmgBi70aTHXof0Sm6BqQH/0KVJ+6VnWz8tQ1j4GyT6+dO57wMQ0kk?=
 =?us-ascii?Q?ip1FAdw36cx9/CT+nkRuK7Wkllsxx0dXMO16KA+1+Sl+13RR9ukMJevkdXrK?=
 =?us-ascii?Q?WvpFA45MQwjTcm8kLP81nuamagchFZ7XOHmVkOEcjK1DdB4F71PDo0aVpWAS?=
 =?us-ascii?Q?vIyBOiiTs6nCGvpvbXjnjIHxsGx6M1ImskqAW37olQIyCHXlpUqxCozTzed4?=
 =?us-ascii?Q?kl4JKMXqzpXCGqan17Q53SGD1B2oCyhLfDbmv6BGrK6yqTf+ABCI9ei2Qvac?=
 =?us-ascii?Q?SdLjB9O4H4jpZWoWhHg8uqKEapynI6aEj8vBRmsew9jUjDiSRadu6/JS2yq7?=
 =?us-ascii?Q?rN1/d7U5W4CSoJOkWc/ua6XCfzQ0IqNCW8DFwt80hVktr5dlWeShP9CbOCsB?=
 =?us-ascii?Q?C9lb5JCgVtFgBTnB+RgI9srHl0okTZCZJP4Pw01ywKfIp4aO6rVxu1XrbRZz?=
 =?us-ascii?Q?v4YDm3Q/q10GtOyMvDQ+Bt7zxTF4ALz/urG1A2p+5nydWTnG3ERCRqV/+awH?=
 =?us-ascii?Q?0Adc9fDHHxxmI/W7PVqfoK3sRJAmamFIW3fyT9WkkEcwHB1GANFO9Ac7p3Uj?=
 =?us-ascii?Q?Zs7KghP7R5FayXD6K71bV/hAfuZ5DlK4d66fkoe+uj2wiLMFT7x+S+x/qFWN?=
 =?us-ascii?Q?9GWqCcyLk+KE3SiAFONeCUXnL6b1U9cXlVHC8oavnmerSR1xVk5mCKADiHe7?=
 =?us-ascii?Q?krzzenh/4FoGHOYraaFfR3yK+jjfRS2+l8BlCoE2Ypfn2wVNuP8bW125MyES?=
 =?us-ascii?Q?hupLoH7ShxAlwJE4FBE/DQRddAjOxdZRdIPfXSNfeilh3PN+FxVd25bHb++L?=
 =?us-ascii?Q?DarIubckUoCh/WJL07jA17mhXxcaIA/YMND4Qz6g/OsaL6e48MPJ0O0X0Ie2?=
 =?us-ascii?Q?fZAsFv6TuRXkkwVXlYUwz8lIYpfbJ1qHgD4kig1uRa+bxrWW11q0/YMhlohO?=
 =?us-ascii?Q?qwD/SeD4MtCyCAUub/CjTr77cF25FfGk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TQG00JkssXzh2iIoCD1kwBFSULyYTw2Or3ZvSP4xkINiN9DCgSuLetT0PKGG?=
 =?us-ascii?Q?hn+XxGXONc6o+ZEUVC9GwdDMMk24YsxRY6PZ6tk8zmCjnO/kTcb78clLyLyJ?=
 =?us-ascii?Q?nW9meLnt1Re81ItZwsAvi7wAGr8U8Pp0CyzDqoMsuggXFIdTbfgBW6jzt8wy?=
 =?us-ascii?Q?URviP717gronhVli+Doew+abY9Z3u5jpPP+FHda6bwkcqc6mrC2Hq3Zzgndn?=
 =?us-ascii?Q?Hj2HqGUteDZtH4fR4fQGnxSC1xDBlMiz1psH14in2ZYe8TUQbWQ8gb18XvNW?=
 =?us-ascii?Q?5MMGgIbijUnZhbVhNJpJhxw8mvCq3najFMCYEAzvyK0/WxmCu3/A/o3mBlqZ?=
 =?us-ascii?Q?bXtIUybq2LYPlgTyxpbVkrRnL1+FM+ps3ImiGLyrOJp0Lk+ncgZfp/KO12Io?=
 =?us-ascii?Q?2GCqao0zR/nmDPqBBEJiPI6bE0hFzST5OnZh98y5VXZJfqwdqH1o8kVTkWD0?=
 =?us-ascii?Q?0i5eXrNmGhB+5ZVNz3DJk7oCIj4XL7qG3VPEHwSNhkZgeqekJhBd10JSzevZ?=
 =?us-ascii?Q?PXpSVqTK8W9lBN5HbDbNIx0DMIVw/72H3sHuznFzU9HdlovOGO//cYWVYzqP?=
 =?us-ascii?Q?lca8vcIj3xck+Ex5zW5quXmX3ssE8KsFGdwIXrDL8nJilWDsdbdyi8Ie3/xj?=
 =?us-ascii?Q?FS9hYB+Rj7/Ceinln7/P2BHYSSiFdklUp/oXiKuL6vzh218FOoAdxMj4RaTI?=
 =?us-ascii?Q?8KV43RLhKA8eWejxGaiw1dzL0bi5b+Pu+L+ipVKWzllKeOIkmQcg916wHClL?=
 =?us-ascii?Q?Z0dR+zkPDoeoYP4VfocGoh8tUAbc5NKgPc/x7TV2/LEOCjBS11WolmtePYBU?=
 =?us-ascii?Q?FCodmgNELAmfuXH39rcgfVR7He6/QU8bSHauBdeH3NtjXOthAlk7rxICVMtO?=
 =?us-ascii?Q?okxmpo12glo9LSDpUghoLyrbuVGJjO0ZzmZn0pTFKiZ3aMCm3xpQEOR/JU7s?=
 =?us-ascii?Q?k/SXt6KEreGSlk7wn3JFzhAzjMIDh6yM3lG3rpV7Z7s4oljff/eim4zaugar?=
 =?us-ascii?Q?wrZn02jufZmVirOsFY9KbqdSc0sh2QLw+Az5vlyViQ98fjW5qN11mzzxrs5K?=
 =?us-ascii?Q?GyWUK3EtI6w+QPkO6xS+CENJb4ia0TaVpdIxEMMpuqjEzhjnDjHOYLN+rvJ3?=
 =?us-ascii?Q?89xco5zK74JMsYOuFKnjJjAmvdao0a5JssIRedcnRHFK2xmiwo8ohev1FenT?=
 =?us-ascii?Q?tAcBZf0XKkD+7QI08bSZQwaz8TazWNbCe9t9E8N+6JIHO+WxFfhMU5GxXx35?=
 =?us-ascii?Q?Kh6t0fsIIxqZmdPCfmGDZ7tNlyBoV/BdgI6OnRDZGoTX6n1gsznNSgvkzC4P?=
 =?us-ascii?Q?SOG3ISjl22gxaDAfkvfa7fXuK8S66J7Jo6WjUe6fsROgmrkZSBvphBQMqOOq?=
 =?us-ascii?Q?DfKzeC1p0IXcZDpuFVu0rFKvcXkdAnpKq25Zxn+YAOMGyEm2zBzUs5Tv8uJH?=
 =?us-ascii?Q?7wjXJAqsFeswJ2kGxV+/OPAErOkbmGkuI5TUww8KkxgyntElqcMhmzemW5pB?=
 =?us-ascii?Q?Pl7s5d0QVSBTlPrvhYnfTQEc3fohDf4XvbFAwAyciB4H9z2CKWPrCR9jcYmC?=
 =?us-ascii?Q?Dt0d5FYDy6GZF4Lh5ooDNQmh9YkXqXZ25Zsi97hO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2651985-4e92-475f-285f-08dd5cc6ed40
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 15:52:41.3562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nYUGC7SPTx0h96jXo8bCD7/3k+O4/iQ2y2QEEykuaJtunL9qk/EAzmh2ne1dcPvbgWr+ajzHllFam2axuvvyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7746

Add compatible string "fsl,imx94-mu" for the i.MX94 chip, which is backward
compatible with i.MX95. Set it to fall back to "fsl,imx95-mu".

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 00631afcd51d8..581425aacdccf 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -54,6 +54,10 @@ properties:
               - fsl,imx8qm-mu
               - fsl,imx8qxp-mu
           - const: fsl,imx6sx-mu
+      - items:
+          - enum:
+              - fsl,imx94-mu
+          - const: fsl,imx95-mu
 
   reg:
     maxItems: 1
@@ -142,7 +146,8 @@ allOf:
       not:
         properties:
           compatible:
-            const: fsl,imx95-mu
+            contains:
+              const: fsl,imx95-mu
     then:
       patternProperties:
         "^sram@[a-f0-9]+": false
-- 
2.34.1


