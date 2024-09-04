Return-Path: <linux-kernel+bounces-314815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 421C796B96A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658831C248AC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24EB1CFEA3;
	Wed,  4 Sep 2024 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zap9wGih"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010028.outbound.protection.outlook.com [52.101.69.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E870F1D096B;
	Wed,  4 Sep 2024 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447347; cv=fail; b=WeaT+KmyKl3MhDU229Ey6NSfsDIBMlitsKu2Aaqyr8CjzHtSun+ztV2MbIrFlnpE4el3ZqT+HbdNE9JTHmBeOuMOj3G8SSbcAdV5bCaYIevai4U2zwi7T+oEBDifUxfqNJrG1u36Jqlu+EAdcTqr5Yzg5gdZsUfMOAu7UuNPyDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447347; c=relaxed/simple;
	bh=pYE3/Q6exoCLJsnwweUy9J21x6w9vr/mPHeIgg5m5qc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pPTbp1V315ksDquOk55TygyaS2CTPyzVt46YIBakDwu9LuGNgRgj2609vm2Ri33SW7PGFkawn0+0aSQwA2QYEfDY68UwCash2kuxGsW4uxBxw9rUcoKbmG08iQ2XJ3fHltYx9FooqVN8/7koaMCLDv1drqqDTRafDPUnnePHaek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zap9wGih; arc=fail smtp.client-ip=52.101.69.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chDoTEBiUL9sDWzMZ55Ur1Izp+F550SP9XQSTNJ2BgoHyfcKt/vhyVgU7qqbi/0g/bkhxJL2oKD+zUMheuRuJPHum0GUQofTbrrAxtAfQ8OQ/cm5mEg67xM9FcJvz+LWYuxVbJTi6KCaqiaR/of08xx0EmkSx0gXNiiP96k/Zd9TaBT9yEtkjtfU8yUlUdF32+FyBWokzgfNGc3K9gJOWkd7MDlVJmxgLk3n/bhGWpL0+aneaLlY7qg4CQihlLOgQTITegMOJ6umI/m0UIJTqm3SWXkpcvofeqsexBpPvWwMY6eHixFCFAWCHJy2Z3b8SbMtB9zArk2rzXQEsSDnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gtkzixnwb0RPmDgVy9ypv5aH2wWPad0rOTiqgwx/eh8=;
 b=xBDuXzy3b9dN9pKP7XhVSTCSQs5h8rHqQXAXzeSJ1tV9bLC3u1c9bENWjW8GtdeyQ2FgU4Aw6qBoF/X7SzHH7vuV/MYwBtkheq56doZKdhwnyy+Gmw7Sq++Dnz9klWUmG8pPFaGxQqJ+onb/gpgjVUZy8+uRziCQt64TQSIcifY7btIpqKGhKRz9inTADrnji6ZerJrjvvD8nSBThJpB6yQIP6hhM17Te0whXPetT6UX6ivORZm326Wx8x+uPPr3Jt896eN+IPS78rh9hYFaNEJoAiLQUWDmfrRNER7i8xfFuukxpyMqeU9BRZYZFe4Okg0/yOERxi8m1j/G7RadTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gtkzixnwb0RPmDgVy9ypv5aH2wWPad0rOTiqgwx/eh8=;
 b=Zap9wGih+d8+qWSvbuOYbnEhJ4IRrPmHaobAKYzCgdKgB9wutsVS2fnsT4cdLt4t+jDq0N8LdOjvErOKgRAqH9372fy0wu0qH4+VkobY3rMsCa1A2COnb80OY96YhDOjWtoksplIgmgZV02giKgRO/72orJP4Vy5vUkEh9SApYvZRS6XEQIRFRe5FUj8mQ5ZXU8rG5QVLPjSLz3JyG6GYTG0m7d7PjqyhnjIYOV1OBPNu9u4qKTsM7/AkGl0htpa42Qsiirmu1PfT3nED+UzuMR3HyqbBcTrc6pGpz6U2y8zqZ1kSxje3JFVnrCz8Fsjgv/m2BE5/zJN4vMZp3bdIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DU2PR04MB8583.eurprd04.prod.outlook.com (2603:10a6:10:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 10:55:42 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 10:55:42 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Wed, 04 Sep 2024 16:21:19 +0530
Subject: [PATCH v7 3/5] arm64: dts: imx8ulp-evk: add nxp secure enclave
 firmware
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-imx-se-if-v7-3-5afd2ab74264@nxp.com>
References: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
In-Reply-To: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725447104; l=2640;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=pYE3/Q6exoCLJsnwweUy9J21x6w9vr/mPHeIgg5m5qc=;
 b=UL3ulq3TkHxNvSP+HNajTVdPRsTkBvaVlb6Os9z8TSYJ2SUsKI4LlMqFkQVXzp5NweQ94Yd1z
 6R2YfrDBXPeDLeIgpWnAblg7AAuE1pLrMCEeazqgsdLYuYjNF3exS8D
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DU2PR04MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c650328-a7dd-4a86-dc73-08dcccd01dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VE4vQjM2d1FUTG11STgrbkY0RFIvOW1OSE9QZ1VhSXNtUGZTa0hGeTVWd3lt?=
 =?utf-8?B?YkRjSkl1Nlh2aUV6ckIxd2phZk44eHZUWjk0c3JuVUtCS1RacmEyZEJnSTRt?=
 =?utf-8?B?U3h3UVV0eitNMTliVHlRZkdOeVJkV1pnSjM0Qkx1cTVWRzQxZzY5ZWkwMzhR?=
 =?utf-8?B?VnZrU3JiSmhWd0lIMG9vVkdBUW43RHh6STNlMHJONDlIbTRRejE5L2FBbGpw?=
 =?utf-8?B?RGpCZWNIR0RYems4REpHeHk0RTlRbWNrWld6bDcvSUxvdTdsSE9jTHBXeFZX?=
 =?utf-8?B?M3NLY0RyaXozT3NGOTdVc0tUd1RQVTFJdUdLRU53MFZCNzQrRDA1ZEJkY1hM?=
 =?utf-8?B?a3VEZEFlaHhpL0dIMWFtTTRqT1B3TGhzVm5MNWFzQVdpYURxNG1HYnhpZkVy?=
 =?utf-8?B?MWl0WmQzQ2F1a1c4dVNUaFZBTWt5ZjYvKzhCYVMvNUVHRFRRcld5T2JReHZJ?=
 =?utf-8?B?NFQ4VzV6cDErdEFMS081TlJFbElNeHJoY2JteGNJUG0raHI5Y2hzcm52YVhT?=
 =?utf-8?B?OVNlVkc0dCthaWVjVnRoMWxtMk5PbEg5c3gzQVlQTlJManRJU05FcnJOMmRT?=
 =?utf-8?B?T01XQ2ZXYmJxZUVCalQ1VE00K2lNV1VyV3BFMUhpaSsxaC92VElvT21MeDFS?=
 =?utf-8?B?dkNrUUZydTRnZ0VXRlZqWXRyTGdDL3hkMGhVNHB6SFN3a1gzSFZBNjhxUW1S?=
 =?utf-8?B?Y21ILy9iM1hrbEdKeVo0d1JwOUZUL0YybkJtVld3VGlhSWE4YU1QRjEvOG5X?=
 =?utf-8?B?OWkvSHp2WGdQZ0p5czlUVm8ySVNuZGtYSDNoU0RTNW4ycldYNmJFYjFoYUhR?=
 =?utf-8?B?aVBrOXREOXh6Mzd4d3c1NG9jcGNsRGRWOEwzWVZRUHNMTHAyTmZ6d0hCQzJk?=
 =?utf-8?B?OXcrSThGYkdaQkkwdTNmeWdmRHRkL1NDN2d5ZFFrN1lqUTNwekZjOGdZNUhx?=
 =?utf-8?B?WmlueDY2UGo3L1JWYmhhRzRaRjRtd09abWtsY3NScGd1bVBic3lZRmxWTVZR?=
 =?utf-8?B?Ylp5NU9lcFBLdUVBbDIvRjl4TVZxNG5SN2pYWWNwR0hCSWRMczdUNXNWMnhJ?=
 =?utf-8?B?eWFocytNUmJ1UW1xd2Z2ZDIrM0NUU0tGU1kraTBCbExTZmtIanpDb1owei93?=
 =?utf-8?B?bmlyZHQ5RDlhWXQ5N2hUWnBLcm9NOU5xZVJ0NGl4OXRSbG93eXE1R2tJRXBz?=
 =?utf-8?B?QUV5eXBwY1lKOU10NzlCTnI4bndaSXEwK2JUZ0pDbVFiYzJsWENkZEVKK1Bw?=
 =?utf-8?B?eFZiai85K09pT2RuS0d1eHluN0Y1RDVhN2ljTWxjdGd2WitxSkloaHRPQ2kv?=
 =?utf-8?B?WlBxa01QZFUxUHJwRHZORnlXdWpOZjIyQkgzN2NFTW5EdGNnMjNBV2NUdGND?=
 =?utf-8?B?WlZsbERXOEE4QUZ3TnF5WlgrTlBQcEpITW5VYlV6NVlJQlFOWWExYUpYM0x3?=
 =?utf-8?B?empySDlTMGJEeGFvdmlNNmRqOWJiR2NrUXRVRVlZaG0zVG93NVJ2UGhPUHRp?=
 =?utf-8?B?SU1ONkg0bEZqeFdkaGRscDNRTVliczFUc1h4WDNhaHdZUnJ4bDVwaTVMc2JU?=
 =?utf-8?B?RElPYm10VXZ2TmhnK3Bvb3dEZkcvVnJIWEY1WlNoUHd5dC9JaytvMEtRd2FW?=
 =?utf-8?B?d3QxTzBkSEZGYnpYNmlYNGhPWXZabXI5dVEwWjZXaEptY3d5U1pTWU9vVE5V?=
 =?utf-8?B?ZU5TMVN2VGgzUVhCbUowN0dHUDlQTHNrZ2p4aUVsbFRKcC85MXJHaG5sTVRi?=
 =?utf-8?B?R2ZjMWdlUnBRTmFvNDRUQkZKdkxnZkpObUxRa1RsanpLYTdpc0oveURKQ2Rm?=
 =?utf-8?B?NmlrVFZBZ2xUVlBBYmNEWFRCaDZxLzN0cHViSmdhcFhVKytBR1BYeWdGaHRt?=
 =?utf-8?B?Q1ZNNkNNZmFqdmVpSUgrTitJMjZYalV4cmhjamZzNUlzaWpYT1pRUjR1dDVZ?=
 =?utf-8?Q?TcoJdFzumP4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFBZWGFmOXR1ZjVhb0R0YUFCdFpaSDlEVEFGb1Jiejk4Tk1LcWQxaVFsSlNC?=
 =?utf-8?B?MkQxdklRNnlyVTIzakFIN1poRlZqZEdlVnJ6WUM1V1dPVXRXeFJHeFR3KzJP?=
 =?utf-8?B?SWUxRCtXS0ZaSTJSeVoremo5WVV2NkwrVmFTc0RYL0ljWGtTM0ViVWk4UU83?=
 =?utf-8?B?d3JmRURrMjRJbGl2MGx3dlJ1UUFPa3ZYQ29TUitLVWFuVkRreTJnajNIdmRh?=
 =?utf-8?B?ZHRBd1BGRDMrWkpRUWIvdmFyTXFzS001alFib0ZxdldaRTZQamd4cjMxcWdU?=
 =?utf-8?B?ek45OWRmWC9XcVV1ZnBHSDhhTVpzOUI1REJhMVVEMjVid2c3ZkNGWW1LS1BJ?=
 =?utf-8?B?ZWkxUHo3MUxGR3NPNklzT0lMWmFTS2ZXeG5NczN1Y3Rpd2FXbWdoVlVsR1J1?=
 =?utf-8?B?SmR6NVFrQVcrS1hoaXJBRi9ZcG40QlkxVXZkL0I2VFdRYXhsTW5pQTh4SGFF?=
 =?utf-8?B?dW0xSTBBR2I2WnRONGdmRlVlK2J2dU1xK1RiaE13a3Zaai9kdlUrdkhqbVhi?=
 =?utf-8?B?MFNWNGNIUHYrV0ZpYVhRTG05b20vUGVGdjZPai9tL3FpU3ZlN1REVHZXM1hu?=
 =?utf-8?B?bHR6YzNkeUUwT3h2STBpdlVVMnBEQ0lpNWVQZ3YrbGhJa0g0SVFJSGgyVXpz?=
 =?utf-8?B?cTk0SUxpQVlCVEZURU93MmhEL3kwUVB0dGF4aXhyY2dWYlFySk9BMnZyYkhT?=
 =?utf-8?B?VmhIZTN5RzV2aGVtM2dQVElxZmMxYjI0OW9HcUxaaTQ4YnlHTnBRc3NWUDhW?=
 =?utf-8?B?ZWtGZ2RHNlc0dWQzSE1wdXRUVEd1NmlmNkU2VkxvaXBGYnJOc0dOTHlKY1kz?=
 =?utf-8?B?YXVuaXlXR1hSOWlycHFaZVNlUDRKekVqSGdVenY3dlZkclI3SjhEU21PRlVY?=
 =?utf-8?B?RENZNSsxZ0tuVjVpUzRwdDJ1MXgyK1NBdjJKRVNvak8rSzR3RFZ5bUFPbi8x?=
 =?utf-8?B?ejZnbUM5dzJ2ci9sNmlZL0FJUGU1bE9wQzRWSUNIdURTTFN4RDlORFROaDhT?=
 =?utf-8?B?WGpWR3cycUI3S2lYQlhhZkdNS3dxTGhDV0F5YjNHRkNLNUJ1NmozOGxhMXNv?=
 =?utf-8?B?NS9JWmZnQXg4TTJSK3BnV2tTN3ZrRlFTRG1wQXJYRnBzY1BwZTM3bnZPUG1P?=
 =?utf-8?B?MlI3RDBTRjIxUWpiM2pUbittUFFBUG1iZWJaOWx5T3VleGdpMXkyTEdJSEZR?=
 =?utf-8?B?L28wV2dTdnBIWXdIakVHSWxyTC9vdDRxQkt2cnc4bE1PZDNxQk9kY2FGMmVN?=
 =?utf-8?B?N1RkRjByODJrVkhEY2MxUzVmYmxTOSt2SHJLci9DUlpkSTdCdWhmcWlvbUhI?=
 =?utf-8?B?NnZub3gzS3VldWMreVl5c3kvRDJCb3Z1RnRZbFdGUENGVTFrWXZQYytsUW0y?=
 =?utf-8?B?ZkF2K0VRVmNBMTE2clpmbUp4MDRqODVPQ09YV01nbjUzSlF4Qk5nK1ZGWk1W?=
 =?utf-8?B?Ny9zeVdGYUhDb0UvYjhSblVzZ1ZUV1dyb09QTmd0bGF4M21FK0JVNEpTdE9G?=
 =?utf-8?B?NWl2MTF0b2NYNXZVS1ZsaEtCNG5qYzcveDFCS3V6S1FYRnZUWU96UGRwRUpt?=
 =?utf-8?B?dCtlTWQxWTVnZ1UrYytYazFsN3d4andqOXpKb2FjMThTZDBET0hRWVkvc1R6?=
 =?utf-8?B?YkJhRk5oUHpUTWRvOFpTQloxbmMwbTdDYXBMUWtnZ2tFTG1QOEFKb0NZM1Ry?=
 =?utf-8?B?d2xDNDR4bDc0TVpUNEpIdWdDMUltcTl3TzlkUUxseHlLK3BBS09TMG01QlFa?=
 =?utf-8?B?UlpDVkgxSnIybTVUNGJucWRXLzNNbkpWcHZmeDRXRys2SERNTTQza3g3Y0pP?=
 =?utf-8?B?R0d2cXFXQ3ZiRmVtWitxaFZTM25PSitEZEV0MnppbEtwaUcwVXNmZlRya0VS?=
 =?utf-8?B?ajNsZEZUYllQblpIek4yazdrTUFLKzk3VlVsTTZoWUtFdTNuSEJicWt2S1hY?=
 =?utf-8?B?eTNHRlpzL3B2WXJkZ3g2RUxBKzhpeWZVVDRrUDhRMEo4aEFES0dPY0RuTERp?=
 =?utf-8?B?RHpQalRFM2V2b0hZemx5ZnNiek5ZdUhCTUh6VG8zRDBkNk1WbDEzalR4MHho?=
 =?utf-8?B?cTFWSkV0TTFqYnZaU3FkQngvaGRNTk9pOTJ0ZWhLNFJraHJvMXE0enJlWUtE?=
 =?utf-8?Q?h80Q4L6v2yDyCWSy7PXdaRK27?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c650328-a7dd-4a86-dc73-08dcccd01dd4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 10:55:41.9395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUH/X+wyQ6Wd9JP7efpZh2lZ5wJgetGLtSEeVe8c7bQrWMfroLuGaQrEAfrwU5wigazunGLI7Wsss9IoLxj55Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8583

Add support for NXP secure enclave called EdgeLock Enclave
firmware (se-fw) for imx8ulp-evk.

EdgeLock Enclave has a hardware limitation of restricted access to DDR
address: 0x80000000 to 0xAFFFFFFF, so reserve 1MB of DDR memory region
from 0x80000000.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 17 ++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 13 +++++++++++--
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 24bb253b938d..ca8958f28a83 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2021 NXP
+ * Copyright 2021, 2024 NXP
  */
 
 /dts-v1/;
@@ -19,6 +19,17 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0 0x80000000>;
 	};
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ele_reserved: ele-reserved@90000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90000000 0 0x100000>;
+			no-map;
+		};
+	};
 
 	reserved-memory {
 		#address-cells = <2>;
@@ -146,6 +157,10 @@ &usdhc0 {
 	status = "okay";
 };
 
+&ele_if0 {
+	memory-region = <&ele_reserved>;
+};
+
 &fec {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_enet>;
diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index c460afaa76f5..914d61b2275c 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2021 NXP
+ * Copyright 2021, 2024 NXP
  */
 
 #include <dt-bindings/clock/imx8ulp-clock.h>
@@ -152,7 +152,7 @@ sosc: clock-sosc {
 		#clock-cells = <0>;
 	};
 
-	sram@2201f000 {
+	sram0: sram@2201f000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0x2201f000 0x0 0x1000>;
 
@@ -167,6 +167,8 @@ scmi_buf: scmi-sram-section@0 {
 	};
 
 	firmware {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		scmi {
 			compatible = "arm,scmi-smc";
 			arm,smc-id = <0xc20000fe>;
@@ -184,6 +186,13 @@ scmi_sensor: protocol@15 {
 				#thermal-sensor-cells = <1>;
 			};
 		};
+
+		ele_if0: secure-enclave {
+			 compatible = "fsl,imx8ulp-se";
+			 mbox-names = "tx", "rx";
+			 mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
+			 sram = <&sram0>;
+		 };
 	};
 
 	cm33: remoteproc-cm33 {

-- 
2.34.1


