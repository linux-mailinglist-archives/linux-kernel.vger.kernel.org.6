Return-Path: <linux-kernel+bounces-444438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A4D9F06E1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1175163B0A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FFA1ABED7;
	Fri, 13 Dec 2024 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="i9fLKSzd"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021138.outbound.protection.outlook.com [52.101.62.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5F71A0AF7
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079612; cv=fail; b=R+Ju5cvagIX0AB+yersrvkZwk/go1uBem+ubmGxv+EedHVpHVHTOzkiIqCoVJ31jxJbiJkEYgqJELKz2Uc+OaY+AHkIgz3ZjrOdnLuxXEq4Jk36tVBOvsPTLFqp4lRKqEX699eMzRkW2oN+r01qSLpZfizX66cqCVkBR0k/oXH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079612; c=relaxed/simple;
	bh=pxQPeUEepmPldgD+L3CiUhkjWTBjjghNyXNQiUiREmw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G3PYRXPM8GjJjqxU+Qsy1DLa84WsFpHyv3eGq/C4LoPdSrjmW239PooR3gccpeiDdcrNMVNVDXBp4IIe1gXb1pZUe576vH2VoAyH9qq+Y/t3zbNRFWIpCx+wwdtk/oPOBOEAIFTSi8AgDXI7dEu8S7eEvrUZaUhrBE43e5RKL+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=i9fLKSzd reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.62.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njIjOOBEKR3pdYr+f4O4VoAfjlt/5FhgbE9grIMfpIY4YHem0sCLKQEUnWHb6Ss+nSHZ2Y7WUi0ZoGCtFQWn1NFpu1LPaekg11s0gdjMySSOeZIrdPf+3Lmyvz9A9lN7cakuczu6fyjNtyaH4qQeSlyA0UkRUMo8+6bI56IKbfJqB8Spw77gb5Yy3+SN/TJDRGZYf53LG3ry2U85yCFH0fFpmyENL5EFUJxoMzTEM33YMFV8lZroctjuXY48hfe+HwnTi6nVkgmMUjx+RpJWXDjxcgmNr6vYcS4sAtlT7G5+qBKDUQGfaxP2nvgCuhckzeyArUuoFLBGJluiWnJxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWuIYaGldRDGFHrYQYg9byCjicYh/6v7Vy181xyPuxI=;
 b=jhoPq1Uvk/nJJiuYaAiFx+PkcwBZaJ/cwBIYMxrgjcm9K27Fckcqcypn6chMx6LYW5y2IyVL9tW3ExJZ+pDnV0M46lPaaEDm1WT3BvDcHgyWcnu3oVxlfspm3zzopGqjLqBz2EOc/o0sCG/maF/y9ifpexTnD/PJVsibEpWMj7RLOAiRmVo73MCNKYf5oIhb6T5cy4CoTe9vrVw5NYYjU64MkDhWaPcdx0msPWnH93U4UUb5PntO1sDMOAxmH2gFpxTZETNPVR28J9IfV8p7Wsq8MgJGHEkxOk4e13UKuH6ojYDWTeNTlmYFPUZnkHoqOzxENib+HHMrdwfyAiHScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWuIYaGldRDGFHrYQYg9byCjicYh/6v7Vy181xyPuxI=;
 b=i9fLKSzdwOksVDfLa9F2PGLqN/2DV8QAuYzADjMy6D40D1qZIG7WawTRe93l9qUYYft/mWBV2CVR2UWEjLGb0hZ2JAPuqJfO38PyPWQCHcXFs2GIpUQVwSdx//oOaX4wxZMi5wKL7HNbxVDXhaZrlzMvepnN5IA3w1Uf+wHaDaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 CH0PR01MB6812.prod.exchangelabs.com (2603:10b6:610:111::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.6; Fri, 13 Dec 2024 08:46:46 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%3]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 08:46:46 +0000
Message-ID: <56f10526-ea50-4d24-a042-d05b305e019e@amperemail.onmicrosoft.com>
Date: Fri, 13 Dec 2024 16:46:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2 fix] arm64: refactor the rodata=xxx
Content-Language: en-GB
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org, anshuman.khandual@arm.com, corbet@lwn.net,
 patches@amperecomputing.com, cl@linux.com, akpm@linux-foundation.org,
 thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com,
 inux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20241212082426.4110-2-shijie@os.amperecomputing.com>
 <20241213053049.7592-1-shijie@os.amperecomputing.com>
 <CAMj1kXF=1Hr9G4ZjnEVzJ1snn0V4L-=+bMU4bn=m0UbYLyBqGA@mail.gmail.com>
 <be0d7423-ca33-416d-a410-3ff303493261@amperemail.onmicrosoft.com>
 <CAMj1kXHXeiPiksuOabp-NXu0ORmmP1Jd1wZPmgAi09jsjaDAsQ@mail.gmail.com>
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <CAMj1kXHXeiPiksuOabp-NXu0ORmmP1Jd1wZPmgAi09jsjaDAsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:3:18::21) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|CH0PR01MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: ae267659-84a0-4fa5-d25a-08dd1b52acd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VS92S0hYZzNUTmJZc1FQRU8yMW9yOFBwM1czOVo5M2tkS25vT1U5dE53eFNm?=
 =?utf-8?B?K2xMZWtrRENtNFQ0S2Qva3pjM0hvTUtjc0JNVmQ5Q0tNaG1EOGxHUTJaZ2Rr?=
 =?utf-8?B?ZTdlSWcxVW9zdHBUZEIzcHFkaC92d3VwV0I0Y3lmakdZTktEeEM3MjZ0dWhR?=
 =?utf-8?B?Y3R4OXUvdTVML2R4VUVyMmFoZ0FIU3JRR28yUUxuTGxCVFM5K2V4Mmt5dmps?=
 =?utf-8?B?V3NtL21DNzR1YWJsYWFYNTBtYjh0Zml3bjhabVdYQkcyZE1XUUtCU25MRzlj?=
 =?utf-8?B?bUsvZjBybmZHdmtPb3BlbVFRUFovUktocEV1UFdqVmtCR0RPbUN3Z044Z0c5?=
 =?utf-8?B?aGJrOVZ4WWlBbmVTMk9JNng0d0o1SHhmRWVJODJlZ1ViVGVZcnpoUHpOMTYz?=
 =?utf-8?B?T3V6YTlQUWp3WndqZFM3S00rNFo2by9KR1VnT0J1K1VXZFkwWmFsRUhkQWFi?=
 =?utf-8?B?RmVuT3ByM3lSb1JyeFIvdEdmbnIyTUUyMngva0RLU3R1Z0dzcE9zK0RDOUpk?=
 =?utf-8?B?aGhLT3BNNitmTjVGY3k1V1dxZWNlME1wekR6OUY0bVBEbStFa202SWhNQnlU?=
 =?utf-8?B?Q3FLY1FiQ2lWMmMyZVBiMzdDUVNLdW1KaHBLZzFqOXpFSUNtQ2wzVkRIajYw?=
 =?utf-8?B?RnpESFRweStCUFI5QmhLQTRibVpRcGkrYkhpeXlYTWRLVlAzODRTY0d5bDhJ?=
 =?utf-8?B?dGhZMUExVThFVm1kalB5bWUrWjdsbTJrUDBUOW0zWlBOcVdwYkVXczdZK28v?=
 =?utf-8?B?MjZIZ0Yycm5ZSzVtQitNemJ0K1FFUGhVenZERFMyNDhseHBDaFN1c3FPaG9F?=
 =?utf-8?B?SXJLVEF4NEp1SFh0NzQrazdLcHpqSk1oZVVPMm5kOWhlQ1V1WWgwZms1aVZP?=
 =?utf-8?B?cTg5a1QwRFhoeUtyMFVEcVFZWC9KRnZBSkhRS3hxck9ES2xBOWd5Vk9Ta1lq?=
 =?utf-8?B?enFPQUxiamRKUmxheU1PQS9lK0FpMDRhRTh5eW40YWZvd0xIRG5acStVWWJK?=
 =?utf-8?B?YldrNCt3T2YrVndYWC83YU9LZFRvZnNOenZ1RnFvZTJrL3h6djNhSnFMSndv?=
 =?utf-8?B?VnhsMkVZMG5XYlFucEtVQkxGWC9hWVVKT0tpdS94WDFBOXdndmgyeFMrMHpF?=
 =?utf-8?B?MTJKbTEvSkh6OUNzMHlDVHIwNlozZDFYNGVkRVJzT3NCbHA2Y0RRb1hLaVBl?=
 =?utf-8?B?b1hWTmZVWmYrK2RnU1VYMTIzcXJxTVhhc1pKcnJpbDEyVDJPUXM0M2FOaVh5?=
 =?utf-8?B?OEx6OVU2TXAvY2NTRWN4dUFUd3lBNFg4SklQZGZ1TTJiTHFSVWIzWUs0RC9H?=
 =?utf-8?B?VTNsQlNnQk9kNGlxSTh2U2dSc01LR2FjUDN2VU1CenFxcXRGaUpBZzBDaEVZ?=
 =?utf-8?B?bHNlVDR3WkI2M1czc256MjNwVHJiOEE3c2l6UDhxTjFCYzhxSEFrbzlzY2xw?=
 =?utf-8?B?ZWk0VzNmOUZwS09XOU04Y0NOcDJ2TThJZ1gvdGg0ZlYwLzRxZWkyRWZNL01O?=
 =?utf-8?B?VU5oSENuUHl6U01XUFBwa2pkaURmS1dLZlpOaHYrVFVmZWJRdVFoNnE5ZG1m?=
 =?utf-8?B?WkdOaGk5eEdhQXNhL0FFZHEzL1NYeElwV09hUVdRcTlhY1grb05YWGxmdm5B?=
 =?utf-8?B?azBHS2w3cUgzTi9Obk0zam04SFpzNDYvbmJXK09reHRCWjU1Z0ZBamlFMm4r?=
 =?utf-8?B?WGU3NGNqUlhLSUU0YTY3R0VUZEI3RVRhOFplQ1l5ZEZWQUFGMVdBcGl1TlI0?=
 =?utf-8?B?d0I3eVVUQ1JKLzI1WUgvbzk0VGZiOUxBWVhBakRtYVhjWi9nTnhrbWVnV0l4?=
 =?utf-8?B?aG81aU5DVWJWOFFUV3YwQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlVOYXg0dEZDQnhPeWRoUDFMWDUzUHVFSXorbWt3RUVTaERQTndxYkFtaG1l?=
 =?utf-8?B?MTQ1VC9RVzRrQ3BaOWhTNHkzU2FsOHA2Z0RvKzR6aDhQaGlSeWh6ZzlPdkNz?=
 =?utf-8?B?djZQcUdrQnFpTUlCT2pZVlVXRStvdVZkeE9wOTVBRHVaRnllZmNzdUx5ZWY5?=
 =?utf-8?B?V3BFbHhZQllmUkh4cTVrdGtaTG1aRktUOEFaM1UvMXhCYWFJaDlDRGFuclJh?=
 =?utf-8?B?T3NneVN0anVtbVkyOFZYRThmQ2ZPbGordTNDdVUwUXVnb0p0WFV1VUtubGJT?=
 =?utf-8?B?ZFFtUnR3WU9UVkxlMHVpeHovTkFTbk5tcG9SYzdtdUxXZzJ2UmN6enBjR0xk?=
 =?utf-8?B?WGF0MVZSeEFJSTdkSElVanlUc2NQL1pvaE1QYzJlbjgyVkppdURsa1RmeTJr?=
 =?utf-8?B?Nm1SY3ZpUXFjS2VRQzJsWHk1VU5LYUdZVk9tTlMxbW5DVnduODUrdURxV1B3?=
 =?utf-8?B?N2NDTG9tUG90S3FqNG9BQkM0OGQ0bHpyTmlTbFN4bWZzbk90a0NmcG5acHhV?=
 =?utf-8?B?YzZPekU4ZXdkZEY5cDErYWV4Z2FPUEV6c2Z3d3ZNTVp2VzJnNlhZUmNCM3p6?=
 =?utf-8?B?VEhzRGtBSHhUZ0ovaDZXYTQrTTR2YWpYREZpUVdxL1l3M3FUYnlXSWttMFkr?=
 =?utf-8?B?b3lmWjlnSG00aDNaTVBHaldZUmM5SDJnZk5MTWl5UTRqNXpXTENqakNTYTFM?=
 =?utf-8?B?dXVNQW1yU1prOWtZSmJkWldJTTZWeWNTUGZLTi9wcGFrQ0VZRUZtUTlvZUlz?=
 =?utf-8?B?VFA1K1FUbzc3cTFaRGRZNzhjOUtGS2RXMktneGlvaWZGN055YVBPSVlNMUNL?=
 =?utf-8?B?TUVNcE1xYzhpYkNESFRqK1l3MDdyVVZmdWp6ekxNc0JYOWNidzJrbnY5NHJw?=
 =?utf-8?B?U2kzdGZKRXUxNXNyNWIyL3RCbUh5cTY1SkVxOERqYzBuSnp2ejMzRnBwSmVJ?=
 =?utf-8?B?Y3g2UEdONzFBRXVpSWcrd0JyOXhzS1RBM00zTzVFZktDcmJNalN0Rmo2S2lK?=
 =?utf-8?B?S0NRcUt2K0YyQmtpRWdySUp0enNqRVRsUWp0eWFkeEtuWlhmdXYzemx5VmtH?=
 =?utf-8?B?SzB3RkpObHM1eTVuQUcwclZCRzBzY3JKWkVHWHUrSUp0dW56dEhFWVp4dTZ5?=
 =?utf-8?B?VjhyMmQxWkZKOFowYm1OY0dQamxNU0g3ejNSaEZNOTFTZmlsc2dEdzk0ZFJh?=
 =?utf-8?B?TTNNTktjalVGendzMG92MFpXbkhtenFUSXJQcU1kNXNBYWl4WGV4eE1GRGhJ?=
 =?utf-8?B?TnlNUjh0VndndjZVNWpEYXpROGVVTURKbjZKb2hrSk11aFhheEtXS1RGdVBJ?=
 =?utf-8?B?bFQzRzJPYWNvOE5BUXVUQzdhVnlqRTRRbTNKMjUya0FTOENyUWYvbXg1MElr?=
 =?utf-8?B?d1BFSDBzL3JBN2tjdHQzYUtFbU5zMExzTEozelQyVlh3Y3l0SkVxMzQyTmdG?=
 =?utf-8?B?Uk5UVjJQOW0zQjNXa0Jrc0xIeXFXbU80T1ltcWpXR0U0ZktmLzhQYVdQRHcw?=
 =?utf-8?B?SkRrbXdJeGNkQ2lMa1FwUEpjMzQ2WXVqa2Z1eWFBQ0RSeFpZakRqbWJYdWpv?=
 =?utf-8?B?bnE2T0d2NGR3MUh1a0hmSmszQi9LbUptQkhBSXRkY0dSV1Q2SStNeDVZRUl0?=
 =?utf-8?B?OGxwZEVyQ2ZWeGpPcGc0OEQ4UTY4aXBQREJIaFU3eDA4RlNFYk5BblF0U2tB?=
 =?utf-8?B?dVhXMExGZk5td2p1dy9URkRiY1hmaEY4bG51YzR5UWxhNEFVN3plcUl4NFpN?=
 =?utf-8?B?QWllazlrMkxjVy9jb2szZXVmTXpRY0wvaElQbi81UXZDRHlkY3pYbVlva3Mz?=
 =?utf-8?B?OE5lWjVsMVk4ZUZ4NlZwN3dwSE1BT2NuUm9PNjB0K2MyeWNkN0IrU0NOSzVJ?=
 =?utf-8?B?a21zMjYybjViZzhaeXBLNTYxM1Y4a3RqSTF5SXYzaDJ6VUJZTGpIcEhxRGd0?=
 =?utf-8?B?L24zWkY3UTZ5V1pZL3NOTjM3L1ZUb0RLc04vRlptK016ZWdZcVE2QXl6Wk5G?=
 =?utf-8?B?MWIzRHdaNXg2SjZvSXNmSnJlQS84c2R4dnlpSVZ1bHRCMlY1OVBQcndQWDNv?=
 =?utf-8?B?YnFjM1MzOGRhYkJodnFncGUvK0NyMERuZzRLSXhWSjlpRjFqOC9pQTZXaWZT?=
 =?utf-8?B?K2FzbUFKQnVVUzhnRDhzR0Rvb1RJVi8wcEhjQURUeUNRbm1ZM2NMdy9SU2hW?=
 =?utf-8?Q?oCBpMOKvESSojAsBcvlFNE0=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae267659-84a0-4fa5-d25a-08dd1b52acd9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 08:46:46.1658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lyAsJWQhNMFFjiYrcORdainDn+i/3tSwxpNu/HlVHf/c/QLLhsg9mjL0Ut9wufN8H7bM/4HGCREjLf2xJKZodvQjHn/ks8mAyrucwdVjLNi/3cD2KtOBXR2E1T2xCBnv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6812


On 2024/12/13 16:26, Ard Biesheuvel wrote:
>>> How do you envisage 'noalias' becoming a security feature? The point
>> for the case 2) above, if its linear alias is also mapped as read-only,
>>
>> can we think it is safe as the original "rodata=full"?
>>
> No, it is not. Why would we bother with rodata=full (which is costly
> in terms of TLB pressure) if rodata=noalias is equally safe?

okay, thanks.

I will wait for two days, and send out the new patch if there no other 
comment.


Thanks

Huang Shijie


