Return-Path: <linux-kernel+bounces-258458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5EA938821
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 865B7B20BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EEF175A1;
	Mon, 22 Jul 2024 04:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XgyWo5uj"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012010.outbound.protection.outlook.com [52.101.66.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB3F8BFC;
	Mon, 22 Jul 2024 04:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721624107; cv=fail; b=mEfiFpxI9t4VK6wpIxYGp5q7cLereWrO9c/9Y0N7wxEMoCYsYTXEmkO+0gTAMZghS95bspUc3pqGsk+NfIpKp4X2T9XWVchMw33H71ljjS50zPUUT4Sr/ryO+4OB1/ZkmhyFPzafaw5+nTUjAixm0ScUATVpu6awr+NtjbSMm0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721624107; c=relaxed/simple;
	bh=NK/Vo0wzbbMSJi1ZdIq9me32O4VmqsZlhy2byWUN/7Q=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=PmJExiggn9fVyx9Pi0H5MttfExvNvELCuJyPKqITY1HxoJ5TgmfIp9UlKM7+h7baxwD91sAM5YcU1bqFC3VIUjP3F5UwQZm4L22DciBll8BgaEJ0zwjmbIk7fd2DH2pGhepnq5XeGNDbh6CisPBO3X2r73+ZIrJs5CF9V9lKhSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XgyWo5uj; arc=fail smtp.client-ip=52.101.66.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0AavDfaYdR20Pk5eAaKVhtlZ3oUKov/YB1ZOANmpDbOoOHxkAwhXL7Qre0xB0kZvBjAS1x0XhsNwKDxEz3uTZ+ipRCtUKAZGgEE6shQqMIWbBTIVy/mYWfZpMoHbVqNPaNWWGIqhuBp065vmzvAhhEAO0lrelTn/pvlwpzTBbySsY2JVhUmdLYAs+tSJQNWAo1/A3IUkTHcU0vEjIrrPyelLSJes9wojH3gNkY1tIzn+czpOkj88t0akOG1kj2PAfgfPC7nEwBYpgN/zHbHSiTVNF9OYoAAsxVt7Ga9GYOiv5aOibulBjplBwKyhd2Ac0Q04HRkDJtNRiTZ1EnQcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoLu1MZEwEaUavvGiEFfMAHD1j2SujZHYqfAlyQO8dI=;
 b=drP0FRZeX1be4NIPnMViUFnnt/Hjr465imHB/eipaXJBvu+hdYmIEusWs79FVLemIjkVXnNKeEpQDyZZUtAqD/9ls0XHigPAwdrGilC2kTYn/Saeae5clmxha7NTXj5T/foAt1S3MCT2BBqnTC0qKK6kvzdmsA7lMNnMgiLnWzRkJz9vCKtxt/iIPiroi+kuPd8WHGt/OP64KXJjmujLVQ6Z6P5e7EdmwLPGOYVOMgxLyygQIZOWVC3Z2z1Z8PjU2CJAPL9jq2JY8xidhFBLnlv+O/H70W9Tu1yL+RHPSvpu8cBh6e0qI4xk9PPyJke8znppYFS0Yh2vNJOG6He6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoLu1MZEwEaUavvGiEFfMAHD1j2SujZHYqfAlyQO8dI=;
 b=XgyWo5ujwRC9Yteek+qbeGmH89pgtHKtcss1XQRxS4vt/5mE/TCb5154yJcgqdZj9t4Tz8+VqJQzvwkABKpdiGb27ErekKLUZ3YkLJ7unhtW9p6ED5cTpkzpsxNL9L3gbfuJDQjslZ/CaWwdybIlugJMqXhdafsq6ybHcm2Vuxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PA1PR04MB10441.eurprd04.prod.outlook.com (2603:10a6:102:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Mon, 22 Jul
 2024 04:55:01 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 04:55:01 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v6 0/5] v6: firmware: imx: driver for NXP secure-enclave
