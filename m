Return-Path: <linux-kernel+bounces-198960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525AD8D7FBB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0808028943B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B38E82D62;
	Mon,  3 Jun 2024 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="PebQwg5J"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056968060E;
	Mon,  3 Jun 2024 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717409324; cv=fail; b=L5f9efL8HfbLH9YRwJC2yquH9QEoS8Jv07a6fc9od22R24Ntw9Y263Wo321snZUQt3nUDZ8nUpajZf2WcqbJtl17EW72jXKY9by7l4hF4AovfVOvkIEVh9o5iCbZaqCVvg3HIPcKFPk2nXEs0oZgAPbAJKBtONYlXA1J3J7QbFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717409324; c=relaxed/simple;
	bh=Aygr9R2mzS920fDPrA/NTOlPcNvSxjrZ/xf52JNeZeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mxNdiIXsSdF9e8xeUpR+93VXbUiv0QAvuTn2EJJaxlKSmRiy9J9dc64HqRhz7FM9GFqRGaVP2PAHzm5xmqPAw3r2Ipq8lqHGe2wqbLfisUTr9zP24eMwJK6pohRcMpIFZoNkAOJPzeHPzJleGZP7r71N8ji+Wzzm192qbkLDVwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=PebQwg5J; arc=fail smtp.client-ip=40.107.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2aYfs0XSlK/GABIiPzAts+U2Cbc98C7a1rW7ljItiOecRxqexpyQF/aQYbyYG1h414oj7DtX2uhC4tRPbq4+IsTyPW14o5HdRwQarhbj7QwnsjEuyzOrtAFw/4eXjyGggN2rjBEmQjHTQdjQd6u7MSl/lavLtF2px3gZd68q1zLPMhshMSV+i8LQ+fjHP5kBSEKfZIo8KnhW2A4pINMlKBqfKfDoPvCQq2G1pauR32pOaJFoarnzIWQsZgt/qpPfiJ6bQxMd+aBjxxVHm9GsI/w6zu2GuPbBsSuspPt/ezCuW4wCiPis5rAeFr591zeD+5lngxdyEsgg76lM4TBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnN5xWXK/p4vK+PGPC8m1Os43S1H1QsdFOPx/XaGFYI=;
 b=IvL3szioCaYFHlThmgkmQihuVCjoMx5J+8dsuXXiv05BKHMl3zNzcPk7e+1dMCYNQW9Up+eUZlK+M/se10MgK2lPSg64GUvJbPHGeUMrgPh7OL+323A++lG3wGPNQjgjUenKT0ZQhe52Djd3nHIl3ADOKy8V1LCS/MVhAm3A7cFnIQ5e5cgunWO89K24Hrk7jwoeKEIrHvgDcVTUSSizcNz9ZWhiAtW1QMnOXU88pFmbuGazswEKqGLyvkB4n+A9m7bhIyg43NBX8r6MvSyWDeNywLdwqKtgscUg0vLaCVX1d2emKit7JkJ22bdM0hhRZYnGj6+f4kB94vpXiAxKog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnN5xWXK/p4vK+PGPC8m1Os43S1H1QsdFOPx/XaGFYI=;
 b=PebQwg5J9nOpzZVgQVSBwhQWqAf6X6w9ty9fiY8ZyT+3DMkua7DT0jE0e7X6djhjEj5W09A7GW4mP7KIuc1/FPHrPuc31ZdDX+XQg7yDN4KKLpiICKCB9KADZcuitoqM0qhtNgRzcc+2G+g1BpKxLM3ZtgG9ZrpihZ6HvBHk1hk=
