Return-Path: <linux-kernel+bounces-281166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051F194D3D5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1681C21B01
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFD0198E8F;
	Fri,  9 Aug 2024 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mk/qmO8T"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDC8CA64
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723218303; cv=fail; b=XV7gvFBXVQs7CUdduDqiHsFu430YBvJXGP/5yJussFoSNnmx4M5YGTwdHVHQBLNbuxo4hFxLP2bU57ABpj2I1O4RajeTJwENlmLMClKhxulc2hMZgJK8hvxSB/zL4MMDFpNTVnK/tZ1BLqet/IqvY/VZGAyjCOn9X4vZBrEth90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723218303; c=relaxed/simple;
	bh=MkgyZLlm7qwfEn8zXtcYkMWRe/ffPtwT0TuggB/gDRM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OwG4Ty8EmtI49XLjsF0YoiwkKmWhUUiOrwaq0CV88Uvwlp4zaqAqB6cVJpRfyIRoNr5ngVuDL+NnzIdTX8IdESsDVtSRTn+BegMO0GUjQkU0YVB+BkMvltdV16H/z+2Wh2id1VeM+tI1NSkLogVyyNiVE6rEayt7BW+CZ76FGOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mk/qmO8T; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUE39AfFse9fKQwq9CZB0nenx+nY5BejkAFsrmrzvk1XtSLtTp4QeFM1R/ejs2xcPSYqODg8BPhl6H2H9hewW0G6yoBXnLCx54I6MJtyuW8YfFYu/IEZ+lW2HOVjAPkwULpecEKVabfTBPy6cC3L/tyQU+jLLmwuFGm7ICH2rpxuf3u1wHzxosOKU7/iW3Y85wpskOHcRum9KC5iyaFBUzuLqfscJFd0nkZE6MV98ryEzXv05YMhhC4phng4iY8zs+GMmVRP7LShjNLNy1rVswDp+ivQOZdfp9286OGzXg12mkUJuDurCvrxxywm6vCcC4ntBbcbmcrY8+8EdQ4xOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18QH39VeXDRD5tEWBp6eQ+DwhUuEQWLGAMgDJLgKxng=;
 b=K/3KgSn8ieUM5Hzt8fny8B2LqPZovUjvcIYkt70jRrG9ItAB/p7+79g8geKmt4zcuzrEvVt+Ucjip+Te8k65Y1D5v/k547kahxMcDHYGdKbAYgCl+sTzGc9ZIBs9UR2eMXXCOr4b7efOTMek+0xFh7m1SV+fXfadISE8DpH7sY+iicEWeSeakTWh3+wXlp3vnsR6wtUzaHsKFc1eojZ7R6DkLHp1xooEVSwvGGuY2Lq3hYTdazzTgDaXoYdb9ohvAN84AVHkCk0SniojMZz8nlIWfqI3facQwA2vBVy5WBvRSgSSa+mVTJgjxPTWd17GRAHtUIspYpX54beZY5OdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18QH39VeXDRD5tEWBp6eQ+DwhUuEQWLGAMgDJLgKxng=;
 b=Mk/qmO8Tu5zhkjhhEp4Gc6Pn7lZkGmqqR3fAjN7Qs8MKNa1oVqrgILNYQsUAEDExK5cRDT4wz86CEhciMa1vbub4ogCwQgfCspZTLKLsQx5AZOmVCgXARXH3GexROQw8QnwZAuXbx03Tej4eH6M3nJE9ZAPh4TWKcouUtrfMfE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by MW6PR12MB9019.namprd12.prod.outlook.com (2603:10b6:303:23f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 15:44:58 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%4]) with mapi id 15.20.7849.015; Fri, 9 Aug 2024
 15:44:58 +0000
Message-ID: <94e789ab-2e64-4a6e-804f-b5e7b2a952cb@amd.com>
Date: Fri, 9 Aug 2024 21:14:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 3/6] i3c: mipi-i3c-hci: Add a quirk to set PIO
 mode