Date: Mon, 22 Jul 2024 10:21:35 +0530
Message-Id: <20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFflnWYC/13OwW7DIAwG4FepOI/JGAxhp71H1YMFZOXQpAoTy
 lTl3UeqSaE7/pa/336Ikpacivg4PcSSai55nlqwbycRrjx9JZljywIBDRA4mW+rLG06SjYAROB
 1DFa0/fuSxrw+u86Xlq+5fM/Lz7O6qn3616Kga6lKgkQXiK0zXtn4Oa339zDfxN5RsXOoe4fNN
 TRGNXgm7V+dPpxV/ddVN8cu4hATUzD86szhHFDvzH4PIwAkNbD69yd1TmHvqDlr2XkPmgeHh9u
 27Rfrszf1gAEAAA==
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721623911; l=15098;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=NK/Vo0wzbbMSJi1ZdIq9me32O4VmqsZlhy2byWUN/7Q=;
 b=0dX5TLqIcuhPdSSKlEKK3eS7YtVXZxtC3BdyGeAn7+DQ2RE2VBJaEkAtlcmtm/hSF1nnd/ZH8
 +tn4G2dfXXvC1mvBaKYbUUNdfviswGcMHgVIxechiDtDtAHAffSPbwa
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SGBP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::30)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|PA1PR04MB10441:EE_
X-MS-Office365-Filtering-Correlation-Id: e761dbc1-508d-46e2-bcc3-08dcaa0a71a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2dNN3ljK255RzRTOCtIeGt0QXpHS2Rtc21RYjF0OENZYU1EK0h6ZFdMTjZo?=
 =?utf-8?B?SW1IUnFNUzYyNTBCTkk5NmZ5ang5bG5EaG1hdXVCU3JoRDZiU3ZZQnU0c0Fa?=
 =?utf-8?B?MFFOZHFqdk5ZMURLMGtOR09ROFREVHlWaS9YKzhvVXZtYWV4TWhCNi9TQ0tn?=
 =?utf-8?B?cDJBcGxpRnZUc3RxbjV0TzVGSi91M1RPRFZQMXNoRDV4Ri83UUJMaE5CaGwx?=
 =?utf-8?B?eWRFNld6eTdmQ2tlSjU1NHQ2NkFpSW1seXozOE40Q051SDV6SnpsejF4dzd6?=
 =?utf-8?B?RlgrVmozcWpucmIzUEVYdUJVc2pFT1diaTdPUUZKT0djL0FqenE1Y0g0Wmtw?=
 =?utf-8?B?Z3dKYUhLaHlpQzYzNFRsWWprcXdweEg5dzdoRkkxOVM5WWU5SGRyTUdYdE9n?=
 =?utf-8?B?QVB2amlLRFlqemxiN0N3Wm9yVkh2SmtJeGRveUIxTzZOMU9vcFIvTW5TTGc3?=
 =?utf-8?B?ZEw2cnhXT0prKy84aE45OTRIeW5NaHVOUlRoYWRrcWdPVGkrVGpwZVl5Q2pl?=
 =?utf-8?B?eG14T0M0b1c4T0pNaEgwZExlVzNzTWwzc21rR2w0Y1pOVUx2ZExqK3NKOFhW?=
 =?utf-8?B?N1BZa2pPbDlQSENoWk9mYVJlbUVEdW9xc0lNbHByWEJEYTViZVcySmVXcjd4?=
 =?utf-8?B?S3hRa0x4QVZycCtYOWVsSUJPRk9mQjJ4QVVaeW1oYnlBekpsbG50Q2ozK1ha?=
 =?utf-8?B?L085cTNYQ2JKenRmWkVWZFRRQnQ5K05kTDV5UDk0Z0Zia1ZiS2FmcWpNdzNp?=
 =?utf-8?B?VlVtcFB3cHN0R29BNi9LQjFiejBXYml1MW4zd1R0ZkozVUNGS1BPZlVxNFJl?=
 =?utf-8?B?OWtuMkVvN0RENVRVa00za29uWHVSd0xJdk9xRU5SbGlPdzVuVzVQYVM2LzEx?=
 =?utf-8?B?cFlhMEhCTTlzc3haU3ZUQjRhRW5JYWFhV0NvWm13bFVFWXU2alh4ZzZYa3Bm?=
 =?utf-8?B?QWwzQ2lZN3p3cytIL0VOaUEyNXEwcWJiakU4NVIrTVpiamFiL3lkb2IvUTVs?=
 =?utf-8?B?MWNHL3pyU2NJQVA4TWdUWW9odkY4VDI0WXA4R0lUZFJCenMxVy9saEhhTVQx?=
 =?utf-8?B?U0c3TTJmUmVxTnVOZXE4T245YkhPOHFrbXVWK3U1K01WNCt6Q2ozY3h5anZC?=
 =?utf-8?B?RW1SdlNnMW45QzZycml5alBLTmhTaGIweExDTnIwc29GVjIydFEwUUhzSmJM?=
 =?utf-8?B?cEdCdWhwMEFhczQ0QzIydkNiejlOZW5xT2JZcGFWcmdQbndnQVlwbk5mZEdM?=
 =?utf-8?B?VmdQVXRxMEZKbVNJZDRCUzNSOFhxZmkxMlpRNC9TNjlsczZ2eXppVnV4QlM5?=
 =?utf-8?B?blhrRW9zK1JpSTNWRHlQS09aTVduUWhvQ0c4dHNxSmFMdHFqZkJEVkZRaTkv?=
 =?utf-8?B?UHc2bXpSZHJtNVgyOWF0bUxSa1VuQmxWOHFUVmtsRTU5M29kaEpPalkvbGxP?=
 =?utf-8?B?RGFmdW9mVHl6b3J3L1dsdjlHTmpiaXlmL2FacjZyeWdLRGFpcXZUYWRSbGV4?=
 =?utf-8?B?OTNBUzJ6V1JHWHpHUVdVc1BYeG5GaGMzbkY5NkFheGNUUzRyT3NhVFFrRkt5?=
 =?utf-8?B?QXlOSk82Zi9PMEpGbUNiSkc5Mmx4T2txQUc4cUM5YmJsMUpYM0dISTFSOG5K?=
 =?utf-8?B?bHB6c0VCRVNsYzRNd3FuZGRzSEhuZVN4Q211TVgxSG5idFcxejZ3VjlaNFNS?=
 =?utf-8?B?NHB3QTd5OVplbWtpRkxaWWpYRms2TFp0SnVpOTUxelpkcVJkL0NpS0xxT1Nl?=
 =?utf-8?B?aHRWajlpRlc2Sk9qV0hEbVRyKys1UWFFdDhkVXQ4MFFqYU9OWGFTeERTRTAz?=
 =?utf-8?B?amdDcXpMY0lRSkEya3VjZGdpMldQWEpFZ0VBM1dTRVkxNVloOHFCRWFzTVRQ?=
 =?utf-8?Q?T3fNDAV7LZcr1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qlk1V09kdXpMamZWeDVTMTErVFhuTkRrWlYrQ0Q1bm55cWxrbnRBNTNibTE2?=
 =?utf-8?B?dTBOVHJEOS9tWTJRb0NyMmJwZmg1NnVUckhHV1MwNUJONGFDOWhUOVNxdGRw?=
 =?utf-8?B?ZU03ZXVVc284SVoyeEEyVmpaeFlIUnI5bUdSYUlmc3BWNVRNNHB0d2FpQjVN?=
 =?utf-8?B?Ykp1ODl4TFZkZ3NBRlJFOGJsbWY1U05VNUxqMk1HWjliNHZURTRtWW04WHhS?=
 =?utf-8?B?dHNEN2hzOE1vS1pick1Wc1pZVndkclJFaFgyNXlvV2czUldDa0IvbjhRNWp2?=
 =?utf-8?B?bnBRV21QRW0rb2QyR0gvQnluYkZvVmh6a2VZY0dBWFZRdFlVSE9rSENHR0ZL?=
 =?utf-8?B?d3JzWjJFKzZ2dzRaRVRHYTZ5cVdyZC8ySDE0YUdyZHA4RUg1eEpMdjZvZ1Nt?=
 =?utf-8?B?TjQrK0U0aFd4TG1jNDVvTXp0WjJ5K2ZKamVTVHZVSmNSNnNBYkRRNkl1dTMy?=
 =?utf-8?B?eC9VTnhWVWtHSFBLd3FLaTFkNmpSM0hqSHByNnJLV0Z6SlUrQVo2RVAvNDQ2?=
 =?utf-8?B?RWc2QzlFYml2Sm1CaWVpV1ExaEZOK1hsVWdTUEZ1akIyaEVtdVFsWWxreWZs?=
 =?utf-8?B?YXpYL1cydVlITzMzZXAyVlFPVmp1MitjVnN0bkxnUVVHSGxGMnBSWUlNODZz?=
 =?utf-8?B?Z20rUE4xOFo3VXJYKzh6R3ZSRGlodUJRdXp4UCtML0EzcEJRRm9HK2JjN2Z3?=
 =?utf-8?B?NVBjQ0xhbm5Xb3J1UHd4QTY1SUhuZWZCRHVPa2M4UlhuTWN5OFhNWXNDS3hE?=
 =?utf-8?B?dit0ZWVPU2dhRm1yNjVqS01IQVhjLzVwamk0Um1XUzRjMFNCanRKN0xoZ2JB?=
 =?utf-8?B?Zm9jMVE4MlByZ2tUWU51NmdVcEV4ZlpYZkNSRGZJZHJhd1cyWWI3WUxlZVU4?=
 =?utf-8?B?K0VIU0xybE5PRDRkQngxa1BobDZoeHVIOURtUTYxdnVoVGV6aWs3Rk9yaU1z?=
 =?utf-8?B?aStlVEN4QnNXMW5YTlhvRG5TVXJobHNvZXB0VDNZWFhWSnBIeUcwbHhPcHg1?=
 =?utf-8?B?dkxTYUM1TlhCeVRQNXVxYXdVYTZPRUJOYkFIelZuNitWNHVzOGUvNUQxMmcz?=
 =?utf-8?B?UG0xYW56WENzdE1FQU5rWEFvZUZhUzg1S2FUeE1EMWZ0V1JZQkxGVStEbmxO?=
 =?utf-8?B?UkxlcHFNS1pDZVJvejkvZEVhdU9HR2dHMnBBRDdqVk5ndGZwL3FsSlVLNGRj?=
 =?utf-8?B?Mk9mU0Z1WEFvanZ2b3Uya0xxZHNIVnF2bGw2QTJwUnc2cFZLcEFOWTIxV1V5?=
 =?utf-8?B?WUljLzJhdGQ4VDIwZkFXcWZ1aWtEUlM0MCtMK1JzR0ZRNUlmcE9XdkViZ1N4?=
 =?utf-8?B?L3NmSXdmWWY5NWZObHdKei85Q3RoWnZURDQvNGdnWTd4ejBSZjV6V1E4Snoz?=
 =?utf-8?B?d3hOeEp0b0pSMEFHTmQ4NUlkMzVSWUd0aTBISVl0U2xDYlRDR1RrdllFb3Jz?=
 =?utf-8?B?V0dtY1NBa0szU2xqTkNueEtOUWRvZmhHbzljMk5CUlBJUnNUU2VJK1grb0pl?=
 =?utf-8?B?NGZHc3NOODQ3VHNQYnU4c1ZLT21saDNobG5rd0tXSnlZSEU1V3kwQzM3dmxy?=
 =?utf-8?B?OGZPTHJWVko1V3V2dHVnbFl2RmRnckZZdlZMcE9WWW51VnQ0VC9kNHp0UXFz?=
 =?utf-8?B?aUVNRU5KcFpjMnJYNEpwRmNRdXRzNmxWeDhQbFdMNTVKWmdYb3lzeHFJRU1Y?=
 =?utf-8?B?Q21oU0ZZYndNcGdMODFNRVgreTlvclpTdGRaa1pkZUdQV0ErUXZ5WnNkRnRF?=
 =?utf-8?B?bFRoZzRyTUVXMkc0TENNTGZoK0J0WkJtaXVjVHdVcW5adkZJTW1Qb2pyYWht?=
 =?utf-8?B?S0NLb1pNZDNOYVk5WUFSU2JWNElvM2xaZ2lFSFg4YTExRmpDVVBaMUdickR3?=
 =?utf-8?B?QnRrWHJKU1VtWU5hQVFDdmptRmhxTjQ5WVJlYXd3RWc3am1LUkVzbTRPQ3dl?=
 =?utf-8?B?ZU9WOWFTQmduVEcxem10OGtncXdtL2tFN0ZhZFgvNnV2Ry9rM3ExR3ZML3Y0?=
 =?utf-8?B?TmhScmEwQ1p6ODBJWGQvaGw2M2s2ZnZMWUJDMXo4blY3alVBODIzR1ZjTzdr?=
 =?utf-8?B?b3NGYk4zazg4ZHNNSzUxZVRXU0dsbU9yZ2FXK0cvbWlBbTJmWExZdjVhUnVQ?=
 =?utf-8?Q?E7MPikWMJ52nt08f4a1oUxruG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e761dbc1-508d-46e2-bcc3-08dcaa0a71a9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 04:55:01.5981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OivfY4lT3BgjVPn56Xz26PhBduZxIXnkDWj3ncG0VX48aTMv+s9WeRwY2y3Cw1+7J1QSkoL9FGlPHwNgzkOyyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10441

