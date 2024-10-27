Return-Path: <linux-kernel+bounces-383581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B01C59B1D95
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 13:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68E0E281A59
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 12:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DDC1547DB;
	Sun, 27 Oct 2024 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="U9MvuEIo"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2076.outbound.protection.outlook.com [40.107.241.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FFE7DA67;
	Sun, 27 Oct 2024 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730030755; cv=fail; b=R27cu+uluqoS/ITYVqclxZRO4dVp37eyvWjhJuEEYVsu6+rKpopBhNTPTx0gTXJv+caPAtU3cE/2eq5M4l+VtNPy8jNbyMJN3R00BZBE0PN3KeuEbPTVQA9hnv53rug+sQ3Jzo40wmUv7+zDmTyfiFFtE5wqOFc9nUnDsNdB2Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730030755; c=relaxed/simple;
	bh=YcwFkbtFV026Y8ksYlGgcwcGWipxaxFf/JI1t9h/mLE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=CQ0xzGfs98J2QR4ih9wi1iUxrGwDewVPa5gUy26cN71lI6s/u07Xiz8iE/Tq7wdCjUoyrcf6qz6Jl0X70PE9KksrHJDlrpUw8fw8HTGwRpxqH/XJqJpuetdEJauFXWIAMnK4mB26kORfu7tI9G3PlO7DntmnupGLBPyAq2o3oCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=U9MvuEIo; arc=fail smtp.client-ip=40.107.241.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jd/qwux6NPP8xLbEBzMx6lcxfIh/FsteVnYP9hy9JzZ6j2m9vqFogfHvod6OkjZb+m05s4z8uh2xmrT9HjGTFIhc29U9GGvChmhC10GguHdyvc1dS1KUm5Vk0Ul9BaXyCJsOsuuKAku0eXtTZoCtBqYReIW/XRs5kFrzvcQrSMMQKEc/hy9PXFVGmjqSshCgRBLR9jrNsR5sjlpvMNdeoXfn8F2rQsO1sIgVrkuaFwRnBnNfFGi/hlLvccoabNTzjXCPsbEmQznwfnHpCsCL2EGcpDxNRHiBEaQUKgM4o0jvuPhD4HMhFxvvy4xnsWtEjzEs3rxHaPY+jN9v/Q1plA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akRBHhTzA+/ScA4ZI0iAxTTpavMr2MOa4j1S0l4m3jE=;
 b=tly+VMobUqe7rqDlkovIgGeFVY/xJeS38AXBR3HFl1Oygz+Daah9BLMQ+aqSYtBXcXsfpwXv3IAJhlmY4rvheGVg75T3jynnZacqVuutyZ3/DSDwES1hj6M9LFILMuA8O0c7RQv5DKMNtM1VwdUN49vQkqqLEm+GaVckiNXk1RHn0k21KVSccqpSJMSwjiT4x+wKXOZNXizAY3uPbUctf985DtFOwq+LNW1miK84vIr8xvWtE111gNDbzubnpV4yqhW9XnebkiwEC7k9wF8C9H8AxMx/PTf0fi9B9ndHMqrDgm8HfpmuXDH0FMvUkNYs5MLuoRaQ3pgdNEiKAkZl/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akRBHhTzA+/ScA4ZI0iAxTTpavMr2MOa4j1S0l4m3jE=;
 b=U9MvuEIoD5ActVHSOHPMJw+x4wrHtSStzNacC6kiKtlWOr5eeF79ubTujmvG5j4DeVDOsJ+P6ClwwcgCUpmQoCmSGjxi8fNczEMqjZOtzzjtwI8ImlUVUVNYcyKhSWWWZAuz7AmiwJ6paLLanO2Drt4USyuSid/KPu8L3YmgVzf2PTKBZ0Ez6y4/t5z36MSpsvI8j2kAchoGFHmKSE7qeSmGfnGUQ0RZwgehrcLh4PNbdgkgyATKN5Uvy9r9kgc7RATQWWcmv3M0D8BSGtSHCuWl0bUa4z4ox4hXUe7z64JGhtYKJwAYKDgW24y3/ZLq7yHw0mrE+4ZMGLy+MW5QJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PAXPR04MB9596.eurprd04.prod.outlook.com (2603:10a6:102:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Sun, 27 Oct
 2024 12:05:48 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.8069.016; Sun, 27 Oct 2024
 12:05:48 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v3 0/2] spi-nor: add optional vcc-supply and enable it for
 i.MX93
Date: Sun, 27 Oct 2024 20:15:58 +0800
Message-Id: <20241027-spi-v3-0-42e81723bbcc@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP4uHmcC/1XMwQ6CMAzG8VchPTvTdYQFT76H8QCjkx4EspEFQ
 3h3BzFRj/+mv2+FyEE4wqVYIXCSKOOQw5wKcH0zPFhJlxsIqcSaUMVJlCnJaG5saSsN+XMK7GU
 5Vm733L3EeQyvYzTp/frvk1aoauuJ0BFrdNdhmc5ufMKuE/0I8xGUBXfWV61rGTv/Fdu2vQEfb
 lnaxgAAAA==
X-Change-ID: 20240920-spi-34231ea74761
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730031368; l=1247;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=YcwFkbtFV026Y8ksYlGgcwcGWipxaxFf/JI1t9h/mLE=;
 b=XEStuGFnWTqYRJk/wLFImWg9b+G0nq06Wvxe0EaQgGNx20WtVb7w6Wp6gicAblMgiWTCk27Ld
 qC9IYwPVs87Ac8IvsFhlp/G2bU+ArB0+LUDXCGdkiGujZlsW9nVhSgg
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:4:91::20) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|PAXPR04MB9596:EE_
X-MS-Office365-Filtering-Correlation-Id: db9aca24-0fa5-4aa3-1a5d-08dcf67fb18e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zk5NeFlPaTIvV2ZVMm5rSUZ4L3hjT1E0WHcyMjg1NjROakJkSEpUSVJ0TUIx?=
 =?utf-8?B?UFNIMDJBcHZRSVN0S09GMGx3bEczR1pWaXZUMzZpSTl6aUtSK3F0Q29kUEpy?=
 =?utf-8?B?T2ljb1pzNzFzUUIrcmFuNkxDZjhsWExZcWlDSzRXTGlDUGNRS1FKaVJqc0o4?=
 =?utf-8?B?R2RkbjlJaEUvdHE3UDNycmhwcEtTdkE1S2lGYStoUVl5MnpMM3Y5TCtqUDNw?=
 =?utf-8?B?Q082blpEeFIyazc0bEMyYUNIb3NxaXg1TTVJT1BGL3FjN3VpOVVmeUdBLzNM?=
 =?utf-8?B?UjNxVnJCYXVVdjYrWXI5Sm5SVEVQZ0lBRitsK3dVZUxYRzNtT3ZxMDJ4bmVh?=
 =?utf-8?B?WjVMbk00ZnBaSFZPYjFITjRRZk9OTDVlOFpLd05TS0JybXFOZTA4d2IxRXlX?=
 =?utf-8?B?bHlVUm9qaVFPTWlMUzRIRkdheVZYem4rVDMyaGRoNzZSVllHL3VWcXZTVEpB?=
 =?utf-8?B?OU1lQzh4OXJNNnF3ZVBWZlhYTVA1OUhLbUI3cm9XRHZsbjlEUC9BQlkxeldH?=
 =?utf-8?B?U1BJclpYT0RRNUJrUnREZzlwdnFTcjZqTXR5MURtRDE0SHo5Qmx3SmlaYjJp?=
 =?utf-8?B?ekJGUElTYThjVGhlRm55VnJSQnhISkkrVXZXWkxoekw4eG14bEYwS0lOTERT?=
 =?utf-8?B?OHJ0Mzc5b0dFbXNFK3owME5RbGhZWlRXUnhqTGQ1bDVFdWo5UHArbTJMRXd6?=
 =?utf-8?B?cENsMGZ2MEMyb3J2WVlwMmZNbS9Xb0ZQMmxYWitRYndoTzlYS095UjU3Yk5n?=
 =?utf-8?B?QWNXekJDM2NaaEJXWDgvNkFBZnZnRktRUE9LbUx0ZlVZeHdTRnFBaFpHTXlX?=
 =?utf-8?B?MUd5amZrTkVLNFhMcXd5VGRpcHV0ZmplQjJXMzIxeHRLSjI0bWpwOGNkbDlC?=
 =?utf-8?B?T251SjU4dU5YWkJ2MGZoTENiczIzZGRQc2lNaEJ5T09kclQ4L2ozVHlab1J1?=
 =?utf-8?B?bXNJZ3Q2a0NoNVR0cXZYM3lwYkpSaUFzUExYZmVtV1FrMDJzcm5xMGdqSGJY?=
 =?utf-8?B?YzhuNGl3N25YZkttbk5Pc0hEczN2RlZ3U3BzS2hlaEpyeG13OEFJbGZvN2dQ?=
 =?utf-8?B?UTFrWFVZTW9tKzI3QVRxYStxRG92Skd4RTFGdmY4UEcwazNsMElYcU1BVE82?=
 =?utf-8?B?bWthYXBjNHJKelREaVo5OStWWEJGUHJrdWxqaVpIeUV4clVmWWV2UEg3REFz?=
 =?utf-8?B?U1JXZW9zUFdrcHdtdnEzWEZCb0c2ZHg2Z2xJL1JocU52UUJTUS8vLzJGTlFT?=
 =?utf-8?B?Q0dLYmFLdmFpaGhWTjA4RXR2K3NrS1lMbmVxck13MkJaZzRzb0xvYXMvUU1M?=
 =?utf-8?B?MWFTWVhFQUt4aXdLUFNYVTBxblpqZE03a0ZMcUhzM2VLZjF0amdjNUl6SEcx?=
 =?utf-8?B?YUZ5QkZDN0s5M2FWQmhwa2tGN0c2bnhGMzlxalJ3THN5YjJKYVVhTEw2YXdr?=
 =?utf-8?B?USs1RUJHM3Q0Zi9xVzdES1pBMVZPVEJlTXJGUHlTbWV3MEQ2aEZjc1lJRFNy?=
 =?utf-8?B?TmNxQkZCSm9UbEF6Zlg5Q0lLVTFRcVdoc21ud2xQS3hoVmZ6elEzL0dRbFp1?=
 =?utf-8?B?K3hHdTd1eWU2d3FLNHpjcmhBbWtpc0ZpUmhPTjVGUkpDTG9wTmd6dDlabjNZ?=
 =?utf-8?B?ZHRNMUlWa1VvTnJPVkx1WUU3QkxXMlNsZjR0Z0g0U3RnbHFXVGlBSnZaWHdX?=
 =?utf-8?B?SXExRWxrUlRpSjlyTzdrdmRtTXhuWjcxbS9UTjBvTURKeDZxWjNSNlhJa0RW?=
 =?utf-8?B?UjlhcnZzT204WDJSd0diMXVFcFVMTlZXMXphbDZOSHVOVVpQSFVpbjRWenNj?=
 =?utf-8?B?ZkRuVFF0aXRuZlh5Zk5TL3R0T01WcDFYWHhVb2VsWW4wYjM4clZkQXJzdUhq?=
 =?utf-8?B?cVEzR0o0b3pjNkpnTS9uWVZ0Mk1QOXdLOGNqMkMzeGhBSkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXA5dXk3R0pxS3lrYm9xZmY5NytpTklqRVJxaFJlZENmcnFmM2FvMU94STdZ?=
 =?utf-8?B?ejg5S3FYRFNOSmYwa0NHZHJzOWc4OEsxbUdnQzFnWm5MNFZGa2hKMUg2SXc3?=
 =?utf-8?B?RE1XakR0MW4rYkFXbjg4WDA0OXR4N0RyL0NvWHl3Z2l2K2VrVW5xLzRNNFkw?=
 =?utf-8?B?R0wySTgzTHpnQjJJWTRHSEI4alJBb1FDU0NnQ1N4aWlGN2dpVU1YcXo4TTJR?=
 =?utf-8?B?cW0xSWRpOHdwZmY2RDh1VlMvZ0tmR255bUpoNkVadjJrQVF3NHltYmdaeUlK?=
 =?utf-8?B?QnMxbDN6bzlQSWRWZ21EMGZld2trL0FWYXlHY1FPNURKQ2Z1TTBsVlkvQ0w2?=
 =?utf-8?B?bE85b3B2cCtRVlJJNXR2L0NhVUtucysxVlZObWZCQ29KdkRmcUdENmJ6aGUw?=
 =?utf-8?B?WkVVVTI1SjYxL3NMRGNGV0JKbmpYbDB0WUwzSHExemQ5WXdmUC9DTFdFTWNX?=
 =?utf-8?B?UFZFdFNhUVBBOFJoczhHbmdlU3hLZ3F6Y2QzQmFsNk15QnJMUTlXR2RGWjRE?=
 =?utf-8?B?ZjBlNFJwWGd5ZHBpTzJVNGpJU1R6UDZJN0xlMWFvYS8ycEMwa1pqV3F0UkZ5?=
 =?utf-8?B?cTAwZ1hqYm5QeW83ajFBdU01MjRZUGdzOWFEdDZuVDV5ZENSTTlSUTlGZUhl?=
 =?utf-8?B?SmszRTBkNnNoeWRXNFJ1d3hrYkJ1aldOOVpGNThBa1hkQlZFaVRjVngvVlpH?=
 =?utf-8?B?QU9ZWThJWTA5UVVmeXpVUXJKU0JnMmRjTjg0TFAwWGVmdzJSbHdOc0l2VDY2?=
 =?utf-8?B?ZGd1RUVKeGVqTXliUWhOZEMyQU0rM2t0czFiZDJJSWcxdTZVZ2NyeVZ6VE95?=
 =?utf-8?B?TXN4bW9HeGF5NVZrR0dlRWxNY1dFTmUySTkzOTRINjlkOGo4S29YYWd3dStk?=
 =?utf-8?B?YW1SNW5DeHY5VUZxSkdkWFJ6V1JwMzRLK3lXd0pmQ1JEOHNER01sN0xJQXNO?=
 =?utf-8?B?VzFHQWpqMzVpbHF1V0JsMGlnMjRnVmhhMzlhekhRS2Joanpvbjk2TnZmVmYw?=
 =?utf-8?B?Q2E4Z1JmTndjUzNraXYwQ2tRYUYxU0txUk9YQysrL2Rsb3VHclA2WG1RejR1?=
 =?utf-8?B?Vkw1ZmR0MzU2N3hxdHhCT2pLYm5PWUY3cGZFZmxhUWMrVFVYMHZCYjJyRkcy?=
 =?utf-8?B?TzFxMmVNZ3hvRHRUM0VzeWtka3NHTzlyaHdXUDlrYmcvODVyZVAwY3V2Q29T?=
 =?utf-8?B?MGVLeXFpRXdsRUdReDhSSUhZQnk2M0t0Y0ttUmxIUUFpNi9USWQ3M2UrdzMw?=
 =?utf-8?B?RDQycytFaWcrblBORkhKNWRlRndWZ1NMNER0SEkzeXlpNXRFcVQ0czZJckRh?=
 =?utf-8?B?Y2RNNGg0RUNhM1d6K1lsdUM5YmxwcENidlFyQy94RG5MKytmWTdEajNpcWZS?=
 =?utf-8?B?ZkxrVUwwQlZYaTJCTGVWYUJLS3lqbERYWENoa1hQVDVLMmZaYmFHQUVSQmxP?=
 =?utf-8?B?L1BVT291ZWRCRjE2RG1NNUY1OWdXell2RTk0WDQ1L2Z1WVhTWG9vRzBhT3kz?=
 =?utf-8?B?Qzh4NmRkMzZBb2xlK0duNlV0Mk5uUVBpaWhTSmYvQVgwYzBwRDhGMzErUjMy?=
 =?utf-8?B?MXQ1dWN2V0dqSVBWVTVUeEt6c1RjQXJiVEtsTGsyOVI4MmU2bkpZVGxwRlZD?=
 =?utf-8?B?Ti9ZSGt4SGJEUEpwMEtuMEFUSlh4QjhhaWdsQm91SmIrUUd4RGVBQVZyRjRM?=
 =?utf-8?B?eEdOMnp0eXBwY056MWJyRTRBKzJrUWxjSEFFanlON2ZpOHVIbFprRDdtYTFL?=
 =?utf-8?B?T2pWYUc1WWNxZHZmVExvd2daVm9tZDUvNnU2WFpuRWZHU1BKTWl0TVdnYUl3?=
 =?utf-8?B?MEVObzJwRVhwV3pUbUJhQTlOMzNXUDRVSllmOFk4QlRRTnY3aHhONFA0NjIv?=
 =?utf-8?B?emI5elhaRzU2dVhJSEg3MnlqMmZDUFJwVVpHV0FkZTN1TTVKTzFsMFRubStv?=
 =?utf-8?B?bWJnYU5SMkhLUXZDV3hCeWIyUE5aN2hDVG9Ib2d5aC9aa043a3REWTRlN0Uz?=
 =?utf-8?B?V0dLcFVYT1dVczZNMk9WbHV4c3Z0WWRvMjN1NUhTNThOL2RORXhKK0JHWmI4?=
 =?utf-8?B?QjE2bWJMMXJqU3I5RG9BTFZpRG9jRDNzbmlTbGV0OUlFK2xpenIwOXNrYVZx?=
 =?utf-8?Q?JvCZjaeOaCZK8Tm3Mb6+HzCnY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9aca24-0fa5-4aa3-1a5d-08dcf67fb18e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2024 12:05:48.0865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2XLfAnKAZbsEjHJ0p78e2ch+77mo3f6+VY/jsZa92DXL3cQvZmm9fnn6sQLVgd6pJN3rmKDZiaFqed3Ydax6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9596

