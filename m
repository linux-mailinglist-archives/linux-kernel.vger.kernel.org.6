Return-Path: <linux-kernel+bounces-569670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25F7A6A5C1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E97627AD537
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27EF2253EC;
	Thu, 20 Mar 2025 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZWW6Uv0o"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECC1221D8E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472233; cv=fail; b=E3KLZ/bXo0e1VU7lwctmhuxGPcxq1Kr4xUMJJ8LMTU37qM3WsF62Yyr0J/Em6YgU0nm5xBiplSXyNbjSihuUz5Zv+HgVgKV7XzHTKoedEEIqcnQ3+7VbnV/W9nxC5or4ho3wmRS0iNq/LZkzLPyF+awZPYgFBXYo9XFTf8KC8gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472233; c=relaxed/simple;
	bh=PRXS/b3vakrNEZBi5Yc/gD9RNvZXPyS0pM3XIIbpOR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=guajAbG9y2wPqKIGpQZ6D38YbZHGhL79akNIK/gJ7xnoRTbfnclDdI5NzzcAXLnfdoAPfunoixOZAbYLDne2X4C/2MDd1d3Rj6tyefcbYBoXVQ3D9kwvpqhIi5gHaV7T1kAaX/si/gpb7WnlCK/uQC8zCYlBBsXGz2afwk9J4ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZWW6Uv0o; arc=fail smtp.client-ip=40.107.20.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDAKq7uR0Fs8vUbsVGfBxddZIlyIR+lSPJZq+B/J/hodLDcpmqMrXnuandYDWEvx4rRfb+i7ygFPT6tDA4pOw7aSoLJmO0ZJ0TaKxFldi0zRPtnEky3Xkfi0vZ2X3g0diqnMTZJt4ejukdFKVdE3M9nTcjLVahsE8LCNq0OPHhjxP+LwAWcF1VDA9SDPsqoxRAqYEgnQut7I64W36QKerUvYR3McyzxdzAn5mE2GYR3q2VcA7ohsDYIFkCPhACc0Z1Usp0BJV/MOXp+KoDUYz+QfQoly8jwoQshkY3/UKdZIrKtPjSfCiTxzN32MNCQqf7CkcVCgv9isSk/BXzebgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GgQfeog4lKp71bi/6hNWaAOdYWTEji2MyeDO6XlExE=;
 b=Vxxu6z9xk3WvEhVNaUdrd7MYgRfpX/MF/5qhjaVLb/FOFn9DwymZalFYQ7WhPC/suWBO8hzwcShyh9KytFwq4s6vC35iWhj9OdgF92asn/2ogpgxmpBrqa5gxIew/dkrcQEkhGj1sc5j/z1/yw8q6LZ2qqW9kyndkUbt9J2zcr7KnPr2Wu4/Gee900G1MiqKWmUopPf0npbhcZsoPksRr5lFGvzTgnD9xCFKxM607YTHk8PkcG9dINe2H7DI2otwP1O+dU3lKa6aCuhcQx2IkamUa5fRdMZ8jYT1zV+tVJelDovYAgm0ckdZ/F5ylUOmQV9ZVeeAaLk1wrQTYA54zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GgQfeog4lKp71bi/6hNWaAOdYWTEji2MyeDO6XlExE=;
 b=ZWW6Uv0orx+jaUEUTVXS3xJH2PmvDyS9sPwkkqAs/opuPmifGJSJFSSUFGzxKvmQV9boC+Op6disipVr9jCPHCmXA5knsfZ0YANQjOy8vRZy+Cc15apWdNlQxYkUnfdfpn7wpqj9OFjm5KChqREwAD01fM6YKZXIdHoVK3FonpsLPt4rp+8npUWqx/cvPF4fqRw4zrfNQgIwtldpQ+x435WKQUIGOeZg6yo4Rq4KgFZcCbuHe0KqFpN7fe4qPCc1e45RHSD9963HLTukRiGfiTGu4qpNytwI0Ox8ZuPz4tY0MJbP+nAQ7S6cnDqJkpKkP0M5osf4ZPHtva3oRJoEuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by AM0PR04MB6929.eurprd04.prod.outlook.com (2603:10a6:208:181::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Thu, 20 Mar
 2025 12:03:47 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 12:03:47 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Stuart Yoder <stuyoder@gmail.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 2/3] MAINTAINERS: fix nonexistent dtbinding file name