5/5
- replaced scope_gaurd with gaurd.

4/5
- replaced scope_gaurd with gaurd.
- remove reading the regs property from dtb.
- Added NULL check for priv data fetched from device, as a sanity check, for ele_base_msg apis)

3/5
- replace firmware with senclave-firmware.

2/5
- replace firmware with senclave-firmware.
- drop description for mbox
- Replaced "items:" with maxItems:1 for "memory-region"
- Replaced "items:" with maxItems:1 for "sram"
- remove regs property.
- remove "$nodename"

- Link to v5: https://lore.kernel.org/r/20240712-imx-se-if-v5-0-66a79903a872@nxp.com

Changes in v5:

2/5
- updated the description of mboxes
- updated the description & items for mbox-names.
- updated the description of memory-region
- move "additional properties: false" after allOf block.
- removed other example except one.

4/5
- Corrected the indentation in Kconfig.
- info members:mbox_tx_name & mbox_rx_name, are replaced with macros.

5/5
- Replaced "for  secure enclaves", with "for secure enclaves"
- Replaced "user space" with "userspace".
- End the line "[include]<linux/firmware/imx/ele_mu_ioctl.h>" with a period.

- Link to v4: https://lore.kernel.org/r/20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com

Changes in v4:

1/5
a. Removed - from EdgeLock Enclave.
 
