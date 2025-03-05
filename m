Return-Path: <linux-kernel+bounces-547645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9687EA50BF2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8388189501A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F117A16426;
	Wed,  5 Mar 2025 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Y03wkmXg"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11011013.outbound.protection.outlook.com [40.93.194.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D005255237;
	Wed,  5 Mar 2025 19:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204227; cv=fail; b=Yolu7N3KHjTFQI3TTtSFi80mvvMnaqLkU4yprZpiH2ANBHYYi6VYVWsBD1AnJQRwdFzuvDJxFB3NF/hdtKMDTHMoj4N0sUicgeYTb6/qBPyLUvWYkVriGCfG0V5wY5Dwbp/jr7WX3oZ+ov1qIllJE92sS4rdva3esx9/zVLKLPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204227; c=relaxed/simple;
	bh=ngzWuB/miy9KVqWt5E5V5q27RJJiqmVxB9Ssl4Ow+4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tinfY9G1qdyOAXKuoC0RlFmMpar7WS8oodc1eTZRn4mwDuK4kxSij0yBAj/LE8RK4IGtxQl4CLkOflX2/R3m9EFO3PqnH2nWXSfcp4brEOoprt4SrItKmYVSXbhQCx4+iMf4aHkry/0dUGHGCfWl+3uSUfKjpgQU8h/VbPGtt24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Y03wkmXg; arc=fail smtp.client-ip=40.93.194.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhaOhGIOXVGsLNwiJjzVSZ/mmA/oH2ieF+eGGFC+73DW8OzRqJMBe/hzt8JTZiiJPgMYtfo7PAbiRQMS/SIUt+8QyfJ52eUNLCjfiVCSQo+sfAkDfjfBjb1fqjU/3SIMtWtzQjbT9CpMRGUyge4SuH95/EVo1lF8zS3FfeykxuVdfZa6ryWOMuFb4dRXtIwcDd6XacMiJ6YRbxoGKkXKHcU4xUlsYlmdbUS03jMvZo2NZsJTww4LYLJewIhx/tY21nS3Fik4Dz9ABzvYBa+i8OZS4QWuvzb/5+V7TT7+mAPn2IbVwcXi7u/FPoqzwQX2XiD8hDBj5CwqqVx6H6zJtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYzk5lgJyVQRGqIPR3oPnxhUOi6xHIV2Wp1/g3oFZTE=;
 b=tH/5aYdytIOZvuHhOCVt/9uAdLhUxFIhuHcCl82vzYDfnjC10opymMnYL1BRCBQDdBf7KQB4d+FJC3/LT+JQKTIfaKUzozhCoT76sx9h1erY6vs4SZFP5G0NuATWAYA5qVF/jiLE/tJPDQfNd4lGnsOyUyHW+uHLU7KT/3DlLAJm9UPZzwvbBjcyIBqRPkvYXQY6na6mol4rIfqBd2unm+tHoQGl2Dcfs+z8hN3pFJLWvZpNP7UzC97MUTMMEV1VzwAzIip6Pg+jFIQAVIYNFMHBQFXVytmwwM/In8ZC0Y+ihP++W9OmGn6W3hhsZ5Qzkepa9ATWJW+pa1fUkBYIFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYzk5lgJyVQRGqIPR3oPnxhUOi6xHIV2Wp1/g3oFZTE=;
 b=Y03wkmXg+kORm6rjRTu4NpGG7s6+F7nvOf5iODbR9dvnl+J4wqkKw2nMGNnzzSK/8kBXU9GH+kgaEOJ1cyj8bsg6DAtbNDel+yc+pFi+FNfv6tce3oKz/ilCaNGGBos4PhEy1dyWTjmy5DMPOwwwdb86p4G6wtvVecfx6nIblTNi9KTkxsbL83IMjBQSMe9UoY8w+kPA6YxOgB1Y+4El1UNs5mAf78YU6Pw/ogw47SuutB9DfcsFOepUCXWPKE93oeQZaFBrvouXQ7liT0MeQ5jxdLlBuR5fel+bisJWg3z1qJE2eYpAx7573vqYjbe0HmLxvoFrRsGPiK3qexOzRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by PH7PR03MB6972.namprd03.prod.outlook.com (2603:10b6:510:12f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 19:50:20 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%7]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 19:50:20 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH 1/2] dt-bindings: intel: document Agilex7 M-Series SoCDK
