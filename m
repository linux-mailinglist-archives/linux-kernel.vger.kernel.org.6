Return-Path: <linux-kernel+bounces-526682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9AEA401F9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEAD6860437
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245E1253F2D;
	Fri, 21 Feb 2025 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jp9boDnP"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2084.outbound.protection.outlook.com [40.107.104.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F423255E3C;
	Fri, 21 Feb 2025 21:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740172599; cv=fail; b=gzxT42uV+9GxVJG8QD+mTAyhphdci+4CSH7t0D9NfQiM5DKUUkYRokrl/vQ5SuzCAPinM2Dgmlx9He+940+F0cDXaBbJ9c1JJef8CpIDiNXVqH/03gJjZoihGyGZlncwlmf7YsuNXjg1f1W5HLHGKS6V1lCZB0t61tsaPKZ64J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740172599; c=relaxed/simple;
	bh=uZf/yc8aPzFm8+4/TkQDcILvJsD9uOGMCKlm66WN02g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ajE60X/lTt+foPqlIt6L3wVZz3Mzplkk5iac6dvv0V4Sn9z9RQT6frTT6n2VYRPihwXu6uGKLyZpny/DyTZfFv6uZNJAB6xkrHbCfZGaP4pCKGfXrzcZ0vAkPUw3pziOXFHISdFTTOcZlDqt1bMidWqGdi9QZueEEc5uubRsbhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jp9boDnP; arc=fail smtp.client-ip=40.107.104.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJeTeuh352DgcL6sKqLX8plp9uu4a/FvOqfkOZ6m2XTPfIG5lBsfTCdSJDLJYxcXXSsKRjr93DXFb080TUou4P99PpWf+p1NAckLoj01uF2CD4KJj8/NBYmTzNeFnDp3UfZ/7fwaIjxuLGjJbnoswgsdKFnKzgDVryxVlvhz9iCVaO3z+D8i11uqtUIPq93+HV2izRej37nnmDRyY0gCdrY6LHfxoLTbiswS0nDVXgNPq3EV5KSn+Qq1J89D+CtO5wE5vbZM0d6A4MSF8tp9v+cRHqbS0pzAnluSWykTJuEVt2mXLBz00WGWou7K1jXE+17j364v4H4bBUlGGD3D1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhMruMkonpUbQRgCgq8nqgmU09UcQZP6//sOG4efqio=;
 b=qubz0/m9I7B7a6QY4C1PehEeKt9ZEBLWShzAUDLThAbkF9Z+QpUORPwMYr5ApipBW6skkacuUNtDSKRiLoEvFNqPngPL8edpQtOXB60i643woP1ebT5CjwzmS2etNVFRriioQJd7OopNEH6BVMp8sT9c5DGQNtxpULf7rdeZg2fDXZjU+2uMfzbZxIgX/BIcWSUR2lmvjeDCVxv36Cc9hUClBudzC7A3WEZjRa/q/+knlG/cPu0Bj2ERd9/42BkVvwuoUiBwXRpEn52lPLvTcDC7rimo+2jaKfoq/ijAsSsG5e1MtBwzjIcWg77k1iPbMYiFFW1fuAp8+nvnXr2wAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhMruMkonpUbQRgCgq8nqgmU09UcQZP6//sOG4efqio=;
 b=Jp9boDnPJAYHBJnw8fqur76brKUqQZzcPaV415f0vT/o1Ojhb+FkPd7povEfa8NbzWIjSIePqq0zcAL5q/HS1t9ClUaPtBV7KkPC2miKQqIEH+88T/qhuyMVN68sIg3cRIf+M0YOkwRgOPjljWVGWoUBFlAAjgk+/maqgY68Kw+aH82QPTY6HzSJRuTaY+LLiZJYzAWs2F6k481zxtXe8t0vbIdrZoA7D/GiRdmID4mRCumBgH1rIUrHQ4IYLAAneFQmBJZinYhrOKHc+swzT8OpI0U/A2JAzbDkEH4XJQH4iUqB8mBSBF/WqmWHxNOZnZbTgqK28dBcsb/Ni5b2og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8925.eurprd04.prod.outlook.com (2603:10a6:102:20c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 21 Feb
 2025 21:16:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 21:16:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 21 Feb 2025 16:16:00 -0500
Subject: [PATCH v4 4/4] arm64: dts: imx95: Add imx95-15x15-evk support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-imx95_15x15-v4-4-385ee8e03dfd@nxp.com>
References: <20250221-imx95_15x15-v4-0-385ee8e03dfd@nxp.com>
In-Reply-To: <20250221-imx95_15x15-v4-0-385ee8e03dfd@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740172577; l=30765;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=uZf/yc8aPzFm8+4/TkQDcILvJsD9uOGMCKlm66WN02g=;
 b=50wL0CSyZm7qbrxZ3Zl2iUr3/N3KRQ633uJc1DIAsIe+vanmCKzWrZSqgxKRgRtOubr5vQq71
 1uREYB00iA3DW83mwQ6VM6nP7MuQx1DocEVv6J8bxzuy+w/gkl0P6Mp
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d4d5b7-322e-4acd-5eb4-08dd52bd0494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ektwOU5xOGU3b1JUTEY2OXNUUm1yZVoxdVhpKy9FeUdVY3BneS95QWNrSHpB?=
 =?utf-8?B?RTRubFoxb09XN3h3aDFMSG9pb3Uxa0VmZTFEaG1iYmdvRjF5SjByaVo0c2dl?=
 =?utf-8?B?aXNTNFNuYnkyc3ozcTJpZGRXTGlRNTluZjNhTnQzRm0yaGw1Qlh2YTBZOHVJ?=
 =?utf-8?B?clVISFB3NUtuS096Y2haU25qZGlOaG9RQTcrRnFSSC9YRjFsOHNib2JxRnU0?=
 =?utf-8?B?M09XaWloang5MDkrWllvbGdic0VmZklFRHZIenZiQk1kV05CZ2RRV3Qyc1V6?=
 =?utf-8?B?WWgrTVE0ZVVNbERqV0N6bit1UUx2aWFxbTJ5dktZL2RDejFCcFhHOFhJOTEx?=
 =?utf-8?B?ZXlMSTIrTjZQR0RsbldnZmRiM2xRUGJrZEJVL2hYMXRoTkk2Nk9sM3JCT0N6?=
 =?utf-8?B?Q2x6a0JnQnJ1QjJyRk5DKzcxcTd6RVZVWFF4UXMvTEZoSTM1clZPcFpDRU5I?=
 =?utf-8?B?SVU0ZjZLUkkwVDkwcXorVm1YVU9Mbm4vdi9YNnJkQ1lmYWtOOE9VYWZLYkVX?=
 =?utf-8?B?SytCWm1TUGJyZ0RQRHdzZWFCZTdyQ0RkcWlrVDJpSzl3Y0c0Wlc1M0xUQi9B?=
 =?utf-8?B?L2VzeWRiSzRvK3BtNVFOOS9LdmFqeWNwYXdGSlRGR1dEZmZLekdBZ0JJMHF0?=
 =?utf-8?B?bENpL0JGWlhCQUExa2prN0pUbVVQaG9oc1NTRDZHdkNKdVkvZUg2N3p0NlMy?=
 =?utf-8?B?VGdUZU9LOGY0ekZCUHIxdUVHWHZvaHRwUjNjRm9Lbm1PaTBURmllZnlhaHF0?=
 =?utf-8?B?eEc1NnI3WVJOMUpoVVhIQXBvUU1GendmLys0UDJ5dmRidjZleExsZlBUYTdZ?=
 =?utf-8?B?aENzTGtEcDUxdjNwN3o4UG5vb2c5ZVZzdnEwQUZDWk93OHdGRHVJUkdwdlJQ?=
 =?utf-8?B?azBNQm8za1NXT25BSEptaUFhWTZ5RStRc2FLNGs2T29TWjVIZlhtMWRBM1R5?=
 =?utf-8?B?RDJBR1locklEWng5UkVkZGxBMytjWlJ1UzJsVFJXMVJrVHA3aEljQ08zTSt6?=
 =?utf-8?B?MjhZclhReFBSSUp1bGxNTFI3MlFhMTJtSVc1VGJ5cmFvMUhmVTJ5QUlPck9V?=
 =?utf-8?B?d0xqMndFQ205dXZSaTVWZFh4OVAwK1N1S3NKbU45aVV0Rzk2dlF2TloyTXov?=
 =?utf-8?B?bDVzSHI5Ly9vcS9lRjZkWDk5dlNlWXc4MGhzcmZldDJJSVd1c3hjZXRvWUVF?=
 =?utf-8?B?SkRnY1lHNUNqaHFkenk5UWlVTHVVNjhsRXFocWxmTEVpYTlxd0o2Z1VUQmFZ?=
 =?utf-8?B?VmYzQzJYNXN6Vi9LeWcyMjMvdzlUc2JuZjlURkVnanp0cDJPeGZuYUhOR05u?=
 =?utf-8?B?aW80ZzU3WVJNRFByR3B1N0FISTR5aFRNcHY1WjQvY1M4c3FsbmRvbEg4K1hK?=
 =?utf-8?B?eTFUSGhJM3dhTENZN0tlVWNTWFVKU2plbm5qYUt0MTFOK0JUSldyWThBMC9j?=
 =?utf-8?B?RXFvMUo1ejJtQktUY2hzR0NTcGxyMi9ZOEJ6RFhMeGhjSWN1azJFM2lxdktZ?=
 =?utf-8?B?VURKWTh2TTVYWG5sTjNoblBoYWJSaTFSaU1JMk1JSGlmeG01WGZ0RTVkU1V0?=
 =?utf-8?B?bWR1SkxFSEp5NU1RYXUzOFVGZXhCQ2xaVDlWV2x2U3ZUWndlZXBKaHI3QzhC?=
 =?utf-8?B?SzNqTFZ3MW1IUXZsYXVPK3o0aE5zdHI1TURIV0ZIRDFySGZwcWJYV3lZUGtp?=
 =?utf-8?B?bVlqVjN0N1RqUDY5SG9VZW8vNWkzY3lPRmlmUnUvNFdxY0ZQZk1qM1BkT2F6?=
 =?utf-8?B?SHZhOE5xQldtUTNvTytpKzVHSXVXODRaRjJtQ01SSjdvanVENVN0Wjh4a2xL?=
 =?utf-8?B?Kzk0bVpMZUc1UjhXbVFmU3Qyd0RkRFkxQ3J6RXZIUmFxZHZZTld2YnJlU1JY?=
 =?utf-8?B?aEJRYithbGY5a29aSzBjSzRmRVY5M1BpK1AzdElJelNaazhhTjc0T3hhdnN3?=
 =?utf-8?Q?qB78FYtTzIUWebeMTqJTD8Jm2gTRR3ts?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmZGTmo3TFVOTjAycC9HK0RDMmJwRGkwT2NsL1c0NGFtR1AzbTUyaTNLMG1H?=
 =?utf-8?B?VTRmcUhiY2QxeDRBeXVDaDcwd3RyZldYaTBqSnV0UXpFS1VubnhZM2xwSGlt?=
 =?utf-8?B?eWVVUHdDVjRHQzl5a1BHWGs0RVYrQk9MNWlraDFzU0RGQzFhSEhUSXh1T1Rs?=
 =?utf-8?B?Q2ZEYnNLeXVVRklhQjJGb2YwNzRPN1RNakdsWXB2M3JWeGtRU1BHS1dxSzR0?=
 =?utf-8?B?TGUwRnZqdjRvT1Y0dDl3VDlRZm93Q0M4RHk4L1RpZjh2TUJXSzQ3amtScjlB?=
 =?utf-8?B?QURCcHV0TjQ3ZWZHUWtqQ2JWMHRTcW9kdGlFcmwzNnh6YXI5aHBtZmpNczlS?=
 =?utf-8?B?RzhmZnUzQnZUWUdSVVZ2bThCaUhsUk55dkNrQzVKR0tRZXAvMzYrNmh5eVRm?=
 =?utf-8?B?dVl4eWdWcldGcE5KeklLTklGbDBnV3VYUlZDaHNkWXJQcVhmaXdncnNvdzBO?=
 =?utf-8?B?OWlxTnBLeWNMN2tUdmFrNWpMV3A4T3Y2ZGY0d2l2WDV4U3E3SXBmWlcwLzJl?=
 =?utf-8?B?MEJBWDBrdGxBVDZ5cGwxdkN3dXFTVlQ3YnRXZ2pYQXVCcWw0RitzeVhwTEFp?=
 =?utf-8?B?c3RLbVhwbVYvTjZNdkVQaWx1V0N3RUNERmVrRjhjRlMyYUVRQnQ2Y0luTDZa?=
 =?utf-8?B?TXNsNjAvb3EwVlRvWG5xc0Y4Ti9RS3R1djg3VFV5ZjAzbkZqWDIvVGYwRUNn?=
 =?utf-8?B?TzFiKzlxUFJuMkN3alVpSWo3K3V0OEowMGlWanZneGMwTUJtT2pMT2JWTEpC?=
 =?utf-8?B?MHVIL1JxOEJqbUlCZUhnWDlZRFFlNHAwSFJjcTFPUW9TWEhjeHpTZE5PMnhu?=
 =?utf-8?B?NE9LZlFWVkwyVzZGSTlJWHdGMitEc004QmFWNDd4UU9HeEF3NE5GNThDbmQ4?=
 =?utf-8?B?OGRla0xVOER1MkVTSzRiczdZV05VakpUVzZQZmtjK2ZvT25CalU3cGN3dVZt?=
 =?utf-8?B?UUt1V1IxSXp2bytGRkh0WVlCbVRlcnFsNVBIaEhyTWdhSDYzSUFqMEVLa3hT?=
 =?utf-8?B?bnVCaEpCZmpBdHBWMW5GajBoQU9LS01ZUTg0OVFvN3lrYVNkY0pVSjlSOFcz?=
 =?utf-8?B?QlViSVk5QkF6Y1BWcElwY0pNQmVpRjVlcWxiTVErSmJ4NUttZi90UzI4K1Jm?=
 =?utf-8?B?RWppZ3I3d1F3TW81UE1NZlZZQityMGlQR0FPdUJQZWxuRHR1empmQXBneG9x?=
 =?utf-8?B?Z2Iyek5MdTVQZEpKNGw5emdFUDVIa1hZRXVTN29WeGpuK3NTRy9EU2orWnM5?=
 =?utf-8?B?T05LbEVnUGllVlNUYm9BNUUyaUdHcVErSUlHZm51OXJnSHBPUnYxTEo1L0pj?=
 =?utf-8?B?UnFmNkE1alczQWxjRmVOR0Z1b1lxY3RjQzJMQmNGTVBXMmpMK3ZyUVpNTWVR?=
 =?utf-8?B?djlzajdYQURGVEY1MjVqNGw0OEhpaHR0TWpZemNSd0FnMlRldVIwTCtOOWhT?=
 =?utf-8?B?TGFmVzRrOW1WNWUvNWFrbzYxWEZxcTZpUDV6dHdJZmNYcFU4YVQ0cFQ5dFQz?=
 =?utf-8?B?dHZUbDc0YUJYUW9tWHlpNGhiNVRuOUJFZE4zeWpsUkh1bjJqdFRRSTdBTmlB?=
 =?utf-8?B?cUpuM0k0WWNBeWtpa1VJN3cxTi9waHpxZWM1SkdGQXMvR3NEd1d3Z1ZPMnVN?=
 =?utf-8?B?YUpxV3Rwb1kydElRdVl5d09FclJRejFydDVhSUgyWHIzQ0RSY3ZVOW53cFNp?=
 =?utf-8?B?aG44ZmpIYmZEMGtwZjVGbFBsaWNOUnJ3R09vRWdHZWQvTEpOVTZWT3FnR3dB?=
 =?utf-8?B?TmZ6YjgydXIzZzNHZUlhOC9OZXRBenFjQlVqZFFKcDFTS3gzUDA2Z1JyYjVS?=
 =?utf-8?B?d1liNXhHV1ZBUzVydVJCNEZwQlF0RzNZanVYRjJxMlJxL3hTbUVRWFZJb1dS?=
 =?utf-8?B?K2tKdVQvM2ZyWFhLK3BpSDczUU1WcDJ1NUFVZzZqeUxHb1g5cExsZ0ZtSDF3?=
 =?utf-8?B?SkZkekRJL2F1bExVajhjb3kyalRGN3dxNmdGaWM5OTJQNU5kNzE5Y0Y3cUV2?=
 =?utf-8?B?cEdmOFZjZDZFbFFvaXM5QkxyckRkbzhlWm9aVHVTSjJZZ29TWjFFRTcwMzl5?=
 =?utf-8?B?aUNSem1sVktmbk50MS8rVWk4MCs2UUw4aDB1dHZwYjZTL21CeUpvb2NhbXcv?=
 =?utf-8?Q?paNrSR2KhC06S3/+yI1teioAZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d4d5b7-322e-4acd-5eb4-08dd52bd0494
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 21:16:34.3172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iICyCc0WWWpyRZtt5VM727jLdELLBiafJ4yCErwG5UKePxrBpytXo70TTBEU5ELlD4kp49iHWgK5u6YzmkiTwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8925

Add imx95-15x15-evk support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- add usb3 and typec
- remove regulator-vbus

change from v2 to v3
- remove a empty line
- remove undocument property fsl,cd-gpio-wakeup-disable. (Need double check
why DTB_CHECK have not report warning for it).
---
 arch/arm64/boot/dts/freescale/Makefile            |    1 +
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 1130 +++++++++++++++++++++
 2 files changed, 1131 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 839432153cc7a..a2fd3a32e351e 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -281,6 +281,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx95-15x15-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
 
 imx8mm-kontron-dl-dtbs			:= imx8mm-kontron-bl.dtb imx8mm-kontron-dl.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
new file mode 100644
index 0000000000000..514f2429dcbc2
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -0,0 +1,1130 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 NXP
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/i3c/i3c.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+#include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/usb/pd.h>
+#include "imx95.dtsi"
+
+#define FALLING_EDGE		BIT(0)
+#define RISING_EDGE		BIT(1)
+
+#define BRD_SM_CTRL_SD3_WAKE		0x8000
+#define BRD_SM_CTRL_PCIE1_WAKE		0x8001
+#define BRD_SM_CTRL_BT_WAKE		0x8002
+#define BRD_SM_CTRL_PCIE2_WAKE		0x8003
+#define BRD_SM_CTRL_BUTTON		0x8004
+
+/ {
+	compatible = "fsl,imx95-15x15-evk", "fsl,imx95";
+	model = "NXP i.MX95 15X15 board";
+
+	aliases {
+		ethernet0 = &enetc_port0;
+		ethernet1 = &enetc_port1;
+		serial0 = &lpuart1;
+	};
+
+	bt_sco_codec: bt-sco-codec {
+		compatible = "linux,bt-sco";
+		#sound-dai-cells = <1>;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		stdout-path = &lpuart1;
+	};
+
+	fan0: pwm-fan {
+		compatible = "pwm-fan";
+		#cooling-cells = <2>;
+		cooling-levels = <64 128 192 255>;
+		pwms = <&tpm6 0 4000000 PWM_POLARITY_INVERTED>;
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "+V1.8_SW";
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3_SW";
+	};
+
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "vref_1v8";
+	};
+
+	reg_audio_pwr: regulator-audio-pwr {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "audio-pwr";
+		gpio = <&pcal6524 13 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_audio_switch1: regulator-audio-switch1 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "audio-switch1";
+		gpio = <&pcal6524 0 GPIO_ACTIVE_LOW>;
+	};
+
+	reg_can2_stby: regulator-can2-stby {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "can2-stby";
+		gpio = <&pcal6524 14 GPIO_ACTIVE_LOW>;
+	};
+
+	reg_m2_pwr: regulator-m2-pwr {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "M.2-power";
+		gpio = <&pcal6524 10 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		off-on-delay-us = <12000>;
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "VDD_SD2_3V3";
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usdhc3_vmmc: regulator-usdhc3 {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "WLAN_EN";
+		vin-supply = <&reg_m2_pwr>;
+		gpio = <&pcal6524 11 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		/*
+		 * IW612 wifi chip needs more delay than other wifi chips to complete
+		 * the host interface initialization after power up, otherwise the
+		 * internal state of IW612 may be unstable, resulting in the failure of
+		 * the SDIO3.0 switch voltage.
+		 */
+		startup-delay-us = <20000>;
+	};
+
+	reg_vcc_12v: regulator-vcc-12v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <12000000>;
+		regulator-min-microvolt = <12000000>;
+		regulator-name = "VCC_12V";
+		gpio = <&pcal6524 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		linux_cma: linux,cma {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0 0x80000000 0 0x7F000000>;
+			reusable;
+			size = <0 0x3c000000>;
+			linux,cma-default;
+		};
+
+		vdev0vring0: vdev0vring0@88000000 {
+			reg = <0 0x88000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: vdev0vring1@88008000 {
+			reg = <0 0x88008000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: vdev1vring0@88010000 {
+			reg = <0 0x88010000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: vdev1vring1@88018000 {
+			reg = <0 0x88018000 0 0x8000>;
+			no-map;
+		};
+
+		vdevbuffer: vdevbuffer@88020000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x88020000 0 0x100000>;
+			no-map;
+		};
+
+		rsc_table: rsc-table@88220000 {
+			reg = <0 0x88220000 0 0x1000>;
+			no-map;
+		};
+
+		vpu_boot: vpu_boot@a0000000 {
+			reg = <0 0xa0000000 0 0x100000>;
+			no-map;
+		};
+	};
+
+	sound-bt-sco {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-inversion;
+		simple-audio-card,bitclock-master = <&btcpu>;
+		simple-audio-card,format = "dsp_a";
+		simple-audio-card,frame-master = <&btcpu>;
+		simple-audio-card,name = "bt-sco-audio";
+
+		simple-audio-card,codec {
+			sound-dai = <&bt_sco_codec 1>;
+		};
+
+		btcpu: simple-audio-card,cpu {
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <16>;
+			sound-dai = <&sai1>;
+		};
+	};
+
+	sound-micfil {
+		compatible = "fsl,imx-audio-card";
+		model = "micfil-audio";
+
+		pri-dai-link {
+			format = "i2s";
+			link-name = "micfil hifi";
+
+			cpu {
+				sound-dai = <&micfil>;
+			};
+		};
+	};
+
+	sound-wm8962 {
+		compatible = "fsl,imx-audio-wm8962";
+		audio-codec = <&wm8962>;
+		audio-cpu = <&sai3>;
+		audio-routing = "Headphone Jack", "HPOUTL", "Headphone Jack", "HPOUTR",
+				"Ext Spk", "SPKOUTL", "Ext Spk", "SPKOUTR", "AMIC", "MICBIAS",
+				"IN3R", "AMIC", "IN1R", "AMIC";
+		hp-det-gpio = <&gpio2 21 GPIO_ACTIVE_HIGH>;
+		model = "wm8962-audio";
+		pinctrl-0 = <&pinctrl_hp>;
+		pinctrl-names = "default";
+	};
+
+	sound-xcvr {
+		compatible = "fsl,imx-audio-card";
+		model = "imx-audio-xcvr";
+
+		pri-dai-link {
+			link-name = "XCVR PCM";
+
+			cpu {
+				sound-dai = <&xcvr>;
+			};
+		};
+	};
+
+	usdhc3_pwrseq: usdhc3-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-0 = <&pinctrl_usdhc3_pwrseq>;
+		pinctrl-names = "default";
+		reset-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
+	};
+
+	memory@80000000 {
+		reg = <0x0 0x80000000 0 0x80000000>;
+		device_type = "memory";
+	};
+};
+
+&adc1 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
+&enetc_port0 {
+	phy-handle = <&ethphy0>;
+	phy-mode = "rgmii-id";
+	pinctrl-0 = <&pinctrl_enetc0>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&enetc_port1 {
+	phy-handle = <&ethphy1>;
+	phy-mode = "rgmii-id";
+	pinctrl-0 = <&pinctrl_enetc1>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&flexcan2 {
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	pinctrl-names = "default";
+	xceiver-supply = <&reg_can2_stby>;
+	status = "okay";
+};
+
+&i3c2 {
+	i2c-scl-hz = <400000>;
+	pinctrl-0 = <&pinctrl_i3c2>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	pca9570: gpio@24 {
+		compatible = "nxp,pca9570";
+		reg = <0x24 0 (I2C_FILTER)>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names = "OUT1", "OUT2", "OUT3", "OUT4";
+	};
+};
+
+&lpi2c2 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	wm8962: codec@1a {
+		compatible = "wlf,wm8962";
+		reg = <0x1a>;
+		clocks = <&scmi_clk IMX95_CLK_SAI3>;
+		AVDD-supply = <&reg_audio_pwr>;
+		CPVDD-supply = <&reg_audio_pwr>;
+		DBVDD-supply = <&reg_audio_pwr>;
+		DCVDD-supply = <&reg_audio_pwr>;
+		gpio-cfg = <
+			0x0000
+			0x0000
+			0x0000
+			0x0000
+			0x0000
+			0x0000
+		>;
+		MICVDD-supply = <&reg_audio_pwr>;
+		PLLVDD-supply = <&reg_audio_pwr>;
+		SPKVDD1-supply = <&reg_audio_pwr>;
+		SPKVDD2-supply = <&reg_audio_pwr>;
+	};
+
+	pcal6524: gpio@22 {
+		compatible = "nxp,pcal6524";
+		reg = <0x22>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupt-parent = <&gpio5>;
+		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		pinctrl-0 = <&pinctrl_pcal6524>;
+		pinctrl-names = "default";
+	};
+};
+
+&lpi2c3 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	ptn5110: tcpc@50 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x50>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&pinctrl_ptn5110>;
+		pinctrl-names = "default";
+
+		typec_con: connector {
+			compatible = "usb-c-connector";
+			data-role = "dual";
+			label = "USB-C";
+			op-sink-microwatt = <15000000>;
+			power-role = "dual";
+			self-powered;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_VAR(5000, 20000, 3000)>;
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			try-power-role = "sink";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec_con_hs: endpoint {
+						remote-endpoint = <&usb3_data_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					typec_con_ss: endpoint {
+						remote-endpoint = <&usb3_data_ss>;
+					};
+				};
+			};
+		};
+	};
+
+	pca9632: led-controller@62 {
+		compatible = "nxp,pca9632";
+		reg = <0x62>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		nxp,inverted-out;
+
+		led_backlight0: led@0 {
+			reg = <0>;
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_BACKLIGHT;
+			function-enumerator = <0>;
+		};
+
+		led_backlight1: led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_BACKLIGHT;
+			function-enumerator = <1>;
+		};
+	};
+};
+
+&lpi2c4 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_lpi2c4>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&lpi2c6 {
+	clock-frequency = <100000>;
+	pinctrl-0 = <&pinctrl_lpi2c6>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&lpuart1 {
+	pinctrl-0 = <&pinctrl_uart1>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&lpuart5 {
+	pinctrl-0 = <&pinctrl_uart5>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	bluetooth {
+		compatible = "nxp,88w8987-bt";
+	};
+};
+
+&micfil {
+	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
+			  <&scmi_clk IMX95_CLK_PDM>;
+	assigned-clock-parents = <0>, <0>, <0>, <0>, <&scmi_clk IMX95_CLK_AUDIOPLL1>;
+	assigned-clock-rates = <3932160000>, <3612672000>, <393216000>, <361267200>, <49152000>;
+	#sound-dai-cells = <0>;
+	pinctrl-0 = <&pinctrl_pdm>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&mu7 {
+	status = "okay";
+};
+
+&netc_blk_ctrl {
+	status = "okay";
+};
+
+&netc_bus0 {
+	msi-map = <0x00 &its 0x60 0x1>,	//ENETC0 PF
+		  <0x10 &its 0x61 0x1>, //ENETC0 VF0
+		  <0x20 &its 0x62 0x1>, //ENETC0 VF1
+		  <0x40 &its 0x63 0x1>, //ENETC1 PF
+		  <0x50 &its 0x65 0x1>, //ENETC1 VF0
+		  <0x60 &its 0x66 0x1>, //ENETC1 VF1
+		  <0x80 &its 0x64 0x1>, //ENETC2 PF
+		  <0xc0 &its 0x67 0x1>;
+};
+
+&netc_emdio {
+	pinctrl-0 = <&pinctrl_emdio>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	ethphy0: ethernet-phy@1 {
+		reg = <1>;
+		reset-assert-us = <10000>;
+		reset-deassert-us = <80000>;
+		reset-gpios = <&pcal6524 4 GPIO_ACTIVE_LOW>;
+		realtek,clkout-disable;
+	};
+
+	ethphy1: ethernet-phy@2 {
+		reg = <2>;
+		reset-assert-us = <10000>;
+		reset-deassert-us = <80000>;
+		reset-gpios = <&pcal6524 5 GPIO_ACTIVE_LOW>;
+		realtek,clkout-disable;
+	};
+};
+
+&netc_timer {
+	status = "okay";
+};
+
+&netcmix_blk_ctrl {
+	status = "okay";
+};
+
+&pcie0 {
+	pinctrl-0 = <&pinctrl_pcie0>;
+	pinctrl-names = "default";
+	reset-gpio = <&gpio5 13 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_m2_pwr>;
+	status = "okay";
+};
+
+&sai1 {
+	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
+			  <&scmi_clk IMX95_CLK_SAI1>;
+	assigned-clock-parents = <0>, <0>, <0>, <0>, <&scmi_clk IMX95_CLK_AUDIOPLL1>;
+	assigned-clock-rates = <3932160000>, <3612672000>, <393216000>, <361267200>, <12288000>;
+	#sound-dai-cells = <0>;
+	pinctrl-0 = <&pinctrl_sai1>;
+	pinctrl-names = "default";
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
+&sai3 {
+	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
+			  <&scmi_clk IMX95_CLK_SAI3>;
+	assigned-clock-parents = <0>, <0>, <0>, <0>, <&scmi_clk IMX95_CLK_AUDIOPLL1>;
+	assigned-clock-rates = <3932160000>, <3612672000>, <393216000>, <361267200>, <12288000>;
+	#sound-dai-cells = <0>;
+	pinctrl-0 = <&pinctrl_sai3>;
+	pinctrl-names = "default";
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
+&scmi_iomuxc {
+	pinctrl_emdio: emdiogrp {
+		fsl,pins = <
+			IMX95_PAD_ENET2_MDC__NETCMIX_TOP_NETC_MDC		0x57e
+			IMX95_PAD_ENET2_MDIO__NETCMIX_TOP_NETC_MDIO		0x97e
+		>;
+	};
+
+	pinctrl_enetc0: enetc0grp {
+		fsl,pins = <
+			IMX95_PAD_ENET1_TD3__NETCMIX_TOP_ETH0_RGMII_TD3		0x57e
+			IMX95_PAD_ENET1_TD2__NETCMIX_TOP_ETH0_RGMII_TD2		0x57e
+			IMX95_PAD_ENET1_TD1__NETCMIX_TOP_ETH0_RGMII_TD1		0x57e
+			IMX95_PAD_ENET1_TD0__NETCMIX_TOP_ETH0_RGMII_TD0		0x57e
+			IMX95_PAD_ENET1_TX_CTL__NETCMIX_TOP_ETH0_RGMII_TX_CTL	0x57e
+			IMX95_PAD_ENET1_TXC__NETCMIX_TOP_ETH0_RGMII_TX_CLK	0x58e
+			IMX95_PAD_ENET1_RX_CTL__NETCMIX_TOP_ETH0_RGMII_RX_CTL	0x57e
+			IMX95_PAD_ENET1_RXC__NETCMIX_TOP_ETH0_RGMII_RX_CLK	0x58e
+			IMX95_PAD_ENET1_RD0__NETCMIX_TOP_ETH0_RGMII_RD0		0x57e
+			IMX95_PAD_ENET1_RD1__NETCMIX_TOP_ETH0_RGMII_RD1		0x57e
+			IMX95_PAD_ENET1_RD2__NETCMIX_TOP_ETH0_RGMII_RD2		0x57e
+			IMX95_PAD_ENET1_RD3__NETCMIX_TOP_ETH0_RGMII_RD3		0x57e
+		>;
+	};
+
+	pinctrl_enetc1: enetc1grp {
+		fsl,pins = <
+			IMX95_PAD_ENET2_TD3__NETCMIX_TOP_ETH1_RGMII_TD3		0x57e
+			IMX95_PAD_ENET2_TD2__NETCMIX_TOP_ETH1_RGMII_TD2		0x57e
+			IMX95_PAD_ENET2_TD1__NETCMIX_TOP_ETH1_RGMII_TD1		0x57e
+			IMX95_PAD_ENET2_TD0__NETCMIX_TOP_ETH1_RGMII_TD0		0x57e
+			IMX95_PAD_ENET2_TX_CTL__NETCMIX_TOP_ETH1_RGMII_TX_CTL	0x57e
+			IMX95_PAD_ENET2_TXC__NETCMIX_TOP_ETH1_RGMII_TX_CLK	0x58e
+			IMX95_PAD_ENET2_RX_CTL__NETCMIX_TOP_ETH1_RGMII_RX_CTL	0x57e
+			IMX95_PAD_ENET2_RXC__NETCMIX_TOP_ETH1_RGMII_RX_CLK	0x58e
+			IMX95_PAD_ENET2_RD0__NETCMIX_TOP_ETH1_RGMII_RD0		0x57e
+			IMX95_PAD_ENET2_RD1__NETCMIX_TOP_ETH1_RGMII_RD1		0x57e
+			IMX95_PAD_ENET2_RD2__NETCMIX_TOP_ETH1_RGMII_RD2		0x57e
+			IMX95_PAD_ENET2_RD3__NETCMIX_TOP_ETH1_RGMII_RD3		0x57e
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO25__CAN2_TX				0x39e
+			IMX95_PAD_GPIO_IO27__CAN2_RX				0x39e
+		>;
+	};
+
+	pinctrl_hp: hpgrp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO21__GPIO2_IO_BIT21			0x31e
+		>;
+	};
+
+	pinctrl_i3c2: i3c2grp {
+		fsl,pins = <
+			IMX95_PAD_ENET1_MDC__I3C2_SCL				0x40000186
+			IMX95_PAD_ENET1_MDIO__I3C2_SDA				0x40000186
+		>;
+	};
+
+	pinctrl_lpi2c1: lpi2c1grp {
+		fsl,pins = <
+			IMX95_PAD_I2C1_SCL__AONMIX_TOP_LPI2C1_SCL		0x40000b9e
+			IMX95_PAD_I2C1_SDA__AONMIX_TOP_LPI2C1_SDA		0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			IMX95_PAD_I2C2_SCL__AONMIX_TOP_LPI2C2_SCL		0x40000b9e
+			IMX95_PAD_I2C2_SDA__AONMIX_TOP_LPI2C2_SDA		0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO28__LPI2C3_SDA				0x40000b9e
+			IMX95_PAD_GPIO_IO29__LPI2C3_SCL				0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c4: lpi2c4grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO30__LPI2C4_SDA				0x40000b9e
+			IMX95_PAD_GPIO_IO31__LPI2C4_SCL				0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c6: lpi2c6grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO02__LPI2C6_SDA				0x40000b9e
+			IMX95_PAD_GPIO_IO03__LPI2C6_SCL				0x40000b9e
+		>;
+	};
+
+	pinctrl_mipi_dsi_csi: mipidsigrp {
+		fsl,pins = <
+			IMX95_PAD_XSPI1_DATA6__GPIO5_IO_BIT6			0x31e
+		>;
+	};
+
+	pinctrl_pcal6524: pcal6524grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO34__GPIO5_IO_BIT14			0x31e
+		>;
+	};
+
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO32__HSIOMIX_TOP_PCIE1_CLKREQ_B		0x40000b1e
+			IMX95_PAD_GPIO_IO33__GPIO5_IO_BIT13			0x31e
+		>;
+	};
+
+	pinctrl_pdm: pdmgrp {
+		fsl,pins = <
+			IMX95_PAD_PDM_CLK__AONMIX_TOP_PDM_CLK				0x31e
+			IMX95_PAD_PDM_BIT_STREAM0__AONMIX_TOP_PDM_BIT_STREAM_BIT0	0x31e
+		>;
+	};
+
+	pinctrl_ptn5110: ptn5110grp {
+		fsl,pins = <
+			IMX95_PAD_XSPI1_SS1_B__GPIO5_IO_BIT11			0x31e
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			IMX95_PAD_SD2_RESET_B__GPIO3_IO_BIT7			0x31e
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			IMX95_PAD_SAI1_RXD0__AONMIX_TOP_SAI1_RX_DATA_BIT0	0x31e
+			IMX95_PAD_SAI1_TXC__AONMIX_TOP_SAI1_TX_BCLK		0x31e
+			IMX95_PAD_SAI1_TXFS__AONMIX_TOP_SAI1_TX_SYNC		0x31e
+			IMX95_PAD_SAI1_TXD0__AONMIX_TOP_SAI1_TX_DATA_BIT0	0x31e
+		>;
+	};
+
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			IMX95_PAD_ENET2_MDIO__NETCMIX_TOP_SAI2_RX_BCLK		0x31e
+			IMX95_PAD_ENET2_MDC__NETCMIX_TOP_SAI2_RX_SYNC		0x31e
+			IMX95_PAD_ENET2_TD3__NETCMIX_TOP_SAI2_RX_DATA_BIT0	0x31e
+			IMX95_PAD_ENET2_TD2__NETCMIX_TOP_SAI2_RX_DATA_BIT1	0x31e
+			IMX95_PAD_ENET2_TXC__NETCMIX_TOP_SAI2_TX_BCLK		0x31e
+			IMX95_PAD_ENET2_TX_CTL__NETCMIX_TOP_SAI2_TX_SYNC	0x31e
+			IMX95_PAD_ENET2_RX_CTL__NETCMIX_TOP_SAI2_TX_DATA_BIT0	0x31e
+			IMX95_PAD_ENET2_RXC__NETCMIX_TOP_SAI2_TX_DATA_BIT1	0x31e
+			IMX95_PAD_ENET2_RD0__NETCMIX_TOP_SAI2_TX_DATA_BIT2	0x31e
+			IMX95_PAD_ENET2_RD1__NETCMIX_TOP_SAI2_TX_DATA_BIT3	0x31e
+			IMX95_PAD_ENET2_RD2__NETCMIX_TOP_SAI2_MCLK		0x31e
+		>;
+	};
+
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO17__SAI3_MCLK				0x31e
+			IMX95_PAD_GPIO_IO16__SAI3_TX_BCLK			0x31e
+			IMX95_PAD_GPIO_IO26__SAI3_TX_SYNC			0x31e
+			IMX95_PAD_GPIO_IO20__SAI3_RX_DATA_BIT0			0x31e
+			IMX95_PAD_GPIO_IO19__SAI3_TX_DATA_BIT0			0x31e
+		>;
+	};
+
+	pinctrl_spdif: spdifgrp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO22__SPDIF_IN				0x3fe
+			IMX95_PAD_GPIO_IO23__SPDIF_OUT				0x3fe
+		>;
+	};
+
+	pinctrl_tpm3: tpm3grp {
+		fsl,pins = <
+			IMX95_PAD_CCM_CLKO2__GPIO3_IO_BIT27			0x51e
+		>;
+	};
+
+	pinctrl_tpm6: tpm6grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO08__TPM6_CH0				0x51e
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX		0x31e
+			IMX95_PAD_UART1_TXD__AONMIX_TOP_LPUART1_TX		0x31e
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			IMX95_PAD_DAP_TDO_TRACESWO__LPUART5_TX			0x31e
+			IMX95_PAD_DAP_TDI__LPUART5_RX				0x31e
+			IMX95_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B			0x31e
+			IMX95_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B			0x31e
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			IMX95_PAD_SD1_CLK__USDHC1_CLK				0x158e
+			IMX95_PAD_SD1_CMD__USDHC1_CMD				0x138e
+			IMX95_PAD_SD1_DATA0__USDHC1_DATA0			0x138e
+			IMX95_PAD_SD1_DATA1__USDHC1_DATA1			0x138e
+			IMX95_PAD_SD1_DATA2__USDHC1_DATA2			0x138e
+			IMX95_PAD_SD1_DATA3__USDHC1_DATA3			0x138e
+			IMX95_PAD_SD1_DATA4__USDHC1_DATA4			0x138e
+			IMX95_PAD_SD1_DATA5__USDHC1_DATA5			0x138e
+			IMX95_PAD_SD1_DATA6__USDHC1_DATA6			0x138e
+			IMX95_PAD_SD1_DATA7__USDHC1_DATA7			0x138e
+			IMX95_PAD_SD1_STROBE__USDHC1_STROBE			0x158e
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			IMX95_PAD_SD1_CLK__USDHC1_CLK				0x158e
+			IMX95_PAD_SD1_CMD__USDHC1_CMD				0x138e
+			IMX95_PAD_SD1_DATA0__USDHC1_DATA0			0x138e
+			IMX95_PAD_SD1_DATA1__USDHC1_DATA1			0x138e
+			IMX95_PAD_SD1_DATA2__USDHC1_DATA2			0x138e
+			IMX95_PAD_SD1_DATA3__USDHC1_DATA3			0x138e
+			IMX95_PAD_SD1_DATA4__USDHC1_DATA4			0x138e
+			IMX95_PAD_SD1_DATA5__USDHC1_DATA5			0x138e
+			IMX95_PAD_SD1_DATA6__USDHC1_DATA6			0x138e
+			IMX95_PAD_SD1_DATA7__USDHC1_DATA7			0x138e
+			IMX95_PAD_SD1_STROBE__USDHC1_STROBE			0x158e
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			IMX95_PAD_SD1_CLK__USDHC1_CLK				0x15fe
+			IMX95_PAD_SD1_CMD__USDHC1_CMD				0x13fe
+			IMX95_PAD_SD1_DATA0__USDHC1_DATA0			0x13fe
+			IMX95_PAD_SD1_DATA1__USDHC1_DATA1			0x13fe
+			IMX95_PAD_SD1_DATA2__USDHC1_DATA2			0x13fe
+			IMX95_PAD_SD1_DATA3__USDHC1_DATA3			0x13fe
+			IMX95_PAD_SD1_DATA4__USDHC1_DATA4			0x13fe
+			IMX95_PAD_SD1_DATA5__USDHC1_DATA5			0x13fe
+			IMX95_PAD_SD1_DATA6__USDHC1_DATA6			0x13fe
+			IMX95_PAD_SD1_DATA7__USDHC1_DATA7			0x13fe
+			IMX95_PAD_SD1_STROBE__USDHC1_STROBE			0x15fe
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			IMX95_PAD_SD2_CD_B__GPIO3_IO_BIT0			0x31e
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			IMX95_PAD_SD2_CLK__USDHC2_CLK				0x158e
+			IMX95_PAD_SD2_CMD__USDHC2_CMD				0x138e
+			IMX95_PAD_SD2_DATA0__USDHC2_DATA0			0x138e
+			IMX95_PAD_SD2_DATA1__USDHC2_DATA1			0x138e
+			IMX95_PAD_SD2_DATA2__USDHC2_DATA2			0x138e
+			IMX95_PAD_SD2_DATA3__USDHC2_DATA3			0x138e
+			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT			0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			IMX95_PAD_SD2_CLK__USDHC2_CLK				0x158e
+			IMX95_PAD_SD2_CMD__USDHC2_CMD				0x138e
+			IMX95_PAD_SD2_DATA0__USDHC2_DATA0			0x138e
+			IMX95_PAD_SD2_DATA1__USDHC2_DATA1			0x138e
+			IMX95_PAD_SD2_DATA2__USDHC2_DATA2			0x138e
+			IMX95_PAD_SD2_DATA3__USDHC2_DATA3			0x138e
+			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT			0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			IMX95_PAD_SD2_CLK__USDHC2_CLK				0x15fe
+			IMX95_PAD_SD2_CMD__USDHC2_CMD				0x13fe
+			IMX95_PAD_SD2_DATA0__USDHC2_DATA0			0x13fe
+			IMX95_PAD_SD2_DATA1__USDHC2_DATA1			0x13fe
+			IMX95_PAD_SD2_DATA2__USDHC2_DATA2			0x13fe
+			IMX95_PAD_SD2_DATA3__USDHC2_DATA3			0x13fe
+			IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT			0x51e
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			IMX95_PAD_SD3_CLK__USDHC3_CLK				0x158e
+			IMX95_PAD_SD3_CMD__USDHC3_CMD				0x138e
+			IMX95_PAD_SD3_DATA0__USDHC3_DATA0			0x138e
+			IMX95_PAD_SD3_DATA1__USDHC3_DATA1			0x138e
+			IMX95_PAD_SD3_DATA2__USDHC3_DATA2			0x138e
+			IMX95_PAD_SD3_DATA3__USDHC3_DATA3			0x138e
+		>;
+	};
+
+	pinctrl_usdhc3_pwrseq: usdhc3pwrseqgrp {
+		fsl,pins = <
+			IMX95_PAD_XSPI1_SCLK__GPIO5_IO_BIT9			0x31e
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			IMX95_PAD_SD3_CLK__USDHC3_CLK				0x158e
+			IMX95_PAD_SD3_CMD__USDHC3_CMD				0x138e
+			IMX95_PAD_SD3_DATA0__USDHC3_DATA0			0x138e
+			IMX95_PAD_SD3_DATA1__USDHC3_DATA1			0x138e
+			IMX95_PAD_SD3_DATA2__USDHC3_DATA2			0x138e
+			IMX95_PAD_SD3_DATA3__USDHC3_DATA3			0x138e
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			IMX95_PAD_SD3_CLK__USDHC3_CLK				0x15fe
+			IMX95_PAD_SD3_CMD__USDHC3_CMD				0x13fe
+			IMX95_PAD_SD3_DATA0__USDHC3_DATA0			0x13fe
+			IMX95_PAD_SD3_DATA1__USDHC3_DATA1			0x13fe
+			IMX95_PAD_SD3_DATA2__USDHC3_DATA2			0x13fe
+			IMX95_PAD_SD3_DATA3__USDHC3_DATA3			0x13fe
+		>;
+	};
+};
+
+&scmi_misc {
+	nxp,ctrl-ids = <BRD_SM_CTRL_SD3_WAKE		1>,
+		       <BRD_SM_CTRL_PCIE1_WAKE		1>,
+		       <BRD_SM_CTRL_BT_WAKE		1>,
+		       <BRD_SM_CTRL_PCIE2_WAKE		1>,
+		       <BRD_SM_CTRL_BUTTON		1>;
+};
+
+&thermal_zones {
+	a55-thermal {
+		cooling-maps {
+			map1 {
+				cooling-device = <&fan0 0 1>;
+				trip = <&atrip2>;
+			};
+
+			map2 {
+				cooling-device = <&fan0 1 2>;
+				trip = <&atrip3>;
+			};
+
+			map3 {
+				cooling-device = <&fan0 2 3>;
+				trip = <&atrip4>;
+			};
+		};
+
+		trips {
+			atrip2: trip2 {
+				hysteresis = <2000>;
+				temperature = <55000>;
+				type = "active";
+			};
+
+			atrip3: trip3 {
+				hysteresis = <2000>;
+				temperature = <65000>;
+				type = "active";
+			};
+
+			atrip4: trip4 {
+				hysteresis = <2000>;
+				temperature = <75000>;
+				type = "active";
+			};
+		};
+	};
+
+	pf09-thermal {
+		polling-delay = <2000>;
+		polling-delay-passive = <250>;
+		thermal-sensors = <&scmi_sensor 2>;
+
+		trips {
+			pf09_alert: trip0 {
+				hysteresis = <2000>;
+				temperature = <140000>;
+				type = "passive";
+			};
+
+			pf09_crit: trip1 {
+				hysteresis = <2000>;
+				temperature = <155000>;
+				type = "critical";
+			};
+		};
+	};
+
+	pf53arm-thermal {
+		polling-delay = <2000>;
+		polling-delay-passive = <250>;
+		thermal-sensors = <&scmi_sensor 4>;
+
+		cooling-maps {
+			map0 {
+				cooling-device = <&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						 <&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						 <&A55_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						 <&A55_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						 <&A55_4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						 <&A55_5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				trip = <&pf5301_alert>;
+			};
+		};
+
+		trips {
+			pf5301_alert: trip0 {
+				hysteresis = <2000>;
+				temperature = <140000>;
+				type = "passive";
+			};
+
+			pf5301_crit: trip1 {
+				hysteresis = <2000>;
+				temperature = <155000>;
+				type = "critical";
+			};
+		};
+	};
+
+	pf53soc-thermal {
+		polling-delay = <2000>;
+		polling-delay-passive = <250>;
+		thermal-sensors = <&scmi_sensor 3>;
+
+		trips {
+			pf5302_alert: trip0 {
+				hysteresis = <2000>;
+				temperature = <140000>;
+				type = "passive";
+			};
+
+			pf5302_crit: trip1 {
+				hysteresis = <2000>;
+				temperature = <155000>;
+				type = "critical";
+			};
+		};
+	};
+};
+
+&tpm3 {
+	pinctrl-0 = <&pinctrl_tpm3>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&tpm6 {
+	pinctrl-0 = <&pinctrl_tpm6>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&usb3 {
+	status = "okay";
+};
+
+&usb3_dwc3 {
+	adp-disable;
+	dr_mode = "otg";
+	hnp-disable;
+	role-switch-default-mode = "peripheral";
+	srp-disable;
+	usb-role-switch;
+	snps,dis-u1-entry-quirk;
+	snps,dis-u2-entry-quirk;
+	status = "okay";
+
+	port {
+		usb3_data_hs: endpoint {
+			remote-endpoint = <&typec_con_hs>;
+		};
+	};
+};
+
+&usb3_phy {
+	orientation-switch;
+	fsl,phy-tx-preemp-amp-tune-microamp = <600>;
+	status = "okay";
+
+	port {
+		usb3_data_ss: endpoint {
+			remote-endpoint = <&typec_con_ss>;
+		};
+	};
+};
+
+&usdhc1 {
+	bus-width = <8>;
+	non-removable;
+	no-sd;
+	no-sdio;
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	pinctrl-3 = <&pinctrl_usdhc1>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	fsl,tuning-step = <1>;
+	status = "okay";
+};
+
+&usdhc2 {
+	bus-width = <4>;
+	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-3 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	fsl,tuning-step = <1>;
+	status = "okay";
+};
+
+&usdhc3 {
+	bus-width = <4>;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&usdhc3_pwrseq>;
+	non-removable;
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	pinctrl-3 = <&pinctrl_usdhc3>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	vmmc-supply = <&reg_usdhc3_vmmc>;
+	wakeup-source;
+	status = "okay";
+};
+
+&wdog3 {
+	status = "okay";
+};
+
+&xcvr {
+	clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>,
+		 <&scmi_clk IMX95_CLK_SPDIF>,
+		 <&dummy>,
+		 <&scmi_clk IMX95_CLK_AUDIOXCVR>,
+		 <&scmi_clk IMX95_CLK_AUDIOPLL1>,
+		 <&scmi_clk IMX95_CLK_AUDIOPLL2>;
+	clock-names = "ipg", "phy", "spba", "pll_ipg", "pll8k", "pll11k";
+	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
+			  <&scmi_clk IMX95_CLK_SPDIF>,
+			  <&scmi_clk IMX95_CLK_AUDIOXCVR>;
+	assigned-clock-parents = <0>, <0>, <0>, <0>,
+				 <&scmi_clk IMX95_CLK_AUDIOPLL1>,
+				 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+	assigned-clock-rates = <3932160000>, <3612672000>,
+			       <393216000>, <361267200>,
+			       <12288000>, <0>;
+	#sound-dai-cells = <0>;
+	pinctrl-0 = <&pinctrl_spdif>;
+	pinctrl-names = "default";
+	status = "okay";
+};

-- 
2.34.1


