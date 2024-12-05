Return-Path: <linux-kernel+bounces-433722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DFD9E5C29
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195D5165FFD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE9D226ED0;
	Thu,  5 Dec 2024 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VrGtP9+c"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3735621D5BD;
	Thu,  5 Dec 2024 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417493; cv=fail; b=B+FCgNONgU0WDyMm5uFWoZTK6P9+NLURfsQ/roM87AtOKe4EUpe926UxPYpVulymrNy522SmORffH3ZZ5aOyXdIpRTMav/EECShBL8EuPfxvmxwkwZC4b5nSjM8Aj6VWJmIQJcSGK/LUNUynoKJ8TSz3nMjONrHbZV5eQl4F0Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417493; c=relaxed/simple;
	bh=E/9uxdBtjF0j6zPxcwv3XbWI+yAR6dXtQGZlNmZDiU4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WdMYcFQSRp3l9gqj+N/psqd3KWVy2lAF6RPZ+ne/3rXexE4r1OVzPsu+Zq1AMJNdA2gxjnIdImKcRl/tLuueCPPQSfH1+tnXINzOCI2v/AAvZwh6JXjPJnFuXoRliMEkD/OnGf3kb7V5LAr04uWxRrrNJqnR4I7mhZmjWO6C+pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VrGtP9+c; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHY4mPNFdNC5sn6KzXlE1xbbSEmRH3G2kG5KDcRffWR3BVSo0ASvswLui26WJLF9bUKxsLDwneI6Ko7OUr2ipdew1LmMHORNTz55jyPq0HLbdElA3YniZB3YL5czvPqb8v4/ih7tP+DUQAl6ZAwugNsgCtw0E83XqKXCxY1dbrc8lilGOB0/5eV65c2o13JFDsN6S/K4c1bF+AzoTahMyPX8XofetC6rVK7D/ILSJ2kimdbyl1rWg0drbgwDRV2/VFpA3HlQlgrc2Kxux6SDJK+MLOVN5Rx5htHEqpzXW8EoYWfYjV5Dfj0Htwg/FHMJAZwheOCSTuktNI9uI+HnMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sLpS2YJwvojP2Rq1CdHzqmGzIPERE+0rD2KZt8p0Vc=;
 b=kLnVYrn62Hru0da+xUZNSqPGjuOdm6XGW8xIAo8OwBe9DVhuQovn6pCHFQdyNKMAR+vxoa3iZXTebEdA6bDGfy/BVuVn+n7/TtKk0gvSXLb46DjkQuWuwu4JQtqJ2rnszFz87WFbH/E+RkflgCnRO3NdVG+DrchFIkxahuBv9/Hx/BkeyrmmyvZed897snKZUDgTFzT6vRV0cQvS9sjlRoG8m5btB/VhYCp7jzOZJoHyUoFdXiQLaaAJLo8aNmOQY5GLltp/JBqXs7sbg1ib/o3H5oHQV9oIG4c7iX7z//gFvKKaapeP7jO5rIRjEzgetNOkZJDAW1mvpEJfz+n9/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sLpS2YJwvojP2Rq1CdHzqmGzIPERE+0rD2KZt8p0Vc=;
 b=VrGtP9+cM00tHMrwtb7t7ZbO6BhBsbTiBZl/LRMna2SnSo87T4Cg/+jXGJ1BCVxiRFsBTKee5bTgnaYiC6pdSfcoDmxCt2FictsZggzA0qxVL947XmQHAphLLV5/i+Zv3Z40L3Mj6bOJzQQZ6Z8sPadnV4j7uepAqmokAC/hU4tXvmUgeNQdXXLhMHE3UziooQb0vCs6EjTwAdzMUII/fSVt8vht1wav3wRanL2zFKAkqt8HScd2QbdwMHveN9EACalqAh4GjQaezoi8TPJhkLMS1GdqM3G0JOwS9lVW8LELRn/XO/81vXHrFCKvwcMcVz6ZRST2zkmqM3D1f8GbNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.13; Thu, 5 Dec
 2024 16:51:29 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 16:51:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 05 Dec 2024 11:51:09 -0500
