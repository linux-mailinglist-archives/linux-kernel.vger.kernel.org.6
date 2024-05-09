Return-Path: <linux-kernel+bounces-174411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FD98C0E60
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2B71F23985
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA9F13049F;
	Thu,  9 May 2024 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="YjoEr1Ti"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2134.outbound.protection.outlook.com [40.107.13.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B982312F38B;
	Thu,  9 May 2024 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251579; cv=fail; b=T9fEyOMlKMonX0HHc/eqAScRGVKxb9FBDWniKrRbVB8UvXkxw/ruj3GUVP+WseiYOm6Z0OCNZzdLhSMniYb8/s9YWRtrpAfUDwdX3rb5tf09ghgTiaGttwS8bc3q5SQ7ThjdEtpgdsPVi8z4C0FIvP4XpPPdJAdVEAHOjCKMtEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251579; c=relaxed/simple;
	bh=b8RRYkGEQQBgiHggilltq3EMAdIEtY73z5O4eNkXSMY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=AweKKO2EkBXC6PYoh29XLn8sO3pE3DNrI5vWMHeQRz73XOqF1r+jEYUsSOUazt3070RlsRkqfVBgGu8k8Zu/QydwJ13nmQCYHD3QzPL1D92uf11Jg6/bT8rpMHE2idp1AIpOe+EYqRMzcs8yObcvcKlpL3bF43Oyw2Ou1Z2KstA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=YjoEr1Ti; arc=fail smtp.client-ip=40.107.13.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmOh2GPYxtf6gP0ozJFqZCDlObHOpt4XFktfkLw+3Av6oaRC3EwsG/Pg9Z9PYRaf2XV3DUVrXlvRcWZpaFfTJUob5CDt5ZGqu4LUtbsCLrXQogFA6+cMy8rReKamU2yaCr2rbp6oJJ5dkAgKgOUdX4VwZkdHZ2QjIvGTfNCiw4ck3Sxr/s6mPR9suk04IO8uqtpv69kVGt/Wz1yhmJFCKYTFLQrR2lNMX00tCZjwKFLE8QT97SbBoyr40z+ibLMzskZy0bsjSnov2nGE2Vc+jYmq5PRlSGTMnGUxdutk2oyhVZhmwJdtBxWfMb2iviexZTK02b6RI1Dz70kPoBF6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmiADlC8ioo0VCKKjwAOBI4dfWzXYCuUryn35rYQOaA=;
 b=nO+KI1pEzo7+M5b83wPO+dAw0Mf2mUVfE5wR5D17Rn11kexI5kM6//lk4F8YqGZ8y7nJNKF9iFQbmN82h7misdpkdctUlOum6H991FUOCh2OYzoeyWa4s2yNOdmnVVwttwgEUhRE+PYgY+nHiJsciczzqCj+yeXr5G7Z/C2CmCmS1Bd3vj+8hd/F3RdE4k+EF8OUgCMmuYHN+vaEKjLWK9ySqIqWjcbloD+PJyz1otgERn1tcg22JNCfeJ/nFWOCBhZcngDbSR1nYRaz5Mu6AQvv10B7Qjatv7RR+wZLcachqPhEWZlqQtiu23TTQ8sT6LD9zS9+eLHr9A7PjCNNkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmiADlC8ioo0VCKKjwAOBI4dfWzXYCuUryn35rYQOaA=;
 b=YjoEr1Tij4BuiKtlvht6y1T3XW+jgoMnm2yqflZwai6Vxd1qZZfmhFqx1VF08b9pH8d3czayjnYDf0b5uXvmLiG37d/0ae9gd+S3mJ0P2CFwzrWE8eQUVUBeEAjhZXFpe24By7QIeQoI98CZ8kI9G7brDkBGRXEGYTK/abTAKcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DBBPR04MB7612.eurprd04.prod.outlook.com (2603:10a6:10:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 10:46:10 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7544.045; Thu, 9 May 2024
 10:46:10 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v5 0/4] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Date: Thu, 09 May 2024 12:46:04 +0200
Message-Id: <20240509-cn9130-som-v5-0-95493eb5c79d@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGypPGYC/23MwWrDMAzG8VcpPs9Fkp3a2WnvMXbQbKU1rHGxt
 7BR8u5zSqFNKTp9gt//rKqUJFW9bs6qyJRqymMb3ctGhQOPe9Eptq0IyIJBr8PYowFd81F768X
 vOHwCB9XAqciQfi+x94+2D6l+5/J3aU+4fK8ZwvvMhBq0Q0RybKFneav5K0VdfsZtyEe1pCa68
 XYrTo0bHoioDy5SfMbNHcc1NwvvgHcuWivAz7i98Q5oxW3jwCQ0YHAQ/SOf5/kfBV+GSGUBAAA
 =
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::13) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DBBPR04MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 17835996-7631-4df9-5c50-08dc70153cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|7416005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnZBaDdkdWdTZElRUlRKSjN0MVpOdmJpWkhNeFA1OXVBbk9tNXB2aXM2SnZu?=
 =?utf-8?B?dEJ1QktZY3RTWnV2aEU5Qm1zVHVUeFIwdEEzY25ONit2RjAwOVEza2ZzU2dL?=
 =?utf-8?B?TTZQY1NMMXhlbmpWajdFRTYxK29FMXJZbDhtWm9xeFBQOGRDMGREK29VQktN?=
 =?utf-8?B?VTdjVitVbVRXd1pDTjJPRkYwZ3RDdGdMSi9JL1BJZkVaMHN2MjJYTEhCS3NR?=
 =?utf-8?B?REk5WnBYR3IwakRMc3U0ZFJMeWc4MkRsa08wREhIQTJNemJ6c0tPcUlMZ01O?=
 =?utf-8?B?dUtDUGo5ZVRUMjhmOGZ5TnQ1OXhlcmt1dTJqay9EYkp5bFlJRDk5R1Z4dkFq?=
 =?utf-8?B?QiszYzhJb0JPZHR0bytuYlF3TktQZHo1SGlvbDdjVEcvc1dtbXRXQUxncDEx?=
 =?utf-8?B?MnJOV0ZWaTRPbVRPRjk1SG02SjBqNmMxZm5HcndWVm0rOXFvMHNMRHcyZHVj?=
 =?utf-8?B?SVFZL1RpbmRrV0ZnajFWaE0yaWZKWHNvVU5nYnFpV1JPdlNPbTZROTdsSG8v?=
 =?utf-8?B?ODZqbnBpZll4eHZOLzJPNmc1dXJ5SHVOQnNjL2xoVU1kbVJQVGMwejdDTEZI?=
 =?utf-8?B?NHN1S3dweDRBRm55cmk0d1hsUDdOQjFsOUZ6MjFYWkl0K0M5Y3hhbk5kUTVv?=
 =?utf-8?B?bnBIV3hKWUFaU1ZGOVZEaVY5QVFwM2hWN0l1KzZObXE1eit2eVBVeEVTNERm?=
 =?utf-8?B?UEdnNkcyY01JZ3p5Ykh1aUU4T3VSWEFRNTBieFRxdkdzZzI0Z2dEMVRrTVB1?=
 =?utf-8?B?dTVmd0FNcjJLSGN5OGtNS3VJT0FiNnRyVUVybVdaNDhDSzlNblhLQ0F2eHNM?=
 =?utf-8?B?aTNVS2MxeTVHdDZYc0xnb0crUlBiMitDaHJESmNTQjlXZ2hEcjhXVUQwRWtY?=
 =?utf-8?B?WDVhNEZRVGRNWTBtMlAwdlpRei9RZjdrMERnbTQ4VGd3Q2hMMG9HQjI2ZG1s?=
 =?utf-8?B?bk4yNWlYQlZTMDVqcGFaV0ZhR0ozYXR5aTNSKytDbFBQTUhTeUFDbDljUnNN?=
 =?utf-8?B?QUZKQ2tvc2g3eU1lTVNNaTYzbFNjTE5MaXZKaXd5Z3IxQkJidE5SNld2bUxX?=
 =?utf-8?B?RWhZMWc2VEJua3RreGgrODlXRXNSLzFVN1o2djhLNkRMaUZodGJzWVQrRkt3?=
 =?utf-8?B?RHlIYk1yZm44bnIxY3NJVWJlWGt3QVZDM1ZMR2w1eUIyQnIvU0FpMTRxMzMr?=
 =?utf-8?B?RGhoY1NiQ3d3Wk1hQytjQnMxYU55RTN5VEVwRkM3dnJ3WU14K0VsdVF1L3Ey?=
 =?utf-8?B?WkxkK21aQU9XVnVmL2ZzckxaZTNVZzJEQVEvdW1ZTktzTmJGYUVyY05QYjl4?=
 =?utf-8?B?MEtQaE9vdFNkVnFscFZKMjNGdzdVdHRsazVTbFF2UVdVeWc0TldjQldGM3FL?=
 =?utf-8?B?M3RpbW40ZENKS0w3SGg3K2RuQlM4cklQSC9nS2duSzNyajJTSFdQN25yQzQ5?=
 =?utf-8?B?aFkzQ05NTmd0Z2UwZGFEbFpTMFJSMTFPb2tMSUtCMW1WUUxQVGIyUjRXbFpq?=
 =?utf-8?B?M0srS1lUNjhHTzZBc0Q1MXo3Q3NuNFJHVlpTc1BPREpoZHZWY09kQThJNkxB?=
 =?utf-8?B?STNscEtwSkRuTTJyMm9aQWRTSnhSREFBRWY1U2thM1RlaEppdmJUZXRJWitr?=
 =?utf-8?B?QmFqYzlUWTRocHVYcGYzWjJnNDU1MnBCL2htaTdhM25jQnJJaWdRLy9PbUFO?=
 =?utf-8?B?aXMxQngzeUdNTVFFYTNpd0MwV3R3cEhtaXFOUlNvRkFlejZOU0hKU1J3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K25SUitYYUFDZUtoOUx2K3hCRDdicnBmaERlazQzK29tMTE4blhEa1RBRXJJ?=
 =?utf-8?B?MTZGTWpDU1FNeFVDWlFtbDNoUVlWdDFobEFrdUpWdEx5V0V1MDRaNEZQOHZM?=
 =?utf-8?B?RnNiYTZpUEJvRnVaVDJrWThhdGNHby8zU0RVU2pvVkhnSzBMaytpaDJIYWh0?=
 =?utf-8?B?ejdOejJFa2U0cjRVTVRYYitMZnpPdWZBMTVWUW9OOGR6QzFVM3pUVEhaZVYx?=
 =?utf-8?B?VU9EYVZrWkNmYkZKZ2JocEdna1E2NVBCTndWQUtvVkFzZGxDZitCMGRjNC81?=
 =?utf-8?B?SlovN3RLdCtlU2FSaDVDVEpUWk1kYkZ1TUhWZkZMbXY3Vm5XbytTMGpyTlIr?=
 =?utf-8?B?Rjh5Y3c2UmsrN05yMGhvWEFCenZaU3BBd3VsdXdoS284M3lKTmgwSmhvSkhI?=
 =?utf-8?B?NjU1aXhmcThwV01LaUNEWllwZGNPR3FPeU0vMTdvdHQzNFVHbTdXRXZHVjNx?=
 =?utf-8?B?N0o3TE9XZTNHRjJWVVRKS2xBcFNBRU1CTnhFa3huWWpKYnRtV210b0NacnVX?=
 =?utf-8?B?TWlOTFUrSjQ5K3JDM0l6T3BUZ1JkNTAyRXVpL2Qra3NWTnZ1ODVBWHB4UU1j?=
 =?utf-8?B?YjJleW1WSkhsMTlTTXlTdEZXRENVdzMyb1MyNVhIREo5RkNMelRsaGN4Tmpo?=
 =?utf-8?B?ZFlZbUYyVjRQMFk0VHlWa2oxOFNoWUNSNDdOU1hkVXlacDlzZTRqY0k1L2JI?=
 =?utf-8?B?SWVaaU5FWm4yTEpCUlIycThta05EYmFZWThnaUlyNDEwUWpjeXMyaG1xRjhW?=
 =?utf-8?B?SnNoTlV4cTFTR1BvbWtPekZCVVhSdkdGY3B2UzM5dlRUOURoMkEycTZncFFK?=
 =?utf-8?B?eU9jS001UU9neDVwbWZhdWZqZSt2c0RFekFQc1BDYWlKNW5ncTkyenJHRkFk?=
 =?utf-8?B?T2FnOFo1ZWIrQ0ErMzQ2YVNINHliNDY0Q0ZVbWZOY01manJIK00rQlBLbC95?=
 =?utf-8?B?WTVBcUJUUlFydWZMLzdDOVRwSU5wYVV4MjNjKzJlakpOV3VzS0ZLUWtlWFpy?=
 =?utf-8?B?R2Q5YzdhdVhMS3RiVjl0S0lPQWIwYk9mOEhVcC9VOTExcC8xZjUwRzF2a3A2?=
 =?utf-8?B?Q0c0bW5CaVNvVnBNWkxKNEU3anRkRDF2S0QvdG9GK1BrR2hEQ051VWJCVWtm?=
 =?utf-8?B?SFNtSld6cm5iWmszTitFVFBsVjFXR2RlU0hSbDloNjdYTTJ1SDg1RWhITmE0?=
 =?utf-8?B?aFBCcUdieER4bzQxSmE4Z2FreGNHT1V0ejQ5djRLay8zbnpBY1BRYjFobWNs?=
 =?utf-8?B?ei9OY2MxNytqK3IrSWRLdk1HT2ZDSGY1SWFCc0J4OHhkcHdGUzN3L1pDNkZv?=
 =?utf-8?B?K2J2MVk0Q01zbElRTUJrdU1va0k4Yk5ROUlUNGd4eitBUlJhRjRQNUsvRXEx?=
 =?utf-8?B?NSswd2hvUVFZV0diZXRzMXNxZEpDZWlOb3ZIOUJ5TTV3aFM0T0VRVTcrekpY?=
 =?utf-8?B?bDVTQ2FjaWdURGVKYzNhWmMxL2R6Ymg2dkVHVjU1bGlINmhlQTRhREszNGVl?=
 =?utf-8?B?N3dvMTJCK0l6Lzd4c3RXTjVTYllMcklic2srZ0lSenE2OU80ZHAxaWw3N3FH?=
 =?utf-8?B?RVNkMTMxaXZlelZNa1NVWTc5bU1vY245bmVmTWJjR3VvVmlzYXUxTVlpclZm?=
 =?utf-8?B?RXlPaEVUd2hKTmlBWXZaNTRzeTl2cUdmNjQ4VnFSb3Fmek4xNFNpVDZPSEJn?=
 =?utf-8?B?SWtITzlBZ0tuekZXL3dmTzJTeWtGelpHZTdOYU8rODB6Yll3ejAyTTdGRXFO?=
 =?utf-8?B?L1RkOVhTdXB5MmhMM3dXQURMb04xSThhZjdTa2p3NnBuUnZGRm1zWmFQcEVz?=
 =?utf-8?B?ZCt6L2NBVkZCbnNoeHUrWkp3WVl1dHVtUE5tUElhUzM5NyttQVhyQmF0NHk3?=
 =?utf-8?B?SmpkbXpra1N1aFFEbUhQQzQ5aDhQb1NzOW53MDlYVFdDY055Mk8vNFlXcU8z?=
 =?utf-8?B?L1JiSzM4MzRQbVZqYWJmMjFZaUV1aFdQdk1TeHVvdW1la3ZnM1lEU3BTeGsy?=
 =?utf-8?B?b1B1NjlVU2g5cFB0M0dWRmUyb2JDaG0yOHN0SW0xSVBJbGc2UGlrRGhHbHNa?=
 =?utf-8?B?cDZITXBkWm8vYm9NWXlKaDdyY01oaFFKUWZwaUZ4bGc5Ym4rWXhzdVN3SURH?=
 =?utf-8?Q?CLNe5j36BuQjKps3dXoa5xXWA?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17835996-7631-4df9-5c50-08dc70153cff
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 10:46:10.0879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qimzCIDyFZgfDtAs4SfSJ3Da1OsEsWIip/EmL8t5T3XqLSus0cwE8qwus8CQpznO8/LfFHaQapIQZaJD+3X/8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7612

