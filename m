Return-Path: <linux-kernel+bounces-190233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1408CFBB5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A002A2823AB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BAA60DCF;
	Mon, 27 May 2024 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RKaqONh4"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2088.outbound.protection.outlook.com [40.107.105.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590A65B1E4;
	Mon, 27 May 2024 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799272; cv=fail; b=jIt29Gpt8bjRWdLjdYAIpyGebIJRTn7qlcu5fZviPLZdIHl80UisdcGDzPoCMYUFIA+7Qb4MdTU+wgh4xYkejI4ojCXKjMbta/V/ssxSK/tudtfSoBC2bUvAaPlH+VZeLucjOMyt+cWPz8ludjsBCUrFe+34Kbba41GdcJHXUXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799272; c=relaxed/simple;
	bh=b35MRj/zcuzkv59MVKwNfPY8X8sajhqjiJ26GimOl2E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RPIFy7jCT6DNQEqGLh/9VFfSwvlfUoSrVEZhyPh0YuD1yLq7FxectKpg3Z9JizAN3d8PwLCxYWQ8xkAMORhFllMLV/7w/33WfTNhyGJ7QnFb0cgdQV7I73HfxIG3EASZjq9/18FLdVy0zB6J2iLwN6RLoRESHV0aSdt8XFhHDtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RKaqONh4; arc=fail smtp.client-ip=40.107.105.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYk5Jge/4slBnVUoVX3jRcBCoteUO/dYkx89N7xBgUABm8KfWciVraVSZQ13LM/Mt0AyfQWvEPcVoszXRYxxYdSl8KieMZLY/Y/ero833gSjG+J8yG1dFWTKGI1eSEseWj+4gj9XVbP4R+fZzlQ14qOXzqq6cgmAntfh1fqiZNs/vHH/m2i1Vmcb31nGaY2rSovbs9GCC2s3NWbf1RlgJZ/hs1buMB6i3n2HBrCLVPaqX9SfRrvVjgnR+QikJd2nkiKn9rhlYLgAqEiHbs6B+vwKhUY5+PmmCr3eTSZSzvRc2H0m5OcslP5G2EAdmvGBzwv0RhSCWoPYS+DwQoCMdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b35MRj/zcuzkv59MVKwNfPY8X8sajhqjiJ26GimOl2E=;
 b=JzoXRHlUJh/0YKXdQ4xMiqH8fW/+GrEqh6zfkfSFCO3uREBj7pq34fc7K3K7ixVYZguu3/N6etdA/TcwCHvqEBo/6/p4z0QuehkhUZU+nVSi4EFwz+nM2iKYi4HXSpGEGgK3KpUcbQEfqMv9MKxgmW+qf3qeXebX2+rffmpuAAcSOsZ7+CPV5ZSOYO4yJiHqGY2iQuRVKs7BBe00nqRFg0i1nFFb0Y9FD8IKjb5KaGFrOUi5Won8BXUFTELdUAC0Q5CXf35oRA9NOW4mwF3C2MpnvwhyzKYcPPNlg3sw+wRJ1UScHsXOPPvup9bdBc8/KjsTnc3JvOAAwWn7/OaUxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b35MRj/zcuzkv59MVKwNfPY8X8sajhqjiJ26GimOl2E=;
 b=RKaqONh4XgjwGnJKCb26iJiO/anK02QUirGyNNwypym0cIiGbCw56zaz+wMrN6o9CK5xeBkAFW6aPU9lWf84w8ZYmB5gcJShFYO5kHzssgMpDzd6X8bd5Bxjc/8hU2rtldK1VnlpTYniSCtUFZLxjGhPAB7YMC90PsGewNErU1Q=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8670.eurprd04.prod.outlook.com (2603:10a6:102:21d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 08:41:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 08:41:03 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Alexander Stein
	<alexander.stein@ew.tq-group.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: RE: [PATCH v5 0/3] arm64: dts: add i.MX95 and EVK board
Thread-Topic: [PATCH v5 0/3] arm64: dts: add i.MX95 and EVK board
Thread-Index: AQHanzmm8xgTyw47NE29tdJqdtzW4LGq5Jbw
Date: Mon, 27 May 2024 08:41:03 +0000
Message-ID:
 <DU0PR04MB941740670E8434EBF3EB18A888F02@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240506-imx95-dts-v3-v5-0-5ec9b99cfb2f@nxp.com>
In-Reply-To: <20240506-imx95-dts-v3-v5-0-5ec9b99cfb2f@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8670:EE_
x-ms-office365-filtering-correlation-id: 4d1d013d-cccb-4ad1-be3f-08dc7e28be68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?bVI2bGEzWnExdU43cHlWK0lJamEwWnNCMkpwVTJydnpGNUs0NFQ0WGtoUStj?=
 =?utf-8?B?dUxTTm1wY0VvcXRrTFF3Vm9iNkgrRC9mS3hQakdjbXBQd0hVdy9ZeVYxQVFK?=
 =?utf-8?B?dXE4WVI0ZGZVL3JpdjNDV2NHc1B6a1ZUK3ByZmxnWitVcDhZaStET2QycnF0?=
 =?utf-8?B?cTduZzNpbllCQnljdVlodmpHRXBQY3dLVGRlZU5hUndtWjMvaGpaeGF5Wmc2?=
 =?utf-8?B?OVlKdHBVT0ZLQTl4eFpicXU5YXc5Y1IvbzVGYjNkYlpicmtIWExVU21hSThu?=
 =?utf-8?B?RENQQXRhWDRvK1dCYUxKSkt1WmVQcm9SRGozM3VIaGk0SHlHb3A2Yi9oKzBE?=
 =?utf-8?B?c2hjVjdvcXVrTDdoVWsvL0FoQkZHcEdCYlE4eUxIR09FbitsTlZEeFkrVVcy?=
 =?utf-8?B?Ky9aYVorK1UySHdYb0Q1UGkyWFJsanVncFo1bkhraVo4Z2FPRUREVVJkbS92?=
 =?utf-8?B?MThYcTVQYko4d3h5TDJtRjBxM3J4dXJ2anBVME1OWmptZllNR2FKd242QWdQ?=
 =?utf-8?B?citVYk1ubnpmc2ZKOVdFaEdmQnlBcnhoa0pWY2NEYXhiQUhzN2hiYVBVSWZN?=
 =?utf-8?B?amZDcUtnSE94QS92OTFUaXUrdHNZcFNTalg5WlFYeVdRS3IwRm1jSEJvSmpp?=
 =?utf-8?B?RmRCTGt0dlBHRW01c2dWaDZ5dXBpT3hzdWVGcG1HWUpGYmgrMzJZOFFjcURF?=
 =?utf-8?B?OXpsSnVMbmtsUXpBNnpKK0tZeGZVd0pRSHh4bUt4WUJTSFp1bkpuWXpERERW?=
 =?utf-8?B?OHpkcERhWXBMaytJQ2ltYWxIajJMZHVqemZaYjJvcXBzaDgyTklGREg1bFkx?=
 =?utf-8?B?bm40cmFPZWhBVm43djh4UGxxeDNuNWRkVldvZzl2d3BkdGc3TU5kQjQyUmw5?=
 =?utf-8?B?ZzBQN1lrVkxPaE50aUlrUkt5dkE5cmt1N0dPc04rOCttZTcrRW1QVytXWFhk?=
 =?utf-8?B?MUY2VDdBY2lBVWRkTG9HSFRXMEtpanVObHlnL0EyY0lsRkV6WlcyOHgvYzJt?=
 =?utf-8?B?bjZRM0RQUjRCeklNVHc0RE9EVGlWWUwweTA2QXV4SU44RWYvc1g0RHdwYkVV?=
 =?utf-8?B?VzhNeEs4VnZQNnNDd2dYeUdBdURVcklScnpmM0hqV1oyMDk1ZmJCTTRLd2RY?=
 =?utf-8?B?bjcyRXZaYmQxUkpKbWM2ZVV5WHFsL0E1WlpPOUM5NzRlakhaVDMrWEJSWkVw?=
 =?utf-8?B?ZE9MdU44R0dzQ2VuVVVXalloNUlEa09Kd09rTDRsWi93Q3J2S0UxWGQ4NktH?=
 =?utf-8?B?RTRsd0RyV0JLdndibnAxbWJYbnQ3WGk2ZFl5K0tya1ZBb3J3UWJFZUQrU1I4?=
 =?utf-8?B?NVJ0YWNra2ZkTmJIcXpPa3lGeGJtQUxuclNyL3lKNWN2b0VYRWFuVnhCaE5S?=
 =?utf-8?B?RjlBMkMxOGZodndyQTR5ekJzT0NyL1poN0gxbGFmamxPNTgzQ0d0bnhOYk5O?=
 =?utf-8?B?TmZaQzdJRWhDN3BuTVdGY2hSakhNdmhLQkl6amtUL09Rd1cxdjJKRzZSb1RR?=
 =?utf-8?B?M0puUnA3VkcxdERvMGlhNnlFRFRmakN1aXF5QkFqeC8zRG9sOTVwUVp3Rklk?=
 =?utf-8?B?ZWM0WDZJdER6cVhXWW10aElIdXpUcFVYRGJLZG4zTnRCY0lsSVdFM21HdjAz?=
 =?utf-8?B?VTUyTmtpZWJYcnh2SUxpcUxMVjVveTd3cytNN2ErZ0hENFhGMy9RQUdsWVN5?=
 =?utf-8?B?dExYNkNBZTFsSlRCSTcyYXZUUUd4YVhTcGg0MThjTUdDMTVKMmxiMWF3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXhRa2VHdWJ2Qm9Vd0hQU21Tc1hkQXR0aW5JL2Nwc1MwWjR0UFJLRnQveTlV?=
 =?utf-8?B?aUFJWTJTLzBCOXd2TkExanFpT1A4UnFhakIya1FPcDJXN2JVZXI0NUJUWHZB?=
 =?utf-8?B?MEwxbWdHWDZHNmdkUE9zaHFvMWQ3WW52MExEeXRoay9BMnhLTGpGSnBSZWpS?=
 =?utf-8?B?NElTRlFXV3NKcVVZSjRMNjE4WkU3SGhlVXk0NWd1QUFXaFc2Wlg0WFN3MllB?=
 =?utf-8?B?RmZhL0JYMy9NMXk2Rkh3SjY3WlYvL3VRbmpMY1FRZzlxQkVxMWxQY2N3TzNa?=
 =?utf-8?B?cFY3TCtKb2tPU083YmVyR3g1WXR6RnNTQjdNMHJTRklUSjJWSGZzcE1tQUQx?=
 =?utf-8?B?YjNSdUlYL3NteUlkVHNoMFNjKzBFYlRnTmNSTXJPUVg3WHVmVitqM1Zuc2hk?=
 =?utf-8?B?M3pWMnJ2d09KK1dQbERjaXpCVklPOGk3di9GZ1FzbmI3aGpBd1RpU080OTVh?=
 =?utf-8?B?UW1LZmtoMVV5ZE95Z2N2NW5rUExmWkg2SklFWnVOK2FZeVZxVndabzd0SDBB?=
 =?utf-8?B?dG5lRHIrUmZ5RjZwdlVDY0EySmtTMElhVkNpc09DcDE5dG9jUWdpWVJxL1ho?=
 =?utf-8?B?bGcwSzhaUHpVWE9wYWp6dzBDbnJTVHdiTEs2SFFPRnY1eDRMWldOWUx5Vzk2?=
 =?utf-8?B?UHNEUkR2b3pUcFdQQk02MS9zMFNEeGdETWZhcS9uWFkzYmE5aG1Kd0V2TXVY?=
 =?utf-8?B?TEhmMVNSeHdZSFR0QkUwM0Q5TVF4MlhkaWIrSDFYQ253Q2VSNVY0WUFFSUxO?=
 =?utf-8?B?dVI4b0pSbGU1VHFwNmxkejRzVnpyS21NNGR6ODN3aHVPUU5wK3c5Y3VBTmhy?=
 =?utf-8?B?TnQxeEJKMGRCWGY5K2xXZmF4c2QxQUNheTFhbEQ3VTlra2dQMGZLZjB1WFlr?=
 =?utf-8?B?STNkR29yR2kySHVsM1prd1d1d0ltVUU0RWhFMUhWMFFOQW9qMWt6SDliNlI5?=
 =?utf-8?B?YUxyUmJKenVFalZpMmFnOTZaZW5kQTJnQms0N2pXeGFUdlc3WTErNTlicWs5?=
 =?utf-8?B?bG1xWGdqSlowS29HazMrcUJoWHlHVGVvYmVUOUpUL2NYdTZZcGZZdFJ3S0hD?=
 =?utf-8?B?YllSMUtGNVlLNVFTNTdEMDhYTFRzdVZxUWU4VlJaeTEwVTJZMmxaY25JNlR0?=
 =?utf-8?B?ZEZ0M3FkS0JjNkUzVTNxQUZXaFlpamduaERHc0NjdjMzQVJTeVBBd20wa0Jz?=
 =?utf-8?B?dDhKMisvUzk2Z0J1YkhGV3NHRjVVZVdvbUQyY3ZYbW1jejlkVkZ5Q0hoVXFi?=
 =?utf-8?B?dnp5bjFyMWF5LzVzdlcwamw3SWZldFM0VERBSlpFOFNGNVdYdEkwc2xHZG96?=
 =?utf-8?B?THlacCtwaHMyck5QMFZxVUZNUDEzUituS01va1dnRHFJTktQZDRoSGR6SzI5?=
 =?utf-8?B?YVJqKzV0TWhtVEduK0s3Y20vWTFHeXprdFk5dHduUlhPN2pVMEllNy9ZUDlS?=
 =?utf-8?B?Z2dXY3NoSVptSnNzLzJ5WkFUdksvZEQ0UE9HUEw3ZlVMWGY3Z2REWGVMVWpN?=
 =?utf-8?B?UmtINEdjR2VwcXR6ZkRMUUxBNUx3Q1djU2p4aVdCSDcwUUJzK25qcUxBV3gw?=
 =?utf-8?B?ZjI4bkU5RGVISmpjRzZFRks0bGVWR2ZyVVQ3cXo2Qk95aGNXSXJ1eUNaSzBm?=
 =?utf-8?B?S3Bpbk1XQkRXZTg3VkpYckh0cjhTQTFjYmJwZzRjbHlvbHdmdTU0cWNEL2tW?=
 =?utf-8?B?aDVOeXBHSE9sOU9OUmUxb0V5STQxdUxrRy8yOTFYWTFhVGNWa21VM2Y1bWdE?=
 =?utf-8?B?VkIyNmhFYUxqMTdPME1qTjhPTytFWXhaeGkwN21mZkx5WHlqaGtYQU9NY2I4?=
 =?utf-8?B?SGM5VEMyQUt2VEVCM3VYaldsS0RtRDgyNWlaZXUzVDRCRThDa0t1bURXUk5v?=
 =?utf-8?B?bC9RMWZoeDErMjlESzdKcWVIdGphWXNXK1VOVXN2T2ovWDIxSVk1SGgrcVlx?=
 =?utf-8?B?dWFmTHZkYis1bWhlNE81M2hOdlhNSmZBV0l1SjRLcG9WdFJqK29sTW5CQnlJ?=
 =?utf-8?B?bklaQWpwQS92bStkL1R0ZjQwVkY5L3JLSEZFNG9VL1VtNU5PeUtrQ0V5RTJ4?=
 =?utf-8?B?ZHpZUjEzVThTZy9DRVhoVDlmbEZCS3dpcnlWdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1d013d-cccb-4ad1-be3f-08dc7e28be68
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 08:41:03.7558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OBSC/w5mLvNrc+z2LbR6/5EEdhSUG2P771m7axiE+bUMtwd9h4EVyuPqmPMII7DCCVX/m8DIivsd4T7jjcZMMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8670

SGkgU2hhd24sDQoNCj4gU3ViamVjdDogW1BBVENIIHY1IDAvM10gYXJtNjQ6IGR0czogYWRkIGku
TVg5NSBhbmQgRVZLIGJvYXJkDQoNCldvdWxkIHlvdSBwaWNrIHRoaXMgcGF0Y2hzZXQsIG9yIGFu
eSBjb21tZW50cz8NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gQWRkIGEgbWluaW1hbCBpLk1Y
OTUgZHRzaSBhbmQgRVZLIGJvYXJkIGR0cy4NCj4gaS5NWDk1IGhhcyBhIE0zMyBydW5uaW5nIFND
TUkgZmlybXdhcmUsIGJ1dCBhcyBvZiBub3csIHRoZSBzY21pIHBpbmN0cmwNCj4gZHJpdmVyIHN0
aWxsIG5vdCByZWFkeSBmb3IgaS5NWDk1LCBzbyB3ZSBjb3VudCBvbiBib290bG9hZGVyIHRvIGNv
bmZpZ3VyZSB0aGUNCj4gcGluY3RybCBmb3IgbHB1YXJ0IGFuZCBzZGhjIGFuZCBpdCBib290cyB3
ZWxsLiBBZnRlciBwaW5jdHJsIGRyaXZlciByZWFkeSwgd2UNCj4gY291bGQgbW92ZSB0byB1c2Ug
c2NtaSBwaW5jdHJsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54
cC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHY1Og0KPiAtIERyb3AgdW51c2VkIHJlZ3VsYXRv
ciBhbmQgYWxpYXMgZm9yIG5vdy4NCj4gLSBGaXggQ0hFQ0tfRFRCIHdhcm5pbmcuDQo+IC0gTGlu
ayB0byB2NDogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDUwMy1pbXg5NS1kdHMtdjMt
djQtMC0NCj4gNTM1ZGRjMmJkZTczQG54cC5jb20NCj4gDQo+IENoYW5nZXMgaW4gdjQ6DQo+IC0g
U29ydCBub2RlcyBieSBhZGRyZXNzDQo+IC0gRHJvcCBjb3Jlc2lnaHQgbm9kZXMNCj4gLSBBbGln
biBjbG9jayByYXRlcyBmb3IgU0RIQzEtMw0KPiAtIERyb3Agd2RvZzMgYm9hcmQgc3BlY2lmaWMg
cHJvcGVydHkNCj4gLSBMaW5rIHRvIHYzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQw
NDI4LWlteDk1LWR0cy12My12My0wLQ0KPiA3NjUzOTVmODhiOWZAbnhwLmNvbQ0KPiANCj4gQ2hh
bmdlcyBpbiB2MzoNCj4gLSBEcm9wIGlycXN0ZWVyIG5vZGUgYmVjYXVzZSBiaW5kaW5nIG5vdCBh
Y2NlcHRlZA0KPiAtIFBhc3MgZHRic19jaGVjaw0KPiAtIExpbmsgdG8gdjI6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3IvMjAyNDAyMjYtaW14OTUtZHRzLXYyLTAtDQo+IDAwZTM2NjM3YjA3ZUBu
eHAuY29tDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIEFkZHJlc3NlZCBSb2IgYW5kIEtyenlz
enRvZidzIGNvbW1lbnRzLCBhbmQgZml4IGR0c19jaGVjayBpc3N1ZQ0KPiAgIFRvIHBhc3MgdGhl
IGR0YnNfY2hlY2ssIG5lZWQgYXBwbHk6DQo+ICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
LzIwMjQwMjI2MDcwOTEwLjMzNzkxMDgtMS0NCj4gcGVuZy5mYW5Ab3NzLm54cC5jb20vDQo+ICAg
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwMjI2MTMwMjQzLjM4MjA5MTUtMS0NCj4g
cGVuZy5mYW5Ab3NzLm54cC5jb20vDQo+ICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIw
MjQwMjI2MTMwNTE2LjM4MjE4MDMtMS0NCj4gcGVuZy5mYW5Ab3NzLm54cC5jb20vDQo+ICAgaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwMjI2MTMwODI2LjM4MjQyNTEtMS0NCj4gcGVu
Zy5mYW5Ab3NzLm54cC5jb20vDQo+ICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQw
MjE5LWlteC1tYWlsYm94LXY4LTEtDQo+IDc1NTM1YTg3Nzk0ZUBueHAuY29tLw0KPiANCj4gLSBM
aW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQwMjE4LWlteDk1LWR0cy12
MS0wLQ0KPiAyOTU5Zjg5ZjIwMThAbnhwLmNvbQ0KPiANCj4gLS0tDQo+IFBlbmcgRmFuICgzKToN
Cj4gICAgICAgZHQtYmluZGluZ3M6IGFybTogZnNsOiBhZGQgaS5NWDk1IDE5eDE5IEVWSyBib2Fy
ZA0KPiAgICAgICBhcm02NDogZHRzOiBmcmVlc2NhbGU6IGFkZCBpLk1YOTUgYmFzaWMgZHRzaQ0K
PiAgICAgICBhcm02NDogZHRzOiBmcmVlc2NhbGU6IGFkZCBpLk1YOTUgMTl4MTkgRVZLIG1pbmlt
YWwgYm9hcmQgZHRzDQo+IA0KPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Fy
bS9mc2wueWFtbCAgICB8ICAgIDYgKw0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
TWFrZWZpbGUgICAgICAgICAgICB8ICAgIDEgKw0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OTUtMTl4MTktZXZrLmR0cyB8ICAgNzAgKysNCj4gIGFyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDk1LWNsb2NrLmggICAgICAgfCAgMTg3ICsrKysNCj4gIGFyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDk1LXBvd2VyLmggICAgICAgfCAgIDU1ICsrDQo+ICBh
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5NS5kdHNpICAgICAgICAgIHwgMTA1MA0K
PiArKysrKysrKysrKysrKysrKysrKysNCj4gIDYgZmlsZXMgY2hhbmdlZCwgMTM2OSBpbnNlcnRp
b25zKCspDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogYmI3YTI0NjdlNmJlZWY0NGE4MGExN2Q0NWVi
ZjI5MzFlNzYzMTA4Mw0KPiBjaGFuZ2UtaWQ6IDIwMjQwNDI4LWlteDk1LWR0cy12My1iZWU1OWYw
ZTU1OWINCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gUGVuZyBGYW4gPHBlbmcuZmFuQG54
cC5jb20+DQoNCg==