b. Removed , after "Each of the above feature,"

c. replace "can exists" with "can exist".
 
d. 
-messaging units(MU) per SE. Each co-existing 'se' can have one or multiple exclusive
-MU(s), dedicated to itself. None of the MU is shared between two SEs.
+messaging units(MU) per SE. Each co-existing SE can have one or multiple exclusive
+MUs, dedicated to itself. None of the MU is shared between two SEs.
 Communication of the MU is realized using the Linux mailbox driver.

e. 
-All those SE interfaces 'se-if' that is/are dedicated to a particular SE, will be
-enumerated and provisioned under the very single 'SE' node.
+Although MU(s) is/are not shared between SE(s). But for SoC like i.MX95 which has
+multiple SE(s) like HSM, V2X-HSM, V2X-SHE; all the SE(s) and their interfaces 'se-if'
+that is/are dedicated to a particular SE will be enumerated and provisioned using the
+single compatible node("fsl,imx95-se").
 
f. Removed ",". Replaced for "Each 'se-if'," with "Each se-if'.

g. removed ","
-  This layer is responsible for ensuring the communication protocol, that is defined
+  This layer is responsible for ensuring the communication protocol that is defined

h. removed "-"
-  - FW can handle one command-message at a time.
+  - FW can handle one command message at a time.

