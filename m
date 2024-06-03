Return-Path: <linux-kernel+bounces-198671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AA38D7BDF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49DEC1C21480
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDD83B781;
	Mon,  3 Jun 2024 06:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="U/tSLR93"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E361238DD8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 06:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717397480; cv=fail; b=BGTJpDLvAAsdMGa3dgdCQ4XCOK/LxPZ4agFRpXzeGJpjYx5gvMUCrmf276zuYO2FZLjMH5We/B9K5OuZ7Eqre9ghMzZaY9h6/b7fjybzcxYukneJR+QzW5ywVKRH8qnAg7bOoQFwXhH056OAD57cEzy6Wl7OjJ8DmKrqbyXyX54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717397480; c=relaxed/simple;
	bh=mJ4iSqV0QtMhVxn6//Ncvqippnj2lwOcO2suNYuvNSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hdYEUTMiEwLr8U1CkZ1RXCzCzlAORUzB5D2eBJ8w6uFFDtUUVVgzpeJ+t02VhpETRU57Srd+3Yx5DPLVpfDBRxyNxcNOE+wJVQBdywCM2I9OpVyYSmoHB+0uQHsyJg4/wX9F37f+3oqQyI0Tt3m2XvHdwdjFmOk7aR8WzEZRYjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=U/tSLR93; arc=fail smtp.client-ip=40.107.6.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBEBlazKHIQAby7BV2yciZA1cVpH/MQ/RbI/XCfi62uCke3psZABe4hV+ftpL4hJ/SB7XBnqt7updsIzy1/Vvzbf3/K5Dfr6DUr3jzQdIGyMYnA9NaMyMlByuZQkvpc/nSgo1AYV1UqUkYl/VlCyaFRIRziA7Pf+/iDY3XAtdueGZvzfPzm8ruXcaFji4qxjwIMpewGfCK5fm2/tzd5xR34nXrB09h0QHmIe+C8bO6gFVkP6Mn1gsf+y9FW+KKEVtshSk0EdvUWzLXNxD0yS04SgB/U/OyKYJiPKm5kHEgfUge/5xOH7hrD3gXdr0IC9Sbav70vljPukKTRMY1RI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1wMuGs/fshPNU8uBRoHGzbhV3JXBfYAHO+9YV6n/4I=;
 b=m2VbsL2LN/fbDzOO9ee/0ORbCcERCVtFxe1PvR1gciAaWGojKL9CjIb3zqfIDE0SlKqozrgu2+lUlPQU0vWnPQNQDYkeiiNxe9K1De7Ai9jagf9KAKYi+jpw53QrghnSkzP4GFa6Z9RLhxJGiXUpKm0ayreQyib3fHJa43yMxmx8Rlw0uOdqw8RUVh5RWEEVwpyeaauvms273elZ5uuNxVJRRsUrYyP3wN4kM58XWtqP4k8FKj3PIIj+p7r9++NM94cwu7xZN2d2J7I+a/jo/oXirEJbDhs+VlWcTfyul3u3P5syAaHarEAkwWPBcnxf6+LFR6jleECyt8oTc+uvyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1wMuGs/fshPNU8uBRoHGzbhV3JXBfYAHO+9YV6n/4I=;
 b=U/tSLR93rsA0zhnAl7Afqzg9z0rrwlUtAOekyOI+wkqP6eM+0D0E+DOPOviQTw5bewZyRyLjFYYVFJRg2r9lCqSN8Fx9kP6Dl4dSrURHPZq8Z4Qn/j4kK89+VqKk2zZlGs2qu2nS1ts1lj57VrJCVwSjGYfoy2oEsYDTduMnro4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI2PR04MB10191.eurprd04.prod.outlook.com (2603:10a6:800:22c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 06:51:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 06:51:15 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: srinivas.kandagatla@linaro.org,
	shawnguo@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	aisheng.dong@nxp.com,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] arm64: defconfig: remove IMX OCOTP
