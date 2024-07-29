Return-Path: <linux-kernel+bounces-266313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ADE93FE01
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6604A1F23473
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED153188CA3;
	Mon, 29 Jul 2024 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fnL3C8Ne"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84A918D4A1;
	Mon, 29 Jul 2024 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279619; cv=fail; b=WvDluu6W9A4/fDZHywkP61NOex/6APY2PsKlUdEZBTxMcYcdJMnwcBvQ4sDxm6JpkSt9kGJvVAN8hyIslaqjqysyfsVaGdtzpleD0v7l4mM6ImauH+lTYPk1XT0FC49AmIkkW3ZNS4Sa208Ulc4K9AEclUl0nLPFPbnA/JSAqps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279619; c=relaxed/simple;
	bh=N8DJqTRxULPhnlZF+78DGRt79wyI1je1xCOfM7hXUOY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pBUW7a6+uDra5O9atRfPN4tlxflGRvnMYQ/kqdAKpIDYVBMQ9Ub810K2XrxpnApAZ3smkksXPMaqp+WdAf4um2rSyl0t6JxMtSuYEht1mmAWFQVqIZVe7NbIKpixgv2N2z+UymVDl6EGDepkBp4tW+0dKKPbtDIkGzr2YsxJLbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fnL3C8Ne; arc=fail smtp.client-ip=40.107.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jc62JMbcZWpqhwppoOteanSSlmZ5Xa2g6ngGtCn/QbGWxe5xljFMlgi5+aDKMbB+JjX34Zc8k9mF7QCPmvrQw2Izd/cAeK0Rs7K6RyCSSr11gz4QuZSBJ0G8lSPdTWfbdIeaSROpiAiBBTkz9balFAwijUaqSGqEclQPJGL+fwIMwEQPCemGhnwF9PlFg8lk47ryCEKxVjGquGwm34/i+sJVoGLwwxk9uga/+QXuaIePGcdVbjiDHH2/wX59Lh24VWmzafykWbJwvH11Gbbf/zcYdhAmObQf4ujgyNw+8AHc8Ze7Tbcssx47gmtidudGwGxOePFU+vQ7UIqCmYGmwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBu8XVmIr6vW984v/goO0KfHL0kGDU4ReHbAq8b13hs=;
 b=SwEJnkVsj6UDTMu6Mka34Ut7rpiy5SiGVtn94AvAkQT/lucAZcaq7m05ZR0yjMBiGCZTsEWRIlUryLhK75BSdVsvcp/szTW8vMDXKKygpERA0CaJpPOUTXOZ5+6pwlBWXW/OtswrOf9Wj7kFR017tzXB2wz9uSIIVpC0ppdI7vhHCwcDoZm4f4qrcrBbDjyg9ZKchf3fnoxhL+UfuieCbswoGqRbzfvtSeuEZEqVDS41JdXoNFitqc8l4qeU62J69/aMuceMHwlxxfZ3Qrh1bxRESDoSiFukfzTMyHLrqPYHiMYpD3rlPr2p6IsxQJTLj3pSCw5e2FFTTNVxUANzIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBu8XVmIr6vW984v/goO0KfHL0kGDU4ReHbAq8b13hs=;
 b=fnL3C8NeB3jnTvdDC97gQACM6oIm/fmCuzRWJ7dOi1O2nIEF/Q2YNMVvYmNymEgyPKMz4yivxjFv+EaPKCeQByzbLqczhOxNEqhkawaKBWHbtKqodlXfD8jfXTKiRCQuE5ZKBD7WqklSW0QI2JEvjezEhE7o7ECWEPGIFhXDrav7WmjCRPTiioRXxezHmDGf7xpF336GvnPfMzC2PGToTm+GCkC6TQ0EiXnFgswVgS0OdasQdpRLn0AVrV6rGpWISNCSIUVUXI5sB/UIUh/PdblZernCm0RCwSWun9t4UOAipXKZjR7Oryi1vMK77ot2/Vg4LIRYGG9J2SMmatxHCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9590.eurprd04.prod.outlook.com (2603:10a6:102:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 19:00:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 19:00:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Jul 2024 14:59:32 -0400
Subject: [PATCH v2 10/10] arm64: dts: fsl,ls2085a: remove fsl,ls2085a-pcie
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-ls_warning_all-v2-10-942d80ddd441@nxp.com>
References: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
In-Reply-To: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722279587; l=1974;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=N8DJqTRxULPhnlZF+78DGRt79wyI1je1xCOfM7hXUOY=;
 b=vVSQew0wSgfYsW0RLhoGtENRoR8sYkRm7wtqPVxZxlmvzzaRKSIPN/OQHwLqW/uoVBrSLvCCr
 B+fVL1g0rbbDk/BNLh2w11vsUrhDhn6NGxOLxCTMIXfOfiIy4CCQurB
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9590:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a5a4f6f-30d6-40d1-fe64-08dcb000ada1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmN4MHc4OXNvblllcHFwUDM2SXRmdVpucDdVSjJGM0FzNmViU0RGZlJ1V3pn?=
 =?utf-8?B?dTV2dHcwVEEvbFJuaGNBTmYzeGpuVWlYNUNVWXhuRC9ESHJsaFovZGtBU2M2?=
 =?utf-8?B?Y2lUSDFYcnQ2Y0ErdGhiMWlWMVBqYXNwenlraGVmRnoxQmZDMS9HRXlWbFRj?=
 =?utf-8?B?N01HK3h4UFlORmZQbWFUWkNwak9Kb2RXSXJHWWlmdGlUS0hKdkFJbGhDVTR6?=
 =?utf-8?B?OWZ2bHhJZElzTUtnbllDWGtEUXBLUWlndUcvdmJrN1I1SDJhUE5LZFZWWnRy?=
 =?utf-8?B?M3Y3NTkxNkZPNWlqK2pnUFhoa1RZbDBoODdIYmpldFdkY0xUNFkrWWdJYlVG?=
 =?utf-8?B?RytLTEVuUTNyTGVDbnFjcFM0WkpiTHkwQmZuSHBUUi8vV2tpM2pSTmgzUGdx?=
 =?utf-8?B?S1NVMnZQMGdTR2s1bUxwN2k0ZFd1ZndqMy9HUmhPT2FqT3pvaURlWW84eGZ4?=
 =?utf-8?B?ZUxlQWlXaUtpQWpaNWhCaWNEVVVMZTdicmRZUFdsUGpkR2pyUWhRVWMxN1No?=
 =?utf-8?B?ekxmL0lSQ1lFWERKZnhlQUt6NWZ4cG9iamJWdTRqNC9TajVOeXB3cHBRNm0x?=
 =?utf-8?B?b20vSWVnblYvKzVYZTFtRG0xUEdtTko5Y3dKNkVxMGxTZU55Q3d3WTNEWFp6?=
 =?utf-8?B?WHArdkExMUE5N2g2eHQ5RjBiMXBndk5wTlNTbi9uUmx6bmkwY0YxTlZ3a3lG?=
 =?utf-8?B?dXRJR3B2SzZvWHI2RTZRUTVlYnY4bmxza0JhNlZWQmVpSW84QWRodTdQcHh0?=
 =?utf-8?B?L0RuRjc5aXA0U3ZpK1lDcFcxUFY4TE1sdjlHRHl6Mk1OZEhRN3ZTemdNTExn?=
 =?utf-8?B?U2NLZ1lYM1UwWDZqN0sybmNITkhKZGRSS05YSVF2bml4VndOM0NreWI2ejB6?=
 =?utf-8?B?bXdSZTB0K1VXaE00Q3BZS0ZjMUZLeWtoZDQ0OG9jNWlUUTZjcmhNbTZuVDkz?=
 =?utf-8?B?UmZ2VnNUanVvQSt6R3RpU0JBSzJXUjgrUUptR2JHczUwTDlRZlRpc2xsTjFu?=
 =?utf-8?B?UHIvRXRWRmxzUHVCbFlWNkZidm0wS2cvVitRa2k1a0tOcUdsaWgzQ2RpeTdq?=
 =?utf-8?B?aFpBckpZWkJOVU5uMlBsL28xZzFMVml6WlBuaVZ4aWdMLzB1VWt6Y1RVbFlR?=
 =?utf-8?B?UXB0cml1V1haY0FXTzhBNEZ5a1Q2bEFkZ0FmT3hCYUpTRXU5NkNKM3RnQk9B?=
 =?utf-8?B?SXNac293NU9wWWpHblhuL2ttYmhFWTdCa2dXM3J3Ymwrbnoybi9LdjA5cXRw?=
 =?utf-8?B?WHNtS2NUSytUVTR4OC9RZml3NlpWTnpzS1FweEtNcGFWZGk3NTVPRHE3TWU3?=
 =?utf-8?B?TUJFelJNRVl6NVNpaHlSaGRSdTFuMUNvQmsxWjZzR2pTUHZqd29BUDNVVmI1?=
 =?utf-8?B?TnBsL1pNbGNEL3ZUNUJKc0lJR0lzbUR6RW5GTmpvZldCbnJ5RzdqWEo1cHEx?=
 =?utf-8?B?Q3B3WGZrd3F6aVpOVEFPajJEUXUwdmVOV3ZzZ05SakhOemd2V29RMFZtMHJD?=
 =?utf-8?B?S0lNYjUwNnhvb0VUcFZvbmRwcGM4V09uMnA2ZnpjMXpzeDMwbFdnU0lkd204?=
 =?utf-8?B?bU5oMWJaOFJNei9XSFpGL2NkOCt4VDFQRzRrWi85OWxibmZmM0VUU1ozUzNL?=
 =?utf-8?B?N3lnL3FNRTVBRGcxSmpyYVQxRUEwOUFqRmZ2dHNPWnNLWStkZko4NWRsaUNu?=
 =?utf-8?B?c3RlS2JTWmRyM0lBd3YzeXFjVDlhRW15ZG1LRVk2VitYdmQ3alFrbGNEc1Jz?=
 =?utf-8?B?d0NqUTV5NHh0YlZNams0N2ZzWGI0WUlpOWUwV3YrcWpTNElaTGg1UTBKaHVu?=
 =?utf-8?Q?uavfcEq0ydLEMo22ycUbAHN6mkax6IdYgzhRs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVJ6Q0VwVlRqWTFzNU1MdUlveWxqSVhjckJhdFdLNFcwbC82b2J5Z3J5V1Bo?=
 =?utf-8?B?eDVwblM2UDBJVEMxamlQeDNqZk5LUnJyRFJYcXBWU3p4WUpubU9nVWpDR0hv?=
 =?utf-8?B?b3pqR1ZmU3FDMURUL0NaNE5SK0RHN1pGQVlDakR1SHUxNzhFbFZ4VzgwNDZL?=
 =?utf-8?B?T2NtZ2F3OGFzS012UXlRcWU5eTVNSWZCTjU4S0Fib05IcTNhNk05TU5vbGts?=
 =?utf-8?B?c0tzWUczOElyU2EzdzRINDBEc2lJMXo5ZmZHRVlabkFGWlV0RHRNQ2hyZmMz?=
 =?utf-8?B?cU5jRVI1azkvUUZ6UVIyUFZjbFN3Qmx3N0w3TWgxY01BTGtPMWNrYUdyT3E1?=
 =?utf-8?B?d25XdVNrNldkSjVCdlNPQ0JoSWxqdVBCVFIwaTBLZ28zZnFzUzFLT2Z5OVRp?=
 =?utf-8?B?U3RzcElOb1NQSm14Q0hsZVQxWElrY2RvOUFkWjE2WmJsTkN1b0FEMWVCdEZG?=
 =?utf-8?B?QlZYdEx6QmF5UzZmY1VPSGN4MGlWUzhRcUs1NjhyWTUrbmF4T3F2ak84S3FU?=
 =?utf-8?B?RE0weXBCN0Vkb1pBeWFJK3JieWdhQkNVUU5ocWZBQ0dSUjNCdmRYMkhYbUdE?=
 =?utf-8?B?dzVQR292WWtyVFdPdTBkYzAzd1BleFlNc3k2V1NKSkNGUFlSczQ3MElpMXE2?=
 =?utf-8?B?emUyY0JEM0VDQ20yOCtmbGc2ZllmQnN4QmQ4SzJIVFZ0aElXSk9MSjZKSSsz?=
 =?utf-8?B?Znh1M1dDYlFpVGxETlp3UGRoVXR1WGVxM3lWRGJjNnhBUDVJckpnOWdjdlZa?=
 =?utf-8?B?OENHWUF6bVB0TWQ3MlNzV3IzeGxXeWhBdzRpVW56V2tCWlFKNS9FMHdlOGZ2?=
 =?utf-8?B?YmVsWkQvOTNFbElyU2hJZWtIUlZiNmg4ZzZXV2xTbnRVZU11cGQ3NFpyMTlx?=
 =?utf-8?B?TmtabG1qSHFUb3MzUFQrOFBwT1JOZ3dsNlRzdkpKT25Tc0x2UXdSMkUyZ3VF?=
 =?utf-8?B?cFBITzVVL2RIM3ZoRUpuOFFxQ09lTEtYSzdUNm80UGwwblNhZ3NvYnI1RzBC?=
 =?utf-8?B?a3VZNkRjNG5pK0JtQkdybmtUZFcwT0ViQS9sMit1cVZNU1RBR0d2dzIvRlo3?=
 =?utf-8?B?WFNLTU5CcVl4RVAwNzJoajhmWG5kdTBadmpQN3JyT0gxL2U2Qzg1OXBORXo4?=
 =?utf-8?B?Y05nRHd6TG5EMHN6VUxsZWpWeHlES3RkajdsVzZ3WHVEUlZxdlRNdDFYY2Nj?=
 =?utf-8?B?VUxGRm5VRTFOOENleUZyZ3RZL3grVUdlb3VaRnZ3SEtLNkZoUmUrZW5JQm5H?=
 =?utf-8?B?eC9aWFVBNXk2NHdtZUs2dCtHTDVZSGNNRzRpVG1TclJzR0w5MmNKQkZXaSs5?=
 =?utf-8?B?Qm94bDNpV0JCMU9OSkNhdWdWd3NpQitNUjdJRnZ2YU9NSW9ReXg4VFdBQ0wx?=
 =?utf-8?B?NWM5Y1ljUVZYOTZSNnpseDlDblBYKzk3SVlXdVp2OVJlajRBTzdkYk00WmN3?=
 =?utf-8?B?dUZzMVFwb0lxaHdyWlE5ejlEdnpPYmFNQnErckZoUkZhR2ZENlJ1c05SUmZS?=
 =?utf-8?B?RDA2MytMWWwvN2xLTjdRMG9sdjRLK3N4U3NmWmFQMittVkExWEpVVzlPNjBk?=
 =?utf-8?B?YWxZbWoreDJYUkZYWkFMRGN2WFRXZVhYZ2ZobnVXMERlUC9yaE93am5QUGZK?=
 =?utf-8?B?cnVlRENZc2ZRbXRESG52M3VpbGwydDdtQ0gxNkRqS0txd1lLS0M5Q3hSQnlS?=
 =?utf-8?B?cHdRT2NEV2dhaXN5dXVZblF1UkNhaldNUUswRzdveS9mYUVLeTJlTTlWbFVr?=
 =?utf-8?B?WDh5V0RBZEgvRi9CZURUZitXTEVnNFBVY2tXb2h3ZEt3M1BUYlE2UzY2cVNl?=
 =?utf-8?B?aGJxMlV4RCtiZ3JGVkZqVFVXeG5PMC9OYkU2YTcvNW8rT1dWUnlDNWZGVDFV?=
 =?utf-8?B?UHlYREhnUHZKRFJ3K2ZnMmRLSFZRNVlRdTM5QUt5Y2RSRWV0YzV6dmZPUitM?=
 =?utf-8?B?UUlFeUZrZ1JNbGJEaWZZN3dNTC9OelFWcEN6UDNYRHFRUTVzTGFzeTBQQnBp?=
 =?utf-8?B?Mzl1RFJkY1JhZ0I5QjQ2SjdqWUEwclFVT0psNEgyc2tuS05Wd2xVc0lMK2Vp?=
 =?utf-8?B?aTZhOGVVTDJKOE9jby9qUlRxV05EWnBwbXEwSGloNFFpWlpSNkxrWWNzR0tD?=
 =?utf-8?Q?Zl1RO7Zmw8CvB4jseWzZ1yGCn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5a4f6f-30d6-40d1-fe64-08dcb000ada1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 19:00:14.0137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTVT/pZaVLvlsVkBJXMJGslP47lk8BTgGxgofPAyRDQjes8zX7DnXkdC/zLn56j7FTm9YUbdhzmK7w7IczJ+ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9590

fsl,ls2080a-pcie actual is the same as fsl,ls2085a-pcie. Only keep one is
enough, so remove "fsl,ls2085a-pcie" to fix below warnings.

arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: pcie@3400000: compatible: ['fsl,ls2080a-pcie', 'fsl,ls2085a-pcie'] is too long
	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 3213a8fe0b3b4..d9ce0fbda1e1b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -1076,7 +1076,7 @@ QORIQ_CLK_PLL_DIV(4)>,
 		};
 
 		pcie1: pcie@3400000 {
-			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
+			compatible = "fsl,ls2080a-pcie";
 			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "intr";
@@ -1098,7 +1098,7 @@ pcie1: pcie@3400000 {
 		};
 
 		pcie2: pcie@3500000 {
-			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
+			compatible = "fsl,ls2080a-pcie";
 			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "intr";
@@ -1120,7 +1120,7 @@ pcie2: pcie@3500000 {
 		};
 
 		pcie3: pcie@3600000 {
-			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
+			compatible = "fsl,ls2080a-pcie";
 			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "intr";
@@ -1142,7 +1142,7 @@ pcie3: pcie@3600000 {
 		};
 
 		pcie4: pcie@3700000 {
-			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
+			compatible = "fsl,ls2080a-pcie";
 			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "intr";

-- 
2.34.1


