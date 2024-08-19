Return-Path: <linux-kernel+bounces-292582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31DB957175
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671431F220DA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5177917BEA2;
	Mon, 19 Aug 2024 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HWLzaxj+"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E0B189517;
	Mon, 19 Aug 2024 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087014; cv=fail; b=oqCEkz+srT3r1NFtlYvdN7haGy9OCh2AK7vEq7PjcyA5TIhin0TBF4FujDUwC2JxerMsONTsblTLupTFHzFVwnC8UIScnAfpMBa3bvajdKLJ+FHGmkqsvajOgYzPngbwhbvlIjYn+LbbuwnaxsohxO5XIZnRTs85pZSnK2Xdd+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087014; c=relaxed/simple;
	bh=kclyjxQw4lOyqZNnPuFTpYDPOubLym7HM2leNTo8O6E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cd9WMKRJBTJISR/18KQ7SJv3jSLofAwO1vCy4TrCF2Hslpt0ciGahWyp1+C+3iJTXCEv41T2Xgza5FVbyp5JBNL2wI9JGBN+qREsOrBZBbZBX+L+qg6WkHjBxgSg2xXgO/Kysf6ysClnXA7KWDpTjbfm2uLpYzxDRlMPwepUctc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HWLzaxj+; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFdwMSQWAX2pAl19HMz7EigBOiUuGMn7Cf1zvFFHpLU3BPoHjwgQNfaf1GHKgBBnlf5pPB1IhdyWuDYtv8t7GCsYbOcHlkRyXwjT1E1kdZQzBje0YWy2DZyuY7SwjCXco+PGm2SX0+daiCrEprSGvQG0ax3MVVy132TrN95iN8alH9QDrS4049jyrZTM17ZkaGQhiyi9qs2JCwoOHkj5Fv5lBF+4zwuMzuRaQhfNMHwwnHn7CyVZ2BkYIz9jUcJHoJNGcinSLWjw/p5hE+EIdeU3cbEmd/KQqerPiuxCY32mlhFuwZUVH6SHQv1SAzFrYYYE2TKCezUm7HyTcRe4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRmVkQSu4oBQXXYgcwN3vzY749nustUShudhz4ZofVU=;
 b=GIxgf61Z6j3okfB85u8kljvDPvu708xwu7nP6cj0cSZ3Sc8/WNbh6IEf8NRkHHuIfWuVHvDzVw7Y8bfYrm43iPKKD2ZAH4NV0JHKNTta5jRrccYndMP6zaqnMQZvPQRuMVy4mq8KQPuEze9WQEzqWFtaFS/NEwjKIVmQwVIMiq7PpgRXLREyFFt+i5e/aFWVFIKBvFMiaV7pg05jwRHHKVnXULUED2JJd6bLJMV9YwZ1/TU0yqalyN2LYgkLnK6HfvzmmpV/jECIACz6S7S0YsfgMljxbd14we9hvIZFoglyaJiTKirEg8XP3H7OOC0D8/85bFemrFTuSoEXyUWtEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRmVkQSu4oBQXXYgcwN3vzY749nustUShudhz4ZofVU=;
 b=HWLzaxj+FuFmGPN8PYhgXLkSpDxZskJf/VGt0k7CKgiuInnuusr0u8YHspndbihI1unFElbsBpcc+qi8KAR6mjX46DXt2tKIJ1WJJ7FOclP7uzZ8HT1olbCeI4a2trOts9ZSGT5FNhcSwKCPgyi/VcTAvTBmuBG6qLV2SktWm6KFEXLqOTyzk0pFaBXr5med6+GvUQXAUXTFd6Iz61A18ZjQycQ8UwTVGm7xH7fFxaG8qVEcQDec15wHRWEuGVkcfK4gJkxXscbpquuXWlEAqLxuMaQkk3Z6njA5P3p6FxwfNXsVFwdiEg9GLl4UuJO6BC4i8Xpvw2XQQ1QAYM86wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8761.eurprd04.prod.outlook.com (2603:10a6:20b:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 17:03:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 17:03:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 19 Aug 2024 13:01:15 -0400
Subject: [PATCH v2 06/12] arm64: dts: fsl-ls1028: add missed supply for
 wm8904
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-imx_warning-v2-6-4c428bd11160@nxp.com>
References: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com>
In-Reply-To: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724086982; l=1365;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=kclyjxQw4lOyqZNnPuFTpYDPOubLym7HM2leNTo8O6E=;
 b=1SoH6j96TY7kJnrULgtKTerDaxyKwCjt2S570bP4/IaDgB00b4D+pjTAxf5ARzNLAfqilATdJ
 FJQ/UtH7difAJ55c9L6HNxO55ByrQJZkmp76Bfib5Ak9IM24cxwM7pV
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: 871b74d2-41db-4cd7-1781-08dcc070d8be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZU80eDB2NkpINjdnalFGcmVwZXNORzkzbWxCNW5ESU9ld0xsQWhIM0k4WVFr?=
 =?utf-8?B?OG9RRzRYa1kycXI0eXptM0tHRXVDYkZ1dTV0N25Fd2dFSnZqL3ZJYTRJcy9I?=
 =?utf-8?B?dEplNy9DTzNpdVFacGVDbVNBeEJVczIyR1VsNTBQeTg4am92Zm9BMWMydDZq?=
 =?utf-8?B?dEN1VXBKenFEZUtjTzlzdGtzcDN1Wkp3WnBURThvUTc3clo4YUF2TVhUMzc5?=
 =?utf-8?B?aW1aOE9jTmVrMEU4bDZ0RzFnc0tHaXFtSTBud2tVbVJIWHhJSndPWlZzVnNu?=
 =?utf-8?B?ZmU0K0JEL0YwbEoyVTlTaVZ4Z1NoZUNzUU5kZjlWN1dyMGhrTFhoMU5ySjUx?=
 =?utf-8?B?OEtFNGlYSjR0RTJERm1Pc2RwQ2lIZXpLOVBlOWZtSndYcy9nRnc2QlBBdkpP?=
 =?utf-8?B?aW9JUUdNZWNNYzRGMDgwNm1IUjdsbHZvUDdXVmxiQzY0SWxCUTVSVnBPM3k5?=
 =?utf-8?B?bzlidVdSN2xUWWxCeEFDVExDd3BQaWpYNjlYeDdLd3lDM0YvaCsxUGYwVXAy?=
 =?utf-8?B?MlJBWXhPN0QyVFIyUkVnZGFWV2tZY1ZzOTFpcitxSXRFYU1zRlVmQklCV3B6?=
 =?utf-8?B?UGt1TjJzTnVNQjN4ODducUh1ajBzU3g1a2R2THhPTUU5RVE5Lzl4TGttdHR3?=
 =?utf-8?B?allZZ0pvT0hrU0l6bXV6SGhTenh0MDlzVTJzTlllVUFhUlplUjNML1ZwL1FZ?=
 =?utf-8?B?WEMyMjAzSEpCbG14K1JadTNubFVWWlRDQ0JSUmQyOWlzdHRNYnhrT0dzS0tE?=
 =?utf-8?B?aWIvUVcxdlVDRi9HTEVJV1EwSDMrQVhVSzcrd0NYeWlHcXB2SnAySmFhSnJj?=
 =?utf-8?B?NFFmaVBQTGlsLzFKYlFTazk4VHlCaUhDRUR6TWhFM0VQWnRweXFwVVVJYThU?=
 =?utf-8?B?TUlhWFV0eXFyZVN5ZzQrUTFGQmtqaE1vTE9qeGw3WnJhUGhUc0IzY3ZhT1RO?=
 =?utf-8?B?QU54dTQreTdlQ25VMitSSVdEaGJWOFNaSGc0ZDhqN2xpZWxabkNZdmVUR1Uz?=
 =?utf-8?B?cDdzT3FmZGNMYUtNK2F6RUdqRjN5YlN1eVlQT1hsTDE3djJGdFdJOVB3OUtY?=
 =?utf-8?B?Q0sySEV1R2QxV1ZER0FXdXdscURzK0RObmtKbjFxU0pob3IzYVNIdlBtSG1F?=
 =?utf-8?B?bGpESUNMZkF6NjdyV2dmUjZnZTlJeXRMcU1CTVlqWndqSjdhVkNPSzVWaG41?=
 =?utf-8?B?VFFLdVhoaFlWNVFNN1l1SmFJL3RtcWhva0hzcG1kUFNvMmxwOEo0eWQ1UmFi?=
 =?utf-8?B?T2RlUFAzNEJTdGpXcWNCKzRoSXVxOW5lOGEvdDhQaXdML2JXdEFSZ05oR1JS?=
 =?utf-8?B?K1F4N1VLM1pQR2l4aWpDb3VMdTlKN0tCTEUxVEtpT0JPNzRZczVDdkV3T0pK?=
 =?utf-8?B?YU8zRldPdC82TVBFeElEQzdxZWFPUEgrTFMwS3pyTThjRldHTVBCUGo2cXhV?=
 =?utf-8?B?c1pwRmtSRzJDcU1ZL0dkSTd6V21GWE9rL2pUM3RXdEc4WXVta0xrUFNBMVVa?=
 =?utf-8?B?OVFDMlNFd0RMcFk0VFkzdUV5WUx2MDdXcVFERnRnM0xzL01XaWF0SnFpaFVI?=
 =?utf-8?B?VSszaFFBRnRtWGhZQzVPYjNEWThsa3AwTkplSkZ1ZEhkNXhXekYxNzYzN2w1?=
 =?utf-8?B?Tlc5VldtUVNmR2h1ZGhBeitKcEFVWTJWNnZIQ1ZvMklCMDZsS05ONkhrNmpW?=
 =?utf-8?B?UkFrbVpab0ppRW1nMThUcGpnVjB6R09RR0tXa2NncG94T2JRZUtJc2h0NE15?=
 =?utf-8?B?cS9QSWhSYTMvYS9UWTZFcjVqYnNTMHU3MUlMOXdWRnM5Vjc0Rlh2T0pxK1Zl?=
 =?utf-8?B?NWc5d0hlaEtpSGZCZFdTSjRVQk1VbDNYNTFvS0pPSERCZkNkQ1RtS2Z6M08y?=
 =?utf-8?B?ekFTdDVFK3pYL1ZxSzV0dC9rd29GYzZrdlFoUFNVckpLbUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z05ZTk1MRDhWN2pneXE4Lyt5UnRQOW1HYlFWa3JNb0p0KzlFWU5XbjBCM3hK?=
 =?utf-8?B?ZmZmdUljS2RlSUpYanMxSmUxMUtqN0E3RWxuZHJuUzUrT1RIVnlhM1ZKeHFz?=
 =?utf-8?B?cmpjdWkveE5wVUZQTUlHTkhETkl3LzJjaEdhZHlGZVJzRmRMRkZ4eFZmaTJW?=
 =?utf-8?B?b2xGaW5LRHdLOTMySVA5dWFsM2orWG9adzRxdFRPQTlUSTNTbjVhZGJCTjVj?=
 =?utf-8?B?bExUK3FTdWI3TW91YnlBS3hCQUFOQVhFQmcvQUVsVGdwc1QzWVhWUEloeDlu?=
 =?utf-8?B?MnU0Ri9sU3Zrd3Q4Ym5TUnRoaWsraVlGZFdxZFVlSHBKUnJXNUJacmwrVHJZ?=
 =?utf-8?B?MXdoOTFPT0V1cTBJajdpUXJ3ZXdZL3VWdkJtOS9DWVRoS013MWJzSzFFL0tS?=
 =?utf-8?B?blRIN3k3dGZ3VnZvVnovVE5HS1gxdTE5ME5EUW9DbGEvdzlqL3hFZGU1Rnh6?=
 =?utf-8?B?enZ3S1F6WGYyUUVrQ3RNU3hhY3JSODBnOHAxUFhXSWFWMk9ETm13ejRsZm5K?=
 =?utf-8?B?Q1FVK3NmL2xIQ1Aydm5ZSGxOMHpBYUU1RzBZdDE5VFBzeU5oUkkvWUFJSE9W?=
 =?utf-8?B?ekJFL1UvR0g2a2hOZXY1ZlBUZjhrMGl0QlUyaGZic3p2UDRCeGF0cUt2bjNj?=
 =?utf-8?B?VEhOUHNNNW81NkF3bFRaSEFXWWdkQmRwWitJMkxHT0xrQmh3TTlxWXU2YmFC?=
 =?utf-8?B?SEZhNS91eWJ2WjBrTjUwd2JTbzQxclZmdkhOcXlTQlZMOFRUTGMzRzRSTW1L?=
 =?utf-8?B?YTVSWHY4YnA5VW9WMUtvaDk0TWtoMzdzcnd4aFEwYmlmcVl4OCtRcHNHaEov?=
 =?utf-8?B?UGRzbkpQWm1jMWNSaFdNWi9OcU96L29hZjRSejNxWURaVUY3THo3MUJsMjR1?=
 =?utf-8?B?Q0VnMVd4QnBmUmprTW5pSUl2WThpZ1Z3UEVDdTE5TEFPVVYyOVZSSWlHZngx?=
 =?utf-8?B?N2ZrdnVkdS9pbFdjRHlZRjVEaVFEWDQ5N3hIQjBWdkJIVk9lUmQ1VElMZGMw?=
 =?utf-8?B?aDRDRmpwQUVhbXc2WVJaaDBhWC83bWY2Y3ZNVnMwUlQ4QnAyd3QxUnU3LzBN?=
 =?utf-8?B?dStTeW5OZVNwaVd5OFBXMG1yaWIzWmJodWVYTzRDbFFzRzMvVWwybENmcmNH?=
 =?utf-8?B?Zjl4ZzNldTBSZFNiK1VqYmpFeFEwRWpFUklUVDV1Wm9PNEczOWNEYlQ4eHFQ?=
 =?utf-8?B?UEp3S0thRndMUUVVU0Jhc1JtT3JpSkEyRnB2V1JSYUhGVkExSUNvOTU3KzYy?=
 =?utf-8?B?eXBoT3VYQ083cW12dGIwSld4elh0L09kQWVTMXVWMnNZY1JXMUNjMlc1ZXlL?=
 =?utf-8?B?QllSMGR2dEo1N1dJdWRLVEpMSVpLL2VYMVIyVlJRZStqN3FocnpVL2s3OVlK?=
 =?utf-8?B?Q1Y5UkdNRDhtQ2FWeVMxQmVDNnN6a2hrVVprT0hZaW83U05EYkRHNC9lbDh2?=
 =?utf-8?B?MmNuMzZQNm42dmRkRDBHZDBkb3Z5dlBhU2ZZSTQwMmp3TER2LzJUcHVJcmo0?=
 =?utf-8?B?SWs4TXlHRWYwYjBDaTFRQ0VTM2F5cjJIV01rR2RlTTNmVUVEM2MwdU13bVRz?=
 =?utf-8?B?SkFabm5zRlRVczI5WjNITE51T3FzeTF6VC9oTzdvVkJmeVZwY20vTVgxb1pZ?=
 =?utf-8?B?SzRNdUZpcnBkbWxhMzhFbCtJTkVKc1lsVElyWXNyeUhMSk1rdHphSEhLTkxo?=
 =?utf-8?B?RUJieWxqQW9PMVpIUDE2Q1loblFvZjJMV0VUYWcvRHZ3eU54ODVjL09mUTFT?=
 =?utf-8?B?THNJMjZZb0prL0o0eTJIQXZZT3NMYk83NCs0cytRYTRLV2RSNTg1MytIdzNF?=
 =?utf-8?B?ZUY0bytQY0RTbnoyeXViR2RRL2piaXZiQU5UZ3RFM2JIVE8yZzV1Yzk4Q3o5?=
 =?utf-8?B?VE5FTmRlZ1l5eTZyV2pObHNYQ3pVTjZWMXF3ZDNGenU2dDIzQVd2ZU4yV3lF?=
 =?utf-8?B?MkNUTGZldTd6SkpvQ004TkJ5U25QTXBZY2FTWUNMY1hJNldxTGh1WDEyUHVx?=
 =?utf-8?B?NzMyeWxBSERUMENQTDBRUW9FY25ydDdLTUJVaEVwb25PRkc4M3krQW40b0NP?=
 =?utf-8?B?Wkp6ZityS0RObm05bElrRy9NWjY2NzR2ZEJ5NVo1ZzJQUDdobjdFc1BFUVg4?=
 =?utf-8?Q?EJOc4xLXaWrXAvfQ64TsosQWD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871b74d2-41db-4cd7-1781-08dcc070d8be
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 17:03:28.6266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwg/I5gVeZmBZ3XcNhBrdUiM87rU/D8CZob21hojYtBxkqNAIg7uVvpFiDd1XXLWpngk2yvSAzTVDYdf9Spb4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8761

Add A(CP, DB, DC, MIC)VDD-supply for wm8904 to fix below warning:
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb:
	audio-codec@1a: 'AVDD-supply' is a required property

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
index 195bdbafdf7c9..d9fac647f4327 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
@@ -26,6 +26,13 @@ pwm-fan {
 		cooling-levels = <1 128 192 255>;
 	};
 
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	sound {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -107,6 +114,11 @@ wm8904: audio-codec@1a {
 		clock-names = "mclk";
 		assigned-clocks = <&mclk>;
 		assigned-clock-rates = <1250000>;
+		AVDD-supply = <&reg_3p3v>;
+		CPVDD-supply = <&reg_3p3v>;
+		DBVDD-supply = <&reg_3p3v>;
+		DCVDD-supply = <&reg_3p3v>;
+		MICVDD-supply = <&reg_3p3v>;
 	};
 };
 

-- 
2.34.1


