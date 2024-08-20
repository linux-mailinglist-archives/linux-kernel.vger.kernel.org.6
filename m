Return-Path: <linux-kernel+bounces-294166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEE3958A33
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3271C1C217B5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16805191F9A;
	Tue, 20 Aug 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LcFG0wCu"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327191917DD;
	Tue, 20 Aug 2024 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165636; cv=fail; b=ihzBqvBk+3w/p7DLqoweWhRSLui/rVXAtkcN2TsQkejwqxVgsZd1JpdbB8o+gVRB8jGaSe+g6Zi+wefW8r24zBUq5xj5JZ5hWDKDha/MZOOFvIHr7ul9sX3pfq1bwY/ZJS4XyLlW5hnQFOkYzVzBfSbqa3Vo1S9aimlyITUz5Vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165636; c=relaxed/simple;
	bh=fvDT1b0Ra2geiJXvOPvs6caqgQsKmxu75ZOk3vLw7vA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Pbmh6mKwIE6uvHh1IcDaqKrGIlmfXeIc4NK8Qi4TFaMguC8XLJfluLh5OUOvupffCpXrIeSSgbbYdrcbNd/bNvgM8YMdpBhfSoN5PI0Wxmh+b9UAQvOlg9uuf4X2sB91H0MK1tqbN7xUNhkh26zVkrJ7aykK8huFE6vkBBtlqL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LcFG0wCu; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+zihVt2b7Xyqn3G5BhAcjedaji5BMBFfr76qoAenXDsl4iyTKCsWXty2P0tMCI9Me6BR3phu6HC8+Jw/VUtG/RaZEtIpAdjOX+wkD6OarxwZv05u+LrwVRVaqF25xe+Cp9r/QpkVOC9PxXVhW1rzWsp39ck/Zpubb2pnM0CUY6LmV3eVwG+mwKubG7l8YgZUUzkX4I1LbE34p76iFrFBlsLd+o5enVpELYlwjGirIUrUbmEgSVuMRkRap4TwBQLiRgQO6qCmnTBKWmndvbHkXTioKBhsE7j/I3IACZKluywFNGRFubKm7yKCGbGAE/yqPFp/gMakMIRj7YVEHgp+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CFE/1KQncWtb3pucebggRspm/HmuSAE82Ba3sWNuuM=;
 b=mAtLBYPWW8/hkZs/pEBdkebpKujTuOrnG02PmNKVfWmoBZZTwCvHT6CfB9+iJWhfSiNO9bv2WIuhg/W49cd+sS/1RuDpBW8GLkSeQKGYehny6lop+/5Pvckf12ayxNN3b1k9HAzZes0OCOzrDF0qXZniTmCgfBXWjxRPIl5tdc8Ca8R0q4W2iOUGThic9S/CAkYKLo/MspDNmXtRBetiB555muuGintcV+231hqhMF3uEzA4/MXA1rqT36tQtrX+tr0aCJZNTYjqBdjW9nTgxxmqfEUVF8TvGwWmaL4tXvzzZfIaMmn/k0knwEw9jNjqaP+mmmyw5Kff7cA2WCN/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CFE/1KQncWtb3pucebggRspm/HmuSAE82Ba3sWNuuM=;
 b=LcFG0wCu9HqHPjr7VjqN+sdIdrOKUm3fpifYaqDqNIvuXGbrgZt7ucYipF/dQnmx7fenRJEkwykIVmE6zIvEFFnm0jIV0jIwNeH6v27LX7tFc71ls7dy69fMb5IkS1QO0bA4oIjQmsrvgLaWyaHZtRKhnKqpARaTEISeVwS2OkfnbZ4mkBgZ+WKnkabJLYs2dnQW3uADWslIu+odfwdqJ+PjVeAyfmCVPn+9SQ2Hcp0EO9e+5nhdSvozv58WBK5o4PO2I0HSaz6KT/7mrmANUxuWSMyfW2YSBKdvSnLdbNznjrY3NOgwO7lVChzikykLoHzW1vHWjscQZgG4To0yxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9415.eurprd04.prod.outlook.com (2603:10a6:102:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 14:53:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 14:53:51 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 20 Aug 2024 23:02:39 +0800
Subject: [PATCH 1/3] arm64: dts: freescale: imx93-11x11-evk: enable
 fsl,ext-reset-output for wdog3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-imx93-wdog-v1-1-5dafda0d4319@nxp.com>
References: <20240820-imx93-wdog-v1-0-5dafda0d4319@nxp.com>
In-Reply-To: <20240820-imx93-wdog-v1-0-5dafda0d4319@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724166168; l=640;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=xYtywckId/LXgdEKCtYS4RLTfdEf3sxvQ5ZOAN86XMw=;
 b=k65GE8JsRtMGpF79o6ahsKrLNaNG+RwzifiqJJevmqpYnHKIxSUSS8WPOQRlftJSC8i3c0Msx
 TzisaCxOwF/CdhOzTsJZg8aEMBIVst/Rzf2ZR/O/DLtVLf5fYc93VZy
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb7277b-a844-4339-29cf-08dcc127e78c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzArRDhVNmpUSEdYeWkyb3lpWVlvREZWU25yWnR3MFFUUzlXSXErWnZ2R3Mz?=
 =?utf-8?B?NS8raHpoTHNsMFM2dzJnZ3ZFY1NmZ3J6SFJnVWtvOVBmOXRSMkJjSC9BS0Uw?=
 =?utf-8?B?RXJhQzJxeTUrek4zMVRRa0Z0MDh0SGdqYUh6eGNUTFZnMG1qMlFPZGxVbXZ0?=
 =?utf-8?B?ZFZDSjh5Q2pPU2hCOTRmcEsyZUdUa05HazZsRmV1ZjJkTjNBSU1JdVBuRk5C?=
 =?utf-8?B?Qi9PbUxFUjVXWndNcjI3SWRuV3psSXdPT2hQNUNqN2ZDdDVlWUlsL3M0a21t?=
 =?utf-8?B?ZmgyOEZ4MTVyeHNvTmtDTGVZMkQ0bUhLUWdOeExKZWFIdFM2djNlWmJPMHkv?=
 =?utf-8?B?L2hUeFFsM1U3NFJieDg0dkkva0tXdTVVSWkyV1oxbXNnTkpPdHg5Q3hrd2Jp?=
 =?utf-8?B?RjBlS3hEREtWUk5WeEVmWTlHR3dkK2FkUm15OFBFbHVoRDkzVWQ0eWNhMkFy?=
 =?utf-8?B?TzZueHczNHIzUWNhSGRrV0NXWFBzdHV6Z1JWRGdEdllDRmY2YUxUTVE3eDlO?=
 =?utf-8?B?ckRlcGIxS3htL1ZPellKRktZelJsRmR2ZTZITW12YkduTnQxVGZzLzNNK3dM?=
 =?utf-8?B?dGd1NC9SeENueU9mMllOQXZIVkZYdjArcktrNkhYMDJlV2RkV0lTOFBuT3Vv?=
 =?utf-8?B?M3dnRS94ZCt4dDBCNUdOUkpDTWFaQzNnbDdmVjRYem05WTBFQVViMW5vaUV1?=
 =?utf-8?B?bWNjSXZrUitJa0tBc3JIbFkyZUZGcDlDR2VneldVd3RDTVNCSDdyS25FbG1I?=
 =?utf-8?B?Tk5mblRNTzRVMTB3NHNhSU41aW9mSnV2ODZoM0RpUFNuWHhiZTZxeFlLMG02?=
 =?utf-8?B?aWQ0THJxSGlFSzdYRzRvMSs2akd4YzBqUWF5b2VDeDZJOGZWeXFVVlNXVGhI?=
 =?utf-8?B?Zmh5QXl1ZEwxelhvT3BJQWhYanJ3SVFWOG9jcHdUd2VuZENQOWtGZ1o2YkZl?=
 =?utf-8?B?OVJVRXM0RU1OVVRoS0xjN1Z6MDFNZ2hUMFZjMzVtSUZPRExUQXFPeVkzcUNL?=
 =?utf-8?B?ZlY0Q1M4TkxlMkY2bHJmK0lQM0huOWhadk5wNzBuWEJwWDhsa0tmdnlGUUhk?=
 =?utf-8?B?enUvdVFMdW4vd3NscUoyejVBS2Vid014UTJTNEJiUWRsekJtMS83YUlHRUhy?=
 =?utf-8?B?Mk1WVG5GdHlLSEg1eWtlRUFnakdSZGV4aGNMQVBFYmRseGdiWEljTVVOS0Zp?=
 =?utf-8?B?TmZleWFEMVNQeVhVaEZjazVoaVhNUmU3b1ZEOUNqRWIwalRSbjh4RDBYZlJw?=
 =?utf-8?B?MFRvbW5RcFpmbXp3UU4xY0N0SHdzN1FzaHltSDFQS1lhbWo0cDBEZy9UOVdi?=
 =?utf-8?B?L2M5eXpGZUhPUjNPNzQyZlp4aW5PblRFZWRITnFzZHUrcThaOGJDdmI4dGlK?=
 =?utf-8?B?NDNmdnA4b20rODFtVnRUN2tTRWczMlRIcFZmQkxCODY5b1FTWWkvQXVyUHhT?=
 =?utf-8?B?TXcwOW9mSVRibG4xNWR6TGVYNEh5SEVaZWxyYTBaWWE3eit4RXBXZWZaWFlE?=
 =?utf-8?B?Y3JCbFFRd1RrRVBxVzJzQ2NvdWRSQzhvYTJ6dmNYQ0hCekQxemFBL1NOdjEy?=
 =?utf-8?B?QkZnZFFhMGhxN0EzTFpOY2Rzd2g2MkZpTVBhMStvVWszaHZWeFNVOEFWQmRW?=
 =?utf-8?B?VW45QTVjQjJQK2Rienh4LzJzZ2xBNXI5emFsRWdtWGJNbk1ab2UycXl2WnVD?=
 =?utf-8?B?YmJtZGFOYnpuaHcreGRMZHExa1FSS2k0UHRMbjJoYnQwVDhSZDhzdkk2WEVs?=
 =?utf-8?B?RjZ6VW9ITVFQa0dsb0djemx4V0RQR1N4Q3RsdEw4elBjcnJjRnNrWFVYSi8y?=
 =?utf-8?B?K2VxMGVoMzlBQ1dNR0JleVduNUNIOTZoQ3QzWVF6Z3ZkM0lDS1dFVjNYR0x6?=
 =?utf-8?B?cXdTTlgrM1AwdkVoR0VPL1JRc1hYbFhZZmpCeVpxRzAycFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUtraDRKQllreURUQ29NandEbFJFTlc5azNRcWZWNXppTzFYTkNjWlJhL1VZ?=
 =?utf-8?B?cDRVS1dGbHhubGpDTkV5NWREWXBZdHdoUzBwZGhIOEV6aXVRSk9pVTJ2ZFVF?=
 =?utf-8?B?RlA1S3d4OHpsRTR5MzBhbERNeVRvbFRWZG9BVHgvbmhJc0NvbExlNjM3aVNY?=
 =?utf-8?B?S09zZVZHUW40WnhYQ3lidFRJNi95Z0pNeENjWXdISEJsNWpic0JCOWNPM2Nt?=
 =?utf-8?B?TWJzRkxwZWdURm5neXJURVU4WGRzMmJZdnhvZzJwZkRpcURqVlgrcThjYzdj?=
 =?utf-8?B?bU9UUEZ2aDc5MjBmZmJjYXVscFFzWlJjSDF3eG9HL3U1OUMwdnMxK3l5d0F4?=
 =?utf-8?B?MWNITi9uM05TRHFCeE03QmpOQXhQblJZcGdqcVVqV1M2RWcrNDAyK3R3UTRz?=
 =?utf-8?B?V2haaDlKMnJrbldNbXRyQ0IrbUVwMzhTM25lUDhNTTVqRW5nYzhRcFRhQkFD?=
 =?utf-8?B?OU5ldnRNZFU1emY3dEhHdWFzWmtzSVVuUFFkVHpxRlZFZW1xWFJPTEo5NG5m?=
 =?utf-8?B?Z1krcU9nNTZrakVQNjJyZ0RUdEJyQ2VxWk5hNXVtN2pUMDBuQVRmVmlLdHJI?=
 =?utf-8?B?VG9IZlZySGNrNTJBd1RPcTY2MU9Cb2pLdTV3Y1pxRW9MaGVzZEIvYlNJbWRG?=
 =?utf-8?B?M0V4SFczNHVyVGtTL1h0QmZnOUJRdWZmUzlKeGpCWW0yWnI1VTJzTzNwRDBT?=
 =?utf-8?B?c2pIV08rdlM4VldET3dEN2NwWGFGQjZGbXJzVDRWYlArRlVEQXhQNlp0NE0y?=
 =?utf-8?B?MmgvY01CTlZvV3VEaHpIWitIUGo3ejhaRVlkRDcvRkhPdG9PaUl3RHFQVWFE?=
 =?utf-8?B?RVlYOU9JSXU1S3N5ejAxZkdSQ0duaVBzWmdIN042Wi9xeDNiRll1Um5jOHR6?=
 =?utf-8?B?RXRPUVRrZTFFV2Zjc2JXV1I1RjRYMXc4YjNOQVJGdUlaVzc0aEVndDB6dU1a?=
 =?utf-8?B?d3ptSm9FWW5hSE5MSXlTNy9JR0s5dFd0WU56eXVHYUVFdjJDSjR6MjNuMGQ2?=
 =?utf-8?B?Y0tHTE9KMUpyaHBaTjJ2b2N1TXNUUi9VdUV6UnRGekRkQ2lyZzl4cnBWM1JK?=
 =?utf-8?B?Szc2UFhKR0R5OGo5bGhkM2NjRFRhekFORDNDRmJRTHJtU2xJeEw2dDdMQUFV?=
 =?utf-8?B?MnJoSGx0cW5qQ2V5SUJZVFczZHMyZnltNjFBQXpPQ0E5RFVnQVpnZVRXb09G?=
 =?utf-8?B?aHhjaTFMOWkxb0tVZko1NmdhVGI5Zi9QVGREb0ZWNUlEV2pBeUJCYncrekh3?=
 =?utf-8?B?cmV6aHRqNVNTcnBmemVXeG1jUy9NR3pXVCtrTFJYWWlXdVdiYytkNHR6MHFL?=
 =?utf-8?B?NlRDcUdxWXZ3TGJzWVJXZ1YxbHdSWGR5bytQbkpVLzBxbStNR1FDVGkra0NZ?=
 =?utf-8?B?bXRzdGdGL0Z3L3NLNTkyMFdSdEt0NTFROTdLS1gzN29yM1hralNvY0k5SmhQ?=
 =?utf-8?B?K1JiWHYzVzRyOWU3cE0wcEg0WEZqN1JxNjJoeEVXaTNjN1RjTmpoV3Voc0pK?=
 =?utf-8?B?bTJvU1dZV3ZmRmh2a3JBNmZyMER3aVZZbXFWdkZJaUtsSWpOWUtCVjhCYlkz?=
 =?utf-8?B?dUkyUEpseW5FcGU0WWpNbEdFS3cyUUFYa3MyUllCb3VWbU91eE1hN214enRR?=
 =?utf-8?B?QUxLMkZyT3A2ZWorNVMwbklkRlNkVVpxZVBKaUJCWU5IbTRTL3RRNVc4WCtV?=
 =?utf-8?B?UGxzeERZRkJ3UUIxQ0IrMHNaSUpHOStoNE5HYUh4QkRVaDlFc2ZTZUkyUXY0?=
 =?utf-8?B?aHNydzNVeUZyVXdZZXhpLzdWb2c1ejIrTWNJSnFrWDR0dzErTG9veDlvYTh1?=
 =?utf-8?B?dUpiZGlYSlpwRjBNK3F3bnlsd29FRWpCN0M2QlNrZjZLTzNyV05KbWp0Vytv?=
 =?utf-8?B?OHl6RVU1QUJGSFlnK2FSeExvRDVFWmdsdkpsamt1eWFvbXc2bk0rWWpLS1pn?=
 =?utf-8?B?M3ZpaDZRVWtOb2RtZ2RKQ2M4ZWNtM1JNTXp2N2ZHbmJlQ24rUTlHdXJSaDAr?=
 =?utf-8?B?bktKRmtMT0VtTDd1Nmh2Y0xXbHNPdUNmSEpjVWJ3VHZTa2FJaG9QbUZFQjI5?=
 =?utf-8?B?VG1vUEJ5NmErR0twQzMrbTVRR0FGSUZibHovMEFoa3JMcEw2aUlNcy9zbWpz?=
 =?utf-8?Q?vw/yKyFsBiAUfagdJ2zqaNbvT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb7277b-a844-4339-29cf-08dcc127e78c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 14:53:51.3389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3s+WiEom1FhQmZU7UMiXTgbFqjdk2NjFQU53EQrA1go2SmEXg/7QaLjDHi+L7tozz8qFT4HgfLawyR3QNIB6zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9415

From: Peng Fan <peng.fan@nxp.com>

The WDOG_B is connected to external PMIC, so set "fsl,ext-reset-output"
to enable triggering PMIC reset.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 60eb64761392..fb93ae654a2b 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -485,6 +485,7 @@ &usdhc2 {
 };
 
 &wdog3 {
+	fsl,ext-reset-output;
 	status = "okay";
 };
 

-- 
2.37.1