SolidRun CN9130 SoM is a mostly pin-comptible replacement for Armada 388
SoM used in Clearfog and Clearfog Pro boards.

1. Add new binding for compatible strings closely matching the original.

2. Add device-tree includes for SoM and carrier shared design.

3. Add device-tree for both Clearfog Base and Pro.

While dtbs_check is happy with LED descriptions behind dsa switch,
functionally they require supporting code by Andrew Lunn:
https://lore.kernel.org/r/20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch

NOTICE IN CASE ANYBODY WANTS TO SELF-UPGRADE:
CN9130 SoM has a different footprint from Armada 388 SoM.
Components on the carrier board below the SoM may collide causing
damage, such as on Clearfog Base.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v5:
- replaced *-gpio properties with preferred *-gpios
  (Reported-by: robh@kernel.org)
- removed fixed-regulator regulator-oc-protection-microamp properties
  This property is intended to set a configurable over-current limit to
  a particular value. The physical component however is not
  configurable, remove the property.
- kept all review tags since the changes were minor, hope that is okay
  with everybody.
- Link to v4: https://lore.kernel.org/r/20240502-cn9130-som-v4-0-0a2e2f1c70d8@solid-run.com

Changes in v4:
- Picked up reviewed-by tags by Andrew Lunn.
- fixed a typo and changed 3-line comment into single-line comment
  for clearfog-base/-pro dts, but kept review tags since change was
  minor.
