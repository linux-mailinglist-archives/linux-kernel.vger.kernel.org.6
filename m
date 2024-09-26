Return-Path: <linux-kernel+bounces-340952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A1D98796E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4CA1F23D11
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906AF17ADFF;
	Thu, 26 Sep 2024 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="aC9QYRim"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2129.outbound.protection.outlook.com [40.107.93.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C14813777E;
	Thu, 26 Sep 2024 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727376547; cv=fail; b=VGt+1tUb//3wd1kooDSzalHY/K6GZoZzpAfO970Z82i1rjU5Hxcd6O9jHjmvw9xku8Oyhw8mmErDTX30bX6z/061TU4Qg5mOIgzyEhym1DE8uN5AKlUQ+EuqQ4tRE+T6lnYeO/b3ZlGYCxzEqJ8iHbzdeIEXuXaiMhDs6eWmN4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727376547; c=relaxed/simple;
	bh=TYzUlhMp9mye/X5+Gwa2EFlxTh8Jz+EGAbjRaAE0UCI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CBT7E48ojXAMq28hFSAZrT8uPv7SEd1JOfnuzCZypyJqaEAB6Rq4DPN0B4Szr2Oj+TQnVQBu4w/Z0q1l8jud2w7VHxavSLf83qvLcwelS/2Nd3X26Q8QY6CwlSHRB3tBKH2rBeBmBD9hkqr/C7Dt5BANsC+eLjP7ooewNfZUBM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=aC9QYRim; arc=fail smtp.client-ip=40.107.93.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nt1cBMVnrW6dazfBnH5k7wjLIXe17fb2zVM2w1g64ZiirXefJVBQ/d8uH3nynYp/+Xlu7dVWi7BIOEYWmV5EHE3UEeICoRiDdiAJC3AL6KKcOpV8sJKAzL+BPR7K0RrruIYwoV13vO5JRdT70GUrd0QTU0CG0dnMl/KlV6vRlvf5hVN7UW87DL1EQgSyniksmdNOtfCIb3bm2343PQEYVxilUMIOd+bEiS/M2TsdoI3FqY00t/XRRIubCvnVd+QxtucUuRFGp2Xmv0P6BeXcWWwoO4R8ezjbEHbVcY7gwupt8awdiJxf7TJ8qs8fiaxRwcRG0G8k3yuJSFjbrEI5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7piVqC2MwncWVeKqTMk2aL75Iupw9QMb5ISVwCN8sIw=;
 b=t4OOOBrPX3Wzkk63GQaDBuH0WuaMBueuV03+dd2c4beC/2LpGpy+PSahxaKkdEOZver1BbJpfGCmSaBUUfwAJ2K4uXFio2FFqtphh7UgKFA+Eiam3sYw0JH/kwgeGRs6kgYP2ybEhPbI8I7iYxJXw0aKCveFqZB86tbCH9ONa+/cHhQeXe8UbwzuXfg4E07NVopIppvTybwCZZTlHaM6p9lr/a7ohvtMG0ikZxkyHdSGQugxgM19QGcK6EGPHFIXfSExUgXkevAoUYhULJyGJro7bkRODcX+NvLR93y7yT2RuRO9gT4GJtP3NyWmTA4kRYR0LdkGRoYq2wtmVQQDWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7piVqC2MwncWVeKqTMk2aL75Iupw9QMb5ISVwCN8sIw=;
 b=aC9QYRim4RBPkM5v1mkxe+P0ASQrAUbTI4OM3JvNBly2D1xESUc/bhajw7VkZjabXJxmBLPob7mBEeDeCjVCp1wnUzb84g5au46053E5YkXK76/y9YzuBJJCTLoOebv6C4FUrppZ4w1HYSVzXEiUK2d/nx2mOc5AbRHMqFhjXog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from CH3PR22MB4407.namprd22.prod.outlook.com (2603:10b6:610:167::14)
 by SA1PR22MB5036.namprd22.prod.outlook.com (2603:10b6:806:3d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 18:49:04 +0000
Received: from CH3PR22MB4407.namprd22.prod.outlook.com
 ([fe80::a87a:b781:ffdd:3256]) by CH3PR22MB4407.namprd22.prod.outlook.com
 ([fe80::a87a:b781:ffdd:3256%6]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 18:49:04 +0000
From: John Ma <jma@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	d.schultz@phytec.de,
	w.egorov@phytec.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	John Ma <jma@phytec.com>
Subject: [PATCH] arm64: dts: ti: k3-am62x-phyboard-lyra: Fix indentation in audio-card
Date: Thu, 26 Sep 2024 11:48:49 -0700
Message-Id: <20240926184849.3341986-1-jma@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:303:b8::16) To CH3PR22MB4407.namprd22.prod.outlook.com
 (2603:10b6:610:167::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR22MB4407:EE_|SA1PR22MB5036:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef78c47-a758-4854-cccc-08dcde5be4a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?81KFqI0M3fubWtHtGIm+UG4jcXie6ZPW98OsQ3lEk6ZQ49bvKEbLMi1vvCsU?=
 =?us-ascii?Q?5dMYBQ+EtZLuD3qQKAXd/JCnviCyydP/qyjiB9LBFIc/IdrOjRjLMYzbs9GM?=
 =?us-ascii?Q?Ug7MQcNVlz3MmQlixwOX1bvexxmCkYgrhzThWXbDtuj7i0uAG5PAb4W8k1EU?=
 =?us-ascii?Q?iLlwtx8nWZu8OMjI/5r6GhtIo1DArAp6nTeDGq9RDKPUVgpVo8beNYBKAiOX?=
 =?us-ascii?Q?lSYK5xH+xUqqIcU9I5GLyHRCtTbjpL7R0RMDu6OlY8plzxl8Abjq8RNdvdIu?=
 =?us-ascii?Q?U/yhT0ds79njXG1i9UZBt6+R5DBpqdRm2NO3+0lWrp5RuN14hfHlgitb3Nws?=
 =?us-ascii?Q?rNOUTYY2/ZNe6fR73M+Fy0ZHmFmtlhQS9pOBSZD909TKw5RZTnKAjJHHJnR+?=
 =?us-ascii?Q?KHo+2BGzDWJ8R8V4+FFth10GDu0io4yBR3XevrBEs7oJeyKJ42TWE1EpKNKB?=
 =?us-ascii?Q?5SYPd3y2Qml+wkKQZVi1p8BsHwabQlJWHfLsMpnsa44Cmg41/njCCBakHZu9?=
 =?us-ascii?Q?Ja840tX9h2MVhnpY05iW0YaIw45CEH/30Pvq4od2LX4tZta6WsjHOvHnRnHY?=
 =?us-ascii?Q?akrXDMHgnC0KHigXiwbkWZa1FTKxq9ByddnXms6hX4impf2PfmJUVWb1nDeh?=
 =?us-ascii?Q?6uK2AgnPdzTMQJ5MrlLuVY3ofiEVB5PfWKOphxXJIIvqx+Tww3Lt43T7okt6?=
 =?us-ascii?Q?W3dSwPMepEklimcRrv+c716DINQVxUS6im8qQh9C7VqlcSoMGpBnVsdzTBcf?=
 =?us-ascii?Q?JPD/tz9KiPTUVOVgN+zWrst+mxRbvEO32uYUcFQgpDETq8yg3x4+SC46iOTX?=
 =?us-ascii?Q?r5ZEJbZo+aQhvJ5IBLr80dJCBvv/FBs2jwa78phcIwtqc8TODZNY6WzukXR0?=
 =?us-ascii?Q?bpb+GnyGjZSaS+I420bNa7PHZYufBqhGDliZfHS1Qa5aBb+KIAMkqmHKVRRr?=
 =?us-ascii?Q?nTXGpvbZe4dQG8qpr/BvGdYCkHw4aRUH0NRbUPk3ReRnrDjyPEh1dtW9CfYe?=
 =?us-ascii?Q?r8xxQPjjRGTqb8V5bARL8fD+zyhHVcHR78z6nFXCCWfe9pSTOEgD+0jdz8da?=
 =?us-ascii?Q?XsuAvXoyHXctC3gLwF28/k48iV+so02zUMniA2ZQJjkma1GT09zpeY//eFXQ?=
 =?us-ascii?Q?/Ry7u2RY0XH5oYAYnntZ2vmU2lehtVdgP02msc0WA0hpPpfsgkNtfWlzxT4n?=
 =?us-ascii?Q?LmaPg4UDVUolhhZu2IsV583fyjb7g+r7IS2xvjmC+HO1+Dlm7nc15DRhN3n1?=
 =?us-ascii?Q?Jtz2XFXBJgMv60vQLQ6RKVldFv+39iEf9OnEliJvVg7lHimydtzqL+9ux3FX?=
 =?us-ascii?Q?0kMRIkgKup9M6dJ2DPggYq73NL44zpyHQqLQTsVR9VB4gA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR22MB4407.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4dA4783YWwANrxIz8prkQz7HGxgkrHcC8WYS8j8N4dLxZ9Y1WjwKtgHkDBV7?=
 =?us-ascii?Q?62qQjrQTVLmKf4QXQamsT8q3tYKchOsU8OipPNiylGA6/znyZPYTnQ2015hC?=
 =?us-ascii?Q?Fl1OmUZ+/e9bYQrdAaESs1O01c2RuctElFefEX5ZF2bkgOLVjOoZW/xh9Pp7?=
 =?us-ascii?Q?GsofhlPJNFFcnkOSN/xyDtKzngIzTdOPTQjwRqK2TqUky9PbbwG0XbaRuamI?=
 =?us-ascii?Q?DrErurVyRrjYdIWj6r++1OR8UFE2cnTFo70jN2E2sxz7WDqE9Qgo7ns+PkcI?=
 =?us-ascii?Q?B6W+q+0nzzIHu+jMf/DiVk4amIUZyhOEEwCCdFlsKvlJDsz4jqSjJdT2Bx46?=
 =?us-ascii?Q?R8i53VEeI8uYE5V4ew2xzEYQBFIlX4u4WO81E4/RDg0d4bXWWYxbSjUsv49P?=
 =?us-ascii?Q?xaWicLiWu3//KzXzPtaN1cd7+M6ox6gK8vnJxKbHLNq+B7qAgh8dKRlo22/L?=
 =?us-ascii?Q?iK0kNW2cWmNFnXk6udh8s98m8KsJjUFPx4SN6SnM6cdmqvViwrytIHsM2XO4?=
 =?us-ascii?Q?YdZqKDgZVhQQORp/dClVkD/EIzauO0HYU63wRlIxN8na439lcuya0D0pcku8?=
 =?us-ascii?Q?y8ua3Xk4+OWXuyKdKlqbdNtXSIS36dT9aw73Dhr7zqGMfLG+ypEp7PdDvG80?=
 =?us-ascii?Q?icE256zrpWpjmkO9PJCmvMwLqzyHKQQXhrqG9jy3EexFFarDo93teHtCKKgB?=
 =?us-ascii?Q?Z0cqF2itzlh4ozwykO8S4MUn4Fbq8eUGRICzdMWkC9705cPtQIReQTHARyaR?=
 =?us-ascii?Q?RccBK0kdvrwi//m9GslXmsN5B2r1mnoebFMmtNDxMk2bxDX2yFTPAEiBxRNL?=
 =?us-ascii?Q?AGa+JEt/2SxMgHkAm2Qu1cm/OkXwIz3yvUnLXQi26YayT+eB2gkx+WOcahHD?=
 =?us-ascii?Q?MfTTCeqf84Acnm5DRLvQKb9af7lX0S0Z6+tD5p/r+/SBK1xIhfywaMJT/gA4?=
 =?us-ascii?Q?Kc4tlewu8btOpPsOTAeYuoo1EegoOKlTQHPtOS5tqfZBW5TuSDBS3QK9NNfT?=
 =?us-ascii?Q?2toOXyLiXQKSBjwY+YNCDOH3FRqcj+cxJOkk+lzIBXSGU6ncHwrbwo40SDre?=
 =?us-ascii?Q?plFYMI4yUWiFL+EPMYBUkZfO6F8k+hUUgg8Px41Kt1LrZRoESa6qdLbTlkrR?=
 =?us-ascii?Q?/JwxgPwR/bDR03V2+kC3TbH8R9OJyc1OPeTMlDT4FYKkPCe5/SYlW9Vzfx1H?=
 =?us-ascii?Q?5lCplr/JOerijscM4TTO+40rJF7VtK86DUghis4otU9HlG+6NmeLRUqqv1TX?=
 =?us-ascii?Q?SxjRmaE98z7zKTvl/7dLCw3O+7VW+NpwysJ5f/KBUfrMN8LU2SCg/eDYraN+?=
 =?us-ascii?Q?0Ohzz6Gpmj/vHCuPBiqMlLcQ9An4jB0iQQl2e7MPXTIk7P0O3tfwU548vrqG?=
 =?us-ascii?Q?ZMPWrlJjEG3uwP6cY9RwkonHPx91ukX7vcKO6TE88R6GDzKfLcXr541m5Dfx?=
 =?us-ascii?Q?1fy/ekvgH3l70rfz2GLLALNg9pRpbaWelF8KUlx4hcmlh/Y5P6qQNogyBKk0?=
 =?us-ascii?Q?Pu3z884dxKS/Z/HsMcVf62v/WI6Yg+NVpwE+x/KplqEF3MU5LaRxe8nD6zfj?=
 =?us-ascii?Q?hKMw/heRUrqey7ISZDE=3D?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef78c47-a758-4854-cccc-08dcde5be4a3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR22MB4407.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 18:49:04.0794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKn1GSuXWNtHBYCum/wRDlG8G9Lsl5mLeeN2F/QA/yENSXGH/XJo5FwNi+HTUzyM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR22MB5036

Corrected the indentation for the audio card node in the phyBOARD-Lyra.

Signed-off-by: John Ma <jma@phytec.com>
---
 arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
index e4633af87eb9..0b434dcfe256 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
@@ -82,8 +82,8 @@ simple-audio-card,cpu {
 		};
 
 		sound_master: simple-audio-card,codec {
-				sound-dai = <&audio_codec>;
-				clocks = <&audio_refclk1>;
+			sound-dai = <&audio_codec>;
+			clocks = <&audio_refclk1>;
 		};
 	};
 
-- 
2.25.1


