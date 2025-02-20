Return-Path: <linux-kernel+bounces-522890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA418A3CFBB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3EC17CDDA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47201D89FD;
	Thu, 20 Feb 2025 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JFCYMVTR"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013055.outbound.protection.outlook.com [40.107.159.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FCE1D5AB9;
	Thu, 20 Feb 2025 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020346; cv=fail; b=aWyffZxVShbzu0v7snnnYngjEm6XeY6Nlcsjy50B9VI3E3KnAcq8qoH0DzPFa4ROcf6m/Lk5znA2yJwqlDwXZ7KYe8U50XYDcVLomFHixoYQrOnDNCn/33lmaxwQJSYdBL2ptc48AuHQwsDDAAJzz5Iax/a/4xU/xvxb9n3ZKoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020346; c=relaxed/simple;
	bh=NkxgtAEqkCPin0kRRZ0NfIer/X+iQfwyqfI7tm09qtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ahPSH2VwEwvGN8mEZphnpoUyEEMonquS0G7zr0X8TPkqu26Bebj38QqOC6D/dviqK80VAvP2zy6sW+PopRxUE3Jzk2srFXsyEA5CZypTA44Hn8gQ8W4ttWSZaWkNnUW21XkTRqZrtw8vMuSH+TMYbmZ+umSHJzCThdfNtjAuSkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JFCYMVTR; arc=fail smtp.client-ip=40.107.159.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmUILLrdFMjBUHvgiMc/Ot0e15ytDRH3h8bla/38iTTNEyYKdLktvTUhd3Z2ceZ+jCVKNFtAqOFyH+UgBqFfnrLEAM7P4IewHsluChkJe3J7s4hKpw+FkbY0DaZNCtYLbF7w1BIhpiXd3X0TLVWGcwqlkN892XtxUUHYLVe/1SKMMphnHyRgXgVj0agZLUNraX1VWOevku3SfRbqxX8ZNB6Uek/X4KNwBeyIPKlKPP8KFqwCW+gerYYRPnW9arWWEEq2EVbqRHQKbJ29FuHhS9pQuaUE1Kc2o4bMEaD8GxOjz+qo8IKnnr0/Vnst3FTl2hEAI2xo8ja213L5WWUoQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkxgtAEqkCPin0kRRZ0NfIer/X+iQfwyqfI7tm09qtY=;
 b=bmTj1Ix0tKBLFEvOZDWeIFgSr/VAKRhKR1nBDK410lmmugpJtCZOuq10LBjjfmSfT9guXTmLvDiNFdR084KShMZD8ePvp6Adp2lSgPNNCC9St4Z16yyATWzxp4Bi46tg8O79Ea58FlguYFdOVdqhrwwJFzVKhLDBWForEq8XOYDdWCAX1tVr399ODS46Ns3XqxtO31cUV2j2d/nLdUWUNpLLUOefJKj/n9rEvEj0e9iRp0MIFmwgplFU4J/Cslhe/HMATgVySpDJqhBVGZvMsbe4TPOw7rjycE0e3sFIy0FyUkaAL6ssCB4hpxEr+IhswJKmefXxlqzQeGe+0mIQ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkxgtAEqkCPin0kRRZ0NfIer/X+iQfwyqfI7tm09qtY=;
 b=JFCYMVTRNLF2oT6NTQfpuTvJYJJp+yq+jaQVeQOhrXXjgy0iYiHDQpN2XTzCYPyY5MxabDmt7U4hRAn/TDY8i/bI2H8hahbTXGNJaEBTU5JP9h6UGusEwXbVGrypu1BqYfZB/BOTXkkWWD2yd0fJxtb3kd/OJtdZmvhxmmFBUOuH3q8nseARiAujl2s2pZAsPUxqB0TwKp7ToNMUpEUm0WwpNjoaSqUZ4Z3w8fk3KSl89/n+bvBufHc9nGkR3rBIsoFWeor1TFSyVGcmXWdO3inSA4f8zYiOT7Hv+ASZ2QUj3GROr277BnafYt7R1PZ+4al+lr9B75RtISCOMZExDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 02:59:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 02:59:02 +0000
Date: Thu, 20 Feb 2025 10:58:43 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Frank Li <Frank.li@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Abel Vesa <abel.vesa@linaro.org>, Marek Vasut <marex@denx.de>,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/6] arm64: dts: imx8mp: add fsl,nominal-mode property
 into nominal.dtsi
Message-ID: <Z7aaYw-ILh1NPq8D@NXL53680.wbi.nxp.com>
References: <20250218-imx8m-clk-v4-0-b7697dc2dcd0@pengutronix.de>
 <20250218-imx8m-clk-v4-3-b7697dc2dcd0@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218-imx8m-clk-v4-3-b7697dc2dcd0@pengutronix.de>
