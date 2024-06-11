Return-Path: <linux-kernel+bounces-209580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A99BF9037F5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291891F257A1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D798A176FB8;
	Tue, 11 Jun 2024 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="FEDB4X7p"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6022230F;
	Tue, 11 Jun 2024 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098596; cv=fail; b=opLk2bEnzleR/wZfbHdExMmUDPxredk4TuVBXOfJIcY4aoj9v67ehywFwFBAP7UoCSzdi6murYZ8Kv+E9Yo1SL444xddM6ZnnIuqHVX8nv/I+NOK+7JkYNSe6U0RRoUtxdF/NzHfRx65pr39DSWbjBkvzXfB8rvzwynTaJwDYFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098596; c=relaxed/simple;
	bh=Aygr9R2mzS920fDPrA/NTOlPcNvSxjrZ/xf52JNeZeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bSwl+qHysBU5LSXHYtfDn2qcLi3dYPdFsceEDP5uDy+8iOI+2jDOVzgg8kJegg+tj5FVJa2leqlJ0LmiH3Uh6pJJDwrpPPOQ2ySo+pvaiZp9h4xJTy+ffbghBI8czi4Sf/j8gl2R2K6Kg9q5lzGtHTlGc7VoVl48Ps+gxxUnAZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=FEDB4X7p; arc=fail smtp.client-ip=40.107.104.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sc/KHlG4L5Us6raHXTnGcSxERDwSLZhMkIfIg00wX5ogbEjfnsL5E3lio980Ycq7BZthdAdKE75/tSW6niVAhyh1+jZM+WBNQwpICE7sy/ZEeZH6BtRfPqy53nHsY7HdQAg+9fjAPz5vwHSmi3VB32GzdVC34NJySl9881QCKrMqc4K0+e2V3e11DgfM4kZQELe1AMG252OxlxjkIi4t5nkA7Z161Qe1Ite2c01LNcgaL925i9tznEL6XvvF6lrLI/hPFhArbnabTA/FodM4Y5OWyqJhoF0z6w9y87Qu6ZQtiSaXPdNdIy0kEiFF0A81fwreJiZIF9vJxvXDNvzzOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnN5xWXK/p4vK+PGPC8m1Os43S1H1QsdFOPx/XaGFYI=;
 b=XRyEz0mqoE+mi3kAooY+EFZ2/sdshmVAdpxuaCNM3VNTzxLRBOPv+b2D272tFATKg0wvIywhdu1LBLw5XkIz5Uh08Wq/XzuP61BSNFR5A9Bgd5rk/xE2BD7w3vSLj+0XRiZJt63b8lcO1P7x99XCWhxv6W67kHURNeo0gisP0CXac4CHNZ6Ekvdy/za7iwpf0UslPwee84LlY5/BdETA6p8H3mpUOo6mnZvyjGBK/OpEgKAx/Sbg+g+AnzeZhEpGauxN+MUgpUwgoTKd+MsuF9eksCrJ3dlcx6IfuKSZw1LMawENKMQie/XQ9KE8v0QcozV013Fn9bWqboxEcFYTHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnN5xWXK/p4vK+PGPC8m1Os43S1H1QsdFOPx/XaGFYI=;
 b=FEDB4X7pEqNx4G7uwC6TYfoYujs8n1aNnKXUfefJK+U8dmC8tCuK7S/66nHCNBEsXgM1kjAg7bvTL2USsr1qMIhudHKcEcLI6QKZ4tYZQS5b8csVy17DRV5xh9IxUi8OAj/PeTFGQg8O4dqFxF1dbVUGn87r/VSujmYzGl8OPYQ=
