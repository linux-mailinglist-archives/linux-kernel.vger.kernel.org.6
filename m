Return-Path: <linux-kernel+bounces-265125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3B493ED08
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0B61C21763
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 05:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78031823DD;
	Mon, 29 Jul 2024 05:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aT0dbXi7"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC9F4C85
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 05:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722231827; cv=fail; b=OToVTlWsU9wG0T2TbLvpJqkVHGbKuxokfDztsVi8+52fRjZyqT+sNHud1IqUqK2lPS0lDSBJ7a5MolADw7mkIsxprYpFD0N5MUOECB0Oi+YE0utrhY7ZbJoQDWbg9JfbyAGSERpCP9eEVW7zBIo/l74IiKTnCULRm5lgzGXAOH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722231827; c=relaxed/simple;
	bh=Lj1Z6TOWf8QFNUFd9oAfecwhSwyx/U21QIcI5bRd+oI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U+WHdCCVEOLpWKi84Ks65vK/aILZstzJVw0RIlP/OgChJyLrra4T9KZ9m+plWwkaflY1EIFvUx/Totmhx9G9yzEfZqI1me07lBv//pBs+f20v+ZGc6wtQ+EWYsvk/t/O6Q+AfoMIhCqWvzwNRc4XOiBqunpsEqsy23EhYtNj8eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aT0dbXi7; arc=fail smtp.client-ip=40.107.100.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJ5HYK8Gd7EbWxXyOuwgLUxrVxRpzxM7JfwI/7eBRUiN1TdcmpblX7P0EgjzN+SqlKVrZam0UjMeN2WIy/rRTy993usf3lTLhpIs2AMywfFlDl6ENJdTk0xwuTGzpqIOhvTib3bWp2YllATGfpqZWnOPWACIqXFNUSoGehFFCxIjHOekeXSOQxHANnbexExKy/+x6H6OE7V5Wr/bVfNkbY8daMODQ8YFpl4W3k7X0ykrlEgKo9UVOs8kvyI7xBoIJXBorqdm1AuZG8jq3XGEM6D3nJWX6TevEsFc7bH4zuFFXWOYyQtffC4+rk24OhvxmceMlpJwvVgyOIRH+hk1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTYVBcQakiwYU1tzwENDgji/RSgcTnRXiWzSnRtXEeQ=;
 b=grRRy9GS8TrhcOJ/PdlyrJRAPSlc499F/BYR2W2plU0d4hKmRboW+35PEKCsedOutHowALQzLt/pxveIF6w2PlLjv519UC+VUUKLDWBuOKn54Gu6ukVnC41L24UV1j4dLtWby7ZlMrA5xzhV+e5PO4nWZLJ81+dsZziXXXmqpFJGWn8dp9Ir3DmFiaXJX9pF2aUdURfcU2/v4iBy3Cp1x44cfXtIO+HeBSUom4g1AlquK5akr1gP50jb4649xWOys12YfDSoEGHtViRbqdrsVkl05GtLCT9bG76v6Obh2BnQ6z48QgN6SIjRXYPlyc/RlhVpyVdKFlFxgYFDQxQFLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTYVBcQakiwYU1tzwENDgji/RSgcTnRXiWzSnRtXEeQ=;
 b=aT0dbXi71GrufF+RVXbgiwy4B+XA6xF9Y5iYJTNWKkwaKPxjjVLAuIfbuLkctcz2jjjukU69cNVsK1ldtKJMqQWh7bPtXbftMOVjftwwKCXls7SgDcyDVGU38d+j8qSax8Q/55odOnwt2U2YjoQBDcj44SdH2EDaim3vVGLfzrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 05:43:43 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 05:43:42 +0000
