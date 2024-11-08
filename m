Return-Path: <linux-kernel+bounces-401818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 620769C1F94
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805B51C231A4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE4F1D2B05;
	Fri,  8 Nov 2024 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yy2wgshh"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2085.outbound.protection.outlook.com [40.107.249.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896DA374F1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731077181; cv=fail; b=iYSj5G4v/qEsddDwzXddRbfsyrfap74u3UxeXLxEnLRhn3cMI8Us43IPQuS2Zmd0qyxzgZooUse8VoC+uz2LdWeFw9lNgRLOIem1aW2mdrd3oq46//nhyEsnZ9W1QgLLri/VOTFjsiJNPfHCGhajroV6MOd8oOdzJNnTc2DGZq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731077181; c=relaxed/simple;
	bh=O0zFPGEeYBNw192Qi9RxO/ehLv1Ia+EHcv6oBfeoEC8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oiR3MXKKK26wozd85ogUceYYTlpAe78Xnj8tDg7s0H/7OMKuOVznGqigQHYjCjFldUhlsew4MErzOS9FVVFv5fk3RhA1Ahi3vOEljDVr1b1MQUa2UDKluVv130/JuUpyAs+kM8lXtM0FSopmmgPz80io+z1bsBxtTLQS5b81mqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yy2wgshh; arc=fail smtp.client-ip=40.107.249.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Epjc4ieOaGx+JIB9WHXdZ665lplhMUEIeblcOHzOzM9d62wOYa4uEA3LPVpMwpRqQgUbTBGu+zzAFP2K6+9pLapPpKxvIdl2mz8PsP4PRSQaHC73nxORqMVzGPjoefqLkpccDwn7ZH/21RHOmTzDl/Qod7n8Qql7gaoBRNC5wYjDZxuJ6C3x2pD7+mjAdyE1FH6XH9EwxN+2xaWmTLtukI3VuoLAcvVLf2APb2++i/+ffZpJtAk/nKHlf0k2hW1OBRCxd8nC+QgFwbshDqKGK7sdD3K3SakleumZrMuOdhb/iKq3gneyJ6vF1gYjEvO5sAdQTEpXcp9RqqfAbs4rwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2tFizmqcBwHFatJCUUhX0MA6xl4T19ODV8hG1IeYqI=;
 b=n21HH0UujXQk6GpDNsUEuDLXX2qGZQU+IcRE9rjW+U7aKQdLT8ZeC03e8XcSSggpGWwUwiHNRhBoe2PZrDpDgloWLSQr2naitIwHjaVCgScVs0dRg7Ztq+q5EFMULdvy2LK3GgmPZdHoPbVqrNWgIo0FSl1/u67w+1KpzawU1ZEXH2IazTJoZkClE39YqNbZjL6xokoc0kRN9gWarD08PpuJhG8N+WPUj6s/Gp8DOzRKqzBUqZCsKQOiTLDPGwtD9eU8BS89PW7j93gtW+XjIVUyvVPZgpKW+a7Sv6CtV0xBnLUJlLXcDCevSsS64htmTDyjwLkokV808b55VmMHkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2tFizmqcBwHFatJCUUhX0MA6xl4T19ODV8hG1IeYqI=;
 b=yy2wgshhhoeN+XsTkAX8OhZL11b/yzl8otqe9N7gtfHGK/P6kjbJfeDirIboAjm/J/AosO+w9ZvOqnvzUV7cm7lMrIbvcLQb08vh4yTEK0Y72f0TwjxmUI+0gcmchjrMPCd/rXJBXDQvHNZpfu7BsXbTxVkhMEsuH0cAni12UzH64h9hH1WODp4S5I2iB9497uApaBY3x6W5peXG5DtItyNGfyPVMUuBvrWwkljIBF5l1yDiBMkL1Nv3usew0lkzxtMBNRp7sbNVrmCsp/kXJn5K8LDTjl0N+Qz7X7WDypxP1zCc4C6I2rloCb69w2+YYI43jgOehKyiSMSY8hRNVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6621.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 14:46:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 14:46:16 +0000
Message-ID: <154d13e3-f80c-46a3-8682-ab894c3d8f90@siemens.com>
Date: Fri, 8 Nov 2024 15:46:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gdb: lx-symbols: do not error out on monolithic build
To: Kieran Bingham <kbingham@kernel.org>,
 Etienne Buira <etienne.buira@free.fr>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrew Ballance <andrewjballance@gmail.com>, linux-kernel@vger.kernel.org
