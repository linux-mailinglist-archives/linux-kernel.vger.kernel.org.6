Return-Path: <linux-kernel+bounces-292576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C887A957166
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E032284D04
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754FA17ADEE;
	Mon, 19 Aug 2024 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TSz+OfgM"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2085.outbound.protection.outlook.com [40.107.249.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A912BD19;
	Mon, 19 Aug 2024 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086991; cv=fail; b=UVG0PpvlLRmh+iv2g1cnYoKGnCmz5tCrkl4fBfuYSHaNImI7KAax6E3upKzQPz2fvvXtXE+F0ND8jw1NHGiBJmVrbHOpcOrXvM+rwo8rmDxTncR6fmIL7qswaeNW3jsBfWaGZmW9GVNzklQU82oMJu6rfja7y7GYwsnTeowbnFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086991; c=relaxed/simple;
	bh=aOS2j6UyXQ0h4/vJ2RKEatenu4Migymun9dwswWBNVk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=vEcfF8cIbC7tMb240grfcvh52atQxKBkr01Aef2jwUi640il34A2cCjHpuqQJq02AWuR1QVboyoaE03YO8dnzd/pSlSc3NiWWxSgpg5vZJ3Do6rnI7mL/ZAWatMPWcqLUtGQBmGoW/YX7RR6ZWlfgl0w/qLh0zxuiWxABoPZOAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TSz+OfgM; arc=fail smtp.client-ip=40.107.249.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCq1CFbgVxTUHSVo1SQvTvRTakNj0BYNy61042J0ZbBNURME89EjN5tjEu1TsjPqEDb4CVhIE3tZfhp01PDGz4Ia2J2QyAuUZUFusgRkKfRjrPSsHIGqJnNwasYgPDhgWl1f7AJsT+nuuwPl/zre0ewu2gPufX14RFdxMDDk0a5BVEImj/l52e9AGi1rh8MkjHJ55RC85zWRpbjOPPWbtkfti9WiXB25t/Ap/L9p3oAdojUqZ55EIbgn81rouhBpcbxk/BI6kyjHOKkOGA1bYGucvhqfU5mYEqO6Gh74Y67OMzs1Znt8HAh1aGCUsw+BBTPlXoCFvEbFg5MjmGDpiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToTq4ibGc36aGT5kMZPOgv1xdbnl/RFsdAegbeapzFQ=;
 b=hRWjtUCKD/QV6MXApwdG9+1bfr5F9ThQfX53Ij7hM+mNet7dVc1xUZPEzynKxe/2og9r3V+5mV/O3gvtcxDCJRhfJLT31IxFuOSG0l29z+RIVSXzjLaL8bxmLhnrZc1mMRz7Vl4E76QDWMWPbeVAyvcGkKCsTjkhyDkDGTpz1dzL1abFJDl1ETa2Pe2ybgSpANMMmbynobbVuYBNVS18t6R2mjnEzqomiXKvhbkJoMpLEhe5E8l/nYuuZpJaItSkNP5zG+OnQ/TFNiKB3+tzaT6o0II7Sgd/XiUU8/Qwu7x/yfAVWVy43GeIRWQSZAMR7/fYBm3ZTs5aac6v8ZNAcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToTq4ibGc36aGT5kMZPOgv1xdbnl/RFsdAegbeapzFQ=;
 b=TSz+OfgMnJzl9aVsNmFvUC/b7N7nOseJBvZGHYqaZLUD6YgBRa7lN+TOgVCkFaVj5ZafDzW+iMOz82Fl7c37Uh03e0rHqbGXzc34mwPwLcBwm/4yajOKv5ZJZ8ZTkjv0qOmal1CJCxu/nNvR3z1aQ+/f7d9zNhyTYXPyjh69Q4g46ejI18JTwm7Z4sUe+9aWsXMTIbRp7rdXAPnMfuc1AAkEaVmo7JnQaBUHE6LqZDgrgQg/fIt2g8C1GSFWHeefIuOxG11/hu8RWQEiVFy9apq8FUfPNthiQTfCs4ygmVT6klCeOumlwiQOIRiePYAFyLfOL5Hhhj2z4ExRMVXicg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10857.eurprd04.prod.outlook.com (2603:10a6:800:271::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 17:03:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 17:03:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 00/12] arm64: dts: imx: 3rd dtb warning clearn up