Message-ID: <b7d2d3e2-5c24-4dda-9f6b-60d8f83d2fdc@amd.com>
Date: Mon, 29 Jul 2024 07:43:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] microblaze: Export xmb_manager functions
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, quic_jjohnson@quicinc.com
Cc: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
References: <e322dbbbde0feef83f44304ea13249d365d1dc5f.1718799090.git.michal.simek@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <e322dbbbde0feef83f44304ea13249d365d1dc5f.1718799090.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0057.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::34) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA3PR12MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: 1661754f-6ee6-44f5-2d7a-08dcaf9167a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3N6RDlwUm9rZEdhOWx4ME43NTM1cmQ5QXlmSUlYcThIYm8zVGExMHltNXZK?=
 =?utf-8?B?REVLNWdvMVR0RC9lRVFxYU5SQXBka2JsbHR3MFl4L1dYOFV5TWdQb1g5cDJo?=
 =?utf-8?B?WHhINmEzaUlqN2FnTUZ3MWVsWTBlUDJZalBHUjd0KysvVXJhRWtyUVlaTHR3?=
 =?utf-8?B?ci82SC95eTFTeTlVUFVWSEllMlM5RG9VdTRKcllXSGlQQXVtcW5CQksvT0Y1?=
 =?utf-8?B?Zys0TWJ1TXA2SWVwNXcwTCtMY2ltcUxJTWtPYkVCdkVMSHM3TUFDa3BkeEFv?=
 =?utf-8?B?TTBORm5HSHlJVkJLU00yUkp0cHlNSnpneXloV1pOaWdlZjZ4YlNicnpTVjls?=
 =?utf-8?B?NXo2djFyYmQrcHZud2hrRnJxUkY1R0lGK1pvRmF2OG9UZFoycjRlQXl5UDI2?=
 =?utf-8?B?aC9kbnNBRjU4V2VYbVA3Wk42NjNCVHZob2hzbTY1YzUrY2JmTVF5d3c3d3hx?=
 =?utf-8?B?OVZ3L2x0NVJYMWljRXBSM3VyM1FwVmpYelIxVzlOU2VEMzNKWkFEWGwxZVRL?=
 =?utf-8?B?b2lJMDVDQnRsVWM1TmF5UHEyTVdMQk1CNHJkeWQ1RzIrRnE1ZjFqcm1nRDE2?=
 =?utf-8?B?OWsxNVRSZzZiL1hWL0tpWStCaFBCUnZPQUhVL0ZaQWNZUlQ1R3FvM3JuSUlv?=
 =?utf-8?B?azZVZXUwNWR6dUQvb0JVWGhyTm8rSDdKYWZQeEVOaVVHbS84V3pxR0U2ZGxU?=
 =?utf-8?B?N2RGcSs3VXZuT1NTc1dqVnJ1VnV6ZU1PYktqeTRiQllGRy83Wm1LUkt2QVNF?=
 =?utf-8?B?MWVPVlNzMHVFSDI1ZGNnaWwvT25HVEdiMWRBYzdGM3dQZitCQUlqd2VEK1hH?=
 =?utf-8?B?VW80VldoZlVKUjJxYTROZ0EycHl6WWlTck5Jb3JKTHprbk5iMjVPVG92ZVFr?=
 =?utf-8?B?em9JTEU3d2I5SEt5NkJTQWxNK2Jxd1gzK2Rrd01XazA0cE91QlEwT3pZaFJG?=
 =?utf-8?B?NjZpZXVGaVhpWEI0SzJPeFcyUXMzdjNUQStoQk9GOVpTU08vaFBzNEsyYmNZ?=
 =?utf-8?B?TlArTGRta0RjcmYxcDlreUdiRWJHVkh2SEdLQjRsUHpQem9RWEdQRXpMdG8x?=
 =?utf-8?B?Mko2QzFGd0VqRU0wMHBNNTVaSXB3eWhmUG1tQjQ3RnJBeksrSDhlQ2hGREk1?=
 =?utf-8?B?SkZvMmJ4WFJ6TUpKdG9UNEtSMnV1ZHFEbWVVVk5ISlRTUkl1aHFUeGk1bVlW?=
 =?utf-8?B?dm9nSGlUb3BabDNYZ1Jha1drNTVTL0VQOEp4YkFSUWJiOWt6Vm9CVHEyekRx?=
 =?utf-8?B?bStXbFhoVlF6ZjBHUXRnOHJKand0eWsvbURDcVFVTWMxZGxMRmRrWjRGQUZX?=
 =?utf-8?B?QTRkcE5XbS9zVXRVZVM3UUlDVHYrSkV4ek00UjNuWU53WHdqalp6QUZqRWsy?=
 =?utf-8?B?c2dRZjJqbm5pSHNTWkd4MEFXcXpkeDcvS1VrLzQwcW9QVXN2RCt3cEdtRzQr?=
 =?utf-8?B?MTlONDQwU1ZpODE5RWJWaVErUi9FclJNRm1XampjeE9XdzJnSGxSUlNpUzBh?=
 =?utf-8?B?RDlvSUlUa2d3S3owWGhYQ2FOUnJZWTFJcXNwTy9iVU9vbEJSVDRRcWNoUVB5?=
 =?utf-8?B?VU95QzJKb0dyU1R5b2hPMHZrTThKVFVCcjJsd25jRGliQVdtUnFnT0Fvd1pY?=
 =?utf-8?B?eDZwMG0rcUl5RUQvRW9UZ3laQy9QY1BaMUh0U2hmWWpTRzJ6RVFGQXkvQXMx?=
 =?utf-8?B?aktIdEJ4RVduVmM2VnJBM09zVTNFT0l1b2h5RXEwOTc5azFTSEVQRjB1TWxJ?=
 =?utf-8?B?U0VwYlVYQU1YMDRCT0lBcUhneU9SeVVRdGRYRlovRktKa0YzcHF2UFUvSnRk?=
 =?utf-8?B?VVozMEovbDZKSGNFem9Idz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmNKQXBZYXdhVTZHU1JVQXljYWRPVzEycHlmOUw2cmhHR1dQSHlnY2cycXov?=
 =?utf-8?B?OXFzSll5Qm5HMHlWWmdHWVhpM2RQVFVldGRXSFNWcENia0NmZC9QRnM1aTNx?=
 =?utf-8?B?MEpoVzcvTi9FaUl3S2hBVSt5MEdZRUZuZStjS3lsbVFpeWxjMEg5ZE5ZMU5m?=
 =?utf-8?B?TklyUHZEcGFqSngxN3NvRmpnYSt5SjB6MVpIZ3E1ZVdlTFM4bFB2dUVCbHIv?=
 =?utf-8?B?dHYzRk9qWE5aZ2FjaVZ6RnBRKzlFNDZYOTFIUEw5Z3BXSWFXaFNGd3ZPbDRJ?=
 =?utf-8?B?eURVNG5OUkRLc0E5OHRBMENsT3N4bDVjN25FQnBoTDJVYTRNWlZUR1Vvb1pT?=
 =?utf-8?B?bGNVZmN1Ny9neXJwVVpGcVNPZUxvZkhVMXpvSElaQ3ZEMTFNMWdDK1JQNXg3?=
 =?utf-8?B?YlBDWDdqZGczN1hHaVQ4Sm1NUTFmRlRWVkZYV24vWVZkTGZTR05XbG5xeUtn?=
 =?utf-8?B?aDJSTUdOZ1VWSnpBM1VWUU45dmdYU2FNYU5keC9zZUFUcWQycnJ5NGFPY0wv?=
 =?utf-8?B?djlGdW5ad2ZFVkdEbmszcUlnQlJlQ1ljZlNDR2JMMk9rTno2aUxTUnJUemRj?=
 =?utf-8?B?OEhOSmtoWUZYZHVPaFdVRk1POGdVQ2FMZlkvdWpMd0ZXSnVORFdDY1BrU1o0?=
 =?utf-8?B?Y2U2TE45NnJ4cmRsMERzUldkOENvTkV0enNBQVJoUWZBR0Uzdlc1Qm9vSmE4?=
 =?utf-8?B?cWVEK0dTTExMRm56dFVKNjN2N1BaeHFyZXBOQ0NFYTR5RkZzeUk0MHNIdjNS?=
 =?utf-8?B?ZG1xbm5uNFppZUhmU2RqK3ZmMkVVNERsNzZuSDI2NDBEQ2o0bHFNTVpMNnQ2?=
 =?utf-8?B?aGtaZEFlbHYzcEZESktINVZnV1ViMUlWRlZZSzlWWXpWL2FrejdScjBEaHNz?=
 =?utf-8?B?VjR2eHVScFIwMkpuM1JKakhSeC9UVjE1VXRPWVVkMUExNjFDaHRrTmNVSFdh?=
 =?utf-8?B?enZVSjkwR1dEdHI2SWdkZ1RlMDFjSVN6YldmMkg1UjI4bUZud2lJdlRWdjIv?=
 =?utf-8?B?WTNSa2dsWkJWL0tPdGozWTJoYi9odnljUnpEMFVramYvM0pJMGFCaHhJOTIw?=
 =?utf-8?B?cThOZGVTcGtXZFZSbWxEYTArMms5M3NFNW96L092aXJka0taaFo3dGU0WHcr?=
 =?utf-8?B?VDhQc3g1UEhuU0tDb05ObE1BUkdpd2N5MGxCY0NoWnUyMWVNcFlJSUFINHh4?=
 =?utf-8?B?Y3pZQUUrbTZFNGNMeG1FODI2TjZ0ZEovU0w2dVRCbm5udFY5UDhHN3c2SHIx?=
 =?utf-8?B?c2V0T2JDQ0taTVZuQ0YyUkZRbDl2U3NEaW5uRE5lOHp2dnNzeDhPYWpuckRz?=
 =?utf-8?B?alk5QmU0R0dNU2t4ckQ5YWVUZHYydHRCWk9QYm5jWDAwdDhWRUNlQ2hqY0JB?=
 =?utf-8?B?Sy84MHRTN1lkS2kyOWszL05jL0dWdGRYSlJnTTE4SmN2TTNmQmhoSUpxaitJ?=
 =?utf-8?B?cWpYSHRBenEzalUxNFdwYmNlVEhZWDBMWmlaOUFGdU8xdC9CaWdEa2hWUWYy?=
 =?utf-8?B?d1EzemxlS3lFV3Z5dklKUEt2c3c3K3kybWk0ZElSeFZRRnlUVnJydGRIV1Fq?=
 =?utf-8?B?c0xIQi8vbkFpZGF2ekVsVFo5aGhZSW1oeVgyZGdRdG5Xd2tjZUdrUTFBb2NK?=
 =?utf-8?B?dDArcWtVOXBYSml5dTJpeVZUOU05amx2cmZVL2c2VGNCc2N2d3pXaGF4Mkxt?=
 =?utf-8?B?c2dPM0tZNmlhR1JtUm5RRTIvczUyMklhYmExZzAvU2R4T0d0eDRoM3N4UFRI?=
 =?utf-8?B?U3lBTWNsWEhRZ0FtbWtSU05xRlNid1UrTXlFaWhRaU1nRVhHcW1tT2xXNjJ4?=
 =?utf-8?B?K1MwTThyRUZ5ZnFUWTFRdUk0ZFMvRnBWMGRMckQyZDFjcVVZeTBZRnI2Mk9S?=
 =?utf-8?B?RFBTaWJzREkzTHc3S2hBVWRnYUZPdXI4NnBVOEYvNTFMb0F3cXd4MHluOGVh?=
 =?utf-8?B?U282Sm5nUzNldzM5RTlSZlE0Y2diYWFVVXYrdXUzK0F3RzQ2TkM2L1hqNVUr?=
 =?utf-8?B?b3FWcG1zcU9YQW9BUTF4VktuY3RiL0ptTUVseWVOdkVPVnFFQWxEVXZCZ08r?=
 =?utf-8?B?T2g3QTd0bi9keHJ1QXoyZXZKSnZsMGRXVHF5dzViclkzUTlmR0VpYzVoaXJl?=
 =?utf-8?Q?+9W782Vddnzu6S63KBw3oCOAx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1661754f-6ee6-44f5-2d7a-08dcaf9167a8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 05:43:42.6586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZIuszxMVqo7qqZS1OsMDoUfddPL8PqfCJ93AgU3GMs6J7oB+vjw8zbnuVg6ERjy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9131