i. 
-  Using these multiple device contexts, that are getting multiplexed over a single MU,
-  user-space application(s) can call fops like write/read to send the command-message,
-  and read back the command-response-message to/from Firmware.
-  fops like read & write uses the above defined service layer API(s) to communicate with
+  Using these multiple device contexts that are getting multiplexed over a single MU,
+  userspace application(s) can call fops like write/read to send the command message,
+  and read back the command response message to/from Firmware.
+  fops like read & write use the above defined service layer API(s) to communicate with
   Firmware.
 
j. Uppercase for word "Linux".

2/5
a. Rephrased the description to remove list of phandles.

b. Moved required before allOf: 
+required:
+  - compatible
+  - reg
+  - mboxes
+  - mbox-names
+
+additionalProperties: false
+
 allOf:

c. replaced not: required: with properties: <property-name>: false.
   # memory-region
-      not:
-        required:
-          - memory-region
+      properties:
+        memory-region: false

   # sram
-    else:
-      not:
-        required:
-          - sram

d. Reduced examples. keeping example of i.MX95.
e. node-name is changed to "firmware@<hex>"

3/5
- node name changed to "firmware@<hex>".

4/5
- used sizeof(*s_info)
- return early, rather than doing goto exit, in ele_get_info().
- Use upper_32_bits() and lower_32_bits() 
- use rx_msg here instead of priv->rx_msg
- Moved the status check to validate_rsp_hdr. Rename the function to "se_val_rsp_hdr_n_status"
- typecasting removed header = (struct se_msg_hdr *) msg;
- Converted the API name with prefix imx_ele_* or imx_se_*, to ele_* and se_*, respectively.
- Removed the functions definition & declaration for: free_phybuf_mem_pool() & get_phybuf_mem_pool()
- removed the mbox_free_channel() calls from clean-up.
- Flag "priv->flags" is removed.
- Converted the int se_if_probe_cleanup() to void se_if_probe_cleanup().
- Replaced NULL initialization of structure members: priv->cmd_receiver_dev & priv->waiting_rsp_dev , with comments.
- Removed the function's declaration get_phy_buf_mem_pool1

