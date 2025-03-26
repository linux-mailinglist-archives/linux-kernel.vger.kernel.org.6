Return-Path: <linux-kernel+bounces-577006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F77A71737
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12BA61763C8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204991EB9E2;
	Wed, 26 Mar 2025 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ABl6iVpT"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011020.outbound.protection.outlook.com [52.101.70.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64431E5B86;
	Wed, 26 Mar 2025 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742994915; cv=fail; b=ozM9WwQZWRtHkA/3vbxq0Hb11tT4TLAYcPT3G3Z4ZMLFCh/w/ug/ABYnSHXRV5s9CKMc7T+L03jWK9epBr4BhwmDfEkHqCSmQ5Y8ppTzBkdbNdH0qB4teKakmjOKXPAHxc7IcRU/clfMRbvFv/OwcnFRWwpLXcrDDPkNpjLRvLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742994915; c=relaxed/simple;
	bh=d9ghXjA7XbkK/PptSq/iXmM9cfluf6kTBj9Nk+k/Gkk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=K5WH/LqdYPE2oIi3TK3oSgOd1Ca1LouAN4e/V+bFcz2Afe5z8opDLSlKRGQkRAnWBo3cwmnE+cLz1d4N7bY4nyxrUoipQbWxMx0sWwucEAGudRFTShTH3x0v77npAvTSTl4JNl0LEZpb9Ajfx8Z19rqFDotD9RbvtK+sRUt8m2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ABl6iVpT; arc=fail smtp.client-ip=52.101.70.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBq4AiVTHADYGkMxnxgS3qXqLdCqBVWq1CeI/YoSajP68FhxRtGOsORVIErbXTcaUF0CEXFG7KTp0Fm8kSzOwygTstCedVBSo4piOeImK55x0JMWJ4IHXUtcg7Ky9lxCEYXLTn2B0DiJ4unOcP4tIXi2c8Vr/pi8P9l3k6+BZzZesSt7BKx7XW+aq+ljF8EH6U8b93rXwbIJQ8is/lQIx0XN6Zrku9VtEgaC6Bc3NB9BOsMy+eJkpBLOp5n06AZK7ud/KRDOFueDkfbFrNYoM4/gN71JAKyk5hd49jsjAyMAS/68KILHt5HtJFes5wUGX3voz/hlyLtMvmuNb8+Qog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlpEfZGzB2T6I/sX8gLw2edoGZZWPEci2WUiM9/D7Bs=;
 b=YqZYJHNOrgzdYagbhvayipMwJkESj4VG1uoEl1yglYC9Xkw45Slf/H6s2e7c5cKesRQQBcwg0mW4gY2nd/jIFczTdFySSRoreOy9NYRfhZfRUY8AD9VXLXMgu7TwgU0yJxSGZOJhSnuR6uAA/65IErMfStX2PufAw5fvb9B4UdA0t7M6CmdGiB/Zx5qoliE1/+rtBCcEILuRbcJGWJoQUoJ6tfmogECtFmKNvHWJRSVwZLtb0GcwqSkKLacMBOIKFOkCuSNI17AaQvz9HnjjICPYHmpIQFbC/GWNhn7PDTp8aBs86gnJZw+l1qTcx03yp9yoeL8G40u/h+JInAqBqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlpEfZGzB2T6I/sX8gLw2edoGZZWPEci2WUiM9/D7Bs=;
 b=ABl6iVpTLtb77DZMHfNePCFVzrKVIpWVchksTJ09F3WySHkUE6Y/tEDk1c+js76RNvkmQDIdIqnpN6CeCih0GSc8gzu3XAK3WuWiyrELJPR147QWsDYVYqAWf4GtZ/K/vbghPYO+M9Y9S1sbNplkBPjpUKx4dHaZID9NZjBkQfaqmtnR1U9pIb+LIymEiAbS7+ypy2EIYaTGFIFL/NNv7ql/upDAKb8rl6T1LvyDmRI8Opx0khoS3fpcGFoOg8aKRzbE5gPWV1OuHuhSgiQ6RGHaxHMS20fa6Qrh7WjuP1FD8/z4iv+YYXPNmpo+kxeKwt6kkxfEy+wGjgveofMx1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DU2PR04MB8855.eurprd04.prod.outlook.com (2603:10a6:10:2e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 13:15:09 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 13:15:09 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Thu, 27 Mar 2025 00:08:00 +0530
Subject: [PATCH v14 4/6] firmware: imx: add driver for NXP EdgeLock Enclave
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-imx-se-if-v14-4-2219448932e4@nxp.com>
References: <20250327-imx-se-if-v14-0-2219448932e4@nxp.com>
In-Reply-To: <20250327-imx-se-if-v14-0-2219448932e4@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743014302; l=39292;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=d9ghXjA7XbkK/PptSq/iXmM9cfluf6kTBj9Nk+k/Gkk=;
 b=luvTG83Ky5SJ+8SQjoWy41F9Ks7H84ZK5JLn0sNwlkFpY6vyXI58MGokCCiaZAauFxkerRNI6
 HXqA1P9ZzKVCXvkoX14zPr+XbG2STos5VXQc9Yl+fx67GZzdf/GUemG
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DU2PR04MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: e92f5f47-393c-45aa-62ed-08dd6c683ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?am9pT0RKaTRRWXIvWDZ3L0tpRFlOb09XOVBYUVRQT2RaTURMTFhVSzQrRERr?=
 =?utf-8?B?bmJzNFNLQXNPbVhVSEQzc3VmbzdvbEZneVVXYjdwbE5GNnNiY3lVMTUzbXIr?=
 =?utf-8?B?b0F2RzBrbGlNblRtSEQzUGFoaCtlL2Z4eS9WaERWbVVJaW1RMFhFakhyT0Np?=
 =?utf-8?B?SGVKVW8xVjZ6dk5nK1dYd2p5OTJrTkdxb2lsZmdvTFJ2Y0lYY3NZdDkySjl2?=
 =?utf-8?B?SXFhWnByeE1EYWhOU1FXbmxCdm1KdkRydjBXaFlwS1ZQTzJ4OFZZeEM5SHUx?=
 =?utf-8?B?RytlZFZNRStBWlBCbGNrNDdRVFo4c1MzM1JldHk4TTY4TnB3STJQWnFaOVY0?=
 =?utf-8?B?TmxVcHAyY05RWmdQNmpVWjJVQkM1MWpWalFVcXpoT1N2SEhtL3c3TS9yc2tu?=
 =?utf-8?B?SGJBYmYwNUE0R2VlR3AxRmVQM1lyZ3VhcTE1bkJVMVNTUlNsM0c2ZUhzblhB?=
 =?utf-8?B?NkRMdURWNjRZTFZreHZPWk83RVVSN3EyQ3ZrMXhqR0pXaTFZQ3R6WGd1eXBu?=
 =?utf-8?B?VnRJeExTeWlPdXZCd0YvdmJQOFQrUzBrS2NyVEovcnNaN2F0RWF4VXNwV1Jo?=
 =?utf-8?B?SjMzYVZwVE93L1RWdVN1WHZEN1pRZG44Y0pONXFYTTdhUm1NbFVoZkN0aXhY?=
 =?utf-8?B?Q3h0Y0Z2R3dEV09QRmFmY21VUndZeENEdFVHc3FzaE5BeWNRdkdnZjRSSlRX?=
 =?utf-8?B?UXNmT2c2bjNvcDFiSzN0ZWFnYUZKQTE2ZWJYNEtCVFVUMzRzUFgvRDdKckNZ?=
 =?utf-8?B?d240VFdXODlveFAxdlpzSm5IcUtCOFQ4NE1JNU9ZdldHV0RHbWlReXNJRC8r?=
 =?utf-8?B?bzVSa2JtN1ZGUnhDY0tKM1g1V1JpbWVGV2Mza0llWWFzbjdrWVVBQ1pPcFBw?=
 =?utf-8?B?WkUzbnF1NmxvSFZaV25HNUJGQ0p2dG1qMjdoWElzSXBvR01kTCs4S3l6VU5U?=
 =?utf-8?B?OVcxL1RmT2hpZEcwRk9kc05za1RicnJicEMrTysrZGlZZVR4T0o4c0JxczFP?=
 =?utf-8?B?VGNUWkgyS3BlUUp4T1NSSE0zWVdNM1hocWlLWWh0Y0FFZk9QVGlPdm94U2kr?=
 =?utf-8?B?c3FzeGQvM0NLc0YyYk5LS3BLaVNNZjJ6ZUtiYTFwbU1zVFAvL1lEL3NLMjZt?=
 =?utf-8?B?ZkNCbEd3TnZrRGVncEpoRVh1SHpWUk5FQmNWQlZoN1VTM01SdG9jbHRQTUVW?=
 =?utf-8?B?ZjNyMmRCMWVHZG5waDdmdDUwYjJVZkcvak5LR0NPNkVzTE4weStXSzE5Nk9B?=
 =?utf-8?B?M3BlaUVrTTBFb1prU3dTelhncTJMb2Nwd3QzbjZDVnpiTmFTQXRCckJFTXVp?=
 =?utf-8?B?emNZQ0IvUVNtbWlVT3hjZkxZOTlSVGIrSUUxaVRvR010SDVOU256MDRZN2Vh?=
 =?utf-8?B?cGNaZ3JaejVkM2czRGhaeVZzUk90MmM0VnVsdUFHK2lRSUkzMWRmbDNCdDlK?=
 =?utf-8?B?NXFhZXFTek1VY1VGb3hFR05qR245SHVZMXcxaVBtcUcrM3ZENDdIYlpFOHZX?=
 =?utf-8?B?TVpiTTIxQWQvVHBCakJXUS9QYk8zdzJsNTZpT2x6V2NYME1zYndHZXFoV2Jk?=
 =?utf-8?B?aHlLQk5VTjRVTVJNa1FCMm9mNXFhNG8yZTJSekxMZ1IycFlLV21XVzBYYjdW?=
 =?utf-8?B?T3lPVnU4UEF2YlY2UmJ2YjFLTDRJVm96VjljTlpLWHBnaHBCUnVRbEkzdEdU?=
 =?utf-8?B?NlFyTE56WmRseW5uYkprcUoxaDZUOWpJeEplTW14d3JrNndRNmNSL2FEN0k2?=
 =?utf-8?B?WWZwTXc5S1dKODVqcEd4cGFBMGlZcWw0WGZPRzFSK2Z1cDY1RzFhNW5JNXp2?=
 =?utf-8?B?d21WU3Ewb3d6cThtMy8vM1BPb0RGWUpTU0ZGRU54bkJQZVpqa1ZtenlLTkps?=
 =?utf-8?B?WUFlRVZNZUo5NzlWZVdVNlVreUxhYm5IMTAxOXVrYjVBMFNHR0E3b0RQWmov?=
 =?utf-8?B?ODJudmt1Z3FoNXY2aXR0aVJNQXdEcEt1Y3IyUG5SR3kySWV6VnJPb3pzaG00?=
 =?utf-8?B?VnJYeHU1S21nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3l4eTd5dWtiUWNCd1VrYkZBQk9KdVpjT3NWUzFKY0paa1FwdWlITlJWQ3Jl?=
 =?utf-8?B?ZjRkeWNQZTJGSWorYkx3ZWNKSFUySHNzYnhqbWxCQ1duY21DaUJMdTdrMFdF?=
 =?utf-8?B?ZEhhVVJ6Z2dIU3dBVnJ6QWNPNGhpL3hNdTdldm5aUFJqZk9LbUZmNU5xM1Z1?=
 =?utf-8?B?Ymg4WjV0RExaOGVPY0pxblBHbzErN0YyS3pOc0xTQk5CWDB1alVpMUVXWlRy?=
 =?utf-8?B?aFNMY0xZYVJPdjVFVGRzQmNFSTJsZUFVNTBzMzQ0a3c2aUh5dVZaYk1kMC9I?=
 =?utf-8?B?aGxNMmU4aXVDc3NmaUswNDg1NHc4cTlqSEZYMWsxSmVFa1BZNjBoL0tzUHFF?=
 =?utf-8?B?UUk4SzJ2bkd1VHRHSGhsS2VwSzkzRDI2UDcvUXVSN0JzTWlDNU1jZGZOMmxa?=
 =?utf-8?B?MU5FZ0w0WWhUQUlkVHFpeGRIQUVDQ1RTWkkrQ01HM1lZM3hTTWxnSFY4d0dC?=
 =?utf-8?B?dmpGVElEcEhoS056bjE2ZUU1bDVlSXBGbFdQSXVHbEpxcGlzVzluTU1SQjFI?=
 =?utf-8?B?VDVSZ2VWeXZMZUo1T2U1N2l1OUVMTm11TGVhMU9qZXBrb3JzWFdvY2JrWmxN?=
 =?utf-8?B?ZVJNQU52M1l5dUlLMW9PbTlkbVlwcHk3K1Y5NWlBTk9UWnBrUEs5VElOeEhP?=
 =?utf-8?B?OE5wdklOQURYbTcvVjdHMzd5U0hMZkUrYStITVZDQzl2MXpXSmc3dkgrRkti?=
 =?utf-8?B?bFJlbTh5MGZaQU5zTHk5T0p2NEVTQjVmdWN0RzdqL1VwS0ppd29zaHJXZUNz?=
 =?utf-8?B?QjdPUExJa1dFWFZlSTFqeE1DNGpGY056YTQ1OHltWTdpSXkvV2VaWkkwVTI3?=
 =?utf-8?B?SXUxcE8rak55SmZ1dTJBUWFMalNwMytSVnNJYnVkZW4ySm1kbGJwYXJMN3Vn?=
 =?utf-8?B?NTRwemRWYjFkWGlhVnNXK1ZlWTFEZmlZYjdpeXo0TEx0b1Ezb0luRHRzWE16?=
 =?utf-8?B?SFNJdnpxTW9sd1VKWjBwa1ZLS3V5bGp3aU0zTU1NSm03dVc4eHRjdDljT1lz?=
 =?utf-8?B?cGFzZFJhZWR3bDArZ09tdk1qZkRDd2JqS3V2dGlvMlJIK1RpZnM3NXlmS2oy?=
 =?utf-8?B?SlVBaW1HU0lDc204azZBcGhPallSTDMveW9iN1llK21YbXBURlRFN1lISDFE?=
 =?utf-8?B?aTlONmhmZUY1L0dPTWJ6UzcwMjNaOEhkd09XS1BVaDhTdTlPMUdjTnVZQXYz?=
 =?utf-8?B?NHJ6TzBqR3ZVa3EzUkc2VHovTGVsbThRK2VvMmxBWVZUWVlRaXpFV1p6SWZH?=
 =?utf-8?B?SmE1WW1mdjlWdDlZeFg4ckRrcFcyeDV5aXl1YmxPMXVGd3BUWXM1WUs4RDJk?=
 =?utf-8?B?ZWxjTmlDd2ptTlkvYVZSakhQZDBuSW9OZU9ZUzhNSXNISlFibElZcVoySVhz?=
 =?utf-8?B?amlHa2xYRFVYVTdJVFQxZElIT0pzUlBveEFUcU9TeXNKRkJSeUZBdFNhdkc5?=
 =?utf-8?B?c2FYUUxBUllXUC9mem1QT3p6R0w3UnlOaGI1eXA2NG1FNE9LNWw4QjIzNC9x?=
 =?utf-8?B?a3VhSE5qbWw1ZEFpSlZRZzJUM1VUUytINkQzR1JrMFRIZkg1TDlSd08zeEhm?=
 =?utf-8?B?OFVjQ1RPdHV0L0JyZXp0WnZLSlFhYTlKQXphZVpnTEVjT2hibkJZVEVvelp6?=
 =?utf-8?B?SWVVcitVaXg2dnB2blEzZnhLYU83NytGb3dLaEQxV0VFWEJGYkc3L3pQVDJE?=
 =?utf-8?B?NTArTjFJVU5ucjVielhGemlMMTFCckFBMlhaVGljeXJMeVdVeUowb0FPR1pw?=
 =?utf-8?B?VTZnYVVnMTlXU2JrdzE1Z3RJcWY0NVRKUGZDc01CRmIvS1l2NjFYODRvKzFn?=
 =?utf-8?B?SWlleGFtN05GSjM5YzhLRGxQMEM0aWZjRkltR2FYNGRJdHRMM0VuVVd4TVI3?=
 =?utf-8?B?NWE3TGhJQmdpd3lBTG1xTWVhYkFkazloaWFtbmFKUnBZRklVa3pMSklML1N5?=
 =?utf-8?B?K085eTlxZ1pic2JhYzZ3aXRlU1kyaWEzd2tvRm51dXBTUlUzNkhQRDFEZDU1?=
 =?utf-8?B?UkVQaEJuUGJtYW8yRkN0T09lcGczZG1WaUpXeEJRUDR2ckwvdWd5M2pYMjhS?=
 =?utf-8?B?dnNQU080bzA1YzVlRWdCczAxU1pXMmU2VjlxaUcxS1pMdVl4UU13RDlrSW1B?=
 =?utf-8?Q?kf5Ck8ddpxymCr6MNjRhCtZRv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92f5f47-393c-45aa-62ed-08dd6c683ba3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 13:15:09.1167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQIcBaENpvs83zBYllmK5TA6QrJPPB3uXnBojO2aSFDzxDcSoHQkuxrh7LdqT1CSfsXm2uJJDdzkroxfnbSEhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8855

Add driver for enabling MU based communication interface to secure-enclave.

NXP hardware IP(s) for secure-enclaves like Edgelock Enclave(ELE),
are embedded in the SoC to support the features like HSM, SHE & V2X,
using message based communication interface.

The secure enclave FW communicates with Linux over single or multiple
dedicated messaging unit(MU) based interface(s).
Exists on i.MX SoC(s) like i.MX8ULP, i.MX93, i.MX95 etc.

Other dependent kernel drivers will be:
- NVMEM: that supports non-volatile devices like EFUSES,
         managed by NXP's secure-enclave.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
changes from v13 to v14
- trimmed the ele_fetch_soc_info.
- removed the function ptr "se_info->se_fetch_soc_info" and replaced with ele_fetch_soc_info.
- moved definition of func se_load_firmware, to 6/6 patch.
- Different SoC, different ways to fetch soc_info. Generic function declaration for ele_fetch_soc_info() is needed. Hence wrapping ele_get_info() in it.
- Updated Kconfig help text for assertive tone.
- func ele_debug_dump is updated, to remove constructing the format string.
- removed the macro usage for SOC_ID_MASK.
- used low case hex number.
- Condition will never occur, where msg_len satisfy the following condition "msg_len % 4 != 0". Err msg is added if it occurs.
- Function description is added to se_add_msg_crc.
- timeout is added to function ele_msg_rcv, in 5/5 patch.
- local variable "header" is initialized with "tx_msg" and replaced "return err" with "return tx_msg_sz" in func ele_msg_send().
- replace function name from "exception_for_size" to "check_hdr_exception_for_sz"
- replaced "return ret > 0 ? 0 : -1;" with "return ret > 0 ? 0 : ret;" in func "se_save_imem_state".
- func "se_restore_imem_state", to return if the condition is false to proceed.
- removed casting by (void *).
- removed devm_kasprintf and done direct allocatiion for attr->soc_id = "i.MX8ULP" & attr->soc_id = "i.MX8ULP", & attr->family.
- Followed Reverse christmas tree order, whereever missing.
- There is no return if ele_fw_authenticate fails. Execution flow continue forward and execute the fucn dma_free_coherent().
- The loop is not for retry. The loop is needed to load secondary fw followed by loading primary fw, first. This is the case when ELE also got reset.
- dev_err_probe is corrected in func "se_if_request_channel".
---
 drivers/firmware/imx/Kconfig        |  13 ++
 drivers/firmware/imx/Makefile       |   2 +
 drivers/firmware/imx/ele_base_msg.c | 315 ++++++++++++++++++++++++++++
 drivers/firmware/imx/ele_base_msg.h |  95 +++++++++
 drivers/firmware/imx/ele_common.c   | 343 ++++++++++++++++++++++++++++++
 drivers/firmware/imx/ele_common.h   |  50 +++++
 drivers/firmware/imx/se_ctrl.c      | 402 ++++++++++++++++++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h      |  84 ++++++++
 include/linux/firmware/imx/se_api.h |  14 ++
 9 files changed, 1318 insertions(+)

diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index c964f4924359..f76ad32aad59 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -33,3 +33,16 @@ config IMX_SCMI_MISC_DRV
 	  core that could provide misc functions such as board control.
 
 	  This driver can also be built as a module.
+
+config IMX_SEC_ENCLAVE
+	tristate "i.MX Embedded Secure Enclave - EdgeLock Enclave Firmware driver."
+	depends on IMX_MBOX && ARCH_MXC && ARM64
+	select FW_LOADER
+	default m if ARCH_MXC
+
+	help
+	  Exposes APIs supported by the iMX Secure Enclave HW IP called:
+	  - EdgeLock Enclave Firmware (for i.MX8ULP, i.MX93),
+	    like base, HSM, V2X & SHE using the SAB protocol via the shared Messaging
+	    Unit. This driver exposes these interfaces via a set of file descriptors
+	    allowing to configure shared memory, send and receive messages.
diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 8d046c341be8..4e1d2706535d 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -2,3 +2,5 @@
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
 obj-${CONFIG_IMX_SCMI_MISC_DRV}	+= sm-misc.o
+sec_enclave-objs		= se_ctrl.o ele_common.o ele_base_msg.o
+obj-${CONFIG_IMX_SEC_ENCLAVE}	+= sec_enclave.o
diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
new file mode 100644
index 000000000000..3839c93f8212
--- /dev/null
+++ b/drivers/firmware/imx/ele_base_msg.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <linux/types.h>
+
+#include <linux/completion.h>
+#include <linux/dma-mapping.h>
+#include <linux/genalloc.h>
+
+#include "ele_base_msg.h"
+#include "ele_common.h"
+
+#define FW_DBG_DUMP_FIXED_STR		"ELE"
+
+int ele_get_info(struct se_if_priv *priv, struct ele_dev_info *s_info)
+{
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	dma_addr_t get_info_addr = 0;
+	u32 *get_info_data = NULL;
+	int ret = 0;
+
+	if (!priv)
+		return -EINVAL;
+
+	memset(s_info, 0x0, sizeof(*s_info));
+
+	tx_msg = kzalloc(ELE_GET_INFO_REQ_MSG_SZ, GFP_KERNEL);
+	if (!tx_msg)
+		return -ENOMEM;
+
+	rx_msg = kzalloc(ELE_GET_INFO_RSP_MSG_SZ, GFP_KERNEL);
+	if (!rx_msg)
+		return -ENOMEM;
+
+	if (priv->mem_pool)
+		get_info_data = gen_pool_dma_alloc(priv->mem_pool,
+						   ELE_GET_INFO_BUFF_SZ,
+						   &get_info_addr);
+	else
+		get_info_data = dma_alloc_coherent(priv->dev,
+						   ELE_GET_INFO_BUFF_SZ,
+						   &get_info_addr,
+						   GFP_KERNEL);
+	if (!get_info_data) {
+		dev_dbg(priv->dev,
+			"%s: Failed to allocate get_info_addr.\n",
+			__func__);
+		return -ENOMEM;
+	}
+
+	ret = se_fill_cmd_msg_hdr(priv,
+				  (struct se_msg_hdr *)&tx_msg->header,
+				  ELE_GET_INFO_REQ,
+				  ELE_GET_INFO_REQ_MSG_SZ,
+				  true);
+	if (ret)
+		goto exit;
+
+	tx_msg->data[0] = upper_32_bits(get_info_addr);
+	tx_msg->data[1] = lower_32_bits(get_info_addr);
+	tx_msg->data[2] = sizeof(*s_info);
+	ret = ele_msg_send_rcv(priv,
+			       tx_msg,
+			       ELE_GET_INFO_REQ_MSG_SZ,
+			       rx_msg,
+			       ELE_GET_INFO_RSP_MSG_SZ);
+	if (ret < 0)
+		goto exit;
+
+	ret = se_val_rsp_hdr_n_status(priv,
+				      rx_msg,
+				      ELE_GET_INFO_REQ,
+				      ELE_GET_INFO_RSP_MSG_SZ,
+				      true);
+
+	memcpy(s_info, get_info_data, sizeof(*s_info));
+
+exit:
+	if (priv->mem_pool)
+		gen_pool_free(priv->mem_pool,
+			      (u64)get_info_data,
+			      ELE_GET_INFO_BUFF_SZ);
+	else
+		dma_free_coherent(priv->dev,
+				  ELE_GET_INFO_BUFF_SZ,
+				  get_info_data,
+				  get_info_addr);
+
+	return ret;
+}
+
+int ele_fetch_soc_info(struct se_if_priv *priv, void *data)
+{
+	return ele_get_info(priv, data);
+}
+
+int ele_ping(struct se_if_priv *priv)
+{
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	int ret = 0;
+
+	if (!priv)
+		return -EINVAL;
+
+	tx_msg = kzalloc(ELE_PING_REQ_SZ, GFP_KERNEL);
+	if (!tx_msg)
+		return -ENOMEM;
+
+	rx_msg = kzalloc(ELE_PING_RSP_SZ, GFP_KERNEL);
+	if (!rx_msg)
+		return -ENOMEM;
+
+	ret = se_fill_cmd_msg_hdr(priv,
+				  (struct se_msg_hdr *)&tx_msg->header,
+				  ELE_PING_REQ, ELE_PING_REQ_SZ, true);
+	if (ret) {
+		dev_err(priv->dev, "Error: se_fill_cmd_msg_hdr failed.\n");
+		return ret;
+	}
+
+	ret = ele_msg_send_rcv(priv,
+			       tx_msg,
+			       ELE_PING_REQ_SZ,
+			       rx_msg,
+			       ELE_PING_RSP_SZ);
+	if (ret < 0)
+		return ret;
+
+	ret = se_val_rsp_hdr_n_status(priv,
+				      rx_msg,
+				      ELE_PING_REQ,
+				      ELE_PING_RSP_SZ,
+				      true);
+
+	return ret;
+}
+
+int ele_service_swap(struct se_if_priv *priv,
+		     phys_addr_t addr,
+		     u32 addr_size, u16 flag)
+{
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	int ret = 0;
+
+	if (!priv)
+		return -EINVAL;
+
+	tx_msg = kzalloc(ELE_SERVICE_SWAP_REQ_MSG_SZ, GFP_KERNEL);
+	if (!tx_msg)
+		return -ENOMEM;
+
+	rx_msg = kzalloc(ELE_SERVICE_SWAP_RSP_MSG_SZ, GFP_KERNEL);
+	if (!rx_msg)
+		return -ENOMEM;
+
+	ret = se_fill_cmd_msg_hdr(priv,
+				  (struct se_msg_hdr *)&tx_msg->header,
+				  ELE_SERVICE_SWAP_REQ,
+				  ELE_SERVICE_SWAP_REQ_MSG_SZ, true);
+	if (ret)
+		return ret;
+
+	tx_msg->data[0] = flag;
+	tx_msg->data[1] = addr_size;
+	tx_msg->data[2] = ELE_NONE_VAL;
+	tx_msg->data[3] = lower_32_bits(addr);
+	tx_msg->data[4] = se_add_msg_chksum((uint32_t *)&tx_msg[0],
+					    ELE_SERVICE_SWAP_REQ_MSG_SZ);
+	if (!tx_msg->data[4])
+		return -EINVAL;
+
+	ret = ele_msg_send_rcv(priv,
+			       tx_msg,
+			       ELE_SERVICE_SWAP_REQ_MSG_SZ,
+			       rx_msg,
+			       ELE_SERVICE_SWAP_RSP_MSG_SZ);
+	if (ret < 0)
+		return ret;
+
+	ret = se_val_rsp_hdr_n_status(priv,
+				      rx_msg,
+				      ELE_SERVICE_SWAP_REQ,
+				      ELE_SERVICE_SWAP_RSP_MSG_SZ,
+				      true);
+	if (ret)
+		return ret;
+
+	if (flag == ELE_IMEM_EXPORT)
+		ret = rx_msg->data[1];
+	else
+		ret = 0;
+
+	return ret;
+}
+
+int ele_fw_authenticate(struct se_if_priv *priv, phys_addr_t addr)
+{
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	int ret = 0;
+
+	if (!priv)
+		return -EINVAL;
+
+	tx_msg = kzalloc(ELE_FW_AUTH_REQ_SZ, GFP_KERNEL);
+	if (!tx_msg)
+		return -ENOMEM;
+
+	rx_msg = kzalloc(ELE_FW_AUTH_RSP_MSG_SZ, GFP_KERNEL);
+	if (!rx_msg)
+		return -ENOMEM;
+
+	ret = se_fill_cmd_msg_hdr(priv,
+				  (struct se_msg_hdr *)&tx_msg->header,
+				  ELE_FW_AUTH_REQ,
+				  ELE_FW_AUTH_REQ_SZ,
+				  true);
+	if (ret)
+		return ret;
+
+	tx_msg->data[1] = upper_32_bits(addr);
+	tx_msg->data[0] = lower_32_bits(addr);
+	tx_msg->data[2] = addr;
+
+	ret = ele_msg_send_rcv(priv,
+			       tx_msg,
+			       ELE_FW_AUTH_REQ_SZ,
+			       rx_msg,
+			       ELE_FW_AUTH_RSP_MSG_SZ);
+	if (ret < 0)
+		return ret;
+
+	ret = se_val_rsp_hdr_n_status(priv,
+				      rx_msg,
+				      ELE_FW_AUTH_REQ,
+				      ELE_FW_AUTH_RSP_MSG_SZ,
+				      true);
+	return ret;
+}
+
+int ele_debug_dump(struct se_if_priv *priv)
+{
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	bool keep_logging;
+	int msg_ex_cnt;
+	int ret = 0;
+	int i;
+
+	if (!priv)
+		return -EINVAL;
+
+	tx_msg = kzalloc(ELE_DEBUG_DUMP_REQ_SZ, GFP_KERNEL);
+	if (!tx_msg)
+		return -ENOMEM;
+
+	rx_msg = kzalloc(ELE_DEBUG_DUMP_RSP_SZ, GFP_KERNEL);
+	if (!rx_msg)
+		return -ENOMEM;
+
+	ret = se_fill_cmd_msg_hdr(priv,
+				  &tx_msg->header,
+				  ELE_DEBUG_DUMP_REQ,
+				  ELE_DEBUG_DUMP_REQ_SZ,
+				  true);
+	if (ret)
+		return ret;
+
+	msg_ex_cnt = 0;
+	do {
+		memset(rx_msg, 0x0, ELE_DEBUG_DUMP_RSP_SZ);
+
+		ret = ele_msg_send_rcv(priv,
+				       tx_msg,
+				       ELE_DEBUG_DUMP_REQ_SZ,
+				       rx_msg,
+				       ELE_DEBUG_DUMP_RSP_SZ);
+		if (ret < 0)
+			return ret;
+
+		ret = se_val_rsp_hdr_n_status(priv,
+					      rx_msg,
+					      ELE_DEBUG_DUMP_REQ,
+					      ELE_DEBUG_DUMP_RSP_SZ,
+					      true);
+		if (!ret) {
+			keep_logging = (rx_msg->header.size < (ELE_DEBUG_DUMP_RSP_SZ >> 2)) ?
+					false : true;
+			keep_logging = keep_logging ?
+						(msg_ex_cnt > ELE_MAX_DBG_DMP_PKT ? false : true) :
+						false;
+
+			rx_msg->header.size -= 2;
+
+			if (rx_msg->header.size > 4)
+				rx_msg->header.size--;
+
+			for (i = 0; i < rx_msg->header.size; i += 2)
+				dev_info(priv->dev, "%s%02x_%02x: 0x%08x 0x%08x",
+					 FW_DBG_DUMP_FIXED_STR,	msg_ex_cnt, i,
+					 rx_msg->data[i + 1], rx_msg->data[i + 2]);
+		} else {
+			dev_err(priv->dev, "Dump_Debug_Buffer Error: %x.", ret);
+			break;
+		}
+		msg_ex_cnt++;
+	} while (keep_logging);
+
+	return ret;
+}
diff --git a/drivers/firmware/imx/ele_base_msg.h b/drivers/firmware/imx/ele_base_msg.h
new file mode 100644
index 000000000000..c037a9cfa24c
--- /dev/null
+++ b/drivers/firmware/imx/ele_base_msg.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ *
+ * Header file for the EdgeLock Enclave Base API(s).
+ */
+
+#ifndef ELE_BASE_MSG_H
+#define ELE_BASE_MSG_H
+
+#include <linux/device.h>
+#include <linux/types.h>
+
+#include "se_ctrl.h"
+
+#define ELE_NONE_VAL			0x0
+
+#define ELE_GET_INFO_REQ		0xda
+#define ELE_GET_INFO_REQ_MSG_SZ		0x10
+#define ELE_GET_INFO_RSP_MSG_SZ		0x08
+
+#define MAX_UID_SIZE                     (16)
+#define DEV_GETINFO_ROM_PATCH_SHA_SZ     (32)
+#define DEV_GETINFO_FW_SHA_SZ            (32)
+#define DEV_GETINFO_OEM_SRKH_SZ          (64)
+#define DEV_GETINFO_MIN_VER_MASK	0xff
+#define DEV_GETINFO_MAJ_VER_MASK	0xff00
+#define ELE_DEV_INFO_EXTRA_SZ		0x60
+
+struct dev_info {
+	u8  cmd;
+	u8  ver;
+	u16 length;
+	u16 soc_id;
+	u16 soc_rev;
+	u16 lmda_val;
+	u8  ssm_state;
+	u8  dev_atts_api_ver;
+	u8  uid[MAX_UID_SIZE];
+	u8  sha_rom_patch[DEV_GETINFO_ROM_PATCH_SHA_SZ];
+	u8  sha_fw[DEV_GETINFO_FW_SHA_SZ];
+};
+
+struct dev_addn_info {
+	u8  oem_srkh[DEV_GETINFO_OEM_SRKH_SZ];
+	u8  trng_state;
+	u8  csal_state;
+	u8  imem_state;
+	u8  reserved2;
+};
+
+struct ele_dev_info {
+	struct dev_info d_info;
+	struct dev_addn_info d_addn_info;
+};
+
+#define ELE_GET_INFO_BUFF_SZ		(sizeof(struct ele_dev_info) \
+						+ ELE_DEV_INFO_EXTRA_SZ)
+
+#define GET_SERIAL_NUM_FROM_UID(x, uid_word_sz) \
+	(((u64)(((u32 *)(x))[(uid_word_sz) - 1]) << 32) | ((u32 *)(x))[0])
+
+#define ELE_MAX_DBG_DMP_PKT		50
+#define ELE_DEBUG_DUMP_REQ		0x21
+#define ELE_DEBUG_DUMP_REQ_SZ		0x4
+#define ELE_DEBUG_DUMP_RSP_SZ		0x5c
+
+#define ELE_PING_REQ			0x01
+#define ELE_PING_REQ_SZ			0x04
+#define ELE_PING_RSP_SZ			0x08
+
+#define ELE_SERVICE_SWAP_REQ		0xdf
+#define ELE_SERVICE_SWAP_REQ_MSG_SZ	0x18
+#define ELE_SERVICE_SWAP_RSP_MSG_SZ	0x0c
+#define ELE_IMEM_SIZE			0x10000
+#define ELE_IMEM_STATE_OK		0xca
+#define ELE_IMEM_STATE_BAD		0xfe
+#define ELE_IMEM_STATE_WORD		0x27
+#define ELE_IMEM_STATE_MASK		0x00ff0000
+#define ELE_IMEM_EXPORT			0x1
+#define ELE_IMEM_IMPORT			0x2
+
+#define ELE_FW_AUTH_REQ			0x02
+#define ELE_FW_AUTH_REQ_SZ		0x10
+#define ELE_FW_AUTH_RSP_MSG_SZ		0x08
+
+int ele_get_info(struct se_if_priv *priv, struct ele_dev_info *s_info);
+int ele_fetch_soc_info(struct se_if_priv *priv, void *data);
+int ele_ping(struct se_if_priv *priv);
+int ele_service_swap(struct se_if_priv *priv,
+		     phys_addr_t addr,
+		     u32 addr_size, u16 flag);
+int ele_fw_authenticate(struct se_if_priv *priv, phys_addr_t addr);
+int ele_debug_dump(struct se_if_priv *priv);
+#endif
diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
new file mode 100644
index 000000000000..be4dabeeb64c
--- /dev/null
+++ b/drivers/firmware/imx/ele_common.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include "ele_base_msg.h"
+#include "ele_common.h"
+
+/*
+ * se_add_msg_chksum() - to calculate checksum word by word.
+ *
+ * @msg  : reference to the input msg-data.
+ * @msg_len  : reference to the input msg-data length in bytes.
+ *
+ * This function returns the checksum calculated by ORing word by word.
+ *
+ * Return:
+ *  0: if the input length is not 4 byte aligned, or num of words < 5.
+ *  chksum: calculated word by word.
+ */
+u32 se_add_msg_chksum(u32 *msg, u32 msg_len)
+{
+	u32 nb_words = msg_len / (u32)sizeof(u32);
+	u32 chksum = 0;
+	u32 i;
+
+	if (nb_words < 5)
+		return chksum;
+
+	if (msg_len % SE_MSG_WORD_SZ) {
+		pr_err("Msg-len is not 4-byte aligned.");
+		return chksum;
+	}
+
+	for (i = 0; i < nb_words - 1; i++)
+		chksum ^= *(msg + i);
+
+	return chksum;
+}
+
+int ele_msg_rcv(struct se_if_priv *priv,
+		struct se_clbk_handle *se_clbk_hdl)
+{
+	int err = 0;
+
+	do {
+		err = wait_for_completion_interruptible(&se_clbk_hdl->done);
+		if (err == -ERESTARTSYS) {
+			if (priv->waiting_rsp_clbk_hdl.rx_msg) {
+				priv->waiting_rsp_clbk_hdl.signal_rcvd = true;
+				continue;
+			}
+			dev_err(priv->dev,
+				"Err[0x%x]:Interrupted by signal.\n", err);
+			err = -EINTR;
+			break;
+		}
+	} while (err != 0);
+
+	return err ? err : se_clbk_hdl->rx_msg_sz;
+}
+
+int ele_msg_send(struct se_if_priv *priv,
+		 void *tx_msg,
+		 int tx_msg_sz)
+{
+	struct se_msg_hdr *header = tx_msg;
+	int err;
+
+	/*
+	 * Check that the size passed as argument matches the size
+	 * carried in the message.
+	 */
+	if (header->size << 2 != tx_msg_sz) {
+		dev_err(priv->dev,
+			"User buf hdr: 0x%x, sz mismatced with input-sz (%d != %d).",
+			*(u32 *)header,
+			header->size << 2, tx_msg_sz);
+		return -EINVAL;
+	}
+
+	err = mbox_send_message(priv->tx_chan, tx_msg);
+	if (err < 0) {
+		dev_err(priv->dev, "Error: mbox_send_message failure.\n");
+		return err;
+	}
+
+	return tx_msg_sz;
+}
+
+/* API used for send/receive blocking call. */
+int ele_msg_send_rcv(struct se_if_priv *priv,
+		     void *tx_msg,
+		     int tx_msg_sz,
+		     void *rx_msg,
+		     int exp_rx_msg_sz)
+{
+	int err;
+
+	guard(mutex)(&priv->se_if_cmd_lock);
+
+	priv->waiting_rsp_clbk_hdl.rx_msg_sz = exp_rx_msg_sz;
+	priv->waiting_rsp_clbk_hdl.rx_msg = rx_msg;
+
+	err = ele_msg_send(priv, tx_msg, tx_msg_sz);
+	if (err < 0)
+		return err;
+
+	err = ele_msg_rcv(priv, &priv->waiting_rsp_clbk_hdl);
+
+	if (priv->waiting_rsp_clbk_hdl.signal_rcvd) {
+		err = -EINTR;
+		priv->waiting_rsp_clbk_hdl.signal_rcvd = false;
+		dev_err(priv->dev,
+			"Err[0x%x]:Interrupted by signal.\n", err);
+	}
+
+	return err;
+}
+
+static bool check_hdr_exception_for_sz(struct se_if_priv *priv,
+				       struct se_msg_hdr *header)
+{
+	/* List of API(s) header that can be accepte variable length
+	 * response buffer.
+	 */
+	if (header->command == ELE_DEBUG_DUMP_REQ &&
+	    header->ver == priv->if_defs->base_api_ver &&
+	    header->size >= 0 &&
+	    header->size <= ELE_DEBUG_DUMP_RSP_SZ)
+		return true;
+
+	return false;
+}
+
+/*
+ * Callback called by mailbox FW, when data is received.
+ */
+void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
+{
+	struct se_clbk_handle *se_clbk_hdl;
+	struct device *dev = mbox_cl->dev;
+	struct se_msg_hdr *header;
+	struct se_if_priv *priv;
+	u32 rx_msg_sz;
+
+	priv = dev_get_drvdata(dev);
+
+	/* The function can be called with NULL msg */
+	if (!msg) {
+		dev_err(dev, "Message is invalid\n");
+		return;
+	}
+
+	header = msg;
+	rx_msg_sz = header->size << 2;
+
+	/* Incoming command: wake up the receiver if any. */
+	if (header->tag == priv->if_defs->cmd_tag) {
+		se_clbk_hdl = &priv->cmd_receiver_clbk_hdl;
+		dev_dbg(dev,
+			"Selecting cmd receiver for mesg header:0x%x.",
+			*(u32 *)header);
+
+		/* Pre-allocated buffer of MAX_NVM_MSG_LEN
+		 * as the NVM command are initiated by FW.
+		 * Size is revealed as part of this call function.
+		 */
+		if (rx_msg_sz > MAX_NVM_MSG_LEN) {
+			dev_err(dev,
+				"CMD-RCVER NVM: hdr(0x%x) with different sz(%d != %d).\n",
+				*(u32 *)header,
+				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
+
+			se_clbk_hdl->rx_msg_sz = MAX_NVM_MSG_LEN;
+		}
+		se_clbk_hdl->rx_msg_sz = rx_msg_sz;
+
+	} else if (header->tag == priv->if_defs->rsp_tag) {
+		se_clbk_hdl = &priv->waiting_rsp_clbk_hdl;
+		dev_dbg(dev,
+			"Selecting resp waiter for mesg header:0x%x.",
+			*(u32 *)header);
+
+		if (rx_msg_sz != se_clbk_hdl->rx_msg_sz &&
+		    check_hdr_exception_for_sz(priv, header)) {
+			dev_err(dev,
+				"Rsp to CMD: hdr(0x%x) with different sz(%d != %d).\n",
+				*(u32 *)header,
+				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
+
+			se_clbk_hdl->rx_msg_sz = min(rx_msg_sz, se_clbk_hdl->rx_msg_sz);
+		}
+	} else {
+		dev_err(dev, "Failed to select a device for message: %.8x\n",
+			*((u32 *)header));
+		return;
+	}
+
+	memcpy(se_clbk_hdl->rx_msg, msg, se_clbk_hdl->rx_msg_sz);
+
+	/* Allow user to read */
+	complete(&se_clbk_hdl->done);
+}
+
+int se_val_rsp_hdr_n_status(struct se_if_priv *priv,
+			    struct se_api_msg *msg,
+			    u8 msg_id,
+			    u8 sz,
+			    bool is_base_api)
+{
+	struct se_msg_hdr *header = &msg->header;
+	u32 status;
+
+	if (header->tag != priv->if_defs->rsp_tag) {
+		dev_err(priv->dev,
+			"MSG[0x%x] Hdr: Resp tag mismatch. (0x%x != 0x%x)",
+			msg_id, header->tag, priv->if_defs->rsp_tag);
+		return -EINVAL;
+	}
+
+	if (header->command != msg_id) {
+		dev_err(priv->dev,
+			"MSG Header: Cmd id mismatch. (0x%x != 0x%x)",
+			header->command, msg_id);
+		return -EINVAL;
+	}
+
+	if (header->size != (sz >> 2) && !check_hdr_exception_for_sz(priv, header)) {
+		dev_err(priv->dev,
+			"MSG[0x%x] Hdr: Cmd size mismatch. (0x%x != 0x%x)",
+			msg_id, header->size, (sz >> 2));
+		return -EINVAL;
+	}
+
+	if (is_base_api && header->ver != priv->if_defs->base_api_ver) {
+		dev_err(priv->dev,
+			"MSG[0x%x] Hdr: Base API Vers mismatch. (0x%x != 0x%x)",
+			msg_id, header->ver, priv->if_defs->base_api_ver);
+		return -EINVAL;
+	} else if (!is_base_api && header->ver != priv->if_defs->fw_api_ver) {
+		dev_err(priv->dev,
+			"MSG[0x%x] Hdr: FW API Vers mismatch. (0x%x != 0x%x)",
+			msg_id, header->ver, priv->if_defs->fw_api_ver);
+		return -EINVAL;
+	}
+
+	status = RES_STATUS(msg->data[0]);
+	if (status != priv->if_defs->success_tag) {
+		dev_err(priv->dev, "Command Id[%x], Response Failure = 0x%x",
+			header->command, status);
+		return -EPERM;
+	}
+
+	return 0;
+}
+
+int se_save_imem_state(struct se_if_priv *priv, struct se_imem_buf *imem)
+{
+	struct ele_dev_info s_info = {0};
+	int ret;
+
+	ret = ele_get_info(priv, &s_info);
+	if (ret) {
+		dev_err(priv->dev, "Failed to get info from ELE.\n");
+		return ret;
+	}
+
+	/* Do not save the IMEM buffer, if the current IMEM state is BAD. */
+	if (s_info.d_addn_info.imem_state == ELE_IMEM_STATE_BAD)
+		return ret;
+
+	/* EXPORT command will save encrypted IMEM to given address,
+	 * so later in resume, IMEM can be restored from the given
+	 * address.
+	 *
+	 * Size must be at least 64 kB.
+	 */
+	ret = ele_service_swap(priv,
+			       imem->phyaddr,
+			       ELE_IMEM_SIZE,
+			       ELE_IMEM_EXPORT);
+	if (ret < 0) {
+		dev_err(priv->dev, "Failed to export IMEM.");
+		imem->size = 0;
+	} else {
+		dev_info(priv->dev,
+			 "Exported %d bytes of encrypted IMEM.",
+			 ret);
+		imem->size = ret;
+	}
+
+	return ret > 0 ? 0 : ret;
+}
+
+int se_restore_imem_state(struct se_if_priv *priv, struct se_imem_buf *imem)
+{
+	struct ele_dev_info s_info;
+	int ret;
+
+	/* get info from ELE */
+	ret = ele_get_info(priv, &s_info);
+	if (ret) {
+		dev_err(priv->dev, "Failed to get info from ELE.");
+		return ret;
+	}
+	imem->state = s_info.d_addn_info.imem_state;
+
+	/* Get IMEM state, if 0xFE then import IMEM if imem size is non-zero. */
+	if (s_info.d_addn_info.imem_state != ELE_IMEM_STATE_BAD || !imem->size)
+		return ret;
+
+	/* IMPORT command will restore IMEM from the given
+	 * address, here size is the actual size returned by ELE
+	 * during the export operation
+	 */
+	ret = ele_service_swap(priv,
+			       imem->phyaddr,
+			       imem->size,
+			       ELE_IMEM_IMPORT);
+	if (ret) {
+		dev_err(priv->dev, "Failed to import IMEM");
+		return ret;
+	}
+
+	/* After importing IMEM, check if IMEM state is equal to 0xCA
+	 * to ensure IMEM is fully loaded and
+	 * ELE functionality can be used.
+	 */
+	ret = ele_get_info(priv, &s_info);
+	if (ret) {
+		dev_err(priv->dev, "Failed to get info from ELE.");
+		return ret;
+	}
+	imem->state = s_info.d_addn_info.imem_state;
+
+	if (s_info.d_addn_info.imem_state == ELE_IMEM_STATE_OK)
+		dev_info(priv->dev, "Successfully restored IMEM.");
+	else
+		dev_err(priv->dev, "Failed to restore IMEM.");
+
+	return ret;
+}
diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
new file mode 100644
index 000000000000..c95e45123b5b
--- /dev/null
+++ b/drivers/firmware/imx/ele_common.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef __ELE_COMMON_H__
+#define __ELE_COMMON_H__
+
+#include "se_ctrl.h"
+
+#define ELE_SUCCESS_IND			0xD6
+
+#define IMX_ELE_FW_DIR                 "imx/ele/"
+
+u32 se_add_msg_chksum(u32 *msg, u32 msg_len);
+int ele_msg_rcv(struct se_if_priv *priv,
+		struct se_clbk_handle *se_clbk_hdl);
+int ele_msg_send(struct se_if_priv *priv,
+		 void *tx_msg,
+		 int tx_msg_sz);
+int ele_msg_send_rcv(struct se_if_priv *priv,
+		     void *tx_msg,
+		     int tx_msg_sz,
+		     void *rx_msg,
+		     int exp_rx_msg_sz);
+void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg);
+int se_val_rsp_hdr_n_status(struct se_if_priv *priv,
+			    struct se_api_msg *msg,
+			    u8 msg_id,
+			    u8 sz,
+			    bool is_base_api);
+
+/* Fill a command message header with a given command ID and length in bytes. */
+static inline int se_fill_cmd_msg_hdr(struct se_if_priv *priv,
+				      struct se_msg_hdr *hdr,
+				      u8 cmd, u32 len,
+				      bool is_base_api)
+{
+	hdr->tag = priv->if_defs->cmd_tag;
+	hdr->ver = (is_base_api) ? priv->if_defs->base_api_ver : priv->if_defs->fw_api_ver;
+	hdr->command = cmd;
+	hdr->size = len >> 2;
+
+	return 0;
+}
+
+int se_save_imem_state(struct se_if_priv *priv, struct se_imem_buf *imem);
+int se_restore_imem_state(struct se_if_priv *priv, struct se_imem_buf *imem);
+
+#endif /*__ELE_COMMON_H__ */
diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
new file mode 100644
index 000000000000..be381980fec0
--- /dev/null
+++ b/drivers/firmware/imx/se_ctrl.c
@@ -0,0 +1,402 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/firmware.h>
+#include <linux/firmware/imx/se_api.h>
+#include <linux/genalloc.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/miscdevice.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/sys_soc.h>
+
+#include "ele_base_msg.h"
+#include "ele_common.h"
+#include "se_ctrl.h"
+
+#define MAX_SOC_INFO_DATA_SZ		256
+#define MBOX_TX_NAME			"tx"
+#define MBOX_RX_NAME			"rx"
+#define SE_TYPE_STR_HSM			"hsm"
+#define SE_TYPE_ID_HSM			0x2
+
+struct se_fw_img_name {
+	const u8 *prim_fw_nm_in_rfs;
+	const u8 *seco_fw_nm_in_rfs;
+};
+
+struct se_fw_load_info {
+	const struct se_fw_img_name *se_fw_img_nm;
+	bool is_fw_tobe_loaded;
+	bool imem_mgmt;
+	struct se_imem_buf imem;
+};
+
+struct se_var_info {
+	u16 soc_rev;
+	struct se_fw_load_info load_fw;
+};
+
+/* contains fixed information */
+struct se_soc_info {
+	const u16 soc_id;
+	const bool soc_register;
+	const struct se_fw_img_name se_fw_img_nm;
+};
+
+struct se_if_node {
+	struct se_soc_info *se_info;
+	u8 *pool_name;
+	bool reserved_dma_ranges;
+	struct se_if_defines if_defs;
+};
+
+/* common for all the SoC. */
+static struct se_var_info var_se_info;
+
+static struct se_soc_info se_imx8ulp_info = {
+	.soc_id = SOC_ID_OF_IMX8ULP,
+	.soc_register = true,
+	.se_fw_img_nm = {
+		.prim_fw_nm_in_rfs = IMX_ELE_FW_DIR
+			"mx8ulpa2-ahab-container.img",
+		.seco_fw_nm_in_rfs = IMX_ELE_FW_DIR
+			"mx8ulpa2ext-ahab-container.img",
+	},
+};
+
+static struct se_if_node imx8ulp_se_ele_hsm = {
+	.se_info = &se_imx8ulp_info,
+	.pool_name = "sram",
+	.reserved_dma_ranges = true,
+	.if_defs = {
+		.se_if_type = SE_TYPE_ID_HSM,
+		.se_instance_id = 0,
+		.cmd_tag = 0x17,
+		.rsp_tag = 0xe1,
+		.success_tag = ELE_SUCCESS_IND,
+		.base_api_ver = MESSAGING_VERSION_6,
+		.fw_api_ver = MESSAGING_VERSION_7,
+	},
+};
+
+static struct se_soc_info se_imx93_info = {
+	.soc_id = SOC_ID_OF_IMX93,
+};
+
+static struct se_if_node imx93_se_ele_hsm = {
+	.se_info = &se_imx93_info,
+	.reserved_dma_ranges = true,
+	.if_defs = {
+		.se_if_type = SE_TYPE_ID_HSM,
+		.se_instance_id = 0,
+		.cmd_tag = 0x17,
+		.rsp_tag = 0xe1,
+		.success_tag = ELE_SUCCESS_IND,
+		.base_api_ver = MESSAGING_VERSION_6,
+		.fw_api_ver = MESSAGING_VERSION_7,
+	},
+};
+
+static const struct of_device_id se_match[] = {
+	{ .compatible = "fsl,imx8ulp-se-ele-hsm", .data = &imx8ulp_se_ele_hsm},
+	{ .compatible = "fsl,imx93-se-ele-hsm", .data = &imx93_se_ele_hsm},
+	{},
+};
+
+static struct se_fw_load_info *get_load_fw_instance(struct se_if_priv *priv)
+{
+	return &var_se_info.load_fw;
+}
+
+static int get_se_soc_info(struct se_if_priv *priv, const struct se_soc_info *se_info)
+{
+	struct se_fw_load_info *load_fw = get_load_fw_instance(priv);
+	struct soc_device_attribute *attr;
+	u8 data[MAX_SOC_INFO_DATA_SZ];
+	struct ele_dev_info *s_info;
+	struct soc_device *sdev;
+	int err = 0;
+
+	/* This function should be called once.
+	 * Check if the se_soc_rev is zero to continue.
+	 */
+	if (var_se_info.soc_rev)
+		return err;
+
+	err = ele_fetch_soc_info(priv, &data);
+	if (err < 0)
+		return dev_err_probe(priv->dev, err, "Failed to fetch SoC Info.");
+	s_info = (void *)data;
+	var_se_info.soc_rev = s_info->d_info.soc_rev;
+	load_fw->imem.state = s_info->d_addn_info.imem_state;
+
+	if (!se_info->soc_register)
+		return 0;
+
+	attr = devm_kzalloc(priv->dev, sizeof(*attr), GFP_KERNEL);
+	if (!attr)
+		return -ENOMEM;
+
+	if (FIELD_GET(DEV_GETINFO_MIN_VER_MASK, var_se_info.soc_rev))
+		attr->revision = devm_kasprintf(priv->dev, GFP_KERNEL, "%x.%x",
+						FIELD_GET(DEV_GETINFO_MIN_VER_MASK,
+							  var_se_info.soc_rev),
+						FIELD_GET(DEV_GETINFO_MAJ_VER_MASK,
+							  var_se_info.soc_rev));
+	else
+		attr->revision = devm_kasprintf(priv->dev, GFP_KERNEL, "%x",
+						FIELD_GET(DEV_GETINFO_MAJ_VER_MASK,
+							  var_se_info.soc_rev));
+
+	switch (se_info->soc_id) {
+	case SOC_ID_OF_IMX8ULP:
+		attr->soc_id = "i.MX8ULP";
+		break;
+	case SOC_ID_OF_IMX93:
+		attr->soc_id = "i.MX93";
+		break;
+	}
+
+	err = of_property_read_string(of_root, "model",
+				      &attr->machine);
+	if (err)
+		return -EINVAL;
+
+	attr->family = "Freescale i.MX";
+
+	attr->serial_number = devm_kasprintf(priv->dev,
+					     GFP_KERNEL, "%016llX",
+					     GET_SERIAL_NUM_FROM_UID(s_info->d_info.uid,
+								     MAX_UID_SIZE >> 2));
+
+	sdev = soc_device_register(attr);
+	if (IS_ERR(sdev))
+		return PTR_ERR(sdev);
+
+	return 0;
+}
+
+/* interface for managed res to free a mailbox channel */
+static void if_mbox_free_channel(void *mbox_chan)
+{
+	mbox_free_channel(mbox_chan);
+}
+
+static int se_if_request_channel(struct device *dev,
+				 struct mbox_chan **chan,
+				 struct mbox_client *cl,
+				 const char *name)
+{
+	struct mbox_chan *t_chan;
+	int ret = 0;
+
+	t_chan = mbox_request_channel_byname(cl, name);
+	if (IS_ERR(t_chan))
+		return dev_err_probe(dev, PTR_ERR(t_chan),
+				     "Failed to request %s channel.", name);
+
+	ret = devm_add_action_or_reset(dev, if_mbox_free_channel, t_chan);
+	if (ret)
+		return dev_err_probe(dev, -EPERM,
+				     "Failed to add-action for removal of mbox: %s\n",
+				     name);
+	*chan = t_chan;
+
+	return ret;
+}
+
+static void se_if_probe_cleanup(void *plat_dev)
+{
+	struct platform_device *pdev = plat_dev;
+	struct se_fw_load_info *load_fw;
+	struct device *dev = &pdev->dev;
+	struct se_if_priv *priv;
+
+	priv = dev_get_drvdata(dev);
+	load_fw = get_load_fw_instance(priv);
+
+	/* In se_if_request_channel(), passed the clean-up functional
+	 * pointer reference as action to devm_add_action_or_reset().
+	 * No need to free the mbox channels here.
+	 */
+
+	/* free the buffer in se remove, previously allocated
+	 * in se probe to store encrypted IMEM
+	 */
+	if (load_fw && load_fw->imem.buf) {
+		dmam_free_coherent(dev,
+				   ELE_IMEM_SIZE,
+				   load_fw->imem.buf,
+				   load_fw->imem.phyaddr);
+		load_fw->imem.buf = NULL;
+	}
+
+	/* No need to check, if reserved memory is allocated
+	 * before calling for its release. Or clearing the
+	 * un-set bit.
+	 */
+	of_reserved_mem_device_release(dev);
+}
+
+static int se_if_probe(struct platform_device *pdev)
+{
+	const struct se_soc_info *se_info;
+	const struct se_if_node *if_node;
+	struct se_fw_load_info *load_fw;
+	struct device *dev = &pdev->dev;
+	struct se_if_priv *priv;
+	int ret;
+
+	if_node = device_get_match_data(dev);
+	if (!if_node)
+		return -EINVAL;
+
+	se_info = if_node->se_info;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->if_defs = &if_node->if_defs;
+	dev_set_drvdata(dev, priv);
+
+	ret = devm_add_action_or_reset(dev, se_if_probe_cleanup, pdev);
+	if (ret)
+		return ret;
+
+	/* Mailbox client configuration */
+	priv->se_mb_cl.dev		= dev;
+	priv->se_mb_cl.tx_block		= false;
+	priv->se_mb_cl.knows_txdone	= true;
+	priv->se_mb_cl.rx_callback	= se_if_rx_callback;
+
+	ret = se_if_request_channel(dev, &priv->tx_chan,
+				    &priv->se_mb_cl, MBOX_TX_NAME);
+	if (ret)
+		return ret;
+
+	ret = se_if_request_channel(dev, &priv->rx_chan,
+				    &priv->se_mb_cl, MBOX_RX_NAME);
+	if (ret)
+		return ret;
+
+	mutex_init(&priv->se_if_cmd_lock);
+
+	init_completion(&priv->waiting_rsp_clbk_hdl.done);
+	init_completion(&priv->cmd_receiver_clbk_hdl.done);
+
+	if (if_node->pool_name) {
+		priv->mem_pool = of_gen_pool_get(dev->of_node,
+						 if_node->pool_name, 0);
+		if (!priv->mem_pool)
+			return dev_err_probe(dev, -ENOMEM,
+					     "Unable to get sram pool = %s.",
+					     if_node->pool_name);
+	}
+
+	if (if_node->reserved_dma_ranges) {
+		ret = of_reserved_mem_device_init(dev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					    "Failed to init reserved memory region.");
+	}
+
+	if (if_node->if_defs.se_if_type == SE_TYPE_ID_HSM) {
+		ret = get_se_soc_info(priv, se_info);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to fetch SoC Info.");
+	}
+
+	/* By default, there is no pending FW to be loaded.*/
+	if (se_info->se_fw_img_nm.prim_fw_nm_in_rfs ||
+	    se_info->se_fw_img_nm.seco_fw_nm_in_rfs) {
+		load_fw = get_load_fw_instance(priv);
+		load_fw->se_fw_img_nm = &se_info->se_fw_img_nm;
+		load_fw->is_fw_tobe_loaded = true;
+
+		if (se_info->se_fw_img_nm.prim_fw_nm_in_rfs) {
+			/* allocate buffer where SE store encrypted IMEM */
+			load_fw->imem.buf = dmam_alloc_coherent(priv->dev, ELE_IMEM_SIZE,
+								&load_fw->imem.phyaddr,
+								GFP_KERNEL);
+			if (!load_fw->imem.buf)
+				return dev_err_probe(dev, -ENOMEM,
+						     "dmam-alloc-failed: To store encr-IMEM.");
+			load_fw->imem_mgmt = true;
+		}
+	}
+	dev_info(dev, "i.MX secure-enclave: %s%d interface to firmware, configured.",
+		 SE_TYPE_STR_HSM,
+		 priv->if_defs->se_instance_id);
+
+	return ret;
+}
+
+static void se_if_remove(struct platform_device *pdev)
+{
+	se_if_probe_cleanup(pdev);
+}
+
+static int se_suspend(struct device *dev)
+{
+	struct se_if_priv *priv = dev_get_drvdata(dev);
+	struct se_fw_load_info *load_fw;
+	int ret = 0;
+
+	load_fw = get_load_fw_instance(priv);
+
+	if (load_fw->imem_mgmt)
+		ret = se_save_imem_state(priv, &load_fw->imem);
+
+	return ret;
+}
+
+static int se_resume(struct device *dev)
+{
+	struct se_if_priv *priv = dev_get_drvdata(dev);
+	struct se_fw_load_info *load_fw;
+
+	load_fw = get_load_fw_instance(priv);
+
+	if (load_fw->imem_mgmt)
+		se_restore_imem_state(priv, &load_fw->imem);
+
+	return 0;
+}
+
+static const struct dev_pm_ops se_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(se_suspend, se_resume)
+};
+
+static struct platform_driver se_driver = {
+	.driver = {
+		.name = "fsl-se",
+		.of_match_table = se_match,
+		.pm = &se_pm,
+	},
+	.probe = se_if_probe,
+	.remove = se_if_remove,
+};
+MODULE_DEVICE_TABLE(of, se_match);
+
+module_platform_driver(se_driver);
+MODULE_AUTHOR("Pankaj Gupta <pankaj.gupta@nxp.com>");
+MODULE_DESCRIPTION("iMX Secure Enclave Driver.");
+MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
new file mode 100644
index 000000000000..177623f3890e
--- /dev/null
+++ b/drivers/firmware/imx/se_ctrl.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef SE_MU_H
+#define SE_MU_H
+
+#include <linux/miscdevice.h>
+#include <linux/semaphore.h>
+#include <linux/mailbox_client.h>
+
+#define MAX_FW_LOAD_RETRIES		50
+#define SE_MSG_WORD_SZ			0x4
+
+#define RES_STATUS(x)			FIELD_GET(0x000000ff, x)
+#define MAX_NVM_MSG_LEN			(256)
+#define MESSAGING_VERSION_6		0x6
+#define MESSAGING_VERSION_7		0x7
+
+struct se_clbk_handle {
+	struct completion done;
+	bool signal_rcvd;
+	u32 rx_msg_sz;
+	/* Assignment of the rx_msg buffer to held till the
+	 * received content as part callback function, is copied.
+	 */
+	struct se_api_msg *rx_msg;
+};
+
+struct se_imem_buf {
+	u8 *buf;
+	phys_addr_t phyaddr;
+	u32 size;
+	u32 state;
+};
+
+/* Header of the messages exchange with the EdgeLock Enclave */
+struct se_msg_hdr {
+	u8 ver;
+	u8 size;
+	u8 command;
+	u8 tag;
+}  __packed;
+
+#define SE_MU_HDR_SZ	4
+
+struct se_api_msg {
+	struct se_msg_hdr header;
+	u32 data[];
+};
+
+struct se_if_defines {
+	const u8 se_if_type;
+	const u8 se_instance_id;
+	u8 cmd_tag;
+	u8 rsp_tag;
+	u8 success_tag;
+	u8 base_api_ver;
+	u8 fw_api_ver;
+};
+
+struct se_if_priv {
+	struct device *dev;
+
+	struct se_clbk_handle cmd_receiver_clbk_hdl;
+	/* Update to the waiting_rsp_dev, to be protected
+	 * under se_if_cmd_lock.
+	 */
+	struct se_clbk_handle waiting_rsp_clbk_hdl;
+	/*
+	 * prevent new command to be sent on the se interface while previous
+	 * command is still processing. (response is awaited)
+	 */
+	struct mutex se_if_cmd_lock;
+
+	struct mbox_client se_mb_cl;
+	struct mbox_chan *tx_chan, *rx_chan;
+
+	struct gen_pool *mem_pool;
+	const struct se_if_defines *if_defs;
+};
+
+#endif
diff --git a/include/linux/firmware/imx/se_api.h b/include/linux/firmware/imx/se_api.h
new file mode 100644
index 000000000000..b1c4c9115d7b
--- /dev/null
+++ b/include/linux/firmware/imx/se_api.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef __SE_API_H__
+#define __SE_API_H__
+
+#include <linux/types.h>
+
+#define SOC_ID_OF_IMX8ULP		0x084d
+#define SOC_ID_OF_IMX93			0x9300
+
+#endif /* __SE_API_H__ */

-- 
2.43.0