On 6/19/24 14:11, Michal Simek wrote:
> When TMR_MANAGER is enabled as module there is a need to export functions
> which are present in architecture code.
> 
> It has been found by running:
> make W=1 C=1 allmodconfig
> sed -i -e 's/WERROR=y/WERROR=n/g' .config
> make C=1 W=1
> 
> which errors out like this:
> ERROR: modpost: "xmb_manager_register" [drivers/misc/xilinx_tmr_manager.ko] undefined!
> ERROR: modpost: "xmb_inject_err" [drivers/misc/xilinx_tmr_inject.ko] undefined!
> 
> Fixes: a5e3aaa654c1 ("microblaze: Add xmb_manager_register function")
> Reported-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/microblaze/kernel/microblaze_ksyms.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/microblaze/kernel/microblaze_ksyms.c b/arch/microblaze/kernel/microblaze_ksyms.c
> index c892e173ec99..a8553f54152b 100644
> --- a/arch/microblaze/kernel/microblaze_ksyms.c
> +++ b/arch/microblaze/kernel/microblaze_ksyms.c
> @@ -16,6 +16,7 @@
>   #include <asm/page.h>
>   #include <linux/ftrace.h>
>   #include <linux/uaccess.h>
> +#include <asm/xilinx_mb_manager.h>
>   
>   #ifdef CONFIG_FUNCTION_TRACER
>   extern void _mcount(void);
> @@ -46,3 +47,12 @@ extern void __udivsi3(void);
>   EXPORT_SYMBOL(__udivsi3);
>   extern void __umodsi3(void);
>   EXPORT_SYMBOL(__umodsi3);
> +
> +#ifdef CONFIG_MB_MANAGER
> +extern void xmb_manager_register(uintptr_t phys_baseaddr, u32 cr_val,
> +				 void (*callback)(void *data),
> +				 void *priv, void (*reset_callback)(void *data));
> +EXPORT_SYMBOL(xmb_manager_register);
> +extern asmlinkage void xmb_inject_err(void);
> +EXPORT_SYMBOL(xmb_inject_err);
> +#endif

Applied.
M