Date: Mon, 19 Aug 2024 13:01:09 -0400
Message-Id: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFV6w2YC/1XMQQ7CIBCF4as0sxYDA1HqqvcwjcEW21kUGjCIa
 bi72MSFy/8l79sg2kA2wqXZINhEkbyrgYcGhtm4yTIaawNyVFwLZLTk28sER25i57sZNaI0AjX
 Uxxrsg/KuXfvaM8WnD+8dT+K7/hz55yTBOJOqVQpPxhredi6vx8Ev0JdSPvEhLoOkAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724086981; l=3502;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=aOS2j6UyXQ0h4/vJ2RKEatenu4Migymun9dwswWBNVk=;
 b=6oZeM9w2ey4pq+8PFoid/wdOeXIEKt8EJq5cLFYoyn7JTkStS6+jD95NG5HzTXlpnnQnKTwtO
 qXBdBNvAI+EAuQvdzBLcgkbKWQ2KfkKOFG4s560QdummRAancqii0P6
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10857:EE_
X-MS-Office365-Filtering-Correlation-Id: ba7b1f38-f8ea-4a25-75c2-08dcc070cb3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzhjalVLdjlmVWJPL3paSG5PeFdra1BjQ2FZTFptUzFtL1QrL2tSL1ZFZ1Jo?=
 =?utf-8?B?ZzBqaVY5ek4veXFRNEFlNlhtc00weXhuWTR2dzNmald6ZGl6a2RSdS83ekxr?=
 =?utf-8?B?T3c5ZUcyZDludCsxSDdqRHBvZ01MTTUyNGRTTTZSMVJaUUNESy9HSUZuaVo2?=
 =?utf-8?B?NDBYU25VbEJsRDFtMzQ4VnNVOHFZYlJVd0R6aGZEZEl5cmpKQUtOQ0p4ZlVM?=
 =?utf-8?B?UzJwZUJVaSs0QU1GcGZUNm1JbzAvc3lrRk9sUmpBcVorV0dqNWtQRHVsbTR1?=
 =?utf-8?B?M3RPN0VUSjN5YWMvSkRlTDNoUUlyVjZKOUhRc1JsTlBjc1BQcE5BRVRONWZs?=
 =?utf-8?B?K2Z3Ti9Wd2dlcThYRllPelEyR2pnTjVHMWFGc21MT005dVY3N25yOGJMOGtX?=
 =?utf-8?B?R0llbEkvYzFmajFvUGk2dGZQSlN2SzB5eVJkQ1RUVjgwcmhvWHVNU0I3ZDJs?=
 =?utf-8?B?d0xDLy9BQVp0cCs0TzdseFJ0eGV4Ny9wYTIwYm83VXhNN2ZvNmVSN01FYzBv?=
 =?utf-8?B?OWxpaUVGa1JOU3ZtOEd1YXhHU21kVUs4Y2tqNFNnRFpoWHhabjFRNXZRS2lx?=
 =?utf-8?B?amZBaGdPY2pVRnpVQVRZcElEc3pnMk9WNSs0NVo4eUJaZmY3VHpIa0QyME52?=
 =?utf-8?B?MW1ZTTFHbDdZWmFLMHdxbWRZMFROeXRUNlV4NU4rZVgwQmRScXQ2QXBtTy8y?=
 =?utf-8?B?YXhrUVdLTGtNMXlBQnFIaWZNOUpoeEtvRmpIUVl1STE4Nk9nMkp1b1pGbUNF?=
 =?utf-8?B?QkdJemo4dzNVMkY1dnJlNTdUc1RDTnBkSG9aeEZVRmRTR0I0REpqeFhteGIy?=
 =?utf-8?B?RDY2YkphNlVrQ1p3b2lDU2ZmWlphSkVMQzJLRzBFRjNWVk9qemdJY2ZMN2R5?=
 =?utf-8?B?TzR4NUhodjlJaXQ2OSttbGxkanNnVkMzZWtaNVptb1cyWFQyZVZ4VFFTOVY4?=
 =?utf-8?B?RGNaZ3JaYW1qcHJzWXJsMWlkMlpLeE9mRGtQdnFreUpjbmxEMGptd1hpYXRZ?=
 =?utf-8?B?WGNabmdpYy8yTkZJMkJaa2N5SGdHRWpZNGsxcnZ3MkdvVUFzcVpNNVJTSkN0?=
 =?utf-8?B?dG9rQVJ2NkhvK081QjJHZW9jL2plS2k0Rngwb0lESE9vTStubytrdkJaVUth?=
 =?utf-8?B?Ym9yeXUvRGQ0UWoxUEhja0NWSWl0cHdUdnZxWXIxcjY3YkVieVVqMTFidGhw?=
 =?utf-8?B?Wm15SWorQzRmSjkveFFHT0xsS3c5QzdqR0VDMWtsaWxlS0Q0SUplVklXeDZi?=
 =?utf-8?B?QXRNaEFOL1QxeVc4YlNOWnAzMm41RmxnL0loNjFqV2lvZFY4TU5LMXg2VGQz?=
 =?utf-8?B?TWJab0RBd1E2dWozSVN0Q2FWaFhUdDZBeTlGaVNBMm5lelBNcko5WHNvRWJZ?=
 =?utf-8?B?U3pRS3JHa0pyRm9HOVI0N0ZDVUNGeEZoUjBTNUQwRHE3cTlka092eS90aGZW?=
 =?utf-8?B?NzcxckpvMnB2dUF3VWtCazZ0ZVRMZzNhbGtWWkc1Y21OLzRMZW9wbmtwVHUv?=
 =?utf-8?B?Rk93L2hDMHdSdDZha1FYRjlYUWRmZE1hdS9uanVxd29WYTRVYVJwdzJ6UVpp?=
 =?utf-8?B?TDlOTEVKOTN5ZGYxQWdScjZ1SzVvZEhpVUZsazFZSnhUbmlMV1dpR1RtTHpx?=
 =?utf-8?B?ZmFRVHlSaFBYRnJ6WkJpVkQxTC9IVC9iK2FPRVVmWTFVVW10dENGRS9Uc0cv?=
 =?utf-8?B?OGNXRzhXV0UrdVR3ck5SMWdpck1UY3hvS0tVOFFYUEIrR3hCcU5SWGl6STdP?=
 =?utf-8?B?Nmg1NGRuWGhwL3lTVlV2THBySUF0ZGtnRjdpKzMzU2dKRXVwNVQ2OGhzN1E2?=
 =?utf-8?B?MVE2czdZbDliSkxvMTVubURjQUxFejFTbDlEUzhGRno0T0dHSWQ0R1Bra1Bx?=
 =?utf-8?B?K09xVVlja3A1TXNRK1lHcmNuQmZLWGlrSXpCUkdTdXlkUWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVNxaktVMkkwNFc0ZzhsV1NlcUwwU1dPVkxxRVo4Q0NJTm9Ud1BHU0UreEVa?=
 =?utf-8?B?SW1rSE02cXR0Rlh1NDRTWFMwb0F0WlFzbFdyaGp1MjZlUzJseW5DMXM0WFl3?=
 =?utf-8?B?NTZ0dHZqSGtaSmsvZHZqbUU5dTJNdVlOdUlaTndUbmwwSDNnTDNRU1oxNE9y?=
 =?utf-8?B?NkF1eVgrcWFYajl5c1hIMGxWNEdzanlrRjZLRHZnOW9CTTYxY2JRMlQydGJX?=
 =?utf-8?B?REhHeDYrMWN2MHk4TFhTTDFUTzFJbHVqU1VhWjl6OGljdDRybFBEdWRmVklv?=
 =?utf-8?B?MnFQTUZPU3lDMEtTK0laOUc5eGQrKzFVUWlUb3B1cHRVMmNxYnpRL2tDSkZr?=
 =?utf-8?B?RzZLQjJJQlBoMHQzaHdEVG1YcUNUT2ZITW1sQkxjdWNad0pSam4yaFNId3NZ?=
 =?utf-8?B?MlpNcGdlT2tjOEdrRWs1ZTFWSU9sc2lQcFMyMCtjdlNJRFcvSjk5Ri9kOGNw?=
 =?utf-8?B?VFd6K21kZmU1RWVpKzhKdjIvRmJlSVM3TzRBWXlyZWFsMjZQYUliVDUrbWNL?=
 =?utf-8?B?ZlpUdDVITDQ3d01aTzBlT1BiQjdOeGN0Y2F1bEZqY1pqU2JDRlRIOFEyRFBH?=
 =?utf-8?B?aXhrSjhBNzg1SVFidFFhRUZMNkxWeTFaYUM4dG1iSGlTNmx0eSs5MVhNSHhH?=
 =?utf-8?B?VGwrQ1FlMVorbzQvejJEakpzTlVCbGVVRzZTbkorTkdSNVg0emcvN2tqeFFJ?=
 =?utf-8?B?V3RkZnk1SEovZzYrVE9vZTg1K0pLc2p1b1Y5UFlYbGM2dEoxb1MwNzl5cFVF?=
 =?utf-8?B?R3NNeXZyZGxJQ0VuMDlFZ010NnVFT1ljWFowWW1wN0tFVDlDVFBPWXF4YVBJ?=
 =?utf-8?B?SlRNZFlXd1dtMW9oSlluU0FTQlNDb2hvSFRvRGxBUHkwVllqMzFmZmVjUFJJ?=
 =?utf-8?B?cXhiMTcvdGlrNGhjcyt0VEx6Tk9sdjhOQys2TXRpbWxLWTVIWDdGRTlMVit5?=
 =?utf-8?B?Y2FSaG5PUmJ5QVBFdEZGa2ZjVmZpemJXT0lXQXFrN0crc1hKVDB6VTMzc2xy?=
 =?utf-8?B?RlQrSkhRZDJ2ZXFZL2syam42WGdybWZUaXNMVGZRUHV4WVR6TGlPZkJOemhE?=
 =?utf-8?B?T2U2cjJEbVBydUx4dzl0VEpXMDFWNXBBMzlzcWF4QnNxSDBYMkhwc0xaYWxn?=
 =?utf-8?B?b0VSbjc2dHg0R3hlU3Zkbm1HdklOcU5BSUp2Q3B0cmdSL0U0TU9sY3Y3bTJT?=
 =?utf-8?B?WXVSaXpiVzVZc2ZqOFRXcEppdHc0UUJnNjhhajd2cXVzSFRFYm1iVDFMbURH?=
 =?utf-8?B?Lzd6M01RSUdYVW1Gb29rbEpaUnNWMU16dWtITDFRNGUyRTFjTmlJcEZTakJy?=
 =?utf-8?B?aTBKSThzZy91dVd3bHVBak9rNk9Nbk14SURkK3VOd3dNcStrS1Z4b1paNDBX?=
 =?utf-8?B?bnJhYnVzUUF1OUwvQXNJYkFWaDVWY21XK0FzMzdaalVtcVlPQi9BdTlKUWxB?=
 =?utf-8?B?cGU4dS9NbnJDMnFCdVMyM2ZleEtYRnZhMlljc2Y1Y0NVZzJDODlsS2hnVVJm?=
 =?utf-8?B?VUJXVTR3YnVzZXVMK1p6TEcwMXA1N2pKT3BsT2pkRHQyQ3I0OFgvQ1B2K0Rx?=
 =?utf-8?B?a2F6b1JhK3hQUkRaU2pERmt0cjBDdU9zdFFrdnJteTZMT0Z0Q21pQUtmZktB?=
 =?utf-8?B?eUE4OUpxeFhJMm84NWFUY0NJdlk5YVlMS2tTd3FFUWdNeEJWK08zWHBIMlFT?=
 =?utf-8?B?eFY1dGlPODlxZ0xLbGsrUWZlU1JVQnhXWFJFWVVWQmVKaXBwWUl6b2I1SnFy?=
 =?utf-8?B?UVVrbnJEL2FNT1VyZ1JDck81aHQ4VzNGV1kwaVhtajhKUXR1b0VtYVdPUzNu?=
 =?utf-8?B?cEVlM2FuVGswNmp5bWFVaEtONEJaTER6b1J1by9BbksrMFBpTEZrV2U4Q2d0?=
 =?utf-8?B?dDVRekp0STJjckx3anpXQTluNFpDOFEwc0QxcWMyUGhjNnNRRDNxQUU1VnFa?=
 =?utf-8?B?YnV3cFMxanNkT0pCS3hnYlloWExBNkxxQ2UxZTlvaUY3UCtIbWhOci9HSnFa?=
 =?utf-8?B?ZzNlREdCRkJBKzdFcVZwd0ZXc0VEcVAxL2NtaXFqeHJyRDdzS2FNNEVsU3l3?=
 =?utf-8?B?bGdzL1p2b2p5MDgzNnV2Ylg0T3QvSHViTjlFQ1p1eUNFckVFMmx1ajBkV1Fs?=
 =?utf-8?Q?xj98c00ofOzuMMXNijKHJEjTG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7b1f38-f8ea-4a25-75c2-08dcc070cb3a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 17:03:05.9307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znLfPlbyMdZ+fJ7DNkl1KcEIANwqx0mAg8bDr4XqUq1Kprcub4wodTh7lMlcum3DwQ9yFByHdW7VkheriP4iTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10857

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- Merge gpio hogs rename patches to one
- Delete remove big-endian patch for watchdog
- Remove patch imx93-tqma9352-mba93xxla: rename hub to usb
- Remove patch arm64: dts: imx8mm-beacon-kit: reorder reg-names cec and edid of hdmi@3d
- Add Alexander review tag
- rename mux-mdio-emi to mux-mdio
- binding doc change base on next-20240819
- Remove patch - Link to v1: https://lore.kernel.org/r/20240813-imx_warning-v1-0-3494426aea09@nxp.com