Date: Wed,  5 Mar 2025 11:49:50 -0800
Message-Id: <20250305194951.7226-2-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250305194951.7226-1-matthew.gerlach@altera.com>
References: <20250305194951.7226-1-matthew.gerlach@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::34) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|PH7PR03MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd28f4c-dc9c-43d9-23bf-08dd5c1ef250
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8c18dPgYrOkoZiR98mIflvMQuvwpEr7ehEgkDc4tlb8Cm55jklLBpAiVdLFJ?=
 =?us-ascii?Q?lAJZPOlyz5NeZt/l9DpvYJDBwvUIhZAwYwXBIbLdBxqlTSpMZBFKbZTqUkzY?=
 =?us-ascii?Q?oTW23n0tN45d+ejY36AYo7e5GjvnXLxyuY3tgN69IgCG57arcmIOPZ0qjn5N?=
 =?us-ascii?Q?otmLHinwTZxnKd0vM0Kcot330GSmahGo0YH7PMVaLV+RQjGyCNFZ1hx4kfl/?=
 =?us-ascii?Q?jnK5Ugq+Qi/t9I60RgACb/mvdUbU8JIc6dqrEMwYdVkyuPJdxj4dFcUOxV79?=
 =?us-ascii?Q?UhpJbPP0vuuW5cpJ5ZXhX+ridJapJp+bg2+a7LPnFjPRhZh8A0OsQ3ApYJmg?=
 =?us-ascii?Q?eldppqq0aIlbAWZR+8CJHbX2wNWpZU4yPet4EgLun3Dl0scPmjD17QLN+0//?=
 =?us-ascii?Q?sVs/2wQ6Dl4Jtr2yQRVF6TUWaOXDQdR71I2+JMFKRb3PyZLT2xkhkrrV524g?=
 =?us-ascii?Q?FL/QMDvDO3C5vjTfi09KtmLdAh3fVa0YpHI7TVzZYFDoaXyhc89IMv3ZFJqm?=
 =?us-ascii?Q?zKy991k9PRUXKZg4YdovzgJLpPfZQRZSpj8ObKbuGlsJ2ZMgMr/gMr69K5Td?=
 =?us-ascii?Q?4LFX17waFdcuC7GM8gE3yu7aO1+WfieUjTtQ7A2YcVk9CNdQNTTKeYtLAtCw?=
 =?us-ascii?Q?WAXPPmXL6SqAyue9lXIYBz/3JUglaat/oYtRjdbAr7du26kDinuPptkhUKwx?=
 =?us-ascii?Q?DiXXc5hQ4uQ6Rqft89jKi+SFXWJqgwE51I8zaqpS7CkryxGPzUJvv2plOD5m?=
 =?us-ascii?Q?pew4NqU2wiYZn4hxIN2Su3NpURSyLAZb7u5CoNgWLqqnQGjgCZ7lqa9rjTO2?=
 =?us-ascii?Q?ieQNOUmVZ5iQ+2MUEJ0oVzEyXTx0+he7NeceBn5/ONoT2jpTTZM1rB3nn8Nm?=
 =?us-ascii?Q?kBVqpVfzK9gdEastjlt+6fipRxgPsvZTAPNflvcam52EbFDGuh87NY90Wemr?=
 =?us-ascii?Q?urE3F7jVuSZVsOYxoVt7tyBKFTJGSmjeqEB+VRgEnUs+1iADpPcJe9P0VPsI?=
 =?us-ascii?Q?JIT058YNqg9uxeMSv3GMK4WAz6HSQds/3Pvqw9nEYzIUjv4zSAjE1JF5B+4S?=
 =?us-ascii?Q?uxcwoqeIzh1Vb84bdsnxItUTf4MqTDiD6tDN/qbEOJ+HokjCBhAk9dYdp620?=
 =?us-ascii?Q?X27C+5Bl+qvcNsrCgqY3tmGnczkwCC6vkFGVBr0HQ+y27qpsvSIO/L9+1U/b?=
 =?us-ascii?Q?n06e5q951zz+4SJOQjTBIUToh34thl2rZ6exwxKIRkFelay4RAuM9k+OTmI/?=
 =?us-ascii?Q?khgJ5Y4rwnMYCVCOtOTG1Q/2SniQp5Rop94eDFFlCfc0T23dQdnzYR/n99EG?=
 =?us-ascii?Q?atZn4AZpHZ3D7jUZqBSF0Vkr8WLpLIHibu8E2wPmAC7Z7cSam65phPf2/f/X?=
 =?us-ascii?Q?SZXlwDeo6lCpGXuzhzS1w352xa7n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E9n4A9sDheDnZlsUV5RklxwsfsN5qeVsC7RXZoVGHSpxKm6NrMacX4KGzB3L?=
 =?us-ascii?Q?O3KG4rJAu3By0QaS9n73j/uTx5m/D/WEtg1LwKpHcau9HfBWrInq8qtasd8j?=
 =?us-ascii?Q?b89ukFRFKucw3MDLmEG3DV62uUA362cboHLE2NY1aJJdWoFkFMLl0tiO1CXT?=
 =?us-ascii?Q?wgw5Vut4YF0qC+McFB93ldP+XMlgucFm/gBjFathf4cK9+PH4HKDitZgaaVw?=
 =?us-ascii?Q?6DoB0WeDuRk/X55mOpCgGlyFzuZu1+tRGjhEnTu8qXs9wQxxUMgtIO3ShFky?=
 =?us-ascii?Q?K7qFWmEWrtSd7lkUBKFeOkaWucpgNOmOCyCgJu57jtrLVqbLpW575GARG9r4?=
 =?us-ascii?Q?jkr2cC4nFk/OAkkkuei/km9kIBqWwjn02Tve4c/eR8V8J1XsaEdgpUqMqda7?=
 =?us-ascii?Q?cluYygssfCVp8spoju+l/PyxSxdvxMCUQxZ2nVs2+rRojESgSpDQTQ2ps4ap?=
 =?us-ascii?Q?t6QomGhV6Mv/gPXdHqSyF/Pkk4YwcwWiNp4/paL+AuN9tEBURRh4EuX95pzj?=
 =?us-ascii?Q?YtX2vbVd9MmONRsv1u+Fknp0zI6dfpNy23hTcWE+OF0JzhmrwmnOPvR+cIlC?=
 =?us-ascii?Q?lvo2+UivJL+Xf5TcEnVWGvmHk06l8RLI46F12UXpou71NOymg1q/2HsTCWCa?=
 =?us-ascii?Q?K758v+cAyprE5VKybQ2AkKFQ3wdBlM5wHCFG17kgAb/hiCKYfHpGleppVJyo?=
 =?us-ascii?Q?VONsMqO0lDVhMj8tQiwAH90uvqsrXChGzPWilYoGOXlfrNxcfgn+ToBc8rxx?=
 =?us-ascii?Q?Ttw2V7PF7jORN/ZqA51SefLyjRGq+vjn434qiawKEktcfsdxKQEggjGpfu4h?=
 =?us-ascii?Q?X6zcBIZK1+xs9b3VNDByf1wnJi4sFPE/+BZs7U20NnPjVdM4X3DV6MuET1iA?=
 =?us-ascii?Q?Duw0Z6XZ7+gG/1Z1OLSYF/M+rVxtvDrT6A2VwBr1FY6XnRD1TV2FAd1Diut1?=
 =?us-ascii?Q?wKMrvoO8fw9MA9mA4J9tbYbkgdOUFmEgTCzXjWKo+74dh2I+JooeXWni0HyT?=
 =?us-ascii?Q?hN/X8Mt3pxs5mVe2Om6OZLfvmLjfFpavn21jSEC+gTnx7rm6zm+hunqfUG+/?=
 =?us-ascii?Q?qKjyxyTjcxOZLOvl4Z9fjxzgkvPmKG2xppTbml/zcytTjBjDsZN7wvLWbOqZ?=
 =?us-ascii?Q?9cuvvjVG0EQqTv7uaQXsr7nsRqcZuNSjmSrDIa3iZLUleYfngrwKS0b8qAJ5?=
 =?us-ascii?Q?apNErz27zMbywNuUVm49wiDXzNjbC0kHL19q1DcQ6knKHf556PRab/QbC5uf?=
 =?us-ascii?Q?EKXVyb4yLljO0m/yg0UXNUE/+Y+osjJYC1Iw0Y3b1QOP0zKvV1hejdV5VJpG?=
 =?us-ascii?Q?bd0d64fFv5KLgutr65oylLpxuteUFPqDe7/MPE1KYjOZI3xpE+1j8Ymc30tj?=
 =?us-ascii?Q?tOSvoYJTGSuJ2gPfLabHx3UROYzVleAavlWgqnD9TH82iCyLWh/a/GSpeOVL?=
 =?us-ascii?Q?six55llIw/rj39p4ykbCnHz6D5asIs4scpyAQchoa/AVoD4iW0K4gAFvnfEN?=
 =?us-ascii?Q?NmGp9cZyUs+Lfk/lZAAE2J387W4lvuZfMXNdWKlG30UFOIC5Ahj7IT3AphEv?=
 =?us-ascii?Q?TpIozN1RWwlFuQ2mBZyBlYL4hwdgUsJcmTa06+cTtmJapT7UPCYr8+Tcbhf4?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd28f4c-dc9c-43d9-23bf-08dd5c1ef250
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 19:50:14.2470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cyid76Y07inHL1MF8H6oXQGT52o4FNo+UKlPAfpTFyh5bEKlXElyCUJ6M1ERpTS3A891uFn2q+mQLgIKGO/MIX1XtaIOYboxZDvVsCHKPzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB6972

Add device tree bindings for the Intel Agilex7 M-Series Development Kit:
https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/agm039.html

Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 Documentation/devicetree/bindings/arm/intel,socfpga.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
index 2ee0c740eb56..f569d62235cd 100644
--- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
+++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
@@ -26,6 +26,11 @@ properties:
           - enum:
               - intel,socfpga-agilex5-socdk
           - const: intel,socfpga-agilex5
+      - description: Agilex7 boards
+        items:
+          - enum:
+              - intel,socfpga-agilex7m-socdk
+          - const: intel,socfpga-agilex7
 
 additionalProperties: true
 
-- 
2.35.3


