Return-Path: <linux-kernel+bounces-297208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9467795B482
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C38C0B226F0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38DC185924;
	Thu, 22 Aug 2024 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qqKx3404"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2053.outbound.protection.outlook.com [40.107.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497AE170A2B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328097; cv=fail; b=VSbz8LSNMZq1hKyImibK0S3O+GFn/4x8W1N+qYgDsDOWTcQYnI+CTW6Nv3ps6oXdX6MvbJ3/1OpSsoEVJl15yAFEUgLoiOq+9qVcAgxlqzEJjkHwkQf8uOBFFFr1ZEUqRaqvptvaPzPSl0ob4xkOXQpm4oXeeQ2QSPvLGhdo9kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328097; c=relaxed/simple;
	bh=DkXtxYf1u6LlQ+4mCa0XCLrSXT7a+BUAZqdsJUzbR1k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mxtor+m5OcvcDKyGo/FlckPCYlCDYcd9EDUPHWy+yBG6TjeHO/Oc3dLpW0qqHwyjtU7LG5J8pvjevF/T8+tt6HlSw+z2iD7CdCUSJ6eRiZIyYpo8t9K6atriKWk2Rah1QHD/aXL1ooS7h3rEDMpvQ92JoyuL5mVVrw1lDj5LWW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qqKx3404; arc=fail smtp.client-ip=40.107.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjulErHir9ILvsMA91NMYuBOePeH5WQEnsN/NSW6FU+UpDF2+AQram0FBPtJOSRM0s1V2xNM6wO7VSA59VxRHJbSg78VVg9zAzLtLgrx92dOTMUYyzmp+1SqdxnnYVNsbtEzrJpfs2c9ySOzLVOlyvz9wPe6HLwz0eWEsTuQbyqd1v86r/53PSrqNb2Q8KmiS6rMHN+Mo/RpyPKkKIxDe4P+eykK64wS96G5eIM2oAK/6gKScjN8TeS6fXGzSlxOMKiY2lKHsxQOIxddULEJS6QEIvy9WRxadq0pmVMPKTOaRpp4Xx0d7LkToC8bm6La7gJGeI26nMFsgSpAJsrMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcnb9OE+uUrqrr1k1BtJnchwr0aFn4mL7DonHdjXWD4=;
 b=ErXAiZbYBRWSZDIfgRv3h4rfHg7HE1w9e/plXQ66lBlm09DnztABVb+mjDz6ds/eVK4M1BbCyNUQbCJz6GYX6Ne/knYJ1XS6XfMZZpgicPBnfFFXfYGVVNnsM4TnAElR9DWwZUIg/y0p3Xq/LARLgnbNnsBpBQCFQjztoASaOcqJspPVsK1EYZglJ1GnoT1PEsHKt1mBFnbO1QZUcBL1sxTvjnMZ1nlRoV2D7JJaXojrNgc16dGzJ07zENlgyfi0ktSZpsvtgInDx75DM8r7Y76T8jFLPVGUcBUYjpuB1/rj6vUv/H047xYUMXKdzQIoWdXmf525acORnX2Wk6zkxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcnb9OE+uUrqrr1k1BtJnchwr0aFn4mL7DonHdjXWD4=;
 b=qqKx3404adLxENHhPHEsw1g4X4LlAx338QmjmuUjUHPbyDy32zevfZ84Paft9xxVipkajujC8YmMRk5U3VhmaxrXrhkSku4wSFqAdoK3Upzz5WzlAAVjVttw2f9UXVIpZqIULIY94hFocU1HoVhdfgKnY6mS0wFReXUs8jDRrTOlS5gCCxXnJzA4gLOunC6p5pNpReILk9Tiwjt2tv6blLgyC7iiVxEjiWDuwEwDRSf6QvvFrQ9Ha/yBfjBEoK8S00Y8V5KpiuhOcESWJdY6ghy4RFkoR1B3XRfcZHJJQbKtbn7ytkme5mfqgERZqt4zeDgMolUoJqcrheBKnbSGfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by SEYPR06MB5489.apcprd06.prod.outlook.com (2603:1096:101:b7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 12:01:29 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 12:01:29 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v2] intel_th: Switch to use kmemdup_array()
