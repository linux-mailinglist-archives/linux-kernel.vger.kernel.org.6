Return-Path: <linux-kernel+bounces-521603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B14ABA3BFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D3D1884350
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3690E1EB184;
	Wed, 19 Feb 2025 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jLvmzwvt"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6112D1E51F5;
	Wed, 19 Feb 2025 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971507; cv=fail; b=C2rmXnha+Gu/RcFJBgDQFXxcegv6mSAnwyOKe0zkIdiDXFuOZfQPh9U6rJp10y8EaCM5GhnWWRkXdI4mF1322BRfI2G3YXXao9P1vZj+WTy2i80uzVGUhp9iKxw60NgITlbG8FHrCwkeULBjI0cD+1bpgro50ShQIBvkNUcPoeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971507; c=relaxed/simple;
	bh=FixFbnFnis7l76VW9Yl898yCMOByQgcUi+KAYUSu0Yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=agr833O/l+bEqkmUIF1vbrgsZ669PMx5CcTZfau75QHYJLVOAPGQTyUl+j93CeYZnk+JkM5COxD2ipOBhKS2q1DXKLREMk+Z56mhIAxNtpPHaYgteOXs/dJlKyfCldJ5AtoQ3Y4YfyeyJt5Cv6/6H9Aqv7t1fq88XRu/6VQC/pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jLvmzwvt; arc=fail smtp.client-ip=40.107.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVUUsBFq6yBH1RBZIRXJ6LTUfbPisr2sIXv7lQ7LM06JxG1Z/rPY/lxCqoRddAMsezFGYv0nT3RS3/ab0T5Bx9MRv0airy7mBwqLnGN4oH3nm0BgAfjVVY/eCDJQWoNS+QODtrALFQgpl7rN5H7i058Of1GNpTZkJM58esDqf88it368bwDYY3HrnnRXa6dNStwsKo90xmDyc6P3YYQdZT/CNjCZi3863O8mbZGEHNuu0UtmXsjLhvP3EzSCOxSPneNXY3e16IzZ9+qW2K6T+OaYzgHOk0S2qeAGqTK3A5oKAeFvvanYysq3HAl4b0J9MDVi2CDLK9o7jo4THE6uPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WDXLLOwjHC61C1Q8rfgvTYE4L/eenzC0R33whNnZGM=;
 b=FC1DU/2FUxZG4i/gxMtoiBKKMNLUvjRlW/gbfPo7xApKin/CpFlasfExCFA8dnSl7ZayoG5h4PO9izZ80v6SgBwN6YSNhQ5EJfMZ4HyyxFS0TREvglU3V8+oH+Jgw3ozBHOqKS2AirtsvTwIsxDm0epgea9yAXELpISNxzbDWGRvfOUEqovxTU6yWTL+FuPQ8ni/jFY4Mgy+hZzyVY9eQ6iuNC0RA4YX9Vh7AebuHwC4Hgu37iUcOJFPi0OUJD+V0liO0P7emAI+6Z0FeXLAtG1XBoGR6DNfNgNwAMEIhbA9eQRNYvFMABwUtlfVivAweYd5HHKfGsqdiim6Kmrg+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WDXLLOwjHC61C1Q8rfgvTYE4L/eenzC0R33whNnZGM=;
 b=jLvmzwvtp77V46S3rqZ+5pNWXcnNnOrN0oRRzUqFAyMwc0sZ+Eg9QwR7KK21DFb0mdHG6EghObcoXz02KbPB2UI6UNG0BFAIddPLjv/YWlLQlDUptcZrkDJNt3NJVsiXzLGww7Z1n+DJG/eBGhDDEZG35kzRI4AHg4Hh/9eoKqsQCcxLK9ejF+0sAIflv+8Nyrb1wTR8ZH66TOkinDe8M5PaS0FGNCkNFCjl6Y1Xi8x1lAAs5xJGzv2KBG/yWWnGVHQz+oeYaDynrW8PfIZXwEfjSGOujvN1x5enx6ouZjQkcxfQ9pTQxOW4RS3+k1r1Cu0Nci0GQ/6yT/MXsDiWjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com (2603:10a6:10:5b3::14)
 by PA1PR04MB10841.eurprd04.prod.outlook.com (2603:10a6:102:487::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 19 Feb
 2025 13:25:02 +0000
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db]) by DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db%2]) with mapi id 15.20.8398.021; Wed, 19 Feb 2025
 13:25:02 +0000
