Return-Path: <linux-kernel+bounces-311042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4F496843E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4341F23986
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB96186E20;
	Mon,  2 Sep 2024 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EfOXM/vU"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6757618592D;
	Mon,  2 Sep 2024 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271858; cv=fail; b=Aavo4kIaGXk5sjfMxe0FEcvlDu+SELyh1LIUwebOUIkIB7xcntdGzjMOgd7Hjvn78EEr1cwCyQH/LsVOvE7nafK7AwjDpLCSBvdb7hDZYKiTmDWa7gTQI3pRU8meHX/QLmbKdYnZbkV01tRBNuC1NCqhHH6fmTsIl0Ixqr7OBpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271858; c=relaxed/simple;
	bh=iv+Xnp6szQwP0LlAEm9s69JzGawGSXHr8OrgUbO7BrA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CsYEMV0EQlcytQ3AvrQ6pAYPFClN+akRwIxy5jJfQhCKGCzfk4GoTREK4lUUDauZmLiNcthPw64p/b9SvbzhAtc2L8I5AvuoQeQluh6r6TCL2RRYVegbHEOOQTo4IAio1znCBLjeb21ASBf7d0r5PhsOenrV+tVybXW1el2axOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EfOXM/vU; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYfUF1V/h/jEJGOLWJdemElj4OHvK004KiGZ4CH3q/oyZVR0pH0HXpDwRdC3dkSlsRrX7Hz+kHyDOeSer7H3RwTEnnZyqG5PaqEpyoSbNEuNetnD30LAIN/IVqOCkL/M3pzCuHOe3GH+oqG6j8Nn5WBUN7ZYo1UxtOCHDCjNlOzyYzZn+yrlSGbVEazx5B5FNH9OPJ7lPyLCNW3fGvLCCjlo1O9LbHg7dCwZvKD3DkRsPGWPHY7pXdIJYZD0EXDNtxInbXsT6QWapDJ91jv/TX4TnKaa9O3reVx1qzFIjSlZJAnERGKpLTOhf9l1TDp1HwssM6n0UKOuWSfXrgy3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fzeVCk2IEOiCOL05rfNNFErdeSeG1XWUkm4nAespeY=;
 b=Clgg/Jkbm0FTdjjN21Dzu4deRvHX/kUBST7nWA3U7w7q2BbX39jRGhQE3ZB/q/kl9BVVIxFmelm5lqF8DpHzUZXytZ5cO8Ue40tYC5UtXHNxwCJusznV6kFmuIDcHufOZV9av0T8NlqxZPi/IiXPBpAqPMEsBPAmsrDcS9Kmf/cyjPIDBrh1eYJbwWA2mWRW9m1JT4NkwmZqP44F6wV8gJ6dniFFGwMejQ6OYSYGH8amyXUkFq4c0zC+YIv4hk6mlb3iHgzCt7Fhl+Yhwmvuz4XzwDdDKVyn96ksukj+P8upA6nvm1BQV+mZHjHGPdYN0EMNWeqUr1fWE4o/Ugp2vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fzeVCk2IEOiCOL05rfNNFErdeSeG1XWUkm4nAespeY=;
 b=EfOXM/vUvHIbDhw/Sll1TtbWzyQepSohXx8UHhIhJB0lL2xu3CZ4g0IonDs6jndq8rFUTiPTFkvuERcs0wuEi6m/krplp743GBf9N4cNHEm0nTs64/zLNieQISgo7MVxY+DFKwXxhuMUwLyxmIKHzhtVAHz3sEjWmz+ZAo5ahFstu5EQKItwST6x6rqaWDcoBgwOcK9r4DU84OStuovvbAvxddiBPICDP6LHvYry5SdkxYZSkbYf+SMOJEitEA7G4mljWtmvSorduvQ+ca8IID5aD3O4iIufjEbjbCSKA2n9v5cdvMHa4DshZI10EVwlBZ4AI472jdwoFH2azlDPVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10099.eurprd04.prod.outlook.com (2603:10a6:102:45d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 10:10:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 10:10:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 02 Sep 2024 18:19:27 +0800
Subject: [PATCH 5/7] arm64: dts: freescale: imx95: enable A55 cpuidle
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-imx95-dts-new-v1-5-a1f798f4f746@nxp.com>
References: <20240902-imx95-dts-new-v1-0-a1f798f4f746@nxp.com>
In-Reply-To: <20240902-imx95-dts-new-v1-0-a1f798f4f746@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725272373; l=2478;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=rzWCgPVY+Scu1I6HkQDGLw1kH0NbKbPzqEDgDkYWCVU=;
 b=CqlTjMOavZZKr1WWw5yOm1OFCUlM6HTclDg+j9RWEq/CZpgImi6U3oZ/BootyKdp08jfFRths
 fbJbp4VnvlrDE69t290O/NXrVwF6E5iOIxvG3hpBawZIA03dc0a9oAL
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10099:EE_
X-MS-Office365-Filtering-Correlation-Id: 528025c6-903d-4092-d17d-08dccb37876c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXFEV0pmaDZoYzN2QnJvR0g5dlc1NEFqNXpqVHplS28yL2xIbnkrcFZNZGdU?=
 =?utf-8?B?VGNUQVVsR0VGWkxJRStQcjY0ZkF5bzdvRzBwUDJjdE1kOUkrb2k2S2R2dVF6?=
 =?utf-8?B?b0xMUzhPQWlPY1d5NjJjTnRNRFlrazZ3cmNsTE43eXhIN1lFcERtWGhaS1k5?=
 =?utf-8?B?aWhIcXJmZ2NmMkhMZzk1THQ2eFNOUm1pM0ZCYy9zRWR3b2dLL09DVVJmbVBL?=
 =?utf-8?B?SnZ1bVZQdjdGREU1bHlMZjF4V2hLcldyVHM1bmYwaG5vbndva1NjaVpvSjd4?=
 =?utf-8?B?dmQvWlArekZLNjVDejVMSDNzdWZ0MjZZeFRtMFQvVTdDS2ZIZE0zd1pRU1VD?=
 =?utf-8?B?VmxaZE9pc0U2YmxndTdZQTd4SVpIRldnei8rSmxLdmRZRS9YWFBaNktma2FH?=
 =?utf-8?B?Y3JpaTdyR2hzRzYvQys0MjYrcmtybUZtWFFBeERiSG9CQ1k5ZWRtYjdKM0JL?=
 =?utf-8?B?TGpNM3I1a09rZ0xXZ1dWeFdFOWQ5eUJ2Ylg0a3c3bkQwczZCMVlmQ24yd1FX?=
 =?utf-8?B?ZzRFa05lK1pQaS9hZEJqcGVHa3U2K3BsNUlqM1IrTGNFazUxWFVUcFYwcVlS?=
 =?utf-8?B?ZUpnQ0RYcmZ4NWtqZTU0L21FMElVcGlXdkw1NzR3UnFrUUVuVjM3cllIdHlk?=
 =?utf-8?B?TWp3cHRQdUZjSHQzZG51Q1lYdzFPOCtESllRQ1UvYTlZVndyUHd4S3FXSGI5?=
 =?utf-8?B?cWpyNWFSL0doQWZ0N3pnMG0yaEw4WFcrbmRRL3o4WldlTW16NFExUDBOMmRX?=
 =?utf-8?B?bGtRVkpId2w4cHUxMDRLeFhZa09sajdYNmRWM3N0L3JXWEVGNENLM3pVUFl1?=
 =?utf-8?B?WlRyMzdrT1M4REFUZUV4aXZXaHliN3F3OUovWEY2bS9QZnR2SWVwWXJxK2pW?=
 =?utf-8?B?RE52VzB6RUxxOTdMNk5hKzYrYWtSRkd0c3cvY21IZnpBa0VBMUI5Wnpxc21w?=
 =?utf-8?B?cUF2UEJjU1VOTGQ0a2loVVpoazViaFN3VkdTT3pMcmgwbVU2eE5SWTRyTGRB?=
 =?utf-8?B?V2RuNk1iV0k0YlVKZTFpY1lyekdsSmdwTzR3Q2ZUVnAzdno1R1dJMXNhcGsr?=
 =?utf-8?B?OVVlb1FKNUsyazhYVHUzMnZYbWs1TVE5bEZhYUdacDl0ZHE0MytuVDdXTWxI?=
 =?utf-8?B?Y3hMK0ZwRHAwb0lzSjRJUS9GVFlNUU5YOXJsbTZBYU80T09yTjZMRnpCVGs5?=
 =?utf-8?B?c0Q4L3NISXZlTC90NzhXRlpLUDFhUEtkWVBZWFc5VGIzK0pNUEFlY0diQ2E3?=
 =?utf-8?B?bktXNkFKK2orMzVESFM3by9YZVl0YkNxSUU3Tkd4a21ZY2ZTUDVYV3ZLcWJk?=
 =?utf-8?B?bW5sYThtOFZLNUg0M2pxSDRodk1ITFdBcUd2dHFEeU84UVFVbjlIa2g3WVBu?=
 =?utf-8?B?d3ArV0xiRDJBNTZEVXpWNU4zWHdmOEdIUlRwVHcrb1ZYdW9NN1NHY2EvWTBW?=
 =?utf-8?B?cHZaa3lBcWl3TG9GeWJOZ3RDRkozZVo0dWVsM29LL1gxaWN0TWtlUytBLzhv?=
 =?utf-8?B?eUFGWWpsUVF5Y2xKUUp5aWtMa1JOOWQyOEsxcmNSZEVzMU0wTmMvRHRDaExk?=
 =?utf-8?B?MnZDalJjSUdvK3orTUU4R0pvR2E4NTVFMFJzL2pBOE5qVjNXeDV3bG9WMmNl?=
 =?utf-8?B?WkhScFFCc3NkOW1oNnAzVEg5d0QvdTdwd2svM3hDS0VtT3RUNVFMOUtiTlNJ?=
 =?utf-8?B?SUtyYTg5SGI2L2xST3NQWnBjZ0FaS3R1dDhEaWpEWVFPbG1zOWszenozaWE1?=
 =?utf-8?B?d0Uzc3ZCRXE3RmJub2QrNFNqR2pZbG5YWFFQZHY3QVJYdmJkcjcxS010Q2ZS?=
 =?utf-8?B?SXV2N3JKbC94WTBpaUVZRmdNQy9SRmszQmJnRVNVOUF5b2dPZXA4OUM4NTQy?=
 =?utf-8?B?TnpRcjFQNnRYVXJEYjFHanplZTRWZGQ4NllTR2dtTzhqUUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkRSVk1HaUl4ZHNnaEFUd0tQeDdkU0Y4azFUbklka0s2MEtBTk15aXRZWG5u?=
 =?utf-8?B?QmhaYWRpU002MVJnMFRYUkJNeEEzZjlyMFI1a2dyZWpualN6TnY1dHBkMTky?=
 =?utf-8?B?SC8yZU5SQnIzYXYreGlPV3FqaUpjSGlDbjF3Yi9LUTNNb3M5dUFrSEd5ZU4y?=
 =?utf-8?B?b0g1UE5mYTc2OE14UFd2RjllZEpobUxsN1dDa3JBVlE2d2hpTU5oWkJvc0hC?=
 =?utf-8?B?VVZteTZHcGlKdy8vKzFsYVlBRTk2YzJvK1o4c09mRWZmSXAyQWlCY1Z1MnZX?=
 =?utf-8?B?a3NjZ2pSZTZwZnA5QTJQaGZGVWM0ZTkwMjRQcWVFYWYzNkcwVXJLWFdRUjRr?=
 =?utf-8?B?YzYxWXZQUDZNdko2bFFFb3JyU0JzbUtFYVgxRnd2Y3pXb0phZmZHN3RRWXo0?=
 =?utf-8?B?Tmt2YTlhMmNBeWR5ejI3NitrcnU1bVJFc1JkSUpkT2ZwcUYxUTVCLzRUTVRn?=
 =?utf-8?B?VFlmVVNHQ0EyM3ZCSGlnR1E3aFlrTk9JZG1QcHVGZmVNTWFvc3N6K0kzNEVH?=
 =?utf-8?B?eDJXb0VzaENueXhyZGFKc2JNNVNUQWt1dHJMdTZYWVhzUHM5QnFUSFQxVS82?=
 =?utf-8?B?a09qWEdBNmpVMEZENHlZOWxSclJIblJTNndVTVdUQUNnRHlHTnZXd1JGVlhz?=
 =?utf-8?B?TUtNY1hKek5WMUVLaHpVMVNMVHFUVHQ1OEw5UjJ0elhrUzlXdzBHZm5jYXNY?=
 =?utf-8?B?U0Zwa0F1aEM4NzZBUCtiTU5JMURZaVExdTBsWkFyWndFZG9HdDdyeWdES0xK?=
 =?utf-8?B?TkdGWC9haSswM1RYOEJlM3hHV3hRWnFFN1JoYTVtNHh0UEFZQWZGR2tvaDFn?=
 =?utf-8?B?cktVS0RGSjB2WnFkdU1PeUlwNmRSUzVmdTZGZ2NQb0hCRDVjSDR1N1dXei9i?=
 =?utf-8?B?QmdDdkVlMmNMY2trNE8xYmorNGdXaFBnYWxPUnlpRmg2UFRxTmtJRVpxaElQ?=
 =?utf-8?B?cXQreXE1TmVqbU4xSi9wbFVUNFhVL3dvcURJUk1Cdzg1SUttN3NPN05DSjhF?=
 =?utf-8?B?NjYyT2FSNXJRbW56OGRObHRGVTF1NUMydEEvaXlqRzg4NGxoZDMxME9yL293?=
 =?utf-8?B?V1VmVHZuNnJUQ1N2Y0pxR01MZWF3K1VpRWZUdk9pV2hwUDVzWjJXRXFsYk5T?=
 =?utf-8?B?STUyVXNTTUJGUCtUWThlUGFKWW9kT0pSSFY0ZnlkcHpjVnFEdnVHQzM5UkVp?=
 =?utf-8?B?QjBDM2NiTVlXbUhWemZITmYrbElvTmZkMDNXSWZYcGxDa3YzTGdXWUUxZmY3?=
 =?utf-8?B?V1IzNHVjSytJV3NBOEpLeU94VHZtQ1l0VlAzZW1sdFFOY1lqVXIxYWlGakx6?=
 =?utf-8?B?Ky82SlRFdEhXREEwV3BxNlk4TTdTQ1FFTldiS0hGeWtCVWhNUlVpYlNDUGZ5?=
 =?utf-8?B?anM0MXpkb1ZQV010NTFMQ1FpbmNhRml0MnUzakdGM2pNdHN6Q3RYNFMzRU5u?=
 =?utf-8?B?OVg5T0d2d3FkVXBGQkVJeHpCVENkRHFMWDNQSEFmejM1OGErTElpVW80Y0xh?=
 =?utf-8?B?M2pzWDBWWmZFMmlveSsyblhIQ2dlRkFjd2Z2RFU0WkpWaHppLytFZEo0NVRC?=
 =?utf-8?B?QXF3RHhLWkg5S3ZjclNuajRtOURTa1RzZGtWZkQ4MG9RWHZiYVFEL0JXVHdt?=
 =?utf-8?B?cStLV1poS1RUaGpnZ1ZQK1dpZFhBRU1NTlNGVy9jaWNZTlFYcmpHd2JhSkZK?=
 =?utf-8?B?eUN3QnR5NktCdHF3TzF2RE13Qzdka0R5dXV3cXN0ZVZNbThkZUtOUjZnZ2JT?=
 =?utf-8?B?STJXamROSFQ3cXZ2MW0ySTRDVnJIQVlJZVIyRi9YM3U1c1NtdFFyNHVyVmE0?=
 =?utf-8?B?MHZxNTNzaDdxdzZmMFJyajM1YUcrOUJxMzJVZGwwcUlCSUc4OTNwaDNET2ph?=
 =?utf-8?B?N0VFNDhPdkxtK2hINmtDNHo5aE9yZmZsZHEzOVA5ZGdiTTlVSHRTTUdQRGZF?=
 =?utf-8?B?RE5iQnUwWkhTaDVOWlltUUY0WjNPVkR2OS9CT2VsU0VDRnZxRURjb2tteWdk?=
 =?utf-8?B?MXN2Y0J4MnU2MkRzdVdUZTE1cWNMQnFPblRWUkJ1NVJ2MkxtOTE1eDh1dVZD?=
 =?utf-8?B?WUtKbDFYbWZNaEFld3lUR2gyZ2hPQ3hCT0JFZjZZbHZYS2xBZTl0UHQzNisr?=
 =?utf-8?Q?uvGsmBnxa6XeUf8w2CVChCZ1l?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 528025c6-903d-4092-d17d-08dccb37876c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:10:53.6557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmNL4Y3aVdA+HQM/DPL5f6tj8r6OzVyZ3dCMgAhFtvvUgedrmzEwdOMKTN2hzGD1oN2E3jSFV4P4ATferGzHyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10099

From: Peng Fan <peng.fan@nxp.com>

Add cpuidle node and enable cpuidle for A55.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index d031b9548aaf..a7e411f1daa6 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -22,12 +22,27 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		idle-states {
+			entry-method = "psci";
+
+			cpu_pd_wait: cpu-pd-wait {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0010033>;
+				local-timer-stop;
+				entry-latency-us = <10000>;
+				exit-latency-us = <7000>;
+				min-residency-us = <27000>;
+				wakeup-latency-us = <15000>;
+			};
+		};
+
 		A55_0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 			power-domains = <&scmi_perf IMX95_PERF_A55>;
 			power-domain-names = "perf";
 			i-cache-size = <32768>;
@@ -45,6 +60,7 @@ A55_1: cpu@100 {
 			reg = <0x100>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 			power-domains = <&scmi_perf IMX95_PERF_A55>;
 			power-domain-names = "perf";
 			i-cache-size = <32768>;
@@ -62,6 +78,7 @@ A55_2: cpu@200 {
 			reg = <0x200>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 			power-domains = <&scmi_perf IMX95_PERF_A55>;
 			power-domain-names = "perf";
 			i-cache-size = <32768>;
@@ -79,6 +96,7 @@ A55_3: cpu@300 {
 			reg = <0x300>;
 			enable-method = "psci";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 			power-domains = <&scmi_perf IMX95_PERF_A55>;
 			power-domain-names = "perf";
 			i-cache-size = <32768>;
@@ -98,6 +116,7 @@ A55_4: cpu@400 {
 			power-domain-names = "perf";
 			enable-method = "psci";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;
@@ -115,6 +134,7 @@ A55_5: cpu@500 {
 			power-domain-names = "perf";
 			enable-method = "psci";
 			#cooling-cells = <2>;
+			cpu-idle-states = <&cpu_pd_wait>;
 			i-cache-size = <32768>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;

-- 
2.37.1


