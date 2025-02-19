Return-Path: <linux-kernel+bounces-522305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AFCA3C87B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D6C1788B1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86AA22F384;
	Wed, 19 Feb 2025 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WAFZ7+RF"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012054.outbound.protection.outlook.com [52.101.66.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B822DFB2;
	Wed, 19 Feb 2025 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739992900; cv=fail; b=IGin0zFWrO9yBBWCSzase1WSb8bCy/84v06smylWj1DVt3SdSDRMRarCpbE32KDS1Ru93gvQRSQD/R6Kb2fYasfcT2fQHbsAiGNrq6NodUOc+hKsQpL6v5ph+dRQQIUV7YDJSqBFDh0XsFEHahkX8Hzb2TkyfUfyKVsHduTPf70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739992900; c=relaxed/simple;
	bh=m1VVOVKeRItaxA5fNLK5UXrzWZ4SaiV9AR/4Rwiodwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y6JHlNqBWwblfrsHvicK9EIpus58gcaAVg4BhArMJ251IqKDUPedHkyXUgO87WO/BnZoIT+As9yGZZlp4u5oxvRPK/K4YIGullPIR46B60S99K1RmAFSxtmSnpIjKfLrt8ba0oiI52kN4JRiOx5zLNkdHfJefOK+IKrc9c96TiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WAFZ7+RF; arc=fail smtp.client-ip=52.101.66.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLBLQNL3H91+BGZztK+FviTFuVr/U0GbkLTWhwhzOzM5r+W9Zx1eyoXYbD4wS8Ya11mcQJ6uR5z3lZiIgHsuXEeRlze3mbY8AN/7Oj0GUbB9bYgBcqjWr770gtmv32NNqMrmHmCQA3TfOie7KOoVUjtP6fFg9ejVIwAKBh80LEXRGrYoeQqBKNGEC4p/owMuGRGufIQ3pdwdeVfndijuZpF/o4mGy8Osdw4x6+GO9abz9c3Hss8bqCuI97kqX6l7ZeejVhJEfAVxF4fzLmau7QKqAEKNvVUEShZU61P13gTBghNlbua7zqmvkSnDlqLQ4XEdsmo53vzsVnsXI3AlNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2AVZXEuoLFoLGLvyFPIGTa0ZVxfDZHoBCFKBTu6p30=;
 b=h5v4OPa8uvFLgvQMKO7kybdhukJ2lpEZxDABLygDDcBMZZxL9PyuXxwuRoVt2x15BGhcMHyN4ZxnlYj+lXbInd1fph/Z8P+IWBNOZTHE0S++5w8EuorNBcwnZ1odVc3UBB1/FtUj28Nt2EnurbLAG7G27B/yiinP6nlznyMVONzC8N7HYKswtXiHLsnTaUDrr4hCCu428LYNDkxlySDdBfflIpaFnop3vVVOHIs4G8nYkFOlepXvAmMTfNXFXewpNQrZw1+AwRbQSRSkydUeX5Ruxa6pYgfJUsxzccwdqqQ5iF3VGt3xFGgzaghBqd5ydCQIQ5XVbBzVmcbK2chkHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2AVZXEuoLFoLGLvyFPIGTa0ZVxfDZHoBCFKBTu6p30=;
 b=WAFZ7+RF0rVGj95FrbqrdZWk7i17AVWJ/FpDGGC1UQ6T6bwYdwxXu5tHTcHSEMZD8uWt3DvHKW5+CIORizjRqPXw3msitGAkUS1Sa4YIhjPJXj7EjivUaoDmncFoxj0o9UTdVQ4m6Cn4MBvow5vEnqTYunaa3zieMz/Nrwmu0zyu0X3+Pjd0oIi2Xyqi2HzSIbm1DpeFYQHSRo+/KpAOKYlTzJp/QytA2QkcGCu7SUZD8gLtlK1vanWewjZINH/iW1UvsHOiHhgltc2LEdlu7QmGTjL5aG1VVgDZAK1WdALRGTEKGBvVy2GPgWAw9r8gWP6jXS1vwgiXAzkM+10g0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by VI0PR04MB10951.eurprd04.prod.outlook.com (2603:10a6:800:25c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 19:21:31 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 19:21:31 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: p.zabel@pengutronix.de,
	robh@kernel.org,
	shawnguo@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	mathieu.poirier@linaro.org,
	shengjiu.wang@nxp.com,
	Frank.Li@nxp.com,
	peng.fan@nxp.com,
	laurentiu.mihalcea@nxp.com,
	iuliana.prodan@nxp.com,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 7/8] reset: imx8mp-audiomix: Add support for DSP run/stall