Content-Language: en-US
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
 <20240807052359.290046-4-Shyam-sundar.S-k@amd.com>
 <2a9f6c23-9c7b-496b-9998-ea0afe526b46@linux.intel.com>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <2a9f6c23-9c7b-496b-9998-ea0afe526b46@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::24) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|MW6PR12MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: 20890f52-751d-4706-4330-08dcb88a390d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0h6b2w1a1ZpM2YvNTlzMkNNZjJWNWtObjd6S0lSQXcvRExoUUJxVFg5MUFC?=
 =?utf-8?B?MDRwb3J1YkhNTWlXTVBiQ0l3NGZJQ1NBbHp2Sk1KR1BISmtUZG44UFNmT2Y1?=
 =?utf-8?B?azd5eXVDQ2gzVnl3NU1xWENRSEFPalc2T1RXNzRvY1I1MnplbmFCeTVOVVl0?=
 =?utf-8?B?ZEp6RitkSEZkOHRVSkdjbTVaL0tYaE1adElRbTFlUTk4UVhYSGJWWFFoaGo1?=
 =?utf-8?B?ODJOTENlbHdGdlIvdE9aU0VtZlZocmtjRmJmMDNWb1dFWisxMmk2RHBjak9q?=
 =?utf-8?B?Kzg4UTM4TGc2NjJyLzZVenBlQi9RUmFHSkpJOWp1WmVucURheGZxeG1qblFI?=
 =?utf-8?B?THZ5alJIK2EzOVRIL05OMEpNb2RqQ2pVN2VzZDQ4YTlGcldWVWJjK2RpVFZy?=
 =?utf-8?B?M2ZmUVhUOGNOc1RDV0E4cDRxQjJqNFZ6dnRxNzdzaW9mS2lXUTJ4aWh6a0JD?=
 =?utf-8?B?bUtUc2pTbi8zT25ZQTB4MnppcFQ0N2hwVFFwdkxwT0ptdWVLK3dja3RKSGtS?=
 =?utf-8?B?aUlhdHVoT0pNNDMyN00wbm0yYWlPMUlNNERsOGF0ZVorNWZ1OElkMU04WWNq?=
 =?utf-8?B?UDc0NzZSbkI5YnlYTVlHNW5NMG9Tam1hMUN4MWlWNWNEQ005T2l4eG9RMitv?=
 =?utf-8?B?ZDI1K1kzTU5sRzhmRURZNDhkV1dORjZFU2ZxMkJ0ODVvamhOaitvMkR1RnFT?=
 =?utf-8?B?RktmTFlTWmNrVTM4N0R1QUZtdTlhL1FqL0FSUUQ1RXlxRmwzejN6bSt4RkJh?=
 =?utf-8?B?a2NsWXdtamtHRnhHOFBIQjMxelNEWVZPVmFRa2xSTnVaZ0R6cFJRQnlsZWJv?=
 =?utf-8?B?NEZMUzlpTnNpbUxSbDBCNlk1ZlZOKzdLWDUvVFd0cmRYZG1uQUdvUzUxeGQ3?=
 =?utf-8?B?R1JOenZIdldETW9OaUxNdTViVDBPMGdhVVFUdDBCcXFBNVN1djNkRHdPN3Nh?=
 =?utf-8?B?aGtvTjlsRHNPdTNDYmRjMFRaSmd3VjNqNU1KaHFDQUZaeThTWUpwY3pCSlhN?=
 =?utf-8?B?cXk2TWt4UkZub1kzbURyN0JoZUdIQ0pxSVNwU0pkU29MTlRuckdweTZXWlNt?=
 =?utf-8?B?YnZpemVzTXdmb0dSeEM4MldsNkJjTDRYU3VHTGFWcXpGWm5sWC9zcklOcGMw?=
 =?utf-8?B?V2V4VDN0WE1yVy9TM2dGeUxXWWQrVjBHRHJVbkNjN1Z5aFdVeU1LNlo2ZHU2?=
 =?utf-8?B?VmNaZGtnRkhvYzNsL05Fa3lySUxkbXg4WDdGaGxrQXFUTzcrRWp1RnpNR0Zn?=
 =?utf-8?B?SVVzWHpnMk9wa0ZEdlJZamUyaDhKRjdLTVA1cmlzMUtjK3B6VGFUWnkyYUpW?=
 =?utf-8?B?K0tBTWx5LytLMTlOc3V5bEFMcE9OTFBvM25qSG9zTGdxaUdxcWZqekx0QmlW?=
 =?utf-8?B?UkVXMmVjd2tqQnd3ejdUaGFHVG5sRVc1TjNWaWpta1dmSHk5WGFWVHdqbUxX?=
 =?utf-8?B?ZHRraXo3YlNLeERqWXFqQm42Q0RSaTlobjMza1FxaEQzTVJSb2tEdkhzeHRK?=
 =?utf-8?B?TlJtZVVrWVNNQXAzOTFyU0hRVmxWQ1FHQUdUcUl0aHhJcCsreWczeStoZXZ1?=
 =?utf-8?B?M2J4UVNmY25HZUNwOHVhalM1SENnYnVsbDVqaG1icURkQnVjckViVlhneFRP?=
 =?utf-8?B?SmNWd1VIYVZxczdYWHVkbSt2RW5lVGNoWjdGKzE1L3RNai8vVVBJYm9XcWVx?=
 =?utf-8?B?TEFvOGdTS3BKN0lEUE4zbTkzMUttZndDSWwxQlRxYWpvOE1tUjk5d2VTbDVB?=
 =?utf-8?B?LzdwRys1aDJ1NnpmT2Z6WjFjV2E1R09QL3lYZHViczVyeVYyYkJzcHU2dXVa?=
 =?utf-8?B?QXpGTklZU2ViSWV0RnNIZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enNZb0VoMlhreVVqVWNuWTRKQWFZNm1yZTF6bUk0RG1ad1JRbTUxUmx2T2dF?=
 =?utf-8?B?eC8wUVd1QjBmYUZXLzNyNC9PeDNFeEczME95OWs3bW9jV2hQQmlrOEROV3NF?=
 =?utf-8?B?Qlorem52TFNsNSszLzFZcTlIeWgwQmtzU0pONElycmlobndmUUR5cStjTjFU?=
 =?utf-8?B?NWFIM2xiRE5OZytRckNiZGYrczBjYkV0aFVIWTFTNHdieC90TGh3RVV3OHRQ?=
 =?utf-8?B?TEdTQnF5UzB6ZzVHWHVRSXpWOGVUTXZraDlVNmJpOWhaQWZkbFhOL3VZU2ww?=
 =?utf-8?B?Nllrc1g4amtnMmcwbG9KWlRzRWVkckhkN1M2WWFCZS9ndlNJYVkwQXNtbG5p?=
 =?utf-8?B?RndpZzMxaHJJb0VpZGN2RHVFTDJBNTNvRW5ud3JHckFjQkl6KzZvdGU4dXB0?=
 =?utf-8?B?QlVrZmlRMTg4R0JUOG9rREczN01sQ2ladnNRNGVnck16bWlOam1WSlRBSGFs?=
 =?utf-8?B?bHZ5cENlV3JZeHpGZWxka1NUVTVsNHMvbVVwZ3hLZ2U1ZXFpQlRrZ3poSG5C?=
 =?utf-8?B?QXlMQ2pkNkVlNW05SXkzenhEME1VU05EaGMwVUptT2RJTDZDcU41enE0WjRM?=
 =?utf-8?B?aVVRT0xCK0ZmVkxyTGsyN2lqVFlxY0R6aHlFMFdORzkvanhDUEV4emczU1BV?=
 =?utf-8?B?S0NLTTA2Z011WWd1VjNYQVZGbVhManBVSHliVXJnMDhOWE4zZjVTNzRSWWV4?=
 =?utf-8?B?Y1NmNkFMVEJjbnl6b1A1MmQ2OTlxaDNWMXZ2dFllUnRDUTNTbzlkdHRmcXdV?=
 =?utf-8?B?Q29xQ1RHdk04M2NYVWpaa215L2FsVmU0MjhCRG11REhXQ0lxWlpSS1B4cjJM?=
 =?utf-8?B?V1lOOUZkMUhOektpeFVvSndVVmNseUU3REFDUE80dkM1VitPakRFako1WTky?=
 =?utf-8?B?cTE2VEdYczFVajVMWFlBQnZKSVVWb3YwcGFRRy9GVjZHdDNVS01YcXd3Mm0x?=
 =?utf-8?B?eDVGa1BGNXZyWEZwWVdCSjZSTlJFV0FxejR2dEhSZnBwOVZDd2lEbDBVUnZJ?=
 =?utf-8?B?V3BEYithcTdUZTc2SGg3MWx2bGl4RzZack8zSWhsOTR1TUZFMzVFTlBScGxS?=
 =?utf-8?B?ODRKY3MvaVhQTTJtd3NScHBpOGJWMnY4VlZoNTJScjZXV1lKZ2pSMURMV0tH?=
 =?utf-8?B?dTltbWpqVXlMUDNicnNjV0ppY05uMDBlbHJwRnRtYVhjU0hnMUQ5bmxkcUNy?=
 =?utf-8?B?WTBSaFF3bzVJSHpEMkRSSnYxMnZNb2NzR3hVYjNkYXNKSWh4VWluN0N6UFJh?=
 =?utf-8?B?S05wQm04SlY2clBkTDNmVUQyZzBUaDZabWxMMFd5WnErZndNcysrQ1VYRFg2?=
 =?utf-8?B?ajBUWHJwSTNjUGVWb1FHWnMrUzZTZGR2WkFwL1QrZ3lPQjlVRjRGbW9PQk9E?=
 =?utf-8?B?dzQyTTBGa0duNU5vQUtYbW1mNWhjajhDM1FTYmlmR3NsK3VLa0FSYWtDL0g1?=
 =?utf-8?B?NkwyK2ZZYjg3WjZmQlBOK0E1ZzBTUGhKYitoUXd0RFNhalVkVU5FLzBIcXk1?=
 =?utf-8?B?TUpjU0U1K2NrUnNKc2VkNmVxcjdOZzVGbElDSHFXVlE0UllyYkVLeWl3aDF3?=
 =?utf-8?B?QjQ3UXo1ZlQ1TUpyek5ubGcrVGI0NXVFWGVhRUJ3NnhucE5DcENHTWU2SzRl?=
 =?utf-8?B?cHhHSG90cHRVK2REWEhZcjczTkxFaEsycDJHa2FxRng5NGdjTnNtRWZUdkwz?=
 =?utf-8?B?UkZ0MWhCeldIeWpzbklOcmJNaVZlRElrSEpaT1loYnkxaW1Jek9ndVpTMWd4?=
 =?utf-8?B?TXY4eFZtN2FzYUIwOUpYNUoyUlpqVXBadFFnZVBCWXZpbWY1amJINm9WeDdt?=
 =?utf-8?B?a3RZWDVleE9mc3ZyV3A2YjRQaHUrWXg3ekNuZGJWd2JXcFk2SGlZWHFuRS9J?=
 =?utf-8?B?SFl6RG5zSXp0dldqSThwZWFjcUVHRzNzbzhYOGsySHBhbmlqVUZFVDFHWDRP?=
 =?utf-8?B?VWx0c0dVR3JGZmhRT1JsaURJdFJFNWxKNytMUDYyRlJTZStET0RrUGduNmZs?=
 =?utf-8?B?eEJNNTkzYlhHNi9JcVJwZmRHQjNhbzJlWHIydUVMei9RUHY2TkFiQ0VRaHg2?=
 =?utf-8?B?QkVNSFFtZFhteGtpU1NiL1JBUEI1c1JLelNsWFFoSk9Vak80UjNqRFJHa1NG?=
 =?utf-8?Q?SGeMgWj0nBtQKe/9yI2cxpfYx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20890f52-751d-4706-4330-08dcb88a390d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 15:44:58.4801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gi2AuxGkttacIKCtYfT4p51Wzanww0sowjZd+bidMw5abkVbKBOnKf9C2gHeOxEW/sa5pOsCL0KFB6sCxfjAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9019



