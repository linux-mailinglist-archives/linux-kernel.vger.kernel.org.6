Return-Path: <linux-kernel+bounces-274956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3832C947EB3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C44BB24A5E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B962D15FA75;
	Mon,  5 Aug 2024 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NxLRAnX0"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CEA15EFAA;
	Mon,  5 Aug 2024 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873039; cv=fail; b=qX2Or3la67UcEf44ug4PR1acBdgl5P5h3NFF+/nOsm+8q5nENjYNteoAtYU7Ld12JFsjEXc0DrXoHRdU3MYFRZvj6ljR56H+qYoX37Mf4R8Bvsw/8ucqs2HOSJI1bGcS0fG5J86mMmb2Z/5R6o2HHmf2QnG4HkKM9u4L61tumJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873039; c=relaxed/simple;
	bh=Xg2YLv7VFQUr2f3oqZv/KBZFLd1HlWkFefLmo+WSV20=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=W0xZ0AHLWsOU5R9focQMvvRfC5qsOUno5AH51bOfPYfRI0mtmc6ZU0PeNhvPJer4OVjmi+AooWGlIub2Qi38yVHu9z6A9dQvUVElLTH5OPFSBGuTblV1LjETnTf3owHoQo0/Nq+/QIEbTFEBDYuVVh/53mNOZYkWJXjVUIgoX3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NxLRAnX0; arc=fail smtp.client-ip=40.107.21.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhvfZfiwly4nuUFkR7g9q4GWEGssI57a09TllKWlBpSV7Rocn381QxtqATned1WohTir1QKJ/tn3BkAjwpMyXbAqT2ed5545HwVtWcK0X7jZTYEOSYb/YeD1xV7rcgEEFntA0tfYIHmIHee4VWeXiSNj4s8m/fLsuNL7oIbGu+oyMgtt+q0cD2CjEJwsuIbwSMTkKVvAYrm802svSmnaJZY0FL/Q5zEIZPZrLpAofrh/S2kMRVyo1jHh4GEakvQZ8r5ZaFei+7FRnv/ZEIFSWi2MeCPV8kGQ6CHn9Az/S7XJCT7OVERCxPb94PgBla8wMWoDHG3W/Qht89l6hp1kTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7Txbjxx6VqQs8zaQdZsvI2udhEQjNFsir4pASrVDSo=;
 b=FiUcwICA8lF8327zG5dqv7DdzaYfe6HhJmu3QekEadIWc5Fn37elOuEQkZP/5XbhKwT1rMpLEYxAOCFkRSgnJ7nXPqG15d1NZTtc/BIrQ7/jcsOXadlGErpY69l4IqBjY8uURhHQMOEsS9N+oDwETwa2Bp/gTiSJvFWbW4kSLBGzRRMfOMxN35xvwH+gOEykedebX3QPGD6mhlATaxd1+7fbjAUxhoOqX/njIkqtTJGGqdIJyl0eUJSO8Veo+Cp4jGY3NPBt/513/uAozzatrBkLIk8u7snp79z/Rm8QwTh63kSxhawbMhsW8O5jxhMp1CWzSjq8D27HDQlo6Ne7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7Txbjxx6VqQs8zaQdZsvI2udhEQjNFsir4pASrVDSo=;
 b=NxLRAnX0txG2/zlHAsDitiENAsH0mVU2d1F4h+orR6/MLahPXC/sssHx/FWLwmeL6ZNGV855uJ/U5IpU6RBaTIMfwgiREDX43yTTDwy7JSIumoR1xP9fbdhoOazI34H0VqZyWJFA48lklxQ9tnOnJBybDN4oEHnqivqcTlSYPA/9myUJvs3fCWYolLmhKYl388xd0Cw16uPyRgGNrdV8yJB6/UTbapTqQetjJ00lkUqkPVY2RTz5MIQfvoe4/qwyMuc119+fnoCQew5YJfdfi6oUr7cnammUiGnZJBu2QW/s2mrTjQpNTrrSRE8UMyuB9zP2XBMK8PDzbYfWbQmb1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10464.eurprd04.prod.outlook.com (2603:10a6:800:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 15:50:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 15:50:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 05 Aug 2024 11:49:50 -0400
Subject: [PATCH 8/9] arm64: dts: imx8mm: Add fallback compatible string
 fsl,imx8mm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-fsl_dts_warning-v1-8-055653dd5c96@nxp.com>
References: <20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com>
In-Reply-To: <20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722873011; l=2189;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Xg2YLv7VFQUr2f3oqZv/KBZFLd1HlWkFefLmo+WSV20=;
 b=RrMz4aoV97gT1DZWYAM4HNLDr51coHvHXXgvtBKRwxOAj1ttAcBjQRIQgcuoEkqRdT7l1Pk11
 hiMyLuOL6mFBxDoQhaK+zppH5BKsUabRgdqb4YTnAcP3Wr63nXWfSJy
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:806:27::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10464:EE_
X-MS-Office365-Filtering-Correlation-Id: 540145e1-818b-45d3-26e7-08dcb566559c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czZmcFcxY2VZa2NHSmd1OXIwM1hwYlo5bXFUanpmSXl6dVN3a1pRYkpvMVBk?=
 =?utf-8?B?U1FKRWVsL1c3NFQwVWlNeUswaFQ4aCsrYjN4eU9yNzNTMEVvUEx6S2wvSlBU?=
 =?utf-8?B?clFLSWNQNFMwZElXdkJ2YStHdkFYNm53elU4L0pmZ3ZWc2R1SzQ0TUQvNHNv?=
 =?utf-8?B?ODkwSWRweUxqbnM1NFNPaHpIN1B5andFSDlwc1RqZGFZNkIweUk5SHVrbTlP?=
 =?utf-8?B?blVBeGhxY0NaZEVPTnBzdXUvNmxlTUFneWVMdGh3eERYaThINlVGWTJuZkhQ?=
 =?utf-8?B?N0cycjJjcEwyMWlMT1YyUld1WUI3Ykd5N2ZmamdTeGYzM2FKVURpYkp5cFJO?=
 =?utf-8?B?WDdid3hRMlVxNFYrY1VZZXJBUmt4bFp6YUxMcGpoT1FKUTh1YS9VeU13cUxE?=
 =?utf-8?B?bEwrenB1VGJvY09TdnRycG1aNlZNb3VuTEdkSHg4bFFCNElNSENLdHcySGtC?=
 =?utf-8?B?cFZObVlueUVWdDlodDkvSit0SEhRMXJ0ZDNycDNiQVlLNjdKT2FqZ1NnTk54?=
 =?utf-8?B?SkpIMkdaTlk4ck5RK05xL0tSK1h3bFJKQjhCemswUmpqcC85eXZ5b0NDaGll?=
 =?utf-8?B?cVA1YURRZExEREhFeHBicWtJSVNHZlVBS0pabFY4MHRCVUY5QmIxdXhMczR4?=
 =?utf-8?B?TUJvQUNtWG81UXloRzVpcE92djdPS2hMTUQ0M2xoc3RBQmhiNWh1aUZRVVZY?=
 =?utf-8?B?S2h3K0wxdjJEemlwc1NudGdQVmxQTWpHelJNWm9WcG1KYUpXcFphUlhXdEhl?=
 =?utf-8?B?OUJSVUw5WS9ucDhhQXZCNlRSQUl0djFlQ0F4aUY0bURhWXBBR3FsQWtJRFNT?=
 =?utf-8?B?RDAvNlNFcGVlTnhaMzg2VTdZOUU5SWNkTDQ5WDZINjc5cnRkOXVKc1hmZ1hL?=
 =?utf-8?B?VFJDcHZzSkw2REsxUUZWUzNoRHROYTJEV1pRTzRXQ0VHSUlVOE80R3ZtYXQx?=
 =?utf-8?B?dkoxKzQrdy9oNmpGdWQwWmNUZ0hETnV1dGRGWFBHZnhsNFkwRFkrYmdGVjdL?=
 =?utf-8?B?MWh0MjhFSWpSZDhGeExyekxrc3Ftcnh1Y2ducGpEdEpubGJETVNBSXZMVWI1?=
 =?utf-8?B?Z1hsalBsQ1FzMFFINzR2SUtIbG1qUTVXWGlxYURzMWFteldLUWJCLzkyb2Uy?=
 =?utf-8?B?cmpQVkpjQTdlRHMrWnVndm1hdXFUUXU1VytCRmtseVd4NXAxRVgxRDdSMGVv?=
 =?utf-8?B?ZStoWjdQS0VFOGlxNS9WSGxZU0RaODlwZmxVTTVsSVI1b3Nmekp3dVFTOW1T?=
 =?utf-8?B?ZkMvT2ZtRW4wOEVpWWVUNU9hV2hqQ0RNa0thYng0ejcxYmkvbmIza0diSXZo?=
 =?utf-8?B?eUlsK0dpaUY4UlZ6eGJlc2pHMm5GcGN5ZGMxK21mcGhDZmRRSHhLQzJCT0xB?=
 =?utf-8?B?N3hVa0N5aEN6cnY1YWNZM3h5Z3FUb2I1aElsQys4UGVqZmlmMmlQRitiVDUv?=
 =?utf-8?B?R0VNT3Z4TUFmdkN6NnN1YjVKMmk5aGNxTmJKbGU2SDdjV0xnZUZ1Y3kwdUxK?=
 =?utf-8?B?REwzUGNJNFlCRk5xTHQ5K1duTlBiRVBFMlNPMWxmUG9mVzlSRnVpc0ltN1BM?=
 =?utf-8?B?dHBhbEkwaksrV3dFREJNcTNMd3FjVWNneXQ2dG1uaTZSU3ZBMndqVk5IMjNU?=
 =?utf-8?B?ZnJQTHVIYWNLUEZGdzAzNTQrcTNFK0E4T01FcURZS0VRM2IxVzlvaDN1anJQ?=
 =?utf-8?B?ZllCVUhqUU4zcWhoSlE0ZXcvQkY3TUtSWFVXY21VQ3NsOHZCeXNoRkxNUFBB?=
 =?utf-8?B?T0NMbmNZR2Z0MWxncGFwUHpZTVplWEU1bmpMdXVvWDVIK0U0bjNjSmxyN0JO?=
 =?utf-8?B?UjMxN1FjWWVQMUJmV1VFRDQxTTR2RENaZHJmMlRnK2V4RVBaWTFoYTh3SU1D?=
 =?utf-8?B?T1lOWHZRN0E4bGZQbjZwa0lESGtxOTBsa0YyQjVBMVBOaEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1pyTDQ3Wm04THNLb0FURDdUS3BRN2pYK0lXbk5MM1IvWEk4NkpFS3pvbnAw?=
 =?utf-8?B?Y2Q1Y0UvYlM3a0p2c0M3bUxsK3d1VjFBN2k5SVNkMThlWXNTQkppRlVSOEtm?=
 =?utf-8?B?a0R3QUJMZ3MyS0srdmhUdjdNZWZKWlh1K1E1OVhUbVlBdEJUMElHNFVmdlFV?=
 =?utf-8?B?TXQyRXczZTJlSVlJaEp0MmlraE95M3JPaVZ5ZUtOZDBNVHN2QU1maGJFRkl1?=
 =?utf-8?B?N1NRTzB5ZlFjdGRsdFZaNVFGa0NTblVQNUZaUnBjOE1sSjU4Q0ZDQk5zalBO?=
 =?utf-8?B?VG1Mdkg4SFFEVFMzRlJSTzFMcTJ3V2F4b3ZqZDhnRTlSUW9tV1ZBYVVvTTRi?=
 =?utf-8?B?Q2lrTW96RkRGMUp4REFZZ0RIM25nK2swdTZiZTBneldCQkk2QW1VMk5UUm5q?=
 =?utf-8?B?NVdpTjVLOUcrTzk5K2U2d1JkeVgvb2YyalFCSk96SUplWFBhNnIxVXdnSFdT?=
 =?utf-8?B?c3YzNThYUFB2TjN6d3orWWNzTVhmYkRHRENhMldQSTUzRkUwYjJCU29iaktj?=
 =?utf-8?B?NFZ3bFBMdVpzbmZ4YWtYa05SWmUrNUpsS3pLZFcySi9WTThJdW9jbSttakdu?=
 =?utf-8?B?OUlmK2JuTTNXY2pSS3orT01Yb3BJeWVXUEZxOG1aQ256UEhOTFlNMWwvMERq?=
 =?utf-8?B?MG5Ddkdxeis1TEZ6L2srQUR3WUJwcDFsb0poZGJ5THNzSVEwbVJsZFNRSTJL?=
 =?utf-8?B?TXBjMUxOaGpUdU15RzNNZHB2SlpLbGRpdWZGVjlqY1J2VWs5Y2NpdWR0eFph?=
 =?utf-8?B?RklESExPTGRocGVrbGlYWngvR2s3dEQvZmN0TnVFWFZZYkE2MWRKeFV2TTJ6?=
 =?utf-8?B?eFN3NTZOV2IyYlBvQzNoTWN4L0VEZm1Td0xJVWFOdmhpVXhCajFOSHVHZUJE?=
 =?utf-8?B?bkZ4SStRMGFKYURIa0RYRU9FMzNsUXcyejhuUUxtd1R6dmt1OXl0WTFmQ0Zr?=
 =?utf-8?B?SzZqWGJKMjlZSU5ja2R3Vmk4M3JwSjA3QytmM1VPc3laaW1ENWhkcE51MmVs?=
 =?utf-8?B?K01FQjNCTlNoemlIaTVZekxaVDdiOWY1ek9GUEtEaHlMaGlFbWFkczlDbjM2?=
 =?utf-8?B?U3BjTzEyeGtBbEVhdVEyekkvd2Q3R25XRFZqR0srNU1zN0FXS2VJZnNEWmEy?=
 =?utf-8?B?VGpRY2J0cW5rcHozWUtLTG00NzBrUEFxVDZDU0tiZUMyRnBLOHNNS3ZZblYv?=
 =?utf-8?B?d1BvMCsvaWhRNzdYN0ZxWDdJMC9OK2Q2Y21tOXhZQmxLdU5tN1FGTk1SY1Z4?=
 =?utf-8?B?SEp4S1pPSk55RG5JaVFzTFhWSkpxVW1wQ1Bvb3BEK2hUQUFZd2FmcDRyWDFB?=
 =?utf-8?B?OFlFVlZOOE5PY3dQeFgxVFQxTW84WW96blFPVHFNbzZCdlZ1L3NGS3IvcFpn?=
 =?utf-8?B?UGg5Q1lRVDRqS1ZLaFRuMmNWYW1GeUdHUVA4amNHNG82Q2tZQThMcGlxMHl4?=
 =?utf-8?B?WVVYelhHcXJqMit0TGZ6YlR1ZmZSdVJRS2VMdEprczNsOTFiT0l0UlR3SjVQ?=
 =?utf-8?B?emxkZ080MitKSlBDOGsyZlM5RWJOeENJTkdLOGNSV1lWTzVyeFNoUEZsMnpV?=
 =?utf-8?B?ZWlBN3IvMlRvcjU1UkhOSjBNWTdwQm1YK1djZFNMbmNRRDdWcXV4dGR0c3dZ?=
 =?utf-8?B?REhJVzNPemVacmp0N1dPaVl4T21IWm54VE1iVXRpbEg0ODlMM1lDOFFUU0lT?=
 =?utf-8?B?MXRYcG1XalNrc212ajZFOE1BVmF6V0ZSam9ucStOQjZ6THFaS1U2a1hKeUJV?=
 =?utf-8?B?TlMzSkhBWk1QNGVOQUhsVWxIRXZFWlRvTnRCRnprTTcvcmZsT3BTT3EwYWha?=
 =?utf-8?B?aGdXVnd5NC9Ndko0SUZaNldoRXJob2xUdUxBYnU0cWJpcmM5aEVtNlk5UzdZ?=
 =?utf-8?B?Y3dtRTluUExtVVFxZmdyaDZxY25NVGJCc2NnMHFBcERnRGFlcEU4MVhWYnpa?=
 =?utf-8?B?Z1l6SCtSV3VDdzFQOHdFcURrOHRsdGNxWnRvbG5iZDZkdHErZkxyOXdxM1Ft?=
 =?utf-8?B?SjdqaXVBTzlrQlkzRTZoSGpJcDNmOStWSndqc2piMHAvSTdhY2V1QXlUMG9G?=
 =?utf-8?B?cUlmVjYrUnJFdk4yNmQvNUpoNk9UeXlqOGJnMXVvUFFId0RYS2NNaGZvYndz?=
 =?utf-8?Q?UNJyHU9xKNEzfo2dPzkaM7FtF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540145e1-818b-45d3-26e7-08dcb566559c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:50:30.8134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s111gZVyk1Zz+gbW7sktFnvBxfbPwG2VJRsL1IO65ZTfYe5bP0r57AzykNeUXQi7NDO8YR3vjfs51pdSuBROMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10464

Add fallback compatible string imx8mm-phygate to fix below warning:
'phytec,imx8mm-phygate-tauri-l' is not one of ['armadeus,imx1-apf9328', 'fsl,imx1ads']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso  | 3 ++-
 arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso  | 3 ++-
 .../arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rts-cts.dtso | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso
index bf3e04651ba00..f246b0ba6af29 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso
@@ -15,7 +15,8 @@
 /plugin/;
 
 &{/} {
-	compatible = "phytec,imx8mm-phygate-tauri-l";
+	compatible = "phytec,imx8mm-phygate-tauri-l",
+		     "phytec,imx8mm-phycore-som", "fsl,imx8mm";
 
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso
index f4448cde0407c..67508ca14276f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso
@@ -16,7 +16,8 @@
 /plugin/;
 
 &{/} {
-	compatible = "phytec,imx8mm-phygate-tauri-l";
+	compatible = "phytec,imx8mm-phygate-tauri-l",
+		     "phytec,imx8mm-phycore-som", "fsl,imx8mm";
 
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rts-cts.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rts-cts.dtso
index 107f743fbb1c3..714e22ccb9c64 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rts-cts.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rts-cts.dtso
@@ -16,7 +16,8 @@
 
 
 &{/} {
-	compatible = "phytec,imx8mm-phygate-tauri-l";
+	compatible = "phytec,imx8mm-phygate-tauri-l",
+		     "phytec,imx8mm-phycore-som", "fsl,imx8mm";
 
 };
 

-- 
2.34.1