5/5
Changes to Documentation/ABI/testing/se-cdev.
a. Removed "-" from "secure-enclave" and "file-descriptor".

b. Removed "-" from "shared-library"
 
c. Replaced "get" with "getting".

d. Added description for the new IOCTL "send command and receive command response"

e. Replaced "wakeup_intruptible" with "wait_event_interruptible"

f. Removed ";"

g. Removd "," from "mailbox_lock," 
 
h. Replaced "free" with "frees"

i. In mailbox callback function, checking the buffer size before
copying.

- Link to v3: https://lore.kernel.org/r/20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com

Communication Interface to NXP secure-enclave HW IP like Edgelock Enclave

Hardware interface of the NXP Secure Enclave  HW IP(s) like EdgeLock Enclave,
V2X, SHE etc, is based on the Messaging Unit module that enables processing
elements like ARMv8 core, RISC V core, within the SoC to communicate and
coordinate by passing messages (e.g., data, status and control) through 
these interfaces.

The NXP i.MX secure enclaves hardware interface kernel driver, is specifically
targeted for use between application core and NXP secure-enclave(s) HW. It allows
to send/receive messages to/from the secure-enclave.

Patch-set adds the kernel driver for communication interface to secure-enclave,
for exchanging messages with NXP secure enclave HW IP(s) like EdgeLock Enclave,
both from:
- User-Space Applications via character driver.
- Kernel-space, used by kernel management layers like DM-Crypt.

To: Jonathan Corbet <corbet@lwn.net>
To: Rob Herring <robh+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>