Date: Wed, 19 Feb 2025 21:21:01 +0200
Message-Id: <20250219192102.423850-8-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250219192102.423850-1-daniel.baluta@nxp.com>
References: <20250219192102.423850-1-daniel.baluta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0267.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::34) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|VI0PR04MB10951:EE_
X-MS-Office365-Filtering-Correlation-Id: 84aa2202-abc2-426d-f657-08dd511a9d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6q2rdVt0MvZePYvKq5o50CytrCWLnM0G2f3Y2VUfBJdwcsezBWA1+lcaN+Zu?=
 =?us-ascii?Q?I96vvu7pJ0i1Pzsh2T3fLq5IpPKypSpHJBbDrEZilRV2+92AgKvxPWqdeY9W?=
 =?us-ascii?Q?05Qtect9aYGM2xpNxWl4KnDcgNx1n5TVkBVTwUbyg9zEDk2SoxlopIVfsH7T?=
 =?us-ascii?Q?RqjFVG93GWMFCm+rxzntV/FsKLQoUhv/ti2fVNCwgmCjllGp56kU2ihXlbFp?=
 =?us-ascii?Q?mumk28bvxzGbqx/ok2kR5Esxv8cOVDuY+ZSnSlNMA6/nAOmrcKIzQZDG6Q/f?=
 =?us-ascii?Q?j2kiG5LigSclX6ZoKRWwoZgNCyAMYFwfygtQ8YztCTdmIjJtf4AqN1KA6jB9?=
 =?us-ascii?Q?DAm7ynI+cflq6ndcNPDvq/0VvmkujC+mtoFrEy/Q2682I9boUzm7z8MZ0zLj?=
 =?us-ascii?Q?3uKmlEgcPtA1NWDH46Dy9iDN7aKW8eXTVMr6bPYPoYjZI8EwSonIt6Th4yJT?=
 =?us-ascii?Q?P8KI0c8qS2k31BDqZKOwDIwOjIiDRMeW/XcCliap1srAUuMCUJbarEulbU0A?=
 =?us-ascii?Q?YNQZovQpyPdhB8F6evxmLTQngbCw7LOASZz5lPvlRuBbjhKjjWTHx088VEfx?=
 =?us-ascii?Q?2oIocHGswEoI7PQVXKbQzlYWpgM2z5JwEJtvCVhnt7hK5SCex4HoiVCG7nZh?=
 =?us-ascii?Q?FadC0wE+K048VM7TD6x6wsC3/MSGKcFPo8T0CWSumjzk0YA704t8U6dnhhmu?=
 =?us-ascii?Q?tbIMsVm6Kf6x3jrRA5Ak4SXWQqt+C++O1vCkZ1LEe1326ZVQ6BROIhTlOAxX?=
 =?us-ascii?Q?8YPXIfK2wsx4gQHBU6+YaITNwWlwWyRDZMU5ND8cO3lDltjDISUa3R+hq1bu?=
 =?us-ascii?Q?ZsRCCTyWHLHVHdtUxc6h/QfRU0TuTH6pjG511AOiarOwhoQuLL98I3WM6KGi?=
 =?us-ascii?Q?gjmfngnvKxNK3p4L1fZf2fX49XkGqoVshaI9DYoKGBrrJRfHtM8pEdLiovPE?=
 =?us-ascii?Q?ZY3Iu2TBDKqe0fjAVFmH+AHXuI1TuK+AUeM11BO6razXIyFXN+Txmbls3Ig1?=
 =?us-ascii?Q?B6C4MWTojLJNvq6B4KyUfxT4bCYrwg8wIC0SMCLw6fRN5YElfaIY1jjE6H1y?=
 =?us-ascii?Q?KyTFHIiQ2DhL11ogWQetVgAs0H26NsU+OtDyue5Ucc3EWla2klE7SE5e0e2i?=
 =?us-ascii?Q?oIbNuLa/HVzM364XYfDDt51qLxHLUghqpX7mE2ZbOvNlKCOsTbN1d/2/q0F6?=
 =?us-ascii?Q?Gnrsn08SWgUgwhFe8nYu6mwi0znOmfC0qvRrtJRo2BKokdSZ37fNq1us5AJy?=
 =?us-ascii?Q?J524wPg17o68tZ9J7c/su6mkn/cIbuTq/6yZ9xQP71f7ON6yUsqgTp3jkznO?=
 =?us-ascii?Q?ZmUE3j3Ozwjn1RoyrRTBallUJCscvrxxMikAqSR6JFv7arQLCE+wy6+UOGPI?=
 =?us-ascii?Q?58b1VVnAi8fB/sPOa2QbBVj5nWo7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9dXzkNW3chHl4HxpW9XgFxK7N7NX5exWRzUbD4KmZO+ptrJ35Ltlit5gAG0N?=
 =?us-ascii?Q?a4mDEolLLW4f+S0jVl9RjDQ5E/xpVd/nmcFEML8S4Z0xREs8jhbpCpMOt2+8?=
 =?us-ascii?Q?Mi7Li558aV8fxfmnLCkC3XR1+/6xIsf+1Y8+YQXYmJpWBXpwrGQumjuxBsrj?=
 =?us-ascii?Q?kO0CwMTBUJwZGAaAkf+2w0axvXhkOhcNOIlPayXWth+J36zyV/Xw7majEAZo?=
 =?us-ascii?Q?nRUh5iuRf9/cbhrwOaEQQPFY20C95FN/lzGnWoVgVVsCf3AFM+5aRm3Nd4oR?=
 =?us-ascii?Q?K8f8FWvvXCCNYoA1n430IW+T26P6ZOZgdTCCa7dEbjr23264LiE0BQ4c7mvx?=
 =?us-ascii?Q?IvWxAZDM2l3TUOyH7ellePLr772+ZKg5Lvt/Cb6w60TjPcxF2+5Mc9j/0cNV?=
 =?us-ascii?Q?gMllzNf2ihLbJfEk+YP5fnIkJCR3D4/4z76rmX+SDoI70VnkKsxCZsenaQBk?=
 =?us-ascii?Q?w/VRY/DLvD+o2HhtBZErK2YxIwWadGg0b4Rno56oU3h+B2iIY/j4nZ31rRaZ?=
 =?us-ascii?Q?Tl8yZB4D0SmYUDAZmXQZ4zMKFeU+Lyf4M4QlBkMtQCSkp7RNxxeS3V5EHOGq?=
 =?us-ascii?Q?+mphg9NXDjiyENBDvV5PfxTS2qrxGTUV/CnBAwT7H67KLfn/al4OrVul+tsr?=
 =?us-ascii?Q?oR7/b6o3c140yASr5VerRkgtLJKJ18fo2YzjvFsYMJb4Pz6YmoBjlgDq9+YT?=
 =?us-ascii?Q?LuPmtNgrIAHBNMnqqlc3nA8yQJ8j29f07aRL9dUuqDFMCsvCBo7SQClUyp1q?=
 =?us-ascii?Q?JIhIUgG4ONoYfO5D/By6PaXm82cHXYnlGtouaWh+0NxlAlOfGZEiQZSJ7Zf9?=
 =?us-ascii?Q?SIkA9rVO3BkIrvoUGzrVrpb/j50BxpXe5GxtG9AMTpQncf9Px3BwQbyxkZ+r?=
 =?us-ascii?Q?kfsyUpV3ub973duhrj3yXXNPd5LEstu2ZgCjS/A5iVoh/kjmfjvLrCjPsddc?=
 =?us-ascii?Q?iK48z+OsnjL64R438CWgtiIZ7BiyrnYm1LHQT/a4fuvtU9rKW5y9DoSypZUi?=
 =?us-ascii?Q?czYmWHvcVzTND7s6SPFd3NSMxL0mmtKVGKW1KfDvR53b+sR6Cct+gRgAaK3m?=
 =?us-ascii?Q?JGpeY03AJ3bNEEO85p5nhttcI2JNfQmHs0vwH7fq4QaE1hQI/4+X7p5Ldwyo?=
 =?us-ascii?Q?7awUnaYd0JDJyF7CQqs26Sl85kqiqrnepgF8FNRQWORDaG6FQ2gjeNsoVmle?=
 =?us-ascii?Q?z/tv6ex3iB1uS9U3JLI85yN50FmXgWM3MZ9PEXicWK01xMo8bqOcMF3mbO1I?=
 =?us-ascii?Q?gMMm86w7SGQqQhFRwkATFuc9//Iy0+1GhV0Qzx+ZVaNccI6tuwKYvetzxlrx?=
 =?us-ascii?Q?WHX7wnaVYS0ePxeCgAkjPVDfwJGyJqyRE9OZhe4WBzJUyG+cdJ+ViUTf+4xf?=
 =?us-ascii?Q?/G+TqNsytzZWCTLwf/5hjADLBjtG8ag8I3dAEh5vJCYhq5+AnG+zsTQDoVIl?=
 =?us-ascii?Q?ftQtfRpWPpL5X8hk82p2iMr+iPITGSi00eQytpNtdtqIjBieJpDRv//ftVbd?=
 =?us-ascii?Q?sK/0GTO/S17eFy/ulfG2mg/C8o7OH5r/qVWGQtu2x5UiHIjWQ+oYJZnxvAKT?=
 =?us-ascii?Q?QGJBSyiotqO8GnH2tu1wr7nELq2ufZRjW4n+ILk+5RQ4mzlxfgrK+68ZFwLC?=
 =?us-ascii?Q?sotbtSrsublEtKFdZd7MmB4MGa14ESgmy6EDyItejdAD5fmOHhF2P803de3C?=
 =?us-ascii?Q?lDhCgg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84aa2202-abc2-426d-f657-08dd511a9d87
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 19:21:31.2258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAV+6kSleHQ5x8+0VIC0tVWkFY85dAnYGErTUaiD81DNTuvYKJhCJcZomF3CbKmedCIKfuCCMd+lAbq4PR6z/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10951