On 8/9/2024 19:25, Jarkko Nikula wrote:
> Hi
> 
> On 8/7/24 8:23 AM, Shyam Sundar S K wrote:
>> The AMD HCI controller currently only supports PIO mode but exposes DMA
>> rings to the OS, which leads to the controller being configured in DMA
>> mode. To address this, add a quirk to avoid configuring the
>> controller in
>> DMA mode and default to PIO mode.
>>
>> Additionally, introduce a generic quirk infrastructure to the
>> mipi-i3c-hci
>> driver to facilitate seamless future quirk additions.
>>
>> Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
>> Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
>> Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
>> Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
>> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> ---
> 
> ...
> 
>> +void amd_i3c_hci_quirks_init(struct i3c_hci *hci)
>> +{
>> +#if defined(CONFIG_X86)
>> +    if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
>> +        hci->quirks |= HCI_QUIRK_PIO_MODE;
>> +#endif
>> +}
> 
> I was thinking these quirks can be passed as driver_data more cleanly
> and be specific only to affected HW if AMD HW would have an unique
> ACPI ID for each HW version.
> 
> Above X86_VENDOR_AMD might be too generic if and when quirks are fixed
> in the future HW :-)
> 
> So something like:
> 
> static const struct acpi_device_id i3c_hci_acpi_match[] = {
>     {"AMDI1234", HCI_QUIRK_PIO_MODE | HCI_QUIRK_OD_PP_TIMING |
> HCI_QUIRK_RESP_BUF_THLD},
>     {}
> };
> 
> and set them in the i3c_hci_probe() as:
> 
> hci->quirks = (unsigned long)device_get_match_data(&pdev->dev);

Nice idea. But only problem is that MSFT wants to have the same ACPI
ID present in the specification.

I have replied to Andy on patch 1/6. Can you please put your remarks
there?

Yeah, agreed that having X86_VENDOR_AMD is too generic, but felt its
good to have additional checks only after the HW is fixed, rather than
being speculative now.. :-)

What would you advise?

Thanks,
Shyam

