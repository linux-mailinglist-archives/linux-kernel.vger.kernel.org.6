Return-Path: <linux-kernel+bounces-518778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8554DA3946E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4D81893C01
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A2C22A818;
	Tue, 18 Feb 2025 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="P7DqhOCw"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021094.outbound.protection.outlook.com [52.101.70.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D411A9B3B;
	Tue, 18 Feb 2025 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739865751; cv=fail; b=Zx6XKhOr+n998LVO1YOv1Elyp9trzNfGEqdENfQ0hirpfrp2ZtRnJ7j/95VEiSoNfqw/ZV32A1E0ksEoblV18vvWb0tMHCGqsxoJVgqMjDup+uurPJF0ydSpG/8s+wzVw/VxwsadQgBxVhoDzhDv306h5zZUjafJsFhrv3k3hE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739865751; c=relaxed/simple;
	bh=whRPazCScWRDXiPxjgXvwkv9wS9tYp0RaxkwtoB4pcM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AjxLo3sD2x8sNF6II8ykjcEc/QnmiqiamzxNFWZ5eJkaHZbcjiyB8ecitkRYgih6fu5AvvMHC5dLt0zmgYi4j/wb/gkhqnmvm6Lk+5RszUey09J8EKG1MXDlcsaBTr/QQf2Cm+a5edL7Zig+A+c/MPgwp+NcqQhoUFWF06laF1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=P7DqhOCw; arc=fail smtp.client-ip=52.101.70.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E15IvaRgYrKtsC3W4VGJKcngl+rXVef8RcBz3peLaYqdF/HG3lGRVQPL9FEziQ1/EwgK4iVvCMKNDlyFgdQahcJReNvVH4LQjwbhCUB5yFoJEATa7Q+hVzCDIpLysjM2eDSoinUPvdYTcex23FOVAUrYvSssUVLBsoxmDasYy06ltS1HDhqpWMkQWEb65eH7XFHfzE7BQDV4z6n9c6GnbUIluWs/UvQq6HRj62jik+9ewPCfBaB2GDgwFqyXDCOtHxJ69CA4gR9IVpNllnZXvxVYMosWhYAkFU3Ca8Xx7Zp3GGzzZfo89U0mD8x7d/wcBmrhBP6dM9G52r9RWeUEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QL1h5W2sLB265QtvOv+TicgtNS59fK7YjeDfBspbdW4=;
 b=GYo/7+VIzjj4y8MLxAYHgMfWFs4C9L6Un9+eMYPkk7x2+le4rgknJCdbrTZBSIxE341cGULebben+rnSY8GJivUptfddDlsENVLmdMYIwLqHQachSoOmXa3vAqsugxJsD8h1j6yKHIU6Vd/3yYRHL5mHvyZouSag30r97fyj1AwLFL067IkGWcDlFQuwevU8bre8RZj8pXNS3hlP+Xw0g1dCiAcxdezTRUlYvHvb+IF33GPTOMDXvaUn83RBEfXl7j7JZguug7rfY/nrTj9ukr5jpSVgEbNCF59PEmHkTkyjBQh3R+WH0WaZDBBqWC6Cdk94SjGoG4H2drrra4YX/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QL1h5W2sLB265QtvOv+TicgtNS59fK7YjeDfBspbdW4=;
 b=P7DqhOCwnLyEprsh4v3rGGR4rRyx8pvFWNkIVI3C8wTxkpSOFkDzOBtQIhsU1VpYqeo+fxPNPhwBcSrduXnfH/inRRbsbQBS+z6PigH7RsuUNVolGqgwFgRluMFp4DtETs/D0GA1f1v0bKy7zB/dt5Jz9tsMNnRE3u2IvPsTgN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by GV1PR10MB8735.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.12; Tue, 18 Feb
 2025 08:02:21 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8466.009; Tue, 18 Feb 2025
 08:02:20 +0000
Message-ID: <bb1810fb-aa27-42d8-8aa1-c9ae7782d900@kontron.de>
Date: Tue, 18 Feb 2025 09:02:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v3 0/9] Use correct LDO5 control registers for
 PCA9450