---
Frank Li (12):
      arm64: dts: imx8-ss-img: remove undocument slot for jpeg
      arm64: dts: fsl-ls1043a: move "fsl,ls1043a-qdma" ahead "fsl,ls1021a-qdma"
      arm64: dts: imx: rename gpio hog as <gpio name>-hog
      arm64: dts: fsl-ls1012a-frdm: move clock-sc16is7xx under root node
      arm64: dts: layerscape: rename mdio-mux-emi to mdio-mux@<addr>
      arm64: dts: fsl-ls1028: add missed supply for wm8904
      arm64: dts: imx8mm-venice-gw7902(3): add #address-cells for gsc@20
      arm64: dts: fsl-lx2160a-tqmlx2160a: change "vcc" to "vdd" for hub*
      arm64: dts: imx8mp-venice: add vddl and vana for sensor@10
      arm64: dts: fsl-ls1088a-ten64: change to low case hex value
      arm64: dts: s32v234: remove fallback compatible string arm,cortex-a9-gic
      arm64: dts: imx8mm-beacon-kit: add DVDD-supply and DOVDD-supply

 arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts       | 12 ++++++------
 .../dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts | 12 ++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts        |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi           |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts        |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts      |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi       |  2 +-
 .../dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts   |  4 ++--
 arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi           |  2 --
 .../boot/dts/freescale/imx8mm-beacon-baseboard.dtsi      | 16 ++++++++++++++++
 .../freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso    |  2 +-
 .../freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso    |  2 +-
 .../dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dtso    | 16 ++++++++++++++++
 .../dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso |  2 +-
 .../dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso     |  4 ++--
 .../dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso     |  4 ++--
 .../dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtso    | 16 ++++++++++++++++
 .../dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso |  2 +-
 .../dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso     |  4 ++--
 .../dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso     |  4 ++--
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts   |  2 ++
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts   |  2 ++
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts   |  2 ++
 .../boot/dts/freescale/imx8mn-beacon-baseboard.dtsi      | 16 ++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts   |  2 ++
 .../boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso  | 16 ++++++++++++++++
 arch/arm64/boot/dts/freescale/s32v234.dtsi               |  2 +-
 27 files changed, 128 insertions(+), 30 deletions(-)
---
base-commit: a50aae2269990c41a5bb896cd9340395da000eef
change-id: 20240812-imx_warning-7bad8223a128

Best regards,
---
Frank Li <Frank.Li@nxp.com>