Received: from DUZPR01CA0184.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::7) by AM9PR02MB6643.eurprd02.prod.outlook.com
 (2603:10a6:20b:2ce::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 09:36:26 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::d6) by DUZPR01CA0184.outlook.office365.com
 (2603:10a6:10:4b3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 09:36:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 09:36:30 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:36:28 +0200
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:36:28 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Jun 2024 11:36:28 +0200
Received: from lnxamnaw.se.axis.com (unknown [10.92.129.190])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 468923D46;
	Tue, 11 Jun 2024 11:36:28 +0200 (CEST)
Received: by lnxamnaw.se.axis.com (Postfix, from userid 12778)
	id 448CA205FB3; Tue, 11 Jun 2024 11:36:28 +0200 (CEST)
From: Amna Waseem <Amna.Waseem@axis.com>
Date: Tue, 11 Jun 2024 11:36:25 +0200
Subject: [PATCH v4 1/2] dt-bindings: hwmon: ti,ina2xx: Add
 ti,alert-polarity-active-high property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240611-apol-ina2xx-fix-v4-1-8df1d2282fc5@axis.com>
References: <20240611-apol-ina2xx-fix-v4-0-8df1d2282fc5@axis.com>
In-Reply-To: <20240611-apol-ina2xx-fix-v4-0-8df1d2282fc5@axis.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, <linux-hwmon@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Amna Waseem
	<Amna.Waseem@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.13.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|AM9PR02MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: 56702498-1fff-468c-7fbb-08dc89f9f98d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUhvdDBUa05mMjdxVWM2a3lUdWgrTHN1c0ZZQktoRnh2SVpIa3JreWlTa2Ji?=
 =?utf-8?B?RWdQOFJaSlZhN2NKcUFaK3R5a0lobjErNm9pQnl0NERTSVgvSG5RanFGZlAw?=
 =?utf-8?B?eXNkc2c4akVMNjlwVllqcmpIUzk0TGF1SFJpUEVQbnZVSmdjNHpzOG1jWk1z?=
 =?utf-8?B?Q0p2ZlRIbUY1QVFvREpiSmtFNnF6NzJSekdnb2JKU2l5b1BiRy9vV1VhTE9H?=
 =?utf-8?B?Z0p3ZzEyeXFaRk5NQ0FMbGNoYnF0VytrNHFyNzIrYlhMRW9WbnZRVkZoVXc4?=
 =?utf-8?B?K2ZCcjNqUVYwUW16MGpmaUkyOVhOV1BidzlKZkFVZCtRVFp2ZXdOV0pFWTBE?=
 =?utf-8?B?YUlKajk3RzFCa2s2blJvR0QyZG5KY21pTlZxTWlCTmpMdmYvU1dsMUtHOHFp?=
 =?utf-8?B?clNlMFB2WS9EUXdjUDNrQ0V1RW9ZVDlkSkZLdVducEhPWFlwc29OZ1lSekxL?=
 =?utf-8?B?UDFRTXdlaVhqaldJUTZxVlU0bWhaLzdOelk0M1ZITkx3SURrWXBVdGQ1REZN?=
 =?utf-8?B?cXF2UnlON2FhalJNUFBJK0FUQmNxMnhCVGxUM3crUlY3VjFnLzRLOWxwMEVa?=
 =?utf-8?B?MStYNGk2dmdZa3h3d0tJSCtKQWlvdVFwNDFwdmxMRGlzd1Q2aGVlRVJGOTlN?=
 =?utf-8?B?RlRsUjAwSDBYNUwwTzMrR3pzbVk1d2dGUEpGMWpzeWUwOTA0aG14TVExU0xM?=
 =?utf-8?B?SFdyQkpWQmtBczU5Ukg5azdkOVdyL1NJbzVLNDNoTk5oZVR3UXl0UXQzSTk3?=
 =?utf-8?B?Qk9wMXpyNG95STdFMlR4WTloS3FoRm5ONkMrQ3BZem1OTzdMVmJDMjNKelhy?=
 =?utf-8?B?U0p6VFpxR2MzcFdudDdaRVVDOTdJaUE2K3puY1l4UklNaU53QjZ3azY4bHpz?=
 =?utf-8?B?WkU1MlZJSGhZR2IzOW5IN1Rkd245d0NmV05EOHJyWlJ5aFJyL1ZVeEU0RlYx?=
 =?utf-8?B?KzJRSHZWdS9xbmk5NjNKai93eFFPeGUvbjVCeUNwb0hrTmZtQjhFbWl5M3R1?=
 =?utf-8?B?N0NEa3lHOUpHdDB3S1VIUkt0b3NHRFl6Sm90QUdLUXYxL3VrTi9iMmQxRTM0?=
 =?utf-8?B?T0puc2EzZXVJT1NidUdMKzVyNVlodGU4eC9oSEovM1B3dW9lcnk4SHUvVitv?=
 =?utf-8?B?d1B6c2ZRenNLRjhVZmlCNFlDZ1ZZMjBkdmRzZ0M0Ky9ZQ0tjNDhEMy94UG01?=
 =?utf-8?B?WVhNT0JZOG9OdXNjVzR2UWoyQ1NIaHZzZ29tUlRNRnBhMlRmbFR2V0d4eXh4?=
 =?utf-8?B?Ym0yRGdCS3RwMFZ0RWhKTG81ZHJqUCtiTkxXSWRyWkRaMFY4TENBZ25TVUpr?=
 =?utf-8?B?ZUM4QWgvZVZCY0lnblBnKzBpeXM4VHplN29xNlMzZ1dnQWtLQnBLN0lXTUxn?=
 =?utf-8?B?aFNXV0x5dU0vRU9UdWVZMFNFVzRYMXJtYVY5OVZpR09TeTMvNGNHME9Qcjk3?=
 =?utf-8?B?OWF0WXMzSkFCcWsrdXdSeVY2TWwza25BT01jcnVqNDFXUmZRVTljNXJMblZy?=
 =?utf-8?B?SjZaZTNvMzA2WTlyMW9EekJENlhYdFdBY0t6Rlo2clRvR2RJOUM1OEI2c0ty?=
 =?utf-8?B?ZDJSeFE5K09uZkc1ekJYK29zKzRqblJrRUppWE1DYmVlcUNicldxeUJCZ3A0?=
 =?utf-8?B?cHVYbEdHdWVmN1JMbGtZSWhoWGdsemcyaHFxVmJEWHBnQStLcE1kbjFXZjlS?=
 =?utf-8?B?Rkw0dXJaTXhnYVJGZUpneG5DZ0dzRnR0WjkxRkVsM01LV1R4emRBdm51bkJj?=
 =?utf-8?B?bXIrQm1xR1JhckQrMVkzV1RFWVE4YXdkM05UN0E1K3JDQVgwbmt3RzIzVTFX?=
 =?utf-8?B?UWlqQjJSRklNQ2Z2bkVXa3RXbFhBVkdOdVFRdVc1QVRQK3V0S0I4Z3VTeXh3?=
 =?utf-8?B?c0Vnc0R4TXBNTElNK0VicWp0STdYdk1BQ25uTlU5OHkxZ2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 09:36:30.5648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56702498-1fff-468c-7fbb-08dc89f9f98d
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6643

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