To: Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Marek Vasut <marex@denx.de>, Conor Dooley <conor@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Robin Gong <yibin.gong@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Frieder Schrempf <frieder@fris.de>
Cc: Bo Liu <liubo03@inspur.com>, Conor Dooley <conor.dooley@microchip.com>,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Joy Zou <joy.zou@nxp.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20241218152842.97483-1-frieder@fris.de>
 <173861266637.674751.16665389874730608623.b4-ty@kernel.org>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <173861266637.674751.16665389874730608623.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR2P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::11) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|GV1PR10MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: dc96dc1a-7692-4e09-553c-08dd4ff291c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWhVS0dZeHBxaWFtQTRxUTlIY1V6VG1CSU9VcGxlVTN2eGdGMitnUmx1Uk8r?=
 =?utf-8?B?VkdORGFSaGYrckFDYVluYVNFRTcwWSszNTJrZ0pJdFhGSHgwY1Q1aUUvZjVF?=
 =?utf-8?B?UEpVZUVtdWU2YjNYbUxQanR1blhMZWRJQ0ZCaGN4bjg5aUpFWFBnMVRpbnZU?=
 =?utf-8?B?ZU56NHQ1UmVKemE3c09hS041QmY5ZHVVdVVXeStYMUZYTGdycUlnNWdUUTBu?=
 =?utf-8?B?SlRXdXZnRkwwRnl4KzZuODZPeTRXTkxsWTJiWEFVaVFQMmxqc2NuZktqUFc1?=
 =?utf-8?B?aHFsNlJDa0dsNklmSGdkbUpHTHEzYzVnZkdDUEQyMzBiZndWdENTT3BEUkFx?=
 =?utf-8?B?SGJrams5Wi9BYm95ZFBwWHlkTjZEWUxhUUlVMzNzMlZJQUJKR0VRb2tjRENj?=
 =?utf-8?B?Vmp4ZlV0YW8yek9aWTNDT3JabnorSWZuV3RaYmgvQ2tZYjR0ZlRRZ0txcHZE?=
 =?utf-8?B?UUcrdDltcWM4ZU5JZXlHY25WaHQ5M2pnZjdCMC90cS9TeWV4YVdFNE93RXYv?=
 =?utf-8?B?MjViU0VMcVp3RVVtcGRDYlo0Q25abFZHOVl0eHJ6ZXhyZUVmMkJTMkVXRzY1?=
 =?utf-8?B?LzI0UldUcE1JTzlkWkNoYXk4K1VnamMybWw5K2NFcTJybDVURndEMFk4YXpT?=
 =?utf-8?B?SmEvY3VHNnRHOTVvbWR4Zi9JZHlqcnZueVROZVM2OTVjb2RDRnNsWGdjWkhW?=
 =?utf-8?B?VWpnaVh1Wm92ZXY3Vk5aaytvZzh5L0pCV0Y2R3FDYndzZkt3SU5qbGRMNzAx?=
 =?utf-8?B?eTVCMGlqTG00VmFYREhsbHdLTXRTOE1ySWtFa1BtbU1wUUhXeklieUZIUGNU?=
 =?utf-8?B?amo4SGlOYm9aakR5RElHQkk5T3dLb1FCQjhLMGE2dk12Q2g3cm91eVQycGI2?=
 =?utf-8?B?ZnhjZGYwbmpFL0RpWFRxbE5NOWpSekJ6OUE3SW83MWhRRFlNbm9JYmJDRE02?=
 =?utf-8?B?TTJpY01wcTFCbHlSQUpLUE1WTUhaUzJTeTE0dlFLUE45RUQxVkV2d0Q0Mmk3?=
 =?utf-8?B?QVZYOGIyMzVoRW43N2s2WDFoZCtDSGhNSE9rVHE0UjByWVgyb2Mzcm9hQURW?=
 =?utf-8?B?Y1RwTS8xaGxOeDlGdnFKY3VDVkV1YlRsVS9kanRFQWhlaHdSbEZkMmxTcVpZ?=
 =?utf-8?B?R2NnY0xXMmhQbFBLYm14WWhNRmJLalZkQzVEdFpzalYvWVNMMWZ6RFQ4SmxD?=
 =?utf-8?B?YVI2SDZXay9ndUVVRmZIVGJReFpJY2s3RWtSWkJIYUdaM2sweVF2SmNqbXlk?=
 =?utf-8?B?aXhCS3pJdDZHcGIxSi9UeUJ0SEhaSHY3K2g3dUZqdUx4Y1h0WGRnWGRCSEFN?=
 =?utf-8?B?RWJiS09BcWhGREVOY29XeUFWQXVPU0pRN0FmVmhwemlnSEIyZlBaSzY3cWZU?=
 =?utf-8?B?bW5BM2gwRk1nQjdEK3hqbG0wZWY0NExwc01NZ1Z5c3kwVWlDQjVqMXNPVFJQ?=
 =?utf-8?B?cmZhaFgvc1lHQS9zT1M5MUlRQUVmY2hkRjdrNE11T2xDOTJ2allWS0ZkbEM0?=
 =?utf-8?B?TGs4UVNKb2JIZHUzN1I0UUk0aWI3dlBBVkI0YlVla1ZxUGMzMmpTdGpzRGNw?=
 =?utf-8?B?NTdCNnUzRUNoTWxBWE1sRDl0Rm50MkRrd2VwKzlQZzd1bDgvUWlZNE9Cb3Zo?=
 =?utf-8?B?ZzdaT1R2alhjNGRNL2tJR0hHZks2RXdScHl0UzEwOWVVeHFhRHJoMVl4bGNV?=
 =?utf-8?B?bUlIUnJCQXpQSUdWRTdQZHBWb3Zwd0IvZHRpVVNEMGdiWThQam1JMmt0R0Vs?=
 =?utf-8?B?YVAzMXBzUWpSN1ZGV2t0TDY5MWdxZU5RczVXUmIydWF1WEpjQ1FQTnREc0dM?=
 =?utf-8?B?dTZKQ0N2bUQwUGRVRXNlMVBMdXpYSGF4UU52VFJEK28wcjFLWTZZN0lIZEFI?=
 =?utf-8?B?ZWJsd3Y5SHZwbjNEaUp5Z3JoZnBrci9yS1FNNUlvSWJ2ckxZVXhWdk1RK0Ey?=
 =?utf-8?Q?emsMufomZuU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VCtXM2UwNklidnN0RVlJZzdSQUM5WW9FZFl3ZEoyVUJZU05hZ01vRHphdjdo?=
 =?utf-8?B?M1NZYTdaYXFHS3hHSnk2NkZZY01YZWc4WGJCNUNDRDdLSzBabG9wL0xHd3Fs?=
 =?utf-8?B?VUJVQS9rVEVDWW5vdDZlcUduMSs3a0tpV2hreXZmUk4yVXJqNk15YjJ1alhq?=
 =?utf-8?B?UlpvVzM0RGdzUWJFMWR6Z1B0Z1VDK1o5TWJDYStrQnRFQXFQSm5UR2RRd2Ro?=
 =?utf-8?B?YmVNN0JydlZuU2dtSVdhelJYV0VHaU5NVlM3a0p5dFlycGo3UDVDQm93K2Vn?=
 =?utf-8?B?dFN0M0VLbHBsK0tHTlpncHkyeGtmbjRwcGRjT2htNTNkdTdmbVZJTDRNWEFT?=
 =?utf-8?B?cTVsR0s5VUpXRWJLWVIwcHdDYlpuZ29tVDlSV3Zya1hyd2xCTUdFUXlMQzB2?=
 =?utf-8?B?dzkwVWRTZGx0ZjJCZCtuSTRzQW1OUW1LTDFZY0dNcjJJcWV5a2xRUTVCcUN0?=
 =?utf-8?B?MWtMSkxPOTAzbmpPU1NkbnJOVDVpeFVQaGorTFEveHNnWDJZRmdEczBTa1Vh?=
 =?utf-8?B?REM1d2RUb3ViUGJiaU92SWxKeWUyYjl0YmNGUHFZWWIvU0RpWVdXYjI4MDFD?=
 =?utf-8?B?ZkNoS3pWQVZmNE0xbitLWUpZczEwVUp0Q25ETkl0Sy92Z3R0YXhDZWJPeVVl?=
 =?utf-8?B?R2ViU2hOYVBzbmpEd0kvQUFiSVpLMVNpWm1Ub05QTmZJOTV2WDVRSUhwRmlC?=
 =?utf-8?B?VTUrckNtZ0lCd01oVUlvOUdoaW5IakJFdURxanNqc1FjNWRyRmZ5STNtUm16?=
 =?utf-8?B?dzRqejFOT2YwWTBnQUd5bTlITDYzS1pPNmpzZEUzQUVJYzVBMGliY1FTVDV3?=
 =?utf-8?B?OVd4b0NXK0Jub3ozdTJWNmpzY3lxTit6WjNUa09oQ2pDK1F6S1VFWCtLZXRS?=
 =?utf-8?B?TWIwdWdIdFNOT3JKUDhTaVM1anRMR3I3ZlJsQ2dwVHpMeXRLbzgwUzN4djRa?=
 =?utf-8?B?R1JlTTB5QjZURi9MVmdOaVlXSnM4ZXUycHV0Z1V0VHI1ZXd0RDNTSXpScGVZ?=
 =?utf-8?B?RzNOMGtjNU4rV0JIMXZjdFZoMlZmY015WFlId2NyVzNWbGZVUHFwdlphclM1?=
 =?utf-8?B?U2FYL0tJKzlZQlZISGtyY1lxQ3V0UnhrekZwY0phYVlLdDU4eXVNZ3VPRzNI?=
 =?utf-8?B?SkhJWkVLNGNNNTlLWWUweWJiM1RybXRUMXJNVkoyeTJoQjlDcjhvQWtTeUJU?=
 =?utf-8?B?KzdMUG5DRktYR0hadGJHUnVJczBrTTA2aXkwb1VxS01mZDY5VzkzZ1E2aTV5?=
 =?utf-8?B?K3RUZFJpSEtCYzZxVkZSaklwbkgrM2RZc1FKUkNmdGVLYTVObXVQcU9UdHZl?=
 =?utf-8?B?dTBmYmxkWTJhU1NFQ3RINld6Yis2NkRMMit1UGdoOUs5SjBhS0VoY3IwOHZ5?=
 =?utf-8?B?N2ZvTkNIeTQ1WkVncEdBbjBINFhNbGk2bjl6c2t3SkFpV1VSRnJFanQ1ZUQv?=
 =?utf-8?B?U3dnWlRBUk1vMmVNL0Njb2dZOTVhc0NlM2VVNVJoUTJKNEMyQVhKZ0xCMkh0?=
 =?utf-8?B?K1VacFB5RjNFbzBFZERubU0yd25kUndweHZod1dhMVpwdlBJdi9lOXRPcmxh?=
 =?utf-8?B?Y25NSjU5VllkMUtzWXh2QlVDTjFFSE52bWpEQUxrTFRLeWxRd0t6NlNISTNN?=
 =?utf-8?B?c1hTVmlUOHNaTHh4WE41ZXFTOUcxK0xVQlNMUGZkV3pvQmtLZEppWWxhVVcz?=
 =?utf-8?B?cFJFZHBXV21ITmtkczVuemJxczBJSVhuRkxNT3FKMTZLZDhjN0lMb1dlY2dO?=
 =?utf-8?B?cm9zd1FTUWV3UVhrVVVRZjJ5S1E5UlU3Z3hrNkhBNjFsZkFHTnBhSC9vTWdS?=
 =?utf-8?B?U01kalpTbUdKYWx0YUNqU2JQcXhTejMzWVZrODV5OFBDT0pURGVFQmpjeGdO?=
 =?utf-8?B?ZEt4S0dMa1RHR2M5NkNSN2NtQUwzSlVKQzVxUWgyU3RUdEtEZUNINGFWdFZr?=
 =?utf-8?B?UjVPc05mWUhEV0tsRXZ5RExzMVZsb1VMeTVITnJXb2c2YW9XOVVzY2tEc05K?=
 =?utf-8?B?anJoQnZPMSs4aXF3WTVmMnJ0N0F1bWVVMUkybnEveFFPdkVuK2ZVRThDWUQv?=
 =?utf-8?B?enZJK1RPazRKOUNkU0tJajR6SFdaQUJoQy9VSEtsci9lVFRodUpFSkpOTXJo?=
 =?utf-8?B?TjVGRVNXQyt6bDNXZXRIR3RPUWdtWkc2R2pKTFFBbTc2Vjg4Y0grQXNvdlAr?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dc96dc1a-7692-4e09-553c-08dd4ff291c8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 08:02:20.7362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dzRJiFbzRiPrRN++KDbnFFslwNArn8/WLXfIIhZ52IL5W9DyzMGhmbYg3k4uNtC+KL+sh8ajvrwvCV56RYwQXGc6/4+dQJTk3lQPYSASgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8735