We can Run/Stall the DSP via audio block control bits found in audiomix.
Implement this functionality using the reset controller and use assert
for Stall and deassert for Run.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/reset/reset-imx8mp-audiomix.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
index 42539cafbccc..4a713b772429 100644
--- a/drivers/reset/reset-imx8mp-audiomix.c
+++ b/drivers/reset/reset-imx8mp-audiomix.c
@@ -16,6 +16,9 @@
 #define IMX8MP_AUDIOMIX_EARC_RESET_MASK		BIT(1)
 #define IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK	BIT(2)
 
+#define IMX8MP_AUDIOMIX_DSP_OFFSET		0x108
+#define IMX8MP_AUDIOMIX_DSP_RUNSTALL_MASK	BIT(5)
+
 struct imx8mp_reset_map {
 	unsigned int offset;
 	unsigned int mask;
@@ -33,6 +36,11 @@ static const struct imx8mp_reset_map reset_map[] = {
 		.mask	= IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK,
 		.active_low = true,
 	},
+	[IMX8MP_AUDIOMIX_DSP] = {
+		.offset	= IMX8MP_AUDIOMIX_DSP_OFFSET,
+		.mask	= IMX8MP_AUDIOMIX_DSP_RUNSTALL_MASK,
+		.active_low = false,
+	},
 };
 
 struct imx8mp_audiomix_reset {
-- 
2.25.1