Received: from DBBPR09CA0003.eurprd09.prod.outlook.com (2603:10a6:10:c0::15)
 by VI1PR02MB6285.eurprd02.prod.outlook.com (2603:10a6:800:17c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 10:08:38 +0000
Received: from DB1PEPF000509E2.eurprd03.prod.outlook.com
 (2603:10a6:10:c0:cafe::7b) by DBBPR09CA0003.outlook.office365.com
 (2603:10a6:10:c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29 via Frontend
 Transport; Mon, 3 Jun 2024 10:08:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E2.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 10:08:37 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Jun
 2024 12:08:37 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 3 Jun 2024 12:08:37 +0200
Received: from lnxamnaw.se.axis.com (unknown [10.92.129.190])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 29E132A66;
	Mon,  3 Jun 2024 12:08:37 +0200 (CEST)
Received: by lnxamnaw.se.axis.com (Postfix, from userid 12778)
	id 24C84205DA9; Mon,  3 Jun 2024 12:08:37 +0200 (CEST)
From: Amna Waseem <Amna.Waseem@axis.com>
Date: Mon, 3 Jun 2024 12:08:34 +0200
Subject: [PATCH v3 1/2] dt-bindings: hwmon: ti,ina2xx: Add
 ti,alert-polarity-active-high property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240603-apol-ina2xx-fix-v3-1-b9eff3158e4e@axis.com>
References: <20240603-apol-ina2xx-fix-v3-0-b9eff3158e4e@axis.com>
In-Reply-To: <20240603-apol-ina2xx-fix-v3-0-b9eff3158e4e@axis.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, <linux-hwmon@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Amna Waseem
	<Amna.Waseem@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.13.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E2:EE_|VI1PR02MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf3a412-f991-4e66-7c85-08dc83b522e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEpVSnA4bWV4Zkx1Wm9FWWl6bFhBY3JtYWJtcXd0bGszVWhYeVc4WW5ZNEpW?=
 =?utf-8?B?Ynl3cklucHhIT0o2QjlSeGxqUUR5QkxWTFNCa2lhMTFpcnh6VE1COWtQaUV6?=
 =?utf-8?B?S3E3RTEvQ2tvVlBqUnB6N3ZUTjAwQ0dGeVZodFBpaGI1WkpCRm1MdisvQ2Va?=
 =?utf-8?B?bGNCSndlcEI5NWk2ZHhsWUtHL2NONnNOZm14RER0QlBmUlF0eG9JVWtnZlM4?=
 =?utf-8?B?dFc4S3BZb2tJSUR0NWl5aVRjVFdtS1NyaFJ5Q3ZCb28rV1FsRzVTUjByNHpK?=
 =?utf-8?B?TXVBZjZGNGNMZ3daRTZoTTY2NUVrd3pZNUZCQXlmQm45WGg1ZWxlQ21RT21P?=
 =?utf-8?B?MWRRclNQSUlsRnUybmQ5Y0NnRHd6Q2ZBdVVlTjZ2Y0E2ano2MDRta3FIM3Nr?=
 =?utf-8?B?SzYvZndtWGVGd2RQd3hYY2MvbVhIKzQ2aFlDekllWlpkcmo4Y21wKzBwVXRs?=
 =?utf-8?B?aHF4OHBmOXZaR3RiYkdteDZ3Q212cEZ3NDRlLzhKSUp5dURTblZhbm5uZWgy?=
 =?utf-8?B?MWJ1OStVMVEwR2xxOGZUeE5aVGw3VGpvZHJiTDN5ZllRbVQ5WXlsaEV1NlpI?=
 =?utf-8?B?RmNHVFM3TlI3N1FZdFFDRW9wVFd3SVY5NW1INHUvUlE2bHQ3T243c3lMczF1?=
 =?utf-8?B?YllBNUhabHBCK0ZLQlFkTUdzSHR6elNtMXZDVHMrclVEVEVEWHRKTHVRZk80?=
 =?utf-8?B?QjNsWlU1elFZZFNEOW1PdFZGTVhIbVZxMUlBWTRTWUYvMGRmaHNKK2FtVTFD?=
 =?utf-8?B?UHZvczZkdjI5OVJjVlpiRGdqT1JnTmlPdzJUTFczRVpCOFZtT1ErUlBFZEtI?=
 =?utf-8?B?U3BaYkdBdFF5Z2FNRTdDK0cwYTZSR0VpL1dHQnRZQk5FOFlzVWRKSjF1d3Rh?=
 =?utf-8?B?dXJYS29Ldm41Ti9BUllpRHhVbWtkeTRpWUhOdXBKVm8yR2JNNUtvajd3aE1w?=
 =?utf-8?B?YkNUU0FCWlhlMCt2Y3pKVm15UXhZRE85RzNpam1hKzkrelFrODA1SU1oN1l3?=
 =?utf-8?B?eW9ZT2VNVlh3LzZyek1LZkVMVmV0WFlwVEpra1lKQ3FQcHNZMmtESTlHZnYv?=
 =?utf-8?B?WGs3VEU0TG9DSytPUnE3K1UvenF4aDc2ZVpxZ09BSlFkTHJQWXltOHBuSG5j?=
 =?utf-8?B?dC9GcUhLLzBvU3FPc01WS3V2R20wOUNLMHdpbVNYM1VuUDcyYnpoZWpqRC9z?=
 =?utf-8?B?SERrVHhnM3A5U0xZMGtmZHJ1MGtxYlBGK1FjVnRRZHErUW03VVRpWTV6Zk54?=
 =?utf-8?B?K1d6OXhKeFJROG9zSlNUNDJEcDcrWitYSkYxSDA1cVhNY0U4QU95dzZtWmJG?=
 =?utf-8?B?dWNSbTdGbkMxNFFqVUU3TXVja1FJVWJFUm9IVUpDZEQ1QnlvSUZSelpNTjdT?=
 =?utf-8?B?dUJHaVJGam9SM2VHaDFRcXgwYUJ0Y25NZTFwamdLdy9LM3ZQNXJxa2lwblU4?=
 =?utf-8?B?TkJVQUdkQzYrZkdBdUJEYnZGcFl2S2lpeHFpckdvWVY4NFpnZ1VaWEQ0a3Q5?=
 =?utf-8?B?VFFya3ArSlcxdnVtSThKeUk0Y1Y3ZzRZSkJldHJPSkRuWFByLzVVTHdFNTNS?=
 =?utf-8?B?eWtaTHEwYklaM2lKQzdwUFk3dzBMWVY0SXAyTmlLdkhZZjQ2TDJpRldPWnZl?=
 =?utf-8?B?UlNMUGdJOTN4TGRaL2J3VzByNlZhQjZnelQ4UUsyZGp6d2xRbUo1OWdHYXRO?=
 =?utf-8?B?cTZEN21XU2RiSzBEeDZ6R1RkaTZ4ZnIxNy92OGhkbXIwVWFGSitkTm1xakp5?=
 =?utf-8?B?ZTcrVUJDUXVUdVUzTUFZK0ZsbllPbVhIbWVtY290WEJLUnFaT1g0Ti9tYkVn?=
 =?utf-8?B?T0hlT05QQ2lWM3l6VE04aWJja1N0QTd5REpheUtEaUZzSGw0cEFWY2VhTXJy?=
 =?utf-8?Q?rkw5PpZuHNsvi?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 10:08:37.6508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf3a412-f991-4e66-7c85-08dc83b522e1
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6285

Add a property to the binding to configure the Alert Polarity.
Alert pin is asserted based on the value of Alert Polarity bit of
Mask/Enable register. It is by default 0 which means Alert pin is
configured to be active low open collector. Value of 1 maps to
Inverted (active high open collector).

Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>
---
 Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
index df86c2c92037..9190ef0bda54 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
@@ -66,6 +66,14 @@ properties:
     description: phandle to the regulator that provides the VS supply typically
       in range from 2.7 V to 5.5 V.
 
+  ti,alert-polarity-active-high:
+    description: Alert pin is asserted based on the value of Alert polarity Bit
+      of Mask/Enable register. Default value is Normal (0 which maps to
+      active-low open collector). The other value is Inverted
+      (1 which maps to active-high open collector). Specify this property to set
+      the alert polarity to active-high. 
+    $ref: /schemas/types.yaml#/definitions/flag
+
 required:
   - compatible
   - reg
@@ -88,5 +96,6 @@ examples:
             label = "vdd_3v0";
             shunt-resistor = <1000>;
             vs-supply = <&vdd_3v0>;
+            ti,alert-polarity-active-high;
         };
     };

-- 
2.30.2