spi-nor flash needs power supply to work properly, the power supply
could be software controlled. So need enable the power before using the
flash.

Patch 1,2 is to add vcc-supply for spi-nor
Patch 3 is to add overlays for i.MX93-11x11-EVK

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- Rebased to linux-next next-20241025
- Drop patch 3 which is to add i.MX93 flexspi overlay device tree.
- Typo "spi nor" -> "SPI NOR" in patch 1
- Link to v2: https://lore.kernel.org/r/20240930-spi-v2-0-ed7f6bcbe0df@nxp.com

Changes in v2:
- Add A-b for patch 1, typo in patch 1
- Use devm_regulator_get_enable in patch 2
  I still keep it in spi_nor_scan because it is in probe stage.
- Link to v1: https://lore.kernel.org/r/20240920-spi-v1-0-97f220c2e10c@nxp.com

---
Peng Fan (2):
      dt-bindings: mtd: jedec,spi-nor: add optional vcc-supply
      mtd: spi-nor: support vcc-supply regulator

 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 4 ++++
 drivers/mtd/spi-nor/core.c                               | 5 +++++
 2 files changed, 9 insertions(+)
---
base-commit: 7c98818f1183b7e4b6757901b41b0e37293aa28c
change-id: 20240920-spi-34231ea74761

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