Date: Mon,  3 Jun 2024 15:00:07 +0800
Message-Id: <20240603070007.2413599-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240603070007.2413599-1-peng.fan@oss.nxp.com>
References: <20240603070007.2413599-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI2PR04MB10191:EE_
X-MS-Office365-Filtering-Correlation-Id: 737ad141-65dd-47f5-d00f-08dc83999050
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5wZzo6OQ6BQHmCWBtvbnh81Gjql+sPqdj3lk3dsuVsk8v+NNWfD6k0SS/adH?=
 =?us-ascii?Q?X2mO9+7tgg2TnY3t1+BTKltEgUxDy8XCU5rYcahm6OA/U2Ud715HZPh7xaId?=
 =?us-ascii?Q?8m87Cq8Gd9ULCvNions5LTuZp9WuEwghOPt6LdzwDRn3hkf0u4U9jdtdFgfS?=
 =?us-ascii?Q?MV5B9jcQYZrZoAVsedv2rrpCvj1hCIKs/rGN8jfKBvly+G0CRRDq1dGwnCBz?=
 =?us-ascii?Q?A6i4A51cSYj1rvVJrEhU9rJFMTUHT07aXSNfHY8Wm8Z2wIiv1DCSkyM6gDqz?=
 =?us-ascii?Q?jG6U0tN+lViAMTjn44fSHhgH5LOFtewmZGdboQ+bQz2nbtkYJPagdhe6BkrJ?=
 =?us-ascii?Q?iVdWNP59ADLkVSXZI+Hy/P4GdjGmXurVxhUtQaBrJNOCQYv7Ak7L1uNK1t5T?=
 =?us-ascii?Q?o0hWlzY9cAQkCFVS1solQ6fwksW0yph7Ftt4rDapYB6Zd+9blI0HPqXjN+QB?=
 =?us-ascii?Q?6T63wSGUIxMlVW4hGPl2B41rdtu36T+B9bFBdLof/lgrxw+RbEDrk3oEb2ou?=
 =?us-ascii?Q?Dlfab1e1oYlQx4QNAG7H3hRL+DC32vuFSEF6+Rnz5JHiYQdj5Zq+7BztF8oK?=
 =?us-ascii?Q?lqkkYk5r8NQzzTVfiCP3sk8YV6kezQp8HvHrLDt+vhFpCqsql5Qqcl+mUKA2?=
 =?us-ascii?Q?WfZUzbFMqydDe669/aYbXnYFh2rYvUj9mavRbasVThfpPt6S1Vi1AZiKwMPr?=
 =?us-ascii?Q?kQDm+GmXV2pLXVhwtAbTZX6AJRDQB121hR5i7JYEDmY7kN9k/iPNwXJZ3l9p?=
 =?us-ascii?Q?wf75fcaInerEe6KoC2EFlRfR5Y6YXhWueSqyj68erTqPs69QTmanSm1YP3Fu?=
 =?us-ascii?Q?Y/2qmM+LBav4vfBSJAkvTh0yGUg4W/yZV9xCufp/UL+53YsuoMmp+8B4jbJO?=
 =?us-ascii?Q?kjdIGb4FKL3gKvXBiHOtXtR8Uc1hMAPdZO+I0/II6VcRQMLHXLRxCZO1h6lx?=
 =?us-ascii?Q?FX9Ah2Ca6j4v3HLcgCh4LmpUNQLGZKvIndOOgsZ1+11cWcFjSkoo0Lqa2LU+?=
 =?us-ascii?Q?e1+4VeIP2Se9O1Nz/EPl3jfs9Cs6mMeOFqrmNtRCtoDZ/8XcfdIBlpafXIRY?=
 =?us-ascii?Q?ycXfkTyZsRMi3KczPH/WjvQ6DOUiBTO7TpbMjb7T+/1uhDg3RkmwsqWLHYPw?=
 =?us-ascii?Q?zjoff++Vb/PIkw2XQpXCcSppkmsWu6sVfNX5ROrrA+CHhW+gPjCzIwmE5vej?=
 =?us-ascii?Q?zAJ0ZWUdCwq6400U7w4tR3bvIS7SkaH/MFpYERBOUQu1yqqsnbxcSObeS6CR?=
 =?us-ascii?Q?1KfDJlwmzMn8YsLn/EJYrv9yrjWy9CbsAjl7j8skGuhY/mEmuWC2zu67KlL+?=
 =?us-ascii?Q?GqZPFBuWR/W/78S397LadwJ0mPwa1BNJAF6DnKLozqs50w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dhXapjR5eXWIugEFnIrOS2heIdOeIWhTJ4e5C37TaMxVc1qy/DFuCS5dK/PN?=
 =?us-ascii?Q?w9317LqWL/tKxb60gJzznvrW7tvb1k+ne/2+TSHTR+doRjHHxLOq0Zh+rjQ1?=
 =?us-ascii?Q?Qup4ACfBPqb2QVO2V2zbRqcAG+JfcrLoK9SNoBDm2aOjUXXUJkofMPO7eL6e?=
 =?us-ascii?Q?wIogdh1OhbfKD4o7Lsz49Tn2ivhVaWhHw7p+OKr4/Tmzzx971ClwIxZihLul?=
 =?us-ascii?Q?4cVI2WBeb76PyOqr1gTNBCnJ2ImIKi/4zcGKbVwuVkgKL+Ip0g172zD6tNfA?=
 =?us-ascii?Q?j8sBUslNMn5Z0H2+ruHWTK0G+5QsD8eFj2wJNTjNehm5mfkfc+NlGpUfCBYf?=
 =?us-ascii?Q?T4e6kz+Y3CIb73NFTqQwovIc8CHjFyz6cFvDYGWetR1W4YGL9RhmcEDS4OsN?=
 =?us-ascii?Q?OzCXY9+aDEh2FVuq5FhRDDgCtu9l8lVh07+jAo5/ZaaCTv6CaxUFgI7aMtl0?=
 =?us-ascii?Q?qyjjdxP+yuLudTAAd65AZ3nXHYUh9Gm+MjdDYiZoyIQfzoacPd0PYb/xxme4?=
 =?us-ascii?Q?2w5Lg1SO6+5mMt7LBiFPg1bew8P7oXWpioe0TRPLX9ZpKyNUfVWELBZIYSB+?=
 =?us-ascii?Q?dnL4LFdY+192x9e6thYTtRxrLGTBQfR2BnU07JssjMEThEJD/Uqt85AKqod+?=
 =?us-ascii?Q?IevR0PCkH978tKIHINgwuzxHqqKytmqWSK6og2lXSlvzKMfGt/Llp0ih/DWg?=
 =?us-ascii?Q?oiobzfI83S4twjTvTtAKMTL7ZB/i2WemZ5YnG4Gn1Q91SKHIPLjCp9BBca+/?=
 =?us-ascii?Q?cVdgwla+MCLXCc1at6JA8ZA1rLQQzGhJ7cC+HbJ+b4IBdfEi0b3qTOQIvzf7?=
 =?us-ascii?Q?pxuD3DdEqFqJVVW6QYiI/plZBq160q1EATC8KeMXxwG51MU2VkYLc3MSSaXL?=
 =?us-ascii?Q?FgRUbk4uCV9EFdQXE2Vh1LHgGSo8D4FcMik4UnP4KBu7CftQKaKcbgkgVKAS?=
 =?us-ascii?Q?d2DUIRLCbGchqtORlSv0WZhe9VYKz7MN+U9b+NJL/qVhrUG26VVGfuWI9tmo?=
 =?us-ascii?Q?RWdJQ8S/WA4l5BZ9x37upakF9r9XXpraKK/J4q3MLp14B90inKVuckXrNKcF?=
 =?us-ascii?Q?0rNk/kxr8ymRo53sPX7nz1WbcsI1qB8Nd01QLGq8Am4n3MftxJFoP7Edb9cu?=
 =?us-ascii?Q?vcOld8CLrTgrkOeRpgN+vWE7yzfzezHyHSD+tBZHt0hUn3sbv6yXj8ZlMtwG?=
 =?us-ascii?Q?1fuyOWJ138rVEgWE7cBFfNkS0+QRUuWyfmKZ713zEGDDpH15vylcFM8FTV1+?=
 =?us-ascii?Q?Pslo31VlYZIbJ0aijRI5bz2iqsUy+Z9VH9KCrcs6nRdprvuqmYWsEfz3ZCH4?=
 =?us-ascii?Q?asoHwV090+x8EAgqy584cXcSVQ2znTvvVwIo8rA1mivmLJM/mgarSd5oHzoL?=
 =?us-ascii?Q?zlPn56rLERyXX6ViTZJ/blBnj7qUGtduQGhALbtNOxSVMf67FEhq6ppnUozw?=
 =?us-ascii?Q?DkR6mx5kpjlanyCY7/MOOyhoiAPvY0keFxyg6z4M1r4pzrmQYX9z3Uwa8Of2?=
 =?us-ascii?Q?RxTGTfXC2ZY4Phn3uiyyll27vsIyLUx/tBhhw4kZ8UQOYK93BIgOxqLrIgow?=
 =?us-ascii?Q?+EpqOec+YoUfxobXuWuGpHif9GBk3uD/wGhAXvZn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737ad141-65dd-47f5-d00f-08dc83999050
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 06:51:15.7701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f84EwsqKQv+fz2bvdWa2byMa+p/9Jwn9eQ+QD030L96KW4zTyhxGNE/ACGdoW5sUqAFXHkQ1j48hTCHv2wkr3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10191

From: Peng Fan <peng.fan@nxp.com>

i.MX OCOTP has default settings as y in Kconfig, no need entries in
defconfig.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/configs/defconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6f9e1996694b..19797a26e697 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1558,9 +1558,6 @@ CONFIG_HISI_PMU=y
 CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU=m
 CONFIG_MESON_DDR_PMU=m
 CONFIG_NVMEM_LAYOUT_SL28_VPD=m
-CONFIG_NVMEM_IMX_OCOTP=y
-CONFIG_NVMEM_IMX_OCOTP_ELE=m
-CONFIG_NVMEM_IMX_OCOTP_SCU=y
 CONFIG_NVMEM_LAYERSCAPE_SFP=m
 CONFIG_NVMEM_MESON_EFUSE=m
 CONFIG_NVMEM_MTK_EFUSE=y
-- 
2.37.1