- Updated SFP led labels to use "sfp?:colour" without "color" property,
  to avoid duplicate labels while reflecting they are each dual-colour.
- Link to v3: https://lore.kernel.org/r/20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com

Changes in v3:
- picked up acked-by for dt-bindings
- skipped acked-by for dts because additional changes were made:
  - moved legacy netdev aliases to carrier dts
  - fix status property style errors
  - add pinctrl for secondary spi chip-select on mikrobus header (& som)
  - specify spi bus frequency limits for som
- Added CN9131 SolidWAN board
- Link to v2: https://lore.kernel.org/r/20240404-cn9130-som-v2-0-3af2229c7d2d@solid-run.com

Changes in v2:
- rewrote dt bindings dropping unnecessary compatibles
  (Reported-By: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>)
- added bindings for two additional boards (cn9131/9132)
  support planned for the coming weeks, mostly serves
  illustrational purposes, to understand cn913x variants
- cf-pro: add description for LEDs behind DSA switch
- cf-base: add description for LEDs behind PHYs
  (Reported-By: Andrew Lunn <andrew@lunn.ch>)
- Link to v1: https://lore.kernel.org/r/20240321-cn9130-som-v1-0-711127a409ae@solid-run.com

---
Josua Mayer (4):
      dt-bindings: arm64: marvell: add solidrun cn9130 som based boards
      dt-bindings: arm64: marvell: add solidrun cn9132 CEX-7 evaluation board
      arm64: dts: add description for solidrun cn9130 som and clearfog boards
      arm64: dts: add description for solidrun cn9131 solidwan board

 .../bindings/arm/marvell/armada-7k-8k.yaml         |  18 +
 arch/arm64/boot/dts/marvell/Makefile               |   3 +
 arch/arm64/boot/dts/marvell/cn9130-cf-base.dts     | 178 ++++++
 arch/arm64/boot/dts/marvell/cn9130-cf-pro.dts      | 375 ++++++++++++
 arch/arm64/boot/dts/marvell/cn9130-cf.dtsi         | 197 +++++++
 arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi     | 160 +++++
 arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts | 641 +++++++++++++++++++++
 7 files changed, 1572 insertions(+)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240318-cn9130-som-848e86acb0ac

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


