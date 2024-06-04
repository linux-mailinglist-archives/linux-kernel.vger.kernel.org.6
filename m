Return-Path: <linux-kernel+bounces-201066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DD78FB8E6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8786B1F232F5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DA41487F4;
	Tue,  4 Jun 2024 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="oPVzuqQk"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2090.outbound.protection.outlook.com [40.107.15.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF40148314;
	Tue,  4 Jun 2024 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518513; cv=fail; b=OCFAeRt7u578Bs5uVY8iU+mErUrGY2QGdQ3tdKnDG1FBNJtobdg7nZjpYiKk4MUUAlOelY70wHxmTvmRX3O/s6XOJ1+SDoN/9KXCQQTT9P+jVMMpF0Dc0fM5+GciO3cQO3wLxJVfs9i0BLKAIsfcY50J/zvzs1zdC2xAx7xPMMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518513; c=relaxed/simple;
	bh=+XrGSfYMNdM0P0BF/aUwwpqKET1udtuH6ZwoXJ4Kw3Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=R3sFb/nklUKiQSW66fINojgrJNAskxX26MosoNnBNxlm6CPfkjCCF6v9BvYWjcSwlAdCGH66wDfIDr85fiMVjeqNFxLuRL8nbEyh7Xe+L2ucUB4WiyloHsCXYKz4G6z/ND9BvHOnte3J+alMi4yd9YxizwTQVM0kgGfnfeRrUNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=oPVzuqQk; arc=fail smtp.client-ip=40.107.15.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkYc6b0q4hV5hJFFLxdMwHVJ8sqB7gCwsx60dO9Bo/8v3+XMZ9MakUe6I7e26ZrYk/V8rgsO9E+tLmnZ8LDmdcxviF4wjinhLaw32ByqEt5Kd8EamFKJIES+u+M70Q/kX0RfsSlGpGlmikbzFJlP8BperlfRuwcOkM6MZ9OdcMeS41rxrIS6SX2P6dJipoH5N549xTaAdLBIN3iL6ZCkdkbTHFU/7E3ZIazXm0cBa+odlSJzXJuFa7DR8ex3eVbc0hAnXeACFGXxvVJL5z97xkOahzbxnPjRAP6DuOsCh7GSgMIMeZRyksSGxbqyvV1KYZgjpDTF3kZrYaSlXJGkwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=On0oVvcix4kz32EkquB9/gcU0H9k4vE/nZRTBC1fi4M=;
 b=BsQjM74xYGLR79AgOSYtiim1g2VfWfi4eKSaBt4mWpC/DkngGLfNAvTtkxAuE2Zn5o6l7ALzEiPmgaFMP8JHIf+Mu84gSONCAA/srk4jGNZ9n1kyW9f/41TeHuDtN6i4NKaYFFhtuLSDxdGmDrAglyNhphSeD//yfdN9QHiY35/d5F/nnqH/CRSoT7iBr1lCySYijSNdBO2M5Q/hjgnlDEHXMtEgV1T/yD5xHusPVPyvCITu+OOp8pdAPJsjMUeaAU3amWYqZ2GlwnZJsPh5LYD+u5vVBUvE/z513OBqk42aD2yUu06/MdEzX4rdwLgYhZtvLV9bbMtaIVu4esp4Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=On0oVvcix4kz32EkquB9/gcU0H9k4vE/nZRTBC1fi4M=;
 b=oPVzuqQk8gpTN/dgBaGhqUWN+4ZceUJbEDU7RNd4qKZ+cfagV6IHftVvNRvj6d/l+EzqL23QVUpoH2cQXDEdWHGtBXLV1zl0HuzRJ/wvjN63wRQvVUAOHDLKuVaPWG/bj5zfmNknk9W3x0n5XBrdDHLdGLlg3TaXXEpjQ5kWBl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com (2603:10a6:803:122::31)
 by PAXPR04MB8893.eurprd04.prod.outlook.com (2603:10a6:102:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 16:28:27 +0000
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6]) by VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 16:28:27 +0000
From: Farouk Bouabid <farouk.bouabid@cherry.de>
Date: Tue, 04 Jun 2024 18:23:52 +0200
Subject: [PATCH 2/4] arm64: dts: rockchip: add mule nvram/rom to
 px30-ringneck
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-nvmem-v1-2-b784260a36a6@cherry.de>
References: <20240604-nvmem-v1-0-b784260a36a6@cherry.de>
In-Reply-To: <20240604-nvmem-v1-0-b784260a36a6@cherry.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Farouk Bouabid <farouk.bouabid@cherry.de>, quentin.schulz@cherry.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: VE1PR08CA0003.eurprd08.prod.outlook.com
 (2603:10a6:803:104::16) To VE1PR04MB6382.eurprd04.prod.outlook.com
 (2603:10a6:803:122::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6382:EE_|PAXPR04MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: d059a260-2ef3-49a5-841f-08dc84b35c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0tlR2hKYk5taWNsMXJOS3U4MTdTVE5hejQvSjJQVTYzZFpEcitGZ3JraWlk?=
 =?utf-8?B?RHdWUUxlUTE5V2ZYVEVmRnlTaDRsaG5Zb29jcEpBYzNYYWp4Mll0M283NGtX?=
 =?utf-8?B?c1VXc3FweVJCaXh2WkdNVENpemN1bS9sQnQzYmFXdUVJdS9HSjFVdytPK3Zu?=
 =?utf-8?B?aDlnbEN6bk5ZajdTaWJnOElyd2JzVXdrVHpDODFnN0xzMURHWEhTV2dsenNI?=
 =?utf-8?B?MFV6OTIrTmpOakFkaHFzNnIyQzBzSU1NVGgybE9tanhlZmdCZVVtSlhveENY?=
 =?utf-8?B?d2lySEtmMDJGZUttcnBsb0IrelJNaE5Ocmd3VkN0TWF3dU9FaFgyQTdXNEg4?=
 =?utf-8?B?UDZoWWljVEdBUTFpa3hHa3NuMm5RMlNhVU9MYW9kQWw2WWFmT1VOa1VpTXVz?=
 =?utf-8?B?TGUxUHJwb0JqOERFQjJ3SU5pOWI0Y2ZVZkdKTXRmcDNKaFlUc0pEamRCejNy?=
 =?utf-8?B?NHB1V1FvRnR3Rlh3aXYzVHMwM3FtYXVVVk1rYzFpSVhRdWRTTnV0N0tZWkt2?=
 =?utf-8?B?UTVleW8vY2dJOW9heFZxaFVCWlFzV3NSWnpMckt3bUpsSlROck9EUEw2YWNE?=
 =?utf-8?B?M2JZRnhmbE9DZGtkNjZwaVVTZHI4M0xEMyt4WXF6SmVHd2tybUVhd3JVVlpK?=
 =?utf-8?B?YS9QNDlBb3ZOc2RVdmNzVXZLdzFoU2ZiamlLcEcwbG9nSFdkVnd0NlhTeldn?=
 =?utf-8?B?TUJCeVJzdkFMQzJIZW1SRndhOEVnTnRIWEdsT3V0WGYvTGtJeUhDV2lIY1dI?=
 =?utf-8?B?NVFETHc4aW5tZjFPYUhZWHZGNmdXWmowWlVZN3lnejFBbVcxc0hvRkpqa3Rx?=
 =?utf-8?B?KzF1RGNjZU1SR1p5Zkt5S0d5OFJWTkQ2bGFlaW5OSDc4Q01xVzh1QlFxOWNx?=
 =?utf-8?B?Z0RHS2p3TnBXRHIyM2ZzdWY3OSt5eklYZ01vMExZOVd4UUVtd3B5TGFqNUZM?=
 =?utf-8?B?c0JXWENrZUV4STRMYTMzV1hHMTJuTXFjb2U2dyt3a1kzQ1hjZTJ6Rlh4dkkz?=
 =?utf-8?B?T1Nwa3FKblY3QklrYjNuTHErdGN6Q01mYnZEVlJveDFxM2gva1N0UjVXejRi?=
 =?utf-8?B?VU94VU9DMVJPNGd1SE8xWjVTMkZBMDZoTDc2SkdHUXBaNEZ4dUVnTllYRnhy?=
 =?utf-8?B?ZGJhSkpBMHRnMkxvVEk2S2s0b0RpZUlyZjl0d0tQQzNMNlQxUTZ2ZkdVRFhD?=
 =?utf-8?B?SW45bzlnNzRXQnFGaXI0SXhaYUc1cEZkUEorMS9tSWV4c0l6TS9taytVYnc5?=
 =?utf-8?B?bGc3Mk9MeWlEaCt0S0V4TkJRWjYrL2lFUE52bjRJYjlmWlNVb0ZDNC9OU2tK?=
 =?utf-8?B?RWZFd3hRTHhJbFg0Tm8xV2xCdWZlNFc4ZmNaejN3Q2MwdU02QkdDREtBY01L?=
 =?utf-8?B?UEhvK0toYi8yWE1uNzZZeUF6VHZiWTdxK0dFK0N6L3ZnRmxGK2oyQ3MyeUxN?=
 =?utf-8?B?M01TaW8wYnZYTTJJZkdnMEVCdlNBSUJtOTRjS2t4d0hGSmx5WVVOVXppa0ZZ?=
 =?utf-8?B?cDJnN0doQk1hQk1XZXNrSzBjMnFBL05VdGZCSHRwUmhnQ3k4NGhTdXlhUWpX?=
 =?utf-8?B?RVdyd0x2MHR0eDlTcmJvdzdnMGl5ZXgycXlBZzRibzRpc0VZYzNRRW5PdllM?=
 =?utf-8?B?TVZCU0VsUkpiU1I5TW5vSXpSdTdmQVlrbk9jd0Z3K3o3ZEZzWG9MUjZrak9S?=
 =?utf-8?B?enYybldkZGUwaWNZZ28ybXNvR2taRk04TnQwREF5UXpaUTFUc2lYK3ovR3kw?=
 =?utf-8?B?eVhWOTFCUEVUZmhMYnVEQk9hY3NQRm1QSnAzbTlUZWJ3WlA0MW12MFd2RFY2?=
 =?utf-8?Q?pYetzfWdLAmTkcEI9m5Z5jv7k08rfyJsjvyZ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzB4a3FHaVU2SVpQNEl5aFZHaENzM01XNUtSUkVZWE1xaWgxTXdwajI0T2pE?=
 =?utf-8?B?Q09tUGorQmFMeUFYVC9DVXBwWVZjMWc2MXpwekFQb0Q5ZHVNV09Nd0NMNDdL?=
 =?utf-8?B?N2tEL1dtTDVWbFVvRXBiUGlOZk54bHlVTzJkeVFjbnFhQzY1bjZVR24xSDlL?=
 =?utf-8?B?RXFUcWwrc3dnZWh0ZU9TWUNEZW9UUlBDdmxVaUVMVkRXcFFKTWJ3UG5IWkZQ?=
 =?utf-8?B?Z3I1blgrSVBncktwbzAybWV2UXAyWUF3YnlLNmpvSEhNZXdVcFd6dWRERWxB?=
 =?utf-8?B?T1pIb0psTFpMNXN4TGNmNG9VS29VcWhPMXlNazFhOE9zOXdjdC9hSC8xZTBn?=
 =?utf-8?B?REo2b05xTmVtTzdQWGd4cUxKZExQUGtoK2NoL2pUM3dlOHBSc0FmQ2tJNmVG?=
 =?utf-8?B?NnpuQ3VJN1dsRHV5Y1VIRytWbHB2Vno4dHFUc2Y2NFN1eE1OUWl3ZGZnOTdq?=
 =?utf-8?B?ZDBsS3lGcTRhVDdrN1N0OXFXcVVJbUFJUmVJcFVWa3pOWlZ2STlWelZuS3NY?=
 =?utf-8?B?WWdpMGlpUGRaQzV1TFlJcEpzN0RGZG1FaXBMZ2gvOGhwRnljdFc3MnExT05j?=
 =?utf-8?B?Nkc1TUN6Mks2c2dML2JlOExYYkx4UVREb2EyWnlvcU9PNW5hZ0NJMjJyVVQr?=
 =?utf-8?B?SHpxMTlIVzZOR21LcXN1MWxFb0ptelcya1dMNmdPeU5VS21PMUNQSU9hSU4v?=
 =?utf-8?B?ZVhPalNYWHVwZW45WkVIeXNiNUYxZXNFdEpNbUh1UjBSbXNJV3hnNHIxL2g1?=
 =?utf-8?B?YXdNN243WkhINVRrSGl6V2Z4WGF0OUxFSzJhbDlocjBHanFKL1hLNzhSVndq?=
 =?utf-8?B?dVdEWGpsYnJQc2xxbnlPa3JOeGtveFZNVTZ6NTRRUmh6UFJYSU5pcjdmeTFk?=
 =?utf-8?B?bHFzeDdDTkNmeGc3eUxLc3NTcFc0TFEvcTF3VVdBeUZwb2VHSjI0SFFSbFZG?=
 =?utf-8?B?RWZidEkrYXpvT2NVUlYyZENJb25POWE5aVNvdkpZWUUrY1FEZ2c5d1NMc3R2?=
 =?utf-8?B?d3Zta0ExUkxGU21RS0p3OTNxeXQvTVNkUkcxVzBBY3FDQW40TVpmT2M2ZXEx?=
 =?utf-8?B?RXQ0NSt2TlRkWDdubzYyenFBSjFUZVlSNHdBM01TZjFJdVdpTncrM2JlR1Zj?=
 =?utf-8?B?eHBaTmpjSHlDWGk4anFFTFZQd1NvcGdGd0ZQVDh1Z1c0aVlubnk2OFlwVHhC?=
 =?utf-8?B?R3hUZlo0UmZQUnRFUk1udE1STWU4UVRBbXRQRUFSUGxrSFBvTmpMbEVNZmti?=
 =?utf-8?B?RmhjRTFsYXRtejk1SXI5WnhpNGNPWm5BM3RVUUxic01xckRvMTloSGVlODdO?=
 =?utf-8?B?U05wMGg0eElic1NtTjkvT1AyWkZUbzR5MU9qVDRnTTlqTzhsR0tsQnZoVk1X?=
 =?utf-8?B?TnBpUUk5VW9NbzNWdER4bUZGNjBiVnpXR21nZ05WY0dhNVNHVHdHWDYrdTk1?=
 =?utf-8?B?ZEF0bG8wVHRFMGxGaTVqd1BMTmVhbitRZU9uZDlpT3NTRmU1ZVY0OVM4Smgv?=
 =?utf-8?B?d2M1WEg2T21pSEppZkM2eVpacW54b0UyV0VNZTlTbk96R3gvYjVDaTZQWDFD?=
 =?utf-8?B?cTREYnByMDN2aHVZY092MFdNWnNZbXVIcUNmQTRvdzh4aDFTZi9pc21EQzZu?=
 =?utf-8?B?aFRMSjRsS0Exb1ZMcUhWQ1p6ZnBORHdHQUxJQzhXaGRhb1RhdlpCTG1pODFB?=
 =?utf-8?B?Qk5rUVBrNExVZzRaWEhrOXU0WlAzL3hJQk9wTW1lSzBwTkcyUmZWMG80b2Jr?=
 =?utf-8?B?T0NsWXJpcGFReFZLT1AyRkMycXN6cmtHYzFONU5VVnlaQ21nSVpnMm94WC91?=
 =?utf-8?B?S3JiajFEZ0lyRCs0SUovTVU2VnZwWkE1NlRhakZCSk55ODJtTjYwbWtpOElL?=
 =?utf-8?B?MSsvbm9BQUlXL25RTUtNM1AyVkhWdFJnZnowT0drUDlFYkEyd1NudmQySCtJ?=
 =?utf-8?B?ZHJlKzVqanhibXIxb3QvWEZmK0gxZnA2S3F2emhZenlzWU5XYXQ4MFYwSEp0?=
 =?utf-8?B?Z29mbTJNdDgxRkZXaDVrUjJrTnhoaWJyZnM0Sm5GVHhtU3JoY0pRS04xTTdv?=
 =?utf-8?B?VE5kdGs4c0V6Z2pZcDBYcFpXZWdXUmJHUi81RFRwcFV0ZGs3Z2hZaSt3WVVh?=
 =?utf-8?B?R3hoaWFZMGo2cHphYWo4dGY5RVZpalFTMUk1N2c2bEh4TjNrL1czY3ZDdytC?=
 =?utf-8?B?RVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d059a260-2ef3-49a5-841f-08dc84b35c9e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 16:28:26.8420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qz806gTBh22myQAiUDuckiJ6KGQy6x95Zo9ti6cegsMny02HSufCQ2uUThqLFgM7wY+jhH2v24/8rOnj2luq61p8AbtProI2F43+pUej/gg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8893

Add mule NVRAM and ROM on the Mule I2C mux (0x18).

Signed-off-by: Farouk Bouabid <farouk.bouabid@cherry.de>
---
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi | 45 +++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
index eea906379983..62591972df02 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
@@ -10,6 +10,8 @@
 / {
 	aliases {
 		i2c10 = &i2c10;
+		i2c12 = &i2c12;
+		i2c13 = &i2c13;
 		mmc0 = &emmc;
 		mmc1 = &sdio;
 		rtc0 = &rtc_twi;
@@ -309,6 +311,49 @@ fan: fan@18 {
 				#cooling-cells = <2>;
 			};
 		};
+
+		i2c12: i2c@2 {
+			reg = <0x2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom@18 {
+				compatible = "atmel,24c02";
+				reg = <0x18>;
+				size = <8>;
+			};
+		};
+
+		i2c13: i2c@3 {
+			reg = <0x3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom@18 {
+				compatible = "atmel,24c02";
+				reg = <0x18>;
+				read-only;
+				size = <32>;
+
+				nvmem-layout {
+					compatible = "fixed-layout";
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					mule-variant@0 {
+						reg = <0x0 0x1>;
+					};
+
+					mule-bl-version@1 {
+						reg = <0x1 0x8>;
+					};
+
+					mule-version@9 {
+						reg = <0x9 0x8>;
+					};
+				};
+			};
+		};
 	};
 
 	rtc_twi: rtc@6f {

-- 
2.34.1