Subject: [PATCH 1/5] regulator: pca9450: add enable_value for all bucks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-pca9450-v1-1-aab448b74e78@nxp.com>
References: <20241205-pca9450-v1-0-aab448b74e78@nxp.com>
In-Reply-To: <20241205-pca9450-v1-0-aab448b74e78@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robin Gong <yibin.gong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, joy.zou@nxp.com, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733417480; l=4660;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=w0wr4uNLDwl95zI6sHN+f9rDrooK+8cDnt8wPRzm9bc=;
 b=qdUn7TI9xxJdccSA3p+UtGamFXi39sMiW/XoATXHbl09sXZPD7lSCGomd95FiS9uqApO5qX6F
 dNTTCMcAn0vDRkFHwsv2/ZvXeyxPos2Ea0jhk32Z8Hq+Qiw+qHjBVAy
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::42) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 887a29e3-8a75-4820-1a9e-08dd154d109a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amY0U2VOSU9oM0NWNThHSFJzcWtGWVVwWjZ4d1RlcDZvcVBKaHZiL29DVEhm?=
 =?utf-8?B?QmUrTTR6cWNhK2FGS1h4RFVYc2wwbkFtZGlGMHoyMi9ITTUyVXVsb21HWi9I?=
 =?utf-8?B?dkJGT1J2em9iN2pzVnJqSHZTZFdOV0hscU5FSG9uMjRuTnM5c0hNWnJoeldw?=
 =?utf-8?B?WHZCYVJybTI5WGxXNGtPMWNEWktEZm90cnZnZjRFTnNlbi9uMmRZUUxiV3Ax?=
 =?utf-8?B?VkJQcEFid01zZktBOG50VlNYVjRKZnJQRkJ3V2VHTWsyM3h0Q1JFYldFWkJw?=
 =?utf-8?B?UWhnajdZeHVaNmVuUWhnLzZsamRlQWlIK0lFZGxBcHBYOWdJOWhuYVFlaWI4?=
 =?utf-8?B?c3dZZFFIMnFkNEo5cFR2dXRVTERxUUhoaWFKRzk3R1FLb1hub09zQzI3bDRC?=
 =?utf-8?B?RXNIZm5RazdORHAyU1Mxc3JnMWxDcHZWQjEwcnVpWkNKeVBrTXVrc01RdkNj?=
 =?utf-8?B?RzFHSmw1VlE5RWlNZDRSVXpRQlhNRXBVZXo1VVJ6Tyt6dlFEdkEyZWlJQlBq?=
 =?utf-8?B?MCtNbkVQNTB2Z2lQeDAvMlF0MHJDSTA0dmI2aGhZUG16d1llZExnK3pPdURQ?=
 =?utf-8?B?ZlBsTm12WjMzbTFTVEx1T1dIRjdkNVpYZit3S3JtV1J4bmhvRTRJd1dJM1Vi?=
 =?utf-8?B?MEV2b1dJOVVrVHNKbHF0eHBwUDRLOU5DMWFQU2xwLy9La3hDUXNqWERicHRH?=
 =?utf-8?B?MG54RVhqR0owM05uZG4zZ0Q5NDJicXd2WlBSZmhUblJoQ2taK3BnN1cyeVRq?=
 =?utf-8?B?WFYvbmZSM3kzdnErVll2M3dpQ0pHTktuRmRUMVJka3pEUFpqOGpQTTdxWkVp?=
 =?utf-8?B?amU0U3Mwbk1DT21odDlCSlJSU0FIaWpTbXNLd25DZndpTlU4cmMxYzkyRlgx?=
 =?utf-8?B?RERqUFU3YzQ5czBwOGNPMmxKZzM1dit2SHFjbTJ0Y2JldmY0clpsVGlrcXRK?=
 =?utf-8?B?cHg2QnVZSmJQUzNkcVRvbXpTeEV2Wk0ybk53UXJRcmZoV3dQdFBpU29wV0I5?=
 =?utf-8?B?YXZOMjJRSGJwSmQzcVh1MDlxRVpIYmVNSGQycTQvd3h5RE15R0lOVDQxN2tE?=
 =?utf-8?B?Y050dUl4bkkxVlp6eUN4UHdSaGV5NFpDeGg4ZWJuMC9lM0xFd0VTaU0rSEV5?=
 =?utf-8?B?d2ZaazczZm5OTmltTWtnVm5pbndrUGxGOFEyeUNsRTUrRmZxWjdhS2RJR08v?=
 =?utf-8?B?RTVTanNRQ1R3alNUNDBkdGpNbURISlVTa2dROHVHT2gzRndWN3dSaTkrdEoy?=
 =?utf-8?B?WDZoaStsK2hiRXNobjlqMXRBQlpSdTJmN2hrTWdRSUx3WDl6UHBxbnl0VGk2?=
 =?utf-8?B?UlNlYnlJZUxkRXBpWFlraXloNU5SUmQ5dmlDZXd1dnZJVXFvZEdsSjUrdmo5?=
 =?utf-8?B?VndjUDJlcDJGVDdCWFlrVmpONnZJTXl1NXovRUJtOW9DS3h4bzFVUXFZRElU?=
 =?utf-8?B?dWxjZWl6NUhFRVlGaDZHVXVySmdQUkxuT3dXSnZtYWxEc05ySUtGM1JxSUpQ?=
 =?utf-8?B?OWl4QnhRN0p4RDVsUlBaSGs0anQxQzFTc0xObjIzNWR2NGVGNTlQQjNVYkha?=
 =?utf-8?B?K1RsTGJ0YnE0eDQxdUE4b0JKSEhCVk05QWhkWFlBaE81RFBVMmlKcXZBc1Ri?=
 =?utf-8?B?MlVJcG80TDc2SGpQOFNlQ3Nuc0U5MWJIWk5uMmdrbEFJRHFIVjJNU0hXSytw?=
 =?utf-8?B?RDVHTGpxRko3V1JqTjlMWHpmTkpUdUk4eFdDVENoK0tYRzZOc1VSSWkzc1dB?=
 =?utf-8?B?MmNjUlBQTTdUSDduTCt2MEdzdUx2UWExUzZFOFAxc3p1MVNORFQyYmxiV2Nz?=
 =?utf-8?B?UFhkdU53czZQaWZuWVoxczdzZFFBd0FvTWdReHBJWkdpRWhCZitYYm5aaUVh?=
 =?utf-8?B?ZlZBUXRYb3NnZmRTSVAxb1VXcTZhdDZtMU92OGxtb0paMmEzV3prYi8zVjVX?=
 =?utf-8?Q?7sRDwrVOap8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlhTdmltRk1CUzk5ME9sMk14SnF6REY3Wk9qWlpBemEySldPcjIzTlBZSWt3?=
 =?utf-8?B?cWFhN2plTzhyOWZkNFN0aGxRUTZzblhnSFhuK0tRWS9EUHBENkN5Ukpvdmxp?=
 =?utf-8?B?cURINVNyOFU5OWxrMjN4K0pOd1Q1U0pNTmFhTFFQTmo2LzlyRC8vNHkwbE5n?=
 =?utf-8?B?dkdsTGVRZjF6eHVIaUZmV25TRFZnZFFvTjA5bXIvNWh4N1lSZjk5YlFvZUtt?=
 =?utf-8?B?dXhzRmVKendxWFpqSlJNUTBOdXFFNmlHQVFxR0xJQ3NhQThoZ0RUMmlkWmZK?=
 =?utf-8?B?TlE2aWJVNGFBUVIxVm4xZnZrYVl0dm8wRW5zVEpaL2M0NVVxOE1RWk51MmtC?=
 =?utf-8?B?UlZ6TlVoRFZiOFA3MS9PaWlQV1UxODJiU0l2dmxjV0Y1enpTRUFHc1V1c2FG?=
 =?utf-8?B?Q21PV1VRa245aWZhVGxyTVpzY2dXdTc1U2FkVVpKY2ZVcEZYSFBsUUhtK2tp?=
 =?utf-8?B?QjBEQkZpMHJjQklXanQ3akUrY1MxajlMZXlycUZaWUpJcWFSUXh4NXlwK1Jp?=
 =?utf-8?B?SXozdmN3aHYzSHA0akRwbEJNb215N2FFMFFrSS9RdGVqWkV0czZMdnFjRlRq?=
 =?utf-8?B?ME5TcXovMCtvOXFrWStwWnNoU0xEdnFHMmtBTGc2aHpaRi9IcGxRWGRTcmJo?=
 =?utf-8?B?U2dpQjJXbnF4WW1kTnp5UVZqRU54VEQ0cHZNUk1kL1hxWG9zbWNnN2NuWWFT?=
 =?utf-8?B?dmlVZXZqYklBM3JVU1kwajFpaGgramFaaGNzQ3ZXUHFkWXNKcDBQSDFDejFL?=
 =?utf-8?B?cHBGZWlVRFd6dmh3Q2tWd3F3NEdnODIxR05iRGkvUlpUcHltZHdsTHBrT203?=
 =?utf-8?B?WXIrcEpWc2ZxWFZhT3g4NHBqcnRLRnd3UFV5QWxuTkJjTkRvcGZwQkVlRk82?=
 =?utf-8?B?cjlkeFBvblZFa25PSW1tWjY1SjQ1UEFsaVhsQ3FIMXNkNzA4c1Z5eloxN3Bz?=
 =?utf-8?B?NHVpdkNnYUJPWUtqSS9YUzdhdHhKcnRRSmxycStSWXEvQjZPNDVFY2lEWXRs?=
 =?utf-8?B?OUtJN2F1bEl0NG1WQmpWY2hHallsbysvTFFkZ0xtdTVtS2FaOE9wNmpBVUE5?=
 =?utf-8?B?TlJZY1Vxa016NUZLSXJBZzdXRHhpb3dPN29DZ0lCWm0yd0Z4WVBvc0JUaXRF?=
 =?utf-8?B?LzlXZHphYXRPakxQRmpVWlByNXZNZEtoM05qdkFyTDRQWk9wbEZkT0JMRG56?=
 =?utf-8?B?VGI0MzRaZ0VoSVNjclVQZVVLWWc1REVqZUxIa2lEdUV2SjFsSW1RNjROMlI2?=
 =?utf-8?B?MnZ0aWxPa2JYYUNnNkFHMXk5QXpzdUp0akwrdGcxVmNXV01kKzUrY2ViQith?=
 =?utf-8?B?a2pPVGFzYmk4MUtQaHE4Wm5oRkpCUEtoU1NXRjJTNDNXbVZQaEhjQ2FGK3dn?=
 =?utf-8?B?N1JLdnJtZEhEMnFOWG5HS25YYlora3YwcXFOKzlBL2ZGZWRMVXl2bndzaVhp?=
 =?utf-8?B?YWQ4bllJZ2JXNUJMZC9sZG9veWFRbTBkUzB3MURiOUdTTm9ZZmJNRVZZQWJX?=
 =?utf-8?B?cWpmT29taWdPd2hMMjdkTm5HSTZMTFVJM2FVTExZTm1yK09KdFg5V2xReTUy?=
 =?utf-8?B?Q0pzZ2lKTmZuZEZuWDNvY0RqemZuVGpQci80T00xb0N4SkM2VkFLZXlHZ25v?=
 =?utf-8?B?V1M5U0hKMDExTFFReWlMaVcxb0xtcHpZQzg5dVZKVWNOYjBHRENPd0Z1dm5k?=
 =?utf-8?B?QWU4eU8yYjBSMy9yT09JZEhUSHpGOWdvVkl0Zmx1YXF5aDJVN2gwMFJ1ZHBu?=
 =?utf-8?B?Mzg3Wmh2UllOWkJYTUtDUkd3ZE5jaWtJU0tVVVVCWWphYUNpT2tQeDk1UFU0?=
 =?utf-8?B?djhISWVvZ3RhV3VabW1Oa0hpdzJFWWFGNDdjS1ZLUmFXMjJCVlZ1YTZSWUVq?=
 =?utf-8?B?KytIU3BQRTR2TDJsWEZnUDF1ek9CQmt3OURkdzMreFEwTC9xeDFKOXRZdDVK?=
 =?utf-8?B?TktDSzAzbmplVW1sV3lsVnVrc0lGV2gxY0Z1WlBPVTU5cmlMVXBZSUc0L0Iv?=
 =?utf-8?B?dmtyRHJZMkZtMDlkSUlFOFZIQUZJWkZYWUVMaWJ0bWxqWXFEUVNuQ2RDQUNS?=
 =?utf-8?B?VE4za1dHNmxMY3djMGNmVWxmUFBLdHIranJVVnBwWVc5TnNLL1JIYlJHcXJj?=
 =?utf-8?Q?yGFVACG6UmKTUr8GTnlz+3xG7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887a29e3-8a75-4820-1a9e-08dd154d109a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 16:51:29.5233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCvNJOHlRwi42a9aDNULj+riWjtAEOi80JCv/qmggsbasVsDtWYSdusXYwKh9CinSGgX3CO8bv1HvMs6s4+R9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7511