Changes in v3:
5/5:
- Initialize tx_msg with NULL.
- memdup_user() returns an error pointer, not NULL. correct it by adding check for err_ptr.
- new IOCTL is added to send & recieve the message.
- replaced the while loop till list is empty, with list_for_each_entry.
- replaced __list_del_entry, with list_del.
- Removed the dev_err message from copy to user.
- Removed the casting of void *.
- corrected the typcasting in copy to user.
- removed un-necessary goto statement.
- Removed dead code for clean-up of memory.
- Removed un-mapping of secured memory
- Passing se_if_priv structure to init_device_context.
- Updated the below check to replace io.length with round_up(io.length).
	if (shared_mem->size < shared_mem->pos|| io.length >= shared_mem->size - shared_mem->pos)
- Created a function to cleanup the list of shared memory buffers.
- Used list_for_each_entry_safe(). created a separate functions: se_dev_ctx_cpy_out_data() & se_dev_ctx_shared_mem_cleanup()

4/5
- Changed the compatible string to replace "-ele", to "-se".
- Declaration of imx_se_node_info, is done as const in the whole file
- Remove the unused macros from ele_base_msg.h
- Remove the function declaration get_phy_buf_mem_pool1, from the header file.
- Replace the use of dmam_alloc_coherent to dma_alloc_coherent
- Check for function pointer, before calling the fucntion pointer in imx_fetch_se_soc_info
- Removed the unused flag for SE_MU_IO_FLAGS_USE_SEC_MEM.
-  Removed the unused macros WORD_SZ
- instead of struct device *dev, struct se_if_priv *priv, is used as argument to the funtions:se_save_imem_state, se_restore_imem_state, imx_fetch_se_soc_info
- Removed ret from validate_rsp_hdr.
- changed the prefix of the funtion: plat_add_msg_crc and plat_fill_cmd_msg_hdr.
- indentation correction for info structures.
- remove the check for priv not null from se_if_probe_cleanup
- Removed the casting of void *.
- se_load_firmware function is corrected for not freeing the buffer when allocation fails.
- Checking if get_imx_se_node_info() can return NULL, in se_if_probe()
- imem.size has type u32. return value from se_save_imem_state() will be assigned to imem.size in case of success only.
- removed the flag un-setting in case of failure. priv->flags &= (~RESERVED_DMA_POOL);
- removed the function call for devm_of_platform_populate(dev);
- Checking for not-NULL,  before calling the funtion pointer se_fetch_soc_info.
- Removed the checking for reserved memory flag, before freeing up the reserved memory, in se_probe_if_cleanup.

3/5
- Changed the compatible string to replace "-ele", to "-se".

2/5
- to fix the warning error, replaced the "-ele" & "-v2x" in compatible string, to "-se".
- Added an example for ele@0 for compatible string "fsl,imx95-se"

Changes in v2:

4/4
- Split this patch into two: 1. base driver & 2. Miscdev
- Initialize the return variable "err" as 0, before calling 'return err', in the file ele_common.c
- Fix the usage of un-iniitialized pointer variable, by initializing them with NULL, in ele_base_msg.c.
- Fix initializing the ret variable, to return the correct error code in case of issue.
- replaced dmam_alloc_coherent with dma_alloc_coherent.
- Replace the use of ELE_GET_INFO_READ_SZ, with sizeof(soc_info).
- Replaced -1 with -EPERM
- Removed the safety check on func-input param, in ele_get_info().
- fix the assigning data[1] with lower 32 address, rather than zero, for ele_fw_authenticate API.
- Correctly initializing the function's return error code, for file  ele_base_msg.c.
- replaced 'return' with 'goto'.
- Use length in bytes.
- Corrected the structure se_msg_hdr.
- Moved setting of rx_msg  to priv, into the function imx_ele_msg_send_rcv
- Will add lockdep_assert_held, to receive path, in v2.
- corrected the spacing at "ret  = validate_rsp_hdr"
- FIELD_GET() used for RES_STATUS
- Re-write the structure soc_info, matching the information provided in response to this api.
- The "|" goes to the end of the previous line. 
- Moved the locking and unlocking of the command lock to the caller of the function.
- removed the safety check for device private data.
- Structure memory reference, used to read message header.
- In the interrupt call back function, remove assigning waiting_rsp_dev to NULL, in case of response message rcv from FW.
- do while removed.
- replaced BIT(1) for RESERVED_DMA_POOL, to BIT(0)
- The backslash is removed while assigning the file name with absolute path to structure variable.fw_name_in_rfs =.
- Update the 'if' condition by removing "idx < 0".
- mbox_request_channel_byname() uses a "char" for the name not a u8. Corrected.
- devm managed resources, are not cleaned now, in function se_probe_if_cleanup
- Used dev_err_probe().
- Used %pe to print error string.
- remove "__maybe_unused" for "struct platform_device *enum_plat_dev __maybe_unused;"
- used FIELD_GET(), for  RES_STATUS. Removed the use of MSG_TAG, MSG_COMMAND, MSG_SIZE, MSG_VER.
- Depricated the used of member of struct se_if_priv, bool no_dev_ctx_used;
- Moved the text explaing the synchronization logic via mutexes, from patch 1/4 to se_ctrl.h.
- removed the type casting of info_list = (struct imx_se_node_info_list *) device_get_match_data(dev->parent);
- Used static variable priv->soc_rev in the se_ctrl.c, replaced the following condition: if (info_list->soc_rev) to if (priv->soc_rev) for checking if this flow is already executed or not.
- imx_fetch_soc_info will return failure if the get_info function fails.
- Removed devm_free from imx_fetch_soc_info too.

3/3
- Made changes to move all the properties to parent node, without any child node.

2/4
- Use Hex pattern string.
- Move the properties to parent node, with no child node.
- Add i.MX95-ele to compatible nodes to fix the warning "/example-2/v2x: failed to match any schema with compatible: ['fsl,imx95-v2x']"

1/1
- Corrected the spelling from creats to creates.
- drop the braces around the plural 's' for interfaces
- written se in upper case SE.
- Replace "multiple message(s)" with messages.
- Removed too much details about locks.

Testing
- make CHECK_DTBS=y freescale/imx8ulp-evk.dtb;
- make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx-se.yaml
- make C=1 CHECK=scripts/coccicheck drivers/firmware/imx/*.* W=1 > r.txt
- ./scripts/checkpatch.pl --git <>..HEAD
- Tested the Image and .dtb, on the i.MX8ULP.

Reference
- Link to v1: https://lore.kernel.org/r/20240510-imx-se-if-v1-0-27c5a674916d@nxp.com
- Link to v2: https://lore.kernel.org/r/20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com

---
Pankaj Gupta (5):
      Documentation/firmware: add imx/se to other_interfaces
      dt-bindings: arm: fsl: add imx-se-fw binding doc
      arm64: dts: imx8ulp-evk: add nxp secure enclave firmware
      firmware: imx: add driver for NXP EdgeLock Enclave
      firmware: imx: adds miscdev

 Documentation/ABI/testing/se-cdev                  |   43 +
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   |   91 ++
 .../driver-api/firmware/other_interfaces.rst       |  121 ++
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts      |   17 +-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi         |   13 +-
 drivers/firmware/imx/Kconfig                       |   12 +
 drivers/firmware/imx/Makefile                      |    2 +
 drivers/firmware/imx/ele_base_msg.c                |  274 +++++
 drivers/firmware/imx/ele_base_msg.h                |   95 ++
 drivers/firmware/imx/ele_common.c                  |  450 ++++++++
 drivers/firmware/imx/ele_common.h                  |   48 +
 drivers/firmware/imx/se_ctrl.c                     | 1205 ++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h                     |  133 +++
 include/linux/firmware/imx/se_api.h                |   14 +
 include/uapi/linux/se_ioctl.h                      |   94 ++
 15 files changed, 2609 insertions(+), 3 deletions(-)
---
base-commit: b63ff26648537a5600cf79bd62f916792c53e015
change-id: 20240507-imx-se-if-a40055093dc6

Best regards,
-- 
Pankaj Gupta <pankaj.gupta@nxp.com>


