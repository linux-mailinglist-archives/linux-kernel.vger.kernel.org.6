Return-Path: <linux-kernel+bounces-243919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1286929C68
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EABAB20B47
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66C3179A3;
	Mon,  8 Jul 2024 06:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AQ/stpkT"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011003.outbound.protection.outlook.com [52.101.70.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A7EAD5A;
	Mon,  8 Jul 2024 06:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720421224; cv=fail; b=AC06AVN+eQVCgCJtNsIJlhjI8kFTd86VO9eZ2Y/L8FmH3jOPAp8VYUV3RFqStdbBxkXHbtiyAqASWXsgQYYlRzVDwdJ9IRN1c4vyJ6IoVSXS/GoUKEZP4Xq/fm7PNh/91LaANlS5p2IqfeEz0FEPrmcGlWwXh9Ou7jZxTuZ3kZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720421224; c=relaxed/simple;
	bh=6ANFiMFUUUyJOsn5IfOoSwtYA2iIqBNKcygd151puU4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pu2+1Xp9RktnRb0sw3n3FyL3vg+L1JU9QuTX6GHTExNXk+ckJ7EJg9i67JVT3koJKF/I7Guc30h0ZvHDpD28Ry4xxkLzzAlUiJyHwGy7JY6K+KxxHhrEv/0I9nsMaZurmIE1oZV974WQakkDhR30RCc4I44wjH9Xnp49nCGjpZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AQ/stpkT; arc=fail smtp.client-ip=52.101.70.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWADe6XomHz9FhUrchHnD15nAAAXvhflSz0scXoWGhLfMJGMpsvaCncuwfjinzdWmBpUNJsRolrQYzTW3U/Q7DdEKhz8RvjXVnDKWKyIOx/Ct63//MW0gBdwcDbMiHMfxpBCyL+J8VUqiNNEXaUjyUOklVFLWNyBVg5E+U6pMJ5urQaINaFgFNTSZ+x4Q2D+LJlFzxuk98bkc0ZbSeNqyO9gpR+o2O/13L27cAN2KeihZQ4wSFX2M5zVgbKD0HYpUMLZHtJpd8RhM5h2NQeLIvAGBvON14ATL+4vFLYSUA7OfduSp95JEXaUv31sWGvSDNI3PN0VAtGk9OH7snjdAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDREJMplVE4G4iS0GqaR2uCEfzMB7yqCsG6qZOHAy+c=;
 b=c+z1kMqAyafgI+lvcux8u8TpF33oQ67k463favg2YN2Q3zw4pv4YWGOH2CkTX7JPAN38cEf5gVqQVEAPYisUbceH65h3FZUQ7moHOrqBein+Dw5LY3WeO0ZNmaNThDqe80IEIOHK5DlXnDLMo3VSW9jRLFd6yT7084c/3xPNEnVo2xIO7SJyZiToaAZnGEwPnNVIUBe6lSKwB0gSIYvfdSLwMl7OzYtWwGDpszWZAiyTJIsjWm8EPOUtexWlFEZI/H//yAdq1trzUQtQBL+rheMLr02CPNcUOY3yweCkxUpBbdSkd+vOVBX+z/dE1K50E6JJG0XzskDex4nStcipkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDREJMplVE4G4iS0GqaR2uCEfzMB7yqCsG6qZOHAy+c=;
 b=AQ/stpkTgpeNOFkanhC1D+r2QUF+PJXuyZteJq5GThr5mja0csoDgqxewfZQxkOigsrmVdLa+fQUJ+K5Zu1Ls1+TvtAKEKGc4PF2wlWjo0TDmcDIsHIrLUwuL/yfRXlnanh20Fvezc6uzLkBXcBP8Xppnydz5E7J22ROkCCvl6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS8PR04MB8913.eurprd04.prod.outlook.com (2603:10a6:20b:42c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 06:46:59 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%2]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 06:46:59 +0000
Message-ID: <ea8a5f78-65a5-4be8-9e15-57351a839f52@nxp.com>
Date: Mon, 8 Jul 2024 14:47:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] dt-bindings: display: imx: Add i.MX8qxp Display
 Controller pixel engine