X-ClientProxiedBy: TYCP286CA0218.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS5PR04MB10020:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e71a50-3b89-4853-981c-08dd515a87a0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x5sG84lHECc1u0WvF2TRNod+WQ8szexSDrpbPq48SOjkHdSRw4vKO4UDY8DL?=
 =?us-ascii?Q?RidFZQcJ3x1n4yFVyHRY2Ceqfle/uzDzMleBMfrLlhEnIMSvtoNB2Ki9Cljx?=
 =?us-ascii?Q?/p5a29stoHe9KVZjgaClRi/8eYH1vY8iNhkjd8ol0aTK5lRTcfZujXdai+hN?=
 =?us-ascii?Q?woF6uJwLUZ2RV9cWA38AUSnJJit9hOZgzpbSokfxH8+nEjSuTbpYC6xUmHzW?=
 =?us-ascii?Q?IdxXbEgZ0MvZ5qu0n3WGkWfvUGBTt4VkjmzrCZqKR6DsMJSvnPHxkFEMzM/V?=
 =?us-ascii?Q?cQBarUzxntw1U3f8UTuIg/++LEEXsqEW5J024Wb/eyxfIgURUs6zb7RlVV7s?=
 =?us-ascii?Q?opeWupTkFvxQaxseEvL/9Qq2VyHZgRJi7n5yTLQVlsTHWl9AGYmndGPJ/doY?=
 =?us-ascii?Q?aSfX4KHMKDYwUfaiJ0LoDMWyP+Jtc5xkCdQxVj6ge90bJGU4h/8RSMBqPxXA?=
 =?us-ascii?Q?tM/D7N+QEI0ewi/6ppYismc0y2cUG5sL1U4j7YFJUQS828n2toWqWhZz2lFZ?=
 =?us-ascii?Q?W5MHdBxOkX5MrRnV0gTsNjrcsjVKRLEWDDEYbBaF5K4xjJc47g4TRAuhi2yS?=
 =?us-ascii?Q?ltQ6ZgCIRQalyTNdPDifox0wUKhNOm4+ITyVEkSTyzGsIgpZQVTMm6SE5P8V?=
 =?us-ascii?Q?r5O/jSZwMthhNameObp+PsxQHRwoPAUCCvDJXDX1SG1FMWllB+9cZ7oXAuUU?=
 =?us-ascii?Q?WdDJDZCm8A2N0mU8pqXJ/DkIHtegcSvLPs09T4VKrPgFDo4xKMHOdE3PgdiN?=
 =?us-ascii?Q?CAVUGbRgx3kYlPyNWHEmeyTPFiaOtT/pKGsxcsMJxVHL3Sx8kaEx16hppdRy?=
 =?us-ascii?Q?yUTfFsoDRa/sTfGoKiG3QTv0oQQOjHBRhOW/YLZtRxfx4ItEcoUT8TI0QQhy?=
 =?us-ascii?Q?x+8dGDKnCqNiLnEi3OGJlBS/qaFfQYsiKiJDU6wTTbxuUkfLImwZWnS+W18w?=
 =?us-ascii?Q?uW8vV5odvkxl/muLyEMFjPdEF46m1PJS+jqpw7STPaw5KCSun48pIOQ8f/sW?=
 =?us-ascii?Q?hBEoHiiXSEL795lyk+IpjtHbUTgzeXXH8SDR0q+AqdYcRvOt7xGMRFhRykrS?=
 =?us-ascii?Q?0USVcK4DccYaR6gug/JIwgX9o1EnkD5EaEbUtZGfc/nY6b7xBht2To/41r+2?=
 =?us-ascii?Q?vmm56yuA2RfZgbQe/nnVCHXRxv45pp5d7dsULMszA6b+zef61omNY+WzV32u?=
 =?us-ascii?Q?wGS5v21viFXrecxKmLmhLkwndoA0N5ND+wzy/fvw50Od5+38+w22kh3Ko06c?=
 =?us-ascii?Q?MgnxK5kky9230DmKHk0PH+SHsKTdF/C74c3KGv9uabyrMaHHuf+vvA6Vl4wx?=
 =?us-ascii?Q?T12eaxHFxU1Iln3wjVZxf10zFfLi/Csi1lzXl/yQHCN1IkJTspREEN07MxUj?=
 =?us-ascii?Q?eryKTBI00FhnMOTPNLjXcbEIWFz4T0spVU7ePhlD2m5xhO8AAzgNMw5B7HAh?=
 =?us-ascii?Q?uVP5uupSWls262+kdv5PMOutjjWi2by0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?55Fy1+acjPNBAoRU4HWWFs7zss+XpaZtkSJc9HnxDMFoWmUe6uxT9yf+QtLW?=
 =?us-ascii?Q?Q/ZOEytyaCSEoEsYtmNfsM94RPh0mKmhxXK8UVF5zl+SVce8rj6+POEtB1cE?=
 =?us-ascii?Q?UweKYQGKnYxhPE75T7vN58tLrdxpGJKrTq9Iux9/sf+Qaf7PYH8eqJstyvYT?=
 =?us-ascii?Q?ufpCm53bWIILx2dyz9ALAzcSG8BtYwiYDAkeui7P1FVUZsFR0Ys0ekDgXrVC?=
 =?us-ascii?Q?5lo/32qMgtxWINNS7JGTsjTt4bGqw3qvvnlEA2zAADXR7EkamWNRUG6iChPR?=
 =?us-ascii?Q?tA2rdGhiGjvfcqPO/jFXhz7RT8biELY8eB/ogvfKq4Jkm4+8fnTeWfWsgeV9?=
 =?us-ascii?Q?rEPKjmaPf9WUYuiiPUvoWOejApxcDUOIB9SVihCXrsiJWomEk1JZFUm35lNL?=
 =?us-ascii?Q?QLc3bVq4rE+12hNCZYlZkMOhSdcDySQV1TPGB5Vd1xZmdZuL9+uGVimmnwiD?=
 =?us-ascii?Q?kqXAuiPgt2aQCuvR5zp+6SwbEvTODNytYkGcU77eg+lm0s6X6t4aGPwyqGBm?=
 =?us-ascii?Q?Yyov+olwkaLp0l0ckDvqaMkrTZPBg9hwpAN3SvqHxZKNOw0AI0qFvjGetHbp?=
 =?us-ascii?Q?1KDU6Q7IbugW2CfLkkSCLqXFQEQ4y24X9klO/Mmrynlx4nNV32DtxViIS8X9?=
 =?us-ascii?Q?GEXdr8LoGSH0xCejB/LJzGNcpFI1Dpj00JSAeV2AAuYUtLI933Vbe8Wsy9H5?=
 =?us-ascii?Q?F6FlGwTX5W8VlNf5F15I5rlwuIdQIBqdrRZ+NZjfIBhi3TrIQnj2bTRsvREn?=
 =?us-ascii?Q?ZBT0TtLRfhG+0QRpHbxAR3GqvQZ9ks/gXQSXer7OG1yj1mnS9J6HqglO65Hc?=
 =?us-ascii?Q?8E0eHqnTdVZTWyl+WsHPai1Rito59vYYnLQUhge+JHCnlYfDNG4flHvbuZnM?=
 =?us-ascii?Q?8m+A4zpTC9IibFtCtyZehGADfUDeEwDhWVfEmN6mh24Vipp0fvlfKSyW0DWa?=
 =?us-ascii?Q?F3zpmmaEqnv7F0SK3Zg3Ui9f0ES4ynk3l8V3CAfUknVa9ZRZ2djvwJ1029lz?=
 =?us-ascii?Q?RTWy7HCMTTkD6hRjnRFFOpvubWeW63HzMyB5LmwsouacN7n9d37xdN0ucSqw?=
 =?us-ascii?Q?HpAbx6DPYnoCCmXJzrUsVmkTbQhbN5ksyzAQActhF1RvVylJHuKibpvLv357?=
 =?us-ascii?Q?5JD7qdnNN56svAHRECY/E5tuNfoAglKzx53kLLfsxha3nVQhFDejIzaWMq2/?=
 =?us-ascii?Q?KBSONsQ456gRZwIQVYASq/HTFcyLHlwr/nHvPWWHhg96CWFpMEPYJ/QSYjBr?=
 =?us-ascii?Q?pXfjHDhHwmL9nEbmJwaLCjtUFhWVoRkB1MaWstr3cXCCohSQwMj5smnACh+S?=
 =?us-ascii?Q?P/XwOCXJ5CjLCxrHKIwPj6pNfveYRiyEGHlo0JdRdWE1LzLEw/tKvgj5f+bd?=
 =?us-ascii?Q?0ig4ATOvmzV/Zdki+fY36I3NF8/GGeepXuIXZYMYFH8H/UQkEik0VnSC4Ga1?=
 =?us-ascii?Q?UA9PhFuUKXmg4PalU8NB4BZ/uS4A8n9YQW3JEyC6c1XnSunkEa/bRUKWkgT1?=
 =?us-ascii?Q?PMzkNp3ayC33umd3HQRKmYlVWqtkGFtopLibSHfcRCZ//qPWguE8vVueX8qN?=
 =?us-ascii?Q?z2RGfhm5A7e4KRpA0l1e6dnm1+oo3ex/LpPkaeaA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e71a50-3b89-4853-981c-08dd515a87a0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 02:59:02.2012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsSs3HvLZY4p6HCSChu2mYM9Fo88nEaP+yPEaK8mHdPCPLJCwdVw3lpLZkH8pxHy1tqGN6buD2bzT0J9+2Gw9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

On Tue, Feb 18, 2025 at 07:26:43PM +0100, Ahmad Fatoum wrote:
>The imx8mp-nominal.dtsi is meant to be included into boards that want to
>override the default overdrive clock settings with settings suitable for
>running in nominal drive mode at its lower required voltage.
>
>Specifying fsl,operating-mode = "nominal" informs drivers of this fact,
>so they can sanity check runtime clock reconfiguration to observe the
>limits imposed by nominal mode.
>
>Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