From: florin.leotescu@oss.nxp.com
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Shych <michaelsh@nvidia.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viorel.suman@nxp.com,
	carlos.song@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Florin Leotescu <florin.leotescu@nxp.com>
Subject: [PATCH v2 1/3] hwmon: emc2305: Update cooling device registration to include device node
Date: Wed, 19 Feb 2025 15:32:19 +0200
Message-Id: <20250219133221.2641041-2-florin.leotescu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219133221.2641041-1-florin.leotescu@oss.nxp.com>
References: <20250219133221.2641041-1-florin.leotescu@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0042.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::19) To DU7PR04MB11163.eurprd04.prod.outlook.com
 (2603:10a6:10:5b3::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PR04MB11163:EE_|PA1PR04MB10841:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d0a07d-136e-4da4-d4e5-08dd50e8d0ec
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?/isW6UcFdUEqRzpUC3/cNuDXLw8HQ9I6CZBJyMSTCpBQDoxGCY2yYQGXE9?=
 =?iso-8859-1?Q?ECKqH8oUp2A9pK/5I+fXA22yZRX9OBqd5yOQu6A7m37dxBMCdrNErgCQ3g?=
 =?iso-8859-1?Q?E+yyROqkbh5OTBSka7lKPOu7rO3KzQ9lpf5M9BMR/vgzApveJM51FXtvZ1?=
 =?iso-8859-1?Q?ID6Z8fg+cQ5N/ctdOH+PsnRSD18M7TvSpA2bC5pHs9+dIJiK56yZiXtgqr?=
 =?iso-8859-1?Q?+r4HwMS/m9nB47o1qJQNz2840xggzZYsLDGeo1BzzYOYTHCdiE/XJdmUME?=
 =?iso-8859-1?Q?KzIs5Xh2aOkSbwZeQyimobINn4YzNIfLCOPan9l8Dgzcq7S+f5go6P8WWF?=
 =?iso-8859-1?Q?Hdn+lFvDposxcQCLlCHne2Lu1n8ZHazCdA8nkWVo9oMIjAnaLUg1vOTaag?=
 =?iso-8859-1?Q?fQlfT4MWrwrihsfbZHGOY2vgb0HFFFO7cv+Mp9fzM244j4GRmjNsKHohSe?=
 =?iso-8859-1?Q?hUWYoOpb1yVaOTOVW3adTu/RUq8718QNrNi+mU969cumrHVj96y/9Zk5Jg?=
 =?iso-8859-1?Q?g8VpRWwGNKNAYtquOmDuQ5xbcWHi/afGpXLlwr5Zn+4mh/Ysk1tLMKbS0y?=
 =?iso-8859-1?Q?H/4p0wX+m6hxPvkdrPy2+MEvpvUMar/EQoLOkSRoYHMBQghhzFJ7X3+q2R?=
 =?iso-8859-1?Q?xjtCjDjc5Qf8bNwYN4IYAAXVv/vOGUtcd6Ww96O0P6wwOj6ACIzNOZrpt9?=
 =?iso-8859-1?Q?QnRv2LOvrDMbk4aOM+Ki47C+2N17ce8cTLudOVU/GwqlzT2W4quXPRzV7b?=
 =?iso-8859-1?Q?e+Badt4UV16Bh0aNjrbYJ7QcrMS7FWZjrW5BakEBl0DPyjg/1uoUgGvgv3?=
 =?iso-8859-1?Q?0aT6WrrhkcYKxSbujGZrFAhHdHbkrHcdMusn/oiZKg+QNhlL9qPvj7JuMG?=
 =?iso-8859-1?Q?F3czWOYJgdoPkNZsPuodG/gD3GRk2Dpkinl+3fVKZz64G8+vxAkXnY40fO?=
 =?iso-8859-1?Q?K9yW/aTfSjTqcN+fHLIi/RXqyGNjjjE93EZqkB3rNtKyN9thZyqmSlGNnQ?=
 =?iso-8859-1?Q?xDfta8WwBP/vKU7nhGCQxsrNixVOKvM7oPfWTcRgT86lLZRHglSdtadOQE?=
 =?iso-8859-1?Q?hUxXEquYwawJ0r5bgD/c/dARH7+ITV43UAws3jCRQZVaqSIpuK7Nc3gYZR?=
 =?iso-8859-1?Q?yFrvGKlS5ioULjUoFTZij9PsrDRnyAyZnpiZpqDl2vQr34/iyEmH1oGJUo?=
 =?iso-8859-1?Q?ZPwJxKelZ5/5Rmm2od7vTr8Rhxbb0NS7o4IIeXUy96gHk6r2c4e98QabWl?=
 =?iso-8859-1?Q?2SfKiTgeOuyI5QyVgt6qlpUUrtB+nJiOTqVL5xlxRUNiehjDn2FNI2tiGS?=
 =?iso-8859-1?Q?N/mxrfi95U28xeAsGDs9r+m5/sU8IYO8WSXxpRCWu+KuwGg1edDi7raHch?=
 =?iso-8859-1?Q?QIy4wX0BBJFYl3E955WumS4qZPyuOveoh6DFTmTKpUfjAVebiLrQZ3fJYH?=
 =?iso-8859-1?Q?hPEqh9TMKNL//tIi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR04MB11163.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?/fmIXYZFWMlM0FF43Vy+AybfvWiulKTUGv49HGzzgLPrxm9HFPjJmtt0qB?=
 =?iso-8859-1?Q?v6yRXZ7rM3tj3HpInoRCu7GL1Hvoku9w5AQUVhgekh8F7AHMrYGoPKxUaE?=
 =?iso-8859-1?Q?quz4wo7zQt4w8kif2JhKI4KywPmTD6+mdqk37FPz/JB/3RoKDg3Omled+E?=
 =?iso-8859-1?Q?v5g84yhZU2/xxz5LaUCYEGrn8aHDKKQTfNgIuCZE6cmLWKzx6AuSXaeTsA?=
 =?iso-8859-1?Q?nCFVqXRrWZbUeMNKEB8/puwY3W7xyS2i0fCk5da8c8JBRM8vU9xsgBeti9?=
 =?iso-8859-1?Q?MmQxgyPUu17ft2/p4jxM3R5BDJ6HBiRs10yfq2kMqMpEhJNc+yiCGxkwvE?=
 =?iso-8859-1?Q?Yp/OT/JaTGfmNx1yO3fg4mCHOdCpqBLhm4PmlCZfAP+gjwec4tpspCbliS?=
 =?iso-8859-1?Q?0OGZC8gJ+WtvC7t4T0OzmVG7HDWlGxJR9BnPAMXlTzsV9QXOd5CVCoilBW?=
 =?iso-8859-1?Q?J+jYt1YCfS/e3pFDGkEWGL5Se9gOCHpDYk23J0VuojWboiPhDvl14vdc9s?=
 =?iso-8859-1?Q?/WgEXxuw9V0TTqpIcGElpr13rA5tijSrGMDMas95/pqOHX2oGe4RBjjidf?=
 =?iso-8859-1?Q?4OSHn16VGtkX1p4OIKAkLpBmf+jLr9CaSCpWq/5lJYI1M5Obbm1Hf9GCkg?=
 =?iso-8859-1?Q?Mjye0N3Jbqw6vDkqnbG0DWR3UQnjCig0NJcRoN4INeKeHiTAaLquY/pD8z?=
 =?iso-8859-1?Q?FFzr6crd8wWzJA2lZGRAJCCX4E2nR9I66TdSCpSJ4tNPFmZGVq3JXIKVPj?=
 =?iso-8859-1?Q?4oEus+4u0ZQ4tZ0YH6DxpeNN9nTzqTakDdsSy8IY+iF+d38Uoib4pAy6mY?=
 =?iso-8859-1?Q?Pj1S8gmFZa2CGu1QV3ImYJ5GHwWdL8adWFFXEvWfXReeWMffNgtUZsbu8R?=
 =?iso-8859-1?Q?+il0iKX1/G3EZJfcKQAx2Qt12Qz+An663dM39pjmaMMwX6SGgxn2Pa0ExN?=
 =?iso-8859-1?Q?2h1f8hUERey00hz2+PjeDVzY6qX6ZJZnKoV8VZhrLn7iBLW/Ob6CznBHMc?=
 =?iso-8859-1?Q?NcOAE5tCKSgdZr+OIowz8mIq2dxjhEBYagXrzGRk4/tPGKct+to8vmt/Yp?=
 =?iso-8859-1?Q?iYV0ooEn/V5ndKtUH220Z6hZs/bGGkNvHq1Z8aAeGUmdbY73xKELsWlLMp?=
 =?iso-8859-1?Q?LnXnfKMRcs5oOCm8/+P7gyZbfcB4rBvenI+dqH6Gbohh7bI28g/ZZoUtxJ?=
 =?iso-8859-1?Q?tMFdhDGYIpUfB3A23u4AYpbEnZvm+Wqmdnnrl8Ln2NkjbWPeubkA85Tr/O?=
 =?iso-8859-1?Q?u/i+cONbidQpjxPx/h5TD18Q9W17X3TCHZWgJRoCzPS/ttu6MFG4EdNzyu?=
 =?iso-8859-1?Q?fr/gWKCXud3fCYORg1cjKHv0T8CLtsMF9dkxdvG+JeveiuBEzc/sYk2IvO?=
 =?iso-8859-1?Q?KFzkEFXrDNFCfiTjX7d5cEa+GgQAShCdjpBxhHCViDkJMuuJtpc/wiVNFY?=
 =?iso-8859-1?Q?fzm/nI2FriavN1hH3lpp8YfYACleSJmDrlxLgavVEXZepH7BVSiUttummA?=
 =?iso-8859-1?Q?XxEwj36s5pP6G7hSuxvD5z8por4Jz+FPMGs94I/VU2e6dwUoUK6bq6yexE?=
 =?iso-8859-1?Q?UOymGL3aOfDs0xsSrUxmdxIJDq07FH8BS0yPWZYtkPhHUAkyb6b5D7gy4q?=
 =?iso-8859-1?Q?3HKwaE8YSSifGURaWVUvrQBHMSML9N/rLiwwdqZ5bAJDcEi4vlaZ2EHQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d0a07d-136e-4da4-d4e5-08dd50e8d0ec
X-MS-Exchange-CrossTenant-AuthSource: DU7PR04MB11163.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 13:25:02.5587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDHXwbGk3hwzGId139sIy/z60r8YXP+o9LL5Qv0ysNQOMuYOdNNnT5h0okhL8N2pLD4kOxXmVwSX/7quG16DdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10841

From: Florin Leotescu <florin.leotescu@nxp.com>

This patch updates the EMC2305 hwmon driver to register the thermal
cooling device with Device Tree (DTS) node. This change allows
cooling device to be configured based on the properties defined
in Device Tree. Use devm_thermal_of_cooling_device_register for
automatic resource management and to simplify resource management.

Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
---
 drivers/hwmon/emc2305.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
index 4d39fbd83769..5d8fb7526e23 100644
--- a/drivers/hwmon/emc2305.c
+++ b/drivers/hwmon/emc2305.c
@@ -112,8 +112,6 @@ static char *emc2305_fan_name[] = {
 	"emc2305_fan5",
 };
 
-static void emc2305_unset_tz(struct device *dev);
-
 static int emc2305_get_max_channel(const struct emc2305_data *data)
 {
 	return data->pwm_num;
@@ -293,8 +291,9 @@ static int emc2305_set_single_tz(struct device *dev, int idx)
 	pwm = data->pwm_min[cdev_idx];
 
 	data->cdev_data[cdev_idx].cdev =
-		thermal_cooling_device_register(emc2305_fan_name[idx], data,
-						&emc2305_cooling_ops);
+		devm_thermal_of_cooling_device_register(dev, dev->of_node,
+							emc2305_fan_name[idx], data,
+							&emc2305_cooling_ops);
 
 	if (IS_ERR(data->cdev_data[cdev_idx].cdev)) {
 		dev_err(dev, "Failed to register cooling device %s\n", emc2305_fan_name[idx]);
@@ -337,21 +336,9 @@ static int emc2305_set_tz(struct device *dev)
 	return 0;
 
 thermal_cooling_device_register_fail:
-	emc2305_unset_tz(dev);
 	return ret;
 }
 
-static void emc2305_unset_tz(struct device *dev)
-{
-	struct emc2305_data *data = dev_get_drvdata(dev);
-	int i;
-
-	/* Unregister cooling device. */
-	for (i = 0; i < EMC2305_PWM_MAX; i++)
-		if (data->cdev_data[i].cdev)
-			thermal_cooling_device_unregister(data->cdev_data[i].cdev);
-}
-
 static umode_t
 emc2305_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr, int channel)
 {
@@ -599,20 +586,11 @@ static int emc2305_probe(struct i2c_client *client)
 	return 0;
 }
 
-static void emc2305_remove(struct i2c_client *client)
-{
-	struct device *dev = &client->dev;
-
-	if (IS_REACHABLE(CONFIG_THERMAL))
-		emc2305_unset_tz(dev);
-}
-
 static struct i2c_driver emc2305_driver = {
 	.driver = {
 		.name = "emc2305",
 	},
 	.probe = emc2305_probe,
-	.remove	  = emc2305_remove,
 	.id_table = emc2305_ids,
 };
 
-- 
2.34.1


