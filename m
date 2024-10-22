Return-Path: <linux-kernel+bounces-375864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F06D9A9C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69891F22597
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E719156F24;
	Tue, 22 Oct 2024 08:08:12 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2138.outbound.protection.outlook.com [40.107.239.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2C51547EE;
	Tue, 22 Oct 2024 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729584492; cv=fail; b=YkzHBwlXMziKtfH6TYVNwgBkMAVnXdEJFBMOip1O7UtAssKwl9mhnLdud7NDL849xlakT8PaspO+kPT/o2HU+3qrxxR549+MK0dj9dy6QOjslo6f1ZHKYaZNma9+TM72qTDu6l3qj+8i87e/1Usd2JVlPlcVz3DYwylbOYAAheg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729584492; c=relaxed/simple;
	bh=2RjhCla6GxRf0cfuDHoXBU7H3h/FcRlNzUO/gRvrwdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=urV33HAcHIZwvD/QCVvFUMssioTEZj+HOvrnWgPzqKhXZ9yZGwsmCd+bpdwKJQUgm5zPQTc/EJnxFwYKPGoHVFvKQxmMJmC5qVm0tUNvReIiPfY/dnh6svPlFNk3crDYRE1VVN+kP+/I7lulsca4HqAR+pAMePOXp6+pG9Ry4sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjmM8D9GzJo4GBWGLvxBo61jH0Fj61EZ5pEE+5JtI8VaY+7VqNPMdclx4ohWkYesWCB/stzp2vAcK5ThZHPurgl51JN97ocxcAUNJUuAe+MC1p53jx158WcEB+KC2dELSYPRe0bfcW4dv5gh2aPcO2q6cD0C41kTXeTQmc2HyKaZhtnwEYNimV7arIskubU0s1GMgMEUk0cxFrEJCjeHjMnsy8zqX3yBdRgRpLD/25TChjzwpH/AzgaZqiYtVV0KEMVemPSwv7ePmvDfDYnNxj2hApGvP9hKyYFXvHJQS+haakhQvQpsyp6wR2JQiseSUy2nAX12oF9TXV5mfXrg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SizgIdNgryjdOlgkT7YRB2O9/7ON0hG/owpTs5VbQAE=;
 b=G8E5hvwezhxlr2zbqHWJqOEIdsl3ZDRTgTxB0XCUozE1wDnse2CSUIZgFIdoV9rCjuHzOlUK8nMdtDA3RoqaUE7cyKcuyguT0bCZhM5mhghNF/O52OWHjLe2Hwc9SDEQpSKFw7cj5DuxN+JAmCjq5gkP7bSb0o3/OCl6jYNSHRddvf2PltPSmR5EYyZ1cRgVf6c20MN4cJcFWJtm7/ZeVN9/EobadQkXtOGh8NA6eWzuADUZzxXWmxm1vHZcb0O93xEiWU++fuvHdEWkH0vMD/WRai4ygvcGNyDxAmivy6K7PuQz7ISd55YyoD0v/VzJdLiojZuZBMYrws7KFQKhcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a1::5)
 by PN2P287MB0824.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Tue, 22 Oct
 2024 08:08:07 +0000
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::12a8:c951:3e4b:5a8a]) by PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::12a8:c951:3e4b:5a8a%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 08:08:07 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: shawnguo@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Michael Walle <mwalle@kernel.org>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Tim Harvey <tharvey@gateworks.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: arm: fsl: Add Boundary Device Nitrogen8MP Universal SMARC Carrier Board
Date: Tue, 22 Oct 2024 13:36:13 +0530
Message-ID: <20241022080645.39536-2-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022080645.39536-1-bhavin.sharma@siliconsignals.io>
References: <20241022080645.39536-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0192.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::16) To PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:1a1::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1171:EE_|PN2P287MB0824:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b19f34-d54f-4f25-270e-08dcf270a973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lDtJaj+0nDpxIVCQSM+r8yG/d0/kjHeEqeY5QHqhu3X9FKwRqXuIJyeHIPjE?=
 =?us-ascii?Q?1YI2cphAg/j4iiXw1GW81BvXMnwjoNb25z0ir/WxJ5Ut3Ikwzbn4z1SM5J+U?=
 =?us-ascii?Q?lEdg+S4v1PrzYQSVX+jvHvDcJV5a8p1lzME72OEhD9MMsh4IBmwrZQ2gLzZ5?=
 =?us-ascii?Q?8DhrCE5cv1Gs8IiKxDuluV/qORXBfqW9iOxeWrFH+4CM8yh+H5R9535rdJCG?=
 =?us-ascii?Q?gso1lnFpqI0t3kt5NlsrtZ5Oy8tb7DtVf86XMYzlwK+60emHrEXsF3t6MbiQ?=
 =?us-ascii?Q?2WmUBGAj5G5WwL1zV8fQbDQSuKxfu8rtKN7NjWWV7+N0tV+yVYSmMkC1fa92?=
 =?us-ascii?Q?sgQ9p1pmWI/u8GwD39zP3v3tspckwkHAaG9ih/bZP24eD0NdNKQpuAZPraPU?=
 =?us-ascii?Q?au6yX3epkaNPaE1R0PSBv3Y2V3vkIuISgS+xsTqUtymqCa+mWS6C5fd72gic?=
 =?us-ascii?Q?66P37gpzimoiZCJcHBOjxrh63iqVZHFo2NrNqdXESp+lQRi6ThBQYFnIKF6w?=
 =?us-ascii?Q?2KTApnq2+wsam6pEDOWUJALlQFpplkKJNyn59SEndqYx9qxan1t4YBhWGXF5?=
 =?us-ascii?Q?PIE0KtLN/7ttpWU1UtGN3Yf+f5gq5hJgqMts/2AJoHnDxHilHXrU+iygOdse?=
 =?us-ascii?Q?V6Iysy1xqguuzIMchkpVODapgZp3MCd4Lg5IBHvIZHWo7Zq864nT0gHdiOr5?=
 =?us-ascii?Q?gK09r9cNMh6CQitCEonHLh0lZNzoISJ7Ijz1RSPduafz4fR5vYahcvi7tpRf?=
 =?us-ascii?Q?1NUry/VaMacwfMtVmQzK3KS8/rDWNScEYbqLbF+KljHbQ41gLNBUdrebAAuC?=
 =?us-ascii?Q?ylwOZSMTotGrvAIizuqb8Wf4tvTctqZ6NcqgiIWHVbv+QjCL+Hv/1IWtFete?=
 =?us-ascii?Q?ISoTV2iWBr1E/dx8OzAgIcR2NNlgUMCBk47aZiH9uTZTTJ8QqM2Ge11Vwij0?=
 =?us-ascii?Q?+Oq/kpwwjUDlCRuiO5pQjcrVKuPYr4sI0SG1VoM0byA55KcFwxPj8WBHymQC?=
 =?us-ascii?Q?eQzb0ugi/pFXY3Wc4iqkW1JLo3qh5MJKqS1iycoGoJYbV44RuYBq9Y9xZIyg?=
 =?us-ascii?Q?NV3BFENqSJxWWqlQBuaBvs0oPV4tAUJixrlYTSPIq1tike6VaZ2jyRlvZrzC?=
 =?us-ascii?Q?j0copiOErzQlMnz00ALRsbxX9w1SUgi5i+qkYji1Rsk9UZ3ldz6Wxeq5J8WW?=
 =?us-ascii?Q?/WhzvTAz8oBaqbCNL10AuiM8rYTyEwN8g3AjQUUj0lNGFKWYKq+cOdEHFHrV?=
 =?us-ascii?Q?EbDQR7NQMj/HHPASjwnp9hwTFaol2EjkFZiUwby/kgpsBIhYX0xAklglmCV0?=
 =?us-ascii?Q?xkb9pCP4SH5pb4pYmmqk4G6ZpY87RB807262p2WODYIlsBlrp5xav0x+TNAS?=
 =?us-ascii?Q?tspj+bo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1171.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fprTeP3hSeOjsB8qgz3nKpaUtceLvCLMfuiSv9zc6EQdNLPkLjr5RBx8Zjth?=
 =?us-ascii?Q?rBXR+CmSweP9MirJv+ki2/2HZD6QMSDUVvEKhjxKYYsJ27x3Zdk1eSSmcCF0?=
 =?us-ascii?Q?DKDJvxJD9XRaBhrcuCeeF765UTjhw/A6iuLmPGWgDBChC8geWhxrqkCC6a4K?=
 =?us-ascii?Q?Y8lvX8Qogavxm1vWj6wp9EAS/yaccvja+BPsZBJszCmEJZsPp1DVSArHOAt2?=
 =?us-ascii?Q?ewOYNoh2+sRGgrx/4JHrZj/DolTr0hPnHrKWORqQ0QhpyissM/ttAW6eDeRz?=
 =?us-ascii?Q?DSOzsRjr+wMPrgWg7Rx60Ov3IW++1alGFsKJex5zch6UB2C/9r7D0pBgxqHt?=
 =?us-ascii?Q?xeKD48DmS/braU5ibrEchHQaiO1SvBhzOz8z+0+Fxt4/wXf++sMeTJ5vQG8N?=
 =?us-ascii?Q?z+eYhVE5hbU6oiSj177DkFD5oau5p77Rjnx3ws2krnr4PSVRHuoBJrnH44Ua?=
 =?us-ascii?Q?Ovxwk7cN4AffR9FRTUYvtUfyGi/RIZMmdwk2StPS8VhsfAWjW+rwFxwyvEjT?=
 =?us-ascii?Q?8PzRacEPnZwglsRuuJstEaxJIc9fHxuv038geQ4RXjrctfuNzZnH6+3v9ZFT?=
 =?us-ascii?Q?yPb+fzSAHqtkpPNSP5t4hcoqBOW6IQVRgoLqlCufDOgx/GAUASCJ2L6Uxeu4?=
 =?us-ascii?Q?SoWLMESzHWc0AqLOsV+4/9IRFyngOrX+iaov860Bn60nAbNvov7GSdX1NWxQ?=
 =?us-ascii?Q?Rj8dXhscQD9fWmxFIMmCpmpPAgw8s/u11mDMoi2dxgIbY0PMKNEe/aac2Ytk?=
 =?us-ascii?Q?V292Qabom23SMKMIfnLUTV/e0BK3Sx2WqBib/OjxCiTZIMdJjD3mRRo929/u?=
 =?us-ascii?Q?rQoLGA2kwe4KAgTAG01PyjUQfD2HvQDNkCX+mlH60Ts8CpAXZ7U8VvMgn2Zw?=
 =?us-ascii?Q?/LSOFKNYGeufXvBiZKRik8cJZ46sbiOjrRViMUkZlMdppPR6p2Wvb826Liqt?=
 =?us-ascii?Q?5u7mhD9FpYj+qNDwvONBgdl82aioqnYVffdNkz/Ffj3PntftxxY5UoG54iob?=
 =?us-ascii?Q?8VLEa3RUQ8KCowMKxsUzBUP1ngD/V/52fBf/EMZ/6ZpaNvN6e45TErktZjR4?=
 =?us-ascii?Q?vwm86TpRO17+wvk+EWs5eCVAfrlshLOTD3uMwZN3v1Crl76lYpgMD2EyuGMn?=
 =?us-ascii?Q?XkefA4nfgKJPFF+XC8qdVSz/9iA1boPWbogGeQMANsMoyLfNUnBSIu2QJbSy?=
 =?us-ascii?Q?oTYuHkrcMbfWGAbuAgDw8m6NW4jeRdkOgEXmYs4bFVOxLwMB2wAjL30wrnzY?=
 =?us-ascii?Q?76xCjIqBzksZp+MMhzNN6EUTShcRiiHWme71IguWXXQfdQ374TGttMXSMzav?=
 =?us-ascii?Q?Kqcv5jxpvJflvQBUvQU4/guB6/Am+6zl9MXW+oMBig5qqdA0OMhO5RyF9CLZ?=
 =?us-ascii?Q?mnMxze+p5i5b29Uh+o/tBbqun0Cavhd1fJBe25XyW2Sk6/092vi0BFgf75Ei?=
 =?us-ascii?Q?RIAZWVzdMkcB40n+4pNYzXLMandx1osnxvKZYJIT98JS8m0RhE8DIVqbSHQq?=
 =?us-ascii?Q?g5X/PcyTtF3DtH2yocr9cDYt88Q6ihu6t7V8rjYx7usb8MLVvs+lPJRA88lJ?=
 =?us-ascii?Q?0rcVjnM5AYbxLC4r6H6sSD9avE5yeE2ZyxABnpIUA6p5eJTXx/NuYfD0lHtA?=
 =?us-ascii?Q?oc4yyie+moQGFhYRjn007vc=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b19f34-d54f-4f25-270e-08dcf270a973
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 08:08:07.3892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htmdo6Z/qkaLUOEtQo+II+8nZCLzZ33DsFEMJdj2AKlQY0lXQvhiyoc2PMMOSDUOinHqikIFKFOpSehNQVctkJiiK2oqzS3SpkqkTkUKXzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0824

Adds support for the Nitrogen8MP SMARC System on Module and
the Nitrogen8MP Universal SMARC Carrier Board.

Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index b39a7e031177..58979c030519 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1097,6 +1097,12 @@ properties:
           - const: avnet,sm2s-imx8mp              # SM2S-IMX8PLUS SoM
           - const: fsl,imx8mp
 
+      - description: Boundary Device Nitrogen8MP Universal SMARC Carrier Board
+        items:
+          - const: boundary,imx8mp-nitrogen-smarc-universal-board
+          - const: boundary,imx8mp-nitrogen-smarc-som
+          - const: fsl,imx8mp
+
       - description: i.MX8MP DHCOM based Boards
         items:
           - enum:
-- 
2.43.0


