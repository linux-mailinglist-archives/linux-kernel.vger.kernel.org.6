Return-Path: <linux-kernel+bounces-347743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B146C98DDF4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D475D1C23DD5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A4D1D1F52;
	Wed,  2 Oct 2024 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PEXUPkii"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136A11D097D
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880673; cv=fail; b=rqfaZjk4rhV7dWjRYllwU2tG63y3gVOodWFJyd7Fb+lsVs5y7vsl8j7KE0ei/q3a9jQDq73t6knf2z3ADj92ASysXTBBGQfpawf20SmK9xWG1DblNTmARQPliQKnQUDByzqOhoEd7QSrib39O5VNOf0eHPPyL6oY7uywMhU1Onc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880673; c=relaxed/simple;
	bh=G9/ttx8HfBwzcCCJhNo04kopgONzp6KBdwhqa41YDTc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=esocUvzZcuAB6dk1T5g+vcZchXlBar2h/Gkzsxyd8cBencc8dR1PAe10sXDKJKo4ydbxcnyw9S75363VRTHMfPCZQing6SERsp8UMmFpOIgBYasXnS830rTjno4GykAlEgJwci13hZoOZA9G83j38kPJrPIg6saZQcbe0HaVyMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PEXUPkii; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXkh5eALk5vyRhsUdVGILm+dGYBIk5oeuRaj+gZOBUDJUkYmXgZPrg6h4dCTO8cpOBaQB8gi4L9kmWK452CWppmH3TOODVrjlb/Djq4XIEP5uOuxs2qhAIbrkbs2NgtbQJQQ8mTUCMCAcbbSMpH5bI+1tOamF9Ievxys5zCVX4LkJRLjMkzW92mcb6Byr87EuLR0WiaTVblRIqhI5JdKkrsuDzhmH335GmLUE0+LjzIAqY1d3eFxBSE3YOvSXa6H6XUXjeT6IcOqbay06XEAHcNdAEb1+QPl9/xMlp09zSQp4Fkdu8jGFxY+a+tx/Vu8u6PpQsSsBjDlj5oNuCysXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCabqBI/J+Um2gFtk/c1eujjBGuD7tYM07r5dx9+W6Q=;
 b=jxdP2DcKPBe0zDSp+8mzcrWWYge39sggik/ye06ecGSDVTLcZkw+y9dmK2p2yryun+GAup7KO8i4naz9XLy+uTOwrhAmXYhSQC7mA4tpiB2Wl/GfbR6mkmGic72Nv+4zRA4nLCmj8/dvY64JEifwdYqUdhnwHdRn6jsFFthID1mQMfuRYINfaUpmGUX3kbS04KXrss5OmJmR9U3Plb4ifmzWt9dcv/Al1unOPC8o9O01XQRyA5Hu8LdQOiIhxvNOLo+qjkXByge6JIhgz7BpA3MPvV1zyAFjY/yVzZtBL7a1j6jPfHoHaIXn7h63M/7OTUIZ1ZneEiZtg7J8XQK4QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCabqBI/J+Um2gFtk/c1eujjBGuD7tYM07r5dx9+W6Q=;
 b=PEXUPkiiO8XmHi0q/MkPrTL4+Bta8iS9vIrlsqMXWLLFKYb6VWEs6EQdyQS3NxFBZNAfsyxoclRM3dEzIUsNKGDGNuvBVwIeIivOs6yfW0GOpQwn6yX50zhHU4nhVxzLurGrZvZpOKMpxWSQhr1slRXju5Dw0MZEHZbns8N8Mqb1Mv49Xv1ekz1Pr3anl0GullU3nqLwZn0BJiavZj1hwKEf3st+o9fGrxxIxU1kORPSwyC7aaV/ISY/4RqL1PktUZATXeWNy8BiLsa7qjU68INIe503EZ0f6VqnpblGvMgbVvM9vcQlBTrpNnXPJvoGNJxDex8H7rzM1N0w4k/f8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9699.eurprd04.prod.outlook.com (2603:10a6:20b:482::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 14:51:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Wed, 2 Oct 2024
 14:51:03 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 02 Oct 2024 10:50:37 -0400
Subject: [PATCH v6 5/6] i3c: master: svc: wait for Manual ACK/NACK Done
 before next step
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-svc-i3c-hj-v6-5-7e6e1d3569ae@nxp.com>
References: <20241002-svc-i3c-hj-v6-0-7e6e1d3569ae@nxp.com>
In-Reply-To: <20241002-svc-i3c-hj-v6-0-7e6e1d3569ae@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727880649; l=3372;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=G9/ttx8HfBwzcCCJhNo04kopgONzp6KBdwhqa41YDTc=;
 b=j0Cy3zpyiNPCgiiRenemJPXQtFjOsLeN0k4YpZehwlftlCPnvrOwh84fLbeXlV3tjg/OQC8vk
 cLXKwyPyjfWC8euOFJY6eV/24w2f7PuVitZptCbp8suugX96dVVqxqO
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9699:EE_
X-MS-Office365-Filtering-Correlation-Id: 35375ec9-9797-4301-1bff-08dce2f1a324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWZNMVNZOFFYdk84dG43Ym1HVDFtWExKNk1oeWpvRzZoM0ZnN2NRb2VXUUlL?=
 =?utf-8?B?VGpNdXZpcU0zV0VuQThRRmQ0TXNjZFptMmI4eGdUdzdqbDFlVjE2cjltRGhU?=
 =?utf-8?B?YmhMVXNJbmlaUk81MllGdUZ6eWlYTXl2c2RsNzlEZDM1dk92Q2pJVVkycTFp?=
 =?utf-8?B?aGJ0bldLeENSWXY4R3dvbGNmSE5weFB6TDhFTzdVYXFrdVJRRmVBOU8zVDlt?=
 =?utf-8?B?R0NKbmY3ZUlFMXcvQ3JjdzBjM3c1dC9XRElibS9PcGdmcGxHKzkyanJscWNQ?=
 =?utf-8?B?NTR5WG81c1VtQllsMHgzSVdFMmh4SVJnRHc5TWZLSmRoUldDRU1QdHFuTGFL?=
 =?utf-8?B?Mll5VzBPY0h3S1pUM0NoanN1OHNyQjQ2OHo2S1JFT1FsaGNGRDlUTy9saUIy?=
 =?utf-8?B?YXh4SXhiRkMzOFVRZWE4WDVXMEd1RWlsb2RvMWcySmFyNVRiTzVXNW52QlI2?=
 =?utf-8?B?a2xOMnFsRkpFSFpaeE5ZQmZiTEhEdVVIWVlYUjVIUTNIUHQza04xc3ZIN1Rw?=
 =?utf-8?B?TDQwdndOMjl4ejFEemV2Tk0xVzFrbzJNQ1lzVkVUdjF0cHc4UytPYXN6ZDh4?=
 =?utf-8?B?Mm56Q3JpWk1qTTd1emt3enRoTFVUOTBlclJNaWVhbEh1U2VyVkR3ZEM2WFZI?=
 =?utf-8?B?ejhvZW5SUSs4MU9ZZFltakdEQk9KV1BzZ3Z5L24xamt1UmVFSkZ1STd4ekpk?=
 =?utf-8?B?eEJhbTJWT0xMakUwVVBMUEFxdlFaV2tZTm1zc2lLM3NnTDRnQ3A0Z3lPOHdi?=
 =?utf-8?B?d0lLUkRtS2trNFY5OVFGemJYZVZNaEt4WUVra1hyYmt0U1lzN0pudWN5MWFV?=
 =?utf-8?B?OGk5Wk4vVzFxOUpYNEFlVG9jNnZkOGw3b0xxQXJ4V0FLOVpHQ2dyWVVwcklv?=
 =?utf-8?B?RzlTZ3kvQ1pzQ25Id1R6ZG0vL1ZPbzBjdEZ2MCt1TFcxd3JyQUg1QmhzeENq?=
 =?utf-8?B?ZnhydUN4MVIzbzNzWk5RaGlDakZQSzdSeG40ZE5IeTdrelBYa3lEYzQ3QmY2?=
 =?utf-8?B?SjkyNTlnUTVRUEs4WTA3dWlHQXROZFRzU2RtL281UHA2MG40OW9FTUpVTklo?=
 =?utf-8?B?RGdSeDRMa3RtYU9sMkFvMzV4NjBidUtNM00xeTBva0R5ekFxV1BWYUFlYzEw?=
 =?utf-8?B?VzhYS2ptTTEwNm9BNVY1OXBTVDNNcXdYaTBKTis0UjJDekw4b2pocjRXanhj?=
 =?utf-8?B?UUljNFlkQkF3TzAwS1JkdktRWTFGdEwrbjZpd3hFZHF4K2UrTlVKQzEyK0M1?=
 =?utf-8?B?Q0hmS1dJKzBaVENXV202Mm9ua3l2TFUwN2ZMQm9Db0hPR0FIckhQTTRyTU1L?=
 =?utf-8?B?TG1ZZVhPZWFiTjVLZW9kRStLSE53clZQUGUvNmdyNkhna3VRcytLTHdOYU5l?=
 =?utf-8?B?UVUxZlVNRytmeGJyQnhuVnUrZ2IxUWIwcFRzSEVIL0pzcTdvN0VFOHdlWWkx?=
 =?utf-8?B?VWpzOHU0MWZYNXczSW9RNi9yT2kwMXZTbUlqSlBhUDlqN3VXY1FoYi9ncnM2?=
 =?utf-8?B?bjhqT2F2ZVhleTluVmRHcWhlY1h5K2ZFcEozTHFkVnhRM3FVRWU1WFd4ay8r?=
 =?utf-8?B?bXdLNmptSm8zYXQ2eFNYK0Y2end3V29HMVMvbFg3ZE1aak10MEk1Vyt0bFIv?=
 =?utf-8?B?UlpFMlNwNnRnd3dqNWYvbVdpVmoyalVjcWZoTzhMM0dQbGF1amNrL1QwREpI?=
 =?utf-8?B?YThTL1FSWmxvYm1Kem5aZHlhNUZLckhFSGJ2b2J0V3ZhMVpZUndETm1Ub2NG?=
 =?utf-8?B?Z1h1dlV3eXlNRnl6em5yWHp3WHQyaWVLR0YwMXZUdmJvbzlBcXNxYUZnNnNJ?=
 =?utf-8?B?WkhjZWJxZFFOQU9ONUY5QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUhyWkhGVm1DNHlqNE9vVXNLdy9aY005b2FJRWlxekVST0tXdnNyOFpEdFMw?=
 =?utf-8?B?SUJ1QnFMZ3BMb3d6TzFFaWhyd3E0SFFQQUw3L1AwdzVoWTI2U3BSclUvMXNh?=
 =?utf-8?B?ZlZNNnNWVCt6ZXdMcFJ0ZDZaVUNsdy85T0RrUXNBQzN1dmVTTFNpY2hiaUZG?=
 =?utf-8?B?OXhZQ2MyR0hLUkJPbkN0SzV6c05XYnVTenVwUGtoU1RVMmY0L2dNSmNSMHo1?=
 =?utf-8?B?aGUvVFk3L0padk5Hdk5hV2hXTG5nQU4vZXUwcHZ1UTVqNFF5OHFqaGFlL1p0?=
 =?utf-8?B?VEQ0b3A4WXl1SVNUbjdDOXdNK3dzdmRKbDF0NytzelJ2QzZTUmtUaE14WUht?=
 =?utf-8?B?TkJrSTR2SlVISFpuK1N3VmJqdHJzdU40bUlqdVY1dytjQzV1N3VTRFRZRElW?=
 =?utf-8?B?NWg2QUZuMDRKUUx1ekdtSUlXQUlzcUdmdkdMazAreDlkV3pPbm5lcXIyNEMz?=
 =?utf-8?B?NTdKMUdTTCtLYm1teVNBOHh6T0Y1UU9LK2ZhTENINE4yWUpNd3czY0dRS2xy?=
 =?utf-8?B?SUMxcStncWZKeEZnek0wWCs3aDZJcTBwR3hUWTQzaXFwVnpnWVpKL3JIRGgy?=
 =?utf-8?B?cC9Zelp1d09OaXNFd0xsUDZzd3RHRkJGeWJxdUpvR2xxWnkxemRTdS9TZm0z?=
 =?utf-8?B?UUVFQzhWMzhjVmFVV3gvRVJYWU0xaVFjT2UrSG1mNy9FNjVsTkt5ZWlCcnNl?=
 =?utf-8?B?OTBNRmg4K3NUTGFrUWVoVGora2F2N3FMZUFaOXdTSDBsay9XbGhaditqTTlq?=
 =?utf-8?B?N3hPSjV3b3ZkSGhWbGdPSmFoYktWM1RIZlRWWVlXWjVheUxEMlJpT0VHeFdI?=
 =?utf-8?B?bERGbnFGQVVPOGZuYXdmWGhJWHNwVTNnc1pOMVBKWjQ2VHcrV1RnNjBpZVdm?=
 =?utf-8?B?NTN1azZLTFlBNndKRWtaL3NoY215eCtadC9jcEFraUdRVzROdHRxVTg2YWIv?=
 =?utf-8?B?bDI5cjRUNWxYR3pWM2VCT1NrRW5XL2Zubk1SbnFLQ21rZmRIZkxsTGh4Tmk0?=
 =?utf-8?B?MEl5TDNob1V5SGErc3R1TkptUnVpNVp1VzU4LzZtSUY5dHcyRE4zU3J3eDMw?=
 =?utf-8?B?dTNSNVc3cUhXUndBM0dRTi9ucjZTWGcvMlpWek5LeU41Y0JhWkx3a3psMDBN?=
 =?utf-8?B?ejAzMGl0WVAzYk4yZlFENEhwYjVpeDJXOVZIUDB5RzgvU0VVZWFjMWhUMCtG?=
 =?utf-8?B?dDhPWVJHaFpxZm0zcm1nZm9PUXRYUlNybGo5TTNtK2J6dTdDS0pBeTYzeEtz?=
 =?utf-8?B?U1FaZzc0c0RFbGdLWUJ6WjFTQS9SNjVUVHc1dDRnOENCOHJ5TzZlRmR5eU1F?=
 =?utf-8?B?bnNYNXB3bGxjTEVSK3RONVFQaWkxTjFPekd6WHJIRlIxazZ3bm9JUmg1ZXdm?=
 =?utf-8?B?N2dxWGZQV2RNLzZGWGVDTGVITUtEQnppbEh3V0ZLWDRINGFjWTdWQnZILzVW?=
 =?utf-8?B?RHhpb1FBYWUzb3BtQU41WGFueDhPOTE0ZHpSQjdoaFJRUkk1TFFIQlBrU0I5?=
 =?utf-8?B?T2U4L01xRnNyZzNVZmdCVGNmTWg4OEZoWU0yV3RvaEJOVVlLNVdJdFFYTUxV?=
 =?utf-8?B?MForSlROdHhBWjdlVENyK3UzRE1QTjNPUG5ZNmlRUEtrRGxnUDNxTE9CWDJt?=
 =?utf-8?B?UmU1SStQejM1ZFk2bXc2b0hHeUtzMnI4czBiR0xCZEN1VUM5M0dDWE1TekU5?=
 =?utf-8?B?N3ZFTE9ONlJLZWRlUXNrb00vc25MUXkxNjJnSXg3b1BKSmdwRlAwcFlNcXpB?=
 =?utf-8?B?aVdaeUlQRGg4a0tVZyt6WlU0NUhYNkYrRHFiSXhJRXJRNmp6OWo2clhtYnRL?=
 =?utf-8?B?WWNxREhXeDZtSUdFclVjU214NVIvZTQ3cHNlMkJHRHlwbFR4cVJ2am0wSXJ4?=
 =?utf-8?B?NkQwZkMvMk1PWWJ0ZVJRS2ErSmQrVXdVYUVqOE8zbzBOVmNhSFZKSlozSTIz?=
 =?utf-8?B?SCtuNW11WDdOSUpnRVJBRnZxaWw1QUgxSmVpR3FJMytYREJHMjdJQ2RDUkpL?=
 =?utf-8?B?L3BNMXVnQWhwZlZXS0hMNXlDcGc1S1BTSXY4NHArQTl3QmFrTVBVQ1hsbW9O?=
 =?utf-8?B?TGdUTWlzNmxEdWs1QllYTjJubFVpTjdWbFZiclNzdmZsL3hPVStBMGVpUXE5?=
 =?utf-8?Q?IbBBlCd00y17kx8YMAQezCkT0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35375ec9-9797-4301-1bff-08dce2f1a324
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 14:51:03.2566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cx1JgCw6BMVgYqsPZbDQA7JO//otiwWncNvPum3BFme3Cn73gxxpXcIZZbEz08MHSWJPLzNmvUwfZSAjEpAacA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9699

Wait for the controller to complete emitting ACK/NACK, otherwise the next
command may be omitted by the hardware.

Add a "command done" check in svc_i3c_master_nack(ack)_ibi() and change the
return type to int to flag possible timeouts.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v5 to v6
- add "add a" at commit message
- Add Miquel review tag
Change from v3 to v4
- rework commit message
- add miquel's review tag
- directly return readl(...)
---
 drivers/i3c/master/svc-i3c-master.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index ed3f1bfbea37a..7ef7e50b4b916 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -388,10 +388,11 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 	return 0;
 }
 
