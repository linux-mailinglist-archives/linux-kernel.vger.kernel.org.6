Return-Path: <linux-kernel+bounces-266311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0356B93FDFE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795E41F2322B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34FB18D4B6;
	Mon, 29 Jul 2024 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bAIiX0L+"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC4918785A;
	Mon, 29 Jul 2024 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279617; cv=fail; b=lvKLHsNy67SR02IqDB8uEdnvKVs41/7zhRcCoc+4wuD83aTdsJvc1Qq45xjwMz/WdkdVxLwQsjbYPsy4EtHkdg3jgNAOxSSHko6Qbhtoe8+ZicxeK/hO3Ostf5tQb7DpCL6W3ZoHl2b93R9ZsJzWLeiowGL73FwMhAOP5ihDNb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279617; c=relaxed/simple;
	bh=vPCvA6jCIt6F2Mk6bIddyM/ak3NsIeXlck/eNAHfWPI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=s0wNCwcATYRBShMroFLZEKGe/8h3Nj7Zva1dC3MvO5NnxTKFtsNdQ0f1bLbebNWRblM7ops559n6TOWl8nlnIkQA0iMJFRFfE0CcJyA4f7c65Mdz2vEYrOGU4d6ijtHcvJR11gQHUFeCjiVKiECjXNp/WQKRDEJeeUzFb6tdmcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bAIiX0L+; arc=fail smtp.client-ip=40.107.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBOcdwlgXs1tMbDsw82qwZbzaka0gBH6wziuHW6o91euqcfRXNeGYQ7KWiFKR9irRnV88CIoEswvm5X2U91vEZx8d7IBaKxvxTK1ZP02kEylCLEU+ZFQIgfd8/LUqZeeCLZn46gShmcejdLIxqN8aOcU4Lncl1RjT3Wb+TDVpHGmSwlb1R8Isd5G+Wx3ejCEDJAOpHJRZ7qW1cOg8AAFRosn2KAkt9X3aYeIzoHTUxyN24ciWziFz3aJp0eYEbEAU+mKrXD8eoGcwNOW+97Td7ey68qXipkHmYqz9FBMLhK80nmAz/UpRbyvNNhIpjzsC1Kc87COJmO/QRMLdFYPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvTPpgnQHa+b9UGNSwUdW1DeRZzCp6t4DALMvlh6Iuk=;
 b=nz550O1ryfaSWJnCRsQDWgkZHeuUMM705SgVwDezB2Y1S0A4I1uAySN4EWlFG27CWWNnT/0afLjlnJJ2oqVuXwfYs422UIMqPrrucQNz1dw+mgRLk4KYuST1GmpJthnNmlJAJTlXldSogCWPpYAxCR4Dbu0NfHlrZZDqmdnOW05bOQelJKV1tln7jOTu2VgChP5z0POdmgbAXf4EhcX+mgIZU+xVDRrggBiW/HvWsUW62LmBvNZ0bDs1HA1V7LnS8haO1yvpsrFcNlrzYWw550rPFlWaoyvDqUxdeBsWMKaicNLXdfAEgOkckYvsJBuZgzJgEERMD8KtSnRmDrP/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvTPpgnQHa+b9UGNSwUdW1DeRZzCp6t4DALMvlh6Iuk=;
 b=bAIiX0L+tLHdKOOW1M9cKmVlOouSpg4tneaA9vxf6IcKpuVRHfgzmZUTBivOpPIN28TIyAA56zNUv1gk1gN1YzzR3sqUR1/jVrvO/jQCNPPqPwF4TCOhrbLte6v3STCKi6yCd1QZADSsQYj0L4M+wOfKJOERfUpwMeM++GCKzHjye2MMDBjPWdc0QkAEeKDenfJp51oiqO0TgJUpc0L2UD/b3sw99qbETMCAF0DRbFR6LAIU33zEb9Sai3PR21hEaOCq+0OrQ3Bta4i1/mWGkr22kP6kTvwMOErPpp0fZn9FAxJK6aRfwQbiF0vfnTl48QyzcDAfhLzR2Zzd1W6bfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9590.eurprd04.prod.outlook.com (2603:10a6:102:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 19:00:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 19:00:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Jul 2024 14:59:31 -0400
Subject: [PATCH v2 09/10] arm64: dts: layerscape: remove undocumented
 fsl,ls-pcie-ep
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-ls_warning_all-v2-9-942d80ddd441@nxp.com>
References: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
In-Reply-To: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722279587; l=2955;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=vPCvA6jCIt6F2Mk6bIddyM/ak3NsIeXlck/eNAHfWPI=;
 b=mw3DORk0f86tYR3aaqDGNkOpl07HP65a9tahochI/3u9elCjwNnnI+JvFjpaj5y2G82Z9hdHc
 ibTrbUtqsxbBUfQCOjGvBpi4EKjmQV6Rx4VwrYIMau7Eg/vttLuYiOI
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9590:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a1441f5-30c7-450b-b890-08dcb000ac31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ri9TSnY1Z1FjY1JjY3JCdkJIa1hUdUJiTWxvSmtZMTVmNFBDaTJrbHlLNHpz?=
 =?utf-8?B?WS9HYW95TUJsOUswY3BlbzYxWE9Rd3phZmFFcUl3R0pEamFtN3BpMkhodDRD?=
 =?utf-8?B?ZTRrbndHRCtwZnRTNWZkUjdNT2YrUUlBVWlYUVpwZGZWQ1R4VTZSSVBmVENM?=
 =?utf-8?B?TUt4V0Z0ekdkTExrRmYrVjNRY0ViUGMreDRDTkhDNkpkMXVQQlVGRmw2eHB0?=
 =?utf-8?B?ejYzNTZWdGxpaDZ1UXh4amNGQncybmpsMmpKMndRY0o5Rmx2cWdFSlhwcGRu?=
 =?utf-8?B?M0xIMWFYRGJjd2ZFR0VTWFo5Mm9Td1g1ZGRMenc4TmYweGtiU1Vxb0VjUEta?=
 =?utf-8?B?ZW9TRndERWkzY1NYZzhaaFBDTXZpOG9VMUlVNWNxZVZ2Rks4ZG91NFNneEMy?=
 =?utf-8?B?ekt5MmlPYlU5aWhJR1FZNTQvZXBvK2NyWU44aUFmcVFNZlZxNGViVmhYUi9s?=
 =?utf-8?B?S3pFdUFPckpaNEpnMmxSNTVxY3Q0US9MbHJPdit4UWY4Ym4yOG9MU1pqSVJQ?=
 =?utf-8?B?c2ZiRmVaM0RMYWJaS1gxUkN3ME5xYkFsdHU0VWsveHhkMDcwSDVUOWNWbmFL?=
 =?utf-8?B?LzIzMVlOd3ZWMzY3UHZxU3ZsdXlmbms3WXJpQ2dJbjIvUldGU1UvTFFUWkVq?=
 =?utf-8?B?ZCtVaDdKSVFxc2xuZ1JjUmhxdTVXTi94dmlwamxiSkxsK2FhS0tGV3gzaHAw?=
 =?utf-8?B?TjJKYVpiWktpczVibS9pVWpYYm9jRlJRdExGZ1BwOGZXWW1vQjNROXhVamdn?=
 =?utf-8?B?bnlGeSt5U1NGcVF0L0Mzdk5QWDVKRVNRK250ODM1NkVPRzVUNGVtbDI3dndh?=
 =?utf-8?B?YzVNYjhmMzFZZFBadmdGQ3pnQjYyazZwaU1xMmdXWDBSYXM4WHh5Q2N3Uks0?=
 =?utf-8?B?Y2JjQldFOVpla2VKWisyc3dncTg5VWJjdUtheklVRjR6Y0VBbk9TMTFMWHdB?=
 =?utf-8?B?NFdZRTZlbGJYU09SMTYza2hPMWdTL0luc1h6dzI5ZERxRTFQeHg2QjJwVkVI?=
 =?utf-8?B?M0JLaGJyOTFlS09MMGRWLzJ3aE9WMEJBSmg5TGs5RGlWY0lqWGMwQTE4RWdH?=
 =?utf-8?B?YlJCWE5MdHZnNEI3RHQxckpWMVN3MCtldEtLUis4VFN5WUF2cDlkajZNZVl0?=
 =?utf-8?B?bjZVSG5rc1JrWFlpZytzWXJOcTRTWHBMOFdZT3F3b2wrWk9uVURqZzQ5NjFz?=
 =?utf-8?B?bUc2TGZ0NGJiN3pQVy9PQWlzY1hQc0ZyWjc4NHE3eTRlM0ZIdlMrclp0TzZ5?=
 =?utf-8?B?MHZRSDQzYkh5N3JXYTVpV3lxVmJYSVVlRld3UUh1OXJKWEJvZm1rMlA0cHRX?=
 =?utf-8?B?SE1UYURjTnpxUy9jSEFpa3RIVTA5bi9xQ2VOMElzZnI3Yk9zUzZFclFsMjg3?=
 =?utf-8?B?dEhPa2V6T2xaVDJueXNLSlpGMXo3YzRQdDExcVc3NURXZ0pRMzRQU0FHTXJ3?=
 =?utf-8?B?SEZ4bkxMeWVsQWZpR3MxMnh6bDV5VlQrY1F1WG9BdmdvV0NUYi9adkhxWmVj?=
 =?utf-8?B?V1RHdUIxMVFqOTFoUmdJTGJSRkgrYXRzV3lZWlNDUUtRZDdaNzlwRlZMaHpP?=
 =?utf-8?B?eU8xTTJnN2x6SXVtdUhxb0taSHdnZTdBL1A0V1YwZlljaWh6d3lCVEFDSnJ0?=
 =?utf-8?B?T05VVU05RVpiSmwrZG5PNitNTlVsdHdscHBvamtvUGxJVFhqeHBYL1NteFdj?=
 =?utf-8?B?VS9LbjRqS0V0YUJqSk1OK2tTOVhCMlJWRVBIN3lzcURMekhyc09JdFk1SUFu?=
 =?utf-8?B?UVpCajFoRExGdW8yS0g5Y3hDMkRNVTJuVStIeGc2U29LcDBqYUFHN3dZWVRp?=
 =?utf-8?Q?DfInHej5tudzmUYfdUAbtqQOWmbiVvoRAKEqw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEV3UnpGRFhoOHlrN3pGS3dhUGtxbHNzSEhZMXRYcnNielhSY3dEdk5rOU5C?=
 =?utf-8?B?bjJncjRrbEx0MGhsejJNVjB1RG53eWNlVlFhaDNQd0REWWVxVGxJUGhLd2NZ?=
 =?utf-8?B?dDJZSEZET0M5Qy9PN05oYThoWkhGZGJJWkFpbVhMaEhjZ29hckZvK2JicDNQ?=
 =?utf-8?B?bXlodUpXdEQ4R29yQzBkelMwQVIyWGlxM0I2enRvL2t6eFNRTmI1QnBBRHFM?=
 =?utf-8?B?MHZ3UG1tQitXb0ZhZkxDVGR2aHlKWUp3cXZlbHp5ZWx6d3VqVEJEWlBwMGkr?=
 =?utf-8?B?dm1OV0txVEdtTkRwL2ZURHA5ZEM0STVnTThydE8ycXhENHNkYjQxMGFuYnJu?=
 =?utf-8?B?b044UmtjdzhFUFFFT2dsYWFQeWt5Q3p6aHFxRzZzOG5LZUpWTUFHb01zNEVK?=
 =?utf-8?B?RDZwRWRmL0V6VnNXaWhQWGNqaTd1V2lvN01FZ2RocUp5aE5ESGZXb3ROQ3dU?=
 =?utf-8?B?K05aRXYwdlBwSU5IWFRIeWVaQThjYVMzdXNCbTdJbktvWUUwZkJhOGRjRnRB?=
 =?utf-8?B?dFF4cGxRaFl1THNtVmVjbEdhUER2VjNYbHBPTHZpUW8veVBSV3R6TDBSUUY1?=
 =?utf-8?B?eVRYTjlOSzJld3QxUG9OQ2VLcUhRd0pLTFE5aGFMZGN1MVBpYk9meHVpY2E5?=
 =?utf-8?B?UE40dTBmNFJ1cmpQam9jRHU4Tk9nc20wK2FiZmMzM3hPK1VSVjAvVWljQmdu?=
 =?utf-8?B?QjlJREJJTUFPVmEvQ3hROEpVSmlpam9iNjQzdnkwSVZsSW9BdFRaWHhxRTVK?=
 =?utf-8?B?VjE2Uy8wcThQS1J0eG5ITXpSL0hEbGk1eGhrQTZ3K1g4cGF2VGYzZ09tR3pO?=
 =?utf-8?B?QXFCNTFZOWZENUQ0QmNGMFhwWmdxR0JBd1ptem0xWm1TTXZsVlJqVG1TVXVz?=
 =?utf-8?B?QzQ2UHZNdWRhOGFZU2ZpRk1JWlg3dWYrcDlkSmRvWVNwUnFEcmRza01UbDEw?=
 =?utf-8?B?VCsyempVQUxKa1F6QWxwdGorOU5KQmdFT3ZQMnpLaDdxaWlIV0lnVUJFckdT?=
 =?utf-8?B?SHRCWXQ0elNkdmI1QktPUzRvTzl3YThXMkgwSUVIMGhZZFZadkRWYnpPdnd2?=
 =?utf-8?B?WHI2azZFV0lHd2czMEg3SE9tNVFUMHJSV0JvTEtjTmdwbmZKbGp5SjFNalBR?=
 =?utf-8?B?ZzFZYi94WE4rbkEyekJhN2Q0Z1dHdFk2RGFiRWYzNzVRV1FySGFYb3hjN0pi?=
 =?utf-8?B?YkNaUDJ3RmtYQ0QzQzVTL2tnTTQ0cURNVkk4SGhodmw5SklhbTlzUnNKbzhy?=
 =?utf-8?B?QlA1QTFqQmgzQmFJNkt5dHRiOE9TT0FFQTVxU0M3ZFJ4dnowSW04S2hNOWJw?=
 =?utf-8?B?a01jTld2bEVZSHl3RGtBVzlQeGk3MFpqYTNjVmJ3SVUwWDhOOWYrb0hYaG1k?=
 =?utf-8?B?NEZaaS82bGJQMnNzekVabzZGdEVhdktzZllieEs1ZVR1VmRwMXFMUElNQUh5?=
 =?utf-8?B?ZGsxY3czNnAzWC9iMWZpYThtZlYvMnFTTnlJNm9VV2Flem5PaHdTUEVzWXJY?=
 =?utf-8?B?MDIxeEZQSElxR1ZZRHljdDBIaDRyeVlkMVVyaGdtRGk4YnlYNjJGWVlyeGZN?=
 =?utf-8?B?NjZrTE0xTDY3TERJZmZCWXFXMkFrd2h6cGVySFV6WHZwdUpvbGdyOWlUd2pR?=
 =?utf-8?B?ZHFqRHc0N2VkT0YzQS80djFwTlA3VTFrOUtIUTVjWUpqV0NFSm1QS0tSczZp?=
 =?utf-8?B?d2hjNE51QmFWeE1qVWtZTExzOW5wYk1jTS8wRGtucjFhaXVrK082SExQeTF5?=
 =?utf-8?B?MUtzNmFkY3NJd1pzMGhhYi9QRmR6dmV1a1RMOGQvZlFJQkxSQkxIenhDMHdp?=
 =?utf-8?B?UHRxcTlqenJxZHBWOXgwK1FNNTFuZmdFaldzeFNJYXZWYzZiRUpuUjlUZXBV?=
 =?utf-8?B?clJDcGdBTitaZyt6T2dITnFGUjY1eTV0NndEeGhQZDZMU0d2NDZOaGYwU2pB?=
 =?utf-8?B?ZGpPQ1NCRzFlQU1aeU56aEVHaFc2TU1ndUN1Ti9zOWVUK040TjNOcXZZeTBJ?=
 =?utf-8?B?S3IybnBMMnpSTHpDRVBGODNIUCt0TEdoNnRnVWI0MUlueEdTRHJCNWtielFU?=
 =?utf-8?B?ZSszcFMzMGtrQkVhZFM5U1BFTk5ZaXFNd3pDZDMzbktJSUZQdnY3RUViNzRB?=
 =?utf-8?Q?XoM3XThpSWobDD0y5QqiB8xte?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1441f5-30c7-450b-b890-08dcb000ac31
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 19:00:11.5745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bmVbOXLFu+yClLqjy+SF26VNEnuzf5j81+ETJIefznvoO34EzIpBTX/fn+k4wgXcV+v1g9dkzzlPI59gWhQUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9590

Remove undocumented compatible string fsl,ls-pcie-ep to fix below
CHECK_DTBS warning.
arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: pcie_ep@3400000: compatible: ['fsl,ls1046a-pcie-ep', 'fsl,ls-pcie-ep'] is too long
        from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index e33c04a8ea3f9..244ed720b4246 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -820,7 +820,7 @@ pcie1: pcie@3400000 {
 		};
 
 		pcie_ep1: pcie_ep@3400000 {
-			compatible = "fsl,ls1046a-pcie-ep","fsl,ls-pcie-ep";
+			compatible = "fsl,ls1046a-pcie-ep";
 			reg = <0x00 0x03400000 0x0 0x00100000>,
 			      <0x40 0x00000000 0x8 0x00000000>;
 			reg-names = "regs", "addr_space";
@@ -859,7 +859,7 @@ pcie2: pcie@3500000 {
 		};
 
 		pcie_ep2: pcie_ep@3500000 {
-			compatible = "fsl,ls1046a-pcie-ep","fsl,ls-pcie-ep";
+			compatible = "fsl,ls1046a-pcie-ep";
 			reg = <0x00 0x03500000 0x0 0x00100000>,
 			      <0x48 0x00000000 0x8 0x00000000>;
 			reg-names = "regs", "addr_space";
@@ -898,7 +898,7 @@ pcie3: pcie@3600000 {
 		};
 
 		pcie_ep3: pcie_ep@3600000 {
-			compatible = "fsl,ls1046a-pcie-ep", "fsl,ls-pcie-ep";
+			compatible = "fsl,ls1046a-pcie-ep";
 			reg = <0x00 0x03600000 0x0 0x00100000>,
 			      <0x50 0x00000000 0x8 0x00000000>;
 			reg-names = "regs", "addr_space";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 3533779f737ab..9963fcc625a24 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -588,7 +588,7 @@ pcie1: pcie@3400000 {
 		};
 
 		pcie_ep1: pcie-ep@3400000 {
-			compatible = "fsl,ls1088a-pcie-ep", "fsl,ls-pcie-ep";
+			compatible = "fsl,ls1088a-pcie-ep";
 			reg = <0x00 0x03400000 0x0 0x00100000>,
 			      <0x20 0x00000000 0x8 0x00000000>;
 			reg-names = "regs", "addr_space";
@@ -627,7 +627,7 @@ pcie2: pcie@3500000 {
 		};
 
 		pcie_ep2: pcie-ep@3500000 {
-			compatible = "fsl,ls1088a-pcie-ep", "fsl,ls-pcie-ep";
+			compatible = "fsl,ls1088a-pcie-ep";
 			reg = <0x00 0x03500000 0x0 0x00100000>,
 			      <0x28 0x00000000 0x8 0x00000000>;
 			reg-names = "regs", "addr_space";
@@ -665,7 +665,7 @@ pcie3: pcie@3600000 {
 		};
 
 		pcie_ep3: pcie-ep@3600000 {
-			compatible = "fsl,ls1088a-pcie-ep", "fsl,ls-pcie-ep";
+			compatible = "fsl,ls1088a-pcie-ep";
 			reg = <0x00 0x03600000 0x0 0x00100000>,
 			      <0x30 0x00000000 0x8 0x00000000>;
 			reg-names = "regs", "addr_space";

-- 
2.34.1