From: Robin Gong <yibin.gong@nxp.com>

Set 'enable_value' in the regulator descriptor for different bucks to
manage their enable modes:

- 00b: OFF
- 01b: ON when PMIC_ON_REQ = H
- 10b: ON when PMIC_ON_REQ = H && PMIC_STBY_REQ = L
- 11b: Always ON

Ensure appropriate behavior based on the intended design. For example:
- Buck2, designed for vddarm, should be set to '10b' (ON when
PMIC_STBY_REQ = L) since it can be off when `PMIC_STBY_REQ = H` after the
kernel enters suspend.
- Other bucks remain '01b' (ON when PMIC_ON_REQ = H), matching the default
setting. This avoids the need to re-enable them during kernel boot as they
are already enabled after PMIC initialization.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/regulator/pca9450-regulator.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 9714afe347dcc..caeeed433165c 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -247,6 +247,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.ramp_mask = BUCK1_RAMP_MASK,
 			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
 			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
+			.enable_val = BUCK_ENMODE_ONREQ,
 			.owner = THIS_MODULE,
 			.of_parse_cb = pca9450_set_dvs_levels,
 		},
@@ -272,6 +273,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_mask = BUCK2OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK2CTRL,
 			.enable_mask = BUCK2_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ_STBYREQ,
 			.ramp_reg = PCA9450_REG_BUCK2CTRL,
 			.ramp_mask = BUCK2_RAMP_MASK,
 			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
