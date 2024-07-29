Return-Path: <linux-kernel+bounces-265182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832CB93EDAB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DCF1C219DB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23BE84D2C;
	Mon, 29 Jul 2024 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="m/UWzSW5"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011023.outbound.protection.outlook.com [52.101.70.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DBF2119;
	Mon, 29 Jul 2024 06:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236077; cv=fail; b=g71Gmje7DntBrOtWwlT2nwX5gIBBAGXtrxUCrLQbOHQ7hgNw6kiCuUYFqz59YPwcX6Aqb2m3Pg8WzGRZtY1syp2agrt/aGjlkBltO8+bSwbjzkP9ZzM6P+AXQ7SeirfcnZD+Q4wW58+MIcpdB8N+ozwTf3xT025T7JWn1r/42rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236077; c=relaxed/simple;
	bh=W7qTSm+LuDCD04MpGMu3e78fJua1zSpKjs+SIq/ISpA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qf6MzEUqGQ2gHDD21DLHNcqLw1nid0yoDiYvp8sJxSSuY0OyY0KeEI1SwMMAujsEwOyzjRXM4SqddGAT1dzrnO6svqcL6xZkQaCaC8MAOqBxZ57R/ezdfu3MR4gywrIb5VwZ48VGsaaein0pOJy9VoY2WJC7KCpI7WZnjig3AQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=m/UWzSW5; arc=fail smtp.client-ip=52.101.70.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZUPTN+023oyd8uBzRp+ALCSfHfaGeUbajcnb4lSgy63YuEFaKRpR/anff8ecWxxLS86G7OC1i0UseRH+GtCtjyNkgepV2kN34gJhUcpgs8Xx+wAmAXxx5XffAB+UE1yNpKjivf/INzwIhL+/17JEqEYaUlcFM4zB1xuvr9PqSl/Hpn1TMay5jSPzFSWFLIzpHFStI8PV5tKIppMuX0yKSM93fIvcc0yIKE4EjfbQP+hdcsNdnBo/MGnAD1uWdaUf5xeZznnfD5D/MeVQy3NDDFOUMVnhxivIP1RktC2WcCy33IHuvKgeiKS02E0penYs+HM/XwO2+F3IhtGm9ra0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnUfI7l7G+dWmuKWcK0OFsh68QfLnYE/LBrRY1hamL0=;
 b=AzhPtfc6Lt3Zyfz/wj0pUwdGrJpHYrC3tQZxWKNWhRws+7XX+1UPlgaeqTG2VYo3C5GwKkxO9/c348vEApnOCyl2YJdTDzyumU7gZ6n47cvFyaRT7VzCJpQVy4JKmqAY8hEJIgXqrqnr5k7hE1x1nq8YY17TiRgK/EXVwpNRUdOmo+5XHD0B3xA8MAI66/gV1jhfLmzoZ5W5tTdLL7cIhN2ypI0pSgpjdH7yrq4yKuIsj07CEVyOwGkKvvFPhdfWZ2j78IDO+Fxz4/MRBZn60tLK4dc7ADC6/VpUrFZT6jb7N+fRpD/3ShploiI5+gn3a0refRrKDmvj9rh4WJ6b4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnUfI7l7G+dWmuKWcK0OFsh68QfLnYE/LBrRY1hamL0=;
 b=m/UWzSW5az0n51BkzzNOhkCoAs6G/rc12zpf0ISHInV978Nlx3k1CMNUp7XMtVxp9nqj+txef5jIPwa6WtasrCLJXZbHNhVMVKB4nwKB1sdycjYUKwCFBdgSQ9tuD8+DHyBADm/9PPdVbhhxq8IxGTMzHW/TAvjZEHPPUunGfzys3C2QC8eZ6Yn11lkCJg6+a8dk8ljxrsxJYtAVioIrZ9lHBBhhMyH+VQPs8qKognCI6uk2J4yhqRINNigrnWngq+ynZkZEYuYGbDdCYp8iuocLj0Vbkn0MwNIqy5AuKiGWsoPArTHtI5XbMGA1m5GwXuOU49yvOYyfF7o158D8NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10858.eurprd04.prod.outlook.com (2603:10a6:800:27a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 06:54:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Mon, 29 Jul 2024
 06:54:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	saravanak@google.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode for scmi cpufreq
Date: Mon, 29 Jul 2024 15:03:25 +0800
Message-Id: <20240729070325.2065286-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10858:EE_
X-MS-Office365-Filtering-Correlation-Id: c99cceb6-e84c-46ca-cac0-08dcaf9b4c73
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SSonQv2j60LcY7ol0bgaPt2tKXKEuJu1lnNdCkdiz/rgDpmzCkDwqHDJ5Isz?=
 =?us-ascii?Q?beEPE8woXH+hc+K3NZG3sPTd1M4MSyLX7hKv9ppsOFzvQJwoHyEXc1vmEUiG?=
 =?us-ascii?Q?Fun/PS1cuPtwsGBhLMY0Y3ggaoJdWc0irZHUjO//hQiMpK/U+AbyhnTh4sG3?=
 =?us-ascii?Q?QBJH9qk3s6be3T+007vqlXrJIFueT1CN5nWkNfRosSIuMH8E40HX03GvBYjJ?=
 =?us-ascii?Q?VtdfrX+RmJkA4FW0Jml9ZRbe3YkhQTRGea/+VrSyYV3RWcR59ppMFhw6TnwF?=
 =?us-ascii?Q?244MwcYqHgiXRBdOTUbz+tDtkrfe43huw1qcSM7NC0FrHnKbHHU9omluXqw+?=
 =?us-ascii?Q?/UTSsQaZ5QqNjIw+Qjz++kflbAApO1nl6V+H35JDO2mBjb7S+Q5WnVynJ5EO?=
 =?us-ascii?Q?tKVqqWaw3O4sa0+ALUS3Y1+bpYOvuxYqvO012Cp1EQAGR4XG618Xw5AaqkOz?=
 =?us-ascii?Q?UQFDaByDhHWpnH5cY3KlyjPt+d14HLdqA7NPUTB0p5F+dsrtDZjruc0ksBNY?=
 =?us-ascii?Q?oIABcSzHIyrXISHI748vv4V4OhbruqaSJNW0tSVsIvqL1GkapzqhEu9QmUiw?=
 =?us-ascii?Q?6USMAAeaaFBfLgNWb8SQmnNmE6FvNpPqfG7G4Vya8uBXPixU71avH+aZhYyq?=
 =?us-ascii?Q?n3YX1YfYGkLUbI2cZKzBkPTgMCJ+u3W4TOhry4v3JzqpcJzHZYAfT3BVORD1?=
 =?us-ascii?Q?mDVwtNby1N1nlZqEaIDRb3f0oi8C7UbaIfmoHUD2fe5S6Wgxl81IO2pzgNdE?=
 =?us-ascii?Q?C060b/HmtiPFGmDox2AOFxmqimWOm5BPdYYOgF3k8NflPPicuIhwzoLOizhH?=
 =?us-ascii?Q?MRw8gf5gkQ2kXuiDodbkeC5sg8YCUpzyUxWY7BLVzFi0SGoComg/g9lGBWaT?=
 =?us-ascii?Q?C3G2cBW9uJLWRL2x3fdRenHPUqLV8teU4GZ0UFCBIh3GSVadLm6j18vyH055?=
 =?us-ascii?Q?LEW1cIF9n8ms1pu91jkTPB6IYVfhJmsaUFqCDP987E14lzPyHYtO/0d7hdTJ?=
 =?us-ascii?Q?NYnmHoOZnAuhdS7mzHDKGYy8mmPahh8ZyZBEdrwvw8DQSh57P4BNAeSiBn1O?=
 =?us-ascii?Q?eDFvHvBO6B8KzRRyi+wBVXW3FyHMOAIvxeyzfvPeCPOTIygP8STXBjQUEVhr?=
 =?us-ascii?Q?GhPAh9VvSEqye/4BcuIS1DpNEk700aZlIOyd/xdDQUvSPiUgSWVsrphO8w91?=
 =?us-ascii?Q?wqCaX0rreS0cJpSXxMCnoe1XCo5YPKf8FK9qhdJSKp47ypVp2fR40lGG7sRC?=
 =?us-ascii?Q?icC9SkcKtKrrupVfTDy3Zf6EeUFw2u5TLa7kVoNXdd0y+sWhZiJ+OGCL38hV?=
 =?us-ascii?Q?Lu7QHsylfZaZJKrbudTgUUkD8s1CCPou6WJO7XQdd856fGwhuGoxa+PIYDfu?=
 =?us-ascii?Q?u2Hxi4g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8hwbPJUOyRIuWxAbhRPrn/8GrXKImtZjZSpBEbx9umQI2TO4XUddVh1zk4ug?=
 =?us-ascii?Q?EuVw5X768LvRHves/dviNpUvflYVFqHsSetban8X2Tb4zK7/zzxZACCTQ930?=
 =?us-ascii?Q?n2x4pO2ak8UzjYOWtUyxe7FthE5vP8D57NiqUuslohBFpiw77eP4ayWehut6?=
 =?us-ascii?Q?yIB1jsqoLhi6BVxUMNqvuDXXSFolC61SDKRHnLjBixylIgH6ygjvGox1pQ3o?=
 =?us-ascii?Q?d2GuTrvTBIrrYpNbO6zDazUhSVdsK2eK7YYORBD1L5WS7uBJXfHcP8TKHrSA?=
 =?us-ascii?Q?236BpOr6Y9kP9j3xhE/OAQmCvEaj70Mz1qwdD6o9gOeVLC77zJhSH8COebNH?=
 =?us-ascii?Q?8epvb+c4RWgP0JXwnh18OxmhWXJttQHe6PvFOFZOspvaNKkZ3dMggph+oMV3?=
 =?us-ascii?Q?XHUcEAPciI8aahFvlH1Ji0She4+H5TgV0RhvaV0K6sSjn2s4J9dIbmco7VTj?=
 =?us-ascii?Q?JbnGfI/EcoJLcfvEFalCla86O9r0+CGnYhV3ME9cmMYeYbYCld5EBdDgiH9G?=
 =?us-ascii?Q?UyOpRSjSBre/J+NHkmEHSicjspAO2+L0ubyenXzIHf/FAwCKGkgAaVhCv1QU?=
 =?us-ascii?Q?kx2OY1d9prRlxyFMn3yinxM8pl+aegJyyMgnaa14bh7s3Cocp/EgDs8EDcgU?=
 =?us-ascii?Q?OoTe6J5RBp7JZQ4Ah2DHN8lsEAJLOXiTrrlm+uXL4FQ6/4Q3YLNXu+dpPvEu?=
 =?us-ascii?Q?Q36zlMp63z+nt8SWhUnGvfnL7ffBvvFBAIFKykGIS0R0k0/lVRgmU+Fh6Uat?=
 =?us-ascii?Q?2yUGSpG7uzFvxJEMsVRUs4/XoaWW7396abohQQx+pB0jgao9OykkJK5xTHGK?=
 =?us-ascii?Q?zVIXeJRGpjBzAdM1p/1Sq1O4l8NcDNC5W50oseDgfYiaA3vb4e9HVYU68/lK?=
 =?us-ascii?Q?Q7WprSWhemY9sI8hOqySdd3HYZ042yZH9aJR+9oKhs8KHKCWI6sv3Ugvk1WF?=
 =?us-ascii?Q?vKfDLVTM6wBAaEMXYiqN74+odULnuFqFtiOO5eijK+6glthic2JR3RqWiVmI?=
 =?us-ascii?Q?SHIGo1wyTWx/P5aOcGgI4Gc8JMzFbm5/VXHXHenfA/cZPnEmFUEfPqU/MADQ?=
 =?us-ascii?Q?aOu3yYl2tzlsU10iYx0+Rn4TMQxMrN3lmrPT4jMU/Hz4ksrzuTpkU6r+TOM3?=
 =?us-ascii?Q?9DrPSB8siWAKMN2jj574Dk3nKbrCFs+RwjZdhjC17QtnAbVQbnGJCx1i3nYF?=
 =?us-ascii?Q?+hmewR6r6NLqzrRM2Q9pYznrXX1leYl9JQlgBMFQygTAy4FcKkFZi1Fo/kRR?=
 =?us-ascii?Q?slyC8EU/3RRWvt00MbEX4pzmFbX9/DkRnh4WJTQQ+cBxMziCHyG9mYFajqak?=
 =?us-ascii?Q?D+UAgCAHCMoOOlXYyIR+ko6lHMV6XI4v6LHD4UXkyxmkT0Pbp74RV6aRx5qE?=
 =?us-ascii?Q?BTA72bSpUxhbd/IdGKlU/wG2CpE/GJWOTbzlMeZV/GAhItpAArAVPePnH8As?=
 =?us-ascii?Q?iXJwb7VJCwg9xAUGb/AUnKhrjC0KaQTIBTW/lWUsQlER5R2jj928tJE64hPA?=
 =?us-ascii?Q?LbOjzSKYoNJJQz4x+T8dawh1z54MqN8+fibZVE3V6KE/kiVplCgn5I00l5KD?=
 =?us-ascii?Q?1RUsTC136My2FGj2eN+nMS37ZMa0eXfvxE3H9z0x?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99cceb6-e84c-46ca-cac0-08dcaf9b4c73
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 06:54:31.9043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JliauFhiWG6DnAplMbHg+n07+vk4GCP/7hTQXDQxz121tMeg9SOpKIbBAi7BGrCPtisk+fB2KwqBPFzi1u9GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10858

From: Peng Fan <peng.fan@nxp.com>

Two drivers scmi_cpufreq.c and scmi_perf_domain.c both use
SCMI_PROTCOL_PERF protocol, but with different name, so two scmi devices
will be created. But the fwnode->dev could only point to one device.

If scmi cpufreq device created earlier, the fwnode->dev will point to
the scmi cpufreq device. Then the fw_devlink will link performance
domain user device(consumer) to the scmi cpufreq device(supplier).
But actually the performance domain user device, such as GPU, should use
the scmi perf device as supplier. Also if 'cpufreq.off=1' in bootargs,
the GPU driver will defer probe always, because of the scmi cpufreq
device not ready.

Because for cpufreq, no need use fw_devlink. So bypass setting fwnode
for scmi cpufreq device.

Fixes: 96da4a99ce50 ("firmware: arm_scmi: Set fwnode for the scmi_device")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Use A!=B to replace !(A == B)
 Add fixes tag
 This might be a workaround, but since this is a fix, it is simple for
 backporting.

V1:
 https://lore.kernel.org/all/20240717093515.327647-1-peng.fan@oss.nxp.com/

 drivers/firmware/arm_scmi/bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 96b2e5f9a8ef..be91a82e0cda 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -395,7 +395,8 @@ __scmi_device_create(struct device_node *np, struct device *parent,
 	scmi_dev->id = id;
 	scmi_dev->protocol_id = protocol;
 	scmi_dev->dev.parent = parent;
-	device_set_node(&scmi_dev->dev, of_fwnode_handle(np));
+	if ((protocol != SCMI_PROTOCOL_PERF) || strcmp(name, "cpufreq"))
+		device_set_node(&scmi_dev->dev, of_fwnode_handle(np));
 	scmi_dev->dev.bus = &scmi_bus_type;
 	scmi_dev->dev.release = scmi_device_release;
 	dev_set_name(&scmi_dev->dev, "scmi_dev.%d", id);
-- 
2.37.1


