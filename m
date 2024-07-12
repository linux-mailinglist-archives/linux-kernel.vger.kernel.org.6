Return-Path: <linux-kernel+bounces-250980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D17D792FF25
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D54B23809
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ACE17A5B0;
	Fri, 12 Jul 2024 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iX1a6xm3"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011021.outbound.protection.outlook.com [52.101.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E9A17836E;
	Fri, 12 Jul 2024 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720804024; cv=fail; b=Nkp2lHbRzl1RgEvO0gOe/cFpCefp7M9f9hoVRFhJW34nsKmXGydWz3HETTA5oUCy5MEdJ6+4hwdDf3TgyyOI7rL6xbzR46+YpXddLzRN15WyLm3ycjdnuhSa7wi4+3GKy45/zyf8pwc0uwswvTRDuZpy05wN14snMbbUyQTfJHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720804024; c=relaxed/simple;
	bh=aHrdmbOz2MM5HsXHak6b1MCtDok1mwtV3KKVfgHywhM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UzZYJx9xPkNUNYPEbgoobEKlCbzw8Cd0fHz1nfBiRVXg3W+OSvugX+4jyREnKTaEE1x/GYaP9PoMeOYyfJhehehzVdSqDnTXKWJLyoIOCgA0bJoWlhA24epi5RyVyCEUn6LBqO3nm7rwCXYNtglABIQhp/QTtKcH3ut9kFvMbMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iX1a6xm3; arc=fail smtp.client-ip=52.101.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggzjpdknmvSgMmVzSpuyeQE5gAHkleRcwefuHOWZe42OQER8qH+kL2WbAec4ky8hE66tD5GfHRc+/lajsBn8nJImvzOSqasWmE+njArzEWhO8XJKpjFPqF6yPunymkVsdn7sIWkrrv+C3jysztK4dbVn2v5j8kyc5Y+19oCTEN7Z+ULMGPFxDKDZQTivkPi9R9usPrywixPythJtU7GCoIwcTXEwZAWRNzuSYxS4ma7t0jXZaQzItfTpvCKQd2EQ9TGt5c96czbMoEIlWJjK2wBLx1PmUUZZiiiUgHjkJjIyxQdd0miwHyCqIuZY+SI19lpA7XFeRc/v8836Bx5a3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjPUtpkxr34CmDx7g7lN7HugJ8CCI+KKQ4XXqJDkjQE=;
 b=s7kpWv1aW7s9Q+AsQyhGkO2DbdO6fpOLBKBbSwfN/F3CTrS2qOMdFFIpYnhcCBrb4ruRIciScGYjTSuy6L/CguoCucxN+Fnrkh7Td3GmFmgKceTC2hl/s/GSrfwOmedEVYzOZ5r1KhJrLfkwMx7G82qHhuiGeXkJscYWzfSi28rqrNYlWjfpbg201jnNpaMosibOof9RpUqYM2Li30AzAXNoNCo83FDOsE53bjhUqYTMHy0zB0I5/vLr2zoGqZMNQdn8Wc440kyzer8vxejI9zWrpl1tso8AzPoarFGVriTIXnc6MY8wlpmc0ne5qo24iDdoYPRwXd9+LNOVMhaHJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjPUtpkxr34CmDx7g7lN7HugJ8CCI+KKQ4XXqJDkjQE=;
 b=iX1a6xm3GlGZfnw/0kIEAPgtPMWEJkmXv9rH9cGzboaMhKRy6ZvssH516Ud7rwSCBOoyEK4cgx9SZrve+gpIRfQUK/ni/1e2XNiqGvZnU0r+kHBuWgs6Jj7L0zb7+cv33/46RLoCaaqlCnIxR98uT01IKlgWkjgvoGohxvZJWAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB11075.eurprd04.prod.outlook.com (2603:10a6:800:27a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 17:06:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 17:06:59 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-i3c@lists.infradead.org (moderated list:I3C SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: i3c: add header for generic I3C flags
Date: Fri, 12 Jul 2024 13:06:39 -0400
Message-Id: <20240712170640.3635096-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0045.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB11075:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f6fc23-463e-4a29-079d-08dca2950af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g+tb+1Png+sJ7S5oW3n7Yl4uVM2hmbNizoMSEAXyfn1g5wYtQf1lDp2N4Tw/?=
 =?us-ascii?Q?pLMla0z1WRdkhuuBMzv26O4CGZ315l4Xqkk6EBesgjNKkZVnwkhz5cU7sGQY?=
 =?us-ascii?Q?v+lbfLqhBTUFlf3zcZHcvv3WILcdQaM7JQD0gvRzoG6LSu3mC68PdG3ZCmPO?=
 =?us-ascii?Q?nXlqqqMxrIK1aIjNQAPU+EPKxrhbm5YxSOUZY2thgHYNZPAb0IqLYdPVDXSn?=
 =?us-ascii?Q?wEAXIP9PTFuUeJhg90eDX80+0tR/L0XJ0GZhohuhx9rgMpbNkM1+O7w8zbi4?=
 =?us-ascii?Q?MaZEzvmrDVnRxsIZrYB6CxaxdZI7ozlSxIix6SGAL30TCZJ9BRBTwcsav4nu?=
 =?us-ascii?Q?hxtCU7D1LbWa5Z6gUOPyhjzZo4l81biDgD9H1+gjtbnvwv72ols4hNg/UXvE?=
 =?us-ascii?Q?XPwVFEnmuK6SNUKiIbBtv4MP95kZWU5YatYcQ5uk3EMhWQVqIsaT5INqSu6t?=
 =?us-ascii?Q?80Wl2Mq6d/gBgCJyUZZECqoJ5fTO5NCJUtOUMeTlt+Fj82omazJ1d+FPBs7Z?=
 =?us-ascii?Q?9W+6NG77W+APWUEwhxQT8wkwgUFxFSp9hBUy9vT2d4dCoDiKn0yYyreRz7CF?=
 =?us-ascii?Q?VfXGNNksDJsaiIJ7oKJNt6+6KwcJ/BNdrut42vxEac0awgLT6YPahxZcKYGs?=
 =?us-ascii?Q?m0nqur7qkq+3qUVHgC4Dkrfjg/VaP1+xJjXsuHNxwpvXB3h/AeEiEi4ZjU5n?=
 =?us-ascii?Q?QfDA/tV4FdO5hYolDzWib+I0Dv5fKv8vdil3Ue2Ffnyk3L29MguTiijssXfD?=
 =?us-ascii?Q?LqYTblyqprNtqUFmhwr9L4KAnYYriIwwlwySK26EHBzkSsh6TD3u+bDTTQ76?=
 =?us-ascii?Q?4Xy8PIwBkbUdG+6Lhzmsdjq72VFEtVfJl4isy8wl6vAMnBXnJBc207s3ijni?=
 =?us-ascii?Q?NSkOF1OCrWHw12y9kq1l2Od1wD1bWyiNan9Ji5gXQXW3SU2WAoKvDdlXDEqo?=
 =?us-ascii?Q?T++22kCY/ktGpHrzaWO0WyCzf/y/ueHUj50Bk2K4SYR7XEQv4/nqb/inM5+t?=
 =?us-ascii?Q?RoB1LS7vlIPYSYKHbMuhApdChF8sk9auTTuTKbhrJQSRdpTeK4x1WHQtiarL?=
 =?us-ascii?Q?WNZhq1EgCHBnI6/yjeHZVoBWZEKiJIK9xuAxu4CU9a54+A5HfR1OD5EH4Z9j?=
 =?us-ascii?Q?Ez4Aeo95wNLAIsSph2AJ/PkenUI9JAthZxi/kWo9xX1AbIp63BuKfbzU5lrT?=
 =?us-ascii?Q?kkGRGZVzDI3+0vrIJQyZ2KmAtxC+yJQYOMwhQFqKmCj71fRTbZHM52wBr+uP?=
 =?us-ascii?Q?EFvoqd4N+9rPyH2Wi1Fh2070mG+IKGR8T445pnPnHiFqns/HfD2ur7sEvoMM?=
 =?us-ascii?Q?P3aoC7p0qCXOneXX+ToWLB2BczuSDDUB5734OGO4pDsANCb5VIK5NfHpsOQD?=
 =?us-ascii?Q?aPo1pXRAqtvgmMJ8uA6dfKP/S/GojzJlDxhjIiVV3hQEa/kRmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0lrRtsIa+1QxBzydWfbx2q5bv2RzIy06rgu3taEdQSevMNhxmwm9kpJfr/JO?=
 =?us-ascii?Q?EWRBHJEwI5jVVIuDpIb2jw4vHVVBlYMWITo0KDnoz246hygamn+PJdzAGEjC?=
 =?us-ascii?Q?ECc+TinOSc5mA1wpK5od+ybVFCJwcY+n5frCYwbNI+bse2rMxIxL4Um6o4Nf?=
 =?us-ascii?Q?VkgMKVfx1oq5wqjScHQlD5+MXm8JzajgRDwXQ1vVI8KR+nYHSP6DZ3hxNWlO?=
 =?us-ascii?Q?MJ/bzobMoUjr21n3D3UaJTRndTsc5GiUJc7aggw8C29ujO0fyRUFRUFcJD/J?=
 =?us-ascii?Q?/iXq6+76oHzftTyj7VCobXLkWMWWwU4eY+u4Phe1dhY5fuzmvVyjRR9n7zU+?=
 =?us-ascii?Q?k02Jez1vfoIgMTTWUcXzlrdxWurYjGvXUp8Hn93vj36o96qsLagf0ZwWKsAC?=
 =?us-ascii?Q?l5AFBWkS2tPgoTsjYW0PLHzUbqyZVI2G6xYrhVVUbszTk0fCQGTqn2/Lk9gG?=
 =?us-ascii?Q?KnFOy6pLL/CMO0S4XGQ+eelOb7Gcwl2N1hTm7vWBoGrZd1T1d7p5uoAllXgk?=
 =?us-ascii?Q?lXQsQrS02Q9yDn8m+JtAjfz2qV0BxxCw5J2F4HVCxxgqjHLV/vz423CMc+qj?=
 =?us-ascii?Q?pBf3XGmZCBKpa+XG5itdTX9xQhyLyE+HfFjsN3qYBacsGb4jEIeHVlvbxazf?=
 =?us-ascii?Q?rn2fwdKkBSvorTldgSj1kJ16YP6yCSOH8XvaHWzGRONr/8JbL8yZFX7hIawY?=
 =?us-ascii?Q?Z2tHPzERSZWGa9nflf1KxjOj+m3pGjny1yffhmwxAvKkgqcFImYH/plzzUFK?=
 =?us-ascii?Q?p1w5Foyr47rvit0CHlv7xcaY9/2DL4A8i64uWi9xfkftWG1h8drLjoYHVJ0W?=
 =?us-ascii?Q?Hx+df837r2mEVVcCsExmGF0O09ZKRe53+w5Z25sbnjBN0G1BJTJ6tNeACPMg?=
 =?us-ascii?Q?/xxlOFPuWtabcBp1qTitYLw2maLlSM4RUpYsVUgnmUmWnEbtjoLSWeubVskR?=
 =?us-ascii?Q?E5B0Whdkh/uE5IuxVGuptLU/d+WNxXJujzXrEaR/CA9tN86SbIc6nXYfRM8q?=
 =?us-ascii?Q?GMXpIqGgED015+I7hSo32pf8fcdj6oM54iohiwubur4BzJnWDfuSVsw9V8TS?=
 =?us-ascii?Q?7LRGX++rfYEtJZ2UfDx4/ENTAiP1/udC10VPh6z5zS09KIF31pt5YC+pjW8F?=
 =?us-ascii?Q?uVDROzHOKuTkVN+/3IdmrN+Axqs5bR2vTQB/5Ehbv63lS0KUcFrAOoa5QzOy?=
 =?us-ascii?Q?xpU+w6RbeiArqAJjqod9hQHYPiAWzUPcR8/4CIMU8uPizgEcqnVvb8cdo9h2?=
 =?us-ascii?Q?jxxvhyodJO8kx7IHfS88VGslYawdMXKirvPLFLXzE98stUNugydFba/s1Vtq?=
 =?us-ascii?Q?oIxHOups+GvuGrsqjfCqoc1GqWDYi7ey7d5c3pqxNi6Je5shm64JIWqiJWDi?=
 =?us-ascii?Q?f3gjab41BSgmZM2q/uauNaj0Ck0ACj6Lv9AIM0tHIuAh2xOwLEC9Jj9EdpQc?=
 =?us-ascii?Q?CBISsJsP1cx27sB7+8GKDQLSVLmeCkhBP3A7cQbkVPE2Gq7l+aSrfGXtuyil?=
 =?us-ascii?Q?VL9X1I36hYNScKd+UcpV17SXqA7F+0QdjEmy8c+mtuv1B5UkwHmC7oolJB8h?=
 =?us-ascii?Q?yY8KnJ6meSI9Clbq6YKyCPu8KHobDh6yMXFL0saL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f6fc23-463e-4a29-079d-08dca2950af0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 17:06:59.8413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ld/IV6ZigF7GILgiIHJUdfLPQ2s87XALZCVpFPtnRcqRJuEMN/s0QAnpraKmmcGl8xDY1a1u0g9EBLJC/BvQSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11075

From: Carlos Song <carlos.song@nxp.com>

Add header file for generic I3C flags to avoid hard code in dts file.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Frank Li <frank.li@nxp.com>
Acked-by: Jason Liu <jason.hui.liu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/i3c/i3c.yaml |  5 ++++-
 MAINTAINERS                                    |  1 +
 include/dt-bindings/i3c/i3c.h                  | 16 ++++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/i3c/i3c.h

diff --git a/Documentation/devicetree/bindings/i3c/i3c.yaml b/Documentation/devicetree/bindings/i3c/i3c.yaml
index 113957ebe9f1d..90f3610725185 100644
--- a/Documentation/devicetree/bindings/i3c/i3c.yaml
+++ b/Documentation/devicetree/bindings/i3c/i3c.yaml
@@ -91,6 +91,7 @@ patternProperties:
               - const: 0
               - description: |
                   Shall encode the I3C LVR (Legacy Virtual Register):
+                  See dt-bindings/i3c/i3c.h
                     bit[31:8]: unused/ignored
                     bit[7:5]: I2C device index. Possible values:
                       * 0: I2C device has a 50 ns spike filter
@@ -153,6 +154,8 @@ additionalProperties: true
 
 examples:
   - |
+    #include <dt-bindings/i3c/i3c.h>
+
     i3c@d040000 {
         compatible = "cdns,i3c-master";
         clocks = <&coreclock>, <&i3csysclock>;
@@ -166,7 +169,7 @@ examples:
         /* I2C device. */
         eeprom@57 {
             compatible = "atmel,24c01";
-            reg = <0x57 0x0 0x10>;
+            reg = <0x57 0x0 (I2C_FM | I2C_FILTER)>;
             pagesize = <0x8>;
         };
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 3c4fdf74a3f9d..f0ce22e04d467 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10479,6 +10479,7 @@ F:	Documentation/ABI/testing/sysfs-bus-i3c
 F:	Documentation/devicetree/bindings/i3c/
 F:	Documentation/driver-api/i3c
 F:	drivers/i3c/
+F:	include/dt-bindings/i3c/
 F:	include/linux/i3c/
 
 IBM Operation Panel Input Driver
diff --git a/include/dt-bindings/i3c/i3c.h b/include/dt-bindings/i3c/i3c.h
new file mode 100644
index 0000000000000..2513947e70cd2
--- /dev/null
+++ b/include/dt-bindings/i3c/i3c.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef _DT_BINDINGS_I3C_I3C_H
+#define _DT_BINDINGS_I3C_I3C_H
+
+#define I2C_FM      (1 << 4)
+#define I2C_FM_PLUS (0 << 4)
+
+#define I2C_FILTER  (0 << 5)
+#define I2C_NO_FILTER_HIGH_FREQUENCY    (1 << 5)
+#define I2C_NO_FILTER_LOW_FREQUENCY     (2 << 5)
+
+#endif
-- 
2.34.1