Date: Thu, 20 Mar 2025 14:03:18 +0200
Message-Id: <20250320120319.3520315-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320120319.3520315-1-ioana.ciornei@nxp.com>
References: <20250320120319.3520315-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA1P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::25) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|AM0PR04MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: da5b0727-8d6e-461a-b25c-08dd67a74544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Eci5rMwFPkI47TTHDxI2rzxdZZcUhIjiAJ57I+h2DRZK3if3B1so6PPncA9?=
 =?us-ascii?Q?VGPwzbFlLg/lHeuoq8LH0FhLd+I1gSByXveZCMsrMz1AbSDVaznN4Hw8+k8N?=
 =?us-ascii?Q?7pQD/5WiIWELQbERno+sbJjGOhngIGkuiF2nb+WvU4L4a2J0ioisy+VgbjAe?=
 =?us-ascii?Q?fDCtEE/ZG8NijdpFKL8Y4o0JlqWfyKZITQp6iVT43BXTifDYe6J65qinEhgA?=
 =?us-ascii?Q?WWOlCdQSH8lJPPTKIQpzASh0VAyGHi0TNYPBw5H2VEzgBhByW01sRh0UosqK?=
 =?us-ascii?Q?wBjeOhmNNaBZY5hXg4NocFbIHEycEDNPru99qcmTpxbBOhBEjETJfKE2zskG?=
 =?us-ascii?Q?+TT8xRAdtCzY7HGr6wjQhlmP7xYHUu2O/EBgpnShm6prUDEOrpKf2KD8yL+C?=
 =?us-ascii?Q?lzWmv1kKzGKHeAwutFJy5PPNueFVuEhqmETbwF5O7a8n6ogIyi3Qd600khAL?=
 =?us-ascii?Q?xWFZoaZ2fGiggH71xkTH6HTcfepv/huS18HD/EQXU6VidcT7fkhKI3ugzcUU?=
 =?us-ascii?Q?6Asdh+2KCuVsto6DCOTJRcGEtwvgzlyxZ+XJ6fBkQNpO0YQ5GixPA+Cv2tqM?=
 =?us-ascii?Q?f+quvg3yxwE3835GUFNOLa97k7yhsRo8L6CgpzB6ElJWSG8In53INVcyTYTd?=
 =?us-ascii?Q?K/ZMz21fxis9AznmpyzoM65RCgshezLg/auI/UCQGIy9xapiGq4dlQNOgFEV?=
 =?us-ascii?Q?QwU9P17QX+pKT1GypJHvB0wgDf2x2hY6caKdUCEKtj8CwOKC65DE84VHKbzt?=
 =?us-ascii?Q?VuvKVEXzxcVt6VQ+W9m8bFJ99xYrpSgAYmhAJelD8oOFHA6/BRAqiuhXExZ1?=
 =?us-ascii?Q?rvrag7hg90ogeLwiS9P/MYR2wyIO+tRiS/xQj//BnOTiRJZSKtQW3KEHFn7J?=
 =?us-ascii?Q?tHbLl0HkVFilt9P8UNCEkzKX0oZb2z2wk8egd1G9U7HmLmAOnZqrKL7x8wZe?=
 =?us-ascii?Q?7VUV7oanhd/DvCbAR3B9yAik+BrsMdsoVC/dTxKZgvGVf0suF2o4La6osANt?=
 =?us-ascii?Q?7jWim47+m6H5Blr/VXtcl+4rmbM7XYp8CZ3tp6EdehDM0jeToAnJMfZ+F2E1?=
 =?us-ascii?Q?QMu37z+uEv0RisBh9OVbMi53CoHse9Puo8G4Gs/Tkwy9humpc2UKqc9zQCvb?=
 =?us-ascii?Q?UdWgMd2nPACfyx+hbflFFU/os/74YAieOo232OZWVPNmLxQav9dj3GXi371W?=
 =?us-ascii?Q?TRXmSAklU1HPTHJJ1bgq7jzKrx770NYI+WsCQvA8fqMV1mEgVKmtdqai8Rin?=
 =?us-ascii?Q?hJdPem6zk0jGPVTN3ipXI8H/wedsq19GXXRNp3JNpT8g9D3Qx/13ZrrK+1M4?=
 =?us-ascii?Q?OXB7sBv6PXM5KK9O+qSWsCRKyt7gmuJm8Mwss+VfhI7MCBCqx3gBxcRtCqDT?=
 =?us-ascii?Q?EcjonwUa6Dw70Po4armSIR5mLhic?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r+EYtmR9dxE0kFnQMPvOvDFJvounHKurG4iOzsOZKEyTK2tTsaW9s24itVTU?=
 =?us-ascii?Q?NG9McaB++DG750xVsSaGeLCUjPtNLIS6TIaqIyQ6/d8Rz/3+mUThBi9qq+gH?=
 =?us-ascii?Q?/0ey1wmzgPryrQ10l8mBxQjoCCSZokmPKDkeqXQB02xDebj3sESRboTrl+8G?=
 =?us-ascii?Q?fRi3mT9BD7JQWiOYXPaGdqB8jYcK2GzwacFFXT2wAGF32AcWfYf2CfXmdsFC?=
 =?us-ascii?Q?VBr00ZsGe8zWcB3t9Q5bye1CtTzi2AFo98X2a60bViUrmjhBlThA2cDZfYOz?=
 =?us-ascii?Q?hQ5HElCYmsKiatlP3APKLY+OZkJ8hHezDmDhErfwoKqcsqVxigrrXeHGorJf?=
 =?us-ascii?Q?R2AwOrOIkGx1CK58MlUj8ednS3rZQtYxtcMkwZUtbkky2RkJzIhwaDghrfHN?=
 =?us-ascii?Q?wfnkM7j4dt/S8P4FETMSIa3W+s6bIlTHD1ltaNOjSLUBvqtr43tbgHJuMegY?=
 =?us-ascii?Q?psFMzN8QhZhWJ/m6947H5GUhftLZQJnOMjq+0wYaeqNNh7Xtb7Qb5msS/Q63?=
 =?us-ascii?Q?NFpH50PThE/MruNqD15tfv9wGWWcD+P4SAnWbeLAkSjeubbXMXNq+DoRN3y/?=
 =?us-ascii?Q?Jjw3am9GONkg4jToH4npOhdSowhDYzQnXWAT+lQF6yoxTt0p99WDm5gnuiIr?=
 =?us-ascii?Q?ILbt5de57qO+1xjkZVjfVVJXDglKAubg9qikIiVOwPPVTNtU2zwvNdNR4hp1?=
 =?us-ascii?Q?DAYOsV9pkir7i4N3jdF9eWvfGQFkj+fTBQgGnlzEUkvGL6SZbcR+6HCgF8xb?=
 =?us-ascii?Q?jGD9dfs9M4vA3DWKj7Awh476sKg98O/Bh7mRXAF9nY5senVOB6DEqFSa7mDO?=
 =?us-ascii?Q?LqLDrs4OHLKED4FUyQ63wzUM1jTZ2GIpAkC3RKdpMJsgLYfzSpI/4llZzRkt?=
 =?us-ascii?Q?zfk8Edt/ZzRv8VgRI2zDbruYTrwizFro7zeWPxst5LUcdp3VFwIrBoXcpmHD?=
 =?us-ascii?Q?zk8lvggWoydh6VlGIVoVEK1El2pa0eHVWy6yHKVSe0tPDPbQ1e0Td0IdWQCX?=
 =?us-ascii?Q?KHizG9CZZ5EAAXoyL8fSfSHox2DFNgcTFIpI6XDLrXwuJlvxz/QvnbNiiyb/?=
 =?us-ascii?Q?PdJMKC3+EOmQeHgbWUruxs8SMeEiHCTFdYVzU59pb9FetxJ9jZGOyTgcQZWK?=
 =?us-ascii?Q?ezcdB5tOOmNqidoOak35Xus5GamwjFRcJX+ACJZ1mP72GrplK4ce+spTIswW?=
 =?us-ascii?Q?imcmumi+0LDbJo186Ts91BwdJEkQVmWGK2KPduBtqBCP7p9FgycC+pdiR342?=
 =?us-ascii?Q?NQwucExy16wHtRbAwiYhagyg+AIOMU/yZoT8Nqp2s0Flv9agXMdYlTSTBEwn?=
 =?us-ascii?Q?JUU3fhsQBoflhnKQumVDUBhzfgxSPcH9KHc6OGIIQrnAwrqHHAq6blFrkRB2?=
 =?us-ascii?Q?8zyqIjnKmowSIkRgHXyPYJcs0WWxw7Wm+qKaRr860B3h6ZpP+j+mPJyTRGYY?=
 =?us-ascii?Q?/zP82j8QLr2vXPuKj4lm1BfK0ywwB0+7LDaWnJ8fhM2i7s94spdcoD72D1Nr?=
 =?us-ascii?Q?nm8Pcvh//0rS59II+yi3kRa7MCTkKTzxDwedvFcFfLXjRO/1kf6GsGq0i+MB?=
 =?us-ascii?Q?0XX4wT6z+n4OIuAh9ExDwLoo6v7l4GeJsz1Uj29X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5b0727-8d6e-461a-b25c-08dd67a74544
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 12:03:47.6995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A//xL3CoILuCdHB6N8CWznYlQTYPx8TOYXOgGZbYH1lx4ooQO/XR8nxzdziHi1qKeWev8qB0gTnKRKNyLs3V0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6929

The blamed commit converted the fsl,qoriq-mc.txt into fsl,qoriq-mc.yaml
but forgot to also update the MAINTAINERS file to reference the new
filename.

Fix this by using the corrent filename - fsl,qoriq-mc.yaml.

Fixes: bfb921b2a9d5 ("dt-bindings: misc: fsl,qoriq-mc: convert to yaml format")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
Changes in v2:
- none

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 95cf8b1a40d5..012a3fbf884c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19642,7 +19642,7 @@ M:	Ioana Ciornei <ioana.ciornei@nxp.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/stable/sysfs-bus-fsl-mc
-F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
+F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
 F:	Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
 F:	drivers/bus/fsl-mc/
 F:	include/uapi/linux/fsl_mc.h
-- 
2.34.1


