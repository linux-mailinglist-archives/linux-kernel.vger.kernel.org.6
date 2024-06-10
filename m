Return-Path: <linux-kernel+bounces-208878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A8F902A27
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F672822BB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5823315253F;
	Mon, 10 Jun 2024 20:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rGV6h6dZ"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6D515219C;
	Mon, 10 Jun 2024 20:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052429; cv=fail; b=Xp34Dyr4sW5my51ThjSLAQECj2NeDupB5UVWqtxdgl7OBiDMynUbhksqVYo22qOoNNH0Jw+mSc6hq5FsGfyA4n0UoWD+t52W/jbb986nflyeKUqng3uCr78XtfJGELTbKJnytuzEtTiolfugZkraoyuDX67t/pjnTZwVsIiuuns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052429; c=relaxed/simple;
	bh=BGdAl9Cw88q5CXYFPKaVtp4lX6FlBfRQpGYgJfGNwyY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Qw2HBWyy0pC7C5gPB6QhdAZyUSPZVL3WGQO0goQQxzWlhoFHPUxqPEOwNT5CJNRCyYaHGwplm0sl2ugvoVklz+UMf4rqjvjfXW8+h+H1YQQ+EStzqBqgHJyDpk0IXzwFfvw5ODsS/yfyXYVTA1HBirmZKg8YEv9W+x1gktldLN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rGV6h6dZ; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DISjU6eNEQBvV/QHqzV4Nli8GGjXiS4Rsv1ISNExvAmycSsnKqfixeBiSDf2es7PsnXBJ+iLzAaYQrdigjWYrdqkBMq1MOjheJP9Z89G3X9SVRxtzphGU3fJ5RsEQ7hqj27pLG53VYg9xkanA2qqXNFcprMO6L+oPpjgZywb11S5WUAAaZEWtLorbLsrwhnTX+DuZsp5HpFG1FH/SEWcQSxmecPWETsGtE5clPmNPKnyqGNQ1AhmYJMhhIlyvsttxEkvctBlwCSOaxiPDYDlqYBlxQ6tWfEg8ZRS+VqiVYqwtEDs+dfo2glW3H5ROB1YTulCrxKJhjnhFbNbcfMKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5noNf9OgsZyK0Puh1BxlGX/SHf4fS2HLp0jvD3F09k=;
 b=KYaNouUi4FksiLWF1zfdej7orAbXXe7BEms7kRkSAoWjIuqTf23JZpyOzfR7fma28Ao1fNbn442ymmrxkZrxzkVLS/Fn68YH1aRiV7oFerf+/jsHBhsLTXsHGDj7lVe6A5woZAMv+4EhsL9eLDXMZtf7nRCcPy8mv9AJGMvqOwdGPUs7pW2t5HuPP2crhB2vvq0fXJNiTQCL3Oj7VihVlXn3ed612w4yxXakm0KnEmpPE/eYuKl9ERHabn2WFlLZ/2SA6gQhmo2Wlcw+QK9rTAs8EGF2v1eprdHjz+OjfAtTueLPmj6ONouuTQ/djMXwGmnMnKwH92y/WHpwob5cjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5noNf9OgsZyK0Puh1BxlGX/SHf4fS2HLp0jvD3F09k=;
 b=rGV6h6dZIjzEKch1H/OsJI/9aOeXnhYutbbqoxf5IZj70Ok2l3As3l8vP7E9Ct8zkqO3+/rwPPRL5wQ0sGdbYdYOhJUDjn9Es9wsp+KrWWjwFOIcM6cW5my/GB597p7kXRTrVaMNhsWSf+M6JGvDc6dNt77wQPjBUS4mN+q9apE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9376.eurprd04.prod.outlook.com (2603:10a6:102:2b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 20:47:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 20:47:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 10 Jun 2024 16:46:26 -0400
Subject: [PATCH v2 9/9] arm64: dts: imx8qm-mek: add usb 3.0 and related
 type C nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-imx8qm-dts-usb-v2-9-788417116fb1@nxp.com>
References: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com>
In-Reply-To: <20240610-imx8qm-dts-usb-v2-0-788417116fb1@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718052391; l=2977;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=BGdAl9Cw88q5CXYFPKaVtp4lX6FlBfRQpGYgJfGNwyY=;
 b=WNwIlV9Jh8Jz9EGf/thYITAxuN8/su1hBXZ1B8/mJQY9G1yn3gfZ43eRg65NX3svU7Zm9uyNM
 qt25zTD3dRJA7Je22e9A94R9+i0avRccqpxh6DDIdpnIA6XdSY69S04
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9376:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae6cafa-6b61-4932-ee2b-08dc898e7d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjR4OHp4NTExZW8zSHZZMFJUUGlmM291RmhNRnNhblJwSDRNYmk1SVUwWVlR?=
 =?utf-8?B?NWNhWTVGSktCU2M3aitkcm83Z1ROQWprMnd2YnZ3dGFmek5CMHdrV2ZIZm9D?=
 =?utf-8?B?VzM2N29mSkg5ckxQdGJaYkVXM3dIamFvYWFCV3d0QjVsajJoYW5UWmJOMkNm?=
 =?utf-8?B?V2dqRlk0b1RWeUtmVEF3S01kdndpcTgxajAvMGZYZHhTWEVVS3BLVi9YZzIv?=
 =?utf-8?B?UWYycDN1b1VwUzVSTjVZVUZiZkRWSzdjNWlpWG43dGZVcUpsUXNnMGc4VFFz?=
 =?utf-8?B?WUlIQVJHZm1HcmJTdTgweEM4cnM5dUtVUE9oUjdYclFWeitoWFBRYjdrQUY2?=
 =?utf-8?B?QVZ3ZW9vUmt0a0VWbzIyMXhsd1ptaVFWMGhRSm85SDdXOFNyTFE4UWt4MXh2?=
 =?utf-8?B?eUZoN0R1UHFsNXh1NzRhZEVXb0dhZ0lQMWt0cVlFMFdvaitJalk0dEhMN0tO?=
 =?utf-8?B?cEN3Z1NOMXdvWnRSSjZpZUtrcG9xV2dCMEQxOU9yaHFpaVc2aGJjTnNKcGZH?=
 =?utf-8?B?Q1d6WnFKaTEyN0VFTHRuWndZT2V6L3p3MzBYdHUwR29jSDFFQitmNXl1MCt6?=
 =?utf-8?B?RjFuVGgzNmpCMi84L3FJenFYOHc1K3U2aGFKejdaWkpPWWluV2FOeFFnVFAv?=
 =?utf-8?B?VnZDSDZ2dVJ2ekpSdjg0Ky9YUFBXdjlmc2o4UURUZ0hTSnNlUThhYUJZeDF3?=
 =?utf-8?B?TXBMWkIrcU9nL0FwOE5NYWtkbS83a3ZycGRPbC9QVjJ6MmtMQzZqbWJTU3ZE?=
 =?utf-8?B?RCt6byt4OVdTb2lsdlhhUVpzNnpTc2F4b3RLU0ZhNDQ1VDVEdURHZ295YTlm?=
 =?utf-8?B?SWtldzhFc0c5ZDhZTE1ubnQyVExDRDBrRDBJQnFrN2lhbThCOExOWVRLakZB?=
 =?utf-8?B?eURMdEpNZUs2M1VEL2dUYzF4OHF6UlN0R1Y4MDQ3L1BGdnJrOGFaNTJsZmV3?=
 =?utf-8?B?bXFBdnI4UEwzV0c0R0QrN1JMaU5rKzNNRDVhTmg1cEZBWGQ0Ylo2c1ZSTTJj?=
 =?utf-8?B?Q2U4UWlPMVZ0YjhpR0NmNWpwUWVRdU00MzZPWkhjVVgwczVVcWZRTnlOclNL?=
 =?utf-8?B?VS9kSFM0dGladGtUQUpjVTNxNkkzbjg5OEJrR0d6NllBL3FzRlBXUG45QlBh?=
 =?utf-8?B?Q2hFR0t2NE8vLzZJWFlhS1FQeitSWWhkYnBIN2lsblpYeXVieDlLblJPd29z?=
 =?utf-8?B?SnlIck1jM2NJUXcvT0o1MGgxK2V4VEhWcUFOa29nWG1mYk10bHBtOUxwSWE2?=
 =?utf-8?B?aXNmaUFQSkg3WjhYRTRqRmJIZDdPc21pcE9lRHJ4YUFOcXE1Q0xEdGwvRSs1?=
 =?utf-8?B?MzJDVkNFUVI2ZWhXaVVlUEM0dzZ0dEdSSTIwTVljVWE3QkwraklxSm5mZnAr?=
 =?utf-8?B?b0hZOGhESHNOUElsTXdFVUdvODgwZitTb0RaRnczY2grd0pZaVJVZ3lUazBW?=
 =?utf-8?B?dXJSdHFXNy9wUE9IT29Sa1gweTdWbFNGbjVNL2RnN1VhZGVsRHpqVy9NWjRt?=
 =?utf-8?B?YVJ1cUZWYXpBTGxaeUtGZ3BhZ2c0R2RldXNCaXpINUx4VEJyRlFSUmo4dGEv?=
 =?utf-8?B?S2EySDk1a2c2YXQ1YmxHUnNKeFhyQ0hsZWdmR2Z1cVN6SWxpZlB6UmR1ODJq?=
 =?utf-8?B?SUpMVDloN3h4THJpT2VGK2I2cndvRGFZakUvNFVqdUU5TmtkbHNIZk5GOFNH?=
 =?utf-8?B?emkvbXRBVU1JdlRBTG9wUUxncjZOSWFBcHVkYlJIUWliQktFMHU4OTFmakZF?=
 =?utf-8?B?a2dac1lha0pFSTFkYllIdVpWWWphRHdaYlBJOW8vWTBEUUNiTDdxL0lSVTdK?=
 =?utf-8?Q?WUeTyiMdG8WPNrCESes0L5Dh2wWYQAoE5KljA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NG90cHNyL2YvZXhiNzd2L3lmYWpEbUJ2NlIyT1VSZng5V3dPcWQ3OHhBMWZo?=
 =?utf-8?B?dkdaNTZkcUdYRjBrRkpsQ3BDbmdlRjZ4cGlac3JKVHVyRG9KNlY4UHdUQjFY?=
 =?utf-8?B?eW9iekZKTjFtV3d4WTd0T2puWC9GOElHK0pyeWJDK1ZNMG5LekZIamdoMERx?=
 =?utf-8?B?dUNOMEpaNmRSUm1ORjJVYVkweDZ4aEhzZWpneWQ3NnAwdmplSVg4Vjd5VWlz?=
 =?utf-8?B?L0xnZkVyeGdMUzZqMGFKaGZmQjBib1NtMDJXTzltbXBISnJGVjZLT3BQWGNn?=
 =?utf-8?B?MmNKeFgvVFFBNFVsL1VOR1lEbkRaR2RpaHZ1THBrUTZ4SVdoZmUzc0U0aXd3?=
 =?utf-8?B?a0lnMmNWZHAvNWlHTW14RWlFUzhFQ25IRXF0NjRDNkhzV3BkLzRoR1BkM3Rw?=
 =?utf-8?B?U0hUQzlxOFlVNVNXNGZqSm9vOE9FbjdpUDN1Y25JMWlpMXdzS0NsaktPNVVF?=
 =?utf-8?B?eWNvYSs1VUVydVlOcWduTEJRaWxMdkZQYjVpNjFDeWJDRmpNWllCZWtuNThv?=
 =?utf-8?B?dnlDY3lEVGZYWldWM0xLRWpRZkx1VGZwQzhuK3JzcWRCejJJVVdIUFdLYS9I?=
 =?utf-8?B?MTI0ZlZvKzFzTEF0dXdkdVhPYVZrZzUvZlR2VDdDOWVQYThOdy9kUS9RY3JG?=
 =?utf-8?B?U2t0aENFdUdGUGpDQnEza2d1NFU3cnNxM2FaSDh6OXFCQmZHc3RhYjJHRlhz?=
 =?utf-8?B?bHd1SXVvaEdOOVFBQSsrdlVqTFhiMU1LaUxvSkxFM2JyVXNMY1czUjZDRnc5?=
 =?utf-8?B?Rkt6ekxRN0FsQUE0UjB0QmpsdnJVbXE4T242Q3lFUTdTK1BSVFNTTXJGRjNy?=
 =?utf-8?B?ZVBNODdNZk5jU0Nzd2pPV2srYXpXR2E5T1dDazZ4MlB1UHQvVXZEUVVJUGtz?=
 =?utf-8?B?MWxFTlQrTzVOd2NJSUhscC9mMXdpTG1icmc3dE55b2QzeHdFaURvUWFkU2o1?=
 =?utf-8?B?YllFc2VpYjljc1gwSzltdFBPd3QvMDQxMlRWQi9Yc09uVExRSHJYSHQvdVpz?=
 =?utf-8?B?MVBLR1JKMlR5a3lkbXloTzhWeWExY05MMWo5U1FjMGg5dGx4emYzQUhVZ0VH?=
 =?utf-8?B?ZEdQWDQyVFFGUkVzSTZkY0RmSXVxcGdHSWtBUk5SYngvdG1lQ3JWYTI5WWpx?=
 =?utf-8?B?SG0rekdOY2FEaVhvd2gyL3FoV2pTTmRCY2xSY0pvaFdKR29XQVM0aXRPeXRI?=
 =?utf-8?B?bmFFZnYzcnBQVmdkVkJOQjdVeUNTeUhLUm9RRUNYZEVPbGJ2bG9raDZiMjg5?=
 =?utf-8?B?VHpxR1hKUFJJOUJSOXdHWUhLZEJ5VWkxekszdjl1aFZHQk5kbjMxWk1iZ0lJ?=
 =?utf-8?B?Y2ZEazRrdkJremdWeXQwcXM2MExYWVA1WEdtN0ZjaFczenFobk5uQ2l0dzN3?=
 =?utf-8?B?L09VZVpuNHNSY0lhZ01WU1M3SDVkcVZyUlQ4dEJYZXc4Q21UeDgrTGVWc05S?=
 =?utf-8?B?U1RQU0hNbUtBV1RsWnhHd0N2OWpzS3pmUi8zK3pSVDdjcmh5dTRTaTQwL1VZ?=
 =?utf-8?B?enN3VmNveXVITzRYeE9KTy9NVjhwOElmY29MMnB1bHFtV2VNckdEOEFaR0RZ?=
 =?utf-8?B?dHhBZUlWSXJITlhDT0MzMk9ublpvMHNaNkdlOSt5cEtuMmNlUDl6eFdxVEgy?=
 =?utf-8?B?NWc0Y1RqU0dNLzFtQ0JiZ2liTDc1cXhPUDU5cU9oR2RvYTdlNFhDYytjRUlu?=
 =?utf-8?B?Y1luaUpaQlA1NXZsTmRFR0RPRzhwbjF6QmI2N1JqY0RGcUNYdmhYcEkrTWEv?=
 =?utf-8?B?NnJJZDU2R0xVYU81Q29KTXJiRVRHR0VsY1RhLzNxSWpVSEVZbkFoalF6VzFX?=
 =?utf-8?B?aUZzQ3I0dEZwT0xSOUMwcnp2aUlTbGx6NG1PeUs4MzNlOUhSelFWR1dkRjdN?=
 =?utf-8?B?S0gxbjFBamVSVHZPNGIvSFd0ZkNUSkRHd0R0N0NxRi9Cbk5pL21TcGIxTVBl?=
 =?utf-8?B?bXFRcmNqNDZ3aEZZa3RJWm1SeitaRVNzMkhPRThyS0lVR0xLNEdIcmFpblZa?=
 =?utf-8?B?TkIyVVRjelRuY1BLWjNxYkxndGJCaWFxUWdTM3BZbUwrTGlxZ2xWOS94dWV3?=
 =?utf-8?B?QjVkNExzTUw5L3c1VmFkb010VHJzRjVoQmR5MmhwUE8weWR2T2FIMzBxMGxp?=
 =?utf-8?Q?TfR0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae6cafa-6b61-4932-ee2b-08dc898e7d30
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 20:47:05.9131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZR/Ucxrab1NkTl61UjthuUYSxHg1QbwBXyud+QyetBVAN+iiEN/ixG7E7a32FfZfa2Qb+Gp83lsR5VknfPwBkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9376

Enable usb3.0 and related usb type C nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 87 ++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 8ab75cc5b9aff..0f4132f342d89 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -6,6 +6,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/usb/pd.h>
 #include "imx8qm.dtsi"
 
 / {
@@ -109,6 +110,21 @@ lvds_backlight1: backlight-lvds1 {
 		default-brightness-level = <80>;
 	};
 
+	mux-controller {
+		compatible = "nxp,cbdtu02043", "gpio-sbu-mux";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec_mux>;
+		select-gpios = <&lsio_gpio4 6 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
+		orientation-switch;
+
+		port {
+			usb3_data_ss: endpoint {
+				remote-endpoint = <&typec_con_ss>;
+			};
+		};
+	};
+
 	reg_usdhc2_vmmc: usdhc2-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "SD1_SPWR";
@@ -321,6 +337,44 @@ gyrometer@69 {
 		compatible = "st,l3g4200d-gyro";
 		reg = <0x69>;
 	};
+
+	ptn5110: tcpc@51 {
+		compatible = "nxp,ptn5110", "tcpci";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec>;
+		reg = <0x51>;
+		interrupt-parent = <&lsio_gpio4>;
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+		status = "okay";
+
+		usb_con1: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "source";
+			data-role = "dual";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec_dr_sw: endpoint {
+						remote-endpoint = <&usb3_drd_sw>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					typec_con_ss: endpoint {
+						remote-endpoint = <&usb3_data_ss>;
+					};
+				};
+			};
+		};
+	};
 };
 
 &i2c1 {
@@ -525,6 +579,26 @@ &usdhc2 {
 	status = "okay";
 };
 
+&usb3_phy {
+	status = "okay";
+};
+
+&usbotg3 {
+	status = "okay";
+};
+
+&usbotg3_cdns3 {
+	dr_mode = "otg";
+	usb-role-switch;
+	status = "okay";
+
+	port {
+		usb3_drd_sw: endpoint {
+			remote-endpoint = <&typec_dr_sw>;
+		};
+	};
+};
+
 &sai0 {
 	#sound-dai-cells = <0>;
 	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
@@ -791,6 +865,19 @@ IMX8QM_SAI1_TXC_AUD_SAI1_TXC				0x06000040
 		>;
 	};
 
+	pinctrl_typec: typecgrp {
+		fsl,pins = <
+			IMX8QM_QSPI1A_DATA0_LSIO_GPIO4_IO26		0x00000021
+		>;
+	};
+
+	pinctrl_typec_mux: typecmuxgrp {
+		fsl,pins = <
+			IMX8QM_QSPI1A_SS0_B_LSIO_GPIO4_IO19		0x60
+			IMX8QM_USB_SS3_TC3_LSIO_GPIO4_IO06		0x60
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			IMX8QM_EMMC0_CLK_CONN_EMMC0_CLK				0x06000041

-- 
2.34.1


