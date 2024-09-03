Return-Path: <linux-kernel+bounces-312305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 932909694C6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50999282E31
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914311D618D;
	Tue,  3 Sep 2024 07:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="k+c4CoXv"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC68C1D6C78;
	Tue,  3 Sep 2024 07:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347349; cv=fail; b=ElILGTRUJTeGS7+/E6EHY/aZBpQY2uD5Cs5hmrU/kw1jZQF0TOTAc4490kN+u/oU5qDZacpoCJTGqXvUtHyl/8asNDkqLcZkoq1ip6mbBASh61TliaDX4rR6W4Zt35QBHjSKvdWd00JVkJfgmoepRwLm7RAR5BxVSGNHi9pC8nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347349; c=relaxed/simple;
	bh=+lVIv8BXgiXbFq9omoa1N048WJeZkhJu5pNu5ItbpJQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aAApx+8tIT9PKHY5A+skVpTNfQSUd7TeWWgO0z/WMH1dvkFt7Az1XJ8apqFRIlcd3Zm16bv1gYz0EJBzJsuqbNKjWuQHmrWUHbKlVp1fLlUPsnXr78LtvGZPGBF9oldr0OAPD38qKHiXHDc/eGI02ijFz7SgdiLgB2t9uWh6310=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=k+c4CoXv; arc=fail smtp.client-ip=40.107.21.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nc+z3pkz7zVxHXqeFxm/yVz20+1W/v4HPt294UX8qg2HfjpAa+EF7GeBl+dclEb/Zy9oSWgeenWzInAe9W5Ncb2fUy1a1s5i5j1VXAbeHxlYEDJohKBcwR8rso2lDiKo//IUoHPvMtC3vM7318u4HI2Cuw80PB51NuCEfVkEqKB8j/GVibk9ZO5MrtlbzJt58QX4nas/+zAvIiq+NY/enaZDLp28JRHwAFrmVeyIXZqg4jza5FjHtg8nhbLODm5pg0gyLWzNfStkXwAJYZLHQw1JFwhuTsNH+tIuVlXpyMEwAgX891JoOy60SFpV5b/Y43aYtrhf1sw0vj3FJ5kZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7dZsVBV0sNZ7SH7sU6wrlcfKVgC6d+/3wl9oTECxhc=;
 b=WRAYTbMQfKoC9tole/V0ARq3pfloemAyHKeMDxUj8ZP5VyvbqljziITA5qKNmhBFe5WZ1vmipnBt2pWMLZ/PmxtDr9HySO3W2VzfI2e2JB2Sq5RLtlnAhArCUT5JYOmyFgQRFiAo2FtBjehhEj57cdzVL+cjM9aOwWdoKIpHbbiuh1XqCOnsGGkHG+GUTiPxGyQzDQBuE2VHyRLfnOX5bkg70Nxl/4MmSVuZayBaw8v3LihDR33tYIb9oTWdFbdB5TKmTbr9jeVKqxvmK1lEVO28G/P8TZ6ggNomet7dFSObKqPN5PbbXpl5/GJoSXmkWyW4IRpU69I4zVWnuTF2+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7dZsVBV0sNZ7SH7sU6wrlcfKVgC6d+/3wl9oTECxhc=;
 b=k+c4CoXvncnBcZ/nKO7OTBFreyMFbpbRk2WTpVB1zRqdDXOYP/f5fEfRDE7+/OBgpbkT4VyrmHe0116UW//RUgY2HaSEGqYGsqIOn2DDWjMbVwVu/DTmv0z5X1VE33tg9k5L5/314raV1eXcPYLep4UU7v5hpWTBlHomsFuuiUZw0eWj/B8bYPK2bjORW9GiIg1sS54VQKRjhwkn/LOgXXOmLdHcMd0gtRAq2XJwFs7uEIZbp0SgNLQXhZvvb8TlbXYE27uekEif25J7edyiPAvUyuo+D+W+OYN+zQBkt7JHQK17nnq3B+IMpF3ayN4QcbIxxpT5oCAW0lRQZ6YEcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9365.eurprd04.prod.outlook.com (2603:10a6:102:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 07:09:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 07:09:04 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Sep 2024 15:17:47 +0800
Subject: [PATCH v2 2/7] arm64: dts: freescale: imx95: add bbm/misc/syspower
 scmi nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-imx95-dts-new-v2-2-8ed795d61358@nxp.com>