-static void svc_i3c_master_ack_ibi(struct svc_i3c_master *master,
+static int svc_i3c_master_ack_ibi(struct svc_i3c_master *master,
 				   bool mandatory_byte)
 {
 	unsigned int ibi_ack_nack;
+	u32 reg;
 
 	ibi_ack_nack = SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK;
 	if (mandatory_byte)
@@ -400,18 +401,30 @@ static void svc_i3c_master_ack_ibi(struct svc_i3c_master *master,
 		ibi_ack_nack |= SVC_I3C_MCTRL_IBIRESP_ACK_WITHOUT_BYTE;
 
 	writel(ibi_ack_nack, master->regs + SVC_I3C_MCTRL);
+
+	return readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
+					 SVC_I3C_MSTATUS_MCTRLDONE(reg), 1, 1000);
+
 }
 
-static void svc_i3c_master_nack_ibi(struct svc_i3c_master *master)
+static int svc_i3c_master_nack_ibi(struct svc_i3c_master *master)
 {
+	int ret;
+	u32 reg;
+
 	writel(SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK |
 	       SVC_I3C_MCTRL_IBIRESP_NACK,
 	       master->regs + SVC_I3C_MCTRL);
+
+	ret = readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
+					SVC_I3C_MSTATUS_MCTRLDONE(reg), 1, 1000);
+	return ret;
 }
 
 static int svc_i3c_master_handle_ibi_won(struct svc_i3c_master *master, u32 mstatus)
 {
 	u32 ibitype;
+	int ret = 0;
 
 	ibitype = SVC_I3C_MSTATUS_IBITYPE(mstatus);
 
@@ -421,10 +434,10 @@ static int svc_i3c_master_handle_ibi_won(struct svc_i3c_master *master, u32 msta
 	switch (ibitype) {
 	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
 	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
-		svc_i3c_master_nack_ibi(master);
+		ret = svc_i3c_master_nack_ibi(master);
 	}
 
-	return 0;
+	return ret;
 }
 
 static void svc_i3c_master_ibi_work(struct work_struct *work)
@@ -935,7 +948,9 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 			if (ret)
 				break;
 		} else if (SVC_I3C_MSTATUS_IBIWON(reg)) {
-			svc_i3c_master_handle_ibi_won(master, reg);
+			ret = svc_i3c_master_handle_ibi_won(master, reg);
+			if (ret)
+				break;
 			continue;
 		} else if (SVC_I3C_MSTATUS_MCTRLDONE(reg)) {
 			if (SVC_I3C_MSTATUS_STATE_IDLE(reg) &&
@@ -1209,7 +1224,9 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		 * start.
 		 */
 		if (SVC_I3C_MSTATUS_IBIWON(reg)) {
-			svc_i3c_master_handle_ibi_won(master, reg);
+			ret = svc_i3c_master_handle_ibi_won(master, reg);
+			if (ret)
+				goto emit_stop;
 			continue;
 		}
 

-- 
2.34.1


