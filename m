Return-Path: <linux-kernel+bounces-178155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A638C49C9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 00:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C217CB2212A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A4E84DF7;
	Mon, 13 May 2024 22:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="QrK1k5et"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2107.outbound.protection.outlook.com [40.107.223.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED63446A5;
	Mon, 13 May 2024 22:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715641027; cv=fail; b=lqFo+SI92kUzDZbxgH0ymwgoy2KwTQHWNaxe3uLcR+iwZr0B1bV37jh/bmurEXXzxdfuahXtq8XKF8Y/8mAP6Mpg8INYrbSYS0L0/lbsT6tq31IsxP4YaA0Or/apuwp/P+OcA0y1p7Yu2Qi4NJq4DCFm6onKwA3xigsO2Pc4Wvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715641027; c=relaxed/simple;
	bh=PcllG5mrWO9uyZ4obTraT1FrlP5mSDxbaYF+xctC3sc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rpFqeO6utFYG7ypVJKz6MyzaxzLLdKYYCtlxGoS0i67PvPLM/9r4CoQ+I1ArUQjtIl0FTFuBACOSBXQipP3COndbZT4oPbBR4wJmU2x75MT6Ruj2ENmXGAoQuvFfdpUK17l028xUIRXHQt5uFvJWtxupoxHFzuoLm93/xuMPoFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=QrK1k5et; arc=fail smtp.client-ip=40.107.223.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4lD1umCAwo5SGqPml15VYE5pphCrJC/dhfdbZIGr6npme5gxqfvSTmpWCSpwCnEnRX6eIkAjoe+VVEsBev6HgbgxzbQnH3vaoby9IRp23pjNPUnk+9uSR7NW8y3MObsQc9nzQT3BHtyoaoEcG8gaQ/4H4c2prwwdwa5+6q0rnWXRomfmARO6TutaLYbY+uRpIOOPyIjZWQChp9Tg7G4wTzlhX8fmr12WzowanjXixkd1i8gJQbDoQCD5DSSZxFq4i1EKe4yEUs3mxyCCXlJNEA+6reWIm/ChlLs68LEJIXCVb/CT5v/rwD6TzjOezRrR+oYVa+LNPssxA7sJFs7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeCk8hX1rFOBdhqCPodnRc15lwHgi+CZXjME427SvgQ=;
 b=dIB2u6tOP322aJrTb87woxmmsytOEDqA6/g6/1iDp46t7Q9bTdRaqhqEqI6S84F/G+hjljnVSLm18zF0/LAuTfjDSHj3CXJADdsJjCFnwtZNR9c/nk7BEdhqnghMQx322/vq89Ca0SRjFgNTORCkjY5X4NCG83tWED1qxMmHVvgbdx9iyzQxvhpxcNF1GsPz/ZEvQtH7I5F2929d8Dv2IgyztNHBa4mP10gIjYdOLBfVN3nP9+TTYVNsaj+bYOcrIPc/krXsba8LevAMAIOLj29+ZZl58tEwNKrSqHCYaoYpCRwYQpWaH4mjdCeg9Mhxd4kLSi9K/OINdAlR4Q9nJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeCk8hX1rFOBdhqCPodnRc15lwHgi+CZXjME427SvgQ=;
 b=QrK1k5etx2A12Pfa/HQPTzLUSDlZ98U/0q33QWl276/+9e8NTif9y0MWzgPwqbfANm1HRf9awLNiSrl67lcvmOwdfyTi4EcKakhjcCBEEI5e/ZonfZOjR3wcq1p4y1H4u/iPb4U/smkyjGyqjUJQdDjpPqGBEM8aB6vwMvHei6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by MN0PR22MB3668.namprd22.prod.outlook.com (2603:10b6:208:37b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 22:57:02 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 22:57:00 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH v3 0/2] Add PCIe overlay for am642-phyboard-electra
Date: Mon, 13 May 2024 15:56:44 -0700
Message-Id: <20240513225646.3603803-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::10) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|MN0PR22MB3668:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c6c63b-73ab-4941-0674-08dc739fff34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|366007|7416005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qhSxaKinaGH0mpzU66SqBs04KtahzZeKbTojzD3KjV0CbpYbM/bB3Vfysiuf?=
 =?us-ascii?Q?5IEoL+FOEPO4vomVd9LaJBAhdsEk8Gr3mq8W53ztgJX2TEP31JvAIMBq1134?=
 =?us-ascii?Q?xvHhxYojGc55LjeCZkuXUtNyUdyH6ahkVITRnTOGTOgrjy95KhThBX+S5Eci?=
 =?us-ascii?Q?NiYOVIfjY3LVkYnvQqOIJJD27ONMO0LfGDnh1FMEj5ZU2sv1AqWtbE442YCh?=
 =?us-ascii?Q?H664Q7TW0zec9+gxY0/Ch5eER7n8EzISnB5oNi6q0K6XbCAk++ZgW16unYDG?=
 =?us-ascii?Q?h9bY5gAo3LEkWfsKowH9I3VUOeawRE2voHNZ14PLsV6KZjcjN2+okAYVzZP9?=
 =?us-ascii?Q?FqVriO4DqLfYig3VxqKdDCXxbboLzadgL8ESEgd7z3vQJttMAeSv2JctxPhz?=
 =?us-ascii?Q?zLytbtgxu+ReBxqcux0+0ZwbzelgfrYf8WQwSxNNYWBgys9NAxja67YWXxLe?=
 =?us-ascii?Q?MWNFF1UpLOWabpaqEwvte3lrb/7LN0hQtrCVtpLwN2AIOPfBTiN/I9nk+Pg3?=
 =?us-ascii?Q?SRWymevQ4ydoLIncZtKF7HVIN++WLsC3KfK+9mGUkXh9MpdSpmYlSBOIjcRI?=
 =?us-ascii?Q?Wx6Wsf/bjhWTxjVhmNcRZYSiL4qKXusiyXrXHJdUZgQlC/p2RKt7+iRwT8Aj?=
 =?us-ascii?Q?3Dq/U5q7Ma+5rAHW3EdjF8UI5eVeNsUwBnQZS+5HjZ796v7nb9fWsKx1fRxC?=
 =?us-ascii?Q?66kXuNg16G0eKvRGcIhlhwFYpuoDTam9sZAWgt2HG3apZE0xWcEx6l9+37pz?=
 =?us-ascii?Q?RIJYa0XUCosixAT8rH8I5HZY347eLAlePkZa/rvmhKtVjMiysUjFggQ9Fn4N?=
 =?us-ascii?Q?3oYit1Rqcn4/lU50NB/nGm2vs8xSLNPPcBM0irN03y3tq6n5YLhSzZjf01pB?=
 =?us-ascii?Q?Yntz/arWMRyR3qMJNlTJqpJp17kZ8LOvZk3zy1a86CAD5mPjbgrM7TZQ33xx?=
 =?us-ascii?Q?kRrNnbXbR/g300GZuV5/bpRhUFeyQOPpTek3OS/VSkQNmTjZjfrcxh2jtwV+?=
 =?us-ascii?Q?tNV8D9Bk5DhWZz3+/BSYK18TNCEXkSHhDSVn29MZouioNYKw2Vc4sq19BzX2?=
 =?us-ascii?Q?2HVHOQcYyEuulrZV3ZMAKy38iO2U0Ck8uWmfFlM5wm1NluTzu0DZPOnX1Ny5?=
 =?us-ascii?Q?DZmhkArt+Dr5r80f7kEn43Gyfwq01HdNQ/OZ3WmcP7E+NT0AFfWmaEY9Jtkj?=
 =?us-ascii?Q?/StHcJfQwx9XSJvAnoZhdziENZeJmngOYx1wtZHBb1DdPEmHhyrccMYHWgsl?=
 =?us-ascii?Q?a2BB1NKr24aXl9m9mijcxeuaJvOa/KkKu31wcV/Z4SGBYGE/4LT9ttCLgh28?=
 =?us-ascii?Q?nnW2qlBBhO5SZnvitrVkrTg4QywQTf1wJ6MIo53lJ4n8/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(366007)(7416005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l+fZIj4xqmjmIalvrhA9QqHBtaf+WDYPpM1Y244W9itMxRw5fi0SbxVIubmN?=
 =?us-ascii?Q?wHaOfmDtCf1/f0Htjcat156Q34NLYsINwsed+BjywqdeGueaXZQ8Kutwamxs?=
 =?us-ascii?Q?/fjhhEWFa4RgwNiFcusOcZmKVDBjjCK1br1ppQIzjbFBL8jAH9gS3wWotL78?=
 =?us-ascii?Q?Sm++QPsGztMcUOUYwGYoJ+5HBg0TJG3t/WKcLS0cHR1pvRl2rQe7qpEgI+hp?=
 =?us-ascii?Q?kT1H3iNkEairC8eKs1Zd1jp+ExdJg9DRpbdWmy195EJmMA/4S0AwLuQobTzj?=
 =?us-ascii?Q?izvuTgVxE4f5WUo05uv8SCUk3ndWnV+cjwZDpBvnug5Ra8nlpyoTkAxsTCj0?=
 =?us-ascii?Q?MpqkD30dA6Or1WdPDbSf4Bd5u1HVU1LvnHkvcfXpWXw2EGxTsrjRzsTlGlmL?=
 =?us-ascii?Q?VJUkJU+huXSmF+/qA6HVdIRxQVbDZ2/P+fYZWoQASmmTjWqTTDWQGAD45x0v?=
 =?us-ascii?Q?nlpyUqk6PmOGjrRIU7So210hEnltmMtFu0RhchEt9iiyZsHAVgRabLxfvBVu?=
 =?us-ascii?Q?0XDoSk6GI+2viO+2JrpbbXS2dAQ7byi1vLYKQjB5IAz2ueK0bbNDyjzcjUDf?=
 =?us-ascii?Q?haKwqnSA+RoaojfJvcRs5MNEAkHSxrXoyIDjSJVddX6lcpAJ0rxO+mv1ssr/?=
 =?us-ascii?Q?C6E9YV+DUyf51hhOv3lbP6kMLhoRDEyAFyS/1w2c54FCO92gLQ7QMS9FFjMT?=
 =?us-ascii?Q?VjvQiCJ2XiJ7fCB5dHUm/AYn5LHDJUZHjLI16vVpCRtvF5bcY/3OiPWVblAe?=
 =?us-ascii?Q?wal/xl5vxME9Pa9MbAFv49kbYlQf1p4e5TIpnv0yikWb6VVYPbR3peb7hBeP?=
 =?us-ascii?Q?Nov4RGOhEQXIO8nB+hm6lnIIaBk39CPFaVvIegkGVrSMS8nYvN0+awEZ4cwh?=
 =?us-ascii?Q?hqukVGi9g+vBjL8jmFwn2QWKVFbOVOmVKg/J7TXef9wFtkTqVPKb5uVLLrKU?=
 =?us-ascii?Q?v7NwsADWchAKSYkyxQHfYGEvREjiX1u2vEVubZaH1fW884pX+ILBuKFEBYCx?=
 =?us-ascii?Q?5/O3tLchGsGUUBKe2QoClaLjao57lLxnhRHjJ7cIJPNAGMlZ4AQ/9YJ9IqbC?=
 =?us-ascii?Q?JzSpC0hHplSIMoWCGTsz+ZgOOnyauwgmnmGX98uKgTyhM1XrOCL9fWhHto4b?=
 =?us-ascii?Q?P0X60SJt8bzRt4NBzir3rW8wxDxCsCllycaig+cxoAKCa7gEF+j9grAubfj8?=
 =?us-ascii?Q?UxZ4PqgCNdK9p93j+lTINW28pfQnglKVqF6q3YQWZ/uBwHhyamPkxyEJkBqK?=
 =?us-ascii?Q?/hy4bG5yhVyX/Ry1zNLe6sobpkux3LfI/6XJhV++orVtiXXtREDSGvsTH4lr?=
 =?us-ascii?Q?OmEBZ3slIyCZkvkavumwbH4Mt2m4tcP3i6Z/O0DfREGfa/Bf/MIYqUrA4lyZ?=
 =?us-ascii?Q?LpgmqY80POys8J0KXO96ctuFSlFNCWYiUK4KDP4rsmzsFu6q9qKI1L2la0TS?=
 =?us-ascii?Q?XfMgqqmrSNfDQZ9u2ROd4E1kTukn5OycdGMMJieMRa183iV8jN+VHgba69dJ?=
 =?us-ascii?Q?CiJgbiu+SXL6nAKnp7sdfItgw+EIJpTj30zY0QeOcX2hdy0tOqdZMVqAiAYO?=
 =?us-ascii?Q?6R8SsCV8iKO2SJOAWRypDiwAQ9D4hk3mmChrb5SN?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c6c63b-73ab-4941-0674-08dc739fff34
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 22:57:00.0248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xN2pChXBOMv3rAhaJhWoZEfEmq41Ot8idccg+mgUsT0nYUd87xGOu7527ZdmlnNZyIvtxzkQHsaHBfBZ58QEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR22MB3668

Remove PCIe pinmuxing from the am642-phyboard-electra device tree and
provide an overlay to mux and enable PCIe.

v3:
  - Fix typo from .dtbs to -dtbs in Makefile for overlay testing

v2:
  - Fix double space typo
  - Remove redundant status = okay

Nathan Morrisson (2):
  arm64: dts: ti: am642-phyboard-electra: Remove PCIe pinmuxing
  arm64: dts: ti: am642-phyboard-electra: Add overlay to enable PCIe

 arch/arm64/boot/dts/ti/Makefile               |  3 +
 .../k3-am642-phyboard-electra-pcie-usb2.dtso  | 87 +++++++++++++++++++
 .../dts/ti/k3-am642-phyboard-electra-rdk.dts  | 12 ---
 3 files changed, 90 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso

-- 
2.25.1