@@ -301,6 +303,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_mask = BUCK3OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK3CTRL,
 			.enable_mask = BUCK3_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
 			.ramp_reg = PCA9450_REG_BUCK3CTRL,
 			.ramp_mask = BUCK3_RAMP_MASK,
 			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
@@ -330,6 +333,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_mask = BUCK4OUT_MASK,
 			.enable_reg = PCA9450_REG_BUCK4CTRL,
 			.enable_mask = BUCK4_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
 			.owner = THIS_MODULE,
 		},
 	},
@@ -348,6 +352,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_mask = BUCK5OUT_MASK,
 			.enable_reg = PCA9450_REG_BUCK5CTRL,
 			.enable_mask = BUCK5_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
 			.owner = THIS_MODULE,
 		},
 	},
@@ -366,6 +371,7 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_mask = BUCK6OUT_MASK,
 			.enable_reg = PCA9450_REG_BUCK6CTRL,
 			.enable_mask = BUCK6_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
 			.owner = THIS_MODULE,
 		},
 	},
@@ -481,6 +487,7 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.vsel_mask = BUCK1OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK1CTRL,
 			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
 			.ramp_reg = PCA9450_REG_BUCK1CTRL,
 			.ramp_mask = BUCK1_RAMP_MASK,
 			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
@@ -510,6 +517,7 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.vsel_mask = BUCK2OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK2CTRL,
 			.enable_mask = BUCK2_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ_STBYREQ,
 			.ramp_reg = PCA9450_REG_BUCK2CTRL,
 			.ramp_mask = BUCK2_RAMP_MASK,
 			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
@@ -539,6 +547,7 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.vsel_mask = BUCK4OUT_MASK,
 			.enable_reg = PCA9450_REG_BUCK4CTRL,
 			.enable_mask = BUCK4_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
 			.owner = THIS_MODULE,
 		},
 	},
@@ -557,6 +566,7 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.vsel_mask = BUCK5OUT_MASK,
 			.enable_reg = PCA9450_REG_BUCK5CTRL,
 			.enable_mask = BUCK5_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
 			.owner = THIS_MODULE,
 		},
 	},
@@ -575,6 +585,7 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.vsel_mask = BUCK6OUT_MASK,
 			.enable_reg = PCA9450_REG_BUCK6CTRL,
 			.enable_mask = BUCK6_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
 			.owner = THIS_MODULE,
 		},
 	},

-- 
2.34.1