References: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com>
In-Reply-To: <20240903-imx95-dts-new-v2-0-8ed795d61358@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725347874; l=914;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=jKMLZnwqOMB8RBv1H3mut/xvZe058iNtUdblLGQkkJI=;
 b=vtbQG/H2ThK0foV79Pvn/a6ZvjCRtjyb3k0eOIpb0kcItIf1P1FRSRWCM20pevKaIuyaK0Nsc
 mEvxC8Pk57lDcZPDgBc5MoO9CGNSlefxrTdvHFmnQhZamr3juzEOvvc
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9365:EE_
X-MS-Office365-Filtering-Correlation-Id: 054a74e3-51b4-4997-d538-08dccbe74b91
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dW9uMW9oWitVNktCVDlBbE9kM0ttQ0NiTjExVHptM0IrMWVjNGttcEw4cC9F?=
 =?utf-8?B?MnY5YkNUZ21GZHRUcWdlemc0cUY3SUd6WHRBVHk3eHRGUER6dEZkaTZReEE0?=
 =?utf-8?B?MXUvMWdzRXNDUjJFeGFFb09GME9sVzRqT1RPaEFGOXJKTWEySE9kWm1CZ2pH?=
 =?utf-8?B?c1BZUzFaSyt1SDRzcjVOMlRUZ0dyWDFhLytXOHNnQlZRdmUxMHBPSEc5M0FY?=
 =?utf-8?B?aUs3c2FqTHFlcnBiSEcxTkZxV3VtY1hHN3F3SFg1YXBOU3NJaWZVR2VPZkU4?=
 =?utf-8?B?bW5Iai9LaHFRclpuczJrRU9zRExJSHVxRW14Q1lYY0YzeE50Skh3TGpEUUh1?=
 =?utf-8?B?aHozemNrV3NFb3VkakZCbnYyaTFNUVRDSFFWckpsSFZld2RsZFY3Yld4QUtu?=
 =?utf-8?B?OTRnbXQ5UERWOE1oQUFMR21XT2ZPbDgyL1llNFNUL0E3emM0R0VQZG1xSmFL?=
 =?utf-8?B?NjdSc3pucEpNTE5HcTRBM2c5eWRBOXNTR1piSFRQd0RQN3Y5OExyM2tTb2Jj?=
 =?utf-8?B?RlEyQTQyNTV4YkJBdGRJY0Z1ZDN4aFI5UUJHSXludDJ1cUJYcXZ6aitqdlpM?=
 =?utf-8?B?NGt1ME00bTZneWJqRTBNY1NFTXo0M1ZDVFlocGVhQUU0Ky9nZVFydVhVaUJI?=
 =?utf-8?B?dnowRjhuc2FBVHludmxZNVJBZGJKT0JFY21EQi8rZi9ldWNvelpobmF6bU1E?=
 =?utf-8?B?a0dvZk1VV0tmNW1yK3Rhc0ZJREtRQ3FDcm9lMjhVYVNDSnBOWjNyVEZVenNu?=
 =?utf-8?B?Z0ZQU2g1V0VrbXhFU2lqalpZUEZCMVE5Mkw5ZWJvYkFuMTN1dG56WDZzd1gz?=
 =?utf-8?B?R3NTVzI5akxLSkh5dXhXRmR2bUdCaTJuWjFMTzdtcHVJblRzUGJnblpwemVu?=
 =?utf-8?B?Wm5EbzRUMjZRbkszaXdtd25DUlNEQ2tjQ0hSMXFzOG9jenZ6ZDBHRTg2K09X?=
 =?utf-8?B?Y3hhOTJLVmN4MnF3M0M2ZnFTQjVud3dpUldjTnNOcVBaWWMyOXptRnRVSTZM?=
 =?utf-8?B?bnpwL1hzeHBqdUVxd2t6QXRGUVViVlpDZVRGRGQyM3grMVJ3MnU1elVsQWFq?=
 =?utf-8?B?TGNSUk1YOUlTREFKWlVpR1ByV2xRQmlhZWpTS0FzMjRQMWJhbEtBMUJCcjBG?=
 =?utf-8?B?UDV4YldtMUxBcUZOSXhDMFV5WWcxRDh2ZmV1RjljWVI2OStIempTY1VjazBD?=
 =?utf-8?B?dHFxYkxwMGxMdVZKREt4cUFVQVU4NTJCeGxJWDFRWmtwUzByN1FBSzZyQjQ2?=
 =?utf-8?B?RitZRzJDb0hyeFpkdGJoTTFTaUNuWkZuYXNXV3gvRCs1K2F5RlB2bDZIWVdO?=
 =?utf-8?B?SHluV2JBTlRxZUEyV0NSWnNlLy84NFpESTJCaDJEL0xVN3MwYlJDWGIyNlJt?=
 =?utf-8?B?aVlVM2kxU3V3Q2lGS3F2V3lDMDI4WHVPT01kYXdDRjR3dkFVZnBwa0x4enQ2?=
 =?utf-8?B?NWxVbDF5WGFEL2FZSFVZdmV5Z1NmMmRuTUpkMUJ4N1BZQjBZZmw5SVYxdmhR?=
 =?utf-8?B?SDc4bzA4K1dUZ0JPeVVaYlB2dUtuWjdlSDRScDYvMDEybGFnWURoMkFBTmMy?=
 =?utf-8?B?RmthcDF6dWFVa3NvNnYyY2pvVG02b01sVVhDZ2dvOTNYSWNGa2c4azNRT1dx?=
 =?utf-8?B?TElMVWxhcEpZcTlSUVR6K0VCUVlBVmxsTldMeUEzRytJTEdPSklwd1BsQXNP?=
 =?utf-8?B?M2ZKUkpGUUFSbzZkclZZYUlQejlHOXhUeWVDVS9XbkpoSUFJcjQ0ajAveWts?=
 =?utf-8?B?TjRscUczRXl3M0RmMHppeHprQzk3bWVKa2l5cktlWmtXV3psdFk4Uk5DaENV?=
 =?utf-8?B?aFV1S2YxTFJvL3FvSGlxS01KRGhhK0lnai9ES3R5R3A5MVZYa2gyQmdrSXJC?=
 =?utf-8?B?dWI2azdnR2pNNFl6VzNSVzlMKzZJOXg4cFJXc1VpOEtvZmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ay9iSFYzNGRNelNtU0RjR2c0OTBVeXFOMGJVUlB0Q25wWWNpbzhCeXMxVk9T?=
 =?utf-8?B?c2dBU2VzLzhEOFhmb01zaXFJbUlMaUZPd0ZnS3ljT053WkNFMjBHSHg5dXVm?=
 =?utf-8?B?UEhSNFY2NUpUOFpvRjNiNE1CYnM1di9UaU4rRU13cVZubFBTL3A5T0NYY3lO?=
 =?utf-8?B?Z3FyOEU4QXNoVmFGVllkZWdLZHFDZWg5K0xoeUFyRWpCN1Nnak1aUEd6TFRo?=
 =?utf-8?B?cGZ2SXFmMHRVMUlqdGJPNDVXQm5VZWQ0RWJGZHJCWDVBZ1cxcVcrNDJYUEhZ?=
 =?utf-8?B?bWw0SHJhZmhKSGlUR2gxYktrakZ5a0p1UEhPOHU1aDRiaDRtSzNGb0VRODZ6?=
 =?utf-8?B?Nmd1eDg3RHMzdXpMRHBPaThIU2x5U296MS9QUnlmZHpndyt1S1pHWkM3MGRu?=
 =?utf-8?B?N1BUNFlwNFZSUGVsMjhpYXdqSkZhK3NmckRXa0FhaXZiemZuSnU3TjJ0NkVX?=
 =?utf-8?B?dmFsWjArbUd5UC9ieHNtMUo2TENjeWlLYk93MHFyd1VlSHZNV2wwZDB4K0JP?=
 =?utf-8?B?dmtpcFlHckw2NFkxMFBkeW9Xai9kVWYwMTA1VjZ5bnkxRjVKZUJSU0l5YVkr?=
 =?utf-8?B?b2NZUVlSWm0ybytNanpkL1Qxd09zZm0wZGx0MlNjbjhzYlRVNzEyMnlycUNr?=
 =?utf-8?B?OVlVVUVjRXI4Q2J4dVFNUGRWa0c4TWE0cjExK3FabVBhdDZtZnJjcUwrWEQz?=
 =?utf-8?B?MGpINFAvNFJKKzRwL3NRd3J4encxOFhGamx0NDBlS1dtZWx3dUtzWkl3dHB6?=
 =?utf-8?B?bFVNbjZEaHhzTnFPajJxeHQ2ell4ejluQUQyTnplSE1uY3Z6dU9CU1h1Rmwx?=
 =?utf-8?B?Vy8ySWZyOG1aZHBMYVhEak1jN1F3RzhYTVpuc3NYdmhEbm5WdkJwKzBxdlhH?=
 =?utf-8?B?WUoxYjZxQjg5VW1jcGs3d1VDNmV3ZEpJU0MyODZQeXlzUVFNQnZrZWFJcVZR?=
 =?utf-8?B?RjN2RFdnb0RLUEdKSGhmVHpicW5vdnFYSXVSRHE3TU9HQ3BmV0hNMVlIV0xW?=
 =?utf-8?B?bkdCY2dwZWNKK21LcEx6eERROXFEQklIekRPbzZzQjd6eTI2VjRYWEhlTFps?=
 =?utf-8?B?dVZ3T1dzU28yQWM0U2RRUVdmT3RMSUw2NFFjUmEzL3lCSkJxa0pZVlczbzU5?=
 =?utf-8?B?TVZRdDMxNFU3ZXFJRGVDYnArVmNtelhpNXNiMjJjQTVCSTB3c0ZWVnJvYXdy?=
 =?utf-8?B?Z1NUNGkxV3R0WWJoT0hSdDRiUTJsUThZdkMvUVI0alhHNFR1S01tQmNKVTI4?=
 =?utf-8?B?aU5RV0NwMDFPeVFXQllGMWRZQnpWWVZFM2pmcTFxQUtlVUNUSHdvUVppZjJH?=
 =?utf-8?B?RjFRSlFkeHc2TlFKT290UWxNQjZwVTQ2VWI3M3IxK1p3WWdCM3RYZEJUV01p?=
 =?utf-8?B?M3B0ZnV1dm1Yb0JQbS9aRG9SQXZJam0zVWtuNmNaR3ZCUTg3KzFMWUhkM1lD?=
 =?utf-8?B?ZGJHRDVDdlZtRUdvV1NLbGx1ZVpPRDIxZ2pjNVM0SVFZWUIvRTVtK3M4cTRV?=
 =?utf-8?B?ekJORnVXTys3VTJOZm9ya2QydVY1LzMyRVJyRk5TMVVpVVBrcUdjYVlOdzhR?=
 =?utf-8?B?VnFmcE92dmx3MGkxVmdzNzI3ZDVMamdmYmo4SlNNNmxzaDA1c3lGWkJKQytu?=
 =?utf-8?B?dWd6VWV6QVVQNUNOSXVZQ2ZqSkFQc2l1VGtoM2I1Rk02dXNoRW1BaWNtZVNn?=
 =?utf-8?B?QkNxUklnRVF0YXVHVytkWlFvU055R0V3aGI5REd5L2ljaVE2c3haK25tNldN?=
 =?utf-8?B?ZlNuU0krQy9FZmxpVUQyMDdRd09mcHNkR1R3TGFPS0xGa2RYdkNJU0hDSXdh?=
 =?utf-8?B?aTFzdTZ0aTEyWmpwUUl3SUpGOUFtWjlMRnZwaVNoRFRLOVYzcDlGQ2dnalBi?=
 =?utf-8?B?aitoUlZKNlJsWTllbXM2eUttVEJrZ0xYMmtIWTRLVk1LTTZzbTFmVW15dzhx?=
 =?utf-8?B?Ui9HYTlxNVA0Sngvd1pHc1lldGE3Q2ZReVpZeFNHRzZ3R3NGRHJNUVFWa1dn?=
 =?utf-8?B?OXk4aWNTUTJSRzVoaDdQNDlNR1dvK3lRU3lqNW9ScGg3dUMzbUNUbTZrUHU3?=
 =?utf-8?B?TjBEbjA3TGtGMUZ4OUtXZlpQVGdqd1l5UmJYNnRHS1FJQXRLZE9lRzJqUHhN?=
 =?utf-8?Q?6Yq7OP3Enut42/VwxloOz7dN8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 054a74e3-51b4-4997-d538-08dccbe74b91
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 07:09:04.6416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQnf6EMZwWA2mppS3PYoPcMCSC1FJEH6dtTi2LIdCZABp9vwZdhX5dVPUv5AyGc8Uwk7E3LxKh+aeBrjQaQXlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9365

From: Peng Fan <peng.fan@nxp.com>

Add SYS Power, BBM and MISC nodes under SCMI firmware node.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 7880d3efbd7e..314a45e82c38 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -301,6 +301,10 @@ scmi_devpd: protocol@11 {
 				#power-domain-cells = <1>;
 			};
 
+			scmi_sys_power: protocol@12 {
+				reg = <0x12>;
+			};
+
 			scmi_perf: protocol@13 {
 				reg = <0x13>;
 				#power-domain-cells = <1>;
@@ -320,6 +324,13 @@ scmi_iomuxc: protocol@19 {
 				reg = <0x19>;
 			};
 
+			scmi_bbm: protocol@81 {
+				reg = <0x81>;
+			};
+
+			scmi_misc: protocol@84 {
+				reg = <0x84>;
+			};
 		};
 	};
 

-- 
2.37.1