References: <Zy4UfR0-KR6YroN2@Z926fQmE5jqhFMgp6>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <Zy4UfR0-KR6YroN2@Z926fQmE5jqhFMgp6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 12639a85-3892-4a39-676e-08dd00041963
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eG9xQWp4VkJSWkJUWGZ1VURFVXNFYnVsWkorZktFNDJKQ2V6cWI2NmZlQUpi?=
 =?utf-8?B?SnB6MDhGaFluQWJGUjVvc00yU0xkOUZLQkt5VG91M0dLdER6OTl3WnZ2bFE4?=
 =?utf-8?B?TDEwcEFUZ3BQQzBPaUxqbld1Zk1lb25ISEdSaDR2ZzNBSVo2MVphNThjcGVZ?=
 =?utf-8?B?MnJRMTE2TW9wakt3aUxLTFpHbDdUMDJSalpjUUZhSUI4TzZzUFlJM0NKK3JY?=
 =?utf-8?B?K1V6L3FxTmFjWERmVlF3MWszeVFCUy80OEtrRklJQ2wrYU0yUENQMHN5bXlu?=
 =?utf-8?B?UHRLOHRScUVTNEFXZERWTm1pVC9QN0tRWndqOGhzMGt0SWRTZkdySFo4TkJy?=
 =?utf-8?B?QXM2c0NDZDM0RHlxNFV6UGZidDlhU2VHbDd3OEtzQWcyZ2tiUGxPMENQM0VZ?=
 =?utf-8?B?cFdvWmpqNHNUQkJKZElkaDd1S01zcU1DSGx3ZklpZENBMFByV0xSU3Bta0tU?=
 =?utf-8?B?M3JtdU9KYlRFRXBxRkN0dmJ2TWpiWFdnb0h4UmsrM0xIdDlZMVFBS0dmTkZl?=
 =?utf-8?B?VDdOMU41aWorU1MzYllTa2l2cTAyTlVkVVFyYlloRmRLRnU0eVA4TDFYeHNu?=
 =?utf-8?B?b2x3cDhFQ3U2OXVoLzRhL2lWT0lvOU5MbEorak5RVGJ2bHQ2Tm0xNnNpM2hh?=
 =?utf-8?B?T1dUZ0RnTGw5cnBEUlozVVRmRUZQaVdGdXp6Y09iczdTVGZ1dkl1bjAwZ3k4?=
 =?utf-8?B?MDIxRVRQTkJtTm85cVBRL0ttSzl5clIvQXQ0cUhGOTZZeTBxMzNzSnhZS1Bp?=
 =?utf-8?B?cmphU2M3ZXpPZit5ZXNOTFk4RWQrOWRjdElEYW0yZlY4RERPSDFmRm5Hdzdv?=
 =?utf-8?B?MklobDk2Vk1PdHFXWk1nMk9rU25vb1ZYMEZTNzIvcGZKWStVdDZKQ3JiblNI?=
 =?utf-8?B?dUhJSVB5L1BsUDhnVzBsTEdUZWVtb0kzMnhVbFVzQS9BeHBZcUREYjBpUm5Z?=
 =?utf-8?B?ZVd6U1A0U0NhQ2V2U1ZoY25FK0xyMCtPMUUrdDc3THFqbm1OWGh5OGRuSXBG?=
 =?utf-8?B?U0RZYWx5MlJpYisyVGV4YmVhbkdGb1RwQUliRWNkSnpBelNEMm9JOUFUYjVR?=
 =?utf-8?B?N0kzbmFCVkhjaUx5Yk9UcEdUOGNCUTR3Y2VWMU0vQ0d3RWVIR0RmQjBaajJC?=
 =?utf-8?B?QVRvRjdJTG5aNFlSSnQ2ekkvNUI3ODFOTDg2S0R6c3duK3JOVmYwVFl5QnlR?=
 =?utf-8?B?MXY4YWl0dTBkeGdOVHppaHZVZmRGNVZKMm9hUVRSaWh5YUZ0dElLVDJSSStI?=
 =?utf-8?B?QzE5S28yNjJHMzF2dDJVSWlWbFMyTm9sNFNrOXVPK1hhRUJwR29jb1J6cllT?=
 =?utf-8?B?d3J5OHF5R01yQ0lteXNZVENYelg2UUVDWTd4ZVA1SGo4eVMxNXBhN0JTMjdK?=
 =?utf-8?B?blg4V1NRc2N5YjlYbUZUL0pjblhiNlVvSGdEcTdjcWwvSzh4eCtlTUR0aDBM?=
 =?utf-8?B?TG9QM0wyVFM4ZGt6RlpVNFlRWHpQbm1UcVAxLy9jRGIxd0JYQlJ5c3c1Y1NO?=
 =?utf-8?B?Tldnd2VvdzFXS1dUbkZCR1ZlMmU1MjZRYStKSzAwSFRzS3dxdWVjYklRaWM1?=
 =?utf-8?B?SGZkUzRrUy95dElqNExNMFhIZFZva2pmbEVya1BDVlFnMUZmOVYrQmtjQUUz?=
 =?utf-8?B?b2dxaUlKYjJtMGw1dUt4dytPSkM2RzlGRVR5dXRWRzcrYWhLSXlOdnV2cFl0?=
 =?utf-8?B?Q0tkdDJHUXFjOHQ2VXNabFJ1Mlh4Zm8wQnpVVExDWWNTVGtVaEtqcUxJRk5M?=
 =?utf-8?B?ek1rcCtaNTlqZExkQXdsQ1k5UDA5ZVU4Z2F4VXJsRDcybnNyUjRUZWxWV3NY?=
 =?utf-8?B?OFA5NmxvUXR1Ym1hMTFmaFNjWk5mMWpXL09zYmNPSTFwV0NvS3pjYWNjOEZT?=
 =?utf-8?B?TjVmdDc3UktxY2RIbE12SmROOHM3d1JrV2VQTVMxQ3lxWnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(41080700001)(15866825006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ull4dWhVbXBTTFg4b2F4aDVSNVBpcmtKei8yRENmWnduN3N1S0FyZ1VzU0ZL?=
 =?utf-8?B?TUdubFE5b2NNMmI3OU4vVlRUNVg2ZElQaHZtUTZNbmtKZnBKRlAva3R0Nm1h?=
 =?utf-8?B?UDZaaDhpYnMxRUMrTDFscTZ3YmJocjVyWGtxOXZWUndQeDNJZVc5eTRFSzU1?=
 =?utf-8?B?UmJGMmQxRXlOOFE1UUsxOWU5L3UrdXp2L1NuUEh0ajBOUlFmYTRrdzEzSEtJ?=
 =?utf-8?B?NzVNNTdMVlZaNExuU3llTk0vQzgyeC9ld0QySUc0MmFVZnZFSUh5MnFRZTJB?=
 =?utf-8?B?UmpXUWoxWEpmMW1lRFBzaFZhdjBUUVdWVWlxcHY0ZnhWeTBTYnA1SUZvRFFX?=
 =?utf-8?B?UU5tQTZWREhEdGQ2VjNjNlROZkFQQWJZckF1UVJSVkpHV0VxaGR0L1pOUmVN?=
 =?utf-8?B?bGlCN0NPalNRYUhZaDlmMU5YdjdMdjM0QzNHRFhuenR0bGMwL2ZlVndHY3RG?=
 =?utf-8?B?c2hVeEovcjZSUUo0eXkwNlg2ZjFOVkx0Wm1KRmpFZmlNQjNFcDV2Y2FtNlRt?=
 =?utf-8?B?eVRRZGdEWmh1Ky9nZk55NkIvNDlJbDFiaG5XNFRNZkR0RFFPMmlZZENNSHk3?=
 =?utf-8?B?ODA5eUZoNXRkMmpseWRPZWw5eTdJUFlic255M2pSdmVWKzlQeW5SZm82dTJs?=
 =?utf-8?B?ZzcrT1I3SXY4Mk1UOGlVQm9QMWc1ZUQzTTA3WFZwa2srQ2xtRk5MRS9wdXdF?=
 =?utf-8?B?WnJvYTdsUW02SFJ6VFRCYlJwZSsvbm9veEhkamM4Wk50K0xiRm9Pakg3cnA3?=
 =?utf-8?B?YzQzOFB1TVRoVW15ZkZPOFJUU0x3czEyUEQ1TWZVSmxFMldCeTVNM3hrelRx?=
 =?utf-8?B?SmY5WWZBemhIbXZiQzhSUFFYQzJGSGw5MlNxQkhBWE1MME9wU1h1NnZzTEhn?=
 =?utf-8?B?NG9LakNkZFcvVm9XWmw5d3FkTHY2WURyUk13dG5xNjVBZXNYRDFtSUNxYzFY?=
 =?utf-8?B?UGRVb2xrV1RMUE4zRDF6QzQ4T0FUeGlXWURGWmJhNW4yOFRXaFQyZGxCNTVl?=
 =?utf-8?B?ZFVBM2RiSmVkYTBnemxzVWgwSXJpWmlwSHFETXcreFEwdGNML3VWTVVFdGtU?=
 =?utf-8?B?TUVaSFNUbUhrUEQvNTJuSzRFam9IQy9YUTROOEYwblpsSWxDL2ViZHROY3Ry?=
 =?utf-8?B?azVFeEE4d05aUnhtdXF1WWlhZUhpUlk3WUtVOHJ6cmJZcTg4N0hkMWdlSGht?=
 =?utf-8?B?czh4V0w3bjNCb25IdWlTTnpKQXNPTjd1NGtPdGZzb290WGJxWHJkN1hkQUZF?=
 =?utf-8?B?RXFyd0FqN3ByVzQyRmxDcXVyUTZxZGcxOHF1Q1pDWGJZejRuZUo3clFaQTVw?=
 =?utf-8?B?bGZBVjFGclM1OFMvbFhRYU9nVFNFeE0zblVBZDdERDh5TXQ4bnhaRFlRQnJw?=
 =?utf-8?B?ZFN4U3JrM1JFdEhhMTRQYWMzaExmK2txOEJQdW11MjN6eSt2RmdReUcrK0Ny?=
 =?utf-8?B?REFaenpTQU1zaGpXY3V0U1dhQ1p5dlhuM2xPM0xvNHJPSEJvcjFlQzZoVXFI?=
 =?utf-8?B?VXVNMm1UQW9OdERTcXZ4SjIvSWtGOElTTXBHbFYzc3NFdDBrbXZxaU04MzhG?=
 =?utf-8?B?ZkZpQmliY3ZoZWhqay8vZlpldlBWSFBTRDZEVnRyWUFUcmNwWUs0ZVRoZzhO?=
 =?utf-8?B?cUsxd1FGTXM4WDNpUUVzNnpHWVhmQmNVNGdpcVBBbUdMOWxtVVdsUWtFT1RU?=
 =?utf-8?B?Qm5zOEEvMWhKSmRQdUlWa3pVaW1ZbDFwRURIUEVxdExnc3hWclZiZjZuU0dC?=
 =?utf-8?B?MWUyMWFZd01LNjBkdWtySm8wVjRjQWdtY2YwWE1QOURNbU9FdTlPYTdiRjk0?=
 =?utf-8?B?emtGWGJZaXgwV3o5bjVDbjQ0SG1PcCtDcGduR2JVeE5GV2h5ZWc1UFhwWHJR?=
 =?utf-8?B?VlY5clZvMnM3djhhTGl6dEZEMFZheEkySDhSNXJDRWFqcHEyUkNPcjdiR0lt?=
 =?utf-8?B?YW5IRU5IeGRJdVdBUEtPYVhzbjQ0R3gya2RoYjkyZEp0Q0RSM1VSRFNseS9T?=
 =?utf-8?B?YUVRSEZtMVI5TmczVWkxMFBYSG0xbjJMcWxuSGNTM1pXOW5ySUx1Mmd4eDA1?=
 =?utf-8?B?SWFsRXRXNVkxMVE0UjRwaE9wZzRrd25iUWtTdXIxeTFaY1plcFAzNzdVaVhB?=
 =?utf-8?B?MFhWb2dYSkVHUnd4SmFHbkFNVkZMZDU3NnBNRktNNTJCY2kvMGdkdGNVVHlj?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12639a85-3892-4a39-676e-08dd00041963
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 14:46:16.3344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ac5vUej+/1DkZiKwgziJj1xL7c4lL9lnVxHG8V/4pkTp5yBtFbcCsLnZOq2Xwe1i/D/VOTs8RPWRa8OL4CEqPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6621

On 08.11.24 14:39, Etienne Buira wrote:
> This avoids spurious message:
> (gdb) lx-symbols
> loading vmlinux
> No source file named kernel/module/main.c.
> 
> Signed-off-by: Etienne Buira <etienne.buira@free.fr>
> ---
>  scripts/gdb/linux/modules.py | 3 +++
>  scripts/gdb/linux/symbols.py | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/gdb/linux/modules.py b/scripts/gdb/linux/modules.py
> index 298dfcc25eae..fa15f872ddbe 100644
> --- a/scripts/gdb/linux/modules.py
> +++ b/scripts/gdb/linux/modules.py
> @@ -19,6 +19,9 @@ from linux import cpus, utils, lists, constants
>  module_type = utils.CachedType("struct module")
>  
>  
> +def has_modules():
> +    return utils.gdb_eval_or_none("modules") is not None
> +
>  def module_list():
>      global module_type
>      modules = utils.gdb_eval_or_none("modules")
> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> index e8316beb17a7..fb0f55d81686 100644
> --- a/scripts/gdb/linux/symbols.py
> +++ b/scripts/gdb/linux/symbols.py
> @@ -178,13 +178,13 @@ lx-symbols command."""
>  
>          self.load_all_symbols()
>  

if not modules.has_modules():
   return

> -        if hasattr(gdb, 'Breakpoint'):
> +        if hasattr(gdb, 'Breakpoint') and modules.has_modules():
>              if self.breakpoint is not None:
>                  self.breakpoint.delete()
>                  self.breakpoint = None
>              self.breakpoint = LoadModuleBreakpoint(
>                  "kernel/module/main.c:do_init_module", self)
> -        else:
> +        elif modules.has_modules():
>              gdb.write("Note: symbol update on module loading not supported "
>                        "with this gdb version\n")
>  

Looks good otherwise.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