To: Krzysztof Kozlowski <krzk@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, tglx@linutronix.de
References: <20240705090932.1880496-1-victor.liu@nxp.com>
 <20240705090932.1880496-4-victor.liu@nxp.com>
 <35c70e6c-d4e1-45a0-8c8e-db530fd84aab@kernel.org>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <35c70e6c-d4e1-45a0-8c8e-db530fd84aab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS8PR04MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: a7bca7ff-6cc9-4f67-2e79-08dc9f19c412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlZya2pERjRKYVU3R2wxWS9tUEJtbS9DT3ViOHJ0ZWFEVzZORDF0M1dkVVBn?=
 =?utf-8?B?dVlVc09yUlJNSlRmL0pYa1BxQ3RJR0xYcXUzTVNOOGVYQUhFa0dyR2JUNjlL?=
 =?utf-8?B?dmtUWVF6cWM3ZFExTEovNklkbHViRjFBejdxbStuNHNTTjR4UFAyR0tTRmpR?=
 =?utf-8?B?T1ZiWUliTkRiOXp3elM4Q296aHdVellWNUZJZG9PcGw5WnZpYVFzTHhBWHIv?=
 =?utf-8?B?alJzdnhRZFY5bWd2RUMrd0xpaGJlbFYycHp4N3NOOVZiRzZPNVFQcEt6bk5E?=
 =?utf-8?B?N05FeExIbzBiY2xKejhGTjNnNUVMM1FKZzl2ZXQ5eW5wdC8vZ0lPY0h4SVBr?=
 =?utf-8?B?SDZweXR4Q0NBT0Q1OWVVc1hGMFNUZlZlRTd5c3F2Y1AvdzUyNlBzRFQ0VGEx?=
 =?utf-8?B?N3Y0bzRwcVp0cHZPVjIxbkpvLzRsYy9IVUhNSCtMU1NNZjE1Z0p4OE9NMHFP?=
 =?utf-8?B?NlA2Lyt3MytwSm1tKzRqcjgwalNuRUhOZmlBb1F4YjhTWGt2N0kyUkdkL2xt?=
 =?utf-8?B?SVFXQmFhZXQ2dkVDU3hRTk5KVmFpVVNxT0VqQ0plQlNXTlVvTC96enJ0cmk5?=
 =?utf-8?B?TWtwMGg0UlVwMFNSakJlMTcwTC9OcGdPV2JGbjd3VVIvOFZTVFpJWDNCZ1pX?=
 =?utf-8?B?eFp5T2xBNXlPRkZPbDB1b01kb1Yvc2FUWi9qS2dKY3JZaVlJQWxJQU1lcWdK?=
 =?utf-8?B?ODBwYTVOdnluanc4RDZBcWNVdWdXMVhvcHhzZFU3WEVlTnlhN3NTZzJBcjRO?=
 =?utf-8?B?YTdJTFp5TU1jempUUHdqaUJkSWNhY1pnWWdCSG1oRE5tdjJQR29HbFdPQTRu?=
 =?utf-8?B?S2FhVXhpREQrenpIR2N5eTl4Rlhad2dDcExCeXVLM3hFQUZsTC9LSmlXUURn?=
 =?utf-8?B?TmFlODdwQ1JMSFlzRk1JVGhrT2Q2bWRoWW1jRkFtbFBLdW90Rkh6UzhBRXdE?=
 =?utf-8?B?eFVzWWVlZUpqK0pqWTg0ZnkrTDNWbnJ2WUJjQzZSbERIMzR5QzMrdU9UQ2V4?=
 =?utf-8?B?eVVDbi9LMVN6bHRYQkl4RGpjQnhNb0UxZzhwZkNxS0V5cXI4UXZ5eVVicWc1?=
 =?utf-8?B?V0lBb3MxOGd1Tjh6dW52U1gyN3V0T3VqazVBUkJ2MnVvVFdoR1psTUpxTk9D?=
 =?utf-8?B?dDBNMVoxQzByalQxT1cwU2FmRWlJSzIxS2Fxa2E0VmhxY3FkNExPanFBTGtn?=
 =?utf-8?B?dU8wa1Rldy8vMzd4R3Z5QnU2YVBmRHFxM3RnYm51NllGeHFKTzFRNWE3eFJq?=
 =?utf-8?B?WEIvNFRQQUFjQmZHN3BmOVZoYnBoOTBXVzEvNFlHUW1WejhTcjd3TEUwM20x?=
 =?utf-8?B?dnVkcmNkQmQ4VEN5ZGNhc0dOQXpJMTJDamtmRkdUOUU5cjFHYU90WGNpMmpy?=
 =?utf-8?B?V3lCL2picVBUSGN4NWpxTWY4bklUd1lybThLQk0yMG9XOXB6Z0NEYkxteko3?=
 =?utf-8?B?MnczY3JVTW5MNkh1aGJiTlRsUW0zSFl4eUFYd3lUbFNMTzNOZnVnc2U4QnNV?=
 =?utf-8?B?S05BNEI2L3M1anJRUWF4VTVQZUhGMmR6U1VMdFlJZUsyeXZwSUZCTjZGTHRi?=
 =?utf-8?B?OFB1OVZDRGJtUG92SVowKzh4MDVjS2dRTklDUVpTRXcxcWEzajZ1SW83bWdC?=
 =?utf-8?B?Vmd0eEEzV3ZxZVVwYkJmOUtRM2o2MEE5K2dHUHJERzArb013THJyb1lkazJK?=
 =?utf-8?B?UHEwa1RaYktHRDVrdURHSDFDVzNZam9rNXRsL3JLZGxoeDlCT28rTDN3YXBs?=
 =?utf-8?B?ZW1ZdHZSVEQ1eGgrSXJvMTQxV2ZEWGlPSDVZYS9mZEF0TFExZUtwQ1dTQU9q?=
 =?utf-8?B?ckI1cndnUVN3QzRLS0V0QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2FBMXM0QWNEemFtNlJaZ3JKd1pOQnhqa0ZDcHJKNnF6Y2l2OWd6RFZMN3pl?=
 =?utf-8?B?K3YwZllUTWdOc0hXb3MvOVhGSlNmSTJHckJLR0hNaEdPb1RoWmdhdnBkNjZF?=
 =?utf-8?B?b2JTdmxsM0lud3laZnJ0M2pkZFVGcDFNL2hTRHdod3k2akhlc3JGeWVTU0dZ?=
 =?utf-8?B?QktEMEdzaW1IZUd4Q1VuR1NPZlo2TmNNMFpWRmlnMDcxczVKQUk5L0sxWjRL?=
 =?utf-8?B?SStMeGJaekNZd1RxajlDc3dZbk1IcFZwbWN2V3hERW82NHViM3M0cGNFVUxF?=
 =?utf-8?B?bW50YU13TWRoSkNoWkxmSjdsU0V6NWJkSysyQ2hqeTRCak00dmJmczBSbHFD?=
 =?utf-8?B?Vk9tZWNVd1lHblg4Y01QT2VtWmlRUTdTbnllcnYyYVVkTDhZaThWNDVjWTFw?=
 =?utf-8?B?SHZmWEEwN2p1MnlMUTl4a3ByRjJGZ1ZxMXI0MVAyL2tzWnAvUUtWT2RXbUd0?=
 =?utf-8?B?cVdJeEF0M1BTUTg4bU9tVHZzMkx4Zlc0TUJJZWF0cGYyU0cyQldyNHZtcGFw?=
 =?utf-8?B?cDh4VXNMVWpnTUJlL0NSVzlDUEFtNmRTZUtoZVNSc3FrQWl1bHRRUUVOVVBX?=
 =?utf-8?B?L3lFUzBBeUsvcjBjMWpVUVVkRzAvUHdXZXdna3lVeWJmVVZNMmh1YXVWcTJZ?=
 =?utf-8?B?TzVUV1hQRk9DaFNUMUJ0ODdFUC8vRmJlZVRxSm5Ba0h6dzBRc0cwVzdpU0Z2?=
 =?utf-8?B?V1lHcmRsQWJqcmFQVGM0UWcycVkxRHZ4OEhHZU9vQkNpenE5UzNsMDJ5L3Rx?=
 =?utf-8?B?Yjc0M3FWcHVjQmFGRlNTLzhiR1BjRy92WXBnc2swYnI4anV6aWxXdHpZZ09H?=
 =?utf-8?B?YXAwcWxRUGc1bEpqT0hKTzBzbE9xTjg3dkM3akNlNGxvM1U2WXltQy9sOUd6?=
 =?utf-8?B?QzFjdy9sTllhWHk2ak1HL0pKazR0VTUvRGg3UFNXUTU2UVVSNlhhcnRXY2Vj?=
 =?utf-8?B?NkNTWDZENGhoYUZZbkZlQjBKY2NDMkk3WThkdkVUeXI0cXR5SkVPQ2RCbVdX?=
 =?utf-8?B?a2xLSk4xMHlvb2lPYVB6UlZZWmM3eFdyQlA2RUI5S0VDTUY2Q3dwRHdkdlls?=
 =?utf-8?B?MkVWTjFvRTBiRytmRzFmUEs2NTBMRDFQT04wWjhLem5nN0c0WGJqWE1jTDlF?=
 =?utf-8?B?WVd3cENpUGVjS2JIcGJ3cEVaZ0ttclJuQnRuVUNXSkhZZk8zUmhlL2dXSkhl?=
 =?utf-8?B?NThQdC9yTzhleGIvdi81YVZEbnhsSmtFNVNmb1hhaU00Yi9leWJTanpEcGht?=
 =?utf-8?B?ejV0SzRzVVcycENRM1NTK1AxQWllQmdxNFFXMi96Nko0NXo2MCtmK05IMm5D?=
 =?utf-8?B?b3ZGQW1XamlwcmJITjB5NGIyU1VLOFBkWXR2b3RHTndWblFON3JBYWZnQUJ3?=
 =?utf-8?B?UlNqc2MvTXM5TTJLZU5ZeVlOcWE3dFYwazJzRmYyTWpsTm1yN010RUpwZHVG?=
 =?utf-8?B?Q1N6Y3FaaFU2bllyenRjdnBtTzdTVUhiTWJMOGtudU1qZjlLWGpBbEpzVzJX?=
 =?utf-8?B?eEVMejBCbTUvYlpQN1IwTkJ0bTh0QnlyampMdFduNGNxQzJXY1MxTFdEVFR5?=
 =?utf-8?B?Zm53YXE1NU1oRTBrUGhwL1dZZk5SZG0yeVBRSXNFN3Npd1pVV3pGYkpnU0hl?=
 =?utf-8?B?QXVSdlFVVVZQY3VQeTYrYVNOeS9qOVZteGxWaktYVk16NGpJbXhuNmdFR216?=
 =?utf-8?B?YS9RbE5RNkExSmZPNTlOSFVPUWN1QmdnZHhpTlc3M0FjLzFJZFU4ZEtZeVpH?=
 =?utf-8?B?Tjh4R1pjSlB5SThVZEFhQjhPZGs4TVpHemJKSjROZnQ2MnFnQjBSeStycEJG?=
 =?utf-8?B?SnBaQ09FOVZuNWk1Sjl5YTJtTU1ubFZDU2FMT3BsTHJxWnkyTTdJaGhSOTA4?=
 =?utf-8?B?dUdaZmZVM2JvU0F6cEFpVUp1ZFg1L2FXUElIeTVqVzJOSXdtTXV1ZEhMV3By?=
 =?utf-8?B?ZWhCUnZwK3R1ei93ejhEaksvYXR3V0xVYjhKWkFmUDBOdmd6ckRqK1F2dUw0?=
 =?utf-8?B?MFBiTVVCY2ZSNWNoTnRPUXdYSlBJei9EaTJDZlIvWDBCdlE3aHZGNm9ReFFC?=
 =?utf-8?B?YzBJSzU4YXIzZDlicTFhSlBDcFUrSFBWeXR5ZzVySzV5WkNJaUtkaWFqRUI0?=
 =?utf-8?Q?ltg0q2TywX13jXmv8Ikqw3hSy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bca7ff-6cc9-4f67-2e79-08dc9f19c412
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 06:46:59.5206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9O1UuS5zHOv2uUTZHcMX5jPtrMlrlv1C9yktrB73u76Up9tn5EpgPaXxcEz9y9WRaMtmdKSmV9ACJDB7gfz+5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8913