Hi Mark,

On 03.02.25 8:57 PM, Mark Brown wrote:
> On Wed, 18 Dec 2024 16:27:23 +0100, Frieder Schrempf wrote:
>> This is a follow-up of [1].
>>
>> The main objective of this is to fix the PCA9450 driver to
>> use the correct control register for the LDO5 regulator.
>>
>> Currently the control register to use for LDO5 is hardcoded to
>> LDO5CTRL_H. This is wrong for two reasons:
>>
>> [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
> 
> Thanks!
> 
> [1/9] dt-bindings: regulator: pca9450: Add properties for handling LDO5
>       commit: f9cbf56b0a1966d977df87d15a5bdbff2c342062
> [2/9] arm64: dts: imx8mp-skov-reva: Use hardware signal for SD card VSELECT
>       commit: b5ec74c2aec76fbdff9bc16951455602e11902bf
> [3/9] Revert "regulator: pca9450: Add SD_VSEL GPIO for LDO5"
>       commit: c73be62caabbec6629689c705aea65e5ce364d5d
> [4/9] regulator: pca9450: Fix control register for LDO5
>       commit: 3ce6f4f943ddd9edc03e450a2a0d89cb025b165b
> [5/9] regulator: pca9450: Fix enable register for LDO5
>       commit: f5aab0438ef17f01c5ecd25e61ae6a03f82a4586
> 

Thanks for picking up these patches. Meanwhile Shawn has applied patch 2
and 7-9 on his side. What about patch 6? Is there a specific reason why
this was left out?

Thanks
Frieder


