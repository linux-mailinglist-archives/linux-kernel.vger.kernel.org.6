Return-Path: <linux-kernel+bounces-204909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0998A8FF4E5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9533A28A86A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6BB61FD9;
	Thu,  6 Jun 2024 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="heMxl5Rk"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9684E1D1;
	Thu,  6 Jun 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699644; cv=fail; b=F3DKjPlD4uwS+gleiX0zikd6frsRX8fl1Pgzvx2fBmvZMPmeUY//Uz5BjOm9PQDspFepmZP7J+nUwLIogXRou3yIwaIN7C4mNrHa+PLzGwsswRi/mPCEvBbovHbnN2IO0d9z3FpY2tqBITEszoBkd0UZqtuftGGMISWep+YZcUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699644; c=relaxed/simple;
	bh=HxqilMpkOUYtT6M32FAj6QHaT7m1xfXbT1CeKuw1Cos=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EBBiFqn3nngyfRGISq7qx3uh9cHPrZxBCUgpo4bjSIyOJZS8Cgvae2TxykEECf+B8K3XlW/ALLs+uOb3iFPcckTBm67QZPmhS8uScQPtr7ciwRL7nO3GwaGhIece5lIKjsP9i61w4il4QbR3Eo6LQFypyrLAujMl+ntnxfNPtHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=heMxl5Rk; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuhWzSw59rYc9NMlyaMRBgG/MDmnMkfVE4A7lSOo0tpZAOi4l7FJGul1A8CgZPJTFjGa/V74VX4amwVWgN/fYvnAjN1Uc3OCF0t89jRxhpu038xkhUZ+WedzqMzmapbIQVPTmwt1+Mz3a+QbIhM2TZlsUh3zfZecdgQgEohhQl6/uYDUx4CbsFVLqgTAPWnmRNT8vzhNAboey7d+XZTB8xWTrNX9UGsV5Vd9XLW7jxFW2Z7zGDrnyHGeNZCRdjtquMS7Azno/ROGpzg+9hBGgv5FPUa2nN+EQvujNoVxTfLPtpC6jvyhGoamir86HVZrwPN2se3n9+7O2eQLRne8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEr4H2t/FZhrOLiRv93baGt2D1M7/Y54CPZ/HyC2GX4=;
 b=fYxO5JUacFsl1ayXnTGxeskiotouZp7TRz1P29/Fyn1lw+lMxZbZWoFU8AomfVJJv+/XXill71HFKYu/UZpdtxHCfrwsugjmVWK7L7qXOs90HT7gTbg3RkMNuZQEyDAVCfb8ijCHqY3g+SIGCnkjTaiEYZYD8DycmvK4cwl516u68ak4VlySg6PJSjfU7Bh/SBU92MnMWkQHpXFdGtXK7QhwXnK6Gq28JRww1UEu7BsWgC0U45BBsNEGXB+TOZ24D17W1/gGMDQPcUella/WyZSF2vhxmWqIz4P00/yPMidDm/DxaZqykPeqOiGVWRlATvxqPVy4sR2dyK5kdmCCxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEr4H2t/FZhrOLiRv93baGt2D1M7/Y54CPZ/HyC2GX4=;
 b=heMxl5Rk6W3Ek6t2n9nYt1kAuuHCFZF8hr7R1+khkIjAInptfRKBE1KXP1I1DY75t6EFCX8ecEfFuFrSotTbaz1PMHe1LpeG/XSxDRU8ioiLmJhEJMfPtjYfNdBEx8mmmdZnUPfZ8k9myx8qRGqYvHcZYqP+Qgj1nwjsfD9GkWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB11069.eurprd04.prod.outlook.com (2603:10a6:800:266::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 18:47:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 18:47:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 06 Jun 2024 14:46:55 -0400
Subject: [PATCH 1/7] arm64: dts: imx8qm: add lvds subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-imx8qm-dts-usb-v1-1-565721b64f25@nxp.com>
References: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
In-Reply-To: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717699632; l=8595;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HxqilMpkOUYtT6M32FAj6QHaT7m1xfXbT1CeKuw1Cos=;
 b=6IdTc3M+2FeZeytZ8ahGB/9FuxJ6JzV9l0OK/B9EwX/QyE8EKS48Spqg+WQ0v1NINjgFVsMYZ
 f4zvGOZ0eInBtZIfWMGWui3onfdgftNhfVjmIVystIaAdAVzazJpkVA
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0178.namprd05.prod.outlook.com
 (2603:10b6:a03:339::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB11069:EE_
X-MS-Office365-Filtering-Correlation-Id: 4253d309-c05e-4b00-2a8d-08dc865917a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFc5eWJvZy80eVRlZEJxYmFudzdTZTJJWkJhbVpqa0VIaGtOWUhFclB1YWd3?=
 =?utf-8?B?TVVqVjIvVFBGWkRYMmRzZnZOSUJUM0FDWUR5UW5JT05kTDhNRTZXU213WWpT?=
 =?utf-8?B?emJUZEQ4eGJmWGpoWWd0MHJWRUVaVWJlRnRzOHRRS1RiNW84WHpvdlQvRG9T?=
 =?utf-8?B?L2l2aWJGN2w1ZG9EUG9HTHVoK3FsUURVdWI0S0hFWkx6T2xCZG9TeUhvVUZn?=
 =?utf-8?B?TzVza1JtSEtDa1F3bVJ5UDZGUTVxeThsK2p0UTNFcjcydisvaG1pLytLUmpQ?=
 =?utf-8?B?cHpQR1hsMWZvY0VEOWZPaWx6anRoUDZ1Sms5OE1iRlJQaUpWRTBCV3RRdkoy?=
 =?utf-8?B?WWZ2Zldnbm41RzJjcmM0MVU4ajM4MDUzUm16NkpNaW9qc3J1WWE1VlV0L1pH?=
 =?utf-8?B?dFBvckdwamRSb1FRbmlSd3FCSE5pK3Y5L0FaVWZ3bEJjaVNQMzFVR1QzV0lK?=
 =?utf-8?B?bGxXZ2tvMzBoNDNXYVdnUitSMHQvWUp4enRkd3hRS0xUbTJkcVNJT21FVXJ2?=
 =?utf-8?B?ZFNHRnExQ1pGZnFjOFFBUGhHSHVHMEV6akwvRTV3UmxXUE44K1NlVmVIbDBy?=
 =?utf-8?B?ZUZPZWRQOXozUVBnL05VcHdwOElqM2RBNk5ScDRVT3hoZWpvYXlzVXoxOVlW?=
 =?utf-8?B?dWhwK0FpMzVqWFczRDVzREhBT2ZqSkc2NXJ1YXExbFNweXFibk5GTjJESUVJ?=
 =?utf-8?B?Tk1oczFlc1lvNnRET1p2VE1CZCtmeWdyVmdsV0wydmkwTWZRcGpHQ0grTnZm?=
 =?utf-8?B?ejd3dWFyb0pSc3pzWVY2NkdOZDNJemJFWFRzbTNWaVlWb051RHlMdTFrcHRh?=
 =?utf-8?B?TXh5SU1DZzFnODJZRkVsVnhJOU16b3I5RzY5Z25oRXZQdEJkSjhoT0hicFpr?=
 =?utf-8?B?S3Y3TkJObUkwbFoybG9RRXFObEM5bHdBdklvN2todjI0V1lheEVUdm5BamxY?=
 =?utf-8?B?MlJ0S25sQ1hqMGdGcS9BcE9QZ0dJZzA5UmN0RTkxRy9zcVdBa3RYcWVVUnow?=
 =?utf-8?B?b2V6RC9CR0hUQURWbXF1ZGlMM3h1Y1dMdGxlWDg4K3MvNkRMUXZhVSs2SFMz?=
 =?utf-8?B?ZUZmdkFlUWJvTjZXM3lPd1kyaXdWelVwUW5vQUEzUS9iZXIvQUpxQkFvcjFr?=
 =?utf-8?B?ZVBTZENPZm1mcnhOc05ZTHVtNGtaZ3E2SWJhSTdGOXFEODExdFZaanVibVJQ?=
 =?utf-8?B?YmFFbjJueXhQS3czZFdTd2FzTHloSXlheVdoSWNOa0gxTkpiU0NMQlNUSGpk?=
 =?utf-8?B?c0F1R2NFK3dvOXlGdGg4cWUwOG1MVysxZEpVYS9sMVhsVFhiQ0phUFYwZVpI?=
 =?utf-8?B?L2VqZlRYRnlPUEtqdnRYRHdCai9ObnRTckpkK2xNWnBTWTA1aHNLV1h6NmNX?=
 =?utf-8?B?QXdtZ3kwZndrbDZGRXdCK3NFZkdQeG1scUh6VjgxQWh6LzIzYko4NFA5MnBF?=
 =?utf-8?B?bU5pVUFFMmZnMTFWSG9SbnRBdGVuTHpJNE9qc2VGSWkzUnJEMERtcHZXbGNn?=
 =?utf-8?B?cDVTY3RvZ25YQTEyMFdkQzR0cVdiQjdENGNTc3VFZ1dSc1JQZllqZmU2dnA4?=
 =?utf-8?B?cnRSVTNmQUN2ZVJPUTJRZEVDaTdyeHhKSlRpUWpnQU1Dd3QwSXZvQ2VpZmYy?=
 =?utf-8?B?amZxeW93dTYyQit1cmtjT0ZFdWhXUDMwM2g1Y2xSUTZ5MUtEYWxORW5LWXY2?=
 =?utf-8?B?VlpYK1BiYnh3elRhZzg5cExKYjVPSjMvT3h4cmluRCtJd2xFdGYvMmVISS9S?=
 =?utf-8?B?ejhxeWRBaHJHNW1GcnpCLzIwQXZZUFZoWjlzNThhYmM1T0lCNHpDa3RuQmNY?=
 =?utf-8?Q?zfTJZo01FfHvBg169ITn/aSzQQhJK1c9I5mps=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elJGUnc2WUtMcEZEQkxWNU5PbjNQR2t2TUwvd3Q1M0YwZjNhcUVqdGlyWXJV?=
 =?utf-8?B?RGsvYmozOWw5Wnh0SVNscTJqWmFIdlRVcHdmalcwUFNrRE9sSnFiSGNYci82?=
 =?utf-8?B?OU9yYm1JUTZhME80SVEzcmllVnYxeE84RVR6TkJOWDRITlFFWFVBUnZDYkp1?=
 =?utf-8?B?MjA4ZVFHN2VXYTVRMWtLa2JvZ3k1ZG9EY2VpZlcvVTFzalVsOG5iWFRUNkFy?=
 =?utf-8?B?T3psdG1zMmtFeUh5QjYvbWVnSm5PaWdCQWhxTHRSYy9JWUxPOWtpMDQyYTB3?=
 =?utf-8?B?WkRNa1F2Sk0yWmVLaFE2bUJoRTZSanNRK1J0R3hHdTZkelEwUDFhSDNCNmhy?=
 =?utf-8?B?dVdINTlCRDF4Umw4dmNMdEVsMFRDeDBKRnp6aGN0TTR4N28vZjdKaEk4bWpu?=
 =?utf-8?B?Q2F5YTl4Q0xuYjBlSy9iY1ZZd0p1Skg1Uk9SS1F4VlFQWE5pMlJIcHcvWE9m?=
 =?utf-8?B?TmpOTGVkcDF0cDJXaE5aQVcvTzNiTDR1aHZ0Y05uZWJJeGxRTzd2bHJ6ZHoy?=
 =?utf-8?B?d2dmd1p6U3RKU1prQmxJOWdoeUFjKzNpbmJlbEM1OWtKUm1DMmlVYzB1eUlC?=
 =?utf-8?B?ajNJSGdISUpGOHJURGY5RjRmOTJxZ2lNV0c1NDd1RHoxTDlsMkFScjJ6dit1?=
 =?utf-8?B?RlJWWHQ3MERrWW0rWk84QTMvcDRmYk90dkZzVjNsNTdtb2sxU0R4bzhkL1dW?=
 =?utf-8?B?aHRkK3Nic2dqYmJTYUVzZm5TMUF5VFFjdEFwVHIyWUFqeG14WnorWklONDVk?=
 =?utf-8?B?NDlQVDA1bURDZEdrNUd6cG84RGFUUHJrRTdQZENvaU9PVmE5bUNQUS9vd2p1?=
 =?utf-8?B?bkVoV2ZsSXhsWENVR25zMVpyeGQrd2MvZ0V3YnpzNkdtSng3TGtLVTlWZTlE?=
 =?utf-8?B?OEhzcmkrY0cxT0hyaGtnbFJ3WTNCdzh0THdLSHI3ZU1GTVVOeFFWaEU5UjVO?=
 =?utf-8?B?UGh5eXFRTFJTa1ZQazhKS21DdXpWN2J6KzV1Z2V0Q1cxZElpQUptdkNqVVdm?=
 =?utf-8?B?UnpsZGtQd0lRNEtmNnZncStXNWJhYTNETFhQVnRTeHdrNkdaV0Exa1BBV3Qw?=
 =?utf-8?B?QkdqNURUVTFXdDQvc1BSNXoza2IzUXdKWlNwaCtCc1AwQ09OT1NBTDQrUkx2?=
 =?utf-8?B?MFE1UmthQTlHbmd0My8rWmZrRlhNR3M0VTBJWG9UMEZXMjV4ZCtvcnI3K1Vl?=
 =?utf-8?B?aThwVUpDNWVaUnVoUFJhRDUwVUdJN1F5SU5ST25lalkwanpPRktIYlJVU1Fa?=
 =?utf-8?B?RkI1NjhndGdSZXdrRTZpKzE1V3lzUmJNMmNxN2wrd1RDTEc2M1B4UlAwd0x6?=
 =?utf-8?B?R3NDZDMvVjZjd0wvYnd0Y09yZUZSTFRPYng5R3pHTlBGWmpnVC9aVDFiT0FG?=
 =?utf-8?B?YVRMWmh2VnVBM2JSMXVwenF3OExscjBxWXZLRmpjdlBXZ3U4U1FmQm9tUFRX?=
 =?utf-8?B?bitsWlc0QlBRMS9STFJHcXE0UzJIeGdTWUhlViswR3BSZmJSOWVuOWFCUVBH?=
 =?utf-8?B?eXNHMnZRRHpISWpiY1F4Y0svS1ZEelV0V3pkQThJc0c5ckpnd0tOODFrTDdu?=
 =?utf-8?B?bGFyWE5PcGQrSGlrNXVCTFkwbE1qU2FDM1VkbEUwZFhhdDdNK0E1c2ttZHVR?=
 =?utf-8?B?N2dMY09Rd3VBN055N0ZZLzExY2NPVHFhTFRXTjFiVnhNRHRXTk54K0h3NVlw?=
 =?utf-8?B?NkJnaVFmQ2M4ZnA3YzhYZ2tuUlhLS1F6SnRuQzdWRkVPZXllTGpXaTlrTjBC?=
 =?utf-8?B?S2FtR29ZaU1HTUxWNFlaSWpIT2tCQkxkSUxEd1B4b3dPVCtRZkVvQ3h0ZTdS?=
 =?utf-8?B?RndtSUNhOTR6Q1BrdFJTaHFmR041SWZ3ellQVkN5Z01waEVyU0pRNzg1RHVy?=
 =?utf-8?B?YmJKSXE3aW0vcjRWQVJlZ3ZWdmJDbm5DSElvZmptNHE0YS9CUzBFekJObHNV?=
 =?utf-8?B?TFJOVVJrNFMwaVNiT2hlNmpZNTQraTR1NHI1cnBwTldYVHFkUnd4VG1lYXFa?=
 =?utf-8?B?WXU1blgxM1daR3BoTE5tSzQ5UFgvRC9neTI0ajIwT1d6eWVmN1phdGo3Ukh0?=
 =?utf-8?B?RTlVR2dnaFZibnhuMHNQWEtwaEZxMmtyaS84c0ZJTTNodUZ4dXNTdUF4MzFk?=
 =?utf-8?Q?AfFDUE1ig0qb17GxqCIrdDCsC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4253d309-c05e-4b00-2a8d-08dc865917a3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 18:47:18.7279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqdTubS9kKiV62gSbm0e2Z3dHVBilvaffQ4uoPfEyYbfwLMWAQr+bOVWdOVsfS92vsNNpKbo9n8ww2XGBr0/8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11069

Add irqstear, pwm and i2c in lvds subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi | 231 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi         |   1 +
 2 files changed, 232 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
new file mode 100644
index 0000000000000..eb8208cddeaf9
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Copyright 2024 NXP
+ */
+
+/{
+
+	lvds1_ipg_clk: lvds0_ipg_clk: clock-controller-lvds-ipg {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "lvds0_ipg_clk";
+	};
+
+	lvds1_subsys: bus@56240000 {
+		compatible = "simple-bus";
+		interrupt-parent = <&irqsteer_lvds0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x56240000 0x0 0x56240000 0x10000>;
+
+		irqsteer_lvds0: interrupt-controller@56240000 {
+			compatible = "fsl,imx-irqsteer";
+			reg = <0x56240000 0x1000>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			#interrupt-cells = <1>;
+			clocks = <&lvds0_lis_lpcg IMX_LPCG_CLK_4>;
+			clock-names = "ipg";
+			power-domains = <&pd IMX_SC_R_LVDS_0>;
+
+			fsl,channel = <0>;
+			fsl,num-irqs = <32>;
+		};
+
+		lvds0_lis_lpcg: clock-controller@56243000 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x56243000 0x4>;
+			#clock-cells = <1>;
+			clocks = <&lvds0_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_4>;
+			clock-output-names = "lvds0_lis_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_LVDS_0>;
+		};
+
+		lvds0_pwm_lpcg: clock-controller@5624300c {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x5624300c 0x4>;
+			#clock-cells = <1>;
+			clocks = <&clk IMX_SC_R_LVDS_0_PWM_0 IMX_SC_PM_CLK_PER>,
+				 <&lvds0_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+			clock-output-names = "lvds0_pwm_lpcg_clk",
+					     "lvds0_pwm_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_LVDS_0_PWM_0>;
+		};
+
+		lvds0_i2c0_lpcg: clock-controller@56243010 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x56243010 0x4>;
+			#clock-cells = <1>;
+			clocks = <&clk IMX_SC_R_LVDS_0_I2C_0 IMX_SC_PM_CLK_PER>,
+				 <&lvds0_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+			clock-output-names = "lvds0_i2c0_lpcg_clk",
+					     "lvds0_i2c0_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_LVDS_0_I2C_0>;
+		};
+
+		lvds0_i2c1_lpcg: clock-controller@56243014 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x56243014 0x4>;
+			#clock-cells = <1>;
+			clocks = <&clk IMX_SC_R_LVDS_0_I2C_0 IMX_SC_PM_CLK_PER>,
+				 <&lvds0_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+			clock-output-names = "lvds0_i2c1_lpcg_clk",
+					     "lvds0_i2c1_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_LVDS_0_I2C_0>;
+		};
+
+		pwm_lvds0: pwm@56244000 {
+			compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
+			reg = <0x56244000 0x1000>;
+			clocks = <&lvds0_pwm_lpcg IMX_LPCG_CLK_4>,
+				 <&lvds0_pwm_lpcg IMX_LPCG_CLK_0>;
+			clock-names = "ipg", "per";
+			assigned-clocks = <&clk IMX_SC_R_LVDS_0_PWM_0 IMX_SC_PM_CLK_PER>;
+			assigned-clock-rates = <24000000>;
+			#pwm-cells = <3>;
+			power-domains = <&pd IMX_SC_R_LVDS_0_PWM_0>;
+			status = "disabled";
+		};
+
+		i2c0_lvds0: i2c@56246000 {
+			compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+			reg = <0x56246000 0x1000>;
+			interrupts = <8>;
+			clocks = <&lvds0_i2c0_lpcg IMX_LPCG_CLK_0>,
+				 <&lvds0_i2c0_lpcg IMX_LPCG_CLK_4>;
+			clock-names = "per", "ipg";
+			assigned-clocks = <&clk IMX_SC_R_LVDS_0_I2C_0 IMX_SC_PM_CLK_PER>;
+			assigned-clock-rates = <24000000>;
+			power-domains = <&pd IMX_SC_R_LVDS_0_I2C_0>;
+			status = "disabled";
+		};
+
+		i2c1_lvds0: i2c@56247000 {
+			compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+			reg = <0x56247000 0x1000>;
+			interrupts = <9>;
+			clocks = <&lvds0_i2c0_lpcg IMX_LPCG_CLK_0>,
+				 <&lvds0_i2c0_lpcg IMX_LPCG_CLK_4>;
+			clock-names = "per", "ipg";
+			assigned-clocks = <&clk IMX_SC_R_LVDS_0_I2C_0 IMX_SC_PM_CLK_PER>;
+			assigned-clock-rates = <24000000>;
+			power-domains = <&pd IMX_SC_R_LVDS_0_I2C_0>;
+			status = "disabled";
+		};
+	};
+
+	lvds2_subsys: bus@57240000 {
+		compatible = "simple-bus";
+		interrupt-parent = <&irqsteer_lvds1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x57240000 0x0 0x57240000 0x10000>;
+
+		irqsteer_lvds1: interrupt-controller@57240000 {
+			compatible = "fsl,imx-irqsteer";
+			reg = <0x57240000 0x1000>;
+			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			#interrupt-cells = <1>;
+			clocks = <&lvds1_lis_lpcg IMX_LPCG_CLK_4>;
+			clock-names = "ipg";
+			power-domains = <&pd IMX_SC_R_LVDS_1>;
+
+			fsl,channel = <0>;
+			fsl,num-irqs = <32>;
+		};
+
+		lvds1_lis_lpcg: clock-controller@57243000 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x57243000 0x4>;
+			#clock-cells = <1>;
+			clocks = <&lvds1_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_4>;
+			clock-output-names = "lvds1_lis_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_LVDS_1>;
+		};
+
+		lvds1_pwm_lpcg: clock-controller@5724300c {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x5724300c 0x4>;
+			#clock-cells = <1>;
+			clocks = <&clk IMX_SC_R_LVDS_1_PWM_0 IMX_SC_PM_CLK_PER>,
+				 <&lvds1_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+			clock-output-names = "lvds1_pwm_lpcg_clk",
+					     "lvds1_pwm_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_LVDS_1_PWM_0>;
+		};
+
+		lvds1_i2c0_lpcg: clock-controller@57243010 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x57243010 0x4>;
+			#clock-cells = <1>;
+			clocks = <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>,
+				 <&lvds1_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+			clock-output-names = "lvds1_i2c0_lpcg_clk",
+					     "lvds1_i2c0_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_LVDS_1_I2C_0>;
+		};
+
+		lvds1_i2c1_lpcg: clock-controller@57243014 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x57243014 0x4>;
+			#clock-cells = <1>;
+			clocks = <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>,
+				 <&lvds1_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+			clock-output-names = "lvds1_i2c1_lpcg_clk",
+					     "lvds1_i2c1_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_LVDS_1_I2C_0>;
+		};
+
+		pwm_lvds1: pwm@57244000 {
+			compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
+			reg = <0x57244000 0x1000>;
+			clocks = <&lvds1_pwm_lpcg IMX_LPCG_CLK_4>,
+				 <&lvds1_pwm_lpcg IMX_LPCG_CLK_0>;
+			clock-names = "ipg", "per";
+			assigned-clocks = <&clk IMX_SC_R_LVDS_1_PWM_0 IMX_SC_PM_CLK_PER>;
+			assigned-clock-rates = <24000000>;
+			#pwm-cells = <3>;
+			power-domains = <&pd IMX_SC_R_LVDS_1_PWM_0>;
+			status = "disabled";
+		};
+
+		i2c0_lvds1: i2c@57246000 {
+			compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+			reg = <0x57246000 0x1000>;
+			interrupts = <8>;
+			clocks = <&lvds1_i2c0_lpcg IMX_LPCG_CLK_0>,
+				 <&lvds1_i2c0_lpcg IMX_LPCG_CLK_4>;
+			clock-names = "per", "ipg";
+			assigned-clocks = <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>;
+			assigned-clock-rates = <24000000>;
+			power-domains = <&pd IMX_SC_R_LVDS_1_I2C_0>;
+			status = "disabled";
+		};
+
+		i2c1_lvds1: i2c@57247000 {
+			compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+			reg = <0x57247000 0x1000>;
+			interrupts = <9>;
+			clocks = <&lvds1_i2c0_lpcg IMX_LPCG_CLK_0>,
+				 <&lvds1_i2c0_lpcg IMX_LPCG_CLK_4>;
+			clock-names = "per", "ipg";
+			assigned-clocks = <&clk IMX_SC_R_LVDS_1_I2C_0 IMX_SC_PM_CLK_PER>;
+			assigned-clock-rates = <24000000>;
+			power-domains = <&pd IMX_SC_R_LVDS_1_I2C_0>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 61986e0639e53..9f29fe4589668 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -576,3 +576,4 @@ clk_spdif1_rx: clock-spdif1-rx {
 #include "imx8qm-ss-conn.dtsi"
 #include "imx8qm-ss-lsio.dtsi"
 #include "imx8qm-ss-audio.dtsi"
+#include "imx8qm-ss-lvds.dtsi"

-- 
2.34.1