On 07/07/2024, Krzysztof Kozlowski wrote:
> On 05/07/2024 11:09, Liu Ying wrote:
>> i.MX8qxp Display Controller pixel engine consists of all processing units
>> that operate in the AXI bus clock domain.  Command sequencer and interrupt
>> controller of the Display Controller work with AXI bus clock, but they are
>> not in pixel engine.
>>
>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>> ---
> 
> 
>> +
>> +        extdst@56180a40 {
>> +            compatible = "fsl,imx8qxp-dc-extdst";
>> +            reg = <0x56180a40 0x7>, <0x56186000 0x400>;
>> +            reg-names = "pec", "cfg";
>> +            interrupt-parent = <&dc0_intc>;
>> +            interrupts = <12>, <13>, <14>;
>> +            interrupt-names = "shdload", "framecomplete", "seqcomplete";
>> +            fsl,dc-ed-id = <5>;
>> +        };
>> +
>> +        fetchwarp@56180a60 {
>> +            compatible = "fsl,imx8qxp-dc-fetchwarp";
>> +            reg = <0x56180a60 0x4>, <0x56186400 0x400>;
> 
> Aha, one word for address range.

Sorry, I don't get your idea here.

> 
> Sorry, these are not separate devices.

Hmm, again, Maxime suggested to use separate devices.

> 
> Best regards,
> Krzysztof
> 
> 

-- 
Regards,
Liu Ying