Date: Thu, 22 Aug 2024 20:01:10 +0800
Message-Id: <20240822120111.2096548-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0273.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::12) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|SEYPR06MB5489:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a03a41-aee8-46f6-cfd9-08dcc2a227e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z5+BbyPvX8OipckV/izW8b78t0730gtwFogf10nccbaSX1ihcn94RWY8yXUN?=
 =?us-ascii?Q?OkKBBhfJv248gcNTWN3BcawzZgGalEjzFTX+hB2eQKUQJJVVXnwhl4BEckUJ?=
 =?us-ascii?Q?8BTnvkcPJd2+03IEVvfeTLZ/ZjrZhERdDuAP/yfuHWipk5gXkfVdvh9VQz6b?=
 =?us-ascii?Q?4BJ0YFvbrYAqgq/zwVlYBa70UQIhG4U6+xLvnMBzjF1aK4A2jrVIr99m4XMZ?=
 =?us-ascii?Q?cMRq4WaWQNvMe8UyWuXnjypNsF5gSD9Q4Gqr1chVIrKBSJVCvrVN9N1imD3z?=
 =?us-ascii?Q?jk1IigB3gMLYbJew2PcMFhgMkPjEzKliMci9wcTzq0Q68e89/VXXz0y5sme6?=
 =?us-ascii?Q?YGYE5xU5K+RTL+4pN0MFDJUUW0RJPN4Bre61HSF2ePrI6OhYQ+uJgIhcq8J2?=
 =?us-ascii?Q?Bl4dpJ0ykq1aJVfADEnl/DOZfQmnXGqNusS5xKECxjI/DbhD6K3I7qLD1gac?=
 =?us-ascii?Q?V/PpLLyIva3oRVS91sf9EqQ94wS2qq2Od50Arm1QeNWKubl486TJwfFJ9EcF?=
 =?us-ascii?Q?kC3yr224ZRuOZS57ptdOWJQOzdiIo4LxlQY/84os/6TfoEWYjh6sfEOJyJIS?=
 =?us-ascii?Q?KsSoNw50hHntI4NI1RQU0gvBosqVBqcgU1NZHxhVzEGsQ2vWLlbr1SeZ73R3?=
 =?us-ascii?Q?16mfFr2L+4sXrmJ12oveq6qlgerp6lU3fBg0s52G55/2JpFiF+L4zR5+HE2w?=
 =?us-ascii?Q?VjWzi5br8Sr72UXpYuHFVTiU23IEgkMivq96bKjkzY7Bos3WyMbGUx0K/7hU?=
 =?us-ascii?Q?+GEfpF0jSxXOyU3abj+0OO8htF95wjkdOcxFOr0EQxh4OsZbmju7QXG5Teuo?=
 =?us-ascii?Q?9HZKjT6xUF+0yJazzG9ZVV9KtIsg7LmoBbkunWQ6C9l7LC6zz6i0Wo37tRAW?=
 =?us-ascii?Q?r0zHXRXdDylKNJP3VxLpHo4n9Mrel1dZYR27S89W84UbcGcFAqepJ4SVpnBi?=
 =?us-ascii?Q?gapP9RAC0S7mUnocZQpO5z/Vji/6TiPKWZOXl/6MNHLJWvwW9AASDd5bemGy?=
 =?us-ascii?Q?aRkK1oZSwV1XMFM8dfCqfdbYCeE34yDMML+2HqH8PXMfiZhZzG2kMDCWf6Se?=
 =?us-ascii?Q?bNKxHDt8FG3vsFS765LZPCxkZm2yWJRBEpQXJA90kp5+M+5NIaqUe8QO5J/0?=
 =?us-ascii?Q?NdD+E2dNCGR0cYIl4Cj0PegAvGxowU+1MN9gn42O0MDLjgLBGr1PSr8lEg3x?=
 =?us-ascii?Q?miYRzge8v5egaKtCk+Ghg6BhBsC/Oyc/2W8IZOiRa5rKWffjMWiuz6DYz0P1?=
 =?us-ascii?Q?uU7u0XGXKYcXDOCczRaZm2b06scFFpHyfatkfoiT0xixtu0ZPKTrjOjh3BW3?=
 =?us-ascii?Q?GFOFwhHY6rXy9jyRiD6xHokfh2szEXK5U5Ur+Fy5jDpQ+55vNXdNGXf+8lyc?=
 =?us-ascii?Q?oTnvzp4OUVh9DHiuaH1+ziCvgyGhh7EA/MJZE91GZCx652ia2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YWClQvoVdSJT/dbThGLfShjgTRAVg69pvW4Su7fkMcv20j0CPnYw9UAGzb4A?=
 =?us-ascii?Q?A8KayKS7U/XPhMQS8nUTadh1at9NP5IvfUHIvXLHyRsu2Z9oUucCqcZCTQDl?=
 =?us-ascii?Q?UohUt08ZTlmC9p+jWYcRElb+rbVyq9fGDacvEa3M4hRg1zyCzWd4ARJ3n8JH?=
 =?us-ascii?Q?KCCemeGKR/z529N1h8FvGv7w5idAPOHzre1yjYkRpg8n7cFNmuqYLH6viOEc?=
 =?us-ascii?Q?QbKsBbRgtLkf7sNKSRlebjFm4dsvmnZ488i3EmFXaA5gJ/96fLQkFlcs893J?=
 =?us-ascii?Q?TJnhEI34KmI03SZaBp9hRj/Ywa1Df9902rcQN57WG05RYABNj0EoNtv4x+4r?=
 =?us-ascii?Q?8A591nonXRGUjSge4AqRBhNIX8fLWuLVKYvvh7JyDjUxPfP2dZ7ShX44ReB+?=
 =?us-ascii?Q?RVVbkOuXeDR67O39zMpsezC/Ytnl0Ky7IntBK9sPMXDHBZKpya4NsKpkPUJq?=
 =?us-ascii?Q?pZc4aW4+ATA1PlBpM92TWhrTCIsA6ABfkuAnV9SekieYF4jnLJeEWJYwWhx8?=
 =?us-ascii?Q?O9ECwNLObVjagan68812zKOBSxmQ5VyCyG3klr3PzZwv5VSqPs88Ifx7TMk7?=
 =?us-ascii?Q?90Ab/zfCl4tBymEwTt+LzkTUzt8OojAGXm3MsCh78Uru1nx910h8mfqRv/+1?=
 =?us-ascii?Q?kmRrqawfaNj+KQKVkWqiaxY6j3flVJ8/pt8oOwbDkjILcJ14Yclegxvy0B3T?=
 =?us-ascii?Q?0DDhvwcVsAUUTk0+t7bFgoJYHbGjxcNUvZMYO+ead4hd14R16zPcxpo79f+/?=
 =?us-ascii?Q?E3Ii48Isr61XKPNwrzqq+2B0u9vEZfX/tqp5D+GQvcbuK7d9+xbeqdzk9Evo?=
 =?us-ascii?Q?RY3VytSZuzhDMjA9oQSYwavUa37fnHwArw4/lIrnRmFXwzNIGHCNh4xyXdOs?=
 =?us-ascii?Q?Qg3Ggla3fzbNu9Cda/7HX9vUiE3RcsnBbxOPTW1bpp1Ywv+lxgb85XqlE7Zf?=
 =?us-ascii?Q?FCkNfZPEHg2mh+YWfc1qLkCHgLwHoGYyIiMiYMsXRWtFUnN+yCiBFU/cgHqA?=
 =?us-ascii?Q?I6iQqOK6T/4stY75Zu1+3XCqx0jEX7uu72TwD9iDJ94NEgpu9K2JCQE/LKN+?=
 =?us-ascii?Q?ytZ3AwtFoCmJ+PN/UpZV213XXFahWDxPp2VbjeI4gpcT5v3V/Vms2E9WPQPX?=
 =?us-ascii?Q?YWM71IMHLtsQdGV59cFD3VngKSV44WKdkx9GRLfS2G0+DreCJMIcufao9yfk?=
 =?us-ascii?Q?J4SKpdfxaFe/PDFV8BL10zZtQtl+P8HOCaGupAqC7M+siAQf0wHXIx2zHsgd?=
 =?us-ascii?Q?sHhUE3TQZlQ/VSgMPUsU3OcSloasi9TeSL1b8a0NvAxxct9ehpl2IRWWTfIo?=
 =?us-ascii?Q?clEGXvDdYgl16sRH42eNAEMS3VQGL+4EM17roE117wqlAO4brbMbQC65rNVv?=
 =?us-ascii?Q?dfylBm/uY2FobQXMCzvkrnXkJK20Sjr0dmm5gSEaE7joYFzaRpPiusJuUOg4?=
 =?us-ascii?Q?Add2ZIupRBoLf/PAlIwsgGGA7mgx63YuxZ5P7oN02RMpJH97GenEvfpR316v?=
 =?us-ascii?Q?1891OI5LoNBM3n2HxcEQTJ+lJczE4HhWds8DQsDYVEYBx321AJH+wYrfyC6J?=
 =?us-ascii?Q?kuZHUHetF+TBUEdquzTZ0PPXLaAzyKCiI8rsOP2n?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a03a41-aee8-46f6-cfd9-08dcc2a227e0
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 12:01:29.0712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27OXU11s2YhoIn/59GeHKf8V+fkL4BLFTt0WoveQtWHaKBUgOYvYhQdccfBR8YPNmGSQsPUnvLVtCAewGqzkmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5489

Let the kememdup_array() take care about multiplication and possible
overflows.

v2:
- Leave one blank line between the commit log and the tag section
- Change subject to intel_th

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 drivers/hwtracing/intel_th/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index d72993355473..df72037c1c86 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -408,7 +408,7 @@ static int intel_th_device_add_resources(struct intel_th_device *thdev,
 {
 	struct resource *r;
 
-	r = kmemdup(res, sizeof(*res) * nres, GFP_KERNEL);
+	r = kmemdup_array(res, nres, sizeof(*res), GFP_KERNEL);
 	if (!r)
 		return -ENOMEM;
 
-- 
2.34.1


